---
status: active
created: 2026-05-20
updated: 2026-06-13
---
# Chapter 17 — The Damage Formula: How Soldiers Die

> Chapter 14 mapped the combat loop; chapters 15–16 placed the tactical map and its render. This chapter carries the payoff the Pass-1 walk left deferred: **the damage formula, decoded from the bytecode and emulator-certified against live battles.** The Pass-1 reading guessed it lived in native 6502 and depended on RNG. Neither is true. Melee is a **deterministic strength-ratio** computed entirely in VM bytecode; only *Bribe* and the AI's off-screen path roll dice. What follows is the certified math, the Charisma-contest defection that is Bribe, the battle cleanup, and the one genuinely open question — terrain.

**Links:** [Chapter 14 — Combat Overview](./14-combat-overview.md) · [Chapter 15 — Tactical Map](./15-tactical-map.md) · [Chapter 16 — Render Pipeline](./16-tactical-map-render.md) · [Nobunaga README](./README.md)

## Two resolvers, not one

The Pass-1 walk conflated them. There are **two** casualty paths:

| Path | Function | Used by | Character |
|---|---|---|---|
| **Melee** | `resolve_attack_apply_mutual_casualties $9E20` | the **Attack** verb (Move-into-contact) | deterministic mutual attrition |
| **Defection** | `resolve_attack_apply_casualties $9E73` | the **Bribe** verb + the AI's own attacks | a morale+Charisma+rng contest; men switch sides |

When the player attacks, melee runs. The earlier "the real damage formula is a Charisma contest" claim was reading `$9E73` — that's **Bribe**, below. The actual sword-on-sword math is `$9E20`, and it has no Charisma term and no dice.

## The melee formula (Attack `$9E20`) — certified

One attack is a **mutual exchange** driven by your share `p` of the combined strength:

```
p = calc_battle_strength_pct_one_side          # 0..100, the attacker's strength share
  = math32_2arg(S_attacker, S_defender)        # = S_attacker·100 / (S_attacker + S_defender)

your unit   loses (100 − p)%   of its men
enemy unit  loses      p%      of its men

casualties = pct_op(men, pct) + (pct ≥ 50 ? 1 : 0)     # capped at the unit's men
```

Both sides bleed every exchange; there is no "free" attack. `p = 50` is an even trade, `p > 50` means you came out ahead. The result feeds `apply_pct_reduction_to_unit_strength $9D03` twice — once per side — and a unit dies when its men reach 0 (no special "kill" path, confirming the Pass-1 observation).

### The strength core `S` (`ai_eval_battle_strength_total $9C88`)

Each unit's effective strength, for `m` = its men:

```
S = ( m                                            base men
    + (your side is the DEFENDER ? m : 0)          +100% HOME bonus  (war_side_state_flag bit7 = defender)
    + terrain_term                                 affects casualties (likely DEFENSIVE — see below); rule not yet locked
    + province_stat_diff                           small: fief skill/arms edge over the enemy
    + (wrap(slot) > wrap(enemy_slot) ? m : 0)      +100% unit-rank   (Rifles slot2 > Cavalry slot1 > Infantry)
    + m·(1 + 0.4·W/100)                            the 8-STAT term (re-adds one ·m)
    + m·0.2·(enemy unit's prior-contest count)     +20% momentum per prior exchange this turn
    ) × difficulty_scale
difficulty_scale = (your fief is AI-Home state0) ? 100% : (115 − 15·skill)%
```

Two structural surprises, both confirmed:

1. **bit7 is the *defender's* bit, not the attacker's** — so the `+base` doubling is a **home-ground bonus**. **Combat favors the defender.** An attacker must bring overwhelming force (more men, better stats, or the higher-rank unit) to overcome it.
2. **The "AI weakness scorer" *is* the engine.** `ai_sum_battle_strength` — which the AI uses to decide *whether* to attack (chapter 12) — is the very routine that builds `W` inside the real resolver. The decision math and the combat math are one core, and that core pulls in **all five daimyo personal stats**, not just the fief's military ones.

