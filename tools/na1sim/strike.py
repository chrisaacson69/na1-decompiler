"""The human combat player: where to deploy against an attacker's commander, and the strike.

The battle is decided by the commanders (#42), so the defender's plan is decapitation: be next to
the attacker's commander before his army can matter. Three facts from the ROM make it a plan:

- The defender deploys first and moves first every day (`battle_init_defender` leaves
  cur_combat_side = 1). Each unit gets ONE verb a day: Move one hex, or Attack one adjacent enemy
  (`player_move_unit_until_placed_loop` $A90E, `..._with_occupancy_check_loop` $A96C, both
  return 0 = the unit's turn is spent). So a unit two hexes off steps in on day 1, strikes on day 2.
- The attacker's commander lands by `rng_search_combat_rect_for_unit_cell` $9954: the first strip
  cell in scan order with none of our units on or next to it. The scan reverses by reflecting off
  the strip's MAX (`x = flip ? xi : x_max - xi`), so from the EAST (x 7-10, flip_x forced 0) every
  scanned column is 3..0, outside the strip: an eastern commander always falls to the random drop
  (uniform over the free strip cells, with no check for our units: he can land next to one). From
  the SOUTH (y 2-4, flip_y forced 0) only row 2 is in the strip. North and West scan the strip from
  one of two corners, by a coin. Checked on the 299 captured Saito invasions: E 87/87 random,
  N/S/W 212/212 scanned, each onto one of two corner cells (one W exception).
- An exchange is mutual and deterministic (`resolve_attack_apply_mutual_casualties` $9E20): the
  target loses p% of its men, the attacker 100-p%, and every exchange a unit has taken this turn
  gives the next attacker on it +20% of base (`$7BEE` momentum, reset each side-turn). Several
  strikers on one commander in one turn escalate; a lone striker does not.

The deployment planner searches the placements of the non-commander units (the commander holds the
castle seat), scoring each by the exact landing model above:
  contact  maximise P(at least one unit engages the commander by day 2), then the expected count;
  pocket   on scan edges, force ONE landing cell (cover every other strip cell), then maximise the
           units that engage it; on the east, maximise the expected count.
"Engage" = already adjacent (strikes on day 1) or two hexes off with a free neighbour of his
cell to step into, after his two bodyguards take theirs (`ai_place_unit_in_free_slot_resolve_coords`
$9810: slots 1-2 on his first free neighbours in direction order). A unit's distinct step cells
are assigned by matching.

The day script (`act`): a unit next to the enemy commander attacks him; a striker otherwise steps
to a free neighbour of his cell, or toward him; anything else runs the AI logic (the human side
never retreats: OPENING no_retreat). Arms: control (AI placement + the script), contact, pocket.
"""
import copy
import itertools
import random

from . import memmap as M, tactical as T

CELLS = [(x, y) for y in range(5) for x in range(11)]
BIT = {c: 1 << i for i, c in enumerate(CELLS)}


def _nbrs(c):
    out = []
    for d in range(6):
        moved, nx, ny = T.step_coord_by_direction(c[0], c[1], d)
        if moved:
            out.append((nx, ny))
    return out


NB = {c: _nbrs(c) for c in CELLS}
NBMASK = {c: sum(BIT[n] for n in NB[c]) for c in CELLS}


def _scratch(m):
    s = copy.copy(m)
    s.m = bytearray(m.m)
    s.rng = random.Random(0)
    return s


