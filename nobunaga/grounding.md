# Grounding pass — method + ledger

The decompiler now emits readable game-C (DREAM canonical, 495 subs). This pass makes the
**labels and the mechanics docs trustworthy**, which they are not yet: the existing names and
their toml comments came from a low-fidelity first pass that prioritized breadth (give every
sub *a* name) over correctness. **Everything prior — names AND comments AND the chapter docs
derived from them — is a SUSPECT to be re-grounded, not a fact to be trusted.**

This is a distinct *mode* from that first pass:

| first pass (`label-walk`) | grounding pass (this doc) |
|---|---|
| breadth-first coverage | depth-first correctness |
| name the *anonymous* subs | re-confirm / correct the *named* ones too |
| prior names = trusted seeds | prior names = suspects |
| name + one-line comment | name + **evidence** + **confidence** + recovered **mechanics** |

We reuse `label-walk`'s machinery (leaves-first call-graph cursor, seed assembly) but flip the
job from "name the blank" to "ground-truth it, lowest layer first."

---

## Settled framing

- **★ THE BAR IS FULL VERIFICATION, not the stub sweep (Chris, 2026-06-10).** A bank is NOT "done"
  when its address-tagged (`_<4hex>`) stubs are gone — those are merely the *self-confessed* suspects.
  EVERY sub gets read against its bytecode, because the clean, descriptive names are the more dangerous
  ones: `unit_record_ptr`→`side_resource_ptr` had a confident name AND a prior `[HIGH CONFIRMED]` tag and
  was wrong ("+4 = hp" was actually "men") — caught only because it sat in a keystone's call path. The
  stub sweep under-covers exactly that class. "Bank 2 complete" in the ledger means **stub-sweep complete
  (0 address-tagged)**; full verification of bank 2 is tracked separately (17/131 as of 2026-06-10).
- **The bottom-up worklist tool: `py -3 tools/bank-ground-order.py <bank>`** (`--todo` hides already-dated,
  `--json` for automation). Emits EVERY sub in the bank leaves-first by call-graph depth (reuses
  native-call-index's fused graph), annotated `SUSPECT`/`dated`/`todo`. Depth 0 = calls no other in-bank
  sub (only grounded other-bank helpers, e.g. bank 15) ⇒ groundable NOW; the roots (battle_init_driver
  depth 13, etc.) land last, read against already-grounded callees. This is the "flush out the call tree"
  Chris asked for — grind the list top-to-bottom and the top-level routines arrive already-clarified.
- **Direction: leaves-first up the call graph.** A leaf is the only thing nameable with
  confidence in isolation (no unnamed callee hiding its meaning); naming it propagates up to
  every caller for free. This mirrors the project's own recurring lesson — *topological order
  beats address order everywhere.* Completeness comes from covering a **call-graph layer to
  exhaustion**, not from a linear "walk from the start" (code is a tree; there is no start).
- **Pass 0 = the native 6502 / Bank-15 floor.** The true leaves under the VM. See *Layer ID*.
- **Two outputs per grounded routine, not one:** (1) a grounded label in `mesen-labels.toml`;
  (2) any recovered *rule* promoted up into the matching mechanics chapter (`NN-*.md`). A
  chapter claim that can't be re-grounded gets marked provisional, not left masquerading as fact.
- **Misread ⇒ a decompiler-3% flag.** If a routine won't read right after honest effort, suspect
  the decompiler before the label: hand-decompile the raw bytecode (the loop that found the
  value-merge phi bugs — the CFG gate is value-blind, only *reading* catches these). Log it.

### Layer ID (do this first — you cannot tell from the address)
`$D772` *looked* like fixed-bank native 6502; it is VM bytecode in the fixed bank. Rule, per
Chris: **the bytecode compiler has claimed every VM routine, so —**
- in the bytecode-routine set (has a VM sub / `vm_disasm` decodes it) ⇒ **VM** → read
  `source/4-c/bank_NN.c` + `py -3 -m na1dream.vm_disasm <bank> --sub <ADDR>`.
- not claimed ⇒ **6502 or data** (Mesen separated these by execution-marking over time) → read
  `source/1-asm-6502/bank_15*.asm`. This native code lives mostly/entirely in **Bank 15**;
  no mixed code has been seen in the other banks. *(Pass-0 worklist = bank-15 code the bytecode
  compiler did NOT claim — deterministically enumerable.)*

---

## The loop (proven on `$D772`, below — run N of these per session)

1. **Pick** the next leaf from the grounding cursor
   (`py -3 tools/label-walk-prep.py <bank> --grounding`) — lists the still-`_XXXX`-suffixed
   (suspect) subs ranked **high-fanout first** (inbound call sites = leverage). Take the top.
2. **Layer-ID** it (VM vs 6502 — see above). Choose the view accordingly.
3. **Read the authoritative body.** Reduce an accessor to a one-line semantic; trace full logic
   otherwise.
4. **Fact-check the existing name/comment as a suspect** → confirm / amend / refute. Never harvest
   a prior note as truth.
5. **Name from behavior** (house style: read-at-the-call-site, e.g. `fief_owner` not
   `ui_helper_d772`); record the **evidence expression** + a **confidence tag**.
6. **Apply** to `mesen-labels.toml`, **regenerate** (`py -3 -m na1dream.cli.decompile_all`),
   **spot-check** 2–3 call sites now read right. Log the rename old→new (chapters cite old names).
7. **Mechanics → chapter** (`NN-*.md`) if the routine encodes a rule; accessors have none.
8. **Ledger + advance the frontier** (below).

### Conventions
- **Where labels live:** `mesen-labels.toml` — `[prg.bankN]` `"0xADDR" = {name, comment}` for code
  labels; `[vars.bankN."0xADDR"]` for per-sub slot/variable names; `[ram]` for ZP/RAM.
- **Confidence tag** (formalize the emergent toml convention) in every grounded comment:
  `[<LEVEL> <STATUS> <DATE>]` — LEVEL ∈ HIGH/MED/LOW (certainty), STATUS ∈
  CONFIRMED / PROBABLE / AMENDED / REFUTED / OPEN. The comment MUST carry the evidence expression
  (the recovered one-liner or the key trace), so the next session can re-check without re-deriving.
- **Only CONFIRMED facts flow up into the `.md` chapters** as grounded; everything else stays
  provisional in the toml.
- The generated C (`source/4-c/*.c`) is NEVER hand-edited — change the toml and regenerate.

---

## Decompiler 3% backlog (misreads found by reading — the other output of this pass)

### DREAM fold clobbers if/else phi-temp merges (value-wrong 4-c, V1 correct)   [FIXED 2026-06-10]
Found while grounding bank-15 leaves ($DB6E, $D687). **DREAM's structured output (`source/4-c`) was
VALUE-WRONG** for an if/else whose arms set a front-end phi temp: it dropped the if-arm's skip-over-else
and emitted the else-arm's `phi = <default>` UNCONDITIONALLY after the `if`, so the conditional value
was dead. The V1 raw witness (`source/3-c-basic`) was CORRECT — a block-ATTRIBUTION bug, not a value
bug. **Root cause:** `consuming_phis`/`push_phis` tagged the fall-through pred's materialise at the
MERGE address (the capture site), so DREAM — which buckets lines into blocks BY ADDRESS TAG — placed it
in the join block. `return_phis`/`value_merge_phis` already carried a separate `tag_addr` (the pred's
own block) for exactly this; `consuming_phis`/`push_phis` never got it. **Fix (commit pending):** both
now return a `tag_addr` (fall pred → its last-instr/block addr; jump pred → the jump addr), and the
decoder emits the materialise line via `state.lines.append((tag, …))` not `state.emit(...)`. Mirrors
the $E80C return-phi fix. **Result:** clobber-pattern scan 42 → 11, and all 11 are FALSE POSITIVES
(sibling-branch / conditional-overwrite). $DB6E/$D687/$9FFA now render correct if/else. Gates green:
CFG 499/499 (dream + v2), 114/114, stack-audit 187, round-trip clean. **Gate-invisible** still — found
only by READING (the recurring [[decompiler-method-reframe]] lesson); a value-golden harness would catch
this class at the assertion level.
- **Confirmed cases:** `$DB6E draw_province_lord_name` — 4-c always `redraw_window(msg_no_lord)`, raw
  correctly picks `daimyo_name_table[owner]` vs `msg_no_lord`. `$9FFA` (bank 1) — 4-c always
  `msg_debt_what_debt`, raw picks `msg_no_gold` vs `msg_debt`. `$D687` season-string select (same shape).
- **Scope:** a heuristic scan (`phi_X` assigned in a block, then re-assigned a *different* rvalue at
  shallower indent before use) flags **~42 candidate sites across all 4 banks** — incl. message pickers
  (`no_gold`/`no_rice`/`no_peasants`…), a 4-way coord merge (`phi_d2ec_0..3`), swapped province pairs
  (`phi_e0a2_*`). Upper bound (some may be legit sequential reassigns); needs triage.
- **Impact on grounding:** the 4-c oracle (what we READ to ground) is value-wrong here — for any sub
  hitting this shape, read the **raw `3-c-basic`** form. **Fix = the AST analogue of the front-end
  clobber fix:** emit each arm's phi assignment INSIDE its arm / keep the skip, in `dream.py`'s fold.

### Arms reconverging at a shared SUFFIX op → per-arm value collapsed (value-wrong 4-c)   [OPEN 2026-06-10]
Two confirmed bank-2 cases. The shape: branch/switch arms each compute a different value, then **jump to a shared
tail** that applies a common op (DEREF, `*9+table`, etc.); DREAM keeps only ONE arm's value for all, dropping the
others. Gate-invisible; found by reading.
- `$8B8A draw_side_resource_field` — `SWITCH_noncontig` cases differ by `ADD_qimm` before a shared `DEREF`: 4-c shows
  all 3 as `side_resource_ptr(arg1)` offset 0, but bytecode is +0/+2/+4 ($8BD8/$8BE1) = gold/rice/men.
- `$8BEA combat_unit_window_refresh` — if/else arms compute `selected_province_owner()` ($8C17) vs `fief_owner(defender)`
  ($8C26), reconverging at the shared `*9 + $77A8` tail ($8C2A): 4-c renders fief_owner(defender) for BOTH; the
  `selected_province_owner` call shows as a bare discarded statement.
**Impact:** any sub whose branches feed a shared downstream op reads value-wrong in 4-c — verify vs bytecode/`3-c-basic`.
Not yet scanned corpus-wide; likely a handful. **Fix = AST analogue of the front-end clobber fix** (keep each arm's
value to the merge), in `dream.py`'s fold.

### `$E80C` — return-phi reached by a conditional-branch taken edge   [FIXED 2026-06-10]
**Root cause (not "boolean arm" as first hypothesized):** `return_phis` bailed on ANY pred ending in
a conditional branch (`else: ok=False`). `$E822`'s preds are the `JUMPF` branch block (taken edge →
RETURN) + the call block (fall-through), so the merge was abandoned and the call-valued fall arm
leaked to the RETURN, firing `call_bank_wrap(14)` UNCONDITIONALLY. **Fix:** accept a pred whose
conditional branch's taken edge IS the merge — `branch_z/nz` emit `if(regA) goto` and don't touch
regA, so capture regA at the branch; and carry a `tag_addr` (return `{site:(merge,tag)}`) so DREAM
buckets the fall-arm capture INTO the arm, not after the join (the value_merge_phis DREAM-vs-linear
placement lesson, re-applied). **Blast radius: 49 merges / 48 subs — 21 SERIOUS (a side-effecting
call made unconditional: `$E80C`, `$87B7` draw_tactical_terrain_feature, `redraw_window` `$CEC4`,
`find_record` `$E554`, +17) + 28 value-only regA leaks.** Gate-invisible (CFG identical, value/effect
differ) — found by READING e80c while grounding. Gates after fix: 114/114, CFG hybrid 495/495
witness + 495/495 CFG-preserving (0 fallbacks), stack-audit 184. Lives in `vm_cfg.return_phis` +
`vm_decompile.py` ret_phi hook. `$E80C` itself now reads `if(ai_turn_flags&4){mem_7FCB=arg1; return
call_bank_wrap(14);} return 0;` — grounding of its NAME still pending (a conditional bank-14 dispatch).

