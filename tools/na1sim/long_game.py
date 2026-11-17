"""Long games: the #48 expand player out to N years, or until it holds every live fief or dies.

The whole-game runner behind #48's unification counts (150 of 340, every start x 20 seeds,
70 years, all battles fought), and the control of #51 and #52 (154 on seeds 3000-3019). It
lived in a session scratchpad until 2026-11-13; a rebuild from `deaths.play`'s defaults (skill 2,
`policy.expand_policy`, the AI's own defence) gave 27 of 340, so the settings below are the
point of this file. Keep them here and change them by flag, not by copy.

  skill 1; policy.OPENING no_retreat, summer_rice_first, line_first, shield_rice=4;
  attacking: expand.expand_policy (Charge when expand.CHARGE); defending:
  strike.Doctrine("control", "contact"); once it holds every live fief, the reader plays on.

From tools/:  py -3.14 -m na1sim.long_game FIEFS SEEDS YEARS [OUT.json] [--first 3000]
  e.g.  py -3.14 -m na1sim.long_game 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16 20 70 long70.json
Yearly rows: (year, held, live, owners, age, exposed, bill, men, econ index per own fief, per AI fief).
`--keep-q 0.25` sizes conquests on the battle lab's q-quantile of survivors, not the mean (#61).
Each result also carries a tally (#61): conq = every real attack (year, season, src, tgt, men, won,
the prize's state right after, fiefs held); losses = every owned fief lost (year, season, fief, new owner).
`--gate-hire 1` hires to the gate line before the economy tops out (#59).
`--pocket N` plans the shape N conquests out (#60: the goal empire with the fewest men per back-line
fief gained); `--pocket-strict 0` lets a fief take a greedy pick while no goal target is ready;
`--staging 1` stages one campaign at a time, toward the goal when --pocket is on.
`--line 3,0` forces an opening line (Kaga, then Noto: nothing else is attacked until the line is
done or broken), then plays on as configured.
`--strike N` (earliest-X strike hire, 2026-11-16): each season a fief that is not topped prices every
neighbour over N seasons, with the target's men growing at its observed rate, under two plans, save
(hire) or grow (give the gold to the peasants first), and follows whichever invades soonest.
`--hold 0` drops the men for holding the prize. `--tol EARLY,LATE,N` lets a conquered fief be left
HUNTABLE or COMING (the rest stay SAFE) while fewer than N fiefs are held, then LATE.
`--skill N` plays at another difficulty (#57: skill 3). `--ev` is #48's tuned weak-start opening:
while the player holds one fief, the season's policy (expand.BASE) is the ev player (8-season
horizon, growth, marks, riots priced), then the reader; #48 ran Saito with it (13 of 300 unified,
40 years, skill 1).
A game counts as unified when, at a Winter, the player's owner holds every live fief.
#48's 150 was run with the merchant always present; `--merchant 0` reproduces it (the default
rolls him, as the cartridge does: 155 on the same seeds, #53).
"""
import argparse
import json
import time
from concurrent.futures import ProcessPoolExecutor

from . import deaths as Dz, ev, policy, reaction, tactical, strike, expand as X, memmap as M

OPENING = dict(no_retreat=1, summer_rice_first=1, line_first=1, shield_rice=4)
SKILL = 1


def econ_index(m, i):
    """Chris's Economic Index for one fief: the cube root of town x output x wealth."""
    f = m.fief(i)
    return (max(0, m.r16(f + M.F_TOWN)) * max(0, m.r16(f + M.F_OUTPUT)) * max(0, m.r16(f + M.F_WEALTH))) ** (1 / 3)


def ev_base(m, idx, rng):
    """#48's Saito opening: the ev player while he holds one fief, then the reader."""
    if len(X.owned(m, m.fief_owner(idx))) == 1:
        ev.ev_policy(m, idx, rng)
    else:
        reaction.reader_policy(m, idx, rng)