class Geometry:
    """One defending map against one approach: the strip, the scan orders, the free cells."""

    def __init__(self, m):
        s = _scratch(m)
        T.clear_all_unit_positions(s)
        s.cur_combat_side = 0
        self.edge = T.set_combat_arena_rect_by_approach(s)
        self.strip = [c for c in CELLS if T.is_coord_in_combat_rect(s, *c) and not T.is_map_cell_blocked(s, *c)
                      and not T.tile_blocked_for_placement(s, *c)]
        self.stripmask = sum(BIT[c] for c in self.strip)
        x0, x1 = s.r16(M.COMBAT_ARENA_X_MIN), s.r16(M.COMBAT_ARENA_X_MAX)
        y0, y1 = s.r16(M.COMBAT_ARENA_Y_MIN), s.r16(M.COMBAT_ARENA_Y_MAX)
        flips = {1: [(0, 1), (1, 1)], 2: [(0, 0), (1, 0)], 3: [(1, 0), (1, 1)], 4: [(0, 0), (0, 1)]}[self.edge]
        self.orders = []                      # per corner: the scan sequence restricted to strip cells
        for fx, fy in flips:
            seq = []
            for xi in range(x0, x1 + 1):
                for yi in range(y0, y1 + 1):
                    c = (xi if fx else x1 - xi, yi if fy else y1 - yi)
                    if c in BIT and BIT[c] & self.stripmask:
                        seq.append(c)
            self.orders.append(seq)
        self.seat = T.find_free_tactical_placement_cell(s)
        self.free = [c for c in CELLS if not T.is_map_cell_blocked(s, *c)]
        self.freemask = sum(BIT[c] for c in self.free)

    def landings(self, cells, atk_present):
        """Our units on `cells` -> [(prob, commander cell, bodyguard cells, scanned?)]."""
        occ = sum(BIT[c] for c in cells)
        covered = occ | sum(NBMASK[c] for c in cells)
        out = []
        for seq in self.orders:
            land = next((c for c in seq if not BIT[c] & covered), None)
            if land is None:
                out.extend(self._random(occ, 1 / len(self.orders)))
            else:
                out.append((1 / len(self.orders), land, self._guards(land, occ, atk_present), True))
        return out

    def _random(self, occ, w):
        cand = [c for c in self.strip if not BIT[c] & occ]
        return [(w / len(cand), c, (), False) for c in cand] if cand else []

    def _guards(self, land, occ, atk_present):
        """ai_place_unit_in_free_slot_resolve_coords(3) $9810 around the commander's cell."""
        taken, guards, slot = occ | BIT[land], [], 1
        for d in range(6):
            if slot >= 3:
                break
            if not atk_present[slot]:
                slot += 1
                continue
            moved, nx, ny = T.step_coord_by_direction(land[0], land[1], d)
            if moved and BIT[(nx, ny)] & self.stripmask and not BIT[(nx, ny)] & taken:
                taken |= BIT[(nx, ny)]
                guards.append((nx, ny))
                slot += 1
        return tuple(guards)

    def engagers(self, cells, land, guards):
        """Units that hit the commander by day 2: adjacent now, or a distinct free step cell."""
        occ = sum(BIT[c] for c in cells) | BIT[land] | sum(BIT[g] for g in guards)
        adjacent = [c for c in cells if BIT[c] & NBMASK[land]]
        open_ = [n for n in NB[land] if BIT[n] & self.freemask and not BIT[n] & occ]
        movers = [c for c in cells if c not in adjacent]
        return len(adjacent) + _matching(movers, open_)


def _matching(units, targets):
    """Maximum bipartite matching: each unit to a distinct target cell it neighbours."""
    match = {}

    def aug(u, seen):
        for t in targets:
            if t in NB[u] and t not in seen:
                seen.add(t)
                if t not in match or aug(match[t], seen):
                    match[t] = u
                    return True
        return False
    return sum(1 for u in units if aug(u, set()))


_PLANS = {}


