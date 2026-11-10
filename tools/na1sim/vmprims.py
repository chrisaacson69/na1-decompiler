"""
Leaf VM primitives -- the shared engine math/effect handlers the daimyo-AI
command routines bottom out on, transcribed line-for-line from source/4-c
(bank_01.c + all_banks.c). Each function cites its ROM address so it can be
diffed against the decompile and the na1dream bytecode oracle (Plan A).

WHY THIS EXISTS (the trap it closes)
------------------------------------
The earlier sim routed AI develop through `econ.grow`, which was *re-derived*
from the appendix and DEBITS GOLD -- but the ROM `effect_grow $87F0` never
touches gold (the gold accounting lives in the callers, and differs per branch).
Bottoming the transcription out on these C-faithful leaves -- not the appendix
re-derivations -- is what stops that class of divergence.

CONVENTIONS
-----------
- Pure math leaves take/return plain Python ints. The ROM's math32_* ops are
  32-bit ext-ops (full precision); only *storage* is 16-bit, so we compute wide
  and let Memory.w16 truncate on write.
- Effect leaves take the machine `m` (memmap.Memory) and operate on record
  ADDRESSES exactly as the C does: `m.r16(fief + F_OUTPUT)`, etc.
- `skill_level` (the skill dial) is a live global at memmap.SKILL_LEVEL; routines
  read it via `m.skill`, and apply_two_grows_const1_override mutates it in place
  (and restores) just like the ROM.
- Signed `< 0` clamps in the C become explicit `max(0, ...)`; word-subtraction
  wrap (where the C relies on it, e.g. effect_send headroom) is masked &0xFFFF.
"""

from math import isqrt

from . import memmap as M


# ===========================================================================
# Pure math leaves (bank15 / bank1 -- "CERTIFIED ext-op fold vs ROM")
# ===========================================================================
def min_word(a: int, b: int) -> int:
    """min_word $CB5E."""
    return a if a < b else b


def max_word(a: int, b: int) -> int:
    """max_word $CB6F."""
    return a if a > b else b


def sqrt_int(x: int) -> int:
    """sqrt_int $CBCD -- integer floor sqrt (ext-op; isqrt is ROM-exact per econ)."""
    return isqrt(x) if x > 0 else 0


# The five 32-bit ext-op helpers point at emu-harness's ROM-checked models (cfg_gate checks them
# against the ROM's own subs over an edge grid) instead of keeping a copy: the copies here had come
# from the June 4-c folds, which were unsigned and dropped the guards (NA1 revisit 2026-10-27).
# The ROM works in 16-bit words; these return signed ints (0xFFFF -> -1), the sim's convention.
from emu_harness.vm.koei.nes.vm_decompile import na1_extop_model


def _rom16(stub, *args):
    v = na1_extop_model(stub)(*(x & 0xFFFF for x in args))
    return v - 0x10000 if v & 0x8000 else v


def math32_3arg(a: int, b: int, c: int) -> int:
    """math32_3arg $D6B8 = signed (a*b)/c; c == 0 -> -1 (a guard in its bytecode)."""
    return _rom16(0xD6B8, a, b, c)


def math32_2arg(a: int, b: int) -> int:
    """math32_2arg $D6DE = (a*100)/(a+b), unsigned; (0, 0) -> 0."""
    return _rom16(0xD6DE, a, b)


def math32_muladddiv(rate: int, amount: int) -> int:
    """math32_muladddiv $8303 = signed (rate*amount + 9)/10."""
    return _rom16(0x8303, rate, amount)


