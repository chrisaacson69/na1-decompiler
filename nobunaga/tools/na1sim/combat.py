"""
Off-screen battle resolver — resolve_siege_assault_outcome ($8DFD) +
the AI commit ai_commit_attack_deduct_resources ($9046) + conquest cleanup
apply_conquest_outcome ($E03C). Sources: 21-combat-resolution.md, bank_01.c.

Two entry points share one core resolver:
  resolve_offscreen(world, atk, def, rng)  -- an AI war (commits SURPLUS troops)
  resolve_uprising(world, fief, rng)       -- a revolt (rebels vs the garrison)

GROUNDED commit (was "full mobilization" — wrong):
  attack_budget = min(2*rice, men, gold)            # $9094
  commit = pct_op(attack_budget, rng(20)+50)        # 50-69% of budget ($90DD)
  home.men/gold -= commit ; home.rice -= rice_share # leaves a garrison
So the attacker keeps a home garrison; the CONQUERED fief gets only the committed
fraction -> it's left weak and re-conquerable (the "Mino changes hands several
times on turn 1" dynamic), while the attacker's home fief stays defended.

Strength (off-screen; only Drive matters):
  men*(2 + [+1 attacker | +1 defender-on-castle]) + arms + skill + morale
  + 10% own morale to the higher-Drive lord.  Higher wins; winner absorbs half.

FLAGS: [C1] defender +1 only on a capital. [C3] winner absorbs floor(loser/2).
[C4] capital capture -> faction collapse + lord eliminated. [U1] uprising rebel
fraction = 50% of the garrison (magnitude wants an emulator check).
"""

import random
from . import econ
from .state import World, Province, Daimyo, AI_HOME, AI_DIRECT


def _math32_2arg(a: int, b: int) -> int:
    return (100 * a) // (a + b) if (a + b) > 0 else 0


def _blend(stat_a, men_a, stat_b, men_b):
    tot = men_a + men_b
    return (stat_a * men_a + stat_b * men_b) // tot if tot > 0 else stat_a


def _shift_lords(winner: Daimyo, loser: Daimyo):
    """daimyo_stat_transfer $DF3D: winner +1 Drive/Cha/IQ, loser -1 each."""
    winner.drive += 1
    winner.charisma += 1
    winner.iq += 1
    loser.drive = max(0, loser.drive - 1)
    loser.charisma = max(0, loser.charisma - 1)
    loser.iq = max(0, loser.iq - 1)


def _collapse_faction(world, loser_owner, winner_owner):
    winner_is_player = any(p.owner == winner_owner and p.ai_state == AI_DIRECT
                           for p in world.provinces)
    for p in world.provinces:
        if p.owner == loser_owner:
            p.owner = winner_owner
            p.ai_state = AI_DIRECT if winner_is_player else AI_HOME
            p.tax = min(p.tax, 30)
    world.daimyos[loser_owner].alive = False


