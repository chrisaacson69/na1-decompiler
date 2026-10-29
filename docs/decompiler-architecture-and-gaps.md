---
status: active
created: 2026-06-11
---
# Decompiler — components laid out, vs the paper, and where the gaps are

Companion to [decompiler-dream-thesis](./decompiler-dream-thesis.md) (the paper) and [tech-debt](./tech-debt.md)
(bug ledger). Written to answer one question while deep-diving bug 1.2: **lay out every component, compare to the
paper, and classify each gap as theory / architecture / implementation** — so we know whether the residue ("the 3%")
is a paper↔impl mismatch, a fixable misunderstanding, or the middle. Short answer: **the middle, and it's now
addressable** — because the value-golden oracle (the thing the paper and the build log both said was needed) is built.

---

## 1. The components (the actual pipeline)

```
ROM bytes
  │
  ▼  vm-disasm.py            execution-validated opcode lengths  → the asm listing (source/2-asm-vm)
  │
  ▼  vm_decompile.py         FRONT-END: opcode → linear C (goto/label form).
  │                          ALSO hosts the value-correctness materialisation (the phi family is APPLIED here)
  │                          and now the ext-op body-override (bug 1.3 fix) + the asset-ID enum substitution.
  │
  ├─ vm_cfg.py               CFG + the VALUE-MERGE PHI FAMILY (the project's value layer, beyond the paper):
  │                            value_diamonds   — side-effect-FREE 2-way → ternary
  │                            consuming_phis   — shared CALL consumer (stack args)
  │                            return_phis      — shared bare `vm_return`
  │                            push_phis        — shared `pushA`
  │                            value_merge_phis — shared `storeA_*` / `branch_z/nz` consumer
  │                            boolean_regions  — short-circuit ||/&& cascades
  │                          tagged_cfg() — each edge's branch predicate τ (the paper's edge condition)
  │
  ▼  dream.py                STRUCTURER (the paper): reaching conditions cr(h,n) → refine into if/else/switch/loops.
  │                          Goto-free by construction. Owns 479/495 subs; V2 fallback for ~16.
  │
  ├─ vm_reduce.py            V2 region reducer — the FALLBACK structurer (shape catalog + atoms).
  │
  ▼  THE GATE                dream_equivalent_ast / structured_equivalent — proves CFG-ISOMORPHISM (structural).
  │
  ▼  source/4-c/*.c          the canonical oracle (DREAM-structured C)
     source/3-c-basic/*.c    the BASIC witness (goto/label, pre-structuring)
     source/2-asm-vm/*.asm    the asm oracle

  NEW 2026-06-10:
  ▶  tools/value-oracle.py   the VALUE-GOLDEN oracle — runs any sub on the REAL ROM (6502 emu) = value ground truth.
                             The missing piece: a VALUE-equivalence check, where the gate only does STRUCTURAL.
```

Two distinct concerns run through this pipeline, and conflating them is the root of the confusion:
- **STRUCTURE** (goto-free, readable control flow) — the paper's domain. `dream.py` + the gate. **Done, gate-proven.**
- **VALUE** (the right expression reaches each merge/consumer) — NOT the paper's domain. The phi family + (now) the
  oracle. **The residue lives entirely here.**

---

## 2. Versus the paper (Yakdan et al., NDSS 2015 "No More Gotos")

> **✅ PRIMARY-SOURCE VERIFIED 2026-06-11** — pulled the actual NDSS 2015 PDF
> (net.cs.uni-bonn.de/.../dream_ndss2015.pdf, text at `tools/_dream_paper.txt`) and checked the claims below
> against it rather than the local summary. Three corrections to how we'd been framing it:
>
> 1. **Data-flow / value is ENTIRELY out of the paper's scope.** The paper structures CFGs whose basic blocks are
>    opaque "sequences of statements" (§II, p.202). The string "data flow" appears in the paper *only in citation
>    titles* — never the body. DREAM rearranges blocks; it never reasons about which value reaches a merge. So our
>    value-merge bugs (1.1–1.4) are **100% upstream of DREAM** — our front-end's job, not a paper gap. The paper
>    *assumes* correct block statements as input.
> 2. **The paper's correctness model is DYNAMIC/BEHAVIORAL, not structural.** §VI: they restructure GNU coreutils
>    source with DREAM, **recompile it, and run the test suite** — "semantically equivalent if they follow the same
>    behavior and produce the same results when executed" (p.1328). **There is NO CFG-isomorphism gate in the paper.**
>    Our static CFG-iso gate is *this project's invention* and is **stricter** than the paper's behavioral test — it
>    is the single biggest assumption we add. And the value-golden ROM oracle (value-oracle.py) is us **returning to
>    the paper's own model** (run it, check behavior), which we'd replaced with the cheaper-but-stricter structural gate.
> 3. **For hard (irreducible / multi-entry/exit) regions the paper INSERTS A BOOLEAN VARIABLE + redirects edges**
>    (§V, p.525–530; §V impl p.1116 "we insert a Boolean variable"), NOT duplication and NOT gotos. We **deliberately
>    diverge**: cap duplication (`DUP_CAP`) + fall back to an honest `goto`. Why it's right for us: DREAM's goal is
>    *readability of unknown malware* (a synthesised flag reads fine); ours is *faithful reconstruction of a known
>    game* — inserting state the binary never had MISREPRESENTS it, so an honest goto is the MORE faithful rendering.
>    A goal-driven divergence, not a bug. **So "does DREAM work as advertised?" — yes for structure; our 3% is (a)
>    value = our front-end, outside the paper, and (b) hard regions where the paper would add a flag and we chose a goto.**


