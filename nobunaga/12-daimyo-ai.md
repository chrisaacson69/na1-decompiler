---
status: active
created: 2026-05-14
---
# Chapter 12 — The Daimyo AI: A Cascade of Weighted Coin-Flips

> Chapter 11 mapped the 21 commands — the player's verbs. This chapter finds the engine that picks among them for the *other* daimyo. The static walk leads from the AI's effect-call sites up through a six-way command switch, a probabilistic decision primitive, and a decision-flag byte — and the model that emerges is strikingly simple: the daimyo AI is not a planner or a utility-maximiser. It is a **cascade of weighted coin-flips** — `RNG() mod 100` against thresholds computed from game state and tunable constants — accumulating into a flag byte that selects the action. For a 1986 strategy engine running in a bytecode VM, that is exactly the right amount of AI, and it fits the pattern this project keeps finding (Utopia's score-driven rebels, M.U.L.E.'s rubber-banded RNG).

**Links:** [Chapter 11 — The Strategic Engine](./11-strategic-engine-complete.md) · [Chapter 9 — Command System](./09-command-system-and-grow.md) · [Chapter 6 — VM Disassembler](./06-vm-disassembler.md) · [How the AI Plays](./ai.html) · [Command-pass deep dive](./turn-loop-command.html) · [Nobunaga README](./README.md)

## The AI turn, top to bottom

The full walk of one AI fief's turn — decision order, the probability at each gate, and where (if anywhere) the daimyo's own stats tilt the odds.

### Entry & the per-fief loop
The turn loop (ch.13) calls `ai_per_fief_command_driver $B89B`, which walks `daimyo_turn_order` (re-shuffled each round) and dispatches each fief on `province_ai_state`. A player's **Direct (5)** fief opens the interactive menu; every **AI (0)** fief runs `ai_econ_action_state0 → ai_econ_command_dispatch $B64B` — **one brain, every AI fief, every turn** (the AI never uses states 1–4; ch.11 / ledger #22).

### The action-economy asymmetry — the AI's biggest structural edge
The two per-fief handlers are *not* symmetric, and this matters more than any single decision:
- **Player (`issue_province_command`):** *"Your orders?"* → pick from the menu → the command runs → the loop ends **the moment a command consumes the turn** (returns 1). Free *looks* (View/Map return 0) don't end it, but the player gets **exactly one turn-consuming action per fief, per season** — Grow *or* Hire *or* War *or* Tax, never together.
- **AI (`ai_econ_action_state0`):** runs the **entire `ai_econ_command_dispatch` cascade** — recruit + feed-morale + buy-arms + train + (develop town + dam + grow) + market-trade — **and then** `random_daimyo_stat_increment` **and** a 25% arms bump. That's **six-to-eight sub-actions in a single fief-turn.**

So the AI's recruiting, training, trading, and developing are **all "free"** — bundled into the one turn the player would spend on just one of them. This **action-economy gap is arguably the AI's single biggest advantage**, independent of the stat/harvest subsidies. What keeps it beatable is that each AI sub-action is **small** (capped by the `gold−men` surplus) and **unstrategized** (random tax, never Assign, weakest-target wars): the AI does *everything a little, badly*, while the player does *one thing, optimally*. The whole player skill curve is choosing **which** one move per fief matters most — and, crucially, **using Grant to buy back the AI's throughput** where breadth beats depth (below).

### Grant policies are alternate AI behaviours — the player's throughput lever
The `$B89B` switch dispatches each Grant policy to a **different subset** of the cascade — so a granted fief runs one *focused, multi-action* behaviour per turn:

| state | runs | behaviour per turn |
|---|---|---|
| **0 Home** | `ai_econ_action_state0` | the **full cascade + subsidies** (10% daimyo-stat boost, 25% arms bump, the Spring boon) — the AI default |
| **1 Industrial** | `ai_develop_town_handler` | town-build + market-trade + tax (no army, no war) |
| **2 Military** | `ai_state2_recruit_arm_train` | war + recruit + arm + train (no economy) — *an autonomous aggressor* |
| **3 Balanced** | `ai_econ_command_dispatch` | the full cascade **without** the Home subsidies |
| **4 Farming** | `ai_develop_dam_and_grow` | dam + grow (no army, no town) |
| **5 Direct** | `issue_province_command` | **you**, one manual action |

