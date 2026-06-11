VM bytecode disassembly
  ROM:          Nobunaga's Ambition (USA).nes
  mode:         bulk dump of bank 14
  opcode spec:  vm-opcodes-v2.toml via nobunaga_vm.OPCODE_INFO (execution-validated lengths)
  labels:       1334 CPU addresses named

  bank 14: found 3 bytecode-subroutine stubs

; ============================================================
; sub $8003   (frame_off=-2, body @ $8008)
; ============================================================
  $8008  D6 18 80                   JUMP_abs               $8018
 >$800B  89 32                      BYTE_LOADL_imm1        +50
  $800D  2B                         STORE_quick   ; inline operand = 11
 >$800E  0B                         LOADL_quick   ; inline operand = 11
  $800F  D1                         DEC
  $8010  2B                         STORE_quick   ; inline operand = 11
  $8011  0B                         LOADL_quick   ; inline operand = 11
  $8012  D7 0E 80                   JUMPT_abs              $800E
  $8015  0C                         LOADL_quick   ; inline operand = 12
  $8016  D1                         DEC
  $8017  2C                         STORE_quick   ; inline operand = 12
 >$8018  0C                         LOADL_quick   ; inline operand = 12
  $8019  D7 0B 80                   JUMPT_abs              $800B
  $801C  CF                         RETURN

; ============================================================
; sub $801D   (frame_off=-152, body @ $8022)
; ============================================================
  $8022  66                         PUSH_qimm   ; inline operand = 6
  $8023  DE 68 FF                   LEAL_far               $FF68
  $8026  B3                         PUSHL
  $8027  3F                         PUSH_quick   ; inline operand = 15
  $8028  3C                         PUSH_quick   ; inline operand = 12
  $8029  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $802D  A0 68 FF                   BYTE_LOADL_far         $FF68
  $8030  27                         STORE_quick   ; inline operand = 7
  $8031  A0 69 FF                   BYTE_LOADL_far         $FF69
  $8034  26                         STORE_quick   ; inline operand = 6
  $8035  8D 40                      BYTE_PUSH_imm1         +64
  $8037  DE B2 FF                   LEAL_far               $FFB2
  $803A  86 70 FF                   STORE_far              $FF70
  $803D  B3                         PUSHL
  $803E  88 6A FF                   PUSH_far               $FF6A
  $8041  3C                         PUSH_quick   ; inline operand = 12
  $8042  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $8046  8D 40                      BYTE_PUSH_imm1         +64
  $8048  DE 72 FF                   LEAL_far               $FF72
  $804B  86 6E FF                   STORE_far              $FF6E
  $804E  B3                         PUSHL
  $804F  88 6C FF                   PUSH_far               $FF6C
  $8052  3C                         PUSH_quick   ; inline operand = 12
  $8053  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $8057  89 10                      BYTE_LOADL_imm1        +16
  $8059  25                         STORE_quick   ; inline operand = 5
  $805A  0E                         LOADL_quick   ; inline operand = 14
  $805B  28                         STORE_quick   ; inline operand = 8
  $805C  40                         LOADL_qimm   ; inline operand = 0
  $805D  2B                         STORE_quick   ; inline operand = 11
  $805E  D6 A0 80                   JUMP_abs               $80A0
 >$8061  0D                         LOADL_quick   ; inline operand = 13
  $8062  29                         STORE_quick   ; inline operand = 9
  $8063  40                         LOADL_qimm   ; inline operand = 0
  $8064  2A                         STORE_quick   ; inline operand = 10
  $8065  D6 91 80                   JUMP_abs               $8091
 >$8068  82 6E FF                   LOADL_far              $FF6E
  $806B  D0                         INC
  $806C  86 6E FF                   STORE_far              $FF6E
  $806F  D1                         DEC
  $8070  D3                         BYTE_DEREF
  $8071  B3                         PUSHL
  $8072  82 70 FF                   LOADL_far              $FF70
  $8075  D0                         INC
  $8076  86 70 FF                   STORE_far              $FF70
  $8079  D1                         DEC
  $807A  D3                         BYTE_DEREF
  $807B  B3                         PUSHL
  $807C  38                         PUSH_quick   ; inline operand = 8
  $807D  39                         PUSH_quick   ; inline operand = 9
  $807E  05                         LOADL_quick   ; inline operand = 5
  $807F  D0                         INC
  $8080  25                         STORE_quick   ; inline operand = 5
  $8081  D1                         DEC
  $8082  B3                         PUSHL
  $8083  63                         PUSH_qimm   ; inline operand = 3
  $8084  E9 26 F2 0C                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0C
  $8088  0A                         LOADL_quick   ; inline operand = 10
  $8089  D0                         INC
  $808A  2A                         STORE_quick   ; inline operand = 10
  $808B  D1                         DEC
  $808C  48                         LOADL_qimm   ; inline operand = 8
  $808D  CD                         SWAP
  $808E  09                         LOADL_quick   ; inline operand = 9
  $808F  BB                         ADD
  $8090  29                         STORE_quick   ; inline operand = 9
 >$8091  0A                         LOADL_quick   ; inline operand = 10
  $8092  17                         LOADR_quick   ; inline operand = 7
  $8093  C2                         SCMPLT
  $8094  D7 68 80                   JUMPT_abs              $8068
  $8097  0B                         LOADL_quick   ; inline operand = 11
  $8098  D0                         INC
  $8099  2B                         STORE_quick   ; inline operand = 11
  $809A  D1                         DEC
  $809B  48                         LOADL_qimm   ; inline operand = 8
  $809C  CD                         SWAP
  $809D  08                         LOADL_quick   ; inline operand = 8
  $809E  BB                         ADD
  $809F  28                         STORE_quick   ; inline operand = 8
 >$80A0  0B                         LOADL_quick   ; inline operand = 11
  $80A1  16                         LOADR_quick   ; inline operand = 6
  $80A2  C2                         SCMPLT
  $80A3  D7 61 80                   JUMPT_abs              $8061
  $80A6  8D 13                      BYTE_PUSH_imm1         +19
  $80A8  E9 26 F2 02                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $02
  $80AC  CF                         RETURN

