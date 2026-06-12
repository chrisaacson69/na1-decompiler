---
status: active
created: 2026-05-10
---
# Chapter 1 — Boot, Vectors, and the Syscall Dispatcher
> First architectural cut into a 256 KB cartridge: decode the iNES header, find the reset code, identify the interrupt handlers, and discover that the IRQ vector doubles as an OS-style **syscall dispatcher** over 23 kernel primitives.

> **⚠ Pass-2 fact-check (2026-06-11).** This session-1 chapter was written before the kernel was grounded; several hypotheses are now settled, corrected inline below. **(1)** The dispatcher is **not** a "BRK-VM": game/VM code requests a service via `jsr syscall_dispatch ($F226)`, which *fakes* a BRK with `PHP + JMP ($FFFE)` so the IRQ handler dispatches on the B flag — the "1-byte BRK saves bytes" rationale is **refuted** (the trampoline is larger, not smaller; the win is a central return + parameter passing). **(2)** The 23 entries are now all **named** — 19 OS-style kernel primitives + 4 RTS no-op slots, not 23 game subsystems. **(3)** The "5×9-byte records at $0734 = daimyo slots" guess is **refuted** — it is the **music engine's voice-state array**. **(4)** The bytecode-VM "working hypothesis" is **confirmed** (see ch.5). The accurate parts (iNES decode, MMC1 init, NMI shape, the paired wall-clocks) stand.

**Links:** [Nobunaga README](./README.md) · [NES mappers reference](../../../research/nes/mappers-reference.md) · [NES PPU reference](../../../research/nes/ppu-reference.md) · [NES APU reference](../../../research/nes/apu-reference.md)

## iNES header (file offset 0–15)

```
4E 45 53 1A   "NES\x1a"           iNES magic
10            16                  PRG banks × 16 KB = 256 KB
00            0                   no CHR-ROM → CHR-RAM
12            0001_0010           mapper low=1, battery=1, vertical-mirror=0
08            0000_1000           mapper high=0, bits 2-3=10 → NES 2.0
00 00         submapper/upper bits
77            PRG-RAM=8 KB, PRG-NVRAM=8 KB (the battery save)
07            CHR-RAM=8 KB
00 00 00 00 00 (reserved)
```

**Verdict:** mapper 1 (MMC1), 256 KB PRG, 8 KB CHR-RAM, 8 KB battery-backed PRG-RAM at $6000–$7FFF. The combination of 8 KB battery RAM + 256 KB PRG identifies this as a **SOROM** board (Koei used this for their large-state strategy carts).

## Bank layout under MMC1

The MMC1 control register is set to `$0E` during reset (see below). Decoded:

- Bits 0–1 = `10` → **vertical mirroring**
- Bits 2–3 = `11` → **PRG mode 3** (16 KB switchable at $8000–$BFFF; 16 KB fixed at $C000–$FFFF, set to the last bank)
- Bit 4 = `0` → CHR 8 KB mode

So **bank 15 is permanently mapped at $C000–$FFFF** and holds the boot code, interrupt handlers, and presumably the most critical "always live" routines. Banks 0–15 (well, 0–14 in practice; selecting 15 into the switchable region duplicates the fixed bank) rotate through $8000–$BFFF as the game switches subsystems.

The reset vector points to **$C000** — i.e., the very first byte of bank 15. The Koei signature `"NOBU-NES10      "` sits at $FFE0–$FFEF, just above the vector table.

## The 6502 vector table at $FFFA–$FFFF

```
$FFFA  DA C0   → NMI   = $C0DA
$FFFC  00 C0   → RESET = $C000
$FFFE  39 C1   → IRQ   = $C139
```

## Reset handler ($C000–$C0D9)

The reset code follows the canonical NES boot pattern with MMC1-specific register sequencing layered in.

