"""na1dream — BACK-COMPAT ALIAS to the KOEI VM toolchain, now `emu_harness.vm.koei`.

The NA1 Dream Decompiler core graduated from this repo to koei-nes (`koeivm`, 2026-06-29) and then
to emu-harness (2026-10-23, its MIGRATION.md row F). `na1dream.X` IS `emu_harness.vm.koei.X`, the
same module object (emu_harness.core.alias), so NA1's tools keep working unchanged. New engine
work happens in emu-harness; do NOT add real code here.

The NA1 defaults (ROM, labels, asset enums) come from the engine's `na1` title profile
(games.toml), so nothing needs re-pointing here any more.
"""
from emu_harness.core.alias import alias_package

alias_package(__name__, "emu_harness.vm.koei", also=("emu_harness.vm.koei.nes",))
