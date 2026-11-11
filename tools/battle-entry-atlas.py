#!/usr/bin/env python3
"""The battle-entry atlas: for every fief and every side it can be invaded from, where the AI
attacker is allowed to deploy and where its commander and two guards land, rendered on the
fief's true-colour map (render-battle-setup.py).

Everything comes from the sim's transcriptions of the ROM, not from a re-derivation:
  entry strip     set_combat_arena_rect_by_approach $9675 (the strategic-map bearing)
  banned cells    commit_unit_dest_tile_if_valid $9792: blocked terrain ($C2), bit 8, the seat
                  and its 6 neighbours (tile_blocked_for_placement $9735)
  the landing     rng_search_combat_rect_for_unit_cell $9954, run once per coin outcome with the
                  two flips scripted; guards by ai_place_unit_in_free_slot_resolve_coords(3)

The defender is the AI's minimum: its commander alone on the seat (find_free_tactical_placement_cell
$9647). A human who places units near the scan corner pushes the landing along the scan.
When the scan finds nothing (always from the east: x = x_max - xi mirrors 7..10 to 3..0, outside
the strip) the commander and guards drop at random on the tinted cells, like slots 3-4 always do.

Usage:  py -3.14 tools/battle-entry-atlas.py [--out assets/maps/battles/entries] [--scale 2]
Writes one PNG per (fief, entry, coin outcome) plus atlas.json (the table the pictures show).
"""
import sys, json, random, argparse, importlib.util
from pathlib import Path

HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))
from na1sim import setup, loader, tactical as T, memmap as M
_spec = importlib.util.spec_from_file_location("render_battle_setup", HERE / "render-battle-setup.py")
rbs = importlib.util.module_from_spec(_spec); _spec.loader.exec_module(rbs)

EDGE = {1: "north", 2: "south", 3: "west", 4: "east"}


class Scripted:
    """m.rng stand-in: the first draws come from a script (the two coin flips), the rest at random."""
    def __init__(self, script, seed=0):
        self.script, self.r = list(script), random.Random(seed)

    def randrange(self, n):
        return self.script.pop(0) % n if self.script else self.r.randrange(n)


def reset(m, attacker, defender, n_def=1):
    m.selected, m.defending = attacker, defender
    T.clear_all_unit_positions(m)
    m.w8(M.WAR_SIDE_STATE_FLAG + 0, 0x1F)        # attacker: all five slots present, a general leads
    m.w8(M.WAR_SIDE_STATE_FLAG + 1, 0x80 | ((1 << n_def) - 1))   # defender: the first n_def slots, the daimyo leads
    for side in (0, 1):
        for slot in range(5):
            m.w16(m.unit_strength_ptr(side, slot), 20)


def placeable(m):
    """Strip cells the attacker may use, and strip cells it may not (commit_unit_dest_tile_if_valid
    without the occupancy test)."""
    x0, y0, x1, y1 = (m.r16(a) for a in (M.COMBAT_ARENA_X_MIN, M.COMBAT_ARENA_Y_MIN,
                                         M.COMBAT_ARENA_X_MAX, M.COMBAT_ARENA_Y_MAX))
    ok, bad = set(), set()
    for x in range(x0, x1 + 1):
        for y in range(y0, y1 + 1):
            (bad if (T.is_map_cell_blocked(m, x, y) or T.tile_blocked_for_placement(m, x, y)) else ok).add((x, y))
    return ok, bad


def deploy_case(m, attacker, defender, flips, defenders=()):
    """Defender commander on the seat (plus `defenders`, cells for slots 1.., placed as a human
    would), then the attacker's scan with scripted flips -> facts."""
    reset(m, attacker, defender, 1 + len(defenders))
    m.cur_combat_side = 1
    seat = T.find_free_tactical_placement_cell(m)
    for slot, (x, y) in enumerate([seat, *defenders]):
        m.w8(m.unit_col_ptr(1, slot), x); m.w8(m.unit_row_ptr(1, slot), y)
    m.cur_combat_side = 0
    edge = T.set_combat_arena_rect_by_approach(m)
    ok, bad = placeable(m)
    m.rng = Scripted(flips)
    m.cur_combat_unit_slot = 0
    T.rng_search_combat_rect_for_unit_cell(m, edge)
    placed = m.cur_combat_unit_slot                  # 0: the scan found nothing -> random drop
    cells = [(m.r8(m.unit_col_ptr(0, s)), m.r8(m.unit_row_ptr(0, s))) for s in range(placed)]
    # leave only what the scan placed on the board (slots 3-4, and a failed scan, drop at random)
    for s in range(placed, 5):
        m.w8(m.unit_col_ptr(0, s), 200); m.w8(m.unit_row_ptr(0, s), 200)
    rect = tuple(m.r16(a) for a in (M.COMBAT_ARENA_X_MIN, M.COMBAT_ARENA_Y_MIN, M.COMBAT_ARENA_X_MAX, M.COMBAT_ARENA_Y_MAX))
    return dict(edge=edge, rect=rect, seat=seat, placed=cells, ok=sorted(ok), bad=sorted(bad))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default=str(HERE.parent / "assets" / "maps" / "battles" / "entries"))
    ap.add_argument("--scale", type=int, default=2)
    a = ap.parse_args()
    out = Path(a.out); out.mkdir(parents=True, exist_ok=True)

    m = setup.build_board(seed=0, player_fief=None)
    provs = loader.load_provinces()
    adj = loader.load_adjacency()
    atlas = []
    for d in range(17):
        by_edge = {}
        for att in adj[d]:
            m.selected, m.defending, m.cur_combat_side = att, d, 0
            by_edge.setdefault(T.set_combat_arena_rect_by_approach(m), []).append(att)
        for edge, atts in sorted(by_edge.items()):
            outcomes = {}
            for fx in (0, 1):                        # the two draws: flip_x, then flip_y
                for fy in (0, 1):
                    c = deploy_case(m, atts[0], d, [fx, fy])
                    key = tuple(c["placed"])
                    if key not in outcomes:
                        outcomes[key] = (c, (fx, fy), 1)
                    else:
                        outcomes[key] = (outcomes[key][0], outcomes[key][1], outcomes[key][2] + 1)
            entry = dict(fief=d, name=provs[d].name, edge=EDGE[edge], attackers=[provs[x].name for x in atts],
                         outcomes=[])
            for i, (key, (c, flips, n)) in enumerate(outcomes.items()):
                fname = f"{d:02d}-{provs[d].name.lower()}-{EDGE[edge]}-{i}.png"
                deploy_case(m, atts[0], d, list(flips))                  # rebuild that board to draw it
                units = rbs.units_from(m.r8, m.r16)
                land = "random drop" if not c["placed"] else f"commander {c['placed'][0]}"
                title = f"{provs[d].name} from the {EDGE[edge]} ({', '.join(entry['attackers'])}): {land}, {n}/4"
                rbs.draw(d, units, rect=c["rect"], scale=a.scale, valid=set(c["ok"]), banned=set(c["bad"]),
                         title=title, out=str(out / fname))
                entry["outcomes"].append(dict(png=fname, chance=f"{n}/4", placed=c["placed"], seat=c["seat"],
                                              rect=c["rect"], open_cells=len(c["ok"]), banned_cells=len(c["bad"])))
            atlas.append(entry)
    (out / "atlas.json").write_text(json.dumps(atlas, indent=1), encoding="utf-8")
    print(f"{len(atlas)} fief entries -> {out}")


if __name__ == "__main__":
    main()
