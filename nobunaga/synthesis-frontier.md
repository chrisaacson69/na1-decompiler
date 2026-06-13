---
status: active
created: 2026-06-11
---
# Pass 2 — Re-analysis & Synthesis (the dominance frontier)

Pass 1 is done: the decompiler is canonical and all 6 code banks are 100% grounded. This pass
**re-reads the now-legible engine to discover and correct structure, and builds the synthesis** —
the README's payoff: *bytecode → strategy counter-graph / dominance frontier*, the proof of why
optimal play degenerates to "pick the high-luck leader and assassinate everyone."

**The goal is "HOW DOES IT ALL WORK" — uncovering the hidden mechanics (Chris, 2026-06-11), NOT "what
wins."** Concretely this is: **(1) fact-check + fill out the existing chapters and command/wiki pages**
against the now-legible C (the economic mechanics were largely right; the ninja ones are being uncovered
now), **(2) go deeper** where we only scratched, and **(3) surface player-facing meta-game knowledge** —
e.g. a comprehensive *what each daimyo stat affects* reference (what to look for when rolling a character
or facing the AI). The TAS run (roll a max-stat lord, RNG-manipulate assassinations of weak neighbours,
absorb their fiefs) is the *motivating example* of why these hidden mechanics matter — it is NOT the
deliverable. Don't build the exploit; explain the engine.

Read this doc to resume — it carries the method, the verified ledger, and the frontier.

## Method (Chris, 2026-06-11)

- **Exploration AND correction — not automated verification.** The dominance thesis is the *lens*
  that makes the re-read goal-directed; it is NOT a rigid checklist to tick off. Expect to discover
  structure, not just confirm a pre-baked spine.
- **Reading the decompiled C is PRIMARY; walking the bytecode is the BACKUP** — the oracle we drop
  to when the C reads oddly, as it always should have been. `py -3 -m na1dream.vm_disasm <bank>
  --sub 0x<ADDR>` from `tools/`.
- **A single read of a load-bearing, negated formula is a SUSPECT, not a fact** (the pass-1 lesson).
  Anything that bears weight in the frontier gets confirmed against bytecode and, where it yields a
  number, certified on the emulator (`value-oracle.py` / `nobunaga_vm.py` / `econ_sim.py`).
- **Decompiler value-state: trustworthy (checked 2026-06-11, not assumed).** Bugs 1.1/1.4/1.5 fixed,
  1.3 emit-fixed + oracle-certified, 1.2 deref-subclass fixed. Residue: the hard gate is red on 3
  ext-op subs (`$8327`,`$D6B8`,`$D6DE` — raw-witness only; values certified) + one rare 1.2 subclass
  (`$8BEA`). None sit in the assassination/bribe/combat-strength logic. So the C is value-correct for
  the dominance work. Detail in tech-debt.md §1.
- **Asset labels are opportunistic.** As we hit data tables mid-read we label them (label-as-you-go),
  watching for a *general method* to uncover the whole data-bank set — secondary, not the job.
- **Label as you go + ledger every finding here** with a `[LEVEL STATUS DATE]` tag and the recovered
  expression. Only CONFIRMED facts promote into the chapters.

## The dominance lens (threads, not a checklist)

