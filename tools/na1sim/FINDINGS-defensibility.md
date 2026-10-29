# na1sim — fief defensibility findings (2026-06-20)

Experiments run on the bit-exact tactical engine (`tactical.py`, oracle 19/19 +
full-battle emulator lockstep) and the off-screen resolver (`game.resolve_siege`,
`$8DFD`). Reproduce with `tools/na1sim/experiments.py`.

## Method
- **Metric:** the attacker:defender **men ratio at which the defender holds 50%** of
  the time ("50% ratio"). Higher = more defensible.
- **Protocol:** defender FIXED at 200 men (kills small-unit noise; Chris's call),
  rice = men. Unless noted, all **8 stats equal both sides** (so the strength
  formula's stat terms cancel and only men/terrain remain). Attacker men swept;
  the tactical sim's setup/movement RNG turns the threshold into a probability curve
  (50–100 games/cell). Off-screen is deterministic (binary-searched threshold).
- **Stat level is irrelevant** when equal: STAT=60 and STAT=100 give identical
  results to ±0.00 on every fief. The baseline is a pure (terrain × direction ×
  men-ratio) signal.

## Factor hierarchy (what actually decides a battle)
Ablation on Iga (flat→+castle→+full terrain):

| factor | swing in the 50% ratio | nature |
|---|:---:|---|
| **Men ratio** | the whole axis | dominant |
| **Home-ground bonus** (formula bit-7 base-doubling) | ~**1.55** base | uniform — every defender gets it |
| **Surrounding terrain** | **−0.13 … +0.60** | THE differentiator between fiefs |
| **Castle (the seat)** | ~**+0.15** | uniform — every fief has one |
| **All 8 stats combined (tactical)** | ≤ **0.17**, and only if you flip the whole block | weakest lever |

`defensibility ≈ 1.55 (home-bonus) + ~0.15 (castle) + terrain(−0.13…+0.60)`.
The home-bonus sets the *level*; **terrain sets the *variance*** — and it cuts both
ways (Shinano/Mino terrain is a net *liability*, below a bare castle).

## Tactical terrain ranking (equal stats, per accessible approach)
Approach is **adjacency-gated** (a fief is only attacked from where it has real
neighbours; the arena rect = the attacker's entry strip, by strategic-map bearing).
Defensibility is therefore a **(fief × direction)** property; the realistic number is
the WORST accessible approach (the attacker picks it).

| Fief | by direction | worst | spread | terrain feature |
|---|---|:---:|:---:|---|
| Mikawa | N2.07 **W2.50** E2.03 | **2.03** | 0.47 | water moat (row of `~`), garrison behind it — fortress every side |
| Settsu | S1.96 E1.90 | 1.90 | 0.06 | |
| Musashi | N1.81 W1.89 | 1.81 | 0.08 | |
| Echizen | S1.78 E1.75 | 1.75 | 0.03 | |
| **Echigo** | **S2.23** W1.69 | **1.69** | **0.53** | mountain wall — fortress from S, bare castle from W |
| Iga | W1.78 E1.67 | 1.67 | 0.11 | open field — a bare castle (Chris: "Iga is vacant, only the castle") |
| … (most fiefs) | | ~1.65–1.72 | | plain-castle baseline |
| Iseshima | N1.74 W1.60 E1.62 | 1.60 | 0.14 | split arena |
| Shinano | S1.70 W1.67 **E1.58** | **1.58** | 0.12 | dense forest/mtn fragments the defence (Chris's "split the defender in 2") |

Big spreads (Echigo 0.53, Mikawa 0.47, Omi 0.29) = the value of *predicting the
attack direction*; a defender who knew the bearing could pre-position.

## Conquest cost: the full attacker-men band (not just the 50% point)
The headline "50% ratio" is a **coin-flip**, not a conquest cost. Sweeping attacker men
finely (worst approach, 120 games/cell, `experiments.py curve`) gives the whole
probability curve — i.e. how many EQUAL-stat attackers it takes to *actually* take 200
defenders, at 50% / 90% / 99% confidence (men = ratio × 200):

| Fief (worst dir) | win 50% | win 90% | win 99%* |
|---|:---:|:---:|:---:|
| **Mikawa** E | 410 (2.05×) | **542 (2.71×)** | 593 (2.97×) |
| Musashi N | 379 (1.90×) | 414 (2.07×) | 446 |
| Settsu E | 375 (1.88×) | 400 (2.00×) | 445 |
| Echigo W | 343 (1.72×) | 389 (1.95×) | 399 |
| Iga E | 329 (1.65×) | 368 (1.84×) | 396 |
| Shinano E | 322 (1.61×) | 375 (1.88×) | 420 |
| Yamashiro E | 320 (1.60×) | 346 (1.73×) | 388 |

\*99% column is noisy (120 games → ±1% resolution; a lone fluke hold moves it). Trust 50/90.

**The S-curve is Lanchester-tight, and terrain sets its *width*.** The base curve is the
defender's built-in home-ground advantage; for a *flat* fief it is a near-vertical cliff —
the whole "play" zone is ~100 men wide, and past ~1.9–2.0× the outcome is deterministic:

```
Iga (bare castle):  300 men 98% hold → 350 16% → 400  0%   (cliff at 1.75×)
Echigo (mtn wall):  300     100%     → 350 43% → 400  1%   (same cliff)
```

**Tough terrain WIDENS the band** — it doesn't just shift the 50% point up. Mikawa's water
moat keeps deployment luck live far past its coin-flip, a genuine fat tail:
```
Mikawa:  400 men 55% hold → 450 32% → 500 24% → 550 8% → 600 0%
```
A Mikawa defender holds at **2.5:1 a quarter of the time** — battles a pure ratio model
calls unwinnable. So terrain converts a deterministic ratio-war into a real gamble (the
NA1 echo of the Battleship symmetry-breaking point). But the effect is bounded: even
Mikawa is certain by ~3:1. **Net: Lanchester dominates; terrain is a width dial on a
tight S-curve, not an escape from it.**

## Tactical defense WINS the battle, LOSES the war (the attrition trap)
Does the tactical defensive advantage change strategic OUTCOMES? **No — it inverts
them.** Combat A/B (`game.py combat_ab`, same seeds/AI, off-screen vs all-tactical,
20 seeds × 22 yr) shows tactical combat **consolidates the map FASTER** (avg living
factions @1581: 9.9 auto → 6.7 tactical) and drops survival across the board —
*hardest for the terrain fortresses*: Tokugawa/Mikawa −30% (95→65%), Hojo/Musashi −35%,
Uesugi/Echigo −25% (and dies earlier, med Y1572→Y1566). The "terrain helps survival"
hypothesis is REJECTED.

**Mechanism — confirmed by code-read AND measurement (`experiments.py attrition`):**
the two resolvers destroy men at completely different rates.
- **Off-screen ($8DFD) is near-bloodless and additive:** the winner keeps its men *plus
  half the loser's* (`_conquest` tot = c_men + d_men//2; the hold path = d_men + c_men//2).
  Net men destroyed = a **flat ~100 (half the loser's committed), ratio-independent**. A
  fief that holds at 1:1 *gains* men (200 → 300).
- **Tactical garrisons the fief with the actual survivors** of a ≤30-day grind
  (`tactical.py:1353`, `WAR_ATTACKER_MEN + WAR_DEFENDER_MEN`), after daily melee + the
  `men//30`-per-day supply drain. Destroys **2–4× more** (220–440 men).

| Mikawa def 200 | AUTO men left / destr / hold | TAC men left / destr / hold / days |
|---|---|---|
| vs 200 (1:1) | 300 / 100 / **100%** | **119** / 281 / **100%** / 18 |
| vs 300 | 400 / 100 / 0% | 108 / 392 / 100% / 24 |
| vs 600 | 700 / 100 / 0% | 479 / 321 / 0% / 21 |

**The pyrrhic-hold trap:** in the 100%-hold rows the defender *wins the battle* yet ends
gutted — Echigo holding vs 300 atk ends with **77 men** (20-day grind), then dies next
turn to any neighbour. And the bleed scales with battle LENGTH, which scales with
terrain: moat/forest fiefs (Mikawa/Owari) drag to 18–26 days, bare Iga resolves in
10–16. **Defensive terrain prolongs the fight, and the prolonging is the attrition that
kills you** — the fief inherits the survivors regardless of who owns it. Matches play
experience ("close/defensive fiefs die to the man"; the autobattler shortens battles).
Both engines are oracle-locked faithful ($8DFD 13/13, apply_conquest_outcome 19/19), so
this is real game behaviour. NB: normal AI-vs-AI play uses the gentle off-screen
resolver; the all-tactical A/B is the counterfactual — but the battles the *player*
fights are tactical, so the trap is the human's lived experience.

## The attrition trap is AI-vs-AI; the HUMAN inverts it (the player's biggest edge)
The combat A/B and the attrition table both run the **AI tactical orders for BOTH
sides** (`resolve_battle`: "no combat-policy by design"), so those numbers are the
**both-sides-dumb FLOOR**, not a player verdict. The AI's per-unit logic
(`ai_advance_units_toward_reachable_enemies` → `..._attack_or_advance`) is greedy: BFS
toward the enemies nearest the commander and melee whatever is adjacent — *no terrain
use, no chokepoint hold, no force concentration*. Two self-inflicted weaknesses:
- the **commander charges into sub-50% trades** (slot-0 threshold = 0, `:997`); only
  non-commander units with rice get the "don't make a losing trade" guard.
- **deployment is an RNG cell-scan** (`rng_search_combat_rect_for_unit_cell`) and a
  weaker defender **SPREADS** its units (`ai_advance_units_when_attacker_stronger`),
  fragmenting the defence — the AI inflicting the "split the defender in two" terrain
  weakness on itself.

So a **human defender is not bound by the suicidal setup or the charge reflex**: hold the
moat/chokepoint, mass force, and make the attacker eat the bad trades the AI walks into.
The same terrain that *hurts* an AI defender (longer grind → more `men//30` bleed) is a
*weapon* for a human (force the attacker to bleed, exit with men intact). Net: **AI-held
Echigo/Mikawa = pyrrhic grind → dogpiled; human-held = the defensibility band realised**
— the tactical layer is the player's single biggest un-modeled edge (skill compounds
here, not just economy). NB on symmetry: with "Watch AI battles" ON, AI-vs-AI *also* uses
the tactical resolver, so the attrition is borne by everyone equally — the honest
"accurate" mode is watch-ON (level field), and the player's tactical skill is a pure edge
on top. Quantifying that edge needs the by-design-absent combat-policy (a deliberate
defensive tactical policy) — not yet built.

## Two shapes of defensive terrain: chokepoint (acyclic) vs donut (cyclic)
The 50%-ratio ranking is a SCALAR and **conflates two topologically opposite terrains**
that play identically for the AI but oppositely for a human. The distinction is whether
the passable-tile graph contains a **cycle**:
- **Donut / circle (e.g. Echigo)** — ocean shrinks the map to ~3 rows; top & bottom rows
  passable, middle all mountain except a passable tile each edge → a closed LOOP. A cycle
  is the necessary condition to **kite**. The human lines up by the top castle, lets the
  AI deploy, then either (1) the AI exposes its leader → decapitate → quick win, or (2) it
  protects the leader → lead the greedy pursuers around the loop until the 30-day timeout.
  KEY mechanic: the supply clock (`consume_daily_battle_rice`) drains **rice, not men**
  (`men//30` rice/day) — a pure kite loses ZERO men. At timeout `BATTLE_WINNER_PROV =
  selected(attacker)` → `atk_won` False → **defender holds**, and `:1353` garrisons the
  fief with `WAR_ATTACKER_MEN + WAR_DEFENDER_MEN` = the attacker's *intact* army. You don't
  repel the invasion, you POCKET it. Constraint = the rice race: rice (≈men, burns ~men/30
  ·day) must outlast the attacker's or you lose first (`:1415`); so prep = stockpile rice,
  then run laps.
- **Chokepoint / peninsula (e.g. Mikawa moat)** — ACYCLIC, a dead-end. No loop to run, so
  the defender is cornered into contact. Best case = a lucky early leader-kill (a few units
  forward, leader holds the neck); default = line up on the peninsula and let the enemy
  grind every unit to reach the castle = the **attrition trap** above.

So the donut's value is **latent to the AI** (it has no kiting behaviour — it fights a
cycle exactly like a dead-end and throws away the free army), and 100% available to a
human. The ranking measures AI-vs-AI *melee* resolution; the HUMAN value of terrain is
governed by this cycle/acyclic property the scalar can't see. Echigo and Mikawa can share
a 50%-ratio yet be opposite fiefs for a player: cyclic = kiter's fortress, acyclic =
survivable grind.

## Strategic subordination: defense is a floor-raiser, never the strategy
All of the above is tactical and **subordinate to the one finding that dominates: don't
be a target.** The war-commit gate selects the *weakest-provisioned* fief in a neighbour's
border set and only then checks the ratio — so not-being-the-local-weakest means you are
never *selected*: the battle never happens, zero rice / men / turns spent. That strictly
dominates winning a fight, because every defended battle (even a clean kite) is pure cost.
It matters MORE for a human: the `get_province_ai_state` bypass makes the AI commit against
a human target ~2× more readily than vs another AI.

Kiting/terrain only raises the survival FLOOR, and is bounded three ways: **rice-bounded**
(each defense burns ~a fief's rice; sustained siege wins by exhaustion), **topology-bounded**
(few fiefs have the cycle), **gain-bounded** (a kite ends with you holding *your* fief — a
survival tool, not an expansion engine). So Echigo is human-winnable *despite* a tough
neighbourhood — but only because kiteability buys enough floor to then execute the normal
doctrine: get off the weakest-target list, develop, and expand only when taking the new
fief leaves BOTH fiefs above the weakest-in-border threshold. A conquest that makes either
fief the new local-weakest just relocates the target — net negative. Defensibility is
insurance; non-weakness is the policy.

## Stats: binary in tactical, proportional off-screen
Within the tactical strength formula the 8 stats are **binary** (the `W` term flags
who's higher; ties go to the defender, so 200 vs 2000 is the same as 200 vs 150):
- Each single stat ≈ **±0.02** (≈4 men); daimyo stats have **no** other tactical role.
- The co-channel `ai_province_stat_diff_term` is **dead** — `pct_op(men, diff/100)`,
  integer division, so any gap under 100 rounds to 0.
- Aggregate effect (attacker flips all 8 weights) ≤ **−0.17**, non-linear (nothing
  until the *majority* of weight flips, then it tips, then saturates).

But Skill/Arms serve real **double duty OFF-SCREEN**: `_quality = arms/2 + skill/2`
adds to strength **proportionally** in `resolve_siege`. Defender Skill 20→180 on Iga:

| def Skill | tactical | off-screen |
|:---:|:---:|:---:|
| 20 / 100 / 180 | 1.66 / 1.68 / 1.68 (flat, Δ0.02) | 1.27 / 1.47 / 1.67 (ramp, **Δ0.40**) |

Morale alone has extra *tactical* roles (the breach `$AD95` halves it at the castle;
the bribe gate `$A780`/contest `$9EC1` — bribe only fires vs a human), but its
strength impact is still one `W`-weight.

## The two resolvers are ORTHOGONAL axes of defense
The `watch_battles` switch (`ui_confirm_flag_6e7d`) swaps the basis of defense:

- **Off-screen + equal stats = 1.48 for ALL 17 fiefs** — terrain fully erased
  (`resolve_siege` never calls `read_map_cell`).
- **Off-screen + real stats ranks by QUALITY** (morale/arms/skill; morale dominates —
  Echigo 168, Musashi 156 are the standouts), NOT terrain.
- The orders barely correlate: **Owari** quality-fortress (auto #3, stats 88/90) but
  tactical pushover (#15, open map); **Mikawa** the reverse (tac #2 moat, auto #4).
  **Echigo** tops both (mountains + morale 168) — genuinely unbreakable. **Iga** is
  last in both (bare castle + worst stats 36/37/55).
- **Watching always favours the defender:** lowest tactical (1.60) > highest
  off-screen-real (1.58). So defend *watched*, attack *off-screen* — cashing in
  doc-17's "attacking is expensive (home doubling)".

To know if a fief is safe you need TWO numbers: its terrain rank (watched fights) and
its quality rank (auto-resolved ones).

## Chapter-17 corrections accumulated
1. Supply clock drains **men_total/30** per day, not rice/30.
2. The grid is **square tiles with a half-tile column stagger** (6 reachable
   neighbours), not a literal hex; the AI step is native `sub_8003 ($8003)`.
3. In the **tactical** battle the 8 stats are **binary and minor** — "Skill/IQ are
   decisive" holds only for their relative `W` *weights*, not battle impact;
   `province_stat_diff` is dead via integer `/100`.
4. Skill/Arms's **proportional** clout lives **off-screen** (`_quality`), not in the
   tactical strength formula.

## Open thread
The same `ai_sum_battle_strength` drives the AI's **decision to attack** (war-commit
gate), so stats may steer *who picks fights* even though they barely change *who
wins*. If so: off-screen quality rank predicts aggression, tactical terrain rank
predicts survival. Not yet tested.
