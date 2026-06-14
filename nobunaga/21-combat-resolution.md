---
status: active
created: 2026-06-13
---
# Chapter 21 — Combat Resolution: How a Battle Ends and Who Inherits

> Chapter 14 mapped the day loop and named the four ways a battle ends; chapter 17 decoded the per-exchange damage. This chapter walks what happens **after** the last blow: the resolution dispatch, the daimyo-death/succession path, the conquest cleanup (where the surviving men, rice, and gold go), and the separate **off-screen** resolver that decides AI-vs-AI wars you don't watch. It's the seam between the tactical layer (bank 2) and the strategic map (bank 0) — and it's where conquest, faction collapse, and the assassination-keystone all cash out.

**Links:** [Chapter 14 — Combat Overview](./14-combat-overview.md) · [Chapter 17 — Damage Formula](./17-damage-formula.md) · [Chapter 12 — Daimyo AI](./12-daimyo-ai.md) · [Nobunaga README](./README.md)

## How a battle ends — the resolution codes

The day loop (`battle_init_driver $AFE1`) exits to **`dispatch_battle_resolution $AF3B`** with a code:

| Code | Trigger | Message |
|---|---|---|
| **3** | 30-day timeout (attacker/`selected` set as winner) | — |
| **4** | a side's strength hit 0 (annihilation) | `"you have no soldiers!"` `$B8BB` |
| **5/6** | commander killed (unit 0 gone, `check_commander_alive_both_sides`) | `"this is truly unfortunate…"` `$B7B1` |
| **7/8** | the defended fief had no rice / no men (undefended → instant) | `"you have no rice!"` `$B8A9` |
| — | voluntary **Flee** (verb 3) | `"%s has retreated"` `$B96E` |
| — | morale/exhaustion rout | `"your men are exhausted!"` `$B7F3` |

`dispatch_battle_resolution` first nudges code 5→6 if the "winner" actually has no units left, announces the outcome for both provinces, then runs the two aftermath steps below. (If this is an **AI battle the player didn't watch**, it takes an abbreviated branch — palette + a single redraw — having already resolved off-screen; see the last section.)

## Aftermath, step 1 — succession & daimyo death (`transfer_owned_fiefs_and_announce_succession $AE2C`)

If a **capital** fell, the loser's lord dies:

- **`announce_daimyo_death`** fires (when the fallen province isn't the sentinel 50).
- The fallen daimyo's **entire holdings** are enumerated and announced fief-by-fief — *"fief NN has passed from lord X to lord Y."* Losing your capital loses your **whole faction**, not just the one fief.
- If the eliminated lord was AI-run, **`increment_ai_player_count`** tracks the elimination (toward the victory/defeat check).

This is the mechanical reason the **assassination keystone** (chapter on Ninja) is so dominant: kill the daimyo in their *capital* and `find_fiefs_of_owner` collapses the faction with no battle at all — the same collapse this path produces, bought for a Ninja mission instead of an army.

## Aftermath, step 2 — conquest cleanup (`apply_conquest_outcome $E03C`)

Both the tactical and off-screen resolvers finish here. For a normal single-fief conquest:

- **Survivors of BOTH sides SUM into the conquered fief** — `gold = attacker+defender`, `rice = attacker+defender`, `men = attacker+defender` (province record `+0/+6/+16`). Your victorious army **garrisons the captured fief and stays there**: winning **moves your force forward**, it does not march home. (A real strategic cost — every conquest leaves your front-line fief manned and your rear thinner.)
- **`transfer_force_triplet $DF73`** — the conquered fief's morale/skill/arms become a **men-weighted blend** of the two armies (`scaled_force_transfer`).
- **`cap_arms_at_index $DFFE`** — rifles are re-clamped to the new arms level (**rifle cap = `arms/50 + 20`**; excess rifles spill to another unit type).
- **`daimyo_stat_transfer $DF3D` — battles permanently shift daimyo stats:** the **winner's** lord gains **+1 Drive / +1 Charisma / +1 IQ** (record `+2/+4/+5`); the **loser's** loses one of each. Winners snowball; losers decay — a feedback loop independent of the AI-only random stat bumps.
- **Ownership / state inheritance:** the conquered fief's owner becomes the attacker and its state inherits the attacker's — `ai_state(conquered) = ai_state(attacker) ? 5 : 0`. The player always attacks from a Direct(5) or granted(1–4) fief, so **every player conquest comes out Direct(5)** (chapter 12's action-economy consequence). If the **capital** fell, **`reassign_fiefs_to_conqueror $DEC1`** transfers *all* the loser's fiefs at once.
- **Extras:** conquered-daimyo tax rates are capped at 30 (`clamp_field_6d2d_to_30`); both fiefs' stats are clamped (`cap_fief_stats`); an **uprising** (`selected_province_idx == 50`) deposits nothing and docks the fief **10–20% loyalty** (`pct_op(loy, rng(10)+10)`).

`end_war_relocate_capital $8F55` (used by Flee and by capital captures) simply flips the `fief_is_daimyo_capital` flag from the old seat to the new — the mobile-seat mechanic.

## The off-screen resolver — a different, simpler battle (`resolve_siege_assault_outcome $8DFD`)

An **AI-vs-AI** battle (an AI invasion or an uprising) is gated in bank 1 at **`$9130`**:

```
if (ui_confirm_flag_6e7d || ai_state(defender) == 5)   # "Watch Battles" ON, or you're the defender
    -> run the full tactical engine (bank 2)            # chapters 14-17
else
    -> resolve_siege_assault_outcome  (bank 1)          # one-shot, no day loop
```

The off-screen formula is **not** the tactical engine. It's a single comparison:

```
strength = men·(2 + [+1 if attacker | +1 if defender-on-castle]) + arms + skill + morale
         + 10% morale to whichever daimyo has higher DRIVE
higher strength wins
```

Among the five daimyo stats, **only Drive** matters off-screen (vs all eight in the tactical engine). The loser's survivors split (winner absorbs half), a capital capture rolls a **Drive-based escape** (the daimyo flees to another fief or dies), and then it calls the **same `apply_conquest_outcome`** cleanup above. So the *aftermath* is identical; only the *fight* differs.

**Consequence:** the "Watch Battles" option is **not cosmetic** — turning it on routes AI wars through the rich tactical sim (men + terrain + all 8 stats), off through this men-dominated abstraction. The same matchup can resolve to a different winner, so a display setting can change how the strategic map evolves.

## Why resolution is a dominance hinge

- **The capital is the keystone.** A single capital loss collapses an entire faction (this chapter's succession path) — which is exactly what the Ninja assassination buys without a battle. Defending the capital, and targeting the enemy's, dominates.
- **Conquest is positional and costly.** Winning relocates your army forward and leaves it as the new garrison; the action-economy burden (chapter 12) grows with every Direct fief you add.
- **Winners snowball.** +1 Drive/Cha/IQ per win compounds a strong daimyo's edge battle over battle.
- **The clock and the doughnut.** Codes 3/7/8 (timeout, no-rice, no-men) are the supply-exhaustion endings — a defender who runs the 30-day clock or starves the attacker wins without fighting (chapter 17's rice analysis).

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
