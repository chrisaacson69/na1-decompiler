"""
experiments.py -- the fief-defensibility harness behind FINDINGS-defensibility.md.

Battles run ~7 ms each (tactical) / <1 ms (off-screen); the board is BUILT ONCE
(~1.1 s, it drives na1dream for the setup boosts) and the $6000-$7FFF image reused.

Run:  py -3 -m na1sim.experiments <which>
  terrain   -- per-direction tactical defensibility ranking (equal stats)
  curve     -- full attacker-men probability BAND per fief (50/90/99% win + ascii curves)
  attrition -- post-battle men left on the fief: off-screen (additive) vs tactical (grind)
  factors   -- flat / +castle / +full-terrain ablation
  dual      -- defender Skill: tactical (binary) vs off-screen (_quality, proportional)
  offscreen -- terrain ranking under off-screen: equal (flat) + real-stat (quality)
"""
import sys
import random

from . import setup, memmap as M, tactical as T, game, loader

EDGE = {0: "full", 1: "N", 2: "S", 3: "W", 4: "E"}
DEF_MEN = 200
NAMES = {p.idx: getattr(p, "name", "?") for p in loader.load_provinces()}
_BOARD = None


def _board():
    global _BOARD
    if _BOARD is None:
        b = setup.build_board(skill=2, seed=42)
        _BOARD = (bytes(b.m[0x6000:0x8000]), dict(b.neighbor_rows), b)
    return _BOARD


def fresh(seed=0):
    pre, nrows, _ = _board()
    m = M.Memory(rng=random.Random(seed))
    m.m[0x6000:0x8000] = bytearray(pre)
    m.neighbor_rows = nrows
    return m


def setup_battle(m, deff, atk, atk_men, stat_mode="equal", stat=None,
                 defval=100, base=100):
    """stat_mode: 'equal' (all 8 == base both sides), 'real_def' (defender keeps its
    real board stats, attacker == base), 'override' (all base, then set the defender's
    one `stat`=(kind,off) to defval)."""
    m.selected = atk
    m.defending = deff
    if stat_mode in ("equal", "override"):
        for fief in (atk, deff):
            f = m.fief(fief)
            for off in (M.F_MORALE, M.F_SKILL, M.F_ARMS):
                m.w16(f + off, base)
            d = m.fief_daimyo(fief)
            for off in (M.D_HEALTH, M.D_DRIVE, M.D_LUCK, M.D_CHARISMA, M.D_IQ):
                m.w8(d + off, base)
        if stat_mode == "override" and stat is not None:
            kind, off = stat
            if kind == "fw":
                m.w16(m.fief(deff) + off, defval)
            else:
                m.w8(m.fief_daimyo(deff) + off, defval)
    elif stat_mode == "real_def":                 # defender real, attacker baseline
        fa, da = m.fief(atk), m.fief_daimyo(atk)
        for off in (M.F_MORALE, M.F_SKILL, M.F_ARMS):
            m.w16(fa + off, base)
        for off in (M.D_HEALTH, M.D_DRIVE, M.D_LUCK, M.D_CHARISMA, M.D_IQ):
            m.w8(da + off, base)
    for fief in (atk, deff):
        m.w16(m.fief(fief) + M.F_HEADER, 1900)
    fd = m.fief(deff)
    m.w16(fd + M.F_MEN, DEF_MEN); m.w16(fd + M.F_GOLD, 80); m.w16(fd + M.F_RICE, DEF_MEN)
    for o, v in [(M.SR_GOLD, atk_men), (M.SR_RICE, atk_men), (M.SR_MEN, atk_men)]:
        m.w16(m.side_resource_ptr(0) + o, v)
    m.w16(M.WAR_ATTACKER_MEN, atk_men); m.w16(M.WAR_ATTACKER_GOLD, atk_men)
    m.w16(M.WAR_ATTACKER_RICE, atk_men)
    m.w8(M.WAR_SIDE_STATE_FLAG, 0); m.w8(M.WAR_SIDE_STATE_FLAG + 1, 0)


