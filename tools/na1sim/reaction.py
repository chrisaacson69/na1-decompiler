"""Read a position the way a player does: for each enemy neighbour, can it attack, what would stop
that, and what would beat it if it comes. Chris, 2026-11-06: solve problems in order of hierarchy, and
know when you cannot. Everything read here is on the player's screen.

An AI attacks a human only past both gates (ai_try_war_attack, ai_commit_attack_deduct_resources):
  share   its men / (its men + mine) above 47, the grudge path, and
  budget  min(2 * rice, men, gold) at least the shield, min(my rice, my men).
Shutting either stops the attack. Failing that, the fight can still be won: it commits 50-89% of the
budget at 2x (3x on a siege), and a capital defends at 3x.

Run from tools/:  py -3.14 -m na1sim.reaction   (the turn-1 table: no game is played)
"""
from collections import Counter, namedtuple
from itertools import product

Side = namedtuple("Side", "gold rice men morale arms skill")
RATES = range(14, 50)        # gold per man in tenths at 1560: 70% of 20 + rng(51)
COMMIT = 70                  # a typical commit, percent of budget
GRUDGE = 47
CLEAR, SHUT, REPEL, CANT = "clear", "shut", "repel", "cant"


def budget(s):
    return min(2 * s.rice, s.men, s.gold)


def shield(s):
    return min(s.rice, s.men)


def is_open(me, them):
    return budget(them) >= shield(me) and them.men * 100 // (them.men + me.men) > GRUDGE


