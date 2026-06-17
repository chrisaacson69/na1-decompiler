---
status: active
created: 2026-05-11
layout: default
title: "Chapter 3 \u2014 The NMI Pipeline (PPU, OAM, Controllers, Audio)"
---
# Chapter 3 — The NMI Pipeline (PPU, OAM, Controllers, Audio)

> Every 1/60s the NMI handler runs five subsystems in a strict order, bracketed by NMI-disable/enable, with all PPU register access funneled through a shadow-state API. First chapter with runtime correlation: a 1-2 second Mesen trace (912k lines) confirmed the architecture and decoded the music driver completely.

**Links:** [Chapter 1 — Boot & Dispatch](./01-boot-and-dispatch.md) · [Chapter 2 — Zero-Page Map](./02-zero-page-map.md) · [Nobunaga README](./README.md) · [NES PPU reference](../../../research/nes/ppu-reference.md) · [NES APU reference](../../../research/nes/apu-reference.md)

## The frame

The NMI fires when the PPU enters VBlank (scanline 241, ~2273 cycles before rendering resumes). The CPU has ~2273 + ~6820 = ~9000 cycles of safe PPU access before the next frame's rendering begins to read VRAM. Everything that has to touch the PPU — OAM DMA, palette updates, scroll registers — happens inside this window.

Nobunaga's NMI uses exactly **5 of those ~9000 cycles' worth of routines** in a fixed order, plus a pair of bookend operations:

1. **Disable further NMIs** (`$C54F`)
2. **OAM DMA** (sprite shadow $0600 → PPU OAM)
3. **Controller poll** (P1 to $6E, P2 to $6F)
4. **Palette upload** (gated by $0074)
5. **Music driver tick** (two passes: trigger + sequencer)
6. **Wall-clock tick** (gated by $0089)
7. **Re-enable NMI** (`$C68A`)

The two gating flags `$00B0` and `$0089` let the engine selectively skip work — `$B0` skips everything after OAM, `$89` skips just the clock. Useful for menu transitions and pause states.

## How the audio engine was grounded

The music driver was decoded from a ~1–2 second Mesen trace (≈912k lines): filtering for accesses into the `$0734-$0760` voice-record region (`\[\$07[3-5][0-9A-F]\]`) surfaced the whole driver in ~50 lines, which pinned down the 9-byte record layout and the two-pass structure below.

## The NMI handler (`nmi_handler` $C0DA-$C138)

The five subsystems in fixed order, bracketed by `nmi_off`/`nmi_on`:

```asm
$C0DA: PHA / TXA/PHA / TYA/PHA           ; save A, X, Y
$C0DF: LDA PPUSTATUS                     ; clear the VBlank flag
$C0E2: JSR nmi_off                       ; bracket: disable NMI re-entry
$C0E5: LDA #$00 / STA OAMADDR
$C0EA: LDA #$06 / STA OAMDMA             ; OAM DMA: oam_shadow ($0600) → PPU OAM
$C0EF: LDA nmi_skip_all / BNE .done      ; $B0 set → bail after sprites
$C0F4: LDA #$00 / JSR controller_poll    ; P1 → p1_buttons ($6E)
$C0F9: LDA #$01 / JSR controller_poll    ; P2 → p2_buttons ($6F)
$C0FE: JSR palette_upload                ; if palette_dirty ($74): ship palette_shadow → PPU $3F00
$C101: JSR music_driver                  ; two passes: trigger + sequencer
$C104: LDA skip_wallclock / BNE .clk     ; $89 set → freeze game-time
$C109: clock_a += 2 ; clock_b += 2       ; the two wall-clocks (16-bit, +2/frame)
.clk:  LDA #$00 / STA nmi_busy           ; release the VBlank handshake
$C12E: JSR nmi_on                        ; bracket: re-enable NMI
$C133: PLA/TAY / PLA/TAX / PLA / RTI     ; .done lands here
```

## The PPU register-shadow API

The PPU control register ($2000 / PPUCTRL) and mask register ($2001 / PPUMASK) are **write-only** on the NES. Any RMW operation — "toggle bit 7 of PPUCTRL," "clear the rendering-enable bits of PPUMASK" — requires the CPU to keep its own shadow copy. Nobunaga puts those shadows in ZP and wraps every register access in a tiny helper API:

