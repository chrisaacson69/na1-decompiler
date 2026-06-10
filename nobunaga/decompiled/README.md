# `decompiled/` — the engine as a readable codebase

> The "see the whole picture" payoff. Every bytecode subroutine in Nobunaga's
> Ambition, decompiled to readable C. Generated **once**, committed, read like
> source — never re-derived per session (the anti-drift thesis applied to the
> project's most valuable output).

## What's here

| File | Bank | Subs | Notes |
|---|---|---:|---|
| `bank_00.c` | 0 | 98 | boot + bytecode |
| `bank_01.c` | 1 | 131 | **the economy engine** — Grow/Build/Give/Dam/Tax effect handlers (`sub_87F0` = grow, etc.) |
| `bank_02.c` | 2 | 131 | combat + map |
| `bank_15.c` | 15 | 135 | kernel-side bytecode |

**That's the whole engine.** Banks 03–14 are **data** (graphics/maps/text/tables) — 0 bytecode subroutines (verified via the `JSR $E823` stub scan), so there is nothing to decompile there. The 4 files above are the complete bytecode surface: 495 functions, ~11.8k lines.

## Three views per bank — basic, full, and asm

Each bank is committed in three forms, so the structure engine's work is legible side by side:

| Form | File | What it is |
|---|---|---|
| **full** (canonical) | `bank_NN.c` | The readable C: `if`/`while`/`switch`/`do-while` with braces. Structured by **DREAM** (the pattern-independent reaching-condition structurer; owns **479/495**), with the **V2** region reducer as the per-sub fallback (16 subs). This is what you read. |
| **basic** | `bank_NN.raw.c` | Bytecode → **direct goto/label C, no structuring** — the intermediary the structure engine folds. Also the **CFG-equivalence reference**: the gate proves `bank_NN.c` induces the *same control-flow graph* as this file, so the structured form is faithful by construction. Open both to *see* what the structure engine did. |
| **asm** | `bank_NN_vm.asm` | The execution-validated VM-asm listing (`vm-disasm.py`), the disassembly each form is decompiled from. |

`all_banks.c` / `all_banks.raw.c` are the merged PRG-keyed views of the same.

## How it's made

```
cd ../tools                                       # run from the tools/ dir (so `na1dream` resolves)
py -3 -m na1dream.cli.decompile_all               # canonical (DREAM) bank_NN.c + bank_NN_vm.asm + all_banks.c
py -3 -m na1dream.cli.decompile_all --basic       # the basic goto form -> bank_NN.raw.c + all_banks.raw.c
py -3 -m na1dream.cli.decompile_all --v2          # V2 region reducer (audit/diff only) -> bank_NN.v2.c
```

Pipeline (execution-validated — see `../tools/na1dream/ARCHITECTURE.md`, `../ROADMAP.md`):
`vm_disasm` (ROM → VM-asm, correct lengths) → `vm_decompile` (asm → C, dispatch keyed on the opcode byte) → `dream` (DREAM structurer; V2 fallback), all in the `na1dream` package. **Deterministic:** fixed ROM → byte-identical output, so these are committed and only regenerated when a *tool* improves (not every session). Soundness is gated end-to-end: `py -3 -m na1dream.gates.cfg_gate --dream` proves every sub's `bank_NN.c` is CFG-equivalent to its `bank_NN.raw.c` witness (DREAM subs via the reorder-tolerant AST gate, V2 subs via the address-anchored gate).

## Reading the C — caveats

- **`// TODO:` lines (~22%)** are opcodes the decompiler has a byte-length for but no semantic translation yet. The surrounding structure (control flow, handled ops, frame slots, host-calls) still carries the logic. TODO density drops as opcodes get decoded.
- **`/*stack underflow*/ regA`, `/* via argN */`** — the decompiler's heuristic for implicit args passed via frame-shadow writes (see the `math32_3arg` label comment about reading uninitialized stack). Not a bug in the C; a marker of an inferred value.
- **`local10 = (x / 0)`** and similar — artifacts of the same uninitialized-arg heuristic; cross-check against the emulator (`nobunaga_vm.py`) for ground truth, which is how every *verified* formula here was confirmed.
- Field accesses like `arg1->output` use the province-record field map (`vm_decompile.PROV_FIELDS`).

**Ground-truth rule:** the C is the map; the emulator is the territory. Every formula cited as "verified" in memory/chapters was validated by executing the handler in `nobunaga_vm.py`, not by reading this C alone.
