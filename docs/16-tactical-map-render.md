---
status: active
created: 2026-05-20
updated: 2026-06-17
---
# Chapter 16 — The Render Pipeline: How a Tactical Map Becomes Pixels

> Chapter 15 located the per-fief tactical map — a 55-byte cell array addressed by `$A57E + map_id×55` — but couldn't decode what those bytes *meant*. This chapter reconstructs the entire render pipeline end-to-end, from a 1-MB filtered Mesen trace, the bytecode, and a paused-game SRAM dump from Mino (fief 9): from the cell-byte in ROM, through the SRAM staging buffer at **`$7B4E`**, through the **terrain dictionary at `$B11E`**, to the per-row PPU writes that paint the screen. The core finding is the **cell byte itself**: a **one-hot terrain code** (`& $FE`, a single set bit → terrain type 0–5: castle / forest / town / mountain / clear / river), read by three independent consumers — graphics (`$B11E + type×16`), combat (`$B9C2` multiplier), and movement-blocking (the `$C2` mask). The chapter also surfaces the **isometric stagger** baked into the buffer (odd columns offset +8 bytes). The whole mapping is verified against six independent landmarks in Mino, so the 55-byte array is now translatable into a rendered map — the doughnut-fief, the chokepoint terrain, the diagonal mountain ridges, all locatable as concrete bits in concrete bytes.

**Links:** [Chapter 15 — The Tactical Map](./15-tactical-map.md) · [Chapter 4 — Syscall API](./04-syscall-api.md) · [Chapter 6 — VM Disassembler](./06-vm-disassembler.md) · [Nobunaga README](./README.md)

## The pipeline, in one diagram

```
   ROM bank 4 cell pool                               SRAM ($6000-$7FFF)
   ───────────                                        ──────────────────
   $A57E + map_id×55  ──[1]──→  cell-byte (1 B, one-hot terrain bitmask)
                                       │
                                       │ & $FE → which bit (32/16/8/128/4/64)?
                                       │ ──→ terrain type 0-5
                                       │         │
                                       │         ├──[combat]→ $B9C2 mult, ch.17
                                       │         └──[block ]→ $C2 mask scan ($9019), pathfinding
                                       ▼
   $B11E + type×16   ──[2]──→  terrain_attr_table (16 B/type, 6 types)
                                       │
                                       ▼
                                $7B4E + col×88 + stagger    SRAM staging buffer
                                       │                     (11 cols × 88 B = 968 B,
                                       │                      odd cols +8 byte stagger)
                                       ▼
                                  ──[3]──→  via $CBBD → syscall_dispatch
                                       │
                                       ▼
                                 $C4E0  syscall_ppu_render_rect (native)
                                       │
                                       ▼
                                 $C480  PPU row uploader (native)
                                       │
                                       ▼
                                 PPU $2000+   visible nametable
                                              + unit overlay (5-byte unit records at $6FD0)
```

Each numbered arrow corresponds to one of the sections below.

## [1] The cell-byte is a one-hot terrain bitmask

Each cell byte is **not** a packed two-field word; it is a **one-hot terrain code**. Exactly one of six bits names the terrain, and bit 0 is a low flag stripped before the decode. The canonical decode is `lookup_terrain_attr_record $83C6` (bytecode-decompiled):

```c
word lookup_terrain_attr_record(col, row) {
    type = 5;
    switch (read_map_cell(col, row) & 254) {   // & $FE — drop bit 0
        case 32:  type--;   // fall-through
        case 16:  type--;
        case 8:   type--;
        case 128: type--;
        case 4:   type--; break;
        case 64:  default: break;
    }
    return terrain_attr_table + type*16;        // $B11E + type×16
}
```

The `switch` matches `cell & $FE` against a **single** power-of-two value, so each terrain cell carries exactly one terrain bit. The fall-through assigns the type:

| `cell & $FE` | type | terrain | combat (§ ch.17) | attr tiles |
|---|:---:|---|---|---|
| `$20` (32) | 0 | **castle** | +270% | `$63-72` |
| `$10` (16) | 1 | **forest** | +60% | `$A2-B1` |
| `$08` (8) | 2 | **town** | +30% | `$73-81` |
| `$80` (128) | 3 | mountain (blocks, bit 7) | 0 | `$92-A1` |
| `$04` (4) | 4 | **clear** | 0 | `$82-91` |
| `$40` (64) or none | 5 | river / sea (blocks, bit 6) | 0 | `$57-66` |

(Types 0–2 are certified by the combat multiplier and ch.17; types 3–5 are read from the attribute-record tile clusters and the Mino landmark map below.)

This refutes the earlier "low 5 bits = a 0–31 metatile index" reading: a multi-bit value would fall straight to `default` (type 5), so the low bits cannot be an index — they are mutually-exclusive terrain flags. The terrain dictionary it indexes therefore has **6 entries, not 32** (section [2]).

The **same byte** is read by three independent consumers, each masking differently — which is what made it look like "packed fields":

- **graphics** — `lookup_terrain_attr_record` above (`& $FE`, 6 types) → the tile block to draw.
- **combat** — `ai_terrain_strength_term $9BB4` (`& $FE`, collapsed to 4 classes: 32→0, 16→1, 8→2, else→3) → `terrain_strength_mult_table $B9C2 = [90,20,10,0]` → the defensive bonus (ch.17).
- **movement-blocking** — `is_map_cell_blocked $9019` tests the mask **`$C2`** (bits 7,6,1): a cell with bit 7 (mountain/wall), bit 6, or bit 1 (water/border) blocks a unit's path. `$A221`'s BFS uses the same `$C2` mask to mark impassable cells. This is the real role of the `$C2` scan — pathfinding, not a "feature-flag half of the byte."

## [2] The terrain dictionary — `terrain_attr_table $B11E`, 6 records of 16 bytes

`lookup_terrain_attr_record` returns `$B11E + type×16`, so the dictionary is **six 16-byte records** at `$B11E-$B17D`, indexed by terrain type 0–5 — not a 32-entry table indexed by a low-5-bit field. Each record is a **4×4 NES-tile metatile** (four rows of four tiles) drawn for that terrain, in the per-fief CHR range `$57-$B3` the combat-init bulk-uploads from ROM `$A05E+`:

| type | Address | First 8 tiles | terrain |
|:---:|---|---|---|
| 0 | `$B11E` | `63 64 67 68 65 66 69 6A` | castle |
| 1 | `$B12E` | `A2 A3 A6 A7 A4 A5 A8 A9` | forest |
| 2 | `$B13E` | `73 74 77 78 75 76 79 7A` | town |
| 3 | `$B14E` | `92 93 96 97 94 95 98 99` | mountain |
| 4 | `$B15E` | `82 83 86 87 84 85 88 89` | clear |
| 5 | `$B16E` | `57 58 5B 5C 59 5A 5D 59` | river / sea |

The earlier reading of this region as a `$B100-$B17D` "metatile dictionary" placed the table start **30 bytes too early and mis-indexed it**. The bytes at `$B100` and `$B110` (`12 13 17 19 18 1A …` = decimal 18–27) are not tile graphics — they are the tail of **`strategic_map_fief_y $B0EC`**, the 50-byte per-fief strategic-map Y-coordinate table (Y values run 3–31), which ends exactly at `$B11E` (`$B0EC + 50`). Two adjacent but unrelated tables; the real terrain records begin at `$B11E`. (The "32 possible metatiles" never existed — there are six terrains.)

After the records, `$B17E-$B195` holds **attribute (palette) data** — one quad per terrain — and a **pointer table at `$B196+`** with little-endian addresses into `$B1D8-$B4C8` (still open, item 1 below).

The hot subroutine `$CBBD` shows up *27 times* across the codebase. That's because it's the **VM→syscall bridge** — not the renderer itself, just a thin wrapper that marshals VM arguments into the syscall parameter block at `$0050-$0065` and invokes `syscall_dispatch` ($F226). The underlying syscall is `$C4E0 = syscall_ppu_render_rect`, labeled by chapter 4's syscall sweep as the **"2D nametable region renderer ... used for menu borders, status panels, *map sections*."**

