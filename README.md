# Nobunaga's Ambition (NES) — Decompiled

A bottom-up decompiler for the **Nobunaga's Ambition (NES)** bytecode VM ("Sea-16"),
plus a full reverse-engineering of how the 1989 Koei strategy engine actually works —
its turn loop, combat math, economy, and AI.

## Three ways in

| | | |
|---|---|---|
| 📖 **[Analysis site](https://chrisaacson69.github.io/na1-decompiler/)** | chapter-by-chapter walkthrough, the decompiler story, verified formulas | *GitHub Pages* |
| 📚 **[Game Wiki](https://github.com/chrisaacson69/na1-decompiler/wiki)** | concepts &amp; formulas reference — per-command pages, cross-linked | *GitHub Wiki* |
| 🔧 **This repo** | the decompiler, tools, disassembly, and decompiled banks | *source* |

The analysis site and wiki are generated from the markdown and tools in [`nobunaga/`](./nobunaga/);
the site by [`nobunaga/tools/build-site.py`](./nobunaga/tools/build-site.py) (→ `docs/`, served by
GitHub Pages with Jekyll), the wiki reference by `nobunaga/tools/build-wiki.py`.

## How the decompiler works

The decompiler lifts the game's stack VM bytecode to C, then **structures** it — recovering
`if`/`while`/`switch` from raw goto/label form via a CFG region reducer. Every structuring fold
is proven CFG-equivalent to the bytecode by a self-validation gate before it's kept, so the
output is faithful by construction (a fold that can't be proven equivalent falls back to an
honest `goto`). Progress is measured by residual goto count: lower = more structure recovered.

## Layout

| Dir | What |
|---|---|
| [`nobunaga/`](./nobunaga/) | The decompiler + analysis: VM disassembler, opcode-keyed C emitter, the CFG region reducer (`tools/vm_reduce.py`), the equivalence gate, the decompiled banks, and the chapter/appendix markdown. |
| [`docs/`](./docs/) | **Generated** Pages site (by `tools/build-site.py`) — do not hand-edit; edit sources in `nobunaga/` and rebuild. |
| [`lowering-atlas/`](./lowering-atlas/) | The **forward** catalog — compile C, observe which CFG shapes the compiler emits, and source the decompiler's inverse-lowering "atom table" forward rather than guessing it. |

## The atom log

The heart of the decompiler is [`nobunaga/decompiler-atom-log.md`](./nobunaga/decompiler-atom-log.md):
a running ledger where each **atom** is the inverse of one compiler lowering. The discipline is
*fix as we go, but log each case* — so a fix that generalizes (clears many subs) is distinguished
from a one-off pattern-match. Current state: **V2 = 929 gotos, 222 ahead of the V1 reference.**

## Build

```sh
# decompiler (run from nobunaga/)
py tools/decompile-all.py --v2     # regenerate decompiled/*.v2.c
py tools/vm-cfg-gate.py            # the hard CFG-equivalence gate
py tools/test-vm-cfg.py            # structuring test suite

# publishing
py nobunaga/tools/build-site.py    # regenerate docs/ (the Pages site)
py nobunaga/tools/build-wiki.py    # regenerate + push the wiki reference
```

> Reverse-engineering notes for interoperability and preservation. **The game ROM is not
> included** (it is gitignored); derived material — disassembly listings, Mesen labels, and a
> handful of reference screen/SRAM renders — is kept for analysis.
