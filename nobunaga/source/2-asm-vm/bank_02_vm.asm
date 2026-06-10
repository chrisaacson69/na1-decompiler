VM bytecode disassembly
  ROM:          Nobunaga's Ambition (USA).nes
  mode:         bulk dump of bank 2
  opcode spec:  vm-opcodes-v2.toml via nobunaga_vm.OPCODE_INFO (execution-validated lengths)
  labels:       1329 CPU addresses named

  bank 2: found 131 bytecode-subroutine stubs

; ============================================================
; sub $8086   (frame_off=-10, body @ $808B)
; ============================================================
  $808B  A4 5B 6F                   LOADL_abs              $6F5B (active_province_idx_copy)
  $808E  D2                         LSHIFT1
  $808F  8C B1 6E                   LOADR_imm2             $6EB1 (daimyo_face_code_table)
  $8092  BB                         ADD
  $8093  B0                         DEREF
  $8094  2B                         STORE_quick   ; inline operand = 11
  $8095  0B                         LOADL_quick   ; inline operand = 11
  $8096  55                         LOADR_qimm   ; inline operand = 5
  $8097  B8                         UDIV
  $8098  29                         STORE_quick   ; inline operand = 9
  $8099  0B                         LOADL_quick   ; inline operand = 11
  $809A  55                         LOADR_qimm   ; inline operand = 5
  $809B  BA                         UMOD
  $809C  2A                         STORE_quick   ; inline operand = 10
  $809D  09                         LOADL_quick   ; inline operand = 9
  $809E  55                         LOADR_qimm   ; inline operand = 5
  $809F  B8                         UDIV
  $80A0  28                         STORE_quick   ; inline operand = 8
  $80A1  09                         LOADL_quick   ; inline operand = 9
  $80A2  55                         LOADR_qimm   ; inline operand = 5
  $80A3  BA                         UMOD
  $80A4  29                         STORE_quick   ; inline operand = 9
  $80A5  08                         LOADL_quick   ; inline operand = 8
  $80A6  55                         LOADR_qimm   ; inline operand = 5
  $80A7  B8                         UDIV
  $80A8  27                         STORE_quick   ; inline operand = 7
  $80A9  08                         LOADL_quick   ; inline operand = 8
  $80AA  55                         LOADR_qimm   ; inline operand = 5
  $80AB  BA                         UMOD
  $80AC  28                         STORE_quick   ; inline operand = 8
  $80AD  6C                         PUSH_qimm   ; inline operand = 12
  $80AE  8E F0 17                   PUSH_imm2              $17F0
  $80B1  0A                         LOADL_quick   ; inline operand = 10
  $80B2  8C C0 00                   LOADR_imm2             $00C0
  $80B5  B5                         MULT
  $80B6  8C 04 A6                   LOADR_imm2             $A604 (unpack_base5_digits_uplo_data_a604)
  $80B9  BB                         ADD
  $80BA  B3                         PUSHL
  $80BB  68                         PUSH_qimm   ; inline operand = 8
  $80BC  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $80C0  66                         PUSH_qimm   ; inline operand = 6
  $80C1  8E B0 18                   PUSH_imm2              $18B0
  $80C4  09                         LOADL_quick   ; inline operand = 9
  $80C5  8B 60                      BYTE_LOADR_imm1        +96
  $80C7  B5                         MULT
  $80C8  8C C4 A9                   LOADR_imm2             $A9C4 (unpack_base5_digits_uplo_data_a9c4)
  $80CB  BB                         ADD
  $80CC  B3                         PUSHL
  $80CD  68                         PUSH_qimm   ; inline operand = 8
  $80CE  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $80D2  66                         PUSH_qimm   ; inline operand = 6
  $80D3  8E 10 19                   PUSH_imm2              $1910
  $80D6  08                         LOADL_quick   ; inline operand = 8
  $80D7  8B 60                      BYTE_LOADR_imm1        +96
  $80D9  B5                         MULT
  $80DA  8C A4 AB                   LOADR_imm2             $ABA4
  $80DD  BB                         ADD
  $80DE  B3                         PUSHL
  $80DF  68                         PUSH_qimm   ; inline operand = 8
  $80E0  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $80E4  6C                         PUSH_qimm   ; inline operand = 12
  $80E5  8E 70 19                   PUSH_imm2              $1970
  $80E8  07                         LOADL_quick   ; inline operand = 7
  $80E9  8C C0 00                   LOADR_imm2             $00C0
  $80EC  B5                         MULT
  $80ED  8C 84 AD                   LOADR_imm2             $AD84 (unpack_base5_digits_uplo_data_ad84)
  $80F0  BB                         ADD
  $80F1  B3                         PUSHL
  $80F2  68                         PUSH_qimm   ; inline operand = 8
  $80F3  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $80F7  6C                         PUSH_qimm   ; inline operand = 12
  $80F8  3C                         PUSH_quick   ; inline operand = 12
  $80F9  0A                         LOADL_quick   ; inline operand = 10
  $80FA  5C                         LOADR_qimm   ; inline operand = 12
  $80FB  B5                         MULT
  $80FC  8C 34 AE                   LOADR_imm2             $AE34
  $80FF  BB                         ADD
  $8100  B3                         PUSHL
  $8101  69                         PUSH_qimm   ; inline operand = 9
  $8102  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $8106  66                         PUSH_qimm   ; inline operand = 6
  $8107  0C                         LOADL_quick   ; inline operand = 12
  $8108  7C                         ADD_qimm   ; inline operand = 12
  $8109  B3                         PUSHL
  $810A  09                         LOADL_quick   ; inline operand = 9
  $810B  56                         LOADR_qimm   ; inline operand = 6
  $810C  B5                         MULT
  $810D  8C 70 AE                   LOADR_imm2             $AE70
  $8110  BB                         ADD
  $8111  B3                         PUSHL
  $8112  69                         PUSH_qimm   ; inline operand = 9
  $8113  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $8117  66                         PUSH_qimm   ; inline operand = 6
  $8118  0C                         LOADL_quick   ; inline operand = 12
  $8119  8F 12                      BYTE_ADD_imm1          +18
  $811B  B3                         PUSHL
  $811C  08                         LOADL_quick   ; inline operand = 8
  $811D  56                         LOADR_qimm   ; inline operand = 6
  $811E  B5                         MULT
  $811F  8C 8E AE                   LOADR_imm2             $AE8E
  $8122  BB                         ADD
  $8123  B3                         PUSHL
  $8124  69                         PUSH_qimm   ; inline operand = 9
  $8125  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $8129  6C                         PUSH_qimm   ; inline operand = 12
  $812A  0C                         LOADL_quick   ; inline operand = 12
  $812B  8F 18                      BYTE_ADD_imm1          +24
  $812D  B3                         PUSHL
  $812E  07                         LOADL_quick   ; inline operand = 7
  $812F  5C                         LOADR_qimm   ; inline operand = 12
  $8130  B5                         MULT
  $8131  8C AC AE                   LOADR_imm2             $AEAC (unpack_base5_digits_uplo_data_aeac)
  $8134  BB                         ADD
  $8135  B3                         PUSHL
  $8136  69                         PUSH_qimm   ; inline operand = 9
  $8137  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $813B  CF                         RETURN

; ============================================================
; sub $813C   (frame_off=-47, body @ $8141)
; ============================================================
  $8141  40                         LOADL_qimm   ; inline operand = 0
  $8142  85 D7                      STORE_near             $D7
 >$8144  81 D7                      LOADL_near             $D7
  $8146  D2                         LSHIFT1
  $8147  8C 1E B5                   LOADR_imm2             $B51E (build_blit_fief_tile_blo_data_b51e)
  $814A  BB                         ADD
  $814B  B0                         DEREF
  $814C  B3                         PUSHL
  $814D  87 D7                      PUSH_near              $D7
  $814F  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8153  81 D7                      LOADL_near             $D7
  $8155  D0                         INC
  $8156  85 D7                      STORE_near             $D7
  $8158  81 D7                      LOADL_near             $D7
  $815A  54                         LOADR_qimm   ; inline operand = 4
  $815B  C6                         UCMPLT
  $815C  D7 44 81                   JUMPT_abs              $8144
  $815F  AA 5B 6F                   PUSH_abs               $6F5B (active_province_idx_copy)
  $8162  E9 CD D7 02                CALL_abs_imm1          $D7CD (daimyo_record_addr) {bytecode}, $02
  $8166  76                         ADD_qimm   ; inline operand = 6
  $8167  D3                         BYTE_DEREF
  $8168  D7 E8 81                   JUMPT_abs              $81E8
  $816B  AA 5B 6F                   PUSH_abs               $6F5B (active_province_idx_copy)
  $816E  E9 66 DC 02                CALL_abs_imm1          $DC66 (fief_to_mapid) {bytecode}, $02
  $8172  D2                         LSHIFT1
  $8173  D2                         LSHIFT1
  $8174  8C D0 BB                   LOADR_imm2             $BBD0 (build_blit_fief_tile_blo_data_bbd0)
  $8177  BB                         ADD
  $8178  85 D5                      STORE_near             $D5
  $817A  64                         PUSH_qimm   ; inline operand = 4
  $817B  DE D1 FF                   LEAL_far               $FFD1
  $817E  B3                         PUSHL
  $817F  87 D5                      PUSH_near              $D5
  $8181  68                         PUSH_qimm   ; inline operand = 8
  $8182  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $8186  DE D1 FF                   LEAL_far               $FFD1
  $8189  85 D5                      STORE_near             $D5
  $818B  81 D5                      LOADL_near             $D5
  $818D  D0                         INC
  $818E  D3                         BYTE_DEREF
  $818F  B3                         PUSHL
  $8190  8E F0 17                   PUSH_imm2              $17F0
  $8193  81 D5                      LOADL_near             $D5
  $8195  72                         ADD_qimm   ; inline operand = 2
  $8196  B0                         DEREF
  $8197  B3                         PUSHL
  $8198  81 D5                      LOADL_near             $D5
  $819A  D3                         BYTE_DEREF
  $819B  B3                         PUSHL
  $819C  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $81A0  40                         LOADL_qimm   ; inline operand = 0
  $81A1  85 D7                      STORE_near             $D7
  $81A3  AA 5B 6F                   PUSH_abs               $6F5B (active_province_idx_copy)
  $81A6  E9 66 DC 02                CALL_abs_imm1          $DC66 (fief_to_mapid) {bytecode}, $02
  $81AA  8B 24                      BYTE_LOADR_imm1        +36
  $81AC  B5                         MULT
  $81AD  8C 44 B1                   LOADR_imm2             $B144 (build_blit_fief_tile_blo_data_b144)
  $81B0  BB                         ADD
  $81B1  85 DA                      STORE_near             $DA
  $81B3  D6 DD 81                   JUMP_abs               $81DD
 >$81B6  61                         PUSH_qimm   ; inline operand = 1
  $81B7  DE D9 FF                   LEAL_far               $FFD9
  $81BA  B3                         PUSHL
  $81BB  87 DA                      PUSH_near              $DA
  $81BD  68                         PUSH_qimm   ; inline operand = 8
  $81BE  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $81C2  DE DC FF                   LEAL_far               $FFDC
  $81C5  B3                         PUSHL
  $81C6  81 D7                      LOADL_near             $D7
  $81C8  B4                         POPR
  $81C9  BB                         ADD
  $81CA  B3                         PUSHL
  $81CB  A0 D9 FF                   BYTE_LOADL_far         $FFD9
  $81CE  8F 24                      BYTE_ADD_imm1          +36
  $81D0  D4                         BYTE_POPSTORE
  $81D1  81 D7                      LOADL_near             $D7
  $81D3  D0                         INC
  $81D4  85 D7                      STORE_near             $D7
  $81D6  D1                         DEC
  $81D7  81 DA                      LOADL_near             $DA
  $81D9  D0                         INC
  $81DA  85 DA                      STORE_near             $DA
  $81DC  D1                         DEC
 >$81DD  81 D7                      LOADL_near             $D7
  $81DF  8B 24                      BYTE_LOADR_imm1        +36
  $81E1  C6                         UCMPLT
  $81E2  D7 B6 81                   JUMPT_abs              $81B6
  $81E5  D6 18 82                   JUMP_abs               $8218
 >$81E8  DE DC FF                   LEAL_far               $FFDC
  $81EB  B3                         PUSHL
  $81EC  E9 86 80 02                CALL_abs_imm1          $8086 (compose_upload_daimyo_portrait) {bytecode}, $02
  $81F0  40                         LOADL_qimm   ; inline operand = 0
  $81F1  85 D7                      STORE_near             $D7
  $81F3  DE DC FF                   LEAL_far               $FFDC
  $81F6  85 DA                      STORE_near             $DA
  $81F8  D6 10 82                   JUMP_abs               $8210
 >$81FB  8D 24                      BYTE_PUSH_imm1         +36
  $81FD  81 DA                      LOADL_near             $DA
  $81FF  B4                         POPR
  $8200  B3                         PUSHL
  $8201  D3                         BYTE_DEREF
  $8202  BB                         ADD
  $8203  D4                         BYTE_POPSTORE
  $8204  81 D7                      LOADL_near             $D7
  $8206  D0                         INC
  $8207  85 D7                      STORE_near             $D7
  $8209  D1                         DEC
  $820A  81 DA                      LOADL_near             $DA
  $820C  D0                         INC
  $820D  85 DA                      STORE_near             $DA
  $820F  D1                         DEC
 >$8210  81 D7                      LOADL_near             $D7
  $8212  8B 24                      BYTE_LOADR_imm1        +36
  $8214  C6                         UCMPLT
  $8215  D7 FB 81                   JUMPT_abs              $81FB
 >$8218  68                         PUSH_qimm   ; inline operand = 8
  $8219  DE DC FF                   LEAL_far               $FFDC
  $821C  B3                         PUSHL
  $821D  0D                         LOADL_quick   ; inline operand = 13
  $821E  75                         ADD_qimm   ; inline operand = 5
  $821F  B3                         PUSHL
  $8220  0C                         LOADL_quick   ; inline operand = 12
  $8221  75                         ADD_qimm   ; inline operand = 5
  $8222  B3                         PUSHL
  $8223  3D                         PUSH_quick   ; inline operand = 13
  $8224  3C                         PUSH_quick   ; inline operand = 12
  $8225  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_copy_rect_wrap) {bytecode}, $0C
  $8229  CF                         RETURN

; ============================================================
; sub $822A   (frame_off=-2, body @ $822F)
; ============================================================
  $822F  8E 26 B5                   PUSH_imm2              $B526 (msg_y_n_b526)
  $8232  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8236  61                         PUSH_qimm   ; inline operand = 1
  $8237  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
 >$823B  AC 87 D2                   CALL_abs               $D287 (wait_button_edge) {bytecode}
  $823E  2B                         STORE_quick   ; inline operand = 11
  $823F  8B 40                      BYTE_LOADR_imm1        +64
  $8241  C1                         CMPNE
  $8242  D8 4D 82                   JUMPF_abs              $824D
  $8245  0B                         LOADL_quick   ; inline operand = 11
  $8246  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $8249  C1                         CMPNE
  $824A  D7 3B 82                   JUMPT_abs              $823B
 >$824D  60                         PUSH_qimm   ; inline operand = 0
  $824E  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $8252  0B                         LOADL_quick   ; inline operand = 11
  $8253  8B 40                      BYTE_LOADR_imm1        +64
  $8255  C0                         CMPEQ
  $8256  D8 63 82                   JUMPF_abs              $8263
  $8259  8D 59                      BYTE_PUSH_imm1         +89
  $825B  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $825F  41                         LOADL_qimm   ; inline operand = 1
  $8260  D6 6A 82                   JUMP_abs               $826A
 >$8263  8D 4E                      BYTE_PUSH_imm1         +78
  $8265  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $8269  40                         LOADL_qimm   ; inline operand = 0
 >$826A  2B                         STORE_quick   ; inline operand = 11
  $826B  AC 09 D3                   CALL_abs               $D309 (clear_rect_left_lower) {bytecode}
  $826E  0B                         LOADL_quick   ; inline operand = 11
  $826F  CF                         RETURN

; ============================================================
; sub $8270   (frame_off=+0, body @ $8275)
; ============================================================
  $8275  0C                         LOADL_quick   ; inline operand = 12
  $8276  A8 F5 7B                   STORE_abs              $7BF5 (tactical_cursor_cell_7bf5)
  $8279  0D                         LOADL_quick   ; inline operand = 13
  $827A  A8 F7 7B                   STORE_abs              $7BF7 (tactical_cursor_row_7bf7)
  $827D  CF                         RETURN

; ============================================================
; sub $827E   (frame_off=+0, body @ $8283)
; ============================================================
  $8283  0C                         LOADL_quick   ; inline operand = 12
  $8284  56                         LOADR_qimm   ; inline operand = 6
  $8285  B5                         MULT
  $8286  8C 7D 6F                   LOADR_imm2             $6F7D (war_attacker_gold)
  $8289  BB                         ADD
  $828A  CF                         RETURN

; ============================================================
; sub $828B   (frame_off=+0, body @ $8290)
; ============================================================
  $8290  0C                         LOADL_quick   ; inline operand = 12
  $8291  55                         LOADR_qimm   ; inline operand = 5
  $8292  B5                         MULT
  $8293  1D                         LOADR_quick   ; inline operand = 13
  $8294  BB                         ADD
  $8295  8C D0 6F                   LOADR_imm2             $6FD0
  $8298  BB                         ADD
  $8299  CF                         RETURN

; ============================================================
; sub $829A   (frame_off=+0, body @ $829F)
; ============================================================
  $829F  0C                         LOADL_quick   ; inline operand = 12
  $82A0  55                         LOADR_qimm   ; inline operand = 5
  $82A1  B5                         MULT
  $82A2  1D                         LOADR_quick   ; inline operand = 13
  $82A3  BB                         ADD
  $82A4  8C DA 6F                   LOADR_imm2             $6FDA
  $82A7  BB                         ADD
  $82A8  CF                         RETURN

; ============================================================
; sub $82A9   (frame_off=+0, body @ $82AE)
; ============================================================
  $82AE  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $82B1  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $82B4  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $82B8  CF                         RETURN

; ============================================================
; sub $82B9   (frame_off=+0, body @ $82BE)
; ============================================================
  $82BE  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $82C1  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $82C4  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $82C8  CF                         RETURN

; ============================================================
; sub $82C9   (frame_off=+0, body @ $82CE)
; ============================================================
  $82CE  0D                         LOADL_quick   ; inline operand = 13
  $82CF  D2                         LSHIFT1
  $82D0  B3                         PUSHL
  $82D1  0C                         LOADL_quick   ; inline operand = 12
  $82D2  5A                         LOADR_qimm   ; inline operand = 10
  $82D3  B5                         MULT
  $82D4  B4                         POPR
  $82D5  BB                         ADD
  $82D6  8C BC 6F                   LOADR_imm2             $6FBC
  $82D9  BB                         ADD
  $82DA  CF                         RETURN

; ============================================================
; sub $82DB   (frame_off=+0, body @ $82E0)
; ============================================================
  $82E0  0C                         LOADL_quick   ; inline operand = 12
  $82E1  5A                         LOADR_qimm   ; inline operand = 10
  $82E2  C8                         UCMPGT
  $82E3  D7 EC 82                   JUMPT_abs              $82EC
  $82E6  0D                         LOADL_quick   ; inline operand = 13
  $82E7  54                         LOADR_qimm   ; inline operand = 4
  $82E8  C8                         UCMPGT
  $82E9  D8 EE 82                   JUMPF_abs              $82EE
 >$82EC  41                         LOADL_qimm   ; inline operand = 1
  $82ED  CF                         RETURN
 >$82EE  3D                         PUSH_quick   ; inline operand = 13
  $82EF  3C                         PUSH_quick   ; inline operand = 12
  $82F0  E9 88 DC 04                CALL_abs_imm1          $DC88 (read_map_cell) {bytecode}, $04
  $82F4  1E                         LOADR_quick   ; inline operand = 14
  $82F5  DA                         AND
  $82F6  D7 FD 82                   JUMPT_abs              $82FD
  $82F9  41                         LOADL_qimm   ; inline operand = 1
  $82FA  D6 FE 82                   JUMP_abs               $82FE
 >$82FD  40                         LOADL_qimm   ; inline operand = 0
 >$82FE  CF                         RETURN

; ============================================================
; sub $82FF   (frame_off=+0, body @ $8304)
; ============================================================
  $8304  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8307  8B 32                      BYTE_LOADR_imm1        +50
  $8309  C0                         CMPEQ
  $830A  CF                         RETURN

; ============================================================
; sub $830B   (frame_off=-8, body @ $8310)
; ============================================================
  $8310  40                         LOADL_qimm   ; inline operand = 0
  $8311  28                         STORE_quick   ; inline operand = 8
 >$8312  38                         PUSH_quick   ; inline operand = 8
  $8313  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $8317  74                         ADD_qimm   ; inline operand = 4
  $8318  B0                         DEREF
  $8319  2B                         STORE_quick   ; inline operand = 11
  $831A  0B                         LOADL_quick   ; inline operand = 11
  $831B  8B 1E                      BYTE_LOADR_imm1        +30
  $831D  B6                         SDIV
  $831E  2A                         STORE_quick   ; inline operand = 10
  $831F  0B                         LOADL_quick   ; inline operand = 11
  $8320  8B 1E                      BYTE_LOADR_imm1        +30
  $8322  B9                         SMOD
  $8323  29                         STORE_quick   ; inline operand = 9
  $8324  39                         PUSH_quick   ; inline operand = 9
  $8325  08                         LOADL_quick   ; inline operand = 8
  $8326  D2                         LSHIFT1
  $8327  1D                         LOADR_quick   ; inline operand = 13
  $8328  BB                         ADD
  $8329  B4                         POPR
  $832A  B3                         PUSHL
  $832B  B0                         DEREF
  $832C  BB                         ADD
  $832D  B1                         POPSTORE
  $832E  8B 1E                      BYTE_LOADR_imm1        +30
  $8330  C9                         UCMPGE
  $8331  D8 42 83                   JUMPF_abs              $8342
  $8334  8D 1E                      BYTE_PUSH_imm1         +30
  $8336  08                         LOADL_quick   ; inline operand = 8
  $8337  D2                         LSHIFT1
  $8338  1D                         LOADR_quick   ; inline operand = 13
  $8339  BB                         ADD
  $833A  B4                         POPR
  $833B  B3                         PUSHL
  $833C  B0                         DEREF
  $833D  BC                         SUB
  $833E  B1                         POPSTORE
  $833F  0A                         LOADL_quick   ; inline operand = 10
  $8340  D0                         INC
  $8341  2A                         STORE_quick   ; inline operand = 10
 >$8342  3A                         PUSH_quick   ; inline operand = 10
  $8343  08                         LOADL_quick   ; inline operand = 8
  $8344  D2                         LSHIFT1
  $8345  1C                         LOADR_quick   ; inline operand = 12
  $8346  BB                         ADD
  $8347  B0                         DEREF
  $8348  B4                         POPR
  $8349  B3                         PUSHL
  $834A  B0                         DEREF
  $834B  BC                         SUB
  $834C  B1                         POPSTORE
  $834D  50                         LOADR_qimm   ; inline operand = 0
  $834E  C3                         SCMPLE
  $834F  D8 5A 83                   JUMPF_abs              $835A
  $8352  08                         LOADL_quick   ; inline operand = 8
  $8353  D2                         LSHIFT1
  $8354  1C                         LOADR_quick   ; inline operand = 12
  $8355  BB                         ADD
  $8356  B0                         DEREF
  $8357  B3                         PUSHL
  $8358  40                         LOADL_qimm   ; inline operand = 0
  $8359  B1                         POPSTORE
 >$835A  61                         PUSH_qimm   ; inline operand = 1
  $835B  38                         PUSH_quick   ; inline operand = 8
  $835C  E9 8A 8B 04                CALL_abs_imm1          $8B8A (draw_unit_stat_field) {bytecode}, $04
  $8360  08                         LOADL_quick   ; inline operand = 8
  $8361  D0                         INC
  $8362  28                         STORE_quick   ; inline operand = 8
  $8363  08                         LOADL_quick   ; inline operand = 8
  $8364  52                         LOADR_qimm   ; inline operand = 2
  $8365  C6                         UCMPLT
  $8366  D7 12 83                   JUMPT_abs              $8312
  $8369  CF                         RETURN

; ============================================================
; sub $836A   (frame_off=-4, body @ $836F)
; ============================================================
  $836F  3C                         PUSH_quick   ; inline operand = 12
  $8370  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $8374  74                         ADD_qimm   ; inline operand = 4
  $8375  B0                         DEREF
  $8376  2B                         STORE_quick   ; inline operand = 11
  $8377  5F                         LOADR_qimm   ; inline operand = 15
  $8378  B8                         UDIV
  $8379  2A                         STORE_quick   ; inline operand = 10
  $837A  0B                         LOADL_quick   ; inline operand = 11
  $837B  5F                         LOADR_qimm   ; inline operand = 15
  $837C  BA                         UMOD
  $837D  D8 83 83                   JUMPF_abs              $8383
  $8380  0A                         LOADL_quick   ; inline operand = 10
  $8381  D0                         INC
  $8382  2A                         STORE_quick   ; inline operand = 10
 >$8383  3C                         PUSH_quick   ; inline operand = 12
  $8384  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $8388  72                         ADD_qimm   ; inline operand = 2
  $8389  B0                         DEREF
  $838A  B3                         PUSHL
  $838B  0A                         LOADL_quick   ; inline operand = 10
  $838C  B4                         POPR
  $838D  C7                         UCMPLE
  $838E  CF                         RETURN

; ============================================================
; sub $838F   (frame_off=+0, body @ $8394)
; ============================================================
  $8394  0C                         LOADL_quick   ; inline operand = 12
  $8395  D7 9E 83                   JUMPT_abs              $839E
  $8398  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $839B  D6 A1 83                   JUMP_abs               $83A1
 >$839E  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
 >$83A1  CF                         RETURN

; ============================================================
; sub $83A2   (frame_off=+0, body @ $83A7)
; ============================================================
  $83A7  3D                         PUSH_quick   ; inline operand = 13
  $83A8  0C                         LOADL_quick   ; inline operand = 12
  $83A9  B0                         DEREF
  $83AA  51                         LOADR_qimm   ; inline operand = 1
  $83AB  DA                         AND
  $83AC  D2                         LSHIFT1
  $83AD  B3                         PUSHL
  $83AE  0D                         LOADL_quick   ; inline operand = 13
  $83AF  B0                         DEREF
  $83B0  D0                         INC
  $83B1  D2                         LSHIFT1
  $83B2  D2                         LSHIFT1
  $83B3  B4                         POPR
  $83B4  BB                         ADD
  $83B5  B1                         POPSTORE
  $83B6  3C                         PUSH_quick   ; inline operand = 12
  $83B7  A4 FE 6F                   LOADL_abs              $6FFE (tactical_battle_phase)
  $83BA  53                         LOADR_qimm   ; inline operand = 3
  $83BB  B5                         MULT
  $83BC  B3                         PUSHL
  $83BD  0C                         LOADL_quick   ; inline operand = 12
  $83BE  B0                         DEREF
  $83BF  B4                         POPR
  $83C0  BC                         SUB
  $83C1  D2                         LSHIFT1
  $83C2  D2                         LSHIFT1
  $83C3  7A                         ADD_qimm   ; inline operand = 10
  $83C4  B1                         POPSTORE
  $83C5  CF                         RETURN

; ============================================================
; sub $83C6   (frame_off=-2, body @ $83CB)
; ============================================================
  $83CB  45                         LOADL_qimm   ; inline operand = 5
  $83CC  2B                         STORE_quick   ; inline operand = 11
  $83CD  3D                         PUSH_quick   ; inline operand = 13
  $83CE  3C                         PUSH_quick   ; inline operand = 12
  $83CF  E9 88 DC 04                CALL_abs_imm1          $DC88 (read_map_cell) {bytecode}, $04
  $83D3  8C FE 00                   LOADR_imm2             $00FE
  $83D6  DA                         AND
  $83D7  D9 06 00 04 00 00 84 08 00 FA 83 10 ... SWITCH_noncontig       count=6   ; .table 6 (key,target) + default (noncontiguous); SWITCH 4=>$8400 8=>$83FA 16=>$83F7 32=>$83F4 64=>$8403 128=>$83FD default=>$8403
 >$83F4  0B                         LOADL_quick   ; inline operand = 11
  $83F5  D1                         DEC
  $83F6  2B                         STORE_quick   ; inline operand = 11
 >$83F7  0B                         LOADL_quick   ; inline operand = 11
  $83F8  D1                         DEC
  $83F9  2B                         STORE_quick   ; inline operand = 11
 >$83FA  0B                         LOADL_quick   ; inline operand = 11
  $83FB  D1                         DEC
  $83FC  2B                         STORE_quick   ; inline operand = 11
 >$83FD  0B                         LOADL_quick   ; inline operand = 11
  $83FE  D1                         DEC
  $83FF  2B                         STORE_quick   ; inline operand = 11
 >$8400  0B                         LOADL_quick   ; inline operand = 11
  $8401  D1                         DEC
  $8402  2B                         STORE_quick   ; inline operand = 11
 >$8403  0B                         LOADL_quick   ; inline operand = 11
  $8404  54                         LOADR_qimm   ; inline operand = 4
  $8405  BD                         LSHIFT
  $8406  8C 1E B1                   LOADR_imm2             $B11E (lookup_terrain_attr_reco_data_b11e)
  $8409  BB                         ADD
  $840A  CF                         RETURN

; ============================================================
; sub $840B   (frame_off=-6, body @ $8410)
; ============================================================
  $8410  AA F5 7B                   PUSH_abs               $7BF5 (tactical_cursor_cell_7bf5)
  $8413  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $8417  D7 1B 84                   JUMPT_abs              $841B
  $841A  CF                         RETURN
 >$841B  0C                         LOADL_quick   ; inline operand = 12
  $841C  51                         LOADR_qimm   ; inline operand = 1
  $841D  C0                         CMPEQ
  $841E  D8 67 84                   JUMPF_abs              $8467
  $8421  A4 F5 7B                   LOADL_abs              $7BF5 (tactical_cursor_cell_7bf5)
  $8424  2A                         STORE_quick   ; inline operand = 10
  $8425  A4 F7 7B                   LOADL_abs              $7BF7 (tactical_cursor_row_7bf7)
  $8428  29                         STORE_quick   ; inline operand = 9
  $8429  DE FA FF                   LEAL_far               $FFFA
  $842C  B3                         PUSHL
  $842D  DE FC FF                   LEAL_far               $FFFC
  $8430  B3                         PUSHL
  $8431  E9 A2 83 04                CALL_abs_imm1          $83A2 (calc_tactical_cell_coords) {bytecode}, $04
  $8435  41                         LOADL_qimm   ; inline operand = 1
  $8436  2B                         STORE_quick   ; inline operand = 11
 >$8437  60                         PUSH_qimm   ; inline operand = 0
  $8438  60                         PUSH_qimm   ; inline operand = 0
  $8439  09                         LOADL_quick   ; inline operand = 9
  $843A  53                         LOADR_qimm   ; inline operand = 3
  $843B  BD                         LSHIFT
  $843C  D1                         DEC
  $843D  B3                         PUSHL
  $843E  0A                         LOADL_quick   ; inline operand = 10
  $843F  53                         LOADR_qimm   ; inline operand = 3
  $8440  BD                         LSHIFT
  $8441  B3                         PUSHL
  $8442  3B                         PUSH_quick   ; inline operand = 11
  $8443  63                         PUSH_qimm   ; inline operand = 3
  $8444  E9 26 F2 0C                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0C
  $8448  0A                         LOADL_quick   ; inline operand = 10
  $8449  D0                         INC
  $844A  2A                         STORE_quick   ; inline operand = 10
  $844B  53                         LOADR_qimm   ; inline operand = 3
  $844C  DA                         AND
  $844D  52                         LOADR_qimm   ; inline operand = 2
  $844E  C0                         CMPEQ
  $844F  D8 5A 84                   JUMPF_abs              $845A
  $8452  44                         LOADL_qimm   ; inline operand = 4
  $8453  CD                         SWAP
  $8454  0A                         LOADL_quick   ; inline operand = 10
  $8455  BC                         SUB
  $8456  2A                         STORE_quick   ; inline operand = 10
  $8457  09                         LOADL_quick   ; inline operand = 9
  $8458  D0                         INC
  $8459  29                         STORE_quick   ; inline operand = 9
 >$845A  0B                         LOADL_quick   ; inline operand = 11
  $845B  D0                         INC
  $845C  2B                         STORE_quick   ; inline operand = 11
  $845D  0B                         LOADL_quick   ; inline operand = 11
  $845E  8B 10                      BYTE_LOADR_imm1        +16
  $8460  C3                         SCMPLE
  $8461  D7 37 84                   JUMPT_abs              $8437
  $8464  D6 81 84                   JUMP_abs               $8481
 >$8467  41                         LOADL_qimm   ; inline operand = 1
  $8468  2B                         STORE_quick   ; inline operand = 11
 >$8469  62                         PUSH_qimm   ; inline operand = 2
  $846A  60                         PUSH_qimm   ; inline operand = 0
  $846B  8E F8 00                   PUSH_imm2              $00F8
  $846E  8E F8 00                   PUSH_imm2              $00F8
  $8471  3B                         PUSH_quick   ; inline operand = 11
  $8472  63                         PUSH_qimm   ; inline operand = 3
  $8473  E9 26 F2 0C                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0C
  $8477  0B                         LOADL_quick   ; inline operand = 11
  $8478  D0                         INC
  $8479  2B                         STORE_quick   ; inline operand = 11
  $847A  0B                         LOADL_quick   ; inline operand = 11
  $847B  8B 10                      BYTE_LOADR_imm1        +16
  $847D  C3                         SCMPLE
  $847E  D7 69 84                   JUMPT_abs              $8469
 >$8481  8D 13                      BYTE_PUSH_imm1         +19
  $8483  E9 26 F2 02                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $02
  $8487  CF                         RETURN

; ============================================================
; sub $8488   (frame_off=-2, body @ $848D)
; ============================================================
  $848D  AC 4E D1                   CALL_abs               $D14E (poll_input) {bytecode}
  $8490  D9 0A 00 01 00 D1 84 02 00 D6 84 10 ... SWITCH_noncontig       count=10   ; .table 10 (key,target) + default (noncontiguous); SWITCH 1=>$84D1 2=>$84D6 16=>$84C7 32=>$84CC 64=>$84BD 80=>$84BD 96=>$84BD 128=>$84C2 144=>$84C2 160=>$84C2 default=>$84F3
 >$84BD  89 34                      BYTE_LOADL_imm1        +52
 >$84BF  2B                         STORE_quick   ; inline operand = 11
  $84C0  0B                         LOADL_quick   ; inline operand = 11
  $84C1  CF                         RETURN
 >$84C2  89 36                      BYTE_LOADL_imm1        +54
  $84C4  D6 BF 84                   JUMP_abs               $84BF
 >$84C7  89 38                      BYTE_LOADL_imm1        +56
  $84C9  D6 BF 84                   JUMP_abs               $84BF
 >$84CC  89 32                      BYTE_LOADL_imm1        +50
  $84CE  D6 BF 84                   JUMP_abs               $84BF
 >$84D1  89 30                      BYTE_LOADL_imm1        +48
  $84D3  D6 BF 84                   JUMP_abs               $84BF
 >$84D6  60                         PUSH_qimm   ; inline operand = 0
  $84D7  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $84DB  D8 E2 84                   JUMPF_abs              $84E2
  $84DE  65                         PUSH_qimm   ; inline operand = 5
  $84DF  D6 EF 84                   JUMP_abs               $84EF
 >$84E2  65                         PUSH_qimm   ; inline operand = 5
  $84E3  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $84E7  D8 EE 84                   JUMPF_abs              $84EE
  $84EA  6A                         PUSH_qimm   ; inline operand = 10
  $84EB  D6 EF 84                   JUMP_abs               $84EF
 >$84EE  60                         PUSH_qimm   ; inline operand = 0
 >$84EF  E9 BE 95 02                CALL_abs_imm1          $95BE (draw_tactical_cursor_region_arg0) {bytecode}, $02
 >$84F3  40                         LOADL_qimm   ; inline operand = 0
  $84F4  D6 BF 84                   JUMP_abs               $84BF

; ============================================================
; sub $84F7   (frame_off=-4, body @ $84FC)
; ============================================================
  $84FC  0E                         LOADL_quick   ; inline operand = 14
  $84FD  54                         LOADR_qimm   ; inline operand = 4
  $84FE  C6                         UCMPLT
  $84FF  D8 22 85                   JUMPF_abs              $8522
  $8502  0E                         LOADL_quick   ; inline operand = 14
  $8503  D5 00 00 04 00 19 85 12 85 2C 85 35 ... SWITCH_contig          limit=4   ; .table 4 word targets (contiguous); SWITCH 0=>$8512 1=>$852C 2=>$8535 3=>$853B default=>$8519
 >$8512  0C                         LOADL_quick   ; inline operand = 12
  $8513  B0                         DEREF
  $8514  2B                         STORE_quick   ; inline operand = 11
  $8515  0D                         LOADL_quick   ; inline operand = 13
  $8516  B0                         DEREF
  $8517  D0                         INC
 >$8518  2A                         STORE_quick   ; inline operand = 10
 >$8519  3A                         PUSH_quick   ; inline operand = 10
  $851A  3B                         PUSH_quick   ; inline operand = 11
  $851B  E9 11 8F 04                CALL_abs_imm1          $8F11 (is_tile_in_bounds) {bytecode}, $04
  $851F  D7 24 85                   JUMPT_abs              $8524
 >$8522  40                         LOADL_qimm   ; inline operand = 0
  $8523  CF                         RETURN
 >$8524  3C                         PUSH_quick   ; inline operand = 12
  $8525  0B                         LOADL_quick   ; inline operand = 11
  $8526  B1                         POPSTORE
  $8527  3D                         PUSH_quick   ; inline operand = 13
  $8528  0A                         LOADL_quick   ; inline operand = 10
  $8529  B1                         POPSTORE
  $852A  41                         LOADL_qimm   ; inline operand = 1
  $852B  CF                         RETURN
 >$852C  0C                         LOADL_quick   ; inline operand = 12
  $852D  B0                         DEREF
  $852E  D1                         DEC
 >$852F  2B                         STORE_quick   ; inline operand = 11
  $8530  0D                         LOADL_quick   ; inline operand = 13
  $8531  B0                         DEREF
  $8532  D6 18 85                   JUMP_abs               $8518
 >$8535  0C                         LOADL_quick   ; inline operand = 12
  $8536  B0                         DEREF
  $8537  D0                         INC
  $8538  D6 2F 85                   JUMP_abs               $852F
 >$853B  0C                         LOADL_quick   ; inline operand = 12
  $853C  B0                         DEREF
  $853D  2B                         STORE_quick   ; inline operand = 11
  $853E  0D                         LOADL_quick   ; inline operand = 13
  $853F  B0                         DEREF
  $8540  D1                         DEC
  $8541  D6 18 85                   JUMP_abs               $8518

; ============================================================
; sub $8544   (frame_off=+0, body @ $8549)
; ============================================================
  $8549  0E                         LOADL_quick   ; inline operand = 14
  $854A  8B 30                      BYTE_LOADR_imm1        +48
  $854C  C1                         CMPNE
  $854D  D8 5F 85                   JUMPF_abs              $855F
  $8550  0E                         LOADL_quick   ; inline operand = 14
  $8551  8F D0                      BYTE_ADD_imm1          -48
  $8553  51                         LOADR_qimm   ; inline operand = 1
  $8554  BE                         URSHIFT
  $8555  D1                         DEC
  $8556  2E                         STORE_quick   ; inline operand = 14
  $8557  3E                         PUSH_quick   ; inline operand = 14
  $8558  3D                         PUSH_quick   ; inline operand = 13
  $8559  3C                         PUSH_quick   ; inline operand = 12
  $855A  E9 F7 84 06                CALL_abs_imm1          $84F7 (step_coord_by_direction) {bytecode}, $06
  $855E  CF                         RETURN
 >$855F  40                         LOADL_qimm   ; inline operand = 0
  $8560  CF                         RETURN

; ============================================================
; sub $8561   (frame_off=-4, body @ $8566)
; ============================================================
  $8566  3D                         PUSH_quick   ; inline operand = 13
  $8567  3C                         PUSH_quick   ; inline operand = 12
  $8568  E9 70 82 04                CALL_abs_imm1          $8270 (set_combat_state_pair_7bf5_7bf7) {bytecode}, $04
 >$856C  61                         PUSH_qimm   ; inline operand = 1
  $856D  E9 0B 84 02                CALL_abs_imm1          $840B (draw_tactical_cursor_region) {bytecode}, $02
  $8571  40                         LOADL_qimm   ; inline operand = 0
  $8572  2A                         STORE_quick   ; inline operand = 10
 >$8573  AC 88 84                   CALL_abs               $8488 (read_button_press) {bytecode}
  $8576  2B                         STORE_quick   ; inline operand = 11
  $8577  D7 84 85                   JUMPT_abs              $8584
  $857A  0A                         LOADL_quick   ; inline operand = 10
  $857B  D0                         INC
  $857C  2A                         STORE_quick   ; inline operand = 10
  $857D  0A                         LOADL_quick   ; inline operand = 10
  $857E  8B 64                      BYTE_LOADR_imm1        +100
  $8580  C6                         UCMPLT
  $8581  D7 73 85                   JUMPT_abs              $8573
 >$8584  60                         PUSH_qimm   ; inline operand = 0
  $8585  E9 0B 84 02                CALL_abs_imm1          $840B (draw_tactical_cursor_region) {bytecode}, $02
  $8589  0B                         LOADL_quick   ; inline operand = 11
  $858A  D8 8F 85                   JUMPF_abs              $858F
  $858D  0B                         LOADL_quick   ; inline operand = 11
  $858E  CF                         RETURN
 >$858F  40                         LOADL_qimm   ; inline operand = 0
  $8590  2A                         STORE_quick   ; inline operand = 10
 >$8591  AC 88 84                   CALL_abs               $8488 (read_button_press) {bytecode}
  $8594  2B                         STORE_quick   ; inline operand = 11
  $8595  D8 9A 85                   JUMPF_abs              $859A
  $8598  0B                         LOADL_quick   ; inline operand = 11
  $8599  CF                         RETURN
 >$859A  0A                         LOADL_quick   ; inline operand = 10
  $859B  D0                         INC
  $859C  2A                         STORE_quick   ; inline operand = 10
  $859D  0A                         LOADL_quick   ; inline operand = 10
  $859E  8B 64                      BYTE_LOADR_imm1        +100
  $85A0  C6                         UCMPLT
  $85A1  D7 91 85                   JUMPT_abs              $8591
  $85A4  D6 6C 85                   JUMP_abs               $856C

; ============================================================
; sub $85A7   (frame_off=-6, body @ $85AC)
; ============================================================
  $85AC  AC 4E D1                   CALL_abs               $D14E (poll_input) {bytecode}
  $85AF  2B                         STORE_quick   ; inline operand = 11
  $85B0  D9 06 00 01 00 00 86 02 00 00 86 10 ... SWITCH_noncontig       count=6   ; .table 6 (key,target) + default (noncontiguous); SWITCH 1=>$8600 2=>$8600 16=>$8600 32=>$8600 64=>$85CD 128=>$8602 default=>$85FE
 >$85CD  60                         PUSH_qimm   ; inline operand = 0
  $85CE  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $85D2  D7 FE 85                   JUMPT_abs              $85FE
  $85D5  60                         PUSH_qimm   ; inline operand = 0
  $85D6  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $85DA  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $85DD  2A                         STORE_quick   ; inline operand = 10
  $85DE  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $85E1  29                         STORE_quick   ; inline operand = 9
  $85E2  65                         PUSH_qimm   ; inline operand = 5
  $85E3  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $85E7  D7 EE 85                   JUMPT_abs              $85EE
 >$85EA  65                         PUSH_qimm   ; inline operand = 5
  $85EB  D6 EF 85                   JUMP_abs               $85EF
 >$85EE  60                         PUSH_qimm   ; inline operand = 0
 >$85EF  E9 BE 95 02                CALL_abs_imm1          $95BE (draw_tactical_cursor_region_arg0) {bytecode}, $02
  $85F3  39                         PUSH_quick   ; inline operand = 9
  $85F4  3A                         PUSH_quick   ; inline operand = 10
  $85F5  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $85F9  62                         PUSH_qimm   ; inline operand = 2
  $85FA  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
 >$85FE  40                         LOADL_qimm   ; inline operand = 0
  $85FF  2B                         STORE_quick   ; inline operand = 11
 >$8600  0B                         LOADL_quick   ; inline operand = 11
  $8601  CF                         RETURN
 >$8602  6A                         PUSH_qimm   ; inline operand = 10
  $8603  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $8607  D7 FE 85                   JUMPT_abs              $85FE
  $860A  60                         PUSH_qimm   ; inline operand = 0
  $860B  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $860F  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $8612  2A                         STORE_quick   ; inline operand = 10
  $8613  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $8616  29                         STORE_quick   ; inline operand = 9
  $8617  65                         PUSH_qimm   ; inline operand = 5
  $8618  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $861C  D8 EA 85                   JUMPF_abs              $85EA
  $861F  6A                         PUSH_qimm   ; inline operand = 10
  $8620  D6 EF 85                   JUMP_abs               $85EF

; ============================================================
; sub $8623   (frame_off=-4, body @ $8628)
; ============================================================
  $8628  3D                         PUSH_quick   ; inline operand = 13
  $8629  3C                         PUSH_quick   ; inline operand = 12
  $862A  E9 70 82 04                CALL_abs_imm1          $8270 (set_combat_state_pair_7bf5_7bf7) {bytecode}, $04
 >$862E  61                         PUSH_qimm   ; inline operand = 1
  $862F  E9 0B 84 02                CALL_abs_imm1          $840B (draw_tactical_cursor_region) {bytecode}, $02
  $8633  40                         LOADL_qimm   ; inline operand = 0
  $8634  2A                         STORE_quick   ; inline operand = 10
 >$8635  AC A7 85                   CALL_abs               $85A7 (tactical_cursor_input_validate_redraw) {bytecode}
  $8638  2B                         STORE_quick   ; inline operand = 11
  $8639  D7 46 86                   JUMPT_abs              $8646
  $863C  0A                         LOADL_quick   ; inline operand = 10
  $863D  D0                         INC
  $863E  2A                         STORE_quick   ; inline operand = 10
  $863F  0A                         LOADL_quick   ; inline operand = 10
  $8640  8B 64                      BYTE_LOADR_imm1        +100
  $8642  C6                         UCMPLT
  $8643  D7 35 86                   JUMPT_abs              $8635
 >$8646  60                         PUSH_qimm   ; inline operand = 0
  $8647  E9 0B 84 02                CALL_abs_imm1          $840B (draw_tactical_cursor_region) {bytecode}, $02
  $864B  0B                         LOADL_quick   ; inline operand = 11
  $864C  D8 51 86                   JUMPF_abs              $8651
  $864F  0B                         LOADL_quick   ; inline operand = 11
  $8650  CF                         RETURN
 >$8651  40                         LOADL_qimm   ; inline operand = 0
  $8652  2A                         STORE_quick   ; inline operand = 10
 >$8653  AC A7 85                   CALL_abs               $85A7 (tactical_cursor_input_validate_redraw) {bytecode}
  $8656  2B                         STORE_quick   ; inline operand = 11
  $8657  D8 5C 86                   JUMPF_abs              $865C
  $865A  0B                         LOADL_quick   ; inline operand = 11
  $865B  CF                         RETURN
 >$865C  0A                         LOADL_quick   ; inline operand = 10
  $865D  D0                         INC
  $865E  2A                         STORE_quick   ; inline operand = 10
  $865F  0A                         LOADL_quick   ; inline operand = 10
  $8660  8B 64                      BYTE_LOADR_imm1        +100
  $8662  C6                         UCMPLT
  $8663  D7 53 86                   JUMPT_abs              $8653
  $8666  D6 2E 86                   JUMP_abs               $862E

; ============================================================
; sub $8669   (frame_off=-4, body @ $866E)
; ============================================================
  $866E  6A                         PUSH_qimm   ; inline operand = 10
  $866F  63                         PUSH_qimm   ; inline operand = 3
  $8670  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8674  62                         PUSH_qimm   ; inline operand = 2
  $8675  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $8679  40                         LOADL_qimm   ; inline operand = 0
  $867A  2A                         STORE_quick   ; inline operand = 10
  $867B  40                         LOADL_qimm   ; inline operand = 0
  $867C  2B                         STORE_quick   ; inline operand = 11
 >$867D  0B                         LOADL_quick   ; inline operand = 11
  $867E  D8 83 86                   JUMPF_abs              $8683
  $8681  0A                         LOADL_quick   ; inline operand = 10
  $8682  CF                         RETURN
 >$8683  3D                         PUSH_quick   ; inline operand = 13
  $8684  3C                         PUSH_quick   ; inline operand = 12
  $8685  E9 23 86 04                CALL_abs_imm1          $8623 (poll_cursor_input_until_button) {bytecode}, $04
  $8689  D9 04 00 01 00 A0 86 02 00 9E 86 10 ... SWITCH_noncontig       count=4   ; .table 4 (key,target) + default (noncontiguous); SWITCH 1=>$86A0 2=>$869E 16=>$86AD 32=>$86E2 default=>$867D
 >$869E  44                         LOADL_qimm   ; inline operand = 4
  $869F  2A                         STORE_quick   ; inline operand = 10
 >$86A0  60                         PUSH_qimm   ; inline operand = 0
  $86A1  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $86A5  41                         LOADL_qimm   ; inline operand = 1
  $86A6  2B                         STORE_quick   ; inline operand = 11
  $86A7  AC 09 D3                   CALL_abs               $D309 (clear_rect_left_lower) {bytecode}
  $86AA  D6 7D 86                   JUMP_abs               $867D
 >$86AD  60                         PUSH_qimm   ; inline operand = 0
  $86AE  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $86B2  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $86B5  D1                         DEC
  $86B6  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $86B9  59                         LOADR_qimm   ; inline operand = 9
  $86BA  C0                         CMPEQ
  $86BB  D8 C8 86                   JUMPF_abs              $86C8
  $86BE  6F                         PUSH_qimm   ; inline operand = 15
  $86BF  63                         PUSH_qimm   ; inline operand = 3
  $86C0  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $86C4  45                         LOADL_qimm   ; inline operand = 5
  $86C5  D6 D4 86                   JUMP_abs               $86D4
 >$86C8  0A                         LOADL_quick   ; inline operand = 10
  $86C9  D1                         DEC
  $86CA  D6 D4 86                   JUMP_abs               $86D4
 >$86CD  6A                         PUSH_qimm   ; inline operand = 10
  $86CE  63                         PUSH_qimm   ; inline operand = 3
  $86CF  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $86D3  40                         LOADL_qimm   ; inline operand = 0
 >$86D4  2A                         STORE_quick   ; inline operand = 10
  $86D5  62                         PUSH_qimm   ; inline operand = 2
  $86D6  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $86DA  62                         PUSH_qimm   ; inline operand = 2
  $86DB  E9 3E D7 02                CALL_abs_imm1          $D73E (delay_loop) {bytecode}, $02
  $86DF  D6 7D 86                   JUMP_abs               $867D
 >$86E2  60                         PUSH_qimm   ; inline operand = 0
  $86E3  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $86E7  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $86EA  D0                         INC
  $86EB  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $86EE  8B 10                      BYTE_LOADR_imm1        +16
  $86F0  C0                         CMPEQ
  $86F1  D7 CD 86                   JUMPT_abs              $86CD
  $86F4  0A                         LOADL_quick   ; inline operand = 10
  $86F5  D0                         INC
  $86F6  D6 D4 86                   JUMP_abs               $86D4

; ============================================================
; sub $86F9   (frame_off=-4, body @ $86FE)
; ============================================================
  $86FE  8D 15                      BYTE_PUSH_imm1         +21
  $8700  62                         PUSH_qimm   ; inline operand = 2
  $8701  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8705  62                         PUSH_qimm   ; inline operand = 2
  $8706  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $870A  40                         LOADL_qimm   ; inline operand = 0
  $870B  2A                         STORE_quick   ; inline operand = 10
  $870C  40                         LOADL_qimm   ; inline operand = 0
  $870D  2B                         STORE_quick   ; inline operand = 11
 >$870E  0B                         LOADL_quick   ; inline operand = 11
  $870F  D8 19 87                   JUMPF_abs              $8719
  $8712  0A                         LOADL_quick   ; inline operand = 10
  $8713  8C 2F B5                   LOADR_imm2             $B52F (msg_d_d)
  $8716  BB                         ADD
  $8717  D3                         BYTE_DEREF
  $8718  CF                         RETURN
 >$8719  3D                         PUSH_quick   ; inline operand = 13
  $871A  3C                         PUSH_quick   ; inline operand = 12
  $871B  E9 23 86 04                CALL_abs_imm1          $8623 (poll_cursor_input_until_button) {bytecode}, $04
  $871F  D9 04 00 01 00 36 87 02 00 34 87 10 ... SWITCH_noncontig       count=4   ; .table 4 (key,target) + default (noncontiguous); SWITCH 1=>$8736 2=>$8734 16=>$8743 32=>$877B default=>$870E
 >$8734  46                         LOADL_qimm   ; inline operand = 6
  $8735  2A                         STORE_quick   ; inline operand = 10
 >$8736  60                         PUSH_qimm   ; inline operand = 0
  $8737  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $873B  41                         LOADL_qimm   ; inline operand = 1
  $873C  2B                         STORE_quick   ; inline operand = 11
  $873D  AC 09 D3                   CALL_abs               $D309 (clear_rect_left_lower) {bytecode}
  $8740  D6 0E 87                   JUMP_abs               $870E
 >$8743  60                         PUSH_qimm   ; inline operand = 0
  $8744  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $8748  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $874B  D1                         DEC
  $874C  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $874F  8B 14                      BYTE_LOADR_imm1        +20
  $8751  C0                         CMPEQ
  $8752  D8 60 87                   JUMPF_abs              $8760
  $8755  8D 1A                      BYTE_PUSH_imm1         +26
  $8757  62                         PUSH_qimm   ; inline operand = 2
  $8758  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $875C  45                         LOADL_qimm   ; inline operand = 5
  $875D  D6 6D 87                   JUMP_abs               $876D
 >$8760  0A                         LOADL_quick   ; inline operand = 10
  $8761  D1                         DEC
  $8762  D6 6D 87                   JUMP_abs               $876D
 >$8765  8D 15                      BYTE_PUSH_imm1         +21
  $8767  62                         PUSH_qimm   ; inline operand = 2
  $8768  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $876C  40                         LOADL_qimm   ; inline operand = 0
 >$876D  2A                         STORE_quick   ; inline operand = 10
  $876E  62                         PUSH_qimm   ; inline operand = 2
  $876F  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $8773  62                         PUSH_qimm   ; inline operand = 2
  $8774  E9 3E D7 02                CALL_abs_imm1          $D73E (delay_loop) {bytecode}, $02
  $8778  D6 0E 87                   JUMP_abs               $870E
 >$877B  60                         PUSH_qimm   ; inline operand = 0
  $877C  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $8780  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $8783  D0                         INC
  $8784  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $8787  8B 1B                      BYTE_LOADR_imm1        +27
  $8789  C0                         CMPEQ
  $878A  D7 65 87                   JUMPT_abs              $8765
  $878D  0A                         LOADL_quick   ; inline operand = 10
  $878E  D0                         INC
  $878F  D6 6D 87                   JUMP_abs               $876D

; ============================================================
; sub $8792   (frame_off=-2, body @ $8797)
; ============================================================
  $8797  3D                         PUSH_quick   ; inline operand = 13
  $8798  3C                         PUSH_quick   ; inline operand = 12
  $8799  8E 36 B5                   PUSH_imm2              $B536 (msg_d_d_b536)
  $879C  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $87A0  3D                         PUSH_quick   ; inline operand = 13
  $87A1  3C                         PUSH_quick   ; inline operand = 12
  $87A2  E9 9D D5 04                CALL_abs_imm1          $D59D (select_province_by_cursor) {bytecode}, $04
  $87A6  2B                         STORE_quick   ; inline operand = 11
  $87A7  0B                         LOADL_quick   ; inline operand = 11
  $87A8  D8 B5 87                   JUMPF_abs              $87B5
  $87AB  0B                         LOADL_quick   ; inline operand = 11
  $87AC  8B FF                      BYTE_LOADR_imm1        -1
  $87AE  C1                         CMPNE
  $87AF  D8 B5 87                   JUMPF_abs              $87B5
  $87B2  AC 09 D3                   CALL_abs               $D309 (clear_rect_left_lower) {bytecode}
 >$87B5  0B                         LOADL_quick   ; inline operand = 11
  $87B6  CF                         RETURN

; ============================================================
; sub $87B7   (frame_off=-10, body @ $87BC)
; ============================================================
  $87BC  62                         PUSH_qimm   ; inline operand = 2
  $87BD  3D                         PUSH_quick   ; inline operand = 13
  $87BE  3C                         PUSH_quick   ; inline operand = 12
  $87BF  E9 DB 82 06                CALL_abs_imm1          $82DB (test_map_cell_bits) {bytecode}, $06
  $87C3  D8 21 88                   JUMPF_abs              $8821
  $87C6  0C                         LOADL_quick   ; inline operand = 12
  $87C7  2B                         STORE_quick   ; inline operand = 11
  $87C8  0D                         LOADL_quick   ; inline operand = 13
  $87C9  2A                         STORE_quick   ; inline operand = 10
  $87CA  DE FC FF                   LEAL_far               $FFFC
  $87CD  B3                         PUSHL
  $87CE  DE FE FF                   LEAL_far               $FFFE
  $87D1  B3                         PUSHL
  $87D2  E9 A2 83 04                CALL_abs_imm1          $83A2 (calc_tactical_cell_coords) {bytecode}, $04
  $87D6  3D                         PUSH_quick   ; inline operand = 13
  $87D7  3C                         PUSH_quick   ; inline operand = 12
  $87D8  E9 C6 83 04                CALL_abs_imm1          $83C6 (lookup_terrain_attr_record) {bytecode}, $04
  $87DC  27                         STORE_quick   ; inline operand = 7
  $87DD  62                         PUSH_qimm   ; inline operand = 2
  $87DE  07                         LOADL_quick   ; inline operand = 7
  $87DF  78                         ADD_qimm   ; inline operand = 8
  $87E0  B3                         PUSHL
  $87E1  0A                         LOADL_quick   ; inline operand = 10
  $87E2  73                         ADD_qimm   ; inline operand = 3
  $87E3  B3                         PUSHL
  $87E4  0B                         LOADL_quick   ; inline operand = 11
  $87E5  73                         ADD_qimm   ; inline operand = 3
  $87E6  B3                         PUSHL
  $87E7  0A                         LOADL_quick   ; inline operand = 10
  $87E8  72                         ADD_qimm   ; inline operand = 2
  $87E9  B3                         PUSHL
  $87EA  3B                         PUSH_quick   ; inline operand = 11
  $87EB  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_copy_rect_wrap) {bytecode}, $0C
  $87EF  07                         LOADL_quick   ; inline operand = 7
  $87F0  D3                         BYTE_DEREF
  $87F1  D9 06 00 57 00 26 88 63 00 26 88 73 ... SWITCH_noncontig       count=6   ; .table 6 (key,target) + default (noncontiguous); SWITCH 87=>$8826 99=>$8826 115=>$8822 130=>$8822 146=>$880E 162=>$880E default=>$8810
 >$880E  41                         LOADL_qimm   ; inline operand = 1
 >$880F  28                         STORE_quick   ; inline operand = 8
 >$8810  38                         PUSH_quick   ; inline operand = 8
  $8811  0A                         LOADL_quick   ; inline operand = 10
  $8812  72                         ADD_qimm   ; inline operand = 2
  $8813  B3                         PUSHL
  $8814  0B                         LOADL_quick   ; inline operand = 11
  $8815  72                         ADD_qimm   ; inline operand = 2
  $8816  B3                         PUSHL
  $8817  0A                         LOADL_quick   ; inline operand = 10
  $8818  72                         ADD_qimm   ; inline operand = 2
  $8819  B3                         PUSHL
  $881A  0B                         LOADL_quick   ; inline operand = 11
  $881B  D0                         INC
  $881C  B3                         PUSHL
  $881D  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
 >$8821  CF                         RETURN
 >$8822  42                         LOADL_qimm   ; inline operand = 2
  $8823  D6 0F 88                   JUMP_abs               $880F
 >$8826  43                         LOADL_qimm   ; inline operand = 3
  $8827  D6 0F 88                   JUMP_abs               $880F

; ============================================================
; sub $882A   (frame_off=+0, body @ $882F)
; ============================================================
  $882F  61                         PUSH_qimm   ; inline operand = 1
  $8830  0D                         LOADL_quick   ; inline operand = 13
  $8831  59                         LOADR_qimm   ; inline operand = 9
  $8832  B5                         MULT
  $8833  8C E4 6F                   LOADR_imm2             $6FE4
  $8836  BB                         ADD
  $8837  B3                         PUSHL
  $8838  0C                         LOADL_quick   ; inline operand = 12
  $8839  8B 31                      BYTE_LOADR_imm1        +49
  $883B  B5                         MULT
  $883C  8C 24 9C                   LOADR_imm2             $9C24
  $883F  BB                         ADD
  $8840  B3                         PUSHL
  $8841  65                         PUSH_qimm   ; inline operand = 5
  $8842  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $8846  63                         PUSH_qimm   ; inline operand = 3
  $8847  0D                         LOADL_quick   ; inline operand = 13
  $8848  8B 30                      BYTE_LOADR_imm1        +48
  $884A  B5                         MULT
  $884B  90 10 15                   ADD_imm2               $1510
  $884E  B3                         PUSHL
  $884F  0C                         LOADL_quick   ; inline operand = 12
  $8850  8B 31                      BYTE_LOADR_imm1        +49
  $8852  B5                         MULT
  $8853  8C 25 9C                   LOADR_imm2             $9C25 (upload_map_cell_tiles_data_9c25)
  $8856  BB                         ADD
  $8857  B3                         PUSHL
  $8858  65                         PUSH_qimm   ; inline operand = 5
  $8859  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $885D  CF                         RETURN

; ============================================================
; sub $885E   (frame_off=-6, body @ $8863)
; ============================================================
  $8863  40                         LOADL_qimm   ; inline operand = 0
  $8864  29                         STORE_quick   ; inline operand = 9
 >$8865  09                         LOADL_quick   ; inline operand = 9
  $8866  D2                         LSHIFT1
  $8867  D2                         LSHIFT1
  $8868  7A                         ADD_qimm   ; inline operand = 10
  $8869  2B                         STORE_quick   ; inline operand = 11
  $886A  62                         PUSH_qimm   ; inline operand = 2
  $886B  A4 FE 6F                   LOADL_abs              $6FFE (tactical_battle_phase)
  $886E  53                         LOADR_qimm   ; inline operand = 3
  $886F  B5                         MULT
  $8870  19                         LOADR_quick   ; inline operand = 9
  $8871  BB                         ADD
  $8872  8B 58                      BYTE_LOADR_imm1        +88
  $8874  B5                         MULT
  $8875  8C FD 7B                   LOADR_imm2             $7BFD
  $8878  BB                         ADD
  $8879  B3                         PUSHL
  $887A  8D 19                      BYTE_PUSH_imm1         +25
  $887C  0B                         LOADL_quick   ; inline operand = 11
  $887D  73                         ADD_qimm   ; inline operand = 3
  $887E  B3                         PUSHL
  $887F  64                         PUSH_qimm   ; inline operand = 4
  $8880  3B                         PUSH_quick   ; inline operand = 11
  $8881  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_copy_rect_wrap) {bytecode}, $0C
  $8885  09                         LOADL_quick   ; inline operand = 9
  $8886  D0                         INC
  $8887  29                         STORE_quick   ; inline operand = 9
  $8888  09                         LOADL_quick   ; inline operand = 9
  $8889  55                         LOADR_qimm   ; inline operand = 5
  $888A  C6                         UCMPLT
  $888B  D7 65 88                   JUMPT_abs              $8865
  $888E  63                         PUSH_qimm   ; inline operand = 3
  $888F  8E C8 23                   PUSH_imm2              $23C8
  $8892  A4 FE 6F                   LOADL_abs              $6FFE (tactical_battle_phase)
  $8895  8B 30                      BYTE_LOADR_imm1        +48
  $8897  B5                         MULT
  $8898  B3                         PUSHL
  $8899  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $889C  E9 66 DC 02                CALL_abs_imm1          $DC66 (fief_to_mapid) {bytecode}, $02
  $88A0  8C 90 00                   LOADR_imm2             $0090 (palette_alt)
  $88A3  B5                         MULT
  $88A4  B4                         POPR
  $88A5  BB                         ADD
  $88A6  8C 04 80                   LOADR_imm2             $8004 (map_render_driver_data_8004)
  $88A9  BB                         ADD
  $88AA  B3                         PUSHL
  $88AB  65                         PUSH_qimm   ; inline operand = 5
  $88AC  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $88B0  A4 FE 6F                   LOADL_abs              $6FFE (tactical_battle_phase)
  $88B3  D8 C5 88                   JUMPF_abs              $88C5
  $88B6  62                         PUSH_qimm   ; inline operand = 2
  $88B7  8E 40 B5                   PUSH_imm2              $B540 (map_render_driver_data_b540)
  $88BA  63                         PUSH_qimm   ; inline operand = 3
  $88BB  6C                         PUSH_qimm   ; inline operand = 12
  $88BC  63                         PUSH_qimm   ; inline operand = 3
  $88BD  6B                         PUSH_qimm   ; inline operand = 11
  $88BE  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_copy_rect_wrap) {bytecode}, $0C
  $88C2  D6 D2 88                   JUMP_abs               $88D2
 >$88C5  63                         PUSH_qimm   ; inline operand = 3
  $88C6  6B                         PUSH_qimm   ; inline operand = 11
  $88C7  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $88CB  8E 44 B5                   PUSH_imm2              $B544 (map_render_driver_data_b544)
  $88CE  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$88D2  A4 FE 6F                   LOADL_abs              $6FFE (tactical_battle_phase)
  $88D5  52                         LOADR_qimm   ; inline operand = 2
  $88D6  C1                         CMPNE
  $88D7  D8 EB 88                   JUMPF_abs              $88EB
  $88DA  62                         PUSH_qimm   ; inline operand = 2
  $88DB  8E 42 B5                   PUSH_imm2              $B542 (map_render_driver_data_b542)
  $88DE  63                         PUSH_qimm   ; inline operand = 3
  $88DF  8D 1C                      BYTE_PUSH_imm1         +28
  $88E1  63                         PUSH_qimm   ; inline operand = 3
  $88E2  8D 1B                      BYTE_PUSH_imm1         +27
  $88E4  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_copy_rect_wrap) {bytecode}, $0C
  $88E8  D6 F9 88                   JUMP_abs               $88F9
 >$88EB  63                         PUSH_qimm   ; inline operand = 3
  $88EC  8D 1B                      BYTE_PUSH_imm1         +27
  $88EE  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $88F2  8E 47 B5                   PUSH_imm2              $B547 (map_render_driver_data_b547)
  $88F5  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$88F9  61                         PUSH_qimm   ; inline operand = 1
  $88FA  66                         PUSH_qimm   ; inline operand = 6
  $88FB  68                         PUSH_qimm   ; inline operand = 8
  $88FC  63                         PUSH_qimm   ; inline operand = 3
  $88FD  62                         PUSH_qimm   ; inline operand = 2
  $88FE  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8902  CF                         RETURN

; ============================================================
; sub $8903   (frame_off=-12, body @ $8908)
; ============================================================
  $8908  40                         LOADL_qimm   ; inline operand = 0
  $8909  2A                         STORE_quick   ; inline operand = 10
 >$890A  40                         LOADL_qimm   ; inline operand = 0
  $890B  2B                         STORE_quick   ; inline operand = 11
 >$890C  62                         PUSH_qimm   ; inline operand = 2
  $890D  3A                         PUSH_quick   ; inline operand = 10
  $890E  3B                         PUSH_quick   ; inline operand = 11
  $890F  E9 DB 82 06                CALL_abs_imm1          $82DB (test_map_cell_bits) {bytecode}, $06
  $8913  D8 1F 89                   JUMPF_abs              $891F
  $8916  3A                         PUSH_quick   ; inline operand = 10
  $8917  3B                         PUSH_quick   ; inline operand = 11
  $8918  E9 C6 83 04                CALL_abs_imm1          $83C6 (lookup_terrain_attr_record) {bytecode}, $04
  $891C  D6 22 89                   JUMP_abs               $8922
 >$891F  8A 4A B5                   LOADL_imm2             $B54A (map_populate_data_b54a)
 >$8922  26                         STORE_quick   ; inline operand = 6
  $8923  0A                         LOADL_quick   ; inline operand = 10
  $8924  D2                         LSHIFT1
  $8925  D2                         LSHIFT1
  $8926  27                         STORE_quick   ; inline operand = 7
  $8927  0B                         LOADL_quick   ; inline operand = 11
  $8928  51                         LOADR_qimm   ; inline operand = 1
  $8929  DA                         AND
  $892A  D8 32 89                   JUMPF_abs              $8932
  $892D  42                         LOADL_qimm   ; inline operand = 2
  $892E  CD                         SWAP
  $892F  07                         LOADL_quick   ; inline operand = 7
  $8930  BB                         ADD
  $8931  27                         STORE_quick   ; inline operand = 7
 >$8932  40                         LOADL_qimm   ; inline operand = 0
  $8933  29                         STORE_quick   ; inline operand = 9
 >$8934  40                         LOADL_qimm   ; inline operand = 0
  $8935  28                         STORE_quick   ; inline operand = 8
 >$8936  07                         LOADL_quick   ; inline operand = 7
  $8937  D2                         LSHIFT1
  $8938  D2                         LSHIFT1
  $8939  B3                         PUSHL
  $893A  0B                         LOADL_quick   ; inline operand = 11
  $893B  8B 58                      BYTE_LOADR_imm1        +88
  $893D  B5                         MULT
  $893E  B4                         POPR
  $893F  BB                         ADD
  $8940  18                         LOADR_quick   ; inline operand = 8
  $8941  BB                         ADD
  $8942  8C FD 7B                   LOADR_imm2             $7BFD
  $8945  BB                         ADD
  $8946  B3                         PUSHL
  $8947  06                         LOADL_quick   ; inline operand = 6
  $8948  D0                         INC
  $8949  26                         STORE_quick   ; inline operand = 6
  $894A  D1                         DEC
  $894B  D3                         BYTE_DEREF
  $894C  D4                         BYTE_POPSTORE
  $894D  08                         LOADL_quick   ; inline operand = 8
  $894E  D0                         INC
  $894F  28                         STORE_quick   ; inline operand = 8
  $8950  08                         LOADL_quick   ; inline operand = 8
  $8951  54                         LOADR_qimm   ; inline operand = 4
  $8952  C6                         UCMPLT
  $8953  D7 36 89                   JUMPT_abs              $8936
  $8956  09                         LOADL_quick   ; inline operand = 9
  $8957  D0                         INC
  $8958  29                         STORE_quick   ; inline operand = 9
  $8959  D1                         DEC
  $895A  07                         LOADL_quick   ; inline operand = 7
  $895B  D0                         INC
  $895C  27                         STORE_quick   ; inline operand = 7
  $895D  D1                         DEC
  $895E  09                         LOADL_quick   ; inline operand = 9
  $895F  54                         LOADR_qimm   ; inline operand = 4
  $8960  C6                         UCMPLT
  $8961  D7 34 89                   JUMPT_abs              $8934
  $8964  0B                         LOADL_quick   ; inline operand = 11
  $8965  D0                         INC
  $8966  2B                         STORE_quick   ; inline operand = 11
  $8967  0B                         LOADL_quick   ; inline operand = 11
  $8968  5B                         LOADR_qimm   ; inline operand = 11
  $8969  C6                         UCMPLT
  $896A  D7 0C 89                   JUMPT_abs              $890C
  $896D  0A                         LOADL_quick   ; inline operand = 10
  $896E  D0                         INC
  $896F  2A                         STORE_quick   ; inline operand = 10
  $8970  0A                         LOADL_quick   ; inline operand = 10
  $8971  55                         LOADR_qimm   ; inline operand = 5
  $8972  C6                         UCMPLT
  $8973  D7 0A 89                   JUMPT_abs              $890A
  $8976  CF                         RETURN

; ============================================================
; sub $8977   (frame_off=-2, body @ $897C)
; ============================================================
  $897C  61                         PUSH_qimm   ; inline operand = 1
  $897D  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $8981  40                         LOADL_qimm   ; inline operand = 0
  $8982  2B                         STORE_quick   ; inline operand = 11
 >$8983  0B                         LOADL_quick   ; inline operand = 11
  $8984  8C 5A B5                   LOADR_imm2             $B55A (combat_map_palette)
  $8987  BB                         ADD
  $8988  D3                         BYTE_DEREF
  $8989  B3                         PUSHL
  $898A  3B                         PUSH_quick   ; inline operand = 11
  $898B  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $898F  0B                         LOADL_quick   ; inline operand = 11
  $8990  D0                         INC
  $8991  2B                         STORE_quick   ; inline operand = 11
  $8992  0B                         LOADL_quick   ; inline operand = 11
  $8993  8B 10                      BYTE_LOADR_imm1        +16
  $8995  C6                         UCMPLT
  $8996  D7 83 89                   JUMPT_abs              $8983
  $8999  8D 61                      BYTE_PUSH_imm1         +97
  $899B  8E 70 15                   PUSH_imm2              $1570
  $899E  8E 6E 9F                   PUSH_imm2              $9F6E
  $89A1  64                         PUSH_qimm   ; inline operand = 4
  $89A2  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $89A6  60                         PUSH_qimm   ; inline operand = 0
  $89A7  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $89AA  D8 B3 89                   JUMPF_abs              $89B3
  $89AD  A4 EB 7F                   LOADL_abs              $7FEB (sram_save_checksum)
  $89B0  D6 BB 89                   JUMP_abs               $89BB
 >$89B3  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $89B6  B3                         PUSHL
  $89B7  E9 66 DC 02                CALL_abs_imm1          $DC66 (fief_to_mapid) {bytecode}, $02
 >$89BB  B3                         PUSHL
  $89BC  E9 2A 88 04                CALL_abs_imm1          $882A (upload_map_cell_tiles) {bytecode}, $04
  $89C0  61                         PUSH_qimm   ; inline operand = 1
  $89C1  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $89C4  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $89C8  B3                         PUSHL
  $89C9  E9 66 DC 02                CALL_abs_imm1          $DC66 (fief_to_mapid) {bytecode}, $02
  $89CD  B3                         PUSHL
  $89CE  E9 2A 88 04                CALL_abs_imm1          $882A (upload_map_cell_tiles) {bytecode}, $04
  $89D2  40                         LOADL_qimm   ; inline operand = 0
  $89D3  A8 FE 6F                   STORE_abs              $6FFE (tactical_battle_phase)
  $89D6  AC 5E 88                   CALL_abs               $885E (map_render_driver) {bytecode}
  $89D9  60                         PUSH_qimm   ; inline operand = 0
  $89DA  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $89DE  CF                         RETURN

; ============================================================
; sub $89DF   (frame_off=-10, body @ $89E4)
; ============================================================
  $89E4  3D                         PUSH_quick   ; inline operand = 13
  $89E5  3C                         PUSH_quick   ; inline operand = 12
  $89E6  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $89EA  D3                         BYTE_DEREF
  $89EB  29                         STORE_quick   ; inline operand = 9
  $89EC  3D                         PUSH_quick   ; inline operand = 13
  $89ED  3C                         PUSH_quick   ; inline operand = 12
  $89EE  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $89F2  D3                         BYTE_DEREF
  $89F3  28                         STORE_quick   ; inline operand = 8
  $89F4  09                         LOADL_quick   ; inline operand = 9
  $89F5  5A                         LOADR_qimm   ; inline operand = 10
  $89F6  C8                         UCMPGT
  $89F7  D7 00 8A                   JUMPT_abs              $8A00
  $89FA  08                         LOADL_quick   ; inline operand = 8
  $89FB  54                         LOADR_qimm   ; inline operand = 4
  $89FC  C8                         UCMPGT
  $89FD  D8 01 8A                   JUMPF_abs              $8A01
 >$8A00  CF                         RETURN
 >$8A01  39                         PUSH_quick   ; inline operand = 9
  $8A02  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $8A06  D7 11 8A                   JUMPT_abs              $8A11
  $8A09  39                         PUSH_quick   ; inline operand = 9
  $8A0A  E9 BE 95 02                CALL_abs_imm1          $95BE (draw_tactical_cursor_region_arg0) {bytecode}, $02
  $8A0E  D6 24 8B                   JUMP_abs               $8B24
 >$8A11  DE F8 FF                   LEAL_far               $FFF8
  $8A14  B3                         PUSHL
  $8A15  DE FA FF                   LEAL_far               $FFFA
  $8A18  B3                         PUSHL
  $8A19  E9 A2 83 04                CALL_abs_imm1          $83A2 (calc_tactical_cell_coords) {bytecode}, $04
  $8A1D  0D                         LOADL_quick   ; inline operand = 13
  $8A1E  D8 2E 8A                   JUMPF_abs              $8A2E
  $8A21  0C                         LOADL_quick   ; inline operand = 12
  $8A22  59                         LOADR_qimm   ; inline operand = 9
  $8A23  B5                         MULT
  $8A24  8C E5 6F                   LOADR_imm2             $6FE5
  $8A27  BB                         ADD
  $8A28  B3                         PUSHL
  $8A29  0D                         LOADL_quick   ; inline operand = 13
  $8A2A  79                         ADD_qimm   ; inline operand = 9
  $8A2B  D6 47 8A                   JUMP_abs               $8A47
 >$8A2E  0C                         LOADL_quick   ; inline operand = 12
  $8A2F  59                         LOADR_qimm   ; inline operand = 9
  $8A30  B5                         MULT
  $8A31  8C E5 6F                   LOADR_imm2             $6FE5
  $8A34  BB                         ADD
  $8A35  B3                         PUSHL
  $8A36  3C                         PUSH_quick   ; inline operand = 12
  $8A37  E9 E5 D9 02                CALL_abs_imm1          $D9E5 (test_6f65_bit7) {bytecode}, $02
  $8A3B  D8 44 8A                   JUMPF_abs              $8A44
  $8A3E  8A B2 00                   LOADL_imm2             $00B2
  $8A41  D6 47 8A                   JUMP_abs               $8A47
 >$8A44  8A B3 00                   LOADL_imm2             $00B3
 >$8A47  D4                         BYTE_POPSTORE
  $8A48  8E 0F 27                   PUSH_imm2              $270F
  $8A4B  3D                         PUSH_quick   ; inline operand = 13
  $8A4C  3C                         PUSH_quick   ; inline operand = 12
  $8A4D  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $8A51  B0                         DEREF
  $8A52  B3                         PUSHL
  $8A53  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $8A57  2B                         STORE_quick   ; inline operand = 11
  $8A58  40                         LOADL_qimm   ; inline operand = 0
  $8A59  27                         STORE_quick   ; inline operand = 7
  $8A5A  0B                         LOADL_quick   ; inline operand = 11
  $8A5B  8C E8 03                   LOADR_imm2             $03E8
  $8A5E  B8                         UDIV
  $8A5F  2A                         STORE_quick   ; inline operand = 10
  $8A60  D7 6F 8A                   JUMPT_abs              $8A6F
  $8A63  0C                         LOADL_quick   ; inline operand = 12
  $8A64  59                         LOADR_qimm   ; inline operand = 9
  $8A65  B5                         MULT
  $8A66  8C E9 6F                   LOADR_imm2             $6FE9
  $8A69  BB                         ADD
  $8A6A  B3                         PUSHL
  $8A6B  41                         LOADL_qimm   ; inline operand = 1
  $8A6C  D6 7B 8A                   JUMP_abs               $8A7B
 >$8A6F  41                         LOADL_qimm   ; inline operand = 1
  $8A70  27                         STORE_quick   ; inline operand = 7
  $8A71  0C                         LOADL_quick   ; inline operand = 12
  $8A72  59                         LOADR_qimm   ; inline operand = 9
  $8A73  B5                         MULT
  $8A74  8C E9 6F                   LOADR_imm2             $6FE9
  $8A77  BB                         ADD
  $8A78  B3                         PUSHL
  $8A79  0A                         LOADL_quick   ; inline operand = 10
  $8A7A  78                         ADD_qimm   ; inline operand = 8
 >$8A7B  D4                         BYTE_POPSTORE
  $8A7C  0B                         LOADL_quick   ; inline operand = 11
  $8A7D  8C E8 03                   LOADR_imm2             $03E8
  $8A80  BA                         UMOD
  $8A81  2B                         STORE_quick   ; inline operand = 11
  $8A82  0B                         LOADL_quick   ; inline operand = 11
  $8A83  8B 64                      BYTE_LOADR_imm1        +100
  $8A85  B8                         UDIV
  $8A86  2A                         STORE_quick   ; inline operand = 10
  $8A87  D7 9E 8A                   JUMPT_abs              $8A9E
  $8A8A  0C                         LOADL_quick   ; inline operand = 12
  $8A8B  59                         LOADR_qimm   ; inline operand = 9
  $8A8C  B5                         MULT
  $8A8D  8C EA 6F                   LOADR_imm2             $6FEA
  $8A90  BB                         ADD
  $8A91  B3                         PUSHL
  $8A92  07                         LOADL_quick   ; inline operand = 7
  $8A93  D7 9A 8A                   JUMPT_abs              $8A9A
  $8A96  41                         LOADL_qimm   ; inline operand = 1
  $8A97  D6 AA 8A                   JUMP_abs               $8AAA
 >$8A9A  48                         LOADL_qimm   ; inline operand = 8
  $8A9B  D6 AA 8A                   JUMP_abs               $8AAA
 >$8A9E  41                         LOADL_qimm   ; inline operand = 1
  $8A9F  27                         STORE_quick   ; inline operand = 7
  $8AA0  0C                         LOADL_quick   ; inline operand = 12
  $8AA1  59                         LOADR_qimm   ; inline operand = 9
  $8AA2  B5                         MULT
  $8AA3  8C EA 6F                   LOADR_imm2             $6FEA
  $8AA6  BB                         ADD
  $8AA7  B3                         PUSHL
  $8AA8  0A                         LOADL_quick   ; inline operand = 10
  $8AA9  78                         ADD_qimm   ; inline operand = 8
 >$8AAA  D4                         BYTE_POPSTORE
  $8AAB  0B                         LOADL_quick   ; inline operand = 11
  $8AAC  8B 64                      BYTE_LOADR_imm1        +100
  $8AAE  BA                         UMOD
  $8AAF  2B                         STORE_quick   ; inline operand = 11
  $8AB0  0B                         LOADL_quick   ; inline operand = 11
  $8AB1  5A                         LOADR_qimm   ; inline operand = 10
  $8AB2  B8                         UDIV
  $8AB3  2A                         STORE_quick   ; inline operand = 10
  $8AB4  D7 CB 8A                   JUMPT_abs              $8ACB
  $8AB7  0C                         LOADL_quick   ; inline operand = 12
  $8AB8  59                         LOADR_qimm   ; inline operand = 9
  $8AB9  B5                         MULT
  $8ABA  8C EB 6F                   LOADR_imm2             $6FEB
  $8ABD  BB                         ADD
  $8ABE  B3                         PUSHL
  $8ABF  07                         LOADL_quick   ; inline operand = 7
  $8AC0  D7 C7 8A                   JUMPT_abs              $8AC7
  $8AC3  41                         LOADL_qimm   ; inline operand = 1
  $8AC4  D6 D5 8A                   JUMP_abs               $8AD5
 >$8AC7  48                         LOADL_qimm   ; inline operand = 8
  $8AC8  D6 D5 8A                   JUMP_abs               $8AD5
 >$8ACB  0C                         LOADL_quick   ; inline operand = 12
  $8ACC  59                         LOADR_qimm   ; inline operand = 9
  $8ACD  B5                         MULT
  $8ACE  8C EB 6F                   LOADR_imm2             $6FEB
  $8AD1  BB                         ADD
  $8AD2  B3                         PUSHL
  $8AD3  0A                         LOADL_quick   ; inline operand = 10
  $8AD4  78                         ADD_qimm   ; inline operand = 8
 >$8AD5  D4                         BYTE_POPSTORE
  $8AD6  0B                         LOADL_quick   ; inline operand = 11
  $8AD7  5A                         LOADR_qimm   ; inline operand = 10
  $8AD8  BA                         UMOD
  $8AD9  2A                         STORE_quick   ; inline operand = 10
  $8ADA  D7 E9 8A                   JUMPT_abs              $8AE9
  $8ADD  0C                         LOADL_quick   ; inline operand = 12
  $8ADE  59                         LOADR_qimm   ; inline operand = 9
  $8ADF  B5                         MULT
  $8AE0  8C EC 6F                   LOADR_imm2             $6FEC
  $8AE3  BB                         ADD
  $8AE4  B3                         PUSHL
  $8AE5  48                         LOADL_qimm   ; inline operand = 8
  $8AE6  D6 F3 8A                   JUMP_abs               $8AF3
 >$8AE9  0C                         LOADL_quick   ; inline operand = 12
  $8AEA  59                         LOADR_qimm   ; inline operand = 9
  $8AEB  B5                         MULT
  $8AEC  8C EC 6F                   LOADR_imm2             $6FEC
  $8AEF  BB                         ADD
  $8AF0  B3                         PUSHL
  $8AF1  0A                         LOADL_quick   ; inline operand = 10
  $8AF2  78                         ADD_qimm   ; inline operand = 8
 >$8AF3  D4                         BYTE_POPSTORE
  $8AF4  0C                         LOADL_quick   ; inline operand = 12
  $8AF5  59                         LOADR_qimm   ; inline operand = 9
  $8AF6  B5                         MULT
  $8AF7  8C E4 6F                   LOADR_imm2             $6FE4
  $8AFA  BB                         ADD
  $8AFB  D3                         BYTE_DEREF
  $8AFC  B3                         PUSHL
  $8AFD  08                         LOADL_quick   ; inline operand = 8
  $8AFE  72                         ADD_qimm   ; inline operand = 2
  $8AFF  B3                         PUSHL
  $8B00  09                         LOADL_quick   ; inline operand = 9
  $8B01  72                         ADD_qimm   ; inline operand = 2
  $8B02  B3                         PUSHL
  $8B03  08                         LOADL_quick   ; inline operand = 8
  $8B04  72                         ADD_qimm   ; inline operand = 2
  $8B05  B3                         PUSHL
  $8B06  09                         LOADL_quick   ; inline operand = 9
  $8B07  D0                         INC
  $8B08  B3                         PUSHL
  $8B09  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8B0D  62                         PUSH_qimm   ; inline operand = 2
  $8B0E  0C                         LOADL_quick   ; inline operand = 12
  $8B0F  59                         LOADR_qimm   ; inline operand = 9
  $8B10  B5                         MULT
  $8B11  8C E5 6F                   LOADR_imm2             $6FE5
  $8B14  BB                         ADD
  $8B15  B3                         PUSHL
  $8B16  08                         LOADL_quick   ; inline operand = 8
  $8B17  73                         ADD_qimm   ; inline operand = 3
  $8B18  B3                         PUSHL
  $8B19  09                         LOADL_quick   ; inline operand = 9
  $8B1A  73                         ADD_qimm   ; inline operand = 3
  $8B1B  B3                         PUSHL
  $8B1C  08                         LOADL_quick   ; inline operand = 8
  $8B1D  72                         ADD_qimm   ; inline operand = 2
  $8B1E  B3                         PUSHL
  $8B1F  39                         PUSH_quick   ; inline operand = 9
  $8B20  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_copy_rect_wrap) {bytecode}, $0C
 >$8B24  CF                         RETURN

; ============================================================
; sub $8B25   (frame_off=+0, body @ $8B2A)
; ============================================================
  $8B2A  3C                         PUSH_quick   ; inline operand = 12
  $8B2B  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $8B2F  D8 38 8B                   JUMPF_abs              $8B38
  $8B32  3D                         PUSH_quick   ; inline operand = 13
  $8B33  3C                         PUSH_quick   ; inline operand = 12
  $8B34  E9 B7 87 04                CALL_abs_imm1          $87B7 (draw_tactical_terrain_feature) {bytecode}, $04
 >$8B38  CF                         RETURN

; ============================================================
; sub $8B39   (frame_off=+0, body @ $8B3E)
; ============================================================
  $8B3E  65                         PUSH_qimm   ; inline operand = 5
  $8B3F  62                         PUSH_qimm   ; inline operand = 2
  $8B40  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8B44  AC 77 D6                   CALL_abs               $D677 (draw_current_year) {bytecode}
  $8B47  6A                         PUSH_qimm   ; inline operand = 10
  $8B48  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $8B4C  AC 87 D6                   CALL_abs               $D687 (draw_current_season) {bytecode}
  $8B4F  3C                         PUSH_quick   ; inline operand = 12
  $8B50  8E 6A B5                   PUSH_imm2              $B56A (msg_day_2d)
  $8B53  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $8B57  CF                         RETURN

; ============================================================
; sub $8B58   (frame_off=-6, body @ $8B5D)
; ============================================================
  $8B5D  40                         LOADL_qimm   ; inline operand = 0
  $8B5E  2A                         STORE_quick   ; inline operand = 10
 >$8B5F  40                         LOADL_qimm   ; inline operand = 0
  $8B60  29                         STORE_quick   ; inline operand = 9
 >$8B61  39                         PUSH_quick   ; inline operand = 9
  $8B62  3A                         PUSH_quick   ; inline operand = 10
  $8B63  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $8B67  D3                         BYTE_DEREF
  $8B68  2B                         STORE_quick   ; inline operand = 11
  $8B69  3B                         PUSH_quick   ; inline operand = 11
  $8B6A  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $8B6E  D8 77 8B                   JUMPF_abs              $8B77
  $8B71  39                         PUSH_quick   ; inline operand = 9
  $8B72  3A                         PUSH_quick   ; inline operand = 10
  $8B73  E9 DF 89 04                CALL_abs_imm1          $89DF (draw_unit_count_digits) {bytecode}, $04
 >$8B77  09                         LOADL_quick   ; inline operand = 9
  $8B78  D0                         INC
  $8B79  29                         STORE_quick   ; inline operand = 9
  $8B7A  09                         LOADL_quick   ; inline operand = 9
  $8B7B  55                         LOADR_qimm   ; inline operand = 5
  $8B7C  C6                         UCMPLT
  $8B7D  D7 61 8B                   JUMPT_abs              $8B61
  $8B80  0A                         LOADL_quick   ; inline operand = 10
  $8B81  D0                         INC
  $8B82  2A                         STORE_quick   ; inline operand = 10
  $8B83  0A                         LOADL_quick   ; inline operand = 10
  $8B84  52                         LOADR_qimm   ; inline operand = 2
  $8B85  C6                         UCMPLT
  $8B86  D7 5F 8B                   JUMPT_abs              $8B5F
  $8B89  CF                         RETURN

; ============================================================
; sub $8B8A   (frame_off=-6, body @ $8B8F)
; ============================================================
  $8B8F  A4 FB 7B                   LOADL_abs              $7BFB (combat_unit_window_mode_flag)
  $8B92  52                         LOADR_qimm   ; inline operand = 2
  $8B93  C0                         CMPEQ
  $8B94  D8 D7 8B                   JUMPF_abs              $8BD7
  $8B97  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $8B9A  2B                         STORE_quick   ; inline operand = 11
  $8B9B  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $8B9E  2A                         STORE_quick   ; inline operand = 10
  $8B9F  0C                         LOADL_quick   ; inline operand = 12
  $8BA0  D8 A7 8B                   JUMPF_abs              $8BA7
  $8BA3  49                         LOADL_qimm   ; inline operand = 9
  $8BA4  D6 A8 8B                   JUMP_abs               $8BA8
 >$8BA7  4F                         LOADL_qimm   ; inline operand = 15
 >$8BA8  1D                         LOADR_quick   ; inline operand = 13
  $8BA9  BB                         ADD
  $8BAA  B3                         PUSHL
  $8BAB  66                         PUSH_qimm   ; inline operand = 6
  $8BAC  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8BB0  0D                         LOADL_quick   ; inline operand = 13
  $8BB1  D9 03 00 00 00 C2 8B 01 00 D8 8B 02 ... SWITCH_noncontig       count=3   ; .table 3 (key,target) + default (noncontiguous); SWITCH 0=>$8BC2 1=>$8BD8 2=>$8BE1 default=>$8BC9
 >$8BC2  3C                         PUSH_quick   ; inline operand = 12
  $8BC3  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
 >$8BC7  B0                         DEREF
  $8BC8  29                         STORE_quick   ; inline operand = 9
 >$8BC9  39                         PUSH_quick   ; inline operand = 9
  $8BCA  8E 74 B5                   PUSH_imm2              $B574 (msg_fmt__4d_b574)
  $8BCD  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $8BD1  3A                         PUSH_quick   ; inline operand = 10
  $8BD2  3B                         PUSH_quick   ; inline operand = 11
  $8BD3  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
 >$8BD7  CF                         RETURN
 >$8BD8  3C                         PUSH_quick   ; inline operand = 12
  $8BD9  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $8BDD  72                         ADD_qimm   ; inline operand = 2
  $8BDE  D6 C7 8B                   JUMP_abs               $8BC7
 >$8BE1  3C                         PUSH_quick   ; inline operand = 12
  $8BE2  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $8BE6  74                         ADD_qimm   ; inline operand = 4
  $8BE7  D6 C7 8B                   JUMP_abs               $8BC7

; ============================================================
; sub $8BEA   (frame_off=-2, body @ $8BEF)
; ============================================================
  $8BEF  A4 FB 7B                   LOADL_abs              $7BFB (combat_unit_window_mode_flag)
  $8BF2  52                         LOADR_qimm   ; inline operand = 2
  $8BF3  C0                         CMPEQ
  $8BF4  D8 F8 8B                   JUMPF_abs              $8BF8
  $8BF7  CF                         RETURN
 >$8BF8  AC F9 D2                   CALL_abs               $D2F9 (clear_rect_left_upper) {bytecode}
  $8BFB  41                         LOADL_qimm   ; inline operand = 1
  $8BFC  2B                         STORE_quick   ; inline operand = 11
 >$8BFD  0B                         LOADL_quick   ; inline operand = 11
  $8BFE  D7 1D 8C                   JUMPT_abs              $8C1D
  $8C01  6E                         PUSH_qimm   ; inline operand = 14
  $8C02  62                         PUSH_qimm   ; inline operand = 2
  $8C03  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8C07  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $8C0A  D8 17 8C                   JUMPF_abs              $8C17
  $8C0D  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8C10  E9 78 DE 02                CALL_abs_imm1          $DE78 (select_message_string_de78) {bytecode}, $02
  $8C14  D6 30 8C                   JUMP_abs               $8C30
 >$8C17  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $8C1A  D6 2A 8C                   JUMP_abs               $8C2A
 >$8C1D  68                         PUSH_qimm   ; inline operand = 8
  $8C1E  62                         PUSH_qimm   ; inline operand = 2
  $8C1F  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8C23  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8C26  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
 >$8C2A  59                         LOADR_qimm   ; inline operand = 9
  $8C2B  B5                         MULT
  $8C2C  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $8C2F  BB                         ADD
 >$8C30  B3                         PUSHL
  $8C31  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8C35  3B                         PUSH_quick   ; inline operand = 11
  $8C36  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $8C3A  74                         ADD_qimm   ; inline operand = 4
  $8C3B  B0                         DEREF
  $8C3C  B3                         PUSHL
  $8C3D  3B                         PUSH_quick   ; inline operand = 11
  $8C3E  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $8C42  72                         ADD_qimm   ; inline operand = 2
  $8C43  B0                         DEREF
  $8C44  B3                         PUSHL
  $8C45  3B                         PUSH_quick   ; inline operand = 11
  $8C46  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $8C4A  B0                         DEREF
  $8C4B  B3                         PUSHL
  $8C4C  8E 78 B5                   PUSH_imm2              $B578 (msg_gold_4d_rice_4d_men_4d)
  $8C4F  E9 34 D1 08                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $08
  $8C53  0B                         LOADL_quick   ; inline operand = 11
  $8C54  D1                         DEC
  $8C55  2B                         STORE_quick   ; inline operand = 11
  $8C56  0B                         LOADL_quick   ; inline operand = 11
  $8C57  50                         LOADR_qimm   ; inline operand = 0
  $8C58  C5                         SCMPGE
  $8C59  D7 FD 8B                   JUMPT_abs              $8BFD
  $8C5C  42                         LOADL_qimm   ; inline operand = 2
  $8C5D  A8 FB 7B                   STORE_abs              $7BFB (combat_unit_window_mode_flag)
  $8C60  CF                         RETURN

; ============================================================
; sub $8C61   (frame_off=-6, body @ $8C66)
; ============================================================
  $8C66  3C                         PUSH_quick   ; inline operand = 12
  $8C67  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $8C6B  8B 1A                      BYTE_LOADR_imm1        +26
  $8C6D  B5                         MULT
  $8C6E  8C 13 70                   LOADR_imm2             $7013
  $8C71  BB                         ADD
  $8C72  2A                         STORE_quick   ; inline operand = 10
  $8C73  3C                         PUSH_quick   ; inline operand = 12
  $8C74  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $8C78  B3                         PUSHL
  $8C79  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $8C7D  2B                         STORE_quick   ; inline operand = 11
  $8C7E  3C                         PUSH_quick   ; inline operand = 12
  $8C7F  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $8C83  29                         STORE_quick   ; inline operand = 9
  $8C84  46                         LOADL_qimm   ; inline operand = 6
  $8C85  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
 >$8C88  0C                         LOADL_quick   ; inline operand = 12
  $8C89  D0                         INC
  $8C8A  5C                         LOADR_qimm   ; inline operand = 12
  $8C8B  B5                         MULT
  $8C8C  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $8C8F  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $8C92  D5 FA FF 0C 00 12 8D B1 8C B1 8C B1 ... SWITCH_contig          limit=12   ; .table 12 word targets (contiguous); SWITCH 65530=>$8CB1 65531=>$8CB1 65532=>$8CB1 65533=>$8CB1 65534=>$8CB1 65535=>$8CB1 65536=>$8CE7 65537=>$8CE7 65538=>$8CE7 65539=>$8CF4 65540=>$8CF4 65541=>$8CF4 default=>$8D12
 >$8CB1  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $8CB4  D8 BB 8C                   JUMPF_abs              $8CBB
  $8CB7  0C                         LOADL_quick   ; inline operand = 12
  $8CB8  D8 E1 8C                   JUMPF_abs              $8CE1
 >$8CBB  0B                         LOADL_quick   ; inline operand = 11
  $8CBC  D0                         INC
  $8CBD  2B                         STORE_quick   ; inline operand = 11
  $8CBE  D1                         DEC
  $8CBF  D3                         BYTE_DEREF
  $8CC0  B3                         PUSHL
  $8CC1  8E 91 B5                   PUSH_imm2              $B591
 >$8CC4  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $8CC8  D6 12 8D                   JUMP_abs               $8D12
 >$8CCB  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $8CCE  D7 38 8D                   JUMPT_abs              $8D38
  $8CD1  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $8CD4  A8 5B 6F                   STORE_abs              $6F5B (active_province_idx_copy)
  $8CD7  8D 14                      BYTE_PUSH_imm1         +20
  $8CD9  6C                         PUSH_qimm   ; inline operand = 12
  $8CDA  E9 3C 81 04                CALL_abs_imm1          $813C (build_blit_fief_tile_block) {bytecode}, $04
  $8CDE  D6 38 8D                   JUMP_abs               $8D38
 >$8CE1  8E 95 B5                   PUSH_imm2              $B595
  $8CE4  D6 0E 8D                   JUMP_abs               $8D0E
 >$8CE7  09                         LOADL_quick   ; inline operand = 9
  $8CE8  72                         ADD_qimm   ; inline operand = 2
  $8CE9  29                         STORE_quick   ; inline operand = 9
  $8CEA  8F FE                      BYTE_ADD_imm1          -2
  $8CEC  B0                         DEREF
  $8CED  B3                         PUSHL
  $8CEE  8E 9A B5                   PUSH_imm2              $B59A
  $8CF1  D6 C4 8C                   JUMP_abs               $8CC4
 >$8CF4  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $8CF7  D8 FE 8C                   JUMPF_abs              $8CFE
  $8CFA  0C                         LOADL_quick   ; inline operand = 12
  $8CFB  D8 0B 8D                   JUMPF_abs              $8D0B
 >$8CFE  0A                         LOADL_quick   ; inline operand = 10
  $8CFF  72                         ADD_qimm   ; inline operand = 2
  $8D00  2A                         STORE_quick   ; inline operand = 10
  $8D01  8F FE                      BYTE_ADD_imm1          -2
  $8D03  B0                         DEREF
  $8D04  B3                         PUSHL
  $8D05  8E 9E B5                   PUSH_imm2              $B59E
  $8D08  D6 C4 8C                   JUMP_abs               $8CC4
 >$8D0B  8E A2 B5                   PUSH_imm2              $B5A2
 >$8D0E  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$8D12  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $8D15  D0                         INC
  $8D16  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $8D19  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $8D1C  8B 12                      BYTE_LOADR_imm1        +18
  $8D1E  C6                         UCMPLT
  $8D1F  D7 88 8C                   JUMPT_abs              $8C88
  $8D22  0C                         LOADL_quick   ; inline operand = 12
  $8D23  D8 CB 8C                   JUMPF_abs              $8CCB
  $8D26  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8D29  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $8D2D  A8 5B 6F                   STORE_abs              $6F5B (active_province_idx_copy)
  $8D30  8D 14                      BYTE_PUSH_imm1         +20
  $8D32  8D 18                      BYTE_PUSH_imm1         +24
  $8D34  E9 6F E7 04                CALL_abs_imm1          $E76F (draw_daimyo_portrait) {bytecode}, $04
 >$8D38  CF                         RETURN

; ============================================================
; sub $8D39   (frame_off=+0, body @ $8D3E)
; ============================================================
  $8D3E  63                         PUSH_qimm   ; inline operand = 3
  $8D3F  62                         PUSH_qimm   ; inline operand = 2
  $8D40  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8D44  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8D47  E9 D3 D9 02                CALL_abs_imm1          $D9D3 (redraw_window_row) {bytecode}, $02
  $8D4B  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8D4E  D0                         INC
  $8D4F  B3                         PUSHL
  $8D50  8E A7 B5                   PUSH_imm2              $B5A7 (msg_fief_2d_b5a7)
  $8D53  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $8D57  61                         PUSH_qimm   ; inline operand = 1
  $8D58  E9 39 8B 02                CALL_abs_imm1          $8B39 (draw_combat_day_header) {bytecode}, $02
  $8D5C  CF                         RETURN

; ============================================================
; sub $8D5D   (frame_off=-4, body @ $8D62)
; ============================================================
  $8D62  61                         PUSH_qimm   ; inline operand = 1
  $8D63  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $8D67  8D 2B                      BYTE_PUSH_imm1         +43
  $8D69  67                         PUSH_qimm   ; inline operand = 7
  $8D6A  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8D6E  8D 23                      BYTE_PUSH_imm1         +35
  $8D70  6B                         PUSH_qimm   ; inline operand = 11
  $8D71  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8D75  61                         PUSH_qimm   ; inline operand = 1
  $8D76  63                         PUSH_qimm   ; inline operand = 3
  $8D77  8D 1D                      BYTE_PUSH_imm1         +29
  $8D79  63                         PUSH_qimm   ; inline operand = 3
  $8D7A  6B                         PUSH_qimm   ; inline operand = 11
  $8D7B  E9 42 CC 0A                CALL_abs_imm1          $CC42 (ppu_fill_rect_wrap) {bytecode}, $0A
  $8D7F  61                         PUSH_qimm   ; inline operand = 1
  $8D80  66                         PUSH_qimm   ; inline operand = 6
  $8D81  8D 1D                      BYTE_PUSH_imm1         +29
  $8D83  64                         PUSH_qimm   ; inline operand = 4
  $8D84  6A                         PUSH_qimm   ; inline operand = 10
  $8D85  E9 42 CC 0A                CALL_abs_imm1          $CC42 (ppu_fill_rect_wrap) {bytecode}, $0A
  $8D89  61                         PUSH_qimm   ; inline operand = 1
  $8D8A  8D 1A                      BYTE_PUSH_imm1         +26
  $8D8C  8D 1D                      BYTE_PUSH_imm1         +29
  $8D8E  67                         PUSH_qimm   ; inline operand = 7
  $8D8F  62                         PUSH_qimm   ; inline operand = 2
  $8D90  E9 42 CC 0A                CALL_abs_imm1          $CC42 (ppu_fill_rect_wrap) {bytecode}, $0A
  $8D94  AC 5D CF                   CALL_abs               $CF5D (fill_attr_wrap) {bytecode}
  $8D97  61                         PUSH_qimm   ; inline operand = 1
  $8D98  6B                         PUSH_qimm   ; inline operand = 11
  $8D99  8D 16                      BYTE_PUSH_imm1         +22
  $8D9B  66                         PUSH_qimm   ; inline operand = 6
  $8D9C  8D 12                      BYTE_PUSH_imm1         +18
  $8D9E  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8DA2  62                         PUSH_qimm   ; inline operand = 2
  $8DA3  8D 11                      BYTE_PUSH_imm1         +17
  $8DA5  8D 17                      BYTE_PUSH_imm1         +23
  $8DA7  6C                         PUSH_qimm   ; inline operand = 12
  $8DA8  8D 12                      BYTE_PUSH_imm1         +18
  $8DAA  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8DAE  8A FF 00                   LOADL_imm2             $00FF
  $8DB1  A8 DF 7F                   STORE_abs              $7FDF (ui_input_sel_latch_7fdf)
  $8DB4  40                         LOADL_qimm   ; inline operand = 0
  $8DB5  A8 FB 7B                   STORE_abs              $7BFB (combat_unit_window_mode_flag)
  $8DB8  64                         PUSH_qimm   ; inline operand = 4
  $8DB9  6C                         PUSH_qimm   ; inline operand = 12
  $8DBA  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8DBE  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $8DC1  D8 CE 8D                   JUMPF_abs              $8DCE
  $8DC4  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8DC7  E9 78 DE 02                CALL_abs_imm1          $DE78 (select_message_string_de78) {bytecode}, $02
  $8DCB  D6 D7 8D                   JUMP_abs               $8DD7
 >$8DCE  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $8DD1  59                         LOADR_qimm   ; inline operand = 9
  $8DD2  B5                         MULT
  $8DD3  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $8DD6  BB                         ADD
 >$8DD7  B3                         PUSHL
  $8DD8  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8DDC  89 16                      BYTE_LOADL_imm1        +22
  $8DDE  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $8DE1  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8DE4  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $8DE8  59                         LOADR_qimm   ; inline operand = 9
  $8DE9  B5                         MULT
  $8DEA  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $8DED  BB                         ADD
  $8DEE  B3                         PUSHL
  $8DEF  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8DF3  40                         LOADL_qimm   ; inline operand = 0
  $8DF4  2B                         STORE_quick   ; inline operand = 11
  $8DF5  46                         LOADL_qimm   ; inline operand = 6
  $8DF6  2A                         STORE_quick   ; inline operand = 10
  $8DF7  D6 29 8E                   JUMP_abs               $8E29
 >$8DFA  0B                         LOADL_quick   ; inline operand = 11
  $8DFB  D5 F9 FF 07 00 10 8E 26 8E 26 8E 10 ... SWITCH_contig          limit=7   ; .table 7 word targets (contiguous); SWITCH 65529=>$8E26 65530=>$8E26 65531=>$8E10 65532=>$8E26 65533=>$8E26 65534=>$8E26 65535=>$8E26 default=>$8E10
 >$8E10  3A                         PUSH_quick   ; inline operand = 10
  $8E11  8D 12                      BYTE_PUSH_imm1         +18
  $8E13  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8E17  0B                         LOADL_quick   ; inline operand = 11
  $8E18  D2                         LSHIFT1
  $8E19  8C AE F8                   LOADR_imm2             $F8AE (effect_view_a_data_f8ae)
  $8E1C  BB                         ADD
  $8E1D  B0                         DEREF
  $8E1E  B3                         PUSHL
  $8E1F  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8E23  0A                         LOADL_quick   ; inline operand = 10
  $8E24  D0                         INC
  $8E25  2A                         STORE_quick   ; inline operand = 10
 >$8E26  0B                         LOADL_quick   ; inline operand = 11
  $8E27  D0                         INC
  $8E28  2B                         STORE_quick   ; inline operand = 11
 >$8E29  0B                         LOADL_quick   ; inline operand = 11
  $8E2A  8B 12                      BYTE_LOADR_imm1        +18
  $8E2C  C6                         UCMPLT
  $8E2D  D7 FA 8D                   JUMPT_abs              $8DFA
  $8E30  60                         PUSH_qimm   ; inline operand = 0
  $8E31  E9 61 8C 02                CALL_abs_imm1          $8C61 (draw_unit_roster_columns) {bytecode}, $02
  $8E35  61                         PUSH_qimm   ; inline operand = 1
  $8E36  E9 61 8C 02                CALL_abs_imm1          $8C61 (draw_unit_roster_columns) {bytecode}, $02
  $8E3A  60                         PUSH_qimm   ; inline operand = 0
  $8E3B  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $8E3F  CF                         RETURN

; ============================================================
; sub $8E40   (frame_off=+0, body @ $8E45)
; ============================================================
  $8E45  0D                         LOADL_quick   ; inline operand = 13
  $8E46  D2                         LSHIFT1
  $8E47  8C EA 7B                   LOADR_imm2             $7BEA
  $8E4A  BB                         ADD
  $8E4B  B0                         DEREF
  $8E4C  B3                         PUSHL
  $8E4D  8D 28                      BYTE_PUSH_imm1         +40
  $8E4F  3C                         PUSH_quick   ; inline operand = 12
  $8E50  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $8E54  B3                         PUSHL
  $8E55  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $8E59  1C                         LOADR_quick   ; inline operand = 12
  $8E5A  BB                         ADD
  $8E5B  CF                         RETURN

; ============================================================
; sub $8E5C   (frame_off=-12, body @ $8E61)
; ============================================================
  $8E61  40                         LOADL_qimm   ; inline operand = 0
  $8E62  A8 EC 7B                   STORE_abs              $7BEC
  $8E65  A8 EA 7B                   STORE_abs              $7BEA
  $8E68  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $8E6B  D0                         INC
  $8E6C  2B                         STORE_quick   ; inline operand = 11
  $8E6D  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8E70  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $8E74  D0                         INC
  $8E75  2A                         STORE_quick   ; inline operand = 10
  $8E76  8A B1 B5                   LOADL_imm2             $B5B1 (battle_strength_stat_weights)
  $8E79  29                         STORE_quick   ; inline operand = 9
  $8E7A  40                         LOADL_qimm   ; inline operand = 0
  $8E7B  D6 A5 8E                   JUMP_abs               $8EA5
 >$8E7E  09                         LOADL_quick   ; inline operand = 9
  $8E7F  D0                         INC
  $8E80  29                         STORE_quick   ; inline operand = 9
  $8E81  D1                         DEC
  $8E82  D3                         BYTE_DEREF
  $8E83  B3                         PUSHL
  $8E84  0A                         LOADL_quick   ; inline operand = 10
  $8E85  D0                         INC
  $8E86  2A                         STORE_quick   ; inline operand = 10
  $8E87  D1                         DEC
  $8E88  D3                         BYTE_DEREF
  $8E89  B3                         PUSHL
  $8E8A  0B                         LOADL_quick   ; inline operand = 11
  $8E8B  D0                         INC
  $8E8C  2B                         STORE_quick   ; inline operand = 11
  $8E8D  D1                         DEC
  $8E8E  D3                         BYTE_DEREF
  $8E8F  B4                         POPR
  $8E90  C3                         SCMPLE
  $8E91  D8 98 8E                   JUMPF_abs              $8E98
  $8E94  41                         LOADL_qimm   ; inline operand = 1
  $8E95  D6 99 8E                   JUMP_abs               $8E99
 >$8E98  40                         LOADL_qimm   ; inline operand = 0
 >$8E99  D2                         LSHIFT1
  $8E9A  8C EA 7B                   LOADR_imm2             $7BEA
  $8E9D  BB                         ADD
  $8E9E  B4                         POPR
  $8E9F  B3                         PUSHL
  $8EA0  B0                         DEREF
  $8EA1  BB                         ADD
  $8EA2  B1                         POPSTORE
  $8EA3  06                         LOADL_quick   ; inline operand = 6
  $8EA4  D0                         INC
 >$8EA5  26                         STORE_quick   ; inline operand = 6
  $8EA6  06                         LOADL_quick   ; inline operand = 6
  $8EA7  55                         LOADR_qimm   ; inline operand = 5
  $8EA8  C2                         SCMPLT
  $8EA9  D7 7E 8E                   JUMPT_abs              $8E7E
  $8EAC  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8EAF  8B 1A                      BYTE_LOADR_imm1        +26
  $8EB1  B5                         MULT
  $8EB2  8C 13 70                   LOADR_imm2             $7013
  $8EB5  BB                         ADD
  $8EB6  28                         STORE_quick   ; inline operand = 8
  $8EB7  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8EBA  8B 1A                      BYTE_LOADR_imm1        +26
  $8EBC  B5                         MULT
  $8EBD  8C 13 70                   LOADR_imm2             $7013
  $8EC0  BB                         ADD
  $8EC1  27                         STORE_quick   ; inline operand = 7
  $8EC2  45                         LOADL_qimm   ; inline operand = 5
  $8EC3  26                         STORE_quick   ; inline operand = 6
 >$8EC4  09                         LOADL_quick   ; inline operand = 9
  $8EC5  D0                         INC
  $8EC6  29                         STORE_quick   ; inline operand = 9
  $8EC7  D1                         DEC
  $8EC8  D3                         BYTE_DEREF
  $8EC9  B3                         PUSHL
  $8ECA  07                         LOADL_quick   ; inline operand = 7
  $8ECB  72                         ADD_qimm   ; inline operand = 2
  $8ECC  27                         STORE_quick   ; inline operand = 7
  $8ECD  8F FE                      BYTE_ADD_imm1          -2
  $8ECF  B0                         DEREF
  $8ED0  B3                         PUSHL
  $8ED1  08                         LOADL_quick   ; inline operand = 8
  $8ED2  72                         ADD_qimm   ; inline operand = 2
  $8ED3  28                         STORE_quick   ; inline operand = 8
  $8ED4  8F FE                      BYTE_ADD_imm1          -2
  $8ED6  B0                         DEREF
  $8ED7  B4                         POPR
  $8ED8  C3                         SCMPLE
  $8ED9  D8 E0 8E                   JUMPF_abs              $8EE0
  $8EDC  41                         LOADL_qimm   ; inline operand = 1
  $8EDD  D6 E1 8E                   JUMP_abs               $8EE1
 >$8EE0  40                         LOADL_qimm   ; inline operand = 0
 >$8EE1  D2                         LSHIFT1
  $8EE2  8C EA 7B                   LOADR_imm2             $7BEA
  $8EE5  BB                         ADD
  $8EE6  B4                         POPR
  $8EE7  B3                         PUSHL
  $8EE8  B0                         DEREF
  $8EE9  BB                         ADD
  $8EEA  B1                         POPSTORE
  $8EEB  06                         LOADL_quick   ; inline operand = 6
  $8EEC  D0                         INC
  $8EED  26                         STORE_quick   ; inline operand = 6
  $8EEE  06                         LOADL_quick   ; inline operand = 6
  $8EEF  57                         LOADR_qimm   ; inline operand = 7
  $8EF0  C3                         SCMPLE
  $8EF1  D7 C4 8E                   JUMPT_abs              $8EC4
  $8EF4  CF                         RETURN

; ============================================================
; sub $8EF5   (frame_off=+0, body @ $8EFA)
; ============================================================
  $8EFA  AC 5C 8E                   CALL_abs               $8E5C (ai_sum_battle_strength) {bytecode}
  $8EFD  61                         PUSH_qimm   ; inline operand = 1
  $8EFE  AA 87 6F                   PUSH_abs               $6F87 (war_defender_men)
  $8F01  E9 40 8E 04                CALL_abs_imm1          $8E40 (ai_score_strength_term_40pct) {bytecode}, $04
  $8F05  B3                         PUSHL
  $8F06  60                         PUSH_qimm   ; inline operand = 0
  $8F07  AA 81 6F                   PUSH_abs               $6F81 (war_attacker_men)
  $8F0A  E9 40 8E 04                CALL_abs_imm1          $8E40 (ai_score_strength_term_40pct) {bytecode}, $04
  $8F0E  B4                         POPR
  $8F0F  C4                         SCMPGT
  $8F10  CF                         RETURN

; ============================================================
; sub $8F11   (frame_off=+0, body @ $8F16)
; ============================================================
  $8F16  0C                         LOADL_quick   ; inline operand = 12
  $8F17  5A                         LOADR_qimm   ; inline operand = 10
  $8F18  C7                         UCMPLE
  $8F19  D8 22 8F                   JUMPF_abs              $8F22
  $8F1C  0D                         LOADL_quick   ; inline operand = 13
  $8F1D  54                         LOADR_qimm   ; inline operand = 4
  $8F1E  C7                         UCMPLE
  $8F1F  D7 26 8F                   JUMPT_abs              $8F26
 >$8F22  40                         LOADL_qimm   ; inline operand = 0
  $8F23  D6 27 8F                   JUMP_abs               $8F27
 >$8F26  41                         LOADL_qimm   ; inline operand = 1
 >$8F27  CF                         RETURN

; ============================================================
; sub $8F28   (frame_off=+0, body @ $8F2D)
; ============================================================
  $8F2D  0E                         LOADL_quick   ; inline operand = 14
  $8F2E  8B 33                      BYTE_LOADR_imm1        +51
  $8F30  C7                         UCMPLE
  $8F31  D7 3B 8F                   JUMPT_abs              $8F3B
  $8F34  0E                         LOADL_quick   ; inline operand = 14
  $8F35  8B 37                      BYTE_LOADR_imm1        +55
  $8F37  C9                         UCMPGE
  $8F38  D8 53 8F                   JUMPF_abs              $8F53
 >$8F3B  89 31                      BYTE_LOADL_imm1        +49
  $8F3D  CD                         SWAP
  $8F3E  0E                         LOADL_quick   ; inline operand = 14
  $8F3F  BC                         SUB
  $8F40  2E                         STORE_quick   ; inline operand = 14
  $8F41  56                         LOADR_qimm   ; inline operand = 6
  $8F42  C9                         UCMPGE
  $8F43  D8 4B 8F                   JUMPF_abs              $8F4B
  $8F46  43                         LOADL_qimm   ; inline operand = 3
  $8F47  CD                         SWAP
  $8F48  0E                         LOADL_quick   ; inline operand = 14
  $8F49  BC                         SUB
  $8F4A  2E                         STORE_quick   ; inline operand = 14
 >$8F4B  3E                         PUSH_quick   ; inline operand = 14
  $8F4C  3D                         PUSH_quick   ; inline operand = 13
  $8F4D  3C                         PUSH_quick   ; inline operand = 12
  $8F4E  E9 03 80 06                CALL_abs_imm1          $8003 {native}, $06
  $8F52  CF                         RETURN
 >$8F53  40                         LOADL_qimm   ; inline operand = 0
  $8F54  CF                         RETURN

; ============================================================
; sub $8F55   (frame_off=+0, body @ $8F5A)
; ============================================================
  $8F5A  8D 7F                      BYTE_PUSH_imm1         +127
  $8F5C  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $8F5F  8C 65 6F                   LOADR_imm2             $6F65 (war_side_state_flag)
  $8F62  BB                         ADD
  $8F63  B4                         POPR
  $8F64  B3                         PUSHL
  $8F65  D3                         BYTE_DEREF
  $8F66  DA                         AND
  $8F67  D4                         BYTE_POPSTORE
  $8F68  0C                         LOADL_quick   ; inline operand = 12
  $8F69  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $8F6C  BB                         ADD
  $8F6D  B3                         PUSHL
  $8F6E  40                         LOADL_qimm   ; inline operand = 0
  $8F6F  D4                         BYTE_POPSTORE
  $8F70  0D                         LOADL_quick   ; inline operand = 13
  $8F71  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $8F74  BB                         ADD
  $8F75  B3                         PUSHL
  $8F76  41                         LOADL_qimm   ; inline operand = 1
  $8F77  D4                         BYTE_POPSTORE
  $8F78  CF                         RETURN

; ============================================================
; sub $8F79   (frame_off=+0, body @ $8F7E)
; ============================================================
  $8F7E  0D                         LOADL_quick   ; inline operand = 13
  $8F7F  55                         LOADR_qimm   ; inline operand = 5
  $8F80  C6                         UCMPLT
  $8F81  D8 91 8F                   JUMPF_abs              $8F91
  $8F84  0C                         LOADL_quick   ; inline operand = 12
  $8F85  8C 65 6F                   LOADR_imm2             $6F65 (war_side_state_flag)
  $8F88  BB                         ADD
  $8F89  D3                         BYTE_DEREF
  $8F8A  1D                         LOADR_quick   ; inline operand = 13
  $8F8B  BE                         URSHIFT
  $8F8C  51                         LOADR_qimm   ; inline operand = 1
  $8F8D  DA                         AND
  $8F8E  D7 95 8F                   JUMPT_abs              $8F95
 >$8F91  40                         LOADL_qimm   ; inline operand = 0
  $8F92  D6 96 8F                   JUMP_abs               $8F96
 >$8F95  41                         LOADL_qimm   ; inline operand = 1
 >$8F96  CF                         RETURN

; ============================================================
; sub $8F97   (frame_off=+0, body @ $8F9C)
; ============================================================
  $8F9C  0D                         LOADL_quick   ; inline operand = 13
  $8F9D  8C B9 B5                   LOADR_imm2             $B5B9 (clear_unit_status_flag_s_data_b5b9)
  $8FA0  BB                         ADD
  $8FA1  D3                         BYTE_DEREF
  $8FA2  B3                         PUSHL
  $8FA3  0C                         LOADL_quick   ; inline operand = 12
  $8FA4  8C 65 6F                   LOADR_imm2             $6F65 (war_side_state_flag)
  $8FA7  BB                         ADD
  $8FA8  B4                         POPR
  $8FA9  B3                         PUSHL
  $8FAA  D3                         BYTE_DEREF
  $8FAB  DA                         AND
  $8FAC  D4                         BYTE_POPSTORE
  $8FAD  3D                         PUSH_quick   ; inline operand = 13
  $8FAE  3C                         PUSH_quick   ; inline operand = 12
  $8FAF  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $8FB3  B3                         PUSHL
  $8FB4  3D                         PUSH_quick   ; inline operand = 13
  $8FB5  3C                         PUSH_quick   ; inline operand = 12
  $8FB6  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $8FBA  B3                         PUSHL
  $8FBB  89 C8                      BYTE_LOADL_imm1        -56
  $8FBD  D4                         BYTE_POPSTORE
  $8FBE  D4                         BYTE_POPSTORE
  $8FBF  CF                         RETURN

; ============================================================
; sub $8FC0   (frame_off=-2, body @ $8FC5)
; ============================================================
  $8FC5  40                         LOADL_qimm   ; inline operand = 0
  $8FC6  2B                         STORE_quick   ; inline operand = 11
 >$8FC7  3B                         PUSH_quick   ; inline operand = 11
  $8FC8  3C                         PUSH_quick   ; inline operand = 12
  $8FC9  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $8FCD  D3                         BYTE_DEREF
  $8FCE  1D                         LOADR_quick   ; inline operand = 13
  $8FCF  C0                         CMPEQ
  $8FD0  D8 E1 8F                   JUMPF_abs              $8FE1
  $8FD3  3B                         PUSH_quick   ; inline operand = 11
  $8FD4  3C                         PUSH_quick   ; inline operand = 12
  $8FD5  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $8FD9  D3                         BYTE_DEREF
  $8FDA  1E                         LOADR_quick   ; inline operand = 14
  $8FDB  C0                         CMPEQ
  $8FDC  D8 E1 8F                   JUMPF_abs              $8FE1
  $8FDF  41                         LOADL_qimm   ; inline operand = 1
  $8FE0  CF                         RETURN
 >$8FE1  0B                         LOADL_quick   ; inline operand = 11
  $8FE2  D0                         INC
  $8FE3  2B                         STORE_quick   ; inline operand = 11
  $8FE4  0B                         LOADL_quick   ; inline operand = 11
  $8FE5  55                         LOADR_qimm   ; inline operand = 5
  $8FE6  C6                         UCMPLT
  $8FE7  D7 C7 8F                   JUMPT_abs              $8FC7
  $8FEA  40                         LOADL_qimm   ; inline operand = 0
  $8FEB  CF                         RETURN

; ============================================================
; sub $8FEC   (frame_off=-4, body @ $8FF1)
; ============================================================
  $8FF1  40                         LOADL_qimm   ; inline operand = 0
  $8FF2  2B                         STORE_quick   ; inline operand = 11
 >$8FF3  3D                         PUSH_quick   ; inline operand = 13
  $8FF4  3C                         PUSH_quick   ; inline operand = 12
  $8FF5  3B                         PUSH_quick   ; inline operand = 11
  $8FF6  E9 C0 8F 06                CALL_abs_imm1          $8FC0 (find_unit_slot_by_fields) {bytecode}, $06
  $8FFA  D8 FF 8F                   JUMPF_abs              $8FFF
  $8FFD  41                         LOADL_qimm   ; inline operand = 1
  $8FFE  CF                         RETURN
 >$8FFF  0B                         LOADL_quick   ; inline operand = 11
  $9000  D0                         INC
  $9001  2B                         STORE_quick   ; inline operand = 11
  $9002  0B                         LOADL_quick   ; inline operand = 11
  $9003  52                         LOADR_qimm   ; inline operand = 2
  $9004  C6                         UCMPLT
  $9005  D7 F3 8F                   JUMPT_abs              $8FF3
  $9008  40                         LOADL_qimm   ; inline operand = 0
  $9009  CF                         RETURN

; ============================================================
; sub $900A   (frame_off=+0, body @ $900F)
; ============================================================
  $900F  0C                         LOADL_quick   ; inline operand = 12
  $9010  52                         LOADR_qimm   ; inline operand = 2
  $9011  C8                         UCMPGT
  $9012  D8 17 90                   JUMPF_abs              $9017
  $9015  40                         LOADL_qimm   ; inline operand = 0
  $9016  2C                         STORE_quick   ; inline operand = 12
 >$9017  0C                         LOADL_quick   ; inline operand = 12
  $9018  CF                         RETURN

; ============================================================
; sub $9019   (frame_off=+0, body @ $901E)
; ============================================================
  $901E  8E C2 00                   PUSH_imm2              $00C2
  $9021  3D                         PUSH_quick   ; inline operand = 13
  $9022  3C                         PUSH_quick   ; inline operand = 12
  $9023  E9 DB 82 06                CALL_abs_imm1          $82DB (test_map_cell_bits) {bytecode}, $06
  $9027  D8 2E 90                   JUMPF_abs              $902E
  $902A  40                         LOADL_qimm   ; inline operand = 0
  $902B  D6 2F 90                   JUMP_abs               $902F
 >$902E  41                         LOADL_qimm   ; inline operand = 1
 >$902F  CF                         RETURN

; ============================================================
; sub $9030   (frame_off=-2, body @ $9035)
; ============================================================
  $9035  3C                         PUSH_quick   ; inline operand = 12
  $9036  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $903A  2B                         STORE_quick   ; inline operand = 11
  $903B  3B                         PUSH_quick   ; inline operand = 11
  $903C  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9040  55                         LOADR_qimm   ; inline operand = 5
  $9041  C1                         CMPNE
  $9042  D7 56 90                   JUMPT_abs              $9056
  $9045  3B                         PUSH_quick   ; inline operand = 11
  $9046  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $904A  8C 67 6D                   LOADR_imm2             $6D67 (rest_turns_remaining)
  $904D  BB                         ADD
  $904E  D3                         BYTE_DEREF
  $904F  D7 56 90                   JUMPT_abs              $9056
  $9052  40                         LOADL_qimm   ; inline operand = 0
  $9053  D6 57 90                   JUMP_abs               $9057
 >$9056  41                         LOADL_qimm   ; inline operand = 1
 >$9057  CF                         RETURN

; ============================================================
; sub $9058   (frame_off=+0, body @ $905D)
; ============================================================
  $905D  3D                         PUSH_quick   ; inline operand = 13
  $905E  3C                         PUSH_quick   ; inline operand = 12
  $905F  E9 11 8F 04                CALL_abs_imm1          $8F11 (is_tile_in_bounds) {bytecode}, $04
  $9063  D8 9E 90                   JUMPF_abs              $909E
  $9066  3D                         PUSH_quick   ; inline operand = 13
  $9067  3C                         PUSH_quick   ; inline operand = 12
  $9068  E9 EC 8F 04                CALL_abs_imm1          $8FEC (find_unit_at_tile) {bytecode}, $04
  $906C  D7 9E 90                   JUMPT_abs              $909E
  $906F  3D                         PUSH_quick   ; inline operand = 13
  $9070  3C                         PUSH_quick   ; inline operand = 12
  $9071  E9 19 90 04                CALL_abs_imm1          $9019 (test_map_cell_blocked_c2) {bytecode}, $04
  $9075  D7 9E 90                   JUMPT_abs              $909E
  $9078  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $907B  D3                         BYTE_DEREF
  $907C  B3                         PUSHL
  $907D  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $9080  D3                         BYTE_DEREF
  $9081  B3                         PUSHL
  $9082  E9 25 8B 04                CALL_abs_imm1          $8B25 (draw_terrain_feature_if_valid) {bytecode}, $04
  $9086  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $9089  B3                         PUSHL
  $908A  0C                         LOADL_quick   ; inline operand = 12
  $908B  D4                         BYTE_POPSTORE
  $908C  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $908F  B3                         PUSHL
  $9090  0D                         LOADL_quick   ; inline operand = 13
  $9091  D4                         BYTE_POPSTORE
  $9092  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $9095  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9098  E9 DF 89 04                CALL_abs_imm1          $89DF (draw_unit_count_digits) {bytecode}, $04
  $909C  41                         LOADL_qimm   ; inline operand = 1
  $909D  CF                         RETURN
 >$909E  40                         LOADL_qimm   ; inline operand = 0
  $909F  CF                         RETURN

; ============================================================
; sub $90A0   (frame_off=+0, body @ $90A5)
; ============================================================
  $90A5  8E BE B5                   PUSH_imm2              $B5BE (msg_up_up_rt_down_rt_down_down_lt)
  $90A8  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $90AC  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $90AF  D3                         BYTE_DEREF
  $90B0  B3                         PUSHL
  $90B1  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $90B4  D3                         BYTE_DEREF
  $90B5  B3                         PUSHL
  $90B6  E9 F9 86 04                CALL_abs_imm1          $86F9 (select_entry_from_b52f_table_by_cursor) {bytecode}, $04
  $90BA  CF                         RETURN

; ============================================================
; sub $90BB   (frame_off=-14, body @ $90C0)
; ============================================================
  $90C0  3C                         PUSH_quick   ; inline operand = 12
  $90C1  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $90C5  25                         STORE_quick   ; inline operand = 5
  $90C6  DE F8 FF                   LEAL_far               $FFF8
  $90C9  27                         STORE_quick   ; inline operand = 7
  $90CA  8A 4F 6F                   LOADL_imm2             $6F4F (deduped_owner_list)
  $90CD  D6 F0 90                   JUMP_abs               $90F0
 >$90D0  06                         LOADL_quick   ; inline operand = 6
  $90D1  D3                         BYTE_DEREF
  $90D2  B3                         PUSHL
  $90D3  E9 99 D9 02                CALL_abs_imm1          $D999 (province_state_is_FF) {bytecode}, $02
  $90D7  D7 EE 90                   JUMPT_abs              $90EE
  $90DA  06                         LOADL_quick   ; inline operand = 6
  $90DB  D3                         BYTE_DEREF
  $90DC  B3                         PUSHL
  $90DD  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $90E1  15                         LOADR_quick   ; inline operand = 5
  $90E2  C0                         CMPEQ
  $90E3  D8 EE 90                   JUMPF_abs              $90EE
  $90E6  07                         LOADL_quick   ; inline operand = 7
  $90E7  D0                         INC
  $90E8  27                         STORE_quick   ; inline operand = 7
  $90E9  D1                         DEC
  $90EA  B3                         PUSHL
  $90EB  06                         LOADL_quick   ; inline operand = 6
  $90EC  D3                         BYTE_DEREF
  $90ED  D4                         BYTE_POPSTORE
 >$90EE  06                         LOADL_quick   ; inline operand = 6
  $90EF  D0                         INC
 >$90F0  26                         STORE_quick   ; inline operand = 6
  $90F1  06                         LOADL_quick   ; inline operand = 6
  $90F2  D3                         BYTE_DEREF
  $90F3  8C FF 00                   LOADR_imm2             $00FF
  $90F6  C1                         CMPNE
  $90F7  D7 D0 90                   JUMPT_abs              $90D0
  $90FA  37                         PUSH_quick   ; inline operand = 7
  $90FB  89 FF                      BYTE_LOADL_imm1        -1
  $90FD  D4                         BYTE_POPSTORE
  $90FE  68                         PUSH_qimm   ; inline operand = 8
  $90FF  8E 4F 6F                   PUSH_imm2              $6F4F (deduped_owner_list)
  $9102  DE F8 FF                   LEAL_far               $FFF8
  $9105  B3                         PUSHL
  $9106  62                         PUSH_qimm   ; inline operand = 2
  $9107  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $910B  CF                         RETURN

; ============================================================
; sub $910C   (frame_off=-2, body @ $9111)
; ============================================================
  $9111  8D 18                      BYTE_PUSH_imm1         +24
  $9113  62                         PUSH_qimm   ; inline operand = 2
  $9114  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $9118  8E E9 B5                   PUSH_imm2              $B5E9 (msg_hit_any_key)
  $911B  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $911F  AC 87 D2                   CALL_abs               $D287 (wait_button_edge) {bytecode}
  $9122  2B                         STORE_quick   ; inline operand = 11
  $9123  AC 09 D3                   CALL_abs               $D309 (clear_rect_left_lower) {bytecode}
  $9126  AC E1 CC                   CALL_abs               $CCE1 (reset_prompt_selection) {bytecode}
  $9129  0B                         LOADL_quick   ; inline operand = 11
  $912A  CF                         RETURN

; ============================================================
; sub $912B   (frame_off=-6, body @ $9130)
; ============================================================
  $9130  40                         LOADL_qimm   ; inline operand = 0
  $9131  2B                         STORE_quick   ; inline operand = 11
  $9132  8E F6 B5                   PUSH_imm2              $B5F6 (msg_fief_b5f6)
  $9135  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9139  40                         LOADL_qimm   ; inline operand = 0
  $913A  2A                         STORE_quick   ; inline operand = 10
  $913B  8A 4F 6F                   LOADL_imm2             $6F4F (deduped_owner_list)
  $913E  29                         STORE_quick   ; inline operand = 9
  $913F  D6 88 91                   JUMP_abs               $9188
 >$9142  41                         LOADL_qimm   ; inline operand = 1
  $9143  2A                         STORE_quick   ; inline operand = 10
  $9144  09                         LOADL_quick   ; inline operand = 9
  $9145  D0                         INC
  $9146  29                         STORE_quick   ; inline operand = 9
  $9147  D1                         DEC
  $9148  D3                         BYTE_DEREF
  $9149  D0                         INC
  $914A  B3                         PUSHL
  $914B  8E FD B5                   PUSH_imm2              $B5FD (msg_fmt__2d_b5fd)
  $914E  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $9152  0B                         LOADL_quick   ; inline operand = 11
  $9153  D0                         INC
  $9154  2B                         STORE_quick   ; inline operand = 11
  $9155  0B                         LOADL_quick   ; inline operand = 11
  $9156  53                         LOADR_qimm   ; inline operand = 3
  $9157  BA                         UMOD
  $9158  D7 5F 91                   JUMPT_abs              $915F
  $915B  4A                         LOADL_qimm   ; inline operand = 10
  $915C  D6 61 91                   JUMP_abs               $9161
 >$915F  89 20                      BYTE_LOADL_imm1        +32
 >$9161  B3                         PUSHL
  $9162  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $9166  0B                         LOADL_quick   ; inline operand = 11
  $9167  56                         LOADR_qimm   ; inline operand = 6
  $9168  C0                         CMPEQ
  $9169  D8 88 91                   JUMPF_abs              $9188
  $916C  09                         LOADL_quick   ; inline operand = 9
  $916D  D3                         BYTE_DEREF
  $916E  8C FF 00                   LOADR_imm2             $00FF
  $9171  C1                         CMPNE
  $9172  D8 88 91                   JUMPF_abs              $9188
  $9175  AC 0C 91                   CALL_abs               $910C (prompt_hit_any_key_return_button) {bytecode}
  $9178  52                         LOADR_qimm   ; inline operand = 2
  $9179  C0                         CMPEQ
  $917A  D8 7F 91                   JUMPF_abs              $917F
  $917D  40                         LOADL_qimm   ; inline operand = 0
  $917E  CF                         RETURN
 >$917F  8E 01 B6                   PUSH_imm2              $B601 (msg_fief_b601)
  $9182  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9186  40                         LOADL_qimm   ; inline operand = 0
  $9187  2B                         STORE_quick   ; inline operand = 11
 >$9188  09                         LOADL_quick   ; inline operand = 9
  $9189  D3                         BYTE_DEREF
  $918A  8C FF 00                   LOADR_imm2             $00FF
  $918D  C1                         CMPNE
  $918E  D7 42 91                   JUMPT_abs              $9142
  $9191  0A                         LOADL_quick   ; inline operand = 10
  $9192  D7 9F 91                   JUMPT_abs              $919F
  $9195  8E 08 B6                   PUSH_imm2              $B608 (msg_there_is_no_fief_to_flee_to)
  $9198  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $919C  AC 1A D3                   CALL_abs               $D31A (clear_rect_left_lower_alt) {bytecode}
 >$919F  0A                         LOADL_quick   ; inline operand = 10
  $91A0  CF                         RETURN

; ============================================================
; sub $91A1   (frame_off=-4, body @ $91A6)
; ============================================================
  $91A6  8A 4F 6F                   LOADL_imm2             $6F4F (deduped_owner_list)
  $91A9  2A                         STORE_quick   ; inline operand = 10
  $91AA  AA 9D 6D                   PUSH_abs               $6D9D (scenario_fief_count)
  $91AD  61                         PUSH_qimm   ; inline operand = 1
  $91AE  E9 9D D5 04                CALL_abs_imm1          $D59D (select_province_by_cursor) {bytecode}, $04
  $91B2  2B                         STORE_quick   ; inline operand = 11
  $91B3  D8 D1 91                   JUMPF_abs              $91D1
  $91B6  0B                         LOADL_quick   ; inline operand = 11
  $91B7  D1                         DEC
  $91B8  2B                         STORE_quick   ; inline operand = 11
  $91B9  D6 C8 91                   JUMP_abs               $91C8
 >$91BC  0A                         LOADL_quick   ; inline operand = 10
  $91BD  D3                         BYTE_DEREF
  $91BE  1B                         LOADR_quick   ; inline operand = 11
  $91BF  C0                         CMPEQ
  $91C0  D8 C5 91                   JUMPF_abs              $91C5
  $91C3  0B                         LOADL_quick   ; inline operand = 11
  $91C4  CF                         RETURN
 >$91C5  0A                         LOADL_quick   ; inline operand = 10
  $91C6  D0                         INC
  $91C7  2A                         STORE_quick   ; inline operand = 10
 >$91C8  0A                         LOADL_quick   ; inline operand = 10
  $91C9  D3                         BYTE_DEREF
  $91CA  8C FF 00                   LOADR_imm2             $00FF
  $91CD  C1                         CMPNE
  $91CE  D7 BC 91                   JUMPT_abs              $91BC
 >$91D1  8A FF 00                   LOADL_imm2             $00FF
  $91D4  CF                         RETURN

; ============================================================
; sub $91D5   (frame_off=-12, body @ $91DA)
; ============================================================
  $91DA  40                         LOADL_qimm   ; inline operand = 0
  $91DB  28                         STORE_quick   ; inline operand = 8
 >$91DC  38                         PUSH_quick   ; inline operand = 8
  $91DD  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $91E1  74                         ADD_qimm   ; inline operand = 4
  $91E2  B0                         DEREF
  $91E3  2B                         STORE_quick   ; inline operand = 11
  $91E4  08                         LOADL_quick   ; inline operand = 8
  $91E5  5A                         LOADR_qimm   ; inline operand = 10
  $91E6  B5                         MULT
  $91E7  8C BC 6F                   LOADR_imm2             $6FBC
  $91EA  BB                         ADD
  $91EB  29                         STORE_quick   ; inline operand = 9
  $91EC  38                         PUSH_quick   ; inline operand = 8
  $91ED  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $91F1  55                         LOADR_qimm   ; inline operand = 5
  $91F2  B5                         MULT
  $91F3  8C A9 76                   LOADR_imm2             $76A9
  $91F6  BB                         ADD
  $91F7  26                         STORE_quick   ; inline operand = 6
  $91F8  8D 1F                      BYTE_PUSH_imm1         +31
  $91FA  08                         LOADL_quick   ; inline operand = 8
  $91FB  8C 65 6F                   LOADR_imm2             $6F65 (war_side_state_flag)
  $91FE  BB                         ADD
  $91FF  B4                         POPR
  $9200  B3                         PUSHL
  $9201  D3                         BYTE_DEREF
  $9202  DB                         OR
  $9203  D4                         BYTE_POPSTORE
  $9204  39                         PUSH_quick   ; inline operand = 9
  $9205  06                         LOADL_quick   ; inline operand = 6
  $9206  D3                         BYTE_DEREF
  $9207  B3                         PUSHL
  $9208  3B                         PUSH_quick   ; inline operand = 11
  $9209  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $920D  B1                         POPSTORE
  $920E  2A                         STORE_quick   ; inline operand = 10
  $920F  50                         LOADR_qimm   ; inline operand = 0
  $9210  C3                         SCMPLE
  $9211  D8 18 92                   JUMPF_abs              $9218
  $9214  39                         PUSH_quick   ; inline operand = 9
  $9215  41                         LOADL_qimm   ; inline operand = 1
  $9216  B1                         POPSTORE
  $9217  2A                         STORE_quick   ; inline operand = 10
 >$9218  41                         LOADL_qimm   ; inline operand = 1
  $9219  27                         STORE_quick   ; inline operand = 7
 >$921A  0B                         LOADL_quick   ; inline operand = 11
  $921B  1A                         LOADR_quick   ; inline operand = 10
  $921C  BC                         SUB
  $921D  50                         LOADR_qimm   ; inline operand = 0
  $921E  C4                         SCMPGT
  $921F  D8 39 92                   JUMPF_abs              $9239
  $9222  07                         LOADL_quick   ; inline operand = 7
  $9223  D2                         LSHIFT1
  $9224  19                         LOADR_quick   ; inline operand = 9
  $9225  BB                         ADD
  $9226  B3                         PUSHL
  $9227  06                         LOADL_quick   ; inline operand = 6
  $9228  17                         LOADR_quick   ; inline operand = 7
  $9229  BB                         ADD
  $922A  D3                         BYTE_DEREF
  $922B  B3                         PUSHL
  $922C  3B                         PUSH_quick   ; inline operand = 11
  $922D  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9231  B1                         POPSTORE
  $9232  CD                         SWAP
  $9233  0A                         LOADL_quick   ; inline operand = 10
  $9234  BB                         ADD
  $9235  2A                         STORE_quick   ; inline operand = 10
  $9236  D6 40 92                   JUMP_abs               $9240
 >$9239  07                         LOADL_quick   ; inline operand = 7
  $923A  D2                         LSHIFT1
  $923B  19                         LOADR_quick   ; inline operand = 9
  $923C  BB                         ADD
  $923D  B3                         PUSHL
  $923E  40                         LOADL_qimm   ; inline operand = 0
  $923F  B1                         POPSTORE
 >$9240  07                         LOADL_quick   ; inline operand = 7
  $9241  D0                         INC
  $9242  27                         STORE_quick   ; inline operand = 7
  $9243  07                         LOADL_quick   ; inline operand = 7
  $9244  55                         LOADR_qimm   ; inline operand = 5
  $9245  C6                         UCMPLT
  $9246  D7 1A 92                   JUMPT_abs              $921A
  $9249  0A                         LOADL_quick   ; inline operand = 10
  $924A  CD                         SWAP
  $924B  0B                         LOADL_quick   ; inline operand = 11
  $924C  BC                         SUB
  $924D  2B                         STORE_quick   ; inline operand = 11
  $924E  50                         LOADR_qimm   ; inline operand = 0
  $924F  C4                         SCMPGT
  $9250  D8 79 92                   JUMPF_abs              $9279
  $9253  40                         LOADL_qimm   ; inline operand = 0
  $9254  27                         STORE_quick   ; inline operand = 7
  $9255  D6 73 92                   JUMP_abs               $9273
 >$9258  45                         LOADL_qimm   ; inline operand = 5
  $9259  CD                         SWAP
  $925A  07                         LOADL_quick   ; inline operand = 7
  $925B  BA                         UMOD
  $925C  27                         STORE_quick   ; inline operand = 7
  $925D  16                         LOADR_quick   ; inline operand = 6
  $925E  BB                         ADD
  $925F  D3                         BYTE_DEREF
  $9260  D8 6B 92                   JUMPF_abs              $926B
  $9263  07                         LOADL_quick   ; inline operand = 7
  $9264  D2                         LSHIFT1
  $9265  19                         LOADR_quick   ; inline operand = 9
  $9266  BB                         ADD
  $9267  B3                         PUSHL
  $9268  B0                         DEREF
  $9269  D0                         INC
  $926A  B1                         POPSTORE
 >$926B  0B                         LOADL_quick   ; inline operand = 11
  $926C  D1                         DEC
  $926D  2B                         STORE_quick   ; inline operand = 11
  $926E  D0                         INC
  $926F  07                         LOADL_quick   ; inline operand = 7
  $9270  D0                         INC
  $9271  27                         STORE_quick   ; inline operand = 7
  $9272  D1                         DEC
 >$9273  0B                         LOADL_quick   ; inline operand = 11
  $9274  50                         LOADR_qimm   ; inline operand = 0
  $9275  C4                         SCMPGT
  $9276  D7 58 92                   JUMPT_abs              $9258
 >$9279  40                         LOADL_qimm   ; inline operand = 0
  $927A  27                         STORE_quick   ; inline operand = 7
 >$927B  07                         LOADL_quick   ; inline operand = 7
  $927C  D2                         LSHIFT1
  $927D  19                         LOADR_quick   ; inline operand = 9
  $927E  BB                         ADD
  $927F  B0                         DEREF
  $9280  D7 89 92                   JUMPT_abs              $9289
  $9283  37                         PUSH_quick   ; inline operand = 7
  $9284  38                         PUSH_quick   ; inline operand = 8
  $9285  E9 97 8F 04                CALL_abs_imm1          $8F97 (clear_unit_status_flag_set_field_200) {bytecode}, $04
 >$9289  07                         LOADL_quick   ; inline operand = 7
  $928A  D0                         INC
  $928B  27                         STORE_quick   ; inline operand = 7
  $928C  07                         LOADL_quick   ; inline operand = 7
  $928D  55                         LOADR_qimm   ; inline operand = 5
  $928E  C6                         UCMPLT
  $928F  D7 7B 92                   JUMPT_abs              $927B
  $9292  08                         LOADL_quick   ; inline operand = 8
  $9293  D0                         INC
  $9294  28                         STORE_quick   ; inline operand = 8
  $9295  08                         LOADL_quick   ; inline operand = 8
  $9296  52                         LOADR_qimm   ; inline operand = 2
  $9297  C6                         UCMPLT
  $9298  D7 DC 91                   JUMPT_abs              $91DC
  $929B  CF                         RETURN

; ============================================================
; sub $929C   (frame_off=-4, body @ $92A1)
; ============================================================
  $92A1  40                         LOADL_qimm   ; inline operand = 0
  $92A2  2B                         STORE_quick   ; inline operand = 11
 >$92A3  40                         LOADL_qimm   ; inline operand = 0
  $92A4  2A                         STORE_quick   ; inline operand = 10
 >$92A5  3A                         PUSH_quick   ; inline operand = 10
  $92A6  3B                         PUSH_quick   ; inline operand = 11
  $92A7  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $92AB  B3                         PUSHL
  $92AC  3A                         PUSH_quick   ; inline operand = 10
  $92AD  3B                         PUSH_quick   ; inline operand = 11
  $92AE  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $92B2  B3                         PUSHL
  $92B3  89 C8                      BYTE_LOADL_imm1        -56
  $92B5  D4                         BYTE_POPSTORE
  $92B6  D4                         BYTE_POPSTORE
  $92B7  0A                         LOADL_quick   ; inline operand = 10
  $92B8  D0                         INC
  $92B9  2A                         STORE_quick   ; inline operand = 10
  $92BA  0A                         LOADL_quick   ; inline operand = 10
  $92BB  55                         LOADR_qimm   ; inline operand = 5
  $92BC  C6                         UCMPLT
  $92BD  D7 A5 92                   JUMPT_abs              $92A5
  $92C0  0B                         LOADL_quick   ; inline operand = 11
  $92C1  D0                         INC
  $92C2  2B                         STORE_quick   ; inline operand = 11
  $92C3  0B                         LOADL_quick   ; inline operand = 11
  $92C4  52                         LOADR_qimm   ; inline operand = 2
  $92C5  C6                         UCMPLT
  $92C6  D7 A3 92                   JUMPT_abs              $92A3
  $92C9  CF                         RETURN

; ============================================================
; sub $92CA   (frame_off=-2, body @ $92CF)
; ============================================================
  $92CF  8A FF 00                   LOADL_imm2             $00FF
  $92D2  A8 E1 7F                   STORE_abs              $7FE1
  $92D5  40                         LOADL_qimm   ; inline operand = 0
  $92D6  2B                         STORE_quick   ; inline operand = 11
  $92D7  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $92DA  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $92DD  BB                         ADD
  $92DE  D3                         BYTE_DEREF
  $92DF  57                         LOADR_qimm   ; inline operand = 7
  $92E0  BD                         LSHIFT
  $92E1  A9 66 6F                   BYTE_STORE_abs         $6F66 (battle_defender_status_flag_6f66)
  $92E4  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $92E7  8B 1A                      BYTE_LOADR_imm1        +26
  $92E9  B5                         MULT
  $92EA  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $92ED  BB                         ADD
  $92EE  B0                         DEREF
  $92EF  A8 83 6F                   STORE_abs              $6F83 (war_defender_gold)
  $92F2  50                         LOADR_qimm   ; inline operand = 0
  $92F3  C3                         SCMPLE
  $92F4  D8 07 93                   JUMPF_abs              $9307
  $92F7  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $92FA  8B 1A                      BYTE_LOADR_imm1        +26
  $92FC  B5                         MULT
  $92FD  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9300  BB                         ADD
  $9301  B3                         PUSHL
  $9302  40                         LOADL_qimm   ; inline operand = 0
  $9303  B1                         POPSTORE
  $9304  A8 83 6F                   STORE_abs              $6F83 (war_defender_gold)
 >$9307  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $930A  8B 1A                      BYTE_LOADR_imm1        +26
  $930C  B5                         MULT
  $930D  8C 07 70                   LOADR_imm2             $7007
  $9310  BB                         ADD
  $9311  B0                         DEREF
  $9312  A8 85 6F                   STORE_abs              $6F85 (war_defender_rice)
  $9315  50                         LOADR_qimm   ; inline operand = 0
  $9316  C3                         SCMPLE
  $9317  D8 2C 93                   JUMPF_abs              $932C
  $931A  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $931D  8B 1A                      BYTE_LOADR_imm1        +26
  $931F  B5                         MULT
  $9320  8C 07 70                   LOADR_imm2             $7007
  $9323  BB                         ADD
  $9324  B3                         PUSHL
  $9325  40                         LOADL_qimm   ; inline operand = 0
  $9326  B1                         POPSTORE
  $9327  A8 85 6F                   STORE_abs              $6F85 (war_defender_rice)
  $932A  47                         LOADL_qimm   ; inline operand = 7
  $932B  2B                         STORE_quick   ; inline operand = 11
 >$932C  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $932F  8B 1A                      BYTE_LOADR_imm1        +26
  $9331  B5                         MULT
  $9332  8C 11 70                   LOADR_imm2             $7011
  $9335  BB                         ADD
  $9336  B0                         DEREF
  $9337  A8 87 6F                   STORE_abs              $6F87 (war_defender_men)
  $933A  50                         LOADR_qimm   ; inline operand = 0
  $933B  C3                         SCMPLE
  $933C  D8 51 93                   JUMPF_abs              $9351
  $933F  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9342  8B 1A                      BYTE_LOADR_imm1        +26
  $9344  B5                         MULT
  $9345  8C 11 70                   LOADR_imm2             $7011
  $9348  BB                         ADD
  $9349  B3                         PUSHL
  $934A  40                         LOADL_qimm   ; inline operand = 0
  $934B  B1                         POPSTORE
  $934C  A8 87 6F                   STORE_abs              $6F87 (war_defender_men)
  $934F  48                         LOADL_qimm   ; inline operand = 8
  $9350  2B                         STORE_quick   ; inline operand = 11
 >$9351  0B                         LOADL_quick   ; inline operand = 11
  $9352  D7 62 93                   JUMPT_abs              $9362
  $9355  AC D5 91                   CALL_abs               $91D5 (distribute_damage_across_unit_types) {bytecode}
  $9358  AC 9C 92                   CALL_abs               $929C (reset_unit_field_grid_to_200) {bytecode}
  $935B  41                         LOADL_qimm   ; inline operand = 1
  $935C  A8 E8 7B                   STORE_abs              $7BE8 (cur_combat_side)
  $935F  D6 68 93                   JUMP_abs               $9368
 >$9362  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9365  A8 57 6F                   STORE_abs              $6F57 (battle_winner_province_sel)
 >$9368  0B                         LOADL_quick   ; inline operand = 11
  $9369  CF                         RETURN

; ============================================================
; sub $936A   (frame_off=+0, body @ $936F)
; ============================================================
  $936F  8E 26 B6                   PUSH_imm2              $B626 (draw_combat_ui_string_data_b626)
  $9372  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9376  0D                         LOADL_quick   ; inline operand = 13
  $9377  D0                         INC
  $9378  2D                         STORE_quick   ; inline operand = 13
  $9379  B3                         PUSHL
  $937A  0C                         LOADL_quick   ; inline operand = 12
  $937B  D2                         LSHIFT1
  $937C  8C 96 B1                   LOADR_imm2             $B196 (jumptab_b196)
  $937F  BB                         ADD
  $9380  B0                         DEREF
  $9381  B3                         PUSHL
  $9382  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $9386  CF                         RETURN

; ============================================================
; sub $9387   (frame_off=+0, body @ $938C)
; ============================================================
  $938C  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $938F  E9 0A 90 02                CALL_abs_imm1          $900A (wrap_index_0_2_to_zero) {bytecode}, $02
  $9393  D0                         INC
  $9394  53                         LOADR_qimm   ; inline operand = 3
  $9395  BA                         UMOD
  $9396  D2                         LSHIFT1
  $9397  8C AF F9                   LOADR_imm2             $F9AF (draw_unit_label_data_f9af)
  $939A  BB                         ADD
  $939B  B0                         DEREF
  $939C  B3                         PUSHL
  $939D  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $93A0  D0                         INC
  $93A1  B3                         PUSHL
  $93A2  8E 27 B6                   PUSH_imm2              $B627 (msg_unit_d_s)
  $93A5  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $93A9  CF                         RETURN

; ============================================================
; sub $93AA   (frame_off=-12, body @ $93AF)
; ============================================================
  $93AF  0C                         LOADL_quick   ; inline operand = 12
  $93B0  A6 63 6F                   LOADR_abs              $6F63 (battle_defending_province)
  $93B3  C0                         CMPEQ
  $93B4  27                         STORE_quick   ; inline operand = 7
  $93B5  07                         LOADL_quick   ; inline operand = 7
  $93B6  51                         LOADR_qimm   ; inline operand = 1
  $93B7  DC                         XOR
  $93B8  B3                         PUSHL
  $93B9  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $93BD  29                         STORE_quick   ; inline operand = 9
  $93BE  3C                         PUSH_quick   ; inline operand = 12
  $93BF  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $93C3  2A                         STORE_quick   ; inline operand = 10
  $93C4  0C                         LOADL_quick   ; inline operand = 12
  $93C5  A6 57 6F                   LOADR_abs              $6F57 (battle_winner_province_sel)
  $93C8  C0                         CMPEQ
  $93C9  28                         STORE_quick   ; inline operand = 8
  $93CA  AC 20 CD                   CALL_abs               $CD20 (repaint_screen) {bytecode}
  $93CD  61                         PUSH_qimm   ; inline operand = 1
  $93CE  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $93D2  40                         LOADL_qimm   ; inline operand = 0
  $93D3  2B                         STORE_quick   ; inline operand = 11
 >$93D4  0B                         LOADL_quick   ; inline operand = 11
  $93D5  8C 58 B6                   LOADR_imm2             $B658 (msg_the_enemy_has_turned_tail_and)
  $93D8  BB                         ADD
  $93D9  D3                         BYTE_DEREF
  $93DA  B3                         PUSHL
  $93DB  3B                         PUSH_quick   ; inline operand = 11
  $93DC  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $93E0  0B                         LOADL_quick   ; inline operand = 11
  $93E1  D0                         INC
  $93E2  2B                         STORE_quick   ; inline operand = 11
  $93E3  0B                         LOADL_quick   ; inline operand = 11
  $93E4  8B 10                      BYTE_LOADR_imm1        +16
  $93E6  C6                         UCMPLT
  $93E7  D7 D4 93                   JUMPT_abs              $93D4
  $93EA  8E 9A 00                   PUSH_imm2              $009A
  $93ED  8E 10 15                   PUSH_imm2              $1510
  $93F0  8E BC 83                   PUSH_imm2              $83BC
  $93F3  64                         PUSH_qimm   ; inline operand = 4
  $93F4  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $93F8  60                         PUSH_qimm   ; inline operand = 0
  $93F9  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $93FD  63                         PUSH_qimm   ; inline operand = 3
  $93FE  62                         PUSH_qimm   ; inline operand = 2
  $93FF  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $9403  3C                         PUSH_quick   ; inline operand = 12
  $9404  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9408  D8 86 94                   JUMPF_abs              $9486
  $940B  08                         LOADL_quick   ; inline operand = 8
  $940C  D7 39 94                   JUMPT_abs              $9439
  $940F  0D                         LOADL_quick   ; inline operand = 13
  $9410  57                         LOADR_qimm   ; inline operand = 7
  $9411  C8                         UCMPGT
  $9412  D8 19 94                   JUMPF_abs              $9419
  $9415  47                         LOADL_qimm   ; inline operand = 7
  $9416  D6 2E 94                   JUMP_abs               $942E
 >$9419  07                         LOADL_quick   ; inline operand = 7
  $941A  D8 2F 94                   JUMPF_abs              $942F
  $941D  0D                         LOADL_quick   ; inline operand = 13
  $941E  51                         LOADR_qimm   ; inline operand = 1
  $941F  C0                         CMPEQ
  $9420  D8 2F 94                   JUMPF_abs              $942F
  $9423  60                         PUSH_qimm   ; inline operand = 0
  $9424  37                         PUSH_quick   ; inline operand = 7
  $9425  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $9429  D7 2F 94                   JUMPT_abs              $942F
  $942C  0D                         LOADL_quick   ; inline operand = 13
  $942D  D0                         INC
 >$942E  2D                         STORE_quick   ; inline operand = 13
 >$942F  0D                         LOADL_quick   ; inline operand = 13
  $9430  D1                         DEC
  $9431  2D                         STORE_quick   ; inline operand = 13
  $9432  D2                         LSHIFT1
  $9433  8C 32 B6                   LOADR_imm2             $B632 (jumptab_b632)
  $9436  D6 51 94                   JUMP_abs               $9451
 >$9439  0D                         LOADL_quick   ; inline operand = 13
  $943A  51                         LOADR_qimm   ; inline operand = 1
  $943B  C0                         CMPEQ
  $943C  D8 4A 94                   JUMPF_abs              $944A
  $943F  37                         PUSH_quick   ; inline operand = 7
  $9440  E9 6A 83 02                CALL_abs_imm1          $836A (unit_damage_within_strength) {bytecode}, $02
  $9444  D7 4A 94                   JUMPT_abs              $944A
  $9447  0D                         LOADL_quick   ; inline operand = 13
  $9448  D0                         INC
  $9449  2D                         STORE_quick   ; inline operand = 13
 >$944A  0D                         LOADL_quick   ; inline operand = 13
  $944B  D1                         DEC
  $944C  2D                         STORE_quick   ; inline operand = 13
  $944D  D2                         LSHIFT1
  $944E  8C 40 B6                   LOADR_imm2             $B640 (battle_conclusion_msgs_loser)
 >$9451  BB                         ADD
  $9452  B0                         DEREF
  $9453  26                         STORE_quick   ; inline operand = 6
  $9454  3C                         PUSH_quick   ; inline operand = 12
  $9455  E9 8B D7 02                CALL_abs_imm1          $D78B (daimyo_name_width) {bytecode}, $02
  $9459  8E 6C B9                   PUSH_imm2              $B96C (announce_battle_outcome_data_b96c)
  $945C  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9460  36                         PUSH_quick   ; inline operand = 6
  $9461  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9465  08                         LOADL_quick   ; inline operand = 8
  $9466  D8 6D 94                   JUMPF_abs              $946D
  $9469  44                         LOADL_qimm   ; inline operand = 4
  $946A  D6 6E 94                   JUMP_abs               $946E
 >$946D  43                         LOADL_qimm   ; inline operand = 3
 >$946E  B3                         PUSHL
  $946F  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $9473  A4 4D 6F                   LOADL_abs              $6F4D (audio_wait_gate)
  $9476  D8 F2 94                   JUMPF_abs              $94F2
 >$9479  62                         PUSH_qimm   ; inline operand = 2
  $947A  61                         PUSH_qimm   ; inline operand = 1
  $947B  6A                         PUSH_qimm   ; inline operand = 10
  $947C  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $9480  D8 F5 94                   JUMPF_abs              $94F5
  $9483  D6 79 94                   JUMP_abs               $9479
 >$9486  08                         LOADL_quick   ; inline operand = 8
  $9487  D7 F2 94                   JUMPT_abs              $94F2
  $948A  0D                         LOADL_quick   ; inline operand = 13
  $948B  52                         LOADR_qimm   ; inline operand = 2
  $948C  C7                         UCMPLE
  $948D  D8 B4 94                   JUMPF_abs              $94B4
  $9490  39                         PUSH_quick   ; inline operand = 9
  $9491  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $9495  59                         LOADR_qimm   ; inline operand = 9
  $9496  B5                         MULT
  $9497  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $949A  BB                         ADD
  $949B  B3                         PUSHL
  $949C  8E 6E B9                   PUSH_imm2              $B96E (msg_s_has_retreated)
  $949F  D6 AD 94                   JUMP_abs               $94AD
 >$94A2  0A                         LOADL_quick   ; inline operand = 10
  $94A3  59                         LOADR_qimm   ; inline operand = 9
  $94A4  B5                         MULT
  $94A5  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $94A8  BB                         ADD
  $94A9  B3                         PUSHL
  $94AA  8E 7F B9                   PUSH_imm2              $B97F (msg_s_hung_on_to_the_end_and_won)
 >$94AD  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $94B1  D6 F2 94                   JUMP_abs               $94F2
 >$94B4  0D                         LOADL_quick   ; inline operand = 13
  $94B5  53                         LOADR_qimm   ; inline operand = 3
  $94B6  C0                         CMPEQ
  $94B7  D7 A2 94                   JUMPT_abs              $94A2
  $94BA  39                         PUSH_quick   ; inline operand = 9
  $94BB  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $94BF  D7 F2 94                   JUMPT_abs              $94F2
  $94C2  0D                         LOADL_quick   ; inline operand = 13
  $94C3  57                         LOADR_qimm   ; inline operand = 7
  $94C4  C0                         CMPEQ
  $94C5  D8 CC 94                   JUMPF_abs              $94CC
  $94C8  44                         LOADL_qimm   ; inline operand = 4
  $94C9  D6 D4 94                   JUMP_abs               $94D4
 >$94CC  0D                         LOADL_quick   ; inline operand = 13
  $94CD  58                         LOADR_qimm   ; inline operand = 8
  $94CE  C0                         CMPEQ
  $94CF  D8 D5 94                   JUMPF_abs              $94D5
  $94D2  0D                         LOADL_quick   ; inline operand = 13
  $94D3  D1                         DEC
 >$94D4  2D                         STORE_quick   ; inline operand = 13
 >$94D5  44                         LOADL_qimm   ; inline operand = 4
  $94D6  CD                         SWAP
  $94D7  0D                         LOADL_quick   ; inline operand = 13
  $94D8  BC                         SUB
  $94D9  2D                         STORE_quick   ; inline operand = 13
  $94DA  53                         LOADR_qimm   ; inline operand = 3
  $94DB  C7                         UCMPLE
  $94DC  D8 F2 94                   JUMPF_abs              $94F2
  $94DF  AA 57 6F                   PUSH_abs               $6F57 (battle_winner_province_sel)
  $94E2  E9 4B DB 02                CALL_abs_imm1          $DB4B (draw_owner_name) {bytecode}, $02
  $94E6  0D                         LOADL_quick   ; inline operand = 13
  $94E7  D2                         LSHIFT1
  $94E8  8C 50 B6                   LOADR_imm2             $B650 (battle_conclusion_msgs_observer)
  $94EB  BB                         ADD
  $94EC  B0                         DEREF
  $94ED  B3                         PUSHL
  $94EE  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$94F2  AC 59 D7                   CALL_abs               $D759 (standard_delay) {bytecode}
 >$94F5  CF                         RETURN

; ============================================================
; sub $94F6   (frame_off=-4, body @ $94FB)
; ============================================================
  $94FB  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $94FE  51                         LOADR_qimm   ; inline operand = 1
  $94FF  DC                         XOR
  $9500  2A                         STORE_quick   ; inline operand = 10
  $9501  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9504  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $9508  2B                         STORE_quick   ; inline operand = 11
  $9509  B3                         PUSHL
  $950A  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $950E  D8 69 95                   JUMPF_abs              $9569
  $9511  0C                         LOADL_quick   ; inline operand = 12
  $9512  D7 1F 95                   JUMPT_abs              $951F
  $9515  AA C6 B1                   PUSH_abs               $B1C6
  $9518  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $951C  D6 3F 95                   JUMP_abs               $953F
 >$951F  8E 9D B9                   PUSH_imm2              $B99D (announce_combat_side_dai_data_b99d)
  $9522  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9526  3B                         PUSH_quick   ; inline operand = 11
  $9527  E9 AF D7 02                CALL_abs_imm1          $D7AF (draw_daimyo_name) {bytecode}, $02
  $952B  6A                         PUSH_qimm   ; inline operand = 10
  $952C  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $9530  0C                         LOADL_quick   ; inline operand = 12
  $9531  D1                         DEC
  $9532  D2                         LSHIFT1
  $9533  74                         ADD_qimm   ; inline operand = 4
  $9534  D2                         LSHIFT1
  $9535  8C 96 B1                   LOADR_imm2             $B196 (jumptab_b196)
  $9538  BB                         ADD
  $9539  B0                         DEREF
  $953A  B3                         PUSHL
  $953B  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$953F  41                         LOADL_qimm   ; inline operand = 1
  $9540  CD                         SWAP
  $9541  0A                         LOADL_quick   ; inline operand = 10
  $9542  DC                         XOR
  $9543  2A                         STORE_quick   ; inline operand = 10
 >$9544  AC 1A D3                   CALL_abs               $D31A (clear_rect_left_lower_alt) {bytecode}
  $9547  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $954A  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $954D  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $9551  D7 A3 95                   JUMPT_abs              $95A3
  $9554  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $9557  0A                         LOADL_quick   ; inline operand = 10
  $9558  A6 E8 7B                   LOADR_abs              $7BE8 (cur_combat_side)
  $955B  C0                         CMPEQ
  $955C  D8 BA 95                   JUMPF_abs              $95BA
 >$955F  47                         LOADL_qimm   ; inline operand = 7
 >$9560  B3                         PUSHL
  $9561  E9 6A 93 04                CALL_abs_imm1          $936A (draw_combat_ui_string_b196) {bytecode}, $04
  $9565  AC 1A D3                   CALL_abs               $D31A (clear_rect_left_lower_alt) {bytecode}
 >$9568  CF                         RETURN
 >$9569  3A                         PUSH_quick   ; inline operand = 10
  $956A  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $956E  2B                         STORE_quick   ; inline operand = 11
  $956F  B3                         PUSHL
  $9570  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9574  D8 A2 95                   JUMPF_abs              $95A2
  $9577  8E 9E B9                   PUSH_imm2              $B99E (announce_combat_side_dai_data_b99e)
  $957A  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $957E  3B                         PUSH_quick   ; inline operand = 11
  $957F  E9 AF D7 02                CALL_abs_imm1          $D7AF (draw_daimyo_name) {bytecode}, $02
  $9583  6A                         PUSH_qimm   ; inline operand = 10
  $9584  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $9588  AA A6 B1                   PUSH_abs               $B1A6
  $958B  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $958F  0C                         LOADL_quick   ; inline operand = 12
  $9590  52                         LOADR_qimm   ; inline operand = 2
  $9591  C0                         CMPEQ
  $9592  D8 44 95                   JUMPF_abs              $9544
  $9595  AC 1A D3                   CALL_abs               $D31A (clear_rect_left_lower_alt) {bytecode}
  $9598  AA D6 B1                   PUSH_abs               $B1D6
  $959B  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $959F  D6 44 95                   JUMP_abs               $9544
 >$95A2  CF                         RETURN
 >$95A3  3D                         PUSH_quick   ; inline operand = 13
  $95A4  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $95A7  51                         LOADR_qimm   ; inline operand = 1
  $95A8  DC                         XOR
  $95A9  B3                         PUSHL
  $95AA  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $95AE  D7 68 95                   JUMPT_abs              $9568
  $95B1  3D                         PUSH_quick   ; inline operand = 13
  $95B2  0A                         LOADL_quick   ; inline operand = 10
  $95B3  A6 E8 7B                   LOADR_abs              $7BE8 (cur_combat_side)
  $95B6  C0                         CMPEQ
  $95B7  D8 5F 95                   JUMPF_abs              $955F
 >$95BA  45                         LOADL_qimm   ; inline operand = 5
  $95BB  D6 60 95                   JUMP_abs               $9560

; ============================================================
; sub $95BE   (frame_off=+0, body @ $95C3)
; ============================================================
  $95C3  60                         PUSH_qimm   ; inline operand = 0
  $95C4  E9 0B 84 02                CALL_abs_imm1          $840B (draw_tactical_cursor_region) {bytecode}, $02
  $95C8  A4 FE 6F                   LOADL_abs              $6FFE (tactical_battle_phase)
  $95CB  D9 03 00 00 00 DC 95 01 00 FB 95 02 ... SWITCH_noncontig       count=3   ; .table 3 (key,target) + default (noncontiguous); SWITCH 0=>$95DC 1=>$95FB 2=>$9605 default=>$95E6
 >$95DC  0C                         LOADL_quick   ; inline operand = 12
  $95DD  58                         LOADR_qimm   ; inline operand = 8
  $95DE  C9                         UCMPGE
  $95DF  D8 F7 95                   JUMPF_abs              $95F7
 >$95E2  42                         LOADL_qimm   ; inline operand = 2
 >$95E3  A8 FE 6F                   STORE_abs              $6FFE (tactical_battle_phase)
 >$95E6  61                         PUSH_qimm   ; inline operand = 1
  $95E7  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $95EB  AC 5E 88                   CALL_abs               $885E (map_render_driver) {bytecode}
  $95EE  60                         PUSH_qimm   ; inline operand = 0
  $95EF  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $95F3  AC 58 8B                   CALL_abs               $8B58 (draw_valid_unit_field_cells) {bytecode}
  $95F6  CF                         RETURN
 >$95F7  41                         LOADL_qimm   ; inline operand = 1
  $95F8  D6 E3 95                   JUMP_abs               $95E3
 >$95FB  0C                         LOADL_quick   ; inline operand = 12
  $95FC  55                         LOADR_qimm   ; inline operand = 5
  $95FD  C8                         UCMPGT
  $95FE  D7 E2 95                   JUMPT_abs              $95E2
 >$9601  40                         LOADL_qimm   ; inline operand = 0
  $9602  D6 E3 95                   JUMP_abs               $95E3
 >$9605  0C                         LOADL_quick   ; inline operand = 12
  $9606  52                         LOADR_qimm   ; inline operand = 2
  $9607  C7                         UCMPLE
  $9608  D8 F7 95                   JUMPF_abs              $95F7
  $960B  D6 01 96                   JUMP_abs               $9601

; ============================================================
; sub $960E   (frame_off=+0, body @ $9613)
; ============================================================
  $9613  0C                         LOADL_quick   ; inline operand = 12
  $9614  55                         LOADR_qimm   ; inline operand = 5
  $9615  C6                         UCMPLT
  $9616  D8 1F 96                   JUMPF_abs              $961F
  $9619  A4 FE 6F                   LOADL_abs              $6FFE (tactical_battle_phase)
  $961C  D8 45 96                   JUMPF_abs              $9645
 >$961F  0C                         LOADL_quick   ; inline operand = 12
  $9620  52                         LOADR_qimm   ; inline operand = 2
  $9621  C8                         UCMPGT
  $9622  D8 33 96                   JUMPF_abs              $9633
  $9625  0C                         LOADL_quick   ; inline operand = 12
  $9626  58                         LOADR_qimm   ; inline operand = 8
  $9627  C6                         UCMPLT
  $9628  D8 33 96                   JUMPF_abs              $9633
  $962B  A4 FE 6F                   LOADL_abs              $6FFE (tactical_battle_phase)
  $962E  51                         LOADR_qimm   ; inline operand = 1
  $962F  C0                         CMPEQ
  $9630  D7 45 96                   JUMPT_abs              $9645
 >$9633  0C                         LOADL_quick   ; inline operand = 12
  $9634  55                         LOADR_qimm   ; inline operand = 5
  $9635  C8                         UCMPGT
  $9636  D8 41 96                   JUMPF_abs              $9641
  $9639  A4 FE 6F                   LOADL_abs              $6FFE (tactical_battle_phase)
  $963C  52                         LOADR_qimm   ; inline operand = 2
  $963D  C0                         CMPEQ
  $963E  D7 45 96                   JUMPT_abs              $9645
 >$9641  40                         LOADL_qimm   ; inline operand = 0
  $9642  D6 46 96                   JUMP_abs               $9646
 >$9645  41                         LOADL_qimm   ; inline operand = 1
 >$9646  CF                         RETURN

; ============================================================
; sub $9647   (frame_off=-4, body @ $964C)
; ============================================================
  $964C  40                         LOADL_qimm   ; inline operand = 0
  $964D  2B                         STORE_quick   ; inline operand = 11
 >$964E  40                         LOADL_qimm   ; inline operand = 0
  $964F  2A                         STORE_quick   ; inline operand = 10
 >$9650  8D 20                      BYTE_PUSH_imm1         +32
  $9652  3A                         PUSH_quick   ; inline operand = 10
  $9653  3B                         PUSH_quick   ; inline operand = 11
  $9654  E9 DB 82 06                CALL_abs_imm1          $82DB (test_map_cell_bits) {bytecode}, $06
  $9658  D7 62 96                   JUMPT_abs              $9662
  $965B  3C                         PUSH_quick   ; inline operand = 12
  $965C  0B                         LOADL_quick   ; inline operand = 11
  $965D  B1                         POPSTORE
  $965E  3D                         PUSH_quick   ; inline operand = 13
  $965F  0A                         LOADL_quick   ; inline operand = 10
  $9660  B1                         POPSTORE
  $9661  CF                         RETURN
 >$9662  0A                         LOADL_quick   ; inline operand = 10
  $9663  D0                         INC
  $9664  2A                         STORE_quick   ; inline operand = 10
  $9665  0A                         LOADL_quick   ; inline operand = 10
  $9666  55                         LOADR_qimm   ; inline operand = 5
  $9667  C6                         UCMPLT
  $9668  D7 50 96                   JUMPT_abs              $9650
  $966B  0B                         LOADL_quick   ; inline operand = 11
  $966C  D0                         INC
  $966D  2B                         STORE_quick   ; inline operand = 11
  $966E  0B                         LOADL_quick   ; inline operand = 11
  $966F  5B                         LOADR_qimm   ; inline operand = 11
  $9670  C6                         UCMPLT
  $9671  D7 4E 96                   JUMPT_abs              $964E
  $9674  CF                         RETURN

; ============================================================
; sub $9675   (frame_off=-10, body @ $967A)
; ============================================================
  $967A  40                         LOADL_qimm   ; inline operand = 0
  $967B  A8 F8 6F                   STORE_abs              $6FF8 (combat_arena_y_min)
  $967E  A8 F6 6F                   STORE_abs              $6FF6 (combat_arena_x_min)
  $9681  27                         STORE_quick   ; inline operand = 7
  $9682  4A                         LOADL_qimm   ; inline operand = 10
  $9683  A8 FA 6F                   STORE_abs              $6FFA (combat_arena_x_max)
  $9686  44                         LOADL_qimm   ; inline operand = 4
  $9687  A8 FC 6F                   STORE_abs              $6FFC (combat_arena_y_max)
  $968A  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $968D  D7 08 97                   JUMPT_abs              $9708
  $9690  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $9693  D7 08 97                   JUMPT_abs              $9708
  $9696  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $9699  E9 66 DC 02                CALL_abs_imm1          $DC66 (fief_to_mapid) {bytecode}, $02
  $969D  8C BA B0                   LOADR_imm2             $B0BA (strategic_map_fief_x)
  $96A0  BB                         ADD
  $96A1  D3                         BYTE_DEREF
  $96A2  2B                         STORE_quick   ; inline operand = 11
  $96A3  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $96A6  E9 66 DC 02                CALL_abs_imm1          $DC66 (fief_to_mapid) {bytecode}, $02
  $96AA  8C BA B0                   LOADR_imm2             $B0BA (strategic_map_fief_x)
  $96AD  BB                         ADD
  $96AE  D3                         BYTE_DEREF
  $96AF  2A                         STORE_quick   ; inline operand = 10
  $96B0  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $96B3  E9 66 DC 02                CALL_abs_imm1          $DC66 (fief_to_mapid) {bytecode}, $02
  $96B7  8C EC B0                   LOADR_imm2             $B0EC (strategic_map_fief_y)
  $96BA  BB                         ADD
  $96BB  D3                         BYTE_DEREF
  $96BC  29                         STORE_quick   ; inline operand = 9
  $96BD  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $96C0  E9 66 DC 02                CALL_abs_imm1          $DC66 (fief_to_mapid) {bytecode}, $02
  $96C4  8C EC B0                   LOADR_imm2             $B0EC (strategic_map_fief_y)
  $96C7  BB                         ADD
  $96C8  D3                         BYTE_DEREF
  $96C9  28                         STORE_quick   ; inline operand = 8
  $96CA  09                         LOADL_quick   ; inline operand = 9
  $96CB  18                         LOADR_quick   ; inline operand = 8
  $96CC  BC                         SUB
  $96CD  B3                         PUSHL
  $96CE  E9 4C CB 02                CALL_abs_imm1          $CB4C (abs16) {bytecode}, $02
  $96D2  B3                         PUSHL
  $96D3  0B                         LOADL_quick   ; inline operand = 11
  $96D4  1A                         LOADR_quick   ; inline operand = 10
  $96D5  BC                         SUB
  $96D6  B3                         PUSHL
  $96D7  E9 4C CB 02                CALL_abs_imm1          $CB4C (abs16) {bytecode}, $02
  $96DB  B4                         POPR
  $96DC  C2                         SCMPLT
  $96DD  D8 F5 96                   JUMPF_abs              $96F5
  $96E0  09                         LOADL_quick   ; inline operand = 9
  $96E1  18                         LOADR_quick   ; inline operand = 8
  $96E2  C6                         UCMPLT
  $96E3  D8 EE 96                   JUMPF_abs              $96EE
  $96E6  42                         LOADL_qimm   ; inline operand = 2
  $96E7  A8 FC 6F                   STORE_abs              $6FFC (combat_arena_y_max)
  $96EA  41                         LOADL_qimm   ; inline operand = 1
  $96EB  D6 07 97                   JUMP_abs               $9707
 >$96EE  42                         LOADL_qimm   ; inline operand = 2
  $96EF  A8 F8 6F                   STORE_abs              $6FF8 (combat_arena_y_min)
  $96F2  D6 07 97                   JUMP_abs               $9707
 >$96F5  0B                         LOADL_quick   ; inline operand = 11
  $96F6  1A                         LOADR_quick   ; inline operand = 10
  $96F7  C8                         UCMPGT
  $96F8  D8 03 97                   JUMPF_abs              $9703
  $96FB  47                         LOADL_qimm   ; inline operand = 7
  $96FC  A8 F6 6F                   STORE_abs              $6FF6 (combat_arena_x_min)
  $96FF  44                         LOADL_qimm   ; inline operand = 4
  $9700  D6 07 97                   JUMP_abs               $9707
 >$9703  43                         LOADL_qimm   ; inline operand = 3
  $9704  A8 FA 6F                   STORE_abs              $6FFA (combat_arena_x_max)
 >$9707  27                         STORE_quick   ; inline operand = 7
 >$9708  07                         LOADL_quick   ; inline operand = 7
  $9709  CF                         RETURN

; ============================================================
; sub $970A   (frame_off=+0, body @ $970F)
; ============================================================
  $970F  0C                         LOADL_quick   ; inline operand = 12
  $9710  A6 F6 6F                   LOADR_abs              $6FF6 (combat_arena_x_min)
  $9713  C6                         UCMPLT
  $9714  D7 2F 97                   JUMPT_abs              $972F
  $9717  0C                         LOADL_quick   ; inline operand = 12
  $9718  A6 FA 6F                   LOADR_abs              $6FFA (combat_arena_x_max)
  $971B  C8                         UCMPGT
  $971C  D7 2F 97                   JUMPT_abs              $972F
  $971F  0D                         LOADL_quick   ; inline operand = 13
  $9720  A6 F8 6F                   LOADR_abs              $6FF8 (combat_arena_y_min)
  $9723  C6                         UCMPLT
  $9724  D7 2F 97                   JUMPT_abs              $972F
  $9727  0D                         LOADL_quick   ; inline operand = 13
  $9728  A6 FC 6F                   LOADR_abs              $6FFC (combat_arena_y_max)
  $972B  C8                         UCMPGT
  $972C  D8 33 97                   JUMPF_abs              $9733
 >$972F  40                         LOADL_qimm   ; inline operand = 0
  $9730  D6 34 97                   JUMP_abs               $9734
 >$9733  41                         LOADL_qimm   ; inline operand = 1
 >$9734  CF                         RETURN

; ============================================================
; sub $9735   (frame_off=-10, body @ $973A)
; ============================================================
  $973A  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $973D  D7 90 97                   JUMPT_abs              $9790
  $9740  8D 20                      BYTE_PUSH_imm1         +32
  $9742  3D                         PUSH_quick   ; inline operand = 13
  $9743  3C                         PUSH_quick   ; inline operand = 12
  $9744  E9 DB 82 06                CALL_abs_imm1          $82DB (test_map_cell_bits) {bytecode}, $06
  $9748  D8 55 97                   JUMPF_abs              $9755
  $974B  68                         PUSH_qimm   ; inline operand = 8
  $974C  3D                         PUSH_quick   ; inline operand = 13
  $974D  3C                         PUSH_quick   ; inline operand = 12
  $974E  E9 DB 82 06                CALL_abs_imm1          $82DB (test_map_cell_bits) {bytecode}, $06
  $9752  D7 57 97                   JUMPT_abs              $9757
 >$9755  41                         LOADL_qimm   ; inline operand = 1
  $9756  CF                         RETURN
 >$9757  DE FC FF                   LEAL_far               $FFFC
  $975A  B3                         PUSHL
  $975B  DE FE FF                   LEAL_far               $FFFE
  $975E  B3                         PUSHL
  $975F  E9 47 96 04                CALL_abs_imm1          $9647 (find_free_tactical_placement_cell) {bytecode}, $04
  $9763  40                         LOADL_qimm   ; inline operand = 0
  $9764  27                         STORE_quick   ; inline operand = 7
 >$9765  0B                         LOADL_quick   ; inline operand = 11
  $9766  29                         STORE_quick   ; inline operand = 9
  $9767  0A                         LOADL_quick   ; inline operand = 10
  $9768  28                         STORE_quick   ; inline operand = 8
  $9769  37                         PUSH_quick   ; inline operand = 7
  $976A  DE F8 FF                   LEAL_far               $FFF8
  $976D  B3                         PUSHL
  $976E  DE FA FF                   LEAL_far               $FFFA
  $9771  B3                         PUSHL
  $9772  E9 03 80 06                CALL_abs_imm1          $8003 {native}, $06
  $9776  D8 87 97                   JUMPF_abs              $9787
  $9779  09                         LOADL_quick   ; inline operand = 9
  $977A  1C                         LOADR_quick   ; inline operand = 12
  $977B  C0                         CMPEQ
  $977C  D8 87 97                   JUMPF_abs              $9787
  $977F  08                         LOADL_quick   ; inline operand = 8
  $9780  1D                         LOADR_quick   ; inline operand = 13
  $9781  C0                         CMPEQ
  $9782  D8 87 97                   JUMPF_abs              $9787
  $9785  41                         LOADL_qimm   ; inline operand = 1
  $9786  CF                         RETURN
 >$9787  07                         LOADL_quick   ; inline operand = 7
  $9788  D0                         INC
  $9789  27                         STORE_quick   ; inline operand = 7
  $978A  07                         LOADL_quick   ; inline operand = 7
  $978B  56                         LOADR_qimm   ; inline operand = 6
  $978C  C6                         UCMPLT
  $978D  D7 65 97                   JUMPT_abs              $9765
 >$9790  40                         LOADL_qimm   ; inline operand = 0
  $9791  CF                         RETURN

; ============================================================
; sub $9792   (frame_off=+0, body @ $9797)
; ============================================================
  $9797  3D                         PUSH_quick   ; inline operand = 13
  $9798  3C                         PUSH_quick   ; inline operand = 12
  $9799  E9 EC 8F 04                CALL_abs_imm1          $8FEC (find_unit_at_tile) {bytecode}, $04
  $979D  D7 D7 97                   JUMPT_abs              $97D7
  $97A0  3D                         PUSH_quick   ; inline operand = 13
  $97A1  3C                         PUSH_quick   ; inline operand = 12
  $97A2  E9 19 90 04                CALL_abs_imm1          $9019 (test_map_cell_blocked_c2) {bytecode}, $04
  $97A6  D7 D7 97                   JUMPT_abs              $97D7
  $97A9  3D                         PUSH_quick   ; inline operand = 13
  $97AA  3C                         PUSH_quick   ; inline operand = 12
  $97AB  E9 35 97 04                CALL_abs_imm1          $9735 (tile_blocked_by_existing_unit_in_placement) {bytecode}, $04
  $97AF  D7 D7 97                   JUMPT_abs              $97D7
  $97B2  3D                         PUSH_quick   ; inline operand = 13
  $97B3  3C                         PUSH_quick   ; inline operand = 12
  $97B4  E9 0A 97 04                CALL_abs_imm1          $970A (is_coord_in_combat_rect) {bytecode}, $04
  $97B8  D8 D7 97                   JUMPF_abs              $97D7
  $97BB  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $97BE  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $97C1  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $97C5  B3                         PUSHL
  $97C6  0C                         LOADL_quick   ; inline operand = 12
  $97C7  D4                         BYTE_POPSTORE
  $97C8  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $97CB  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $97CE  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $97D2  B3                         PUSHL
  $97D3  0D                         LOADL_quick   ; inline operand = 13
  $97D4  D4                         BYTE_POPSTORE
  $97D5  41                         LOADL_qimm   ; inline operand = 1
  $97D6  CF                         RETURN
 >$97D7  40                         LOADL_qimm   ; inline operand = 0
  $97D8  CF                         RETURN

; ============================================================
; sub $97D9   (frame_off=+0, body @ $97DE)
; ============================================================
  $97DE  3D                         PUSH_quick   ; inline operand = 13
  $97DF  3C                         PUSH_quick   ; inline operand = 12
  $97E0  E9 92 97 04                CALL_abs_imm1          $9792 (commit_unit_dest_tile_if_valid) {bytecode}, $04
  $97E4  D8 F7 97                   JUMPF_abs              $97F7
  $97E7  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $97EA  D0                         INC
  $97EB  A8 E4 7B                   STORE_abs              $7BE4 (cur_combat_unit_slot)
  $97EE  D1                         DEC
  $97EF  B3                         PUSHL
  $97F0  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $97F3  E9 DF 89 04                CALL_abs_imm1          $89DF (draw_unit_count_digits) {bytecode}, $04
 >$97F7  CF                         RETURN

; ============================================================
; sub $97F8   (frame_off=+0, body @ $97FD)
; ============================================================
  $97FD  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $9800  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9803  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $9807  D8 0E 98                   JUMPF_abs              $980E
  $980A  40                         LOADL_qimm   ; inline operand = 0
  $980B  D6 0F 98                   JUMP_abs               $980F
 >$980E  41                         LOADL_qimm   ; inline operand = 1
 >$980F  CF                         RETURN

; ============================================================
; sub $9810   (frame_off=-6, body @ $9815)
; ============================================================
  $9815  40                         LOADL_qimm   ; inline operand = 0
  $9816  D6 55 98                   JUMP_abs               $9855
 >$9819  AC F8 97                   CALL_abs               $97F8 (test_cur_unit_slot_present) {bytecode}
  $981C  D8 29 98                   JUMPF_abs              $9829
  $981F  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $9822  D0                         INC
  $9823  A8 E4 7B                   STORE_abs              $7BE4 (cur_combat_unit_slot)
  $9826  D6 53 98                   JUMP_abs               $9853
 >$9829  60                         PUSH_qimm   ; inline operand = 0
  $982A  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $982D  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $9831  D3                         BYTE_DEREF
  $9832  2B                         STORE_quick   ; inline operand = 11
  $9833  60                         PUSH_qimm   ; inline operand = 0
  $9834  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9837  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $983B  D3                         BYTE_DEREF
  $983C  2A                         STORE_quick   ; inline operand = 10
  $983D  39                         PUSH_quick   ; inline operand = 9
  $983E  DE FC FF                   LEAL_far               $FFFC
  $9841  B3                         PUSHL
  $9842  DE FE FF                   LEAL_far               $FFFE
  $9845  B3                         PUSHL
  $9846  E9 03 80 06                CALL_abs_imm1          $8003 {native}, $06
  $984A  D8 53 98                   JUMPF_abs              $9853
  $984D  3A                         PUSH_quick   ; inline operand = 10
  $984E  3B                         PUSH_quick   ; inline operand = 11
  $984F  E9 D9 97 04                CALL_abs_imm1          $97D9 (commit_unit_move_and_redraw_count) {bytecode}, $04
 >$9853  09                         LOADL_quick   ; inline operand = 9
  $9854  D0                         INC
 >$9855  29                         STORE_quick   ; inline operand = 9
  $9856  09                         LOADL_quick   ; inline operand = 9
  $9857  56                         LOADR_qimm   ; inline operand = 6
  $9858  C6                         UCMPLT
  $9859  D8 64 98                   JUMPF_abs              $9864
  $985C  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $985F  1C                         LOADR_quick   ; inline operand = 12
  $9860  C6                         UCMPLT
  $9861  D7 19 98                   JUMPT_abs              $9819
 >$9864  CF                         RETURN

; ============================================================
; sub $9865   (frame_off=-12, body @ $986A)
; ============================================================
  $986A  DE FC FF                   LEAL_far               $FFFC
  $986D  B3                         PUSHL
  $986E  DE FE FF                   LEAL_far               $FFFE
  $9871  B3                         PUSHL
  $9872  E9 47 96 04                CALL_abs_imm1          $9647 (find_free_tactical_placement_cell) {bytecode}, $04
  $9876  3A                         PUSH_quick   ; inline operand = 10
  $9877  3B                         PUSH_quick   ; inline operand = 11
  $9878  E9 D9 97 04                CALL_abs_imm1          $97D9 (commit_unit_move_and_redraw_count) {bytecode}, $04
  $987C  AC F5 8E                   CALL_abs               $8EF5 (ai_attacker_outstrengths_defender) {bytecode}
  $987F  D8 FD 98                   JUMPF_abs              $98FD
  $9882  65                         PUSH_qimm   ; inline operand = 5
  $9883  E9 10 98 02                CALL_abs_imm1          $9810 (ai_place_unit_in_free_slot_resolve_coords) {bytecode}, $02
  $9887  41                         LOADL_qimm   ; inline operand = 1
  $9888  D6 EC 98                   JUMP_abs               $98EC
 >$988B  AC F8 97                   CALL_abs               $97F8 (test_cur_unit_slot_present) {bytecode}
  $988E  D8 9B 98                   JUMPF_abs              $989B
  $9891  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $9894  D0                         INC
  $9895  A8 E4 7B                   STORE_abs              $7BE4 (cur_combat_unit_slot)
  $9898  D6 EA 98                   JUMP_abs               $98EA
 >$989B  37                         PUSH_quick   ; inline operand = 7
  $989C  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $989F  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $98A3  D3                         BYTE_DEREF
  $98A4  2B                         STORE_quick   ; inline operand = 11
  $98A5  37                         PUSH_quick   ; inline operand = 7
  $98A6  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $98A9  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $98AD  D3                         BYTE_DEREF
  $98AE  2A                         STORE_quick   ; inline operand = 10
  $98AF  40                         LOADL_qimm   ; inline operand = 0
  $98B0  26                         STORE_quick   ; inline operand = 6
 >$98B1  0B                         LOADL_quick   ; inline operand = 11
  $98B2  29                         STORE_quick   ; inline operand = 9
  $98B3  0A                         LOADL_quick   ; inline operand = 10
  $98B4  28                         STORE_quick   ; inline operand = 8
  $98B5  36                         PUSH_quick   ; inline operand = 6
  $98B6  DE F8 FF                   LEAL_far               $FFF8
  $98B9  B3                         PUSHL
  $98BA  DE FA FF                   LEAL_far               $FFFA
  $98BD  B3                         PUSHL
  $98BE  E9 03 80 06                CALL_abs_imm1          $8003 {native}, $06
  $98C2  D8 E1 98                   JUMPF_abs              $98E1
  $98C5  38                         PUSH_quick   ; inline operand = 8
  $98C6  39                         PUSH_quick   ; inline operand = 9
  $98C7  E9 92 97 04                CALL_abs_imm1          $9792 (commit_unit_dest_tile_if_valid) {bytecode}, $04
  $98CB  D8 E1 98                   JUMPF_abs              $98E1
  $98CE  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $98D1  D0                         INC
  $98D2  A8 E4 7B                   STORE_abs              $7BE4 (cur_combat_unit_slot)
  $98D5  D1                         DEC
  $98D6  B3                         PUSHL
  $98D7  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $98DA  E9 DF 89 04                CALL_abs_imm1          $89DF (draw_unit_count_digits) {bytecode}, $04
  $98DE  D6 EA 98                   JUMP_abs               $98EA
 >$98E1  06                         LOADL_quick   ; inline operand = 6
  $98E2  D0                         INC
  $98E3  26                         STORE_quick   ; inline operand = 6
  $98E4  06                         LOADL_quick   ; inline operand = 6
  $98E5  56                         LOADR_qimm   ; inline operand = 6
  $98E6  C6                         UCMPLT
  $98E7  D7 B1 98                   JUMPT_abs              $98B1
 >$98EA  07                         LOADL_quick   ; inline operand = 7
  $98EB  D0                         INC
 >$98EC  27                         STORE_quick   ; inline operand = 7
  $98ED  07                         LOADL_quick   ; inline operand = 7
  $98EE  A6 E4 7B                   LOADR_abs              $7BE4 (cur_combat_unit_slot)
  $98F1  C6                         UCMPLT
  $98F2  D8 FD 98                   JUMPF_abs              $98FD
  $98F5  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $98F8  55                         LOADR_qimm   ; inline operand = 5
  $98F9  C6                         UCMPLT
  $98FA  D7 8B 98                   JUMPT_abs              $988B
 >$98FD  CF                         RETURN

; ============================================================
; sub $98FE   (frame_off=-6, body @ $9903)
; ============================================================
  $9903  40                         LOADL_qimm   ; inline operand = 0
  $9904  2B                         STORE_quick   ; inline operand = 11
 >$9905  0C                         LOADL_quick   ; inline operand = 12
  $9906  2A                         STORE_quick   ; inline operand = 10
  $9907  0D                         LOADL_quick   ; inline operand = 13
  $9908  29                         STORE_quick   ; inline operand = 9
  $9909  3B                         PUSH_quick   ; inline operand = 11
  $990A  DE FA FF                   LEAL_far               $FFFA
  $990D  B3                         PUSHL
  $990E  DE FC FF                   LEAL_far               $FFFC
  $9911  B3                         PUSHL
  $9912  E9 03 80 06                CALL_abs_imm1          $8003 {native}, $06
  $9916  D8 28 99                   JUMPF_abs              $9928
  $9919  39                         PUSH_quick   ; inline operand = 9
  $991A  3A                         PUSH_quick   ; inline operand = 10
  $991B  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $991E  51                         LOADR_qimm   ; inline operand = 1
  $991F  DC                         XOR
  $9920  B3                         PUSHL
  $9921  E9 C0 8F 06                CALL_abs_imm1          $8FC0 (find_unit_slot_by_fields) {bytecode}, $06
  $9925  D7 31 99                   JUMPT_abs              $9931
 >$9928  0B                         LOADL_quick   ; inline operand = 11
  $9929  D0                         INC
  $992A  2B                         STORE_quick   ; inline operand = 11
  $992B  0B                         LOADL_quick   ; inline operand = 11
  $992C  56                         LOADR_qimm   ; inline operand = 6
  $992D  C6                         UCMPLT
  $992E  D7 05 99                   JUMPT_abs              $9905
 >$9931  0B                         LOADL_quick   ; inline operand = 11
  $9932  56                         LOADR_qimm   ; inline operand = 6
  $9933  C9                         UCMPGE
  $9934  D8 52 99                   JUMPF_abs              $9952
  $9937  3D                         PUSH_quick   ; inline operand = 13
  $9938  3C                         PUSH_quick   ; inline operand = 12
  $9939  E9 92 97 04                CALL_abs_imm1          $9792 (commit_unit_dest_tile_if_valid) {bytecode}, $04
  $993D  D8 52 99                   JUMPF_abs              $9952
  $9940  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $9943  D0                         INC
  $9944  A8 E4 7B                   STORE_abs              $7BE4 (cur_combat_unit_slot)
  $9947  D1                         DEC
  $9948  B3                         PUSHL
  $9949  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $994C  E9 DF 89 04                CALL_abs_imm1          $89DF (draw_unit_count_digits) {bytecode}, $04
  $9950  41                         LOADL_qimm   ; inline operand = 1
  $9951  CF                         RETURN
 >$9952  40                         LOADL_qimm   ; inline operand = 0
  $9953  CF                         RETURN

; ============================================================
; sub $9954   (frame_off=-12, body @ $9959)
; ============================================================
  $9959  62                         PUSH_qimm   ; inline operand = 2
  $995A  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $995E  27                         STORE_quick   ; inline operand = 7
  $995F  62                         PUSH_qimm   ; inline operand = 2
  $9960  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9964  26                         STORE_quick   ; inline operand = 6
  $9965  0C                         LOADL_quick   ; inline operand = 12
  $9966  D5 FF FF 04 00 77 99 75 99 7D 99 81 ... SWITCH_contig          limit=4   ; .table 4 word targets (contiguous); SWITCH 65535=>$9975 65536=>$997D 65537=>$9981 65538=>$9986 default=>$9977
 >$9975  41                         LOADL_qimm   ; inline operand = 1
 >$9976  26                         STORE_quick   ; inline operand = 6
 >$9977  A4 F6 6F                   LOADL_abs              $6FF6 (combat_arena_x_min)
  $997A  D6 C8 99                   JUMP_abs               $99C8
 >$997D  40                         LOADL_qimm   ; inline operand = 0
  $997E  D6 76 99                   JUMP_abs               $9976
 >$9981  41                         LOADL_qimm   ; inline operand = 1
 >$9982  27                         STORE_quick   ; inline operand = 7
  $9983  D6 77 99                   JUMP_abs               $9977
 >$9986  40                         LOADL_qimm   ; inline operand = 0
  $9987  D6 82 99                   JUMP_abs               $9982
 >$998A  A4 F8 6F                   LOADL_abs              $6FF8 (combat_arena_y_min)
  $998D  D6 BD 99                   JUMP_abs               $99BD
 >$9990  07                         LOADL_quick   ; inline operand = 7
  $9991  D8 98 99                   JUMPF_abs              $9998
  $9994  0B                         LOADL_quick   ; inline operand = 11
  $9995  D6 9D 99                   JUMP_abs               $999D
 >$9998  A4 FA 6F                   LOADL_abs              $6FFA (combat_arena_x_max)
  $999B  1B                         LOADR_quick   ; inline operand = 11
  $999C  BC                         SUB
 >$999D  29                         STORE_quick   ; inline operand = 9
  $999E  06                         LOADL_quick   ; inline operand = 6
  $999F  D8 A6 99                   JUMPF_abs              $99A6
  $99A2  0A                         LOADL_quick   ; inline operand = 10
  $99A3  D6 AB 99                   JUMP_abs               $99AB
 >$99A6  A4 FC 6F                   LOADL_abs              $6FFC (combat_arena_y_max)
  $99A9  1A                         LOADR_quick   ; inline operand = 10
  $99AA  BC                         SUB
 >$99AB  28                         STORE_quick   ; inline operand = 8
  $99AC  38                         PUSH_quick   ; inline operand = 8
  $99AD  39                         PUSH_quick   ; inline operand = 9
  $99AE  E9 FE 98 04                CALL_abs_imm1          $98FE (seek_enemy_adjacent_cell_and_commit_move) {bytecode}, $04
  $99B2  D8 BB 99                   JUMPF_abs              $99BB
  $99B5  63                         PUSH_qimm   ; inline operand = 3
  $99B6  E9 10 98 02                CALL_abs_imm1          $9810 (ai_place_unit_in_free_slot_resolve_coords) {bytecode}, $02
  $99BA  CF                         RETURN
 >$99BB  0A                         LOADL_quick   ; inline operand = 10
  $99BC  D0                         INC
 >$99BD  2A                         STORE_quick   ; inline operand = 10
  $99BE  0A                         LOADL_quick   ; inline operand = 10
  $99BF  A6 FC 6F                   LOADR_abs              $6FFC (combat_arena_y_max)
  $99C2  C7                         UCMPLE
  $99C3  D7 90 99                   JUMPT_abs              $9990
  $99C6  0B                         LOADL_quick   ; inline operand = 11
  $99C7  D0                         INC
 >$99C8  2B                         STORE_quick   ; inline operand = 11
  $99C9  0B                         LOADL_quick   ; inline operand = 11
  $99CA  A6 FA 6F                   LOADR_abs              $6FFA (combat_arena_x_max)
  $99CD  C7                         UCMPLE
  $99CE  D7 8A 99                   JUMPT_abs              $998A
  $99D1  CF                         RETURN

; ============================================================
; sub $99D2   (frame_off=-4, body @ $99D7)
; ============================================================
  $99D7  40                         LOADL_qimm   ; inline operand = 0
  $99D8  A8 E4 7B                   STORE_abs              $7BE4 (cur_combat_unit_slot)
  $99DB  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $99DE  D8 E7 99                   JUMPF_abs              $99E7
  $99E1  AC 65 98                   CALL_abs               $9865 (ai_advance_units_when_attacker_stronger) {bytecode}
  $99E4  D6 0F 9A                   JUMP_abs               $9A0F
 >$99E7  3C                         PUSH_quick   ; inline operand = 12
  $99E8  E9 54 99 02                CALL_abs_imm1          $9954 (rng_search_combat_rect_for_unit_cell) {bytecode}, $02
  $99EC  D6 0F 9A                   JUMP_abs               $9A0F
 >$99EF  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $99F2  D0                         INC
  $99F3  A8 E4 7B                   STORE_abs              $7BE4 (cur_combat_unit_slot)
  $99F6  D6 0F 9A                   JUMP_abs               $9A0F
 >$99F9  AC F8 97                   CALL_abs               $97F8 (test_cur_unit_slot_present) {bytecode}
  $99FC  D7 EF 99                   JUMPT_abs              $99EF
  $99FF  65                         PUSH_qimm   ; inline operand = 5
  $9A00  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9A04  B3                         PUSHL
  $9A05  6B                         PUSH_qimm   ; inline operand = 11
  $9A06  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9A0A  B3                         PUSHL
  $9A0B  E9 D9 97 04                CALL_abs_imm1          $97D9 (commit_unit_move_and_redraw_count) {bytecode}, $04
 >$9A0F  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $9A12  55                         LOADR_qimm   ; inline operand = 5
  $9A13  C6                         UCMPLT
  $9A14  D7 F9 99                   JUMPT_abs              $99F9
  $9A17  CF                         RETURN

; ============================================================
; sub $9A18   (frame_off=-10, body @ $9A1D)
; ============================================================
  $9A1D  40                         LOADL_qimm   ; inline operand = 0
  $9A1E  A8 E4 7B                   STORE_abs              $7BE4 (cur_combat_unit_slot)
 >$9A21  AC F8 97                   CALL_abs               $97F8 (test_cur_unit_slot_present) {bytecode}
  $9A24  D7 F5 9A                   JUMPT_abs              $9AF5
  $9A27  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $9A2A  D7 56 9A                   JUMPT_abs              $9A56
  $9A2D  8E A0 B9                   PUSH_imm2              $B9A0 (msg_lord)
  $9A30  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9A34  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9A37  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $9A3B  B3                         PUSHL
  $9A3C  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $9A40  59                         LOADR_qimm   ; inline operand = 9
  $9A41  B5                         MULT
  $9A42  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $9A45  BB                         ADD
  $9A46  B3                         PUSHL
  $9A47  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9A4B  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $9A4E  D0                         INC
  $9A4F  B3                         PUSHL
  $9A50  8E A6 B9                   PUSH_imm2              $B9A6 (msg_please_position_unit_d)
  $9A53  D6 65 9A                   JUMP_abs               $9A65
 >$9A56  8D 18                      BYTE_PUSH_imm1         +24
  $9A58  67                         PUSH_qimm   ; inline operand = 7
  $9A59  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $9A5D  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $9A60  D0                         INC
  $9A61  B3                         PUSHL
  $9A62  8E BF B9                   PUSH_imm2              $B9BF (msg_fmt__d_b9bf)
 >$9A65  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $9A69  A4 F8 6F                   LOADL_abs              $6FF8 (combat_arena_y_min)
  $9A6C  D6 8C 9A                   JUMP_abs               $9A8C
 >$9A6F  A4 F6 6F                   LOADL_abs              $6FF6 (combat_arena_x_min)
  $9A72  D6 81 9A                   JUMP_abs               $9A81
 >$9A75  62                         PUSH_qimm   ; inline operand = 2
  $9A76  39                         PUSH_quick   ; inline operand = 9
  $9A77  3A                         PUSH_quick   ; inline operand = 10
  $9A78  E9 DB 82 06                CALL_abs_imm1          $82DB (test_map_cell_bits) {bytecode}, $06
  $9A7C  D7 95 9A                   JUMPT_abs              $9A95
  $9A7F  0A                         LOADL_quick   ; inline operand = 10
  $9A80  D0                         INC
 >$9A81  2A                         STORE_quick   ; inline operand = 10
  $9A82  0A                         LOADL_quick   ; inline operand = 10
  $9A83  A6 FA 6F                   LOADR_abs              $6FFA (combat_arena_x_max)
  $9A86  C7                         UCMPLE
  $9A87  D7 75 9A                   JUMPT_abs              $9A75
  $9A8A  09                         LOADL_quick   ; inline operand = 9
  $9A8B  D0                         INC
 >$9A8C  29                         STORE_quick   ; inline operand = 9
  $9A8D  09                         LOADL_quick   ; inline operand = 9
  $9A8E  A6 FC 6F                   LOADR_abs              $6FFC (combat_arena_y_max)
  $9A91  C7                         UCMPLE
  $9A92  D7 6F 9A                   JUMPT_abs              $9A6F
 >$9A95  0A                         LOADL_quick   ; inline operand = 10
  $9A96  28                         STORE_quick   ; inline operand = 8
  $9A97  09                         LOADL_quick   ; inline operand = 9
  $9A98  27                         STORE_quick   ; inline operand = 7
  $9A99  D6 C8 9A                   JUMP_abs               $9AC8
 >$9A9C  3B                         PUSH_quick   ; inline operand = 11
  $9A9D  DE FA FF                   LEAL_far               $FFFA
  $9AA0  B3                         PUSHL
  $9AA1  DE FC FF                   LEAL_far               $FFFC
  $9AA4  B3                         PUSHL
  $9AA5  E9 44 85 06                CALL_abs_imm1          $8544 (step_coord_from_dir_code) {bytecode}, $06
  $9AA9  D8 C4 9A                   JUMPF_abs              $9AC4
  $9AAC  39                         PUSH_quick   ; inline operand = 9
  $9AAD  3A                         PUSH_quick   ; inline operand = 10
  $9AAE  E9 0A 97 04                CALL_abs_imm1          $970A (is_coord_in_combat_rect) {bytecode}, $04
  $9AB2  D8 C4 9A                   JUMPF_abs              $9AC4
  $9AB5  0A                         LOADL_quick   ; inline operand = 10
  $9AB6  28                         STORE_quick   ; inline operand = 8
  $9AB7  09                         LOADL_quick   ; inline operand = 9
  $9AB8  27                         STORE_quick   ; inline operand = 7
  $9AB9  62                         PUSH_qimm   ; inline operand = 2
  $9ABA  E9 3E D7 02                CALL_abs_imm1          $D73E (delay_loop) {bytecode}, $02
  $9ABE  D6 C8 9A                   JUMP_abs               $9AC8
  $9AC1  D6 C8 9A                   JUMP_abs               $9AC8
 >$9AC4  08                         LOADL_quick   ; inline operand = 8
  $9AC5  2A                         STORE_quick   ; inline operand = 10
  $9AC6  07                         LOADL_quick   ; inline operand = 7
  $9AC7  29                         STORE_quick   ; inline operand = 9
 >$9AC8  3A                         PUSH_quick   ; inline operand = 10
  $9AC9  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $9ACD  D7 D5 9A                   JUMPT_abs              $9AD5
  $9AD0  3A                         PUSH_quick   ; inline operand = 10
  $9AD1  E9 BE 95 02                CALL_abs_imm1          $95BE (draw_tactical_cursor_region_arg0) {bytecode}, $02
 >$9AD5  39                         PUSH_quick   ; inline operand = 9
  $9AD6  3A                         PUSH_quick   ; inline operand = 10
  $9AD7  E9 61 85 04                CALL_abs_imm1          $8561 (wait_button_press_debounced) {bytecode}, $04
  $9ADB  2B                         STORE_quick   ; inline operand = 11
  $9ADC  8B 30                      BYTE_LOADR_imm1        +48
  $9ADE  C1                         CMPNE
  $9ADF  D7 9C 9A                   JUMPT_abs              $9A9C
  $9AE2  39                         PUSH_quick   ; inline operand = 9
  $9AE3  3A                         PUSH_quick   ; inline operand = 10
  $9AE4  E9 92 97 04                CALL_abs_imm1          $9792 (commit_unit_dest_tile_if_valid) {bytecode}, $04
  $9AE8  D8 C8 9A                   JUMPF_abs              $9AC8
  $9AEB  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $9AEE  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9AF1  E9 DF 89 04                CALL_abs_imm1          $89DF (draw_unit_count_digits) {bytecode}, $04
 >$9AF5  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $9AF8  D0                         INC
  $9AF9  A8 E4 7B                   STORE_abs              $7BE4 (cur_combat_unit_slot)
  $9AFC  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $9AFF  55                         LOADR_qimm   ; inline operand = 5
  $9B00  C6                         UCMPLT
  $9B01  D7 21 9A                   JUMPT_abs              $9A21
  $9B04  AC 09 D3                   CALL_abs               $D309 (clear_rect_left_lower) {bytecode}
  $9B07  CF                         RETURN

; ============================================================
; sub $9B08   (frame_off=-4, body @ $9B0D)
; ============================================================
  $9B0D  AC EA 8B                   CALL_abs               $8BEA (combat_unit_window_refresh) {bytecode}
  $9B10  40                         LOADL_qimm   ; inline operand = 0
  $9B11  2B                         STORE_quick   ; inline operand = 11
 >$9B12  AC 75 96                   CALL_abs               $9675 (set_combat_arena_rect_by_approach) {bytecode}
  $9B15  2A                         STORE_quick   ; inline operand = 10
  $9B16  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $9B19  D8 22 9B                   JUMPF_abs              $9B22
  $9B1C  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $9B1F  D8 2C 9B                   JUMPF_abs              $9B2C
 >$9B22  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9B25  E9 30 90 02                CALL_abs_imm1          $9030 (is_battleside_province_aistate5_and_not_resting) {bytecode}, $02
  $9B29  D8 34 9B                   JUMPF_abs              $9B34
 >$9B2C  3A                         PUSH_quick   ; inline operand = 10
  $9B2D  E9 D2 99 02                CALL_abs_imm1          $99D2 (ai_place_combat_units_random_or_smart) {bytecode}, $02
  $9B31  D6 37 9B                   JUMP_abs               $9B37
 >$9B34  AC 18 9A                   CALL_abs               $9A18 (player_interactive_unit_move_loop) {bytecode}
 >$9B37  41                         LOADL_qimm   ; inline operand = 1
  $9B38  CD                         SWAP
  $9B39  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $9B3C  DC                         XOR
  $9B3D  A8 E8 7B                   STORE_abs              $7BE8 (cur_combat_side)
  $9B40  0B                         LOADL_quick   ; inline operand = 11
  $9B41  D0                         INC
  $9B42  2B                         STORE_quick   ; inline operand = 11
  $9B43  0B                         LOADL_quick   ; inline operand = 11
  $9B44  52                         LOADR_qimm   ; inline operand = 2
  $9B45  C6                         UCMPLT
  $9B46  D7 12 9B                   JUMPT_abs              $9B12
  $9B49  CF                         RETURN

; ============================================================
; sub $9B4A   (frame_off=-8, body @ $9B4F)
; ============================================================
  $9B4F  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $9B52  E9 0A 90 02                CALL_abs_imm1          $900A (wrap_index_0_2_to_zero) {bytecode}, $02
  $9B56  8F 1F                      BYTE_ADD_imm1          +31
  $9B58  B3                         PUSHL
  $9B59  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $9B5D  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $9B60  51                         LOADR_qimm   ; inline operand = 1
  $9B61  DC                         XOR
  $9B62  28                         STORE_quick   ; inline operand = 8
  $9B63  3C                         PUSH_quick   ; inline operand = 12
  $9B64  38                         PUSH_quick   ; inline operand = 8
  $9B65  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $9B69  D3                         BYTE_DEREF
  $9B6A  2A                         STORE_quick   ; inline operand = 10
  $9B6B  3C                         PUSH_quick   ; inline operand = 12
  $9B6C  38                         PUSH_quick   ; inline operand = 8
  $9B6D  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $9B71  D3                         BYTE_DEREF
  $9B72  29                         STORE_quick   ; inline operand = 9
  $9B73  3A                         PUSH_quick   ; inline operand = 10
  $9B74  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $9B78  D7 80 9B                   JUMPT_abs              $9B80
  $9B7B  3A                         PUSH_quick   ; inline operand = 10
  $9B7C  E9 BE 95 02                CALL_abs_imm1          $95BE (draw_tactical_cursor_region_arg0) {bytecode}, $02
 >$9B80  40                         LOADL_qimm   ; inline operand = 0
  $9B81  2B                         STORE_quick   ; inline operand = 11
 >$9B82  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $9B85  D3                         BYTE_DEREF
  $9B86  B3                         PUSHL
  $9B87  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $9B8A  D3                         BYTE_DEREF
  $9B8B  B3                         PUSHL
  $9B8C  E9 70 82 04                CALL_abs_imm1          $8270 (set_combat_state_pair_7bf5_7bf7) {bytecode}, $04
  $9B90  61                         PUSH_qimm   ; inline operand = 1
  $9B91  E9 0B 84 02                CALL_abs_imm1          $840B (draw_tactical_cursor_region) {bytecode}, $02
  $9B95  60                         PUSH_qimm   ; inline operand = 0
  $9B96  E9 0B 84 02                CALL_abs_imm1          $840B (draw_tactical_cursor_region) {bytecode}, $02
  $9B9A  39                         PUSH_quick   ; inline operand = 9
  $9B9B  3A                         PUSH_quick   ; inline operand = 10
  $9B9C  E9 70 82 04                CALL_abs_imm1          $8270 (set_combat_state_pair_7bf5_7bf7) {bytecode}, $04
  $9BA0  61                         PUSH_qimm   ; inline operand = 1
  $9BA1  E9 0B 84 02                CALL_abs_imm1          $840B (draw_tactical_cursor_region) {bytecode}, $02
  $9BA5  60                         PUSH_qimm   ; inline operand = 0
  $9BA6  E9 0B 84 02                CALL_abs_imm1          $840B (draw_tactical_cursor_region) {bytecode}, $02
  $9BAA  0B                         LOADL_quick   ; inline operand = 11
  $9BAB  D0                         INC
  $9BAC  2B                         STORE_quick   ; inline operand = 11
  $9BAD  0B                         LOADL_quick   ; inline operand = 11
  $9BAE  53                         LOADR_qimm   ; inline operand = 3
  $9BAF  C6                         UCMPLT
  $9BB0  D7 82 9B                   JUMPT_abs              $9B82
  $9BB3  CF                         RETURN

; ============================================================
; sub $9BB4   (frame_off=-2, body @ $9BB9)
; ============================================================
  $9BB9  43                         LOADL_qimm   ; inline operand = 3
  $9BBA  2B                         STORE_quick   ; inline operand = 11
  $9BBB  3D                         PUSH_quick   ; inline operand = 13
  $9BBC  3C                         PUSH_quick   ; inline operand = 12
  $9BBD  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $9BC1  D3                         BYTE_DEREF
  $9BC2  B3                         PUSHL
  $9BC3  3D                         PUSH_quick   ; inline operand = 13
  $9BC4  3C                         PUSH_quick   ; inline operand = 12
  $9BC5  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $9BC9  D3                         BYTE_DEREF
  $9BCA  B3                         PUSHL
  $9BCB  E9 88 DC 04                CALL_abs_imm1          $DC88 (read_map_cell) {bytecode}, $04
  $9BCF  8C FE 00                   LOADR_imm2             $00FE
  $9BD2  DA                         AND
  $9BD3  D9 03 00 20 00 E4 9B 10 00 E7 9B 08 ... SWITCH_noncontig       count=3   ; .table 3 (key,target) + default (noncontiguous); SWITCH 32=>$9BE4 16=>$9BE7 8=>$9BEA default=>$9BED
 >$9BE4  0B                         LOADL_quick   ; inline operand = 11
  $9BE5  D1                         DEC
  $9BE6  2B                         STORE_quick   ; inline operand = 11
 >$9BE7  0B                         LOADL_quick   ; inline operand = 11
  $9BE8  D1                         DEC
  $9BE9  2B                         STORE_quick   ; inline operand = 11
 >$9BEA  0B                         LOADL_quick   ; inline operand = 11
  $9BEB  D1                         DEC
  $9BEC  2B                         STORE_quick   ; inline operand = 11
 >$9BED  0B                         LOADL_quick   ; inline operand = 11
  $9BEE  D2                         LSHIFT1
  $9BEF  8C C2 B9                   LOADR_imm2             $B9C2 (ai_terrain_strength_term_data_b9c2)
  $9BF2  BB                         ADD
  $9BF3  B0                         DEREF
  $9BF4  B3                         PUSHL
  $9BF5  3D                         PUSH_quick   ; inline operand = 13
  $9BF6  3C                         PUSH_quick   ; inline operand = 12
  $9BF7  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $9BFB  B0                         DEREF
  $9BFC  B3                         PUSHL
  $9BFD  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9C01  53                         LOADR_qimm   ; inline operand = 3
  $9C02  B5                         MULT
  $9C03  CF                         RETURN

; ============================================================
; sub $9C04   (frame_off=-10, body @ $9C09)
; ============================================================
  $9C09  3C                         PUSH_quick   ; inline operand = 12
  $9C0A  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $9C0E  8B 1A                      BYTE_LOADR_imm1        +26
  $9C10  B5                         MULT
  $9C11  8C 13 70                   LOADR_imm2             $7013
  $9C14  BB                         ADD
  $9C15  29                         STORE_quick   ; inline operand = 9
  $9C16  0C                         LOADL_quick   ; inline operand = 12
  $9C17  D8 1E 9C                   JUMPF_abs              $9C1E
  $9C1A  40                         LOADL_qimm   ; inline operand = 0
  $9C1B  D6 1F 9C                   JUMP_abs               $9C1F
 >$9C1E  41                         LOADL_qimm   ; inline operand = 1
 >$9C1F  B3                         PUSHL
  $9C20  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $9C24  8B 1A                      BYTE_LOADR_imm1        +26
  $9C26  B5                         MULT
  $9C27  8C 13 70                   LOADR_imm2             $7013
  $9C2A  BB                         ADD
  $9C2B  28                         STORE_quick   ; inline operand = 8
  $9C2C  40                         LOADL_qimm   ; inline operand = 0
  $9C2D  2B                         STORE_quick   ; inline operand = 11
  $9C2E  27                         STORE_quick   ; inline operand = 7
  $9C2F  D6 5F 9C                   JUMP_abs               $9C5F
 >$9C32  08                         LOADL_quick   ; inline operand = 8
  $9C33  72                         ADD_qimm   ; inline operand = 2
  $9C34  28                         STORE_quick   ; inline operand = 8
  $9C35  8F FE                      BYTE_ADD_imm1          -2
  $9C37  B0                         DEREF
  $9C38  B3                         PUSHL
  $9C39  09                         LOADL_quick   ; inline operand = 9
  $9C3A  72                         ADD_qimm   ; inline operand = 2
  $9C3B  29                         STORE_quick   ; inline operand = 9
  $9C3C  8F FE                      BYTE_ADD_imm1          -2
  $9C3E  B0                         DEREF
  $9C3F  B4                         POPR
  $9C40  BC                         SUB
  $9C41  2A                         STORE_quick   ; inline operand = 10
  $9C42  50                         LOADR_qimm   ; inline operand = 0
  $9C43  C4                         SCMPGT
  $9C44  D8 5C 9C                   JUMPF_abs              $9C5C
  $9C47  0A                         LOADL_quick   ; inline operand = 10
  $9C48  8B 64                      BYTE_LOADR_imm1        +100
  $9C4A  B6                         SDIV
  $9C4B  B3                         PUSHL
  $9C4C  3D                         PUSH_quick   ; inline operand = 13
  $9C4D  3C                         PUSH_quick   ; inline operand = 12
  $9C4E  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $9C52  B0                         DEREF
  $9C53  B3                         PUSHL
  $9C54  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9C58  CD                         SWAP
  $9C59  07                         LOADL_quick   ; inline operand = 7
  $9C5A  BB                         ADD
  $9C5B  27                         STORE_quick   ; inline operand = 7
 >$9C5C  0B                         LOADL_quick   ; inline operand = 11
  $9C5D  D0                         INC
  $9C5E  2B                         STORE_quick   ; inline operand = 11
 >$9C5F  0B                         LOADL_quick   ; inline operand = 11
  $9C60  53                         LOADR_qimm   ; inline operand = 3
  $9C61  C6                         UCMPLT
  $9C62  D7 32 9C                   JUMPT_abs              $9C32
  $9C65  07                         LOADL_quick   ; inline operand = 7
  $9C66  53                         LOADR_qimm   ; inline operand = 3
  $9C67  B5                         MULT
  $9C68  CF                         RETURN

; ============================================================
; sub $9C69   (frame_off=+0, body @ $9C6E)
; ============================================================
  $9C6E  3E                         PUSH_quick   ; inline operand = 14
  $9C6F  E9 0A 90 02                CALL_abs_imm1          $900A (wrap_index_0_2_to_zero) {bytecode}, $02
  $9C73  B3                         PUSHL
  $9C74  3D                         PUSH_quick   ; inline operand = 13
  $9C75  E9 0A 90 02                CALL_abs_imm1          $900A (wrap_index_0_2_to_zero) {bytecode}, $02
  $9C79  B4                         POPR
  $9C7A  C8                         UCMPGT
  $9C7B  D8 86 9C                   JUMPF_abs              $9C86
  $9C7E  3D                         PUSH_quick   ; inline operand = 13
  $9C7F  3C                         PUSH_quick   ; inline operand = 12
  $9C80  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $9C84  B0                         DEREF
  $9C85  CF                         RETURN
 >$9C86  40                         LOADL_qimm   ; inline operand = 0
  $9C87  CF                         RETURN

; ============================================================
; sub $9C88   (frame_off=-4, body @ $9C8D)
; ============================================================
  $9C8D  AC 5C 8E                   CALL_abs               $8E5C (ai_sum_battle_strength) {bytecode}
  $9C90  3D                         PUSH_quick   ; inline operand = 13
  $9C91  3C                         PUSH_quick   ; inline operand = 12
  $9C92  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $9C96  B0                         DEREF
  $9C97  2B                         STORE_quick   ; inline operand = 11
  $9C98  0E                         LOADL_quick   ; inline operand = 14
  $9C99  8C EE 7B                   LOADR_imm2             $7BEE
  $9C9C  BB                         ADD
  $9C9D  D3                         BYTE_DEREF
  $9C9E  8B 14                      BYTE_LOADR_imm1        +20
  $9CA0  B5                         MULT
  $9CA1  B3                         PUSHL
  $9CA2  3B                         PUSH_quick   ; inline operand = 11
  $9CA3  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9CA7  B3                         PUSHL
  $9CA8  3C                         PUSH_quick   ; inline operand = 12
  $9CA9  3B                         PUSH_quick   ; inline operand = 11
  $9CAA  E9 40 8E 04                CALL_abs_imm1          $8E40 (ai_score_strength_term_40pct) {bytecode}, $04
  $9CAE  B3                         PUSHL
  $9CAF  3E                         PUSH_quick   ; inline operand = 14
  $9CB0  3D                         PUSH_quick   ; inline operand = 13
  $9CB1  3C                         PUSH_quick   ; inline operand = 12
  $9CB2  E9 69 9C 06                CALL_abs_imm1          $9C69 (ai_strength_term_gated_table_word) {bytecode}, $06
  $9CB6  B3                         PUSHL
  $9CB7  3D                         PUSH_quick   ; inline operand = 13
  $9CB8  3C                         PUSH_quick   ; inline operand = 12
  $9CB9  E9 04 9C 04                CALL_abs_imm1          $9C04 (ai_province_stat_diff_term) {bytecode}, $04
  $9CBD  B3                         PUSHL
  $9CBE  3D                         PUSH_quick   ; inline operand = 13
  $9CBF  3C                         PUSH_quick   ; inline operand = 12
  $9CC0  E9 B4 9B 04                CALL_abs_imm1          $9BB4 (ai_terrain_strength_term) {bytecode}, $04
  $9CC4  B3                         PUSHL
  $9CC5  3C                         PUSH_quick   ; inline operand = 12
  $9CC6  E9 E5 D9 02                CALL_abs_imm1          $D9E5 (test_6f65_bit7) {bytecode}, $02
  $9CCA  D8 D1 9C                   JUMPF_abs              $9CD1
  $9CCD  0B                         LOADL_quick   ; inline operand = 11
  $9CCE  D6 D2 9C                   JUMP_abs               $9CD2
 >$9CD1  40                         LOADL_qimm   ; inline operand = 0
 >$9CD2  B4                         POPR
  $9CD3  BB                         ADD
  $9CD4  B4                         POPR
  $9CD5  BB                         ADD
  $9CD6  B4                         POPR
  $9CD7  BB                         ADD
  $9CD8  B4                         POPR
  $9CD9  BB                         ADD
  $9CDA  B4                         POPR
  $9CDB  BB                         ADD
  $9CDC  2A                         STORE_quick   ; inline operand = 10
  $9CDD  3C                         PUSH_quick   ; inline operand = 12
  $9CDE  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $9CE2  B3                         PUSHL
  $9CE3  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9CE7  D8 F7 9C                   JUMPF_abs              $9CF7
  $9CEA  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $9CED  5F                         LOADR_qimm   ; inline operand = 15
  $9CEE  B5                         MULT
  $9CEF  B3                         PUSHL
  $9CF0  89 73                      BYTE_LOADL_imm1        +115
  $9CF2  B4                         POPR
  $9CF3  BC                         SUB
  $9CF4  D6 F9 9C                   JUMP_abs               $9CF9
 >$9CF7  89 64                      BYTE_LOADL_imm1        +100
 >$9CF9  B3                         PUSHL
  $9CFA  0B                         LOADL_quick   ; inline operand = 11
  $9CFB  1A                         LOADR_quick   ; inline operand = 10
  $9CFC  BB                         ADD
  $9CFD  B3                         PUSHL
  $9CFE  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9D02  CF                         RETURN

; ============================================================
; sub $9D03   (frame_off=-4, body @ $9D08)
; ============================================================
  $9D08  3D                         PUSH_quick   ; inline operand = 13
  $9D09  3C                         PUSH_quick   ; inline operand = 12
  $9D0A  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $9D0E  2B                         STORE_quick   ; inline operand = 11
  $9D0F  0B                         LOADL_quick   ; inline operand = 11
  $9D10  B0                         DEREF
  $9D11  B3                         PUSHL
  $9D12  0E                         LOADL_quick   ; inline operand = 14
  $9D13  8B 32                      BYTE_LOADR_imm1        +50
  $9D15  C9                         UCMPGE
  $9D16  D8 1D 9D                   JUMPF_abs              $9D1D
  $9D19  41                         LOADL_qimm   ; inline operand = 1
  $9D1A  D6 1E 9D                   JUMP_abs               $9D1E
 >$9D1D  40                         LOADL_qimm   ; inline operand = 0
 >$9D1E  B3                         PUSHL
  $9D1F  3E                         PUSH_quick   ; inline operand = 14
  $9D20  0B                         LOADL_quick   ; inline operand = 11
  $9D21  B0                         DEREF
  $9D22  B3                         PUSHL
  $9D23  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9D27  B4                         POPR
  $9D28  BB                         ADD
  $9D29  2A                         STORE_quick   ; inline operand = 10
  $9D2A  B4                         POPR
  $9D2B  C8                         UCMPGT
  $9D2C  D8 32 9D                   JUMPF_abs              $9D32
  $9D2F  0B                         LOADL_quick   ; inline operand = 11
  $9D30  B0                         DEREF
  $9D31  2A                         STORE_quick   ; inline operand = 10
 >$9D32  3A                         PUSH_quick   ; inline operand = 10
  $9D33  3C                         PUSH_quick   ; inline operand = 12
  $9D34  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $9D38  74                         ADD_qimm   ; inline operand = 4
  $9D39  B4                         POPR
  $9D3A  B3                         PUSHL
  $9D3B  B0                         DEREF
  $9D3C  BC                         SUB
  $9D3D  B1                         POPSTORE
  $9D3E  62                         PUSH_qimm   ; inline operand = 2
  $9D3F  3C                         PUSH_quick   ; inline operand = 12
  $9D40  E9 8A 8B 04                CALL_abs_imm1          $8B8A (draw_unit_stat_field) {bytecode}, $04
  $9D44  3A                         PUSH_quick   ; inline operand = 10
  $9D45  0B                         LOADL_quick   ; inline operand = 11
  $9D46  B4                         POPR
  $9D47  B3                         PUSHL
  $9D48  B0                         DEREF
  $9D49  BC                         SUB
  $9D4A  B1                         POPSTORE
  $9D4B  50                         LOADR_qimm   ; inline operand = 0
  $9D4C  C3                         SCMPLE
  $9D4D  D8 6D 9D                   JUMPF_abs              $9D6D
  $9D50  3D                         PUSH_quick   ; inline operand = 13
  $9D51  3C                         PUSH_quick   ; inline operand = 12
  $9D52  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $9D56  D3                         BYTE_DEREF
  $9D57  B3                         PUSHL
  $9D58  3D                         PUSH_quick   ; inline operand = 13
  $9D59  3C                         PUSH_quick   ; inline operand = 12
  $9D5A  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $9D5E  D3                         BYTE_DEREF
  $9D5F  B3                         PUSHL
  $9D60  E9 25 8B 04                CALL_abs_imm1          $8B25 (draw_terrain_feature_if_valid) {bytecode}, $04
  $9D64  3D                         PUSH_quick   ; inline operand = 13
  $9D65  3C                         PUSH_quick   ; inline operand = 12
  $9D66  E9 97 8F 04                CALL_abs_imm1          $8F97 (clear_unit_status_flag_set_field_200) {bytecode}, $04
  $9D6A  D6 73 9D                   JUMP_abs               $9D73
 >$9D6D  3D                         PUSH_quick   ; inline operand = 13
  $9D6E  3C                         PUSH_quick   ; inline operand = 12
  $9D6F  E9 DF 89 04                CALL_abs_imm1          $89DF (draw_unit_count_digits) {bytecode}, $04
 >$9D73  0A                         LOADL_quick   ; inline operand = 10
  $9D74  CF                         RETURN

; ============================================================
; sub $9D75   (frame_off=+0, body @ $9D7A)
; ============================================================
  $9D7A  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $9D7D  3C                         PUSH_quick   ; inline operand = 12
  $9D7E  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $9D81  51                         LOADR_qimm   ; inline operand = 1
  $9D82  DC                         XOR
  $9D83  B3                         PUSHL
  $9D84  E9 88 9C 06                CALL_abs_imm1          $9C88 (ai_eval_battle_strength_total) {bytecode}, $06
  $9D88  B3                         PUSHL
  $9D89  3C                         PUSH_quick   ; inline operand = 12
  $9D8A  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $9D8D  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9D90  E9 88 9C 06                CALL_abs_imm1          $9C88 (ai_eval_battle_strength_total) {bytecode}, $06
  $9D94  B3                         PUSHL
  $9D95  E9 DE D6 04                CALL_abs_imm1          $D6DE (math32_2arg) {bytecode}, $04
  $9D99  CF                         RETURN

; ============================================================
; sub $9D9A   (frame_off=+0, body @ $9D9F)
; ============================================================
  $9D9F  3C                         PUSH_quick   ; inline operand = 12
  $9DA0  E9 75 9D 02                CALL_abs_imm1          $9D75 (calc_battle_strength_pct_one_side) {bytecode}, $02
  $9DA4  8B 32                      BYTE_LOADR_imm1        +50
  $9DA6  C2                         SCMPLT
  $9DA7  CF                         RETURN

; ============================================================
; sub $9DA8   (frame_off=-4, body @ $9DAD)
; ============================================================
  $9DAD  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $9DB0  51                         LOADR_qimm   ; inline operand = 1
  $9DB1  DC                         XOR
  $9DB2  2B                         STORE_quick   ; inline operand = 11
  $9DB3  68                         PUSH_qimm   ; inline operand = 8
  $9DB4  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $9DB7  D3                         BYTE_DEREF
  $9DB8  B3                         PUSHL
  $9DB9  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $9DBC  D3                         BYTE_DEREF
  $9DBD  B3                         PUSHL
  $9DBE  E9 DB 82 06                CALL_abs_imm1          $82DB (test_map_cell_bits) {bytecode}, $06
  $9DC2  D8 DE 9D                   JUMPF_abs              $9DDE
  $9DC5  68                         PUSH_qimm   ; inline operand = 8
  $9DC6  3D                         PUSH_quick   ; inline operand = 13
  $9DC7  3B                         PUSH_quick   ; inline operand = 11
  $9DC8  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $9DCC  D3                         BYTE_DEREF
  $9DCD  B3                         PUSHL
  $9DCE  3D                         PUSH_quick   ; inline operand = 13
  $9DCF  3B                         PUSH_quick   ; inline operand = 11
  $9DD0  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $9DD4  D3                         BYTE_DEREF
  $9DD5  B3                         PUSHL
  $9DD6  E9 DB 82 06                CALL_abs_imm1          $82DB (test_map_cell_bits) {bytecode}, $06
  $9DDA  D8 DE 9D                   JUMPF_abs              $9DDE
  $9DDD  CF                         RETURN
 >$9DDE  8E CA B9                   PUSH_imm2              $B9CA (msg_the_town_is_in_complete_chaos)
  $9DE1  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9DE5  42                         LOADL_qimm   ; inline operand = 2
  $9DE6  CD                         SWAP
  $9DE7  0C                         LOADL_quick   ; inline operand = 12
  $9DE8  B8                         UDIV
  $9DE9  2C                         STORE_quick   ; inline operand = 12
  $9DEA  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9DED  8B 1A                      BYTE_LOADR_imm1        +26
  $9DEF  B5                         MULT
  $9DF0  8C 05 70                   LOADR_imm2             $7005
  $9DF3  BB                         ADD
  $9DF4  2A                         STORE_quick   ; inline operand = 10
  $9DF5  0A                         LOADL_quick   ; inline operand = 10
  $9DF6  B0                         DEREF
  $9DF7  1C                         LOADR_quick   ; inline operand = 12
  $9DF8  C7                         UCMPLE
  $9DF9  D8 02 9E                   JUMPF_abs              $9E02
  $9DFC  3A                         PUSH_quick   ; inline operand = 10
  $9DFD  40                         LOADL_qimm   ; inline operand = 0
  $9DFE  B1                         POPSTORE
  $9DFF  D6 1C 9E                   JUMP_abs               $9E1C
 >$9E02  0A                         LOADL_quick   ; inline operand = 10
  $9E03  B0                         DEREF
  $9E04  1C                         LOADR_quick   ; inline operand = 12
  $9E05  BC                         SUB
  $9E06  B3                         PUSHL
  $9E07  3C                         PUSH_quick   ; inline operand = 12
  $9E08  E9 DE D6 04                CALL_abs_imm1          $D6DE (math32_2arg) {bytecode}, $04
  $9E0C  B3                         PUSHL
  $9E0D  0A                         LOADL_quick   ; inline operand = 10
  $9E0E  B0                         DEREF
  $9E0F  B3                         PUSHL
  $9E10  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9E14  5A                         LOADR_qimm   ; inline operand = 10
  $9E15  B5                         MULT
  $9E16  B3                         PUSHL
  $9E17  3A                         PUSH_quick   ; inline operand = 10
  $9E18  E9 31 CA 04                CALL_abs_imm1          $CA31 (word_sub_saturating) {bytecode}, $04
 >$9E1C  AC 1A D3                   CALL_abs               $D31A (clear_rect_left_lower_alt) {bytecode}
  $9E1F  CF                         RETURN

; ============================================================
; sub $9E20   (frame_off=-2, body @ $9E25)
; ============================================================
  $9E25  3C                         PUSH_quick   ; inline operand = 12
  $9E26  E9 4A 9B 02                CALL_abs_imm1          $9B4A (validate_phase_unit_cells_draw_cursor) {bytecode}, $02
  $9E2A  0C                         LOADL_quick   ; inline operand = 12
  $9E2B  8C EE 7B                   LOADR_imm2             $7BEE
  $9E2E  BB                         ADD
  $9E2F  B3                         PUSHL
  $9E30  D3                         BYTE_DEREF
  $9E31  D0                         INC
  $9E32  D4                         BYTE_POPSTORE
  $9E33  3C                         PUSH_quick   ; inline operand = 12
  $9E34  E9 75 9D 02                CALL_abs_imm1          $9D75 (calc_battle_strength_pct_one_side) {bytecode}, $02
  $9E38  2B                         STORE_quick   ; inline operand = 11
  $9E39  3C                         PUSH_quick   ; inline operand = 12
  $9E3A  3B                         PUSH_quick   ; inline operand = 11
  $9E3B  3C                         PUSH_quick   ; inline operand = 12
  $9E3C  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $9E3F  51                         LOADR_qimm   ; inline operand = 1
  $9E40  DC                         XOR
  $9E41  B3                         PUSHL
  $9E42  E9 03 9D 06                CALL_abs_imm1          $9D03 (apply_pct_reduction_to_unit_strength) {bytecode}, $06
  $9E46  B3                         PUSHL
  $9E47  89 64                      BYTE_LOADL_imm1        +100
  $9E49  1B                         LOADR_quick   ; inline operand = 11
  $9E4A  BC                         SUB
  $9E4B  B3                         PUSHL
  $9E4C  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $9E4F  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9E52  E9 03 9D 06                CALL_abs_imm1          $9D03 (apply_pct_reduction_to_unit_strength) {bytecode}, $06
  $9E56  B4                         POPR
  $9E57  BB                         ADD
  $9E58  B3                         PUSHL
  $9E59  E9 A8 9D 04                CALL_abs_imm1          $9DA8 (reduce_defending_province_town_chaos) {bytecode}, $04
  $9E5D  0B                         LOADL_quick   ; inline operand = 11
  $9E5E  8B 32                      BYTE_LOADR_imm1        +50
  $9E60  C0                         CMPEQ
  $9E61  D8 66 9E                   JUMPF_abs              $9E66
  $9E64  40                         LOADL_qimm   ; inline operand = 0
  $9E65  CF                         RETURN
 >$9E66  0B                         LOADL_quick   ; inline operand = 11
  $9E67  8B 32                      BYTE_LOADR_imm1        +50
  $9E69  C8                         UCMPGT
  $9E6A  D8 71 9E                   JUMPF_abs              $9E71
  $9E6D  41                         LOADL_qimm   ; inline operand = 1
  $9E6E  D6 72 9E                   JUMP_abs               $9E72
 >$9E71  42                         LOADL_qimm   ; inline operand = 2
 >$9E72  CF                         RETURN

; ============================================================
; sub $9E73   (frame_off=-10, body @ $9E78)
; ============================================================
  $9E78  3D                         PUSH_quick   ; inline operand = 13
  $9E79  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9E7C  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $9E80  B4                         POPR
  $9E81  B3                         PUSHL
  $9E82  B0                         DEREF
  $9E83  BC                         SUB
  $9E84  B1                         POPSTORE
  $9E85  60                         PUSH_qimm   ; inline operand = 0
  $9E86  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9E89  E9 8A 8B 04                CALL_abs_imm1          $8B8A (draw_unit_stat_field) {bytecode}, $04
  $9E8D  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9E90  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $9E94  29                         STORE_quick   ; inline operand = 9
  $9E95  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $9E98  51                         LOADR_qimm   ; inline operand = 1
  $9E99  DC                         XOR
  $9E9A  27                         STORE_quick   ; inline operand = 7
  $9E9B  B3                         PUSHL
  $9E9C  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $9EA0  28                         STORE_quick   ; inline operand = 8
  $9EA1  39                         PUSH_quick   ; inline operand = 9
  $9EA2  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $9EA6  74                         ADD_qimm   ; inline operand = 4
  $9EA7  D3                         BYTE_DEREF
  $9EA8  B3                         PUSHL
  $9EA9  09                         LOADL_quick   ; inline operand = 9
  $9EAA  8B 1A                      BYTE_LOADR_imm1        +26
  $9EAC  B5                         MULT
  $9EAD  8C 13 70                   LOADR_imm2             $7013
  $9EB0  BB                         ADD
  $9EB1  B0                         DEREF
  $9EB2  B3                         PUSHL
  $9EB3  46                         LOADL_qimm   ; inline operand = 6
  $9EB4  A6 63 6D                   LOADR_abs              $6D63 (const_two)
  $9EB7  BC                         SUB
  $9EB8  B3                         PUSHL
  $9EB9  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9EBD  B4                         POPR
  $9EBE  BB                         ADD
  $9EBF  B4                         POPR
  $9EC0  BB                         ADD
  $9EC1  2B                         STORE_quick   ; inline operand = 11
  $9EC2  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $9EC5  D2                         LSHIFT1
  $9EC6  B3                         PUSHL
  $9EC7  38                         PUSH_quick   ; inline operand = 8
  $9EC8  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $9ECC  74                         ADD_qimm   ; inline operand = 4
  $9ECD  D3                         BYTE_DEREF
  $9ECE  B3                         PUSHL
  $9ECF  08                         LOADL_quick   ; inline operand = 8
  $9ED0  8B 1A                      BYTE_LOADR_imm1        +26
  $9ED2  B5                         MULT
  $9ED3  8C 13 70                   LOADR_imm2             $7013
  $9ED6  BB                         ADD
  $9ED7  B0                         DEREF
  $9ED8  B4                         POPR
  $9ED9  BB                         ADD
  $9EDA  B4                         POPR
  $9EDB  BB                         ADD
  $9EDC  2A                         STORE_quick   ; inline operand = 10
  $9EDD  A4 F3 7B                   LOADL_abs              $7BF3 (combat_casualty_skip_flag_7bf3)
  $9EE0  D7 37 9F                   JUMPT_abs              $9F37
  $9EE3  0B                         LOADL_quick   ; inline operand = 11
  $9EE4  1A                         LOADR_quick   ; inline operand = 10
  $9EE5  C4                         SCMPGT
  $9EE6  D8 37 9F                   JUMPF_abs              $9F37
  $9EE9  3C                         PUSH_quick   ; inline operand = 12
  $9EEA  37                         PUSH_quick   ; inline operand = 7
  $9EEB  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $9EEF  B0                         DEREF
  $9EF0  CD                         SWAP
  $9EF1  0D                         LOADL_quick   ; inline operand = 13
  $9EF2  B6                         SDIV
  $9EF3  2D                         STORE_quick   ; inline operand = 13
  $9EF4  0D                         LOADL_quick   ; inline operand = 13
  $9EF5  50                         LOADR_qimm   ; inline operand = 0
  $9EF6  C4                         SCMPGT
  $9EF7  D8 CE 9F                   JUMPF_abs              $9FCE
  $9EFA  3B                         PUSH_quick   ; inline operand = 11
  $9EFB  0B                         LOADL_quick   ; inline operand = 11
  $9EFC  1A                         LOADR_quick   ; inline operand = 10
  $9EFD  BC                         SUB
  $9EFE  B3                         PUSHL
  $9EFF  E9 DE D6 04                CALL_abs_imm1          $D6DE (math32_2arg) {bytecode}, $04
  $9F03  B3                         PUSHL
  $9F04  3C                         PUSH_quick   ; inline operand = 12
  $9F05  37                         PUSH_quick   ; inline operand = 7
  $9F06  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $9F0A  B0                         DEREF
  $9F0B  B3                         PUSHL
  $9F0C  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9F10  2B                         STORE_quick   ; inline operand = 11
  $9F11  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9F14  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $9F18  74                         ADD_qimm   ; inline operand = 4
  $9F19  B0                         DEREF
  $9F1A  1B                         LOADR_quick   ; inline operand = 11
  $9F1B  BB                         ADD
  $9F1C  8C 0F 27                   LOADR_imm2             $270F
  $9F1F  C4                         SCMPGT
  $9F20  D8 33 9F                   JUMPF_abs              $9F33
  $9F23  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9F26  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $9F2A  74                         ADD_qimm   ; inline operand = 4
  $9F2B  B0                         DEREF
  $9F2C  B3                         PUSHL
  $9F2D  8A 0F 27                   LOADL_imm2             $270F
  $9F30  B4                         POPR
  $9F31  BC                         SUB
  $9F32  2B                         STORE_quick   ; inline operand = 11
 >$9F33  0B                         LOADL_quick   ; inline operand = 11
  $9F34  D7 58 9F                   JUMPT_abs              $9F58
 >$9F37  39                         PUSH_quick   ; inline operand = 9
  $9F38  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9F3C  D8 46 9F                   JUMPF_abs              $9F46
  $9F3F  AA CE B1                   PUSH_abs               $B1CE
  $9F42  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
 >$9F46  3C                         PUSH_quick   ; inline operand = 12
  $9F47  37                         PUSH_quick   ; inline operand = 7
  $9F48  E9 DF 89 04                CALL_abs_imm1          $89DF (draw_unit_count_digits) {bytecode}, $04
  $9F4C  60                         PUSH_qimm   ; inline operand = 0
  $9F4D  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9F50  E9 DF 89 04                CALL_abs_imm1          $89DF (draw_unit_count_digits) {bytecode}, $04
  $9F54  AC 1A D3                   CALL_abs               $D31A (clear_rect_left_lower_alt) {bytecode}
  $9F57  CF                         RETURN
 >$9F58  3B                         PUSH_quick   ; inline operand = 11
  $9F59  3C                         PUSH_quick   ; inline operand = 12
  $9F5A  37                         PUSH_quick   ; inline operand = 7
  $9F5B  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $9F5F  B4                         POPR
  $9F60  B3                         PUSHL
  $9F61  B0                         DEREF
  $9F62  BC                         SUB
  $9F63  B1                         POPSTORE
  $9F64  3B                         PUSH_quick   ; inline operand = 11
  $9F65  37                         PUSH_quick   ; inline operand = 7
  $9F66  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $9F6A  74                         ADD_qimm   ; inline operand = 4
  $9F6B  B4                         POPR
  $9F6C  B3                         PUSHL
  $9F6D  B0                         DEREF
  $9F6E  BC                         SUB
  $9F6F  B1                         POPSTORE
  $9F70  62                         PUSH_qimm   ; inline operand = 2
  $9F71  37                         PUSH_quick   ; inline operand = 7
  $9F72  E9 8A 8B 04                CALL_abs_imm1          $8B8A (draw_unit_stat_field) {bytecode}, $04
  $9F76  3B                         PUSH_quick   ; inline operand = 11
  $9F77  60                         PUSH_qimm   ; inline operand = 0
  $9F78  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9F7B  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $9F7F  B4                         POPR
  $9F80  B3                         PUSHL
  $9F81  B0                         DEREF
  $9F82  BB                         ADD
  $9F83  B1                         POPSTORE
  $9F84  3B                         PUSH_quick   ; inline operand = 11
  $9F85  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9F88  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $9F8C  74                         ADD_qimm   ; inline operand = 4
  $9F8D  B4                         POPR
  $9F8E  B3                         PUSHL
  $9F8F  B0                         DEREF
  $9F90  BB                         ADD
  $9F91  B1                         POPSTORE
  $9F92  62                         PUSH_qimm   ; inline operand = 2
  $9F93  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $9F96  E9 8A 8B 04                CALL_abs_imm1          $8B8A (draw_unit_stat_field) {bytecode}, $04
  $9F9A  38                         PUSH_quick   ; inline operand = 8
  $9F9B  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9F9F  D8 A9 9F                   JUMPF_abs              $9FA9
  $9FA2  AA 9A B1                   PUSH_abs               $B19A
  $9FA5  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
 >$9FA9  39                         PUSH_quick   ; inline operand = 9
  $9FAA  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9FAE  D8 C7 9F                   JUMPF_abs              $9FC7
  $9FB1  AA 96 B1                   PUSH_abs               $B196 (jumptab_b196)
  $9FB4  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9FB8  3B                         PUSH_quick   ; inline operand = 11
  $9FB9  8E E9 B9                   PUSH_imm2              $B9E9 (msg_fmt__d_b9e9)
  $9FBC  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $9FC0  AA 98 B1                   PUSH_abs               $B198
  $9FC3  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$9FC7  41                         LOADL_qimm   ; inline operand = 1
  $9FC8  A8 F3 7B                   STORE_abs              $7BF3 (combat_casualty_skip_flag_7bf3)
  $9FCB  D6 46 9F                   JUMP_abs               $9F46
 >$9FCE  39                         PUSH_quick   ; inline operand = 9
  $9FCF  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9FD3  D8 DE 9F                   JUMPF_abs              $9FDE
  $9FD6  46                         LOADL_qimm   ; inline operand = 6
  $9FD7  A6 63 6D                   LOADR_abs              $6D63 (const_two)
  $9FDA  BC                         SUB
  $9FDB  D6 E1 9F                   JUMP_abs               $9FE1
 >$9FDE  A4 63 6D                   LOADL_abs              $6D63 (const_two)
 >$9FE1  B3                         PUSHL
  $9FE2  08                         LOADL_quick   ; inline operand = 8
  $9FE3  8B 1A                      BYTE_LOADR_imm1        +26
  $9FE5  B5                         MULT
  $9FE6  8C 13 70                   LOADR_imm2             $7013
  $9FE9  BB                         ADD
  $9FEA  B4                         POPR
  $9FEB  B3                         PUSHL
  $9FEC  B0                         DEREF
  $9FED  BC                         SUB
  $9FEE  B1                         POPSTORE
  $9FEF  08                         LOADL_quick   ; inline operand = 8
  $9FF0  8B 1A                      BYTE_LOADR_imm1        +26
  $9FF2  B5                         MULT
  $9FF3  8C 13 70                   LOADR_imm2             $7013
  $9FF6  BB                         ADD
  $9FF7  B0                         DEREF
  $9FF8  50                         LOADR_qimm   ; inline operand = 0
  $9FF9  C3                         SCMPLE
  $9FFA  D8 08 A0                   JUMPF_abs              $A008
  $9FFD  08                         LOADL_quick   ; inline operand = 8
  $9FFE  8B 1A                      BYTE_LOADR_imm1        +26
  $A000  B5                         MULT
  $A001  8C 13 70                   LOADR_imm2             $7013
  $A004  BB                         ADD
  $A005  B3                         PUSHL
  $A006  40                         LOADL_qimm   ; inline operand = 0
  $A007  B1                         POPSTORE
 >$A008  39                         PUSH_quick   ; inline operand = 9
  $A009  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $A00D  D8 C7 9F                   JUMPF_abs              $9FC7
  $A010  AA CA B1                   PUSH_abs               $B1CA
  $A013  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A017  D6 C7 9F                   JUMP_abs               $9FC7

; ============================================================
; sub $A01A   (frame_off=-4, body @ $A01F)
; ============================================================
  $A01F  40                         LOADL_qimm   ; inline operand = 0
  $A020  2B                         STORE_quick   ; inline operand = 11
  $A021  D6 34 A0                   JUMP_abs               $A034
 >$A024  3A                         PUSH_quick   ; inline operand = 10
  $A025  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A028  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $A02C  D8 32 A0                   JUMPF_abs              $A032
  $A02F  0B                         LOADL_quick   ; inline operand = 11
  $A030  D0                         INC
  $A031  2B                         STORE_quick   ; inline operand = 11
 >$A032  0A                         LOADL_quick   ; inline operand = 10
  $A033  D0                         INC
 >$A034  2A                         STORE_quick   ; inline operand = 10
  $A035  0A                         LOADL_quick   ; inline operand = 10
  $A036  55                         LOADR_qimm   ; inline operand = 5
  $A037  C6                         UCMPLT
  $A038  D7 24 A0                   JUMPT_abs              $A024
  $A03B  0B                         LOADL_quick   ; inline operand = 11
  $A03C  53                         LOADR_qimm   ; inline operand = 3
  $A03D  C8                         UCMPGT
  $A03E  D8 48 A0                   JUMPF_abs              $A048
  $A041  0B                         LOADL_quick   ; inline operand = 11
  $A042  D1                         DEC
  $A043  1C                         LOADR_quick   ; inline operand = 12
  $A044  C0                         CMPEQ
  $A045  D7 4C A0                   JUMPT_abs              $A04C
 >$A048  40                         LOADL_qimm   ; inline operand = 0
  $A049  D6 4D A0                   JUMP_abs               $A04D
 >$A04C  41                         LOADL_qimm   ; inline operand = 1
 >$A04D  CF                         RETURN

; ============================================================
; sub $A04E   (frame_off=+0, body @ $A053)
; ============================================================
  $A053  3F                         PUSH_quick   ; inline operand = 15
  $A054  3E                         PUSH_quick   ; inline operand = 14
  $A055  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $A059  D8 74 A0                   JUMPF_abs              $A074
  $A05C  3F                         PUSH_quick   ; inline operand = 15
  $A05D  3E                         PUSH_quick   ; inline operand = 14
  $A05E  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $A062  D3                         BYTE_DEREF
  $A063  1C                         LOADR_quick   ; inline operand = 12
  $A064  C0                         CMPEQ
  $A065  D8 74 A0                   JUMPF_abs              $A074
  $A068  3F                         PUSH_quick   ; inline operand = 15
  $A069  3E                         PUSH_quick   ; inline operand = 14
  $A06A  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $A06E  D3                         BYTE_DEREF
  $A06F  1D                         LOADR_quick   ; inline operand = 13
  $A070  C0                         CMPEQ
  $A071  D7 78 A0                   JUMPT_abs              $A078
 >$A074  40                         LOADL_qimm   ; inline operand = 0
  $A075  D6 79 A0                   JUMP_abs               $A079
 >$A078  41                         LOADL_qimm   ; inline operand = 1
 >$A079  CF                         RETURN

; ============================================================
; sub $A07A   (frame_off=-6, body @ $A07F)
; ============================================================
  $A07F  40                         LOADL_qimm   ; inline operand = 0
  $A080  2B                         STORE_quick   ; inline operand = 11
 >$A081  0C                         LOADL_quick   ; inline operand = 12
  $A082  2A                         STORE_quick   ; inline operand = 10
  $A083  0D                         LOADL_quick   ; inline operand = 13
  $A084  29                         STORE_quick   ; inline operand = 9
  $A085  3B                         PUSH_quick   ; inline operand = 11
  $A086  DE FA FF                   LEAL_far               $FFFA
  $A089  B3                         PUSHL
  $A08A  DE FC FF                   LEAL_far               $FFFC
  $A08D  B3                         PUSHL
  $A08E  E9 03 80 06                CALL_abs_imm1          $8003 {native}, $06
  $A092  D8 A2 A0                   JUMPF_abs              $A0A2
  $A095  3F                         PUSH_quick   ; inline operand = 15
  $A096  3E                         PUSH_quick   ; inline operand = 14
  $A097  39                         PUSH_quick   ; inline operand = 9
  $A098  3A                         PUSH_quick   ; inline operand = 10
  $A099  E9 4E A0 08                CALL_abs_imm1          $A04E (is_unit_at_coords) {bytecode}, $08
  $A09D  D8 A2 A0                   JUMPF_abs              $A0A2
  $A0A0  41                         LOADL_qimm   ; inline operand = 1
  $A0A1  CF                         RETURN
 >$A0A2  0B                         LOADL_quick   ; inline operand = 11
  $A0A3  D0                         INC
  $A0A4  2B                         STORE_quick   ; inline operand = 11
  $A0A5  0B                         LOADL_quick   ; inline operand = 11
  $A0A6  56                         LOADR_qimm   ; inline operand = 6
  $A0A7  C6                         UCMPLT
  $A0A8  D7 81 A0                   JUMPT_abs              $A081
  $A0AB  40                         LOADL_qimm   ; inline operand = 0
  $A0AC  CF                         RETURN

; ============================================================
; sub $A0AD   (frame_off=-2, body @ $A0B2)
; ============================================================
  $A0B2  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $A0B5  51                         LOADR_qimm   ; inline operand = 1
  $A0B6  DC                         XOR
  $A0B7  2B                         STORE_quick   ; inline operand = 11
  $A0B8  3C                         PUSH_quick   ; inline operand = 12
  $A0B9  3B                         PUSH_quick   ; inline operand = 11
  $A0BA  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $A0BE  D8 D4 A0                   JUMPF_abs              $A0D4
  $A0C1  3C                         PUSH_quick   ; inline operand = 12
  $A0C2  3B                         PUSH_quick   ; inline operand = 11
  $A0C3  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $A0C6  D3                         BYTE_DEREF
  $A0C7  B3                         PUSHL
  $A0C8  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $A0CB  D3                         BYTE_DEREF
  $A0CC  B3                         PUSHL
  $A0CD  E9 7A A0 08                CALL_abs_imm1          $A07A (find_adjacent_unit_around_tile) {bytecode}, $08
  $A0D1  D7 D8 A0                   JUMPT_abs              $A0D8
 >$A0D4  40                         LOADL_qimm   ; inline operand = 0
  $A0D5  D6 D9 A0                   JUMP_abs               $A0D9
 >$A0D8  41                         LOADL_qimm   ; inline operand = 1
 >$A0D9  CF                         RETURN

; ============================================================
; sub $A0DA   (frame_off=+0, body @ $A0DF)
; ============================================================
  $A0DF  3C                         PUSH_quick   ; inline operand = 12
  $A0E0  E9 AD A0 02                CALL_abs_imm1          $A0AD (enemy_unit_type_present_at_unit_tile) {bytecode}, $02
  $A0E4  D8 F2 A0                   JUMPF_abs              $A0F2
  $A0E7  3C                         PUSH_quick   ; inline operand = 12
  $A0E8  3C                         PUSH_quick   ; inline operand = 12
  $A0E9  E9 20 9E 02                CALL_abs_imm1          $9E20 (tally_unit_type_then_check_strength_parity_50) {bytecode}, $02
  $A0ED  B3                         PUSHL
  $A0EE  E9 F6 94 04                CALL_abs_imm1          $94F6 (announce_combat_side_daimyo_and_status) {bytecode}, $04
 >$A0F2  CF                         RETURN

; ============================================================
; sub $A0F3   (frame_off=-10, body @ $A0F8)
; ============================================================
  $A0F8  0E                         LOADL_quick   ; inline operand = 14
  $A0F9  27                         STORE_quick   ; inline operand = 7
  $A0FA  40                         LOADL_qimm   ; inline operand = 0
  $A0FB  2B                         STORE_quick   ; inline operand = 11
  $A0FC  D6 40 A1                   JUMP_abs               $A140
 >$A0FF  37                         PUSH_quick   ; inline operand = 7
  $A100  89 FF                      BYTE_LOADL_imm1        -1
  $A102  D4                         BYTE_POPSTORE
  $A103  0C                         LOADL_quick   ; inline operand = 12
  $A104  29                         STORE_quick   ; inline operand = 9
  $A105  0D                         LOADL_quick   ; inline operand = 13
  $A106  28                         STORE_quick   ; inline operand = 8
  $A107  3B                         PUSH_quick   ; inline operand = 11
  $A108  DE F8 FF                   LEAL_far               $FFF8
  $A10B  B3                         PUSHL
  $A10C  DE FA FF                   LEAL_far               $FFFA
  $A10F  B3                         PUSHL
  $A110  E9 03 80 06                CALL_abs_imm1          $8003 {native}, $06
  $A114  D8 38 A1                   JUMPF_abs              $A138
  $A117  40                         LOADL_qimm   ; inline operand = 0
  $A118  2A                         STORE_quick   ; inline operand = 10
 >$A119  3A                         PUSH_quick   ; inline operand = 10
  $A11A  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $A11D  51                         LOADR_qimm   ; inline operand = 1
  $A11E  DC                         XOR
  $A11F  B3                         PUSHL
  $A120  38                         PUSH_quick   ; inline operand = 8
  $A121  39                         PUSH_quick   ; inline operand = 9
  $A122  E9 4E A0 08                CALL_abs_imm1          $A04E (is_unit_at_coords) {bytecode}, $08
  $A126  D8 2F A1                   JUMPF_abs              $A12F
  $A129  37                         PUSH_quick   ; inline operand = 7
  $A12A  0A                         LOADL_quick   ; inline operand = 10
  $A12B  D4                         BYTE_POPSTORE
  $A12C  D6 38 A1                   JUMP_abs               $A138
 >$A12F  0A                         LOADL_quick   ; inline operand = 10
  $A130  D0                         INC
  $A131  2A                         STORE_quick   ; inline operand = 10
  $A132  0A                         LOADL_quick   ; inline operand = 10
  $A133  55                         LOADR_qimm   ; inline operand = 5
  $A134  C6                         UCMPLT
  $A135  D7 19 A1                   JUMPT_abs              $A119
 >$A138  07                         LOADL_quick   ; inline operand = 7
  $A139  D0                         INC
  $A13A  27                         STORE_quick   ; inline operand = 7
  $A13B  D1                         DEC
  $A13C  0B                         LOADL_quick   ; inline operand = 11
  $A13D  D0                         INC
  $A13E  2B                         STORE_quick   ; inline operand = 11
  $A13F  D1                         DEC
 >$A140  0B                         LOADL_quick   ; inline operand = 11
  $A141  56                         LOADR_qimm   ; inline operand = 6
  $A142  C6                         UCMPLT
  $A143  D7 FF A0                   JUMPT_abs              $A0FF
  $A146  0E                         LOADL_quick   ; inline operand = 14
  $A147  CF                         RETURN

; ============================================================
; sub $A148   (frame_off=-4, body @ $A14D)
; ============================================================
  $A14D  8A FF 00                   LOADL_imm2             $00FF
  $A150  2A                         STORE_quick   ; inline operand = 10
  $A151  40                         LOADL_qimm   ; inline operand = 0
  $A152  2B                         STORE_quick   ; inline operand = 11
  $A153  D6 8C A1                   JUMP_abs               $A18C
 >$A156  0C                         LOADL_quick   ; inline operand = 12
  $A157  D3                         BYTE_DEREF
  $A158  55                         LOADR_qimm   ; inline operand = 5
  $A159  C2                         SCMPLT
  $A15A  D8 84 A1                   JUMPF_abs              $A184
  $A15D  0A                         LOADL_quick   ; inline operand = 10
  $A15E  55                         LOADR_qimm   ; inline operand = 5
  $A15F  C6                         UCMPLT
  $A160  D8 75 A1                   JUMPF_abs              $A175
  $A163  0A                         LOADL_quick   ; inline operand = 10
  $A164  8C EE 7B                   LOADR_imm2             $7BEE
  $A167  BB                         ADD
  $A168  D3                         BYTE_DEREF
  $A169  B3                         PUSHL
  $A16A  0C                         LOADL_quick   ; inline operand = 12
  $A16B  D3                         BYTE_DEREF
  $A16C  8C EE 7B                   LOADR_imm2             $7BEE
  $A16F  BB                         ADD
  $A170  D3                         BYTE_DEREF
  $A171  B4                         POPR
  $A172  D6 7D A1                   JUMP_abs               $A17D
 >$A175  0C                         LOADL_quick   ; inline operand = 12
  $A176  D3                         BYTE_DEREF
  $A177  8C EE 7B                   LOADR_imm2             $7BEE
  $A17A  BB                         ADD
  $A17B  D3                         BYTE_DEREF
  $A17C  50                         LOADR_qimm   ; inline operand = 0
 >$A17D  C4                         SCMPGT
  $A17E  D8 84 A1                   JUMPF_abs              $A184
  $A181  0C                         LOADL_quick   ; inline operand = 12
  $A182  D3                         BYTE_DEREF
  $A183  2A                         STORE_quick   ; inline operand = 10
 >$A184  0C                         LOADL_quick   ; inline operand = 12
  $A185  D0                         INC
  $A186  2C                         STORE_quick   ; inline operand = 12
  $A187  D1                         DEC
  $A188  0B                         LOADL_quick   ; inline operand = 11
  $A189  D0                         INC
  $A18A  2B                         STORE_quick   ; inline operand = 11
  $A18B  D1                         DEC
 >$A18C  0B                         LOADL_quick   ; inline operand = 11
  $A18D  56                         LOADR_qimm   ; inline operand = 6
  $A18E  C6                         UCMPLT
  $A18F  D7 56 A1                   JUMPT_abs              $A156
  $A192  0A                         LOADL_quick   ; inline operand = 10
  $A193  CF                         RETURN

; ============================================================
; sub $A194   (frame_off=-18, body @ $A199)
; ============================================================
  $A199  40                         LOADL_qimm   ; inline operand = 0
  $A19A  25                         STORE_quick   ; inline operand = 5
 >$A19B  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $A19E  D3                         BYTE_DEREF
  $A19F  27                         STORE_quick   ; inline operand = 7
  $A1A0  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $A1A3  D3                         BYTE_DEREF
  $A1A4  26                         STORE_quick   ; inline operand = 6
  $A1A5  35                         PUSH_quick   ; inline operand = 5
  $A1A6  DE F4 FF                   LEAL_far               $FFF4
  $A1A9  B3                         PUSHL
  $A1AA  DE F6 FF                   LEAL_far               $FFF6
  $A1AD  B3                         PUSHL
  $A1AE  E9 03 80 06                CALL_abs_imm1          $8003 {native}, $06
  $A1B2  D8 E5 A1                   JUMPF_abs              $A1E5
  $A1B5  DE FA FF                   LEAL_far               $FFFA
  $A1B8  B3                         PUSHL
  $A1B9  36                         PUSH_quick   ; inline operand = 6
  $A1BA  37                         PUSH_quick   ; inline operand = 7
  $A1BB  E9 F3 A0 06                CALL_abs_imm1          $A0F3 (build_reachable_enemy_target_list) {bytecode}, $06
  $A1BF  28                         STORE_quick   ; inline operand = 8
  $A1C0  40                         LOADL_qimm   ; inline operand = 0
  $A1C1  24                         STORE_quick   ; inline operand = 4
 >$A1C2  08                         LOADL_quick   ; inline operand = 8
  $A1C3  D0                         INC
  $A1C4  28                         STORE_quick   ; inline operand = 8
  $A1C5  D1                         DEC
  $A1C6  D3                         BYTE_DEREF
  $A1C7  55                         LOADR_qimm   ; inline operand = 5
  $A1C8  C2                         SCMPLT
  $A1C9  D7 D5 A1                   JUMPT_abs              $A1D5
  $A1CC  04                         LOADL_quick   ; inline operand = 4
  $A1CD  D0                         INC
  $A1CE  24                         STORE_quick   ; inline operand = 4
  $A1CF  04                         LOADL_quick   ; inline operand = 4
  $A1D0  56                         LOADR_qimm   ; inline operand = 6
  $A1D1  C6                         UCMPLT
  $A1D2  D7 C2 A1                   JUMPT_abs              $A1C2
 >$A1D5  04                         LOADL_quick   ; inline operand = 4
  $A1D6  56                         LOADR_qimm   ; inline operand = 6
  $A1D7  C9                         UCMPGE
  $A1D8  D8 E5 A1                   JUMPF_abs              $A1E5
  $A1DB  36                         PUSH_quick   ; inline operand = 6
  $A1DC  37                         PUSH_quick   ; inline operand = 7
  $A1DD  E9 58 90 04                CALL_abs_imm1          $9058 (place_unit_at_tile_if_free) {bytecode}, $04
  $A1E1  D8 E5 A1                   JUMPF_abs              $A1E5
  $A1E4  CF                         RETURN
 >$A1E5  05                         LOADL_quick   ; inline operand = 5
  $A1E6  D0                         INC
  $A1E7  25                         STORE_quick   ; inline operand = 5
  $A1E8  05                         LOADL_quick   ; inline operand = 5
  $A1E9  56                         LOADR_qimm   ; inline operand = 6
  $A1EA  C6                         UCMPLT
  $A1EB  D7 9B A1                   JUMPT_abs              $A19B
  $A1EE  CF                         RETURN

; ============================================================
; sub $A1EF   (frame_off=+0, body @ $A1F4)
; ============================================================
  $A1F4  3C                         PUSH_quick   ; inline operand = 12
  $A1F5  E9 AD A0 02                CALL_abs_imm1          $A0AD (enemy_unit_type_present_at_unit_tile) {bytecode}, $02
  $A1F9  D8 1F A2                   JUMPF_abs              $A21F
  $A1FC  0C                         LOADL_quick   ; inline operand = 12
  $A1FD  D8 18 A2                   JUMPF_abs              $A218
  $A200  3C                         PUSH_quick   ; inline operand = 12
  $A201  E9 9A 9D 02                CALL_abs_imm1          $9D9A (ai_battle_strength_ratio_below_50) {bytecode}, $02
  $A205  D8 18 A2                   JUMPF_abs              $A218
  $A208  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $A20B  D8 1F A2                   JUMPF_abs              $A21F
  $A20E  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A211  E9 6A 83 02                CALL_abs_imm1          $836A (unit_damage_within_strength) {bytecode}, $02
  $A215  D7 1F A2                   JUMPT_abs              $A21F
 >$A218  3C                         PUSH_quick   ; inline operand = 12
  $A219  E9 DA A0 02                CALL_abs_imm1          $A0DA (eval_and_announce_battle_strength_parity_if_enemy_present) {bytecode}, $02
  $A21D  41                         LOADL_qimm   ; inline operand = 1
  $A21E  CF                         RETURN
 >$A21F  40                         LOADL_qimm   ; inline operand = 0
  $A220  CF                         RETURN

; ============================================================
; sub $A221   (frame_off=-209, body @ $A226)
; ============================================================
  $A226  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $A229  D3                         BYTE_DEREF
  $A22A  25                         STORE_quick   ; inline operand = 5
  $A22B  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $A22E  D3                         BYTE_DEREF
  $A22F  24                         STORE_quick   ; inline operand = 4
  $A230  05                         LOADL_quick   ; inline operand = 5
  $A231  1C                         LOADR_quick   ; inline operand = 12
  $A232  C0                         CMPEQ
  $A233  D8 3E A2                   JUMPF_abs              $A23E
  $A236  04                         LOADL_quick   ; inline operand = 4
  $A237  1D                         LOADR_quick   ; inline operand = 13
  $A238  C0                         CMPEQ
  $A239  D8 3E A2                   JUMPF_abs              $A23E
  $A23C  40                         LOADL_qimm   ; inline operand = 0
  $A23D  CF                         RETURN
 >$A23E  8A FF 00                   LOADL_imm2             $00FF
  $A241  2A                         STORE_quick   ; inline operand = 10
 >$A242  DE 2F FF                   LEAL_far               $FF2F
  $A245  23                         STORE_quick   ; inline operand = 3
  $A246  40                         LOADL_qimm   ; inline operand = 0
  $A247  28                         STORE_quick   ; inline operand = 8
 >$A248  40                         LOADL_qimm   ; inline operand = 0
  $A249  29                         STORE_quick   ; inline operand = 9
 >$A24A  03                         LOADL_quick   ; inline operand = 3
  $A24B  D0                         INC
  $A24C  23                         STORE_quick   ; inline operand = 3
  $A24D  D1                         DEC
  $A24E  B3                         PUSHL
  $A24F  38                         PUSH_quick   ; inline operand = 8
  $A250  39                         PUSH_quick   ; inline operand = 9
  $A251  E9 88 DC 04                CALL_abs_imm1          $DC88 (read_map_cell) {bytecode}, $04
  $A255  8C C2 00                   LOADR_imm2             $00C2
  $A258  DA                         AND
  $A259  D8 62 A2                   JUMPF_abs              $A262
  $A25C  8A 80 00                   LOADL_imm2             $0080 (skip_vblank_wait)
  $A25F  D6 63 A2                   JUMP_abs               $A263
 >$A262  40                         LOADL_qimm   ; inline operand = 0
 >$A263  D4                         BYTE_POPSTORE
  $A264  09                         LOADL_quick   ; inline operand = 9
  $A265  D0                         INC
  $A266  29                         STORE_quick   ; inline operand = 9
  $A267  09                         LOADL_quick   ; inline operand = 9
  $A268  5B                         LOADR_qimm   ; inline operand = 11
  $A269  C6                         UCMPLT
  $A26A  D7 4A A2                   JUMPT_abs              $A24A
  $A26D  08                         LOADL_quick   ; inline operand = 8
  $A26E  D0                         INC
  $A26F  28                         STORE_quick   ; inline operand = 8
  $A270  08                         LOADL_quick   ; inline operand = 8
  $A271  55                         LOADR_qimm   ; inline operand = 5
  $A272  C6                         UCMPLT
  $A273  D7 48 A2                   JUMPT_abs              $A248
  $A276  0A                         LOADL_quick   ; inline operand = 10
  $A277  8C FF 00                   LOADR_imm2             $00FF
  $A27A  C0                         CMPEQ
  $A27B  D8 B5 A2                   JUMPF_abs              $A2B5
  $A27E  40                         LOADL_qimm   ; inline operand = 0
  $A27F  2B                         STORE_quick   ; inline operand = 11
 >$A280  3B                         PUSH_quick   ; inline operand = 11
  $A281  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A284  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $A288  D8 AC A2                   JUMPF_abs              $A2AC
  $A28B  DE 2F FF                   LEAL_far               $FF2F
  $A28E  B3                         PUSHL
  $A28F  3B                         PUSH_quick   ; inline operand = 11
  $A290  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A293  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $A297  D3                         BYTE_DEREF
  $A298  B3                         PUSHL
  $A299  3B                         PUSH_quick   ; inline operand = 11
  $A29A  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A29D  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $A2A1  D3                         BYTE_DEREF
  $A2A2  5B                         LOADR_qimm   ; inline operand = 11
  $A2A3  B5                         MULT
  $A2A4  B4                         POPR
  $A2A5  BB                         ADD
  $A2A6  B4                         POPR
  $A2A7  BB                         ADD
  $A2A8  B3                         PUSHL
  $A2A9  89 80                      BYTE_LOADL_imm1        -128
  $A2AB  D4                         BYTE_POPSTORE
 >$A2AC  0B                         LOADL_quick   ; inline operand = 11
  $A2AD  D0                         INC
  $A2AE  2B                         STORE_quick   ; inline operand = 11
  $A2AF  0B                         LOADL_quick   ; inline operand = 11
  $A2B0  55                         LOADR_qimm   ; inline operand = 5
  $A2B1  C6                         UCMPLT
  $A2B2  D7 80 A2                   JUMPT_abs              $A280
 >$A2B5  DE 2F FF                   LEAL_far               $FF2F
  $A2B8  B3                         PUSHL
  $A2B9  0D                         LOADL_quick   ; inline operand = 13
  $A2BA  5B                         LOADR_qimm   ; inline operand = 11
  $A2BB  B5                         MULT
  $A2BC  1C                         LOADR_quick   ; inline operand = 12
  $A2BD  BB                         ADD
  $A2BE  B4                         POPR
  $A2BF  BB                         ADD
  $A2C0  B3                         PUSHL
  $A2C1  89 FF                      BYTE_LOADL_imm1        -1
  $A2C3  D4                         BYTE_POPSTORE
  $A2C4  DE 66 FF                   LEAL_far               $FF66
  $A2C7  22                         STORE_quick   ; inline operand = 2
  $A2C8  23                         STORE_quick   ; inline operand = 3
  $A2C9  02                         LOADL_quick   ; inline operand = 2
  $A2CA  D0                         INC
  $A2CB  22                         STORE_quick   ; inline operand = 2
  $A2CC  D1                         DEC
  $A2CD  B3                         PUSHL
  $A2CE  0C                         LOADL_quick   ; inline operand = 12
  $A2CF  D4                         BYTE_POPSTORE
  $A2D0  02                         LOADL_quick   ; inline operand = 2
  $A2D1  D0                         INC
  $A2D2  22                         STORE_quick   ; inline operand = 2
  $A2D3  D1                         DEC
  $A2D4  B3                         PUSHL
  $A2D5  0D                         LOADL_quick   ; inline operand = 13
  $A2D6  D4                         BYTE_POPSTORE
  $A2D7  02                         LOADL_quick   ; inline operand = 2
  $A2D8  D0                         INC
  $A2D9  22                         STORE_quick   ; inline operand = 2
  $A2DA  D1                         DEC
  $A2DB  B3                         PUSHL
  $A2DC  89 FF                      BYTE_LOADL_imm1        -1
  $A2DE  D4                         BYTE_POPSTORE
 >$A2DF  03                         LOADL_quick   ; inline operand = 3
  $A2E0  D0                         INC
  $A2E1  23                         STORE_quick   ; inline operand = 3
  $A2E2  D1                         DEC
  $A2E3  D3                         BYTE_DEREF
  $A2E4  27                         STORE_quick   ; inline operand = 7
  $A2E5  8C FF 00                   LOADR_imm2             $00FF
  $A2E8  C0                         CMPEQ
  $A2E9  D8 18 A3                   JUMPF_abs              $A318
  $A2EC  DE EB FF                   LEAL_far               $FFEB
  $A2EF  13                         LOADR_quick   ; inline operand = 3
  $A2F0  C0                         CMPEQ
  $A2F1  D8 F8 A2                   JUMPF_abs              $A2F8
  $A2F4  DE 66 FF                   LEAL_far               $FF66
  $A2F7  23                         STORE_quick   ; inline operand = 3
 >$A2F8  03                         LOADL_quick   ; inline operand = 3
  $A2F9  12                         LOADR_quick   ; inline operand = 2
  $A2FA  C0                         CMPEQ
  $A2FB  D7 AF A3                   JUMPT_abs              $A3AF
  $A2FE  02                         LOADL_quick   ; inline operand = 2
  $A2FF  D0                         INC
  $A300  22                         STORE_quick   ; inline operand = 2
  $A301  D1                         DEC
  $A302  B3                         PUSHL
  $A303  89 FF                      BYTE_LOADL_imm1        -1
  $A305  D4                         BYTE_POPSTORE
  $A306  DE EB FF                   LEAL_far               $FFEB
  $A309  12                         LOADR_quick   ; inline operand = 2
  $A30A  C0                         CMPEQ
  $A30B  D8 12 A3                   JUMPF_abs              $A312
  $A30E  DE 66 FF                   LEAL_far               $FF66
  $A311  22                         STORE_quick   ; inline operand = 2
 >$A312  03                         LOADL_quick   ; inline operand = 3
  $A313  D0                         INC
  $A314  23                         STORE_quick   ; inline operand = 3
  $A315  D1                         DEC
  $A316  D3                         BYTE_DEREF
  $A317  27                         STORE_quick   ; inline operand = 7
 >$A318  DE EB FF                   LEAL_far               $FFEB
  $A31B  13                         LOADR_quick   ; inline operand = 3
  $A31C  C0                         CMPEQ
  $A31D  D8 24 A3                   JUMPF_abs              $A324
  $A320  DE 66 FF                   LEAL_far               $FF66
  $A323  23                         STORE_quick   ; inline operand = 3
 >$A324  03                         LOADL_quick   ; inline operand = 3
  $A325  D0                         INC
  $A326  23                         STORE_quick   ; inline operand = 3
  $A327  D1                         DEC
  $A328  D3                         BYTE_DEREF
  $A329  26                         STORE_quick   ; inline operand = 6
  $A32A  DE EB FF                   LEAL_far               $FFEB
  $A32D  13                         LOADR_quick   ; inline operand = 3
  $A32E  C0                         CMPEQ
  $A32F  D8 36 A3                   JUMPF_abs              $A336
  $A332  DE 66 FF                   LEAL_far               $FF66
  $A335  23                         STORE_quick   ; inline operand = 3
 >$A336  40                         LOADL_qimm   ; inline operand = 0
  $A337  2B                         STORE_quick   ; inline operand = 11
 >$A338  07                         LOADL_quick   ; inline operand = 7
  $A339  29                         STORE_quick   ; inline operand = 9
  $A33A  06                         LOADL_quick   ; inline operand = 6
  $A33B  28                         STORE_quick   ; inline operand = 8
  $A33C  3B                         PUSH_quick   ; inline operand = 11
  $A33D  DE F8 FF                   LEAL_far               $FFF8
  $A340  B3                         PUSHL
  $A341  DE FA FF                   LEAL_far               $FFFA
  $A344  B3                         PUSHL
  $A345  E9 03 80 06                CALL_abs_imm1          $8003 {native}, $06
  $A349  D8 A3 A3                   JUMPF_abs              $A3A3
  $A34C  09                         LOADL_quick   ; inline operand = 9
  $A34D  15                         LOADR_quick   ; inline operand = 5
  $A34E  C0                         CMPEQ
  $A34F  D8 5C A3                   JUMPF_abs              $A35C
  $A352  08                         LOADL_quick   ; inline operand = 8
  $A353  14                         LOADR_quick   ; inline operand = 4
  $A354  C0                         CMPEQ
  $A355  D8 5C A3                   JUMPF_abs              $A35C
  $A358  46                         LOADL_qimm   ; inline operand = 6
  $A359  1B                         LOADR_quick   ; inline operand = 11
  $A35A  BC                         SUB
  $A35B  CF                         RETURN
 >$A35C  DE 2F FF                   LEAL_far               $FF2F
  $A35F  B3                         PUSHL
  $A360  08                         LOADL_quick   ; inline operand = 8
  $A361  5B                         LOADR_qimm   ; inline operand = 11
  $A362  B5                         MULT
  $A363  19                         LOADR_quick   ; inline operand = 9
  $A364  BB                         ADD
  $A365  B4                         POPR
  $A366  BB                         ADD
  $A367  D3                         BYTE_DEREF
  $A368  8B 10                      BYTE_LOADR_imm1        +16
  $A36A  C2                         SCMPLT
  $A36B  D8 A3 A3                   JUMPF_abs              $A3A3
  $A36E  DE 2F FF                   LEAL_far               $FF2F
  $A371  B3                         PUSHL
  $A372  08                         LOADL_quick   ; inline operand = 8
  $A373  5B                         LOADR_qimm   ; inline operand = 11
  $A374  B5                         MULT
  $A375  19                         LOADR_quick   ; inline operand = 9
  $A376  BB                         ADD
  $A377  B4                         POPR
  $A378  BB                         ADD
  $A379  B3                         PUSHL
  $A37A  89 FF                      BYTE_LOADL_imm1        -1
  $A37C  D4                         BYTE_POPSTORE
  $A37D  02                         LOADL_quick   ; inline operand = 2
  $A37E  D0                         INC
  $A37F  22                         STORE_quick   ; inline operand = 2
  $A380  D1                         DEC
  $A381  B3                         PUSHL
  $A382  09                         LOADL_quick   ; inline operand = 9
  $A383  D4                         BYTE_POPSTORE
  $A384  DE EB FF                   LEAL_far               $FFEB
  $A387  12                         LOADR_quick   ; inline operand = 2
  $A388  C0                         CMPEQ
  $A389  D8 90 A3                   JUMPF_abs              $A390
  $A38C  DE 66 FF                   LEAL_far               $FF66
  $A38F  22                         STORE_quick   ; inline operand = 2
 >$A390  02                         LOADL_quick   ; inline operand = 2
  $A391  D0                         INC
  $A392  22                         STORE_quick   ; inline operand = 2
  $A393  D1                         DEC
  $A394  B3                         PUSHL
  $A395  08                         LOADL_quick   ; inline operand = 8
  $A396  D4                         BYTE_POPSTORE
  $A397  DE EB FF                   LEAL_far               $FFEB
  $A39A  12                         LOADR_quick   ; inline operand = 2
  $A39B  C0                         CMPEQ
  $A39C  D8 A3 A3                   JUMPF_abs              $A3A3
  $A39F  DE 66 FF                   LEAL_far               $FF66
  $A3A2  22                         STORE_quick   ; inline operand = 2
 >$A3A3  0B                         LOADL_quick   ; inline operand = 11
  $A3A4  D0                         INC
  $A3A5  2B                         STORE_quick   ; inline operand = 11
  $A3A6  0B                         LOADL_quick   ; inline operand = 11
  $A3A7  56                         LOADR_qimm   ; inline operand = 6
  $A3A8  C6                         UCMPLT
  $A3A9  D7 38 A3                   JUMPT_abs              $A338
  $A3AC  D6 DF A2                   JUMP_abs               $A2DF
 >$A3AF  41                         LOADL_qimm   ; inline operand = 1
  $A3B0  CD                         SWAP
  $A3B1  0A                         LOADL_quick   ; inline operand = 10
  $A3B2  BE                         URSHIFT
  $A3B3  2A                         STORE_quick   ; inline operand = 10
  $A3B4  0A                         LOADL_quick   ; inline operand = 10
  $A3B5  8B 7F                      BYTE_LOADR_imm1        +127
  $A3B7  C9                         UCMPGE
  $A3B8  D7 42 A2                   JUMPT_abs              $A242
  $A3BB  40                         LOADL_qimm   ; inline operand = 0
  $A3BC  CF                         RETURN

; ============================================================
; sub $A3BD   (frame_off=-2, body @ $A3C2)
; ============================================================
  $A3C2  3D                         PUSH_quick   ; inline operand = 13
  $A3C3  3C                         PUSH_quick   ; inline operand = 12
  $A3C4  E9 21 A2 04                CALL_abs_imm1          $A221 (bfs_path_distance_to_target) {bytecode}, $04
  $A3C8  2B                         STORE_quick   ; inline operand = 11
  $A3C9  50                         LOADR_qimm   ; inline operand = 0
  $A3CA  C8                         UCMPGT
  $A3CB  D8 F6 A3                   JUMPF_abs              $A3F6
  $A3CE  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $A3D1  D3                         BYTE_DEREF
  $A3D2  2C                         STORE_quick   ; inline operand = 12
  $A3D3  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $A3D6  D3                         BYTE_DEREF
  $A3D7  2D                         STORE_quick   ; inline operand = 13
  $A3D8  0B                         LOADL_quick   ; inline operand = 11
  $A3D9  D1                         DEC
  $A3DA  2B                         STORE_quick   ; inline operand = 11
  $A3DB  B3                         PUSHL
  $A3DC  DE 0D 00                   LEAL_far               $000D
  $A3DF  B3                         PUSHL
  $A3E0  DE 0B 00                   LEAL_far               $000B
  $A3E3  B3                         PUSHL
  $A3E4  E9 03 80 06                CALL_abs_imm1          $8003 {native}, $06
  $A3E8  D8 F6 A3                   JUMPF_abs              $A3F6
  $A3EB  3D                         PUSH_quick   ; inline operand = 13
  $A3EC  3C                         PUSH_quick   ; inline operand = 12
  $A3ED  E9 58 90 04                CALL_abs_imm1          $9058 (place_unit_at_tile_if_free) {bytecode}, $04
  $A3F1  D8 F6 A3                   JUMPF_abs              $A3F6
  $A3F4  41                         LOADL_qimm   ; inline operand = 1
  $A3F5  CF                         RETURN
 >$A3F6  40                         LOADL_qimm   ; inline operand = 0
  $A3F7  CF                         RETURN

; ============================================================
; sub $A3F8   (frame_off=-12, body @ $A3FD)
; ============================================================
  $A3FD  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $A400  D7 05 A4                   JUMPT_abs              $A405
  $A403  40                         LOADL_qimm   ; inline operand = 0
  $A404  CF                         RETURN
 >$A405  DE F6 FF                   LEAL_far               $FFF6
  $A408  B3                         PUSHL
  $A409  60                         PUSH_qimm   ; inline operand = 0
  $A40A  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A40D  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $A411  D3                         BYTE_DEREF
  $A412  B3                         PUSHL
  $A413  60                         PUSH_qimm   ; inline operand = 0
  $A414  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A417  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $A41B  D3                         BYTE_DEREF
  $A41C  B3                         PUSHL
  $A41D  E9 F3 A0 06                CALL_abs_imm1          $A0F3 (build_reachable_enemy_target_list) {bytecode}, $06
  $A421  26                         STORE_quick   ; inline operand = 6
  $A422  40                         LOADL_qimm   ; inline operand = 0
  $A423  2B                         STORE_quick   ; inline operand = 11
 >$A424  06                         LOADL_quick   ; inline operand = 6
  $A425  D3                         BYTE_DEREF
  $A426  55                         LOADR_qimm   ; inline operand = 5
  $A427  C2                         SCMPLT
  $A428  D8 39 A4                   JUMPF_abs              $A439
  $A42B  06                         LOADL_quick   ; inline operand = 6
  $A42C  D3                         BYTE_DEREF
  $A42D  B3                         PUSHL
  $A42E  E9 AD A0 02                CALL_abs_imm1          $A0AD (enemy_unit_type_present_at_unit_tile) {bytecode}, $02
  $A432  D7 39 A4                   JUMPT_abs              $A439
  $A435  36                         PUSH_quick   ; inline operand = 6
  $A436  89 FF                      BYTE_LOADL_imm1        -1
  $A438  D4                         BYTE_POPSTORE
 >$A439  06                         LOADL_quick   ; inline operand = 6
  $A43A  D0                         INC
  $A43B  26                         STORE_quick   ; inline operand = 6
  $A43C  D1                         DEC
  $A43D  0B                         LOADL_quick   ; inline operand = 11
  $A43E  D0                         INC
  $A43F  2B                         STORE_quick   ; inline operand = 11
  $A440  D1                         DEC
  $A441  0B                         LOADL_quick   ; inline operand = 11
  $A442  56                         LOADR_qimm   ; inline operand = 6
  $A443  C6                         UCMPLT
  $A444  D7 24 A4                   JUMPT_abs              $A424
  $A447  DE F6 FF                   LEAL_far               $FFF6
  $A44A  B3                         PUSHL
  $A44B  E9 48 A1 02                CALL_abs_imm1          $A148 (find_flagged_present_unit_type) {bytecode}, $02
  $A44F  2A                         STORE_quick   ; inline operand = 10
  $A450  55                         LOADR_qimm   ; inline operand = 5
  $A451  C9                         UCMPGE
  $A452  D8 AD A4                   JUMPF_abs              $A4AD
  $A455  DE F6 FF                   LEAL_far               $FFF6
  $A458  26                         STORE_quick   ; inline operand = 6
  $A459  40                         LOADL_qimm   ; inline operand = 0
  $A45A  2B                         STORE_quick   ; inline operand = 11
  $A45B  D6 7D A4                   JUMP_abs               $A47D
 >$A45E  06                         LOADL_quick   ; inline operand = 6
  $A45F  D3                         BYTE_DEREF
  $A460  55                         LOADR_qimm   ; inline operand = 5
  $A461  C2                         SCMPLT
  $A462  D8 75 A4                   JUMPF_abs              $A475
  $A465  06                         LOADL_quick   ; inline operand = 6
  $A466  D3                         BYTE_DEREF
  $A467  B3                         PUSHL
  $A468  E9 9A 9D 02                CALL_abs_imm1          $9D9A (ai_battle_strength_ratio_below_50) {bytecode}, $02
  $A46C  D7 75 A4                   JUMPT_abs              $A475
  $A46F  06                         LOADL_quick   ; inline operand = 6
  $A470  D3                         BYTE_DEREF
  $A471  2A                         STORE_quick   ; inline operand = 10
  $A472  D6 83 A4                   JUMP_abs               $A483
 >$A475  06                         LOADL_quick   ; inline operand = 6
  $A476  D0                         INC
  $A477  26                         STORE_quick   ; inline operand = 6
  $A478  D1                         DEC
  $A479  0B                         LOADL_quick   ; inline operand = 11
  $A47A  D0                         INC
  $A47B  2B                         STORE_quick   ; inline operand = 11
  $A47C  D1                         DEC
 >$A47D  0B                         LOADL_quick   ; inline operand = 11
  $A47E  56                         LOADR_qimm   ; inline operand = 6
  $A47F  C6                         UCMPLT
  $A480  D7 5E A4                   JUMPT_abs              $A45E
 >$A483  0A                         LOADL_quick   ; inline operand = 10
  $A484  55                         LOADR_qimm   ; inline operand = 5
  $A485  C9                         UCMPGE
  $A486  D8 AD A4                   JUMPF_abs              $A4AD
  $A489  DE F6 FF                   LEAL_far               $FFF6
  $A48C  26                         STORE_quick   ; inline operand = 6
  $A48D  40                         LOADL_qimm   ; inline operand = 0
  $A48E  2B                         STORE_quick   ; inline operand = 11
  $A48F  D6 A7 A4                   JUMP_abs               $A4A7
 >$A492  06                         LOADL_quick   ; inline operand = 6
  $A493  D3                         BYTE_DEREF
  $A494  55                         LOADR_qimm   ; inline operand = 5
  $A495  C2                         SCMPLT
  $A496  D8 9F A4                   JUMPF_abs              $A49F
  $A499  06                         LOADL_quick   ; inline operand = 6
  $A49A  D3                         BYTE_DEREF
  $A49B  2A                         STORE_quick   ; inline operand = 10
  $A49C  D6 AD A4                   JUMP_abs               $A4AD
 >$A49F  06                         LOADL_quick   ; inline operand = 6
  $A4A0  D0                         INC
  $A4A1  26                         STORE_quick   ; inline operand = 6
  $A4A2  D1                         DEC
  $A4A3  0B                         LOADL_quick   ; inline operand = 11
  $A4A4  D0                         INC
  $A4A5  2B                         STORE_quick   ; inline operand = 11
  $A4A6  D1                         DEC
 >$A4A7  0B                         LOADL_quick   ; inline operand = 11
  $A4A8  56                         LOADR_qimm   ; inline operand = 6
  $A4A9  C6                         UCMPLT
  $A4AA  D7 92 A4                   JUMPT_abs              $A492
 >$A4AD  0A                         LOADL_quick   ; inline operand = 10
  $A4AE  55                         LOADR_qimm   ; inline operand = 5
  $A4AF  C6                         UCMPLT
  $A4B0  D8 BA A4                   JUMPF_abs              $A4BA
  $A4B3  3A                         PUSH_quick   ; inline operand = 10
  $A4B4  E9 DA A0 02                CALL_abs_imm1          $A0DA (eval_and_announce_battle_strength_parity_if_enemy_present) {bytecode}, $02
  $A4B8  41                         LOADL_qimm   ; inline operand = 1
  $A4B9  CF                         RETURN
 >$A4BA  40                         LOADL_qimm   ; inline operand = 0
  $A4BB  CF                         RETURN

; ============================================================
; sub $A4BC   (frame_off=-8, body @ $A4C1)
; ============================================================
  $A4C1  40                         LOADL_qimm   ; inline operand = 0
  $A4C2  2A                         STORE_quick   ; inline operand = 10
  $A4C3  29                         STORE_quick   ; inline operand = 9
  $A4C4  D6 E8 A4                   JUMP_abs               $A4E8
 >$A4C7  0C                         LOADL_quick   ; inline operand = 12
  $A4C8  D3                         BYTE_DEREF
  $A4C9  55                         LOADR_qimm   ; inline operand = 5
  $A4CA  C2                         SCMPLT
  $A4CB  D8 E0 A4                   JUMPF_abs              $A4E0
  $A4CE  0C                         LOADL_quick   ; inline operand = 12
  $A4CF  D3                         BYTE_DEREF
  $A4D0  B3                         PUSHL
  $A4D1  E9 75 9D 02                CALL_abs_imm1          $9D75 (calc_battle_strength_pct_one_side) {bytecode}, $02
  $A4D5  28                         STORE_quick   ; inline operand = 8
  $A4D6  19                         LOADR_quick   ; inline operand = 9
  $A4D7  C4                         SCMPGT
  $A4D8  D8 E0 A4                   JUMPF_abs              $A4E0
  $A4DB  08                         LOADL_quick   ; inline operand = 8
  $A4DC  29                         STORE_quick   ; inline operand = 9
  $A4DD  0C                         LOADL_quick   ; inline operand = 12
  $A4DE  D3                         BYTE_DEREF
  $A4DF  2B                         STORE_quick   ; inline operand = 11
 >$A4E0  0C                         LOADL_quick   ; inline operand = 12
  $A4E1  D0                         INC
  $A4E2  2C                         STORE_quick   ; inline operand = 12
  $A4E3  D1                         DEC
  $A4E4  0A                         LOADL_quick   ; inline operand = 10
  $A4E5  D0                         INC
  $A4E6  2A                         STORE_quick   ; inline operand = 10
  $A4E7  D1                         DEC
 >$A4E8  0A                         LOADL_quick   ; inline operand = 10
  $A4E9  56                         LOADR_qimm   ; inline operand = 6
  $A4EA  C6                         UCMPLT
  $A4EB  D7 C7 A4                   JUMPT_abs              $A4C7
  $A4EE  09                         LOADL_quick   ; inline operand = 9
  $A4EF  1D                         LOADR_quick   ; inline operand = 13
  $A4F0  C2                         SCMPLT
  $A4F1  D8 FA A4                   JUMPF_abs              $A4FA
  $A4F4  8A FF 00                   LOADL_imm2             $00FF
  $A4F7  D6 FB A4                   JUMP_abs               $A4FB
 >$A4FA  0B                         LOADL_quick   ; inline operand = 11
 >$A4FB  CF                         RETURN

; ============================================================
; sub $A4FC   (frame_off=-6, body @ $A501)
; ============================================================
  $A501  89 64                      BYTE_LOADL_imm1        +100
  $A503  2A                         STORE_quick   ; inline operand = 10
  $A504  40                         LOADL_qimm   ; inline operand = 0
  $A505  2B                         STORE_quick   ; inline operand = 11
  $A506  D6 27 A5                   JUMP_abs               $A527
 >$A509  0C                         LOADL_quick   ; inline operand = 12
  $A50A  D3                         BYTE_DEREF
  $A50B  55                         LOADR_qimm   ; inline operand = 5
  $A50C  C2                         SCMPLT
  $A50D  D8 1F A5                   JUMPF_abs              $A51F
  $A510  0C                         LOADL_quick   ; inline operand = 12
  $A511  D3                         BYTE_DEREF
  $A512  B3                         PUSHL
  $A513  E9 75 9D 02                CALL_abs_imm1          $9D75 (calc_battle_strength_pct_one_side) {bytecode}, $02
  $A517  29                         STORE_quick   ; inline operand = 9
  $A518  1A                         LOADR_quick   ; inline operand = 10
  $A519  C6                         UCMPLT
  $A51A  D8 1F A5                   JUMPF_abs              $A51F
  $A51D  09                         LOADL_quick   ; inline operand = 9
  $A51E  2A                         STORE_quick   ; inline operand = 10
 >$A51F  0C                         LOADL_quick   ; inline operand = 12
  $A520  D0                         INC
  $A521  2C                         STORE_quick   ; inline operand = 12
  $A522  D1                         DEC
  $A523  0B                         LOADL_quick   ; inline operand = 11
  $A524  D0                         INC
  $A525  2B                         STORE_quick   ; inline operand = 11
  $A526  D1                         DEC
 >$A527  0B                         LOADL_quick   ; inline operand = 11
  $A528  56                         LOADR_qimm   ; inline operand = 6
  $A529  C6                         UCMPLT
  $A52A  D7 09 A5                   JUMPT_abs              $A509
  $A52D  0A                         LOADL_quick   ; inline operand = 10
  $A52E  CF                         RETURN

; ============================================================
; sub $A52F   (frame_off=-10, body @ $A534)
; ============================================================
  $A534  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $A537  E9 1A A0 02                CALL_abs_imm1          $A01A (unit_type_count_gt3_and_equals_arg1) {bytecode}, $02
  $A53B  D7 44 A5                   JUMPT_abs              $A544
  $A53E  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $A541  D7 48 A5                   JUMPT_abs              $A548
 >$A544  40                         LOADL_qimm   ; inline operand = 0
  $A545  D6 4A A5                   JUMP_abs               $A54A
 >$A548  89 32                      BYTE_LOADL_imm1        +50
 >$A54A  27                         STORE_quick   ; inline operand = 7
  $A54B  DE F8 FF                   LEAL_far               $FFF8
  $A54E  B3                         PUSHL
  $A54F  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $A552  D3                         BYTE_DEREF
  $A553  B3                         PUSHL
  $A554  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $A557  D3                         BYTE_DEREF
  $A558  B3                         PUSHL
  $A559  E9 F3 A0 06                CALL_abs_imm1          $A0F3 (build_reachable_enemy_target_list) {bytecode}, $06
  $A55D  B3                         PUSHL
  $A55E  E9 48 A1 02                CALL_abs_imm1          $A148 (find_flagged_present_unit_type) {bytecode}, $02
  $A562  2B                         STORE_quick   ; inline operand = 11
  $A563  55                         LOADR_qimm   ; inline operand = 5
  $A564  C9                         UCMPGE
  $A565  D8 72 A5                   JUMPF_abs              $A572
  $A568  37                         PUSH_quick   ; inline operand = 7
  $A569  DE F8 FF                   LEAL_far               $FFF8
  $A56C  B3                         PUSHL
  $A56D  E9 BC A4 04                CALL_abs_imm1          $A4BC (find_strongest_unit_type_by_strength) {bytecode}, $04
  $A571  2B                         STORE_quick   ; inline operand = 11
 >$A572  0B                         LOADL_quick   ; inline operand = 11
  $A573  55                         LOADR_qimm   ; inline operand = 5
  $A574  C6                         UCMPLT
  $A575  D8 7E A5                   JUMPF_abs              $A57E
  $A578  3B                         PUSH_quick   ; inline operand = 11
  $A579  E9 DA A0 02                CALL_abs_imm1          $A0DA (eval_and_announce_battle_strength_parity_if_enemy_present) {bytecode}, $02
  $A57D  CF                         RETURN
 >$A57E  60                         PUSH_qimm   ; inline operand = 0
  $A57F  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A582  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $A585  D3                         BYTE_DEREF
  $A586  B3                         PUSHL
  $A587  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $A58A  D3                         BYTE_DEREF
  $A58B  B3                         PUSHL
  $A58C  E9 7A A0 08                CALL_abs_imm1          $A07A (find_adjacent_unit_around_tile) {bytecode}, $08
  $A590  D7 A3 A5                   JUMPT_abs              $A5A3
  $A593  DE F8 FF                   LEAL_far               $FFF8
  $A596  B3                         PUSHL
  $A597  E9 FC A4 02                CALL_abs_imm1          $A4FC (max_enemy_unit_type_strength_pct) {bytecode}, $02
  $A59B  17                         LOADR_quick   ; inline operand = 7
  $A59C  C8                         UCMPGT
  $A59D  D8 A3 A5                   JUMPF_abs              $A5A3
  $A5A0  AC 94 A1                   CALL_abs               $A194 (ai_place_units_near_enemy_loop) {bytecode}
 >$A5A3  CF                         RETURN

; ============================================================
; sub $A5A4   (frame_off=-12, body @ $A5A9)
; ============================================================
  $A5A9  AC F8 A3                   CALL_abs               $A3F8 (ai_select_weak_reachable_enemy_target) {bytecode}
  $A5AC  D8 B0 A5                   JUMPF_abs              $A5B0
  $A5AF  CF                         RETURN
 >$A5B0  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $A5B3  51                         LOADR_qimm   ; inline operand = 1
  $A5B4  DC                         XOR
  $A5B5  2A                         STORE_quick   ; inline operand = 10
  $A5B6  DE F6 FF                   LEAL_far               $FFF6
  $A5B9  B3                         PUSHL
  $A5BA  60                         PUSH_qimm   ; inline operand = 0
  $A5BB  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A5BE  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $A5C2  D3                         BYTE_DEREF
  $A5C3  B3                         PUSHL
  $A5C4  60                         PUSH_qimm   ; inline operand = 0
  $A5C5  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A5C8  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $A5CC  D3                         BYTE_DEREF
  $A5CD  B3                         PUSHL
  $A5CE  E9 F3 A0 06                CALL_abs_imm1          $A0F3 (build_reachable_enemy_target_list) {bytecode}, $06
  $A5D2  26                         STORE_quick   ; inline operand = 6
  $A5D3  40                         LOADL_qimm   ; inline operand = 0
  $A5D4  2B                         STORE_quick   ; inline operand = 11
 >$A5D5  06                         LOADL_quick   ; inline operand = 6
  $A5D6  D3                         BYTE_DEREF
  $A5D7  55                         LOADR_qimm   ; inline operand = 5
  $A5D8  C2                         SCMPLT
  $A5D9  D8 F8 A5                   JUMPF_abs              $A5F8
  $A5DC  06                         LOADL_quick   ; inline operand = 6
  $A5DD  D3                         BYTE_DEREF
  $A5DE  B3                         PUSHL
  $A5DF  3A                         PUSH_quick   ; inline operand = 10
  $A5E0  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $A5E4  D3                         BYTE_DEREF
  $A5E5  B3                         PUSHL
  $A5E6  06                         LOADL_quick   ; inline operand = 6
  $A5E7  D3                         BYTE_DEREF
  $A5E8  B3                         PUSHL
  $A5E9  3A                         PUSH_quick   ; inline operand = 10
  $A5EA  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $A5EE  D3                         BYTE_DEREF
  $A5EF  B3                         PUSHL
  $A5F0  E9 BD A3 04                CALL_abs_imm1          $A3BD (ai_step_unit_toward_target) {bytecode}, $04
  $A5F4  D8 F8 A5                   JUMPF_abs              $A5F8
  $A5F7  CF                         RETURN
 >$A5F8  06                         LOADL_quick   ; inline operand = 6
  $A5F9  D0                         INC
  $A5FA  26                         STORE_quick   ; inline operand = 6
  $A5FB  D1                         DEC
  $A5FC  0B                         LOADL_quick   ; inline operand = 11
  $A5FD  D0                         INC
  $A5FE  2B                         STORE_quick   ; inline operand = 11
  $A5FF  D1                         DEC
  $A600  0B                         LOADL_quick   ; inline operand = 11
  $A601  56                         LOADR_qimm   ; inline operand = 6
  $A602  C6                         UCMPLT
  $A603  D7 D5 A5                   JUMPT_abs              $A5D5
  $A606  60                         PUSH_qimm   ; inline operand = 0
  $A607  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A60A  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $A60E  D3                         BYTE_DEREF
  $A60F  B3                         PUSHL
  $A610  60                         PUSH_qimm   ; inline operand = 0
  $A611  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A614  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $A618  D3                         BYTE_DEREF
  $A619  B3                         PUSHL
  $A61A  E9 BD A3 04                CALL_abs_imm1          $A3BD (ai_step_unit_toward_target) {bytecode}, $04
  $A61E  D7 24 A6                   JUMPT_abs              $A624
  $A621  AC 2F A5                   CALL_abs               $A52F (ai_decide_unit_action_attack_or_advance) {bytecode}
 >$A624  CF                         RETURN

; ============================================================
; sub $A625   (frame_off=-14, body @ $A62A)
; ============================================================
  $A62A  AC F8 A3                   CALL_abs               $A3F8 (ai_select_weak_reachable_enemy_target) {bytecode}
  $A62D  D8 31 A6                   JUMPF_abs              $A631
  $A630  CF                         RETURN
 >$A631  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $A634  D3                         BYTE_DEREF
  $A635  28                         STORE_quick   ; inline operand = 8
  $A636  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $A639  D3                         BYTE_DEREF
  $A63A  27                         STORE_quick   ; inline operand = 7
  $A63B  40                         LOADL_qimm   ; inline operand = 0
  $A63C  25                         STORE_quick   ; inline operand = 5
  $A63D  40                         LOADL_qimm   ; inline operand = 0
  $A63E  D6 77 A6                   JUMP_abs               $A677
 >$A641  08                         LOADL_quick   ; inline operand = 8
  $A642  2A                         STORE_quick   ; inline operand = 10
  $A643  07                         LOADL_quick   ; inline operand = 7
  $A644  29                         STORE_quick   ; inline operand = 9
  $A645  3B                         PUSH_quick   ; inline operand = 11
  $A646  DE FA FF                   LEAL_far               $FFFA
  $A649  B3                         PUSHL
  $A64A  DE FC FF                   LEAL_far               $FFFC
  $A64D  B3                         PUSHL
  $A64E  E9 03 80 06                CALL_abs_imm1          $8003 {native}, $06
  $A652  D8 75 A6                   JUMPF_abs              $A675
  $A655  39                         PUSH_quick   ; inline operand = 9
  $A656  3A                         PUSH_quick   ; inline operand = 10
  $A657  E9 11 8F 04                CALL_abs_imm1          $8F11 (is_tile_in_bounds) {bytecode}, $04
  $A65B  D8 75 A6                   JUMPF_abs              $A675
  $A65E  39                         PUSH_quick   ; inline operand = 9
  $A65F  3A                         PUSH_quick   ; inline operand = 10
  $A660  E9 EC 8F 04                CALL_abs_imm1          $8FEC (find_unit_at_tile) {bytecode}, $04
  $A664  D7 75 A6                   JUMPT_abs              $A675
  $A667  39                         PUSH_quick   ; inline operand = 9
  $A668  3A                         PUSH_quick   ; inline operand = 10
  $A669  E9 19 90 04                CALL_abs_imm1          $9019 (test_map_cell_blocked_c2) {bytecode}, $04
  $A66D  D7 75 A6                   JUMPT_abs              $A675
  $A670  41                         LOADL_qimm   ; inline operand = 1
  $A671  25                         STORE_quick   ; inline operand = 5
  $A672  D6 7E A6                   JUMP_abs               $A67E
 >$A675  0B                         LOADL_quick   ; inline operand = 11
  $A676  D0                         INC
 >$A677  2B                         STORE_quick   ; inline operand = 11
  $A678  0B                         LOADL_quick   ; inline operand = 11
  $A679  56                         LOADR_qimm   ; inline operand = 6
  $A67A  C6                         UCMPLT
  $A67B  D7 41 A6                   JUMPT_abs              $A641
 >$A67E  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $A681  51                         LOADR_qimm   ; inline operand = 1
  $A682  DC                         XOR
  $A683  26                         STORE_quick   ; inline operand = 6
  $A684  40                         LOADL_qimm   ; inline operand = 0
  $A685  2B                         STORE_quick   ; inline operand = 11
 >$A686  3B                         PUSH_quick   ; inline operand = 11
  $A687  36                         PUSH_quick   ; inline operand = 6
  $A688  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $A68C  D8 B8 A6                   JUMPF_abs              $A6B8
  $A68F  05                         LOADL_quick   ; inline operand = 5
  $A690  D8 AF A6                   JUMPF_abs              $A6AF
  $A693  0B                         LOADL_quick   ; inline operand = 11
  $A694  D7 AF A6                   JUMPT_abs              $A6AF
  $A697  60                         PUSH_qimm   ; inline operand = 0
  $A698  36                         PUSH_quick   ; inline operand = 6
  $A699  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $A69D  D3                         BYTE_DEREF
  $A69E  B3                         PUSHL
  $A69F  60                         PUSH_qimm   ; inline operand = 0
  $A6A0  36                         PUSH_quick   ; inline operand = 6
  $A6A1  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $A6A5  D3                         BYTE_DEREF
  $A6A6  B3                         PUSHL
  $A6A7  E9 BD A3 04                CALL_abs_imm1          $A3BD (ai_step_unit_toward_target) {bytecode}, $04
  $A6AB  D8 AF A6                   JUMPF_abs              $A6AF
  $A6AE  CF                         RETURN
 >$A6AF  3B                         PUSH_quick   ; inline operand = 11
  $A6B0  E9 EF A1 02                CALL_abs_imm1          $A1EF (ai_engage_present_enemy_if_favorable) {bytecode}, $02
  $A6B4  D8 B8 A6                   JUMPF_abs              $A6B8
  $A6B7  CF                         RETURN
 >$A6B8  0B                         LOADL_quick   ; inline operand = 11
  $A6B9  D0                         INC
  $A6BA  2B                         STORE_quick   ; inline operand = 11
  $A6BB  0B                         LOADL_quick   ; inline operand = 11
  $A6BC  55                         LOADR_qimm   ; inline operand = 5
  $A6BD  C6                         UCMPLT
  $A6BE  D7 86 A6                   JUMPT_abs              $A686
  $A6C1  AC 2F A5                   CALL_abs               $A52F (ai_decide_unit_action_attack_or_advance) {bytecode}
  $A6C4  CF                         RETURN

; ============================================================
; sub $A6C5   (frame_off=-20, body @ $A6CA)
; ============================================================
  $A6CA  DE EE FF                   LEAL_far               $FFEE
  $A6CD  B3                         PUSHL
  $A6CE  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $A6D1  D3                         BYTE_DEREF
  $A6D2  B3                         PUSHL
  $A6D3  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $A6D6  D3                         BYTE_DEREF
  $A6D7  B3                         PUSHL
  $A6D8  E9 F3 A0 06                CALL_abs_imm1          $A0F3 (build_reachable_enemy_target_list) {bytecode}, $06
  $A6DC  B3                         PUSHL
  $A6DD  E9 FC A4 02                CALL_abs_imm1          $A4FC (max_enemy_unit_type_strength_pct) {bytecode}, $02
  $A6E1  22                         STORE_quick   ; inline operand = 2
  $A6E2  02                         LOADL_quick   ; inline operand = 2
  $A6E3  8B 14                      BYTE_LOADR_imm1        +20
  $A6E5  C6                         UCMPLT
  $A6E6  D7 F7 A6                   JUMPT_abs              $A6F7
  $A6E9  60                         PUSH_qimm   ; inline operand = 0
  $A6EA  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A6ED  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $A6F1  B0                         DEREF
  $A6F2  51                         LOADR_qimm   ; inline operand = 1
  $A6F3  C3                         SCMPLE
  $A6F4  D8 FB A6                   JUMPF_abs              $A6FB
 >$A6F7  AC 94 A1                   CALL_abs               $A194 (ai_place_units_near_enemy_loop) {bytecode}
  $A6FA  CF                         RETURN
 >$A6FB  8D 46                      BYTE_PUSH_imm1         +70
  $A6FD  DE EE FF                   LEAL_far               $FFEE
  $A700  B3                         PUSHL
  $A701  E9 BC A4 04                CALL_abs_imm1          $A4BC (find_strongest_unit_type_by_strength) {bytecode}, $04
  $A705  26                         STORE_quick   ; inline operand = 6
  $A706  55                         LOADR_qimm   ; inline operand = 5
  $A707  C6                         UCMPLT
  $A708  D8 11 A7                   JUMPF_abs              $A711
  $A70B  36                         PUSH_quick   ; inline operand = 6
  $A70C  E9 DA A0 02                CALL_abs_imm1          $A0DA (eval_and_announce_battle_strength_parity_if_enemy_present) {bytecode}, $02
  $A710  CF                         RETURN
 >$A711  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $A714  D7 20 A7                   JUMPT_abs              $A720
  $A717  0C                         LOADL_quick   ; inline operand = 12
  $A718  55                         LOADR_qimm   ; inline operand = 5
  $A719  C8                         UCMPGT
  $A71A  D8 20 A7                   JUMPF_abs              $A720
  $A71D  AC 25 A6                   CALL_abs               $A625 (ai_advance_units_into_free_adjacent_cells) {bytecode}
 >$A720  CF                         RETURN

; ============================================================
; sub $A721   (frame_off=-8, body @ $A726)
; ============================================================
  $A726  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $A729  51                         LOADR_qimm   ; inline operand = 1
  $A72A  DC                         XOR
  $A72B  28                         STORE_quick   ; inline operand = 8
  $A72C  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $A72F  D0                         INC
  $A730  B3                         PUSHL
  $A731  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A735  D8 99 A7                   JUMPF_abs              $A799
  $A738  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A73B  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $A73F  74                         ADD_qimm   ; inline operand = 4
  $A740  B0                         DEREF
  $A741  B3                         PUSHL
  $A742  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A745  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $A749  B0                         DEREF
  $A74A  B4                         POPR
  $A74B  C3                         SCMPLE
  $A74C  D7 99 A7                   JUMPT_abs              $A799
  $A74F  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $A752  D7 99 A7                   JUMPT_abs              $A799
  $A755  38                         PUSH_quick   ; inline operand = 8
  $A756  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $A75A  B3                         PUSHL
  $A75B  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $A75F  D8 99 A7                   JUMPF_abs              $A799
  $A762  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $A765  D7 99 A7                   JUMPT_abs              $A799
  $A768  38                         PUSH_quick   ; inline operand = 8
  $A769  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $A76D  74                         ADD_qimm   ; inline operand = 4
  $A76E  B0                         DEREF
  $A76F  52                         LOADR_qimm   ; inline operand = 2
  $A770  B6                         SDIV
  $A771  B3                         PUSHL
  $A772  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A775  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $A779  74                         ADD_qimm   ; inline operand = 4
  $A77A  B0                         DEREF
  $A77B  B4                         POPR
  $A77C  C4                         SCMPGT
  $A77D  D7 99 A7                   JUMPT_abs              $A799
  $A780  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $A783  8B 64                      BYTE_LOADR_imm1        +100
  $A785  B5                         MULT
  $A786  B3                         PUSHL
  $A787  38                         PUSH_quick   ; inline operand = 8
  $A788  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $A78C  8B 1A                      BYTE_LOADR_imm1        +26
  $A78E  B5                         MULT
  $A78F  8C 13 70                   LOADR_imm2             $7013
  $A792  BB                         ADD
  $A793  B0                         DEREF
  $A794  B4                         POPR
  $A795  C8                         UCMPGT
  $A796  D8 9A A7                   JUMPF_abs              $A79A
 >$A799  CF                         RETURN
 >$A79A  40                         LOADL_qimm   ; inline operand = 0
  $A79B  2A                         STORE_quick   ; inline operand = 10
  $A79C  29                         STORE_quick   ; inline operand = 9
  $A79D  D6 C4 A7                   JUMP_abs               $A7C4
 >$A7A0  3A                         PUSH_quick   ; inline operand = 10
  $A7A1  38                         PUSH_quick   ; inline operand = 8
  $A7A2  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $A7A6  D8 C1 A7                   JUMPF_abs              $A7C1
  $A7A9  3A                         PUSH_quick   ; inline operand = 10
  $A7AA  38                         PUSH_quick   ; inline operand = 8
  $A7AB  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $A7AF  B0                         DEREF
  $A7B0  B3                         PUSHL
  $A7B1  09                         LOADL_quick   ; inline operand = 9
  $A7B2  B4                         POPR
  $A7B3  C2                         SCMPLT
  $A7B4  D8 C1 A7                   JUMPF_abs              $A7C1
  $A7B7  0A                         LOADL_quick   ; inline operand = 10
  $A7B8  2B                         STORE_quick   ; inline operand = 11
  $A7B9  B3                         PUSHL
  $A7BA  38                         PUSH_quick   ; inline operand = 8
  $A7BB  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $A7BF  B0                         DEREF
  $A7C0  29                         STORE_quick   ; inline operand = 9
 >$A7C1  0A                         LOADL_quick   ; inline operand = 10
  $A7C2  D0                         INC
  $A7C3  2A                         STORE_quick   ; inline operand = 10
 >$A7C4  0A                         LOADL_quick   ; inline operand = 10
  $A7C5  55                         LOADR_qimm   ; inline operand = 5
  $A7C6  C6                         UCMPLT
  $A7C7  D7 A0 A7                   JUMPT_abs              $A7A0
  $A7CA  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A7CD  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $A7D1  74                         ADD_qimm   ; inline operand = 4
  $A7D2  B0                         DEREF
  $A7D3  B3                         PUSHL
  $A7D4  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A7D7  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $A7DB  B0                         DEREF
  $A7DC  B4                         POPR
  $A7DD  BC                         SUB
  $A7DE  B3                         PUSHL
  $A7DF  3B                         PUSH_quick   ; inline operand = 11
  $A7E0  E9 73 9E 04                CALL_abs_imm1          $9E73 (resolve_attack_apply_casualties) {bytecode}, $04
  $A7E4  CF                         RETURN

; ============================================================
; sub $A7E5   (frame_off=-14, body @ $A7EA)
; ============================================================
  $A7EA  DE F8 FF                   LEAL_far               $FFF8
  $A7ED  B3                         PUSHL
  $A7EE  60                         PUSH_qimm   ; inline operand = 0
  $A7EF  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A7F2  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $A7F6  D3                         BYTE_DEREF
  $A7F7  B3                         PUSHL
  $A7F8  60                         PUSH_qimm   ; inline operand = 0
  $A7F9  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A7FC  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $A800  D3                         BYTE_DEREF
  $A801  B3                         PUSHL
  $A802  E9 F3 A0 06                CALL_abs_imm1          $A0F3 (build_reachable_enemy_target_list) {bytecode}, $06
  $A806  2B                         STORE_quick   ; inline operand = 11
  $A807  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $A80A  51                         LOADR_qimm   ; inline operand = 1
  $A80B  DC                         XOR
  $A80C  26                         STORE_quick   ; inline operand = 6
  $A80D  40                         LOADL_qimm   ; inline operand = 0
  $A80E  27                         STORE_quick   ; inline operand = 7
  $A80F  25                         STORE_quick   ; inline operand = 5
  $A810  D6 3A A8                   JUMP_abs               $A83A
 >$A813  0B                         LOADL_quick   ; inline operand = 11
  $A814  D3                         BYTE_DEREF
  $A815  55                         LOADR_qimm   ; inline operand = 5
  $A816  C2                         SCMPLT
  $A817  D8 32 A8                   JUMPF_abs              $A832
  $A81A  0B                         LOADL_quick   ; inline operand = 11
  $A81B  D3                         BYTE_DEREF
  $A81C  B3                         PUSHL
  $A81D  36                         PUSH_quick   ; inline operand = 6
  $A81E  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $A822  D8 32 A8                   JUMPF_abs              $A832
  $A825  0B                         LOADL_quick   ; inline operand = 11
  $A826  D3                         BYTE_DEREF
  $A827  B3                         PUSHL
  $A828  36                         PUSH_quick   ; inline operand = 6
  $A829  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $A82D  B0                         DEREF
  $A82E  CD                         SWAP
  $A82F  05                         LOADL_quick   ; inline operand = 5
  $A830  BB                         ADD
  $A831  25                         STORE_quick   ; inline operand = 5
 >$A832  07                         LOADL_quick   ; inline operand = 7
  $A833  D0                         INC
  $A834  27                         STORE_quick   ; inline operand = 7
  $A835  D1                         DEC
  $A836  0B                         LOADL_quick   ; inline operand = 11
  $A837  D0                         INC
  $A838  2B                         STORE_quick   ; inline operand = 11
  $A839  D1                         DEC
 >$A83A  07                         LOADL_quick   ; inline operand = 7
  $A83B  56                         LOADR_qimm   ; inline operand = 6
  $A83C  C6                         UCMPLT
  $A83D  D7 13 A8                   JUMPT_abs              $A813
  $A840  60                         PUSH_qimm   ; inline operand = 0
  $A841  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A844  E9 C9 82 04                CALL_abs_imm1          $82C9 (unit_word_field_ptr_6fbc) {bytecode}, $04
  $A848  B0                         DEREF
  $A849  D2                         LSHIFT1
  $A84A  15                         LOADR_quick   ; inline operand = 5
  $A84B  C6                         UCMPLT
  $A84C  CF                         RETURN

; ============================================================
; sub $A84D   (frame_off=-4, body @ $A852)
; ============================================================
  $A852  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $A855  D7 68 A8                   JUMPT_abs              $A868
  $A858  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A85B  E9 E5 D9 02                CALL_abs_imm1          $D9E5 (test_6f65_bit7) {bytecode}, $02
  $A85F  D8 68 A8                   JUMPF_abs              $A868
  $A862  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $A865  D8 6A A8                   JUMPF_abs              $A86A
 >$A868  40                         LOADL_qimm   ; inline operand = 0
  $A869  CF                         RETURN
 >$A86A  AC E5 A7                   CALL_abs               $A7E5 (ai_test_own_double_ge_enemy_total_strength) {bytecode}
  $A86D  D7 87 A8                   JUMPT_abs              $A887
  $A870  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A873  E9 6A 83 02                CALL_abs_imm1          $836A (unit_damage_within_strength) {bytecode}, $02
  $A877  D8 87 A8                   JUMPF_abs              $A887
  $A87A  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $A87D  D7 CD A8                   JUMPT_abs              $A8CD
  $A880  0C                         LOADL_quick   ; inline operand = 12
  $A881  8B 1D                      BYTE_LOADR_imm1        +29
  $A883  C8                         UCMPGT
  $A884  D8 CD A8                   JUMPF_abs              $A8CD
 >$A887  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $A88A  E9 AB DA 02                CALL_abs_imm1          $DAAB (load_daimyo_relation_row) {bytecode}, $02
  $A88E  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A891  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $A895  2B                         STORE_quick   ; inline operand = 11
  $A896  B3                         PUSHL
  $A897  E9 BB 90 02                CALL_abs_imm1          $90BB (build_daimyo_province_list) {bytecode}, $02
  $A89B  A5 4F 6F                   BYTE_LOADL_abs         $6F4F (deduped_owner_list)
  $A89E  2A                         STORE_quick   ; inline operand = 10
  $A89F  8C FF 00                   LOADR_imm2             $00FF
  $A8A2  C1                         CMPNE
  $A8A3  D8 CD A8                   JUMPF_abs              $A8CD
  $A8A6  0B                         LOADL_quick   ; inline operand = 11
  $A8A7  A8 57 6F                   STORE_abs              $6F57 (battle_winner_province_sel)
  $A8AA  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A8AD  E9 E5 D9 02                CALL_abs_imm1          $D9E5 (test_6f65_bit7) {bytecode}, $02
  $A8B1  D8 CD A8                   JUMPF_abs              $A8CD
  $A8B4  3A                         PUSH_quick   ; inline operand = 10
  $A8B5  3B                         PUSH_quick   ; inline operand = 11
  $A8B6  E9 55 8F 04                CALL_abs_imm1          $8F55 (clear_unit_combat_flags) {bytecode}, $04
  $A8BA  0A                         LOADL_quick   ; inline operand = 10
  $A8BB  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $A8BE  BB                         ADD
  $A8BF  D3                         BYTE_DEREF
  $A8C0  D8 CB A8                   JUMPF_abs              $A8CB
  $A8C3  0A                         LOADL_quick   ; inline operand = 10
  $A8C4  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $A8C7  BB                         ADD
  $A8C8  B3                         PUSHL
  $A8C9  45                         LOADL_qimm   ; inline operand = 5
  $A8CA  D4                         BYTE_POPSTORE
 >$A8CB  41                         LOADL_qimm   ; inline operand = 1
  $A8CC  CF                         RETURN
 >$A8CD  40                         LOADL_qimm   ; inline operand = 0
  $A8CE  CF                         RETURN

; ============================================================
; sub $A8CF   (frame_off=+0, body @ $A8D4)
; ============================================================
  $A8D4  3C                         PUSH_quick   ; inline operand = 12
  $A8D5  E9 4D A8 02                CALL_abs_imm1          $A84D (ai_clear_province_state_when_strong_enough) {bytecode}, $02
  $A8D9  D8 DE A8                   JUMPF_abs              $A8DE
  $A8DC  41                         LOADL_qimm   ; inline operand = 1
  $A8DD  CF                         RETURN
 >$A8DE  AC 21 A7                   CALL_abs               $A721 (ai_rng_resolve_combat_apply_casualties) {bytecode}
  $A8E1  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $A8E4  D7 EF A8                   JUMPT_abs              $A8EF
  $A8E7  3C                         PUSH_quick   ; inline operand = 12
  $A8E8  E9 C5 A6 02                CALL_abs_imm1          $A6C5 (ai_choose_combat_action_by_battle_strength) {bytecode}, $02
  $A8EC  D6 0C A9                   JUMP_abs               $A90C
 >$A8EF  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $A8F2  D8 09 A9                   JUMPF_abs              $A909
  $A8F5  AC F5 8E                   CALL_abs               $8EF5 (ai_attacker_outstrengths_defender) {bytecode}
  $A8F8  D8 09 A9                   JUMPF_abs              $A909
  $A8FB  3D                         PUSH_quick   ; inline operand = 13
  $A8FC  E9 1A A0 02                CALL_abs_imm1          $A01A (unit_type_count_gt3_and_equals_arg1) {bytecode}, $02
  $A900  D7 09 A9                   JUMPT_abs              $A909
  $A903  AC A4 A5                   CALL_abs               $A5A4 (ai_advance_units_toward_reachable_enemies) {bytecode}
  $A906  D6 0C A9                   JUMP_abs               $A90C
 >$A909  AC 25 A6                   CALL_abs               $A625 (ai_advance_units_into_free_adjacent_cells) {bytecode}
 >$A90C  40                         LOADL_qimm   ; inline operand = 0
  $A90D  CF                         RETURN

; ============================================================
; sub $A90E   (frame_off=-8, body @ $A913)
; ============================================================
  $A913  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A916  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $A91A  2B                         STORE_quick   ; inline operand = 11
 >$A91B  AA F0 B4                   PUSH_abs               $B4F0 (combat_command_dispatch_data_b4f0)
  $A91E  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A922  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $A925  D3                         BYTE_DEREF
  $A926  29                         STORE_quick   ; inline operand = 9
  $A927  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $A92A  D3                         BYTE_DEREF
  $A92B  28                         STORE_quick   ; inline operand = 8
  $A92C  AC A0 90                   CALL_abs               $90A0 (prompt_unit_move_direction_at_tile) {bytecode}
  $A92F  2A                         STORE_quick   ; inline operand = 10
  $A930  8B 30                      BYTE_LOADR_imm1        +48
  $A932  C0                         CMPEQ
  $A933  D8 3B A9                   JUMPF_abs              $A93B
  $A936  AC 09 D3                   CALL_abs               $D309 (clear_rect_left_lower) {bytecode}
  $A939  41                         LOADL_qimm   ; inline operand = 1
  $A93A  CF                         RETURN
 >$A93B  3A                         PUSH_quick   ; inline operand = 10
  $A93C  DE F8 FF                   LEAL_far               $FFF8
  $A93F  B3                         PUSHL
  $A940  DE FA FF                   LEAL_far               $FFFA
  $A943  B3                         PUSHL
  $A944  E9 28 8F 06                CALL_abs_imm1          $8F28 (validate_dir_code_and_dispatch) {bytecode}, $06
  $A948  D8 5F A9                   JUMPF_abs              $A95F
  $A94B  38                         PUSH_quick   ; inline operand = 8
  $A94C  39                         PUSH_quick   ; inline operand = 9
  $A94D  E9 11 8F 04                CALL_abs_imm1          $8F11 (is_tile_in_bounds) {bytecode}, $04
  $A951  D8 5F A9                   JUMPF_abs              $A95F
  $A954  38                         PUSH_quick   ; inline operand = 8
  $A955  39                         PUSH_quick   ; inline operand = 9
  $A956  E9 58 90 04                CALL_abs_imm1          $9058 (place_unit_at_tile_if_free) {bytecode}, $04
  $A95A  D8 5F A9                   JUMPF_abs              $A95F
  $A95D  40                         LOADL_qimm   ; inline operand = 0
  $A95E  CF                         RETURN
 >$A95F  AA C4 B1                   PUSH_abs               $B1C4
  $A962  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A966  AC 1A D3                   CALL_abs               $D31A (clear_rect_left_lower_alt) {bytecode}
  $A969  D6 1B A9                   JUMP_abs               $A91B

; ============================================================
; sub $A96C   (frame_off=-12, body @ $A971)
; ============================================================
  $A971  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $A974  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $A978  29                         STORE_quick   ; inline operand = 9
  $A979  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $A97C  51                         LOADR_qimm   ; inline operand = 1
  $A97D  DC                         XOR
  $A97E  2B                         STORE_quick   ; inline operand = 11
 >$A97F  AA F2 B4                   PUSH_abs               $B4F2
  $A982  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A986  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $A989  D3                         BYTE_DEREF
  $A98A  27                         STORE_quick   ; inline operand = 7
  $A98B  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $A98E  D3                         BYTE_DEREF
  $A98F  26                         STORE_quick   ; inline operand = 6
  $A990  AC A0 90                   CALL_abs               $90A0 (prompt_unit_move_direction_at_tile) {bytecode}
  $A993  28                         STORE_quick   ; inline operand = 8
  $A994  8B 30                      BYTE_LOADR_imm1        +48
  $A996  C0                         CMPEQ
  $A997  D8 9F A9                   JUMPF_abs              $A99F
  $A99A  AC 09 D3                   CALL_abs               $D309 (clear_rect_left_lower) {bytecode}
  $A99D  41                         LOADL_qimm   ; inline operand = 1
  $A99E  CF                         RETURN
 >$A99F  38                         PUSH_quick   ; inline operand = 8
  $A9A0  DE F4 FF                   LEAL_far               $FFF4
  $A9A3  B3                         PUSHL
  $A9A4  DE F6 FF                   LEAL_far               $FFF6
  $A9A7  B3                         PUSHL
  $A9A8  E9 28 8F 06                CALL_abs_imm1          $8F28 (validate_dir_code_and_dispatch) {bytecode}, $06
  $A9AC  D8 EE A9                   JUMPF_abs              $A9EE
  $A9AF  36                         PUSH_quick   ; inline operand = 6
  $A9B0  37                         PUSH_quick   ; inline operand = 7
  $A9B1  E9 11 8F 04                CALL_abs_imm1          $8F11 (is_tile_in_bounds) {bytecode}, $04
  $A9B5  D8 EE A9                   JUMPF_abs              $A9EE
  $A9B8  40                         LOADL_qimm   ; inline operand = 0
  $A9B9  2A                         STORE_quick   ; inline operand = 10
 >$A9BA  3A                         PUSH_quick   ; inline operand = 10
  $A9BB  3B                         PUSH_quick   ; inline operand = 11
  $A9BC  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $A9C0  D3                         BYTE_DEREF
  $A9C1  17                         LOADR_quick   ; inline operand = 7
  $A9C2  C0                         CMPEQ
  $A9C3  D8 D2 A9                   JUMPF_abs              $A9D2
  $A9C6  3A                         PUSH_quick   ; inline operand = 10
  $A9C7  3B                         PUSH_quick   ; inline operand = 11
  $A9C8  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $A9CC  D3                         BYTE_DEREF
  $A9CD  16                         LOADR_quick   ; inline operand = 6
  $A9CE  C0                         CMPEQ
  $A9CF  D7 DB A9                   JUMPT_abs              $A9DB
 >$A9D2  0A                         LOADL_quick   ; inline operand = 10
  $A9D3  D0                         INC
  $A9D4  2A                         STORE_quick   ; inline operand = 10
  $A9D5  0A                         LOADL_quick   ; inline operand = 10
  $A9D6  55                         LOADR_qimm   ; inline operand = 5
  $A9D7  C6                         UCMPLT
  $A9D8  D7 BA A9                   JUMPT_abs              $A9BA
 >$A9DB  0A                         LOADL_quick   ; inline operand = 10
  $A9DC  55                         LOADR_qimm   ; inline operand = 5
  $A9DD  C6                         UCMPLT
  $A9DE  D8 EE A9                   JUMPF_abs              $A9EE
  $A9E1  3A                         PUSH_quick   ; inline operand = 10
  $A9E2  3A                         PUSH_quick   ; inline operand = 10
  $A9E3  E9 20 9E 02                CALL_abs_imm1          $9E20 (tally_unit_type_then_check_strength_parity_50) {bytecode}, $02
  $A9E7  B3                         PUSHL
  $A9E8  E9 F6 94 04                CALL_abs_imm1          $94F6 (announce_combat_side_daimyo_and_status) {bytecode}, $04
  $A9EC  40                         LOADL_qimm   ; inline operand = 0
  $A9ED  CF                         RETURN
 >$A9EE  AA C0 B1                   PUSH_abs               $B1C0
  $A9F1  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A9F5  AC 1A D3                   CALL_abs               $D31A (clear_rect_left_lower_alt) {bytecode}
  $A9F8  D6 7F A9                   JUMP_abs               $A97F

; ============================================================
; sub $A9FB   (frame_off=-8, body @ $AA00)
; ============================================================
  $AA00  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $AA03  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $AA07  29                         STORE_quick   ; inline operand = 9
  $AA08  AA F4 B4                   PUSH_abs               $B4F4
  $AA0B  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AA0F  6A                         PUSH_qimm   ; inline operand = 10
  $AA10  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $AA14  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $AA17  D7 22 AA                   JUMPT_abs              $AA22
  $AA1A  A4 48 6E                   LOADL_abs              $6E48 (ai_turn_planner_resume_flag)
  $AA1D  51                         LOADR_qimm   ; inline operand = 1
  $AA1E  C0                         CMPEQ
  $AA1F  D8 32 AA                   JUMPF_abs              $AA32
 >$AA22  AA D4 B1                   PUSH_abs               $B1D4
 >$AA25  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AA29  D6 62 AA                   JUMP_abs               $AA62
 >$AA2C  AA B8 B1                   PUSH_abs               $B1B8
  $AA2F  D6 25 AA                   JUMP_abs               $AA25
 >$AA32  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $AA35  D7 2C AA                   JUMPT_abs              $AA2C
  $AA38  AA A8 B1                   PUSH_abs               $B1A8
  $AA3B  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AA3F  65                         PUSH_qimm   ; inline operand = 5
  $AA40  61                         PUSH_qimm   ; inline operand = 1
  $AA41  E9 92 87 04                CALL_abs_imm1          $8792 (prompt_province_selection) {bytecode}, $04
  $AA45  2A                         STORE_quick   ; inline operand = 10
  $AA46  D8 A2 AA                   JUMPF_abs              $AAA2
  $AA49  0A                         LOADL_quick   ; inline operand = 10
  $AA4A  D1                         DEC
  $AA4B  2A                         STORE_quick   ; inline operand = 10
  $AA4C  B3                         PUSHL
  $AA4D  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $AA50  51                         LOADR_qimm   ; inline operand = 1
  $AA51  DC                         XOR
  $AA52  28                         STORE_quick   ; inline operand = 8
  $AA53  B3                         PUSHL
  $AA54  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $AA58  D7 67 AA                   JUMPT_abs              $AA67
  $AA5B  AA C2 B1                   PUSH_abs               $B1C2
 >$AA5E  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
 >$AA62  AC 1A D3                   CALL_abs               $D31A (clear_rect_left_lower_alt) {bytecode}
  $AA65  41                         LOADL_qimm   ; inline operand = 1
  $AA66  CF                         RETURN
 >$AA67  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $AA6A  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $AA6E  74                         ADD_qimm   ; inline operand = 4
  $AA6F  B0                         DEREF
  $AA70  B3                         PUSHL
  $AA71  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $AA74  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $AA78  B0                         DEREF
  $AA79  B4                         POPR
  $AA7A  BC                         SUB
  $AA7B  2B                         STORE_quick   ; inline operand = 11
  $AA7C  0B                         LOADL_quick   ; inline operand = 11
  $AA7D  50                         LOADR_qimm   ; inline operand = 0
  $AA7E  C3                         SCMPLE
  $AA7F  D8 88 AA                   JUMPF_abs              $AA88
  $AA82  AA CC B1                   PUSH_abs               $B1CC
  $AA85  D6 5E AA                   JUMP_abs               $AA5E
 >$AA88  AA C8 B1                   PUSH_abs               $B1C8
  $AA8B  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AA8F  3B                         PUSH_quick   ; inline operand = 11
  $AA90  61                         PUSH_qimm   ; inline operand = 1
  $AA91  E9 92 87 04                CALL_abs_imm1          $8792 (prompt_province_selection) {bytecode}, $04
  $AA95  2B                         STORE_quick   ; inline operand = 11
  $AA96  D8 62 AA                   JUMPF_abs              $AA62
  $AA99  3B                         PUSH_quick   ; inline operand = 11
  $AA9A  3A                         PUSH_quick   ; inline operand = 10
  $AA9B  E9 73 9E 04                CALL_abs_imm1          $9E73 (resolve_attack_apply_casualties) {bytecode}, $04
  $AA9F  D6 62 AA                   JUMP_abs               $AA62
 >$AAA2  AC 09 D3                   CALL_abs               $D309 (clear_rect_left_lower) {bytecode}
  $AAA5  41                         LOADL_qimm   ; inline operand = 1
  $AAA6  CF                         RETURN

; ============================================================
; sub $AAA7   (frame_off=-4, body @ $AAAC)
; ============================================================
  $AAAC  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $AAAF  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $AAB3  2B                         STORE_quick   ; inline operand = 11
  $AAB4  AA F6 B4                   PUSH_abs               $B4F6
  $AAB7  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AABB  6A                         PUSH_qimm   ; inline operand = 10
  $AABC  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $AAC0  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $AAC3  D8 D3 AA                   JUMPF_abs              $AAD3
  $AAC6  AA B8 B1                   PUSH_abs               $B1B8
  $AAC9  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AACD  AC 1A D3                   CALL_abs               $D31A (clear_rect_left_lower_alt) {bytecode}
  $AAD0  D6 35 AB                   JUMP_abs               $AB35
 >$AAD3  AA AA B1                   PUSH_abs               $B1AA
  $AAD6  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AADA  AC 2A 82                   CALL_abs               $822A (prompt_yes_no) {bytecode}
  $AADD  D8 35 AB                   JUMPF_abs              $AB35
  $AAE0  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $AAE3  E9 AB DA 02                CALL_abs_imm1          $DAAB (load_daimyo_relation_row) {bytecode}, $02
  $AAE7  3B                         PUSH_quick   ; inline operand = 11
  $AAE8  E9 BB 90 02                CALL_abs_imm1          $90BB (build_daimyo_province_list) {bytecode}, $02
  $AAEC  AC 2B 91                   CALL_abs               $912B (paged_flee_fief_list_display) {bytecode}
  $AAEF  D8 32 AB                   JUMPF_abs              $AB32
  $AAF2  AA D0 B1                   PUSH_abs               $B1D0
  $AAF5  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AAF9  AC A1 91                   CALL_abs               $91A1 (prompt_select_province_from_list) {bytecode}
  $AAFC  2A                         STORE_quick   ; inline operand = 10
  $AAFD  8C FF 00                   LOADR_imm2             $00FF
  $AB00  C1                         CMPNE
  $AB01  D8 32 AB                   JUMPF_abs              $AB32
  $AB04  AC 09 D3                   CALL_abs               $D309 (clear_rect_left_lower) {bytecode}
  $AB07  AA D2 B1                   PUSH_abs               $B1D2
  $AB0A  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AB0E  AC 2A 82                   CALL_abs               $822A (prompt_yes_no) {bytecode}
  $AB11  D8 35 AB                   JUMPF_abs              $AB35
  $AB14  0B                         LOADL_quick   ; inline operand = 11
  $AB15  A8 57 6F                   STORE_abs              $6F57 (battle_winner_province_sel)
  $AB18  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $AB1B  E9 E5 D9 02                CALL_abs_imm1          $D9E5 (test_6f65_bit7) {bytecode}, $02
  $AB1F  D8 30 AB                   JUMPF_abs              $AB30
  $AB22  3A                         PUSH_quick   ; inline operand = 10
  $AB23  3B                         PUSH_quick   ; inline operand = 11
  $AB24  E9 55 8F 04                CALL_abs_imm1          $8F55 (clear_unit_combat_flags) {bytecode}, $04
  $AB28  0A                         LOADL_quick   ; inline operand = 10
  $AB29  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $AB2C  BB                         ADD
  $AB2D  B3                         PUSHL
  $AB2E  45                         LOADL_qimm   ; inline operand = 5
  $AB2F  D4                         BYTE_POPSTORE
 >$AB30  40                         LOADL_qimm   ; inline operand = 0
  $AB31  CF                         RETURN
 >$AB32  AC 09 D3                   CALL_abs               $D309 (clear_rect_left_lower) {bytecode}
 >$AB35  41                         LOADL_qimm   ; inline operand = 1
  $AB36  CF                         RETURN

; ============================================================
; sub $AB37   (frame_off=+0, body @ $AB3C)
; ============================================================
  $AB3C  AA F8 B4                   PUSH_abs               $B4F8
  $AB3F  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AB43  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $AB46  D7 65 AB                   JUMPT_abs              $AB65
  $AB49  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $AB4C  E9 E5 D9 02                CALL_abs_imm1          $D9E5 (test_6f65_bit7) {bytecode}, $02
  $AB50  D7 58 AB                   JUMPT_abs              $AB58
  $AB53  89 13                      BYTE_LOADL_imm1        +19
  $AB55  D6 5A AB                   JUMP_abs               $AB5A
 >$AB58  89 12                      BYTE_LOADL_imm1        +18
 >$AB5A  D2                         LSHIFT1
  $AB5B  8C 96 B1                   LOADR_imm2             $B196 (jumptab_b196)
  $AB5E  BB                         ADD
  $AB5F  B0                         DEREF
  $AB60  B3                         PUSHL
  $AB61  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$AB65  AC 1A D3                   CALL_abs               $D31A (clear_rect_left_lower_alt) {bytecode}
  $AB68  40                         LOADL_qimm   ; inline operand = 0
  $AB69  CF                         RETURN

; ============================================================
; sub $AB6A   (frame_off=+0, body @ $AB6F)
; ============================================================
  $AB6F  AC 5D 8D                   CALL_abs               $8D5D (draw_combat_roster_window) {bytecode}
  $AB72  8D 1A                      BYTE_PUSH_imm1         +26
  $AB74  62                         PUSH_qimm   ; inline operand = 2
  $AB75  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $AB79  8E EC B9                   PUSH_imm2              $B9EC (msg_hit_any_key_b9ec)
  $AB7C  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AB80  AC 87 D2                   CALL_abs               $D287 (wait_button_edge) {bytecode}
  $AB83  AC E1 CC                   CALL_abs               $CCE1 (reset_prompt_selection) {bytecode}
  $AB86  AC 77 89                   CALL_abs               $8977 (render_combat_map_screen) {bytecode}
  $AB89  AC 58 8B                   CALL_abs               $8B58 (draw_valid_unit_field_cells) {bytecode}
  $AB8C  41                         LOADL_qimm   ; inline operand = 1
  $AB8D  CF                         RETURN

; ============================================================
; sub $AB8E   (frame_off=+0, body @ $AB93)
; ============================================================
  $AB93  60                         PUSH_qimm   ; inline operand = 0
  $AB94  60                         PUSH_qimm   ; inline operand = 0
  $AB95  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $AB99  D7 A4 AB                   JUMPT_abs              $ABA4
  $AB9C  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $AB9F  A8 57 6F                   STORE_abs              $6F57 (battle_winner_province_sel)
  $ABA2  45                         LOADL_qimm   ; inline operand = 5
  $ABA3  CF                         RETURN
 >$ABA4  60                         PUSH_qimm   ; inline operand = 0
  $ABA5  61                         PUSH_qimm   ; inline operand = 1
  $ABA6  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $ABAA  D7 B5 AB                   JUMPT_abs              $ABB5
  $ABAD  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $ABB0  A8 57 6F                   STORE_abs              $6F57 (battle_winner_province_sel)
  $ABB3  45                         LOADL_qimm   ; inline operand = 5
  $ABB4  CF                         RETURN
 >$ABB5  40                         LOADL_qimm   ; inline operand = 0
  $ABB6  CF                         RETURN

; ============================================================
; sub $ABB7   (frame_off=-8, body @ $ABBC)
; ============================================================
  $ABBC  40                         LOADL_qimm   ; inline operand = 0
  $ABBD  A8 E4 7B                   STORE_abs              $7BE4 (cur_combat_unit_slot)
  $ABC0  28                         STORE_quick   ; inline operand = 8
  $ABC1  29                         STORE_quick   ; inline operand = 9
  $ABC2  D6 72 AC                   JUMP_abs               $AC72
 >$ABC5  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $ABC8  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $ABCB  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $ABCF  D8 6B AC                   JUMPF_abs              $AC6B
  $ABD2  AC EA 8B                   CALL_abs               $8BEA (combat_unit_window_refresh) {bytecode}
  $ABD5  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $ABD8  D8 F4 AB                   JUMPF_abs              $ABF4
  $ABDB  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $ABDE  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $ABE2  B3                         PUSHL
  $ABE3  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $ABE7  D7 F4 AB                   JUMPT_abs              $ABF4
  $ABEA  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $ABED  E9 78 DE 02                CALL_abs_imm1          $DE78 (select_message_string_de78) {bytecode}, $02
  $ABF1  D6 06 AC                   JUMP_abs               $AC06
 >$ABF4  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $ABF7  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $ABFB  B3                         PUSHL
  $ABFC  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $AC00  59                         LOADR_qimm   ; inline operand = 9
  $AC01  B5                         MULT
  $AC02  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $AC05  BB                         ADD
 >$AC06  B3                         PUSHL
  $AC07  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AC0B  8E 04 BA                   PUSH_imm2              $BA04 (msg_giving_orders_for)
  $AC0E  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AC12  AC 87 93                   CALL_abs               $9387 (draw_unit_label_b627) {bytecode}
  $AC15  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $AC18  D3                         BYTE_DEREF
  $AC19  2A                         STORE_quick   ; inline operand = 10
  $AC1A  B3                         PUSHL
  $AC1B  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $AC1F  D7 27 AC                   JUMPT_abs              $AC27
  $AC22  3A                         PUSH_quick   ; inline operand = 10
  $AC23  E9 BE 95 02                CALL_abs_imm1          $95BE (draw_tactical_cursor_region_arg0) {bytecode}, $02
 >$AC27  41                         LOADL_qimm   ; inline operand = 1
  $AC28  2A                         STORE_quick   ; inline operand = 10
 >$AC29  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $AC2C  D3                         BYTE_DEREF
  $AC2D  B3                         PUSHL
  $AC2E  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $AC31  D3                         BYTE_DEREF
  $AC32  B3                         PUSHL
  $AC33  E9 70 82 04                CALL_abs_imm1          $8270 (set_combat_state_pair_7bf5_7bf7) {bytecode}, $04
  $AC37  0A                         LOADL_quick   ; inline operand = 10
  $AC38  51                         LOADR_qimm   ; inline operand = 1
  $AC39  DA                         AND
  $AC3A  B3                         PUSHL
  $AC3B  E9 0B 84 02                CALL_abs_imm1          $840B (draw_tactical_cursor_region) {bytecode}, $02
  $AC3F  0A                         LOADL_quick   ; inline operand = 10
  $AC40  D0                         INC
  $AC41  2A                         STORE_quick   ; inline operand = 10
  $AC42  0A                         LOADL_quick   ; inline operand = 10
  $AC43  57                         LOADR_qimm   ; inline operand = 7
  $AC44  C6                         UCMPLT
  $AC45  D7 29 AC                   JUMPT_abs              $AC29
  $AC48  41                         LOADL_qimm   ; inline operand = 1
  $AC49  A8 C5 7F                   STORE_abs              $7FC5 (ui_msg_oneshot_flag_7fc5)
  $AC4C  08                         LOADL_quick   ; inline operand = 8
  $AC4D  D0                         INC
  $AC4E  28                         STORE_quick   ; inline operand = 8
  $AC4F  D1                         DEC
  $AC50  B3                         PUSHL
  $AC51  3C                         PUSH_quick   ; inline operand = 12
  $AC52  E9 CF A8 04                CALL_abs_imm1          $A8CF (ai_select_unit_combat_action) {bytecode}, $04
  $AC56  2B                         STORE_quick   ; inline operand = 11
  $AC57  40                         LOADL_qimm   ; inline operand = 0
  $AC58  A8 C5 7F                   STORE_abs              $7FC5 (ui_msg_oneshot_flag_7fc5)
  $AC5B  0B                         LOADL_quick   ; inline operand = 11
  $AC5C  D8 64 AC                   JUMPF_abs              $AC64
  $AC5F  41                         LOADL_qimm   ; inline operand = 1
  $AC60  29                         STORE_quick   ; inline operand = 9
  $AC61  D6 7A AC                   JUMP_abs               $AC7A
 >$AC64  AC 8E AB                   CALL_abs               $AB8E (check_commander_alive_both_sides) {bytecode}
  $AC67  29                         STORE_quick   ; inline operand = 9
  $AC68  D7 7A AC                   JUMPT_abs              $AC7A
 >$AC6B  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $AC6E  D0                         INC
  $AC6F  A8 E4 7B                   STORE_abs              $7BE4 (cur_combat_unit_slot)
 >$AC72  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $AC75  55                         LOADR_qimm   ; inline operand = 5
  $AC76  C6                         UCMPLT
  $AC77  D7 C5 AB                   JUMPT_abs              $ABC5
 >$AC7A  AC 09 D3                   CALL_abs               $D309 (clear_rect_left_lower) {bytecode}
  $AC7D  09                         LOADL_quick   ; inline operand = 9
  $AC7E  CF                         RETURN

; ============================================================
; sub $AC7F   (frame_off=-8, body @ $AC84)
; ============================================================
  $AC84  40                         LOADL_qimm   ; inline operand = 0
  $AC85  A8 E4 7B                   STORE_abs              $7BE4 (cur_combat_unit_slot)
  $AC88  2A                         STORE_quick   ; inline operand = 10
  $AC89  D6 2E AD                   JUMP_abs               $AD2E
 >$AC8C  AA E4 7B                   PUSH_abs               $7BE4 (cur_combat_unit_slot)
  $AC8F  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $AC92  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $AC96  D8 27 AD                   JUMPF_abs              $AD27
 >$AC99  A4 FB 7B                   LOADL_abs              $7BFB (combat_unit_window_mode_flag)
  $AC9C  51                         LOADR_qimm   ; inline operand = 1
  $AC9D  C1                         CMPNE
  $AC9E  D8 CA AC                   JUMPF_abs              $ACCA
  $ACA1  AC F9 D2                   CALL_abs               $D2F9 (clear_rect_left_upper) {bytecode}
  $ACA4  AC 09 D3                   CALL_abs               $D309 (clear_rect_left_lower) {bytecode}
  $ACA7  40                         LOADL_qimm   ; inline operand = 0
  $ACA8  2B                         STORE_quick   ; inline operand = 11
 >$ACA9  0B                         LOADL_quick   ; inline operand = 11
  $ACAA  7A                         ADD_qimm   ; inline operand = 10
  $ACAB  B3                         PUSHL
  $ACAC  64                         PUSH_qimm   ; inline operand = 4
  $ACAD  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $ACB1  0B                         LOADL_quick   ; inline operand = 11
  $ACB2  D2                         LSHIFT1
  $ACB3  8C F0 B4                   LOADR_imm2             $B4F0 (combat_command_dispatch_data_b4f0)
  $ACB6  BB                         ADD
  $ACB7  B0                         DEREF
  $ACB8  B3                         PUSHL
  $ACB9  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $ACBD  0B                         LOADL_quick   ; inline operand = 11
  $ACBE  D0                         INC
  $ACBF  2B                         STORE_quick   ; inline operand = 11
  $ACC0  0B                         LOADL_quick   ; inline operand = 11
  $ACC1  56                         LOADR_qimm   ; inline operand = 6
  $ACC2  C6                         UCMPLT
  $ACC3  D7 A9 AC                   JUMPT_abs              $ACA9
  $ACC6  41                         LOADL_qimm   ; inline operand = 1
  $ACC7  A8 FB 7B                   STORE_abs              $7BFB (combat_unit_window_mode_flag)
 >$ACCA  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $ACCD  D3                         BYTE_DEREF
  $ACCE  29                         STORE_quick   ; inline operand = 9
  $ACCF  39                         PUSH_quick   ; inline operand = 9
  $ACD0  E9 0E 96 02                CALL_abs_imm1          $960E (is_cell_valid_for_phase) {bytecode}, $02
  $ACD4  D7 DC AC                   JUMPT_abs              $ACDC
  $ACD7  39                         PUSH_quick   ; inline operand = 9
  $ACD8  E9 BE 95 02                CALL_abs_imm1          $95BE (draw_tactical_cursor_region_arg0) {bytecode}, $02
 >$ACDC  8E 18 BA                   PUSH_imm2              $BA18 (combat_command_dispatch_data_ba18)
  $ACDF  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $ACE3  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $ACE6  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $ACEA  B3                         PUSHL
  $ACEB  E9 AF D7 02                CALL_abs_imm1          $D7AF (draw_daimyo_name) {bytecode}, $02
  $ACEF  8E 19 BA                   PUSH_imm2              $BA19 (msg_your_orders_for)
  $ACF2  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $ACF6  AC 87 93                   CALL_abs               $9387 (draw_unit_label_b627) {bytecode}
  $ACF9  AC B9 82                   CALL_abs               $82B9 (cur_unit_field_ptr_6fda) {bytecode}
  $ACFC  D3                         BYTE_DEREF
  $ACFD  B3                         PUSHL
  $ACFE  AC A9 82                   CALL_abs               $82A9 (cur_unit_field_ptr_6fd0) {bytecode}
  $AD01  D3                         BYTE_DEREF
  $AD02  B3                         PUSHL
  $AD03  E9 69 86 04                CALL_abs_imm1          $8669 (combat_command_menu_input_loop) {bytecode}, $04
  $AD07  2B                         STORE_quick   ; inline operand = 11
  $AD08  0B                         LOADL_quick   ; inline operand = 11
  $AD09  D2                         LSHIFT1
  $AD0A  8C F8 B9                   LOADR_imm2             $B9F8 (combat_command_dispatch_data_b9f8)
  $AD0D  BB                         ADD
  $AD0E  B0                         DEREF
  $AD0F  28                         STORE_quick   ; inline operand = 8
  $AD10  08                         LOADL_quick   ; inline operand = 8
  $AD11  DD                         CALLPTR
  $AD12  D7 99 AC                   JUMPT_abs              $AC99
  $AD15  0B                         LOADL_quick   ; inline operand = 11
  $AD16  53                         LOADR_qimm   ; inline operand = 3
  $AD17  C0                         CMPEQ
  $AD18  D8 20 AD                   JUMPF_abs              $AD20
  $AD1B  41                         LOADL_qimm   ; inline operand = 1
  $AD1C  2A                         STORE_quick   ; inline operand = 10
  $AD1D  D6 36 AD                   JUMP_abs               $AD36
 >$AD20  AC 8E AB                   CALL_abs               $AB8E (check_commander_alive_both_sides) {bytecode}
  $AD23  2A                         STORE_quick   ; inline operand = 10
  $AD24  D7 36 AD                   JUMPT_abs              $AD36
 >$AD27  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $AD2A  D0                         INC
  $AD2B  A8 E4 7B                   STORE_abs              $7BE4 (cur_combat_unit_slot)
 >$AD2E  A4 E4 7B                   LOADL_abs              $7BE4 (cur_combat_unit_slot)
  $AD31  55                         LOADR_qimm   ; inline operand = 5
  $AD32  C6                         UCMPLT
  $AD33  D7 8C AC                   JUMPT_abs              $AC8C
 >$AD36  0A                         LOADL_quick   ; inline operand = 10
  $AD37  CF                         RETURN

; ============================================================
; sub $AD38   (frame_off=+0, body @ $AD3D)
; ============================================================
  $AD3D  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $AD40  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $AD44  D8 7B AD                   JUMPF_abs              $AD7B
  $AD47  8E 2B BA                   PUSH_imm2              $BA2B (display_morale_falling_m_data_ba2b)
  $AD4A  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AD4E  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $AD51  E9 AF D7 02                CALL_abs_imm1          $D7AF (draw_daimyo_name) {bytecode}, $02
  $AD55  8E 2C BA                   PUSH_imm2              $BA2C (msg_our)
 >$AD58  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AD5C  8E 39 BA                   PUSH_imm2              $BA39 (msg_morale_is_falling)
  $AD5F  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AD63  AC 1A D3                   CALL_abs               $D31A (clear_rect_left_lower_alt) {bytecode}
  $AD66  CF                         RETURN
 >$AD67  8E 31 BA                   PUSH_imm2              $BA31 (display_morale_falling_m_data_ba31)
  $AD6A  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AD6E  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $AD71  E9 AF D7 02                CALL_abs_imm1          $D7AF (draw_daimyo_name) {bytecode}, $02
  $AD75  8E 32 BA                   PUSH_imm2              $BA32 (msg_enemy)
  $AD78  D6 58 AD                   JUMP_abs               $AD58
 >$AD7B  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $AD7E  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $AD82  D7 67 AD                   JUMPT_abs              $AD67
  $AD85  CF                         RETURN

; ============================================================
; sub $AD86   (frame_off=-4, body @ $AD8B)
; ============================================================
  $AD8B  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $AD8E  8B 1A                      BYTE_LOADR_imm1        +26
  $AD90  B5                         MULT
  $AD91  8C 13 70                   LOADR_imm2             $7013
  $AD94  BB                         ADD
  $AD95  2A                         STORE_quick   ; inline operand = 10
  $AD96  40                         LOADL_qimm   ; inline operand = 0
  $AD97  2B                         STORE_quick   ; inline operand = 11
 >$AD98  3B                         PUSH_quick   ; inline operand = 11
  $AD99  60                         PUSH_qimm   ; inline operand = 0
  $AD9A  E9 79 8F 04                CALL_abs_imm1          $8F79 (test_unit_type_present_flag) {bytecode}, $04
  $AD9E  D8 C7 AD                   JUMPF_abs              $ADC7
  $ADA1  8D 20                      BYTE_PUSH_imm1         +32
  $ADA3  3B                         PUSH_quick   ; inline operand = 11
  $ADA4  60                         PUSH_qimm   ; inline operand = 0
  $ADA5  E9 9A 82 04                CALL_abs_imm1          $829A (unit_field_ptr_6fda) {bytecode}, $04
  $ADA9  D3                         BYTE_DEREF
  $ADAA  B3                         PUSHL
  $ADAB  3B                         PUSH_quick   ; inline operand = 11
  $ADAC  60                         PUSH_qimm   ; inline operand = 0
  $ADAD  E9 8B 82 04                CALL_abs_imm1          $828B (unit_field_ptr_6fd0) {bytecode}, $04
  $ADB1  D3                         BYTE_DEREF
  $ADB2  B3                         PUSHL
  $ADB3  E9 DB 82 06                CALL_abs_imm1          $82DB (test_map_cell_bits) {bytecode}, $06
  $ADB7  D7 C7 AD                   JUMPT_abs              $ADC7
  $ADBA  62                         PUSH_qimm   ; inline operand = 2
  $ADBB  0A                         LOADL_quick   ; inline operand = 10
  $ADBC  B4                         POPR
  $ADBD  B3                         PUSHL
  $ADBE  B0                         DEREF
  $ADBF  B6                         SDIV
  $ADC0  B1                         POPSTORE
  $ADC1  AC 38 AD                   CALL_abs               $AD38 (display_morale_falling_message) {bytecode}
  $ADC4  D6 D0 AD                   JUMP_abs               $ADD0
 >$ADC7  0B                         LOADL_quick   ; inline operand = 11
  $ADC8  D0                         INC
  $ADC9  2B                         STORE_quick   ; inline operand = 11
  $ADCA  0B                         LOADL_quick   ; inline operand = 11
  $ADCB  55                         LOADR_qimm   ; inline operand = 5
  $ADCC  C6                         UCMPLT
  $ADCD  D7 98 AD                   JUMPT_abs              $AD98
 >$ADD0  CF                         RETURN

; ============================================================
; sub $ADD1   (frame_off=-6, body @ $ADD6)
; ============================================================
  $ADD6  AC 86 AD                   CALL_abs               $AD86 (halve_defender_province_stat_for_exposed_units) {bytecode}
  $ADD9  40                         LOADL_qimm   ; inline operand = 0
  $ADDA  2A                         STORE_quick   ; inline operand = 10
 >$ADDB  40                         LOADL_qimm   ; inline operand = 0
  $ADDC  A8 F3 7B                   STORE_abs              $7BF3 (combat_casualty_skip_flag_7bf3)
  $ADDF  40                         LOADL_qimm   ; inline operand = 0
  $ADE0  2B                         STORE_quick   ; inline operand = 11
 >$ADE1  0B                         LOADL_quick   ; inline operand = 11
  $ADE2  8C EE 7B                   LOADR_imm2             $7BEE
  $ADE5  BB                         ADD
  $ADE6  B3                         PUSHL
  $ADE7  40                         LOADL_qimm   ; inline operand = 0
  $ADE8  D4                         BYTE_POPSTORE
  $ADE9  0B                         LOADL_quick   ; inline operand = 11
  $ADEA  D0                         INC
  $ADEB  2B                         STORE_quick   ; inline operand = 11
  $ADEC  0B                         LOADL_quick   ; inline operand = 11
  $ADED  55                         LOADR_qimm   ; inline operand = 5
  $ADEE  C6                         UCMPLT
  $ADEF  D7 E1 AD                   JUMPT_abs              $ADE1
  $ADF2  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $ADF5  D8 FE AD                   JUMPF_abs              $ADFE
  $ADF8  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $ADFB  D8 08 AE                   JUMPF_abs              $AE08
 >$ADFE  AA E8 7B                   PUSH_abs               $7BE8 (cur_combat_side)
  $AE01  E9 30 90 02                CALL_abs_imm1          $9030 (is_battleside_province_aistate5_and_not_resting) {bytecode}, $02
  $AE05  D8 10 AE                   JUMPF_abs              $AE10
 >$AE08  3C                         PUSH_quick   ; inline operand = 12
  $AE09  E9 B7 AB 02                CALL_abs_imm1          $ABB7 (ai_run_all_units_combat_actions) {bytecode}, $02
  $AE0D  D6 13 AE                   JUMP_abs               $AE13
 >$AE10  AC 7F AC                   CALL_abs               $AC7F (combat_command_dispatch_loop_per_unit) {bytecode}
 >$AE13  29                         STORE_quick   ; inline operand = 9
  $AE14  09                         LOADL_quick   ; inline operand = 9
  $AE15  D7 2A AE                   JUMPT_abs              $AE2A
  $AE18  41                         LOADL_qimm   ; inline operand = 1
  $AE19  CD                         SWAP
  $AE1A  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $AE1D  DC                         XOR
  $AE1E  A8 E8 7B                   STORE_abs              $7BE8 (cur_combat_side)
  $AE21  0A                         LOADL_quick   ; inline operand = 10
  $AE22  D0                         INC
  $AE23  2A                         STORE_quick   ; inline operand = 10
  $AE24  0A                         LOADL_quick   ; inline operand = 10
  $AE25  52                         LOADR_qimm   ; inline operand = 2
  $AE26  C6                         UCMPLT
  $AE27  D7 DB AD                   JUMPT_abs              $ADDB
 >$AE2A  09                         LOADL_quick   ; inline operand = 9
  $AE2B  CF                         RETURN

; ============================================================
; sub $AE2C   (frame_off=-10, body @ $AE31)
; ============================================================
  $AE31  AC 20 CD                   CALL_abs               $CD20 (repaint_screen) {bytecode}
  $AE34  AA 57 6F                   PUSH_abs               $6F57 (battle_winner_province_sel)
  $AE37  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $AE3B  2A                         STORE_quick   ; inline operand = 10
  $AE3C  A4 57 6F                   LOADL_abs              $6F57 (battle_winner_province_sel)
  $AE3F  A6 63 6F                   LOADR_abs              $6F63 (battle_defending_province)
  $AE42  C0                         CMPEQ
  $AE43  27                         STORE_quick   ; inline operand = 7
  $AE44  B3                         PUSHL
  $AE45  E9 E5 D9 02                CALL_abs_imm1          $D9E5 (test_6f65_bit7) {bytecode}, $02
  $AE49  D8 69 AE                   JUMPF_abs              $AE69
  $AE4C  A4 57 6F                   LOADL_abs              $6F57 (battle_winner_province_sel)
  $AE4F  8B 32                      BYTE_LOADR_imm1        +50
  $AE51  C1                         CMPNE
  $AE52  D8 69 AE                   JUMPF_abs              $AE69
  $AE55  AA 57 6F                   PUSH_abs               $6F57 (battle_winner_province_sel)
  $AE58  E9 75 E2 02                CALL_abs_imm1          $E275 (announce_daimyo_death) {bytecode}, $02
  $AE5C  AA 57 6F                   PUSH_abs               $6F57 (battle_winner_province_sel)
  $AE5F  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $AE63  D8 69 AE                   JUMPF_abs              $AE69
  $AE66  AC 35 DB                   CALL_abs               $DB35 (increment_ai_player_count) {bytecode}
 >$AE69  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $AE6C  D8 70 AE                   JUMPF_abs              $AE70
  $AE6F  CF                         RETURN
 >$AE70  8A 89 6F                   LOADL_imm2             $6F89
  $AE73  28                         STORE_quick   ; inline operand = 8
  $AE74  37                         PUSH_quick   ; inline operand = 7
  $AE75  E9 E5 D9 02                CALL_abs_imm1          $D9E5 (test_6f65_bit7) {bytecode}, $02
  $AE79  D8 B6 AE                   JUMPF_abs              $AEB6
  $AE7C  40                         LOADL_qimm   ; inline operand = 0
  $AE7D  D6 93 AE                   JUMP_abs               $AE93
 >$AE80  3B                         PUSH_quick   ; inline operand = 11
  $AE81  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $AE85  1A                         LOADR_quick   ; inline operand = 10
  $AE86  C0                         CMPEQ
  $AE87  D8 91 AE                   JUMPF_abs              $AE91
  $AE8A  08                         LOADL_quick   ; inline operand = 8
  $AE8B  D0                         INC
  $AE8C  28                         STORE_quick   ; inline operand = 8
  $AE8D  D1                         DEC
  $AE8E  B3                         PUSHL
  $AE8F  0B                         LOADL_quick   ; inline operand = 11
  $AE90  D4                         BYTE_POPSTORE
 >$AE91  0B                         LOADL_quick   ; inline operand = 11
  $AE92  D0                         INC
 >$AE93  2B                         STORE_quick   ; inline operand = 11
  $AE94  0B                         LOADL_quick   ; inline operand = 11
  $AE95  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $AE98  C6                         UCMPLT
  $AE99  D7 80 AE                   JUMPT_abs              $AE80
 >$AE9C  38                         PUSH_quick   ; inline operand = 8
  $AE9D  89 FF                      BYTE_LOADL_imm1        -1
  $AE9F  D4                         BYTE_POPSTORE
  $AEA0  63                         PUSH_qimm   ; inline operand = 3
  $AEA1  62                         PUSH_qimm   ; inline operand = 2
  $AEA2  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $AEA6  8E 4C BA                   PUSH_imm2              $BA4C (msg_fief_ba4c)
  $AEA9  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AEAD  8A 89 6F                   LOADL_imm2             $6F89
  $AEB0  28                         STORE_quick   ; inline operand = 8
  $AEB1  40                         LOADL_qimm   ; inline operand = 0
  $AEB2  29                         STORE_quick   ; inline operand = 9
  $AEB3  D6 F4 AE                   JUMP_abs               $AEF4
 >$AEB6  07                         LOADL_quick   ; inline operand = 7
  $AEB7  D8 C6 AE                   JUMPF_abs              $AEC6
  $AEBA  08                         LOADL_quick   ; inline operand = 8
  $AEBB  D0                         INC
  $AEBC  28                         STORE_quick   ; inline operand = 8
  $AEBD  D1                         DEC
  $AEBE  B3                         PUSHL
  $AEBF  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $AEC2  D4                         BYTE_POPSTORE
  $AEC3  D6 9C AE                   JUMP_abs               $AE9C
 >$AEC6  CF                         RETURN
 >$AEC7  08                         LOADL_quick   ; inline operand = 8
  $AEC8  D3                         BYTE_DEREF
  $AEC9  B3                         PUSHL
  $AECA  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $AECE  8C FF 00                   LOADR_imm2             $00FF
  $AED1  C1                         CMPNE
  $AED2  D8 F1 AE                   JUMPF_abs              $AEF1
  $AED5  08                         LOADL_quick   ; inline operand = 8
  $AED6  D3                         BYTE_DEREF
  $AED7  D0                         INC
  $AED8  B3                         PUSHL
  $AED9  8E 52 BA                   PUSH_imm2              $BA52 (msg_fmt__2d_ba52)
  $AEDC  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $AEE0  09                         LOADL_quick   ; inline operand = 9
  $AEE1  D0                         INC
  $AEE2  29                         STORE_quick   ; inline operand = 9
  $AEE3  59                         LOADR_qimm   ; inline operand = 9
  $AEE4  C0                         CMPEQ
  $AEE5  D8 F1 AE                   JUMPF_abs              $AEF1
  $AEE8  8E 57 BA                   PUSH_imm2              $BA57 (transfer_owned_fiefs_and_data_ba57)
  $AEEB  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AEEF  40                         LOADL_qimm   ; inline operand = 0
  $AEF0  29                         STORE_quick   ; inline operand = 9
 >$AEF1  08                         LOADL_quick   ; inline operand = 8
  $AEF2  D0                         INC
  $AEF3  28                         STORE_quick   ; inline operand = 8
 >$AEF4  08                         LOADL_quick   ; inline operand = 8
  $AEF5  D3                         BYTE_DEREF
  $AEF6  8C FF 00                   LOADR_imm2             $00FF
  $AEF9  C1                         CMPNE
  $AEFA  D7 C7 AE                   JUMPT_abs              $AEC7
  $AEFD  8E 59 BA                   PUSH_imm2              $BA59 (msg_has_passed_from)
  $AF00  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AF04  AA 57 6F                   PUSH_abs               $6F57 (battle_winner_province_sel)
  $AF07  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $AF0B  59                         LOADR_qimm   ; inline operand = 9
  $AF0C  B5                         MULT
  $AF0D  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $AF10  BB                         ADD
  $AF11  B3                         PUSHL
  $AF12  8E 6B BA                   PUSH_imm2              $BA6B (msg_lord_s_to)
  $AF15  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $AF19  07                         LOADL_quick   ; inline operand = 7
  $AF1A  51                         LOADR_qimm   ; inline operand = 1
  $AF1B  DC                         XOR
  $AF1C  B3                         PUSHL
  $AF1D  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $AF21  B3                         PUSHL
  $AF22  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $AF26  59                         LOADR_qimm   ; inline operand = 9
  $AF27  B5                         MULT
  $AF28  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $AF2B  BB                         ADD
  $AF2C  B3                         PUSHL
  $AF2D  8E 77 BA                   PUSH_imm2              $BA77 (msg_lord_s)
  $AF30  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $AF34  AC 59 D7                   CALL_abs               $D759 (standard_delay) {bytecode}
  $AF37  AC 20 CD                   CALL_abs               $CD20 (repaint_screen) {bytecode}
  $AF3A  CF                         RETURN

; ============================================================
; sub $AF3B   (frame_off=-2, body @ $AF40)
; ============================================================
  $AF40  60                         PUSH_qimm   ; inline operand = 0
  $AF41  60                         PUSH_qimm   ; inline operand = 0
  $AF42  6A                         PUSH_qimm   ; inline operand = 10
  $AF43  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $AF47  0C                         LOADL_quick   ; inline operand = 12
  $AF48  55                         LOADR_qimm   ; inline operand = 5
  $AF49  C0                         CMPEQ
  $AF4A  D8 6A AF                   JUMPF_abs              $AF6A
  $AF4D  A4 57 6F                   LOADL_abs              $6F57 (battle_winner_province_sel)
  $AF50  A6 63 6F                   LOADR_abs              $6F63 (battle_defending_province)
  $AF53  C0                         CMPEQ
  $AF54  D8 5B AF                   JUMPF_abs              $AF5B
  $AF57  41                         LOADL_qimm   ; inline operand = 1
  $AF58  D6 5C AF                   JUMP_abs               $AF5C
 >$AF5B  40                         LOADL_qimm   ; inline operand = 0
 >$AF5C  8C 65 6F                   LOADR_imm2             $6F65 (war_side_state_flag)
  $AF5F  BB                         ADD
  $AF60  D3                         BYTE_DEREF
  $AF61  8B 1F                      BYTE_LOADR_imm1        +31
  $AF63  DA                         AND
  $AF64  D7 6A AF                   JUMPT_abs              $AF6A
  $AF67  0C                         LOADL_quick   ; inline operand = 12
  $AF68  D0                         INC
  $AF69  2C                         STORE_quick   ; inline operand = 12
 >$AF6A  A4 48 6E                   LOADL_abs              $6E48 (ai_turn_planner_resume_flag)
  $AF6D  51                         LOADR_qimm   ; inline operand = 1
  $AF6E  C1                         CMPNE
  $AF6F  D8 A2 AF                   JUMPF_abs              $AFA2
  $AF72  AC FF 82                   CALL_abs               $82FF (is_no_province_selected) {bytecode}
  $AF75  D7 80 AF                   JUMPT_abs              $AF80
  $AF78  3C                         PUSH_quick   ; inline operand = 12
  $AF79  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $AF7C  E9 AA 93 04                CALL_abs_imm1          $93AA (announce_battle_outcome_retreat_or_won) {bytecode}, $04
 >$AF80  3C                         PUSH_quick   ; inline operand = 12
  $AF81  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $AF84  E9 AA 93 04                CALL_abs_imm1          $93AA (announce_battle_outcome_retreat_or_won) {bytecode}, $04
  $AF88  AC 2C AE                   CALL_abs               $AE2C (transfer_owned_fiefs_and_announce_succession) {bytecode}
  $AF8B  AC 3C E0                   CALL_abs               $E03C (apply_conquest_outcome) {bytecode}
  $AF8E  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $AF91  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $AF94  DA                         AND
  $AF95  D7 E0 AF                   JUMPT_abs              $AFE0
  $AF98  AA E6 7B                   PUSH_abs               $7BE6 (latched_selected_record_idx)
  $AF9B  E9 F2 E5 02                CALL_abs_imm1          $E5F2 (render_map_section) {bytecode}, $02
  $AF9F  D6 E0 AF                   JUMP_abs               $AFE0
 >$AFA2  AC 20 CD                   CALL_abs               $CD20 (repaint_screen) {bytecode}
  $AFA5  61                         PUSH_qimm   ; inline operand = 1
  $AFA6  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $AFAA  40                         LOADL_qimm   ; inline operand = 0
  $AFAB  2B                         STORE_quick   ; inline operand = 11
 >$AFAC  0B                         LOADL_quick   ; inline operand = 11
  $AFAD  8C 7F BA                   LOADR_imm2             $BA7F (battle_setup_select_prov_data_ba7f)
  $AFB0  BB                         ADD
  $AFB1  D3                         BYTE_DEREF
  $AFB2  B3                         PUSHL
  $AFB3  3B                         PUSH_quick   ; inline operand = 11
  $AFB4  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $AFB8  0B                         LOADL_quick   ; inline operand = 11
  $AFB9  D0                         INC
  $AFBA  2B                         STORE_quick   ; inline operand = 11
  $AFBB  0B                         LOADL_quick   ; inline operand = 11
  $AFBC  8B 10                      BYTE_LOADR_imm1        +16
  $AFBE  C6                         UCMPLT
  $AFBF  D7 AC AF                   JUMPT_abs              $AFAC
  $AFC2  8E 9A 00                   PUSH_imm2              $009A
  $AFC5  8E 10 15                   PUSH_imm2              $1510
  $AFC8  8E BC 83                   PUSH_imm2              $83BC
  $AFCB  64                         PUSH_qimm   ; inline operand = 4
  $AFCC  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $AFD0  60                         PUSH_qimm   ; inline operand = 0
  $AFD1  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $AFD5  89 32                      BYTE_LOADL_imm1        +50
  $AFD7  A9 33 6E                   BYTE_STORE_abs         $6E33 (post_elim_owner_sentinel_id)
  $AFDA  8D 1E                      BYTE_PUSH_imm1         +30
  $AFDC  E9 54 E5 02                CALL_abs_imm1          $E554 (redraw_fief_on_map) {bytecode}, $02
 >$AFE0  CF                         RETURN

; ============================================================
; sub $AFE1   (frame_off=-16, body @ $AFE6)
; ============================================================
  $AFE6  43                         LOADL_qimm   ; inline operand = 3
  $AFE7  A8 D3 7F                   STORE_abs              $7FD3 (ui_input_mode)
  $AFEA  64                         PUSH_qimm   ; inline operand = 4
  $AFEB  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $AFEF  8F 35                      BYTE_ADD_imm1          +53
  $AFF1  A8 EB 7F                   STORE_abs              $7FEB (sram_save_checksum)
  $AFF4  AC 20 CD                   CALL_abs               $CD20 (repaint_screen) {bytecode}
  $AFF7  62                         PUSH_qimm   ; inline operand = 2
  $AFF8  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $AFFC  AC 03 89                   CALL_abs               $8903 (map_populate) {bytecode}
  $AFFF  AC 77 89                   CALL_abs               $8977 (render_combat_map_screen) {bytecode}
  $B002  AC CA 92                   CALL_abs               $92CA (battle_init_clear_defending_province_fields) {bytecode}
  $B005  26                         STORE_quick   ; inline operand = 6
  $B006  AC 39 8D                   CALL_abs               $8D39 (draw_combat_fief_day_header) {bytecode}
  $B009  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $B00C  8B 32                      BYTE_LOADR_imm1        +50
  $B00E  C0                         CMPEQ
  $B00F  D8 1B B0                   JUMPF_abs              $B01B
  $B012  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $B015  8C A6 FE                   LOADR_imm2             $FEA6 (province_to_map_section_50)
  $B018  D6 21 B0                   JUMP_abs               $B021
 >$B01B  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $B01E  8C D8 FE                   LOADR_imm2             $FED8 (province_to_map_section_17)
 >$B021  BB                         ADD
  $B022  D3                         BYTE_DEREF
  $B023  A8 E6 7B                   STORE_abs              $7BE6 (latched_selected_record_idx)
  $B026  06                         LOADL_quick   ; inline operand = 6
  $B027  D8 30 B0                   JUMPF_abs              $B030
  $B02A  36                         PUSH_quick   ; inline operand = 6
  $B02B  E9 3B AF 02                CALL_abs_imm1          $AF3B (dispatch_battle_resolution) {bytecode}, $02
  $B02F  CF                         RETURN
 >$B030  AC 08 9B                   CALL_abs               $9B08 (deploy_both_sides_units_loop) {bytecode}
  $B033  40                         LOADL_qimm   ; inline operand = 0
  $B034  25                         STORE_quick   ; inline operand = 5
 >$B035  DE FC FF                   LEAL_far               $FFFC
  $B038  B3                         PUSHL
  $B039  05                         LOADL_quick   ; inline operand = 5
  $B03A  D2                         LSHIFT1
  $B03B  B4                         POPR
  $B03C  BB                         ADD
  $B03D  B3                         PUSHL
  $B03E  35                         PUSH_quick   ; inline operand = 5
  $B03F  E9 7E 82 02                CALL_abs_imm1          $827E (unit_record_ptr) {bytecode}, $02
  $B043  72                         ADD_qimm   ; inline operand = 2
  $B044  B1                         POPSTORE
  $B045  DE F8 FF                   LEAL_far               $FFF8
  $B048  B3                         PUSHL
  $B049  05                         LOADL_quick   ; inline operand = 5
  $B04A  D2                         LSHIFT1
  $B04B  B4                         POPR
  $B04C  BB                         ADD
  $B04D  B3                         PUSHL
  $B04E  40                         LOADL_qimm   ; inline operand = 0
  $B04F  B1                         POPSTORE
  $B050  05                         LOADL_quick   ; inline operand = 5
  $B051  D0                         INC
  $B052  25                         STORE_quick   ; inline operand = 5
  $B053  05                         LOADL_quick   ; inline operand = 5
  $B054  52                         LOADR_qimm   ; inline operand = 2
  $B055  C6                         UCMPLT
  $B056  D7 35 B0                   JUMPT_abs              $B035
  $B059  41                         LOADL_qimm   ; inline operand = 1
  $B05A  27                         STORE_quick   ; inline operand = 7
 >$B05B  37                         PUSH_quick   ; inline operand = 7
  $B05C  E9 39 8B 02                CALL_abs_imm1          $8B39 (draw_combat_day_header) {bytecode}, $02
  $B060  40                         LOADL_qimm   ; inline operand = 0
  $B061  25                         STORE_quick   ; inline operand = 5
 >$B062  DE FC FF                   LEAL_far               $FFFC
  $B065  B3                         PUSHL
  $B066  05                         LOADL_quick   ; inline operand = 5
  $B067  D2                         LSHIFT1
  $B068  B4                         POPR
  $B069  BB                         ADD
  $B06A  B0                         DEREF
  $B06B  B0                         DEREF
  $B06C  50                         LOADR_qimm   ; inline operand = 0
  $B06D  C3                         SCMPLE
  $B06E  D8 7F B0                   JUMPF_abs              $B07F
  $B071  35                         PUSH_quick   ; inline operand = 5
  $B072  E9 8F 83 02                CALL_abs_imm1          $838F (get_battle_side_province) {bytecode}, $02
  $B076  A8 57 6F                   STORE_abs              $6F57 (battle_winner_province_sel)
  $B079  64                         PUSH_qimm   ; inline operand = 4
  $B07A  E9 3B AF 02                CALL_abs_imm1          $AF3B (dispatch_battle_resolution) {bytecode}, $02
  $B07E  CF                         RETURN
 >$B07F  05                         LOADL_quick   ; inline operand = 5
  $B080  D0                         INC
  $B081  25                         STORE_quick   ; inline operand = 5
  $B082  05                         LOADL_quick   ; inline operand = 5
  $B083  52                         LOADR_qimm   ; inline operand = 2
  $B084  C6                         UCMPLT
  $B085  D7 62 B0                   JUMPT_abs              $B062
  $B088  37                         PUSH_quick   ; inline operand = 7
  $B089  E9 D1 AD 02                CALL_abs_imm1          $ADD1 (run_both_sides_combat_turn) {bytecode}, $02
  $B08D  26                         STORE_quick   ; inline operand = 6
  $B08E  D8 97 B0                   JUMPF_abs              $B097
  $B091  36                         PUSH_quick   ; inline operand = 6
  $B092  E9 3B AF 02                CALL_abs_imm1          $AF3B (dispatch_battle_resolution) {bytecode}, $02
  $B096  CF                         RETURN
 >$B097  DE F8 FF                   LEAL_far               $FFF8
  $B09A  B3                         PUSHL
  $B09B  DE FC FF                   LEAL_far               $FFFC
  $B09E  B3                         PUSHL
  $B09F  E9 0B 83 04                CALL_abs_imm1          $830B (consume_daily_battle_rice) {bytecode}, $04
  $B0A3  07                         LOADL_quick   ; inline operand = 7
  $B0A4  D0                         INC
  $B0A5  27                         STORE_quick   ; inline operand = 7
  $B0A6  07                         LOADL_quick   ; inline operand = 7
  $B0A7  8B 1F                      BYTE_LOADR_imm1        +31
  $B0A9  C6                         UCMPLT
  $B0AA  D7 5B B0                   JUMPT_abs              $B05B
  $B0AD  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $B0B0  A8 57 6F                   STORE_abs              $6F57 (battle_winner_province_sel)
  $B0B3  63                         PUSH_qimm   ; inline operand = 3
  $B0B4  E9 3B AF 02                CALL_abs_imm1          $AF3B (dispatch_battle_resolution) {bytecode}, $02
  $B0B8  CF                         RETURN