The thesis decomposes into questions the re-read answers as it goes. Current state in brackets.
- **Luck dominance** — assassination attempt-gate + empty-fief kill defense. [CONFIRMED, entry #1]
- **Charisma dominance** — assassination resolution + counterattack; bribe; harvest variance; train
  bonus. [PARTIAL — assassination leg confirmed (entry #1); bribe/harvest/train unverified]
- **Assassination as the dominant action** — cheap, removes a whole faction, no guard stat.
  [CONFIRMED mechanically, entry #1]
- **Combat = strength + supply, secondary** — 8-stat weighted compare, rice exhaustion. [from ch.14-17]
- **The AI is structurally exploitable** — monomorphic (always `ai_state==0`), attack-first cascade of
  `rng(10)` gates (`ai_econ_command_dispatch`); war target = weakest adjacent (`pick_weakest_men_fief`);
  never specializes / assassinates / uses diplomacy; defends its seat only reflexively; subsidized by the
  `const_two` dial + a harvest gold bonus. [CONFIRMED, ledger #24 + ch.12 rewrite]
- **Luck decays → early-game window** — `drift_daimyo_luck $A2ED`, called **per fief EVERY season** from `per_period_fief_daimyo_update_driver` (cadence found, ledger #24). [PARTIAL — cadence confirmed; sign/magnitude of the drift still to read in `$A2ED`]
- **Diplomacy & the relation value** — the `$6193` relation byte (0–100; Pact→70, Marry→90) is read as
  an **AI-aggression probability**: `$9422` spares an AI war-target when `rng(100) < relation` (AND the
  daimyo's `Drive < 50`); `$827C` is the ally-cooperation roll behind War's *"They are your allies!"*.
  Relations **decay each turn** (`$9103/$9139` saturating-sub, reset-if-≥100), so a pact erodes.
  [PARTIAL — readers found (ledger #20); OPEN: decay rate, the deterrence threshold, and the gold-cheese
  (see open questions)]

## Verified foundations

**Daimyo record — 7 bytes at `$752F + idx*7`** (TRIPLE-confirmed: mesen-labels.toml:118 +
`17Diamyo.txt` header + bytecode field offsets used in `$918D`):
`+0 age, +1 health, +2 drive, +3 luck, +4 charisma, +5 iq, +6 status`.
The `+1 health` byte is the daimyo's **life pool** — assassination (and illness) whittle it to 0 = death.
Scenario-start values in `17Diamyo.txt`; the strongest assassins by the entry-#1 formula are
**Tokugawa (player, L115/Ch110/IQ115)** and **Oda (L111/Ch106/IQ108)**.

---

## Ledger (newest first)

### #29 — The combat MENU walked verb-by-verb + a CORRECTION to #28's "damage formula" — 2026-06-12
Chris's focus: the per-unit tactical menu (turn loop is well-understood: each side orders units 0→4 in succession, then rice drains, next day). Ground-read the 6-verb jumptab `combat_command_jumptab $B9F8` and every handler; verb labels confirmed from `combat_command_menu_str_ptrs $B4F0` strings.
- **THE 6 VERBS (index → handler → real semantics):**
  - **[0] Move** `$A90E player_move_unit_until_placed_loop` — prompt a direction, `place_unit_at_tile_if_free`; reposition to a free in-bounds tile.
  - **[1] Attack** `$A96C player_move_unit_with_occupancy_check_loop` — step **into** an enemy-occupied tile → **`resolve_attack_apply_mutual_casualties $9E20`** (the MELEE resolver).
  - **[2] Bribe** `$A9FB combat_command_select_target_resolve_attack` (misnamed) — pick a target unit (1–5) + spend an amount of gold → **`resolve_attack_apply_casualties $9E73`**.
  - **[3] Flee** `$AAA7 combat_flee_to_fief_command` — pick a fief to retreat to; if attacker (`test_6f65_bit7`) `end_war_relocate_capital` + set dest `ai_state=5`; dispatch loop hard-codes `local11==3 → battle_over=1`.
  - **[4] Pass** `$AB37 redraw_combat_side_window` — returns 0 (consumes the unit's turn, no action).
  - **[5] View** `$AB6A prompt_hit_any_key_and_redraw_combat_screen` — roster + hit-any-key; returns 1 (re-prompts same unit).
  - Dispatch (`combat_command_dispatch_loop_per_unit $AC7F`): per slot 0–4, `do { handler } while(handler returns truthy)` (truthy = re-prompt same unit; falsy = turn consumed, advance); after each, `battle_over = check_commander_alive_both_sides` (commander-death = unit 0 gone → ends battle).
- **⛔ CORRECTION to #28: `$9E73` is NOT the player's Attack formula — it's the BRIBE/defection resolver (also the AI's attack path).** #28 walked `resolve_attack_apply_casualties $9E73` and called it "THE REAL DAMAGE FORMULA." Re-grounded: `$9E73` is called by **Bribe [2]** (`$AA9B`) and the **AI** combat path (`ai_rng_resolve_combat_apply_casualties $A721`, `$A7E4`) — NOT by the player's Attack. And its casualties **DEFECT**: `local11` men are subtracted from the enemy unit and **ADDED to the attacker's commander unit** (`unit_strength[cur][0] += local11`, `side_resource[cur]+4 += local11`). So `$9E73` = "spend gold/surplus → enemy men switch sides," a morale+Charisma+rng contest (the `+2·const_two` favors the defender) — the #28 write-up of that contest is the BRIBE math, not melee.
- **THE REAL ATTACK (melee) = `resolve_attack_apply_mutual_casualties $9E20` — MUTUAL proportional attrition.** `p = calc_battle_strength_pct_one_side(enemy)` (0..100 = attacker's share of combined strength); YOUR unit loses `(100−p)%` (`apply_pct_reduction_to_unit_strength(cur, slot, 100−p)`), ENEMY loses `p%`. Return 0 if p==50, 1 if p>50 (you won the exchange), 2 if p<50. Both sides bleed every exchange — there is no "free" attack. (`reduce_defending_province_town_chaos` also halves the town/`$7005` value when fighting on a town/castle cell — bit 8 — "the town is in complete chaos.")
- **THE STRENGTH CORE `ai_eval_battle_strength_total $9C88` (shared by melee + the AI heuristic) consumes — answering Chris's "is terrain more than passable?": YES.** `base_strength(men) + [attacker-bit ? +base again] + ai_terrain_strength_term (TERRAIN feeds combat power — where the 16-byte terrain_attr_table $B11E records get consumed) + ai_province_stat_diff_term (morale/skill/arms differential) + ai_strength_term_gated_table_word (the 3-type Rifles/Infantry/Cavalry MATCHUP, takes BOTH units' types) + ai_score_strength_term_40pct (the 40% 8-stat term from #28) + pct_op(base, prior_contest_count·20) (+20% momentum per prior contest this turn)`, then `× (province is AI/granted ? (115−const_two·15) : 100)%`. `calc_battle_strength_pct_one_side` = `math32_2arg(my_total, enemy_total)` (≈ `my·100/(my+enemy)`, the share-percent — CERTIFY the exact op).
- **BRIBE — THE EXACT FORMULA (`resolve_attack_apply_casualties $9E73`, primitives ROM-certified: `math32_2arg(a,b)=a·100/(a+b)`, `pct_op(a,b)=a·b/100`, `rng_mod(n)=rng%n` uniform 0..n−1, daimyo `+4`=Charisma, `const_two`=skill 1–5 from `number_input(1,5)`).** Bribe is COMMANDER-ONLY (`cur_combat_unit_slot==0`; non-0 slots rejected). You pick an enemy unit (1–5) and an amount of gold `g` from 1..budget, where **budget = your_gold − your_men** (`side_resource[+0]=gold, [+4]=men`). The gold `g` is **deducted in full immediately**, win or lose. Then a contest:
  - **att_score = `rng(0..5−skill)` + your_fief_morale (`$7013`) + your_daimyo_Charisma**
  - **def_score = enemy_fief_morale + enemy_daimyo_Charisma + `2·skill`**
  - **Gate 1 (the roll):** proceeds only if **att_score > def_score** (strict) AND not already resolved this side-turn (`combat_casualty_skip_flag_7bf3`). Fail → nothing happens (gold already spent, "no effect").
  - **Gate 2 (the gold threshold):** `g / enemy_unit_men` (integer) must be **> 0**, i.e. **you must spend ≥ the enemy unit's man-count (1 gold per soldier).** ⚠ The ratio's *magnitude is never used again* — **overpaying past `enemy_men` buys NOTHING.** Below threshold → no defection, only a morale chip: `enemy_morale −= (you ? 6−skill : skill)` (and you still lose `g`).
  - **The payoff (both gates pass): defectors = `enemy_men × (att−def)/(2·att−def)`** [= `pct_op(enemy_men, math32_2arg(att−def, att))`], capped so your total men ≤ 9999. Those men **leave the enemy unit and JOIN your commander unit** (`unit_strength[cur][0] += defectors`) — you are literally buying troops.
  - **ANSWERS to Chris's Qs:** (1) *How much gold?* — exactly `enemy_unit_men` is optimal; less = wasted on a morale nick, more = wasted entirely. (2) *The roll?* — only the attacker's `rng(0..5−skill)` is random (vanishes to 0 at skill 5); defender gets a flat `+2·skill` → **bribing is far weaker at high difficulty.** (3) *Morale so high it's ineffective?* — **YES:** if `enemy_morale+enemy_Cha+2·skill ≥ your_morale+your_Cha+rng`, the bribe fails outright. And even on success a single bribe defects **at most ~50%** of a unit (fraction `(att−def)/(2·att−def)` → 0.5 only when def_score=0). High-morale + high-Charisma defenders are bribe-proof; only the commander can bribe, one resolution per side per day. **[Emulator-grade modulo the `side_resource` field offsets — confirm `[+0]=gold,[+4]=men`.]**
- **★ THE FULL ATTACK FORMULA — "what makes an army strong" (all sub-terms read; weights bytecode-confirmed).** Melee `$9E20` does mutual attrition on `p = calc_battle_strength_pct_one_side = math32_2arg(S_you, S_enemy) = S_you·100/(S_you+S_enemy)` (you lose `(100−p)%`, enemy loses `p%`). Each side's per-unit **effective strength S** (`ai_eval_battle_strength_total $9C88`, `m` = unit men):
  ```
  S = ( m                                              // base men
      + (your side is the DEFENDER ? m : 0)            // +100% HOME bonus — war_side_state_flag bit7 (test_6f65_bit7) is on the DEFENDER, not the attacker [EMULATOR-CORRECTED 2026-06-13, see run #1]
      + terrain_bonus                                  // = m · mult/100 · 3   (ai_terrain_strength_term $9BB4)
      + province_stat_diff                             // Σ over fief skill/arms/(+24): if yours>enemy, += m·(Δ/100)/100·3   (small; ai_province_stat_diff_term)
      + (wrap(your_slot) > wrap(enemy_slot) ? m : 0)   // +100%  — unit position/type advantage (ai_strength_term_gated_table_word; wrap: slots 0,1,2,3,4→0,1,2,0,0)
      + m·(1 + 0.4·W/100)                              // the 8-STAT term (ai_score_strength_term_40pct) — NOTE this re-adds one ·m
      + m·0.2·(enemy_unit's prior-contest count)       // +20% momentum per prior exchange this turn (7BEE counter)
      ) × difficulty_scale
  difficulty_scale = (your fief is AI-Home state0) ? 100% : (115 − 15·skill)%   // player/Granted fiefs: skill1=100% … skill5=40%
  ```
  - **W = Σ weights of the 8 stats you BEAT the enemy on** (`ai_sum_battle_strength`, into `$7BEA[0]=attacker-wins / [1]=defender-wins`; **bytecode-confirmed alignment via the pre-increment idiom**): daimyo **health 5, drive 10, luck 10, charisma 5, iq 20**; fief **morale 10, skill/training 25, arms 15** (Σ=100 → win-all = +40% S). The decisive stats are **fief SKILL/training (25) and daimyo IQ (20)**; charisma & health are the WEAKEST here (5 each — charisma's combat value is in BRIBE, not strength). Skill & arms ALSO re-enter via `province_stat_diff` → they double-dip. **ARMS triple-duty (Chris):** beyond the two combat terms, last session established that a fief's **arms count caps the % of the army that can be RIFLES** — so arms gates your access to the strongest unit type AND feeds strength directly. **★ THE UNIFICATION (Chris flagged as the surprise): `ai_sum_battle_strength` is NOT just the AI's attack-decision heuristic (#28's framing) — the SAME 8-stat contest machinery is baked into the real resolver** (`ai_eval_battle_strength_total` calls it and folds `$7BEA[side]` into every unit's strength via the 40% term). So the AI's "is that fief weak enough to attack?" scorer and the actual battle engine share one stat-comparison core — and that core pulls in **all five daimyo personal stats**, not just the fief's military stats. Refines #28: the 8-stat heuristic is a *component of* the resolver, not separate from it.
  - **TERRAIN multipliers** (`terrain_strength_mult_table $B9C2`, term = `m·mult/100·3`, so bonus = +2.7m / +0.6m / +0.3m / 0): cell `&254`: **bit32 → 90 (+270%!)**, bit16 → 20 (+60%), **bit8 → 10 (+30%)**, else(128/4/64/plains) → 0. Grounded reads on the bits: **bit32 = castle/fortification** (an attacker standing on it = "breached" → `halve_defender_morale_for_breaching_attackers`), **bit8 = town** (fighting here triggers "the town is in complete chaos" + halves the town value), **bits 64 & 128 = IMPASSABLE** (`is_map_cell_blocked` tests mask 194 = bits 1/6/7). So terrain is FAR more than passable/not — a castle cell nearly quadruples a unit. **bit16 (+60%) = FOREST** (Chris: it's the only passable terrain left once castle/town/plains/and the two impassable water+mountain are accounted for — a clean by-elimination ID). (The +24 fief stat in the diff term still wants a confirm.)
  - **UNIT TYPES (`unit_type_name_table $F9AF` = Rifles/Infntry/Cavalry).** slot→type = `(wrap(slot)+1)%3`: slot0→Infntry, slot1→Cavalry, slot2→Rifles, slots3/4→Infntry. The matchup term gives **+100% m to whichever unit sits in the higher wrap(slot)** (2>1>0) — a fixed hierarchy (Rifles-slot2 > Cavalry-slot1 > Infntry), NOT cyclic rock-paper-scissors. So types/positions matter, but as a ladder.
  - **⚠ THE DIFFICULTY HANDICAP (big, certify direction on emulator): AI Home(0) fiefs compute at 100%; PLAYER Direct(5)/Granted(1–4) fiefs at `(115−15·skill)%` → 40% at skill 5.** Only bites player-vs-AI (player-vs-player cancels in the ratio; AI-vs-AI both 100%). Consistent with the established difficulty-dial subsidy/tax pattern (#11/#24 Spring rubber-band) — a hidden combat tax on the player that grows with difficulty.
  - **NET "strong army" ranking:** men (base, counted ~2×+) → terrain (castle = +270%, the single biggest lever) → DEFENDER home bonus (+100%, see correction below — combat favors the defender) → unit-position advantage (+100%) → win the stat contest (+≤40%, dominated by training & IQ) → momentum (+20%/exchange) → minus the player difficulty tax. **Primitives ROM-certified; weights bytecode-confirmed; EMULATOR-CERTIFY the difficulty-scale direction + the casualty amounts.**

### #30 — EMULATOR RUN #1: Oda(Owari fief16) → Mino(fief8), 17-fief, watched tactical battle — 2026-06-13
First live battle via `tools/lua/combat-certify.lua` (Mesen frame-poll of the unit-men array + full input snapshot). Log: assets/Saves/MinoBattle.txt. (The many spurious "BATTLE START"s = the per-fief AI "scope enemies" eval setting `battle_defending_province`; real fight = the men-changing block.)
- **SIDE MAPPING NAILED (`get_battle_side_province $838F`): side 0 = `selected_province_idx` = ATTACKER; side 1 = `battle_defending_province` = DEFENDER.** Log: side0 (Oda) deployed 25/22/16/8/8 = 79 men (war_attacker_men split); side1 (Mino) 5/5/5/5/5 = 25 (home garrison split).
- **✅ MUTUAL ATTRITION CONFIRMED.** Each Oda attack (`cur_combat_side=0`): the Mino (enemy) unit loses **p%**, the Oda (attacking) unit loses **(100−p)%**, sum ≈ 100. Samples: Oda16→Mino5 = Mino −4 (80%)/Oda −3 (18.8%); Oda22→Mino5 = Mino −4 (80%)/Oda −5 (22.7%); Oda17→Mino5 = Mino −4 (80%)/Oda −3 (17.6%). `p≈80%` (Oda's strength share) every exchange — lopsided matchup, stable.
- **✅ BREACH MORALE-HALVING CONFIRMED, exact:** Mino fief morale **63 → 31** mid-battle (`63/2`, integer) once an Oda unit reached the castle cell.
- **⛔ CORRECTION to #29: `test_6f65_bit7` is the DEFENDER (home) bit, NOT the attacker.** Live flags: side0/attacker `$6F65=0x1F` (units, no bit7); side1/defender `$6F66=0x9F` (bit7+units). So the strength `+base` term is a **DEFENDER HOME-GROUND doubling** → **combat FAVORS THE DEFENDER**; an attacker must overpower it (Oda did: 79 men+morale164+elite daimyo vs 25+morale63). Reverses the earlier "attacker advantage" reading.
- **Daimyo stats >100 are legit** (Oda 107/120/121/111/113) — Chris: max STARTING stats can theoretically reach ~120, so these are high base values (Oda/Nobunaga), not a bad table read (Mino's Saito reads a sane 62/52/38/48/56). 17-fief daimyo table `$752F` confirmed correct.
- **STILL OPEN (run #2):** numeric `p = S_you/(S_you+S_enemy)` needs the per-cell TERRAIN bit + ideally logging the computed `S` (add to the lua); the `115−15·skill` player difficulty tax; and the OFF-SCREEN resolver (`resolve_siege_assault_outcome`) — this run was WATCHED (tactical engine), so the off-screen path is still untested.

### #31 — EMULATOR RUN #2: Iseshima(fief12 atk) → Iga(fief11 def), 17-fief, ✅ MELEE FORMULA CERTIFIED — 2026-06-13
v2 logger (positions+momentum, spurious starts suppressed). Log: assets/Saves/IgaBattle.txt. Mostly clear-terrain battle (so the terrain MULTIPLIERS are still untested), but the rest of the strength core is now **numerically certified** by hand vs the exact casualty counts (melee is deterministic — no rng):
- **✅ Exchange #23/#24** (Iga u2 def 6 men vs Ise u4 atk 6 men, both plains): S_Iga = base6+home6+rank6+t5(6)+mom1 = **25**; S_Ise = base6+t5(8) = **14**; `p = 25·100/39 = 64`. Casualties: enemy `pct_op(6,64)+1 = 4` (obs −4), own `pct_op(6,36) = 2` (obs −2). **EXACT.**
- **✅ Exchange #29/#30** (Ise u2 atk 10 men vs Iga u0 def 8 men home, plains): S_Ise = 10+rank10+t5(14)+mom2 = **36**; S_Iga = 8+home8+t5(8) = **24**; `p = 60`. Casualties: target `pct_op(8,60)+1 = 5` (obs −5), attacker `pct_op(10,40) = 4` (obs −4). **EXACT.**
- **CONFIRMED live:** the strength terms base + DEFENDER-home(+base) + unit-rank ladder(+base if wrap(slot)>wrap(other)) + the 8-stat 40% term (`pct_op(pct_op(base,40),W)+base`, W from the won-weights — here attacker won all 8 → W0=100/W1=0) + momentum (`pct_op(base, mom·20)`); the casualty rounding `pct_op(men,pct) + (pct≥50?1:0)`; and `p = math32(S_atk,S_def) = S_atk·100/(S_atk+S_def)`. AI-vs-AI → difficulty scale = 100 (no player tax this run).
- **TOOL note:** `tools/combat-check.py` auto-checker has a terrain-position bug (resolves a non-plains tile at some logged positions → inflates S → wrong p); the HAND calcs above (t2=0) match exactly. Fix the checker's terrain lookup (stale attacker pos / row-col orientation) + log the CUR unit's position too.
- **✅ DAIMYO STAT ACCUMULATION CONFIRMED (Chris): all daimyo read ABOVE their starting values** (e.g. Iseshima's lord 120/115/111/91/93, Iga's 95/41/60/66/86) → the **+1-per-win `daimyo_stat_transfer` + AI `random_daimyo_stat_increment` ARE accruing live** (revises #30's "just high starting stats"; it's both — high starts AND ongoing growth). Stats are constant within a battle, so this didn't affect the per-exchange certification.
- **⚠ ANOMALY — TERRAIN BONUS DID NOT APPLY in melee (Chris spotted the town/castle tiles).** #29/#30 was NOT clear ground: Iga's map (mapid `$F70E[11]=0x1B`, confirmed via `fief_to_mapid`) has the **castle at (4,2)** (Iga u0 defender stood there) and the **town at (5,2)** (Ise u2 attacker). WITH the terrain term the formula predicts S_Ise=39 / S_Iga=45 → p=46 → casualties **3/6**; the game gave **5/4** = the NO-TERRAIN result (p=60). So `ai_terrain_strength_term` is effectively ZERO in the real melee — even though (a) its bytecode is correct (switch fall-through 32→90/16→20/8→10 confirmed at `$9BD3`, NOT the §1.6 defect), (b) `read_map_cell` works in combat (the run-#1 Mino breach needed `read_map_cell&32`), and (c) the map/mapid are right. **LEAD (bytecode-narrowed):** `ai_eval_battle_strength_total $9C88` bytecode DOES call+sum `ai_terrain_strength_term` ($9CC0, in the `POPR/ADD` chain $9CD2–DB), so the formula path genuinely includes terrain. The defender's castle bonus is the SMOKING GUN: had it applied (+21 → Sd 45), Iga u0 loses ~3, not the observed 5 — independent of the attacker's tile. So either (A) my OFFLINE (col,row)→cell lookup is wrong — orientation (`row*11+col` vs transposed) or the combat-grid→cell-pool mapping differs from the strategic render, so Iga u0 was actually on CLEAR ground (no anomaly, just a checker bug); or (B) terrain really is suppressed in the live melee despite the bytecode. **RESOLVE NEXT RUN:** capture the LIVE `read_map_cell` byte at each unit's position at attack time (compare to ROM), AND/OR do a deliberate attacker-INTO-castle run and watch the breach fire to cross-check the (col,row) orientation.
- **RUN #3 (Oda fief16 atk → Iseshima fief12 def, log assets/Saves/OdaIseshimaBattle.txt): PLAINS RE-CERTIFIED, terrain STILL OPEN, and a methodology fix.** Orientation re-confirmed (Iseshima castle (4,2); no attacker there → breach correctly didn't fire, defMor 77). Plains exchanges exact again (#17/18 p=59→3/1; #19/20 p=75→3/3). Castle exchanges ambiguous: #24/25 (Ise u0 castle, 3 men) inconclusive; #22/23 (Ise u0 castle, 7 men) observed (4,4) — flat predicts (5,3), full-terrain (3,7), truth BETWEEN.
- **⛔ RETRACTED: the "$8AD6 = counterattack path" idea was NOISE.** v2 logged vmpc at FRAME-END (where the VM happened to be at the poll), NOT at the write — so those PCs were meaningless and the #22/23 mis-pair couldn't be diagnosed from them. **Terrain's role in melee is cleanly UNRESOLVED** (plains all match flat; the two castle data points disagree — Iga's matched flat, Iseshima's landed between). Likely the castle exchanges were mis-paired by v2's frame-batching.
- **LOGGER v3 (write-callback based, like ai-war-logger):** catches each men write AT the write with the TRUE vmpc (casualty apply ~$9D4A), in execution order → the two halves of one exchange are consecutive = clean automatic pairing, no controlled-battle needed. Next run with v3 should resolve terrain (pairs will be unambiguous; the real vmpc separates apply vs removal vs deploy).
- **RUN #4 (Omi fief10 atk → Iseshima fief12 def [now Oda's], v3 write-callback, log OmiIseshimaBattle.txt): PLAINS re-confirmed; CASTLE exposed TWO mechanics the decompile missed.** v3 works great — accurate write PCs (`$9D4B`=apply, `$926B`=deploy) in execution order. Plains exchange #23/24 (Ise u1 vs Omi u0, both plains): p=62 → 5/2 EXACT. But:
  - **★ ASYMMETRIC DEFENSIVE TERRAIN.** The unit on the castle (Ise u0 @(4,2)) repeatedly DEALS 4–5 and TAKES only 1. (5,1) for two 8-men units is **mathematically impossible** under the symmetric `resolve_mutual` (`p` for enemy / `100−p` for cur): enemy=5 needs p∈[50,62], cur=1 needs p∈[76,87] — disjoint. Confirmed `$9E20` bytecode IS symmetric (no hidden terrain term) and `apply_pct_reduction $9D03` is clean. So terrain protects the OCCUPANT via a path OUTSIDE `resolve_mutual` — NOT the symmetric strength-term I'd modeled. The terrain-as-`ai_eval`-term may only feed the AI heuristic; the real in-combat terrain effect is a defensive casualty reduction we haven't located.
  - **THE +1 INCREASES — likely NOT reinforcement (Chris's correction).** Chris: total men only move via combat or bribe (no army-wide growth over a battle), so the +1s are most likely **deployment redistribution** (`distribute_men` rebalancing across the 5 slots, total conserved — they cluster in the early setup records) and/or the **bribe defection** that adds to the COMMANDER (unit 0) — consistent with #6 `s1u0`/#20 `s0u0` being unit-0. Walk back the "per-action reinforcement" reading; confirm by tracking the per-side TOTAL men across +1 events (should be conserved if redistribution).
  - **REVISES the terrain story:** plains melee = the certified symmetric formula (men + home + rank + 8-stat-40% + momentum, p=share). Terrain & reinforcement are ADDITIONAL combat-loop mechanics not in the per-exchange strength math. Static decompile missed both — emulation found them.
- **UNIT-RANK / COMMANDER CHECK (Chris):** the rank term gives `+base` to the higher wrap(slot) (2>1>0); slot 2 = Rifles gets it, but slot 0 = the COMMANDER = Infantry gets wrap=0 = NO rank bonus. Verify that's intended (the commander/Infantry forgoes the positional bonus that Rifles/Cavalry get) and not a slot↔type mislabel in `draw_unit_type_label`.
- **RUN #5 (Yamato fief9 atk → Iseshima fief12 def, v4 self-checking logger): TERRAIN DOES NOT AFFECT MELEE CASUALTIES — the "asymmetric defensive" anomaly was a PAIRING/SCRIPT ARTIFACT.** v4 computes the flat (no-terrain) prediction live. Result: every TARGET-loss exchange matches flat EXACTLY, **including forest-vs-forest** (#10: Yamato u2 (4,for) vs Ise u1 (3,for,home), p=54 → −2/−2). The apparent `DIFF -2` lines were all the CUR's OWN-loss records, where the script wrongly computed strength self-vs-self (Scur=Schg→p=50); plugging the exchange's real p (54) makes the own-losses match too (`pct_op(4,46)=1`, `pct_op(6,46)=2` — all exact). So the earlier #4 "castle occupant deals 5/takes 1 = impossible" was my MANUAL mis-pairing of the same own-loss/target confusion, NOT a real terrain effect. **Conclusion: `ai_terrain_strength_term` feeds only the AI attack-decision heuristic; the live melee casualty math has NO terrain term** (consistent with the symmetric `$9E20`/`$9D03` bytecode). Still want ONE clean castle-OCCUPANT fight to nail it 100% (this battle's castle cells held only deploys/+1s, no occupant exchange), but forest=no-effect + the bytecode make terrain-in-melee very unlikely. v4 self-check bug FIXED (predict on the target write, confirm the cur's own-loss against it).
- **RUN #6 (Yamashiro fief13 atk → Yamato fief9 def, v4 self-check FIXED) — RE-OPENS terrain; run #5's "no effect" was PREMATURE.** With the own-loss bug fixed, complex multi-terrain exchanges show real DIFFs the flat formula does NOT explain (±1–2): #13 castle→forest target −1 (flat −3); #15 forest→forest target −4 (flat −2, DIFF **+2**); own-losses consistently −1 under flat. Hand-check of #15: defender took 4 → needs p≈67, but flat gives p=45 and a forest strength-boost only reaches ~46 → **neither flat nor a simple terrain term explains it.** Also #14: the castle defender GAINED +1 right after attacking → the mystery +1 happens MID-COMBAT and corrupts the men used in prediction. So: **the flat formula is exact only on SIMPLE, low-contest exchanges; it diverges in complex battles, cause UNRESOLVED** (candidates: the momentum term's exact form, the +1 mechanic, or a real terrain effect). Run #5's clean forest match was a low-complexity coincidence — do not treat terrain as resolved either way.
- **RUN #7 (v5 dual-prediction: flat vs +terrain) — ✅ TERRAIN CONFIRMED IN MELEE. The original full formula was right; "flat" was my error.** v5 dumps each unit's S term breakdown and predicts under BOTH flat and +terrain. On castle exchanges the +terrain model wins decisively on BOTH halves:
  - #15: cur(clear) → defender on CASTLE. Castle adds `terr=12` (`pct_op(5,90)·3`) to the defender's S, flipping p 60→46. `flat: target −4 ✗ / own −2 ✗` ; `+terr: target −2 OK / own −4 OK` (#16). Both halves match +terr, neither matches flat.
  - #17/#18: castle defender attacks → own-loss `flat −2 ✗ / +terr −1 OK`.
  So `ai_terrain_strength_term` (castle +270%, forest +60%, town +30% of men, ·via `terrain_strength_mult_table`) DOES feed the live melee strength — exactly the bytecode. **This resolves the saga: the run-#4 "tanky castle" was REAL; runs #4–#6 failed only because I predicted FLAT (omitting terrain) and mis-paired own-losses.** The melee formula is: `S = men + DEFENDER-home + unit-rank + 8stat-40% + momentum + TERRAIN`; `p = S_atk/(S_atk+S_def)`; casualties `pct_op(men,pct)+(pct≥50?1:0)`.
  - **Residual ±1 noise** on some exchanges is the deploy/combat WRITE-INTERLEAVE (#13: `cur base=0` because its deploy write landed AFTER the exchange) and small-unit rounding/momentum — NOT a formula gap. (Not script lag: write callbacks are synchronous.)
- **RUN #8 (Shinano fief15 atk → Mino fief8 def [Oda's]) — TERRAIN RULE NOT a simple symmetric term; SCRIPT RELIABILITY is now the blocker (Chris distrusts the tool, correctly).** This run contradicts run-#7's "symmetric +terrain confirmed": #17 castle on the TARGET (attacked) → +terr matches, flat misses (castle reduced the target's losses); #23 castle on the CUR (attacker) → FLAT matches, +terr over-predicts (castle did NOT boost the attacker's output). So the leading hypothesis is now a **DEFENSIVE terrain bonus — it helps the unit being ATTACKED, not the one attacking** (reconciles #7's #15 + #8's #17 vs #23). BUT #18 (forest cur took MORE than flat) muddies it, and the script can't be trusted to settle it because of:
  - **Deploy/combat WRITE-INTERLEAVE**: exchanges fire before a unit's deploy write (e.g. #19 `cur base=0`, deploy at #20) → poisoned men → garbage prediction. Not all 5v5 deploys are cleanly captured before combat starts.
  - **The mystery mid-combat `+1`** changing men used in S.
  - **Low fidelity** on 1-man units (predictions collapse to one rounding bucket).
- **DON'T re-flip the terrain conclusion again.** STABLE & TRUE across all runs: terrain DOES affect melee (every castle/forest exchange diverges from the flat no-terrain prediction). UNRESOLVED: the exact rule (defensive-to-the-attacked-unit is the current best read, NOT the symmetric strength-term). **BLOCKER: harden the logger first** — (a) guard against exchanges whose units were just deploy/+1-written (flag/skip), (b) track per-side TOTAL men to classify the +1 (conservation = redistribution), (c) flag low-fidelity (≤~2-man) exchanges. Then re-run on a high-men battle.
- **PAUSED 2026-06-13.** Combat CORE formula (men+home+rank+8stat40+momentum) = certified on clean exchanges. Terrain = affects melee, rule OPEN (defensive-bonus hypothesis), script-hardening-gated. Off-screen resolver + player tax still untested.
- **NEXT:** (a) locate the defensive terrain casualty-reduction (re-read `validate_phase_unit_cells_draw_cursor $9B4A` at the top of `resolve_mutual`, `ai_select_unit_combat_action`, the move handlers — NOT in `resolve_mutual`/`apply_pct_reduction` themselves, both confirmed clean/symmetric); (b) verify the +1 = redistribution by tracking per-side total men; (c) confirm the unit-rank/commander bonus; (d) more castle/forest data; (e) OFF-SCREEN resolver (watch OFF); (f) player difficulty tax.
- **STAGE-5 = BATTLE CLEANUP — WALKED (`dispatch_battle_resolution $AF3B` → two cleanup calls).** Resolution announces the outcome, then runs succession + conquest.
  - **A. Succession / daimyo-death (`transfer_owned_fiefs_and_announce_succession $AE2C`).** If a capital fell, `announce_daimyo_death`; the fallen lord's ENTIRE holdings are enumerated and announced "fief NN has passed from lord X to lord Y"; AI elimination tracked via `increment_ai_player_count`.
  - **B. Resource disposition (`apply_conquest_outcome $E03C`) — CHRIS'S "men/rice/gold → the fief?" CONFIRMED, and richer:** the conquered fief (`battle_defending_province*26+0x7001`) receives the **SUM of BOTH sides' survivors**: `gold = war_attacker_gold + war_defender_gold` (`+0`), `rice = att+def` (`+6`), `men = att+def` (`+16`). So the winning army **garrisons the captured fief with everything that survived from both sides — your men move FORWARD into the conquest, they do NOT return home** (a real strategic cost: winning relocates your force).
  - **`transfer_force_triplet $DF73`** — the conquered fief's morale/skill/arms (`$7013/15/17`) become a **men-weighted blend** of attacker vs defender (`scaled_force_transfer`, weighted by `war_attacker_men`/`war_defender_men`).
  - **`cap_arms_at_index $DFFE`** — rifles re-capped to the NEW arms level (**rifle cap = `arms/50 + 20`**; excess rifles in `$76AB` spill back to `$76A9`). The arms→rifle-cap (Chris) is enforced post-conquest too — and this is the exact cap formula.
  - **`daimyo_stat_transfer $DF3D` — battles PERMANENTLY shift daimyo stats: the WINNER's daimyo +1 Drive/Charisma/IQ (record `+2/+4/+5`); the LOSER's daimyo −1 each.** (A feedback loop: winners snowball their personal stats, losers decay — independent of the AI-only `random_daimyo_stat_increment`.)
  - **Faction absorption:** if the capital fell (`test_6f65_bit7(local9)`) → `reassign_fiefs_to_conqueror $DEC1` transfers ALL the loser's fiefs to the victor, clears capital flags, each inheriting `ai_state(attacker)?5:0` (re-confirms #27: player conquest → Direct(5)). Single-fief win: `fief_owner[def]=attacker; ai_state[def]=ai_state(attacker)?5:0`.
  - **Extras:** `clamp_field_6d2d_to_30` caps the conquered daimyo's tax rates at 30; `cap_fief_stats` clamps both fiefs; **uprising case** (`selected_province_idx==50`): the rebel "attacker" contributes nothing and the fief takes a **10–20% loyalty hit** (`pct_op(loy, rng(10)+10)`).
  - **★ OFF-SCREEN RESOLUTION — there are TWO different combat formulas (Chris's question).** An AI-vs-AI battle (AI invasion OR uprising) is gated at bank-1 `$9130`: **`if (ui_confirm_flag_6e7d || ai_state(defender)==5)`** → run the full tactical engine (`ai_turn_loop_redispatch_flag=1` → master loop `call_bank_wrap(2)` → `battle_init_driver`, both sides AI-played); **ELSE** (watch-battles OFF and the player isn't the defender) → **skip bank 2 entirely** and call the abstract one-shot resolver **`resolve_siege_assault_outcome $8DFD` (bank 1).**
    - **The off-screen strength formula is SIMPLER & DIFFERENT:** `strength = men·(2 + [attacker-bit | defender-is-capital]) + arms + skill + morale`, then **+10% morale to whichever daimyo has higher DRIVE** (record `+2`). Higher strength wins (single comparison, no day-loop). The loser's surviving men split (winner absorbs ½); capital capture rolls a **Drive-based escape** (`rng(drive/10)` → flee to another fief vs die); outcome → `announce_daimyo_death`; then it calls **the SAME `apply_conquest_outcome`** (men/rice/gold sum into the fief, faction absorption, daimyo ±stat, rifle cap — cleanup is shared).
    - **So among daimyo stats, ONLY DRIVE matters off-screen** — vs the tactical engine's full 8-stat contest (all 5 daimyo stats), terrain, unit-type ladder, and momentum. **CONSEQUENCE (emulator-testable, possibly exploitable): the "Watch Battles" setting changes which formula resolves AI-vs-AI wars** — ON routes them through the men+terrain+stats tactical sim (AI plays both sides), OFF through this men-dominated abstraction — so a purely cosmetic-looking option can alter how the strategic map evolves.
  - **TWO POSITIONAL MECHANICS (Chris's follow-ups):**
    - **Castle breach halves morale (`halve_defender_morale_for_breaching_attackers $AD86`, run at the TOP of every combat day).** Scans the attacker's 5 units; the first one found standing on a **Castle cell (bit 32)** → **defender fief morale `= morale/2`** (then break) + "morale is falling." Because it re-fires each day the castle is held, morale **decays geometrically** (50%→25%→…). Morale is load-bearing (the weight-10 stat in the strength contest + a flat strength add + the bribe-defense score), so a breach rapidly collapses the garrison. This is the payoff for reaching the castle tile.
    - **Town chaos is a PER-EXCHANGE town-value reduction, NOT an end-of-battle one-shot (`reduce_defending_province_town_chaos $9DA8`, called from the melee resolver on EVERY attack).** If either combatant's cell has **bit 8 (town)** → "the town is in complete chaos" and the fief's **town/commerce value (`$7005`)** is cut: `c = casualties/2; town -= pct_op(town, math32_2arg(c, town−c))·10` (saturating to 0). The arithmetic folds to a drop of ≈ **5× that exchange's casualties** each time. So repeated fighting on the town tile progressively razes commerce — a bloody town capture leaves it economically gutted. (The ·10 digit-math wants an emulator spot-check.)
  - **BANK 2 / COMBAT ENGINE = STRUCTURALLY COMPLETE** (both the watched tactical engine AND the off-screen `resolve_siege_assault_outcome` sibling). Remaining = emulator certification only: the casualty amounts, the `115−15·skill` player difficulty-scale direction, the bribe `side_resource [+0]/[+4]` offsets, and the off-screen-vs-tactical outcome divergence.

### #28 — COMBAT opened (bank 2): the 8-stat strength formula + supply + the unit-type ambiguity — 2026-06-12
First walk of the combat bank (its own bank, bank 2; entry `effect_war_a` bank 1 → bank 2). Grounding the ch.14 trace-map against the decompiled C.
- **THE STRENGTH FORMULA (`ai_sum_battle_strength $8E5C`) is the AI's ATTACK-DECISION HEURISTIC, NOT the combat resolver (Chris, 2026-06-12).** It compares **8 stats**: 5 daimyo (health/drive/luck/charisma/iq, +1..+5) + 3 fief (morale+18/skill+20/arms+22), winner of each taking its `battle_strength_stat_weights` weight into `$7BEA[side]`; side score = `men × (1 + 0.4 × stat%)` (`ai_score_strength_term_40pct`); `ai_attacker_outstrengths_defender` = `score(att) > score(def)`. **Chris: this does NOT predict actual combat** — the real outcome is the per-round casualty math (below, to be walked). → **EXPLOIT FODDER:** the gap between this heuristic and the real resolution means you can *look* strong (game the 8 stats to deter/bait the AI) vs *be* strong (game what the casualty math actually rewards) — two different optimizations.
- **UNIT MODEL (Chris-corrected): 3 TYPES, up to 5 UNITS in FIXED POSITIONS.** Each of the ≤5 slots has a **fixed type** (Rifles/Infntry/Cavalry, the `(wrap_0_2(slot)+1)%3` mapping in `draw_unit_type_label`); **Assign distributes the men-% across the slots** (`render_arms_edit_screen` over the 5-entry `$76A9`); **0% is allowed for every slot except #1 (the commander).** `distribute_men_into_unit_strengths $91D5` splits total men by those %s. So *not* "5 types" — 3 types in 5 fixed-position slots. (Treat the toml's "5 unit types" label as loose.)
- **SUPPLY / the DOUGHNUT (confirmed).** `consume_daily_battle_rice` drains each side's rice every combat day (≈`rice/30` + remainder carry, hitting the strength when starved); `side_has_rice_for_day` gates another day on remaining rice. So a defender who avoids battle **starves the attacker out** → "you have no rice!" (ch.14's doughnut, now mechanized). Exact tick rate (rice/30 vs the /15 day-check) wants a clean read.
- **CAPITAL RELOCATES ON A WIN** (`end_war_relocate_capital`): conquering relocates the victor's capital flag to the conquered fief — ties to the mobile-seat thread (ledger #19) and the conquest-state inheritance (ledger #27: conquered fief = `ai_state(attacker)?5:0`).
- **Tactical layer:** 5 verbs (Attack/Bribe/Flee/Pass/View, `combat_command_menu_input_loop`); a 5×11 tile grid (`is_tile_in_bounds`: x≤10,y≤4); per-unit move/attack; 4 endings (commander-killed / exhausted-morale / no-rice / annihilation) + retreat.
**TOP-DOWN WALK (Chris's method: setup → menu → terrain → formulas; treat NOTHING as fact). Spine = `battle_init_driver $AFE1`:**
```
SETUP:  map_populate (terrain) → render → battle_init_defender (read defended fief's
        gold/rice/men; if rice≤0 OR men≤0 → undefended → INSTANT resolution, no battle;
        else split men into the ≤5 slots) → deploy_both_sides_units_loop (deployment)
DAY LOOP (max 30 days, $B05B): if a side's strength ≤0 → resolution(4) annihilation;
        run_both_sides_combat_turn(day) → if it returns nonzero, resolve; else
        consume_daily_battle_rice (supply tick) → day++
RESOLVE: dispatch_battle_resolution(code)   [3 = 30-day timeout (selected/attacker set
        as winner_sel), 4 = annihilation, 7/8 = defender had no rice/men]
```
- **Combat is capped at 30 DAYS**; rice drains once per day — the doughnut has a hard clock (outlast 30 days OR starve the attacker's rice → he leaves).
- **STAGE-1 SETUP — the "4 setup restrictions" DEBUNK Pass-1's "4 round outcomes" (Chris was right it was misinfo).** `set_combat_arena_rect_by_approach` restricts the **ATTACKER** to a 4-deep edge band by approach direction (from the strategic-map fief positions): **N→rows0-2 (code1), S→rows2-4 (code2), W→cols0-3 (code3), E→cols7-10 (code4)** on the 11×5 (x≤10,y≤4) grid. The **DEFENDER deploys anywhere** → a real positional edge. AI places via `ai_place_combat_units_random_or_smart`; the player via `player_interactive_unit_move_loop`.
- **STAGE-2 TERRAIN (one step at a time).** `map_populate $8903` builds the 11×5 grid (each cell → a 4×4 metatile block in the `$7BFD` staging buffer). Per-cell terrain = `lookup_terrain_attr_record` → `read_map_cell & 254` maps the bitmask `32/16/8/128/4/64 → terrain index 0..5` → a **16-byte record in `terrain_attr_table $B11E`** (6 terrain types; **the record fields = the combat modifiers are still UNANALYZED** — extract them where the day loop consumes them). The per-cell data is a **per-fief 55-byte map** (11×5) in `tactical_map_cell_pool $A57E` (bank 4), selected by `province_to_mapid_table $F70E` — every fief has its own baked tactical map (the doughnut/chokepoint topology). Water/border = `map_water_cell_tile`.
- **STAGE-3 THE DAY (`run_both_sides_combat_turn $ADD1`).** Each day: (1) `halve_defender_morale_for_breaching_attackers` — if attackers have **breached**, the defender's morale is **halved** (a positional/castle mechanic); (2) each side acts in `cur_combat_side` order — **AI → `ai_run_all_units_combat_actions`**, **player → `combat_command_dispatch_loop_per_unit`** (the per-unit 5-verb menu); (3) returns nonzero when the battle resolves. Both paths converge on per-unit attacks → the casualty math (the REAL damage formula, next).
- **STAGE-4 THE MENU = 6 VERBS (ch.14 missed "Move").** `combat_command_menu_str_ptrs` = **Move / Attack / Bribe / Flee / Pass / View** (`combat_command_dispatch_loop_per_unit`: per unit slot 0–4, pick a verb via `combat_command_jumptab`; a handler returning truthy re-prompts the same unit, falsy advances; **verb 3 = Flee ends the battle**; commander-death also ends it).
- **STAGE-4 THE REAL DAMAGE FORMULA (`resolve_attack_apply_casualties $9E73`) — and it is NOT the 8-stat heuristic (proves Chris's point).** Each attack exchange is a contest:
  - **attacker_score = `rng(6−const_two) + attacker.morale(fief +18) + attacker.daimyo.Charisma(+4)`**
  - **defender_score = `defender.morale + defender.daimyo.Charisma + 2·const_two`**
  - If `attacker_score > defender_score`: **defender-unit casualties = `defender_unit_strength × (margin / attacker_score)`** where `margin = attacker_score − defender_score` (`pct_op(strength, math32_2arg(margin, attacker_score))`), capped at 9999; else just a **morale chip** (`defender.morale −= attacker-is-AI ? (6−skill) : skill`).
  - **So actual combat is a MORALE + CHARISMA contest** (+ an rng and a difficulty term that **favors the DEFENDER**, `+2·skill`) — NOT the `ai_sum_battle_strength` heuristic (which weighs all 8 stats incl. health/luck/iq/drive). **THE EXPLOIT, grounded:** the AI decides to attack on the 8-stat *look*, but battles are decided by **morale + charisma**. Pump morale (feed troops, ledger #26) + a high-Charisma lord → win battles the AI thinks it can take; conversely a high-luck/iq lord *looks* strong to the AI heuristic but may fold in the real exchange.
  - **⚠ NEEDS EMULATOR CERTIFICATION** (this area had the most Pass-1 misinfo): the casualty *amount* bookkeeping (the `arg2 / defender_strength` divide; the `+local11` write back to the attacker's unit-0/resource; the side_resource `+4` field) reads murkily from the decompiler — derive the exact casualty count on the emulator before promoting to a chapter. The CONTEST (morale+cha+rng vs morale+cha+2·skill) and the difficulty-favors-defender direction are clear. A second path `resolve_attack_apply_mutual_casualties` (head-on clashes, `calc_battle_strength_pct_one_side`) splits casualties both ways — to walk next.
- **NEXT:** the second casualty path + terrain's 16-byte modifier consumption + the Bribe/Move/Flee verb handlers; then an emulator harness to certify the casualty numbers. Treat ch.14-17 + toml as suspect throughout.

### #27 — The ACTION-ECONOMY asymmetry + Grant policies = alternate AI behaviors (Chris's threads) — 2026-06-12
Chris's follow-ups cracked open the biggest AI advantage and the real meaning of Grant.
- **THE ACTION-ECONOMY ASYMMETRY (the headline).** Player `issue_province_command` = *"Your orders?"* → pick ONE command → the loop breaks as soon as a command **consumes the turn** (returns 1). So the **player gets ONE action per fief-turn** (info looks are free). The AI's `ai_econ_action_state0` runs the **whole `ai_econ_command_dispatch` cascade** — recruit + feed + arm + train + (town + dam + grow) + trade — **plus** `random_daimyo_stat_increment` **plus** a 25% arms bump: **~6–8 sub-actions in ONE fief-turn.** So Chris's "free action" instinct is exactly right — the AI's train/trade/recruit/develop are all *bundled free* into one turn. This is a **structural action-economy advantage** independent of the stat subsidies — arguably the main reason the AI keeps pace. Kept exploitable only because each AI action is **small** (surplus-bounded) and **unstrategized** (random tax, never Assign, weakest-target wars): broad-but-shallow vs the player's one focused, optimized move.
- **"Same routine as the player" was WRONG.** The AI calls the player's **effect handlers** (`effect_grow`/`effect_dam`/`effect_train`/`effect_send`) but **not** the player's **drivers** (no prompts; it self-sizes via the surplus). And it never touches some player verbs at all (Assign). Same *effects*, totally different orchestration + a different action economy.
- **GRANT POLICIES = alternate AI behaviors = how the player buys back the action economy.** Each Grant state runs ONE handler per turn, multi-action within its focus: **Industrial(1)** `ai_develop_town_handler` (town+trade+tax), **Military(2)** `ai_state2_recruit_arm_train` (war+recruit/arm/train), **Farming(4)** `ai_develop_dam_and_grow` (dam+grow), **Balanced(3)** the full cascade (NO subsidies), **Direct(5)** = player manual (1 action). So Granting trades manual control for **AI-style multi-action throughput** in one focus.
- **Home(0) is strictly better than Balanced(3)** — Home = cascade + 10% daimyo-stat-boost + 25% arms-bonus + the Spring boon (ledger #24); Balanced = cascade only, and (state≠0) it takes the Spring decay.
- **⛔ CORRECTION (Chris, 2026-06-12) — the PLAYER CANNOT GET HOME(0) FIEFS.** My earlier "leave conquered fiefs at Home" was WRONG. **Conquest inherits the ATTACKER's state:** `apply_conquest_outcome $E194` and `reassign_fiefs_to_conqueror $DF2B` both set `ai_state(conquered) = ai_state(attacker) ? 5 : 0`. The player always attacks from a Direct(5) or granted(1–4) fief (all nonzero) → **every player conquest, single or whole-faction-absorption, comes out Direct(5)** — you micro it (or Grant it to 1–4). The player starts with one Direct fief and has **no Home(0) bootstrap**, so player fiefs are *only ever* 5 or 1–4 — **never 0**. (The "victory {Home 33,...}" were AI/unconquered fiefs, not the player's.) "You conquer the way you fight": attack from a hands-on fief → a hands-on prize.
  - **This makes the asymmetry STARKER:** the AI's fiefs are all Home(0) = full cascade + ALL subsidies; the player's are Direct(5) (1 action, no subsidy, takes Spring decay) or granted(1–4) (focused, no subsidy, decay). **The player can never replicate the AI's multi-action-Home-with-subsidies mode** — and conquest *adds Direct fiefs to micro*, so the action-economy burden GROWS with the player's success while the AI auto-manages.
- **The daimyo stat-bump is AI-ONLY and holdings-scaled (Chris).** `random_daimyo_stat_increment` is gated `ai_state==0` with **no capital gate** — so it rolls on *every* Home fief a daimyo owns (a sprawling AI daimyo balloons), and since the player never owns a state-0 fief, **the player's daimyo never gets it** (stats fixed at roll, only drained by marry/events). Pure AI subsidy that snowballs with AI conquest.
- **The market IS moved by AI trading.** Each AI rice trade nudges the global `$6E0B` rate ±1 (`cycle_economy_rate`), accumulating intra-year, reset by the yearly reroll. With many fiefs trading (75% of develop turns), the rate drifts — likely **net-down from AI rice-selling to fund development**, so AI activity tends to make rice cheap for the player. (Quantify: an emulator sweep of the rate over a year.)
- **THE GAME CLOCK (Chris: "the hire mechanic sets a real clock").** Hire/develop caps scale with the year: men cap `(year−1559)·40`, town `(year−1559)·100+100`, grow `(year−1559)·50+250`. The AI is **weak early, strong late** — a built-in escalation that, with the early Luck-assassination window, is the engine's "**win early**" pressure. The hire clock is the spine of it.

### #26 — The AI turn, top to bottom (decision order · probabilities · stat influence) — 2026-06-12
Chris's brief: a full top-to-bottom walk of the AI's turn — order, odds, and whether daimyo stats move them. Written into ch.12 as "The AI turn, top to bottom." Findings:
- **Decision order (`ai_econ_command_dispatch`):** seed rice if 0 → token-garrison an undefended capital → **~90% MILITARY** (war→recruit→arm→train), STOP if it acted → else **~90% develop town + ALWAYS dam/grow**. Attack-first, build-second.
- **The probabilities:** military entry `rng(10)≠0` (~90%); recruit `rng(10)<const_two+3` (≈(skill+3)/10, **rises with difficulty**); town `rng(3)≠0` (2/3); train `rng(2)` (50%); reinforce `rng(100)==0` (1%); war commit needs a men-ratio advantage (`ratio−10−rng(skill·3)>60`) or 1/100.
- **Spend-sizing without a prompt:** `ai_calc_men_surplus = {gold−men, rice−men}` (clamped ≥0) — the AI keeps a reserve = its army size, spends the surplus; caps scale with the **game year** (AI strengthens as the campaign ages). It even **plays the rice market**.
- **War targeting (`ai_try_war_attack`):** target = **weakest enemy by *provisioned* men** (`pick_weakest_men_fief`; a fief with no rice = 0 men → starved fiefs are magnets); needs men AND rice to attack; risk-averse commit. → bank-2 combat. The "no real scorer" thesis is literally true: the scorer is men-ratio.
- **DO DAIMYO STATS ALTER THE ODDS? — only DRIVE.** The cascade reads difficulty/year/market/province-stats, **not** the daimyo's personal stats — EXCEPT **Drive = the aggression dial** (`ai_relations_and_low_drive_skip_gate`: `Drive<50` respects relations & won't attack liked fiefs; `Drive≥50` ignores them; also gates the monk-fief attack). Charisma/IQ/Luck/age/health are inert on *decisions* (they matter in combat/events/assassination). So the AI plays the same opening regardless of who the lord is; only aggression (Drive) and battle strength vary.
- **Partial answer to Q1 (what relation buys):** relation **gates AI attacks, but only for Drive<50 daimyo** — a bold (Drive≥50) lord rolls over your pacts/marriages. So diplomacy's deterrence is Drive-conditional. (Still open: the decay-vs-deterrence quantification.)
- **Tie-back noted in ch.12 for combat (ch.14-17):** AI wars (`effect_war_a`) and uprisings (`spawn_uprising_force`) both resolve in **bank 2**; combat should close the men-ratio/`$8EB8` strength compare (Drive re-enters), rice/supply exhaustion, and the uprising-attacker resolution.

**DEEPER PASS (Chris pushed — the first walk was too shallow), 2026-06-12:**
- **The cascade is NOT military-XOR-develop.** `ai_state2_recruit_arm_train` returns 1 only on a launched WAR, so the `&&` falls through: **military-prep runs ~90% of turns AND develop also runs whenever no war fired** — an AI fief does a little of everything each turn. Military spends gold FIRST.
- **WHY the AI under-develops (Chris #2):** surplus = `{gold−men, rice−men}` (reserve = army size) and the **military pass eats it first** → develop gets scraps. A big army leaves ~0 gold over `men`, so military fiefs stay economically stunted. Real, mechanism nailed.
- **WHY few wars despite 90% military (Chris #1):** entering the pass ≠ attacking; a war needs the men-ratio gate (`ratio−10−rng(skill·3)>60`) to pass — most fiefs have no soft-enough neighbour. **No per-year attack counter** — the limiter is opportunity. Flip side: a fief that goes weak (esp. starved → 0 provisioned men) gets piled on by every adjacent stronger daimyo. Weakness summons wars, not a timer.
- **TAX:** the AI never strategizes it — `ai_seed_fief_tax_rate` re-randomizes to `rng(30)+35 = 35–64` every develop turn, so AI tax **wanders 35–64** (never the 90s that self-trigger riots).
- **ASSIGN (army comp):** the AI **NEVER** uses it — `effect_assign` has only the player's `driver_assign` as caller; AI sets unit-type composition at hire only, can't re-mix. Player-only lever.
- **TRADE:** on a develop turn, 75% it rebalances surplus by price (sell rice dear / buy cheap) → moves the *global* `$6E0B` market the player shares.
- **HIRE/TRAIN:** hire when `men < min((year−1559)·40, header)` at prob `(skill+3)/10` (barely early-game, grows late); train flat 50%/military turn.
- **AI daimyo STAT GROWTH:** `random_daimyo_stat_increment` — AI fiefs only, 10%/turn, a random daimyo stat +2 (wrap 200). AI lords' stats drift UP over the campaign; the player's are fixed at roll. Another anti-player subsidy.
- **AI develop uses the player's √-curve** (`effect_grow`, the `(6−skill)` term) — not a cheat; one decompiler bookkeeping ambiguity in the AI grow (`output += spend` alongside `effect_grow`) flagged for bytecode-check.

### #25 — The EVENT SYSTEM enumerated → new appendix-events.md (the deep dive, not a glance) — 2026-06-12
Chris's push: the bank-0 glance (#24) was reconnaissance; walk the events properly. Did, and it corrected my own #24 labels. Built **`appendix-events.md`** (season · trigger · result). Findings:
- **The 75% common event is the UPRISING dispatcher (Riot/Revolt), not a "boon"** (my #24 mislabel). Two eligibility variants drive it: **RIOT = loyalty variant** (low loyalty / **high tax** / low Charisma → "The people are rebelling!", player can quell by spending) vs **REVOLT = morale variant** (low **morale**, the army stat → ownership **flips**; at an AI capital the rebels can win → `announce_daimyo_death` + `find_fiefs_of_owner` = **faction collapse, same as assassination**). Confirms Chris's "military uprising if morale too low" — it's the morale-variant revolt.
- **The "zealot" label is a confirmed MISLABEL** (Chris's suspicion). Uprising flavor is cosmetic, keyed by **fief index** (`select_message_string_by_flags_and_arg`: fiefs **7/23 → "zealots"**, **13/30 → "monks"**, else rebels/rioters). The spawner `spawn_zealot_uprising_force_from_province` serves all three → should be `spawn_uprising_force_from_province` (flagged for rename). Chris's in-game "religious zealot uprising" = a revolt that landed in fief 7/23.
- **Other events grounded (real names via `announce_seasonal_event`):** **TYPHOON** (Summer, 50%, *"Summer brings typhoons"*): `output ×= (0.9·dams)%` — **dams are typhoon insurance** (no dams → output wiped); + wealth loss. **PLAGUE** (25%, *"Lord, plague has come"*): men & output ×50–99%, **and at a capital the daimyo loses `rng(9)+1` health** (the only province event that hits a life pool). [These were my #25 mislabels "flood/ravage" — corrected to typhoon/plague when Chris asked "did we find plague?" — yes, it's the ravage event.] **Illness/sickness** (every season, `rng(400)<100−health`, "has taken ill") is a SEPARATE personal event. **Natural death** (every season, age≥70). **Aging** (Spring, age+1/health−1/yr).
- **BIG — the Spring rubber-band (BYTECODE-VERIFIED).** In the aging pass, **state-0 (AI) fiefs get a wealth/loyalty BOON** (`event_boost_province_wealth_loyalty`, 50%), while **state-≠0 (player Direct + Granted) fiefs DECAY 3 stats by `rng(const_two)`** at difficulty>1. The gates are confirmed in `$9F8C` bytecode (boost⟺ai_state==0 `$9FD8`; decay⟺ai_state!=0 & const_two!=1 `$9FF7`/`$9FFF`). So the AI is *subsidized* and the player *taxed*, scaled by difficulty — and **Granting a fief off Home(0) exposes it to the decay** (a hidden cost of delegation; leaving it at Home earns the boon instead). The exact 3 stats (all readings hit wealth +14; decompiler says wealth/men/skill, hand-trace says loyalty/wealth/morale) want an emulator diff — the structural finding doesn't depend on it.

### #24 — THE MAIN GAME LOOP grounded (bank 0): vm_bootstrap + the seasonal task rotation — 2026-06-12
Walked ch.12/13's subject in the grounded C. The turn loop lives in **bank 0** (its own bank, as Chris noted; commands=bank 1, combat=bank 2). Closes ch.13's #1 open item ("the top-level loop hides").
- **Master loop `vm_bootstrap $A778`** (bank 0): `init_new_game_state` then forever, each SEASON: (1) `ai_strategic_turn_planner` (season change); (2) `call_bank_wrap(2)` → **bank 2 combat** if a war/revolt is staged; (3) `shuffle_fief_turn_order_array` randomizes the `$6F1B` order; (4) `call_bank_wrap(1)` → `ai_per_fief_command_driver` = the **command phase** (walks `daimyo_turn_order`; player's Direct/ai_state-5 fiefs → `issue_province_command` interactive, AI fiefs → the cascade; a war launched mid-phase re-enters bank 2); (5) game-over on `ai_turn_flags` bit 7 → victory/defeat graphic. So ONE driver dispatches player-or-AI by `province_ai_state` (ch.13's structural guess, now grounded).
- **`ai_strategic_turn_planner $A455` (season change):** deferred SRAM save (`write_sram_save_checksum_and_signature`, the Other→Save flag); advance `current_season` (`&3`, 4/year) → **at the year wrap: `current_game_year++` + `roll_period_market_rates`**; `per_period_fief_daimyo_update_driver`; cap all stats; pick + fire ONE random event (~7.5%/fief); illness sweep (low-health daimyo: `rng(400) < 100−health` → flagged, "has taken ill").
- **THE SEASONAL TASK ROTATION** (`per_period_fief_daimyo_update_driver` → `switch(current_season)`): **S0 = aging** (`per_turn_age_daimyo_decay_health_and_province_stats`), **S1 = highwater marks**, **S2 = HARVEST** (`harvest_income_sweep_all_fiefs`), **S3 = relations decay** (`normalize_relations_matrix_lower`). Plus EVERY season: `drift_daimyo_luck` per fief + `check_and_process_daimyo_natural_death` per fief. So harvest is **annual (Fall)**, relations decay **annual (Winter)**, aging **annual (Spring)**; Luck drift + death checks are **per-season**.
- **The Fall harvest (`harvest_income_sweep_all_fiefs`):** per fief — if loyalty>0, `gold += calc_fief_gold_income`, `rice += calc_fief_rice_income` (appendix §4, tax%-scaled); **AI/Home fiefs (ai_state==0) get a bonus `event_boost_province_gold_output`** (economic rubber-banding — the AI is subsidized); **debt auto-repays from harvested gold** (`repay_province_debt_from_gold`); armies eat upkeep (`consume_province_army_upkeep`). A fief in full revolt (loyalty 0) earns nothing.
- **Events (`ai_strategic_turn_planner`):** one per season by RNG — see the new **`appendix-events.md`** (ledger #25). [Correction to my first glance: the 75% branch is the **uprising dispatcher (Riot/Revolt)**, NOT a "boon".]

**RECONCILIATIONS this forces (fixing earlier ledger/doc claims):**
- **Market rates reroll YEARLY, not per-season** (`roll_period_market_rates` only at the year wrap) → fix the Trade docs (ledger #23 / appendix / trade.html said "each season").
- **The per-turn loyalty decay fires at HIGH tax, not low** (`per_period_fief_daimyo_update_driver`: `tax ≥ 90−skill → loyalty ×0.9`) → **resolves ledger #17's open `$A32A` puzzle** (the "fires at LOW tax — counterintuitive" read was inverted; it's a high-tax penalty, every season).
- **Relations decay is ANNUAL (Winter, season 3)**, not per-turn → refine ledger #20 (a Pact's 70 erodes once/year, far slower than implied; deterrence lasts longer).
- **Luck drifts EVERY season** (`drift_daimyo_luck`, 4×/year) → the "Luck decay → early-game window" thread now has its cadence (sign/magnitude still to read in `$A2ED`).

### #23 — Trade: a global commodity/credit market with real synthesis impacts — 2026-06-12
The last non-combat command, and the richest (Chris: "simple interface, lots of impacts"). `driver_trade $A1B6` → 6 services via `jumptab_b9dc`. Market prices = the **period-rolled rate table `$6E0B`** (5 entries, re-rolled once per **year** by `roll_period_market_rates $924A` — see #24), which **also drifts ±1 per transaction** (`cycle_economy_rate`). Helpers CERTIFIED: `ratio_times10_capped = min(⌊a·10/rate⌋,cap)`, `math32_muladddiv = ⌈rate·N/10⌉` → rates are stored ×10 (price = rate/10).
- **Presence (`effect_trade $8A15`):** always at the two commercial capitals (fiefs **13/14**, or 30/32 at 50-fief); elsewhere only when `ai_turn_flags & 1` (set per-turn at prob **(55−5·skill)%** — ~45% at skill 2, rarer at higher difficulty). A concrete reason to hold Kyoto/Sakai.
- **Credit (Loan `$9F04` / Repay `$9FAF`):** borrow against **town collateral** — debt ceiling = `town`; borrowing N gives `gold+=N` but `debt += ⌈(loan_rate+10)·N/10⌉`. So **`loan_rate` IS the interest, baked into the gold-per-debt ratio** (`10/(loan_rate+10)` = 0.91→0.50 as loan_rate 1→10). This reconciles the toml's "sizes the loan, not interest" (it's the implicit cost). Repay is 1:1. **The only way to spend beyond your treasury** — a leverage lever for an early-game rush (borrow cheap when loan_rate is low, fund development/army, repay from harvest).
- **Rice market (Sell `$A003` / Buy `$A068`):** convert gold⟷rice at `gold_rice_exchange_rate`; selling nudges the price down, buying up. Lets you **liquidate rice for gold or stockpile rice (= combat supply) for gold** — ties the harvest economy to the war economy. Caps are the `header` ceiling.
- **Arms (`$A113`):** buy weapons; gain is **diluted by force size** (`N / math32_3arg(arms+men,5,header)`) — diminishing returns like the develop commands, and capped at `header`. An alternative arms source to Build/Train, but merchant-gated.
- **SYNTH IMPACTS:** (1) **Leverage** — loans break the treasury ceiling for a tempo rush; (2) **rice↔gold arbitrage** couples harvest and war economies, and rice doubles as combat supply; (3) the **rates are GLOBAL shared state** — `gold_men_hire_rate`/`hire_gold_rate` in the same `$6E0B` table price **Hire and Ninja** (ledger #1/#2), so the merchant table reaches the assassination economy; (4) the seasonal re-roll + per-transaction drift make **timing** a lever (borrow/buy when cheap). *(Open: quantify the period-roll distribution + whether AI trading moves the global rice price under the player.)*
- **Wiki corrections (`trade.html`):** the spec's open "precise divisor per good" follow-up is now CLOSED (÷10, certified); fixed "debt += N" → the loan-rate-scaled debt; fixed "arms += N" → the force-diluted gain; added the per-transaction price drift the spec missed.

### #22 — Grant = the player's AI-automation dial; Other = the settings, grounded — 2026-06-12
- **Grant (`driver_grant $AF66`) — benign writer, deep meaning in the turn order (Chris's framing).** Capital-gated; writes `province_ai_state[fief]` to a chosen policy. The payoff is the turn engine: `ai_per_fief_command_driver $B89B` `switch`es on the policy each turn to pick the fief's auto-action:
  | state | policy | turn-engine handler → behavior |
  |--|--|--|
  | 0 | Home | `ai_econ_action_state0`→`ai_econ_command_dispatch` — general econ (the **AI default**; conquered/AI fiefs sit here. NOT manual) |
  | 1 | Industrial | `ai_develop_town_handler` — develop town (gold) |
  | 2 | Military | `ai_state2_recruit_arm_train` — **tries `ai_try_war_attack` FIRST**, then recruit/arm/train → an autonomous aggressor |
  | 3 | Balanced | `ai_econ_command_dispatch` — general econ dispatch |
  | 4 | Farming | `ai_develop_dam_and_grow` — Dam+Grow (rice/output) |
  | 5 | Direct | `issue_province_command` — **manual player control** (your capital starts here) |
  - **Fixed a backwards wiki error:** `grant.html` had Home(0)="manual" and Direct(5)="hands-off/aggressive" — exactly inverted (0 = AI-run default, 5 = you-run-it). Also missed Military's auto-war. Now corrected from the `$B89B` switch.
  - Delegated fiefs auto-set their own tax (`ai_seed_fief_tax_rate` = rng(30)+35 = 35–64%).
  - **SYNTH ANGLE:** per the SRAM census the AI never uses states 1–4 (all AI fiefs = 0/Home) — so the themed loops are a **player automation affordance**: conquer → Grant rear fiefs Farming/Industrial to self-develop, set frontier fiefs **Military to wage war for you**, micro only your Direct capital. A late-game force multiplier the AI itself never employs (ties the **AI-exploitability** thread).
- **Other (`driver_other $B23E`) — the options menu, grounded (Chris: "iding the options is grounding for what uses them").** 7 items via `jumptab_b9e8`; the 5 settings + their variables: **Sound**→`audio_wait_gate`; **Animation**→`ai_turn_flags` bit 2 (gates every `ui_helper_e80c` command animation); **Wait**→`delay_loop_count = 2·n²` (n 1–10, times every text box); **Save**→`sram_save_pending_flag` (saves at season end); **Battle**→`ui_confirm_flag_6e7d` (gates whether AI-vs-AI battles are shown; read at `$9130` in the combat/ninja path). Index 5 = End (the only option that ends the turn), 6 = back out.

### #21 — Five atomic commands (Rest / Pass / Map / View / Assign) — 2026-06-12
Pushed out the clean-to-finish atoms. Findings:
- **View (`driver_view $A6C7`) — espionage is a Luck+IQ contest.** Your own fiefs view free; **spying an enemy costs 10 gold** per look (`selected.gold −= 10`, gated `gold < 10` → "You have no gold!"). Spy success = `effect_view_d $A6B3 = rng(daimyo.Luck[+3]) + daimyo.IQ[+5]`, **you vs target**: beat them AND `rng_mod(skill)==0` → clean; else a 2/3 fallback succeeds, the remaining 1/3 (vs an owned target) → "Our spy was caught." → **new stat-table legs: IQ and Luck both gate spying.** View also bundles the vassal list (the "99" sub-option) and the same map-browse renderer as Map.
- **Assign (`driver_assign $AD67` → `effect_assign $AC11`) — confirms ledger #12 + SYNTH BAIT.** Arms-allocation editor: needs men (`+16>0`, else "no soldiers") + **flat 30 gold**; interactive 5-unit-type redistribution over `edit_buffer` (cursor across 5 rows, a `units_delta` pool). Unit-type **row 2 is capped at `arms/50+20`** — the SAME ceiling as Move's `cap_arms_at_index`. No formula, no animation; commits via `commit_arms_record_from_buffer`.
  - **⚑ SYNTH BAIT (Chris):** row 2 = the **rifle/musket** unit type — the highest-damage class (×3 in the combat model). So the province **`arms` stat (+22) gates your rifle ceiling** (`arms/50 + 20` → at arms 100 you cap ~22% rifles, at arms 250 ~25%, …). Arms quality isn't just a battle multiplier — it **buys access to the strongest unit type**, and it's enforced in THREE places (Assign editor, Move's `cap_arms_at_index`, conquest). → a combat-economy lever for the synthesis: pump `arms` (via Build/Train? — verify) to unlock more rifles, the dominant unit. [thread: confirm the row→unit mapping + the ×3 in the damage model when ch.14-17 lands]
- **Rest (`driver_rest $ADB3`) — capital-gated multi-turn lock.** Must be at your capital (`$6DA2`, else "not home"); `rest_turns_remaining[owner] = number_input(1,10)` (per-daimyo, 1–10 seasons). The driver ONLY sets the counter — the actual recuperation (health) is applied **downstream in the per-turn tick**, not here (open thread). Cost = pure tempo (several action-slots).
- **Map (`driver_map $AF38`) — pure view, no effect, no cost.** Renders the section holding your selected fief, then an arrows-to-pan / A-to-exit browse loop (`browse_map_sections`); writes no state and **returns 0** (does not consume the turn). Uses `province_to_map_section_17/50` lookup tables.
- **Pass (`driver_pass $B2A1`) — trivial.** "What a waste" → confirm → return 1 (ends the turn). No state change. Exactly as ch.11 had it.
- **Wikis:** View spec's spy-contest pinned to the closed form (`rng(Luck)+IQ`, was "not yet pinned"); Rest/Map/Pass/Assign specs were already accurate. ch.11 + stat table updated.

### #20 — Diplomacy pair (Pact + Marry): the price scales to YOUR treasury + DRIVE is the diplomacy stat — 2026-06-12
Walked the two diplomacy atoms. Both are **fully formulaic** (ch.11 had Pact's cost as "—"; the appendix had neither) and both **pay the gold TO the target daimyo's fief** (peace is literally bought — the enemy pockets it).

- **Pact (`driver_pact $9C4F` → price `prompt_diplomacy_pact $E3A4`) — BYTECODE-CERTIFIED.** vs an AI target (`ai_state==0`): the AI **offers a pact only with probability 1/skill** (`rng_mod(const_two)==0`) AND, if you're militarily weak (`fief_owner_weakness`), refuses 2/3 of the time. When it offers, **price = `pct_op(gold,50) + pct_op(gold, rng_mod(50)) + 20` ≈ 50–99% of YOUR OWN treasury + 20.** vs a human target (`ai_state!=0`) the other player just types a demand (1–9999). Effect on accept: gold transfers to target, `set_pact_relation $DA4F` = **70**. Verified: bytecode `$E3A4` matches C line-for-line (pct_op is ROM-certified → numbers are emulator-grade).
- **Marry (`driver_marry $9DC4` → dowry `marriage_pact_handler $E314`) — DERIVED (sibling-confirmed).** Capital-gated (`show_not_home_fief` otherwise). AI dowry = `pct_op(gold, rng_mod(30)+50) + 200` ≈ **50–79% of treasury + 200**, gated on **your gold > 200**, same 1/skill-offer + weakness machinery as Pact. Effect on accept: gold→target, `set_marriage_relation $DA7D` = **90** (the strongest tie); rolls a bride portrait (`rng%22+53`).
- **DRIVE (+2) is the diplomacy-attempt currency — promotes the stat-table row from TO-VERIFY to confirmed.** Every Pact/Marry attempt costs the player daimyo **−1 Drive** (`daimyo[+2]−1`). Pact: **−2 Drive** if you decline the price or get refused. **Marry refusal is harsh — `daimyo[+2]−1 (Drive), [+3]−1 (Luck), [+4]−1 (Charisma)`** (net refused = −2 Drive, −1 Luck, −1 Charisma; permanent stat loss). Marry *decline* (after seeing the dowry) costs nothing extra. The toml daimyo-record comment already hinted "+3=LUCK … marry-drained" — now grounded in the driver.
- **CORRECTIONS found in the existing wikis:** `pact.html` claimed *"No formula … the price is read out of the relations state"* — **false** (it's a curve on your own gold, at 1/skill odds). `marry.html` said refusal drops "+3 (skill)" — **wrong, +3 is Luck**. Both fixed.
- **Synthesis read (TENSIONED — see open Qs):** the price scales to your treasury (so it never feels cheap *at full coffers*), the AI gates the offer on 1/skill and refuses the weak, and the product is a relation number (70/90) that **decays once a year** (Winter, ledger #24). First read: a regressive sink the strong don't need and the weak can't get. BUT the price formula is **gameable** (below) and relation **does** gate AI aggression — so whether diplomacy is a dead sink or a cheap shield is genuinely open and hinges on quantifying decay-vs-deterrence.

**OPEN QUESTIONS raised by the diplomacy pair (added 2026-06-12, Chris):**
1. **What does the `relation` value actually buy?** Readers found (ledger #20 grep): `$9422` AI war-target selection spares a target when `rng(100) < relation(target,you)` AND `daimyo.Drive < 50`; `$827C` ally-cooperation roll → War's *"They are your allies!"* block; decay `$9103/$9139` each turn. OPEN: the **decay rate/period**, the effective **deterrence threshold** (is 70 enough to reliably stop a war? how many turns before it bleeds below useful?), the `order_flag` (directional vs symmetric) semantics, and whether the AI ever *raises* relation (only Pact/Marry/normalize seen). Map the full reader set + emulate a pact→decay→AI-attack-roll sequence.
2. **The gold-cheese (price ∝ current gold).** Because Pact price = `~50–99%·gold + 20`, **spending your treasury down first collapses the cost to ~20** (Grow/Build/Dam/Give convert gold→development, then Pact for pocket change — Drive, not gold, becomes the limiter). Marry is partly cheese-proof: the **floor `gold > 200` + flat `+200`** keeps its dowry ≳ 300 even at the floor. Neither the weakness gate nor the 1/skill offer odds depend on gold, so emptying the treasury doesn't reduce *availability*. → IF relation buys meaningful AI-aggression deterrence (Q1), the spend-down-then-Pact line is a **cheap defensive lever** bounded only by Drive (−1/−2 per attempt) and per-turn decay. Quantify: cost-per-turn-of-deterrence via the cheese vs. the value of the deterrence.

### #19 — ch.11 walk opens: Move deep-dive + the CAPITAL is MOBILE + Bribe is a Charisma contest — 2026-06-12
Resumed the linear chapter walk at **ch.11** (the structural "21 commands" chapter; effect formulas deferred there).
Walking the first non-economic command, **Move (`driver_move $96D1` → `effect_move $8CA5`)**, against the grounded C (`source/4-c/bank_01.c`):
- **Move = capacity-limited troop transfer between OWN fiefs.** Amount capped at `min(src.men[+16], dest.capacity[+24] − dest.men[+16])`. `effect_move` shifts `amount` men donor→target AND blends the **3 military quality stats — morale(+18)/skill(+20)/arms(+22)** — as a men-weighted average (`scaled_force_transfer $DA24` = same dilution math as Hire, capped at the `header` ceiling); `clear_military_stats_if_no_men(src)` zeroes them if the source is emptied; `cap_arms_at_index` separately re-caps the 5-entry unit-type-composition table `$76A9` (the thing Assign edits — distinct from the quality stats). Precondition `effect_war_combat_prep_b` = "you have no soldiers" gate (src.men>0).
- **HEADLINE — the daimyo's CAPITAL is a MOBILE flag.** Move's *"Will you lead them personally"* (`$9757`, offered only when **src IS the capital AND lord not too-weak** — `fief_is_daimyo_capital[src] && !fief_owner_weakness(src)`) does `fief_is_daimyo_capital[src]=0; [dest]=1; province_ai_state[dest]=5`. **The lord physically relocates his seat.** ch.11 line 19 called this merely "a combat modifier" — the real mechanic is moving the capital.
- **Capital representation reconciled (closes a ledger-#1 imprecision).** The seat is **`fief_is_daimyo_capital` = `$6DA2`** (a per-fief 0/1 flag; census-confirmed bijection: exactly one capital per living daimyo). DISTINCT from `province_ai_state` = `$6CF7` (the Grant governance byte: 0=Home,1=Industrial,2=Military,3=Balanced,4=Farming,**5=Direct**,0xFF=unowned; census: AI fiefs all sit at 0=Home, only the player's own fief is 5=Direct). The assassination capital gate **`$A349` keys on `$6DA2`** (mission 4 only → "The daimyo is out." otherwise) — the SAME flag Move writes. So ledger #1's "capital is ai_state==0" conflated the two ninja-path gates: `$9192` (ai_state) and `$A349` (capital flag). **Synthesis consequence: assassination targets a MOVABLE seat — a player can relocate the capital (lead-personally Move from the capital) to dodge; conquest also relocates it (`apply_conquest_outcome`). NEW writer found: driver_move `$9782` is not in the $6DA2 census-comment's writer list (only conquest was).** The capital flag ALSO gives a **+1 defensive multiplier** in `ai_sum_battle_strength $8E5D` (`(capital+2)·men`) — so relocating the seat fortifies the destination too.
- **BONUS — Bribe's success gate is a CHARISMA CONTEST** (`bribe_success_check $8D02`, confirming `effect_bribe $8D4D` = gold→sqrt(gold) peasants defect from target.output → your wealth, ledger #12): success iff `your(loyalty[+12]+daimyo.Charisma[+4]) > target(loyalty + daimyo.Charisma) + rng(10)·skill` **AND** a coin flip. → **closes the "Charisma→bribe" leg the dominance lens had marked PARTIAL/unverified.** Also another `const_two`/skill difficulty-dial site (the rng penalty lands on the briber).
- **BONUS — diplomacy relation matrix** (for the Pact/Marry deep-dives next): `$6193`, a full **54-stride fief×fief matrix** (`relations_matrix_cell_addr $8C35` = `arg1*54+arg2+$6193`). `set_pact_relation $DA4F` writes **70**; `set_marriage_relation $DA7D` writes **90** (marriage > pact) into the canonical (sorted-index) cell. Concrete values for what ch.11 deferred as the "diplomacy subsystem" (which is data, not a code subsystem).

### #18 — The develop SINKS are REGRESSIVE (Chris flagged the under-examined drains) — 2026-06-11
The `pct` in Grow's `loyalty/dams -= pct_op(field, pct)` is **live-computed, not constant**:
`pct = ⌊100·gain/(gain+output)⌋/2`, capped 50. Pass-1's "20%" was a coincidence of one test fief (output≈80).
Characterized via econ_sim (Grow amount=100, skill 2): drain% = **32% @ output 40 → 21% @ 80 → 11% @ 160 →
~1% @ 800**. So the sink **punishes early development hardest and vanishes as a fief matures** (gain shrinks,
output grows). Implications for the synthesis:
- A young fief loses **~25 dams + ~25 loyalty per 100-gold Grow** (catastrophic: most of its dams + revolt-risk
  loyalty); a mature fief loses ~0. → the **Grow↔Dam rebuild loop (ledger #17) is an EARLY-GAME tax, self-
  resolving as output climbs**. At high skill it's doubly brutal (Grow 5× slower *and* drain % is output-based,
  not skill-scaled).
- Same shape = **Build's wealth drain**; **Give/Dam have NO drain** (Give's "widest command" edge).

### #17 — Tax verified + the Grow↔Dam↔skill synthesis interaction — 2026-06-11
- **Tax (verified, wiki accurate):** the command just *sets the rate* (1-100) + an immediate penalty —
  loyalty AND wealth each drain `|Δtax|%` (econ_sim: Δ20 → −20% of each), −1 charisma. The rate's real
  weight is **downstream**: it's the harvest income multiplier (`gold/rice ≈ tax% of the economic base`,
  `fief_tax_rate $6D2D`). RESOLVED (ledger #24): the per-period loyalty `×0.9` decay fires at **HIGH tax**
  (`tax ≥ 90−skill`), every season — the "LOW tax" read was inverted. Overtaxing bleeds 10% loyalty/season.
- **SYNTHESIS — the Grow↔Dam↔skill interaction (Chris):** harvest ∝ output×dams. Marginal rice/gold:
  Grow ∝ `dams·(6−skill)/√output`, Dam ∝ `√output` → **crossover output ≈ (6−skill)·dams** (skill 1 → 5×dams,
  skill 5 → 1:1). Since **Grow drains dams**, at high skill (crossover ≈ 1:1) you're forced into a
  **Grow→rebuild-Dam loop**. A genuine dominance lever for the synthesis chapter. *(TODO: reconcile —
  `dam.html` states the crossover as `output² > ~38·dams`, a different shape than this skill-linear one.)*

### #16 — Develop family deep-dive complete (Grow/Build/Give/Dam) — DONE 2026-06-11
The economic-command sweep. Each re-verified by RUNNING the (now skill-aware) `econ_sim`:
- **Grow/Build/Give** — the `(6−skill)` develop curve confirmed (Grow 76/60/46/30/14, Build 82/66/50/32/16,
  Give 50/40/30/20/10 @ skill 1-5) and the **skill-level dial surfaced** in each wiki (was framed as "≈1, ×5").
- **Dam — SKILL-IMMUNE finding:** its gain is `2·amount/√output`, NO `(6−skill)` term (econ_sim: dams +25 at
  skill 1 and 5). The one development command the difficulty dial doesn't slow → **relatively more valuable at
  high difficulty** (a real dominance lever for the synthesis). Noted in dam.html.
- All animations clean (the batch). Pages regenerated. **Next: Tax** (first non-develop economic command).

### #15 — Animation-clipping fix (run-animation.py) — DONE 2026-06-11
Goal-6 (animations). The renders came out fullscreen (256×240, mostly empty) — **root cause: the crop used
`im.getbbox()`, which keys on non-BLACK pixels, but the backdrop is palette entry 0 (grey for Grow), so
getbbox returned the whole frame → no crop.** Fixed: clip to the **sprite bounding region computed from OAM
positions** (= the bank-14 `draw_sprite_grid` window). Grow: 768×720 → 384×645 (clipped to peasant+meter);
grow.html 62KB → 52KB. Applies to ALL animations.
- **Bank-14 engine grounded** (the 4 helpers): `cutscene_delay $8003`, `draw_sprite_grid $801D` (cols×rows
  grid at base x,y — the clip rect), `run_cutscene $80AD` (script interpreter), `cutscene_table $AF80`
  (5-byte descriptors: SRAM bank + palette/CHR/script ptrs — **the asset-tag source**).
- **Crop refined:** clip to the bbox of actually-DRAWN pixels (not OAM slots — active-but-blank sprites were
  loosening it). grow 768×720 → 198×186 (×3); train 77×62; ninja 37×62; war 148×48. Tight to content.
- **BATCH DONE:** all 18 command anims re-rendered clipped + every page rebuilt, via new reusable
  `tools/batch-render-anims.py` (pulls command→anim_id from the page specs; promotes to `<command>.gif`).
- **The 5 "broken" anims — DIAGNOSED 2026-06-11 (NOT broken).** Ground-truthed `run_cutscene $80AD` + decoded
  both streams (the command stream always lives in **bank 14**, read directly from the mapped window; data is in
  the descriptor's bank 12/13/14). Command set = ASCII letters: `V`=pos+draw+delay (4 args), `D`=draw+delay (2),
  `L`=setpos, `X`=moveX, `C`=delay+CLEAR (0 args), `R/E`=loop, `S`=sound, `0x00`=terminator(→default→`return`).
  - **grow (works):** leads with `R 3 [V D D S D] E` — a loop over *varying* grid indices (0→1→2) = animation.
  - **build (flat):** `S V(grid0) C 0x00` — draw one scene, clear, **terminate**. Bytecode-confirmed: `C` takes no
    arg so the `0x00` ends it. So the bank-14 anims are a **different authoring style** (single-scene-then-clear),
    not broken. Frame 1 = the full scene (build = lumber/scaffolding), frame 2 = the clear.
  - **FIX LANDED 2026-06-11:** `run-animation.py` now drops trailing clear/blank frames (trim from the end while
    sprite-count < 30% of peak). build/hire/dam/bribe/rest → 1 clean scene frame; looped anims shed their trailing
    clear (grow 17→16, train 21→20). All 18 re-batched + pages rebuilt. **IN-GAME CONFIRMED 2026-06-11 (Chris):
    build shows the still scene + plays music — exactly the single-draw + `S` sound + terminate diagnosis.**
  - **STILL TODO (asset thread):** tag each anim's CHR/palette from the descriptor `data_src`; the `S` command
    marks sound (`call_bank10`).

### #14 — Asset reorg: flat dumping ground → structured `assets/` — DONE 2026-06-11
Goal-3 (assets) infrastructure. `atlas/` (180 flat files mixing 5+ asset kinds) + `commands/assets/`
(duplicated the command GIFs; same anims existed 3× — atlas numeric + commands-named + base64-in-HTML).
- **New `assets/` taxonomy** + **`assets/README.md` registry** (predetermined structure + anti-dup rules):
  `animations/`(+`frames/`), `maps/{fiefs,strategic}/`, `portraits/`, `screens/`, `rom/`. ~181 files migrated.
- **Dedup**: command anims canonical = `animations/<command>.gif` (byte-identical numeric `atlas/anim-N.gif`
  removed, md5-verified). `atlas/` + `commands/assets/` retired.
- **Repointed 10 render tools + `build-command-page.py`** (syntax-checked); fixed broken `commands/map.html`
  image links + CONTEXT/appendix paths. **Pipeline re-verified** (grow.html regen through the new path). 0 stale refs.

### #13 — Command Deep-Dive opened + econ_sim fixed/verified — 2026-06-11
Chris expanded the command work into a 6-goal deep-dive over all 21 commands (formulas/re-investigate/
assets/code-coverage/wikis/animations; "sprawl is good"). The linear chapter sweep pauses at ch.11.
- **Fixed a stale testing asset:** `econ_sim.py`'s develop family (`grow`/`build`/`give_peasants`) was
  hardcoded at `×5` = skill-1, predating the 2026-06-02 skill discovery. Made it skill-aware
  (`SKILL`/`_dev_mult()=(6−SKILL)`, 4 sites).
- **Re-verified by RUNNING it:** Grow gain at output=80/amount=100 = **76/60/46/30/14 for skill 1-5**,
  matching the ROM-confirmed curve exactly. The higher-fidelity "test the formula" approach, demonstrated.

### #12 — Chapter 10 fact-check (Command Families) — DONE 2026-06-11
The √-develop-template insight (Grow/Build/Dam share one parameterized command) is real, but session 10
over-fit two commands and missed the skill dial. Fixed against the verified `commands/` pages + appendix:
- **Bribe (idx 14, `effect_bribe $8D4D`)** — NOT a develop-√ command; it's gold-for-spy **peasant defection**.
- **Assign (idx 15, `effect_assign $AC11`)** — the **arms-allocation editor**, not "assign a retainer / men-store".
- **Skill dial** — same `(6−skill)` correction as ch.9, universal to the develop family.
- **`$879F`/`$804C`** = generic province-target-select helpers (War/Bribe/Pact/View/Ninja), not a "diplomacy subsystem".
- **Method note:** the mechanics chapters have *semantic* errors (not just naming) — reconcile against the
  verified `commands/*.md` pages + `appendix-formulas.md`, and TEST (econ_sim/emulator) rather than trust a
  session's "confident characterization." (Chris's higher-fidelity steer for chs.10+.)

### #11 — Chapter 9 fact-check (Command System / Grow) — DONE 2026-06-11
First game-logic chapter. The calling convention, province idiom, √-returns find, and §5d field
reconciliation all **hold** — but it MISSED the headline mechanic (Chris predicted it):
- **`const_two $6D63` = the SKILL LEVEL / difficulty knob (1-5, default 2)**, not a constant "2". Chosen at
  new-game. The chapter read it as a literal constant.
- **Complete Grow formula:** `output gain = 2·⌊amount·(6−skill)/√(output+amount)⌋` (emulator-verified). The
  `(6−skill)` multiplier was the missing piece — and the **"×5 mystery"** solved (skill 1 → ×5 … skill 5 → ×1,
  a 5.4× economic-speed swing; higher skill = harder).
- **`const_two` is a pervasive anti-player DIFFICULTY DIAL** (a major hidden global mechanic): scales the 5
  develop commands, AI-only stat boosts, uprising magnitude `(skill+1)·10`, and combat casualties `rng(6−skill)`.
  → a top candidate for the synthesis (the engine's "why it's hard" lever, invisible in the UI).
- Drain pct is live-computed (`⌊100·gain/(gain+output)⌋/2`, flat-50 ceiling), not "flat 100". Opcode §7 → Appendix C.

### #10 — Chapter 8 fact-check (VM Instruction Set) — DONE 2026-06-11
Solid session-8 chapter — the ALU decode + compare-then-branch idiom + the **9999-cap → economy-location**
find all **hold**. Two real opcode errors fixed (the ch.6 length-bug family) + name reconciliation:
- **$30-$3F = `PUSH_quick`** (push a frame local to the stack), NOT "store regB to frame" — the quick grid
  is LOADL/LOADR/STORE/PUSH, not loadA/loadB/storeA/storeB.
- **$D8 = `JUMPF_abs`** — a 2-byte **absolute** branch target, not the relative "branch_z +sbyte" shown (the
  relative branches are $E3-$E8; the clamp example's "+89" was that mis-render).
- `regA/regB` = canonical `regL/regR`; descriptive mnemonics → Appendix C. Its own $8A/$8C word-load fix is right.

### #9 — Chapter 7 fact-check (SRAM Save Layer) — DONE 2026-06-11 (the queued body rewrite)
The messiest chapter: a 2026-05-14 erratum sat on top of an un-rewritten body full of the exact "old junk"
Chris flagged. Did the rewrite the chapter itself said was "queued":
- **Province table:** `$6000/$601A` + "BE in SRAM" + `$60B6` example → all wrong (mislabeled-offset reads).
  Corrected to **`province_table_live $7001`, 17×26, little-endian**; **gold IS at +0** (refuting "gold stored
  separately"); no "footer" (last field = `header` +24).
- **Arrays-first map** (Chris's unlock): documented the SRAM as parallel index-keyed arrays with grounded
  bases — `fief_history_table $6003`, `fief_tax_rate $6D2D`, `fief_to_daimyo_map $6E15` (the explicit owner
  array the body said didn't exist), `daimyo_table_17 $752F`, `daimyo_name_table $77A8`.
- **Daimyo `+6`** = original-vs-generated portrait flag (not "dead").
- **Cleanup DONE:** retired the toml's dead `province_table_OLD $601A` label (was kept only to flag this
  chapter) — regen-clean (empty C diff, unreferenced). "The toml maps live code, not dead code" (Chris).

### #8 — Chapter 6 fact-check (VM Disassembler) + NEW Appendix C — DONE 2026-06-11
Session-6 chapter: the disassembler tool is real (rebuilt pass-1 = `na1dream.vm_disasm`), but its opcode
*reference* was a partial, partly-wrong first pass. **Spawned a new artifact** (Chris's call):
- **NEW: `appendix-vm-opcodes.md`** — the canonical 256-opcode reference, **generated** by
  `tools/gen-opcode-appendix.py` from `vm-opcodes-v2.toml` (pops/pushes/semantics) + `nobunaga_vm.OPCODE_INFO`
  (execution-validated mnemonic + operand length). 193 opcodes verified; 2 illegal ($80,$CE). Registered as
  README Appendix C; chs.6 & 8 cite it. Regenerate, don't hand-edit.
- **CORRECTED:** the old operand *lengths* for ~10 opcodes ($84/$86/$88 = `*_far` = 2 bytes, not 4; +$A0-$A3/$AA/$AF/$DE/$DF).
- **REFUTED:** the "37 trigger_syscall BRK opcodes" — they're the illegal/undefined-opcode **trap**, not a syscall
  path; only `CALL_abs`/`CALL_abs_imm1`→$F226 call out (reconciles with ch.4 "real BRK unused").

### #7 — Chapter 5 fact-check (Bytecode VM) — DONE 2026-06-11
VM-discovery chapter (session 5) — **architecturally correct** (it's the whole engine), needed the renames Chris predicted.
- **RENAMED** the pre-grounding ZP pointers: `ptr0→scratch_ptr` ($00/01), `ptr1→vm_sp` ($02/03),
  `ptr2→vm_fp` ($04/05), `ptr3→vm_ip` ($06/07). Added a name-map banner; asm blocks keep old names + map.
- **REFINED:** the chapter called `ptr1` "the VM frame pointer" — grounded = `vm_sp` (operand-stack
  pointer; frame = a slice of the stack). Surfaced the piece it **missed**: `vm_fp` ($04/05) = the separate
  frame-base for local/arg access (`vm_fp+offset` → decompiler `local0..N`/`arg1..N`).
- Sub names already matched grounded (`vm_entry $E823`, `vm_dispatch $E867`, `vm_call_native $EB57`,
  `vm_opcode_lo/hi_table`). host-call opcodes = `vm_op_E9_host_call`/`_AC_` (mnemonics `CALL_abs_imm1`/`CALL_abs`).

### #6 — Chapter 4 fact-check (Syscall API) — DONE 2026-06-11 (VERIFIED, holds)
The most-grounded early chapter (pass-1 updated it). No corrections needed:
- All 23 catalog entries match the grounded `[prg.bank15]` labels; `$F226` `PHP+JMP($FFFE)` mechanism correct;
  rows 12/20 carry hand-decoded arg-maps.
- It was effectively the **oracle** for the chs.1-3 errata — its "Errata to chapters 1-3" table is exactly
  the set I applied inline this session; noted as now-fixed-at-source.
- Confirmed cross-link: `syscall_rng_next $C1C3` runs a 48-bit transform over wall-clock state `$0083-$0088`
  → game-time + RNG pause together under `skip_wallclock` (ties chs.1/2/4 into one story).

### #5 — Chapter 3 fact-check (NMI pipeline) — DONE 2026-06-11
First runtime-correlated chapter — **largely holds** (NMI handler, PPU shadow API, palette pipeline,
controller poll, two-pass music driver all correct; it's where the `$0734`=audio-voices fix originated).
- **REFUTED:** the "4-byte song header at `$0730-$0733`" — that region is the tail of the 5×3-byte
  **per-voice config array** (`$0725-$0733` = v0..v4_config, each tempo_div/song_ptr_lo/song_ptr_hi,
  written by `audio_load_voice $C3AD`). The trace snapshot misaligned v3/v4 config as a header.
- **RESOLVED its open-for-ch4 list:** `$90-$AF`=`palette_alt`, `$1C-$1F`=`ppu_queue_a/b`,
  `$C757`=`reset_ppu_init`; the "dispatcher is a syscall surface, not a scheduler" inference confirmed.
- Grounded sub names: `music_trigger_pass $C7AC`, `music_sequencer_pass $C817`, `p1/p2_buttons $6E/$6F`.

### #4 — Chapter 2 fact-check (Zero-page map) — DONE 2026-06-11
Static-only session-1 map, predates the VM decode.
- **HEADLINE FILL:** `$02-$07` = the VM's core registers (`vm_sp $02/03`, `vm_fp $04/05`, `vm_ip $06/07`) —
  the busiest RAM in the ROM is the interpreter register file, not "generic subroutine pointers." Ties ch.2 → ch.5.
- **REFUTED:** `$90-$AF` "attribute table buffer" guess — it's `palette_alt` (the fade/swap target paired
  with `palette_shadow $0700-$071F`). Resolves the chapter's main runtime-open question.
- **CONFIRMED:** `$1C-$1F → $0020/$0030` PPU upload queues; the two byte-meaning-by-context findings
  (`$68/$69`, `$83-$86`) — the session-1 analysis method was sound.
- **GROUNDED:** `$74 palette_dirty`, `$80 skip_vblank_wait`, `$7A music_ptr`, `$71/$72 ppu*_shadow`.
- Small ch.1 residual fixed: NMI `$C54F` is `nmi_off` (re-entry guard), not "deferred PPU updates."

### #3 — Chapter 1 fact-check (Boot/dispatch) — DONE 2026-06-11
First chapter of the by-chapter sweep. Session-1 chapter, written before the kernel was grounded.
- **REFUTED:** the "BRK dispatcher" framing — game/VM code calls `jsr syscall_dispatch ($F226)`, which
  fakes a BRK via `PHP + JMP ($FFFE)`; the IRQ handler ($C139) dispatches on the B flag. The "1-byte BRK
  saves bytes" rationale is backwards (the trampoline is larger). Chapter retitled "…Syscall Dispatcher".
- **REFUTED:** "5×9-byte records at $0734 = 5 daimyo slots" — it is the **music voice-state array** (5
  voices × 9 bytes, `music_driver` + `syscall_audio_load_voice`). A clean-but-wrong guess.
- **FILLED:** the 23-entry dispatch table now carries grounded names (19 kernel syscalls + 4 RTS no-ops).
- **CONFIRMED:** the bytecode-VM hypothesis (`$8000 bank0_entry → $A778` = VM); the two wall-clocks
  (`clock_a/b $0083-86`, gated by `skip_wallclock $0089`); the NMI gate flags + `nmi_busy` semaphore.
- Synced README chapter-map title. No code/label changes needed (chapter-only).

### #2 — The 4 sabotage missions + ninja economics — CONFIRMED 2026-06-11 (C + bytecode `$A255`/`$A2D2`)
The other four ninja missions and the answer to "is it economical to sabotage?". Fixed a real error in
`commands/ninja.md` (page now corrected + filled).
- **Drain formula** `hire_stat_drain_rng $A255`: `drain = (rng_mod(max(1, ⌊field × √(unit_count) ÷ 100⌋))
  + 1) × 5`, clamped to the field. `arg1=field`, `arg2=unit_count` (bytecode `$A25B`/`$A261`).
- **WIKI ERROR FIXED:** the page had the √ over `your_skill+30` — wrong. It's `√(unit_count)`; the `+30`
  is the separate **Luck** attempt-gate (record +3 = Luck, not "skill"). Two mechanics had been fused.
- **Economics = denial with √-diminishing returns.** Cost ∝ `unit_count` (linear,
  `math32_muladddiv(hire_gold_rate, units)`); drain ∝ `√unit_count` (and ∝ field magnitude). Doubling
  ninjas doubles cost for ~1.41× drain → small batches are most gold-efficient. You gain nothing
  material — it's pre-war softening: Uprising(loyalty+wealth), Revolt(**morale**→desertion), Dams(dams+
  **rice**→starvation feeds the combat day-loop), Arson(town). Best vs already-high fields, in small doses.
- **Resolved two open Qs on the page:** the assassination "`$6DA2` present" gate = the **capital**; and
  "Tokugawa's mystery health loss" = the assassination **counterattack** hitting the attacker's own daimyo.

### #1 — The Ninja / Assassination keystone — CONFIRMED 2026-06-11 (C + bytecode `$918D`/`$A2D2`)
`effect_ninja_sabotage $A2D2` → `ninja_mission_resolve_vs_defender $918D`. Five missions sharing one
cost and one gate: `1 Uprising / 2 Revolt / 3 Dams / 4 Assassinate / 5 Arson`. Corrects the scout
read on every load-bearing point:

- **Assassination requires the target be the daimyo's CAPITAL** (`$A349`): non-capital → "The daimyo
  is out." return. The capital is `ai_state==0` (directly-run), which is *why* the `$9192` gate admits
  it — the scout's "player-only" read was a misread; **enemy AI daimyo ARE assassinable at their seat.**
- **Outer attempt-gate, ALL 5 missions (`$A36C`): `target.Luck < attacker.Luck + 30`.** The +30 is the
  attacker's edge — high attacker Luck nearly always passes; the target needs Luck ≥ attacker+30 to block.
- **Resolution contest = `attacker(Charisma+IQ) ≥ target(Charisma+IQ)`** (`$91BF–$91D2`, bytecode-
  confirmed). Distinct from the Luck attempt-gate. ("Cha+IQ seemed odd but is right.")
- **Counterattack** (`$91D5`): a defender whose noisy Charisma beats the attacker's repels — attacker's
  own Charisma −1, the kill is blocked that turn, and the health damage is **halved** (divisor 1+counter).
- **Kill = ATTRITION, not one-shot** (`$9264–$92B5`): on success, deduct `rng(1 .. health/(1+counter))`
  from target `health (+1)`; the daimyo **dies when health reaches 0** (avg ~2 un-countered hits). At a
  capital, death → `find_fiefs_of_owner` neutralizes EVERY fief the daimyo owns (faction collapse). The
  `230 >` constant at `$9290` is vestigial (health ≤115).
- **Garrison does NOT protect** (`$9213`, field = **men**, record +16): `if men ≤ rng(1-10)` an extra
  defensive roll runs (using target **Luck**/10 & /100 — the C's `local7` mislabeled IQ; bytecode `+3`=
  Luck); otherwise (men > ~5) it jumps **straight to the success path**. A defended capital gets *no*
  defensive roll. Counterintuitive; flagged for an emulator sanity-check.
- **Cost paid win or lose** (`math32_muladddiv(hire_gold_rate, unit_count)`, `$A452`/`$A2CB`).

**Synthesis takeaway:** the dominant pick is **high-Luck AND high-Charisma** (Luck gates the attempt +
defends the empty-fief roll; Cha+IQ wins the resolution + counterattack). No guard stat exists — the
only defense is the target's own probabilistic Luck/Cha/IQ. Cheap + repeatable + removes a whole
faction = the engine half of the README thesis, now grounded.

**RNG surface of the kill path (the TAS exploit, measurable) — enumerated from the `$918D` bytecode:**
7 `rng_mod` draws between attempt and kill; with a controlled stream the ~2-hit attrition becomes a
**deterministic one-shot**.

| # | draw | addr | what the TAS forces |
|---|------|------|---------------------|
| 1-2 | counterattack `rng_mod(20)`×2 | `$91DB`,`$91EB` | NO counterattack (kill not blocked/halved) |
| 3 | men-check `rng_mod(10)+1` | `$9216` | route the men branch favorably |
| 4 | charisma factor `rng_mod(Cha)+50` (cap 100) | `$9226` | pass the kill sub-roll |
| 5-6 | kill-roll `rng_mod(Luck/10)`, `rng_mod(Luck/100)` | `$923B`,`$9257` | pass both gates |
| 7 | health deduction `rng_mod(health/(1+counter))+1` | `$926C` | MAX it → deduct = full health → **instant kill** |

Plus the **character roll is RNG** (`prompt_roll_stat_value $85FC` = `rng_mod(50)+60`, 60-109) → the TAS
rolls L/Ch/IQ ≈ max at creation; targeting *weaker* daimyo means their low Cha+IQ always loses the
resolution contest. The exploit is a chain of gamed `rng_mod` calls. *UNVERIFIED as a runnable exploit —
next step is to drive `$918D` from the ROM with a fixed RNG stream and demonstrate health→0 in one mission.*

**Decompiler defect found (logged tech-debt §1.6):** the C renders `case 4` (assassinate) falling
through into `case 5` (arson); bytecode `$A50D` is `JUMP $A41D` (shared tail) — a switch emit mis-render.

---

## Meta-game artifact: what each daimyo stat affects (accumulating — CONFIRMED only)
The player-facing "what to look for when rolling a character / facing the AI" reference. Add a row only
when bytecode-confirmed; the scout pass proposed more (Drive→combat, Charisma→bribe/harvest, Luck+IQ→
train) but those are PROBABLE until verified.

| stat (offset) | confirmed effects | source |
|---|---|---|
| Health (+1) | the daimyo's **life pool**: assassination drains it; 0 = death | #1 |
| Luck (+3) | ninja **attempt-gate** (`target.Luck < attacker.Luck+30`, all 5 missions); empty-fief assassination kill-roll defense (`rng(Luck/10)`,`rng(Luck/100)`); **−1 on Marry refusal**; **View spying** (`rng(Luck)+IQ` contest) | #1, #2, #20, #21 |
| Charisma (+4) | assassination **resolution** (Cha+IQ contest); **counterattack** duel; kill sub-roll factor (`rng(Cha)+50`); **bribe success** (`your(loy+Cha) > target(loy+Cha)+rng·skill`); **−1 on Marry refusal** | #1, #19, #20 |
| IQ (+5) | assassination **resolution** (Cha+IQ contest); **View spying** (`rng(Luck)+IQ` contest vs target) | #1, #21 |
| Drive (+2) | the **diplomacy-attempt currency** (Pact/Marry cost −1, −2 on refusal); **the AI's AGGRESSION dial** — `Drive<50` respects relations (won't attack liked fiefs), `Drive≥50` ignores them; gates attacking the monk fief; compared daimyo-vs-daimyo in combat (`$8EB8`) | #20, #26 |
| Age (+0) | — *(aging/event interactions — TO VERIFY)* | — |

## Pass-2 sweep — BY CHAPTER, in order (the method, Chris 2026-06-11)

Walk the 20 mechanics chapters `01`→`20` in order; fact-check + fill each against the grounded C; fold
wiki / command-page / stat-table / appendix findings in as they surface. Linear doc coverage — nothing missed.

**Per-chapter procedure** (one chapter at a time):
1. **Read the chapter**; list its claims, formulas, and cited sub-names as **suspects**.
2. **Verify each against the grounded C (primary)** → bytecode `na1dream.vm_disasm` (backup, when the C
   reads oddly) → emulator (`value-oracle.py`/`econ_sim.py`, for numbers). Confirm / amend / **refute**.
3. **Correct + fill** the chapter (deepen where it only scratched). Tag claims `[LEVEL STATUS DATE]`.
4. **Fold in downstream**, editing the SOURCE not the artifact:
   - command/wiki pages (`commands/*.html`) → edit the **`tools/build-command-page.py` spec + regenerate**
     (`py -3 build-command-page.py build <cmd>`); the `.md` companions are hand-edited.
   - `appendix-formulas.md` (hand-edited) where a formula drifts.
   - **stat-effect table** above — add any newly-confirmed daimyo-stat edge.
   - `mesen-labels.toml` (+ regen) for any slot/label corrected in passing (label-as-you-go).
5. **Ledger** the findings here + mark the chapter row in the tracker.

## Coverage tracker (chapters 1-20)
Status: `todo` / `WIP` / `done` (= every claim verified, corrections applied). Prior errata noted.

| ch | title | status | notes |
|----|-------|--------|-------|
| 01 | Boot, vectors, Syscall dispatcher | **done** | 2026-06-11 — BRK framing refuted; 23-table named; $0734 daimyo-guess refuted (music voices); VM hypothesis confirmed (ledger #3) |
| 02 | Zero-page memory map | **done** | 2026-06-11 — $02-$07 grounded as VM regs (vm_sp/fp/ip); $90-$AF=palette_alt (not attr table); $74/$80/$7A/$1C-$1F grounded; 2 byte-context findings confirmed (ledger #4) |
| 03 | NMI/VBlank pipeline | **done** | 2026-06-11 — runtime-verified chapter, mostly holds; refuted the $0730 "song header" (= per-voice config array); resolved its open-for-ch4 items (ledger #5) |
| 04 | Syscall API (23 entries) | **done** | 2026-06-11 — VERIFIED, holds (pass-1 grounded it); all 23 match labels; was the oracle for chs.1-3 errata (ledger #6) |
| 05 | Bytecode VM | **done** | 2026-06-11 — model correct; renamed ptr0-3 → scratch_ptr/vm_sp/vm_fp/vm_ip; surfaced vm_fp ($04/05) the chapter missed (ledger #7) |
| 06 | VM disassembler | **done** | 2026-06-11 — tool real (na1dream.vm_disasm); opcode table superseded → **new Appendix C** (generated); wrong-lengths + trigger_syscall refutation (ledger #8) |
| 07 | SRAM save layer | **done** | 2026-06-11 — did the queued body rewrite: $6000/$601A/BE junk → $7001/LE; gold@+0; daimyo +6 = generated-flag; fief_to_daimyo_map owner array; array-base map (ledger #9); retired dead `province_table_OLD $601A` label (regen-clean) |
| 08 | VM instruction set | **done** | 2026-06-11 — 9999-cap/ALU/control-flow hold; fixed $30-$3F (PUSH not store-regB) + $D8 (JUMPF_abs, absolute not relative); names→Appendix C (ledger #10) |
| 09 | Command system & Grow | **done** | 2026-06-11 — Grow/idiom/convention hold; added the MISSING skill-level dial (`const_two`=difficulty 1-5; gain ×(6−skill), 5.4× swing); ch.7 reconciliation closed (ledger #11) |
| 10 | Command families | **done** | 2026-06-11 — develop-template real, but fixed 2 misclassifications (Bribe=peasant-defection not √-grow; Assign=arms-editor not retainer) + skill dial + the "target-select≠diplomacy-subsystem" over-read (ledger #12) |
| 11 | Strategic engine (21 commands) | **done** | 2026-06-12 — ALL 20 non-combat commands walked through the 6-goal checklist (Move/diplomacy/atoms/Grant/Other/Trade); only War deferred to the combat chapters (ledger #19-#23) |
| 12 | Daimyo AI | **done** | 2026-06-12 — full top-to-bottom AI-turn walk (order/probabilities/Drive-only stat influence) + the decompiled model + AI-exploitability synthesis; old pre-decompiler body superseded (ledger #24, #26) |
| 13 | Turn loop & harvest | **done** | 2026-06-12 — grounded `vm_bootstrap` master loop + the seasonal task rotation (S0 age/S1 highwater/S2 harvest/S3 relations-decay); closed the "top-level loop hides" + harvest-misID open items (ledger #24) |
| 14 | Combat overview | todo | erratum 2026-06-01 |
| 15 | Tactical map | todo | |
| 16 | Render pipeline | todo | errata 2026-05-20 |
| 17 | Damage formula | todo | Drive + combat stat-weights verify here |
| 18 | Window updates | todo | pass-1 added UI-primitive section |
| 19 | Bank 15 layered map | todo | written fresh in grounding pass |
| 20 | Strategic map render | todo | written fresh in grounding pass |

## Command Deep-Dive — ACTIVE workstream (Chris, 2026-06-11)
The linear sweep **pauses at ch.11**; chs.9-10 opened the commands, and now we run the ch.8→9 method
(test the code → derive/verify the formula) across **all 21 lord commands**. The deep-dive feeds ch.11 +
the appendix + the wikis. **Sprawl is GOOD here — this is exploration.** Per command, six goals:
1. **Formula correct + in `appendix-formulas.md`** — spot-verify on emulator/`econ_sim`; flush out gaps.
2. **Re-investigate** the handler for missed mechanics.
3. **Assets** — label the data/graphics it touches; look for a generalizable approach.
4. **Full code coverage** of the command bank (bank 1).
5. **Wiki up to date** — `commands/*.html` (fix the `build-command-page.py` spec + regen, like Ninja).
6. **Animations** (bonus) — fix fullscreen-vs-clipped-region framing; repair broken ones; maybe add sound.

**Testing assets must be faithful too:** `econ_sim.py` was hardcoded at skill-1 (`×5`) — fixed 2026-06-11
to be skill-aware (`SKILL` / `(6−SKILL)`); now reproduces the ROM curve (Grow gain 76/60/46/30/14 @ skill 1-5).

**Worklist** (21 lord commands; ✓ = formula already in appendix). Fill status as we go:
`Move · War · Tax · Send✓ · Dam✓ · Pact · Grow✓ · Marry · Trade · Hire✓ · Train✓ · View · Build✓ · Give✓ ·
Bribe(emu✓) · Assign · Rest · Map · Grant · Other · Pass`   (+ **Hire▸Ninja done**, ledger #1/#2)

**Develop family deep-dive — COMPLETE 2026-06-11** (ledger #16): **Grow / Build / Give** all econ_sim-verified
+ skill-dial surfaced in their wikis (curves 76.., 82.., 50.. across skill 1-5). **Dam = SKILL-IMMUNE** —
its gain is `2·amount/√output` with NO `(6−skill)` term (econ_sim: dams +25 at skill 1 *and* 5), so it's the
one develop command the difficulty dial doesn't slow → relatively stronger at high skill (a dominance lever).
**Tax ✓** (ledger #17: sets the rate + `|Δtax|%` loy/wlt drain + −1 cha; the rate = the harvest income
multiplier). **Economic core (Grow/Build/Give/Dam/Tax) DONE.** NEXT: the non-economic commands (War/Pact/
Marry/Trade/View/Move/Send/…) + the Grow↔Dam crossover reconciliation (ledger #17 TODO).

**Grow (the pattern command):** goal 1 formula ✓ (econ_sim re-verified the skill curve); goal 5
wiki ✓ (skill dial surfaced in grow.html); goal 6 animation rendered (id 9, peasant+output-meter, renders
clean) — needs the **clipping fix** (clip render to the game's animation window, not full 256×240 / sprite-bbox;
a `run-animation.py` change, applies to ALL command animations). Goals 2/3/4 (re-investigate/assets/coverage) light — ch.9 traced it.
**Animation-clip is a shared sub-task** for the whole command set, not Grow-specific.

**Side tasks (do when convenient, not blocking):** census the §1.6 switch mis-render; emulator-certify
entry #1's surprises if a number is ever disputed.

**Emerging artifacts / frontier ideas:**
- **Engine-architecture synthesis writeup** (Chris, video-worthy): the chs.1-8 story — native bank-15 kernel
  + custom Sea-16 bytecode VM (ISA/syscalls/save) — *plus* the decompiler/DREAM journey (its own arc, not yet
  a chapter). A candidate standalone narrative once the sweep finishes.
- **Global difficulty dial** `const_two`/skill-level (ledger #11): a pervasive hidden anti-player mechanic;
  belongs in the synthesis as a top-level "why the game is hard" lever (distinct from the daimyo-stat table).
