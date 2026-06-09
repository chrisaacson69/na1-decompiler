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

## Spike A vs B — the decision (2026-06-08)

Chris's call was "spike both, then decide." Built **Spike A** (address-constrained emit) fully and probed **Spike B**'s (forward-reorder gate) necessity. Result:

**Spike A WORKS and carries rung 1.** Across all 4 code banks, condition-based refinement → nested if/else, emitted address-constrained, validated through the *unchanged* gate:

| bank | eligible (acyclic, no switch) | validated gate-green | rejected | gotos over validated |
|---|---|---|---|---|
| 15 | 94 | 87 | 7 | 43 → **0** |
| 0 | 52 | 43 | 9 | 32 → **0** |
| 1 | 98 | 54 | 44 | 46 → **0** |
| 2 | 66 | 52 | 14 | 39 → **0** |
| **tot** | **310** | **236 (76%)** | **74** | **160 → 0** |

**Every validated sub is FULLY goto-free**, and spot-reads as game logic (`$CA36` → `if (x < 0) { x = 0; }`, a clamp). One emitter refinement (the empty-then FLIP: a guard idiom `if(c) goto body; merge` emits as `if(c){body}` not `if(!c){}else{body}`) lifted the validated count by ~40 across banks and improved readability.

**Spike B is NOT yet justified by evidence.** I emitted every reject class I could find (bank 15 `$CE86`/`$CF9D`, bank 1 `$8008`/`$82DB`) looking for a reject that genuinely *needs* forward code motion the address-gate forbids — **found none.** The 74 rejects are dominated by EMITTER/SIMPLIFIER bugs, all fixable WITHIN address-constrained Spike A:
  1. **Arm-order** (`$8008`): the goto-target block sits at a *lower* address than the fall block, so "then = fall side" inverts the gate's address order → flip arms when `else_min_addr < then_min_addr`.
  2. **Empty-arm pruning** (`$82DB`): a both-empty nested `if(!c){}else{}` isn't dropped because the emptiness test is on the AST list, not the emitted output.
  3. **Weak boolean simplifier**: merge guards like `(!c2&&!c1)||(!c1&&c2)` should reduce to `!c1` (consensus/distribution `_and`/`_or` don't do yet) — this is rung 5, surfacing early.
  4. **Merge-after-early-return** (`$CE86`): when one arm `return`s, the continuation's reaching condition is non-trivial (`!c1`) but should hoist to unconditional; pure-cr over-guards it.

**RECOMMENDATION: pursue Spike A as rung 1 proper; Spike B is the DESTINATION, not a discard.** For rung 1 specifically the address-anchored gate is not yet the wall — the emitter/simplifier is — so the immediate work is in A. But B must not be filed as "optional revisit": see the reframing below.

### The wall = V2's local optimum, and it IS the point of DREAM (Chris, 2026-06-08)

The address-ordered emitter wall is **the exact local optimum V2 could never climb out of.** Across ~200 sessions the V2 epic kept hitting "address-ordered / address-inverted layout" as *the* recurring blocker (atom-4 switch, atom-5 terminal-dup, atom-6 inverted-sink, the `$AD38` family, the 130-goto "neither" bucket, the 22 `self_gate` improper regions V1 only beats "by physically nesting the goto-target inside a sibling's else — flat-text trickery a control-flow-following reducer structurally cannot do"). V2's whole convergence story bottomed out there.

**Getting over that wall is the WHOLE POINT of the DREAM architecture.** Reaching conditions are reorder-agnostic *by construction* — DREAM derives "what must be true to reach this code," not "what block sits at the next address," so the layout that traps V2 simply isn't part of DREAM's model. That is why DREAM is the right architecture and not just a second pattern-matcher.

**The struggle is an impedance mismatch DREAM's paper glossed:** DREAM *assumes* a backend free to reorder and duplicate code (its semantics-preserving transforms do exactly that). Our gate is address-anchored, so the paper's superpower lands on a backend that rejects it. Realizing DREAM's advantage therefore *requires* the reorder-tolerant gate (Spike B / the V2-flagged "reorder-invariant gate") — that work is the destination of this epic, met head-on at rung 4 where the reordering transforms live, with the concrete improper-region cases ($AD38, $A2D2, the 22 self_gate subs) as its test corpus.

**The precise mechanism of the wall (Chris, 2026-06-08): synthetic control has no address.** Using addresses as the labels/brackets was the natural start (every real block HAS an address). But the fix for an irreducible region is to insert "more gotos" (honest gotos for folded shared exits/entries) — or to reorder/duplicate a block — and *that inserted control flow has no native address*. An address-keyed gate/emitter therefore can't anchor or bracket it, which is exactly why V2 couldn't compose across folded exits/entries. DREAM keys structure on reaching conditions, not addresses, so synthetic control needs no address to exist. The gate already carries the seed of the resolution — `_SYNTH_BASE` (synthetic addresses sorted above the real range; how V2's atom-5 dup validates) and the backward-only `lex_fall` label anchor — so the rung-4 fix likely generalizes one of those (give inserted control a synthetic address, or anchor it by label) rather than inventing a new mechanism.

**Looming concern beyond the wall — logical vs structural equivalence.** The current gate proves *structural* (CFG-isomorphism) equivalence. DREAM's semantics-preserving transforms can produce code that is *logically* equivalent but NOT CFG-isomorphic to the witness (a refactored condition, a hoisted/duplicated block, a `&&`-merged guard). A structural gate will reject those even when they're correct. So the equivalence oracle itself may need to climb from structural to logical (e.g. SAT/BDD equivalence on the reaching-condition formulas, which DREAM already has in algebraic form) — a known future concern to design for, not yet hit.

## Worked example — `$D2A2` (why it's hard; what the verification layer must check)

Hand-decompiled from bytecode (2026-06-08). Faithful C:
```c
ui_timer_gate_flag = arg1 ? (arg1 - 1) : 2;        // value-diamond, store at low-addr $D2AC
if (arg1 == 0) {
    syscall_dispatch(12, 3, 0, 248, 248, 0, 2);
    return syscall_dispatch(2, 19);                // return = SYSCALL result here
}
int a,b,c,d;
if (arg1 == 1) { a=2; b=0; c=248; d=248; }
else /*>=2*/   { a=ui_timer_gate_flag; b=0; c=(ui_cursor_row<<3)-1; d=(ui_window_col<<3); }
syscall_dispatch(12, a, b, c, d, 0, 3);            // STACK-PHI join at $D2EC
frame_counter = 200;
return 200;
```
It has **three value-merge points**, only one of which is a control join:
1. **Value-diamond `$D2AC`** — the two arms set the L register, the store merges them; the store sits at a LOWER address than its arms. DREAM dropped the `arg1-1` arm and emitted a bare `ui_timer_gate_flag = 2` at the bottom. Needs the **value-diamond pre-contraction** (as V2 does at the expression layer) BEFORE structuring.
2. **Stack-phi `$D2EC`** — the `==1` and `>=2` arms push DIFFERENT call arguments, then share one `CALL`. No goto-free C without temporaries; DREAM dropped the `==1` sub-case.
3. **Return-phi `$D2F8`** — `RETURN` returns L = the syscall result on `arg1==0`, but `200` otherwise.

**Consequence for the new verification layer:** a structural CFG-isomorphism gate CANNOT catch #2 and #3 — two structurings can share a CFG yet differ on which value reaches the call/return. So the verification can't be "AST→block-CFG, compare edges"; it must also check **value/stack identity at merges** (this is the logical-vs-structural-equivalence concern, made concrete). New assumptions (reorder-free, value-aware) ⇒ new verification.

## Build log

*(one entry per session; newest first)*

- **2026-06-08 — AST-NATIVE GATE BUILT — the wall is over. 274 → 285/310, reorder-tolerant, strict superset, 0 regressions.** Replaced the address-anchored gate (for DREAM) with `dream_equivalent_ast`: `_ast_cfg` lowers the DREAM AST DIRECTLY to a block-CFG (identity = the real block each node owns; edges = the tree's nesting — an `if`'s two arms, a block's lexical continuation), then compares to the raw `lower_goto_cfg` witness via the existing `contract` + TRUE/FALSE orientation. **No text parse, no address dependence → flush + address-inversion are irrelevant by construction** (the exact thing that killed V2 and made the synth-renumber first cut flush-fragile). Three bugs fixed along the way, each found by the new gate exposing what the old address-based gate had MASKED:
  1. **Pivot polarity** — `refine` normalized the pivot to positive, which swapped the pos/neg factoring vs the edge tags when `rawcond` is `!(...)`, mislabelling the `if` arms. The emitter's flip accidentally compensated (old gate passed); the AST gate's orientation check (read from `rawcond`) exposed it. Fix: pivot on the real goto-cond literal. (191→255)
  2. **Guard bail too conservative** — a `guard` (`if(cr){block}`, short-circuit-`||` target) is CFG-TRANSPARENT: the real branching is the upstream `if`s whose empty goto-arms route to it via `cont`, and the guard cond is correct-by-construction. Process the payload as a block instead of rejecting. (255→282, +12 reorder wins)
  3. **Pre-pivot trunk misplaced** — blocks on the entry chain BELOW the first branch were dumped into `rest` and emitted AFTER the `if`; the address gate masked it, the AST gate caught it. Fix: emit the pre-pivot trunk first. (4 regressions → 0)
  **Result: 285/310 validated, EVERY one fully goto-free; 11 genuine reorder wins (the address-inverted-merge cases the old gate rejected — `$E3A9`, `$8F0F`, `$96D6`, `$A6CA`, …); 0 regressions (strict superset of the old gate).** `--check` now uses the AST gate; the old `structured_equivalent` and the flush-fragile synth `dream_equivalent` are retained for reference (`--check2`). **Remaining 25 rejects characterized: refinement MIS-ROUTING, not gate failures and NOT block-drops** (checked `$D2A2`/`$904B`/`$9192`: 0 dropped blocks; the AST has every block, but condition-BASED refinement nests multi-path merges wrongly → wrong CFG edges, e.g. `$914f` raw→`917f` but AST→EXIT). The gate SOUNDLY rejects them (it is not passing wrong output). These need **rung-2 condition-AWARE refinement** (detect the genuine merge point, emit once) + **value-diamond pre-contraction** (`$D2A2`). So the address-inversion WALL is genuinely solved — what's left is refinement coverage, not verification. **NEXT: rung-2 condition-aware refinement.**

- **2026-06-08 — reorder-tolerant gate, FIRST CUT (synth-renumber + reuse the gate) REGRESSED 274→240; AST-native is the path.** Built `dream_equivalent` (`--check2`): renumber each emitted block to a synthetic ascending emit-order address (below `_SYNTH_BASE`), lower with the existing verified `lower_struct_cfg` (now never reordered), map `synth→real`, compare to the raw witness. **Concept VALIDATED** — genuine reorder wins appeared (`$E3A9`, `$93C4`, `$A6CA`, `$AD3D`, subs the old gate wrongly rejected). **BUT net regression**: detecting block boundaries by `bor(addr)` line-to-line breaks on FLUSHED-CALL reordering (a flushed line's address belongs to a neighbouring block → transiently flips the synth split → corrupts blocks). The old gate is flush-robust precisely because it stays in real-address space; renumbering loses that. **CONCLUSION: don't renumber-and-reuse — build the CFG DIRECTLY from the DREAM AST** (block identity is known structurally from the tree, so flush is irrelevant), then compare to the raw `lower_goto_cfg` via the existing `contract`+orientation. Kept the first cut behind `--check2` as the concept proof; NOT wired into `--check`. **NEXT: AST→CFG builder (handle `guard`/disjunctive-merge nodes, which don't map to a single branch block — the one real subtlety).**
- **2026-06-08 — hand-decompiled `$D2A2` (Chris's ask): it's a triple value-merge (value-diamond + stack-phi + return-phi), not a simple inverted merge.** See the worked example above. Reframes the verification-layer build: structural CFG-equivalence is necessary but NOT sufficient (it misses stack/return phis); and `dream.py` needs value-diamond pre-contraction before structuring. NEXT: build the AST-native / pseudo-address verification layer WITH value-merge awareness.

- **2026-06-08 (cont.) — QUICK EXPERIMENT (emit merge labels) FAILED; pseudo-address / AST-native gate is the radical path (Chris).** The gate's `merge_after` reads an if's merge lexically from a `L_M:` label after the `}` (else address fallback), so the cheap test was: have DREAM emit `L_D2AC:` before address-inverted merges. **Result: net −2 (274→272), `$D2A2` still rejected.** Two findings: (1) `$D2A2` is more complex than a pure inverted-merge (10 leaders; the emit collapses several), and (2) naive labels REGRESSED passing subs — the existing label machinery (`merge_after` if-merges only, `lex_fall` backward-only, `tail_redirect`) is fragile + special-cased, so a label fires those heuristics in ways that break correct subs. Reverted (back to 274). **That fragility is the evidence FOR Chris's radical idea: PSEUDO-ADDRESSES** (`$D2A2.0`, `$D2A2.1`, …) — a synthetic address whose *integer part is the real block it belongs to* (identity, for the CFG compare via `block_of`) and whose *suffix is a per-emit uniquifier* (so duplicated/reordered/inserted control gets a unique label and an explicit emit position). This **decouples identity from position**, which is the root fix: the address-anchored gate conflates "which block is this" with "where does it sit," and synthetic control has no native address for the latter. **Cleanest realization:** DREAM already HOLDS the structure tree, so rather than serialize-to-text-then-reparse (the address-anchored `lower_struct_cfg`), lower the AST DIRECTLY to a CFG (identity = real leader, edges = tree structure) and compare to the raw `lower_goto_cfg` via the existing `contract` + orientation check. **KNOWN SUBTLETY to design around (found while scoping it):** DREAM's `guard` nodes and disjunctive merge re-guards do NOT map to a single CFG branch block (their condition is a reaching-condition formula, not one block's predicate), so an AST→block-CFG comparison needs to model those as multi-predicate or contract them — this is the part to get right before trusting it as an oracle ([[feedback_foundation_discipline_early]]: a wrong verification primitive corrupts silently). **NEXT: green-light + build the AST-native (pseudo-address) gate as a DREAM-specific checker, leaving V2's shared gate untouched.**
- **2026-06-08 (cont.) — REACHED THE WALL: the 36 remaining rejects characterized (resume point).** Sampled across banks; the leftover rejects are NO LONGER emitter bugs — they're the two genuine DREAM-frontier classes Chris predicted:
  1. **Address-inverted merge** (`$D2A2` — THE wall). Leaders `…d2ab, d2ac, d2b3, d2ca…`: the shared merge `$D2AC` sits at a LOWER address than the arm bodies that execute before it. Emitting it after the `if/else` (correct logic) inverts address order, and the address-anchored gate can't place it — Chris's "synthetic control has no address" exactly. **Fix lives at rung 4 / Spike B:** give the reordered continuation a synthetic address (`_SYNTH_BASE`, as atom-5 dup does) OR generalize the gate's backward-only `lex_fall` to a FORWARD label anchor so the merge follows its label, not its address. NOTE for the synth-address route: a UNIQUE merge isn't a duplicate, so re-addressing changes its identity in the CFG-equality compare — the label-anchor (V2's `merge_after`, already landed for if-merges) is the more likely vehicle; check why it doesn't fire on DREAM's label-free emit.
  2. **Re-guarded shared continuation** (`$904B`, `$E31A`). A block reached from many paths is emitted under a complex disjunction guard REPEATEDLY instead of structured once as a merge. This is the DREAM paper's *condition-AWARE* refinement (its 2nd phase), not just condition-based — detect the genuine merge point and emit the block once. (The `!a||!b||a` tautology DOES simplify — verified `_or(...) => 1` — so these are real multi-path merges, not simplifier misses.)
  **So rung 1 (condition-based, address-constrained) is essentially harvested at 274/310; the remaining 36 require either the address-wall fix (rung 4 / Spike B) or condition-aware refinement (rung 2-ish). This is the planned crossover into DREAM's actual advantage over V2.**
- **2026-06-08 (cont.) — arm-order-by-address flip. 241 → 274/310 (88%).** Generalized the flip trigger from "fall arm empty" to "then-arm should be the LOWER-address arm" (`flip` when the goto body's min emitted address < the fall body's, via `_min_addr`). The gate is address-anchored, so emitting ascending is what it wants. Recovered 33 subs (bank 1 alone 58→79 — arm-order inversion was its dominant reject). `$8008` now reads as clean game logic (`if(arg1==255){redraw} else {ui_helper}; return redraw`). All validated subs remain fully goto-free (bank 1: 138 gotos → 0 over 79 subs). NOTE: this is still a HEURISTIC (lowest-address arm = then); the robust form is try-both-orientations + self-validate, but the heuristic captures most of it cheaply — keep until a reject needs the trial.
- **2026-06-08 (cont.) — rung-1 refinements: consensus simplifier + post-emit emptiness. 236 → 241/310.** Added `_consensus` to the boolean `_or`: `(X∧a)∨(X∧¬a)→X` and `a∨(¬a∧X)→a∨X`, so merge-block reaching conditions collapse (`(!c1&&!c2)||(!c1&&c2)→!c1`) instead of ballooning — a readability + validation win (+5 subs). Switched emptiness checks to POST-emit (`_emits`, since a both-empty nested `if` is a non-empty AST list that yields no lines). **LESSON (logged): I tried to replace the working empty-then FLIP heuristic with a "principled" `next_leader`-based then-selection — it REGRESSED 236→198.** Leaders are flush-reordered, so `next_leader(header)` is often the fall block even when the body is on the goto side; the address-next rule reverted to the un-flipped form. Reverted to the emptiness-based flip (the heuristic that earned its 87 on bank 15) and kept only the additive wins. Matches [[feedback_foundation_discipline_early]] / incremental-measure discipline: don't swap a measured heuristic for a theory without measuring. **Still open (next):** the robust fix is try-BOTH-orientations-per-`if` + self-validate against the gate (V2's session-7d keystone), which should recover the arm-order rejects without guessing; then the early-return merge hoist (`$CE86`: a returning arm leaves the continuation's `cr=!c1`, should hoist to unconditional). Validated subs remain fully goto-free.
- **2026-06-08 — SPIKE A built + measured, SPIKE B probed (see the decision section above).** `tools/dream.py` gained: `eligible`/`_has_backedge` (acyclic+no-switch scope), `refine` (condition-based factoring by the lowest-address branch predicate), `_emit_ast` (address-constrained if/else, then=fall-side, empty-then flip), `dream_structure` (top-level, passthrough out of scope), and a `--check <bank>` / `--emit <bank> <addr>` harness. 236/310 eligible subs validate fully goto-free; rejects are emitter/simplifier bugs, not the gate. dream.py is a standalone fork tool — NOT wired into `decompile()`, so the default `decompiled/*.c` is untouched. **Next (rung 1 cont.): arm-order flip → empty-arm pruning (post-emit) → consensus simplifier → early-return merge hoist; re-measure each.**

- **2026-06-07 — PoC foundation committed (`a5f311e`).** Boolean layer + `tagged_cfg` + `reaching_conditions` + capture harness, both verified against ground truth. No structured C yet.
- **2026-06-08 — ⚠ GATE CONSTRAINT FOUND (shapes the whole approach).** Read `vm_cfg.lower_struct_cfg` + `structured_equivalent` (the gate DREAM must pass). **The gate is ADDRESS-ANCHORED:** it lowers the structured C to a CFG by *address*, not by parsing the condition. For `if(C){then}` the then-arm is forced to `next_leader(header)` (the address-NEXT block); merge/else resolve by address-after-span. `C` is cosmetic (orientation is checked separately against the raw witness). The ONLY reorder escape hatches are a BACKWARD label-anchored fall (`lex_fall`, fires only when a label's addr `< prev`) and SYNTHETIC duplicate addresses (`_SYNTH_BASE`). **Implication:** DREAM's reaching-condition refinement reorders freely by boolean grouping, and the paper's headline power — semantics-preserving transforms that REORDER/DUPLICATE to go fully goto-free — is exactly what a forward-address-anchored gate rejects. This is the same "address-ordered emitter" wall the V2 epic documented. So rung 1 forks: **(A)** address-constrained emit (then=fall-through; prove the pipeline, DREAM converges toward V2's behaviour, reorder power deferred); or **(B)** first generalize the gate's `lex_fall` to FORWARD label-anchored reorders so DREAM can emit its natural goto-free form and validate (the V2 epic's flagged-but-untried "reorder-invariant gate"; DREAM is the forcing function). **DECISION PENDING with Chris.**
- **2026-06-08 — baseline re-run on `char_classify` ($CDCF, bank 15) + the rung-1 insight.** The dump confirms the foundation works AND surfaces the design key for rung 1: the per-node `cr` formulas LOOK exploded (`$CE11` is a screenful) but every one is built from the **same shared subexpressions** — `cr($CDF4)` appears verbatim inside `cr($CDE6)`, `cr($CDFD)`, `cr($CE11)`, … . So the "blowup" is redundancy, and **factoring shared `cr(pred)` terms back out IS the nesting recovery** (`$CDF4` becomes one `if`, its dependants nest inside). Refinement (rung 1) and the simplifier (rung 5) are the same lever attacked from two ends: don't re-expand a predecessor's condition, REFERENCE it. **Next: rung 1 — condition-based refinement → nested if/else, diffed against V2 through the gate.**
