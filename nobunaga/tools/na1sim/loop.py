"""
Turn coordinator — the per-season strategic loop (ch.13 + appendix-events.md).

One season =
  Spring : aging (age+1/health-1) + AI loyalty/wealth boon + player decay
  Summer : re-seed high-water marks
  (every): ONE seasonal event class (typhoon | plague | uprising[riot|revolt])
  (every): command pass — turn-order shuffle, each fief acts (AI cascade or
           player policy); AI wars resolve off-screen inline
  Fall   : harvest sweep (income/debt/upkeep)
then advance season/year and check elimination/victory.

Run an all-AI sample game (no player) to watch the natural 17-fief dynamics:
    py -3 -m na1sim.loop
"""

import random
from . import econ, ai, combat
from .state import World, AI_HOME, AI_DIRECT

SEASONS = ["Spring", "Summer", "Fall", "Winter"]


def square_roll(x: int, rng: random.Random) -> bool:
    """square_over_2025_probability_roll: min(x,50)^2 < rng(2025). Fires when a
    stat is LOW; zero at x>=45. This is how bad events home in on weak fiefs."""
    return min(x, 50) ** 2 < rng.randrange(2025)


# ---------------------------------------------------------------------------
def _spring(world: World, rng: random.Random):
    for d in world.daimyos:
        if d.alive:
            d.age += 1
            d.health = max(0, d.health - 1)
    for p in world.provinces:
        if p.owner < 0:
            continue
        cha = world.daimyos[p.owner].charisma
        if p.ai_state == AI_HOME:
            if rng.randrange(2) == 0:                      # AI boon (rubber-band)
                p.wealth = min(100, p.wealth + rng.randrange(10) + cha // 10)
                p.loyalty = min(100, p.loyalty + rng.randrange(40) + cha // 10)
        elif world.skill > 1:                              # player decay (state!=0, skill>1)
            p.wealth = max(0, p.wealth - rng.randrange(world.skill))
            p.loyalty = max(0, p.loyalty - rng.randrange(world.skill))
            p.morale = max(0, p.morale - rng.randrange(world.skill))


def _events(world: World, rng: random.Random, log):
    # one event class per season (ai_strategic_turn_planner $A455)
    if world.season == 1 and rng.randrange(2) == 0:                 # Summer typhoon
        for p in world.provinces:
            if p.owner >= 0 and rng.randrange(40) < 3:
                p.wealth = max(0, p.wealth - (rng.randrange(4) + 1))
                p.output = econ.pct_op(p.output, econ.pct_op(p.dams, 90))
        return
    if rng.randrange(4) == 0:                                       # Plague
        for p in world.provinces:
            if p.owner >= 0 and rng.randrange(40) < 3:
                p.men = econ.pct_op(p.men, rng.randrange(50) + 50)
                p.output = econ.pct_op(p.output, rng.randrange(50) + 50)
        return
    # Uprising dispatcher — 50/50 revolt vs riot. The stochastic gate is
    # square_roll (the real eligibility primitive); a separate per-fief 3%
    # inclusion was far too strict (it zeroed the mechanic — appendix puts a
    # low-morale fief at ~10-25%/yr). Only morale/loyalty < 45 fiefs qualify.
    is_revolt = rng.randrange(2) == 0
    for p in world.provinces:
        if p.owner < 0 or not world.daimyos[p.owner].alive:
            continue
        cha = world.daimyos[p.owner].charisma
        if is_revolt:    # morale variant -> ownership flip
            if p.men > 2 and (square_roll(p.morale, rng) or square_roll(cha, rng)
                              or rng.randrange(1000) == 0):
                lost = combat.resolve_uprising(world, p.idx, rng)
                log.append(f"REVOLT {p.name}(mor{p.morale}) -> "
                           f"{'FIEF LOST' if lost else 'crushed'}")
        else:            # loyalty variant -> loyalty dock (recoverable)
            if p.men > 2 and p.output > 0 and (
                    square_roll(p.loyalty, rng) or square_roll(100 - p.tax, rng)
                    or square_roll(cha, rng) or rng.randrange(1000) == 0):
                pre = p.loyalty
                p.loyalty -= econ.pct_op(p.loyalty, rng.randrange(10) + 10)
                log.append(f"RIOT {p.name}(loy{pre}->{p.loyalty})")


def _command_pass(world: World, rng: random.Random, player_policy, log):
    order = list(range(len(world.provinces)))
    rng.shuffle(order)
    for idx in order:
        p = world.provinces[idx]
        if p.owner < 0 or not world.daimyos[p.owner].alive:
            continue
        if p.ai_state == AI_DIRECT and player_policy is not None:
            player_policy(world, idx, rng)
        else:
            ai.decide_ai_fief(world, idx, rng, combat.resolve_offscreen)


def _harvest(world: World, rng: random.Random):
    for p in world.provinces:
        if p.owner >= 0:
            econ.harvest_fief(p, world.daimyos[p.owner], rng)


def step_season(world: World, rng: random.Random, player_policy=None, log=None):
    if log is None:
        log = []
    econ.SKILL = world.skill
    if world.season == 0:
        _spring(world, rng)
    if world.season == 1:
        for p in world.provinces:
            p.reseed_marks()
    _events(world, rng, log)
    _command_pass(world, rng, player_policy, log)
    if world.season == 2:
        _harvest(world, rng)
    world.season = (world.season + 1) % 4
    if world.season == 0:
        world.year += 1
        # market men-price ramps ~5 -> ~15 over the campaign
        world.men_price = min(15, 5 + (world.year - 1560) // 2)
    return log


def living_factions(world: World):
    return sorted({p.owner for p in world.provinces
                   if p.owner >= 0 and world.daimyos[p.owner].alive})


def fief_counts(world: World):
    counts = {}
    for p in world.provinces:
        if p.owner >= 0:
            counts[p.owner] = counts.get(p.owner, 0) + 1
    return counts


def run_game(world: World, years=15, player_policy=None, rng=None):
    if rng is None:
        rng = random.Random(0)
    for _ in range(years * 4):
        step_season(world, rng, player_policy)
        if len(living_factions(world)) <= 1:
            break
    return world


# ---------------------------------------------------------------------------
HIDA_CLAN = 5   # Anekoji — Hida's clan id == its starting fief idx


def base_test(skill=2, n_seeds=40, years=20):
    """0-player base test: all 17 fiefs are AI. Run n_seeds games and report the
    survival curve for Hida and the overall elimination tempo."""
    from .loader import build_world
    names = [d.name for d in build_world().daimyos]
    n_clans = len(names)
    alive_by_year = [0.0] * years        # sum of clan-counts across seeds, per year
    hida_alive_by_year = [0] * years     # seeds where Anekoji is alive, per year
    hida_death_years = []                # death year per seed (None -> survived)
    all_deaths = []                      # every clan death year (tempo)
    reach_one = []                       # year the game collapses to a single clan
    clan_survived = [0] * n_clans        # seeds where clan c alive at end
    clan_deaths = [[] for _ in range(n_clans)]   # death years per clan

    for seed in range(n_seeds):
        w = build_world(seed=seed)
        w.skill = skill
        rng = random.Random(seed)
        prev = set(living_factions(w))
        elim = {}
        won_year = None
        for yr in range(years):
            for _ in range(4):
                step_season(w, rng)
            alive = set(living_factions(w))
            for d in prev - alive:
                elim[d] = w.year - 1
            prev = alive
            alive_by_year[yr] += len(alive)
            if HIDA_CLAN in alive:
                hida_alive_by_year[yr] += 1
            if won_year is None and len(alive) <= 1:
                won_year = w.year - 1
        hida_death_years.append(elim.get(HIDA_CLAN))
        all_deaths += list(elim.values())
        if won_year is not None:
            reach_one.append(won_year)
        for c in range(n_clans):
            if c in prev:
                clan_survived[c] += 1
            elif c in elim:
                clan_deaths[c].append(elim[c])

    def med(xs):
        xs = sorted(xs)
        return xs[len(xs) // 2] if xs else None

    print(f"=== 0-player base test: skill {skill}, {n_seeds} seeds, {years} yrs ===")
    print("  year |  avg clans | P(Hida alive)")
    for yr in range(0, years, 2):
        print(f"  {1560 + yr} |   {alive_by_year[yr] / n_seeds:4.1f}    |   "
              f"{hida_alive_by_year[yr] / n_seeds:3.0%}")
    survived = sum(1 for d in hida_death_years if d is None)
    died = sorted(d for d in hida_death_years if d is not None)
    print(f"  Hida survives {years}yr: {survived}/{n_seeds} ({survived / n_seeds:.0%})")
    if died:
        print(f"    when Hida dies: median Y{med(died)}, "
              f"earliest Y{died[0]}, latest Y{died[-1]}")
    print(f"  tempo: {len(all_deaths) / n_seeds:.1f} clans die/game; "
          f"median clan death Y{med(all_deaths)}; "
          f"game reaches 1 clan in {len(reach_one)}/{n_seeds} runs"
          + (f" (median Y{med(reach_one)})" if reach_one else ""))
    print("  per-clan survival (the model's emergent tier list):")
    rows = []
    for c in range(n_clans):
        surv = clan_survived[c] / n_seeds
        rows.append((surv, med(clan_deaths[c]), c))
    for surv, mdeath, c in sorted(rows):
        bar = "#" * round(surv * 20)
        dtxt = f"med-death Y{mdeath}" if mdeath else ""
        print(f"    {names[c]:9} {surv:3.0%} {bar:<20} {dtxt}")


if __name__ == "__main__":
    import sys
    sk = int(sys.argv[1]) if len(sys.argv) > 1 else 2
    base_test(skill=sk)
