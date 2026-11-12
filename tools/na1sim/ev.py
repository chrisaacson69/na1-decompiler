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
MARKS = True             # the Summer income re-seed in the projection (False = the pre-fix projection)
RIOTS = False            # price riots (all the gold paid, RIOT_PAY) and offer the tax moves
RIOT_DEATH = 0.01        # a riot battle lost, measured (gold 0: 99-100% won)
RIOT_SETTLE = False      # price a riot by its settle rule and an output-sized battle (else RIOT_DEATH flat)
PLANS = False            # two-move plans: this season's move, then a give or a tax next season
ECON = False             # second objective: among moves within EPS of the best survival, the most
                         # harvest income at the horizon's end; the economy step is scored as applied
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


def riot_risk(m, idx, season):
    """P(a riot lands on him) this season: the uprising branch x the planner gate x the riot-or-revolt
    coin (1/2) x riot eligibility (ai_event_eligibility_check_loyalty_variant: a failed roll of loyalty,
    100 - tax or charisma, or 1 in 1000, then a 1 in 4, with output and more than 2 men)."""
    f = m.fief(idx)
    if m.r16(f + M.F_MEN) <= 2 or m.s16(f + M.F_OUTPUT) <= 0:
        return 0.0
    live = sum(1 for i in range(m.r16(M.SCENARIO_FIEF_COUNT)) if m.province_ai_state(i) != M.EMPTY)
    cha = m.r8(m.fief_daimyo(idx) + M.D_CHARISMA)
    tax = m.r8(M.FIEF_TAX_RATE + idx)
    fail = 1 - (1 - _fail(m.s16(f + M.F_LOYALTY))) * (1 - _fail(100 - tax)) * (1 - _fail(cha)) * (1 - 1 / 1000)
    branch = 0.375 if season == 1 else 0.75
    return branch * (1 - 0.97 ** live) * 0.5 * fail / 4


def riot_death(m, idx):
    """P(the fief falls) given a riot on a human capital (game._riots, human_riot, RIOT_PAY): all the
    gold goes to the peasants and settles it only if loyalty ends above 25 having risen more than 5
    (the riot payment's gain, vmprims._gift_gain); otherwise the staged riot battle. The riot army is
    the fief's output, plus up to half the men (rng(50)%) when charisma < rng(skill) + 70
    (spawn_uprising_force); it is general-led, priced on the odds table."""
    f = m.fief(idx)
    gold, loy, out = m.r16(f + M.F_GOLD), m.r16(f + M.F_LOYALTY), m.r16(f + M.F_OUTPUT)
    if gold:
        gain = P._gift_gain(loy, out, gold, m.skill, m.r16(f + M.F_HEADER))
        if loy + gain > 25 and gain > 5:
            return 0.0
    men = m.r16(f + M.F_MEN)
    cha, sk = m.r8(m.fief_daimyo(idx) + M.D_CHARISMA), max(1, m.skill)
    join = sum(1 for r in range(sk) if cha < r + 70) / sk
    moved = join * 0.245 * men
    army, left = out + moved, men - moved
    if left <= 0:
        return 1.0
    return max(RIOT_DEATH, 1 - p_held(idx, left, army, False))


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


def income_capacity(m, idx):
    """Gold + rice a harvest would bring in from the memory as it stands, before upkeep: the marks
    re-seeded from the live stats (Summer), every roll at its mean, the army set aside. The vault's
    Economic Index measures balance, not income (synthesis #36), so this is the harvest formula itself."""
    from . import game
    with forecast.held(m):
        game.reset_marks(m)
        f = m.fief(idx)
        m.w16(f + M.F_MEN, 0)
        g, r = m.r16(f + M.F_GOLD), m.r16(f + M.F_RICE)
        game.harvest_fief(m, idx, forecast.Mean())
        return m.r16(f + M.F_GOLD) - g + m.r16(f + M.F_RICE) - r


