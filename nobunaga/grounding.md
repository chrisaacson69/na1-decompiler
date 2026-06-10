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

1. **Pick** the next leaf from `label-walk`'s leaves-first cursor
   (`py -3 tools/label-walk-prep.py <bank>`); take high-fanout first for leverage.
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

### >>> NEXT BLOCK (start here): next high-fanout non-UI leaves <<<
The UI-primitive cluster is done (vocabulary grounded + chaptered). Re-run the leaves-first cursor
(`py -3 tools/label-walk-prep.py <bank>`) and take the next high-fanout leaves OUTSIDE the UI family.
Still-open threads to fold in when their inputs get grounded: `$E80C` name (needs `mem_7FCB` +
bank-14 routine 14); the `$7FD1`/`ui_msg_col_shift_flag` axis (read `message_display $D338`); the
`$7530` per-daimyo stat table (stride 7) and `$77A8` daimyo-name table (stride 9) exposed by `fief_owner`.

### Then: finish the UI-primitive vocabulary + write the chapter-18 section once
Grounded primitives so far: `format_string`($CFFC), `set_cursor`($CC7B), `draw_message`($D134),
`open_message_window`($CC89), `redraw_window`($CEC4), `prompt_y_n`($D3A7), `standard_delay`($D759).
Once the draw-window family lands, write the chapter-18 "UI primitive vocabulary" section in one pass.

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
