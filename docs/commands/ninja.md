# Ninja (Hire ▸ Ninja) — sabotage subsystem

> Rich walkthrough: **[ninja.html](./ninja.html)**. This file is the bytecode-shape + mechanics companion.
> Full assassination resolution + the dominance framing live in [synthesis-frontier.md](../synthesis-frontier.md) §ledger #1.

Reached from **Hire** (`driver_hire $A5F4`) via the `(Men/Ninja)?` prompt → **Ninja** = `effect_ninja_sabotage` (`$A2D2`, was mislabeled `effect_hire`). Recruit-men is the sibling `effect_hire_men $A553`.

## Flow (from `$A2D2` bytecode)
1. `"How many"` — gold-gated hire; `unit_count = number_input(1, max_affordable)`, where `max_affordable = ratio_times10_capped(gold, hire_gold_rate, header)`. `hire_gold_rate $6E13` = `(rng_mod(101) + (year−1560)·10 + 4) / 4`, rolled once a year (`roll_period_market_rates` $92A5) and nudged by each mission (`cycle_economy_rate(5)`). *(Corrected 2026-11-13, ledger #50: this page had the men price, `gold_men_hire_rate = pct_op(year_scaled, 70)`, and said it re-rolls every turn.)*
2. `"Send where?"` — target fief (`$A31B`).
3. `"What mission"` → menu `$BD8F` `"1-Uprisng 2-Revolt 3-Dams 4-Assassin 5-Arson"`.
4. **Assassination pre-gate** (`$A349`, mission 4 only): the target fief must be the **daimyo's capital** (`fief_is_daimyo_capital`); otherwise `"The daimyo is out."` and the command aborts (no charge).
5. `trigger_cutscene(CUTSCENE_NINJA_ASSASSIN)` — mission-launch animation (`$A36D`).
6. **Luck attempt-gate** (`$A36C`, ALL five missions): proceeds only if `target_daimyo.Luck < attacker_daimyo.Luck + 30` (record **+3 = Luck**; the `+30` is the attacker's edge). Fail → `"Your ninja failed!"`, **gold spent anyway, and your daimyo loses 1 Charisma** (`effect_ninja_failed $A29B`: `deduct_byte_at(charisma, 1)`). The gate has no roll, so against a lord with Luck ≥ yours + 30 every attempt fails.
7. `switch` at `$A39A` → per-mission effect.

## The five missions (switch `$A39A`)
| # | Mission | Target drains | Anim | Code |
|---|---|---|---|---|
| 1 | Uprising | loyalty + wealth | 28 | `$A3AB` |
| 2 | Revolt | morale | 27 | `$A45A` |
| 3 | Dams | dams + rice | 30 | `$A497` |
| 4 | Assassin | kills the daimyo outright on a landed, un-countered hit (#55) via `ninja_mission_resolve_vs_defender $918D` — see below | 1 | `$A508` |
| 5 | Arson | town | 29 | `$A510` |

Each non-assassination mission short-circuits to `"Your ninja failed!"` if its target field(s) are already 0; a non-zero drain is clamped to the field (`drain = min(drain, field)`).

## Drain magnitude — `hire_stat_drain_rng $A255` (C + bytecode CONFIRMED 2026-06-11)
```
drain = (rng_mod( max(1, ⌊ field × √(unit_count) ÷ 100 ⌋) ) + 1) × 5     # then clamped to field
```
A multiple of 5, scaling with **the target field's current value** and **√(unit_count)** — `arg1 = field`, `arg2 = unit_count` (`$A25B PUSH_quick 13` → `sqrt_int(arg2)`; `$A261 PUSH_quick 12` → `pct_op(arg1, …)`). Result text: `"Fief %d's %s has declined by %d"` (`report_fief_stat_decline $A274`).

> ⚠️ **Correction 2026-06-11:** earlier this page wrote the √ over `your_skill+30` — wrong. The √ is over **`unit_count`** (the ninjas you hired); the `+30` belongs to the separate **Luck** attempt-gate (step 6), not the drain. The prior `probe-espionage.py` confirmation validated the drain *shape* (`{5,10,…}`), not the mislabeled argument.

## Economics — denial, with √-diminishing returns
- **Cost ∝ `unit_count`** (linear): `gold -= math32_muladddiv(hire_gold_rate, unit_count) ≈ rate·units/10`.
- **Drain ∝ `√(unit_count)`** (and ∝ the field's magnitude): doubling ninjas doubles the cost but multiplies the expected drain by only ~1.41. **Small batches are the most gold-efficient per ninja; large batches waste gold.**
- The drain is **pure denial** — you gain nothing material; the rival loses the stat. So the four sabotage missions are **pre-war softening tools**, each pulling a different strategic lever:
  - **Uprising** (loyalty+wealth) — destabilises a fief + erodes its economic base.
  - **Revolt** (morale) — morale feeds combat strength and troop cohesion; deep enough drains pressure desertion.
  - **Dams** (dams+rice) — sabotages flood control and **food**; rice supply drives the combat day-loop → starvation pressure.
  - **Arson** (town) — cuts the commercial/tax base.
- Most effective against **already-high** fields (drain ∝ field) and best deployed in **small doses before a war**, not as a standalone economy play.

## Priced (ledger #50, 2026-11-13)
Only Revolt changes outcomes (through the morale-45 cliff), and only at 25-100 ninjas every season: about 33-130 gold a season in 1560 and every command, for a 27-62% chance over six years of toppling a strong lord by revolt, without gaining the fief. Uprising, Dams and Arson cut their fields and change nothing. Not part of the player. Full table in [synthesis-frontier.md](../synthesis-frontier.md) §ledger #50.

## Priced (ledger #55, 2026-11-13)
Three fixed gates (capital, Luck < yours + 30, their Cha+IQ ≤ yours) and one Charisma roll, `rng(10·skill)` each side; one ninja, 1-2 gold, one command. AI lords carry the ROM stats + 5·skill. A perfect roll (109/109) certainly kills 12 of 16 lords at skill 1 and 6 at skill 3; Uesugi, Tokugawa and Takeda are beyond any roll. Table and cartridge checks: [synthesis-frontier.md](../synthesis-frontier.md) §ledger #55; calculator `py -3.14 -m na1sim.assassin`.

## Assassination (mission 4) — summary
`ninja_mission_resolve_vs_defender $918D`. Capital-only (step 4). Resolution is a **Charisma+IQ** contest (`attacker(Cha+IQ) ≥ target(Cha+IQ)`), with a Charisma **counterattack** that can repel the ninja and **damage the attacker's own daimyo**. **A landed, un-countered hit kills at once** (`$9293` is `230 > health`; checked in the cartridge, #55). The `rng(1 … health/(1+counter))` deduction only matters on a counter, where it hits *your* lord. (The earlier "≈2 hits, attrition" read was wrong.) If the dead daimyo's fief was a capital, `find_fiefs_of_owner` **neutralizes every fief they owned** (faction collapse). **Garrison does not protect** — a target with men > ~`rng(1-10)` skips the only defensive roll (`$9213`). The empty-fief roll never blocks either (needs Luck ≥ 200), so one ninja is enough. Cost is paid win or lose. Full trace + the TAS/RNG framing: [synthesis-frontier.md](../synthesis-frontier.md) §ledger #1.

## Resolved (was "Open")
- **Assassination gate = the capital** (`fief_is_daimyo_capital`), not a generic "`$6DA2` present" check.
- **"Tokugawa's mystery health loss"** is the counterattack: a high-Charisma defender repels the ninja, the role flips at `$91FB`, and the **attacker's** daimyo health/charisma takes the hit — i.e. *your* assassins can get your own lord hurt.

## Test log
_TBD — needs an in-game PRE/POST capture per mission (snap protocol in [README](./README.md)). The drain formula's emulator confirmation (probe-espionage.py, retired; [tools/RETIRED.md](../../tools/RETIRED.md)) stands; an in-game capture per mission would close the loop._
