---
status: active
created: 2026-05-14
---
# Chapter 12 — The Daimyo AI: A Cascade of Weighted Coin-Flips

> Chapter 11 mapped the 21 commands — the player's verbs. This chapter finds the engine that picks among them for the *other* daimyo. The static walk leads from the AI's effect-call sites up through a six-way command switch, a probabilistic decision primitive, and a decision-flag byte — and the model that emerges is strikingly simple: the daimyo AI is not a planner or a utility-maximiser. It is a **cascade of weighted coin-flips** — `RNG() mod 100` against thresholds computed from game state and tunable constants — accumulating into a flag byte that selects the action. For a 1986 strategy engine running in a bytecode VM, that is exactly the right amount of AI, and it fits the pattern this project keeps finding (Utopia's score-driven rebels, M.U.L.E.'s rubber-banded RNG).

**Links:** [Chapter 11 — The Strategic Engine](./11-strategic-engine-complete.md) · [Chapter 9 — Command System](./09-command-system-and-grow.md) · [Chapter 6 — VM Disassembler](./06-vm-disassembler.md) · [Nobunaga README](./README.md)

> **⚠⚠ Erratum (2026-06-03, post-decompiler — supersedes the analysis below).** The whole pipeline is now decoded against the clean transpiled C and oracle-checked; the canonical writeups are **[How the AI Plays](./ai.html)** (consolidated overview), **[the command-pass deep dive](./turn-loop-command.html)**, and memory `project_nobunaga_ai_command_pass`. Four corrections to this chapter:
> 1. **The `$B94C` switch is `switch(province_ai_state[fief])`, not a computed action-index.** The 0–5 it dispatches on is the **Grant policy** — a *persistent per-fief byte the player sets with the Grant command*, not a cascade result. The six executors are now named: 0 `ai_econ_action_state0 $B875` · 1 `ai_develop_town_handler $B3AA` · 2 `ai_state2_recruit_arm_train $B4D5` · 3 `ai_econ_command_dispatch $B64B` · 4 `ai_develop_dam_and_grow $B42B` · 5 = Direct/interactive menu (`issue_province_command $B79B`). The per-fief driver is `ai_per_fief_command_driver $B89B`.
> 2. **The enemy AI is monomorphic — it never picks a style.** A save-state census (`tools/probe-ai-policy-distribution.py`) shows every AI fief permanently at **state 0 (Home)**; states 1–4 appear only where the *player* granted them. So the six "actions" are a player affordance, and the AI always runs case 0.
> 3. **The "cascade of weighted coin-flips" model is correct — but it lives *inside* state 0, not in the switch.** State 0 → `ai_econ_action_state0` → `ai_econ_command_dispatch` ($B64B), which RNG-gates recruit/arm/train ($B4D5) → else town-develop ($B3AA) + dam/grow ($B42B). **This reconciles the 2026-05-14 erratum below** (it saw $B875/$B64B/$B4D5/$B3AA/$B42B "all in sequence" — that *is* case 0 routing through the dispatcher, not the switch running every stage).
> 4. **War target = the weakest adjacent enemy** (`pick_weakest_men_fief`, ROM-confirmed `tools/probe-ai-war-target.py`), keyed on *provisioned* men, with a real strength gate at commit. And `$B8A0` **does** run during AI turns — it draws "Turn %d Fief %d" (`msg_turn_2d_fief_2d`) and is the per-fief AI driver, contra the note below. The "cascade of coin-flips" headline survives; the addresses/framing below are pre-decompiler and superseded by the pages above.

> **⚠ Erratum (2026-05-14, post-draft).** A Mesen `$EB7A` trace across a turn boundary revealed that this chapter's "pick one of six executors via `$B94C`" framing is one level too high. The trace shows each AI-fief iteration calls `$B875`, `$B64B`, `$B4D5`, `$B3AA`, `$B42B` **all in sequence** (16 hits each over ~16 AI fiefs — they are *stages*, not alternatives). The `$B94C` switch is used *inside* `$B64B` (the develop sub-dispatcher) to pick Dam/Grow/Build, which is consistent with chapter 10. So the per-fief AI is a **multi-stage pipeline**, and each stage's `$CA52` roll gates whether that stage acts. The "cascade of weighted coin-flips" model is *more* right under this correction, not less — the cascade just runs across all stages, every fief. Also: the `$B8A0` "Turn %2d Fief %2d" sub never fires during a normal turn — it is some other (probably combat-announcement) context, not the AI turn handler I called it. The pipeline entry point is reached indirectly and is part of the turn loop in ch 13.

## The AI turn, top to bottom (2026-06-12)

