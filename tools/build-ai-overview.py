#!/usr/bin/env python3
"""
build-ai-overview.py — generate ai.html, the consolidated overview of how the
enemy AI plays Nobunaga's Ambition.

This is a HUB page (Chris's call, 2026-06-03): it tells the end-to-end AI story
at a summary level and links INTO the existing turn-loop deep-dives
(turn-loop-planner / -command / -combat) rather than duplicating them. The four
acts of an AI daimyo's existence map onto pages we already have:

    Plan  -> turn-loop-planner.html   (the per-season tick + events)
    Act   -> turn-loop-command.html   (the per-fief command pass)
    War   -> (summarized here, with the two now-closed threads)
    Fight -> turn-loop-combat.html    (the battle engine + battle-brain)

Source-of-truth = the SECTIONS / FINDINGS registries below. HTML is DERIVED;
never hand-edit ai.html. Reuses the turn-loop hub CSS + the command-page shell.

Walk that produced this: AI command-pass decode + war re-walk + policy/capital
census, 2026-06-03 ([[project_nobunaga_ai_command_pass]]).

Usage:
    py -3 tools/build-ai-overview.py
"""
import importlib.util
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# reuse the turn-loop hub's CSS (which itself extends the command-page shell)
_spec = importlib.util.spec_from_file_location(
    "build_turn_loop", Path(__file__).resolve().parent / "build-turn-loop.py")
_btl = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_btl)
_bcp = _btl._bcp
HUB_CSS = _btl.HUB_CSS

