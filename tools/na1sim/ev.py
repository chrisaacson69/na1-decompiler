"""An expected-value player for a lone fief (Chris, 2026-11-11, #45-#46): every command is chosen by
the survival it buys over the next HORIZON seasons, priced from the formulas, not from a rule order.

The parts (#45):
  * revolt, from the formulas: the uprising branch (0.75, Summer 0.375 behind the typhoon) x the
    planner gate (1 - 0.97^live fiefs) x the revolt-or-riot coin (1/2) x eligibility
    (square_over_2025 on morale or charisma, or 1 in 1000) x the staged battle he loses (REVOLT_LOSS,
    measured: morale does not enter it);
  * invasion: each neighbour that would pick him and can pay (reaction.threats, the ROM's own
    selection) attacks with P_ATTACK a season (measured, 300 Saito games), daimyo-led on a coin from
    a capital, committing its budget x 60-89% (led) or 50-69%; he holds by the odds table
    (na1sim.odds, real captured starts); rice 0 loses outright (battle_init_defender $92CA);
  * the harvest: a horizon that crosses a Fall runs the real harvest (game.harvest_fief, income rolls
    at their mean); a future Summer command buys the least rice that keeps the post-harvest rice above 0, and
    if none can, that Fall is death (rice 0 -> every neighbour attacks, the defence loses unfought).
The score is the product of the season survivals; the state is held fixed between harvests (no
future command but the Summer rice; every fief harvests). The candidates are the reader's own move
and the gold moves: morale, hire (all, or to the picker line), rice; a gold move replaces the reader's
only when it prices higher by EPS (the reader carries the economy the score cannot see). Riots are not priced (no riot deaths in the Saito runs).
"""
import json
from pathlib import Path

from . import forecast, memmap as M, policy, reaction, vmprims as P

P_ATTACK = 0.65          # per threatening neighbour per season (1 threat .65, 2 .89, 3+ 1.0 observed)
REVOLT_LOSS = ((24, .24), (38, .36), (58, .42))   # staged revolt battle lost, by his men (#45)
HORIZON = 8              # seasons; 8 reaches the second harvest (the income loyalty and wealth buy)
GROWTH = True            # the AI fiefs recruit on the ROM's schedule in the projection (expected values)
PEASANTS = False         # give the gold to the peasants as a candidate (worth pricing only with HORIZON 8)
EPS = 0.003
ALL_HARVEST = True       # project every fief's harvest, not only his
READER_DEFAULT = False   # tried 2026-11-11: 41 alive of 600 against 48 without; the reader's move is a candidate and the fallback (else reaction.economy)
_ODDS = {}


def _odds(fief):
    if fief not in _ODDS:
        p = Path(__file__).with_name(f"odds_f{fief}.json")
        _ODDS[fief] = json.loads(p.read_text()) if p.exists() else json.loads(
            Path(__file__).with_name("odds_f8.json").read_text())
    return _ODDS[fief]


def _bracket(xs, x):
    if x <= xs[0]:
        return 0, 0, 0.0
    for i in range(1, len(xs)):
        if x <= xs[i]:
            return i - 1, i, (x - xs[i - 1]) / (xs[i] - xs[i - 1])
    return len(xs) - 1, len(xs) - 1, 0.0


def p_held(fief, men, committed, led):
    """Bilinear in the odds table; scaled to the table's ratio past its edges (the ratio decides)."""
    t = _odds(fief)
    d, a = t["def"], t["atk"]
    if men > d[-1]:                      # past the table: keep the ratio
        committed, men = committed * d[-1] / men, d[-1]
    if men < d[0]:
        committed, men = committed * d[0] / max(1, men), d[0]
    g = t["led" if led else "general"]
    i0, i1, u = _bracket(d, men)
    j0, j1, v = _bracket(a, committed)
    top = g[i0][j0] * (1 - v) + g[i0][j1] * v
    bot = g[i1][j0] * (1 - v) + g[i1][j1] * v
    return top * (1 - u) + bot * u


def _fail(x):            # square_over_2025_probability_roll: min(x,50)^2 < rng(2025)
    s = min(x, 50)
    return max(0, 2024 - s * s) / 2025


def revolt_risk(m, idx, season):
    f = m.fief(idx)
    if m.r16(f + M.F_MEN) <= 2:
        return 0.0
    live = sum(1 for i in range(m.r16(M.SCENARIO_FIEF_COUNT)) if m.province_ai_state(i) != M.EMPTY)
    cha = m.r8(m.fief_daimyo(idx) + M.D_CHARISMA)
    elig = 1 - (1 - _fail(m.s16(f + M.F_MORALE))) * (1 - _fail(cha)) * (1 - 1 / 1000)
    branch = 0.375 if season == 1 else 0.75
    men = m.r16(f + M.F_MEN)
    lose = next((p for x, p in REVOLT_LOSS if men <= x), REVOLT_LOSS[-1][1])
    return branch * (1 - 0.97 ** live) * 0.5 * elig * lose


