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
- **Data structures = TRUST KNOWN VALUES (Chris, 2026-06-10).** The on-RAM layouts (`$7001` province
  record, `$6193` relations matrix, the combat unit table, etc.) are well-known and reliable. This pass
  grounds *code behavior*, not data layout — use the established field map; only flag a field if the code
  actively contradicts it. Do NOT spend the pass re-deriving data structures.
- **Tech debt + quirks live in `nobunaga/tech-debt.md`** (the canonical map). Log decompiler-bug detail in
  the §"Decompiler 3% backlog" below AND the corresponding tech-debt.md row.

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

## ★ THE FULL-VERIFY PROCEDURE (canonical, proven on bank 2 → 131/131) ★

This supersedes the stub-sweep cursor for the full-verification bar. One **bank** at a time, **7 subs per
batch**, leaves-first. Repeat per batch until `--todo` is empty, then mark the bank complete.

**Per-batch loop:**
1. **Pull the next 7** from the worklist: `py -3 tools/bank-ground-order.py <bank> --todo` — leaves-first by
   call-graph depth, annotated SUSPECT/dated/todo. Take the top 7 todo (highest fanout within the depth band).
   Depth-0 first ⇒ everything a sub calls is already grounded by the time you read it.
2. **Read all 7 bodies at once** from `source/4-c/bank_NN.c` (one py splitter on the `// $ADDR name` headers).
3. **For each, fact-check the inherited name+comment as a SUSPECT** — confirm / refine / REFUTE. The clean
   descriptive names are wrong as often as the stubs (bank-2: ~30 renames, ~40 corrected comments). Watch for:
   inverted polarity, wrong side (attacker/defender), wrong return value, men-vs-damage / record-offset confusion.
4. **Reach for the bytecode when the 4-c looks off** (`source/2-asm-vm/bank_NN_vm.asm`) — it is authoritative.
   Specifically suspect a **DREAM value-merge bug** (see backlog) when a `switch`/if-else collapses per-arm
   values; the bytecode `ADD_qimm`/distinct `CALL`s reveal the truth. Cross-check `source/3-c-basic` too.
5. **Read ROM strings directly** for any `draw_message`/`message_display`/table target — decisive for naming.
   File offset = `16 + bank*0x4000 + (cpu - (bank==15 ? 0xC000 : 0x8000))`.
6. **Edit `mesen-labels.toml`** (one Edit per sub): reads-at-call-site name + `[<LEVEL> <STATUS> 2026-..-..]`
   tag + the evidence one-liner. Label/relabel any data tables & vars you grounded in passing.
7. **Regenerate** (`py -3 -m na1dream.cli.decompile_all` from `tools/`), confirm **old names gone** + **`--todo`
   count dropped by 7**, spot-check 1-2 call sites.
