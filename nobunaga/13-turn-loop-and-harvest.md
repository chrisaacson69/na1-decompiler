---
status: active
created: 2026-05-14
---
# Chapter 13 — The Turn Loop and the Harvest: What a Round Looks Like

> Chapter 11 mapped the player's 21 verbs; chapter 12 mapped the AI's decision engine. This chapter is the *loop* that drives both — the per-round backbone that advances the season, fires the harvest, hands each fief to the player or the AI, and comes back around. It lives in **bank 0** (commands are bank 1, combat bank 2), and it is the spine the rest of the engine hangs from.

**Links:** [Chapter 12 — Daimyo AI](./12-daimyo-ai.md) · [Chapter 11 — The Strategic Engine](./11-strategic-engine-complete.md) · [Appendix A — Formulas](./appendix-formulas.md) · [Appendix D — The Event System](./appendix-events.md) · [Nobunaga README](./README.md)

## The turn loop — `vm_bootstrap $A778` (bank 0)

After `init_new_game_state`, `vm_bootstrap` runs forever. Each **season** is five phases:

1. **`ai_strategic_turn_planner $A455` — the season change.** Write the deferred SRAM save (the Other▸Save flag); advance `current_season` (`& 3`, four per year) and, **at the year wrap, `current_game_year++` + `roll_period_market_rates`** (so the merchant's rates re-roll *yearly*, not per-turn); run `per_period_fief_daimyo_update_driver` (below); cap every fief's stats; pick and fire **one random event** (the full flood/ravage/riot/revolt/illness/death catalogue is **[Appendix D](./appendix-events.md)**); run the illness sweep (a low-health daimyo, `rng(400) < 100−health`, is flagged and *"has taken ill"*).
2. **Combat.** If a war or revolt is staged, `call_bank_wrap(2)` into **bank 2**, then re-plan.
3. **`shuffle_fief_turn_order_array`.** Randomize this round's turn order (`$6F1B`) — which is why a Send can arrive *after* the fief that needed it already acted (ch.11).
4. **`call_bank_wrap(1)` → `ai_per_fief_command_driver $B89B` — the command phase** (below).
5. **Game over** when `ai_turn_flags` bit 7 is set → the victory/defeat graphic.

## The seasonal task rotation

`per_period_fief_daimyo_update_driver` switches on `current_season` — the spine of "what a round does":

| season | the season's maintenance task |
|---|---|
| 0 (Spring) | **aging** — `per_turn_age_daimyo_decay_health_and_province_stats` |
| 1 (Summer) | re-seed the province **high-water marks** (`init_province_highwater_from_records`) |
| 2 (Fall) | **the HARVEST** — `harvest_income_sweep_all_fiefs` |
| 3 (Winter) | **relations decay** — `normalize_relations_matrix_lower` |

Plus, **every** season: `drift_daimyo_luck` per fief and a natural-death check per fief. So the harvest is annual (Fall), aging annual (Spring), and Luck drifts four times a year. Two timing wrinkles: relations actually decay **twice a year** (`normalize_relations_matrix_lower` also runs at the *top* of the Fall harvest sweep), and the high-water marks re-seed each Summer — so a stat dip costs only one year of income, not permanently.

## The harvest (Fall)

`harvest_income_sweep_all_fiefs`, per fief: if `loyalty > 0`, add `calc_fief_gold_income` + `calc_fief_rice_income` (the tax%-scaled formula, [appendix §4](./appendix-formulas.md)); **then auto-repay debt from the new gold** (`repay_province_debt_from_gold` — the Trade-loan counterpart) and **subtract army upkeep** (`consume_province_army_upkeep`). A fief in full revolt (`loyalty == 0`) earns nothing. One asymmetry: an **AI-run fief (`state == 0`) gets a bonus** (`event_boost_province_gold_output`) — the AI economy is quietly subsidized, a rubber-band (ch.12).

Three details, bytecode-certified against `bank_00_vm.asm`:

- **The income-RNG ceiling `$946D` is the daimyo's Charisma** (`daimyo_record + 4`) — a high-Charisma lord harvests more, on average.
- **Upkeep can starve an army.** If `min(gold, rice) < MEN/2`, `men` is cut to `2·min(gold, rice)` — a fief that can't feed and pay its troops loses them.
- **Debt auto-repays before upkeep**, so a leveraged fief's harvest services the Trade loan first.

## The command phase — `ai_per_fief_command_driver $B89B`

The driver walks `daimyo_turn_order` and, for each fief, dispatches on `province_ai_state`:

- a player **Direct (5)** fief calls `issue_province_command` — the interactive *"your orders?"* menu (ch.11);
- an **AI (0)** fief runs the weighted-coin-flip cascade (ch.12);
- a war launched mid-phase re-enters bank 2.

The same render preamble (a status display terminated by `$CC54`) precedes both an AI-fief iteration and the start of the player's turn — the loop calls one handler or the other purely on who owns the current fief.

Inside an AI fief, the decode aligns with ch.12: `$B875` (`ai_econ_action_state0`) → `$B64B` (`ai_econ_command_dispatch`) → the develop/recruit sub-actions (`$B3AA`/`$B42B`/`$B4D5`), each gated by its own `$CA52` roll. They run as a **cascade every fief, not switch-alternatives** — `$CA52`/`$CA46` fire ~555 times each over a round (≈35 rolls per fief across ~16 fiefs), exactly the signature of "many stages, each independently gated." The `$B94C` 6-way switch is the *player's* Grant policy, sitting one level down inside the dispatcher — not the AI's choice.

## What's open

- **The AI war path → combat (bank 2).** A staged war hands off via `call_bank_wrap(2)`; the bank-2 resolution is the combat chapters (ch.14–17).
- **`drift_daimyo_luck $A2ED`** — sign and magnitude. It fires per fief every season; whether Luck trends down (the "early-game window" thesis) and by how much is a short read of the `$A2ED` body.
- **The event payloads.** The disaster/ravage/boon handlers and `spawn_uprising_force_from_province` are named (Appendix D); their exact field effects are a short walk each.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
