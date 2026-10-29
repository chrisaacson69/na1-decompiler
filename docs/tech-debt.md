# NA1 Decompiler — Tech Debt & Quirks Map

Mapped 2026-06-10 while fresh, during the grounding pass (bank 2 complete, bank 1 in progress).
Severity: 🔴 corrupts the oracle / blocks work · 🟡 friction or latent risk · 🟢 cleanup.

This is the living debt list. When you fix one, mark it ✅ with the date + commit and leave the entry
(history is useful). The companion detail for the decompiler bugs lives in `grounding.md` §"Decompiler 3% backlog".

---

## 1. Decompiler (DREAM) value-correctness bugs — 🔴 highest

The structured-C oracle (`source/4-c/`) is **value-wrong** for a few control-flow/value-merge shapes. These are
**gate-invisible** — CFG (499/499), stack-audit, and round-trip all pass, because the bugs change *values*, not
structure. They are found **only by reading**. Until DREAM is fixed, for any affected sub read the **bytecode**
(`source/2-asm-vm/`) or the **V1 raw** (`source/3-c-basic/`); the grounded toml comments flag each one inline.

| # | Bug | Status | Blast radius | Example subs |
|---|-----|--------|-------------|--------------|
| 1.1 | if/else phi-temp clobber (else-arm value emitted unconditionally) | ✅ FIXED 2026-06-10 | 42→11 candidates, the 11 all false positives | `$DB6E`, `$D687`, `$9FFA` |
| 1.2 | Arms reconverge at a shared SUFFIX op → only one arm's value kept | 🔴 OPEN — DIAGNOSED 2026-06-10 | a handful (structural census = 29 candidates but NOISY; most are legit shared-body switches) | `$8B8A` (switch +2/+4 offset collapses to 0), `$8BEA` (name-source dropped) |

**Bug 1.2 — DEREF-consumer subclass FIXED + CERTIFIED 2026-06-11.** `value_merge_phis`' consumer set was
`_STORE_REGA | _BRANCH_REGA`; a merge whose first op is a **`DEREF`** (`loadA_ind_word`, regA-as-address) was not
recognised, so switch cases computing `base+{0,2,4}` and converging at a shared deref collapsed to the fall arm. Added
`_DEREF_REGA = {'loadA_ind_word'}` to the consumer set (vm_cfg.py) — a ONE-LINE front-end fix; the decoder side is
consumer-agnostic (sets `state.regA` to the temp, the deref reads `*(phi_val)`). **Corpus blast radius: exactly 1 sub**
(`$8B8A draw_side_resource_field`). **Oracle-certified**: with distinct gold/rice/men set, the ROM draws 111/222/333
for arg2=0/1/2 — matching the new per-case +0/+2/+4 (the old collapsed code drew 111 for all three). Gates: self-check
(stack model) clean, deterministic, 1-sub diff. **STILL OPEN — the `$8BEA` name-source subclass** (a HARDER shape,
diagnosed 2026-06-11): two name sources (`selected_province_owner` @ $8C17 vs `fief_owner(defender)` @ $8C26)
reconverge at `$8C2A`, but that block's FIRST op is `LOADR_qimm 9` — a regR load that is regA-NEUTRAL; the actual regA
consumer is the `MULT` two ops later (`base*9+$77A8`). `value_merge_phis` only inspects `blk[0]`, so it can't see the
consumer hiding behind the regR-load → the selected_province_owner base is dropped. **Fix is NOT a consumer-set add** —
it needs the check to scan PAST leading regA-neutral ops to the first op that READS regA (a per-op "reads-regA"
classification), with a broader blast radius. Left for attended work, not the unattended pass.

