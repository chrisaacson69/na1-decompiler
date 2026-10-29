---
status: active
created: 2026-10-27
---
# tools/ — retired scripts
> What was removed from `tools/` and `tools/attic/` on 2026-10-27, why, and where to get it back. Nothing here runs; the list exists so a session reads a verdict instead of reviving a broken tool.

**Restore one:** `git show <commit>:nobunaga/tools/<path> > <file>` with the commit below (the last one that touched it; attic scripts lived at `tools/attic/<name>`). Each script's docstring records what it found.

**The rule this replaces the attic with:** a one-off is deleted when done, and its finding goes to a chapter. A check worth keeping becomes a gate in emu-harness, not a script here.

## Address / table hunt (one-off)

| Script | Last commit | What it did |
|---|---|---|
| `dump-defaults.py` | `fa8fc6e` | Extract Nobunaga's Ambition ROM defaults tables to a reference file. Bank 3 of the ROM holds the static "new game" templates for both scenarios: each  |
| `dump-rom-defaults.py` | `fa8fc6e` | Dump the province defaults table in bank 3. |
| `find-adjacency-50.py` | `fa8fc6e` | Locate the 50-fief adjacency table. Strategy: scan the ROM for any region that "looks like" 50 adjacency slots: - 50 consecutive N-byte slots (try N = |
| `find-cell-table.py` | `fa8fc6e` | Hunt for the actual cell-index table in all ROM banks. The table should be 935 bytes (17 fiefs × 55) of "map-like" data: - Many byte values repeat (te |
| `find-market.py` | `fa8fc6e` | Find market prices in SRAM: rate 1.0, rice 1.4, arms 2.8, men 3.0, ninja 1.9. |
| `find-mikawa.py` | `fa8fc6e` | Find Mikawa's province record by searching for the stat signature. |
| `find-rom-defaults.py` | `fa8fc6e` | Search PRG-ROM for the initial Mikawa (and other fief) base-stats table. |
| `find-table-refs.py` | `fa8fc6e` | Find every reference to a given little-endian word in the ROM. |
| `find-title-assets.py` | `fa8fc6e` | Search the ROM for the NA1 title screen's 4 assets: palette, attribute table, nametable, CHR pattern table. Reports ROM location for each — answers wh |
| `find-tokugawa.py` | `fa8fc6e` | Find Tokugawa's stats (85,77,98,86,84 = 55 4D 62 56 54) in a save file. |
| `find-tokugawa2.py` | `fa8fc6e` | Hunt for Tokugawa with multiple encodings. |
| `locate-tables.py` | `fa8fc6e` | Locate daimyo defaults + name tables in PRG-ROM. |
| `map-17fief.py` | `fa8fc6e` | Map the 17-fief scenario tables in the $B0xx region of bank 3. |
| `map-bank3.py` | `fa8fc6e` | Map bank 3's table layout — find table boundaries. |

## Game-fact probe (one-off)

| Script | Last commit | What it did |
|---|---|---|
| `probe-ai-policy-distribution.py` | `fa8fc6e` | Show that the AI never 'picks' a Grant policy — every AI fief sits at province_ai_state == 0 (Home/Balanced); states 1-4 only appear when the PLAYER g |
| `probe-ai-war-target.py` | `fa8fc6e` | Pin the AI war-target SELECTION direction against the ROM, killing the reverse-push ambiguity in the decompiled C. Two questions, two oracles: (1) fie |
| `probe-combat-arena.py` | `fa8fc6e` | Oracle test: settle what select_quadrant_damage_by_direction ($9675, bank 2) actually does, overturning the May-27 "4-quadrant damage formula {1,2,4,7 |
| `probe-combat-bleed.py` | `fa8fc6e` | Close the combat DAMAGE MODEL: separate the three mechanisms that touch unit strength, and settle what the famous "/30" in apply_unit_damage_over_30 ( |
| `probe-combat-casualty.py` | `fa8fc6e` | Pin the real combat casualty/capture formula by RUNNING resolve_attack_apply_casualties ($9E73, bank 2) on a real combat SRAM dump and diffing the uni |
| `probe-map-emit.py` | `ccaed27` | Run a battle-init / map routine in-VM and inspect the staging buffer + syscalls. The kernel syscall layer now lives in nobunaga_vm (intercepts $F226,  |
| `probe-skill-impact.py` | `fa8fc6e` | settle which DIRECTION the skill level (const_two $6D63) pushes development gain, by running the Grow effect at several skill levels on one identical  |

## Structurer bring-up (V2 epic, finished)

| Script | Last commit | What it did |
|---|---|---|
| `probe-bail-audit.py` | `fa8fc6e` | audit the region-reducer's bail guards (atom-log discipline). The atom-3 lesson (2026-06-05): some `_NotReducible` bails in `vm_reduce` are GENUINE so |
| `probe-cfg-reducibility.py` | `fa8fc6e` | the census that distinguishes IRREDUCIBLE control flow from reducible-code-rendered-with-gotos (a missing inverse-lowering "atom"). WHY THIS EXISTS Th |
| `probe-emitorder.py` | `fa8fc6e` | emit-order (atom-5 / approach-B) working probe. For one sub: dump the bytecode CFG, V1's structured layout, V2's structured layout + LAST_BAIL, and (t |
| `probe-inversion-sink.py` | `fa8fc6e` | classify each RESIDUE goto SINK vs NON-SINK. The lowering-atlas cross-jump experiment (2026-06-05) proved a typical compiler cross-jumps SINK suffixes |
| `probe-primitives.py` | `fa8fc6e` | MODEL VALIDATION via forward primitives (not residue-chasing). Chris's reframe (2026-06-06): stop steering by goto-count / "behind V1". Instead, take  |
| `probe-residue-cause.py` | `fa8fc6e` | decide atom 1 (terminal-dup) vs atom 2 (switch) by EVIDENCE. The 57 behind-V1 subs carry 220 recoverable gotos. Two candidate atoms compete for the wo |
| `probe-switch-shapes.py` | `fa8fc6e` | classify every `switch` in the 4 code banks by whether its case bodies form a CLEAN dispatch region (Phase-3 switch-body-inlining foldability). A swit |
| `v2-corpus.py` | `ae15832` | the REGION-REDUCER (V2) regression oracle (CFG epic). Runs every sub through BOTH structurers and compares: * V1 = the template menagerie (structure_l |

## Converted → emu-harness `gates.compare_probe`

| Script | Last commit | What it did |
|---|---|---|
| `probe-compare-opcodes.py` | `fa8fc6e` | Oracle validator for the VM compare opcodes ($C0-$C9) — the PRIMITIVE-LAYER guard that the CFG / round-trip / drift gates structurally CANNOT catch. W |

## Guard idea → emu-harness `gates.value_probe`

| Script | Last commit | What it did |
|---|---|---|
| `probe-espionage.py` | `fa8fc6e` | Empirically pin the espionage formulas by running their VM subs in the emulator. Two questions the static decompile left ambiguous (stack-underflow +  |
| `probe-ternary-folds.py` | `fa8fc6e` | Oracle validator for value-diamond TERNARY folding — the part the CFG gate cannot see. A value-diamond (`regA = cond ? a : b`, rendered as two value-l |

## Superseded → `cfg_gate`'s override value check (15,317 inputs)

| Script | Last commit | What it did |
|---|---|---|
| `probe-math32.py` | `fa8fc6e` | Empirically probe the three VM arithmetic helpers by calling them in the emulator with controlled arguments and reading the return value (regL). These |

## Broken by a path move, finding recorded

Corrected 2026-10-28: the input was not gone. It sits at `traces/sram_dump.txt`; the script opened it next to itself after the move into `tools/`. Its one finding (the `$7BFE` tactical staging buffer and its metatile patterns) is in `mesen-labels.toml` and the chapters. `title-render` / `title-nametable` were listed here on the same wrong reason (their input is `nobunaga/nametable_bytes.txt`) and are restored for the assets phase.

| Script | Last commit | What it did |
|---|---|---|
| `sram-decode.py` | `c020647` | Parse SRAM dump and find the staging buffer + metatile patterns. |

## Superseded → nestest log, `gates.stack_audit`, `titles.run_sub`

| Script | Last commit | What it did |
|---|---|---|
| `test-cpu6502.py` | `fa8fc6e` | Smoke test: run the $E9F6 setA_imm4 handler directly from ROM and verify it sets regA correctly. The handler is `setA = opcode & 0x0F`. Test with opco |
| `test-dispatcher.py` | `fa8fc6e` | Test the full VM dispatcher cycle. Place a real VM bytecode in RAM, point VM PC at it, jump CPU to the dispatcher at $E867, and verify the opcode exec |
| `test-loadl-quick.py` | `fa8fc6e` | Verify LOADL_quick #12 (opcode $0C) reads from FP+11. |

## Presentation cherry-pick (2026-10-29)

The registry's "Not yet reviewed" scripts outside rendering (that triage is the assets phase's), the three
VM-opcode tools that kept their own copies after the engine moved, and two shims. Each was run before the
verdict.

| Script | Last commit | What it did, and why it went |
|---|---|---|
| `analyze-vm-opcodes.py` | `38387b5` | Opcode dispatch-table survey / handler byte dumps / operand-fetch classification. Superseded: operand lengths are measured on the live handlers by emu-harness `tools/koei_isa_probe.py` (0 live disagreements), stack effects by `gates.stack_audit` (187 opcodes), handler names graded by `native_floor --oracle` (157/157). |
| `classify-handlers.py` | `c020647` | Classified each VM opcode from its handler's 6502. Superseded as above. |
| `vm-opcode-labels.py` | `1437815` | Wrote the 158 `vm_op_XX_<mnem>` handler labels (June); re-run proposes 0. Done; the names are in the registry and `native_floor --oracle` grades them. |
| `value-oracle.py` | `b237a5f` | Ran a sub on the ROM for a ground-truth value (oracle_run; certify-extop). Converted into emu-harness `titles.run_sub`; `gates.value_probe` and cfg_gate's ext-op override check do its two jobs; `tools/rule_probe.py` runs rules on it. It also timed out on a no-argument run. |
| `detect-prop-clobber.py` | `9252108` | Flagged a value stored twice whose second store re-printed the clobbered source. That form is gone (the stored-name rebind); its confirm rule now flags the correct C (`turn_idx = turn_idx + 1; ai_per_fief_loop_index = turn_idx;` at bank 1 \$B996). |
| `debug-trace.py` | `fa8fc6e` | Step trace of one selector run (debugging one-off). |
| `paste-analyze.py`, `paste-full.py` | `c020647` | Analyzed SRAM pasted into a chat (pre-capture era); `analyze-sram.py` and the `.dmp` captures replace them. |
| `ui-strings.py` | `c020647` | Dumped the master UI string table; crashed (IndexError). The strings are named by `rom-xref.py strings` (297) and read by reader. |
| `secondary-tables.py` | `c020647` | Dumped the 33-record table at \$B1D6 (between the 17-fief province and daimyo defaults; field 0 markers 2500 / 3000 / 4500 / 7000). **The table has no registry name** (a data-phase gap, recorded in the roadmap). |
| `verify-50fief-align.py` | `c020647` | Checked the 50-fief name and stats tables are index-aligned: they are (name[24] = Owari = stats[24]). |
| `zp-harvest.py` | `82a20fd` | Zero-page usage counts from nes-disasm6 listings (needed them in its cwd); the data phase named the zero page. |
| `vm_assemble.py`, `vm-roundtrip.py` | `c621c0f` | 10-line shims into emu-harness. Run the modules: `py -3.14 -m emu_harness.vm.koei.nes.vm_assemble <bank>`, `... .gates.roundtrip`. |

## Failed map experiments (retired 2026-10-29, the assets phase)

Chris: a fief map shows an interesting part of a territory, not the territory, so stitching fief maps into one map was a failed experiment. (Stitching the overworld is different and still live: the strategic map's section pages overlap, and merging them into one map is `render-strategic-map.py --faithful`.) The whole map is the cartridge's own, `render-strategic-map.py`.

| Script | Last commit | What it did, and why it went |
|---|---|---|
| `render-atlas.py` | `a3b4d31` | Drew the 17 fief maps from bank-4 `$A57E` as a static cell table, plus `atlas-overview*.png` / `atlas-summary.txt`. The hypothesis was disproven 2026-05-21 (its Mino is `{town:18, forest:35}`, the game's 15 clear / 26 forest / 12 mountain): the maps are emitted by bytecode at battle init. The fief maps now come from `batch-render-fief-maps.py`. Its outputs went with it. |
| `render-strategic-atlas.py` | `a3b4d31` | Composited the 17 fief maps at geographic positions with an adjacency overlay (`strategic-atlas-with-adjacencies*.png`). Its inputs, capture renders, were removed in `27c16cb`, so it could not rebuild its own output; and the stitch was the failed experiment above. Its outputs went with it. |
