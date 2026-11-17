"""skill_lab.py - the expander's fought attack, at each difficulty (ledger #58).

The expander prices an attack with skill-blind numbers: a win when men sent >= CHARGE_NEED x the
defender's men (2.0x, "~90%"), keeping CHARGE_KEEP of the men sent (expand.py, from #48's replays at
skill 1). The battle map reads skill in several places (`tactical.py`: the per-exchange morale hit
$9FEE, a human side 6 - skill and an AI side skill; the strength scale 115 - 15·skill $9CF4; the bribe
$A721/$A780). This lab fights the same attacks on the battle map at each skill: one attacker, one
target, the attacker's men set to r x the target's, the doctrine's Assign split made first, the
charge fought (expand.player_war with an rng), and counts the wins and the men left in the fief.

  py -3.14 -m na1sim.skill_lab                     # the default pairs, skills 1 and 3
  py -3.14 -m na1sim.skill_lab --skills 1,2,3 --seeds 30 --ratios 1.5,2,2.5,3,4
  py -3.14 -m na1sim.skill_lab --skills 1,2,3 --seeds 30 --ratios 2,2.5,3,4,6 --quantiles --out keep_q.json

--quantiles (#61) adds the spread of the men kept: a won battle's survivors are not the mean; the
low tail is what leaves a conquest HUNTABLE or COMING. --out saves every won battle's kept share by
skill and ratio, the table expand.KEEP_Q reads.
"""
from __future__ import annotations

import json

import argparse
import random
from concurrent.futures import ProcessPoolExecutor

from . import expand as X, memmap as M, setup, vmprims as P

# (source, target), 0-based: Owari->Mino, Owari->Mikawa, Omi->Yamashiro, Echizen->Kaga, Settsu->Yamato,
# Mino->Omi, Iseshima->Iga
PAIRS = ((16, 8), (16, 7), (10, 13), (4, 3), (14, 9), (8, 10), (12, 11))


def one(job):
    skill, src, tgt, ratio, seed = job
    m = setup.build_board(skill=skill, seed=seed, player_fief=src)
    f, t = m.fief(src), m.fief(tgt)
    dmen = m.r16(t + M.F_MEN)
    men = max(1, int(dmen * ratio))
    m.w16(f + M.F_HEADER, max(m.r16(f + M.F_HEADER), men + 10))
    m.w16(f + M.F_MEN, men)
    m.w16(f + M.F_GOLD, men + 50)
    m.w16(f + M.F_RICE, men * 2)
    split = X.desired_split(m, src, tgt)
    if P.assign_reachable(m, src, split):
        P.commit_arms_record(m, src, split, 0)
    won = X.player_war(m, src, tgt, men, men * 2, rng=random.Random(seed), fought=True)
    left = m.r16(t + M.F_MEN) if won else 0
    return skill, src, tgt, ratio, bool(won), left / men


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--skills", default="1,3")
    ap.add_argument("--ratios", default="1.5,2,2.5,3")
    ap.add_argument("--seeds", type=int, default=20)
    ap.add_argument("--first", type=int, default=5000)
    ap.add_argument("--quantiles", action="store_true", help="the kept share's q10 / q25 / median too")
    ap.add_argument("--out", help="save {skill: {ratio: [kept share of each won battle]}} as JSON")
    a = ap.parse_args()
    skills = [int(s) for s in a.skills.split(",")]
    ratios = [float(r) for r in a.ratios.split(",")]
    jobs = [(s, src, tgt, r, seed) for s in skills for src, tgt in PAIRS for r in ratios
            for seed in range(a.first, a.first + a.seeds)]
    with ProcessPoolExecutor(6) as ex:
        res = list(ex.map(one, jobs, chunksize=4))
    print(f"wins / {a.seeds * len(PAIRS)} (all pairs), and the men kept per man sent when won; expand assumes "
          f"~90% at {X.CHARGE_NEED[False]}x")
    print(f"  {'ratio':>5} " + "".join(f"| skill {s}: win   kept " for s in skills))
    for r in ratios:
        line = f"  {r:5.2f} "
        for s in skills:
            rows = [x for x in res if x[0] == s and x[3] == r]
            w = [x for x in rows if x[4]]
            kept = sum(x[5] for x in w) / len(w) if w else 0
            line += f"|       {len(w) / len(rows):5.0%}  {kept:5.2f} "
        print(line)
    if a.quantiles:
        print("kept per man sent, won battles only: q10 / q25 / median / mean")
        for r in ratios:
            line = f"  {r:5.2f} "
            for s in skills:
                k = sorted(x[5] for x in res if x[0] == s and x[3] == r and x[4])
                q = (lambda p: k[min(len(k) - 1, int(p * len(k)))]) if k else (lambda p: 0)
                line += f"| s{s}: {q(.1):.2f} {q(.25):.2f} {q(.5):.2f} {sum(k) / max(1, len(k)):.2f} "
            print(line)
    if a.out:
        table = {s: {r: sorted(round(x[5], 4) for x in res if x[0] == s and x[3] == r and x[4]) for r in ratios}
                 for s in skills}
        json.dump(table, open(a.out, "w"))
    print("by pair at 2.0x:")
    for src, tgt in PAIRS:
        print(f"  {src:2}->{tgt:2} " + "  ".join(
            f"skill {s}: {sum(x[4] for x in res if x[0] == s and x[1] == src and x[2] == tgt and x[3] == 2.0):2}/{a.seeds}"
            for s in skills))


if __name__ == "__main__":
    main()