def _quality(s):
    return (s.arms // 2 + s.skill // 2) * 2


def men_to_shut(me, them):
    """The fewest men, or None, that close a gate by men alone: past the share line, or past the
    budget where rice already covers it."""
    share = them.men * (100 - GRUDGE) // GRUDGE + 1
    budget_line = budget(them) + 1
    return min(share, budget_line) if me.rice > budget(them) else share


def men_to_repel(me, them):
    """The fewest men that beat a typical commit at a capital (the off-screen formula, so rough)."""
    c = budget(them) * COMMIT // 100
    atk = 2 * c + _quality(them) + them.morale
    return max(0, (atk - _quality(me) - me.morale) // 3 + 1)


def classify(me, nbrs, rate):
    """Which row of the matrix a position lands in, for a fief that can spend its gold on men."""
    open_ = [n for n in nbrs if is_open(me, n)]
    if not open_:
        return CLEAR
    most = me.men + (me.gold - 1) * 10 // rate
    if max(men_to_shut(me, n) for n in open_) <= most:
        return SHUT
    if max(men_to_repel(me, n) for n in open_) <= most:
        return REPEL
    return CANT


def human_side(p):
    return Side(p.gold, p.rice, p.men, p.morale, p.arms, p.skill)


def ai_side(p, skill, doubled):
    """apply_scenario_starting_stat_boosts on a 17-fief board."""
    k = 5 * skill
    gold, rice, men, morale = p.gold + 2 * k, p.rice + k, p.men + k, p.morale + k
    if doubled:
        gold, rice, men, morale = gold * 2, rice * 3, men * 2, morale * 2
    return Side(gold, rice, men, morale, p.arms + k, p.skill + k)


def boards(fief, skill, provinces, adjacency, coins):
    """Every coin outcome among a fief's neighbours -> (doubled neighbours, neighbour sides)."""
    near = [n for n in adjacency.get(fief, []) if n < len(provinces)]
    flip = [n for n in near if n in coins]
    for hits in product((False, True), repeat=len(flip)):
        won = {n for n, h in zip(flip, hits) if h}
        yield won, [ai_side(provinces[n], skill, n in won) for n in near]


def table(skills=(1, 2, 3, 4, 5)):
    from . import deaths, loader
    prov = {p.idx: p for p in loader.load_provinces()}
    adj = loader.load_adjacency()
    print("share of turn-1 boards in each row (coins x market rate, all equally likely)")
    print(f"{'fief':11}" + "".join(f"| skill {s}: clear shut repel cant " for s in skills))
    total = {s: Counter() for s in skills}
    for f in sorted(prov):
        line = f"{deaths.NAMES[f]:11}"
        me = human_side(prov[f])
        for s in skills:
            c = Counter()
            for _won, nbrs in boards(f, s, prov, adj, deaths.COIN_FIEFS):
                for r in RATES:
                    c[classify(me, nbrs, r)] += 1
            n = sum(c.values())
            total[s][CANT] += c[CANT] / n
            line += f"| {c[CLEAR] / n:13.0%} {c[SHUT] / n:4.0%} {c[REPEL] / n:5.0%} {c[CANT] / n:4.0%} "
        print(line)
    print("fiefs' worth of unplayable starts:", {s: round(total[s][CANT], 1) for s in skills})


def live_side(m, i):
    from . import memmap as M
    f = m.fief(i)
    return Side(*(m.r16(f + k) for k in (M.F_GOLD, M.F_RICE, M.F_MEN, M.F_MORALE, M.F_ARMS, M.F_SKILL)))


def enemy_neighbours(m, idx):
    """The AI-held neighbours of a fief."""
    from . import memmap as M
    n, me = m.r16(M.SCENARIO_FIEF_COUNT), m.fief_owner(idx)
    return [nb for nb in m.neighbor_rows.get(idx, [])
            if nb < n and m.province_ai_state(nb) == 0 and m.fief_owner(nb) != me]


def huntable(m, idx):
    """Some enemy neighbour is past the share gate (its men / both > 47%): it could pick this fief,
    whether or not it does today."""
    from . import ai_vm
    return any(ai_vm.fief_men_ratio_pct(m, nb, idx) > GRUDGE for nb in enemy_neighbours(m, idx))


def threats(m, idx):
    """The neighbours that would pick this fief, by the ROM's own choice, and can pay to attack it."""
    from . import policy
    me = live_side(m, idx)
    return [n for n in policy.hunted_by(m, idx) if budget(live_side(m, n)) >= shield(me)]


def live_row(m, idx):
    """The matrix row of a live position, which knows who else each neighbour could hit."""
    from . import memmap as M
    now = threats(m, idx)
    if not now:
        return CLEAR
    f = m.fief(idx)
    men, gold = m.r16(f + M.F_MEN), m.r16(f + M.F_GOLD)
    rate = m.r16(M.GOLD_MEN_HIRE_RATE) or 50
    most = men + min(max(gold - 1, 0) * 10 // rate, m.r16(f + M.F_HEADER) - men)
    me = live_side(m, idx)
    try:
        for v in range(men + 1, most + 1):
            m.w16(f + M.F_MEN, v)
            if not threats(m, idx):
                return SHUT
    finally:
        m.w16(f + M.F_MEN, men)
    return REPEL if max(men_to_repel(me, live_side(m, n)) for n in now) <= most else CANT


def men_line(m, idx):
    """The fewest men that leave no threat, or None if the gold will not reach it."""
    from . import memmap as M
    f = m.fief(idx)
    men, gold = m.r16(f + M.F_MEN), m.r16(f + M.F_GOLD)
    rate = m.r16(M.GOLD_MEN_HIRE_RATE) or 50
    most = men + min(max(gold - 1, 0) * 10 // rate, m.r16(f + M.F_HEADER) - men)
    try:
        for v in range(men + 1, most + 1):
            m.w16(f + M.F_MEN, v)
            if not threats(m, idx):
                return v
    finally:
        m.w16(f + M.F_MEN, men)
    return None


AFTER_HARVEST = 30           # the high end of a neighbour's yearly drift


def opens_after_harvest(m, idx):
    """Will a neighbour that picks this fief be able to pay once the harvest is in? Rough."""
    from . import policy
    me = live_side(m, idx)
    return any(budget(live_side(m, n)) + AFTER_HARVEST >= shield(me) for n in policy.hunted_by(m, idx))


ROWS = Counter()


def reaction_policy(m, idx, rng):
    """The matrix, first row that applies: fix what breaks from inside; if a gate is open, put all the
    gold into men, to shut it, win or absorb; hold the rice if a gate opens at harvest; otherwise
    play on. The read decides whether to buy, not how much: buying exactly to the line lost
    (Uesugi 87% to 79%, Hojo at skill 1 64% to 56%), all the gold did not."""
    from . import memmap as M, policy
    f = m.fief(idx)
    morale, loyalty = m.r16(f + M.F_MORALE), m.r16(f + M.F_LOYALTY)
    # `tax_first`: take the first harvest at the full rate, loyalty or not, once morale is safe.
    early = (policy.OPENING.get("tax_first") and m.r16(M.CURRENT_GAME_YEAR) == 1560
             and getattr(m, "season", 0) in ((1,) if policy.OPENING["tax_first"] == 2 else (0, 1))
             and morale >= policy.CLIFF)
    if morale >= policy.CLIFF and (loyalty >= policy.CLIFF or early) and threats(m, idx):
        if m.r16(f + M.F_GOLD) > 1:         # all of it: the neighbours move after this, so an exact
            ROWS["shut" if men_line(m, idx) is not None else "absorb"] += 1     # fit goes stale
            policy.hire_men(m, idx, m.r16(f + M.F_GOLD) - 1)
            return
    if early and m.r8(M.FIEF_TAX_RATE + idx) < (30 if m.fief_owner(idx) == 3 else 55):
        ROWS["tax"] += 1
        policy._tax_max(m, idx)
        return
    keep = policy.OPENING["keep_rice"]
    policy.OPENING["keep_rice"] = keep or opens_after_harvest(m, idx)
    try:
        policy.expand_policy(m, idx, rng)
    finally:
        policy.OPENING["keep_rice"] = keep


def reader_policy(m, idx, rng):
    """A player who reads the position each turn instead of following a script (Chris, 2026-11-10:
    treat Saito as a new player). Saito's T1 battle can come before or after his first command, so
    a turn-numbered opening cannot tell a fief that just won a big garrison from one that did not.
    In order, the first that applies takes the season:
      1. cliffs: morale, then loyalty, under 45 (gold first, else rice above the upkeep);
      2. the runt: a neighbour would pick me and can pay -> hire to the fewest men that stop it
         (men_line; all the gold if out of reach), and no further;
      3. Summer, the last command before the harvest: if the army cannot be fed through this upkeep
         and the next, buy the least rice that can; when gold is then short, the upkeep dismisses
         the men it cannot pay;
      4. the economy: tax to 55 as loyalty bears it; Summer gives the rice above what step 3 keeps
         (above the men while hunted), Spring gives the gold, else train."""
    from . import memmap as M, policy
    f = m.fief(idx)
    gold, rice, men = m.r16(f + M.F_GOLD), m.r16(f + M.F_RICE), m.r16(f + M.F_MEN)
    morale, loyalty = m.r16(f + M.F_MORALE), m.r16(f + M.F_LOYALTY)
    season = getattr(m, "season", 0)
    rice_first = policy.OPENING.get("summer_rice_first")
    # line_first (Chris, 2026-11-11): when the gold reaches the picker line (men_line runs the real
    # selection), hiring to it outranks the morale fix: nobody picks him, so the battle never comes.
    # Hiring also lifts morale a little (recruits arrive at 40-59, apply_hire_unit_stats $8BF4).
    if policy.OPENING.get("line_first") and threats(m, idx) and gold > 1:
        line = men_line(m, idx)
        if line is not None and policy._hire_up_to(m, idx, line):
            return
    for low, give in ((morale, policy.give_men), (loyalty, policy.give_peasants)):     # 1
        # summer_rice_first (Chris, 2026-11-11: T2 is rice): in Summer the rice for the upkeep
        # outranks the loyalty cliff (a won T1 garrison has the morale; loyalty only risks a riot)
        if rice_first and give is policy.give_peasants and season == 1 and policy.buy_rice_to(
                m, idx, lambda s: policy._rice_slack(m, idx, False, s, sustain=True)):
            return
        if low < policy.CLIFF:
            if gold > 1:
                give(m, idx, min(60, gold - 1), gold=True)
                return
            floor = men if policy.OPENING.get("shield_rice") else men // 2
            if rice - floor - 1 > 0:
                give(m, idx, min(60, rice - floor - 1))
                return
    if threats(m, idx) and gold > 1:                                                    # 2
        line = men_line(m, idx)
        if line is None:
            policy.hire_men(m, idx, gold - 1)
            return
        if policy._hire_up_to(m, idx, line):
            return
    if season == 1 and policy.buy_rice_to(                                              # 3
            m, idx, lambda s: policy._rice_slack(m, idx, False, s, sustain=True)):
        return
    economy(m, idx)                                                                     # 4


def economy(m, idx):
    """reader_policy's step 4, shared with ev.ev_policy: tax to 55 as loyalty bears it; Summer gives
    the rice above what the upkeep keeps (above the men while hunted), Spring gives the gold, else train."""
    from . import memmap as M, policy
    f = m.fief(idx)
    gold, rice, men = m.r16(f + M.F_GOLD), m.r16(f + M.F_RICE), m.r16(f + M.F_MEN)
    loyalty = m.r16(f + M.F_LOYALTY)
    season = getattr(m, "season", 0)
    tax, cap = m.r8(M.FIEF_TAX_RATE + idx), (30 if m.fief_owner(idx) == 3 else 55)
    guard = policy.OPENING.get("shield_rice")
    # shield_rice (Chris, 2026-11-12): the gate reads min(rice, men), so rice under the men is a shield
    # given away. Summer's gift left Tokugawa 1 rice beside 71 men, unhunted when it gave; an AI moved
    # later that season, passed the gate on 1 rice and won (3 deaths every player shared on the bench).
    # Hunted and short: buy back to the men (rice >= men now and after the harvest) before anything.
    # Mode 3 (Chris, 2026-11-12), three states, not two: past the share gate nobody can pick him and
    # the rice is free to give; huntable (some neighbour's share of men > 47, picked or not) the gift
    # stops at the budget gate; hunted (threats) is the rows above. hunted_by alone missed the gift:
    # Tokugawa was nobody's pick when it gave, and Imagawa came at 52% later that season.
    hunt = huntable(m, idx) if guard == 3 else guard and policy.hunted_by(m, idx)
    if guard and season == 1 and rice < men and hunt and policy.buy_rice_to(
            m, idx, lambda s: policy._rice_slack(m, idx, True, s)):
        return
    step = next((s for s in range(cap - tax, 0, -1)
                 if loyalty - policy.P.pct_op(loyalty, s) >= policy.CLIFF - 1), 0)
    if step:
        policy.set_tax(m, idx, tax + step)
        return
    capped = (m.r16(f + M.F_WEALTH) + loyalty) // 2 >= m.r16(f + M.F_HEADER)
    if season == 1:
        keep = men if guard == 1 or policy.hunted_by(m, idx) else 0
        if guard == 2 or guard == 3 and hunt:   # only as much as shuts the budget gate
            keep = max(keep, min(men, max([budget(live_side(m, n)) + 1 for n in enemy_neighbours(m, idx)] or [0])))
        keep = max(keep, rice - max(0, policy._rice_slack(m, idx, False, sustain=True)))
        if rice > keep + 1:
            (policy.give_men if capped else policy.give_peasants)(m, idx, rice - keep - 1)
            return
    if season == 0 and gold > 1 and not capped:
        policy.give_peasants(m, idx, gold - 1, gold=True)
        return
    policy.train(m, idx)


def _rows(job):
    import random
    from . import game, setup
    fief, s0, s1, skill = job
    out = {}
    for seed in range(s0, s1):
        m = setup.build_board(skill=skill, seed=seed, player_fief=fief)
        m.season = 0
        game.roll_period_market_rates(m, random.Random(10000 + seed))
        out[seed] = live_row(m, fief)
    return fief, out


def validate(path, skill, first=3000, seeds=300):
    """The row each game's opening lands in, against how that game went."""
    import json
    from concurrent.futures import ProcessPoolExecutor
    from . import deaths
    played = json.load(open(path))
    jobs = [(f, s, s + 50, skill) for f in range(17) for s in range(first, first + seeds, 50)]
    rows = {f: {} for f in range(17)}
    with ProcessPoolExecutor(6) as ex:
        for f, r in ex.map(_rows, jobs):
            rows[f].update(r)
    order = (CLEAR, SHUT, REPEL, CANT)
    print(f"skill {skill}: games in each turn-1 row, alive at year 6 in brackets")
    tot = {r: [0, 0] for r in order}
    for f in range(17):
        c = {r: [0, 0] for r in order}
        for g in played[str(f)]:
            r = rows[f][g["seed"]]
            c[r][0] += 1
            c[r][1] += not g["fatal"]
            tot[r][0] += 1
            tot[r][1] += not g["fatal"]
        print(f"{deaths.NAMES[f]:11}" + "".join(f" {r} {c[r][0]:3} ({c[r][1] / max(c[r][0], 1):4.0%})" for r in order))
    print("ALL        " + "".join(f" {r} {tot[r][0]:4} ({tot[r][1] / max(tot[r][0], 1):4.0%})" for r in order))


if __name__ == "__main__":
    import sys
    if len(sys.argv) > 2:
        validate(sys.argv[1], int(sys.argv[2]))
    else:
        table()


ASSIGN_SPLIT = (96, 1, 1, 1, 1)


def reader_assign_policy(m, idx, rng):
    """reader_policy, but the first command with 30 gold spends the Assign to ASSIGN_SPLIT (#44: the
    commander holds the army on the castle, one-man units steer the attacker's landing), once."""
    from . import memmap as M, vmprims as P
    base = M.PROVINCE_UNIT_TYPE_PCT + idx * 5
    if tuple(m.r8(base + i) for i in range(5)) != ASSIGN_SPLIT and P.driver_assign(m, idx, ASSIGN_SPLIT):
        return
    reader_policy(m, idx, rng)