def p_tactical(deff, atk, atk_men, games=50, **kw):
    h = 0
    for g in range(games):
        m = fresh(g); setup_battle(m, deff, atk, atk_men, **kw)
        T.run_tactical_battle(m, m.rng)
        if m.fief_owner(deff) == deff:
            h += 1
    return h / games


def fifty_tactical(deff, atk, ratios=(1.3, 1.5, 1.7, 1.9, 2.1, 2.3, 2.5), games=50, **kw):
    ps = [(r, p_tactical(deff, atk, int(DEF_MEN * r), games, **kw)) for r in ratios]
    for i in range(len(ps) - 1):
        (r1, p1), (r2, p2) = ps[i], ps[i + 1]
        if p1 >= 0.5 >= p2 and p1 != p2:
            return r1 + (p1 - 0.5) / (p1 - p2) * (r2 - r1)
    return ratios[0] if ps[0][1] < 0.5 else ratios[-1]


def threshold_offscreen(deff, atk, **kw):           # deterministic -> binary search
    lo, hi = 80, 700
    while hi - lo > 2:
        mid = (lo + hi) // 2
        m = fresh(); setup_battle(m, deff, atk, mid, **kw)
        game.resolve_siege(m, m.rng)
        lo, hi = (mid, hi) if m.fief_owner(deff) == deff else (lo, mid)
    return lo / DEF_MEN


def edge_of(deff, atk):
    _, _, b = _board(); b.selected = atk; b.defending = deff
    return T.set_combat_arena_rect_by_approach(b)


def _worst_approach(deff):
    """the neighbour the attacker would actually pick (lowest 50% ratio)."""
    by_edge = {}
    for n in _board()[1].get(deff, []):
        if n < 17:
            by_edge.setdefault(edge_of(deff, n), n)
    best_atk, best50 = None, 99.0
    for e, atk in by_edge.items():
        r = fifty_tactical(deff, atk, games=30)
        if r < best50:
            best_atk, best50 = atk, r
    return best_atk


def run_attrition():
    """WHY does accurate combat collapse survival? Same committed force, two engines.
    Off-screen is ADDITIVE (winner keeps men + half the loser's: game.py _conquest /
    the d_men+c_men//2 hold). Tactical garrisons the fief with the ACTUAL survivors of
    a <=30-day grind (tactical.py:1353). Measure the men left ON THE FIEF (what the next
    attacker faces) + total men destroyed + how long the tactical battle ran.
    py -3 -m na1sim.experiments attrition"""
    import na1sim.tactical as TT
    targets = [("Mikawa", 7), ("Echigo", 1), ("Iga", 11), ("Owari", 16)]
    ratios = (1.0, 1.5, 2.0, 2.5, 3.0)
    GAMES = 40
    # wrap the per-day driver to count how many days each tactical battle ran
    _orig = TT.run_both_sides_combat_turn
    _day = [0]
    def _counted(m, day):
        _day[0] = day
        return _orig(m, day)
    print("post-battle MEN LEFT ON THE FIEF (the next attacker's target) + men destroyed.")
    print("committed = atk_men + 200 def.  AUTO=off-screen $8DFD, TAC=tactical 30-day.\n")
    for name, deff in targets:
        atk = _worst_approach(deff)
        print(f"  {name} (worst approach, def 200):")
        print(f"    {'atk':>4} {'commit':>6} | {'AUTO men':>8} {'destr':>5} hold% | "
              f"{'TAC men':>7} {'destr':>5} hold% days")
        for r in ratios:
            am = int(DEF_MEN * r)
            commit = am + DEF_MEN
            # off-screen
            a_men, a_hold = 0, 0
            for g in range(GAMES):
                m = fresh(g); setup_battle(m, deff, atk, am)
                game.resolve_siege(m, m.rng)
                a_men += m.r16(m.fief(deff) + M.F_MEN)
                a_hold += (m.fief_owner(deff) == deff)
            a_men //= GAMES
            # tactical
            TT.run_both_sides_combat_turn = _counted
            t_men, t_hold, t_days = 0, 0, 0
            for g in range(GAMES):
                _day[0] = 0
                m = fresh(g); setup_battle(m, deff, atk, am)
                TT.run_tactical_battle(m, m.rng)
                t_men += m.r16(m.fief(deff) + M.F_MEN)
                t_hold += (m.fief_owner(deff) == deff)
                t_days += _day[0]
            TT.run_both_sides_combat_turn = _orig
            t_men //= GAMES
            print(f"    {am:>4} {commit:>6} | {a_men:>8} {commit-a_men:>5} {a_hold*100//GAMES:>4}% | "
                  f"{t_men:>7} {commit-t_men:>5} {t_hold*100//GAMES:>4}% {t_days/GAMES:>4.0f}")
        print()


