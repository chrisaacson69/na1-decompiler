---
status: active
created: 2026-06-10
layout: default
title: "Chapter 20 \u2014 The Strategic Map Render: The Overworld in 28\u00d716 Tiles"
---
# Chapter 20 — The Strategic Map Render: The Overworld in 28×16 Tiles

> Chapter 16 took the tactical battlefield from cell-bytes to pixels. This is its overworld counterpart: how the **strategic map** — the illustrated province overview behind the Map command — gets drawn. The answer is small and clean once the code is named: the cartridge stores the map as **9 discrete 28×16-tile "sections"** (a pannable atlas, not a scrolling field), each a triple of {tilemap, attribute table, fief-record list}, and a single bytecode routine — `render_map_section` ($E5F2) — blits one section to the nametable on demand. None of it needs a PPU dump to reconstruct; it is all ROM, which `tools/render-strategic-map.py` already extracts. This chapter names the code path that the ROM-only tool inferred, and pins the data layout. (This is the *art* map — terrain tiles drawn by the cartridge — not the schematic adjacency graphs of `render-strategic-atlas.py`, and not the tactical battle grid of ch.16.)

**Links:** [Chapter 11 — Strategic Engine](./11-strategic-engine-complete.md) · [Chapter 16 — Tactical Map Render](./16-tactical-map-render.md) · [Chapter 18 — Window Updates](./18-window-updates.md) · [Chapter 19 — Bank 15 Map](./19-bank15-memory-map.md) · [README](./README.md)

## The render path

Entering the Map command (`driver_map $AF38`) drives three named primitives, all now grounded:

```
Map command
  └─ repaint_screen ($CD20)          clear screen + dirty-flag-gated palette & CHR upload (ch.18)
  └─ render_map_section(section)     blit one 28×16 section to the nametable        ← the keystone
       ↑ arrows pan: each press re-calls render_map_section with the next/prev section index
  └─ redraw_fief_on_map(fief)        refresh ONE fief in place (after an action), no full redraw
```

The pan is **section-switching, not scrolling**: there is no smooth scroll: an arrow press calls `render_map_section` with a different section index and the whole 28×16 window is re-blitted. `repaint_screen` (ch.18's full-screen clear + dirty-flag palette/CHR reload) runs once on entry; `render_map_section` runs per section change; `redraw_fief_on_map` runs for single-fief touch-ups.

## A "section" = three parallel arrays (bank 4)

| array | addr (bank 4) | stride | content |
|---|---|---|---|
| **tilemap** | `$8D5C` `strategic_map_section_tilemaps` | `0x1C0` (= 448 = 28×16) | one tile index per nametable cell |
| **attributes** | `$9D1C` `strategic_map_section_attributes` | `0x20` (32) | one BG sub-palette per 16×16 quad |
| **fief records** | `find_record_data_9e3c` | 34 | `(col, row, fief_id)` triples, `$FF`-terminated |

**9 sections** total. **The 17-fief scenario uses sections 0–1; the 50-fief scenario uses 0–8.** They are discrete pages, not a scrolling field — the section index *is* the "which part of Japan" selector.

## What `render_map_section(section)` does ($E5F2)

```c
if (section == selected_record_idx_9e3c) return;     // already showing it — no-op
palette_swap(1);                                      // swap to the working palette (ch. on palette_swap)
ppu_fill_rect_wrap(30, 4, 31, 19, 1);                 // blank the right margin (cols 30-31)
ppu_copy_rect_wrap(2, 4, 29, 19,                      // blit the 28×16 tilemap into cols 2-29 / rows 4-19
                   strategic_map_section_tilemaps + section*0x1C0, 4);
ppu_upload_block_wrap(4,                              // upload the 32-byte attribute table to $23C8
                   strategic_map_section_attributes + section*0x20, 0x23C8, 2);
selected_record_idx_9e3c = section;                   // mark this section current
for each (col,row,id) in this section's 34-byte record list:   // label every fief
    set cursor; draw_province_lord_name(id);
palette_swap(0);                                      // swap back
```

The blit is `ppu_copy_rect` (ch.18): a byte-stream copy of `width*height` tiles into an inclusive nametable rectangle. The geometry here — cols 2–29 × rows 4–19 = **28×16 = `0x1C0`** — is the exact match that *originally confirmed* `ppu_copy_rect`'s argument map (ch.18/19): the source stride and the rectangle area are the same number, so a "section" of tile data maps 1:1 onto the on-screen rectangle.

`redraw_fief_on_map(fief)` ($E554) is the inverse-grained operation: rather than re-blit the whole section, it scans the current section's record list for the matching `fief_id`, then `ppu_copy_rect`s just that fief's ~8-wide label tile-strip at its `(col,row)` and redraws its lord name — used to refresh a single province after a command without flicker.

## Tiles, CHR, and palette

- **Cell value semantics:** a tilemap byte `V` ≤ 80 is a **font glyph** (the fief-number labels, digits 0–9 overlaid on the map); `V` ≥ 81 is a **terrain tile**.
- **CHR:** the bank-4 map tileset is uploaded to pattern table 1 starting at tile `$5B` (= 91). Cell `V` indexes `CHR-RAM[$1000 + V*16]`; the uploaded block begins at bank-4 `$845C` for tile 91, so a terrain cell reads `$845C + (V-91)*16`.
- **Palette:** bank-15 `$F67A`, 4 colors per sub-palette (stored as words with a zero high byte). BG palette 0 ≈ `[$3E,$12,$29,$30]` — backdrop / sea / land / coast.

## ROM-only extraction

Because every input is ROM (tilemap + attributes + CHR + palette, no runtime state), the strategic map reconstructs with **no emulation**: `tools/render-strategic-map.py` renders any section straight from the cart using exactly the layout above (decoded 2026-06-02; this chapter names the code it inferred). That is the strategic-map analogue of ch.16's claim that tactical maps are fully ROM-extractable — both overworld and battlefield are recoverable from bytes alone.

## Strategic vs tactical render, side by side

| | **strategic** (this chapter) | **tactical** (ch.16) |
|---|---|---|
| unit of map | 9 fixed 28×16 sections (atlas pages) | one per-fief 55-byte cell array |
| storage | tilemap + attrs + records, all ROM | cell array → SRAM staging `$7B4E` |
| blit | `render_map_section` → `ppu_copy_rect` (whole rect) | the row uploader → per-row `ppu_render` |
| geometry | rectilinear 28×16 | isometric stagger (odd cols +8 B) |
| labels | fief numbers (font tiles) + lord names | unit overlays + strength digits |

The two share the same low-level vocabulary (ch.18: `ppu_copy_rect`/`ppu_fill_rect`, the palette/CHR uploads) over the same fixed-bank kernel (ch.19); they differ only in how the map *data* is shaped above that.

## Open items

- The fief-record `(col, row, id)` triples: confirm the exact coordinate frame (nametable tile vs section-relative) by cross-checking `redraw_fief_on_map`'s cursor math against a live section.
- The boundary between font-glyph cells (≤80) and terrain (≥81), and whether `--font` rendering in the tool changes any terrain reads.
- Whether the 50-fief sections 0–8 tile the whole archipelago contiguously or overlap at section seams.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [ppu](../../../tags/ppu.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
