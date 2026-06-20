"""
na1sim — a high-fidelity, headless, formula-grounded simulator for
Nobunaga's Ambition (NES), 17-fief scenario.

Design (mirrors the Monopoly sim): the ENGINE (economy, harvest, combat,
turn loop) is fully decoupled from POLICY (who decides each fief's moves).
The decoded daimyo AI is itself just one policy; the player/Hida slot can be
swapped for a tuned policy. A Monte-Carlo harness sweeps RNG seeds to wash
out variance and produce survival/dominance curves.

Every formula traces to a bytecode-certified source in the repo docs:
  - economy:   appendix-formulas.md  (Grow/Build/Give/Dam/Tax/Harvest)  -> econ.py
  - AI:        12-daimyo-ai.md        (ai_econ_command_dispatch cascade) -> ai.py
  - combat:    21-combat-resolution.md (off-screen resolve_siege_$8DFD)  -> combat.py

NOTHING here is a guess. Where a value is not yet extracted from ROM
(daimyo personal stats), it is loudly marked PLACEHOLDER and tracked in
ROADMAP so it can't masquerade as grounded.
"""
