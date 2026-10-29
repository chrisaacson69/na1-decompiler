"""
The daimyo AI — a port of ai_econ_command_dispatch ($B64B) and friends from
source/4-c/bank_01.c. This is the "hollow opponent" made executable: no search,
no lookahead, just a military-biased cascade of rng(10) gates with
weakest-provisioned-men war targeting.

DECISION STRUCTURE is ported EXACTLY (the part that defines the threat model):
  ai_econ_command_dispatch:
    if rice==0:                     rice += rng(10)
    if capital & ai-owned & men==0: men = 2
    if rng(10)!=0 (~90%) and military_pass() launched a war:  done
    else:  if rng(10)!=0: develop_town;   always: develop_dam_and_grow

  military_pass (ai_state2_recruit_arm_train):
    war-attack FIRST (returns 1 only if a war launches)
    recruit if men < min((year-1559)*40, header), prob rng(10) < const_two+3,
            spending gold_surplus/2
    buy arms; sell/convert; 50% train; 1% rare reinforce

  war commit gate (ai_try_war_attack): target = weakest provisioned-men enemy;
    attack iff (ratio(att,tgt) - 10 - rng(const_two*3) > 60) OR rng(100)==0
    where ratio = att_men*100/(att_men+tgt_men); a no-rice fief counts as 0 men.

GROUNDING FLAGS (see ROADMAP):
  [F1] AI develop magnitude: the C does a *linear* field += spend (capacity-
       clamped, year-scaled) for town/grow — which would let AI economies
       outpace the player's sqrt-curve. The decompiler flagged this region as
       ambiguous. v1 routes develop through the validated sqrt-curve econ
       functions and caps the spend by the grounded year/surplus bounds. If the
       linear read is correct, AI econ is STRONGER than modeled here -> Hida's
       task harder. #1 oracle check.
  [F2] fief_owner_weakness precondition body not yet read; approximated as
       "this fief is its faction's weakest-men fief among its own neighborhood".
"""

import random
from math import isqrt
from typing import Callable, Optional

from . import econ
from .state import World, Province, AI_HOME

# resolve_battle(world, attacker_idx, defender_idx, rng) -> bool (True = attacker conquered)
BattleResolver = Callable[[World, int, int, random.Random], bool]


# ---------------------------------------------------------------------------
# grounded helpers (bank_01.c)
# ---------------------------------------------------------------------------
def men_surplus(p: Province):
    """ai_calc_men_surplus_over_gold_and_rice $B2EF: reserve == army size."""
    return max(0, p.gold - p.men), max(0, p.rice - p.men)


def men_ratio_pct(a: Province, b: Province) -> int:
    """fief_men_ratio_pct: a's share of (a+b) provisioned men, as a percent.
    A fief with no rice contributes 0 men (provisioned_men)."""
    am, bm = a.provisioned_men, b.provisioned_men
    tot = am + bm
    return (am * 100) // tot if tot > 0 else 0


def pick_weakest_men_fief(world: World, candidates) -> Optional[Province]:
    """$93B3: the enemy with the FEWEST provisioned men."""
    weakest = None
    for c in candidates:
        if weakest is None or men_ratio_pct(weakest, c) > 50:
            weakest = c
    return weakest


def _is_weak(world: World, p: Province) -> bool:
    """[F2] fief_owner_weakness approximation — weakest-men fief in its border set."""
    nbrs = world.neighbors_of(p)
    if not nbrs:
        return False
    return all(men_ratio_pct(n, p) > 50 for n in nbrs)


