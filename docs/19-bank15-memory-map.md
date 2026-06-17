---
status: active
created: 2026-06-10
layout: default
title: "Chapter 19 \u2014 Bank 15: The Layered Map (Firmware, BIOS, Interpreter, and the Bytecode Band)"
---
# Chapter 19 — Bank 15: The Layered Map (Firmware, BIOS, Interpreter, and the Bytecode Band)

> Bank 15 is the **fixed bank** — the only 16 KB always visible at `$C000–$FFFF` while banks 0–14 page through `$8000–$BFFF`. It is easy to think of it as "the code bank," but it is not one thing: it is a **stack of architectural layers**, each a different kind of code with a different notion of done. From the bottom: the CPU-vector firmware, the BIOS syscall surface, the native kernel/global helpers, the VM interpreter and its 32-bit ALU — and, sitting *on top of* all that native machinery, a contiguous band of **VM bytecode** that is the actual game. This chapter is the memory map that separates those layers, with the hard native↔bytecode boundary measured rather than guessed. The punchline for the grounding pass: every layer of Bank 15 is now ground-truthed — the native floor (firmware, BIOS, kernel, interpreter, ALU) and the one bytecode band on top of it alike.

**Links:** [Chapter 1 — Boot & the BRK Dispatcher](./01-boot-and-dispatch.md) · [Chapter 4 — Syscall API](./04-syscall-api.md) · [Chapter 5 — The Bytecode VM](./05-bytecode-vm.md) · [Chapter 8 — VM Instruction Set](./08-vm-instruction-set.md) · [Nobunaga README](./README.md)

## The map

```
addr     layer                                            kind      ground-0 means…           status
──────────────────────────────────────────────────────────────────────────────────────────────────
$C000   ┌ RESET init / boot                               native    the vectors resolve        ✅ ch.01
$C0DA   │ NMI handler  (vblank: OAM, palette, scroll)     native      to real handlers         ✅ ch.01/03
$C139   │ IRQ + BRK dispatcher   (23-entry table @ $C173) native                               ✅ ch.01
        ╞═ FIRMWARE / CPU-vector floor ═══════════════════════════
$C1B8   ┌ 23 SYSCALL handlers ($C1B8…$C60C, scattered)    native    23 handlers named          ✅ ch.04
$C537   │ native PPU/system helpers the syscalls call:    native    the leaf helpers           ✅ (20)
        │   wait_vblank, set_prg_bank, screen/render        │         named
        │   gates, controller_poll, mul, palette_upload
        ╞═ BIOS + KERNEL — the "OS" the bytecode sits on ═════════
$C7C9   ┌ MUSIC engine (15 subs: voice/note/stream)       native    the subsystem named        ✅ (15)
        ╞═ global helper subsystem ═══════════════════════════════
$CA03   ┌ VM BYTECODE application routines                bytecode  the 135 game subs       ✅ (135)
$E80C   └   (135 subs: AI, combat, province, save/load)              named & correct
        ╞═ the "PROGRAM" — the application layer ═════════════════
$E823   ┌ VM INTERPRETER: vm_entry → vm_dispatch ($E867)  native    engine + opcode            ✅ ch.05
        │   fetch-decode-execute; opcode handlers;           │        handlers named
        │   vm_fetch_*/vm_pop_operand/vm_call_native;
        │   udiv16 / sdiv16
$F026   │ opcode dispatch tables (lo $F026 / hi $F126)    data                                 ✅ ch.05
$F226   │ VM↔syscall dispatch region                      data                                 ✅
$F2FE   │ VM 32-bit math + bitfield ALU:                  native    the bignum ops             ✅
        │   sdiv32/udiv32/cmp32/negate32/                    │        named
        │   bitfield read-write/make_bitmask
        ╞═ interpreter engine + its bignum ALU ═══════════════════
$FFFA   └ hardware vectors → $C0DA / $C000 / $C139        data                                 ✅ ch.01
```

## The layers, bottom-up

Each layer is a different kind of artifact and grounds against a different authority. Reading them low-to-high is the project's recurring discipline (a layer is only nameable once the layer beneath it is) — and it is why Bank 15 must be done before chasing high-fanout callers elsewhere.

1. **Firmware floor — `$C000–$C172`.** The three 6502 entry points the silicon jumps to: `RESET` ($C000, the boot/init), `NMI` ($C0DA, the vblank pipeline — chapter 3), and `IRQ` ($C139), which immediately tests for `BRK`. *Ground 0 here = the vector table at `$FFFA–$FFFF` points at real, decoded handlers.* Done (chapter 1).

2. **BIOS — the syscall surface, `$C1B8–$C60C`.** `BRK` is the game's syscall instruction (one byte vs JSR's three). The IRQ handler's BRK path reads the 23-entry dispatch table at `$C173` and routes to one of 23 handlers, **all of which land inside Bank 15** — this is a kernel-level scheduler, not a user coroutine system. *Ground 0 = all 23 handlers named and their struct arguments mapped.* Done (chapter 4; the two `ppu_fill_rect`/`ppu_copy_rect` blits and `ppu_render_rect` were the last to get full arg-maps — chapter 18).

3. **Kernel / global helpers — `$C537–$C990`.** The native leaf routines the syscalls and the interpreter call: PPU gates (`screen_on`, `rendering_on`, `ppu_safe_gate`), `wait_vblank`, `set_prg_bank`, `controller_poll`, `palette_upload`, the `mul_xy` multiply, and the 15-sub **music engine** (`$C7C9–$C990`). *Ground 0 = every jsr-reached native leaf named.* Done — see "The boundary, measured" below.

