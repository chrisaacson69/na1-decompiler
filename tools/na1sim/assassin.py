"""assassin.py - price the Ninja ▸ Assassinate mission from its rules (ledger #55).

The rules, `effect_ninja_sabotage` $A2D2 → `ninja_mission_resolve_vs_defender` $918D, checked in the
cartridge with tools/na1_play.py (#55):

  1. the target fief is a daimyo's capital ($A349, else "The daimyo is out", nothing spent) and is
     run by the AI ($9192: ai_state 0; a human's fiefs are immune);
  2. Luck gate ($A36C): target Luck < your Luck + 30;
  3. contest ($91A2): target (Cha + IQ) <= your (Cha + IQ);
  4. counterattack ($91D5): target Cha - rng(10·skill) > your Cha - rng(10·skill). Your lord loses
     rng(health/2)+1 health and 1 Charisma; the target is untouched;
  5. otherwise the hit lands and KILLS: $9293 is `230 > health` (cmp_sgt is regA > regB), so any
     landed hit that is not a counter sets health 0, and the faction falls (`find_fiefs_of_owner`).
     Not attrition. The empty-fief defensive roll ($9213) needs rng(Luck/100) != 0, i.e. Luck >= 200,
     so it never blocks, and the ninja count never matters: one ninja does it.
  A failure at 2 or 3 costs 1 Charisma ($92E4 / effect_ninja_failed). Gold is (rate·n + 9)/10.

AI lords carry the ROM table + 5·skill on health, Drive, Luck, Charisma, IQ
(`apply_scenario_starting_stat_boosts` $83E2; seen in the cartridge at skills 1, 3, 5), and Luck then
drifts rng(11) - 5 every season (`drift_daimyo_luck` $A2ED). The player's lord gets no boost: each of
his five stats is rolled rng(50)+60, 60-109, re-rollable without limit ($85FC).

  py -3.14 -m na1sim.assassin                       # the table: three player rolls x skill 1-3
  py -3.14 -m na1sim.assassin --cha 95 --iq 90 --luck 100 --health 80 --skill 2 --year 1565

Cost of a success, all variables: see cost_of_success(); the formula is written out in ledger #55.
"""
from __future__ import annotations

import argparse
from functools import lru_cache

from .loader import load_daimyos


def p_counter(my_cha: int, t_cha: int, skill: int) -> float:
    """P(t_cha - U1 > my_cha - U2), U1, U2 uniform on 0 .. n-1, n = 10·skill. Closed form
    (checked against enumeration for skills 1-5, every d): with d = my_cha - t_cha,
      d >= n-1 : 0
      0 <= d   : (n-d-1)(n-d) / 2n^2
      -n < d < 0: 1 - (n+d)(n+d+1) / 2n^2
      d <= -n  : 1"""
    n, d = 10 * skill, my_cha - t_cha
    if d >= n - 1:
        return 0.0
    if d <= -n:
        return 1.0
    if d >= 0:
        return (n - d - 1) * (n - d) / (2 * n * n)
    return 1 - (n + d) * (n + d + 1) / (2 * n * n)


def gold_per_try(year: int) -> float:
    """Mean gold for one ninja: (rate + 9) // 10, rate = (rng(101) + (year-1560)·10 + 4) // 4, rolled
    once a year (`roll_period_market_rates` $92A5; each mission nudges it, ignored here)."""
    return sum(((r + (year - 1560) * 10 + 4) // 4 + 9) // 10 for r in range(101)) / 101


def cost_of_success(my_cha, my_iq, my_health, t_cha, t_iq, skill, year=1560, max_tries=40):
    """Try every season until the kill or until the contest closes (each counter or failure costs
    1 Cha). Luck gate assumed open. -> P(kill ever), and per campaign the expected tries (= season
    commands), gold, your health lost (rng(h/2)+1 a counter, mean (h//2 + 1)/2), Charisma lost."""
    g = gold_per_try(year)

    @lru_cache(maxsize=None)
    def go(cha, h, left):
        if left == 0 or t_cha + t_iq > cha + my_iq:   # contest closed: stop trying
            return 0.0, 0.0, 0.0, 0.0
        pc = p_counter(cha, t_cha, skill)
        hit = (h // 2 + 1) / 2
        p, n, dh, dc = go(cha - 1, max(0, h - round(hit)), left - 1)
        return (1 - pc) + pc * p, 1 + pc * n, pc * (hit + dh), pc * (1 + dc)

    p, n, dh, dc = go(my_cha, my_health, max_tries)
    return dict(p_kill=p, tries=n, gold=n * g, health=dh, cha=dc)


def table(cha, iq, luck, health, skill, year=1560, player=None):
    rows = []
    for d in load_daimyos():
        if d.id == player:
            continue
        tl, tc, ti = d.luck + 5 * skill, d.charisma + 5 * skill, d.iq + 5 * skill
        margin = luck + 30 - tl                         # > 0 open; each Luck drifts +-5 a season
        gate = "open" if margin > 10 else "drifts" if margin > -10 else "SHUT"
        if tc + ti > cha + iq:
            rows.append((d.name, tl, tc, ti, gate, None, None))
            continue
        rows.append((d.name, tl, tc, ti, gate, 1 - p_counter(cha, tc, skill),
                     cost_of_success(cha, iq, health, tc, ti, skill, year)))
    return rows


def show(cha, iq, luck, health, skill, year=1560, player=None):
    print(f"\nyou Cha {cha} IQ {iq} Luck {luck} health {health} (Cha+IQ {cha + iq}), skill {skill}, {year}"
          f" ({gold_per_try(year):.1f} gold a try)")
    print(f"  {'target':10} {'L':>4} {'Cha':>4} {'IQ':>4}  {'Luck gate':9} {'1st try':>7} {'ever':>5}"
          f" {'tries':>5} {'gold':>5} {'health':>6} {'Cha':>5}")
    for name, tl, tc, ti, gate, p1, c in table(cha, iq, luck, health, skill, year, player):
        head = f"  {name:10} {tl:4} {tc:4} {ti:4}  {gate:9}"
        if c is None:
            print(head + " contest lost (a try's gold and 1 Cha, never a kill)")
        else:
            print(head + f" {p1:7.0%} {c['p_kill']:5.0%} {c['tries']:5.2f} {c['gold']:5.1f}"
                         f" {-c['health']:6.1f} {-c['cha']:5.2f}")


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--cha", type=int)
    ap.add_argument("--iq", type=int)
    ap.add_argument("--luck", type=int)
    ap.add_argument("--health", type=int, default=85, help="your lord's health (rolled 60-109)")
    ap.add_argument("--skill", type=int, default=1)
    ap.add_argument("--year", type=int, default=1560)
    ap.add_argument("--player", type=int, help="your lord's id (0-16), left out of the table")
    a = ap.parse_args()
    if a.cha is not None:
        show(a.cha, a.iq, a.luck, a.health, a.skill, a.year, a.player)
        return
    for cha, iq, luck in [(109, 109, 109), (95, 95, 95), (85, 85, 85)]:
        for skill in (1, 2, 3):
            show(cha, iq, luck, a.health, skill, a.year, 16)


if __name__ == "__main__":
    main()