def one(job):
    """One game. job = (fief, seed, years[, topped, war_at, fought, need, merchant]); the optional
    knobs are expand.TOPPED, WAR_AT, FOUGHT and a flat CHARGE_NEED, as #48 swept them, and
    policy.MERCHANT (Trade only when game.roll_merchant found one, #53)."""
    fief, seed, years = job[:3]
    if len(job) > 3 and job[3] is not None:
        X.TOPPED = job[3]
    if len(job) > 4 and job[4] is not None:
        X.WAR_AT = job[4]
    if len(job) > 5 and job[5] is not None:
        X.FOUGHT = bool(job[5])
    if len(job) > 6 and job[6]:
        X.CHARGE_NEED = {False: job[6], True: job[6]}
    if len(job) > 7 and job[7] is not None:
        policy.MERCHANT = bool(job[7])
    skill = job[8] if len(job) > 8 and job[8] else SKILL
    if len(job) > 9 and job[9]:
        ev.RIOTS = True
        X.BASE = ev_base
    if len(job) > 10 and job[10] is not None:
        X.GATE_HIRE = bool(job[10])
    X.POCKET = bool(len(job) > 11 and job[11])          # set every job: the pool reuses its workers
    if X.POCKET:
        X.POCKET_DEPTH = job[11]
    if len(job) > 12 and job[12] is not None:
        X.POCKET_STRICT = bool(job[12])
    if len(job) > 13 and job[13] is not None:
        X.STAGING = bool(job[13])
    X.LINE = tuple(job[14]) if len(job) > 14 and job[14] else ()
    X.STRIKE = int(job[15]) if len(job) > 15 and job[15] else 0          # set every job: the pool reuses workers
    X.STRIKE_SHARE = job[16] if len(job) > 16 and job[16] else 100
    X.HOLD = not (len(job) > 17 and job[17] == 0)
    X.KEEP_Q = job[19] if len(job) > 19 and job[19] is not None else None
    tol = job[18] if len(job) > 18 and job[18] else ("SAFE", "SAFE", 0)
    X.TOL_EARLY, X.TOL_LATE, X.TOL_SWITCH = tol[0], tol[1], int(tol[2])
    policy.OPENING.update(OPENING)
    tactical.HUMAN = strike.Doctrine("control", "contact")
    X.LOG.clear()
    X.HIRES.clear()
    X.POCKET_LOG.clear()
    X.STRIKES.clear()
    X.CONQ.clear()
    X.MEN_HIST.clear()
    X._POCKET.clear()
    owner, yearly, t0 = [], [], time.time()

    prev, losses = {}, []

    def pol(m, idx, rng):
        if not owner:
            owner.append(m.fief_owner(fief))
        t = (m.r16(M.CURRENT_GAME_YEAR), m.season)
        now = set(X.owned(m, owner[0]))         # every turn of ours: which of our fiefs changed hands
        for i in prev.get("set", set()) - now:
            losses.append((*t, i, m.fief_owner(i)))
        prev["set"] = now
        if len(yearly) and yearly[-1][1] == yearly[-1][2]:        # holds everything: the reader plays on
            reaction.reader_policy(m, idx, rng)
            return
        X.expand_policy(m, idx, rng)
        if idx == fief and m.season == 3:
            n = m.r16(M.SCENARIO_FIEF_COUNT)
            live = [i for i in range(n) if m.province_ai_state(i) != M.EMPTY]
            age = m.r8(m.fief_daimyo(fief) + M.D_AGE) if m.fief_owner(fief) == owner[0] else None
            bill, exposed, held = X.army_bill(m, owner[0])
            men = sum(m.r16(m.fief(i) + M.F_MEN) for i in X.owned(m, owner[0]))
            mine = X.owned(m, owner[0])
            ai = [i for i in live if m.fief_owner(i) != owner[0]]
            yearly.append((m.r16(M.CURRENT_GAME_YEAR), held, len(live), len({m.fief_owner(i) for i in live}),
                           age, exposed, bill, men,
                           round(sum(econ_index(m, i) for i in mine) / max(1, len(mine)), 1),
                           round(sum(econ_index(m, i) for i in ai) / max(1, len(ai)), 1)))
    rec = Dz.play(fief, seed, years, ("auto",), tail=pol, skill=skill)
    tally = dict(conq=[list(c) for c in X.CONQ], losses=losses)    # per-game events (#61's walk)
    return fief, seed, rec["fatal"], yearly, len(X.LOG), round(time.time() - t0), tally


