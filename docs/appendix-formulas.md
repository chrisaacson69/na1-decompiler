---
status: active
created: 2026-05-26
updated: 2026-11-02
---
# Appendix A — Verified Game Formulas

> Exact equations from the bytecode walk, checked against controlled in-game tests. Most are **emulator-certified to the digit** across ≥3 SRAM snapshots; a few (Move, Marry, View, parts of Trade) are **derived by composition** of already-certified primitives and flagged as such in their sections.

**Links:** [commands README](./commands/README.md) · [Chapter 11 — strategic engine complete](./11-strategic-engine-complete.md) · `source/2-asm-vm/bank_01_vm.asm`, `source/2-asm-vm/bank_15_vm.asm`

## Notation

- `⌊x⌋` = floor (truncate-toward-zero integer division — what 6502/VM does natively)
- `√x` = `sqrt_int` ($CBCD) — integer square root, truncated
- `header` = fief's max-economy ceiling (column at province record offset +24, e.g. 1640 for Mikawa)
- `pct_op(b, p)` ≈ `⌊b × p ÷ 100⌋`, computed split-by-10 to stay in 16 bits ($D70D), and so up to 1 short (§pct_op)
- `math32_3arg(a, b, c) = ⌊(a × b) ÷ c⌋` — 32-bit signed ($D6B8); **`c = 0` returns `$FFFF`**, and a **negative `c` divides by |c|−1** (KOEI's `sdiv32` one's-complements a negative divisor: a ROM bug, in every KOEI NES title that has it)
- `math32_2arg(a, b) = ⌊100 × a ÷ (a + b)⌋` — `a`'s share of the total `(a+b)` as a percent ($D6DE; `(0,0)→0` guard)

