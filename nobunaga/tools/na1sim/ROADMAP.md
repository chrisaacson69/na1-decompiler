# na1sim — build roadmap

A high-fidelity, headless, formula-grounded NA1 simulator. Engine decoupled
from policy (Monopoly-sim style); decoded daimyo AI is one policy. Goal #1:
answer **"can Hida (or any seed) escape the bottom trap?"** as a Monte-Carlo
survival/dominance curve, not a judgment call.

## Experiment config (locked 2026-06-18)
- **Combat:** off-screen stat resolver for ALL battles (`resolve_siege_assault_outcome $8DFD`). Tactical grid = later toggle.
- **Outcome metric:** survival + dominance curves over years, seed-swept — P(alive & above-threshold) and P(regional dominance/unification) vs year.
- **Hida policy:** strong hand-tuned policy vs decoded-AI neighbors = the optimistic "is it *possible*" bound.

## Plan-B faithful transcription (2026-06-19) — replaces the lossy hand-port
The prose/appendix-derived AI port kept dropping field-writes (THREE gold-sinks
found: arms-buy, feed#2, and the `$95C9` surplus-drain), making the AI hoard gold
and over-recruit men to its year-cap. Pivot: **transcribe the verified decompiled
C directly** against a flat memory model, validated against the na1dream bytecode
(Plan A = oracle, Plan B = runnable workhorse).
- `memmap.py` — flat $0000-$7FFF work-RAM/SRAM + the grounded address map (fief
  record $7001 stride 26; daimyo $752F stride 7; const_two $6D63, year $6D9F,
  market table $6E0B, province_ai_state $6CF7, fief_is_capital $6DA2, ...).
- `vmprims.py` — leaf engine, line-for-line from source/4-c w/ ROM addrs. KEY:
  `effect_grow` is **gold-neutral** (the econ.grow-debits-gold divergence, designed out).
- `ai_vm.py` — the FULL AI command family: dispatch/recruit/develop/$95C9 sink
  AND the war engine (ai_try_war_attack + target selection + ai_commit_attack_
  deduct_resources, the men/gold/rice war sink). Battle delegated to an injected
  resolver at the resolve_siege_assault_outcome $8DFD boundary (combat.py/autoresolve,
  bank-1; bank-2 tactical NOT transcribed by design). Candidate neighbour list
  sourced from m.neighbor_rows (loader adjacency / oracle-captured), not the
  banked-SRAM relation syscall. Fixed D_DRIVE = +2 (war gates read +2, not +3).
- `oracle_vm.py` — cross-checks vmprims/ai_vm vs na1dream, bit-exact LCG replica
  (DreamRNG) for rng lockstep; $8DFD no-op'd for the deduct-only war check;
  recruit feeds the ROM's captured $6F4F candidate list so the war rng aligns.
  **2026-06-19: 11/11 routines bit-exact**, incl. the develop gold-sink, the war
  sink (gold/men/rice -168, war_att_* +168, war_side +128), and recruit_arm_train
  END-TO-END WITH the real war hook (morale/skill match to the digit).
- `setup.py` — faithful board via the ROM's setup core: drives
  apply_scenario_starting_stat_boosts ($83E2) HEADLESS in na1dream (skips the
  UI-heavy init_new_game_state entirely). Produces real random headers
  (pct_op(data+1000, rng20+80) -> ~1700-1900, verified 840-1960), difficulty
  stat boosts, boosted-fief rolls, market seed. build_board(skill, seed).
- `game.py` — the FLAT-NATIVE turn loop (one source of truth, no World sync):
  flat harvest_fief + resolve_siege ($8DFD resolution; ai_vm already did the
  commit) + command_pass (ai_vm) + base_test. **player==0 RUNS (2026-06-19).**
- **RESULT: the men-overdevelopment fix is CONFIRMED.** Avg AI men sits BELOW
  the (year-1559)*40 year-cap now (e.g. 285 @ 1570 vs cap 440) -- the old port
  hit ~450 (at the cap); faithful gold-sinks gold-starve recruiting -> ~285
  matches Chris's observed ~300.
- EVENTS + 4 fidelity cleanups DONE (2026-06-19): events (uprising/typhoon/plague)
  + Spring boon, the low-water marks ($6003; update_province_highwater_marks =
  MIN not max -- asm-verified twice; reset Summer, min+income Fall), ownerless-fief
  succession ($8C75: strongest neighbour bids rng(gold) & annexes, else fresh
  daimyo -- no empty fiefs), daimyo age at record +0 (record = [age,H,D,L,Ch,IQ,
  status]) + aging/death, and per-season market reroll (roll_period_market_rates
  $924A: hire_rate ~14->98 => men cost ~3->16 gold). **HARVEST oracle-validated
  BIT-EXACT** (game.harvest_fief vs ROM harvest_income_sweep $A274, all 17 fiefs
  gold/rice/men/output/loy/wealth; oracle_vm now 12/12).
- FINDING: with the faithful harvest (low-water marks + the AI's own develop
  loyalty-drain suppress income) + the market price ramp + war attrition, AI men
  settles ~130 seats / ~200 top -- LEANER than the ~300 recollection. AI command
  + harvest are bit-exact; any residual gap lives in the un-validated approximations
  (resolve_siege combat, aging rate per-season, succession aggression).
- 0-PLAYER TOURNEY REASONABLE (2026-06-19, game.py tourney): 40 seeds x 25yr ->
  Oda #1 survivor (82%, dies latest Y1579), strong clans top (Uesugi/Hojo/Tokugawa/
  Takeda 60-78%), weak die turn-1 (Saito/Mino 8%, Honganji/Kaga 10%, Rokkaku/Iga
  15%), Hida mid-pack 50%, no unification in 25yr -- matches known NA1 outcomes,
  falls out of faithful mechanics (not tuned). [4-turns/year bug fixed AGAIN: aging
  is per-YEAR; the per-season driver wrongly ×4'd it and killed every lord by 1570.]
- COMBAT VALIDATED (2026-06-19): game.resolve_siege vs ROM resolve_siege_assault
  _outcome $8DFD -- strength formula line-for-line identical to the C; loss (def
  absorbs half committed -> 210) + win (conquest garrison = committed + half def
  -> 215, ownership flips) both MATCH. Only the war_attacker_men scratch global
  diverges (cosmetic). **oracle_vm now 13/13** (AI family + harvest + combat).
- FEASIBILITY METRIC: games DON'T unify even in 45yr (0/20; consolidation 14->5
  factions over 42yr -- lean economy => similar men-ratios => few wars clear the
  commit gate; a faithful long-sandbox). So "time to unification" is useless as a
  metric; SURVIVAL/DOMINANCE curves are the lens (Hida/Anekoji 30-50% survival =
  mid-pack, NOT doomed -- the feasibility answer). "time to max" is a separate
  POLICY metric (needs policy.py).
