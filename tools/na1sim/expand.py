"""Expansion: the player attacks (Chris, 2026-11-12).

The rule: an attack is worth making only if, after it, every fief the player owns is still past its
gates, the one the army left and the one it took. A fief with no enemy neighbours needs no army,
taking the biggest neighbour lowers the gates of every owned fief next to it, and a fallen capital
can hand over its whole faction, so the decision is as much "what does the map look like after"
as "can we win". Start simple: the calculated battle (game.siege_strengths) prices the attack;
a fought-battle attack player comes later and only changes the odds.

The War command, as the cartridge runs it for a human (driver_war $9850):
  men      at most min(men, gold); a weak lord's (daimyo_weakness_flag) a quarter of that, and a
           weak lord cannot attack from his capital at all;
  gold     one per man sent, deducted and carried (it lands in the conquered fief);
  rice     at most min(rice, men sent);
  lead     only from the capital: sets the daimyo-present bit (3x men instead of 2x).
On a win (game._conquest) half the defender's men join the survivors, the carried gold and rice add
to the fief's own, its tax drops to 30 at most; on a loss the defender absorbs half the attackers.
"""
import random

from . import memmap as M, game, reaction, forecast, ai_vm

SHARE = reaction.GRUDGE                 # 47: past it a neighbour can pick you
SAFE, HUNTABLE, COMING = "SAFE", "HUNTABLE", "COMING"
RANK = {SAFE: 0, HUNTABLE: 1, COMING: 2}
FOUGHT = True                           # the player's attacks are fought on the battle map, as the cartridge does
                                        # (Chris: no auto-resolve for a human; the calculated battle gave free wins)

# Fought attacks (#48, the attack-odds harvest: 22,792 replays of the expander's real attacks fought
# on the battle map, 7 starts x 6 seeds). A fought battle is decided by men, not by the quality and
# morale that dominate the calculated one: a general wins an ordinary fief 9% at 1-1.25x the
# defender's men, 22% at 1.25-1.5, 71% at 1.5-2, 89% at 2-2.5; a capital (home bonus) 1 / 12 / 32 /
# 82%, 88% at 2.5-3. A daimyo-led attack shifts the curve about half a step, but a led loss hands the
# whole faction to the defender ($DED4), so the fought player does not lead.
FOUGHT_NEED = {False: 2.25, True: 2.75}     # men sent / defender's men for ~90%, by target is capital
# the conquered fief's men after a win, as a share of the men sent, by that ratio (both sides' survivors)
FOUGHT_KEEP = ((1.5, .40), (2.0, .49), (2.5, .61), (3.0, .67), (4.0, .77), (6.0, .87))


# The attack doctrine (#48, Chris): the commander holds back and units 1-4 charge the enemy commander
# (strike.Charge), on an army Assigned for it before the campaign. A conquered fief keeps the old
# defender's split (commander 30-65% of the men), so it is reshaped first: heavy (1/99/0/0/0, one
# striker) through a one-lane approach, spread (4 and the rest even, row 2 under its arms cap) where
# the castle can be surrounded. SPLIT_FOR: per target fief, from the battle lab.
CHARGE = True
# From the battle lab: each fief attacked by the charge from every neighbour, at 2x and 2.5x its men,
# 12 seeds, heavy against spread (wins). Heavy for Mikawa 95/96 vs 45, Owari 62/72 vs 53, Echigo,
# Musashi, Echizen, Omi (narrowly); spread for Noto 0/24 vs 24, Hida 24/96 vs 96, Iga 48/96 vs 96,
# Iseshima 72/120 vs 117, Settsu; the rest tie (spread).
SPLIT_FOR = {1: "heavy", 2: "heavy", 4: "heavy", 7: "heavy", 10: "heavy", 16: "heavy"}