def plan(m, objective, n_units, atk_present):
    """The best cells for `n_units` non-commander units (the commander takes the seat)."""
    geo = Geometry(m)
    key = (T.fief_to_mapid(m, m.defending), geo.edge, n_units, tuple(atk_present), objective)
    if key in _PLANS:
        return geo, _PLANS[key]
    reach = geo.stripmask                     # cells within two hexes of the strip: the only ones that matter
    for _ in range(2):
        reach |= sum(NBMASK[c] for c in CELLS if BIT[c] & reach)
    lead = objective == "lead"                # the commander strikes too: n_units + 1 cells, no seat
    near = [c for c in geo.free if (lead or c != geo.seat) and BIT[c] & reach]
    best, best_score = None, None
    for cells in itertools.combinations(near, n_units + lead):
        allc = cells if lead else (geo.seat,) + cells
        lands = geo.landings(allc, atk_present)
        if not lands:
            continue
        if objective in ("pocket", "lead") and geo.edge != 4:
            if len({c for _, c, _, _ in lands}) != 1 or not all(sc for _, _, _, sc in lands):
                continue
        eng = [(p, geo.engagers(cells, c, g)) for p, c, g, _ in lands]
        p_any = sum(p for p, e in eng if e)
        mean = sum(p * e for p, e in eng)
        if lead:                              # the commander's own cell must engage, in every landing
            if any(not geo.engagers((cells[0],), c, g) for _, c, g, _ in lands):
                cells = None
            if cells is None:
                continue
        score = (p_any, mean) if objective == "contact" else (mean, p_any)
        if best_score is None or score > best_score:
            best, best_score = cells, score
    _PLANS[key] = (best, best_score)
    return geo, _PLANS[key]


def plan_single(m, n_home, atk_present):
    """Arm 'single' (Chris: does starting next to the commander beat forcing him into a pocket?): ONE
    striker, placed to engage by day 2 whichever corner he scans from; the other units stand on the
    free cells nearest the seat, off the strip. Returns (geo, (cells: striker first, score))."""
    geo = Geometry(m)
    key = (T.fief_to_mapid(m, m.defending), geo.edge, n_home, tuple(atk_present), "single")
    if key in _PLANS:
        return geo, _PLANS[key]
    dist = _distances(m, geo.seat)
    home = tuple(sorted((c for c in geo.free if c != geo.seat and not BIT[c] & geo.stripmask),
                        key=lambda c: (dist.get(c, 99), c))[:n_home])
    best, best_score = None, None
    for c in geo.free:
        if c == geo.seat or c in home:
            continue
        lands = geo.landings((geo.seat,) + home + (c,), atk_present)
        if not lands:
            continue
        eng = [(p, geo.engagers((c,), l, g)) for p, l, g, _ in lands]
        score = (sum(p for p, e in eng if e), sum(p * e for p, e in eng))
        if best_score is None or score > best_score:
            best, best_score = (c,) + home, score
    _PLANS[key] = (best, best_score)
    return geo, _PLANS[key]


def _cell(m, side, slot):
    return m.r8(m.unit_col_ptr(side, slot)), m.r8(m.unit_row_ptr(side, slot))