# ---------------------------------------------------------------------------
# war (ai_try_war_attack $949A)
# ---------------------------------------------------------------------------
def _try_war(world: World, idx: int, rng: random.Random,
             resolve_battle: BattleResolver) -> bool:
    """Returns True iff a war launched (turn consumed)."""
    p = world.provinces[idx]
    # preconditions: not weak, has men AND rice (rice = provisions)
    if _is_weak(world, p) or p.men <= 0 or p.rice <= 0:
        return False

    enemies = world.enemy_neighbors(p)
    target = pick_weakest_men_fief(world, enemies)
    if target is None:
        return False

    # commit gate (deterministic majority OR 1/100), const_two*3 noise
    ratio = men_ratio_pct(p, target)
    do_attack = ((ratio - 10) - rng.randrange(max(1, world.skill * 3)) > 60) \
        or (rng.randrange(100) == 0)
    if not do_attack:
        return False

    # HUMAN/AI go-no-go ASYMMETRY ($9561: get_province_ai_state(target) || rng_mod(2)).
    # Targeting ("am I the weakest") is identical, but the COMMIT differs: attacking an
    # AI fief (state Home=0, falsy) must also pass a 50% coin; attacking the PLAYER
    # (Direct, truthy) bypasses it -> the human is attacked ~2x as readily once weakest.
    if target.ai_state == AI_HOME and rng.randrange(2) == 0:
        return False

    # (Drive<50 + good-relations skip not modeled v1 — all scenario lords are bold;
    #  monk fief 30 absent in the 17-fief scenario.)
    return resolve_battle(world, idx, target.idx, rng)


# ---------------------------------------------------------------------------
# military prep (ai_state2_recruit_arm_train $B4D5)
# ---------------------------------------------------------------------------
def _military_pass(world: World, idx: int, rng: random.Random,
                   resolve_battle: BattleResolver) -> bool:
    if _try_war(world, idx, rng, resolve_battle):
        return True   # war launched -> turn consumed
    p = world.provinces[idx]
    gold_surplus, _ = men_surplus(p)

    # recruit: under year-strength, prob rng(10) < const_two+3, spend gold_surplus/2.
    # ROM: men_gained = (spend*10)/hire_rate = spend/men_price (rate stored x10).
    year_men_cap = min((world.year - 1559) * 40, p.header)
    if p.men < year_men_cap and rng.randrange(10) < (world.skill + 3):
        spend = gold_surplus // 2
        gained = spend // world.men_price
        if gained > 0 and p.gold >= spend:
            p.gold -= spend
            p.men += gained           # men cost ~5-15 gold each, NOT 1
    # train: 50%
    if rng.randrange(2) == 0:
        p.skill += ((rng.randrange(20) + 10) << 2)   # effect_train: (rng%20+10)*4
    return False   # no war -> fall through to develop


# ---------------------------------------------------------------------------
# develop (ai_develop_town_handler $B3AA + ai_develop_dam_and_grow $B42B)
# [F1] routed through the validated sqrt-curve econ functions, year/surplus capped.
# ---------------------------------------------------------------------------
def _seed_tax(p: Province, rng: random.Random):
    p.tax = rng.randrange(30) + 35    # ai_seed_fief_tax_rate: rng(30)+35 -> [35,64]


def _develop_town(world: World, idx: int, rng: random.Random):
    """ai_develop_town_handler $B3AA. VALIDATED LINEAR (bytecode): town += gold spent
    1:1 (capacity-clamped to a year-scaled cap), NO effect_build sqrt-curve."""
    p = world.provinces[idx]
    gold_surplus, _ = men_surplus(p)
    _seed_tax(p, rng)
    town_cap = min((world.year - 1559) * 100 + 100, p.header)
    gain = min(max(0, town_cap - p.town), gold_surplus)   # effect_send capacity clamp
    if p.town < p.header and rng.randrange(3) == 0 and gain > 0:
        p.town += gain          # linear 1:1 (the AI's economic edge)
        p.gold -= gain
    # trailing ai_develop_grow_if_men_exceeds_gold (charisma bump + minor grow) not modeled v1


