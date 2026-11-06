"""How the player's game ends, for every starting fief: the cause, the season, the attacker and the
share of men that let it attack. Nothing here changes the game: it wraps the calls where a fief can
be lost and asks, after each, whether the player still has one.

An AI attacks a human past a 47% share of provisioned men with no coin (the grudge path). Its usual
gate needs about 71-76% (ratio - 10 - rng(skill * 3) > 60) and a neighbour's coin only binds AI
targets. So a share of 48-70 is the grudge alone, and 71 up would pass either way.

Run from tools/:  py -3.14 -m na1sim.deaths [--seeds 300] [--years 6] [--fiefs 1,2]
"""
import argparse
import collections
import json
import random
from concurrent.futures import ProcessPoolExecutor

from . import ai_vm, game, loader, memmap as M, policy, setup, vmprims as P

NAMES = ("Hatakeyama Uesugi Hojo Honganji Asakura Hida Imagawa Tokugawa Saito Tsutsui Asai Rokkaku "
         "Kitabatake Ashikaga Miyoshi Takeda Oda").split()
LOG = None
BASE_MEN = {p.idx: p.men for p in loader.load_provinces()}
COIN_FIEFS = (1, 2, 4, 7, 10, 15, 16)      # apply_scenario_starting_stat_boosts: 1 in 2, AI fiefs only


def doubled(m, skill=2):
    """The fiefs the setup's coin doubled on this board."""
    return [i for i in COIN_FIEFS if m.province_ai_state(i) == M.AI_HOME
            and m.r16(m.fief(i) + M.F_MEN) == 2 * (BASE_MEN[i] + 5 * skill)]


class Log:
    """One game's record. `fatal` is set by the first wrapped call the player does not survive."""

    def __init__(self, m, fief):
        self.m, self.fief = m, fief
        self.turns = 0
        self.year = 1
        self.fatal = None
        self.attacks = []       # every AI attack on the player: (year, season, share, committed, won)
        self.riots = self.riots_paid = self.rebel_battles = 0

    def alive(self):
        m = self.m
        return any(m.fief_owner(i) == self.fief and m.province_ai_state(i) != M.EMPTY
                   for i in range(m.r16(M.SCENARIO_FIEF_COUNT)))

    def check(self, cause, **detail):
        if self.fatal is None and not self.alive():
            self.fatal = dict(cause=cause, year=self.year, season=self.m.season, turns=self.turns, **detail)


def _commit(orig):
    def wrapped(m, resolve=ai_vm._no_resolve):
        log = LOG
        if log is None or m.fief_owner(m.defending) != log.fief or m.fief_owner(m.selected) == log.fief:
            return orig(m, resolve)
        d = m.fief(m.defending)
        a = m.fief(m.selected)
        info = dict(share=ai_vm.fief_men_ratio_pct(m, m.selected, m.defending), attacker=m.fief_owner(m.selected),
                    atk_men=m.r16(a + M.F_MEN), def_men=m.r16(d + M.F_MEN), def_rice=m.r16(d + M.F_RICE),
                    def_gold=m.r16(d + M.F_GOLD), def_morale=m.r16(d + M.F_MORALE))
        seen = []

        def res(mm):
            seen.append(mm.r16(M.WAR_ATTACKER_MEN))
            return resolve(mm)
        r = orig(m, res)
        if seen:
            log.check("invasion", committed=seen[0], **info)
            log.attacks.append((log.year, m.season, info["share"], seen[0], log.alive()))
        return r
    return wrapped


def _after(cause, orig):
    def wrapped(*a, **k):
        r = orig(*a, **k)
        if LOG is not None:
            LOG.check(cause)
        return r
    return wrapped


def _riot(orig):
    def wrapped(m, i, pay):
        r = orig(m, i, pay)
        if LOG is not None and m.fief_owner(i) == LOG.fief:
            LOG.riots += 1
            LOG.riots_paid += bool(r)
        return r
    return wrapped


def _rebels(orig):
    def wrapped(m, i, is_uprising, rng):
        r = orig(m, i, is_uprising, rng)
        if LOG is not None and m.fief_owner(i) == LOG.fief or LOG is not None and not LOG.alive():
            LOG.rebel_battles += 1
            LOG.check("riot" if is_uprising else "revolt")
        return r
    return wrapped


ai_vm.ai_commit_attack_deduct_resources = _commit(ai_vm.ai_commit_attack_deduct_resources)
game.natural_death = _after("lord died", game.natural_death)
game._lose_fief = _after("rebels", game._lose_fief)
game._rebel_battle = _rebels(game._rebel_battle)
P.human_riot = _riot(P.human_riot)


