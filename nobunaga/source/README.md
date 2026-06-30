# `source/` — the recovered game source, as a pipeline ladder

> The "see the whole picture" payoff. Nobunaga's Ambition reconstructed from the
> ROM at every level of abstraction, each decompiler stage in its own folder so you
> can walk ROM → readable C. Generated **once**, committed, read like source — never
> re-derived per session (the anti-drift thesis applied to the project's most valuable
> output).

## The four stages

| Dir | Stage | What it holds |
|---|---|---|
| `1-asm-6502/` | native disassembly | every bank force-decoded to 6502 — `bank_NN.asm` — the rawest view (the bytecode banks 0/1/2/10/14 decode as 6502 garbage; that's the point: tiers 2–4 make sense of it). Plus the full-ROM `.asm` header + `chr_rom.bin`. (Regenerated with `disasm6502.py`; the original downloaded disassembler — "disasm65" — is gone, and the old `_labeled` variants it produced were dropped as un-regenerable. A labeled native view would be a future label-injection pass over disasm6502 output.) |
| `2-asm-vm/` | VM bytecode | `bank_NN_vm.asm` — the Sea-16 VM bytecode disassembly for the 4 code banks (the interpreted layer the game logic actually runs in). |
| `3-c-basic/` | basic decompile | `bank_NN.raw.c` — bytecode → **direct goto/label C, no structuring**. The intermediary the structure engine folds, AND the **CFG-equivalence witness** the gate proves `4-c/bank_NN.c` equivalent to. |
| `4-c/` | structured C (canonical) | `bank_NN.c` — the readable C (`if`/`while`/`switch`/`do-while`), structured by **DREAM** (owns 479/495) with the **V2** reducer as the per-sub fallback. **This is what you read.** |

`3-c-basic/` and `4-c/` also hold the merged PRG-keyed `all_banks*.c`. Open a `3-c-basic`/`4-c` pair side by side to *see* what the structure engine did.

**The bytecode surface is the whole engine:** banks 0/1/2/15 = 495 functions, ~11.8k lines of C (bank 1 = the economy engine, bank 2 = combat+map, bank 15 = kernel-side). Banks 03–14 are data (0 bytecode subs).

## How it's made

The decompiler **graduated** out of this repo into `koei-nes/tools/` (`na1dream` is now a thin import-shim,
so the old `python -m na1dream.cli.decompile_all` no longer runs). Regenerate from the shared engine — run
from `koei-nes/tools/`, with NA1's ROM in place per the resolver (`ROM` and `SRC` paths shown relative):

```
ROM="../../na1-decompiler/nobunaga/Nobunaga's Ambition (USA).nes"
SRC="../../na1-decompiler/nobunaga/source"
# tier 1 — native 6502 (all 16 MMC1 banks; base 8000 for 0-14, c000 for the fixed bank 15)
for b in $(seq 0 15); do bb=$(printf '%02d' $b); base=$([ $b -lt 15 ] && echo 8000 || echo c000); \
  py -3 disasm6502.py "$ROM" $b --base $base -o "$SRC/1-asm-6502/bank_${bb}.asm"; done
# tiers 2 / 4 / 3 — bytecode banks 0,1,2,10,14,15
for b in 0 1 2 10 14 15; do bb=$(printf '%02d' $b); \
  py -3 koei_vm.py disasm    na1 $b "$SRC/2-asm-vm/bank_${bb}_vm.asm"; \
  py -3 koei_vm.py decompile na1 $b "$SRC/2-asm-vm/bank_${bb}_vm.asm" "$SRC/4-c/bank_${bb}.c"; \
  py -3 koei_vm.py decompile na1 $b "$SRC/2-asm-vm/bank_${bb}_vm.asm" "$SRC/3-c-basic/bank_${bb}.raw.c" --raw; done
```

(Then strip the `// Decompiled from …/source/` path prefix to a clean relative one and prepend the banners —
see the recreate commit.) Pipeline: `koei_vm disasm` (ROM → VM-asm, execution-validated lengths) →
`koeivm.vm_decompile` (asm → C, dispatch keyed on the opcode byte) → DREAM structurer / V2 fallback for `4-c`,
or **`--raw`** (no structuring) for `3-c-basic`. **Deterministic:** fixed ROM + `../mesen-labels.toml` →
byte-identical output, so these are committed and only regenerated when a *tool* or the toml improves. The
`3-c-basic` / `4-c` pair now differ **only by structuring** (same labels), so a side-by-side shows exactly
what DREAM folded. (The CFG-equivalence gate lives in the graduated `koeivm` engine.)

## Reading the C — caveats

- **`// TODO:` lines (~22%)** are opcodes the decompiler has a byte-length for but no semantic translation yet. The surrounding structure (control flow, handled ops, frame slots, host-calls) still carries the logic. TODO density drops as opcodes get decoded.
- **`/*stack underflow*/ regA`, `/* via argN */`** — the decompiler's heuristic for implicit args passed via frame-shadow writes (see the `math32_3arg` label comment about reading uninitialized stack). Not a bug in the C; a marker of an inferred value.
- **`local10 = (x / 0)`** and similar — artifacts of the same uninitialized-arg heuristic; cross-check against the emulator (`nobunaga_vm.py`) for ground truth, which is how every *verified* formula here was confirmed.
- Field accesses like `arg1->output` use NA1's province-record field map — now selected per-title by
  `vm_decompile.set_schema("na1")` (the shared engine serves NA1/NA2/ROTK/GK, each with its own layout;
  NA1's is the SRAM-verified one in `../docs/07-sram-save-layer.md`).

**Ground-truth rule:** the C is the map; the emulator is the territory. Every formula cited as "verified" in memory/chapters was validated by executing the handler in `nobunaga_vm.py`, not by reading this C alone.