```asm
; --- CPU init ---
$C000: SEI                  ; mask IRQs (which point at the BRK dispatcher — see below)
$C001: CLD                  ; clear decimal (no-op on NES 6502 but standard)
$C002: LDX #$FD
$C004: TXS                  ; SP = $FD (note: not the usual $FF)
                            ; — by booting with SP one slot lower the boot code can drop
                            ;   a sentinel into $01FE without disturbing later use of the stack

; --- MMC1 control register: 5 serial writes of bit 0, then a reset preamble ---
$C005: LDA #$FF
$C007: STA $9FFF            ; bit 7 high → MMC1 internal reset
$C00A: LDA #$0E             ; control value = 01110
$C00C: STA $9FFF            ; serial write 1 (LSB)
$C00F: LSR A                ; A = $07
$C010: STA $9FFF            ; write 2
$C013: LSR A                ; A = $03
$C014: STA $9FFF            ; write 3
$C017: LSR A                ; A = $01
$C018: STA $9FFF            ; write 4
$C01B: LSR A                ; A = $00
$C01C: STA $9FFF            ; write 5 — commits CONTROL = $0E

; --- CHR bank 0 register = 0 (5 writes, all zeros) ---
$C01F: LDA #$00
$C021: STA $BFFF            ; ×5

; --- PRG bank register = 0 (5 writes to anywhere in $E000-$FFFF) ---
$C030: STA $FFF0            ; ×5  (selects bank 0 at $8000–$BFFF on entry)
```

The `STA $FFF0` trick is the standard MMC1 idiom: any write to $E000–$FFFF routes to the PRG-bank register. Writing the address `$FFF0` rather than `$E000` is purely cosmetic — but it does mean the 5-write commit sequence is invisible to anyone grepping for `$E000`.

Continuing:

```asm
; --- Zero misc RAM, fill defaults ---
$C03F: STA $0073            ; clear var $73
$C042: LDA #$00 / STA $0080 / STA $00B0    ; clear $80, $B0

; --- Two init subroutines (likely PPU warmup / wait-for-VBlank) ---
$C04A: LDA #$10
$C04C: JSR $C6A6
$C04F: JSR $C537            ; called twice — almost certainly the standard
$C052: JSR $C537            ;   "wait for two VBlanks before touching PPU" pattern
$C055: LDA #$1E
$C057: JSR $C570

; --- Fill RAM regions with $3E (some neutral-default tile or value) ---
$C05A: LDX #$00
$C05C: LDA #$3E
$C05E: STA $0090,X          ; $0090–$00AF (32 bytes of zero-page-ish RAM)
$C061: STA $0700,X          ; $0700–$071F (32 bytes of $0700 page)
$C064: INX / CPX #$20 / BNE $C05E

; --- Fill OAM-shadow buffer at $0600 with $F8 (Y = off-screen) ---
$C069: LDA #$FF / STA $0074
$C06E: LDX #$00
$C070: LDA #$F8
$C072: STA $0600,X          ; Y = $F8 (sprite off-screen)
$C075: STA $0603,X          ;   (also writing every 4th-byte offset — sprite Y again?
$C078: INX × 4              ;    actually since both target the +0 and +3 columns and
$C07C: BNE $C072            ;    INX runs 4× per loop, we hit Y at +0 then again at +3,
                            ;    +4, +7, +8, +11... which is *every* byte alternating.
                            ;    Closer read: $0600,X and $0603,X with X stepped by 4
                            ;    fills offsets [0,3,4,7,8,11,...] — covers all positions
                            ;    that hold sprite Y (bytes 0 of each 4-byte sprite) and
                            ;    sprite X (byte 3). Initializes Y and X to $F8 so unused
                            ;    sprites are off-screen and don't smear.)

; --- Set up ZP indirect-pointer pairs ---
$C07E: LDA #$FF / STA $02   ; ZP $02/$03 = $05FF  (wait — high byte stored first?)
$C082: LDA #$05 / STA $03   ;   actually 6502 stores high in $03 → pointer = $05FF
$C086: LDA #$20 / STA $1C   ; $1C/$1D = $0020
$C08A: LDA #$00 / STA $1D
$C08E: LDA #$30 / STA $1E   ; $1E/$1F = $0030
$C092: LDA #$00 / STA $1F

; --- APU init ---
$C096: LDA #$1F / STA $4015 ; enable all 5 channels (pulse1, pulse2, tri, noise, DMC)
$C09B: LDA #$C0 / STA $4017 ; frame counter: 5-step mode, no IRQ

; --- Clear small tables ---
$C0A0: LDX #$00 / LDA #$00 / STA $0720,X / INX / CPX #$05 / BNE  ; clear $0720–$0724
$C0AC: clear every byte at $0734 + N×9 for N=0..4     ; 5 records, 9-byte stride
                                                       ; — this is the player/daimyo
                                                       ;   record skeleton: 5 slots
                                                       ;   of 9-byte fixed-size records.

; --- Default state vars ---
$C0BC: LDA #$04 / STA $0083 / STA $0085   ; $83 and $85 = 4
$C0C4: LDA #$D2 / STA $0084 / STA $0086   ; $84 and $86 = $D2
$C0CC: LDA #$00 / STA $0089                ; $89 = 0

; --- Two more init calls ---
$C0D1: JSR $C68A
$C0D4: JSR $C757

; --- Hand off to main program in bank 0 ---
$C0D7: JMP $8000
```

