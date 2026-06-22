"""
The daimyo-AI command family -- a faithful (Plan B) transcription of
ai_econ_command_dispatch ($B64B) and its callees from source/4-c/bank_01.c,
operating on the flat memmap.Memory via the vmprims leaves.

This REPLACES the prose-derived ai.py. The point of the rewrite is that the
three gold-sinks the old port silently dropped are now PRESENT, because the
transcription mirrors every field-write in ROM order:
  - the military pass spends gold on ARMS-buy and FEED#2 (morale), and
  - the develop pass drains the remaining surplus to the men reserve via
    ai_develop_grow_if_men_exceeds_gold ($95C9) -- SCMPGE-gated (gold>men),
    confirmed against the bytecode.
Without those, the old port hoarded gold and over-recruited men to its year-cap.

War is injected: ai_try_war_attack ($949A) is well-understood (weakest-target +
commit gate) and battle resolution lives in combat.py, so recruit_arm_train
takes a `try_war(m, idx) -> bool` callback (True == a war launched, turn consumed),
preserving the ROM return contract without re-implementing combat here.

Field reads/writes are `m.r16(fief + F_*)` -- diff against bank_01.c directly.
"""

from . import memmap as M
from . import vmprims as P


def _no_war(m, idx) -> bool:
    """Default war hook: never attacks (econ-only runs)."""
    return False


# ---------------------------------------------------------------------------
# tiny shared helpers
# ---------------------------------------------------------------------------
def men_surplus(m: "M.Memory"):
    """ai_calc_men_surplus_over_gold_and_rice $B2EF (SELECTED fief):
    (gold-men, rice-men), each clamped >=0. The AI keeps a cash/food reserve
    equal to its army size and spends only the surplus above it."""
    fief = m.cur_fief()
    gs = m.r16(fief + M.F_GOLD) - m.r16(fief + M.F_MEN)
    rs = m.r16(fief + M.F_RICE) - m.r16(fief + M.F_MEN)
    return max(0, gs), max(0, rs)


def seed_fief_tax_rate(m: "M.Memory", idx: int) -> None:
    """ai_seed_fief_tax_rate $B2BD: fief_tax_rate[idx] = rng(30)+35 -> [35,64].
    (the ROM swaps through battle_defending_province; net effect is this write.)"""
    m.w8(M.FIEF_TAX_RATE + idx, m.rng_mod(30) + 35)


def rng_threshold_10_29(m: "M.Memory") -> int:
    """rng_threshold_10_29 $B32B = rng(20)+10."""
    return m.rng_mod(20) + 10


