---
status: active
created: 2026-05-12
layout: default
title: "Chapter 4 \u2014 The Syscall API"
---
# Chapter 4 — The Syscall API

> The 23-entry dispatch table is a syscall surface, not a subsystem state machine. Every dispatch goes through a single callable wrapper at $F226 that copies a parameter block from a caller-supplied struct into ZP, then fakes a BRK via PHP + JMP($FFFE). These are OS-style primitives (`read_controller`, `palette_write`, `set_sprite`), not game subsystems.

**Links:** [Chapter 1 — Boot & Dispatch](./01-boot-and-dispatch.md) · [Chapter 2 — Zero-Page Map](./02-zero-page-map.md) · [Chapter 3 — NMI Pipeline](./03-nmi-pipeline.md) · [Nobunaga README](./README.md) · [NES PPU reference](../../../research/nes/ppu-reference.md) · [NES APU reference](../../../research/nes/apu-reference.md)

## The syscall surface

The 23-entry indirect-JMP table at `syscall_dispatch_table` ($C173) is an **OS-style syscall API.** Each handler is a 5-50 instruction routine implementing one primitive operation — read a controller, write a palette byte, blit a tile block, switch banks. Game code in banks 0-14 invokes these primitives through a uniform calling convention whenever it needs kernel services. The bank-15 fixed kernel **is** the OS; the rest of the ROM is application code that runs on it.

The syscall analogy is exact:
- A **dispatcher** turns a numbered request into a handler call
- A **parameter block** carries arguments from caller to handler
- A **return-value register** carries results back
- Each handler is **stateless** between calls; it operates on the parameters and any shared kernel state (palette buffers, audio state, PPU shadows)

## The dispatch mechanism — code walkthrough

The real syscall site is `syscall_dispatch` at $F226, callable as `jsr syscall_dispatch` with a request-struct pointer in `$02/$03` (ptr1):

```asm
syscall_dispatch:                  ; $F226
            ldy #$17                ; Y = 23 (loop counter)
.copy:      lda (ptr1_lo),y         ; load source[Y] from struct at ($02/$03)
            sta $004E,y             ; store to $004E+Y
            dey
            cpy #$01
            bne .copy               ; loop until Y == 1 (so $004E and $004F are NOT touched)

            lda #$F2                ; push high byte of return addr ($F23C)
            pha
            lda #$3C                ; push low byte
            pha
            php                     ; push P (the PHP pushes with B=1, matching BRK behavior)
            jmp (irq_vector_FFFE)   ; → irq_handler ($C139); B flag set so dispatch path runs

syscall_dispatch_return:           ; $F23C — dispatched routine RTS's here
            nop
            lda brk_scratch_lo      ; copy return values from $66/$67
            sta $08                 ;   to the caller-visible $08/$09
            lda brk_scratch_hi
            sta $09
            rts
```

Six findings packed into this routine:

1. **The 22-byte parameter copy.** $0050-$0065 are filled from `(ptr1),$02..$17`. The struct's bytes 0 and 1 are not used by the dispatcher (they may carry caller-local metadata).
2. **Byte 2 of the struct ($004E+2 = $0050) becomes the task ID** that the IRQ-handler dispatcher at $C139 reads. So a "request" is identified by its byte at offset 2.
3. **The other 21 bytes ($0051-$0065) are syscall arguments.** Each handler reads whichever offsets it needs (e.g., $C39E reads $0052 for the controller index; $C2CB reads $0052/$0054/$0056/$0058/$005A for sprite Y/X/attr/tile/idx).
4. **PHP + JMP($FFFE) fakes a BRK.** PHP pushes P with the B flag set (per 6502 hardware behavior, identical to what BRK pushes). The indirect JMP through $FFFE lands in `irq_handler` ($C139). The handler's B-flag check passes, dispatch proceeds. The mechanism produces a stack frame identical to what `BRK` would have produced — same downstream code path — but is callable from a wrapper function with full control over the setup.
5. **A custom return address is pushed.** `lda #$F2 / pha / lda #$3C / pha` puts $F23C-style return on the stack so the dispatched handler's `RTS` lands in syscall_dispatch_return, not back at the BRK site. This decouples handler return from caller's stack frame.
6. **Return values flow through `$66/$67 → $08/$09`.** The dispatcher pre-clears $66/$67 at $C148, the handler stores its return into $66/$67, and `syscall_dispatch_return` copies to $08/$09 for the actual caller. Two-stage return: kernel-private (66/67) and caller-visible (08/09).

