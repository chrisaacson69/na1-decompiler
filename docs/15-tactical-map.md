---
status: active
created: 2026-05-14
updated: 2026-06-17
layout: default
title: "Chapter 15 \u2014 The Tactical Map: Where the Battle Lives"
---
# Chapter 15 — The Tactical Map: Where the Battle Lives

> Combat runs in its own bank — **bank 2** — where the region `$8200–$83C6` holds a clean **modular combat engine**: a cluster of small bytecode subs, each doing one job. The per-fief tactical map is reached through a single address formula in `$DC88` (bank 15): it looks the fief up in a province→map-id table, multiplies the map id by 55, and adds the base `$A57E`. So **each tactical map is 55 bytes (11 × 5 cells), and several fiefs can share one map.** The cell bytes — and the terrain they encode — are decoded in chapter 16; this chapter locates the engine, the unit-data table, and the map-address formula. Chris's defensive archetypes — the doughnut-fief, the chokepoint fiefs — live as these 55-byte records.

**Links:** [Chapter 14 — Combat Overview](./14-combat-overview.md) · [Chapter 16 — The Render Pipeline](./16-tactical-map-render.md) · [Chapter 6 — VM Disassembler](./06-vm-disassembler.md) · [Nobunaga README](./README.md)

## The bank-2 combat engine

The combat engine is a set of bytecode subroutines in bank 2, reached after the war driver (bank 0) switches that bank in. Bank 2's combat region is a clean cluster of `20 23 E8` bytecode stubs:

| Sub | Frame | Role (best read so far) |
|---|---|---|
| `$822A` | −2 | combat-screen entry / main orchestration |
| `$8270, $827E` | 0 | small helpers |
| **`$828B`** | 0 | **unit-address calculator (`addr = $6FD0 + idx × 5`)** |
| `$829A` | 0 | sibling calculator (base `$6FDA`) |
| `$82A9, $82B9, $82C9` | 0 | further address-arithmetic helpers |
| **`$82DB`** | 0 | **cell-coord bounds check (x ≤ 10, y ≤ 4) → calls cell reader** |
| `$82FF, $830B, $836A` | 0/−8/−4 | mid-tier handlers |
| `$838F, $83A2, $83C6` | 0/0/−2 | more helpers |

Most of these are frame-offset 0 — meaning they take their inputs entirely through positive frame slots (arguments pushed by the caller) and use no own locals. That's the signature of a small, function-style helper, which is exactly what a combat engine wants: cheap, composable primitives.

## Unit data — SRAM `$6FD0`, 5 bytes per slot

`$828B`'s entire body is eight bytecode instructions:

```
$8291 setB 5             ; regB = 5
$8292 mul                ; regA = idx * 5
$8293 loadB_local +0x0D  ; regB = an offset argument
$8294 add                ; regA = idx*5 + offset
$8295 loadB $6FD0        ; regB = $6FD0 (the table base)
$8298 add                ; regA = idx*5 + offset + $6FD0
$8299 vm_return
```

`$828B` is a **pure address calculator** for **a 5-byte-per-record table at SRAM `$6FD0`**. Five bytes per slot, five slots per side: the army's per-unit data fits in 25 bytes on each side, 50 total. The 5-byte record presumably holds *current men count, unit type (0–2: Rifles/Infntry/Cavalry), position (x,y on the 11×5 grid), and one flag/morale byte*. Per the chapter-14 unit model: slot 0 is the commander and slots 1–4 are the four composed type units.

`$829A` is the same calculator with base `$6FDA` (= `$6FD0 + 10`). Two interpretations:

- The two bases address **opposite-side unit tables** (attacker vs defender) at the same stride. If each side's table is 25 bytes (5 slots × 5 bytes), the second base would be `$6FE5`, not `$6FDA`. So this reading needs adjustment.
- More likely: **each unit has two record halves** at offsets 0 and +10, accessed independently. `$828B` reads/writes the "primary" 5 bytes; `$829A` reads/writes the "secondary" 5 bytes. With 10 bytes per unit × 5 slots × 2 sides = 100 bytes, the layout fits the surrounding SRAM cleanly.

Either way, the **base is `$6FD0` and the per-slot stride is 5** — that's locked.

