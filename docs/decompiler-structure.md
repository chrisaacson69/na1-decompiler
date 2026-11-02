---
status: active
created: 2026-11-02
---
# The Structurer — Where It Stands
> One structurer, DREAM, turns the VM's goto form into readable C; a region reducer takes the subs DREAM cannot own; every printed sub is checked against the bytecode, and the checks are themselves checked.

**Links:** [source/README](../source/README.md) · [appendix-formulas](./appendix-formulas.md) · the engine: [emu-harness](https://github.com/chrisaacson69/emu-harness) `emu_harness.vm.koei.nes` · how it was built: the history pages listed at the end

This page is the current state (2026-11-02). The other `decompiler-*` pages are the June build log; read them for why, not for what is true now.

## The pipeline

| Stage | Tool (emu-harness `vm.koei.nes`) | NA1 artifact |
|---|---|---|
| ROM → VM listing | `vm_disasm` (`titles disasm`) | `source/2-asm-vm/bank_NN_vm.asm` |
| listing → goto C | `vm_decompile`, opcode-keyed, `STRUCTURE=False` | `source/3-c-basic/bank_NN.raw.c` (the witness) |
| goto C → structured C | `dream.dream_structure_gated` per sub, else `vm_decompile.region_reduce` (`vm_reduce`), else the honest goto form | `source/4-c/bank_NN.c` |

**DREAM** is pattern-independent structuring by reaching conditions (Yakdan, Eschweiler, Gerhards-Padilla, Smith, *No More Gotos*, NDSS 2015): each block's condition is computed from the graph and the tree is built from those conditions, so no catalog of shapes is needed. A sub DREAM cannot own (out of scope, its gate rejects, or it would duplicate a merge too much) goes to the **region reducer**, a bottom-up CFG reducer. A sub neither can fold stays the honest goto form. `vm_decompile.STRUCTURE` is the only switch: on means this chain, off means the witness.

NA1, 499 subs: **DREAM 469, region reducer 25, honest goto 0**, and 5 printed as formula overrides (the 32-bit ext-op helpers, whose bodies are arithmetic, not control flow).

Regenerate the whole ladder with `py -3.14 tools/na1_regen.py`; the committed files must come back byte-identical.

## How it is checked

| Check | Proves | NA1 (2026-11-02) |
|---|---|---|
| `gates.roundtrip` | the listing re-encodes to the ROM's bytes | 499 subs, 45,711 bytes identical |
| `gates.stack_audit`, `gates.compare_probe` | each opcode's stack effect, compare direction and signedness, on the ROM's own handlers | 187 opcodes; 10/10 + 10/10 |
| `gates.cfg_gate` | the witness's CFG equals the bytecode's; every printed sub is CFG-equivalent, by its owner's relation (DREAM: `dream_equivalent_ast`; reducer: `structured_equivalent`); each formula override equals the ROM over an edge grid | 494/494, 494/494, 5/5 |
| `gates.test_vm_cfg` | both relations can reject: a misroute, a dropped back edge, an inverted guard, break↔continue, a dropped case, swapped if-arms in DREAM's tree | 129 checks; an always-accept DREAM relation fails 15 |
| `gates.value_probe` | the printed C, evaluated, equals the ROM running the sub (calls run the callee on the ROM, so argument order counts) | 5 fixtures, 684 inputs; a dropped negation and reversed call arguments each fail it |

The formulas read *from* the C have their own check, against the ROM's routines: `py -3.14 -m na1sim.oracle` (see [appendix-formulas](./appendix-formulas.md)).

## What the 2026-10-27 → 11-02 pass found

- **The 32-bit helpers are signed**, and KOEI's `sdiv32` divides by |d|−1 for a negative divisor (a ROM bug in every KOEI NES title that has it). The June forms were unsigned; the models are `vm_decompile.na1_extop_model`, checked by `cfg_gate` every run.
- **The `$8B` immediate dropped its sign**: 5 NA1 sites printed `!= 1` for `!= -1`.
- **A rotated loop's header statements** landed at the body's bottom, so the C read a variable before setting it (51 loops); fixed with the phi coalescing.
- **Three tools fell into a retired structurer by default.** The module flags defaulted to the template structurer, so `decompile_merged` (349 of 499 subs), `titles decompile`, and `value_probe` each printed or checked C that nothing committed, and the recorded `cfg_gate` run was the template one (its "11 honest goto fallbacks" were the template's count; the canonical count is 0). The cure is removal, not a fixed default: the template structurer and the reducer-only audit mode are gone from the engine (2026-11-02), and `STRUCTURE` now means DREAM.
- **DREAM's relation had no test that it could reject anything.** It judges nearly every sub; `test_vm_cfg` now mutates DREAM's tree for six loops the template structurer used to supply.

## Open

- **Readability vs consistency across the KOEI titles.** DREAM can be made to read better per title, at the cost of one structurer behaving the same everywhere; the trade is not settled. The presentation revisit in `re-roadmap.toml` lists the concrete items (a few names, two double-call reprints, `run_cutscene`'s opcode-switch loop falling back to gotos).
- **The printed text is checked by value only on 5 fixtures.** `cfg_gate` checks DREAM's tree, not the text rendered from it; a rendering bug outside the fixtures' shapes would pass it. More `value_probe` fixtures are the cheap cover.

## History — how it got here

- [decompiler-bottom-up-thesis](./decompiler-bottom-up-thesis.md) — the decompiler as a reverse compiler (June 4).
- [decompiler-method](./decompiler-method.md) and [decompiler-atom-log](./decompiler-atom-log.md) — the region reducer's build and its case ledger.
- [decompiler-dream-thesis](./decompiler-dream-thesis.md) — DREAM, from fork to the June 10 cutover.
- [decompiler-architecture-and-gaps](./decompiler-architecture-and-gaps.md) — the components against the paper (June 11).

The first structurer was a set of shape templates; the region reducer replaced it, DREAM replaced the reducer as primary, and the templates were kept beside them as an A/B reference until 2026-11-02. The June pages call these V1, V2 and DREAM.