Two consequences for play:
- **Home (0) is strictly better than Balanced (3)** (cascade + the 10% stat-boost / 25% arms-bonus / Spring boon vs cascade alone) — **but the player can never have a Home fief.** Conquest *inherits the attacker's state*: `apply_conquest_outcome $E194` (and the whole-faction `reassign_fiefs_to_conqueror $DF2B`) both set `ai_state(conquered) = ai_state(attacker) ? 5 : 0`. The player always attacks from a Direct(5) or granted(1–4) fief, so **every player conquest comes out Direct (5)** — you micro it (or Grant it to 1–4). With no Home(0) fief to start from, the player's fiefs are *only ever* 5 or 1–4. **"You conquer the way you fight"** — a hands-on attack yields a hands-on prize. So the AI's whole empire runs the subsidised Home cascade while the **player's empire is all Direct (one action each) or granted (focused, decayed)** — and each conquest *adds another Direct fief to micro*. The action burden grows with the player's success; the AI's shrinks into autopilot. *(This corrects an earlier draft that wrongly said the player could "leave conquered fiefs at Home".)*
- **Grant is the player's *only* throughput lever, and it's for *focus*.** Since you can't reach Home, Grant (states 1–4) is how you stop micro-ing a fief: make a frontier fief **Military** to auto-attack, a rear fief **Farming** to auto-feed — accepting the state-≠0 Spring decay and *no* Home subsidies in exchange for the multi-action focused behaviour (and, for Farming/Industrial, no unwanted wars).
- **The daimyo stat-boost is AI-only.** `random_daimyo_stat_increment` is gated `ai_state==0` with no capital check, so it rolls on *every* Home fief a daimyo holds — a holdings-scaled snowball for a sprawling AI lord, and **never** for the player (whose daimyo's stats stay fixed at the character roll, only drained by marry-refusals and events).

### The decision order (`ai_econ_command_dispatch`)
```
1. if rice == 0:            rice += rng(10)              ; never let a fief starve to 0
2. if capital & men == 0:   men  = 2                     ; token garrison — never leave the seat naked
3. ~90% (rng(10) ≠ 0):      run MILITARY-PREP  →  if it launched a WAR, STOP the turn
4. fall through:            ~90% DEVELOP TOWN ; then ALWAYS DAM+GROW
```
**The military and develop passes are NOT mutually exclusive** — a subtle but important point. `ai_state2_recruit_arm_train` returns 1 *only when it launches a war* (not for recruiting/arming/training), so the `&&` short-circuits and the fief **falls through to develop unless a war actually fired**. Net cadence per fief:
- **~90% of turns:** the military pass runs (recruit / feed / arm / train); if a **war** launches, the turn ends there.
- **On every turn a war did *not* fire** (the large majority — see "why so few wars" below): the develop pass *also* runs.
- **~10% of turns:** the military pass is skipped entirely; develop only.

So a typical AI fief **does a little of everything every turn** — recruit, arm, train, *and* build — not one-or-the-other. The catch is the **ordering**: military spends gold *first*.

### The order of operations, and why the AI under-develops (Chris's #2)
Every spend is sized against `ai_calc_men_surplus_over_gold_and_rice`: **`gold_surplus = gold − men`, `rice_surplus = rice − men`** (clamped ≥0) — the AI keeps a cash/food reserve **equal to its army size** and spends only what's above it. Because the **military pass runs first and eats that surplus** (recruit spends `gold_surplus/2`, then arms), the develop pass that follows gets only the scraps. Combined with the reserve floor, this is a genuine trap: **a fief with a big army has little gold over `men`, so it can barely develop** — military daimyo stay economically stunted, exactly as observed. Develop caps also scale with the **game year** (`(year−1559)·k`), so what little the AI does build trends upward late.

### What an AI fief actually does on a non-war turn — by question
- **Recruit men?** Only when under-strength for the year (`men < min((year−1559)·40, header)`), then with probability **`(const_two+3)/10`** (50% at skill 2, higher at higher difficulty), spending half the gold surplus. New men get random morale/skill/arms (`apply_hire_unit_stats`, the Hire dilution). *Early game the year-cap is tiny, so the AI barely recruits; it builds armies as the campaign ages.*
- **Train (skill)?** A flat **50% (`rng(2)`)** every military-prep turn (`effect_train`), after recruiting. Plus a 1% rare reinforce.
- **Change its tax?** It doesn't *strategize* tax — every develop turn calls `ai_seed_fief_tax_rate`, which **re-randomizes the rate to `rng(30)+35` = 35–64**. Since develop runs most turns, AI tax simply **wanders in the 35–64 band** turn to turn (never the 90s that would trigger its own riots — see Appendix D).
- **Re-mix its army (Assign)?** **Never.** `effect_assign` has exactly one caller — the player's `driver_assign`. The AI sets unit composition *only at hire time* and can't redistribute it. The army-composition lever is **player-only**.
- **Buy / sell rice — and why?** On a develop turn, **75% (`rng(4)≠0`)** it rebalances surplus by price (`ai_province_gold_to_rice_convert`): **sell rice when the market is dear** (`rng(10..29) < exchange_rate`) for gold to develop with; **buy rice when cheap** (`> exchange_rate`) to feed troops. It's converting whichever surplus it's short of — and because the rate is the *global* `$6E0B` table, **the AI's trades move the same market the player trades in** (and the AI selling rice pushes the price down on you).
- **Build / dam / grow?** Town: 2/3 (`rng(3)≠0`) if below the year-cap. Dam+Grow: only if `loyalty > output` (headroom), via the player's `effect_dam`/`effect_grow` (the √-curve + drain — the AI develops on the *same* lossy curve, not a cheat). *(One decompiler ambiguity in the AI grow bookkeeping — an extra `output += spend` alongside `effect_grow` — is flagged for a bytecode check; it doesn't change the cadence.)*