Two findings worth flagging:

1. **Five slots of 9-byte records at $0734 — the MUSIC voice-state array, NOT daimyo slots.** [REFUTED 2026-06-11] The clear loop initializes 5 records of 9-byte stride; session 1 guessed "5 daimyo player slots." Grounded: `$0734-$0760` is the **music engine's per-voice state** (5 voices × 9 bytes — trigger / vol-duty / sweep / timer-lo / timer-hi / tempo-div / ptr-lo / ptr-hi / countdown), driven by `music_driver` each NMI and configured by `syscall_audio_load_voice` (ID 9). The daimyo records live elsewhere (the 7-byte `$752F` table, ch.7). A clean-looking guess that was simply wrong — the kind of thing this pass exists to catch. *(The adjacent `$0725-$0733` is the 5×3-byte voice **config** array.)*

2. **Paired 16-bit counters at $83/$84 and $85/$86 — two wall-clocks.** [CONFIRMED 2026-06-11] Both initialise to `$04D2 = 1234`; the NMI increments each pair by 2 every frame, gated by `skip_wallclock $0089`. Grounded as `clock_a`/`clock_b` (`$0083-$0086`): synchronized but independently-gateable game-time counters — this is the clock that **freezes while the player holds a button** (the `skip_wallclock` finding: game-time and RNG pause during input).

## NMI handler ($C0DA–$C138)

Standard VBlank shape; the order of operations matters because NMI fires while rendering is off and the PPU is writable.

```asm
$C0DA: PHA / TXA / PHA / TYA / PHA       ; save A, X, Y
$C0DF: LDA $2002                         ; clear VBlank flag
$C0E2: JSR $C54F                         ; nmi_off — disable NMI re-entry (paired with nmi_on $C68A at frame end)
$C0E5: LDA #$00 / STA $2003              ; OAMADDR = 0
$C0EA: LDA #$06 / STA $4014              ; OAM DMA from page $0600 → PPU OAM
$C0EF: LDA $00B0
$C0F2: BNE skip_periodic                 ; if $B0 set, skip the rest of frame work
$C0F4: LDA #$00 / JSR $C628              ; controller read pass 1 (player 1)
$C0F9: LDA #$01 / JSR $C628              ; controller read pass 2 (player 2)
$C0FE: JSR $C6D4                         ; (audio engine tick?)
$C101: JSR $C7A5                         ; (some other periodic update)
$C104: LDA $0089
$C107: BNE skip_clock                    ; if $89 set, skip the wall clock
$C109: ; 16-bit add $0002 to ($86 high / $85 low)  — but wait, address order:
$C109: CLC
$C10A: LDA $0086 / ADC #$02 / STA $0086  ; low byte += 2
$C112: LDA $0085 / ADC #$00 / STA $0085  ; high byte += carry
$C11A: CLC
$C11B: LDA $0084 / ADC #$02 / STA $0084  ; second counter low += 2
$C123: LDA $0083 / ADC #$00 / STA $0083  ; second counter high += carry
skip_clock:
$C12B: LDA #$00 / STA $0081              ; clear "NMI busy" semaphore
$C12E: JSR $C68A                         ; (same routine as reset — likely PPU finalize)
$C133: PLA/TAY / PLA/TAX / PLA           ; restore Y, X, A
$C138: RTI
```

The `$B0` and `$89` flags are grounded as **frame-work gates** [CONFIRMED 2026-06-11]: `nmi_skip_all $00B0` set → NMI bails right after OAM DMA (skip controller / audio / palette / clock — pause, cutscene); `skip_wallclock $0089` set → run the frame but skip the wall-clock tick (strategic-level pause, rendering continues). Both session-1 readings were right.

The `$81` semaphore (`nmi_busy $0081`) is cleared at the end of NMI; foreground code sets it to 1 and spin-waits for the clear — the classic "wait for next VBlank" handshake. [CONFIRMED]

