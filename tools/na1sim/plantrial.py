"""Paired trial of the fixed battle plans (plans.py) on a fief's captured battle starts.

  py -3.14 -m na1sim.plantrial tools/_battles/f1-k1-y6-expand-s3000x300.pkl.gz [--out rows.json]

Arms, each replaying the same start: the AI's own play (as captured), the AI with no retreat,
the doctrine (strike.Doctrine), and PlanPlayer strike / hold / run. Per battle: held (the fief keeps
its owner), the end code (1 a flight, 3 day 30, 4 out of rice, 5/6 a commander killed), and the
fiefs the defender's lord gains (a daimyo-led attacker that loses hands over his faction, $DED4).
"""
import pickle

from . import memmap as M, tactical as T, battles as B, strike as S, plans as P

ARMS = ("ai_nr", "doctrine", "strike", "hold", "run")


def _owned(m, owner):
    return sum(1 for i in range(m.r16(M.SCENARIO_FIEF_COUNT)) if m.fief_owner(i) == owner
               and m.province_ai_state(i) != M.EMPTY)


def _player(arm):
    if arm == "doctrine":
        return S.Doctrine()
    if arm in ("strike", "hold", "run"):
        return P.PlanPlayer(1, P.ECHIGO, arm)
    return None


SCALE = 1.0


def _scale(m):
    """Headless what-if: the attacker's committed men and rice times SCALE (his days of food unchanged);
    the units are dealt from the side total at battle_init ($91D5), so this is the whole army."""
    a = m.side_resource_ptr(0)
    for k in (M.SR_MEN, M.SR_RICE):
        m.w16(a + k, min(0xFFFF, round(m.r16(a + k) * SCALE)))


def _init(scale):
    global SCALE
    SCALE = scale


def _one(rec):
    m0, _ = pickle.loads(rec["start"])
    if SCALE != 1.0:
        _scale(m0)
    m0.cur_combat_side = 0
    edge = T.set_combat_arena_rect_by_approach(m0)
    led = bool(m0.r8(M.WAR_SIDE_STATE_FLAG) & 0x80)
    me = rec["def_owner"]
    before = _owned(m0, me)
    row = dict(fief=rec["defender"], seed=rec["seed"], attacker=rec["attacker"], edge=edge, led=led, scale=SCALE,
               atk_men=m0.r16(m0.side_resource_ptr(0) + M.SR_MEN),
               def_men=rec["def_men"], atk_days=rec["atk_days"], ai=rec["won"], ai_code=rec["outcome"])
    for arm in ARMS:
        T.HUMAN = _player(arm)
        try:
            code, held, _, m = B.replay(rec, {"no_retreat": 1}, _scale if SCALE != 1.0 else None)
        finally:
            T.HUMAN = None
        row[arm] = held
        row[arm + "_code"] = code
        row[arm + "_gain"] = _owned(m, me) - before if held else 0
    return row


def trial(recs, scale=1.0, procs=6):
    from concurrent.futures import ProcessPoolExecutor
    with ProcessPoolExecutor(procs, initializer=_init, initargs=(scale,)) as ex:
        return list(ex.map(_one, recs, chunksize=4))


def report(rows):
    cols = ("ai",) + ARMS
    def line(name, rs):
        if not rs:
            return
        held = "".join(f"{sum(r[c] for r in rs):7}" for c in cols)
        gain = "".join(f"{sum(r.get(c + '_gain', 0) for r in rs if c != 'ai'):7}" for c in ARMS)
        print(f"{name:26}{len(rs):4} |{held} |{gain}")
    print(f"{'held / fiefs gained':26}{'n':>4} |" + "".join(f"{c:>7}" for c in cols) + " |" + "".join(f"{c:>7}" for c in ARMS))
    line("all invasions", rows)
    rows = [r for r in rows if r["fief"] == 1]
    line("Echigo itself", rows)
    for e, nm in ((2, "south"), (3, "west"), (4, "east")):
        line(f"  from the {nm}", [r for r in rows if r["edge"] == e])
    line("  daimyo-led", [r for r in rows if r["led"]])
    line("  a general", [r for r in rows if not r["led"]])
    for lo, hi in ((0, 1), (1, 1.5), (1.5, 2), (2, 3), (3, 99)):
        line(f"  men ratio {lo}-{hi if hi < 99 else ''}", [r for r in rows if r["def_men"] and lo <= r["atk_men"] / r["def_men"] < hi])
    for lo, hi in ((0, 20), (20, 30), (30, 999)):
        line(f"  days of food {lo}-{hi if hi < 999 else ''}", [r for r in rows if lo <= r["atk_days"] < hi])


def main():
    import argparse, json
    from pathlib import Path
    ap = argparse.ArgumentParser()
    ap.add_argument("path")
    ap.add_argument("--out")
    ap.add_argument("--scale", default="1", help="attacker men and rice multipliers, e.g. 1,1.5,2,3")
    a = ap.parse_args()
    recs = [r for r in B.load(Path(a.path)) if r["kind"] == "invasion"]
    rows = []
    for sc in (float(v) for v in a.scale.split(",")):
        rs = trial(recs, sc)
        if sc != 1.0 or "," in a.scale:
            print(f"\n=== attacker men and rice x{sc:g} ===")
        report(rs)
        rows += rs
    if a.out:
        json.dump(rows, open(a.out, "w"))


if __name__ == "__main__":
    main()
