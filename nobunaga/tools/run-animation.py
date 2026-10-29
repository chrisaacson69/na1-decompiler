"""
run-animation.py — pull a command/event ANIMATION out of the ROM and render it,
purely from ROM bytes (no Mesen capture).

The game's animations are a small bytecode SCRIPTING VM:
  - `ui_helper_e80c(id)` stores the animation id at $7FCB, then calls bank 14.
  - bank-14 entry `$80AD` reads $7FCB, indexes a 5-byte descriptor table at
    bank-14 $AF80  -> {byte chr/data bank, word data_src, word command_stream}.
  - it loads the data block, writes the palette, uploads the base CHR, then runs
    a 22-opcode command stream that drives sprite frames (set_sprite -> OAM),
    palette cycles, sound (bank 10) and frame delays.

This tool drives `$80AD` in the headless VM (tools/nobunaga_vm), intercepts the
graphics syscalls to maintain a Python PPU model (CHR-RAM + palette + OAM),
snapshots a frame at each present point (prompt_redraw / delay_loop), and renders
each frame's sprites with the real NES palette -> PNG frames + an animated GIF.

Usage:
    py -3.14 tools/run-animation.py <id> [--sram traces/X.dmp] [--out assets/animations/anim]
                                 [--pt 0|1] [--h 8|16] [--scale N] [--trace]
    py -3.14 tools/run-animation.py --list      # dump the descriptor table

Animation ids (descriptor table $AF80): 9 = Grow. (others TBD as labeled.)

The interpreter harness, the PPU model and the NES pixels are the shared library's
(emu_harness.vm.koei.nes.assets.animation, machines.nes.ppu), checked against Mesen's own
PPU during Train (emu-harness row O3); this tool keeps NA1's CLI and descriptor listing.
"""
import sys, argparse
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from na1dream.nobunaga_vm import NobunagaVM

from emu_harness.machines.nes import ppu as NR
from emu_harness.vm.koei.nes.assets import MASTER
from emu_harness.vm.koei.nes.assets import animation as KA

# The NES master palette (index -> RGB): the KOEI asset layer's one table.
NES_PALETTE = MASTER

ANIM_DESC = 0xAF80     # bank 14, 5 bytes/entry: {bank, data_src(LE), stream(LE)}
ANIM_BANK = 14
ADDR_7FCB = 0x7FCB     # animation-id selector (written by ui_helper_e80c)
PPU_UPLOAD_WRAP = 0xCF7C   # ppu_upload_block_wrap(bank, src, dst_ppu, count)
DELAY_LOOP = 0xD73E
PROMPT_REDRAW = 0x8003
OAM_SHADOW = 0x0600    # set_sprite ($03) target: [Y, tile, attr, X] * 64
PAL_SHADOW = 0x0700    # palette_write ($04) target: 32 entries


def descriptor(vm, aid):
    base = ANIM_DESC + aid * 5
    b = [vm.read_banked(ANIM_BANK, (base + i) & 0xFFFF) for i in range(5)]
    return b[0], b[1] | (b[2] << 8), b[3] | (b[4] << 8)


def list_descriptors(vm):
    print("id  bank  data_src  stream")
    for aid in range(34):
        bank, src, stream = descriptor(vm, aid)
        mark = "  <- Grow" if aid == 9 else ""
        print(f"{aid:2d}   {bank:2d}    ${src:04X}     ${stream:04X}{mark}")


def decode_tile(chr_ram, addr, pal4):
    """2bpp tile at byte `addr` in chr_ram -> 8x8 list of (rgb, opaque?) using a 4-color palette."""
    return [(pal4[v], v != 0) for row in NR.decode_tile(chr_ram, 0, addr) for v in row]


def run(aid, sram, pt_base, sprite_h, scale, trace, out_prefix):
    """Interpret animation `aid` and write <out_prefix>.gif + <out_prefix>-frames.png."""
    KA.render_animation(aid, game="na1", sram=sram, pt=pt_base // 0x1000, sprite_h=sprite_h,
                        scale=scale, trace=trace, out_prefix=out_prefix)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("id", nargs="?", type=int)
    ap.add_argument("--sram", default=str(Path(__file__).resolve().parent.parent / "traces" / "exp-fall-1560-start.dmp"))
    ap.add_argument("--out", default=str(Path(__file__).resolve().parent.parent / "assets" / "animations" / "anim"))
    ap.add_argument("--pt", type=int, default=0, choices=(0, 1))
    ap.add_argument("--h", type=int, default=8, choices=(8, 16))
    ap.add_argument("--scale", type=int, default=3)
    ap.add_argument("--trace", action="store_true")
    ap.add_argument("--list", action="store_true")
    a = ap.parse_args()
    vm0 = NobunagaVM()
    if a.list:
        list_descriptors(vm0); return
    if a.id is None:
        ap.error("need an animation id (or --list)")
    out = f"{a.out}-{a.id}"
    run(a.id, a.sram, a.pt * 0x1000, a.h, a.scale, a.trace, out)


if __name__ == "__main__":
    main()