**Bug 1.2 root cause (diagnosed 2026-06-10):** the value-merge phi family (`value_merge_phis`/`consuming_phis`/
`return_phis`/`push_phis`, keyed by `tag_addr`) that landed 1.1/1.4 covers **if/else** merges, but `dream.py` DEFERS
switches (line ~213 "switch predicates handled later"; Rung-1 scope ~line 374 = "no switch dispatch"). So switch arms
carrying DIFFERENT values (e.g. `$8B8A` side_resource_ptr(arg1)+0/+2/+4 per case) collapse to one arm. The fix is a
real dream.py switch-handling extension (apply the phi machinery across switch cases), NOT a quick override. **The
certified census needs the full differential harness** (oracle vs a 4-c executor / DREAM-AST evaluator) — the
structural "duplicate arm-address line" proxy gives 29 candidates but most are legit (shared loop bodies, jump tables).
Snapshot of the pre-fix corpus is at `/tmp/all_banks_before_1_2.c` for a regression-diff gate.
| 1.3 | 32-bit ext-op math chains render as a placeholder `return <local>` | ✅ FIXED 2026-06-10 (certified body-override `_EXTOP_OVERRIDE`, wired at `vm_decompile.py:946`; 0 `// ext_op` stubs remain) | **exactly 5 subs corpus-wide** (bank1 ×3, bank15 ×2, **bank0 ×0**) | `$8303 math32_muladddiv`, `$8357 ratio_times10_capped` |

**★ value-golden ORACLE built 2026-06-10 (`tools/value-oracle.py`).** Runs any VM sub from the REAL ROM via the
6502 emulator (na1dream.cpu6502/nobunaga_vm) → ground truth by construction. `certify-extop` proved all 5 ext-op
formulas against the ROM (and CORRECTED a wrong grounding: math32_2arg = (a*100)/(a+b), not a*b/c). Certified
formulas now in the toml `[CERTIFIED]` comments. This is the gate the whole capstone needed. **1.3 DONE 2026-06-10:**
the certified formulas ship as a 5-entry body-override (`_EXTOP_OVERRIDE`, `vm_decompile.py:55`/wired at `:946`) —
value-exact (oracle-certified, stronger than the CFG gate), bounded, no `// ext_op` stubs left. The general
aux-32-bit-stack modeling in DREAM stays deliberately unbuilt (not worth it for 5 subs). **Remaining 1.2 work:**
extend the oracle to a full differential census (oracle vs a 4-c executor) to find every value-merge sub, then the
dream.py fold fix.
| 1.4 | return-phi reached by a conditional-branch taken edge | ✅ FIXED 2026-06-10 | — | `$E80C` |

| 1.5 | SWITCH_contig case KEYS rendered as `offs+k` instead of `(k-offs)&0xFFFF` | ✅ FIXED 2026-06-11 | 6 subs (contig switches with offs!=0) | `$8C61`, `$8D5D` |

**Bug 1.5 (SWITCH_contig key rendering) — FIXED 2026-06-11.** The VM dispatch is `index = (value + offs) & 0xFFFF`
(vm_op_D5_switch @ $EC65: `clc; lda offs; adc regA`), so `offs` is a NEGATIVE bias (= -low_key) and the case VALUE for
slot k is `(k - offs) & 0xFFFF`. vm_disasm.py emitted `offs + k` (the author assumed `value - offs`), so a switch on a
variable not starting at 0 rendered garbage keys: `$8C61`'s cursor_row switch showed `case 65530..65541` for the real
keys `6..17`. Gate-INVISIBLE (the dispatch CFG / targets are correct; only the printed case LABELS were wrong) — found
by Chris READING the output. Fix: `vm_disasm.py:164` `(k - offs) & 0xFFFF`. Label-only (no CFG change): 6 subs, self-
check clean, deterministic. offs=0 switches were coincidentally already correct (no regression).

| # | Bug | Status | Blast radius | Example subs |
|---|-----|--------|-------------|--------------|
| 1.6 | Switch case whose terminator is a JUMP to a case-root that is ALSO the shared tail/merge is emitted with NO trailing break/goto → renders as a false FALL-THROUGH into the next case | 🟡 DIAGNOSED + CENSUSED 2026-06-17 (root cause pinned; emit-only) | **13 fall-through cases corpus-wide, of which ~6 are GENUINE** (bank_02 bit-count cascades `case 128/32/16/8: local11--`); the false ones are a subset (`$A2D2` confirmed; ~6 others need per-case bytecode check) | `$A2D2` (case 4 assassinate "falls into" case 5 arson) |

