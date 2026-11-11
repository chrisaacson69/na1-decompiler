"""Fixed battle plans for one fief (Chris, 2026-11-11): a deployment per entry side, then a day script.

Built for Echigo (fief 1), whose ring terrain lets the defender decide the attacker's setup
(#44). The placements come from the entry atlas (`tools/battle-entry-atlas.py`):

  south  commander on the seat; slots 1-2 on (8,1) (7,1), slots 3-4 on (2,1) (3,1). The coin puts his
         commander on (10,2) or (0,2), and either way two of ours are 2 hexes off along row 1, which his
         random drops can never reach (row 1 is outside his strip).
  west   all five on (0,1) (0,2) (1,1) (2,1) (3,1), the commander on (3,1): the whole enemy layout is
         fixed (his commander (0,4), guards (0,3) (1,4), random drops on (2,4) (3,4)). Our commander
         walks home (2 days) after the deployment; the cover only matters while he deploys.

Day scripts (`mode`):
  strike  each non-commander unit: next to his commander -> attack him; else step to a free cell next
          to him, else one hex closer; else, blocked, attack the adjacent enemy nearest his commander
          (burn through the guard). Our commander walks to the seat, then fights only what is next to it.
  hold    strike, but never give a daimyo-led commander the excuse to flee: he gives the battle up at
          the start of his own turn when his men doubled are under the men of our units NEXT TO HIM
          (`ai_claim_province_when_strong_enough` $A84D over `build_reachable_enemy_target_list` $A0F3,
          adjacent cells only; oracle flee[*]). So a unit steps next to him only while our adjacent
          total stays at or under 2x his men, and waits two hexes off otherwise; units already next to
          him attack together (each exchange on him this turn gives the next +20%, `$7BEE`). Against
          a general (no flight) it is plain strike.
  run     our commander holds the seat (fighting only what is next to it); every other unit steps to
          the free neighbour farthest from the nearest enemy unit and never attacks: circle the castle,
          play for his rice and the day-30 clock.

Another fief, an entry side without a plan (rebels, the odd east attack) falls back to `strike.Doctrine`.
"""
from . import memmap as M, tactical as T
from .strike import NB, Doctrine, Player, _cell, _distances

ECHIGO = {
    2: [(5, 2), (8, 1), (7, 1), (2, 1), (3, 1)],          # south: slot order 0..4
    3: [(3, 1), (0, 1), (0, 2), (1, 1), (2, 1)],          # west: the commander on (3,1)
}


def _free(m, c):
    return not T.is_any_unit_at_tile(m, *c) and not T.is_map_cell_blocked(m, *c)


class PlanPlayer(Player):
    def __init__(self, fief, cells_by_edge, mode="strike", k=2):
        super().__init__("plan")
        self.fief, self.cells, self.mode, self.k = fief, cells_by_edge, mode, k
        self.fallback = None

    # ------------------------------------------------------------------ deployment
    def deploy(self, m):
        side = m.cur_combat_side
        m.cur_combat_side = 0
        edge = T.set_combat_arena_rect_by_approach(m)        # the attacker's entry (its rect is recomputed)
        m.cur_combat_side = side
        T.set_combat_arena_rect_by_approach(m)               # ours: the full board
        self.edge = edge
        self.seat = T.find_free_tactical_placement_cell(m)
        if side == 0 or m.selected == 50 or m.defending != self.fief or edge not in self.cells:
            self.fallback = Doctrine()
            self.fallback.deploy(m)
            self.log.append(dict(edge=edge, plan=None))
            return
        self.fallback = None
        cells = iter(self.cells[edge])
        for slot in range(5):
            target = next(cells)
            m.cur_combat_unit_slot = slot
            if m.is_unit_present(side, slot):
                assert T.commit_unit_dest_tile_if_valid(m, *target), (slot, target)
        self.log.append(dict(edge=edge, plan=self.mode))

    # ------------------------------------------------------------------ the day script
    def act(self, m, day, slot):
        if self.fallback:
            return self.fallback.act(m, day, slot)
        side = m.cur_combat_side
        es = side ^ 1
        here = _cell(m, side, slot)
        enemies = [_cell(m, es, s) for s in range(5) if m.is_unit_present(es, s)]
        if not enemies:
            return ("pass",)
        if slot == 0:
            return self._home(m, here, es)
        if self.mode == "run":
            return self._run(m, here, enemies)
        if not m.is_unit_present(es, 0):
            return ("pass",)
        cmd = _cell(m, es, 0)
        if here in NB[cmd]:
            return ("attack", 0)
        step = [n for n in NB[here] if n in NB[cmd] and _free(m, n)]
        if step and self.mode == "hold" and m.test_6f65_bit7(es):
            adj = sum(m.r16(m.unit_strength_ptr(side, s)) for s in range(5)
                      if m.is_unit_present(side, s) and _cell(m, side, s) in NB[cmd])
            if adj + m.r16(m.unit_strength_ptr(side, slot)) > 2 * m.r16(m.unit_strength_ptr(es, 0)):
                return ("pass",) if _distances(m, cmd).get(here, 99) <= 2 else self._closer(m, here, cmd, keep=2)
        if step:
            return ("move",) + step[0]
        dist = _distances(m, cmd)
        best = min(((dist.get(n, 99), n) for n in NB[here] if _free(m, n)), default=None)
        if best and best[0] < dist.get(here, 99):
            return ("move",) + best[1]
        # blocked: burn through the adjacent enemy nearest his commander
        adj = [(dist.get(_cell(m, es, s), 99), s) for s in range(1, 5)
               if m.is_unit_present(es, s) and _cell(m, es, s) in NB[here]]
        if adj:
            return ("attack", min(adj)[1])
        return ("pass",)

    def _closer(self, m, here, cmd, keep=0):
        """One hex toward his commander, but not nearer than `keep` hexes."""
        dist = _distances(m, cmd)
        best = min(((dist.get(n, 99), n) for n in NB[here] if _free(m, n) and dist.get(n, 99) >= keep),
                   default=None)
        if best and best[0] < dist.get(here, 99):
            return ("move",) + best[1]
        return ("pass",)

    def _home(self, m, here, es):
        """Our commander: walk to the seat; on it, fight only what is next to it."""
        if here != self.seat:
            dist = _distances(m, self.seat)
            best = min(((dist.get(n, 99), n) for n in NB[here] if _free(m, n)), default=None)
            if best and best[0] < dist.get(here, 99):
                return ("move",) + best[1]
        adj = [s for s in range(5) if m.is_unit_present(es, s) and _cell(m, es, s) in NB[here]]
        if adj:
            return ("attack", 0 if 0 in adj else adj[0])
        return ("pass",)

    def _run(self, m, here, enemies):
        def gap(c):
            return min(_distances(m, e).get(c, 99) for e in enemies)
        best = max(((gap(n), n) for n in NB[here] if _free(m, n)), default=None)
        if best and best[0] > gap(here):
            return ("move",) + best[1]
        return ("pass",)