> **Re-checked against the ROM 2026-10-27** (15,317 inputs incl. `$8000` / `$FFFF` / zero divisors; the May probe's test vectors missed the edges). The checked models are emu-harness `vm_decompile.na1_extop_model`, which `cfg_gate` runs against the ROM on every gate run; cite those, not a copy. The underlying extended-opcode table (`ext_op_table` $F263, 47 handlers) is decoded and named in `mesen-labels.toml`, but these three composite helpers are the interface every formula calls. ⚠️ `run-effect.py` *reverses* captured arg order for display — true frame order is arg1@fp+0x0B, arg2@+0x0D, arg3@+0x0F.

## 1. Grow ($87F0) — develop output

```
gain = 2 × ⌊amount × (6 − skill_level) ÷ √(output + amount)⌋   ; skill_level=$6D63, normally 1 → ×5
                                  ; headroom clamp: gain = min(gain, header − output); min gain 1
pct  = (gain/2 > output) ? 50 : ⌊100 × gain ÷ (gain + output)⌋ ÷ 2   ; computed LIVE — not a constant
loyalty -= pct_op(loyalty, pct)   ; ⌊loyalty × pct ÷ 100⌋
dams    -= pct_op(dams,    pct)   ; same pct
output  += gain
gold    -= amount                 ; debited by driver before effect runs
```

**Drain sequence verified from bytecode** ($8859-$8870): two `host_call $D70D (pct_op)` invocations, one for loyalty (record+12), one for dams (record+10). Both use the SAME pct computed once at $884D.

**The drain percentage is computed live** ($8833-$884E), not a constant: `math32_2arg(gain, output) = ⌊100·gain/(gain+output)⌋` is halved to give `pct`, with a flat `pct = 50` ceiling when `gain > 2·output`. The same `6−skill_level` multiplier and live-pct drain apply to Build and Give.

- **ROI**: `gain / amount ≈ 10 / √(output + amount)` — pure inverse-sqrt diminishing returns
- **Strategic implication**: front-load Grow when output is low; ROI drops sharply past output ~300
- **Verified**: 5/5 controlled tests (2026-05-26). See [grow.md](./commands/grow.md).
- **Source bytecode**: $87F0–$881x; math at $D6B8

## 2. Build ($88A6) — develop town

```
g    = ⌊amount × (6 − skill_level) ÷ √(town + amount)⌋   ; skill_level=$6D63, normally 1 → ×5
g    = max(g, 1); g = min(g, header − town)            ; headroom clamp (rarely fires)
pct  = (g > town) ? 50 : ⌊100 × g ÷ (g + town)⌋ ÷ 2    ; computed LIVE — not a constant
wealth -= pct_op(wealth, pct)
town   += 2 × g                                        ; via helper_dam_rounding (halved if at war)
gold   -= amount                                       ; debited by the driver
```

**Only ONE drain** (wealth), vs Grow's TWO drains (loyalty + dams). Same `pct_op` primitive. From the bytecode walk of `$88AB-$891C` (+ 5 ROM re-executions):
- **`pct` is computed live**, like Grow — from the gain-to-town ratio (`math32_2arg(g, town)` halved), capped at 50%.
- **Build does ONE town write of `2g`**, routed through `add_effect_gain_clamped` ($887D) — which adds the full `2g` in peacetime, halves it only when `war_helper_d972(province)` is true, then calls `helper_82AC` to cap `town` at `header`. (There is no separate "secondary" town add — it's that single routed write.)
- **`g` is the UN-doubled gain** (math32_3arg result, stored without `<<1`); the `×2` is applied at the town write (`gain << 1` passed to the helper), and `effect_build` returns `g` for the confirm screen. (Grow doubles early; Build doubles late — same magnitude, slightly different `pct` ratio input.)

- **K = 5** — same `6 − skill_level` multiplier as Grow/Give. Develop-family universal constant.
- **Verified**: bytecode + 5/5 ROM-executed tests (town=176, wealth=235; amounts 30/50/80/120/200 all exact) + in-game Test 1 (amount=170, town 320→396 = +76, √490=22, g=⌊850/22⌋=38, 2g=76). See [build.html](./commands/build.html).
- **Source bytecode**: $88A6 (+ $887D helper); math at $D6B8

## 3. Give-Peasants ($A8D3 → $891D + $896F) — convert resource → loyalty + wealth

```
rice -= amount                               ; or gold if gold-mode (1:1 source drain)
loyalty_gain = 2 × ⌊amount × (6 − skill_level) ÷ √(⌊(output + loyalty)/2⌋ + amount)⌋   ; develop_loyalty $891D
wealth_gain  = 2 × ⌊amount × (6 − skill_level) ÷ √(⌊(town   + wealth )/2⌋ + amount)⌋   ; develop_wealth $896F
loyalty += loyalty_gain
wealth  += wealth_gain
```

**Thematic pairing confirmed by bytecode**: each target stat is averaged with its "productivity twin" before sqrt:
- LOYALTY (peasant satisfaction) ↔ OUTPUT (agricultural productivity)
- WEALTH (commerce capacity) ↔ TOWN (urban infrastructure)

This prevents runaway-pumping by pulling the gain toward whichever of the pair is lower.

- **K = 5** — same develop-family constant as Grow/Build. **Now confirmed 3-of-3 commands.**
- **Verified**: 2 controlled Give-Rice-Peasants tests (give.md test 1 + 2026-05-26 new-game test). Both predicted gains (loyalty +48, wealth +58) matched exactly.
- **Source bytecode**: $891D (loyalty helper, walked 2026-05-26 to confirm pairing), $896F (wealth helper, parallel structure)

## Train ($9586) — skill growth

```
skill_gain = (rng%20 + 10) × 4 + bonus       ; (rng%20 + 10) << 2, confirmed $959A-$95A2
bonus = 10 if (daimyo[+3] + daimyo[+5]) > (rng%10 + 90) else 0   ; aptitude pair (Luck+IQ)
skill += skill_gain                          ; capped at the fief ceiling by the driver
```

- Range: **40–116 per training session** (without bonus), **50–126** (with bonus) — `(rng%20+10)×4` with `rng%20 ∈ [0,19]` spans 40–116.
- For Tokugawa (aptitude pair = 167 > max threshold 99): bonus **always fires**, so his band is 50–126
- No drains, no cost — pure skill stat-up; the animation plays *before* the effect (driver $A671 → $A676)
- Requires soldiers (`men > 0`) — you can't drill an empty garrison
- **Verified**: bytecode ($9586) + 9/9 controlled tests (2026-05-24/25). See [train.html](./commands/train.html) · [train.md](./commands/train.md).
- **Source bytecode**: $9586; uses `rng_mod` ($CA52) and `ui_helper_d7ea` (daimyo getter)

## pct_op ($D70D) — percentage drain primitive

```
pct_op(b, p) = ⌊b ÷ 10⌋ × ⌊p ÷ 10⌋
             + ⌊(b mod 10) × p ÷ 100⌋
             + ⌊(p mod 10) × (b ÷ 10) ÷ 10⌋
```

Three pieces keep every intermediate in 16 bits, and each piece floors on its own, so the sum is **not** `⌊b × p ÷ 100⌋`: it is never more and is exactly 1 less for about a third of in-range inputs (e.g. `pct_op(11, 19) = 1`, not 2). Checked against the ROM 2026-11-02 (`na1sim.oracle` case `pct_op`, 110/110 for the three-piece form; the plain `⌊b × p ÷ 100⌋` model fails 10 of them). The 8+ observed drain calls of May fit both forms.

## 4. Harvest income ($A26F sweep → $A1E2 gold + $A21F rice)

> **The named subroutines** (walked in the grounded C `source/4-c/bank_00.c` and re-checked opcode-for-opcode in `source/2-asm-vm/bank_00_vm.asm`): `harvest_income_sweep_all_fiefs $A26F`, `calc_fief_harvest_base_term $A1AA`, `calc_fief_gold_income $A1E2`, `calc_fief_rice_income $A21F`, `calc_charisma_scaled_income_variance $A191`, `event_boost_province_gold_output $A128`, `consume_province_army_upkeep $A15B`, `repay_province_debt_from_gold $92A9`, `update_province_highwater_marks $A0A9`, `get_fief_daimyo_charisma $946D`.

The fall transition (`current_season == 2`) calls `harvest_income_sweep_all_fiefs`, which **decays relations once at the top** (`normalize_relations_matrix_lower(2)` — so relations drift in BOTH Fall and Winter, ledger note), then iterates every fief. Per fief, in this exact order:
1. **`$A0A9 update_province_highwater_marks`** — ratchet the low-water marks (output_max, dams_max, lm, wm) at the `$6000`-base table (8 B/fief: +3 output_max, +5 dams_max, +7 lm, +9 wm).
2. **`$A128 event_boost_province_gold_output`** — **AI-owned fiefs only** (`province_ai_state == 0`). NOT a deposit — it's the rubber-band subsidy (see Critical mechanics).
3. **Income gate = loyalty (record +12) > 0.** A fief in full revolt (loyalty 0) earns nothing. If loyalty > 0: `gold += calc_fief_gold_income`, `rice += calc_fief_rice_income` (deposits are **inline in the sweep**, not a `$A128` call).
4. **`$92A9 repay_province_debt_from_gold`** — auto-repay debt from the new gold (`pay = min(gold, debt)`), **before** upkeep.
5. **`$A15B consume_province_army_upkeep`** — MEN/2 from both gold and rice (with the starvation clause below).
6. **`$D836 cap_fief_stats`** — clamp each field to [0, header].

Province-record offsets (base `$7001 + fief*26`): gold +0, debt +2, town +4, rice +6, output +8, dams +10, **loyalty +12**, wealth +14, men +16, header +24.

### Gold formula

> Both incomes share one base term (`calc_fief_harvest_base_term $A1AA`) and one RNG term (`calc_charisma_scaled_income_variance $A191`); MEN/2 is **not** part of the income calc — it is the separate upkeep step (5) that drains gold *and* rice after deposit.

```
base = pct_op(pct_op(lm, 40), tax)        ; loyalty contrib via 40% pre-scaling
     + pct_op(wm, tax)                     ; wealth contrib
rng  = rng_mod( pct_op(charisma/2, tax) + 1 )   ; = rng in [0 .. ⌊charisma × tax / 200⌋]; independent roll for gold vs rice

GOLD = base + pct_op(town, tax)            ; town contrib (gold-specialized)
     + rng                                 ; RNG_G
     (then clamped to ≤ header in the calc; ≥ 0 by $D836 after upkeep)
```

### Rice formula

```
RICE = base + pct_op(pct_op(output_max, dams_max), tax)   ; output × dams (rice-specialized)
     + rng                                                 ; RNG_R — independent roll
     (then clamped to ≤ header in the calc; ≥ 0 by $D836 after upkeep)
```

Then, regardless of loyalty: **debt is repaid** (step 4), and **upkeep** (step 5) drains `⌊MEN/2⌋` from gold AND rice — so the net deposit a player sees is `income − debt_repaid − ⌊MEN/2⌋`.

### Critical mechanics

- **lm/wm/output_max/dams_max are LOW-water marks**, but **re-seeded every Summer.** `$A0A9` ratchets each mark DOWN to current when current is lower (`if mark >= current: mark = current` — confirmed in grounded C, resolving the old "inverted `cmp_sle`" note); but **Summer (`current_season == 1`) calls `init_province_highwater_from_records`**, which re-seeds the marks from the live records. So a stat dip hurts income **only for the rest of that year** — the marks reset each Summer, not "permanently." Income each Fall is computed off `min(summer_snapshot, fall_current)` per stat. **The Summer snapshot is taken as the Summer banner appears, before any Summer command** (`ai_strategic_turn_planner` advances the season at $A483 and runs the per-period driver at $A498 before the fiefs' commands; season 1 is "Summer", `draw_current_season` $D6A9), and the Fall harvest likewise runs before any Fall command. So a Spring gift pays this Fall, a Summer gift pays next Fall, and a Summer dip costs this Fall (ledger #54; **checked in the cartridge**, headless Mesen, Oda 1560: a Summer gift of 50 gold took live loyalty/wealth 47/48 → 97/98, the marks stayed 47/48, and the Fall harvest matched marks 47/48).
- **`$946D` = daimyo Charisma.** `get_fief_daimyo_charisma` reads `daimyo_record + 4` (the Charisma byte, BYTE_DEREF). The RNG range `⌊$946D × tax / 200⌋` is exactly `pct_op(charisma/2, tax)`; same-owner fiefs share it because they share a daimyo (Tokugawa's Charisma 68 drives the Mikawa check below).
- **Army STARVATION**: `consume_province_army_upkeep` is not a flat −MEN/2. If `min(gold, rice) < ⌊MEN/2⌋` (you can't afford upkeep), then upkeep is capped at `min(gold, rice)` **and `men` is cut to `min(gold,rice) × 2`** — you lose the soldiers you can't feed. Then both gold and rice are drained by the (capped) upkeep. So a cash/rice-starved big army bleeds men every Fall.
- **AI gold SUBSIDY**: `event_boost_province_gold_output` fires only on AI fiefs (`ai_state == 0`): `gold += rng(0..9) + ⌊charisma/10⌋`, then a **50% coin (`rng_mod(2)`)** also does `output += rng(0..9) + ⌊charisma/10⌋`. This is the rubber-band — the AI economy is quietly topped up; the player's is not.
- **MEN/2 is the army-upkeep tax** — subtracted from BOTH gold AND rice every harvest. Big armies eat substantially into harvest (and can starve, above).
- **Tax dominates income SIGN**: below break-even (where positive contributions = MEN/2), income clamps to 0. For undeveloped fiefs, break-even ≈ 25-30% tax.
- **TOWN is in gold formula, OUTPUT×DAMS is in rice formula** — confirms Build's direct gold ROI and Grow+Dam's direct rice ROI.

### Verification (Mikawa, fief 7)

State: town=66, dams_max=64, output_max=136, lm=40, wm=51, men=71, tax=55, **Charisma=68** (Tokugawa)

| field | calc | value |
|---|---|---:|
| loyalty contrib | pct_op(pct_op(40,40),55) = pct_op(16,55) | 8 |
| wealth contrib | pct_op(51, 55) | 27 |
| town contrib | pct_op(66, 55) | 36 |
| OD_pct (rice only) | pct_op(pct_op(136, 64), 55) = pct_op(87, 55) | 47 |
| RNG range | pct_op(charisma/2, tax) = pct_op(34, 55) | 0–18 |
| RNG_G (this run) | from trace | 4 |
| RNG_R (this run) | derived from obs | 14 |
| MEN/2 | 71/2 | 35 |

**Predicted GOLD = 8+27+36+4−35 = 40** ✓ (observed +40)
**Predicted RICE = 8+27+47+14−35 = 61** ✓ (observed +61)

### Strategic implications

1. **Wealth_mark has highest ROI per point** (full tax×wealth scaling)
2. **Loyalty_mark has half-ROI** (40% pre-scale before tax multiply)
3. **Town: gold-only**, **Output×Dams: rice-only** — Build vs Grow specialize
4. **MEN/2 is tax-independent** → at low tax + big army, harvest clamps to 0
5. **Marks ratchet down within a year, reset each Summer** → don't let stats dip *going into Fall*; the damage is one year, not permanent (Summer re-seeds the marks). Spend the Spring/Summer window restoring loyalty/wealth before the Fall snapshot.
6. **Charisma quietly matters** → high-Charisma daimyo get a bigger income RNG ceiling (`⌊charisma×tax/200⌋`), and AI fiefs get a Charisma-scaled gold/output subsidy each Fall.
7. **Feed your army** → keep `min(gold, rice) ≥ MEN/2` each Fall or the upkeep step culls men down to `2·min(gold,rice)`.

## math32_3arg ($D6B8) — 3-arg math helper

```
if arg3 == 0: return -1
return ⌊(arg1 × arg2) ÷ arg3⌋
```

32-bit signed multiply then signed divide. Used by Grow, Build, Give, Dam — the "develop-family" math kernel. Each caller pushes (arg1, arg2, arg3) at frame offsets +0xB, +0xD, +0xF before `host_call $D6B8`.

- **Verified**: by trace of Test 5 Grow (2026-05-26)
- **Underlying ALU**: 47 extended opcodes (`ext_op_table` $F263, via `ext_op_dispatch` $F246); 32-bit shift-add multiply at $F2C1, 64-bit/32-bit restoring divide at $F2FE

## Send ($9A5D driver + $8BE5 capacity helper)

### Formula
```
effective_amount = min(target_HEADER − target_current, user_requested)
target_field += effective_amount
source_field -= effective_amount   (no attrition)
```

### Confirmed
- **NO travel attrition** — all sent resources arrive
- **Receiver-capacity cap** is the only limit (you can't overfill target's HEADER)
- Sends BOTH rice and gold in single confirm step
- $8BE5 = `min(HEADER − current_field, requested_amount)`

### Strategic
- Trickle-fill works fine across many small targets
- Send to high-HEADER fiefs for biggest transfers
- Pairs with Give-Peasants: Send moves rice, Give converts rice to stats

## Trade — the merchant market ($A1B6 driver; rate table $6E0B)

> A global commodity/credit market behind one menu. Prices come from a **period-rolled rate table** (`$6E0B`, re-rolled once per **year** at the season wrap by `roll_period_market_rates $924A` — see ledger #24) that **also drifts ±1 per transaction**. Every quantity cap uses `ratio_times10_capped(a,rate,cap) = min(⌊a·10/rate⌋, cap)` (CERTIFIED); every price uses `math32_muladddiv(rate,N) = ⌈rate·N/10⌉` (CERTIFIED) — so **rates are stored ×10** (a rate of 15 = 1.5 gold/unit).

### Presence (`effect_trade $8A15`)
```
merchant present ⇔ fief is 13 or 14 (17-fief) / 30 or 32 (50-fief)   ; the two commercial capitals: always
              OR  (ai_turn_flags & 1)                                ; elsewhere: a per-turn flag, set with prob (55 − 5·skill)%
```

### The five services (rates: `loan_rate $6E0B`, `gold_rice_exchange_rate $6E0D`, `arms_buy_price_rate $6E0F`)
```
Loan  ($9F04→$8B40):  max_gold = min(⌊(town−debt)·10/(loan_rate+10)⌋, header−gold)
                      borrow N → gold += N ;  debt += ⌈(loan_rate+10)·N/10⌉   ; cycle_economy_rate(0): loan_rate+1 (wrap>15→rng15)
   ⇒ debt CEILING = town; at max loan debt rises by (town−debt) but you only RECEIVE (town−debt)·10/(loan_rate+10) gold.
     loan_rate is the interest, baked in: gold-per-debt = 10/(loan_rate+10) = 0.91→0.50 as loan_rate climbs 1→10.
Repay ($9FAF):        N = number_input(1, min(gold,debt)) ;  gold −= N ; debt −= N         ; 1:1, no rate
Sell  ($A003):        max = min(⌊(header−gold)·10/rate⌋, rice) ;  gold += ⌈rate·N/10⌉ ; rice −= N ; rate−1 (price falls)
Buy   ($A068):        max = min(⌊gold·10/rate⌋, header−rice) ;     gold −= ⌈rate·N/10⌉ ; rice += N ; rate+1 (price rises)
Arms  ($A113):        needs men>0 ; max = min(⌊gold·10/arms_rate⌋, header−arms)
                      gold −= ⌈arms_rate·N/10⌉ ; arms += N / force_factor   ; arms_rate+1 (price rises)
                      force_factor = math32_3arg(arms+men, 5, header)   ; arms gain DILUTES as the force grows
```
- **Per-transaction drift** (`cycle_economy_rate`): selling rice nudges its price **down**, buying rice/arms nudges it **up**, each loan raises `loan_rate` — a light supply/demand pressure on top of the seasonal re-roll.
- **Caps everywhere are the `header` ceiling** (treasury/storehouse/armory room) — the same development ceiling the develop commands fight.
- All field offsets per the `$7001` province-record map (gold +0, debt +2, town +4, rice +6, arms +22, header +24).

## Move ($96D1 driver → effect_move $8CA5; arms blend $DA24) — *derived by composition*

> Move relocates men **and** arms between two of your own fiefs. The men transfer is Send's capacity-clamp; the arms transfer is Hire's men-weighted dilution — so Move is verified *by composition* of two already-certified primitives (not independently emulator-run yet).

### Formula
```
; preconditions (driver $96D1)
if src.men == 0:                 "you have no soldiers"     ; effect_war_combat_prep_b
amount = number_input(cap = min(src.men, dest.capacity − dest.men))   ; "That fief can't hold more men" if cap==0

; effect ($8CA5): for each of the 3 military QUALITY stats q ∈ {morale+18, skill+20, arms+22}
dest.q = min(dest.header,
             ⌊ dest.q·dest.men / (dest.men + amount) ⌋        ; pct_op · math32_2arg(dest.men, amount)
           + ⌊ src.q · amount  / (dest.men + amount) ⌋ )      ; = men-weighted average (same as Hire dilution §7)
dest.men += amount
src.men  −= amount
if src.men == 0: clear src military stats   ; clear_military_stats_if_no_men (zeroes morale/skill/arms)
cap_arms_at_index(dest)                     ; re-caps the SEPARATE $76A9 unit-type-pct table at arms/50+20
```

### Confirmed
- **Capacity-clamped, no attrition** — `min(src.men, dest.header − dest.men)` (the `header` +24 field = the army ceiling); the men all arrive (like Send).
- **The 3 quality stats dilute on merge** — morale/skill/arms become the **men-weighted average** of garrison-and-incoming, capped at `header` (`scaled_force_transfer $DA24` = `min(cap, pct_op(a, math32_2arg(men_a,men_b)) + pct_op(b, math32_2arg(men_b,men_a)))`; `math32_2arg = a·100/(a+b)`, CERTIFIED). Moving green troops *into* an elite garrison drags its quality down — the Hire-dilution lesson applies to Move. (The 5-entry **unit-type composition** `$76A9` is a *separate* table, re-capped by `cap_arms_at_index`, not blended.)
- **Emptying the source clears its military stats** (`clear_military_stats_if_no_men`).
- **Costs no gold** (the only resource-moving command that doesn't gate on treasury).
- **"Lead them personally" relocates the CAPITAL** when moving *out of* your seat (`fief_is_daimyo_capital[src]→[dest]`, `province_ai_state[dest]=5`) — a strategic, not a numeric, effect. See ch.11 / synthesis ledger #19.

### Strategic
- **Consolidate into one strong fief, don't dribble** — each merge dilutes arms toward the average; repeated small reinforcements erode an elite stack.
- **Move is the only no-gold way to reposition force** — pairs with Send (resources) for staging before War.
- **Capital mobility = assassination defense** — relocate your seat (lead-personally Move from the capital) so `$A349` can't find the daimyo "in."

## Pact ($9C4F driver; AI price $E3A4; relation $DA4F)

> Buy peace from a rival. The price is sized to **your own treasury** (not the target's anything), the AI gates whether it even offers, and the gold is **paid to the target daimyo**. Plus a hidden Drive cost.

### Formula (vs an AI house — `prompt_diplomacy_pact $E3A4`, `ai_state==0`)
```
; the AI decides whether to offer at all:
if owner_is_weak(you) and rng(3) != 0:   refuse        ; weak players refused 2/3 of the time
if rng(skill) != 0:                       refuse        ; otherwise offered only 1-in-skill attempts
price = pct_op(your.gold, 50) + pct_op(your.gold, rng(0..49)) + 20      ; ≈ 50–99% of YOUR treasury + 20

; on the player paying (driver $9C4F):
if your.gold < price:  "You have no gold!"
else: your.gold −= price ;  target.gold += price ;  relation[$6193] := 70   ; gold goes TO the rival
```
- **Drive cost:** −1 Drive (`daimyo +2`) per attempt; **−2** if you decline the named price or are refused.
- **vs a human house** (`ai_state != 0`): the other player simply types a demand (1–9999).
- Verified: bytecode `$E3A4` matches the C line-for-line; `pct_op` is ROM-certified, so the price is emulator-grade.

## Marry ($9DC4 driver; AI dowry $E314; relation $DA7D) — *derived (sibling of Pact)*

> The strongest tie (relation 90 vs Pact's 70), capital-gated, with the harshest refusal penalty in the game.

### Formula (vs an AI house — `marriage_pact_handler $E314`, `ai_state==0`)
```
gate:  must be at your capital ($6DA2);  the AI requires your.gold > 200
if rng(skill) != 0 or (owner_is_weak(you) and rng(3) != 0):  refuse
dowry = pct_op(your.gold, rng(50..79)) + 200                  ; ≈ 50–79% of YOUR treasury + 200

; on paying:  your.gold −= dowry ; target.gold += dowry ; relation[$6193] := 90
```
- **Drive cost:** −1 Drive per attempt.
- **Refusal penalty (permanent):** `daimyo +2 (Drive) −1`, `+3 (Luck) −1`, `+4 (Charisma) −1` — you lose three core stats for the snub. (Declining the dowry after it's named costs nothing extra.)
- Flavor: rolls a composite bride-portrait (`rng%22 + 53`).

## View — spy contest ($A6C7 driver; roll $A6B3) — *derived*

> Viewing your own fiefs is free. Spying an enemy costs **10 gold** a look and runs a Luck+IQ contest.

```
if your.gold < 10:  "You have no gold!"
your.gold −= 10
roll(d) = rng(d.Luck[+3]) + d.IQ[+5]                 ; effect_view_d $A6B3
if roll(you) > roll(target) and rng(skill) == 0:  clean look          ; auto-success
elif rng(3) != 0:                                  clean look          ; 2/3 fallback
elif target is owned (ai_state != 0xFF):           "Our spy was caught"
else:                                              clean look          ; neutral target never catches
```
- **High Luck + IQ → reliable espionage.** The `rng(skill)` term makes the auto-success leg rarer at higher difficulty (another `skill_level` dial).
- Adds spying to the IQ and Luck stat-effect rows (synthesis stat table).

## 7. Hire ($A5F4 driver → Men:$A553 / Ninja:$A2D2; dilution $8BF4)

> The driver `$A5F4` prompts **"(Men/Ninja)?"** and branches: **Men → `effect_hire_men` ($A553)** (the recruit-soldiers formula below, animation **id 33**); **Ninja → `$A2D2`** (the *sabotage*-mission menu — Uprising/Revolt/Dams/Assassin/Arson, animation id 12 — the same subsystem **Bribe** uses, NOT recruitment). The per-man gold cost uses `gold_men_hire_rate` ($6E11), which **re-rolls every turn** (market-rate table) — so hiring is cheaper some seasons.

### Recruit base stats (random per hire)
```
morale_base = rng(0..19) + 40    ; range 40-59
skill_base  = rng(0..19) + 60    ; range 60-79
arms_base   = rng(0..9)  + 50    ; range 50-59
```

### Dilution (weighted average)
```
new_stat = min(cap, pct_op(stat, 100·w / (w + new_men)) + pct_op(recruit_stat | 1, 100·new_men / (w + new_men)))
; w = current men for morale and skill; w = the fief's current ARMS value for arms
```

`apply_hire_unit_stats` passes `fief->arms` as the weight of the arms blend. So arms follow their own value, not the head count: arms 300 taking 100 recruits ends at 238 (a men weight of 100 would give 177), and a fief at arms 0 goes straight to the recruit's 51-59 on one man. The two percentages truncate, so they can sum to 99.

### Verified empirically (Fall 1566, fief 6 hired 30 men):
- Pre: men=55, morale=111, skill=590, arms=70
- Post: men=85, morale=88, skill=401, arms=66
- Fitted through `pct_op`: recruit morale 52-55, skill 68-71, arms 56-59, all inside their bands. A men weight for arms tops out at 64 here, so this capture rules it out. (The fit by plain division gave skill 54.5, outside its band, and blamed batched hires. It was the arithmetic.)

### Strategic note
- **Train > Hire for elite armies** (no dilution)
- **Hire early when current stats are low** (recruits don't drag down much)
- **Hire restores body count** after combat losses

## Dam ($9B7E driver; √output helper $87D8; apply $887D)

> The last open economic formula. It is **not** in `$87D8` (that sub, mislabeled "effect_dam", is just `sqrt(output)` — returns 10000 if output==0). The dam math is computed **inline in the driver $9B7E** and applied through `add_effect_gain_clamped` ($887D, shared with Build).

```
; preconditions
if output == 0:  "you have no peasants"          ; can't dam undeveloped land
if dams  >= 100: "we're at our limit"            ; dams is the ONLY 0-100-capped province stat
if gold  == 0:   "you have no gold"

sqrt      = int_sqrt(output)                      ; $87D8
max_spend = min( gold, (100 − dams) × sqrt ÷ 2 )  ; the spend cap = exactly enough to reach dams 100
amount    = number_input(cap = max_spend)
gold     −= amount
gain      = max(1, ⌊ 2 × amount ÷ sqrt ⌋)         ; INVERSELY proportional to √output
dams     += gain                                  ; helper_dam_rounding: war-halves, then caps at 100
```

- **Gain is inversely proportional to √output** — a developed fief pays far more gold per dam point. The spend cap is exactly the amount that lifts dams to 100.
- **Why dams matter**: the rice harvest multiplies `output × dams` (§4 rice formula), so Dam is a rice-yield multiplier; ROI rises with output. Dam beats Grow for rice once `output² > ~38 × dams` (an early estimate; synthesis-frontier #17 has the (6−skill)·dams crossover, an open reconcile).
- **Verified**: bytecode + `dam-mikawa` capture (Tokugawa output=254 → √=15, spent all 424 gold → dams 39 → 95 = +56; `⌊848/15⌋ = 56` exact). See [dam.html](./commands/dam.html).
- **Source bytecode**: driver $9B7E; helpers $87D8 (√output), $887D (apply+cap), animation id 21.

## Tax ($999A driver; `effect_tax` $82D6)

```
delta    = old_tax − new_tax                        ; the driver's order ($9A41)
loyalty  = effect_tax(loyalty, delta)
wealth   = effect_tax(wealth,  delta)

effect_tax(stat, d) = d < 0 ? stat − pct_op(stat, |d|)  ; RAISING the tax drains
                            : stat + pct_op(stat, d)    ; CUTTING it adds the same amount
```

- **Symmetric, not a penalty both ways.** A raise of |Δ| points takes ⌊stat·|Δ|/100⌋ from loyalty and wealth; a cut of Δ points gives ⌊stat·Δ/100⌋ back. Charisma moves the other way (−1 on a raise, +1 on a cut; see [tax.html](./commands/tax.html)).
- **Checked against the ROM** 2026-11-02 (`na1sim.oracle` case `tax_drain`, 48/48, raises and cuts; the planted drain-both-ways model fails it). The May capture was a single raise (20 → 50), which a drain-both-ways formula also fits; that was the formula na1sim and the notes carried until this check.

## 8. Daimyo passive aging

Daimyo records ($752F+, 7 bytes each: age, H, D, L, Ch, IQ, status) — daimyo stats DRIFT UP each season turnover, independent of Train command:
- Drive +1-2 per season (observed daimyos 1, 2)
- Health +1-2 per season (observed daimyo 2)
- Charisma +1 per season (observed daimyos 2, 16)

So Train command ACCELERATES what would happen anyway. The drift might be conditional on age/health (younger daimyos grow faster?).

**These May observations are not explained by the aging routine.** That routine (§10) raises age and lowers health by 1 a year and changes no other daimyo byte, and luck drifts by §10's rule. A rise in Drive or Health comes from elsewhere, or the observation was wrong; it has not been traced.

## 9. Event system

The disaster / uprising / illness / death catalogue — with each event's season, trigger, exact probability, and result — is **[Appendix D — The Event System](./appendix-events.md)** (bytecode-walked). The economic hooks those events touch (the harvest, the AI subsidy, army upkeep) are §4 above.

## 10. Upkeep, luck, the Spring pass, revolts, the auction, the battle bribe

Read from the C, then run against the ROM with every draw scripted (table below). `rng(n)` is `rng_mod(n)`, 0..n-1.

**Army upkeep** (`consume_province_army_upkeep` $A15B): `upkeep = men/2`, taken from gold and rice. If `min(gold, rice) < upkeep`, upkeep is that minimum and `men = 2 × min(gold, rice)`.

**Every season** (`per_period_fief_daimyo_update_driver` $A30D), for each index: `luck += rng(11) − 5` on a byte with no clamp, and a fief taxed at `90 − skill_level` or more loses a tenth of its loyalty (`pct_op(loyalty, 90)`). The turn planner then runs `cap_fief_stats` over every fief, which resets a wrapped luck (above 235 → 0) and holds it to 210.

**Spring, once a year** (`per_turn_age_daimyo_decay_health_and_province_stats`, season 0 of that driver): age +1 and health −1 on every record up to `fief_count + 3`, living or not. An AI fief takes the boon (Appendix D). A human fief, past skill level 1, loses **one** `rng(skill_level)` from **loyalty, wealth and morale** alike. In 1560 none of this runs; instead a human on fief 16 (17 fiefs) or fief 24 (50 fiefs) has that fief's gold set to 100.

**A revolt** (`uprising_rebels_win_roll` $9595): the loyal share of the men is `min(morale, 100)·3/10 + min(charisma, 200)·3/20 + rng(31) + 10` percent, by `pct_op`. The larger side wins; a tie goes to the rebels on `rng(2) = 0`. So at morale 100 and charisma 200 the loyal share is 70-100%, and at 0 and 0 it is 10-40%, so the rebels always win there. If the loyal men win, morale rises by `pct_op(morale, rng(10) + 30) + rng(30) + 30` and men fall by `pct_op(men, rng(20) + 10)`.

**The auction of an ownerless fief** (`auction_ownerless_fief_to_bidders` $8C75): the bidders are the neighbours, one per owner. Fewer than 2 owners around it, or no bid, and a new daimyo takes the fief. Each bidder acts from its owner's first capital. An AI bids `rng(gold)`, but only if its gold beats the current bid. A human who is not resting and has gold is asked, and types 1..gold. The highest bid wins, **but the winner pays the last bid made, not its own**: `bid` is one variable that nothing resets, so a later, lower bid sets the price, and a bidder who passes leaves it standing. The price never exceeds the winning bid. A human late in the order can therefore bid 1 and cut the price a rival pays. A human winner's new fief starts at state 5, an AI's at 0, never a capital.

**The bribe in battle** (`resolve_bribe_enemy_unit` $9E73; not the strategic Bribe command): the gold is spent first, win or lose. `score = rng(6 − skill_level) + own morale + own charisma`, against `enemy = enemy morale + enemy charisma + 2·skill_level`. A loss, or a bribe already made this turn (`combat_casualty_skip_flag`), ends it there. On a win, if the gold covers a man each (`amount / unit ≥ 1`), `pct_op(unit, 100·(s−e) / (2s−e))` men cross to the briber's slot 0, the briber's total held to 9999. If it does not, the enemy loses morale instead: `6 − skill_level` from a human briber, `skill_level` from the AI, floored at 0. Both set the flag.

**Give** (`driver_give` $AA1F, `give_transfer_apply`): gold and rice give alike. To peasants, the whole amount goes into loyalty **and** wealth (§ the develop family), each doubled; to men, into morale. Nothing else pays for it, where Grow cuts loyalty and dams and Build cuts wealth. Every Give adds 1 charisma. It is refused with no output (peasants) or no men, with nothing to give, and at the limit: `(wealth + loyalty) / 2 ≥ stat_cap` for peasants, `morale ≥ stat_cap` for men.

**The harvest order** (`harvest_income_sweep_all_fiefs` $A26F): it runs in the season driver, before Fall's command, so Fall spends it. The marks are set at the start of Summer and only lowered, so a gift pays this year only if it lands before Summer; one given in Summer pays from next year. The AI-only boost is gated on `province_ai_state == 0`. Every fief starts at tax 20.

## 11. The starting boost and the attack gates

`apply_scenario_starting_stat_boosts` $83E2, AI fiefs only: the daimyo's five stats +skill x 5, gold +skill x 10, the ten fields from town to arms +skill x 5. Then, for the listed fiefs (17: 1, 2, 4, 7, 10, 15, 16; 50: 5, 9, 13, 14, 19, 21, 23, 24, 26, 38, 42, 49), a coin each: gold, loyalty, morale, men x 2, rice x 3 (x 4 at 50). Winners marry each other (relation 90). Every fief, human too, rolls its cap: `pct_op(header + 1000, rng(20) + 80)`.

An attack (`ai_commit_attack_deduct_resources` $9040) is refused if `min(defender rice, defender men) > min(2 x rice, men, gold)` of the attacker, or that budget is under 5. Against a human, a share of men above 47 skips the usual gate and coin (`ai_try_war_attack`).

## How these formulas are checked

`py -3.14 -m na1sim.oracle` (from `tools/`) runs na1sim's models (this appendix as code) against the ROM's own routines on a real save image, over a grid that crosses each input with its edges: the stat at and past `stat_cap`, a partner stat far from the stat, amounts from 1 up, every `skill_level`, tax raises and cuts. Grow, Build and Dam run as the player issues them (the driver and its guards, `number_input` answering within its own range); Give runs its effect handlers. `--plant NAME` swaps in a known-wrong model, and each must fail.

| Case | ROM routine | 2026-11-02 | Planted wrong model |
|---|---|---|---|
| grow | `driver_grow` $9D3D | 480/480 | — |
| build | `driver_build` $A853 | 480/480 | — |
| give_peasants | `develop_loyalty` $891D + `develop_wealth` $896F | 480/480 | no partner averaging: fails |
| give_men | `develop_morale` $89C1 | 480/480 | doubled gain: fails 480/480 |
| dam | `driver_dam` $9B7E | 240/240 | no 100 cap: fails |
| pct_op | $D70D | 110/110 | plain ⌊b·p/100⌋: fails |
| tax_drain | `effect_tax` $82D6 | 48/48 | drain both ways: fails |

Added 2026-11-04, the sim's own functions (`vmprims`, which the strategic loop calls) against the ROM. `rng_mod` is scripted on both sides, so a draw's edges are on the grid, and the moduli asked for are compared too: a wrong `rng(n)` or a reordered draw fails even when the values agree. Every state table is compared, not chosen fields.

| Case | ROM routine | 2026-11-04 | Planted wrong model |
|---|---|---|---|
| train | `driver_train` $A637 | 160/160 | no Luck+IQ bonus: fails 64 |
| hire | `effect_hire_men` $A553 | 432/432 | arms weighted by men: fails 352 |
| upkeep | `consume_province_army_upkeep` $A15B | 252/252 | no desertion: fails 104 |
| luck_then_cap | `drift_daimyo_luck` + `cap_fief_stats` | 35/35 | no cap: fails 6 |
| period_driver | `per_period_fief_daimyo_update_driver` $A30D | 63/63 | — |
| uprising | `uprising_rebels_win_roll` $9595 | 650/650 | the sim's old split: fails 283 |
| revolt_loyal | `resolve_revolt_event_on_listed_fiefs` $9778 | 27/27 | — |
| spring | the Spring routine | 68/68 | decay on men, or `rng(2)`: each fails 16 |
| auction | `dedup_owners` + the auction | 341/341 | the winner pays its own bid: fails 76 |
| bribe | `resolve_bribe_enemy_unit` $9E73 | 385/385 | skill_level as the morale cost for both: fails 72 |
| give | `driver_give` $AA1F | 578/578 | no +1 charisma: fails 253 |
| harvest | `harvest_income_sweep_all_fiefs` $A26F | 648/648 | the AI's boost given to the player: fails 324 |
| riot_eligible, revolt_eligible | `ai_event_eligibility_check_*` | 3840/3840 each | no 1-in-4 gate: fails 3456 |
| riot_contest | `resolve_riot_uprising_contest` | 90/90 | — |
| riot_human | `resolve_riot_event_on_listed_fiefs` | 384/384 | the payment read as a Give: fails 72 |
| rebel_spawn | `spawn_uprising_force_from_province` | 720/720 | half the men: fails all |
| ai_state0 | `ai_econ_action_state0` | 200/200 | no arms bump: fails 100 |
| buy_rice | `effect_buy_rice` $A068 | 180/180 | no rate nudge: fails 135 |

Two notes this check overturned: the human decay is `rng(skill_level)` on morale, not `rng(2)` on men (a summary of the C, wrong on both). And the printed C is not evaluation order: `pct_op(morale, rng_mod(10) + 30) + rng_mod(30) + 30` draws the `rng_mod(30)` first.

This check found three formulas that had each passed an in-game capture: Give-Men (the capture's men ≈ morale hid the averaging, and a `2×` had crept in), the tax direction (the capture was a raise), and `pct_op` (the observed drains fit the plain percentage too). A capture checks one point. Not yet covered: Train and Hire (their RNG needs the lockstep `na1sim.oracle_vm` uses), Send, Trade, and the harvest, which `oracle_vm`'s harvest check covers at the routine level.

## All atomic economic formulas are verified

Every atomic/economic command is bytecode-verified — the develop family (Grow/Build/Give/Dam), Train, Send, Hire, Trade, Move, Pact, Marry, View, and the Fall harvest are all closed above or in their command pages. **Give-Men** = `develop_morale` ($89C1): `morale += ⌊amount × (6−skill_level) ÷ √(⌊(men+morale)/2⌋ + amount)⌋` (min 1, clamped to `stat_cap`): the develop-family template on the morale↔men pair, **not doubled** (`develop_loyalty` / `develop_wealth` write `gain << 1`; `develop_morale` writes `gain`). Checked 2026-11-02 by running the ROM's `$89C1` with men varied (men 200 / morale 66 / amount 50 → +19; men 500 / morale 10 / amount 40 → +11), which the 2026-05-27 capture could not separate (men 62 ≈ morale 66). The earlier `2 ×` here was wrong.

The per-command HTML walkthroughs (driver flow + bytecode-validated formula + embedded from-ROM animation) live in [commands/](./commands/) — `grow` `build` `give` `train` `tax` `send` `hire` `dam`.
