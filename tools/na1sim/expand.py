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


def after(m, idx, tgt, men, rice, led=False):
    """The map after the attack, without changing the game: (won, {fief: state})."""
    owner = m.fief_owner(idx)
    with forecast.held(m):
        won = player_war(m, idx, tgt, men, rice, led)
        return won, empire(m, owner)


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
    the owned fiefs left with no enemy neighbour, the target's harvest, then fewer men sent."""
    from . import ev
    t, men, rice, led = move
    owner = m.fief_owner(idx)
    with forecast.held(m):
        if not player_war(m, idx, t, men, rice, led):
            return False, None
        states = empire(m, owner)
        if any(s != SAFE for s in states.values()):
            return False, None
        inner = sum(1 for i in states if interior(m, i))
        return True, (inner, ev.income_capacity(m, t), -men)


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
    if capped(m, idx) and m.r16(f + M.F_MEN) < m.r16(f + M.F_HEADER) and m.r16(f + M.F_GOLD) > 20:
        gold = m.r16(f + M.F_GOLD)
        if fief_state(m, idx) == SAFE or not reaction.threats(m, idx):
            HIRES.append((m.r16(M.CURRENT_GAME_YEAR), m.season, idx, gold * ARMY_SHARE // 100))
            policy.hire_men(m, idx, gold * ARMY_SHARE // 100)
            return
    reaction.reader_policy(m, idx, rng)


HIRES = []


LOG = []
