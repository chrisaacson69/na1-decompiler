"""chain.py - the assassinate-and-buy chain: from each start, which fiefs fall, how fast, and what
garrisons come with them (ledger #56). A static map read, not a game: the AI's own wars are left out,
so it is the upper bound of the pure line Chris described (the TAS / speedrun opening).

The rules it uses (each from the ROM; see #55):
  * the kill is not limited by the map ("Send where" takes any fief), the purchase is: an ownerless
    fief is auctioned only to the owners bordering it (`auction_ownerless_fief_to_bidders` $8C75);
  * with fewer than two bordering owners the fief gets a new lord instead (`install_new_daimyo`), so a
    fief that borders only you can never be bought;
  * the fief comes with its army: `neutralize_fief` $E459 leaves the fief record alone;
  * one command per fief you run, every season (ch.11), and the ninja carries your lord's stats from
    any fief, so each fief you hold is another assassin the next season;
  * "killable" = Luck gate open at its mean and P(kill on the first try) >= --certain (assassin.py).
Assumptions: you win every auction you may enter (an AI bids rng(its gold), the winner pays the last
bid made, #55); a dead neighbour does not count as a bordering owner; the starting board is the
scenario's, each lord on his own fief, garrisons at the table + 5·skill.

  py -3.14 -m na1sim.chain                              # every start, your roll 109/109/109, skill 1
  py -3.14 -m na1sim.chain --cha 95 --iq 95 --luck 95 --skill 2 --certain 0.9
  py -3.14 -m na1sim.chain --start 16 --verbose         # one start, season by season
"""
from __future__ import annotations

import argparse

from .assassin import p_counter
from .loader import load_adjacency, load_daimyos, load_provinces


def killable(cha, iq, luck, skill, certain):
    out = set()
    for d in load_daimyos():
        tl, tc, ti = d.luck + 5 * skill, d.charisma + 5 * skill, d.iq + 5 * skill
        if tl < luck + 30 and tc + ti <= cha + iq and 1 - p_counter(cha, tc, skill) >= certain:
            out.add(d.id)
    return out


def chain(start, cha, iq, luck, skill, certain=1.0, max_seasons=40):
    adj, provs = load_adjacency(), load_provinces()
    men = {p.idx: p.men + 5 * skill for p in provs}
    can = killable(cha, iq, luck, skill, certain) - {start}
    mine, alive = {start}, set(range(17)) - {start}
    log, lost = [], []
    for season in range(1, max_seasons + 1):
        # one assassin per fief held. Buy first what is about to close (fewest other bordering
        # owners), then the bigger garrison; never kill what could not be bought.
        def others(f, chosen):
            return {n for n in adj[f] if n in alive and n not in chosen and n != f}
        frontier = []
        for f in sorted({n for g in mine for n in adj[g]} & alive & can,
                        key=lambda f: (len(others(f, set())), -men[f])):
            trial = frontier + [f]
            if len(trial) <= len(mine) and all(others(g, set(trial)) for g in trial):
                frontier = trial
        if not frontier:
            break
        alive -= set(frontier)
        bought = []
        for f in frontier:
            owners = {n for n in adj[f] if n in alive} | ({0} if set(adj[f]) & mine else set())
            if set(adj[f]) & mine and len(owners) >= 2:
                bought.append(f)
            else:
                lost.append(f)
        mine |= set(bought)
        log.append((season, frontier, bought))
    return dict(mine=mine, log=log, lost=lost, men=sum(men[f] for f in mine - {start}),
                seasons=len(log), can=can)


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--cha", type=int, default=109)
    ap.add_argument("--iq", type=int, default=109)
    ap.add_argument("--luck", type=int, default=109)
    ap.add_argument("--skill", type=int, default=1)
    ap.add_argument("--certain", type=float, default=1.0, help="min P(kill) on the first try")
    ap.add_argument("--start", type=int, help="one start fief (0-16) instead of all")
    ap.add_argument("--verbose", action="store_true")
    a = ap.parse_args()
    names = {p.idx: p.name for p in load_provinces()}
    lords = {d.id: d.name for d in load_daimyos()}
    starts = [a.start] if a.start is not None else range(17)
    rows = [(s, chain(s, a.cha, a.iq, a.luck, a.skill, a.certain)) for s in starts]
    print(f"your roll Cha {a.cha} IQ {a.iq} Luck {a.luck}, skill {a.skill}, kill if P(first try) >= {a.certain:.0%}")
    print(f"  {'start':18} {'fiefs':>5} {'men':>5} {'seasons':>7}  chain (fief: season bought) / lost to a new lord")
    for s, r in sorted(rows, key=lambda x: (-len(x[1]['mine']), -x[1]['men'])):
        seq = ", ".join(f"{names[f]}:{se}" for se, _, b in r["log"] for f in b)
        lost = ", ".join(names[f] for f in r["lost"])
        print(f"  {names[s] + ' (' + lords[s][:8] + ')':18} {len(r['mine']):5} {r['men']:5} {r['seasons']:7}  "
              f"{seq or '-'}" + (f"  / lost: {lost}" if lost else ""))
        if a.verbose:
            for se, front, b in r["log"]:
                print(f"      season {se}: kill {[names[f] for f in front]}, buy {[names[f] for f in b]}")


if __name__ == "__main__":
    main()