**Bug 1.6 (false switch fall-through) — FOUND 2026-06-11 during the pass-2 ninja read.** In
`effect_ninja_sabotage $A2D2` the C (`source/4-c/bank_01.c:2199-2201`) shows `case 4` (assassinate,
`ninja_mission_resolve_vs_defender`) with no break, falling into `case 5` (arson `town` drain) — but the
bytecode at `$A50D` is `JUMP $A41D` (to the shared charge/return tail), so arson NEVER runs after
assassinate. **Gate-INVISIBLE and most likely EMIT-only:** the hard gate proves gated structuring is
CFG-preserving 499/499, so DREAM's AST routes case 4 → `$A41D` correctly; `_emit_ast` just dropped the
visual `break`/`goto` to the shared tail, so the TEXT misleads (shows code that doesn't run) — same
class of "text wrong, behavior right" as 1.5, not a value bug. Found by READING the C against bytecode
(the "C looks off → drop to bytecode" backup).

**ROOT CAUSE PINNED 2026-06-17.** In `dream.py` `_case_region_tc` (~line 1153) a case's outgoing edge is
classified: `s == merge → break`, **`s in case_targets → fall-through (_ft_sink)`**, else → break. The ROM
sends case 4 (`$A509`) backward to **`$A41D`**, which is the **default case's root** (basic-C: `default: goto
L_A41D`) AND the shared report/charge/return tail — so `$A41D ∈ case_targets`, the edge is tagged `_ft_sink`,
and a BACKWARD jump to the default/merge renders as a silent fall-through. **C fall-through is only valid when the
target is the case emitted IMMEDIATELY NEXT and reached by a genuine fall (contiguous), NOT a jump.** Fix:
`_ft_sink` should apply only to the textually-adjacent next case; a jump to any other case-root (backward, or
skipping cases — esp. the default-as-shared-tail) must emit `goto L_X` (gotosink), not fall-through. CFG-invisible
(the AST routes correctly), so it needs a VISUAL/value check, not the CFG gate. **Census (2026-06-17): 13 non-empty
fall-through cases corpus-wide; ~6 are GENUINE cascades (bank_02 `local11--`/`terrain_class_idx--` bit-counts that
DO flow contiguously); the false ones are the subset whose case jumps away — confirm each via the basic-C
(`source/3-c-basic`) `goto L_X` vs contiguous flow.** Localized, attended (not unattended) work.

**Shared root cause:** value materialization across a control-flow join (if/else, switch, the 32-bit aux stack)
keeps only ONE arm's value. The proper fix is one AST-level change in `dream.py`'s fold — emit each arm's value to
the merge — plus a **value-golden harness** (assert 4-c expression values == V1/bytecode) that would catch this
entire class **at the gate** instead of by eye. The 32-bit ext-op case (1.3) additionally needs DREAM to model the
VM's aux 32-bit stack + ext-ops (`sign_extend16_to_32`/`umul32`/`sdiv32`/`add32`) rather than emitting a stub.

**Good news:** the remaining open bugs (1.2 name-source subclass, 1.6 false switch fall-through) are *bounded and
known* — text/value issues in a few math/formula + switch-emit spots, not a broad rot. (1.3 is now FIXED; 1.1/1.4/1.5
fixed.) Find any residual ext-op subs with `grep -l '// ext_op' source/4-c/bank_NN.c` (currently 0).

**Plan (decided 2026-06-10): DEFER the fix, finish grounding first.** The grounding pass is the quantification pass —
every affected sub gets hit, read against bytecode, and **flagged inline** in its toml comment (`grep -n 'DREAM\|ext-op\|value-wrong' mesen-labels.toml`).
When banks 1 & 0 are done we'll have the *complete* list and fix the decompiler as an informed capstone (value-merge AST
fix first — same family as the landed ones; 32-bit ext-op modeling only if the count justifies it; a heuristic gate-scan
for the patterns as the backstop). Fixing now would mean investing blind to the real scope.

---

## 2. Tooling & architecture — 🟡

- **2.1 `native-call-index` `CODE_BANKS` doesn't split native vs bytecode** → the switchable banks (0/1/2 share the
  `$8000-$BFFF` CPU window) get miscounted, which made the old `label-walk-prep --grounding` cursor unreliable for
  those banks. Worked around by **`bank-ground-order.py`** (derives the per-bank sub set from the C, not the address
  index). Proper fix: split `CODE_BANKS` into NATIVE vs BYTECODE sets. → [[tools-architecture-refactor]]
- **2.2 `tools/` is a flat ~111-file directory** — wants the package/architecture refactor (the standing
  [[tools-architecture-refactor]] goal).
- **2.3 Stale "loop" doc** — `grounding.md` §"The loop" describes the superseded stub-sweep cursor; the canonical
  flow is now §"THE FULL-VERIFY PROCEDURE". Harmless, but prune when convenient.

---

## 3. Label / documentation hygiene — 🟡

- **3.1 Chapter rename sweep (the biggest hygiene debt).** The mechanics chapters (`NN-*.md`) and many toml *comment
  bodies* cite OLD names from before this pass — e.g. `unit_record_ptr` (now `side_resource_ptr`),
  `test_unit_type_present_flag` (now `is_unit_present`). ~30 renames in bank 2 + growing in bank 1 mean prose drifts.
  The toml *keys* (`0xADDR`) are authoritative so nothing breaks, but a periodic find-and-update of chapter/prose
  references keeps the docs trustworthy. Do a sweep after each bank completes.
- **3.2 `const_two` → `skill_level`/`game_difficulty`** — the var IS the new-game skill level (1-5), but the rename is
  parked because it has a huge doc blast-radius (~35 read sites across all banks). Ticketed, not urgent.
- **3.3 Cross-bank same-address pairs are FINE** (not debt, noted to prevent re-alarming): `$83A2`, `$93AA`, `$85A7`
  legitimately name different subs in different banks (shared CPU window). Verify each is right for its bank; don't
  "fix" them.

---

## 4. Readability — 🟢

- **4.1 single-use-phi → ternary inline pass.** Collapsing `phi_X = a; ... phi_X = b; use(phi_X)` into a ternary
  where the phi is used once would make the 4-c read much cleaner. A `dream.py` post-fold pass.
- **4.2 synthetic-temp inlining — MEASURED 2026-06-11; trivial slice DONE, rest DEFERRED (low ROI).** Of 243 distinct
  `phi_*`/`dsel_*` temps corpus-wide: **210 (87%) are genuine downstream value-merges that MUST stay** (the faithful
  rendering — e.g. `phi_ret_8bd7`, read by an `if` AND a `return`). Only **~33 are inlinable** (~68 lines, ~0.5% of the
  12k-line corpus): **6 single-use + pure-RHS + adjacent → DONE** (`vm_decompile.inline_trivial_temps`, wired in
  `bank_subs` for the DREAM canonical only; provably value-preserving — single static use, pure RHS, adjacent, plus a
  guard against `T=a; T=b` reassignment; self-check + deterministic). The remaining **27 are the `$8B8A`-style per-arm
  temps** (every assign has its own adjacent use, shared name across switch arms) — they need a per-block LIVENESS pass
  to tell them from genuine merges, AND that pass is **NOT gate-protected** (copy-prop is CFG-preserving, so the CFG-iso
  gate is BLIND to a bad inline — it would need value-oracle verification). **Deferred: ~62 lines is not worth the
  liveness machinery + oracle harness; the phi density is mostly inherent.** Measurement script logic in this entry.
- **4.3 switch-tail-hoist + per-arm phi — CONFIRMED CROSS-GAME (ROTK, 2026-06-22).** Specimen `cursor_newline_wrap`
  (ROTK `$CB87`, a real `SWITCH_noncontig`): each arm renders as `phi_val = N; goto L_tail`, with the shared
  continuation (`text_cursor_col = phi_val; row++; wrap…`) living *inside case 1*. Two distinct cleanups: **(a)** the
  per-arm phi is the §4.2 deferred class (shared name across arms → needs liveness + value-oracle, NOT gate-safe);
  **(b)** NEW and separable — **switch-tail-hoist**: a STRUCTURER *placement* fix — DREAM/V2 emits the join node inside
  an arm + `goto`s instead of hoisting it after the `switch` with `break`s. This is **CFG-preserving → gate-safe**
  (unlike the phi inline), so it's the cheaper, lower-risk half. **ROI shift:** this is na1dream output verbatim
  (1368 `phi_*` in NA1's own 4-c — not a ROTK bug), so a fix lands on **every KOEI title at once** once na1dream
  graduates to `koei-nes`. The per-game ROI that made §4.2 "deferred, low" now multiplies across games — **reconsider
  (b) the tail-hoist at the koei-nes graduation.** Not a walk blocker: output is correct + nameable as-is.

---

## ★ Impact on the planned RE-ANALYSIS pass (Chris's next goal, 2026-06-10)

The point of grounding is to make `source/4-c/*.c` legible so a *second* pass (human AND LLM) can correct the
earlier reads and discover new structure from the readable C. Debt impact on that:
- 🔴 **The DREAM value-correctness bugs (§1) are the one thing that MISLEADS the re-analysis.** For the affected
  subs the C is silently WRONG (e.g. `math32_muladddiv` shows `return rate` but is `(rate*amount+9)/10`). A careful
  human sees the inline `value-wrong`/`ext_op` flag and drops to the bytecode — but **a bulk LLM pass reading the C
  as ground truth will faithfully reproduce the wrong logic.** → Fixing the decompiler (esp. the value-golden harness
  that *certifies* C-values == bytecode) is the natural BRIDGE between grounding and re-analysis. Small/bounded; bank 0
  has 0 ext-op subs, so finishing it completes the census. Do this capstone before the automated re-analysis.
- 🟢 **Everything else HELPS:** grounded names + struct fields (legible to both), the confidence tags + evidence
  expressions (an LLM re-judges rather than re-derives), `bank-ground-order.py` (leaves-first reading order), and the
  call cross-references (navigable graph).
- 🟡 The chapter rename-sweep (§3.1) is friction for a human cross-referencing chapters vs C, not a blocker.

## 5. NOT debt — policy on data structures (Chris, 2026-06-10)

The on-RAM **data structures are well-known and reliable** (the `$7001` province record, the `$6193` relations
matrix, the combat unit table, the turn-order array, etc.). **Use the known/established values; only flag a field if
something actively contradicts it.** This code-grounding pass verifies *code behavior*, not data layout — so items
like "`$7001` +24 field meaning", "`$76A9` writer unread", "`$7BEE` exact semantics", "`fief->header`" are **NOT
debt** — just fields this pass didn't independently re-derive. Trust the established map; don't spend the pass
re-grounding data structures.

---

## Quirks (game mechanics, for the record — not debt, just non-obvious)

- **Battle map is an isometric/diagonal grid.** It maps cleanly to the controller d-pad, which is why movement is
  6-directional (hex-style) and reads diagonal. Direction *codes* `{49,50,51,55,56,57}` → dirs 0-5; `52-54` are the
  deliberately-invalid keypad middle.
- **Combat phase windows:** a 5-cell zone sweeping +3 cells per phase (p0:0-4, p1:3-7, p2:6-10) — consistent across
  the validity gate, the coord transform, and the renderer.
- **Difficulty (`const_two`/skill 1-5) scales everything:** Grow gain ∝ `(6-skill)` (higher skill = less dev = harder,
  emulator-confirmed 76/60/46/30/14), combat-AI strength × `(115-skill*15)`, plus stat boosts / AI gates / event
  magnitude. ONE early-game selection ("Please select skill level.").
- **Sentinels:** `200`/`0xC8` = unit off-map; `selected_province_idx == 50` = "no province"; `effect_dam` returns
  `10000` when output is 0.
- **Packed byte `$6F65`:** unit-presence bits 0-4 AND the war/siege state in bit 7 (two prior comments each wrongly
  called the other "stale" — both were half-right).
- **`battle_strength_stat_weights` has 8 entries** (5 daimyo + 3 province: morale/skill/arms) — a prior note
  undercounted to 7 (dropped arms=15).
- **Bank 0's entry is `vm_bootstrap`** — named for being the first sub the VM calls at game start (the main loop).
- **The clean guessed names lie as often as the stubs** — ~40 already-`[HIGH/MED CONFIRMED]` bank-2 comments had wrong
  polarity / side / return value. This is *the* finding that justifies the full-verify bar.
