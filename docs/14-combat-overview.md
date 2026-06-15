---
status: active
created: 2026-05-14
updated: 2026-06-13
layout: default
title: "Chapter 14 \u2014 Combat: Structure, Strings, and the Day Loop"
---
# Chapter 14 — Combat: Structure, Strings, and the Day Loop

> Chapter 13 stitched together the strategic loop and noted that two wars were *folded into* the AI's turn. This chapter opens the war door: the entry point, the day loop, the tactical command menu, the 3-unit-type model, and the four ways a battle ends. It is the *map* of combat; chapters 15–16 walk the tactical-map data and render, and **chapter 17 carries the now-decoded, emulator-certified damage formula**. (Pass 2, 2026-06: the formula that the Pass-1 walk left deferred has been recovered from the decompiled bytecode and confirmed against live battles — the call-graph anchors below are corrected accordingly.)

**Links:** [Chapter 13 — Turn Loop](./13-turn-loop-and-harvest.md) · [Chapter 11 — Strategic Engine](./11-strategic-engine-complete.md) · [Chapter 17 — Damage Formula](./17-damage-formula.md) · [Nobunaga README](./README.md)

## Where combat lives

Combat is its **own bank — bank 2**. The strategic loop (bank 0) and the AI/command layer (bank 1) call into it via `call_bank_wrap(2)`, whose entry is **`battle_init_driver $AFE1`**. A war can be launched three ways (an AI invasion, a player attack, or a revolt/uprising), and all of them converge on `$AFE1`.

```
        AI war / player War / uprising
                  │  call_bank_wrap(2)
                  ▼
      battle_init_driver  $AFE1
        ├─ map_populate $8903        build the 11×5 terrain grid (ch.15)
        ├─ render_combat_map_screen  $8977
        ├─ battle_init_defender      read defended fief's gold/rice/men; if
        │                            rice≤0 or men≤0 → undefended → instant resolve
        ├─ deploy_both_sides_units_loop
        └─ DAY LOOP (max 30 days)
             run_both_sides_combat_turn $ADD1
               ├─ halve_defender_morale_for_breaching_attackers
               └─ per side, in order:
                    AI side    → ai_run_all_units_combat_actions $ABB7
                    player side→ combat_command_dispatch_loop_per_unit $AC7F
             consume_daily_battle_rice      supply tick (the rice clock)
                  │
                  ▼
        dispatch_battle_resolution $AF3B    end-of-battle: succession + conquest
```

**Side convention** (confirmed via `get_battle_side_province $838F`): **side 0 = attacker** (`selected_province_idx`), **side 1 = defender** (`battle_defending_province`).

## The tactical command menu — **6 verbs** (not 5)

The Pass-1 string sweep missed one. The menu is six packed strings at `combat_command_menu_str_ptrs $B4F0`, dispatched through `combat_command_jumptab $B9F8`:

| # | Verb | String | Handler | What it does |
|---|---|---|---|---|
| 0 | **Move** | `$B4FC` | `$A90E` | step the unit to a free in-bounds tile |
| 1 | **Attack** | `$B501` | `$A96C` | step *into* an enemy-occupied tile → **`resolve_attack_apply_mutual_casualties $9E20`** (the melee math, ch.17) |
| 2 | **Bribe** | `$B508` | `$A9FB` | pick a target + spend gold → **`resolve_attack_apply_casualties $9E73`** (enemy men defect to your commander) |
| 3 | **Flee** | `$B50E` | `$AAA7` | retreat to a chosen fief; relocates the capital; ends the battle |
| 4 | **Pass** | `$B513` | `$AB37` | take no action, advance to the next unit |
| 5 | **View** | `$B518` | `$AB6A` | show the roster, hit-any-key |

