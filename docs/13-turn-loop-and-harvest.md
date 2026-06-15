---
status: active
created: 2026-05-14
layout: default
title: "Chapter 13 \u2014 The Turn Loop and the Harvest: What a Round Looks Like"
---
# Chapter 13 — The Turn Loop and the Harvest: What a Round Looks Like

> Chapter 11 mapped the player's 21 verbs; chapter 12 mapped the AI's decision engine. What was missing was the *loop* that drives both — the per-round backbone that hands the turn from player to AI, processes every fief, fires the season's harvest, and comes back to the player. A Mesen `$EB7A` call-graph trace across a full turn boundary (a fall turn, two wars) makes that backbone visible. This chapter walks the trace and shows the five-phase shape of a round, the per-fief AI pipeline (correcting chapter 12), the harvest's signature, and where the exact top-level loop sub still hides.

**Links:** [Chapter 12 — Daimyo AI](./12-daimyo-ai.md) · [Chapter 11 — The Strategic Engine](./11-strategic-engine-complete.md) · [Nobunaga README](./README.md)

> **✔ Decompiled (2026-06-12) — the loop no longer hides.** Pass 2 walked the turn loop in the grounded C; the trace narrative below is how it was *found* and still holds in shape, but the structural questions it left open are now answered. The turn loop is **bank 0** (its own bank; commands are bank 1, combat bank 2).
>
> **`vm_bootstrap $A778` is the top-level loop** (the sub ch.13 said "still hides"). After `init_new_game_state`, it runs forever, and each **season** does:
> 1. **`ai_strategic_turn_planner $A455`** — the *season change*: write the deferred SRAM save (the Other→Save flag); advance `current_season` (`&3`, four per year) and, **at the year wrap, `current_game_year++` + `roll_period_market_rates`** (so the merchant rates re-roll *yearly*, not per-turn); run `per_period_fief_daimyo_update_driver`; cap every fief's stats; pick and fire **one random event** (the full catalogue — flood/ravage/riot/revolt/illness/death — is **[Appendix D: The Event System](./appendix-events.md)**); run the illness sweep (a low-health daimyo, `rng(400) < 100−health`, is flagged and *"has taken ill"*).
> 2. **Combat** — if a war or revolt is staged, `call_bank_wrap(2)` into **bank 2** and re-plan.
> 3. **`shuffle_fief_turn_order_array`** — randomize this round's turn order (`$6F1B`). *(This is the `$6F0B`-style permutation; it is why a Send can arrive after the fief that needed it already acted — ch.11.)*
> 4. **`call_bank_wrap(1)` → `ai_per_fief_command_driver $B89B`** — the **command phase**: walk `daimyo_turn_order`, and for each fief dispatch on `province_ai_state` — a player **Direct (5)** fief calls `issue_province_command` (the interactive *"your orders?"* menu, ch.11); an **AI (0)** fief runs the weighted-coin-flip cascade (ch.12); a war launched mid-phase re-enters bank 2. **This is the single driver ch.13 (below) correctly guessed dispatches "player-handler-or-AI by ownership."**
> 5. Game over when `ai_turn_flags` bit 7 is set → the victory/defeat graphic.
>
> **The seasonal task rotation** (`per_period_fief_daimyo_update_driver` → `switch(current_season)`) is the spine of "what a round does":
>
> | season | the season's maintenance task |
> |---|---|
> | 0 (Spring) | **aging** — `per_turn_age_daimyo_decay_health_and_province_stats` |
> | 1 (Summer) | province highwater marks |
> | 2 (Fall) | **the HARVEST** — `harvest_income_sweep_all_fiefs` |
> | 3 (Winter) | **relations decay** — `normalize_relations_matrix_lower` |
>
> Plus, **every** season: `drift_daimyo_luck` per fief and a natural-death check per fief. So the **harvest is annual (Fall)**, relations decay annual (Winter), aging annual (Spring) — and Luck drifts four times a year.
>
> **The harvest itself** (`harvest_income_sweep_all_fiefs`): per fief, if loyalty>0 add `calc_fief_gold_income` + `calc_fief_rice_income` (the tax%-scaled formula, appendix §4); **then auto-repay debt from the new gold** (`repay_province_debt_from_gold` — the Trade-loan counterpart) and **subtract army upkeep** (`consume_province_army_upkeep`). One twist: an **AI-run fief (state 0) gets a bonus** `event_boost_province_gold_output` — the AI economy is quietly subsidized (rubber-banding). A fief in full revolt (loyalty 0) earns nothing.
>
> **✔ Harvest Pass-2 bytecode-certified (2026-06-14)** — every sub above walked in grounded C and re-checked opcode-for-opcode in `bank_00_vm.asm`; the appendix-§4 formula holds exactly. Three refinements landed there: (a) the income RNG ceiling's `$946D` is **daimyo Charisma** (`daimyo_record+4`); (b) upkeep includes **army starvation** — if `min(gold,rice) < MEN/2`, `men` is cut to `2·min(gold,rice)`; (c) two **timing** facts that touch this chapter's seasonal table — relations actually decay **twice a year** (`normalize_relations_matrix_lower` runs at the *top of the Fall harvest sweep* as well as in Winter), and the low-water marks are **re-seeded each Summer** (`init_province_highwater_from_records`, season 1), so a stat dip costs only one year of income, not "permanently."
>
> **Correction to the trace below:** the *"harvest = the `$E03C` cluster"* identification in Phase 4 was wrong — `$E03C` is `apply_conquest_outcome` and `$DA24` is `scaled_force_transfer` (Move's arms blend). The trace caught those because an AI war *resolved* in that window; the real harvest is `harvest_income_sweep_all_fiefs` (bank 0), fired only in Fall.

## What the trace shows

14 985 `$EB7A` events across frames 29 731 – 33 321 (≈ 3 590 frames, one full turn boundary). Stripping the idle cursor loop, the events fall into a clean five-phase shape:

| Phase | Frames | What's happening |
|---|---|---|
| 1. End of previous player turn | 29 700 – 30 000 | UI render, message dismissal |
| 2. **AI turns** | 30 300 – 31 000 | the per-fief AI pipeline, ~16 iterations |
| 3. *Hit any key* pause | 31 200 – 31 600 | `$801D`/`$8003`/`$CA03`/`$CBB1` polling loop |
| 4. **Harvest / season change** | 31 700 – 32 100 | the `$E03C` cluster driving `$D70D` math |
| 5. *Hit any key* pause + new player turn | 32 200 – 33 321 | second pause, then `$B79B` fires at Fr 33 101 |

Two wars are folded into phase 2 — one of those 16 AI iterations included combat (the `$87D8` Dam effect handler fires 22 times — more than any other effect — suggesting some of those AI fiefs went to war and the war path reuses that handler). Combat's full path is the next chapter arc.

## Phase 2 — the AI per-fief pipeline (corrects chapter 12)

Each AI-fief iteration is a fixed sequence. Reading two consecutive iterations side by side (Fr 30 839 and Fr 30 868) shows the same call shape every time:

```
$CC54                                 ; close the previous render
$B875  -> $B64B  -> $CA52/$CA46       ; first stage; develop-dispatcher; roll
$B4D5  -> $949A -> $D972/$DAD7/$DAAB  ; second stage; bank-0 helpers
$D98D ×many / $DD3A / $D9B7 / $D77E   ; predicate scans
$93B3 / $939D / $9382 / $D6DE  (loop) ; per-target scoring (4 iterations)
$CA52/$CA46  $945D                    ; another roll, dispatch
$B2EF / $B2B2 / $CB94 / $DB12         ; pipeline tail handlers
$B338 / $B32B                         ; more decision branches
$8357 / $CB5E / $8303 / $8A4E         ; military/economic helpers
$D134 / $CFFC / $CA65 / ...           ; status redraw
$CC7B / $B2EF / $CB5E / $8BE5 / ...   ; another helper invocation
$B42B  -> $B2B2 / $CB94 / $DB12       ; develop executor
   $87D8 / $CBCD / $87D8 / $CBCD      ; effects: Dam, sqrt, Dam, sqrt
   $887D / $D972 / $82AC / $CB5E      ; Dam2
   $87F0 / $D836                      ; Grow
$D7DA / $D7CD / $D815 / $D7F7         ; UI updates after the action
$8C68 / $D98D / $CA52/$CA46 ×many     ; post-action rolls (RNG bursts)
$D972 / $D628 / $D98D / $D982         ; predicate cleanups
$CC7B / $D134 / ...                   ; re-render for the next fief
```

The crucial correction to chapter 12: **`$B875`, `$B64B`, `$B4D5`, `$B3AA`, `$B42B` are *stages of a pipeline*, not alternatives.** Each fires roughly 16 times — once per AI fief — and they run in the same order every time. The `$B94C` 6-way switch (chapter 12) lives *inside* `$B64B`, where it picks among the Dam/Grow/Build sub-actions; that part of chapter 12 is right, just one level down. The cascade-of-coin-flips model is *more* right under this correction: each pipeline stage has its own `$CA52` roll deciding "should I do this at all" — so an AI fief that doesn't need development simply rolls 0 at every stage and the fief produces nothing.

Three observations the corrected model makes obvious:

1. **`$CA52`/`$CA46` fire 555 times each over the round** — a 1:1 lockstep, which is consistent with `$CA52`'s body (one guard, then one RNG call). 555 ÷ 16 fiefs ≈ 35 rolls per fief — a *lot* of dice, which fits a "many stages, each independently gated" pipeline rather than a single decision.
2. **`$87D8` (Dam effect) fires 22 times** versus `$87F0` (Grow) and `$887D` (Dam2) at 12 and 11 — the develop dispatcher leans on Dam. Whether that's per-fief bias or one fief getting Dam'd repeatedly is a trace-by-frame question.
3. **`$B8A0`, the "Turn %2d Fief %2d" sub, never fires.** Chapter 12 called it the AI per-fief turn handler. It isn't. It's a different context — likely combat or scenario start — and the real pipeline entry is reached indirectly (a native loop or a deep indirect call, see "what's still open" below).

## Phase 4 — the harvest

Burst 2 (Fr 31 700 – 32 100) carries a different signature from the AI pipeline: heavy `$D70D` (the percentage operator), with three new subs at the head — **`$E03C`, `$DF73`, `$DA24`** — plus the familiar `$D6DE` helper. That math-heavy fingerprint, in the slot between AI turns and the next player turn, is the **harvest / season change**. (Bank 2 `$9E73`, the candidate I'd identified from chapter 8's "value + income, clamped at 9999" code, doesn't fire here — that sub is something economy-adjacent but not the seasonal harvest. The real harvest lives in bank 15 at the `$E03C` cluster.)

What the harvest *does* — apply per-fief income on a percentage curve, clamp at 9999 — is the same shape as the develop commands' tails (chapter 8, chapter 10), just driven over every fief in one pass. The exact field updates (which stats accumulate, which decay) are an effect-formula appendix item once the `$E03C` body is walked.

## Phase 5 — the player turn entry

Frame 33 101 fires `$B79B` — the player command-dispatch from chapter 11 (the *"your orders?"* prompt → `$B9B2` indirect call). The lead-in is identical to the AI pipeline's: a status render (`$CC7B`/`$D134`/`$CFFC`/`$CA65`/`$CB30`/`$CB11`/`$CEC4`), then `$CC54` closing the render, then **`$B79B`** fires and immediately calls `$85A7` and starts iterating through `$83D5`/`$83A2` (the per-fief sub-renderers chapter 11 already noted inside `$B79B`'s loop). So the *same* render preamble (`$CC54`-terminated status display) precedes both an AI-fief iteration and the start of the player turn — the loop calls one handler or the other based on who owns the current fief.

That symmetry is the structural hint about the top-level loop: **it iterates "the next fief to process" and dispatches player-handler-or-AI-pipeline based on ownership** — same render preamble, different action sub.

## What's still open

*(Most of the 2026-05-14 open list is now closed by the decompiled model above; the survivors:)*

- ~~The exact top-level loop sub~~ — **closed**: `vm_bootstrap $A778` (bank 0), with the per-fief dispatcher `ai_per_fief_command_driver $B89B`.
- ~~The harvest body~~ — **closed**: `harvest_income_sweep_all_fiefs` (bank 0, Fall only), using the appendix-§4 `calc_fief_gold_income`/`calc_fief_rice_income`. The `$E03C` cluster was conquest, not harvest.
- **The AI war path (→ combat, bank 2).** A staged war hands off via `call_bank_wrap(2)`; walking the bank-2 combat resolution is the next chapter arc (ch.14–17).
- **`drift_daimyo_luck $A2ED` — the drift's sign and magnitude.** We know it fires per fief every season; whether Luck trends down (the "early-game window" thesis) and by how much is a short read of the `$A2ED` body.
- **The event payloads.** The disaster/ravage/boon handlers (`decay_fief_list_wealth_and_output_disaster1`, `random_event_ravage_output_hidden_mark_weakness`, `ai_event_build_two_batches_dispatch_or_announce`) and `spawn_zealot_uprising_force_from_province` are named; their exact field effects are a short walk each.
- **Leader characteristics in command effects.** Grow's effect didn't read the daimyo record; War's does (combat is where Drive/Charisma/etc. weigh in) — that lands in the combat chapters.

## Method note — when the trace beats the static walk

This chapter is the first one where a Mesen capture *corrected* a static reading (the chapter-12 pipeline-vs-switch error) rather than just confirming one. The pattern is general: when dispatch goes through computed indirection — table-index times stride plus base, all in one bytecode subroutine — *no* literal address appears in the ROM for the called handler, and reference-search is blind. A trace of the indirect-jmp trampoline (`$EB7A`) makes the call graph visible directly. It is the right tool for "this code is reached, but nothing names it." Combined with the static walk (for *content*), it is the project's full toolkit.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
