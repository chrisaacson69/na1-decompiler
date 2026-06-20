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
- `const_two` (the skill dial) is a live global at memmap.CONST_TWO; routines
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


def math32_3arg(a: int, b: int, c: int) -> int:
    """math32_3arg $D6B8 = (a*b)/c.  (c==0 guarded by callers via sqrt+amount>0.)"""
    return (a * b) // c if c else 0


def math32_2arg(a: int, b: int) -> int:
    """math32_2arg $D6DE = (a*100)/(a+b) -- a's percentage weight of (a+b)."""
    return (a * 100) // (a + b) if (a + b) else 0


def math32_muladddiv(rate: int, amount: int) -> int:
    """math32_muladddiv $8303 = (rate*amount + 9)/10  (round-up-ish /10 scale)."""
    return (rate * amount + 9) // 10


def pct_op(arg1: int, arg2: int) -> int:
    """pct_op $D70D -- the percentage primitive (split-by-10; NOT floor(b*p/100)).
    Certified: pct_op(51,55)=27, pct_op(136,64)=86."""
    if arg2 == 100:
        return arg1
    return (((arg2 % 10) * (arg1 // 10)) // 10
            + ((arg1 % 10) * arg2) // 100
            + (arg2 // 10) * (arg1 // 10))


def ratio_times10_capped(a: int, b: int, c: int) -> int:
    """ratio_times10_capped $8357 = min((a*10)/b, c)."""
    return min_word((a * 10) // b if b else 0xFFFF, c)


def scale_div10_capcheck(a: int, b: int, c: int) -> int:
    """scale_div10_capcheck $8327 = ((a*b)/10 >= c) ? 0xFFFF : (a*b)/10."""
    v = (a * b) // 10
    return 0xFFFF if v >= c else v


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
        gain = (amount*(6-const_two)) / ( sqrt((stat+companion)/2) + sqrt(amount) )
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
    """apply_two_grows_const1_override $8379: force const_two=1 (max 6-const_two
    multiplier) for two grows (loyalty+wealth), THEN debit `amount` gold (clamped
    >=0), restore const_two. This is the AI's gold-sink + loy/wealth pump."""
    saved = m.skill                      # local11 = const_two
    m.w16(M.CONST_TWO, 1)                # const_two = 1
    record_apply_two_grows(m, fief, amount)
    m.w16(fief + M.F_GOLD, max(0, m.s16(fief + M.F_GOLD) - amount))   # gold -= amount; if(<0)=0
    m.w16(M.CONST_TWO, saved)            # restore
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
    assert scale_div10_capcheck(700, 150, 99999) == 10500
    assert scale_div10_capcheck(700, 150, 100) == 0xFFFF  # cap tripped

    m = M.Memory()
    f = m.fief(5)
    m.selected = 5
    m.w16(M.CONST_TWO, 2)
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

    # apply_two_grows_const1_override drains gold by `amount`, restores const_two
    m.w16(f + M.F_GOLD, 200)
    apply_two_grows_const1_override(m, f, 120)
    assert m.r16(f + M.F_GOLD) == 80                   # 200 - 120
    assert m.skill == 2                                # const_two restored
    print("vmprims smoke: PASS  (pct_op/math32 certified; effect_grow gold-neutral; "
          "override drains gold + restores const_two)")


if __name__ == "__main__":
    _smoke()
