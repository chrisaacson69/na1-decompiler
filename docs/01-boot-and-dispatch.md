---
status: active
created: 2026-05-10
layout: default
title: "Chapter 1 \u2014 Boot, Vectors, and the Syscall Dispatcher"
---
# Chapter 1 — Boot, Vectors, and the Syscall Dispatcher
> First architectural cut into a 256 KB cartridge: decode the iNES header, find the reset code, trace the interrupt handlers, and discover that the IRQ vector doubles as an OS-style **syscall dispatcher** over 23 kernel primitives. Every routine and variable below carries its grounded name from `mesen-labels.toml`; the bare-address forms are in the `_labeled.asm` listings.

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

So **bank 15 is permanently mapped at $C000–$FFFF** and holds the boot code, interrupt handlers, and the kernel of always-live routines. Banks 0–14 rotate through $8000–$BFFF as the game switches subsystems (selecting bank 15 into the switchable window just duplicates the fixed bank).

The reset vector points to **$C000** — the first byte of bank 15. The Koei signature `"NOBU-NES10      "` sits at $FFE0–$FFEF, just above the vector table.

## The 6502 vector table at $FFFA–$FFFF

```
$FFFA  DA C0   → NMI   = nmi_handler   ($C0DA)
$FFFC  00 C0   → RESET = reset_handler ($C000)
$FFFE  39 C1   → IRQ   = irq_handler   ($C139)   ← also the syscall gate (see below)
```

## Reset handler (`reset_handler` $C000–$C0D9)

The canonical NES boot pattern with MMC1 register sequencing layered in.

```asm
; --- CPU + MMC1 init ---
SEI / CLD / LDX #$FD / TXS          ; mask IRQ, decimal off, SP = $FD
LDA #$FF / STA $9FFF                ; MMC1 reset (bit 7 high)
LDA #$0E / STA $9FFF / LSR×4 + STA  ; CONTROL = $0E, 5 serial LSB writes:
                                    ;   vertical mirror + PRG mode 3 + CHR 8 KB
LDA #$00 / STA $BFFF ×5             ; CHR bank-0 register = 0
            STA $FFF0 ×5            ; PRG bank register = 0 (bank 0 at $8000)
            STA prg_bank_shadow     ; record current PRG bank = 0 (reuses the live A)

; --- clear the two NMI gate flags ---
LDA #$00 / STA skip_vblank_wait     ; $0080
            STA nmi_skip_all        ; $00B0

; --- PPU warm-up ---
LDA #$10 / JSR write_ppuctrl        ; PPUCTRL ($2000) = $10  (sets ppuctrl_shadow $0071)
JSR wait_vblank / JSR wait_vblank   ; two VBlanks before touching PPU (the standard warm-up)
LDA #$1E / JSR write_ppumask        ; PPUMASK ($2001) = $1E

; --- fill both palette buffers with $3E (medium grey) ---
LDX #$00 / LDA #$3E
.loop: STA palette_alt,x  ($0090)   ; 32 bytes
       STA palette_shadow,x ($0700) ; 32 bytes
       INX / CPX #$20 / BNE .loop
LDA #$FF / STA palette_dirty        ; force a palette upload on the first NMI

; --- hide every sprite: shadow-OAM Y and X = $F8 (off-screen) ---
LDX #$00 / LDA #$F8
.loop: STA oam_shadow,x    ($0600)  ; byte 0 of each sprite (Y)
       STA oam_shadow+3,x  ($0603)  ; byte 3 of each sprite (X)
       INX ×4 / BNE .loop           ; stride 4 = one sprite per pass, all 64

; --- ZP pointer pairs ---
ptr1        = $05FF   ($02/$03)
ppu_queue_a = $0020   ($1C/$1D)
ppu_queue_b = $0030   ($1E/$1F)

; --- APU ---
LDA #$1F / STA SND_CHN ($4015)      ; enable all 5 channels
LDA #$C0 / STA $4017                ; frame counter: 5-step mode, no frame IRQ

; --- clear audio + music state ---
LDX #$00 / LDA #$00
.loop: STA audio_mute_triangle,x    ; clear $0720–$0724 (5 bytes)
       INX / CPX #$05 / BNE .loop
LDX #$00
.loop: STA v0_trigger,x ($0734)     ; 5 music voices × 9-byte stride → $0734–$0760
       X += 9 / CPX #$2D / BNE .loop

; --- two wall-clocks, both = $04D2 (1234) ---
LDA #$04 / STA clock_a_hi / STA clock_b_hi   ; $0083 / $0085
LDA #$D2 / STA clock_a_lo / STA clock_b_lo   ; $0084 / $0086
LDA #$00 / STA skip_wallclock                ; $0089

; --- finalize + hand off ---
JSR nmi_on                          ; enable NMI generation (PPUCTRL bit 7)
JSR reset_ppu_init                  ; upload the initial tiles, turn the screen on
JMP $8000                           ; → bank0_entry
```