def _cross(curve, target):
    """curve = [(ratio, p_hold)] with p_hold DECREASING in ratio. Return the ratio
    where defender-hold prob == target (so attacker-win == 1-target), lin-interp."""
    for i in range(len(curve) - 1):
        (r1, p1), (r2, p2) = curve[i], curve[i + 1]
        if p1 >= target >= p2 and p1 != p2:
            return r1 + (p1 - target) / (p1 - p2) * (r2 - r1)
    return None


def run_curve():
    """Full attacker-men probability band per fief, on its WORST accessible approach.
    Answers 'how many EQUAL-stat attackers beat 200 defenders?' at 50/90/99% confidence.
    py -3 -m na1sim.experiments curve"""
    grid = [round(1.0 + 0.25 * i, 2) for i in range(15)]   # 1.00 .. 4.50
    GAMES = 120
    print(f"defender FIXED 200 men, equal stats. attacker-win ratio at each confidence.")
    print(f"sweep {grid[0]}-{grid[-1]}x, {GAMES} games/cell.  men = ratio * 200.\n")
    summary = []
    for deff in range(17):
        by_edge = {}
        for n in _board()[1].get(deff, []):
            if n < 17:
                by_edge.setdefault(edge_of(deff, n), n)
        if not by_edge:
            continue
        # pick worst (lowest 50% ratio) approach first, coarse
        worst_e, worst_atk, worst50 = None, None, 99.0
        for e, atk in by_edge.items():
            r50 = fifty_tactical(deff, atk, games=40)
            if r50 < worst50:
                worst_e, worst_atk, worst50 = e, atk, r50
        # fine sweep the worst approach
        curve = [(r, p_tactical(deff, worst_atk, int(DEF_MEN * r), GAMES)) for r in grid]
        p50 = _cross(curve, 0.50)
        p90 = _cross(curve, 0.10)   # attacker wins 90%
        p99 = _cross(curve, 0.01)   # attacker wins 99%
        summary.append((deff, EDGE[worst_e], p50, p90, p99, curve))
    summary.sort(key=lambda x: -(x[2] or 0))
    print(f"  {'fief':9} via  | win50%        win90%        win99%(approx)")
    print(f"  {'':9}      | ratio  men   | ratio  men   | ratio  men")
    for deff, ed, p50, p90, p99, _ in summary:
        def cell(p):
            return f"{p:.2f}  {int(p*DEF_MEN):4}" if p else "  -      - "
        print(f"  {NAMES[deff]:9} {ed:3}  | {cell(p50)}  | {cell(p90)}  | {cell(p99)}")
    print("\n--- full probability band, representative fiefs (defender-hold %) ---")
    by_name = {NAMES[d]: (ed, c) for d, ed, p50, p90, p99, c in summary}
    for want in ("Shinano", "Iga", "Mikawa", "Echigo"):
        if want not in by_name:
            continue
        ed, curve = by_name[want]
        print(f"\n  {want} (worst approach {ed}):")
        for r, p in curve:
            bar = "#" * int(round(p * 40))
            print(f"    {r:4.2f}x ({int(r*DEF_MEN):4} men)  {p*100:5.1f}% def-hold |{bar}")


