"""Pockets: the map's shape, read statically, and the opening-line race (#60).

  py -3.14 -m na1sim.pockets table             best back line per start, 1-5 conquests (brute force)
  py -3.14 -m na1sim.pockets walks             A^N until no zero (N = the diameter), centrality
  py -3.14 -m na1sim.pockets trace 3,15,1 2,6,7,0    back line / front / enemies along a conquest line
  py -3.14 -m na1sim.pockets race SKILL [--first 3060 --seeds 200 --cases ...] [OUT.json]

The race plays each (start, line) on the same seeds through long_game: skill SKILL, gate hire on,
the pocket planner (4 deep, greedy fallback) after the line. A case is START:LINE with LINE one of
`greedy` (no planner), `pocket` (planner alone) or fief indices, e.g. 1:3,15 (Echigo: Kaga, Shinano).
"""
import argparse
import json
import statistics as st
from concurrent.futures import ProcessPoolExecutor

from .loader import load_adjacency, load_provinces

DEFAULT_CASES = ("1:greedy 1:pocket 1:3,0 1:3,15 1:15,3 1:15 1:2 "
                 "15:greedy 15:pocket 15:1,3 15:3,1 15:1,2 3:greedy 3:pocket 3:0,1 3:1,15")


def shape(adj, S):
    """(back line, front, enemies faced) of an empire S on the starting map."""
    inner = [i for i in S if all(j in S for j in adj[i])]
    return inner, [i for i in S if i not in inner], sorted({j for i in S for j in adj[i] if j not in S})


def table(depth=5):
    adj, P = load_adjacency(), load_provinces()
    for s in range(len(P)):
        lvl, row, best3 = {frozenset([s])}, [], None
        for k in range(1, depth + 1):
            lvl = {S | {j} for S in lvl for i in S for j in adj[i] if j not in S}
            key = lambda S: (len(shape(adj, S)[0]), -len(shape(adj, S)[2]), -sum(P[j].men for j in S if j != s))
            b = max(lvl, key=key)
            inn, fr, en = shape(adj, b)
            row.append(f"k{k}:{len(inn)}in/{len(fr)}fr/{len(en)}en")
            best3 = b if k == 3 else best3
        print(f"{P[s].name:9}", "  ".join(row), "| k3 =", [P[j].name for j in sorted(best3) if j != s])


def walks():
    import numpy as np
    adj, P = load_adjacency(), load_provinces()
    n = len(P)
    A = np.zeros((n, n), dtype=np.int64)
    for i, js in adj.items():
        A[i, js] = 1
    R, k = A.copy(), 1
    while (R == 0).any():
        R, k = R @ A, k + 1
    print(f"A^N has no zero from N = {k}")
    names = [p.name[:4] for p in P]
    print("      " + " ".join(f"{x:>5}" for x in names))
    for i in range(n):
        print(f"{names[i]:5} " + " ".join(f"{v:5}" for v in R[i]))
    w, v = np.linalg.eigh(A.astype(float))
    e = np.abs(v[:, -1]) / np.abs(v[:, -1]).max()
    print(f"lambda_max {w[-1]:.3f}; walks of {k} from each fief, centrality:")
    for i in sorted(range(n), key=lambda i: -e[i]):
        print(f"  {P[i].name:9} {R[i].sum():5}  {e[i]:.2f}")


def trace(start, line):
    adj, P = load_adjacency(), load_provinces()
    nm = lambda s: ", ".join(P[i].name for i in sorted(s)) or "-"
    S = set(start)
    for t in [None] + list(line):
        if t is not None:
            S.add(t)
        inn, fr, en = shape(adj, S)
        print(f"{'+ ' + P[t].name if t is not None else 'start':12} back [{nm(inn)}]  front [{nm(fr)}]  facing {len(en)}")


def _job(case, seed, years, skill):
    f, line = case
    greedy = line == "greedy"
    fiefs = [] if line in ("greedy", "pocket") else [int(x) for x in line.split(",")]
    # long_game.one's job: fief, seed, years, topped, war_at, fought, need, merchant, skill, ev,
    # gate_hire, pocket depth, pocket strict, staging, line
    return (f, seed, years, None, None, None, 0, None, skill, False, 1, 0 if greedy else 4, 0, None, fiefs)


def race(skill, cases, first, seeds, years, out):
    from . import long_game as L
    P = load_provinces()
    cases = [(int(c.split(":")[0]), c.split(":")[1]) for c in cases]
    jobs = [(c, _job(c, s, years, skill)) for c in cases for s in range(first, first + seeds)]
    with ProcessPoolExecutor(6) as ex:
        res = list(ex.map(L.one, [j for _, j in jobs]))
    by = {}
    for (c, _), r in zip(jobs, res):
        by.setdefault(c, []).append(r)
    if out:
        json.dump({f"{c[0]}:{c[1]}": v for c, v in by.items()}, open(out, "w"), default=str)
    print(f"skill {skill}, seeds {first}-{first + seeds - 1}, {years} years")
    print(f"{'start':9} {'line':18} alive6  exp  2nd 3rd  held@20 back@20 held@30 back@30 peak10 uni  deaths")
    for (f, line), rs in by.items():
        nth = lambda r, k: next((y[0] - 1560 for y in r[3] if y[1] >= k), None)
        med = lambda v: st.median(v) if v else "-"
        mean = lambda v: f"{st.mean(v):.1f}" if v else "-"
        at = lambda k, fld: [fld(r[3][k]) for r in rs if len(r[3]) > k]
        peak = [max((y[1] for y in r[3]), default=0) for r in rs]
        causes = {}
        for r in rs:
            if r[2]:
                causes[r[2]["cause"]] = causes.get(r[2]["cause"], 0) + 1
        label = line if line in ("greedy", "pocket") else "->".join(P[int(t)].name for t in line.split(","))
        print(f"{P[f].name:9} {label:18} {sum(1 for r in rs if not r[2] or r[2]['year'] >= 6):5} "
              f"{sum(p >= 2 for p in peak):4} {med([x for x in (nth(r, 2) for r in rs) if x is not None]):>4} "
              f"{med([x for x in (nth(r, 3) for r in rs) if x is not None]):>3}  "
              f"{mean(at(20, lambda y: y[1])):>6} {mean(at(20, lambda y: y[1] - y[5])):>7} "
              f"{mean(at(30, lambda y: y[1])):>7} {mean(at(30, lambda y: y[1] - y[5])):>7} "
              f"{sum(p >= 10 for p in peak):6} {sum(1 for r in rs if any(y[1] == y[2] for y in r[3])):3}  {causes}")


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("table")
    sub.add_parser("walks")
    t = sub.add_parser("trace")
    t.add_argument("start")
    t.add_argument("line")
    r = sub.add_parser("race")
    r.add_argument("skill", type=int)
    r.add_argument("out", nargs="?")
    r.add_argument("--first", type=int, default=3000)
    r.add_argument("--seeds", type=int, default=60)
    r.add_argument("--years", type=int, default=70)
    r.add_argument("--cases", default=DEFAULT_CASES)
    a = ap.parse_args()
    if a.cmd == "table":
        table()
    elif a.cmd == "walks":
        walks()
    elif a.cmd == "trace":
        trace([int(x) for x in a.start.split(",")], [int(x) for x in a.line.split(",")])
    else:
        race(a.skill, a.cases.split(), a.first, a.seeds, a.years, a.out)


if __name__ == "__main__":
    main()