| ZP | PPU register | Role |
|---|---|---|
| `$0071` | $2000 PPUCTRL shadow | NMI enable, nametable base, PPUDATA increment, sprite-pattern base |
| `$0072` | $2001 PPUMASK shadow | Greyscale, BG/sprite enable, BG/sprite leftmost-8-pixels, color emphasis |

Seven routines manage them:

| Routine | Function | Code |
|---|---|---|
| `write_ppuctrl` ($C6A6) | write A → PPUCTRL + shadow | `sta $2000 ; sta ppuctrl_shadow` |
| `write_ppumask` ($C570) | write A → PPUMASK + shadow | `sta $2001 ; sta ppumask_shadow` |
| `nmi_off` ($C54F) | clear bit 7 of `ppuctrl_shadow` | `lda ppuctrl_shadow ; and #$7F ; jsr write_ppuctrl` |
| `nmi_on` ($C68A) | set bit 7 of `ppuctrl_shadow` | `lda ppuctrl_shadow ; ora #$80 ; jsr write_ppuctrl` |
| `rendering_on` ($C567) | set bits 3,4 of `ppumask_shadow` | `lda ppumask_shadow ; ora #$18 ; jsr write_ppumask` |
| `rendering_off` ($C69D) | clear bits 3,4 of `ppumask_shadow` | `lda ppumask_shadow ; and #$E7 ; jsr write_ppumask` |
| `ppu_safe_gate` ($C693) | the long-PPU-update preamble | `jsr nmi_off ; jsr wait_vblank ; jsr rendering_off` |

The composite `$C693` is the canonical "I'm about to do a long PPU update from foreground code" preamble:

1. Disable NMI so it doesn't reentrant-fire mid-update.
2. Wait for VBlank (`$C537`) so the PPU is in a writable state.
3. Disable rendering so reads through PPUDATA don't drift.

That's the standard NES pattern (see [NES PPU reference](../../../research/nes/ppu-reference.md) — VBlank window discipline), here factored into named routines instead of inlined everywhere. **The codebase never reads $2000 or $2001 directly.** Discipline is strict and project-wide.

### `wait_vblank` ($C537) — and the audio-during-spin trick

```asm
wait_vblank:  lda skip_vblank_wait     ; $0080
              bne done                 ; non-zero → skip the wait entirely
              ; (save regs, jsr music_driver, restore regs)
spin:         lda PPUSTATUS
              bpl spin                 ; spin until bit 7 (VBlank) is set
done:         rts
```

Two things worth noting:

1. **`skip_vblank_wait` ($0080)** lets boot / long operations bypass the spin and return immediately.
2. **`music_driver` is called from inside the spin** — so audio ticks both here and in the NMI proper. The driver runs every frame regardless of foreground state, and *twice* if the foreground is waiting for VBlank when NMI fires. Deliberate: it keeps audio rock-solid through any heavy PPU update.

## The palette pipeline

Palette uploads are the canonical "deferred PPU update" pattern: foreground code edits a RAM shadow, sets a dirty flag, and the next NMI does the actual transfer.

```asm
b15_c6d4:   lda $0074
            beq done                     ; nothing to do
            jsr $c69d                    ; rendering off
            lda #$3F / sta PPUADDR       ; PPUADDR = $3F00 (palette base)
            lda #$00 / sta PPUADDR
            tax                          ; X = 0
loop:       lda $0700,x                  ; read shadow byte
            sta PPUDATA                  ; → PPU palette RAM
            inx
            cpx #$20
            bne loop                     ; 32 bytes = full BG+sprite palette
            ; reset PPUADDR to $3F00 then $0000 (PPU bus address tidy-up)
            lda #$3F / sta PPUADDR ; lda #$00 / sta PPUADDR / sta PPUADDR / sta PPUADDR
            sta PPUSCROLL / sta PPUSCROLL ; scroll = 0,0
            jsr $c567                    ; rendering on
            lda #$00 / sta $0074         ; clear dirty flag
done:       rts
```

Three named ZP locations:

| ZP | Role |
|---|---|
| `$0074` | **Palette dirty flag.** Non-zero = upload pending. Cleared by `$C6D4` after upload. |
| `$0700-$071F` | **Palette shadow** — 32 bytes mirroring PPU $3F00-$3F1F. Reset-initialized to `$3E` (a real palette entry: medium grey). Foreground writes here; NMI ships to PPU. |

