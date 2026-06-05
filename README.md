# NA1 Decompiler

A bottom-up decompiler for the **Nobunaga's Ambition (NES)** bytecode VM ("Sea-16"),
plus the forward-direction lowering catalog that sources it.

The decompiler lifts the game's stack VM bytecode to C, then **structures** it — recovering
`if`/`while`/`switch` from raw goto/label form via a CFG region reducer. Every structuring fold
is proven CFG-equivalent to the bytecode by a self-validation gate before it's kept, so the
output is faithful by construction (a fold that can't be proven equivalent falls back to an
honest `goto`). Progress is measured by residual goto count: lower = more structure recovered.

## Layout

| Dir | What |
|---|---|
| [`nobunaga/`](./nobunaga/) | The decompiler: VM disassembler, opcode-keyed C emitter, the CFG region reducer (`tools/vm_reduce.py`), the equivalence gate, and the decompiled banks (`decompiled/*.v2.c`). |
| [`lowering-atlas/`](./lowering-atlas/) | The **forward** catalog — compile C, observe which CFG shapes the compiler emits, and source the decompiler's inverse-lowering "atom table" forward rather than guessing it. |

## The atom log

The heart of the project is [`nobunaga/decompiler-atom-log.md`](./nobunaga/decompiler-atom-log.md):
a running ledger where each **atom** is the inverse of one compiler lowering. The discipline is
*fix as we go, but log each case* — so a fix that generalizes (clears many subs) is distinguished
from a one-off pattern-match. Current state: **V2 = 929 gotos, 222 ahead of the V1 reference.**

## Build

```sh
py tools/decompile-all.py --v2     # regenerate decompiled/*.v2.c (run from nobunaga/)
py tools/vm-cfg-gate.py            # the hard CFG-equivalence gate
py tools/test-vm-cfg.py            # structuring test suite
```

> Reverse-engineering notes for interoperability and preservation. **The game ROM is not
> included.** Derived material (disassembly listings, Mesen labels, and a handful of reference
> screen/SRAM renders) is kept for analysis — hence this repository is **private**.
