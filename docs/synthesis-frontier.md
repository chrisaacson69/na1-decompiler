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
- **★ OVERWRITE doctrine — a chapter carries ONE grounded layer, never a fossil record (Chris, 2026-06-16).**
  Each chapter/page states the *current* ground truth as if we always knew it. When a later pass supersedes
  earlier text, **delete the old text** — never leave it below as a stratum with a "⚠️ earlier this said X"
  note. Corrections become the prose, not annotations; provenance is at most a single `verified YYYY-MM-DD`
  tag per hard claim, NOT a changelog of what we used to believe. A **"What's open" list holds only what is
  still open** — a resolved item moves into the body as fact and is struck from the list. *Why:* the layered
  Pass-1-guess-under-Pass-2-note style re-confuses every reader (you, me, anyone) on every re-read, and it
  hides live findings. Poster child: ch.12 simultaneously names the six executors (Pass 2) **and** lists them
  as "four un-named, likely war/diplomacy" open items (Pass 1), and asserts the AI "never uses ninja/diplomacy"
  while the AI's random-event ninja sweep vs the human (`random_ravage_sweep_bounded_fiefs`) sat un-cited.
  Applies to ALL chapters; the early-chapter re-grounding **overwrites, it does not append**. (Git is the
  history; the prose is not.)

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
  never specializes; its command cascade never assassinates or plays diplomacy strategically. Its *only*
  ninja/marry/pact use is the rare **random-event** path vs the human (`random_event_type_dispatch` →
  `random_ravage_sweep_bounded_fiefs`): AI-fief senders, human (`state==5`) victim, **economic ravage only,
  never an assassination** (`$918D` is unreachable from the AI) — so there is still no AI counter to the
  player's assassination. Defends its seat only reflexively; subsidized by the `const_two` dial + a harvest
  gold bonus. [CONFIRMED 2026-06-16, ledger #24 + ch.12]
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

### #117 — Two questions in one label: the split, and the trade it cannot escape (Chris, 2026-11-23)

Chris: *we lost something with the new codes; I am not sure it is lord-specific yet; we need to see how the old games made the winning moves and why the new classification missed them.* Of #113's 14 later invasions, 13 were one-fief openings in years 2-7 and 9 were wins for #101. **The traces** (`--aim 0` now replays #101: the preset fills only flags not given, `--strike` excepted since it defaults to 0): Suruga 6/3017 under #101 read COMING all opening (a neighbour's share over 47) and the secure rung spent every Fall's harvest on men, 73 → 109 → 129 → 177 → 196 → 226, its line; under `--aim 4` it was nobody's pick, SAFE, the Fall gold piled up (118, 196, 263, 379) and went to the peasants each Spring, 124 men when Hojo (Musashi, fief 2) turned with 180. Hida 5/3011 the same (64 → 85 → 118 against 54 → 75). The label answered two questions: *will they attack us this season* (the AI's own pick: the gates) and *if they turn to us, can we hold* (the share and budget test: the fief's own line, since picks flip).

`AIM = 5` (`--aim 5`, `gate_empire`; off): the empire-wide gates and the post-strike check read `aimed_state` with its look-ahead; each fief's own responses keep #101's states. The four traced games all won, sooner (Suruga 1587, Hida 1582, Echizen 4/3002 1589, Iseshima 12/3000 1583). **181 of 240** (against #113's 189: saved 20, lost 28, z −1.2): later invasions 14 → 5, old age 17 → 34; Suruga 11 → 4 (3003, 3005, 3013 died at 14, 14 and 11 fiefs: the old lines cost the tempo of the shortest clock). `--aim 5 --aim-min 2` (#101's local states only while one fief is held): **183** (invasions 6, old age 31). Per start against `--aim 4`, the opening's line helps Uesugi 1, Asakura 4, Hida 5, Tokugawa 7 (+6) and costs Hojo 2, Imagawa 6, Kitabatake 12, Ashikaga 13, Takeda 15 (−12): the trade is the lord's, not the label's.

### #114-#116 — Bad prediction or the dice? Neither: the timing fixes do not pay (Chris, 2026-11-23)

Chris: *SAFE can go COMING on a flip too: the lowest fief hires and makes us lowest, or it is invaded so it is no longer lowest. Is it rare for the AI to buy outside the Fall? I would think the biggest surprise is a plague. We need to know if it is bad prediction or RNG.* **The census** (`misses.py`, `misses3.py`; 16 games of #113's `--aim 4` player, the four opening losers among them): of 433 AI attacks on our fiefs, the state at our last handover (after our own move) was COMING 189 (54 fell), HUNTABLE 203 (5 fell), SAFE 41 (22 fell). The 41: 20 came from a fief that was ours at the handover (the season's order is shuffled once; a fief taken early takes its own slot later as an AI fief), 12 the 1-in-100 wildcard (the cartridge's own choice said no even then), 7 the attacker's old pick grew, 5 plague on us (117 → 61, 46 → 12), 1 the attacker past the worst-case hire. **The AI hires in the Fall**: 2,063 of 2,516 hires, 57,225 of 63,733 men (90%). The losses are on the response side: 50 of the 54 COMING fiefs that fell were short of their line at the handover, 35 without the gold to close it.

**#114**, `expand.FALL_HIRE` (`--fall-hire 1`; off): in the Fall a flagged fief short of its line hires to it first. **186 of 240** against #113's 189 (saved 10, lost 13, z −0.6); later invasions 14 → 14, old age 17 → 20: the fifth turn taken from the economy that lost (#87, #102, #110, #112). **#115**, `expand.GIFT_RESERVE` (`--gift-reserve 1`, a guard in `policy.give_peasants` covering every gold gift; off): a flagged fief's gold gifts keep its line's hire cost (cliff gifts exempt). **187** (saved 10, lost 12, z −0.4). **#116**, `expand.CASCADE` (`--cascade 1`; off): a fief aimed at by an enemy yet to move this season (`m.acted`), short of its line, is reinforced first, by a Move if adjacent, else a Send of the gold its shortfall costs less what it holds. **185** (saved 5, lost 9, z −1.1). Echizen 4/3010 shows the limit: both attackers moved before our Fall turn. What is left is mostly the dice and the turn order; #113's `--aim 4` stands alone.

### #113 — The states read off the AI's own war choice: SAFE, HUNTABLE, COMING as Chris meant them (Chris, 2026-11-23)

Chris: *why does SAFE toggle on and off so much, and why does a COMING fief so rarely get attacked? I might be missing a gate. The states were: SAFE, we are not the smallest target of any neighbour; HUNTABLE, we are someone's smallest but a gate (men, rice, gold) holds, a precarious state, since a harvest or a windfall can lower it quickly; COMING, someone's smallest and every gate clear, only the dice hold them back. COMING can be eternal (Kaga under Noto, or a late pocket with one enemy left), and there "safe" is the other gates. All SAFE should be not COMING, and we need to look ahead: the flip between HUNTABLE and COMING is tenuous.* **The census** (`toggles.py`, `toggles2.py`; 12 games of #101's player, 17,664 player fief-seasons): `fief_state` tested share of provisioned men > 47 and budget >= shield, which says "could be picked", not "is picked": SAFE 17,280 fief-seasons attacked 6 times, COMING 303 attacked 41 (13.5%); the 105 flips out of SAFE were a neighbour's men growing (39), both sides (31), our own men falling (20), a conquest moving the border (15). **`ai_vm.ai_war_aim`**, `ai_try_war_attack` $949A without its dice (the commit gate at its widest roll, the relations skip and veto not firing, the 1/100 wildcard left out): AIMED (picked, every gate clear) 71 fief-seasons attacked 39 (55%); picked but gated 1,073 attacked 2; not picked 16,520 attacked 6. The 47 is the alternate pick's override (`pick_ai_attack_target_fief` prefers the player's fiefs), not the commit gate (ratio − 10 − rng(skill×3) > 60).

`expand.AIM` (`--aim N`; off): **1**, an old COMING nobody aims at is SAFE: **186 of 240** (against #101's 185: saved 24, lost 23), old age 29 → 13 but later invasions 5 → 18, every one a one-fief opening. **3**, the three states read off `ai_war_aim` (`aimed_state`): first **0 of 240**, the eternal HUNTABLE (fiefs 12 and 7 always someone's pick) froze the empire through every all-SAFE gate (955 men beside a 257-man target for twenty years); `quiet()` lets HUNTABLE pass the empire-wide gates (the fief's own line still answers it): 69; `grade()` in the post-strike check (the source that just sent its army reads HUNTABLE): **186** (old age 19, later invasions 15). **4**, the look-ahead: a harvest alone never moved a label (the gates bind on men: the ratio, and min(2 rice, men, gold)); each neighbour's biggest recruit (`forecast.grow_ai` at p=1): 186; then **every** AI fief's recruit, after every fief's harvest in Summer (a neighbour's pick turns on its own neighbours' men; Echizen 4/3010 read SAFE in Summer, and in the Fall fief 8 had harvested and hired 45 → 69, leaving Echizen fief 10's weakest: 10 hit 62 men with 52, 5 took the 8 left): **189 of 240** (saved 25, lost 21, z +0.6; wins 2 years sooner), old age 29 → 17, later invasions 5 → 14. `--aim-min 2` (the old states while one fief is held) 183: the opening holds both halves of the trade. The openings still lost: the alarm rings with nothing in the treasury (the reader gives every Spring's gold and every Summer's rice while SAFE; Echizen sat at 62 men under a line of 101 with 75 gold for a year). The old COMING kept that reserve by accident.

### #112 — Standing fiefs up: unsafe spells are short, and hiring before the tax costs the economy (Chris, 2026-11-23)

Chris: *something is missing in getting new fiefs up and running sooner; it is silly that it thinks it can stand them up faster alone; I get the morale, but rice to feed men? We are drowning in rice. With the other fiefs maxed, new fiefs can be sent gold and rice almost every turn; they should manage two buys of men a year and still give rice for morale and wealth. We should not have to risk the empire to stand up a new fief.* **The census** (`standup.py`, `standup2.py`; 12 games of #101's player): new conquests are mostly SAFE at once (185: seasons to SAFE quartiles 0 / 0 / 1); any fief's spells out of SAFE, 179, quartiles 1 / 1 / 2 seasons (one of 51). On the 258 unsafe turns the fief had the gold and morale to hire 179 times (no gold 52, morale under 55 27) and did: hire 144, **the ladder's tax rung 72**, the reader 38. Donors sent to unsafe fiefs 158 times: 27,399 gold, 5,588 men, **no rice** (the safety line asks only for rice its own harvest cannot feed). `expand.SECURE_FIRST` (`--secure-first 1`; off): an unsafe fief short of its line hires to it before the tax rung. **173 of 240** (against #101's 185: saved 13, lost 25, z −1.9), econ y20 0.69 → 0.66, 11 more games to age. A tax raised now compounds through every harvest after it; a hire a season late costs less. With #87 (every fief), #102 and #110, the fourth time a turn taken from the economy outside the one-fief opening has lost.

### #110-#111 — Owari's logistics: men marched toward unsafe fiefs, and the surplus rice sold (Chris, 2026-11-23)

Chris, stepping through Owari 3001 at skill 2 (#108's stepper; without `--preset best` it plays the plain player): *Omi is taken; ever since, the economy grows while Mino and Omi struggle to stay SAFE; Mikawa hires a lot but never attacks, since Mino and Omi are not SAFE; why can we not transfer men, gold or rice to Mino and Omi? The Mikawa men do very little. Why can the capital not be a true depot, no men, feeding everyone? And we end with lots of rice everywhere: we should be able to do something with it.* The code: in `empire_move` a fief's spare men Move only to an adjacent line; marching a step toward a farther fief was only for the attack line, so a back fief's men never reach an unsafe fief two steps off (gold reaches any fief by Send, #74); the capital's garrison is #92's floor (Chris: *the trouble with only men on the front is that losing one makes an exploitable hole; I would rather stop losing the front than hedge*: later); the surplus rice only went to morale (#88).

**#110**, `expand.MARCH_SAFETY` (`--march-safety 1`; off): spare men march a step a turn toward a COMING or HUNTABLE fief up to 4 steps off, each march pledged against its shortfall. **176 of 240** (against #101's 185: saved 4, lost 13, z −2.2), 8 more games to age; marches 2,842 → 4,113: each takes a turn a fief would have spent on a Send or a hire (#83's and #100's lesson).

**#111**, `expand.RICE_SELL` (`--rice-sell 1`; off; Chris: *it needs a merchant and the fief low on gold so the cap does not hurt it, and not on a Summer turn*): a topped-out fief outside Summer, a merchant here, gold under half its header, sells the rice over its shield and a year's upkeep, only as much as its treasury can take (`effect_sell_rice_for_gold` $8B0A). **183 of 240** (saved 6, lost 8, z −0.5), wins about half a year sooner; 1,073 sales turned 712,000 rice into 1.18 million gold, mostly in fiefs with nothing left to buy. Off.

### #108 — The stepper played an old player: `na1sim.trace` now takes long_game's flags and preset (Chris, 2026-11-23)

Chris: *rerun Suruga 3001 at skill 1: the stepper shows he makes it to 16 by Spring 1577, then collapses, and could finish before old age at Spring 1589; if that is still happening and we can avoid the disaster, we might find a few more wins.* On the current player (`long_game --preset best --skill 1`) Suruga 3001 **unifies in 1580** (year 21): 7 fiefs in 1574, four lost to Oda over two seasons of 1575 (Mino, Shinano, Echigo, Musashi), 9 by 1577, 12 by 1579, all 17 in 1580. The stepper had built its own job with only the #65-era flags (strike, stage, combine, capital first, capital guard, secure, ladder): with them the same seed never unifies and the lord dies in Spring 1589, Chris's game. **`na1sim.trace` now parses `long_game`'s own arguments** (`long_game.parser()` and `jobs_from()`, factored out of `main`), so `py -3.14 -m na1sim.trace FIEF SEED OUT.json --skill 2 --preset best` steps through exactly the raced player, and records every flag in the trace.

### #106-#107 — Hatakeyama's opening wired in: Noto's first unifications; and the attack line's keep that counts its own target (Chris, 2026-11-23)

Chris: *wire in the Hatakeyama opening and race Noto, then look at specifics to see why they never get rolling.* **#106**: `long_game --opening` (default: the searched opening where a start has one; `none`; or a comma list of `policy.OPENING_ACTIONS` steps), `OPENINGS = {0: ("hire", "tax", "rice>peasants")}`: the #4x search's best for Hatakeyama (Spring: hire with all the gold; Summer: the tax to 55; Fall: the harvest's rice to the peasants; skill 1, 12.7% → 30.7% alive at year 3), played by `policy.plan_policy` before the tail. Noto at skill 2, the #101 player, 100 seeds: **alive at year 3, 10 → 32**; over 70 years **3 of 100 unify** (none had in any race). How the 100 ended (`na1sim.triage`): revolts 22 (20 in year 1: 13 before his first command at morale 23, 7 on turns 1-2 as the hire dilutes it, the trade the search accepted to halve the invasions), invaded before turn 1 6, in year 1 36, later 22 (years 2-41), old age 11 (4 never past 5 fiefs, 7 stalled at 7-14). 62 die in year 1; of the 38 survivors 3 unify.

**#107**, why one never got rolling (`whystuck.py`; 3007, one fief for 50 years): Noto's header is 960; by year 20 an attack line on Kaga (Takeda, 153 men) stood 9 men short (542 against 361 + 190); at year 24, 673 men against a line of 513 + 272: **the keep is `own_need`, Noto's share line against its enemy neighbours, and its only one is Kaga, the fief it attacks** (on a win Kaga is ours; a loss is priced by #94's RISK; Kaga kept 1,184 men against Noto the same way in #82). `expand.KEEP_EXCL_T` (`--keep-excl-t 1`; off): the line's keep answers the source's other enemy neighbours, the capital's line and the floor. 3007 takes Musashi and holds two fiefs at year 24. But on the 12 live starts **174 of 240** (against #101's 185: saved 10, lost 21, z −2.0), 11 more games to age; Noto 3 of 100 (saved 2, lost 2). Every source then strikes thinner, where #94's hazards were measured with the old keep. Off.

### #105 — Noto's single entry: two blockers pin the attacker's commander to one cell on every coin; the battle is still lost on numbers (Chris, 2026-11-20)

Chris: *Noto has only one way in, and it is narrow; the leader lands at (1,2) or (1,4), easily covered by two units: if we place (2,3)/(2,4), does it force the leader to a more open spot? There are only 10 setup spots and 10 units in all; we should be able to manipulate this opening.* The atlas (`deploy_case` in `tools/battle-entry-atlas.py`, the ROM's scan $9954 with our units placed first, as the human defender places): Noto (fief 0) is entered only from the west (Kaga), the seat far east at (9,1), the attacker's strip x 0-3 with 10 open cells; on the coin his commander lands at (1,4) (guards (1,3), (2,4)) or (1,2) (guards (1,3), (2,3)). **With ours on (2,3)/(2,4) he lands at (3,1) on all four coins** (guards (2,2), (3,2)): the strip's corner on the open field. Units placed beside (3,1) make the scan fail (a random drop); **every pair two hexes off ((4,0), (4,3), (5,0), (5,1), (5,2)) keeps the landing at (3,1)**. `plans.NOTO` (`long_game --plan strike|hold|trap` at start 0): the lord on the seat, the blockers on (2,3)/(2,4), hitters on (4,0)/(5,1); `trap` sends the blockers away once the landing is done (their work), the hitters strike.

Noto's first three years, 100 seeds, alive: **doctrine 10, strike 4, hold 4, trap 9**. A traced pair: 26 attackers against our 48, held (his commander killed on day 2, as planned); 63 against 39, lost: under the 20 × 5 split each of our units holds about 8 men, the blockers inside his strip take his guards' and drops' blows on day 1, and the 8-man hitters cannot kill a 19-man commander. The landing is ours to choose; the battle is decided by the year-1 armies' size, as at Musashi (#104). Off.

**Conditional, and the rebels** (#109, Chris: *8 men each will not kill many invasions, and he has no time or gold to reorganize; force it if the attacker's troops are X or less, otherwise go full defensive; it might work against a rebellion, as those tend to be 50/50s*). `plans.TRAP_RATIO`, `--plan trapif`: the trap only against an attacker with at most our men, else the doctrine. With Hatakeyama's opening (#106), alive at year 3 over 100 seeds: **doctrine 32, conditional trap 25**: even against a weak attacker the doctrine, its five units kept near the castle, beats the trap's two blockers in his strip. Rebels (attacker 50) at Noto get the whole board (edge 0): their commander lands in the far east corner beside our castle ((10,4) or (10,3)) on half the coins and in the west on the other half, where the blockers pin him to (3,1) as they pin Kaga's; a rebel plan would need both corners. Noto's tactics are closed: his losses are the dice of year 1 (Chris).

### #104 — Hojo's chokepoints: Musashi's pocket is held as planned, and his early battles are lost on numbers (Chris, 2026-11-20)

Chris: *Hojo has possibilities. From the north the coin flip sets him up in the corners; we cannot fight the leader, but there are two chokepoints, (4,1)/(4,2) covering (3,1) and (6,0)/(6,1) covering (7,0), close together: put 1/3 on one side and 2/4 on the other with the leader in the castle; after the attacker's setup the unused side comes to (5,0)/(5,1) to reinforce the attacked side. From the west the (4,1)/(4,2) choke still holds. I do not think Hojo can win every combat, as space is tight, but this can give better odds.* The sim's Musashi (fief 2) agrees: the castle pocket (columns 4-6, the seat at (6,4)) has two ways in, the west gap (2,1)/(3,1) and the north-east gap (7,0) (column 7 blocked from row 1 down, so the east column is a dead end); from the north his commander lands at (10,0) or (0,0), from the west at (0,4) or (0,0) (`assets/maps/battles/entries/atlas.json`); the north strip covers rows 0-2, so his random drops can land inside the pocket. `plans.MUSASHI` and a `choke` mode on `PlanPlayer` (`long_game --plan choke` at start 2): north, 1/3 at (4,1)/(4,2) and 2/4 at (6,0)/(6,1), the commander on the seat; once his commander's side is known the pair on the quiet side moves to (5,0)/(5,1); west, 1/3 at the choke and 2/4 behind it; each unit strikes what comes next to it (his commander first, else the weakest), our lord fights only at the seat.

Hojo's first three years, 100 seeds (`chokeprobe.py`): alive after three years **43 under the chokepoints, 47 under the doctrine**. By the attacker's men over ours: under 1× from the west the doctrine holds 46 of 55 and the chokepoints 48 of 55; 1-2× 4 of 17 against 1 of 17; **at 2× and more, 0 of 29 and 0 of 32**: most of Hojo's early deaths are battles at twice his men or more, lost under any placement (our commander falls in the castle, outcome 5). Hojo's problem is numbers, not formation: the plan stays available, off; the lever is men in the first year.

Chris: *coming from Suruga and Shinano, do three hitters stand a chance against the leader and guards, or is it too tight? A second hit on the same unit every turn helps, but not enough to beat high odds: at best it beats 1:1+, at worst it slows the attacker.* `plans.MUSASHI_HIT` (`--plan chokehit`): from the west, slots 1-3 on (0,2) (1,1) (1,2), two hexes off both coin landings, striking his commander and the guards in the way, slot 4 holding the choke at (4,1), the lord on the seat; from the north the chokepoints. West battles over the same 100 seeds: under 1× held 47 of 55 (doctrine 46 of 55), 1-1.5× 1 of 8 (2 of 6), 1.5× and more 0 of 13 (0 of 16). A traced battle (54 men against 54): every unit about 11 men under the 20 × 5 split; on day 1 the guards stand between the hitters and his commander, and one exchange with the 15-man guard takes two of the hitters to 1-2 men. Too tight: split five ways the hitters do not survive the guards, and the extra hits do not change the bands. Off.

### #102-#103 — Two opening rules that do not help: hiring for an unpicked COMING fief, and jumping the tax (Chris, 2026-11-20)

**#102**, `expand.THREAT_COMING` (`long_game --threat-coming 1`; off): #87's threat-first hire (the one-fief opening hires to its men line before the tax rung) also for a COMING fief no neighbour has picked yet (4/3008, 5/3015, 15/3016: a man short of the line). With the tax step: **88 of 240** (against #101's 185: saved 6, lost 103), invaded 23 → 102, econ y20 0.69 → 0.56: before anyone picks it, a COMING fief's men line answers every neighbour's budget, and hiring to it every turn starves the opening. #87's rule (only once a neighbour has picked the fief) stands; a narrower rule (only the men missing) is open.

**#103**, Chris: *if fiefs with 70+ loyalty are using tax steps, do not: go straight for 55%; 59+ might get away with a gamble too, but A/B compare: an early loss may be the same as a death.* And: *70+ can jump to 55% with no risk; it is the 45-69 ones that gamble.* `expand.TAX_JUMP` (`long_game --tax-jump N`; off): loyalty at N or more takes the tax straight to the cap. With the tax step: **70: 185, identical game for game** (the rung already takes the largest raise that keeps loyalty over the cliff, so 70 already goes to 55; the creep happens only at the cliff); **59: 180** (saved 12, lost 17), econ y20 0.66, start 14 17 → 13: the gamble from the 45-69 band costs. **Promoted (#101):** `--preset best` adds `--tax-min-step 5`: 185 of 240.

### #101 — The early one-fief deaths, traced turn by turn: the tax rung crept two points a turn. 185 of 240 (Chris, 2026-11-20)

Chris, reading #99's run (183): *we optimized this pretty hard, but concrete examples can fill in details; we only have to play 3-4 years.* `earlydeaths.py`: every death after our first turn and before year 4 (17), each turn's action and state and every battle at our fief. **The tax rung creeps**: Asai 10/3019 raised the tax 20 → 44 on turn 1 (loyalty 58 → 45, just under the cliff 46), then 2 points a turn, 44 → 55 over six turns, because a 2-point raise on 45 loyalty drains 45 × 2% = 0, which keeps the rung's test (loyalty after the drain at least the cliff − 1) true; all the while COMING, a man short of its line (58 against 59), with 58-138 gold to hire him. The same in 4/3004 (six turns), 4/3008, 5/3015, 15/3016. Chris: *you lose stat points each time you raise it, too* (each raise drains loyalty and wealth, `econ.tax_effect`, and costs the lord a point of charisma, `set_tax` $9A1B); *those struggling to get high taxes need a better player that takes their position into account.* `expand.TAX_MIN_STEP` (`long_game --tax-min-step N`): the rung fires only for a raise of N points or more, or to the cap.

| the 12 live starts, 240 games | won | paired | invaded | win year |
|---|---|---|---|---|
| #99 (`--preset best`) | 183 | | 25 | 26 / 30 / 34 |
| **+ tax step 5** | **185** | saved 5, lost 3, z +0.7 | 23 | 25 / 29 / 34 |

10/3019 and 4/3004 survive their first five years. **Promoted:** `--preset best` adds `--tax-min-step 5`. The second pattern in the traces: 4/3008, 5/3015, 15/3016 were COMING and one man short of the line, and #87's threat-first did not fire because no neighbour had picked them yet (`threats` empty): #102.

### #100 — The defensive Assign: a capital out of an attack's split costs more turns than it saves (Chris, 2026-11-20)

Chris, on Hojo 3019 (#99): *poor Hojo, he went with the army and lost; it brings up reassigning if the fief is not SAFE; 100/0 might be fine for now.* `expand.DEF_ASSIGN` (`long_game --def-assign 1`; off): a capital that is not SAFE spends its turn on an Assign to 100/0 (every man in the lord's unit). First with the commander row under half the army: **169 of 240** (against #99's 183: saved 21, lost 35, z −1.9), 416 Assigns in 228 games, nearly all on turn 1: every capital starts in the scenario's 20 × 5 (the split the defence doctrine does best with, #43) and many are COMING on turn 1, which they then spent reshaping instead of hiring (Hojo 3019 died on turn 1 instead of fleeing at year 18). Then only under 10% (an attack's 1/99): **179** (saved 6, lost 10, z −1.0), 203 Assigns in 148 games: a capital that is also the striker swings between the attack's split and the defence's, each swing a turn. With #99's Flee the 1% commander runs instead of dying, which covers the case at no cost of turns. Off.

### #99 — The 180 run read by start: the revolts are the fluke, and the Flee that missed. 183 of 240 (Chris, 2026-11-20)

Chris read #95's run (180) start by start: Uesugi a revolt (a won game that revolted after unifying) and a turn-1 invasion, so maxed if the revolt is the 1-in-1,000; Hojo 8 turn-1 invasions (parked until tactics), a revolt, and a year-18 invasion at 2 fiefs (*were they disconnected so he could not flee?*); Asakura 3013's 5-fief invasion (#97's output wipe); Imagawa's early losses and eight age-outs at 2-12 fiefs; *more revolts than I would like*.

**The revolts** (`capprobe3.py`): past turn 1, all four came to an empire of 1-2 fiefs in years 11-18 (2/3004, 10/3011, 15/3008, 5/3012), at capital morale 52 / 86 / 56 / 401 and charisma 93 / 77 / 125 / 110: neither roll can fail at 45 or more (`_roll_failed`), so each was the 1-in-1,000 draw (#85's estimate, about 5% of games), and a one-fief empire's only fief is its capital, where the rebels' morale (the header less ours, about 1,500) wins.

**Hojo 3019**: Shinano (15) was his and bordered the battle fief, but the Flee never fired (#96's `Fleeing`, on in `h96_fb`). The day-by-day trace: our commander held **9 men** (the capital still in an attack's 1/99 split, #75); the enemy's 21-man commander closed over eight days, and on day 9 the doctrine sent ours to attack him and he died; the lethal test simulated only the enemy's blows. Fixed: units within two cells count (the attacker side acts first each day), and the commander also flees on **the ROM's own flight test for a lord** ($A84D: his men doubled under the enemy men next to him; here 18 against 21, a unit more than twice his strength). Hojo 3019 then flees in year 18, reaches 5 fiefs and lasts to year 43.

| the 12 live starts, 240 games | won | paired | invaded | revolts |
|---|---|---|---|---|
| #95 (`--preset best`) | 180 | | 29 | 6 |
| **+ Flee (lethal, or the ROM's test)** | **183** | saved 5, lost 2, z +1.1 | 25 | 4 |

Tokugawa 20 of 20; start 5 16 → 18. **Promoted:** `--preset best` adds `--flee 1`. **Open:** the capital that keeps an attack's 1/99 split defends with a 1% commander, and at the capital his death is the faction: reshaping it back, priced for the turn it costs.

### #98 — Disaster cliffs: a recovery that works, and cliffs that are rare (Chris, 2026-11-20)

Chris: *the formula is less useful, but we need recovery.* `expand.RECOVER` (`long_game --recover 1`; off): a fief at output 0 Grows first with the gold over its upkeep reserve (after the wipe the drain takes from a loyalty of 0, so it costs nothing; and the ladder no longer spends the wiped fief's every turn on a peasant Give the cartridge refuses); a rank-0 `recover` ledger line has the donors fund its Grow and upkeep; in Spring and Summer a rank-0 `upkeep` line covers any fief whose gold and this Fall's income will not pay the army's upkeep (4/3013's 397 → 20 men). 4/3013: the capital Grew 685 gold in year 31 (output 0 → 210) and the game ends in old age at year 45 instead of an invasion at 31.

Chris: *if loyalty drops to 0, is that not an instant revolt? Pad before the cliff?* Revolts roll on morale and charisma (#85), not loyalty; riots roll on loyalty, but `riot_eligible` ($9DA3) also requires output > 0, so a fief at output 0 cannot riot; once Grown, a loyalty of 0 fails every sweep's roll and the 1-in-4 gate decides, and a capital riot cannot be paid off under 25 loyalty: the recovery must follow its Grow with a gift past 45 at once (the ladder gives 60 a turn). Padding: disasters hit about 10% of fief-years (typhoon 3.75%, output × about dams × 90%; plague about 6%, × 50-99%), so output 2 is one or two hits from 0 and output 50 about ten; the Grow's drain is half its gain's share of output, cheap high and brutal low (100 → 120 drains about 8%, 2 → 50 drains 50%): a floor would be kept with small top-ups before the decay.

On #95's player (180): **179 of 240** (saved 0, lost 1; 239 games identical). **Three fiefs reached output 0 in 240 games** (fief 0 at year 28, Asakura's capital at 31, fief 5 at 20), each Grown back to 210-250; the donor lines sent 5 times (970 gold). At about one game in 80 neither the recovery nor a floor moves the count; the recovery stays as insurance, off (with the post-Grow gift to add before it is used).

### #97 — Asakura's output trap, and an econ lab for one fief's best development path (Chris, 2026-11-20)

One of the six games the 180 player lost that the 92 player won (4/3013) died of its economy. Asakura's capital, 5 fiefs at year 31: its **output (the land) had sat at 1-2 of a 1,740 header for years** while loyalty and wealth were maxed; in Spring of year 31 it reached 0, and the cartridge's `clear_econ_stats_if_no_output` zeroed loyalty and wealth (1,737 → 0); with loyalty 0 there is no income; its gold went on men (822 → 10); at the Fall harvest `consume_province_army_upkeep` cut the army to what the gold could pay (397 → 20 men), and Takeda's 208 took the capital (`capprobe2.py`, `w16` watch). **Our player never develops output**: snapshots every 5 years in 12 games (`outputcensus.py`, 304 fief-years), output under 5% of the header in 37%, 5-25% in 52%, 25%+ in 11%; capitals under 5% 71 times. Typhoons (output × about dams × 90%), plague (× 50-99%) and riots (−10-60%) wear it down, and nothing rebuilds it. The formulas (`vmprims`): a Give to the peasants gains loyalty ∝ gold / √((loyalty + output)/2 + gold) and wealth ∝ gold / √((wealth + town)/2 + gold), each doubled, with no other cost, **and is refused at output 0**; Grow gains output ∝ gold / √(output + gold), doubled, and drains loyalty and dams by half its gain's share of output (**a flat 50% when the gain is over twice the output**); Build gains town the same way and drains wealth. Income: gold = (loyalty × 40% + wealth + town) × tax, rice = (loyalty × 40% + wealth + output × dams) × tax. So at output 2 any Grow halves the maxed loyalty: the price says never, until a disaster takes it to 0 and nothing can be given.

Chris: *start with an econ sim with a longer horizon; Asakura's trap is real but maybe it should not have got that bad; a sim can become a function: given loyalty / wealth / output / town / dams / rice / gold, the best MIRR; we cannot plan for disasters, but we can find the best way out using math. Grow and build gave less than giving to the peasants, and they have downsides, and development makes later gifts dearer; gifts worked because the increase was large and cheap with no downside.* **`na1sim.econ_lab`**: one fief, every turn on development, the real commands (Give gold or rice, Grow, Build, Dam, raise the tax, or export the surplus to the rest of the empire at par), the real year (marks reset at Summer, the harvest at Fall with the mean roll and the upkeep), no disasters; a beam search over H seasons for the plan of most value at r a season (the treasury's real change at each harvest, after the clamp and the upkeep, less the spend, discounted; at the horizon the treasury left and the last harvest as an annuity), against "peasants only" (every turn all the gold over the upkeep to the peasants). 5 years, r 0.08, 400 men unless noted:

| state (loyalty, wealth, output, town, dams) | peasants only | best plan | the best plan |
|---|---|---|---|
| Asakura, year 30 (1,737, 1,737, 2, 44, 71) | 4,352 | 23,832 | develop nothing, export the surplus |
| mid-game (600, 600, 200, 100, 50), 300 men | 4,081 | 9,757 (+139%) | gifts, half-sized in Fall and Winter, export in Summer; never Grow, Build or Dam |
| early (117, 117, 400, 50, 30), 120 men | 2,235 | 2,749 (+23%) | gifts, timed the same way |
| wiped (0, 0, 0, 44, 71) | −1,015 | 2,902 | export; no recovery |

- **Gifts dominate, and their timing is worth as much as their target**: the best plans gift half in Fall and Winter and export in Summer (a Summer gift misses the Fall's marks).
- **Asakura's output 2 was right, absent disasters**: no Grow pays back halving 1,737 loyalty within five years.
- **A wiped fief cannot recover alone while it keeps an army**: a hand-made recovery (Grow 599 gold, output 0 → 198 at no loyalty cost since loyalty was 0, dams 71 → 36; then 1,100 rice to the peasants, loyalty and wealth to 258 and 266) earns about 250 a year against the 400 men's upkeep (200 gold and 200 rice): value −2,106. It needs gold sent in, which is what 4/3013 lacked.
- **Open (the next step):** the lab as a function for the player (gift timing; the cliff's insurance against output 0, or its recovery with imported gold); disasters as expected hazards; the beam ranks nodes by income now, which hides a payoff a turn away (it pruned the Grow from output 0).

### #96 — The lord may Flee: the ROM's verb for the human, lethal-only, and the losing defence burns its gold; neutral (Chris, 2026-11-20)

Chris, on 1/3018 (Uesugi at 11 fiefs, the capital lost in year 31): *we need a flee command; capitals should not get invaded, but if they do we do not have to stick around if we can flee; check adjacency, as the engine may not prevent a flee with nowhere to run; and even then, burning gold and fighting to almost the last man is the best way to damage the attacker.* Then: *the lord must not abandon the capital because one unit shows up; flee when we know the attack will wipe the leader unit*; and *burn gold only if we know we are losing: I do not want the enemy coming at us in a battle we can win, burning all the gold on a bribe that cannot work, and then winning*.

**The ROM's Flee** (verb 3, `combat_flee_to_fief_command` $AAA7, decompiled): the commander only; the destinations are the fleeing side's owner's fiefs among the battle fief's neighbours (`load_fief_neighbor_list` $DAAB, `build_daimyo_province_list` $90BB), none and there is no flight; it sets the winner to the fleeing side's own fief, so `apply_conquest_outcome` ($E03C) hands the fief to the attacker, and on a daimyo-led side it relocates the capital (`end_war_relocate_capital` $8F55), which clears the side's bit, so the faction is not handed over ($E117 tests the loser's bit). `tactical.human_command_loop` now takes `("flee", dest)` (`tactical.flee_destinations`). **`strike.Fleeing`** wraps the defence player: the commander Flees only when the blows waiting for him would kill him (on a copy of the battle, `forecast.held`, which restores memory and the RNG, every enemy unit adjacent to him makes its exchange and his unit is gone), from our capital, to the owned neighbour holding the most men (`--flee 1`); with `--burn 1`, once our men are under half the attacker's (the AI's own weak test) and he is not about to die, he bribes away the gold over our men each day, in any fief we defend.

| on #95's player (180), 240 games | won | paired | invaded |
|---|---|---|---|
| #95 (`--preset best`) | 180 | | 29 |
| Flee (#94's player) | 176 | against 178: saved 2, lost 4 | 27 |
| **Flee + the losing burn** | 179 | saved 10, lost 11, z −0.2 | 26 |

`fleecount.py` (60 games): our capital defended 19 battles to the end; the lethal test fired 10 times, and only once was there an owned neighbour to run to: most capital defences come while the empire is one fief. Correct and harmless, rarely in reach: off.

**Against the 92 player** (#74, on the same 240 games), the best run (180): saved 94, lost 6. Invaded later holding 9+ fiefs 10 → 0; old age stalled at 6-14 fiefs 51 → 14; invaded in year 1 24 → 11; every start better (Uesugi 10 → 19, Hojo 2 → 10, start 5 4 → 16, start 14 7 → 18). Never started 8 → 10. The six lost: 4/3013 (invaded in year 31 at 5 fiefs, our 20 men against 208), 13/3019 (one fief, 121 against 123), 10/3011 (a revolt at 2 fiefs), and three to age (6/3012 at 4, 12/3006 at 13, 15/3004 at 8).

### #95 — Chris's triage, and Tokugawa's one-fief years: a striker stuck in the morale dead zone. 180 of 240 (Chris, 2026-11-20)

`na1sim.triage RUN.json [--start F]` sorts a run the way Chris reads it: unified set aside; then revolts and riots, invasions before the first turn, in year 1, later, and old age by peak fiefs (5 or fewer: never started; 15+: one short). On #94's run (178) Chris read: Uesugi's 3002 and 3018 say too much risk where 3012 shows it paying; Hojo loses only to turn-1 invasions (tactics, not strategy); Imagawa (start 6, the shortest clock: his lord dies at years 30-32) won 9 under #92 and 6 now; 6/3019 is a win (unified 1582, a revolt after); Tokugawa wins all but 3012, never started.

**Tokugawa 3012** (`slowstart2.py`, `owari.py`, `tokuhire.py`): Owari (46 men) priced at MIRR 0.40-0.49 against r 0.09-0.32 in six years (4-10) and was refused every time, for two reasons stacked. (1) The first conquest makes the empire two fiefs and #92's capital floor applies, but the line (`_stage_line`: send + `own_need`) adds the capital's line only from two fiefs: 127 men left against 150, `capital_ok` fails, no attack line forms. (2) With the line fixed, Mikawa sat at 236 men from year 7 to 11 at **morale 50-51**: `striker_hire` needs `MORALE_FLOOR` 55 (recruits arrive at 40-59 and dilute it), the ladder lifts morale only under the cliff (45) and the capital guard only under 50: a dead zone where the striker can neither hire nor raise its morale. `expand.CAPITAL_NEED` (`--capital-need 1`): a lone capital's attack line carries the floor (first tried in `own_need`, where it made every lone capital hoard men: 160, z −3.0). `expand.STRIKER_MORALE` (`--striker-morale 1`): a striker short of its line and under the floor gives rice over its men (else gold) to its men first. Tokugawa 3012 unifies (1598) with both.

| on #94's player, 240 games | won | paired | lord died | invaded |
|---|---|---|---|---|
| #94 (`--preset best`) | 178 | | 31 | 27 |
| both fixes | 166 | saved 18, lost 30, z −1.7 | 36 | 29 |
| capital floor in the line only | 173 | saved 7, lost 12, z −1.1 | 34 | 27 |
| **striker morale only** | **180** | saved 20, lost 18, z +0.3 | **25** | 29 |

**Promoted:** `--preset best` adds `--striker-morale 1`; the line fix stays off.

### #94 — Risk priced, not gated: attacks weighted by measured outcomes, the hazards calibrated from the games. 178 of 240 (Chris, 2026-11-20)

Chris, on #93: *keep the tax fix, it is correct; not assessing risk properly is the stronger signal. The deadline rule is ad hoc. This is like pricing the army size, a wide range of acceptable values; sometimes keeping your neighbours down and the world at war instead of economy lets you grow. The model plays it safe because it can usually find inevitability; many of our hurdles are when inevitability is not there and we do not gamble on our outs. Sometimes starting wars hurts your opponents more than it hurts you.* The principle: price risk as expected cash flows, every probability measured from the sim's own games (as the battle lab priced the battles), and let the price replace the gate.

**The hazards** (#92's player, 3,299 battles): battle lost 4-5%; prize lost within a year by the state it is left in, SAFE about 1%, HUNTABLE 2-5%, COMING 15% / 23% / 27% at 2-4 / 5-8 / 9+ fiefs; the source lost within two seasons, 0.2-1.1% after a won battle, 7-12% after a lost one. `expand.RISK` (`long_game --risk N`): `attack_mirr` weights its flows by outcome: the battle won (`p_win`, the lab's table) and the prize kept (`p_hold`, by its state after the win and the empire's size); won and the prize lost (its income and men gone, the treasury and freed bill kept); the battle lost (every man sent, and the source lost `RISK_SRC` of the time: its harvest annuity and men); the prize at its true tax (#93). In `score` the prize may be left up to COMING when that priced MIRR beats r (`risk_ok`, read on the map before the move); every other fief must still be SAFE.

| the 12 live starts, 240 games | won | paired | invaded | lord died | win year | first conquest | COMING prizes taken (lost in a year) |
|---|---|---|---|---|---|---|---|
| #92 (`--preset best`) | 173 | | 29 | 36 | 27 / 31 / 35 | 12 / 13 / 15 | 346 (80) |
| risk, round 1 (the hazards above) | 175 | saved 24, lost 22, z +0.3 | 34 | 29 | 26 / 30 / 34 | 10 / 12 / 14 | 1,404 (540) |
| **risk, round 2** (round 1's own hazards) | **178** | saved 23, lost 18, z +0.8 | 27 | 31 | 26 / 30 / 34 | 11 / 12 / 14 | 1,353 (475) |

- **The first hazards were biased**, as expected: they came from prizes left COMING by accident. Chosen COMING prizes were lost 24% / 43% / 47% (round 1's games); priced so (round 2, with SAFE 95-97% and the source 12%), the games lost them 24% / 37% / 42%: close to a fixed point.
- **Gambling on the outs**: the first conquest about two years sooner, wins about two years sooner, fewer games to age, and invasions back under the gate's (27 against 29). Start 15 6 → 12; Uesugi 18 → 16, start 6 9 → 6.
- **Promoted:** `--preset best` adds `--risk 2` (the true prize tax with it). **Open:** the other side of Chris's point, the cost of not attacking (the hazard on our own border as the neighbours arm, and what a war costs the rival), measured the same way; the whole-empire SAFE gate for the other fiefs, still a rule.

### #93 — Uesugi's development trap: the windows, and the prize priced at the conquest's tax (Chris, 2026-11-20)

Chris: *MIRR is doing its thing right, but it does not know it is so far behind that it cannot catch up. Was there a window to attack from 8 to 24? Maybe we are not pricing conquests properly?* `pricing.py` (Uesugi 3012, the #92 player): **year 16**, Sagami (Hojo, 92 men): send 217, line 434; the flows invest 1,823 (217 men at 8.4 gold) for 364 at the conquest and 1,194 a harvest, terminal 2,826: **MIRR 0.175 against r 0.13, an attack**; `strike_ok` refused it: after the win Sagami is COMING (Hojo's Shinano beside it). **Year 20**, Sagami at 190 men: send 513 (the hold-sized line 785) invests 5,027 (9.8 gold a man) for **1,020** a harvest, terminal 4,218: MIRR 0.047 against r 0.161 (Echigo's own gift: 564 gold for +259 a harvest). Sagami's harvest as ours is **1,814**: the pricing writes the conquest's tax (min(tax, 30), as the cartridge does on a conquest) and keeps it for the whole horizon, while the ladder's first rung raises it toward 55 within a turn or two, so every conquest's income was priced about 45% low.

`expand.PRIZE_TAX` (`long_game --prize-tax 1`; off): the prize's harvests priced at the ladder's tax (55; Honganji 30) in `attack_mirr`, `attack_price` and `wave_plan`. On #92's player: **163 of 240** (saved 15, lost 25, z −1.6), invaded 29 → 35, revolts 2 → 5, econ y20 0.68 → 0.66; Uesugi 18 → 16, Hojo 11 → 9, start 4 15 → 18. The low price was offsetting the attack price's optimism (no losing branch, the prize always held: `EMPIRE_LOSS` off, #71): corrected alone, the planner attacks more and loses more. Off. **Open:** Uesugi's trap as Chris framed it, being behind: the cost of waiting (the target's growth, 92 → 190 men in four years, is not charged to development) or the deadline (#61: no conquest by about year 12 halves the win rate; the year-16 window died on the hold gate).

### #92 — Uesugi and Hojo read game by game: the empty capital; a capital floor of 150 men. 173 of 240 (Chris, 2026-11-20)

Chris read #90's race (162): *Uesugi 16 wins, 1 turn-1 invasion (dice), 1 revolt, 2 old age at peak 5 (he never got started): fix the revolt, and why he cannot get past 5. Hojo 8 wins, 8 turn-1 deaths (grudges in a big neighbourhood, many coin flips; can his defence improve?), and the age-outs, where he has a winning game he does not convert.* Read from the json: Hojo's losses were 9 invasions in year 1, invasions at years 16 (2 fiefs), **23 and 28 (9 fiefs each, the capital at 0 men, taken by 5 and 38 men)**, and one age-out at 15 fiefs. `capprobe.py`: in 3009 the capital, interior (no enemy two steps out, so `capital_line` 0), sat at 0 men for two years holding 1,980 gold and 1,980 rice; in 3019 the empire's Moves took it from 138 to 0 (its keep was the capital line, 0) and it sat empty with 1,700 gold. Uesugi's revolt (3002, year 33) came at morale 721: the 1-in-1,000 roll (#85). Uesugi 3012 (one fief until year 28; `slowstart.py`): the MIRR attack line stood at years 4-8 but he could not afford a line of 410-545 men on 50-80 gold; from year 12 his own gifts' IRR (r 0.24 a season) beat every attack (0.14-0.18), he grew his peasants 515 → 1,720 while the neighbours armed, and by year 24 every attack priced near 0: #61's deadline, which MIRR does not see; several strikes also failed `strike_ok` (the prize left COMING beside Hojo's other fief, not checked).

`expand.CAPITAL_MIN` (`long_game --capital-min N`): `capital_line` is at least N (capped at the header), so the capital never Moves below it and `capital_hire` hires up to it, past the morale gate when empty (as `CAPITAL_GUARD`, #65, did with no floor).

| the 12 live starts, 240 games | won | paired | invaded | empty-capital invasions after y2 | revolts | first conquest (quartiles) |
|---|---|---|---|---|---|---|
| #90 (`--preset best`) | 162 | | 37 | 5 | 5 | 10 / 12 / 15 |
| **+ capital floor 150** | **173** | saved 30, lost 19, z +1.6 | 29 | 2 | 2 | 12 / 13 / 15 |

By start (#90 → floor): Uesugi 16 → 18, Hojo 8 → 11 (3009, 3014, 3019 unify), 4: 14 → 15, 5: 17 → 16, 7: 16 → 19, 10: 17 → 19, 12: 12 → 14, 13: 10 → 13, 14: 16 → 14, 15: 8 → 6, 6 and 16 unchanged. The floor costs a year of first conquest. **Promoted:** `--preset best` adds `--capital-min 150`. **Open:** MIRR's development trap at one fief (Uesugi 3012), and Hojo's year-1 defence (9 of 20).

### #91 — The rice drain, in the lab: the AI hunts a keep-away force down in days (Chris, 2026-11-20)

Chris: *a capped fief that can be attacked from several fiefs: drain its rice. Come in with a nominal force and play keep-away to burn 30 days of rice (spend your gold, or attack on the last days, so as not to feed it men); attack again the same way; when it no longer has 30 days of rice, go in and wait, and it loses by starvation. Watch that your last battle brings plenty of rice and gold, or that it can be shipped in, so an opponent cannot do the same to you. It might decapitate a capital too: the daimyo might not flee if he does not see the threat.* The mechanism is the morning check (#82, #86: a side with no rice loses, outcome 4), and a big garrison eats ceil(men/15) of its own rice a day (`consume_daily_battle_rice` $830B).

`strike.KeepAway` (an attacker player: deploy on the strip cells farthest from the enemy commander; each day every unit steps to the free neighbouring cell farthest from the nearest enemy unit, never attacking) and `skill_lab --drain N,GM,GR,K [--split solo]` (a garrison of GM men and GR rice, waves of N men each carrying exactly 30 days of ration, up to K waves). Skill 2, 7 pairs × 2 seeds, a garrison of 900 men and 1,800 rice, 4 waves:

| wave of | outcome (all 56) | defender rice per wave | defender men per wave |
|---|---|---|---|
| 60, five-way split | commander killed (5) | −60 | +9 (fed) |
| 60, solo | 5 | −58 | −28 |
| 150, solo | 5 | about flat | −68 |
| 300, solo | 5 | **+20** | **−136** |

**No wave survived to day 30**: the force lasted 1-11 days. `ai_select_unit_combat_action` ($A8CF) advances every non-commander unit toward reachable enemies when the attacker outstrengths the defender, else into free adjacent cells; either way five units hunt one down on the 11 × 5 board. The defender eats a few days of rice, and a lost wave's carried rice garrisons it ($E03C), so a bigger wave raises its rice. (A first build confined the keep-away to the deployment strip and was caught by day 1-10; the whole board did not change the count.) Underneath, the commander-only wave is the siege Chris described (#89): 300 men kill about 136 defenders and give back none, four waves taking 900 to 356, about 0.45 defenders a man sent.

Chris: *if the defender is larger than the attacker he might pursue instead of turtling: so either one guy staying alive as long as possible, or enough guys to keep the defender from pursuing.* (The ROM: the defender's non-commander units charge when the attacker outstrengths it, else step into free adjacent cells.) The same garrison:

| keep-away force | waves to day 30 (outcome 3) | rice burned a surviving wave | the timeout |
|---|---|---|---|
| 600, five-way | 1 of 42 | | |
| 900, five-way | 6 of 14 (wave 1) | about 650 | survivors garrison it: 900 → 1,437 men |
| 1,200, five-way | 6 of 14 | about 650 | 900 → 1,571 |
| 900, solo | 8 of 14 | about 650 | 900 → 1,040 |
| 1,200, solo | 10 of 14 | about 750 | 900 → 1,357 |
| 1,200, solo, charge from day 26 / 20 / 15 (`--charge-at`, 5 waves) | | | fell 2 / 4 / 6 of 14; by starvation (outcome 4) 2 / 4 / 0 battles |

**Chris's size threshold holds**: at about the defender's size the force is not hunted down and lasts the 30 days in half or more of the waves, burning about a third of the stores each. But a survivor at the timeout garrisons the defender, and a wave that is lost returns its carried rice, so the stores refill and the garrison grows; the late charge (Chris's fix for feeding men) must start early enough to reach the castle, and then it is an attack. Starvation took 2-4 garrisons in 70 battles. Per man sent the drain costs about a garrison a wave against plain commander-only waves at 0.45 defenders a man with nothing fed: not wired into the game.

Chris: *we need to drain gold too, which the battle sim will not see: the AI buys rice on its turn, making the plan moot; on the other hand, giving the AI more men is not necessarily bad, it drains their rice faster on the follow-up; the trouble is having enough rice after the battle not to fall to a follow-up attack. Once the mechanics are figured out, test on a capital for the kill.* The AI's rice buying (`ai_vm.gold_to_rice_convert` $B338, in the town handler of most non-war turns) is a random draw against the exchange rate (buy when cheap, otherwise sell), with the gold over its men (`men_surplus` $B2EF: the AI keeps gold and rice equal to its army); so every survivor that joins it raises its reserve. `skill_lab --ai-turn 1` runs the target's own AI turn (`econ_action_state0`, no war) between waves; `KeepAway(dump=True)` has the commander bribe away the side's gold over its men when no enemy is within 2 cells. Five-way, 1,200 men, the same garrison, 4 waves: after a wave the defender's gold sits at the header (1,857); on its turn it spends down to exactly its men (1,571 / 1,571) and its rice falls (1,420 → 1,295): **no rice was bought** in these runs. The refill is our own: the waves caught (outcome 5) carry 30 days of rice for 1,200 men into the garrison (1,295 → 1,694). The dump never fired (the commander was never both 2 cells clear and holding a surplus). Fell 1 of 14 either way. Not wired into the game; the capital test waits on a force that survives the 30 days.

**Who kills the force** (`killprobe.py`, wave 1, 7 pairs × 3 seeds): never the defender's commander; always its field units 1-4 (150 solo: all 21, days 2-12; 1,200 solo: 6 of 21, days 8-25; 1,200 five-way: 12 of 21, days 7-25). The commander stays in the castle. `KeepAway(fight_back=True)` (`--fight-back 1`): strike an adjacent field unit unless their commander is adjacent too, and keep away from the commander only. With the AI's turns between waves the target also **sells** rice when its new men eat its reserve (1,849 → 904 after a 600 solo wave). Solo, fight back, AI turns, the 900 / 1,800 garrison:

| waves | fell | the run (defender men, rice after its turn) |
|---|---|---|
| 600 × 5 | 3 of 21 | 604 / 904 → 327 / 497 → wave 3 lasts the 30 days in all 21: 793 / 265 → wave 4 caught in 18 of 21 |
| **600, 600, 600, 1,200, 1,200** | **19 of 21, all on wave 4, all starved (outcome 4)** | the same three waves, then a 1,200 wave outlasts 793 men on 265 rice |

Chris's shape, measured: small solo waves grind the garrison and make the AI sell its rice, a wave that lasts the 30 days burns the stores and leaves its survivors as more mouths (*giving the AI more men drains their rice faster*), and a bigger wave waits out the starvation. About 3,000 men in waves of at most 1,200, against a one-shot strike's 2,100 plus a keep (the wall). **The kill** (`--kill-test 1`: the target's lord given a second fief): 20 of 21 fell and the faction kept its second fief in all 20: the lord fled. A daimyo-led commander flees when his side's rice is under two days' ration (#44), before the starvation lands; a lord with no fief to flee to (a faction's last fief) cannot. Not wired into the game.

Chris: *one guy: we set up after the defender, so a spot can buy a few days before death, for a gold and a rice, while 900 men burn 60 rice a day; it would take many repetitions, and he restores his rice by then. Maybe it is for when 2-3+ forces are ready to attack the same fief: an opportunist; if a fief's rice to men is low, several attacks in a turn can take advantage.* **The opportunity does not arise on its own** (`ricedays.py`, 14 games, 6,588 sightings of an enemy fief beside us in our war seasons): none under 6 days of ration, 0.2% at 6-10, 37% at 10-20, 63% over 20: the AI keeps rice >= its men (`men_surplus`), about 15 days. Same-season waves (no AI turn between) on 900 men and 900 rice: a 1-man solo wave is caught on day 1 and burns about 35 rice; 1, 1, 1 then 1,200-man waves fell 13 of 21, nearly all to the 1,200s (3 starved on the first of them); five 1-man waves then 1,200, 5 of 21; 600 then 1,200s, 1 of 21 (the 600 wave's lost rice refilled the stores, 900 → 1,274). The starvation play needs forces that last the days of the reserve (13-15), so it is an opportunist only after earlier battles have burned the stores. Closed; not wired into the game.

### #90 — The last fief, again: the source's rice shield asked for all its men. To the share line: 162 of 240 (Chris, 2026-11-20)

Of #88's 21 losses with the bigger economy, seven end at 15-16 fiefs against one rival at 5-28 times its economy. 16/3005 (`lastfief3.py`): year 44, the last rival Noto (0) holds 102 men; Kaga (3) holds 1,081 men, 1,849 gold and **596 rice**, the line is 368 and the MIRR 0.225 against r 0.1, but `strike_ok` refuses and no attack line forms: `score` requires the source to keep **rice >= its men** after the strike (the Tokugawa rule, #48), and Kaga, just filled with men after taking fief 3, cannot also carry its 10 days (#82). That rule guards the AI's gate, which reads min(rice, men) against its share line, so the shield needed is rice up to the share line of the source's enemy neighbours, not all its men (the same reasoning as #86's mode 6; here about 111). `expand.SHIELD_LINE` (`long_game --shield-line 1`): the source keeps rice >= min(its men, its enemies' share line); and `strike_ok`'s top-up now covers the men the fief holds, not the line's (an #82 slip).

| the 12 live starts, 240 games | won | paired | revolts | lost with the bigger economy | attacks won / made |
|---|---|---|---|---|---|
| #88 (`--preset best`) | 158 | | 8 | 21 | 3,073 / 3,248 |
| **+ shield line** | **162** | saved 8, lost 4, z +1.2 | 5 | 15 | 3,100 / 3,267 |

16/3005 unifies (1604). **Promoted:** `--preset best` adds `--shield-line 1`. Over #82-#90 the preset went 93 → 162 of 240 on the live starts; the year-1 coin flips (about 33 games), the old lords of starts 14-15, and the 1-in-1,000 capital revolt are most of what is left.

### #89 — The siege (Chris's 3 → 0): it wears the target down without feeding it, and is rarely needed (Chris, 2026-11-20)

`expand.SIEGE` (`long_game --siege 1`; off): against a target past the header wall (`past_wall`), a rich source (gold at half its header or more; not the capital; every other owned fief SAFE) strikes every war season with all its men over a keep that counts only its OTHER enemies, at no less than `SIEGE_MIN` = 1.5 × the garrison (#79's lab: a lost 1/99 wave with the dump leaves about a quarter, and the defender no gold), carrying the 10-day rice and keeping rice >= men; it re-hires from its surplus (#88) between waves. On #88's player: **26 sieges in 16 of 240 games, 15 won outright, and every lost wave cut the garrison to 15-35%** (565 → 0 won; 275 → 73, 409 → 79, 544 → 197 lost): it wears down without feeding, as Chris said. 156 of 240 (saved 0, lost 2, z −1.4): the wall is rare now that the empire no longer feeds its last rivals starved armies until they cap (#82). Off.

### #88 — The big-economy losses: the harvest clamp throws away a fifth of the gold and half the rice; spending it wins sooner. 158 of 240 (Chris, 2026-11-20)

Chris: *the late-game economy is very telling; at 16 fiefs you generate more than you can spend; at best you max out the men everywhere. And the 3 → 0 case: send the full army each turn knowing 15 other fiefs replace the losses; as long as you do not feed the target (100/0, the gold dump), losing 1:100 does not matter: you wear them down.*

On #87's player, **21 of 87 lost games out-earned every rival combined** in some year. Two groups: starts 14 and 15 (10 of the 21), whose lords die at years 32-35, a clock the planner cannot see; and endings at 15-16 fiefs against one small rival (15/3012: 16 fiefs, economy 8,162 against 697). In 15/3012 (`lastfief2.py`) the fiefs facing the last rivals held 1,175-1,840 gold, most at the header, with 150-380 men, and the strikes failed `strike_ok` for want of the men the idle gold would buy.

**The clamp census** (`clampcensus.py`, real harvests only, not the planner's forecasts): the Fall harvest closes with `cap_fief_stats` ($D836), which clamps gold and rice at the header. In six lost big-economy games the player's harvests threw away **10-22% of the gold income and 42-63% of the rice income** (15/3012: 73,648 gold and 147,499 rice; 4/3007: 120,916 and 412,777).

`expand.CLAMP_SPEND` (`long_game --clamp-spend 1`): on its Summer turn, the last before the harvest, a fief whose gold or rice would clamp (its stores + this Fall's harvest from the marks as they stand − the upkeep > the header) spends the larger excess: gold into men (room under the header, morale at the floor), else to the peasants (capped: the men's morale); rice to the men's morale, keeping rice >= men.

| the 12 live starts, 240 games | won | paired | win year (quartiles) | invaded | lord died | lost with the bigger economy |
|---|---|---|---|---|---|---|
| #87 (`--preset best`) | 153 | | 27 / 31 / 36 | 38 | 40 | 21 |
| **+ clamp spend** | **158** | saved 33, lost 28, z +0.6 | **26 / 29 / 35** | 38 | 36 | 21 |

Spent over 240 games: 9.16 million rice to morale (9,078 Gives), 1.84 million gold to men (2,078 hires). Wins come two years sooner; the 21 losses with the bigger economy stay, so spending alone does not finish them. **Promoted:** `--preset best` adds `--clamp-spend 1`. **Next (Chris's 3 → 0):** the siege, repeated waves that do not feed a target past the wall, refilled from the rest of the empire.

### #87 — Morale against bribes, and the turn-2 invasions: the one-fief opening hires before it taxes. 153 of 240 (Chris, 2026-11-20)

Chris: *bump morale past 100 to stop bribes in combat (morale = men), expensive but maybe a use for excess rice; turn-1 invasions are a coin flip, but some come on turn 2: a delayed attack, or bad policy of not buying men.*

**The bribes** (`bribecensus.py`, the #86 player, 21 games): the AI tried 1,118 battle bribes on our units ($A721: its commander, when its gold > its men, its men <= half ours and our fief's morale <= 100 × skill), 1,107 of them in our attacks (the fief read is the striker's source). 84 worked, flipping 2,914 men (about 140 a game); none came at our morale above 200, and no fief of ours reached 200. A failed (underpaid) bribe still drops our fief's morale by 2-4 ($9E73), about 1,000 times: a drain the morale guard now covers. Lifting a striker past 200 is about 700 rice of Gives, a turn each, undone by recruits: not built.

**The early invasions** (#86's player, 33 deaths in years 1-2): 6 before our first turn, 11 after one, 16 after two to seven. Hojo (start 2), three seeds traced (`early2.py`): turn 1, COMING (Imagawa), 70 men against a men line of 86, 53 gold; the ladder's first rung raised the tax, the turn passed with no men hired, and two attacks came that season (Imagawa held, 70 → 5-24 men; Takeda or Uesugi took the rest). The reader's `line_first` (hire to the men line when threatened) never ran: the ladder takes the turn first. `expand.LADDER_THREAT_FIRST` (`long_game --threat-first N`): a threatened, not-SAFE fief short of its men line hires to it before the tax rung; 2 only while the empire holds one fief.

| the 12 live starts, 240 games | won | paired | early invasions | expanded | invaded | lord died |
|---|---|---|---|---|---|---|
| #86 (`--preset best`, guard + shield 6) | 149 | | 33 | 199 | 46 | 37 |
| threat first, every fief | 149 | saved 22, lost 22 | 20 | 212 | 41 | 43 |
| **threat first, one fief only** | **153** | saved 8, lost 4, z +1.2 | 20 | 212 | 38 | 40 |

Hojo 2 → 5 of 20 (7 in a 20-seed test with the every-fief rule). Every fief: the mid-game threatened fiefs hire before taxing, and the slower economy gave back the gain (6 more games to age). **Promoted:** `--preset best` adds `--threat-first 2`.

### #85-#86 — The revolts and the later invasions: a capital under morale 45, and a Summer gift that left the border on 1 rice. 149 of 240 (Chris, 2026-11-20)

Chris: *revolts and riots look like the easiest fixes that lost games; many early invasions are map coin flips we let go, but there may be later invasions we could have avoided.*

**The revolts** (`revoltprobe.py`: the capital at each fatal rebel battle and its last 8 turns; #84's player, 8 deaths). A revolt or riot staged at the human capital (`game._revolts` / `_riots`, `_rebel_battle`) is a battle that ends the faction when lost. Eligibility rolls `min(stat, 50)^2 < rng_mod(2025)` (`vmprims._roll_failed`): morale or the lord's charisma for a revolt ($9E21), loyalty, 100 − tax or charisma for a riot ($9DA3), **so a stat of 45 or more never fails**, beside a 1-in-1,000 roll; the rebels take 20-89% of the men, with morale = the header − ours (`spawn_uprising_force`). Three kinds: (1) a capital left at morale 46-51 for two years, then an attack from it took it under 45 (2/3007 at 43; 5/3008 at 48); (2) an interior capital emptied to 0 by hire-and-move, then re-hired with 21-57 recruits at morale 41-49 (10/3007, 14/3013); (3) the 1-in-1,000, at morale 89-354 (5/3011's riot: a capital riot cannot be paid off once loyalty is at its cap, since paying settles only a rise over 5). An uprising sweep comes in about 40% of seasons and checks the capital each time: about a 5% chance a game of the fluke, and the rebels' morale near 1,500 is near unbeatable.

`expand.MORALE_GUARD` (`long_game --morale-guard N`): a capital with more than 2 men and morale under N gives to its men first, rice over its men (else gold over 20), up to 300.

**The later invasions** (#84, 54 invasion deaths): 33 in years 1-2 (the coin flips; all fed), 21 later. **Ten of the later ones were 7-11% armies taking a capital** (13 men against 99, 17 against 188, 47 against 575); traced (`tinyprobe.py`, 13/3007 year 12): outcome 4, the defender out of rice, 188 men on **1 rice**. 8 of the 21 later invasion deaths had under 2 days of rice. `riceflow.py`: every Summer the capital gave all its rice but 1 to its peasants (`reaction.economy`'s Summer gift); `shield_rice` mode 4 (Tokugawa's case, #48) keeps rice only while a neighbour is past the share line, and the gate reads min(rice, men), so the test ran on the rice before the gift and every neighbour was past the line after it. New modes (`long_game --shield N`): **5**, a fief with an enemy neighbour keeps rice >= men unless every enemy neighbour has moved this Summer; **6**, only as much as keeps min(rice, men) over the share line of every enemy neighbour that has not moved (its provisioned men × 52/48 + 1), the rest given as before.

| the 12 live starts, 240 games | won | paired | invaded (starved after y2) | lord died | rebellions | econ y20 |
|---|---|---|---|---|---|---|
| `--preset best` (#84) | 140 | | 54 (8) | 38 | 8 | 0.69 |
| + morale guard 50 | 145 | saved 32, lost 27, z +0.7 | 54 (6) | 38 | 3 | 0.69 |
| + guard 50 + #65's capital guard | 142 | z +0.2 | 51 | 42 | 5 | 0.70 |
| + guard 50 + shield 5 | 143 | against guard: z −0.3 | 45 (0) | 45 | 7 | 0.66 |
| **+ guard 50 + shield 6** | **149** | against #84: saved 34, lost 25, z +1.2 | 46 (0) | 37 | 8 | 0.68 |
| + guard 65 + shield 6 | 128 | against shield 6: z −2.6 | 52 | 47 | 13 | 0.65 |

- The guard ends the low-morale revolts (8 → 3 alone); at 65 it fires 6.3 times a game and spends the capital's hire turns. The rebellions left are mostly the 1-in-1,000 roll at high morale (two traced at 89 and 354) and swing 3-13 between runs.
- Shield 5 ends the starved invasions and costs the growth (econ y20 0.66, 7 more games to age); shield 6 keeps the protection (invaded 46, none starved) without the cost.
- **Promoted:** `--preset best` now adds `--morale-guard 50 --shield 6`. Each gain alone is within noise; together with #84's they are 149 of 240.

### #84 — The established rules promoted (`--preset best`; rice and the Echigo plan by default): 140 of 240. Rice after men: closer, still slower (Chris, 2026-11-20)

Chris: *bake in the Echigo defence: in h82 Uesugi was back to losing at the start; we should be able to promote established rules.* `long_game` defaults now: `--rice-days 10` (#82; `0` turns it off) and `--plan default` (#81's strike at Echigo, none elsewhere since Mino's plans did not help; `none` turns it off). **`--preset best`** sets #80's flag set (strike 8, capital first, ladder, empire, empire attack, MIRR, empty morale, donor MIRR, MIRR turns, hire-move, safety donors, dump, waves) where not given, so the measured player is `long_game F 20 70 out.json --skill 2 --preset best`. Checked: Uesugi's 20 seeds under the preset reproduce #82's run with `--plan strike` game for game, once a side-effect of #83 was undone (its `_mirr_donor` refused a donor's top-up under `SEND_MIN` even with rice logistics off; restored when off).

Chris, on #83: *a timing issue: buy men first, only send rice after; it adjusts, as the new men require rice, and it can top out.* `rice_feed` now Sends only when the maxed fief can hire no more (men at the header, or gold at 20 or under).

| the 12 live starts, 240 games | won | paired | invaded | lord died | win year (quartiles) |
|---|---|---|---|---|---|
| rice 10 days (#82) | 135 | | 60 | 37 | 27 / 31 / 35 |
| **`--preset best` (+ the Echigo plan)** | **140** | against #82: saved 6, lost 1 | 54 | 38 | 26 / 31 / 35 |
| + rice logistics 1, men first | 135 | saved 18, lost 23, z −0.8 | 53 | 43 | 29 / 33 / 37 |

Uesugi 15 of 20 under the preset (16 with the rice). Men first cut the cost from 22 games (#83) to 5, within noise, but the wins still come two years later: 1,502 rice Sends (417,000 rice) took turns a maxed fief with no gold left would spend marching men to the front (`depot_move`). Off.

### #83 — Rice logistics: rice to the attack line is within noise; a maxed fief feeding rice costs its hire turn (Chris, 2026-11-20)

Chris, on #82: *the rice gate will slow some attacks, but Send carries rice and gold in one command: do to rice what we do for gold. Summer rice can all be spent but 1 if SAFE, all of it with no enemy neighbour (the harvest refills it); rice >= men if a target / COMING. And a maxed fief is free to send rice over its men to the smallest fief or a staging fief; its only other use is morale.* Before this the donors' Sends to the attack line carried gold only (`_mirr_send` rank 3, `_mirr_donor`); only the safety Sends carried rice, and every donor kept a year's upkeep. `expand.RICE_LOGISTICS` (`long_game --rice-logistics N`; off), `rice_spare(m, i)`: rice rides beside the gold to the attack line (a rice-only Send when only rice is short); a maxed fief (`capped`) spares all its rice over its men; `rice_feed`: a maxed fief whose Send found no line Sends its spare rice to the owned fief furthest under a year's upkeep for its men; level 2 adds Chris's Summer rule for every fief (interior all, SAFE all but 1, threatened only over its men). On the #82 player (135 of 240):

| | won | paired | invaded | lord died | win year (quartiles) | rice |
|---|---|---|---|---|---|---|
| rice 10 days (#82) | 135 | | 60 | 37 | 27 / 31 / 35 | |
| rice to the attack line + the Summer rule (first build) | 129 | saved 11, lost 17, z −1.1 | 62 | 41 | 28 / 31 / 35 | 54,664 to attack lines |
| level 1 (+ the maxed fief's feed) | 118 | saved 18, lost 35, **z −2.3** | 61 | 52 | 28 / 32 / 37 | 682,457 fed by maxed fiefs |
| level 2 (+ both) | 117 | saved 17, lost 35, z −2.5 | 61 | 53 | 28 / 33 / 37 | 689,346 |

- **The cost is the turn, not the rice.** A maxed fief that Sends rice spends the turn it would hire men with half its gold (the army builder); fiefs under a year's upkeep are common, so it found a receiver about every turn it had nothing else (2,800 rice a game). Wins came 1.5 years later and 15 more games ran out of years. Attacks won and made hardly moved (2,741 / 3,155 against 2,749 / 3,108).
- **Rice to the attack line alone does not add wins**: it flows (54,664) and attacks won rise (2,802), within noise of #82. The rice gate's delay was not binding at 10 days. All off; the #82 player stands.

### #82 — Attacks went out without rice: 40 of 78 lost attacks were starved, every army handed to the defender. Carrying 10 days: 93 → 135 (Chris, 2026-11-20)

Chris, on #81: *total econ is a better measure than the average; I am concerned about the games where the player has a greater econ than the rest of the board and still loses: we are not spending well.* In #80's race (240 games), **51 of 147 lost games had our total economy (fiefs × the mean index) above every rival's combined** in some Winter, for 1-18 years; 13 lost games reached 16 of 17 fiefs, six ending at 16 against one rival. One followed through (`lastfief.py`, `kaga.py`, `kaga2.py`; 12/3012): the last rival held Noto (0), a capital whose one owned neighbour was Kaga (3), Chris's single-entry 0-3 border. Year 32: Noto 242 men, Kaga 1,842, line 872, MIRR 0.136 against r 0.091, `strike_ok`; Kaga struck three times and lost three: Winter y32, 570 men and 228 rice against a lord-led castle at **morale 363**, our strikers ground down, the 30-day timeout (outcome 3); Spring y33, 236 men with **1 rice**, starved (outcome 4) and all 236 joined Noto (40 → 276); Fall y33, 650 with 1 rice, the same (276 → 926 = 276 + 650). Noto capped at 950 against Kaga's header 1,980 and the planner never could again. In the lab Kaga → Noto wins 28-30 of 30 at 2.35× with the spread split (the 1/99 split loses all 30 by our commander's death on Noto's map: Chris's open map that corners the 1).

**The census** (`ricecensus.py`, 375 real attacks in 21 games, rice as days of ration, rice / ceil(men/15)): **under 2 days, 31, all lost by starvation**; 2-10 days 17 won, 16 lost (9 starved); 10-30 days 280 won, 31 lost. **40 of the 78 lost attacks starved**, and a starved army garrisons the defender whole ($E03C). The what-if battle (`player_war` with no rng) never read rice, `candidates` let the rice run down to 1, and the only rice rule was the shield the source keeps.

`expand.RICE_DAYS` (`long_game --rice-days N`; off): `score` refuses a move carrying under N days (`rice_for(men)` = N × ceil(men/15); the War command carries at most a rice a man, about 15 days); `strike_ok` tests the line with that rice in hand beside the shield; the MIRR attack line asks the donors for the rice shortfall with the gold; the two-wave strike and its pledged second wave need it too. At 10 days, the 21 games: 331 attacks, 284 won, none starved.

| the 12 live starts, 240 games, skill 2 | won | paired | invaded | lord died | lost with the bigger economy | lost at 16 fiefs | attacks won / made |
|---|---|---|---|---|---|---|---|
| #80 (dump + waves) | 93 | | 71 | 68 | 51 | 13 | 2,775 / 3,332 |
| **+ rice 10 days** | **135** | **saved 48, lost 6, z +5.7** | 60 | 37 | 23 | 1 | 2,749 / 3,108 |

By start (#80 → rice): Uesugi 7 → 10, 2: 2 → 2, 4: 8 → 13, 5: 6 → 15, 6: 6 → 9, 7: 18 → 19, 10: 11 → 15, 12: 8 → 11, 13: 4 → 7, 14: 7 → 10, 15: 5 → 5, Owari 11 → 19. Uesugi with the Echigo plan (#81) as well: **15 of 20**. Much of what #69-#80 read as the late stall was the empire feeding its last rivals whole starved armies until they capped. **Open:** the defender's morale (363 here) is not in the 2.35× sizing; the mid-game revolts; the 23 games still lost with the bigger economy.

### #81 — Uesugi's openings: the Echigo plan was never in the whole-game runs; with it, 7 of 8 year-1 invasions are held (Chris, 2026-11-20)

Chris, reading Uesugi's 20 games in #80's race: *7 won (the text says 'lord died'), 8 invaded before he could play, Hojo with a grudge; we have a specific strategy for Echigo, hitters 2 squares from his 2 possible leader starts, which should execute the leader or at least win with plenty of men: why is it not lucky? The other 5 die of age at 3-16 fiefs. We can get most of that 40% to survive; what we have been working on is the last 5.* (A won game is reported by its end, the lord's death at year 41-45, with `unified` the year it held all 17.) The 8 invasions: Hojo (attacker 2) in Spring of year 1 before Uesugi's first command, 91-128 men committed against 59-74 (3003, 3005, 3007, 3016), and attacker 15 or 7 against a garrison of 7-35 (3013, 3014, 3015, 3019).

**`long_game` fought every defence with `strike.Doctrine("control", "contact")`; #44's fixed Echigo plan (`plans.PlanPlayer`, `plans.ECHIGO`) was only ever wired into `deaths.py --combat plan1:MODE`.** `long_game --plan MODE` installs it as `tactical.HUMAN` for a start that has one (Echigo 1, Mino 8); it falls back to the same doctrine for any other battle (the player's attacks, other fiefs, edges without a plan). Uesugi, the #80 player, 20 seeds:

| | won | invaded in year 1 | 
|---|---|---|
| doctrine (#80) | 7 | 8 |
| **plan strike** | **11** | 1 |
| plan hold | 10 | 1 (and one at year 10) |

Under strike the year-1 invasions came out: won 3003 (y26), 3005 (y27), 3019 (y20); lord died 3013 (2 fiefs), 3014 (14), 3015 (9); revolt 3007 (y26); 3016 still falls (Hojo, 128 against 59). 3018 also turned from age (11 fiefs) to a win (y28); hold lost 3017 at year 10, which strike won. **Mino's plans do not rescue it**: gate 19 of 20 invaded in year 1, hold 20 of 20 (doctrine 20 of 20). Uesugi's remaining losses are early stalls more than late ones: lord died at 1, 2, 6 and 9 fiefs (3009, 3013, 3006, 3015) beside 10-15 (3002, 3012, 3014).

### #80 — The dump and two waves in the game: both neutral; the waves are priced right and rarely possible (Chris, 2026-11-20)

From here on the races run on the **12 live starts** (Chris: some starts are unrecoverable; 0, 3, 8, 9 and 11 were never won by any of 26 races since #70 and are invaded before year 20 in 17-20 of 20 seeds, so they never flip a paired game): 240 games, the 92 player winning 92 of them.

**The lab with the dump** (`skill_lab --dump 1 --waves …`, both first-wave splits, skills 2 and 3, 210 a cell; added to `waves_q.json` as `heavy+dump` and `solo+dump`, with the one-wave controls). One wave: skill 2 at 2.0× 73% → 85% (kept 0.19 → 0.33 a man sent), skill 3 at 2.0× 19% → 51%, at 2.25× 43% → 58%. Two waves, 1/99 + dump: 1.5 + 1.5 **100% at skills 2 and 3** (90% / 78% without), 1.5 + 1.0 96% / 74%, 1.8 + 1.8 100% / 100%; a weak 1/99 first wave still feeds men (0.75× → the garrison 1.32, 21% / 8% won). Solo first wave (no dump: its commander fights, so a lost solo wave still leaves its gold): 1.0 + 2.0 100% / 98%, 0.75 + 1.5 83% / 47%, 1.5 + 1.5 85% / 71%. So: 1/99 with the dump from about 1.5×; under it a commander-only first wave and a 2.0× second.

**`--dump 1` alone** (on the 92 player): 94 of 240 (saved 32, lost 30, z +0.3), invaded 67 (74). The attacks won 2,772 of 3,256 (85.1%; 85.3% before): at skill 2 the planner sends 2.35× (`CHARGE_NEED` 2.0 × the skill scale 1.18), where the lab wins all with or without the dump.

**`--waves 1`** (`expand.WAVES`, `wave_plan`, `wave_strike`; Chris: *if the spare is over 0.5, see if the MIRR is good with a helper*): a SAFE fief, in a war season, with no solo attack (`best_attack` None), whose spare over its own line (`own_need`, the capital's line) is at least `WAVE_MIN` = 0.5 × a target's garrison, pairs with an owned neighbour of the target that has not acted this season, from its own spare; P and the kept share from the best lab cell no stronger in either wave (`wave_odds`, `WAVE_TABLE` = heavy+dump); the prize with the survivors must leave everything within the gate; one MIRR (both waves' men invested at the hire rate; on a win, P × the treasury, the freed army bill, the income and the garrison's upkeep; the terminal value) above r. The first wave attacks; the helper's attack is pledged (`_PLEDGE`, kind `wave`, not re-checked against `fought_need`: the table priced it). With the dump: **93 of 240** (against the 92 player: saved 37, lost 36, z +0.1; against the dump alone: z −0.2), invaded 71. It fired 90 times in 61 of 240 games; the target fell that season 69 times (77%); second waves won 37 and lost 21; P's quartiles 0.75 / 0.96 / 1.0. **Rare by geometry** (`waveprobe.py`, per game): a fief unsafe somewhere 132-138 seasons; interior 64-181; no spare 85-87; **no unacted second owned neighbour of the target 82-178**; the helper's spare under every lab cell 28-64; priceable 7-8; fired 0-1. The fiefs keep few men over their own lines, and a target with two owned neighbours that both still have their turn is rare. **Next:** an attack line that is a pair (both fiefs hire toward their share over a season or two, as the solo line does), so the waves are built, not found.

### #79 — The timeouts are a bribe paid with the first wave's gold; the held-back commander dumps it (Chris, 2026-11-19)

Chris, on #78: *timeout makes sense, but not with proper setup: battlefields are 11 × 5 and no castle is over 30 steps from the nearest start cell; go from the start cell nearest the capital straight for it, attacking anything in the way; a short run to see if they still time out.* That is the doctrine already (`strike.Charge`: units 1-4 on the strip cells nearest the enemy commander, the shortest path, blockers attacked). A traced timeout (`traceprobe.py`, Owari → Mikawa, 1.5 + 1.5, seed 5000; wave 2 from fief 6, 7 steps out): **day 1, the defender's commander goes 14 → 81 men and our striker 240 → 173**; days 3-12 the striker kills the four small units one by one (173 → 120); days 13-14 it attacks the commander on the castle seat and dies (120 → 0 against 81 → 37); days 15-30 our 1% commander holds back, outcome 3. Day 1 is the AI's Bribe (`ai_rng_resolve_combat_apply_casualties` $A721: the commander, when its gold > its men, its men ≤ half ours and our fief's morale ≤ 100 × skill, pays gold − men to our strongest unit, $9E73: defectors join its commander). Its gold: **178 before wave 1, 421 after**: the War command carries a gold per man sent, and a lost army's gold garrisons the defender ($E03C). So the first wave pays for the bribe that breaks the second, and the worn-down garrison always meets the "half ours" test.

Chris's earlier idea (*bribe as much as you can even at 0 results so you dump gold*): `strike.Charge(dump=True)` (`expand.DUMP`, `skill_lab --dump 1`; off): the held-back commander's idle day is a Bribe of the side's gold over its men (0 at the start, since War carries a gold per man; the surplus is what the dead leave behind) on the strongest enemy unit, paid win or lose. `endprobe2.py`, skill 2, 1.5 + 1.5, the second wave after a lost first, 30 seeds:

| wave 2 against | without the dump | with the dump |
|---|---|---|
| Mikawa (16 → 7) | 14 won, 16 timed out | **30 of 30 won** |
| Omi (8 → 10) | 17 won, 6 timed out | **22 of 22 won** |

The full wave grid with the dump (both first-wave splits, skills 2 and 3) was stopped by the host for low memory before it wrote anything; not rerun. **Next:** that grid; then the dump as a plain doctrine change on the 92 player (it applies to every 1/99 attack against a weak, gold-rich garrison); then the two-wave planner (Chris: a fief whose spare is over 0.5 × the garrison looks for one or two unacted helpers, priced from the table, taken when its MIRR beats growth and the solo strike).

### #78 — The two-wave losses are the 30-day clock, not the commander (Chris, 2026-11-19)

Chris, on #77's leftover losses (Mikawa, Omi): *the 1/99 results are from being careless; you should be able to hide the leader so it never gets attacked; on a very open map the defender may get round the 99 and corner the 1, but that is a problem with the split.* `strike.Charge(hide=True)` (`expand.HIDE`, `skill_lab --hide 1`; off): the held-back commander steps to the free neighbouring cell farthest from the nearest enemy unit whenever one is within 3 steps. `endprobe.py` (the battle's outcome code through `tactical.dispatch_battle_resolution`), skill 2, 1.5 + 1.5, wave 2 after a lost wave 1, 30 seeds: Owari → Mikawa 14 won, **16 lost, every one outcome 3, the 30-day timeout (the attacker withdraws)**; Mino → Omi 17 won, 6 lost, all outcome 3. Not one was lost by our commander's death, and with hiding the 60 battles came out the same, battle for battle. `distprobe.py`: wave 2 comes from a different neighbour (fief 6 into Mikawa, 4 into Omi), so the battle map is entered from another side; into Mikawa the nearest strip cell is 7 steps from the defending commander (from Owari 0). So **the map decides** (Chris): the second wave fights the clock on a long or hard approach, against a garrison of about 0.27 of the first. Why a 99% striker cannot reach and kill a 20-40-man commander in 30 days there is not traced (terrain, the castle cell, the path). The hiding stays off (neutral).

### #77 — Two waves in the battle lab: a weak 1/99 wave feeds the defender, a commander-only first wave does not, and two waves cost more than one (Chris, 2026-11-19)

#76 found that past the header wall the striker's capped men cannot win at all. Chris: the double attack fits, *but we have to price it from the lab*; two half-strength attacks likely take more than one full one; ways not to feed the defender (100/0 or 1/99, holding the attack until the rice drains, dumping gold on bribes) are each tactical work of their own; *even so, go at no less than 1:2 odds.* `skill_lab --waves r1+r2[,…] [--split solo]`: wave 1 from the source at r1 × the garrison; if it loses, wave 2 from a second neighbour of the target, the same season, at r2 × the ORIGINAL garrison (made ours, with the source's morale, skill and arms as they were before wave 1: a lost wave empties the source and `clear_military_stats_if_no_men` zeroes them, which the first run missed); against one wave of r1 + r2 from the source on the same board and seed. The doctrine's split for wave 2 and the one-wave control; `--split solo` sets wave 1 to 100/0 (reachable by Assign in all 3,360). 7 pairs × 30 seeds = 210 per cell. The table is saved as `na1sim/waves_q.json` (p, kept per man sent, garrison after a lost wave 1, by skill, wave-1 split, r1+r2).

| r1 + r2 | garrison after a lost wave 1: 1/99 / solo (skill 2) | skill 2 two waves won: 1/99 / solo | one wave of r1 + r2 | skill 3 two waves: 1/99 / solo | one wave |
|---|---|---|---|---|---|
| 0.5 + 1.5 | **1.21** / 0.82 | 9% / 51% | 73% | 0% / 6% | 19% |
| 0.75 + 1.5 | — / 0.69 | — / 82% | 100% | — / 35% | 43% |
| 1.0 + 1.0 | 0.90 / 0.54 | 42% / 60% | 73% | 1% / 3% | 19% |
| 1.0 + 1.5 | 0.90 / 0.54 | 73% / 86% | 100% | 40% / 54% | 97% |
| 1.0 + 2.0 | 0.90 / 0.54 | 75% / **100%** | 100% | 70% / **99%** | 100% |
| 1.5 + 1.0 | 0.27 / 0.28 | 86% / 81% | 100% | 28% / 46% | 97% |
| 1.5 + 1.5 | 0.27 / 0.28 | 90% / 83% | 100% | 78% / 72% | 100% |
| 1.8 + 1.8 | 0.16 / 0.16 | 93% / 89% | 100% | 85% / 80% | 100% |

- **A weak 1/99 wave feeds the defender**: at 0.5× the garrison ends 21% larger (both armies' survivors garrison the defender, $E03C); #62's "no loss fed" was measured at 1.5× and up. Under 1/99 a wave wears the garrison down only from about 1.5×.
- **A commander-only (solo) first wave never feeds** (0.5× → 0.82) and wears twice as hard per man at 1.0× (0.54 against 0.90): the battle ends at the commander's death and no 1% is left to be captured. From 1.5× the two splits wear alike, and solo wins wave 1 outright more often (25% against 3% at skill 2).
- **Two waves always cost more than one of the same total** (Chris): 1.5 + 1.5 wins 83-90% where one 3.0× wave wins all; but at the wall one wave does not exist, so the comparison is against no attack. The best mix is a solo first wave of about 1.0× and a 1/99 second of 2.0× (100% / 99%), or 0.75 + 1.5 at skill 2 (82%).
- **What is left is per target**: nearly every two-wave loss is against Mikawa (16 → 7) and Omi (8 → 10), capitals with the lord in the garrison, where wave 2's 1% commander can be killed however few defenders remain (at skill 3, 1.5 + 1.5 solo: 0/30 and 2/30; every other pair 30/30). Wave 2's split per target is open, as #62 left solo against heavy.
- **Next:** the wall attack in the planner, priced from `waves_q.json`: two owned fiefs adjacent to a target past the wall, first wave solo at no less than 0.5× (Chris's floor), the second from a fief that has not acted, both in one season; MIRR with p and kept from the table and both waves' men as the investment.

### #76 — The coordinated attack: follow-ups that mend the prize lose; past the header wall the wall is the win, not the hold (Chris, 2026-11-19)

Chris, on #75 (34% of the ready striker's refusals were the prize left COMING or another fief unsafe after): *the result = unsafe might have to be solved with a double attack.* `expand.COORD` (`long_game --coord 1|2`; off): a winning move that `score` would refuse is accepted if the owned fiefs that have not yet acted this season (`m.acted`; the season order is shuffled) can mend the map on their turns, tested by playing their commands on the forecast: Moves of their spare men (over their own line on the post-conquest map) into the fief over the gate (1), and failing that a winning attack on the threat from a SAFE neighbour of it (2). `coord_fix` is greedy, at most `COORD_MAX` = 4 commands, the map re-read after each; a clean move outranks a mended one. After the real battle the plan is recomputed on the real map and the helpers' commands are pledged (`_PLEDGE`), executed first on their turns (`coord_act`). `--coord-min N`: only for an empire of N+ fiefs; `--coord-margin P`: the plan must hold with the prize at P% of the forecast's men; `--coord-wall 1` (Chris: *use it when you have to: when your capped men cannot beat the target; below that, growth, as the ROI of an unachievable invasion is 0*): only for a target past the header wall (every owned neighbour's hold-sized `_stage_line` over its header), and `attack_mirr` prices such a target at the striker's capped line when the survivors plus the neighbours' spare men reach the hold line.

| on the 92 player (#74), 340 games | won | paired | invaded | follow-ups pledged / unmended | pledged prize lost within a year |
|---|---|---|---|---|---|
| safety donors (#74) | 92 | | 170 | | |
| coord 1 (Moves), any size | 55 | saved 12, lost 49, z −4.7 | 227 | 673 / 427 | 11% |
| coord 2 (+ attack the threat), any size | 54 | saved 15, lost 53, z −4.6 | 231 | 683 / 442 | 12% |
| coord 2, 9+ fiefs | 67 | saved 11, lost 36, z −3.6 | 185 | 367 / 122 | 17% |
| coord 2, 9+ fiefs, margin 75 | 74 | saved 13, lost 31, z −2.7 | 181 | 335 / 97 | 16% |
| coord 1, 9+ fiefs, margin 75 | 70 | saved 12, lost 34, z −3.2 | 181 | | |

- **Every variant loses.** At any size half the lost games died by invasion in years 8-24: under 6 fiefs the real battle kept fewer men than the forecast's mean and the plan could not mend the prize as often as it could (226 unmended, 217 pledged). Of 867 pledged Moves, 192 found the prize already taken (the threat's turn came first). Even the prizes left SAFE were lost more (3% within a year → 6-9%): the helpers' Moves thin their own lines. Gated at 9 fiefs and with a margin it costs less, and still costs. The follow-up attack itself wins (13-19 of 15-24) but rarely has the chance.
- **The header wall, measured** (`wall_probe.py`, three stalled games): of 1,700-1,800 priced attacks a game, 0-186 had a hold-sized line over the striker's header; past the wall (every neighbour over), the header could not even **win** in 143 of 156 (header − own keep < `fought_need`), and the follow-up help fell short of the hold in the other 13. In 4/3012 no attack was over the header at all. So Chris's case (*capped men cannot beat the target*) is a win wall: Moves into the prize cannot help it. With the wall gate the follow-ups never fire in the smoke games and the game is the 92 player's.
- **Next (Chris's double attack, literally):** two waves on one target in one season. #62: a lost battle shrinks the garrison (0.37-0.58 men per man sent), so a first wave from one fief wears the target down and a second from another fief wins and holds; priced as one MIRR with the first wave's men as the cost (Chris: two half-strength attacks likely take more than one full one; measure the sequence in the battle lab first).

### #75 — The stall audited: the striker holds its line and does not strike; the hold line and Assign-ahead do not fix it (Chris, 2026-11-19)

Chris: *we know how to grow safely, but then we stall; we need an audit.* **`audit.py`** (in the session scratchpad, the #74 player, 17 starts × 6 seeds) classifies every owned fief's turn, from the season the empire first holds 9 fiefs to the end, by its effect on the board (men, gold, rice, wealth, loyalty, morale and tax before and after the turn, other fiefs' gains for Moves and Sends).
- **Turns split the same way in won and stalled games:** front fiefs hire about 30% of the time and develop about 20%; interior fiefs Send and Move about 45%.
- **The striker differs.** In the stalled games it attacks 16% of its turns (26% when won), hires 38%, and does nothing or gives to its peasants 36%.
- **MIRR finds no attack line** in 29% of the attack seasons (19% when won). The rivals left: median 3 (2 when won).

**`audit3.py`, the ready striker.** In the 15 games the lord's age ended, the striker held its full line in a War season 177 times and struck 49:

| why the ready striker did not strike (128) | share |
|---|---|
| another fief unsafe (the whole-empire gate) | 36% |
| the prize left COMING, or another fief unsafe after | 34% |
| its turn spent reshaping the army for the target (Assign, `split_ready`) | 22% |
| the capital's line, other | 8% |

Two cheap fixes, on the #74 player (92):
- **`--hold-all 1`** (#70): 90 (saved 30, lost 32, z −0.3). More conquests (attacks after 9 fiefs 1.45 → 1.55 a year, prizes left SAFE 1,075 → 1,238), fewer invasions (15 → 8 among the 9+ empires), more lost to age. Prizes left COMING unchanged (171).
- **`--assign-ahead 1`** (`expand.ASSIGN_AHEAD`): the striker reshapes on any turn it holds 80% of its line. **70 (saved 21, lost 43, z −2.8)**, invaded 170 → 187. The split is also the fief's defence: a striker sitting in its attack shape (heavy: 1% on the commander) defends badly while it waits.
- **`--assign-ahead 2`** (Chris: *only once, on a down turn*): only in Summer, at the full line. 81 (saved 16, lost 27, z −1.7), invaded 164. About 1 a game, and still worse; not yet traced why (the spread split's target reads the current one, `desired_split`, so a reshaped army may not stay ready).
- Both fixes together: 88 (z −0.5).

- **The Assign at the strike stays as it was.** Reshaping earlier costs more than the War turn it saves.
- **Next (Chris):** the prize left COMING is a **double attack**. Either strike and then reinforce (SAFE fiefs adjacent to the prize that have not acted Move men in before the rivals' turns, so `score` may accept a COMING prize whose hold gap they can cover), or strike the threat first (a two-target plan priced as one MIRR).

### #74 — Safety donors: any SAFE fief funds the unsafe ones first. 92, and the local gate does not help (Chris, 2026-11-19)

Chris: *a fief that is not SAFE is one that can be lost, and fixing it is usually just sending enough gold to make the hire. Nothing is wrong with one maxed fief sending to the unsafe fief while another sends to stage an attack, or with fixing several problems a year (Fall a hire after its transfers, Winter more transfers or more men). Late, an underdeveloped fief has 8 others to feed it and should be stood up very quickly.* **The unsafe census** (`unsafe_census.py` in the session scratchpad, the #73 player, 17 starts × 6 seeds): 340 unsafe fief-seasons at 9+ fiefs, gap median 92 men.
- The next season: 59% SAFE, 25% still unsafe (+46 men median), **16% lost**.
- The hire cost more than the fief's own gold in 66%, and only about half received a transfer that season.
- Even a full treasury could not buy the gap in one turn in 42%; in 19 the line exceeds the header (no hire makes it SAFE).
- Rice was never the limit.

The cause: only topped-out fiefs Sent to the safety lines, and #72's donor gate let growing fiefs fund only the attack line. The ledger already marks what is done: it is built once a season, and each Send or Move shrinks its line, so donors fill one receiver and move on.

- **`--safety-donors 1`** (`expand.SAFETY_DONORS`, `_safety_send`): any SAFE fief Sends its spare gold and rice to the COMING, then HUNTABLE, lines before anything else, receivers that have not acted first, clamped to the receiver's header room. No MIRR test: an unsafe fief can be lost.
- **`--local-gate 1`** (`LOCAL_GATE`): an attack must leave its source SAFE, the prize within the tolerance, the capital's line, and every other fief no worse than before (`score`). `best_attack`, `strike_plan` and the MIRR attack line no longer require the whole empire SAFE.

| every start, seeds 3000-3019, 70 years, skill 2, the #73 player (MIRR + empty-morale + donor gate + turns + hire-move) | won | paired against #73 | invaded | age |
|---|---|---|---|---|
| #73 | 82 | | 168 | 80 |
| + safety donors | **92** | saved 25, lost 15, z +1.6 | 170 | 67 |
| + safety donors + rescue (#70) | 84 | z +0.2 | 168 | 79 |
| + safety donors + rescue + local gate | 74 | z −1.1 | 172 | 85 |
| + safety donors + local gate | 88 | against safety donors: z −0.6 | 174 | 65 |

Against the ladder (#66) the safety-donor player is saved 57, lost 25, **z +3.5**; against MIRR (#69) z +4.1. Of the empires that reach 9 fiefs, 92 of 156 win (82 of 149 before).

- **Funding the weak fief is the gain:** the safety Sends double (COMING lines 2.1 → 4.1 a game), and the lord's age falls from 80 to 67.
- **Moving men in hurts** (rescue: 92 → 84). It strips SAFE fiefs that are also the strikers, as in #67.
- **The local gate does not help** (−4 alone, −10 on top of rescue). Attacks after 9 fiefs stay at 1.4 a year and fiefs lost rise from 0.18 to 0.3 a year: attacking past a weak fief costs the weak fief.
- **Still open:** the late tempo (1.4 attacks a year after 9 fiefs, unchanged since #72), and the 47 games the lord's age ends.

### #73 — The striker's turns priced, and the hire-and-Move: honest timing alone costs games, the capacity wins them back (Chris, 2026-11-19)

Chris, on #72's not-ready strikers: *it is usually quicker to send gold and rice and let the front fief hire. But donors near the front can hire and Move, which saves the front fief's turns. A new fief must not get more men than it can feed past the harvest. MIRR should have been the signal for what to do in any situation; maybe the pricing is bad.* **The logistics census** (`logi_census.py` in the session scratchpad, 17 starts × 6 seeds, the donor-gate player):
- Feeding is not a problem: about 20 men a game were lost to unpaid upkeep, and none at 9+ fiefs.
- In 129 of 235 not-ready seasons the striker's shortfall (median 163 men, about 2,100 gold) cost more than its header (median 1,780). Its gold sat at the header in 105 of them.
- Its SAFE neighbours' spare men covered the shortfall in only 69 (median 60 men).

The striker is short of **turns**, not gold: one hire per command, a treasury per hire, the attack another command, no War in Summer. **The pricing was wrong in that way.** `attack_mirr` struck at the first War season as if the men already stood there. And a turn has no price, so hire-in-place and send-gold could not be compared.

- **`--mirr-turns 1`** (`expand.MIRR_TURNS`, `strike_season`): the strike season is played out a season at a time. SAFE neighbours Move their spare men in before the striker's turn. The striker hires a header's worth on each turn it is still short. It strikes on the first War season it holds the line without having spent that turn. The target's growth and the line are re-sized to that season, and a strike that cannot be built within the horizon is dropped.
- **`--hire-move 1`** (`HIRE_MOVE`, `_hire_for_striker`): a SAFE donor adjacent to the striker, with no spare men, hires toward the striker's shortfall with its own gold when the attack line's MIRR beats its own gift (the donor-gate test). The hire is pledged against the line, and the donor Moves the men on its next turn (`empire_move`'s spare-men rule). In the pricing, each adjacent donor adds half its treasury in men a season (two commands).

| every start, seeds 3000-3019, 70 years, skill 2, MIRR + empty-morale + donor gate | won | paired | invaded | age | attacks/yr after 9 fiefs |
|---|---|---|---|---|---|
| donor gate (#72) | 79 | | 169 | 84 | 1.42 |
| + turns | 71 | saved 36, lost 44, z −0.9 | 179 | 80 | 1.38 |
| + turns + hire-move | **82** | against #72: saved 42, lost 39, z +0.3; against turns: z +1.5 | 168 | 80 | 1.43 |

Against the ladder (#66) 82 is saved 53, lost 31, z +2.4; against MIRR (#69) z +2.9.

- **Honest timing alone costs games (−8):** an attack that needs hiring is now priced at its real, later season, so fewer lines beat r. Attack-line Sends fell from 20.5 a game to 15.3, and hires from 13.0 to 9.7.
- **The capacity wins them back (+11 over turns alone):** 6.4 hire-and-Moves a game. The best count of the line, but within noise of the donor gate.
- **The picture is unchanged after 9 fiefs:** 1.4 attacks a year in all three, and the lord's age still takes 52-59. The corrected price moves *which* attacks are chosen, not how many the empire can mount.

### #72 — Why 9+ fief empires stall, and the empty army's last turn: 76, the first significant gain of the line (Chris, 2026-11-19)

Chris: *once a player has 9+ fiefs they should be able to force a win; only age stops them. Why we stall and stay alive is strange.* Across the races, 129-141 of 340 games reach 9 fiefs and about 45% of those win. The rest peak at 13 (median), make 0.8-1.0 attacks a year, win 75-80% of them, and lose about 0.45 fiefs a year: about +0.2 fiefs a year with four left. **The census** (`big_census.py` in the session scratchpad, MIRR + empty-morale, 17 starts × 6 seeds): at the first player turn of every attack season with 9+ fiefs, how far the attack pairs get.

| attack seasons at 9+ fiefs | won (20 games) | not won (17) |
|---|---|---|
| an attack made | 38% | 24% |
| no target fits a header | 5% | 24% |
| no striker holds its line | 15% | 20% |
| a fief not SAFE (median 1) | 20% | 20% |
| `strike_ok` refuses / approved but not made | 22% | 13% |

In 79 of the 105 no-fit seasons even the bare win (2.35× at skill 2) exceeds every adjacent header: the garrisons left are 800+ (the wall). In the not-ready seasons the striker lacked the gold for its shortfall (median 161 men) in 66 of 88 while the empire held 558 spare men and 12,500 gold and a MIRR attack line stood in 65: only topped-out fiefs Sent. The rivals face the same wall against our fronts, so both sides trade small border fiefs and the clock ends it.

- **The other two Gives to an empty army** (#71's remainder, `--empty-morale` now closes all three): the reader's Summer rice to the men of a capped empty fief, and the topped-out hire, which under its morale floor Gave to the men instead of hiring. An empty army has morale 0, so every empty topped-out fief Gave forever and never hired. In 10/3003 the refused Gives fall 324 → 0.
- **`--donor-mirr 1`** (`expand.DONOR_MIRR`): a SAFE fief still growing Sends to the attack line when the line's MIRR beats its own gift's IRR (`own_irr`: the harvest formulas, as r) and r. 26,700 gold a game.

| every start, seeds 3000-3019, 70 years, skill 2 | won | paired | invaded | age | fiefs y20 / y30 / y45 | econ y20 / y30 |
|---|---|---|---|---|---|---|
| ladder (#66) | 60 | | 179 | 93 | 4.7 / 7.7 / 7.4 | 0.70 / 0.61 |
| MIRR (#69) | 57 | | 182 | 90 | 4.8 / 8.8 / 9.2 | 0.67 / 0.64 |
| MIRR + empty-morale, one site (#71) | 63 | z +0.9 | 183 | 84 | 5.0 / 9.1 / 8.9 | 0.70 / 0.69 |
| **MIRR + empty-morale, all three sites** | **76** | against #69: saved 36, lost 17, **z +2.6** | 176 | 78 | 4.9 / 9.0 / 9.5 | 0.70 / 0.66 |
| + donor gate | **79** | against the row above: saved 37, lost 34, z +0.4; against the ladder: z +2.3 | 169 | 84 | 4.9 / 9.1 / 9.1 | 0.70 / 0.66 |

- **The empty topped-out fief that now hires is worth 13 games**: the outposts make men again and the depots march them to the front. The first significant gain over both #66 and #69.
- **The donor gate moves the gold (26,700 a game) but not the count.** Its census (17 × 6): attacks in 32% of the not-won seasons (24% before), the wall down to 4%, but **not ready rises to 25%**, and the striker still lacks the gold for its shortfall (median 216 men) in 123 of 152 of them. Not yet checked: a Send is clamped to the striker's header room, so a shortfall worth more than one treasury (216 men × 18 gold is about 3,900 against a header near 1,900) needs several hire turns whatever the donors send.
- **Next:** check the header-bound hire; then waves for the wall, fought as a two-wave sequence in the battle lab (Chris: two half-strength attacks likely cost more than one at full strength, so the odds are measured, not assumed).

### #71 — The battle picker's two branches and the empty army's turn: the economy rises, the count stays in noise (Chris, 2026-11-19)

Three items from #70. **`--hub W`** (`expand.EMPIRE_HUB`, `HUB_W`): the big play in reverse. An attack's MIRR also counts the rise in every AI fief's share line when T falls (`ai_bill`: each AI fief against its non-own neighbours, ours included; before the battle with T grown and S at its line, after with T ours at the kept men and S at line − send), at the hire rate × W%. That their cost is our gain is a modelling choice, not a cartridge formula. Because the bill charges a fief's largest neighbour, not the sum, the term is selective: in 5/3009 it lifted 111 of 1,132 attacks priced, by 0.005 / 0.014 / 0.033 a season (quartiles; max 0.076, r about 0.10). **`--loss 1`** (`EMPIRE_LOSS`): the flows are the win's and the loss's weighted by P(win) from the battle lab (`keep_q.json`: won battles of 7 pairs × 30 seeds, so wins / 210, by skill and raw ratio; under 2.0 a linear fall to 0 at 1.0, assumed). A loss keeps the hire's cost and the upkeep to the battle and loses every man sent. At skill 2 the strikes go at about 2.35×, P(win) 0.92. **`--empty-morale 1`** (`reaction.EMPTY_MORALE`): found tracing #70's idle outposts (10/3003, fiefs 9, 13, 16). With no men the cartridge clears morale to 0 (`clear_military_stats_if_no_men`), the reader's first rule read it as a cliff and Gave 60 gold to the men, and `driver_give` refused it (no men): no gold spent, the turn lost, every season, so the outpost never reached its Spring gift (peasants at 868-869 of 1,800 for years, the treasury at the header). The fix is the ladder's own rule (an empty army's morale is no cliff). In 10/3003 the refused Gives fall 324 → 139; the rest are two more sites, not fixed: the reader's Summer rice to the men of a capped empty fief (126) and the topped-out hire's morale floor, which Gives instead of hiring when morale is 0 (13).

| every start, seeds 3000-3019, 70 years, skill 2, strike 8 + capital first + ladder | won | paired | invaded | age | fiefs y20 / y30 / y45 | econ y20 / y30 |
|---|---|---|---|---|---|---|
| ladder (#66) | 60 | | 179 | 93 | 4.7 / 7.7 / 7.4 | 0.70 / 0.61 |
| ladder + empty-morale | 57 | saved 16, lost 19, z −0.5 | 182 | 94 | 4.7 / 7.9 / 7.6 | 0.71 / 0.66 |
| MIRR (#69) | 57 | | 182 | 90 | 4.8 / 8.8 / 9.2 | 0.67 / 0.64 |
| MIRR + empty-morale | 63 | saved 25, lost 19, z +0.9 | 183 | 84 | 5.0 / 9.1 / 8.9 | 0.70 / 0.69 |
| MIRR + loss | 54 | saved 25, lost 28, z −0.4 | 180 | 95 | 4.9 / 9.2 / 9.9 | 0.68 / 0.59 |
| MIRR + hub 100 | **66** | saved 29, lost 20, z +1.3 | 180 | 88 | 4.9 / 9.2 / 8.2 | 0.70 / 0.61 |
| MIRR + all three | 55 | saved 29, lost 31, z −0.3 | 184 | 93 | 4.7 / 8.5 / 10.1 | 0.70 / 0.64 |

(fiefs: the mean over the games alive then; econ: the median of the player's to the AI's.)

- **The empty army's turn lifts the economy as Chris expected**, in both players: at year 30, 0.61 → 0.66 (ladder) and 0.64 → 0.69 (MIRR). The win count does not follow (−3, +6).
- **The hub term is the best single result of the line (66, z +1.3)**, not significant, and it does not stack: all three together are 55. The losing branch (P(win) 0.92 at the strike ratio) moves little and what it moves is down.
- **Logistics (Chris):** Gold to the front beats men when the front is 2+ steps away: one Send against a hire and a Move per step. The depots already do this once an outpost is empty. A backline fief needs about two commands a year until its peasants top out, then one. A Summer Send can fill the receiver past what its harvest will bring and lose that harvest, unless it spends the Send before the harvest. To check next: how often Summer Sends push a receiver's next harvest over the header. The cap is calculable: header − (gold + forecast Fall income).

### #70 — The stall, looked at: idle outposts, a hold line blind to the rival's own fiefs, and a rescue; all within noise (Chris, 2026-11-18)

Chris, on #69's stall: *what do the investments look like when we stall? Are the fiefs maxed out, can we not field an army big enough, how many outposts?* Four of `mirr3`'s stalled games (lord died, short of 17: 4/3012, 5/3009, 7/3013, 10/3003), every owned fief and every attack, in Winter of years 30/35/40/45:

| year 45 | fiefs | interior (all 0 men) | interior treasuries at the header | idle interior gold | men (need) |
|---|---|---|---|---|---|
| 4/3012 | 13 | 9 | 4 (8 at y35) | ~15,000 | 3,248 (1,833) |
| 5/3009 | 11 | 4 | 2 | 5,965 | 2,102 (5,152) |
| 7/3013 | 13 | 9 | 8 | 16,242 | 1,485 (1,202) |
| 10/3003 | 11 | 7 | 7 | 12,140 | 2,645 (1,294) |

- **The investment is idle gold in the outposts.** The depots empty the interior of men; its treasuries sit at the header (where the harvest is clamped away), 600-850 men's worth at the late hire rate (18-20 gold a man). Half to three quarters of the fiefs have peasants at 95% of the header or more; in 10/3003 five of seven interior fiefs sit near 50% with full treasuries, not giving (the ladder gives at most 60; `own_gift`, MIRR's model of a fief's own gift, assumes all its gold above the upkeep, and `harvest_value` empties the stores, so the clamp is not seen: not changed).
- **Fielding an army: two blocks.** (1) The header caps a fief's men at 1,600-1,980; the last rival's big fief wants a line of 2,150-2,500 (4/3012 fief 1, 5/3009 fief 8, 7/3013 fief 0): no single fief can take it. (2) The targets that fit are refused by `score` because the prize would be left COMING (4/3012 6→2: 66 of 72 candidates; the 6 that pass send more than the line) or because an emptied interior capital fails `capital_ok` (10/3003). **The cause of (2):** `hold_line` read `enemy_neighbours(T)`, T's neighbours its owner does not hold, so it left out that owner's other fiefs, the very ones facing the prize once it is taken. With one rival left the hold line was 0, `_stage_line` sized the strike to win only, MIRR priced it as held, and the planner built toward an attack `score` refused every season.
- **Not a stall but churn.** 5/3009 swung 7-12 fiefs; 10/3003 reached 16 of 17 at year 36 and lost 5 within two years; 5-7 failed attacks a game after year 30. In 5/3009 the hub (8, Mino: seven neighbours) sat COMING for several seasons while its men drained 263 → 97, then attacked 7 with 580 men and lost (its survivors join the defender, $E03C, though a lost battle still leaves the garrison smaller, #62: the 580 were mostly just gone), and rival 2 took it with 644: 4, 5, 10, 12 went COMING at once (Echizen, Hida, Omi, Iseshima, Shinano, several of them backline before) and the army bill went from 2,025 at year 40 to 4,484 at year 45. Chris: *these big plays make or break games; our job is to make sure they happen on our side.*

Built, each behind a flag (off): `HOLD_ALL` (`long_game --hold-all 1`): the hold line counts every AI-held neighbour of T not ours (also changes `strike_plan`'s hold). `EMPIRE_RESCUE` (`--rescue 1`): a SAFE fief's first command, ahead of its gift and ladder: Move its spare men (over its own line, the capital's line for the capital) into an adjacent owned fief that is COMING or HUNTABLE and short, receivers that have not acted first; and in Spring and Summer Send rice to a fief whose rice will not carry the Fall's upkeep and the next (the ledger's feed line, the reader's Summer purchase test), so it is spared a rice-buying turn.

| every start, seeds 3000-3019, 70 years, skill 2, strike 8 + capital first + ladder | won | paired | invaded | age | fiefs y20 / y30 / y45 (mean over the games alive then) |
|---|---|---|---|---|---|
| ladder (#66) | 60 | | 179 | 93 | 4.7 / 7.7 / 7.4 |
| ladder + hold-all | 66 | saved 31, lost 25, z +0.8 | 190 | 76 | 5.0 / 7.6 / 8.8 |
| MIRR (#69) | 57 | | 182 | 90 | 4.8 / 8.8 / 9.2 |
| MIRR + hold-all | 58 | saved 32, lost 31, z +0.1 | 190 | 82 | 5.1 / 8.8 / 9.4 |
| MIRR + rescue | 64 | saved 34, lost 27, z +0.9 | 177 | 92 | 5.0 / 8.4 / 9.2 |
| MIRR + both | 57 | saved 31, lost 31, z 0.0 | 174 | 103 | 5.2 / 9.1 / 9.6 |

- **Nothing moves the win count past noise.** The hold line wins its games sooner (the games both versions win: 2.4 years earlier under MIRR) and loses more to invasion (182 → 190); the rescue made 5.2 Moves a game.
- **The feed line never fired:** in three games over 40 years, 1,142 Spring/Summer fief-seasons, not one fief was short of the rice for the Fall and the next, and there was one Summer rice purchase. The ladder already hires only what the rice feeds (`_feedable`); there is no rice turn to save.
- **The single games scramble:** under the four flag sets the four stalled games came out (won y32 / invaded / age at 9 …) with no pattern; one change reshuffles a whole game. Only the paired 340 counts.
- **Next (Chris):** not more protection (*a SAFE fief is safe barring a disaster; extra is insurance*), but the big play in reverse in the battle picker: a target's value includes what its fall costs its owner, the jump in the owner's army bill as its other fiefs turn exposed, beside the harvest and the men it frees for us; and the losing branch of an attack (the men lost and the source left short) priced into its MIRR.

### #69 — The ledger priced by MIRR: the accounting is right, and it plays level with the ladder (Chris, 2026-11-18)

Chris, on #68: *we are not calculating MIRR correctly. Everything into attack gets outgrown in the later half, so men → attack is not always better than development; it is better early, when the armies on the board are small, and the ROI of everything falls as the game ages. The gift's value was supposed to be marginal over the fief's own gifting, and priced by turn order (the donor first: one combined gift; the receiver first: two separate gifts). It is all calculable from the formulas, no empirical data. MIRR costs in time, so if the predictions are right it is the least time; if attack is better, MIRR shows it and does it anyway.* Old age is beyond control, not a thing to optimise.

`expand.EMPIRE_MIRR` (`long_game --mirr 1`; off), on #68's ledger. Every option is a stream of cash flows over `MIRR_H` = 8 seasons, from the formulas:
- **gift**: `develop_stat`'s gain, amount × (6 − skill) / √(level + amount), the amount under the root, so one gift of 1,000 at level 400 gains 26.7 per point of the factor where two of 500 gain 33.2; income is the harvest's (`harvest_value`: gold, and rice at the exchange rate; marks reset; stores emptied, so the header's clamp clips nothing); a Summer gift misses the Fall after it;
- **transfer**: at the margin over the receiver's own gift (its gold above the year's upkeep): one combined gift if it has not yet acted this season, else a second, separate gift on its next turn; a receiver that would cap prices at −1;
- **attack**: the target's men grown to the strike season (`growth()`), the hold-sized line; **men are capital**: every man sent is invested at the hire rate (a hire only turns gold into men) and the survivors return at the horizon; the defender's treasury is taken (`_conquest`), the men freed by the army bill (or the new front's cost) at the conquest, the upkeep (men/2 gold and men/2 rice at each Fall) on the men held, the prize's income from the Fall after;
- **terminal value** at the horizon: an income stream from then on at r, men at the hire rate;
- **MIRR** = (FV of the inflows at r ÷ PV of the outflows at r)^(1/8) − 1 a season, inflows and outflows kept **gross** in each season; **r**, the reinvestment rate, the best IRR of an owned fief's own gift that season (the last one known when none can give). Safety lines first; then the donor's gold goes to the highest MIRR above r, attack or growth; none above r, it keeps its gold. The attack line is the best MIRR above r (kept unless a new one compounds 25% more over the horizon).

Two accounting errors on the way, each found in the numbers: with the men already held counted free (only new hires invested, the lost men netted at the horizon), a quarter of the attacks priced at the cap of 1.0; with men as capital but an attack that lands this season netting its men against the treasury it takes in the same season, 20% still did. Gross flows: 8 of 16,793.

| every start, seeds 3000-3019, 70 years, skill 2, strike 8 + capital first + ladder | won | invaded | age | y20 fiefs | y30 | y45 | econ y20 |
|---|---|---|---|---|---|---|---|
| ladder (#66) | 60 | 179 | 93 | 5.1 | 7.7 | 7.4 | 0.70 |
| ROI ledger (#68) | 34 | 198 | 101 | 4.5 | 7.9 | | 0.71 |
| MIRR, the army's men free | 54 | 189 | 89 | 5.5 | 8.7 | | 0.66 |
| MIRR, men as capital, netted | 62 | 180 | 87 | 5.3 | 9.4 | | 0.69 |
| **MIRR, men as capital, gross** | **57** (saved 36, lost 39, z −0.3; against #68: saved 39, lost 16, z +3.1) | 182 | 90 | 5.2 | 9.2 | 9.5 | 0.67 |

Per game (gross): the donors chose the attack 13.6 times and growth 4.9 (by gold, 5,500 to the attack and 2,200 to growth); the striker hired 13.7 times and drew 15 Moves and 8 marches. r's quartiles 0.08 / 0.11 / 0.15 a season; the attack line's MIRR 0.15 / 0.20 / 0.27; an attack line stood in 66% of seasons. In the probe game development beat every attack in 1566 (best 0.12 against r 0.13-0.17) and the attacks took over by 1570 (0.26 against 0.09): the switch Chris described, from the formulas, untuned.

- **MIRR repairs the ledger** (34 → 54-62 across the three accountings, all within noise of each other) and plays **level with the ladder** (57-62 against 60). The empire it builds is larger (9.2-9.5 fiefs from year 30 on, against 7.4-8.3), at the same invasion count.
- **The stall is still there, one fief further on.** Past year 30 the surviving empires sit at about 9 fiefs with 3.4 rivals left, in both players, and the lord's age (90) takes them. MIRR prices the next attack and the next gift correctly; it does not see past the horizon of one conquest, and the late conquests are the ones a single fief's line cannot reach.
- **Open:** r jumps with whichever fief can give (1% in a season when only a poor fief could); the defender's men that join on a win (half the survivors) are not counted (a battle would have to be run); each fief's own command still follows the ladder and `strike_plan`, MIRR only directs the donors' gold and the attack line.
### #68 — Attacks on the ledger, priced by ROI: gold is the wrong currency, the clock is (Chris, 2026-11-18)

**Corrected in #69 (Chris):** the conclusion below is wrong. The fault was the metric, a perpetuity yield with no timing, upkeep, terminal value or reinvestment, and a transfer priced without the receiver's own gift. It was not the currency. Priced by MIRR, the same ledger wins 57 (against 34).

Chris: *see if we can add attacks and price their ROI, to see how they fit in the model.* `expand.EMPIRE_ATTACK` (`long_game --empire-attack 1`; off), on #67's ledger. For each owned S and enemy neighbour T: the hold-sized line (`_stage_line`); the **return** is T's harvest gold as ours (the conquest's writes in a `forecast.held` copy: owner, Direct, not a capital, tax at most 30, the survivors in it); the **cost** is the gold to hire the men S lacks, plus the men the battle uses up (`fought_keep`), less the men freed by the fiefs it turns interior (the army bill before and after, T's own need aside). ROI = return ÷ cost, the growth lines' scale (gold a year per gold). The best attack (kept unless beaten by 25%; `strike_ok` while the empire is all SAFE) is a rank-3 line beside the growth lines, taken in ROI order: S hires toward it keeping the War gold, its neighbours Move men in, farther fiefs march a step, topped fiefs Send the gold.

**A valuation bug, which #67 carried.** The growth lines read exactly 1.0 every season. `gold_income(reset=False)` (start index 7, seed 3000, skill 2, years 12-20, a 100-gold gift):

| fief | as the ledger read it | with the Summer reset | unclipped (the real gain) |
|---|---|---|---|
| peasants at 1959 of 1960 | 100 | 100 | 3 |
| 16, Fall | 0 | 38 | 38 |
| 6, Fall | 100 | 100 | 20 |

A treasury near its header made the gift look like it paid back in full (it only made room under the clamp, `cap_fief_stats`), and in Fall and Winter the marks it read were the low ones (the next harvest follows a Summer reset). `year_gold` (reset, no upkeep, treasury emptied first) now prices both the gifts and the prize. #67's growth row ranked receivers by the artifact; it is rerun below. `strike_plan`'s grow plan uses `gold_income(gift=…)` with the reset and may carry the clip; not changed.

| every start, seeds 3000-3019, 70 years, skill 2, strike 8 + capital first + ladder | won | invaded | age | y15 fiefs | y20 | y30 | econ y20 |
|---|---|---|---|---|---|---|---|
| ladder (#66) | **60** | 179 | 93 | 3.0 | 5.1 | 7.7 | 0.70 |
| + safety transfers (#67, `--empire 2`) | 49 (z −1.4) | 170 | 114 | | 5.0 | 8.4 | 0.70 |
| + growth, valued right (`--empire 1`) | 26 (saved 12, lost 46, z −4.5) | 180 | 126 | 2.4 | 3.9 | 6.8 | 0.70 |
| + growth + attack lines (`--empire 1 --empire-attack 1`) | 34 (saved 20, lost 46, z −3.2) | 198 | 101 | 2.9 | 4.5 | 7.9 | 0.71 |

Per game, the full model sent ~9,600 gold to growth (17.6 Sends) and ~5,000 to the attack (10.1 Sends), made 12 Moves and 6.4 marches into the striker, and the striker hired 16 times. Attack ROI quartiles 0.13 / 0.23 / 0.59, growth 0.20 / 0.24 / 0.29: the attack ranked higher in 53% of seasons. **The two do compete on one scale**, and the planner splits the gold between them about 2:1.

- **The growth gifts do not grow the economy.** At the same fief count, econ per fief moves 0-7% (y20: 301 ladder, 322 growth, 312 full) while men per fief fall (281 → 242 in the full model) and conquest slows (5.1 → 3.9-4.5 fiefs at y20). The receiver's own turn already gives to its peasants (the reader); the donor's gold mostly replaces that gift, at falling returns, and was the gold that hired the army.
- **Pricing in gold misses the objective.** A gold-a-year return is a perpetuity; the game has a deadline. At skill 2 the binding loss is the lord's age (93-126 of 340), and anything that moves the next conquest later loses the race no matter its yield: growth at 0.24 a year needs four years to repay, the lord rarely has the years. The attack's real return is not T's harvest but **the seasons it brings the following conquests forward** (T's men and gold join, fronts close, the next target is nearer).
- So the ROI model is the right shape and the wrong unit. **Next:** price every line in time: how many seasons it moves the empire's next conquest (and the one after) forward, from the strike planner's own X (`strike_plan`'s earliest season); a growth gift is worth what it saves in X, which at these returns is usually nothing.
### #67 — The empire planner's transfers, built: safety transfers are neutral, growth transfers slow the conquest (Chris, 2026-11-18)

#66's design made concrete (`expand.EMPIRE`, `long_game --empire 1`; `--empire 2` without the growth lines; off), on top of the ladder. Once a season, on the owner's first turn, a **ledger** of what each owned fief still lacks after spending its own gold (the projected year): COMING then HUNTABLE fiefs the gold for their cliffs plus the hire to their own line, and the rice to feed those men (`_feedable`); fiefs under a cliff the gold for the Give (costed at 60); from Fall to Spring, the fiefs still growing, ranked by the Fall gold a 100-gold gift returns (`gold_income`). On its turn a SAFE fief with men over its own line **Moves** them into an adjacent COMING fief (the emergency move); a SAFE, topped-out fief **Sends** to the top open line, receivers that have not yet acted this season first (Move and Send land at the command, #66). Each Send shrinks its line, so several donors fill one fief and a filled fief drops out; growth gold is **earmarked** and given to the receiver's peasants on its own turn ahead of anything else. Emptying outposts was already the depots' job.

| every start, seeds 3000-3019, 70 years, skill 2, strike 8 + capital first + ladder | won | invaded | age | y20 fiefs | y30 fiefs | econ y20 |
|---|---|---|---|---|---|---|
| ladder (#66) | **60** | 179 | 93 | 5.1 | 7.7 | 0.70 |
| + safety transfers (`--empire 2`) | 49 (saved 26, lost 37, z −1.4) | 170 | 114 | 5.0 | 8.4 | 0.70 |
| + growth transfers (`--empire 1`) | 44 (saved 22, lost 38, z −2.1) | 186 | 100 | 4.4 | 7.6 | 0.73 |

**Corrected in #68:** the growth lines here were ranked by a valuation artifact (the header clip, and no Summer reset); valued right, growth transfers win 26, not 44.

Per game the safety planner made ~3.6 emergency Moves (96 men each) and ~2.6 Sends (unsafe 530 gold, huntable 360); the growth planner added ~24 growth Sends (460 gold each), nearly all given away by the receivers.

- **Growth transfers work as an economy and lose as a strategy.** The economy rises (0.73, the highest of this line), but the gold is what the topped-out fiefs hired the striking army with: fiefs held at year 20 fall 5.1 → 4.4 and the lord's age takes the difference. Growing the weak fiefs is a real return; it is not a bigger one than the next conquest, which the ledger does not price.
- **Safety transfers are neutral to slightly worse.** They cut invasions (179 → 170) and the empire is *larger* at year 30 (8.4 against 7.7), but the games it loses are late (29 of 37 to the lord's age, 11-16 fiefs at the peak): the emergency Move takes spare men from a SAFE fief, which is also the fief that would strike, and each Send spends a topped fief's hire. The ledger has no line for "the next attack".
- So Chris's #66 caution holds: **attacks have an ROI too**, and a planner that ranks only growth and safety starves them. The next step is to put the attack on the ledger: the campaign's men and War gold (`_stage_line` / `strike_plan`) as a line competing with the others, ranked by return per gold, so a donor gives to whichever is worth more.
### #66 — The empire planner, designed: a fiscal year, a fief ladder, and transfers that solve several problems at once (Chris, 2026-11-18)

Chris: *keep safety over dying of old age; the hope is that controlling many interior fiefs makes up for the slowness, if logistics get better.* Every fief keeps growing, which includes sending gold, rice and men to weak fiefs so they get up and running faster. Attacks have an ROI too, but are the hardest to price, and are left out of the first planner.

**The cartridge's year** (appendix-formulas, cartridge-checked, #54). Gold and rice arrive once, at the Fall harvest, before Fall's commands, and the army's upkeep is paid there. Each Fall's income reads the lower of each stat's Summer snapshot and its Fall value, so a gift pays at the coming harvest only if it lands before Summer. One Give to the peasants lifts loyalty **and** wealth (`driver_give`); morale is a separate Give to the men. A Send is clamped to the receiver's header room. So:

| Season | The year's job |
|---|---|
| Fall | the harvest in hand: transfers out of the rich fiefs, urgent fixes |
| Winter | the receivers spend: gifts, hires; more transfers |
| Spring | the last season a gift pays this harvest |
| Summer | the upkeep: can each fief feed its men through Fall (buy rice or hire); no gifts (they pay a year late) |

What is scarce is not transfers but **gold, which arrives once, and each fief's four commands a year**.

**The fief ladder** (Chris; each fief alone, one command a season): tax to 55 as loyalty bears it; morale under 45 (an army revolt is worse than a riot); loyalty or wealth under 45 (one Give fixes both; the fief in trouble fixes one cliff a turn); men while not SAFE, only as many as its rice can feed (a non-SAFE fief whose economy cannot carry the army is taken anyway), buying rice if needed; the gift; then hire.

**The planner** (Chris): rank on the **projected** year, not the current state. Each fief is first played alone through its ladder with what it holds; the transfers then fill the gaps that projection shows (unsafe first, then cliffs, then the best gift that can still land before Summer). A fief covered by a transfer drops out of the queue, so the weakest fief does not absorb everything. Re-planned every season (events, battles, the shuffled order).
- **Send** reaches any owned fief; **Move** only an adjacent one. Gold is the general tool. Men still matter in two cases: an **emergency move** (a COMING fief, and a SAFE neighbour that acts before the attacker in the season's order, `m.acted`: better than waiting for the fief's own turn, especially if it comes after the attacker's), and **emptying an outpost** to put its army where it is used.
- **Several donors, one receiver, one season**: X sends gold for the morale or peasants problem while Y moves men for the shortage, so the fief most in need gets several problems solved at once.
- **Send/spend cycles** get past the header cap: send to the header, the receiver spends (a gift, a hire), send again. Turn order decides how fast: if Y moves after X for two seasons, the cycle completes in those two.
- **Move and Send land at the command, checked on the cartridge** (2026-11-18, `tools/check-transfer-timing.py`, headless Mesen): Owari given Mino as a conquest writes it; Mino Sent 10 gold in Summer 1560, Owari's gold went 100 → 110 at once, and Owari's own Summer turn, later that season, had the 110 to spend. A Move (Owari → Mino, 10 men) wrote both fiefs' men when the command completed (after the *arrived safely* message; `effect_move` at $97A7). Chris had recalled end of turn. So a donor acting before its receiver in the season's shuffled order saves a season, which the emergency Move and the same-season send/spend cycle rely on; the sim's `move_men` and `send` already behave this way.

**Step 1, the ladder alone** (`expand.LADDER`, `long_game --ladder 1`; off): the rungs above, ahead of the depots and the strike hire, after the attack and the capital's hire. Results below.

| every start, seeds 3000-3019, 70 years, strike 8 + capital first | skill 1 | skill 2 |
|---|---|---|
| capital first (#64) | 166 (invaded 149, age 12; econ y20 0.75) | 45 (invaded 214, age 73; 0.72) |
| + secure (#65) | 170 | 46 (invaded 183, age 99; 0.66) |
| **+ ladder** | 171 (saved 44, lost 39) | **60** (saved 41, lost 26, z +1.8; invaded 179, age 93; 0.70) |

**The ladder is the best skill-2 player of this line** (#61's base was 40): it keeps secure's cut in invasions (214 → 179) and gives back most of its economy (0.70 against 0.66), because men while not SAFE stop where the rice stops and the cliffs come first. The lord's age still takes 93. Skill 1 is unchanged.

**Skill 3** (same harness): 1 unified against 0, but the shape changes: invaded 275 → 207, **starts that expand 77 → 141**, the lord's age 58 → 123, first conquest year 14 → 17, econ at year 20 0.50 → 0.32. The ladder keeps skill-3 starts alive and lets them expand; their economies then stall at a third of the AI's, which is the planner's job.

**Next:** the planner's transfers on top of the ladder (the projected year, Send from the topped-out fiefs, the emergency Move); the Move/Send timing checked on the cartridge.

### #65 — Eight stalled games stepped through: the gate is local fiefs that never secure themselves, and the lord's empty capital (Chris, 2026-11-17)

Eight stalled games traced (`na1sim.trace`, capital-first player; skill 1: Omi s3010, Settsu s3001, Musashi s3005, Suruga s3001; skill 2: Iseshima s3009, Hida s3011, Mikawa s3016, Echizen s3001). Seasons with 2+ fiefs, by what held the player back: **some fief not SAFE, so no attack anywhere: 27-47%**, the largest cause in every game; Summer 25%; attacked 8-25%; an attack would have passed but the fief spent the turn on Assign 5-10% (all 85 cases: `split_ready`); blocked by no winning split, another fief or the prize 2-25%.

- **COMING fiefs do not secure themselves.** Median 73 men against a 113-man neighbour, with 747 gold and morale 72; on their own turn the reader's economy or a gift 321 times of 442, a hire 121. The same 1-3 border fiefs each game. One fief's local choice freezes every front: its safety is priced locally and costs empire-wide.
- **The empty capital.** Two of the four skill-1 invasions lost the lord's fief with 1 and 0 men (to 25 and 15). With no enemy within two steps `capital_line` is 0, the depots march every man out, `clear_military_stats_if_no_men` sets morale 0, and the capital hire needs morale at the cliff, so it never refills.
- Topped-out fiefs hire in up to 46% of their turns while a neighbour stays COMING (Chris's frame: their surplus should jump-start the others).

Switches (off): `--capital-guard 1` (`CAPITAL_GUARD`: the capital line reaches three steps when nothing is within two; an emptied capital hires past the morale gate); `--secure 1` (`SECURE`: a fief not SAFE hires toward `own_need` before anything else). Against the capital-first player, every start, seeds 3000-3019, 70 years:

| | skill 1 | skill 2 |
|---|---|---|
| capital first (#64) | 166 (invaded 149, age 12) | 45 (invaded 214, age 73) |
| + capital guard | **180** (saved 26, lost 12, z +2.3; invaded 127, age 20) | 37 (5 / 13, z -1.9; invaded 202, age 91) |
| + secure | 170 (48 / 44; invaded 141) | 46 (35 / 34; invaded 183, age 99, expanded 199 vs 162, first conquest 12 vs 9) |

The guard saves skill-1 empires from the walk-in and slows skill 2 (men held at home, the lord's life runs out). Secure trades invasions for age at skill 2: 31 fewer invaded, 37 more starts expand, three years later, and the clock takes them; the safe fief does not grow (econ at year 20 0.66 vs 0.72). The rush/boom trade in one switch. The runs of both together and skill 3 were stopped by the machine (memory) and not rerun.

**Open:** both switches together, and skill 3; secure only after the opening (it delays the first conquest); a topped-out neighbour sending men or gold to the COMING fief instead of its own hire; the Assign turn.

### #64 — Stepping through a game: the trace, and a capital that gave its gold away (Chris, 2026-11-17)

Chris: aggregates do not show the bottleneck; step through games fief by fief, season by season. `na1sim.trace FIEF SEED out.json` reuses `long_game.one` unchanged and records, at every player turn, the board (every fief's owner, men, gold, rice, wealth, loyalty, town, output, header, morale) and, for the fief moving, its state, own line, topped-out flag, the command and the rule that took it, its cheapest target (hold-sized send, shortfall, gold), and, when the empire is all SAFE, each target's blocker. A swimlane viewer (fiefs × seasons, coloured by command) was published as a private artifact from the session.

**The first game traced found a bug.** Owari s3001, skill 2: from 1577 to 1587 five fiefs, all SAFE, 1,400 → 4,755 men (Mikawa 1,920, short 0 against Shinano and Suruga), no attack, lost to a revolt. Every target's blocker was `capital`: the depot rule ran before the capital's own hire in `expand_policy`, so the interior capital (147 men, line 229-310, morale 204) sent its gold to the front every season and never hired, and `capital_ok` vetoed every attack. `expand.CAPITAL_FIRST` (`long_game --capital-first 1`, off so earlier results reproduce) hires to the capital line first. In the traced game the attacks resume (11 fiefs by 1581), then the capital is emptied to 0 and the empire falls apart by 1583 (not yet traced).

| 340 games, strike 8 | skill 1 | skill 2 | skill 3 |
|---|---|---|---|
| as committed | 164 | 40 | 0 |
| capital first | 166 (saved 7, lost 5) | 45 (12 / 7, z +1.1) | 0 |

A real fault, and a rare one: it decides about one game in thirty, so it is not the general mid-game stall.

**Open:** trace more stalled games (with the fix) to classify the stalls; the emptied capital in the fixed game; Chris's rush/boom frame, a per-fief return-on-investment choice each season between developing, closing the cheapest target's shortfall (with the back fiefs it creates), and sending the surplus to a growing fief, keyed on whether the empire is ahead of the largest rival.

### #63 — Staging toward a hold-sized strike works, and the gate is the whole empire's SAFE (Chris, 2026-11-17)

Chris: *mid to late game is generally where AIs stall, because the coordination to do large campaigns is harder; we can try staging.* #62 found the men beside the striker too few in 37% of stalled pairs, while the empire held hundreds over its lines.

**Staging** (`expand.STAGE`, `long_game --stage N`; off). Each season with everything SAFE and no campaign on, the empire picks one striker and target that the striker cannot take alone. The strike is sized so the survivors hold the prize's share line (as `--combine 1`), the striker's own line on top. The pool is every connected owned fief's men over its own line, counted out to `STAGE_ETA` 4 steps. The choice is the nearest pool, then the smallest shortfall, and it must pass `strike_ok`. The campaign is kept until the target falls, the plan breaks, or N seasons pass, re-sized to the target's men each season. Every other fief marches its spare men a step toward the striker; one with none to march Sends gold if the striker lacks the War gold; the striker hires the rest, keeping the War gold. `best_attack` makes the strike. This differs from #48's `STAGING` (always on, sized to win, re-picked each season). The tally has `stage` events.

| 340 games, strike 8, stage 8 | skill 1 | skill 2 | skill 3 |
|---|---|---|---|
| no staging (#62's base) | 164 | 40 | 0 |
| staging | 168 (saved 31, lost 27) | 39 (23 / 24) | 1 (1 / 0) |
| campaigns ended with the target taken | 1,041 of 1,325 (79%) | 761 of 1,145 (66%) | 141 of 244 (58%) |

**The mechanism works and the count does not move.** In the games both sides lose (peak 5+ fiefs at skill 2, 87 games), staging makes the middle game slightly worse: 10.6 attacks after year 15 against 12.1, and 8.7 won against 10.0. At skill 1, campaigns that reached their line sat stuck at the striker's turn for 2,115 fief-turns: **1,031 because another owned fief was not SAFE**, 795 in Summer (waiting), 265 rejected by `score`, 24 short of gold.

**The binding gate: the whole empire must be SAFE** (`best_attack`, `score`, `strike_plan`, `combine_plan`, `stage_plan` all ask it). The census (`safe_census.py` in the session scratchpad, 17 starts × 4 seeds, the strike-8 player, the first own turn of each attack season):

| fiefs held | 1 | 2-3 | 4-6 | 7-9 | 10-13 | 14-15 | 16-17 |
|---|---|---|---|---|---|---|---|
| all SAFE, skill 1 | 52% | 60% | 36% | 51% | 44% | 71% | 99% |
| all SAFE, skill 2 | 37% | 59% | 45% | 44% | 41% | ~70% | 92% |

Through the middle game, from 4 to 13 fiefs, **one or more fiefs is short in more than half the attack seasons**, and any one of them vetoes every attack anywhere in the empire. Under staging the share falls (skill 2, 3-8 fiefs: 24-42%), and only 7-20% of the unsafe fiefs are ones it drained in the last four seasons. Concentrating men on one striker raises the odds that some other fief is short. The rule dates from #48 (*a player who cannot hold one fief will not hold two*), written when empires were small.

**Open:** a local gate, where an attack must leave the fiefs it touches SAFE (the source, the prize, the fiefs whose borders change, the capital) and must not worsen any other fief, instead of requiring the whole empire SAFE; then staging and combining again under it; the rest of #62's open list.

### #62 — The mid-game stall: lost attacks do not feed the defender, the stall is the hold, and the adjacent pool is too small (Chris, 2026-11-17)

Chris: at 9 fiefs, back-line chances are target selection; the interesting lever is **2+ fiefs coordinating one attack**, where the men each holds above its hold line combine to reach the odds. And two kinds of combined attack: several fiefs on the same turn (turn order matters), or the same fief over several years (the enemy may recover faster).

**The season's mechanics** (sim, from the ROM): the command order is shuffled every season and the player sees who has acted (`game.command_pass`, `m.acted`); a Move lands at once (`expand.move_men`, effect_move $8CA5), so men moved into a fief that has not acted yet fight in its attack that season.

**The combined attack** (`expand.COMBINE`, `long_game --combine 1`; off). Only when no fief can attack alone: the owned fiefs beside a striker Move it the men they hold over their own line (`own_need`, with margin), before its turn, and `best_attack` makes the strike. `--combine 2` pools to the win line; `1` (`COMBINE_HOLD`) to the prize's hold line (survivors at its share line, by the keep table).

**Do lost attacks feed the defender?** `apply_conquest_outcome` ($E03C) garrisons the defender with both armies' survivors, win or lose, so the plan first assumed waves feed the target. Chris: *not if done right*: go in 100/0/0/0/0 so the battle ends with the commander's death and no men to capture (a unit goes at 0 men, $9D03; the battle ends when slot 0 is gone, $AB87); or keep the cavalry striker (it has bonuses the commander lacks) and *suicide the 1% leader after the cavalry is spent*. `skill_lab --split solo | sacrifice` (`strike.Charge(solo=, sacrifice=)`, `expand.SPLIT_MODE`) now also reports each lost battle's garrison change per man sent. 7 pairs × 10 seeds:

| win % (kept on a win) | skill 1 heavy / solo | skill 2 | skill 3 |
|---|---|---|---|
| 1.5× | 46% / **66%** | 4% / **26%** | 0% / **13%** |
| 2.0× | **100%** / 84% | 74% / 76% | 17% (0.24) / **43% (0.34)** |
| 2.5× | 100% / 100% | **100%** / 89% | **94%** / 73% |
| 3.0× | 100% / 100% | 100% / 100% | **100%** / 89% |

- **No lost battle fed the defender, under any split**: over 400 losses, the garrison fell by 0.37-0.58 men per man sent. Under the heavy split the striker dies before the commander, so the 1% is all that is left; **sacrifice is identical to heavy** to the digit (the switch never fires). So waves wear a target down, and the same fief over several years (Chris's second kind) is open.
- **Solo against heavy is a per-target, per-ratio choice**: solo wins far more under 2× (skill 3 at 2×: 43% against 17%), heavy is surer from 2.5×, and pairs split hard (Owari → Mikawa: solo 0/10 at every skill; Omi → Yamashiro, Settsu → Yamato, Iseshima → Iga: solo 10/10 at skill 3, where heavy wins 4, 0 and 3). Not yet traced why.

**The stall, measured** (8 stalled skill-2 games, years 22-34, 6+ fiefs held): the empire holds **465-1,475 men over its own lines and 6,000-18,000 gold** while the cheapest target needs 95-311 men. Not a shortage. With everything SAFE (62% of those seasons), of 372 fief-turns: 154 have no winning move within that fief's own war cap, **114 would leave the prize COMING** (beside a large rival), 29 leave another fief unsafe, 13 the capital short, 61 attack. **The stall is the hold, not the win.**

| 340 games, strike 8 | skill 1 | skill 2 | skill 3 | combined strikes (won), skill 1 / 2 / 3 |
|---|---|---|---|---|
| no combine | 164 | 40 | 0 | |
| combine to the win line | 171 | 43 | 0 | 82 (75) / 125 (101) / 21 (14) |
| combine to the hold line | 173 | 41 | 0 | 85 (81) / 138 (123) / 31 (21) |

**Neutral: it fires about once in the games that use it**, and three in four contributing moves do not become a strike that season. In the stalled seasons, of 645 striker-target pairs: **the adjacent pool is too small for 37%** (the spare men sit elsewhere in the empire), the striker has already acted for 20%, the striker could go alone for 11%, its gold is under the men to send for 8%, the line exceeds its header for 3%; 22% are feasible, and of those `score` passes two in three (the rest: another fief left unsafe, or the prize still COMING).

**Open:** bring the empire's spare men to the striker over several seasons (staging toward a hold-sized strike: #48's `STAGING` was measured worse at skill 1, before this objective existed) and its gold (a Send before the strike); why the striker so often reshapes first (`split_ready` → Assign spends its turn); solo or heavy chosen per target and ratio; the same fief over several years, now that a lost battle weakens the defender.

### #61 — Grow or strike: the economy has a floor, and a targeted strike beats a lower threshold (Chris, 2026-11-16)

Chris: at skill 3 the opponents outgrow us and we stagnate, so expand sooner by forgoing growth. *How much econ can we give up without putting us at risk?* Nail the principles at skill 1 first. It is context-sensitive: some fiefs can strike sooner because their neighbours are weak.

**The uniform dial: `--topped`** (hire the attack army before the economy is full; #58 swept it at skill 3 only). Skill 1, 340 games, 70 years; econ = the Economic Index per own fief over the AI's, median:

| topped at | unified | alive at 6 | first conquest, year quartiles | econ, years 5 / 10 / 20 |
|---|---|---|---|---|
| 100% (#48's player) | 155 | 216 | 9 / 9 / 10 | 1.11 / 0.86 / 0.76 |
| 70% | 168 | 216 | 8 / 9 / 9 | 1.11 / 0.81 / 0.71 |
| 50% | 172 | 219 | 7 / 8 / 8 | 1.11 / 0.85 / 0.66 |
| 30% | **178** | 227 | 6 / 7 / 8 | 1.05 / 0.79 / 0.61 |
| 15% | 117 | 232 | 5 / 7 / 10 | 0.85 / 0.65 / 0.52 |
| 0% | 86 | 236 | 7 / 9 / 14 | 0.76 / 0.54 / 0.48 |

- **Tempo pays until a floor, then falls off a cliff.** About 8 unifications per year of earlier first conquest, down to roughly 0.6 of the AI's economy at year 20; then 178 → 117 in one step. At 0% even the first conquest comes later: an army without an economy cannot fund the War gold, and the men sit.
- **Survival and winning separate.** Alive at 6 rises all the way down (216 → 236); unification does not. Hiring everything makes you hard to kill and unable to win.
- **The metric is P(win), and the safe choice is the plateau, not the peak** (Chris: even with the fastest unification found by EV, % win argues for a safer approach). 168 / 172 / 178 are within noise at 340 games; the cliff at 15% is not. The edge moves with skill, the start, and shocks: plague halves a fief's men before anyone moves (#46: 7 of 38 one-fief deaths), and losing a fief is only fatal while you hold one. So the risky window belongs to the one-fief → two-fief step, and holding one fief longer is itself the exposure.

**The targeted dial: earliest-X strike hire** (`expand.STRIKE`, seasons; `long_game --strike 8`). Chris: *we know the growth rate of all neighbours and what we can afford; compare how quickly we could hire men to invade by time X, and decide grow vs hire by whatever makes X smallest. The targets are moving, but we can calculate lead.* Each season a fief that is not topped prices every enemy neighbour over N seasons, the neighbour's men growing at its observed slope (`record_men`, `growth`: the last 4 seasons), under two plans: **save** (hire the gold into men) and **grow** (give it to the peasants first; the gift pays from the first Fall after the next Summer mark reset). X is the first season the gold covers the hire to the line plus the War gold, the line being the men sent (fought_need on the projected garrison; with `HOLD`, enough that the survivors stand at the prize's share line) plus the fief's own gate. The fief follows whichever plan strikes sooner, ties to grow. The attacking fief need not be SAFE before (at skill 1 the opening sits COMING for about 9 years, under its own line, while every gold goes to the peasants; the line includes its gate, so hiring to it is how it gets SAFE). `--tol EARLY,LATE,YEARS` lets the conquered fief be left HUNTABLE or COMING (the rest stay SAFE) early.

**Banking deadlocked, and is gone** (Chris: *the player should not be banking at all; enough buys at max econ should either max his army or put it to a tolerable attack*). The first version let a short fief pass its season to bank gold. All five variants (SAFE with or without hold, HUNTABLE or COMING for 10 years, HUNTABLE always) unified only **107-123**, and the lord's death by age rose from 11 to 35-53. Traced on 8 games: the plan called a strike ready now for 30-55 seasons that `best_attack` never approved (the prize or the home left unsafe), and the fief sat on its gold. Those five rows measured the deadlock, not the tolerance. Now gold that cannot hire this season develops.

| 340 games, 70 years | unified | expanded | invaded | lord died | first conquest | econ, years 5 / 10 / 20 |
|---|---|---|---|---|---|---|
| skill 1, control | 155 | 205 | 163 | 11 | 9 / 9 / 10 | 1.11 / 0.86 / 0.76 |
| skill 1, strike 8 | **167** | 215 | 144 | 15 | 6 / 8 / 10 | 1.06 / 0.85 / **0.77** |
| skill 1, strike 8 + topped 30% | 161 | 219 | 150 | 18 | 6 / 7 / 8 | 1.04 / 0.78 / 0.62 |
| skill 1, tolerance only (HUNTABLE 10 years) | 154 | 205 | 162 | 13 | 9 / 9 / 10 | 1.11 / 0.87 / 0.78 |
| skill 2, control | 32 | 140 | 231 | 69 | 11 / 12 / 13 | 0.93 / 0.79 / 0.73 |
| skill 2, strike 8 | **47** | 163 | 209 | 76 | 9 / 12 / 13 | 0.92 / 0.82 / 0.73 |
| skill 3, control (#58's row: 1, 62) | 1 | 62 | 284 | 49 | 15 / 17 / 19 | 0.73 / 0.62 / 0.42 |
| skill 3, strike 8 | 0 | 79 | 271 | 62 | 14 / 16 / 19 | 0.73 / 0.62 / 0.52 |

- **Skill 1: the targeted strike matches the threshold and keeps the economy.** 167 against topped 30%'s 178 (not separated), but at 0.77 of the AI's economy at year 20 against 0.61: the same win rate, far from the cliff. It spends the economy only where a neighbour is soft. The two do not stack (161).
- **Skill 2: +15 unified (32 → 47), 23 more expanders, 22 fewer invasions,** economy unchanged. The fast quartile's first conquest comes two years sooner; the median does not move.
- **Skill 3: 17 more expanders and a better economy at year 20 (0.52 against 0.42), still no one finishes.** The median first conquest is still year 16. The race is lost by construction where a target's garrison grows faster than the gold can hire: no X exists inside the horizon.
- **Tolerance alone is neutral at skill 1** (154): the control rarely attacks before topping, so the window never binds.

**The safety check, and tolerance by fiefs held.** The planner now returns the soonest strike that `score` itself would pass (`strike_ok`: on today's map with the line's men and gold in hand; the prize within the tolerance, the rest SAFE, the capital's line, the rice shield), so a planned strike is one `best_attack` makes. `--tol EARLY,LATE,N` now keys on fiefs held (EARLY while fewer than N), not years (Chris: losing a fief is fatal only while you hold one). Chris's question: *do the games just take longer, or do we lose more?* Win year is years from the start, quartiles:

| strike 8, 340 games | skill 1 won | win year | invaded | lord died | skill 2 won | win year | invaded | lord died |
|---|---|---|---|---|---|---|---|---|
| control (no planner) | 155 | 21 / 24 / 27 | 163 | 11 | 32 | 28 / 33 / 37 | 231 | 69 |
| planner, no safety check | 167 | 18 / 20 / 25 | 144 | 15 | 47 | 26 / 30 / 34 | 209 | 76 |
| a: + safety check, SAFE | 164 | 18 / 21 / 24 | 147 | 17 | 40 | 25 / 28 / 34 | 211 | 80 |
| b: HUNTABLE at 1 fief | 167 | 19 / 21 / 24 | 150 | 10 | 37 | 28 / 31 / 37 | 212 | 80 |
| c: HUNTABLE at 1-2 fiefs | **179** | 19 / 22 / 25 | 139 | 10 | 38 | 27 / 31 / 35 | 216 | 78 |
| d: COMING at 1 fief | 167 | 19 / 21 / 24 | 150 | 10 | 37 | 28 / 31 / 37 | 212 | 80 |
| e: COMING at 1-2 fiefs | 175 | 18 / 21 / 25 | 142 | 11 | 41 | 28 / 30 / 36 | 212 | 76 |
| f: HUNTABLE always | 172 | 18 / 21 / 25 | 144 | 15 | 34 | 25 / 28 / 32 | 218 | 77 |

- **Neither.** No tolerance setting makes games longer (win years within a year of each other) or loses more (invasions 139-150 at skill 1, 211-218 at skill 2). As Chris had found before: above a minimum, the chance to win barely moves. Skill 1's best, HUNTABLE through the second fief, is +15 over SAFE, at the edge of the noise (about ±10 on paired seeds); skill 2 does not separate at all (34-41).
- **At the first step, COMING and HUNTABLE are the same game** (b = d, row for row, at both skills): the first prize is never left COMING when it is not already HUNTABLE.
- **The safety check costs nothing measurable** (164 vs 167, 40 vs 47, both inside the noise) and removes the class of plan that deadlocked; it stays.
- **Skill 2's losses are the clock and the invasion, not the risk setting**: about 80 lords die of age and the median win is year 28-31. Tolerance does not reach that.

**Why tolerance does not move outcomes: walking one start through the skills** (Chris: *the data shows it does not impact win % or game length, but why? Do we trade a fief over and over because we cannot hold, or are we missing a mechanism? Aggregates do not tell the whole story; tally key metrics so we can dig in*). `long_game` now returns a per-game tally: every real attack (`expand.CONQ`: won, the prize's state right after, fiefs held) and every owned fief lost (checked on each of our turns). Owari (Oda), 50 seeds, 70 years; churn = a conquest lost again within 4 seasons:

| Owari | won | attacks / game | fiefs lost / game | conquests left SAFE (churned) | left HUNTABLE or COMING (churned) | lord died |
|---|---|---|---|---|---|---|
| skill 1, control | 40 | 16.8 | 3.3 | 717 (2%) | 46 (9%) | 2 |
| skill 1, planner | 42 | 16.0 | 2.6 | 701 (1%) | 51 (16%) | 1 |
| skill 1, planner + HUNTABLE to 2 fiefs | 41 | 16.7 | 3.2 | 747 (2%) | 49 (8%) | 2 |
| skill 2, control | 11 | 14.2 | 5.2 | 523 (4%) | 95 (16%) | 16 |
| skill 2, planner | 18 | 15.2 | 5.2 | 566 (3%) | 93 (14%) | 15 |
| skill 2, planner + HUNTABLE to 2 fiefs | 15 | 13.9 | 4.3 | 522 (2%) | 90 (14%) | 22 |
| skill 3, control | 0 | 3.7 | 1.7 | 138 (4%) | 30 (10%) | 30 |
| skill 3, planner | 0 | 3.8 | 1.4 | 129 (1%) | 47 (13%) | 31 |
| skill 3, planner + HUNTABLE to 2 fiefs | 0 | 4.5 | 2.1 | 155 (4%) | 36 (31%) | 35 |

- **Not trading fiefs.** A SAFE conquest is lost again within a year 1-4% of the time; fiefs lost run 1.4-5.2 a game against 4-17 attacks.
- **The dial covers one or two attacks a game.** About 45 conquests in 50 games leave the player holding 2 fiefs and 50 holding 3; everything after (500-700) is at 4 or more, where "to 2 fiefs" has expired. The risky window is the opening step, a small share of a game's decisions.
- **The missing mechanism: the battle sets its own tolerance.** Conquests end HUNTABLE or COMING under every setting, the SAFE-only control included: 6% of them at skill 1, 15% at skill 2, 18% at skill 3, and those churn 8-31%. `score` forecasts the survivors from the keep table's mean; the battle map has a long low tail. Traced (Owari, skill 2, seed 3012): Mino → Omi 1580, 280 men against 112 (2.5×), forecast 142 survivors and SAFE, the battle left **55** and COMING, and the fief was gone the next season. The same game in 1572: 115 forecast, 111 left, HUNTABLE (a line-edge case). The dial being tuned is smaller than the risk the battle hands out uncontrolled, and the share rises with skill as the keep falls (#58's battle lab: 0.42 at 2.5× on skill 2, 0.19 on skill 3).
- **Skill 3 is not a risk problem.** 4 attacks a game against 16 at skill 1, and the lord dies of age in 30-35 of 50. The tempo wall again.

**Sizing for a bad battle: it fixes the churn and costs the tempo.** `skill_lab --quantiles --out keep_q.json` (30 seeds × 7 pairs, every won battle's kept share; the means reproduce #58's). Kept per man sent, q10 / q25 / median:

| ratio | skill 1 | skill 2 | skill 3 |
|---|---|---|---|
| 2.0× | 0.24 / 0.37 / 0.44 | 0.10 / 0.11 / 0.15 | 0.05 / 0.12 / 0.19 |
| 2.5× | 0.38 / 0.50 / 0.52 | 0.23 / 0.31 / 0.42 | 0.09 / 0.13 / 0.20 |
| 3.0× | 0.47 / 0.57 / 0.68 | 0.35 / 0.47 / 0.51 | 0.22 / 0.33 / 0.40 |
| 4.0× | 0.59 / 0.68 / 0.71 | 0.50 / 0.60 / 0.70 | 0.40 / 0.51 / 0.60 |

The old forecast was wrong twice at skill 2: the tail is wide, and even its mean was high (it divides the ratio by the skill scale and reads the skill-1 table: 0.51 at 2.5×, against a measured 0.41). `expand.KEEP_Q = q` (`long_game --keep-q`, off) prices the survivors, in `score`'s forecast and the planner's hold, at the lab's q-quantile for the game's skill. Every start, strike 8, SAFE:

| 340 games | won | expanded | invaded | first conquest | attacks / game | fiefs lost / game | conquests left non-SAFE | of those, lost within a year |
|---|---|---|---|---|---|---|---|---|
| skill 1, mean (as before) | 164 | 215 | 147 | 6 / 8 / 10 | 10.5 | 2.3 | 253 of 3310 (8%) | 13% |
| skill 1, median | 164 | 217 | 153 | 6 / 8 / 10 | 10.4 | 2.2 | 174 (5%) | 12% |
| skill 1, q25 | 175 | 216 | 141 | 6 / 8 / 10 | 10.0 | 1.4 | 111 (3%) | 8% |
| skill 1, q10 | 166 | 214 | 156 | 7 / 9 / 10 | 9.5 | 1.6 | 54 (2%) | 7% |
| skill 2, mean (as before) | **40** | 162 | 211 | 9 / 12 / 13 | 7.1 | 2.6 | 293 of 2069 (14%) | 15% |
| skill 2, median | 24 | 146 | 232 | 11 / 12 / 13 | 5.8 | 2.3 | 162 (9%) | 14% |
| skill 2, q25 | 30 | 144 | 234 | 11 / 12 / 13 | 5.4 | 1.8 | 79 (5%) | 11% |
| skill 2, q10 | 37 | 143 | 224 | 11 / 12 / 13 | 5.0 | 1.5 | 22 (1%) | 9% |

- **The mechanism is real and the fix works on it**: non-SAFE conquests fall 8% → 2% at skill 1 and 14% → 1% at skill 2; fiefs lost fall by about 40%.
- **Win rate does not follow.** Skill 1 does not separate (164-175). At skill 2 every honest pricing loses (24-37 against 40): the first conquest moves from year 9 to 11 in the fast quartile, 16-19 fewer starts ever expand, and 13-23 more are invaded. An attack sized to hold through a bad battle is one the opening cannot afford yet.
- **So the optimistic forecast was a risk tolerance, and a good one.** Chris's reading, measured: a low-odds conquest still pays, because a fief lost a year later costs the rebalancing of everyone around it too, while a year of waiting costs tempo the opponents use to grow. Across #61 one quantity tracks the outcome: when the first conquest comes earlier (topped down to 30%, the planner), the win rate rises; when it comes later (topped 0%, banking, honest sizing), it falls. Holding what you take is second-order while the opening is open. `KEEP_Q` stays off; the table stays as the instrument.

**The tempo reading, tested: it is a deadline, and missing it leads to a mid-game stall** (first written as "the deadline is the lord's life"; corrected below). Every #61 run (25 configs × 340 games at skill 1, 12 at skill 2; the same starts and seeds), three cuts, each controlling more:

- **Pooled, P(win | first conquest year), skill 1:** ≤5 years 74%, 6-7 77%, 8-9 76%, 10-12 72%, **13-16 44%, 17+ 24%**, never 0% (3,158 of 8,500 games never expand). Flat, then a cliff.
- **Within each start** (first conquest at or before that start's median vs after): skill 1, 76% vs 65%, early ahead on 12 of 15 starts; skill 2, 27% vs 15%, 10 of 12.
- **Paired** (the same start and seed under two configs whose first conquests differ by 2+ years):

| | pairs | earlier won | later won |
|---|---|---|---|
| skill 1, both by year 12 | 20,996 | 75% | 76% |
| skill 1, the later one after year 12 | 8,352 | 72% | **34%** |
| skill 1, both after 12 | 610 | 49% | 15% |
| skill 2, both by year 12 | 1,710 | 29% | 34% |
| skill 2, the later one after year 12 | 1,537 | 22% | **13%** |
| skill 2, both after 12 | 177 | 16% | 2% |

**Earlier buys nothing before about year 12 (at skill 2 rushing costs a little); missing it halves the win rate or worse.** How the expanders lose:

| | games | won | lord died | invaded | losers' median peak / end year |
|---|---|---|---|---|---|
| skill 1, first conquest by year 12 | 4,807 | 75% | 8% | 15% | 10 fiefs / year 28 |
| skill 1, after year 12 | 535 | 35% | **38%** | 20% | 7 / 37 |
| skill 2, by year 12 | 1,353 | 28% | **43%** | 27% | 9 / 35 |
| skill 2, after year 12 | 546 | 12% | 59% | 27% | 9 / 37 |

Invasion barely moves; the lord dying of age is what a late opening buys (8% → 38% at skill 1), and at skill 2 even punctual expanders die of age 43% of the time.

**Age ends those games; it does not decide them (Chris: age is a hard cap, but it cannot force an earlier start. The cliff caps how early anyone can strike, and if a 41-year-old can start early, so can a 20-year-old. A time clock might justify more risk, but we already know the minimum).** Checked: these are old-age deaths (`natural_death`: health 0, or the roll from age 70; starting health is 65-109 and falls about 1.35 a year with the capital's plague, so health never runs out first; Fief 5, starting at age 20, dies in years 51-54). Across every #61 run, **1,390 of the 1,417 expanders lost to the lord's death were 69 or older** at their last yearly row. The 27 earlier deaths are health reaching 0 (Chris asked about AI ninjas and sickness: Appendix D has the AI's ninja sweep as economic harassment whose rare all-miss fallback chips the daimyo's Charisma or Health by rng(0-4), and illness flags the lord weak without taking health, so those, and the capital's plague, are the candidates for the 2%). Mind the trap: "lord died" is also logged for 3,224 *winners* (after unification the yearly rows stop and the reader plays on until the lord dies), so cut by won first. Young lords die of age too (skill 2: 33% of age-15 expanders, 51% of age-20), so these are games that ran 40-50 years without finishing. The expanders lost to the lord's death:

| | games | peak, reached in | held at death | rivals left | death year |
|---|---|---|---|---|---|
| skill 1 | 604 | 9 fiefs, year 29 | 7 of 17 | 3 | 40 |
| skill 2 | 905 | 9 fiefs, year 32 | 7 of 17 | 4 | 40 |

They reach half the map, stall against three or four consolidated rivals, slide back, and the clock ends it. The year-12 deadline predicts who stalls (a late opening meets bigger rivals); it is not a lifespan race, so the opening's policy stays "as early as the economy floor allows" at every age. What is missing is the mid-game: the expander attacks one fief from one fief, and that stops working against a few large neighbours. This is the original complaint (*the opponents grow faster than us, so we stagnate*), placed: it is the mid-game, not the opening.

**Open (next session): the mid-game war against consolidated rivals,** measured on the stalled games (peak about 9 fiefs, 3-4 rivals left). Chris: two kinds of combined attack. **(1) Several fiefs on the same turn**: the order in which fiefs act within a season matters. **(2) The same fief over several years**: you need not win on the first try, but the enemy may recover faster than you. A time-clock risk dial only after that; size by quantile only after the opening (the late game, where Chris expects holding to matter); count the targets with no X at skill 3 (how often the race is lost before it starts); and the general fix for skill 3, raising our side of the race: men from several fiefs into one attack, the multi-turn war (#59), the back-line economy (#60).

### #60 — The pocket planner: the map has pockets, the greedy expander already finds them, and the opening is the wall (Chris, 2026-11-16)

Chris: a planner that looks far enough ahead to see whether conquest can make **pockets** of fiefs with no enemy neighbour, so the army can focus on one front (#59's open thread).

**The map, read statically** (`py -3.14 -m na1sim.pockets table | walks | trace`). Every start can reach back line, but it takes 3-5 conquests. Best case is the Kinki corner: Settsu, Yamato, Yamashiro, Iga, then Omi or Iseshima gives 4 interior fiefs behind a 2-fief front facing 3 rivals. Noto/Kaga and the east get there in 4-5. The adjacency matrix A has no zero entry from **A⁵** (the diameter is 5; triangles such as Mino-Omi-Iseshima make the map non-bipartite). Its row sums and its top eigenvector (λ ≈ 4.59) rank exposure: Mino 1.00 and Shinano 0.88 at the top, Settsu 0.15 and Noto 0.13 at the bottom. The unique 5-walk Noto ↔ Settsu is the one 1 in A⁵.

**Chris's correction: hubs are strong owned, weak alone.** Holding Kaga, Shinano and Echigo, then taking Musashi, Suruga, Mikawa and Noto, adds a back fief with every conquest while the front stays at 3 fiefs (Kaga, Shinano, Mikawa) and the enemies faced fall from 7 to 4. It works because `share_line` charges a fief the men for its **largest** enemy neighbour, not the sum: a hub facing three rivals pays one garrison and covers the borders of everything behind it. Degree is a liability for a one-fief start (the opening) and an asset inside an empire. Centrality ranks how hard a fief is to hold alone, not what it is worth to own.

**The planner** (`expand.POCKET`, off; `long_game --pocket N`). Each season it lists every connected empire within N conquests and prices each in men per back-line fief gained: the men to take it (`fought_need`, skill-aware) plus the change in the army bill, over the interior fiefs gained. The cheapest is the goal, sticky unless a new one is 25% cheaper (`POCKET_KEEP`). `best_attack` attacks only goal fiefs (`--pocket-strict 0`: the greedy pick while none is ready), and `campaign` stages toward it. `--line` forces an opening line (nothing else is attacked until it is done or broken). `long_game` now sets `POCKET` on every job: the process pool reuses workers, so a setting could leak between jobs (no earlier run was affected).

**Skill 3** (340 games, 20 seeds, 70 years, all with gate hire; the control reproduces #59's row exactly):

| | expanded | peak ≥ 10 | unified | economy, yours / AI's per fief, years 5 / 10 / 20 |
|---|---|---|---|---|
| gate hire (#59) | 116 | 10 | 0 | 0.58 / 0.51 / 0.37 |
| + pocket 4, strict | 109 | 6 | 1 | 0.58 / 0.51 / 0.34 |
| + pocket 4, greedy fallback | 116 | 14 | 1 | 0.58 / 0.51 / 0.36 |
| + pocket 4 + staging | 109 | 9 | 0 | 0.58 / 0.51 / 0.34 |

Neutral, because there is nothing to plan with: **only 4 of 340 games hold a second fief by year 10**, the median first conquest is year 19 (quartiles 17 / 19 / 23), and no game has an interior fief before year 20. The one-fief player sits under its own army bill until about year 13 (median men vs bill: 96 / 116 at year 3, 120 / 165 at year 9, 162 / 199 at year 12) while the AI's garrisons grow. Opening lines raced from Echigo, Shinano and Kaga (60 seeds) change nothing before the first conquest (year 17-24 in every line); Honganji is dead whatever the line (1 of 60 alive at year 6).

**Skill 2, where the first conquest comes at year 13** (`pockets race 2`). On seeds 3000-3059, Chris's trio line Echigo → Kaga → Shinano led with 11 unified against greedy's 6. **On 200 fresh seeds (3060-3259) it did not hold:**

| Echigo, unless noted | peak ≥ 10 | unified | back line at year 30 | invasion deaths |
|---|---|---|---|---|
| greedy | 87 | 48 | 3.9 | 83 |
| pocket planner | 89 | 46 | 4.0 | 83 |
| Shinano only | 85 | 50 | 3.4 | 84 |
| Kaga → Shinano | 82 | 39 | 3.6 | 103 |
| Shinano → Kaga (hub first) | 75 | 38 | 2.9 | 97 |
| Shinano start, greedy | 53 | 16 | 2.3 | 59 |
| Shinano start, pocket planner | 58 | 17 | 2.8 | 64 |

- **The planner ties the greedy expander** (46 vs 48, 17 vs 16). The greedy expander was never blind to shape: `score` ranks a move by the interior fiefs it creates first, and `LOOKAHEAD` adds a second conquest priced by the army bill. On a 17-fief map with diameter 5, 1-2 conquests of shape plus "attack whatever is ready and SAFE" catch what 4 conquests do.
- **A forced two-step line costs about 10 unifications in 200,** mostly through invasion: waiting on one target while the neighbours grow. Hub first was worst in both samples (Chris doubted "hub first" too), but weakly against the noise; at about 50 unified in 200, lines within ±10 are not separated.

So the planner's horizon is not the bottleneck. What separates outcomes is tempo: being able to strike as soon as something is takeable. At skill 3 that is the one-fief opening, the same wall as #58-#59.

**Open:** the opening tempo (what lets a one-fief player strike before year ~10 at skills 2-3: hire to the attack and accept being huntable for a few seasons?); the multi-fief, multi-turn late war (#59).

### #59 — Gate hire at skill 3: it saves openings and costs the economy, and the economy is the wall (Chris, 2026-11-13)

Chris: hire before the economy tops out, but *top-out is probably too long, and ASAP might be too short*; and *be conscious that our economy does not stall: if your economy recovers slower than your enemy, this stalls too*. (On the late war's gold: a capped fief cannot even be sent gold, so the answer is attacking from several fiefs or over several turns; you do not have to win on the first try. Not built yet.)

**The rule** (`expand.GATE_HIRE`, off by default; `long_game --gate-hire 1`): a fief that is not topped and is under its gate line (`own_need`: the share line with margin, the capital's line) hires toward that line with at most `ARMY_SHARE` (half) of its gold, and otherwise develops as before. The attack army still waits for the topped economy. **The instrument:** `long_game`'s yearly rows now carry Chris's Economic Index, ∛(town·output·wealth), per own fief and per AI fief.

| 340 games (every start, 20 seeds, 70 years) | alive at 6 | expanded | peak ≥ 10 | unified | men at year 8 | economy, yours / AI's per fief, years 5 / 10 / 20 |
|---|---|---|---|---|---|---|
| skill 1, the #48 player | 216 | 205 | 184 | 155 | 291 | 1.10 / 0.86 / 0.76 |
| skill 3, skill-aware attacks (#58) | 133 | 62 | 4 | 1 | 78 | 0.71 / 0.59 / 0.46 |
| skill 3 + gate hire | **172** | **116** | 10 | 0 | 109 | 0.58 / 0.51 / **0.37** |
| skill 3 + gate hire, topped at 70% | 172 | 116 | 4 | 0 | 109 | 0.58 / 0.51 / 0.34 |

- **Gate hire saves 39 openings** and nearly doubles expansion. It runs before the reader's fallback, so it does reach the opening (#58's "none of these knobs reach it" was true of the attack and topping knobs only).
- **It costs the economy**, as Chris warned: by year 20 your fiefs are at 0.37 of the AI's, from 0.46. The gold that holds the gates did not develop.
- **The economy is the wall at skill 3.** Without gate hire you start at 0.71 of the AI's per fief and slide to 0.46; at skill 1 you start ahead (1.10) and drift to 0.76. Every develop gain is × (6 − skill) on the player's √ curve (`$8814`-`$89EE`), and the AI's cascade does not pay it. Neither topping earlier nor holding the gates sooner can close a gap that opens from year 5.

The skill-1 control reproduces 155 exactly. (Checked: the AI's town and output grow through `effect_send` at $B3FB / $B4B7, a clamped one-for-one transfer of surplus gold with no √ and no skill term.)

**The skill wall (Chris).** *The game relies on human advantages to carry logical play.* The skill dial removes them one by one: your units' battle strength 100% → 70% ($9CF4), the morale hit per exchange 5 vs 1 → 3 vs 3 ($9FEE), your develop multiplier ×5 → ×3, the AI's stats +5 → +15 ($83E2). At skill 1 those edges carry a greedy expander to unification in about half the games; at skill 3 they are gone. Grant is no way round: the AI's develop path is the AI's alone, and the Grant states are a few fixed choices. **The greedy expander has met its limits.** What is left is shape: targeted expansion that turns your own fiefs into back line (no enemy neighbour, no army, all the gold into the economy), so a few interior fiefs out-develop the AI 2:1 even on the cut curve. `army_bill` already prices a back-line fief at 0, but `best_attack` picks by what is winnable now, not by what it makes interior; the planner (`expand.PLANNER`, neutral at skill 1 where the game is saturated) is the natural home for that objective, untried at skill 3. Then the multi-fief, multi-turn attack for the late war.

### #58 — Skill 3, the predictors checked: the attack odds were skill-blind, and the hire rule waits a decade (Chris, 2026-11-13)

Chris: look whether any gates change at skill 3 (*they should still move*), whether the predictors miss something that can be avoided, and whether the attack choice can be tuned so the game does not stall.

**Every `skill_level` read in the ROM**, against the sim. About 25 sites; the battle engine (`tactical.py`) and the AI (VM) carry them all. The ones that move expansion:
- **`$9CF4`: every human unit's battle strength × (115 − 15·skill)%** (AI units 100%): 100, 85, 70, 55, 40% at skills 1-5. The largest, and the one the predictor missed.
- `$9FEE`, the morale hit per exchange: a human side 6 − skill, an AI side skill (5 vs 1 at skill 1, 3 vs 3 at skill 3).
- Develop gains × (6 − skill) (`$8814`-`$89EE`, `$D8E9`): your economy builds at 3/5 of the skill-1 rate. The AI recruits on (skill + 3)/10 of turns (`$B519`), 60% at skill 3.
- **The gates do not move against you.** The AI's commit (`$9505`) is ratio − 10 − rng(3·skill) > 60 (higher skill, slightly *less* eager) and the pick line (`$952E`) is a men share over 47 with no skill term, as `reaction.GRUDGE` has it. "Past its gates" means the same at every skill.

**The miss: the expander's attack odds.** It prices a fought attack as a win at `CHARGE_NEED` 2.0× the defender's men ("~90%") and keeps `CHARGE_KEEP` of the men, from #48's replays at skill 1. `na1sim.skill_lab` fights the same attacks (7 attacker/target pairs, 20 seeds, the doctrine's Assign and charge) at each skill:

| ratio | skill 1 win / kept | skill 2 | skill 3 |
|---|---|---|---|
| 1.5× | 44% / .18 | 4% / .08 | 0% |
| **2.0×** | **100%** / .44 | 76% / .18 | **21%** / .20 |
| 2.5× | 100% / .53 | 100% / .42 | 97% / .19 |
| 3.0× | 100% / .66 | 100% / .51 | 100% / .42 |
| 4.0× | 100% / .72 | 100% / .68 | 100% / .58 |

At skill 3 the expander attacked at 2.0× believing 90% and lost four in five. **Fix** (`expand.SKILL_AWARE`, on; a no-op at skill 1): the need × 100/(115 − 15·skill), from the ROM site, not a fit (2.0, 2.35, 2.86×), and the keep read at the effective ratio. It moved little: 1 of 340 unified (Asai), 286 attacks instead of 352, 62 expanded instead of 63.

**The stall: the hire rule.** The survivors' armies sit at 74-78 men for 8-10 years while the men their gates need climb from about 100 to 200+. The expander buys men only once a fief is topped ((wealth + loyalty)/2 ≥ header, `expand.capped`), and at 3/5 the gift gain that takes about a decade. Topping earlier (`--topped`):

| skill 3, 340 games | expanded | peak ≥ 10 fiefs | attacks | median men at year 8 | unified |
|---|---|---|---|---|---|
| skill-aware, topped 100% | 62 | 4 | 286 | 78 | 1 |
| topped 70% | 74 | 10 | 467 | 78 | 0 |
| topped 50% | 85 | 7 | 428 | 168 | 0 |

More expand and the armies double, but no one finishes: the lords still die of age (33-56 years) part way. **Alive at 3 and 6 years is 173 and 133 in all four runs:** the opening (the reader's policy) decides every early death and none of these knobs reach it, so the five weak starts stay at zero.

**Open:** an opening tuned for skill 3 (it was tuned at skill 1, #45-#47); a skill-aware hire rule (buy men by the gate's need, not by a topped economy); and the late war's gold, since War costs a gold per man sent and 2.86× the AI's year-20 garrisons is more gold than a fief holds. Defence costs more too (your garrison fights at 70%), but the gates keep you from being picked, so that is the ev odds table's problem (`odds_f8.json`, measured at skill 1), not the expander's.

### #57 — Skill 3, where assassination stops working: the game is playable, but no one finishes it (Chris, 2026-11-13)

Chris: skill 3 is where assassinate does not work (#56: the chain collapses to at most 5 fiefs). *Can one actually play the game at this point, or has the difficulty spiked so nothing is possible?* And Saito's ev player, which he guessed is dead at this level.

**Setup.** `long_game` gained `--skill` and `--ev` (#48's tuned weak-start opening as `expand.BASE`: the ev player with riots priced while holding one fief, then the reader; it had not been committed). Checked first at skill 1 on Saito, 300 seeds, 40 years: ev 11 unified, alive 27 / 24 at 3 / 6 years, 22 expanded; reader 5, 17 / 16, 13. #48 had 13, 29 / 27, 23 and 6, 16 / 15, 12, so the setup reproduces. The #48 player is not retuned for skill 3.

**Every start, skill 3** (20 seeds, 3000-3019, 70 years, all battles fought, merchant rolled; skill 1 on the same seeds: 155 of 340 unified):

| | skill 1 | skill 3 |
|---|---|---|
| never hold a second fief | 137* | 277 |
| expanded | 203* | 63 |
| unified | 155 (#53, these seeds and settings) | **0** |

\* from #48's planner study on 340 games, a different run (186 of its 203 expanders unified); not rerun here.

- **Playable, not winnable.** Half the starts are alive at year 3 (173 of 340) and 133 at year 6. Miyoshi (20 / 17), Oda (18 / 17), Kitabatake, Takeda and Asai survive the opening as well as at skill 1. But 49 of the 63 expanders end with **the lord dying of age** (years 33-56), holding a median of 4 fiefs. The best reached 16 of 17 (Asai, seed 3000, invaded at year 48), then 12, 11 and 10. The difficulty does not shut the game; it slows conquest until the clock (the lord's life) runs out.
- **The weak starts are gone.** Hatakeyama, Honganji, Saito, Tsutsui and Rokkaku: 0 alive at year 3 in 100 games.
- **Saito with the ev opening, skill 3** (300 seeds, 40 years): 7 alive at 3 years, 5 at 6, **none expands**; invasion 273, revolt 27. Chris guessed it: dead.

Read with #56: skill 1 is where the exploit takes the map and the honest player unifies in about half the games; skill 3 is where neither works and the strong starts can only hold on. A retuned player (earlier attacks, a faster economy) is the open question: whether the limit at skill 3 is the policy or the game.

### #56 — The assassinate-and-buy chain: who sits nearest the vulnerable fiefs (Chris, 2026-11-13)

Chris: *if you win the fief, you can then chain it to another connected fief, so it is about finding all the vulnerable ones, and who sits near them, more than actual play.* A static read of the map (`py -3.14 -m na1sim.chain`), not a game. The AI's own wars are left out, so this is the upper bound of the pure line.

**The rules it chains:** the kill is not limited by the map ("Send where" takes any fief), but the purchase is: only the owners bordering a dead fief bid, and with fewer than two of them a new lord is seated (#55). Each fief you hold gets its own command every season, and the ninja carries your lord's stats from any of them, so every fief bought is another assassin next season. Order matters: a fief must be bought while someone else still borders it. Noto borders only Kaga, so only a Noto start can ever buy it. The chain buys what is about to close first, then the bigger garrison, and never kills what it cannot buy.

**Results** (killable = a certain kill on the first try, Luck gate open at its mean):
- **Perfect roll (109/109/109), skill 1:** from Echigo, Mikawa or Shinano, **11 of 17 fiefs and 577 men in 5-6 seasons** (about 18 gold of ninjas plus the bids). The best starts are the three lords no roll can kill. Playing one of them removes an untouchable rival, and the other two, Miyoshi (79%), Anekoji (15%) and Noto are all that is left. Every central start (Owari, Settsu, Hida, Noto) reaches 9 fiefs, the rest 8. Musashi and Suruga are boxed in by Uesugi and Takeda and reach 2.
- **Skill 2, the same roll:** at most **5 fiefs** (Omi or Iseshima: Yamashiro, Iga, Yamato, Mino). Most starts reach 1-3. Skill 3 is the same shape. The +5·skill on the AI's Cha and IQ is what breaks the chain.
- **A 95s roll at skill 1, kill at ≥ 90%:** 8 fiefs from Echizen, Hida or Shinano in 3-5 seasons.

So the exploit is a skill-1 game: roll high, sit next to the soft middle (Mino, Omi, Iseshima, Yamato, Yamashiro, Iga, Echizen, Kaga, Saito's and Asai's lands), and in about a year and a half own two thirds of the map, garrisons included, without a battle. Chris: *out of the spirit of good play*. This is a map of the exploit, not a policy for the player.

### #55 — Assassination priced: three fixed gates and one Charisma roll, and a landed hit always kills (Chris, 2026-11-13)

Chris: assassination is the one that is OP and decides games on a die roll; price it as expected cost by circumstance (sometimes too dear, sometimes impossible). The last of the unused verbs (#49-#54).

**The rules** (`effect_ninja_sabotage` $A2D2 → `ninja_mission_resolve_vs_defender` $918D), in order:
1. The target fief must be a daimyo's **capital** ($A349: else "The daimyo is out", nothing spent) and run by the AI ($9192: `ai_state` 0, so a human's fiefs are immune; the AI never assassinates anyway, #1).
2. **Luck gate** ($A36C): target Luck < your Luck + 30. A fixed compare, as in #50.
3. **Contest** ($91A2): target Cha + IQ ≤ your Cha + IQ. Also fixed.
4. **Counterattack** ($91D5): target Cha − rng(10·skill) > your Cha − rng(10·skill). Your lord loses rng(health/2)+1 health and 1 Charisma. The target is untouched.
5. Otherwise the hit lands and **kills**. At $9293 the test is `230 > health` (`cmp_sgt` is regA > regB, ch.8), so any landed hit that is not a counter sets health to 0, and `find_fiefs_of_owner` empties the faction. The `rng(health)+1` deduction before it only matters on a counter.
- The empty-fief defensive roll ($9213, men ≤ rng(10)+1) blocks only if rng(Luck/100) ≠ 0, which needs Luck ≥ 200. It never blocks, so **the ninja count never matters**: one ninja does it, at (rate + 9)/10 gold, 1-2 in 1560. A failure at gate 2 or 3 costs 1 Charisma, as in #50.

**The cost of a success, every variable** (`na1sim.assassin.cost_of_success`). Inputs: your Cha *C*, IQ *I*, Luck *L*, health *H*; the target's Cha *c*, IQ *i*, Luck *l* (ROM table + 5·skill, below); the difficulty *s*; the year *y*.

- **Gates** (no die): *l* < *L* + 30, and *c* + *i* ≤ *C* + *I*. Shut, and every try costs a try's gold and 1 Cha for nothing.
- **Kill chance per try:** *p* = 1 − *P*<sub>counter</sub>, with *n* = 10·*s* and *d* = *C* − *c*:

  | *d* | *P*<sub>counter</sub> |
  |---|---|
  | *d* ≥ *n* − 1 | 0 (a certain kill) |
  | 0 ≤ *d* < *n* − 1 | (*n* − *d* − 1)(*n* − *d*) / 2*n*² |
  | −*n* < *d* < 0 | 1 − (*n* + *d*)(*n* + *d* + 1) / 2*n*² |
  | *d* ≤ −*n* | 1 (never) |

  (Checked against enumeration for skills 1-5 and every *d*.) At equal Charisma the kill is (*n* + 1)/2*n*: 55% at skill 1, 52.5% at 2, 51.7% at 3. Each point of Charisma moves it most near *d* = 0, and a lead of *n* − 1 makes it certain.
- **What a try costs:** one season command, and one ninja's gold, (rate + 9) // 10 with rate = (rng(101) + 10(*y* − 1560) + 4) // 4: on average 1.8 gold in 1560, 3.0 in 1565, 4.2 in 1570, 6.8 in 1580, 9.2 in 1590.
- **What a counter costs** (probability 1 − *p*): rng(*H*/2) + 1 of your lord's health, on average (*H*//2 + 1)/2, about 23 for *H* = 90, and 1 Charisma. The lost point lowers *d* for the next try and can shut the contest (*C* + *I* − 1 < *c* + *i*).
- **The campaign** (try each season until the kill or the contest shuts): P(kill ever), expected tries, gold, health and Charisma lost follow from the recursion on (*C*, *H*). Without the Charisma loss it would be geometric: 1/*p* tries, (1 − *p*)/*p* counters.

Examples (your 109/109, health 90, skill 2, 1560): Saito, Hatakeyama, Honganji 1 try, 1.8 gold, nothing lost; Hojo 1.1 tries, 2 gold, 2 health; Miyoshi 43% a try, 96% ever, 3 tries, 5.4 gold, 26 health, 2 Cha; Anekoji 14% a try, 23% ever (the contest shuts after about two counters), 33 health. At 90/90, skill 3, 1570: Honganji 36% a try, 88% ever, 11.5 gold and 28 health; nine lords shut.

**This overturns #1's "attrition, about two hits"**: there is no attrition. Checked in the cartridge (`tools/na1_play.py`, Oda 1560, the player's stats written into his record, one ninja, mission 4, seeded at the mission prompt):

| case | prediction | cartridge |
|---|---|---|
| you 109/109 vs Saito (Cha 36, skill 1), a counter impossible | kill every time, in one hit | 30/30 dead, health 101 → 0, "Fief 9 lost its leader" |
| you Cha 36 vs Saito, d = 0 | 55% kill | 14/30 kill, 16 counter (your health −2..−30, Cha −1, Saito untouched) |
| you 109/109 vs Miyoshi (Cha 112), skill 2 | 38% kill | 27/60 (z ≈ 1.1) |
| you 109/109 vs Anekoji (Cha 115), skill 1 | 10% kill | 0/20 (P = 12%), all counters |
| you 68+64 = 132 vs Saito 36+97 = 133 | contest lost | 20/20 "Your ninja failed", Cha −1, 1 gold |
| you 218 vs Uesugi 235 | contest lost | 20/20 failed |

**The AI's lords are stronger than `17Diamyo.txt` by 5·skill.** In the cartridge their health, Drive, Luck, Charisma and IQ are the ROM table ($D5xx, which the file matches) + 5 at skill 1, + 15 at 3, + 25 at 5 (`apply_scenario_starting_stat_boosts` $83E2, AI fiefs only; the sim already runs it on the VM). Luck then drifts rng(11) − 5 every season (`drift_daimyo_luck` $A2ED). The player's lord gets no boost: each of his five stats is rolled rng(50)+60, re-rollable without limit ($85FC).

**The price by circumstance** (`py -3.14 -m na1sim.assassin`; your Cha/IQ/Luck as rolled, AI at ROM + 5·skill, Oda left out):

| you (Cha/IQ/Luck) | skill | contest lost | certain (100% first try) | a die roll |
|---|---|---|---|---|
| 109/109/109 | 1 | Uesugi, Tokugawa, Takeda | 12 lords | Miyoshi 79%, Anekoji 15% |
| 109/109/109 | 2 | Uesugi, Tokugawa, Takeda | 8 | Hojo, Imagawa 91%, Asakura 98%, Kitabatake 96%, Miyoshi 43%, Anekoji 14% |
| 109/109/109 | 3 | + Hojo, Anekoji | 6 | Honganji 87%, Asai 85%, Asakura 79%, Kitabatake 77%, Imagawa 69%, Miyoshi 31% |
| 95/95/95 | 1 | 8 lords | 6 | Kitabatake 90%, Imagawa 72% |
| 85/85/85 | 2 | 10 lords | 4 (Hatakeyama, Saito, Tsutsui, Ashikaga) | Rokkaku 98%, Honganji 30% |

- **The cost is one command and a gold or two.** No men, no rice, no risk to your fief. The only real price is in a counter: your lord's health (rng(health/2)+1, which raises his death roll, `rng(300) < age − 10 − health/4`) and a Charisma point, which can close the contest for the next try.
- **"Impossible" is the contest, and the roll screen decides it.** Uesugi, Tokugawa and Takeda carry Cha + IQ of 233-245 at skill 1, above any roll (218 at most), so they can never be assassinated. Everyone else is reachable by a lord who re-rolls for Cha + IQ, and against most of them it is not a die roll at all: when your Cha is 10·skill or more above theirs, the counter is impossible and the kill is certain.
- **Difficulty is the armour.** Every skill level adds 5 to the AI's Charisma and IQ and widens the counter roll, so the list of certain kills shrinks from 12 (skill 1) to 6 (skill 3) for a perfect roll, and to 4 by skill 2 for an 85s lord.
- **What a kill buys:** every fief of the faction, **army intact**. `neutralize_fief` $E459 sets `ai_state` 255, clears the capital flag, resets tax to 20 and the arms record, and leaves the fief record (men, rice, gold, town, dams) untouched. At the next period each is auctioned to its neighbours (`auction_ownerless_fief_to_bidders` $8C75; appendix-formulas §10). An AI bids only if its gold beats the current bid, and then rng(its gold), which can be 0; the winner pays the last bid made. So when the neighbours are broke a fief with its garrison goes for 1 gold. Fewer than two neighbouring owners, or no bid, and a new lord is seated instead. Chris: *for almost nothing you get an entire fief with the army intact*. This is the TAS and speedrun line: start among weak lords, roll high, assassinate, and buy their land early. He reads it as an exploit of known mechanics, outside the spirit of good play: the battle that should price that army never happens.

**Verdict (Chris):** *yup, OP*. Not in the player: he is not comfortable playing with it. The formula above is what he wanted priced. Left open, as a curiosity: how fast a game goes with it (the #48 player with an assassinate-first policy on `long_game`; the sim has no assassination verb, and its `natural_death` empties fiefs without the auction). Caveat: the Luck column assumes the gate at its mean; with the ±5 seasonal drift a lord within 10 of your Luck + 30 is open some seasons and shut in others.

### #54 — Loans priced: an advance on the next harvest, and the turn it costs is the price (Chris, 2026-11-13)

Chris: *the same investment problem any CAPM planner would do: is the rate of growth from the extra gold higher than the interest?* And: *the √ is the killer here again.*

**The rules** (bank 1): `effect_loan` $9F04 refuses with the treasury full (gold ≥ header) or debt at the town; the most it lends is min((town − debt)·10/(loan_rate + 10), header − gold). `effect_take_loan` $8B40 adds ⌈(loan_rate + 10)·N/10⌉ to debt, a **one-time fee of 10-100%** (loan_rate rolled 1-10 a year, nudged +2 per loan; no running interest). The harvest (`$A2C5`) takes **all the gold up to the debt before the upkeep**. It is a Trade service, so it needs the merchant (#53). At the most it lends, the debt lands at about the town whatever the rate; a bad rate only lends less against it. On the opening boards (skill 1, seed 3000): 15-75 gold, 12-62 men at that year's 1.2 gold.

**As an investment** (the opening board, borrow the most and give it to the peasants, the first Fall's extra harvest at rice 1.8): 6-10× the fee at rate 1, about 1× at rate 10, before two corrections that both cut it. (1) The √: a gift's gain is amount·(6 − skill)/√((stat + partner)/2 + amount), so borrowed gold added to one's own lands at the top of the curve (Hatakeyama: his 43 gold about 0.6 a point a gold, the loan's 27 on top about 0.37). (2) The timing: the Summer marks are copied before the Summer command (below), so only a Spring gift pays this Fall; the opening's loan takes Spring, its gift lands in Summer and pays a year later, while the debt is collected at the first Fall.

**As men** (`policy.take_loan` and the opening steps `loan` / `loan_cheap`, merchant rolled; `deaths`, skill 1, 300 seeds, the reader tail with the #48 flags, alive at year 3):

| start | best opening | loan first | loan at rate 1-3 only |
|---|---|---|---|
| Hatakeyama (hire, tax, rice → peasants) | 48.3% | 8.0% | 13.3% |
| Rokkaku (hire) | 1.0% | 0.0% | |
| Saito (hire) | 1.0% | 2.0% | |
| Tsutsui (hire) | 11.0% | 7.3% | |
| Honganji (hire) | 14.0% | 9.7% | |

Hatakeyama, separated: a wasted Spring (train, then the opening) 17.0%, so the command is most of it (the hire lands after Honganji's Spring); a Summer loan 11.0%, worse than wasting the turn, because the tax moves back and the first Fall collects the debt from all his gold before the upkeep of the army he just hired; a Fall loan 46.0%, neutral, its debt due a year later. **Verdict:** not in the player. The return beats the fee on paper; the turn, the √ and the first-Fall collection take it back. Rokkaku stays moveless.

Also: `policy.OPENING` had no `shield_rice` default, so `deaths --tail reader` crashed unless the flag was passed (`reaction.economy`); the default is now 0 (off, what a missing key meant).

**The marks, timed** (Chris: the watermark has been misunderstood; real play seems to show a Summer gift helps). `ai_strategic_turn_planner` advances the season ($A483), then runs `per_period_fief_daimyo_update_driver` ($A498), whose banner `draw_current_season` names season 1 "Summer" ($D6A9) and which copies live → marks there ($A066) and harvests in Fall ($A26F, min(mark, live) at $A0A9); the fiefs' commands come after. So Fall income reads loyalty and wealth as min(entering Summer, entering Fall): a Spring gift pays this Fall; a Summer gift does not raise this Fall's marks but pays in full next year, protects against riots now (rolled on live loyalty) and adds 1 Charisma; a Summer dip (a tax raise) does cost this Fall. **Checked in the running cartridge** (Chris: tax/give against tax/train, someone with 70+ loyalty and not hunted; headless Mesen through emu-harness `NES` + `live.run`, reading SRAM, no screen capture). New game, 17 fiefs, 1 player, Oda (fief 17), skill 1; Spring 1560 tax 20 → 55 (loyalty 71 → 47, wealth 72 → 48). At the Summer menu, before any command, the marks (`$6003 + 8·fief`: output, dams, loyalty, wealth) already read 80/80/47/48. Arm A gave 50 gold to the peasants: live loyalty/wealth 97/98, **marks stayed 47/48**, Fall gold 50 → 92, rice 80 → 136. Arm B trained: marks 47/48, gold 100 → 137, rice 80 → 113. Both harvests fit marks 47/48 to the unit (gold 66 + roll 15 / 10, rice 70 + roll 2 for train, upkeep 39; the gift arm's rice is the outlier below); with marks 97/98 the gold before the roll would have been 104, above A's 81. **A Summer gift does not reach this Fall's harvest; it pays at the next one** (the next Summer copies the live 97/98). The jumps seen in play after a Summer gift are the tax (pct of 55 against 20) and last year's gift landing.

Driving NA1 headless, so it is not re-derived: screen text is the nametables through tile = ASCII − 0x2F (capitals 4 further; a digit d shows as d + '7' in that map); Y/N and two-way choices are Left / Right; number entry starts each digit at 0, Up adds 1, Right opens the next digit at 0, A confirms (`input_number_digits` $D3ED); the command menu is a cursor from item 1, 12 to a page with wrap, Right flips to 13-21 (Build, Give, Bribe, Assign, Rest, Map, Grant, Other, Pass). Setup from power-on: `wait*600,start,wait*240,left` (new game), `left` (17 fiefs), `right` (no AI battles), the player count, the fief, `left`, five presses for the abilities, `left`, the skill, `left`. Now a tool: `tools/na1_play.py` (Chris: it will help solve problems). **With 20 rolls** (`summer-gift --runs 20`; each run seeds the RNG at the Summer menu, since the wall-clocks $0083-$0088 do not advance there and waiting changes no roll): give, Fall gold +36.0 (28-45) and rice +39.9 (31-48); train, +35.0 (27-43) and +39.5 (31-48); the marks 47/48 in every run. The formula on marks 47/48 gives gold +27..+45 (mean 36) and rice +31..+49 (mean 40); on 97/98 it would be +65..+83 and +69..+87. The first single pair (+42/+56 against +37/+33) was two different rolls; its rice +56 sits 7 above the range and is not reproduced in 40 runs (an event in that game, not identified). Oda's Charisma is 68 (the roll is 0-18), not the 108 read through the first charmap.

### #53 — Rice: the merchant is there half the time, the price hardly moves, and the player rarely needs either (Chris, 2026-11-13)

Chris: *the runner assumes it can always buy rice when it needs it, and this is untrue; it will probably sink games when rice is needed after a successful defence brings in lots of troops.* And: buy cheap and sell dear makes sense, but it costs a turn, a gift is √, not 1:1, and the caps bind once the economy is large.

**The merchant** (`ai_per_fief_command_driver` $B8B1-$B8EB): at every fief's turn, present when rng_mod(100) < 55 − 5·skill (50% at skill 1), plus 1 in 4 when the lord carries the weakness mark; `effect_trade` $8A15 admits Trade where he is, and always at fiefs 13/14 (Yamashiro, Settsu). Only the player's Trade reads the flag; the AI trades in its own develop handler. The sim never rolled him. Now `game.roll_merchant` does, for the player's turns, from a separate stream seeded off the game's (so every other roll is unchanged), and `policy.MERCHANT` (default on) gates the player's rice buys; absent, Trade does not spend the turn and the policy plays something else.

**Measured** (`na1sim.long_game`, every start, seeds 3000-3019, 70 years): merchant always there **150** (#48's figure exactly), rolled **155** (8 saved, 3 lost, z +1.5, noise). It cannot matter much: in 85 of those games the player bought rice **25 times in 1,448 player-years**, all in Summer (the shield and upkeep rules). After a successful defence the attacker's surviving men join the fief with whatever rice and gold his purse still holds (`apply_conquest_outcome` $E03C writes both armies' purses into the fief). **Chris: the deadly case is the defence won because the attacker ran out of rice:** his purse is 0, so the fief gains his men and gold and no rice, and cannot feed the army at the Fall upkeep; Summer rice buys were the answer, found on Saito under the EV planner (#45's turtle against a short-fed attacker wins exactly this way). On the #48 player it is rare: in 170 games (every start, 10 seeds, merchant rolled) the player won 329 defences, **1 with the attacker out of rice**, and only 6 (2%, all Summer battles, none in years 0-5) left the fief with rice under men/2 for the Fall. The expander's doctrine fights rather than waiting out the attacker's food, and later every invader carries enough rice. So the merchant matters most for a turtling defender early; it did not move the whole-game count.

**The price in games, not in the roll.** The yearly roll alone (80% drift ±5 within 10-30, 20% a jump to 5-10 or 30-39) puts 27% of years at 1.0 gold or less and 28% at 3.0 or more. Chris: the AI buys and sells every turn, so prices are steadier. In all-AI games (skill 1, 60 × 30 years, every season): **1.1-1.9 gold 83% of seasons, 2.0-2.9 17%, 3.0+ 0.1%, never under 1.0; mean 1.77.** Each AI trade nudges the rate by 1 (`cycle_economy_rate`), and the trading pulls it back to the middle within the year. Buy-low, sell-high has no spread to work with; with the turn, the √ on gifts and the header cap on top, it is not a strategy. Rice is a steady ~1.8 gold that the player seldom has to buy.

### #52 — Morale over 100 against more men: the AI's bribes stop, the outcome does not move (Chris, 2026-11-13)

Chris: *push your morale 100+ and it stops* (the AI's battle bribe, #51); *is morale under 100 losing too many battles? Maybe a morale bump beats more men, then again maybe not.*

**The gate, from the ROM** (`ai_try_bribe_strongest_enemy_unit` $A721): the AI's commander bribes only when rng_mod(skill + 1) ≠ 0, its battle gold exceeds its men, it has at most half the human's men, and the human fief's morale is at most skill × 100 (`$A780`, unsigned). At skill 1, morale 101 closes it, as Chris plays it.

**Tested:** `expand.MORALE_FLOOR`, under which the expander's topped-out gold goes to the men's morale instead of hiring, at 101 against the default 55. The #48 player and harness of #51 (bribes off), every start, seeds 3000-3019, 70 years, paired:

| | unified | saved / lost | unified in both: mean year | AI-bribed men | AI attacks survived |
|---|---|---|---|---|---|
| floor 55 | 154 | | 24.7 | 13,540 | 89.5% of 1,586 |
| floor 101 | 150 | 27 / 31 (z −0.5) | 23.6 (67 sooner, 48 later; t −1.9) | 2,163 | 88.2% of 1,387 |

**The bribe drain stops** (84% fewer men taken), and the games that unify in both finish about a year sooner, borderline. **The count does not move**, nor does defence: the gold that buys morale is gold not spent on men, and the two come out even. Deaths stay invasions (167 / 164). Floor 101 is a defensible style, not a stronger player; the default stays 55.

### #51 — Bribe priced: cheap men when the gate is open, and it almost never is (Chris, 2026-11-13)

Chris: *an efficient way to spend your gold and kill an army, or overpriced?* The battle Bribe (#29: commander only, once a side a day, `resolve_attack_apply_casualties` $9E73, oracle-checked) is priced here; the strategic Bribe command (#19) is not.

**The price, from the formula.** The contest is nearly a stat check: your fief morale + your Charisma + rng(0..5 − skill) against theirs + 2·skill, gold paid win or lose. The best payment is exactly the target unit's men, and it turns pct_op(unit, 100(s − e)/(2s − e)), at most half. A 100-man unit at skill 1: Oda at morale 100 turns 29 of Saito's (3.4 gold a man) and 9 of Honganji's (11.6); against Uesugi or Takeda (morale about 150, Charisma 101-113) he never wins. Each turned man is a swing of two, and the price is one gold per target man in any year while men climb from about 3 to 10-20 gold, so where it works it is the cheapest army in the game. It costs no season command, only the commander's day, which the Charge holds back anyway.

**Chris: how much gold can you bring?** `driver_war` sets the army's gold to exactly the men sent (`war_attacker_gold = war_attacker_men`, $995C), and the bribe budget is gold − men, so **an attacker starts every battle with no bribe budget**; it grows only as his own men die, and each turned man uses it up again. The defender's purse is the whole treasury (`battle_init_defender` $92CA). After the battle both purses go to the fief with the winner (#48's garrison write); bribe gold is simply gone, the enemy does not receive it.

**Tested in whole games.** The ROM verb is now in `tactical.human_command_loop` (`("bribe", slot, gold)`, budget-checked). A scratch harness wrapped the #48 player (skill 1, `no_retreat`, `summer_rice_first`, `line_first`, `shield_rice=4`; Charge attacking, `Doctrine("control", "contact")` defending; the 11-12 `long_game.py` settings): each day the commander bribes the largest affordable enemy unit with exactly its men when the contest wins even at rng 0 and a man would turn. Every start, seeds 3000-3019, 70 years, paired:

| | unified | saved / lost | gate open, attacking | defending | gold → men turned |
|---|---|---|---|---|---|
| bribes off | 154 (#48: 150) | | | | |
| bribes on | 152 | 9 / 11 | 389 of 27,787 days (1%) | 484 of 10,185 (5%) | 16,870 → 2,169 (7.8 gold a man) |

**No effect.** Chris: *the trouble is you need to win the gate first.* The player's fiefs rarely out-score the AI's morale + Charisma: the AI feeds morale every military pass and sits near 150, and the attacker's budget is zero until he bleeds. Where it opened the price was about 8 gold a man turned (4 a man of swing), above the table's best cases because real margins are thin. An earlier run on a weaker reconstruction (skill 2, the AI's own defence; 27 unified) gave 27 → 36 (24 saved, 15 lost, z ≈ 1.4) with the gate open 9-11% of days: the bribe helps a little where the player is weak and the gate is open more, and nothing on the real player.

**The other side of the verb.** The AI bribes the human whenever its commander's roll passes (`ai_rng_resolve_combat_apply_casualties` $A721): with probability skill/(skill + 1), when its gold is over its men, it is under half the human's men, and the human fief's morale is at most 100·skill. It turned **13,540 of the player's men** in the 340 control games, about 40 a game, a cost every #48 game already paid. At skill 1 a player fief with morale over 100 shuts that gate entirely (per the sim's port of $A721; worth a direct check against the bytecode before acting on it).

Verdict: not in the player. The verb is priced right; its gate makes it a defender's tool against weak, low-morale attackers, and the AI rarely is one.

### #50 — Sabotage priced: one opponent tied up costs more than making yourself better against all of them (Chris, 2026-11-13)

Chris: the four non-lethal ninja missions are probably overpriced; price them. Assassination is left out on purpose: a single roll that removes a lord, priced separately as expected cost by circumstance (sometimes too dear, sometimes impossible).

**The rules** (`effect_ninja_sabotage` $A2D2, `source/4-c/bank_01.c`):
- **Price per ninja:** `hire_gold_rate` = (rng(101) + (year − 1560)·10 + 4) / 4, rolled once a year (`roll_period_market_rates` $92A5), nudged by each mission (`cycle_economy_rate(5)`). The cost of n ninjas is (rate·n + 9)/10: on average 1.8 gold a ninja in 1560, 4.2 in 1570, 9.2 in 1590. It is paid win or lose.
- **Gate:** the mission runs only if target Luck < your Luck + 30 ($A36C). There is no roll, so each pair of lords is always open or never. Of the 17, Imagawa (Luck 31) and Anekoji (46) are blocked by 14 lords each, Rokkaku (52) by 13, Saito (77) by Tokugawa and Oda, Hatakeyama and Ashikaga by Tokugawa; the other eleven reach everyone.
- **Failure costs your lord 1 Charisma** (`effect_ninja_failed` $A29B: `deduct_byte_at(charisma, 1)`) as well as the gold. A mission fails at the gate, or when its field is already 0. So a mission against a lord who blocks you is a certain loss of gold and Charisma. This was not in #1/#2 or `ninja.md`.
- **Drain:** (rng(max(1, pct_op(field, isqrt(n)))) + 1) × 5, clamped to the field. Because of the integer square root, only square counts pay. For a field of 100 or less (morale, loyalty, dams) anything under about 16 ninjas drains a flat 5. Only town and large rice stocks drain well per ninja. Missions: 1 loyalty and wealth, 2 morale, 3 dams and rice, 5 town.
- **Each mission is the season's command**, the same price as a pact (#49).

**What the drains buy.** All-AI games, skill 2, 200 paired seeds, 6 years. One AI capital is drained every season after the command pass (Luck gate assumed passed, cost not charged to anyone). Faction dead by year 6, and dead by a revolt at that capital:

| Target | control | Revolt n=1 | Revolt n=25 | Revolt n=100 | Dams n=100 | Uprising n=25 | Arson n=25 |
|---|---|---|---|---|---|---|---|
| Honganji (Kaga) | 76% (1.5%) | 80% (7%) | 93% (21%) | 99% (32%) | 80% | 76% | 76% |
| Uesugi (Echigo) | 5.5% (0%) | 6% (0%) | 32.5% (27%) | 67% (62%) | 14.5% | 6.5% | 3% |
| Takeda (Shinano) | 25% (0%) | 24% (0%) | 43.5% (19.5%) | 64.5% (43.5%) | 36.5% | 27% | 25% |
| Saito (Mino) | 98.5% (20%) | 99.5% (25%) | 99.5% (26%) | 100% (29.5%) | 99.5% | 99.5% | 98% |

- **Only Revolt moves outcomes**, through the morale-45 cliff: a capital with morale ≥ 45 and Charisma ≥ 45 is never revolt-eligible (eligibility fails both min(x,50)² < rng(2025) rolls). Even at morale 0 the ceiling is about 12-15% a non-Summer season (the uprising branch × the 3%-per-fief planner gate × the revolt coin × the rebels' win roll). The AI feeds morale back every military pass, so one ninja is repaired (Summer morale 153 → 111 on Uesugi, never under the cliff). 25 a season gets Uesugi's capital to 70 and topples him in a third of games. 100 gets it to 55 and two thirds.
- **The price of that:** 25 ninjas cost about 33 gold a season in 1560 and 64 by 1565; 100 cost about 130 and 256. Every command for six years goes to one capital, and a revolt does not give you the fief: the ROM installs a new daimyo there (`install_new_daimyo`). Chris: 130 a season is 520 a year in 1560, an economy nobody has, and it takes every turn, *all for a chance to revolt one fief*. Men bought with the same gold and commands work against every neighbour.
- **Uprising, Dams, Arson** cut their fields hard (Uesugi's loyalty 206 → 80, town 113 → 36) and change nothing that matters within six years. The AI's income has slack, and its Spring boon refills loyalty and wealth.
- **Saito, the low-Charisma test:** he is revolt-eligible about half the time at any morale (Charisma 31 fails its own roll), but he is already dead in 98.5% of AI games, so there is nothing to snipe. Low Charisma helps sabotage only against a lord who would otherwise live.
- **Dams as defence** (a hunter at rice 0 cannot start an attack, and its men count as 0 to its neighbours): 100 ninjas a season held Uesugi's Summer rice at 46 against 106, nowhere near 0, and his death rate rose only 5.5% → 14.5%. Not a lever.

**Verdict (Chris):** not baked into the player. Tying up one opponent costs more than making yourself better against all of them. At best a cheap Revolt snipes a lord who is already failing; the experiment found no case where that changes the game.

Caveats: the drain hits every season including Summer, with no cost to the attacker, so these are upper bounds on the effect; the Summer means are over games where the target still held the capital. The experiment was a scratch script, not a tool.

### #49 — Diplomacy priced from the formulas: a pact is a stall, a marriage is an army you could have bought (Chris, 2026-11-13)

Chris: *does it really even affect anything? Can a pact or marry deal with a hard gate; isn't it easier to just buy men?* Priced from the rules, no full runs. First of the unused verbs to price (Pact/Marry, Bribe, Trade, sabotage, then Assassinate, the OP one that "decides games on a die roll").

**What a relation does.** One reader matters: the AI's war commit (`ai_commit_attack_deduct_resources` $9040) calls `relations_rng_predicate` $8271 after the budget checks, and calls the attack off that season if rng(100) < the owner relation, or else rng(100) < the fief relation. A blocked roll leaves the relation alone; a committed attack zeroes both cells (`effect_war_a` $8201). A timid lord (Drive < 50) also skips liked targets when picking (`ai_relations_and_low_drive_skip_gate` $93DD). Of the 17 lords only Rokkaku (36) is under 50, so `ai.py`'s "all scenario lords are bold" is nearly but not quite right. Your own War on an ally gets "They are your allies!" (#20, not rechecked).

**Two cells, two decay rates** (corrects #20 and `na1sim/diplomacy.py`):
- **Pact** writes 70 into the *fief* cell, your fief to the target fief (`set_pact_relation` $DA4F, the upper triangle). `decay_relations_matrix_upper` runs **every season**: 4 in season 0 ($9F9C, skipped in 1560) and 2 in the others ($A06C, $A275, $A392), **10 a year**. A pact is gone in about seven years and guards one border.
- **Marriage** writes 90 into the *daimyo* cell, owner to owner (`set_marriage_relation` $DA7D, the lower triangle). `decay_relations_matrix_lower` runs in season 0 only ($9FA1), **2 a year**, and covers every fief both lords own.
- A daimyo's death clears his capital's whole row and column (`clear_fief_pair_matrix` $E1E7, called only from `announce_daimyo_death` $E275 and the natural death `check_and_process_daimyo_natural_death` $9194). Nothing else clears a fief's row, so a pact on a non-capital fief survives a change of owner.
- `diplomacy.py` (unwired, nothing measured with it) said relations never decay, and its marriage writes the fief cell. Both are flagged in its docstring.

**The price.** Pact: offered when rng_mod(skill_level) == 0 (always at skill 1), refused 2 in 3 when the asker carries the weakness mark, which is health-based ((100 − health)/400 a pass), not army size as #20 read it. The demand is pct_op(gold, 50) + pct_op(gold, rng(50)) + 20 of *your* fief's gold, paid from gold in hand, plus 1 Drive. Spend the treasury the season before and it costs about 20. Marriage: gold > 200 to ask, dowry pct_op(gold, rng(30) + 50) + 200, so 300 or more; refusal costs −1 Drive, Luck and Charisma for good. Either one costs **the season's command**, the real price in a 4-command year.

**Against a hard gate** (a hunter who reaches the commit with chance q each season; blocks independent each season; decay by season as above):

| | expected safe seasons, q = 0.9 | q = 0.5 | P(no attack in year 1), q = 0.9 | year 2 |
|---|---|---|---|---|
| nothing | 1.1 | 2.0 | 0.00 | 0.00 |
| pact 70 | 3.0 | 5.0 | 0.21 | 0.02 |
| marriage 90 | 8.4 | 13.2 | 0.66 | 0.40 |
| both | 13.4 | 18.5 | 0.86 | 0.69 |

The roll repeats every season, so the blocks multiply: a 70 pact is about two extra seasons, not 70% safety. Men in 1560 cost 1.4-4.9 gold (`GOLD_MEN_HIRE_RATE` = pct_op(20 + rng(51), 70), ×10), so a marriage's 300 gold is about 100 men, enough to close most early gates for good (Saito's mean killing blow is 144 men against 37). **Buying men is easier wherever the gold exists.** A pact is a stall: about 20 gold and a command for two seasons.

**Where it could live (Chris): only early.** Late, the men are there, the plan is expansion, and a marriage blocks it. Early, a pact closes one border, and the weak starts have several: of the 17 starts only Noto (Hatakeyama) has one border (Kaga), and Kaga has five. So Hatakeyama is the only clean test, and he may have fixed his problems by Winter 1560 / Spring 1561 (Chris), which is the window two stalled seasons would buy. Against it:
- His opening (Spring hire all, Summer tax 55, Fall gift; 12.7% → 30.7% alive at year 3) already uses three commands; a pact displaces one of them.
- The hire empties his gold, which makes the pact cheap but needs about 20 in hand.
- Honganji is rarely the killer (22 of 243 invasion deaths at skill 1): whoever takes Kaga is. The pact is the Noto–Kaga fief cell, so it would roll against Kaga's next owner too, unless taking Kaga kills Honganji (it is his only fief, so his capital) and his death clears Kaga's row first. Which happens is the first thing to check.

**To test before it becomes a tool:** Hatakeyama, skill 1, 300 paired seeds, alive at year 3: the opening against the opening with a pact in each slot (and a Winter 1560 pact after the gift); log whether the Noto–Kaga cell survives Kaga's fall.

### #48 — Expansion: attack only when everything owned stays past its gates (Chris, 2026-11-12)

**The rule** (Chris): if you cannot keep your first fief past its gates, you will not keep two. An attack is worth making only if, afterwards, every owned fief, the one the army left and the one it took, is still SAFE. A fief with no enemy neighbours needs no army, and taking the biggest neighbour lowers the gates of every owned fief beside it, so the choice is a graph question as much as a battle one. Start simple: the calculated battle prices the attack (a fought-battle attack player comes later and only moves the odds).

**The War command as the cartridge runs it for a human** (`driver_war $9850`): men up to min(men, gold), a weak lord a quarter of that and never from his capital; one gold per man sent, carried; rice up to min(rice, men sent); lead only from the capital (the daimyo-present bit, 3x men). On a win half the defender's men join the survivors, the carried gold and rice add to the fief's, tax drops to 30; on a loss the defender absorbs half the attackers; a fallen capital can hand over its whole faction (1 in drive/10). The strengths are `game.siege_strengths` (factored out of `resolve_siege`, outcomes unchanged).

**The player** (`na1sim.expand`): from a position where every owned fief is SAFE, in Fall, Winter or Spring, price every target x men (the fewest that win up to the cap) x rice x lead; keep the moves that win and leave every owned fief SAFE; prefer more interior fiefs, then the target's harvest, then fewer men. Else, once the peasants are full ((wealth + loyalty) / 2 >= header), buy men with half the gold (Chris: when wealth tops out, buy men; the other half pays the War command's gold per man). Else the reader's season.

**Why the topped-out rule matters.** The reader's income "fell" after year 6 (Oda 1840 to 702 by year 10). It did not: loyalty and wealth hit the header (1660), the gold followed, and `cap_fief_stats` clamps gold at the header, so every harvest into a full treasury is thrown away. A full treasury makes men free.

Bench, skill 1, 10 years, 20 seeds, both players shield 4 (fiefs and income are means over the living; income = what the harvest adds, `ev.income_capacity` summed over the owned fiefs):

| fief | player | alive | fiefs y6 | y10 | income y6 | y10 | attacks/game |
|---|---|---|---|---|---|---|---|
| Oda | reader | 18 | 1.1 | 1.3 | 1840 | 702 | 0 |
| Oda | expand | 18 | 1.6 | **2.8** | 2095 | **2983** | 1.50 |
| Tokugawa | reader | 19 | 1.1 | 1.1 | 1905 | 517 | 0 |
| Tokugawa | expand | 19 | 1.4 | **3.0** | 2050 | **3246** | 1.75 |
| Hojo | reader | 11 | 1.0 | 1.1 | 1579 | 450 | 0 |
| Hojo | expand | 12 | 1.3 | **2.8** | 1803 | **2876** | 1.00 |
| Imagawa | reader | 10 | 1.0 | 1.3 | 1685 | 812 | 0 |
| Imagawa | expand | 12 | 1.5 | **2.9** | 1921 | **3096** | 1.15 |

Expansion costs no survival (equal or better on every start) and speeds up once the economy tops out: most first attacks come in 1565-1568, and the holdings nearly double between years 7 and 10. Without the topped-out rule the same player reached only 1.6-1.9 fiefs. Saito never gets past being hunted, so it never attacks. The reader sometimes ends with 2-3 fiefs without attacking: something hands it territory (a faction collapsing into it, not yet traced).

**Can they win? Out to 70 years** (Chris). The five strongest starts, 20 seeds each, skill 1, until the player holds every live fief or the lord dies. The first run unified 9 of 100 and lost 79 to revolts, most in years 10-20: the topped-out hires pulled the capital's morale down season after season (recruits arrive low; Oda 77 to 31) until a revolt fired, and a human capital's revolt is a staged battle that ends the faction. The fix: a topped-out fief under 55 morale gives the gold to the men instead of hiring (`expand.MORALE_FLOOR`). The carried rice now counts too (the value prefers the most rice that keeps everything SAFE; gold is fixed at one per man).

| start | unified /20 | years to unify (median) | lord's age then (median) | failed |
|---|---|---|---|---|
| Miyoshi | 9 (2 before) | 29 | 67 | lord died 10, invaded 1 |
| Oda | 14 (1) | 25.5 | 51.5 | invaded 3, lord died 3 |
| Asakura | 12 (2) | 26.5 | 53.5 | invaded 5, lord died 3 |
| Kitabatake | 12 (1) | 22.5 | 55 | invaded 3, lord died 5 |
| Tokugawa | 16 (3) | 26 | 44.5 | invaded 3, lord died 1 |

**63 of 100 unify (9 before), and no game is lost to a revolt.** The clock is the lord's age now: 22 of the 37 failures are a lord dying of old age mid-conquest (Miyoshi's lord starts old: 10 of 20), the other 15 invasions. Speed is the next lever, which is what the graph terms below are for.

**The invasions that remained were two holes, not the gates.** (1) An interior capital passes SAFE with no men; an AI took a neighbouring owned fief, the capital became a border with 0-8 men, and its fall handed over the faction (late empires of 6-14 fiefs). Now, holding two fiefs or more, the capital answers to every enemy within two steps through owned ground (`expand.capital_line`): the attack check requires it and the capital hires to it on its own turn. Invasion deaths on the strong five fell 15 to 8 (64/100 unified). (2) The rice preference let an attack carry the home fief's rice away: Tokugawa's capital sat at rice 1 beside 276 men and a 6-man attack at 4% share took the faction (a fief at rice 1 is depleted before the battle; the AI's rare off-gate attack found it). Now the fief the army left keeps rice >= men.

**Every start, 70 years** (20 seeds each, the current player):

| start | unified /20 | median years | median lord's age | failed |
|---|---|---|---|---|
| Asakura | 15 | 30 | 57 | lord 2, invaded 2, revolt 1 |
| Tokugawa | 15 | 28 | 46 | lord 3, invaded 2 |
| Asai | 13 | 27 | 42 | invaded 3, lord 3, revolt 1 |
| Hida | 12 | 35.5 | 55.5 | invaded 6, lord 2 |
| Kitabatake | 11 | 25 | 57 | lord 6, invaded 2, revolt 1 |
| Oda | 10 | 24.5 | 50.5 | lord 8, invaded 2 |
| Hojo | 9 | 25 | 47 | invaded 8, lord 3 |
| Takeda | 9 | 25 | 64 | lord 8, invaded 3 |
| Ashikaga | 7 | 35 | 58 | invaded 9, lord 2, revolt 1, riot 1 |
| Uesugi | 6 | 28 | 58 | invaded 7, lord 7 |
| Miyoshi | 5 | 24 | 62 | lord 15 |
| Imagawa | 4 | 26 | 67 | invaded 8, lord 8 |
| Tsutsui | 2 | 44 | 55 | invaded 18 |
| Hatakeyama | 1 | 31 | 52 | invaded 12, lord 5, revolt 2 |
| Saito, Honganji, Rokkaku | 0 | | | invaded 19 / 15 / 20 |

**119 of 340 unify.** Fourteen of the seventeen starts can win; the three that cannot are the ones that never get past being hunted (#45-#47). The outcome is bimodal: a start either clears the opening and then usually conquers everything (median peak 16-17 fiefs), or dies in it (median peak 1). The strong five read 56/100 here against 64 before the rice rule: the full home shield makes the attacks fewer and later, and Miyoshi's old lord (15 of 20 lost to old age) feels it most. Speed is the lever now.

**The three that never win** never clear the opening under the reader's: Saito and Rokkaku die in year 1 in 19 and 20 of 20 games, Honganji in 12. Honganji's survivors expand to 9-13 fiefs and stall: the Tax command caps every Honganji-owned fief at 30 (`number_input(1, defender_owner_is_honganji() ? 30 : 100)`, the owner, not the fief), so conquest does not lift it. Hatakeyama's third that clears the opening goes the distance (one unified, six lasted to year 50-51).

**Depots** (Chris: the basics before we can plan). `expand.move_men` is the Move command (`driver_move $96D1` + `effect_move $8CA5`): men to an adjacent owned fief, at most min(men, the destination's header room), morale/skill/arms blended by men (`weighted_average_capped`), an emptied source loses its military stats, a lord-led move takes the capital. `expand.send` is Send (`driver_send $9A62`, `effect_send $8BE5`): rice and gold to any owned fief (`build_eligible_province_list(1)`: owned, not ownerless, not itself), each at most min(the receiver's header room, the sender's stock). A fief with no enemy neighbour is a depot: its command marches its spare men one step toward the front, else sends spare gold and rice to the front fief least able to field its army (attacking costs a gold per man and rice up to the men), else hires once topped out (the recruits march next season). The front's commands stay free for attacking. Interior fiefs keep no garrison: revolts and riots need more than 2 men (`revolt_eligible $9E21`, `riot_eligible $9DA3`), so an empty interior fief cannot rise (Chris); a 20-man garrison gave 190 unified, none 188, the same.

Every start, 70 years, 20 seeds each: **188 of 340 unify** (119 before depots). The median unification comes in about year 20 (25-35 before), so old age is almost gone as a failure (3 lords of 340, all Oda); what is left is invasion, nearly all of it in the starts that never clear the opening. Per start, unified /20 before -> after: Tokugawa 15 -> 19, Asakura 15 -> 18, Kitabatake 11 -> 18, Miyoshi 5 -> 18, Takeda 9 -> 17, Asai 13 -> 16, Oda 10 -> 15, Hida 12 -> 15, Uesugi 6 -> 12, Imagawa 4 -> 12, Hojo 9 -> 11, Ashikaga 7 -> 9, Honganji 0 -> 3 (despite its tax cap), Tsutsui 2 -> 3, Hatakeyama 1 -> 2, Saito and Rokkaku 0.

**The shape of an empire: its army bill** (`expand.army_bill`; Chris: 5 fiefs with 4 on the front beats 5 all exposed). For the owned set: the men every owned fief needs to stay SAFE by share against its enemy neighbours (`share_line`), the capital against every enemy two steps out. Charted over 50 depot games (Oda, Tokugawa, Asakura, Hojo, Imagawa, 10 seeds, 30 years), by fiefs held before unification:

| held | exposed / held | army bill | men held | bill per fief |
|---|---|---|---|---|
| 2 | 1.00 | 201 | 384 | 101 |
| 4 | 0.98 | 590 | 1337 | 148 |
| 6 | 0.92 | 855 | 2250 | 142 |
| 8 | 0.89 | 1011 | 2895 | 126 |
| 10 | 0.62 | 935 | 2808 | 93 |
| 12 | 0.47 | 762 | 2715 | 64 |
| 14 | 0.34 | 482 | 2933 | 34 |
| 16 | 0.18 | 421 | 3233 | 26 |

Two readings. Up to eight fiefs the greedy empire is nearly all frontier, and its bill per fief climbs; interior appears only once the map is mostly eaten. And the men held run two to four times the bill: the army is there, but spread over many front fiefs, each attacking alone with its own men (the War command sends from one fief). So the planner's work is shape early (conquests that make interior sooner) and concentration (the depots marching to the fief that will attack, not merely the nearest front).

**Two conquests deep** (`expand.LOOKAHEAD`, `plan_value`): for each first conquest that passes the all-SAFE check, the best follow-up the empire could then make (from the owned neighbour with the most men, at the fewest that win), scored by fiefs gained then by the smaller army bill; the first move of the best pair is played. Every start, 70 years, paired against the greedy value: unified 186 vs 188 (6 saved, 8 lost), median year 20 vs 21, exposed per fief held at 4 / 6 / 8 fiefs 0.94 / 0.88 / 0.85 vs 0.98 / 0.92 / 0.89. A year faster and slightly more compact, no more unifications. The shape barely moves because there is rarely a choice to make: the all-SAFE check usually leaves one target, and the map, not the planner, decides what is adjacent. The measured slack is elsewhere: the men held run two to four times the bill while each attack comes from one fief.

**When to stop growing** (Chris: once the economy is big enough, less need to grow). Two readings, every start, 70 years, paired against the full-cap switch (186 unified, median year 20):
- *Each fief switches to men at half its cap* (`expand.TOPPED = 50`): 171 unified (17 saved, 32 lost). Stopping growth early starves the conquest; the economy pays for itself over twenty years.
- *Every fief switches once the empire holds half the live fiefs* (`expand.WAR_AT = 50`, Chris's meaning: by then the economy outweighs every rival's together): 176 unified (1 saved, 11 lost), and the games both unify finish 0.77 years sooner on average. Faster when it works; the 11 it loses stall at 9-16 fiefs for decades until the lord dies (7) or a capital revolts (3; war footing puts hired men, and their diluted morale, in every fief at once), one to an empty capital. The likely cause is the blunt switch: newly taken fiefs stop growing before their economy is worth anything. A war footing for developed fiefs only is the next reading. Both knobs default off.

**One campaign at a time is worse** (`expand.STAGING`, off). The empire picks the enemy fief its bordering fief is closest to beating; every other owned fief marches its men above its own line (+15%) along the shortest owned path to that stager, and topped-out fiefs send it gold and rice (letting every fief send starved their growth: the smoke game fell from 16 fiefs to 11). Every start, 70 years, paired: **133 unified against 186** (13 saved, 66 lost), and the games both unify finish 2.04 years later. Chris: one fief is too much focus once the economy can fill several fronts to their caps; the targets must be several, and the planner needs thought before more code. The principles so far, from what the runs measured:
- survival is a floor, not a trade: every owned fief SAFE, the capital two steps out; every relaxation lost empires;
- economy first, then the army: stopping growth early (half cap, or sends from every fief) cost 15 to 53 unifications;
- concentrate only as far as the targets need: a stager holds at most its header in men and a target needs only enough to win and stay SAFE, so the number of campaigns should follow the surplus;
- a likely shape: a flow on the owned graph (sources with spare men or gold, sinks at the chosen stagers, capacities at the headers, men a step a season against gold in one Send), with the set of campaigns chosen together for winnability, map-opening value (the army bill) and capitals; re-planned each season.

**The planner, as math** (Chris: graph theory; design recorded 2026-11-12, not built). Each season:
1. *Free army* = the men owned + what the topped-out fiefs' gold would buy - the army bill (every fief's gate line; the back line needs 0). `expand.free_army`.
2. *Price each attackable fief t*: need(t) = the fewest men that win from its best bordering source + what the new fief needs to stay SAFE; gain(t) = the army bill it removes + its income + a capital's chance of collapsing a faction. The bill term is the "holes" effect: an enemy fief the empire nearly surrounds turns several owned front fiefs interior when taken, so its gain counts them; a greedy picker that grabs easy edge fiefs leaves those holes and pays for a longer front.
3. *Choose the attacks*: targets matched to distinct sources (one command per fief a season: a source bordering two chosen targets launches one, the other is reassigned or waits), maximising total gain with total need <= the free army, each source holding gold >= the men it sends and rice up to them. A max-weight matching under a budget; at most about ten targets by ten sources, so exact enumeration is cheap.
4. *Logistics*: free men a step a season through owned ground and gold and rice in one Send, to the assigned sources; a loaded source attacks, the rest keep gathering.
5. *Re-plan* the next season. The number of campaigns falls out of the free army.

**Measured first: the greedy player leaves the army idle and the holes open.** The current player (depots + lookahead), 10 starts x 10 seeds, 40 years, each year before unification, by fiefs held: the free army (`expand.free_army`), the men actually sent to war that year, and the holes (`expand.holes`: enemy fiefs with two or more neighbours, at least half of them owned) with how long each has stayed enemy.

| held | men | buyable | bill | free army | sent / year | free unused | open holes | hole age (years) |
|---|---|---|---|---|---|---|---|---|
| 2 | 409 | 47 | 192 | 264 | 52 | 72% | 0.6 | 2.6 |
| 4 | 1121 | 70 | 466 | 724 | 119 | 77% | 2.1 | 3.7 |
| 6 | 3364 | 211 | 943 | 2632 | 157 | 87% | 3.1 | 8.4 |
| 7 | 3781 | 263 | 819 | 3226 | 145 | 89% | 3.3 | 7.5 |
| 9 | 3108 | 203 | 1017 | 2295 | 376 | 82% | 2.6 | 5.8 |
| 11 | 3215 | 312 | 925 | 2603 | 642 | 72% | 3.2 | 3.7 |
| 13+ | 3225 | 449 | 528 | 3146 | 1807 | 51% | 1.8 | 4.0 |

Both halves of the hypothesis hold. Through the middle game the free army runs 2,000-3,000 men while 150-650 a year go to war: 70-89% of it idles. And the empire carries two to three enemy holes at a time, which stay enemy four to eight years (longest at six to seven fiefs, the stall zone). The matcher has room: the men exist, the targets exist, the attacks do not happen because each is priced from one fief alone and the holes are never chosen.

**The planner, built** (`expand.PLANNER`, `plan`, `plan_move`; off by default). Each season: for every owned source and enemy target, the men to send (`send_needed`: win the calculated battle, and the new fief, survivors plus the defecting half of the garrison, clears its own share line); the gain (`target_gain`: the army bill removed, a quarter of the target's harvest, 300 for a capital); then an exact search for distinct sources, total men within the free army, the most gain. A source attacks once loaded and SAFE after, else takes the greedy best, else (topped out) hires toward its number; every other fief marches its spare men toward the nearest source and, topped out, sends gold and rice to the source furthest from loaded. Every start, 70 years, paired: **185 unified against 186** (12 saved, 13 lost), 0.2 years faster where both unify. Neutral.

**Why: the expansion game is nearly saturated.** Of 340 games, 137 die in the opening without ever holding a second fief; of the 203 that expand, 186 unify (92%), and only 17 expand and fail (8 to old age, 7 invaded). No planner can add many unifications to that; it can only add speed, and the median is already about year 20, much of it the economy topping out (first attacks come in years 5-8). **The lever is the opening:** 137 of the 154 failures are starts that never clear it, which is the weak-start openings (#45-#47, the ev player) built into the expanding player. The planner stays in as the foundation for fought battles, where attacks cost men and the free army will bind.

**Fought attacks** (Chris: the attack doctrine is next; the defence is easier to predict). The cartridge fights every human attack on the battle map; the expander had priced and resolved them with the calculated formula. `expand.player_war(fought=True)` runs `tactical.run_tactical_battle` (the engine already hands side 0 to `tactical.HUMAN` when the player attacks).

*The odds, measured* (22,792 replays of the expander's real attacks fought, 7 starts x 6 seeds, our side on the AI's own logic or `strike.Doctrine`, the two indistinguishable at these sizes). A fought battle is decided by men, not by the quality and morale that dominate the calculated one (the calculated minimum wins only 72% fought: sometimes far too many men, sometimes too few). By men sent over the defender's men:

| attacker | target | 1-1.25 | 1.25-1.5 | 1.5-2 | 2-2.5 | 2.5-3 | 3-4 |
|---|---|---|---|---|---|---|---|
| general | fief | 9% | 22% | 71% | 89% | 90% | 92% |
| general | capital | 1% | 12% | 32% | 82% | 88% | 93% |
| daimyo-led | fief | 35% | 62% | 73% | 89% | 100% | 100% |
| daimyo-led | capital | 9% | 51% | 76% | 89% | 94% | 99% |

Under 1x, essentially never. Leading (the daimyo-present bit counts the men again) shifts the curve half a step, but a led loss hands the whole faction to the defender (`$DED4`: the losing side was daimyo-led), and a led win moves the capital onto the conquest (`$E1B1`). Taking a capital whose daimyo stays hands over his faction in a fought battle; an AI daimyo flees when out-strengthened (`ai_claim_province_when_strong_enough`). A win leaves the fief 40% of the men sent at 1.5-2x, 49% at 2-2.5x, 61% at 2.5-3x, 67% at 3-4x, 77% at 4-6x, 87% beyond (both sides' survivors). (A bug fixed on the way: `player_war` judged a win by the target sharing the source's owner, which a led loss also produces once the faction is handed over; it now compares against the attacker's owner before the battle. The calculated results are unaffected: a calculated loss moves no fiefs.)

*The fought player* (`expand.FOUGHT`, off): a general sends 2.25x the defender's men for a fief, 2.75x for a capital (about 90%), never leads; the planner's what-ifs use the measured outcome instead of fighting (`fought_need`, `fought_keep`); real attacks are fought. Checked against 601 real fought attacks: 90% won, as priced; the garrison after a win came out at 0.99 of the prediction; 509 of 542 new fiefs were SAFE as predicted. **Every start, 70 years: 132 unified against 186 calculated** (6 saved, 60 lost; shared wins 1.8 years later). The prediction is not the gap: the war is. A fought conquest costs a quarter to a third of the men sent and one attack in ten fails (half the attackers join the defender), where the calculated one cost nothing; the losses land as invasions of expanded empires. 132 is the honest figure for a human's game, and the room for the doctrine is the attrition: win at lower ratios and with fewer losses.

**The attack doctrine, first try: worse than the AI's own logic** (`strike.Charge`, experimental, used nowhere by default). Chris's doctrine: the AI defender puts its commander on the castle seat with the others around him; we put our commander at the back of the strip and units 1-4 as close to the castle as possible in slot order, march in, kill what is in the way, and pursue the commander until he dies. Replays of the expander's real attacks (7 starts x 3 seeds), won / share of the men sent the fief keeps:

| | fief 2-2.5x | fief 2.5-3x | capital 2-2.5x | capital 2.5-3x |
|---|---|---|---|---|
| AI's own logic | 78%, 0.42 | 95%, 0.55 | 79%, 0.33 | 93%, 0.56 |
| Charge (v2: focused on the unit most of ours already touch) | 55%, 0.56 | 73%, 0.63 | 25%, 0.65 | 65%, 0.67 |

The charge keeps more men when it wins and never lost its commander, but wins far less: its losses are 30-day timeouts. Traces: the column breaks on the castle commander one unit at a time (home bonus 3x, each exchange costs the attacker 100-p%), and the pathing sometimes marches the wrong way (a detour, or chasing guards; not yet resolved). The AI's own logic wins the same battles by killing the commander too, so it gets there differently: possibly clearing the guards and striking together (the +20% per extra attacker momentum, `$7BEE`) rather than in single file. Open, with Chris.

**Why the charge lost: the unit split.** A battle lab (one attacker against one fief, fixed men, 16-20 seeds, both arms; Chris: study specific fiefs) showed the charge winning where the harvest said it lost: at 2.5x across 33 attacker/target pairs, 633 wins of 660 against the AI logic's 581 (Musashi -> Echigo 19 to 0; Mikawa, the slog Chris described, hard for both). The difference was the army: the lab's attacker had the scenario's 20x5 split, and in real games a conquered fief inherits the defender's (`province_unit_type_pct` $76A9): of 38 real attacks the commander held 20% of the men in 8, 30-33% in 21, 50% in 7, 55-65% in 2. "The commander holds back" then sits out half the army. With the Assign command (`effect_assign` $AC11, 30 gold and the fief's command: the commander row down to 1, row 2 up to arms/50 + 20) the commander becomes a token and the strikers carry the army. Wins of 16 at 2.5x, ten battles:

| our split | AI logic | charge |
|---|---|---|
| 20x5 | 106 | 140 |
| inherited 50/15/10/15/10 | 114 | **22** |
| Assign 1 / strikers | 101 | **158** |

**Assign + charge wins 158 of 160** (the AI logic 101-114 whatever the split). The doctrine is the pair: assign the commander down to a token before a fief's first campaign, then charge (Musashi -> Echigo 16/16, Owari -> Mikawa 14/16). Next: re-measure the fought odds under Assign + charge (the ratio needed should fall), then the expander assigns each source once before its first attack and fights with the charge.

**The split per map** (Chris). Same ten battles, wins of 16 at 2.5x, charge: Chris's 4/24/24/24/24 (row 2 capped at 20-21 by arms, so about 4/25/21/25/25) **154 of 160**, the token assign 158, the inherited split 22: the losses were the assignment, not the doctrine. The single heavy striker 1/99/0/0/0 (empty rows are not fielded) wins 144: **every Mikawa battle (16/16 from Owari, where the spread split took 10)** and every chokepoint map, but **none at Iga (0/16)**, the open map with the castle in the middle, where a lone ball meets the whole garrison and no momentum stacks. So the split is a per-map choice: heavy through a one-lane approach, spread where the castle can be surrounded. And the mirror for our own defence (Chris): 100/0/0/0/0, the whole army in the commander on the castle seat with the home bonus, against which a big ball comes and dies; to be tested against the AI's attacks.

**The doctrine in whole games** (`expand.CHARGE`, on; `desired_split`, `SPLIT_FOR`). Per map, heavy against spread from the lab (each fief from every neighbour, 2x and 2.5x, 12 seeds): heavy for Mikawa (95/96 vs 45), Owari, Echigo, Musashi, Echizen, Omi; spread for Noto (0/24 vs 24), Hida (24 vs 96), Iga (48 vs 96), Iseshima, Settsu; ties spread. Before a campaign a source whose split does not fit its target spends the season on an Assign (30 gold); its fought battles use the charge. Odds under the doctrine (12,708 replays): a fief 46% at 1.25-1.5x, 82% at 1.5-2, 93% at 2-2.5; a capital 22 / 54 / 91%; so the pricing is 2x for both (`CHARGE_NEED`, `CHARGE_KEEP`). **Every start, 70 years, all battles fought: 150 unified**, against 132 fought on the AI's own logic (45 saved, 27 lost) and 186 calculated (shared wins 2.9 years later). The doctrine wins back about a third of what fighting costs; the rest is attrition (a win still leaves the fief about half the men sent) and the Assign's season and 30 gold per campaign.

**Fought by default** (Chris: a human cannot auto-resolve; the calculated battle gave free wins): `expand.FOUGHT = True`. The ratio the doctrine prices at hardly matters: every start, 70 years, paired against 2.0x (150): 2.5x 150 (29 saved, 29 lost; shared wins 0.7 years sooner), 1.75x 154 (30 / 26). More men per attack fails less and garrisons more; fewer men attacks more often; it nets out. Echizen per direction (Chris): heavy holds from both edges, clearly from the south (Mino at 2x 13/16 vs 8, Omi at 1.5x 11 vs 0). Saito's ~8-9% stands: the AI's attacks on a human are always fought (the commit sets the redispatch flag for a player defender), and that work was all defence.

**Saito can unify** (Chris: run the tuned start with the expander). `expand.BASE` takes the season's policy when the expander has nothing to do; for Saito it is the ev player (8-season horizon, growth, marks, riots) while he holds one fief, then the reader. All battles fought, the doctrine on, skill 1, 300 seeds, 40 years, against the reader's opening on the same seeds:

| opening | alive at 3 years | at 6 | expanded | unified | years to unify |
|---|---|---|---|---|---|
| reader | 16 | 15 | 12 | 6 | 23-31 |
| ev (tuned) | 29 | 27 | 23 | **13** | **14**-31, median 23 |

The opening is the whole game for Saito: 9% get past it (the #46 figure, unchanged with fought battles), and of those 27, 23 expand and 13 take all of Japan, against a lord who dies in about year 38 (the "lord died" deaths at 38-40 come after unification). **4.3% of Saito games unify**, with every battle fought.

**Honganji and Rokkaku, same test** (300 seeds, 40 years, all fought):

| start | opening | alive at 3 years | at 6 | expanded | unified | deaths |
|---|---|---|---|---|---|---|
| Honganji | reader | 83 | 72 | 55 | 9 (21-39 years) | invasion 236, revolt 47 |
| Honganji | ev | 105 | 92 | 59 | 5 (18-37) | invasion 214, revolt 64 |
| Rokkaku | reader | 8 | 8 | 7 | 4 (18-29) | invasion 295 |
| Rokkaku | ev | 14 | 13 | 13 | 1 (32) | invasion 290 |

**Every start can now unify**, Rokkaku included (Chris had no hope for it; 4 of 300 under the reader). The ev opening keeps more of both alive (Honganji 92 vs 72 at six years, Rokkaku 13 vs 8) but unifies fewer, inside the noise at these counts. Honganji is the different case: it expands as often as anyone (55-59 of 300), and few of those finish, because revolts end them (47-64): its fiefs revolt on a 1-in-20 roll where every other lord's is 1 in 1000 (`revolt_eligible`). Out-expanding beats its 30% tax cap; the revolt rate is what stops it (Chris: Honganji wins by out-expanding).

**The bottom five, ranked** (300 seeds each, 40 years, all fought; unified, reader opening / ev opening): **Hatakeyama 23 / 28** (9.3% at best), **Tsutsui 15 / 17** (5.7%), **Saito 6 / 13** (4.3%), **Honganji 9 / 5** (3.0%), **Rokkaku 4 / 1** (1.3%). The ev opening helps the hunted starts (more clear the opening) except where few survive either way. Honganji with a morale floor of 100 (`expand.MORALE_FLOOR`): 7 / 8 unified, revolt deaths 49 / 59, no change: a human capital's revolt is a staged battle, lost about a third of the time whatever the morale (#45), and Honganji's flat 1-in-20 eligibility ignores morale, so the special rule is its ceiling, not its tax. The win rates of the twelve stronger starts, all fought (20 seeds, 70 years): Oda and Asai 80%, Asakura 75%, Hida and Tokugawa 70%, Kitabatake and Takeda 65%, Uesugi 60%, Miyoshi 50%, Hojo 45%, Ashikaga 40%, Imagawa 30%.

**A player's lord dying is game over** (Chris asked about an heir). `check_and_process_daimyo_natural_death` $9194 calls `retire_human_player_check_game_over` for a player's lord (the AI-player count rises; with no human left, the game-over flag), then `find_fiefs_of_owner` neutralises every fief he held ("lost its leader"). Each goes to `auction_ownerless_fief_to_bidders` $8C75 (neighbours bid gold), and with fewer than two bidders `install_new_daimyo` seats a generated lord (`assign_unique_daimyo_face_code` marks him) in the AI's seat. The heir exists, but not for the player, so the "lord died" losses are counted right. The sim's `natural_death` empties the fiefs without the auction, which does not matter once the player's game is over. Also: a player's five stats are rolled at the new game (450+ in the sim), only the age is historical, so the second variable after the opening is the lord's runway: Anekoji is 20, Miyoshi 38 (Miyoshi is the safest opening but runs out of years).

**Next (Chris, 2026-11-12), by expected gain:**
1. ~~**The other verbs: interior fiefs as depots.**~~ **Done (above).** A fief with no enemy neighbour needs no army, and today it spends its command training. `driver_move $96D1` moves men only, to an adjacent owned fief, up to min(men, the destination's header room), blending morale/skill/arms; led by the daimyo it moves the capital too (the king can retreat inward). `driver_send $9A62` moves rice and gold to an owned fief, capped by the receiver's header (eligibility `build_eligible_province_list(1)`, not yet read). So the interior marches its men one step toward the front each season and sends its surplus forward; the front hires and attacks with what gathers.
2. **Faction collapse.** A fallen capital hands over the whole faction on a 1-in-(drive/10) roll (`game._conquest`, the calculated battle). Cornering the daimyo is the hard part: in a fought battle the lord usually flees if he can, so this term is worth less once battles are fought.
3. **The weak starts' openings, baked in:** Saito-type fiefs need their special opening (#45-#47, ev) to reach the expansion phase at all.
4. Speed knobs: the home shield at the budget line rather than the men; "biggest neighbour removed" in the value. Check plague's share of the invasion deaths.
5. Fought-battle odds for the attacker (an attack doctrine); the 70-year runs use calculated battles throughout.

### #47 — A second objective: survival first, then income (Chris, 2026-11-11)

**`ev.ECON`.** Among moves within EPS of the best survival, take the most harvest income at the horizon's end (`ev.income_capacity`: gold + rice a harvest brings in before upkeep, the marks re-seeded, mean rolls), then the most gold and rice kept. The economy step is scored applied, so tax-then-give plans compete with it. The measure is income, not the Economic Index: the vault records that the index rewards balance and misses the peasant shortcut (#36). Bench (Chris: strong fiefs, longer games; no expansion, so not full games): skill 1, 6 years, 50 seeds, doctrine battles; `evS` = survival only with riots and tax moves, `evE` = + plans, peasants and ECON. Income is the mean over the living.

| fief | player | alive | income y1 | y2 | y3 | y4 | y6 |
|---|---|---|---|---|---|---|---|
| Oda | reader | 47 | 257 | 455 | 726 | 1075 | 1833 |
| | evS | 48 | 257 | 455 | 726 | 1068 | 1817 |
| | evE | 49 | 341 | 580 | 863 | 1258 | 1758 |
| Tokugawa | reader | 41 | 255 | 450 | 709 | 1028 | 1801 |
| | evS | 42 | 246 | 381 | 571 | 837 | 1539 |
| | evE | 41 | 340 | 520 | 790 | 1091 | 1691 |
| Hojo | reader | 29 | 233 | 359 | 546 | 828 | 1628 |
| | evS | 33 | 154 | 273 | 381 | 549 | 1097 |
| | evE | 33 | 178 | 335 | 489 | 721 | 1368 |
| Imagawa | reader | 34 | 210 | 344 | 540 | 823 | 1688 |
| | evS | 42 | 137 | 284 | 400 | 572 | 1131 |
| | evE | 39 | 247 | 407 | 583 | 848 | 1468 |

- **The margin thesis holds** (vault: *The Margin Sets the Intelligence*): on the strong fiefs survival does not depend on the player (47-49, 41-42); on the mid fiefs the EV players keep 4-8 more.
- **The second objective works for four years**: ev-econ leads on income through year 4 on every fief (Oda +33% in year 1, +17% in year 4), and on the mid fiefs it wins back most of what survival-only spends on men. Imagawa: more survivors than the reader (39 against 34) and more income through year 4.
- **The reader overtakes by year 6 everywhere, and the trace says why: defence, not myopia** (my first guess, that the projection never reinvests, was wrong). Oda, 6 games, moves by season. Reader, every year: Spring gold to the peasants (tax +35 once), Summer rice to the peasants, Fall and Winter train. ev-econ, years 1-3: the same gifts, but the gold gift moves to the Fall, straight after the harvest, plus tax-then-give plans. **ev-econ, years 4-6: Fall hire (11 of 18), Winter morale (10 of 18).** The hire dilutes morale and the morale buy repairs it. The growth schedule lifts every neighbour's target 40 men a year, and survival scores those hires above the gift by more than EPS. Real survival barely differs (49 against 47), so either the defence is worth about two games, or the threat is overstated: the projection grows the neighbours without their wars or losses, and it prices battles on Saito's odds table. Per-fief odds tables, and a test without the late hires, would separate the two.

**The hunted gate: economy by rule, defence by forecast** (Chris: the economy was well tuned; the hard part is knowing when to react to neighbours getting larger; once past being hunted, the route to maximum economy is straightforward). `ev.HUNT_GATE = N`: when no neighbour picks him now and `forecast.threats_in` finds none within N seasons, the reader plays the season; otherwise the scorer (survival, then income) decides. Same bench, against the reader. Income is paired (games alive at year 6 under both), so a player that keeps weaker games alive is not charged for their lower income:

| player | alive /200 | Oda | Tokugawa | Hojo | Imagawa |
|---|---|---|---|---|---|
| reader | 151 | | | | |
| **gate N=2** | **158** | -0% | -2% | -5% | -6% |
| gate N=4 | 163 | -1% | -5% | -15% | -12% |
| ev-econ, no gate | 162 | -3% | -6% | -15% | -11% |
| ev-survival | 165 | -1% | -14% | -32% | -30% |

The warning horizon is a dial between survival and income. Strong fiefs pay almost nothing either way (Oda keeps the reader's income at every setting). The mid fiefs buy survivors with income, more dearly at each step: N=2 gives +7 for about 5%, N=4 +5 more for about 10% more, pure survival +2 more for about 30%. N=4 ties ev-econ on both axes, so ev-econ acted on warnings it did not need. **N=2 is the efficient point:** most of the survival gain at almost the reader's income. Which point is best depends on what income buys later; with expansion, income becomes conquest.

**What is left is the opening, and one self-inflicted gate** (2026-11-12). Every death on the bench, under every player, is an invasion. Of the reader's 49, 31 come in year 1 and 18 later; the scorers cut the later ones to 7-9 but year 1 only to 28, and 12 of those 28 fall before the player's first command. Three deaths every player shared were rice 1 beside a full army (Tokugawa Summer 1560 twice, Oda Summer 1562): the Summer gift gave the rice above the upkeep to the peasants (75 -> 1), the fief was not hunted when it gave, and an AI moving later that season passed the budget gate (min(rice, men) = 1) and won against an army with a day of rice. The gift opened the gate it was outside of.

`policy.OPENING["shield_rice"]` (reaction.economy and the reader's cliff gift, Chris): the gift never takes the shield down; hunted and short, buy rice back to the men first (`_rice_slack(targeted=True)`). Mode 1 keeps rice at the men; **mode 2** keeps only past every enemy neighbour's budget (capped at the men). Paired, same 200 games:

| player | alive | saves/losses | income y1 (Oda/Toku/Hojo/Imag) | y6 |
|---|---|---|---|---|
| reader -> reader + shield 2 | 151 -> 155 | 5/1 | -35/-27/0/0% | -2/-3/-6/-7% |
| gate N=2 -> + shield 2 | 158 -> 161 | 4/1 | -35/-27/-1/0% | -2/-7/-12/-7% |
| gate N=4 -> + shield 1 | 163 -> 164 | 3/2 | | -4/-12/-22/-14% |
| ev-survival -> + shield 1 | 165 -> **169** | 4/0 | | -4/-23/-28/-20% |

Mode 2 against mode 1: same survivors, 1-2% more income. The year-1 cost is the strong fiefs' first gift, which was feeding their first harvest; by year 6 it is mostly paid back. Against the reader, gate N=2 + shield 2 saves 11 and loses 1.

**Mode 3: three states, not two** (Chris). *Safe*: no enemy neighbour's share of men passes 47, nobody can pick him, give freely. *Huntable*: some neighbour passes it, picked today or not; the gift stops at the budget gate, and short rice is bought back. *Hunted*: the threat rows. `hunted_by` (picked now) was the wrong test for the gift: Tokugawa was nobody's pick when it gave, Imagawa's share was 52. Paired:

| | alive | saves/losses | y1 income | y6 income |
|---|---|---|---|---|
| reader -> reader + shield 3 | 151 -> 156 | 6/1 | -35/-26/0/0% | -1/-3/-5/-6% |
| reader + shield 2 -> 3 | 155 -> 156 | 1/0 | 0/+1/0/0% | +1% each |
| gate N=2 + shield 2 -> 3 | 161 -> **162** | 1/0 | ~0 | -1..+3% |
| ev-survival + shield 1 -> 3 | 169 -> 166 | 1/4 | ~0 | +3/+12/+35/+5% |

The year-1 cost does not move: the strong fiefs start huntable (Oda and Tokugawa within the share line of each other), so their first gift really was the risk, not caution. Mode 3 is the rule for the reader and the gate; ev-survival keeps mode 1 if survival is all that counts (3 games is inside the noise either way). Against the reader: gate N=2 + shield 3 saves 12, loses 1 (162/200).

**What the gate leaves after mode 3, by cause** (gate N=2 + shield 3: 38 deaths; 12 before the first command). At the player's last turn before each of the other 26, the attacker had the same men in 25 of them: the rival does not hire then strike (once). The player's men fell instead: **16 pile-ons** (an attack held, the battle bled men, a second attack the same or next season finished him), **7 plague** (events, before anyone moves: men to 50-99%; a huntable neighbour passes the share line and comes that season), 3 straight losses at 67-86% share. Chris: neither is a policy problem. A pile-on is decided at the gate (do not get gated) or in the battle (win men); plague insurance is a doubled army at a 50% hit, and the 1-in-50 baked in adds 0.6-2% that does not save you when it hits. Variance, left as it is. The EV scorer misses both by design: it counts only neighbours picking him now, a held battle costs no men in its forecast, and plague is not in it, so a longer horizon could not have helped.

**Mode 4: turn order** (Chris). The player sees who has moved (`m.acted`). Huntable, but every neighbour past the share line has already moved this Summer: the next move that can punish the gift comes after the Fall harvest, so the gift goes as low as the harvest (every roll at its floor) still lifts the rice back to the men (`after_harvest_room`). Paired:

| | alive | saves/losses | income y1 | y2 | y6 |
|---|---|---|---|---|---|
| reader + shield 3 -> 4 | 156 -> 157 | 1/0 | +12/+6/0/0% | +6/+4/+7/+9% | +1/+2/+2/+2% |
| gate N=2 + shield 3 -> 4 | 162 -> 162 | 0/0 | +12/+5/0/0% | +6/+4/+6/+8% | +1/+2/+3/+1% |
| reader -> reader + shield 4 | 151 -> **157** | 6/0 | -27/-22/0/0% | | -0/-1/-3/-4% |
| reader -> gate N=2 + shield 4 | 151 -> **162** | 12/1 | -27/-21/-8/0% | | -1/-7/-11/-11% |

Free income, no survivors lost. **Shield 4 is the rule.** The reader with it keeps 6 more alive at the old reader's year-6 income.

**Typhoons do not need a model** (Chris asked whether dams should be chased as flood insurance). The typhoon (appendix-events) hits each fief 3/40 in half the Summers, 3.75% a year: output x= 0.9*dams % (dams 100 still loses 10%), wealth -1..4. Priced with the harvest itself (`ev.income_capacity`, tax 55, the bench starts): expected cost **0.2-0.5 income a year** out of ~170-215, and dams 100 only halves it. Per gold, a year's income: give 1.5-2.1, build (town) 0.3-0.6, dam 0.07, grow 0-0.13. Output x dams feeds only the rice term, and the reader's income comes from the loyalty and wealth marks the gifts lift. Dams matter only after the gifts cap ((wealth+loyalty)/2 >= header), and even then Build pays about 5x more at these outputs. The typhoon's cost scales with output (dams' value with sqrt(output)), so it matters only for a fief grown into the hundreds, and only for income, never survival.

### #46 — The EV player: Saito's commands priced, not ordered (Chris, 2026-11-11)

**`na1sim/ev.py`, `deaths.py --tail ev`.** Each command is chosen by the survival it buys over the next four seasons, from #45's parts: revolt by the formula, invasion by `reaction.threats` (the ROM's own pick), with each threatening neighbour attacking **65% of seasons** (measured: 1 threat .65, 2 .89, 3+ 1.00), committing its budget × 60-89% (daimyo-led, a coin from a capital) or 50-69%, against the odds table (`na1sim/odds.py` → `odds_f8.json`). A horizon that crosses a Fall runs every fief's real harvest at mean income. A future Summer command buys the least rice; rice 0 after it scores 0. The candidates are morale, hire all, hire to the picker line, Summer rice, or nothing (then the reader's economy step, `reaction.economy`, factored out of `reader_policy` with no change to it). Ties within 0.003 go to the move that keeps the most gold and rice.

Saito, skill 1, 3 years, doctrine battles, against `reader` with `summer_rice_first` + `line_first`:

| | tuning 3000-3299 | fresh 4000-4299 | total |
|---|---|---|---|
| reader | 22 | 18 | 40 (6.7%) |
| **ev** | **26** | **24** | **50 (8.3%)** |
| ev, the reader's move as candidate and fallback | 21 | 20 | 41 |

Nothing was fitted. The parts are formulas or one-off measurements, and the fresh seeds gain as much as the tuning ones. **What the scorer sees that the rule order did not:** spending all the Spring gold (on morale *or* men) leaves nothing for the Fall upkeep (men/2 from gold), so the upkeep dismisses men and more neighbours pick him (seed 3093: 3 threats become 6); hiring just to the line kept 22 gold and left no threat. **What it still misses:** 4-5 revolt deaths against the reader's 0-3. Morale lasts beyond a four-season horizon, so the morale fix is undervalued, and the income that loyalty and wealth buy is not in the score at all (4240, 4275: morale on turn 1, then the economy never grew and the year-2 upkeep cut him to 12 men). The 157-172 games decided before his first command are untouched.

**End-of-horizon value by a longer horizon: it does not work, and why** (same seeds). `HORIZON = 8` reaches the second harvest, where loyalty and wealth pay as income and next year's upkeep dismisses unpaid men; `PEASANTS` adds the gold-to-peasants move. ev8 44, ev8 + peasants 44 (peasants never chosen), against ev 50. Separately, a relative tie tolerance (`EPS × top`) gave 46: shrinking the tolerance at small scores starved the keep-most tie-break, so it stays absolute. The cause shows in 4240: the 8-season score for the turn-1 morale buy was 0.93, and he died at the second Fall. **The projection holds the world still.** The neighbours harvest but never hire or develop, so the far end of a long horizon looks safe, and a long horizon cannot price what pays late (income, peasants). A longer horizon needs the neighbours to move: either a measured growth rate, or their real commands (the ROM's own AI, which the sim runs exactly). Defaults stay `HORIZON = 4`, `PEASANTS = False`.

**The neighbours moved: the AI recruit schedule in the projection** (Chris: hiring runs on a schedule). `GROWTH` applies `ai_vm.recruit_arm_train`'s recruit in expectation each projected season: about 90% take the military pass; below min((year−1559)×40, cap) men, recruit with probability (skill+3)/10, hiring min(half the gold surplus ×10/rate, room to (year−1559)×100) and paying the half-surplus; the year rolls at Spring. First, what the late attacks are (300 games, ev, 149 attacks after his first command): 95 were already threats at his last command (73 right after the first), 30 a pick flip or the 1-in-100, 14 his own shield falling, 10 the attacker's budget growing. **Only 1 came with the attacker hiring men**: the 1560 cap is 40, so early on the AI barely recruits. The schedule works through *relative* standing. In 4240 the killer (budget 77) was not picking him in the frozen projection; two years of everyone else growing made him its weakest neighbour. Results, alive of 600: ev 50; ev + growth 52; **8 seasons + growth 53** (the frozen 8 seasons gave 44); + peasants 53 (never chosen). The gains over 50 are a few games, inside the noise; the clear effect is that growth turns the long horizon from worse (44) to level or better (53). Revolt deaths rise to 6-7 of 300: with the neighbours growing, men gain value over morale. New defaults: `HORIZON = 8`, `GROWTH = True`. Still open: income is never worth buying (peasants never chosen), so the economy is not yet priced.

**The projection is shared plumbing now: `na1sim/forecast.py`** (Chris: growth matters for every fief; an economy that builds while the neighbours grow gets invaded). `step` advances one projected season (the year roll, the AI recruit schedule, every fief's harvest at mean income); `held` undoes anything done inside; `projected(m, n)`, `threats_in(m, idx, n)` and `neighbours_in(m, idx, n)` answer *who picks me, and how big are they, n seasons from now if I stand still*. `ev.survival` runs on it (regression: 28/300, identical causes). On Saito's start, the three big neighbours' budgets shrink over three years (fief 4: 124 to 64): their men stay level while the upkeep outruns the harvest. The forecast does not model AI building, arming or wars, so that part is approximate.

**Pricing income (Chris: price income properly).** Why the peasants move was never chosen: **a projection bug.** Harvest income is computed from low-water marks that Summer re-seeds from the live stats (`game.reset_marks`, $A066), and `forecast.step` did not re-seed them, so loyalty or wealth bought in the projection never paid. Fixed (`marks=True`). With it, on Saito's start (income 17 gold / 12 rice, upkeep 19): 28 gold to the peasants makes 28/23 a year; tax 55 alone 41/27; **tax 55 then the give 72/58, against give then tax 61/47** (Chris: the gift lands on a lower base; the tax cut is a percentage). The same holds from loyalty 50 (74/60 against 64/50) and 70 (76/62 against 66/52), and from 70 the season between costs nothing (loyalty 46). **Riots, measured on his capital** (`game._riots`): the sim's human pays all his gold (`RIOT_PAY`), which settles a riot only if loyalty ends above 25 having risen more than 5; unpaid, the staged battle is fought against the fief's **output** (plus up to half the men when charisma < 70 + rng(skill)). With output 28 against 38 men he wins 99-100%, so a riot costs Saito his treasury, not his fief. It turns deadly where output outgrows the army, and on the second riot, when the gold is gone (Chris). New `ev` switches: `RIOTS` (riot risk priced, tax moves offered), `RIOT_SETTLE` (the settle rule and an output-sized battle on the odds table), `PLANS` (two-move plans: tax now and give next season, or the reverse), `PEASANTS`. Results, alive of 600 (8 seasons + growth): marks fix 53; + peasants 54; **+ riots and tax moves 57** (32 + 25); + settle, + plans, + peasants: 57, the same games. **Why the refinements cannot show on Saito:** of 553 decisions in 300 games, 267 had a best score ≥ 0.99 (every move survives, so they tie and the reader's economy step decides, which already taxes as loyalty allows and gives in Spring), 139 ≤ 0.01 (nothing helps), and only 147 lay between. Income moves were taken 22 times and changed no outcome. A survival score is blind exactly where the position is safe: the margin thesis inside one game. The fix is a second objective for when survival saturates (economic value at the horizon's end, e.g. Chris's Economic Index Σ∛(town·output·wealth)), judged on longer games or a stronger fief. Defaults: `MARKS` on (no change at 53), the rest off.

### #45 — Saito's choices priced from the formulas: revolt, rice 0, battle odds, and the daimyo's doubling (Chris, 2026-11-11)

**Chris: every early choice is an expected value on the current state; derive it, and use the sim to check.** These are the parts. Saito at start: 38 men, morale 21, 29 gold, 25 rice, charisma 102 (so morale alone sets his revolt eligibility).

- **Turn 1.** Gold into morale gives 41 at any rate; a hire blends in recruits (morale 40-59) and reaches about 31 at the cheapest rate (+20 men) and 25 at the dearest (+6).
- **Revolt.** The chance a revolt lands on him is about 0.15 × eligibility per season (Summer half); Appendix D is corrected. That is 12% at morale 21, 8% at 31 and 2.6% at 41. For a human capital a revolt is a staged battle, which he loses about a third of the time **whatever his morale** (24% at 24 men, 36% at 38, 42% at 58, 200 fights each): the rebels' stats are 40-59% of his, so he takes every comparison anyway. Morale only decides whether the revolt fires. Dying of revolt per year, until the first one: about 15% at morale 21, 10% at 31, 3% at 41. A won revolt lifts morale 30+, which ends the risk.
- **Rice 0 after the Fall harvest is death**, not a smaller army. Upkeep takes min(gold, rice) when short, so short rice goes to 0; the attack gate (`min(defender rice, men)` against the attacker's budget) then passes for every neighbour; and `battle_init_defender $92CA` makes a rice-0 defender lose before the battle starts. Forcing his rice to 0 after the year-1 harvest (gold untouched, 300 seeds): **52 of 52 dead that Fall**. Rice 1-9 lost 2 of 5. Rice is a hard limit, not a trade: the EV is only over the gold left once the harvest is safe.
- **Battle odds** (200 real starts on Saito, his men 20-130 × the committed men 20-250, his rice at 30 days, the doctrine, no retreat; 19,800 battles). The ratio decides it. Holds, by attacker/his men:

  | ratio | <0.75 | 0.75-1 | 1-1.25 | 1.25-1.5 | 1.5-2 | 2-2.5 | 2.5-3 | 3+ |
  |---|---|---|---|---|---|---|---|---|
  | daimyo-led | 100% | 87% | 51% | 23% | 15% | 12% | 13% | 12% |
  | a general | 100% | 100% | 89% | 63% | 25% | 10% | 1% | 0% |

  Weighted by the real commits (40-120 men, mostly 80-100): he holds 19% at 30 men, 26% at 40, 35% at 50, 50% at 60, 65% at 75, 80% at 90. About a point of holding per man in the 40-60 range, so the cheap hire (38 to 58) is worth about 20 points if he is attacked. A first estimate puts the turn-1 crossover at a hire of about 10 men (a rate of about 25-30), to be checked by the EV player.
- **Why a daimyo-led attack does better at close odds.** Not his stats: both kinds take 92 of the 100 weight points against Saito. It is the strength formula. `ai_eval_battle_strength_total $9C88` adds a unit's men again when its **side's** bit7 is set. The defender's bit is "this fief is a capital"; the attacker's is the daimyo-led bit, a coin (`rng_mod(2)`) when the AI attacks from a capital. Oracle `combat_tactical_check` gained two daimyo-led cases: a 10-man attacker unit is 29 without the bit and 39 with it, ROM = sim (21/21). Ch.17 said the bit was the defender's only (written before the attacker's meaning was known) and is corrected. Clearing the attacker's bit on the same starts (his men 50) takes Saito's holds from 56% to 92% against 50 men, and from 31% to 82% against 60. So the daimyo cancels a capital's doubling, and against a non-capital he doubles outright. His cost is the kill or the flight (ch.21). That cost sets the 12% floor, and an AI daimyo flees before it costs him his faction. **When to bring the daimyo:** odds close to even, against a capital. Against a 2:1 edge he adds little and risks everything.

**Next.** An `ev` tail on these parts: rice first as the hard limit; then revolt (formula), the picker line (`men_line`) and this odds table for the leftover gold. Compared with `reader` (22 tuning / 18 fresh) on the same seeds.

### #44 — The setup can be steered: the entry atlas, two endings the sim had wrong, Echigo and Mino (Chris, 2026-11-11)

**Why the attackers' setups looked so varied** (Chris: more variety than the rules implied). The rules hold; most of the variety is built in. By entry side, on the 299 captured Saito invasions and 50 redraws of each start's dice: **north, south and west**, the commander and two guards form a fixed three-cell block at one of two places, chosen by `rng_mod(2)` (the other flip is forced by the side); **east**, all five units drop at random (the mirrored scan of #43 never finds a cell, and the guards are only placed after a successful scan); **slots 3-4 always drop at random**. The coin is a plain draw, not terrain. Terrain moves the landing instead: on **12 of the 28** scanned entries in the 17-fief scenario, water, mountains or the castle ring cover a corner and push the commander along the scan (Noto from the west lands on (1,4) or (1,2); Iseshima from the north on (9,0) or (0,2)). In the real game the dice are frame-driven (`syscall_rng_next` $C1C3), so the attacker's whole setup depends on the frame of the player's last placement press: a TAS lever, not a player's.

**The entry atlas** (`tools/battle-entry-atlas.py`, `assets/maps/battles/entries/`): every fief, every side it can be invaded from (with the neighbours using it), every coin outcome, drawn on the fief's true-colour map with the units as the game draws them (`tools/render-battle-setup.py`; `draw_unit_count_digits` $89DF stamps a 4x2-tile overlay: the slot digit, or tile 178/179 on the commander for a daimyo or a general, the side's 3-tile flag, the men). Everything comes from the sim's ROM transcriptions run with the flips scripted; the one real start in `traces/` (`b2-startbattle.dmp`, Mino from the east) matches the east rule.

**Two endings the sim had wrong** (both oracle-checked against the bytecode; `oracle_vm` 21 / 21):
- **A daimyo-led attacker who loses hands his whole faction to the defender.** `apply_conquest_outcome` $E117 tests the *loser's* daimyo-led bit, and `reassign_fiefs_to_conqueror` $DED4 works in both directions; the sim had only the attacker-won half (`conquest[atk-lost-daimyo-led]`). Killed, starved or timed out, any defender win against a leading daimyo takes his faction (Chris's experience: kill a daimyo who leads his army and his fiefs come with him).
- **AI daimyos never fled.** The flight builds its destination list in `$6F4F` after `load_fief_neighbor_list` $DAAB of the defending fief; the sim read the buffer stale, so no AI daimyo ever left a battle (`combat_flee_check`, 4 / 4). The rule: at the start of his own action, a daimyo-led commander flees when **his unit's men doubled are under the men of the enemy units adjacent to him** (`build_reachable_enemy_target_list` $A0F3, the six neighbouring cells), **or** his side's rice is under two days' ration (`side_has_rice_for_day` $836A, ceil(men/15)). A flight clears the bit (`end_war_relocate_capital` $8F55), so it never pays the faction; both armies' survivors, rice and gold still garrison the defender.

What that means, measured at Echigo: the AI commits rice equal to its men, 30 days, so a daimyo-led attacker **flees for rice around day 28 and never reaches day 30**; the faction comes only from a kill. Per daimyo-led invasion, the mean change in Uesugi's holdings: killed, +1 fief (Musashi), +65 men, +185 rice, +111 gold; fled, +32 men, +62 rice, +80 gold. Crowding his commander is what makes him flee (Chris's practice: hold the killing blow until the strike can come in one round).

Every whole-game figure before this entry (#36-#43) was measured without both rules. Rerun: Saito, skill 1, 3 years, 300 seeds, default **1.7%** (was 0.3%), `reader_policy` **3.7%** (was 1.3%), reader with the doctrine fighting his battles 5.0%. All 17, 6 years, 300 seeds: skill 1 mean **68.1%** (Uesugi 91.3, Hojo 69.3, Hatakeyama 14.7, Honganji 15.3, Tsutsui 15.7, Saito 1.7, Rokkaku 0.0, the other ten 86-99); skill 2 **63.3%** (Hojo 45, Honganji 6, Hatakeyama 2, Tsutsui 1, Saito 1, Rokkaku 0, the rest 82-100).

**Echigo: the defender decides the setup** (ring terrain: the castle (5,2) inside a corridor along row 1, the attacker's strips outside it). From the **south** (Hojo, 120 of 129 invasions) only (0,2) and (10,2) are open in the scanned row: commander on the seat, units on (8,1) (7,1) and (2,1) (3,1), and whichever way the coin falls two of ours are 2 hexes from his commander along row 1, which his random drops can never reach (it is outside his strip). From the **west** (Kaga, Shinano), all five on (0,1) (0,2) (1,1) (2,1) (3,1) fix the **whole** enemy layout (commander (0,4), guards (0,3) (1,4), random drops on (2,4) (3,4)), sealed in his corner (Chris); our commander walks home from (3,1) in 2 days, since the cover only matters while he deploys. `na1sim.plans.PlanPlayer` and `na1sim.plantrial` (paired replays, the attacker's men and rice scaled), 116 captured invasions on the fixed sim, held / fiefs gained:

| attacker | AI no retreat | strike | hold | run |
|---|---|---|---|---|
| x0.5 | 96 / 15 | 97 / 7 | 96 / 7 | 94 / 11 |
| x1 | 92 / 19 | 93 / 7 | 93 / 14 | 73 / 6 |
| x1.5 | 72 / 15 | 80 / 13 | 78 / 14 | 43 / 2 |
| x2 | 58 / 6 | 58 / 4 | 58 / 5 | 21 / 1 |
| x3 | 24 / 2 | 32 / 3 | 32 / 3 | 3 / 0 |
| x4 | 9 / 1 | 17 / 2 | 17 / 2 | 2 / 0 |

For holding the fief there is **no size at which decapitation gets too risky**: strike is best or tied everywhere and its edge grows with the attacker; running never wins (30 days of rice outlast the clock). For the faction it goes the other way: strike makes the Hojo daimyo flee (35 of 51 at x1); *hold* (a unit steps next to him only while our adjacent men stay at or under twice his) doubles the kills; the AI's own, less crowding play kills the most at x1. A weak daimyo-led attacker (x0.35) flees from any single unit next to him, so only staying away keeps him in the battle. About a seventh of the daimyo-led battles are lost to Echigo's own rice running out, whatever the plan.

**Mino: the spiral and the gate** (Chris: a counter-clockwise spiral ending at the castle; force the attacker to start far for a starve plan). Days of march to the castle (6,1): the top right is 20, then down column 10, west along row 4, up column 0, east to the castle. His commander's landing on the two coins, by side: north (0,0) 6 days or (10,0) 20; south (0,2) 7 or (10,2) 18; west 3-10 everywhere; east random, 14-20. **Three units force the far end on both coins**: north (0,1) (2,2) (3,0) puts him on (10,0)/(9,0), 20 days; south (0,0) (0,1) (2,2) on (10,2), 18 days; the fourth unit must stand east (e.g. (6,3)) or a near landing reopens; the west tops out at (3,4), 10 days. And **(3,0) is the castle's one gate**: its only outside neighbour is (2,0), so the castle is fought one unit at a time. The starve plan as built (far push, then hold the gate) at the 20x5 start holds 51 of 317 against the strike script's 55. It delays the loss (north from day 18 to 25), but only the commander and his guards are pushed (slots 3-4 drop 8-11 days out, in the north even inside the gate on (4,0)/(4,1)), the west attacker starts at the gate, and these armies outnumber Saito 2-3x with 30 days of rice. **What works is one-man units as scan tokens**: the scan reads where units stand, not their size, so with the 96/1/1/1/1 Assign four one-man units steer the landing while the commander keeps the army on the castle. Held of 317: AI 39, strike script 96, gate 108, **far push + hold 114** (west 40 against 22; at 2-3x men 45 against 27), the best Saito battle figure yet. **But the Assign does not pay in whole games** (Chris expected it to lose to buying men). Saito starts with 29 gold on every board, so a turn-1 Assign (30) is impossible. Assigning 96/1/1/1/1 at the first command that can afford it, with a battle player that uses the far-push hold plan once the split is heavy and the doctrine otherwise (`plans.BySplit`, `deaths.py --tail reader_assign --combat plan8:hold:bysplit`): skill 1, 3 years, 300 seeds, **1.7%** alive against **5.0%** for the same player without the Assign; all the gold into men on turn 1 gives 1.0%. The turn and the 30 gold cost more than the better battles return.

Half of Saito's invasions are daimyo-led (150 of 318): Tokugawa from the south 41, Takeda from the east 34, Asakura from the north 32, Oda from the west 30. The AI defence never kills one (its 20 holds against Takeda are all his flights, mostly for rice), so every leader kill is a faction left on the table.

**Open.** Pushing slots 3-4 back in the north (they land behind the gate). A decapitation chokepoint against Oda from the west. A hold rule that estimates a one-round kill. The run plans by side (Chris: from the west at Echigo, slide everyone right in step; from the south, circle the castle away from him).

### #43 — The pocket, tested: decapitation pays to about 2:1, and the sim had the wrong armies (Chris, 2026-11-10)

**The sim's unit split was wrong for every fief.** `setup.build_board` seeded `province_unit_type_pct` $76A9 with 50/5/5/5/5 (sum 70), half of `ai_reinforce` $960C's rare reseed (which adds 30 and sums to 100). The scenario's record is **20/20/20/20/20**: every SRAM dump in `traces/` (six, 1560-1562) has the player's fief at 20x5 and the AI's at about 32/27/20/10/11, which is $83E2's `init_daimyo_arms_record` $839A (rows 3-4 into 0-1, AI fiefs only) applied to 20x5 (Chris: the player starts 20x5 until an Assign, which turn 1 cannot spend). Fixed by seeding 20x5 before the ROM's own $83E2 runs; its RNG draws are unchanged, and a built board now matches the dumps. **Every tactical-battle figure before this entry was measured on the wrong armies**, including #36-#42: Saito, skill 1, 3 years, 300 seeds is now **0.3%** default (was 2.0%) and **1.3%** with `reader_policy` (was 4.7%), with his battles still fought by the AI logic.

**The harness.** `na1sim.battles` saves the start of every battle the human defends and replays it bit for bit (Saito, recaptured on the fixed board: 357 / 357). `na1sim.strike` adds a human player: `tactical.HUMAN`, gated where the ROM hands a side to the player (`battleside_not_state5_or_resting`), deploying as `player_interactive_unit_move_loop` $9A18 (any free, unblocked cell, slot order) and fighting through `human_command_loop`, a transcription of `combat_command_dispatch_loop_per_unit` $AC7F with Move / Attack / Pass. Move and Attack each return 0, so a unit gets one of them a day (Chris: attack is moving into the enemy's cell). Off by default; the default path replays bit-exact.

**Correction to #42: the scan reflects off the strip's max.** `rng_search_combat_rect_for_unit_cell` $9954 reverses with `x = flip ? xi : x_max - xi` (C and transcription agree). From the **east** (x 7-10, flip_x forced 0) every scanned column is 3..0, outside the strip, so an eastern commander *always* falls to the random drop, uniform over the free strip cells and with no check for our units. From the **south** (y 2-4, flip_y forced 0) only row 2 is scanned. North and west scan from one of two corners. On the captured Saito invasions: E 87 / 87 random (14 cells), N 60 / 60 on (0,0) or (10,0), S 69 / 69 on (0,2) or (10,2), W 83 / 83 on (0,0) or (0,4) (one (0,3)). #42's east pocket and blanket at Mino assumed a scan and do not apply. The exposure differs by fief and entry (Chris: Noto can only be attacked from the south); a cross-fief sweep is open.

**The arms** (299 invasions, paired, the human never retreats): *control* (the AI's placement plus the strike script: a unit next to the enemy commander attacks him, a striker otherwise steps toward a free cell next to him, anything else runs the AI logic); *single* (one striker placed to engage by day 2 from either corner, the rest beside the seat); *contact* (maximise P(any unit engages by day 2)); *pocket* (force one landing cell on scan edges, maximise the units that engage it); *lead* (the pocket with Saito's commander striking too).

| held | AI | AI, no retreat | control | single | contact | pocket | lead |
|---|---|---|---|---|---|---|---|
| all 299 | 18 | 31 | 51 | 24 | 28 | 27 | 8 |
| days of food under 20 (34) | 11 | 23 | 28 | 9 | 3 | 3 | 1 |
| 30 and up (265) | 7 | 8 | 23 | 15 | 25 | 24 | 7 |
| attacker 60-80 men (50) | 0 | 0 | 7 | 0 | 6 | 6 | 0 |

**The doctrine, measured: 53 of 299 against the AI's 18.** Short-fed: hold the castle (control: strike only what comes next to you). Long-fed: contact. The best arm per battle would hold 65. Pocket vs single, paired: +14 / -11 overall, +13 / -4 on long food, +5 / 0 from the north (Chris's resilience reading: several units around the landing outlast one striker). Sending the commander out (*lead*) loses the castle and him.

**How far decapitation reaches** (long-fed attackers, doctrine vs AI, by attacker:defender men): under 1:1, 6 / 9 vs 4; 1-1.5, 7 / 20 vs 3; 1.5-2, 6 / 38 vs 0; 2-3, 6 / 163 vs 0; 3 and up, 0 / 35. Even or better wins most, the defender's edge stretches it to about 2:1, and past 3:1 starvation is the only hope (Chris's expectation for big armies).

**Assign is the big lever** (Chris: a player has 20x5 until he spends a turn on it; the AI reshapes for free). Grounded and oracle-checked: `effect_assign` (bank 1 $AC11) edits $76A9 + fief*5, the split the battle deals men by; the editor moves points between rows (the commit, `commit_arms_record_from_buffer` $ABBD, is cancelled unless the pool is 0), keeps row 0 at 1 or more, and lets row 2 rise only under arms/50 + 20. Now in the sim as `vmprims.driver_assign` (men > 0, 30 gold debited on a commit), `assign_reachable`, `commit_arms_record` (`oracle_vm.assign_commit_check`: 4 / 4 MATCH vs the bytecode). The same audit found the sim's `apply_conquest_outcome` missing the musket cap the ROM applies after merging the forces (`cap_arms_at_index` $E08B; also after Move and Hire, which the sim had): fixed, and `combat_conquest_check` now diffs the split (5 / 5 MATCH, 20 / 20 routines). **The AI's free reshapes:** `init_daimyo_arms_record` at setup (AI fiefs only, about 32/27/20/10/11) and `ai_reinforce` $960C's reseed (50/5/5/5/5 plus six +5s, 1% a turn); the player gets neither.

The sweep (`strike.py --split`, the 299 starts, held):

| split | AI, no retreat | control | single | contact | pocket |
|---|---|---|---|---|---|
| 20/20/20/20/20 (start) | 31 | 51 | 24 | 28 | 27 |
| 40/15/15/15/15 | 35 | 63 | 47 | 36 | 29 |
| 60/10/10/10/10 | 50 | 76 | 61 | 49 | 43 |
| 80/5/5/5/5 | 61 | 85 | 79 | 79 | 64 |
| **96/1/1/1/1** | 78 | 83 | **96** | 80 | 77 |
| 70/10/20/0/0 | 69 | 68 | 83 | 64 | 61 |
| 1/40/20/20/19 | 25 | 36 | 21 | 26 | 38 |

Everything in the commander on the castle seat wins most: 96/1/1/1/1 with one one-man striker holds **96 of 299, five times the AI's 18** (66 of the 265 long-fed). The castle commander is the piece the battle turns on (Chris: the castle is a big defence piece). The pocket is best only when the men are in the strikers (1/40/20/20/19: pocket vs single +25 / -8 on long food, Chris's multi-unit resilience), but an empty commander loses more than the pocket saves. The catch is the turn: an Assign costs an action and 30 gold, and Saito is attacked before his first action in about half his games.

**Wired into whole games:** `strike.Doctrine` (short-fed `control`, long-fed `contact` by default; rebels and the player's own attacks `control`) as `tactical.HUMAN`, with the human never retreating: `deaths.py --combat doctrine` (or `--combat SHORT,LONG`). Smoke-tested only (Chris: no reruns needed; he expects little from no-retreat alone: a retreat is an instant loss, but fighting on often ends to the man, or so small the fief falls that turn or the next).

**Open.** A policy that spends the Assign (when, and to what: 96/1/1/1/1 against a wait-and-see 20x5). Bribe (`resolve_attack_apply_casualties`: morale + Charisma + rng vs morale + Charisma + 2·skill, defectors join the commander; it re-prompts, so possibly once per turn at no action cost): parked (Chris: little hope for Saito's poor troops and gold, probably worse; worth knowing exactly). The landing model ignores his random slots 3-4. The setup's variety and how far it can be steered: #44.

### #42 — The battle is chess: deployment, the AI retreat, and decapitation (Chris, 2026-11-10)

**Deployment, from the ROM.** The defender sets up first (`battle_init_defender` ends `cur_combat_side = 1`, $935C; `deploy_both_sides_units_loop` $9B07 starts from it), and since each day's loop flips the side twice, the defender also acts first every day. A human side places interactively (`player_interactive_unit_move_loop` $9A18); an AI side runs `ai_place_combat_units_random_or_smart` $99D2:
- **AI defender:** the commander (slot 0) on the castle seat (`find_free_tactical_placement_cell`, the first castle-bit cell). If the attacker out-strengths it, the rest ring the seat; otherwise they drop on random cells.
- **AI attacker:** confined to an entry strip set by the compass bearing between the fiefs (`set_combat_arena_rect_by_approach`: 3-4 columns or 2-3 rows), and barred from the six cells around the seat (`tile_blocked_for_placement`). Its commander takes the **first cell with no defender unit adjacent**, scanning the strip from a corner chosen by two coin flips, one of them fixed by the approach edge; up to two units fan out around it, the rest drop at random inside the strip.

So against an AI attacker, a human defender knows the strip, knows the commander lands at one of two scan corners, can push that landing cell along the scan with his own placement, and moves first.

**The AI retreat.** `ai_claim_province_when_strong_enough` $A84D is not a conquest trigger: when a daimyo-led commander's own men doubled are under the men of the enemy units next to him, or his side's rice is under two days' ration, he relocates the capital and gives the battle up (the exact rule, and the sim's missing neighbour list, in #44). The ROM runs it only for an AI side; the sim fought the human's battles with the AI logic, so Saito's battles were mostly ended by his own retreat (83 of 100 seeds, days 6-26). Knob `no_retreat` (tactical.py; off by default). It saves nothing: 2.0% → 2.3% (1 / 0) at skill 1, 0.3% → 0.3% at skill 2, because without it 75 of those 83 battles end with **his commander killed** instead, and the wins stay at about 27 in 100. The retreat was pre-empting a decapitation. The battle is decided by the commanders, in both directions.

**How Saito wins** (300 seeds, skill 1, the AI fighting his side; 363 battles). Rebels (his own revolts and riots): 40 of 63. Invasions: 36 of 300, and by the attacker's men: under 40, 7 / 24; 40-60, 10 / 42; **60-80, 1 / 61**; 80-120, 6 / 150; **120 and up, 12 / 23**. 19 of the 36 are against Takeda's coin-doubled army (about 164 men): an army eats men/30 rice a day (`consume_daily_battle_rice` $830B), so 164 men arriving with about 50 rice run dry near day 18 and lose (code 4) with **about 55 men still standing**, and those survivors garrison Saito's fief with no rice: the 38 → 141 of #41. The other wins are decapitations (15), mostly of small, short-supplied attacks. The 60-80 band is the attacker's sweet spot: big enough to win, small enough to stay fed. Not a bug: Echigo's ring (#36) seen from inside the castle. Starving them out wins the battle but not the Fall.

**Doctrine for a combat player (Chris).** Read the attacker's days of food, its rice over men/30. Short (Takeda's 9 days): turtle, the commander in the castle, and win on the clock. Better still, spend Saito's own men in attacks along the way: the garrison's morale blends by men (`transfer_force_triplet` $DF73), so fewer of his low-morale troops raise it, each side burns only its own men/30, so his losses save his rice, and the attacker's losses are fewer mouths joining him; the price is a slower starvation and a longer exposure of his commander. Long: go for the commander, steering where it lands (above). The small battles (under 60 men: 17 of 66 won now, mostly by decapitation) are where deliberate play should gain most. Movement is one hex a day, no more, no less (Chris); the grid's columns are offset by half a row, six neighbours (`step_coord_by_direction`).

**Gaming the setup (Chris: one hex a day, units act in slot order, 55 cells and 30 days, so the setup's dice decide most of it; the rice rule sets the tone first, delay or decapitate).** The lever is the attacker's commander rule: it takes the first strip cell with no defender unit adjacent, and if there is none it falls to the random drop inside the strip, which can land next to a defender, and the defender moves first. Blanketing the strip (every valid cell a unit's or next to one; the commander on the seat, four units free): Mino, 60 seeds of battles, Takeda from the east 14 cells, **3 units**; Asakura from the north 18, Oda / Kitabatake / Asai from the west 17, Tokugawa from the south 25, **more than 4**. So a full blanket works only against Takeda, the attacker the rice rule says to starve. A partial blanket still steers the landing to the first uncovered cell in the scan (one of two corners), which puts a strike unit two hexes off: step in on day 1, strike on day 2.

**The pocket (Chris).** Cover all but one or two strip cells, so the commander must land in the hole; nothing of the defender's is next to it, so place the strikers at exactly two hexes, step in first on day 1, and win the race. Mino, four units at most, the commander on the seat: a **1-cell pocket exists against 5 of 6** attackers. Takeda (E) at (7,4) with 3 units, 2 of them two hexes off, 3 open neighbours; Oda, Kitabatake and Asai (W) share one placement, (3,4), 2 strikers, 2 open neighbours; Asakura (N) at (7,2), 3 open neighbours but no striker two hexes off; Tokugawa (S, 25 cells) none. A one-cell pocket takes the corner coin out of it. **The snag: bodyguards seal a tight pocket.** The attacker places slots 1-2 on the commander's first free neighbours (`ai_place_unit_in_free_slot_resolve_coords`, which does not check for defenders), so a hole with 2 open neighbours, like (3,4), is filled by his own escort: he cannot run, and he cannot be reached until a guard dies. A pocket wants **3 or more open neighbours**, one left after the guards. Untested in battle: his day-1 move and the strike odds against a commander holding about 70% of the army.

**Open, for a combat player:** what it takes to kill a commander that holds most of the army (the base split is 50/5/5/5/5, so about 70% of the men; Assign can change it), and whether steering the attacker's commander to a known cell and striking first turns the 27 wins into more. A battle harness that replays the captured start of every player-defended battle would measure a placement policy far faster than whole games.

**The harness, step 1 (2026-11-10).** `na1sim.battles` (capture / replay / verify): Saito, skill 1, 3 years, seeds 3000-3299, the expand tail: 376 human-defended battles, a plain replay **bit-exact on 376 of 376**, 1.6 s for all of them. Baseline held: rebels 36 / 55, invasions 43 / 321; by the attacker's committed men under 40, 10 / 34; 40-60, 13 / 43; **60-80, 0 / 52**; 80-120, 8 / 168; **120 and up, 12 / 24**; by days of food (rice x 30 / men) 10-19, 25 / 28, 30 and up, 18 / 293. The shape is the one above; the counts differ (376 vs 363) because the probes behind the figures above were not saved, so their settings are unknown. These records are the baseline from here. "Held" = the fief keeps its owner (the engine's winner flag names the DEFENDING province when the attacker wins).

### #41 — Rice for targets only, Saito is decided at T1, and search on one seed set (Chris, 2026-11-10)

**#40's upkeep rule on all 17** (`upkeep_rice=1`, default tail, 300 seeds paired, 6 years). The mean did not move (skill 1 66.3% → 66.6%, skill 2 61.5% → 60.4%) because it was two effects cancelling. Split by whether the seed was attacked with the rule off: attacked games 97 saved / 6 lost (skill 1), 66 / 6 (skill 2); never-attacked games 3 / 72 and 5 / 121. Imagawa fell 90.7% → 77.0% and 84.7% → 69.0%, Hida and Kitabatake fell too, all by invasion in years 1-2 with fewer men at death (Imagawa 52 → 41): spending Summer on rice left them under the grudge line and **made them targets**. Chris's reading: off target, tax/give is the standard and sets up the harvest; a target hires first (Men, then Tax if that lifts it out of range); only a target still in range buys rice, to rice = men before and after the harvest, and sees to the economy after.

**The upkeep is read after payday.** The harvest sweep runs income, debt, then upkeep (`harvest_income_sweep_all_fiefs`, appendix §harvest), and mode 1 judged the rice before the harvest. `upkeep_rice=2` (`policy._gate_rice`) forecasts the harvest by running `game.harvest_fief` itself on a snapshot with every income roll at 0 (`policy.harvest_after`; memory and RNG restored, checked). 13 fiefs, 300 seeds, 3 years: attacked games 45 saved / 4 lost (skill 1) and 20 / 1 (skill 2), never-attacked 0 / 6 and 0 / 7; Imagawa 0 / 0. Takeda +4.3 and +4.0 (13 and 12 saved, 0 lost), Uesugi +5.0 at skill 1. Mode 1's Tokugawa and Ashikaga gains died in years 4-6 off, outside the window; Chris: the early game is this rule's job, later the economy fixes it. Still off by default.

**Saito is decided at T1.** Default, 300 seeds, skill 1: 270 games attacked in the first Spring (36 survive, share 80), 19 in Summer, 27 in Fall (1 survives, share 93); 160 of 298 deaths come **before his first action** (169 of 299 at skill 2). The T1 survivors hold the blended armies (seed 3100: 38 → 141 men) on a harvest of about 26 rice against an upkeep near 65, so the Fall upkeep zeroes the rice and the share-100 attack follows: **winning too well** (Chris). Mode 2's 1-rice line kept that army and moved the death to year 2; mode 1 spent all the gold, made gold the short one, and the upkeep cut the army to what it could feed. Buying rice beats a Summer economy here because a tax raise scales a 26-rice harvest, while the purchase is ~35 rice now (two traced seeds). The opening search (`hatakeyama.py --fief 8`, Spring men moves, depth 3, 100 seeds) found men/tax at 25-67% on boards with 0-1 doubled neighbours and rice on 2+; **on 300 fresh seeds** that fell to: default 2.0%, default / rice / tax40 4.0%, hire 3/4 / tax 2.0% (20% / 5% / 0% by 0 / 1 / 2+ doubled). About 8% of games end in a revolt from the morale-21 start. What is left is the T1 battle itself.

**Method: search on one seed set, validate on another.** The 100-seed beam fit its own seeds (one board class 25% → 5% fresh); Hatakeyama's 30.7% held because it was confirmed on fresh seeds.

**Extended combat (Chris), tried and dropped for T1.** A won defence garrisons both armies' survivors, rice and gold (`apply_conquest_outcome` $E03C), so a player who is winning fights on: `tactical._extend_won_defence`, X men a day in all (half each side), each side burning men/30 rice (`consume_daily_battle_rice` $830B), until the garrison passes the post-harvest feed line; knobs `extend_x`, `extend_stop` (1 rice above 0, 2 also next year's upkeep), `extend_floor`. Saito, 300 fresh seeds, paired, X 20 / 40 / 60: without a floor 2.0% → 0.0-0.3% (X=40 sustain: 0 saved, 6 lost), every loss cut to 0-22 men and taken by a **second neighbour the same Spring**: the big blended army is his shield until the hunters have moved. With the men floor (never below the size `hunted_by` passes over: *big enough not to be the runt, no bigger than he can feed*, Chris) 2.0% → 1.0-1.3% (1 saved, 3-4 lost), the rate irrelevant. The reach is the problem: of 300 games 161 die before his first action and only 28 win a T1 battle (6 already alive at year 3). The cut belongs at the Fall upkeep, after the hunters move, not in the battle. Off by default.

**Saito as a new player: `reaction.reader_policy`** (Chris). The T1 battle can come before or after his first command, so a turn-numbered opening cannot tell a fief that just won a big garrison from one that did not, and a Spring hire on top of a won battle makes the upkeep worse. The reader takes the first that applies each season: cliffs (morale, then loyalty); the runt (a neighbour would pick him and can pay: hire to `men_line`, no further); Summer, an army that cannot be fed through this upkeep and the next buys the least rice that can (`policy.buy_rice_to`; when gold is then the short one, the upkeep dismisses the rest); else the economy (tax as loyalty bears it, Summer rice, Spring gold, train). Saito, 300 fresh seeds, year 3, paired: **skill 1 2.0% → 4.7% (8 saved, 0 lost), skill 2 0.3% → 3.0% (8 / 0)**, the best Saito figure on fresh seeds and the first with nothing lost. `deaths.py --tail reader`. Its ceiling is the board: 161-165 of 300 games end before his first action and 23-26 in a revolt. Untested on the other 16 (Chris, 2026-11-10: the gains are marginal and the cases it adapts to are few; stop here, apply it if it generalises).

**Rokkaku has no move** (Chris: no hatred, just a small economy and army, fighting uphill). Reader and default, 300 fresh seeds, both skills: 0 alive, the rows identical, so no choice it made changed an outcome. Every game ends in the first Spring: 205 of 300 (211 at skill 2) before his first command, the other 95 after it that same season, 43 of them attacked twice. At his first command he has 36 gold, 24 rice and 21 men, and four neighbours pick him (Tsutsui, Asai, Kitabatake, Ashikaga, 38-74 men). All his gold buys 7-25 men at the year's rate of 1.4-4.6 gold a man, so 28-46 men, and not being the runt is out of reach. A pact (relations 70, the attack-abort gate of #34) demands at least half his gold plus 20, 38 or more against his 36, and would cover one hunter of four. Hatakeyama, Saito and Rokkaku are the three ways a start fails: the order of fixes (playable), the morale and the battle (marginally), and the size of the position (not at all).

### #40 — Picked, then paid: the two gates, the Summer window, and Hatakeyama (Chris, 2026-11-09)

**One rice is as good as a thousand, but only for being picked.** The June doctrine (keep 1 rice, give the rest) read only half of an attack. An AI attack passes two gates, and they read rice differently:

1. **Pick.** Every targeting comparison (the weakest-prey scans, the usual ratio gate, the grudge past 47) goes through `fief_men_ratio_pct` → `fief_men_if_provisioned` ($9382): your men if you hold any rice, else 0. Here 1 rice is a full army and 0 is none, which makes you the softest target on the map.
2. **Pay.** Once picked, `ai_commit_attack_deduct_resources` attacks only if its budget `min(2 × rice, men, gold)` reaches your shield `min(rice, men)` (#39). Here rice counts unit for unit: at 1 rice any picker with a budget of 5 gets through.

So the order of play (Chris): ideally nobody picks you, and then rice past 1 does nothing, so spend it. When someone does pick you, which you often cannot prevent, rice and men must both stand above that attacker's budget, since the shield is the lower of the two. **Men work on both gates, rice only on the second**, and on the fight that follows. The matrix already reads both gates (`reaction.threats` is `hunted_by` filtered by budget ≥ shield); the default's Summer rice gift ignores the second.

**The Summer window (Chris).** The gates are read only when the attacker moves. `shuffle_fief_turn_order_array` ($A742) reshuffles `daimyo_turn_order` every round, between the planner and the command phase, and the player sees who has moved. The harvest runs before Fall's command. So in a Summer where every hunter has already moved, the shield can drop to 1 and the harvest refills it before anyone looks again. In any other season, rice spent after the hunters move is still missing at their next turn. The sim now records who has moved (`m.acted`; it shuffles uniformly, while the ROM makes n random swaps, close but not uniform). Measured on Hatakeyama: below.

**The matrix on all 17 fiefs** (`reaction_policy` against the default tail, 300 seeds each, paired by seed). It never costs anything: no fief falls significantly at either skill. It gains where a hunter's gate can be closed with gold:

| Skill | Default | Matrix | Significant (paired \|z\| ≥ 2) |
|---|---|---|---|
| 1 | 66.3% | 67.0% | Uesugi +4.7 (16 saved, 2 lost), Tsutsui +3.0, Honganji +1.7 |
| 2 | 61.5% | 62.1% | Hojo +5.7 (18 saved, 1 lost) |

The other twelve fiefs do not move: either nobody picks them or nothing saves them. As expected of a board read (Chris): it helps only where it can, and marginal gains are the kind there are.

**Hatakeyama: what to fix first.** Noto starts at morale 23 and loyalty 24, both under 45; it has one neighbour, Honganji, whose grudge picks it. The menu, priced on its turn-1 board (skill 2):

| Turn 1 | Effect | Revolt roll fails | Riot roll fails | Shield |
|---|---|---|---|---|
| (start) | | 74% | 72% | 44 |
| gold → peasants | loyalty 24 → 60, wealth +36 | 74% | 0% | 44 |
| rice → men | morale 23 → 44 | 4% | 72% | 1 |
| gold → men | morale → 39 | 25% | 72% | 44 |
| rice → men, half | morale → 35 | 40% | 72% | 23 |
| hire, all gold | men +21 at 1.5 a man | 64% | 72% | 44 |
| tax to 55 / to 40 | loyalty −8 / −4 | 74% | 87% / 80% | 44 |

An uprising season comes about 30% of the time (15% in Summer), half of them revolts, so morale 23 costs about an 11% chance a season of a rebel battle; a riot is about 3% and gold in hand settles it. Gold and rice are separate purses and each fixes one cliff, but the rice fix drops the shield. Taxing after the peasant gift undoes it (60 less 35% is 39); tax to 40 keeps 51.

Where Noto's games end (default tail, 300 seeds):

| Skill | Before his first turn | Year 1, after moving | Year 2 | Later | Alive at year 6 |
|---|---|---|---|---|---|
| 1 | 10% | 55% | 22% | 2% | 11% |
| 2 | 11% | 76% | 12% | 1% | 0% |

Year 1 is the game, and invasion ends most of them: in a traced sample, Honganji hits in Spring, Noto survives at 13-29 men, and Honganji finishes it in Fall once the harvest has refilled his budget too. The Summer move fired as designed (Honganji had moved first in 5 of 6 Summers) and changed nothing, because Fall comes anyway.

**The search** (`na1sim/hatakeyama.py`: every two-move opening over 14 moves, full and half gifts, tax 40, the Summer rice move, then the best six extended to a third; skill 1, 100 seeds a plan, alive at year 3; default 10%). Morale first is close to suicide: rice to men 1%, gold then rice to men 2%, because the shield drops to 1 and invasions rise to 90 of 100, while revolt deaths barely fall (8 against 8-17). The leaders all open hire, tax: men first, then the tax that pays for them at the harvest. Hire alone, without the tax, is 8%, below the default. **The best risk is the revolt** (Chris: keep rolling the dice): hire / tax doubles revolt deaths (8 to 17) and cuts invasions from 81 to 57.

**Hire raises morale.** Recruits arrive at morale `rng(20) + 40` (skill `rng(20) + 60`, arms `rng(10) + 50`), blended by headcount (`apply_hire_unit_stats` $8BF4), so Noto's full opening hire takes morale 23 to 30-33 with no rice spent and the shield whole. It works on the revolt cliff and the gate at once.

**How much to hire** (Chris: an undershoot is fatal, an overshoot pays upkeep). At skill 1 the line is about 50 men, 2 over the start (`reaction.men_line`). Confirmed on 300 fresh seeds, skill 1, alive at year 3, paired by seed:

| Spring / Summer / Fall | Alive y3 | Riot deaths |
|---|---|---|
| default | 12.7% | 7 |
| hire to the line / tax | 25.0% | 2 |
| a quarter of the gold / tax | 24.7% | 2 |
| hire half / tax | 23.0% | 3 |
| hire all / tax | 22.0% | 10 |
| hire all / tax / **rice → peasants** | **30.7%** | 4 |
| hire all / tax / gold → peasants | 30.0% | 4 |
| hire half / tax / rice → peasants, half | 25.0% | 0 |

On two moves the size barely matters (small hires edge it, z about 1), and the overshoot's cost shows in one column: riots, 2 against 10, since an empty purse cannot pay one off. The third move settles it: **hire all, tax, then give the harvest to the peasants** beats the default by 73 games saved to 19 lost (z +5.6), the same plan without the gift by 47 to 21 (z +3.2), the hire to the line by 43 to 26 (z +2.0), and the half version by 39 to 22 (z +2.2). Rice or gold for the gift is a wash (z 0.3); gold keeps the shield. **The overshoot pays when loyalty is mended right after the harvest**: the big hire buys a margin over Honganji and 8 points of morale, and the Fall gift covers the purse it emptied.

**Hatakeyama's opening, skill 1:** Spring, hire with all the gold; Summer, tax to 55; Fall, give the harvest to the peasants. 12.7% → 30.7% alive at year 3. What is left is mostly invasion, and it is the board: with 0 / 1 / 2+ of Honganji's coin neighbours doubled (Uesugi, Asakura, Takeda), 39% / 34% / 25%. The coin hurts him, and Honganji is rarely the killer (Chris asked whether someone takes Kaga and comes on): of Noto's invasion deaths on the default tail, 300 seeds, Honganji dealt 22 of 243 at skill 1 and 38 of 268 at skill 2; the rest were Uesugi, Takeda, Asakura and Hida, mostly in year 1. Noto borders only Kaga, so each had taken it first. A doubled neighbour of Honganji's takes Kaga sooner and arrives with a bigger army; the real opponent is whoever wins Kaga. Skill 2 and year 6 are not yet run.

**Saito's clear boards, answered** (the #39 blind spot). Of the 21 boards that read clear and died: 9 had a revolt first (morale 21; five died before his first turn, gold untouched), 6 had spent rice to 0-1, and 6 were snapshots gone stale as neighbours' shares crossed the line. Holding rice (`keep_rice`) saved none: his shield of about 25 is under any budget that kills him. 56% of Saito's games end before his first turn, and the mean killing blow is 144 men against 37. Chris's chain for avoiding every attack (move first, men at 1.7 gold or less, dodge the revolts and the coins) prices near 1 in 3,500 just to reach Fall.

**But the sim's survivors did not avoid the attack: every one was hit in Spring of year 1 and won the castle fight.** `apply_conquest_outcome` ($E03C) garrisons the defender's fief with the survivors of both armies, their gold and their rice, and `transfer_force_triplet` ($DF73) blends morale, skill and arms by surviving men on a win or a loss, so a doubled attacker's army brings its morale too (Chris guessed it; the session first said otherwise, wrongly). Seed 3032 survives in every run: 38 men, a 123-man attack beaten, 122 men at the year's end.

Most such wins then died in Fall at a 100% share with rice 0 and gold in hand (all 37 such blows, both skills): the upkeep (`consume_province_army_upkeep` $A15B) takes men/2 from gold and rice, and when the smaller cannot cover it, takes all of it and cuts men to twice it. A 120-man army on Mino's harvest ends at rice exactly 0, which opens both gates at once. The fix: in Summer, buy rice with all the gold it takes. Gold is in neither gate, so if gold is then the short one, the upkeep zeroes the gold and trims men, and the rice survives (a first version that kept gold for the upkeep fixed nothing). Saito, 300 seeds paired: skill 1, alive at year 6, 2 → 12 (10 saved, 0 lost); skill 2, 1 → 5 (4 / 0). It is `policy.OPENING["upkeep_rice"]`, off until it is measured on all 17. **Saito has no economic way through; his one way is the defensive battle, then feeding the army.** The battle is a human's to win: the sim defends with AI logic.

**Firing men (Chris).** There is no dismiss command, but the upkeep is one: spend gold down before the harvest until gold plus the harvest's gold is about the army you want over 2, keep the rice high, and the harvest dismisses the rest. That keeps a won battle's morale and rice without its payroll. A longer battle to thin the attackers costs rice (each side burns about men/30 a day, `consume_daily_battle_rice` $830B, and a side out of rice loses) and morale blend (fewer survivors), so thin them, then end it. Not yet measured: a post-battle trim to the line plus a margin is the sim's stand-in, optimistic by the days of rice.

**Fixed on the way:** the player's Tax command (`policy.set_tax`, and `econ.set_tax`) still drained loyalty and wealth on a cut, the June model the oracle had retired for `econ.tax_effect`. Now as `driver_tax`: a cut gives back, charisma +1 on a cut and −1 on a raise (not below 0), the rate 1-100. No policy cuts the tax, so no earlier figure moves.

### #39 — What kills a start, and reading the board (Chris, 2026-11-06)

**The sim's boards were wrong until now.** `apply_scenario_starting_stat_boosts` flips a coin for each listed AI fief (17 fiefs: 1, 2, 4, 7, 10, 15, 16; 50 fiefs: 5, 9, 13, 14, 19, 21, 23, 24, 26, 38, 42, 49). A win doubles gold, loyalty, morale and men and multiplies rice by 3 (4 at 50 fiefs), after the skill bonus, so Takeda is (72 + 10) x 2 = 164. The sim runs that routine on the VM, whose stand-in generator is a 16-bit LCG with an alternating low bit, so `rng_mod(2)` was no coin: 40 of 40 boards had all of them doubled or none. Chris caught it by doubting a 164-man Takeda. The VM now has the ROM's generator (`syscall_rng_next $C1C3`, 500 of 500 states against the 6502) and setup uses it; `oracle_vm` stays on the stand-in, whose sequence it depends on. **Every survival figure before this section came from those boards**, #38's tables included. The mean barely moved (60.7% to 61.5%, different seeds); individual fiefs did.

**Who sets the starting relations:** the same routine. Every pair of coin winners is married (relation 90). Saves agree: Uesugi, Hojo, Asai married and all three doubled; the 50-fief save has 6 winners and all 15 pairs. The sim had each board's winners all allied or none, so AI-against-AI war was off as well.

**An AI needs two things to attack a human.** Share: its men past 47% of the two armies (the grudge). Budget: `min(2 x rice, men, gold)` at least the defender's shield, `min(rice, men)` (`ai_commit_attack_deduct_resources`). The coin matters because it doubles the gold: plain Hojo already has a 51% share of Uesugi but a budget of 73 against a shield of 74, shut by one; doubled, 146. Chris's "coin flips create new grudges". At skill 3 plain Hojo reaches 83 and opens it with no coin.

**How the game ends** (`na1sim/deaths.py`; 17 fiefs, 300 seeds, skill 2, 1,964 deaths). Invasion 96%, revolt 78, riot 8. The last blow is usually overwhelming (71%+), but 61% of invasion deaths *began* with a grudge-band hit: Hojo, 70 men against Uesugi's 84, wins the first fight, falls to about 27, and the next attacker finishes it. 44% of deaths come before the player's first turn (Uesugi 23 of 39, Honganji 211, Rokkaku 203), out of any opening's reach.

| Skill | Mean | Hojo | Tsutsui | Hatakeyama | Saito | Rokkaku |
|---|---|---|---|---|---|---|
| 1 | 66.3% | 63.7% | 12.0% | 11.3% | 0.7% | 0% |
| 2 | 61.5% | 36.3% | 1.0% | 0% | 0.3% | 0% |

**Tested, paired by seed, skill 2 unless noted.** No men on turn 1: Uesugi 87.0% to 58.7%, Hojo 36.3% to 14.7%; the default already opens that way, which is why a men-first plan seemed to do nothing. Men then tax: Hojo +6, Hatakeyama 0 to 5% (21% at skill 1, from the tax), Uesugi +4 at skill 1 only, Ashikaga -10, because it starts at morale 36 and loyalty 38 and breaks from inside (revolt deaths 9 to 22). Keep rice at or above men: Takeda 90.3% to 95.3%, nothing else moves. Buy rice first: Imagawa 84.7% to 54.0%, Hida 92.3% to 80.0%. Forecast picker (+30 on every AI army): Hojo +8, Takeda -8, measured on the old boards.

**The read** (`na1sim/reaction.py`). At the start of a game, each neighbour that would pick this fief by the ROM's own choice and can pay. The row predicts the game with no game played (default player, alive at year 6):

| Turn-1 row | Skill 2 | Skill 1 |
|---|---|---|
| Clear | 3,166 games, 92% | 3,166, 94% |
| Shut: gold can close it | 651, 31% | 1,012, 39% |
| Repel: only a fight | 214, 15% | 0 |
| Can't | 1,069, 0% | 922, 3% |

Repel and can't together rise from 18% of boards to 25%, Chris's point that skill adds unplayable starts. A first version that counted every neighbour able to attack failed: it had Hatakeyama playable and Takeda not. An AI hits one target, chosen by who else it could hit. Blind spots: revolts (Ashikaga reads clear at 82%), 21 clear Saito boards that all die, later turns, turn order; Uesugi at skill 1 inverts slightly.

**The matrix** (`reaction_policy`), first row that applies: fix morale and loyalty; if a gate is open, all the gold into men; hold rice if a gate may open at harvest; else play on. **The read decides whether to buy, not how much.** Buying exactly to the line lost (Uesugi 87.0% to 79.3%, Hojo at skill 1 63.7% to 56.3%), as the picker did: the line is read before the neighbours move. All the gold, on the seven fiefs tried: Hojo 42.0% (18 saved, 1 lost), Uesugi at skill 1 94.3% (16 saved, 2 lost), Tsutsui at skill 1 15.0%, nothing significantly worse. Chris: it saves a turn and adds padding. Not yet run on all 17; Hatakeyama's tax jump is a missing row.

**Method** (Chris). Monte Carlo finds principles, not plans: a plan answers a board. Some boards are dead, so the measure is how many playable ones a player wins, and what you do depends on the position, not a rail. Averages over a fief hide the board, and a "best" describes the player that found it.

### #38 — Openings: fix the weakness, tax by turn 2, and the picker (Chris, 2026-11-04)

**Measured on boards with a broken coin: see #39.** The goal is not a high win rate; it is the best chance of getting to play. Most of a game is decided by year 2. Numbers are the sim, skill 2, 17 fiefs, its human defending with AI logic, so a bottom-tier fief's figure is a floor. The table below was measured before the real riot went in; rerun with it, the default moved from 57.1% to 57.8% and no low-loyalty fief moved much (Ashikaga 74 to 72, Asakura 79 to 81, Asai 96 to 94; Hojo 37 to 30, the largest fall, about two standard errors at 150 seeds).

**The tax line.** The revolt roll is `min(stat, 50)^2 < rng(2025)`: 45 or more cannot fail, and it runs on loyalty and on `100 - tax`, so 55% is the highest rate that adds no risk of its own. Raising 20 to 55 takes 35% off loyalty and wealth, so **loyalty 70 is the no-risk line** (70 x 0.65 = 45.5). Below it, tax then give: a gift after the tax is not cut by the 35%, and the lower stat makes each unit buy more, about half the cost of give then tax. The exposure is one event roll. Income is linear in tax, so 55% against the opening 20% is 2.75x on the 1560 Fall harvest. Tax takes any rate in one turn.

**Give.** `gain = amount x (6 - skill) / sqrt((stat + partner) / 2 + amount)`; peasants take 2 x gain into loyalty and wealth alike, men take gain into morale, and gold and rice are the same (Appendix A section 10).

**Uprisings.** The roll runs at the start of any season, but one only happens if a fief passes a 3% roll (about 40% of seasons over 17 fiefs, Summer's typhoon and plague aside); then a coin picks riot or revolt, falling to the other if no fief qualifies. A riot needs a failed roll of loyalty, 100 - tax or charisma, then a 1-in-4 with output and more than 2 men.

A human capital facing a **riot** is asked for gold: yes gives all of it to the peasants, in a weaker form than a Give (a sum of roots, not doubled), and settles it only if loyalty ends above 25 and rose by more than 5. Otherwise it is a battle, and the rebel army is the fief's **output**, joined by up to half the men if charisma is under about 70, with 50-80% of the rice. Beaten, it leaves nothing and output loses 10-19%. A **revolt** on a human capital is a battle too: 20-89% of the men defect, with the rice; beaten, the survivors rejoin. If the rebels win, a new daimyo takes the fief and a capital takes the faction with it. An AI or non-capital fief instead has a riot contest, sqrt(output) + sqrt(wealth) + rng(20) + 10 against the men, or the revolt roll (Appendix A section 10). Uprisings are fatal and rare: 0.13 rebel battles per 6-year game for Ashikaga, 0.05 for Hida, once stats pass 45; forced, Hida lost the fief 25 times of 30 to a riot and about half the time to a revolt, on the sim's AI-logic defence. Chris: always pay; better all the gold than the game.

**The market.** Rates are rolled before turn 1. Men cost `70% of ((year - 1560) / 2 + 2) x 10 + rng(51)`, in tenths of a gold: 1.4 to 4.9 gold a man in 1560, averaging 3.2, about +0.35 a year after (29 captured 1560 saves span 14-47). Each purchase adds 1, whatever its size. A build order can branch on the roll.

**Creation.** A human rolls five abilities at `rng(50) + 60`, refusing the set at will; age stays. It barely moved survival (40.1% either way), and Imagawa at health 109 did no better than at 52: his trouble was never his lord.

**Alive at year 6, 150 fresh seeds.** Default = tax to the 45 line, gold for emergency gifts. The search tried all 64 two-turn plans over tax, gold or rice to peasants or men, hire, train and default, with a 6-turn beam for the troubled fiefs, and confirmed the leaders on seeds it had not seen.

| Fief | Default | Best plan | Plan |
|---|---|---|---|
| Hatakeyama | 0% | 7% | hire / tax / rice to peasants |
| Uesugi | 81% | 81% | default |
| Hojo | 37% | 41% | hire |
| Honganji | 1% | 1% | none helps |
| Asakura | 79% | 87% | hire / tax |
| Hida | 79% | 79% | default |
| Imagawa | 68% | 69% | hire / tax |
| Tokugawa | 79% | 81% | default / tax |
| Saito | 0% | 3% | gold to peasants |
| Tsutsui | 0% | 0% | none helps |
| Asai | 96% | 97% | hire |
| Rokkaku | 0% | 0% | none helps |
| Kitabata | 92% | 95% | default / tax |
| Ashikaga | 74% | 83% | tax / rice to men |
| Miyoshi | 99% | 99% | default |
| Takeda | 87% | 87% | default |
| Oda | 99% | 99% | default |

Mean 57.1% for the default, 59.3% for each fief's best plan, from about 45% before these rules. Beyond turn 2 the beam added little, though it was narrow (30 seeds).

**The picker.** You need not be the strongest, you just cannot be the weakest, and the grudge tilts it. An AI's choice depends on who else it could hit, so it is a second-order question on the adjacency graph, and the order of a neighbour's list counts (the sim's lists match the ROM on all 17). `policy.hunted_by` and `picker_line` run the real selection. At the start, 10 fiefs are hunted by nobody. Men short of the line, and the cost at an average market: Hatakeyama 8 (26 gold of 33), Uesugi 13 (42 of 63), Hojo 18 (58 of 53), Saito 17 (55 of 29), Honganji 25 (80 of 42), Tsutsui 28 (90 of 42), Rokkaku 32 (103 of 36). Uesugi is hunted by Hojo, Hojo by Imagawa, Tsutsui by Miyoshi, Hatakeyama by Honganji.

As a standing rule it lost: 54.7% against the default's 57.1%, and margins of 25% and 50% barely moved it (55.2, 55.3), so "no margin" is not the reason. The fiefs that lost most (Asakura, Imagawa, Hida) start unhunted, so it bought nothing. Leading guess, not traced: it answers who is a target today, and they become one later. The open question is Chris's: how to stay ahead of being the weakest, at the least cost, which the largest in an area get for free and the rest must skate between army and economy. Uesugi is the sharp case: too much army and he cannot boom, too little and Hojo comes. Two things have moved since that was first tried: the shortcut's income loosens the trade, and the AI's army may be forecast, since `ai_state2_recruit_arm_train` recruits only under `min((year - 1559) x 40, stat_cap)`. Untested: ask who will be weakest next year on that schedule, not who is now. Measure the real curve first; a dice gate, gold and wars hold it below the schedule.

**A human turns it round.** Chris survives Uesugi by taking Hojo's men in combat: being hunted can pay. The sim scores that as danger.

**Watching battles** (Chris). The calculated battle is gentler than the fought one, so the "Watch other daimyos battle" option wears the AI down. Measured over 6 fiefs, 100 seeds: AI armies 25% smaller by year 6, 33% by year 10, about 1.5 fewer clans. This player's survival barely moves (75% to 77%, within noise), but it barely expands; a human who attacks should gain more. Chris recalls the SNES port fixing this; unchecked.

**Challenge runs.** Hatakeyama: every problem has a price (43 rice for morale, 26 gold for men, separate purses), one way in, one hunter; but morale-first and men-first lines without tax both went 0 of 700, while hire / tax / rice to peasants reached 7%. Saito needs men at 1.7 gold or less and the luck to move first: 0 of 1,500 in the sim, which cannot fight for him. Tsutsui's way out is a cheap market and one hunter. Rokkaku has none.

### #37 — Save RAM is the game's memory (Chris, 2026-11-04)

The memory map at the top of `source/4-c/all_banks.c` shows a design shape of the bytecode titles: every table it lists sits in `$6000-$7FFF`, the battery save RAM. The game keeps its state there and treats NES RAM as the machine's: the VM's stack and frames (about `$05xx`), the syscalls and the kernel. Logic passes data as parameters rather than through globals, and the syscalls take care of the hardware. So the save file is close to a dump of the live game, which is why one table reads so well, and why the snap protocol works. It reads like a program written for a machine with a heap, ported to a NES.

### #36 — The peasant shortcut and the ring at Echigo (Chris, 2026-11-04)

**The shortcut.** Leave town and output alone, and give gold and rice to the peasants. The harvest's base term holds wealth and loyalty and feeds *both* gold and rice, where town feeds only gold and output only rice. One Give raises two stats, each doubled, costs no other stat, and adds 1 charisma; Grow and Build each cut a stat, and their price climbs with the stat. Two seasons do what took three. Year-10 income on Hida at skill 2: 1,539 against 443 for the June rotation (600 seeds).

**The sequence.** Gold in Spring, rice in Summer (the army keeps its rice for battle every season but the one before the harvest), Fall and Winter train. If a neighbour is in reach, Fall is men, not peasants: a large army deters. When the economy tops out, that is the signal to buy men and expand. Measured over all 17 starts at skill 2: Spring beats Fall; slack over the grudge line costs growth and buys no survival; one big buy and a yearly top-up come out even. Bad fiefs do not recover (six starts survive 0-2% in the sim, where the human defends with AI logic, so that is a floor).

**The grudge path** (`$952E`) is why: an AI attacks a human neighbour past a 47% share of provisioned men, skipping its usual coin, and it counts men alone. Skill deters nobody; soldiers do. A strong economy has to become soldiers.

**A further step, not modelled:** sell rice and give the gold when a rice fetches more than 1 gold, or buy rice when it fetches less. It costs a turn, the merchant is not always there, and caps bite when large.

**Expansion is a graph problem, not an odds problem** (Chris, 2026-11-04). Taking a fief is the small part; it takes enough left over to hold it. Three ways to pay less for that:
- **Decapitation.** Corner and capture the daimyo and all his fiefs come with him, so a lord who cannot run is worth more than his fief.
- **Pump fiefs.** Capture enough that some fiefs have no enemy neighbour. Those cost nothing to hold and only feed the economy, so making one often beats an easier battle: the hold cost goes to 0.
- **Backfield attacks.** Attack out of a fief that a win would leave behind your front, and you need leave nobody home.
- **Cascades.** The picker turned round: hit a third party until it falls below a neighbour's attack line, and that war may tip the next, so the AIs fight each other while the player develops. Hard to pull off and maybe too dear: AI against AI needs a share past about 70% and a coin, where a human draws an attack at 47% with none.

The sim's player picks the weakest neighbour it can take. None of the three is modelled; each needs the adjacency graph (a fief's enemy-neighbour count before and after a capture), not a strength comparison. A good battle AI is a project of its own.

**The ring at Echigo (fief 2, one-based).** The map is a doughnut with the castle set like a diamond in the ring. The AI splits and deploys on both sides, so the defender goes straight for the general and ends the battle with more men than it began. If the AI sets up on one side, run the opposite way and reach the general at its tail; if it splits to counter, take the weaker half. The ring lets the defender control the engagement: circle to time them out, or strike the weak side. The sim's human fights with AI logic, so none of this is in its numbers.

### #35 — Player doctrine from the May 2026 playthroughs, promoted from memory — 2026-11-02
> Chris's strategy, worked out playing Tokugawa in Mikawa (May 2026), held until now only in session memory. It is **play-observed doctrine, not ROM-certified**; where the bytecode has since corrected a premise, the correction is inline. The general theses it rests on (the turn economy, the Winning-Position Theorem, the Economic Index, ~10% CAGR) are the vault's [NA1 Turn Economy](https://github.com/chrisaacson69/Vault/blob/master/research/gaming/na1-turn-economy.md).

**The five-step compounding loop.** (1) Develop each fief to its cap (`stat_cap`, record +24; randomized per game, ~1500–2000, so read it at the start). (2) Once output saturates, convert the surplus into men. (3) Train *after* buying: a session's total gain scales with the army, so buy first, then train. (4) Strike the weakest neighbour while force × quality is far ahead. (5) A conquest with no hostile fief beyond it becomes **backfield**: no garrison needed, its whole output a subsidy to the front, and a reservoir to Move men from (the capital is mobile too, #19). Each backfield conquest raises the sustainable army; the frontier migrates outward. Tax: set ~55% early and leave it (the riot roll, appendix-events; a cut *raises* loyalty and wealth, appendix-formulas §Tax).

**Staging with Move.** A fief's men are garrison, not committed force: a multi-fief clan concentrates at the attack vector before striking, and can feint (observed: Asakura took Kaga after Hojo shifted men toward Musashi). A single-fief clan cannot stack beyond its garrison.

**Anti-backfield fiefs.** A fief every neighbour wants is a drain, not an engine: Mino (7 neighbours in the ROM adjacency table, bank 4 $8300, `tools/adjacency.py`; the May notes said 5) changes hands instead of compounding. Net value ≈ cap − contestation, so a high-cap contested fief can be worth less than a modest isolated one; isolation beats raw stats ([Hollow Opponent](https://github.com/chrisaacson69/Vault/blob/master/research/gaming/hollow-opponent-perceived-depth.md)).

**Army composition is asymmetric.** Offense: strip the leader unit thin and put the strength in rifle and cavalry. Defense: pour everything into the leader and keep him in the castle; the town may be wrecked, but the battle ends on the commander (ch.21). Map geometry is a strategic variable: doughnut maps let a defender circle until the attacker's rice runs out (ch.17 supply clock), chokepoint maps funnel the attacker.

**Starting positions (17-fief), beyond #33's viability map.** Tier is two axes, the fixed starting stats × the per-game cap roll (Owari had the lowest cap of one game despite Oda's stats). Per start:
- **Omi (Asai)** is the average fief, every stat mid-distribution: the baseline to test a doctrine on (if it works for Omi it generalizes).
- **Settsu (Miyoshi)** is the favorable challenge: modest stats in a soft pocket (puppet-shogun Yamashiro, weak Yamato, Iga), charisma 101.
- **Suruga (Imagawa)** runs on its daimyo's health (52, the lowest): a mortality clock, not an economy (illness odds, appendix-events).
- **Noto ↔ Kaga** is one coupled puzzle: Kaga gates Noto's escape, and the Honganji hard mode (#34) decides when that gate weakens.
- **Hida** and **Yamashiro** are tier-in-neighbourhood cases: Hida should not take Mino (it inherits the contest) and waits on Kaga or a distracted Echizen; Yamashiro has one real threat (Settsu) and weak prey around it.
- Superseded May premises, kept out: revolt keyed on loyalty ≈35 (it keys on morale < 45 and charisma, #33); Iga safe from revolt at loyalty 46 (same); Honganji stable for 10–15 years (#34 gives it a revolt floor).

### #34 — The "KEYED DAIMYO" (Honganji / Ikkō-ikki) hard-mode + a 4th invade gate (relations) + the COULD-vs-WILL caveat — 2026-06-15
Chasing Chris's playthrough reads ("Kaga's tax is capped at 30%"; "Shinano isn't invaded as often as the map says") surfaced three things:
- **`defender_owner_is_keyed_daimyo` ($DB12) = `owner == 3` (17-fief) / `== 20` (50-fief) = Honganji (Kaga), the historical Ikkō-ikki.** One flag, three coded handicaps: (1) **30% tax ceiling** (`driver_tax $999A`: `number_input(1, keyed ? 30 : 100)`) → ~half a rival's harvest since income scales with tax (appendix §4) — *the* reason Kaga can't keep up economically, distinct from its military softness; (2) **50× base revolt floor** — the revolt random term is `rng(20)` for Honganji vs `rng(1000)` for everyone (`$9E21`); (3) combat/diplomacy quirks (the flag is also read at `$DFC9` and in the war path). So Kaga is **triple-doomed** (soft men + capped economy + revolt-prone) — hard-mode encoded.
- **A 4th AI invade gate found: `relations_rng_predicate $8271`** (called in `ai_commit_attack_deduct_resources $90C0`, *after* the men-share + logistics gates): aborts the attack when `rng(100) < relation[owner(def),owner(atk)]` OR `rng(100) < relation[def,atk]` — i.e. **abort probability ∝ relations**. **BUT it's moot at turn-1**: the `$6193` relations matrix only ever takes event-driven writes (combat→0, pact→70, marriage→90); no non-zero init found, so relations start ~0 and the gate grows teeth only as pacts/wars accrue. Not Shinano's turn-1 savior.
- **WEAKEST-TARGET fix (Chris's structural catch, applied):** the AI's `pick_weakest_men_fief $93B3` targets only its **weakest** neighbour, so a neighbour `n` threatens fief `F` **only if F is n's weakest** — a strong fief that isn't anyone's weakest is ignored regardless of the men/logistics gates. The viability map's `human_threats` now requires that, and it snaps to play: **Mikawa → PLAYABLE** ("never invaded"), **Shinano → hard(1)** ("rarely"), Suruga/Echigo/Musashi/Iseshima → PLAYABLE; **only Iga(4) and Mino(5) stay UNPLAYABLE** — the weakest-of-many. **Reconciles Mino:** safe in the all-AI map (no single 2.3× neighbour) yet unplayable as a human (the weakest of its neighbours (7 in the ROM adjacency table, bank 4 $8300; corrected 2026-11-02 from 5) pile on at the 47% grudge line) — Chris's "central = patsy" intuition was right, *for the human*, via weakest-of-many. The revolt overlay uses the same gate with men/2 (a revolt can make F *become* a neighbour's weakest). (Residual: the grudge override `$952E` and a gold-rich start buying rice turn-1 are secondary effects; relations gate moot at t=0.)
**Open:** confirm the `$6193` t=0 init is really zero (vs a ROM/SRAM seed via `load_daimyo_relation_row $DAAB`); model realized-vs-potential (a light turn simulation) if we want true invasion rates.

**Honganji, complete (2026-11-05).** Every use of the flag: tax ceiling 30 on each fief he owns, re-applied after any war, so what he conquers is capped too (`cap_honganji_fief_tax_rate_at_30`); AI tax 16-30 against 35-64; a revolt floor of 1-in-20 against 1-in-1000; and **riots cannot happen** on his land, since every riot branch requires not-Honganji. It keys on the owner, so Kaga taken from him taxes normally. No diplomatic penalty found: no 17-fief save from 1560 has a relation touching him. Relations do not always start at zero, though (0-6 cells by game), so the "moot at turn 1" above wanted a recheck: answered in #39, they are the setup coin's marriages.

**Kyoto, not Honganji.** Chris recalled that only high-Drive lords will attack Honganji. The rule is real, but `ai_try_war_attack` keys it on fief 30: an AI attacks only if its Drive beats rng(80) + 90, so under 90 never, 100 about 14%, 115 about a third. Fief 30 at 50 fiefs is Yamashiro, Ashikaga's Kyoto. At 17 fiefs Yamashiro is 13, and the check does not cover it, though the label table covers both: likely an oversight.

**Zealots and Monks.** `select_uprising_message` names the rebels by province, in both scenarios: Mikawa (7 / 23) Zealots, Yamashiro (13 / 30) Monks, others plain. Cosmetic, and history: the Mikawa Ikko-ikki, Mt. Hiei. Chris met them once as Tokugawa with high stats: with every roll safe, only the floor is left (1-in-1000, then 1-in-4, after the event gate), about 1 in 25,000 a season.

### #33 — STARTING-FIEF VIABILITY MAP built (grounds #32) + the revolt→war coupling + human-playability verdict — 2026-06-15
`tools/viability-map.py` computes, for both scenarios at t=0 (every fief its own daimyo → all adjacencies hostile), each fief's invade math. It both **confirmed and corrected** the intuition; it's the first **Pages "generated data" page** (`docs/data/viability.html`, view #5).
- **The AI does NOT coordinate → vulnerability is a *single* overwhelming neighbour, not degree.** Each attacker independently needs share > ~70% (2.3×) *alone*. So **Mino** (central, 7 neighbours, 38 men) is **safe** turn-1 — its biggest neighbour Owari (78) is < 2.3·38≈87. **Iga** (21 men) is the real 17-fief patsy: 3 neighbours (Omi 58 / Iseshima 74 / Yamashiro 52) each clear 2.3×21. Only **3/17 fiefs attack turn-1** (all onto Iga) → the map is **~80% frozen**, the deterrence frontier visible in data. (50-fief: 9/50 attack; **Tanba** (20 men) is the patsy.)
- **The event system FEEDS the war system (revolt→war coupling).** A fief safe by men can be pushed under its threshold by a **revolt** (low morale → `MEN/2`, appendix-events). `m_safe` = own men so no neighbour clears 2.3×. **Mino is the worked example:** safe at 38, but **morale 21 (lowest board)** → revolt → 19 men → Owari (78) invades. *This is the early-Mino invasion Chris saw.* (Yamato/Kaga/Yamashiro/Hida/Omi also `revolt→VULN`, but Mino's morale makes it likeliest.)
- **HUMAN playability ≠ the AI-vs-AI map — and needs BOTH gates** (refined 2026-06-15 after Chris's "I play Mikawa, never invaded turn-1" falsified the men-only model). Against the *player* the AI uses the harsher grudge gate (stage-1: share > **47%** ≈ 0.89× you) — BUT a neighbour only actually attacks if it ALSO clears **stage-2 logistics** (`$9046`): its gold/rice-capped `attack_budget = min(2·rice, men, gold)` must cover your `min(rice,men)`. Budgets are **gold-capped (~40–70 at start)**, so a high-men, well-supplied fief makes most "threats" abort — **Mikawa (71 men + supply) → only 1 real threat ("hard"), not 3.** The DRIVE/relations skip-gate is a **red herring at start: every daimyo has drive ≥ 50** (Tokugawa 102, weakest Anekoji 85), so it never fires. With both gates: **Iga & Mino still UNPLAYABLE**, but the **PLAYABLE set is broad** (Noto, Settsu, Echigo, Echizen, Omi, …) — matching live play.
- **Revolt overlay (the RNG-death tail):** a PLAYABLE start with **low morale** can still die turn-1 — a revolt halves men and may open a threat absent at full strength. **Noto** (PLAYABLE, but morale **23**) is the case: revolt → 24 men → Kaga (41) clears 47%. Flagged `REVOLT→dies`; high-morale playables (Settsu 70, Echigo 74) are not.
- **Event-trigger walk DONE (2026-06-15) — exact revolt cutoff = morale 45** (`square_over_2025 $9D86`: `min(morale,50)² < rng(2025)`, P=`(2024−morale²)/2025`; Noto-23 ≈ 74%, ≥45 → 0). Full gate (`morale_variant $9E21`): `square_roll(morale) OR square_roll(charisma) OR rng(1000)`, gated `men>2`; **low CHARISMA is a second revolt path**. Per-season compound = ~75% uprising branch × 3% planner inclusion-gate × 50% revolt-vs-riot × eligibility ⇒ a low-morale fief's turn-1 revolt ≈ elig×~0.3 (~10–25%). **Illness** (daimyo) = `rng(400)<100−health` = `(100−health)/400`/season. Riot = the loyalty/high-tax twin. All written to **appendix-events.md → "Trigger probabilities (exact)"**; the viability page's revolt column now shows the eligibility %.
- **Open / refinements:** add the **charisma** revolt path + per-season compound into the viability flag (currently morale-only); cross-check men vs `rom-defaults.txt` for t=0; relations/DRIVE matter on *later* turns (grudges accrue) though not turn-1; per-start strategy prose (view #4, "the detailed human-starts walk").

### #32 — THE AI INVADE PREDICATE quantified from bytecode → the "deterrence frontier" win (Chris's playthrough thesis, certified) — 2026-06-15
Chris's Pass-2 playthrough win (7→9 fiefs vs a richer, stat-capped Oda) made the thesis; the bytecode now certifies and quantifies it. **The AI's decision to invade is a MEN-COUNT ratio, NOT the 8-stat combat strength** — the 8-stat (`$8E7D`, ledger #31) only resolves *who wins the battle*, not *whether the AI starts one*. `fief_men_ratio_pct(a,b) = math32_2arg(men(a),men(b)) = ⌊100·men(a)/(men(a)+men(b))⌋` (a's men-share %; `fief_men_if_provisioned` zeroes a fief with no rice).

**Two-stage AI war flow:**
- **Stage 1 — `ai_try_war_attack $949A` (decide + pick):** precondition = attacker daimyo not weakness-flagged AND has men (record+16) AND rice (record+6) — *no rice, no war*. Target = weakest-men enemy (`pick_weakest_men_fief $93B3`). Then:
  - **vs another AI:** attack iff `men_ratio_pct(atk,tgt) − 10 − rng(0..3·const_two) > 60` → share > ~70–72% → **atk men > ~2.3–2.6× target** (overwhelming-force rule — why AI houses sit frozen vs each other).
  - **vs a PLAYER fief (grudge path $952E):** attack weakest *player* neighbor (`pick_ai_attack_target_fief $9423`) iff `men_ratio_pct > 47` → **atk men > ~0.89× yours** (near parity → the AI WILL come at you with up to ~11% fewer men; Chris saw this). Gated by relations + **DRIVE** (`ai_relations_and_low_drive_skip_gate $93DD`: low-drive <50 + good relations → skip; **drive ≥ 50 → wars regardless** — confirms ai-war-experiment H2 from code).
  - plus a flat **1-in-100** random attack.
- **Stage 2 — `ai_commit_attack_deduct_resources $9046` (logistics + commit):** `attack_budget = min(2·rice, men, gold)` (logistics cap — broke/starving fiefs can't deploy). Abort if budget < 5. **Second defender gate: abort if `min(def.rice, def.men) > attack_budget`.** Commit only **~50–70%** of budget (60–90% if the capital/rng flag set), deducting men+gold+rice from home → the attacker keeps a reserve and its home fief is weaker right after (counterattack window).

**THE WIN (deterrence frontier), now exact:**
- Vulnerability is **per-edge, men-relative** ("only as weak as your neighbors"). **Interior fiefs (no enemy adjacency) need ZERO men** — pure economy, untouchable.
- **Two ways a border fief is unattackable:** (1) men ≥ ~1.13× the strongest adjacent AI (their share < 47% → fails stage 1); OR (2) `min(your rice, your men)` > each adjacent AI's `attack_budget` (fails stage 2). **Rice/gold are a defensive lever**, not just economy.
- **Offense = "take what you can hold":** you commit a chosen force (player `driver_war $9850`: `number_input`), leaving a home garrison; after winning, your residual in the new fief must keep *its* new neighbors below their thresholds. Strategic position can beat weakness (Noto = central/high-degree → needs "gusto").
- **Economy is capability-without-leverage for the AI:** it never reinforces/transfers to the front and never buys men, so an economic lead can't be converted — you out-tempo a "winning" economy despite the AI's 210 stat cap (you at 140–150).

**Promotes:** Chris's playthrough specimen → thesis; a clean worked example of vault [[capability-without-leverage]] and [[dominance-frontier-lens]] ("random-start viability as the design verdict"). **Unblocks:** (a) `army-bv.lua` invade-risk column (men-share 47%, separate from BV); (b) the **starting-fief viability/patsy map** (per fief: any adjacent AI men-share > 47% at t=0? Noto-17fief = hypothesis-zero patsy) — Pages data artifact #5 + how-to-play #4.
**Open:** exact `fief_men_if_provisioned` rice-gating; `relations_rng_predicate`/`$6E7F` minority-owner override specifics; `const_two` (difficulty) effect on the +rng spread.

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
      + (your side is the DEFENDER ? m : 0)            // +100% — war_side_state_flag[side] bit7: the defender's when it defends a capital, the attacker's when daimyo-led [CORRECTED 2026-11-11, #45: was "defender only"]
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
  - **NET "strong army" ranking:** men (base, counted ~2×+) → terrain (castle = +270%, the single biggest lever) → the daimyo bonus (+100%: a capital's defender, or a daimyo-led attacker; #45) → unit-position advantage (+100%) → win the stat contest (+≤40%, dominated by training & IQ) → momentum (+20%/exchange) → minus the player difficulty tax. **Primitives ROM-certified; weights bytecode-confirmed; EMULATOR-CERTIFY the difficulty-scale direction + the casualty amounts.**

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
- **RUN #9 (v7 full-array recorder + diff-based analyzer, Mino fief8 atk → Iseshima fief12 def) — ✅ TERRAIN IS A DEFENSIVE BONUS (the `def` model, confirmed by DISCRIMINATING evidence).** The offline analyzer scored each exchange under flat / sym / def. The two castle situations split the models cleanly:
  - castle unit **ATTACKING** (`cur(s1u0)@CAS → s0u1@.`, obs tgt−2): `flat OK, sym ✗(−4), def OK` → terrain gave the attacker NO boost.
  - castle unit **BEING ATTACKED** (`cur(s0u1)@. → s1u0@CAS` and `cur(s0u2)@. → s1u0@CAS`, obs tgt−1/−2): `flat ✗(−3), sym OK, def OK` → terrain reduced the defender's casualties.
  `flat` fails the second, `sym` fails the first; **only `def` survives both.** So **terrain strengthens the unit BEING ATTACKED (reduces its casualties), and does nothing for the attacker** — `ai_terrain_strength_term` enters as a DEFENSIVE term, NOT the symmetric strength-term. This is the discriminating result the earlier runs lacked (it's why flat#5, sym#7 each "confirmed" wrongly). RESOLVED.
  - **The "log now, calc later" rearchitecture is what cracked it:** v7 recorder logs the full men[10]/col[10]/row[10] arrays (the write-LABEL desyncs during bursts, so the analyzer DIFFs the arrays); analyzer pairs exchanges with target = OPPOSITE side from cur (fixed a same-side mis-pairing). Low-fidelity (≤2-man) exchanges flagged & ignored.
  - Remaining tiny: one `+1` gain at `$9D4B` (conservation: classify redistribution vs reinforcement); forest/town defensive multipliers (castle confirmed).
- **RUN #10 (high-men forest, Musashi fief2 atk → Noto fief15 def) — exposes a TOOL problem: per-casualty ATTACKER ATTRIBUTION is unreliable, so high-men scoring can't be trusted yet.** Smoking gun: an exchange `cur(s1u2,2 men) -> s0u2(15 men), obs tgt−8` — a 2-man unit's S is ~6, max ~2 casualties; it CANNOT deal 8. So the `cur` registers (`$7BE8/$7BE4`) are STALE — they don't reliably name the unit that dealt a given casualty (a bigger defender hit s0u2 while `cur` still pointed at s1u2). This poisons every model prediction at high men (wrong attacker → wrong p), and explains the inconsistencies here (#2 big forest unit takes ⅓ of predicted; #5 castle-defender matches FLAT not def; #10 castle-attacker "deals double"). **Implication: run-#9's clean `def` result was clean by LUCK (few units, little interleave → `cur` happened to be right); it is NOT a high-men certification.** The men/pos ARRAYS remain ground truth; WHO attacked is the missing piece.
- **NEXT (before any more terrain conclusions): recover the real attacker per casualty** — (a) infer it from positions (the trusted arrays: the enemy unit ADJACENT to the target), or (b) trace the combat loop for where the true attacker is held vs the stale `cur`; (c) interim guard: analyzer flags physically-impossible exchanges (attacker too weak for the observed casualties) and discards them. Terrain rule (defensive vs exact magnitudes) stays OPEN until the attacker is trustworthy.
- **PAUSED 2026-06-13.** Combat CORE (men+home+rank+8stat40+momentum, p=share) is first-order-correct (matches clean/low-interleave exchanges). Terrain affects melee (deviates from flat) but the exact rule is NOT certified — blocked on the attacker-attribution tool issue above. Off-screen resolver + player tax still untested.
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
- **Synthesis read (TENSIONED — see open Qs):** the price scales to your treasury (so it never feels cheap *at full coffers*), the AI gates the offer on 1/skill and refuses the weak, and the product is a relation number (70/90) that **decays once a year** (Winter, ledger #24). *[Corrected by #49: the pact's fief cell decays every season, 10 a year; the marriage's daimyo cell 2 a year, in season 0.]* First read: a regressive sink the strong don't need and the weak can't get. BUT the price formula is **gameable** (below) and relation **does** gate AI aggression — so whether diplomacy is a dead sink or a cheap shield is genuinely open and hinges on quantifying decay-vs-deterrence.

**OPEN QUESTIONS raised by the diplomacy pair (added 2026-06-12, Chris):**
1. **Resolved 2026-11-13 → #49** (one roll in the war commit, blocks multiply per season; decay 10/yr pact, 2/yr marriage). **What does the `relation` value actually buy?** Readers found (ledger #20 grep): `$9422` AI war-target selection spares a target when `rng(100) < relation(target,you)` AND `daimyo.Drive < 50`; `$827C` ally-cooperation roll → War's *"They are your allies!"* block; decay `$9103/$9139` each turn. OPEN: the **decay rate/period**, the effective **deterrence threshold** (is 70 enough to reliably stop a war? how many turns before it bleeds below useful?), the `order_flag` (directional vs symmetric) semantics, and whether the AI ever *raises* relation (only Pact/Marry/normalize seen). Map the full reader set + emulate a pact→decay→AI-attack-roll sequence.
2. **Resolved 2026-11-13 → #49** (the cheese works, about 20 gold, but buys about two seasons against a hard gate). **The gold-cheese (price ∝ current gold).** Because Pact price = `~50–99%·gold + 20`, **spending your treasury down first collapses the cost to ~20** (Grow/Build/Dam/Give convert gold→development, then Pact for pocket change — Drive, not gold, becomes the limiter). Marry is partly cheese-proof: the **floor `gold > 200` + flat `+200`** keeps its dowry ≳ 300 even at the floor. Neither the weakness gate nor the 1/skill offer odds depend on gold, so emptying the treasury doesn't reduce *availability*. → IF relation buys meaningful AI-aggression deterrence (Q1), the spend-down-then-Pact line is a **cheap defensive lever** bounded only by Drive (−1/−2 per attempt) and per-turn decay. Quantify: cost-per-turn-of-deterrence via the cheese vs. the value of the deterrence.

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
- ~~**Kill = ATTRITION, not one-shot**~~ **Overturned by #55 (cartridge-checked): any landed, un-countered hit kills; `$9293` is `230 > health` → kill.** Original read (`$9264–$92B5`): on success, deduct `rng(1 .. health/(1+counter))`
  from target `health (+1)`; the daimyo **dies when health reaches 0** (avg ~2 un-countered hits). At a
  capital, death → `find_fiefs_of_owner` neutralizes EVERY fief the daimyo owns (faction collapse). The
  `230 >` constant at `$9290` is vestigial (health ≤115).
- **Garrison does NOT protect** (`$9213`, field = **men**, record +16): `if men ≤ rng(1-10)` an extra
  defensive roll runs (using target **Luck**/10 & /100 — the C's `local7` mislabeled IQ; bytecode `+3`=
  Luck); otherwise (men > ~5) it jumps **straight to the success path**. A defended capital gets *no*
  defensive roll. Counterintuitive; flagged for an emulator sanity-check. **#55:** the empty-fief roll never blocks either (it needs `rng(Luck/100) ≠ 0`, Luck ≥ 200), so the ninja count never matters.
- **Cost paid win or lose** (`math32_muladddiv(hire_gold_rate, unit_count)`, `$A452`/`$A2CB`).

**Synthesis takeaway:** the dominant pick is **high-Luck AND high-Charisma** (Luck gates the attempt +
defends the empty-fief roll; Cha+IQ wins the resolution + counterattack). No guard stat exists — the
only defense is the target's own probabilistic Luck/Cha/IQ. Cheap + repeatable + removes a whole
faction = the engine half of the README thesis, now grounded.

**RNG surface of the kill path (the TAS exploit, measurable) — enumerated from the `$918D` bytecode:**
7 `rng_mod` draws between attempt and kill. **#55:** only the two counter draws matter; a landed hit is already a one-shot kill, with no RNG to force.

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
next step is to drive `$918D` from the ROM with a fixed RNG stream and demonstrate health→0 in one mission.* **Done in #55:** health → 0 in one mission, 30/30 against Saito.

**Decompiler defect found (logged tech-debt §1.6):** the C renders `case 4` (assassinate) falling
through into `case 5` (arson); bytecode `$A50D` is `JUMP $A41D` (shared tail) — a switch emit mis-render.

---

## Meta-game artifact: what each daimyo stat affects (accumulating — CONFIRMED only)
The player-facing "what to look for when rolling a character / facing the AI" reference. Add a row only
when bytecode-confirmed; the scout pass proposed more (Drive→combat, Charisma→bribe/harvest, Luck+IQ→
train) but those are PROBABLE until verified.

| stat (offset) | confirmed effects | source |
|---|---|---|
| Health (+1) | the daimyo's **life pool**: 0 = death. A landed assassination sets it to 0 at once; a counter costs the *attacker* rng(health/2)+1 | #1, #55 |
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
