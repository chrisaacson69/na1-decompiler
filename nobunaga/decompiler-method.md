---
status: active
created: 2026-06-05
---
# Decompiler Method — push/pull + atlas grounding, the lessons, and the emit-order problem
> How we recover structure SOUNDLY (not by chasing goto-count), the lessons that earned their
> place, and a dedicated working section to break apart the one wall that's left: the
> **emit-order gate** (address-inverted layouts). Companion to [decompiler-bottom-up-thesis](./decompiler-bottom-up-thesis.md)
> (the *why* — a finite inverse-lowering table), [decompiler-atom-log](./decompiler-atom-log.md)
> (the running case ledger), and [../lowering-atlas/atom-table.md](../lowering-atlas/atom-table.md)
> (the forward catalog).

---

## 1. The method — layered grounding + push/pull

A structuring fold is kept ONLY when **both** the structure (the emitter) and its proof (the gate)
line up. The goal is **C that reads as game logic**, NOT goto-count → 0. We ground every fold from
several independent directions, so no single (gameable) metric is in charge:

| # | Grounding source | What it proves | Blind to |
|---|---|---|---|
| 1 | **Witness faithfulness** `lower(raw) == bytecode` | the raw decompile IS the bytecode CFG (the foundation everything rests on) | — (this one is sacrosanct; never relax it) |
| 2 | **CFG-equivalence gate** (`structured_equivalent`) | routing + true/false orientation between observable blocks (catches misroute / then-else swap / dropped case) | **statement CONTENT** — it checks edges, not whether a block's statements are present on each path |
| 3 | **The lowering-atlas** (forward truth) | the SHAPE is a real compiler lowering, and the `-O0` form is the correct target | NA1's exact opcodes (it catalogs CFG shape, not bytecode) |
| 4 | **Reducer self-checks** | orphan/multiset (no statement vanishes); `copies == in-edges` (per-arm content for duplication) | — (these cover the gate's content blind spot) |
| 5 | **Push/pull (V1 ⟂ V2)** | a change holds green on BOTH an address-ordered emitter (V1 templates) AND a region tree (V2 reducer) | — (the cross-check; a cheap gate hack that games one is caught by the other) |
| 6 | **Oracle / emulation** | semantic ground truth — run the bytecode through the live ROM handler | nothing, but expensive; reserved for direction/value questions |

**The push/pull is the keystone discipline.** Two *independent* structurers — V1 (flat address-ordered
emit + gotos) and V2 (bottom-up region tree) — must both stay gate-green under any change. A single
metric (V2 goto-count) can be gamed by flat-text trickery; making the *same* change validate on both
an address-ordered emitter and a region tree is what keeps it honest. This session it caught two
unsound moves before they shipped (see Lessons).

**Atlas grounding closes the gate's content blind spot.** The gate (2) checks routing, not content.
The atlas (3) compiles the *forward* construct and reads the CFG the compiler emits — so for any
residual shape it answers: *"this is lowering X; the inverse exists, and the `-O0` form is the
target"* vs *"no lowering produces this without a goto → honest goto is CORRECT."* That turns
goto-count from a target into a diagnostic: a residual goto is either a missing inverse-lowering
(an architecture gap to fill) or genuine irreducibility (correct to keep). **To invert something,
learn the forward mechanism and invert THAT — output-clues are a confession you haven't learned it.**

---

## 2. Lessons (each one earned, with the evidence)

- **Goto-count is a proxy, not a target.** It conflates "missing inverse-lowering" with "genuinely
  irreducible." Minimizing it alone invites unsound hacks. Ground each residual goto via the atlas
  (architecture gap vs honest goto) instead.
- **Gate-equivalent ≠ reads-correctly.** V1's `$A30D` switch passes the gate but renders
  `case 0: default: L_A381: per_turn_age(); …` — which READS as "default runs per_turn_age" (false,
  default skips it). The gate reads *address tags*; a human reads *layout*. The DoD is the human read.
- **The negative tests are the backstop — correctness beats results.** atom-5 retry-1 (a blanket
  `contract` terminal-bypass) "improved" V2 by 124 gotos and was UNSOUND — it collapsed distinct
  `return A`/`return B` arms to `EXIT`, hiding then/else swaps + dropped cases. The 114-suite caught
  it in seconds. We threw the "win" away. (Fix: the ≥2-pred restriction — bypass only genuine
  cross-jump *merge* targets, never 1-pred terminal arms.)
- **Atlas-source the inverse, don't guess.** `||` → `b_or`; switch-empty-default → `sm_default_preswitch_share`;
  cross-jump → the `-O0` duplicated tail (`07_terminal_merge`). Every landed atom this session was
  forward-validated first.
- **Trouble on both sides IS the structure of the problem** (Chris, 2026-06-05). A fold needs a
  correct EMITTER *and* a gate that can SEE it's correct. atom 5 made this concrete: the emitter half
  works (the dup produces the exact clean form) but the gate half (lexical fall-through) is missing,
  so it can't land. Necessary ≠ sufficient — and progress and difficulty share this root.
- **Don't land inert complexity.** atom-5's sound dup machinery + the chase-V2 global region
  assignment were both sound but INERT (0 corpus movement) → reverted, design banked in the ledger.
  Bank the knowledge, not dead code.
- **Soundness is delicate around the gate's content blind spot.** Anything that duplicates or bypasses
  a content-bearing block needs an EXPLICIT content guard the routing gate can't give —
  `copies == in-edges` + the atlas `-O0` oracle.
- **The recurring wall is ADDRESS-ORDER** (named ~49× across the ledger). The gate reconstructs the
  CFG from the emitted text using address layout as a proxy for execution order. A *correct*
  structuring emitted OUT of address order (address-inverted) is rejected. atom B fixed this for if-
  *merges* (label-anchored `merge_after`); the general fall-through is the remaining lever → §3.

---

## 3. The emit-order problem (the working section)

**Status (2026-06-05): V2 = 883 gotos; 56 subs behind V1.** Residue by cause (`probe-residue-cause.py`):

```
terminal-dup (atom 5)        11 subs   ≤56 gotos   (blocked: address-inverted arm)
switch shapes                 7 subs   ≤48 gotos   (shared-return $9C84, non-empty default)
NEITHER (cross-edge/layout)  39 subs    141 gotos   ← 63% — all ADDRESS-INVERTED LAYOUT
```

> **63%+ of the residue, AND the blocked atom 5, are one capability gap: lexical fall-through.**
> This is the highest-leverage remaining work, and it's the natural completion of the push/pull arc
> (we've grounded the emitter; this grounds the gate to match it).

### 3.1 The problem, exactly

`vm_cfg.lower_struct_cfg` reconstructs the CFG from the emitted C text. For a block with no explicit
terminator (a guard's fall, an `ifreturn`'s fall, a plain block, a switch case), it computes the
fall-through edge as **`fall_thru = next_leader[L]`** — the ADDRESS-next leader. That's a proxy for
"what executes next," and it's correct *only when emit-order == address-order*. When the reducer emits
blocks out of address order (a correct structuring of address-inverted code), the address-based
fall-through routes to the wrong block → the gate rejects a correct fold.

**atom B already solved this for one site — the if-MERGE** — via `merge_after` (label-anchored: a join
is always labelled, so the merge resolves by its label even when it's a lower address). **The gap is
the GENERAL fall-through**, and the hard part is that a *fall-reached* block often has **no label** to
anchor on (unlike a merge).

### 3.2 Worked example — `$AD38` (the cross-jump terminal, fully dissected)

Bytecode CFG: `AD3D→{AD47,AD7B}`, `AD47→AD58`, `AD58→EXIT`, `AD67→AD58`, `AD7B→{AD67,AD85}`, `AD85→EXIT`.
The reducer's correct (atom-5 dup) output:

```c
if (ai_state(def)) { msg(2b); <AD58 tail>; return …; }     // then: AD47 -> AD58
else {
    if (!ai_state(sel)) return …;                          // AD7B (ifreturn), AD85 inlined
    msg(31); draw(sel); <AD58 tail dup>; return …;         // AD67 -> dup of AD58
}
```

This is correct (0 gotos, dup verified, `copies==in-edges` holds). **The gate rejects it.** Why:
the else-arm is **address-inverted** — `AD67` (0xAD67) is emitted AFTER `AD7B` (0xAD7B) but has a
LOWER address. `lower_struct` computes `AD7B`'s ifreturn fall as `next_leader[AD7B] = AD85` (address)
instead of the emitted `AD7B → AD67`. Contracted CFGs diverge: raw has `AD7B→{AD67,EXIT}`, struct has
`AD7B→{AD67_missing}` (it fell to AD85→EXIT). `AD67` is **fall-reached → has no label** → atom B's
label trick doesn't reach it.

### 3.3 The other examples to work (extract the patterns from these)

- **`$8172`** (bank 1): **V1 folds to 0, V2 leaves 10.** The purest "address-ordered emitter wins
  entirely" case — dissect WHY V1's flat address-order emit succeeds where V2's region tree can't.
- **`$9A5D`** (bank 1): the `||` folded (atom 9) but the surrounding still flat-spans (+10). A MIXED
  case — what part is address-inversion vs another shape?
- **`$A2D2`** (bank 1, +23, the worst): a 42-goto switch+branch handler. V1 folds to 19 by address-
  layout gotos. The big prize — likely several inversions compounded.
- **`$B89B`** (bank 1, +8): the AI per-fief command driver — real game logic, high readability value.

### 3.4 The pattern questions (what the worked examples should answer)

1. **When does emit-order diverge from address-order?** Reordered arms (`$AD38`), pulled-out merges
   (atom 4), duplicated terminals (atom 5), … — enumerate the generators.
2. **Which fall-through sites need lexical resolution?** guard fall, `ifreturn` fall, plain-block
   fall, switch-case fall. (merge is done — atom B.)
3. **How to anchor an UNLABELLED fall target?** The crux. atom B leaned on the merge's label;
   fall-reached blocks have none.

### 3.5 Candidate approaches (for the worked-examples session to evaluate)

- **A — lexical fall-through with a position anchor.** Make `fall_thru` the next block-occupying line
  *lexically*. RISK: re-introduces the flushed-call reordering + line-less-folded-block hazards that
  `lower_struct` is address-based to AVOID. Must handle those (the reason it wasn't done naively).
- **B — the reducer emits a LABEL on a reordered fall target** (lead candidate). When the reducer
  places a block out of address order, it emits `L_xxxx:` on it even though no goto targets it. Then
  the gate resolves the fall by label (the exact `merge_after` mechanism, extended). Harmless
  cosmetically; preserves gate independence (the gate still reads text, gains a stable anchor). This
  is "give the unlabelled fall target a label" — the minimal bridge between atom B and the general case.
- **C — pass emit-order to the gate.** The reducer hands `lower_struct` the block sequence so it
  doesn't reconstruct from address. CLEANEST mechanically but COUPLES the gate to the reducer (loses
  the independent-backstop property that makes push/pull work) — likely rejected on principle.

**Recommended entry point:** approach B on `$AD38`'s `AD7B→AD67` (the atom-5 unblock). It both LANDS
atom 5 (the dup machinery is built, in [decompiler-atom-log] "Atom 5 retry #2", ready to re-apply) and
starts the 141-goto "neither" majority with one mechanism. Validate the same way atom B did: 114-suite
green (esp. the negative swap/dispatch tests), witness 495/495, V2 0-worse, deterministic — and
forward-check the recovered shape against the atlas where one exists.

### 3.6 Working discipline for this section

One example at a time. For each: (a) dump its bytecode CFG + V1's winning layout + V2's bail; (b) name
the exact address-inversion and the mis-routed fall edge; (c) try the candidate fix, gate it on the
full push/pull suite; (d) log the case in [decompiler-atom-log]. The pattern (the general fall-through
rule) emerges from the cases — don't try to design it whole up front (that's how the earlier
"gate-tweak crack" over-reached and broke 4 tests).