The full walk of one AI fief's turn — decision order, the probability at each gate, and where (if anywhere) the daimyo's own stats tilt the odds. The "cascade of weighted coin-flips" headline **survives intact**; the addresses and framing in the older sections below are superseded by this.

### Entry & the per-fief loop
The turn loop (ch.13) calls `ai_per_fief_command_driver $B89B`, which walks `daimyo_turn_order` (re-shuffled each round) and dispatches each fief on `province_ai_state`. A player's **Direct (5)** fief opens the interactive menu; every **AI (0)** fief runs `ai_econ_action_state0 → ai_econ_command_dispatch $B64B` — **one brain, every AI fief, every turn** (the AI never uses states 1–4; ch.11 / ledger #22).

### The decision order (`ai_econ_command_dispatch`)
```
1. if rice == 0:            rice += rng(10)              ; never let a fief starve to 0
2. if capital & men == 0:   men  = 2                     ; token garrison — never leave the seat naked
3. ~90% (rng(10) ≠ 0):      try the MILITARY branch  →  if it acted, STOP
4. otherwise:               ~90% (rng(10) ≠ 0) DEVELOP TOWN ; then ALWAYS DAM+GROW
```
So the AI is **attack-first, build-second**: ~90% of fiefs look to recruit or make war before anyone develops.

### Branch A — Military (`ai_state2_recruit_arm_train`), in order
1. **War (`ai_try_war_attack`)** — tried first; if a war launches, the branch returns and the fief is done. (Detailed below.)
2. **Recruit** — only if `men < min((year−1559)·40, header)` (a *year-scaled* cap — armies grow over the campaign), and gated by **`rng(10) < const_two + 3`** (recruit chance ≈ `(difficulty+3)/10` — 50% at skill 2, higher at higher difficulty). Spends half the gold surplus.
3. **Feed morale** — convert rice surplus into morale (`morale += send`, rice paid per man).
4. **Buy arms** — if affordable, `arms += 2·N` at the market `arms_buy_price_rate` (and bumps that rate).
5. **Train** — **50% (`rng(2)`)** → `effect_train` (raise skill).
6. **Reinforce** — **1% (`rng(100)==0`)** → a rare arms/econ top-up.

### Branch B — Development (Town, then Dam+Grow)
- **Town** (`ai_develop_town_handler`): seed tax, trade rice↔gold, then **2/3 (`rng(3)≠0`)** build town if `town < header`, sized to a year-scaled cap.
- **Dam + Grow** (`ai_develop_dam_and_grow`): if `loyalty > output` (headroom), spend on Dam (to dams cap) then Grow (year-scaled cap); else just a small grow.

### How the AI sizes its spends — no "how much?" prompt
Every spend reads `ai_calc_men_surplus_over_gold_and_rice`: **`gold_surplus = gold − men`, `rice_surplus = rice − men`** (clamped ≥0). The AI keeps a reserve equal to its **army size** and spends only the surplus — a one-line economic policy, **no daimyo stats involved**. The caps it spends toward scale with the **game year** (`(year−1559)·k`), so AI provinces strengthen as the campaign ages. The AI even **plays the rice market** (`ai_province_gold_to_rice_convert`: a `rng(10..29)` vs `gold_rice_exchange_rate` roll → sell rice when dear, buy when cheap).

### The war decision (`ai_try_war_attack`) — the only place targeting happens
1. **Preconditions:** the fief must not be weak, and must have **both men and rice** — *no supply, no war* (rice = provisions).
2. **Target = the weakest enemy by *provisioned* men** (`pick_weakest_men_fief`; `fief_men_ratio_pct = a_men·100/(a_men+b_men)`, where a fief with **no rice counts as 0 men**). A starved or tiny neighbour is the magnet. An adjacency/men-minority target (`$6E7F`) can override.
3. **Commit gate:** attack only with a men-ratio advantage — `ratio − 10 − rng(const_two·3) > 60` — or a 1/100 "attack anyway". Risk-averse; it picks on the weak.
4. **Resolve:** deduct men/rice → `effect_war_a` → **bank 2 (combat)**. *(The same bank-2 resolver handles uprisings — see the tie-back note below; the battle math itself is the combat chapters, ch.14–17.)*

### Do daimyo stats alter the odds? — **only Drive**
The econ/military cascade is driven by **difficulty (`const_two`)**, the **game year**, the **market rates**, and **province stats** (gold/rice/men/output/loyalty) — *not* the daimyo's personal stats. The single exception is **Drive (record +2)**, the AI's **aggression dial**:
- **`ai_relations_and_low_drive_skip_gate`** — the target selector skips a candidate when relations are good **and** the daimyo's `Drive < 50`. So a **timid (Drive<50) daimyo respects pacts/marriages** (won't attack fiefs it likes), while a **bold (Drive≥50) daimyo ignores relations** and attacks the weakest target regardless.
- **The monk fief (30)** is attacked only by a high-Drive daimyo (`drive < rng(80)+90` → skip) — historical reluctance to assault the warrior-monks.