## The tactical-map address — `$DC88`, 55 bytes per map

The cell reader's wrapper `$82DB` opens with two bounds checks:

```
setB 10   cmp_ugt   branch_nz exit   ; bail if x > 10
loadA_local +0x0D   setB 4   cmp_ugt   branch_z proceed   ; bail unless y > 4 fails
... clearA; vm_return                ; bail path
... proceed: host_call $DC88(x, y)
```

Valid input: **x ∈ {0..10}, y ∈ {0..4}** — **11 columns × 5 rows = 55 cells**, the entire battle map per fief.

`$DC88` (bank 15) computes the address of any cell in the current battle's map:

```
mapid     = fief_to_mapid(battle_defending_province)   ; $DC66
cell_addr = $A57E + mapid × 55 + cell_offset
read through $CBBD                                      ; the syscall-16 SRAM/bank wrapper
```

Two facts fall out of the bytecode:

- **Maps are keyed by a map-id, not the raw fief index.** `fief_to_mapid` (`$DC66`) returns `province_to_mapid_table[$F70E + fief]` (except in the 50-fief scenario, which uses the fief index directly). So several fiefs can resolve to the *same* 55-byte map, and the map a fief fights on is a table lookup, not its province number.
- **The stride is 55 = 11 × 5** — one whole battle map per entry, matching `$82DB`'s bounds.

The base literal is `$A57E`, but **bank-2 CPU `$A57E` is not the map table — it is combat-engine code.** Disassembled, those bytes are the unit-action routine (`PUSH_qimm 0 / PUSH_abs $7BE8 / CALL $82B9 …`). The map bytes live at CPU `$A57E` in **bank 4**, switched in by the read syscall. This is validated: a blank SRAM seeded with only the defending province and the scenario fief-count reproduces a fief's grid byte-for-byte against a paused-state dump (ch.16). The bulk reader is `map_populate $8903`, which walks `$A57E + map_id×55` one metatile byte at a time via `memcpy_banked`; `$DC88` is the single-cell form of the same address math.

## The cell bytes — decoded in chapter 16

An early reading dumped raw bytes at bank-2 `$A57E` and tried to read them as terrain codes — but those bytes are the engine's executable code, not map data (the "repeated `170 232 123`" pattern is `AA E8 7B` = `PUSH_abs $7BE8`). The real cell bytes, captured from a paused-state SRAM dump, are decoded in **chapter 16**: each cell byte is a **one-hot terrain code** — `& $FE`, then a single set bit (32/16/8/128/4/64) selects terrain type 0–5 (castle / forest / town / mountain / clear / river). The type drives a 16-byte graphics record in `terrain_attr_table $B11E` and, separately, the combat multiplier (ch.17); the `$C2` bits gate movement. Chapter 16 validates the whole mapping against six independent landmarks in Mino.

What matters for the strategy counter-graph the project is building: **the doughnut-fief and chokepoint-fief archetypes Chris described from the project's start exist as concrete 55-byte map records**, and with chapter 16's dictionary every fief's tactical map can be rendered and its asymmetric defensive advantages catalogued.

## Combat engine flow

The full structure, from war declaration to resolution:

```
   AI war path (bank 0) -- declares war
        |  bank-switch to bank 2
        v
   $822A (bank 2) combat-screen entry
        |
        v
   map setup: for each cell (x,y) in 11x5:
        $82DB (bounds check) -> $DC88 (read $A57E[mapid*55 + y*11 + x]) -> render
        |
        v
   day loop (per day):
        unit-action inner loop ($828B family on $6FD0 unit data)
            Attack = resolve_mutual $9E20 (DETERMINISTIC, ch.17); Bribe/AI = $9E73 (+RNG)
        end-of-day check: supplies, casualties, leader, retreat
        |
        v
   ending: print one of the four messages (ch 14) + resolution
```

`$828B`'s ~1 005 hits per battle are **unit-record address computations** — every time the engine reads or writes a unit's slot, it goes through this calculator. That's the price of encapsulating the table base in a single sub: one helper call per access, but only one place in the code to change if the table moves.

## What's open

- **The 5-byte unit record's field layout.** A targeted memory-watch of `$6FD0–$6FF3` across a single attack exchange would expose which byte stores the men count, type, position, and morale/flag.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
