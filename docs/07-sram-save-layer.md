---
status: active
created: 2026-05-13
layout: default
title: "Chapter 7 \u2014 The SRAM Save Layer"
---
# Chapter 7 — The SRAM Save Layer

> The 8 KB battery-backed PRG-RAM at $6000-$7FFF holds the game's complete persistent state — every province, every daimyo, every name. This chapter decodes it field-by-field using live SRAM dumps from a 17-fief Tokugawa playthrough. We find: a 26-byte province record matching the ROM defaults exactly (with an LE/BE byte-swap during boot), a 7-byte daimyo record packing age + 5 attributes, parallel name tables indexed by clan and province ID, and a $7FXX "transient UI cache" region whose contents (like the frame counter at $7FE9) get rewritten every frame and are zeroed at boot.

**Links:** [Chapter 4 — Syscall API](./04-syscall-api.md) (SRAM I/O via syscalls $15/$16) · [Chapter 5 — Bytecode VM](./05-bytecode-vm.md) · [Chapter 6 — VM Disassembler](./06-vm-disassembler.md) · [Chapter 9 — Command System](./09-command-system-and-grow.md) · [Nobunaga README](./README.md)

## The save problem

Nobunaga's Ambition is a turn-based strategy game with 17 (or 50) provinces, ~17 active daimyo clans, and ten-plus attributes per fief — plus a player-specific layer (personal stats, current location, treasury). All of it must survive a power-off. The MMC1 SOROM board provides exactly this: 8 KB of battery-backed PRG-RAM mapped at $6000-$7FFF. The cartridge's iNES header declares battery support, which is why Mesen creates a `.sav` file automatically when the user invokes the game's in-game Save option.

Chapter 4 documented the **two SRAM syscalls** that mediate access:
- `syscall_set_chr_bank0_reg` ($15 → $C60C) — opens/closes the MMC1 WRAM-enable bit
- `syscall_sram_block_with_checksum` ($16 → $C5AA) — reads or writes a block via a staging buffer at $0200, computing a 16-bit checksum

These are exclusively invoked from VM bytecode (no native code calls them directly). The syscalls bracket every save operation with WRAM enable/disable to prevent stray writes from corrupting the save during normal gameplay.

This chapter decodes **what** the bytes actually mean.

## The SRAM memory map (17-fief scenario)

The SRAM is a set of **parallel index-keyed arrays**; naming each array's **base + stride** (not just guessing offsets) is what makes the code legible.

