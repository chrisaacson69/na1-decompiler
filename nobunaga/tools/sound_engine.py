#!/usr/bin/env python3
"""sound_engine.py - NA1's adapter for the emu-harness sound lane (emu_harness.machines.nes.sound).

The ROM drives its sound engine in two halves, and the adapter runs both as the game does:
  request : sound_request_id ($7FE5) = id, then bank 10's play_audio_by_id ($8003, bytecode) on the
            game's own VM. A song (id < 27) loads three voices from play_audio_by_id_stream_ptrs
            ($8617, id*3) and arms them; an effect (27-63) loads one. The two audio syscalls
            (audio_load_voice $09, audio_control $0A) run through the ROM's own kernel handlers
            (NobunagaVM.native_syscalls), not the VM's Python stand-ins.
  tick    : music_driver ($C7A5, native), what nmi_handler calls once a frame: the trigger pass
            programs a newly armed voice's channel, the sequencer pass steps every playing one.
  init    : what reset writes ($4015 = $1F, $4017 = $C0), and audio_wait_gate ($6F4D) = 1, which
            init_new_game_state sets (play_audio_by_id does nothing while it is 0).

Events are the ids the game requests by constant, named by the routine that requests them
(source/4-c); bank 14's run_cutscene also requests ids from its data.

    py -3.14 -m emu_harness.machines.nes.sound tools/sound_engine.py          # summary
    py -3.14 -m emu_harness.machines.nes.sound tools/sound_engine.py --wav assets/sound
"""
from emu_harness.vm.koei.nes import titles

SOUND_REQUEST_ID = 0x7FE5
AUDIO_WAIT_GATE = 0x6F4D
PLAY_AUDIO_BODY = 0x8008        # play_audio_by_id ($8003) + the 5-byte vm_entry stub
AUDIO_BANK = 10
MUSIC_DRIVER = 0xC7A5
SYSCALL_AUDIO_LOAD_VOICE, SYSCALL_AUDIO_CONTROL = 0x09, 0x0A
RETURN_SENTINEL = 0xFFFF        # an RTS from the outermost call lands here
PRG_BANK_SHADOW = 0x73          # set_prg_bank skips the switch when the shadow already matches


class Engine:
    # name -> (sound id, hold[, "loop"]). The game requests each sound once (hold 1); the three songs
    # then repeat by themselves (the --list summary: still writing after 50 s; find_loop measures them).
    events = {
        "s00_new_game":            (0, 1, "loop"),   # init_new_game_state $89AD; ending prompt $81B7
        "s01_after_jingle":        (1, 1, "loop"),   # vm_bootstrap $A781..; play_result_jingle, after the cue
        "s02_battle_start":        (2, 1, "loop"),   # battle_init_driver $AFF8
        "s03_battle_lost":         (3, 1),        # announce_battle_outcome_retreat_or_won $946F
        "s04_battle_won":          (4, 1),        # (is_winner ? 4 : 3)
        "s05_game_ending":         (5, 1),        # show_game_ending_and_play_again_prompt $808C
        "s06_game_ending_2":       (6, 1),        # show_game_ending_and_play_again_prompt $811D
        "s07_jingle_fail":         (7, 1),        # play_result_jingle $8BA5 (failed ? 8 : 7)
        "s08_jingle_ok":           (8, 1),
        "e27_province_command":    (27, 1),       # issue_province_command $B7DF
        "e28_auction":             (28, 1),       # auction_ownerless_fief_to_bidders $8CC7
        "e29_fief_pair_clear":     (29, 1),       # clear_fief_pair_matrix $E1EE
        "e30_conflict":            (30, 1),       # takeover / revolt / AI event ($8F17, $9796, $9F21, $9F3D)
        "e31_combat_unit_0":       (31, 1),       # validate_phase_unit_cells_draw_cursor $9B59
        "e32_combat_unit_1":       (32, 1),       #   (wrap_index_0_2_to_zero(slot) + 31)
        "e33_combat_unit_2":       (33, 1),
    }

    def machine(self):
        self.vm, _ = titles.make_vm("na1")
        self.vm.native_syscalls = {SYSCALL_AUDIO_LOAD_VOICE, SYSCALL_AUDIO_CONTROL}
        self.vm.mem.mmc1_serial = True          # the driver banks in each stream byte (set_prg_bank)
        return self.vm.mem

    def init(self):
        m = self.vm.mem
        m.write(0x4015, 0x1F)
        m.write(0x4017, 0xC0)
        m.write(AUDIO_WAIT_GATE, 1)

    def request(self, sound_id):
        vm = self.vm
        vm.mem.write_word(SOUND_REQUEST_ID, sound_id)
        bank, shadow = vm.mem.bank_lo, vm.mem.read(PRG_BANK_SHADOW)
        vm.switch_bank(AUDIO_BANK)                   # what call_bank_wrap(10) does: bank and shadow
        vm.mem.write(PRG_BANK_SHADOW, AUDIO_BANK)
        vm.cpu.sp = 0xFD
        vm.vm_fp = 0x05FF
        vm.vm_sp = (0x05FF - 6) & 0xFFFF            # play_audio_by_id's frame_off
        vm.vm_pc = PLAY_AUDIO_BODY
        vm.cpu.pc = vm.DISPATCHER_ADDR
        vm.run_until_outermost_return(max_ops=200_000)
        vm.switch_bank(bank)
        vm.mem.write(PRG_BANK_SHADOW, shadow)

    def tick(self):
        cpu = self.vm.cpu
        cpu.a = cpu.x = cpu.y = 0
        cpu.sp = 0xFD
        cpu.push_word((RETURN_SENTINEL - 1) & 0xFFFF)
        cpu.pc = MUSIC_DRIVER
        cpu.run_until({RETURN_SENTINEL}, max_steps=200_000)