Two pieces of this clear loop are worth naming, because both were easy to mis-guess and both are now grounded:

- **The 5×9-byte records at `v0_trigger` ($0734–$0760) are the music engine's per-voice state**: 5 voices × 9 bytes (trigger / vol-duty / sweep / timer-lo / timer-hi / tempo-div / ptr-lo / ptr-hi / countdown), advanced by `music_driver` each NMI and configured by `syscall_audio_load_voice` (ID 9). The adjacent `$0725–$0733` is the 5×3-byte voice **config** array.
- **`clock_a` ($0083/$0084) and `clock_b` ($0085/$0086) are two wall-clocks**, both seeded to `$04D2 = 1234`. The NMI bumps each by 2 every frame, gated by `skip_wallclock`. This is the game-time/RNG clock that **freezes while the player holds a button** (ch.2/3).

## NMI handler (`nmi_handler` $C0DA–$C138)

VBlank fires while rendering is off and the PPU is writable, so the order of operations matters: sprites first (DMA has a hard VBlank deadline), then the gated frame work.

```asm
PHA / TXA/PHA / TYA/PHA              ; save A, X, Y
LDA PPUSTATUS                        ; clear the VBlank flag
JSR nmi_off                          ; guard against NMI re-entry (paired with nmi_on at exit)
LDA #$00 / STA OAMADDR
LDA #$06 / STA OAMDMA ($4014)        ; DMA oam_shadow ($0600) → PPU OAM

LDA nmi_skip_all / BNE .done         ; $B0 set → bail right after sprites (pause / cutscene)
LDA #$00 / JSR controller_poll       ; P1 buttons → $006E
LDA #$01 / JSR controller_poll       ; P2 buttons → $006F
JSR palette_upload                   ; if palette_dirty: push palette_shadow → PPU $3F00
JSR music_driver                     ; advance the 5 music voices

LDA skip_wallclock / BNE .skipclk    ; $89 set → run the frame but freeze game-time
   clock_b += 2  (lo $86, hi $85)    ; 16-bit add, carry into the high byte
   clock_a += 2  (lo $84, hi $83)
.skipclk:
.done:
LDA #$00 / STA nmi_busy ($0081)      ; release the "wait for VBlank" handshake
JSR nmi_on                           ; re-enable NMI generation
PLA/TAY / PLA/TAX / PLA / RTI
```

The two gate flags are the engine's pause levers: **`nmi_skip_all` ($00B0)** set → NMI does the sprite DMA and bails (a hard pause that still shows the last frame's sprites — cutscenes); **`skip_wallclock` ($0089)** set → the frame runs normally but game-time and the RNG clock don't advance (the strategic-level pause that freezes time while rendering continues). **`nmi_busy` ($0081)** is the handshake semaphore: foreground code sets it to 1 and spin-waits for the NMI to clear it — the classic "block until the next VBlank" wait.