## [3] The SRAM staging buffer at `$7B4E`: 11 × 88 = 968 bytes, with isometric stagger

The combat trace showed every per-cell render reading 16 bytes from SRAM. The paused Mino dump confirms the buffer location and structure:

**Address formula** (verified against a paused dump from Mino):

```
cell_addr = $7B4E + col × 88 + (col & 1) × 8 + row × 16
```

Where:
- `col` ∈ [0, 10] = column index across the full 11-wide fief
- `row` ∈ [0, 4] = row within the column
- `(col & 1) × 8` = **the isometric stagger** — odd columns are shifted 8 bytes (= 2 NES tile rows = half a cell vertically)

**Column layout** (even col vs odd col):

```
Even col (0, 2, 4, 6, 8, 10):      Odd col (1, 3, 5, 7, 9):
  +0  ..+15   cell at (col, 0)       +0  ..+7   trailer of previous col / blank
  +16 ..+31   cell at (col, 1)       +8  ..+23  cell at (col, 0)
  +32 ..+47   cell at (col, 2)       +24 ..+39  cell at (col, 1)
  +48 ..+63   cell at (col, 3)       +40 ..+55  cell at (col, 2)
  +64 ..+79   cell at (col, 4)       +56 ..+71  cell at (col, 3)
  +80 ..+87   8-byte blank trailer   +72 ..+87  cell at (col, 4)
```

The 8 "trailer" bytes are always `01 01 01 01 01 01 01 01` — those are the *missing half-cell* at the column extremes caused by the stagger. In an isometric brick layout, the very top of even columns and the very bottom of odd columns (or vice versa) reach above/below the playfield; those positions get filled with blanks.

11 × 88 = 968 bytes total, spanning **`$7B4E-$7F15`** in SRAM.

### The bytecode address calculator

Bank-2 `$8865-$8878` computes the address. One detail is still unreconciled: the base literal in the bytecode reads `$7BFD`, but the live buffer (verified against the Mino dump) starts at `$7B4E`, 175 bytes earlier — most likely a frame-local offset folded into the multi-step compute (the `+88 mul` and `+88 col` interactions). The 88-byte stride and the column-major structure are confirmed either way.

### Viewport sections (mechanism known, variable not yet identified)

Chris's in-game observation of three overlapping 5×5 viewport sections is real — the visible-window logic page-flips between cols 0-4, 3-7, and 6-10. The variable that drives this *isn't* `$6FFE` (which holds `$2400` in the paused state — too large to be a 0/1/2 section selector); it's likely a different SRAM byte set by the scroll-input handler. Which one is open.

## [4] The render syscall ($C4E0) and what the VM hands it

The bytecode in bank 2 (around `$8800-$88FF`) pushes arguments — start (x,y), end (x,y), source pointer, per-tile parameter — onto the VM data stack, then `host_call`s a sub that ultimately reaches `$CBBD`. `$CBBD` itself is a tiny 11-instruction wrapper that copies the args into the syscall parameter block and invokes `$F226` (syscall_dispatch):

```
$CBBD-$CBC5  storeA/storeB to frame +$3C..$3F  ; marshal args
$CBC8        host_call $F226 (syscall_dispatch)
$CBCC        vm_return
```

`syscall_dispatch` then routes to the syscall handler via the dispatch table at `$C173`. For map rendering, the target is `$C4E0 = syscall_ppu_render_rect`, which:

