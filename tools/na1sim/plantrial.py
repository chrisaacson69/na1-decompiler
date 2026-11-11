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
FIEF = 1
PLANS = {1: (P.ECHIGO, None, ("ai_nr", "doctrine", "strike", "hold", "run")),
         8: (P.MINO, P.MINO_GATE, ("ai_nr", "control", "gate", "hold"))}


def _owned(m, owner):
    return sum(1 for i in range(m.r16(M.SCENARIO_FIEF_COUNT)) if m.fief_owner(i) == owner
               and m.province_ai_state(i) != M.EMPTY)


def _player(arm):
    if arm == "doctrine":
        return S.Doctrine()
    if arm == "control":
        return S.Player("control")
    if arm in ("strike", "hold", "run", "gate"):
        cells, stations, _ = PLANS[FIEF]
        return P.PlanPlayer(FIEF, cells, arm, stations=stations)
    return None


SCALE = 1.0
SPLIT = None          # an Assign before the battle (strike.assign), e.g. (96, 1, 1, 1, 1)


def _scale(m):
    """Headless what-if: the attacker's committed men and rice times SCALE (his days of food unchanged);
    the units are dealt from the side total at battle_init ($91D5), so this is the whole army."""
    a = m.side_resource_ptr(0)
    for k in (M.SR_MEN, M.SR_RICE):
        m.w16(a + k, min(0xFFFF, round(m.r16(a + k) * SCALE)))


def _prep(m):
    if SCALE != 1.0:
        _scale(m)
    if SPLIT:
        S.assign(SPLIT)(m)


def _init(scale, fief=1, split=None):
    global SCALE, FIEF, ARMS, SPLIT
    SCALE, FIEF, SPLIT = scale, fief, split
    ARMS = PLANS[fief][2]


def _one(rec):
    m0, _ = pickle.loads(rec["start"])
    try:
        _prep(m0)
    except ValueError:
        return None
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
            code, held, _, m = B.replay(rec, {"no_retreat": 1}, _prep)
        finally:
            T.HUMAN = None
        row[arm] = held
        row[arm + "_code"] = code
        row[arm + "_gain"] = _owned(m, me) - before if held else 0
    return row


def trial(recs, scale=1.0, procs=6):
    from concurrent.futures import ProcessPoolExecutor
    _init(scale, FIEF, SPLIT)
    with ProcessPoolExecutor(procs, initializer=_init, initargs=(scale, FIEF, SPLIT)) as ex:
        return [r for r in ex.map(_one, recs, chunksize=4) if r is not None]


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
    rows = [r for r in rows if r["fief"] == FIEF]
    line("the fief itself", rows)
    for e, nm in ((1, "north"), (2, "south"), (3, "west"), (4, "east")):
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
    ap.add_argument("--fief", type=int, default=1, help="the planned fief (1 Echigo, 8 Mino)")
    ap.add_argument("--split", help="an Assign before each battle, e.g. 96,1,1,1,1")
    ap.add_argument("--scale", default="1", help="attacker men and rice multipliers, e.g. 1,1.5,2,3")
    a = ap.parse_args()
    global FIEF, SPLIT
    FIEF = a.fief
    SPLIT = tuple(int(v) for v in a.split.split(",")) if a.split else None
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
