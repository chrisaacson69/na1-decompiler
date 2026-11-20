"""econ_lab.py - the best development path for one fief, on the cartridge's formulas (Chris, 2026-11-20, #97).

Chris: *start with an econ sim with a longer horizon; Asakura's output-2 trap is real, but maybe it should
not have gotten that bad. A sim can then be turned into a function: given loyalty / wealth / output / town /
dams / rice / gold, what is the best MIRR. We cannot plan for natural disasters, but we can find the best way
out using math.*

One fief, every turn on development, the real commands (policy.give_peasants -> driver_give $AA1F,
grow_output -> effect_grow $87F0, build_town -> effect_build $88A6, build_dam, set_tax $999A), the real year
(marks reset at the start of Summer, $A066; the harvest at the start of Fall, harvest_fief with the mean
roll, and its upkeep), no disasters. A beam search over H seasons maximises the plan's value at rate r a
season: the harvests (gold + rice at the exchange rate) less what the plan spends, discounted, plus at the
horizon the treasury left and the last harvest as an annuity. Compared with 'peasants only' (every turn, all
the gold over the upkeep to the peasants: the ladder's and MIRR's habit).

  py -3.14 -m na1sim.econ_lab --state loyalty,wealth,output,town,dams,rice,gold,men,header,tax [--years 5]
"""
from __future__ import annotations

import argparse

from . import forecast, game, memmap as M, policy, setup

FIEF = 4


def _income_now(m, idx):
    """The harvest the live stats would bring (the marks read as the live values): (gold, rice)."""
    f = m.fief(idx)
    tax = m.r8(M.FIEF_TAX_RATE + idx)
    pct = lambda v, p: v * p // 100
    lo, we, out, da, town, hdr = (m.r16(f + o) for o in (M.F_LOYALTY, M.F_WEALTH, M.F_OUTPUT, M.F_DAMS, M.F_TOWN, M.F_HEADER))
    if lo <= 0:
        return 0, 0
    base = pct(pct(lo, 40), tax) + pct(we, tax)
    return min(base + pct(town, tax), hdr), min(base + pct(pct(out, da), tax), hdr)


def _price(m):
    return (m.r16(M.GOLD_RICE_EXCHANGE) or 10) / 10


ACTIONS = ("pass", ("give", 1.0), ("give", .5), ("give_rice", 1.0), ("grow", 1.0), ("grow", .5),
           ("build", 1.0), ("build", .5), ("dam", 1.0), ("tax", 55), ("export", 1.0))


