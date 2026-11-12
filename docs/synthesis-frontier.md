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
