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
    policy.OPENING.update(OPENING)
    tactical.HUMAN = strike.Doctrine("control", "contact")
    X.LOG.clear()
    X.HIRES.clear()
    owner, yearly, t0 = [], [], time.time()

    def pol(m, idx, rng):
        if not owner:
            owner.append(m.fief_owner(fief))
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
            yearly.append((m.r16(M.CURRENT_GAME_YEAR), held, len(live), len({m.fief_owner(i) for i in live}),
                           age, exposed, bill, men))
    rec = Dz.play(fief, seed, years, ("auto",), tail=pol, skill=skill)
    return fief, seed, rec["fatal"], yearly, len(X.LOG), round(time.time() - t0)


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
    a = ap.parse_args()
    fiefs = [int(x) for x in a.fiefs.split(",")]
    jobs = [(f, s, a.years, a.topped, a.war_at, a.fought, a.need, a.merchant, a.skill, a.ev)
            for f in fiefs for s in range(a.first, a.first + a.seeds)]
    with ProcessPoolExecutor(6) as ex:
        res = list(ex.map(one, jobs))
    json.dump(res, open(a.out or f"long_game_{a.years}.json", "w"), default=str)
    for f, s, fatal, yearly, att, secs in res:
        last = yearly[-1] if yearly else None
        peak = max((y[1] for y in yearly), default=0)
        print(f"f{f:2} s{s} {secs:4}s  fatal {fatal and (fatal['cause'], fatal['year'])}  last {last}"
              f"  peak fiefs {peak}  attacks {att}  unified {unified_year(yearly)}")
    print(f"unified {sum(1 for r in res if unified_year(r[3]))} of {len(res)}")


if __name__ == "__main__":
    main()
