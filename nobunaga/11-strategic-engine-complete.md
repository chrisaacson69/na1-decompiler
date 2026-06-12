---
status: active
created: 2026-05-14
---
# Chapter 11 — The Strategic Engine, Complete: All 21 Lord Commands

> Chapters 9 and 10 traced Grow and diffed its family. This chapter walks the remaining thirteen menu commands and assembles the whole picture: every action a player can take on their turn, what it costs, what it touches, and what it tells us about the game's strategic design. With the flow-following disassembler and the in-game-text resolver from chapter 9, each command's *driver* gives up its structure on one pass — the strings it shows are, quite literally, the game narrating its own mechanics. By the end the **strategic engine is mapped end to end**: 21 commands, five functional groups, one shared UI substrate.

**Links:** [Chapter 9 — Command System & Grow](./09-command-system-and-grow.md) · [Chapter 10 — Command Families](./10-command-families.md) · [Chapter 7 — SRAM Save Layer](./07-sram-save-layer.md) · [Nobunaga README](./README.md)

## Method: the strings narrate the mechanics

Once `op_8E push_imm_word` operands resolve to text (chapter 9), a command driver reads almost like a screenplay. `"Tax is %d\nEnter new tax"` followed by `"The peasants are protesting!"` / `"The peasants are delighted!"` *is* the Tax mechanic — set a rate, the peasantry reacts. So this chapter characterizes each command from its driver: the prompts it shows, the preconditions that gate it, the cost it charges, and the helper subroutines it calls. This is **structural characterization, not formula tracing** — the per-command effect handlers (the exact numbers) are a later pass — but it is enough to lay out the complete action space.

## The thirteen remaining commands

### Military

**Move** (`driver_move $96D1`) — relocate troops between your own provinces. Prompts: *"Move where?"* (province select), *"How many men"* (`number_input`), *"Will you lead them personally"*. Success: *"They have arrived safely"*. Gated by `effect_war_combat_prep_b` (a *"you have no soldiers"* check — the source must have men) and by destination capacity — the move amount is clamped to `min(src.men, dest.capacity − dest.men)`, else *"That fief can't hold more men"*. The effect (`effect_move $8CA5`) shifts the men **and blends the three military quality stats — morale/skill/arms** — as a men-weighted average of garrison-and-incoming (`scaled_force_transfer`, the same dilution as Hire), capped at the `header` ceiling; an emptied source has its military stats cleared.

> **The "lead them personally" choice MOVES THE CAPITAL** (`$9782`) — confirmed against the grounded C (2026-06-12). When the source fief *is* the daimyo's seat (and the lord isn't *"too weak for battle"*), answering yes does `fief_is_daimyo_capital[src]=0; fief_is_daimyo_capital[dest]=1` — the lord physically relocates his capital to the destination. This is not merely a "combat modifier": `fief_is_daimyo_capital` (`$6DA2`, a per-fief 0/1 flag, census-confirmed one-per-living-daimyo) is the **seat** that the assassination gate (`$A349`, mission 4) checks — *"The daimyo is out."* fires on any non-capital target. So the assassination target is a **mobile seat**: a player can relocate it (a lead-personally Move out of the capital) to dodge, and conquest reassigns it. The flag also grants a **+1 defensive multiplier** in battle (`ai_sum_battle_strength`: `(capital+2)·men`), so relocating the seat fortifies the destination. (Distinct from `province_ai_state` `$6CF7`, the Grant governance byte — `0=Home, 1=Industrial, 2=Military, 3=Balanced, 4=Farming, 5=Direct, 0xFF=unowned`; Move sets the destination to **5=Direct**, the player-run state.)

**War** (`$9855`) — launch an attack. Heavy pre-roll setup (`$9368`/`$9351`/`$9323`/`$933A`/`$9814` — combat-prep subroutines), then *"Attack where?"*, blocked by *"They are your allies!"*. Prompts: *"How many men"*, *"How much rice will they take"* (supplies — the doughnut-fief attrition mechanic lives downstream of this), *"Will you lead them personally"*. War is the **front end to combat**; the battle resolution itself is elsewhere (a later chapter).

