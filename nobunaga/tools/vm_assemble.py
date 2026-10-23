"""vm_assemble.py: moved to emu_harness.vm.koei.nes.vm_assemble (emu-harness MIGRATION.md row F). This file is an alias:
`import vm_assemble` gives that module itself, and `py tools/vm_assemble.py ...` runs it as before."""
import importlib
import runpy
import sys

if __name__ == "__main__":
    runpy.run_module("emu_harness.vm.koei.nes.vm_assemble", run_name="__main__", alter_sys=True)
else:
    sys.modules[__name__] = importlib.import_module("emu_harness.vm.koei.nes.vm_assemble")
