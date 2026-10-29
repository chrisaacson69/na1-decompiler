---
name: nobunaga
description: Run the Nobunaga's Ambition (NES) reverse-engineering tools — render fief/strategic maps, test command effects, decompile VM bytecode to C, query labels, run the verified econ sim, decode combat traces. Lives in the na1-decompiler repo, so it loads only here — use it so an NA1 tool gets INVOKED instead of rebuilt. Triggers — "run the nobunaga <X> tool", "render <fief>", "test the <command> effect", "decompile bytecode at <addr>", "where's the label for <addr>".
user-invocable: true
allowed-tools: Bash, Read, Grep, Edit
---

## Nobunaga tool dispatcher

**This one is deliberately instance-scoped.** The naming walks (label, data, var) are disassembly
*method* and live in emu-harness (PHASES.md §5, `workflows/`; NA1's facts for them are
`walk-context.json`). This skill dispatches NA1's **specific tool surface** (fief renderers,
the econ sim, the combat-trace decoder). It is correctly bound to one project; do not generalize it.
If a tool here proves useful on another target, that's the signal to **promote the tool** into
emu-harness, not to widen this dispatcher.

**Project root (`PROJ`)** is the repo root (it was `nobunaga/` until the 2026-10-29 layout move; the chapters are in `docs/`, the command pages in `docs/commands/`, the game-data captures in `assets/data/`). (Moved here from the vault's skills on
2026-10-26; the vault's pointer page is `projects/game-annotation/nes/na1/README.md`.)

**Rule 0 — anti-drift (this is why the skill exists):** before running OR building anything, the source of truth is the registries, not your memory:
1. Read `PROJ/CONTEXT.md` (vocabulary + canonical artifacts + quick-routes).
2. Read `PROJ/tools/README.md` (the tool catalog — canonical ✅ / duplicate 🔁 / one-shot 🧪).
3. If a tool seems missing, it is probably there under a different name, or its **output** already exists as a data file/label. Re-derive only after confirming it doesn't. If you do build one, add it to `tools/README.md` in the same session.

Then route the request.

> **Launcher: use `py`, not `python`** — `python` is not on PATH on this machine. All invocations are from `PROJ`. Signatures were verified against the tools 2026-05-29 and the moved ones re-checked 2026-10-26. If a tool changed, fix this table **and** `tools/README.md` in the same session — they must not disagree.

| Ask | Tool | Invocation (from `PROJ`) |
|---|---|---|
| Render a fief tactical map | `render-fief-from-ppu.py` | `py -3.14 tools/render-fief-from-ppu.py <fief>`  (`--list` shows available PPU dumps). **py -3.14**: it and `render-text` / `render-portrait` / `render-strategic-map` / `run-animation` (and their importers, e.g. `render-fief-truecolor`, `batch-render-anims`) draw through emu-harness's shared renderer, which plain `py` (3.9) can't import. |
| **Render a fief map straight from ROM (no capture)** | `render-rom-to-map.py` | `py tools/render-rom-to-map.py <province> [--scenario 17\|50]` · validate a dump: `… --sram traces/<dump>.dmp`. Seeds province `$6F63` + scenario `$6D9D`, runs populate `$8903`, decodes `$7BFD`. Verified byte-exact on Mino (17-fief) AND Tanba/Ezo (50-fief, 55/55 cells). |
| **Render the WHOLE atlas from ROM** | `render-rom-atlas.py` | `py tools/render-rom-atlas.py [--scenario 17\|50]` — all 50 (or 17) fiefs → `atlas/rom-50/` + terrain-distribution table + anomaly flags. All 50 verified clean; reproduces every hand-captured fief's terrain counts. |
| Render the strategic map (the cartridge's art) | `render-strategic-map.py` | `py -3.14 tools/render-strategic-map.py [--scenario 17] [--faithful]`  (contact sheet, or the stitched whole map) |
| Render the 50-fief adjacency graph | `render-strategic-50.py` | `py tools/render-strategic-50.py [rom] [out.png]`  (*separate tool — there is no `--variant`*) |
| Test a command's effect | snap protocol | `py -3.14 tools/capture-test.py <tag> pre` → make the move → `… <tag> post` → `… <tag> diff [--fief N]` (py -3.14: the Mesen Debugger folder comes from emu-harness); `--note "..."` on pre/post for provenance. See `docs/commands/README.md`. |
| Run an effect handler in the emulator | `run-effect.py` | `py tools/run-effect.py <grow\|build\|dam\|give…> <sram_pre.dmp> [amount]` |
| Analyze the VM opcode table | emu-harness | `py -3.14 tools/koei_isa_probe.py na1` (lengths, from emu-harness/), `py -3.14 -m emu_harness.vm.koei.nes.gates.stack_audit` (stack effects) |
| Decompile a bytecode sub → C | emu-harness `vm.koei.nes.vm_decompile` | `py -3.14 -m emu_harness.vm.koei.nes.vm_decompile source/2-asm-vm/bank_NN_vm.asm <addr_hex>` (the engine graduated to emu-harness; the read-ready output is `source/4-c/bank_NN.c`, see `source/README.md`) |
| Analyze an SRAM dump (landscape) | `analyze-sram.py` | `py tools/analyze-sram.py <structure\|detail> <dump.dmp>` |
| Decode the live province table | `sram-decode-province.py` | `py tools/sram-decode-province.py <dump.dmp> [--diff <other.dmp>]` |
| Province adjacency table | `adjacency.py` / `adjacency-50.py` | `py tools/adjacency.py "<rom>"` (17-fief) · `py tools/adjacency-50.py "<rom>"` (50-fief) |
| Fief strategic profile (50-fief) | bulk / drill-down | all-50 table → `py tools/fief-analysis-50.py` · one fief → `py tools/profile-fief-50.py <Name…>` |
| Simulate economy / check a formula | `econ_sim.py` | `py tools/econ_sim.py` |
| Trace the VM headless (no GUI) | `vm-trace.py` | `py -3.14 tools/vm-trace.py <state.mss> --inputs "a,wait*40" --trigger <VMPC hex> [--out f] [--check]` — an emu-harness watch on the dispatcher; same lines as `lua/vm-trace.lua` (`--check` runs both and diffs). |
| Decode a combat trace | `combat-trace-decode.py` | `py -3.14 tools/combat-trace-decode.py <trace.txt[.gz]>` (lines parsed by emu-harness; the routine-free view is emu-harness `machines/nes/trace.PPUWrites`) |
| Find a named address | `mesen-labels.toml` | grep it — **never re-trace a known label** |
| **Update Mesen with the latest labels** | `mesen-labels.py` | `py -3.14 tools/mesen-labels.py --mlb` (emu-harness's shared exporter; it also prints registry defects) → writes `Nobunaga's Ambition (USA).mlb` beside the ROM. Mesen 2 **auto-loads** it (same basename, same folder) on next ROM load; or in Mesen: Debugger → File → Workspace → Import Labels. Run this after adding labels to `mesen-labels.toml` so the debugger reflects them. Add `--asm` to also refresh `source/1-asm-6502/bank_NN_labeled.asm` (`--verify` checks the committed ones). `mesen-labels.toml` is the single source of truth — edit it, then re-project. |
| What is this dump / capture provenance | `data-index.py` | `py tools/data-index.py scan` (backlog) · `… auto` (bulk-classify by naming convention) · `… add <file> --note "…"` · `… show` |
| **Find / fetch a Mesen dump** (battle SaveRam, tracelog) | `mesen-dump.py` | `py -3.14 tools/mesen-dump.py list` · `… path [name] [--trace]` · `… get [name] [--trace]` (copies into `traces/` + registers provenance). Convention: `.dmp`=SRAM, `.txt`=tracelog; **no name → latest by timestamp**. `name` is a case-insensitive substring. Resolves Mesen's `Debugger\` output dir. |
| What's the frontier / what's next | — | show `PROJ/ROADMAP.md` |

**Emulator pattern** (for runs on emu-harness `vm.koei.nes.nobunaga_vm`): load SRAM → switch bank → set `vm_pc`/`vm_sp` (pre-allocate locals!) → run. Details in `CONTEXT.md`.

**After the work:** if the session produced a reusable result, register it — update `ROADMAP.md` (move the item), `traces/README.md` (if a precious dump was captured, name it per convention), or `tools/README.md` (if a tool was added/changed). Leaving the result unregistered is how the project drifts.