def desired_split(m, src, tgt):
    base = M.PROVINCE_UNIT_TYPE_PCT + src * 5
    cur = [m.r8(base + i) for i in range(5)]
    total = sum(cur)
    if SPLIT_FOR.get(tgt) == "heavy":
        return [1, total - 1, 0, 0, 0]
    cap2 = max(cur[2], m.r16(m.fief(src) + M.F_ARMS) // 50 + 20)
    r2 = min(cap2, (total - 4) // 4)
    rest = total - 4 - r2
    return [4, rest - 2 * (rest // 3), r2, rest // 3, rest // 3]


def split_ready(m, src, tgt):
    base = M.PROVINCE_UNIT_TYPE_PCT + src * 5
    return [m.r8(base + i) for i in range(5)] == desired_split(m, src, tgt)


# Under the doctrine (assigned army + charge; 12,708 replays of the expander's real attacks): a fief
# 46% at 1.25-1.5x, 82% at 1.5-2, 93% at 2-2.5; a capital 22 / 54 / 91%, 96% at 2.5-3. ~2x buys ~90%
# for both (it was 2.25x and 2.75x on the AI's own logic).
CHARGE_NEED = {False: 2.0, True: 2.0}
CHARGE_KEEP = ((1.5, .38), (2.0, .51), (2.5, .62), (3.0, .68), (4.0, .77), (6.0, .85))


# The tables above were measured at skill 1. The battle map scales every human unit's strength by
# (115 - 15·skill)% ($9CF4; AI units 100%), so at skill 3 a man fights as 0.7 of one (#58: at 2.0x the
# charge wins 100% at skill 1, 76% at 2, 21% at 3). SKILL_AWARE prices the attack at the effective
# ratio: the need grows by 100/(115 - 15·skill) and the keep is read at the effective ratio.
SKILL_AWARE = True


def skill_scale(m):
    return 100 / (115 - 15 * m.skill) if SKILL_AWARE else 1.0


def fought_need(m, tgt):
    need = CHARGE_NEED if CHARGE else FOUGHT_NEED
    return int(m.r16(m.fief(tgt) + M.F_MEN) * need[bool(m.is_capital(tgt))] * skill_scale(m)) + 1


def fought_keep(ratio, scale=1.0):
    table = CHARGE_KEEP if CHARGE else FOUGHT_KEEP
    keep = table[0][1]
    for r, k in table:
        if ratio / scale >= r:
            keep = k
    return keep


# --- the War command ------------------------------------------------------------------------
def war_cap(m, idx):
    """The most men the War command lets this fief send (0: it cannot attack)."""
    f = m.fief(idx)
    men, gold, rice = m.r16(f + M.F_MEN), m.r16(f + M.F_GOLD), m.r16(f + M.F_RICE)
    weak = m.r8(M.DAIMYO_WEAKNESS_FLAG + m.fief_owner(idx))
    if (weak and m.is_capital(idx)) or not (men and gold and rice):    # prep_d; prep_a-c
        return 0
    cap = min(men, gold)
    return max(1, cap // 4) if weak else cap


def targets(m, idx):
    """The enemy neighbours this fief can attack."""
    return reaction.enemy_neighbours(m, idx)


def player_war(m, idx, tgt, men, rice, led=False, rng=None, fought=None):
    """Fight it: commit as driver_war does, resolve with the calculated battle. -> True if won."""
    f = m.fief(idx)
    me = m.fief_owner(idx)
    men = max(1, min(men, war_cap(m, idx)))
    rice = max(1, min(rice, m.r16(f + M.F_RICE), men))
    led = bool(led and m.is_capital(idx))
    m.w16(M.WAR_ATTACKER_MEN, men)
    m.w16(M.WAR_ATTACKER_GOLD, men)
    m.w16(M.WAR_ATTACKER_RICE, rice)
    m.w16(f + M.F_GOLD, m.r16(f + M.F_GOLD) - men)
    m.w16(f + M.F_RICE, m.r16(f + M.F_RICE) - rice)
    m.w16(f + M.F_MEN, m.r16(f + M.F_MEN) - men)
    m.w8(M.WAR_SIDE_STATE_FLAG, 0x80 if led else 0)
    m.selected, m.defending = idx, tgt
    if (fought if fought is not None else FOUGHT) and rng is None:
        # a what-if (the planner's checks): no battle, the measured outcome. A win leaves the fief
        # with the measured share of the men sent; a loss leaves half of them to the defender.
        ft = m.fief(tgt)
        dmen = m.r16(ft + M.F_MEN)
        if men >= fought_need(m, tgt):
            left = int(men * fought_keep(men / max(1, dmen), skill_scale(m)))
            game._conquest(m, idx, tgt, max(0, left - dmen // 2), men, rice,
                           m.r16(f + M.F_ARMS), m.r16(f + M.F_SKILL), m.r16(f + M.F_MORALE), random.Random(0))
        else:
            m.w16(ft + M.F_MEN, dmen + men // 2)
    elif fought if fought is not None else FOUGHT:  # the cartridge fights every human attack on the map
        from . import tactical, strike
        keep_human = tactical.HUMAN
        if CHARGE:
            tactical.HUMAN = strike.Charge()
        try:
            tactical.run_tactical_battle(m, rng)
        finally:
            tactical.HUMAN = keep_human
    else:
        game.resolve_siege(m, rng or random.Random(0))
    # against the attacker's owner before the battle: a daimyo-led attack that loses hands the whole
    # faction to the defender ($DED4), after which source and target share an owner that is not ours
    return m.fief_owner(tgt) == me and m.province_ai_state(tgt) != M.EMPTY


def wins(m, idx, tgt, men, led=False):
    if FOUGHT:
        return not led and men >= fought_need(m, tgt)
    a, d = game.siege_strengths(m, idx, tgt, men, bool(led and m.is_capital(idx)))
    return a > d


def min_men(m, idx, tgt, led=False):
    """The fewest men that win the calculated battle, or None if the War command's cap cannot."""
    cap = war_cap(m, idx)
    if not cap or not wins(m, idx, tgt, cap, led):
        return None
    lo, hi = 1, cap
    while lo < hi:
        mid = (lo + hi) // 2
        if wins(m, idx, tgt, mid, led):
            hi = mid
        else:
            lo = mid + 1
    return lo


# --- the gates, over everything the player owns ---------------------------------------------
def owned(m, owner):
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    return [i for i in range(n) if m.province_ai_state(i) != M.EMPTY and m.fief_owner(i) == owner]


def fief_state(m, i):
    """SAFE / HUNTABLE / COMING for one fief (the dashboard's three states): share of provisioned
    men > 47, then whether that neighbour's budget reaches the shield."""
    me = reaction.live_side(m, i)
    worst = SAFE
    for n in reaction.enemy_neighbours(m, i):
        if ai_vm.fief_men_ratio_pct(m, n, i) > SHARE:
            st = COMING if reaction.budget(reaction.live_side(m, n)) >= reaction.shield(me) else HUNTABLE
            if RANK[st] > RANK[worst]:
                worst = st
    return worst


def empire(m, owner):
    """{fief: state} for every fief the owner holds."""
    return {i: fief_state(m, i) for i in owned(m, owner)}


def interior(m, i):
    return not reaction.enemy_neighbours(m, i)


# --- the capital: the king piece ------------------------------------------------------------
# An interior capital passes SAFE with no men, and the late empires died that way: an AI took a
# neighbouring owned fief, the capital became a border with 0-8 men, and its fall handed over the
# whole faction (8 of 15 invasion deaths over 70 years, at 6-14 fiefs). So the capital answers to
# every enemy within two steps, as if it were already on the border.
def enemies_within(m, i, steps=2):
    n, me = m.r16(M.SCENARIO_FIEF_COUNT), m.fief_owner(i)
    seen, frontier, out = {i}, [i], set()
    for _ in range(steps):
        nxt = []
        for a in frontier:
            for b in m.neighbor_rows.get(a, []):
                if b < n and b not in seen:
                    seen.add(b)
                    if m.province_ai_state(b) != M.EMPTY and m.fief_owner(b) != me:
                        out.add(b)              # an enemy: counted, but not walked through
                    else:
                        nxt.append(b)           # our own (or empty) ground: the next step goes on
        frontier = nxt
    return out


def capital_line(m, i):
    """The fewest men that keep every enemy within two steps under the share line (0: none)."""
    return max([m.fief_men_if_provisioned(e) * 52 // 48 + 1 for e in enemies_within(m, i)] or [0])


def capital_ok(m, owner):
    mine = owned(m, owner)
    if len(mine) < 2:
        return True
    caps = [i for i in mine if m.is_capital(i)]
    return all(m.fief_men_if_provisioned(c) >= capital_line(m, c) for c in caps)


def after(m, idx, tgt, men, rice, led=False):
    """The map after the attack, without changing the game: (won, {fief: state})."""
    owner = m.fief_owner(idx)
    with forecast.held(m):
        won = player_war(m, idx, tgt, men, rice, led)
        return won, empire(m, owner)


# --- the shape of an empire: its army bill --------------------------------------------------
def share_line(m, i):
    """The fewest men keeping every enemy neighbour of fief i at or under the share line (0 if none)."""
    return max([m.fief_men_if_provisioned(e) * 52 // 48 + 1 for e in reaction.enemy_neighbours(m, i)] or [0])


def army_bill(m, owner):
    """What a shape costs to hold (Chris: an empire of 5 with 4 on the front beats 5 all exposed):
    -> (bill, exposed, held). bill = the men every owned fief needs to stay SAFE by share against its
    enemy neighbours, the capital against every enemy two steps out; exposed = owned fiefs with an
    enemy neighbour."""
    mine = owned(m, owner)
    bill = exposed = 0
    for i in mine:
        need = share_line(m, i)
        exposed += need > 0
        if m.is_capital(i) and len(mine) > 1:
            need = max(need, capital_line(m, i))
        bill += need
    return bill, exposed, len(mine)


def free_army(m, owner):
    """Chris's attackable army: the men owned, plus what the topped-out fiefs' gold would buy, less
    the army bill (every fief's gate line; the back line needs 0). -> (free, men, buyable, bill)."""
    rate = m.r16(M.GOLD_MEN_HIRE_RATE) or 50
    mine = owned(m, owner)
    men = sum(m.r16(m.fief(i) + M.F_MEN) for i in mine)
    buy = sum(m.r16(m.fief(i) + M.F_GOLD) * 10 // rate for i in mine if capped(m, i))
    bill = army_bill(m, owner)[0]
    return men + buy - bill, men, buy, bill


def holes(m, owner):
    """Enemy fiefs the empire nearly surrounds: at least two neighbours and at least half of them
    owned. Taking one turns owned front fiefs into interior (Chris)."""
    n = m.r16(M.SCENARIO_FIEF_COUNT)
    out = []
    for t in range(n):
        if m.province_ai_state(t) == M.EMPTY or m.fief_owner(t) == owner:
            continue
        nb = [b for b in m.neighbor_rows.get(t, []) if b < n and m.province_ai_state(b) != M.EMPTY]
        mine = sum(1 for b in nb if m.fief_owner(b) == owner)
        if mine >= 2 and mine * 2 >= len(nb):
            out.append(t)
    return out


# --- the other verbs: Move and Send ---------------------------------------------------------
def move_men(m, src, dst, men, lead=False):
    """The Move command (driver_move $96D1 + effect_move $8CA5): men to an adjacent owned fief, at
    most min(men, the destination's header room); morale/skill/arms blend into the destination by
    men (weighted_average_capped); an emptied source loses its military stats; led by the lord
    from the capital, the capital moves with him. -> men moved."""
    from . import vmprims as P
    if dst not in m.neighbor_rows.get(src, []) or m.fief_owner(dst) != m.fief_owner(src):
        return 0
    fs, fd = m.fief(src), m.fief(dst)
    hdr = m.r16(fd + M.F_HEADER)
    men = min(men, m.r16(fs + M.F_MEN), hdr - m.r16(fd + M.F_MEN))
    if men < 1:
        return 0
    for off in (M.F_MORALE, M.F_SKILL, M.F_ARMS):
        m.w16(fd + off, P.scaled_force_transfer(m.r16(fd + off), m.r16(fs + off), men, m.r16(fd + M.F_MEN), hdr))
    m.w16(fd + M.F_MEN, m.r16(fd + M.F_MEN) + men)
    m.w16(fs + M.F_MEN, m.r16(fs + M.F_MEN) - men)
    P.clear_military_stats_if_no_men(m, src)
    if lead and m.is_capital(src) and not m.r8(M.DAIMYO_WEAKNESS_FLAG + m.fief_owner(src)):
        m.w8(M.FIEF_IS_CAPITAL + src, 0)
        m.w8(M.FIEF_IS_CAPITAL + dst, 1)
        m.w8(M.PROVINCE_AI_STATE + dst, 5)
    return men


def send(m, src, dst, rice, gold):
    """The Send command (driver_send $9A62, effect_send $8BE5): rice and gold to any owned fief,
    each at most min(the receiver's header room, what the sender has). -> (rice, gold) sent."""
    if dst == src or m.fief_owner(dst) != m.fief_owner(src):
        return 0, 0
    fs, fd = m.fief(src), m.fief(dst)
    hdr = m.r16(fd + M.F_HEADER)
    rice = max(0, min(rice, m.r16(fs + M.F_RICE), hdr - m.r16(fd + M.F_RICE)))
    gold = max(0, min(gold, m.r16(fs + M.F_GOLD), hdr - m.r16(fd + M.F_GOLD)))
    for off, v in ((M.F_RICE, rice), (M.F_GOLD, gold)):
        m.w16(fd + off, m.r16(fd + off) + v)
        m.w16(fs + off, m.r16(fs + off) - v)
    return rice, gold


# --- depots: interior fiefs feed the front --------------------------------------------------
GARRISON = 0                            # revolts and riots need more than 2 men (revolt_eligible $9E21,
                                        # riot_eligible $9DA3): an empty interior fief cannot rise (Chris)
MARCH_MIN = 10                          # fewer movable men than this is not worth a command
SEND_MIN = 20


def front_distance(m, owner):
    """{owned fief: steps to the nearest owned fief with an enemy neighbour} (front = 0)."""
    mine = set(owned(m, owner))
    dist = {i: 0 for i in mine if reaction.enemy_neighbours(m, i)}
    frontier = list(dist)
    while frontier:
        nxt = []
        for a in frontier:
            for b in m.neighbor_rows.get(a, []):
                if b in mine and b not in dist:
                    dist[b] = dist[a] + 1
                    nxt.append(b)
        frontier = nxt
    return dist


def depot_move(m, idx):
    """An interior fief's command, or None: march its spare men a step toward the front, else send
    its spare gold and rice to the front fief least able to field its army."""
    owner = m.fief_owner(idx)
    dist = front_distance(m, owner)
    d = dist.get(idx)
    if not d:                                       # on the front, or cut off from it
        return None
    f = m.fief(idx)
    keep = max(GARRISON, capital_line(m, idx) if m.is_capital(idx) else 0)
    spare = m.r16(f + M.F_MEN) - keep
    if spare >= MARCH_MIN and m.r16(f + M.F_MORALE) >= reaction_cliff():
        steps = [b for b in m.neighbor_rows.get(idx, []) if dist.get(b) == d - 1]
        if steps:
            dst = max(steps, key=lambda b: m.r16(m.fief(b) + M.F_HEADER) - m.r16(m.fief(b) + M.F_MEN))
            if m.r16(m.fief(dst) + M.F_HEADER) - m.r16(m.fief(dst) + M.F_MEN) >= MARCH_MIN:
                return ("move", dst, spare)
    front = [i for i, k in dist.items() if k == 0]
    if not front:
        return None
    def short(i):                                   # what it lacks to send its whole army
        g = m.fief(i)
        return max(0, m.r16(g + M.F_MEN) - m.r16(g + M.F_GOLD)) + max(0, m.r16(g + M.F_MEN) - m.r16(g + M.F_RICE))
    dst = max(front, key=short)
    if short(dst) <= 0:
        return None
    spare_gold = m.r16(f + M.F_GOLD) - 20
    spare_rice = m.r16(f + M.F_RICE) - 2 * (m.r16(f + M.F_MEN) // 2 + 1)    # this year's and next upkeep
    g = m.fief(dst)
    want_g = max(0, m.r16(g + M.F_MEN) - m.r16(g + M.F_GOLD))
    want_r = max(0, m.r16(g + M.F_MEN) - m.r16(g + M.F_RICE))
    rice, gold = min(max(0, spare_rice), want_r), min(max(0, spare_gold), want_g)
    if rice + gold >= SEND_MIN:
        return ("send", dst, rice, gold)
    return None


# --- staging: one campaign at a time ---------------------------------------------------------
# Chris: the economy is only a means to an overwhelming army, and that army must be focused on the
# front so the momentum keeps rolling. The greedy empire spread its men over every front fief (two to
# four times the army bill) while each attack came from one fief alone, and its new fiefs, the gateways
# to what was left, were the ones left weak. So the empire picks one target, and the fief that will
# launch it draws the spare men and gold of every other owned fief.
STAGING = False                         # one campaign at a time: measured worse (#48), kept for the planner
MARGIN = 115                            # percent of its own line a fief keeps before it gives men away


def own_need(m, i):
    """The men fief i keeps for itself: its share line (with margin) if exposed, the capital's line."""
    mine = owned(m, m.fief_owner(i))
    need = share_line(m, i) * MARGIN // 100
    if m.is_capital(i) and len(mine) > 1:
        need = max(need, capital_line(m, i))
    return need


def campaign(m, owner):
    """(target, stager) for the empire, or None: among the enemy fiefs the empire borders, the one
    the bordering owned fief is closest to taking (men it lacks to win, as if it could send them
    all), the stager being that owned fief. Cached per season."""
    key = (m.r16(M.CURRENT_GAME_YEAR), getattr(m, "season", 0), owner, tuple(owned(m, owner)))
    if _CAMPAIGN.get("key") == key:
        return _CAMPAIGN["val"]
    best = None
    for i in owned(m, owner):
        for t in reaction.enemy_neighbours(m, i):
            led = m.is_capital(i)
            a, d = game.siege_strengths(m, i, t, 0, led)
            per_man = 3 if led else 2
            need = max(0, (d - a) // per_man + 1)               # men that win the calculated battle
            lack = need + own_need(m, i) - m.r16(m.fief(i) + M.F_MEN)
            cand = (lack, -m.r16(m.fief(i) + M.F_MEN), t, i)
            if best is None or cand < best:
                best = cand
    val = (best[2], best[3]) if best else None
    _CAMPAIGN.update(key=key, val=val)
    return val


_CAMPAIGN = {}


def distance_to(m, owner, goal):
    """{owned fief: steps to goal through owned fiefs}."""
    mine = set(owned(m, owner))
    dist, frontier = {goal: 0}, [goal]
    while frontier:
        nxt = []
        for a in frontier:
            for b in m.neighbor_rows.get(a, []):
                if b in mine and b not in dist:
                    dist[b] = dist[a] + 1
                    nxt.append(b)
        frontier = nxt
    return dist


def staging_move(m, idx):
    """A non-stager fief's command toward the campaign, or None: march men above its own need a step
    toward the stager, else send spare gold and rice to the stager when it lacks them."""
    owner = m.fief_owner(idx)
    c = campaign(m, owner)
    if not c or c[1] == idx:
        return None
    target, stager = c
    dist = distance_to(m, owner, stager)
    d = dist.get(idx)
    if d is None:
        return None
    f = m.fief(idx)
    spare = m.r16(f + M.F_MEN) - own_need(m, idx)
    if spare >= MARCH_MIN and m.r16(f + M.F_MORALE) >= reaction_cliff():
        steps = [b for b in m.neighbor_rows.get(idx, []) if dist.get(b) == d - 1]
        room = lambda b: m.r16(m.fief(b) + M.F_HEADER) - m.r16(m.fief(b) + M.F_MEN)
        steps = [b for b in steps if room(b) >= MARCH_MIN]
        if steps:
            return ("move", max(steps, key=room), spare)
    if not capped(m, idx):                      # the economy grows first, then feeds the army
        return None
    g = m.fief(stager)
    want_g = max(0, m.r16(g + M.F_MEN) + 50 - m.r16(g + M.F_GOLD))     # a gold per man sent, and a hire
    want_r = max(0, m.r16(g + M.F_MEN) - m.r16(g + M.F_RICE))
    spare_gold = m.r16(f + M.F_GOLD) - 20
    spare_rice = m.r16(f + M.F_RICE) - max(m.r16(f + M.F_MEN), 2 * (m.r16(f + M.F_MEN) // 2 + 1))
    rice, gold = min(max(0, spare_rice), want_r), min(max(0, spare_gold), want_g)
    if rice + gold >= SEND_MIN:
        return ("send", stager, rice, gold)
    return None


# --- the planner: targets matched to sources within the free army ----------------------------
# Chris: count the free army (the men owned and buyable, less every fief's gate line), price each
# attack, and distribute: the number of targets falls out of the math, each from its own source (one
# command per fief a season), and a hole the empire nearly surrounds is worth the front it removes.
# Measured before building: 70-89% of the free army idled through the middle game, and two to three
# enemy holes stayed open four to eight years.
PLANNER = False                         # measured neutral (185 vs 186 unified, #48); kept as the foundation
MAX_TARGETS = 8


def send_needed(m, src, t):
    """(men, led) to send from src so the attack wins the calculated battle and the new fief, holding
    the survivors plus the half of the garrison that defects, clears its own share line; None if the
    source's header could never hold that many."""
    best = None
    for led in ((False, True) if m.is_capital(src) else (False,)):
        a, d = game.siege_strengths(m, src, t, 0, led)
        win = max(1, (d - a) // (3 if led else 2) + 1)
        defect = m.r16(m.fief(t) + M.F_MEN) // 2
        line = max([m.fief_men_if_provisioned(e) * 52 // 48 + 1
                    for e in reaction.enemy_neighbours(m, t) if m.fief_owner(e) != m.fief_owner(src)] or [0])
        men = max(win, line - defect)
        if best is None or men < best[0]:
            best = (men, led)
    if best and best[0] > m.r16(m.fief(src) + M.F_HEADER):
        return None
    return best


def target_gain(m, owner, src, t, men):
    """What taking t from src is worth: the army bill it removes (the holes), its harvest, a capital."""
    from . import ev
    before = army_bill(m, owner)[0]
    capital = m.is_capital(t)
    with forecast.held(m):
        ft, fs = m.fief(t), m.fief(src)
        m.w8(M.FIEF_TO_DAIMYO_MAP + t, owner)
        m.w8(M.FIEF_IS_CAPITAL + t, 0)
        m.w16(ft + M.F_MEN, men + m.r16(ft + M.F_MEN) // 2)
        m.w16(fs + M.F_MEN, max(0, m.r16(fs + M.F_MEN) - men))
        after = army_bill(m, owner)[0]
        inc = ev.income_capacity(m, t)
    return (before - after) + inc // 4 + (300 if capital else 0)


def plan(m, owner):
    """{source: (target, men, led)} for this season: distinct sources, total men within the free
    army, the most total gain. Cached per season."""
    key = (m.r16(M.CURRENT_GAME_YEAR), getattr(m, "season", 0), owner)
    if _PLAN.get("key") == key:
        return _PLAN["val"]
    free = free_army(m, owner)[0]
    options = {}                                    # target -> [(gain, men, src, led)]
    for src in owned(m, owner):
        for t in reaction.enemy_neighbours(m, src):
            sn = send_needed(m, src, t)
            if sn is None or sn[0] > free:
                continue
            g = target_gain(m, owner, src, t, sn[0])
            options.setdefault(t, []).append((g, sn[0], src, sn[1]))
    targets = sorted(options, key=lambda t: -max(o[0] for o in options[t]))[:MAX_TARGETS]
    best = [0, {}]

    def search(k, used, budget, value, chosen):
        if value > best[0]:
            best[0], best[1] = value, dict(chosen)
        if k == len(targets):
            return
        t = targets[k]
        for g, men, src, led in options[t]:
            if src not in used and men <= budget and g > 0:
                chosen[src] = (t, men, led)
                search(k + 1, used | {src}, budget - men, value + g, chosen)
                del chosen[src]
        search(k + 1, used, budget, value, chosen)
    search(0, frozenset(), free, 0, {})
    _PLAN.update(key=key, val=best[1])
    return best[1]


_PLAN = {}


def plan_move(m, idx, rng):
    """This fief's part in the plan, or None. A source attacks once loaded and the all-SAFE check
    passes, else hires toward the men it needs; any other fief marches its men above its own need
    toward the nearest source, or (topped out) sends gold and rice to the source furthest from loaded."""
    owner = m.fief_owner(idx)
    p = plan(m, owner)
    if not p:
        return None
    f = m.fief(idx)
    if idx in p:
        t, men, led = p[idx]
        if t not in reaction.enemy_neighbours(m, idx):
            return None
        if getattr(m, "season", 0) in SEASONS and war_cap(m, idx) >= men:
            ok = []
            for mv in candidates(m, idx):
                if mv[0] == t and mv[1] >= men:
                    good, v = score(m, idx, mv)
                    if good:
                        ok.append((v, mv))
            if ok:
                return ("attack", max(ok)[1])
        mv = best_attack(m, idx)                    # the plan's target is not ready: take what is
        if mv:
            return ("attack", mv)
        need = men + own_need(m, idx)
        if (capped(m, idx) and m.r16(f + M.F_MEN) < need and m.r16(f + M.F_GOLD) > men
                and m.r16(f + M.F_MORALE) >= MORALE_FLOOR):    # the economy grows first
            return ("hire", need)
        return None
    sources = list(p)
    dist = {}
    for s_ in sources:
        for k, v in distance_to(m, owner, s_).items():
            dist[k] = min(dist.get(k, 99), v)
    d = dist.get(idx)
    spare = m.r16(f + M.F_MEN) - own_need(m, idx)
    if d and spare >= MARCH_MIN and m.r16(f + M.F_MORALE) >= reaction_cliff():
        room = lambda b: m.r16(m.fief(b) + M.F_HEADER) - m.r16(m.fief(b) + M.F_MEN)
        steps = [b for b in m.neighbor_rows.get(idx, []) if dist.get(b) == d - 1 and room(b) >= MARCH_MIN]
        if steps:
            return ("move", max(steps, key=room), spare)
    if capped(m, idx):
        def lack(s_):
            g = m.fief(s_)
            men_s = p[s_][1]
            return max(0, men_s - m.r16(g + M.F_GOLD)) + max(0, men_s - m.r16(g + M.F_RICE))
        dst = max(sources, key=lack)
        g = m.fief(dst)
        men_s = p[dst][1]
        want_g = max(0, men_s + 50 - m.r16(g + M.F_GOLD))
        want_r = max(0, men_s - m.r16(g + M.F_RICE))
        spare_gold = m.r16(f + M.F_GOLD) - 20
        spare_rice = m.r16(f + M.F_RICE) - max(m.r16(f + M.F_MEN), 2 * (m.r16(f + M.F_MEN) // 2 + 1))
        rice, gold = min(max(0, spare_rice), want_r), min(max(0, spare_gold), want_g)
        if rice + gold >= SEND_MIN:
            return ("send", dst, rice, gold)
    return None


# --- the decision ---------------------------------------------------------------------------
MEN_STEPS, RICE_STEPS = 12, 6
SEASONS = (2, 3, 0)                     # after the harvest, while the rice lasts; never Summer


def _spread(lo, hi, n):
    if hi <= lo:
        return [lo]
    return sorted({lo + (hi - lo) * k // (n - 1) for k in range(n)})


def candidates(m, idx):
    """Every (target, men, rice, led) worth pricing from this fief: from the fewest men that win to
    the War command's cap, rice from 1 to all it may carry."""
    f = m.fief(idx)
    rice_have = m.r16(f + M.F_RICE)
    for t in targets(m, idx):
        for led in ((False, True) if m.is_capital(idx) and not FOUGHT else (False,)):
            k = min_men(m, idx, t, led)
            if k is None:
                continue
            for men in _spread(k, war_cap(m, idx), MEN_STEPS):
                for rice in _spread(1, min(rice_have, men), RICE_STEPS):
                    yield t, men, rice, led


def score(m, idx, move):
    """(ok, value) of a move. ok: it wins and every owned fief is SAFE after it. value, in order:
    the owned fiefs left with no enemy neighbour, the target's harvest, the rice carried (it lands
    in the new fief: its upkeep and its shield; gold is fixed at one per man), then fewer men."""
    from . import ev
    t, men, rice, led = move
    owner = m.fief_owner(idx)
    with forecast.held(m):
        if not player_war(m, idx, t, men, rice, led):
            return False, None
        states = empire(m, owner)
        if any(s != SAFE for s in states.values()) or not capital_ok(m, owner):
            return False, None
        # the fief the army left keeps a full shield (rice >= men): carrying its rice away left
        # Tokugawa's capital at rice 1 beside 276 men, and a 6-man attack took the faction
        fh = m.fief(idx)
        if m.r16(fh + M.F_RICE) < m.r16(fh + M.F_MEN):
            return False, None
        inner = sum(1 for i in states if interior(m, i))
        return True, (inner, ev.income_capacity(m, t), rice, -men)


LOOKAHEAD = True


def _next_conquest(m, owner):
    """Every second conquest the empire could make now: (src, target, men, rice, led), each from the
    owned neighbour with the most men to send, at the fewest men that win."""
    mine = owned(m, owner)
    out = []
    for t in {e for i in mine for e in reaction.enemy_neighbours(m, i)}:
        srcs = [i for i in mine if t in m.neighbor_rows.get(i, []) and war_cap(m, i)]
        if not srcs:
            continue
        src = max(srcs, key=lambda i: war_cap(m, i))
        for led in ((False, True) if m.is_capital(src) else (False,)):
            k = min_men(m, src, t, led)
            if k is not None:
                out.append((src, t, k, min(k, m.r16(m.fief(src) + M.F_RICE)), led))
                break
    return out


def plan_value(m, idx, mv):
    """Two conquests deep (Chris: plan the shape): after this move, the best follow-up the empire
    could make, scored by fiefs gained then by the smaller army bill. -> (conquests, -bill)."""
    owner = m.fief_owner(idx)
    with forecast.held(m):
        if not player_war(m, idx, *mv):
            return (0, 0)
        best = (1, -army_bill(m, owner)[0])
        for src, t, men, rice, led in _next_conquest(m, owner):
            with forecast.held(m):
                if player_war(m, src, t, men, rice, led):
                    best = max(best, (2, -army_bill(m, owner)[0]))
        return best


def best_attack(m, idx):
    """The best move from this fief, or None. Only from a position where everything owned is SAFE:
    a player who cannot hold one fief will not hold two. With LOOKAHEAD the target is the one whose
    best two-conquest outcome leaves the smallest army bill; its split is the greedy best."""
    if getattr(m, "season", 0) not in SEASONS or not war_cap(m, idx):
        return None
    if any(s != SAFE for s in empire(m, m.fief_owner(idx)).values()):
        return None
    per_target = {}
    for mv in candidates(m, idx):
        ok, v = score(m, idx, mv)
        if ok and (mv[0] not in per_target or v > per_target[mv[0]][1]):
            per_target[mv[0]] = (mv, v)
    if not per_target:
        return None
    if not LOOKAHEAD or len(per_target) == 1:
        return max(per_target.values(), key=lambda x: x[1])[0]
    return max(per_target.values(), key=lambda x: (plan_value(m, idx, x[0]), x[1]))[0]


def capped(m, idx):
    """The peasants are full ((wealth + loyalty) / 2 >= header, Give is refused): the economy has
    topped out, and the treasury is next (cap_fief_stats clamps gold at the header, so a harvest
    into a full treasury is thrown away)."""
    f = m.fief(idx)
    if WAR_AT:                                  # half the map held: the economy is bigger than every
        n = m.r16(M.SCENARIO_FIEF_COUNT)        # rival's combined, so growth stops mattering (Chris)
        live = sum(1 for i in range(n) if m.province_ai_state(i) != M.EMPTY)
        if live and len(owned(m, m.fief_owner(idx))) * 100 >= live * WAR_AT:
            return True
    return (m.r16(f + M.F_WEALTH) + m.r16(f + M.F_LOYALTY)) // 2 >= m.r16(f + M.F_HEADER) * TOPPED // 100


ARMY_SHARE = 50                         # percent of the gold a topped-out fief turns into men
TOPPED = 100                            # percent of the header at which the economy counts as topped out
WAR_AT = 0                              # percent of the live fiefs held at which every fief goes to war footing
                                        # (Chris: past about half way there is little more need to grow)
MORALE_FLOOR = 55                       # under it, that gold raises morale instead (revolts start under 45)


def expand_policy(m, idx, rng):
    """Attack when a move keeps everything SAFE; else, once the economy has topped out, buy men with
    half the gold (Chris: when wealth tops out, buy men; the other half pays the War command's gold
    per man sent); else play the reader's season."""
    from . import policy
    if PLANNER:
        pm = plan_move(m, idx, rng)
        if pm:
            PLAN_LOG.append((m.r16(M.CURRENT_GAME_YEAR), m.season, idx, pm[0]))
            if pm[0] == "attack":
                LOG.append((m.r16(M.CURRENT_GAME_YEAR), m.season, idx, *pm[1]))
                player_war(m, idx, *pm[1], rng=rng)
            elif pm[0] == "hire":
                policy._hire_up_to(m, idx, pm[1])
            elif pm[0] == "move":
                move_men(m, idx, pm[1], pm[2])
            elif pm[0] == "send":
                send(m, idx, pm[1], pm[2], pm[3])
            return
    mv = best_attack(m, idx)
    if mv:
        if FOUGHT and CHARGE and not split_ready(m, idx, mv[0]):
            from . import vmprims
            if vmprims.driver_assign(m, idx, desired_split(m, idx, mv[0])):    # this season: reshape
                ASSIGNS.append((m.r16(M.CURRENT_GAME_YEAR), m.season, idx, mv[0]))
                return
        LOG.append((m.r16(M.CURRENT_GAME_YEAR), m.season, idx, *mv))
        player_war(m, idx, *mv, rng=rng)
        return
    f = m.fief(idx)
    if DEPOTS:
        dm = staging_move(m, idx) if STAGING else None
        dm = dm or depot_move(m, idx)
        if dm and dm[0] == "move":
            DEPOT_LOG.append((m.r16(M.CURRENT_GAME_YEAR), m.season, idx, *dm))
            move_men(m, idx, dm[1], dm[2])
            return
        if dm and dm[0] == "send":
            DEPOT_LOG.append((m.r16(M.CURRENT_GAME_YEAR), m.season, idx, *dm))
            send(m, idx, dm[1], dm[2], dm[3])
            return
    if (m.is_capital(idx) and len(owned(m, m.fief_owner(idx))) > 1 and m.r16(f + M.F_GOLD) > 1
            and m.r16(f + M.F_MORALE) >= reaction_cliff()):
        short = capital_line(m, idx) - m.r16(f + M.F_MEN)
        if short > 0 and policy._hire_up_to(m, idx, capital_line(m, idx)):
            return
    if capped(m, idx) and m.r16(f + M.F_MEN) < m.r16(f + M.F_HEADER) and m.r16(f + M.F_GOLD) > 20:
        gold = m.r16(f + M.F_GOLD)
        if fief_state(m, idx) == SAFE or not reaction.threats(m, idx):
            # Recruits arrive with low morale and dilute the army's: hired season after season, a
            # capital's morale ran 77 -> 31 and the revolt took it (15 of 20 Oda empires died that
            # way, 79 of 100 strong starts). Under the floor, the gold goes to the men instead.
            if m.r16(f + M.F_MORALE) < MORALE_FLOOR:
                policy.give_men(m, idx, gold * ARMY_SHARE // 100, gold=True)
                return
            HIRES.append((m.r16(M.CURRENT_GAME_YEAR), m.season, idx, gold * ARMY_SHARE // 100))
            policy.hire_men(m, idx, gold * ARMY_SHARE // 100)
            return
    (BASE or reaction.reader_policy)(m, idx, rng)


BASE = None                             # the season's policy when the expander has nothing to do
                                        # (default the reader; a weak start passes its tuned opening)
HIRES = []
ASSIGNS = []
PLAN_LOG = []
DEPOTS = True
DEPOT_LOG = []


def reaction_cliff():
    from . import policy
    return policy.CLIFF


LOG = []