def survival(m, idx, then=None, value=False):
    """P(alive over the next HORIZON seasons) from the memory as it stands (after the candidate move).
    Season 0 is this one: its events have rolled, about half the neighbours are still to move."""
    s0 = getattr(m, "season", 0)
    with forecast.held(m):
        alive = 1.0
        for k in range(HORIZON):
            t = (s0 + k) % 4
            if k:
                forecast.step(m, t, growth=GROWTH, harvest_only=None if ALL_HARVEST else (idx,), marks=MARKS,
                              before_harvest=(lambda mm: policy.buy_rice_to(           # a Summer command
                                  mm, idx, lambda s: policy._rice_slack(mm, idx, False, s)))  # still to come
                              if k > 1 else None)
                if t == 2 and m.r16(m.fief(idx) + M.F_RICE) == 0:
                    return (0.0, 0) if value else 0.0
                if k == 1 and then:          # the plan's second move, next season
                    then()
            if k:
                alive *= 1 - revolt_risk(m, idx, t)
            if k and RIOTS:                  # a riot takes all the gold (expected), rarely the fief
                r = riot_risk(m, idx, t)
                alive *= 1 - r * (riot_death(m, idx) if RIOT_SETTLE else RIOT_DEATH)
                g = m.fief(idx) + M.F_GOLD
                m.w16(g, round(m.r16(g) * (1 - r)))
            alive *= 1 - (0.5 if k == 0 else 1.0) * invasion_risk(m, idx)
        return (alive, income_capacity(m, idx)) if value else alive


def candidates(m, idx):
    """-> [(name, move)]: the gold moves worth pricing this season."""
    f = m.fief(idx)
    gold = m.r16(f + M.F_GOLD)
    out = [("none", lambda: None)]
    if RIOTS:
        tax, loy = m.r8(M.FIEF_TAX_RATE + idx), m.r16(f + M.F_LOYALTY)
        cap = 30 if m.fief_owner(idx) == 3 else 55
        keep = next((t for t in range(cap - tax, 0, -1)
                     if loy - P.pct_op(loy, t) >= policy.CLIFF - 1), 0)
        if keep:
            out.append(("tax_keep", lambda: policy.set_tax(m, idx, tax + keep)))
        if tax < cap:
            out.append(("tax_cap", lambda: policy.set_tax(m, idx, cap)))
    if PLANS:                        # tax now, give next season (Chris: the gift lands on a lower base)
        tax, cap = m.r8(M.FIEF_TAX_RATE + idx), (30 if m.fief_owner(idx) == 3 else 55)
        if tax < cap:
            out.append(("tax_cap>give", lambda: policy.set_tax(m, idx, cap),
                        lambda: policy.give_peasants(m, idx, m.r16(m.fief(idx) + M.F_GOLD) - 1, gold=True)))
            if gold > 1:
                out.append(("give>tax_cap", lambda: policy.give_peasants(m, idx, gold - 1, gold=True),
                            lambda: policy.set_tax(m, idx, cap)))
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
    scores, left, value = {}, {}, {}
    first = [("reader", lambda: reaction.reader_policy(m, idx, rng))] if READER_DEFAULT else []
    cands = candidates(m, idx)
    if ECON:                         # "none" hands the season to the economy step: score it applied
        cands = [("none", lambda: reaction.economy(m, idx))] + [c for c in cands if c[0] != "none"]
    for name, move, *then in first + cands:
        snap = _snapshot(m)
        try:
            move()
            if ECON:
                scores[name], value[name] = survival(m, idx, then[0] if then else None, value=True)
            else:
                scores[name] = survival(m, idx, then[0] if then else None)
            f = m.fief(idx)
            left[name] = m.r16(f + M.F_GOLD) + m.r16(f + M.F_RICE)
        finally:
            _restore(m, snap)
    base = "reader" if READER_DEFAULT else "none"
    top = max(scores.values())
    tol = EPS
    if ECON:                         # survival first; then the richer future; then keep the most
        best = max((k for k in scores if scores[k] >= top - tol), key=lambda k: (value[k], left[k], scores[k]))
        if TRACE:
            LOG.append((getattr(m, "season", 0), scores, best))
        if best == "none":
            reaction.economy(m, idx)
        else:
            next(c[1] for c in cands if c[0] == best)()
        return                        # absolute; relative (EPS * top) tried 2026-11-11: 46 of 600 against 50
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
        next(c[1] for c in candidates(m, idx) if c[0] == best)()
