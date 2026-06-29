"""na1dream — BACK-COMPAT ALIAS to `koeivm` (the graduated VM core).

The KOEI-NES VM/decompiler engine was graduated out of this repo into koei-nes
(`koei-nes/tools/koeivm/`) so koei-nes is self-contained and every game repo is a
thin consumer. This package is now a thin shim: `na1dream.X` loads the *same*
source as `koeivm.X` (via a shared __path__), so NA1's existing tools keep working
unchanged. New engine work happens in koeivm; do NOT add real code here.

The only NA1-specific bit is the default ROM/labels path: koeivm's defaults point
at koei-nes (no labels file there), so we re-point them at this repo for NA1 tools
that rely on load_labels()/ROM_PATH.
"""
import sys, pathlib

# Locate the graduated engine (sibling layout: na1-decompiler/ and koei-nes/ side by side).
_koeivm_tools = pathlib.Path(__file__).resolve().parents[4] / "koei-nes" / "tools"
if not (_koeivm_tools / "koeivm").exists():
    raise ImportError(f"koeivm (graduated VM core) not found at {_koeivm_tools}; clone koei-nes as a sibling of na1-decompiler")
if str(_koeivm_tools) not in sys.path:
    sys.path.insert(0, str(_koeivm_tools))

import koeivm  # the real engine

# Make `na1dream.X` resolve to koeivm's source files (same code, na1dream-named modules).
__path__ = list(koeivm.__path__)

# Re-point the NA1-layout defaults (koeivm's defaults sit at koei-nes, which has no NA1 labels/ROM).
from . import nobunaga_vm as _nv   # loaded from koeivm source via the shared __path__
_na1_root = pathlib.Path(__file__).resolve().parents[2]   # na1-decompiler/nobunaga/ (na1dream -> tools -> nobunaga)
_nv.ROM_PATH = _na1_root / "Nobunaga's Ambition (USA).nes"
_nv.LABELS_PATH = _na1_root / "mesen-labels.toml"
