---
status: active
created: 2026-05-11
---
# Chapter 2 — Zero-Page Memory Map
> 256 bytes of fast RAM, every byte counts. The first ZP map for the project — built by harvesting writes/reads across the full 16-bank disassembly. Confirms what chapter 1 saw, identifies the shared-scratch-pointer pool, and finds the first concrete instances of byte-meaning-by-context.

> **⚠ Pass-2 fact-check (2026-06-11).** This static-only session-1 map predates the VM decode; the labels are now grounded. **Headline correction:** `$02–$07` are the **VM's core registers** (`vm_sp`/`vm_fp`/`vm_ip`) — the bytecode interpreter's state (ch.5) — not generic "subroutine-local pointers." The two **byte-meaning-by-context** findings (`$68/$69`, `$83-$86`) are **confirmed**. Settled statically since: `$1C–$1F → $0020/$0030` are the **PPU upload queues** (confirmed); `$0090–$00AF` is **`palette_alt`** (the fade/swap buffer paired with `palette_shadow $0700–$071F`) — *not* an attribute table; `$74 = palette_dirty`; `$80 = skip_vblank_wait`; `$7A = the music driver's voice pointer`.

**Links:** [Chapter 1 — Boot & Dispatch](./01-boot-and-dispatch.md) · [Mappy Ch 2 — Object records & states](../mappy/02-object-records-and-states.md) (the byte-meaning-by-context precedent) · [Nobunaga README](./README.md)

## The constraint

The NES has exactly **256 bytes of zero-page RAM** at $0000-$00FF. Zero-page addressing on the 6502 is **2 cycles faster and 1 byte shorter** than absolute addressing, so any value touched in the inner loop wants to live there. For a 256 KB strategy engine that has to fit dozens of subsystems (combat, AI, dialog, menus, save state, map rendering) into 2 KB of total RAM, the ZP allocation is a designed thing — not just whatever fell on the floor first.

What we expect to find (from prior projects):
- **Pointer-pair scratch pool** at the bottom — pairs at $00/$01, $02/$03, etc., used as indirect pointers (`lda ($XX),y`)
- **NMI/IRQ-driven state flags** above the pointer pool
- **Game-clock and engine-tick counters** clustered together
- **Byte-meaning-by-context** — the same byte serving different roles depending on which subsystem is active. Mappy chapter 2 named this pattern; Nobunaga's strategy engine has 64× more code competing for the same 256 bytes, so it should be more aggressive here.

## How this map was built

After session 1, disasm6 produced 16 per-bank `.asm` files. A Python pass over all of them tallied every ZP read, write, RMW, indirect-mode, and indexed-mode access. Bank 15 (the kernel) provided most of the context for *what* each address means; the per-bank access counts revealed *which* addresses are shared across the codebase versus subsystem-local.

The map below is **static-only**. Some semantics — especially "which game mode is each scratch byte assigned to" — will only be settled with runtime correlation in Mesen.

## The map ($0000-$00FF)

### Shared scratch pointer pool — $00 to $0F

This is the busy block. Every subsystem borrows from here when it needs a temporary 16-bit indirect pointer.

| Addr | Total accesses | Banks touching | Primary use |
|------|---------------:|----------------|-------------|
| $00  | 173 (83 ind, 99 idx) | 13 of 16 | **General scratch pointer low** — most-used ZP location in the entire ROM |
| $01  | 68 (15 ind, 17 idx) | 10 banks | **General scratch pointer high** — companion to $00 |
| $02  | 52 (14 ind, 19 idx) | 11 banks | Pointer pair low — **init'd to $FF at reset**, `$02/$03` form pointer $05FF |
| $03  | 15 | 3 banks | Pointer pair high — init'd to $05 at reset |
| $04  | 29 (13 ind) | 7 banks | Pointer pair low — heavy `lda ($04),y` use |
| $05  | 14 | 4 banks | Pointer pair high |
| $06  | 56 (25 ind) | 5 banks | Pointer pair low — second-busiest indirect pair after $00/$01 |
| $07  | 27 (2 ind) | 4 banks | Pointer pair high |
| $08  | 159 (7 ind, 25 idx) | 5 banks | **Indexed-table base** — `sta $08,y` pattern is very common |
| $09  | 122 (1 ind, 1 idx) | 4 banks | Companion register |
| $0A  | 50 (10 ind, 14 idx) | 8 banks | Mixed-mode scratch |
| $0B  | 22 | 2 banks | Companion |
| $0C  | 71 (11 ind, 25 idx) | 4 banks | Indexed scratch |
| $0D  | 44 | 3 banks | Companion |
| $0E  | 8 | 4 banks | Sparse use |
| $0F  | (rare) | — | Likely free / boundary |