### Why a faked BRK, not a real one?

The mechanism is *bigger* than a real `BRK` — 10 bytes (PHA+PHA+PHP+JMP indirect) per dispatch, plus the 22-byte parameter copy in the wrapper — so it's not a byte-saving trick. The motivation is functional:

- A real `BRK $XX` would push the BRK-site PC as the return address. The dispatched routine would have to manage that. The Nobunaga design pushes a **single, central return PC** ($F23C-1) so the handler's RTS goes to one predictable cleanup site.
- The parameter copy loop runs **outside** the handler, in a callable subroutine. Each syscall site is one `jsr syscall_dispatch`, not 23 bytes of inline setup. Game code stays compact.
- The faked-BRK reuses the *existing* IRQ handler at $C139, which the chip would also enter on a real BRK or hardware IRQ. One handler, three entry mechanisms (real IRQ — but MMC1 has none; real BRK — unused; faked BRK via syscall_dispatch — the path actually taken). Maintenance economy.

## The 23-syscall catalog

All 23 entries are characterized. 16 fired during the captured trace (startup + reset → first-turn UI); the rest were walked statically in the disasm. Each table entry is reached as `JMP $XXXX` at `syscall_dispatch_table + id*3`. (Note: disasm6 emitted the table as raw `hex 4c XX XX` bytes rather than decoded `jmp` instructions, because the only inbound reference is the indirect-JMP-through-$0068 in the IRQ handler — disasm6 couldn't trace through that to discover the table is code-targeted.)

| ID | Target | Name | Function (key params marked struct[N]) |
|---:|---|---|---|
| 0 | $C000 | (reset) | Jumps to `reset_handler`. Probably "soft reboot" / cold-restart syscall; not invoked in our trace |
| 1 | $C264 | `syscall_ppu_upload_block` | Bank-switched bulk copy from PRG → PPU. struct[2]=bank, [4:5]=src ptr, [6:7]=PPU dest, [8]=chunk count (×16 bytes) |
| 2 | $C34B | (unmapped — RTS only) | Single `RTS` at $C34B; placeholder/no-op slot |
| 3 | $C2CB | `syscall_set_sprite` | Write one OAM sprite. struct[2]=idx, [4]=X, [6]=Y, [8]=attr, [a]=tile → OAM shadow at $0600+idx*4 |
| 4 | $C34C | `syscall_palette_write` | Write 1 palette byte. struct[2]=palette idx (0-31), struct[4]=color. Writes to palette_shadow + sets palette_dirty (or to palette_alt if skip_vblank_wait is set) |
| 5 | $C312 | `syscall_fill_nametable` | Fill full 30×32 nametable with one tile byte. struct[2]=name idx, struct[4]=fill byte |
| 6 | $C39E | `syscall_read_controller` | Poll buttons. struct[2]=player idx (0/1). Returns held buttons; side effect: if any button pressed, sets skip_wallclock (game-time pauses while held) |
| 7 | $C339 | `syscall_call_bank` | Save current bank, switch to struct[2], `JSR $8000`, restore. The inter-bank call primitive |
| 8 | $C2F0 | `syscall_fill_attr_quadrant` | Fill 64-byte attribute table quadrant with one constant. PPUADDR = $23C0 + struct[2]*4, fill = struct[4] |
| 9 | $C3AD | `syscall_audio_load_voice` | Set voice config. struct[2]=voice idx, [4]=tempo_div, [6]=song_ptr_lo, [8]=song_ptr_hi → 3 bytes at v0_config + voice*3 ($0725-$0733) |
| 10 | $C3CF | `syscall_audio_control` | Audio control. struct[2]=voice idx, struct[4]=mode: 0 = silence all (clear audio state + APU); 1 = mute triangle for voice; 2 = query mute state |
| 11 | $C427 | (RTS) | Single `RTS` at $C427; another placeholder slot |
| 12 | $C437 | `syscall_ppu_fill_rect` | Constant-tile FILL of an inclusive nametable rect. struct → $52=nametable sel 0-3 ($2000/$2400/$2800/$2C00; wrappers pass 0), $54=left, $56=top, $58=right, $5A=bottom, $5C=fill tile. Writes tile $5C to every cell; PPU addr = $2000 + (sel<<10) + row*32 + col. Enters with mode flag $82=0 (no bank switch); shares the rect loop at $C439 with #20. Tile $01 = blank, so the UI callers use it to CLEAR regions. (Hand-decoded 2026-06-10, see ch.18.) |
| 13 | $C4E0 | `syscall_ppu_render_rect` | 2D nametable region renderer. struct[6/8]=start (x,y), struct[10/12]=end (x,y), struct[14]=per-tile param. For each cell calls three helpers ($C640 addr, $C673 attr, $C711 write). Used for menu borders, status panels — anything with per-tile variation |
| 14 | $C535 | (RTS placeholder) | Single `RTS` byte. Reserved slot |
| 15 | $C536 | (RTS placeholder) | Single `RTS` byte. Reserved slot (sequential to #14 — `60 60` at $C535-$C536) |
| 16 | $C22C | `syscall_memcpy_banked` | Bank-switched general memcpy with 16-bit length. struct[2]=src bank, [4:5]=src ptr, [6:7]=dest ptr, [8:9]=length |
| 17 | $C1C3 | `syscall_rng_next` | 48-bit shift-and-add transform over the wall-clock words ($0083-$0088). Returns a 16-bit value in $66/$67. The game's RNG — and since it churns the wall-clock state, **game-time and the RNG pause together** under `skip_wallclock` ($0089) |
| 18 | $C36C | `syscall_palette_swap` | Atomically swap palette_shadow ($0700-$071F) with palette_alt ($0090-$00AF). Used for fade/transition effects |
| 19 | $C1B8 | `syscall_wait_for_nmi` | Set nmi_busy=1, spin until NMI clears it. The canonical "wait for next VBlank" primitive |
| 20 | $C428 | `syscall_ppu_copy_rect` | Byte-stream COPY into an inclusive nametable rect (same rect math as #12, mode flag $82=1). Saves PRG bank, switches to $5E, copies width*height bytes from the ($5C/$5D) source pointer (post-incremented, row-major) into the rect, restores bank. struct → $52=nt sel, $54=left, $56=top, $58=right, $5A=bottom, $5C/$5D=src ptr, $5E=src bank. Proof: $E621 copies a 28×16 = 0x1C0 B strategic-map section. The workhorse for screen content (menus, maps, portraits). (Hand-decoded 2026-06-10, see ch.18.) |
| 21 | $C60C | `syscall_set_chr_bank0_reg` | Write 5-bit value (struct[2]) to MMC1 CHR-bank-0 register at $BFFF. On SOROM, bit 4 is the WRAM-enable gate — this is the bracket call that opens/closes SRAM access around save I/O |
| 22 | $C5AA | `syscall_sram_block_with_checksum` | SRAM block read/write with 16-bit checksum. Toggles MMC1 WRAM gate via $BFFF writes, copies a block via $0200 buffer in two passes, accumulates a 16-bit checksum into $66/$67. The save-data I/O primitive |

**All 23 dispatch slots characterized.** Final tally: **19 active syscalls + 4 RTS placeholders** (IDs 2, 11, 14, 15) **+ 1 reset-entry slot** (ID 0). The 4 placeholders are not at the end of the table — they sit at specific positions interleaved with active handlers. This is consistent with the table being a **generic Koei kernel surface** that defines a fixed set of syscall slots; Nobunaga's Ambition uses 19 of them and leaves the others as `RTS` no-ops. Other Koei MMC1 titles likely populate the remaining slots with their own game-specific primitives — an obvious cross-game investigation if a future chapter wants to confirm.

### Call frequency tells the role

The dispatch event log shows striking concentration:

| Task | Events | % | Why |
|---|---:|---:|---|
| **$06** read_controller | 6342 | **92.2%** | Polled in every menu-wait loop, every prompt, every UI tick. The game spends most of its CPU waiting on input |
| $11 rng_next | 130 | 1.9% | Used wherever randomness is needed; consistent low-grade demand |
| $14 ppu_copy_rect | 122 | 1.8% | Screen content rendering — menus, prompts, map updates |
| $03 set_sprite | 81 | 1.2% | OAM updates for cursors, animation, UI sprites |
| $04 palette_write | 78 | 1.1% | Color changes — title-screen palette load, menu highlights |
| Others | 127 | 1.8% | Boot one-shots + low-frequency game state |

The hottest 4 syscalls together account for **97.0%** of all dispatch traffic. Game logic spends almost all its kernel-call time on input polling, with PPU updates and RNG distantly trailing.

## Helper functions worth naming

While walking the handlers, several internal helpers were identified:

- **`set_prg_bank` ($C577)** — the MMC1 bank-switch helper. Saves NMI state, writes the 5-bit serial sequence to $FFF0 (the MMC1 PRG bank register), updates `prg_bank_shadow` ($0073, the current-bank tracker), restores NMI state. Called by every bank-switching syscall. The "BRK + 5×STA $FFF0 + restore" sequence is canonical MMC1 bank-switching with NMI-safe wrappers around it.

- **`mul_xy_by_3` ($C6AD)** — same routine the IRQ handler uses to scale a task ID by 3 (the table stride). Reused inside handlers for similar small-N multiplications.

## Three structural insights this chapter establishes

1. **The syscall API is the boundary between bank 15 and the rest of the ROM.** Game code in banks 0-14 cannot directly touch palette state, OAM, controllers, audio, or PPU — those are all kernel-managed. The only way through is `jsr syscall_dispatch`. This is OS-style separation between user code and kernel services, in 1989, on a cartridge.

2. **The hottest syscall is input polling, by an enormous margin.** ~200 input polls per second, 92% of all kernel-call traffic. This is the signature of a turn-based strategy game: the CPU is mostly waiting for the player to do something. Combat phases (when surfaced in later chapters) will show different patterns.

3. **The dispatch event log + the call-site struct addresses are an inventory of game-code intentions.** Each invocation of `syscall_dispatch` with struct base $05XX corresponds to a specific request template in main RAM. Cataloging those templates would surface the **set of syscall sequences** the game uses — which syscall combinations form a "draw a menu" or "play a sound effect" idiom. That's a chapter 5+ direction.

## What's open

- **The static request templates** at $05B2, $05B4, $05BF, $05C7, $05CB, etc. carry the syscall arguments game code reuses. Walking the 22-byte content of each tells us what each "macro" does (e.g. the template behind the main-map prompt).
- **Cross-game kernel comparison.** Other Koei MMC1 titles (Romance of the Three Kingdoms, Genghis Khan, Bandit Kings of Ancient China) likely share this dispatcher and fill the 4 placeholder slots with their own primitives — a short investigation could confirm the "generic Koei kernel" hypothesis.
- **disasm6 code/data misreads.** The dispatch table itself renders as `hex 4c XX XX` (it's reached only via the indirect JMP, so disasm6 can't tell it's code-targeted), and the same happens wherever the only inbound reference is indirect. Where disasm6 emits `hex` and a trace shows execution, the bytes are code — worth a split (as done for `music_driver` at $C7A5).

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