# ── The four acts of an AI daimyo's turn. Each links to its deep-dive page. ────
SECTIONS = [
  dict(no="1", act="Plan", title="The world ticks",
       page="turn-loop-planner.html", page_label="turn-loop-planner.html",
       addr="ai_strategic_turn_planner $A455",
       body=(
         "<p>Before any daimyo acts, the planner runs the whole world forward one season: "
         "the calendar, the season-phased economy (stat drift, the tax→income harvest, aging + "
         "natural death), and the <b>random-event engine</b> (floods, quakes, riots, revolts). "
         "Two outputs matter to the AI specifically:</p>"
         "<ul>"
         "<li>It sets the <code>daimyo_weakness_flag</code> on low-health lords "
         "(<code>P(mark) = (100 − health) / 400</code>) — a vulnerability mark the war step reads.</li>"
         "<li>The ravage event <code>random_event_ravage_output_hidden_mark_weakness $9D00</code> "
         "(men &amp; output × 50–99%) is one of the disasters it can fire — <b>not</b> an AI command, "
         "and no longer an unknown routine.</li>"
         "</ul>")),
  dict(no="2", act="Act", title="Each fief takes its turn",
       page="turn-loop-command.html", page_label="turn-loop-command.html",
       addr="ai_per_fief_command_driver $B89B",
       body=(
         "<p>The turn order is reshuffled, then every fief is handed to the command driver, which "
         "dispatches on <code>province_ai_state</code> — the Grant policy. <b>The headline we proved "
         "by save-state census:</b> those six policies are a <i>player</i> tool (the Grant command); "
         "the enemy never uses them. Every AI fief sits permanently at state 0 (Home), which routes to "
         "the RNG-weighted <b>Balanced</b> dispatcher <code>ai_econ_command_dispatch</code>:</p>"
         "<pre>~9/10 turns:  try recruit / arm / train  (and this is where war is attempted)\n"
         "else:         develop town  +  dam / grow output</pre>"
         "<p>So the AI is <b>monomorphic</b>: one universal loop on every fief. The variety you see "
         "between AI fiefs is their differing resource surplus + RNG + daimyo stats, not a chosen "
         "personality. Spending also <b>scales with the year</b> (<code>(year − 1559) × N</code>) — "
         "the AI escalates on a calendar ramp.</p>")),
  dict(no="3", act="War", title="Whether — and whom — to attack",
       page="turn-loop-command.html", page_label="turn-loop-command.html (war section)",
       addr="ai_try_war_attack $949A",
       body=(
         "<p>Inside the command pass, a fief may try for war. The decision is a filter, not a gamble — "
         "and re-walking it this pass closed both of the project's parked AI threads:</p>"
         "<ol>"
         "<li><b>Self-gate.</b> No attack if the attacker's own daimyo is weakness-marked, or has no "
         "men, or no gold.</li>"
         "<li><b>Candidates = adjacent enemies only.</b> The list is seeded from the adjacency table "
         "(<code>$8004</code>) and filtered to active, enemy-owned fiefs. Geography is hard-coded into "
         "the target set.</li>"
         "<li><b>Target = the weakest neighbour.</b> <code>pick_weakest_men_fief</code> returns the "
         "adjacent enemy with the <b>fewest provisioned men</b> — and a fief <b>out of rice counts as "
         "zero men</b>, so supply attrition makes a fief prey. A grudge override (rival <code>$6E7F</code>) "
         "and a Drive-gated diplomatic pick can replace it.</li>"
         "<li><b>Commit gate.</b> Muster ≈ 60–89% of <code>min(gold, men, rice×2)</code>, and attack "
         "<b>only if that force ≥ the defender's weaker of {men, rice}</b>. Weakest-prey selection, but "
         "a genuine strength check — the AI isn't reckless.</li>"
         "</ol>"
         "<p class='sub'><b>Thread 1 closed — the tiebreak locus.</b> The “which of several valid targets” "
         "logic lives entirely in this picker chain, and it keys on <b>provisioned men</b> "
         "(<code>fief_men_if_provisioned</code>), not the long-hypothesised men×morale×arms “power.”</p>"
         "<p class='sub'><b>Thread 2 closed — the $6DA2 flag.</b> A save-state census proved "
         "<code>$6DA2 = fief_is_daimyo_capital</code> (exactly one home-seat per living daimyo). It "
         "transfers on conquest, gives a <b>defensive bonus</b> when a capital is the fief under attack, "
         "and the living-daimyo count drives the victory check.</p>")),
  dict(no="4", act="Fight", title="The battle resolves",
       page="turn-loop-combat.html", page_label="turn-loop-combat.html",
       addr="battle_init_driver $AFE1 (bank 2)",
       body=(
         "<p>Once an attack commits, control passes to the bank-2 battle engine — its own deep dive. "
         "The piece that closes the AI loop is the <b>battle brain</b> "
         "<code>ai_sum_battle_strength $8E5D</code>: a weighted attacker-vs-defender tally with weights "
         "<code>[HEALTH 5, DRIVE 10, LUCK 10, CHARISMA 5, IQ 20, morale 10, skill 25]</code>. "
         "<b>IQ (20) is the dominant daimyo stat</b>; province skill (25) the biggest term overall; and "
         "the capital flag adds its defensive <code>(capital+2)×weight</code> here. Casualties then come "
         "from the three-mechanism model (rice clock / relative-strength kills / charisma capture).</p>")),
]

FINDINGS = [
  ("The enemy AI is monomorphic — it never picks a style.",
   "<code>province_ai_state</code>’s six Grant policies are a player affordance. A census across every "
   "save (<code>tools/probe-ai-policy-distribution.py</code>) shows every AI fief permanently at 0 (Home); "
   "states 1–4 appear only where the player granted them. The AI runs one loop — the Balanced dispatcher — "
   "on every fief, every turn."),
  ("It hunts the weakest neighbour, but checks it can win.",
   "Target selection (<code>pick_weakest_men_fief</code>, ROM-confirmed via "
   "<code>probe-ai-war-target.py</code>) prefers the fewest-provisioned-men adjacent enemy; the commit gate "
   "then requires the mustered force to beat the defender’s weaker of {men, rice}. Soft target + winnable "
   "fight — which is why under-strength AI attacks are uncommon, not the rule."),
  ("It escalates on the calendar, not just on conquest.",
   "Every AI spend cap is <code>(year − 1559) × N</code>, so the opponent plays small early and commits far "
   "more per command in the late game — a built-in difficulty ramp independent of territory."),
  ("Strategy emerges from state, not from a planner.",
   "There is no global AI strategist choosing builds or fronts. Each fief independently runs the same "
   "probabilistic loop against its own resources and its daimyo’s stats; the macro behaviour (snowballing, "
   "border wars, capital defence) is emergent from 49 copies of one simple rule."),
]