; ============================================================
; sub $80AD   (frame_off=-53, body @ $80B2)
; ============================================================
  $80B2  A4 CB 7F                   LOADL_abs              $7FCB (cutscene_id)
  $80B5  55                         LOADR_qimm   ; inline operand = 5
  $80B6  B5                         MULT
  $80B7  8C 80 AF                   LOADR_imm2             $AF80 (cutscene_table)
  $80BA  BB                         ADD
  $80BB  85 D7                      STORE_near             $D7
  $80BD  81 D7                      LOADL_near             $D7
  $80BF  D3                         BYTE_DEREF
  $80C0  27                         STORE_quick   ; inline operand = 7
  $80C1  8D 15                      BYTE_PUSH_imm1         +21
  $80C3  DE E1 FF                   LEAL_far               $FFE1
  $80C6  85 DF                      STORE_near             $DF
  $80C8  B3                         PUSHL
  $80C9  81 D7                      LOADL_near             $D7
  $80CB  D0                         INC
  $80CC  B0                         DEREF
  $80CD  B3                         PUSHL
  $80CE  37                         PUSH_quick   ; inline operand = 7
  $80CF  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $80D3  81 DF                      LOADL_near             $DF
  $80D5  85 DD                      STORE_near             $DD
  $80D7  89 10                      BYTE_LOADL_imm1        +16
  $80D9  D6 F8 80                   JUMP_abs               $80F8
 >$80DC  61                         PUSH_qimm   ; inline operand = 1
  $80DD  DE DC FF                   LEAL_far               $FFDC
  $80E0  B3                         PUSHL
  $80E1  81 DD                      LOADL_near             $DD
  $80E3  D0                         INC
  $80E4  85 DD                      STORE_near             $DD
  $80E6  D1                         DEC
  $80E7  B3                         PUSHL
  $80E8  37                         PUSH_quick   ; inline operand = 7
  $80E9  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $80ED  A0 DC FF                   BYTE_LOADL_far         $FFDC
  $80F0  B3                         PUSHL
  $80F1  3B                         PUSH_quick   ; inline operand = 11
  $80F2  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $80F6  0B                         LOADL_quick   ; inline operand = 11
  $80F7  D0                         INC
 >$80F8  2B                         STORE_quick   ; inline operand = 11
  $80F9  0B                         LOADL_quick   ; inline operand = 11
  $80FA  8B 20                      BYTE_LOADR_imm1        +32
  $80FC  C2                         SCMPLT
  $80FD  D7 DC 80                   JUMPT_abs              $80DC
  $8100  81 DF                      LOADL_near             $DF
  $8102  8F 10                      BYTE_ADD_imm1          +16
  $8104  D3                         BYTE_DEREF
  $8105  B3                         PUSHL
  $8106  8E 00 01                   PUSH_imm2              $0100
  $8109  81 DF                      LOADL_near             $DF
  $810B  8F 11                      BYTE_ADD_imm1          +17
  $810D  B0                         DEREF
  $810E  B3                         PUSHL
  $810F  37                         PUSH_quick   ; inline operand = 7
  $8110  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $8114  81 D7                      LOADL_near             $D7
  $8116  73                         ADD_qimm   ; inline operand = 3
  $8117  B0                         DEREF
 >$8118  85 DD                      STORE_near             $DD
 >$811A  81 DD                      LOADL_near             $DD
  $811C  D0                         INC
  $811D  85 DD                      STORE_near             $DD
  $811F  D1                         DEC
  $8120  D3                         BYTE_DEREF
  $8121  D5 BD FF 16 00 25 82 EC 81 95 81 DC ... SWITCH_contig          limit=22   ; .table 22 word targets (contiguous); SWITCH 67=>$81EC 68=>$8195 69=>$81DC 70=>$81F2 71=>$8225 72=>$8225 73=>$8225 74=>$8225 75=>$8225 76=>$8154 77=>$8225 78=>$8225 79=>$8225 80=>$8225 81=>$8225 82=>$81CB 83=>$8216 84=>$8225 85=>$8225 86=>$8185 87=>$81BC 88=>$8167 default=>$8225
 >$8154  81 DD                      LOADL_near             $DD
  $8156  D0                         INC
  $8157  85 DD                      STORE_near             $DD
  $8159  D1                         DEC
  $815A  D3                         BYTE_DEREF
  $815B  2A                         STORE_quick   ; inline operand = 10
  $815C  81 DD                      LOADL_near             $DD
  $815E  D0                         INC
  $815F  85 DD                      STORE_near             $DD
  $8161  D1                         DEC
  $8162  D3                         BYTE_DEREF
  $8163  29                         STORE_quick   ; inline operand = 9
  $8164  D6 1A 81                   JUMP_abs               $811A
 >$8167  81 DD                      LOADL_near             $DD
  $8169  D3                         BYTE_DEREF
  $816A  CD                         SWAP
  $816B  0A                         LOADL_quick   ; inline operand = 10
  $816C  BB                         ADD
  $816D  2A                         STORE_quick   ; inline operand = 10
  $816E  81 DD                      LOADL_near             $DD
  $8170  D0                         INC
  $8171  85 DD                      STORE_near             $DD
  $8173  D1                         DEC
  $8174  D3                         BYTE_DEREF
  $8175  8B 7F                      BYTE_LOADR_imm1        +127
  $8177  C4                         SCMPGT
  $8178  D8 1A 81                   JUMPF_abs              $811A
  $817B  8A 00 01                   LOADL_imm2             $0100
  $817E  CD                         SWAP
  $817F  0A                         LOADL_quick   ; inline operand = 10
  $8180  BC                         SUB
  $8181  2A                         STORE_quick   ; inline operand = 10
  $8182  D6 1A 81                   JUMP_abs               $811A
 >$8185  81 DD                      LOADL_near             $DD
  $8187  D0                         INC
  $8188  85 DD                      STORE_near             $DD
  $818A  D1                         DEC
  $818B  D3                         BYTE_DEREF
  $818C  2A                         STORE_quick   ; inline operand = 10
  $818D  81 DD                      LOADL_near             $DD
  $818F  D0                         INC
  $8190  85 DD                      STORE_near             $DD
  $8192  D1                         DEC
  $8193  D3                         BYTE_DEREF
  $8194  29                         STORE_quick   ; inline operand = 9
 >$8195  6A                         PUSH_qimm   ; inline operand = 10
  $8196  DE CB FF                   LEAL_far               $FFCB
  $8199  B3                         PUSHL
  $819A  81 DF                      LOADL_near             $DF
  $819C  8F 13                      BYTE_ADD_imm1          +19
  $819E  B0                         DEREF
  $819F  B3                         PUSHL
  $81A0  37                         PUSH_quick   ; inline operand = 7
  $81A1  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $81A5  DE CB FF                   LEAL_far               $FFCB
  $81A8  B3                         PUSHL
  $81A9  81 DD                      LOADL_near             $DD
  $81AB  D0                         INC
  $81AC  85 DD                      STORE_near             $DD
  $81AE  D1                         DEC
  $81AF  D3                         BYTE_DEREF
  $81B0  D2                         LSHIFT1
  $81B1  B4                         POPR
  $81B2  BB                         ADD
  $81B3  B0                         DEREF
  $81B4  B3                         PUSHL
  $81B5  39                         PUSH_quick   ; inline operand = 9
  $81B6  3A                         PUSH_quick   ; inline operand = 10
  $81B7  37                         PUSH_quick   ; inline operand = 7
  $81B8  E9 1D 80 08                CALL_abs_imm1          $801D (draw_sprite_grid) {bytecode}, $08
 >$81BC  81 DD                      LOADL_near             $DD
  $81BE  D0                         INC
  $81BF  85 DD                      STORE_near             $DD
  $81C1  D1                         DEC
  $81C2  D3                         BYTE_DEREF
  $81C3  B3                         PUSHL
  $81C4  E9 03 80 02                CALL_abs_imm1          $8003 (cutscene_delay) {bytecode}, $02
  $81C8  D6 1A 81                   JUMP_abs               $811A
 >$81CB  81 DD                      LOADL_near             $DD
  $81CD  D0                         INC
  $81CE  85 DD                      STORE_near             $DD
  $81D0  D1                         DEC
  $81D1  D3                         BYTE_DEREF
  $81D2  A2 D9 FF                   BYTE_STORE_far         $FFD9
  $81D5  81 DD                      LOADL_near             $DD
  $81D7  85 DA                      STORE_near             $DA
  $81D9  D6 1A 81                   JUMP_abs               $811A
 >$81DC  A0 D9 FF                   BYTE_LOADL_far         $FFD9
  $81DF  D1                         DEC
  $81E0  A2 D9 FF                   BYTE_STORE_far         $FFD9
  $81E3  D0                         INC
  $81E4  D8 1A 81                   JUMPF_abs              $811A
  $81E7  81 DA                      LOADL_near             $DA
  $81E9  D6 18 81                   JUMP_abs               $8118
 >$81EC  8D 32                      BYTE_PUSH_imm1         +50
  $81EE  E9 3E D7 02                CALL_abs_imm1          $D73E (delay_loop) {bytecode}, $02
 >$81F2  89 10                      BYTE_LOADL_imm1        +16
  $81F4  28                         STORE_quick   ; inline operand = 8
 >$81F5  62                         PUSH_qimm   ; inline operand = 2
  $81F6  60                         PUSH_qimm   ; inline operand = 0
  $81F7  8E F8 00                   PUSH_imm2              $00F8
  $81FA  8E F8 00                   PUSH_imm2              $00F8
  $81FD  38                         PUSH_quick   ; inline operand = 8
  $81FE  63                         PUSH_qimm   ; inline operand = 3
  $81FF  E9 26 F2 0C                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0C
  $8203  08                         LOADL_quick   ; inline operand = 8
  $8204  D0                         INC
  $8205  28                         STORE_quick   ; inline operand = 8
  $8206  08                         LOADL_quick   ; inline operand = 8
  $8207  8B 40                      BYTE_LOADR_imm1        +64
  $8209  C2                         SCMPLT
  $820A  D7 F5 81                   JUMPT_abs              $81F5
  $820D  8D 13                      BYTE_PUSH_imm1         +19
  $820F  E9 26 F2 02                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $02
  $8213  D6 1A 81                   JUMP_abs               $811A
 >$8216  81 DD                      LOADL_near             $DD
  $8218  D0                         INC
  $8219  85 DD                      STORE_near             $DD
  $821B  D1                         DEC
  $821C  D3                         BYTE_DEREF
  $821D  B3                         PUSHL
  $821E  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $8222  D6 1A 81                   JUMP_abs               $811A
 >$8225  CF                         RETURN