## IRQ handler ($C139–$C172) — the BRK dispatcher

This is the architectural find of the session.

```asm
$C139: PHA / TXA / PHA / TYA / PHA       ; save A, X, Y
$C13E: TSX                               ; X = SP
$C13F: LDA $0104,X                       ; load saved P from stack frame
$C142: AND #$10                          ; isolate B flag
$C144: BEQ real_irq_C16C                 ; if not BRK, fall through to plain IRQ exit
                                         ; (no MMC1 IRQ; this branch handles spurious only)

; --- BRK path: software dispatch ---
$C146: LDA #$00 / STA $0066 / STA $0067  ; clear scratch
$C14E: LDA #$C1 / PHA                    ; push return-high = $C1
$C151: LDA #$6C / PHA                    ; push return-low  = $6C
                                         ; → return address $C16C-1 wraps to $C16B
                                         ;   wait — actually the dispatch JMP doesn't
                                         ;   return; this push is the "fall-through"
                                         ;   if the dispatched task RTS's.
$C154: LDX $0050                         ; X = task ID
$C157: LDY #$03                          ; Y = stride
$C159: JSR $C6AD                         ; multiply X by 3 with carry into X high

$C15C: CLC
$C15D: TYA / ADC #$73 / STA $0068        ; low  = $73 + (X*3 lo)
$C163: TXA / ADC #$C1 / STA $0069        ; high = $C1 + (X*3 hi) + carry
$C169: JMP ($0068)                       ; INDIRECT — jump to $C173 + task_id*3

real_irq_C16C:
$C16C: NOP                               ; (also the RTS-return landing for dispatched tasks)
$C16D: PLA/TAY / PLA/TAX / PLA / RTI
```