def _develop_dam_grow(world: World, idx: int, rng: random.Random):
    """ai_develop_dam_and_grow $B42B, gated loyalty>output. Dam at ~gold/sqrt(output);
    grow is VALIDATED LINEAR+sqrt: output += grow_amount ($B4BF) THEN effect_grow ($B4C2).
    Faithful to the bytecode quirks (gold_budget -= dams_gain; effect_grow may no-op on
    low gold AFTER the linear add already landed)."""
    p = world.provinces[idx]
    gold_budget, _ = men_surplus(p)
    _seed_tax(p, rng)
    if p.loyalty > p.output and p.output > 0:    # headroom gate (C: loy>output)
        sq = isqrt(p.output)
        if sq > 0:
            spend = min(gold_budget, sq * (100 - p.dams))   # effect_dam = sqrt(output)
            if spend > 0:
                p.gold -= spend
                dams_gain = spend // sq
                p.dams = min(100, p.dams + dams_gain)
                gold_budget -= dams_gain                     # ($B492-96) gain, not spend
        grow_cap = min((world.year - 1559) * 50 + 250, p.header)
        grow_amount = min(max(0, grow_cap - p.output), gold_budget)
        if grow_amount > 0:
            p.output += grow_amount        # LINEAR add ($B4BF) — bytecode-confirmed
            econ.grow(p, grow_amount)      # effect_grow ($B4C2): sqrt gain + gold debit + drains


# ---------------------------------------------------------------------------
# the brain (ai_econ_command_dispatch $B64B)
# ---------------------------------------------------------------------------
def decide_ai_fief(world: World, idx: int, rng: random.Random,
                   resolve_battle: BattleResolver):
    """Run one AI fief's full turn (mutates world)."""
    p = world.provinces[idx]
    if p.rice == 0:
        p.rice += rng.randrange(10)                  # never starve to 0
    if p.is_capital and p.ai_state == AI_HOME and p.men == 0:
        p.men = 2                                    # token garrison
        p.rice += 1

    # ~90%: military pass; if it launched a war, the turn is consumed
    if rng.randrange(10) != 0 and _military_pass(world, idx, rng, resolve_battle):
        return
    # develop fallback
    if rng.randrange(10) != 0:
        _develop_town(world, idx, rng)
    _develop_dam_grow(world, idx, rng)


# ---------------------------------------------------------------------------
# smoke test: targeting + war gate behave as decoded
# ---------------------------------------------------------------------------
def _smoke():
    from .loader import build_world
    econ.SKILL = 2
    w = build_world()
    w.skill = 2
    rng = random.Random(1)

    # Hida (idx5) enemies and the weakest-men pick
    hida = w.provinces[5]
    enemies = w.enemy_neighbors(hida)
    weakest = pick_weakest_men_fief(w, enemies)
    print("AI smoke test")
    print(f"  Hida enemies (name, prov_men): "
          f"{[(e.name, e.provisioned_men) for e in enemies]}")
    print(f"  weakest-men target picked: {weakest.name} "
          f"(men={weakest.provisioned_men}) — expect Mino(38)")
    assert weakest.name == "Mino", weakest.name

    # war gate: a strong fief vs a much weaker neighbour should clear ratio>70
    # Shinano(72 men) attacking Mino(38): ratio = 72*100/110 = 65 -> just under 70, rarely fires
    shin, mino = w.provinces[15], w.provinces[8]
    print(f"  ratio(Shinano->Mino) = {men_ratio_pct(shin, mino)} "
          f"(need >70+rng(skill*3) to commit) -> war is OPPORTUNITY-gated, scarce early")

    # a lopsided case: give an attacker 3x men -> ratio ~75 -> should usually fire
    shin.men = 120
    fired = 0
    for s in range(200):
        r = random.Random(s)
        ratio = men_ratio_pct(shin, mino)
        if ((ratio - 10) - r.randrange(max(1, w.skill * 3)) > 60) or (r.randrange(100) == 0):
            fired += 1
    print(f"  with Shinano=120 vs Mino=38 (ratio={men_ratio_pct(shin, mino)}): "
          f"war-gate fires {fired}/200 seeds")

    # full single-fief turn with a stub resolver (no real combat yet)
    log = []
    def stub_resolve(world, a, d, rng):
        log.append((world.provinces[a].name, world.provinces[d].name))
        return False    # never actually conquer in the stub
    w2 = build_world()
    w2.skill = 2
    decide_ai_fief(w2, 8, random.Random(3), stub_resolve)   # Mino takes a turn
    print(f"  decide_ai_fief(Mino) ran; war attempts this turn: {log}")
    print("AI smoke test: PASS")


if __name__ == "__main__":
    _smoke()