def gold_to_rice_convert(m: "M.Memory", gs: int, rs: int):
    """ai_province_gold_to_rice_convert $B338: 1/4 skip; else by a rng(20)+10 vs
    the exchange rate, SELL rice (market dear) or BUY rice (cheap). Returns the
    recomputed (gold_surplus, rice_surplus); on the 1/4 skip, the surpluses pass
    through unchanged (the ROM early-returns before recomputing)."""
    if m.rng_mod(4) == 0:
        return gs, rs
    fief = m.cur_fief()
    if rng_threshold_10_29(m) < m.r16(M.GOLD_RICE_EXCHANGE):
        P.effect_sell_rice_for_gold(m, rs // 2)
    elif rng_threshold_10_29(m) > m.r16(M.GOLD_RICE_EXCHANGE):
        rate = m.r16(M.GOLD_RICE_EXCHANGE)
        rice = m.r16(fief + M.F_RICE)
        rice_gain = P.ratio_times10_capped(gs, rate, m.r16(fief + M.F_HEADER) - rice)
        m.w16(fief + M.F_GOLD, m.r16(fief + M.F_GOLD) - P.math32_muladddiv(rate, rice_gain))
        m.w16(fief + M.F_RICE, rice + rice_gain)
        P.cycle_economy_rate(m, 2)
    return men_surplus(m)


def develop_grow_if_men_exceeds_gold(m: "M.Memory") -> int:
    """ai_develop_grow_if_men_exceeds_gold $95C9 (misnomer -- it's the surplus
    gold-sink): 50% bump the daimyo's charisma; then if gold>men (SCMPGE), pump
    loyalty+wealth at max multiplier for the WHOLE surplus and debit it -> gold
    falls to the men reserve. THIS is the drain the old port dropped."""
    if m.rng_mod(2) == 0:
        daimyo = m.fief_daimyo(m.selected)
        m.w8(daimyo + M.D_CHARISMA, m.r8(daimyo + M.D_CHARISMA) + 1)
    fief = m.cur_fief()
    surplus = m.r16(fief + M.F_GOLD) - m.r16(fief + M.F_MEN)   # signed SCMPGE >= 1
    if surplus >= 1:
        P.apply_two_grows_const1_override(m, fief, surplus)
        return 14
    return 0


# ---------------------------------------------------------------------------
# develop handlers
# ---------------------------------------------------------------------------
def develop_town_handler(m: "M.Memory", idx: int) -> int:
    """ai_develop_town_handler $B3AA: re-seed tax, market-trade, then 1/3-gated
    LINEAR town += gold spent (year-capped), and ALWAYS the surplus gold-sink."""
    m.selected = idx
    fief = m.fief(idx)
    gs, rs = men_surplus(m)
    seed_fief_tax_rate(m, idx)
    gs, rs = gold_to_rice_convert(m, gs, rs)
    town = m.r16(fief + M.F_TOWN)
    header = m.r16(fief + M.F_HEADER)
    cap = P.min_word((m.year - 1559) * 100 + 100, header)
    gain = P.effect_send(cap, town, gs)
    if (town < header) and (m.rng_mod(3) == 0) and (gain > 0):
        m.w16(fief + M.F_TOWN, town + gain)            # linear 1:1
        m.w16(fief + M.F_GOLD, m.r16(fief + M.F_GOLD) - gain)
    develop_grow_if_men_exceeds_gold(m)
    return 1


def develop_dam_and_grow(m: "M.Memory", idx: int) -> int:
    """ai_develop_dam_and_grow $B42B: only when loyalty>output -- dam (gold-debited)
    then grow (output += spend LINEAR, then effect_grow's sqrt gain, NEITHER
    gold-debited); otherwise the surplus gold-sink. Closes with cap_fief_stats."""
    m.selected = idx
    fief = m.fief(idx)
    gold_budget, _rs = men_surplus(m)
    seed_fief_tax_rate(m, idx)
    if m.r16(fief + M.F_LOYALTY) > m.r16(fief + M.F_OUTPUT):
        if m.r16(fief + M.F_OUTPUT):
            spend = P.min_word(gold_budget, P.effect_dam(m, fief) * (100 - m.r16(fief + M.F_DAMS)))
            m.w16(fief + M.F_GOLD, m.r16(fief + M.F_GOLD) - spend)
            gain = spend // P.effect_dam(m, fief)
            P.add_effect_gain_clamped(m, gain, fief + M.F_DAMS)
            gold_budget -= gain                        # budget -= GAIN, not spend (ROM quirk)
        cap = P.min_word((m.year - 1559) * 50 + 250, m.r16(fief + M.F_HEADER))
        grow_amount = P.effect_send(cap, m.r16(fief + M.F_OUTPUT), gold_budget)
        m.w16(fief + M.F_OUTPUT, m.r16(fief + M.F_OUTPUT) + grow_amount)   # LINEAR add, no gold debit
        P.effect_grow(m, fief, grow_amount)            # sqrt gain on top, also no gold debit
    else:
        develop_grow_if_men_exceeds_gold(m)
    P.cap_fief_stats(m, idx)
    return 1


# ---------------------------------------------------------------------------
# military prep
# ---------------------------------------------------------------------------
def reinforce_arms_econ_10pct(m: "M.Memory") -> int:
    """ai_reinforce_province_arms_and_econ_10pct $960C (1% rare): bump the daimyo's
    Drive; if the fief has >8 men, (re)seed its unit-type composition table
    (province_unit_type_pct $76A9) = [50,5,5,5,5] + 5 random +5 boosts + 1 more to
    slot 0/1; then +10% gold/rice/men. This is THE AI distribution the tactical
    battle's distribute_men splits on (Chris: fair for an AI-v-AI battle)."""
    daimyo = m.fief_daimyo(m.selected)
    m.w8(daimyo + M.D_DRIVE, m.r8(daimyo + M.D_DRIVE) + m.rng_mod(m.skill + 1))
    fief = m.cur_fief()
    if m.r16(fief + M.F_MEN) > 8:
        arms = [50, 5, 5, 5, 5]
        for _ in range(5):
            arms[m.rng_mod(5)] += 5
        arms[1 + m.rng_mod(2)] += 5                  # +5 to a MIDDLE unit (arms_record_scratch = &arms_buf[1])
        base = M.PROVINCE_UNIT_TYPE_PCT + m.selected * 5    # copy_arms_record_5 $E2AF
        for i in range(5):
            m.w8(base + i, arms[i] & 0xFF)
    m.w16(fief + M.F_GOLD, m.r16(fief + M.F_GOLD) + P.pct_op(m.r16(fief + M.F_GOLD) + 1, 10))
    m.w16(fief + M.F_RICE, m.r16(fief + M.F_RICE) + P.pct_op(m.r16(fief + M.F_RICE) + 1, 10))
    m.w16(fief + M.F_MEN, m.r16(fief + M.F_MEN) + P.pct_op(m.r16(fief + M.F_MEN) + 1, 10))
    return 0


def recruit_arm_train(m: "M.Memory", idx: int, try_war) -> int:
    """ai_state2_recruit_arm_train $B4D5: war FIRST (return 1 iff it launches);
    else recruit -> feed#1(rice) -> arms-buy(gold) -> feed#2(gold) -> 50% train
    -> 1% reinforce, returning 0. Steps 'feed#1/arms/feed#2' are the gold/rice
    sinks the old port omitted."""
    m.selected = idx
    if try_war(m, idx):
        return 1
    fief = m.fief(idx)
    gs, rs = men_surplus(m)                            # men_over_gold, men_over_rice
    header = m.r16(fief + M.F_HEADER)
    year = m.year

    # RECRUIT (under year-strength; prob (skill+3)/10; spend surplus/2)
    if P.min_word((year - 1559) * 40, header) > m.r16(fief + M.F_MEN):
        room = P.min_word((year - 1559) * 100, header) - m.r16(fief + M.F_MEN)
        cnt = P.ratio_times10_capped(gs // 2, m.r16(M.GOLD_MEN_HIRE_RATE), room)
        if cnt > 0 and m.rng_mod(10) < (m.skill + 3):
            m.w16(fief + M.F_GOLD, m.r16(fief + M.F_GOLD) - gs // 2)
            P.apply_hire_unit_stats(m, fief, cnt)
            gs, rs = men_surplus(m)                    # recompute

    # FEED #1: rice -> morale (per-man)
    men = m.r16(fief + M.F_MEN)
    cnt = P.effect_send(header, m.r16(fief + M.F_MORALE), (rs // men) if men else 0)
    m.w16(fief + M.F_MORALE, m.r16(fief + M.F_MORALE) + cnt)
    m.w16(fief + M.F_RICE, m.r16(fief + M.F_RICE) - men * cnt)

    # ARMS BUY: gold -> arms (sink the old port dropped)
    price = P.scale_div10_capcheck(men, m.r16(M.ARMS_BUY_PRICE_RATE), header)
    if m.r16(fief + M.F_GOLD) >= price and price != 1:
        units = (gs // price) if price else 0
        if units:
            m.w16(fief + M.F_GOLD,
                  m.r16(fief + M.F_GOLD) - P.scale_div10_capcheck(units, m.r16(M.ARMS_BUY_PRICE_RATE), m.r16(fief + M.F_GOLD)))
            m.w16(fief + M.F_ARMS, m.r16(fief + M.F_ARMS) + (units << 1))
            P.clamp_amount_to_province_max(m, fief + M.F_ARMS)
            P.cycle_economy_rate(m, 3)

    # FEED #2: gold -> morale (sink the old port dropped)
    gs, rs = men_surplus(m)
    men = m.r16(fief + M.F_MEN)
    cnt = P.effect_send(header, m.r16(fief + M.F_MORALE), (gs // men) if men else 0)
    m.w16(fief + M.F_MORALE, m.r16(fief + M.F_MORALE) + m.rng_mod(10) + cnt)
    m.w16(fief + M.F_GOLD, m.r16(fief + M.F_GOLD) - men * cnt)

    # TRAIN (50%) + rare reinforce (1%)
    if m.rng_mod(2):
        P.effect_train(m)
    if m.rng_mod(100) == 0:
        reinforce_arms_econ_10pct(m)
    return 0


# ---------------------------------------------------------------------------
# the brain
# ---------------------------------------------------------------------------
def econ_command_dispatch(m: "M.Memory", idx: int, try_war=_no_war) -> None:
    """ai_econ_command_dispatch $B64B. ~90%: military pass (war-first); if a war
    launched, the turn is consumed. Otherwise ~90% develop town, then ALWAYS
    dam+grow. (The `return recruit()` twice in the C is a short-circuit artifact;
    recruit runs once -- its value is the war flag.)"""
    m.selected = idx
    fief = m.fief(idx)
    if m.r16(fief + M.F_RICE) == 0:
        m.w16(fief + M.F_RICE, m.r16(fief + M.F_RICE) + m.rng_mod(10))   # never starve to 0
    if m.is_capital(idx) and not m.province_ai_state(idx) and m.r16(fief + M.F_MEN) == 0:
        m.w16(fief + M.F_MEN, 2)                                          # token garrison
        m.w16(fief + M.F_RICE, m.r16(fief + M.F_RICE) + 1)

    # military gate: rng(10)!=0 AND recruit launched a war -> turn consumed
    if m.rng_mod(10) != 0 and recruit_arm_train(m, idx, try_war):
        return
    if m.rng_mod(10) != 0:
        develop_town_handler(m, idx)
    develop_dam_and_grow(m, idx)


# Back-compat alias for callers expecting the old entry-point name.
def decide_ai_fief(m: "M.Memory", idx: int, try_war=_no_war) -> None:
    econ_command_dispatch(m, idx, try_war)


# ===========================================================================
# War (ai_try_war_attack $949A) -- engine-side, bank-1; battle delegated to the
# injected resolver at the resolve_siege_assault_outcome $8DFD boundary.
# Candidate neighbour list is sourced from m.neighbor_rows (loader adjacency /
# oracle-captured), NOT the banked-SRAM relation syscall.
# ===========================================================================
def _no_resolve(m: "M.Memory") -> None:
    """Default battle hook at the $8DFD boundary: deduct-only, no resolution."""
    return None


def fief_men_ratio_pct(m: "M.Memory", a: int, b: int) -> int:
    """fief_men_ratio_pct $939D = math32_2arg(provisioned_men(a), provisioned_men(b))."""
    return P.math32_2arg(m.fief_men_if_provisioned(a), m.fief_men_if_provisioned(b))


def load_daimyo_relation_row(m: "M.Memory", idx: int) -> int:
    """load_daimyo_relation_row $DAAB: copy the 8-byte neighbour row for `idx`
    into DEDUPED_OWNER_LIST (FF-padded). Source = m.neighbor_rows (the banked-SRAM
    read is replaced by a direct lookup, per the agreed plan)."""
    row = (list(m.neighbor_rows.get(idx, [])) + [0xFF] * 8)[:8]
    for i in range(8):
        m.w8(M.DEDUPED_OWNER_LIST + i, row[i] & 0xFF)
    return M.DEDUPED_OWNER_LIST


def compact_relation_list(m: "M.Memory") -> None:
    """compact_relation_list $DAD7: load the selected fief's row, then compact in
    place keeping only still-existing provinces (ai_state != 255)."""
    load_daimyo_relation_row(m, m.selected)
    src = dst = M.DEDUPED_OWNER_LIST
    while m.r8(src) != 0xFF:
        if m.province_ai_state(m.r8(src)) != 0xFF:
            m.w8(dst, m.r8(src))
            dst += 1
        src += 1
    m.w8(dst, 0xFF)


def filter_province_list_by_owner(m: "M.Memory", match_enemy: int) -> None:
    """filter_province_list_by_owner $DD3A: prune DEDUPED_OWNER_LIST in place,
    keeping fiefs whose is_enemy_owned(p) == match_enemy AND that still exist."""
    kept = []
    src = M.DEDUPED_OWNER_LIST
    while m.r8(src) != 0xFF:
        p = m.r8(src)
        if not (m.is_enemy_owned(p) ^ match_enemy) and not m.province_state_is_FF(p):
            kept.append(p)
        src += 1
    for i, p in enumerate(kept):
        m.w8(M.DEDUPED_OWNER_LIST + i, p)
    m.w8(M.DEDUPED_OWNER_LIST + len(kept), 0xFF)


def pick_weakest_men_fief(m: "M.Memory", list_addr: int) -> int:
    """pick_weakest_men_fief $93B3: the enemy with the FEWEST provisioned men
    (ratio(weakest, candidate) > 50 -> candidate is weaker)."""
    weakest = m.r8(list_addr)
    p = list_addr
    while m.r8(p) != 0xFF:
        if fief_men_ratio_pct(m, weakest, m.r8(p)) > 50:
            weakest = m.r8(p)
        p += 1
    return weakest


def ai_relations_and_low_drive_skip_gate(m: "M.Memory", candidate: int) -> int:
    """ai_relations_and_low_drive_skip_gate $93DD: a timid (Drive<50) daimyo
    respects good relations and skips the candidate. Rolls rng_mod(100) 1-3x with
    C short-circuit order preserved."""
    drive = m.r8(m.fief_daimyo(m.selected) + M.D_DRIVE)
    sel = m.selected
    # left: rel(candidate,selected,0) > rng AND drive<50  -> skip
    if (m.relations_matrix_get(candidate, sel, 0) > m.rng_mod(100)) and (drive < 50):
        return 1
    # right: NOT(rel(candidate,selected,0) > rng) AND rel(own,own,1) > rng AND drive<50
    if (not (m.relations_matrix_get(candidate, sel, 0) > m.rng_mod(100))) \
            and (m.relations_matrix_get(m.fief_owner(candidate), m.selected_province_owner(), 1) > m.rng_mod(100)) \
            and (drive < 50):
        return 1
    return 0


def pick_ai_attack_target_fief(m: "M.Memory", list_addr: int) -> int:
    """pick_ai_attack_target_fief $9423: refine toward the weakest NON-skipped
    target among non-AI-state (i.e. player/granted) candidates. For an all-AI
    list, get_province_ai_state(target)==0 -> no rng, target stays the first."""
    target = m.r8(list_addr)
    p = list_addr
    while m.r8(p) != 0xFF:
        if m.province_ai_state(target):
            if not ai_relations_and_low_drive_skip_gate(m, target):
                if fief_men_ratio_pct(m, target, m.r8(p)) > 50:
                    target = m.r8(p)
        p += 1
    return target


def find_fief_by_owner_men_minority(m: "M.Memory", list_addr: int, owner: int) -> int:
    """find_fief_by_owner_men_minority $945D: men-minority adjacency override.
    [FLAG: the decompile holds local11 at the FIRST list element (loop var not
    re-read) -- transcribed literally; verify vs asm. Has NO rng, so it doesn't
    affect rng alignment, only which target. Gated on owner != 255.]"""
    if owner == 255:
        return 255
    first = m.r8(list_addr)
    p = list_addr
    while m.r8(p) != 0xFF:
        if m.fief_owner(first) == owner:
            if fief_men_ratio_pct(m, first, m.selected) >= 50:
                return first
            break
        p += 1
    return 255


def effect_war_a(m: "M.Memory") -> int:
    """effect_war_a $8201: war breaks pacts -- zero the province cell [sel][def]
    and the (transposed) owner cell. No rng."""
    a, b = m.selected, m.defending
    m.w8(M.RELATIONS_MATRIX + (a * 54 + b if a < b else b * 54 + a), 0)
    ao, bo = m.selected_province_owner(), m.fief_owner(m.defending)
    m.w8(M.RELATIONS_MATRIX + (bo * 54 + ao if ao < bo else ao * 54 + bo), 0)
    return 0


def ai_commit_attack_deduct_resources(m: "M.Memory", resolve=_no_resolve) -> int:
    """ai_commit_attack_deduct_resources $9040: the WAR SINK. Sizes an attack
    budget = min(rice*2, min(men, gold)); bails if too small or the defender is
    too strong; relations_rng_predicate can block; else commits spend% of the
    budget as men+gold and a rice cost, deducting from the attacker, then hands
    off to the injected resolver (resolve_siege_assault_outcome $8DFD). Returns 1
    if committed."""
    m.w16(M.AI_REDISPATCH_FLAG, 0)
    fief = m.cur_fief()
    deff = m.fief(m.defending)
    if m.r8(M.REST_TURNS + m.selected):            # (decompile indexes by selected idx)
        war_side = 0
    elif m.is_capital(m.selected):
        war_side = m.rng_mod(2) << 7               # siege flag
    else:
        war_side = 0
    m.w8(M.WAR_SIDE_STATE_FLAG, war_side)          # BYTE store ($6F66 is a separate field)

    attack_budget = P.min_word(m.r16(fief + M.F_RICE) << 1,
                               P.min_word(m.r16(fief + M.F_MEN), m.r16(fief + M.F_GOLD)))
    if not (attack_budget >= 5):
        return 0
    if not (P.min_word(m.r16(deff + M.F_RICE), m.r16(deff + M.F_MEN)) <= attack_budget):
        return 0
    if P.relations_rng_predicate(m, m.defending, m.selected):
        return 0

    spend_pct = (m.rng_mod(30) + 60) if war_side else (m.rng_mod(20) + 50)
    spend = P.pct_op(attack_budget, spend_pct)
    m.w16(M.WAR_ATTACKER_MEN, spend)
    m.w16(M.WAR_ATTACKER_GOLD, spend)
    m.w16(fief + M.F_GOLD, m.r16(fief + M.F_GOLD) - spend)
    m.w16(fief + M.F_MEN, m.r16(fief + M.F_MEN) - spend)

    if P.math32_2arg(m.r16(fief + M.F_RICE), spend) > 55:
        rice_cost = spend
    else:
        rice_cost = P.min_word(m.r16(fief + M.F_RICE) - 1, P.pct_op(spend, m.rng_mod(10) + 50))
    m.w16(M.WAR_ATTACKER_RICE, rice_cost)
    m.w16(fief + M.F_RICE, m.r16(fief + M.F_RICE) - rice_cost)

    # announce (UI no-op); snapshot the defender unless it's the human (state 5)
    if not m.r8(M.UI_CONFIRM_FLAG) and m.province_ai_state(m.defending) != 5:
        m.w16(M.WAR_DEFENDER_GOLD, m.r16(deff + M.F_GOLD))
        m.w16(M.WAR_DEFENDER_RICE, m.r16(deff + M.F_RICE))
        m.w16(M.WAR_DEFENDER_MEN, m.r16(deff + M.F_MEN))
        m.w16(M.AI_REDISPATCH_FLAG, 0)
    else:
        m.w16(M.AI_REDISPATCH_FLAG, 1)
    resolve(m)                                     # resolve_siege_assault_outcome $8DFD
    return 1


def ai_try_war_attack(m: "M.Memory", idx: int, resolve=_no_resolve) -> int:
    """ai_try_war_attack $949A: returns 2 iff a war launched (turn consumed).
    Preconditions -> build enemy list -> weakest target -> commit gate (UNSIGNED,
    wraps) -> monk-fief/Drive + AI-vs-human asymmetry -> deduct + resolve."""
    m.selected = idx
    fief = m.fief(idx)
    if P._fief_owner_weakness(m, idx) or not m.r16(fief + M.F_MEN) or not m.r16(fief + M.F_RICE):
        return 0

    compact_relation_list(m)
    filter_province_list_by_owner(m, 0)            # keep enemy fiefs
    target = pick_weakest_men_fief(m, M.DEDUPED_OWNER_LIST)
    if target == 0xFF:
        return 0

    alt = pick_ai_attack_target_fief(m, M.DEDUPED_OWNER_LIST)
    minority = find_fief_by_owner_men_minority(m, M.DEDUPED_OWNER_LIST,
                                               m.r8(M.MINORITY_OWNER_TABLE + idx))
    if minority != 0xFF:
        target = minority

    # commit gate -- UNSIGNED compare (ratio-10-rng wraps to huge if negative)
    do_attack = (((fief_men_ratio_pct(m, idx, target) - 10 - m.rng_mod(m.skill * 3)) & 0xFFFF) > 60) \
        or (m.rng_mod(100) == 0)
    if m.province_ai_state(alt) and fief_men_ratio_pct(m, idx, alt) > 47:
        do_attack = True
        target = alt

    drive = m.r8(m.fief_daimyo(idx) + M.D_DRIVE)
    if (target != 30) or (not (drive < m.rng_mod(80) + 90)):        # monk-fief 30 reluctance
        if m.province_ai_state(target) or m.rng_mod(2):            # AI(0) needs a coin; human(5) bypasses
            if do_attack:
                m.defending = target
                if ai_commit_attack_deduct_resources(m, resolve):
                    effect_war_a(m)
                    return 2
    return 0


def war_hook(resolve=_no_resolve):
    """Build a try_war(m, idx) callback for recruit_arm_train / the loop."""
    return lambda m, idx: ai_try_war_attack(m, idx, resolve)


# ===========================================================================
# smoke: a full econ turn drains surplus to the men reserve (the $95C9 fix)
# ===========================================================================
def _smoke():
    m = M.Memory()
    m.w16(M.CONST_TWO, 2)
    m.w16(M.CURRENT_GAME_YEAR, 1570)
    # market rates (mid-game-ish)
    m.w16(M.GOLD_RICE_EXCHANGE, 15)
    m.w16(M.ARMS_BUY_PRICE_RATE, 40)
    m.w16(M.GOLD_MEN_HIRE_RATE, 70)

    idx = 5
    f = m.fief(idx)
    m.w8(M.FIEF_TO_DAIMYO_MAP + idx, 3)            # owned by daimyo 3
    m.w8(M.PROVINCE_AI_STATE + idx, M.AI_HOME)
    m.w8(M.FIEF_IS_CAPITAL + idx, 1)
    # daimyo 3 record stats
    d = m.daimyo(3)
    m.w8(d + M.D_DRIVE, 60)
    m.w8(d + M.D_CHARISMA, 70)
    m.w8(d + 5, 80)        # the +5 stat effect_train reads
    # fief stats: a rich fief sitting on a big gold pile over a small army
    m.w16(f + M.F_GOLD, 800)
    m.w16(f + M.F_TOWN, 400)
    m.w16(f + M.F_RICE, 600)
    m.w16(f + M.F_OUTPUT, 300)
    m.w16(f + M.F_DAMS, 50)
    m.w16(f + M.F_LOYALTY, 400)                    # loyalty>output -> grow branch active
    m.w16(f + M.F_WEALTH, 200)
    m.w16(f + M.F_MEN, 80)
    m.w16(f + M.F_MORALE, 60)
    m.w16(f + M.F_SKILL, 200)
    m.w16(f + M.F_ARMS, 100)
    m.w16(f + M.F_HEADER, 1900)

    # Seed RNG so the develop path actually runs (no war hook).
    import random
    m.rng = random.Random(7)

    gold0 = m.r16(f + M.F_GOLD)
    men0 = m.r16(f + M.F_MEN)
    out0 = m.r16(f + M.F_OUTPUT)
    town0 = m.r16(f + M.F_TOWN)

    # Run develop directly (force the develop fallback) to exercise the sink.
    develop_town_handler(m, idx)
    develop_dam_and_grow(m, idx)

    gold1 = m.r16(f + M.F_GOLD)
    men1 = m.r16(f + M.F_MEN)
    out1 = m.r16(f + M.F_OUTPUT)
    town1 = m.r16(f + M.F_TOWN)

    print("ai_vm smoke -- one develop turn on a gold-rich fief:")
    print(f"  gold  {gold0} -> {gold1}   (men reserve = {men1})")
    print(f"  town  {town0} -> {town1}   output {out0} -> {out1}")
    # THE FIX: the surplus gold-sink drains gold to ~the men reserve, not hoarded.
    assert gold1 <= men1 + 5, f"gold not drained to men reserve: {gold1} vs men {men1}"
    assert out1 >= out0, "output should have grown (linear + sqrt)"
    print("  -> surplus drained to the men reserve (the $95C9 sink is present). PASS")

    # And a full dispatch turn runs end-to-end without error.
    m.rng = random.Random(11)
    econ_command_dispatch(m, idx)
    print("  full econ_command_dispatch turn ran clean. PASS")


if __name__ == "__main__":
    _smoke()