The dispatched task lands inside a 3-byte-per-entry JMP table starting at $C173 (`syscall_dispatch_table`). **23 entries** before the table runs out — now fully grounded (names from ch.4): **19 active OS-style kernel primitives + 4 RTS no-op slots** (IDs 2/11/14/15, reserved generic-Koei-kernel slots this title doesn't use):

| ID | Entry | Target | Grounded name (ch.4) | Role |
|----|-------|--------|----------------------|------|
|  0 | $C173 | $C000  | `reset_handler` | soft reboot (jumps to RESET) |
|  1 | $C176 | $C264  | `syscall_ppu_upload_block` | bank-switched bulk PRG→PPU copy |
|  2 | $C179 | $C34B  | `syscall_noop_02` | RTS no-op slot |
|  3 | $C17C | $C2CB  | `syscall_set_sprite` | write one OAM sprite |
|  4 | $C17F | $C34C  | `syscall_palette_write` | write one palette byte |
|  5 | $C182 | $C312  | `syscall_fill_nametable` | fill the 30×32 nametable |
|  6 | $C185 | $C39E  | `syscall_read_controller` | poll buttons |
|  7 | $C188 | $C339  | `syscall_call_bank` | inter-bank JSR $8000 (the bank-call trampoline) |
|  8 | $C18B | $C2F0  | `syscall_fill_attr_quadrant` | fill an attribute quadrant |
|  9 | $C18E | $C3AD  | `syscall_audio_load_voice` | load a voice config |
| 10 | $C191 | $C3CF  | `syscall_audio_control` | audio control |
| 11 | $C194 | $C427  | `syscall_noop_0b` | RTS no-op slot |
| 12 | $C197 | $C437  | `syscall_ppu_fill_rect` | constant-tile rect fill |
| 13 | $C19A | $C4E0  | `syscall_ppu_render_rect` | per-tile nametable render |
| 14 | $C19D | $C535  | `syscall_noop_0e` | RTS no-op slot |
| 15 | $C1A0 | $C536  | `syscall_noop_0f` | RTS no-op slot |
| 16 | $C1A3 | $C22C  | `syscall_memcpy_banked` | bank-switched memcpy |
| 17 | $C1A6 | $C1C3  | `syscall_rng_next` | RNG transform |
| 18 | $C1A9 | $C36C  | `syscall_palette_swap` | swap palette buffers (fades) |
| 19 | $C1AC | $C1B8  | `syscall_wait_for_nmi` | spin until VBlank |
| 20 | $C1AF | $C428  | `syscall_ppu_copy_rect` | byte-stream rect copy |
| 21 | $C1B2 | $C60C  | `syscall_set_chr_bank0_reg` | write MMC1 CHR bank |
| 22 | $C1B5 | $C5AA  | `syscall_sram_block_with_checksum` | SRAM block I/O + checksum |

**All 23 targets land in bank 15 ($C000–$FFFF).** The table routes only inside the fixed bank — it is a **kernel syscall surface** (PPU/OAM/palette/audio/RNG/SRAM/bank-call primitives), not a game-subsystem scheduler. Game logic lives in the bytecode VM (banks 0/1/2/10/14) and reaches these services through it (`syscall_call_bank`, ID 7, is the trampoline that JSRs another bank's $8000). The four `syscall_noop_*` slots (2/11/14/15) are bare `RTS` — a generic Koei-kernel layout with slots other titles fill. *(Earlier "fallthrough pair" reading of #2/#4 and #14/#15 was wrong — they are separate no-op stubs.)*

### Why a faked BRK, not a real one?

Game/VM code does **not** scatter 1-byte `BRK`s. It calls `jsr syscall_dispatch ($F226)`, a 22-byte wrapper that copies the request parameters, then **`PHP` + `JMP ($FFFE)`** — synthesising the exact stack frame a BRK would, so execution lands in the IRQ handler ($C139) with the **B flag set** and the dispatch path runs. The IRQ handler thus serves double duty: real hardware IRQ (B=0, plain exit) vs. syscall request (B=1, dispatch on `brk_dispatch_id $0050`).

So the original "BRK is 1 byte, saving bytes over JSR across thousands of sites" rationale is **refuted** — the actual path is a 3-byte `jsr` into a multi-instruction trampoline, *larger* than a JSR, not smaller. The real payoff is architectural: one uniform kernel entry with parameter marshalling and a single return point, callable identically from native code and from the VM (via the `host_call $E9 → $F226` opcode). The pattern still echoes Adventure's hardware-feature reuse and Mappy's NMI kernel — "use the CPU's accidental capabilities as load-bearing structure" — but the capability here is the **interrupt vector as a syscall gate**, not BRK's byte count.

## Bank 0 main entry ($8000)

```asm
$8000: JMP $A778
```

A single shim. Bank 0 at $8000 immediately jumps into $A778. Inspection of $A778-onward shows **byte patterns inconsistent with raw 6502** — long runs of `E9 / CF / CC / 8D / AC / 89 / A8`-flavored data interleaved with what *look* like opcodes but produce nonsense flow when traced linearly.

**Working hypothesis:** there is a bytecode VM running in bank 0 (or possibly several banks), and $A778 is its main interpreter or program entry. The 23-entry BRK dispatcher and the bytecode VM are likely the same architecture seen from two sides: BRK from native code calls the dispatcher; the dispatcher invokes the VM for menu/script/AI logic.

If confirmed, this game runs **two layers of code**: native 6502 for the hot path (NMI, OAM, controllers, math) and a custom bytecode for the strategy layer (orders, AI, dialog, save state). That's a Koei-typical design and would explain how they fit a home-computer strategy engine into a 256 KB cartridge with a 2 KB RAM budget.

**[CONFIRMED 2026-06-11]** The hypothesis holds. `$8000` is `bank0_entry` (`JMP $A778`), and `$A778` onward is **VM bytecode** — the Sea-16 interpreter the rest of the project decompiles (chs. 5–6). The two-layer architecture — native bank-15 kernel + a bytecode VM in banks 0/1/2/10/14 — is the confirmed shape of the whole engine.

## What we have after session 1

- iNES decode confirmed; MMC1/SOROM identified.
- Reset code traced; MMC1 init sequence understood.
- NMI handler decoded — standard VBlank kernel with 2 paired wall-clocks and 2 gating flags.
- IRQ handler decoded — discovered the **23-entry BRK dispatcher** at $C173.
- Bank 0 entry $8000 shimmed into $A778; **bytecode-VM hypothesis** flagged.

What session 1 left open — **all since resolved (pass-2 note, 2026-06-11):**
- The semantic role of the 23 dispatch IDs → all named kernel syscalls (table above; ch.4).
- The memory map (zero-page / RAM / SRAM) → chs. 2 and 7; every boot-touched RAM byte is grounded above.
- Whether $A778 onward is native or VM bytecode → it is **VM bytecode** (chs. 5–6).

Those were Chapters 2–4 (and 7); this chapter now carries their resolutions inline.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
