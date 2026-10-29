#!/usr/bin/env python3
"""Batch-render every lord-command animation (clipped) into the canonical
assets/animations/<command>.{gif, frames/<command>-frames.png}, then rebuild
all command pages. Pulls the command->anim_id map from build-command-page.py's
COMMANDS spec. Run from anywhere: `py -3 tools/batch-render-anims.py`.
"""
import importlib.util, subprocess, shutil, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location("bcp", ROOT / "tools" / "build-command-page.py")
bcp = importlib.util.module_from_spec(spec); spec.loader.exec_module(bcp)

SRAM = ROOT / "traces" / "exp-fall-1560-start.dmp"
ANIM = ROOT / "assets" / "animations"
TMP  = ANIM / "_tmp"
PY   = sys.executable

results = []
for cmd, s in bcp.COMMANDS.items():
    aid = s.get("anim_id")
    if aid is None:
        results.append((cmd, None, "no animation")); continue
    r = subprocess.run([PY, str(ROOT / "tools" / "run-animation.py"), str(aid),
                        "--sram", str(SRAM), "--out", str(TMP / "a")],
                       capture_output=True, text=True)
    gif = TMP / f"a-{aid}.gif"; frm = TMP / f"a-{aid}-frames.png"
    if gif.exists():
        shutil.copy(gif, ANIM / f"{cmd}.gif")
        if frm.exists():
            shutil.copy(frm, ANIM / "frames" / f"{cmd}-frames.png")
        size = next((l.split("(")[-1].rstrip(") \n") for l in r.stdout.splitlines()
                     if "frames," in l), "?")
        results.append((cmd, aid, size))
    else:
        err = (r.stderr.strip().splitlines() or ["no gif produced"])[-1]
        results.append((cmd, aid, "FAILED: " + err[:60]))

if TMP.exists():
    shutil.rmtree(TMP, ignore_errors=True)

print("=== batch render ===")
for cmd, aid, info in results:
    print(f"  {cmd:9} {('anim '+str(aid)) if aid is not None else '—':10} {info}")

# rebuild every page from the (now refreshed) canonical animations
subprocess.run([PY, str(ROOT / "tools" / "build-command-page.py"), "build", "all"],
               cwd=ROOT / "tools", capture_output=True, text=True)
ok = sum(1 for _, a, i in results if a is not None and "FAIL" not in i)
total = sum(1 for _, a, _ in results if a is not None)
print(f"\n{ok}/{total} animations rendered (clipped) + all command pages rebuilt")
