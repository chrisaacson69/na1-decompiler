"""
Economy engine — bytecode-grounded fief math.

Source of truth: appendix-formulas.md (emulator-certified to the digit), NOT
tools/econ_sim.py. econ_sim is a useful single-fief sibling but it simplified
two things that this engine gets right:

  1. pct_op: econ_sim used naive (b*p)//100. The REAL ROM primitive ($D70D) is
     a split-by-10 sum that does NOT always equal floor(b*p/100) — e.g.
     pct_op(51,55) = 27 (ROM) vs 28 (naive). The appendix harvest worked
     example only reconciles with the split-by-10 version. We implement that.
  2. Grow drain-pct: econ_sim used (50*gain)//(out+gain); the ROM computes
     (100*gain//(gain+out))//2 with a flat-50 ceiling when gain/2 > output.

Validate with: py -3 -m na1sim.validate  (reproduces the appendix Mikawa example).

All functions MUTATE the passed Province (the turn loop owns the copies).
"""

from math import isqrt
from typing import Tuple

from .state import Province, Daimyo, AI_HOME

# const_two / skill-level difficulty dial ($6D63); 1-5, game default 2.
# The develop family scales gain by (6 - SKILL).
SKILL = 2


def _dev_mult() -> int:
    return 6 - SKILL