1. Reads start (x,y) and end (x,y) from struct slots 6/8/10/12
2. Loops over every (x,y) in the rectangle
3. For each cell, calls helpers `$C640` (compute PPU address), `$C673` (compute attribute), `$C711` (write byte)
4. The write helper drives the per-row PPU uploader at `$C480` (chapter's title-screen walk)

The end result is what the trace recorded: 4-byte row uploads to PPU `$2080+`, source `$7B4E+` (the staging buffer), 220 calls per full map paint (55 cells × 4 rows/cell).

## [5] The pathfinding buffer and the unit overlay (architecture confirmed)

`$A221`'s `$C2`-mask scan really does write feature flags to a separate buffer — but **that buffer isn't at `$7BE8`** (the paused Mino dump shows `$7BE8` is inside the staging buffer at col 2 cell 4). The reachability buffer must live at a different SRAM address; finding it requires either disassembling further into `$A221` to extract the actual destination pointer, or tracing the writes during a unit-move event. Either is an appendix task.

**The architectural separation is now clean**, validated by the Mino paused dump:

- **Terrain layer** — SRAM `$7B4E + col×88 + stagger`. 968 bytes. Pure metatile patterns. Never modified during a battle except for rare terrain-change events (rivers crossed, bridges destroyed, walls breached). Every cell in the Mino dump decoded as a clean metatile from the dictionary — no unit bytes mixed in.
- **Unit layer** — SRAM `$6FD0+`, 5 bytes per slot, 10 slots = 50 bytes per side. Holds position, type, current HP. Modified after every unit action.
- **Render-time composition** — the renderer (`$C480` via `$C4E0 = syscall_ppu_render_rect`) reads the terrain from `$7B4E+`, then stamps unit graphics from the unit records over specific cells. The composite is what reaches the PPU nametable.

### Unit overlay format (decoded from the live tilemap viewer)

Each unit renders as **8 NES tiles arranged 4 wide × 2 tall** — exactly the *bottom half* of a 4×4 metatile cell. Units always occupy the lower half of their cell, so the top half always shows the underlying terrain. **One unit per cell maximum** — units do not stack:

```
Cell layout (4×4 NES tiles, top to bottom):

  Row 0:  terrain  terrain  terrain  terrain    ← top half of metatile (always visible)
  Row 1:  terrain  terrain  terrain  terrain

  Row 2:  [unit #] [flag 0] [flag 1] [flag 2]   ← bottom half: unit overlay if present
  Row 3:  [blank]  [blank]  [tens]   [ones]        else terrain (rows 2-3 of metatile)
```

The two blanks in the bottom row likely reserve slots for thousands and hundreds digits when a unit's strength exceeds 99 — the engine internally tracks strength in real soldiers (with the /30 displayed-strength multiplier from chapter 14), so 100+ counts are reachable.

This "terrain on top, unit on bottom" composition means the player can always see what terrain a unit is standing on — useful for reading the strategic situation at a glance. It also halves the visual real estate the unit takes, keeping the map dense.

**Tile assignments** (confirmed against the running game):

| Tiles | Role | CHR region |
|---|---|---|
| `$08 – $11` | digits 0-9 | fixed CHR (never re-uploaded) |
| `$51 – $53` | attacker flag (3-tile glyph) | fixed CHR |
| `$54 – $56` | defender flag (3-tile glyph) | fixed CHR |
| `$57 – $B1` | per-fief terrain metatiles | per-fief CHR upload from ROM `$A05E+` |
| `$B2` | attacker leader marker | per-fief CHR (top of range) |
| `$B3` | defender leader marker | per-fief CHR |

This explains the **per-fief CHR upload range** more precisely: it's tiles `$57-$B3` (= 93 tiles, not the rough ~115 estimate from earlier). Below `$57` is the **fixed bank** (digits, characters, both flags, blank, HUD). Above `$B3` is also fixed (characters and remaining UI).

### Mapping the trace's non-metatile clusters

The non-metatile byte clusters that appeared in the rendered nametable in the combat trace decode cleanly as unit overlays:

- `0D 51 52 53` = unit "5" (digit `$0D` = `5` in the digit range starting at `$08`) wearing the **attacker flag**
- `0D 54 55 56` = unit "5" wearing the **defender flag**
- `B2 xx xx xx` (with leader marker) = attacker leader's cell
- `B3 xx xx xx` = defender leader's cell

Every unit-rendered cell is identifiable from the nametable bytes alone — no separate unit-overlay table read is needed to find them. That's a useful invariant: **you can scan a rendered nametable for `$51`/`$54`/`$B2`/`$B3` to locate every unit position**.

### Why the combat trace had 544 row uploads

That's exactly **2-3 full scene repaints** (55 cells × 4 row-uploads/cell = 220 calls per paint). The initial paint + per-day repaints as units moved on the board.

## Putting it all together: a worked example (validated against Mino)

A paused-state SRAM dump from Mino (fief 9, 1-based = index 8, 0-based) was decoded against this model. Every cell in the 11×5 grid resolved cleanly to a known terrain record from the `$B11E` table:

**Terrain dictionary** (cross-validated against Chris's hand-mapped Mino landmarks):

| type | Tile cluster | Terrain | Validation |
|:---:|---|---|---|
| 4 | `82-91` | clear | bottom-row clear lanes match Chris's description |
| 1 | `A2-B1` | forest | border cols (0-2 and 10) match Chris's edge-forest pattern |
| 3 | `92-A1` | mountain | (r2, c6) = mountain between fortress and town ✓; diagonal (0,8)→(3,3) ✓ |
| 2 | `73-81` | town | (r3, c6) = town ✓ |
| 0 | `63-72` | castle | (r1, c6) = castle ✓ (Chris's "fortress" position — castle in NA terminology) |

(Type 5 (`57-66`, river/sea) didn't appear in Mino — seen in coastal fiefs. The earlier table had two extra "border metatile" rows; those bytes were `strategic_map_fief_y`, not terrain — section [2].)

**Decoded Mino battle map** (5 rows × 11 cols, with isometric stagger):

```
       c0   c1   c2   c3   c4   c5   c6   c7   c8   c9   c10
  r0:  cler cler cler frst frst frst frst frst mtn  frst frst
  r1:  frst frst mtn  mtn  frst frst CSTL mtn  mtn  frst frst
  r2:  frst frst frst frst mtn  mtn  mtn  cler mtn  mtn  frst
  r3:  frst frst frst mtn  mtn  cler TOWN cler cler cler frst
  r4:  frst frst frst cler cler cler cler cler cler cler frst
```

Six independent landmarks line up: fortress/castle at (c6, r1), town at (c6, r3), mountain barrier between them at (c6, r2), diagonal mountain ridge from (c8, r0) to (c3, r3), additional mountain band from (c2, r1) to (c4, r2), and clear forest borders on cols 0-2 and 10. **That's full validation of the staging buffer model AND the terrain-type mapping AND the column/row indexing.**

The 55-byte map array at `$A57E + map_id×55` (keyed through `province_to_mapid_table $F70E`, so fiefs can share a map — ch.15) is no longer opaque. It lives in **bank 4**, and the populator `map_populate $8903` reads it one metatile byte at a time. This is validated end-to-end: a blank SRAM seeded with only province=8 (Mino) + the scenario fief-count reproduces the Mino grid **byte-for-byte (1027/1027)** against the paused-state dump. With the terrain dictionary, *every tactical map can now be decoded* straight from bank 4.

## What's still open (appendix material)

The cell table (bank 4), the populator (`map_populate $8903`), and the cell-byte decode (one-hot terrain → `terrain_attr_table $B11E`, sections [1]/[2]) are all settled — closed by the byte-for-byte Mino reproduction and the `$83C6`/`$9BB4` bytecode. What remains:

1. **The pointer table at `$B196`** — 50-ish word pointers into `$B1D8-$B4C8`. Could be per-fief variant terrain dictionaries, unit graphic patterns, or attribute-override tables.

2. **The unit-overlay writer** — the code that stamps unit graphics on the rendered nametable. The terrain layer at `$7B4E+` is unit-free, so unit composition happens at render-time, not in the staging buffer.

3. **The actual viewport-section variable** — the three 5×5 page-views are real but `$6FFE` doesn't drive them. The actual section selector is at an unknown SRAM byte set by the scroll-input handler.

4. **The reachability buffer destination** — `$A221`'s `$C2`-mask scan writes flag bytes somewhere, but not to `$7BE8` (which is inside the terrain staging buffer). Where exactly the path-find scratchpad lives is open.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
