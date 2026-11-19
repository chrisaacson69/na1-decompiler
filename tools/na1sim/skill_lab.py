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
    skill, src, tgt, ratio, seed = job[:5]
    X.SPLIT_MODE = job[5] if len(job) > 5 else None     # set every job: the pool reuses workers
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
    elif X.SPLIT_MODE == "solo":
        return skill, src, tgt, ratio, None, 0, 0           # the editor cannot make it here
    won = X.player_war(m, src, tgt, men, men * 2, rng=random.Random(seed), fought=True)
    left = m.r16(t + M.F_MEN) if won else 0
    after = m.r16(t + M.F_MEN) if not won else 0            # a loss: the garrison against its men before
    return skill, src, tgt, ratio, bool(won), left / men, (after - dmen) / max(1, men) if not won else 0


def _arm(m, src, tgt, men):
    """Give src `men` (gold and rice to send them) and the doctrine's split for tgt -> False if unreachable."""
    f = m.fief(src)
    m.w16(f + M.F_HEADER, max(m.r16(f + M.F_HEADER), men + 10))
    m.w16(f + M.F_MEN, men)
    m.w16(f + M.F_GOLD, men + 50)
    m.w16(f + M.F_RICE, men * 2)
    split = X.desired_split(m, src, tgt)
    if P.assign_reachable(m, src, split):
        P.commit_arms_record(m, src, split, 0)
        return True
    return False


def waves(job):
    """#77 (Chris: the double attack, priced from the lab): wave 1 from src at r1 x the garrison; if it
    loses, wave 2 from a second neighbour of tgt (made ours, with src's morale, skill and arms) at r2 x the
    ORIGINAL garrison, the same season. Against one wave of r1 + r2 from src on the same board and seed.
    -> (skill, src, tgt, r1, r2, wave1 won, garrison after a lost wave 1 / before, two-wave won,
        kept share of the total sent, one-wave won, its kept share)"""
    skill, src, tgt, r1, r2, seed, split1 = job
    out = []
    for mode in ("two", "one"):
        m = setup.build_board(skill=skill, seed=seed, player_fief=src)
        t = m.fief(tgt)
        dmen = m.r16(t + M.F_MEN)
        if mode == "one":
            men = max(1, int(dmen * (r1 + r2)))
            _arm(m, src, tgt, men)
            won = X.player_war(m, src, tgt, men, men * 2, rng=random.Random(seed), fought=True)
            out += [bool(won), (m.r16(t + M.F_MEN) / men) if won else 0]
            continue
        n = m.r16(M.SCENARIO_FIEF_COUNT)
        src2 = next(b for b in m.neighbor_rows.get(tgt, []) if b < n and b not in (src, tgt)
                    and m.province_ai_state(b) != M.EMPTY)
        m1 = max(1, int(dmen * r1))
        X.SPLIT_MODE = split1                   # the first wave's split (solo: 100/0, no 1% left to capture)
        reach = _arm(m, src, tgt, m1)
        stats = [m.r16(m.fief(src) + off) for off in (M.F_MORALE, M.F_SKILL, M.F_ARMS)]   # before the
        # battle: a lost wave empties src and clear_military_stats_if_no_men zeroes them
        w1 = X.player_war(m, src, tgt, m1, m1 * 2, rng=random.Random(seed), fought=True)
        X.SPLIT_MODE = None
        g1 = m.r16(t + M.F_MEN) / max(1, dmen) if not w1 else None
        won, kept = bool(w1), (m.r16(t + M.F_MEN) / m1 if w1 else 0)
        if not w1 and m.fief_owner(tgt) != m.fief_owner(src):
            fs, f2 = m.fief(src), m.fief(src2)
            m.w8(M.FIEF_TO_DAIMYO_MAP + src2, m.fief_owner(src))
            m.w8(M.PROVINCE_AI_STATE + src2, M.PLAYER_DIRECT)
            m.w8(M.FIEF_IS_CAPITAL + src2, 0)
            for off, v in zip((M.F_MORALE, M.F_SKILL, M.F_ARMS), stats):
                m.w16(f2 + off, v)
            m2 = max(1, int(dmen * r2))
            _arm(m, src2, tgt, m2)
            w2 = X.player_war(m, src2, tgt, m2, m2 * 2, rng=random.Random(seed + 7919), fought=True)
            won, kept = bool(w2), (m.r16(t + M.F_MEN) / (m1 + m2) if w2 else 0)
        out = [skill, src, tgt, r1, r2, bool(w1), g1, won, kept] + out
    return tuple(out) + (reach,)


