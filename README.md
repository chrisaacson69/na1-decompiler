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

The analysis site and wiki are generated from the pages in [`docs/`](./docs/) and the tools in [`tools/`](./tools/):
the site by [`tools/build-site.py`](./tools/build-site.py), built and deployed by GitHub Actions
([`.github/workflows/pages.yml`](./.github/workflows/pages.yml), Jekyll), the wiki reference by `tools/build-wiki.py`.

## How the decompiler works

The decompiler lifts the game's stack VM bytecode to C, then **structures** it — recovering
`if`/`while`/`switch` from raw goto/label form via a CFG region reducer. Every structuring fold
is proven CFG-equivalent to the bytecode by a self-validation gate before it's kept, so the
output is faithful by construction (a fold that can't be proven equivalent falls back to an
honest `goto`). Progress is measured by residual goto count: lower = more structure recovered.

## Layout

| Dir | What |
|---|---|
| [`source/`](./source/) | The generated ladder: 6502 asm, labelled asm, VM listing, raw C, structured C (the engine itself lives in [emu-harness](https://github.com/chrisaacson69/emu-harness), `emu_harness.vm.koei.nes`). |
| [`docs/`](./docs/) | Hand-written pages: the chapters, appendices, decompiler papers, and the command pages ([`docs/commands/`](./docs/commands/)). The site is built from them; it is not committed. |
| [`assets/`](./assets/) | Committed renders from the ROM, and the game-data captures ([`assets/data/`](./assets/data/)). |
| [`tools/`](./tools/) | NA1's tools and adapters; the catalog is [`tools/README.md`](./tools/README.md). |
| [`CONTEXT.md`](./CONTEXT.md) · [`ROADMAP.md`](./ROADMAP.md) · [`re-roadmap.toml`](./re-roadmap.toml) | Where to start, the frontier, and every phase gate's state. `mesen-labels.toml` is the symbol registry. |
| [`lowering-atlas/`](https://github.com/chrisaacson69/emu-harness/tree/master/tools/lowering-atlas) | The **forward** catalog — compile C, observe which CFG shapes the compiler emits, and source the decompiler's inverse-lowering "atom table" forward rather than guessing it. |

## The atom log

The heart of the decompiler is [`docs/decompiler-atom-log.md`](./docs/decompiler-atom-log.md):
a running ledger where each **atom** is the inverse of one compiler lowering. The discipline is
*fix as we go, but log each case* — so a fix that generalizes (clears many subs) is distinguished
from a one-off pattern-match. Current state: **V2 = 929 gotos, 222 ahead of the V1 reference.**

## Build

```sh
# decompiler (paths resolve from each tool's file; the engine is emu-harness)
py -3.14 tools/na1_regen.py                                    # regenerate source/ (all tiers)
py -3.14 -m emu_harness.vm.koei.nes.gates.cfg_gate             # the hard CFG-equivalence gate
py -3.14 -m emu_harness.vm.koei.nes.gates.test_vm_cfg          # structuring test suite
py -3.14 -m emu_harness status na1-decompiler                  # every phase gate's last result

# publishing
py tools/build-site.py    # build the Pages site into _build/site/ (Actions does this on push)
py tools/build-wiki.py    # regenerate + push the wiki reference
```

> Reverse-engineering notes for interoperability and preservation. **The game ROM is not
> included** (it is gitignored); derived material — disassembly listings, Mesen labels, and a
> handful of reference screen/SRAM renders — is kept for analysis.