`$0074` resolves chapter 2's open question "name $74's subsystem." The routines near `b15_c36c` that EOR/manage $74 are the **palette setter** — they write new colors to $0700-$071F and then set $74=1 to signal NMI. Identifying that subsystem definitively is a chapter-4 task (it'll be invoked by one of the BRK dispatch entries).

Note the `$3E` reset fill: 32 grey-grey-grey palette entries. The game boots with a neutral palette until the title screen overwrites it.

The parallel reset fill of `$0090-$00AF` with `$3E` is the second palette buffer, **`palette_alt`** — the swap target that `palette_swap` ($C36C, syscall $12) atomically exchanges with `palette_shadow` for fade/transition effects (ch.2).

## OAM DMA

```asm
$C0E5: LDA #$00 / STA $2003           ; OAMADDR = 0
$C0EA: LDA #$06 / STA $4014           ; DMA $0600-$06FF → 256 bytes of OAM
```

Standard NES OAM DMA. The CPU is suspended for 513 cycles (or 514 on odd cycle) while DMA copies 256 bytes from $0600-$06FF to PPU OAM.

This finally explains the cryptic chapter-1 reset code:

```asm
; reset $C06E-$C07C:
            lda #$F8
            sta $0600,x   ; sprite Y (off-screen)
            sta $0603,x   ; sprite X (off-screen)
            inx ×4
            ...
```

Each NES sprite is 4 bytes — Y, tile, attribute, X. Filling byte 0 (Y) and byte 3 (X) with `$F8` puts every sprite at coordinate (248, 248) — off-screen-bottom-right, so unused sprites don't draw. The stride-of-4 loop is just an optimization to clear both Y and X in one pass.

## Controller poll ($C628)

A 16-byte routine that handles both controllers via the indexed-addressing trick:

```asm
b15_c628:   tax                        ; X = A = player index (0 or 1)
            lda #$01 / sta $4016       ; strobe high
            lda #$00 / sta $4016       ; strobe low → latch
            ldy #$08                   ; 8 buttons to read
loop:       lda $4016,x                ; $4016 (P1) or $4017 (P2)
            lsr a                      ; bit 0 → carry
            ror $006e,x                ; carry → top bit of $6E (P1) or $6F (P2)
            dey
            bne loop
            rts
```

After 8 shifts the destination byte holds the canonical NES button bitfield (MSB-first):

| Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
|---|---|---|---|---|---|---|---|---|
| Button | A | B | Select | Start | Up | Down | Left | Right |

Two more ZP locations identified:

| ZP | Role |
|---|---|
| `$006E` | P1 button state (held; raw 8-bit field) |
| `$006F` | P2 button state (held; raw 8-bit field) |

These are **held** state with no edge detection. Just-pressed / just-released detection happens elsewhere — typically a "previous-frame snapshot" XOR'd with the current frame. The trace didn't hit that code path; presumably it lives near whichever BRK dispatch entry handles menu input.

## The music driver — two passes

The music driver advances five voices over the 9-byte records at `v0_trigger` ($0734), and it runs in **two distinct passes per frame** — a trigger pass that starts newly-queued notes, and a sequencer pass that advances each voice's song stream.

### Dispatcher (`music_driver` $C7A5)

Three instructions — call each pass in turn:

```asm
$C7A5: JSR music_trigger_pass    ; pass 1: start any voice with byte0 ∈ [1..4]
$C7A8: JSR music_sequencer_pass  ; pass 2: tick countdown / load the next note
$C7AB: RTS
```

### Voice state records ($0734-$0760) + the per-voice config array ($0725-$0733)

Five 9-byte voice **state** records at `$0734-$0760`, preceded by the 5×3-byte per-voice **config** array `$0725-$0733`:

```
$0721-$0724: audio_active_v0..v3       (per-voice enable flags)
$0725-$0733: v0..v4_config             — 5 × (tempo_div, song_ptr_lo, song_ptr_hi), written by audio_load_voice $C3AD
$0734-$073C: Voice 0 state  (9 bytes)
$073D-$0745: Voice 1
$0746-$074E: Voice 2
$074F-$0757: Voice 3
$0758-$0760: Voice 4
```

