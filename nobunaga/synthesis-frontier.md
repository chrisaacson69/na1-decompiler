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
- **The AI is structurally exploitable** — shares the player command path; war target is emergent
  weakest-neighbor with no real scorer. [from ROADMAP AI-fork findings — to re-confirm]
- **Luck decays → early-game window** — `drift_daimyo_luck $A2ED`. [UNVERIFIED — check sign/magnitude]
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
- **Synthesis read (TENSIONED — see open Qs):** the price scales to your treasury (so it never feels cheap *at full coffers*), the AI gates the offer on 1/skill and refuses the weak, and the product is a relation number (70/90) that **decays each turn**. First read: a regressive sink the strong don't need and the weak can't get. BUT the price formula is **gameable** (below) and relation **does** gate AI aggression — so whether diplomacy is a dead sink or a cheap shield is genuinely open and hinges on quantifying decay-vs-deterrence.

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
  `fief_tax_rate $6D2D`). OPEN (toml Inbox): the `$A32A` per-turn loyalty `×0.9` decay direction (fires at
  LOW tax — counterintuitive, recheck vs bytecode).
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
| Drive (+2) | the **diplomacy-attempt currency**: Pact/Marry each cost −1 Drive to attempt, −2 on Pact decline/refuse or Marry refusal; compared daimyo-vs-daimyo in combat (`$8EB8`) | #20 |
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
| 11 | Strategic engine (21 commands) | todo | **espionage/ninja portion already done** (ledger #1/#2) |
| 12 | Daimyo AI | todo | erratum ×2; the AI-exploitability leg lands here |
| 13 | Turn loop & harvest | todo | |
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
