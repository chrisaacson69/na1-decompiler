---
status: active
created: 2026-06-12
---
# Appendix D — The Event System (season · trigger · result)

The strategic loop (ch.13) does more than hand turns around: between rounds it ages daimyo, runs the
harvest, and fires **events** — random disasters, peasant riots, military revolts, illnesses, deaths, and
AI-initiated diplomacy. This appendix catalogues every event found in the **bank-0** turn loop, with its
**season**, **trigger**, and **result**, walked from the grounded C (`source/4-c/bank_00.c`).

> **Confidence:** mechanics below are read from the decompiled C; the per-stat field offsets follow the
> `$7001` province-record map (gold +0, debt +2, town +4, rice +6, output +8, dams +10, loyalty +12,
> wealth +14, men +16, morale +18, skill +20, arms +22, header +24) and the 7-byte daimyo record
> (age +0, health +1, drive +2, luck +3, charisma +4, iq +5). Items marked **⚠verify** lean on murky
> decompiler pointer arithmetic and want a bytecode pass.

## How an event is chosen each season (`ai_strategic_turn_planner $A455`)

One random event is selected per season:
- **Season 1 (Summer) + 50% (`rng(2)`)** → the **Flood/Disaster**.
- Otherwise: **25% (`!rng(4)`)** → **Ravage**; **75%** → the **Uprising dispatcher** (Riot or Revolt).

Then each owned fief is rolled for inclusion (`rng(40) < 3` ≈ 7.5%, or `roll_3pct_event_chance` for the
uprising branch) into a candidate list at `$7BAD`; if any qualify, `announce_seasonal_event` fires and the
selected handler runs over the list.

**Eligibility primitive `square_over_2025_probability_roll(x) = min(x,50)² < rng(2025)`** — fires when a
stat is **low** (2025 = 45², so a stat ≥45 almost never qualifies). This is how "bad" events home in on
weak fiefs.

## The seasonal maintenance cadence (not random — `per_period_fief_daimyo_update_driver`)

| season | task | effect |
|---|---|---|
| 0 Spring | **Aging** (`per_turn_age...`) | every daimyo **age +1, health −1** (per year); relations decay; AI-fief **boon** + player-fief **decay** (below) |
| 1 Summer | highwater marks | records each province's peak stats |
| 2 Fall | **Harvest** (`harvest_income_sweep_all_fiefs`) | per fief (if loyalty>0): gold/rice income (appendix A §4); **debt auto-repays from gold**; **army upkeep** consumed; AI fiefs get a bonus `event_boost_province_gold_output` |
| 3 Winter | **Relations decay** | `normalize_relations_matrix_lower` bleeds every `$6193` relation toward 0 (so a Pact's 70 / Marriage's 90 erodes ~once a year) |

Every season also runs, per fief: **`drift_daimyo_luck`** and a **natural-death check**.