class Player:
    """A HUMAN for tactical.py: deploy by plan (or the AI's placement, arm 'control'), then strike."""

    def __init__(self, arm):
        self.arm = arm
        self.log = []                         # per battle: plan score, engagers, outcome bits

    def deploy(self, m):
        side = m.cur_combat_side
        self.strikers = set(range(1, 5))
        if self.arm == "control":
            edge = T.set_combat_arena_rect_by_approach(m)
            T.ai_place_combat_units_random_or_smart(m, edge)
            self.log.append(dict(score=None))
            return
        units = [s for s in range(1, 5) if m.is_unit_present(side, s)]
        atk_present = [m.is_unit_present(side ^ 1, s) for s in range(5)]
        if self.arm == "single":
            geo, (cells, score) = plan_single(m, len(units) - 1, atk_present)
        else:
            geo, (cells, score) = plan(m, self.arm, len(units), atk_present)
        self.strikers = set(units[:1]) if self.arm == "single" else set(units)
        targets = list(cells or []) if self.arm == "lead" else [geo.seat] + list(cells or [])
        if cells is None:                     # no admissible placement: the AI's own
            T.ai_place_combat_units_random_or_smart(m, T.set_combat_arena_rect_by_approach(m))
            self.log.append(dict(score=None))
            return
        m.cur_combat_unit_slot = 0
        it = iter(targets)
        for slot in range(5):
            m.cur_combat_unit_slot = slot
            if m.is_unit_present(side, slot):
                assert T.commit_unit_dest_tile_if_valid(m, *next(it))
        self.log.append(dict(score=score, edge=geo.edge))

    def act(self, m, day, slot):
        side = m.cur_combat_side
        es = side ^ 1
        if not m.is_unit_present(es, 0):
            return None
        cmd = _cell(m, es, 0)
        here = _cell(m, side, slot)
        if here in NB[cmd]:
            return ("attack", 0)
        if (slot == 0 and self.arm != "lead") or (slot and slot not in getattr(self, "strikers", range(1, 5))):
            return None                       # the commander holds the seat; non-strikers: the AI logic
        free = [n for n in NB[cmd] if not T.is_any_unit_at_tile(m, *n) and not T.is_map_cell_blocked(m, *n)]
        step = [n for n in NB[here] if n in free]
        if step:
            return ("move",) + step[0]
        # one hex toward him: the free neighbour of ours nearest his cell (hex distance by BFS)
        dist = _distances(m, cmd)
        best = min(((dist.get(n, 99), n) for n in NB[here]
                    if not T.is_any_unit_at_tile(m, *n) and not T.is_map_cell_blocked(m, *n)), default=None)
        if best and best[0] < dist.get(here, 99):
            return ("move",) + best[1]
        return None


class Doctrine(Player):
    """The combat doctrine for whole games (#43): read the attacker's days of food (his rice over
    men/30, `consume_daily_battle_rice` $830B) and pick the arm. Short-fed: `short` (default control:
    hold the castle, strike only what comes next to you, win on his clock). Long-fed: `long`
    (default contact, the best at the 20x5 a player has until he spends an Assign; after an Assign
    to a heavy commander, single is best). Rebels and the player's own attacks: control (the
    planner assumes a defended castle against an entry strip). Set it as tactical.HUMAN with
    OPENING no_retreat=1 (deaths.py --combat doctrine)."""

    def __init__(self, short="control", long="contact", gate=20):
        super().__init__(short)
        self.short, self.long, self.gate = short, long, gate

    def deploy(self, m):
        side = m.cur_combat_side
        a = m.side_resource_ptr(side ^ 1)
        men, rice = m.r16(a + M.SR_MEN), m.s16(a + M.SR_RICE)
        days = rice * 30 // men if men else 99
        if side == 0 or m.selected == 50:
            self.arm = "control"
        else:
            self.arm = self.short if days < self.gate else self.long
        super().deploy(m)
        self.log[-1].update(arm=self.arm, days=days)


def _distances(m, src):
    """Hex distance from src over unblocked cells (units ignored)."""
    dist, frontier = {src: 0}, [src]
    while frontier:
        nxt = []
        for c in frontier:
            for n in NB[c]:
                if n not in dist and not T.is_map_cell_blocked(m, *n):
                    dist[n] = dist[c] + 1
                    nxt.append(n)
        frontier = nxt
    return dist


