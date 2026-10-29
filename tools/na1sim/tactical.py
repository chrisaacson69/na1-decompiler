"""
tactical.py -- the on-screen tactical battle (bank 2), transcribed line-for-line
from source/4-c/bank_02.c against the flat memory model, validated bit-exact
against the na1dream bytecode (oracle_vm.combat_tactical_check).

WHY THIS EXISTS
---------------
Every battle so far routed through the OFF-SCREEN stat resolver
(resolve_siege_assault_outcome $8DFD): one strength comparison, only Drive among
the daimyo stats, no grid. That is the formula the ROM uses when an AI-vs-AI war
is NOT watched. But when the PLAYER fights (or watches), bank 2 runs a full
tactical battle -- an 11x5 grid, up to 5 unit slots/side, a 30-day rice clock,
and a DIFFERENT, richer strength formula pulling in all eight daimyo+fief stats,
unit rank, terrain (defensive + asymmetric), home-ground doubling, and per-turn
momentum. This module is that engine.

GROUNDING (the oracle, not the prose)
-------------------------------------
The decompiled C is the source of truth; na1dream's bytecode is the oracle;
chapter 17 (17-damage-formula.md) is a hint to sanity-check, no more. Where the
C and the chapter disagree, the C wins and the chapter gets corrected
(e.g. the supply clock drains men_total/30, not rice/30 as ch.17 says).

The combat math bottoms out on the SAME bank-15 primitives the develop family
uses -- pct_op ($D70D), math32_2arg ($D6DE), min_word -- so this is Python over
those leaves (vmprims.py), not a second VM.

CONVENTIONS
-----------
- side 0 = attacker (province = selected_province_idx), side 1 = defender
  (province = battle_defending_province). cur_combat_side / cur_combat_unit_slot
  ($7BE8 / $7BE4) are the ambient cursors the resolvers key off, exactly like
  selected_province_idx for the develop family.
- a "unit" is a (side, slot) pair; its men live at unit_strength_ptr, its map
  cell at unit_col_ptr / unit_row_ptr (200 = off-map sentinel).
- read_map_cell reads STATIC terrain from bank-4 ROM (the .nes), the same bytes
  na1dream reads -- so terrain is faithful by construction. Unit occupancy is
  tracked in the position arrays, never in the map grid.
"""

from pathlib import Path

from . import memmap as M
from . import vmprims as P
from .vmprims import pct_op, math32_2arg, min_word


# ===========================================================================
# read_map_cell -- static terrain from bank-4 ROM ($A57E pool)
# ===========================================================================
_ROM_MAP_POOL = None      # bytes of bank-4 starting at the $A57E cell pool


def _load_map_pool():
    """Lazily slice the tactical_map_cell_pool out of the .nes (bank 4 @ $A57E).
    iNES: 16-byte header, then 16x 16KB PRG banks; bank n at file off 16+n*0x4000;
    $A57E in a bank window ($8000-$BFFF) is bank-offset $257E."""
    global _ROM_MAP_POOL
    if _ROM_MAP_POOL is not None:
        return _ROM_MAP_POOL
    repo = Path(__file__).resolve().parent.parent.parent
    rom = (repo / "Nobunaga's Ambition (USA).nes").read_bytes()
    base = 16 + 4 * 0x4000 + (M.MAP_CELL_POOL - 0x8000)        # 0x1258E
    _ROM_MAP_POOL = rom[base:base + 64 * 55]                    # plenty for any mapid
    return _ROM_MAP_POOL


def fief_to_mapid(m: "M.Memory", province: int) -> int:
    """fief_to_mapid $DC66: 50-fief -> province directly; 17-fief -> the table."""
    if province > 50:
        return province
    if m.r16(M.SCENARIO_FIEF_COUNT) == 50:
        return province
    return M.PROVINCE_TO_MAPID_17[province]


def read_map_cell(m: "M.Memory", col: int, row: int) -> int:
    """read_map_cell $DC88: the terrain byte at (col,row) of the DEFENDING fief's
    tactical map -- pool[fief_to_mapid(defending)*55 + row*11 + col]. Static
    bank-4 ROM; identical bytes to na1dream's banked read."""
    pool = _load_map_pool()
    idx = fief_to_mapid(m, m.defending) * 55 + row * 11 + col
    return pool[idx] if 0 <= idx < len(pool) else 0


_STRAT_X = None           # strategic_map_fief_x $B0BA (bank 2 ROM, 50 bytes)
_STRAT_Y = None           # strategic_map_fief_y $B0EC


def _strat_xy(mapid):
    """strategic_map_fief_x/_y[mapid] -- per-fief strategic-map coords (bank-2 ROM)."""
    global _STRAT_X, _STRAT_Y
    if _STRAT_X is None:
        repo = Path(__file__).resolve().parent.parent.parent
        rom = (repo / "Nobunaga's Ambition (USA).nes").read_bytes()
        bx = 16 + 2 * 0x4000 + (0xB0BA - 0x8000)
        _STRAT_X = rom[bx:bx + 50]
        _STRAT_Y = rom[bx + (0xB0EC - 0xB0BA):bx + (0xB0EC - 0xB0BA) + 50]
    return _STRAT_X[mapid], _STRAT_Y[mapid]


def is_cell_clear_of_bits(m, col, row, bits) -> int:
    """is_cell_clear_of_bits $82DB: off-grid -> clear(1); else (cell & bits)?0:1."""
    if col > 10 or row > 4:
        return 1
    return 0 if (read_map_cell(m, col, row) & bits) else 1


# ===========================================================================
# Strength evaluation core (deterministic -- no RNG)
# ===========================================================================
def ai_sum_battle_strength(m: "M.Memory") -> None:
    """ai_sum_battle_strength $8E5C: build the per-side 8-stat weight sums into
    battle_side_strength_mod[0..1] ($7BEA/$7BEC). For each stat, the side that
    does NOT lose it gets its weight: index = (attacker_stat <= defender_stat)
    ? 1(defender) : 0(attacker). Stats: daimyo H,D,L,Ch,IQ (record +1..+5) then
    fief Morale,Skill,Arms (+18,+20,+22); weights BATTLE_STRENGTH_STAT_WEIGHTS."""
    m.w16(M.BATTLE_SIDE_STR_MOD + 2, 0)        # mem_7BEC = 0
    m.w16(M.BATTLE_SIDE_STR_MOD, 0)            # battle_side_strength_mod = 0
    weights = M.BATTLE_STRENGTH_STAT_WEIGHTS
    atk_daimyo = m.fief_daimyo(m.selected)
    def_daimyo = m.fief_daimyo(m.defending)
    # 5 daimyo stat bytes: record +1..+5 (Health,Drive,Luck,Charisma,IQ)
    for i in range(5):
        a = m.r8(atk_daimyo + 1 + i)
        d = m.r8(def_daimyo + 1 + i)
        idx = 1 if a <= d else 0
        addr = M.BATTLE_SIDE_STR_MOD + (idx << 1)
        m.w16(addr, m.r16(addr) + weights[i])
    # 3 fief stat words: +18 morale, +20 skill, +22 arms
    atk_fief = m.fief(m.selected)
    def_fief = m.fief(m.defending)
    for j, off in enumerate((M.F_MORALE, M.F_SKILL, M.F_ARMS)):
        a = m.r16(atk_fief + off)
        d = m.r16(def_fief + off)
        idx = 1 if a <= d else 0
        addr = M.BATTLE_SIDE_STR_MOD + (idx << 1)
        m.w16(addr, m.r16(addr) + weights[5 + j])


def ai_score_strength_term_40pct(m: "M.Memory", strength_base: int, side_idx: int) -> int:
    """ai_score_strength_term_40pct $8E5B: the 8-stat term --
        pct_op(pct_op(base, 40), W[side]) + base
    where W[side] = battle_side_strength_mod[side] ($7BEA + side*2). At W=100
    this is base*(1 + 0.4) = +40%. RE-ADDS one base (so base appears twice in S)."""
    W = m.r16(M.BATTLE_SIDE_STR_MOD + (side_idx << 1))
    return pct_op(pct_op(strength_base, 40), W) + strength_base


def ai_terrain_strength_term(m: "M.Memory", side: int, unit_slot: int) -> int:
    """ai_terrain_strength_term $9BB4: the DEFENSIVE, asymmetric terrain bonus on
    the unit's own cell -- pct_op(men, terrain_mult[class]) * 3. class by
    (cell & 254): 32->castle(0), 16->forest(1), 8->town(2), else clear(3)."""
    col = m.r8(m.unit_col_ptr(side, unit_slot))
    row = m.r8(m.unit_row_ptr(side, unit_slot))
    terrain_class_idx = 3
    feature = read_map_cell(m, col, row) & 254
    if feature == 32:
        terrain_class_idx = 0
    elif feature == 16:
        terrain_class_idx = 1
    elif feature == 8:
        terrain_class_idx = 2
    men = m.r16(m.unit_strength_ptr(side, unit_slot))
    return pct_op(men, M.TERRAIN_STRENGTH_MULT_TABLE[terrain_class_idx]) * 3