**Reading [CORRECTED 2026-06-11]:** $00/$01 is the project-wide general scratch pointer (`scratch_ptr`, 13 of 16 banks) — that holds. But **$02–$07 are not "subroutine-local pointers"; they are the VM's three core registers**, which is *why* this block is the busiest RAM in the ROM:
- **$02/$03 = `vm_sp`** — VM operand-stack pointer (reset-init $FF → `$05FF` stack base; frame alloc does `vm_sp -= 9`; `syscall_dispatch` reads params via `(vm_sp),Y`).
- **$04/$05 = `vm_fp`** — VM frame-base pointer (frame-local address = `vm_fp + signed offset` — the local/arg access base).
- **$06/$07 = `vm_ip`** — VM bytecode instruction pointer (the dispatch loop does `lda (vm_ip),Y / inc vm_ip` to fetch opcodes + inline operands; "second-busiest indirect," which session 1 noticed without knowing why).

So $00-$07 is *the general scratch pointer + the entire interpreter register file*, and the striking access volume is the VM dispatch loop pounding `vm_ip`/`vm_sp` on every opcode (ch.5). $08-$0F remain indexed scratch / syscall return slots (`,x`/`,y` dominant). The convention is enforced project-wide because it **is** the VM.

### NMI/PPU pipeline pointers — $1C to $1F

Initialized by the reset handler (chapter 1, $C086-$C094):

| Addr | Init value | Role |
|------|-----------|------|
| $1C  | $20 | Pointer low → forms `$1C/$1D = $0020` |
| $1D  | $00 | Pointer high |
| $1E  | $30 | Pointer low → forms `$1E/$1F = $0030` |
| $1F  | $00 | Pointer high |