4. **The bytecode application band — `$CA03–$E80C`.** This is the game: 135 VM subroutines (daimyo AI, combat resolution, province management, save/load, the menu/command system). It is **bytecode, not 6502** — it happens to live in the fixed bank, but it is interpreted, not executed. *Ground 0 here = the 135 subs read correctly and are named for behavior.* Done — all 135 read-verified and behavior-named, **0 address-suffixed suspects remaining** (closed out 2026-06-10; see `grounding.md`).

5. **The VM interpreter — `$E823–$F1xx`.** The native engine that runs layer 4. `vm_entry` ($E823) sets up the VM frame; `vm_dispatch` ($E867) is the fetch-decode-execute loop: read a bytecode byte, index the two 256-byte handler-address tables at `$F026` (lo) / `$F126` (hi), `jmp` to the handler. Helpers (`vm_fetch_*`, `vm_pop_operand16`, `vm_call_native`, `udiv16`/`sdiv16`) round it out. *Ground 0 = the dispatch loop, the opcode tables, and the host-call bridge decoded.* Done (chapter 5).

6. **The 32-bit ALU — `$F2FE–$F669`.** The interpreter is a soft 16-bit machine, but the game needs wider math (the `0x01C0` strides, the damage formula). This native library gives it `sdiv32`/`udiv32`, `cmp32`, `negate32`, and the bitfield read/write + `make_bitmask` primitives. *Ground 0 = the bignum ops named.* Done.

## The boundary, measured

The native↔bytecode split is not a guess — it falls straight out of two sources that disagree by construction, which is what makes the cut sharp:

- **VM subs** = the function definitions the decompiler emits in `source/4-c/bank_15.c`. The decompiler only claims *bytecode*, so its sub list **is** the authoritative bytecode set: exactly **135 subs, `$CA03–$E80C`** — a single contiguous band.
- **Native subs** = `jsr`-reached entries from `native-call-index`, minus the VM set: exactly **50 pure-native subroutines, and all 50 are grounded.** They cluster perfectly by address into the layers above (kernel `$C5–$C7`, music `$C7–$C9`, interpreter `$E8–$EF`, ALU `$F2–$F6`).

Two cautions this exercise surfaced, both worth keeping in mind when reading any Bank-15 tool output:

- **Disassembling the whole bank as 6502 lies.** `native-call-index` runs a flat 6502 pass, so the bytecode band ($CA03–$E80C) and stray data get mis-parsed into phantom "native subs," and intra-routine *branch targets* (e.g. `$C439`, `$C47D` inside `ppu_fill_rect`) look like sub entries. Filter to **`jsr`-reached** entries to recover the real subroutine list; everything else is noise.
- **The interpreter is the floor under the bytecode, but cross-bank calls reach below the graph.** The call graph spans only banks 0/1/2/15. A bytecode sub at the top of the band (`$E80C`) that does `call_bank_wrap(14)` looks like a leaf to a graph that cannot see bank 14 — it is not. Depth-0 in the cursor is *necessary, not sufficient*; the human ledger overrides.

### Reproduce

```
cd nobunaga/tools
py -3 label-walk-prep.py 15 --grounding        # walk the layer-4 bytecode band, leaves-first (now 0 suspects)
py -3 native-call-index.py callers $ADDR        # who calls a sub (kind = jsr / branch / host_call)
```

## Done

Every layer of Bank 15 is ground-truthed. The native floor — firmware, BIOS, kernel helpers, music, interpreter, ALU — was settled by the boundary measurement above; **layer 4, the bytecode band `$CA03–$E80C`, closed out on 2026-06-10** when the final 7 leaves were named (the last batch: `$CA97 fill_bytes`, `$CCBA clear_rect_lower_right`, `$D7F7 clear_econ_stats_if_no_output`, `$D815 clear_military_stats_if_no_men`, `$DA24 scaled_force_transfer`, `$DE78 select_uprising_message`, `$E4DC build_fiefs_excluding_daimyo`). All 135 subs read-verified and behavior-named — **0 todo, 0 suspects, 0 address-tagged stubs** (confirmed by both the cursor and a direct `^word *_XXXX(` definition count of zero in `source/4-c/bank_15.c`). With Bank 15 closed, there is no un-grounded layer left in the fixed bank.

### The cross-bank inventory (what runs where)

`call_bank` (syscall 7) does a literal `JSR` to any bank's `$8000`, where a tiny native stub (`JMP …; JSR $E823 vm_entry`) hands off to that bank's bytecode. Scanning every bank for that bootstrap settles the whole-ROM code map:

| Banks | Contents |
|---|---|
| **15** | native firmware / BIOS / interpreter / ALU (this chapter) |
| **0, 1, 2** | bytecode — the bulk of the game (491 subs) |
| **10** | bytecode — the audio/SFX trigger (`play_audio_by_id`, 1 sub) |
| **14** | bytecode — the **AI-turn cutscene engine** (`run_cutscene` + 2 helpers, 3 subs) |
| **3–9, 11–13** | **pure data** — graphics, tilemaps, tables (no executable code) |

So the code-bearing banks are **0, 1, 2, 10, 14** (bytecode) **+ 15** (native) — six in total; the other ten are data. Banks 10 and 14 were folded into the decompiler corpus on 2026-06-10 (they had been missed by an `CODE_BANKS = [0,1,2,15]` that wrongly assumed "the rest are data"); the trigger that exposed them was `$E80C trigger_cutscene`, whose `call_bank_wrap(14)` reached a subsystem the corpus had never decompiled. With those in, the corpus is **499 subs across all six code banks**, and the frontier is the bytecode itself — there is no undiscovered native or bytecode bank left to find.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