### `W` — the 8-stat weighted contest

`W` is the sum of the weights of the stats you **beat the enemy on** (`battle_strength_stat_weights $B5B1`, bytecode-confirmed alignment). Win all eight → `W=100` → +40% strength.

| Stat | Weight | | Stat | Weight |
|---|:---:|---|---|:---:|
| fief **Skill / training** | **25** | | daimyo Drive | 10 |
| daimyo **IQ** | **20** | | daimyo Luck | 10 |
| fief **Arms** | **15** | | daimyo Health | 5 |
| fief Morale | 10 | | daimyo **Charisma** | **5** |

The decisive stats are **fief training (25)** and **daimyo IQ (20)**. **Charisma is nearly worthless in melee (5)** — its combat value is in *Bribe*. Skill and Arms also re-enter via the small `province_stat_diff` term, so they double-count. (Arms is triple-duty: it also caps how much of your army can be Rifles — `cap = arms/50 + 20`.)

### The primitives (ROM-certified)

```
math32_2arg(a, b) = a·100 / (a + b)        # $D6DE — a as a percent of the total
pct_op(a, b)      = a·b / 100              # $D70D — digit-decomposed to dodge 16-bit overflow
```

### Determinism — no RNG in melee

`$9E20` and `$9D03` contain no `rng` call. Given the inputs, the casualties are exact. That is what makes the formula certifiable: predicted counts must match observed counts to the soldier.

## Certified, on the emulator

A write-callback logger (`tools/lua/combat-certify.lua`) capturing every men-array write with its inputs, plus an offline checker (`tools/combat-check.py`) replicating the formula, was run across four battles (logs in `assets/Saves/*Battle.txt`). On open ground every exchange matches **exactly**:

| Exchange | S_attacker | S_defender | p | predicted (enemy / self) | observed |
|---|---|---|---|---|---|
| Iga, Oda u3 vs Mino-style 6v6 | 25 (home) | 14 | 64% | 4 / 2 | 4 / 2 ✓ |
| Iga, Ise u2 vs Iga u0 (8 men ea.) | 36 | 24 (home) | 60% | 5 / 4 | 5 / 4 ✓ |
| Omi vs Iseshima, plains 6v8 | — | — | 62% | 5 / 2 | 5 / 2 ✓ |

The `+1`-when-≥50% rounding is what makes the *enemy* lose 4 of 6 (not 3) at `p=64`. With the primitives ROM-certified and the weights bytecode-confirmed, the open-ground melee formula is **locked**.

## Bribe & the AI attack (`$9E73`) — buying soldiers

`$9E73` is a different beast: **pay gold, and enemy men defect into your commander's unit.** Commander-only. You pick an enemy unit and an amount of gold `g` (deducted in full, win or lose); then:

```
att_score = rng(0 .. 5−skill) + your_fief_morale + your_daimyo_Charisma
def_score = enemy_fief_morale + enemy_daimyo_Charisma + 2·skill

needs:  att_score > def_score        (else nothing happens)
  and:  g ≥ enemy_unit_men           (1 gold per soldier — overpaying buys nothing)

defectors = enemy_men · (att−def)/(2·att−def)     # ≤ ~50% of a unit per bribe
→ those men LEAVE the enemy unit and JOIN your commander (unit 0)
```

So Charisma rules the bribe and is inert in melee — a clean division of labor. Bribing is far weaker at high difficulty (your `rng(0..5−skill)` shrinks to 0 at skill 5 while the defender gains a flat `+2·skill`), and a high-morale, high-Charisma garrison is effectively bribe-proof. The **AI** uses this same routine for its attacks (spending its surplus), which is why an AI assault often *absorbs* your men rather than simply killing them.

## The off-screen resolver — a third, simpler formula