def unified_year(yearly):
    """The first year the player held every live fief, else None. yearly rows: (year, held, live, ...)."""
    return next((y[0] for y in yearly if y[1] == y[2]), None)


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("fiefs")
    ap.add_argument("seeds", type=int)
    ap.add_argument("years", type=int)
    ap.add_argument("out", nargs="?")
    ap.add_argument("--first", type=int, default=3000)
    ap.add_argument("--topped", type=int)
    ap.add_argument("--war-at", type=int)
    ap.add_argument("--fought", type=int)
    ap.add_argument("--need", type=float, default=0)
    ap.add_argument("--merchant", type=int, help="1: Trade only when the merchant is here (#53)")
    ap.add_argument("--skill", type=int, default=SKILL)
    ap.add_argument("--ev", action="store_true", help="#48's tuned ev opening while holding one fief")
    ap.add_argument("--gate-hire", type=int, help="1: hire to the gate line before topping out (#59)")
    ap.add_argument("--pocket", type=int, default=0, help="N: the pocket planner, N conquests deep (#60)")
    ap.add_argument("--pocket-strict", type=int, help="0: no goal target ready, take the greedy pick")
    ap.add_argument("--line", default="", help="an opening line, e.g. 3,0: take Kaga then Noto, nothing else first (#60)")
    ap.add_argument("--staging", type=int, help="1: one campaign at a time (with --pocket: toward the goal)")
    ap.add_argument("--strike", type=float, default=0, help="Y: strike hire, a soft neighbour within Y years of gold")
    ap.add_argument("--strike-share", type=int, default=100, help="percent of a season's gold into men toward it")
    ap.add_argument("--hold", type=int, default=1, help="0: the strike does not pay for holding the prize")
    ap.add_argument("--tol", default="", help="EARLY,LATE,N: the state a conquered fief may be left in while fewer than N "
                    "fiefs are held, then LATE, e.g. HUNTABLE,SAFE,3 (default SAFE everywhere)")
    ap.add_argument("--keep-q", type=float, help="q: price the survivors at the battle lab's q-quantile (#61)")
    a = ap.parse_args()
    fiefs = [int(x) for x in a.fiefs.split(",")]
    jobs = [(f, s, a.years, a.topped, a.war_at, a.fought, a.need, a.merchant, a.skill, a.ev, a.gate_hire,
             a.pocket, a.pocket_strict, a.staging,
             [int(x) for x in a.line.split(',') if x], a.strike, a.strike_share,
             a.hold, tuple(a.tol.split(",")) if a.tol else None, a.keep_q)
            for f in fiefs for s in range(a.first, a.first + a.seeds)]
    with ProcessPoolExecutor(6) as ex:
        res = list(ex.map(one, jobs))
    json.dump(res, open(a.out or f"long_game_{a.years}.json", "w"), default=str)
    for f, s, fatal, yearly, att, secs, *_ in res:
        last = yearly[-1] if yearly else None
        peak = max((y[1] for y in yearly), default=0)
        print(f"f{f:2} s{s} {secs:4}s  fatal {fatal and (fatal['cause'], fatal['year'])}  last {last}"
              f"  peak fiefs {peak}  attacks {att}  unified {unified_year(yearly)}")
    print(f"unified {sum(1 for r in res if unified_year(r[3]))} of {len(res)}")


if __name__ == "__main__":
    main()