| Base | Array | Stride / size | Notes |
|---|---|---|---|
| **$6003** | `fief_history_table` | 17 × 8 bytes | Per-fief HIGH-WATER MARKS (output/dams/loyalty/wealth maxima) — income harvests off the *peak*, not current. |
| **$6D2D** | `fief_tax_rate` | 17 × 1 byte (flat) | Per-fief tax % (0-100); NOT in the 26-byte record. |
| **$6D5F** | `current_season` + config | 4-byte block | Season 0-3; `$6D63 = const_two` (Grow's √ subtrahend). |
| **$6E15** | `fief_to_daimyo_map` | 17 × 1 byte | **The explicit owner array**: position i = owner-daimyo of fief i+1. Starts identity; changes on conquest. |
| **$7001** | `province_table_live` | 17 × 26 bytes | The live province records (see below). Record N at `$7001 + N*26`. |
| **$7515** | `zealot_uprising_slot` | 26 bytes (idx 50) | Ikko-Ikki uprising force in province-record format (header=9999 = `0F 27` marks it). |
| **$752F** | `daimyo_table_17` | 17 × 7 bytes | Daimyo records (see below). |
| **$77A8** | `daimyo_name_table` | 17 × 9 bytes | 8 chars + null pad, parallel-indexed to the records. |
| (after names) | province name table | 17 × 9 bytes | Province names, same scheme. |
| **$7C00-$7E2D** | strategic-map tile data | 558 bytes | Background tile indices for the overworld. |
| **$7F00-$7FFF** | **transient UI cache** | — | Frame counter `$7FE9`, status flags; zeroed at boot (`$7FE7/$7FC7/$7FD3/$7FD1`). Rebuilt from canonical state each boot — not part of the save proper. |

The boundary between "canonical game state" and "UI cache" runs at ~$7C00.

## The province record (26 bytes) — `province_table_live $7001`

Each fief is a 26-byte record at `$7001 + idx*26`, **little-endian** 16-bit fields (the VM's `loadA_ind_word` reads low byte first). Confirmed layout (= the decompiler's `PROV_FIELDS`):

| +0 | +2 | +4 | +6 | +8 | +10 | +12 | +14 | +16 | +18 | +20 | +22 | +24 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| gold | debt | town | rice | output | dams | loyalty | wealth | men | morale | skill | arms | **header** |

`header` (+24, **last**) = base koku / development ceiling. The province-access idiom `idx*26 + $7001` appears 81× across the ROM; `selected_province_idx $6F5F` holds the index.

Each fief has its own gold at +0; `wealth` (+14) is the separate economic-capacity stat. There is no "footer" — the last field is `header`.

The header is **dynamic** (a fief's koku grows with development), and `index 0 = Hatakeyama/Noto` starts at header 0 (the weakest fief) — the generic-engine pattern: one 50-province world, scenario-windowed to the 17 active fiefs; `$7515` (idx 50) is the uprising slot.

## The ROM defaults table (the scenario template)

The same 26-byte province format exists **twice in PRG-ROM** — once per scenario:

- **17-fief scenario** at bank 3, CPU `$9258`
- **50-fief scenario** at bank 3, CPU `$B0BE`

Mikawa's defaults at `$9258` (17-fief):

```
$9258   20 03            $0320 = 800       header (different from runtime 1794 — likely
                                              modified on game start based on scenario parameters)
$925A   45 00            gold = 69         (the LE encoding stores low byte first)
$925C   00 00            debt = 0
$925E   42 00            town = 66
$9260   4B 00            rice = 75
$9262   50 00            output = 80
$9264   50 00            dams = 80
$9266   4C 00            loyalty = 76
$9268   4D 00            wealth = 77
$926A   47 00            men = 71
$926C   4B 00            morale = 75
$926E   4A 00            skill = 74
$9270   49 00            arms = 73
$9272   E8 03            $03E8 = 1000      next record's header
```

All 12 starting stats match user-reported turn-1 values **exactly in display order**. The ROM defaults exist as a separate template (`$9258` for 17-fief, `$B0BE` for 50-fief), and the boot bytecode initializes SRAM by copying from this template.

Both the ROM template and the live record store 16-bit values **little-endian**; they differ only in **field order** — the ROM scenario-defaults template is header-first (`gold` at field 1), while the live record is gold-first (`header` at +24). Boot init copies ROM → live, reordering the fields. The template is a static "starting condition" snapshot, not a structural mirror of the live record. (The "two representations of one logical record" pattern — see CONTEXT.md.)

## The daimyo record (7 bytes)

**17-fief table at $752F-$75A6**, 17 records × 7 bytes each.

The user's Tokugawa character: age=18, H=97, D=94, L=69, Ch=82, IQ=84.

```
$7560:  12 61 5E 3A 52 54 00
         ↑   ↑  ↑  ↑  ↑  ↑  ↑
         |   H  D  L  Ch IQ status
         age = $12 = 18  ✓
         H   = $61 = 97  ✓
         D   = $5E = 94  ✓
         L   = $3A = 58  (drifted from 69 during play — luck decreases over turns)
         Ch  = $52 = 82  ✓
         IQ  = $54 = 84  ✓
```

**Record layout (7 bytes):**

| Byte | Field | Range | Notes |
|---|---|---|---|
| 0 | **age** | $0B-$29 (11-41) | Sengoku-era ages; matches historical daimyo birth dates relative to 1560 scenario |
| 1 | **Health** | $39-$78 (57-120) | NPC clans can exceed 100; player capped at 99 |
| 2 | **Drive** | $29-$76 (41-118) | "Motivation" — affects AI behavior intensity |
| 3 | **Luck** | $1F-$72 (31-114) | Fluctuates between turns from random events |
| 4 | **Charisma** | $25-$72 (37-114) | Affects loyalty of subordinates and diplomacy |
| 5 | **IQ** | $46-$75 (70-117) | Affects strategy quality |
| 6 | **Status** | usually $00 | **Original-vs-generated flag**: 0 = original scenario daimyo, 1 = generated/replacement — set on succession by `assign_unique_daimyo_face_code $DB97`, read by `draw_daimyo_portrait` to pick a preset vs composite portrait. |

**Tokugawa is at index 7** in the 17-fief daimyo table (matching the name "Tokugawa" at $77E7 in the name table, also index 7). The two tables are parallel: `record[N] in $752F` and `name[N] in $77A8` describe the same clan.

### Cross-clan stat ranges (verified from this scenario)

| Clan | rec @ | age | H | D | L | Ch | IQ |
|---|---|---:|---:|---:|---:|---:|---:|
| Hatakeyama | $752F | 21 | 100 | 86 | 84/86 | 52/54 | 75 |
| Uesugi | $7536 | 30 | 87 | 111 | 92/94 | 118 | 115 |
| Hojo | $753D | 22 | 96 | 109/110 | ?? | ?? | ?? |
| Honganji | $7544 | 30 | 88 | 101 | 82 | 85 | 70 |
| Asakura | $754B | 27 | 78 | 108 | 105/111 | 91 | 106 |
| Anekoji | $7552 | 20 | 95 | 90 | 41/43 | 115 | 93 |
| Imagawa | $7559 | 41 | 57 | 118 | 28/24 | 93/94 | 96 |
| **Tokugawa** | **$7560** | **18** | **97** | **94** | **58-69** | **82** | **84** |
| Saito | $7567 | 28 | 53 | 55 | 37 | 51 | 61 (status flag $01) |
| Tsutsui | $756E | 11 | 91 | 57/59 | ~92 | 60 | 86 |

(Some fields drift between turns due to random events; ranges reflect what's observed in two saves.)

The historical accuracy is striking: Tokugawa Ieyasu (born 1542) = 18 years old in 1560; Uesugi Kenshin = 30; Imagawa Yoshimoto = 41 (he died at the Battle of Okehazama at 41 in 1560, the game's scenario start). The age field IS historical age in the year 1560, the scenario base year.

## How daimyo matches fief: the owner array

At game start the tables are **aligned by index** — `daimyo[N]` owns `province[N]`. But ownership is NOT purely positional: there is an **explicit owner array, `fief_to_daimyo_map $6E15`** (17 bytes, position i = owner-daimyo of fief i+1), initialized to the identity mapping and **rewritten on conquest** (e.g. when Tokugawa takes Owari, position 16 flips 16→7). A daimyo whose id no longer appears in the map has lost their home and becomes a "wandering" lord. So the index-alignment below is the *initial* state; the live owner is always `fief_to_daimyo_map`.

This was verified against history for all 17 of the 17-fief clans:

| idx | daimyo | province | historical check |
|---:|---|---|---|
| 0 | Hatakeyama | Noto | ✓ Hatakeyama held Noto — the weakest start (base koku 0) |
| 1 | Uesugi | Echigo | ✓ Uesugi Kenshin's domain |
| 2 | Hojo | Musashi | ✓ Hojo controlled the Kanto |
| 3 | Honganji | Kaga | ✓ the Ikko-ikki "peasant kingdom" |
| 4 | Asakura | Echizen | ✓ |
| 5 | Anekoji | Hida | ✓ |
| 6 | Imagawa | Suruga | ✓ Yoshimoto's base |
| 7 | Tokugawa | Mikawa | ✓ Ieyasu's home province |
| 8 | Saito | Mino | ✓ |
| 9 | Tsutsui | Yamato | ✓ |
| 10 | Asai | Omi | ✓ |
| 11 | Rokkaku | Iga | ✓ (Rokkaku held southern Omi adjacent to Iga) |
| 12 | Kitabatake | Iseshima | ✓ |
| 13 | Ashikaga | Yamashiro | ✓ the shogunate, in Kyoto |
| 14 | Miyoshi | Settsu | ✓ |
| 15 | Takeda | Shinano | ✓ Shingen's conquest |
| 16 | Oda | Owari | ✓ Nobunaga's home province |

17 of 17 correct. **There is no "special" leading record.** Every table — daimyo records, daimyo names, province records, province names — is dense from index 0; index 0 is simply the weakest clan, Hatakeyama, whose province (Noto) has a base koku header of 0. The table anchors are `$752F` (SRAM) / `$B532` (ROM) for the daimyo records. A `0F 27` (= 9999) sentinel sits immediately *before* the daimyo table as a boundary marker (not a record), so the table begins at `$B532` and Oda lands cleanly at index 16 — the 17th and final clan, exactly where an in-game start shows him.

The 50-fief scenario has the identical structure: 50 dense entries, index 0 = Kakizaki/Ezo (header 0), index 49 = Shimazu/Satsuma.

## The name tables (parallel-indexed by clan/fief ID)

Names are stored in fixed-length slots — **daimyo names in 9-byte slots, province names in 10-byte slots** (ASCII chars + null pad), one slot per clan/fief, indexed identically to the records they describe.

### Daimyo name table at $77A8 (17 entries)

```
$77A8: Hatakeyama (truncated to 8 chars)
$77B1: Uesugi
$77BA: Hojo
$77C3: Honganji
$77CC: Asakura
$77D5: Anekoji
$77DE: Imagawa
$77E7: Tokugawa     ← index 7 = player
$77F0: Saito        ← index 8
$77F9: Tsutsui
$7802: Asai
$780B: Rokkaku
$7814: Kitabatake
$781D: Ashikaga
$7826: Miyoshi
$782F: Takeda
$7838: Oda          ← Nobunaga's clan
```

### Province name table

17 historical Sengoku provinces, in 10-byte slots:
```
Noto, Echigo, Musashi, Kaga, Echizen, Hida, Suruga, Mikawa, Mino,
Yamato, Omi, Iga, Iseshima, Yamashir(o), Settsu, Shinano, Owari
```

Mikawa is **index 7** in the province name list — matching the "fief 8" display (1-indexed) and the province record at `$7001 + 7*26 = $70B7` (record table 0-indexed, naming list 0-indexed, UI 1-indexed; the standard off-by-one).

## The "transient UI cache" region ($7F00-$7FFF)

A handful of distinctive runtime-only behaviors confirmed:

- **$7FE9 — frame counter / animation tick.** The user observed this byte counting (incrementing) when the game was unpaused, stable when paused. Consistent with a 60Hz tick that drives sprite animations, cursor blinking, music timing, menu opening transitions, etc.
- **$7FE7, $7FC7, $7FD3, $7FD1 — status flags.** Boot bytecode explicitly zeroes all four on game start (chapter 6 finding). Likely include "paused," "in-menu," "in-combat," "music-driver-active."
- **$7FCD-$7FEA range — frequent read/write traffic during play** (observed in Mesen). The whole upper-trailer region is per-frame transient state.
- **Boot bytecode zeroes this region**, so save-and-restore doesn't preserve UI position — only canonical state survives a power cycle. The game rebuilds the UI cache from the canonical tables on every game start.

This is good design: the **save layer** is just the canonical state; the **runtime layer** lives in this transient region and is rebuilt as needed. It keeps the save file small (8 KB suffices for a complex strategy game) and makes save migration robust.

## Where each layer's state lives

This chapter rounds out the project's structural picture. Each kernel/runtime layer documented in chapters 1-6 has a corresponding place in the save:

| Chapter | Layer | SRAM region |
|---|---|---|
| 1, 4 | Kernel + syscalls | (none — kernel state is in $0050-$0065 + ZP scratch, not SRAM) |
| 3 | Music driver | $0700-$0760 (in main RAM, not SRAM) |
| 5, 6 | VM | (none — the VM frame is on the active stack at `vm_sp`, not in SRAM) |
| **7** | **Game state** | **$6000-$7BFF (canonical), $7F00-$7FFF (transient)** |

The save's job is to capture **game state** — what makes one game-in-progress different from another. The VM bytecode and the kernel are constants in PRG-ROM; they don't need saving.

## Open

- **Secondary record table at `$61D4-$629F`** — 17 more 26-byte records with much higher headers (`$0B00-$0B23`). Probably per-fief military / production capacity / NPC posture (each daimyo's "current army"), separate from the per-fief infrastructure stats; reconcile against the high-water-mark `fief_history_table $6003`.
- **Market prices** (rate 1.0, rice 1.4, arms 2.8, men 3.0, ninja 1.9) — they fluctuate, so they live in SRAM, likely in the `$6Dxx`/`$6Fxx` dense regions; not yet pinned.
- **The save checksum.** `syscall_sram_block_with_checksum` (ch.4) computes a 16-bit checksum — where is it stored? Likely a fixed trailer offset (e.g. near `$7FFC`).
- **Map data at `$7C00-$7E2D`** — 558 bytes of tile indices, likely an 18×31 strategic-map grid.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [save-format](../../../tags/save-format.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
