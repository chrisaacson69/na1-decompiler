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

## Ledger (append-only, newest first)

### `$CC89`  `ui_helper_cc89` → `open_message_window`   [HIGH CONFIRMED 2026-06-10]
`open_message_window()` = `ppu_blit_nobank_wrap(2, shift?20:22, 19, 25, 1); set_cursor(2, shift?20:22)`
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

- **UI-primitive vocabulary cluster** (ground together, then write the chapter-18 section once).
  Grounded: `format_string`($CFFC), `set_cursor`($CC7B), `draw_message`($D134),
  `open_message_window`($CC89), `redraw_window`($CEC4).
  Pending: `ui_helper_e80c` ×73, `ui_helper_d77e` ×65, `ui_draw_window_d31a`/`d309`, `ui_helper_d3a7`,
  `ui_helper_d759`, `ui_helper_e510` — do `e80c` next (highest fanout left).
  `marry_helper_cc35` ×91 also pending (non-UI; verify the "marry" guess).
- **Open sub-question:** read `message_display ($D338)` to settle the `$7FD1` axis (row vs col) +
  confirm/rename `ui_msg_col_shift_flag` across both consumers.
- **Pass-0 native floor:** enumerate the Bank-15 code the bytecode compiler did not claim; ground
  the 6502 leaves (syscalls + kernel) under the VM.
- **Sub-targets exposed by grounded leaves:** `$7530` (per-daimyo stat table, stride 7), `$77A8`
  (daimyo-name table, stride 9).
- **Backlog size:** 454 distinct `_XXXX`-suffixed (address-tagged = self-confessed low-fidelity)
  names across `source/4-c/`.