## Ledger (append-only, newest first)

### Bank 2 full-verify batch #14 — attack resolution + menu input (115/131, 87%)   [2026-06-10]
- `$9E20` `tally_unit_type_then_check_strength_parity_50` → **`resolve_attack_apply_mutual_casualties`** — the prior note
  MISSED the actual damage step: it applies casualties to both sides (own loses 100-pct%, enemy loses pct% of strength),
  feeds town-chaos, returns 0/1/2 (parity/win/loss). The core melee resolver.
- `$86F9` `select_entry_from_b52f_table_by_cursor` → **`select_menu_entry_by_cursor`** ($B52F is a string prompt, not a table).
- `$A0DA` attack-and-announce wrapper, `$8669`/`$8561` menu/input loops, `$9865` AI advance, `$9954` rng rect search:
  re-grounded. Next: rows 1-7 (~16 left).

### Bank 2 full-verify batch #13 — AI combat tactics + cursor input (108/131, 82%)   [2026-06-10]
2 polarity/meaning refutes:
- `$A4FC` `max_enemy_unit_type_strength_pct` → **`min_own_strength_pct_vs_list`** — keeps the MIN (worst matchup),
  not the max (accumulator starts 100, takes smaller).
- `$A84D` `ai_clear_province_state_when_strong_enough` → **`ai_claim_province_when_strong_enough`** — it SETS
  province_ai_state=5 + relocates capital (claims the province), doesn't 'clear to 0'; gate is NOT-outmatched + has-rice.
- `$8623` poll_cursor (fixed wrong-bank effect_view_c ref), `$98FE` seek-enemy-adjacent, `$9810` AI placement,
  `$9B4A` attack-targeting blink (audio cue + cursor), `$AB6A` (returns 1 not 0): re-grounded. Next: rows 1-7.

### Bank 2 full-verify batch #12 — AI movement/input layer (101/131, 77%)   [2026-06-10]
Well-named depth-4 layer; 1 rename + detail fixes:
- `$8488` `read_button_press` → **`read_dpad_dir_code`** (maps d-pad to the 48-based hex-grid direction code).
- `$97D9` `commit_unit_move_and_redraw_count` ✅ — added the cur_combat_unit_slot++ the prior note missed.
- `$A4BC` `find_strongest_unit_type_by_strength` ✅ — added the arg2 threshold (255 if best% < threshold); metric is the
  strength RATIO. `$A3BD` `ai_step_unit_toward_target` ✅ (bfs + place), `$A194` ai placement, `$9D9A` ratio<50,
  `$85A7` cursor input: re-grounded. `$85A7` is a same-addr cross-bank pair (bank-1 effect_view_c). Next: rows 1-7.

### Bank 2 full-verify batch #11 — combat resolution + attack command (94/131, 71%)   [2026-06-10]
3 renames (1 polarity refute):
- `$A7E5` `ai_test_own_double_ge_enemy_total_strength` → **`ai_own_double_lt_enemy_total`** — code is `2*own <
  enemy_total` (LESS-than), the comment said `>=`. Exact polarity flip.
- `$A0AD` `enemy_unit_type_present_at_unit_tile` → **`is_enemy_unit_adjacent`** — checks 6 neighbors, not "the tile".
- `$92CA` `battle_init_clear_defending_province_fields` → **`battle_init_defender`** — loads war_defender_*; confirms
  $7001 record offsets (+0 gold / +6 rice / +16 men).
- `$9058` `place_unit_at_tile_if_free` ✅ (AI-move commit) / `$A9FB` `combat_command_select_target_resolve_attack` ✅
  (player attack) / `$8D5D` `draw_combat_roster_window` ✅. `$A721` rng gate is rng_mod(skill+1) not 3. Next: rows 1-7.

### Bank 2 full-verify batch #10 — placement/move/flee command layer (87/131, 66%)   [2026-06-10]
Integration layer — ties together a dozen session-grounded subs. 2 renames (both refutes):
- `$95BE` `draw_tactical_cursor_region_arg0` → **`erase_cursor_advance_phase`** — not a thin wrapper; it erases the
  cursor then ADVANCES tactical_battle_phase by cursor column (prior note missed the phase logic entirely).