def render():
    cards = ""
    for s in SECTIONS:
        exists = (ROOT / s["page"]).exists()
        link = (f'<a href="./{s["page"]}">→ {s["page_label"]}</a>' if exists
                else f'<span style="color:var(--dim);font-weight:600">{s["page_label"]}</span>')
        cards += (
          f'<div class="phase" id="act{s["no"]}">\n'
          f'  <div class="bank">Act {s["no"]} · {s["act"]}</div>\n'
          f'  <h3>{s["title"]} <span class="addr">{s["addr"]}</span></h3>\n'
          f'  {s["body"]}\n'
          f'  <div class="branch"><b>Deep dive:</b> {link}</div>\n</div>\n')
    mapitems = ""
    for s in SECTIONS:
        mapitems += (f'  <li><a href="#act{s["no"]}">{s["act"]} — {s["title"]}</a>'
                     f'<span class="addr">{s["addr"]}</span>'
                     f'<span class="gloss">→ {s["page_label"]}</span></li>\n')
    finds = "".join(f'<div class="find"><b>{t}</b> {b}</div>\n' for t, b in FINDINGS)
    body = (
      '<header>\n  <div class="cmdno">Nobunaga’s Ambition · NES · The Engine</div>\n'
      '  <h1>How the AI Plays</h1>\n'
      '  <div class="tag">The enemy daimyo, end to end — one consolidated map over the turn-loop deep dives.</div>\n'
      '</header>\n\n'
      '<div class="skills">\n  <span>① decompiler → C</span>\n  <span>② data-walk labels</span>\n'
      '  <span>③ bytecode-verified flow</span>\n  <span>④ emulator/census oracle</span>\n</div>\n\n'
      '<p class="lead">An enemy daimyo never runs a grand strategy. Its whole existence is <b>four acts</b> '
      'repeated every season — the world ticks, each fief takes one command, a fief may go to war, and battles '
      'resolve — and we’ve decoded every act against the post-fix decompile. This page is the <b>map over them</b>; '
      'each act links to its full deep-dive. The surprise the walk turned up: the AI is far <b>simpler than it '
      'looks</b> — one probabilistic loop, copied across every fief, with the apparent cunning emerging from state '
      'rather than from any planner.</p>\n\n'
      '<h2>An AI daimyo’s turn, in four acts</h2>\n'
      f'<ol class="map">\n{mapitems}</ol>\n\n'
      '<h2>The four acts</h2>\n'
      f'{cards}\n'
      '<h2>What this AI actually is</h2>\n'
      '<p class="sub">The conclusions that survived re-walking and oracle checks:</p>\n'
      f'{finds}\n'
      '<footer>\n  ← <a href="./turn-loop.html">the main turn-loop map</a> &nbsp;·&nbsp;\n'
      '  Sources: <code>decompiled/bank_0{0,1}.c</code> · <code>tools/probe-ai-war-target.py</code> · '
      '<code>tools/probe-ai-policy-distribution.py</code> · '
      'deep dives <a href="./turn-loop-planner.html">planner</a> / '
      '<a href="./turn-loop-command.html">command</a> / <a href="./turn-loop-combat.html">combat</a> · '
      'memory <code>project_nobunaga_ai_command_pass</code>.\n'
      '  Generated by <code>tools/build-ai-overview.py</code> — do not hand-edit; edit the registry and regen.\n'
      '</footer>')
    return _bcp._page("How the AI Plays — Nobunaga’s Ambition", body).replace(
        f"<style>{_bcp.CSS}</style>", f"<style>{HUB_CSS}</style>")


def main():
    out = ROOT / "ai.html"
    out.write_text(render(), encoding="utf-8")
    print(f"  wrote {out.relative_to(ROOT)}  ({out.stat().st_size} bytes, {len(SECTIONS)} acts)")


if __name__ == "__main__":
    main()
