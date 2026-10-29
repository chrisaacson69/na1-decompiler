"""walk_guard.py: moved to emu_harness.walk.guard (emu-harness MIGRATION.md row J), which also holds
AeroBiz's stricter name-mapping guard. This file is an alias: `from walk_guard import
snapshot_decompiled, find_guard_violations` gives that module's functions, unchanged."""
import importlib
import sys

sys.modules[__name__] = importlib.import_module("emu_harness.walk.guard")
