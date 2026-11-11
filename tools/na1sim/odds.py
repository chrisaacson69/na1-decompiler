"""Battle odds for a defending fief (#45): P(the defence holds) by his men x the attacker's committed
men, split daimyo-led / a general, on real captured starts (attacker, edge, terrain, stats).

Per start and grid cell: the defending fief's men set to D and its rice to max(captured, D) (30 days:
rice 0 and short rice are the harvest's losses, not this table's); the attacker's committed men set to
A and his rice scaled with them (his days of food unchanged). The defender plays strike.Doctrine,
no retreat, as in the whole-game runs.

  py -3.14 -m na1sim.odds tools/_battles/f8-k1-y3-expand-s3000x300.pkl.gz --fief 8 --n 200 \\
      --out tools/na1sim/odds_f8.json
"""
import json
import pickle
import random
from pathlib import Path

from . import memmap as M, tactical as T, battles as B, strike as S

DEF = (20, 30, 40, 50, 60, 75, 90, 110, 130)
ATK = (20, 30, 40, 50, 60, 80, 100, 120, 150, 180, 250)


def _led(rec):
    return bool(pickle.loads(rec["start"])[0].r8(M.WAR_SIDE_STATE_FLAG) & 0x80)


def _one(job):
    rec, d, a = job

    def prep(m):
        f = m.fief(m.defending)
        m.w16(f + M.F_MEN, d)
        m.w16(f + M.F_RICE, max(m.r16(f + M.F_RICE), d))
        sr = m.side_resource_ptr(0)
        men = m.r16(sr + M.SR_MEN)
        m.w16(sr + M.SR_RICE, max(1, round(m.r16(sr + M.SR_RICE) * a / max(1, men))))
        m.w16(sr + M.SR_MEN, a)
    T.HUMAN = S.Doctrine("control", "contact")
    try:
        _, held, _, _ = B.replay(rec, {"no_retreat": 1}, prep)
    finally:
        T.HUMAN = None
    return d, a, _led(rec), bool(held)


def table(recs, procs=6):
    """-> {"def": DEF, "atk": ATK, "led": [[p]], "general": [[p]], "n": {...}}, rows his men."""
    from concurrent.futures import ProcessPoolExecutor
    jobs = [(r, d, a) for d in DEF for a in ATK for r in recs]
    with ProcessPoolExecutor(procs) as ex:
        rows = list(ex.map(_one, jobs, chunksize=8))
    out = {"def": DEF, "atk": ATK, "n": {"led": sum(map(_led, recs)), "general": len(recs) - sum(map(_led, recs))}}
    for key, led in (("led", True), ("general", False)):
        grid = []
        for d in DEF:
            line = []
            for a in ATK:
                rs = [h for dd, aa, ll, h in rows if dd == d and aa == a and ll == led]
                line.append(round(sum(rs) / len(rs), 3) if rs else None)
            grid.append(line)
        out[key] = grid
    return out


def main():
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("path")
    ap.add_argument("--fief", type=int, default=8)
    ap.add_argument("--n", type=int, default=200)
    ap.add_argument("--out")
    a = ap.parse_args()
    recs = [r for r in B.load(Path(a.path)) if r["kind"] == "invasion" and r["defender"] == a.fief]
    random.Random(1).shuffle(recs)
    t = table(recs[:a.n])
    for key in ("led", "general"):
        print(f"\n-- P(held), {key} (n {t['n'][key]}): rows his men, columns the committed men")
        print("  men " + "".join(f"{x:>7}" for x in ATK))
        for d, line in zip(DEF, t[key]):
            print(f"  {d:4}" + "".join(f"{p:7.2f}" for p in line))
    if a.out:
        Path(a.out).write_text(json.dumps(t))


if __name__ == "__main__":
    main()