### The Spring AI-boon / player-decay (the rubber-band) — ⚠verify
In the Spring aging pass, fiefs split by `province_ai_state`:
- **state 0 (Home = AI-run)** → `event_boost_province_wealth_loyalty`: 50% chance, **wealth += rng(10)+Cha/10, loyalty += rng(40)+Cha/10**. The AI economy is handed free loyalty and wealth.
- **state ≠ 0 (the player's Direct capital + any Granted fiefs)** → at difficulty `const_two > 1`, **three stats (wealth/men/skill) each drain by `rng(const_two)`** per year. ⚠the exact three offsets want bytecode confirmation.

This is a structural anti-player bias (extends the `const_two` difficulty-dial, appendix A / ledger #11):
the AI is *subsidized*, the player is *taxed*, scaled by difficulty — and note **Granting a fief away from
Home (0) exposes it to the decay**, a hidden cost of delegation.

## Random events

### Flood / Disaster — `decay_fief_list_wealth_and_output_disaster1` (CUTSCENE_DISASTER)
- **Season/trigger:** Summer (season 1), 50%, over the eligible-fief list.
- **Result, per fief:** `wealth −= rng(4)+1`; **`output ×= (0.9·dams)%`** — i.e. output is scaled by ninety-percent-of-dams. **Dams are flood insurance:** at dams 100 you keep ~90% of output; at low/zero dams the flood **wipes output**. The clearest mechanical reason to build Dams beyond their rice-yield role.

### Ravage (raid/plague) — `random_event_ravage_output_hidden_mark_weakness` (CUTSCENE_RAVAGE)
- **Trigger:** 25% of non-disaster seasons, over the eligible list.
- **Result, per fief:** **`men ×= (50–99)%`** and **`output ×= (50–99)%`** (lose up to half of each). **At a capital fief**, the owning daimyo also takes **`health −= rng(9)+1`**, and is flagged weak if health ≤ 50. So Ravage is the one random event that can directly hurt a daimyo's life pool.

### Uprisings — Riot & Revolt (`ai_event_build_two_batches_dispatch_or_announce`)
The 75% branch. It builds a candidate list under one of two eligibility variants and announces accordingly:

| | **RIOT** | **REVOLT** |
|---|---|---|
| eligibility | **loyalty variant** (`...loyalty_variant`): low **loyalty (+12)**, **high tax** (`100−tax` low), low **Charisma**; needs men>2 & output>0 | **morale variant** (`...morale_variant`): low **morale (+18)** (the army stat), low Charisma; needs men>2 |
| message | *"Riot!"* → *"The people are rebelling!"* | *"Revolt!"* |
| handler | `collect_high_loyalty_provinces_to_candidate_list` — for a player fief, prompts to **quell** (spend to appease, `record_apply_two_grows`) | `revolt_spread_sweep_flip_fief_ownership` — **flips fief ownership**; for an AI fief a `province_conquest_roll` runs and, **if the rebels win at a capital → `announce_daimyo_death` + `find_fiefs_of_owner` = faction collapse** (same elimination path as assassination) |
| character | peasant unrest (loyalty) — the **softer** event, recoverable | military mutiny (morale) — the **harder** event; can destroy an AI faction |

- **Flavor is cosmetic, keyed by fief index** (`select_message_string_by_flags_and_arg`): **fiefs 7 / 23 → "zealots"**, **fiefs 13 / 30 → "monks"** (the historical Ikkō-ikki / warrior-monk provinces), else "rebels" / "rioters". A "religious zealot uprising" is just a revolt in fief 7 or 23 — **same mechanic, different name**.
- **The uprising army:** a staged uprising spawns an attacking force from the fief-50 "uprising" slot and hands off to **bank 2 (combat)**. The spawner `spawn_zealot_uprising_force_from_province` is **mislabeled** — it serves rebels/zealots/monks alike; read it as `spawn_uprising_force_from_province` (it takes an `is_uprising` flag and sets `ai_turn_flags` bit 64/32). It seeds the attacker's men/rice from the source fief's stats (`pct_op` of each field), gold 0.

### Synthesis — the tax ceiling (why ~55 is the cap)
The uprising eligibility ties tax directly to revolt risk, and revolt is **non-marginal**:
- The **per-season loyalty decay** fires at **high tax** (`tax ≥ 90 − const_two`; ledger #24), bleeding 10%
  loyalty each season.
- The **Riot eligibility** rolls `square_over_2025_probability_roll(100 − tax)` — **higher tax → lower
  `100−tax` → more likely eligible** for a peasant riot.
- And the **harvest is gated on `loyalty > 0`** (ch.13) — a fief pushed into full revolt earns **nothing**
  that year. The expected loss from triggering a revolt (a whole harvest, plus the combat risk) swamps the
  marginal extra income a higher rate buys.
- **Playtested result (Chris, 2026-06-12):** the practical optimum sits around **tax 55** — past it the
  rising revolt chance outweighs the marginal gain — and at tax 55 you stay under the loyalty-decay
  threshold as long as your difficulty constant is low (`55 < 90 − const_two`, always true for `const_two`
  1–5). *(Quantifying the exact EV-optimal rate vs. the riot-probability curve is a clean emulator follow-up;
  the cross-stat oddity — tax/loyalty are peasant-side while the morale-variant keys on the army stat — is
  noted in the uprising table above.)*

## Personal (daimyo) events

| event | season | trigger | result |
|---|---|---|---|
| **Aging** | Spring (yearly) | automatic | age +1, health −1 for every daimyo |
| **Illness** | every season | low-health daimyo: `rng(400) < 100 − health` | flagged weak; if it's the player's seat, *"&lt;Lord&gt; has taken ill."* |
| **Natural death** | every season | `check_and_process_daimyo_natural_death` (age ≥ 70 + a health-scaled roll) | the daimyo dies; capital death collapses the faction (`find_fiefs_of_owner`) |

## AI-initiated events — `random_event_type_dispatch`
A separate roll (fired at the tail of the uprising dispatcher): **50% nothing**, else one of —
`ai_event_marry_random_eligible_fief` (the AI proposes a marriage), `ai_scan_idle_fiefs_run_diplomacy_action`
(the AI runs a Pact/diplomacy action), or `random_ravage_sweep_bounded_fiefs` (an extra ravage). These are
the AI exercising the *player's* diplomacy verbs autonomously. *(Bodies are named but not yet fully walked —
their exact eligibility/effects are an open follow-up.)*

## Open follow-ups
- **⚠verify the Spring player-decay offsets** (which three province stats; the `const_two>1` gate) against bytecode.
- **The uprising→combat staging path** (`battle_defender_province_staging` / `append_candidate_priority1`) into bank 2.
- **The AI-initiated `random_event_type_dispatch` payloads** (marry / diplomacy eligibility + effects).
- **Rename** `spawn_zealot_uprising_force_from_province` → `spawn_uprising_force_from_province` in the labels.

## Tags
[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