These point into $0020 and $0030 in main RAM. **[CONFIRMED 2026-06-11]** grounded as `ppu_queue_a` ($1C/$1D → $0020) and `ppu_queue_b` ($1E/$1F → $0030) — the PPU upload queues (deferred tile/palette/nametable bytes drained next NMI), exactly the session-1 guess. *(Correction: the NMI's `JSR $C54F` is `nmi_off` — a re-entrancy guard that brackets the frame with `nmi_on $C68A` — not the queue-drainer. Chapter 3 follows the queue plumbing.)*

### IRQ / BRK dispatcher state — $50, $66-$69

| Addr | Role | First witnessed at |
|------|------|--------------------|
| $50  | **BRK dispatch index** — task ID to run when next BRK fires | `b15_c154: ldx $50` (the IRQ handler reads it) |
| $66  | IRQ scratch — cleared on every BRK dispatch entry | `b15_c148: sta $66` (zeroed by handler) |
| $67  | IRQ scratch — cleared on every BRK dispatch entry | `b15_c14b: sta $67` |
| $68  | IRQ-computed JMP target low *(also: general indirect pointer low)* | `b15_c160: sta $68` |
| $69  | IRQ-computed JMP target high *(also: general indirect pointer high)* | `b15_c163: sta $69` |

**First concrete byte-meaning-by-context:** $68/$69 has two distinct contracts depending on who's touching it:

1. **In the IRQ handler:** $68/$69 holds the address of the next dispatched task. The handler builds it from `($73 + Y, $C1 + X)` and indirect-jumps through it. Once the JMP executes, the dispatcher's contract with $68/$69 is over.
2. **In a subroutine at $C29F:** `lda ($68),y` — the same bytes are reused as a generic indirect data pointer. By the time $C29F runs, the BRK dispatch is already in flight or finished, so $68/$69 is "free real estate."

Aggressive but safe: no path can call $C29F while the IRQ dispatcher is mid-build, so the reuse doesn't race. The cost is that any reader has to know which contract is active. The benefit is two named pointer slots costing one in actual ZP.

### Reset-init kernel state — $73, $74, $80, $81, $83-$86, $89, $B0

These are the named kernel flags / counters from chapter 1, now annotated with where else they're read or written.

| Addr | Init | Role | Notable later writers/readers |
|------|------|------|-------------------------------|
| $71  | — | **`ppuctrl_shadow`** — PPUCTRL ($2000) shadow; the code never reads $2000 directly (`nmi_off $C54F` / `nmi_on $C68A` flip bit 7 here) | [grounded 2026-06-11] |
| $72  | — | **`ppumask_shadow`** — PPUMASK ($2001) shadow (`rendering_on $C567` / `rendering_off $C69D`) | [grounded 2026-06-11] |
| $73  | $00 | `kernel_var_73` — cleared at reset; used by `mul_xy_by_3 $C6AD` | Read during dispatch math |
| $74  | $FF | **`palette_dirty`** — non-zero = palette upload pending; `palette_upload $C6D4` uploads `$0700-$071F` → PPU $3F00 next NMI, then clears it (reset-init $FF forces a first-frame upload) | [grounded 2026-06-11] |
| $80  | $00 | **`skip_vblank_wait`** — non-zero = `wait_vblank $C537` returns immediately without spinning (lets boot/long ops bypass the VBlank wait) | [grounded 2026-06-11] |
| $81  | $00 | **NMI busy semaphore.** Mainline sets to 1 then spin-waits for NMI to clear it | Loop pattern at `b15_c1bd` reads $81 |
| $83  | $04 | Timer pair 1 hi | See note below — also accessed indexed as $83+X |
| $84  | $D2 | Timer pair 1 lo (NMI adds +2 every frame, gated by $89) | |
| $85  | $04 | Timer pair 2 hi | |
| $86  | $D2 | Timer pair 2 lo (NMI adds +2 every frame, gated by $89) | |
| $89  | $00 | NMI timer-skip flag — when set, NMI does OAM/audio/controllers but doesn't tick the wall clock | Written elsewhere to pause the game-clock |
| $B0  | $00 | NMI skip-all flag — when set, NMI bails after OAM DMA (still pushes OAM but skips everything else) | Likely set during long PPU updates or menu transitions |

**Second byte-meaning-by-context: $83-$86 as either 2× 16-bit timers OR a 4-byte indexed record.**

- In the NMI handler (chapter 1, $C109-$C12A), $83/$84 and $85/$86 are treated as two independent 16-bit counters, each += 2 per frame.
- At `b15_c1f3` we see `lda $0083,x` — the same 4 bytes are accessed as an X-indexed record. The reading routine doesn't care that the bytes also happen to be valid 16-bit-pair timer values; it's just reading byte $83+X for some external selector.

The two readings aren't contradictory — they're complementary. **The same bytes serve both roles simultaneously.** The X-indexed access at $C1F3 doesn't disturb the timer values; it just reads them as a four-element snapshot. This is the design move that lets the kernel save 4 bytes of dedicated "current timer reading" scratch — the existing live counters *are* the readable register file.

### Palette buffers — $90 to $AF (+ $0700-$071F) [RESOLVED 2026-06-11]

The reset handler ($C05A-$C067) fills these 32 bytes with `$3E`, and does the same at $0700-$071F. Grounded: these are the two **palette buffers**, not an attribute table:
- **$0700-$071F = `palette_shadow`** — the live 32-byte palette. Foreground writes here + sets `palette_dirty $74`; `palette_upload $C6D4` DMAs it to PPU $3F00-$3F1F next NMI.
- **$0090-$00AF = `palette_alt`** — a 32-byte alternate palette that `palette_swap ($C36C, syscall $12)` atomically swaps with `palette_shadow` for **fade / transition effects**.

The `$3E` fill is just a neutral default palette entry. So the session-1 "attribute table buffer?" guess is **refuted** (these are palettes), and the "hot ZP shadow of a main-RAM master" framing is refined: not a hot/cold copy of one buffer but the **live palette and its swap target**. (Resolves the open question below.)

### Untracked regions ($10-$1B, $20-$4F minus $50, $51-$65, $6A-$72, $75-$7F minus key locations, $87-$88, $8A-$8F, $A0-$AF partial, $B1-$FF)

These show sporadic usage in the access stats — some quite heavy (e.g., $7A has 34 accesses, all in bank 15, 30 of them indirect — clearly a kernel-internal scratch pointer). Naming them requires either deeper trace work or runtime observation.

What we know from the access stats:
- **$7A/$7B = `music_ptr`** [grounded 2026-06-11] — the music driver's pointer into the current voice record at `$0734+N*9` (with `$79 = music_voice_idx`). Bank-15-only because it *is* the kernel music engine — ties to the `$0734` voice-state array (ch.1's `$0734` correction). The session-1 "kernel scratch, never escapes" read was directionally right; it's specifically the audio driver's record pointer.
- **$AA** is hit 14 times in 3 banks (7, 8, 13), mostly indexed — likely a multi-bank coordinated register
- **$D7** is RMW-heavy (11 RMWs) — a counter that decrements (the `dec $d7` pattern dominates)
- **$CF** has 23 reads but 0 writes in the disassembled code — likely written via indexed addressing we'd need to grep more carefully to catch, OR it's a constant table set up elsewhere

