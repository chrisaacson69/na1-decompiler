"""
game.py -- the flat-native turn loop. The "bridge" that connects the validated
flat-memory AI (ai_vm) to a runnable game: setup board (setup.build_board) ->
season loop (command pass + Fall harvest) -> per-turn stats. ONE source of truth
(the flat memmap.Memory); no World/Province sync seam.

Pieces here:
  - harvest_fief        : flat Fall harvest (subsidy/income/debt/upkeep+starve/clamp)
  - resolve_siege       : the $8DFD battle RESOLUTION (ai_vm already did the commit);
                          strength compare + conquest, on flat memory
  - command_pass        : turn-order shuffle -> ai_vm per AI fief (war injected)
  - step_season / base_test (player==0)

FIDELITY FLAGS:
  [H-marks] harvest uses LIVE fief fields, not the Summer high-water marks
            (update_province_highwater_marks $A0A9 + calc_fief_*_income). Close
            but slightly hot; the marks subsystem is a later pass.
  [rules] upkeep, the luck drift, the high-tax penalty, Spring, the revolt roll and the auction are
            vmprims functions that na1sim.oracle checks against the ROM. Not ROM yet: the revolt's
            rebel-win arm, the relations decays.
"""

import random

from . import memmap as M
from . import vmprims as P
from . import ai_vm
from . import setup


