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
| 1.2 | Arms reconverge at a shared SUFFIX op → only one arm's value kept | 🔴 OPEN | a handful (not yet scanned corpus-wide) | `$8B8A` (switch +2/+4 offset collapses to 0), `$8BEA` (name-source dropped) |
| 1.3 | 32-bit ext-op math chains render as a placeholder `return <local>` | 🟡 CENSUSED + CERTIFIED 2026-06-10 (formulas known; DREAM emit-fix pending) | **exactly 5 subs corpus-wide** (bank1 ×3, bank15 ×2, **bank0 ×0**) | `$8303 math32_muladddiv`, `$8357 ratio_times10_capped` |

**★ value-golden ORACLE built 2026-06-10 (`tools/value-oracle.py`).** Runs any VM sub from the REAL ROM via the
6502 emulator (na1dream.cpu6502/nobunaga_vm) → ground truth by construction. `certify-extop` proved all 5 ext-op
formulas against the ROM (and CORRECTED a wrong grounding: math32_2arg = (a*100)/(a+b), not a*b/c). Certified
formulas now in the toml `[CERTIFIED]` comments. This is the gate the whole capstone needed. **Remaining 1.3 work:**
make DREAM emit these (a 5-entry body-override, like the enum table — safe, bounded) instead of the ext-op stub.
**Remaining 1.2 work:** extend the oracle to a full differential census (oracle vs a 4-c executor) to find every
value-merge sub, then the dream.py fold fix.
| 1.4 | return-phi reached by a conditional-branch taken edge | ✅ FIXED 2026-06-10 | — | `$E80C` |

**Shared root cause:** value materialization across a control-flow join (if/else, switch, the 32-bit aux stack)
keeps only ONE arm's value. The proper fix is one AST-level change in `dream.py`'s fold — emit each arm's value to
the merge — plus a **value-golden harness** (assert 4-c expression values == V1/bytecode) that would catch this
entire class **at the gate** instead of by eye. The 32-bit ext-op case (1.3) additionally needs DREAM to model the
VM's aux 32-bit stack + ext-ops (`sign_extend16_to_32`/`umul32`/`sdiv32`/`add32`) rather than emitting a stub.

**Good news:** both open bugs are *bounded and known*, concentrated in math/formula primitives — not a broad rot.
Find ext-op subs with `grep -l '// ext_op' source/4-c/bank_NN.c`.

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
