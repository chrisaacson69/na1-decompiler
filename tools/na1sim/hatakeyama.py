"""Hatakeyama's opening: what order to fix morale, loyalty, men and the tax (Chris, 2026-11-09).

Noto starts at morale 23 and loyalty 24, both under the 45 line: a revolt (morale) is a rebel battle
that can take the faction at once, a riot (loyalty) is survivable with gold in hand, and the tax
raise that pays for everything takes another cut off loyalty. One action a season; this searches the
first turns over full and half moves and scores each plan by the share of games alive at year 2 and
year 6, paired by seed, with how the lost games ended.

Run from tools/:  py -3.14 -m na1sim.hatakeyama [--depth 2] [--seeds 100] [--beam 6] [--skill 2] [--years 3]
                                       [--workers 4] [--out FILE.jsonl]   (resumes from FILE)
"""
import argparse
import collections
import json
import os
import time
from concurrent.futures import ProcessPoolExecutor, as_completed
from itertools import product

from . import deaths, memmap as M, policy

FIEF = 0
HONGANJI_NEAR = (1, 4, 15)        # Honganji's coin-fief neighbours: Uesugi, Asakura, Takeda


def _part(give, gold, share):
    def act(m, idx):
        f = m.fief(idx)
        have = m.r16(f + (M.F_GOLD if gold else M.F_RICE)) - 1
        give(m, idx, have * share // 100, gold=gold)
    return act


EXTRA = {
    "gold>men/2": _part(policy.give_men, True, 50),
    "rice>men/2": _part(policy.give_men, False, 50),
    "gold>peasants/2": _part(policy.give_peasants, True, 50),
    "rice>peasants/2": _part(policy.give_peasants, False, 50),
    "tax40": lambda m, idx: policy.set_tax(m, idx, 40),
    "hire/2": lambda m, idx: policy.hire_men(m, idx, (m.r16(m.fief(idx) + M.F_GOLD) - 1) // 2),
}


def _summer_rice(m, idx):
    """Chris (2026-11-09): in Summer, once every enemy neighbour has moved, the shield is free until
    the harvest refills it before Fall's command. All the rice goes (to men while morale is under the
    line, else to the peasants); otherwise the default plays the season."""
    acted = getattr(m, "acted", set())
    if m.season == 1 and all(j in acted for j in policy._enemy_neighbors(m, idx)):
        f = m.fief(idx)
        give = policy.give_men if m.r16(f + M.F_MORALE) < policy.CLIFF else policy.give_peasants
        give(m, idx, m.r16(f + M.F_RICE) - 1)
    else:
        policy.expand_policy(m, idx, m.turn_rng)


def _hire_line(pad):
    """Hire to the fewest men that leave no threat (reaction.men_line), plus `pad` percent; all the
    gold if the line is out of reach. Chris (2026-11-09): an undershoot is fatal, but an overshoot
    pays upkeep in gold and rice at every harvest."""
    def act(m, idx):
        from . import reaction
        f = m.fief(idx)
        men, gold = m.r16(f + M.F_MEN), m.r16(f + M.F_GOLD)
        line = reaction.men_line(m, idx)
        if line is None:
            policy.hire_men(m, idx, gold - 1)
            return
        want = line * (100 + pad) // 100 - men
        rate = m.r16(M.GOLD_MEN_HIRE_RATE) or 50
        if want > 0:
            policy.hire_men(m, idx, min(gold - 1, -(-want * rate // 10)))
    return act


def _hire_part(share):
    return lambda m, idx: policy.hire_men(m, idx, (m.r16(m.fief(idx) + M.F_GOLD) - 1) * share // 100)


EXTRA["summer-rice"] = _summer_rice
EXTRA.update({"hire-line": _hire_line(0), "hire-line+25": _hire_line(25), "hire-line+50": _hire_line(50),
              "hire/4": _hire_part(25), "hire3/4": _hire_part(75)})
policy.OPENING_ACTIONS.update(EXTRA)
MENU = ("auto", "tax", "tax40", "hire", "hire/2", "gold>men", "gold>men/2", "rice>men", "rice>men/2",
        "gold>peasants", "gold>peasants/2", "rice>peasants", "rice>peasants/2", "train")


def _job(args):
    plan, s0, s1, skill, years = args
    out = []
    for seed in range(s0, s1):
        g = deaths.play(FIEF, seed, years, plan, skill=skill)
        fat = g["fatal"]
        out.append((seed, fat["year"] if fat else 0, fat["cause"] if fat else None,
                    sum(1 for i in g["boosted"] if i in HONGANJI_NEAR)))
    return plan, out


def run(plans, seeds, first, skill, years, workers, out=None, label="run"):
    """Play every plan over the seeds in chunks of 25. With `out`, each finished chunk is appended to
    that JSONL file and chunks already in it are skipped, so a stopped run resumes. (Not
    max_tasks_per_child: on Windows the pool hung once every worker had retired; a worker peaks
    near 35 MB, so there is nothing to recycle.)"""
    res = collections.defaultdict(list)
    done = set()
    if out and os.path.exists(out):
        for line in open(out):
            r = json.loads(line)
            if (r["skill"], r["years"]) == (skill, years):
                res[tuple(r["plan"])].extend(map(tuple, r["rows"]))
                done.add((tuple(r["plan"]), r["s0"]))
    jobs = [(p, s, min(s + 25, first + seeds), skill, years) for p in plans
            for s in range(first, first + seeds, 25) if (p, s) not in done]
    print(f"[{label}] {len(plans)} plans x {seeds} seeds, skill {skill}, year {years}: "
          f"{len(jobs)} chunks to play, {len(done)} resumed, {workers} workers", flush=True)
    t0 = time.time()
    with ProcessPoolExecutor(workers) as ex:
        futs = {ex.submit(_job, j): j for j in jobs}
        for n, fut in enumerate(as_completed(futs), 1):
            p, rows = fut.result()
            res[p].extend(rows)
            if out:
                with open(out, "a") as fh:
                    fh.write(json.dumps(dict(plan=p, s0=futs[fut][1], skill=skill, years=years, rows=rows)) + "\n")
            if n % 10 == 0 or n == len(jobs):
                el = time.time() - t0
                left = el / n * (len(jobs) - n)
                ready = [(score(r, years), q) for q, r in res.items() if q in plans and len(r) >= 50]
                lead = max(ready) if ready else None
                tail = f" | leader {' / '.join(lead[1])} {lead[0]:.0%} at y{years}" if lead else ""
                print(f"[{label}] {n}/{len(jobs)} chunks ({n / len(jobs):.0%}), {sum(len(r) for r in res.values())} games, "
                      f"{el / 60:.0f}m in, ~{left / 60:.0f}m left{tail}", flush=True)
    seedset = set(range(first, first + seeds))
    return {p: [r for r in res[p] if r[0] in seedset] for p in plans}


def score(rows, year):
    return sum(1 for _s, y, _c, _b in rows if y == 0 or y > year) / len(rows)


def show(res, years, top=12):
    print(f"{'plan':52}{'y2':>6}{'y' + str(years):>6}  y{years} by Honganji neighbours doubled 0/1/2+  | deaths by cause")
    for p, rows in sorted(res.items(), key=lambda kv: (-score(kv[1], years), -score(kv[1], 2)))[:top]:
        c = collections.Counter(cause for _s, y, cause, _b in rows if y)
        split = "/".join(f"{score(b, years):.0%}({len(b)})" if b else "-" for b in
                         ([r for r in rows if min(r[3], 2) == k] for k in (0, 1, 2)))
        print(f"{' / '.join(p):52}{score(rows, 2):6.1%}{score(rows, years):6.1%}  {split:28}| "
              + ", ".join(f"{k} {v}" for k, v in c.most_common()), flush=True)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--depth", type=int, default=2)
    ap.add_argument("--seeds", type=int, default=100)
    ap.add_argument("--first", type=int, default=5000)
    ap.add_argument("--beam", type=int, default=6)
    ap.add_argument("--skill", type=int, default=2)
    ap.add_argument("--years", type=int, default=3)
    ap.add_argument("--workers", type=int, default=4)
    ap.add_argument("--out", help="JSONL of finished chunks: appended to, and resumed from")
    ap.add_argument("--plans", help="score only these, ';'-separated, actions ','-separated")
    a = ap.parse_args()
    go = lambda plans, label="plans": run(plans, a.seeds, a.first, a.skill, a.years, a.workers, a.out, label)
    if a.plans:
        res = go([tuple(p.split(",")) for p in a.plans.split(";")])
        show(res, a.years, top=len(res))
        return
    plans = list(product(MENU, repeat=2))
    res = go(plans, f"s{a.skill} depth 2")
    print(f"depth 2, {len(plans)} plans, {a.seeds} seeds, skill {a.skill}, scored at year {a.years}")
    show(res, a.years)
    for d in range(3, a.depth + 1):
        best = sorted(res, key=lambda p: -score(res[p], a.years))[:a.beam]
        plans = [p + (x,) for p in best for x in MENU if p[-1] != "auto" or x == "auto"]
        res = go(plans, f"s{a.skill} depth {d}")
        print(f"\ndepth {d}, beam {a.beam}, {len(plans)} plans")
        show(res, a.years)


if __name__ == "__main__":
    main()
