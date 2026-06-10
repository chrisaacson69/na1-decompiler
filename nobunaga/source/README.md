# `source/` — the recovered game source, as a pipeline ladder

> The "see the whole picture" payoff. Nobunaga's Ambition reconstructed from the
> ROM at every level of abstraction, each decompiler stage in its own folder so you
> can walk ROM → readable C. Generated **once**, committed, read like source — never
> re-derived per session (the anti-drift thesis applied to the project's most valuable
> output).

## The four stages

| Dir | Stage | What it holds |
|---|---|---|
| `1-asm-6502/` | native disassembly | every bank decoded to 6502 — `bank_NN.asm` (raw), `bank_NN_labeled.asm` / `bank_NN_named.asm` (toml labels applied), the full-ROM `.asm`, `chr_rom.bin`. |
| `2-asm-vm/` | VM bytecode | `bank_NN_vm.asm` — the Sea-16 VM bytecode disassembly for the 4 code banks (the interpreted layer the game logic actually runs in). |
| `3-c-basic/` | basic decompile | `bank_NN.raw.c` — bytecode → **direct goto/label C, no structuring**. The intermediary the structure engine folds, AND the **CFG-equivalence witness** the gate proves `4-c/bank_NN.c` equivalent to. |
| `4-c/` | structured C (canonical) | `bank_NN.c` — the readable C (`if`/`while`/`switch`/`do-while`), structured by **DREAM** (owns 479/495) with the **V2** reducer as the per-sub fallback. **This is what you read.** |

`3-c-basic/` and `4-c/` also hold the merged PRG-keyed `all_banks*.c`. Open a `3-c-basic`/`4-c` pair side by side to *see* what the structure engine did.

**The bytecode surface is the whole engine:** banks 0/1/2/15 = 495 functions, ~11.8k lines of C (bank 1 = the economy engine, bank 2 = combat+map, bank 15 = kernel-side). Banks 03–14 are data (0 bytecode subs).

## How it's made

```
cd ../tools                                  # run from the tools/ dir (so `na1dream` resolves)
py -3 -m na1dream.cli.decompile_all          # stages 2-4: 2-asm-vm/ + 4-c/ + merged
py -3 -m na1dream.cli.decompile_all --basic  # stage 3: 3-c-basic/ (the goto witness)
py -3 -m mesen-labels --asm                  # stage 1: 1-asm-6502/*_named.asm (from the toml)
py -3 -m na1dream.cli.decompile_all --v2     # V2 audit/diff only -> 4-c/bank_NN.v2.c
```

Pipeline (execution-validated — see `../tools/na1dream/ARCHITECTURE.md`, `../ROADMAP.md`):
`vm_disasm` (ROM → VM-asm, correct lengths) → `vm_decompile` (asm → C, dispatch keyed on the opcode byte) → `dream` (DREAM structurer; V2 fallback), all in the `na1dream` package. **Deterministic:** fixed ROM → byte-identical output, so these are committed and only regenerated when a *tool* improves (not every session). Soundness is gated end-to-end: `py -3 -m na1dream.gates.cfg_gate --dream` proves every sub's `bank_NN.c` is CFG-equivalent to its `bank_NN.raw.c` witness (DREAM subs via the reorder-tolerant AST gate, V2 subs via the address-anchored gate).

## Reading the C — caveats

- **`// TODO:` lines (~22%)** are opcodes the decompiler has a byte-length for but no semantic translation yet. The surrounding structure (control flow, handled ops, frame slots, host-calls) still carries the logic. TODO density drops as opcodes get decoded.
- **`/*stack underflow*/ regA`, `/* via argN */`** — the decompiler's heuristic for implicit args passed via frame-shadow writes (see the `math32_3arg` label comment about reading uninitialized stack). Not a bug in the C; a marker of an inferred value.
- **`local10 = (x / 0)`** and similar — artifacts of the same uninitialized-arg heuristic; cross-check against the emulator (`nobunaga_vm.py`) for ground truth, which is how every *verified* formula here was confirmed.
- Field accesses like `arg1->output` use the province-record field map (`vm_decompile.PROV_FIELDS`).

**Ground-truth rule:** the C is the map; the emulator is the territory. Every formula cited as "verified" in memory/chapters was validated by executing the handler in `nobunaga_vm.py`, not by reading this C alone.
