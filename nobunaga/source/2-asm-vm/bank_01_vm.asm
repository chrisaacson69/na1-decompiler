VM bytecode disassembly
  ROM:          Nobunaga's Ambition (USA).nes
  mode:         bulk dump of bank 1
  opcode spec:  vm-opcodes-v2.toml via nobunaga_vm.OPCODE_INFO (execution-validated lengths)
  labels:       1333 CPU addresses named

  bank 1: found 131 bytecode-subroutine stubs

; ============================================================
; sub $8003   (frame_off=+0, body @ $8008)
; ============================================================
  $8008  8E 10 BA                   PUSH_imm2              $BA10 (str_market_panel_nl2)
  $800B  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $800F  0C                         LOADL_quick   ; inline operand = 12
  $8010  8C FF 00                   LOADR_imm2             $00FF
  $8013  C0                         CMPEQ
  $8014  D8 21 80                   JUMPF_abs              $8021
  $8017  8E FD B9                   PUSH_imm2              $B9FD (msg_attack)
  $801A  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $801E  D6 44 80                   JUMP_abs               $8044
 >$8021  3D                         PUSH_quick   ; inline operand = 13
  $8022  0D                         LOADL_quick   ; inline operand = 13
  $8023  8C 8A F9                   LOADR_imm2             $F98A (msg_no_fiefs)
  $8026  C0                         CMPEQ
  $8027  D8 30 80                   JUMPF_abs              $8030
  $802A  8A 11 BA                   LOADL_imm2             $BA11 (str_market_panel_nl1)
  $802D  D6 33 80                   JUMP_abs               $8033
 >$8030  8A 94 F9                   LOADL_imm2             $F994 (msg_fiefs)
 >$8033  B3                         PUSHL
  $8034  0C                         LOADL_quick   ; inline operand = 12
  $8035  D1                         DEC
  $8036  D2                         LSHIFT1
  $8037  8C 16 F8                   LOADR_imm2             $F816 (lord_command_name_ptrs)
  $803A  BB                         ADD
  $803B  B0                         DEREF
  $803C  B3                         PUSHL
  $803D  8E F6 B9                   PUSH_imm2              $B9F6 (msg_s_s_s)
  $8040  E9 34 D1 08                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $08
 >$8044  8E 12 BA                   PUSH_imm2              $BA12 (str_market_panel)
  $8047  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $804B  CF                         RETURN

; ============================================================
; sub $804C   (frame_off=-8, body @ $8051)
; ============================================================
  $8051  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $8054  29                         STORE_quick   ; inline operand = 9
  $8055  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $8058  28                         STORE_quick   ; inline operand = 8
 >$8059  38                         PUSH_quick   ; inline operand = 8
  $805A  39                         PUSH_quick   ; inline operand = 9
  $805B  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $805F  0C                         LOADL_quick   ; inline operand = 12
  $8060  2B                         STORE_quick   ; inline operand = 11
  $8061  AA 9D 6D                   PUSH_abs               $6D9D (scenario_fief_count)
  $8064  61                         PUSH_qimm   ; inline operand = 1
  $8065  E9 9D D5 04                CALL_abs_imm1          $D59D (select_province_by_cursor) {bytecode}, $04
  $8069  2A                         STORE_quick   ; inline operand = 10
  $806A  D7 88 80                   JUMPT_abs              $8088
  $806D  40                         LOADL_qimm   ; inline operand = 0
  $806E  CF                         RETURN
 >$806F  0A                         LOADL_quick   ; inline operand = 10
  $8070  D1                         DEC
  $8071  B3                         PUSHL
  $8072  0B                         LOADL_quick   ; inline operand = 11
  $8073  D3                         BYTE_DEREF
  $8074  B4                         POPR
  $8075  C0                         CMPEQ
  $8076  D8 85 80                   JUMPF_abs              $8085
  $8079  0A                         LOADL_quick   ; inline operand = 10
  $807A  D1                         DEC
  $807B  B3                         PUSHL
  $807C  E9 99 D9 02                CALL_abs_imm1          $D999 (province_state_is_FF) {bytecode}, $02
  $8080  D7 85 80                   JUMPT_abs              $8085
  $8083  0A                         LOADL_quick   ; inline operand = 10
  $8084  CF                         RETURN
 >$8085  0B                         LOADL_quick   ; inline operand = 11
  $8086  D0                         INC
  $8087  2B                         STORE_quick   ; inline operand = 11
 >$8088  0B                         LOADL_quick   ; inline operand = 11
  $8089  D3                         BYTE_DEREF
  $808A  8C FF 00                   LOADR_imm2             $00FF
  $808D  C1                         CMPNE
  $808E  D7 6F 80                   JUMPT_abs              $806F
  $8091  D6 59 80                   JUMP_abs               $8059

; ============================================================
; sub $8094   (frame_off=-2, body @ $8099)
; ============================================================
  $8099  8D 14                      BYTE_PUSH_imm1         +20
  $809B  8D 14                      BYTE_PUSH_imm1         +20
  $809D  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $80A1  8E 14 BA                   PUSH_imm2              $BA14 (msg_market)
  $80A4  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $80A8  8D 15                      BYTE_PUSH_imm1         +21
  $80AA  8D 14                      BYTE_PUSH_imm1         +20
  $80AC  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $80B0  A4 0B 6E                   LOADL_abs              $6E0B (loan_rate)
  $80B3  2B                         STORE_quick   ; inline operand = 11
  $80B4  5A                         LOADR_qimm   ; inline operand = 10
  $80B5  B9                         SMOD
  $80B6  B3                         PUSHL
  $80B7  0B                         LOADL_quick   ; inline operand = 11
  $80B8  5A                         LOADR_qimm   ; inline operand = 10
  $80B9  B6                         SDIV
  $80BA  B3                         PUSHL
  $80BB  8E 1F BA                   PUSH_imm2              $BA1F (msg_rate_2d_1d)
  $80BE  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $80C2  8D 16                      BYTE_PUSH_imm1         +22
  $80C4  8D 14                      BYTE_PUSH_imm1         +20
  $80C6  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $80CA  A4 0D 6E                   LOADL_abs              $6E0D (gold_rice_exchange_rate)
  $80CD  2B                         STORE_quick   ; inline operand = 11
  $80CE  5A                         LOADR_qimm   ; inline operand = 10
  $80CF  B9                         SMOD
  $80D0  B3                         PUSHL
  $80D1  0B                         LOADL_quick   ; inline operand = 11
  $80D2  5A                         LOADR_qimm   ; inline operand = 10
  $80D3  B6                         SDIV
  $80D4  B3                         PUSHL
  $80D5  8E 2D BA                   PUSH_imm2              $BA2D (msg_rice_2d_1d)
  $80D8  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $80DC  8D 17                      BYTE_PUSH_imm1         +23
  $80DE  8D 14                      BYTE_PUSH_imm1         +20
  $80E0  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $80E4  A4 0F 6E                   LOADL_abs              $6E0F (arms_buy_price_rate)
  $80E7  2B                         STORE_quick   ; inline operand = 11
  $80E8  5A                         LOADR_qimm   ; inline operand = 10
  $80E9  B9                         SMOD
  $80EA  B3                         PUSHL
  $80EB  0B                         LOADL_quick   ; inline operand = 11
  $80EC  5A                         LOADR_qimm   ; inline operand = 10
  $80ED  B6                         SDIV
  $80EE  B3                         PUSHL
  $80EF  8E 3B BA                   PUSH_imm2              $BA3B (msg_arms_2d_1d)
  $80F2  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $80F6  8D 18                      BYTE_PUSH_imm1         +24
  $80F8  8D 14                      BYTE_PUSH_imm1         +20
  $80FA  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $80FE  A4 11 6E                   LOADL_abs              $6E11 (gold_men_hire_rate)
  $8101  2B                         STORE_quick   ; inline operand = 11
  $8102  5A                         LOADR_qimm   ; inline operand = 10
  $8103  B9                         SMOD
  $8104  B3                         PUSHL
  $8105  0B                         LOADL_quick   ; inline operand = 11
  $8106  5A                         LOADR_qimm   ; inline operand = 10
  $8107  B6                         SDIV
  $8108  B3                         PUSHL
  $8109  8E 49 BA                   PUSH_imm2              $BA49 (msg_men_2d_1d)
  $810C  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $8110  8D 19                      BYTE_PUSH_imm1         +25
  $8112  8D 14                      BYTE_PUSH_imm1         +20
  $8114  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8118  A4 13 6E                   LOADL_abs              $6E13 (hire_gold_rate)
  $811B  2B                         STORE_quick   ; inline operand = 11
  $811C  5A                         LOADR_qimm   ; inline operand = 10
  $811D  B9                         SMOD
  $811E  B3                         PUSHL
  $811F  0B                         LOADL_quick   ; inline operand = 11
  $8120  5A                         LOADR_qimm   ; inline operand = 10
  $8121  B6                         SDIV
  $8122  B3                         PUSHL
  $8123  8E 57 BA                   PUSH_imm2              $BA57 (str_passed_from_lord)
  $8126  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $812A  41                         LOADL_qimm   ; inline operand = 1
  $812B  A8 F9 7B                   STORE_abs              $7BF9 (ui_state_flag_7bf9)
  $812E  CF                         RETURN

; ============================================================
; sub $812F   (frame_off=-2, body @ $8134)
; ============================================================
  $8134  0C                         LOADL_quick   ; inline operand = 12
  $8135  D9 08 00 01 00 5A 81 02 00 66 81 04 ... SWITCH_noncontig       count=8   ; .table 8 (key,target) + default (noncontiguous); SWITCH 1=>$815A 2=>$8166 4=>$815A 6=>$8166 8=>$8166 15=>$8166 19=>$815A 255=>$8166 default=>$8164
 >$815A  3D                         PUSH_quick   ; inline operand = 13
  $815B  E9 B7 D9 02                CALL_abs_imm1          $D9B7 (is_enemy_owned) {bytecode}, $02
  $815F  D6 63 81                   JUMP_abs               $8163
 >$8162  40                         LOADL_qimm   ; inline operand = 0
 >$8163  2B                         STORE_quick   ; inline operand = 11
 >$8164  0B                         LOADL_quick   ; inline operand = 11
  $8165  CF                         RETURN
 >$8166  3D                         PUSH_quick   ; inline operand = 13
  $8167  E9 B7 D9 02                CALL_abs_imm1          $D9B7 (is_enemy_owned) {bytecode}, $02
  $816B  D7 62 81                   JUMPT_abs              $8162
  $816E  41                         LOADL_qimm   ; inline operand = 1
  $816F  D6 63 81                   JUMP_abs               $8163

; ============================================================
; sub $8172   (frame_off=-4, body @ $8177)
; ============================================================
  $8177  40                         LOADL_qimm   ; inline operand = 0
  $8178  2A                         STORE_quick   ; inline operand = 10
  $8179  40                         LOADL_qimm   ; inline operand = 0
  $817A  2B                         STORE_quick   ; inline operand = 11
  $817B  D6 EE 81                   JUMP_abs               $81EE
 >$817E  0D                         LOADL_quick   ; inline operand = 13
  $817F  D1                         DEC
  $8180  D3                         BYTE_DEREF
  $8181  B3                         PUSHL
  $8182  3C                         PUSH_quick   ; inline operand = 12
  $8183  E9 2F 81 04                CALL_abs_imm1          $812F (target_eligible_by_cmd) {bytecode}, $04
  $8187  D8 EE 81                   JUMPF_abs              $81EE
  $818A  0D                         LOADL_quick   ; inline operand = 13
  $818B  D1                         DEC
  $818C  D3                         BYTE_DEREF
  $818D  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $8190  BB                         ADD
  $8191  D3                         BYTE_DEREF
  $8192  8C FF 00                   LOADR_imm2             $00FF
  $8195  C1                         CMPNE
  $8196  D8 EE 81                   JUMPF_abs              $81EE
  $8199  0B                         LOADL_quick   ; inline operand = 11
  $819A  D0                         INC
  $819B  2B                         STORE_quick   ; inline operand = 11
  $819C  0E                         LOADL_quick   ; inline operand = 14
  $819D  D8 EE 81                   JUMPF_abs              $81EE
  $81A0  0D                         LOADL_quick   ; inline operand = 13
  $81A1  D1                         DEC
  $81A2  D3                         BYTE_DEREF
  $81A3  D0                         INC
  $81A4  B3                         PUSHL
  $81A5  8E 65 BA                   PUSH_imm2              $BA65 (msg_fmt__2d_ba65)
  $81A8  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $81AC  0A                         LOADL_quick   ; inline operand = 10
  $81AD  D0                         INC
  $81AE  2A                         STORE_quick   ; inline operand = 10
  $81AF  0A                         LOADL_quick   ; inline operand = 10
  $81B0  8B 12                      BYTE_LOADR_imm1        +18
  $81B2  C1                         CMPNE
  $81B3  D8 C7 81                   JUMPF_abs              $81C7
  $81B6  0A                         LOADL_quick   ; inline operand = 10
  $81B7  56                         LOADR_qimm   ; inline operand = 6
  $81B8  BA                         UMOD
  $81B9  D7 C0 81                   JUMPT_abs              $81C0
  $81BC  4A                         LOADL_qimm   ; inline operand = 10
  $81BD  D6 C2 81                   JUMP_abs               $81C2
 >$81C0  89 20                      BYTE_LOADL_imm1        +32
 >$81C2  B3                         PUSHL
  $81C3  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
 >$81C7  0A                         LOADL_quick   ; inline operand = 10
  $81C8  8B 12                      BYTE_LOADR_imm1        +18
  $81CA  C0                         CMPEQ
  $81CB  D8 EE 81                   JUMPF_abs              $81EE
  $81CE  0D                         LOADL_quick   ; inline operand = 13
  $81CF  D3                         BYTE_DEREF
  $81D0  8C FF 00                   LOADR_imm2             $00FF
  $81D3  C1                         CMPNE
  $81D4  D8 EE 81                   JUMPF_abs              $81EE
  $81D7  AC 09 D6                   CALL_abs               $D609 (ui_prompt_redraw) {bytecode}
  $81DA  52                         LOADR_qimm   ; inline operand = 2
  $81DB  C0                         CMPEQ
  $81DC  D8 E4 81                   JUMPF_abs              $81E4
  $81DF  40                         LOADL_qimm   ; inline operand = 0
  $81E0  2B                         STORE_quick   ; inline operand = 11
  $81E1  D6 FA 81                   JUMP_abs               $81FA
 >$81E4  8E 69 BA                   PUSH_imm2              $BA69 (str_fief_list_columns)
  $81E7  3C                         PUSH_quick   ; inline operand = 12
  $81E8  E9 03 80 04                CALL_abs_imm1          $8003 (prompt_message_and_redraw) {bytecode}, $04
  $81EC  40                         LOADL_qimm   ; inline operand = 0
  $81ED  2A                         STORE_quick   ; inline operand = 10
 >$81EE  0D                         LOADL_quick   ; inline operand = 13
  $81EF  D0                         INC
  $81F0  2D                         STORE_quick   ; inline operand = 13
  $81F1  D1                         DEC
  $81F2  D3                         BYTE_DEREF
  $81F3  8C FF 00                   LOADR_imm2             $00FF
  $81F6  C1                         CMPNE
  $81F7  D7 7E 81                   JUMPT_abs              $817E
 >$81FA  0B                         LOADL_quick   ; inline operand = 11
  $81FB  CF                         RETURN

; ============================================================
; sub $81FC   (frame_off=-4, body @ $8201)
; ============================================================
  $8201  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8204  A6 63 6F                   LOADR_abs              $6F63 (battle_defending_province)
  $8207  C6                         UCMPLT
  $8208  D8 17 82                   JUMPF_abs              $8217
  $820B  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $820E  8B 36                      BYTE_LOADR_imm1        +54
  $8210  B5                         MULT
  $8211  A6 63 6F                   LOADR_abs              $6F63 (battle_defending_province)
  $8214  D6 20 82                   JUMP_abs               $8220
 >$8217  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $821A  8B 36                      BYTE_LOADR_imm1        +54
  $821C  B5                         MULT
  $821D  A6 5F 6F                   LOADR_abs              $6F5F (selected_province_idx)
 >$8220  BB                         ADD
  $8221  8C 93 61                   LOADR_imm2             $6193
  $8224  BB                         ADD
  $8225  B3                         PUSHL
  $8226  40                         LOADL_qimm   ; inline operand = 0
  $8227  D4                         BYTE_POPSTORE
  $8228  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $822B  2B                         STORE_quick   ; inline operand = 11
  $822C  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $822F  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $8233  2A                         STORE_quick   ; inline operand = 10
  $8234  0B                         LOADL_quick   ; inline operand = 11
  $8235  1A                         LOADR_quick   ; inline operand = 10
  $8236  C6                         UCMPLT
  $8237  D8 42 82                   JUMPF_abs              $8242
  $823A  0A                         LOADL_quick   ; inline operand = 10
  $823B  8B 36                      BYTE_LOADR_imm1        +54
  $823D  B5                         MULT
  $823E  1B                         LOADR_quick   ; inline operand = 11
  $823F  D6 47 82                   JUMP_abs               $8247
 >$8242  0B                         LOADL_quick   ; inline operand = 11
  $8243  8B 36                      BYTE_LOADR_imm1        +54
  $8245  B5                         MULT
  $8246  1A                         LOADR_quick   ; inline operand = 10
 >$8247  BB                         ADD
  $8248  8C 93 61                   LOADR_imm2             $6193
  $824B  BB                         ADD
  $824C  B3                         PUSHL
  $824D  40                         LOADL_qimm   ; inline operand = 0
  $824E  D4                         BYTE_POPSTORE
  $824F  CF                         RETURN

; ============================================================
; sub $8250   (frame_off=+0, body @ $8255)
; ============================================================
  $8255  0C                         LOADL_quick   ; inline operand = 12
  $8256  1D                         LOADR_quick   ; inline operand = 13
  $8257  C6                         UCMPLT
  $8258  1E                         LOADR_quick   ; inline operand = 14
  $8259  DC                         XOR
  $825A  D8 65 82                   JUMPF_abs              $8265
  $825D  0C                         LOADL_quick   ; inline operand = 12
  $825E  8B 36                      BYTE_LOADR_imm1        +54
  $8260  B5                         MULT
  $8261  1D                         LOADR_quick   ; inline operand = 13
  $8262  D6 6A 82                   JUMP_abs               $826A
 >$8265  0D                         LOADL_quick   ; inline operand = 13
  $8266  8B 36                      BYTE_LOADR_imm1        +54
  $8268  B5                         MULT
  $8269  1C                         LOADR_quick   ; inline operand = 12
 >$826A  BB                         ADD
  $826B  8C 93 61                   LOADR_imm2             $6193
  $826E  BB                         ADD
  $826F  D3                         BYTE_DEREF
  $8270  CF                         RETURN

; ============================================================
; sub $8271   (frame_off=+0, body @ $8276)
; ============================================================
  $8276  61                         PUSH_qimm   ; inline operand = 1
  $8277  3D                         PUSH_quick   ; inline operand = 13
  $8278  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $827C  B3                         PUSHL
  $827D  3C                         PUSH_quick   ; inline operand = 12
  $827E  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $8282  B3                         PUSHL
  $8283  E9 50 82 06                CALL_abs_imm1          $8250 (relations_matrix_get) {bytecode}, $06
  $8287  B3                         PUSHL
  $8288  8D 64                      BYTE_PUSH_imm1         +100
  $828A  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $828E  B4                         POPR
  $828F  C6                         UCMPLT
  $8290  D7 AA 82                   JUMPT_abs              $82AA
  $8293  60                         PUSH_qimm   ; inline operand = 0
  $8294  3D                         PUSH_quick   ; inline operand = 13
  $8295  3C                         PUSH_quick   ; inline operand = 12
  $8296  E9 50 82 06                CALL_abs_imm1          $8250 (relations_matrix_get) {bytecode}, $06
  $829A  B3                         PUSHL
  $829B  8D 64                      BYTE_PUSH_imm1         +100
  $829D  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $82A1  B4                         POPR
  $82A2  C6                         UCMPLT
  $82A3  D7 AA 82                   JUMPT_abs              $82AA
  $82A6  40                         LOADL_qimm   ; inline operand = 0
  $82A7  D6 AB 82                   JUMP_abs               $82AB
 >$82AA  41                         LOADL_qimm   ; inline operand = 1
 >$82AB  CF                         RETURN

; ============================================================
; sub $82AC   (frame_off=+0, body @ $82B1)
; ============================================================
  $82B1  3C                         PUSH_quick   ; inline operand = 12
  $82B2  0C                         LOADL_quick   ; inline operand = 12
  $82B3  B0                         DEREF
  $82B4  B3                         PUSHL
  $82B5  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $82B8  8B 1A                      BYTE_LOADR_imm1        +26
  $82BA  B5                         MULT
  $82BB  8C 19 70                   LOADR_imm2             $7019
  $82BE  BB                         ADD
  $82BF  B0                         DEREF
  $82C0  B3                         PUSHL
  $82C1  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $82C5  B1                         POPSTORE
  $82C6  3C                         PUSH_quick   ; inline operand = 12
  $82C7  0C                         LOADL_quick   ; inline operand = 12
  $82C8  B0                         DEREF
  $82C9  50                         LOADR_qimm   ; inline operand = 0
  $82CA  C2                         SCMPLT
  $82CB  D8 D2 82                   JUMPF_abs              $82D2
  $82CE  40                         LOADL_qimm   ; inline operand = 0
  $82CF  D6 D4 82                   JUMP_abs               $82D4
 >$82D2  0C                         LOADL_quick   ; inline operand = 12
  $82D3  B0                         DEREF
 >$82D4  B1                         POPSTORE
  $82D5  CF                         RETURN

; ============================================================
; sub $82D6   (frame_off=-4, body @ $82DB)
; ============================================================
  $82DB  0D                         LOADL_quick   ; inline operand = 13
  $82DC  50                         LOADR_qimm   ; inline operand = 0
  $82DD  C2                         SCMPLT
  $82DE  2B                         STORE_quick   ; inline operand = 11
  $82DF  D8 EA 82                   JUMPF_abs              $82EA
  $82E2  3D                         PUSH_quick   ; inline operand = 13
  $82E3  E9 4C CB 02                CALL_abs_imm1          $CB4C (abs16) {bytecode}, $02
  $82E7  D6 EB 82                   JUMP_abs               $82EB
 >$82EA  0D                         LOADL_quick   ; inline operand = 13
 >$82EB  B3                         PUSHL
  $82EC  3C                         PUSH_quick   ; inline operand = 12
  $82ED  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $82F1  2A                         STORE_quick   ; inline operand = 10
  $82F2  0B                         LOADL_quick   ; inline operand = 11
  $82F3  D8 FC 82                   JUMPF_abs              $82FC
  $82F6  0C                         LOADL_quick   ; inline operand = 12
  $82F7  1A                         LOADR_quick   ; inline operand = 10
  $82F8  BC                         SUB
  $82F9  D6 00 83                   JUMP_abs               $8300
 >$82FC  0C                         LOADL_quick   ; inline operand = 12
  $82FD  CD                         SWAP
  $82FE  0A                         LOADL_quick   ; inline operand = 10
  $82FF  BB                         ADD
 >$8300  2A                         STORE_quick   ; inline operand = 10
  $8301  0A                         LOADL_quick   ; inline operand = 10
  $8302  CF                         RETURN

; ============================================================
; sub $8303   (frame_off=+0, body @ $8308)
; ============================================================
  $8308  0D                         LOADL_quick   ; inline operand = 13
  $8309  B7 25                      LONG                   $25
  $830B  B7 14                      LONG                   $14
  $830D  0C                         LOADL_quick   ; inline operand = 12
  $830E  B7 25                      LONG                   $25
  $8310  B7 15                      LONG                   $15
  $8312  B7 01                      LONG                   $01
  $8314  B7 19 09 00 00 00          LONG                   $19 $09 $00 $00 $00
  $831A  B7 03                      LONG                   $03
  $831C  B7 19 0A 00 00 00          LONG                   $19 $0A $00 $00 $00
  $8322  B7 02                      LONG                   $02
  $8324  B7 27                      LONG                   $27
  $8326  CF                         RETURN

; ============================================================
; sub $8327   (frame_off=+0, body @ $832C)
; ============================================================
  $832C  3D                         PUSH_quick   ; inline operand = 13
  $832D  3C                         PUSH_quick   ; inline operand = 12
  $832E  E9 03 83 04                CALL_abs_imm1          $8303 (math32_muladddiv) {bytecode}, $04
  $8332  1E                         LOADR_quick   ; inline operand = 14
  $8333  C4                         SCMPGT
  $8334  D8 40 83                   JUMPF_abs              $8340
  $8337  B7 18 FF FF FF FF          LONG                   $18 $FF $FF $FF $FF
  $833D  D6 54 83                   JUMP_abs               $8354
 >$8340  0D                         LOADL_quick   ; inline operand = 13
  $8341  B7 25                      LONG                   $25
  $8343  B7 14                      LONG                   $14
  $8345  0C                         LOADL_quick   ; inline operand = 12
  $8346  B7 25                      LONG                   $25
  $8348  B7 15                      LONG                   $15
  $834A  B7 01                      LONG                   $01
  $834C  B7 19 0A 00 00 00          LONG                   $19 $0A $00 $00 $00
  $8352  B7 02                      LONG                   $02
 >$8354  B7 27                      LONG                   $27
  $8356  CF                         RETURN

; ============================================================
; sub $8357   (frame_off=+0, body @ $835C)
; ============================================================
  $835C  3E                         PUSH_quick   ; inline operand = 14
  $835D  0D                         LOADL_quick   ; inline operand = 13
  $835E  B7 25                      LONG                   $25
  $8360  B7 14                      LONG                   $14
  $8362  0C                         LOADL_quick   ; inline operand = 12
  $8363  B7 25                      LONG                   $25
  $8365  B7 19 0A 00 00 00          LONG                   $19 $0A $00 $00 $00
  $836B  B7 01                      LONG                   $01
  $836D  B7 15                      LONG                   $15
  $836F  B7 02                      LONG                   $02
  $8371  B7 27                      LONG                   $27
  $8373  B3                         PUSHL
  $8374  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $8378  CF                         RETURN

; ============================================================
; sub $8379   (frame_off=-2, body @ $837E)
; ============================================================
  $837E  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $8381  2B                         STORE_quick   ; inline operand = 11
  $8382  41                         LOADL_qimm   ; inline operand = 1
  $8383  A8 63 6D                   STORE_abs              $6D63 (const_two)
  $8386  3D                         PUSH_quick   ; inline operand = 13
  $8387  3C                         PUSH_quick   ; inline operand = 12
  $8388  E9 40 D9 04                CALL_abs_imm1          $D940 (record_apply_two_grows) {bytecode}, $04
  $838C  3D                         PUSH_quick   ; inline operand = 13
  $838D  0C                         LOADL_quick   ; inline operand = 12
  $838E  B4                         POPR
  $838F  B3                         PUSHL
  $8390  B0                         DEREF
  $8391  BC                         SUB
  $8392  B1                         POPSTORE
  $8393  0C                         LOADL_quick   ; inline operand = 12
  $8394  B0                         DEREF
  $8395  50                         LOADR_qimm   ; inline operand = 0
  $8396  C2                         SCMPLT
  $8397  D8 9D 83                   JUMPF_abs              $839D
  $839A  3C                         PUSH_quick   ; inline operand = 12
  $839B  40                         LOADL_qimm   ; inline operand = 0
  $839C  B1                         POPSTORE
 >$839D  0B                         LOADL_quick   ; inline operand = 11
  $839E  A8 63 6D                   STORE_abs              $6D63 (const_two)
  $83A1  CF                         RETURN

; ============================================================
; sub $83A2   (frame_off=+0, body @ $83A7)
; ============================================================
  $83A7  0C                         LOADL_quick   ; inline operand = 12
  $83A8  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $83AB  BB                         ADD
  $83AC  D3                         BYTE_DEREF
  $83AD  8C FF 00                   LOADR_imm2             $00FF
  $83B0  C1                         CMPNE
  $83B1  D8 BF 83                   JUMPF_abs              $83BF
  $83B4  3D                         PUSH_quick   ; inline operand = 13
  $83B5  8E 6B BA                   PUSH_imm2              $BA6B (msg_fmt__4d)
  $83B8  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $83BC  D6 C6 83                   JUMP_abs               $83C6
 >$83BF  8E 6F BA                   PUSH_imm2              $BA6F (str_field_dashes)
  $83C2  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$83C6  CF                         RETURN

; ============================================================
; sub $83C7   (frame_off=+0, body @ $83CC)
; ============================================================
  $83CC  3C                         PUSH_quick   ; inline operand = 12
  $83CD  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $83D0  E9 A2 83 04                CALL_abs_imm1          $83A2 (draw_province_stat_or_dashes) {bytecode}, $04
  $83D4  CF                         RETURN

; ============================================================
; sub $83D5   (frame_off=+0, body @ $83DA)
; ============================================================
  $83DA  0C                         LOADL_quick   ; inline operand = 12
  $83DB  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $83DE  BB                         ADD
  $83DF  D3                         BYTE_DEREF
  $83E0  8C FF 00                   LOADR_imm2             $00FF
  $83E3  C1                         CMPNE
  $83E4  D8 F2 83                   JUMPF_abs              $83F2
  $83E7  3D                         PUSH_quick   ; inline operand = 13
  $83E8  8E 74 BA                   PUSH_imm2              $BA74 (msg_fmt__3d_ba74)
  $83EB  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $83EF  D6 F9 83                   JUMP_abs               $83F9
 >$83F2  8E 78 BA                   PUSH_imm2              $BA78 (str_field_dashes3)
  $83F5  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$83F9  CF                         RETURN

; ============================================================
; sub $83FA   (frame_off=-12, body @ $83FF)
; ============================================================
  $83FF  AC 20 CD                   CALL_abs               $CD20 (repaint_screen) {bytecode}
  $8402  61                         PUSH_qimm   ; inline operand = 1
  $8403  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $8407  8D 23                      BYTE_PUSH_imm1         +35
  $8409  67                         PUSH_qimm   ; inline operand = 7
  $840A  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $840E  8D 25                      BYTE_PUSH_imm1         +37
  $8410  6B                         PUSH_qimm   ; inline operand = 11
  $8411  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8415  8D 2B                      BYTE_PUSH_imm1         +43
  $8417  6F                         PUSH_qimm   ; inline operand = 15
  $8418  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $841C  62                         PUSH_qimm   ; inline operand = 2
  $841D  6B                         PUSH_qimm   ; inline operand = 11
  $841E  66                         PUSH_qimm   ; inline operand = 6
  $841F  6B                         PUSH_qimm   ; inline operand = 11
  $8420  62                         PUSH_qimm   ; inline operand = 2
  $8421  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8425  63                         PUSH_qimm   ; inline operand = 3
  $8426  8D 12                      BYTE_PUSH_imm1         +18
  $8428  64                         PUSH_qimm   ; inline operand = 4
  $8429  6D                         PUSH_qimm   ; inline operand = 13
  $842A  62                         PUSH_qimm   ; inline operand = 2
  $842B  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $842F  63                         PUSH_qimm   ; inline operand = 3
  $8430  65                         PUSH_qimm   ; inline operand = 5
  $8431  8D 13                      BYTE_PUSH_imm1         +19
  $8433  64                         PUSH_qimm   ; inline operand = 4
  $8434  6A                         PUSH_qimm   ; inline operand = 10
  $8435  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8439  61                         PUSH_qimm   ; inline operand = 1
  $843A  8D 12                      BYTE_PUSH_imm1         +18
  $843C  6E                         PUSH_qimm   ; inline operand = 14
  $843D  67                         PUSH_qimm   ; inline operand = 7
  $843E  6A                         PUSH_qimm   ; inline operand = 10
  $843F  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8443  62                         PUSH_qimm   ; inline operand = 2
  $8444  64                         PUSH_qimm   ; inline operand = 4
  $8445  8D 1D                      BYTE_PUSH_imm1         +29
  $8447  64                         PUSH_qimm   ; inline operand = 4
  $8448  8D 16                      BYTE_PUSH_imm1         +22
  $844A  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $844E  62                         PUSH_qimm   ; inline operand = 2
  $844F  8D 12                      BYTE_PUSH_imm1         +18
  $8451  8D 17                      BYTE_PUSH_imm1         +23
  $8453  66                         PUSH_qimm   ; inline operand = 6
  $8454  8D 17                      BYTE_PUSH_imm1         +23
  $8456  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $845A  41                         LOADL_qimm   ; inline operand = 1
  $845B  A8 C9 7F                   STORE_abs              $7FC9 (ui_pending_flag_7fc9)
  $845E  63                         PUSH_qimm   ; inline operand = 3
  $845F  62                         PUSH_qimm   ; inline operand = 2
  $8460  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8464  AC 77 D6                   CALL_abs               $D677 (draw_current_year) {bytecode}
  $8467  63                         PUSH_qimm   ; inline operand = 3
  $8468  67                         PUSH_qimm   ; inline operand = 7
  $8469  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $846D  AC 87 D6                   CALL_abs               $D687 (draw_current_season) {bytecode}
  $8470  3C                         PUSH_quick   ; inline operand = 12
  $8471  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $8475  65                         PUSH_qimm   ; inline operand = 5
  $8476  6A                         PUSH_qimm   ; inline operand = 10
  $8477  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $847B  3C                         PUSH_quick   ; inline operand = 12
  $847C  E9 99 D9 02                CALL_abs_imm1          $D999 (province_state_is_FF) {bytecode}, $02
  $8480  D8 87 84                   JUMPF_abs              $8487
  $8483  40                         LOADL_qimm   ; inline operand = 0
  $8484  D6 88 84                   JUMP_abs               $8488
 >$8487  41                         LOADL_qimm   ; inline operand = 1
 >$8488  28                         STORE_quick   ; inline operand = 8
  $8489  D8 C3 84                   JUMPF_abs              $84C3
  $848C  0C                         LOADL_quick   ; inline operand = 12
  $848D  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $8490  BB                         ADD
  $8491  D3                         BYTE_DEREF
  $8492  26                         STORE_quick   ; inline operand = 6
  $8493  3C                         PUSH_quick   ; inline operand = 12
  $8494  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $8498  D8 B9 84                   JUMPF_abs              $84B9
  $849B  06                         LOADL_quick   ; inline operand = 6
  $849C  D8 A3 84                   JUMPF_abs              $84A3
  $849F  40                         LOADL_qimm   ; inline operand = 0
  $84A0  D6 A9 84                   JUMP_abs               $84A9
 >$84A3  0C                         LOADL_quick   ; inline operand = 12
  $84A4  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $84A7  BB                         ADD
  $84A8  D3                         BYTE_DEREF
 >$84A9  D2                         LSHIFT1
  $84AA  8C D4 F7                   LOADR_imm2             $F7D4 (governance_policy_name_ptrs)
  $84AD  BB                         ADD
  $84AE  B0                         DEREF
  $84AF  D6 B5 84                   JUMP_abs               $84B5
 >$84B2  8A 7C BA                   LOADL_imm2             $BA7C (msg_home_fief)
 >$84B5  B3                         PUSHL
  $84B6  D6 C6 84                   JUMP_abs               $84C6
 >$84B9  06                         LOADL_quick   ; inline operand = 6
  $84BA  D7 B2 84                   JUMPT_abs              $84B2
  $84BD  8A 86 BA                   LOADL_imm2             $BA86 (msg_direct)
  $84C0  D6 B5 84                   JUMP_abs               $84B5
 >$84C3  8E 8D BA                   PUSH_imm2              $BA8D (msg_empty)
 >$84C6  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $84CA  63                         PUSH_qimm   ; inline operand = 3
  $84CB  6E                         PUSH_qimm   ; inline operand = 14
  $84CC  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $84D0  0C                         LOADL_quick   ; inline operand = 12
  $84D1  D0                         INC
  $84D2  B3                         PUSHL
  $84D3  8E 93 BA                   PUSH_imm2              $BA93 (msg_fief_2d_ba93)
  $84D6  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $84DA  63                         PUSH_qimm   ; inline operand = 3
  $84DB  8D 16                      BYTE_PUSH_imm1         +22
  $84DD  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $84E1  3C                         PUSH_quick   ; inline operand = 12
  $84E2  E9 D3 D9 02                CALL_abs_imm1          $D9D3 (redraw_window_row) {bytecode}, $02
  $84E6  64                         PUSH_qimm   ; inline operand = 4
  $84E7  6A                         PUSH_qimm   ; inline operand = 10
  $84E8  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $84EC  08                         LOADL_quick   ; inline operand = 8
  $84ED  D8 F8 84                   JUMPF_abs              $84F8
  $84F0  3C                         PUSH_quick   ; inline operand = 12
  $84F1  E9 4B DB 02                CALL_abs_imm1          $DB4B (draw_owner_name) {bytecode}, $02
  $84F5  D6 FF 84                   JUMP_abs               $84FF
 >$84F8  8E 9C BA                   PUSH_imm2              $BA9C (str_fief_info_labels)
  $84FB  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$84FF  3C                         PUSH_quick   ; inline operand = 12
  $8500  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $8504  2A                         STORE_quick   ; inline operand = 10
  $8505  0C                         LOADL_quick   ; inline operand = 12
  $8506  8B 1A                      BYTE_LOADR_imm1        +26
  $8508  B5                         MULT
  $8509  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $850C  BB                         ADD
  $850D  27                         STORE_quick   ; inline operand = 7
  $850E  29                         STORE_quick   ; inline operand = 9
  $850F  40                         LOADL_qimm   ; inline operand = 0
  $8510  2B                         STORE_quick   ; inline operand = 11
 >$8511  0B                         LOADL_quick   ; inline operand = 11
  $8512  56                         LOADR_qimm   ; inline operand = 6
  $8513  C6                         UCMPLT
  $8514  D8 1E 85                   JUMPF_abs              $851E
  $8517  0B                         LOADL_quick   ; inline operand = 11
  $8518  7D                         ADD_qimm   ; inline operand = 13
  $8519  B3                         PUSHL
  $851A  62                         PUSH_qimm   ; inline operand = 2
  $851B  D6 22 85                   JUMP_abs               $8522
 >$851E  0B                         LOADL_quick   ; inline operand = 11
  $851F  D0                         INC
  $8520  B3                         PUSHL
  $8521  6A                         PUSH_qimm   ; inline operand = 10
 >$8522  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8526  0B                         LOADL_quick   ; inline operand = 11
  $8527  D2                         LSHIFT1
  $8528  8C AE F8                   LOADR_imm2             $F8AE (fief_stat_name_ptrs)
  $852B  BB                         ADD
  $852C  B0                         DEREF
  $852D  B3                         PUSHL
  $852E  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8532  0B                         LOADL_quick   ; inline operand = 11
  $8533  56                         LOADR_qimm   ; inline operand = 6
  $8534  C6                         UCMPLT
  $8535  D8 4A 85                   JUMPF_abs              $854A
  $8538  46                         LOADL_qimm   ; inline operand = 6
  $8539  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $853C  0A                         LOADL_quick   ; inline operand = 10
  $853D  D0                         INC
  $853E  2A                         STORE_quick   ; inline operand = 10
  $853F  D1                         DEC
  $8540  D3                         BYTE_DEREF
  $8541  B3                         PUSHL
  $8542  3C                         PUSH_quick   ; inline operand = 12
  $8543  E9 D5 83 04                CALL_abs_imm1          $83D5 (draw_province_stat3_or_dashes) {bytecode}, $04
  $8547  D6 5B 85                   JUMP_abs               $855B
 >$854A  89 10                      BYTE_LOADL_imm1        +16
  $854C  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $854F  09                         LOADL_quick   ; inline operand = 9
  $8550  72                         ADD_qimm   ; inline operand = 2
  $8551  29                         STORE_quick   ; inline operand = 9
  $8552  8F FE                      BYTE_ADD_imm1          -2
  $8554  B0                         DEREF
  $8555  B3                         PUSHL
  $8556  3C                         PUSH_quick   ; inline operand = 12
  $8557  E9 A2 83 04                CALL_abs_imm1          $83A2 (draw_province_stat_or_dashes) {bytecode}, $04
 >$855B  0B                         LOADL_quick   ; inline operand = 11
  $855C  D0                         INC
  $855D  2B                         STORE_quick   ; inline operand = 11
  $855E  0B                         LOADL_quick   ; inline operand = 11
  $855F  8B 12                      BYTE_LOADR_imm1        +18
  $8561  C6                         UCMPLT
  $8562  D7 11 85                   JUMPT_abs              $8511
  $8565  08                         LOADL_quick   ; inline operand = 8
  $8566  D8 8C 85                   JUMPF_abs              $858C
  $8569  3C                         PUSH_quick   ; inline operand = 12
  $856A  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $856E  A8 5B 6F                   STORE_abs              $6F5B (active_province_idx_copy)
  $8571  64                         PUSH_qimm   ; inline operand = 4
  $8572  62                         PUSH_qimm   ; inline operand = 2
  $8573  E9 6F E7 04                CALL_abs_imm1          $E76F (draw_daimyo_portrait) {bytecode}, $04
  $8577  3C                         PUSH_quick   ; inline operand = 12
  $8578  E9 72 D9 02                CALL_abs_imm1          $D972 (fief_owner_weakness) {bytecode}, $02
  $857C  D8 8C 85                   JUMPF_abs              $858C
  $857F  6B                         PUSH_qimm   ; inline operand = 11
  $8580  62                         PUSH_qimm   ; inline operand = 2
  $8581  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8585  8E A5 BA                   PUSH_imm2              $BAA5 (msg_sick)
  $8588  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$858C  60                         PUSH_qimm   ; inline operand = 0
  $858D  E9 1E 87 02                CALL_abs_imm1          $871E (fief_info_display) {bytecode}, $02
  $8591  AC 94 80                   CALL_abs               $8094 (draw_market_rates) {bytecode}
  $8594  60                         PUSH_qimm   ; inline operand = 0
  $8595  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $8599  CF                         RETURN

; ============================================================
; sub $859A   (frame_off=+0, body @ $859F)
; ============================================================
  $859F  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $85A2  E9 FA 83 02                CALL_abs_imm1          $83FA (effect_view_a) {bytecode}, $02
  $85A6  CF                         RETURN

; ============================================================
; sub $85A7   (frame_off=+0, body @ $85AC)
; ============================================================
  $85AC  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $85AF  E9 FA 83 02                CALL_abs_imm1          $83FA (effect_view_a) {bytecode}, $02
  $85B3  CF                         RETURN

; ============================================================
; sub $85B4   (frame_off=-6, body @ $85B9)
; ============================================================
  $85B9  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $85BC  2A                         STORE_quick   ; inline operand = 10
  $85BD  0C                         LOADL_quick   ; inline operand = 12
  $85BE  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $85C1  BB                         ADD
  $85C2  D3                         BYTE_DEREF
  $85C3  D8 D9 85                   JUMPF_abs              $85D9
  $85C6  8E AA BA                   PUSH_imm2              $BAAA (msg_home)
  $85C9  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $85CD  0A                         LOADL_quick   ; inline operand = 10
  $85CE  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $85D1  8E B0 BA                   PUSH_imm2              $BAB0 (msg_fief_bab0)
  $85D4  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $85D8  CF                         RETURN
 >$85D9  3C                         PUSH_quick   ; inline operand = 12
  $85DA  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $85DE  D2                         LSHIFT1
  $85DF  8C E9 FE                   LOADR_imm2             $FEE9 (governance_state_label_ptrs)
  $85E2  BB                         ADD
  $85E3  B0                         DEREF
  $85E4  B3                         PUSHL
  $85E5  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $85E9  CF                         RETURN

; ============================================================
; sub $85EA   (frame_off=-14, body @ $85EF)
; ============================================================
  $85EF  8A 89 6F                   LOADL_imm2             $6F89
  $85F2  2B                         STORE_quick   ; inline operand = 11
  $85F3  40                         LOADL_qimm   ; inline operand = 0
  $85F4  D6 15 86                   JUMP_abs               $8615
 >$85F7  38                         PUSH_quick   ; inline operand = 8
  $85F8  E9 B7 D9 02                CALL_abs_imm1          $D9B7 (is_enemy_owned) {bytecode}, $02
  $85FC  D8 13 86                   JUMPF_abs              $8613
  $85FF  08                         LOADL_quick   ; inline operand = 8
  $8600  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $8603  BB                         ADD
  $8604  D3                         BYTE_DEREF
  $8605  8C FF 00                   LOADR_imm2             $00FF
  $8608  C1                         CMPNE
  $8609  D8 13 86                   JUMPF_abs              $8613
  $860C  0B                         LOADL_quick   ; inline operand = 11
  $860D  D0                         INC
  $860E  2B                         STORE_quick   ; inline operand = 11
  $860F  D1                         DEC
  $8610  B3                         PUSHL
  $8611  08                         LOADL_quick   ; inline operand = 8
  $8612  D4                         BYTE_POPSTORE
 >$8613  08                         LOADL_quick   ; inline operand = 8
  $8614  D0                         INC
 >$8615  28                         STORE_quick   ; inline operand = 8
  $8616  08                         LOADL_quick   ; inline operand = 8
  $8617  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $861A  C6                         UCMPLT
  $861B  D7 F7 85                   JUMPT_abs              $85F7
  $861E  3B                         PUSH_quick   ; inline operand = 11
  $861F  89 FF                      BYTE_LOADL_imm1        -1
  $8621  D4                         BYTE_POPSTORE
  $8622  40                         LOADL_qimm   ; inline operand = 0
  $8623  2A                         STORE_quick   ; inline operand = 10
  $8624  8A 89 6F                   LOADL_imm2             $6F89
  $8627  D6 05 87                   JUMP_abs               $8705
 >$862A  0A                         LOADL_quick   ; inline operand = 10
  $862B  D7 64 86                   JUMPT_abs              $8664
  $862E  AC 20 CD                   CALL_abs               $CD20 (repaint_screen) {bytecode}
  $8631  61                         PUSH_qimm   ; inline operand = 1
  $8632  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $8636  8D 2B                      BYTE_PUSH_imm1         +43
  $8638  67                         PUSH_qimm   ; inline operand = 7
  $8639  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $863D  8D 23                      BYTE_PUSH_imm1         +35
  $863F  6B                         PUSH_qimm   ; inline operand = 11
  $8640  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8644  61                         PUSH_qimm   ; inline operand = 1
  $8645  63                         PUSH_qimm   ; inline operand = 3
  $8646  65                         PUSH_qimm   ; inline operand = 5
  $8647  63                         PUSH_qimm   ; inline operand = 3
  $8648  62                         PUSH_qimm   ; inline operand = 2
  $8649  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $864D  62                         PUSH_qimm   ; inline operand = 2
  $864E  8D 11                      BYTE_PUSH_imm1         +17
  $8650  67                         PUSH_qimm   ; inline operand = 7
  $8651  65                         PUSH_qimm   ; inline operand = 5
  $8652  62                         PUSH_qimm   ; inline operand = 2
  $8653  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $8657  63                         PUSH_qimm   ; inline operand = 3
  $8658  62                         PUSH_qimm   ; inline operand = 2
  $8659  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $865D  8E B5 BA                   PUSH_imm2              $BAB5 (msg_fief_gold_town_rice_output_dam)
  $8660  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$8664  0B                         LOADL_quick   ; inline operand = 11
  $8665  D3                         BYTE_DEREF
  $8666  B3                         PUSHL
  $8667  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $866B  43                         LOADL_qimm   ; inline operand = 3
  $866C  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $866F  0A                         LOADL_quick   ; inline operand = 10
  $8670  55                         LOADR_qimm   ; inline operand = 5
  $8671  B5                         MULT
  $8672  7B                         ADD_qimm   ; inline operand = 11
  $8673  26                         STORE_quick   ; inline operand = 6
  $8674  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $8677  0B                         LOADL_quick   ; inline operand = 11
  $8678  D3                         BYTE_DEREF
  $8679  D0                         INC
  $867A  B3                         PUSHL
  $867B  8E 02 BB                   PUSH_imm2              $BB02 (msg_fmt__2d_bb02)
  $867E  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $8682  0B                         LOADL_quick   ; inline operand = 11
  $8683  D3                         BYTE_DEREF
  $8684  8B 1A                      BYTE_LOADR_imm1        +26
  $8686  B5                         MULT
  $8687  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $868A  BB                         ADD
  $868B  29                         STORE_quick   ; inline operand = 9
  $868C  06                         LOADL_quick   ; inline operand = 6
  $868D  D1                         DEC
  $868E  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $8691  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $8694  72                         ADD_qimm   ; inline operand = 2
  $8695  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $8698  09                         LOADL_quick   ; inline operand = 9
  $8699  72                         ADD_qimm   ; inline operand = 2
  $869A  29                         STORE_quick   ; inline operand = 9
  $869B  8F FE                      BYTE_ADD_imm1          -2
  $869D  B0                         DEREF
  $869E  B3                         PUSHL
  $869F  8E 06 BB                   PUSH_imm2              $BB06 (msg_fmt__4d_bb06)
  $86A2  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $86A6  40                         LOADL_qimm   ; inline operand = 0
  $86A7  28                         STORE_quick   ; inline operand = 8
 >$86A8  06                         LOADL_quick   ; inline operand = 6
  $86A9  D1                         DEC
  $86AA  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $86AD  09                         LOADL_quick   ; inline operand = 9
  $86AE  72                         ADD_qimm   ; inline operand = 2
  $86AF  29                         STORE_quick   ; inline operand = 9
  $86B0  B0                         DEREF
  $86B1  B3                         PUSHL
  $86B2  8E 0B BB                   PUSH_imm2              $BB0B (msg_fmt__4d_bb0b)
  $86B5  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $86B9  08                         LOADL_quick   ; inline operand = 8
  $86BA  D0                         INC
  $86BB  28                         STORE_quick   ; inline operand = 8
  $86BC  08                         LOADL_quick   ; inline operand = 8
  $86BD  5A                         LOADR_qimm   ; inline operand = 10
  $86BE  C2                         SCMPLT
  $86BF  D7 A8 86                   JUMPT_abs              $86A8
  $86C2  06                         LOADL_quick   ; inline operand = 6
  $86C3  D1                         DEC
  $86C4  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $86C7  0B                         LOADL_quick   ; inline operand = 11
  $86C8  D3                         BYTE_DEREF
  $86C9  8C 2D 6D                   LOADR_imm2             $6D2D (fief_tax_rate)
  $86CC  BB                         ADD
  $86CD  D3                         BYTE_DEREF
  $86CE  B3                         PUSHL
  $86CF  8E 10 BB                   PUSH_imm2              $BB10 (msg_fmt__4d_bb10)
  $86D2  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $86D6  06                         LOADL_quick   ; inline operand = 6
  $86D7  D1                         DEC
  $86D8  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $86DB  0B                         LOADL_quick   ; inline operand = 11
  $86DC  D3                         BYTE_DEREF
  $86DD  B3                         PUSHL
  $86DE  E9 B4 85 02                CALL_abs_imm1          $85B4 (draw_fief_view_label) {bytecode}, $02
  $86E2  0A                         LOADL_quick   ; inline operand = 10
  $86E3  D0                         INC
  $86E4  2A                         STORE_quick   ; inline operand = 10
  $86E5  54                         LOADR_qimm   ; inline operand = 4
  $86E6  C0                         CMPEQ
  $86E7  D7 F4 86                   JUMPT_abs              $86F4
  $86EA  0B                         LOADL_quick   ; inline operand = 11
  $86EB  D0                         INC
  $86EC  D3                         BYTE_DEREF
  $86ED  8C FF 00                   LOADR_imm2             $00FF
  $86F0  C0                         CMPEQ
  $86F1  D8 03 87                   JUMPF_abs              $8703
 >$86F4  60                         PUSH_qimm   ; inline operand = 0
  $86F5  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $86F9  AC 09 D6                   CALL_abs               $D609 (ui_prompt_redraw) {bytecode}
  $86FC  52                         LOADR_qimm   ; inline operand = 2
  $86FD  C0                         CMPEQ
  $86FE  D7 0F 87                   JUMPT_abs              $870F
  $8701  40                         LOADL_qimm   ; inline operand = 0
  $8702  2A                         STORE_quick   ; inline operand = 10
 >$8703  0B                         LOADL_quick   ; inline operand = 11
  $8704  D0                         INC
 >$8705  2B                         STORE_quick   ; inline operand = 11
  $8706  0B                         LOADL_quick   ; inline operand = 11
  $8707  D3                         BYTE_DEREF
  $8708  8C FF 00                   LOADR_imm2             $00FF
  $870B  C1                         CMPNE
  $870C  D7 2A 86                   JUMPT_abs              $862A
 >$870F  8D 21                      BYTE_PUSH_imm1         +33
  $8711  67                         PUSH_qimm   ; inline operand = 7
  $8712  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $8716  8D 30                      BYTE_PUSH_imm1         +48
  $8718  6B                         PUSH_qimm   ; inline operand = 11
  $8719  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $871D  CF                         RETURN

; ============================================================
; sub $871E   (frame_off=-2, body @ $8723)
; ============================================================
  $8723  0C                         LOADL_quick   ; inline operand = 12
  $8724  A8 E2 7B                   STORE_abs              $7BE2 (fief_menu_info_mode_flag)
  $8727  65                         PUSH_qimm   ; inline operand = 5
  $8728  8D 16                      BYTE_PUSH_imm1         +22
  $872A  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $872E  8E 15 BB                   PUSH_imm2              $BB15 (msg_menu)
  $8731  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8735  AC 69 CC                   CALL_abs               $CC69 (clear_rect_right_panel) {bytecode}
  $8738  A4 E2 7B                   LOADL_abs              $7BE2 (fief_menu_info_mode_flag)
  $873B  D7 6B 87                   JUMPT_abs              $876B
  $873E  40                         LOADL_qimm   ; inline operand = 0
  $873F  2B                         STORE_quick   ; inline operand = 11
 >$8740  0B                         LOADL_quick   ; inline operand = 11
  $8741  77                         ADD_qimm   ; inline operand = 7
  $8742  B3                         PUSHL
  $8743  8D 16                      BYTE_PUSH_imm1         +22
  $8745  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8749  0B                         LOADL_quick   ; inline operand = 11
  $874A  D0                         INC
  $874B  B3                         PUSHL
  $874C  8E 1E BB                   PUSH_imm2              $BB1E (msg_fmt__2d_bb1e)
  $874F  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $8753  0B                         LOADL_quick   ; inline operand = 11
  $8754  D2                         LSHIFT1
  $8755  8C 16 F8                   LOADR_imm2             $F816 (lord_command_name_ptrs)
  $8758  BB                         ADD
  $8759  B0                         DEREF
  $875A  B3                         PUSHL
  $875B  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $875F  0B                         LOADL_quick   ; inline operand = 11
  $8760  D0                         INC
  $8761  2B                         STORE_quick   ; inline operand = 11
  $8762  0B                         LOADL_quick   ; inline operand = 11
  $8763  5C                         LOADR_qimm   ; inline operand = 12
  $8764  C6                         UCMPLT
  $8765  D7 40 87                   JUMPT_abs              $8740
  $8768  D6 97 87                   JUMP_abs               $8797
 >$876B  4C                         LOADL_qimm   ; inline operand = 12
  $876C  2B                         STORE_quick   ; inline operand = 11
 >$876D  0B                         LOADL_quick   ; inline operand = 11
  $876E  8F FB                      BYTE_ADD_imm1          -5
  $8770  B3                         PUSHL
  $8771  8D 16                      BYTE_PUSH_imm1         +22
  $8773  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8777  0B                         LOADL_quick   ; inline operand = 11
  $8778  D0                         INC
  $8779  B3                         PUSHL
  $877A  8E 22 BB                   PUSH_imm2              $BB22 (msg_fmt__2d_bb22)
  $877D  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $8781  0B                         LOADL_quick   ; inline operand = 11
  $8782  D2                         LSHIFT1
  $8783  8C 16 F8                   LOADR_imm2             $F816 (lord_command_name_ptrs)
  $8786  BB                         ADD
  $8787  B0                         DEREF
  $8788  B3                         PUSHL
  $8789  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $878D  0B                         LOADL_quick   ; inline operand = 11
  $878E  D0                         INC
  $878F  2B                         STORE_quick   ; inline operand = 11
  $8790  0B                         LOADL_quick   ; inline operand = 11
  $8791  8B 15                      BYTE_LOADR_imm1        +21
  $8793  C6                         UCMPLT
  $8794  D7 6D 87                   JUMPT_abs              $876D
 >$8797  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $879A  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $879D  40                         LOADL_qimm   ; inline operand = 0
  $879E  CF                         RETURN

; ============================================================
; sub $879F   (frame_off=+0, body @ $87A4)
; ============================================================
  $87A4  60                         PUSH_qimm   ; inline operand = 0
  $87A5  3D                         PUSH_quick   ; inline operand = 13
  $87A6  3C                         PUSH_quick   ; inline operand = 12
  $87A7  E9 72 81 06                CALL_abs_imm1          $8172 (count_eligible_targets) {bytecode}, $06
  $87AB  D7 BB 87                   JUMPT_abs              $87BB
  $87AE  8E 8A F9                   PUSH_imm2              $F98A (msg_no_fiefs)
  $87B1  3C                         PUSH_quick   ; inline operand = 12
  $87B2  E9 03 80 04                CALL_abs_imm1          $8003 (prompt_message_and_redraw) {bytecode}, $04
  $87B6  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $87B9  40                         LOADL_qimm   ; inline operand = 0
  $87BA  CF                         RETURN
 >$87BB  8E 26 BB                   PUSH_imm2              $BB26 (str_not_home_and_status)
  $87BE  3C                         PUSH_quick   ; inline operand = 12
  $87BF  E9 03 80 04                CALL_abs_imm1          $8003 (prompt_message_and_redraw) {bytecode}, $04
  $87C3  61                         PUSH_qimm   ; inline operand = 1
  $87C4  3D                         PUSH_quick   ; inline operand = 13
  $87C5  3C                         PUSH_quick   ; inline operand = 12
  $87C6  E9 72 81 06                CALL_abs_imm1          $8172 (count_eligible_targets) {bytecode}, $06
  $87CA  CF                         RETURN

; ============================================================
; sub $87CB   (frame_off=+0, body @ $87D0)
; ============================================================
  $87D0  8E 28 BB                   PUSH_imm2              $BB28 (msg_not_home_fief)
  $87D3  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $87D7  CF                         RETURN

; ============================================================
; sub $87D8   (frame_off=+0, body @ $87DD)
; ============================================================
  $87DD  0C                         LOADL_quick   ; inline operand = 12
  $87DE  78                         ADD_qimm   ; inline operand = 8
  $87DF  B0                         DEREF
  $87E0  D7 E7 87                   JUMPT_abs              $87E7
  $87E3  8A 10 27                   LOADL_imm2             $2710
  $87E6  CF                         RETURN
 >$87E7  0C                         LOADL_quick   ; inline operand = 12
  $87E8  78                         ADD_qimm   ; inline operand = 8
  $87E9  B0                         DEREF
  $87EA  B3                         PUSHL
  $87EB  E9 CD CB 02                CALL_abs_imm1          $CBCD (sqrt_int) {native}, $02
  $87EF  CF                         RETURN

; ============================================================
; sub $87F0   (frame_off=-4, body @ $87F5)
; ============================================================
  $87F5  0D                         LOADL_quick   ; inline operand = 13
  $87F6  51                         LOADR_qimm   ; inline operand = 1
  $87F7  C2                         SCMPLT
  $87F8  D8 FD 87                   JUMPF_abs              $87FD
  $87FB  40                         LOADL_qimm   ; inline operand = 0
  $87FC  CF                         RETURN
 >$87FD  0C                         LOADL_quick   ; inline operand = 12
  $87FE  78                         ADD_qimm   ; inline operand = 8
  $87FF  B0                         DEREF
  $8800  1D                         LOADR_quick   ; inline operand = 13
  $8801  BB                         ADD
  $8802  B3                         PUSHL
  $8803  E9 CD CB 02                CALL_abs_imm1          $CBCD (sqrt_int) {native}, $02
  $8807  B3                         PUSHL
  $8808  46                         LOADL_qimm   ; inline operand = 6
  $8809  A6 63 6D                   LOADR_abs              $6D63 (const_two)
  $880C  BC                         SUB
  $880D  B3                         PUSHL
  $880E  3D                         PUSH_quick   ; inline operand = 13
  $880F  E9 B8 D6 06                CALL_abs_imm1          $D6B8 (math32_3arg) {bytecode}, $06
  $8813  D2                         LSHIFT1
  $8814  2B                         STORE_quick   ; inline operand = 11
  $8815  0B                         LOADL_quick   ; inline operand = 11
  $8816  D7 1B 88                   JUMPT_abs              $881B
  $8819  41                         LOADL_qimm   ; inline operand = 1
  $881A  2B                         STORE_quick   ; inline operand = 11
 >$881B  0C                         LOADL_quick   ; inline operand = 12
  $881C  78                         ADD_qimm   ; inline operand = 8
  $881D  B0                         DEREF
  $881E  B3                         PUSHL
  $881F  0C                         LOADL_quick   ; inline operand = 12
  $8820  8F 18                      BYTE_ADD_imm1          +24
  $8822  B0                         DEREF
  $8823  B4                         POPR
  $8824  BC                         SUB
  $8825  2A                         STORE_quick   ; inline operand = 10
  $8826  B3                         PUSHL
  $8827  0B                         LOADL_quick   ; inline operand = 11
  $8828  B4                         POPR
  $8829  C4                         SCMPGT
  $882A  D8 2F 88                   JUMPF_abs              $882F
  $882D  0A                         LOADL_quick   ; inline operand = 10
  $882E  2B                         STORE_quick   ; inline operand = 11
 >$882F  0C                         LOADL_quick   ; inline operand = 12
  $8830  78                         ADD_qimm   ; inline operand = 8
  $8831  B0                         DEREF
  $8832  B3                         PUSHL
  $8833  0B                         LOADL_quick   ; inline operand = 11
  $8834  52                         LOADR_qimm   ; inline operand = 2
  $8835  B6                         SDIV
  $8836  B4                         POPR
  $8837  C4                         SCMPGT
  $8838  D8 40 88                   JUMPF_abs              $8840
  $883B  89 64                      BYTE_LOADL_imm1        +100
  $883D  D6 49 88                   JUMP_abs               $8849
 >$8840  0C                         LOADL_quick   ; inline operand = 12
  $8841  78                         ADD_qimm   ; inline operand = 8
  $8842  B0                         DEREF
  $8843  B3                         PUSHL
  $8844  3B                         PUSH_quick   ; inline operand = 11
  $8845  E9 DE D6 04                CALL_abs_imm1          $D6DE (math32_2arg) {bytecode}, $04
 >$8849  2A                         STORE_quick   ; inline operand = 10
  $884A  42                         LOADL_qimm   ; inline operand = 2
  $884B  CD                         SWAP
  $884C  0A                         LOADL_quick   ; inline operand = 10
  $884D  B6                         SDIV
  $884E  2A                         STORE_quick   ; inline operand = 10
  $884F  3A                         PUSH_quick   ; inline operand = 10
  $8850  0C                         LOADL_quick   ; inline operand = 12
  $8851  7C                         ADD_qimm   ; inline operand = 12
  $8852  B0                         DEREF
  $8853  B3                         PUSHL
  $8854  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $8858  B3                         PUSHL
  $8859  0C                         LOADL_quick   ; inline operand = 12
  $885A  7C                         ADD_qimm   ; inline operand = 12
  $885B  B4                         POPR
  $885C  B3                         PUSHL
  $885D  B0                         DEREF
  $885E  BC                         SUB
  $885F  B1                         POPSTORE
  $8860  3A                         PUSH_quick   ; inline operand = 10
  $8861  0C                         LOADL_quick   ; inline operand = 12
  $8862  7A                         ADD_qimm   ; inline operand = 10
  $8863  B0                         DEREF
  $8864  B3                         PUSHL
  $8865  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $8869  B3                         PUSHL
  $886A  0C                         LOADL_quick   ; inline operand = 12
  $886B  7A                         ADD_qimm   ; inline operand = 10
  $886C  B4                         POPR
  $886D  B3                         PUSHL
  $886E  B0                         DEREF
  $886F  BC                         SUB
  $8870  B1                         POPSTORE
  $8871  3B                         PUSH_quick   ; inline operand = 11
  $8872  0C                         LOADL_quick   ; inline operand = 12
  $8873  78                         ADD_qimm   ; inline operand = 8
  $8874  B4                         POPR
  $8875  B3                         PUSHL
  $8876  B0                         DEREF
  $8877  BB                         ADD
  $8878  B1                         POPSTORE
  $8879  0B                         LOADL_quick   ; inline operand = 11
  $887A  52                         LOADR_qimm   ; inline operand = 2
  $887B  B6                         SDIV
  $887C  CF                         RETURN

; ============================================================
; sub $887D   (frame_off=-2, body @ $8882)
; ============================================================
  $8882  0C                         LOADL_quick   ; inline operand = 12
  $8883  2B                         STORE_quick   ; inline operand = 11
  $8884  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $8887  E9 72 D9 02                CALL_abs_imm1          $D972 (fief_owner_weakness) {bytecode}, $02
  $888B  D8 99 88                   JUMPF_abs              $8899
  $888E  42                         LOADL_qimm   ; inline operand = 2
  $888F  CD                         SWAP
  $8890  0B                         LOADL_quick   ; inline operand = 11
  $8891  B6                         SDIV
  $8892  2B                         STORE_quick   ; inline operand = 11
  $8893  D7 99 88                   JUMPT_abs              $8899
  $8896  0B                         LOADL_quick   ; inline operand = 11
  $8897  D0                         INC
  $8898  2B                         STORE_quick   ; inline operand = 11
 >$8899  3B                         PUSH_quick   ; inline operand = 11
  $889A  0D                         LOADL_quick   ; inline operand = 13
  $889B  B4                         POPR
  $889C  B3                         PUSHL
  $889D  B0                         DEREF
  $889E  BB                         ADD
  $889F  B1                         POPSTORE
  $88A0  3D                         PUSH_quick   ; inline operand = 13
  $88A1  E9 AC 82 02                CALL_abs_imm1          $82AC (clamp_amount_to_province_max) {bytecode}, $02
  $88A5  CF                         RETURN

; ============================================================
; sub $88A6   (frame_off=-4, body @ $88AB)
; ============================================================
  $88AB  0D                         LOADL_quick   ; inline operand = 13
  $88AC  51                         LOADR_qimm   ; inline operand = 1
  $88AD  C2                         SCMPLT
  $88AE  D8 B3 88                   JUMPF_abs              $88B3
  $88B1  40                         LOADL_qimm   ; inline operand = 0
  $88B2  CF                         RETURN
 >$88B3  0C                         LOADL_quick   ; inline operand = 12
  $88B4  74                         ADD_qimm   ; inline operand = 4
  $88B5  B0                         DEREF
  $88B6  1D                         LOADR_quick   ; inline operand = 13
  $88B7  BB                         ADD
  $88B8  B3                         PUSHL
  $88B9  E9 CD CB 02                CALL_abs_imm1          $CBCD (sqrt_int) {native}, $02
  $88BD  B3                         PUSHL
  $88BE  46                         LOADL_qimm   ; inline operand = 6
  $88BF  A6 63 6D                   LOADR_abs              $6D63 (const_two)
  $88C2  BC                         SUB
  $88C3  B3                         PUSHL
  $88C4  3D                         PUSH_quick   ; inline operand = 13
  $88C5  E9 B8 D6 06                CALL_abs_imm1          $D6B8 (math32_3arg) {bytecode}, $06
  $88C9  2B                         STORE_quick   ; inline operand = 11
  $88CA  0B                         LOADL_quick   ; inline operand = 11
  $88CB  D7 D0 88                   JUMPT_abs              $88D0
  $88CE  41                         LOADL_qimm   ; inline operand = 1
  $88CF  2B                         STORE_quick   ; inline operand = 11
 >$88D0  0C                         LOADL_quick   ; inline operand = 12
  $88D1  74                         ADD_qimm   ; inline operand = 4
  $88D2  B0                         DEREF
  $88D3  B3                         PUSHL
  $88D4  0C                         LOADL_quick   ; inline operand = 12
  $88D5  8F 18                      BYTE_ADD_imm1          +24
  $88D7  B0                         DEREF
  $88D8  B4                         POPR
  $88D9  BC                         SUB
  $88DA  2A                         STORE_quick   ; inline operand = 10
  $88DB  B3                         PUSHL
  $88DC  0B                         LOADL_quick   ; inline operand = 11
  $88DD  B4                         POPR
  $88DE  C4                         SCMPGT
  $88DF  D8 E4 88                   JUMPF_abs              $88E4
  $88E2  0A                         LOADL_quick   ; inline operand = 10
  $88E3  2B                         STORE_quick   ; inline operand = 11
 >$88E4  0C                         LOADL_quick   ; inline operand = 12
  $88E5  74                         ADD_qimm   ; inline operand = 4
  $88E6  B0                         DEREF
  $88E7  B3                         PUSHL
  $88E8  0B                         LOADL_quick   ; inline operand = 11
  $88E9  B4                         POPR
  $88EA  C4                         SCMPGT
  $88EB  D8 F3 88                   JUMPF_abs              $88F3
  $88EE  89 64                      BYTE_LOADL_imm1        +100
  $88F0  D6 FC 88                   JUMP_abs               $88FC
 >$88F3  0C                         LOADL_quick   ; inline operand = 12
  $88F4  74                         ADD_qimm   ; inline operand = 4
  $88F5  B0                         DEREF
  $88F6  B3                         PUSHL
  $88F7  3B                         PUSH_quick   ; inline operand = 11
  $88F8  E9 DE D6 04                CALL_abs_imm1          $D6DE (math32_2arg) {bytecode}, $04
 >$88FC  2A                         STORE_quick   ; inline operand = 10
  $88FD  0A                         LOADL_quick   ; inline operand = 10
  $88FE  52                         LOADR_qimm   ; inline operand = 2
  $88FF  B6                         SDIV
  $8900  B3                         PUSHL
  $8901  0C                         LOADL_quick   ; inline operand = 12
  $8902  7E                         ADD_qimm   ; inline operand = 14
  $8903  B0                         DEREF
  $8904  B3                         PUSHL
  $8905  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $8909  B3                         PUSHL
  $890A  0C                         LOADL_quick   ; inline operand = 12
  $890B  7E                         ADD_qimm   ; inline operand = 14
  $890C  B4                         POPR
  $890D  B3                         PUSHL
  $890E  B0                         DEREF
  $890F  BC                         SUB
  $8910  B1                         POPSTORE
  $8911  0C                         LOADL_quick   ; inline operand = 12
  $8912  74                         ADD_qimm   ; inline operand = 4
  $8913  B3                         PUSHL
  $8914  0B                         LOADL_quick   ; inline operand = 11
  $8915  D2                         LSHIFT1
  $8916  B3                         PUSHL
  $8917  E9 7D 88 04                CALL_abs_imm1          $887D (add_effect_gain_clamped) {bytecode}, $04
  $891B  0B                         LOADL_quick   ; inline operand = 11
  $891C  CF                         RETURN

; ============================================================
; sub $891D   (frame_off=-4, body @ $8922)
; ============================================================
  $8922  0D                         LOADL_quick   ; inline operand = 13
  $8923  51                         LOADR_qimm   ; inline operand = 1
  $8924  C2                         SCMPLT
  $8925  D8 2A 89                   JUMPF_abs              $892A
  $8928  40                         LOADL_qimm   ; inline operand = 0
  $8929  CF                         RETURN
 >$892A  0C                         LOADL_quick   ; inline operand = 12
  $892B  78                         ADD_qimm   ; inline operand = 8
  $892C  B0                         DEREF
  $892D  B3                         PUSHL
  $892E  0C                         LOADL_quick   ; inline operand = 12
  $892F  7C                         ADD_qimm   ; inline operand = 12
  $8930  B0                         DEREF
  $8931  B4                         POPR
  $8932  BB                         ADD
  $8933  52                         LOADR_qimm   ; inline operand = 2
  $8934  B6                         SDIV
  $8935  1D                         LOADR_quick   ; inline operand = 13
  $8936  BB                         ADD
  $8937  B3                         PUSHL
  $8938  E9 CD CB 02                CALL_abs_imm1          $CBCD (sqrt_int) {native}, $02
  $893C  B3                         PUSHL
  $893D  46                         LOADL_qimm   ; inline operand = 6
  $893E  A6 63 6D                   LOADR_abs              $6D63 (const_two)
  $8941  BC                         SUB
  $8942  B3                         PUSHL
  $8943  3D                         PUSH_quick   ; inline operand = 13
  $8944  E9 B8 D6 06                CALL_abs_imm1          $D6B8 (math32_3arg) {bytecode}, $06
  $8948  2B                         STORE_quick   ; inline operand = 11
  $8949  0B                         LOADL_quick   ; inline operand = 11
  $894A  D7 4F 89                   JUMPT_abs              $894F
  $894D  41                         LOADL_qimm   ; inline operand = 1
  $894E  2B                         STORE_quick   ; inline operand = 11
 >$894F  0C                         LOADL_quick   ; inline operand = 12
  $8950  7C                         ADD_qimm   ; inline operand = 12
  $8951  B0                         DEREF
  $8952  B3                         PUSHL
  $8953  0C                         LOADL_quick   ; inline operand = 12
  $8954  8F 18                      BYTE_ADD_imm1          +24
  $8956  B0                         DEREF
  $8957  B4                         POPR
  $8958  BC                         SUB
  $8959  2A                         STORE_quick   ; inline operand = 10
  $895A  B3                         PUSHL
  $895B  0B                         LOADL_quick   ; inline operand = 11
  $895C  B4                         POPR
  $895D  C4                         SCMPGT
  $895E  D8 63 89                   JUMPF_abs              $8963
  $8961  0A                         LOADL_quick   ; inline operand = 10
  $8962  2B                         STORE_quick   ; inline operand = 11
 >$8963  0B                         LOADL_quick   ; inline operand = 11
  $8964  D2                         LSHIFT1
  $8965  B3                         PUSHL
  $8966  0C                         LOADL_quick   ; inline operand = 12
  $8967  7C                         ADD_qimm   ; inline operand = 12
  $8968  B4                         POPR
  $8969  B3                         PUSHL
  $896A  B0                         DEREF
  $896B  BB                         ADD
  $896C  B1                         POPSTORE
  $896D  0B                         LOADL_quick   ; inline operand = 11
  $896E  CF                         RETURN

; ============================================================
; sub $896F   (frame_off=-4, body @ $8974)
; ============================================================
  $8974  0D                         LOADL_quick   ; inline operand = 13
  $8975  51                         LOADR_qimm   ; inline operand = 1
  $8976  C2                         SCMPLT
  $8977  D8 7C 89                   JUMPF_abs              $897C
  $897A  40                         LOADL_qimm   ; inline operand = 0
  $897B  CF                         RETURN
 >$897C  0C                         LOADL_quick   ; inline operand = 12
  $897D  74                         ADD_qimm   ; inline operand = 4
  $897E  B0                         DEREF
  $897F  B3                         PUSHL
  $8980  0C                         LOADL_quick   ; inline operand = 12
  $8981  7E                         ADD_qimm   ; inline operand = 14
  $8982  B0                         DEREF
  $8983  B4                         POPR
  $8984  BB                         ADD
  $8985  52                         LOADR_qimm   ; inline operand = 2
  $8986  B6                         SDIV
  $8987  1D                         LOADR_quick   ; inline operand = 13
  $8988  BB                         ADD
  $8989  B3                         PUSHL
  $898A  E9 CD CB 02                CALL_abs_imm1          $CBCD (sqrt_int) {native}, $02
  $898E  B3                         PUSHL
  $898F  46                         LOADL_qimm   ; inline operand = 6
  $8990  A6 63 6D                   LOADR_abs              $6D63 (const_two)
  $8993  BC                         SUB
  $8994  B3                         PUSHL
  $8995  3D                         PUSH_quick   ; inline operand = 13
  $8996  E9 B8 D6 06                CALL_abs_imm1          $D6B8 (math32_3arg) {bytecode}, $06
  $899A  2B                         STORE_quick   ; inline operand = 11
  $899B  0B                         LOADL_quick   ; inline operand = 11
  $899C  D7 A1 89                   JUMPT_abs              $89A1
  $899F  41                         LOADL_qimm   ; inline operand = 1
  $89A0  2B                         STORE_quick   ; inline operand = 11
 >$89A1  0C                         LOADL_quick   ; inline operand = 12
  $89A2  7E                         ADD_qimm   ; inline operand = 14
  $89A3  B0                         DEREF
  $89A4  B3                         PUSHL
  $89A5  0C                         LOADL_quick   ; inline operand = 12
  $89A6  8F 18                      BYTE_ADD_imm1          +24
  $89A8  B0                         DEREF
  $89A9  B4                         POPR
  $89AA  BC                         SUB
  $89AB  2A                         STORE_quick   ; inline operand = 10
  $89AC  B3                         PUSHL
  $89AD  0B                         LOADL_quick   ; inline operand = 11
  $89AE  B4                         POPR
  $89AF  C4                         SCMPGT
  $89B0  D8 B5 89                   JUMPF_abs              $89B5
  $89B3  0A                         LOADL_quick   ; inline operand = 10
  $89B4  2B                         STORE_quick   ; inline operand = 11
 >$89B5  0B                         LOADL_quick   ; inline operand = 11
  $89B6  D2                         LSHIFT1
  $89B7  B3                         PUSHL
  $89B8  0C                         LOADL_quick   ; inline operand = 12
  $89B9  7E                         ADD_qimm   ; inline operand = 14
  $89BA  B4                         POPR
  $89BB  B3                         PUSHL
  $89BC  B0                         DEREF
  $89BD  BB                         ADD
  $89BE  B1                         POPSTORE
  $89BF  0B                         LOADL_quick   ; inline operand = 11
  $89C0  CF                         RETURN

; ============================================================
; sub $89C1   (frame_off=-4, body @ $89C6)
; ============================================================
  $89C6  0D                         LOADL_quick   ; inline operand = 13
  $89C7  51                         LOADR_qimm   ; inline operand = 1
  $89C8  C2                         SCMPLT
  $89C9  D8 CE 89                   JUMPF_abs              $89CE
  $89CC  40                         LOADL_qimm   ; inline operand = 0
  $89CD  CF                         RETURN
 >$89CE  0C                         LOADL_quick   ; inline operand = 12
  $89CF  8F 10                      BYTE_ADD_imm1          +16
  $89D1  B0                         DEREF
  $89D2  B3                         PUSHL
  $89D3  0C                         LOADL_quick   ; inline operand = 12
  $89D4  8F 12                      BYTE_ADD_imm1          +18
  $89D6  B0                         DEREF
  $89D7  B4                         POPR
  $89D8  BB                         ADD
  $89D9  52                         LOADR_qimm   ; inline operand = 2
  $89DA  B6                         SDIV
  $89DB  1D                         LOADR_quick   ; inline operand = 13
  $89DC  BB                         ADD
  $89DD  B3                         PUSHL
  $89DE  E9 CD CB 02                CALL_abs_imm1          $CBCD (sqrt_int) {native}, $02
  $89E2  B3                         PUSHL
  $89E3  46                         LOADL_qimm   ; inline operand = 6
  $89E4  A6 63 6D                   LOADR_abs              $6D63 (const_two)
  $89E7  BC                         SUB
  $89E8  B3                         PUSHL
  $89E9  3D                         PUSH_quick   ; inline operand = 13
  $89EA  E9 B8 D6 06                CALL_abs_imm1          $D6B8 (math32_3arg) {bytecode}, $06
  $89EE  2B                         STORE_quick   ; inline operand = 11
  $89EF  0B                         LOADL_quick   ; inline operand = 11
  $89F0  D7 F5 89                   JUMPT_abs              $89F5
  $89F3  41                         LOADL_qimm   ; inline operand = 1
  $89F4  2B                         STORE_quick   ; inline operand = 11
 >$89F5  0C                         LOADL_quick   ; inline operand = 12
  $89F6  8F 12                      BYTE_ADD_imm1          +18
  $89F8  B0                         DEREF
  $89F9  B3                         PUSHL
  $89FA  0C                         LOADL_quick   ; inline operand = 12
  $89FB  8F 18                      BYTE_ADD_imm1          +24
  $89FD  B0                         DEREF
  $89FE  B4                         POPR
  $89FF  BC                         SUB
  $8A00  2A                         STORE_quick   ; inline operand = 10
  $8A01  B3                         PUSHL
  $8A02  0B                         LOADL_quick   ; inline operand = 11
  $8A03  B4                         POPR
  $8A04  C4                         SCMPGT
  $8A05  D8 0A 8A                   JUMPF_abs              $8A0A
  $8A08  0A                         LOADL_quick   ; inline operand = 10
  $8A09  2B                         STORE_quick   ; inline operand = 11
 >$8A0A  3B                         PUSH_quick   ; inline operand = 11
  $8A0B  0C                         LOADL_quick   ; inline operand = 12
  $8A0C  8F 12                      BYTE_ADD_imm1          +18
  $8A0E  B4                         POPR
  $8A0F  B3                         PUSHL
  $8A10  B0                         DEREF
  $8A11  BB                         ADD
  $8A12  B1                         POPSTORE
  $8A13  0B                         LOADL_quick   ; inline operand = 11
  $8A14  CF                         RETURN

; ============================================================
; sub $8A15   (frame_off=+0, body @ $8A1A)
; ============================================================
  $8A1A  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $8A1D  8B 32                      BYTE_LOADR_imm1        +50
  $8A1F  C0                         CMPEQ
  $8A20  D8 28 8A                   JUMPF_abs              $8A28
  $8A23  89 1E                      BYTE_LOADL_imm1        +30
  $8A25  D6 29 8A                   JUMP_abs               $8A29
 >$8A28  4D                         LOADL_qimm   ; inline operand = 13
 >$8A29  A6 5F 6F                   LOADR_abs              $6F5F (selected_province_idx)
  $8A2C  C0                         CMPEQ
  $8A2D  D7 46 8A                   JUMPT_abs              $8A46
  $8A30  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $8A33  8B 32                      BYTE_LOADR_imm1        +50
  $8A35  C0                         CMPEQ
  $8A36  D8 3E 8A                   JUMPF_abs              $8A3E
  $8A39  89 20                      BYTE_LOADL_imm1        +32
  $8A3B  D6 3F 8A                   JUMP_abs               $8A3F
 >$8A3E  4E                         LOADL_qimm   ; inline operand = 14
 >$8A3F  A6 5F 6F                   LOADR_abs              $6F5F (selected_province_idx)
  $8A42  C0                         CMPEQ
  $8A43  D8 48 8A                   JUMPF_abs              $8A48
 >$8A46  41                         LOADL_qimm   ; inline operand = 1
  $8A47  CF                         RETURN
 >$8A48  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $8A4B  51                         LOADR_qimm   ; inline operand = 1
  $8A4C  DA                         AND
  $8A4D  CF                         RETURN

; ============================================================
; sub $8A4E   (frame_off=-6, body @ $8A53)
; ============================================================
  $8A53  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $8A56  2A                         STORE_quick   ; inline operand = 10
  $8A57  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $8A5A  29                         STORE_quick   ; inline operand = 9
  $8A5B  89 1A                      BYTE_LOADL_imm1        +26
  $8A5D  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $8A60  0C                         LOADL_quick   ; inline operand = 12
  $8A61  D5 00 00 06 00 94 8A 74 8A BC 8A AA ... SWITCH_contig          limit=6   ; .table 6 word targets (contiguous); SWITCH 0=>$8A74 1=>$8ABC 2=>$8AAA 3=>$8AE6 4=>$8AD4 5=>$8AF8 default=>$8A94
 >$8A74  A4 0B 6E                   LOADL_abs              $6E0B (loan_rate)
  $8A77  D0                         INC
  $8A78  A8 0B 6E                   STORE_abs              $6E0B (loan_rate)
  $8A7B  A4 0B 6E                   LOADL_abs              $6E0B (loan_rate)
  $8A7E  5F                         LOADR_qimm   ; inline operand = 15
  $8A7F  C4                         SCMPGT
  $8A80  D8 8B 8A                   JUMPF_abs              $8A8B
  $8A83  6F                         PUSH_qimm   ; inline operand = 15
  $8A84  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8A88  A8 0B 6E                   STORE_abs              $6E0B (loan_rate)
 >$8A8B  89 15                      BYTE_LOADL_imm1        +21
  $8A8D  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $8A90  A4 0B 6E                   LOADL_abs              $6E0B (loan_rate)
 >$8A93  2B                         STORE_quick   ; inline operand = 11
 >$8A94  0B                         LOADL_quick   ; inline operand = 11
  $8A95  5A                         LOADR_qimm   ; inline operand = 10
  $8A96  B9                         SMOD
  $8A97  B3                         PUSHL
  $8A98  0B                         LOADL_quick   ; inline operand = 11
  $8A99  5A                         LOADR_qimm   ; inline operand = 10
  $8A9A  B6                         SDIV
  $8A9B  B3                         PUSHL
  $8A9C  8E 36 BB                   PUSH_imm2              $BB36
  $8A9F  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $8AA3  39                         PUSH_quick   ; inline operand = 9
  $8AA4  3A                         PUSH_quick   ; inline operand = 10
  $8AA5  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $8AA9  CF                         RETURN
 >$8AAA  A4 0D 6E                   LOADL_abs              $6E0D (gold_rice_exchange_rate)
  $8AAD  D0                         INC
 >$8AAE  A8 0D 6E                   STORE_abs              $6E0D (gold_rice_exchange_rate)
  $8AB1  89 16                      BYTE_LOADL_imm1        +22
  $8AB3  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $8AB6  A4 0D 6E                   LOADL_abs              $6E0D (gold_rice_exchange_rate)
  $8AB9  D6 93 8A                   JUMP_abs               $8A93
 >$8ABC  A4 0D 6E                   LOADL_abs              $6E0D (gold_rice_exchange_rate)
  $8ABF  51                         LOADR_qimm   ; inline operand = 1
  $8AC0  C3                         SCMPLE
  $8AC1  D8 CB 8A                   JUMPF_abs              $8ACB
  $8AC4  A4 0D 6E                   LOADL_abs              $6E0D (gold_rice_exchange_rate)
  $8AC7  D1                         DEC
  $8AC8  D6 CC 8A                   JUMP_abs               $8ACC
 >$8ACB  41                         LOADL_qimm   ; inline operand = 1
 >$8ACC  CD                         SWAP
  $8ACD  A4 0D 6E                   LOADL_abs              $6E0D (gold_rice_exchange_rate)
  $8AD0  BC                         SUB
  $8AD1  D6 AE 8A                   JUMP_abs               $8AAE
 >$8AD4  A4 11 6E                   LOADL_abs              $6E11 (gold_men_hire_rate)
  $8AD7  D0                         INC
  $8AD8  A8 11 6E                   STORE_abs              $6E11 (gold_men_hire_rate)
  $8ADB  89 18                      BYTE_LOADL_imm1        +24
  $8ADD  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $8AE0  A4 11 6E                   LOADL_abs              $6E11 (gold_men_hire_rate)
  $8AE3  D6 93 8A                   JUMP_abs               $8A93
 >$8AE6  A4 0F 6E                   LOADL_abs              $6E0F (arms_buy_price_rate)
  $8AE9  D0                         INC
  $8AEA  A8 0F 6E                   STORE_abs              $6E0F (arms_buy_price_rate)
  $8AED  89 17                      BYTE_LOADL_imm1        +23
  $8AEF  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $8AF2  A4 0F 6E                   LOADL_abs              $6E0F (arms_buy_price_rate)
  $8AF5  D6 93 8A                   JUMP_abs               $8A93
 >$8AF8  A4 13 6E                   LOADL_abs              $6E13 (hire_gold_rate)
  $8AFB  D0                         INC
  $8AFC  A8 13 6E                   STORE_abs              $6E13 (hire_gold_rate)
  $8AFF  89 19                      BYTE_LOADL_imm1        +25
  $8B01  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $8B04  A4 13 6E                   LOADL_abs              $6E13 (hire_gold_rate)
  $8B07  D6 93 8A                   JUMP_abs               $8A93

; ============================================================
; sub $8B0A   (frame_off=-10, body @ $8B0F)
; ============================================================
  $8B0F  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8B12  8B 1A                      BYTE_LOADR_imm1        +26
  $8B14  B5                         MULT
  $8B15  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $8B18  BB                         ADD
  $8B19  2A                         STORE_quick   ; inline operand = 10
  $8B1A  0A                         LOADL_quick   ; inline operand = 10
  $8B1B  76                         ADD_qimm   ; inline operand = 6
  $8B1C  2B                         STORE_quick   ; inline operand = 11
  $8B1D  0B                         LOADL_quick   ; inline operand = 11
  $8B1E  8F 12                      BYTE_ADD_imm1          +18
  $8B20  B0                         DEREF
  $8B21  27                         STORE_quick   ; inline operand = 7
  $8B22  A4 0D 6E                   LOADL_abs              $6E0D (gold_rice_exchange_rate)
  $8B25  29                         STORE_quick   ; inline operand = 9
  $8B26  3C                         PUSH_quick   ; inline operand = 12
  $8B27  39                         PUSH_quick   ; inline operand = 9
  $8B28  E9 03 83 04                CALL_abs_imm1          $8303 (math32_muladddiv) {bytecode}, $04
  $8B2C  B3                         PUSHL
  $8B2D  0A                         LOADL_quick   ; inline operand = 10
  $8B2E  B4                         POPR
  $8B2F  B3                         PUSHL
  $8B30  B0                         DEREF
  $8B31  BB                         ADD
  $8B32  B1                         POPSTORE
  $8B33  3C                         PUSH_quick   ; inline operand = 12
  $8B34  0B                         LOADL_quick   ; inline operand = 11
  $8B35  B4                         POPR
  $8B36  B3                         PUSHL
  $8B37  B0                         DEREF
  $8B38  BC                         SUB
  $8B39  B1                         POPSTORE
  $8B3A  61                         PUSH_qimm   ; inline operand = 1
  $8B3B  E9 4E 8A 02                CALL_abs_imm1          $8A4E (cycle_economy_rate) {bytecode}, $02
  $8B3F  CF                         RETURN

; ============================================================
; sub $8B40   (frame_off=-10, body @ $8B45)
; ============================================================
  $8B45  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8B48  8B 1A                      BYTE_LOADR_imm1        +26
  $8B4A  B5                         MULT
  $8B4B  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $8B4E  BB                         ADD
  $8B4F  27                         STORE_quick   ; inline operand = 7
  $8B50  07                         LOADL_quick   ; inline operand = 7
  $8B51  72                         ADD_qimm   ; inline operand = 2
  $8B52  28                         STORE_quick   ; inline operand = 8
  $8B53  08                         LOADL_quick   ; inline operand = 8
  $8B54  72                         ADD_qimm   ; inline operand = 2
  $8B55  B0                         DEREF
  $8B56  29                         STORE_quick   ; inline operand = 9
  $8B57  A4 0B 6E                   LOADL_abs              $6E0B (loan_rate)
  $8B5A  7A                         ADD_qimm   ; inline operand = 10
  $8B5B  2A                         STORE_quick   ; inline operand = 10
  $8B5C  0C                         LOADL_quick   ; inline operand = 12
  $8B5D  50                         LOADR_qimm   ; inline operand = 0
  $8B5E  C3                         SCMPLE
  $8B5F  D8 74 8B                   JUMPF_abs              $8B74
  $8B62  08                         LOADL_quick   ; inline operand = 8
  $8B63  B0                         DEREF
  $8B64  B3                         PUSHL
  $8B65  09                         LOADL_quick   ; inline operand = 9
  $8B66  B4                         POPR
  $8B67  BC                         SUB
  $8B68  B3                         PUSHL
  $8B69  3A                         PUSH_quick   ; inline operand = 10
  $8B6A  39                         PUSH_quick   ; inline operand = 9
  $8B6B  E9 57 83 06                CALL_abs_imm1          $8357 (ratio_times10_capped) {bytecode}, $06
  $8B6F  2C                         STORE_quick   ; inline operand = 12
  $8B70  40                         LOADL_qimm   ; inline operand = 0
  $8B71  D6 7A 8B                   JUMP_abs               $8B7A
 >$8B74  3C                         PUSH_quick   ; inline operand = 12
  $8B75  3A                         PUSH_quick   ; inline operand = 10
  $8B76  E9 03 83 04                CALL_abs_imm1          $8303 (math32_muladddiv) {bytecode}, $04
 >$8B7A  2B                         STORE_quick   ; inline operand = 11
  $8B7B  3B                         PUSH_quick   ; inline operand = 11
  $8B7C  08                         LOADL_quick   ; inline operand = 8
  $8B7D  B4                         POPR
  $8B7E  B3                         PUSHL
  $8B7F  B0                         DEREF
  $8B80  BB                         ADD
  $8B81  B1                         POPSTORE
  $8B82  3C                         PUSH_quick   ; inline operand = 12
  $8B83  07                         LOADL_quick   ; inline operand = 7
  $8B84  B4                         POPR
  $8B85  B3                         PUSHL
  $8B86  B0                         DEREF
  $8B87  BB                         ADD
  $8B88  B1                         POPSTORE
  $8B89  60                         PUSH_qimm   ; inline operand = 0
  $8B8A  E9 4E 8A 02                CALL_abs_imm1          $8A4E (cycle_economy_rate) {bytecode}, $02
  $8B8E  CF                         RETURN

; ============================================================
; sub $8B8F   (frame_off=+0, body @ $8B94)
; ============================================================
  $8B94  60                         PUSH_qimm   ; inline operand = 0
  $8B95  60                         PUSH_qimm   ; inline operand = 0
  $8B96  6A                         PUSH_qimm   ; inline operand = 10
  $8B97  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $8B9B  0C                         LOADL_quick   ; inline operand = 12
  $8B9C  D7 A3 8B                   JUMPT_abs              $8BA3
  $8B9F  47                         LOADL_qimm   ; inline operand = 7
  $8BA0  D6 A4 8B                   JUMP_abs               $8BA4
 >$8BA3  48                         LOADL_qimm   ; inline operand = 8
 >$8BA4  B3                         PUSHL
  $8BA5  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $8BA9  A4 4D 6F                   LOADL_abs              $6F4D (audio_wait_gate)
  $8BAC  51                         LOADR_qimm   ; inline operand = 1
  $8BAD  C0                         CMPEQ
  $8BAE  D8 BB 8B                   JUMPF_abs              $8BBB
 >$8BB1  62                         PUSH_qimm   ; inline operand = 2
  $8BB2  61                         PUSH_qimm   ; inline operand = 1
  $8BB3  6A                         PUSH_qimm   ; inline operand = 10
  $8BB4  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $8BB8  D7 B1 8B                   JUMPT_abs              $8BB1
 >$8BBB  61                         PUSH_qimm   ; inline operand = 1
  $8BBC  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $8BC0  CF                         RETURN

; ============================================================
; sub $8BC1   (frame_off=+0, body @ $8BC6)
; ============================================================
  $8BC6  8D 19                      BYTE_PUSH_imm1         +25
  $8BC8  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8BCC  8F 1E                      BYTE_ADD_imm1          +30
  $8BCE  B3                         PUSHL
  $8BCF  0C                         LOADL_quick   ; inline operand = 12
  $8BD0  B0                         DEREF
  $8BD1  B3                         PUSHL
  $8BD2  3D                         PUSH_quick   ; inline operand = 13
  $8BD3  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $8BD7  D0                         INC
  $8BD8  B3                         PUSHL
  $8BD9  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $8BDD  D0                         INC
  $8BDE  B3                         PUSHL
  $8BDF  3C                         PUSH_quick   ; inline operand = 12
  $8BE0  E9 31 CA 04                CALL_abs_imm1          $CA31 (word_sub_saturating) {bytecode}, $04
  $8BE4  CF                         RETURN

; ============================================================
; sub $8BE5   (frame_off=+0, body @ $8BEA)
; ============================================================
  $8BEA  3E                         PUSH_quick   ; inline operand = 14
  $8BEB  0C                         LOADL_quick   ; inline operand = 12
  $8BEC  1D                         LOADR_quick   ; inline operand = 13
  $8BED  BC                         SUB
  $8BEE  B3                         PUSHL
  $8BEF  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $8BF3  CF                         RETURN

; ============================================================
; sub $8BF4   (frame_off=+0, body @ $8BF9)
; ============================================================
  $8BF9  0C                         LOADL_quick   ; inline operand = 12
  $8BFA  8F 12                      BYTE_ADD_imm1          +18
  $8BFC  B3                         PUSHL
  $8BFD  0C                         LOADL_quick   ; inline operand = 12
  $8BFE  8F 18                      BYTE_ADD_imm1          +24
  $8C00  B0                         DEREF
  $8C01  B3                         PUSHL
  $8C02  0C                         LOADL_quick   ; inline operand = 12
  $8C03  8F 10                      BYTE_ADD_imm1          +16
  $8C05  B0                         DEREF
  $8C06  B3                         PUSHL
  $8C07  3D                         PUSH_quick   ; inline operand = 13
  $8C08  8D 14                      BYTE_PUSH_imm1         +20
  $8C0A  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8C0E  8F 28                      BYTE_ADD_imm1          +40
  $8C10  B3                         PUSHL
  $8C11  0C                         LOADL_quick   ; inline operand = 12
  $8C12  8F 12                      BYTE_ADD_imm1          +18
  $8C14  B0                         DEREF
  $8C15  B3                         PUSHL
  $8C16  E9 24 DA 0A                CALL_abs_imm1          $DA24 (scaled_force_transfer) {bytecode}, $0A
  $8C1A  B1                         POPSTORE
  $8C1B  0C                         LOADL_quick   ; inline operand = 12
  $8C1C  8F 14                      BYTE_ADD_imm1          +20
  $8C1E  B3                         PUSHL
  $8C1F  0C                         LOADL_quick   ; inline operand = 12
  $8C20  8F 18                      BYTE_ADD_imm1          +24
  $8C22  B0                         DEREF
  $8C23  B3                         PUSHL
  $8C24  0C                         LOADL_quick   ; inline operand = 12
  $8C25  8F 10                      BYTE_ADD_imm1          +16
  $8C27  B0                         DEREF
  $8C28  B3                         PUSHL
  $8C29  3D                         PUSH_quick   ; inline operand = 13
  $8C2A  8D 14                      BYTE_PUSH_imm1         +20
  $8C2C  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8C30  8F 3C                      BYTE_ADD_imm1          +60
  $8C32  B3                         PUSHL
  $8C33  0C                         LOADL_quick   ; inline operand = 12
  $8C34  8F 14                      BYTE_ADD_imm1          +20
  $8C36  B0                         DEREF
  $8C37  B3                         PUSHL
  $8C38  E9 24 DA 0A                CALL_abs_imm1          $DA24 (scaled_force_transfer) {bytecode}, $0A
  $8C3C  B1                         POPSTORE
  $8C3D  0C                         LOADL_quick   ; inline operand = 12
  $8C3E  8F 16                      BYTE_ADD_imm1          +22
  $8C40  B3                         PUSHL
  $8C41  0C                         LOADL_quick   ; inline operand = 12
  $8C42  8F 18                      BYTE_ADD_imm1          +24
  $8C44  B0                         DEREF
  $8C45  B3                         PUSHL
  $8C46  0C                         LOADL_quick   ; inline operand = 12
  $8C47  8F 16                      BYTE_ADD_imm1          +22
  $8C49  B0                         DEREF
  $8C4A  B3                         PUSHL
  $8C4B  3D                         PUSH_quick   ; inline operand = 13
  $8C4C  6A                         PUSH_qimm   ; inline operand = 10
  $8C4D  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8C51  8F 32                      BYTE_ADD_imm1          +50
  $8C53  B3                         PUSHL
  $8C54  0C                         LOADL_quick   ; inline operand = 12
  $8C55  8F 16                      BYTE_ADD_imm1          +22
  $8C57  B0                         DEREF
  $8C58  B3                         PUSHL
  $8C59  E9 24 DA 0A                CALL_abs_imm1          $DA24 (scaled_force_transfer) {bytecode}, $0A
  $8C5D  B1                         POPSTORE
  $8C5E  3D                         PUSH_quick   ; inline operand = 13
  $8C5F  0C                         LOADL_quick   ; inline operand = 12
  $8C60  8F 10                      BYTE_ADD_imm1          +16
  $8C62  B4                         POPR
  $8C63  B3                         PUSHL
  $8C64  B0                         DEREF
  $8C65  BB                         ADD
  $8C66  B1                         POPSTORE
  $8C67  CF                         RETURN

; ============================================================
; sub $8C68   (frame_off=-2, body @ $8C6D)
; ============================================================
  $8C6D  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $8C70  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $8C74  D7 A1 8C                   JUMPT_abs              $8CA1
  $8C77  6A                         PUSH_qimm   ; inline operand = 10
  $8C78  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8C7C  D7 A1 8C                   JUMPT_abs              $8CA1
  $8C7F  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $8C82  2B                         STORE_quick   ; inline operand = 11
  $8C83  62                         PUSH_qimm   ; inline operand = 2
  $8C84  65                         PUSH_qimm   ; inline operand = 5
  $8C85  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8C89  1B                         LOADR_quick   ; inline operand = 11
  $8C8A  BB                         ADD
  $8C8B  D0                         INC
  $8C8C  B4                         POPR
  $8C8D  B3                         PUSHL
  $8C8E  D3                         BYTE_DEREF
  $8C8F  BB                         ADD
  $8C90  D4                         BYTE_POPSTORE
  $8C91  0B                         LOADL_quick   ; inline operand = 11
  $8C92  D0                         INC
  $8C93  D3                         BYTE_DEREF
  $8C94  8C C8 00                   LOADR_imm2             $00C8
  $8C97  C5                         SCMPGE
  $8C98  D8 A1 8C                   JUMPF_abs              $8CA1
  $8C9B  0B                         LOADL_quick   ; inline operand = 11
  $8C9C  D0                         INC
  $8C9D  B3                         PUSHL
  $8C9E  89 C8                      BYTE_LOADL_imm1        -56
  $8CA0  D4                         BYTE_POPSTORE
 >$8CA1  8A FF 00                   LOADL_imm2             $00FF
  $8CA4  CF                         RETURN

; ============================================================
; sub $8CA5   (frame_off=-10, body @ $8CAA)
; ============================================================
  $8CAA  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8CAD  8B 1A                      BYTE_LOADR_imm1        +26
  $8CAF  B5                         MULT
  $8CB0  8C 11 70                   LOADR_imm2             $7011
  $8CB3  BB                         ADD
  $8CB4  2A                         STORE_quick   ; inline operand = 10
  $8CB5  0A                         LOADL_quick   ; inline operand = 10
  $8CB6  72                         ADD_qimm   ; inline operand = 2
  $8CB7  28                         STORE_quick   ; inline operand = 8
  $8CB8  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8CBB  8B 1A                      BYTE_LOADR_imm1        +26
  $8CBD  B5                         MULT
  $8CBE  8C 11 70                   LOADR_imm2             $7011
  $8CC1  BB                         ADD
  $8CC2  29                         STORE_quick   ; inline operand = 9
  $8CC3  09                         LOADL_quick   ; inline operand = 9
  $8CC4  72                         ADD_qimm   ; inline operand = 2
  $8CC5  27                         STORE_quick   ; inline operand = 7
  $8CC6  40                         LOADL_qimm   ; inline operand = 0
  $8CC7  2B                         STORE_quick   ; inline operand = 11
 >$8CC8  37                         PUSH_quick   ; inline operand = 7
  $8CC9  09                         LOADL_quick   ; inline operand = 9
  $8CCA  78                         ADD_qimm   ; inline operand = 8
  $8CCB  B0                         DEREF
  $8CCC  B3                         PUSHL
  $8CCD  09                         LOADL_quick   ; inline operand = 9
  $8CCE  B0                         DEREF
  $8CCF  B3                         PUSHL
  $8CD0  3C                         PUSH_quick   ; inline operand = 12
  $8CD1  08                         LOADL_quick   ; inline operand = 8
  $8CD2  72                         ADD_qimm   ; inline operand = 2
  $8CD3  28                         STORE_quick   ; inline operand = 8
  $8CD4  8F FE                      BYTE_ADD_imm1          -2
  $8CD6  B0                         DEREF
  $8CD7  B3                         PUSHL
  $8CD8  07                         LOADL_quick   ; inline operand = 7
  $8CD9  B0                         DEREF
  $8CDA  B3                         PUSHL
  $8CDB  E9 24 DA 0A                CALL_abs_imm1          $DA24 (scaled_force_transfer) {bytecode}, $0A
  $8CDF  B1                         POPSTORE
  $8CE0  07                         LOADL_quick   ; inline operand = 7
  $8CE1  72                         ADD_qimm   ; inline operand = 2
  $8CE2  27                         STORE_quick   ; inline operand = 7
  $8CE3  0B                         LOADL_quick   ; inline operand = 11
  $8CE4  D0                         INC
  $8CE5  2B                         STORE_quick   ; inline operand = 11
  $8CE6  0B                         LOADL_quick   ; inline operand = 11
  $8CE7  53                         LOADR_qimm   ; inline operand = 3
  $8CE8  C6                         UCMPLT
  $8CE9  D7 C8 8C                   JUMPT_abs              $8CC8
  $8CEC  3C                         PUSH_quick   ; inline operand = 12
  $8CED  09                         LOADL_quick   ; inline operand = 9
  $8CEE  B4                         POPR
  $8CEF  B3                         PUSHL
  $8CF0  B0                         DEREF
  $8CF1  BB                         ADD
  $8CF2  B1                         POPSTORE
  $8CF3  3C                         PUSH_quick   ; inline operand = 12
  $8CF4  0A                         LOADL_quick   ; inline operand = 10
  $8CF5  B4                         POPR
  $8CF6  B3                         PUSHL
  $8CF7  B0                         DEREF
  $8CF8  BC                         SUB
  $8CF9  B1                         POPSTORE
  $8CFA  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $8CFD  E9 15 D8 02                CALL_abs_imm1          $D815 (clear_military_stats_if_no_men) {bytecode}, $02
  $8D01  CF                         RETURN

; ============================================================
; sub $8D02   (frame_off=-4, body @ $8D07)
; ============================================================
  $8D07  3C                         PUSH_quick   ; inline operand = 12
  $8D08  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $8D0C  74                         ADD_qimm   ; inline operand = 4
  $8D0D  D3                         BYTE_DEREF
  $8D0E  B3                         PUSHL
  $8D0F  0C                         LOADL_quick   ; inline operand = 12
  $8D10  8B 1A                      BYTE_LOADR_imm1        +26
  $8D12  B5                         MULT
  $8D13  8C 0D 70                   LOADR_imm2             $700D
  $8D16  BB                         ADD
  $8D17  B0                         DEREF
  $8D18  B4                         POPR
  $8D19  BB                         ADD
  $8D1A  2B                         STORE_quick   ; inline operand = 11
  $8D1B  3D                         PUSH_quick   ; inline operand = 13
  $8D1C  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $8D20  74                         ADD_qimm   ; inline operand = 4
  $8D21  D3                         BYTE_DEREF
  $8D22  B3                         PUSHL
  $8D23  0D                         LOADL_quick   ; inline operand = 13
  $8D24  8B 1A                      BYTE_LOADR_imm1        +26
  $8D26  B5                         MULT
  $8D27  8C 0D 70                   LOADR_imm2             $700D
  $8D2A  BB                         ADD
  $8D2B  B0                         DEREF
  $8D2C  B3                         PUSHL
  $8D2D  6A                         PUSH_qimm   ; inline operand = 10
  $8D2E  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8D32  A6 63 6D                   LOADR_abs              $6D63 (const_two)
  $8D35  B5                         MULT
  $8D36  B4                         POPR
  $8D37  BB                         ADD
  $8D38  B4                         POPR
  $8D39  BB                         ADD
  $8D3A  2A                         STORE_quick   ; inline operand = 10
  $8D3B  0B                         LOADL_quick   ; inline operand = 11
  $8D3C  1A                         LOADR_quick   ; inline operand = 10
  $8D3D  C4                         SCMPGT
  $8D3E  D8 4B 8D                   JUMPF_abs              $8D4B
  $8D41  62                         PUSH_qimm   ; inline operand = 2
  $8D42  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8D46  D8 4B 8D                   JUMPF_abs              $8D4B
  $8D49  41                         LOADL_qimm   ; inline operand = 1
  $8D4A  CF                         RETURN
 >$8D4B  40                         LOADL_qimm   ; inline operand = 0
  $8D4C  CF                         RETURN

; ============================================================
; sub $8D4D   (frame_off=-12, body @ $8D52)
; ============================================================
  $8D52  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8D55  8B 1A                      BYTE_LOADR_imm1        +26
  $8D57  B5                         MULT
  $8D58  8C 09 70                   LOADR_imm2             $7009
  $8D5B  BB                         ADD
  $8D5C  29                         STORE_quick   ; inline operand = 9
  $8D5D  09                         LOADL_quick   ; inline operand = 9
  $8D5E  74                         ADD_qimm   ; inline operand = 4
  $8D5F  2B                         STORE_quick   ; inline operand = 11
  $8D60  0B                         LOADL_quick   ; inline operand = 11
  $8D61  72                         ADD_qimm   ; inline operand = 2
  $8D62  2A                         STORE_quick   ; inline operand = 10
  $8D63  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8D66  8B 1A                      BYTE_LOADR_imm1        +26
  $8D68  B5                         MULT
  $8D69  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $8D6C  BB                         ADD
  $8D6D  28                         STORE_quick   ; inline operand = 8
  $8D6E  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8D71  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $8D74  E9 02 8D 04                CALL_abs_imm1          $8D02 (bribe_success_check) {bytecode}, $04
  $8D78  D8 BF 8D                   JUMPF_abs              $8DBF
  $8D7B  3C                         PUSH_quick   ; inline operand = 12
  $8D7C  E9 CD CB 02                CALL_abs_imm1          $CBCD (sqrt_int) {native}, $02
  $8D80  27                         STORE_quick   ; inline operand = 7
  $8D81  37                         PUSH_quick   ; inline operand = 7
  $8D82  3B                         PUSH_quick   ; inline operand = 11
  $8D83  E9 C1 8B 04                CALL_abs_imm1          $8BC1 (compute_bribe_effect_value) {bytecode}, $04
  $8D87  37                         PUSH_quick   ; inline operand = 7
  $8D88  09                         LOADL_quick   ; inline operand = 9
  $8D89  B4                         POPR
  $8D8A  B3                         PUSHL
  $8D8B  B0                         DEREF
  $8D8C  BC                         SUB
  $8D8D  B1                         POPSTORE
  $8D8E  37                         PUSH_quick   ; inline operand = 7
  $8D8F  08                         LOADL_quick   ; inline operand = 8
  $8D90  78                         ADD_qimm   ; inline operand = 8
  $8D91  B4                         POPR
  $8D92  B3                         PUSHL
  $8D93  B0                         DEREF
  $8D94  BB                         ADD
  $8D95  B1                         POPSTORE
  $8D96  60                         PUSH_qimm   ; inline operand = 0
  $8D97  E9 8F 8B 02                CALL_abs_imm1          $8B8F (play_result_jingle) {bytecode}, $02
  $8D9B  8D 1A                      BYTE_PUSH_imm1         +26
  $8D9D  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $8DA1  8E 3E BB                   PUSH_imm2              $BB3E (str_daimyo_status_msgs)
  $8DA4  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8DA8  37                         PUSH_quick   ; inline operand = 7
  $8DA9  8E 36 FC                   PUSH_imm2              $FC36 (msg_d_peasants_have_defected)
  $8DAC  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $8DB0  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $8DB3  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8DB6  E9 F7 D7 02                CALL_abs_imm1          $D7F7 (clear_econ_stats_if_no_output) {bytecode}, $02
  $8DBA  41                         LOADL_qimm   ; inline operand = 1
  $8DBB  26                         STORE_quick   ; inline operand = 6
  $8DBC  D6 E6 8D                   JUMP_abs               $8DE6
 >$8DBF  61                         PUSH_qimm   ; inline operand = 1
  $8DC0  E9 8F 8B 02                CALL_abs_imm1          $8B8F (play_result_jingle) {bytecode}, $02
  $8DC4  61                         PUSH_qimm   ; inline operand = 1
  $8DC5  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $8DC8  74                         ADD_qimm   ; inline operand = 4
  $8DC9  B4                         POPR
  $8DCA  B3                         PUSHL
  $8DCB  D3                         BYTE_DEREF
  $8DCC  BC                         SUB
  $8DCD  D4                         BYTE_POPSTORE
  $8DCE  8E 50 FC                   PUSH_imm2              $FC50 (msg_no_peasants_defected)
  $8DD1  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8DD5  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $8DD8  40                         LOADL_qimm   ; inline operand = 0
  $8DD9  26                         STORE_quick   ; inline operand = 6
  $8DDA  0C                         LOADL_quick   ; inline operand = 12
  $8DDB  52                         LOADR_qimm   ; inline operand = 2
  $8DDC  B6                         SDIV
  $8DDD  B3                         PUSHL
  $8DDE  09                         LOADL_quick   ; inline operand = 9
  $8DDF  8F F8                      BYTE_ADD_imm1          -8
  $8DE1  B4                         POPR
  $8DE2  B3                         PUSHL
  $8DE3  B0                         DEREF
  $8DE4  BB                         ADD
  $8DE5  B1                         POPSTORE
 >$8DE6  3C                         PUSH_quick   ; inline operand = 12
  $8DE7  08                         LOADL_quick   ; inline operand = 8
  $8DE8  B4                         POPR
  $8DE9  B3                         PUSHL
  $8DEA  B0                         DEREF
  $8DEB  BC                         SUB
  $8DEC  B1                         POPSTORE
  $8DED  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $8DF0  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $8DF4  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8DF7  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $8DFB  06                         LOADL_quick   ; inline operand = 6
  $8DFC  CF                         RETURN

; ============================================================
; sub $8DFD   (frame_off=-34, body @ $8E02)
; ============================================================
  $8E02  40                         LOADL_qimm   ; inline operand = 0
  $8E03  27                         STORE_quick   ; inline operand = 7
  $8E04  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $8E07  29                         STORE_quick   ; inline operand = 9
  $8E08  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8E0B  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $8E0F  28                         STORE_quick   ; inline operand = 8
  $8E10  8A 7F 6F                   LOADL_imm2             $6F7F (war_attacker_rice)
  $8E13  24                         STORE_quick   ; inline operand = 4
  $8E14  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8E17  8B 1A                      BYTE_LOADR_imm1        +26
  $8E19  B5                         MULT
  $8E1A  8C 13 70                   LOADR_imm2             $7013
  $8E1D  BB                         ADD
  $8E1E  23                         STORE_quick   ; inline operand = 3
  $8E1F  03                         LOADL_quick   ; inline operand = 3
  $8E20  72                         ADD_qimm   ; inline operand = 2
  $8E21  22                         STORE_quick   ; inline operand = 2
  $8E22  02                         LOADL_quick   ; inline operand = 2
  $8E23  72                         ADD_qimm   ; inline operand = 2
  $8E24  21                         STORE_quick   ; inline operand = 1
  $8E25  04                         LOADL_quick   ; inline operand = 4
  $8E26  72                         ADD_qimm   ; inline operand = 2
  $8E27  20                         STORE_quick   ; inline operand = 0
  $8E28  8A 85 6F                   LOADL_imm2             $6F85 (war_defender_rice)
  $8E2B  85 E6                      STORE_near             $E6
  $8E2D  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8E30  8B 1A                      BYTE_LOADR_imm1        +26
  $8E32  B5                         MULT
  $8E33  8C 13 70                   LOADR_imm2             $7013
  $8E36  BB                         ADD
  $8E37  85 E4                      STORE_near             $E4
  $8E39  81 E4                      LOADL_near             $E4
  $8E3B  72                         ADD_qimm   ; inline operand = 2
  $8E3C  85 E2                      STORE_near             $E2
  $8E3E  81 E2                      LOADL_near             $E2
  $8E40  72                         ADD_qimm   ; inline operand = 2
  $8E41  85 E0                      STORE_near             $E0
  $8E43  81 E6                      LOADL_near             $E6
  $8E45  72                         ADD_qimm   ; inline operand = 2
  $8E46  85 DE                      STORE_near             $DE
  $8E48  62                         PUSH_qimm   ; inline operand = 2
  $8E49  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $8E4D  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8E50  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $8E53  BB                         ADD
  $8E54  D3                         BYTE_DEREF
  $8E55  57                         LOADR_qimm   ; inline operand = 7
  $8E56  BD                         LSHIFT
  $8E57  A9 66 6F                   BYTE_STORE_abs         $6F66 (battle_defender_status_flag_6f66)
  $8E5A  03                         LOADL_quick   ; inline operand = 3
  $8E5B  B0                         DEREF
  $8E5C  B3                         PUSHL
  $8E5D  02                         LOADL_quick   ; inline operand = 2
  $8E5E  B0                         DEREF
  $8E5F  52                         LOADR_qimm   ; inline operand = 2
  $8E60  B6                         SDIV
  $8E61  B3                         PUSHL
  $8E62  01                         LOADL_quick   ; inline operand = 1
  $8E63  B0                         DEREF
  $8E64  52                         LOADR_qimm   ; inline operand = 2
  $8E65  B6                         SDIV
  $8E66  B4                         POPR
  $8E67  BB                         ADD
  $8E68  D2                         LSHIFT1
  $8E69  B3                         PUSHL
  $8E6A  00                         LOADL_quick   ; inline operand = 0
  $8E6B  B0                         DEREF
  $8E6C  B3                         PUSHL
  $8E6D  A5 65 6F                   BYTE_LOADL_abs         $6F65 (war_side_state_flag)
  $8E70  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $8E73  DA                         AND
  $8E74  50                         LOADR_qimm   ; inline operand = 0
  $8E75  C1                         CMPNE
  $8E76  72                         ADD_qimm   ; inline operand = 2
  $8E77  B4                         POPR
  $8E78  B5                         MULT
  $8E79  B4                         POPR
  $8E7A  BB                         ADD
  $8E7B  B4                         POPR
  $8E7C  BB                         ADD
  $8E7D  2B                         STORE_quick   ; inline operand = 11
  $8E7E  81 E4                      LOADL_near             $E4
  $8E80  B0                         DEREF
  $8E81  B3                         PUSHL
  $8E82  81 E2                      LOADL_near             $E2
  $8E84  B0                         DEREF
  $8E85  52                         LOADR_qimm   ; inline operand = 2
  $8E86  B6                         SDIV
  $8E87  B3                         PUSHL
  $8E88  81 E0                      LOADL_near             $E0
  $8E8A  B0                         DEREF
  $8E8B  52                         LOADR_qimm   ; inline operand = 2
  $8E8C  B6                         SDIV
  $8E8D  B4                         POPR
  $8E8E  BB                         ADD
  $8E8F  D2                         LSHIFT1
  $8E90  B3                         PUSHL
  $8E91  81 DE                      LOADL_near             $DE
  $8E93  B0                         DEREF
  $8E94  B3                         PUSHL
  $8E95  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8E98  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $8E9B  BB                         ADD
  $8E9C  D3                         BYTE_DEREF
  $8E9D  72                         ADD_qimm   ; inline operand = 2
  $8E9E  B4                         POPR
  $8E9F  B5                         MULT
  $8EA0  B4                         POPR
  $8EA1  BB                         ADD
  $8EA2  B4                         POPR
  $8EA3  BB                         ADD
  $8EA4  2A                         STORE_quick   ; inline operand = 10
  $8EA5  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8EA8  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $8EAC  25                         STORE_quick   ; inline operand = 5
  $8EAD  72                         ADD_qimm   ; inline operand = 2
  $8EAE  D3                         BYTE_DEREF
  $8EAF  B3                         PUSHL
  $8EB0  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $8EB3  26                         STORE_quick   ; inline operand = 6
  $8EB4  72                         ADD_qimm   ; inline operand = 2
  $8EB5  D3                         BYTE_DEREF
  $8EB6  B4                         POPR
  $8EB7  C2                         SCMPLT
  $8EB8  D8 CB 8E                   JUMPF_abs              $8ECB
  $8EBB  6A                         PUSH_qimm   ; inline operand = 10
  $8EBC  81 E4                      LOADL_near             $E4
  $8EBE  B0                         DEREF
  $8EBF  B3                         PUSHL
  $8EC0  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $8EC4  CD                         SWAP
  $8EC5  0A                         LOADL_quick   ; inline operand = 10
  $8EC6  BB                         ADD
  $8EC7  2A                         STORE_quick   ; inline operand = 10
  $8EC8  D6 D7 8E                   JUMP_abs               $8ED7
 >$8ECB  6A                         PUSH_qimm   ; inline operand = 10
  $8ECC  03                         LOADL_quick   ; inline operand = 3
  $8ECD  B0                         DEREF
  $8ECE  B3                         PUSHL
  $8ECF  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $8ED3  CD                         SWAP
  $8ED4  0B                         LOADL_quick   ; inline operand = 11
  $8ED5  BB                         ADD
  $8ED6  2B                         STORE_quick   ; inline operand = 11
 >$8ED7  0A                         LOADL_quick   ; inline operand = 10
  $8ED8  1B                         LOADR_quick   ; inline operand = 11
  $8ED9  C6                         UCMPLT
  $8EDA  D8 F4 8E                   JUMPF_abs              $8EF4
  $8EDD  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8EE0  A8 57 6F                   STORE_abs              $6F57 (battle_winner_province_sel)
  $8EE3  A4 87 6F                   LOADL_abs              $6F87 (war_defender_men)
  $8EE6  52                         LOADR_qimm   ; inline operand = 2
  $8EE7  B6                         SDIV
  $8EE8  B3                         PUSHL
  $8EE9  00                         LOADL_quick   ; inline operand = 0
  $8EEA  B4                         POPR
  $8EEB  B3                         PUSHL
  $8EEC  B0                         DEREF
  $8EED  BB                         ADD
  $8EEE  B1                         POPSTORE
  $8EEF  87 DE                      PUSH_near              $DE
  $8EF1  D6 08 8F                   JUMP_abs               $8F08
 >$8EF4  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8EF7  A8 57 6F                   STORE_abs              $6F57 (battle_winner_province_sel)
  $8EFA  A4 81 6F                   LOADL_abs              $6F81 (war_attacker_men)
  $8EFD  52                         LOADR_qimm   ; inline operand = 2
  $8EFE  B6                         SDIV
  $8EFF  B3                         PUSHL
  $8F00  81 DE                      LOADL_near             $DE
  $8F02  B4                         POPR
  $8F03  B3                         PUSHL
  $8F04  B0                         DEREF
  $8F05  BB                         ADD
  $8F06  B1                         POPSTORE
  $8F07  30                         PUSH_quick   ; inline operand = 0
 >$8F08  40                         LOADL_qimm   ; inline operand = 0
  $8F09  B1                         POPSTORE
  $8F0A  A4 57 6F                   LOADL_abs              $6F57 (battle_winner_province_sel)
  $8F0D  A6 5F 6F                   LOADR_abs              $6F5F (selected_province_idx)
  $8F10  C0                         CMPEQ
  $8F11  D8 42 8F                   JUMPF_abs              $8F42
  $8F14  A5 65 6F                   BYTE_LOADL_abs         $6F65 (war_side_state_flag)
  $8F17  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $8F1A  DA                         AND
  $8F1B  D8 A1 8F                   JUMPF_abs              $8FA1
  $8F1E  06                         LOADL_quick   ; inline operand = 6
  $8F1F  73                         ADD_qimm   ; inline operand = 3
  $8F20  D3                         BYTE_DEREF
  $8F21  5A                         LOADR_qimm   ; inline operand = 10
  $8F22  B6                         SDIV
  $8F23  B3                         PUSHL
  $8F24  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8F28  D8 3E 8F                   JUMPF_abs              $8F3E
  $8F2B  40                         LOADL_qimm   ; inline operand = 0
  $8F2C  A9 65 6F                   BYTE_STORE_abs         $6F65 (war_side_state_flag)
  $8F2F  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8F32  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $8F35  BB                         ADD
  $8F36  B3                         PUSHL
  $8F37  41                         LOADL_qimm   ; inline operand = 1
  $8F38  D4                         BYTE_POPSTORE
  $8F39  43                         LOADL_qimm   ; inline operand = 3
 >$8F3A  27                         STORE_quick   ; inline operand = 7
  $8F3B  D6 A1 8F                   JUMP_abs               $8FA1
 >$8F3E  41                         LOADL_qimm   ; inline operand = 1
  $8F3F  D6 3A 8F                   JUMP_abs               $8F3A
 >$8F42  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $8F45  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $8F48  BB                         ADD
  $8F49  D3                         BYTE_DEREF
  $8F4A  D8 A1 8F                   JUMPF_abs              $8FA1
  $8F4D  8E 5F 6F                   PUSH_imm2              $6F5F (selected_province_idx)
  $8F50  8E 63 6F                   PUSH_imm2              $6F63 (battle_defending_province)
  $8F53  E9 94 CB 04                CALL_abs_imm1          $CB94 (swap_word) {bytecode}, $04
  $8F57  AC D7 DA                   CALL_abs               $DAD7 (compact_relation_list) {bytecode}
  $8F5A  8E 4F 6F                   PUSH_imm2              $6F4F (deduped_owner_list)
  $8F5D  61                         PUSH_qimm   ; inline operand = 1
  $8F5E  E9 3A DD 04                CALL_abs_imm1          $DD3A (filter_province_list_by_owner) {bytecode}, $04
  $8F62  A5 4F 6F                   BYTE_LOADL_abs         $6F4F (deduped_owner_list)
  $8F65  8C FF 00                   LOADR_imm2             $00FF
  $8F68  C1                         CMPNE
  $8F69  D8 95 8F                   JUMPF_abs              $8F95
  $8F6C  05                         LOADL_quick   ; inline operand = 5
  $8F6D  73                         ADD_qimm   ; inline operand = 3
  $8F6E  D3                         BYTE_DEREF
  $8F6F  5A                         LOADR_qimm   ; inline operand = 10
  $8F70  B6                         SDIV
  $8F71  B3                         PUSHL
  $8F72  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $8F76  D8 95 8F                   JUMPF_abs              $8F95
  $8F79  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $8F7C  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $8F7F  BB                         ADD
  $8F80  B3                         PUSHL
  $8F81  40                         LOADL_qimm   ; inline operand = 0
  $8F82  D4                         BYTE_POPSTORE
  $8F83  A5 4F 6F                   BYTE_LOADL_abs         $6F4F (deduped_owner_list)
  $8F86  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $8F89  BB                         ADD
  $8F8A  B3                         PUSHL
  $8F8B  41                         LOADL_qimm   ; inline operand = 1
  $8F8C  D4                         BYTE_POPSTORE
  $8F8D  40                         LOADL_qimm   ; inline operand = 0
  $8F8E  A9 66 6F                   BYTE_STORE_abs         $6F66 (battle_defender_status_flag_6f66)
  $8F91  44                         LOADL_qimm   ; inline operand = 4
  $8F92  D6 96 8F                   JUMP_abs               $8F96
 >$8F95  42                         LOADL_qimm   ; inline operand = 2
 >$8F96  27                         STORE_quick   ; inline operand = 7
  $8F97  8E 5F 6F                   PUSH_imm2              $6F5F (selected_province_idx)
  $8F9A  8E 63 6F                   PUSH_imm2              $6F63 (battle_defending_province)
  $8F9D  E9 94 CB 04                CALL_abs_imm1          $CB94 (swap_word) {bytecode}, $04
 >$8FA1  AA 57 6F                   PUSH_abs               $6F57 (battle_winner_province_sel)
  $8FA4  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $8FA8  59                         LOADR_qimm   ; inline operand = 9
  $8FA9  B5                         MULT
  $8FAA  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $8FAD  BB                         ADD
  $8FAE  B3                         PUSHL
  $8FAF  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8FB3  8E 3F BB                   PUSH_imm2              $BB3F (msg_has_lost)
  $8FB6  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8FBA  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $8FBD  07                         LOADL_quick   ; inline operand = 7
  $8FBE  D5 FF FF 04 00 D4 8F CD 8F D8 8F DE ... SWITCH_contig          limit=4   ; .table 4 word targets (contiguous); SWITCH 1=>$8FCD 2=>$8FD8 3=>$8FDE 4=>$8FF7 default=>$8FD4
 >$8FCD  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
 >$8FD0  E9 75 E2 02                CALL_abs_imm1          $E275 (announce_daimyo_death) {bytecode}, $02
 >$8FD4  AC 3C E0                   CALL_abs               $E03C (apply_conquest_outcome) {bytecode}
  $8FD7  CF                         RETURN
 >$8FD8  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $8FDB  D6 D0 8F                   JUMP_abs               $8FD0
 >$8FDE  09                         LOADL_quick   ; inline operand = 9
  $8FDF  59                         LOADR_qimm   ; inline operand = 9
  $8FE0  B5                         MULT
  $8FE1  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $8FE4  BB                         ADD
  $8FE5  B3                         PUSHL
  $8FE6  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $8FEA  8E 49 BB                   PUSH_imm2              $BB49
 >$8FED  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $8FF1  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $8FF4  D6 D4 8F                   JUMP_abs               $8FD4
 >$8FF7  08                         LOADL_quick   ; inline operand = 8
  $8FF8  59                         LOADR_qimm   ; inline operand = 9
  $8FF9  B5                         MULT
  $8FFA  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $8FFD  BB                         ADD
  $8FFE  B3                         PUSHL
  $8FFF  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9003  8E 58 BB                   PUSH_imm2              $BB58
  $9006  D6 ED 8F                   JUMP_abs               $8FED

; ============================================================
; sub $9009   (frame_off=+0, body @ $900E)
; ============================================================
  $900E  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $9011  59                         LOADR_qimm   ; inline operand = 9
  $9012  B5                         MULT
  $9013  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $9016  BB                         ADD
  $9017  B3                         PUSHL
  $9018  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $901C  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $901F  D0                         INC
  $9020  B3                         PUSHL
  $9021  8E 62 BB                   PUSH_imm2              $BB62 (msg_from_fief_2d_has)
  $9024  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $9028  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $902B  D0                         INC
  $902C  B3                         PUSHL
  $902D  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $9030  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $9034  59                         LOADR_qimm   ; inline operand = 9
  $9035  B5                         MULT
  $9036  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $9039  BB                         ADD
  $903A  B3                         PUSHL
  $903B  8E 76 BB                   PUSH_imm2              $BB76 (msg_invaded_s_in_fief_2d)
  $903E  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $9042  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9045  CF                         RETURN

; ============================================================
; sub $9046   (frame_off=-6, body @ $904B)
; ============================================================
  $904B  40                         LOADL_qimm   ; inline operand = 0
  $904C  A8 79 6F                   STORE_abs              $6F79 (ai_turn_loop_redispatch_flag)
  $904F  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9052  8C 67 6D                   LOADR_imm2             $6D67 (rest_turns_remaining)
  $9055  BB                         ADD
  $9056  D3                         BYTE_DEREF
  $9057  D7 6F 90                   JUMPT_abs              $906F
  $905A  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $905D  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $9060  BB                         ADD
  $9061  D3                         BYTE_DEREF
  $9062  D8 6F 90                   JUMPF_abs              $906F
  $9065  62                         PUSH_qimm   ; inline operand = 2
  $9066  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $906A  57                         LOADR_qimm   ; inline operand = 7
  $906B  BD                         LSHIFT
  $906C  D6 70 90                   JUMP_abs               $9070
 >$906F  40                         LOADL_qimm   ; inline operand = 0
 >$9070  A9 65 6F                   BYTE_STORE_abs         $6F65 (war_side_state_flag)
  $9073  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9076  8B 1A                      BYTE_LOADR_imm1        +26
  $9078  B5                         MULT
  $9079  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $907C  BB                         ADD
  $907D  2B                         STORE_quick   ; inline operand = 11
  $907E  0B                         LOADL_quick   ; inline operand = 11
  $907F  B0                         DEREF
  $9080  B3                         PUSHL
  $9081  0B                         LOADL_quick   ; inline operand = 11
  $9082  8F 10                      BYTE_ADD_imm1          +16
  $9084  B0                         DEREF
  $9085  B3                         PUSHL
  $9086  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $908A  B3                         PUSHL
  $908B  0B                         LOADL_quick   ; inline operand = 11
  $908C  76                         ADD_qimm   ; inline operand = 6
  $908D  B0                         DEREF
  $908E  D2                         LSHIFT1
  $908F  B3                         PUSHL
  $9090  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $9094  2A                         STORE_quick   ; inline operand = 10
  $9095  0A                         LOADL_quick   ; inline operand = 10
  $9096  55                         LOADR_qimm   ; inline operand = 5
  $9097  C2                         SCMPLT
  $9098  D8 9D 90                   JUMPF_abs              $909D
  $909B  40                         LOADL_qimm   ; inline operand = 0
  $909C  CF                         RETURN
 >$909D  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $90A0  8B 1A                      BYTE_LOADR_imm1        +26
  $90A2  B5                         MULT
  $90A3  8C 11 70                   LOADR_imm2             $7011
  $90A6  BB                         ADD
  $90A7  B0                         DEREF
  $90A8  B3                         PUSHL
  $90A9  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $90AC  8B 1A                      BYTE_LOADR_imm1        +26
  $90AE  B5                         MULT
  $90AF  8C 07 70                   LOADR_imm2             $7007
  $90B2  BB                         ADD
  $90B3  B0                         DEREF
  $90B4  B3                         PUSHL
  $90B5  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $90B9  1A                         LOADR_quick   ; inline operand = 10
  $90BA  C4                         SCMPGT
  $90BB  D8 C0 90                   JUMPF_abs              $90C0
  $90BE  40                         LOADL_qimm   ; inline operand = 0
  $90BF  CF                         RETURN
 >$90C0  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $90C3  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $90C6  E9 71 82 04                CALL_abs_imm1          $8271 (relations_rng_predicate) {bytecode}, $04
  $90CA  D8 CF 90                   JUMPF_abs              $90CF
  $90CD  40                         LOADL_qimm   ; inline operand = 0
  $90CE  CF                         RETURN
 >$90CF  A5 65 6F                   BYTE_LOADL_abs         $6F65 (war_side_state_flag)
  $90D2  D7 E0 90                   JUMPT_abs              $90E0
  $90D5  8D 14                      BYTE_PUSH_imm1         +20
  $90D7  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $90DB  8F 32                      BYTE_ADD_imm1          +50
  $90DD  D6 E8 90                   JUMP_abs               $90E8
 >$90E0  8D 1E                      BYTE_PUSH_imm1         +30
  $90E2  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $90E6  8F 3C                      BYTE_ADD_imm1          +60
 >$90E8  B3                         PUSHL
  $90E9  3A                         PUSH_quick   ; inline operand = 10
  $90EA  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $90EE  29                         STORE_quick   ; inline operand = 9
  $90EF  09                         LOADL_quick   ; inline operand = 9
  $90F0  A8 81 6F                   STORE_abs              $6F81 (war_attacker_men)
  $90F3  A8 7D 6F                   STORE_abs              $6F7D (war_attacker_gold)
  $90F6  39                         PUSH_quick   ; inline operand = 9
  $90F7  0B                         LOADL_quick   ; inline operand = 11
  $90F8  B4                         POPR
  $90F9  B3                         PUSHL
  $90FA  B0                         DEREF
  $90FB  BC                         SUB
  $90FC  B1                         POPSTORE
  $90FD  39                         PUSH_quick   ; inline operand = 9
  $90FE  0B                         LOADL_quick   ; inline operand = 11
  $90FF  8F 10                      BYTE_ADD_imm1          +16
  $9101  B4                         POPR
  $9102  B3                         PUSHL
  $9103  B0                         DEREF
  $9104  BC                         SUB
  $9105  B1                         POPSTORE
  $9106  39                         PUSH_quick   ; inline operand = 9
  $9107  0B                         LOADL_quick   ; inline operand = 11
  $9108  76                         ADD_qimm   ; inline operand = 6
  $9109  B0                         DEREF
  $910A  B3                         PUSHL
  $910B  E9 DE D6 04                CALL_abs_imm1          $D6DE (math32_2arg) {bytecode}, $04
  $910F  8B 37                      BYTE_LOADR_imm1        +55
  $9111  C8                         UCMPGT
  $9112  D8 19 91                   JUMPF_abs              $9119
  $9115  09                         LOADL_quick   ; inline operand = 9
  $9116  D6 30 91                   JUMP_abs               $9130
 >$9119  6A                         PUSH_qimm   ; inline operand = 10
  $911A  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $911E  8F 32                      BYTE_ADD_imm1          +50
  $9120  B3                         PUSHL
  $9121  39                         PUSH_quick   ; inline operand = 9
  $9122  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9126  B3                         PUSHL
  $9127  0B                         LOADL_quick   ; inline operand = 11
  $9128  76                         ADD_qimm   ; inline operand = 6
  $9129  B0                         DEREF
  $912A  D1                         DEC
  $912B  B3                         PUSHL
  $912C  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
 >$9130  A8 7F 6F                   STORE_abs              $6F7F (war_attacker_rice)
  $9133  AA 7F 6F                   PUSH_abs               $6F7F (war_attacker_rice)
  $9136  0B                         LOADL_quick   ; inline operand = 11
  $9137  76                         ADD_qimm   ; inline operand = 6
  $9138  B4                         POPR
  $9139  B3                         PUSHL
  $913A  B0                         DEREF
  $913B  BC                         SUB
  $913C  B1                         POPSTORE
  $913D  A4 7D 6E                   LOADL_abs              $6E7D (ui_confirm_flag_6e7d)
  $9140  D7 4F 91                   JUMPT_abs              $914F
  $9143  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $9146  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $914A  55                         LOADR_qimm   ; inline operand = 5
  $914B  C0                         CMPEQ
  $914C  D8 59 91                   JUMPF_abs              $9159
 >$914F  AC 09 90                   CALL_abs               $9009 (ai_attack_announce_prompt) {bytecode}
  $9152  41                         LOADL_qimm   ; inline operand = 1
  $9153  A8 79 6F                   STORE_abs              $6F79 (ai_turn_loop_redispatch_flag)
  $9156  D6 7F 91                   JUMP_abs               $917F
 >$9159  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $915C  8B 1A                      BYTE_LOADR_imm1        +26
  $915E  B5                         MULT
  $915F  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9162  BB                         ADD
  $9163  2B                         STORE_quick   ; inline operand = 11
  $9164  B0                         DEREF
  $9165  A8 83 6F                   STORE_abs              $6F83 (war_defender_gold)
  $9168  0B                         LOADL_quick   ; inline operand = 11
  $9169  76                         ADD_qimm   ; inline operand = 6
  $916A  B0                         DEREF
  $916B  A8 85 6F                   STORE_abs              $6F85 (war_defender_rice)
  $916E  0B                         LOADL_quick   ; inline operand = 11
  $916F  8F 10                      BYTE_ADD_imm1          +16
  $9171  B0                         DEREF
  $9172  A8 87 6F                   STORE_abs              $6F87 (war_defender_men)
  $9175  40                         LOADL_qimm   ; inline operand = 0
  $9176  A8 79 6F                   STORE_abs              $6F79 (ai_turn_loop_redispatch_flag)
  $9179  AC 09 90                   CALL_abs               $9009 (ai_attack_announce_prompt) {bytecode}
  $917C  AC FD 8D                   CALL_abs               $8DFD (resolve_siege_assault_outcome) {bytecode}
 >$917F  41                         LOADL_qimm   ; inline operand = 1
  $9180  CF                         RETURN

; ============================================================
; sub $9181   (frame_off=+0, body @ $9186)
; ============================================================
  $9186  61                         PUSH_qimm   ; inline operand = 1
  $9187  3C                         PUSH_quick   ; inline operand = 12
  $9188  E9 12 CA 04                CALL_abs_imm1          $CA12 (deduct_byte_at) {bytecode}, $04
  $918C  CF                         RETURN

; ============================================================
; sub $918D   (frame_off=-20, body @ $9192)
; ============================================================
  $9192  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $9195  23                         STORE_quick   ; inline operand = 3
  $9196  74                         ADD_qimm   ; inline operand = 4
  $9197  25                         STORE_quick   ; inline operand = 5
  $9198  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $919B  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $919F  D7 E3 92                   JUMPT_abs              $92E3
  $91A2  40                         LOADL_qimm   ; inline operand = 0
  $91A3  29                         STORE_quick   ; inline operand = 9
  $91A4  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $91A7  8B 1A                      BYTE_LOADR_imm1        +26
  $91A9  B5                         MULT
  $91AA  8C 11 70                   LOADR_imm2             $7011
  $91AD  BB                         ADD
  $91AE  2B                         STORE_quick   ; inline operand = 11
  $91AF  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $91B2  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $91B6  22                         STORE_quick   ; inline operand = 2
  $91B7  D0                         INC
  $91B8  24                         STORE_quick   ; inline operand = 4
  $91B9  04                         LOADL_quick   ; inline operand = 4
  $91BA  72                         ADD_qimm   ; inline operand = 2
  $91BB  27                         STORE_quick   ; inline operand = 7
  $91BC  07                         LOADL_quick   ; inline operand = 7
  $91BD  D0                         INC
  $91BE  26                         STORE_quick   ; inline operand = 6
  $91BF  03                         LOADL_quick   ; inline operand = 3
  $91C0  75                         ADD_qimm   ; inline operand = 5
  $91C1  D3                         BYTE_DEREF
  $91C2  B3                         PUSHL
  $91C3  05                         LOADL_quick   ; inline operand = 5
  $91C4  D3                         BYTE_DEREF
  $91C5  B4                         POPR
  $91C6  BB                         ADD
  $91C7  B3                         PUSHL
  $91C8  02                         LOADL_quick   ; inline operand = 2
  $91C9  75                         ADD_qimm   ; inline operand = 5
  $91CA  D3                         BYTE_DEREF
  $91CB  B3                         PUSHL
  $91CC  06                         LOADL_quick   ; inline operand = 6
  $91CD  D3                         BYTE_DEREF
  $91CE  B4                         POPR
  $91CF  BB                         ADD
  $91D0  B4                         POPR
  $91D1  C3                         SCMPLE
  $91D2  D8 E3 92                   JUMPF_abs              $92E3
  $91D5  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $91D8  5A                         LOADR_qimm   ; inline operand = 10
  $91D9  B5                         MULT
  $91DA  B3                         PUSHL
  $91DB  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $91DF  B3                         PUSHL
  $91E0  05                         LOADL_quick   ; inline operand = 5
  $91E1  D3                         BYTE_DEREF
  $91E2  B4                         POPR
  $91E3  BC                         SUB
  $91E4  B3                         PUSHL
  $91E5  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $91E8  5A                         LOADR_qimm   ; inline operand = 10
  $91E9  B5                         MULT
  $91EA  B3                         PUSHL
  $91EB  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $91EF  B3                         PUSHL
  $91F0  06                         LOADL_quick   ; inline operand = 6
  $91F1  D3                         BYTE_DEREF
  $91F2  B4                         POPR
  $91F3  BC                         SUB
  $91F4  B4                         POPR
  $91F5  C4                         SCMPGT
  $91F6  D8 13 92                   JUMPF_abs              $9213
  $91F9  03                         LOADL_quick   ; inline operand = 3
  $91FA  D0                         INC
  $91FB  24                         STORE_quick   ; inline operand = 4
  $91FC  05                         LOADL_quick   ; inline operand = 5
  $91FD  26                         STORE_quick   ; inline operand = 6
  $91FE  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9201  8B 1A                      BYTE_LOADR_imm1        +26
  $9203  B5                         MULT
  $9204  8C 11 70                   LOADR_imm2             $7011
  $9207  BB                         ADD
  $9208  2B                         STORE_quick   ; inline operand = 11
  $9209  04                         LOADL_quick   ; inline operand = 4
  $920A  72                         ADD_qimm   ; inline operand = 2
  $920B  27                         STORE_quick   ; inline operand = 7
  $920C  41                         LOADL_qimm   ; inline operand = 1
  $920D  29                         STORE_quick   ; inline operand = 9
  $920E  35                         PUSH_quick   ; inline operand = 5
  $920F  E9 81 91 02                CALL_abs_imm1          $9181 (decrement_byte_at) {bytecode}, $02
 >$9213  41                         LOADL_qimm   ; inline operand = 1
  $9214  28                         STORE_quick   ; inline operand = 8
  $9215  6A                         PUSH_qimm   ; inline operand = 10
  $9216  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $921A  D0                         INC
  $921B  B3                         PUSHL
  $921C  0B                         LOADL_quick   ; inline operand = 11
  $921D  B0                         DEREF
  $921E  B4                         POPR
  $921F  C3                         SCMPLE
  $9220  D8 60 92                   JUMPF_abs              $9260
  $9223  06                         LOADL_quick   ; inline operand = 6
  $9224  D3                         BYTE_DEREF
  $9225  B3                         PUSHL
  $9226  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $922A  8F 32                      BYTE_ADD_imm1          +50
  $922C  2A                         STORE_quick   ; inline operand = 10
  $922D  8B 64                      BYTE_LOADR_imm1        +100
  $922F  C4                         SCMPGT
  $9230  D8 36 92                   JUMPF_abs              $9236
  $9233  89 64                      BYTE_LOADL_imm1        +100
  $9235  2A                         STORE_quick   ; inline operand = 10
 >$9236  07                         LOADL_quick   ; inline operand = 7
  $9237  D3                         BYTE_DEREF
  $9238  5A                         LOADR_qimm   ; inline operand = 10
  $9239  B6                         SDIV
  $923A  B3                         PUSHL
  $923B  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $923F  B3                         PUSHL
  $9240  3A                         PUSH_quick   ; inline operand = 10
  $9241  0B                         LOADL_quick   ; inline operand = 11
  $9242  B0                         DEREF
  $9243  B3                         PUSHL
  $9244  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $9248  B3                         PUSHL
  $9249  0C                         LOADL_quick   ; inline operand = 12
  $924A  B4                         POPR
  $924B  B6                         SDIV
  $924C  B4                         POPR
  $924D  C3                         SCMPLE
  $924E  D8 60 92                   JUMPF_abs              $9260
  $9251  07                         LOADL_quick   ; inline operand = 7
  $9252  D3                         BYTE_DEREF
  $9253  8B 64                      BYTE_LOADR_imm1        +100
  $9255  B6                         SDIV
  $9256  B3                         PUSHL
  $9257  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $925B  D8 60 92                   JUMPF_abs              $9260
  $925E  40                         LOADL_qimm   ; inline operand = 0
  $925F  28                         STORE_quick   ; inline operand = 8
 >$9260  08                         LOADL_quick   ; inline operand = 8
  $9261  D8 BC 92                   JUMPF_abs              $92BC
  $9264  09                         LOADL_quick   ; inline operand = 9
  $9265  D0                         INC
  $9266  B3                         PUSHL
  $9267  04                         LOADL_quick   ; inline operand = 4
  $9268  D3                         BYTE_DEREF
  $9269  B4                         POPR
  $926A  B8                         UDIV
  $926B  B3                         PUSHL
  $926C  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9270  D0                         INC
  $9271  B3                         PUSHL
  $9272  34                         PUSH_quick   ; inline operand = 4
  $9273  E9 12 CA 04                CALL_abs_imm1          $CA12 (deduct_byte_at) {bytecode}, $04
  $9277  09                         LOADL_quick   ; inline operand = 9
  $9278  D8 81 92                   JUMPF_abs              $9281
  $927B  8E 8D BB                   PUSH_imm2              $BB8D (msg_counterattacked)
  $927E  D6 84 92                   JUMP_abs               $9284
 >$9281  8E BB FB                   PUSH_imm2              $FBBB (msg_enemy_morale_is_falling_to_pie)
 >$9284  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9288  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $928B  61                         PUSH_qimm   ; inline operand = 1
  $928C  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
 >$9290  04                         LOADL_quick   ; inline operand = 4
  $9291  D3                         BYTE_DEREF
  $9292  B3                         PUSHL
  $9293  8A E6 00                   LOADL_imm2             $00E6
  $9296  B4                         POPR
  $9297  C4                         SCMPGT
  $9298  D7 A0 92                   JUMPT_abs              $92A0
  $929B  04                         LOADL_quick   ; inline operand = 4
  $929C  D3                         BYTE_DEREF
  $929D  D7 F2 92                   JUMPT_abs              $92F2
 >$92A0  09                         LOADL_quick   ; inline operand = 9
  $92A1  D7 F2 92                   JUMPT_abs              $92F2
  $92A4  34                         PUSH_quick   ; inline operand = 4
  $92A5  40                         LOADL_qimm   ; inline operand = 0
  $92A6  D4                         BYTE_POPSTORE
  $92A7  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $92AA  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $92AD  BB                         ADD
  $92AE  D3                         BYTE_DEREF
  $92AF  D8 D9 92                   JUMPF_abs              $92D9
  $92B2  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $92B5  E9 25 E4 02                CALL_abs_imm1          $E425 (find_fiefs_of_owner) {bytecode}, $02
  $92B9  D6 F2 92                   JUMP_abs               $92F2
 >$92BC  04                         LOADL_quick   ; inline operand = 4
  $92BD  B3                         PUSHL
  $92BE  D3                         BYTE_DEREF
  $92BF  D1                         DEC
  $92C0  D4                         BYTE_POPSTORE
  $92C1  09                         LOADL_quick   ; inline operand = 9
  $92C2  D8 E3 92                   JUMPF_abs              $92E3
  $92C5  8E 8D BB                   PUSH_imm2              $BB8D (msg_counterattacked)
  $92C8  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $92CC  8E 9E BB                   PUSH_imm2              $BB9E (msg_you_have_repelled)
  $92CF  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $92D3  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $92D6  D6 90 92                   JUMP_abs               $9290
 >$92D9  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $92DC  E9 54 E4 02                CALL_abs_imm1          $E454 (neutralize_fief) {bytecode}, $02
  $92E0  D6 F2 92                   JUMP_abs               $92F2
 >$92E3  35                         PUSH_quick   ; inline operand = 5
  $92E4  E9 81 91 02                CALL_abs_imm1          $9181 (decrement_byte_at) {bytecode}, $02
  $92E8  8E B2 BB                   PUSH_imm2              $BBB2 (msg_your_ninja_failed)
  $92EB  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $92EF  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$92F2  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $92F5  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $92F9  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $92FC  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $9300  CF                         RETURN

; ============================================================
; sub $9301   (frame_off=+0, body @ $9306)
; ============================================================
  $9306  0E                         LOADL_quick   ; inline operand = 14
  $9307  B0                         DEREF
  $9308  50                         LOADR_qimm   ; inline operand = 0
  $9309  C3                         SCMPLE
  $930A  D8 20 93                   JUMPF_abs              $9320
  $930D  3E                         PUSH_quick   ; inline operand = 14
  $930E  40                         LOADL_qimm   ; inline operand = 0
  $930F  B1                         POPSTORE
  $9310  3D                         PUSH_quick   ; inline operand = 13
  $9311  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9315  D8 20 93                   JUMPF_abs              $9320
  $9318  3C                         PUSH_quick   ; inline operand = 12
  $9319  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $931D  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$9320  0E                         LOADL_quick   ; inline operand = 14
  $9321  B0                         DEREF
  $9322  CF                         RETURN

; ============================================================
; sub $9323   (frame_off=+0, body @ $9328)
; ============================================================
  $9328  0C                         LOADL_quick   ; inline operand = 12
  $9329  8B 1A                      BYTE_LOADR_imm1        +26
  $932B  B5                         MULT
  $932C  8C 07 70                   LOADR_imm2             $7007
  $932F  BB                         ADD
  $9330  B3                         PUSHL
  $9331  3C                         PUSH_quick   ; inline operand = 12
  $9332  8E EB FD                   PUSH_imm2              $FDEB (msg_you_have_no_rice)
  $9335  E9 01 93 06                CALL_abs_imm1          $9301 (war_prep_clamp_depleted_field_notify) {bytecode}, $06
  $9339  CF                         RETURN

; ============================================================
; sub $933A   (frame_off=+0, body @ $933F)
; ============================================================
  $933F  0C                         LOADL_quick   ; inline operand = 12
  $9340  8B 1A                      BYTE_LOADR_imm1        +26
  $9342  B5                         MULT
  $9343  8C 11 70                   LOADR_imm2             $7011
  $9346  BB                         ADD
  $9347  B3                         PUSHL
  $9348  3C                         PUSH_quick   ; inline operand = 12
  $9349  8E FD FD                   PUSH_imm2              $FDFD (msg_you_have_no_soldiers)
  $934C  E9 01 93 06                CALL_abs_imm1          $9301 (war_prep_clamp_depleted_field_notify) {bytecode}, $06
  $9350  CF                         RETURN

; ============================================================
; sub $9351   (frame_off=+0, body @ $9356)
; ============================================================
  $9356  0C                         LOADL_quick   ; inline operand = 12
  $9357  8B 1A                      BYTE_LOADR_imm1        +26
  $9359  B5                         MULT
  $935A  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $935D  BB                         ADD
  $935E  B3                         PUSHL
  $935F  3C                         PUSH_quick   ; inline operand = 12
  $9360  8E D9 FD                   PUSH_imm2              $FDD9 (msg_you_have_no_gold)
  $9363  E9 01 93 06                CALL_abs_imm1          $9301 (war_prep_clamp_depleted_field_notify) {bytecode}, $06
  $9367  CF                         RETURN

; ============================================================
; sub $9368   (frame_off=-2, body @ $936D)
; ============================================================
  $936D  3C                         PUSH_quick   ; inline operand = 12
  $936E  E9 72 D9 02                CALL_abs_imm1          $D972 (fief_owner_weakness) {bytecode}, $02
  $9372  2B                         STORE_quick   ; inline operand = 11
  $9373  D8 80 93                   JUMPF_abs              $9380
  $9376  8E D6 FA                   PUSH_imm2              $FAD6 (msg_lord_you_are_too_weak_for_batt)
  $9379  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $937D  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$9380  0B                         LOADL_quick   ; inline operand = 11
  $9381  CF                         RETURN

; ============================================================
; sub $9382   (frame_off=-2, body @ $9387)
; ============================================================
  $9387  0C                         LOADL_quick   ; inline operand = 12
  $9388  8B 1A                      BYTE_LOADR_imm1        +26
  $938A  B5                         MULT
  $938B  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $938E  BB                         ADD
  $938F  2B                         STORE_quick   ; inline operand = 11
  $9390  0B                         LOADL_quick   ; inline operand = 11
  $9391  76                         ADD_qimm   ; inline operand = 6
  $9392  B0                         DEREF
  $9393  D7 98 93                   JUMPT_abs              $9398
  $9396  40                         LOADL_qimm   ; inline operand = 0
  $9397  CF                         RETURN
 >$9398  0B                         LOADL_quick   ; inline operand = 11
  $9399  8F 10                      BYTE_ADD_imm1          +16
  $939B  B0                         DEREF
  $939C  CF                         RETURN

; ============================================================
; sub $939D   (frame_off=+0, body @ $93A2)
; ============================================================
  $93A2  3D                         PUSH_quick   ; inline operand = 13
  $93A3  E9 82 93 02                CALL_abs_imm1          $9382 (fief_men_if_provisioned) {bytecode}, $02
  $93A7  B3                         PUSHL
  $93A8  3C                         PUSH_quick   ; inline operand = 12
  $93A9  E9 82 93 02                CALL_abs_imm1          $9382 (fief_men_if_provisioned) {bytecode}, $02
  $93AD  B3                         PUSHL
  $93AE  E9 DE D6 04                CALL_abs_imm1          $D6DE (math32_2arg) {bytecode}, $04
  $93B2  CF                         RETURN

; ============================================================
; sub $93B3   (frame_off=-2, body @ $93B8)
; ============================================================
  $93B8  0C                         LOADL_quick   ; inline operand = 12
  $93B9  D3                         BYTE_DEREF
  $93BA  2B                         STORE_quick   ; inline operand = 11
  $93BB  D6 D2 93                   JUMP_abs               $93D2
 >$93BE  0C                         LOADL_quick   ; inline operand = 12
  $93BF  D3                         BYTE_DEREF
  $93C0  B3                         PUSHL
  $93C1  3B                         PUSH_quick   ; inline operand = 11
  $93C2  E9 9D 93 04                CALL_abs_imm1          $939D (fief_men_ratio_pct) {bytecode}, $04
  $93C6  8B 32                      BYTE_LOADR_imm1        +50
  $93C8  C8                         UCMPGT
  $93C9  D8 CF 93                   JUMPF_abs              $93CF
  $93CC  0C                         LOADL_quick   ; inline operand = 12
  $93CD  D3                         BYTE_DEREF
  $93CE  2B                         STORE_quick   ; inline operand = 11
 >$93CF  0C                         LOADL_quick   ; inline operand = 12
  $93D0  D0                         INC
  $93D1  2C                         STORE_quick   ; inline operand = 12
 >$93D2  0C                         LOADL_quick   ; inline operand = 12
  $93D3  D3                         BYTE_DEREF
  $93D4  8C FF 00                   LOADR_imm2             $00FF
  $93D7  C1                         CMPNE
  $93D8  D7 BE 93                   JUMPT_abs              $93BE
  $93DB  0B                         LOADL_quick   ; inline operand = 11
  $93DC  CF                         RETURN

; ============================================================
; sub $93DD   (frame_off=+0, body @ $93E2)
; ============================================================
  $93E2  8D 64                      BYTE_PUSH_imm1         +100
  $93E4  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $93E8  B3                         PUSHL
  $93E9  60                         PUSH_qimm   ; inline operand = 0
  $93EA  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $93ED  3C                         PUSH_quick   ; inline operand = 12
  $93EE  E9 50 82 06                CALL_abs_imm1          $8250 (relations_matrix_get) {bytecode}, $06
  $93F2  B4                         POPR
  $93F3  C8                         UCMPGT
  $93F4  D7 12 94                   JUMPT_abs              $9412
  $93F7  8D 64                      BYTE_PUSH_imm1         +100
  $93F9  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $93FD  B3                         PUSHL
  $93FE  61                         PUSH_qimm   ; inline operand = 1
  $93FF  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $9402  B3                         PUSHL
  $9403  3C                         PUSH_quick   ; inline operand = 12
  $9404  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $9408  B3                         PUSHL
  $9409  E9 50 82 06                CALL_abs_imm1          $8250 (relations_matrix_get) {bytecode}, $06
  $940D  B4                         POPR
  $940E  C8                         UCMPGT
  $940F  D8 1D 94                   JUMPF_abs              $941D
 >$9412  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $9415  72                         ADD_qimm   ; inline operand = 2
  $9416  D3                         BYTE_DEREF
  $9417  8B 32                      BYTE_LOADR_imm1        +50
  $9419  C2                         SCMPLT
  $941A  D7 21 94                   JUMPT_abs              $9421
 >$941D  40                         LOADL_qimm   ; inline operand = 0
  $941E  D6 22 94                   JUMP_abs               $9422
 >$9421  41                         LOADL_qimm   ; inline operand = 1
 >$9422  CF                         RETURN

; ============================================================
; sub $9423   (frame_off=-2, body @ $9428)
; ============================================================
  $9428  0C                         LOADL_quick   ; inline operand = 12
  $9429  D3                         BYTE_DEREF
  $942A  2B                         STORE_quick   ; inline operand = 11
  $942B  D6 52 94                   JUMP_abs               $9452
 >$942E  3B                         PUSH_quick   ; inline operand = 11
  $942F  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9433  D8 4F 94                   JUMPF_abs              $944F
  $9436  3B                         PUSH_quick   ; inline operand = 11
  $9437  E9 DD 93 02                CALL_abs_imm1          $93DD (ai_relations_and_low_drive_skip_gate) {bytecode}, $02
  $943B  D7 4F 94                   JUMPT_abs              $944F
  $943E  0C                         LOADL_quick   ; inline operand = 12
  $943F  D3                         BYTE_DEREF
  $9440  B3                         PUSHL
  $9441  3B                         PUSH_quick   ; inline operand = 11
  $9442  E9 9D 93 04                CALL_abs_imm1          $939D (fief_men_ratio_pct) {bytecode}, $04
  $9446  8B 32                      BYTE_LOADR_imm1        +50
  $9448  C8                         UCMPGT
  $9449  D8 4F 94                   JUMPF_abs              $944F
  $944C  0C                         LOADL_quick   ; inline operand = 12
  $944D  D3                         BYTE_DEREF
  $944E  2B                         STORE_quick   ; inline operand = 11
 >$944F  0C                         LOADL_quick   ; inline operand = 12
  $9450  D0                         INC
  $9451  2C                         STORE_quick   ; inline operand = 12
 >$9452  0C                         LOADL_quick   ; inline operand = 12
  $9453  D3                         BYTE_DEREF
  $9454  8C FF 00                   LOADR_imm2             $00FF
  $9457  C1                         CMPNE
  $9458  D7 2E 94                   JUMPT_abs              $942E
  $945B  0B                         LOADL_quick   ; inline operand = 11
  $945C  CF                         RETURN

; ============================================================
; sub $945D   (frame_off=-2, body @ $9462)
; ============================================================
  $9462  0D                         LOADL_quick   ; inline operand = 13
  $9463  8C FF 00                   LOADR_imm2             $00FF
  $9466  C1                         CMPNE
  $9467  D8 96 94                   JUMPF_abs              $9496
  $946A  0C                         LOADL_quick   ; inline operand = 12
  $946B  D3                         BYTE_DEREF
  $946C  2B                         STORE_quick   ; inline operand = 11
  $946D  D6 8D 94                   JUMP_abs               $948D
 >$9470  3B                         PUSH_quick   ; inline operand = 11
  $9471  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $9475  1D                         LOADR_quick   ; inline operand = 13
  $9476  C0                         CMPEQ
  $9477  D8 8A 94                   JUMPF_abs              $948A
  $947A  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $947D  3B                         PUSH_quick   ; inline operand = 11
  $947E  E9 9D 93 04                CALL_abs_imm1          $939D (fief_men_ratio_pct) {bytecode}, $04
  $9482  8B 32                      BYTE_LOADR_imm1        +50
  $9484  C9                         UCMPGE
  $9485  D8 96 94                   JUMPF_abs              $9496
  $9488  0B                         LOADL_quick   ; inline operand = 11
  $9489  CF                         RETURN
 >$948A  0C                         LOADL_quick   ; inline operand = 12
  $948B  D0                         INC
  $948C  2C                         STORE_quick   ; inline operand = 12
 >$948D  0C                         LOADL_quick   ; inline operand = 12
  $948E  D3                         BYTE_DEREF
  $948F  8C FF 00                   LOADR_imm2             $00FF
  $9492  C1                         CMPNE
  $9493  D7 70 94                   JUMPT_abs              $9470
 >$9496  8A FF 00                   LOADL_imm2             $00FF
  $9499  CF                         RETURN

; ============================================================
; sub $949A   (frame_off=-12, body @ $949F)
; ============================================================
  $949F  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $94A2  2B                         STORE_quick   ; inline operand = 11
  $94A3  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $94A6  8B 1A                      BYTE_LOADR_imm1        +26
  $94A8  B5                         MULT
  $94A9  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $94AC  BB                         ADD
  $94AD  27                         STORE_quick   ; inline operand = 7
  $94AE  3B                         PUSH_quick   ; inline operand = 11
  $94AF  E9 72 D9 02                CALL_abs_imm1          $D972 (fief_owner_weakness) {bytecode}, $02
  $94B3  D7 C3 94                   JUMPT_abs              $94C3
  $94B6  07                         LOADL_quick   ; inline operand = 7
  $94B7  8F 10                      BYTE_ADD_imm1          +16
  $94B9  B0                         DEREF
  $94BA  D8 C3 94                   JUMPF_abs              $94C3
  $94BD  07                         LOADL_quick   ; inline operand = 7
  $94BE  76                         ADD_qimm   ; inline operand = 6
  $94BF  B0                         DEREF
  $94C0  D7 C5 94                   JUMPT_abs              $94C5
 >$94C3  40                         LOADL_qimm   ; inline operand = 0
  $94C4  CF                         RETURN
 >$94C5  AC D7 DA                   CALL_abs               $DAD7 (compact_relation_list) {bytecode}
  $94C8  8E 4F 6F                   PUSH_imm2              $6F4F (deduped_owner_list)
  $94CB  60                         PUSH_qimm   ; inline operand = 0
  $94CC  E9 3A DD 04                CALL_abs_imm1          $DD3A (filter_province_list_by_owner) {bytecode}, $04
  $94D0  8E 4F 6F                   PUSH_imm2              $6F4F (deduped_owner_list)
  $94D3  E9 B3 93 02                CALL_abs_imm1          $93B3 (pick_weakest_men_fief) {bytecode}, $02
  $94D7  2A                         STORE_quick   ; inline operand = 10
  $94D8  0A                         LOADL_quick   ; inline operand = 10
  $94D9  8C FF 00                   LOADR_imm2             $00FF
  $94DC  C0                         CMPEQ
  $94DD  D8 E2 94                   JUMPF_abs              $94E2
  $94E0  40                         LOADL_qimm   ; inline operand = 0
  $94E1  CF                         RETURN
 >$94E2  8E 4F 6F                   PUSH_imm2              $6F4F (deduped_owner_list)
  $94E5  E9 23 94 02                CALL_abs_imm1          $9423 (pick_ai_attack_target_fief) {bytecode}, $02
  $94E9  29                         STORE_quick   ; inline operand = 9
  $94EA  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $94ED  8C 7F 6E                   LOADR_imm2             $6E7F
  $94F0  BB                         ADD
  $94F1  D3                         BYTE_DEREF
  $94F2  B3                         PUSHL
  $94F3  8E 4F 6F                   PUSH_imm2              $6F4F (deduped_owner_list)
  $94F6  E9 5D 94 04                CALL_abs_imm1          $945D (find_fief_by_owner_men_minority) {bytecode}, $04
  $94FA  28                         STORE_quick   ; inline operand = 8
  $94FB  08                         LOADL_quick   ; inline operand = 8
  $94FC  8C FF 00                   LOADR_imm2             $00FF
  $94FF  C1                         CMPNE
  $9500  D8 05 95                   JUMPF_abs              $9505
  $9503  08                         LOADL_quick   ; inline operand = 8
  $9504  2A                         STORE_quick   ; inline operand = 10
 >$9505  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $9508  53                         LOADR_qimm   ; inline operand = 3
  $9509  B5                         MULT
  $950A  B3                         PUSHL
  $950B  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $950F  B3                         PUSHL
  $9510  3A                         PUSH_quick   ; inline operand = 10
  $9511  3B                         PUSH_quick   ; inline operand = 11
  $9512  E9 9D 93 04                CALL_abs_imm1          $939D (fief_men_ratio_pct) {bytecode}, $04
  $9516  8F F6                      BYTE_ADD_imm1          -10
  $9518  B4                         POPR
  $9519  BC                         SUB
  $951A  8B 3C                      BYTE_LOADR_imm1        +60
  $951C  C8                         UCMPGT
  $951D  D7 2D 95                   JUMPT_abs              $952D
  $9520  8D 64                      BYTE_PUSH_imm1         +100
  $9522  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9526  D8 2D 95                   JUMPF_abs              $952D
  $9529  40                         LOADL_qimm   ; inline operand = 0
  $952A  D6 2E 95                   JUMP_abs               $952E
 >$952D  41                         LOADL_qimm   ; inline operand = 1
 >$952E  26                         STORE_quick   ; inline operand = 6
  $952F  39                         PUSH_quick   ; inline operand = 9
  $9530  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9534  D8 47 95                   JUMPF_abs              $9547
  $9537  39                         PUSH_quick   ; inline operand = 9
  $9538  3B                         PUSH_quick   ; inline operand = 11
  $9539  E9 9D 93 04                CALL_abs_imm1          $939D (fief_men_ratio_pct) {bytecode}, $04
  $953D  8B 2F                      BYTE_LOADR_imm1        +47
  $953F  C8                         UCMPGT
  $9540  D8 47 95                   JUMPF_abs              $9547
  $9543  41                         LOADL_qimm   ; inline operand = 1
  $9544  26                         STORE_quick   ; inline operand = 6
  $9545  09                         LOADL_quick   ; inline operand = 9
  $9546  2A                         STORE_quick   ; inline operand = 10
 >$9547  0A                         LOADL_quick   ; inline operand = 10
  $9548  8B 1E                      BYTE_LOADR_imm1        +30
  $954A  C0                         CMPEQ
  $954B  D8 61 95                   JUMPF_abs              $9561
  $954E  8D 50                      BYTE_PUSH_imm1         +80
  $9550  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9554  8F 5A                      BYTE_ADD_imm1          +90
  $9556  B3                         PUSHL
  $9557  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $955A  72                         ADD_qimm   ; inline operand = 2
  $955B  D3                         BYTE_DEREF
  $955C  B4                         POPR
  $955D  C2                         SCMPLT
  $955E  D7 84 95                   JUMPT_abs              $9584
 >$9561  3A                         PUSH_quick   ; inline operand = 10
  $9562  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $9566  D7 71 95                   JUMPT_abs              $9571
  $9569  62                         PUSH_qimm   ; inline operand = 2
  $956A  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $956E  D8 84 95                   JUMPF_abs              $9584
 >$9571  06                         LOADL_quick   ; inline operand = 6
  $9572  D8 84 95                   JUMPF_abs              $9584
  $9575  0A                         LOADL_quick   ; inline operand = 10
  $9576  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $9579  AC 46 90                   CALL_abs               $9046 (ai_commit_attack_deduct_resources) {bytecode}
  $957C  D8 84 95                   JUMPF_abs              $9584
  $957F  AC FC 81                   CALL_abs               $81FC (effect_war_a) {bytecode}
  $9582  42                         LOADL_qimm   ; inline operand = 2
  $9583  CF                         RETURN
 >$9584  40                         LOADL_qimm   ; inline operand = 0
  $9585  CF                         RETURN

; ============================================================
; sub $9586   (frame_off=-4, body @ $958B)
; ============================================================
  $958B  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $958E  2A                         STORE_quick   ; inline operand = 10
  $958F  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9592  8B 1A                      BYTE_LOADR_imm1        +26
  $9594  B5                         MULT
  $9595  8C 15 70                   LOADR_imm2             $7015
  $9598  BB                         ADD
  $9599  2B                         STORE_quick   ; inline operand = 11
  $959A  8D 14                      BYTE_PUSH_imm1         +20
  $959C  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $95A0  7A                         ADD_qimm   ; inline operand = 10
  $95A1  D2                         LSHIFT1
  $95A2  D2                         LSHIFT1
  $95A3  B3                         PUSHL
  $95A4  0B                         LOADL_quick   ; inline operand = 11
  $95A5  B4                         POPR
  $95A6  B3                         PUSHL
  $95A7  B0                         DEREF
  $95A8  BB                         ADD
  $95A9  B1                         POPSTORE
  $95AA  6A                         PUSH_qimm   ; inline operand = 10
  $95AB  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $95AF  8F 5A                      BYTE_ADD_imm1          +90
  $95B1  B3                         PUSHL
  $95B2  0A                         LOADL_quick   ; inline operand = 10
  $95B3  73                         ADD_qimm   ; inline operand = 3
  $95B4  D3                         BYTE_DEREF
  $95B5  B3                         PUSHL
  $95B6  0A                         LOADL_quick   ; inline operand = 10
  $95B7  75                         ADD_qimm   ; inline operand = 5
  $95B8  D3                         BYTE_DEREF
  $95B9  B4                         POPR
  $95BA  BB                         ADD
  $95BB  B4                         POPR
  $95BC  C4                         SCMPGT
  $95BD  D8 C7 95                   JUMPF_abs              $95C7
  $95C0  6A                         PUSH_qimm   ; inline operand = 10
  $95C1  0B                         LOADL_quick   ; inline operand = 11
  $95C2  B4                         POPR
  $95C3  B3                         PUSHL
  $95C4  B0                         DEREF
  $95C5  BB                         ADD
  $95C6  B1                         POPSTORE
 >$95C7  4B                         LOADL_qimm   ; inline operand = 11
  $95C8  CF                         RETURN

; ============================================================
; sub $95C9   (frame_off=-4, body @ $95CE)
; ============================================================
  $95CE  62                         PUSH_qimm   ; inline operand = 2
  $95CF  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $95D3  D7 DE 95                   JUMPT_abs              $95DE
  $95D6  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $95D9  74                         ADD_qimm   ; inline operand = 4
  $95DA  B3                         PUSHL
  $95DB  D3                         BYTE_DEREF
  $95DC  D0                         INC
  $95DD  D4                         BYTE_POPSTORE
 >$95DE  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $95E1  8B 1A                      BYTE_LOADR_imm1        +26
  $95E3  B5                         MULT
  $95E4  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $95E7  BB                         ADD
  $95E8  2B                         STORE_quick   ; inline operand = 11
  $95E9  40                         LOADL_qimm   ; inline operand = 0
  $95EA  2A                         STORE_quick   ; inline operand = 10
  $95EB  0B                         LOADL_quick   ; inline operand = 11
  $95EC  8F 10                      BYTE_ADD_imm1          +16
  $95EE  B0                         DEREF
  $95EF  B3                         PUSHL
  $95F0  0B                         LOADL_quick   ; inline operand = 11
  $95F1  B0                         DEREF
  $95F2  B4                         POPR
  $95F3  BC                         SUB
  $95F4  51                         LOADR_qimm   ; inline operand = 1
  $95F5  C5                         SCMPGE
  $95F6  D8 0A 96                   JUMPF_abs              $960A
  $95F9  0B                         LOADL_quick   ; inline operand = 11
  $95FA  8F 10                      BYTE_ADD_imm1          +16
  $95FC  B0                         DEREF
  $95FD  B3                         PUSHL
  $95FE  0B                         LOADL_quick   ; inline operand = 11
  $95FF  B0                         DEREF
  $9600  B4                         POPR
  $9601  BC                         SUB
  $9602  B3                         PUSHL
  $9603  3B                         PUSH_quick   ; inline operand = 11
  $9604  E9 79 83 04                CALL_abs_imm1          $8379 (apply_two_grows_const1_override) {bytecode}, $04
  $9608  4E                         LOADL_qimm   ; inline operand = 14
  $9609  2A                         STORE_quick   ; inline operand = 10
 >$960A  0A                         LOADL_quick   ; inline operand = 10
  $960B  CF                         RETURN

; ============================================================
; sub $960C   (frame_off=-9, body @ $9611)
; ============================================================
  $9611  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $9614  D0                         INC
  $9615  B3                         PUSHL
  $9616  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $961A  B3                         PUSHL
  $961B  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $961E  72                         ADD_qimm   ; inline operand = 2
  $961F  B4                         POPR
  $9620  B3                         PUSHL
  $9621  D3                         BYTE_DEREF
  $9622  BB                         ADD
  $9623  D4                         BYTE_POPSTORE
  $9624  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9627  8B 1A                      BYTE_LOADR_imm1        +26
  $9629  B5                         MULT
  $962A  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $962D  BB                         ADD
  $962E  85 F7                      STORE_near             $F7
  $9630  8F 10                      BYTE_ADD_imm1          +16
  $9632  B0                         DEREF
  $9633  58                         LOADR_qimm   ; inline operand = 8
  $9634  C4                         SCMPGT
  $9635  D8 93 96                   JUMPF_abs              $9693
  $9638  89 32                      BYTE_LOADL_imm1        +50
  $963A  A2 FB FF                   BYTE_STORE_far         $FFFB
  $963D  41                         LOADL_qimm   ; inline operand = 1
  $963E  85 F9                      STORE_near             $F9
 >$9640  DE FB FF                   LEAL_far               $FFFB
  $9643  B3                         PUSHL
  $9644  81 F9                      LOADL_near             $F9
  $9646  B4                         POPR
  $9647  BB                         ADD
  $9648  B3                         PUSHL
  $9649  45                         LOADL_qimm   ; inline operand = 5
  $964A  D4                         BYTE_POPSTORE
  $964B  81 F9                      LOADL_near             $F9
  $964D  D0                         INC
  $964E  85 F9                      STORE_near             $F9
  $9650  81 F9                      LOADL_near             $F9
  $9652  55                         LOADR_qimm   ; inline operand = 5
  $9653  C6                         UCMPLT
  $9654  D7 40 96                   JUMPT_abs              $9640
  $9657  40                         LOADL_qimm   ; inline operand = 0
  $9658  85 F9                      STORE_near             $F9
 >$965A  65                         PUSH_qimm   ; inline operand = 5
  $965B  DE FB FF                   LEAL_far               $FFFB
  $965E  B3                         PUSHL
  $965F  65                         PUSH_qimm   ; inline operand = 5
  $9660  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9664  B4                         POPR
  $9665  BB                         ADD
  $9666  B4                         POPR
  $9667  B3                         PUSHL
  $9668  D3                         BYTE_DEREF
  $9669  BB                         ADD
  $966A  D4                         BYTE_POPSTORE
  $966B  81 F9                      LOADL_near             $F9
  $966D  D0                         INC
  $966E  85 F9                      STORE_near             $F9
  $9670  81 F9                      LOADL_near             $F9
  $9672  55                         LOADR_qimm   ; inline operand = 5
  $9673  C6                         UCMPLT
  $9674  D7 5A 96                   JUMPT_abs              $965A
  $9677  65                         PUSH_qimm   ; inline operand = 5
  $9678  DE FC FF                   LEAL_far               $FFFC
  $967B  B3                         PUSHL
  $967C  62                         PUSH_qimm   ; inline operand = 2
  $967D  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9681  B4                         POPR
  $9682  BB                         ADD
  $9683  B4                         POPR
  $9684  B3                         PUSHL
  $9685  D3                         BYTE_DEREF
  $9686  BB                         ADD
  $9687  D4                         BYTE_POPSTORE
  $9688  DE FB FF                   LEAL_far               $FFFB
  $968B  B3                         PUSHL
  $968C  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $968F  E9 AF E2 04                CALL_abs_imm1          $E2AF (copy_arms_record_5) {bytecode}, $04
 >$9693  6A                         PUSH_qimm   ; inline operand = 10
  $9694  81 F7                      LOADL_near             $F7
  $9696  B0                         DEREF
  $9697  D0                         INC
  $9698  B3                         PUSHL
  $9699  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $969D  B3                         PUSHL
  $969E  81 F7                      LOADL_near             $F7
  $96A0  B4                         POPR
  $96A1  B3                         PUSHL
  $96A2  B0                         DEREF
  $96A3  BB                         ADD
  $96A4  B1                         POPSTORE
  $96A5  6A                         PUSH_qimm   ; inline operand = 10
  $96A6  81 F7                      LOADL_near             $F7
  $96A8  76                         ADD_qimm   ; inline operand = 6
  $96A9  B0                         DEREF
  $96AA  D0                         INC
  $96AB  B3                         PUSHL
  $96AC  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $96B0  B3                         PUSHL
  $96B1  81 F7                      LOADL_near             $F7
  $96B3  76                         ADD_qimm   ; inline operand = 6
  $96B4  B4                         POPR
  $96B5  B3                         PUSHL
  $96B6  B0                         DEREF
  $96B7  BB                         ADD
  $96B8  B1                         POPSTORE
  $96B9  6A                         PUSH_qimm   ; inline operand = 10
  $96BA  81 F7                      LOADL_near             $F7
  $96BC  8F 10                      BYTE_ADD_imm1          +16
  $96BE  B0                         DEREF
  $96BF  D0                         INC
  $96C0  B3                         PUSHL
  $96C1  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $96C5  B3                         PUSHL
  $96C6  81 F7                      LOADL_near             $F7
  $96C8  8F 10                      BYTE_ADD_imm1          +16
  $96CA  B4                         POPR
  $96CB  B3                         PUSHL
  $96CC  B0                         DEREF
  $96CD  BB                         ADD
  $96CE  B1                         POPSTORE
  $96CF  40                         LOADL_qimm   ; inline operand = 0
  $96D0  CF                         RETURN

; ============================================================
; sub $96D1   (frame_off=-8, body @ $96D6)
; ============================================================
  $96D6  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $96D9  E9 3A 93 02                CALL_abs_imm1          $933A (effect_war_combat_prep_b) {bytecode}, $02
  $96DD  D7 E2 96                   JUMPT_abs              $96E2
  $96E0  40                         LOADL_qimm   ; inline operand = 0
  $96E1  CF                         RETURN
 >$96E2  AC D7 DA                   CALL_abs               $DAD7 (compact_relation_list) {bytecode}
  $96E5  8E 4F 6F                   PUSH_imm2              $6F4F (deduped_owner_list)
  $96E8  61                         PUSH_qimm   ; inline operand = 1
  $96E9  E9 3A DD 04                CALL_abs_imm1          $DD3A (filter_province_list_by_owner) {bytecode}, $04
  $96ED  8E 4F 6F                   PUSH_imm2              $6F4F (deduped_owner_list)
  $96F0  61                         PUSH_qimm   ; inline operand = 1
  $96F1  E9 9F 87 04                CALL_abs_imm1          $879F (province_select_helper) {bytecode}, $04
  $96F5  D8 BF 97                   JUMPF_abs              $97BF
  $96F8  8E CD F9                   PUSH_imm2              $F9CD (msg_move_where)
  $96FB  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $96FF  8E 4F 6F                   PUSH_imm2              $6F4F (deduped_owner_list)
  $9702  E9 4C 80 02                CALL_abs_imm1          $804C (province_select_prompt) {bytecode}, $02
  $9706  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $9709  D8 BF 97                   JUMPF_abs              $97BF
  $970C  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $970F  D1                         DEC
  $9710  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $9713  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $9716  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9719  8B 1A                      BYTE_LOADR_imm1        +26
  $971B  B5                         MULT
  $971C  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $971F  BB                         ADD
  $9720  29                         STORE_quick   ; inline operand = 9
  $9721  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9724  8B 1A                      BYTE_LOADR_imm1        +26
  $9726  B5                         MULT
  $9727  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $972A  BB                         ADD
  $972B  28                         STORE_quick   ; inline operand = 8
  $972C  09                         LOADL_quick   ; inline operand = 9
  $972D  8F 10                      BYTE_ADD_imm1          +16
  $972F  B0                         DEREF
  $9730  B3                         PUSHL
  $9731  09                         LOADL_quick   ; inline operand = 9
  $9732  8F 18                      BYTE_ADD_imm1          +24
  $9734  B0                         DEREF
  $9735  B4                         POPR
  $9736  BC                         SUB
  $9737  B3                         PUSHL
  $9738  08                         LOADL_quick   ; inline operand = 8
  $9739  8F 10                      BYTE_ADD_imm1          +16
  $973B  B0                         DEREF
  $973C  B3                         PUSHL
  $973D  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $9741  2A                         STORE_quick   ; inline operand = 10
  $9742  0A                         LOADL_quick   ; inline operand = 10
  $9743  D8 B5 97                   JUMPF_abs              $97B5
  $9746  8E DB F9                   PUSH_imm2              $F9DB (msg_how_many_men)
  $9749  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $974D  3A                         PUSH_quick   ; inline operand = 10
  $974E  61                         PUSH_qimm   ; inline operand = 1
  $974F  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $9753  2B                         STORE_quick   ; inline operand = 11
  $9754  D8 BF 97                   JUMPF_abs              $97BF
  $9757  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $975A  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $975D  BB                         ADD
  $975E  D3                         BYTE_DEREF
  $975F  D8 97 97                   JUMPF_abs              $9797
  $9762  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $9765  E9 68 93 02                CALL_abs_imm1          $9368 (effect_war_combat_prep_d) {bytecode}, $02
  $9769  D7 97 97                   JUMPT_abs              $9797
  $976C  8E E8 F9                   PUSH_imm2              $F9E8 (msg_will_you_lead_them_personally)
  $976F  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9773  AC A7 D3                   CALL_abs               $D3A7 (prompt_y_n) {bytecode}
  $9776  D8 97 97                   JUMPF_abs              $9797
  $9779  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $977C  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $977F  BB                         ADD
  $9780  B3                         PUSHL
  $9781  40                         LOADL_qimm   ; inline operand = 0
  $9782  D4                         BYTE_POPSTORE
  $9783  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9786  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $9789  BB                         ADD
  $978A  B3                         PUSHL
  $978B  41                         LOADL_qimm   ; inline operand = 1
  $978C  D4                         BYTE_POPSTORE
  $978D  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9790  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $9793  BB                         ADD
  $9794  B3                         PUSHL
  $9795  45                         LOADL_qimm   ; inline operand = 5
  $9796  D4                         BYTE_POPSTORE
 >$9797  68                         PUSH_qimm   ; inline operand = 8
  $9798  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $979C  8E 06 FA                   PUSH_imm2              $FA06 (msg_they_have_arrived_safely)
  $979F  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $97A3  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $97A6  3B                         PUSH_quick   ; inline operand = 11
  $97A7  E9 A5 8C 02                CALL_abs_imm1          $8CA5 (effect_move) {bytecode}, $02
  $97AB  39                         PUSH_quick   ; inline operand = 9
  $97AC  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $97AF  E9 FE DF 04                CALL_abs_imm1          $DFFE (cap_arms_at_index) {bytecode}, $04
  $97B3  41                         LOADL_qimm   ; inline operand = 1
  $97B4  CF                         RETURN
 >$97B5  8E C4 BB                   PUSH_imm2              $BBC4 (msg_that_fief_can_t_hold_more_men)
  $97B8  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $97BC  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$97BF  40                         LOADL_qimm   ; inline operand = 0
  $97C0  CF                         RETURN

; ============================================================
; sub $97C1   (frame_off=-2, body @ $97C6)
; ============================================================
  $97C6  8A 4F 6F                   LOADL_imm2             $6F4F (deduped_owner_list)
  $97C9  2B                         STORE_quick   ; inline operand = 11
  $97CA  D6 E0 97                   JUMP_abs               $97E0
 >$97CD  0B                         LOADL_quick   ; inline operand = 11
  $97CE  D3                         BYTE_DEREF
  $97CF  1C                         LOADR_quick   ; inline operand = 12
  $97D0  C0                         CMPEQ
  $97D1  D8 D7 97                   JUMPF_abs              $97D7
  $97D4  0D                         LOADL_quick   ; inline operand = 13
  $97D5  B0                         DEREF
  $97D6  CF                         RETURN
 >$97D7  0B                         LOADL_quick   ; inline operand = 11
  $97D8  D0                         INC
  $97D9  2B                         STORE_quick   ; inline operand = 11
  $97DA  D1                         DEC
  $97DB  0D                         LOADL_quick   ; inline operand = 13
  $97DC  72                         ADD_qimm   ; inline operand = 2
  $97DD  2D                         STORE_quick   ; inline operand = 13
  $97DE  8F FE                      BYTE_ADD_imm1          -2
 >$97E0  0B                         LOADL_quick   ; inline operand = 11
  $97E1  D3                         BYTE_DEREF
  $97E2  8C FF 00                   LOADR_imm2             $00FF
  $97E5  C1                         CMPNE
  $97E6  D7 CD 97                   JUMPT_abs              $97CD
  $97E9  CF                         RETURN

; ============================================================
; sub $97EA   (frame_off=+0, body @ $97EF)
; ============================================================
  $97EF  8D 64                      BYTE_PUSH_imm1         +100
  $97F1  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $97F5  B3                         PUSHL
  $97F6  0D                         LOADL_quick   ; inline operand = 13
  $97F7  D8 08 98                   JUMPF_abs              $9808
  $97FA  61                         PUSH_qimm   ; inline operand = 1
  $97FB  3C                         PUSH_quick   ; inline operand = 12
  $97FC  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $9800  B3                         PUSHL
  $9801  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $9804  B3                         PUSHL
  $9805  D6 0D 98                   JUMP_abs               $980D
 >$9808  3D                         PUSH_quick   ; inline operand = 13
  $9809  3C                         PUSH_quick   ; inline operand = 12
  $980A  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
 >$980D  E9 50 82 06                CALL_abs_imm1          $8250 (relations_matrix_get) {bytecode}, $06
  $9811  B4                         POPR
  $9812  C8                         UCMPGT
  $9813  CF                         RETURN

; ============================================================
; sub $9814   (frame_off=-2, body @ $9819)
; ============================================================
  $9819  8A 4F 6F                   LOADL_imm2             $6F4F (deduped_owner_list)
  $981C  2B                         STORE_quick   ; inline operand = 11
  $981D  D6 46 98                   JUMP_abs               $9846
 >$9820  3C                         PUSH_quick   ; inline operand = 12
  $9821  61                         PUSH_qimm   ; inline operand = 1
  $9822  0B                         LOADL_quick   ; inline operand = 11
  $9823  D3                         BYTE_DEREF
  $9824  B3                         PUSHL
  $9825  E9 EA 97 04                CALL_abs_imm1          $97EA (relations_roll_vs_owner) {bytecode}, $04
  $9829  D7 3B 98                   JUMPT_abs              $983B
  $982C  60                         PUSH_qimm   ; inline operand = 0
  $982D  0B                         LOADL_quick   ; inline operand = 11
  $982E  D3                         BYTE_DEREF
  $982F  B3                         PUSHL
  $9830  E9 EA 97 04                CALL_abs_imm1          $97EA (relations_roll_vs_owner) {bytecode}, $04
  $9834  D7 3B 98                   JUMPT_abs              $983B
  $9837  40                         LOADL_qimm   ; inline operand = 0
  $9838  D6 3C 98                   JUMP_abs               $983C
 >$983B  41                         LOADL_qimm   ; inline operand = 1
 >$983C  B1                         POPSTORE
  $983D  0B                         LOADL_quick   ; inline operand = 11
  $983E  D0                         INC
  $983F  2B                         STORE_quick   ; inline operand = 11
  $9840  D1                         DEC
  $9841  0C                         LOADL_quick   ; inline operand = 12
  $9842  72                         ADD_qimm   ; inline operand = 2
  $9843  2C                         STORE_quick   ; inline operand = 12
  $9844  8F FE                      BYTE_ADD_imm1          -2
 >$9846  0B                         LOADL_quick   ; inline operand = 11
  $9847  D3                         BYTE_DEREF
  $9848  8C FF 00                   LOADR_imm2             $00FF
  $984B  C1                         CMPNE
  $984C  D7 20 98                   JUMPT_abs              $9820
  $984F  CF                         RETURN

; ============================================================
; sub $9850   (frame_off=-22, body @ $9855)
; ============================================================
  $9855  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9858  29                         STORE_quick   ; inline operand = 9
  $9859  09                         LOADL_quick   ; inline operand = 9
  $985A  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $985D  BB                         ADD
  $985E  D3                         BYTE_DEREF
  $985F  D8 6C 98                   JUMPF_abs              $986C
  $9862  39                         PUSH_quick   ; inline operand = 9
  $9863  E9 68 93 02                CALL_abs_imm1          $9368 (effect_war_combat_prep_d) {bytecode}, $02
  $9867  D8 6C 98                   JUMPF_abs              $986C
  $986A  40                         LOADL_qimm   ; inline operand = 0
  $986B  CF                         RETURN
 >$986C  39                         PUSH_quick   ; inline operand = 9
  $986D  E9 51 93 02                CALL_abs_imm1          $9351 (effect_war_combat_prep_c) {bytecode}, $02
  $9871  D8 98 99                   JUMPF_abs              $9998
  $9874  39                         PUSH_quick   ; inline operand = 9
  $9875  E9 23 93 02                CALL_abs_imm1          $9323 (effect_war_combat_prep_a) {bytecode}, $02
  $9879  D8 98 99                   JUMPF_abs              $9998
  $987C  39                         PUSH_quick   ; inline operand = 9
  $987D  E9 3A 93 02                CALL_abs_imm1          $933A (effect_war_combat_prep_b) {bytecode}, $02
  $9881  D8 98 99                   JUMPF_abs              $9998
  $9884  AC D7 DA                   CALL_abs               $DAD7 (compact_relation_list) {bytecode}
  $9887  8E 4F 6F                   PUSH_imm2              $6F4F (deduped_owner_list)
  $988A  60                         PUSH_qimm   ; inline operand = 0
  $988B  E9 3A DD 04                CALL_abs_imm1          $DD3A (filter_province_list_by_owner) {bytecode}, $04
  $988F  DE EA FF                   LEAL_far               $FFEA
  $9892  B3                         PUSHL
  $9893  E9 14 98 02                CALL_abs_imm1          $9814 (effect_war_e) {bytecode}, $02
  $9897  8E 4F 6F                   PUSH_imm2              $6F4F (deduped_owner_list)
  $989A  62                         PUSH_qimm   ; inline operand = 2
  $989B  E9 9F 87 04                CALL_abs_imm1          $879F (province_select_helper) {bytecode}, $04
  $989F  D8 98 99                   JUMPF_abs              $9998
  $98A2  8E 1F FA                   PUSH_imm2              $FA1F (msg_attack_where)
  $98A5  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $98A9  8E 4F 6F                   PUSH_imm2              $6F4F (deduped_owner_list)
  $98AC  E9 4C 80 02                CALL_abs_imm1          $804C (province_select_prompt) {bytecode}, $02
  $98B0  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $98B3  D8 98 99                   JUMPF_abs              $9998
  $98B6  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $98B9  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $98BC  D1                         DEC
  $98BD  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $98C0  DE EA FF                   LEAL_far               $FFEA
  $98C3  B3                         PUSHL
  $98C4  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $98C7  E9 C1 97 04                CALL_abs_imm1          $97C1 (fief_list_parallel_lookup) {bytecode}, $04
  $98CB  D8 DA 98                   JUMPF_abs              $98DA
  $98CE  8E 29 FE                   PUSH_imm2              $FE29 (msg_they_are_your_allies)
  $98D1  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $98D5  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $98D8  41                         LOADL_qimm   ; inline operand = 1
  $98D9  CF                         RETURN
 >$98DA  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $98DD  8B 1A                      BYTE_LOADR_imm1        +26
  $98DF  B5                         MULT
  $98E0  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $98E3  BB                         ADD
  $98E4  2B                         STORE_quick   ; inline operand = 11
  $98E5  0B                         LOADL_quick   ; inline operand = 11
  $98E6  B0                         DEREF
  $98E7  B3                         PUSHL
  $98E8  0B                         LOADL_quick   ; inline operand = 11
  $98E9  8F 10                      BYTE_ADD_imm1          +16
  $98EB  B0                         DEREF
  $98EC  B3                         PUSHL
  $98ED  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $98F1  2A                         STORE_quick   ; inline operand = 10
  $98F2  39                         PUSH_quick   ; inline operand = 9
  $98F3  E9 72 D9 02                CALL_abs_imm1          $D972 (fief_owner_weakness) {bytecode}, $02
  $98F7  D8 06 99                   JUMPF_abs              $9906
  $98FA  44                         LOADL_qimm   ; inline operand = 4
  $98FB  CD                         SWAP
  $98FC  0A                         LOADL_quick   ; inline operand = 10
  $98FD  B6                         SDIV
  $98FE  2A                         STORE_quick   ; inline operand = 10
  $98FF  0A                         LOADL_quick   ; inline operand = 10
  $9900  D7 06 99                   JUMPT_abs              $9906
  $9903  0A                         LOADL_quick   ; inline operand = 10
  $9904  D0                         INC
  $9905  2A                         STORE_quick   ; inline operand = 10
 >$9906  8E 2F FA                   PUSH_imm2              $FA2F (msg_how_many_men_fa2f)
  $9909  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $990D  3A                         PUSH_quick   ; inline operand = 10
  $990E  61                         PUSH_qimm   ; inline operand = 1
  $990F  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $9913  A8 81 6F                   STORE_abs              $6F81 (war_attacker_men)
  $9916  D8 98 99                   JUMPF_abs              $9998
  $9919  8E 3C FA                   PUSH_imm2              $FA3C (msg_how_much_rice_will_they_take)
  $991C  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9920  AA 81 6F                   PUSH_abs               $6F81 (war_attacker_men)
  $9923  0B                         LOADL_quick   ; inline operand = 11
  $9924  76                         ADD_qimm   ; inline operand = 6
  $9925  B0                         DEREF
  $9926  B3                         PUSHL
  $9927  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $992B  B3                         PUSHL
  $992C  61                         PUSH_qimm   ; inline operand = 1
  $992D  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $9931  A8 7F 6F                   STORE_abs              $6F7F (war_attacker_rice)
  $9934  D8 98 99                   JUMPF_abs              $9998
  $9937  40                         LOADL_qimm   ; inline operand = 0
  $9938  A9 65 6F                   BYTE_STORE_abs         $6F65 (war_side_state_flag)
  $993B  09                         LOADL_quick   ; inline operand = 9
  $993C  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $993F  BB                         ADD
  $9940  D3                         BYTE_DEREF
  $9941  D8 59 99                   JUMPF_abs              $9959
  $9944  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $9947  8E 59 FA                   PUSH_imm2              $FA59 (msg_will_you_lead_them_personally_fa59)
  $994A  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $994E  AC A7 D3                   CALL_abs               $D3A7 (prompt_y_n) {bytecode}
  $9951  D8 59 99                   JUMPF_abs              $9959
  $9954  89 80                      BYTE_LOADL_imm1        -128
  $9956  A9 65 6F                   BYTE_STORE_abs         $6F65 (war_side_state_flag)
 >$9959  A4 81 6F                   LOADL_abs              $6F81 (war_attacker_men)
  $995C  A8 7D 6F                   STORE_abs              $6F7D (war_attacker_gold)
  $995F  AA 7D 6F                   PUSH_abs               $6F7D (war_attacker_gold)
  $9962  0B                         LOADL_quick   ; inline operand = 11
  $9963  B4                         POPR
  $9964  B3                         PUSHL
  $9965  B0                         DEREF
  $9966  BC                         SUB
  $9967  B1                         POPSTORE
  $9968  AA 7F 6F                   PUSH_abs               $6F7F (war_attacker_rice)
  $996B  0B                         LOADL_quick   ; inline operand = 11
  $996C  76                         ADD_qimm   ; inline operand = 6
  $996D  B4                         POPR
  $996E  B3                         PUSHL
  $996F  B0                         DEREF
  $9970  BC                         SUB
  $9971  B1                         POPSTORE
  $9972  AA 81 6F                   PUSH_abs               $6F81 (war_attacker_men)
  $9975  0B                         LOADL_quick   ; inline operand = 11
  $9976  8F 10                      BYTE_ADD_imm1          +16
  $9978  B4                         POPR
  $9979  B3                         PUSHL
  $997A  B0                         DEREF
  $997B  BC                         SUB
  $997C  B1                         POPSTORE
  $997D  41                         LOADL_qimm   ; inline operand = 1
  $997E  A8 79 6F                   STORE_abs              $6F79 (ai_turn_loop_redispatch_flag)
  $9981  89 8F                      BYTE_LOADL_imm1        -113
  $9983  CD                         SWAP
  $9984  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $9987  DA                         AND
  $9988  A9 A1 6D                   BYTE_STORE_abs         $6DA1 (ai_turn_flags)
  $998B  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $998E  6D                         PUSH_qimm   ; inline operand = 13
  $998F  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $9993  AC FC 81                   CALL_abs               $81FC (effect_war_a) {bytecode}
  $9996  41                         LOADL_qimm   ; inline operand = 1
  $9997  CF                         RETURN
 >$9998  40                         LOADL_qimm   ; inline operand = 0
  $9999  CF                         RETURN

; ============================================================
; sub $999A   (frame_off=-14, body @ $999F)
; ============================================================
  $999F  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $99A2  8C 2D 6D                   LOADR_imm2             $6D2D (fief_tax_rate)
  $99A5  BB                         ADD
  $99A6  26                         STORE_quick   ; inline operand = 6
  $99A7  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $99AA  8B 1A                      BYTE_LOADR_imm1        +26
  $99AC  B5                         MULT
  $99AD  8C 0D 70                   LOADR_imm2             $700D
  $99B0  BB                         ADD
  $99B1  2B                         STORE_quick   ; inline operand = 11
  $99B2  0B                         LOADL_quick   ; inline operand = 11
  $99B3  72                         ADD_qimm   ; inline operand = 2
  $99B4  2A                         STORE_quick   ; inline operand = 10
  $99B5  8E E2 BB                   PUSH_imm2              $BBE2 (str_is_this_ok)
  $99B8  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $99BC  06                         LOADL_quick   ; inline operand = 6
  $99BD  D3                         BYTE_DEREF
  $99BE  B3                         PUSHL
  $99BF  8E 77 FA                   PUSH_imm2              $FA77 (msg_tax_is_d_enter_new_tax)
  $99C2  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $99C6  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $99C9  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $99CC  AC 12 DB                   CALL_abs               $DB12 (defender_owner_is_keyed_daimyo) {bytecode}
  $99CF  D8 D7 99                   JUMPF_abs              $99D7
  $99D2  89 1E                      BYTE_LOADL_imm1        +30
  $99D4  D6 D9 99                   JUMP_abs               $99D9
 >$99D7  89 64                      BYTE_LOADL_imm1        +100
 >$99D9  B3                         PUSHL
  $99DA  61                         PUSH_qimm   ; inline operand = 1
  $99DB  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $99DF  25                         STORE_quick   ; inline operand = 5
  $99E0  D8 5B 9A                   JUMPF_abs              $9A5B
  $99E3  06                         LOADL_quick   ; inline operand = 6
  $99E4  D3                         BYTE_DEREF
  $99E5  15                         LOADR_quick   ; inline operand = 5
  $99E6  C1                         CMPNE
  $99E7  D8 5B 9A                   JUMPF_abs              $9A5B
  $99EA  06                         LOADL_quick   ; inline operand = 6
  $99EB  D3                         BYTE_DEREF
  $99EC  B3                         PUSHL
  $99ED  05                         LOADL_quick   ; inline operand = 5
  $99EE  B4                         POPR
  $99EF  C4                         SCMPGT
  $99F0  D8 FF 99                   JUMPF_abs              $99FF
  $99F3  8D 13                      BYTE_PUSH_imm1         +19
  $99F5  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $99F9  8E AB FA                   PUSH_imm2              $FAAB (msg_the_peasants_are_protesting)
  $99FC  D6 08 9A                   JUMP_abs               $9A08
 >$99FF  8D 12                      BYTE_PUSH_imm1         +18
  $9A01  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $9A05  8E 8F FA                   PUSH_imm2              $FA8F (msg_the_peasants_are_delighted)
 >$9A08  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9A0C  06                         LOADL_quick   ; inline operand = 6
  $9A0D  D3                         BYTE_DEREF
  $9A0E  15                         LOADR_quick   ; inline operand = 5
  $9A0F  BC                         SUB
  $9A10  50                         LOADR_qimm   ; inline operand = 0
  $9A11  C4                         SCMPGT
  $9A12  D8 19 9A                   JUMPF_abs              $9A19
  $9A15  41                         LOADL_qimm   ; inline operand = 1
  $9A16  D6 1B 9A                   JUMP_abs               $9A1B
 >$9A19  89 FF                      BYTE_LOADL_imm1        -1
 >$9A1B  27                         STORE_quick   ; inline operand = 7
  $9A1C  07                         LOADL_quick   ; inline operand = 7
  $9A1D  8B FF                      BYTE_LOADR_imm1        -1
  $9A1F  C0                         CMPEQ
  $9A20  D8 2D 9A                   JUMPF_abs              $9A2D
  $9A23  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $9A26  74                         ADD_qimm   ; inline operand = 4
  $9A27  D3                         BYTE_DEREF
  $9A28  51                         LOADR_qimm   ; inline operand = 1
  $9A29  C2                         SCMPLT
  $9A2A  D7 38 9A                   JUMPT_abs              $9A38
 >$9A2D  07                         LOADL_quick   ; inline operand = 7
  $9A2E  B3                         PUSHL
  $9A2F  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $9A32  74                         ADD_qimm   ; inline operand = 4
  $9A33  B4                         POPR
  $9A34  B3                         PUSHL
  $9A35  D3                         BYTE_DEREF
  $9A36  BB                         ADD
  $9A37  D4                         BYTE_POPSTORE
 >$9A38  06                         LOADL_quick   ; inline operand = 6
  $9A39  D3                         BYTE_DEREF
  $9A3A  28                         STORE_quick   ; inline operand = 8
  $9A3B  36                         PUSH_quick   ; inline operand = 6
  $9A3C  05                         LOADL_quick   ; inline operand = 5
  $9A3D  D4                         BYTE_POPSTORE
  $9A3E  08                         LOADL_quick   ; inline operand = 8
  $9A3F  15                         LOADR_quick   ; inline operand = 5
  $9A40  BC                         SUB
  $9A41  25                         STORE_quick   ; inline operand = 5
  $9A42  3B                         PUSH_quick   ; inline operand = 11
  $9A43  35                         PUSH_quick   ; inline operand = 5
  $9A44  0B                         LOADL_quick   ; inline operand = 11
  $9A45  B0                         DEREF
  $9A46  B3                         PUSHL
  $9A47  E9 D6 82 04                CALL_abs_imm1          $82D6 (effect_tax) {bytecode}, $04
  $9A4B  B1                         POPSTORE
  $9A4C  3A                         PUSH_quick   ; inline operand = 10
  $9A4D  35                         PUSH_quick   ; inline operand = 5
  $9A4E  0A                         LOADL_quick   ; inline operand = 10
  $9A4F  B0                         DEREF
  $9A50  B3                         PUSHL
  $9A51  E9 D6 82 04                CALL_abs_imm1          $82D6 (effect_tax) {bytecode}, $04
  $9A55  B1                         POPSTORE
  $9A56  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9A59  41                         LOADL_qimm   ; inline operand = 1
  $9A5A  CF                         RETURN
 >$9A5B  40                         LOADL_qimm   ; inline operand = 0
  $9A5C  CF                         RETURN

; ============================================================
; sub $9A5D   (frame_off=-12, body @ $9A62)
; ============================================================
  $9A62  61                         PUSH_qimm   ; inline operand = 1
  $9A63  E9 10 E5 02                CALL_abs_imm1          $E510 (build_eligible_province_list) {bytecode}, $02
  $9A67  8E 89 6F                   PUSH_imm2              $6F89
  $9A6A  64                         PUSH_qimm   ; inline operand = 4
  $9A6B  E9 9F 87 04                CALL_abs_imm1          $879F (province_select_helper) {bytecode}, $04
  $9A6F  D8 7C 9B                   JUMPF_abs              $9B7C
  $9A72  8E C8 FA                   PUSH_imm2              $FAC8 (msg_send_where)
  $9A75  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9A79  8E 89 6F                   PUSH_imm2              $6F89
  $9A7C  E9 4C 80 02                CALL_abs_imm1          $804C (province_select_prompt) {bytecode}, $02
  $9A80  28                         STORE_quick   ; inline operand = 8
  $9A81  D8 7C 9B                   JUMPF_abs              $9B7C
  $9A84  08                         LOADL_quick   ; inline operand = 8
  $9A85  D1                         DEC
  $9A86  28                         STORE_quick   ; inline operand = 8
  $9A87  8B 1A                      BYTE_LOADR_imm1        +26
  $9A89  B5                         MULT
  $9A8A  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9A8D  BB                         ADD
  $9A8E  26                         STORE_quick   ; inline operand = 6
  $9A8F  8F 18                      BYTE_ADD_imm1          +24
  $9A91  B0                         DEREF
  $9A92  27                         STORE_quick   ; inline operand = 7
  $9A93  40                         LOADL_qimm   ; inline operand = 0
  $9A94  2B                         STORE_quick   ; inline operand = 11
  $9A95  2A                         STORE_quick   ; inline operand = 10
  $9A96  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $9A99  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $9A9C  E9 23 93 02                CALL_abs_imm1          $9323 (effect_war_combat_prep_a) {bytecode}, $02
  $9AA0  29                         STORE_quick   ; inline operand = 9
  $9AA1  D8 E3 9A                   JUMPF_abs              $9AE3
  $9AA4  39                         PUSH_quick   ; inline operand = 9
  $9AA5  06                         LOADL_quick   ; inline operand = 6
  $9AA6  76                         ADD_qimm   ; inline operand = 6
  $9AA7  B0                         DEREF
  $9AA8  B3                         PUSHL
  $9AA9  37                         PUSH_quick   ; inline operand = 7
  $9AAA  E9 E5 8B 06                CALL_abs_imm1          $8BE5 (effect_send) {bytecode}, $06
  $9AAE  29                         STORE_quick   ; inline operand = 9
  $9AAF  D8 D9 9A                   JUMPF_abs              $9AD9
  $9AB2  8E FF FA                   PUSH_imm2              $FAFF (msg_rice)
  $9AB5  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9AB9  41                         LOADL_qimm   ; inline operand = 1
  $9ABA  A8 E0 7B                   STORE_abs              $7BE0 (ui_input_prompt_active_flag)
  $9ABD  39                         PUSH_quick   ; inline operand = 9
  $9ABE  61                         PUSH_qimm   ; inline operand = 1
  $9ABF  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $9AC3  2A                         STORE_quick   ; inline operand = 10
  $9AC4  40                         LOADL_qimm   ; inline operand = 0
  $9AC5  A8 E0 7B                   STORE_abs              $7BE0 (ui_input_prompt_active_flag)
  $9AC8  0A                         LOADL_quick   ; inline operand = 10
  $9AC9  50                         LOADR_qimm   ; inline operand = 0
  $9ACA  C3                         SCMPLE
  $9ACB  D8 E3 9A                   JUMPF_abs              $9AE3
  $9ACE  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $9AD1  0A                         LOADL_quick   ; inline operand = 10
  $9AD2  50                         LOADR_qimm   ; inline operand = 0
  $9AD3  C2                         SCMPLT
  $9AD4  D8 E3 9A                   JUMPF_abs              $9AE3
  $9AD7  40                         LOADL_qimm   ; inline operand = 0
  $9AD8  CF                         RETURN
 >$9AD9  8E C6 FD                   PUSH_imm2              $FDC6 (msg_we_re_at_our_limit)
  $9ADC  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9AE0  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$9AE3  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $9AE6  E9 51 93 02                CALL_abs_imm1          $9351 (effect_war_combat_prep_c) {bytecode}, $02
  $9AEA  29                         STORE_quick   ; inline operand = 9
  $9AEB  D8 2C 9B                   JUMPF_abs              $9B2C
  $9AEE  39                         PUSH_quick   ; inline operand = 9
  $9AEF  06                         LOADL_quick   ; inline operand = 6
  $9AF0  B0                         DEREF
  $9AF1  B3                         PUSHL
  $9AF2  37                         PUSH_quick   ; inline operand = 7
  $9AF3  E9 E5 8B 06                CALL_abs_imm1          $8BE5 (effect_send) {bytecode}, $06
  $9AF7  29                         STORE_quick   ; inline operand = 9
  $9AF8  D8 22 9B                   JUMPF_abs              $9B22
  $9AFB  8E FA FA                   PUSH_imm2              $FAFA (msg_gold)
  $9AFE  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9B02  41                         LOADL_qimm   ; inline operand = 1
  $9B03  A8 E0 7B                   STORE_abs              $7BE0 (ui_input_prompt_active_flag)
  $9B06  39                         PUSH_quick   ; inline operand = 9
  $9B07  61                         PUSH_qimm   ; inline operand = 1
  $9B08  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $9B0C  2B                         STORE_quick   ; inline operand = 11
  $9B0D  40                         LOADL_qimm   ; inline operand = 0
  $9B0E  A8 E0 7B                   STORE_abs              $7BE0 (ui_input_prompt_active_flag)
  $9B11  0B                         LOADL_quick   ; inline operand = 11
  $9B12  50                         LOADR_qimm   ; inline operand = 0
  $9B13  C3                         SCMPLE
  $9B14  D8 2C 9B                   JUMPF_abs              $9B2C
  $9B17  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $9B1A  0B                         LOADL_quick   ; inline operand = 11
  $9B1B  50                         LOADR_qimm   ; inline operand = 0
  $9B1C  C2                         SCMPLT
  $9B1D  D8 2C 9B                   JUMPF_abs              $9B2C
  $9B20  40                         LOADL_qimm   ; inline operand = 0
  $9B21  CF                         RETURN
 >$9B22  8E C6 FD                   PUSH_imm2              $FDC6 (msg_we_re_at_our_limit)
  $9B25  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9B29  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$9B2C  0B                         LOADL_quick   ; inline operand = 11
  $9B2D  D7 34 9B                   JUMPT_abs              $9B34
  $9B30  0A                         LOADL_quick   ; inline operand = 10
  $9B31  D8 7C 9B                   JUMPF_abs              $9B7C
 >$9B34  8E E3 BB                   PUSH_imm2              $BBE3 (msg_is_this_ok_bbe3)
  $9B37  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9B3B  AC A7 D3                   CALL_abs               $D3A7 (prompt_y_n) {bytecode}
  $9B3E  D8 7C 9B                   JUMPF_abs              $9B7C
  $9B41  3B                         PUSH_quick   ; inline operand = 11
  $9B42  06                         LOADL_quick   ; inline operand = 6
  $9B43  B4                         POPR
  $9B44  B3                         PUSHL
  $9B45  B0                         DEREF
  $9B46  BB                         ADD
  $9B47  B1                         POPSTORE
  $9B48  3A                         PUSH_quick   ; inline operand = 10
  $9B49  06                         LOADL_quick   ; inline operand = 6
  $9B4A  76                         ADD_qimm   ; inline operand = 6
  $9B4B  B4                         POPR
  $9B4C  B3                         PUSHL
  $9B4D  B0                         DEREF
  $9B4E  BB                         ADD
  $9B4F  B1                         POPSTORE
  $9B50  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9B53  8B 1A                      BYTE_LOADR_imm1        +26
  $9B55  B5                         MULT
  $9B56  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9B59  BB                         ADD
  $9B5A  26                         STORE_quick   ; inline operand = 6
  $9B5B  3B                         PUSH_quick   ; inline operand = 11
  $9B5C  06                         LOADL_quick   ; inline operand = 6
  $9B5D  B4                         POPR
  $9B5E  B3                         PUSHL
  $9B5F  B0                         DEREF
  $9B60  BC                         SUB
  $9B61  B1                         POPSTORE
  $9B62  3A                         PUSH_quick   ; inline operand = 10
  $9B63  06                         LOADL_quick   ; inline operand = 6
  $9B64  76                         ADD_qimm   ; inline operand = 6
  $9B65  B4                         POPR
  $9B66  B3                         PUSHL
  $9B67  B0                         DEREF
  $9B68  BC                         SUB
  $9B69  B1                         POPSTORE
  $9B6A  8D 11                      BYTE_PUSH_imm1         +17
  $9B6C  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $9B70  8E 04 FB                   PUSH_imm2              $FB04 (msg_the_supplies_have_arrived_safe)
  $9B73  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9B77  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9B7A  41                         LOADL_qimm   ; inline operand = 1
  $9B7B  CF                         RETURN
 >$9B7C  40                         LOADL_qimm   ; inline operand = 0
  $9B7D  CF                         RETURN

; ============================================================
; sub $9B7E   (frame_off=-8, body @ $9B83)
; ============================================================
  $9B83  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9B86  8B 1A                      BYTE_LOADR_imm1        +26
  $9B88  B5                         MULT
  $9B89  8C 09 70                   LOADR_imm2             $7009
  $9B8C  BB                         ADD
  $9B8D  B0                         DEREF
  $9B8E  D7 9D 9B                   JUMPT_abs              $9B9D
  $9B91  8E 13 FE                   PUSH_imm2              $FE13 (msg_you_have_no_peasants)
  $9B94  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9B98  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9B9B  40                         LOADL_qimm   ; inline operand = 0
  $9B9C  CF                         RETURN
 >$9B9D  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9BA0  8B 1A                      BYTE_LOADR_imm1        +26
  $9BA2  B5                         MULT
  $9BA3  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9BA6  BB                         ADD
  $9BA7  28                         STORE_quick   ; inline operand = 8
  $9BA8  7A                         ADD_qimm   ; inline operand = 10
  $9BA9  2A                         STORE_quick   ; inline operand = 10
  $9BAA  0A                         LOADL_quick   ; inline operand = 10
  $9BAB  B0                         DEREF
  $9BAC  8B 64                      BYTE_LOADR_imm1        +100
  $9BAE  C5                         SCMPGE
  $9BAF  D8 BE 9B                   JUMPF_abs              $9BBE
  $9BB2  8E C6 FD                   PUSH_imm2              $FDC6 (msg_we_re_at_our_limit)
  $9BB5  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9BB9  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9BBC  40                         LOADL_qimm   ; inline operand = 0
  $9BBD  CF                         RETURN
 >$9BBE  08                         LOADL_quick   ; inline operand = 8
  $9BBF  B0                         DEREF
  $9BC0  D7 CF 9B                   JUMPT_abs              $9BCF
  $9BC3  8E D9 FD                   PUSH_imm2              $FDD9 (msg_you_have_no_gold)
  $9BC6  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9BCA  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9BCD  40                         LOADL_qimm   ; inline operand = 0
  $9BCE  CF                         RETURN
 >$9BCF  08                         LOADL_quick   ; inline operand = 8
  $9BD0  7A                         ADD_qimm   ; inline operand = 10
  $9BD1  B0                         DEREF
  $9BD2  B3                         PUSHL
  $9BD3  89 64                      BYTE_LOADL_imm1        +100
  $9BD5  B4                         POPR
  $9BD6  BC                         SUB
  $9BD7  B3                         PUSHL
  $9BD8  38                         PUSH_quick   ; inline operand = 8
  $9BD9  E9 D8 87 02                CALL_abs_imm1          $87D8 (effect_dam) {bytecode}, $02
  $9BDD  B4                         POPR
  $9BDE  B5                         MULT
  $9BDF  52                         LOADR_qimm   ; inline operand = 2
  $9BE0  B6                         SDIV
  $9BE1  B3                         PUSHL
  $9BE2  08                         LOADL_quick   ; inline operand = 8
  $9BE3  B0                         DEREF
  $9BE4  B3                         PUSHL
  $9BE5  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $9BE9  2B                         STORE_quick   ; inline operand = 11
  $9BEA  8E EE BB                   PUSH_imm2              $BBEE (str_dams_value_label)
  $9BED  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9BF1  0A                         LOADL_quick   ; inline operand = 10
  $9BF2  B0                         DEREF
  $9BF3  B3                         PUSHL
  $9BF4  8E EF BB                   PUSH_imm2              $BBEF (msg_dams_value)
  $9BF7  8E 25 FB                   PUSH_imm2              $FB25 (msg_s_is_d_spend_how_much_on_it)
  $9BFA  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $9BFE  3B                         PUSH_quick   ; inline operand = 11
  $9BFF  61                         PUSH_qimm   ; inline operand = 1
  $9C00  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $9C04  29                         STORE_quick   ; inline operand = 9
  $9C05  D8 4E 9C                   JUMPF_abs              $9C4E
  $9C08  39                         PUSH_quick   ; inline operand = 9
  $9C09  08                         LOADL_quick   ; inline operand = 8
  $9C0A  B4                         POPR
  $9C0B  B3                         PUSHL
  $9C0C  B0                         DEREF
  $9C0D  BC                         SUB
  $9C0E  B1                         POPSTORE
  $9C0F  38                         PUSH_quick   ; inline operand = 8
  $9C10  E9 D8 87 02                CALL_abs_imm1          $87D8 (effect_dam) {bytecode}, $02
  $9C14  B3                         PUSHL
  $9C15  09                         LOADL_quick   ; inline operand = 9
  $9C16  D2                         LSHIFT1
  $9C17  B4                         POPR
  $9C18  B6                         SDIV
  $9C19  29                         STORE_quick   ; inline operand = 9
  $9C1A  D7 20 9C                   JUMPT_abs              $9C20
  $9C1D  09                         LOADL_quick   ; inline operand = 9
  $9C1E  D0                         INC
  $9C1F  29                         STORE_quick   ; inline operand = 9
 >$9C20  3A                         PUSH_quick   ; inline operand = 10
  $9C21  39                         PUSH_quick   ; inline operand = 9
  $9C22  E9 7D 88 04                CALL_abs_imm1          $887D (add_effect_gain_clamped) {bytecode}, $04
  $9C26  8D 15                      BYTE_PUSH_imm1         +21
  $9C28  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $9C2C  0A                         LOADL_quick   ; inline operand = 10
  $9C2D  B0                         DEREF
  $9C2E  8B 64                      BYTE_LOADR_imm1        +100
  $9C30  C4                         SCMPGT
  $9C31  D8 38 9C                   JUMPF_abs              $9C38
  $9C34  3A                         PUSH_quick   ; inline operand = 10
  $9C35  89 64                      BYTE_LOADL_imm1        +100
  $9C37  B1                         POPSTORE
 >$9C38  8E FA BB                   PUSH_imm2              $BBFA (str_output_label)
  $9C3B  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9C3F  0A                         LOADL_quick   ; inline operand = 10
  $9C40  B0                         DEREF
  $9C41  B3                         PUSHL
  $9C42  8E 43 FB                   PUSH_imm2              $FB43 (msg_dams_value_is_now_d)
  $9C45  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $9C49  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9C4C  41                         LOADL_qimm   ; inline operand = 1
  $9C4D  CF                         RETURN
 >$9C4E  CF                         RETURN

; ============================================================
; sub $9C4F   (frame_off=-6, body @ $9C54)
; ============================================================
  $9C54  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9C57  8B 1A                      BYTE_LOADR_imm1        +26
  $9C59  B5                         MULT
  $9C5A  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9C5D  BB                         ADD
  $9C5E  2B                         STORE_quick   ; inline operand = 11
  $9C5F  40                         LOADL_qimm   ; inline operand = 0
  $9C60  29                         STORE_quick   ; inline operand = 9
  $9C61  60                         PUSH_qimm   ; inline operand = 0
  $9C62  E9 10 E5 02                CALL_abs_imm1          $E510 (build_eligible_province_list) {bytecode}, $02
  $9C66  8E 89 6F                   PUSH_imm2              $6F89
  $9C69  66                         PUSH_qimm   ; inline operand = 6
  $9C6A  E9 9F 87 04                CALL_abs_imm1          $879F (province_select_helper) {bytecode}, $04
  $9C6E  D8 3B 9D                   JUMPF_abs              $9D3B
  $9C71  8E 9C FC                   PUSH_imm2              $FC9C (msg_which_fief)
  $9C74  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9C78  8E 89 6F                   PUSH_imm2              $6F89
  $9C7B  E9 4C 80 02                CALL_abs_imm1          $804C (province_select_prompt) {bytecode}, $02
  $9C7F  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $9C82  D8 39 9D                   JUMPF_abs              $9D39
  $9C85  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9C88  D1                         DEC
  $9C89  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $9C8C  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $9C8F  72                         ADD_qimm   ; inline operand = 2
  $9C90  B3                         PUSHL
  $9C91  D3                         BYTE_DEREF
  $9C92  D1                         DEC
  $9C93  D4                         BYTE_POPSTORE
  $9C94  41                         LOADL_qimm   ; inline operand = 1
  $9C95  29                         STORE_quick   ; inline operand = 9
  $9C96  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $9C99  AC A4 E3                   CALL_abs               $E3A4 (prompt_diplomacy_pact) {bytecode}
  $9C9C  2A                         STORE_quick   ; inline operand = 10
  $9C9D  D8 19 9D                   JUMPF_abs              $9D19
  $9CA0  3A                         PUSH_quick   ; inline operand = 10
  $9CA1  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $9CA4  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $9CA8  59                         LOADR_qimm   ; inline operand = 9
  $9CA9  B5                         MULT
  $9CAA  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $9CAD  BB                         ADD
  $9CAE  B3                         PUSHL
  $9CAF  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $9CB2  59                         LOADR_qimm   ; inline operand = 9
  $9CB3  B5                         MULT
  $9CB4  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $9CB7  BB                         ADD
  $9CB8  B3                         PUSHL
  $9CB9  8E 27 FD                   PUSH_imm2              $FD27 (msg_lord_s_s_wants_d_gold_pay)
  $9CBC  E9 34 D1 08                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $08
  $9CC0  AC A7 D3                   CALL_abs               $D3A7 (prompt_y_n) {bytecode}
  $9CC3  D8 05 9D                   JUMPF_abs              $9D05
  $9CC6  0B                         LOADL_quick   ; inline operand = 11
  $9CC7  B0                         DEREF
  $9CC8  1A                         LOADR_quick   ; inline operand = 10
  $9CC9  C2                         SCMPLT
  $9CCA  D8 D7 9C                   JUMPF_abs              $9CD7
  $9CCD  8E D9 FD                   PUSH_imm2              $FDD9 (msg_you_have_no_gold)
  $9CD0  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9CD4  D6 14 9D                   JUMP_abs               $9D14
 >$9CD7  60                         PUSH_qimm   ; inline operand = 0
  $9CD8  E9 8F 8B 02                CALL_abs_imm1          $8B8F (play_result_jingle) {bytecode}, $02
  $9CDC  3A                         PUSH_quick   ; inline operand = 10
  $9CDD  0B                         LOADL_quick   ; inline operand = 11
  $9CDE  B4                         POPR
  $9CDF  B3                         PUSHL
  $9CE0  B0                         DEREF
  $9CE1  BC                         SUB
  $9CE2  B1                         POPSTORE
  $9CE3  3A                         PUSH_quick   ; inline operand = 10
  $9CE4  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9CE7  8B 1A                      BYTE_LOADR_imm1        +26
  $9CE9  B5                         MULT
  $9CEA  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9CED  BB                         ADD
  $9CEE  B4                         POPR
  $9CEF  B3                         PUSHL
  $9CF0  B0                         DEREF
  $9CF1  BB                         ADD
  $9CF2  B1                         POPSTORE
  $9CF3  AC 4F DA                   CALL_abs               $DA4F (set_pact_relation) {bytecode}
  $9CF6  63                         PUSH_qimm   ; inline operand = 3
  $9CF7  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $9CFB  8E 63 FD                   PUSH_imm2              $FD63 (msg_war_is_inevitable_so_don_t_let)
  $9CFE  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9D02  D6 14 9D                   JUMP_abs               $9D14
 >$9D05  8E 93 FD                   PUSH_imm2              $FD93 (msg_who_needs_him_anyway)
  $9D08  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
 >$9D0C  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $9D0F  72                         ADD_qimm   ; inline operand = 2
  $9D10  B3                         PUSHL
  $9D11  D3                         BYTE_DEREF
  $9D12  D1                         DEC
  $9D13  D4                         BYTE_POPSTORE
 >$9D14  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9D17  09                         LOADL_quick   ; inline operand = 9
  $9D18  CF                         RETURN
 >$9D19  61                         PUSH_qimm   ; inline operand = 1
  $9D1A  E9 8F 8B 02                CALL_abs_imm1          $8B8F (play_result_jingle) {bytecode}, $02
  $9D1E  8E FB BB                   PUSH_imm2              $BBFB (str_output_label_alias1)
  $9D21  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9D25  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $9D28  59                         LOADR_qimm   ; inline operand = 9
  $9D29  B5                         MULT
  $9D2A  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $9D2D  BB                         ADD
  $9D2E  B3                         PUSHL
  $9D2F  8E AA FC                   PUSH_imm2              $FCAA (msg_lord_s_they_ve_refused)
  $9D32  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $9D36  D6 0C 9D                   JUMP_abs               $9D0C
 >$9D39  09                         LOADL_quick   ; inline operand = 9
  $9D3A  CF                         RETURN
 >$9D3B  09                         LOADL_quick   ; inline operand = 9
  $9D3C  CF                         RETURN

; ============================================================
; sub $9D3D   (frame_off=-4, body @ $9D42)
; ============================================================
  $9D42  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9D45  8B 1A                      BYTE_LOADR_imm1        +26
  $9D47  B5                         MULT
  $9D48  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9D4B  BB                         ADD
  $9D4C  2B                         STORE_quick   ; inline operand = 11
  $9D4D  0B                         LOADL_quick   ; inline operand = 11
  $9D4E  78                         ADD_qimm   ; inline operand = 8
  $9D4F  B0                         DEREF
  $9D50  B3                         PUSHL
  $9D51  0B                         LOADL_quick   ; inline operand = 11
  $9D52  8F 18                      BYTE_ADD_imm1          +24
  $9D54  B0                         DEREF
  $9D55  B4                         POPR
  $9D56  C3                         SCMPLE
  $9D57  D8 66 9D                   JUMPF_abs              $9D66
  $9D5A  8E C6 FD                   PUSH_imm2              $FDC6 (msg_we_re_at_our_limit)
  $9D5D  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9D61  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9D64  40                         LOADL_qimm   ; inline operand = 0
  $9D65  CF                         RETURN
 >$9D66  0B                         LOADL_quick   ; inline operand = 11
  $9D67  B0                         DEREF
  $9D68  D8 B8 9D                   JUMPF_abs              $9DB8
  $9D6B  8E FC BB                   PUSH_imm2              $BBFC (str_output_label_alias2)
  $9D6E  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9D72  0B                         LOADL_quick   ; inline operand = 11
  $9D73  78                         ADD_qimm   ; inline operand = 8
  $9D74  B0                         DEREF
  $9D75  B3                         PUSHL
  $9D76  8E FD BB                   PUSH_imm2              $BBFD (msg_output)
  $9D79  8E 25 FB                   PUSH_imm2              $FB25 (msg_s_is_d_spend_how_much_on_it)
  $9D7C  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $9D80  0B                         LOADL_quick   ; inline operand = 11
  $9D81  B0                         DEREF
  $9D82  B3                         PUSHL
  $9D83  61                         PUSH_qimm   ; inline operand = 1
  $9D84  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $9D88  2A                         STORE_quick   ; inline operand = 10
  $9D89  D8 B6 9D                   JUMPF_abs              $9DB6
  $9D8C  3A                         PUSH_quick   ; inline operand = 10
  $9D8D  0B                         LOADL_quick   ; inline operand = 11
  $9D8E  B4                         POPR
  $9D8F  B3                         PUSHL
  $9D90  B0                         DEREF
  $9D91  BC                         SUB
  $9D92  B1                         POPSTORE
  $9D93  3A                         PUSH_quick   ; inline operand = 10
  $9D94  3B                         PUSH_quick   ; inline operand = 11
  $9D95  E9 F0 87 04                CALL_abs_imm1          $87F0 (effect_grow) {bytecode}, $04
  $9D99  2A                         STORE_quick   ; inline operand = 10
  $9D9A  69                         PUSH_qimm   ; inline operand = 9
  $9D9B  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $9D9F  8E 04 BC                   PUSH_imm2              $BC04 (str_treasure_room_full)
  $9DA2  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9DA6  0B                         LOADL_quick   ; inline operand = 11
  $9DA7  78                         ADD_qimm   ; inline operand = 8
  $9DA8  B0                         DEREF
  $9DA9  B3                         PUSHL
  $9DAA  8E 58 FB                   PUSH_imm2              $FB58 (msg_output_is_now_d)
  $9DAD  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $9DB1  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9DB4  41                         LOADL_qimm   ; inline operand = 1
  $9DB5  CF                         RETURN
 >$9DB6  40                         LOADL_qimm   ; inline operand = 0
  $9DB7  CF                         RETURN
 >$9DB8  8E D9 FD                   PUSH_imm2              $FDD9 (msg_you_have_no_gold)
  $9DBB  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9DBF  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9DC2  40                         LOADL_qimm   ; inline operand = 0
  $9DC3  CF                         RETURN

; ============================================================
; sub $9DC4   (frame_off=-8, body @ $9DC9)
; ============================================================
  $9DC9  40                         LOADL_qimm   ; inline operand = 0
  $9DCA  2A                         STORE_quick   ; inline operand = 10
  $9DCB  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $9DCE  28                         STORE_quick   ; inline operand = 8
  $9DCF  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9DD2  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $9DD5  BB                         ADD
  $9DD6  D3                         BYTE_DEREF
  $9DD7  D8 FC 9E                   JUMPF_abs              $9EFC
  $9DDA  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $9DDD  B3                         PUSHL
  $9DDE  E9 DC E4 02                CALL_abs_imm1          $E4DC (build_fiefs_excluding_daimyo) {bytecode}, $02
  $9DE2  8E 89 6F                   PUSH_imm2              $6F89
  $9DE5  68                         PUSH_qimm   ; inline operand = 8
  $9DE6  E9 9F 87 04                CALL_abs_imm1          $879F (province_select_helper) {bytecode}, $04
  $9DEA  D8 FA 9E                   JUMPF_abs              $9EFA
  $9DED  8E 9C FC                   PUSH_imm2              $FC9C (msg_which_fief)
  $9DF0  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9DF4  8E 89 6F                   PUSH_imm2              $6F89
  $9DF7  E9 4C 80 02                CALL_abs_imm1          $804C (province_select_prompt) {bytecode}, $02
  $9DFB  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $9DFE  D8 F8 9E                   JUMPF_abs              $9EF8
  $9E01  08                         LOADL_quick   ; inline operand = 8
  $9E02  72                         ADD_qimm   ; inline operand = 2
  $9E03  B3                         PUSHL
  $9E04  D3                         BYTE_DEREF
  $9E05  D1                         DEC
  $9E06  D4                         BYTE_POPSTORE
  $9E07  41                         LOADL_qimm   ; inline operand = 1
  $9E08  2A                         STORE_quick   ; inline operand = 10
  $9E09  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9E0C  D1                         DEC
  $9E0D  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $9E10  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $9E13  AC 15 E3                   CALL_abs               $E315 (marriage_pact_handler) {bytecode}
  $9E16  2B                         STORE_quick   ; inline operand = 11
  $9E17  D8 C6 9E                   JUMPF_abs              $9EC6
  $9E1A  8D 16                      BYTE_PUSH_imm1         +22
  $9E1C  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $9E20  8F 35                      BYTE_ADD_imm1          +53
  $9E22  A8 5B 6F                   STORE_abs              $6F5B (active_province_idx_copy)
  $9E25  61                         PUSH_qimm   ; inline operand = 1
  $9E26  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $9E2A  64                         PUSH_qimm   ; inline operand = 4
  $9E2B  62                         PUSH_qimm   ; inline operand = 2
  $9E2C  E9 6F E7 04                CALL_abs_imm1          $E76F (draw_daimyo_portrait) {bytecode}, $04
  $9E30  60                         PUSH_qimm   ; inline operand = 0
  $9E31  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $9E35  3B                         PUSH_quick   ; inline operand = 11
  $9E36  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $9E39  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $9E3D  59                         LOADR_qimm   ; inline operand = 9
  $9E3E  B5                         MULT
  $9E3F  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $9E42  BB                         ADD
  $9E43  B3                         PUSHL
  $9E44  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $9E47  59                         LOADR_qimm   ; inline operand = 9
  $9E48  B5                         MULT
  $9E49  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $9E4C  BB                         ADD
  $9E4D  B3                         PUSHL
  $9E4E  8E 45 FD                   PUSH_imm2              $FD45 (msg_lord_s_s_wants_d_gold_pay_fd45)
  $9E51  E9 34 D1 08                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $08
  $9E55  AC A7 D3                   CALL_abs               $D3A7 (prompt_y_n) {bytecode}
  $9E58  D8 A4 9E                   JUMPF_abs              $9EA4
  $9E5B  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $9E5E  8B 1A                      BYTE_LOADR_imm1        +26
  $9E60  B5                         MULT
  $9E61  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9E64  BB                         ADD
  $9E65  29                         STORE_quick   ; inline operand = 9
  $9E66  09                         LOADL_quick   ; inline operand = 9
  $9E67  B0                         DEREF
  $9E68  B3                         PUSHL
  $9E69  0B                         LOADL_quick   ; inline operand = 11
  $9E6A  B4                         POPR
  $9E6B  C3                         SCMPLE
  $9E6C  D8 9E 9E                   JUMPF_abs              $9E9E
  $9E6F  AC 7D DA                   CALL_abs               $DA7D (set_marriage_relation) {bytecode}
  $9E72  60                         PUSH_qimm   ; inline operand = 0
  $9E73  E9 8F 8B 02                CALL_abs_imm1          $8B8F (play_result_jingle) {bytecode}, $02
  $9E77  8D 10                      BYTE_PUSH_imm1         +16
  $9E79  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $9E7D  8E C3 FC                   PUSH_imm2              $FCC3 (msg_your_bride_to_be_has_arrived)
  $9E80  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9E84  3B                         PUSH_quick   ; inline operand = 11
  $9E85  09                         LOADL_quick   ; inline operand = 9
  $9E86  B4                         POPR
  $9E87  B3                         PUSHL
  $9E88  B0                         DEREF
  $9E89  BC                         SUB
  $9E8A  B1                         POPSTORE
  $9E8B  3B                         PUSH_quick   ; inline operand = 11
  $9E8C  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $9E8F  8B 1A                      BYTE_LOADR_imm1        +26
  $9E91  B5                         MULT
  $9E92  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $9E95  BB                         ADD
  $9E96  B4                         POPR
  $9E97  B3                         PUSHL
  $9E98  B0                         DEREF
  $9E99  BB                         ADD
  $9E9A  B1                         POPSTORE
  $9E9B  D6 AB 9E                   JUMP_abs               $9EAB
 >$9E9E  8E D9 FD                   PUSH_imm2              $FDD9 (msg_you_have_no_gold)
  $9EA1  D6 A7 9E                   JUMP_abs               $9EA7
 >$9EA4  8E E0 FC                   PUSH_imm2              $FCE0 (msg_don_t_you_long_to_hear_the_pit)
 >$9EA7  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
 >$9EAB  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9EAE  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $9EB1  A8 5B 6F                   STORE_abs              $6F5B (active_province_idx_copy)
  $9EB4  61                         PUSH_qimm   ; inline operand = 1
  $9EB5  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $9EB9  64                         PUSH_qimm   ; inline operand = 4
  $9EBA  62                         PUSH_qimm   ; inline operand = 2
  $9EBB  E9 6F E7 04                CALL_abs_imm1          $E76F (draw_daimyo_portrait) {bytecode}, $04
  $9EBF  60                         PUSH_qimm   ; inline operand = 0
  $9EC0  E9 35 CC 02                CALL_abs_imm1          $CC35 (palette_swap) {bytecode}, $02
  $9EC4  0A                         LOADL_quick   ; inline operand = 10
  $9EC5  CF                         RETURN
 >$9EC6  61                         PUSH_qimm   ; inline operand = 1
  $9EC7  E9 8F 8B 02                CALL_abs_imm1          $8B8F (play_result_jingle) {bytecode}, $02
  $9ECB  8E 05 BC                   PUSH_imm2              $BC05 (str_treasure_room_full_alias)
  $9ECE  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9ED2  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $9ED5  59                         LOADR_qimm   ; inline operand = 9
  $9ED6  B5                         MULT
  $9ED7  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $9EDA  BB                         ADD
  $9EDB  B3                         PUSHL
  $9EDC  8E AA FC                   PUSH_imm2              $FCAA (msg_lord_s_they_ve_refused)
  $9EDF  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $9EE3  08                         LOADL_quick   ; inline operand = 8
  $9EE4  72                         ADD_qimm   ; inline operand = 2
  $9EE5  B3                         PUSHL
  $9EE6  D3                         BYTE_DEREF
  $9EE7  D1                         DEC
  $9EE8  D4                         BYTE_POPSTORE
  $9EE9  08                         LOADL_quick   ; inline operand = 8
  $9EEA  74                         ADD_qimm   ; inline operand = 4
  $9EEB  B3                         PUSHL
  $9EEC  D3                         BYTE_DEREF
  $9EED  D1                         DEC
  $9EEE  D4                         BYTE_POPSTORE
  $9EEF  08                         LOADL_quick   ; inline operand = 8
  $9EF0  73                         ADD_qimm   ; inline operand = 3
  $9EF1  B3                         PUSHL
  $9EF2  D3                         BYTE_DEREF
  $9EF3  D1                         DEC
  $9EF4  D4                         BYTE_POPSTORE
  $9EF5  D6 FF 9E                   JUMP_abs               $9EFF
 >$9EF8  0A                         LOADL_quick   ; inline operand = 10
  $9EF9  CF                         RETURN
 >$9EFA  0A                         LOADL_quick   ; inline operand = 10
  $9EFB  CF                         RETURN
 >$9EFC  AC CB 87                   CALL_abs               $87CB (show_not_home_fief) {bytecode}
 >$9EFF  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9F02  0A                         LOADL_quick   ; inline operand = 10
  $9F03  CF                         RETURN

; ============================================================
; sub $9F04   (frame_off=-4, body @ $9F09)
; ============================================================
  $9F09  8E 06 BC                   PUSH_imm2              $BC06 (msg_loan_prompt)
  $9F0C  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9F10  0C                         LOADL_quick   ; inline operand = 12
  $9F11  8F 18                      BYTE_ADD_imm1          +24
  $9F13  B0                         DEREF
  $9F14  B3                         PUSHL
  $9F15  0C                         LOADL_quick   ; inline operand = 12
  $9F16  B0                         DEREF
  $9F17  B4                         POPR
  $9F18  C5                         SCMPGE
  $9F19  D8 2F 9F                   JUMPF_abs              $9F2F
  $9F1C  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $9F1F  E9 8B D7 02                CALL_abs_imm1          $D78B (daimyo_name_width) {bytecode}, $02
  $9F23  8E 07 BC                   PUSH_imm2              $BC07 (msg_the_treasure_room_is_already_f)
  $9F26  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9F2A  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9F2D  40                         LOADL_qimm   ; inline operand = 0
  $9F2E  CF                         RETURN
 >$9F2F  0C                         LOADL_quick   ; inline operand = 12
  $9F30  72                         ADD_qimm   ; inline operand = 2
  $9F31  B0                         DEREF
  $9F32  B3                         PUSHL
  $9F33  0C                         LOADL_quick   ; inline operand = 12
  $9F34  74                         ADD_qimm   ; inline operand = 4
  $9F35  B0                         DEREF
  $9F36  B4                         POPR
  $9F37  C4                         SCMPGT
  $9F38  D8 A3 9F                   JUMPF_abs              $9FA3
  $9F3B  0C                         LOADL_quick   ; inline operand = 12
  $9F3C  B0                         DEREF
  $9F3D  B3                         PUSHL
  $9F3E  0C                         LOADL_quick   ; inline operand = 12
  $9F3F  8F 18                      BYTE_ADD_imm1          +24
  $9F41  B0                         DEREF
  $9F42  B4                         POPR
  $9F43  BC                         SUB
  $9F44  B3                         PUSHL
  $9F45  A4 0B 6E                   LOADL_abs              $6E0B (loan_rate)
  $9F48  7A                         ADD_qimm   ; inline operand = 10
  $9F49  B3                         PUSHL
  $9F4A  0C                         LOADL_quick   ; inline operand = 12
  $9F4B  72                         ADD_qimm   ; inline operand = 2
  $9F4C  B0                         DEREF
  $9F4D  B3                         PUSHL
  $9F4E  0C                         LOADL_quick   ; inline operand = 12
  $9F4F  74                         ADD_qimm   ; inline operand = 4
  $9F50  B0                         DEREF
  $9F51  B4                         POPR
  $9F52  BC                         SUB
  $9F53  B3                         PUSHL
  $9F54  E9 57 83 06                CALL_abs_imm1          $8357 (ratio_times10_capped) {bytecode}, $06
  $9F58  2A                         STORE_quick   ; inline operand = 10
  $9F59  D8 A3 9F                   JUMPF_abs              $9FA3
  $9F5C  8E 9D F9                   PUSH_imm2              $F99D (msg_how_much_f99d)
  $9F5F  8E 2B BC                   PUSH_imm2              $BC2B (msg_s_would_you_like_to_borrow)
  $9F62  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $9F66  3A                         PUSH_quick   ; inline operand = 10
  $9F67  61                         PUSH_qimm   ; inline operand = 1
  $9F68  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $9F6C  2B                         STORE_quick   ; inline operand = 11
  $9F6D  D8 9E 9F                   JUMPF_abs              $9F9E
  $9F70  3B                         PUSH_quick   ; inline operand = 11
  $9F71  E9 40 8B 02                CALL_abs_imm1          $8B40 (effect_take_loan) {bytecode}, $02
  $9F75  3C                         PUSH_quick   ; inline operand = 12
  $9F76  E9 AC 82 02                CALL_abs_imm1          $82AC (clamp_amount_to_province_max) {bytecode}, $02
  $9F7A  60                         PUSH_qimm   ; inline operand = 0
  $9F7B  E9 4E 8A 02                CALL_abs_imm1          $8A4E (cycle_economy_rate) {bytecode}, $02
  $9F7F  67                         PUSH_qimm   ; inline operand = 7
  $9F80  8D 10                      BYTE_PUSH_imm1         +16
  $9F82  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $9F86  0C                         LOADL_quick   ; inline operand = 12
  $9F87  B0                         DEREF
  $9F88  B3                         PUSHL
  $9F89  E9 C7 83 02                CALL_abs_imm1          $83C7 (draw_selected_province_stat) {bytecode}, $02
  $9F8D  68                         PUSH_qimm   ; inline operand = 8
  $9F8E  8D 10                      BYTE_PUSH_imm1         +16
  $9F90  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $9F94  0C                         LOADL_quick   ; inline operand = 12
  $9F95  72                         ADD_qimm   ; inline operand = 2
  $9F96  B0                         DEREF
  $9F97  B3                         PUSHL
  $9F98  E9 C7 83 02                CALL_abs_imm1          $83C7 (draw_selected_province_stat) {bytecode}, $02
  $9F9C  41                         LOADL_qimm   ; inline operand = 1
  $9F9D  CF                         RETURN
 >$9F9E  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $9FA1  40                         LOADL_qimm   ; inline operand = 0
  $9FA2  CF                         RETURN
 >$9FA3  8E 47 BC                   PUSH_imm2              $BC47 (msg_you_can_t_borrow)
  $9FA6  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9FAA  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $9FAD  40                         LOADL_qimm   ; inline operand = 0
  $9FAE  CF                         RETURN

; ============================================================
; sub $9FAF   (frame_off=-2, body @ $9FB4)
; ============================================================
  $9FB4  8E 59 BC                   PUSH_imm2              $BC59 (msg_repay_debt)
  $9FB7  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $9FBB  0C                         LOADL_quick   ; inline operand = 12
  $9FBC  72                         ADD_qimm   ; inline operand = 2
  $9FBD  B0                         DEREF
  $9FBE  D8 F7 9F                   JUMPF_abs              $9FF7
  $9FC1  0C                         LOADL_quick   ; inline operand = 12
  $9FC2  B0                         DEREF
  $9FC3  D8 F1 9F                   JUMPF_abs              $9FF1
  $9FC6  0C                         LOADL_quick   ; inline operand = 12
  $9FC7  B0                         DEREF
  $9FC8  B3                         PUSHL
  $9FC9  0C                         LOADL_quick   ; inline operand = 12
  $9FCA  72                         ADD_qimm   ; inline operand = 2
  $9FCB  B0                         DEREF
  $9FCC  B3                         PUSHL
  $9FCD  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $9FD1  B3                         PUSHL
  $9FD2  61                         PUSH_qimm   ; inline operand = 1
  $9FD3  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $9FD7  2B                         STORE_quick   ; inline operand = 11
  $9FD8  D8 EC 9F                   JUMPF_abs              $9FEC
  $9FDB  3B                         PUSH_quick   ; inline operand = 11
  $9FDC  0C                         LOADL_quick   ; inline operand = 12
  $9FDD  B4                         POPR
  $9FDE  B3                         PUSHL
  $9FDF  B0                         DEREF
  $9FE0  BC                         SUB
  $9FE1  B1                         POPSTORE
  $9FE2  3B                         PUSH_quick   ; inline operand = 11
  $9FE3  0C                         LOADL_quick   ; inline operand = 12
  $9FE4  72                         ADD_qimm   ; inline operand = 2
  $9FE5  B4                         POPR
  $9FE6  B3                         PUSHL
  $9FE7  B0                         DEREF
  $9FE8  BC                         SUB
  $9FE9  B1                         POPSTORE
  $9FEA  41                         LOADL_qimm   ; inline operand = 1
  $9FEB  CF                         RETURN
 >$9FEC  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $9FEF  40                         LOADL_qimm   ; inline operand = 0
  $9FF0  CF                         RETURN
 >$9FF1  8E 5A BC                   PUSH_imm2              $BC5A (msg_no_gold)
  $9FF4  D6 FA 9F                   JUMP_abs               $9FFA
 >$9FF7  8E 63 BC                   PUSH_imm2              $BC63 (msg_debt_what_debt)
 >$9FFA  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $9FFE  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A001  40                         LOADL_qimm   ; inline operand = 0
  $A002  CF                         RETURN

; ============================================================
; sub $A003   (frame_off=-4, body @ $A008)
; ============================================================
  $A008  8E 75 BC                   PUSH_imm2              $BC75 (msg_sell_rice_prompt)
  $A00B  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A00F  0C                         LOADL_quick   ; inline operand = 12
  $A010  76                         ADD_qimm   ; inline operand = 6
  $A011  B0                         DEREF
  $A012  D8 59 A0                   JUMPF_abs              $A059
  $A015  0C                         LOADL_quick   ; inline operand = 12
  $A016  76                         ADD_qimm   ; inline operand = 6
  $A017  B0                         DEREF
  $A018  B3                         PUSHL
  $A019  AA 0D 6E                   PUSH_abs               $6E0D (gold_rice_exchange_rate)
  $A01C  0C                         LOADL_quick   ; inline operand = 12
  $A01D  B0                         DEREF
  $A01E  B3                         PUSHL
  $A01F  0C                         LOADL_quick   ; inline operand = 12
  $A020  8F 18                      BYTE_ADD_imm1          +24
  $A022  B0                         DEREF
  $A023  B4                         POPR
  $A024  BC                         SUB
  $A025  B3                         PUSHL
  $A026  E9 57 83 06                CALL_abs_imm1          $8357 (ratio_times10_capped) {bytecode}, $06
  $A02A  2A                         STORE_quick   ; inline operand = 10
  $A02B  D8 53 A0                   JUMPF_abs              $A053
  $A02E  8E 9D F9                   PUSH_imm2              $F99D (msg_how_much_f99d)
  $A031  8E 76 BC                   PUSH_imm2              $BC76 (msg_s_rice_will_you_sell)
  $A034  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $A038  3A                         PUSH_quick   ; inline operand = 10
  $A039  61                         PUSH_qimm   ; inline operand = 1
  $A03A  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $A03E  2B                         STORE_quick   ; inline operand = 11
  $A03F  D8 63 A0                   JUMPF_abs              $A063
  $A042  3B                         PUSH_quick   ; inline operand = 11
  $A043  E9 0A 8B 02                CALL_abs_imm1          $8B0A (effect_sell_rice_for_gold) {bytecode}, $02
  $A047  3C                         PUSH_quick   ; inline operand = 12
  $A048  E9 AC 82 02                CALL_abs_imm1          $82AC (clamp_amount_to_province_max) {bytecode}, $02
  $A04C  61                         PUSH_qimm   ; inline operand = 1
  $A04D  E9 4E 8A 02                CALL_abs_imm1          $8A4E (cycle_economy_rate) {bytecode}, $02
  $A051  41                         LOADL_qimm   ; inline operand = 1
  $A052  CF                         RETURN
 >$A053  8E 8C BC                   PUSH_imm2              $BC8C (msg_treasury_full)
  $A056  D6 5C A0                   JUMP_abs               $A05C
 >$A059  8E 9A BC                   PUSH_imm2              $BC9A (msg_no_rice)
 >$A05C  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A060  AC 59 D7                   CALL_abs               $D759 (standard_delay) {bytecode}
 >$A063  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $A066  40                         LOADL_qimm   ; inline operand = 0
  $A067  CF                         RETURN

; ============================================================
; sub $A068   (frame_off=-4, body @ $A06D)
; ============================================================
  $A06D  8E A2 BC                   PUSH_imm2              $BCA2 (msg_buy_rice_prompt)
  $A070  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A074  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $A077  8B 1A                      BYTE_LOADR_imm1        +26
  $A079  B5                         MULT
  $A07A  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A07D  BB                         ADD
  $A07E  B0                         DEREF
  $A07F  D8 DE A0                   JUMPF_abs              $A0DE
  $A082  0C                         LOADL_quick   ; inline operand = 12
  $A083  76                         ADD_qimm   ; inline operand = 6
  $A084  B0                         DEREF
  $A085  B3                         PUSHL
  $A086  0C                         LOADL_quick   ; inline operand = 12
  $A087  8F 18                      BYTE_ADD_imm1          +24
  $A089  B0                         DEREF
  $A08A  B4                         POPR
  $A08B  BC                         SUB
  $A08C  B3                         PUSHL
  $A08D  AA 0D 6E                   PUSH_abs               $6E0D (gold_rice_exchange_rate)
  $A090  0C                         LOADL_quick   ; inline operand = 12
  $A091  B0                         DEREF
  $A092  B3                         PUSHL
  $A093  E9 57 83 06                CALL_abs_imm1          $8357 (ratio_times10_capped) {bytecode}, $06
  $A097  2B                         STORE_quick   ; inline operand = 11
  $A098  D8 D8 A0                   JUMPF_abs              $A0D8
  $A09B  8E 9D F9                   PUSH_imm2              $F99D (msg_how_much_f99d)
  $A09E  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A0A2  8E A3 BC                   PUSH_imm2              $BCA3 (msg_rice_will_you_buy)
  $A0A5  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A0A9  3B                         PUSH_quick   ; inline operand = 11
  $A0AA  61                         PUSH_qimm   ; inline operand = 1
  $A0AB  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $A0AF  2A                         STORE_quick   ; inline operand = 10
  $A0B0  D8 E8 A0                   JUMPF_abs              $A0E8
  $A0B3  3A                         PUSH_quick   ; inline operand = 10
  $A0B4  AA 0D 6E                   PUSH_abs               $6E0D (gold_rice_exchange_rate)
  $A0B7  E9 03 83 04                CALL_abs_imm1          $8303 (math32_muladddiv) {bytecode}, $04
  $A0BB  B3                         PUSHL
  $A0BC  0C                         LOADL_quick   ; inline operand = 12
  $A0BD  B4                         POPR
  $A0BE  B3                         PUSHL
  $A0BF  B0                         DEREF
  $A0C0  BC                         SUB
  $A0C1  B1                         POPSTORE
  $A0C2  3A                         PUSH_quick   ; inline operand = 10
  $A0C3  0C                         LOADL_quick   ; inline operand = 12
  $A0C4  76                         ADD_qimm   ; inline operand = 6
  $A0C5  B4                         POPR
  $A0C6  B3                         PUSHL
  $A0C7  B0                         DEREF
  $A0C8  BB                         ADD
  $A0C9  B1                         POPSTORE
  $A0CA  0C                         LOADL_quick   ; inline operand = 12
  $A0CB  76                         ADD_qimm   ; inline operand = 6
  $A0CC  B3                         PUSHL
  $A0CD  E9 AC 82 02                CALL_abs_imm1          $82AC (clamp_amount_to_province_max) {bytecode}, $02
  $A0D1  62                         PUSH_qimm   ; inline operand = 2
  $A0D2  E9 4E 8A 02                CALL_abs_imm1          $8A4E (cycle_economy_rate) {bytecode}, $02
  $A0D6  41                         LOADL_qimm   ; inline operand = 1
  $A0D7  CF                         RETURN
 >$A0D8  8E B6 BC                   PUSH_imm2              $BCB6 (msg_storehouse_full)
  $A0DB  D6 E1 A0                   JUMP_abs               $A0E1
 >$A0DE  8E C6 BC                   PUSH_imm2              $BCC6 (msg_sorry_no_credit)
 >$A0E1  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A0E5  AC 59 D7                   CALL_abs               $D759 (standard_delay) {bytecode}
 >$A0E8  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $A0EB  40                         LOADL_qimm   ; inline operand = 0
  $A0EC  CF                         RETURN

; ============================================================
; sub $A0ED   (frame_off=-2, body @ $A0F2)
; ============================================================
  $A0F2  0C                         LOADL_quick   ; inline operand = 12
  $A0F3  8F 18                      BYTE_ADD_imm1          +24
  $A0F5  B0                         DEREF
  $A0F6  B3                         PUSHL
  $A0F7  65                         PUSH_qimm   ; inline operand = 5
  $A0F8  0C                         LOADL_quick   ; inline operand = 12
  $A0F9  8F 10                      BYTE_ADD_imm1          +16
  $A0FB  B0                         DEREF
  $A0FC  B3                         PUSHL
  $A0FD  0C                         LOADL_quick   ; inline operand = 12
  $A0FE  8F 16                      BYTE_ADD_imm1          +22
  $A100  B0                         DEREF
  $A101  B4                         POPR
  $A102  BB                         ADD
  $A103  B3                         PUSHL
  $A104  E9 B8 D6 06                CALL_abs_imm1          $D6B8 (math32_3arg) {bytecode}, $06
  $A108  2B                         STORE_quick   ; inline operand = 11
  $A109  0B                         LOADL_quick   ; inline operand = 11
  $A10A  D7 0F A1                   JUMPT_abs              $A10F
  $A10D  41                         LOADL_qimm   ; inline operand = 1
  $A10E  2B                         STORE_quick   ; inline operand = 11
 >$A10F  0D                         LOADL_quick   ; inline operand = 13
  $A110  1B                         LOADR_quick   ; inline operand = 11
  $A111  B6                         SDIV
  $A112  CF                         RETURN

; ============================================================
; sub $A113   (frame_off=-4, body @ $A118)
; ============================================================
  $A118  0C                         LOADL_quick   ; inline operand = 12
  $A119  8F 10                      BYTE_ADD_imm1          +16
  $A11B  B0                         DEREF
  $A11C  50                         LOADR_qimm   ; inline operand = 0
  $A11D  C3                         SCMPLE
  $A11E  D8 2D A1                   JUMPF_abs              $A12D
  $A121  8E D7 BC                   PUSH_imm2              $BCD7 (msg_weapons_for_who)
  $A124  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A128  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A12B  40                         LOADL_qimm   ; inline operand = 0
  $A12C  CF                         RETURN
 >$A12D  8E E9 BC                   PUSH_imm2              $BCE9 (msg_buy_arms_prompt)
  $A130  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A134  A4 0F 6E                   LOADL_abs              $6E0F (arms_buy_price_rate)
  $A137  79                         ADD_qimm   ; inline operand = 9
  $A138  5A                         LOADR_qimm   ; inline operand = 10
  $A139  B6                         SDIV
  $A13A  2B                         STORE_quick   ; inline operand = 11
  $A13B  0C                         LOADL_quick   ; inline operand = 12
  $A13C  B0                         DEREF
  $A13D  1B                         LOADR_quick   ; inline operand = 11
  $A13E  C5                         SCMPGE
  $A13F  D8 A0 A1                   JUMPF_abs              $A1A0
  $A142  0C                         LOADL_quick   ; inline operand = 12
  $A143  8F 16                      BYTE_ADD_imm1          +22
  $A145  B0                         DEREF
  $A146  B3                         PUSHL
  $A147  0C                         LOADL_quick   ; inline operand = 12
  $A148  8F 18                      BYTE_ADD_imm1          +24
  $A14A  B0                         DEREF
  $A14B  B4                         POPR
  $A14C  BC                         SUB
  $A14D  B3                         PUSHL
  $A14E  AA 0F 6E                   PUSH_abs               $6E0F (arms_buy_price_rate)
  $A151  0C                         LOADL_quick   ; inline operand = 12
  $A152  B0                         DEREF
  $A153  B3                         PUSHL
  $A154  E9 57 83 06                CALL_abs_imm1          $8357 (ratio_times10_capped) {bytecode}, $06
  $A158  2B                         STORE_quick   ; inline operand = 11
  $A159  D8 9A A1                   JUMPF_abs              $A19A
  $A15C  8E A6 F9                   PUSH_imm2              $F9A6 (msg_how_many)
  $A15F  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A163  3B                         PUSH_quick   ; inline operand = 11
  $A164  61                         PUSH_qimm   ; inline operand = 1
  $A165  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $A169  2A                         STORE_quick   ; inline operand = 10
  $A16A  D8 AA A1                   JUMPF_abs              $A1AA
  $A16D  3A                         PUSH_quick   ; inline operand = 10
  $A16E  AA 0F 6E                   PUSH_abs               $6E0F (arms_buy_price_rate)
  $A171  E9 03 83 04                CALL_abs_imm1          $8303 (math32_muladddiv) {bytecode}, $04
  $A175  B3                         PUSHL
  $A176  0C                         LOADL_quick   ; inline operand = 12
  $A177  B4                         POPR
  $A178  B3                         PUSHL
  $A179  B0                         DEREF
  $A17A  BC                         SUB
  $A17B  B1                         POPSTORE
  $A17C  3A                         PUSH_quick   ; inline operand = 10
  $A17D  3C                         PUSH_quick   ; inline operand = 12
  $A17E  E9 ED A0 04                CALL_abs_imm1          $A0ED (amount_div_force_factor) {bytecode}, $04
  $A182  B3                         PUSHL
  $A183  0C                         LOADL_quick   ; inline operand = 12
  $A184  8F 16                      BYTE_ADD_imm1          +22
  $A186  B4                         POPR
  $A187  B3                         PUSHL
  $A188  B0                         DEREF
  $A189  BB                         ADD
  $A18A  B1                         POPSTORE
  $A18B  0C                         LOADL_quick   ; inline operand = 12
  $A18C  8F 16                      BYTE_ADD_imm1          +22
  $A18E  B3                         PUSHL
  $A18F  E9 AC 82 02                CALL_abs_imm1          $82AC (clamp_amount_to_province_max) {bytecode}, $02
  $A193  63                         PUSH_qimm   ; inline operand = 3
  $A194  E9 4E 8A 02                CALL_abs_imm1          $8A4E (cycle_economy_rate) {bytecode}, $02
  $A198  41                         LOADL_qimm   ; inline operand = 1
  $A199  CF                         RETURN
 >$A19A  8E EA BC                   PUSH_imm2              $BCEA (msg_armory_full)
  $A19D  D6 A3 A1                   JUMP_abs               $A1A3
 >$A1A0  8E F6 BC                   PUSH_imm2              $BCF6 (msg_we_merchants_deal_only_in_cash)
 >$A1A3  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A1A7  AC 59 D7                   CALL_abs               $D759 (standard_delay) {bytecode}
 >$A1AA  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $A1AD  40                         LOADL_qimm   ; inline operand = 0
  $A1AE  CF                         RETURN

; ============================================================
; sub $A1AF   (frame_off=+0, body @ $A1B4)
; ============================================================
  $A1B4  40                         LOADL_qimm   ; inline operand = 0
  $A1B5  CF                         RETURN

; ============================================================
; sub $A1B6   (frame_off=-4, body @ $A1BB)
; ============================================================
  $A1BB  AC 15 8A                   CALL_abs               $8A15 (effect_trade) {bytecode}
  $A1BE  D8 49 A2                   JUMPF_abs              $A249
  $A1C1  AC 69 CC                   CALL_abs               $CC69 (clear_rect_right_panel) {bytecode}
  $A1C4  40                         LOADL_qimm   ; inline operand = 0
  $A1C5  D6 E9 A1                   JUMP_abs               $A1E9
 >$A1C8  0B                         LOADL_quick   ; inline operand = 11
  $A1C9  77                         ADD_qimm   ; inline operand = 7
  $A1CA  B3                         PUSHL
  $A1CB  8D 16                      BYTE_PUSH_imm1         +22
  $A1CD  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $A1D1  0B                         LOADL_quick   ; inline operand = 11
  $A1D2  D0                         INC
  $A1D3  B3                         PUSHL
  $A1D4  8E 15 BD                   PUSH_imm2              $BD15 (msg_fmt__2d_bd15)
  $A1D7  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $A1DB  0B                         LOADL_quick   ; inline operand = 11
  $A1DC  D2                         LSHIFT1
  $A1DD  8C 4F FF                   LOADR_imm2             $FF4F (trade_menu_str_ptrs)
  $A1E0  BB                         ADD
  $A1E1  B0                         DEREF
  $A1E2  B3                         PUSHL
  $A1E3  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A1E7  0B                         LOADL_quick   ; inline operand = 11
  $A1E8  D0                         INC
 >$A1E9  2B                         STORE_quick   ; inline operand = 11
  $A1EA  0B                         LOADL_quick   ; inline operand = 11
  $A1EB  56                         LOADR_qimm   ; inline operand = 6
  $A1EC  C2                         SCMPLT
  $A1ED  D7 C8 A1                   JUMPT_abs              $A1C8
 >$A1F0  8E 19 BD                   PUSH_imm2              $BD19 (msg_lord_how_may_i_serve_you)
  $A1F3  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A1F7  66                         PUSH_qimm   ; inline operand = 6
  $A1F8  E9 A6 B1 02                CALL_abs_imm1          $B1A6 (submenu_prompt) {bytecode}, $02
  $A1FC  2B                         STORE_quick   ; inline operand = 11
  $A1FD  D2                         LSHIFT1
  $A1FE  8C DC B9                   LOADR_imm2             $B9DC (jumptab_b9dc)
  $A201  BB                         ADD
  $A202  B0                         DEREF
  $A203  2A                         STORE_quick   ; inline operand = 10
  $A204  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $A207  8B 1A                      BYTE_LOADR_imm1        +26
  $A209  B5                         MULT
  $A20A  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A20D  BB                         ADD
  $A20E  B3                         PUSHL
  $A20F  0A                         LOADL_quick   ; inline operand = 10
  $A210  EA 02                      CALLPTR_imm1           $02
  $A212  D8 31 A2                   JUMPF_abs              $A231
  $A215  60                         PUSH_qimm   ; inline operand = 0
  $A216  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $A21A  8E 33 BD                   PUSH_imm2              $BD33 (msg_let_s_do_business_again)
  $A21D  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A221  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A224  0B                         LOADL_quick   ; inline operand = 11
  $A225  D7 2F A2                   JUMPT_abs              $A22F
  $A228  60                         PUSH_qimm   ; inline operand = 0
  $A229  E9 1E 87 02                CALL_abs_imm1          $871E (fief_info_display) {bytecode}, $02
  $A22D  40                         LOADL_qimm   ; inline operand = 0
  $A22E  CF                         RETURN
 >$A22F  41                         LOADL_qimm   ; inline operand = 1
  $A230  CF                         RETURN
 >$A231  0B                         LOADL_quick   ; inline operand = 11
  $A232  55                         LOADR_qimm   ; inline operand = 5
  $A233  C0                         CMPEQ
  $A234  D8 F0 A1                   JUMPF_abs              $A1F0
  $A237  8E 4B BD                   PUSH_imm2              $BD4B (msg_bye)
  $A23A  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A23E  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A241  60                         PUSH_qimm   ; inline operand = 0
  $A242  E9 1E 87 02                CALL_abs_imm1          $871E (fief_info_display) {bytecode}, $02
  $A246  D6 53 A2                   JUMP_abs               $A253
 >$A249  8E 69 FB                   PUSH_imm2              $FB69 (msg_no_merchant_in_the_area)
  $A24C  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A250  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$A253  40                         LOADL_qimm   ; inline operand = 0
  $A254  CF                         RETURN

; ============================================================
; sub $A255   (frame_off=+0, body @ $A25A)
; ============================================================
  $A25A  61                         PUSH_qimm   ; inline operand = 1
  $A25B  3D                         PUSH_quick   ; inline operand = 13
  $A25C  E9 CD CB 02                CALL_abs_imm1          $CBCD (sqrt_int) {native}, $02
  $A260  B3                         PUSHL
  $A261  3C                         PUSH_quick   ; inline operand = 12
  $A262  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $A266  B3                         PUSHL
  $A267  E9 6F CB 04                CALL_abs_imm1          $CB6F (max_word) {bytecode}, $04
  $A26B  B3                         PUSHL
  $A26C  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A270  D0                         INC
  $A271  55                         LOADR_qimm   ; inline operand = 5
  $A272  B5                         MULT
  $A273  CF                         RETURN

; ============================================================
; sub $A274   (frame_off=+0, body @ $A279)
; ============================================================
  $A279  3D                         PUSH_quick   ; inline operand = 13
  $A27A  0C                         LOADL_quick   ; inline operand = 12
  $A27B  57                         LOADR_qimm   ; inline operand = 7
  $A27C  C0                         CMPEQ
  $A27D  D8 86 A2                   JUMPF_abs              $A286
  $A280  8A 71 BD                   LOADL_imm2             $BD71 (msg_town_value)
  $A283  D6 8D A2                   JUMP_abs               $A28D
 >$A286  0C                         LOADL_quick   ; inline operand = 12
  $A287  D2                         LSHIFT1
  $A288  8C AE F8                   LOADR_imm2             $F8AE (fief_stat_name_ptrs)
  $A28B  BB                         ADD
  $A28C  B0                         DEREF
 >$A28D  B3                         PUSHL
  $A28E  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $A291  D0                         INC
  $A292  B3                         PUSHL
  $A293  8E 50 BD                   PUSH_imm2              $BD50 (msg_fief_d_s_s_has_declined_by_d)
  $A296  E9 34 D1 08                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $08
  $A29A  CF                         RETURN

; ============================================================
; sub $A29B   (frame_off=+0, body @ $A2A0)
; ============================================================
  $A2A0  61                         PUSH_qimm   ; inline operand = 1
  $A2A1  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $A2A4  74                         ADD_qimm   ; inline operand = 4
  $A2A5  B3                         PUSHL
  $A2A6  E9 12 CA 04                CALL_abs_imm1          $CA12 (deduct_byte_at) {bytecode}, $04
  $A2AA  8E 7C BD                   PUSH_imm2              $BD7C (msg_your_ninja_failed_bd7c)
  $A2AD  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A2B1  AC 59 D7                   CALL_abs               $D759 (standard_delay) {bytecode}
  $A2B4  3D                         PUSH_quick   ; inline operand = 13
  $A2B5  AA 13 6E                   PUSH_abs               $6E13 (hire_gold_rate)
  $A2B8  E9 03 83 04                CALL_abs_imm1          $8303 (math32_muladddiv) {bytecode}, $04
  $A2BC  B3                         PUSHL
  $A2BD  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $A2C0  8B 1A                      BYTE_LOADR_imm1        +26
  $A2C2  B5                         MULT
  $A2C3  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A2C6  BB                         ADD
  $A2C7  B4                         POPR
  $A2C8  B3                         PUSHL
  $A2C9  B0                         DEREF
  $A2CA  BC                         SUB
  $A2CB  B1                         POPSTORE
  $A2CC  65                         PUSH_qimm   ; inline operand = 5
  $A2CD  E9 4E 8A 02                CALL_abs_imm1          $8A4E (cycle_economy_rate) {bytecode}, $02
  $A2D1  CF                         RETURN

; ============================================================
; sub $A2D2   (frame_off=-10, body @ $A2D7)
; ============================================================
  $A2D7  0C                         LOADL_quick   ; inline operand = 12
  $A2D8  8F 18                      BYTE_ADD_imm1          +24
  $A2DA  B0                         DEREF
  $A2DB  B3                         PUSHL
  $A2DC  AA 13 6E                   PUSH_abs               $6E13 (hire_gold_rate)
  $A2DF  0C                         LOADL_quick   ; inline operand = 12
  $A2E0  B0                         DEREF
  $A2E1  B3                         PUSHL
  $A2E2  E9 57 83 06                CALL_abs_imm1          $8357 (ratio_times10_capped) {bytecode}, $06
  $A2E6  2B                         STORE_quick   ; inline operand = 11
  $A2E7  D8 60 A3                   JUMPF_abs              $A360
  $A2EA  8E A6 F9                   PUSH_imm2              $F9A6 (msg_how_many)
  $A2ED  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A2F1  3B                         PUSH_quick   ; inline operand = 11
  $A2F2  61                         PUSH_qimm   ; inline operand = 1
  $A2F3  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $A2F7  29                         STORE_quick   ; inline operand = 9
  $A2F8  D8 51 A5                   JUMPF_abs              $A551
  $A2FB  60                         PUSH_qimm   ; inline operand = 0
  $A2FC  E9 10 E5 02                CALL_abs_imm1          $E510 (build_eligible_province_list) {bytecode}, $02
  $A300  8E 89 6F                   PUSH_imm2              $6F89
  $A303  8E FF 00                   PUSH_imm2              $00FF
  $A306  E9 9F 87 04                CALL_abs_imm1          $879F (province_select_helper) {bytecode}, $04
  $A30A  D8 51 A5                   JUMPF_abs              $A551
  $A30D  8E C8 FA                   PUSH_imm2              $FAC8 (msg_send_where)
  $A310  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A314  8E 89 6F                   PUSH_imm2              $6F89
  $A317  E9 4C 80 02                CALL_abs_imm1          $804C (province_select_prompt) {bytecode}, $02
  $A31B  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $A31E  D8 51 A5                   JUMPF_abs              $A551
  $A321  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $A324  D1                         DEC
  $A325  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $A328  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $A32B  8E AE FB                   PUSH_imm2              $FBAE (msg_what_mission)
  $A32E  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A332  8E 8F BD                   PUSH_imm2              $BD8F (msg_uprisng_2_revolt_3_dams_4_assa)
  $A335  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A339  65                         PUSH_qimm   ; inline operand = 5
  $A33A  61                         PUSH_qimm   ; inline operand = 1
  $A33B  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $A33F  2A                         STORE_quick   ; inline operand = 10
  $A340  D8 51 A5                   JUMPF_abs              $A551
  $A343  0A                         LOADL_quick   ; inline operand = 10
  $A344  54                         LOADR_qimm   ; inline operand = 4
  $A345  C0                         CMPEQ
  $A346  D8 6C A3                   JUMPF_abs              $A36C
  $A349  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $A34C  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $A34F  BB                         ADD
  $A350  D3                         BYTE_DEREF
  $A351  D7 6C A3                   JUMPT_abs              $A36C
  $A354  8E BD BD                   PUSH_imm2              $BDBD (msg_the_daimyo_is_out)
  $A357  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A35B  AC 59 D7                   CALL_abs               $D759 (standard_delay) {bytecode}
  $A35E  40                         LOADL_qimm   ; inline operand = 0
  $A35F  CF                         RETURN
 >$A360  8E D9 FD                   PUSH_imm2              $FDD9 (msg_you_have_no_gold)
  $A363  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A367  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A36A  40                         LOADL_qimm   ; inline operand = 0
  $A36B  CF                         RETURN
 >$A36C  6C                         PUSH_qimm   ; inline operand = 12
  $A36D  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $A371  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $A374  8B 1A                      BYTE_LOADR_imm1        +26
  $A376  B5                         MULT
  $A377  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A37A  BB                         ADD
  $A37B  2C                         STORE_quick   ; inline operand = 12
  $A37C  8E CF BD                   PUSH_imm2              $BDCF (str_men_ninja_train_msgs)
  $A37F  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A383  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $A386  73                         ADD_qimm   ; inline operand = 3
  $A387  D3                         BYTE_DEREF
  $A388  8F 1E                      BYTE_ADD_imm1          +30
  $A38A  B3                         PUSHL
  $A38B  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $A38E  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $A392  73                         ADD_qimm   ; inline operand = 3
  $A393  D3                         BYTE_DEREF
  $A394  B4                         POPR
  $A395  C2                         SCMPLT
  $A396  D8 49 A5                   JUMPF_abs              $A549
  $A399  0A                         LOADL_quick   ; inline operand = 10
  $A39A  D5 FF FF 05 00 1D A4 AB A3 5A A4 97 ... SWITCH_contig          limit=5   ; .table 5 word targets (contiguous); SWITCH 1=>$A3AB 2=>$A45A 3=>$A497 4=>$A508 5=>$A510 default=>$A41D
 >$A3AB  0C                         LOADL_quick   ; inline operand = 12
  $A3AC  7C                         ADD_qimm   ; inline operand = 12
  $A3AD  B0                         DEREF
  $A3AE  D7 BF A3                   JUMPT_abs              $A3BF
  $A3B1  0C                         LOADL_quick   ; inline operand = 12
  $A3B2  7E                         ADD_qimm   ; inline operand = 14
  $A3B3  B0                         DEREF
  $A3B4  D7 BF A3                   JUMPT_abs              $A3BF
  $A3B7  39                         PUSH_quick   ; inline operand = 9
  $A3B8  38                         PUSH_quick   ; inline operand = 8
  $A3B9  E9 9B A2 04                CALL_abs_imm1          $A29B (effect_ninja_failed) {bytecode}, $04
  $A3BD  41                         LOADL_qimm   ; inline operand = 1
  $A3BE  CF                         RETURN
 >$A3BF  8D 1C                      BYTE_PUSH_imm1         +28
  $A3C1  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $A3C5  39                         PUSH_quick   ; inline operand = 9
  $A3C6  0C                         LOADL_quick   ; inline operand = 12
  $A3C7  7C                         ADD_qimm   ; inline operand = 12
  $A3C8  B0                         DEREF
  $A3C9  B3                         PUSHL
  $A3CA  E9 55 A2 04                CALL_abs_imm1          $A255 (hire_stat_drain_rng) {bytecode}, $04
  $A3CE  27                         STORE_quick   ; inline operand = 7
  $A3CF  0C                         LOADL_quick   ; inline operand = 12
  $A3D0  7C                         ADD_qimm   ; inline operand = 12
  $A3D1  B0                         DEREF
  $A3D2  17                         LOADR_quick   ; inline operand = 7
  $A3D3  C5                         SCMPGE
  $A3D4  D8 DB A3                   JUMPF_abs              $A3DB
  $A3D7  07                         LOADL_quick   ; inline operand = 7
  $A3D8  D6 DE A3                   JUMP_abs               $A3DE
 >$A3DB  0C                         LOADL_quick   ; inline operand = 12
  $A3DC  7C                         ADD_qimm   ; inline operand = 12
  $A3DD  B0                         DEREF
 >$A3DE  27                         STORE_quick   ; inline operand = 7
  $A3DF  07                         LOADL_quick   ; inline operand = 7
  $A3E0  D8 F1 A3                   JUMPF_abs              $A3F1
  $A3E3  37                         PUSH_quick   ; inline operand = 7
  $A3E4  0C                         LOADL_quick   ; inline operand = 12
  $A3E5  7C                         ADD_qimm   ; inline operand = 12
  $A3E6  B4                         POPR
  $A3E7  B3                         PUSHL
  $A3E8  B0                         DEREF
  $A3E9  BC                         SUB
  $A3EA  B1                         POPSTORE
  $A3EB  37                         PUSH_quick   ; inline operand = 7
  $A3EC  6C                         PUSH_qimm   ; inline operand = 12
  $A3ED  E9 74 A2 04                CALL_abs_imm1          $A274 (report_fief_stat_decline) {bytecode}, $04
 >$A3F1  39                         PUSH_quick   ; inline operand = 9
  $A3F2  0C                         LOADL_quick   ; inline operand = 12
  $A3F3  7E                         ADD_qimm   ; inline operand = 14
  $A3F4  B0                         DEREF
  $A3F5  B3                         PUSHL
  $A3F6  E9 55 A2 04                CALL_abs_imm1          $A255 (hire_stat_drain_rng) {bytecode}, $04
  $A3FA  27                         STORE_quick   ; inline operand = 7
  $A3FB  0C                         LOADL_quick   ; inline operand = 12
  $A3FC  7E                         ADD_qimm   ; inline operand = 14
  $A3FD  B0                         DEREF
  $A3FE  17                         LOADR_quick   ; inline operand = 7
  $A3FF  C5                         SCMPGE
  $A400  D8 07 A4                   JUMPF_abs              $A407
  $A403  07                         LOADL_quick   ; inline operand = 7
  $A404  D6 0A A4                   JUMP_abs               $A40A
 >$A407  0C                         LOADL_quick   ; inline operand = 12
  $A408  7E                         ADD_qimm   ; inline operand = 14
  $A409  B0                         DEREF
 >$A40A  27                         STORE_quick   ; inline operand = 7
  $A40B  07                         LOADL_quick   ; inline operand = 7
  $A40C  D8 1D A4                   JUMPF_abs              $A41D
  $A40F  37                         PUSH_quick   ; inline operand = 7
  $A410  0C                         LOADL_quick   ; inline operand = 12
  $A411  7E                         ADD_qimm   ; inline operand = 14
  $A412  B4                         POPR
  $A413  B3                         PUSHL
  $A414  B0                         DEREF
  $A415  BC                         SUB
  $A416  B1                         POPSTORE
  $A417  37                         PUSH_quick   ; inline operand = 7
  $A418  6D                         PUSH_qimm   ; inline operand = 13
 >$A419  E9 74 A2 04                CALL_abs_imm1          $A274 (report_fief_stat_decline) {bytecode}, $04
 >$A41D  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $A420  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $A424  0A                         LOADL_quick   ; inline operand = 10
  $A425  54                         LOADR_qimm   ; inline operand = 4
  $A426  C0                         CMPEQ
  $A427  D7 3B A4                   JUMPT_abs              $A43B
  $A42A  0A                         LOADL_quick   ; inline operand = 10
  $A42B  D8 3B A4                   JUMPF_abs              $A43B
  $A42E  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A431  8E BB FB                   PUSH_imm2              $FBBB (msg_enemy_morale_is_falling_to_pie)
  $A434  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A438  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$A43B  39                         PUSH_quick   ; inline operand = 9
  $A43C  AA 13 6E                   PUSH_abs               $6E13 (hire_gold_rate)
  $A43F  E9 03 83 04                CALL_abs_imm1          $8303 (math32_muladddiv) {bytecode}, $04
  $A443  B3                         PUSHL
  $A444  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $A447  8B 1A                      BYTE_LOADR_imm1        +26
  $A449  B5                         MULT
  $A44A  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A44D  BB                         ADD
  $A44E  B4                         POPR
  $A44F  B3                         PUSHL
  $A450  B0                         DEREF
  $A451  BC                         SUB
  $A452  B1                         POPSTORE
  $A453  65                         PUSH_qimm   ; inline operand = 5
  $A454  E9 4E 8A 02                CALL_abs_imm1          $8A4E (cycle_economy_rate) {bytecode}, $02
  $A458  41                         LOADL_qimm   ; inline operand = 1
  $A459  CF                         RETURN
 >$A45A  39                         PUSH_quick   ; inline operand = 9
  $A45B  0C                         LOADL_quick   ; inline operand = 12
  $A45C  8F 12                      BYTE_ADD_imm1          +18
  $A45E  B0                         DEREF
  $A45F  B3                         PUSHL
  $A460  E9 55 A2 04                CALL_abs_imm1          $A255 (hire_stat_drain_rng) {bytecode}, $04
  $A464  27                         STORE_quick   ; inline operand = 7
  $A465  0C                         LOADL_quick   ; inline operand = 12
  $A466  8F 12                      BYTE_ADD_imm1          +18
  $A468  B0                         DEREF
  $A469  17                         LOADR_quick   ; inline operand = 7
  $A46A  C5                         SCMPGE
  $A46B  D8 72 A4                   JUMPF_abs              $A472
  $A46E  07                         LOADL_quick   ; inline operand = 7
  $A46F  D6 76 A4                   JUMP_abs               $A476
 >$A472  0C                         LOADL_quick   ; inline operand = 12
  $A473  8F 12                      BYTE_ADD_imm1          +18
  $A475  B0                         DEREF
 >$A476  27                         STORE_quick   ; inline operand = 7
  $A477  07                         LOADL_quick   ; inline operand = 7
  $A478  D7 83 A4                   JUMPT_abs              $A483
  $A47B  39                         PUSH_quick   ; inline operand = 9
  $A47C  38                         PUSH_quick   ; inline operand = 8
  $A47D  E9 9B A2 04                CALL_abs_imm1          $A29B (effect_ninja_failed) {bytecode}, $04
  $A481  41                         LOADL_qimm   ; inline operand = 1
  $A482  CF                         RETURN
 >$A483  8D 1B                      BYTE_PUSH_imm1         +27
  $A485  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $A489  37                         PUSH_quick   ; inline operand = 7
  $A48A  0C                         LOADL_quick   ; inline operand = 12
  $A48B  8F 12                      BYTE_ADD_imm1          +18
  $A48D  B4                         POPR
  $A48E  B3                         PUSHL
  $A48F  B0                         DEREF
  $A490  BC                         SUB
  $A491  B1                         POPSTORE
  $A492  37                         PUSH_quick   ; inline operand = 7
  $A493  6F                         PUSH_qimm   ; inline operand = 15
  $A494  D6 19 A4                   JUMP_abs               $A419
 >$A497  0C                         LOADL_quick   ; inline operand = 12
  $A498  7A                         ADD_qimm   ; inline operand = 10
  $A499  B0                         DEREF
  $A49A  D7 AB A4                   JUMPT_abs              $A4AB
  $A49D  0C                         LOADL_quick   ; inline operand = 12
  $A49E  76                         ADD_qimm   ; inline operand = 6
  $A49F  B0                         DEREF
  $A4A0  D7 AB A4                   JUMPT_abs              $A4AB
  $A4A3  39                         PUSH_quick   ; inline operand = 9
  $A4A4  38                         PUSH_quick   ; inline operand = 8
  $A4A5  E9 9B A2 04                CALL_abs_imm1          $A29B (effect_ninja_failed) {bytecode}, $04
  $A4A9  41                         LOADL_qimm   ; inline operand = 1
  $A4AA  CF                         RETURN
 >$A4AB  8D 1E                      BYTE_PUSH_imm1         +30
  $A4AD  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $A4B1  39                         PUSH_quick   ; inline operand = 9
  $A4B2  0C                         LOADL_quick   ; inline operand = 12
  $A4B3  7A                         ADD_qimm   ; inline operand = 10
  $A4B4  B0                         DEREF
  $A4B5  B3                         PUSHL
  $A4B6  E9 55 A2 04                CALL_abs_imm1          $A255 (hire_stat_drain_rng) {bytecode}, $04
  $A4BA  27                         STORE_quick   ; inline operand = 7
  $A4BB  0C                         LOADL_quick   ; inline operand = 12
  $A4BC  7A                         ADD_qimm   ; inline operand = 10
  $A4BD  B0                         DEREF
  $A4BE  17                         LOADR_quick   ; inline operand = 7
  $A4BF  C5                         SCMPGE
  $A4C0  D8 C7 A4                   JUMPF_abs              $A4C7
  $A4C3  07                         LOADL_quick   ; inline operand = 7
  $A4C4  D6 CA A4                   JUMP_abs               $A4CA
 >$A4C7  0C                         LOADL_quick   ; inline operand = 12
  $A4C8  7A                         ADD_qimm   ; inline operand = 10
  $A4C9  B0                         DEREF
 >$A4CA  27                         STORE_quick   ; inline operand = 7
  $A4CB  07                         LOADL_quick   ; inline operand = 7
  $A4CC  D8 DD A4                   JUMPF_abs              $A4DD
  $A4CF  37                         PUSH_quick   ; inline operand = 7
  $A4D0  0C                         LOADL_quick   ; inline operand = 12
  $A4D1  7A                         ADD_qimm   ; inline operand = 10
  $A4D2  B4                         POPR
  $A4D3  B3                         PUSHL
  $A4D4  B0                         DEREF
  $A4D5  BC                         SUB
  $A4D6  B1                         POPSTORE
  $A4D7  37                         PUSH_quick   ; inline operand = 7
  $A4D8  6B                         PUSH_qimm   ; inline operand = 11
  $A4D9  E9 74 A2 04                CALL_abs_imm1          $A274 (report_fief_stat_decline) {bytecode}, $04
 >$A4DD  39                         PUSH_quick   ; inline operand = 9
  $A4DE  0C                         LOADL_quick   ; inline operand = 12
  $A4DF  76                         ADD_qimm   ; inline operand = 6
  $A4E0  B0                         DEREF
  $A4E1  B3                         PUSHL
  $A4E2  E9 55 A2 04                CALL_abs_imm1          $A255 (hire_stat_drain_rng) {bytecode}, $04
  $A4E6  27                         STORE_quick   ; inline operand = 7
  $A4E7  0C                         LOADL_quick   ; inline operand = 12
  $A4E8  76                         ADD_qimm   ; inline operand = 6
  $A4E9  B0                         DEREF
  $A4EA  17                         LOADR_quick   ; inline operand = 7
  $A4EB  C5                         SCMPGE
  $A4EC  D8 F3 A4                   JUMPF_abs              $A4F3
  $A4EF  07                         LOADL_quick   ; inline operand = 7
  $A4F0  D6 F6 A4                   JUMP_abs               $A4F6
 >$A4F3  0C                         LOADL_quick   ; inline operand = 12
  $A4F4  76                         ADD_qimm   ; inline operand = 6
  $A4F5  B0                         DEREF
 >$A4F6  27                         STORE_quick   ; inline operand = 7
  $A4F7  07                         LOADL_quick   ; inline operand = 7
  $A4F8  D8 1D A4                   JUMPF_abs              $A41D
  $A4FB  37                         PUSH_quick   ; inline operand = 7
  $A4FC  0C                         LOADL_quick   ; inline operand = 12
  $A4FD  76                         ADD_qimm   ; inline operand = 6
  $A4FE  B4                         POPR
  $A4FF  B3                         PUSHL
  $A500  B0                         DEREF
  $A501  BC                         SUB
  $A502  B1                         POPSTORE
  $A503  37                         PUSH_quick   ; inline operand = 7
  $A504  69                         PUSH_qimm   ; inline operand = 9
  $A505  D6 19 A4                   JUMP_abs               $A419
 >$A508  39                         PUSH_quick   ; inline operand = 9
  $A509  E9 8D 91 02                CALL_abs_imm1          $918D (ninja_mission_resolve_vs_defender) {bytecode}, $02
  $A50D  D6 1D A4                   JUMP_abs               $A41D
 >$A510  39                         PUSH_quick   ; inline operand = 9
  $A511  0C                         LOADL_quick   ; inline operand = 12
  $A512  74                         ADD_qimm   ; inline operand = 4
  $A513  B0                         DEREF
  $A514  B3                         PUSHL
  $A515  E9 55 A2 04                CALL_abs_imm1          $A255 (hire_stat_drain_rng) {bytecode}, $04
  $A519  27                         STORE_quick   ; inline operand = 7
  $A51A  0C                         LOADL_quick   ; inline operand = 12
  $A51B  74                         ADD_qimm   ; inline operand = 4
  $A51C  B0                         DEREF
  $A51D  17                         LOADR_quick   ; inline operand = 7
  $A51E  C5                         SCMPGE
  $A51F  D8 26 A5                   JUMPF_abs              $A526
  $A522  07                         LOADL_quick   ; inline operand = 7
  $A523  D6 29 A5                   JUMP_abs               $A529
 >$A526  0C                         LOADL_quick   ; inline operand = 12
  $A527  74                         ADD_qimm   ; inline operand = 4
  $A528  B0                         DEREF
 >$A529  27                         STORE_quick   ; inline operand = 7
  $A52A  07                         LOADL_quick   ; inline operand = 7
  $A52B  D7 36 A5                   JUMPT_abs              $A536
  $A52E  39                         PUSH_quick   ; inline operand = 9
  $A52F  38                         PUSH_quick   ; inline operand = 8
  $A530  E9 9B A2 04                CALL_abs_imm1          $A29B (effect_ninja_failed) {bytecode}, $04
  $A534  41                         LOADL_qimm   ; inline operand = 1
  $A535  CF                         RETURN
 >$A536  8D 1D                      BYTE_PUSH_imm1         +29
  $A538  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $A53C  37                         PUSH_quick   ; inline operand = 7
  $A53D  0C                         LOADL_quick   ; inline operand = 12
  $A53E  74                         ADD_qimm   ; inline operand = 4
  $A53F  B4                         POPR
  $A540  B3                         PUSHL
  $A541  B0                         DEREF
  $A542  BC                         SUB
  $A543  B1                         POPSTORE
  $A544  37                         PUSH_quick   ; inline operand = 7
  $A545  67                         PUSH_qimm   ; inline operand = 7
  $A546  D6 19 A4                   JUMP_abs               $A419
 >$A549  39                         PUSH_quick   ; inline operand = 9
  $A54A  38                         PUSH_quick   ; inline operand = 8
  $A54B  E9 9B A2 04                CALL_abs_imm1          $A29B (effect_ninja_failed) {bytecode}, $04
  $A54F  41                         LOADL_qimm   ; inline operand = 1
  $A550  CF                         RETURN
 >$A551  40                         LOADL_qimm   ; inline operand = 0
  $A552  CF                         RETURN

; ============================================================
; sub $A553   (frame_off=-6, body @ $A558)
; ============================================================
  $A558  0C                         LOADL_quick   ; inline operand = 12
  $A559  8F 10                      BYTE_ADD_imm1          +16
  $A55B  B0                         DEREF
  $A55C  B3                         PUSHL
  $A55D  0C                         LOADL_quick   ; inline operand = 12
  $A55E  8F 18                      BYTE_ADD_imm1          +24
  $A560  B0                         DEREF
  $A561  B4                         POPR
  $A562  BC                         SUB
  $A563  29                         STORE_quick   ; inline operand = 9
  $A564  B3                         PUSHL
  $A565  AA 11 6E                   PUSH_abs               $6E11 (gold_men_hire_rate)
  $A568  0C                         LOADL_quick   ; inline operand = 12
  $A569  B0                         DEREF
  $A56A  B3                         PUSHL
  $A56B  E9 57 83 06                CALL_abs_imm1          $8357 (ratio_times10_capped) {bytecode}, $06
  $A56F  2B                         STORE_quick   ; inline operand = 11
  $A570  D8 DD A5                   JUMPF_abs              $A5DD
  $A573  8E A6 F9                   PUSH_imm2              $F9A6 (msg_how_many)
  $A576  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A57A  3B                         PUSH_quick   ; inline operand = 11
  $A57B  61                         PUSH_qimm   ; inline operand = 1
  $A57C  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $A580  2A                         STORE_quick   ; inline operand = 10
  $A581  D8 F2 A5                   JUMPF_abs              $A5F2
  $A584  3A                         PUSH_quick   ; inline operand = 10
  $A585  AA 11 6E                   PUSH_abs               $6E11 (gold_men_hire_rate)
  $A588  E9 03 83 04                CALL_abs_imm1          $8303 (math32_muladddiv) {bytecode}, $04
  $A58C  B3                         PUSHL
  $A58D  0C                         LOADL_quick   ; inline operand = 12
  $A58E  B4                         POPR
  $A58F  B3                         PUSHL
  $A590  B0                         DEREF
  $A591  BC                         SUB
  $A592  B1                         POPSTORE
  $A593  3A                         PUSH_quick   ; inline operand = 10
  $A594  3C                         PUSH_quick   ; inline operand = 12
  $A595  E9 F4 8B 04                CALL_abs_imm1          $8BF4 (apply_hire_unit_stats) {bytecode}, $04
  $A599  3C                         PUSH_quick   ; inline operand = 12
  $A59A  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $A59D  E9 FE DF 04                CALL_abs_imm1          $DFFE (cap_arms_at_index) {bytecode}, $04
  $A5A1  64                         PUSH_qimm   ; inline operand = 4
  $A5A2  E9 4E 8A 02                CALL_abs_imm1          $8A4E (cycle_economy_rate) {bytecode}, $02
  $A5A6  0C                         LOADL_quick   ; inline operand = 12
  $A5A7  8F 10                      BYTE_ADD_imm1          +16
  $A5A9  B3                         PUSHL
  $A5AA  E9 AC 82 02                CALL_abs_imm1          $82AC (clamp_amount_to_province_max) {bytecode}, $02
  $A5AE  8D 21                      BYTE_PUSH_imm1         +33
  $A5B0  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $A5B4  8E D0 BD                   PUSH_imm2              $BDD0 (msg_men_or_ninja)
  $A5B7  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A5BB  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $A5BE  8B 1A                      BYTE_LOADR_imm1        +26
  $A5C0  B5                         MULT
  $A5C1  8C 11 70                   LOADR_imm2             $7011
  $A5C4  BB                         ADD
  $A5C5  B0                         DEREF
  $A5C6  B3                         PUSHL
  $A5C7  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $A5CA  59                         LOADR_qimm   ; inline operand = 9
  $A5CB  B5                         MULT
  $A5CC  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $A5CF  BB                         ADD
  $A5D0  B3                         PUSHL
  $A5D1  8E 90 FB                   PUSH_imm2              $FB90 (msg_lord_s_we_now_have_d_men)
  $A5D4  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $A5D8  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A5DB  41                         LOADL_qimm   ; inline operand = 1
  $A5DC  CF                         RETURN
 >$A5DD  09                         LOADL_quick   ; inline operand = 9
  $A5DE  D8 E7 A5                   JUMPF_abs              $A5E7
  $A5E1  8A D9 FD                   LOADL_imm2             $FDD9 (msg_you_have_no_gold)
  $A5E4  D6 EA A5                   JUMP_abs               $A5EA
 >$A5E7  8A C6 FD                   LOADL_imm2             $FDC6 (msg_we_re_at_our_limit)
 >$A5EA  B3                         PUSHL
  $A5EB  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A5EF  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$A5F2  40                         LOADL_qimm   ; inline operand = 0
  $A5F3  CF                         RETURN

; ============================================================
; sub $A5F4   (frame_off=-4, body @ $A5F9)
; ============================================================
  $A5F9  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $A5FC  E9 51 93 02                CALL_abs_imm1          $9351 (effect_war_combat_prep_c) {bytecode}, $02
  $A600  D8 35 A6                   JUMPF_abs              $A635
  $A603  8E 81 FB                   PUSH_imm2              $FB81 (msg_recruit_which)
  $A606  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A60A  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $A60D  8B 1A                      BYTE_LOADR_imm1        +26
  $A60F  B5                         MULT
  $A610  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A613  BB                         ADD
  $A614  2B                         STORE_quick   ; inline operand = 11
  $A615  8E D1 BD                   PUSH_imm2              $BDD1 (msg_men_ninja)
  $A618  E9 51 D3 02                CALL_abs_imm1          $D351 (prompt_ab_window) {bytecode}, $02
  $A61C  D9 02 00 00 00 29 A6 01 00 2F A6 35 ... SWITCH_noncontig       count=2   ; .table 2 (key,target) + default (noncontiguous); SWITCH 0=>$A629 1=>$A62F default=>$A635
 >$A629  3B                         PUSH_quick   ; inline operand = 11
  $A62A  E9 D2 A2 02                CALL_abs_imm1          $A2D2 (effect_ninja_sabotage) {bytecode}, $02
  $A62E  CF                         RETURN
 >$A62F  3B                         PUSH_quick   ; inline operand = 11
  $A630  E9 53 A5 02                CALL_abs_imm1          $A553 (effect_hire_men) {bytecode}, $02
  $A634  CF                         RETURN
 >$A635  40                         LOADL_qimm   ; inline operand = 0
  $A636  CF                         RETURN

; ============================================================
; sub $A637   (frame_off=-2, body @ $A63C)
; ============================================================
  $A63C  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $A63F  8B 1A                      BYTE_LOADR_imm1        +26
  $A641  B5                         MULT
  $A642  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A645  BB                         ADD
  $A646  2B                         STORE_quick   ; inline operand = 11
  $A647  0B                         LOADL_quick   ; inline operand = 11
  $A648  8F 18                      BYTE_ADD_imm1          +24
  $A64A  B0                         DEREF
  $A64B  B3                         PUSHL
  $A64C  0B                         LOADL_quick   ; inline operand = 11
  $A64D  8F 14                      BYTE_ADD_imm1          +20
  $A64F  B0                         DEREF
  $A650  B4                         POPR
  $A651  C2                         SCMPLT
  $A652  D8 A7 A6                   JUMPF_abs              $A6A7
  $A655  0B                         LOADL_quick   ; inline operand = 11
  $A656  8F 10                      BYTE_ADD_imm1          +16
  $A658  B0                         DEREF
  $A659  50                         LOADR_qimm   ; inline operand = 0
  $A65A  C3                         SCMPLE
  $A65B  D8 71 A6                   JUMPF_abs              $A671
  $A65E  8E FD FD                   PUSH_imm2              $FDFD (msg_you_have_no_soldiers)
  $A661  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A665  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $A668  E9 15 D8 02                CALL_abs_imm1          $D815 (clear_military_stats_if_no_men) {bytecode}, $02
  $A66C  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A66F  40                         LOADL_qimm   ; inline operand = 0
  $A670  CF                         RETURN
 >$A671  6A                         PUSH_qimm   ; inline operand = 10
  $A672  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $A676  AC 86 95                   CALL_abs               $9586 (effect_train) {bytecode}
  $A679  0B                         LOADL_quick   ; inline operand = 11
  $A67A  8F 14                      BYTE_ADD_imm1          +20
  $A67C  B3                         PUSHL
  $A67D  0B                         LOADL_quick   ; inline operand = 11
  $A67E  8F 18                      BYTE_ADD_imm1          +24
  $A680  B0                         DEREF
  $A681  B3                         PUSHL
  $A682  0B                         LOADL_quick   ; inline operand = 11
  $A683  8F 14                      BYTE_ADD_imm1          +20
  $A685  B0                         DEREF
  $A686  B4                         POPR
  $A687  C4                         SCMPGT
  $A688  D8 91 A6                   JUMPF_abs              $A691
  $A68B  0B                         LOADL_quick   ; inline operand = 11
  $A68C  8F 18                      BYTE_ADD_imm1          +24
  $A68E  D6 94 A6                   JUMP_abs               $A694
 >$A691  0B                         LOADL_quick   ; inline operand = 11
  $A692  8F 14                      BYTE_ADD_imm1          +20
 >$A694  B0                         DEREF
  $A695  B1                         POPSTORE
  $A696  0B                         LOADL_quick   ; inline operand = 11
  $A697  8F 14                      BYTE_ADD_imm1          +20
  $A699  B0                         DEREF
  $A69A  B3                         PUSHL
  $A69B  8E DE FB                   PUSH_imm2              $FBDE (msg_skill_is_now_d)
  $A69E  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $A6A2  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A6A5  41                         LOADL_qimm   ; inline operand = 1
  $A6A6  CF                         RETURN
 >$A6A7  8E E0 BD                   PUSH_imm2              $BDE0 (msg_the_men_can_t_train_any_furthe)
  $A6AA  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A6AE  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A6B1  40                         LOADL_qimm   ; inline operand = 0
  $A6B2  CF                         RETURN

; ============================================================
; sub $A6B3   (frame_off=+0, body @ $A6B8)
; ============================================================
  $A6B8  0C                         LOADL_quick   ; inline operand = 12
  $A6B9  75                         ADD_qimm   ; inline operand = 5
  $A6BA  D3                         BYTE_DEREF
  $A6BB  B3                         PUSHL
  $A6BC  0C                         LOADL_quick   ; inline operand = 12
  $A6BD  73                         ADD_qimm   ; inline operand = 3
  $A6BE  D3                         BYTE_DEREF
  $A6BF  B3                         PUSHL
  $A6C0  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A6C4  B4                         POPR
  $A6C5  BB                         ADD
  $A6C6  CF                         RETURN

; ============================================================
; sub $A6C7   (frame_off=-10, body @ $A6CC)
; ============================================================
  $A6CC  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $A6CF  28                         STORE_quick   ; inline operand = 8
 >$A6D0  40                         LOADL_qimm   ; inline operand = 0
  $A6D1  27                         STORE_quick   ; inline operand = 7
  $A6D2  61                         PUSH_qimm   ; inline operand = 1
  $A6D3  E9 10 E5 02                CALL_abs_imm1          $E510 (build_eligible_province_list) {bytecode}, $02
  $A6D7  29                         STORE_quick   ; inline operand = 9
  $A6D8  D8 DD A6                   JUMPF_abs              $A6DD
  $A6DB  41                         LOADL_qimm   ; inline operand = 1
  $A6DC  27                         STORE_quick   ; inline operand = 7
 >$A6DD  07                         LOADL_quick   ; inline operand = 7
  $A6DE  D7 13 A7                   JUMPT_abs              $A713
  $A6E1  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $A6E4  8B 1A                      BYTE_LOADR_imm1        +26
  $A6E6  B5                         MULT
  $A6E7  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A6EA  BB                         ADD
  $A6EB  B0                         DEREF
  $A6EC  5A                         LOADR_qimm   ; inline operand = 10
  $A6ED  C2                         SCMPLT
  $A6EE  D8 13 A7                   JUMPF_abs              $A713
  $A6F1  8E D9 FD                   PUSH_imm2              $FDD9 (msg_you_have_no_gold)
  $A6F4  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A6F8  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A6FB  40                         LOADL_qimm   ; inline operand = 0
  $A6FC  CF                         RETURN
 >$A6FD  08                         LOADL_quick   ; inline operand = 8
  $A6FE  8C D8 FE                   LOADR_imm2             $FED8 (province_to_map_section_17)
  $A701  D6 53 A7                   JUMP_abs               $A753
 >$A704  0A                         LOADL_quick   ; inline operand = 10
  $A705  8B 63                      BYTE_LOADR_imm1        +99
  $A707  C0                         CMPEQ
  $A708  D8 6C A7                   JUMPF_abs              $A76C
  $A70B  AC EA 85                   CALL_abs               $85EA (effect_view_b) {bytecode}
  $A70E  38                         PUSH_quick   ; inline operand = 8
  $A70F  E9 FA 83 02                CALL_abs_imm1          $83FA (effect_view_a) {bytecode}, $02
 >$A713  8E EF FB                   PUSH_imm2              $FBEF (msg_view_which_fief)
  $A716  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A71A  61                         PUSH_qimm   ; inline operand = 1
  $A71B  E9 10 E5 02                CALL_abs_imm1          $E510 (build_eligible_province_list) {bytecode}, $02
  $A71F  29                         STORE_quick   ; inline operand = 9
  $A720  D8 2C A7                   JUMPF_abs              $A72C
  $A723  8E 00 BE                   PUSH_imm2              $BE00 (msg_view_vassals)
  $A726  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A72A  41                         LOADL_qimm   ; inline operand = 1
  $A72B  27                         STORE_quick   ; inline operand = 7
 >$A72C  41                         LOADL_qimm   ; inline operand = 1
  $A72D  A8 E0 7B                   STORE_abs              $7BE0 (ui_input_prompt_active_flag)
  $A730  8D 63                      BYTE_PUSH_imm1         +99
  $A732  61                         PUSH_qimm   ; inline operand = 1
  $A733  E9 9D D5 04                CALL_abs_imm1          $D59D (select_province_by_cursor) {bytecode}, $04
  $A737  2A                         STORE_quick   ; inline operand = 10
  $A738  40                         LOADL_qimm   ; inline operand = 0
  $A739  A8 E0 7B                   STORE_abs              $7BE0 (ui_input_prompt_active_flag)
  $A73C  0A                         LOADL_quick   ; inline operand = 10
  $A73D  8B FF                      BYTE_LOADR_imm1        -1
  $A73F  C0                         CMPEQ
  $A740  D8 68 A7                   JUMPF_abs              $A768
  $A743  AC 20 CD                   CALL_abs               $CD20 (repaint_screen) {bytecode}
  $A746  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $A749  8B 32                      BYTE_LOADR_imm1        +50
  $A74B  C0                         CMPEQ
  $A74C  D8 FD A6                   JUMPF_abs              $A6FD
  $A74F  08                         LOADL_quick   ; inline operand = 8
  $A750  8C A6 FE                   LOADR_imm2             $FEA6 (province_to_map_section_50)
 >$A753  BB                         ADD
  $A754  D3                         BYTE_DEREF
  $A755  2B                         STORE_quick   ; inline operand = 11
  $A756  B3                         PUSHL
  $A757  E9 F2 E5 02                CALL_abs_imm1          $E5F2 (render_map_section) {bytecode}, $02
  $A75B  3B                         PUSH_quick   ; inline operand = 11
  $A75C  E9 10 AF 02                CALL_abs_imm1          $AF10 (browse_map_sections) {bytecode}, $02
  $A760  38                         PUSH_quick   ; inline operand = 8
  $A761  E9 FA 83 02                CALL_abs_imm1          $83FA (effect_view_a) {bytecode}, $02
  $A765  D6 D0 A6                   JUMP_abs               $A6D0
 >$A768  09                         LOADL_quick   ; inline operand = 9
  $A769  D7 04 A7                   JUMPT_abs              $A704
 >$A76C  0A                         LOADL_quick   ; inline operand = 10
  $A76D  D8 7A A7                   JUMPF_abs              $A77A
  $A770  0A                         LOADL_quick   ; inline operand = 10
  $A771  D1                         DEC
  $A772  2A                         STORE_quick   ; inline operand = 10
  $A773  A6 5F 6F                   LOADR_abs              $6F5F (selected_province_idx)
  $A776  C0                         CMPEQ
  $A777  D8 87 A7                   JUMPF_abs              $A787
 >$A77A  08                         LOADL_quick   ; inline operand = 8
  $A77B  A6 5F 6F                   LOADR_abs              $6F5F (selected_province_idx)
  $A77E  C0                         CMPEQ
  $A77F  D8 C0 A7                   JUMPF_abs              $A7C0
  $A782  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
 >$A785  40                         LOADL_qimm   ; inline operand = 0
  $A786  CF                         RETURN
 >$A787  0A                         LOADL_quick   ; inline operand = 10
  $A788  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $A78B  C6                         UCMPLT
  $A78C  D8 13 A7                   JUMPF_abs              $A713
  $A78F  3A                         PUSH_quick   ; inline operand = 10
  $A790  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $A794  B3                         PUSHL
  $A795  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $A798  B4                         POPR
  $A799  C1                         CMPNE
  $A79A  D8 33 A8                   JUMPF_abs              $A833
  $A79D  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $A7A0  8B 1A                      BYTE_LOADR_imm1        +26
  $A7A2  B5                         MULT
  $A7A3  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A7A6  BB                         ADD
  $A7A7  B0                         DEREF
  $A7A8  5A                         LOADR_qimm   ; inline operand = 10
  $A7A9  C2                         SCMPLT
  $A7AA  D8 C6 A7                   JUMPF_abs              $A7C6
  $A7AD  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $A7B0  8E D9 FD                   PUSH_imm2              $FDD9 (msg_you_have_no_gold)
  $A7B3  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A7B7  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A7BA  07                         LOADL_quick   ; inline operand = 7
  $A7BB  51                         LOADR_qimm   ; inline operand = 1
  $A7BC  C0                         CMPEQ
  $A7BD  D7 13 A7                   JUMPT_abs              $A713
 >$A7C0  AC A7 85                   CALL_abs               $85A7 (effect_view_c) {bytecode}
  $A7C3  D6 85 A7                   JUMP_abs               $A785
 >$A7C6  6A                         PUSH_qimm   ; inline operand = 10
  $A7C7  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $A7CA  8B 1A                      BYTE_LOADR_imm1        +26
  $A7CC  B5                         MULT
  $A7CD  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A7D0  BB                         ADD
  $A7D1  B4                         POPR
  $A7D2  B3                         PUSHL
  $A7D3  B0                         DEREF
  $A7D4  BC                         SUB
  $A7D5  B1                         POPSTORE
  $A7D6  08                         LOADL_quick   ; inline operand = 8
  $A7D7  A6 5F 6F                   LOADR_abs              $6F5F (selected_province_idx)
  $A7DA  C0                         CMPEQ
  $A7DB  D8 F5 A7                   JUMPF_abs              $A7F5
  $A7DE  67                         PUSH_qimm   ; inline operand = 7
  $A7DF  8D 10                      BYTE_PUSH_imm1         +16
  $A7E1  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $A7E5  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $A7E8  8B 1A                      BYTE_LOADR_imm1        +26
  $A7EA  B5                         MULT
  $A7EB  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A7EE  BB                         ADD
  $A7EF  B0                         DEREF
  $A7F0  B3                         PUSHL
  $A7F1  E9 C7 83 02                CALL_abs_imm1          $83C7 (draw_selected_province_stat) {bytecode}, $02
 >$A7F5  3A                         PUSH_quick   ; inline operand = 10
  $A7F6  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $A7FA  B3                         PUSHL
  $A7FB  E9 B3 A6 02                CALL_abs_imm1          $A6B3 (effect_view_d) {bytecode}, $02
  $A7FF  B3                         PUSHL
  $A800  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $A803  B3                         PUSHL
  $A804  E9 B3 A6 02                CALL_abs_imm1          $A6B3 (effect_view_d) {bytecode}, $02
  $A808  B4                         POPR
  $A809  C4                         SCMPGT
  $A80A  D8 17 A8                   JUMPF_abs              $A817
  $A80D  AA 63 6D                   PUSH_abs               $6D63 (const_two)
  $A810  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A814  D8 2B A8                   JUMPF_abs              $A82B
 >$A817  63                         PUSH_qimm   ; inline operand = 3
  $A818  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $A81C  D7 2B A8                   JUMPT_abs              $A82B
  $A81F  3A                         PUSH_quick   ; inline operand = 10
  $A820  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $A824  8C FF 00                   LOADR_imm2             $00FF
  $A827  C0                         CMPEQ
  $A828  D8 43 A8                   JUMPF_abs              $A843
 >$A82B  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $A82E  6E                         PUSH_qimm   ; inline operand = 14
  $A82F  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
 >$A833  0A                         LOADL_quick   ; inline operand = 10
  $A834  18                         LOADR_quick   ; inline operand = 8
  $A835  C1                         CMPNE
  $A836  D8 13 A7                   JUMPF_abs              $A713
  $A839  3A                         PUSH_quick   ; inline operand = 10
  $A83A  E9 FA 83 02                CALL_abs_imm1          $83FA (effect_view_a) {bytecode}, $02
  $A83E  0A                         LOADL_quick   ; inline operand = 10
  $A83F  28                         STORE_quick   ; inline operand = 8
  $A840  D6 13 A7                   JUMP_abs               $A713
 >$A843  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $A846  8E 01 FC                   PUSH_imm2              $FC01 (msg_our_spy_was_caught)
  $A849  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A84D  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A850  D6 13 A7                   JUMP_abs               $A713

; ============================================================
; sub $A853   (frame_off=-4, body @ $A858)
; ============================================================
  $A858  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $A85B  8B 1A                      BYTE_LOADR_imm1        +26
  $A85D  B5                         MULT
  $A85E  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $A861  BB                         ADD
  $A862  2B                         STORE_quick   ; inline operand = 11
  $A863  0B                         LOADL_quick   ; inline operand = 11
  $A864  74                         ADD_qimm   ; inline operand = 4
  $A865  B0                         DEREF
  $A866  B3                         PUSHL
  $A867  0B                         LOADL_quick   ; inline operand = 11
  $A868  8F 18                      BYTE_ADD_imm1          +24
  $A86A  B0                         DEREF
  $A86B  B4                         POPR
  $A86C  C3                         SCMPLE
  $A86D  D8 7C A8                   JUMPF_abs              $A87C
  $A870  8E C6 FD                   PUSH_imm2              $FDC6 (msg_we_re_at_our_limit)
  $A873  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A877  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A87A  40                         LOADL_qimm   ; inline operand = 0
  $A87B  CF                         RETURN
 >$A87C  0B                         LOADL_quick   ; inline operand = 11
  $A87D  B0                         DEREF
  $A87E  D8 C6 A8                   JUMPF_abs              $A8C6
  $A881  8E 13 BE                   PUSH_imm2              $BE13 (str_town_value_label)
  $A884  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A888  0B                         LOADL_quick   ; inline operand = 11
  $A889  74                         ADD_qimm   ; inline operand = 4
  $A88A  B0                         DEREF
  $A88B  B3                         PUSHL
  $A88C  8E 14 BE                   PUSH_imm2              $BE14 (msg_town_value_be14)
  $A88F  8E 25 FB                   PUSH_imm2              $FB25 (msg_s_is_d_spend_how_much_on_it)
  $A892  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $A896  0B                         LOADL_quick   ; inline operand = 11
  $A897  B0                         DEREF
  $A898  B3                         PUSHL
  $A899  61                         PUSH_qimm   ; inline operand = 1
  $A89A  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $A89E  2A                         STORE_quick   ; inline operand = 10
  $A89F  D8 D2 A8                   JUMPF_abs              $A8D2
  $A8A2  3A                         PUSH_quick   ; inline operand = 10
  $A8A3  0B                         LOADL_quick   ; inline operand = 11
  $A8A4  B4                         POPR
  $A8A5  B3                         PUSHL
  $A8A6  B0                         DEREF
  $A8A7  BC                         SUB
  $A8A8  B1                         POPSTORE
  $A8A9  3A                         PUSH_quick   ; inline operand = 10
  $A8AA  3B                         PUSH_quick   ; inline operand = 11
  $A8AB  E9 A6 88 04                CALL_abs_imm1          $88A6 (effect_build) {bytecode}, $04
  $A8AF  2A                         STORE_quick   ; inline operand = 10
  $A8B0  8D 18                      BYTE_PUSH_imm1         +24
  $A8B2  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $A8B6  0B                         LOADL_quick   ; inline operand = 11
  $A8B7  74                         ADD_qimm   ; inline operand = 4
  $A8B8  B0                         DEREF
  $A8B9  B3                         PUSHL
  $A8BA  8E 14 FC                   PUSH_imm2              $FC14 (msg_town_value_is_now_d)
  $A8BD  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $A8C1  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A8C4  41                         LOADL_qimm   ; inline operand = 1
  $A8C5  CF                         RETURN
 >$A8C6  8E D9 FD                   PUSH_imm2              $FDD9 (msg_you_have_no_gold)
  $A8C9  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A8CD  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A8D0  40                         LOADL_qimm   ; inline operand = 0
  $A8D1  CF                         RETURN
 >$A8D2  CF                         RETURN

; ============================================================
; sub $A8D3   (frame_off=-4, body @ $A8D8)
; ============================================================
  $A8D8  0D                         LOADL_quick   ; inline operand = 13
  $A8D9  51                         LOADR_qimm   ; inline operand = 1
  $A8DA  C0                         CMPEQ
  $A8DB  D8 E2 A8                   JUMPF_abs              $A8E2
  $A8DE  0C                         LOADL_quick   ; inline operand = 12
  $A8DF  D6 E4 A8                   JUMP_abs               $A8E4
 >$A8E2  0C                         LOADL_quick   ; inline operand = 12
  $A8E3  76                         ADD_qimm   ; inline operand = 6
 >$A8E4  2B                         STORE_quick   ; inline operand = 11
  $A8E5  8E A8 FD                   PUSH_imm2              $FDA8 (msg_give_how_much)
  $A8E8  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A8EC  0B                         LOADL_quick   ; inline operand = 11
  $A8ED  B0                         DEREF
  $A8EE  B3                         PUSHL
  $A8EF  61                         PUSH_qimm   ; inline operand = 1
  $A8F0  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $A8F4  2A                         STORE_quick   ; inline operand = 10
  $A8F5  D8 1C A9                   JUMPF_abs              $A91C
  $A8F8  3A                         PUSH_quick   ; inline operand = 10
  $A8F9  0B                         LOADL_quick   ; inline operand = 11
  $A8FA  B4                         POPR
  $A8FB  B3                         PUSHL
  $A8FC  B0                         DEREF
  $A8FD  BC                         SUB
  $A8FE  B1                         POPSTORE
  $A8FF  0E                         LOADL_quick   ; inline operand = 14
  $A900  51                         LOADR_qimm   ; inline operand = 1
  $A901  C0                         CMPEQ
  $A902  D8 14 A9                   JUMPF_abs              $A914
  $A905  3A                         PUSH_quick   ; inline operand = 10
  $A906  3C                         PUSH_quick   ; inline operand = 12
  $A907  E9 1D 89 04                CALL_abs_imm1          $891D (develop_loyalty) {bytecode}, $04
  $A90B  3A                         PUSH_quick   ; inline operand = 10
  $A90C  3C                         PUSH_quick   ; inline operand = 12
  $A90D  E9 6F 89 04                CALL_abs_imm1          $896F (develop_wealth) {bytecode}, $04
  $A911  D6 1A A9                   JUMP_abs               $A91A
 >$A914  3A                         PUSH_quick   ; inline operand = 10
  $A915  3C                         PUSH_quick   ; inline operand = 12
  $A916  E9 C1 89 04                CALL_abs_imm1          $89C1 (develop_morale) {bytecode}, $04
 >$A91A  41                         LOADL_qimm   ; inline operand = 1
  $A91B  CF                         RETURN
 >$A91C  40                         LOADL_qimm   ; inline operand = 0
  $A91D  CF                         RETURN

; ============================================================
; sub $A91E   (frame_off=-2, body @ $A923)
; ============================================================
  $A923  40                         LOADL_qimm   ; inline operand = 0
  $A924  2B                         STORE_quick   ; inline operand = 11
  $A925  0D                         LOADL_quick   ; inline operand = 13
  $A926  50                         LOADR_qimm   ; inline operand = 0
  $A927  C4                         SCMPGT
  $A928  D8 2D A9                   JUMPF_abs              $A92D
  $A92B  42                         LOADL_qimm   ; inline operand = 2
  $A92C  2B                         STORE_quick   ; inline operand = 11
 >$A92D  0C                         LOADL_quick   ; inline operand = 12
  $A92E  50                         LOADR_qimm   ; inline operand = 0
  $A92F  C4                         SCMPGT
  $A930  D8 38 A9                   JUMPF_abs              $A938
  $A933  41                         LOADL_qimm   ; inline operand = 1
  $A934  CD                         SWAP
  $A935  0B                         LOADL_quick   ; inline operand = 11
  $A936  DB                         OR
  $A937  2B                         STORE_quick   ; inline operand = 11
 >$A938  0B                         LOADL_quick   ; inline operand = 11
  $A939  CF                         RETURN

; ============================================================
; sub $A93A   (frame_off=+0, body @ $A93F)
; ============================================================
  $A93F  0C                         LOADL_quick   ; inline operand = 12
  $A940  8F 10                      BYTE_ADD_imm1          +16
  $A942  B0                         DEREF
  $A943  B3                         PUSHL
  $A944  0C                         LOADL_quick   ; inline operand = 12
  $A945  78                         ADD_qimm   ; inline operand = 8
  $A946  B0                         DEREF
  $A947  B3                         PUSHL
  $A948  E9 1E A9 04                CALL_abs_imm1          $A91E (give_eligibility_flags) {bytecode}, $04
  $A94C  CF                         RETURN

; ============================================================
; sub $A94D   (frame_off=+0, body @ $A952)
; ============================================================
  $A952  0C                         LOADL_quick   ; inline operand = 12
  $A953  76                         ADD_qimm   ; inline operand = 6
  $A954  B0                         DEREF
  $A955  B3                         PUSHL
  $A956  0C                         LOADL_quick   ; inline operand = 12
  $A957  B0                         DEREF
  $A958  B3                         PUSHL
  $A959  E9 1E A9 04                CALL_abs_imm1          $A91E (give_eligibility_flags) {bytecode}, $04
  $A95D  CF                         RETURN

; ============================================================
; sub $A95E   (frame_off=-4, body @ $A963)
; ============================================================
  $A963  3C                         PUSH_quick   ; inline operand = 12
  $A964  E9 4D A9 02                CALL_abs_imm1          $A94D (give_rice_gold_eligibility) {bytecode}, $02
  $A968  2B                         STORE_quick   ; inline operand = 11
  $A969  D8 BB A9                   JUMPF_abs              $A9BB
  $A96C  0B                         LOADL_quick   ; inline operand = 11
  $A96D  2A                         STORE_quick   ; inline operand = 10
  $A96E  8E 1F BE                   PUSH_imm2              $BE1F (str_gold_rice_prompt)
  $A971  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A975  8E 20 BE                   PUSH_imm2              $BE20 (msg_gold_rice)
  $A978  E9 51 D3 02                CALL_abs_imm1          $D351 (prompt_ab_window) {bytecode}, $02
  $A97C  2B                         STORE_quick   ; inline operand = 11
  $A97D  0B                         LOADL_quick   ; inline operand = 11
  $A97E  D7 85 A9                   JUMPT_abs              $A985
  $A981  42                         LOADL_qimm   ; inline operand = 2
  $A982  D6 8C A9                   JUMP_abs               $A98C
 >$A985  0B                         LOADL_quick   ; inline operand = 11
  $A986  52                         LOADR_qimm   ; inline operand = 2
  $A987  C0                         CMPEQ
  $A988  D8 8D A9                   JUMPF_abs              $A98D
  $A98B  40                         LOADL_qimm   ; inline operand = 0
 >$A98C  2B                         STORE_quick   ; inline operand = 11
 >$A98D  0B                         LOADL_quick   ; inline operand = 11
  $A98E  D8 AF A9                   JUMPF_abs              $A9AF
  $A991  0A                         LOADL_quick   ; inline operand = 10
  $A992  1B                         LOADR_quick   ; inline operand = 11
  $A993  DA                         AND
  $A994  D7 AF A9                   JUMPT_abs              $A9AF
  $A997  0A                         LOADL_quick   ; inline operand = 10
  $A998  D1                         DEC
  $A999  2A                         STORE_quick   ; inline operand = 10
  $A99A  D8 A3 A9                   JUMPF_abs              $A9A3
  $A99D  8E D9 FD                   PUSH_imm2              $FDD9 (msg_you_have_no_gold)
  $A9A0  D6 A6 A9                   JUMP_abs               $A9A6
 >$A9A3  8E EB FD                   PUSH_imm2              $FDEB (msg_you_have_no_rice)
 >$A9A6  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A9AA  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $A9AD  40                         LOADL_qimm   ; inline operand = 0
  $A9AE  CF                         RETURN
 >$A9AF  0B                         LOADL_quick   ; inline operand = 11
  $A9B0  D8 D3 A9                   JUMPF_abs              $A9D3
  $A9B3  3D                         PUSH_quick   ; inline operand = 13
  $A9B4  3B                         PUSH_quick   ; inline operand = 11
  $A9B5  3C                         PUSH_quick   ; inline operand = 12
  $A9B6  E9 D3 A8 06                CALL_abs_imm1          $A8D3 (give_transfer_apply) {bytecode}, $06
  $A9BA  CF                         RETURN
 >$A9BB  8E D9 FD                   PUSH_imm2              $FDD9 (msg_you_have_no_gold)
  $A9BE  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A9C2  8E 2E BE                   PUSH_imm2              $BE2E (str_peasants_men_prompt_nl)
  $A9C5  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A9C9  8E EB FD                   PUSH_imm2              $FDEB (msg_you_have_no_rice)
  $A9CC  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $A9D0  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$A9D3  40                         LOADL_qimm   ; inline operand = 0
  $A9D4  CF                         RETURN

; ============================================================
; sub $A9D5   (frame_off=-2, body @ $A9DA)
; ============================================================
  $A9DA  3C                         PUSH_quick   ; inline operand = 12
  $A9DB  E9 3A A9 02                CALL_abs_imm1          $A93A (effect_give_a) {bytecode}, $02
  $A9DF  2B                         STORE_quick   ; inline operand = 11
  $A9E0  D8 05 AA                   JUMPF_abs              $AA05
  $A9E3  8E 30 BE                   PUSH_imm2              $BE30 (str_peasants_men_prompt)
  $A9E6  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $A9EA  8E 31 BE                   PUSH_imm2              $BE31 (msg_peasnts_men)
  $A9ED  E9 51 D3 02                CALL_abs_imm1          $D351 (prompt_ab_window) {bytecode}, $02
  $A9F1  2B                         STORE_quick   ; inline operand = 11
  $A9F2  0B                         LOADL_quick   ; inline operand = 11
  $A9F3  D7 FB A9                   JUMPT_abs              $A9FB
  $A9F6  42                         LOADL_qimm   ; inline operand = 2
 >$A9F7  2B                         STORE_quick   ; inline operand = 11
  $A9F8  D6 1D AA                   JUMP_abs               $AA1D
 >$A9FB  0B                         LOADL_quick   ; inline operand = 11
  $A9FC  52                         LOADR_qimm   ; inline operand = 2
  $A9FD  C0                         CMPEQ
  $A9FE  D8 1D AA                   JUMPF_abs              $AA1D
  $AA01  40                         LOADL_qimm   ; inline operand = 0
  $AA02  D6 F7 A9                   JUMP_abs               $A9F7
 >$AA05  8E FD FD                   PUSH_imm2              $FDFD (msg_you_have_no_soldiers)
  $AA08  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AA0C  8E 41 BE                   PUSH_imm2              $BE41 (str_amount_available_fields)
  $AA0F  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AA13  8E 13 FE                   PUSH_imm2              $FE13 (msg_you_have_no_peasants)
  $AA16  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AA1A  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$AA1D  0B                         LOADL_quick   ; inline operand = 11
  $AA1E  CF                         RETURN

; ============================================================
; sub $AA1F   (frame_off=-6, body @ $AA24)
; ============================================================
  $AA24  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $AA27  8B 1A                      BYTE_LOADR_imm1        +26
  $AA29  B5                         MULT
  $AA2A  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $AA2D  BB                         ADD
  $AA2E  29                         STORE_quick   ; inline operand = 9
  $AA2F  39                         PUSH_quick   ; inline operand = 9
  $AA30  E9 3A A9 02                CALL_abs_imm1          $A93A (effect_give_a) {bytecode}, $02
  $AA34  2A                         STORE_quick   ; inline operand = 10
  $AA35  39                         PUSH_quick   ; inline operand = 9
  $AA36  E9 D5 A9 02                CALL_abs_imm1          $A9D5 (effect_give_c) {bytecode}, $02
  $AA3A  2B                         STORE_quick   ; inline operand = 11
  $AA3B  D8 AC AA                   JUMPF_abs              $AAAC
  $AA3E  0A                         LOADL_quick   ; inline operand = 10
  $AA3F  1B                         LOADR_quick   ; inline operand = 11
  $AA40  DA                         AND
  $AA41  D7 5C AA                   JUMPT_abs              $AA5C
  $AA44  0A                         LOADL_quick   ; inline operand = 10
  $AA45  D1                         DEC
  $AA46  2A                         STORE_quick   ; inline operand = 10
  $AA47  D8 50 AA                   JUMPF_abs              $AA50
  $AA4A  8E 13 FE                   PUSH_imm2              $FE13 (msg_you_have_no_peasants)
  $AA4D  D6 53 AA                   JUMP_abs               $AA53
 >$AA50  8E FD FD                   PUSH_imm2              $FDFD (msg_you_have_no_soldiers)
 >$AA53  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AA57  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $AA5A  40                         LOADL_qimm   ; inline operand = 0
  $AA5B  CF                         RETURN
 >$AA5C  09                         LOADL_quick   ; inline operand = 9
  $AA5D  8F 18                      BYTE_ADD_imm1          +24
  $AA5F  B0                         DEREF
  $AA60  B3                         PUSHL
  $AA61  0B                         LOADL_quick   ; inline operand = 11
  $AA62  51                         LOADR_qimm   ; inline operand = 1
  $AA63  C0                         CMPEQ
  $AA64  D8 75 AA                   JUMPF_abs              $AA75
  $AA67  09                         LOADL_quick   ; inline operand = 9
  $AA68  7E                         ADD_qimm   ; inline operand = 14
  $AA69  B0                         DEREF
  $AA6A  B3                         PUSHL
  $AA6B  09                         LOADL_quick   ; inline operand = 9
  $AA6C  7C                         ADD_qimm   ; inline operand = 12
  $AA6D  B0                         DEREF
  $AA6E  B4                         POPR
  $AA6F  BB                         ADD
  $AA70  52                         LOADR_qimm   ; inline operand = 2
  $AA71  B6                         SDIV
  $AA72  D6 79 AA                   JUMP_abs               $AA79
 >$AA75  09                         LOADL_quick   ; inline operand = 9
  $AA76  8F 12                      BYTE_ADD_imm1          +18
  $AA78  B0                         DEREF
 >$AA79  B4                         POPR
  $AA7A  C5                         SCMPGE
  $AA7B  D8 8A AA                   JUMPF_abs              $AA8A
  $AA7E  8E C6 FD                   PUSH_imm2              $FDC6 (msg_we_re_at_our_limit)
  $AA81  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AA85  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $AA88  40                         LOADL_qimm   ; inline operand = 0
  $AA89  CF                         RETURN
 >$AA8A  3B                         PUSH_quick   ; inline operand = 11
  $AA8B  39                         PUSH_quick   ; inline operand = 9
  $AA8C  E9 5E A9 04                CALL_abs_imm1          $A95E (effect_give_b) {bytecode}, $04
  $AA90  D8 AC AA                   JUMPF_abs              $AAAC
  $AA93  66                         PUSH_qimm   ; inline operand = 6
  $AA94  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $AA98  AC EA D7                   CALL_abs               $D7EA (selected_province_daimyo_record) {bytecode}
  $AA9B  74                         ADD_qimm   ; inline operand = 4
  $AA9C  B3                         PUSHL
  $AA9D  D3                         BYTE_DEREF
  $AA9E  D0                         INC
  $AA9F  D4                         BYTE_POPSTORE
  $AAA0  8E B6 FD                   PUSH_imm2              $FDB6 (msg_thank_you_lord)
  $AAA3  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AAA7  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $AAAA  41                         LOADL_qimm   ; inline operand = 1
  $AAAB  CF                         RETURN
 >$AAAC  40                         LOADL_qimm   ; inline operand = 0
  $AAAD  CF                         RETURN

; ============================================================
; sub $AAAE   (frame_off=-4, body @ $AAB3)
; ============================================================
  $AAB3  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $AAB6  8B 1A                      BYTE_LOADR_imm1        +26
  $AAB8  B5                         MULT
  $AAB9  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $AABC  BB                         ADD
  $AABD  2B                         STORE_quick   ; inline operand = 11
  $AABE  0B                         LOADL_quick   ; inline operand = 11
  $AABF  B0                         DEREF
  $AAC0  5A                         LOADR_qimm   ; inline operand = 10
  $AAC1  C4                         SCMPGT
  $AAC2  D8 16 AB                   JUMPF_abs              $AB16
  $AAC5  60                         PUSH_qimm   ; inline operand = 0
  $AAC6  E9 10 E5 02                CALL_abs_imm1          $E510 (build_eligible_province_list) {bytecode}, $02
  $AACA  8E 89 6F                   PUSH_imm2              $6F89
  $AACD  6F                         PUSH_qimm   ; inline operand = 15
  $AACE  E9 9F 87 04                CALL_abs_imm1          $879F (province_select_helper) {bytecode}, $04
  $AAD2  D8 20 AB                   JUMPF_abs              $AB20
  $AAD5  8E 97 FE                   PUSH_imm2              $FE97 (msg_bribe_which)
  $AAD8  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AADC  8E 89 6F                   PUSH_imm2              $6F89
  $AADF  E9 4C 80 02                CALL_abs_imm1          $804C (province_select_prompt) {bytecode}, $02
  $AAE3  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $AAE6  D8 20 AB                   JUMPF_abs              $AB20
  $AAE9  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $AAEC  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $AAEF  D1                         DEC
  $AAF0  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $AAF3  8E 29 FC                   PUSH_imm2              $FC29 (msg_gold_for_spy)
  $AAF6  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AAFA  0B                         LOADL_quick   ; inline operand = 11
  $AAFB  B0                         DEREF
  $AAFC  8F F6                      BYTE_ADD_imm1          -10
  $AAFE  B3                         PUSHL
  $AAFF  61                         PUSH_qimm   ; inline operand = 1
  $AB00  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $AB04  2A                         STORE_quick   ; inline operand = 10
  $AB05  D8 20 AB                   JUMPF_abs              $AB20
  $AB08  6A                         PUSH_qimm   ; inline operand = 10
  $AB09  0B                         LOADL_quick   ; inline operand = 11
  $AB0A  B4                         POPR
  $AB0B  B3                         PUSHL
  $AB0C  B0                         DEREF
  $AB0D  BC                         SUB
  $AB0E  B1                         POPSTORE
  $AB0F  3A                         PUSH_quick   ; inline operand = 10
  $AB10  E9 4D 8D 02                CALL_abs_imm1          $8D4D (effect_bribe) {bytecode}, $02
  $AB14  41                         LOADL_qimm   ; inline operand = 1
  $AB15  CF                         RETURN
 >$AB16  8E D9 FD                   PUSH_imm2              $FDD9 (msg_you_have_no_gold)
  $AB19  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AB1D  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$AB20  40                         LOADL_qimm   ; inline operand = 0
  $AB21  CF                         RETURN

; ============================================================
; sub $AB22   (frame_off=-4, body @ $AB27)
; ============================================================
  $AB27  40                         LOADL_qimm   ; inline operand = 0
  $AB28  2B                         STORE_quick   ; inline operand = 11
 >$AB29  0B                         LOADL_quick   ; inline operand = 11
  $AB2A  D2                         LSHIFT1
  $AB2B  1D                         LOADR_quick   ; inline operand = 13
  $AB2C  BB                         ADD
  $AB2D  B3                         PUSHL
  $AB2E  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $AB31  55                         LOADR_qimm   ; inline operand = 5
  $AB32  B5                         MULT
  $AB33  1B                         LOADR_quick   ; inline operand = 11
  $AB34  BB                         ADD
  $AB35  8C A9 76                   LOADR_imm2             $76A9 (province_unit_type_pct)
  $AB38  BB                         ADD
  $AB39  D3                         BYTE_DEREF
  $AB3A  B1                         POPSTORE
  $AB3B  0B                         LOADL_quick   ; inline operand = 11
  $AB3C  8F 14                      BYTE_ADD_imm1          +20
  $AB3E  B3                         PUSHL
  $AB3F  6E                         PUSH_qimm   ; inline operand = 14
  $AB40  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $AB44  0B                         LOADL_quick   ; inline operand = 11
  $AB45  D2                         LSHIFT1
  $AB46  1D                         LOADR_quick   ; inline operand = 13
  $AB47  BB                         ADD
  $AB48  B0                         DEREF
  $AB49  8C 0F 27                   LOADR_imm2             $270F
  $AB4C  C4                         SCMPGT
  $AB4D  D8 59 AB                   JUMPF_abs              $AB59
  $AB50  0B                         LOADL_quick   ; inline operand = 11
  $AB51  D2                         LSHIFT1
  $AB52  1D                         LOADR_quick   ; inline operand = 13
  $AB53  BB                         ADD
  $AB54  B3                         PUSHL
  $AB55  8A 0F 27                   LOADL_imm2             $270F
  $AB58  B1                         POPSTORE
 >$AB59  0B                         LOADL_quick   ; inline operand = 11
  $AB5A  D2                         LSHIFT1
  $AB5B  1D                         LOADR_quick   ; inline operand = 13
  $AB5C  BB                         ADD
  $AB5D  B0                         DEREF
  $AB5E  B3                         PUSHL
  $AB5F  8E 43 BE                   PUSH_imm2              $BE43 (msg_fmt__3d_be43)
  $AB62  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $AB66  0B                         LOADL_quick   ; inline operand = 11
  $AB67  8F 14                      BYTE_ADD_imm1          +20
  $AB69  B3                         PUSHL
  $AB6A  65                         PUSH_qimm   ; inline operand = 5
  $AB6B  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $AB6F  0B                         LOADL_quick   ; inline operand = 11
  $AB70  D9 02 00 01 00 7D AB 02 00 B5 AB B9 ... SWITCH_noncontig       count=2   ; .table 2 (key,target) + default (noncontiguous); SWITCH 1=>$AB7D 2=>$ABB5 default=>$ABB9
 >$AB7D  42                         LOADL_qimm   ; inline operand = 2
 >$AB7E  2A                         STORE_quick   ; inline operand = 10
  $AB7F  0A                         LOADL_quick   ; inline operand = 10
  $AB80  D2                         LSHIFT1
  $AB81  8C AF F9                   LOADR_imm2             $F9AF (unit_type_name_table)
  $AB84  BB                         ADD
  $AB85  B0                         DEREF
  $AB86  B3                         PUSHL
  $AB87  0B                         LOADL_quick   ; inline operand = 11
  $AB88  D0                         INC
  $AB89  B3                         PUSHL
  $AB8A  8E 47 BE                   PUSH_imm2              $BE47 (msg_d_s)
  $AB8D  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $AB91  8D 19                      BYTE_PUSH_imm1         +25
  $AB93  65                         PUSH_qimm   ; inline operand = 5
  $AB94  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $AB98  8E 4C BE                   PUSH_imm2              $BE4C (msg_available_0)
  $AB9B  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AB9F  8D 14                      BYTE_PUSH_imm1         +20
  $ABA1  64                         PUSH_qimm   ; inline operand = 4
  $ABA2  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $ABA6  62                         PUSH_qimm   ; inline operand = 2
  $ABA7  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $ABAB  0B                         LOADL_quick   ; inline operand = 11
  $ABAC  D0                         INC
  $ABAD  2B                         STORE_quick   ; inline operand = 11
  $ABAE  0B                         LOADL_quick   ; inline operand = 11
  $ABAF  55                         LOADR_qimm   ; inline operand = 5
  $ABB0  C6                         UCMPLT
  $ABB1  D7 29 AB                   JUMPT_abs              $AB29
  $ABB4  CF                         RETURN
 >$ABB5  40                         LOADL_qimm   ; inline operand = 0
  $ABB6  D6 7E AB                   JUMP_abs               $AB7E
 >$ABB9  41                         LOADL_qimm   ; inline operand = 1
  $ABBA  D6 7E AB                   JUMP_abs               $AB7E

; ============================================================
; sub $ABBD   (frame_off=-6, body @ $ABC2)
; ============================================================
  $ABC2  40                         LOADL_qimm   ; inline operand = 0
  $ABC3  29                         STORE_quick   ; inline operand = 9
  $ABC4  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $ABC7  55                         LOADR_qimm   ; inline operand = 5
  $ABC8  B5                         MULT
  $ABC9  8C A9 76                   LOADR_imm2             $76A9 (province_unit_type_pct)
  $ABCC  BB                         ADD
  $ABCD  2A                         STORE_quick   ; inline operand = 10
  $ABCE  40                         LOADL_qimm   ; inline operand = 0
  $ABCF  2B                         STORE_quick   ; inline operand = 11
 >$ABD0  0B                         LOADL_quick   ; inline operand = 11
  $ABD1  D2                         LSHIFT1
  $ABD2  1C                         LOADR_quick   ; inline operand = 12
  $ABD3  BB                         ADD
  $ABD4  B0                         DEREF
  $ABD5  B3                         PUSHL
  $ABD6  0A                         LOADL_quick   ; inline operand = 10
  $ABD7  1B                         LOADR_quick   ; inline operand = 11
  $ABD8  BB                         ADD
  $ABD9  D3                         BYTE_DEREF
  $ABDA  B4                         POPR
  $ABDB  C1                         CMPNE
  $ABDC  D8 E1 AB                   JUMPF_abs              $ABE1
  $ABDF  41                         LOADL_qimm   ; inline operand = 1
  $ABE0  29                         STORE_quick   ; inline operand = 9
 >$ABE1  0B                         LOADL_quick   ; inline operand = 11
  $ABE2  D0                         INC
  $ABE3  2B                         STORE_quick   ; inline operand = 11
  $ABE4  0B                         LOADL_quick   ; inline operand = 11
  $ABE5  55                         LOADR_qimm   ; inline operand = 5
  $ABE6  C6                         UCMPLT
  $ABE7  D7 D0 AB                   JUMPT_abs              $ABD0
  $ABEA  0D                         LOADL_quick   ; inline operand = 13
  $ABEB  D7 F2 AB                   JUMPT_abs              $ABF2
  $ABEE  09                         LOADL_quick   ; inline operand = 9
  $ABEF  D7 F4 AB                   JUMPT_abs              $ABF4
 >$ABF2  40                         LOADL_qimm   ; inline operand = 0
  $ABF3  CF                         RETURN
 >$ABF4  40                         LOADL_qimm   ; inline operand = 0
  $ABF5  2B                         STORE_quick   ; inline operand = 11
 >$ABF6  0A                         LOADL_quick   ; inline operand = 10
  $ABF7  1B                         LOADR_quick   ; inline operand = 11
  $ABF8  BB                         ADD
  $ABF9  B3                         PUSHL
  $ABFA  0B                         LOADL_quick   ; inline operand = 11
  $ABFB  D2                         LSHIFT1
  $ABFC  1C                         LOADR_quick   ; inline operand = 12
  $ABFD  BB                         ADD
  $ABFE  B0                         DEREF
  $ABFF  D4                         BYTE_POPSTORE
  $AC00  0B                         LOADL_quick   ; inline operand = 11
  $AC01  D0                         INC
  $AC02  2B                         STORE_quick   ; inline operand = 11
  $AC03  0B                         LOADL_quick   ; inline operand = 11
  $AC04  55                         LOADR_qimm   ; inline operand = 5
  $AC05  C6                         UCMPLT
  $AC06  D7 F6 AB                   JUMPT_abs              $ABF6
  $AC09  8D 16                      BYTE_PUSH_imm1         +22
  $AC0B  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $AC0F  41                         LOADL_qimm   ; inline operand = 1
  $AC10  CF                         RETURN

; ============================================================
; sub $AC11   (frame_off=-18, body @ $AC16)
; ============================================================
  $AC16  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $AC19  8B 1A                      BYTE_LOADR_imm1        +26
  $AC1B  B5                         MULT
  $AC1C  8C 17 70                   LOADR_imm2             $7017
  $AC1F  BB                         ADD
  $AC20  23                         STORE_quick   ; inline operand = 3
  $AC21  DE F0 FF                   LEAL_far               $FFF0
  $AC24  B3                         PUSHL
  $AC25  3C                         PUSH_quick   ; inline operand = 12
  $AC26  E9 22 AB 04                CALL_abs_imm1          $AB22 (render_arms_edit_screen) {bytecode}, $04
  $AC2A  AC 87 D2                   CALL_abs               $D287 (wait_button_edge) {bytecode}
  $AC2D  89 14                      BYTE_LOADL_imm1        +20
  $AC2F  29                         STORE_quick   ; inline operand = 9
  $AC30  40                         LOADL_qimm   ; inline operand = 0
  $AC31  2A                         STORE_quick   ; inline operand = 10
  $AC32  2B                         STORE_quick   ; inline operand = 11
 >$AC33  AC 4E D1                   CALL_abs               $D14E (poll_input) {bytecode}
  $AC36  D9 06 00 01 00 4B AD 02 00 5D AD 10 ... SWITCH_noncontig       count=6   ; .table 6 (key,target) + default (noncontiguous); SWITCH 1=>$AD4B 2=>$AD5D 16=>$AC92 32=>$ACFA 64=>$AC53 128=>$AC7B default=>$AC33
 >$AC53  60                         PUSH_qimm   ; inline operand = 0
  $AC54  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $AC58  09                         LOADL_quick   ; inline operand = 9
  $AC59  D1                         DEC
  $AC5A  29                         STORE_quick   ; inline operand = 9
  $AC5B  0A                         LOADL_quick   ; inline operand = 10
  $AC5C  D1                         DEC
  $AC5D  2A                         STORE_quick   ; inline operand = 10
  $AC5E  50                         LOADR_qimm   ; inline operand = 0
  $AC5F  C2                         SCMPLT
  $AC60  D8 68 AC                   JUMPF_abs              $AC68
  $AC63  44                         LOADL_qimm   ; inline operand = 4
  $AC64  2A                         STORE_quick   ; inline operand = 10
  $AC65  89 18                      BYTE_LOADL_imm1        +24
 >$AC67  29                         STORE_quick   ; inline operand = 9
 >$AC68  39                         PUSH_quick   ; inline operand = 9
  $AC69  64                         PUSH_qimm   ; inline operand = 4
  $AC6A  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $AC6E  62                         PUSH_qimm   ; inline operand = 2
  $AC6F  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $AC73  62                         PUSH_qimm   ; inline operand = 2
  $AC74  E9 3E D7 02                CALL_abs_imm1          $D73E (delay_loop) {bytecode}, $02
  $AC78  D6 33 AC                   JUMP_abs               $AC33
 >$AC7B  60                         PUSH_qimm   ; inline operand = 0
  $AC7C  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $AC80  09                         LOADL_quick   ; inline operand = 9
  $AC81  D0                         INC
  $AC82  29                         STORE_quick   ; inline operand = 9
  $AC83  0A                         LOADL_quick   ; inline operand = 10
  $AC84  D0                         INC
  $AC85  2A                         STORE_quick   ; inline operand = 10
  $AC86  55                         LOADR_qimm   ; inline operand = 5
  $AC87  C5                         SCMPGE
  $AC88  D8 68 AC                   JUMPF_abs              $AC68
  $AC8B  40                         LOADL_qimm   ; inline operand = 0
  $AC8C  2A                         STORE_quick   ; inline operand = 10
  $AC8D  89 14                      BYTE_LOADL_imm1        +20
  $AC8F  D6 67 AC                   JUMP_abs               $AC67
 >$AC92  0B                         LOADL_quick   ; inline operand = 11
  $AC93  D8 33 AC                   JUMPF_abs              $AC33
  $AC96  0A                         LOADL_quick   ; inline operand = 10
  $AC97  52                         LOADR_qimm   ; inline operand = 2
  $AC98  C0                         CMPEQ
  $AC99  D8 B2 AC                   JUMPF_abs              $ACB2
  $AC9C  03                         LOADL_quick   ; inline operand = 3
  $AC9D  B0                         DEREF
  $AC9E  8B 32                      BYTE_LOADR_imm1        +50
  $ACA0  B6                         SDIV
  $ACA1  8F 14                      BYTE_ADD_imm1          +20
  $ACA3  B3                         PUSHL
  $ACA4  DE F0 FF                   LEAL_far               $FFF0
  $ACA7  B3                         PUSHL
  $ACA8  0A                         LOADL_quick   ; inline operand = 10
  $ACA9  D2                         LSHIFT1
  $ACAA  B4                         POPR
  $ACAB  BB                         ADD
  $ACAC  B0                         DEREF
  $ACAD  B4                         POPR
  $ACAE  C2                         SCMPLT
  $ACAF  D8 C1 AC                   JUMPF_abs              $ACC1
 >$ACB2  0B                         LOADL_quick   ; inline operand = 11
  $ACB3  D1                         DEC
  $ACB4  2B                         STORE_quick   ; inline operand = 11
  $ACB5  DE F0 FF                   LEAL_far               $FFF0
  $ACB8  B3                         PUSHL
  $ACB9  0A                         LOADL_quick   ; inline operand = 10
  $ACBA  D2                         LSHIFT1
  $ACBB  B4                         POPR
  $ACBC  BB                         ADD
  $ACBD  B3                         PUSHL
  $ACBE  B0                         DEREF
  $ACBF  D0                         INC
  $ACC0  B1                         POPSTORE
 >$ACC1  60                         PUSH_qimm   ; inline operand = 0
  $ACC2  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $ACC6  39                         PUSH_quick   ; inline operand = 9
  $ACC7  6E                         PUSH_qimm   ; inline operand = 14
  $ACC8  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $ACCC  DE F0 FF                   LEAL_far               $FFF0
  $ACCF  B3                         PUSHL
  $ACD0  0A                         LOADL_quick   ; inline operand = 10
  $ACD1  D2                         LSHIFT1
  $ACD2  B4                         POPR
  $ACD3  BB                         ADD
  $ACD4  B0                         DEREF
  $ACD5  B3                         PUSHL
  $ACD6  8E 59 BE                   PUSH_imm2              $BE59
  $ACD9  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $ACDD  8D 19                      BYTE_PUSH_imm1         +25
  $ACDF  6E                         PUSH_qimm   ; inline operand = 14
  $ACE0  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $ACE4  3B                         PUSH_quick   ; inline operand = 11
  $ACE5  8E 5D BE                   PUSH_imm2              $BE5D
 >$ACE8  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $ACEC  39                         PUSH_quick   ; inline operand = 9
  $ACED  64                         PUSH_qimm   ; inline operand = 4
  $ACEE  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $ACF2  62                         PUSH_qimm   ; inline operand = 2
  $ACF3  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $ACF7  D6 33 AC                   JUMP_abs               $AC33
 >$ACFA  0A                         LOADL_quick   ; inline operand = 10
  $ACFB  D7 02 AD                   JUMPT_abs              $AD02
  $ACFE  41                         LOADL_qimm   ; inline operand = 1
  $ACFF  D6 03 AD                   JUMP_abs               $AD03
 >$AD02  40                         LOADL_qimm   ; inline operand = 0
 >$AD03  B3                         PUSHL
  $AD04  DE F0 FF                   LEAL_far               $FFF0
  $AD07  B3                         PUSHL
  $AD08  0A                         LOADL_quick   ; inline operand = 10
  $AD09  D2                         LSHIFT1
  $AD0A  B4                         POPR
  $AD0B  BB                         ADD
  $AD0C  B0                         DEREF
  $AD0D  B4                         POPR
  $AD0E  C4                         SCMPGT
  $AD0F  D8 33 AC                   JUMPF_abs              $AC33
  $AD12  0B                         LOADL_quick   ; inline operand = 11
  $AD13  D0                         INC
  $AD14  2B                         STORE_quick   ; inline operand = 11
  $AD15  DE F0 FF                   LEAL_far               $FFF0
  $AD18  B3                         PUSHL
  $AD19  0A                         LOADL_quick   ; inline operand = 10
  $AD1A  D2                         LSHIFT1
  $AD1B  B4                         POPR
  $AD1C  BB                         ADD
  $AD1D  B3                         PUSHL
  $AD1E  B0                         DEREF
  $AD1F  D1                         DEC
  $AD20  B1                         POPSTORE
  $AD21  60                         PUSH_qimm   ; inline operand = 0
  $AD22  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $AD26  39                         PUSH_quick   ; inline operand = 9
  $AD27  6E                         PUSH_qimm   ; inline operand = 14
  $AD28  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $AD2C  DE F0 FF                   LEAL_far               $FFF0
  $AD2F  B3                         PUSHL
  $AD30  0A                         LOADL_quick   ; inline operand = 10
  $AD31  D2                         LSHIFT1
  $AD32  B4                         POPR
  $AD33  BB                         ADD
  $AD34  B0                         DEREF
  $AD35  B3                         PUSHL
  $AD36  8E 61 BE                   PUSH_imm2              $BE61
  $AD39  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $AD3D  8D 19                      BYTE_PUSH_imm1         +25
  $AD3F  6E                         PUSH_qimm   ; inline operand = 14
  $AD40  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $AD44  3B                         PUSH_quick   ; inline operand = 11
  $AD45  8E 65 BE                   PUSH_imm2              $BE65
  $AD48  D6 E8 AC                   JUMP_abs               $ACE8
 >$AD4B  60                         PUSH_qimm   ; inline operand = 0
  $AD4C  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $AD50  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $AD53  3B                         PUSH_quick   ; inline operand = 11
  $AD54  DE F0 FF                   LEAL_far               $FFF0
  $AD57  B3                         PUSHL
  $AD58  E9 BD AB 04                CALL_abs_imm1          $ABBD (commit_arms_record_from_buffer) {bytecode}, $04
  $AD5C  CF                         RETURN
 >$AD5D  60                         PUSH_qimm   ; inline operand = 0
  $AD5E  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $AD62  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $AD65  40                         LOADL_qimm   ; inline operand = 0
  $AD66  CF                         RETURN

; ============================================================
; sub $AD67   (frame_off=-2, body @ $AD6C)
; ============================================================
  $AD6C  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $AD6F  8B 1A                      BYTE_LOADR_imm1        +26
  $AD71  B5                         MULT
  $AD72  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $AD75  BB                         ADD
  $AD76  2B                         STORE_quick   ; inline operand = 11
  $AD77  0B                         LOADL_quick   ; inline operand = 11
  $AD78  8F 10                      BYTE_ADD_imm1          +16
  $AD7A  B0                         DEREF
  $AD7B  50                         LOADR_qimm   ; inline operand = 0
  $AD7C  C3                         SCMPLE
  $AD7D  D8 8C AD                   JUMPF_abs              $AD8C
  $AD80  8E FD FD                   PUSH_imm2              $FDFD (msg_you_have_no_soldiers)
  $AD83  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AD87  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $AD8A  40                         LOADL_qimm   ; inline operand = 0
  $AD8B  CF                         RETURN
 >$AD8C  0B                         LOADL_quick   ; inline operand = 11
  $AD8D  B0                         DEREF
  $AD8E  8B 1E                      BYTE_LOADR_imm1        +30
  $AD90  C5                         SCMPGE
  $AD91  D8 A7 AD                   JUMPF_abs              $ADA7
  $AD94  8D 1E                      BYTE_PUSH_imm1         +30
  $AD96  E9 11 AC 02                CALL_abs_imm1          $AC11 (effect_assign) {bytecode}, $02
  $AD9A  D8 B1 AD                   JUMPF_abs              $ADB1
  $AD9D  8D 1E                      BYTE_PUSH_imm1         +30
  $AD9F  0B                         LOADL_quick   ; inline operand = 11
  $ADA0  B4                         POPR
  $ADA1  B3                         PUSHL
  $ADA2  B0                         DEREF
  $ADA3  BC                         SUB
  $ADA4  B1                         POPSTORE
  $ADA5  41                         LOADL_qimm   ; inline operand = 1
  $ADA6  CF                         RETURN
 >$ADA7  8E D9 FD                   PUSH_imm2              $FDD9 (msg_you_have_no_gold)
  $ADAA  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $ADAE  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$ADB1  40                         LOADL_qimm   ; inline operand = 0
  $ADB2  CF                         RETURN

; ============================================================
; sub $ADB3   (frame_off=+0, body @ $ADB8)
; ============================================================
  $ADB8  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $ADBB  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $ADBE  BB                         ADD
  $ADBF  D3                         BYTE_DEREF
  $ADC0  D8 EE AD                   JUMPF_abs              $ADEE
  $ADC3  8E 66 FC                   PUSH_imm2              $FC66 (msg_seasons)
  $ADC6  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $ADCA  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $ADCD  8C 67 6D                   LOADR_imm2             $6D67 (rest_turns_remaining)
  $ADD0  BB                         ADD
  $ADD1  B3                         PUSHL
  $ADD2  6A                         PUSH_qimm   ; inline operand = 10
  $ADD3  61                         PUSH_qimm   ; inline operand = 1
  $ADD4  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $ADD8  D4                         BYTE_POPSTORE
  $ADD9  D8 F4 AD                   JUMPF_abs              $ADF4
  $ADDC  8E 6E FC                   PUSH_imm2              $FC6E (msg_it_will_do_you_good)
  $ADDF  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $ADE3  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $ADE6  8D 20                      BYTE_PUSH_imm1         +32
  $ADE8  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $ADEC  41                         LOADL_qimm   ; inline operand = 1
  $ADED  CF                         RETURN
 >$ADEE  AC CB 87                   CALL_abs               $87CB (show_not_home_fief) {bytecode}
  $ADF1  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$ADF4  40                         LOADL_qimm   ; inline operand = 0
  $ADF5  CF                         RETURN

; ============================================================
; sub $ADF6   (frame_off=-45, body @ $ADFB)
; ============================================================
  $ADFB  0C                         LOADL_quick   ; inline operand = 12
  $ADFC  A2 D7 FF                   BYTE_STORE_far         $FFD7
  $ADFF  8D 22                      BYTE_PUSH_imm1         +34
  $AE01  DE DA FF                   LEAL_far               $FFDA
  $AE04  B3                         PUSHL
  $AE05  A4 5D 6F                   LOADL_abs              $6F5D (selected_record_idx_9e3c)
  $AE08  8B 22                      BYTE_LOADR_imm1        +34
  $AE0A  B5                         MULT
  $AE0B  8C 3C 9E                   LOADR_imm2             $9E3C (record_sram_9e3c)
  $AE0E  BB                         ADD
  $AE0F  B3                         PUSHL
  $AE10  64                         PUSH_qimm   ; inline operand = 4
  $AE11  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $AE15  DE DA FF                   LEAL_far               $FFDA
  $AE18  85 D8                      STORE_near             $D8
  $AE1A  40                         LOADL_qimm   ; inline operand = 0
  $AE1B  85 D3                      STORE_near             $D3
 >$AE1D  81 D8                      LOADL_near             $D8
  $AE1F  D3                         BYTE_DEREF
  $AE20  8C FF 00                   LOADR_imm2             $00FF
  $AE23  C1                         CMPNE
  $AE24  D7 56 AE                   JUMPT_abs              $AE56
  $AE27  D6 77 AE                   JUMP_abs               $AE77
 >$AE2A  64                         PUSH_qimm   ; inline operand = 4
  $AE2B  0A                         LOADL_quick   ; inline operand = 10
  $AE2C  8F FC                      BYTE_ADD_imm1          -4
  $AE2E  8B 1C                      BYTE_LOADR_imm1        +28
  $AE30  B5                         MULT
  $AE31  B3                         PUSHL
  $AE32  A4 5D 6F                   LOADL_abs              $6F5D (selected_record_idx_9e3c)
  $AE35  8C C0 01                   LOADR_imm2             $01C0
  $AE38  B5                         MULT
  $AE39  B4                         POPR
  $AE3A  BB                         ADD
  $AE3B  1B                         LOADR_quick   ; inline operand = 11
  $AE3C  BB                         ADD
  $AE3D  8C 5A 8D                   LOADR_imm2             $8D5A (window_tile_gfx_8d5a)
  $AE40  BB                         ADD
  $AE41  B3                         PUSHL
  $AE42  3A                         PUSH_quick   ; inline operand = 10
  $AE43  8D 1D                      BYTE_PUSH_imm1         +29
  $AE45  0B                         LOADL_quick   ; inline operand = 11
  $AE46  78                         ADD_qimm   ; inline operand = 8
  $AE47  B3                         PUSHL
  $AE48  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $AE4C  B3                         PUSHL
  $AE4D  3A                         PUSH_quick   ; inline operand = 10
  $AE4E  3B                         PUSH_quick   ; inline operand = 11
  $AE4F  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_copy_rect_wrap) {bytecode}, $0C
  $AE53  D6 A2 AE                   JUMP_abs               $AEA2
 >$AE56  81 D8                      LOADL_near             $D8
  $AE58  D0                         INC
  $AE59  85 D8                      STORE_near             $D8
  $AE5B  D1                         DEC
  $AE5C  D3                         BYTE_DEREF
  $AE5D  2B                         STORE_quick   ; inline operand = 11
  $AE5E  81 D8                      LOADL_near             $D8
  $AE60  D0                         INC
  $AE61  85 D8                      STORE_near             $D8
  $AE63  D1                         DEC
  $AE64  D3                         BYTE_DEREF
  $AE65  2A                         STORE_quick   ; inline operand = 10
  $AE66  81 D8                      LOADL_near             $D8
  $AE68  D0                         INC
  $AE69  85 D8                      STORE_near             $D8
  $AE6B  D1                         DEC
  $AE6C  D3                         BYTE_DEREF
  $AE6D  A6 5F 6F                   LOADR_abs              $6F5F (selected_province_idx)
  $AE70  C0                         CMPEQ
  $AE71  D8 1D AE                   JUMPF_abs              $AE1D
  $AE74  41                         LOADL_qimm   ; inline operand = 1
  $AE75  85 D3                      STORE_near             $D3
 >$AE77  40                         LOADL_qimm   ; inline operand = 0
 >$AE78  85 D5                      STORE_near             $D5
  $AE7A  81 D3                      LOADL_near             $D3
  $AE7C  51                         LOADR_qimm   ; inline operand = 1
  $AE7D  C0                         CMPEQ
  $AE7E  D8 A2 AE                   JUMPF_abs              $AEA2
  $AE81  81 D5                      LOADL_near             $D5
  $AE83  8B 64                      BYTE_LOADR_imm1        +100
  $AE85  C0                         CMPEQ
  $AE86  D7 2A AE                   JUMPT_abs              $AE2A
  $AE89  81 D5                      LOADL_near             $D5
  $AE8B  8C C8 00                   LOADR_imm2             $00C8
  $AE8E  C0                         CMPEQ
  $AE8F  D8 A2 AE                   JUMPF_abs              $AEA2
  $AE92  3A                         PUSH_quick   ; inline operand = 10
  $AE93  3B                         PUSH_quick   ; inline operand = 11
  $AE94  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $AE98  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $AE9B  E9 6E DB 02                CALL_abs_imm1          $DB6E (draw_province_lord_name) {bytecode}, $02
  $AE9F  40                         LOADL_qimm   ; inline operand = 0
  $AEA0  85 D5                      STORE_near             $D5
 >$AEA2  AC 4E D1                   CALL_abs               $D14E (poll_input) {bytecode}
  $AEA5  D9 05 00 01 00 BE AE 10 00 DD AE 20 ... SWITCH_noncontig       count=5   ; .table 5 (key,target) + default (noncontiguous); SWITCH 1=>$AEBE 16=>$AEDD 32=>$AEEE 64=>$AEEE 128=>$AEDD default=>$AECF
 >$AEBE  4A                         LOADL_qimm   ; inline operand = 10
  $AEBF  2C                         STORE_quick   ; inline operand = 12
 >$AEC0  0C                         LOADL_quick   ; inline operand = 12
  $AEC1  CF                         RETURN
 >$AEC2  0C                         LOADL_quick   ; inline operand = 12
  $AEC3  52                         LOADR_qimm   ; inline operand = 2
  $AEC4  C0                         CMPEQ
  $AEC5  D8 CC AE                   JUMPF_abs              $AECC
  $AEC8  42                         LOADL_qimm   ; inline operand = 2
  $AEC9  D6 CE AE                   JUMP_abs               $AECE
 >$AECC  0C                         LOADL_quick   ; inline operand = 12
  $AECD  D1                         DEC
 >$AECE  2C                         STORE_quick   ; inline operand = 12
 >$AECF  A0 D7 FF                   BYTE_LOADL_far         $FFD7
  $AED2  1C                         LOADR_quick   ; inline operand = 12
  $AED3  C1                         CMPNE
  $AED4  D7 C0 AE                   JUMPT_abs              $AEC0
  $AED7  81 D5                      LOADL_near             $D5
  $AED9  D0                         INC
  $AEDA  D6 78 AE                   JUMP_abs               $AE78
 >$AEDD  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $AEE0  8B 32                      BYTE_LOADR_imm1        +50
  $AEE2  C0                         CMPEQ
  $AEE3  D7 C2 AE                   JUMPT_abs              $AEC2
  $AEE6  0C                         LOADL_quick   ; inline operand = 12
  $AEE7  D7 CC AE                   JUMPT_abs              $AECC
  $AEEA  40                         LOADL_qimm   ; inline operand = 0
  $AEEB  D6 CE AE                   JUMP_abs               $AECE
 >$AEEE  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $AEF1  8B 32                      BYTE_LOADR_imm1        +50
  $AEF3  C0                         CMPEQ
  $AEF4  D8 06 AF                   JUMPF_abs              $AF06
  $AEF7  0C                         LOADL_quick   ; inline operand = 12
  $AEF8  58                         LOADR_qimm   ; inline operand = 8
  $AEF9  C0                         CMPEQ
  $AEFA  D8 01 AF                   JUMPF_abs              $AF01
  $AEFD  48                         LOADL_qimm   ; inline operand = 8
  $AEFE  D6 CE AE                   JUMP_abs               $AECE
 >$AF01  0C                         LOADL_quick   ; inline operand = 12
  $AF02  D0                         INC
  $AF03  D6 CE AE                   JUMP_abs               $AECE
 >$AF06  0C                         LOADL_quick   ; inline operand = 12
  $AF07  51                         LOADR_qimm   ; inline operand = 1
  $AF08  C0                         CMPEQ
  $AF09  D8 01 AF                   JUMPF_abs              $AF01
  $AF0C  41                         LOADL_qimm   ; inline operand = 1
  $AF0D  D6 CE AE                   JUMP_abs               $AECE

; ============================================================
; sub $AF10   (frame_off=-4, body @ $AF15)
; ============================================================
  $AF15  8E 69 BE                   PUSH_imm2              $BE69 (msg_arrows_other_sections)
  $AF18  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AF1C  8E 86 BE                   PUSH_imm2              $BE86 (msg_a_button_menu)
  $AF1F  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AF23  D6 2B AF                   JUMP_abs               $AF2B
 >$AF26  3C                         PUSH_quick   ; inline operand = 12
  $AF27  E9 F2 E5 02                CALL_abs_imm1          $E5F2 (render_map_section) {bytecode}, $02
 >$AF2B  3C                         PUSH_quick   ; inline operand = 12
  $AF2C  E9 F6 AD 02                CALL_abs_imm1          $ADF6 (fief_select_input_loop) {bytecode}, $02
  $AF30  2C                         STORE_quick   ; inline operand = 12
  $AF31  5A                         LOADR_qimm   ; inline operand = 10
  $AF32  C1                         CMPNE
  $AF33  D7 26 AF                   JUMPT_abs              $AF26
  $AF36  40                         LOADL_qimm   ; inline operand = 0
  $AF37  CF                         RETURN

; ============================================================
; sub $AF38   (frame_off=-2, body @ $AF3D)
; ============================================================
  $AF3D  AC 20 CD                   CALL_abs               $CD20 (repaint_screen) {bytecode}
  $AF40  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $AF43  8B 32                      BYTE_LOADR_imm1        +50
  $AF45  C0                         CMPEQ
  $AF46  D8 52 AF                   JUMPF_abs              $AF52
  $AF49  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $AF4C  8C A6 FE                   LOADR_imm2             $FEA6 (province_to_map_section_50)
  $AF4F  D6 58 AF                   JUMP_abs               $AF58
 >$AF52  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $AF55  8C D8 FE                   LOADR_imm2             $FED8 (province_to_map_section_17)
 >$AF58  BB                         ADD
  $AF59  D3                         BYTE_DEREF
  $AF5A  2B                         STORE_quick   ; inline operand = 11
  $AF5B  B3                         PUSHL
  $AF5C  E9 F2 E5 02                CALL_abs_imm1          $E5F2 (render_map_section) {bytecode}, $02
  $AF60  3B                         PUSH_quick   ; inline operand = 11
  $AF61  E9 10 AF 02                CALL_abs_imm1          $AF10 (browse_map_sections) {bytecode}, $02
  $AF65  CF                         RETURN

; ============================================================
; sub $AF66   (frame_off=-6, body @ $AF6B)
; ============================================================
  $AF6B  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $AF6E  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $AF71  BB                         ADD
  $AF72  D3                         BYTE_DEREF
  $AF73  D7 7E AF                   JUMPT_abs              $AF7E
  $AF76  AC CB 87                   CALL_abs               $87CB (show_not_home_fief) {bytecode}
  $AF79  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $AF7C  40                         LOADL_qimm   ; inline operand = 0
  $AF7D  CF                         RETURN
 >$AF7E  61                         PUSH_qimm   ; inline operand = 1
  $AF7F  E9 10 E5 02                CALL_abs_imm1          $E510 (build_eligible_province_list) {bytecode}, $02
  $AF83  40                         LOADL_qimm   ; inline operand = 0
  $AF84  2A                         STORE_quick   ; inline operand = 10
 >$AF85  8E 89 6F                   PUSH_imm2              $6F89
  $AF88  8D 13                      BYTE_PUSH_imm1         +19
  $AF8A  E9 9F 87 04                CALL_abs_imm1          $879F (province_select_helper) {bytecode}, $04
  $AF8E  D7 9C AF                   JUMPT_abs              $AF9C
 >$AF91  0A                         LOADL_quick   ; inline operand = 10
  $AF92  D8 9A AF                   JUMPF_abs              $AF9A
  $AF95  61                         PUSH_qimm   ; inline operand = 1
  $AF96  E9 1E 87 02                CALL_abs_imm1          $871E (fief_info_display) {bytecode}, $02
 >$AF9A  40                         LOADL_qimm   ; inline operand = 0
  $AF9B  CF                         RETURN
 >$AF9C  8E 40 FE                   PUSH_imm2              $FE40 (msg_which_fief_fe40)
  $AF9F  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AFA3  8E 89 6F                   PUSH_imm2              $6F89
  $AFA6  E9 4C 80 02                CALL_abs_imm1          $804C (province_select_prompt) {bytecode}, $02
  $AFAA  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $AFAD  D8 60 B0                   JUMPF_abs              $B060
  $AFB0  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $AFB3  D1                         DEC
  $AFB4  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $AFB7  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $AFBA  8E 4D FE                   PUSH_imm2              $FE4D (msg_what_are_your_orders)
  $AFBD  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $AFC1  0A                         LOADL_quick   ; inline operand = 10
  $AFC2  D7 F5 AF                   JUMPT_abs              $AFF5
  $AFC5  41                         LOADL_qimm   ; inline operand = 1
  $AFC6  2A                         STORE_quick   ; inline operand = 10
  $AFC7  AC 69 CC                   CALL_abs               $CC69 (clear_rect_right_panel) {bytecode}
  $AFCA  40                         LOADL_qimm   ; inline operand = 0
  $AFCB  29                         STORE_quick   ; inline operand = 9
 >$AFCC  09                         LOADL_quick   ; inline operand = 9
  $AFCD  77                         ADD_qimm   ; inline operand = 7
  $AFCE  B3                         PUSHL
  $AFCF  8D 17                      BYTE_PUSH_imm1         +23
  $AFD1  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $AFD5  09                         LOADL_quick   ; inline operand = 9
  $AFD6  D0                         INC
  $AFD7  B3                         PUSHL
  $AFD8  8E 98 BE                   PUSH_imm2              $BE98 (msg_fmt__d_be98)
  $AFDB  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $AFDF  09                         LOADL_quick   ; inline operand = 9
  $AFE0  D0                         INC
  $AFE1  D2                         LSHIFT1
  $AFE2  8C E9 FE                   LOADR_imm2             $FEE9 (governance_state_label_ptrs)
  $AFE5  BB                         ADD
  $AFE6  B0                         DEREF
  $AFE7  B3                         PUSHL
  $AFE8  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $AFEC  09                         LOADL_quick   ; inline operand = 9
  $AFED  D0                         INC
  $AFEE  29                         STORE_quick   ; inline operand = 9
  $AFEF  09                         LOADL_quick   ; inline operand = 9
  $AFF0  56                         LOADR_qimm   ; inline operand = 6
  $AFF1  C2                         SCMPLT
  $AFF2  D7 CC AF                   JUMPT_abs              $AFCC
 >$AFF5  66                         PUSH_qimm   ; inline operand = 6
  $AFF6  E9 A6 B1 02                CALL_abs_imm1          $B1A6 (submenu_prompt) {bytecode}, $02
  $AFFA  D0                         INC
  $AFFB  2B                         STORE_quick   ; inline operand = 11
  $AFFC  56                         LOADR_qimm   ; inline operand = 6
  $AFFD  C1                         CMPNE
  $AFFE  D8 85 AF                   JUMPF_abs              $AF85
  $B001  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $B004  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $B007  BB                         ADD
  $B008  D3                         BYTE_DEREF
  $B009  1B                         LOADR_quick   ; inline operand = 11
  $B00A  C0                         CMPEQ
  $B00B  D8 23 B0                   JUMPF_abs              $B023
  $B00E  0B                         LOADL_quick   ; inline operand = 11
  $B00F  D2                         LSHIFT1
  $B010  8C D4 F7                   LOADR_imm2             $F7D4 (governance_policy_name_ptrs)
  $B013  BB                         ADD
  $B014  B0                         DEREF
  $B015  B3                         PUSHL
  $B016  8E 9B BE                   PUSH_imm2              $BE9B (msg_it_s_already_a_s_state)
  $B019  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
 >$B01D  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $B020  D6 85 AF                   JUMP_abs               $AF85
 >$B023  0B                         LOADL_quick   ; inline operand = 11
  $B024  D2                         LSHIFT1
  $B025  8C D4 F7                   LOADR_imm2             $F7D4 (governance_policy_name_ptrs)
  $B028  BB                         ADD
  $B029  B0                         DEREF
  $B02A  B3                         PUSHL
  $B02B  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $B02E  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $B031  BB                         ADD
  $B032  D3                         BYTE_DEREF
  $B033  D2                         LSHIFT1
  $B034  8C D4 F7                   LOADR_imm2             $F7D4 (governance_policy_name_ptrs)
  $B037  BB                         ADD
  $B038  B0                         DEREF
  $B039  B3                         PUSHL
  $B03A  8E 64 FE                   PUSH_imm2              $FE64 (msg_it_s_currently_a_s_state_ok_to)
  $B03D  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $B041  AC A7 D3                   CALL_abs               $D3A7 (prompt_y_n) {bytecode}
  $B044  D8 85 AF                   JUMPF_abs              $AF85
  $B047  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $B04A  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $B04D  BB                         ADD
  $B04E  B3                         PUSHL
  $B04F  0B                         LOADL_quick   ; inline operand = 11
  $B050  D4                         BYTE_POPSTORE
  $B051  6B                         PUSH_qimm   ; inline operand = 11
  $B052  E9 0C E8 02                CALL_abs_imm1          $E80C (trigger_cutscene) {bytecode}, $02
  $B056  8E 82 FC                   PUSH_imm2              $FC82 (msg_lord_you_are_truly_wise)
  $B059  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $B05D  D6 1D B0                   JUMP_abs               $B01D
 >$B060  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $B063  D6 91 AF                   JUMP_abs               $AF91

; ============================================================
; sub $B066   (frame_off=-2, body @ $B06B)
; ============================================================
  $B06B  8E B3 BE                   PUSH_imm2              $BEB3 (msg_sound)
  $B06E  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $B072  8E BA BE                   PUSH_imm2              $BEBA (msg_on_off)
  $B075  E9 51 D3 02                CALL_abs_imm1          $D351 (prompt_ab_window) {bytecode}, $02
  $B079  2B                         STORE_quick   ; inline operand = 11
  $B07A  0B                         LOADL_quick   ; inline operand = 11
  $B07B  52                         LOADR_qimm   ; inline operand = 2
  $B07C  C0                         CMPEQ
  $B07D  D8 82 B0                   JUMPF_abs              $B082
  $B080  40                         LOADL_qimm   ; inline operand = 0
  $B081  CF                         RETURN
 >$B082  0B                         LOADL_quick   ; inline operand = 11
  $B083  A8 4D 6F                   STORE_abs              $6F4D (audio_wait_gate)
  $B086  A4 4D 6F                   LOADL_abs              $6F4D (audio_wait_gate)
  $B089  D7 96 B0                   JUMPT_abs              $B096
  $B08C  60                         PUSH_qimm   ; inline operand = 0
  $B08D  60                         PUSH_qimm   ; inline operand = 0
  $B08E  6A                         PUSH_qimm   ; inline operand = 10
  $B08F  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $B093  D6 9B B0                   JUMP_abs               $B09B
 >$B096  61                         PUSH_qimm   ; inline operand = 1
  $B097  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
 >$B09B  40                         LOADL_qimm   ; inline operand = 0
  $B09C  CF                         RETURN

; ============================================================
; sub $B09D   (frame_off=+0, body @ $B0A2)
; ============================================================
  $B0A2  8E C5 BE                   PUSH_imm2              $BEC5 (msg_animation)
  $B0A5  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $B0A9  8E D0 BE                   PUSH_imm2              $BED0 (msg_on_off_bed0)
  $B0AC  E9 51 D3 02                CALL_abs_imm1          $D351 (prompt_ab_window) {bytecode}, $02
  $B0B0  D9 02 00 01 00 BD B0 00 00 C8 B0 C6 ... SWITCH_noncontig       count=2   ; .table 2 (key,target) + default (noncontiguous); SWITCH 1=>$B0BD 0=>$B0C8 default=>$B0C6
 >$B0BD  44                         LOADL_qimm   ; inline operand = 4
  $B0BE  CD                         SWAP
  $B0BF  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $B0C2  DB                         OR
 >$B0C3  A9 A1 6D                   BYTE_STORE_abs         $6DA1 (ai_turn_flags)
 >$B0C6  40                         LOADL_qimm   ; inline operand = 0
  $B0C7  CF                         RETURN
 >$B0C8  89 FB                      BYTE_LOADL_imm1        -5
  $B0CA  CD                         SWAP
  $B0CB  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $B0CE  DA                         AND
  $B0CF  D6 C3 B0                   JUMP_abs               $B0C3

; ============================================================
; sub $B0D2   (frame_off=-2, body @ $B0D7)
; ============================================================
  $B0D7  8E DB BE                   PUSH_imm2              $BEDB (msg_wait_is_now)
  $B0DA  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $B0DE  A4 65 6D                   LOADL_abs              $6D65 (delay_loop_count)
  $B0E1  52                         LOADR_qimm   ; inline operand = 2
  $B0E2  B6                         SDIV
  $B0E3  B3                         PUSHL
  $B0E4  E9 CD CB 02                CALL_abs_imm1          $CBCD (sqrt_int) {native}, $02
  $B0E8  B3                         PUSHL
  $B0E9  8E E8 BE                   PUSH_imm2              $BEE8 (msg_d_enter_new_wait)
  $B0EC  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $B0F0  6A                         PUSH_qimm   ; inline operand = 10
  $B0F1  61                         PUSH_qimm   ; inline operand = 1
  $B0F2  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $B0F6  2B                         STORE_quick   ; inline operand = 11
  $B0F7  D8 04 B1                   JUMPF_abs              $B104
  $B0FA  0B                         LOADL_quick   ; inline operand = 11
  $B0FB  1B                         LOADR_quick   ; inline operand = 11
  $B0FC  B5                         MULT
  $B0FD  D2                         LSHIFT1
  $B0FE  A8 65 6D                   STORE_abs              $6D65 (delay_loop_count)
  $B101  D6 07 B1                   JUMP_abs               $B107
 >$B104  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
 >$B107  40                         LOADL_qimm   ; inline operand = 0
  $B108  CF                         RETURN

; ============================================================
; sub $B109   (frame_off=+0, body @ $B10E)
; ============================================================
  $B10E  8E FA BE                   PUSH_imm2              $BEFA (msg_are_you_sure)
  $B111  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $B115  AC A7 D3                   CALL_abs               $D3A7 (prompt_y_n) {bytecode}
  $B118  D8 29 B1                   JUMPF_abs              $B129
  $B11B  41                         LOADL_qimm   ; inline operand = 1
  $B11C  A8 61 6F                   STORE_abs              $6F61 (sram_save_pending_flag)
  $B11F  8E 07 BF                   PUSH_imm2              $BF07 (msg_game_will_save_at_end_of_seaso)
  $B122  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $B126  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
 >$B129  40                         LOADL_qimm   ; inline operand = 0
  $B12A  CF                         RETURN

; ============================================================
; sub $B12B   (frame_off=-2, body @ $B130)
; ============================================================
  $B130  8E 27 BF                   PUSH_imm2              $BF27 (msg_watch_others_battle)
  $B133  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $B137  8E 3C BF                   PUSH_imm2              $BF3C (msg_y_n)
  $B13A  E9 51 D3 02                CALL_abs_imm1          $D351 (prompt_ab_window) {bytecode}, $02
  $B13E  2B                         STORE_quick   ; inline operand = 11
  $B13F  0B                         LOADL_quick   ; inline operand = 11
  $B140  52                         LOADR_qimm   ; inline operand = 2
  $B141  C1                         CMPNE
  $B142  D8 49 B1                   JUMPF_abs              $B149
  $B145  0B                         LOADL_quick   ; inline operand = 11
  $B146  A8 7D 6E                   STORE_abs              $6E7D (ui_confirm_flag_6e7d)
 >$B149  40                         LOADL_qimm   ; inline operand = 0
  $B14A  CF                         RETURN

; ============================================================
; sub $B14B   (frame_off=-4, body @ $B150)
; ============================================================
  $B150  8E 44 BF                   PUSH_imm2              $BF44 (msg_do_you_really_want_to_end_the)
  $B153  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $B157  AC A7 D3                   CALL_abs               $D3A7 (prompt_y_n) {bytecode}
  $B15A  D8 A4 B1                   JUMPF_abs              $B1A4
  $B15D  AC 35 DB                   CALL_abs               $DB35 (increment_ai_player_count) {bytecode}
  $B160  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $B163  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $B166  DA                         AND
  $B167  D8 7D B1                   JUMPF_abs              $B17D
  $B16A  AC 20 CD                   CALL_abs               $CD20 (repaint_screen) {bytecode}
  $B16D  6E                         PUSH_qimm   ; inline operand = 14
  $B16E  6C                         PUSH_qimm   ; inline operand = 12
  $B16F  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $B173  8E 67 BF                   PUSH_imm2              $BF67 (msg_game_over_bf67)
  $B176  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$B17A  D6 7A B1                   JUMP_abs               $B17A
 >$B17D  AC 7E D7                   CALL_abs               $D77E (selected_province_owner) {bytecode}
  $B180  2B                         STORE_quick   ; inline operand = 11
  $B181  40                         LOADL_qimm   ; inline operand = 0
  $B182  D6 99 B1                   JUMP_abs               $B199
 >$B185  3A                         PUSH_quick   ; inline operand = 10
  $B186  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $B18A  1B                         LOADR_quick   ; inline operand = 11
  $B18B  C0                         CMPEQ
  $B18C  D8 97 B1                   JUMPF_abs              $B197
  $B18F  0A                         LOADL_quick   ; inline operand = 10
  $B190  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $B193  BB                         ADD
  $B194  B3                         PUSHL
  $B195  40                         LOADL_qimm   ; inline operand = 0
  $B196  D4                         BYTE_POPSTORE
 >$B197  0A                         LOADL_quick   ; inline operand = 10
  $B198  D0                         INC
 >$B199  2A                         STORE_quick   ; inline operand = 10
  $B19A  0A                         LOADL_quick   ; inline operand = 10
  $B19B  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $B19E  C6                         UCMPLT
  $B19F  D7 85 B1                   JUMPT_abs              $B185
  $B1A2  41                         LOADL_qimm   ; inline operand = 1
  $B1A3  CF                         RETURN
 >$B1A4  40                         LOADL_qimm   ; inline operand = 0
  $B1A5  CF                         RETURN

; ============================================================
; sub $B1A6   (frame_off=-4, body @ $B1AB)
; ============================================================
  $B1AB  67                         PUSH_qimm   ; inline operand = 7
  $B1AC  8D 15                      BYTE_PUSH_imm1         +21
  $B1AE  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $B1B2  62                         PUSH_qimm   ; inline operand = 2
  $B1B3  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $B1B7  AC 87 D2                   CALL_abs               $D287 (wait_button_edge) {bytecode}
  $B1BA  40                         LOADL_qimm   ; inline operand = 0
  $B1BB  2A                         STORE_quick   ; inline operand = 10
  $B1BC  40                         LOADL_qimm   ; inline operand = 0
  $B1BD  2B                         STORE_quick   ; inline operand = 11
 >$B1BE  0B                         LOADL_quick   ; inline operand = 11
  $B1BF  D8 C4 B1                   JUMPF_abs              $B1C4
  $B1C2  0A                         LOADL_quick   ; inline operand = 10
  $B1C3  CF                         RETURN
 >$B1C4  AC 4E D1                   CALL_abs               $D14E (poll_input) {bytecode}
  $B1C7  D9 04 00 01 00 DF B1 02 00 DC B1 10 ... SWITCH_noncontig       count=4   ; .table 4 (key,target) + default (noncontiguous); SWITCH 1=>$B1DF 2=>$B1DC 16=>$B1EC 32=>$B21A default=>$B1BE
 >$B1DC  0C                         LOADL_quick   ; inline operand = 12
  $B1DD  D1                         DEC
  $B1DE  2A                         STORE_quick   ; inline operand = 10
 >$B1DF  60                         PUSH_qimm   ; inline operand = 0
  $B1E0  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $B1E4  41                         LOADL_qimm   ; inline operand = 1
  $B1E5  2B                         STORE_quick   ; inline operand = 11
  $B1E6  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $B1E9  D6 BE B1                   JUMP_abs               $B1BE
 >$B1EC  60                         PUSH_qimm   ; inline operand = 0
  $B1ED  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $B1F1  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $B1F4  D1                         DEC
  $B1F5  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $B1F8  56                         LOADR_qimm   ; inline operand = 6
  $B1F9  C0                         CMPEQ
  $B1FA  D8 0A B2                   JUMPF_abs              $B20A
  $B1FD  0C                         LOADL_quick   ; inline operand = 12
  $B1FE  76                         ADD_qimm   ; inline operand = 6
  $B1FF  B3                         PUSHL
  $B200  8D 15                      BYTE_PUSH_imm1         +21
  $B202  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $B206  0C                         LOADL_quick   ; inline operand = 12
  $B207  D6 0B B2                   JUMP_abs               $B20B
 >$B20A  0A                         LOADL_quick   ; inline operand = 10
 >$B20B  D1                         DEC
 >$B20C  2A                         STORE_quick   ; inline operand = 10
  $B20D  62                         PUSH_qimm   ; inline operand = 2
  $B20E  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $B212  62                         PUSH_qimm   ; inline operand = 2
  $B213  E9 3E D7 02                CALL_abs_imm1          $D73E (delay_loop) {bytecode}, $02
  $B217  D6 BE B1                   JUMP_abs               $B1BE
 >$B21A  60                         PUSH_qimm   ; inline operand = 0
  $B21B  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $B21F  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $B222  D0                         INC
  $B223  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $B226  B3                         PUSHL
  $B227  0C                         LOADL_quick   ; inline operand = 12
  $B228  77                         ADD_qimm   ; inline operand = 7
  $B229  B4                         POPR
  $B22A  C0                         CMPEQ
  $B22B  D8 39 B2                   JUMPF_abs              $B239
  $B22E  67                         PUSH_qimm   ; inline operand = 7
  $B22F  8D 15                      BYTE_PUSH_imm1         +21
  $B231  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $B235  40                         LOADL_qimm   ; inline operand = 0
  $B236  D6 0C B2                   JUMP_abs               $B20C
 >$B239  0A                         LOADL_quick   ; inline operand = 10
  $B23A  D0                         INC
  $B23B  D6 0C B2                   JUMP_abs               $B20C

; ============================================================
; sub $B23E   (frame_off=-7, body @ $B243)
; ============================================================
  $B243  AC 69 CC                   CALL_abs               $CC69 (clear_rect_right_panel) {bytecode}
  $B246  40                         LOADL_qimm   ; inline operand = 0
  $B247  29                         STORE_quick   ; inline operand = 9
 >$B248  09                         LOADL_quick   ; inline operand = 9
  $B249  77                         ADD_qimm   ; inline operand = 7
  $B24A  B3                         PUSHL
  $B24B  8D 16                      BYTE_PUSH_imm1         +22
  $B24D  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $B251  09                         LOADL_quick   ; inline operand = 9
  $B252  D0                         INC
  $B253  B3                         PUSHL
  $B254  8E 71 BF                   PUSH_imm2              $BF71 (msg_fmt__2d_bf71)
  $B257  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $B25B  09                         LOADL_quick   ; inline operand = 9
  $B25C  D2                         LSHIFT1
  $B25D  8C 1A FF                   LOADR_imm2             $FF1A (settings_menu_str_ptrs)
  $B260  BB                         ADD
  $B261  B0                         DEREF
  $B262  B3                         PUSHL
  $B263  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $B267  09                         LOADL_quick   ; inline operand = 9
  $B268  D0                         INC
  $B269  29                         STORE_quick   ; inline operand = 9
  $B26A  09                         LOADL_quick   ; inline operand = 9
  $B26B  57                         LOADR_qimm   ; inline operand = 7
  $B26C  C2                         SCMPLT
  $B26D  D7 48 B2                   JUMPT_abs              $B248
 >$B270  8E 75 BF                   PUSH_imm2              $BF75 (msg_change_which)
  $B273  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $B277  67                         PUSH_qimm   ; inline operand = 7
  $B278  E9 A6 B1 02                CALL_abs_imm1          $B1A6 (submenu_prompt) {bytecode}, $02
  $B27C  2A                         STORE_quick   ; inline operand = 10
  $B27D  0A                         LOADL_quick   ; inline operand = 10
  $B27E  D2                         LSHIFT1
  $B27F  8C E8 B9                   LOADR_imm2             $B9E8 (jumptab_b9e8)
  $B282  BB                         ADD
  $B283  B0                         DEREF
  $B284  2B                         STORE_quick   ; inline operand = 11
  $B285  0B                         LOADL_quick   ; inline operand = 11
  $B286  DD                         CALLPTR
  $B287  A2 F9 FF                   BYTE_STORE_far         $FFF9
  $B28A  0A                         LOADL_quick   ; inline operand = 10
  $B28B  56                         LOADR_qimm   ; inline operand = 6
  $B28C  C1                         CMPNE
  $B28D  D8 98 B2                   JUMPF_abs              $B298
  $B290  A0 F9 FF                   BYTE_LOADL_far         $FFF9
  $B293  51                         LOADR_qimm   ; inline operand = 1
  $B294  C1                         CMPNE
  $B295  D7 70 B2                   JUMPT_abs              $B270
 >$B298  60                         PUSH_qimm   ; inline operand = 0
  $B299  E9 1E 87 02                CALL_abs_imm1          $871E (fief_info_display) {bytecode}, $02
  $B29D  0A                         LOADL_quick   ; inline operand = 10
  $B29E  55                         LOADR_qimm   ; inline operand = 5
  $B29F  C0                         CMPEQ
  $B2A0  CF                         RETURN

; ============================================================
; sub $B2A1   (frame_off=+0, body @ $B2A6)
; ============================================================
  $B2A6  8E 83 BF                   PUSH_imm2              $BF83 (msg_what_a_waste)
  $B2A9  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $B2AD  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $B2B0  41                         LOADL_qimm   ; inline operand = 1
  $B2B1  CF                         RETURN

; ============================================================
; sub $B2B2   (frame_off=+0, body @ $B2B7)
; ============================================================
  $B2B7  8E 63 6F                   PUSH_imm2              $6F63 (battle_defending_province)
  $B2BA  DE 0B 00                   LEAL_far               $000B
  $B2BD  B3                         PUSHL
  $B2BE  E9 94 CB 04                CALL_abs_imm1          $CB94 (swap_word) {bytecode}, $04
  $B2C2  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $B2C5  8C 2D 6D                   LOADR_imm2             $6D2D (fief_tax_rate)
  $B2C8  BB                         ADD
  $B2C9  B3                         PUSHL
  $B2CA  AC 12 DB                   CALL_abs               $DB12 (defender_owner_is_keyed_daimyo) {bytecode}
  $B2CD  D8 DA B2                   JUMPF_abs              $B2DA
  $B2D0  6F                         PUSH_qimm   ; inline operand = 15
  $B2D1  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B2D5  8F 10                      BYTE_ADD_imm1          +16
  $B2D7  D6 E2 B2                   JUMP_abs               $B2E2
 >$B2DA  8D 1E                      BYTE_PUSH_imm1         +30
  $B2DC  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B2E0  8F 23                      BYTE_ADD_imm1          +35
 >$B2E2  D4                         BYTE_POPSTORE
  $B2E3  8E 63 6F                   PUSH_imm2              $6F63 (battle_defending_province)
  $B2E6  DE 0B 00                   LEAL_far               $000B
  $B2E9  B3                         PUSHL
  $B2EA  E9 94 CB 04                CALL_abs_imm1          $CB94 (swap_word) {bytecode}, $04
  $B2EE  CF                         RETURN

; ============================================================
; sub $B2EF   (frame_off=-2, body @ $B2F4)
; ============================================================
  $B2F4  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $B2F7  8B 1A                      BYTE_LOADR_imm1        +26
  $B2F9  B5                         MULT
  $B2FA  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $B2FD  BB                         ADD
  $B2FE  2B                         STORE_quick   ; inline operand = 11
  $B2FF  3C                         PUSH_quick   ; inline operand = 12
  $B300  0B                         LOADL_quick   ; inline operand = 11
  $B301  8F 10                      BYTE_ADD_imm1          +16
  $B303  B0                         DEREF
  $B304  B3                         PUSHL
  $B305  0B                         LOADL_quick   ; inline operand = 11
  $B306  B0                         DEREF
  $B307  B4                         POPR
  $B308  BC                         SUB
  $B309  B1                         POPSTORE
  $B30A  3D                         PUSH_quick   ; inline operand = 13
  $B30B  0B                         LOADL_quick   ; inline operand = 11
  $B30C  8F 10                      BYTE_ADD_imm1          +16
  $B30E  B0                         DEREF
  $B30F  B3                         PUSHL
  $B310  0B                         LOADL_quick   ; inline operand = 11
  $B311  76                         ADD_qimm   ; inline operand = 6
  $B312  B0                         DEREF
  $B313  B4                         POPR
  $B314  BC                         SUB
  $B315  B1                         POPSTORE
  $B316  0C                         LOADL_quick   ; inline operand = 12
  $B317  B0                         DEREF
  $B318  50                         LOADR_qimm   ; inline operand = 0
  $B319  C2                         SCMPLT
  $B31A  D8 20 B3                   JUMPF_abs              $B320
  $B31D  3C                         PUSH_quick   ; inline operand = 12
  $B31E  40                         LOADL_qimm   ; inline operand = 0
  $B31F  B1                         POPSTORE
 >$B320  0D                         LOADL_quick   ; inline operand = 13
  $B321  B0                         DEREF
  $B322  50                         LOADR_qimm   ; inline operand = 0
  $B323  C2                         SCMPLT
  $B324  D8 2A B3                   JUMPF_abs              $B32A
  $B327  3D                         PUSH_quick   ; inline operand = 13
  $B328  40                         LOADL_qimm   ; inline operand = 0
  $B329  B1                         POPSTORE
 >$B32A  CF                         RETURN

; ============================================================
; sub $B32B   (frame_off=+0, body @ $B330)
; ============================================================
  $B330  8D 14                      BYTE_PUSH_imm1         +20
  $B332  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B336  7A                         ADD_qimm   ; inline operand = 10
  $B337  CF                         RETURN

; ============================================================
; sub $B338   (frame_off=-4, body @ $B33D)
; ============================================================
  $B33D  64                         PUSH_qimm   ; inline operand = 4
  $B33E  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B342  D7 46 B3                   JUMPT_abs              $B346
  $B345  CF                         RETURN
 >$B346  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $B349  8B 1A                      BYTE_LOADR_imm1        +26
  $B34B  B5                         MULT
  $B34C  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $B34F  BB                         ADD
  $B350  2B                         STORE_quick   ; inline operand = 11
  $B351  AC 2B B3                   CALL_abs               $B32B (rng_threshold_10_29) {bytecode}
  $B354  A6 0D 6E                   LOADR_abs              $6E0D (gold_rice_exchange_rate)
  $B357  C6                         UCMPLT
  $B358  D8 67 B3                   JUMPF_abs              $B367
  $B35B  0D                         LOADL_quick   ; inline operand = 13
  $B35C  B0                         DEREF
  $B35D  52                         LOADR_qimm   ; inline operand = 2
  $B35E  B6                         SDIV
  $B35F  B3                         PUSHL
  $B360  E9 0A 8B 02                CALL_abs_imm1          $8B0A (effect_sell_rice_for_gold) {bytecode}, $02
  $B364  D6 A3 B3                   JUMP_abs               $B3A3
 >$B367  AC 2B B3                   CALL_abs               $B32B (rng_threshold_10_29) {bytecode}
  $B36A  A6 0D 6E                   LOADR_abs              $6E0D (gold_rice_exchange_rate)
  $B36D  C8                         UCMPGT
  $B36E  D8 A3 B3                   JUMPF_abs              $B3A3
  $B371  0B                         LOADL_quick   ; inline operand = 11
  $B372  76                         ADD_qimm   ; inline operand = 6
  $B373  B0                         DEREF
  $B374  B3                         PUSHL
  $B375  0B                         LOADL_quick   ; inline operand = 11
  $B376  8F 18                      BYTE_ADD_imm1          +24
  $B378  B0                         DEREF
  $B379  B4                         POPR
  $B37A  BC                         SUB
  $B37B  B3                         PUSHL
  $B37C  AA 0D 6E                   PUSH_abs               $6E0D (gold_rice_exchange_rate)
  $B37F  0C                         LOADL_quick   ; inline operand = 12
  $B380  B0                         DEREF
  $B381  B3                         PUSHL
  $B382  E9 57 83 06                CALL_abs_imm1          $8357 (ratio_times10_capped) {bytecode}, $06
  $B386  2A                         STORE_quick   ; inline operand = 10
  $B387  3A                         PUSH_quick   ; inline operand = 10
  $B388  AA 0D 6E                   PUSH_abs               $6E0D (gold_rice_exchange_rate)
  $B38B  E9 03 83 04                CALL_abs_imm1          $8303 (math32_muladddiv) {bytecode}, $04
  $B38F  B3                         PUSHL
  $B390  0B                         LOADL_quick   ; inline operand = 11
  $B391  B4                         POPR
  $B392  B3                         PUSHL
  $B393  B0                         DEREF
  $B394  BC                         SUB
  $B395  B1                         POPSTORE
  $B396  3A                         PUSH_quick   ; inline operand = 10
  $B397  0B                         LOADL_quick   ; inline operand = 11
  $B398  76                         ADD_qimm   ; inline operand = 6
  $B399  B4                         POPR
  $B39A  B3                         PUSHL
  $B39B  B0                         DEREF
  $B39C  BB                         ADD
  $B39D  B1                         POPSTORE
  $B39E  62                         PUSH_qimm   ; inline operand = 2
  $B39F  E9 4E 8A 02                CALL_abs_imm1          $8A4E (cycle_economy_rate) {bytecode}, $02
 >$B3A3  3D                         PUSH_quick   ; inline operand = 13
  $B3A4  3C                         PUSH_quick   ; inline operand = 12
  $B3A5  E9 EF B2 04                CALL_abs_imm1          $B2EF (ai_calc_men_surplus_over_gold_and_rice) {bytecode}, $04
  $B3A9  CF                         RETURN

; ============================================================
; sub $B3AA   (frame_off=-8, body @ $B3AF)
; ============================================================
  $B3AF  40                         LOADL_qimm   ; inline operand = 0
  $B3B0  29                         STORE_quick   ; inline operand = 9
  $B3B1  2A                         STORE_quick   ; inline operand = 10
  $B3B2  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $B3B5  8B 1A                      BYTE_LOADR_imm1        +26
  $B3B7  B5                         MULT
  $B3B8  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $B3BB  BB                         ADD
  $B3BC  2B                         STORE_quick   ; inline operand = 11
  $B3BD  DE FA FF                   LEAL_far               $FFFA
  $B3C0  B3                         PUSHL
  $B3C1  DE FC FF                   LEAL_far               $FFFC
  $B3C4  B3                         PUSHL
  $B3C5  E9 EF B2 04                CALL_abs_imm1          $B2EF (ai_calc_men_surplus_over_gold_and_rice) {bytecode}, $04
  $B3C9  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $B3CC  E9 B2 B2 02                CALL_abs_imm1          $B2B2 (ai_seed_fief_tax_rate) {bytecode}, $02
  $B3D0  DE FA FF                   LEAL_far               $FFFA
  $B3D3  B3                         PUSHL
  $B3D4  DE FC FF                   LEAL_far               $FFFC
  $B3D7  B3                         PUSHL
  $B3D8  E9 38 B3 04                CALL_abs_imm1          $B338 (ai_province_gold_to_rice_convert) {bytecode}, $04
  $B3DC  3A                         PUSH_quick   ; inline operand = 10
  $B3DD  0B                         LOADL_quick   ; inline operand = 11
  $B3DE  74                         ADD_qimm   ; inline operand = 4
  $B3DF  B0                         DEREF
  $B3E0  B3                         PUSHL
  $B3E1  0B                         LOADL_quick   ; inline operand = 11
  $B3E2  8F 18                      BYTE_ADD_imm1          +24
  $B3E4  B0                         DEREF
  $B3E5  B3                         PUSHL
  $B3E6  A4 9F 6D                   LOADL_abs              $6D9F (current_game_year)
  $B3E9  90 E9 F9                   ADD_imm2               $F9E9
  $B3EC  8B 64                      BYTE_LOADR_imm1        +100
  $B3EE  B5                         MULT
  $B3EF  8F 64                      BYTE_ADD_imm1          +100
  $B3F1  B3                         PUSHL
  $B3F2  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $B3F6  B3                         PUSHL
  $B3F7  E9 E5 8B 06                CALL_abs_imm1          $8BE5 (effect_send) {bytecode}, $06
  $B3FB  28                         STORE_quick   ; inline operand = 8
  $B3FC  0B                         LOADL_quick   ; inline operand = 11
  $B3FD  8F 18                      BYTE_ADD_imm1          +24
  $B3FF  B0                         DEREF
  $B400  B3                         PUSHL
  $B401  0B                         LOADL_quick   ; inline operand = 11
  $B402  74                         ADD_qimm   ; inline operand = 4
  $B403  B0                         DEREF
  $B404  B4                         POPR
  $B405  C2                         SCMPLT
  $B406  D8 26 B4                   JUMPF_abs              $B426
  $B409  63                         PUSH_qimm   ; inline operand = 3
  $B40A  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B40E  D7 26 B4                   JUMPT_abs              $B426
  $B411  08                         LOADL_quick   ; inline operand = 8
  $B412  50                         LOADR_qimm   ; inline operand = 0
  $B413  C4                         SCMPGT
  $B414  D8 26 B4                   JUMPF_abs              $B426
  $B417  38                         PUSH_quick   ; inline operand = 8
  $B418  0B                         LOADL_quick   ; inline operand = 11
  $B419  74                         ADD_qimm   ; inline operand = 4
  $B41A  B4                         POPR
  $B41B  B3                         PUSHL
  $B41C  B0                         DEREF
  $B41D  BB                         ADD
  $B41E  B1                         POPSTORE
  $B41F  38                         PUSH_quick   ; inline operand = 8
  $B420  0B                         LOADL_quick   ; inline operand = 11
  $B421  B4                         POPR
  $B422  B3                         PUSHL
  $B423  B0                         DEREF
  $B424  BC                         SUB
  $B425  B1                         POPSTORE
 >$B426  AC C9 95                   CALL_abs               $95C9 (ai_develop_grow_if_men_exceeds_gold) {bytecode}
  $B429  41                         LOADL_qimm   ; inline operand = 1
  $B42A  CF                         RETURN

; ============================================================
; sub $B42B   (frame_off=-12, body @ $B430)
; ============================================================
  $B430  40                         LOADL_qimm   ; inline operand = 0
  $B431  29                         STORE_quick   ; inline operand = 9
  $B432  2A                         STORE_quick   ; inline operand = 10
  $B433  DE FA FF                   LEAL_far               $FFFA
  $B436  B3                         PUSHL
  $B437  DE FC FF                   LEAL_far               $FFFC
  $B43A  B3                         PUSHL
  $B43B  E9 EF B2 04                CALL_abs_imm1          $B2EF (ai_calc_men_surplus_over_gold_and_rice) {bytecode}, $04
  $B43F  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $B442  E9 B2 B2 02                CALL_abs_imm1          $B2B2 (ai_seed_fief_tax_rate) {bytecode}, $02
  $B446  0B                         LOADL_quick   ; inline operand = 11
  $B447  78                         ADD_qimm   ; inline operand = 8
  $B448  B0                         DEREF
  $B449  B3                         PUSHL
  $B44A  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $B44D  8B 1A                      BYTE_LOADR_imm1        +26
  $B44F  B5                         MULT
  $B450  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $B453  BB                         ADD
  $B454  2B                         STORE_quick   ; inline operand = 11
  $B455  7C                         ADD_qimm   ; inline operand = 12
  $B456  B0                         DEREF
  $B457  B4                         POPR
  $B458  C4                         SCMPGT
  $B459  D8 C9 B4                   JUMPF_abs              $B4C9
  $B45C  0B                         LOADL_quick   ; inline operand = 11
  $B45D  78                         ADD_qimm   ; inline operand = 8
  $B45E  B0                         DEREF
  $B45F  D8 97 B4                   JUMPF_abs              $B497
  $B462  0B                         LOADL_quick   ; inline operand = 11
  $B463  7A                         ADD_qimm   ; inline operand = 10
  $B464  B0                         DEREF
  $B465  B3                         PUSHL
  $B466  89 64                      BYTE_LOADL_imm1        +100
  $B468  B4                         POPR
  $B469  BC                         SUB
  $B46A  B3                         PUSHL
  $B46B  3B                         PUSH_quick   ; inline operand = 11
  $B46C  E9 D8 87 02                CALL_abs_imm1          $87D8 (effect_dam) {bytecode}, $02
  $B470  B4                         POPR
  $B471  B5                         MULT
  $B472  B3                         PUSHL
  $B473  3A                         PUSH_quick   ; inline operand = 10
  $B474  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $B478  27                         STORE_quick   ; inline operand = 7
  $B479  37                         PUSH_quick   ; inline operand = 7
  $B47A  0B                         LOADL_quick   ; inline operand = 11
  $B47B  B4                         POPR
  $B47C  B3                         PUSHL
  $B47D  B0                         DEREF
  $B47E  BC                         SUB
  $B47F  B1                         POPSTORE
  $B480  3B                         PUSH_quick   ; inline operand = 11
  $B481  E9 D8 87 02                CALL_abs_imm1          $87D8 (effect_dam) {bytecode}, $02
  $B485  B3                         PUSHL
  $B486  07                         LOADL_quick   ; inline operand = 7
  $B487  B4                         POPR
  $B488  B6                         SDIV
  $B489  27                         STORE_quick   ; inline operand = 7
  $B48A  0B                         LOADL_quick   ; inline operand = 11
  $B48B  7A                         ADD_qimm   ; inline operand = 10
  $B48C  B3                         PUSHL
  $B48D  37                         PUSH_quick   ; inline operand = 7
  $B48E  E9 7D 88 04                CALL_abs_imm1          $887D (add_effect_gain_clamped) {bytecode}, $04
  $B492  07                         LOADL_quick   ; inline operand = 7
  $B493  CD                         SWAP
  $B494  0A                         LOADL_quick   ; inline operand = 10
  $B495  BC                         SUB
  $B496  2A                         STORE_quick   ; inline operand = 10
 >$B497  3A                         PUSH_quick   ; inline operand = 10
  $B498  0B                         LOADL_quick   ; inline operand = 11
  $B499  78                         ADD_qimm   ; inline operand = 8
  $B49A  B0                         DEREF
  $B49B  B3                         PUSHL
  $B49C  0B                         LOADL_quick   ; inline operand = 11
  $B49D  8F 18                      BYTE_ADD_imm1          +24
  $B49F  B0                         DEREF
  $B4A0  B3                         PUSHL
  $B4A1  A4 9F 6D                   LOADL_abs              $6D9F (current_game_year)
  $B4A4  90 E9 F9                   ADD_imm2               $F9E9
  $B4A7  8B 32                      BYTE_LOADR_imm1        +50
  $B4A9  B5                         MULT
  $B4AA  90 FA 00                   ADD_imm2               $00FA
  $B4AD  B3                         PUSHL
  $B4AE  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $B4B2  B3                         PUSHL
  $B4B3  E9 E5 8B 06                CALL_abs_imm1          $8BE5 (effect_send) {bytecode}, $06
  $B4B7  26                         STORE_quick   ; inline operand = 6
  $B4B8  36                         PUSH_quick   ; inline operand = 6
  $B4B9  0B                         LOADL_quick   ; inline operand = 11
  $B4BA  78                         ADD_qimm   ; inline operand = 8
  $B4BB  B4                         POPR
  $B4BC  B3                         PUSHL
  $B4BD  B0                         DEREF
  $B4BE  BB                         ADD
  $B4BF  B1                         POPSTORE
  $B4C0  36                         PUSH_quick   ; inline operand = 6
  $B4C1  3B                         PUSH_quick   ; inline operand = 11
  $B4C2  E9 F0 87 04                CALL_abs_imm1          $87F0 (effect_grow) {bytecode}, $04
  $B4C6  D6 CC B4                   JUMP_abs               $B4CC
 >$B4C9  AC C9 95                   CALL_abs               $95C9 (ai_develop_grow_if_men_exceeds_gold) {bytecode}
 >$B4CC  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $B4CF  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $B4D3  41                         LOADL_qimm   ; inline operand = 1
  $B4D4  CF                         RETURN

; ============================================================
; sub $B4D5   (frame_off=-8, body @ $B4DA)
; ============================================================
  $B4DA  AC 9A 94                   CALL_abs               $949A (ai_try_war_attack) {bytecode}
  $B4DD  D8 E2 B4                   JUMPF_abs              $B4E2
  $B4E0  41                         LOADL_qimm   ; inline operand = 1
  $B4E1  CF                         RETURN
 >$B4E2  40                         LOADL_qimm   ; inline operand = 0
  $B4E3  29                         STORE_quick   ; inline operand = 9
  $B4E4  2A                         STORE_quick   ; inline operand = 10
  $B4E5  DE FA FF                   LEAL_far               $FFFA
  $B4E8  B3                         PUSHL
  $B4E9  DE FC FF                   LEAL_far               $FFFC
  $B4EC  B3                         PUSHL
  $B4ED  E9 EF B2 04                CALL_abs_imm1          $B2EF (ai_calc_men_surplus_over_gold_and_rice) {bytecode}, $04
  $B4F1  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $B4F4  8B 1A                      BYTE_LOADR_imm1        +26
  $B4F6  B5                         MULT
  $B4F7  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $B4FA  BB                         ADD
  $B4FB  2B                         STORE_quick   ; inline operand = 11
  $B4FC  0B                         LOADL_quick   ; inline operand = 11
  $B4FD  8F 10                      BYTE_ADD_imm1          +16
  $B4FF  B0                         DEREF
  $B500  B3                         PUSHL
  $B501  0B                         LOADL_quick   ; inline operand = 11
  $B502  8F 18                      BYTE_ADD_imm1          +24
  $B504  B0                         DEREF
  $B505  B3                         PUSHL
  $B506  A4 9F 6D                   LOADL_abs              $6D9F (current_game_year)
  $B509  90 E9 F9                   ADD_imm2               $F9E9
  $B50C  8B 28                      BYTE_LOADR_imm1        +40
  $B50E  B5                         MULT
  $B50F  B3                         PUSHL
  $B510  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $B514  B4                         POPR
  $B515  C4                         SCMPGT
  $B516  D8 71 B5                   JUMPF_abs              $B571
  $B519  0B                         LOADL_quick   ; inline operand = 11
  $B51A  8F 10                      BYTE_ADD_imm1          +16
  $B51C  B0                         DEREF
  $B51D  B3                         PUSHL
  $B51E  0B                         LOADL_quick   ; inline operand = 11
  $B51F  8F 18                      BYTE_ADD_imm1          +24
  $B521  B0                         DEREF
  $B522  B3                         PUSHL
  $B523  A4 9F 6D                   LOADL_abs              $6D9F (current_game_year)
  $B526  90 E9 F9                   ADD_imm2               $F9E9
  $B529  8B 64                      BYTE_LOADR_imm1        +100
  $B52B  B5                         MULT
  $B52C  B3                         PUSHL
  $B52D  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $B531  B4                         POPR
  $B532  BC                         SUB
  $B533  B3                         PUSHL
  $B534  AA 11 6E                   PUSH_abs               $6E11 (gold_men_hire_rate)
  $B537  0A                         LOADL_quick   ; inline operand = 10
  $B538  52                         LOADR_qimm   ; inline operand = 2
  $B539  B6                         SDIV
  $B53A  B3                         PUSHL
  $B53B  E9 57 83 06                CALL_abs_imm1          $8357 (ratio_times10_capped) {bytecode}, $06
  $B53F  28                         STORE_quick   ; inline operand = 8
  $B540  08                         LOADL_quick   ; inline operand = 8
  $B541  50                         LOADR_qimm   ; inline operand = 0
  $B542  C4                         SCMPGT
  $B543  D8 71 B5                   JUMPF_abs              $B571
  $B546  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $B549  73                         ADD_qimm   ; inline operand = 3
  $B54A  B3                         PUSHL
  $B54B  6A                         PUSH_qimm   ; inline operand = 10
  $B54C  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B550  B4                         POPR
  $B551  C6                         UCMPLT
  $B552  D8 71 B5                   JUMPF_abs              $B571
  $B555  0A                         LOADL_quick   ; inline operand = 10
  $B556  52                         LOADR_qimm   ; inline operand = 2
  $B557  B6                         SDIV
  $B558  B3                         PUSHL
  $B559  0B                         LOADL_quick   ; inline operand = 11
  $B55A  B4                         POPR
  $B55B  B3                         PUSHL
  $B55C  B0                         DEREF
  $B55D  BC                         SUB
  $B55E  B1                         POPSTORE
  $B55F  38                         PUSH_quick   ; inline operand = 8
  $B560  3B                         PUSH_quick   ; inline operand = 11
  $B561  E9 F4 8B 04                CALL_abs_imm1          $8BF4 (apply_hire_unit_stats) {bytecode}, $04
  $B565  DE FA FF                   LEAL_far               $FFFA
  $B568  B3                         PUSHL
  $B569  DE FC FF                   LEAL_far               $FFFC
  $B56C  B3                         PUSHL
  $B56D  E9 EF B2 04                CALL_abs_imm1          $B2EF (ai_calc_men_surplus_over_gold_and_rice) {bytecode}, $04
 >$B571  0B                         LOADL_quick   ; inline operand = 11
  $B572  8F 10                      BYTE_ADD_imm1          +16
  $B574  B0                         DEREF
  $B575  B3                         PUSHL
  $B576  09                         LOADL_quick   ; inline operand = 9
  $B577  B4                         POPR
  $B578  B6                         SDIV
  $B579  B3                         PUSHL
  $B57A  0B                         LOADL_quick   ; inline operand = 11
  $B57B  8F 12                      BYTE_ADD_imm1          +18
  $B57D  B0                         DEREF
  $B57E  B3                         PUSHL
  $B57F  0B                         LOADL_quick   ; inline operand = 11
  $B580  8F 18                      BYTE_ADD_imm1          +24
  $B582  B0                         DEREF
  $B583  B3                         PUSHL
  $B584  E9 E5 8B 06                CALL_abs_imm1          $8BE5 (effect_send) {bytecode}, $06
  $B588  28                         STORE_quick   ; inline operand = 8
  $B589  38                         PUSH_quick   ; inline operand = 8
  $B58A  0B                         LOADL_quick   ; inline operand = 11
  $B58B  8F 12                      BYTE_ADD_imm1          +18
  $B58D  B4                         POPR
  $B58E  B3                         PUSHL
  $B58F  B0                         DEREF
  $B590  BB                         ADD
  $B591  B1                         POPSTORE
  $B592  0B                         LOADL_quick   ; inline operand = 11
  $B593  8F 10                      BYTE_ADD_imm1          +16
  $B595  B0                         DEREF
  $B596  18                         LOADR_quick   ; inline operand = 8
  $B597  B5                         MULT
  $B598  B3                         PUSHL
  $B599  0B                         LOADL_quick   ; inline operand = 11
  $B59A  76                         ADD_qimm   ; inline operand = 6
  $B59B  B4                         POPR
  $B59C  B3                         PUSHL
  $B59D  B0                         DEREF
  $B59E  BC                         SUB
  $B59F  B1                         POPSTORE
  $B5A0  0B                         LOADL_quick   ; inline operand = 11
  $B5A1  8F 18                      BYTE_ADD_imm1          +24
  $B5A3  B0                         DEREF
  $B5A4  B3                         PUSHL
  $B5A5  AA 0F 6E                   PUSH_abs               $6E0F (arms_buy_price_rate)
  $B5A8  0B                         LOADL_quick   ; inline operand = 11
  $B5A9  8F 10                      BYTE_ADD_imm1          +16
  $B5AB  B0                         DEREF
  $B5AC  B3                         PUSHL
  $B5AD  E9 27 83 06                CALL_abs_imm1          $8327 (scale_div10_capcheck) {bytecode}, $06
  $B5B1  28                         STORE_quick   ; inline operand = 8
  $B5B2  0B                         LOADL_quick   ; inline operand = 11
  $B5B3  B0                         DEREF
  $B5B4  18                         LOADR_quick   ; inline operand = 8
  $B5B5  C5                         SCMPGE
  $B5B6  D8 F1 B5                   JUMPF_abs              $B5F1
  $B5B9  08                         LOADL_quick   ; inline operand = 8
  $B5BA  8B FF                      BYTE_LOADR_imm1        -1
  $B5BC  C1                         CMPNE
  $B5BD  D8 F1 B5                   JUMPF_abs              $B5F1
  $B5C0  0A                         LOADL_quick   ; inline operand = 10
  $B5C1  18                         LOADR_quick   ; inline operand = 8
  $B5C2  B6                         SDIV
  $B5C3  28                         STORE_quick   ; inline operand = 8
  $B5C4  D8 F1 B5                   JUMPF_abs              $B5F1
  $B5C7  0B                         LOADL_quick   ; inline operand = 11
  $B5C8  B0                         DEREF
  $B5C9  B3                         PUSHL
  $B5CA  AA 0F 6E                   PUSH_abs               $6E0F (arms_buy_price_rate)
  $B5CD  38                         PUSH_quick   ; inline operand = 8
  $B5CE  E9 27 83 06                CALL_abs_imm1          $8327 (scale_div10_capcheck) {bytecode}, $06
  $B5D2  B3                         PUSHL
  $B5D3  0B                         LOADL_quick   ; inline operand = 11
  $B5D4  B4                         POPR
  $B5D5  B3                         PUSHL
  $B5D6  B0                         DEREF
  $B5D7  BC                         SUB
  $B5D8  B1                         POPSTORE
  $B5D9  08                         LOADL_quick   ; inline operand = 8
  $B5DA  D2                         LSHIFT1
  $B5DB  B3                         PUSHL
  $B5DC  0B                         LOADL_quick   ; inline operand = 11
  $B5DD  8F 16                      BYTE_ADD_imm1          +22
  $B5DF  B4                         POPR
  $B5E0  B3                         PUSHL
  $B5E1  B0                         DEREF
  $B5E2  BB                         ADD
  $B5E3  B1                         POPSTORE
  $B5E4  0B                         LOADL_quick   ; inline operand = 11
  $B5E5  8F 16                      BYTE_ADD_imm1          +22
  $B5E7  B3                         PUSHL
  $B5E8  E9 AC 82 02                CALL_abs_imm1          $82AC (clamp_amount_to_province_max) {bytecode}, $02
  $B5EC  63                         PUSH_qimm   ; inline operand = 3
  $B5ED  E9 4E 8A 02                CALL_abs_imm1          $8A4E (cycle_economy_rate) {bytecode}, $02
 >$B5F1  DE FA FF                   LEAL_far               $FFFA
  $B5F4  B3                         PUSHL
  $B5F5  DE FC FF                   LEAL_far               $FFFC
  $B5F8  B3                         PUSHL
  $B5F9  E9 EF B2 04                CALL_abs_imm1          $B2EF (ai_calc_men_surplus_over_gold_and_rice) {bytecode}, $04
  $B5FD  0B                         LOADL_quick   ; inline operand = 11
  $B5FE  8F 10                      BYTE_ADD_imm1          +16
  $B600  B0                         DEREF
  $B601  B3                         PUSHL
  $B602  0A                         LOADL_quick   ; inline operand = 10
  $B603  B4                         POPR
  $B604  B6                         SDIV
  $B605  B3                         PUSHL
  $B606  0B                         LOADL_quick   ; inline operand = 11
  $B607  8F 12                      BYTE_ADD_imm1          +18
  $B609  B0                         DEREF
  $B60A  B3                         PUSHL
  $B60B  0B                         LOADL_quick   ; inline operand = 11
  $B60C  8F 18                      BYTE_ADD_imm1          +24
  $B60E  B0                         DEREF
  $B60F  B3                         PUSHL
  $B610  E9 E5 8B 06                CALL_abs_imm1          $8BE5 (effect_send) {bytecode}, $06
  $B614  28                         STORE_quick   ; inline operand = 8
  $B615  6A                         PUSH_qimm   ; inline operand = 10
  $B616  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B61A  18                         LOADR_quick   ; inline operand = 8
  $B61B  BB                         ADD
  $B61C  B3                         PUSHL
  $B61D  0B                         LOADL_quick   ; inline operand = 11
  $B61E  8F 12                      BYTE_ADD_imm1          +18
  $B620  B4                         POPR
  $B621  B3                         PUSHL
  $B622  B0                         DEREF
  $B623  BB                         ADD
  $B624  B1                         POPSTORE
  $B625  0B                         LOADL_quick   ; inline operand = 11
  $B626  8F 10                      BYTE_ADD_imm1          +16
  $B628  B0                         DEREF
  $B629  18                         LOADR_quick   ; inline operand = 8
  $B62A  B5                         MULT
  $B62B  B3                         PUSHL
  $B62C  0B                         LOADL_quick   ; inline operand = 11
  $B62D  B4                         POPR
  $B62E  B3                         PUSHL
  $B62F  B0                         DEREF
  $B630  BC                         SUB
  $B631  B1                         POPSTORE
  $B632  62                         PUSH_qimm   ; inline operand = 2
  $B633  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B637  D8 3D B6                   JUMPF_abs              $B63D
  $B63A  AC 86 95                   CALL_abs               $9586 (effect_train) {bytecode}
 >$B63D  8D 64                      BYTE_PUSH_imm1         +100
  $B63F  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B643  D7 49 B6                   JUMPT_abs              $B649
  $B646  AC 0C 96                   CALL_abs               $960C (ai_reinforce_province_arms_and_econ_10pct) {bytecode}
 >$B649  40                         LOADL_qimm   ; inline operand = 0
  $B64A  CF                         RETURN

; ============================================================
; sub $B64B   (frame_off=-2, body @ $B650)
; ============================================================
  $B650  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $B653  8B 1A                      BYTE_LOADR_imm1        +26
  $B655  B5                         MULT
  $B656  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $B659  BB                         ADD
  $B65A  2B                         STORE_quick   ; inline operand = 11
  $B65B  0B                         LOADL_quick   ; inline operand = 11
  $B65C  76                         ADD_qimm   ; inline operand = 6
  $B65D  B0                         DEREF
  $B65E  D7 6E B6                   JUMPT_abs              $B66E
  $B661  6A                         PUSH_qimm   ; inline operand = 10
  $B662  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B666  B3                         PUSHL
  $B667  0B                         LOADL_quick   ; inline operand = 11
  $B668  76                         ADD_qimm   ; inline operand = 6
  $B669  B4                         POPR
  $B66A  B3                         PUSHL
  $B66B  B0                         DEREF
  $B66C  BB                         ADD
  $B66D  B1                         POPSTORE
 >$B66E  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $B671  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $B674  BB                         ADD
  $B675  D3                         BYTE_DEREF
  $B676  D8 96 B6                   JUMPF_abs              $B696
  $B679  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $B67C  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $B680  D7 96 B6                   JUMPT_abs              $B696
  $B683  0B                         LOADL_quick   ; inline operand = 11
  $B684  8F 10                      BYTE_ADD_imm1          +16
  $B686  B0                         DEREF
  $B687  D7 96 B6                   JUMPT_abs              $B696
  $B68A  0B                         LOADL_quick   ; inline operand = 11
  $B68B  8F 10                      BYTE_ADD_imm1          +16
  $B68D  B3                         PUSHL
  $B68E  42                         LOADL_qimm   ; inline operand = 2
  $B68F  B1                         POPSTORE
  $B690  0B                         LOADL_quick   ; inline operand = 11
  $B691  76                         ADD_qimm   ; inline operand = 6
  $B692  B3                         PUSHL
  $B693  B0                         DEREF
  $B694  D0                         INC
  $B695  B1                         POPSTORE
 >$B696  6A                         PUSH_qimm   ; inline operand = 10
  $B697  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B69B  D8 A5 B6                   JUMPF_abs              $B6A5
  $B69E  AC D5 B4                   CALL_abs               $B4D5 (ai_state2_recruit_arm_train) {bytecode}
  $B6A1  D8 A5 B6                   JUMPF_abs              $B6A5
  $B6A4  CF                         RETURN
 >$B6A5  6A                         PUSH_qimm   ; inline operand = 10
  $B6A6  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B6AA  D8 B0 B6                   JUMPF_abs              $B6B0
  $B6AD  AC AA B3                   CALL_abs               $B3AA (ai_develop_town_handler) {bytecode}
 >$B6B0  AC 2B B4                   CALL_abs               $B42B (ai_develop_dam_and_grow) {bytecode}
  $B6B3  CF                         RETURN

; ============================================================
; sub $B6B4   (frame_off=-4, body @ $B6B9)
; ============================================================
  $B6B9  67                         PUSH_qimm   ; inline operand = 7
  $B6BA  8D 15                      BYTE_PUSH_imm1         +21
  $B6BC  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $B6C0  62                         PUSH_qimm   ; inline operand = 2
  $B6C1  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $B6C5  AC 87 D2                   CALL_abs               $D287 (wait_button_edge) {bytecode}
  $B6C8  A4 E2 7B                   LOADL_abs              $7BE2 (fief_menu_info_mode_flag)
  $B6CB  D8 D2 B6                   JUMPF_abs              $B6D2
  $B6CE  4C                         LOADL_qimm   ; inline operand = 12
  $B6CF  D6 D3 B6                   JUMP_abs               $B6D3
 >$B6D2  40                         LOADL_qimm   ; inline operand = 0
 >$B6D3  2A                         STORE_quick   ; inline operand = 10
  $B6D4  40                         LOADL_qimm   ; inline operand = 0
  $B6D5  2B                         STORE_quick   ; inline operand = 11
 >$B6D6  AC 4E D1                   CALL_abs               $D14E (poll_input) {bytecode}
  $B6D9  D9 06 00 01 00 F9 B6 02 00 F6 B6 10 ... SWITCH_noncontig       count=6   ; .table 6 (key,target) + default (noncontiguous); SWITCH 1=>$B6F9 2=>$B6F6 16=>$B75D 32=>$B773 64=>$B709 128=>$B709 default=>$B703
 >$B6F6  89 11                      BYTE_LOADL_imm1        +17
  $B6F8  2A                         STORE_quick   ; inline operand = 10
 >$B6F9  60                         PUSH_qimm   ; inline operand = 0
  $B6FA  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $B6FE  41                         LOADL_qimm   ; inline operand = 1
  $B6FF  2B                         STORE_quick   ; inline operand = 11
  $B700  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
 >$B703  0B                         LOADL_quick   ; inline operand = 11
  $B704  D8 D6 B6                   JUMPF_abs              $B6D6
  $B707  0A                         LOADL_quick   ; inline operand = 10
  $B708  CF                         RETURN
 >$B709  60                         PUSH_qimm   ; inline operand = 0
  $B70A  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $B70E  A4 E2 7B                   LOADL_abs              $7BE2 (fief_menu_info_mode_flag)
  $B711  D7 24 B7                   JUMPT_abs              $B724
  $B714  61                         PUSH_qimm   ; inline operand = 1
  $B715  E9 1E 87 02                CALL_abs_imm1          $871E (fief_info_display) {bytecode}, $02
 >$B719  67                         PUSH_qimm   ; inline operand = 7
  $B71A  8D 15                      BYTE_PUSH_imm1         +21
  $B71C  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $B720  4C                         LOADL_qimm   ; inline operand = 12
  $B721  D6 4F B7                   JUMP_abs               $B74F
 >$B724  60                         PUSH_qimm   ; inline operand = 0
  $B725  E9 1E 87 02                CALL_abs_imm1          $871E (fief_info_display) {bytecode}, $02
 >$B729  67                         PUSH_qimm   ; inline operand = 7
  $B72A  8D 15                      BYTE_PUSH_imm1         +21
  $B72C  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $B730  40                         LOADL_qimm   ; inline operand = 0
  $B731  D6 4F B7                   JUMP_abs               $B74F
 >$B734  A4 E2 7B                   LOADL_abs              $7BE2 (fief_menu_info_mode_flag)
  $B737  D7 46 B7                   JUMPT_abs              $B746
  $B73A  8D 12                      BYTE_PUSH_imm1         +18
  $B73C  8D 15                      BYTE_PUSH_imm1         +21
  $B73E  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $B742  4B                         LOADL_qimm   ; inline operand = 11
  $B743  D6 4F B7                   JUMP_abs               $B74F
 >$B746  6F                         PUSH_qimm   ; inline operand = 15
  $B747  8D 15                      BYTE_PUSH_imm1         +21
  $B749  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $B74D  89 14                      BYTE_LOADL_imm1        +20
 >$B74F  2A                         STORE_quick   ; inline operand = 10
  $B750  62                         PUSH_qimm   ; inline operand = 2
  $B751  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $B755  62                         PUSH_qimm   ; inline operand = 2
  $B756  E9 3E D7 02                CALL_abs_imm1          $D73E (delay_loop) {bytecode}, $02
  $B75A  D6 03 B7                   JUMP_abs               $B703
 >$B75D  60                         PUSH_qimm   ; inline operand = 0
  $B75E  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $B762  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $B765  D1                         DEC
  $B766  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $B769  56                         LOADR_qimm   ; inline operand = 6
  $B76A  C0                         CMPEQ
  $B76B  D7 34 B7                   JUMPT_abs              $B734
  $B76E  0A                         LOADL_quick   ; inline operand = 10
  $B76F  D1                         DEC
  $B770  D6 4F B7                   JUMP_abs               $B74F
 >$B773  60                         PUSH_qimm   ; inline operand = 0
  $B774  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $B778  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $B77B  D0                         INC
  $B77C  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $B77F  8B 13                      BYTE_LOADR_imm1        +19
  $B781  C0                         CMPEQ
  $B782  D7 29 B7                   JUMPT_abs              $B729
  $B785  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $B788  8B 10                      BYTE_LOADR_imm1        +16
  $B78A  C0                         CMPEQ
  $B78B  D8 96 B7                   JUMPF_abs              $B796
  $B78E  A4 E2 7B                   LOADL_abs              $7BE2 (fief_menu_info_mode_flag)
  $B791  51                         LOADR_qimm   ; inline operand = 1
  $B792  C0                         CMPEQ
  $B793  D7 19 B7                   JUMPT_abs              $B719
 >$B796  0A                         LOADL_quick   ; inline operand = 10
  $B797  D0                         INC
  $B798  D6 4F B7                   JUMP_abs               $B74F

; ============================================================
; sub $B79B   (frame_off=-16, body @ $B7A0)
; ============================================================
  $B7A0  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $B7A3  A8 DD 7F                   STORE_abs              $7FDD (selected_province_idx_latch_7fdd)
  $B7A6  3C                         PUSH_quick   ; inline operand = 12
  $B7A7  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $B7AB  8C 67 6D                   LOADR_imm2             $6D67 (rest_turns_remaining)
  $B7AE  BB                         ADD
  $B7AF  28                         STORE_quick   ; inline operand = 8
  $B7B0  08                         LOADL_quick   ; inline operand = 8
  $B7B1  D3                         BYTE_DEREF
  $B7B2  D8 DA B7                   JUMPF_abs              $B7DA
  $B7B5  0C                         LOADL_quick   ; inline operand = 12
  $B7B6  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $B7B9  BB                         ADD
  $B7BA  D3                         BYTE_DEREF
  $B7BB  D8 74 B8                   JUMPF_abs              $B874
  $B7BE  3C                         PUSH_quick   ; inline operand = 12
  $B7BF  E9 FA 83 02                CALL_abs_imm1          $83FA (effect_view_a) {bytecode}, $02
  $B7C3  AC 59 D7                   CALL_abs               $D759 (standard_delay) {bytecode}
  $B7C6  08                         LOADL_quick   ; inline operand = 8
  $B7C7  B3                         PUSHL
  $B7C8  D3                         BYTE_DEREF
  $B7C9  D1                         DEC
  $B7CA  D4                         BYTE_POPSTORE
  $B7CB  64                         PUSH_qimm   ; inline operand = 4
  $B7CC  3C                         PUSH_quick   ; inline operand = 12
  $B7CD  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $B7D1  D0                         INC
  $B7D2  B4                         POPR
  $B7D3  B3                         PUSHL
  $B7D4  D3                         BYTE_DEREF
  $B7D5  BB                         ADD
  $B7D6  D4                         BYTE_POPSTORE
  $B7D7  D6 74 B8                   JUMP_abs               $B874
 >$B7DA  AC A7 85                   CALL_abs               $85A7 (effect_view_c) {bytecode}
  $B7DD  8D 1B                      BYTE_PUSH_imm1         +27
  $B7DF  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $B7E3  40                         LOADL_qimm   ; inline operand = 0
  $B7E4  27                         STORE_quick   ; inline operand = 7
  $B7E5  D6 10 B8                   JUMP_abs               $B810
 >$B7E8  07                         LOADL_quick   ; inline operand = 7
  $B7E9  8B 11                      BYTE_LOADR_imm1        +17
  $B7EB  C0                         CMPEQ
  $B7EC  D8 F2 B7                   JUMPF_abs              $B7F2
  $B7EF  AC A7 85                   CALL_abs               $85A7 (effect_view_c) {bytecode}
 >$B7F2  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $B7F5  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $B7F8  E9 8B D7 02                CALL_abs_imm1          $D78B (daimyo_name_width) {bytecode}, $02
  $B7FC  8E 91 BF                   PUSH_imm2              $BF91 (msg_your_orders)
  $B7FF  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $B803  AC B4 B6                   CALL_abs               $B6B4 (command_menu_select_loop) {bytecode}
  $B806  27                         STORE_quick   ; inline operand = 7
  $B807  D2                         LSHIFT1
  $B808  8C B2 B9                   LOADR_imm2             $B9B2 (command_driver_table)
  $B80B  BB                         ADD
  $B80C  B0                         DEREF
  $B80D  25                         STORE_quick   ; inline operand = 5
  $B80E  05                         LOADL_quick   ; inline operand = 5
  $B80F  DD                         CALLPTR
 >$B810  26                         STORE_quick   ; inline operand = 6
  $B811  06                         LOADL_quick   ; inline operand = 6
  $B812  D8 E8 B7                   JUMPF_abs              $B7E8
  $B815  07                         LOADL_quick   ; inline operand = 7
  $B816  51                         LOADR_qimm   ; inline operand = 1
  $B817  C0                         CMPEQ
  $B818  D7 74 B8                   JUMPT_abs              $B874
  $B81B  07                         LOADL_quick   ; inline operand = 7
  $B81C  8B 14                      BYTE_LOADR_imm1        +20
  $B81E  C0                         CMPEQ
  $B81F  D7 74 B8                   JUMPT_abs              $B874
  $B822  3C                         PUSH_quick   ; inline operand = 12
  $B823  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $B827  3C                         PUSH_quick   ; inline operand = 12
  $B828  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $B82C  2A                         STORE_quick   ; inline operand = 10
  $B82D  0C                         LOADL_quick   ; inline operand = 12
  $B82E  8B 1A                      BYTE_LOADR_imm1        +26
  $B830  B5                         MULT
  $B831  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $B834  BB                         ADD
  $B835  24                         STORE_quick   ; inline operand = 4
  $B836  29                         STORE_quick   ; inline operand = 9
  $B837  40                         LOADL_qimm   ; inline operand = 0
  $B838  2B                         STORE_quick   ; inline operand = 11
 >$B839  0B                         LOADL_quick   ; inline operand = 11
  $B83A  56                         LOADR_qimm   ; inline operand = 6
  $B83B  C6                         UCMPLT
  $B83C  D8 55 B8                   JUMPF_abs              $B855
  $B83F  0B                         LOADL_quick   ; inline operand = 11
  $B840  7D                         ADD_qimm   ; inline operand = 13
  $B841  B3                         PUSHL
  $B842  66                         PUSH_qimm   ; inline operand = 6
  $B843  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $B847  0A                         LOADL_quick   ; inline operand = 10
  $B848  D0                         INC
  $B849  2A                         STORE_quick   ; inline operand = 10
  $B84A  D1                         DEC
  $B84B  D3                         BYTE_DEREF
  $B84C  B3                         PUSHL
  $B84D  3C                         PUSH_quick   ; inline operand = 12
  $B84E  E9 D5 83 04                CALL_abs_imm1          $83D5 (draw_province_stat3_or_dashes) {bytecode}, $04
  $B852  D6 6A B8                   JUMP_abs               $B86A
 >$B855  0B                         LOADL_quick   ; inline operand = 11
  $B856  D0                         INC
  $B857  B3                         PUSHL
  $B858  8D 10                      BYTE_PUSH_imm1         +16
  $B85A  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $B85E  09                         LOADL_quick   ; inline operand = 9
  $B85F  72                         ADD_qimm   ; inline operand = 2
  $B860  29                         STORE_quick   ; inline operand = 9
  $B861  8F FE                      BYTE_ADD_imm1          -2
  $B863  B0                         DEREF
  $B864  B3                         PUSHL
  $B865  3C                         PUSH_quick   ; inline operand = 12
  $B866  E9 A2 83 04                CALL_abs_imm1          $83A2 (draw_province_stat_or_dashes) {bytecode}, $04
 >$B86A  0B                         LOADL_quick   ; inline operand = 11
  $B86B  D0                         INC
  $B86C  2B                         STORE_quick   ; inline operand = 11
  $B86D  0B                         LOADL_quick   ; inline operand = 11
  $B86E  8B 12                      BYTE_LOADR_imm1        +18
  $B870  C6                         UCMPLT
  $B871  D7 39 B8                   JUMPT_abs              $B839
 >$B874  CF                         RETURN

; ============================================================
; sub $B875   (frame_off=-2, body @ $B87A)
; ============================================================
  $B87A  AC 4B B6                   CALL_abs               $B64B (ai_econ_command_dispatch) {bytecode}
  $B87D  AC 68 8C                   CALL_abs               $8C68 (random_daimyo_stat_increment) {bytecode}
  $B880  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $B883  8B 1A                      BYTE_LOADR_imm1        +26
  $B885  B5                         MULT
  $B886  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $B889  BB                         ADD
  $B88A  2B                         STORE_quick   ; inline operand = 11
  $B88B  64                         PUSH_qimm   ; inline operand = 4
  $B88C  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B890  D7 9A B8                   JUMPT_abs              $B89A
  $B893  0B                         LOADL_quick   ; inline operand = 11
  $B894  8F 16                      BYTE_ADD_imm1          +22
  $B896  B3                         PUSHL
  $B897  B0                         DEREF
  $B898  D0                         INC
  $B899  B1                         POPSTORE
 >$B89A  CF                         RETURN

; ============================================================
; sub $B89B   (frame_off=-4, body @ $B8A0)
; ============================================================
  $B8A0  41                         LOADL_qimm   ; inline operand = 1
  $B8A1  A8 D3 7F                   STORE_abs              $7FD3 (ui_input_mode)
  $B8A4  A4 01 60                   LOADL_abs              $6001 (ai_per_fief_loop_index)
  $B8A7  D6 9E B9                   JUMP_abs               $B99E
 >$B8AA  89 FE                      BYTE_LOADL_imm1        -2
  $B8AC  CD                         SWAP
  $B8AD  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $B8B0  DA                         AND
  $B8B1  A9 A1 6D                   BYTE_STORE_abs         $6DA1 (ai_turn_flags)
  $B8B4  A4 63 6D                   LOADL_abs              $6D63 (const_two)
  $B8B7  55                         LOADR_qimm   ; inline operand = 5
  $B8B8  B5                         MULT
  $B8B9  B3                         PUSHL
  $B8BA  89 37                      BYTE_LOADL_imm1        +55
  $B8BC  B4                         POPR
  $B8BD  BC                         SUB
  $B8BE  B3                         PUSHL
  $B8BF  8D 64                      BYTE_PUSH_imm1         +100
  $B8C1  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B8C5  B4                         POPR
  $B8C6  C6                         UCMPLT
  $B8C7  CD                         SWAP
  $B8C8  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $B8CB  DB                         OR
  $B8CC  A9 A1 6D                   BYTE_STORE_abs         $6DA1 (ai_turn_flags)
  $B8CF  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $B8D2  E9 72 D9 02                CALL_abs_imm1          $D972 (fief_owner_weakness) {bytecode}, $02
  $B8D6  D8 EE B8                   JUMPF_abs              $B8EE
  $B8D9  64                         PUSH_qimm   ; inline operand = 4
  $B8DA  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $B8DE  D7 E5 B8                   JUMPT_abs              $B8E5
  $B8E1  41                         LOADL_qimm   ; inline operand = 1
  $B8E2  D6 E6 B8                   JUMP_abs               $B8E6
 >$B8E5  40                         LOADL_qimm   ; inline operand = 0
 >$B8E6  CD                         SWAP
  $B8E7  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $B8EA  DB                         OR
  $B8EB  A9 A1 6D                   BYTE_STORE_abs         $6DA1 (ai_turn_flags)
 >$B8EE  AC 28 D6                   CALL_abs               $D628 (count_6da2_set) {bytecode}
  $B8F1  D7 FA B8                   JUMPT_abs              $B8FA
  $B8F4  AC 82 D9                   CALL_abs               $D982 (is_ai_count_ge_8) {bytecode}
  $B8F7  D8 0E B9                   JUMPF_abs              $B90E
 >$B8FA  89 80                      BYTE_LOADL_imm1        -128
  $B8FC  CD                         SWAP
  $B8FD  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $B900  DB                         OR
  $B901  A9 A1 6D                   BYTE_STORE_abs         $6DA1 (ai_turn_flags)
  $B904  AC 28 D6                   CALL_abs               $D628 (count_6da2_set) {bytecode}
  $B907  D8 0D B9                   JUMPF_abs              $B90D
  $B90A  AC 09 D6                   CALL_abs               $D609 (ui_prompt_redraw) {bytecode}
 >$B90D  CF                         RETURN
 >$B90E  40                         LOADL_qimm   ; inline operand = 0
  $B90F  A8 79 6F                   STORE_abs              $6F79 (ai_turn_loop_redispatch_flag)
  $B912  0B                         LOADL_quick   ; inline operand = 11
  $B913  8C 1B 6F                   LOADR_imm2             $6F1B (daimyo_turn_order)
  $B916  BB                         ADD
  $B917  D3                         BYTE_DEREF
  $B918  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $B91B  2A                         STORE_quick   ; inline operand = 10
  $B91C  8D 1A                      BYTE_PUSH_imm1         +26
  $B91E  62                         PUSH_qimm   ; inline operand = 2
  $B91F  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $B923  0A                         LOADL_quick   ; inline operand = 10
  $B924  D0                         INC
  $B925  B3                         PUSHL
  $B926  0B                         LOADL_quick   ; inline operand = 11
  $B927  D0                         INC
  $B928  B3                         PUSHL
  $B929  8E 9F BF                   PUSH_imm2              $BF9F (msg_turn_2d_fief_2d)
  $B92C  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $B930  A4 F9 7B                   LOADL_abs              $7BF9 (ui_state_flag_7bf9)
  $B933  D7 39 B9                   JUMPT_abs              $B939
  $B936  AC 94 80                   CALL_abs               $8094 (draw_market_rates) {bytecode}
 >$B939  3A                         PUSH_quick   ; inline operand = 10
  $B93A  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $B93E  8C 67 6D                   LOADR_imm2             $6D67 (rest_turns_remaining)
  $B941  BB                         ADD
  $B942  D3                         BYTE_DEREF
  $B943  D7 7D B9                   JUMPT_abs              $B97D
  $B946  0A                         LOADL_quick   ; inline operand = 10
  $B947  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $B94A  BB                         ADD
  $B94B  D3                         BYTE_DEREF
  $B94C  D5 00 00 06 00 8D B9 5F B9 65 B9 6B ... SWITCH_contig          limit=6   ; .table 6 word targets (contiguous); SWITCH 0=>$B95F 1=>$B965 2=>$B96B 3=>$B971 4=>$B977 5=>$B988 default=>$B98D
 >$B95F  AC 75 B8                   CALL_abs               $B875 (ai_econ_action_state0) {bytecode}
  $B962  D6 8D B9                   JUMP_abs               $B98D
 >$B965  AC AA B3                   CALL_abs               $B3AA (ai_develop_town_handler) {bytecode}
  $B968  D6 8D B9                   JUMP_abs               $B98D
 >$B96B  AC D5 B4                   CALL_abs               $B4D5 (ai_state2_recruit_arm_train) {bytecode}
  $B96E  D6 8D B9                   JUMP_abs               $B98D
 >$B971  AC 4B B6                   CALL_abs               $B64B (ai_econ_command_dispatch) {bytecode}
  $B974  D6 8D B9                   JUMP_abs               $B98D
 >$B977  AC 2B B4                   CALL_abs               $B42B (ai_develop_dam_and_grow) {bytecode}
  $B97A  D6 8D B9                   JUMP_abs               $B98D
 >$B97D  0A                         LOADL_quick   ; inline operand = 10
  $B97E  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $B981  BB                         ADD
  $B982  D3                         BYTE_DEREF
  $B983  55                         LOADR_qimm   ; inline operand = 5
  $B984  C0                         CMPEQ
  $B985  D8 8D B9                   JUMPF_abs              $B98D
 >$B988  3A                         PUSH_quick   ; inline operand = 10
  $B989  E9 9B B7 02                CALL_abs_imm1          $B79B (issue_province_command) {bytecode}, $02
 >$B98D  A4 79 6F                   LOADL_abs              $6F79 (ai_turn_loop_redispatch_flag)
  $B990  D8 9C B9                   JUMPF_abs              $B99C
  $B993  0B                         LOADL_quick   ; inline operand = 11
  $B994  D0                         INC
  $B995  2B                         STORE_quick   ; inline operand = 11
  $B996  A8 01 60                   STORE_abs              $6001 (ai_per_fief_loop_index)
  $B999  D6 A7 B9                   JUMP_abs               $B9A7
 >$B99C  0B                         LOADL_quick   ; inline operand = 11
  $B99D  D0                         INC
 >$B99E  2B                         STORE_quick   ; inline operand = 11
  $B99F  0B                         LOADL_quick   ; inline operand = 11
  $B9A0  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $B9A3  C6                         UCMPLT
  $B9A4  D7 AA B8                   JUMPT_abs              $B8AA
 >$B9A7  A4 79 6F                   LOADL_abs              $6F79 (ai_turn_loop_redispatch_flag)
  $B9AA  D7 B1 B9                   JUMPT_abs              $B9B1
  $B9AD  40                         LOADL_qimm   ; inline operand = 0
  $B9AE  A8 01 60                   STORE_abs              $6001 (ai_per_fief_loop_index)
 >$B9B1  CF                         RETURN