**Hire** (`driver_hire $A5F4`) — recruit, gated by `effect_war_combat_prep_c` (a *"you have no gold"* check — recruiting costs gold). *"Recruit which"* → *"(Men/Ninja)?"* (`prompt_ab_window`) routes to **two different callees**: the *Men* branch is `effect_hire_men $A553` (the recruiting proper); the *Ninja* branch is `effect_ninja_sabotage $A2D2` — i.e. Hire▸Ninja is the front door to the whole sabotage/assassination system (chapters covered in the ninja deep-dive). *(Correction 2026-06-12: chapter's earlier "recruiting logic is `$A2D2`" conflated the Ninja branch with recruiting.)*

**Train** (`$A637`) and **Assign** (`effect_assign $AC11`, driver `$AD67`) — decoded in chapter 10. Train raises skill against a header-derived cap; **Assign is the arms-allocation editor** (distribute a fief's weapon stores across the three arms types), *not* "place a retainer" (corrected in ch.10 / ledger #12).

### Province development

**Dam, Grow, Build** — the prompt-and-apply template from chapter 10. Spend gold, get a √-curve gain in one province field (Dam→output+debt, Grow→output, Build→town), with a silent percentage drain from other fields and a `header`-gated development ceiling.

### Diplomacy

**Pact** (`driver_pact $9C4F` → price `prompt_diplomacy_pact $E3A4`) — buy peace from a rival. **Not free** (ch.11's table previously said "—"): vs an AI house the price = `pct_op(gold,50) + pct_op(gold, rng(0..49)) + 20` ≈ **50–99% of your own treasury + 20**, and the AI only *offers* a pact at `1/skill` odds (refusing the militarily-weak 2/3 of the time, `fief_owner_weakness`). The gold **transfers to the target daimyo** — peace is literally bought. On success `set_pact_relation $DA4F` writes **70** into the **relation matrix** at `$6193` (a 54-stride fief×fief table, `relations_matrix_cell_addr $8C35`). Each attempt costs the player daimyo **−1 Drive**, **−2** if you decline the named price or are refused. The `$879F/$804C` helpers it shares with War/Bribe/View/Ninja are *generic province-target-select* primitives, **not** a "diplomacy subsystem" (over-read corrected in ch.10 / ledger #12).

**Bribe** (`driver_bribe $AAAE` → `effect_bribe $8D4D`) — **gold-for-spy peasant defection**, *not* a develop-√ command (ch.10 / ledger #12). `sqrt(gold)` peasants defect from the target's `output` into your fief's `wealth`. Gated by a **Charisma contest** (`bribe_success_check $8D02`): success iff `your(loyalty+Charisma) > target(loyalty+Charisma) + rng(10)·skill` *and* a coin flip — *"%d peasants have defected"* on success.

**Marry** (`driver_marry $9DC9` → dowry `marriage_pact_handler $E314`) — alliance by marriage, the strongest tie. Available only from your capital (`fief_is_daimyo_capital[src]`). Select a fief; the dowry (vs an AI house) = `pct_op(gold, rng(50..79)) + 200` ≈ **half-to-three-quarters of your treasury + 200**, gated on your gold > 200, offered only at `1/skill` odds. *"Lord %s, %s wants %d gold. Pay"* → the gold transfers to the target and `set_marriage_relation $DA7D` writes **90** into the `$6193` matrix (vs Pact's 70). **Refusal is costly**: your daimyo permanently loses **−1 Drive, −1 Luck, −1 Charisma** (`$9EE8`/`$9EEE`/`$9EF4`). Each attempt also costs **−1 Drive** up front. (Flavor: a rolled bride-portrait, *"Don't you long to hear the pitter-patter…"*.)

### Resource & economy

**Tax** (`$999F`) — set the tax rate. *"Tax is %d\nEnter new tax"* (`$D5E9`), and the peasantry reacts immediately: *"The peasants are protesting!"* or *"The peasants are delighted!"* — the loyalty consequence of taxation, surfaced right in the command. `$82D6` (called twice) applies the result.

**Send** (`$9A62`) — transfer resources between your own provinces. *"Send where?"*, then *"Rice"* (`$D5E9`) and *"Gold"* (`$D5E9`), each capped (*"We're at our limit"*), then *"Is this OK"* → *"The supplies have arrived safely"*. The internal-logistics command — and the reason the turn-order randomization (`$6F0B`) bites: you may want to Send before you attack, but the receiving fief might act first.

**Trade** (`$A1BB`) — deal with a traveling merchant. *"Lord, how may I serve you?"* opens a buy/sell submenu (`$B1A6`); requires a merchant present (*"No merchant in the area"*). Closes with *"Let's do business again"* / *"Bye!"*.

**Give** (`$AA1F`) — chapter 10's immediate-action group; the loyalty/morale charity command, touches the most province fields.

### Information & administration

**View** (`$A6CC`) — inspect a fief. Free for your own; **spying on others costs gold** (*"You have no gold!"* gate) and can fail — *"Our spy was caught"*. A *"(99-view vassals)"* sub-option. View is both the information command and the **espionage** command.

**Map** (`$AF3D`) — render the strategic map. 18 instructions, no prompt, no cost — pure display (`$E5F2`/`$AF10`).

**Rest** (`$ADB8`) — *"Seasons"* (`$D5E9`: how many) → *"It will do you good"*. The lord skips turns to recover (health/age interplay).

**Grant** (`$AF6B`) — set a province's policy "state". *"Which fief"* → *"What are your orders?"* → a submenu (`$B1A6`); *"It's currently a %s state, OK to make it a %s state"*, confirmed with *"Lord, you are truly wise!"*. Already-set states are rejected (*"It's already a %s state"*).

**Other** (`$B243`) — the settings/save menu. *"Change which?"* + the `$B1A6` submenu.

**Pass** (`$B2A6`) — five instructions. Show one message, end the turn.

## The complete action space

| # | command | group | cost / gate | prompts | what it does |
|--:|---|---|---|---|---|
| 1 | Move | military | src has men; dest capacity | dest, #men, lead? | relocate men+arms between own fiefs; **lead? moves the capital** |
| 2 | War | military | not vs. allies | target, #men, #rice, lead? | launch an attack (→ combat) |
| 3 | Tax | economy | — | new rate | set tax rate; peasants react (loyalty) |
| 4 | Send | economy | per-field caps | dest, rice, gold, confirm | transfer resources between own fiefs |
| 5 | Dam | development | gold; `header`≥field | amount | √-raise output (+debt), drain others |
| 6 | Pact | diplomacy | ~50–99% of gold +20 (to target); −1/−2 Drive | which fief | buy peace → relation `$6193` = 70 |
| 7 | Grow | development | gold; `header`≥output | amount | √-raise output, drain dams+loyalty |
| 8 | Marry | diplomacy | from capital; ~50–79% of gold +200 (to target, floor >200); −1 Drive (refusal: −Drive/−Luck/−Cha) | which fief | marriage alliance → relation `$6193` = 90 |
| 9 | Trade | economy | merchant present | buy/sell submenu | trade with a merchant |
| 10 | Hire | military | gold | Men/Ninja | recruit men (`$A553`) or run a ninja mission (`$A2D2`) |
| 11 | Train | military | `header`-derived cap | — | raise skill |
| 12 | View | information | gold (to spy); can fail | which fief | inspect own / spy on others |
| 13 | Build | development | gold; `header`≥town | amount | √-raise town, drain wealth |
| 14 | Give | economy | — | — | charity → loyalty/morale |
| 15 | Bribe | diplomacy | gold; Charisma contest | amount | `sqrt(gold)` peasants defect target.output → your wealth |
| 16 | Assign | military | — | — | arms-allocation editor (distribute weapon stores) |
| 17 | Rest | misc | — | #seasons | lord rests (recover) |
| 18 | Map | information | — | — | show the strategic map |
| 19 | Grant | administration | — | which fief, policy | set a province's policy "state" |
| 20 | Other | misc | — | submenu | settings / save |
| 21 | Pass | misc | — | — | end the turn |

## Reviewing the mechanics

A few things the full picture makes clear:

**Gold is the master resource.** Of the 21 commands, the ones that *cost* anything cost **gold** — Dam, Grow, Build, Bribe, Pact, Marry, Hire (the *"you have no gold"* gate), and the spying mode of View. (Pact and Marry are the cruellest: their price is sized to a *fraction of your current treasury* — so a full war-chest makes peace proportionally expensive — and the gold is handed straight to the rival.) There is no separate "action point" economy; your turn is bounded by your treasury (and by the per-province `header` development ceiling). Tax is the only command that *generates* gold, and it does so against a loyalty cost — the central economic tension of the game is the **tax↔loyalty tradeoff**, and it's surfaced literally ("protesting" / "delighted").

**Development is deliberately lossy.** Dam/Grow/Build don't just add — they add on a √ curve *and* silently subtract a percentage from other fields (chapter 10). Combined with the `header`-gated ceiling, province development is a game of **managed decline**, not free growth. A player optimizing one stat is always paying in another.

**Three of the 21 are pure information** (View, Map) **or pure pacing** (Rest, Pass) — the engine budgets real screen time for *looking* and *waiting*, not just acting. View doubles as espionage, which folds information-gathering into the same risk economy as everything else (it costs gold, the spy can be caught).

**Diplomacy writes a relation matrix, but there is no "diplomacy subsystem" of code.** The earlier read — that Pact/Bribe/Marry "route through a `$E510/$879F/$804C` diplomacy cluster" — was an over-read (ch.10 / ledger #12): `$879F/$804C` are *generic province-target-select* primitives shared by War/View/Ninja too. What diplomacy genuinely shares is **state, not code**: a pairwise **relation matrix at `$6193`** (packed triangular, `max·54+min`). Pact sets a pair to 70, Marry to 90 — and War's *"They are your allies!"* block reads the same table. Diplomacy is a data structure several commands poke, not a dedicated machine.

**One UI substrate underneath all 21.** Every command is built from the same parts: `$804C` (province select), `$D5E9` (number input), `$CEC4` (confirm/yes-no), `$D326`/`$D134` (text / formatted text), `$B1A6` (generic option submenu), `$E80C` (commit & display result). The command drivers are thin orchestration over a fixed widget set — which is exactly why decoding one (Grow) made the other twenty cheap.

## What's open

The **command layer** is now mapped. What remains for the strategic engine:

- **The effect formulas.** Each command's effect handler (Grow's `$87F0` is the only one fully traced) holds the exact numbers — Tax's rate→loyalty curve, War's combat-strength roll, Marry's success probability, Send's caps. These are the per-command deep dives, each now a short walk.
- **The shared subsystems.** `$B1A6` (the submenu used by Trade/Grant/Other), the generic `$879F/$804C` province-target-select primitives (War/Pact/Bribe/View/Ninja), the `$6193` relation matrix, and `$D5E9` (the input primitive with its cap logic) — naming these opens several commands at once.
- **Combat resolution.** War is the front end; the battle itself — on the per-fief tactical maps Chris described (doughnut, chokepoint, the offense/defense leader tradeoff) — is the next major system.
- **The daimyo AI.** The 21 commands are the player's verbs; the AI uses the same verbs. The decision engine that chooses among them is the counterpart to this chapter.

With the command set complete, the project has the player's half of the strategic engine. Combat and AI are the other half — and then the synthesis chapter can draw the dominance-frontier counter-graph the project was built for.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