# ===========================================================================
# Fall harvest (flat) -- mirrors econ.harvest_fief / harvest_income_sweep $A2C0
# ===========================================================================
def harvest_fief(m: "M.Memory", idx: int, rng: random.Random):
    f = m.fief(idx)
    mk = m.mark(idx)
    header = m.r16(f + M.F_HEADER)
    daimyo = m.fief_daimyo(idx)
    cha = m.r8(daimyo + M.D_CHARISMA)

    # update_province_highwater_marks $A0A9: mark = min(mark, live) -- BEFORE income
    m.w16(mk + M.MK_OUTPUT, min(m.r16(mk + M.MK_OUTPUT), m.r16(f + M.F_OUTPUT)))
    m.w16(mk + M.MK_DAMS, min(m.r16(mk + M.MK_DAMS), m.r16(f + M.F_DAMS)))
    m.w16(mk + M.MK_LOYALTY, min(m.r16(mk + M.MK_LOYALTY), m.r16(f + M.F_LOYALTY)))
    m.w16(mk + M.MK_WEALTH, min(m.r16(mk + M.MK_WEALTH), m.r16(f + M.F_WEALTH)))

    # event_boost_province_gold_output $A128, AI fiefs only: gold += rng(10)+cha/10; 50% output too.
    if not m.province_ai_state(idx):
        boost = cha // 10
        m.w16(f + M.F_GOLD, m.r16(f + M.F_GOLD) + rng.randrange(10) + boost)
        if rng.randrange(2):                       # rng_mod(2) truthy -> output boost
            m.w16(f + M.F_OUTPUT, m.r16(f + M.F_OUTPUT) + rng.randrange(10) + boost)

    # income, gated on LIVE loyalty>0; the base reads the MARKS (low-water income)
    tax = m.r8(M.FIEF_TAX_RATE + idx)
    gy = ry = 0
    if m.r16(f + M.F_LOYALTY) > 0:
        lm, wm = m.r16(mk + M.MK_LOYALTY), m.r16(mk + M.MK_WEALTH)
        om, dm = m.r16(mk + M.MK_OUTPUT), m.r16(mk + M.MK_DAMS)
        town = m.r16(f + M.F_TOWN)                 # town is LIVE, not marked
        ceil = P.pct_op(cha // 2, tax)             # calc_charisma_scaled_income_variance
        rng_g = rng.randrange(ceil + 1)            # rng_mod(variance+1)
        rng_r = rng.randrange(ceil + 1)
        base = P.pct_op(P.pct_op(lm, 40), tax) + P.pct_op(wm, tax)
        gy = min(base + P.pct_op(town, tax) + rng_g, header)
        ry = min(base + P.pct_op(P.pct_op(om, dm), tax) + rng_r, header)
        m.w16(f + M.F_GOLD, m.r16(f + M.F_GOLD) + gy)
        m.w16(f + M.F_RICE, m.r16(f + M.F_RICE) + ry)

    # auto-repay debt
    pay = min(m.r16(f + M.F_GOLD), m.r16(f + M.F_DEBT))
    m.w16(f + M.F_GOLD, m.r16(f + M.F_GOLD) - pay)
    m.w16(f + M.F_DEBT, m.r16(f + M.F_DEBT) - pay)

    P.consume_province_army_upkeep(m, f)

    P.cap_fief_stats(m, idx)             # the ROM closes every harvest with this
    return gy, ry


# ===========================================================================
# Battle RESOLUTION (resolve_siege_assault_outcome $8DFD) -- ai_vm did the commit
# ===========================================================================
def _quality(arms, skill):
    return ((arms // 2) + (skill // 2)) << 1          # $8E7D


def _alive(m: "M.Memory", owner: int) -> bool:
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    return any(m.fief_owner(i) == owner and m.province_ai_state(i) != M.EMPTY
               for i in range(n))


def _shift_lords(m: "M.Memory", winner_d: int, loser_d: int):
    for off in (M.D_DRIVE, M.D_CHARISMA, 5):          # daimyo_stat_transfer $DF3D: +2/+4/+5
        m.w8(winner_d + off, min(255, m.r8(winner_d + off) + 1))
        m.w8(loser_d + off, max(0, m.r8(loser_d + off) - 1))


def _reassign_faction(m: "M.Memory", loser_owner: int, winner_owner: int, winner_state: int):
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    for i in range(n):
        if m.fief_owner(i) == loser_owner:
            m.w8(M.FIEF_TO_DAIMYO_MAP + i, winner_owner)
            m.w8(M.PROVINCE_AI_STATE + i, winner_state)
            m.w8(M.FIEF_TAX_RATE + i, min(m.r8(M.FIEF_TAX_RATE + i), 30))


def _conquest(m, atk, deff, c_men, c_gold, c_rice, a_arms, a_skill, a_mor, rng):
    fd = m.fief(deff)
    al, dl = m.fief_owner(atk), m.fief_owner(deff)
    winner_state = m.province_ai_state(atk)            # "you conquer the way you fight"
    surv = m.r16(fd + M.F_MEN) // 2
    tot = c_men + surv
    blend = lambda a, b: (a * c_men + b * surv) // tot if tot else a
    m.w16(fd + M.F_MORALE, blend(a_mor, m.r16(fd + M.F_MORALE)))
    m.w16(fd + M.F_SKILL, blend(a_skill, m.r16(fd + M.F_SKILL)))
    m.w16(fd + M.F_ARMS, blend(a_arms, m.r16(fd + M.F_ARMS)))
    m.w16(fd + M.F_MEN, tot)
    m.w16(fd + M.F_GOLD, m.r16(fd + M.F_GOLD) + c_gold)
    m.w16(fd + M.F_RICE, m.r16(fd + M.F_RICE) + c_rice)
    capital_fell = bool(m.is_capital(deff))
    m.w8(M.FIEF_TO_DAIMYO_MAP + deff, al)
    m.w8(M.PROVINCE_AI_STATE + deff, winner_state)
    m.w8(M.FIEF_IS_CAPITAL + deff, 0)
    m.w8(M.FIEF_TAX_RATE + deff, min(m.r8(M.FIEF_TAX_RATE + deff), 30))
    _shift_lords(m, m.fief_daimyo(atk), m.fief_daimyo(deff))
    if capital_fell:
        # capital escape ($8F6C): relocate the seat unless a 1/(drive//10) roll hits
        remaining = [i for i in range(m.r16(M.SCENARIO_FIEF_COUNT)) if m.fief_owner(i) == dl]
        D = max(1, m.r8(m.daimyo(dl) + M.D_DRIVE) // 10)
        if remaining and rng.randrange(D) != 0:
            seat = max(remaining, key=lambda i: m.r16(m.fief(i) + M.F_MEN))
            m.w8(M.FIEF_IS_CAPITAL + seat, 1)
        else:
            _reassign_faction(m, dl, al, winner_state)


def resolve_siege(m: "M.Memory", rng: random.Random = None):
    """Injected at the $8DFD boundary. Reads the committed force ai_vm already
    deducted (war_attacker_*), resolves strength, conquers or repels."""
    rng = rng or random.Random()
    atk, deff = m.selected, m.defending
    fa, fd = m.fief(atk), m.fief(deff)
    c_men = m.r16(M.WAR_ATTACKER_MEN)
    c_gold = m.r16(M.WAR_ATTACKER_GOLD)
    c_rice = m.r16(M.WAR_ATTACKER_RICE)
    a_arms, a_skill, a_mor = m.r16(fa + M.F_ARMS), m.r16(fa + M.F_SKILL), m.r16(fa + M.F_MORALE)
    d_men, d_arms, d_skill, d_mor = (m.r16(fd + M.F_MEN), m.r16(fd + M.F_ARMS),
                                     m.r16(fd + M.F_SKILL), m.r16(fd + M.F_MORALE))
    atk_cap = 1 if (m.r8(M.WAR_SIDE_STATE_FLAG) & 0x80) else 0      # siege flag (already rolled)
    a_str = (2 + atk_cap) * c_men + _quality(a_arms, a_skill) + a_mor
    d_str = (2 + (1 if m.is_capital(deff) else 0)) * d_men + _quality(d_arms, d_skill) + d_mor
    if m.r8(m.fief_daimyo(atk) + M.D_DRIVE) < m.r8(m.fief_daimyo(deff) + M.D_DRIVE):
        d_str += P.pct_op(d_mor, 10)                  # +10% morale to higher Drive
    else:
        a_str += P.pct_op(a_mor, 10)
    if a_str > d_str:
        _conquest(m, atk, deff, c_men, c_gold, c_rice, a_arms, a_skill, a_mor, rng)
    else:
        m.w16(fd + M.F_MEN, d_men + c_men // 2)        # defender absorbs half; rest lost
        _shift_lords(m, m.fief_daimyo(deff), m.fief_daimyo(atk))


# ===========================================================================
# Spring boon + the seasonal event pass (ported from loop.py to flat memory)
# ===========================================================================
def resolve_uprising(m: "M.Memory", idx: int, rng: random.Random) -> bool:
    """A revolt: the ROM's roll (P.uprising_rebels_win_roll) and its loyal arm
    (P.revolt_loyal_men_won), both checked by na1sim.oracle. Rebels win -> the lord loses the fief
    (capital -> the whole faction collapses). [U-empty: a lost fief is marked EMPTY here for
    process_ownerless; the ROM installs a new daimyo on it at once, the rest of
    resolve_revolt_event_on_listed_fiefs, not transcribed.]"""
    if not P.uprising_rebels_win_roll(m, idx):
        P.revolt_loyal_men_won(m, idx)
        return False
    _lose_fief(m, idx)
    return True


def _lose_fief(m, idx):
    """A fief falls to rebels: a capital takes the faction down, any other goes ownerless."""
    if m.is_capital(idx):
        owner = m.fief_owner(idx)
        for i in range(m.r16(M.SCENARIO_FIEF_COUNT)):
            if m.fief_owner(i) == owner:
                m.w8(M.PROVINCE_AI_STATE + i, M.EMPTY)
    else:
        m.w8(M.PROVINCE_AI_STATE + idx, M.EMPTY)


def events(m: "M.Memory", season: int, rng: random.Random):
    """One seasonal event class (ai_strategic_turn_planner $A455): Summer typhoon,
    else Plague, else an uprising sweep (50/50 revolt vs riot)."""
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    live = [i for i in range(n) if m.province_ai_state(i) != M.EMPTY]

    if season == 1 and rng.randrange(2) == 0:          # Summer typhoon
        for i in live:
            if rng.randrange(40) < 3:
                f = m.fief(i)
                m.w16(f + M.F_WEALTH, max(0, m.r16(f + M.F_WEALTH) - (rng.randrange(4) + 1)))
                m.w16(f + M.F_OUTPUT, P.pct_op(m.r16(f + M.F_OUTPUT), P.pct_op(m.r16(f + M.F_DAMS), 90)))
        return
    if rng.randrange(4) == 0:                           # Plague (ravage $9D00)
        for i in live:
            if rng.randrange(40) < 3:
                f = m.fief(i)
                m.w16(f + M.F_MEN, P.pct_op(m.r16(f + M.F_MEN), rng.randrange(50) + 50))
                m.w16(f + M.F_OUTPUT, P.pct_op(m.r16(f + M.F_OUTPUT), rng.randrange(50) + 50))
                if m.r8(M.FIEF_IS_CAPITAL + i):         # capital -> daimyo takes ill
                    d = m.fief_daimyo(i)
                    m.w8(d + M.D_HEALTH, max(0, m.r8(d + M.D_HEALTH) - (rng.randrange(9) + 1)))
        return
    # Uprising: the planner rolls each fief at 3%, and only if one passes does the dispatcher run
    # (ai_strategic_turn_planner, ai_event_build_two_batches_dispatch_or_announce).
    if not any([rng.randrange(100) < 3 for _i in live]):
        return
    variant = rng.randrange(2)                         # 0 riot, 1 revolt; the other if none qualify
    hit = []
    for _try in range(2):
        check = P.riot_eligible if variant == 0 else P.revolt_eligible
        hit = [i for i in live if check(m, i)]
        if hit:
            break
        variant ^= 1
    if hit:
        (_riots if variant == 0 else _revolts)(m, hit, rng)


RIOT_PAY = True      # a human facing a riot gives all the gold rather than fight at once


def _human(m, i):
    return m.is_capital(i) and m.province_ai_state(i) == M.PLAYER_DIRECT


def _rebel_battle(m, i, is_uprising, rng):
    """The staged battle: spawn_uprising_force_from_province, then bank 2, on the tactical engine."""
    from . import tactical as T
    m.w16(M.BATTLE_DEFENDING, i)
    P.spawn_uprising_force(m, is_uprising)
    T.run_tactical_battle(m, rng)


def _riots(m, hit, rng):
    """resolve_riot_event_on_listed_fiefs: a staged battle ends the list."""
    for i in hit:
        m.selected = i
        if _human(m, i):
            if P.human_riot(m, i, RIOT_PAY):
                continue
            _rebel_battle(m, i, True, rng)
            return
        if P.riot_contest(m, i):
            _lose_fief(m, i)
        f = m.fief(i)
        m.w16(f + M.F_LOYALTY, m.r16(f + M.F_LOYALTY) + m.rng_mod(30) + 50)


def _revolts(m, hit, rng):
    """resolve_revolt_event_on_listed_fiefs: a human capital stages a battle; the rest roll."""
    staged = []
    for i in hit:
        m.selected = i
        if _human(m, i):
            staged.append(i)
        else:
            resolve_uprising(m, i, rng)
    if staged:
        _rebel_battle(m, staged[0], False, rng)


# ===========================================================================
# Season loop
# ===========================================================================
def resolve_battle(m: "M.Memory", rng: random.Random):
    """The battle-boundary dispatcher (mirrors bank_01.c $9130). ai_vm's commit
    already set ai_turn_loop_redispatch_flag from `ui_confirm_flag_6e7d ||
    defender==player`: a WATCHED battle (the 'Watch other daimyos battle' setting,
    or a human defender) runs the full on-screen tactical engine; otherwise the
    off-screen $8DFD auto-resolve. SPEED (auto) vs ACCURACY (tactical), one switch.
    Both sides always run the AI logic here (no combat-policy yet, by design)."""
    if m.r16(M.AI_REDISPATCH_FLAG):
        from . import tactical as T
        T.run_tactical_battle(m, rng)
    else:
        resolve_siege(m, rng)


def command_pass(m: "M.Memory", rng: random.Random, player_policy=None):
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    order = list(range(n))
    rng.shuffle(order)
    war = ai_vm.war_hook(lambda mm: resolve_battle(mm, rng))
    for idx in order:
        st = m.province_ai_state(idx)
        if st == M.EMPTY:
            continue
        if st == M.AI_HOME:
            ai_vm.econ_command_dispatch(m, idx, war)
        elif st == M.PLAYER_DIRECT and player_policy is not None:
            player_policy(m, idx, rng)


def reset_marks(m: "M.Memory"):
    """Summer init_province_highwater_from_records $A066: mark = live."""
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    for idx in range(n):
        if m.province_ai_state(idx) == M.EMPTY:
            continue
        f, mk = m.fief(idx), m.mark(idx)
        m.w16(mk + M.MK_OUTPUT, m.r16(f + M.F_OUTPUT))
        m.w16(mk + M.MK_DAMS, m.r16(f + M.F_DAMS))
        m.w16(mk + M.MK_LOYALTY, m.r16(f + M.F_LOYALTY))
        m.w16(mk + M.MK_WEALTH, m.r16(f + M.F_WEALTH))


# --- market reroll (roll_period_market_rates $924A) ------------------------
def _year_scaled(m, rng):
    return (((m.year - 1560) // 2 + 2) * 10) + rng.randrange(51)   # $9214


def roll_period_market_rates(m: "M.Memory", rng: random.Random):
    """Year-scaled price reroll. arms/hire ramp via _year_scaled -> men cost
    climbs ~3 gold early to ~20 late (retires the hand-coded men_price)."""
    m.w16(M.LOAN_RATE, rng.randrange(10) + 1)
    if rng.randrange(5):                               # 80% small drift, clamp [10,30]
        gr = m.r16(M.GOLD_RICE_EXCHANGE) + rng.randrange(11) - 5
        m.w16(M.GOLD_RICE_EXCHANGE, max(10, min(gr, 30)))
    else:                                              # 20% small/large jump
        m.w16(M.GOLD_RICE_EXCHANGE, (rng.randrange(6) + 5) if rng.randrange(2) else (rng.randrange(10) + 30))
    m.w16(M.ARMS_BUY_PRICE_RATE, _year_scaled(m, rng) // 2)
    m.w16(M.GOLD_MEN_HIRE_RATE, P.pct_op(_year_scaled(m, rng), 70))
    m.w16(M.HIRE_GOLD_RATE, (rng.randrange(101) + (m.year - 1560) * 10 + 4) // 4)


# --- ownerless-fief succession (no fief stays empty) -----------------------
def _free_daimyo_id(m):
    """A free daimyo slot. New (succession) daimyos take FRESH ids >= fief_count
    so the original clans stay distinct for survival tracking; fall back to
    recycling an original's vacated id only if the fresh range fills."""
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    owned = {m.fief_owner(i) for i in range(n) if m.province_ai_state(i) != M.EMPTY}
    for did in range(n, n + 24):
        if did not in owned:
            return did
    for did in range(n):
        if did not in owned:
            return did
    return None


def install_new_daimyo(m, idx, rng):
    """install_new_daimyo $E21B (pool recycle approximated): a fresh clan seats
    the vacated fief -- age rng(20)+20, stats pct_op(60, rng20+50) (>=30)."""
    did = _free_daimyo_id(m)
    if did is None:
        return
    d = m.daimyo(did)
    m.w8(d + M.D_AGE, rng.randrange(20) + 20)
    for off in (M.D_HEALTH, M.D_DRIVE, M.D_LUCK, M.D_CHARISMA, M.D_IQ):
        v = P.pct_op(60, rng.randrange(20) + 50)
        m.w8(d + off, v + (30 if v < 30 else 0))
    m.w8(d + M.D_STATUS, 0)
    m.w8(M.FIEF_TO_DAIMYO_MAP + idx, did)
    m.w8(M.PROVINCE_AI_STATE + idx, M.AI_HOME)
    m.w8(M.FIEF_IS_CAPITAL + idx, 1)


def process_ownerless(m, rng):
    """resolve_ownerless_fiefs_by_auction $8E63 over P.auction_ownerless_fief_to_bidders, the
    routine na1sim.oracle checks. Fewer than 2 owners around the fief, or no bid: a fresh daimyo.
    The sim's player has no bid policy; a human bidder offers a random amount as before."""
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    for idx in range(n):
        if m.province_ai_state(idx) != M.EMPTY:
            continue
        m.selected = idx
        m.w16(M.BATTLE_DEFENDING, idx)
        around = [j for j in m.neighbor_rows.get(idx, [])
                  if j < n and m.province_ai_state(j) != M.EMPTY]
        count = P.dedup_owners(m, around) if around else 0
        if P.auction_ownerless_fief_to_bidders(m, count, lambda m, gold: max(1, m.rng_mod(gold))) is None:
            install_new_daimyo(m, idx, rng)


# --- natural death ($9194); aging is P.spring_age_and_decay ---------------
def natural_death(m, rng):
    """check_daimyo_natural_death $9154: die if health==0; else only at age>=70,
    with rng(300) < age-10-health/4. The lord's fiefs vacate -> succession."""
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    dead = set()
    for idx in range(n):
        if m.province_ai_state(idx) == M.EMPTY or not m.is_capital(idx):
            continue
        owner = m.fief_owner(idx)
        if owner in dead:
            continue
        d = m.daimyo(owner)
        age, health = m.r8(d + M.D_AGE), m.r8(d + M.D_HEALTH)
        if health == 0 or (age >= 70 and rng.randrange(300) < (age - 10 - health // 4)):
            dead.add(owner)
    for idx in range(n):
        if m.fief_owner(idx) in dead and m.province_ai_state(idx) != M.EMPTY:
            m.w8(M.PROVINCE_AI_STATE + idx, M.EMPTY)


def step_season(m: "M.Memory", season: int, rng: random.Random, player_policy=None):
    m.season = season
    if season == 0:                                    # new year: market
        roll_period_market_rates(m, rng)
    P.per_period_fief_update(m)                        # every season: luck drift, the high-tax penalty
    if season == 0:                                    # once a year: age, boon, player decay
        P.spring_age_and_decay(m)
    if season == 1:                                    # Summer: reset low-water marks
        reset_marks(m)
    if season == 2:                                    # Fall harvest: in the driver, BEFORE the
        for idx in range(m.r16(M.SCENARIO_FIEF_COUNT)):  # season's commands, so Fall spends it
            if m.province_ai_state(idx) != M.EMPTY:
                harvest_fief(m, idx, rng)
    for idx in range(m.r16(M.SCENARIO_FIEF_COUNT)):    # the planner's cap: repairs the wraps above
        if m.province_ai_state(idx) != M.EMPTY:
            P.cap_fief_stats(m, idx)
    events(m, season, rng)
    command_pass(m, rng, player_policy)
    natural_death(m, rng)
    process_ownerless(m, rng)                          # reseat every vacated fief


def living_factions(m: "M.Memory"):
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    return sorted({m.fief_owner(i) for i in range(n) if m.province_ai_state(i) != M.EMPTY})


# ===========================================================================
# player==0 base test: the men/econ trajectory we built all this to read
# ===========================================================================
def base_test(skill=2, n_seeds=20, years=15):
    print(f"=== player==0 flat run: skill {skill}, {n_seeds} seeds, {years} yrs "
          f"(events + spring + command + harvest, ROM-faithful) ===")
    print("  year | seat men | avg men | top men | town | output | clans")
    agg = {yr: dict(men=0, town=0, out=0, seatmen=0, seats=0, topmen=0,
                    clans=0, fiefs=0) for yr in range(years)}
    for seed in range(n_seeds):
        m = setup.build_board(skill=skill, seed=seed)
        rng = random.Random(seed)
        year = 1560
        for yr in range(years):
            for season in range(4):
                step_season(m, season, rng)
            n = m.r16(M.SCENARIO_FIEF_COUNT)
            live = [i for i in range(n) if m.province_ai_state(i) != M.EMPTY]
            men = [m.r16(m.fief(i) + M.F_MEN) for i in live]
            seats = [m.r16(m.fief(i) + M.F_MEN) for i in live if m.is_capital(i)]
            agg[yr]["men"] += sum(men)
            agg[yr]["town"] += sum(m.r16(m.fief(i) + M.F_TOWN) for i in live)
            agg[yr]["out"] += sum(m.r16(m.fief(i) + M.F_OUTPUT) for i in live)
            agg[yr]["seatmen"] += sum(seats)
            agg[yr]["seats"] += len(seats)
            agg[yr]["topmen"] += max(men, default=0)
            agg[yr]["fiefs"] += len(live)
            agg[yr]["clans"] += len(living_factions(m))
            year += 1
            m.w16(M.CURRENT_GAME_YEAR, year)
    for yr in range(0, years, 2):
        a = agg[yr]
        fiefs, seats = max(1, a["fiefs"]), max(1, a["seats"])
        print(f"  {1560+yr} |   {a['seatmen']//seats:4d}   |  {a['men']//fiefs:4d}   |  "
              f"{a['topmen']//n_seeds:4d}   | {a['town']//fiefs:4d} |  {a['out']//fiefs:4d}  |"
              f" {a['clans']/n_seeds:4.1f}")
    print("  (seat men = capital/developed-fief avg ~ your ~300 lens; avg = all fiefs"
          " incl. fresh conquests; top = strongest fief)")


def tourney(skill=2, n_seeds=40, years=25):
    """0-player tournament: run many all-AI games to full length and report the
    emergent tier list (per-original-clan survival + median death year), the
    consolidation curve, and the winners -- to sanity-check against known NA1
    outcomes before building player AI."""
    from .loader import load_daimyos
    names = [d.name for d in load_daimyos()]
    nc = len(names)
    survive = [0] * nc
    deaths = [[] for _ in range(nc)]
    clans_yr = [0.0] * years
    win_years, winners = [], {}
    for seed in range(n_seeds):
        m = setup.build_board(skill=skill, seed=seed)
        rng = random.Random(seed)
        year, prev, win_yr = 1560, set(range(nc)), None
        for yr in range(years):
            for season in range(4):
                step_season(m, season, rng)
            year += 1
            m.w16(M.CURRENT_GAME_YEAR, year)
            facs = living_factions(m)
            clans_yr[yr] += len(facs)
            alive = {o for o in facs if o < nc}              # original clans only
            for d in prev - alive:
                deaths[d].append(year - 1)
            prev = alive
            if win_yr is None and len(facs) <= 1:
                win_yr = year - 1
                win_years.append(win_yr)
                w = facs[0] if facs else -1
                winners[w] = winners.get(w, 0) + 1
        for d in prev:
            survive[d] += 1

    def med(xs):
        xs = sorted(xs)
        return xs[len(xs) // 2] if xs else None

    print(f"=== 0-player TOURNEY: skill {skill}, {n_seeds} seeds, {years} yrs ===")
    print("  consolidation (avg living factions, incl. successor clans):")
    for yr in range(0, years, 3):
        print(f"    {1560+yr}: {clans_yr[yr]/n_seeds:4.1f}")
    print(f"  unification: {len(win_years)}/{n_seeds} games reach 1 clan"
          + (f" (median Y{med(win_years)})" if win_years else " (none in window)"))
    print("  per-original-clan survival (the emergent tier list):")
    print(f"    {'clan':10} {'surv':>4}  {'med-death':>9} {'avg-death':>9}")
    for surv, mdeath, c in sorted((survive[c] / n_seeds, med(deaths[c]), c) for c in range(nc)):
        bar = "#" * round(surv * 20)
        avg = sum(deaths[c]) / len(deaths[c]) if deaths[c] else None
        wins = winners.get(c, 0)
        dm = f"Y{mdeath}" if mdeath else "-"
        da = f"Y{avg:.0f}" if avg else "-"
        wtxt = f"  WON {wins}x" if wins else ""
        print(f"    {names[c]:10} {surv:3.0%} {bar:<14} {dm:>9} {da:>9}{wtxt}")
    nw = sum(v for k, v in winners.items() if k >= nc)
    if nw:
        print(f"    (successor/new clans won {nw}x)")


def player_ab(player_fief=5, n_seeds=40, years=30):
    """A/B: P(the player's clan survives `years`) with the tuned hida_policy vs
    the same fief left as dumb AI -- across skill levels. The escapability test."""
    from . import policy
    from .loader import load_daimyos
    name = load_daimyos()[player_fief].name

    def survival(with_player, sk):
        surv = 0
        for seed in range(n_seeds):
            m = setup.build_board(skill=sk, seed=seed,
                                  player_fief=player_fief if with_player else None)
            rng = random.Random(10000 + seed)
            pol = policy.hida_policy if with_player else None
            for yr in range(years):
                for season in range(4):
                    step_season(m, season, rng, pol)
                m.w16(M.CURRENT_GAME_YEAR, 1561 + yr)
            n = m.r16(M.SCENARIO_FIEF_COUNT)
            alive = any(m.fief_owner(i) == player_fief and m.province_ai_state(i) != M.EMPTY
                        for i in range(n))
            surv += alive
        return surv / n_seeds

    print(f"=== {name} (fief {player_fief}): tuned PLAYER vs AI baseline "
          f"({n_seeds} seeds, {years} yrs) ===")
    print("  skill | P(survive) AI  ->  player |  lift")
    for sk in (1, 2, 5):
        base = survival(False, sk)
        play = survival(True, sk)
        print(f"    {sk}   |    {base:4.0%}       ->   {play:4.0%}  | {play - base:+5.0%}")


def combat_ab(skill=2, n_seeds=12, years=20):
    """Does the TACTICAL defensive advantage (terrain) change strategic OUTCOMES,
    or just buy time before the dogpile wins? Same seeds/AI, two combat engines:
    watch_battles=False (off-screen $8DFD, quality-only) vs True (on-screen tactical,
    terrain-aware). Reports per-clan survival under each + the delta. Falsifier:
    if terrain matters, the moat-fortress Tokugawa(Mikawa) RISES and the open-ground
    quality-fortress Oda(Owari) FALLS when we switch auto->tactical."""
    from .loader import load_daimyos, load_provinces
    names = [d.name for d in load_daimyos()]
    provs = [getattr(p, 'name', '?') for p in load_provinces()]
    nc = len(names)

    def run(watch):
        survive = [0] * nc
        deaths = [[] for _ in range(nc)]
        clans_yr = [0.0] * years
        for seed in range(n_seeds):
            m = setup.build_board(skill=skill, seed=seed, watch_battles=watch)
            rng = random.Random(seed)
            year, prev = 1560, set(range(nc))
            for yr in range(years):
                for season in range(4):
                    step_season(m, season, rng)
                year += 1
                m.w16(M.CURRENT_GAME_YEAR, year)
                facs = living_factions(m)
                clans_yr[yr] += len(facs)
                alive = {o for o in facs if o < nc}
                for d in prev - alive:
                    deaths[d].append(year - 1)
                prev = alive
            for d in prev:
                survive[d] += 1
        return survive, deaths, clans_yr

    print(f"=== COMBAT A/B: off-screen vs tactical ({n_seeds} seeds, {years} yrs, "
          f"skill {skill}) ===")
    auto_s, auto_d, auto_c = run(False)
    tac_s,  tac_d,  tac_c  = run(True)

    def med(xs):
        xs = sorted(xs)
        return xs[len(xs) // 2] if xs else None

    print("  consolidation (avg living factions): year  auto / tactical")
    for yr in range(0, years, 3):
        print(f"    {1560+yr}:  {auto_c[yr]/n_seeds:4.1f} / {tac_c[yr]/n_seeds:4.1f}")
    print(f"\n  per-clan survival  (sorted by terrain effect, tactical - auto):")
    print(f"    {'clan':10}{'fief':10} {'auto':>5} {'tac':>5} {'d-surv':>6}  "
          f"{'med-death auto/tac':>18}")
    rows = []
    for c in range(nc):
        rows.append((tac_s[c] - auto_s[c], c))
    for delta, c in sorted(rows, reverse=True):
        a, t = auto_s[c] / n_seeds, tac_s[c] / n_seeds
        dm_a, dm_t = med(auto_d[c]), med(tac_d[c])
        ds = f"Y{dm_a or '-'}/Y{dm_t or '-'}"
        print(f"    {names[c]:10}{provs[c]:10} {a:4.0%} {t:4.0%} {delta/n_seeds:+5.0%}  {ds:>18}")


if __name__ == "__main__":
    import sys
    mode = sys.argv[1] if len(sys.argv) > 1 else "base"
    sk = int(sys.argv[2]) if len(sys.argv) > 2 else 2
    if mode == "tourney":
        tourney(skill=sk)
    elif mode == "player":
        player_ab()
    elif mode == "combat_ab":
        combat_ab(skill=sk)
    else:
        base_test(skill=sk)