class Charge:
    """The attack doctrine (Chris, 2026-11-12). The AI defender puts its commander on the castle seat
    and its other units around him, and it places first, so his cell is known when we place. Our
    commander goes on the strip cell farthest from him; units 1-4 on the strip cells nearest him, in
    slot order (the army moves in slot order, so the column marches in naturally, through a
    chokepoint too). Each day our commander holds back; units 1-4 strike the enemy commander when
    next to him, else step along the shortest path toward him, attack an enemy unit that blocks that
    path, and side-step to a free cell no farther from him when one of ours blocks it (so a unit
    behind can come up beside the lead and both strike). His cell is read each day, so a commander
    who flees is pursued. Terrain choice is not modelled yet."""

    def __init__(self):
        self.log = []

    def deploy(self, m):
        side = m.cur_combat_side
        es = side ^ 1
        T.set_combat_arena_rect_by_approach(m)
        strip = [c for c in CELLS if T.is_coord_in_combat_rect(m, *c) and not T.is_map_cell_blocked(m, *c)
                 and not T.tile_blocked_for_placement(m, *c) and not T.is_any_unit_at_tile(m, *c)]
        target = _cell(m, es, 0) if m.is_unit_present(es, 0) else None
        if not strip or target is None:
            T.ai_place_combat_units_random_or_smart(m, T.set_combat_arena_rect_by_approach(m))
            return
        dist = _distances(m, target)
        near = sorted(strip, key=lambda c: (dist.get(c, 99), c))
        far = max(strip, key=lambda c: (dist.get(c, -1), c))
        plan = {}
        if m.is_unit_present(side, 0):
            plan[0] = far
        rest = [c for c in near if c != far]
        for slot in range(1, 5):
            if m.is_unit_present(side, slot) and rest:
                plan[slot] = rest.pop(0)
        for slot in range(5):
            if slot not in plan:
                continue
            m.cur_combat_unit_slot = slot
            if not T.commit_unit_dest_tile_if_valid(m, *plan[slot]):
                for c in rest:                        # the planned cell was refused: the next nearest
                    if T.commit_unit_dest_tile_if_valid(m, *c):
                        rest.remove(c)
                        break
        self.log.append(dict(target=target))

    def act(self, m, day, slot):
        side = m.cur_combat_side
        es = side ^ 1
        if not m.is_unit_present(es, 0):
            return None
        if slot == 0:
            return ("pass",)                          # the commander stays out of the fighting
        target = _cell(m, es, 0)
        here = _cell(m, side, slot)
        if here in NB[target]:
            return ("attack", 0)
        dist = _distances(m, target)
        d0 = dist.get(here, 99)
        enemy_at = {_cell(m, es, s): s for s in range(5) if m.is_unit_present(es, s)}
        ours = [_cell(m, side, s) for s in range(5) if m.is_unit_present(side, s)]
        # kill what stands in the way, focused: an adjacent enemy on the path or guarding the
        # commander, the one with the most of our units already beside it (each extra attacker on a
        # unit in one turn adds 20%, the $7BEE momentum: the AI's spread wins by it, a lone column not)
        blockers = [n for n in NB[here] if n in enemy_at and (dist.get(n, 99) < d0 or n in NB[target])]
        if blockers:
            n = max(blockers, key=lambda c: (sum(1 for o in ours if o in NB[c]), -dist.get(c, 99)))
            return ("attack", enemy_at[n])
        closer = sorted((dist.get(n, 99), -sum(1 for e in enemy_at if e in NB[n]), n)
                        for n in NB[here] if dist.get(n, 99) < d0)
        for _, _, n in closer:
            if not T.is_any_unit_at_tile(m, *n):
                return ("move",) + n
        side_steps = sorted((dist.get(n, 99), n) for n in NB[here]
                            if dist.get(n, 99) <= d0 and not T.is_any_unit_at_tile(m, *n)
                            and not T.is_map_cell_blocked(m, *n))
        if side_steps:
            return ("move",) + side_steps[0][1]
        for n in NB[here]:
            if n in enemy_at:
                return ("attack", enemy_at[n])
        return ("pass",)


# ---------------------------------------------------------------------------- Assign
def assign(split):
    """An Assign made before the battle (effect_assign bank 1 $AC11 -> commit_arms_record_from_buffer
    $ABBD): the defending fief's unit-type split ($76A9 + fief*5) becomes `split`. The editor moves
    points between rows, so the total is conserved (the commit is cancelled unless the pool is 0);
    row 0 (commander) keeps at least 1; row 2 (musket) is capped at arms/50 + 20. -> prepare(m)
    for battles.replay, or None if the split is not one the editor can make on this fief."""
    from . import vmprims as P

    def prepare(m):
        if not P.assign_reachable(m, m.defending, split):
            base = M.PROVINCE_UNIT_TYPE_PCT + m.defending * 5
            raise ValueError(f"Assign cannot make {split} from {[m.r8(base + i) for i in range(5)]}")
        P.commit_arms_record(m, m.defending, list(split), 0)
    return prepare