- `$9735` `tile_blocked_by_existing_unit_in_placement` → **`tile_blocked_for_placement`** — REFUTED 'iterates 6 unit
  slots': it steps 6 DIRECTIONS from find_free_tactical_placement_cell.
- `$9792` `commit_unit_dest_tile_if_valid` ✅ — 4-guard move validator (returns 1 not 0); integrates is_any_unit_at_tile
  + is_map_cell_blocked + tile_blocked_for_placement + is_coord_in_combat_rect.
- `$AAA7` `combat_flee_to_fief_command` ✅ — CONFIRMS the 'flee' framing ($90BB+$912B+$91A1 chain).
- `$9D75` grounds math32_2arg = floor(100*A/(A+B)); `$A221` bfs (0xC2 blocking mask); `$9DA8` town-chaos ($7005=+4). Next: rows 1-7.

### Bank 2 full-verify batch #9 — AI strength keystone + battle setup (80/131, 61%)   [2026-06-10]
- `$9C88` `ai_eval_battle_strength_total` ✅ — THE keystone summing every AI strength term grounded this session.
  **Found the difficulty knob:** mod = `115 - const_two*15` (const_two = the skill level 1-5, $6D63) when the side is
  AI → 100/85/70/55/40 — a difficulty-scaled combat-AI handicap. Old note ('30 or 100') corrected.
- `$91D5` `distribute_damage_across_unit_types` → **`distribute_men_into_unit_strengths`** — REFUTED 'damage': splits
  the army's MEN (side_resource+4) into the 5 unit_strength columns by province_unit_type_pct ($76A9, now labeled).
- `$8B58` `draw_valid_unit_field_cells` → **`draw_unit_counts_in_valid_cells`**.
- `$8C61` `draw_unit_roster_columns` ✅, `$A07A` `find_adjacent_unit_around_tile` ✅, `$8544`/`$8B25` ✅ re-grounded.
Next: rows 1-7.