Everything else — Charisma, IQ, Luck, age, health — is inert on the AI's *decisions*; those stats weigh in **combat resolution** (`$8EB8` compares Drive too), **event eligibility** (Charisma), **illness/death** (age/health), and **assassination** (Luck/Cha/IQ), not in choosing what to do. **So even across wildly different lords the AI plays the same opening; only its aggression (Drive) and its battle strength change.** A synthesis consequence: **a Pact or Marriage only buys deterrence against a *timid* daimyo** — it partially answers the "what does relation buy?" question (ledger #20 Q1): relation gates attacks, but the gate is Drive<50.

### AI-initiated diplomacy events (`random_event_type_dispatch`)
At the tail of the event pass, a separate roll (**50% nothing**, else marry / diplomacy / extra-ravage) has the AI exercise the *player's own verbs* autonomously — `ai_event_marry_random_eligible_fief` proposes a marriage, `ai_scan_idle_fiefs_run_diplomacy_action` runs a Pact. These keep the relations matrix alive between human turns. *(Eligibility/effects: a short follow-up.)*

> **Tie-back for the combat chapters:** both the AI's wars (`effect_war_a`) and the world's uprisings (`spawn_uprising_force_from_province`, the riots/revolts of Appendix D) hand off to the **bank-2 combat resolver** via `call_bank_wrap(2)`. When ch.14–17 open that bank, they should close the loop on: the men-ratio/strength comparison (`$8EB8`, where Drive re-enters), supply/rice exhaustion across battle days, and how an uprising's `spawn_uprising_force` attacker (the fief-50 slot) is resolved against the defender.

## The decompiled model (2026-06-12) — and why the AI is exploitable