## Patterns confirmed

1. **Shared scratch pointer pool at $00-$0F.** $00/$01 is the project-wide default; $02-$07 are subroutine-local pointer pairs; $08-$0F is indexed-temp register space. 13 of 16 banks touch $00 — this is a hard convention.
2. **Byte-meaning-by-context** at $68/$69 (IRQ target ↔ data pointer) and $83-$86 (timer pair ↔ indexed register). The Mappy pattern shows up at the kernel level — and it's likely we'll find more instances in the per-subsystem chapters.
3. **Parallel buffers** at $0090-$00AF (ZP) and $0700-$071F (main RAM), both filled with $3E at reset. Hot-cold buffer pattern.
4. **Init constants double as data.** The timer counters start at $04D2 = 1234 decimal. That's not random — likely a calibration value or a deliberate starting offset. Worth keeping in mind when we hit AI tick rates.

## Open questions for runtime correlation

| Question | How to answer in Mesen |
|----------|------------------------|
| What writes to $90-$AF after reset? | Mem-write breakpoint on $0090-$00AF, play normally |
| Who writes $50 (sets the BRK dispatch ID)? | Mem-write breakpoint on $0050, trigger menu actions |
| Where is $20 / $30 (the targets of the $1C-$1F pointers) updated? | Mem-write breakpoint on $0020 and $0030 |
| Does $B0 actually skip the NMI body, or is it gating something else? | Set $B0=1 via debugger mid-game, observe |
| Is $7A really kernel-local, or does some bank reach it indirectly? | Mem-access breakpoint on $7A, run gameplay |

> **[Pass-2, 2026-06-11]** Three of the runtime questions above are now answered statically from the grounded labels: **$90-$AF** = `palette_alt` (written by `palette_swap`), **$B0** = `nmi_skip_all` (does gate the NMI body), **$7A** = `music_ptr` (kernel-local, the audio driver). The $50-writer and $20/$30-updater questions remain good Mesen targets.

## Method note

The harvest used a 60-line Python script against the disasm6 output. The script lives in `tools/zp-harvest.py` (to be committed next session). This is reusable — future chapters that need a "where is X referenced" pass can call the same machinery. Same idea as the chapter-2 retrospective tools from the Mappy project: build the tool you need; reuse it as the corpus grows.

The cost of static-only analysis is visible in the **untracked** sections above. Without runtime correlation we know *that* $7A is heavily used in bank 15 but not *for what semantic purpose*. The next session's Mesen breakpoint runs will fill in those gaps efficiently.

## What chapter 2 establishes

- A first-pass ZP map covering every documented chapter-1 location plus the major scratch-pool addresses
- The **shared scratch pointer pool** convention (kernel-wide $00-$0F discipline)
- Two concrete instances of **byte-meaning-by-context** at the kernel level ($68/$69 and $83-$86)
- An explicit list of **runtime-only questions** for the next Mesen session

What chapter 3 needs — **most now resolved (pass-2 2026-06-11):**
- ~~Resolve the $90-$AF + $0700-$071F buffer pair~~ → `palette_alt` / `palette_shadow` (above).
- ~~Confirm the "$1C/$1D and $1E/$1F = PPU upload queue" hypothesis~~ → confirmed (`ppu_queue_a/b`).
- ~~Name $74's subsystem~~ → `palette_dirty`. Chapter 3 still owns the queue-*drain* plumbing + the audio/voice detail.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
