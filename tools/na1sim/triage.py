"""triage.py - a long_game run sorted the way Chris reads it (2026-11-20).

Unified games are set aside. The losses, in order: revolts and riots (maybe the 1-in-1,000 roll; hedge?),
invasions before the player's first turn (only the defence can help), early invasions (the first year),
later invasions (should get a look), and old age by peak fiefs (never got started, or one short).

  py -3.14 -m na1sim.triage RUN.json [--start F]
"""
import argparse
import collections
import json


def won(y):
    return next((r[0] for r in y if r[1] == r[2]), None) if y else None


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("run")
    ap.add_argument("--start", type=int, help="only this start fief")
    a = ap.parse_args()
    res = json.load(open(a.run))
    if a.start is not None:
        res = [g for g in res if g[0] == a.start]
    groups = collections.defaultdict(list)
    per = collections.defaultdict(collections.Counter)
    for g in res:
        f, s, fatal, y = g[0], g[1], g[2] or {}, g[3]
        peak = max((r[1] for r in y), default=0)
        last = y[-1] if y else None
        if won(y):
            per[f]["unified"] += 1
            continue
        cause, year, turns = fatal.get("cause"), fatal.get("year"), fatal.get("turns", 0)
        if cause in ("revolt", "riot"):
            k = "1 revolt/riot"
        elif cause == "invasion" and turns == 0:
            k = "2 invaded before turn 1"
        elif cause == "invasion" and year is not None and year <= 1:
            k = "3 invaded in year 1"
        elif cause == "invasion":
            k = "4 invaded later"
        elif cause == "lord died":
            k = "5 old age, never started" if peak <= 5 else "6 old age, one short" if peak >= 15 else "5b old age, stalled"
        else:
            k = "7 other"
        per[f][k] += 1
        groups[k].append((f, s, cause, year, turns, peak, last[1] if last else 0, last[3] - 1 if last else None, fatal))
    keys = ["unified", "1 revolt/riot", "2 invaded before turn 1", "3 invaded in year 1", "4 invaded later",
            "5 old age, never started", "5b old age, stalled", "6 old age, one short", "7 other"]
    short = ["won", "rvlt", "T0", "y1", "later", "age<=5", "age6-14", "age15+", "other"]
    print(f"{len(res)} games: unified {sum(p['unified'] for p in per.values())}")
    print(" start | " + " ".join(f"{h:>7}" for h in short))
    for f in sorted(per):
        print(f" {f:5} | " + " ".join(f"{per[f][k]:7}" for k in keys))
    print(" total | " + " ".join(f"{sum(p[k] for p in per.values()):7}" for k in keys))
    for k in keys[1:]:
        if not groups[k]:
            continue
        print(f"\n{k[2:] if k[1] == ' ' else k[3:]} ({len(groups[k])}):")
        for f, s, cause, year, turns, peak, end, rivals, fatal in sorted(groups[k]):
            extra = ""
            if cause == "invasion":
                extra = (f"  attacker {fatal.get('attacker')} committed {fatal.get('committed')} of {fatal.get('atk_men')}"
                         f" vs our {fatal.get('def_men')} men, {fatal.get('def_rice')} rice")
            print(f"   start {f:2} seed {s}  year {year:>2} (turn {turns:>4})  peak {peak:2} end {end:2} rivals {rivals}{extra}")


if __name__ == "__main__":
    main()