def play(fief, seed, years=6, plan=("auto",), tail=policy.expand_policy, skill=2):
    """One game -> the record of how it went."""
    global LOG
    m = setup.build_board(skill=skill, seed=seed, player_fief=fief)
    rng = random.Random(10000 + seed)
    LOG = log = Log(m, fief)
    boosted = doubled(m, skill)
    near = [i for i in boosted if i in m.neighbor_rows.get(fief, [])]
    pol = policy.plan_policy(fief, list(plan), tail=tail)

    def counted(mm, idx, r):
        log.turns += 1
        pol(mm, idx, r)
    for yr in range(1, years + 1):
        log.year = yr
        for s in range(4):
            game.step_season(m, s, rng, counted)
            log.check("other")
        m.w16(M.CURRENT_GAME_YEAR, 1560 + yr)
        if log.fatal:
            break
    LOG = None
    return dict(seed=seed, boosted=boosted, near=near, fatal=log.fatal, attacks=log.attacks, riots=log.riots, paid=log.riots_paid,
                rebels=log.rebel_battles)


def _chunk(job):
    fief, s0, s1, years, plan, skill, opening, tail = job
    policy.OPENING.update(opening)
    from . import reaction
    pol = reaction.reaction_policy if tail == "reaction" else policy.expand_policy
    return fief, [play(fief, s, years, plan, tail=pol, skill=skill) for s in range(s0, s1)]


def bucket(d):
    if d["cause"] != "invasion":
        return d["cause"]
    s = d["share"]
    return "invaded: share <=47" if s <= 47 else "invaded: grudge 48-70" if s <= 70 else "invaded: 71+"


def report(results, years):
    keys = ["invaded: grudge 48-70", "invaded: 71+", "invaded: share <=47", "riot", "revolt", "rebels", "lord died", "other"]
    print(f"{'fief':11}{'alive':>6} | {'y1':>4}{'y2':>4}{'y3+':>4} | {'grudge':>6}{'71+':>5}{'<=47':>5}{'riot':>5}{'rvlt':>5}{'rebl':>5}{'lord':>5}{'othr':>5} |"
          f" {'0turn':>5} | fatal mean: share me/them  | attacks/game won%")
    for f in sorted(results):
        g = results[f]
        fat = [x["fatal"] for x in g if x["fatal"]]
        c = collections.Counter(bucket(d) for d in fat)
        y = collections.Counter(min(d["year"], 3) for d in fat)
        inv = [d for d in fat if d["cause"] == "invasion"]
        att = [a for x in g for a in x["attacks"]]
        mean = lambda k: sum(d[k] for d in inv) / max(len(inv), 1)
        print(f"{NAMES[f]:11}{1 - len(fat) / len(g):6.1%} | {y[1]:4}{y[2]:4}{y[3]:4} | " + f"{c[keys[0]]:6}{c[keys[1]]:5}{c[keys[2]]:5}{c[keys[3]]:5}{c[keys[4]]:5}{c[keys[5]]:5}{c[keys[6]]:5}{c[keys[7]]:5} |"
              f" {sum(1 for d in fat if d['turns'] == 0):5} | {mean('share'):4.0f} {mean('def_men'):4.0f}/{mean('atk_men'):<4.0f}"
              f" commit {mean('committed'):4.0f} | {len(att) / len(g):5.2f} {sum(a[4] for a in att) / max(len(att), 1):4.0%}")


def by_board(results):
    print("alive by how many NEIGHBOURS the setup doubled (games in brackets)")
    for f in sorted(results):
        g = results[f]
        line = f"{NAMES[f]:11}"
        for k in (0, 1, 2):
            s = [x for x in g if min(len(x["near"]), 2) == k]
            line += f" {k}{'+' if k == 2 else ' '}: {sum(1 for x in s if not x['fatal']) / max(len(s), 1):5.1%} ({len(s):3})"
        each = []
        for i in sorted({i for x in g for i in x["near"]}):
            s = [x for x in g if i in x["near"]]
            o = [x for x in g if i not in x["near"]]
            each.append(f"{NAMES[i]} {sum(1 for x in s if not x['fatal']) / len(s):.0%}/{sum(1 for x in o if not x['fatal']) / max(len(o), 1):.0%}")
        print(line, " | doubled/not:", ", ".join(each))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--seeds", type=int, default=300)
    ap.add_argument("--first", type=int, default=3000)
    ap.add_argument("--years", type=int, default=6)
    ap.add_argument("--fiefs", default=",".join(map(str, range(17))))
    ap.add_argument("--plan", default="auto")
    ap.add_argument("--skill", type=int, default=2)
    ap.add_argument("--tail", default="expand", help="expand or reaction")
    ap.add_argument("--opening", default="", help="policy.OPENING overrides: keep_rice=1,picker=1")
    ap.add_argument("--out")
    a = ap.parse_args()
    plan = tuple(a.plan.split(","))
    opening = {k: int(v) for k, v in (kv.split("=") for kv in a.opening.split(",") if kv)}
    jobs = [(int(f), s, min(s + 50, a.first + a.seeds), a.years, plan, a.skill, opening, a.tail) for f in a.fiefs.split(",")
            for s in range(a.first, a.first + a.seeds, 50)]
    res = collections.defaultdict(list)
    with ProcessPoolExecutor(6) as ex:
        for f, rows in ex.map(_chunk, jobs):
            res[f].extend(rows)
    report(res, a.years)
    by_board(res)
    if a.out:
        json.dump(res, open(a.out, "w"))


if __name__ == "__main__":
    main()