- PLAYER POLICY + ESCAPABILITY (2026-06-19): policy.py ports Chris's Mikawa
  playbook to flat (1-rice trick, year-1 tax->55 opening, INVERTED don't-be-weakest
  = not weakest in any BORDER's eyes, develop+train rotation). game.player_ab()
  A/B. **Hida tuned-player 45% vs 35% dumb-AI baseline -- the human out-survives
  autopilot. Bottom-trap thesis ANSWERED.**
- OPEN: the men-fix OVERSHOT. Strong fiefs under-perform as players (Uesugi 15%
  vs 82% AI) because the AI now UNDER-recruits (~130 men) + skill SNOWBALLS to
  ~1100+ (header-capped, ROM-confirmed; trains ~45%/turns, rarely hires -> undiluted)
  -> SKILL-dominated combat. Reality = ~300 men + middling skill (hiring dilutes).
  NEXT: re-examine recruit gate / men-price ramp so AI buys ~300 diluting bodies;
  fixes strong-fief player survival + the too-aggressive turn-1 dogpiles.

## Modules
- [x] `state.py` — Province / Daimyo / World dataclasses (SRAM-offset field names); Daimyo now carries REAL ROM stats + a player-generation path
- [x] `loader.py` — parse 17fief.txt + adjacency.txt + **17Diamyo.txt (real ROM lords)**; player-generated lord (90±15/stat, total>=450, seeded); **smoke test PASS**
- [x] `econ.py` — develop family (Grow/Build/Give/Dam/Tax) + multi-fief Fall harvest (income -> debt-repay -> MEN/2 upkeep + starvation -> clamp), grounded on appendix-formulas.md. **validate.py PASS**: reproduces the emulator-verified Mikawa §4 harvest to the digit (gold +40, rice +61).
- [x] `ai.py` — `ai_econ_command_dispatch` cascade ported, decision STRUCTURE exact from bank_01.c (war-attack-first, weakest-provisioned-men target, commit gate `ratio−10−rng(skill·3)>60 OR rng(100)==0`, recruit/arm/train, develop fallback). **smoke PASS**: Mino correctly picked as Hida-neighborhood weakest; war gate confirmed opportunity-scarce (Shinano→Mino ratio 65 < 70 threshold; needs ~3:1 men to fire). Battle delegated to an injected resolver (stub for now). Develop magnitudes carry flags [F1]/[F2] below.
- [x] `combat.py` — off-screen resolver `$8DFD` + conquest cleanup: strength = `men*(2 + atk/castle) + arms + skill + morale + 10%morale(higher Drive)`; winner absorbs half survivors; men-weighted quality blend; winner +1 Drive/Cha/IQ; capital-fall = faction collapse + lord eliminated. **smoke PASS** (Shinano overruns Mino + eliminates Saito; weak attack repelled & bleeds). Interpretation flags [C1]-[C4] in-file.
- [x] `loop.py` — turn coordinator: seasons (Spring aging+AI-boon/player-decay, Summer mark re-seed, Fall harvest) + the EVENT pass (typhoon/plague/uprising with riot|revolt via `square_roll`) + command pass (AI cascade or player policy) + elimination/victory. **Runs end-to-end**; all-AI sample reproduces the real dynamics: Mino falls turn-1 on revolts + dogpile and churns owners; revolts taper; capital-loss faction collapse snowballs to a leader. Combat commit fixed to SURPLUS (home keeps a garrison).
- [ ] `policy.py` — the pluggable player interface; a tuned Hida policy (don't-be-weakest defense + grow-to-escape-velocity + prey on Mino/Kaga). **NEXT**
- [ ] `mc.py` — seed-sweep × skill-level harness; emit P(alive)/P(dominant) vs year for Hida (the answer). **NEXT**

## 0-player base test results (40 seeds, 20 yrs, all-AI)
- **Hida (Anekoji) survival even as dumb AI:** skill1 18%, skill2 35%, skill5 57%. NOT a doomed bottom-trap fief — it's mid-pack and defensible. Dies median ~Y1567-70 when it dies; earliest Y1560 (turn-1 bad seed), latest ~Y1577.
- **Counterintuitive skill effect (0-player):** HIGHER difficulty -> MORE survival / SLOWER consolidation. Grounded mechanism = the war commit gate `ratio-10-rng(const_two*3)>60`: higher skill widens the random subtraction (rng(3) at skill1 -> rng(15) at skill5), so attacks need ratio>70..84 -> AIs commit far less -> fewer wars. (const_two hurts the PLAYER via develop x(6-skill) + AI subsidies, but makes AI-vs-AI LESS aggressive.) Chris's "skill-1 lets weak starts escape" hypothesis is about the PLAYER, so it needs the with-player experiment to test.
- **Tempo:** early shakeout (median clan death Y1563 — weak/low-morale fiefs go first), ~12 clans die/20yr at skill1-2 (8.5 at skill5), then STALLS at 4-9 clans; no unification in 20yr (NA1 is a long game; extend years to see it resolve).

## Known accepted divergence
- Auto-resolve has NO retreat (Chris): in a full battle the defending daimyo usually retreats from a capital assault and survives; off-screen they don't, so capital-loss faction collapse fires more readily -> faster consolidation than real play. Acceptable for a relative-survival experiment; not worth the cost of tactical sim.
- [ ] `oracle.py` — spot-check engine per-action deltas against `na1dream/nobunaga_vm.py` (real bytecode) so the port is grounded, not trusted.

## Closed gaps / findings
- **Daimyo stats now REAL** (17Diamyo.txt) for the 16 AI lords; the player's seat gets a generated lord per Chris's spec (90±15/stat, reroll to total>=450, age 18). DONE.
- **pct_op fidelity catch:** the real ROM primitive ($D70D) is split-by-10 and does NOT equal naive floor(b*p/100): e.g. pct_op(51,55)=27 (not 28), pct_op(136,64)=86 (not 87). `tools/econ_sim.py` used the naive form and is subtly wrong in harvest edges; na1sim/econ.py uses the true split-by-10 and reproduces the appendix worked example exactly. (Worth back-porting the fix to econ_sim.py + a note to the vault.)
- **Tokugawa Charisma discrepancy:** 17Diamyo.txt=110 vs appendix harvest example=68. Only touches harvest RNG ceiling. Reconcile later (scenario-start vs mid-game save?).

## Player character roll (GROUNDED)
- Real routine `prompt_roll_stat_value $85FC` = `rng_mod(50)+60` -> each stat uniform **[60,109]** (Chris's "90±30" was close; real center 84.5, capped 109). `daimyo_creation_stat_roll_screen $8763` rolls the set with confirm/reroll-all -> we reroll the 5-stat set until total>=450. Held fixed per experiment for low variance.

## AI fidelity flags
- **[F1 RESOLVED — bytecode-confirmed LINEAR]** Read bank_01_vm.asm $B42B: `$B4BF POPSTORE` (output += grow_amount, 1:1) THEN `$B4C2 CALL effect_grow` (sqrt gain too). Town handler ($B3AA) is purely linear (no effect_build). So the AI converts gold->output/town ~1:1 (the player gets only the sublinear sqrt-gain), PLUS a gold-budget overspend quirk (`gold_budget -= dams_gain` not the spend; effect_grow can no-op on low gold AFTER the linear add lands). **AI economies snowball far faster than a player's** — Hida's mid-game is harder than the v1 sqrt-model implied. ai.py now replicates the linear+sqrt behavior faithfully.
- **[ASYMMETRY confirmed — human attacked ~2x]** `get_province_ai_state` returns the raw state (0=AI falsy, 5=player truthy). War commit gate `$9561: get_province_ai_state(target) || rng_mod(2)`: AI-vs-AI needs a 50% coin, AI-vs-player bypasses it. Targeting is identical; the go/no-go favors hitting the human. Now modeled in `_try_war`.
- **[F2] `fief_owner_weakness`** body still un-read; approximated as "weakest-men fief in its border set." Ground next to combat.
- recruit hire-rate abstracted (~1 man/gold); arms buy not yet modeled; relations matrix not modeled (all scenario lords are Drive>=50, so the relations/Drive skip is inert in this scenario anyway).

## Emulator oracle (BUILT — `oracle.py`)
- Drives the real ROM via na1dream (`run-effect.py` pattern; SRAM dumps in `traces/`). **econ.grow VERIFIED ROM-exact**: amount 30 -> out+32 loy-10 dams-11; amount 60 -> out+54 loy-14 dams-14; matches econ.grow to the digit (the √-curve + split-by-10 pct are right). Gold is debited by the driver not effect_grow (cosmetic diff); econ.grow's `gold<amount` guard should `min(amount,gold)`-cap instead of no-op (sim callers always pass amount<=gold, so it doesn't bite).
- **NEXT oracle run:** ai_develop_dam_and_grow ($B42B) on an IDENTICAL SRAM state -> measure the AI's output-per-gold vs effect_grow's, to settle the linear-vs-√ asymmetry magnitude definitively.

## Calibration corrections (from Chris's play-experience)
- **Men price FIXED** — recruits cost ~5 gold early -> ~15 late (`world.men_price`, ROM: men = gold_spent/price), not 1. Was giving AI 5-15x too many men.
- **Caps FIXED** — real economy ceilings ~1700-1900 randomized per game (the static 1000/Noto-0 header was wrong). [exact gen-formula still TBD]
- **Still too hot late-game:** a maxed fief (town~1800) harvests ~pct_op(1800,55)=~990 gold/yr in the model -> over-funds late men (~450 vs Chris's observed ~300). Open anchors: (a) what a maxed fief really harvests/yr, (b) AI war attrition (Chris: AI "spends a lot on wars" — drains men; my attrition may be light). Both want emulator/trace grounding.

## The player's real edge (Chris — NOT ninja/bribe/grant)
- **Stay SMALL on men** (rice/provisioned trick keeps full provisioned men at 1 rice) -> low MEN/2 upkeep -> nearly all gold to development -> max faster than the AI, which over-recruits toward its year-cap (big army -> big upkeep -> starved dev). "I max Mikawa faster than Oda maxes Owari." The model currently has it backwards because the policy over-hires (tracks neighbours' men) instead of buying "only every few years."
- **Mid/endgame coordination the AI can't do** (it plays each fief independently): empty BACKLINE fiefs (0 men, safe) developed up; SEND gold/rice from maxed fiefs to pump weak ones; concentrate men on the front. Model after the 1-fief case is calibrated.
- Point of the sim is NOT that every fief survives — it's the opposite (Yamato unplayable, Mino dies). The target is matching the RELATIVE tier outcomes + that a competent Mikawa out-develops its AI mirror.

## Policy re-tune (next)
- Keep men MINIMAL (buy only when about to become the local weakest, in lazy spikes), so gold flows to dev — encode Chris's "year off every few years to buy men." Drop the per-season men-tracking.

## First-run finding (loader smoke test)
Hida is **mid-pack by men locally** (54), with two weaker neighbors — Mino (38) and Kaga (41) — to absorb aggression and prey on. The map-wide weakest is Iga (out 21), not a Hida border. Hypothesis: Hida is NOT the classic bottom-trap fief; escapability looks plausible. To be MEASURED by mc.py, not asserted.