(In the snapshot below, the `$0730` row reads as `v3_config`'s song-ptr-hi `$81` followed by `v4_config = (tempo_div $0A, song_ptr $84AF)`.)

A snapshot during gameplay (R1=Pulse1, R2=Pulse2, R3=Triangle active):

```
$0730: 81 0A AF 84   ; v3_config ptr-hi $81; v4_config = tempo $0A, song-ptr $84AF
$0734: 00 0F 00 35 08 0A A6 84 00   ; V0 (idle)
$073D: 05 0F 00 7F 08 0A 57 81 05   ; V1 (Pulse1: just played, cursor $8157, count 5)
$0746: 06 0F 00 D5 08 0A 92 81 3D   ; V2 (Pulse2: just played, cursor $8192, count $3D)
$074F: 07 17 00 1D 09 0A C5 81 1D   ; V3 (Triangle: just played, cursor $81C5, count $1D)
$0758: 00 0D 00 1E 08 0A B6 84 00   ; V4 (idle)
```

### 9-byte record layout (runtime-confirmed)

| Offset | Field | Updated by | Notes |
|---|---|---|---|
| 0 | **Channel trigger** | Pass 2 ($C948) writes 1-4 → Pass 1 ($C7F7) writes 5-8 | 1=Pulse1, 2=Pulse2, 3=Triangle, 4=Noise, 0=idle, 5-8=just-played dormant |
| 1 | **APU $4000+N×4** (vol/duty) | song-start only | not re-written per note — envelope is fixed per voice |
| 2 | **APU $4001+N×4** (sweep) | song-start only | usually $00 |
| 3 | **APU $4002+N×4** (timer-lo) | Pass 2 ($C93B) per note | pitch low byte |
| 4 | **APU $4003+N×4** (timer-hi + length) | Pass 2 ($C935) per note | pitch high bits + length-counter index |
| 5 | (tempo divider?) | rarely | constant `$0A` in snapshot — purpose still unclear |
| 6 | **Song-ptr lo** | Pass 2 ($C8A9) per note | advances 1+ bytes per note |
| 7 | **Song-ptr hi** | Pass 2 ($C8B3) per note | high byte stays stable through a song |
| 8 | **Duration countdown** | Pass 2 (load: $C998, dec: $C8CB) | reaches 0 → next note loads |

### Pass 1: the trigger ($C7AC)

```asm
$C7AC:      lda #$00 / sta $0079             ; voice counter = 0
            lda #$34 / sta $7A               ; ($7A) = $0734 (voice 0 base)
            lda #$07 / sta $7B
loop:       jsr $C7DE                        ; check & play this voice
            jsr $C7C9                        ; counter++; ($7A) += 9
            lda $0079
            cmp #$05
            bne loop                         ; 5 voices
            rts
```

The per-voice check ($C7DE) reads byte 0; if `1 ≤ byte0 ≤ 4`, calls `$C7EF`:

```asm
$C7EF:      tax / dex / txa                  ; A = byte0 - 1
            clc / adc #$05                   ; A = byte0 + 4
            ldy #$00 / sta ($7A),y           ; one-shot: byte0 ← byte0+4
            txa / asl / asl / tax            ; X = (byte0-1) × 4
            ; ($0720 mute-group check — see below)
            ldy #$01
write_loop: lda ($7A),y / sta $4000,x        ; write bytes 1-4 → APU $4000+X..$4003+X
            inx / iny / cpy #$05 / bne write_loop
            rts
```

`X = (byte0-1) × 4` maps to the four APU channel bases:

| byte0 | X | APU registers written |
|---|---|---|
| 1 | 0 | $4000-$4003 (Pulse 1) |
| 2 | 4 | $4004-$4007 (Pulse 2) |
| 3 | 8 | $4008-$400B (Triangle) |
| 4 | 12 | $400C-$400F (Noise) |

After playing, byte0 becomes 5-8 (dormant); the dispatcher's `cmp #$05 / bcs skip` ensures it won't fire again until Pass 2 writes a fresh 1-4.

### Pass 2: the sequencer ($C817)

Same outer-loop shape as Pass 1, but the per-voice body decrements byte 8, and when byte 8 hits zero, loads the next note from the song data stream.

The trace caught a complete "countdown → load" sequence at frame 39653, voice 1:

| Trace | Effect |
|---|---|
| `$C8CB STA ($7A),Y [$0745]` $01→$00 | Byte 8 decrements to zero |
| `$C8A9 STA ($7A),Y [$0743]` ← $7C | **Byte 6** (song-ptr lo) ++ |
| `$C8B3 STA ($7A),Y [$0744]` ← $81 | **Byte 7** (song-ptr hi) |
| `$C935 STA ($7A),Y [$0741]` ← $08 | **Byte 4** = new APU timer-hi |
| `$C93B STA ($7A),Y [$0740]` ← $7F | **Byte 3** = new APU timer-lo |
| `$C948 STA ($7A),Y [$073D]` ← $01 | **Byte 0** = 1 → triggers Pulse1 next frame |
| `$C998 STA ($7A),Y [$0745]` ← $20 | **Byte 8** = $20 (32 frames duration) |

Then frames 39654/39655 show byte 8 of all three active voices decrementing in lockstep ($20 → $1F → ...). Voices tick independently — each has its own countdown.

### The $0720 mute-group flag

Pass 1's APU write has a gating check on `$0720`:

```asm
lda $0720
beq do_write           ; if $0720 = 0, normal write
lda $0079
cmp #$02
beq skip               ; if voice index = 2 (Triangle), skip the write
do_write: ...
```

`$0720` is a **triangle-mute flag**. When set, voice 2 (Triangle)'s APU register write is suppressed — the music driver still advances its song pointer and countdown internally (so the song stays in sync), but the triangle channel goes silent. This is how the engine ducks the triangle to play a sound effect through it without losing the music's continuation.

The trace showed `$0720` toggling 0↔1 during gameplay, while `$0721-$0724` stayed at $01 — confirming `$0720` is the mute toggle and `$0721-$0724` are "always-active" voice flags (probably enable-bits set at song start and cleared at song end).

### What the song data looks like

The song-pointer bytes ($81xx for the active song in snapshot) walk through compressed music data byte-by-byte. From the trace:

| Voice | Byte 6/7 sequence |
|---|---|
| V1 (Pulse1) | $8157 → $8159 → $815B → ... (~2 bytes/note) |
| V2 (Pulse2) | $8192 → ...  |
| V3 (Triangle) | $81C5 → $81C7 → ... |

Three separate cursors for three voice channels — i.e., the music data is **per-voice tracks**, not a single interleaved stream. Each voice's track advances independently as its countdown hits zero. The format of the bytes themselves (note value + duration? or note + length + flag?) is a chapter-4 detail.

## The wall-clock tick

```asm
$C109-$C12A:
        clc
        lda $0086 / adc #$02 / sta $0086     ; counter A low += 2
        lda $0085 / adc #$00 / sta $0085     ; counter A high += carry
        clc
        lda $0084 / adc #$02 / sta $0084     ; counter B low += 2
        lda $0083 / adc #$00 / sta $0083     ; counter B high += carry
```

Two paired 16-bit counters, each += 2 per frame, gated by `$0089`. Reset-initialized to `$04D2` = 1234 decimal (a calibration value, not random — picked deliberately, role TBD). Likely roles: in-game month/year counter, animation/timeout timer.

## What chapter 3 establishes

- The NMI handler runs **5 named subsystems** in fixed order, bracketed by `nmi_off`/`nmi_on`.
- A **PPU register shadow API** at `ppuctrl_shadow`/`ppumask_shadow` ($0071/$0072) with 7 helpers — strictly enforced, never bypassed.
- The **palette pipeline**: `palette_dirty` ($0074), `palette_shadow` ($0700-$071F), the `palette_upload` ($C6D4) uploader, and `palette_alt` ($0090-$00AF) the fade swap-target.
- The **OAM DMA** ships `oam_shadow` ($0600), with sprite Y/X both pre-set to $F8 for off-screen idle.
- The **controller poll** (`controller_poll` $C628) stores held state in `p1_buttons`/`p2_buttons` ($006E/$006F).
- The **music driver** runs **two passes per frame** (`music_trigger_pass` + `music_sequencer_pass`) over the 5 voice records at `v0_trigger` ($0734), each 9 bytes with the runtime-confirmed layout above.
- `$0720` is the **triangle-mute flag**; `$0721-$0724` are per-voice always-active flags; `$0725-$0733` is the 5×3-byte per-voice config array (`v0..v4_config`).

## Open

- **The packed song-data format** ($81xx/$84xx per-voice tracks) — the note/duration encoding each `music_sequencer_pass` walks; the one genuinely-open audio item (ties to the bank-10 `play_audio_by_id` path).
- **Just-pressed / just-released edge detection** — `p1_buttons`/`p2_buttons` hold raw state; edge detection lives downstream in the VM input path.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
