# NA1 tools — architecture & where new code goes

**`na1dream/` is no longer a library.** The NA1 Dream Decompiler core graduated to koei-nes
(2026-06-29) and then to emu-harness (2026-10-23, its MIGRATION.md row F); `na1dream/__init__.py` is a
back-compat alias (`na1dream.X` *is* `emu_harness.vm.koei.X`) so old imports keep working. Do not add
code here. This file is the map for NA1's own tools; read it before adding a script.

## Layout

```
tools/
  na1dream/      # alias to emu_harness.vm.koei (no code)
  na1sim/        # the NA1 game simulator, over the ROM-checked models (oracle_vm checks it vs the ROM)
  wikipages/     # the wiki / site page builder package
  lua/           # Mesen emulator scripts (a different runtime)
  *.py           # NA1's own tools: title drivers (na1_regen, data-apply, native_discover), walk apply
                 # tools, label projector, captures, renders, analyses. Registry: README.md
  RETIRED.md     # what was removed, why, and the commit to restore it from
```

## How to run the engine

```
py -3.14 -m emu_harness.vm.koei.nes.titles <disasm|decompile|emulate> na1 ...
py -3.14 tools/na1_regen.py                                   # regenerate source/ (from nobunaga/)
py -3.14 -m emu_harness.vm.koei.nes.gates.<roundtrip|stack_audit|compare_probe|cfg_gate|test_vm_cfg>
py -3.14 -m emu_harness status na1-decompiler                 # where each phase gate stands
```

## Where does a NEW script go? (the decision)

1. **Would another title use it?** (a decoder, a gate, a pass, a walk step) → **emu-harness**, with a
   row in its MIGRATION.md. NA1 is the root of the family, so most generic tools started here; that is
   why most of them have left.
2. **Is it NA1-only and rerunnable?** (a title driver, a render of an NA1 format, the simulator) →
   `tools/`, with a row in `README.md`.
3. **Does it prove something is correct?** → an emu-harness gate: it exits non-zero on failure and
   plants a fault that must fail it. A check that only prints is a diagnostic, not a gate.
4. **Is it a one-off investigation?** → run it, put the finding in a chapter, then **delete it** and
   give it a row in `RETIRED.md`. There is no attic: unmaintained scripts in the tree get revisited as
   if they were tools (2026-10-27: 32 attic scripts, none runnable, re-read to find 2 guard ideas).
5. **Is it a Mesen/Lua emulator script?** → `tools/lua/`.

## Where does OUTPUT go? (the artifact axis)

The package sorts *tools*; tools also *emit*, and that output sorts into three classes.
Keep them apart, and inside the regenerable class organize **by kind, never flat** — a
catch-all output dir is the same smell as a flat `tools/`.

| Class | What | Where | Versioned? |
|---|---|---|---|
| **Source** | hand-authored input/knowledge | `nobunaga/*.md` chapters, the ROM, `mesen-labels.toml`, `.xlsx` data | yes — it's input, not output |
| **Oracle** | committed, deterministic, read-like-source deliverables | **`source/`** — the recovered game source as a pipeline ladder | yes — the project's payoff; regenerate only when a tool improves |
| **Render / scratch** | regenerable from the ROM (graphics, traces, reports, dumps) | a gitignored renders tree, **in a kind subdir** | no — gitignored |

The **oracle** class is itself organized by pipeline stage under `source/` (each stage = one
abstraction level, so you can walk ROM → readable C):

```
source/
  1-asm-6502/   native 6502 disassembly (bank_NN[.asm|_labeled|_named] + the full .asm + chr_rom.bin)
  2-asm-vm/     Sea-16 VM bytecode disassembly (bank_NN_vm.asm) — written by decompile_all
  3-c-basic/    bytecode → direct goto C (bank_NN.raw.c) — the CFG-equivalence witness
  4-c/          structured C, DREAM canonical (bank_NN.c) — what you read
```
Writers: `mesen-labels.py` owns stage 1 (`--asm`); `tools/na1_regen.py` writes stages
2–4 through the emu-harness engine. Stage 1 `*_labeled.asm` are **committed** (regenerated from the toml by
`mesen-labels.py --asm`; `--verify` exits 1 if they drift, so labels can't go silently stale).

Deciding where a new tool's output lands:

1. **A canonical artifact meant to be READ like source** (deterministic, the deliverable)?
   → a committed stage under `source/` (or its own top-level dir if it's a new kind). These are oracles.
2. **Regenerable from the ROM** (a render, a trace, an HTML report, a txt dump)?
   → the gitignored renders tree, under a **kind** subdir (`renders/<kind>/`) — not a flat
   pile in one dir. The tool owns its output subpath.
3. **Hand-authored knowledge?** → it's *source*, not output: a `.md` at the project root.

**Done 2026-06-10:** the oracle reorg above — `disasm/` + `decompiled/` consolidated into the
`source/` ladder, the duplicated VM-asm de-duped (one canonical copy in `2-asm-vm/`).

**Remaining artifact debt (convention defined, moves deferred):** `atlas/` is a flat
catch-all (misnamed — it holds animations, province renders, PPU/SRAM dumps, strategic maps,
UI previews, title CHR — not just "atlas" maps). Target: rename to `renders/` with
`{provinces, anim, ppu-sram, strategic, ui, title}` subdirs. The `nobunaga/` root also has
~22 loose generated `.txt`/`.html` mixed with the source `.md` chapters — they belong under
an `out/` tree (`out/reports/`, `out/dumps/`). Apply this convention when the emitting tools
(`render-*`, the atlas builders) are next touched; `atlas/`+`traces/` are gitignored, so the
moves are git-free — the only coupling is updating each tool's output path + regenerating.