def main_waves(a):
    skills = [int(s) for s in a.skills.split(",")]
    pairs = [tuple(float(x) for x in w.split("+")) for w in a.waves.split(",")]
    jobs = [(s, src, tgt, r1, r2, seed, a.split) for s in skills for src, tgt in PAIRS for r1, r2 in pairs
            for seed in range(a.first, a.first + a.seeds)]
    with ProcessPoolExecutor(6) as ex:
        res = list(ex.map(waves, jobs, chunksize=4))
    N = a.seeds * len(PAIRS)
    print(f"first wave split: {a.split or 'doctrine (heavy 1/99)'}")
    print(f"two waves (r1 then r2, each x the original garrison, wave 2 from a second fief) against one wave of "
          f"r1 + r2; {N} battles each")
    print("  skill  r1+r2  | wave1 won  garrison left by a lost wave 1 | two waves won  kept/sent | one wave won  kept/sent")
    for s in skills:
        for r1, r2 in pairs:
            rows = [x for x in res if x[0] == s and x[3] == r1 and x[4] == r2]
            w1 = sum(x[5] for x in rows)
            g = [x[6] for x in rows if x[6] is not None]
            tw = [x for x in rows if x[7]]
            ow = [x for x in rows if x[9]]
            print(f"  {s:5}  {r1:.2f}+{r2:.2f} | {w1 / N:8.0%}   {sum(g) / max(1, len(g)):5.2f} (n {len(g)})"
                  f"                | {len(tw) / N:12.0%}  {sum(x[8] for x in tw) / max(1, len(tw)):8.2f}"
                  f" | {len(ow) / N:11.0%}  {sum(x[10] for x in ow) / max(1, len(ow)):8.2f}")
    print(f"first-wave splits the Assign could not make (fought with the fief's own): {sum(1 for x in res if not x[-1])} of {len(res)}")
    if a.out:
        json.dump(res, open(a.out, "w"))


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--skills", default="1,3")
    ap.add_argument("--ratios", default="1.5,2,2.5,3")
    ap.add_argument("--seeds", type=int, default=20)
    ap.add_argument("--first", type=int, default=5000)
    ap.add_argument("--split", help="solo: 100/0/0/0/0, the commander leading; sacrifice: the usual split, the commander charges once the strikers are spent (#62)")
    ap.add_argument("--quantiles", action="store_true", help="the kept share's q10 / q25 / median too")
    ap.add_argument("--out", help="save {skill: {ratio: [kept share of each won battle]}} as JSON")
    ap.add_argument("--waves", help="#77: two-wave sequences r1+r2 (x the garrison), e.g. 1+1.5,1.5+1.5")
    a = ap.parse_args()
    if a.waves:
        return main_waves(a)
    skills = [int(s) for s in a.skills.split(",")]
    ratios = [float(r) for r in a.ratios.split(",")]
    jobs = [(s, src, tgt, r, seed, a.split) for s in skills for src, tgt in PAIRS for r in ratios
            for seed in range(a.first, a.first + a.seeds)]
    with ProcessPoolExecutor(6) as ex:
        res = list(ex.map(one, jobs, chunksize=4))
    print(f"wins / {a.seeds * len(PAIRS)} (all pairs), and the men kept per man sent when won; expand assumes "
          f"~90% at {X.CHARGE_NEED[False]}x")
    print(f"  {'ratio':>5} " + "".join(f"| skill {s}: win   kept " for s in skills))
    for r in ratios:
        line = f"  {r:5.2f} "
        for s in skills:
            rows = [x for x in res if x[0] == s and x[3] == r and x[4] is not None]
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
    lost = [x for x in res if x[4] is False]
    if lost:
        print("lost battles: the defender's garrison change per man sent (> 0: the attack fed him)")
        for r in ratios:
            for s in skills:
                ls = [x[6] for x in lost if x[0] == s and x[3] == r]
                if ls:
                    print(f"  {r:5.2f} skill {s}: {len(ls)} lost, mean {sum(ls) / len(ls):+.2f}, fed {sum(1 for v in ls if v > 0)}")
    skipped = sum(1 for x in res if x[4] is None)
    if skipped:
        print(f"{skipped} jobs skipped: the split is not reachable by Assign on that fief")
    print("by pair at 2.0x:")
    for src, tgt in PAIRS:
        print(f"  {src:2}->{tgt:2} " + "  ".join(
            f"skill {s}: {sum(x[4] for x in res if x[0] == s and x[1] == src and x[2] == tgt and x[3] == 2.0):2}/{a.seeds}"
            for s in skills))


if __name__ == "__main__":
    main()