def pct_op(arg1: int, arg2: int) -> int:
    """pct_op $D70D -- the percentage primitive (split-by-10; NOT floor(b*p/100)).
    Certified: pct_op(51,55)=27, pct_op(136,64)=86."""
    if arg2 == 100:
        return arg1
    return (((arg2 % 10) * (arg1 // 10)) // 10
            + ((arg1 % 10) * arg2) // 100
            + (arg2 // 10) * (arg1 // 10))


def ratio_times10_capped(a: int, b: int, c: int) -> int:
    """ratio_times10_capped $8357 = signed min((a*10)/b, c)."""
    return _rom16(0x8357, a, b, c)


def scale_div10_capcheck(a: int, b: int, c: int) -> int:
    """scale_div10_capcheck $8327 = -1 if muladddiv(a, b) > c (i.e. a*b > 10c) else (a*b)/10.
    The June form (a*b/10 >= c) refused an exactly affordable purchase."""
    return _rom16(0x8327, a, b, c)


def scaled_force_transfer(stat, recruit_stat, count, force, header) -> int:
    """scaled_force_transfer $DA1F -- men-weighted blend of an existing unit stat
    with the incoming recruits' stat, capped at header. (the Hire dilution leaf)
        min( pct_op(stat,        weight%_of_existing)
           + pct_op(recruit|1,   weight%_of_new),     header )"""
    return min_word(pct_op(stat, math32_2arg(force, count))
                    + pct_op(recruit_stat | 1, math32_2arg(count, force)),
                    header)


# ===========================================================================
# Develop-family effect leaves (bank1 / bank15)
# ===========================================================================
def effect_send(ceiling: int, current: int, budget: int) -> int:
    """effect_send $8BE5 = min_word(ceiling - current, budget).
    ROM does a WORD subtraction; if current>ceiling it wraps high and min picks
    budget. In normal flow ceiling>=current (fields stay <= their cap)."""
    return min_word((ceiling - current) & 0xFFFF, budget)


def effect_dam(m: "M.Memory", fief: int) -> int:
    """effect_dam $87D8: output==0 -> 10000 (block); else sqrt_int(output)."""
    output = m.r16(fief + M.F_OUTPUT)
    return 0x2710 if output == 0 else sqrt_int(output)


def effect_grow(m: "M.Memory", fief: int, amount: int) -> int:
    """effect_grow $87F0 -- the gold->output grow leaf. NOTE: touches output,
    loyalty, dams ONLY; NEVER gold (that was the econ.grow divergence). Returns
    gain/2 (the develop-family productivity drain magnitude)."""
    if amount < 1:
        return 0
    output = m.r16(fief + M.F_OUTPUT)
    gain = math32_3arg(amount, 6 - m.skill, sqrt_int(output + amount)) << 1
    if gain == 0:
        gain = 1
    headroom = (m.r16(fief + M.F_HEADER) - output) & 0xFFFF
    if gain > headroom:
        gain = headroom
    # drain pct: flat 50 when gain/2 exceeds output, else (gain%-of-(gain+out))/2
    pctval = 100 if (gain // 2) > output else math32_2arg(gain, output)
    drain = pctval // 2
    loy = m.r16(fief + M.F_LOYALTY)
    dams = m.r16(fief + M.F_DAMS)
    m.w16(fief + M.F_LOYALTY, loy - pct_op(loy, drain))
    m.w16(fief + M.F_DAMS, dams - pct_op(dams, drain))
    m.w16(fief + M.F_OUTPUT, output + gain)
    return gain // 2


def effect_build(m: "M.Memory", fief: int, amount: int) -> int:
    """effect_build $88A6 -- the player's TOWN grow (sublinear sqrt curve, unlike
    the AI's linear town add). gain UNdoubled in the formula, doubled at the write
    (add_effect_gain_clamped(gain<<1)); drains WEALTH. NOT gold (caller debits)."""
    if amount < 1:
        return 0
    town = m.r16(fief + M.F_TOWN)
    gain = math32_3arg(amount, 6 - m.skill, sqrt_int(town + amount))
    if gain == 0:
        gain = 1
    cap = (m.r16(fief + M.F_HEADER) - town) & 0xFFFF
    if gain > cap:
        gain = cap
    pct = 100 if gain > town else math32_2arg(gain, town)
    w = m.r16(fief + M.F_WEALTH)
    m.w16(fief + M.F_WEALTH, w - pct_op(w, pct // 2))
    add_effect_gain_clamped(m, gain << 1, fief + M.F_TOWN)    # town += 2*gain (clamped)
    return gain


def develop_gain(m: "M.Memory", amount: int, stat_ptr: int, companion_ptr: int) -> int:
    """develop_gain $D8BA -- the paired-stat grow magnitude (give-peasants shape):
        gain = (amount*(6-skill_level)) / ( sqrt((stat+companion)/2) + sqrt(amount) )
    min 1 when amount>=1. Used by the loyalty/wealth caps below."""
    if amount < 1:
        return 0
    stat = m.r16(stat_ptr)
    comp = m.r16(companion_ptr)
    gain = math32_3arg(amount, 6 - m.skill, sqrt_int((stat + comp) // 2) + sqrt_int(amount))
    return 1 if gain == 0 else gain


def develop_gain_capped_loyalty(m: "M.Memory", fief: int, amount: int) -> int:
    """develop_gain_capped_loyalty $D8F2: develop_gain on (loyalty, companion=output),
    capped at header-loyalty."""
    gain = develop_gain(m, amount, fief + M.F_LOYALTY, fief + M.F_OUTPUT)
    cap = m.r16(fief + M.F_HEADER) - m.r16(fief + M.F_LOYALTY)
    return cap if gain > cap else gain


def develop_gain_capped_wealth(m: "M.Memory", fief: int, amount: int) -> int:
    """develop_gain_capped_wealth $D919: develop_gain on (wealth, companion=town),
    capped at header-wealth."""
    gain = develop_gain(m, amount, fief + M.F_WEALTH, fief + M.F_TOWN)
    cap = m.r16(fief + M.F_HEADER) - m.r16(fief + M.F_WEALTH)
    return cap if gain > cap else gain


def record_apply_two_grows(m: "M.Memory", fief: int, amount: int) -> int:
    """record_apply_two_grows $D940: loyalty += capped_loyalty; wealth += capped_wealth.
    (the "two grows" -- loyalty & wealth, NOT output.)"""
    m.w16(fief + M.F_LOYALTY, m.r16(fief + M.F_LOYALTY) + develop_gain_capped_loyalty(m, fief, amount))
    m.w16(fief + M.F_WEALTH, m.r16(fief + M.F_WEALTH) + develop_gain_capped_wealth(m, fief, amount))
    return m.r16(fief + M.F_WEALTH)


def apply_two_grows_const1_override(m: "M.Memory", fief: int, amount: int) -> int:
    """apply_two_grows_const1_override $8379: force skill_level=1 (max 6-skill_level
    multiplier) for two grows (loyalty+wealth), THEN debit `amount` gold (clamped
    >=0), restore skill_level. This is the AI's gold-sink + loy/wealth pump."""
    saved = m.skill                      # local11 = skill_level
    m.w16(M.SKILL_LEVEL, 1)                # skill_level = 1
    record_apply_two_grows(m, fief, amount)
    m.w16(fief + M.F_GOLD, max(0, m.s16(fief + M.F_GOLD) - amount))   # gold -= amount; if(<0)=0
    m.w16(M.SKILL_LEVEL, saved)            # restore
    return saved


def clamp_amount_to_province_max(m: "M.Memory", ptr: int) -> int:
    """clamp_amount_to_province_max $82AC: *ptr = min(SELECTED fief's header, *ptr);
    if (<0) 0. NOTE: caps against selected_province's header (not necessarily the
    record `ptr` lives in) -- faithful to the ROM quirk."""
    header = m.r16(m.cur_fief() + M.F_HEADER)
    v = min_word(header, m.r16(ptr))
    v = 0 if (v & 0x8000) else v          # signed (<0) -> 0
    m.w16(ptr, v)
    return v


def add_effect_gain_clamped(m: "M.Memory", amount: int, ptr: int) -> int:
    """add_effect_gain_clamped $887D: if the owner is flagged weak, halve `amount`
    (min 1); *ptr += amount; clamp to province max. Used by the dam handler."""
    val = amount
    if _fief_owner_weakness(m, m.selected):
        val = val // 2
        if val == 0:
            val = val + 1
    m.w16(ptr, m.r16(ptr) + val)
    return clamp_amount_to_province_max(m, ptr)


def apply_hire_unit_stats(m: "M.Memory", fief: int, count: int) -> int:
    """apply_hire_unit_stats $8BF4: blend `count` recruits' random morale/skill/arms
    into the fief by men-weight (the Hire dilution), then men += count. Reads
    men/arms BEFORE the men bump."""
    men = m.r16(fief + M.F_MEN)
    header = m.r16(fief + M.F_HEADER)
    arms = m.r16(fief + M.F_ARMS)
    m.w16(fief + M.F_MORALE,
          scaled_force_transfer(m.r16(fief + M.F_MORALE), m.rng_mod(20) + 40, count, men, header))
    m.w16(fief + M.F_SKILL,
          scaled_force_transfer(m.r16(fief + M.F_SKILL), m.rng_mod(20) + 60, count, men, header))
    m.w16(fief + M.F_ARMS,
          scaled_force_transfer(arms, m.rng_mod(10) + 50, count, arms, header))
    m.w16(fief + M.F_MEN, men + count)
    return m.r16(fief + M.F_MEN)


def effect_train(m: "M.Memory") -> int:
    """effect_train $958E: skill += (rng(20)+10)*4; +10 more if the daimyo's
    (+5 stat + +3 stat) > rng(10)+90. Operates on the SELECTED fief's skill ($7015)."""
    daimyo = m.fief_daimyo(m.selected)
    skill_addr = m.cur_fief() + M.F_SKILL
    m.w16(skill_addr, m.r16(skill_addr) + (((m.rng_mod(20) + 10) << 1) << 1))
    if (m.r8(daimyo + 5) + m.r8(daimyo + 3)) > (m.rng_mod(10) + 90):    # ROM reads +5,+3
        m.w16(skill_addr, m.r16(skill_addr) + 10)
    return 11


def relations_rng_predicate(m: "M.Memory", a: int, b: int) -> int:
    """relations_rng_predicate $8271: rng_mod(100) < relations(owner(a),owner(b),1)
    OR rng_mod(100) < relations(a,b,0). Both rolls always evaluated unless the
    first OR-term is true (C short-circuit). Used by the war commit to let good
    relations block an attack."""
    if m.rng_mod(100) < m.relations_matrix_get(m.fief_owner(a), m.fief_owner(b), 1):
        return 1
    return 1 if m.rng_mod(100) < m.relations_matrix_get(a, b, 0) else 0


# ---------------------------------------------------------------------------
# small accessor leaf used by add_effect_gain_clamped (mirrors $D972)
# ---------------------------------------------------------------------------
def _fief_owner_weakness(m: "M.Memory", idx: int) -> int:
    """fief_owner_weakness $D972 = daimyo_weakness_flag[fief_owner(idx)]."""
    return m.r8(M.DAIMYO_WEAKNESS_FLAG + m.fief_owner(idx))


# ===========================================================================
# Market + record-clamp leaves (bank1 / bank15) -- UI side-effects stubbed out
# ===========================================================================
def cycle_economy_rate(m: "M.Memory", which: int) -> None:
    """cycle_economy_rate $8A4E: nudge a market rate after a trade (the draw/cursor
    UI is dropped; only the rate mutation is game-relevant)."""
    if which == 0:
        v = m.r16(M.LOAN_RATE) + 1
        if v > 15:
            v = m.rng_mod(15)
        m.w16(M.LOAN_RATE, v)
    elif which == 1:                       # decrease exchange rate (floor at 1)
        gr = m.r16(M.GOLD_RICE_EXCHANGE)
        dec = (gr - 1) if gr <= 1 else 1
        m.w16(M.GOLD_RICE_EXCHANGE, gr - dec)
    elif which == 2:
        m.w16(M.GOLD_RICE_EXCHANGE, m.r16(M.GOLD_RICE_EXCHANGE) + 1)
    elif which == 3:
        m.w16(M.ARMS_BUY_PRICE_RATE, m.r16(M.ARMS_BUY_PRICE_RATE) + 1)
    elif which == 4:
        m.w16(M.GOLD_MEN_HIRE_RATE, m.r16(M.GOLD_MEN_HIRE_RATE) + 1)
    elif which == 5:
        m.w16(M.HIRE_GOLD_RATE, m.r16(M.HIRE_GOLD_RATE) + 1)


def effect_sell_rice_for_gold(m: "M.Memory", rice_amount: int) -> None:
    """effect_sell_rice_for_gold $8B0A (SELECTED fief): gold += muladddiv(rate, n);
    rice -= n; cycle_economy_rate(1)."""
    fief = m.cur_fief()
    rate = m.r16(M.GOLD_RICE_EXCHANGE)
    m.w16(fief + M.F_GOLD, m.r16(fief + M.F_GOLD) + math32_muladddiv(rate, rice_amount))
    m.w16(fief + M.F_RICE, m.r16(fief + M.F_RICE) - rice_amount)
    cycle_economy_rate(m, 1)


def clear_econ_stats_if_no_output(m: "M.Memory", idx: int) -> None:
    """clear_econ_stats_if_no_output $D7F7: output==0 -> wealth=0, loyalty=0."""
    fief = m.fief(idx)
    if m.r16(fief + M.F_OUTPUT) == 0:
        m.w16(fief + M.F_WEALTH, 0)
        m.w16(fief + M.F_LOYALTY, 0)


def clear_military_stats_if_no_men(m: "M.Memory", idx: int) -> None:
    """clear_military_stats_if_no_men $D815: men==0 -> arms=0, skill=0, morale=0."""
    fief = m.fief(idx)
    if m.r16(fief + M.F_MEN) == 0:
        m.w16(fief + M.F_ARMS, 0)
        m.w16(fief + M.F_SKILL, 0)
        m.w16(fief + M.F_MORALE, 0)


def cap_fief_stats(m: "M.Memory", idx: int) -> None:
    """cap_fief_stats $D836: clamp every fief field (+0..+22) to header and >=0;
    dams to <=100; daimyo stat bytes (>235 -> 0, else >210 -> 210); then zero
    quality stats if no men / no output. The clamp that caps gold at header."""
    fief = m.fief(idx)
    header = m.r16(fief + M.F_HEADER)
    for off in range(0, 24, 2):            # fields +0..+22 (gold..arms)
        v = min_word(m.r16(fief + off), header)
        if v & 0x8000:                     # signed (<0) -> 0
            v = 0
        m.w16(fief + off, v)
    m.w16(fief + M.F_DAMS, min_word(m.r16(fief + M.F_DAMS), 100))
    daimyo = m.fief_daimyo(idx)
    for i in range(6):
        b = m.r8(daimyo + i)
        if b > 235:
            b = 0
        elif b > 210:
            b = 210
        m.w8(daimyo + i, b)
    clear_military_stats_if_no_men(m, idx)
    clear_econ_stats_if_no_output(m, idx)


# ===========================================================================
# The rules of the live revisit, line for line from source/4-c. na1sim.oracle runs each against
# the ROM's routine with the same scripted draws, moduli included.
# ===========================================================================
SPRING_DECAY_FIELDS = (M.F_LOYALTY, M.F_WEALTH, M.F_MORALE)


def consume_province_army_upkeep(m: "M.Memory", fief: int) -> None:
    """consume_province_army_upkeep $A15B: men/2 from gold and rice; if min(gold, rice) cannot
    cover it, upkeep is that minimum and men fall to twice it."""
    upkeep = m.r16(fief + M.F_MEN) // 2
    affordable = min_word(m.r16(fief + M.F_GOLD), m.r16(fief + M.F_RICE))
    if affordable < upkeep:
        upkeep = affordable
        m.w16(fief + M.F_MEN, affordable << 1)
    m.w16(fief + M.F_GOLD, m.r16(fief + M.F_GOLD) - upkeep)
    m.w16(fief + M.F_RICE, m.r16(fief + M.F_RICE) - upkeep)


def drift_daimyo_luck(m: "M.Memory", daimyo: int) -> None:
    """drift_daimyo_luck: luck + rng_mod(11) - 5 on a byte, unclamped; cap_fief_stats repairs an
    underflow in the same turn."""
    p = m.daimyo(daimyo) + M.D_LUCK
    m.w8(p, (m.r8(p) + m.rng_mod(11) - 5) & 0xFF)


def per_period_fief_update(m: "M.Memory") -> None:
    """The head of per_period_fief_daimyo_update_driver $A30D, every season: each index's luck
    drifts, and a tax rate of 90 - skill_level or more loses a tenth of that fief's loyalty."""
    for i in range(m.r16(M.SCENARIO_FIEF_COUNT)):
        drift_daimyo_luck(m, i)
        if m.r8(M.FIEF_TAX_RATE + i) >= 90 - m.skill:
            f = m.fief(i)
            m.w16(f + M.F_LOYALTY, pct_op(m.r16(f + M.F_LOYALTY), 90))


def uprising_rebels_win_roll(m: "M.Memory", idx: int) -> bool:
    """uprising_rebels_win_roll $9595: the loyal share of the men is
    min(morale, 100)*3/10 + min(charisma, 200)*3/20 + rng_mod(31) + 10 percent; the larger side
    wins, a tie goes to the rebels on rng_mod(2) == 0."""
    f = m.fief(idx)
    men = m.r16(f + M.F_MEN)
    share = (min_word(100, m.r16(f + M.F_MORALE)) * 3 // 10
             + min_word(200, m.r8(m.fief_daimyo(idx) + M.D_CHARISMA)) * 3 // 20
             + m.rng_mod(31) + 10)
    loyal = pct_op(men, share)
    rebels = men - loyal
    if loyal == rebels:
        return m.rng_mod(2) == 0
    return loyal < rebels


def revolt_loyal_men_won(m: "M.Memory", idx: int) -> None:
    """The loyal-win arm of resolve_revolt_event_on_listed_fiefs ($981C-$9868): morale rises by
    pct_op(morale, rng_mod(10) + 30) + rng_mod(30) + 30, men fall by pct_op(men, rng_mod(20) + 10).
    The ROM draws the rng_mod(30) first: the C prints operands in place, not in evaluation order."""
    f = m.fief(idx)
    morale = m.r16(f + M.F_MORALE)
    flat = m.rng_mod(30)
    m.w16(f + M.F_MORALE, morale + pct_op(morale, m.rng_mod(10) + 30) + flat + 30)
    men = m.r16(f + M.F_MEN)
    m.w16(f + M.F_MEN, men - pct_op(men, m.rng_mod(20) + 10))


def event_boost_province_wealth_loyalty(m: "M.Memory", idx: int) -> None:
    """event_boost_province_wealth_loyalty $9F57 (AI fiefs, each Spring): on rng_mod(2) != 0,
    wealth += rng_mod(10) + charisma/10 and loyalty += rng_mod(40) + charisma/10. No cap here."""
    bonus = m.r8(m.fief_daimyo(idx) + M.D_CHARISMA) // 10
    if m.rng_mod(2):
        f = m.fief(idx)
        m.w16(f + M.F_WEALTH, m.r16(f + M.F_WEALTH) + m.rng_mod(10) + bonus)
        m.w16(f + M.F_LOYALTY, m.r16(f + M.F_LOYALTY) + m.rng_mod(40) + bonus)


def spring_age_and_decay(m: "M.Memory") -> None:
    """per_turn_age_daimyo_decay_health_and_province_stats, less its two relations decays (the sim
    does not run them). It runs once a year, on season 0 of the driver's switch. Every record ages,
    not only the living lords'. An AI fief takes the boon; a human fief, past skill_level 1, loses
    ONE rng_mod(skill_level) from loyalty, wealth and morale alike. Words and bytes wrap here;
    cap_fief_stats repairs them in the same turn. In 1560 none of that runs: a human on fief 24
    (50 fiefs) or fief 16 (17 fiefs) has that fief's gold set to 100 ($7271 / $71A1)."""
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    if m.year == 1560:
        for fief, count in ((24, 50), (16, 17)):
            if m.province_ai_state(fief) and n == count:
                m.w16(m.fief(fief) + M.F_GOLD, 100)
        return
    for i in range(n + 3):
        d = m.daimyo(i)
        m.w8(d + M.D_AGE, (m.r8(d + M.D_AGE) + 1) & 0xFF)
        m.w8(d + M.D_HEALTH, (m.r8(d + M.D_HEALTH) - 1) & 0xFF)
    for i in range(n):
        if not m.province_ai_state(i):
            event_boost_province_wealth_loyalty(m, i)
        elif m.skill != 1:
            decay = m.rng_mod(m.skill)
            f = m.fief(i)
            for off in SPRING_DECAY_FIELDS:
                m.w16(f + off, m.r16(f + off) - decay)


def _roll_failed(m: "M.Memory", stat: int) -> bool:
    """square_over_2025_probability_roll: min(stat, 50)^2 < rng_mod(2025). 45 or more cannot fail."""
    s = 50 if stat > 50 else stat
    return s * s < m.rng_mod(2025)


def _is_honganji(m: "M.Memory", fief: int) -> bool:
    return m.fief_owner(fief) == (3 if m.r16(M.SCENARIO_FIEF_COUNT) == 17 else 20)


def riot_eligible(m: "M.Memory", fief: int) -> bool:
    """ai_event_eligibility_check_loyalty_variant $9DA3: the first failed roll of loyalty, 100 - tax
    and charisma, or a 1-in-1000, then a 1-in-4 with output, more than 2 men, not Honganji, owned."""
    f = m.fief(fief)
    m.w16(M.BATTLE_DEFENDING, fief)

    def gate():
        return (m.s16(f + M.F_OUTPUT) > 0 and m.s16(f + M.F_MEN) > 2 and not _is_honganji(m, fief)
                and m.province_ai_state(fief) != M.EMPTY and not m.rng_mod(4))
    if _roll_failed(m, m.s16(f + M.F_LOYALTY)):
        return gate()
    if _roll_failed(m, 100 - m.r8(M.FIEF_TAX_RATE + fief)):
        return gate()
    if _roll_failed(m, m.r8(m.fief_daimyo(fief) + M.D_CHARISMA)):
        return gate()
    return False if m.rng_mod(1000) else gate()


def revolt_eligible(m: "M.Memory", fief: int) -> bool:
    """ai_event_eligibility_check_morale_variant $9E21: a failed roll of morale or charisma, or a
    1-in-1000 (1-in-20 for Honganji), with more than 2 men, owned."""
    f = m.fief(fief)
    m.w16(M.BATTLE_DEFENDING, fief)
    if (_roll_failed(m, m.s16(f + M.F_MORALE))
            or _roll_failed(m, m.r8(m.fief_daimyo(fief) + M.D_CHARISMA))
            or not m.rng_mod(20 if _is_honganji(m, fief) else 1000)):
        return m.s16(f + M.F_MEN) > 2 and m.province_ai_state(fief) != M.EMPTY
    return False


def riot_contest(m: "M.Memory", fief: int) -> bool:
    """resolve_riot_uprising_contest: an AI or non-capital fief. sqrt(output) + sqrt(wealth) +
    rng_mod(20) + 10 rioters against the men, a tie on a coin. -> True if the rioters won; else men
    and output each lose rng_mod(50) + 10 percent. (The fief's fall is the caller's.)"""
    f = m.fief(fief)
    rioters = sqrt_int(m.r16(f + M.F_OUTPUT)) + sqrt_int(m.r16(f + M.F_WEALTH)) + m.rng_mod(20) + 10
    men = m.r16(f + M.F_MEN)
    won = (m.rng_mod(2) == 0) if rioters == men else men < rioters
    if won:
        return True
    m.w16(f + M.F_MEN, men - pct_op(men, m.rng_mod(50) + 10))
    m.w16(f + M.F_OUTPUT, m.r16(f + M.F_OUTPUT) - pct_op(m.r16(f + M.F_OUTPUT), m.rng_mod(50) + 10))
    return False


def _gift_gain(stat: int, partner: int, amount: int, skill: int, cap: int) -> int:
    """develop_gain_capped: amount*(6-skill) / (sqrt((stat+partner)/2) + sqrt(amount)), at least 1.
    The riot payment's form: a sum of roots, and not doubled, unlike a Give."""
    g = math32_3arg(amount, 6 - skill, sqrt_int((stat + partner) // 2) + sqrt_int(amount)) if amount >= 1 else 0
    g = g or (1 if amount >= 1 else 0)
    return min(g, cap - stat)


def human_riot(m: "M.Memory", fief: int, pay: bool) -> bool:
    """The human capital's arm of resolve_riot_event_on_listed_fiefs. With gold, and not resting, the
    player is asked: paying gives ALL the gold to the peasants, and it settles the riot only if
    loyalty ends above 25 and rose by more than 5. -> True if settled; False stages the battle."""
    f = m.fief(fief)
    gold = m.r16(f + M.F_GOLD)
    if not gold or m.r8(M.REST_TURNS + m.selected_province_owner()) or not pay:
        return False
    before, cap, sk = m.r16(f + M.F_LOYALTY), m.r16(f + M.F_HEADER), m.skill
    m.w16(f + M.F_LOYALTY, before + _gift_gain(before, m.r16(f + M.F_OUTPUT), gold, sk, cap))
    w = m.r16(f + M.F_WEALTH)
    m.w16(f + M.F_WEALTH, w + _gift_gain(w, m.r16(f + M.F_TOWN), gold, sk, cap))
    m.w16(f + M.F_GOLD, 0)
    after = m.s16(f + M.F_LOYALTY)
    return not (after <= 25 or not (after - before > 5))


def spawn_uprising_force(m: "M.Memory", is_uprising: bool) -> None:
    """spawn_uprising_force_from_province, on battle_defending_province. A riot (is_uprising) raises
    the fief's OUTPUT as the rebel army, and if charisma is under rng_mod(skill) + 70, up to half the
    men join it. A revolt takes 20-89% of the men, or 25-34 from nowhere with 20 men or fewer. Either
    takes 50-80% of the rice. The force goes in slot 50, stats at 40-59% of the fief."""
    fief = m.r16(M.BATTLE_DEFENDING)
    f = m.fief(fief)
    out, men, rice = f + M.F_OUTPUT, f + M.F_MEN, f + M.F_RICE
    if is_uprising:
        if m.s16(out) <= 0:
            m.w16(out, m.r16(men) // 2)
            m.w16(men, m.r16(men) - m.r16(out))
        if m.s16(men) <= 0:
            m.w16(men, m.r16(out) // 2)
            m.w16(out, m.r16(out) - m.r16(men))
        if m.r8(m.fief_daimyo(fief) + M.D_CHARISMA) < m.rng_mod(m.skill) + 70:
            moved = pct_op(m.r16(men), m.rng_mod(50))
            m.w16(out, m.r16(out) + moved)
            m.w16(men, m.r16(men) - moved)
        m.w16(M.WAR_ATTACKER_MEN, m.r16(out))
        taken = pct_op(m.r16(rice), m.rng_mod(31) + 50)
        m.w16(M.WAR_ATTACKER_RICE, taken)
        m.w16(rice, m.r16(rice) - taken)
    elif m.s16(men) > 20:
        force = pct_op(m.r16(men), m.rng_mod(70) + 20)
        m.w16(M.WAR_ATTACKER_MEN, force)
        m.w16(men, m.r16(men) - force)
        taken = pct_op(m.r16(rice), m.rng_mod(31) + 50)
        m.w16(M.WAR_ATTACKER_RICE, taken)
        m.w16(rice, m.r16(rice) - taken)
    else:
        force = m.rng_mod(10) + 25
        m.w16(M.WAR_ATTACKER_MEN, force)
        m.w16(M.WAR_ATTACKER_RICE, force)
    m.w16(M.WAR_ATTACKER_GOLD, 0)
    m.w8(M.AI_TURN_FLAGS, m.r8(M.AI_TURN_FLAGS) | (64 if is_uprising else 32))
    m.w8(M.WAR_SIDE_STATE_FLAG, 0)
    dst = m.fief(50)
    for i in range(8):
        m.w16(dst + 2 * i, pct_op(m.r16(f + 2 * i), m.rng_mod(20) + 40))
    m.w16(dst + 16, m.r16(M.WAR_ATTACKER_MEN))
    m.w16(dst + 18, m.r16(f + M.F_HEADER) - m.r16(f + M.F_MORALE))
    m.w16(dst + 20, m.rng_mod((m.skill + 1) * 10))
    m.w16(dst + 22, m.rng_mod((m.skill + 1) * 10))
    m.w16(dst + 12, m.r16(f + M.F_HEADER) - m.r16(f + M.F_LOYALTY))
    m.selected = 50


def random_daimyo_stat_increment(m: "M.Memory") -> None:
    """random_daimyo_stat_increment: an AI fief, 1 in 10, adds 2 to one of the lord's five abilities
    at random; health is held to 200."""
    if not m.province_ai_state(m.selected) and not m.rng_mod(10):
        d = m.fief_daimyo(m.selected)
        k = d + 1 + m.rng_mod(5)
        m.w8(k, (m.r8(k) + 2) & 0xFF)
        if m.r8(d + 1) >= 200:
            m.w8(d + 1, 200)


def dedup_owners(m: "M.Memory", fiefs) -> int:
    """dedup_owners $8DE1: one fief per owner, first seen kept, into deduped_owner_list ($FF
    ended). -> the count. (The ROM reads past the terminator on an empty list: a caller's guard.)"""
    kept = []
    for j in fiefs:
        if all(m.fief_owner(k) != m.fief_owner(j) for k in kept):
            kept.append(j)
    for i, j in enumerate(kept):
        m.w8(M.DEDUPED_OWNER_LIST + i, j)
    m.w8(M.DEDUPED_OWNER_LIST + len(kept), 0xFF)
    return len(kept)


def find_first_own_fief(m: "M.Memory") -> int:
    """find_first_own_fief $8BE6: the first CAPITAL held by the selected fief's owner, by index;
    0 when that owner has none (the ROM returns the loop's false, not a fief)."""
    owner = m.selected_province_owner()
    for i in range(m.r16(M.SCENARIO_FIEF_COUNT)):
        if m.is_capital(i) and m.fief_owner(i) == owner:
            return i
    return 0


def auction_ownerless_fief_to_bidders(m: "M.Memory", owner_count: int, human_bid):
    """auction_ownerless_fief_to_bidders $8C75 over deduped_owner_list, for the fief in
    battle_defending_province. -> None when the fief goes to a new daimyo (fewer than 2 owners
    around it, or no bid), else (winner_fief, best_bid, price).

    Each bidder acts from its owner's capital. An AI bids rng_mod(gold), but only if its gold
    beats the last bid. A human (not resting, gold > 0) answers human_bid(m, gold): the amount, or
    None to pass. `bid` is one variable across the whole loop and is never reset, so a passing
    bidder leaves it standing, and the winner pays that LAST bid: a later, lower bid sets the
    price, which can never exceed best_bid."""
    if owner_count < 2:
        return None
    best_bid = bid = 0
    winner = None
    p = M.DEDUPED_OWNER_LIST
    while m.r8(p) != 0xFF:
        m.selected = m.r8(p)
        m.selected = find_first_own_fief(m)
        sel = m.selected
        gold = m.s16(m.fief(sel) + M.F_GOLD)
        if m.province_ai_state(sel):
            if not m.r8(M.REST_TURNS + m.selected_province_owner()) and gold > 0:
                answer = human_bid(m, gold)
                if answer is not None:
                    bid = answer
        elif gold > bid:
            bid = m.rng_mod(gold)
        if best_bid < bid:
            best_bid, winner = bid, sel
        p += 1
    if not best_bid:
        return None
    target = m.r16(M.BATTLE_DEFENDING)
    m.w8(M.PROVINCE_AI_STATE + target, 5 if m.province_ai_state(winner) else 0)
    m.w8(M.FIEF_IS_CAPITAL + target, 0)
    m.w8(M.FIEF_TO_DAIMYO_MAP + target, m.fief_owner(winner))
    f = m.fief(winner)
    m.w16(f + M.F_GOLD, m.r16(f + M.F_GOLD) - bid)
    return winner, best_bid, bid


def resolve_bribe_enemy_unit(m: "M.Memory", slot: int, amount: int) -> None:
    """resolve_bribe_enemy_unit $9E73 (bank 2). The briber pays first, win or lose. Score =
    rng_mod(6 - skill_level) + own morale + own charisma, against enemy morale + charisma +
    2 * skill_level. A win with amount / unit >= 1 turns pct_op(unit, 100*(s-e)/(2s-e)) men to the
    briber's slot 0, the briber's total held to 9999; a win that cannot pay one gold a man costs
    the enemy morale instead (6 - skill_level from a human briber, skill_level from the AI).
    combat_casualty_skip gates the contest and both outcomes set it."""
    side = m.cur_combat_side
    own_res, enemy_side = m.side_resource_ptr(side), side ^ 1
    enemy_res = m.side_resource_ptr(enemy_side)
    m.w16(own_res + M.SR_GOLD, m.r16(own_res + M.SR_GOLD) - amount)
    own = m.r16(M.BATTLE_DEFENDING if side else M.SELECTED_PROVINCE)
    enemy = m.r16(M.BATTLE_DEFENDING if enemy_side else M.SELECTED_PROVINCE)
    score = (m.rng_mod(6 - m.skill) + m.r16(m.fief(own) + M.F_MORALE)
             + m.r8(m.fief_daimyo(own) + M.D_CHARISMA))
    enemy_score = (m.r16(m.fief(enemy) + M.F_MORALE) + m.r8(m.fief_daimyo(enemy) + M.D_CHARISMA)
                   + (m.skill << 1))
    if m.r8(M.COMBAT_CASUALTY_SKIP) or score <= enemy_score:
        return
    unit = m.unit_strength_ptr(enemy_side, slot)
    if amount // m.r16(unit) > 0:
        turned = pct_op(m.r16(unit), math32_2arg(score - enemy_score, score))
        if m.r16(own_res + M.SR_MEN) + turned > 9999:
            turned = 9999 - m.r16(own_res + M.SR_MEN)
        if not turned:
            return
        m.w16(unit, m.r16(unit) - turned)
        m.w16(enemy_res + M.SR_MEN, m.r16(enemy_res + M.SR_MEN) - turned)
        slot0 = m.unit_strength_ptr(side, 0)
        m.w16(slot0, m.r16(slot0) + turned)
        m.w16(own_res + M.SR_MEN, m.r16(own_res + M.SR_MEN) + turned)
    else:
        f = m.fief(enemy) + M.F_MORALE
        m.w16(f, m.r16(f) - ((6 - m.skill) if m.province_ai_state(own) else m.skill))
        if m.s16(f) <= 0:
            m.w16(f, 0)
    m.w8(M.COMBAT_CASUALTY_SKIP, 1)


def develop_stat(m: "M.Memory", f: int, field: int, partner: int, amount: int, double: bool) -> None:
    """develop_loyalty $891D / develop_wealth $896F / develop_morale $89C1: the gain is
    amount*(6-skill)/sqrt((stat+partner)/2 + amount), at least 1, held to stat_cap - stat before
    the write doubles it (loyalty and wealth) or not (morale). No other field pays for it."""
    stat, cap = m.r16(f + field), m.r16(f + M.F_HEADER)
    gain = max(1, (amount * (6 - m.skill)) // sqrt_int((stat + m.r16(f + partner)) // 2 + amount))
    gain = min(gain, cap - stat)
    m.w16(f + field, stat + (gain << 1 if double else gain))


def driver_give(m: "M.Memory", to_peasants: bool, gold: bool, amount: int) -> int:
    """driver_give $AA1F, the player answering the two prompts and typing `amount` (held to
    1..what the fief has). Gold and rice give alike. Peasants take the whole amount twice over,
    into loyalty AND wealth; men take it into morale. Every Give adds 1 charisma. Refused with no
    output (peasants) or no men, with nothing to give, and at the limit: (wealth + loyalty) / 2 >=
    cap for peasants, morale >= cap for men."""
    f = m.cur_fief()
    if m.s16(f + (M.F_OUTPUT if to_peasants else M.F_MEN)) <= 0:
        return 0
    level = ((m.r16(f + M.F_WEALTH) + m.r16(f + M.F_LOYALTY)) // 2 if to_peasants
             else m.r16(f + M.F_MORALE))
    if level >= m.r16(f + M.F_HEADER):
        return 0
    source = f + (M.F_GOLD if gold else M.F_RICE)
    have = m.s16(source)
    if have <= 0:
        return 0
    amount = max(1, min(amount, have))
    m.w16(source, have - amount)
    if to_peasants:
        develop_stat(m, f, M.F_LOYALTY, M.F_OUTPUT, amount, True)
        develop_stat(m, f, M.F_WEALTH, M.F_TOWN, amount, True)
    else:
        develop_stat(m, f, M.F_MORALE, M.F_MEN, amount, False)
    d = m.fief_daimyo(m.selected) + M.D_CHARISMA
    m.w8(d, (m.r8(d) + 1) & 0xFF)
    return 1


def driver_train(m: "M.Memory") -> int:
    """driver_train $A637: refused at stat_cap; with no men the military stats clear; else
    effect_train, skill held to stat_cap."""
    f = m.cur_fief()
    if m.r16(f + M.F_SKILL) >= m.r16(f + M.F_HEADER):
        return 0
    if m.s16(f + M.F_MEN) <= 0:
        clear_military_stats_if_no_men(m, m.selected)
        return 0
    effect_train(m)
    m.w16(f + M.F_SKILL, min(m.r16(f + M.F_SKILL), m.r16(f + M.F_HEADER)))
    return 1


def cap_arms_at_index(m: "M.Memory", idx: int, fief: int) -> None:
    """cap_arms_at_index $DFFE: the unit-type share in slot 2 of the fief's five is held to
    arms/50 + 20; the excess moves to slot 0."""
    cap = m.r16(fief + M.F_ARMS) // 50 + 20
    base = M.PROVINCE_UNIT_TYPE_PCT + idx * 5
    if m.r8(base + 2) > cap:
        m.w8(base, m.r8(base) + m.r8(base + 2) - cap)
        m.w8(base + 2, cap)


def commit_arms_record(m: "M.Memory", idx: int, buf, cancel: int) -> int:
    """commit_arms_record_from_buffer bank 1 $ABBD: Assign's commit. Writes the editor's five rows
    into the fief's unit-type split ($76A9 + idx*5) only if the pool is empty (`cancel` is the
    leftover units_delta) and some row changed; returns 1 then, else 0. (The cutscene is UI.)"""
    base = M.PROVINCE_UNIT_TYPE_PCT + idx * 5
    changed = any(m.r8(base + i) != buf[i] for i in range(5))
    if cancel or not changed:
        return 0
    for i in range(5):
        m.w8(base + i, buf[i] & 0xFF)
    return 1


def assign_reachable(m: "M.Memory", idx: int, split) -> bool:
    """The rows effect_assign bank 1 $AC11 lets the player reach: points only move between rows (the
    pool starts at 0, and a non-empty pool cancels the commit), a row goes down only while above
    its floor (row 0: 1, the rest: 0), and row 2 goes up only while under arms/50 + 20."""
    base = M.PROVINCE_UNIT_TYPE_PCT + idx * 5
    cur = [m.r8(base + i) for i in range(5)]
    cap = m.r16(m.fief(idx) + M.F_ARMS) // 50 + 20
    return (len(split) == 5 and sum(split) == sum(cur) and split[0] >= 1 and min(split) >= 0
            and split[2] <= max(cur[2], cap))


def driver_assign(m: "M.Memory", idx: int, split) -> int:
    """driver_assign bank 1 $AD67, the player entering `split` in the editor and pressing A: needs
    soldiers and 30 gold; debits the 30 only if the commit happens. Returns 1 if it did (the
    command spent the turn), 0 if refused (unreachable split, no change, no men, no gold)."""
    f = m.fief(idx)
    if m.s16(f + M.F_MEN) <= 0 or m.r16(f + M.F_GOLD) < 30 or not assign_reachable(m, idx, split):
        return 0
    if commit_arms_record(m, idx, list(split), 0):
        m.w16(f + M.F_GOLD, m.r16(f + M.F_GOLD) - 30)
        return 1
    return 0


def effect_hire_men(m: "M.Memory", fief: int, amount: int) -> int:
    """effect_hire_men $A553, the player typing `amount` (held to the prompt's 1..max). Costs
    (rate*amount + 9)/10 gold, blends the recruits in, and nudges the hire rate up one."""
    cap, men = m.r16(fief + M.F_HEADER), m.r16(fief + M.F_MEN)
    rate = m.r16(M.GOLD_MEN_HIRE_RATE)
    most = ratio_times10_capped(m.r16(fief + M.F_GOLD), rate, cap - men)
    if most <= 0:
        return 0
    amount = max(1, min(amount, most))
    m.w16(fief + M.F_GOLD, m.r16(fief + M.F_GOLD) - math32_muladddiv(rate, amount))
    apply_hire_unit_stats(m, fief, amount)
    cap_arms_at_index(m, m.selected, fief)
    cycle_economy_rate(m, 4)
    clamp_amount_to_province_max(m, fief + M.F_MEN)
    return 1


def effect_buy_rice(m: "M.Memory", fief: int, amount: int) -> int:
    """effect_buy_rice $A068, the player typing `amount` (held to the prompt's 1..max). Costs
    (exchange*amount + 9)/10 gold and nudges the exchange rate."""
    if not m.r16(m.cur_fief() + M.F_GOLD):
        return 0
    rate = m.r16(M.GOLD_RICE_EXCHANGE)
    most = ratio_times10_capped(m.r16(fief + M.F_GOLD), rate, m.r16(fief + M.F_HEADER) - m.r16(fief + M.F_RICE))
    if most <= 0:
        return 0
    amount = max(1, min(amount, most))
    m.w16(fief + M.F_GOLD, m.r16(fief + M.F_GOLD) - math32_muladddiv(rate, amount))
    m.w16(fief + M.F_RICE, m.r16(fief + M.F_RICE) + amount)
    clamp_amount_to_province_max(m, fief + M.F_RICE)
    cycle_economy_rate(m, 2)
    return 1


# ===========================================================================
# smoke: certified pure-math values + an effect_grow that does NOT touch gold
# ===========================================================================
def _smoke():
    # pct_op certified split-by-10 values (ROADMAP)
    assert pct_op(51, 55) == 27, pct_op(51, 55)
    assert pct_op(136, 64) == 86, pct_op(136, 64)
    assert pct_op(123, 100) == 123                    # p==100 identity
    # the math32 folds
    assert math32_3arg(30, 4, 6) == 20
    assert math32_2arg(40, 60) == 40                  # 40*100/100
    assert math32_muladddiv(10, 5) == 5               # (50+9)/10
    assert ratio_times10_capped(100, 50, 999) == 20   # 100*10/50
    assert scale_div10_capcheck(700, 150, 20000) == 10500
    assert scale_div10_capcheck(700, 150, 100) == -1      # cap tripped (0xFFFF)
    assert scale_div10_capcheck(10, 10, 10) == 10         # exactly affordable: the ROM allows it
    assert math32_3arg(5, 7, 0) == -1                     # the c == 0 guard

    m = M.Memory()
    f = m.fief(5)
    m.selected = 5
    m.w16(M.SKILL_LEVEL, 2)
    m.w16(f + M.F_OUTPUT, 100)
    m.w16(f + M.F_HEADER, 1900)
    m.w16(f + M.F_LOYALTY, 80)
    m.w16(f + M.F_DAMS, 40)
    m.w16(f + M.F_GOLD, 500)
    gold_before = m.r16(f + M.F_GOLD)
    ret = effect_grow(m, f, 30)
    # effect_grow MUST NOT debit gold (the econ.grow divergence we're killing)
    assert m.r16(f + M.F_GOLD) == gold_before, "effect_grow debited gold!"
    # output grew, loyalty/dams drained
    assert m.r16(f + M.F_OUTPUT) > 100
    assert m.r16(f + M.F_LOYALTY) <= 80 and m.r16(f + M.F_DAMS) <= 40
    assert ret >= 0

    # effect_send headroom
    assert effect_send(1900, 100, 500) == 500         # budget-limited
    assert effect_send(150, 100, 500) == 50           # headroom-limited

    # apply_two_grows_const1_override drains gold by `amount`, restores skill_level
    m.w16(f + M.F_GOLD, 200)
    apply_two_grows_const1_override(m, f, 120)
    assert m.r16(f + M.F_GOLD) == 80                   # 200 - 120
    assert m.skill == 2                                # skill_level restored
    print("vmprims smoke: PASS  (pct_op/math32 certified; effect_grow gold-neutral; "
          "override drains gold + restores skill_level)")


if __name__ == "__main__":
    _smoke()