Pass 2 walked the AI in the grounded C. The "cascade of weighted coin-flips" headline **survives intact**; the addresses and framing in the older sections below are superseded by this. The confirmed model:

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
- **It never assassinates, bribes, or uses diplomacy strategically.** The ninja/assassination path (ledger #1), the Charisma-contest Bribe (#19), and Pact/Marry (#20) are player verbs the AI's cascade doesn't reach — so the cheapest faction-ending move has *no AI counter*, and the AI never sues for peace to block one.
- **It defends its seat only reflexively** (the `men=2` token garrison) — there is no logic that anticipates a decapitation strike or relocates the capital (the mobile-seat defence, ledger #19) the way a player can.
- **It is subsidized, not skilled.** The difficulty comes from the `const_two` dial (slower player development, bigger AI stat boosts, ledger #11) and the harvest's AI-only `event_boost_province_gold_output` bonus (ledger #24) — the engine props the AI up economically rather than making it play better.

So the README thesis closes here: a high-Luck/Charisma lord who rolls max stats, relocates his seat out of reach, Grants his rear to auto-develop, and assassinates the weakest neighbours faces an opponent that can only do attack-first weighted coin-flips and was never given the verbs to punish any of it.

## The thread: the AI reuses the player's effects

The way in was a search, not a guess. The player's command *drivers* (the `$B9B2` table) have **zero literal callers** — the menu dispatches through the table by indirect call. But the command *effect* handlers do have callers, and they came in pairs: Grow's effect `$87F0` is called from the Grow driver `$9D95` **and** from `$B4C2`; Dam's `$87D8` from its driver **and** from `$B46C`/`$B481`. That second-caller cluster — bank 1 `$B4xx` — is the AI: **it reuses the player's effect handlers but supplies its own arguments**, because it doesn't need the "how much?" prompt — it sizes the spend itself.

From there the static walk climbed:

```
$B42B  AI develop-executor   — builds the $7001 record pointer for $6F5F,
                               reads output/dams/loyalty, sizes a spend,
                               calls the Dam/Grow/Build effect handlers
$B64B  develop sub-dispatcher — picks among $B3AA/$B42B/$B4D5 via $CA52 rolls
$B8A0  AI per-fief turn handler — announces "Turn %2d Fief %2d", runs the
                               decision cascade, dispatches via a switch
$B94C  the AI command switch  — 6 cases -> 6 executor subs
```

## The command switch — `$B94C`

`$B8A0` ends in a `$D5 switch` whose inline table decodes to a clean 6-way dispatch on an **action index** (0–5):

| action | executor | role |
|--:|---|---|
| 0 | `$B875` | executor (military / move — TBD) |
| 1 | `$B3AA` | executor |
| 2 | `$B4D5` | executor |
| 3 | `$B64B` | develop sub-dispatcher → `$B3AA`/`$B42B`/`$B4D5` |
| 4 | `$B42B` | develop executor (Dam/Grow/Build effects) |
| 5 | `$B79B` | executor (diplomacy — TBD) |
| ≥6 | `$B98D` | default — skip |

The six executors are the AI's *verbs*, and they bottom out in the same effect handlers the player's commands use. The open work here is naming `$B875`/`$B3AA`/`$B4D5`/`$B79B` by what they do — but the *shape* (one switch, six executors, shared effects) is settled.

## The decision primitive — `$CA52`

Everything upstream of the switch is built from one tiny subroutine. `$CA52` is ten instructions:

```
CA52(score, divisor):
    if score < 1:  return 0          ; a zero/negative score never fires
    return  RNG() mod divisor        ; RNG via $CA46 -> syscall_dispatch
```

`$CA46` is three instructions — it just fires the RNG syscall (`$F226`). So `$CA52` is a **guarded random roll**: a score gates whether the AI even considers an action, and if it does, the outcome is `RNG() mod divisor` — a number to compare against a threshold. This is the atom of the entire AI.

## The decision cascade — `$B8A0` before the switch

The pre-switch body of `$B8A0` is a sequence of these rolls, and it reads cleanly:

1. **Read state.** `$7FD3` (a game-phase flag), `$6001` (game-state word).
2. **Clear/seed the decision-flag byte `$6DA1`.** `regA AND $FE` clears bit 0; later `regA OR $xx` sets specific bits. `$6DA1` is the AI's working **decision bitmask** for this fief.
3. **Roll, with a state-derived threshold.** A representative gate:
   ```
   regA = word[$6D63] * 5            ; $6D63 = a config constant (= 2)
   regA = 55 - regA                  ; threshold = 55 - 2*5 = 45
   roll = CA52(45, 100)              ; RNG() mod 100
   if roll >= 45:  set a bit in $6DA1
   ```
   The threshold is **computed from game state and a tunable constant** — the AI's aggressiveness/tendency is not hard-coded, it is a parameter (`$6D63`) fed through a formula.
4. **More rolls and predicate checks.** `CA52(4, …)`, plus helpers: `$D982` is a bare predicate (`value < 8`), `$D628` is a scan-with-predicate over a `$6D9D`-bounded range. Each result writes another bit of `$6DA1`.
5. **The accumulated `$6DA1` flags + the state reads resolve to the action index**, and `$B94C` dispatches it.
6. **`$D609`** — *"Hit any key"* — pauses so the human can watch what the AI did.

## The model

Put together, the daimyo AI is:

> **a cascade of weighted coin-flips.** Each potential action is a `RNG() mod 100` roll against a threshold derived from the fief's state and a config constant; the roll outcomes accumulate as bits in a decision byte (`$6DA1`); the byte selects one of six executors; the executor reuses the player's own effect handlers with AI-chosen arguments.

What it is **not** is as informative as what it is. There is no search, no lookahead, no board evaluation, no minimax. The AI does not *plan* — it *reacts*, fief by fief, with biased randomness. The bias is the design: thresholds move with game state (a poor fief rolls differently from a rich one) and with tunable constants (the difficulty/personality knobs).

This is the third time the project has found this shape. Utopia (1981) drove its rebels off score deltas; M.U.L.E. (1983) rubber-banded its event RNG by player rank; Nobunaga (1986) gates its command choice on state-weighted rolls. **Era-appropriate AI is a probability budget, not a planner** — and decoding it means decoding *the thresholds and the constants*, because those, not any algorithm, are where the "intelligence" lives.

## What's open

- **The four un-named executors** — `$B875`, `$B3AA`, `$B4D5`, `$B79B`. `$B42B` (develop) is traced; the others are reached but not walked. Likely move, war, diplomacy, and one more — each a short walk.
- **The threshold formulas** — each `$CA52` site has its own `score` and `divisor` expression. Cataloguing them (and the constants `$6D63`, `$6D9D`, …) *is* cataloguing the AI's personality. This belongs in the effect-formula **appendix**.
- **The turn loop & the economy cycle** — `$B8A0` has no literal callers; it is reached per-daimyo, driven by the `$6F0B` turn-order permutation. The loop that sequences daimyos — and triggers the seasonal harvest/economy update between rounds — is the next structural piece, and the last big one before combat.
- **`$6DA1` bit semantics** — which bit means what. A short focused trace or a few more rolls decoded would finish this.

With the decision engine characterised, the project now has *both* halves of the strategic layer — the player's 21 commands (ch 9–11) and the AI that picks among the same verbs (ch 12). The turn loop stitches them together; combat and the synthesis counter-graph follow.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