## IRQ handler (`irq_handler` $C139–$C172) — the syscall dispatcher

The board has no mapper IRQ, so a hardware IRQ effectively never fires. Instead the IRQ vector is repurposed as the **kernel's syscall gate**: the handler inspects the B flag to tell a (synthesized) software request from a spurious interrupt.

```asm
PHA / TXA/PHA / TYA/PHA              ; save A, X, Y
TSX / LDA $0104,X / AND #$10         ; isolate the B flag from the pushed P
BEQ .spurious                        ; B=0 → not a syscall; plain IRQ exit

; --- syscall path ---
LDA #$00 / STA brk_scratch_lo ($0066) / STA $0067   ; clear scratch
LDA #$C1 / PHA / LDA #$6C / PHA      ; push fall-through return = $C16C (where a task's RTS lands)
LDX brk_dispatch_id ($0050)          ; X = task ID
LDY #$03 / JSR mul_xy_by_3           ; scale the ID by the 3-byte table stride
CLC
TYA / ADC #$73 / STA brk_jmp_target_lo ($0068)   ; target = $C173 + id*3
TXA / ADC #$C1 / STA $0069
JMP (brk_jmp_target_lo)              ; → syscall_dispatch_table[id]

.spurious:                            ; ($C16C — also the landing pad for a task's RTS)
NOP / PLA/TAY / PLA/TAX / PLA / RTI
```

The indirect JMP lands in a 3-byte-per-entry jump table at `syscall_dispatch_table` ($C173). **23 entries: 19 active OS-style kernel primitives + 4 `RTS` no-op slots** (IDs 2/11/14/15 — reserved slots in a generic Koei kernel that this title doesn't use). Names are grounded in ch.4:

| ID | Entry | Target | Name (ch.4) | Role |
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

**All 23 targets land in bank 15 ($C000–$FFFF).** The table routes only inside the fixed bank — it is a **kernel syscall surface** (PPU / OAM / palette / audio / RNG / SRAM / bank-call primitives), not a game-subsystem scheduler. Game logic lives in the bytecode VM (banks 0/1/2/10/14) and reaches these services through it; `syscall_call_bank` (ID 7) is the trampoline that JSRs another bank's $8000.

### How the syscall gate works (the synthesized BRK)

Code does not scatter 1-byte `BRK`s. To request a service it calls `syscall_dispatch ($F226)`, a small wrapper that loads the request into `brk_dispatch_id ($0050)` and then does **`PHP` + `JMP ($FFFE)`** — assembling by hand the exact stack frame a `BRK` would leave, so execution enters `irq_handler` with the **B flag set**. The handler reads B: clear ⇒ a (spurious) hardware IRQ, plain `RTI`; set ⇒ a syscall, so it scales the task ID by 3 and indirect-JMPs through `syscall_dispatch_table`.

The win is architectural, not byte-count (the trampoline is *larger* than a plain `JSR`): one uniform kernel entry, parameter marshalling, and a single return point, reachable identically from native 6502 and from the VM — the VM's `host_call` opcode (`$E9`) routes to the same `$F226`. The interrupt vector, in other words, is load-bearing structure: an OS-style trap gate built out of the CPU's BRK/IRQ machinery.

## Bank 0 hand-off ($8000)

```asm
$8000: JMP $A778        ; bank0_entry
```

A one-instruction shim: `bank0_entry` jumps straight to `$A778`, which is **Sea-16 VM bytecode** — the interpreter the rest of the project decompiles (chs. 5–6). So the engine is two layers: a native bank-15 kernel (NMI, OAM, controllers, palette, audio, math, SRAM — everything above) and a custom bytecode VM in banks 0/1/2/10/14 for the strategy layer (orders, AI, dialog, save state). That split is how Koei fit a home-computer strategy engine into 256 KB of PRG and a 2 KB RAM budget, and it is the shape of the whole engine.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