def ai_province_stat_diff_term(m: "M.Memory", side: int, unit_field: int) -> int:
    """ai_province_stat_diff_term $9C04: for each of fief Morale/Skill/Arms
    (+18,+20,+22) where THIS side's fief beats the OTHER side's, add
    pct_op(men, diff/100). Sum * 3."""
    fief = m.fief(m.get_battle_side_province(side)) + M.F_MORALE
    ref_fief = m.fief(m.get_battle_side_province(0 if side else 1)) + M.F_MORALE
    men = m.r16(m.unit_strength_ptr(side, unit_field))
    total = 0
    for i in range(3):
        stat_diff = (m.r16(fief + i * 2) - m.r16(ref_fief + i * 2))
        if stat_diff > 0:
            total += pct_op(men, stat_diff // 100)
    return total * 3


def ai_strength_term_gated_table_word(m: "M.Memory", unit: int, idx: int, gate_idx: int) -> int:
    """ai_strength_term_gated_table_word $9C69: the unit-RANK term. If this slot
    out-ranks the enemy slot (wrap_0_2(idx) > wrap_0_2(gate_idx)) add its men,
    else 0. wrap: slot>2 -> 0, so ranks cycle Rifles>Cavalry>Infantry."""
    if P_wrap(idx) > P_wrap(gate_idx):
        return m.r16(m.unit_strength_ptr(unit, idx))
    return 0


def P_wrap(arg1: int) -> int:
    """wrap_index_0_2_to_zero $900F: arg>2 -> 0."""
    return 0 if arg1 > 2 else arg1


def ai_eval_battle_strength_total(m: "M.Memory", side: int, unit_slot: int,
                                  other_unit_slot: int) -> int:
    """ai_eval_battle_strength_total $9C88: a unit's full effective strength S.
        ai_sum_battle_strength()                          # refresh W[]
        base = men[side][unit_slot]
        S0 = (home? base : 0)                             # bit7 home-ground double
           + terrain_term                                 # own-cell terrain (def)
           + province_stat_diff_term                      # fief morale/skill/arms edge
           + rank_term(unit_slot vs other_unit_slot)      # +men if higher rank
           + (base + pct_op(pct_op(base,40), W[side]))    # 8-stat term (re-adds base)
           + pct_op(base, $7BEE[other_unit_slot] * 20)    # +20%/prior-exchange momentum
        scale = AI-home(state0) ? 100 : (115 - const_two*15)
        return pct_op(base + S0, scale)"""
    ai_sum_battle_strength(m)
    base = m.r16(m.unit_strength_ptr(side, unit_slot))
    momentum_n = m.r8(M.UNIT_EXCHANGE_COUNT + other_unit_slot)
    s0 = ((base if m.test_6f65_bit7(side) else 0)
          + ai_terrain_strength_term(m, side, unit_slot)
          + ai_province_stat_diff_term(m, side, unit_slot)
          + ai_strength_term_gated_table_word(m, side, unit_slot, other_unit_slot)
          + ai_score_strength_term_40pct(m, base, side)
          + pct_op(base, momentum_n * 20))
    if m.province_ai_state(m.get_battle_side_province(side)):
        scale = 115 - (m.skill * 15)
    else:
        scale = 100
    return pct_op(base + s0, scale)


def calc_battle_strength_pct_one_side(m: "M.Memory", unit_type: int) -> int:
    """calc_battle_strength_pct_one_side $9D75: the attacker's strength share p in
    0..100 -- math32_2arg(S(cur side, cur slot, vs unit_type),
                          S(cur side^1, unit_type, vs cur slot))."""
    s_self = ai_eval_battle_strength_total(m, m.cur_combat_side, m.cur_combat_unit_slot, unit_type)
    s_enemy = ai_eval_battle_strength_total(m, m.cur_combat_side ^ 1, unit_type, m.cur_combat_unit_slot)
    return math32_2arg(s_self, s_enemy)


# ===========================================================================
# Casualty resolution
# ===========================================================================
UNIT_PRESENCE_CLEAR_MASKS = (0xFE, 0xFD, 0xFB, 0xF7, 0xEF)   # ~(1<<slot), $B5B9
OFF_MAP = 200             # -56 & 0xFF; the off-map sentinel for row/col


def remove_unit(m: "M.Memory", side: int, slot: int) -> None:
    """remove_unit $8F97: clear the side's presence bit for `slot`; off-map the
    unit (row/col = 200)."""
    a = M.WAR_SIDE_STATE_FLAG + side
    m.w8(a, m.r8(a) & UNIT_PRESENCE_CLEAR_MASKS[slot])
    m.w8(m.unit_row_ptr(side, slot), OFF_MAP)
    m.w8(m.unit_col_ptr(side, slot), OFF_MAP)


def apply_pct_reduction_to_unit_strength(m: "M.Memory", side: int, slot: int, pct: int) -> int:
    """apply_pct_reduction_to_unit_strength $9D03: kill `pct`% of a unit's men
    (+1 if pct>=50, the >=50 rounding), capped at the unit's men. Decrements both
    the unit's men and the side's army-total (side_resource +4). Removes the unit
    at 0. Returns the casualty count."""
    ptr = m.unit_strength_ptr(side, slot)
    men = m.r16(ptr)
    loss = pct_op(men, pct) + (1 if pct >= 50 else 0)
    if loss > men:
        loss = men
    sr_men = m.side_resource_ptr(side) + M.SR_MEN
    m.w16(sr_men, m.r16(sr_men) - loss)        # draw_side_resource_field: UI no-op
    m.w16(ptr, men - loss)
    if m.s16(ptr) <= 0:
        remove_unit(m, side, slot)             # draw_terrain_feature_if_valid: UI no-op
    # else draw_unit_count_digits: UI no-op
    return loss


def _word_sub_saturating(m: "M.Memory", ptr: int, val: int) -> None:
    """word_sub_saturating: *ptr = max(0, *ptr - val)."""
    m.w16(ptr, max(0, m.r16(ptr) - val))


def reduce_defending_province_town_chaos(m: "M.Memory", casualties: int, enemy_slot: int) -> int:
    """reduce_defending_province_town_chaos $9DA8: if EITHER combatant stands on a
    town cell (bit 8), crater the DEFENDING fief's town -- "the town is in
    complete chaos". Otherwise a no-op. (UI message/redraw dropped.)"""
    other = m.cur_combat_side ^ 1
    cur_col = m.r8(m.unit_col_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    cur_row = m.r8(m.unit_row_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    enemy_col = m.r8(m.unit_col_ptr(other, enemy_slot))
    enemy_row = m.r8(m.unit_row_ptr(other, enemy_slot))
    a_clear = is_cell_clear_of_bits(m, cur_col, cur_row, 8)
    b_clear = is_cell_clear_of_bits(m, enemy_col, enemy_row, 8)
    if a_clear and b_clear:
        return b_clear                          # both clear -> no chaos
    half = casualties // 2
    town_ptr = m.fief(m.defending) + M.F_TOWN
    town = m.r16(town_ptr)
    if town <= half:
        m.w16(town_ptr, 0)
    else:
        _word_sub_saturating(m, town_ptr, pct_op(town, math32_2arg(half, town - half)) * 10)
    return 0


def resolve_attack_apply_mutual_casualties(m: "M.Memory", enemy_slot: int) -> int:
    """resolve_attack_apply_mutual_casualties $9E20: ONE melee exchange (the
    player's Attack verb). Bumps the enemy slot's momentum, computes p (the
    attacker's strength share), then BOTH bleed: cur unit loses (100-p)%, enemy
    loses p%. No RNG. Returns 0 if p==50 (even), 1 if attacker ahead, 2 if behind."""
    # validate_phase_unit_cells_draw_cursor: UI no-op
    a = M.UNIT_EXCHANGE_COUNT + enemy_slot
    m.w8(a, (m.r8(a) + 1) & 0xFF)
    p = calc_battle_strength_pct_one_side(m, enemy_slot)
    own = apply_pct_reduction_to_unit_strength(m, m.cur_combat_side, m.cur_combat_unit_slot, 100 - p)
    foe = apply_pct_reduction_to_unit_strength(m, m.cur_combat_side ^ 1, enemy_slot, p)
    reduce_defending_province_town_chaos(m, own + foe, enemy_slot)
    if p == 50:
        return 0
    return 1 if p > 50 else 2


def resolve_attack_apply_casualties(m: "M.Memory", enemy_slot: int, gold: int) -> None:
    """resolve_attack_apply_casualties $9E73: the DEFECTION verb (player Bribe +
    the AI's own attack). Pay `gold` (always); if the cur side wins a
    morale+Charisma contest AND paid >=1 gold/enemy-man, a fraction of the enemy
    unit DEFECTS into the cur side's commander (slot 0). Else, if underpaid, the
    enemy fief's morale drops instead. RNG: rng_mod(6-const_two), once.

        att = rng(6-const_two) + own_fief.morale + own_daimyo.Charisma
        def = enemy_fief.morale + enemy_daimyo.Charisma + 2*const_two
        win = !skip_flag && att > def
        defectors = pct_op(enemy_men, math32_2arg(att-def, att))   (capped to 9999 total)
    """
    cur = m.cur_combat_side
    other = cur ^ 1
    # pay the gold (own side's gold = side_resource +0)
    own_gold = m.side_resource_ptr(cur) + M.SR_GOLD
    m.w16(own_gold, m.r16(own_gold) - gold)        # draw_side_resource_field: UI no-op
    own_prov = m.get_battle_side_province(cur)
    enemy_prov = m.get_battle_side_province(other)
    att = (m.rng_mod(6 - m.skill)
           + m.r16(m.fief(own_prov) + M.F_MORALE)
           + m.r8(m.fief_daimyo(own_prov) + M.D_CHARISMA))
    deff = (m.r16(m.fief(enemy_prov) + M.F_MORALE)
            + m.r8(m.fief_daimyo(enemy_prov) + M.D_CHARISMA)
            + (m.skill << 1))
    if m.r8(M.COMBAT_CASUALTY_SKIP) or att <= deff:
        return                                      # contest lost / already resolved this turn
    enemy_men_ptr = m.unit_strength_ptr(other, enemy_slot)
    enemy_men = m.r16(enemy_men_ptr)
    gold_per_man = gold // enemy_men if enemy_men else 0
    if gold_per_man > 0:
        defectors = pct_op(enemy_men, math32_2arg(att - deff, att))
        own_army = m.side_resource_ptr(cur) + M.SR_MEN
        if m.r16(own_army) + defectors > 0x270F:
            defectors = 0x270F - m.r16(own_army)
        if defectors == 0:
            return
        # the enemy unit shrinks; the defectors join the cur side's commander (slot 0)
        m.w16(enemy_men_ptr, enemy_men - defectors)
        enemy_army = m.side_resource_ptr(other) + M.SR_MEN
        m.w16(enemy_army, m.r16(enemy_army) - defectors)
        cmd_ptr = m.unit_strength_ptr(cur, 0)
        m.w16(cmd_ptr, m.r16(cmd_ptr) + defectors)
        m.w16(own_army, m.r16(own_army) + defectors)
        m.w8(M.COMBAT_CASUALTY_SKIP, 1)
    else:
        # underpaid: drop the enemy fief's morale instead
        mor_ptr = m.fief(enemy_prov) + M.F_MORALE
        drop = (6 - m.skill) if m.province_ai_state(own_prov) else m.skill
        m.w16(mor_ptr, m.r16(mor_ptr) - drop)
        if m.s16(mor_ptr) <= 0:
            m.w16(mor_ptr, 0)
        m.w8(M.COMBAT_CASUALTY_SKIP, 1)


# ===========================================================================
# Battle setup: men distribution + defender init
# ===========================================================================
MEM_7FE1 = 0x7FE1         # battle-init sentinel (= 255; no game-relevant readers)


def clear_all_unit_positions(m: "M.Memory") -> None:
    """clear_all_unit_positions $929C: off-map every unit slot (row/col = 200)."""
    for side in range(2):
        for slot in range(5):
            m.w8(m.unit_row_ptr(side, slot), OFF_MAP)
            m.w8(m.unit_col_ptr(side, slot), OFF_MAP)


def distribute_men_into_unit_strengths(m: "M.Memory") -> None:
    """distribute_men_into_unit_strengths $91D5: split each side's army total
    (side_resource +4) across the 5 unit slots proportionally to that province's
    unit-type composition % (province_unit_type_pct $76A9 + prov*5) via pct_op.
    Sets all 5 presence bits, gives slot 0 a floor of 1, round-robins any leftover
    men over the nonzero-% slots, then remove_unit's every empty slot."""
    for side in range(2):
        total = m.r16(m.side_resource_ptr(side) + M.SR_MEN)
        dist = M.PROVINCE_UNIT_TYPE_PCT + m.get_battle_side_province(side) * 5
        fa = M.WAR_SIDE_STATE_FLAG + side
        m.w8(fa, m.r8(fa) | M.UNIT_PRESENCE_MASK_ALL)
        # slot 0 (floored to 1)
        s0 = pct_op(total, m.r8(dist))
        m.w16(m.unit_strength_ptr(side, 0), s0 if s0 > 0 else 1)
        accum = s0 if s0 > 0 else 1
        # slots 1..4
        for slot in range(1, 5):
            if total - accum > 0:
                v = pct_op(total, m.r8(dist + slot))
                m.w16(m.unit_strength_ptr(side, slot), v)
                accum += v
            else:
                m.w16(m.unit_strength_ptr(side, slot), 0)
        # spread the remainder round-robin over slots with nonzero %
        rem = total - accum
        slot = 0
        while rem > 0:
            slot %= 5
            if m.r8(dist + slot):
                p = m.unit_strength_ptr(side, slot)
                m.w16(p, m.r16(p) + 1)
            rem -= 1
            slot += 1
        # drop empty slots
        for slot in range(5):
            if m.r16(m.unit_strength_ptr(side, slot)) == 0:
                remove_unit(m, side, slot)


def battle_init_defender(m: "M.Memory") -> int:
    """battle_init_defender $92CA: snapshot the DEFENDING fief's gold/rice/men into
    war_defender_* (side 1 resource triple), zero-clamping each (rice-empty ->
    depleted 7, men-empty -> depleted 8). If not depleted: distribute men + clear
    positions + cur_combat_side = 1. Else the defender is already beaten (winner =
    the defending province). Returns the depleted flag."""
    m.w8(MEM_7FE1, 255)
    depleted = 0
    m.w8(M.BATTLE_DEFENDER_STATUS, (m.is_capital(m.defending) & 1) << 7)
    fd = m.fief(m.defending)
    sr = m.side_resource_ptr(1)
    # gold
    m.w16(sr + M.SR_GOLD, m.r16(fd + M.F_GOLD))
    if m.s16(fd + M.F_GOLD) <= 0:
        m.w16(fd + M.F_GOLD, 0); m.w16(sr + M.SR_GOLD, 0)
    # rice
    m.w16(sr + M.SR_RICE, m.r16(fd + M.F_RICE))
    if m.s16(fd + M.F_RICE) <= 0:
        m.w16(fd + M.F_RICE, 0); m.w16(sr + M.SR_RICE, 0); depleted = 7
    # men
    m.w16(sr + M.SR_MEN, m.r16(fd + M.F_MEN))
    if m.s16(fd + M.F_MEN) <= 0:
        m.w16(fd + M.F_MEN, 0); m.w16(sr + M.SR_MEN, 0); depleted = 8
    if not depleted:
        distribute_men_into_unit_strengths(m)
        clear_all_unit_positions(m)
        m.cur_combat_side = 1
    else:
        m.w16(M.BATTLE_WINNER_PROV, m.defending)
    return depleted


# ===========================================================================
# Grid geometry (the 11x5 tactical map; 4 cardinal neighbours)
# ===========================================================================
def is_tile_in_bounds(x: int, y: int) -> int:
    """is_tile_in_bounds $8F11: x<=10 && y<=4 (unsigned -> the off-map 200 fails)."""
    return 1 if (x <= 10 and y <= 4) else 0


def step_coord_by_direction(x: int, y: int, d: int):
    """sub_8003 (NATIVE $8003): the 6-direction grid step. The 11x5 board is SQUARE
    tiles, but each column is offset half a tile vertically -- so instead of 8
    neighbours (4 orthogonal + 4 diagonal) a cell reaches only 6: the two verticals
    plus, on each side, the two tiles its half-tile stagger lines it up with.
    Functionally a hex grid on square tiles. The diagonal moves (0,2,3,5) therefore
    shift the row only on the entered column's parity:
        0 = down-left   x-1; if new-x EVEN -> y+1
        1 = down        y+1
        2 = down-right  x+1; if new-x EVEN -> y+1
        3 = up-left     x-1; if new-x ODD  -> y-1
        4 = up          y-1
        5 = up-right    x+1; if new-x ODD  -> y-1
    Returns (moved, nx, ny); moved=0 (and coords unchanged for the caller) when the
    move would leave the board. (Was wrongly modelled as the 4-dir player-input
    step_coord_by_direction $84F7 -- that one is for the d-pad, not the AI.)"""
    if d == 0:
        if x == 0:
            return 0, x, y
        nx = x - 1
        if nx & 1:
            return 1, nx, y
        if y == 4:
            return 0, x, y
        return 1, nx, y + 1
    if d == 1:
        if y == 4:
            return 0, x, y
        return 1, x, y + 1
    if d == 2:
        if x == 10:
            return 0, x, y
        nx = x + 1
        if nx & 1:
            return 1, nx, y
        if y == 4:
            return 0, x, y
        return 1, nx, y + 1
    if d == 3:
        if x == 0:
            return 0, x, y
        nx = x - 1
        if (nx & 1) == 0:
            return 1, nx, y
        if y == 0:
            return 0, x, y
        return 1, nx, y - 1
    if d == 4:
        if y == 0:
            return 0, x, y
        return 1, x, y - 1
    if d == 5:
        if x == 10:
            return 0, x, y
        nx = x + 1
        if (nx & 1) == 0:
            return 1, nx, y
        if y == 0:
            return 0, x, y
        return 1, nx, y - 1
    return 0, x, y


def is_map_cell_blocked(m, x, y) -> int:
    """is_map_cell_blocked $9019: cell has any of bits 194 ($C2: river/sea/mountain)."""
    return 0 if is_cell_clear_of_bits(m, x, y, 194) else 1


def side_has_unit_at_cell(m, side, x, y) -> int:
    """side_has_unit_at_cell $8FC0: any of side's 5 slots standing on (x,y)."""
    for slot in range(5):
        if m.r8(m.unit_col_ptr(side, slot)) == x and m.r8(m.unit_row_ptr(side, slot)) == y:
            return 1
    return 0


def is_any_unit_at_tile(m, x, y) -> int:
    """is_any_unit_at_tile $8FEC: either side has a unit on (x,y)."""
    return 1 if (side_has_unit_at_cell(m, 0, x, y) or side_has_unit_at_cell(m, 1, x, y)) else 0


def is_unit_at_coords(m, x, y, side, slot) -> int:
    """is_unit_at_coords $A04E: unit (side,slot) present AND at (x,y)."""
    return 1 if (m.is_unit_present(side, slot)
                 and m.r8(m.unit_col_ptr(side, slot)) == x
                 and m.r8(m.unit_row_ptr(side, slot)) == y) else 0


def find_adjacent_unit_around_tile(m, x, y, side, slot) -> int:
    """find_adjacent_unit_around_tile $A07A: unit (side,slot) on any neighbour of (x,y)."""
    for d in range(6):
        moved, nx, ny = step_coord_by_direction(x, y, d)
        if moved and is_unit_at_coords(m, nx, ny, side, slot):
            return 1
    return 0


def is_enemy_unit_adjacent(m, slot) -> int:
    """is_enemy_unit_adjacent $A0AD: the enemy's `slot` is present and neighbours
    the current unit."""
    es = m.cur_combat_side ^ 1
    cc = m.r8(m.unit_col_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    cr = m.r8(m.unit_row_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    return 1 if (m.is_unit_present(es, slot) and find_adjacent_unit_around_tile(m, cc, cr, es, slot)) else 0


# ===========================================================================
# Target lists + strength selectors
# ===========================================================================
def build_reachable_enemy_target_list(m, ux, uy):
    """build_reachable_enemy_target_list $A0F3: for each of 6 directions from
    (ux,uy), the enemy slot occupying that adjacent cell, else 255. Returns a
    6-entry list (the C writes it to a scratch buffer and returns the pointer)."""
    out = [0xFF] * 6
    es = m.cur_combat_side ^ 1
    for d in range(6):
        moved, cx, cy = step_coord_by_direction(ux, uy, d)
        if moved:
            for slot in range(5):
                if is_unit_at_coords(m, cx, cy, es, slot):
                    out[d] = slot
                    break
    return out


def find_flagged_present_unit_type(m, lst) -> int:
    """find_flagged_present_unit_type $A148: the LAST list entry <5 whose momentum
    ($7BEE[entry]) is >0, else 255 (the AI prefers a unit it already traded with)."""
    res = 0xFF
    for v in lst:
        if v < 5 and m.r8(M.UNIT_EXCHANGE_COUNT + v) > 0:
            res = v
    return res


def find_strongest_unit_type_by_strength(m, lst, threshold) -> int:
    """find_strongest_unit_type_by_strength $A4BC: among list entries <5, the one
    with the highest p-share; 255 if the best < threshold."""
    best, best_type = 0, 0
    for v in lst:
        if v < 5:
            p = calc_battle_strength_pct_one_side(m, v)
            if p > best:
                best, best_type = p, v
    return 0xFF if best < threshold else best_type


def min_own_strength_pct_vs_list(m, lst) -> int:
    """min_own_strength_pct_vs_list $A4FC: the minimum p-share over list entries
    <5 (start 100)."""
    lo = 100
    for v in lst:
        if v < 5:
            p = calc_battle_strength_pct_one_side(m, v)
            if p < lo:
                lo = p
    return lo


def unit_type_count_gt3_and_equals_arg1(m, arg1) -> int:
    """unit_type_count_gt3_and_equals_arg1 $A01A: count cur-side present units;
    return 1 iff count>3 AND (count-1)==arg1 (the 'last of a full roster' test)."""
    n = sum(1 for slot in range(5) if m.is_unit_present(m.cur_combat_side, slot))
    return 1 if (n > 3 and (n - 1) == arg1) else 0


def eval_and_announce_battle_strength_parity_if_enemy_present(m, slot) -> int:
    """eval_and_announce_battle_strength_parity_if_enemy_present $A0DA: if the
    enemy `slot` is adjacent, resolve one melee exchange against it. The C returns
    announce_combat_side_daimyo_and_status(...) which, for an all-AI battle (both
    provinces AI, get_province_ai_state==0), collapses to a UI message_display ->
    0; battle-end is then decided by check_commander_alive_both_sides. So this
    returns 0 for the headless AI path (validated against na1dream)."""
    if is_enemy_unit_adjacent(m, slot):
        resolve_attack_apply_mutual_casualties(m, slot)
        return 0
    return 0


# ===========================================================================
# Placement / deployment
# ===========================================================================
def place_unit_at_tile_if_free(m, x, y) -> int:
    """place_unit_at_tile_if_free $9168: if (x,y) is in-bounds, unoccupied, and
    unblocked, move the CURRENT unit there. Returns 1 on move."""
    if is_tile_in_bounds(x, y) and not is_any_unit_at_tile(m, x, y) and not is_map_cell_blocked(m, x, y):
        m.w8(m.unit_col_ptr(m.cur_combat_side, m.cur_combat_unit_slot), x)
        m.w8(m.unit_row_ptr(m.cur_combat_side, m.cur_combat_unit_slot), y)
        return 1
    return 0


def find_free_tactical_placement_cell(m):
    """find_free_tactical_placement_cell $9647: scan columns 0..10 x rows 0..4 for
    the first cell holding a castle bit (32) -- the home seat. Returns (x,y) or
    None (the C returns via two out-pointers)."""
    for x in range(11):
        for y in range(5):
            if not is_cell_clear_of_bits(m, x, y, 32):
                return x, y
    return None


def set_combat_arena_rect_by_approach(m) -> int:
    """set_combat_arena_rect_by_approach $9675: default rect (0,0,10,4); for the
    ATTACKER (side 0, province selected) narrow it to the entry strip based on the
    compass bearing between the two fiefs' strategic-map coords. Returns the
    entry-edge code {1=N,2=S,3=W,4=E}, 0 on the no-op path (defender/no-province)."""
    m.w16(M.COMBAT_ARENA_Y_MIN, 0)
    m.w16(M.COMBAT_ARENA_X_MIN, 0)
    m.w16(M.COMBAT_ARENA_X_MAX, 10)
    m.w16(M.COMBAT_ARENA_Y_MAX, 4)
    edge = 0
    if not (m.selected == 50 or m.cur_combat_side):
        ax, ay = _strat_xy(fief_to_mapid(m, m.selected))
        dx_, dy_ = _strat_xy(fief_to_mapid(m, m.defending))
        if abs(ax - dx_) < abs(ay - dy_):      # vertical approach -> narrow Y
            if ay < dy_:                       # $96E0: atk_map_y < def_map_y
                m.w16(M.COMBAT_ARENA_Y_MAX, 2); edge = 1
            else:
                m.w16(M.COMBAT_ARENA_Y_MIN, 2); edge = 2
        else:                                  # horizontal approach -> narrow X
            if ax > dx_:                       # $96F5: atk_map_x > def_map_x
                m.w16(M.COMBAT_ARENA_X_MIN, 7); edge = 4
            else:
                m.w16(M.COMBAT_ARENA_X_MAX, 3); edge = 3
    return edge


def is_coord_in_combat_rect(m, x, y) -> int:
    """is_coord_in_combat_rect $970A: (x,y) inside the arena bounding rect."""
    return 0 if (x < m.r16(M.COMBAT_ARENA_X_MIN) or x > m.r16(M.COMBAT_ARENA_X_MAX)
                 or y < m.r16(M.COMBAT_ARENA_Y_MIN) or y > m.r16(M.COMBAT_ARENA_Y_MAX)) else 1


def tile_blocked_for_placement(m, x, y) -> int:
    """tile_blocked_for_placement $9735: attacker-only (side 0) placement guard --
    blocked if the cell isn't placeable (clear of 32 but has bit 8), or if (x,y)
    is one of the 6 neighbours of the home-seat cell."""
    if not m.cur_combat_side:
        if is_cell_clear_of_bits(m, x, y, 32):
            if not is_cell_clear_of_bits(m, x, y, 8):
                return 1
            seat = find_free_tactical_placement_cell(m)
            if seat is not None:
                sx, sy = seat
                for d in range(6):
                    moved, nx, ny = step_coord_by_direction(sx, sy, d)
                    if moved and nx == x and ny == y:
                        return 1
        else:
            return 1
    return 0


def commit_unit_dest_tile_if_valid(m, x, y) -> int:
    """commit_unit_dest_tile_if_valid $9792: if (x,y) is free, unblocked, not a
    bad placement tile, and inside the arena, move the current unit there."""
    if not (is_any_unit_at_tile(m, x, y) or is_map_cell_blocked(m, x, y)
            or tile_blocked_for_placement(m, x, y) or not is_coord_in_combat_rect(m, x, y)):
        m.w8(m.unit_col_ptr(m.cur_combat_side, m.cur_combat_unit_slot), x)
        m.w8(m.unit_row_ptr(m.cur_combat_side, m.cur_combat_unit_slot), y)
        return 1
    return 0


def commit_unit_move_and_redraw_count(m, x, y) -> int:
    """commit_unit_move_and_redraw_count $97D9: commit a placement and, on success,
    advance to the next unit slot."""
    if commit_unit_dest_tile_if_valid(m, x, y):
        m.cur_combat_unit_slot = m.cur_combat_unit_slot + 1
        return 1
    return 0


def is_cur_unit_absent(m) -> int:
    """is_cur_unit_absent $97F8: the current (side,slot) unit is not present."""
    return 0 if m.is_unit_present(m.cur_combat_side, m.cur_combat_unit_slot) else 1


def ai_place_unit_in_free_slot_resolve_coords(m, max_slots) -> int:
    """ai_place_unit_in_free_slot_resolve_coords $9810: step the commander (slot 0)
    outward in each direction, placing successive units around it (up to max_slots)."""
    for slot_idx in range(6):
        if not (m.cur_combat_unit_slot < max_slots):
            break
        if is_cur_unit_absent(m):
            m.cur_combat_unit_slot = m.cur_combat_unit_slot + 1
        else:
            tx = m.r8(m.unit_col_ptr(m.cur_combat_side, 0))
            ty = m.r8(m.unit_row_ptr(m.cur_combat_side, 0))
            moved, nx, ny = step_coord_by_direction(tx, ty, slot_idx)
            if moved:
                commit_unit_move_and_redraw_count(m, nx, ny)
    return 1 if m.cur_combat_unit_slot < max_slots else 0


def ai_advance_units_when_attacker_stronger(m) -> int:
    """ai_advance_units_when_attacker_stronger $9865: defender (side 1) deploy --
    place the commander on the home seat; if the attacker out-strengths, spread the
    rest outward from the seat, then nudge each into a free neighbour cell."""
    seat = find_free_tactical_placement_cell(m)
    if seat is not None:
        commit_unit_move_and_redraw_count(m, seat[0], seat[1])
    if ai_attacker_outstrengths_defender(m):
        ai_place_unit_in_free_slot_resolve_coords(m, 5)
        unit_idx = 1
        while unit_idx < m.cur_combat_unit_slot and m.cur_combat_unit_slot < 5:
            if is_cur_unit_absent(m):
                m.cur_combat_unit_slot = m.cur_combat_unit_slot + 1
            else:
                ux = m.r8(m.unit_col_ptr(m.cur_combat_side, unit_idx))
                uy = m.r8(m.unit_row_ptr(m.cur_combat_side, unit_idx))
                for d in range(6):
                    moved, cx, cy = step_coord_by_direction(ux, uy, d)
                    if moved and commit_unit_dest_tile_if_valid(m, cx, cy):
                        m.cur_combat_unit_slot = m.cur_combat_unit_slot + 1
                        break
            unit_idx += 1
    return 1 if m.cur_combat_unit_slot < 5 else 0


def seek_enemy_adjacent_cell_and_commit_move(m, x, y) -> int:
    """seek_enemy_adjacent_cell_and_commit_move $98FE: if NONE of (x,y)'s 6
    neighbours holds an enemy unit, commit the current unit to (x,y)."""
    d = 0
    while d < 6:
        moved, nx, ny = step_coord_by_direction(x, y, d)
        if moved and not side_has_unit_at_cell(m, m.cur_combat_side ^ 1, nx, ny):
            d += 1
            continue
        if not moved:
            d += 1
            continue
        break
    if d >= 6:
        if commit_unit_dest_tile_if_valid(m, x, y):
            m.cur_combat_unit_slot = m.cur_combat_unit_slot + 1
            return 1
    return 0


def rng_search_combat_rect_for_unit_cell(m, approach_dir) -> int:
    """rng_search_combat_rect_for_unit_cell $9954: attacker (side 0) deploy -- scan
    the arena rect (corner order randomised by rng flips, biased by the approach
    edge) for a cell with no enemy neighbour, place the commander, then fan the
    rest out via ai_place_unit_in_free_slot_resolve_coords(3)."""
    flip_x = m.rng_mod(2)
    flip_y = m.rng_mod(2)
    if approach_dir == 1:
        flip_y = 1
    elif approach_dir == 2:
        flip_y = 0
    elif approach_dir == 3:
        flip_x = 1
    elif approach_dir == 4:
        flip_x = 0
    x_min, x_max = m.r16(M.COMBAT_ARENA_X_MIN), m.r16(M.COMBAT_ARENA_X_MAX)
    y_min, y_max = m.r16(M.COMBAT_ARENA_Y_MIN), m.r16(M.COMBAT_ARENA_Y_MAX)
    xi = x_min
    while xi <= x_max:
        yi = y_min
        while yi <= y_max:
            x = xi if flip_x else (x_max - xi)
            y = yi if flip_y else (y_max - yi)
            if seek_enemy_adjacent_cell_and_commit_move(m, x, y):
                return ai_place_unit_in_free_slot_resolve_coords(m, 3)
            yi += 1
        xi += 1
    return 0


def ai_place_combat_units_random_or_smart(m, arena_rect) -> int:
    """ai_place_combat_units_random_or_smart $99D2: deploy one side -- defender uses
    the seat-anchored spread, attacker the rect scan; any still-unplaced unit drops
    onto a random (rng 11 x rng 5) cell."""
    m.cur_combat_unit_slot = 0
    if m.cur_combat_side:
        ai_advance_units_when_attacker_stronger(m)
    else:
        rng_search_combat_rect_for_unit_cell(m, arena_rect)
    while m.cur_combat_unit_slot < 5:
        if is_cur_unit_absent(m):
            m.cur_combat_unit_slot = m.cur_combat_unit_slot + 1
        else:
            # the VM pushes args right-to-left, so rng_mod(5) (y) draws BEFORE
            # rng_mod(11) (x) -- Python's left-to-right eval would swap them.
            ry = m.rng_mod(5)
            rx = m.rng_mod(11)
            commit_unit_move_and_redraw_count(m, rx, ry)
    return 0


def deploy_both_sides_units_loop(m) -> None:
    """deploy_both_sides_units_loop $9B07: deploy both sides (AI placement for the
    headless path), flipping cur_combat_side between them."""
    for _ in range(2):
        edge = set_combat_arena_rect_by_approach(m)
        ai_place_combat_units_random_or_smart(m, edge)
        m.cur_combat_side = m.cur_combat_side ^ 1


def ai_attacker_outstrengths_defender(m) -> int:
    """ai_attacker_outstrengths_defender $8EF5: ai_sum_battle_strength then compare
    the two sides' 40%-scored army totals (war_attacker_men vs war_defender_men)."""
    ai_sum_battle_strength(m)
    a = ai_score_strength_term_40pct(m, m.r16(m.side_resource_ptr(0) + M.SR_MEN), 0)
    d = ai_score_strength_term_40pct(m, m.r16(m.side_resource_ptr(1) + M.SR_MEN), 1)
    return 1 if a > d else 0


# ===========================================================================
# Pathing + the per-unit AI action chain
# ===========================================================================
from collections import deque as _deque


def bfs_path_distance_to_target(m, tx, ty) -> int:
    """bfs_path_distance_to_target $A221: level-order BFS from the target (tx,ty)
    back to the current unit over free cells (blocked = read_map_cell&194). First
    pass treats own units as blockers; if that fails it retries once without that
    constraint. Returns (6 - dir) for the neighbour direction that reaches the
    unit, or 0 if unreachable. (The ROM's ring-buffer + 255 level-separators are a
    plain FIFO; the dir-scan order 0..5 fixes the tie-break.)"""
    sx = m.r8(m.cur_unit_col_ptr() if False else m.unit_col_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    sy = m.r8(m.unit_row_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    if sx == tx and sy == ty:
        return 0
    block_own = True
    while True:
        dist = [128 if (read_map_cell(m, c, r) & 194) else 0
                for r in range(5) for c in range(11)]
        if block_own:
            for slot in range(5):
                if m.is_unit_present(m.cur_combat_side, slot):
                    uc = m.r8(m.unit_col_ptr(m.cur_combat_side, slot))
                    ur = m.r8(m.unit_row_ptr(m.cur_combat_side, slot))
                    if ur < 5 and uc < 11:
                        dist[ur * 11 + uc] = 128
        dist[ty * 11 + tx] = 255
        q = _deque([(tx, ty)])
        while q:
            x, y = q.popleft()
            for d in range(6):
                moved, nx, ny = step_coord_by_direction(x, y, d)
                if moved:
                    if nx == sx and ny == sy:
                        return 6 - d
                    if dist[ny * 11 + nx] < 16:
                        dist[ny * 11 + nx] = 255
                        q.append((nx, ny))
        # exhausted this pass
        if block_own:
            block_own = False        # local10: 255 -> 127 (>=127) retries once
            continue
        return 0                     # 127 -> 63 (<127) gives up


def ai_step_unit_toward_target(m, tx, ty) -> int:
    """ai_step_unit_toward_target $A3BD: BFS to (tx,ty); if reachable, step the unit
    one cell along (dir-1) and place it. Returns 1 on a move."""
    steps = bfs_path_distance_to_target(m, tx, ty)
    if steps > 0:
        ux = m.r8(m.unit_col_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
        uy = m.r8(m.unit_row_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
        moved, nx, ny = step_coord_by_direction(ux, uy, steps - 1)
        if moved and place_unit_at_tile_if_free(m, nx, ny):
            return 1
    return 0


def ai_place_units_near_enemy_loop(m) -> int:
    """ai_place_units_near_enemy_loop $A194: step the current unit in each direction;
    if the stepped cell has no reachable enemy, settle there. Returns 0/1."""
    cc = m.r8(m.unit_col_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    cr = m.r8(m.unit_row_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    for d in range(6):
        moved, tx, ty = step_coord_by_direction(cc, cr, d)
        if moved:
            lst = build_reachable_enemy_target_list(m, tx, ty)
            if all(v >= 5 for v in lst):           # no enemy adjacent to the new cell
                if place_unit_at_tile_if_free(m, tx, ty):
                    return 1
    return 0


def ai_engage_present_enemy_if_favorable(m, unit_idx) -> int:
    """ai_engage_present_enemy_if_favorable $A1EF: if the enemy `unit_idx` is
    adjacent and engaging is favourable (not a sub-50% trade for a non-commander
    that still has rice), attack it. Returns 1 if it engaged."""
    if is_enemy_unit_adjacent(m, unit_idx):
        if not (not unit_idx or not ai_battle_strength_ratio_below_50(m, unit_idx)):
            if not m.cur_combat_unit_slot or side_has_rice_for_day(m, m.cur_combat_side):
                return 0
        eval_and_announce_battle_strength_parity_if_enemy_present(m, unit_idx)
        return 1
    return 0


def ai_battle_strength_ratio_below_50(m, unit_type) -> int:
    """ai_battle_strength_ratio_below_50 $9D9A: p-share vs unit_type < 50."""
    return 1 if calc_battle_strength_pct_one_side(m, unit_type) < 50 else 0


def ai_select_weak_reachable_enemy_target(m) -> int:
    """ai_select_weak_reachable_enemy_target $A3F8: for a non-commander, pick an
    ADJACENT enemy (preferring a momentum-flagged one, then any not-sub-50%, then
    any) and attack it. Returns 1 if it attacked."""
    if not m.cur_combat_unit_slot:
        return 0
    cc = m.r8(m.unit_col_ptr(m.cur_combat_side, 0))
    cr = m.r8(m.unit_row_ptr(m.cur_combat_side, 0))
    lst = build_reachable_enemy_target_list(m, cc, cr)
    lst = [v if (v < 5 and is_enemy_unit_adjacent(m, v)) else 0xFF for v in lst]
    chosen = find_flagged_present_unit_type(m, lst)
    if chosen >= 5:
        for v in lst:
            if v < 5 and not ai_battle_strength_ratio_below_50(m, v):
                chosen = v
                break
        if chosen >= 5:
            for v in lst:
                if v < 5:
                    chosen = v
                    break
    if chosen < 5:
        eval_and_announce_battle_strength_parity_if_enemy_present(m, chosen)
        return 1
    return 0


def ai_decide_unit_action_attack_or_advance(m) -> int:
    """ai_decide_unit_action_attack_or_advance $A52F: attack a reachable enemy if
    one is good enough, else try to advance toward the enemy or settle near it."""
    threshold = 0 if (unit_type_count_gt3_and_equals_arg1(m, m.cur_combat_unit_slot) or not m.cur_combat_side) else 50
    cc = m.r8(m.unit_col_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    cr = m.r8(m.unit_row_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    lst = build_reachable_enemy_target_list(m, cc, cr)
    target = find_flagged_present_unit_type(m, lst)
    if target >= 5:
        target = find_strongest_unit_type_by_strength(m, lst, threshold)
    if target < 5:
        return eval_and_announce_battle_strength_parity_if_enemy_present(m, target)
    r = find_adjacent_unit_around_tile(m, cc, cr, m.cur_combat_side, 0)
    if r:
        return r
    if not (min_own_strength_pct_vs_list(m, lst) > threshold):
        return 0
    return ai_place_units_near_enemy_loop(m)


def ai_advance_units_toward_reachable_enemies(m) -> int:
    """ai_advance_units_toward_reachable_enemies $A5A4: attack a weak adjacent enemy,
    else step toward a reachable enemy of the commander, else decide attack/advance."""
    if ai_select_weak_reachable_enemy_target(m):
        return 1
    es = m.cur_combat_side ^ 1
    cc = m.r8(m.unit_col_ptr(m.cur_combat_side, 0))
    cr = m.r8(m.unit_row_ptr(m.cur_combat_side, 0))
    lst = build_reachable_enemy_target_list(m, cc, cr)
    for v in lst:
        if v < 5:
            ex = m.r8(m.unit_col_ptr(es, v))
            ey = m.r8(m.unit_row_ptr(es, v))
            if ai_step_unit_toward_target(m, ex, ey):
                return 1
    if ai_step_unit_toward_target(m, cc, cr):
        return 1
    return ai_decide_unit_action_attack_or_advance(m)


def ai_advance_units_into_free_adjacent_cells(m) -> int:
    """ai_advance_units_into_free_adjacent_cells $A625: attack a weak adjacent enemy,
    else (if a free neighbour exists) step toward the enemy commander, engaging any
    favourable adjacent enemy; fall back to attack/advance."""
    if ai_select_weak_reachable_enemy_target(m):
        return 1
    ox = m.r8(m.unit_col_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    oy = m.r8(m.unit_row_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    free_cell = 0
    for d in range(6):
        moved, cx, cy = step_coord_by_direction(ox, oy, d)
        if moved and is_tile_in_bounds(cx, cy) and not is_any_unit_at_tile(m, cx, cy) \
                and not is_map_cell_blocked(m, cx, cy):
            free_cell = 1
            break
    es = m.cur_combat_side ^ 1
    for slot in range(5):
        if m.is_unit_present(es, slot):
            if free_cell and not slot:
                ex = m.r8(m.unit_col_ptr(es, 0))
                ey = m.r8(m.unit_row_ptr(es, 0))
                if ai_step_unit_toward_target(m, ex, ey):
                    return 1
            if ai_engage_present_enemy_if_favorable(m, slot):
                return 1
    return ai_decide_unit_action_attack_or_advance(m)


def ai_choose_combat_action_by_battle_strength(m, unit_type) -> int:
    """ai_choose_combat_action_by_battle_strength $A6C5: the COMMANDER's action --
    settle near the enemy if very weak or nearly dead, else attack the strongest
    reachable enemy (>=70% odds), else (attacker only) advance into a free cell."""
    cc = m.r8(m.unit_col_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    cr = m.r8(m.unit_row_ptr(m.cur_combat_side, m.cur_combat_unit_slot))
    lst = build_reachable_enemy_target_list(m, cc, cr)
    if min_own_strength_pct_vs_list(m, lst) < 20:
        return ai_place_units_near_enemy_loop(m)
    if m.r16(m.unit_strength_ptr(m.cur_combat_side, 0)) <= 1:
        return ai_place_units_near_enemy_loop(m)
    strongest = find_strongest_unit_type_by_strength(m, lst, 70)
    if strongest < 5:
        return eval_and_announce_battle_strength_parity_if_enemy_present(m, strongest)
    if m.cur_combat_side:
        return m.cur_combat_side
    if not (unit_type > 5):
        return 0
    return ai_advance_units_into_free_adjacent_cells(m)


def ai_rng_resolve_combat_apply_casualties(m) -> int:
    """ai_rng_resolve_combat_apply_casualties $A721: with prob (const_two/(const_two
    +1)) the commander may BRIBE -- but ONLY when the enemy is the PLAYER and the
    own army is small vs the enemy. For all-AI battles every guard after the rng
    roll fails, so this just consumes one rng draw and returns. (RNG order matters
    for lockstep; the return is discarded by the caller.)"""
    es = m.cur_combat_side ^ 1
    if m.rng_mod(m.skill + 1):
        own_gold = m.r16(m.side_resource_ptr(m.cur_combat_side) + M.SR_GOLD)
        own_men = m.r16(m.side_resource_ptr(m.cur_combat_side) + M.SR_MEN)
        if not (own_gold <= own_men):
            if m.selected != 50:
                if m.province_ai_state(m.get_battle_side_province(es)):
                    if not m.cur_combat_unit_slot:
                        enemy_men_tot = m.r16(m.side_resource_ptr(es) + M.SR_MEN)
                        if not (own_men > enemy_men_tot // 2):
                            ep_mor = m.r16(m.fief(m.get_battle_side_province(es)) + M.F_MORALE)
                            if not (ep_mor > m.skill * 100):
                                strongest, maxs = 0, 0
                                for ut in range(5):
                                    if m.is_unit_present(es, ut) and maxs < m.r16(m.unit_strength_ptr(es, ut)):
                                        strongest, maxs = ut, m.r16(m.unit_strength_ptr(es, ut))
                                resolve_attack_apply_casualties(m, strongest, own_gold - own_men)
                                return 0
    ep_mor = m.r16(m.fief(m.get_battle_side_province(es)) + M.F_MORALE)
    return 1 if ep_mor > m.skill * 100 else 0


def ai_own_double_lt_enemy_total(m) -> int:
    """ai_own_double_lt_enemy_total $A7E5: 2*commander_men < sum of reachable enemy
    units' men (the 'too weak to claim' test)."""
    cc = m.r8(m.unit_col_ptr(m.cur_combat_side, 0))
    cr = m.r8(m.unit_row_ptr(m.cur_combat_side, 0))
    lst = build_reachable_enemy_target_list(m, cc, cr)
    es = m.cur_combat_side ^ 1
    tot = 0
    for v in lst:
        if v < 5 and m.is_unit_present(es, v):
            tot += m.r16(m.unit_strength_ptr(es, v))
    return 1 if (m.r16(m.unit_strength_ptr(m.cur_combat_side, 0)) << 1) < tot else 0


def ai_select_unit_combat_action(m, fief, unit_idx) -> int:
    """ai_select_unit_combat_action $A8CF: per-unit AI -- claim the province if
    strong enough (battle over -> 1); else maybe bribe, then the commander chooses
    by battle strength while other units advance. Returns 1 only on a claim."""
    if ai_claim_province_when_strong_enough(m, fief):
        return 1
    ai_rng_resolve_combat_apply_casualties(m)
    if not m.cur_combat_unit_slot:
        ai_choose_combat_action_by_battle_strength(m, fief)
    else:
        if not (not m.cur_combat_side or not ai_attacker_outstrengths_defender(m)
                or unit_type_count_gt3_and_equals_arg1(m, unit_idx)):
            ai_advance_units_toward_reachable_enemies(m)
        else:
            ai_advance_units_into_free_adjacent_cells(m)
    return 0


def ai_claim_province_when_strong_enough(m, fief) -> int:
    """ai_claim_province_when_strong_enough $A84D: the conquest trigger. Only the
    commander on its home-bit, with a province selected, strong enough and supplied,
    can claim -- relocating the capital onto a held neighbour and ending the battle.
    Needs the candidate owner list ($6F4F); returns 0 when none is available."""
    if m.cur_combat_unit_slot or not m.test_6f65_bit7(m.cur_combat_side) or m.selected == 50:
        return 0
    strong = not (ai_own_double_lt_enemy_total(m) or not side_has_rice_for_day(m, m.cur_combat_side))
    branch = strong and not (m.cur_combat_side or not (fief > 29))
    if strong and not branch:
        # the C's "strong" path additionally requires !(cur_side || !(fief>29));
        # if that inner guard fails the strong branch does nothing -> fall through.
        return 0
    if strong or True:
        # both the strong-and-eligible and the not-strong paths run the same claim body
        side_fief = m.get_battle_side_province(m.cur_combat_side)
        owner = _build_daimyo_province_list_first(m, m.defending, side_fief)
        if owner != 0xFF:
            m.w16(M.BATTLE_WINNER_PROV, side_fief)
            if m.test_6f65_bit7(m.cur_combat_side):
                _end_war_relocate_capital(m, side_fief, owner)
                if m.province_ai_state(owner):
                    m.w8(M.PROVINCE_AI_STATE + owner, 5)
                return 1
    return 0


def _build_daimyo_province_list_first(m, relrow_fief, side_fief) -> int:
    """build_daimyo_province_list $90BB (reduced): from the loaded candidate list
    ($6F4F), the first fief owned by side_fief's owner whose state != 255. Returns
    the fief id or 255. (load_daimyo_relation_row populates $6F4F upstream.)"""
    target_owner = m.fief_owner(side_fief)
    a = M.DEDUPED_OWNER_LIST
    while m.r8(a) != 0xFF:
        cand = m.r8(a)
        if not m.province_state_is_FF(cand) and m.fief_owner(cand) == target_owner:
            return cand
        a += 1
    return 0xFF


def _end_war_relocate_capital(m, from_fief, to_fief) -> None:
    """end_war_relocate_capital $8F55: clear the war/siege bit; move the capital
    flag from `from_fief` to `to_fief`."""
    a = M.WAR_SIDE_STATE_FLAG + m.cur_combat_side
    m.w8(a, m.r8(a) & 0x7F)
    m.w8(M.FIEF_IS_CAPITAL + from_fief, 0)
    m.w8(M.FIEF_IS_CAPITAL + to_fief, 1)


# ===========================================================================
# Per-day driver + rice clock + morale breach
# ===========================================================================
def check_commander_alive_both_sides(m) -> int:
    """check_commander_alive_both_sides $AB87: if either commander (slot 0) is gone,
    set the winner-province selector and return 5 (battle over)."""
    if not m.is_unit_present(0, 0):
        m.w16(M.BATTLE_WINNER_PROV, m.selected)
        return 5
    if not m.is_unit_present(1, 0):
        m.w16(M.BATTLE_WINNER_PROV, m.defending)
        return 5
    return 0


def battleside_not_state5_or_resting(m, side) -> int:
    """battleside_not_state5_or_resting $9030: side is AI-controlled (state != 5)
    OR its owner is resting -> run the AI action loop (vs the interactive one)."""
    fief = m.get_battle_side_province(side)
    return 1 if (m.province_ai_state(fief) != 5 or m.r8(M.REST_TURNS + m.fief_owner(fief))) else 0


def ai_run_all_units_combat_actions(m, battle_phase) -> int:
    """ai_run_all_units_combat_actions $ABB7: run every present unit of the current
    side through ai_select_unit_combat_action; stop early if a unit claims the
    province or a commander dies. Returns the battle-over code (0/1/5)."""
    m.cur_combat_unit_slot = 0
    unit_iter = 0
    battle_over = 0
    while m.cur_combat_unit_slot < 5:
        if m.is_unit_present(m.cur_combat_side, m.cur_combat_unit_slot):
            unit_iter += 1
            action_result = ai_select_unit_combat_action(m, battle_phase, unit_iter - 1)
            if action_result:
                battle_over = 1
                break
            battle_over = check_commander_alive_both_sides(m)
            if battle_over:
                break
        m.cur_combat_unit_slot = m.cur_combat_unit_slot + 1
    return battle_over


def halve_defender_morale_for_breaching_attackers(m) -> None:
    """halve_defender_morale_for_breaching_attackers $AD86: if any attacker (side 0)
    unit stands on a castle cell (bit 32), halve the defending fief's morale once."""
    mor_ptr = m.fief(m.defending) + M.F_MORALE
    for slot in range(5):
        if m.is_unit_present(0, slot):
            c = m.r8(m.unit_col_ptr(0, slot))
            r = m.r8(m.unit_row_ptr(0, slot))
            if not is_cell_clear_of_bits(m, c, r, 32):
                m.w16(mor_ptr, m.r16(mor_ptr) // 2)
                return


def side_has_rice_for_day(m, side) -> int:
    """side_has_rice_for_day $836A: ceil(army_men/15) <= rice stockpile (+2)."""
    men = m.r16(m.side_resource_ptr(side) + M.SR_MEN)
    need = men // 15 + (1 if men % 15 else 0)
    return 1 if need <= m.r16(m.side_resource_ptr(side) + M.SR_RICE) else 0


def consume_daily_battle_rice(m) -> None:
    """consume_daily_battle_rice $830B: each side burns ceil-ish men/30 rice per
    day (a /30 fixed-point accumulator carries the remainder). Drains the side's
    rice (side_resource +2)."""
    for side in range(2):
        men = m.r16(m.side_resource_ptr(side) + M.SR_MEN)
        drain = men // 30
        rem = men % 30
        # the /30 remainder carries in side_rice_accum (driver-local); modelled as
        # an attribute on m so it persists across days.
        accs = getattr(m, "_rice_accum", [0, 0])
        accs[side] += rem
        if accs[side] >= 30:
            accs[side] -= 30
            drain += 1
        m._rice_accum = accs
        rice_ptr = m.side_resource_ptr(side) + M.SR_RICE
        v = m.r16(rice_ptr) - drain
        m.w16(rice_ptr, v if v > 0 else 0)


def run_both_sides_combat_turn(m, day) -> int:
    """run_both_sides_combat_turn $ADD1: one combat DAY -- breach morale, then each
    side (starting cur_combat_side) resets the per-turn flags and runs its units'
    AI actions. Returns nonzero (battle-over code) the moment a side ends it."""
    halve_defender_morale_for_breaching_attackers(m)
    result = 0
    for _ in range(2):
        m.w8(M.COMBAT_CASUALTY_SKIP, 0)
        for u in range(5):
            m.w8(M.UNIT_EXCHANGE_COUNT + u, 0)
        # AI path for the headless sim (player branch is interactive)
        result = ai_run_all_units_combat_actions(m, day)
        if result:
            break
        m.cur_combat_side = m.cur_combat_side ^ 1
    return result


# ===========================================================================
# Battle resolution + the full battle driver
# ===========================================================================
def _transfer_force_triplet(m: "M.Memory") -> None:
    """transfer_force_triplet $DF73: blend the defending fief's morale/skill/arms
    with the attacker's, men-weighted (war_attacker_men vs war_defender_men),
    capped at the defending fief's header."""
    sp, dp = m.selected, m.defending
    header = m.r16(m.fief(dp) + M.F_HEADER)
    wam, wdm = m.r16(M.WAR_ATTACKER_MEN), m.r16(M.WAR_DEFENDER_MEN)
    for off in (M.F_MORALE, M.F_SKILL, M.F_ARMS):
        d = m.r16(m.fief(dp) + off)
        a = m.r16(m.fief(sp) + off)
        m.w16(m.fief(dp) + off, P.scaled_force_transfer(d, a, wam, wdm, header))


def _daimyo_stat_transfer(m: "M.Memory", win_fief: int, lose_fief: int) -> None:
    """daimyo_stat_transfer $DF3D: winner lord +1 Drive/Charisma/IQ, loser -1."""
    wd, ld = m.fief_daimyo(win_fief), m.fief_daimyo(lose_fief)
    for off in (M.D_DRIVE, M.D_CHARISMA, M.D_IQ):
        m.w8(wd + off, (m.r8(wd + off) + 1) & 0xFF)
        m.w8(ld + off, (m.r8(ld + off) - 1) & 0xFF)


def _reassign_faction(m: "M.Memory", loser_owner: int, winner_owner: int, winner_state: int) -> None:
    """reassign_fiefs_to_conqueror $DEC6 (core): every fief of the eliminated lord
    passes to the conqueror, inheriting its state, capital cleared."""
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    for i in range(n):
        if m.fief_owner(i) == loser_owner and not m.province_state_is_FF(i):
            m.w8(M.FIEF_TO_DAIMYO_MAP + i, winner_owner)
            m.w8(M.FIEF_IS_CAPITAL + i, 0)
            m.w8(M.PROVINCE_AI_STATE + i, winner_state)


def apply_conquest_outcome(m: "M.Memory", rng) -> None:
    """apply_conquest_outcome $E03C (core, non-uprising path): the survivors of both
    armies (war_attacker_* + war_defender_*) garrison the defending fief; if the
    attacker conquered (battle_winner_province_sel == defending) ownership flips to
    the attacker (whole faction if the capital fell, via the bit7 flag), stats blend,
    and the lords' Drive/Charisma/IQ shift. [Uprising/install_new_daimyo edge cases
    deferred -- oracle-validation of this resolution is a follow-up.]"""
    P.cap_fief_stats(m, m.defending)
    sp, dp = m.selected, m.defending
    uprising = (sp == 50)
    atk_won = (m.r16(M.BATTLE_WINNER_PROV) == dp)
    if atk_won:                                          # copy unit-type composition
        for i in range(5):
            m.w8(M.PROVINCE_UNIT_TYPE_PCT + dp * 5 + i, m.r8(M.PROVINCE_UNIT_TYPE_PCT + sp * 5 + i))
    if not uprising:
        _transfer_force_triplet(m)
        if atk_won:
            _daimyo_stat_transfer(m, sp, dp)
        else:
            _daimyo_stat_transfer(m, dp, sp)
    fd = m.fief(dp)
    m.w16(fd + M.F_GOLD, m.r16(M.WAR_ATTACKER_GOLD) + m.r16(M.WAR_DEFENDER_GOLD))
    m.w16(fd + M.F_RICE, m.r16(M.WAR_ATTACKER_RICE) + m.r16(M.WAR_DEFENDER_RICE))
    m.w16(fd + M.F_MEN, m.r16(M.WAR_ATTACKER_MEN) + m.r16(M.WAR_DEFENDER_MEN))
    if not uprising:
        winner_state = 5 if m.province_ai_state(sp) else 0
        if m.test_6f65_bit7(1 if atk_won else 0):        # capital fell -> whole faction
            if atk_won:
                _reassign_faction(m, m.fief_owner(dp), m.selected_province_owner(), winner_state)
        elif atk_won:
            m.w8(M.FIEF_TO_DAIMYO_MAP + dp, m.selected_province_owner())
            m.w8(M.PROVINCE_AI_STATE + dp, winner_state)
        if atk_won:                                      # capital-flag transfer ($E1B1)
            bit7 = m.r8(M.WAR_SIDE_STATE_FLAG) >> 7
            m.w8(M.FIEF_IS_CAPITAL + dp, bit7)
            m.w8(M.FIEF_IS_CAPITAL + sp, m.r8(M.FIEF_IS_CAPITAL + sp) ^ m.r8(M.FIEF_IS_CAPITAL + dp))
        m.w8(M.FIEF_TAX_RATE + dp, min(m.r8(M.FIEF_TAX_RATE + dp), 30))
    P.cap_fief_stats(m, dp)
    if not uprising:
        P.cap_fief_stats(m, sp)


def dispatch_battle_resolution(m: "M.Memory", outcome: int, rng) -> int:
    """dispatch_battle_resolution $AF3B (headless): adjust the commander-death code
    if the winner side has no units left, then apply the conquest. Returns the
    final outcome code."""
    if outcome == 5:
        winner_is_def = 1 if (m.r16(M.BATTLE_WINNER_PROV) == m.defending) else 0
        if not (m.r8(M.WAR_SIDE_STATE_FLAG + winner_is_def) & 31):
            outcome += 1
    apply_conquest_outcome(m, rng)
    return outcome


def _ensure_unit_split(m: "M.Memory", prov: int) -> None:
    """Guard the AI base unit-type split ($76A9 + prov*5) for a province that never
    got one (e.g. created mid-game): without it distribute_men would funnel every
    man into slot 0. setup.build_board seeds [50,5,5,5,5] and ai_reinforce ($960C)
    re-rolls it; this just backstops an unseeded fief."""
    base = M.PROVINCE_UNIT_TYPE_PCT + prov * 5
    if not any(m.r8(base + i) for i in range(5)):
        for i, v in enumerate((50, 5, 5, 5, 5)):
            m.w8(base + i, v)


def run_tactical_battle(m: "M.Memory", rng) -> int:
    """battle_init_driver $AFE1 (headless): the full on-screen battle -- init the
    defender, deploy both sides, run the 30-day combat loop (with the rice clock),
    and resolve. The attacker's committed force must already sit in side-0 resources
    (war_attacker_*, as ai_commit_attack_deduct_resources / the caller set up).
    Returns the battle outcome code; the board is mutated in place."""
    m.cur_combat_side = 0
    m.cur_combat_unit_slot = 0
    m.rng_mod(4)                          # sram_save_checksum = rng_mod(4)+53 ($AFF1):
    #                                       irrelevant value, but the draw keeps the
    #                                       LCG in lockstep with battle_init_driver.
    _ensure_unit_split(m, m.selected)
    _ensure_unit_split(m, m.defending)
    result = battle_init_defender(m)
    if result:                                           # defender already depleted
        return dispatch_battle_resolution(m, result, rng)
    deploy_both_sides_units_loop(m)
    m._rice_accum = [0, 0]
    for day in range(1, 31):
        for side in range(2):                            # rice-exhaustion check
            if m.s16(m.side_resource_ptr(side) + M.SR_RICE) <= 0:
                m.w16(M.BATTLE_WINNER_PROV, m.get_battle_side_province(side))
                return dispatch_battle_resolution(m, 4, rng)
        result = run_both_sides_combat_turn(m, day)
        if result:
            return dispatch_battle_resolution(m, result, rng)
        consume_daily_battle_rice(m)
    m.w16(M.BATTLE_WINNER_PROV, m.selected)              # 30-day timeout -> attacker withdraws
    return dispatch_battle_resolution(m, 3, rng)