### A quiet rubber-band: AI lords grow their own stats
`random_daimyo_stat_increment` fires for AI fiefs only, **10% per turn**, bumping a random daimyo stat (health/drive/luck/charisma/IQ) by **+2** (wrapping at 200). So an AI daimyo's personal stats *drift upward over the campaign* while the player's are fixed at roll — another anti-player subsidy (with the harvest/Spring boosts, ledger #24).

### The war decision (`ai_try_war_attack`) — the only place targeting happens
1. **Preconditions:** the fief must not be weak, and must have **both men and rice** — *no supply, no war* (rice = provisions).
2. **Target = the weakest enemy by *provisioned* men** (`pick_weakest_men_fief`; `fief_men_ratio_pct = a_men·100/(a_men+b_men)`, where a fief with **no rice counts as 0 men**). A starved or tiny neighbour is the magnet. An adjacency/men-minority target (`$6E7F`) can override.
3. **Commit gate:** attack only with a men-ratio advantage — `ratio − 10 − rng(const_two·3) > 60` — or a 1/100 "attack anyway". Risk-averse; it picks on the weak.
4. **Resolve:** deduct men/rice → `effect_war_a` → **bank 2 (combat)**. *(The same bank-2 resolver handles uprisings — see the tie-back note below; the battle math itself is the combat chapters, ch.14–17.)*

**Why so few wars fire despite the ~90% military pass (Chris's #1):** entering the military pass is *not* attacking. A war only launches when **all** of these line up: the fief isn't weak, it has men *and* rice, a neighbour is genuinely weaker (the **men-ratio advantage** gate, `ratio−10−rng(skill·3) > 60`), and — for a liked target — the daimyo is bold enough (Drive≥50) to ignore relations. Most fiefs, most turns, have no neighbour soft enough to clear the ratio gate, so they fall through to recruit/develop instead. There is **no per-year attack counter**; the limiter is purely *opportunity*. The flip side is what you observed: **once a fief becomes weak (especially starved — no rice ⇒ 0 provisioned men), it is reliably attacked** — every adjacent stronger daimyo's ratio gate now passes, so it gets piled on. Weakness, not a timer, is what summons the wars.

### Do daimyo stats alter the odds? — **only Drive**
The econ/military cascade is driven by **difficulty (`const_two`)**, the **game year**, the **market rates**, and **province stats** (gold/rice/men/output/loyalty) — *not* the daimyo's personal stats. The single exception is **Drive (record +2)**, the AI's **aggression dial**:
- **`ai_relations_and_low_drive_skip_gate`** — the target selector skips a candidate when relations are good **and** the daimyo's `Drive < 50`. So a **timid (Drive<50) daimyo respects pacts/marriages** (won't attack fiefs it likes), while a **bold (Drive≥50) daimyo ignores relations** and attacks the weakest target regardless.
- **The monk fief (30)** is attacked only by a high-Drive daimyo (`drive < rng(80)+90` → skip) — historical reluctance to assault the warrior-monks.

Everything else — Charisma, IQ, Luck, age, health — is inert on the AI's *decisions*; those stats weigh in **combat resolution** (`$8EB8` compares Drive too), **event eligibility** (Charisma), **illness/death** (age/health), and **assassination** (Luck/Cha/IQ), not in choosing what to do. **So even across wildly different lords the AI plays the same opening; only its aggression (Drive) and its battle strength change.** A synthesis consequence: **a Pact or Marriage only buys deterrence against a *timid* daimyo** — it partially answers the "what does relation buy?" question (ledger #20 Q1): relation gates attacks, but the gate is Drive<50.

### AI-initiated events vs the human (`random_event_type_dispatch`)
At the tail of the event pass, a separate roll fires one of the AI's "random events" — the **only** place the AI reaches for the player's diplomacy/ninja verbs. `random_event_type_dispatch $9C84` rolls **50% nothing**, else `rng(4)`: a marriage proposal (`ai_event_marry_random_eligible_fief`), a Pact (`ai_scan_idle_fiefs_run_diplomacy_action`), or — cases 2–3, the most likely outcome when it acts — the **ninja sweep** (`random_ravage_sweep_bounded_fiefs $9C22`). All three aim at the **human**: each opens by pointing `selected_province_idx` at a **Direct (state-5) = human** fief via `flag_turn_abort_if_no_state5_province` (which aborts the whole event if no human fief exists).

The ninja sweep is the **"Someone has sent ninja against you"** attack. It picks up to `(8 − ai_player_count)` **AI (state-0) fiefs as the senders** (15% each) and has each ravage the human fief via `ravage_defending_province_sweep $93BF`: one economic field falls — loyalty / morale / wealth / town / output / rice (the sending AI fief even pockets the looted output as arms/wealth). **It is pure economic harassment, never an assassination.** The real assassination resolver — `ninja_mission_resolve_vs_defender $918D`, the capital-only Charisma+IQ attrition-to-death of ledger #1 — has exactly one caller, the *player's* `effect_ninja_sabotage`, and is **unreachable from the AI**. The sweep's only brush with the lord is a rare fallback (all six ravages whiff → 50% → the fief's `$700B` field already at 0) that chips the target daimyo's Charisma and Health by `rng(0–4)` — incidental attrition, not a kill mechanic. So the AI can wreck your economy on a roll but has **no move that threatens your daimyo's life** — the very asymmetry the dominance thesis turns on. And it fires rarely: it's the fallback arm of one seasonal event slot, which is why it shows up "every so often, out of nowhere."

> **Tie-back for the combat chapters:** both the AI's wars (`effect_war_a`) and the world's uprisings (`spawn_uprising_force_from_province`, the riots/revolts of Appendix D) hand off to the **bank-2 combat resolver** via `call_bank_wrap(2)`. When ch.14–17 open that bank, they should close the loop on: the men-ratio/strength comparison (`$8EB8`, where Drive re-enters), supply/rice exhaustion across battle days, and how an uprising's `spawn_uprising_force` attacker (the fief-50 slot) is resolved against the defender.

## The decompiled model (2026-06-12) — and why the AI is exploitable

Pass 2 walked the AI in the grounded C. The confirmed model:

**The AI is monomorphic.** Every AI fief sits permanently at `province_ai_state == 0` (Home) — the six-way `$B94C` switch is the *player's* Grant policy, not an AI choice (ch.11 / ledger #22; census `probe-ai-policy-distribution.py`). So the AI always runs case 0 → `ai_econ_action_state0 $B875` → **`ai_econ_command_dispatch $B64B`**, the single brain it uses for every fief, every turn.

**The brain (`ai_econ_command_dispatch`) is a short, military-biased cascade of `rng(10)` gates:**
```
if rice == 0:                 rice += rng(10)              ; never starve
if capital & no garrison:     men = 2                      ; never leave the seat undefended
if rng(10) and ai_state2_recruit_arm_train():  return      ; ~90%: recruit / arm / train — and TRY A WAR first
else:                                                       ; the develop fallback
    if rng(10):  ai_develop_town_handler()                 ; ~90%: grow the town
    ai_develop_dam_and_grow()                               ; always: dam + grow
```
`ai_state2_recruit_arm_train` opens with `ai_try_war_attack`, so the AI is **attack-first**: ~90% of fiefs each turn look for a war before falling back to building. Its **war target is the weakest adjacent enemy** (`pick_weakest_men_fief`, keyed on *provisioned* men), taken only past a strength gate at commit — emergent weakest-neighbour aggression, no board evaluation. The thresholds scale with the `const_two`/skill difficulty dial; the "intelligence" is entirely in those constants, exactly as the model below argues.

**The AI is structurally exploitable — the dominance thesis's other half.** The asymmetries are all in the engine, not in any one weak heuristic:
- **It never specializes.** The Grant policies (Industrial/Military/Farming/Balanced) that let the *player* automate an empire are never used by the AI — it runs the one generic loop on every fief (ledger #22).
- **Its command cascade never bribes, assassinates, or plays diplomacy.** Those verbs surface *only* on the rare random-event path above — a ninja economic ravage, a Pact, or a marriage proposal aimed at the human — never the Charisma-contest Bribe (#19) and **never an assassination** (`$918D`, ledger #1, is unreachable from the AI). So the cheapest faction-ending move — killing a lord — has *no AI counter*, and the AI never sues for peace to block one.
- **It defends its seat only reflexively** (the `men=2` token garrison) — there is no logic that anticipates a decapitation strike or relocates the capital (the mobile-seat defence, ledger #19) the way a player can.
- **It is subsidized, not skilled.** The difficulty comes from the `const_two` dial (slower player development, bigger AI stat boosts, ledger #11) and the harvest's AI-only `event_boost_province_gold_output` bonus (ledger #24) — the engine props the AI up economically rather than making it play better.

So the README thesis closes here: a high-Luck/Charisma lord who rolls max stats, relocates his seat out of reach, Grants his rear to auto-develop, and assassinates the weakest neighbours faces an opponent that can only do attack-first weighted coin-flips and was never given the verbs to punish any of it.

## The decision primitive — `$CA52`

Every gate in the cascade is built from one tiny subroutine. `$CA52` is ten instructions:

```
CA52(score, divisor):
    if score < 1:  return 0          ; a zero/negative score never fires
    return  RNG() mod divisor        ; RNG via $CA46 -> syscall_dispatch
```

`$CA46` is three instructions — it just fires the RNG syscall (`$F226`). So `$CA52` is a **guarded random roll**: a score gates whether the AI even considers an action, and if it does, the outcome is `RNG() mod divisor` — a number to compare against a threshold. This is the atom of the entire AI.

## The model

> **A cascade of weighted coin-flips.** Each potential action is an `RNG() mod N` roll against a threshold derived from the fief's state and a config constant; the outcomes accumulate in a decision byte (`$6DA1 = ai_turn_flags`) and route the branches of `ai_econ_command_dispatch`; each branch reuses the player's own effect handlers with AI-chosen arguments.

There is no search, no lookahead, no board evaluation, no minimax. The AI does not *plan* — it *reacts*, fief by fief, with biased randomness. The bias is the design: thresholds move with game state (a poor fief rolls differently from a rich one) and with tunable constants (the difficulty/personality knobs).

This is the third time the project has found this shape. Utopia (1981) drove its rebels off score deltas; M.U.L.E. (1983) rubber-banded its event RNG by player rank; Nobunaga (1986) gates its command choice on state-weighted rolls. **Era-appropriate AI is a probability budget, not a planner** — and decoding it means decoding *the thresholds and the constants*, because those, not any algorithm, are where the "intelligence" lives.

## What's open

- **The threshold catalogue** — each `$CA52` site has its own `score`/`divisor`, and the constants behind them (`$6D63 const_two`, the `$6D9D` year/fief bound, the market rates) *are* the AI's personality. Cataloguing them belongs in the effect-formula **appendix**.
- **`$6DA1` (`ai_turn_flags`) bit semantics** — the pre-switch rolls in `ai_per_fief_command_driver` set bits 0/7/… of this byte; which accumulated bit gates which branch is the one piece still un-walked. A short focused trace finishes it.

With the decision engine characterised, the project has *both* halves of the strategic layer — the player's 21 commands (ch 9–11) and the AI that picks among the same verbs (ch 12). The turn loop (ch 13) stitches them together; combat and the synthesis counter-graph follow.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
