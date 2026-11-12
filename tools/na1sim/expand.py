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


def player_war(m, idx, tgt, men, rice, led=False, rng=None):
    """Fight it: commit as driver_war does, resolve with the calculated battle. -> True if won."""
    f = m.fief(idx)
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
    game.resolve_siege(m, rng or random.Random(0))
    return m.fief_owner(tgt) == m.fief_owner(idx)


def wins(m, idx, tgt, men, led=False):
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
        for led in ((False, True) if m.is_capital(idx) else (False,)):
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


def best_attack(m, idx):
    """The best move from this fief, or None. Only from a position where everything owned is SAFE:
    a player who cannot hold one fief will not hold two."""
    if getattr(m, "season", 0) not in SEASONS or not war_cap(m, idx):
        return None
    if any(s != SAFE for s in empire(m, m.fief_owner(idx)).values()):
        return None
    best, best_v = None, None
    for mv in candidates(m, idx):
        ok, v = score(m, idx, mv)
        if ok and (best_v is None or v > best_v):
            best, best_v = mv, v
    return best


def capped(m, idx):
    """The peasants are full ((wealth + loyalty) / 2 >= header, Give is refused): the economy has
    topped out, and the treasury is next (cap_fief_stats clamps gold at the header, so a harvest
    into a full treasury is thrown away)."""
    f = m.fief(idx)
    return (m.r16(f + M.F_WEALTH) + m.r16(f + M.F_LOYALTY)) // 2 >= m.r16(f + M.F_HEADER)


ARMY_SHARE = 50                         # percent of the gold a topped-out fief turns into men
MORALE_FLOOR = 55                       # under it, that gold raises morale instead (revolts start under 45)


def expand_policy(m, idx, rng):
    """Attack when a move keeps everything SAFE; else, once the economy has topped out, buy men with
    half the gold (Chris: when wealth tops out, buy men; the other half pays the War command's gold
    per man sent); else play the reader's season."""
    from . import policy
    mv = best_attack(m, idx)
    if mv:
        LOG.append((m.r16(M.CURRENT_GAME_YEAR), m.season, idx, *mv))
        player_war(m, idx, *mv, rng=rng)
        return
    f = m.fief(idx)
    if DEPOTS:
        dm = depot_move(m, idx)
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
    reaction.reader_policy(m, idx, rng)


HIRES = []
DEPOTS = True
DEPOT_LOG = []


def reaction_cliff():
    from . import policy
    return policy.CLIFF


LOG = []