# ---------------------------------------------------------------------------
# pct_op ($D70D) — the percentage primitive, split-by-10 EXACTLY as the ROM.
# NOT equal to floor(b*p/100) in general.
# ---------------------------------------------------------------------------
def pct_op(b: int, p: int) -> int:
    if b < 0 or p < 0:
        return 0
    return ((b // 10) * (p // 10)
            + ((b % 10) * p) // 100
            + ((p % 10) * (b // 10)) // 10)


# ---------------------------------------------------------------------------
# Develop family (Grow / Build / Give-Peasants / Dam / Tax)
# ---------------------------------------------------------------------------
def grow(p: Province, amount: int) -> Province:
    """gold -> output; drains loyalty AND dams by a live pct. (appendix §1)"""
    if amount < 1 or p.gold < amount or p.output >= p.header:
        return p
    p.gold -= amount
    gain = 2 * ((amount * _dev_mult()) // isqrt(p.output + amount))
    gain = max(1, min(gain, p.header - p.output))
    pct = 50 if (gain // 2 > p.output) else (100 * gain // (gain + p.output)) // 2
    p.loyalty -= pct_op(p.loyalty, pct)
    p.dams -= pct_op(p.dams, pct)
    p.output += gain
    return p


def build(p: Province, amount: int) -> Province:
    """gold -> town; drains wealth by a live pct. (appendix §2)"""
    if amount < 1 or p.gold < amount or p.town >= p.header:
        return p
    p.gold -= amount
    g = (amount * _dev_mult()) // isqrt(p.town + amount)   # UNdoubled
    g = max(1, min(g, p.header - p.town))
    pct = 50 if (g > p.town) else (100 * g // (g + p.town)) // 2
    p.wealth -= pct_op(p.wealth, pct)
    p.town = min(p.header, p.town + 2 * g)                 # doubled at the write
    return p


def give_peasants(p: Province, amount: int) -> Province:
    """rice -> loyalty + wealth, each paired with its productivity twin. (§3)"""
    if amount < 1 or p.rice < amount:
        return p
    p.rice -= amount
    loy_gain = 2 * ((amount * _dev_mult()) // isqrt((p.output + p.loyalty) // 2 + amount))
    wlt_gain = 2 * ((amount * _dev_mult()) // isqrt((p.town + p.wealth) // 2 + amount))
    p.loyalty = min(100, p.loyalty + loy_gain)
    p.wealth = min(100, p.wealth + wlt_gain)
    return p


def dam(p: Province, amount_gold: int) -> Province:
    """gold -> dams; gain inversely proportional to sqrt(output). (Dam §)"""
    if p.output == 0 or p.dams >= 100 or p.gold == 0 or amount_gold < 1:
        return p
    sq = isqrt(p.output)
    max_spend = min(p.gold, (100 - p.dams) * sq // 2)
    amount = min(amount_gold, max_spend)
    if amount < 1:
        return p
    p.gold -= amount
    gain = max(1, (2 * amount) // sq)
    p.dams = min(100, p.dams + gain)
    return p


def give_men(p: Province, amount: int) -> Province:
    """Give-Men / give_morale ($89C1): resource -> morale on the men<->morale
    pair (develop-family template). [FLAG: drains rice, parallel to give_peasants;
    the source-resource (rice vs gold) wants an emulator check.]"""
    if amount < 1 or p.rice < amount:
        return p
    p.rice -= amount
    gain = 2 * ((amount * _dev_mult()) // isqrt((p.men + p.morale) // 2 + amount))
    p.morale = min(100, p.morale + gain)
    return p


# Recruit men for gold at the market rate (gold_men_hire_rate $6E11, ~5->15).
# Quality dilutes toward recruit baselines (morale 50, skill 70, arms 55).
def hire(p: Province, gold_spend: int, price: int = 5) -> Province:
    if gold_spend < 1 or p.gold < gold_spend:
        return p
    n = gold_spend // price
    if n < 1:
        return p
    p.gold -= n * price
    tot = p.men + n
    p.morale = (p.morale * p.men + 50 * n) // tot
    p.skill = (p.skill * p.men + 70 * n) // tot
    p.arms = (p.arms * p.men + 55 * n) // tot
    p.men = tot
    return p


def set_tax(p: Province, new_tax: int, daimyo: Daimyo = None) -> Province:
    """Set tax; drains loyalty & wealth by |delta|%; costs 1 Charisma. (Tax §)"""
    if new_tax == p.tax or new_tax < 0 or new_tax > 100:
        return p
    delta = abs(new_tax - p.tax)
    p.loyalty -= pct_op(p.loyalty, delta)
    p.wealth -= pct_op(p.wealth, delta)
    p.tax = new_tax
    if daimyo is not None:
        daimyo.charisma -= 1
    return p


# ---------------------------------------------------------------------------
# Harvest (Fall) — appendix §4. Split: a pure income calc (testable against the
# appendix worked example) + the full per-fief Fall step (subsidy/debt/upkeep).
# ---------------------------------------------------------------------------
def fief_income(p: Province, charisma: int, rng_g: int, rng_r: int) -> Tuple[int, int]:
    """Gold & rice income BEFORE debt/upkeep. rng_g/rng_r are the two
    independent harvest rolls, each in [0, pct_op(charisma//2, tax)]."""
    base = pct_op(pct_op(p.lm, 40), p.tax) + pct_op(p.wm, p.tax)
    gold = base + pct_op(p.town, p.tax) + rng_g
    rice = base + pct_op(pct_op(p.om, p.dm), p.tax) + rng_r
    return min(gold, p.header), min(rice, p.header)


def harvest_fief(p: Province, daimyo: Daimyo, rng) -> Tuple[int, int]:
    """Full Fall step for one fief, in ROM order (appendix §4):
    AI subsidy -> income (gated on loyalty>0) -> debt repay -> MEN/2 upkeep
    (with starvation cull) -> clamp. Returns (gold_income, rice_income)."""
    # 2. AI-only gold/output subsidy (rubber-band)
    if p.ai_state == AI_HOME:
        p.gold += rng.randint(0, 9) + daimyo.charisma // 10
        if rng.randint(0, 1) == 0:                       # 50% coin
            p.output += rng.randint(0, 9) + daimyo.charisma // 10

    # 3. income, gated on loyalty>0
    gy = ry = 0
    if p.loyalty > 0:
        ceil = pct_op(daimyo.charisma // 2, p.tax)       # rng in [0, ceil]
        rng_g = rng.randint(0, ceil) if ceil > 0 else 0
        rng_r = rng.randint(0, ceil) if ceil > 0 else 0
        gy, ry = fief_income(p, daimyo.charisma, rng_g, rng_r)
        p.gold += gy
        p.rice += ry

    # 4. auto-repay debt from new gold
    pay = min(p.gold, p.debt)
    p.gold -= pay
    p.debt -= pay

    # 5. army upkeep MEN/2 from gold AND rice; starvation culls men
    upkeep = p.men // 2
    afford = min(p.gold, p.rice)
    if afford < upkeep:
        p.men = afford * 2
        upkeep = afford
    p.gold -= upkeep
    p.rice -= upkeep

    # 6. clamp
    p.gold = max(0, min(p.gold, p.header))
    p.rice = max(0, min(p.rice, p.header))
    return gy, ry