The paper is a **structuring** algorithm: reaching conditions → pattern-independent goto-free C. On its own terms it is
sound and ~complete here (479/495 goto-free, the bake-off won). **Three things the paper does NOT give us, by design:**

| The paper assumes… | …but our reality is | Where the thesis already flags it |
|---|---|---|
| a backend free to **reorder/duplicate** code (its semantics-preserving transforms) | an **address-anchored** gate → the paper's superpower lands on a backend that rejects it | thesis §"the wall", line 110: *"an impedance mismatch DREAM's paper glossed"* |
| **value/stack correctness is a backend given** (structuring only moves blocks) | the linear front-end **drops a value at a merge**; structurings share a CFG yet differ on the value | thesis §`$D2A2`, line 137: *"a structural CFG-isomorphism gate CANNOT catch [value merges]… must also check value/stack identity at merges"* |
| a **value-aware verification** exists | our gate is **structural only** (CFG-iso) → value bugs are gate-INVISIBLE | thesis §"logical vs structural equivalence", line 114; build-log line 173: *"NEXT: … a value-golden harness to assert these at runtime."* |

**So there is NO theory↔implementation mismatch in the structuring.** The paper is right and implemented faithfully.
The gap is that the paper is **scoped to structure**, and *value-correctness is out of its scope* — a fact the thesis
states explicitly (it is the "logical vs structural equivalence" concern, named as future work, "not yet hit"). The
project already went **beyond** the paper with the value-merge phi family to compensate — but **ad hoc, class by
class, each found by READING the emitted C** (the recurring decompiler-method-reframe lesson). That ad-hoc-ness is the
architecture gap, and the unfound classes are the implementation gap.

---

## 3. The gap taxonomy — where 1.2 / 1.3 actually sit

- **🟦 Paper gap (by design, not an error):** the paper verifies *structure*, not *value*. It names the value-
  equivalence need but leaves it to the backend. → Nothing to "fix" in the paper; we must SUPPLY the value layer.

- **🟥 Architecture gap (the real one):** the equivalence gate is **structural (CFG-iso) only**, so every value bug is
  invisible to it. The value-merge phi family compensates **reactively** — a new class is found only when someone reads
  a wrong line. That is whack-a-mole, and "the 3%" is its residue. **The systematic fix = promote the value-golden
  oracle (value-oracle.py) into a value-equivalence GATE** that runs the ROM vs the structured C across the corpus and
  flags every value divergence at once. This is precisely what thesis line 137 ("new assumptions ⇒ new verification")
  and build-log line 173 ("a value-golden harness") called for. **It is now built and proven** (bug 1.3 certified +
  fixed through it). Completing it = closing the architecture gap, not patching one more sub.

- **🟧 Implementation gaps (the residue = "the 3%"), each concrete and fixable:**
  - **Bug 1.3 (ext-op):** the FRONT-END doesn't model the VM's 32-bit aux stack, so 5 math subs render as `// ext_op`
    + a stub. **FIXED 2026-06-10** via a certified body-override (proper fix = model the aux stack — optional, 5 subs).
  - **Bug 1.2 (switch/merge value-collapse):** the value-merge phi family's **consumer set is incomplete.**
    `value_merge_phis` fires only when the merge's first op ∈ `_STORE_REGA | _BRANCH_REGA` (vm_cfg.py:917). `$8B8A`'s
    merge consumer is a **deref/load** (regA used as an address: `*(word*)(side_resource_ptr(arg1)+offset)`) — not in
    the set — so the per-case offset (+0/+2/+4) is never materialised and the switch arms collapse. Likely a two-part
    extension: (a) add the **deref-regA / call-arg** consumer to the family; (b) ensure **switch-case preds** are
    recognised (the family today skips conditional-branch preds — a switch dispatch must count its cases). **This is a
    fixable misunderstanding, not a theory wall** — and the oracle can certify the fix per-sub.

---

## 4. The recommendation (what "completing it" means)

Don't patch 1.2 as one more whack-a-mole. **Complete the value-equivalence gate** (oracle vs structured C, corpus-
wide) → it produces the *certified* census of EVERY remaining value-merge sub (1.2 and any unknown siblings), turning
"a handful, found by reading" into a finite list found by running. Then extend the phi family (deref/call/switch-pred
consumers) with the gate as the proof. That simultaneously: (1) fixes 1.2, (2) closes the architecture gap the paper
flagged, and (3) makes the C *certified* value-correct for the re-analysis pass — the whole point of the grounding.

**Status:** oracle built + proven (1.3 fixed through it). Next = the corpus-wide value-gate (needs a 4-c executor or a
DREAM-AST evaluator to get the structured side's value), then the 1.2 phi-family extension.