8. **Ledger entry** (newest-first in grounding.md) + **commit** all of: `mesen-labels.toml`, `grounding.md`,
   `source/4-c/`, `source/2-asm-vm/` (label renames propagate to every bank's asm — commit them or the tree drifts).
   Report the progress (`N/131`) at each commit.
9. Refresh the **memory checkpoint** (`grounding-pass.md`) every few batches so a fresh session resumes clean.

**Bank-complete:** when `--todo` hits 0, write the ★COMPLETE★ ledger entry, advance the frontier to the next
bank, update memory. **Watch for mis-keyed duplicate toml entries** (`grep '"0xADDR"'` returning two hits in
different `[prg.bankN]` sections — same-CPU-addr cross-bank is fine, a wrong section is a bug to fix).

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

### 32-bit ext-op math chains render as a PLACEHOLDER return (value-wrong 4-c)   [OPEN 2026-06-10]
Found grounding bank-1 leaves `$8303 math32_muladddiv`, `$8357 ratio_times10_capped`. Subs whose body is a 32-bit
extended-op chain (`sign_extend16_to_32` / `umul32` / `sdiv32` / `add32` on the VM's aux 32-bit stack, opcodes `B7 25/14/15/01/02/03/19`)
render in 4-c as a bare placeholder `return <some local>` — DREAM models neither the 32-bit aux stack nor the ext-ops, so the
real computation is DROPPED. Examples: `$8303` true body = `floor((rate*amount+9)/10)` but 4-c says `return rate`;
`$8357` true body = `min((arg1*10)/arg2, arg3)` but 4-c says `return min_word(arg1, arg3)`. **Impact:** any sub with
`// ext_op` comment lines in its 4-c is value-wrong — READ THE BYTECODE (`source/2-asm-vm`). These are the financial/stat
formula primitives (rates, interest, growth), so the damage is concentrated in the economy commands. Likely many in banks 0/1.

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

### Bank 0 full-verify batch #9 — ravage variants + AI event eligibility (66/98)   [2026-06-10]
4 renames (1 refute) -- the address-offset suffixes mapped to record fields:
- `$936B` `ravage_defender_field_off4` -> **`ravage_defender_town`** ($7005=+4).
- `$9380` `ravage_defender_arms` -> **`ravage_defender_wealth`** -- REFUTE: $700F=+14=WEALTH, not arms (arms=+22).
- `$9395` `ravage_defender_field_off18` -> **`ravage_defender_morale`** ($7013=+18).
- `$9E21` `..._field18_variant` -> **`ai_event_eligibility_check_morale_variant`**.
- `$9614` append_candidate_priority1, `$98C6` select_provinces_and_assign_ai_state, `$9DA3`
  ai_event_eligibility_check_loyalty_variant: re-grounded. Next: rows 1-7.

### Bank 0 full-verify batch #8 — new-game / succession / rates (59/98)   [2026-06-10]
1 rename (the last bank-0 stub -> SUSPECT 0):
- `$924A` `roll_period_rate_table_6e0b` -> **`roll_period_market_rates`** (loan/exchange/arms/men/hire rates @ $6E0B).
- `$8694` prompt_select_player_daimyo, `$8763` daimyo_creation_stat_roll_screen, `$8B9D`
  select_message_string_by_flags_and_arg, `$8C75` resolve_ownerless_province_succession, `$9194`
  check_and_process_daimyo_natural_death, `$9338` ravage_defender_output_and_bump_selected_arms: re-grounded. Next: rows 1-7.

### Bank 0 full-verify batch #7 — wrappers + disaster/income leaves (52/98)   [2026-06-10]
All confirmed (no renames): `$839A` init_daimyo_arms_record ($76A9 stride-5), `$8C1E`
cur_flag_and_selected_ai_state5, `$8FD3` append_candidate_zero_priority, `$90D7`
saturating_sub_byte_then_reset_if_ge_100, `$9974` process_first_n_unmarked_list_entries (reassign N fiefs to owner),
`$9D00` random_event_ravage_output_hidden_mark_weakness (cutscene 31), `$A191` calc_charisma_scaled_income_variance:
re-grounded. Next: rows 1-7.

### Bank 0 full-verify batch #6 — per-period stats / save / shuffle (45/98)   [2026-06-10]
1 rename:
- `$952F` `avg_byte_array_6d2d_over_fiefs` -> **`avg_fief_tax_rate`**.
- `$92D9` deduct_b_from_a_void_b_if_overdrawn, `$9558` avg_province_wealth_over_fiefs ($700F=+14 wealth),
  `$9CB3` decay_fief_list_wealth_and_output_disaster1 (cutscene 20), `$A2ED` drift_daimyo_luck (+3=LUCK, -5..+5),
  `$A3AA` write_sram_save_checksum_and_signature, `$A742` shuffle_fief_turn_order_array ($6F1B): re-grounded. Next: rows 1-7.

### Bank 0 full-verify batch #5 — scenario events / upkeep / diplomacy (38/98)   [2026-06-10]
1 rename:
- `$9879` `mark_6f89_list_entry_by_value` -> **`mark_fief_list_entry_removed`** (sets the $6F89 entry to 200).
- `$9621` reassign_daimyo24_fiefs_to_owner50 (50-fief event), `$9AAC` driver_diplomacy_gold_transfer (ally-for-gold),
  `$9B7F` marry_transfer_gold_between_provinces (dowry), `$A0A9` update_province_highwater_marks (snapshots into the
  $6003 stride-8 base table; the >= logic tracks toward the min -- flagged), `$A15B` consume_province_army_upkeep
  (men/2 rice+gold cost, starvation cuts men), `$A2DF` roll_3pct_event_chance: re-grounded. Next: rows 1-7.

### Bank 0 full-verify batch #4 — aging/clamp/event leaves (31/98)   [2026-06-10]
1 rename:
- `$94B1` `announce_provinces_by_ai_state_mode` -> **`announce_seasonal_event`** (typhoon/plague by event id, not AI state).
- `$90C6` reset_byte_if_ge_100, `$9154` check_daimyo_natural_death (age>=70 + health-scaled rng), `$91FD`
  clamp_value_to_range, `$922E` roll_small_or_large_random, `$92A9` repay_province_debt_from_gold, `$9595`
  province_conquest_roll_predicate (loyals vs rebels split): re-grounded. Next: rows 1-7.

### Bank 0 full-verify batch #3 — uprising/owner/predicate leaves (24/98)   [2026-06-10]
2 renames:
- `$8B70` `select_msg_by_state_7b79` → **`select_rebellion_message`** (Christians vs rioters by $7B79 state).
- `$8DE1` `dedup_owners_to_6f4f` → **`dedup_owners`** (de-dup-by-owner into $6F4F; fixed a duplicate toml entry too).
- `$88AC` render_boot_title_screens, `$8BE6` find_first_enemy_owned_fief, `$8C0E` is_selected_province_ai_state_5,
  `$8EBC` compare_greater_with_coinflip_tiebreak, `$8FE0` stat_above_threshold_and_gap_predicate: re-grounded. Next: rows 1-7.

### Bank 0 full-verify batch #2 — new-game setup + state setters (17/98)   [2026-06-10]
1 rename + re-grounds:
- `$867F` `display_prompt_message_b900` → **`prompt_player_choose_fief`** (new-game fief pick).
- `$821E` verify_sram_save_integrity, `$85FC` prompt_roll_stat_value (rng 60-109), `$862B`
  prompt_select_scenario_size (17/50), `$98A3` set_fief_ownership_record (owner/capital/state + redraw),
  `$A1AA` calc_fief_harvest_base_term ($6007/$6009 stride-8 income * tax_rate), `$A5D5` rng_mod_30
  ((skill+1)*10): re-grounded. Next: rows 1-7.

### Bank 0 full-verify batch #1 — math/relations/candidate leaves (10/98)   [2026-06-10]
First bank-0 batch (the main loop; entry vm_bootstrap). 2 renames + re-dated confirms:
- `$8E99` `append_candidate_entry_6f67` → **`append_candidate_pair`** (dual-lane $6F67/$6F68 list).
- `$946D` `get_daimyo_stat4_by_fief` → **`get_fief_daimyo_charisma`** (+4 = CHARISMA).
- `$8377` transfer_arms_field_pct (pct byte transfer), `$8C35` relations_matrix_cell_addr ($6193 stride-54),
  `$9214` calc_year_scaled_random_value, `$92F9` random_ravage_province_field, `$9D86`
  square_over_2025_probability_roll (P~(2025-arg1^2)/2025): re-grounded. Next: rows 1-7.

### ★★ BANK 1 FULL-VERIFICATION COMPLETE ★★ — batch #18, the turn-loop roots (131/131, 100%)   [2026-06-10]
**Every one of bank 1's 131 subs is read-verified (0 todo, 0 suspects).** The lord-command / turn engine reads top to
bottom: root `ai_per_fief_command_driver` ($B89B, depth 7, the AI per-fief turn loop) -> ai_econ_command_dispatch /
ai_state2_recruit_arm_train / issue_province_command -> the 21 command drivers (move/war/send/pact/marry/trade/grow/
build/dam/train/hire/bribe/give/grant/view/tax/rest/other/pass + ninja) -> their effects -> the math/relations leaves.
Final 6 confirmed: `$A5F4` driver_hire, `$B4D5` ai_state2_recruit_arm_train, `$B64B` ai_econ_command_dispatch, `$B79B`
issue_province_command, `$B875` ai_econ_action_state0, `$B89B` ai_per_fief_command_driver.
**Bank-1 arc tally (18 batches, 7/batch):** ~30 renames (every `helper_XXXX`/`subhandler_XXXX`/address-tagged stub + the
mislabeled `effect_hire_pay_gold`->`effect_ninja_failed`, `effect_subhandler_A003`->`effect_sell_rice_for_gold`, etc.) +
the **3rd DREAM bug class found** (32-bit ext-op math chains render as placeholder returns — bank-1's 3: $8303/$8357/$8327,
all flagged) + a 4th value-render instance ($97EA roll) + confirmation that the Grow/develop family all share the
skill-scaled formula `2*amount*(6-skill)/sqrt(...)`. Self-inflicted toml nested-quote bug found+fixed (no nested `"`).

### Bank 1 full-verify batch #17 — the rest of the command drivers (125/131)   [2026-06-10]
All confirmed: `$9DC4` driver_marry, `$A2D2` effect_ninja_sabotage (covert actions), `$A6C7` driver_view,
`$A853` driver_build (confirms $7001+4 = town), `$AA1F` driver_give, `$AAAE` driver_bribe, `$AF66` driver_grant.
The entire lord-command menu (the 21 commands) is now read-verified end-to-end. Next: the final 6 (the turn-loop roots).

### Bank 1 full-verify batch #16 — the player + AI command drivers (118/131)   [2026-06-10]
All confirmed (well-named drivers), re-grounded — the command layer is now wired top-to-bottom:
- Player: `$96D1` driver_move, `$9850` driver_war (capital + gold/rice/men prep), `$9A5D` driver_send,
  `$9C4F` driver_pact (costs daimyo DRIVE), `$859A` effect_view_defending_province.
- AI: `$949A` ai_try_war_attack (pick weakest target), `$B3AA` ai_develop_town_handler. Next: rows 1-7 (13 left).

### Bank 1 full-verify batch #15 — trade/give/loan + a parse-bug fix (111/131)   [2026-06-10]
2 renames + 5 re-grounds. Also FIXED a self-inflicted toml bug: batch-14's comments had nested double-quotes
(e.g. inside ('we're at our limit')) which made parse_toml SKIP those 2 entries (driver_dam, find_fief... showed
false-todo). Rule: no nested `"` or em-dashes in toml comments — use single quotes.
- `$9F04` `subhandler_9F04` → **`effect_loan`** (raise gold from town-debt at loan_rate, capped at treasure-room),
  `$A003` `subhandler_A003` → **`effect_sell_rice`** (+ data labels msg_loan_prompt / msg_sell_rice_prompt).
- `$A95E` effect_give_b (gold/rice), `$A9D5` effect_give_c (peasants/men), `$AD67` driver_assign, `$AF38`
  driver_map, `$B338` ai_province_gold_to_rice_convert (market-rate AI economy): re-grounded. Next: rows 1-7.

### Bank 1 full-verify batch #14 — Build + AI economy/attack (102/131)   [2026-06-10]
All confirmed; re-grounded:
- `$88A6` effect_build (Grow shape on TOWN field), `$9B7E` driver_dam (dams field $7001+10, limit 100),
  `$B42B` ai_develop_dam_and_grow (the AI economy turn), `$9046` ai_commit_attack_deduct_resources
  (budget = min(rice*2, men, gold)), `$9423` pick_ai_attack_target_fief, `$9814` effect_war_e.
- `$945D` find_fief_by_owner_men_minority ✅ but FLAGGED: the test is fief_men_ratio_pct >= 50 (comparable-or-stronger),
  so the 'minority' name reads backwards — confirm intent later. Next: rows 1-7.

### Bank 1 full-verify batch #13 — give/assign/rest/other orchestrators (97/131)   [2026-06-10]
All confirmed (well-named orchestrators); 1 comment refute:
- `$AC11` `effect_assign` ✅ — REFUTED 'places a retainer': it's the **arms-allocation editor** (render_arms_edit_screen,
  redistribute arms across unit types, $7017).
- `$A8D3` give_transfer_apply (give gold/rice -> develops recipient loyalty/wealth or morale), `$879F`
  province_select_helper, `$A94D` give_rice_gold_eligibility, `$ADB3` driver_rest (capital-only, rest_turns_remaining),
  `$B23E` driver_other (settings submenu), `$B6B4` command_menu_select_loop: re-grounded. Next: rows 1-7.

### Bank 1 full-verify batch #12 — the command drivers + buy effects (90/131)   [2026-06-10]
3 renames + 4 driver re-grounds:
- `$A068` `subhandler_A068` → **`effect_buy_rice`**, `$A113` `subhandler_A113` → **`effect_buy_arms`**,
  `$A553` `effect_hire_variant_pay` → **`effect_hire_men`** (+ 3 data-label renames: msg_buy_rice/arms_prompt, msg_men_or_ninja).
- `$999A` driver_tax, `$9D3D` driver_grow (limit at $7001+24), `$A1B6` driver_trade (6-item submenu), `$A637`
  driver_train: re-grounded. The lord-command menu (Tax/Grow/Trade/Train/buy rice/arms/men) is now wired end-to-end. Next: rows 1-7.

### Bank 1 full-verify batch #11 — spy/bribe/loan + the last stub (83/131)   [2026-06-10]
2 renames (incl. the LAST address-tagged stub — SUSPECT now 0):
- `$AF10` `map_helper_af10` → **`browse_map_sections`** (strategic-map section scroller).
- `$8B40` `effect_subhandler_9F04` → **`effect_take_loan`** (debt += interest = math32_muladddiv(loan_rate+10, amount)).
- `$8D4D` `effect_bribe` ✅ (siphons enemy output, cutscene 26), `$918D` `ninja_mission_resolve_vs_defender` ✅
  (daimyo CHA/IQ contest, skill-scaled rng), `$8271`/`$93DD` relations-vs-rng gates, `$85EA` effect_view_b
  (enemy-fief list): re-grounded. Next: rows 1-7.

### Bank 1 full-verify batch #10 — targeting/trade/war-prep + 2 value-bug flags (76/131)   [2026-06-10]
1 rename + 2 DREAM value-bug flags:
- `$8327` `scale_div10_capcheck` ✅ — the 3rd/last bank-1 ext-op sub (4-c value-wrong, flagged); = -1 if >arg3 else floor(a*b/10).
- `$97EA` `relations_roll_vs_owner` ✅ — bytecode shows `relations_matrix_get(...) > rng_mod(100)` (a real roll); **4-c renders the
  roll as phi_980d_0 — value-wrong, flagged** (nearly mis-renamed it).
- `$8B0A` `effect_subhandler_A003` → **`effect_sell_rice_for_gold`** (gold += rate*rice/10, rice -= amount).
- `$8172` count_eligible_targets, `$933A/$9351` war-prep men/gold checks (sibling of prep_a=rice), `$A93A` effect_give_a:
  re-grounded. The 3 war-prep checks now map cleanly to rice/men/gold. Next: rows 1-7.

### Bank 1 full-verify batch #9 — view/dam/war-prep + a refute (69/131)   [2026-06-10]
3 renames + 1 REFUTE:
- `$A29B` `effect_hire_pay_gold` → **`effect_ninja_failed`** — bytecode-verified it's the ninja FAILURE effect
  ('your ninja failed' + daimyo CHARISMA loss + gold cost), NOT a hire payment.
- `$83C7` `helper_83C7` → **`draw_selected_province_stat`**, `$887D` `helper_dam_rounding` →
  **`add_effect_gain_clamped`** (weakness-halved gain + province-max clamp, used by Dam/Build),
  `$B14B` `subhandler_B14B` → **`command_end_game`** (resign/game-over).
- `$83FA` effect_view_a, `$9323` effect_war_combat_prep_a (rice check; cross-bank $9323 pair), `$B2A1` driver_pass:
  re-grounded. Next: rows 1-7.

### Bank 1 full-verify batch #8 — the Settings ("Other") submenu (62/131)   [2026-06-10]
5 stub renames — the whole settings menu (driver indices 27-31):
- `subhandler_B066` → **`setting_sound_on_off`**, `_B09D` → **`setting_animation_on_off`** (ai_turn_flags bit2),
  `_B0D2` → **`setting_message_wait_speed`** (delay_loop_count = 2n²), `_B109` → **`setting_save_game`**
  (sram_save_pending_flag), `_B12B` → **`setting_watch_battles`**.
- `$ABBD` `commit_arms_record_from_buffer` ✅ (arms-edit save vs $76A9), `$ADF6` `fief_select_input_loop` ✅
  (on-map fief pick from the $9E3C cell list). Next: rows 1-7.

### Bank 1 full-verify batch #7 — bribe/siege/debt + AI reinforce (55/131)   [2026-06-10]
3 renames (2 stubs + a list-suffix; +1 stale data label):
- `$9FAF` `subhandler_9FAF` → **`prompt_repay_debt`** (number_input vs min(debt,gold); $BC59 → msg_repay_debt).
- `$A0ED` `effect_subhandler_A113` → **`amount_div_force_factor`** (was mis-named AND mis-addressed — it's $A0ED).
- `$97C1` `candidate_list_6f4f_lookup` → **`fief_list_parallel_lookup`** (find key in $6F4F, return parallel arg2[i]).
- `$8D02` `bribe_success_check` ✅ (loyalty+CHARISMA contest, skill-scaled rng + coin flip), `$8DFD`
  `resolve_siege_assault_outcome` ✅ (auto-resolve war from $7013 + $6F7F/$6F85), `$AB22` arms-edit screen ($76A9),
  `$960C` AI reinforce: re-grounded. Next: rows 1-7.

### Bank 1 full-verify batch #6 — the develop/move command family (48/131)   [2026-06-10]
All confirmed (well-named); re-grounded with the formulas + a quirk:
- `$891D/$896F/$89C1` `develop_loyalty/wealth/morale` ✅ — all the Grow shape `math32_3arg(amount, 6-skill,
  sqrt((field+sibling)/2 + amount))` capped at headroom. **Quirk: morale adds `gain`, loyalty/wealth add `gain<<1`**
  — morale develops half as fast.
- `$8CA5` `effect_move` ✅ — moves men donor→target ($7011/+16), blending morale/skill/arms via scaled_force_transfer.
- `$8A15` `effect_trade` ✅ (port fiefs 13/14 or 30/32 always; else ai_turn_flags bit0), `$8BC1` bribe value,
  `$8C68` random_daimyo_stat_increment (1/10, +2 capped 200), confirm const_two=skill + the $7001 struct fields. Next: rows 1-7.

### Bank 1 full-verify batch #5 — targeting/view/rate leaves (41/131)   [2026-06-10]
2 renames (drop address suffixes) + a nice difficulty quirk:
- `$8379` `apply_two_grows_const1_override` ✅ — forces const_two(skill)=1 to make a grow DIFFICULTY-INDEPENDENT
  (deterministic events/scenario effects bypass the skill scaling).
- `$85B4` `view_window_redraw_by_6da2_flag` → **`draw_fief_view_label`** ("Home" if capital else state label).
- `$B2B2` `ai_seed_fief_collection_rate_6d2d` → **`ai_seed_fief_tax_rate`** (fief_tax_rate[arg1] = rng+35, 35-64).
- `$812F` target_eligible_by_cmd, `$A91E` give_eligibility_flags (2-bit), `$A6B3` effect_view_d (rng(rec+3)+rec+5),
  `$B32B` rng_threshold_10_29: re-grounded. Next: rows 1-7.

### Bank 1 full-verify batch #4 — hire/train/war-prep effects (34/131)   [2026-06-10]
Clean batch (no decompiler bugs). 2 stub renames:
- `$9181` `ca12_with_const1_wrapper` → **`decrement_byte_at`** (deduct_byte_at(arg1,1)).
- `$A1AF` `subhandler_A1AF` → **`noop_command_handler`** (returns 0; disabled command slots 26/33).
- `$8BF4` `apply_hire_unit_stats` ✅ (blends recruits' morale/skill/arms via scaled_force_transfer, +arg2 men),
  `$9586` `effect_train` ✅ (province skill += rng*4, +10 daimyo IQ+LUCK bonus), `$9368` war-prep weakness gate,
  `$9382` `fief_men_if_provisioned` ✅ (men only if rice; confirms $7001 +6/+16), `$9009` AI-attack announce. Next: rows 1-7.

### Bank 1 full-verify batch #3 — economy command effects (the Grow formula) (27/131)   [2026-06-10]
The command-effect layer — 2 renames + the canonical formulas:
- `$87F0` `effect_grow` ✅ — THE Grow formula: `2*amount*(6-skill)/sqrt(output+amount)`, capped at headroom
  (header-output); grounds `math32_3arg` and cross-confirms the const_two=skill var.
- `$82D6` `effect_tax` ✅ — stat ± pct(stat, |delta|); `$81FC` `effect_war_a` ✅ — zeroes the $6193 relations
  (province + owner pair) on war declaration.
- `$8094` `view_render_five_stats` → **`draw_market_rates`** (loan/exchange/arms/men rates as %2d.%1d).
- `$83D5` `province_window_redraw_ba78` → **`draw_province_stat3_or_dashes`** (3-digit sibling of $83A2; $BA78 →
  str_field_dashes3). `$A274` decline-report, `$B1A6` submenu_prompt: re-grounded. Next: rows 1-7.

### Bank 1 full-verify batch #2 — command-effect + audio/relations leaves (20/131)   [2026-06-10]
Clean leaves, 2 stub renames + re-grounded effects:
- `$87CB` `helper_87CB` → **`show_not_home_fief`** (message_display wrapper).
- `$8B8F` `helper_8B8F` → **`play_result_jingle`** (bank-10 sound 8/7 = accept/reject, used by Pact/Marry).
- `$87D8` `effect_dam` ✅ — sqrt_int(output), 10000 sentinel if no output. `$8BE5` `effect_send` ✅ — min(ceiling-current, budget).
- `$8250` `relations_matrix_get` ✅ (3 args; $6193 stride-54 matrix), `$9301` war-prep field-clamp ✅ (gold/rice/men
  $7001/$7007/$7011), `$A255` `hire_stat_drain_rng` ✅ ((rng_mod(max(pct(a,sqrt(b)),1))+1)*5). Next: rows 1-7.

### Bank 1 full-verify batch #1 — economy/UI leaves + 32-bit math primitives (13/131)   [2026-06-10]
First bank-1 batch (the lord-command/turn engine). 4 renames (3 from stubs) + a NEW DREAM bug class:
- `$8303` `math32_muladddiv` ✅ — bytecode-grounded = floor((rate*amount+9)/10) = ceil(rate*amount/10); 4-c showed a
  placeholder `return rate`. **Logged a new DREAM backlog item: 32-bit ext-op chains render as a placeholder return** —
  any sub with `// ext_op` lines is value-wrong, read the bytecode.
- `$8357` `helper_8357` → **`ratio_times10_capped`** — = min((arg1*10)/arg2, arg3); 4-c `return min_word(arg1,arg3)` was
  value-wrong (dropped the ext-op math).
- `$82AC` `helper_82AC` → **`clamp_amount_to_province_max`** (caps *arg1 at province field $7019 = the +24 word, open).
- `$8A4E` `helper_8A4E` → **`cycle_economy_rate`** (loan_rate / gold_rice_exchange_rate +1/wrap adjuster).
- `$83A2` `province_window_redraw_ba6f` → **`draw_province_stat_or_dashes`** (stat %4d if active, else "----" $BA6F →
  renamed `str_field_dashes`).
- `$804C` `province_select_prompt` ✅ (7-driver fief picker), `$871E` `fief_info_display` ✅ (paged stat panel). Next: rows 1-7.


### ★★ BANK 2 FULL-VERIFICATION COMPLETE ★★ — batch #16, the 9 combat-driver roots (131/131, 100%)   [2026-06-10]
**Every one of bank 2's 131 subs is now read-verified against its bytecode (0 todo, 0 suspects).** The final 9 are the
depth 8-13 roots, all confirmed (everything they call was grounded in batches 1-15):
- `$AFE1` `battle_init_driver` ✅ — THE root (depth 13, $8000 entry): map_populate -> render_combat_map_screen ->
  battle_init_defender -> draw_combat_fief_day_header -> dispatch_battle_resolution.
- `$ADD1` `run_both_sides_combat_turn` ✅ (one day, both sides) -> `$ABB7` `ai_run_all_units_combat_actions` (one side) ->
  `$A8CF` `ai_select_unit_combat_action` (one unit) -> `$A6C5` `ai_choose_combat_action_by_battle_strength`.
- `$A5A4`/`$A625` AI advance (toward enemies / into free cells), `$A90E`/`$A96C` player move loops (place / melee): re-grounded.
**The full combat call tree reads top-to-bottom as a coherent system.** Tally for the bank-2 full-verify arc (16 batches,
7/batch): ~30 renames + ~40 refuted/corrected comments on previously `[HIGH/MED CONFIRMED]` labels + 2 new DREAM value-bug
classes logged (switch / arms-reconverge value-merge) + the difficulty-knob ($9C88) + the $7001/$7013 record offset maps.
**Vindicates the full-verify bar: the clean names were wrong as often as the stubs.**

### Bank 2 full-verify batch #15 — AI brain + command/move drivers (122/131, 93%)   [2026-06-10]
High-level drivers — all well-named (everything they call is now grounded), mostly re-grounding + 1 return fix:
- `$A52F` `ai_decide_unit_action_attack_or_advance` ✅ — the per-unit AI tactical BRAIN (target -> attack, else advance);
  integrates the whole batch-8..13 AI-strength stack.
- `$A1EF` `ai_engage_present_enemy_if_favorable` ✅ — fixed 'always returns 0' (returns 1 when it engages).
- `$AC7F` `combat_command_dispatch_loop_per_unit` ✅ (the $B9F8 command driver), `$9A18` player move loop,
  `$99D2` AI placement, `$90A0` move-direction prompt, `$A3F8` AI target select: re-grounded. Next: final ~9 (the roots).

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

### >>> NEXT BLOCK (start here): FULL-VERIFY bank 0 (the main loop) — LAST bank <<<
**★ BANKS 2 + 1 FULL-VERIFY COMPLETE (131/131 each, 2026-06-10).** Only **bank 0** remains (~98 subs, the main game
loop — the bank loaded first, entry `vm_bootstrap`, per Chris). Same loop: `py -3 tools/bank-ground-order.py 0 --todo`,
7/batch, read each against bytecode, confirm-or-REFUTE, regen, commit. **Method wins to reuse:** (1) read ROM strings
for any draw_message target (py, file off = 16 + bank*0x4000 + (cpu - (bank==15?0xC000:0x8000))); (2) READ THE BYTECODE
for any sub with `// ext_op` lines (32-bit math, 4-c is value-wrong) or a suspicious linear body (value-merge bugs);
(3) NO nested double-quotes or em-dashes in toml comments (use single quotes — they break parse_toml); (4) the clean
descriptive names are wrong as often as the stubs. Cross-bank same-addr pairs ($83A2/$93AA/$85A7 etc.) are FINE.
Bank 0 is the main loop so expect: the turn/season scheduler, new-game setup, the dispatch into banks 1 (commands) &
2 (combat) via call_bank, and succession/event handling. After bank 0: the corpus is fully grounded -> the optional
decompiler-bug capstone (see tech-debt.md), then the chapter rename-sweep.

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