def act(m, idx, a):
    """Apply one command; -> (gold spent, rice spent)."""
    f = m.fief(idx)
    gold, rice, men = m.r16(f + M.F_GOLD), m.r16(f + M.F_RICE), m.r16(f + M.F_MEN)
    spare = max(0, gold - men // 2 - 1)
    if a == "pass":
        return 0, 0
    kind, x = a
    if kind == "export":                        # Send the surplus to the rest of the empire (valued at par)
        g = int(spare * x)
        r_ = max(0, rice - men - men // 2)
        m.w16(f + M.F_GOLD, gold - g)
        m.w16(f + M.F_RICE, rice - r_)
        return -g, -r_                          # negative spend: value leaves to be used elsewhere
    if kind == "tax":
        policy.set_tax(m, idx, x)
        return 0, 0
    if kind == "give_rice":
        amt = int(max(0, rice - men - men // 2) * x)
        if amt >= 1:
            policy.give_peasants(m, idx, amt)
        return 0, rice - m.r16(f + M.F_RICE)
    amt = int(spare * x)
    if amt < 1:
        return 0, 0
    if kind == "give":
        policy.give_peasants(m, idx, amt, gold=True)
    elif kind == "grow":
        policy.grow_output(m, idx, amt)
    elif kind == "build":
        policy.build_town(m, idx, amt)
    elif kind == "dam":
        policy.build_dam(m, idx, amt)
    return gold - m.r16(f + M.F_GOLD), 0


def setup_fief(state, skill=2, seed=0):
    lo, we, out, town, dams, rice, gold, men, hdr, tax = state
    m = setup.build_board(skill=skill, seed=seed, player_fief=FIEF)
    f = m.fief(FIEF)
    for off, v in ((M.F_HEADER, hdr), (M.F_LOYALTY, lo), (M.F_WEALTH, we), (M.F_OUTPUT, out), (M.F_TOWN, town),
                   (M.F_DAMS, dams), (M.F_RICE, rice), (M.F_GOLD, gold), (M.F_MEN, men)):
        m.w16(f + off, v)
    m.w8(M.FIEF_TAX_RATE + FIEF, tax)
    game.reset_marks(m)
    return m


def run(m, idx, season0, H, r, plan_fn=None, beam=60):
    """Beam search (plan_fn None) or a fixed policy plan_fn(m, idx, season) -> action. -> (value, plan, trace)."""
    p = _price(m)
    ann = 1 / max(1e-6, (1 + r) ** 4 - 1)
    nodes = [(0.0, forecast.snapshot(m), [], [])]
    for k in range(H):
        s = (season0 + k) % 4
        disc = (1 + r) ** -k
        nxt = []
        for val, snap, plan, trace in nodes:
            forecast.restore(m, snap)
            if s == 1:
                game.reset_marks(m)
            inc = 0.0
            if s == 2:                          # the real gain: the treasury after the clamp and the upkeep
                f = m.fief(idx)
                before = m.r16(f + M.F_GOLD) + m.r16(f + M.F_RICE) * p
                game.harvest_fief(m, idx, forecast.Mean())
                inc = m.r16(f + M.F_GOLD) + m.r16(f + M.F_RICE) * p - before
            base = forecast.snapshot(m)
            for a in ([plan_fn(m, idx, s)] if plan_fn else ACTIONS):
                forecast.restore(m, base)
                gs, rs = act(m, idx, a)
                v = val + disc * (inc - gs - rs * p)
                f = m.fief(idx)
                g, ri = _income_now(m, idx)
                est = v + disc * (m.r16(f + M.F_GOLD) + m.r16(f + M.F_RICE) * p + ann * (g + ri * p))
                nxt.append((est, v, forecast.snapshot(m), plan + [a], trace + [(k, s, a, inc, _stats(m, idx))]))
        nxt.sort(key=lambda x: -x[0])
        seen, nodes = set(), []
        for est, v, snap, plan, trace in nxt:
            key = trace[-1][4]
            if key in seen:
                continue
            seen.add(key)
            nodes.append((v, snap, plan, trace))
            if len(nodes) >= beam:
                break
    best = None
    for v, snap, plan, trace in nodes:
        forecast.restore(m, snap)
        f = m.fief(idx)
        g, ri = _income_now(m, idx)
        total = v + (1 + r) ** -H * (m.r16(f + M.F_GOLD) + m.r16(f + M.F_RICE) * p + ann * (g + ri * p))
        if best is None or total > best[0]:
            best = (total, plan, trace)
    return best


def _stats(m, idx):
    f = m.fief(idx)
    return tuple(m.r16(f + o) for o in (M.F_LOYALTY, M.F_WEALTH, M.F_OUTPUT, M.F_TOWN, M.F_DAMS, M.F_GOLD, M.F_RICE)) + (m.r8(M.FIEF_TAX_RATE + idx),)


def peasants_only(m, idx, s):
    return ("give", 1.0)


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--state", default="1737,1737,2,44,71,1700,800,400,1740,55",
                    help="loyalty,wealth,output,town,dams,rice,gold,men,header,tax (default: Asakura 4/3013, year 30)")
    ap.add_argument("--years", type=int, default=5)
    ap.add_argument("--r", type=float, default=0.08)
    ap.add_argument("--season", type=int, default=0, help="the starting season (0 Spring)")
    ap.add_argument("--beam", type=int, default=60)
    ap.add_argument("--skill", type=int, default=2)
    a = ap.parse_args()
    state = tuple(int(x) for x in a.state.split(","))
    H = a.years * 4
    m = setup_fief(state, a.skill)
    best = run(m, FIEF, a.season, H, a.r, beam=a.beam)
    m = setup_fief(state, a.skill)
    base = run(m, FIEF, a.season, H, a.r, plan_fn=peasants_only)
    print(f"state {state}; {a.years} years at r {a.r} a season")
    print(f"  peasants only: value {base[0]:.0f}")
    print(f"  best plan:     value {best[0]:.0f}  ({100 * (best[0] / max(1, base[0]) - 1):+.0f}%)")
    print("  season-by-season (best): action -> loyalty, wealth, output, town, dams, gold, rice, tax")
    for k, s, act_, inc, st in best[2]:
        print(f"   {k:2} {'SpSuFaWi'[2 * s:2 * s + 2]} {str(act_):16} {'harvest %d' % inc if inc else '':12} {st}")
    print("  final (peasants only):", base[2][-1][4])


if __name__ == "__main__":
    main()