def _quality(arms, skill):
    """ROM ($8E7D): (arms/2 + skill/2) << 1 — floored-even arms+skill."""
    return ((arms // 2) + (skill // 2)) << 1


def _do_conquest(world, atk_owner, atk_lord, c_men, c_gold, c_rice,
                 a_arms, a_skill, a_morale, d: Province, d_lord, rng):
    """apply_conquest_outcome: the attacker's committed army garrisons d,
    absorbing half the defenders; both sides' carried resources sum in."""
    surviving_def = d.men // 2
    new_men = c_men + surviving_def
    d.morale = _blend(a_morale, c_men, d.morale, surviving_def)
    d.skill = _blend(a_skill, c_men, d.skill, surviving_def)
    d.arms = _blend(a_arms, c_men, d.arms, surviving_def)
    d.men = new_men
    d.gold += c_gold
    d.rice += c_rice
    capital_fell = d.is_capital
    winner_is_player = any(p.owner == atk_owner and p.ai_state == AI_DIRECT
                           for p in world.provinces)
    d.owner = atk_owner
    d.ai_state = AI_DIRECT if winner_is_player else AI_HOME
    d.is_capital = False
    d.tax = min(d.tax, 30)
    if atk_lord is not None and d_lord is not None:
        _shift_lords(winner=atk_lord, loser=d_lord)
    if capital_fell:
        # GROUNDED escape ($8F6C): if the lord still holds another fief, they
        # relocate the capital iff rng_mod(drive//10) != 0 -> P = (D-1)/D with
        # D = drive//10. ~80-90% for a normal-drive lord, so capital captures
        # rarely collapse a MULTI-fief faction; a single-fief clan has nowhere
        # to flee and is eliminated.
        remaining = [p for p in world.provinces if p.owner == d_lord.id]
        D = max(1, d_lord.drive // 10)
        if remaining and rng.randrange(D) != 0:
            max(remaining, key=lambda p: p.men).is_capital = True   # relocate seat
        else:
            _collapse_faction(world, loser_owner=d_lord.id, winner_owner=atk_owner)


def resolve_offscreen(world: World, atk_idx: int, def_idx: int,
                      rng: random.Random) -> bool:
    """An AI war. Commits the attacker's SURPLUS, resolves, returns True iff
    the attacker conquered def_idx. Home fief keeps its garrison."""
    a = world.provinces[atk_idx]
    d = world.provinces[def_idx]
    al = world.daimyos[a.owner]
    dl = world.daimyos[d.owner]

    # ---- commit (ai_commit_attack_deduct_resources $9046) ----
    budget = min(2 * a.rice, a.men, a.gold)
    if budget < 5:
        return False
    if min(d.rice, d.men) > budget:           # $909D: don't commit under a bigger defender
        return False
    commit = econ.pct_op(budget, rng.randrange(20) + 50)   # 50-69% of budget
    if commit < 1:
        return False
    c_men = c_gold = commit
    if _math32_2arg(a.rice, commit) > 55:
        c_rice = commit
    else:
        c_rice = min(a.rice - 1, econ.pct_op(commit, rng.randrange(10) + 50))
    a.men -= c_men
    a.gold -= c_gold
    a.rice -= max(0, c_rice)

    # ---- resolve ($8E7D/$8EA4) ----
    # attacker men-mult = 2, +1 on a 50% coin when attacking from a capital
    # (war_side_state_flag&128); defender men-mult = 2 + is_capital.
    atk_cap_bonus = 1 if (a.is_capital and rng.randrange(2) == 1) else 0
    a_str = (2 + atk_cap_bonus) * c_men + _quality(a.arms, a.skill) + a.morale
    d_str = (2 + (1 if d.is_capital else 0)) * d.men + _quality(d.arms, d.skill) + d.morale
    # +10% morale to the higher-Drive lord; a tie goes to the attacker ($8E02)
    if al.drive < dl.drive:
        d_str += econ.pct_op(d.morale, 10)
    else:
        a_str += econ.pct_op(a.morale, 10)

    if a_str > d_str:
        _do_conquest(world, a.owner, al, c_men, c_gold, max(0, c_rice),
                     a.arms, a.skill, a.morale, d, dl, rng)
        return True
    # repelled: defender absorbs half the committed attackers (the rest are lost)
    d.men += c_men // 2
    _shift_lords(winner=dl, loser=al)
    return False


def resolve_uprising(world: World, fief_idx: int, rng: random.Random) -> bool:
    """A revolt: part of the garrison rebels and fights the rest. Returns True
    iff the rebels won (fief lost). [U1] rebel fraction = 50% of men."""
    p = world.provinces[fief_idx]
    if p.men <= 2:
        return False
    rebels = p.men // 2                       # [U1]
    garrison = p.men - rebels
    rebel_str = rebels * 2 + _quality(p.arms, p.skill) + p.morale
    garr_str = garrison * (2 + (1 if p.is_capital else 0)) + _quality(p.arms, p.skill) + p.morale
    if rebel_str > garr_str:
        # revolt succeeds -> the lord loses the fief (capital -> faction collapse)
        if p.is_capital:
            _collapse_faction(world, loser_owner=p.owner, winner_owner=-1)  # -1 = rebels/neutral
        else:
            p.owner = -1
            p.ai_state = AI_HOME
        return True
    # rebels crushed: fief loses the rebel men + a loyalty hit
    p.men = garrison
    p.loyalty -= econ.pct_op(p.loyalty, rng.randrange(10) + 10)   # 10-20% dock
    return False


# ---------------------------------------------------------------------------
def _smoke():
    from .loader import build_world
    rng = random.Random(0)

    # surplus commit: a strong attacker conquers but KEEPS a home garrison
    w = build_world()
    shin, mino = w.provinces[15], w.provinces[8]
    shin.men = 150
    home0 = shin.men
    won = resolve_offscreen(w, 15, 8, rng)
    print("combat smoke test")
    print(f"  Shinano(150) vs Mino(38): won={won}, Shinano home men "
          f"{home0}->{w.provinces[15].men} (KEEPS a garrison now), "
          f"Mino(captured) men={w.provinces[8].men}")
    assert won and w.provinces[15].men > 0, "attacker must keep a home garrison"
    assert w.provinces[8].owner == w.daimyos[15].id

    # uprising: Mino (morale 21) rebels
    w2 = build_world()
    m = w2.provinces[8]
    print(f"  Mino pre-revolt: men={m.men} morale={m.morale} loyalty={m.loyalty}")
    lost = resolve_uprising(w2, 8, random.Random(2))
    print(f"  Mino revolt result: rebels_won={lost}, men now {w2.provinces[8].men}, "
          f"owner={'rebels/neutral' if w2.provinces[8].owner == -1 else w2.provinces[8].owner}")
    print("combat smoke test: PASS")


if __name__ == "__main__":
    _smoke()