Each unit slot 0–4 is prompted in turn (`combat_command_dispatch_loop_per_unit`); a verb whose handler returns truthy re-prompts the same unit, falsy advances. **Move** is the verb the original walk overlooked — and it matters, because *Attack is Move-into-contact*: you reach an enemy by moving onto its tile, which is also what triggers the **castle breach** (an attacker reaching the castle cell halves the defender's morale — ch.15/17).

Two verbs reach across layers:

- **Bribe** spends gold mid-battle to peel enemy soldiers into your **commander's** unit (a defection, not a kill). It's a morale-and-Charisma contest with a flat per-soldier gold price — the full formula is in chapter 17.
- **Flee** is *voluntary* withdrawal, distinct from being forced out by attrition (the failure modes below cover the forced cases).

## The unit-type model — 3 types in 5 slots

`unit_type_name_table $F9AF` is a 3-entry pointer table:

| Type | String | Note |
|---|---|---|
| 0 | `Rifles ` | trailing space — 7-char fixed slot |
| 1 | `Infntry` | abbreviated for the 7-char slot |
| 2 | `Cavalry` | |

An army is **5 fixed-position slots**, each with a deterministic type via `(wrap_0_2(slot)+1) % 3`: slot 0 → Infantry (the **commander** — losing it ends the battle), slot 1 → Cavalry, slot 2 → Rifles, slots 3–4 → Infantry. The strategic-layer **Assign** distributes the men-% across these slots (`distribute_men_into_unit_strengths`); 0% is allowed for every slot except the commander. So it is *not* "5 types" — it's 3 types in 5 fixed positions, and the composition (how many men in which slot) drives the unit-rank term of the damage formula (ch.17).

## The four failure modes (plus retreat and timeout)

`dispatch_battle_resolution` ends a battle on a resolution code, each with its message:

| Message | Address | Mechanic |
|---|---|---|
| `"this is truly unfortunate..."` | `$B7B1` | **commander killed** (unit 0 gone) → that side loses |
| `"your men are exhausted!"` | `$B7F3` | **morale/exhaustion** → forced rout |
| `"you have no rice!"` | `$B8A9` | **supply attrition** → attacker starved out (the **doughnut-fief** mechanic) |
| `"you have no soldiers!"` | `$B8BB` | **annihilation** → all units destroyed |

Plus voluntary withdrawal (`"%s has retreated"`, `$B96E`) and the **30-day timeout** (the battle is capped at 30 days; the rice clock runs underneath it). The supply-attrition ending is the find Chris flagged at the very start: a defender who evades contact on a doughnut/chokepoint map runs the attacker's rice to zero and wins, losing nothing — quantified in chapter 17's rice analysis.

## Two combat formulas, by who fights

A subtlety the map must record: **whether a battle is *watched* decides which math resolves it** (gated at bank-1 `$9130`: `ui_confirm_flag_6e7d || defender is the player`).

- **Watched / player-involved** → the full tactical engine above runs (`battle_init_driver`, the day loop, the per-unit menu). This is the engine chapter 17 decodes.
- **Unwatched AI-vs-AI** → bank 2 is skipped entirely and a single abstract resolver runs instead (`resolve_siege_assault_outcome $8DFD`, bank 1): one strength comparison, `men·(2+bonus) + arms + skill + morale`, +10% to the higher-**Drive** daimyo, higher total wins. Same *cleanup* (`apply_conquest_outcome`), different *fight*.

So the "Watch Battles" option isn't cosmetic — it changes how AI wars on the map resolve.

## What this gives the next chapters

After this chapter the combat map is complete and the deep reads are anchored:

- **Chapter 15** — the tactical map: where per-fief cell/terrain data lives (`tactical_map_cell_pool $A57E`, selected by the province→map-id table) and the doughnut/chokepoint topology.
- **Chapter 16** — the render pipeline that turns that cell data + combat CHR + the combat palette into the on-screen battle.
- **Chapter 17** — the damage formula, now **decoded and emulator-certified**: the mutual-attrition strength-share for Attack, the Charisma-contest defection for Bribe, the battle cleanup, and the still-open terrain question.

## Method note

The Pass-1 trace gave the right *surface* (every sub the battle uses, in roughly the right counts) but mis-attributed the damage math to the high-frequency pointer helper `unit_col_ptr $828B` — it fires ~1000×/battle because *every* tile/position read goes through it, not because it computes damage. The lesson held up: when a trace gives counts but not contents, the **strings** the same code displays are the contents (the menu, the unit types, the failure modes all came from the ROM string sweep). What the trace could *not* give — the actual coefficients — needed the decompiled bytecode plus a live emulator pass, which is chapter 17's story.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