# ---------------------------------------------------------------------------
def run_terrain():
    print("per-direction tactical defensibility (50% ratio); worst = realistic vuln.")
    rows = []
    for deff in range(17):
        by_edge = {}
        for n in _board()[1].get(deff, []):
            if n < 17:
                by_edge.setdefault(edge_of(deff, n), n)
        cells = {EDGE[e]: fifty_tactical(deff, atk) for e, atk in sorted(by_edge.items())}
        rows.append((min(cells.values()), deff, cells))
    for mn, d, cells in sorted(rows, reverse=True):
        print(f"  {NAMES[d]:9} worst {mn:.2f}   " + " ".join(f"{k}:{v:.2f}" for k, v in cells.items()))


def run_offscreen():
    print("terrain ranking under OFF-SCREEN.  AUTO(equal)=flat (terrain erased); AUTO(real)=quality")
    rows = []
    _, _, b = _board()
    for deff in range(17):
        atk = (deff + 1) % 17
        f = b.fief(deff)
        sk, ar, mo = b.r16(f + M.F_SKILL), b.r16(f + M.F_ARMS), b.r16(f + M.F_MORALE)
        rows.append((deff, fifty_tactical(deff, atk, games=40),
                     threshold_offscreen(deff, atk, stat_mode="equal"),
                     threshold_offscreen(deff, atk, stat_mode="real_def"), sk, ar, mo))
    print(f"  {'fief':9} TAC(terrain) AUTO(equal) AUTO(real)  skl/arm/mor")
    for deff, tac, ae, ar2, sk, ar, mo in sorted(rows, key=lambda x: -x[3]):
        print(f"  {NAMES[deff]:9}   {tac:.2f}        {ae:.2f}       {ar2:.2f}    {sk}/{ar}/{mo}")


def run_factors():
    _real = T.read_map_cell
    mode = ["full"]
    T.read_map_cell = lambda m, c, r: (_real(m, c, r) if mode[0] == "full"
                                       else (_real(m, c, r) if (mode[0] == "castle" and _real(m, c, r) & 32) else 4))
    print("ablation (Iga etc): flat / +castle / +full-terrain 50% ratio")
    for deff, atk in [(11, 10), (1, 2), (7, 8), (15, 16), (8, 7)]:
        v = {}
        for mode[0] in ("flat", "castle", "full"):
            v[mode[0]] = fifty_tactical(deff, atk, ratios=(0.8, 1.0, 1.2, 1.4, 1.6, 1.8, 2.0, 2.2, 2.4, 2.6))
        print(f"  {NAMES[deff]:9} flat {v['flat']:.2f}  +castle {v['castle']:.2f}  +terrain {v['full']:.2f}"
              f"   (castle {v['castle']-v['flat']:+.2f}, chokepoints {v['full']-v['castle']:+.2f})")
    T.read_map_cell = _real


def run_dual():
    print("defender SKILL: tactical (binary) vs off-screen (_quality, proportional)")
    for sk in (20, 60, 100, 140, 180):
        t = fifty_tactical(11, 10, ratios=(1.2, 1.4, 1.6, 1.8, 2.0),
                           stat_mode="override", stat=("fw", M.F_SKILL), defval=sk)
        a = threshold_offscreen(11, 10, stat_mode="override", stat=("fw", M.F_SKILL), defval=sk)
        print(f"  skill {sk:3}: tactical {t:.2f}   off-screen {a:.2f}")


if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "terrain"
    {"terrain": run_terrain, "offscreen": run_offscreen, "factors": run_factors,
     "dual": run_dual, "curve": run_curve,
     "attrition": run_attrition}.get(which, run_terrain)()
