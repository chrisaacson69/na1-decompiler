---
status: active
created: 2026-06-07
---
# DREAM — Pattern-Independent Structuring (a parallel route to readable C)
> Same goal as the V2 region reducer — readable, goto-minimal C — by a **fundamentally different method**. Instead of matching CFG subgraphs against a catalog of shapes (V2), DREAM computes a **reaching condition** (a boolean formula over branch predicates) for every node and refines those formulas directly into `if/else/switch/loops`. Goto-free by construction, compiler-independent, no shape catalog to be incomplete.

**Links:** [ROADMAP](./ROADMAP.md) (EPIC: DREAM STRUCTURER) · [decompiler-method](./decompiler-method.md) · [decompiler-bottom-up-thesis](./decompiler-bottom-up-thesis.md) (the V2 atom theory this departs from) · [decompiler-atom-log](./decompiler-atom-log.md) · [05-bytecode-vm](./05-bytecode-vm.md) · tool: `tools/dream.py`

**Source:** Yakdan, Eschweiler, Gerhards-Padilla, Smith. *"No More Gotos: Decompilation Using Pattern-Independent Control-Flow Structuring and Semantics-Preserving Transformations."* NDSS 2015. (The DREAM decompiler.)

---

## Why a second structurer at all

V2 (`vm_reduce.py`) works and is canonical (829 gotos). But its convergence path is a **tail of per-shape atoms** — each unhandled CFG shape is a *missing inverse-lowering* you name and add ([[decompiler-bottom-up-thesis]]). That's sound, but it's shape-by-shape attrition: a real atom clears a few subs, the residue is a long list of rarer shapes. We stopped grinding that tail to test a different bet.

**DREAM's bet:** the closure property V2 chases shape-by-shape is *inherent* to reaching conditions. One condition-refinement engine should subsume the whole tail at once, because there is **no shape catalog to be incomplete** — structure is derived from the boolean logic of the CFG itself.

## The two methods, side by side

