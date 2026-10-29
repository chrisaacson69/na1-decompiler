r"""
capture-test.py — Snap Mesen's live SRAM dump under a meaningful name, and
diff pre/post when both are present.

Mesen's NesSaveRam.dmp lives in the Debugger directory and gets rewritten
each time you "Save Memory Dump" (Tools -> Memory Tools). This script copies
it into traces/ with a tag so it survives the next overwrite.

Usage (py -3.14: the Debugger folder comes from emu-harness):
    py -3.14 capture-test.py <tag> pre             ; snapshot before command
    py -3.14 capture-test.py <tag> post             ; snapshot after command
    py -3.14 capture-test.py <tag> diff             ; diff PRE vs POST (no copy)
    py -3.14 capture-test.py <tag> diff --fief 8    ; spotlight one fief

Examples:
    py -3.14 capture-test.py grow-25-spring pre
    (run Grow 25 in-game, save memory dump)
    py -3.14 capture-test.py grow-25-spring post
    py -3.14 capture-test.py grow-25-spring diff --fief 8

The PRE/POST files live in traces/<tag>_PRE.dmp and traces/<tag>_POST.dmp.
"""

import argparse
import shutil
import subprocess
import sys
from pathlib import Path

from emu_harness.backends.mesen import debugger_dir

# Mesen's GUI dump for this ROM, in its Debugger folder (emu-harness resolves the folder)
MESEN_DUMP = debugger_dir() / "Nobunaga's Ambition (USA) - NesSaveRam.dmp"
HERE = Path(__file__).resolve().parent          # tools/
PROJ = HERE.parent                                # project root
TRACES = PROJ / "traces"                           # data lands here regardless of CWD
DECODER = HERE / "sram-decode-province.py"          # co-located in tools/


def snapshot(tag, phase, note=""):
    if not MESEN_DUMP.exists():
        print(f"ERROR: live Mesen dump not found at {MESEN_DUMP}", file=sys.stderr)
        sys.exit(1)
    TRACES.mkdir(exist_ok=True)
    out = TRACES / f"{tag}_{phase.upper()}.dmp"
    shutil.copy2(MESEN_DUMP, out)
    print(f"snapped: {out}  ({out.stat().st_size} bytes)")
    # Self-register: every capture gets provenance at capture time (see data-index.py).
    subprocess.run(["py", "-3", str(HERE / "data-index.py"), "add", str(out),
                    "--note", note or f"{tag} {phase} snapshot"], check=False)


def diff(tag, extra_args):
    pre = TRACES / f"{tag}_PRE.dmp"
    post = TRACES / f"{tag}_POST.dmp"
    if not pre.exists() or not post.exists():
        missing = [p for p in (pre, post) if not p.exists()]
        print(f"ERROR: missing snapshot(s): {missing}", file=sys.stderr)
        sys.exit(1)
    cmd = ["py", "-3", str(DECODER), str(pre), "--diff", str(post)] + list(extra_args)
    subprocess.run(cmd, check=False)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("tag", help="Test name, e.g. grow-25-spring or give-rice-to-peasants")
    ap.add_argument("phase", choices=("pre", "post", "diff"))
    ap.add_argument("--note", default="", help="provenance for the index: what/why this capture")
    args, extras = ap.parse_known_args()
    if args.phase in ("pre", "post"):
        snapshot(args.tag, args.phase, note=args.note)
    else:
        diff(args.tag, extras)


if __name__ == "__main__":
    main()