def invasion_risk(m, idx):
    f = m.fief(idx)
    men, rice = m.r16(f + M.F_MEN), m.r16(f + M.F_RICE)
    alive = 1.0
    for n in reaction.threats(m, idx):
        if rice == 0 or men == 0:
            return 1.0
        b = reaction.budget(reaction.live_side(m, n))
        led = 0.5 if m.is_capital(n) and not m.r8(M.REST_TURNS + n) else 0.0
        lose = (led * (1 - p_held(idx, men, b * 0.745, True))
                + (1 - led) * (1 - p_held(idx, men, b * 0.595, False)))
        alive *= 1 - P_ATTACK * lose
    return 1 - alive


# the projection plumbing lives in forecast.py (shared); these names stay for callers of ev
_Mean, _snapshot, _restore, _grow_ai = forecast.Mean, forecast.snapshot, forecast.restore, forecast.grow_ai


def survival(m, idx):
    """P(alive over the next HORIZON seasons) from the memory as it stands (after the candidate move).
    Season 0 is this one: its events have rolled, about half the neighbours are still to move."""
    s0 = getattr(m, "season", 0)
    with forecast.held(m):
        alive = 1.0
        for k in range(HORIZON):
            t = (s0 + k) % 4
            if k:
                forecast.step(m, t, growth=GROWTH, harvest_only=None if ALL_HARVEST else (idx,),
                              before_harvest=(lambda mm: policy.buy_rice_to(           # a Summer command
                                  mm, idx, lambda s: policy._rice_slack(mm, idx, False, s)))  # still to come
                              if k > 1 else None)
                if t == 2 and m.r16(m.fief(idx) + M.F_RICE) == 0:
                    return 0.0
            if k:
                alive *= 1 - revolt_risk(m, idx, t)
            alive *= 1 - (0.5 if k == 0 else 1.0) * invasion_risk(m, idx)
        return alive


def candidates(m, idx):
    """-> [(name, move)]: the gold moves worth pricing this season."""
    f = m.fief(idx)
    gold = m.r16(f + M.F_GOLD)
    out = [("none", lambda: None)]
    if gold <= 1:
        return out
    out.append(("morale", lambda: policy.give_men(m, idx, min(60, gold - 1), gold=True)))
    out.append(("hire", lambda: policy.hire_men(m, idx, gold - 1)))
    if reaction.threats(m, idx):
        line = reaction.men_line(m, idx)
        if line is not None:
            out.append(("line", lambda: policy._hire_up_to(m, idx, line)))
    if PEASANTS:
        out.append(("peasants", lambda: policy.give_peasants(m, idx, gold - 1, gold=True)))
    out.append(("rice", lambda: policy.buy_rice_to(
        m, idx, lambda s: policy._rice_slack(m, idx, False, s, sustain=True))))
    return out


LOG = []                 # (year?, season, {name: score}, chosen) when TRACE is on
TRACE = False


def ev_policy(m, idx, rng):
    """Price the reader's own move and each gold move by survival(); a gold move replaces the
    reader's only when it beats it by EPS (the reader carries what the score cannot see: loyalty,
    wealth, the tax, so the income)."""
    scores, left = {}, {}
    first = [("reader", lambda: reaction.reader_policy(m, idx, rng))] if READER_DEFAULT else []
    for name, move in first + candidates(m, idx):
        snap = _snapshot(m)
        try:
            move()
            scores[name] = survival(m, idx)
            f = m.fief(idx)
            left[name] = m.r16(f + M.F_GOLD) + m.r16(f + M.F_RICE)
        finally:
            _restore(m, snap)
    base = "reader" if READER_DEFAULT else "none"
    top = max(scores.values())
    tol = EPS                        # absolute; relative (EPS * top) tried 2026-11-11: 46 of 600 against 50
    if scores[base] >= top - tol:
        best = base
    else:                            # of the moves within tol of the best, the one that keeps most
        best = max((k for k in scores if scores[k] >= top - tol), key=lambda k: (left[k], scores[k]))
    if TRACE:
        LOG.append((getattr(m, "season", 0), scores, best))
    if best == "reader":
        reaction.reader_policy(m, idx, rng)
    elif best == "none":
        reaction.economy(m, idx)
    else:
        dict(candidates(m, idx))[best]()
