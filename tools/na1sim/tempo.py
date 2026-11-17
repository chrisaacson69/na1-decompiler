"""tempo.py - is the year of the first conquest what decides the game? (ledger #61)

Reads long_game result files that share starts and seeds (every file: the same 17 starts x seeds)
and cuts win rate by the first conquest's year three ways, each controlling more:
  pooled     P(win | first conquest year)
  in-start   at/before each start's median year vs after (removes "strong starts do both")
  paired     the same start AND seed under two configs, first conquests 2+ years apart, banded by
             whether the later one still lands by DEADLINE (#61: it is a deadline, not a slope)
and how the expanders lose on either side of the deadline.

From tools/:  py -3.14 -m na1sim.tempo RESULT.json [RESULT.json ...]
"""
import collections
import itertools
import json
import sys

DEADLINE = 12
BUCKETS = ((5, "<=5"), (7, "6-7"), (9, "8-9"), (12, "10-12"), (16, "13-16"), (999, "17+"))


def load(path):
    """{(fief, seed): (first conquest year from the start or None, won, cause or None, peak fiefs)}."""
    out = {}
    for f, s, fatal, y, *_ in json.load(open(path)):
        if not y:
            out[(f, s)] = (None, False, fatal and fatal["cause"], 1)
            continue
        y0 = y[0][0] - 1
        won = any(r[1] == r[2] for r in y)
        out[(f, s)] = (next((r[0] - y0 for r in y if r[1] > 1), None), won,
                       None if won else (fatal["cause"] if fatal else "stalled"), max(r[1] for r in y))
    return out


def main(paths):
    runs = [load(p) for p in paths]
    games = [g for r in runs for g in r.items()]
    pool = collections.defaultdict(lambda: [0, 0])
    for _, (fc, w, *_) in games:
        k = "never" if fc is None else next(n for lim, n in BUCKETS if fc <= lim)
        pool[k][0] += 1
        pool[k][1] += w
    print(f"{len(runs)} files, {len(games)} games")
    print("pooled  P(win | first conquest year): " + "  ".join(
        f"{n}: {pool[n][1] / pool[n][0]:.0%} (n {pool[n][0]})" for _, n in BUCKETS + ((0, "never"),) if pool[n][0]))
    e = l = ne = nl = better = starts = 0
    for f in sorted({k[0] for k, _ in games}):
        fcs = sorted(v[0] for k, v in games if k[0] == f and v[0])
        if len(fcs) < 40:
            continue
        med = fcs[len(fcs) // 2]
        ew = [v[1] for k, v in games if k[0] == f and v[0] and v[0] <= med]
        lw = [v[1] for k, v in games if k[0] == f and v[0] and v[0] > med]
        if ew and lw:
            starts += 1
            better += sum(ew) / len(ew) > sum(lw) / len(lw)
            e, ne, l, nl = e + sum(ew), ne + len(ew), l + sum(lw), nl + len(lw)
    if starts:
        print(f"in-start  early {e / ne:.0%}  late {l / nl:.0%}  (early ahead on {better} of {starts} starts)")
    band = collections.defaultdict(collections.Counter)
    for a, b in itertools.combinations(runs, 2):
        for k in a:
            (fa, wa, *_), (fb, wb, *_) = a[k], b.get(k, (None,) * 4)
            if fa is None or fb is None or abs(fa - fb) < 2:
                continue
            we, wl = (wa, wb) if fa < fb else (wb, wa)
            hi, lo = max(fa, fb), min(fa, fb)
            c = band[f"both by {DEADLINE}" if hi <= DEADLINE else
                     (f"later after {DEADLINE}" if lo <= DEADLINE else f"both after {DEADLINE}")]
            c["n"] += 1
            c["e"] += we
            c["l"] += wl
    for name, c in band.items():
        print(f"paired  {name:15} {c['n']:6} pairs  earlier won {c['e'] / c['n']:.0%}  later won {c['l'] / c['n']:.0%}")
    for side, test in ((f"by {DEADLINE}", lambda fc: fc <= DEADLINE), (f"after {DEADLINE}", lambda fc: fc > DEADLINE)):
        gs = [v for _, v in games if v[0] and test(v[0])]
        if gs:
            c = collections.Counter("WIN" if v[1] else v[2] for v in gs)
            print(f"first conquest {side:9} n {len(gs):5}  " + "  ".join(f"{k} {n / len(gs):.0%}" for k, n in c.most_common()))


if __name__ == "__main__":
    main(sys.argv[1:])