# ---------------------------------------------------------------------------- the trial
ARMS = ("control", "single", "contact", "pocket", "lead")
SPLIT = None


def _trial_one(rec):
    from . import battles as B
    prep = assign(SPLIT) if SPLIT else None
    row = dict(seed=rec["seed"], attacker=rec["attacker"], atk_men=rec["atk_men"], atk_days=rec["atk_days"],
               base=rec["won"])
    try:
        row["no_retreat"] = B.replay(rec, {"no_retreat": 1}, prep)[1]
    except ValueError:
        return None
    for arm in ARMS:
        pl = Player(arm)
        T.HUMAN = pl
        try:
            outcome, held, _, m = B.replay(rec, {"no_retreat": 1}, prep)
        finally:
            T.HUMAN = None
        row[arm] = held
        row[arm + "_code"] = outcome
        row[arm + "_score"] = pl.log[0].get("score") if pl.log else None
        row["edge"] = pl.log[0].get("edge", row.get("edge")) if pl.log else row.get("edge")
    if row.get("edge") is None:
        m, _ = __import__("pickle").loads(rec["start"])
        row["edge"] = Geometry(m).edge
    return row


def _init(split):
    global SPLIT
    SPLIT = split


def trial(recs, split=None, procs=6):
    from concurrent.futures import ProcessPoolExecutor
    with ProcessPoolExecutor(procs, initializer=_init, initargs=(split,)) as ex:
        rows = list(ex.map(_trial_one, recs, chunksize=8))
    skipped = sum(r is None for r in rows)
    if skipped:
        print(f"({skipped} starts skipped: Assign cannot make that split there)")
    return [r for r in rows if r is not None]


def report(rows):
    cols = ("base", "no_retreat") + ARMS
    def line(name, rs):
        out = f"{name:22}{len(rs):4} |" + "".join(f"{sum(r[c] for r in rs):8}" for c in cols)
        return out + "  | pocket vs single +%d/-%d" % (sum(r["pocket"] and not r["single"] for r in rs),
                                                    sum(r["single"] and not r["pocket"] for r in rs))
    print(f"{'held, by slice':22}{'n':>4} |" + "".join(f"{c:>8}" for c in cols))
    print(line("all invasions", rows))
    for e, nm in ((1, "N"), (2, "S"), (3, "W"), (4, "E")):
        print(line(f"  approach {nm}", [r for r in rows if r["edge"] == e]))
    for lo, hi in ((0, 40), (40, 60), (60, 80), (80, 120), (120, 9999)):
        print(line(f"  men {lo}-{hi if hi < 9999 else ''}", [r for r in rows if lo <= r["atk_men"] < hi]))
    for lo, hi in ((0, 20), (20, 30), (30, 9999)):
        print(line(f"  days of food {lo}-{hi if hi < 9999 else ''}", [r for r in rows if lo <= r["atk_days"] < hi]))


def main():
    import argparse
    import json
    from pathlib import Path
    from . import battles as B
    ap = argparse.ArgumentParser()
    ap.add_argument("path")
    ap.add_argument("--split", help="an Assign before the battle, e.g. 20,20,10,10,10 (sum as the fief's)")
    ap.add_argument("--out")
    a = ap.parse_args()
    recs = [r for r in B.load(Path(a.path)) if r["kind"] == "invasion"]
    rows = trial(recs, tuple(int(v) for v in a.split.split(",")) if a.split else None)
    report(rows)
    if a.out:
        json.dump(rows, open(a.out, "w"))


if __name__ == "__main__":
    main()