### Bank 2 full-verify batch #8 — AI strength terms + battle resolution (73/131, 55%)   [2026-06-10]
- `$AD86` `halve_defender_province_stat_for_exposed_units` → **`halve_defender_morale_for_breaching_attackers`** —
  REFUTED side: it loops ATTACKER (side-0) units ON placeable cells (bit 32 SET) to halve the DEFENDER's morale
  ($7013+def*26 = the $7001 record's +18 morale), not "defending province's units / not-on-blocked-cell".
- `$8FEC` `find_unit_at_tile` → **`is_any_unit_at_tile`** (returns bool, either side).
- `$9C04` `ai_province_stat_diff_term` ✅ — pins $7013 = the $7001 record's morale/skill/arms (+18/+20/+22) sub-block.
- `$A0F3` `build_reachable_enemy_target_list` ✅ (6 hex dirs, 1 step each), `$9C69`/`$93AA`/`$AE2C` ✅ re-grounded.
- Noted `$93AA` is a same-CPU-addr/different-bank pair (bank-2 announce vs another bank's ravage_defender_loyalty).
Next: rows 1-7.

### Bank 2 full-verify batch #7 — terrain/map render + init (66/131, 50%)   [2026-06-10]
Well-named region (breadth pass was solid here) — mostly confirms + cross-links, 1 rename, 1 polarity fix:
- `$87B7` `draw_tactical_terrain_feature` — REFUTED bit-2 polarity: draws when cell is CLEAR of bit 2 (bit 2 = water/border = skip), not set.
- `$929C` `reset_unit_field_grid_to_200` → **`clear_all_unit_positions`** (off-maps all 10 units to 200).
- `$8903` `map_populate` ✅ (the populator vs map_render_driver) / `$87B7`+`$8903` share the bit-2 land/water test.
- `$84F7` `step_coord_by_direction` ✅ (4 cardinal dirs + is_tile_in_bounds), `$9BB4` `ai_terrain_strength_term` ✅
  (terrain class 32/16/8->0/1/2/else 3 -> strength multiplier), `$8D39` `draw_combat_fief_day_header` ✅,
  `$912B` `paged_flee_fief_list_display` ✅ (paginates the $6F4F list). Next: rows 1-7. **Halfway through bank 2.**

### Bank 2 full-verify batch #6 — depth-1 unit/cell predicates + fief render (59/131)   [2026-06-10]
2 renames + 2 inverted-comment fixes:
- `$9030` `is_battleside_province_aistate5_and_not_resting` → **`battleside_not_state5_or_resting`** — comment was the
  exact NEGATION of the code (`state!=5 || resting`, not `state5 && !resting`).
- `$8FC0` `find_unit_slot_by_fields` → **`side_has_unit_at_cell`** (returns a bool, not a slot).
- `$9647` `find_free_tactical_placement_cell` ✅ — corrected bit-32 polarity (matches SET=placeable, not clear) + the
  output col/row were swapped in the note.
- `$A04E` `is_unit_at_coords` ✅ (specific unit) / `$8FC0` (any of a side) — now a clean pair.
- `$94F6` `announce_combat_side_daimyo_and_status` ✅, `$A01A` `unit_type_count_gt3...` ✅, `$813C`
  `build_blit_fief_tile_block` ✅ (re-grounded; refs updated to combat_message_table/is_unit_present).
Next: rows 1-7.

### Bank 2 full-verify batch #5 — depth-1 combat predicates + render (52/131)   [2026-06-10]
4 renames (incl. a total refute) + a 2nd DREAM value-bug confirmed:
- `$836A` `unit_damage_within_strength` → **`side_has_rice_for_day`** — TOTAL refute: it's ceil(men/15)<=rice (daily
  ration check; caller applies STARVATION on false), not damage/strength. Was a victim of the refuted unit_record_ptr.
- `$8F97` `clear_unit_status_flag_set_field_200` → **`remove_unit`** — clears presence bit + off-maps (200); renamed
  data `$B5B9` -> `unit_presence_clear_masks` (ROM-verified ~(1<<n) masks).
- `$97F8` `test_cur_unit_slot_present` → **`is_cur_unit_absent`** (returned the negation — name read backwards).
- `$9019` `test_map_cell_blocked_c2` → **`is_map_cell_blocked`** (mask 0xC2 = bits 7,6,1).
- `$8EF5` `ai_attacker_outstrengths_defender` ✅ — THE AI engage/avoid gate (ai_sum_battle_strength then compare).
- `$8977` `render_combat_map_screen` ✅ / `$8BEA` `combat_unit_window_refresh` ✅ — but `$8BEA` exposed a **2nd
  arms-reconverge DREAM value bug** (attacker name selected_province_owner dropped); backlog entry generalized.
Reconfirms: $6F65 bits 0-4 = presence (remove_unit clears them), side_resource +2/+4 = rice/men. Next: rows 1-7.

### Bank 2 full-verify batch #4 — last depth-0 leaves + first depth-1 (render/prompt) (45/131)   [2026-06-10]
- `$8B8A` `draw_unit_stat_field` → **`draw_side_resource_field`** — draws side gold/rice/men. **Found a NEW DREAM
  bug:** the switch's per-case +2/+4 offset collapses to 0 in 4-c (value-merge in a SWITCH); bytecode @
  $8BD8/$8BE1 has ADD_qimm 2/4. Logged in the decompiler-3% backlog [OPEN]. Refuted the 'unit stat / unit_record_ptr' note.
- `$AB37` `redraw_combat_side_window` ✅ — REFUTED branch desc: slot-0 draws combat_message_table[18/19] keyed on
  war bit-7 (test_6f65_bit7), clear is unconditional (prior note had it backwards).
- `$840B` `draw_tactical_cursor_region` ✅ — 16-sprite 4x4 cursor (draw at col<<3; erase parks at 248,248).
- `$89DF` `draw_unit_count_digits` ✅ — on-map troop count via $6FE5+side*9 digit buffer + war-marker tile 178/179.
- `$91A1` `prompt_select_province_from_list` ✅ — validates pick against the $6F4F list (built by $90BB — cross-link).
- `$910C` `prompt_hit_any_key_return_button` ✅ / `$AD38` `display_morale_falling_message` ✅ (re-grounded).
Cross-confirms piling up: test_6f65_bit7 (bit-7 war state) reaffirms the batch-1 packed-$6F65 finding; cursor/digit
render reuse the phase-window geometry. Next: rows 1-7 of `bank-ground-order.py 2 --todo`.

### Bank 2 full-verify batch #3 — 7 depth-0 leaves, combat-strength + conquest layer (38/131)   [2026-06-10]
Heavy refute batch — **5 prior comments wrong, 1 rename**:
- `$8E5C` `ai_sum_battle_strength` ✅ — the **WRITER of battle_side_strength_mod** ($7BEA/$7BEC), closing batch-2's
  open loop. 8-stat weighted tally: each won stat adds its weight; side that wins. **Found weight table is 8 not 7**
  (ROM @ $B5B1 = 5/10/10/5/20 daimyo + 10/25/15 province morale/skill/ARMS, 0xFE term) — corrected
  `battle_strength_stat_weights` (prior note missed arms=15) + upgraded `$7BEA` (writer now known).
- `$8F55` `clear_unit_combat_flags` → **`end_war_relocate_capital`** — clears war bit7 + RELOCATES the daimyo capital
  (from_fief=0, to_fief=1). REFUTES old name + comment ('zeros both' — to_fief is SET).
- `$8F28` `validate_dir_code_and_dispatch` — REFUTED polarity: rejects {52,53,54}, dispatches {49-51,55-57}->dir 0-5
  (not 'returns 0 if >=55'). Calls coord-stepper $8003 (bank-2 $8003 still unground).
- `$90BB` `build_daimyo_province_list` ✅ — corrected reversed syscall arg order (src $6F4F -> dst deduped_owner_list).
- `$970A` `is_coord_in_combat_rect` ✅ — cleaned the garbled comment (arena rect $6FF6/$6FFA x, $6FF8/$6FFC y).
- `$8B39` `draw_combat_day_header` ✅ / `$A148` `find_flagged_present_unit_type` ✅ (re-grounded).
Mechanic captured: **battle strength = weighted stat-comparison** (skill 25 > IQ 20 top terms) feeding the AI engage/avoid
decision. Next: rows 1-7 of `bank-ground-order.py 2 --todo`.

### Bank 2 full-verify batch #2 — 7 depth-0 leaves, the tactical-render layer (31/131)   [2026-06-10]
All 7 names CONFIRMED accurate (cleaner than batch #1) — value was sharper comments + cross-confirmations + 1
arg-order fix + 1 new var label:
- `$885E` `map_render_driver` ✅ — renders the **5-cell phase window** (screen X=i*4+10, src=(phase*3+i)*88+$7BFD)
  + background upload + phase-conditional scroll arrows (cols 11/27). Locks together with batch-1's
  `is_cell_valid_for_phase` (5 cells, +3/phase) + `calc_tactical_cell_coords` (*4+10, phase*3). Render pipeline solid.
- `$83C6` `lookup_terrain_attr_record` ✅ — terrain bit->type map (32->0,16->1,8->2,128->3,4->4,64/none->5), stride-16
  table; renamed data `$B11E` -> `terrain_attr_table`.
- `$8E40` `ai_score_strength_term_40pct` ✅ — base + pct(pct(base,40), per-side mod[$7BEA]); side 0=atk/1=def.
  Labeled `$7BEA` -> `battle_side_strength_mod` (writer unread, role clear).
- `$822A` `prompt_yes_no` ✅ — A(0x40)->1 echo 'Y'(89), B(0x80)->0 echo 'N'(78).
- `$8792` `prompt_province_selection` ✅ — cursor pick (reused for combat unit-target, list-size 5).
- `$882A` `upload_map_cell_tiles` ✅ — **CORRECTED** the prior comment's reversed syscall arg order + swapped src/dst.
- `$900A` `wrap_index_0_2_to_zero` ✅.
Next: `bank-ground-order.py 2 --todo` rows 1-7 (next depth band begins).

### Bank 2 full-verify batch #1 — 7 depth-0 leaves (24/131)   [2026-06-10]
First batch under the **full-verification** bar (`bank-ground-order.py 2 --todo`, leaves-first). 7 highest-fanout
depth-0 predicates/accessors — 5 names confirmed, 2 refined, **3 comments REFUTED**, 1 var corrected:
- `$838F` `get_battle_side_province` ✅ — side 0=attacker(selected_province_idx), !=0=defender(battle_defending). 25 callers.
- `$82FF` `is_no_province_selected` ✅ — selected_province_idx==50 sentinel (valid fiefs 0-49).
- `$8F11` `is_tile_in_bounds` ✅ — col<=10 & row<=4 (the tactical grid is 11x5).
- `$83A2` `calc_tactical_cell_coords` ✅ — in-place (col,row)->screen; *col scrolls by phase*3. **Found a mis-keyed
  DUPLICATE `0x83A2` (province_window_redraw_ba6f = a BANK-1 $BA6F label) — log for bank 1.**
- `$8F79` `test_unit_type_present_flag` → **`is_unit_present(side,slot)`** — bytecode-verified it indexes $6F65
  (LOADL 12,+$6F65,BYTE_DEREF,>>arg2,&1), **REFUTING the $6F65 var note's "indexes $6DA2" claim**. $6F65[side] is a
  PACKED byte: bits 0-4 = unit presence, bit 7 = war state. Amended the $6F65 comment.
- `$82DB` `test_map_cell_bits` → **`is_cell_clear_of_bits`** — old comment had the polarity backwards on BOTH counts
  (returns 1 = off-map OR no masked bits; 0 = bit set). REFUTED.
- `$960E` `is_cell_valid_for_phase` ✅ name, **comment REFUTED** — real per-phase windows p0:0-4, p1:3-7, p2:6-10
  (5-cell window, +3/phase); cross-confirmed by $83A2's phase*3 scroll. Old note dropped the low bound + flipped phase2.
**Lesson reinforced:** even `[HIGH CONFIRMED]` leaves had wrong comments — full-verify is earning its keep. Next:
`bank-ground-order.py 2 --todo` rows 8-14.

### ★ BANK 2 GROUNDING COMPLETE ★ — the 3 combat-UI tail suspects   [2026-06-10]
**Bank 2 (tactical combat engine) is fully grounded: 0 suspects (0 pure `_XXXX`, 0 address-tagged).** The
final 3, all read from the ROM (not guessed) — pulled actual strings out of `Nobunaga's Ambition (USA).nes`:
- `$8270` `set_combat_state_pair_7bf5_7bf7` → **`set_tactical_cursor_pos(cell,row)`** [HIGH] — writes the
  confirmed tactical-cursor pair $7BF5(col)/$7BF7(row); draw_tactical_cursor_region ($840B) consumes it.
- `$936A` `draw_combat_ui_string_b196` → **`draw_combat_message(idx,slot)`** [HIGH] — draws combat
  announcement string #idx from the $B196 table for a unit slot. **Renamed `jumptab_b196` →
  `combat_message_table`**: ROM-verified ≥10 entries ([3] "You can`t move there!", [5] "Enemy unit %d has
  been..", [7] "Unit %d has been wiped out", desertion/counter-attack/upper-hand). Caller picks 5(enemy)/7(own).
  Also `$B626` `draw_combat_ui_string_data_b626` → **`combat_msg_blank_str`** (just a leading NUL = blank line).
- `$9387` `draw_unit_label_b627` → **`draw_unit_type_label`** [HIGH] — draws "unit %d\n%s" = slot+1 + a
  unit-type name. **Renamed `draw_unit_label_data_f9af` → `unit_type_name_table`** + added 3 string labels:
  ROM-verified the 3 NA1 unit types = **'Rifles' / 'Infntry' / 'Cavalry'** ($F9B5/$F9BD/$F9C5).
Regenerated (499 subs), 0 old-name stragglers. **Method note:** reading the ROM strings directly (py one-liner,
16KB-bank offsets) was decisive — turned 3 MED "ui string" guesses into HIGH facts. Bank-2 totals for the arc:
**9 suspects ground/refuted** (6 keystone + 3 UI). NEXT = bank 1 (5 suspects), then bank 0 (5).

### Bank 2 keystone — the combat unit table (struct-of-arrays @ $6FBC) + side resource pool   [2026-06-10]
**Started bank 2 (the tactical COMBAT engine; banks 1/2 are specialized engines dispatched by bank 0's main
loop, never co-resident — Chris's NES-banking framing). One keystone cleared 5 of 8 address-tagged suspects
+ refuted 1 confidently-misnamed sub.** The combat unit table is a struct-of-arrays, 2 sides × 5 unit slots:
- `$82C9` `unit_word_field_ptr_6fbc` → **`unit_strength_ptr(side,slot)`** [HIGH] — word troop count, cap 9999
  (`min_word(_,0x270F)` @ $08A57; `base_strength` @ $09C97; casualty/reinforce attrition @ $09F63/$09F83).
- `$828B` `unit_field_ptr_6fd0` → **`unit_col_ptr(side,slot)`** [HIGH] — byte tactical-map COLUMN (X).
- `$829A` `unit_field_ptr_6fda` → **`unit_row_ptr(side,slot)`** [HIGH] — byte tactical-map ROW (Y).
  (Coord pair: unit-present-at-(col,row) scan @ $8FC7/$A079; off-map sentinel 200 @ $8FBD; `draw_terrain_
  feature_if_valid(col,row)` @ $09082.) Geometry: $6FBC word[2][5]→$6FD0 byte[2][5]→$6FDA byte[2][5].
- `$82A9`/`$82B9` `cur_unit_field_ptr_6fd0/6fda` → **`cur_unit_col_ptr`/`cur_unit_row_ptr`** [HIGH] — bind
  (cur_combat_side $7BE8, cur_combat_unit_slot $7BE4). **Fixed stale comments** that mislabeled $7BE8 as
  "field index" / $7BE4 as "unit index" — both REFUTED (verified $7BE8 is the 0/1 side: `=1` @ $935C, `^1` @
  $9B3D/$AE1E; $7BE4 is the 0..4 slot).
- `$827E` `unit_record_ptr` → **`side_resource_ptr(side)`** [HIGH, was NOT even flagged as suspect — clean
  name, wrong meaning]. Per-combat-side resource pool, stride 6 = 3 words: **+0 gold / +2 rice / +4 men**.
  Rosetta = `draw_message(msg_gold_4d_rice_4d_men_4d, +0,+2,+4)` @ $08C4F; ration check men/15<=rice @ $0838E;
  men cap 9999 @ $09EFA; gold spend @ $09E84. **REFUTES** old comment's "6-byte combat-unit record, +4 = hp".
Regenerated (499 subs), 0 old-name stragglers, call sites self-documenting. Surfaced for later: more parallel
columns in the table — `$6F65` (per-unit status/flag byte), `$6FE5` (digit-render scratch buffer).
**Bank 2 now: 3 address-tagged suspects left** — `set_combat_state_pair_7bf5_7bf7` ($8270),
`draw_combat_ui_string_b196` ($B196), `draw_unit_label_b627`.

### ★ BANK 15 GROUNDING COMPLETE ★ — batch #5, the final 7 leaves   [2026-06-10]
**Bank 15 is fully grounded: 0 suspect (`_XXXX`-suffixed) subs remain** (confirmed by both the cursor and
a direct `^word *_XXXX(` def count). The fixed bank — native floor (firmware/BIOS/interpreter/ALU, ch.19),
the 37-sub bytecode band, banks 10/14, the DREAM phi fix — is recovered top to bottom. Gates green (CFG
499/499, 114/114, stack-audit 187, round-trip clean). Final 7:
- `$D7F7` → **`clear_econ_stats_if_no_output`** [HIGH] — if output(+8)==0, zero loyalty(+12)+wealth(+14).
- `$D815` → **`clear_military_stats_if_no_men`** [HIGH] — if men(+16)==0, zero morale(+18)/skill(+20)/arms(+22).
  (Both unblocked by the already-mapped $7001 province record; no new map needed.)
- `$DA24` → **`scaled_force_transfer`** [MED] — proportional pct_op/math32 split clamped to arg5 (effect_move).
- `$DE78` → **`select_uprising_message`** [HIGH] — uprising message by ai_turn_flags + province; wrong-cat'd note refined.
- `$E4DC` → **`build_fiefs_excluding_daimyo`** [MED] — owned fiefs minus daimyo arg1's (marriage targets).
- `$CA97` → **`fill_bytes`** [HIGH] — memset(arg1, arg3, arg2); REFUTES "derived byte" note.
- `$CCBA` → **`clear_rect_lower_right`** [HIGH] — blanks cols 20-29 rows 20-25 + clears ui_state_flag_7bf9;
  REFUTES the "ui_get" name (it clears, doesn't get). The 2 cursor-invisible orphans (no tracked inbound).
**Session tally:** 33 bank-15 leaves grounded across 5 batches + a corpus-wide DREAM value-fix + banks 10/14
folded + ch.19/ch.20 written. ~15 wrong-category labels and ~8 refuted notes corrected.

### Bytecode band batch #4 — 7 bank-15 accessor-tail leaves   [2026-06-10]
Gates green (CFG 499/499, 114/114). Backlog 12 → 5 bank-15 suspects.
- `$E275` → **`announce_daimyo_death`** [HIGH] — the "[lord] was killed in fief X, year Y" announcement (+ clear_fief_pair_matrix + sound); wrong-category (was "prompt_helper").
- `$E4A2` → **`build_owned_fief_list`** [HIGH] — builds the $6F89 list of fiefs passing get_6da2_cur(); drop addr suffix.
- `$D586` → **`count_decimal_digits`** [HIGH] — base-10 digit count of arg1.
- `$D9F7` → **`revolt_type_message`** [HIGH] — `$7B79[arg1]==7 ? christians : rioters` uprising-message picker; wrong-category (was "classify_7b79").
- `$E694` → **`render_section_for_selected_province`** [HIGH] — render_map_section(province_to_map_section[latched province]); the "jump map to selected province" entry.
- `$D8F2` → **`develop_gain_capped_loyalty`** [MED], `$D919` → **`develop_gain_capped_wealth`** [MED] — develop_gain clamped to the (header − loyalty/wealth) headroom.
**Remaining bank-15: 5** — `$DA24` (formula), `$D815`/`$D7F7` (province-record field cleaners → next, the $7001 map),
`$DE78 select_message_string_de78` + `$E4DC marry_helper_e4dc` (now depth-0).

### Bytecode band batch #3 — 7 more bank-15 leaves (the GRAPHICS keystone)   [2026-06-10]
Gates green (CFG 499/499, 114/114). Backlog 19 → 12 bank-15 suspects.
- `$E5F2` → **`render_map_section`** [HIGH] — **the strategic-map section renderer** (graphics thread): blits the
  section's 28×16 tilemap (`strategic_map_section_tilemaps`+idx*0x1C0) + 32-B attribute table
  (`strategic_map_section_attributes`+idx*32→$23C8) + palette, marks it current, draws every fief's lord name.
  **A "map section" = tilemap(0x1C0) + attributes(32) + fief records(34).**
- `$E554` → **`redraw_fief_on_map`** [HIGH] — locate one fief by id in the current section's record list (col,row,id triples)
  and redraw its label tile-strip + lord name. Pairs with render_map_section. (was "find_record_9e3c" — it draws.)
- `$DAD7` → **`compact_relation_list`** [MED] — load selected daimyo's relation row, prune to still-existing entries; wrong-category (was "combat_helper").
- `$DB35` → **`increment_ai_player_count`** [MED] — `ai_player_count++`; set $6DA1 bit7 at ≥8; wrong-category (was "ui_helper").
- `$E1E7` → **`clear_fief_pair_matrix`** [HIGH] — sound 29 + zero fief arg1's row+col in the 54-stride fief×fief $6193 grid.
- `$E315` → **`marriage_pact_handler`** [MED] — marriage-pact flow (interactive accept+demand-gold vs auto/AI probabilistic dowry).
- `$D9D3` → **`redraw_window_row`** [MED] — `redraw_window($7985 + arg1*10)`, a 10-B-stride row table.
- DEFERRED still: `$DA24` (formula), `$D815`/`$D7F7` (province-record field cleaners — need the $7001/$7011 map).
**Graphics thread unlocked:** the strategic-map render path (`render_map_section`→`ppu_copy_rect` on the section tilemaps,
`redraw_fief_on_map` for per-fief refresh) is now legible end to end — a good ch.16 update when the band's done.

### Bytecode band batch #2 — 10 more bank-15 leaves grounded   [2026-06-10]
Resumed the tree-out after the DREAM phi-clobber fix (so the 4-c oracle is value-correct). Gates green
(CFG 499/499, 114/114). Backlog 29 → 19 bank-15 suspects.
- `$DB6E` → **`draw_province_lord_name`** [HIGH] — owner name (`daimyo_name_table[fief_owner]`) or `msg_no_lord` (the phi-clobber sub, now correct).
- `$D687` → **`draw_current_season`** [HIGH] — season banner string by `current_season` (also a fixed clobber).
- `$DD3A` → **`filter_province_list_by_owner`** [HIGH] — in-place prune of a province list by ownership; wrong-category (was "combat_helper").
- `$CC69` → **`clear_rect_right_panel`** [HIGH] — `ppu_fill_rect_wrap(22,7,29,18,1)`; another `clear_rect_*`, wrong-category (was "trade_helper").
- `$CCE1` → **`reset_prompt_selection`** [HIGH] — blanks row 26 + `ui_input_sel_latch_7fdf=255`; REFUTES "returns cursor selection" (it WRITES it).
- `$CDAF` → **`cursor_advance_row`** [HIGH] — col=2, row++, wrap 27→3; REFUTES "returns menu count" (it advances the cursor).
- `$D677` → **`draw_current_year`** [HIGH] — `draw_message($F6C4, current_game_year)`.
- `$DAAB` → **`load_daimyo_relation_row`** [MED] — loads daimyo arg1's 8-byte relation row (bank 4, scenario-keyed) into $6F4F.
- `$DFFE` → **`cap_arms_at_index`** [MED] — caps `$76AB[arg1]` at `arg2->arms/50+20`, spills excess to `$76A9[arg1]`.
- `$D982` → **`is_ai_count_ge_8`** [MED] — `ai_player_count >= 8` (8's role open).
- DEFERRED still: `$DA24` (pure pct/math32 formula), `$D815`/`$D7F7` (province-record field cleaners — need the $7001/$7011 record map).
**Tally of wrong-category labels this batch: 4** (combat_/trade_/2× ui_get_* misfilings) + 2 refuted accessor notes.

### Banks 10 + 14 folded into the corpus — the "$E80C" cross-bank case resolved   [2026-06-10]
`$E80C` (top depth-0 leaf, 34 sites) was "blocked" by `call_bank_wrap(14)` → bank 14, a bank the
decompiler never covered (`CODE_BANKS = [0,1,2,15]`, comment claimed "rest are data"). Chased it:
`call_bank_wrap(n)` = `syscall_dispatch(n,7)` = **call_bank** (`JSR bank n $8000`). Scanned every bank
for the `JSR $E823` (vm_entry) bootstrap → only banks **0,1,2,10,14** carry bytecode; **3-9, 11-13 are
pure data** (0 bytecode, confirmed). Banks **10 (1 sub) and 14 (3 subs) were missed.** Added them to the
bytecode-pipeline `CODE_BANKS` (decompile_all/merged, cfg_gate, stack_audit, v2-corpus, vm-roundtrip —
NOT the native-parse tools, whose $8xxx addresses would collide with banks 0/1/2). Corpus **495 → 499
subs**, gates green (CFG 499/499, 114/114, stack-audit 187). Grounded the 4 + the caller:
- `$E80C` `ui_helper_e80c` → **`trigger_cutscene`** [HIGH]. `if(ai_turn_flags&4){cutscene_id=arg1;
  return call_bank_wrap(14);}` — fire the AI-turn cutscene engine for event `arg1`. 34 sites.
- bank14 `$80AD` → **`run_cutscene`** [HIGH] — the AI-turn cutscene SCRIPT INTERPRETER (reads a 5-byte
  descriptor at `cutscene_id*5 + cutscene_table $AF80`, loads palette+CHR, runs a command switch:
  move/draw-sprite-grid/delay/loop/clear/play-audio/end). A second mini-interpreter we'd never seen.
- bank14 `$801D` → **`draw_sprite_grid`** [HIGH]; `$8003` → **`cutscene_delay`** [HIGH]; `$AF80` →
  **`cutscene_table`** [MED]. bank10 `$8003` → **`play_audio_by_id`** [HIGH] (sound/music trigger).
- RAM: `$7FCB` → **`cutscene_id`**, `$7FE5` → **`sound_request_id`**.
**Lesson:** the "code only in 0/1/2/15" assumption was a decompiler-scope artifact, not a fact —
call_bank reaches any bank's $8000, and the bank-14 cutscene engine proves it. Code banks = 0,1,2,10,14
(bytecode) + 15 (native). See chapter 19 + the decompile_all comment.

### Bytecode band batch #1 — 7 depth-0 leaves grounded   [2026-06-10]
First "tree-out" pass over the bank-15 bytecode band ($CA03–$E80C), leaves-first. Gates green
(CFG 495/495 both ways, 114/114). `$E80C` (top, 34 sites) **deferred** — cross-bank-14 blocked.
- `$CD20` `ui_helper_cd20` → **`repaint_screen`** [HIGH]. Full-screen repaint + UI-state reset:
  palette_swap(1) bracket; fill_nametable + fill_attr; two DIRTY-FLAG-gated reloads (`7fc9`→sprite
  palette 7/11/15; `7fc7`→bg palette + `strategic_map_chr_tiles` upload); then latch/clear selection,
  reset cursor + state flags. ~18 sites. Consumes the two dirty flags whose producers sit at $7FC9/$7FC7.
- `$CA12` `byte_helper_ca12` → **`deduct_byte_at`** [HIGH]. `*p -= (byte)arg2; return *p`. REFUTES the
  old [LOW] "compares vs a const" note (no compare; the undecoded-op guess was wrong). 7 sites.
- `$D972` `war_helper_d972` → **`fief_owner_weakness`** [HIGH]. `daimyo_weakness_flag[fief_owner(arg1)]`
  — data accessor, wrong-category (not a "war helper"); built on grounded `fief_owner`. 9 sites.
- `$D351` `ui_helper_d351` → **`prompt_ab_window`** [HIGH]. A/B prompt over a caller window: poll
  A(→1,glyph60)/B(→0,glyph62)/btn-2(→2); sibling of `prompt_y_n` with a window arg + 3rd exit. 7 sites.
- `$DC0E` `list_op_6e4a` → **`pool_push_pop`** [HIGH]. Stack on $6E4A/$6E4B: arg1≤49 PUSH, >49 POP.
  Elements are 0-49 (fief range) — the `daimyo_pool` var label may be a misnomer (flagged). 6 sites.
- `$DC3C` `list_remove_6e7f` → **`list_remove_matching`** [HIGH]. FFs every entry == arg1 in the $6E7F
  list (scenario_fief_count). $6E7F list's purpose still open. 6 sites.
- `$DB12` `tax_helper_db12` → **`defender_owner_is_keyed_daimyo`** [MED]. Combat predicate, wrong-category
  (NOT tax): `fief_owner(battle_defending_province) == (fiefs==17 ? 3 : 20)`. OPEN: who is daimyo 3/20
  (likely the scenario protagonist) — confirm via daimyo table.
- DEFERRED `$DA24 scaled_transfer_da24` — pure pct_op/math32 formula; needs caller-domain context to name.

### `$C437`/`$C428`  PPU blit syscalls → fill-rect vs copy-rect geometry   [HIGH CONFIRMED 2026-06-10]
Hand-decoded the native 6502 keystone (`bank_15.asm $C428-$C4DF`, the first pass-0-floor descent).
Both syscalls walk the SAME inclusive tile rect; mode flag `$0082` (set by entry point) selects fill
vs copy. ZP arg map: `$52`=nametable sel 0-3 (→ `$2000/$2400/$2800/$2C00`; wrappers pass 0), `$54`=left
col, `$56`=top row, `$58`=right col, `$5A`=bottom row, `$5C/$5D`=fill tile (nobank) / source ptr
(from_bank, post-incremented), `$5E`=source bank (from_bank only). `PPU_addr = $2000 + (sel<<10) +
row*32 + col` (row*32 via the `$C6AD` repeated-add multiply). **`syscall_ppu_fill_rect` ($C437) =
constant-tile FILL** (writes `$5C` to every cell), **`syscall_ppu_copy_rect` ($C428) = byte-stream
COPY** of width*height bytes (saves/switches/restores PRG bank). Proof: `$E621` copies `(2,4,29,19)` =
28×16 = `0x1C0` B/section from `strategic_map_section_tilemaps` (matches its documented 448-B stride).
Tile `$01` = blank (ch.16), so every `ppu_fill_rect_wrap(...,1)` UI call CLEARS a region.
**Suspect-note slips fixed:** the `ui_draw_window_*` family (`ccd1`/`d2f9`/`d309`/`d31a`) listed its 5
args REVERSED and miscategorized fill-with-blank as "window draw" — amended in `mesen-labels.toml`.
**Renames applied** (Chris chose full rename): syscalls `ppu_blit_nobank`/`_from_bank` →
`ppu_fill_rect`/`ppu_copy_rect` (+ `syscall_`/`_wrap` forms), and `ui_draw_window_{ccd1,d2f9,d309,d31a}`
→ `clear_rect_{top_strip,left_upper,left_lower,left_lower_alt}`. Source of truth = `mesen-labels.toml`
(PRG labels + wrappers) and the syscall-id maps in `vm_decompile.py`/`nobunaga_vm.py`; regen propagates.

### `$E510`  `ui_helper_e510` → `build_eligible_province_list`   [HIGH CONFIRMED 2026-06-10]
`build_eligible_province_list(enemy_flag)`: scans all fiefs, keeps those that exist
(`!province_state_is_FF`), match the ownership filter (`is_enemy_owned(i) == enemy_flag`), and aren't
`selected_province_idx`; appends each idx to the `$6F89` buffer, FF-terminates, returns the count.
The candidate-list BUILDER the Send/Pact/View/Marry target-select commands pick from — confirms (and
sharpens) the prior caller note; it builds the list, it's not a "cursor/menu enter primitive."

### `$D3A7`  `ui_helper_d3a7` → `prompt_y_n`   [HIGH CONFIRMED 2026-06-10]
Y/N confirm prompt: `redraw_window(msg_y_n_f695)`, poll `wait_button_edge` until A(64)/B(128); on A
echo 'Y' + return 1, else return 0. 8 callers. Sibling of `confirm_prompt ($D766)` — this draws the
explicit "Y/N" string and echoes the choice.

### `$D759`  `ui_helper_d759` → `standard_delay`   [HIGH CONFIRMED 2026-06-10]
2-op wrapper: `return delay_loop(delay_loop_count)`. Runs the standard configurable busy-wait;
`delay_loop_count ($6D65)` is the user-adjustable message-speed setting. 3 callers.

### `$CC35`  `marry_helper_cc35` → `palette_swap`   [HIGH CONFIRMED 2026-06-10]
1-op forward: `return syscall_palette_swap(arg1)`. **Wrong-category label** (like `fief_owner`):
nothing to do with marriage — a generic palette-swap primitive that merely *appears* in effect/
marriage screens. Sites read `palette_swap(1)` / `palette_swap(0)` bracketing `palette_write_wrap`
blocks (swap to a working palette, write, swap back). 91 sites, 0 stale.

### `$D77E`  `ui_helper_d77e` → `selected_province_owner`   [HIGH CONFIRMED 2026-06-10]
2-op accessor: `return fief_owner(selected_province_idx)` (`PUSH $6F5F; CALL fief_owner; RETURN`).
The owning daimyo id of the currently-selected province. 5 callers (Marry/Pact diplomacy). NOT a
UI helper — a data accessor like `fief_owner`. Sites now read as game logic:
`rest_turns_remaining[selected_province_owner()]`. (Built on the just-grounded `fief_owner` — the
leaves-first order paying off: a 2-op accessor over a grounded leaf grounds instantly.)

### `$CC89`  `ui_helper_cc89` → `open_message_window`   [HIGH CONFIRMED 2026-06-10]
`open_message_window()` = `ppu_fill_rect_wrap(2, shift?20:22, 19, 25, 1); set_cursor(2, shift?20:22)`
(body @ `$CC8E`). Draws the standard bottom message-window rect + homes the cursor — the
"prepare the window before printing" primitive (14 callers, command pre-roll). **Also corrected a
SUSPECT neighbor note `$7FD1 ui_msg_col_shift_flag`:** (1) polarity was inverted (code is
`flag?20:22` = !=0→20, ==0→22; note said opposite); (2) the 20/22 lands in `set_cursor`'s ROW arg,
so it reads as a row/vertical shift, not a column — `col_shift` name left un-renamed, marked OPEN
pending `message_display ($D338)`. UI vocabulary now also covers window setup.

### `$D134`  `ui_helper_d134` → `draw_message`   [HIGH CONFIRMED 2026-06-10]
`draw_message(fmt, ...)` = `format_string(&fmt, &msg_buf); return redraw_window(&msg_buf)`
(body @ `$D139`, −150 frame = the `msg_buf`). printf-then-draw wrapper. 193 sites, all
`(msg_*_Nd, value)` — the `_2d`/`_4d` suffixes encode the printf width. **Refuted** the old note:
d134 is NOT the %d/%s substitution layer — that is `$CFFC format_string` ([HIGH]); d134 wraps it
with `redraw_window`. UI vocabulary now: `format_string`(printf core) · `set_cursor`(locate) ·
`redraw_window`(draw raw) · `draw_message`(printf+draw).

### `$CC7B`  `ui_helper_cc7b` → `set_cursor`   [HIGH CONFIRMED 2026-06-10]
5-op VM setter: `set_cursor(col,row)` = `ui_window_col=arg1; ui_cursor_row=arg2`
(`LOADL 12; STORE $7FCD; LOADL 13; STORE $7FCF; RETURN @ $CC80`). The text-cursor / draw-origin
positioning primitive — the `locate(col,row)` every `redraw_window` consumes. Axes confirmed
*independently of the body* by consumers (`$7FCD`=col/X line-wrap boundary; `$7FCF`=row/Y, used in
`find_record`'s `base+(row-4)*28+col`). 211 sites de-noised, 0 stale; call sites now read as real
layout (`set_cursor(3,4); set_cursor(3,6); set_cursor(3,8); set_cursor(3,10)` = a menu list down
col 3). First member of the **UI-primitive vocabulary** cluster — chapter-18 section deferred until
the cluster (`cc89`, `d134`, `d77e`, ...) is ground, then written once.

### `$D772`  `ui_helper_d772` → `fief_owner`   [HIGH CONFIRMED 2026-06-10]
Pilot that proved the loop. 5-op VM accessor: `return fief_to_daimyo_map[fief]`
(`LOADL 12 fief; LOADR_imm2 $6E15 fief_to_daimyo_map; ADD; BYTE_DEREF; RETURN @ $D777`).
Takes a fief id, returns its owning daimyo id. Old name was wrong-category (a data accessor, not a
UI helper); the "fief→owner" note scattered in ~5 other comments is now ground-truthed. 149 call
sites flipped, 0 stale, structurally inert. Exposed next targets: `$7530` per-daimyo stat table
(stride 7), `$77A8` daimyo-name table (stride 9).

---

## Frontier (where to resume — do not retread)

### DONE 2026-06-10: the pass-0 native blit-geometry unlock + full rename
`$C437`/`$C428` fully decoded (fill-rect vs copy-rect, full ZP arg map, `PPU_addr` formula) — see the
ledger entry above. Renames applied end-to-end and gate-verified (CFG 495/495 both directions,
114/114 unit suite): `ppu_blit_nobank`/`_from_bank` → `ppu_fill_rect`/`ppu_copy_rect` (+ `syscall_`/
`_wrap` forms), `ui_draw_window_{ccd1,d2f9,d309,d31a}` → `clear_rect_{top_strip,left_upper,left_lower,
left_lower_alt}`. Source-of-truth touched: `mesen-labels.toml`, the syscall-id maps in
`vm_decompile.py`/`nobunaga_vm.py`, the curated `bank_15_labeled.asm`, and the `.md` chapters; all of
`source/2,3,4` + `.mlb` + the turn-loop HTML regenerated. ch.04 rows 12/20 now carry the full arg-map.

### DONE 2026-06-10: ch.18 "UI primitive vocabulary" section written
Added to `18-window-updates.md` (after "The window-update model in steady state"): a 3-layer grounded
stack — Layer 0 the two blit syscalls (`ppu_fill_rect`/`ppu_copy_rect` + arg-map + `PPU_addr` formula),
Layer 1 the `clear_rect_*` blanks (with old→new name map), Layer 2 the text/window primitives
(`format_string`, `set_cursor`, `redraw_window`, `draw_message`, `open_message_window`, `prompt_y_n`,
`standard_delay`) — plus the "every screen = clear → locate → format+draw → copy art → wait" idiom. It
explicitly grounds the chapter's older informal `$C480`/`$0075`/`$0082` model into the named syscalls.

### DONE 2026-06-10: repaired the grounding cursor (`label-walk-prep --grounding`)
The leaves-first cursor was broken by the oracle reorg: `cluster-anon-subs.py` had been moved to
`attic/` (but is imported by `label-walk-prep` + `var-walk-prep`) and still read the gone
`decompiled/` path. Restored it to `tools/`, repointed at `source/4-c/`, and added `suspect_targets(bank)` + a
`--grounding` mode. **Ordered LEAVES-FIRST** (Chris's bottom-up correction): `depth` = how many
un-grounded subs deep this one sits (0 = a true root, groundable NOW); fanout (= inbound sites) is
only the tiebreak *within* a depth band. `--by-fanout` flips to the leverage view. Backlog surfaced:
**b15 37, b0/b1/b2 16 each ≈ 85 suspect code subs.** **KNOWN BLIND SPOT:** depth is computed over the
in-graph suspect set (banks 0/1/2/15 only), so it cannot see cross-bank deps into banks 13/14 or data
deps — `$E80C` shows depth-0 but is really blocked by a bank-14 routine. Treat depth-0 as *necessary,
not sufficient*; the human ledger's open-items override.

### DONE 2026-06-10: pass-0 native floor (kernel) confirmed COMPLETE — bottom-up satisfied
Per Chris ("make sure ground-0 is done first; `$E80C` proves we must stay lower"): audited the
native kernel region `$C000-$C7FF`. Filtering `native-call-index` defs to **real subroutines (≥1 jsr
caller)** — the raw def list is polluted by branch-target labels (`$C439`, `$C47D`… are intra-routine
labels of `ppu_fill_rect`) and by VM-bytecode regions ($C800+) mis-parsed as 6502. Result: **20/20 real
native subs grounded, 0 gaps** (`wait_vblank`, `set_prg_bank`, `mul_xy_by_3`, the PPU gates
`screen_on`/`rendering_on`/`ppu_safe_gate`, `controller_poll`, `palette_upload`, music voices, +the
blit helpers just done). The interrupt handlers (ch.01) + 23 syscalls (ch.04) cover the rest. **The
bank-15 native floor is grounded; the remaining bank-15 work is the VM-suspect layer above it.**
FLAG: `$C6AD mul_xy_by_3` is really a general `Y*X` multiply (blit passes X=32 for row*32) — `_by_3`
is likely named after one caller; re-ground the name.

### >>> NEXT BLOCK (start here): FULL-VERIFY bank 2 bottom-up (17/131); then banks 1, 0 <<<
**STANDARD CHANGED 2026-06-10 (Chris): full verification, not stub sweep** (see Settled framing ★). Bank 2's
address-tagged STUBS are cleared (0 `_<4hex>`), but only **17/131 subs are truly verified** — the other 114
carry inherited breadth-pass names that are SUSPECTS until read. **Resume = `py -3 tools/bank-ground-order.py
2 --todo`** (leaves-first worklist of the 114). Grind depth-0 up: top of the list is `get_battle_side_province`
($838F, 25 callers), `test_unit_type_present_flag` ($8F79), `is_no_province_selected` ($82FF)… roots last
(`battle_init_driver` $AFE1 depth 13). Same loop as before (layer-ID → read bytecode → fact-check → name+tag →
toml → regen → spot-check), now applied to descriptively-named subs too (confirm or REFUTE the inherited name).
Bonus table columns still un-mapped (optional): `$6F65` (per-unit status/flag byte), `$6FE5` (digit scratch buf). **Bank 1 — 5 address-tagged suspects** (the specialized lord-command/turn engine
dispatched by bank 0; per Chris's NES-banking framing banks 1 & 2 are the engines, bank 0 the main loop):
- `helper_8357` ($8357, 3 args) — fully vague; ID first.
- `province_window_redraw_ba6f` + `province_window_redraw_ba78` ($BA6F/$BA78, 2 args) — adjacent pair, likely
  the province-info window redraw; ground together.
- `map_helper_af10` ($AF10, 1 arg).
- `ai_seed_fief_collection_rate_6d2d` ($6D2D area) — AI tax/collection seed; cross-checks the $6D2D table.
**Method that worked in bank 2:** read the ROM strings directly for any draw_message/message_display target
(py one-liner, 16KB-bank file offset = 16 + bank*0x4000 + (cpu - (bank==15?0xC000:0x8000))) — decisive.
Then **bank 0** (5: display_prompt_message_b900, select_msg_by_state_7b79, dedup_owners_to_6f4f,
append_candidate_entry_6f67, roll_period_rate_table_6e0b — the main-loop bank, do last).

#### (historical) original NEXT BLOCK note: banks 0/1/2 (bank 15 + 10 + 14 are DONE)
**Bank 15 complete (0 suspects); banks 10 & 14 complete (all named).** Remaining corpus suspects: banks
0/1/2 — **5 (bank 0), 5 (bank 1), 7 (bank 2) ≈ 17** `_XXXX`-suffixed function defs (direct C count).
NOTE the cursor's `--grounding` count for switchable banks is UNRELIABLE: native-call-index keys by CPU
address so banks 0/1/2 share the $8000-$BFFF window (the cursor shows ~16 for EACH, the colliding union,
and spuriously shows it for 10/14 too). Ground banks 0/1/2 by reading `source/4-c/bank_0N.c` directly
(grep `^word *_[0-9a-f]{4}(` per file); the leaves-first/fanout ordering is still a useful hint, just not
the per-bank attribution. A proper fix = split native-call-index's CODE_BANKS into NATIVE vs BYTECODE sets
([[tools-architecture-refactor]] debt). Later: the ch.16 strategic vs tactical render is now both grounded.

### (historical) bank-15 batch cursors
Run `py -3 tools/label-walk-prep.py 15 --grounding`. Batches #1 (7) + #2 (10) + #3 (7) done — **12 suspects
left (10 depth-0)**. Current top clean depth-0 leaves: `$E275 prompt_helper_e275` (4), `$E4A2
build_owned_fief_list_6f89` (2), `$D586 count_div_iterations_d586` (1), `$D8F2 record_grow_capped_d8f2`
(1) — the tail is mostly 1-2-site accessors/wrappers. DEFERRED (need data-structure maps): `$DA24`
(pct/math32 formula), `$D815`/`$D7F7` (province-record field cleaners — the $7001/$7011 record map would
unblock both + sharpen many others). **DONE: ch.20 "The Strategic Map Render"** written (render_map_section + redraw_fief_on_map + the
section data layout; the graphics thread captured). Plan from here (Chris): **(1) batch #4** — the bank-15
accessor tail (`$E275`, `$E4A2`, `$D586`, `$D8F2`); **(2) then the `$7001`/`$7011` province-record map** —
unblocks `$D815`/`$D7F7` and sharpens many subs; **(3) then banks 0/1/2** (16 suspects each). Re-confirm
stowaways: `$C6AD mul_xy_by_3` (general Y*X); `daimyo_pool` var at $6E4A (fief-id-ranged, likely misnamed).

### Open items
- `$E80C` (now value-correct) — name needs `mem_7FCB` + bank-14 routine 14 grounded.
- Read `message_display ($D338)` to settle the `$7FD1` axis (row vs col) + confirm/rename
  `ui_msg_col_shift_flag` across both consumers.
- Next high-fanout non-UI leaves once UI is done (re-run `label-walk-prep` for the leaves-first cursor).
- **Open sub-question:** read `message_display ($D338)` to settle the `$7FD1` axis (row vs col) +
  confirm/rename `ui_msg_col_shift_flag` across both consumers.
- **Pass-0 native floor:** enumerate the Bank-15 code the bytecode compiler did not claim; ground
  the 6502 leaves (syscalls + kernel) under the VM.
- **Sub-targets exposed by grounded leaves:** `$7530` (per-daimyo stat table, stride 7), `$77A8`
  (daimyo-name table, stride 9).
- **Backlog size:** 454 distinct `_XXXX`-suffixed (address-tagged = self-confessed low-fidelity)
  names across `source/4-c/`.