| | **V2 — region reducer** (`vm_reduce.py`) | **DREAM** (`dream.py`) |
|---|---|---|
| Core idea | Match CFG subgraphs against ~7 base rules + an atom table; reduce to a fixpoint | Compute a reaching condition per node; refine formulas into if/else/switch/loops |
| Completeness | Incomplete by construction — each new shape is a missing atom | Goto-free by construction (Böhm–Jacopini); no catalog gap |
| Compiler dependence | Needs the [[lowering-atlas]] as a **reference** (what shapes this compiler emits) | **Compiler-independent** — derives structure from boolean logic; atlas is a *pure readability oracle*, not a correctness crutch |
| Failure mode | Long tail of rare per-shape atoms (V2's residue) | Condition formulas can blow up / read worse than a clean pattern match |
| Control of failure | Add more atoms | Semantics-preserving simplification transforms + the readability oracle |

Both share the **same correctness model**: propose a structured AST → the existing CFG-equivalence gate (`structured_equivalent`) proves CFG-equivalence or rejects, and the `--raw` witness proves the round-trip. DREAM introduces **no new verification machinery**.

## Relationship to V2 (locked)

DREAM is a **fork running in parallel, NOT a replacement.** V2 stays the canonical structurer and the default `decompiled/*.c` source. DREAM proves itself on the **same corpus, through the same gate**, and only displaces V2 if it folds **≥ V2 with every gate green and reads as good or better** (lowering-atlas is the readability tie-breaker). Until then both live side by side; no V2 code is deleted. Three honest outcomes: DREAM displaces V2 · DREAM stays a parallel tool · DREAM seeds specific transforms back into V2.

---

## How DREAM works (the mechanism)

For an acyclic region with header `h`, the **reaching condition** of node `n` is the boolean formula describing exactly which paths from `h` arrive at `n`:

```
cr(h, h) = T
cr(h, n) = OR over predecessors v of:  cr(h, v) AND τ(v, n)
```

where `τ(v, n)` is the **edge condition** — the branch predicate under which control passes from `v` to `n` (computed in `tagged_cfg`). Computed in **reverse-postorder** so every predecessor is known before `n` (a topological order for the DAG; loops handled separately). Refinement then factors shared subexpressions out of the `cr` formulas to recover nesting: blocks sharing a common conjunct sit inside the same `if`, the complement gives the `else`, mutually-exclusive constants give a `switch`.

The boolean layer (`dream.py`) keeps formulas canonical: literals carry polarity (so `x` and `!x` share a base and complementation `x & !x → F` is detectable), and `_and`/`_or` apply absorption + idempotence + De Morgan. Keeping these formulas *small* is what keeps the emitted C readable — the open risk DREAM trades for completeness.

---

## Status — PoC foundation built + ground-truth verified

Commit `a5f311e` on branch `dream-structuring`. **`tools/dream.py` (260 lines). Does NOT yet emit structured C** — the foundation is laid and verified before refinement/emit is built on top.

1. **Boolean layer** — canonical expr tuples (`T`/`F`/`lit`+polarity/`and`/`or`); `_and`/`_or` with complementation, absorption, idempotence; De Morgan `neg`; `to_c` renderer.
2. **`tagged_cfg()`** — recovers each edge's branch predicate τ by reusing `vm_cfg` + `vm_reduce._parse_block`. **VERIFIED against the asm on `char_classify`.**
3. **`reaching_conditions()`** — the `cr` recurrence above, reverse-postorder. **VERIFIED** — re-derived the "lowercase"/"uppercase" byte-range conditions straight from the raw compares. (A real address-order ≠ topological-order bug was caught + fixed here, per paper §IV-B.)
4. **`_capture_sub()` harness** — grabs one sub's `(lines, instructions)` via the `structure_v2` hook from `decompile-all`. Front-end inherited from `vm_cfg`/`vm_decompile`/`vm_reduce`; DREAM replaces ONLY structuring.

Single-sub dump:
```
py -3 tools/dream.py <bank> <sub_addr_hex>      # e.g. tools/dream.py 15 CDCF
```

---

## Build ladder

Each rung lands gate-green + measured on the corpus (the same discipline as V2's ladder).

1. **Condition-based refinement → nested if/else** — factor shared subexpressions out of the per-node reaching conditions into a nested `if/else` tree. **First readable output; first thing diffable against V2 through the gate. ← START HERE.**
2. **Condition-aware switch** — the `$D5`/`$D9` dispatch shapes (cf. V2's atom-4 diagnosis in [[decompiler-atom-log]]).
3. **Loop inference** — the paper's loop-structuring rules (`continue`/`break` fall out of the condition formulas); reuse `vm_cfg.natural_loop`/`back_edges`.
4. **Semantics-preserving transforms for irreducibles** — restructure genuinely-improper regions instead of emitting a goto. DREAM's structural answer to V2's `_flat_span`/honest-goto residue.
5. **Stronger simplifier** — keep growing condition formulas readable. Where DREAM wins or loses on readability vs V2.
6. **Bake-off + cutover decision** — full-corpus V2 vs DREAM, gate-green, goto-count + spot-read readability → decide displace / parallel / seed-back.

## Build log

*(one entry per session; newest first)*

- **2026-06-07 — PoC foundation committed (`a5f311e`).** Boolean layer + `tagged_cfg` + `reaching_conditions` + capture harness, both verified against ground truth. No structured C yet.
- **2026-06-08 — baseline re-run on `char_classify` ($CDCF, bank 15) + the rung-1 insight.** The dump confirms the foundation works AND surfaces the design key for rung 1: the per-node `cr` formulas LOOK exploded (`$CE11` is a screenful) but every one is built from the **same shared subexpressions** — `cr($CDF4)` appears verbatim inside `cr($CDE6)`, `cr($CDFD)`, `cr($CE11)`, … . So the "blowup" is redundancy, and **factoring shared `cr(pred)` terms back out IS the nesting recovery** (`$CDF4` becomes one `if`, its dependants nest inside). Refinement (rung 1) and the simplifier (rung 5) are the same lever attacked from two ends: don't re-expand a predecessor's condition, REFERENCE it. **Next: rung 1 — condition-based refinement → nested if/else, diffed against V2 through the gate.**
