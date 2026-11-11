"""Projecting the world forward without playing it (Chris, 2026-11-11: "where will my neighbours be
when I look up?"). Shared plumbing for any player that weighs the future: the EV player (ev.py) first.

A projected season is the season driver's slow parts, in expectation:
  * the year rolls at Spring (Dz.play writes CURRENT_GAME_YEAR after Winter);
  * Fall: every live fief harvests (game.harvest_fief: income, debt, upkeep, the starvation clause)
    with the income rolls at their mean, then cap_fief_stats;
  * every season: the AI fiefs recruit on the ROM's schedule (grow_ai, ai_vm.recruit_arm_train).
Not projected: events, wars, the AI's building and arming, and any human command (a caller adds its
own, e.g. ev's future Summer rice). Everything runs on the real memory inside `held`, which puts the
memory, the RNG and the selection back: asking must not change the game.
"""
from contextlib import contextmanager

from . import memmap as M, vmprims as P


class Mean:
    """An RNG stand-in that rolls the mean (policy._Floor is the lowest)."""
    def randrange(self, n):
        return n // 2


def snapshot(m):
    return bytes(m.m), m.rng.getstate(), m.r16(M.SELECTED_PROVINCE), getattr(m, "selected", None)


def restore(m, snap):
    mem, rng, _sel, selected = snap
    m.m[:] = mem
    m.rng.setstate(rng)
    if selected is not None:
        m.selected = selected


@contextmanager
def held(m):
    """Anything done to `m` inside is undone on the way out."""
    snap = snapshot(m)
    try:
        yield m
    finally:
        restore(m, snap)


def grow_ai(m):
    """One projected season of AI recruiting, in expectation (ai_vm.recruit_arm_train): ~90% of AI
    fiefs take the military pass (rng(10) != 0); one under min((year-1559)*40, cap) men recruits with
    probability (skill+3)/10, min(half its gold surplus x10 / rate, room to (year-1559)*100) men,
    paying the half-surplus whatever it hires. So every New Year lifts every AI target by 40 men."""
    year, rate, n = m.year, m.r16(M.GOLD_MEN_HIRE_RATE) or 50, m.r16(M.SCENARIO_FIEF_COUNT)
    p = 0.9 * (m.skill + 3) / 10
    for i in range(n):
        if m.province_ai_state(i) != 0:
            continue
        f = m.fief(i)
        men, gold, header = m.r16(f + M.F_MEN), m.r16(f + M.F_GOLD), m.r16(f + M.F_HEADER)
        if min((year - 1559) * 40, header) <= men:
            continue
        half = max(0, gold - men) // 2
        cnt = min(half * 10 // rate, min((year - 1559) * 100, header) - men)
        if cnt > 0:
            m.w16(f + M.F_MEN, men + round(p * cnt))
            m.w16(f + M.F_GOLD, gold - round(p * half))


def harvest_all(m, only=None):
    """The Fall harvest at mean income for every live fief (or only the fiefs in `only`)."""
    from . import game
    for i in range(m.r16(M.SCENARIO_FIEF_COUNT)):
        if m.province_ai_state(i) != M.EMPTY and (only is None or i in only):
            game.harvest_fief(m, i, Mean())
            P.cap_fief_stats(m, i)


def step(m, season, *, growth=True, harvest_only=None, before_harvest=None):
    """Advance the memory through one projected `season` (0 Spring .. 3 Winter), in place.
    `before_harvest(m)` runs first in a Fall (a command the caller assumes, such as a rice buy)."""
    if season == 2:
        if before_harvest:
            before_harvest(m)
        harvest_all(m, harvest_only)
    if growth:
        if season == 0:
            m.w16(M.CURRENT_GAME_YEAR, m.year + 1)
        grow_ai(m)


def seasons_ahead(m, n):
    """The (k, season) pairs of the next n seasons after this one."""
    s0 = getattr(m, "season", 0)
    return [(k, (s0 + k) % 4) for k in range(1, n + 1)]


@contextmanager
def projected(m, n, **kw):
    """The memory as it would stand n seasons ahead if this fief and the player stand still."""
    with held(m):
        for _k, t in seasons_ahead(m, n):
            step(m, t, **kw)
        yield m


def threats_in(m, idx, n):
    """Who would pick fief `idx` n seasons from now, if it stands still (reaction.threats there)."""
    from . import reaction
    with projected(m, n):
        return reaction.threats(m, idx)


def neighbours_in(m, idx, n):
    """{neighbour: (men, budget)} n seasons from now, standing still."""
    from . import reaction
    with projected(m, n):
        out = {}
        for nb in m.neighbor_rows.get(idx, []):
            if nb < m.r16(M.SCENARIO_FIEF_COUNT) and m.province_ai_state(nb) != M.EMPTY:
                s = reaction.live_side(m, nb)
                out[nb] = (s.men, reaction.budget(s))
        return out
