---
status: active
created: 2026-05-11
---
# Chapter 2 — Zero-Page Memory Map
> 256 bytes of fast RAM, every byte counts. The grounded zero-page map: the shared scratch pointer, the bytecode VM's register file, the kernel's flags and wall-clocks, and the first concrete instances of **byte-meaning-by-context**. Names below are the labels in `mesen-labels.toml`.

**Links:** [Chapter 1 — Boot & Dispatch](./01-boot-and-dispatch.md) · [Chapter 5 — Bytecode VM](./05-bytecode-vm.md) · [Mappy Ch 2 — Object records & states](../mappy/02-object-records-and-states.md) (the byte-meaning-by-context precedent) · [Nobunaga README](./README.md)

## The constraint

The NES has exactly **256 bytes of zero-page RAM** at $0000–$00FF. Zero-page addressing is **2 cycles faster and 1 byte shorter** than absolute, so any value touched in an inner loop wants to live there. For a 256 KB strategy engine fitting dozens of subsystems (combat, AI, dialog, menus, save state, map rendering) into 2 KB of total RAM, the ZP allocation is a designed thing — and its busiest block is the one the bytecode interpreter pounds on every opcode.

## $00–$0F — scratch pointer + the VM register file

This is the busiest RAM in the ROM, and the reason is the VM: `$00/$01` is a general scratch pointer, and **`$02–$07` are the bytecode interpreter's three core registers** (ch.5), hammered by the dispatch loop every instruction.

| Addr | Label | Role |
|------|-------|------|
| $00/$01 | `scratch_ptr` | general-purpose ZP indirect pointer — the project-wide default (13 of 16 banks touch it); in the VM also the computed-address / indirect-call target |
| $02/$03 | `vm_sp` | VM operand-stack pointer. Reset-inits to `$05FF` (stack base); frame alloc does `vm_sp -= 9`; `syscall_dispatch` reads params via `(vm_sp),Y` |
| $04/$05 | `vm_fp` | VM frame-base pointer. A frame-local address is `vm_fp + signed offset` (the local/arg access base) |
| $06/$07 | `vm_ip` | VM bytecode instruction pointer. The dispatch loop does `lda (vm_ip),Y / inc vm_ip` to fetch opcodes + inline operands — the second-busiest indirect after `scratch_ptr` |
| $08–$0F | — | indexed scratch / syscall return slots (`,x`/`,y`-dominant) |

So `$00–$07` is the general scratch pointer plus the entire interpreter register file, and the striking access volume is simply the VM dispatch loop running. A handful of kernel syscalls (e.g. the SRAM checksum at `$C5AA`) transiently borrow `$02/$03` as a scratch pointer — see the caveat in the TOML — but the convention holds because this block **is** the VM.

## $1C–$1F — PPU upload queues

Initialized by the reset handler (`$C086–$C094`) to point into main RAM:

| Addr | Label | Points at |
|------|-------|-----------|
| $1C/$1D | `ppu_queue_a` | $0020 |
| $1E/$1F | `ppu_queue_b` | $0030 |

Deferred tile/palette/nametable bytes staged here are drained to the PPU on the next NMI (the queue *drain* plumbing is ch.3).

## $50, $66–$69 — IRQ / syscall dispatcher state

| Addr | Label | Role |
|------|-------|------|
| $50 | `brk_dispatch_id` | task ID for the next syscall; the IRQ handler reads it and indirect-JMPs through `$C173 + id*3` |
| $66/$67 | `brk_scratch` | cleared on every dispatch entry |
| $68/$69 | `brk_jmp_target` | the IRQ-computed indirect-JMP target — and a **byte-meaning-by-context** slot (below) |

## $6E–$7B — controllers, PPU shadows, music

| Addr | Label | Role |
|------|-------|------|
| $6E/$6F | `p1_buttons` / `p2_buttons` | held buttons (ABSS UDLR, MSB-first), written by `controller_poll` every NMI |
| $71 | `ppuctrl_shadow` | PPUCTRL ($2000) mirror — the code never reads $2000 directly; `nmi_off`/`nmi_on` flip bit 7 here |
| $72 | `ppumask_shadow` | PPUMASK ($2001) mirror; `rendering_on`/`rendering_off` flip the render bits here |
| $73 | `prg_bank_shadow` | current PRG bank in the $8000-$BFFF window; `set_prg_bank` compares/updates it, and the banked syscalls save/restore it around a switch |
| $74 | `palette_dirty` | non-zero ⇒ a palette upload is pending; `palette_upload` pushes `palette_shadow` → PPU $3F00 next NMI, then clears it |
| $79 | `music_voice_idx` | outer-loop voice index (0–4) during the music driver scan |
| $7A/$7B | `music_ptr` | pointer into the current voice record at `$0734 + N*9` (the `v0_trigger` voice array, ch.1) |

## $80–$B0 — kernel flags + wall-clocks

| Addr | Label | Role |
|------|-------|------|
| $80 | `skip_vblank_wait` | non-zero ⇒ `wait_vblank` returns immediately (boot/long ops bypass the spin) |
| $81 | `nmi_busy` | the "wait for VBlank" handshake — foreground sets it to 1 and spin-waits for the NMI to clear it |
| $83/$84 | `clock_a` | 16-bit wall-clock A (hi/lo); NMI adds +2 every frame, gated by `skip_wallclock`. Reset = `$04D2` (1234) |
| $85/$86 | `clock_b` | 16-bit wall-clock B; same cadence and seed |
| $89 | `skip_wallclock` | non-zero ⇒ NMI runs OAM/audio/input but freezes game-time |
| $B0 | `nmi_skip_all` | non-zero ⇒ NMI bails right after OAM DMA (still pushes sprites; skips controller/palette/audio/clock) |

## $90–$AF — `palette_alt`

The reset handler fills these 32 bytes (and `palette_shadow` at $0700–$071F) with `$3E`, a neutral grey. They are the two **palette buffers**: `palette_shadow` is the live palette uploaded each frame; `palette_alt` is the swap target that `palette_swap` (syscall $12) exchanges with it atomically for **fade / transition effects**.

## Byte-meaning-by-context — two kernel cases

The same RAM serving different contracts depending on which subsystem is active. Mappy chapter 2 named this pattern; here it appears at the kernel level, and the per-subsystem chapters find more.

1. **`$68/$69` (`brk_jmp_target`) — dispatch target ↔ data pointer.** In the IRQ handler these bytes hold the address of the next dispatched task; the handler builds it from `($73 + Y, $C1 + X)` and indirect-jumps through it. Once that JMP fires, the dispatcher's contract is over, and a routine at `$C29F` reuses the same bytes as a generic `lda ($68),y` data pointer. Safe because no path can reach `$C29F` while the dispatcher is mid-build — two named pointer slots for the cost of one in ZP.
2. **`$83–$86` (`clock_a`/`clock_b`) — timer pair ↔ indexed record.** The NMI treats these as two independent 16-bit counters (each += 2 per frame). A routine at `$C1F3` reads the same four bytes as an X-indexed snapshot (`lda $0083,x`) — the live counters *are* the readable register, so the kernel spends no dedicated "current reading" scratch. The two roles coexist: the indexed read doesn't disturb the counters.

## Still unmapped

Most ZP outside the kernel block is per-subsystem scratch, named in the chapter that owns each subsystem (combat, AI, menus). A few kernel-internal bytes — notably `$AA`, `$CF`, `$D7` — are touched often enough to matter but not yet tied to a routine; a focused trace or a Mesen access-breakpoint run names them.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