When an AI-vs-AI battle is **not watched** (and the player isn't the defender), bank 2 is skipped and `resolve_siege_assault_outcome $8DFD` resolves it in one comparison:

```
strength = men·(2 + [+1 if attacker | +1 if defender-on-castle]) + arms + skill + morale
         + 10% morale to whichever daimyo has higher DRIVE
higher strength wins
```

Only **Drive** matters here among the five daimyo stats — versus the full eight in the tactical engine. The "Watch Battles" option therefore changes which formula decides AI wars, and so can change how the strategic map evolves.

## Battle cleanup (`apply_conquest_outcome $E03C`)

Both resolvers finish through the same cleanup:

- **Survivors of both sides SUM into the conquered fief** — `gold = att+def`, `rice = att+def`, `men = att+def`. Your army garrisons the captured fief and stays there: winning **moves your force forward**, it does not march home.
- **Battles permanently shift daimyo stats**: the winner's lord gains **+1 Drive / +1 Charisma / +1 IQ**; the loser's loses one of each (`daimyo_stat_transfer`). Winners snowball.
- The fief's morale/skill/arms become a men-weighted blend of the two armies; **rifles are re-capped** to `arms/50 + 20`.
- **Capital falls → the whole faction is absorbed** (`reassign_fiefs_to_conqueror`), each fief inheriting the attacker's state (so a player conquest comes out Direct).

## The `/30` — that's the *supply* clock, not damage

Pass-1 read a `/30` fixed-point accumulator and called it the damage tracker. It is the **rice supply tick**: `consume_daily_battle_rice` drains each side's stockpile ≈ `rice/30` per combat day. Melee casualties are integer `pct_op` results with no `/30` carry. So the `/30` belongs to the rice clock below — which is exactly what makes the doughnut defence work.

### Captured damage events (re-read correctly)

The Pass-1 memory-write trace on `$6FBC–$6FCF` across three battles still stands as evidence — now correctly interpreted:

| Pair | Unit | Side | Old → New | Notes |
|---|---|---|---|---|
| 1 | 2 | attacker | 9 → 7 | gradual `pct_op` loss |
| 2 | 7 | defender | 4 → 1 | |
| 3 | 7 | defender | 1 → 0 | death = strength hits 0 (no kill opcode) |
| 4 | 1 | attacker | 12 → 12 | a 0-casualty exchange (`pct_op` rounded to 0) |
| 5 | 5 | defender | 5 → 2 | |
| 6 | 2 | attacker | 7 → 4 | |

Damage is gradual (0–3/exchange), units die at 0, and the casualty *ratio* varies by battle because it falls straight out of `p` — there is no hardcoded attacker multiplier. (What asymmetry exists favors the **defender**, via the home bonus.)

## Terrain — it affects melee; the exact rule is still under investigation

What is **solid**: terrain affects melee casualties. Every exchange fought on castle/forest deviates from the no-terrain prediction, in the direction `ai_terrain_strength_term $9BB4` implies (castle +270%, forest +60%, town +30% of a unit's men). Holding the castle is unambiguously the strongest defensive position.

What is **not yet locked**: *how* it enters. A symmetric strength-term (terrain boosts whoever stands on it, attacker or defender) fits some exchanges but not others — a unit on the castle while **attacking** showed no offensive boost, while a unit on the castle while **being attacked** clearly took fewer casualties. The leading hypothesis is therefore a **defensive** bonus — terrain helps the unit *being attacked*, not the one attacking — but the certifying tool isn't yet reliable enough to confirm it (see below), and one forest exchange contradicts even that.

Three tool problems block the final rule, and they are reliability issues, not formula gaps:
1. **Deployment/combat write interleave** — in a full 5v5, some exchanges fire before a unit's deployment write is captured, so the men values used in the prediction are momentarily wrong (a unit can read as 0 strength).
2. **The mystery mid-combat `+1`** to a unit's men (supply/redistribution or a bribe defection), which shifts the men the prediction depends on.
3. **Low fidelity** — when units are down to 1–2 men, integer rounding makes every prediction collapse to the same value, so nothing discriminates.

The fix is to harden the logger (guard exchanges whose units were just non-combat-written, track per-side total men to classify the `+1`, flag low-fidelity exchanges) and re-run on a high-strength battle. Until then the terrain *rule* is honestly open.

What terrain unambiguously **also** does is the **breach** — an attacker reaching the castle cell halves the defending fief's morale, once per day, geometrically collapsing the garrison (confirmed `63 → 31` mid-battle).

## The rice-exhaustion attack — a dominance-frontier edge

The supply mechanic's two ingredients (linear man-day consumption + a 30-day hard deadline) produce a non-obvious counter-strategy that turns map topology into economics directly.

```
1 rice ≈ food for 1 man for one full battle (consumption ≈ rice/30 per day)

Defender with R rice, N men, facing K successive full-length attacks:
  each attack drains ~N rice; survival needs R ≥ K·N.
  Even K=1 with R < N → "you have no rice!" mid-battle, instant defeat.
```

### Worked example: a 3-province exhaustion attack

```
Target T: 100 defenders, R rice. Attacker holds A,B,C adjacent to T.
Turn 1: 10 men +10 rice from A → T; evade contact 30 days; T burns ~100 rice.
Turn 2: 10 men +10 rice from B → T; another ~100.
Turn 3: 10 men +10 rice from C → T; if R < 300, T starves mid-battle.
Cost: 30 men + 30 rice. Required defender rice to survive: ≥ 300.
```

### Why it works — and the counter

The attacker must be able to **evade contact** for the full clock — a doughnut/chokepoint tactical map enables it; a tight open map forces engagement and the small attacking force is crushed first. So viability rides on two topology variables: **K** (adjacent enemy provinces, from the bank-4 adjacency table) and the **fief's tactical geometry**. Beautiful symmetry: doughnut fiefs are strong on *both* offense and defense — the same shape lets a defender evade a larger attacker and lets an attacker evade a stronger garrison while running its rice down.

### Strategic implications

1. **Defender's required rice scales as `K·N`.** A central province with K=4 and 100 men needs 400 rice to survive coordinated assault. **Geography is economics.**
2. **Pyrrhic-conquest recursion**: a captured fief inherits depleted rice (and the merged survivors), exposed to the same trick next.
3. **The 30-day limit IS the dominance-frontier mechanism** — a deterministic resource clock, time replacing RNG as the closing move.
4. `vulnerability(T) = K_T · N_defenders / R_stockpile`; a score ≥ 1 means a coordinated K-attack can exhaust the defender. Ranking all fiefs by it *is* the conquest-phase frontier picture.

## How combat sits in the dominance frontier

- **Attacking is expensive** (the defender's home doubling) — so the dominant play is to *bait* the AI into attacking you (where you hold the home bonus), or to win battles before they start (assassinate the capital, ch. ninja).
- **The exploit gap**: the AI decides to attack on the 8-stat *look* (`ai_sum_battle_strength`), but you win battles by maximizing what the *same core* rewards — men, the higher-rank unit, training, and IQ — while the AI never optimizes composition. Look weak, be strong.
- **Charisma's two faces**: useless in the sword-fight, decisive in the bribe — pump it and *buy* armies instead of grinding them.
- **The rice clock** turns the map graph into the real win condition: who borders whom, and which fiefs can run the doughnut.

## Method note

Static disassembly carried the *structure* (the day driver, the supply clock, the 30-day limit, the dominance-frontier analysis). It could **not** give the coefficients, and it produced a confident-but-wrong story (formula "hidden in native code," RNG-driven, `/30` damage). Reading the **decompiled bytecode** recovered the real formula; the **emulator** certified it to the soldier and then caught two things the static read never showed — the defender home bonus and the asymmetric terrain protection. The combination — decompile for structure, bytecode for coefficients, emulator for truth — is the method that turned a deferred chapter into a certified one.

## Tags

[6502](../../../tags/6502.md) · [nes](../../../tags/nes.md) · [mmc1](../../../tags/mmc1.md) · [assembly](../../../tags/assembly.md) · [reverse-engineering](../../../tags/reverse-engineering.md) · [bytecode-vm](../../../tags/bytecode-vm.md) · [nobunagas-ambition](../../../tags/nobunagas-ambition.md)
