VM bytecode disassembly
  ROM:          Nobunaga's Ambition (USA).nes
  mode:         bulk dump of bank 15
  opcode spec:  vm-opcodes-v2.toml via nobunaga_vm.OPCODE_INFO (execution-validated lengths)
  labels:       1324 CPU addresses named

  bank 15: found 135 bytecode-subroutine stubs

; ============================================================
; sub $CA03   (frame_off=+0, body @ $CA08)
; ============================================================
  $CA08  0C                         LOADL_quick   ; inline operand = 12
  $CA09  A8 E5 7F                   STORE_abs              $7FE5
  $CA0C  6A                         PUSH_qimm   ; inline operand = 10
  $CA0D  E9 B1 CB 02                CALL_abs_imm1          $CBB1 (call_bank_wrap) {bytecode}, $02
  $CA11  CF                         RETURN

; ============================================================
; sub $CA12   (frame_off=+0, body @ $CA17)
; ============================================================
  $CA17  3C                         PUSH_quick   ; inline operand = 12
  $CA18  A0 0D 00                   BYTE_LOADL_far         $000D
  $CA1B  B3                         PUSHL
  $CA1C  0C                         LOADL_quick   ; inline operand = 12
  $CA1D  D3                         BYTE_DEREF
  $CA1E  B4                         POPR
  $CA1F  C2                         SCMPLT
  $CA20  D8 27 CA                   JUMPF_abs              $CA27
  $CA23  40                         LOADL_qimm   ; inline operand = 0
  $CA24  D6 2F CA                   JUMP_abs               $CA2F
 >$CA27  A0 0D 00                   BYTE_LOADL_far         $000D
  $CA2A  B3                         PUSHL
  $CA2B  0C                         LOADL_quick   ; inline operand = 12
  $CA2C  D3                         BYTE_DEREF
  $CA2D  B4                         POPR
  $CA2E  BC                         SUB
 >$CA2F  D4                         BYTE_POPSTORE
  $CA30  CF                         RETURN

; ============================================================
; sub $CA31   (frame_off=-2, body @ $CA36)
; ============================================================
  $CA36  0C                         LOADL_quick   ; inline operand = 12
  $CA37  B0                         DEREF
  $CA38  1D                         LOADR_quick   ; inline operand = 13
  $CA39  BC                         SUB
  $CA3A  2B                         STORE_quick   ; inline operand = 11
  $CA3B  50                         LOADR_qimm   ; inline operand = 0
  $CA3C  C2                         SCMPLT
  $CA3D  D8 42 CA                   JUMPF_abs              $CA42
  $CA40  40                         LOADL_qimm   ; inline operand = 0
  $CA41  2B                         STORE_quick   ; inline operand = 11
 >$CA42  3C                         PUSH_quick   ; inline operand = 12
  $CA43  0B                         LOADL_quick   ; inline operand = 11
  $CA44  B1                         POPSTORE
  $CA45  CF                         RETURN

; ============================================================
; sub $CA46   (frame_off=+0, body @ $CA4B)
; ============================================================
  $CA4B  8D 11                      BYTE_PUSH_imm1         +17
  $CA4D  E9 26 F2 02                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $02
  $CA51  CF                         RETURN

; ============================================================
; sub $CA52   (frame_off=+0, body @ $CA57)
; ============================================================
  $CA57  0C                         LOADL_quick   ; inline operand = 12
  $CA58  51                         LOADR_qimm   ; inline operand = 1
  $CA59  C2                         SCMPLT
  $CA5A  D8 5F CA                   JUMPF_abs              $CA5F
  $CA5D  40                         LOADL_qimm   ; inline operand = 0
  $CA5E  CF                         RETURN
 >$CA5F  AC 46 CA                   CALL_abs               $CA46 (rng_next_wrapper) {bytecode}
  $CA62  1C                         LOADR_quick   ; inline operand = 12
  $CA63  B9                         SMOD
  $CA64  CF                         RETURN

; ============================================================
; sub $CA65   (frame_off=+0, body @ $CA6A)
; ============================================================
  $CA6A  89 30                      BYTE_LOADL_imm1        +48
  $CA6C  1C                         LOADR_quick   ; inline operand = 12
  $CA6D  C7                         UCMPLE
  $CA6E  D8 78 CA                   JUMPF_abs              $CA78
  $CA71  0C                         LOADL_quick   ; inline operand = 12
  $CA72  8B 39                      BYTE_LOADR_imm1        +57
  $CA74  C7                         UCMPLE
  $CA75  D7 7C CA                   JUMPT_abs              $CA7C
 >$CA78  40                         LOADL_qimm   ; inline operand = 0
  $CA79  D6 7D CA                   JUMP_abs               $CA7D
 >$CA7C  41                         LOADL_qimm   ; inline operand = 1
 >$CA7D  CF                         RETURN

; ============================================================
; sub $CA7E   (frame_off=-2, body @ $CA83)
; ============================================================
  $CA83  40                         LOADL_qimm   ; inline operand = 0
  $CA84  2B                         STORE_quick   ; inline operand = 11
  $CA85  D6 90 CA                   JUMP_abs               $CA90
 >$CA88  0C                         LOADL_quick   ; inline operand = 12
  $CA89  D0                         INC
  $CA8A  2C                         STORE_quick   ; inline operand = 12
  $CA8B  D1                         DEC
  $CA8C  0B                         LOADL_quick   ; inline operand = 11
  $CA8D  D0                         INC
  $CA8E  2B                         STORE_quick   ; inline operand = 11
  $CA8F  D1                         DEC
 >$CA90  0C                         LOADL_quick   ; inline operand = 12
  $CA91  D3                         BYTE_DEREF
  $CA92  D7 88 CA                   JUMPT_abs              $CA88
  $CA95  0B                         LOADL_quick   ; inline operand = 11
  $CA96  CF                         RETURN

; ============================================================
; sub $CA97   (frame_off=+0, body @ $CA9C)
; ============================================================
  $CA9C  D6 AB CA                   JUMP_abs               $CAAB
 >$CA9F  0C                         LOADL_quick   ; inline operand = 12
  $CAA0  D0                         INC
  $CAA1  2C                         STORE_quick   ; inline operand = 12
  $CAA2  D1                         DEC
  $CAA3  B3                         PUSHL
  $CAA4  A0 0F 00                   BYTE_LOADL_far         $000F
  $CAA7  D4                         BYTE_POPSTORE
  $CAA8  0D                         LOADL_quick   ; inline operand = 13
  $CAA9  D1                         DEC
  $CAAA  2D                         STORE_quick   ; inline operand = 13
 >$CAAB  0D                         LOADL_quick   ; inline operand = 13
  $CAAC  D7 9F CA                   JUMPT_abs              $CA9F
  $CAAF  CF                         RETURN

; ============================================================
; sub $CAB0   (frame_off=+0, body @ $CAB5)
; ============================================================
  $CAB5  D6 C7 CA                   JUMP_abs               $CAC7
 >$CAB8  0C                         LOADL_quick   ; inline operand = 12
  $CAB9  D3                         BYTE_DEREF
  $CABA  D7 BF CA                   JUMPT_abs              $CABF
  $CABD  40                         LOADL_qimm   ; inline operand = 0
  $CABE  CF                         RETURN
 >$CABF  0C                         LOADL_quick   ; inline operand = 12
  $CAC0  D0                         INC
  $CAC1  2C                         STORE_quick   ; inline operand = 12
  $CAC2  D1                         DEC
  $CAC3  0D                         LOADL_quick   ; inline operand = 13
  $CAC4  D0                         INC
  $CAC5  2D                         STORE_quick   ; inline operand = 13
  $CAC6  D1                         DEC
 >$CAC7  0D                         LOADL_quick   ; inline operand = 13
  $CAC8  D3                         BYTE_DEREF
  $CAC9  B3                         PUSHL
  $CACA  0C                         LOADL_quick   ; inline operand = 12
  $CACB  D3                         BYTE_DEREF
  $CACC  B4                         POPR
  $CACD  C0                         CMPEQ
  $CACE  D7 B8 CA                   JUMPT_abs              $CAB8
  $CAD1  0D                         LOADL_quick   ; inline operand = 13
  $CAD2  D3                         BYTE_DEREF
  $CAD3  B3                         PUSHL
  $CAD4  0C                         LOADL_quick   ; inline operand = 12
  $CAD5  D3                         BYTE_DEREF
  $CAD6  B4                         POPR
  $CAD7  BC                         SUB
  $CAD8  CF                         RETURN

; ============================================================
; sub $CAD9   (frame_off=-2, body @ $CADE)
; ============================================================
  $CADE  0C                         LOADL_quick   ; inline operand = 12
  $CADF  2B                         STORE_quick   ; inline operand = 11
 >$CAE0  0C                         LOADL_quick   ; inline operand = 12
  $CAE1  D0                         INC
  $CAE2  2C                         STORE_quick   ; inline operand = 12
  $CAE3  D1                         DEC
  $CAE4  B3                         PUSHL
  $CAE5  0D                         LOADL_quick   ; inline operand = 13
  $CAE6  D0                         INC
  $CAE7  2D                         STORE_quick   ; inline operand = 13
  $CAE8  D1                         DEC
  $CAE9  D3                         BYTE_DEREF
  $CAEA  D4                         BYTE_POPSTORE
  $CAEB  D7 E0 CA                   JUMPT_abs              $CAE0
  $CAEE  0B                         LOADL_quick   ; inline operand = 11
  $CAEF  CF                         RETURN

; ============================================================
; sub $CAF0   (frame_off=+0, body @ $CAF5)
; ============================================================
  $CAF5  D6 0B CB                   JUMP_abs               $CB0B
 >$CAF8  A0 0D 00                   BYTE_LOADL_far         $000D
  $CAFB  B3                         PUSHL
  $CAFC  0C                         LOADL_quick   ; inline operand = 12
  $CAFD  D3                         BYTE_DEREF
  $CAFE  B4                         POPR
  $CAFF  C0                         CMPEQ
  $CB00  D8 05 CB                   JUMPF_abs              $CB05
  $CB03  0C                         LOADL_quick   ; inline operand = 12
  $CB04  CF                         RETURN
 >$CB05  0C                         LOADL_quick   ; inline operand = 12
  $CB06  D0                         INC
  $CB07  2C                         STORE_quick   ; inline operand = 12
  $CB08  0E                         LOADL_quick   ; inline operand = 14
  $CB09  D1                         DEC
  $CB0A  2E                         STORE_quick   ; inline operand = 14
 >$CB0B  0E                         LOADL_quick   ; inline operand = 14
  $CB0C  D7 F8 CA                   JUMPT_abs              $CAF8
  $CB0F  40                         LOADL_qimm   ; inline operand = 0
  $CB10  CF                         RETURN

; ============================================================
; sub $CB11   (frame_off=+0, body @ $CB16)
; ============================================================
  $CB16  A0 0B 00                   BYTE_LOADL_far         $000B
  $CB19  B3                         PUSHL
  $CB1A  89 61                      BYTE_LOADL_imm1        +97
  $CB1C  B4                         POPR
  $CB1D  C3                         SCMPLE
  $CB1E  D8 2A CB                   JUMPF_abs              $CB2A
  $CB21  A0 0B 00                   BYTE_LOADL_far         $000B
  $CB24  8B 7A                      BYTE_LOADR_imm1        +122
  $CB26  C3                         SCMPLE
  $CB27  D7 2E CB                   JUMPT_abs              $CB2E
 >$CB2A  40                         LOADL_qimm   ; inline operand = 0
  $CB2B  D6 2F CB                   JUMP_abs               $CB2F
 >$CB2E  41                         LOADL_qimm   ; inline operand = 1
 >$CB2F  CF                         RETURN

; ============================================================
; sub $CB30   (frame_off=+0, body @ $CB35)
; ============================================================
  $CB35  A0 0B 00                   BYTE_LOADL_far         $000B
  $CB38  B3                         PUSHL
  $CB39  E9 11 CB 02                CALL_abs_imm1          $CB11 (is_lower) {bytecode}, $02
  $CB3D  D8 48 CB                   JUMPF_abs              $CB48
  $CB40  A0 0B 00                   BYTE_LOADL_far         $000B
  $CB43  8F E0                      BYTE_ADD_imm1          -32
  $CB45  D6 4B CB                   JUMP_abs               $CB4B
 >$CB48  A0 0B 00                   BYTE_LOADL_far         $000B
 >$CB4B  CF                         RETURN

; ============================================================
; sub $CB4C   (frame_off=+0, body @ $CB51)
; ============================================================
  $CB51  0C                         LOADL_quick   ; inline operand = 12
  $CB52  50                         LOADR_qimm   ; inline operand = 0
  $CB53  C2                         SCMPLT
  $CB54  D8 5C CB                   JUMPF_abs              $CB5C
  $CB57  0C                         LOADL_quick   ; inline operand = 12
  $CB58  CB                         MINUS
  $CB59  D6 5D CB                   JUMP_abs               $CB5D
 >$CB5C  0C                         LOADL_quick   ; inline operand = 12
 >$CB5D  CF                         RETURN

; ============================================================
; sub $CB5E   (frame_off=+0, body @ $CB63)
; ============================================================
  $CB63  0C                         LOADL_quick   ; inline operand = 12
  $CB64  1D                         LOADR_quick   ; inline operand = 13
  $CB65  C2                         SCMPLT
  $CB66  D8 6D CB                   JUMPF_abs              $CB6D
  $CB69  0C                         LOADL_quick   ; inline operand = 12
  $CB6A  D6 6E CB                   JUMP_abs               $CB6E
 >$CB6D  0D                         LOADL_quick   ; inline operand = 13
 >$CB6E  CF                         RETURN

; ============================================================
; sub $CB6F   (frame_off=+0, body @ $CB74)
; ============================================================
  $CB74  0C                         LOADL_quick   ; inline operand = 12
  $CB75  1D                         LOADR_quick   ; inline operand = 13
  $CB76  C4                         SCMPGT
  $CB77  D8 7E CB                   JUMPF_abs              $CB7E
  $CB7A  0C                         LOADL_quick   ; inline operand = 12
  $CB7B  D6 7F CB                   JUMP_abs               $CB7F
 >$CB7E  0D                         LOADL_quick   ; inline operand = 13
 >$CB7F  CF                         RETURN

; ============================================================
; sub $CB80   (frame_off=-1, body @ $CB85)
; ============================================================
  $CB85  0C                         LOADL_quick   ; inline operand = 12
  $CB86  D3                         BYTE_DEREF
  $CB87  A2 FF FF                   BYTE_STORE_far         $FFFF
  $CB8A  3C                         PUSH_quick   ; inline operand = 12
  $CB8B  0D                         LOADL_quick   ; inline operand = 13
  $CB8C  D3                         BYTE_DEREF
  $CB8D  D4                         BYTE_POPSTORE
  $CB8E  3D                         PUSH_quick   ; inline operand = 13
  $CB8F  A0 FF FF                   BYTE_LOADL_far         $FFFF
  $CB92  D4                         BYTE_POPSTORE
  $CB93  CF                         RETURN

; ============================================================
; sub $CB94   (frame_off=-2, body @ $CB99)
; ============================================================
  $CB99  0C                         LOADL_quick   ; inline operand = 12
  $CB9A  B0                         DEREF
  $CB9B  2B                         STORE_quick   ; inline operand = 11
  $CB9C  3C                         PUSH_quick   ; inline operand = 12
  $CB9D  0D                         LOADL_quick   ; inline operand = 13
  $CB9E  B0                         DEREF
  $CB9F  B1                         POPSTORE
  $CBA0  3D                         PUSH_quick   ; inline operand = 13
  $CBA1  0B                         LOADL_quick   ; inline operand = 11
  $CBA2  B1                         POPSTORE
  $CBA3  CF                         RETURN

; ============================================================
; sub $CBA4   (frame_off=+0, body @ $CBA9)
; ============================================================
  $CBA9  3C                         PUSH_quick   ; inline operand = 12
  $CBAA  8D 15                      BYTE_PUSH_imm1         +21
  $CBAC  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $CBB0  CF                         RETURN

; ============================================================
; sub $CBB1   (frame_off=+0, body @ $CBB6)
; ============================================================
  $CBB6  3C                         PUSH_quick   ; inline operand = 12
  $CBB7  67                         PUSH_qimm   ; inline operand = 7
  $CBB8  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $CBBC  CF                         RETURN

; ============================================================
; sub $CBBD   (frame_off=+0, body @ $CBC2)
; ============================================================
  $CBC2  3F                         PUSH_quick   ; inline operand = 15
  $CBC3  3E                         PUSH_quick   ; inline operand = 14
  $CBC4  3D                         PUSH_quick   ; inline operand = 13
  $CBC5  3C                         PUSH_quick   ; inline operand = 12
  $CBC6  8D 10                      BYTE_PUSH_imm1         +16
  $CBC8  E9 26 F2 0A                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0A
  $CBCC  CF                         RETURN

; ============================================================
; sub $CC35   (frame_off=+0, body @ $CC3A)
; ============================================================
  $CC3A  3C                         PUSH_quick   ; inline operand = 12
  $CC3B  8D 12                      BYTE_PUSH_imm1         +18
  $CC3D  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $CC41  CF                         RETURN

; ============================================================
; sub $CC42   (frame_off=+0, body @ $CC47)
; ============================================================
  $CC47  87 13                      PUSH_near              $13
  $CC49  3F                         PUSH_quick   ; inline operand = 15
  $CC4A  3E                         PUSH_quick   ; inline operand = 14
  $CC4B  3D                         PUSH_quick   ; inline operand = 13
  $CC4C  3C                         PUSH_quick   ; inline operand = 12
  $CC4D  60                         PUSH_qimm   ; inline operand = 0
  $CC4E  6C                         PUSH_qimm   ; inline operand = 12
  $CC4F  E9 26 F2 0E                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0E
  $CC53  CF                         RETURN

; ============================================================
; sub $CC54   (frame_off=+0, body @ $CC59)
; ============================================================
  $CC59  87 15                      PUSH_near              $15
  $CC5B  87 13                      PUSH_near              $13
  $CC5D  3F                         PUSH_quick   ; inline operand = 15
  $CC5E  3E                         PUSH_quick   ; inline operand = 14
  $CC5F  3D                         PUSH_quick   ; inline operand = 13
  $CC60  3C                         PUSH_quick   ; inline operand = 12
  $CC61  60                         PUSH_qimm   ; inline operand = 0
  $CC62  8D 14                      BYTE_PUSH_imm1         +20
  $CC64  E9 26 F2 10                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $10
  $CC68  CF                         RETURN

; ============================================================
; sub $CC69   (frame_off=+0, body @ $CC6E)
; ============================================================
  $CC6E  61                         PUSH_qimm   ; inline operand = 1
  $CC6F  8D 12                      BYTE_PUSH_imm1         +18
  $CC71  8D 1D                      BYTE_PUSH_imm1         +29
  $CC73  67                         PUSH_qimm   ; inline operand = 7
  $CC74  8D 16                      BYTE_PUSH_imm1         +22
  $CC76  E9 42 CC 0A                CALL_abs_imm1          $CC42 (ppu_blit_nobank_wrap) {bytecode}, $0A
  $CC7A  CF                         RETURN

; ============================================================
; sub $CC7B   (frame_off=+0, body @ $CC80)
; ============================================================
  $CC80  0C                         LOADL_quick   ; inline operand = 12
  $CC81  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $CC84  0D                         LOADL_quick   ; inline operand = 13
  $CC85  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $CC88  CF                         RETURN

; ============================================================
; sub $CC89   (frame_off=+0, body @ $CC8E)
; ============================================================
  $CC8E  61                         PUSH_qimm   ; inline operand = 1
  $CC8F  8D 19                      BYTE_PUSH_imm1         +25
  $CC91  8D 13                      BYTE_PUSH_imm1         +19
  $CC93  A4 D1 7F                   LOADL_abs              $7FD1 (ui_msg_col_shift_flag)
  $CC96  D8 9E CC                   JUMPF_abs              $CC9E
  $CC99  89 14                      BYTE_LOADL_imm1        +20
  $CC9B  D6 A0 CC                   JUMP_abs               $CCA0
 >$CC9E  89 16                      BYTE_LOADL_imm1        +22
 >$CCA0  B3                         PUSHL
  $CCA1  62                         PUSH_qimm   ; inline operand = 2
  $CCA2  E9 42 CC 0A                CALL_abs_imm1          $CC42 (ppu_blit_nobank_wrap) {bytecode}, $0A
  $CCA6  A4 D1 7F                   LOADL_abs              $7FD1 (ui_msg_col_shift_flag)
  $CCA9  D8 B1 CC                   JUMPF_abs              $CCB1
  $CCAC  89 14                      BYTE_LOADL_imm1        +20
  $CCAE  D6 B3 CC                   JUMP_abs               $CCB3
 >$CCB1  89 16                      BYTE_LOADL_imm1        +22
 >$CCB3  B3                         PUSHL
  $CCB4  62                         PUSH_qimm   ; inline operand = 2
  $CCB5  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $CCB9  CF                         RETURN

; ============================================================
; sub $CCBA   (frame_off=+0, body @ $CCBF)
; ============================================================
  $CCBF  61                         PUSH_qimm   ; inline operand = 1
  $CCC0  8D 19                      BYTE_PUSH_imm1         +25
  $CCC2  8D 1D                      BYTE_PUSH_imm1         +29
  $CCC4  8D 14                      BYTE_PUSH_imm1         +20
  $CCC6  8D 14                      BYTE_PUSH_imm1         +20
  $CCC8  E9 42 CC 0A                CALL_abs_imm1          $CC42 (ppu_blit_nobank_wrap) {bytecode}, $0A
  $CCCC  40                         LOADL_qimm   ; inline operand = 0
  $CCCD  A8 F9 7B                   STORE_abs              $7BF9 (ui_state_flag_7bf9)
  $CCD0  CF                         RETURN

; ============================================================
; sub $CCD1   (frame_off=+0, body @ $CCD6)
; ============================================================
  $CCD6  61                         PUSH_qimm   ; inline operand = 1
  $CCD7  63                         PUSH_qimm   ; inline operand = 3
  $CCD8  8D 1D                      BYTE_PUSH_imm1         +29
  $CCDA  63                         PUSH_qimm   ; inline operand = 3
  $CCDB  62                         PUSH_qimm   ; inline operand = 2
  $CCDC  E9 42 CC 0A                CALL_abs_imm1          $CC42 (ppu_blit_nobank_wrap) {bytecode}, $0A
  $CCE0  CF                         RETURN

; ============================================================
; sub $CCE1   (frame_off=+0, body @ $CCE6)
; ============================================================
  $CCE6  61                         PUSH_qimm   ; inline operand = 1
  $CCE7  8D 1A                      BYTE_PUSH_imm1         +26
  $CCE9  8D 1D                      BYTE_PUSH_imm1         +29
  $CCEB  8D 1A                      BYTE_PUSH_imm1         +26
  $CCED  62                         PUSH_qimm   ; inline operand = 2
  $CCEE  E9 42 CC 0A                CALL_abs_imm1          $CC42 (ppu_blit_nobank_wrap) {bytecode}, $0A
  $CCF2  8A FF 00                   LOADL_imm2             $00FF
  $CCF5  A8 DF 7F                   STORE_abs              $7FDF (ui_input_sel_latch_7fdf)
  $CCF8  CF                         RETURN

; ============================================================
; sub $CCF9   (frame_off=+0, body @ $CCFE)
; ============================================================
  $CCFE  61                         PUSH_qimm   ; inline operand = 1
  $CCFF  8D 13                      BYTE_PUSH_imm1         +19
  $CD01  8D 1F                      BYTE_PUSH_imm1         +31
  $CD03  64                         PUSH_qimm   ; inline operand = 4
  $CD04  60                         PUSH_qimm   ; inline operand = 0
  $CD05  E9 42 CC 0A                CALL_abs_imm1          $CC42 (ppu_blit_nobank_wrap) {bytecode}, $0A
  $CD09  A4 5D 6F                   LOADL_abs              $6F5D (selected_record_idx_9e3c)
  $CD0C  8C FF 00                   LOADR_imm2             $00FF
  $CD0F  C1                         CMPNE
  $CD10  D8 1F CD                   JUMPF_abs              $CD1F
  $CD13  A4 5D 6F                   LOADL_abs              $6F5D (selected_record_idx_9e3c)
  $CD16  A8 E6 7B                   STORE_abs              $7BE6 (latched_selected_record_idx)
  $CD19  8A FF 00                   LOADL_imm2             $00FF
  $CD1C  A8 5D 6F                   STORE_abs              $6F5D (selected_record_idx_9e3c)
 >$CD1F  CF                         RETURN

; ============================================================
; sub $CD20   (frame_off=-2, body @ $CD25)
; ============================================================
  $CD25  61                         PUSH_qimm   ; inline operand = 1
  $CD26  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $CD2A  AC 50 CF                   CALL_abs               $CF50 (fill_nametable_wrap) {bytecode}
  $CD2D  AC 5D CF                   CALL_abs               $CF5D (fill_attr_wrap) {bytecode}
  $CD30  A4 C9 7F                   LOADL_abs              $7FC9 (ui_pending_flag_7fc9)
  $CD33  D8 4F CD                   JUMPF_abs              $CD4F
  $CD36  8D 21                      BYTE_PUSH_imm1         +33
  $CD38  67                         PUSH_qimm   ; inline operand = 7
  $CD39  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $CD3D  8D 30                      BYTE_PUSH_imm1         +48
  $CD3F  6B                         PUSH_qimm   ; inline operand = 11
  $CD40  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $CD44  8D 30                      BYTE_PUSH_imm1         +48
  $CD46  6F                         PUSH_qimm   ; inline operand = 15
  $CD47  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $CD4B  40                         LOADL_qimm   ; inline operand = 0
  $CD4C  A8 C9 7F                   STORE_abs              $7FC9 (ui_pending_flag_7fc9)
 >$CD4F  A4 C7 7F                   LOADL_abs              $7FC7 (ui_pending_flag_7fc7)
  $CD52  D8 7E CD                   JUMPF_abs              $CD7E
  $CD55  40                         LOADL_qimm   ; inline operand = 0
  $CD56  2B                         STORE_quick   ; inline operand = 11
 >$CD57  0B                         LOADL_quick   ; inline operand = 11
  $CD58  D2                         LSHIFT1
  $CD59  8C 7A F6                   LOADR_imm2             $F67A (strategic_map_bg_palette)
  $CD5C  BB                         ADD
  $CD5D  B0                         DEREF
  $CD5E  B3                         PUSHL
  $CD5F  3B                         PUSH_quick   ; inline operand = 11
  $CD60  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $CD64  0B                         LOADL_quick   ; inline operand = 11
  $CD65  D0                         INC
  $CD66  2B                         STORE_quick   ; inline operand = 11
  $CD67  0B                         LOADL_quick   ; inline operand = 11
  $CD68  54                         LOADR_qimm   ; inline operand = 4
  $CD69  C6                         UCMPLT
  $CD6A  D7 57 CD                   JUMPT_abs              $CD57
  $CD6D  8D 24                      BYTE_PUSH_imm1         +36
  $CD6F  8E B0 15                   PUSH_imm2              $15B0
  $CD72  8E 5C 84                   PUSH_imm2              $845C (strategic_map_chr_tiles)
  $CD75  64                         PUSH_qimm   ; inline operand = 4
  $CD76  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $CD7A  40                         LOADL_qimm   ; inline operand = 0
  $CD7B  A8 C7 7F                   STORE_abs              $7FC7 (ui_pending_flag_7fc7)
 >$CD7E  60                         PUSH_qimm   ; inline operand = 0
  $CD7F  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $CD83  A4 5D 6F                   LOADL_abs              $6F5D (selected_record_idx_9e3c)
  $CD86  8C FF 00                   LOADR_imm2             $00FF
  $CD89  C1                         CMPNE
  $CD8A  D8 99 CD                   JUMPF_abs              $CD99
  $CD8D  A4 5D 6F                   LOADL_abs              $6F5D (selected_record_idx_9e3c)
  $CD90  A8 E6 7B                   STORE_abs              $7BE6 (latched_selected_record_idx)
  $CD93  8A FF 00                   LOADL_imm2             $00FF
  $CD96  A8 5D 6F                   STORE_abs              $6F5D (selected_record_idx_9e3c)
 >$CD99  8A FF 00                   LOADL_imm2             $00FF
  $CD9C  A8 DF 7F                   STORE_abs              $7FDF (ui_input_sel_latch_7fdf)
  $CD9F  8D 14                      BYTE_PUSH_imm1         +20
  $CDA1  62                         PUSH_qimm   ; inline operand = 2
  $CDA2  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $CDA6  40                         LOADL_qimm   ; inline operand = 0
  $CDA7  A8 F9 7B                   STORE_abs              $7BF9 (ui_state_flag_7bf9)
  $CDAA  40                         LOADL_qimm   ; inline operand = 0
  $CDAB  A8 FB 7B                   STORE_abs              $7BFB (combat_unit_window_mode_flag)
  $CDAE  CF                         RETURN

; ============================================================
; sub $CDAF   (frame_off=+0, body @ $CDB4)
; ============================================================
  $CDB4  42                         LOADL_qimm   ; inline operand = 2
  $CDB5  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $CDB8  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $CDBB  D0                         INC
  $CDBC  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $CDBF  8B 1B                      BYTE_LOADR_imm1        +27
  $CDC1  C8                         UCMPGT
  $CDC2  D8 C9 CD                   JUMPF_abs              $CDC9
  $CDC5  43                         LOADL_qimm   ; inline operand = 3
  $CDC6  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
 >$CDC9  CF                         RETURN

; ============================================================
; sub $CDCA   (frame_off=+0, body @ $CDCF)
; ============================================================
  $CDCF  A0 0B 00                   BYTE_LOADL_far         $000B
  $CDD2  8B 5F                      BYTE_LOADR_imm1        +95
  $CDD4  C5                         SCMPGE
  $CDD5  D8 F4 CD                   JUMPF_abs              $CDF4
  $CDD8  A0 0B 00                   BYTE_LOADL_far         $000B
  $CDDB  8B 7A                      BYTE_LOADR_imm1        +122
  $CDDD  C3                         SCMPLE
  $CDDE  D8 F4 CD                   JUMPF_abs              $CDF4
  $CDE1  89 2F                      BYTE_LOADL_imm1        +47
  $CDE3  D6 11 CE                   JUMP_abs               $CE11
 >$CDE6  A0 0B 00                   BYTE_LOADL_far         $000B
  $CDE9  8B 5A                      BYTE_LOADR_imm1        +90
  $CDEB  C3                         SCMPLE
  $CDEC  D8 FD CD                   JUMPF_abs              $CDFD
  $CDEF  89 2B                      BYTE_LOADL_imm1        +43
  $CDF1  D6 11 CE                   JUMP_abs               $CE11
 >$CDF4  A0 0B 00                   BYTE_LOADL_far         $000B
  $CDF7  8B 41                      BYTE_LOADR_imm1        +65
  $CDF9  C5                         SCMPGE
  $CDFA  D7 E6 CD                   JUMPT_abs              $CDE6
 >$CDFD  A0 0B 00                   BYTE_LOADL_far         $000B
  $CE00  8B 2D                      BYTE_LOADR_imm1        +45
  $CE02  C5                         SCMPGE
  $CE03  D8 1D CE                   JUMPF_abs              $CE1D
  $CE06  A0 0B 00                   BYTE_LOADL_far         $000B
  $CE09  8B 3A                      BYTE_LOADR_imm1        +58
  $CE0B  C3                         SCMPLE
  $CE0C  D8 1D CE                   JUMPF_abs              $CE1D
  $CE0F  89 28                      BYTE_LOADL_imm1        +40
 >$CE11  CD                         SWAP
  $CE12  A0 0B 00                   BYTE_LOADL_far         $000B
  $CE15  BC                         SUB
 >$CE16  A2 0B 00                   BYTE_STORE_far         $000B
  $CE19  A0 0B 00                   BYTE_LOADL_far         $000B
  $CE1C  CF                         RETURN
 >$CE1D  A0 0B 00                   BYTE_LOADL_far         $000B
  $CE20  D9 0C 00 20 00 55 CE 21 00 55 CE 23 ... SWITCH_noncontig       count=12   ; .table 12 (key,target) + default (noncontiguous); SWITCH 32=>$CE55 33=>$CE55 35=>$CE5A 37=>$CE5F 40=>$CE64 41=>$CE64 42=>$CE69 43=>$CE69 44=>$CE69 60=>$CE73 62=>$CE78 63=>$CE78 default=>$CE7D
 >$CE55  89 1F                      BYTE_LOADL_imm1        +31
  $CE57  D6 11 CE                   JUMP_abs               $CE11
 >$CE5A  89 4C                      BYTE_LOADL_imm1        +76
  $CE5C  D6 16 CE                   JUMP_abs               $CE16
 >$CE5F  89 4D                      BYTE_LOADL_imm1        +77
  $CE61  D6 16 CE                   JUMP_abs               $CE16
 >$CE64  89 25                      BYTE_LOADL_imm1        +37
  $CE66  D6 11 CE                   JUMP_abs               $CE11
 >$CE69  89 24                      BYTE_LOADL_imm1        +36
  $CE6B  CD                         SWAP
  $CE6C  A0 0B 00                   BYTE_LOADL_far         $000B
  $CE6F  BB                         ADD
  $CE70  D6 16 CE                   JUMP_abs               $CE16
 >$CE73  89 13                      BYTE_LOADL_imm1        +19
  $CE75  D6 16 CE                   JUMP_abs               $CE16
 >$CE78  89 2A                      BYTE_LOADL_imm1        +42
  $CE7A  D6 11 CE                   JUMP_abs               $CE11
 >$CE7D  40                         LOADL_qimm   ; inline operand = 0
  $CE7E  D6 16 CE                   JUMP_abs               $CE16

; ============================================================
; sub $CE81   (frame_off=+0, body @ $CE86)
; ============================================================
  $CE86  A0 0B 00                   BYTE_LOADL_far         $000B
  $CE89  5A                         LOADR_qimm   ; inline operand = 10
  $CE8A  C0                         CMPEQ
  $CE8B  D8 92 CE                   JUMPF_abs              $CE92
  $CE8E  AC AF CD                   CALL_abs               $CDAF (ui_get_menu_count_7fcf) {bytecode}
  $CE91  CF                         RETURN
 >$CE92  A0 0B 00                   BYTE_LOADL_far         $000B
  $CE95  B3                         PUSHL
  $CE96  E9 CA CD 02                CALL_abs_imm1          $CDCA (char_classify) {bytecode}, $02
  $CE9A  A2 0B 00                   BYTE_STORE_far         $000B
  $CE9D  A0 0B 00                   BYTE_LOADL_far         $000B
  $CEA0  B3                         PUSHL
  $CEA1  AA CF 7F                   PUSH_abs               $7FCF (ui_cursor_row)
  $CEA4  AA CD 7F                   PUSH_abs               $7FCD (ui_window_col)
  $CEA7  AA CF 7F                   PUSH_abs               $7FCF (ui_cursor_row)
  $CEAA  AA CD 7F                   PUSH_abs               $7FCD (ui_window_col)
  $CEAD  60                         PUSH_qimm   ; inline operand = 0
  $CEAE  6C                         PUSH_qimm   ; inline operand = 12
  $CEAF  E9 26 F2 0E                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0E
  $CEB3  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $CEB6  D0                         INC
  $CEB7  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $CEBA  8B 1F                      BYTE_LOADR_imm1        +31
  $CEBC  C8                         UCMPGT
  $CEBD  D8 C3 CE                   JUMPF_abs              $CEC3
  $CEC0  AC AF CD                   CALL_abs               $CDAF (ui_get_menu_count_7fcf) {bytecode}
 >$CEC3  CF                         RETURN

; ============================================================
; sub $CEC4   (frame_off=-37, body @ $CEC9)
; ============================================================
  $CEC9  D6 1E CF                   JUMP_abs               $CF1E
 >$CECC  A0 FD FF                   BYTE_LOADL_far         $FFFD
  $CECF  5A                         LOADR_qimm   ; inline operand = 10
  $CED0  C0                         CMPEQ
  $CED1  D8 EC CE                   JUMPF_abs              $CEEC
  $CED4  0B                         LOADL_quick   ; inline operand = 11
  $CED5  A6 CD 7F                   LOADR_abs              $7FCD (ui_window_col)
  $CED8  C1                         CMPNE
  $CED9  D8 1B CF                   JUMPF_abs              $CF1B
  $CEDC  64                         PUSH_qimm   ; inline operand = 4
  $CEDD  DE DB FF                   LEAL_far               $FFDB
  $CEE0  B3                         PUSHL
  $CEE1  AA CF 7F                   PUSH_abs               $7FCF (ui_cursor_row)
  $CEE4  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $CEE7  D1                         DEC
  $CEE8  B3                         PUSHL
  $CEE9  D6 13 CF                   JUMP_abs               $CF13
 >$CEEC  81 FB                      LOADL_near             $FB
  $CEEE  D0                         INC
  $CEEF  85 FB                      STORE_near             $FB
  $CEF1  D1                         DEC
  $CEF2  B3                         PUSHL
  $CEF3  A0 FD FF                   BYTE_LOADL_far         $FFFD
  $CEF6  B3                         PUSHL
  $CEF7  E9 CA CD 02                CALL_abs_imm1          $CDCA (char_classify) {bytecode}, $02
  $CEFB  D4                         BYTE_POPSTORE
  $CEFC  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $CEFF  D0                         INC
  $CF00  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $CF03  8B 20                      BYTE_LOADR_imm1        +32
  $CF05  C0                         CMPEQ
  $CF06  D8 27 CF                   JUMPF_abs              $CF27
  $CF09  64                         PUSH_qimm   ; inline operand = 4
  $CF0A  DE DB FF                   LEAL_far               $FFDB
  $CF0D  B3                         PUSHL
  $CF0E  AA CF 7F                   PUSH_abs               $7FCF (ui_cursor_row)
  $CF11  8D 1F                      BYTE_PUSH_imm1         +31
 >$CF13  AA CF 7F                   PUSH_abs               $7FCF (ui_cursor_row)
  $CF16  3B                         PUSH_quick   ; inline operand = 11
  $CF17  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_blit_from_bank_wrap) {bytecode}, $0C
 >$CF1B  AC AF CD                   CALL_abs               $CDAF (ui_get_menu_count_7fcf) {bytecode}
 >$CF1E  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $CF21  2B                         STORE_quick   ; inline operand = 11
  $CF22  DE DB FF                   LEAL_far               $FFDB
  $CF25  85 FB                      STORE_near             $FB
 >$CF27  0C                         LOADL_quick   ; inline operand = 12
  $CF28  D0                         INC
  $CF29  2C                         STORE_quick   ; inline operand = 12
  $CF2A  D1                         DEC
  $CF2B  D3                         BYTE_DEREF
  $CF2C  A2 FD FF                   BYTE_STORE_far         $FFFD
  $CF2F  D7 CC CE                   JUMPT_abs              $CECC
  $CF32  0B                         LOADL_quick   ; inline operand = 11
  $CF33  A6 CD 7F                   LOADR_abs              $7FCD (ui_window_col)
  $CF36  C1                         CMPNE
  $CF37  D8 4F CF                   JUMPF_abs              $CF4F
  $CF3A  64                         PUSH_qimm   ; inline operand = 4
  $CF3B  DE DB FF                   LEAL_far               $FFDB
  $CF3E  B3                         PUSHL
  $CF3F  AA CF 7F                   PUSH_abs               $7FCF (ui_cursor_row)
  $CF42  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $CF45  D1                         DEC
  $CF46  B3                         PUSHL
  $CF47  AA CF 7F                   PUSH_abs               $7FCF (ui_cursor_row)
  $CF4A  3B                         PUSH_quick   ; inline operand = 11
  $CF4B  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_blit_from_bank_wrap) {bytecode}, $0C
 >$CF4F  CF                         RETURN

; ============================================================
; sub $CF50   (frame_off=+0, body @ $CF55)
; ============================================================
  $CF55  61                         PUSH_qimm   ; inline operand = 1
  $CF56  60                         PUSH_qimm   ; inline operand = 0
  $CF57  65                         PUSH_qimm   ; inline operand = 5
  $CF58  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $CF5C  CF                         RETURN

; ============================================================
; sub $CF5D   (frame_off=+0, body @ $CF62)
; ============================================================
  $CF62  60                         PUSH_qimm   ; inline operand = 0
  $CF63  60                         PUSH_qimm   ; inline operand = 0
  $CF64  68                         PUSH_qimm   ; inline operand = 8
  $CF65  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $CF69  CF                         RETURN

; ============================================================
; sub $CF6A   (frame_off=+0, body @ $CF6F)
; ============================================================
  $CF6F  87 13                      PUSH_near              $13
  $CF71  3F                         PUSH_quick   ; inline operand = 15
  $CF72  3E                         PUSH_quick   ; inline operand = 14
  $CF73  3D                         PUSH_quick   ; inline operand = 13
  $CF74  3C                         PUSH_quick   ; inline operand = 12
  $CF75  60                         PUSH_qimm   ; inline operand = 0
  $CF76  6D                         PUSH_qimm   ; inline operand = 13
  $CF77  E9 26 F2 0E                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0E
  $CF7B  CF                         RETURN

; ============================================================
; sub $CF7C   (frame_off=+0, body @ $CF81)
; ============================================================
  $CF81  3F                         PUSH_quick   ; inline operand = 15
  $CF82  3E                         PUSH_quick   ; inline operand = 14
  $CF83  3D                         PUSH_quick   ; inline operand = 13
  $CF84  3C                         PUSH_quick   ; inline operand = 12
  $CF85  61                         PUSH_qimm   ; inline operand = 1
  $CF86  E9 26 F2 0A                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0A
  $CF8A  CF                         RETURN

; ============================================================
; sub $CF8B   (frame_off=+0, body @ $CF90)
; ============================================================
  $CF90  3D                         PUSH_quick   ; inline operand = 13
  $CF91  3C                         PUSH_quick   ; inline operand = 12
  $CF92  64                         PUSH_qimm   ; inline operand = 4
  $CF93  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $CF97  CF                         RETURN

; ============================================================
; sub $CF98   (frame_off=-2, body @ $CF9D)
; ============================================================
  $CF9D  0D                         LOADL_quick   ; inline operand = 13
  $CF9E  1E                         LOADR_quick   ; inline operand = 14
  $CF9F  C6                         UCMPLT
  $CFA0  D8 BC CF                   JUMPF_abs              $CFBC
  $CFA3  0C                         LOADL_quick   ; inline operand = 12
  $CFA4  B3                         PUSHL
  $CFA5  B0                         DEREF
  $CFA6  D0                         INC
  $CFA7  B1                         POPSTORE
  $CFA8  D1                         DEC
  $CFA9  B3                         PUSHL
  $CFAA  0D                         LOADL_quick   ; inline operand = 13
  $CFAB  5A                         LOADR_qimm   ; inline operand = 10
  $CFAC  C6                         UCMPLT
  $CFAD  D8 B6 CF                   JUMPF_abs              $CFB6
  $CFB0  0D                         LOADL_quick   ; inline operand = 13
  $CFB1  8F 30                      BYTE_ADD_imm1          +48
  $CFB3  D6 B9 CF                   JUMP_abs               $CFB9
 >$CFB6  0D                         LOADL_quick   ; inline operand = 13
  $CFB7  8F 37                      BYTE_ADD_imm1          +55
 >$CFB9  D4                         BYTE_POPSTORE
  $CFBA  41                         LOADL_qimm   ; inline operand = 1
  $CFBB  CF                         RETURN
 >$CFBC  3E                         PUSH_quick   ; inline operand = 14
  $CFBD  0D                         LOADL_quick   ; inline operand = 13
  $CFBE  1E                         LOADR_quick   ; inline operand = 14
  $CFBF  B8                         UDIV
  $CFC0  B3                         PUSHL
  $CFC1  3C                         PUSH_quick   ; inline operand = 12
  $CFC2  E9 98 CF 06                CALL_abs_imm1          $CF98 (num_to_ascii) {bytecode}, $06
  $CFC6  2B                         STORE_quick   ; inline operand = 11
  $CFC7  3E                         PUSH_quick   ; inline operand = 14
  $CFC8  0D                         LOADL_quick   ; inline operand = 13
  $CFC9  1E                         LOADR_quick   ; inline operand = 14
  $CFCA  BA                         UMOD
  $CFCB  B3                         PUSHL
  $CFCC  3C                         PUSH_quick   ; inline operand = 12
  $CFCD  E9 98 CF 06                CALL_abs_imm1          $CF98 (num_to_ascii) {bytecode}, $06
  $CFD1  0B                         LOADL_quick   ; inline operand = 11
  $CFD2  D0                         INC
  $CFD3  CF                         RETURN

; ============================================================
; sub $CFD4   (frame_off=-3, body @ $CFD9)
; ============================================================
  $CFD9  40                         LOADL_qimm   ; inline operand = 0
  $CFDA  2B                         STORE_quick   ; inline operand = 11
  $CFDB  D6 ED CF                   JUMP_abs               $CFED
 >$CFDE  0B                         LOADL_quick   ; inline operand = 11
  $CFDF  5A                         LOADR_qimm   ; inline operand = 10
  $CFE0  B5                         MULT
  $CFE1  B3                         PUSHL
  $CFE2  A0 FD FF                   BYTE_LOADL_far         $FFFD
  $CFE5  B4                         POPR
  $CFE6  BB                         ADD
  $CFE7  2B                         STORE_quick   ; inline operand = 11
  $CFE8  0C                         LOADL_quick   ; inline operand = 12
  $CFE9  B3                         PUSHL
  $CFEA  B0                         DEREF
  $CFEB  D0                         INC
  $CFEC  B1                         POPSTORE
 >$CFED  0C                         LOADL_quick   ; inline operand = 12
  $CFEE  B0                         DEREF
  $CFEF  D3                         BYTE_DEREF
  $CFF0  8F D0                      BYTE_ADD_imm1          -48
  $CFF2  A2 FD FF                   BYTE_STORE_far         $FFFD
  $CFF5  5A                         LOADR_qimm   ; inline operand = 10
  $CFF6  C2                         SCMPLT
  $CFF7  D7 DE CF                   JUMPT_abs              $CFDE
  $CFFA  0B                         LOADL_quick   ; inline operand = 11
  $CFFB  CF                         RETURN

; ============================================================
; sub $CFFC   (frame_off=-23, body @ $D001)
; ============================================================
  $D001  0C                         LOADL_quick   ; inline operand = 12
  $D002  72                         ADD_qimm   ; inline operand = 2
  $D003  2C                         STORE_quick   ; inline operand = 12
  $D004  8F FE                      BYTE_ADD_imm1          -2
  $D006  B0                         DEREF
  $D007  85 FD                      STORE_near             $FD
  $D009  0C                         LOADL_quick   ; inline operand = 12
  $D00A  85 E9                      STORE_near             $E9
  $D00C  D6 18 D0                   JUMP_abs               $D018
 >$D00F  0D                         LOADL_quick   ; inline operand = 13
  $D010  D0                         INC
  $D011  2D                         STORE_quick   ; inline operand = 13
  $D012  D1                         DEC
  $D013  B3                         PUSHL
  $D014  A0 FF FF                   BYTE_LOADL_far         $FFFF
  $D017  D4                         BYTE_POPSTORE
 >$D018  81 FD                      LOADL_near             $FD
  $D01A  D0                         INC
  $D01B  85 FD                      STORE_near             $FD
  $D01D  D1                         DEC
  $D01E  D3                         BYTE_DEREF
  $D01F  A2 FF FF                   BYTE_STORE_far         $FFFF
  $D022  D8 30 D1                   JUMPF_abs              $D130
  $D025  A0 FF FF                   BYTE_LOADL_far         $FFFF
  $D028  8B 25                      BYTE_LOADR_imm1        +37
  $D02A  C0                         CMPEQ
  $D02B  D8 0F D0                   JUMPF_abs              $D00F
  $D02E  DE F3 FF                   LEAL_far               $FFF3
  $D031  85 F1                      STORE_near             $F1
  $D033  46                         LOADL_qimm   ; inline operand = 6
  $D034  85 EB                      STORE_near             $EB
  $D036  40                         LOADL_qimm   ; inline operand = 0
  $D037  85 EF                      STORE_near             $EF
  $D039  81 FD                      LOADL_near             $FD
  $D03B  D3                         BYTE_DEREF
  $D03C  A2 FF FF                   BYTE_STORE_far         $FFFF
  $D03F  A0 FF FF                   BYTE_LOADL_far         $FFFF
  $D042  B3                         PUSHL
  $D043  E9 65 CA 02                CALL_abs_imm1          $CA65 (is_digit) {bytecode}, $02
  $D047  D8 55 D0                   JUMPF_abs              $D055
  $D04A  DE FD FF                   LEAL_far               $FFFD
  $D04D  B3                         PUSHL
  $D04E  E9 D4 CF 02                CALL_abs_imm1          $CFD4 (atoi_decimal) {bytecode}, $02
  $D052  D6 56 D0                   JUMP_abs               $D056
 >$D055  40                         LOADL_qimm   ; inline operand = 0
 >$D056  85 ED                      STORE_near             $ED
  $D058  81 FD                      LOADL_near             $FD
  $D05A  D0                         INC
  $D05B  85 FD                      STORE_near             $FD
  $D05D  D1                         DEC
  $D05E  D3                         BYTE_DEREF
  $D05F  A2 FF FF                   BYTE_STORE_far         $FFFF
  $D062  8B 2E                      BYTE_LOADR_imm1        +46
  $D064  C0                         CMPEQ
  $D065  D8 7F D0                   JUMPF_abs              $D07F
  $D068  DE FD FF                   LEAL_far               $FFFD
  $D06B  B3                         PUSHL
  $D06C  E9 D4 CF 02                CALL_abs_imm1          $CFD4 (atoi_decimal) {bytecode}, $02
  $D070  85 EB                      STORE_near             $EB
  $D072  41                         LOADL_qimm   ; inline operand = 1
  $D073  85 EF                      STORE_near             $EF
  $D075  81 FD                      LOADL_near             $FD
  $D077  D0                         INC
  $D078  85 FD                      STORE_near             $FD
  $D07A  D1                         DEC
  $D07B  D3                         BYTE_DEREF
  $D07C  A2 FF FF                   BYTE_STORE_far         $FFFF
 >$D07F  A0 FF FF                   BYTE_LOADL_far         $FFFF
  $D082  B3                         PUSHL
  $D083  E9 30 CB 02                CALL_abs_imm1          $CB30 (to_upper) {bytecode}, $02
  $D087  D9 04 00 00 00 2F D1 43 00 D0 D0 44 ... SWITCH_noncontig       count=4   ; .table 4 (key,target) + default (noncontiguous); SWITCH 0=>$D12F 67=>$D0D0 68=>$D09C 83=>$D0B7 default=>$D00F
 >$D09C  6A                         PUSH_qimm   ; inline operand = 10
  $D09D  81 E9                      LOADL_near             $E9
  $D09F  72                         ADD_qimm   ; inline operand = 2
  $D0A0  85 E9                      STORE_near             $E9
  $D0A2  8F FE                      BYTE_ADD_imm1          -2
  $D0A4  B0                         DEREF
  $D0A5  B3                         PUSHL
  $D0A6  DE F1 FF                   LEAL_far               $FFF1
  $D0A9  B3                         PUSHL
  $D0AA  E9 98 CF 06                CALL_abs_imm1          $CF98 (num_to_ascii) {bytecode}, $06
  $D0AE  CD                         SWAP
  $D0AF  81 ED                      LOADL_near             $ED
  $D0B1  BC                         SUB
  $D0B2  85 ED                      STORE_near             $ED
  $D0B4  D6 E5 D0                   JUMP_abs               $D0E5
 >$D0B7  81 E9                      LOADL_near             $E9
  $D0B9  72                         ADD_qimm   ; inline operand = 2
  $D0BA  85 E9                      STORE_near             $E9
  $D0BC  8F FE                      BYTE_ADD_imm1          -2
  $D0BE  B0                         DEREF
  $D0BF  85 F1                      STORE_near             $F1
  $D0C1  87 F1                      PUSH_near              $F1
  $D0C3  E9 7E CA 02                CALL_abs_imm1          $CA7E (strlen) {bytecode}, $02
  $D0C7  CD                         SWAP
  $D0C8  81 ED                      LOADL_near             $ED
  $D0CA  BC                         SUB
  $D0CB  85 ED                      STORE_near             $ED
  $D0CD  D6 FC D0                   JUMP_abs               $D0FC
 >$D0D0  81 ED                      LOADL_near             $ED
  $D0D2  D1                         DEC
  $D0D3  85 ED                      STORE_near             $ED
  $D0D5  81 F1                      LOADL_near             $F1
  $D0D7  D0                         INC
  $D0D8  85 F1                      STORE_near             $F1
  $D0DA  D1                         DEC
  $D0DB  B3                         PUSHL
  $D0DC  81 E9                      LOADL_near             $E9
  $D0DE  72                         ADD_qimm   ; inline operand = 2
  $D0DF  85 E9                      STORE_near             $E9
  $D0E1  8F FE                      BYTE_ADD_imm1          -2
  $D0E3  B0                         DEREF
  $D0E4  D4                         BYTE_POPSTORE
 >$D0E5  87 F1                      PUSH_near              $F1
  $D0E7  40                         LOADL_qimm   ; inline operand = 0
  $D0E8  D4                         BYTE_POPSTORE
  $D0E9  DE F3 FF                   LEAL_far               $FFF3
  $D0EC  85 F1                      STORE_near             $F1
  $D0EE  40                         LOADL_qimm   ; inline operand = 0
  $D0EF  85 EF                      STORE_near             $EF
  $D0F1  D6 FC D0                   JUMP_abs               $D0FC
 >$D0F4  0D                         LOADL_quick   ; inline operand = 13
  $D0F5  D0                         INC
  $D0F6  2D                         STORE_quick   ; inline operand = 13
  $D0F7  D1                         DEC
  $D0F8  B3                         PUSHL
  $D0F9  89 20                      BYTE_LOADL_imm1        +32
  $D0FB  D4                         BYTE_POPSTORE
 >$D0FC  81 ED                      LOADL_near             $ED
  $D0FE  D1                         DEC
  $D0FF  85 ED                      STORE_near             $ED
  $D101  D0                         INC
  $D102  50                         LOADR_qimm   ; inline operand = 0
  $D103  C4                         SCMPGT
  $D104  D7 F4 D0                   JUMPT_abs              $D0F4
 >$D107  81 F1                      LOADL_near             $F1
  $D109  D3                         BYTE_DEREF
  $D10A  D8 18 D0                   JUMPF_abs              $D018
  $D10D  81 EF                      LOADL_near             $EF
  $D10F  D8 19 D1                   JUMPF_abs              $D119
  $D112  81 EB                      LOADL_near             $EB
  $D114  50                         LOADR_qimm   ; inline operand = 0
  $D115  C4                         SCMPGT
  $D116  D8 27 D1                   JUMPF_abs              $D127
 >$D119  0D                         LOADL_quick   ; inline operand = 13
  $D11A  D0                         INC
  $D11B  2D                         STORE_quick   ; inline operand = 13
  $D11C  D1                         DEC
  $D11D  B3                         PUSHL
  $D11E  81 F1                      LOADL_near             $F1
  $D120  D3                         BYTE_DEREF
  $D121  D4                         BYTE_POPSTORE
  $D122  81 EB                      LOADL_near             $EB
  $D124  D1                         DEC
  $D125  85 EB                      STORE_near             $EB
 >$D127  81 F1                      LOADL_near             $F1
  $D129  D0                         INC
  $D12A  85 F1                      STORE_near             $F1
  $D12C  D6 07 D1                   JUMP_abs               $D107
 >$D12F  CF                         RETURN
 >$D130  3D                         PUSH_quick   ; inline operand = 13
  $D131  40                         LOADL_qimm   ; inline operand = 0
  $D132  D4                         BYTE_POPSTORE
  $D133  CF                         RETURN

; ============================================================
; sub $D134   (frame_off=-150, body @ $D139)
; ============================================================
  $D139  DE 6A FF                   LEAL_far               $FF6A
  $D13C  B3                         PUSHL
  $D13D  DE 0B 00                   LEAL_far               $000B
  $D140  B3                         PUSHL
  $D141  E9 FC CF 04                CALL_abs_imm1          $CFFC (format_string) {bytecode}, $04
  $D145  DE 6A FF                   LEAL_far               $FF6A
  $D148  B3                         PUSHL
  $D149  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $D14D  CF                         RETURN

; ============================================================
; sub $D14E   (frame_off=-8, body @ $D153)
; ============================================================
  $D153  42                         LOADL_qimm   ; inline operand = 2
  $D154  2B                         STORE_quick   ; inline operand = 11
  $D155  A4 D3 7F                   LOADL_abs              $7FD3 (ui_input_mode)
  $D158  D5 00 00 05 00 6B D1 69 D1 E1 D1 E8 ... SWITCH_contig          limit=5   ; .table 5 word targets (contiguous); SWITCH 0=>$D169 1=>$D1E1 2=>$D1E8 3=>$D1EE 4=>$D24E default=>$D16B
 >$D169  40                         LOADL_qimm   ; inline operand = 0
 >$D16A  2B                         STORE_quick   ; inline operand = 11
 >$D16B  0B                         LOADL_quick   ; inline operand = 11
  $D16C  51                         LOADR_qimm   ; inline operand = 1
  $D16D  C8                         UCMPGT
  $D16E  D7 C9 D1                   JUMPT_abs              $D1C9
 >$D171  0B                         LOADL_quick   ; inline operand = 11
  $D172  51                         LOADR_qimm   ; inline operand = 1
  $D173  DA                         AND
  $D174  2B                         STORE_quick   ; inline operand = 11
  $D175  A6 DF 7F                   LOADR_abs              $7FDF (ui_input_sel_latch_7fdf)
  $D178  C1                         CMPNE
  $D179  D8 AD D1                   JUMPF_abs              $D1AD
  $D17C  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $D17F  29                         STORE_quick   ; inline operand = 9
  $D180  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $D183  28                         STORE_quick   ; inline operand = 8
  $D184  61                         PUSH_qimm   ; inline operand = 1
  $D185  8D 1A                      BYTE_PUSH_imm1         +26
  $D187  8D 1D                      BYTE_PUSH_imm1         +29
  $D189  8D 1A                      BYTE_PUSH_imm1         +26
  $D18B  8D 14                      BYTE_PUSH_imm1         +20
  $D18D  E9 6A CF 0A                CALL_abs_imm1          $CF6A (ppu_render_rect_wrap) {bytecode}, $0A
  $D191  8D 1A                      BYTE_PUSH_imm1         +26
  $D193  8D 15                      BYTE_PUSH_imm1         +21
  $D195  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $D199  0B                         LOADL_quick   ; inline operand = 11
  $D19A  D0                         INC
  $D19B  B3                         PUSHL
  $D19C  8E 8A F6                   PUSH_imm2              $F68A
  $D19F  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $D1A3  38                         PUSH_quick   ; inline operand = 8
  $D1A4  39                         PUSH_quick   ; inline operand = 9
  $D1A5  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $D1A9  0B                         LOADL_quick   ; inline operand = 11
  $D1AA  A8 DF 7F                   STORE_abs              $7FDF (ui_input_sel_latch_7fdf)
 >$D1AD  A4 E7 7F                   LOADL_abs              $7FE7 (ui_timer_gate_flag_7fe7)
  $D1B0  52                         LOADR_qimm   ; inline operand = 2
  $D1B1  C1                         CMPNE
  $D1B2  D8 69 D2                   JUMPF_abs              $D269
  $D1B5  A4 E9 7F                   LOADL_abs              $7FE9 (frame_counter)
  $D1B8  D1                         DEC
  $D1B9  A8 E9 7F                   STORE_abs              $7FE9 (frame_counter)
  $D1BC  D9 02 00 64 00 52 D2 00 00 70 D2 69 ... SWITCH_noncontig       count=2   ; .table 2 (key,target) + default (noncontiguous); SWITCH 100=>$D252 0=>$D270 default=>$D269
 >$D1C9  40                         LOADL_qimm   ; inline operand = 0
 >$D1CA  2B                         STORE_quick   ; inline operand = 11
  $D1CB  3A                         PUSH_quick   ; inline operand = 10
  $D1CC  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $D1D0  B3                         PUSHL
  $D1D1  0B                         LOADL_quick   ; inline operand = 11
  $D1D2  8C D5 7F                   LOADR_imm2             $7FD5
  $D1D5  BB                         ADD
  $D1D6  D3                         BYTE_DEREF
  $D1D7  B4                         POPR
  $D1D8  C1                         CMPNE
  $D1D9  D8 71 D1                   JUMPF_abs              $D171
  $D1DC  0B                         LOADL_quick   ; inline operand = 11
  $D1DD  D0                         INC
  $D1DE  D6 CA D1                   JUMP_abs               $D1CA
 >$D1E1  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
 >$D1E4  2A                         STORE_quick   ; inline operand = 10
  $D1E5  D6 6B D1                   JUMP_abs               $D16B
 >$D1E8  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $D1EB  D6 E4 D1                   JUMP_abs               $D1E4
 >$D1EE  A4 E1 7F                   LOADL_abs              $7FE1
  $D1F1  8C FF 00                   LOADR_imm2             $00FF
  $D1F4  C0                         CMPEQ
  $D1F5  D8 3D D2                   JUMPF_abs              $D23D
  $D1F8  40                         LOADL_qimm   ; inline operand = 0
  $D1F9  D6 FE D1                   JUMP_abs               $D1FE
 >$D1FC  0B                         LOADL_quick   ; inline operand = 11
  $D1FD  D0                         INC
 >$D1FE  2B                         STORE_quick   ; inline operand = 11
  $D1FF  AC 7E D7                   CALL_abs               $D77E (ui_helper_d77e) {bytecode}
  $D202  B3                         PUSHL
  $D203  0B                         LOADL_quick   ; inline operand = 11
  $D204  8C D5 7F                   LOADR_imm2             $7FD5
  $D207  BB                         ADD
  $D208  D3                         BYTE_DEREF
  $D209  B4                         POPR
  $D20A  C1                         CMPNE
  $D20B  D8 14 D2                   JUMPF_abs              $D214
  $D20E  0B                         LOADL_quick   ; inline operand = 11
  $D20F  58                         LOADR_qimm   ; inline operand = 8
  $D210  C6                         UCMPLT
  $D211  D7 FC D1                   JUMPT_abs              $D1FC
 >$D214  0B                         LOADL_quick   ; inline operand = 11
  $D215  58                         LOADR_qimm   ; inline operand = 8
  $D216  C9                         UCMPGE
  $D217  D8 37 D2                   JUMPF_abs              $D237
  $D21A  40                         LOADL_qimm   ; inline operand = 0
  $D21B  D6 20 D2                   JUMP_abs               $D220
 >$D21E  0B                         LOADL_quick   ; inline operand = 11
  $D21F  D0                         INC
 >$D220  2B                         STORE_quick   ; inline operand = 11
  $D221  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $D224  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $D228  B3                         PUSHL
  $D229  0B                         LOADL_quick   ; inline operand = 11
  $D22A  8C D5 7F                   LOADR_imm2             $7FD5
  $D22D  BB                         ADD
  $D22E  D3                         BYTE_DEREF
  $D22F  B4                         POPR
  $D230  C1                         CMPNE
  $D231  D7 1E D2                   JUMPT_abs              $D21E
  $D234  0B                         LOADL_quick   ; inline operand = 11
  $D235  D0                         INC
  $D236  2B                         STORE_quick   ; inline operand = 11
 >$D237  0B                         LOADL_quick   ; inline operand = 11
  $D238  51                         LOADR_qimm   ; inline operand = 1
  $D239  DA                         AND
  $D23A  A8 E1 7F                   STORE_abs              $7FE1
 >$D23D  A4 E1 7F                   LOADL_abs              $7FE1
  $D240  2B                         STORE_quick   ; inline operand = 11
  $D241  A4 E8 7B                   LOADL_abs              $7BE8 (cur_combat_side)
  $D244  D8 6B D1                   JUMPF_abs              $D16B
  $D247  41                         LOADL_qimm   ; inline operand = 1
  $D248  CD                         SWAP
  $D249  0B                         LOADL_quick   ; inline operand = 11
  $D24A  DC                         XOR
  $D24B  D6 6A D1                   JUMP_abs               $D16A
 >$D24E  41                         LOADL_qimm   ; inline operand = 1
  $D24F  D6 6A D1                   JUMP_abs               $D16A
 >$D252  AA E7 7F                   PUSH_abs               $7FE7 (ui_timer_gate_flag_7fe7)
  $D255  60                         PUSH_qimm   ; inline operand = 0
  $D256  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $D259  53                         LOADR_qimm   ; inline operand = 3
  $D25A  BD                         LSHIFT
  $D25B  D1                         DEC
  $D25C  B3                         PUSHL
  $D25D  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $D260  53                         LOADR_qimm   ; inline operand = 3
  $D261  BD                         LSHIFT
  $D262  B3                         PUSHL
  $D263  60                         PUSH_qimm   ; inline operand = 0
  $D264  63                         PUSH_qimm   ; inline operand = 3
  $D265  E9 26 F2 0C                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0C
 >$D269  3B                         PUSH_quick   ; inline operand = 11
  $D26A  66                         PUSH_qimm   ; inline operand = 6
  $D26B  E9 26 F2 04                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $04
  $D26F  CF                         RETURN
 >$D270  62                         PUSH_qimm   ; inline operand = 2
  $D271  60                         PUSH_qimm   ; inline operand = 0
  $D272  8E F8 00                   PUSH_imm2              $00F8
  $D275  8E F8 00                   PUSH_imm2              $00F8
  $D278  60                         PUSH_qimm   ; inline operand = 0
  $D279  63                         PUSH_qimm   ; inline operand = 3
  $D27A  E9 26 F2 0C                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0C
  $D27E  8A C8 00                   LOADL_imm2             $00C8
  $D281  A8 E9 7F                   STORE_abs              $7FE9 (frame_counter)
  $D284  D6 69 D2                   JUMP_abs               $D269

; ============================================================
; sub $D287   (frame_off=-2, body @ $D28C)
; ============================================================
 >$D28C  AC 4E D1                   CALL_abs               $D14E (poll_input) {bytecode}
  $D28F  D7 8C D2                   JUMPT_abs              $D28C
  $D292  40                         LOADL_qimm   ; inline operand = 0
  $D293  2B                         STORE_quick   ; inline operand = 11
 >$D294  AC 4E D1                   CALL_abs               $D14E (poll_input) {bytecode}
  $D297  2B                         STORE_quick   ; inline operand = 11
  $D298  D8 94 D2                   JUMPF_abs              $D294
  $D29B  0B                         LOADL_quick   ; inline operand = 11
  $D29C  CF                         RETURN

; ============================================================
; sub $D29D   (frame_off=+0, body @ $D2A2)
; ============================================================
  $D2A2  0C                         LOADL_quick   ; inline operand = 12
  $D2A3  D8 AB D2                   JUMPF_abs              $D2AB
  $D2A6  0C                         LOADL_quick   ; inline operand = 12
  $D2A7  D1                         DEC
  $D2A8  D6 AC D2                   JUMP_abs               $D2AC
 >$D2AB  42                         LOADL_qimm   ; inline operand = 2
 >$D2AC  A8 E7 7F                   STORE_abs              $7FE7 (ui_timer_gate_flag_7fe7)
  $D2AF  0C                         LOADL_quick   ; inline operand = 12
  $D2B0  D7 CA D2                   JUMPT_abs              $D2CA
  $D2B3  62                         PUSH_qimm   ; inline operand = 2
  $D2B4  60                         PUSH_qimm   ; inline operand = 0
  $D2B5  8E F8 00                   PUSH_imm2              $00F8
  $D2B8  8E F8 00                   PUSH_imm2              $00F8
  $D2BB  60                         PUSH_qimm   ; inline operand = 0
  $D2BC  63                         PUSH_qimm   ; inline operand = 3
  $D2BD  E9 26 F2 0C                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0C
  $D2C1  8D 13                      BYTE_PUSH_imm1         +19
  $D2C3  E9 26 F2 02                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $02
  $D2C7  D6 F8 D2                   JUMP_abs               $D2F8
 >$D2CA  0C                         LOADL_quick   ; inline operand = 12
  $D2CB  51                         LOADR_qimm   ; inline operand = 1
  $D2CC  C0                         CMPEQ
  $D2CD  D8 DB D2                   JUMPF_abs              $D2DB
  $D2D0  62                         PUSH_qimm   ; inline operand = 2
  $D2D1  60                         PUSH_qimm   ; inline operand = 0
  $D2D2  8E F8 00                   PUSH_imm2              $00F8
  $D2D5  8E F8 00                   PUSH_imm2              $00F8
  $D2D8  D6 EC D2                   JUMP_abs               $D2EC
 >$D2DB  AA E7 7F                   PUSH_abs               $7FE7 (ui_timer_gate_flag_7fe7)
  $D2DE  60                         PUSH_qimm   ; inline operand = 0
  $D2DF  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $D2E2  53                         LOADR_qimm   ; inline operand = 3
  $D2E3  BD                         LSHIFT
  $D2E4  D1                         DEC
  $D2E5  B3                         PUSHL
  $D2E6  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $D2E9  53                         LOADR_qimm   ; inline operand = 3
  $D2EA  BD                         LSHIFT
  $D2EB  B3                         PUSHL
 >$D2EC  60                         PUSH_qimm   ; inline operand = 0
  $D2ED  63                         PUSH_qimm   ; inline operand = 3
  $D2EE  E9 26 F2 0C                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $0C
  $D2F2  8A C8 00                   LOADL_imm2             $00C8
  $D2F5  A8 E9 7F                   STORE_abs              $7FE9 (frame_counter)
 >$D2F8  CF                         RETURN

; ============================================================
; sub $D2F9   (frame_off=+0, body @ $D2FE)
; ============================================================
  $D2FE  61                         PUSH_qimm   ; inline operand = 1
  $D2FF  8D 13                      BYTE_PUSH_imm1         +19
  $D301  69                         PUSH_qimm   ; inline operand = 9
  $D302  68                         PUSH_qimm   ; inline operand = 8
  $D303  62                         PUSH_qimm   ; inline operand = 2
  $D304  E9 42 CC 0A                CALL_abs_imm1          $CC42 (ppu_blit_nobank_wrap) {bytecode}, $0A
  $D308  CF                         RETURN

; ============================================================
; sub $D309   (frame_off=+0, body @ $D30E)
; ============================================================
  $D30E  61                         PUSH_qimm   ; inline operand = 1
  $D30F  8D 1A                      BYTE_PUSH_imm1         +26
  $D311  69                         PUSH_qimm   ; inline operand = 9
  $D312  8D 14                      BYTE_PUSH_imm1         +20
  $D314  62                         PUSH_qimm   ; inline operand = 2
  $D315  E9 42 CC 0A                CALL_abs_imm1          $CC42 (ppu_blit_nobank_wrap) {bytecode}, $0A
  $D319  CF                         RETURN

; ============================================================
; sub $D31A   (frame_off=+0, body @ $D31F)
; ============================================================
  $D31F  AC 59 D7                   CALL_abs               $D759 (ui_helper_d759) {bytecode}
  $D322  AC 09 D3                   CALL_abs               $D309 (ui_draw_window_d309) {bytecode}
  $D325  CF                         RETURN

; ============================================================
; sub $D326   (frame_off=+0, body @ $D32B)
; ============================================================
  $D32B  A4 C5 7F                   LOADL_abs              $7FC5 (ui_msg_oneshot_flag_7fc5)
  $D32E  D8 38 D3                   JUMPF_abs              $D338
  $D331  AC 09 D3                   CALL_abs               $D309 (ui_draw_window_d309) {bytecode}
  $D334  40                         LOADL_qimm   ; inline operand = 0
  $D335  A8 C5 7F                   STORE_abs              $7FC5 (ui_msg_oneshot_flag_7fc5)
 >$D338  A4 D1 7F                   LOADL_abs              $7FD1 (ui_msg_col_shift_flag)
  $D33B  D8 43 D3                   JUMPF_abs              $D343
  $D33E  89 14                      BYTE_LOADL_imm1        +20
  $D340  D6 45 D3                   JUMP_abs               $D345
 >$D343  89 16                      BYTE_LOADL_imm1        +22
 >$D345  B3                         PUSHL
  $D346  62                         PUSH_qimm   ; inline operand = 2
  $D347  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $D34B  3C                         PUSH_quick   ; inline operand = 12
  $D34C  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $D350  CF                         RETURN

; ============================================================
; sub $D351   (frame_off=-2, body @ $D356)
; ============================================================
  $D356  3C                         PUSH_quick   ; inline operand = 12
  $D357  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $D35B  61                         PUSH_qimm   ; inline operand = 1
  $D35C  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
 >$D360  AC 87 D2                   CALL_abs               $D287 (wait_button_edge) {bytecode}
  $D363  2B                         STORE_quick   ; inline operand = 11
  $D364  8B 40                      BYTE_LOADR_imm1        +64
  $D366  C1                         CMPNE
  $D367  D8 78 D3                   JUMPF_abs              $D378
  $D36A  0B                         LOADL_quick   ; inline operand = 11
  $D36B  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $D36E  C1                         CMPNE
  $D36F  D8 78 D3                   JUMPF_abs              $D378
  $D372  0B                         LOADL_quick   ; inline operand = 11
  $D373  52                         LOADR_qimm   ; inline operand = 2
  $D374  C1                         CMPNE
  $D375  D7 60 D3                   JUMPT_abs              $D360
 >$D378  60                         PUSH_qimm   ; inline operand = 0
  $D379  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $D37D  0B                         LOADL_quick   ; inline operand = 11
  $D37E  8B 40                      BYTE_LOADR_imm1        +64
  $D380  C0                         CMPEQ
  $D381  D8 8E D3                   JUMPF_abs              $D38E
  $D384  8D 3C                      BYTE_PUSH_imm1         +60
  $D386  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $D38A  41                         LOADL_qimm   ; inline operand = 1
  $D38B  D6 A1 D3                   JUMP_abs               $D3A1
 >$D38E  0B                         LOADL_quick   ; inline operand = 11
  $D38F  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $D392  C0                         CMPEQ
  $D393  D8 A0 D3                   JUMPF_abs              $D3A0
  $D396  8D 3E                      BYTE_PUSH_imm1         +62
  $D398  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $D39C  40                         LOADL_qimm   ; inline operand = 0
  $D39D  D6 A1 D3                   JUMP_abs               $D3A1
 >$D3A0  42                         LOADL_qimm   ; inline operand = 2
 >$D3A1  2B                         STORE_quick   ; inline operand = 11
  $D3A2  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $D3A5  0B                         LOADL_quick   ; inline operand = 11
  $D3A6  CF                         RETURN

; ============================================================
; sub $D3A7   (frame_off=-2, body @ $D3AC)
; ============================================================
  $D3AC  8E 95 F6                   PUSH_imm2              $F695 (msg_y_n_f695)
  $D3AF  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $D3B3  61                         PUSH_qimm   ; inline operand = 1
  $D3B4  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
 >$D3B8  AC 87 D2                   CALL_abs               $D287 (wait_button_edge) {bytecode}
  $D3BB  2B                         STORE_quick   ; inline operand = 11
  $D3BC  8B 40                      BYTE_LOADR_imm1        +64
  $D3BE  C1                         CMPNE
  $D3BF  D8 CA D3                   JUMPF_abs              $D3CA
  $D3C2  0B                         LOADL_quick   ; inline operand = 11
  $D3C3  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $D3C6  C1                         CMPNE
  $D3C7  D7 B8 D3                   JUMPT_abs              $D3B8
 >$D3CA  60                         PUSH_qimm   ; inline operand = 0
  $D3CB  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $D3CF  0B                         LOADL_quick   ; inline operand = 11
  $D3D0  8B 40                      BYTE_LOADR_imm1        +64
  $D3D2  C0                         CMPEQ
  $D3D3  D8 E0 D3                   JUMPF_abs              $D3E0
  $D3D6  8D 59                      BYTE_PUSH_imm1         +89
  $D3D8  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $D3DC  41                         LOADL_qimm   ; inline operand = 1
  $D3DD  D6 E7 D3                   JUMP_abs               $D3E7
 >$D3E0  8D 4E                      BYTE_PUSH_imm1         +78
  $D3E2  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $D3E6  40                         LOADL_qimm   ; inline operand = 0
 >$D3E7  2B                         STORE_quick   ; inline operand = 11
  $D3E8  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $D3EB  0B                         LOADL_quick   ; inline operand = 11
  $D3EC  CF                         RETURN

; ============================================================
; sub $D3ED   (frame_off=-20, body @ $D3F2)
; ============================================================
  $D3F2  40                         LOADL_qimm   ; inline operand = 0
  $D3F3  24                         STORE_quick   ; inline operand = 4
  $D3F4  40                         LOADL_qimm   ; inline operand = 0
  $D3F5  26                         STORE_quick   ; inline operand = 6
  $D3F6  41                         LOADL_qimm   ; inline operand = 1
  $D3F7  25                         STORE_quick   ; inline operand = 5
 >$D3F8  DE F4 FF                   LEAL_far               $FFF4
  $D3FB  B3                         PUSHL
  $D3FC  05                         LOADL_quick   ; inline operand = 5
  $D3FD  D2                         LSHIFT1
  $D3FE  B4                         POPR
  $D3FF  BB                         ADD
  $D400  B3                         PUSHL
  $D401  8A FF 00                   LOADL_imm2             $00FF
  $D404  B1                         POPSTORE
  $D405  05                         LOADL_quick   ; inline operand = 5
  $D406  D0                         INC
  $D407  25                         STORE_quick   ; inline operand = 5
  $D408  05                         LOADL_quick   ; inline operand = 5
  $D409  55                         LOADR_qimm   ; inline operand = 5
  $D40A  C3                         SCMPLE
  $D40B  D7 F8 D3                   JUMPT_abs              $D3F8
  $D40E  36                         PUSH_quick   ; inline operand = 6
  $D40F  8E 9E F6                   PUSH_imm2              $F69E (msg_fmt__d_f69e)
  $D412  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $D416  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $D419  D1                         DEC
  $D41A  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $D41D  61                         PUSH_qimm   ; inline operand = 1
  $D41E  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $D422  AC 87 D2                   CALL_abs               $D287 (wait_button_edge) {bytecode}
  $D425  40                         LOADL_qimm   ; inline operand = 0
  $D426  22                         STORE_quick   ; inline operand = 2
 >$D427  AC 4E D1                   CALL_abs               $D14E (poll_input) {bytecode}
  $D42A  D9 06 00 01 00 59 D4 02 00 47 D4 10 ... SWITCH_noncontig       count=6   ; .table 6 (key,target) + default (noncontiguous); SWITCH 1=>$D459 2=>$D447 16=>$D469 32=>$D4AF 64=>$D4DB 128=>$D511 default=>$D460
 >$D447  60                         PUSH_qimm   ; inline operand = 0
  $D448  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $D44C  A4 E0 7B                   LOADL_abs              $7BE0 (ui_input_prompt_active_flag)
  $D44F  51                         LOADR_qimm   ; inline operand = 1
  $D450  C0                         CMPEQ
  $D451  D8 57 D4                   JUMPF_abs              $D457
  $D454  89 FF                      BYTE_LOADL_imm1        -1
  $D456  CF                         RETURN
 >$D457  40                         LOADL_qimm   ; inline operand = 0
  $D458  CF                         RETURN
 >$D459  60                         PUSH_qimm   ; inline operand = 0
  $D45A  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $D45E  41                         LOADL_qimm   ; inline operand = 1
  $D45F  22                         STORE_quick   ; inline operand = 2
 >$D460  02                         LOADL_quick   ; inline operand = 2
  $D461  D8 27 D4                   JUMPF_abs              $D427
  $D464  40                         LOADL_qimm   ; inline operand = 0
  $D465  23                         STORE_quick   ; inline operand = 3
  $D466  D6 73 D5                   JUMP_abs               $D573
 >$D469  DE F4 FF                   LEAL_far               $FFF4
  $D46C  B3                         PUSHL
  $D46D  04                         LOADL_quick   ; inline operand = 4
  $D46E  D2                         LSHIFT1
  $D46F  B4                         POPR
  $D470  BB                         ADD
  $D471  B3                         PUSHL
  $D472  B0                         DEREF
  $D473  D0                         INC
  $D474  B1                         POPSTORE
  $D475  5A                         LOADR_qimm   ; inline operand = 10
  $D476  C9                         UCMPGE
  $D477  D8 85 D4                   JUMPF_abs              $D485
  $D47A  DE F4 FF                   LEAL_far               $FFF4
  $D47D  B3                         PUSHL
  $D47E  04                         LOADL_quick   ; inline operand = 4
  $D47F  D2                         LSHIFT1
  $D480  B4                         POPR
  $D481  BB                         ADD
  $D482  B3                         PUSHL
  $D483  40                         LOADL_qimm   ; inline operand = 0
  $D484  B1                         POPSTORE
 >$D485  DE F4 FF                   LEAL_far               $FFF4
  $D488  B3                         PUSHL
  $D489  04                         LOADL_quick   ; inline operand = 4
  $D48A  D2                         LSHIFT1
  $D48B  B4                         POPR
  $D48C  BB                         ADD
  $D48D  B0                         DEREF
  $D48E  B3                         PUSHL
  $D48F  8E A1 F6                   PUSH_imm2              $F6A1
 >$D492  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $D496  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $D499  D1                         DEC
  $D49A  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $D49D  60                         PUSH_qimm   ; inline operand = 0
  $D49E  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $D4A2  62                         PUSH_qimm   ; inline operand = 2
  $D4A3  E9 3E D7 02                CALL_abs_imm1          $D73E (delay_loop) {bytecode}, $02
  $D4A7  61                         PUSH_qimm   ; inline operand = 1
  $D4A8  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $D4AC  D6 60 D4                   JUMP_abs               $D460
 >$D4AF  DE F4 FF                   LEAL_far               $FFF4
  $D4B2  B3                         PUSHL
  $D4B3  04                         LOADL_quick   ; inline operand = 4
  $D4B4  D2                         LSHIFT1
  $D4B5  B4                         POPR
  $D4B6  BB                         ADD
  $D4B7  B3                         PUSHL
  $D4B8  B0                         DEREF
  $D4B9  D1                         DEC
  $D4BA  B1                         POPSTORE
  $D4BB  5A                         LOADR_qimm   ; inline operand = 10
  $D4BC  C9                         UCMPGE
  $D4BD  D8 CB D4                   JUMPF_abs              $D4CB
  $D4C0  DE F4 FF                   LEAL_far               $FFF4
  $D4C3  B3                         PUSHL
  $D4C4  04                         LOADL_quick   ; inline operand = 4
  $D4C5  D2                         LSHIFT1
  $D4C6  B4                         POPR
  $D4C7  BB                         ADD
  $D4C8  B3                         PUSHL
  $D4C9  49                         LOADL_qimm   ; inline operand = 9
  $D4CA  B1                         POPSTORE
 >$D4CB  DE F4 FF                   LEAL_far               $FFF4
  $D4CE  B3                         PUSHL
  $D4CF  04                         LOADL_quick   ; inline operand = 4
  $D4D0  D2                         LSHIFT1
  $D4D1  B4                         POPR
  $D4D2  BB                         ADD
  $D4D3  B0                         DEREF
  $D4D4  B3                         PUSHL
  $D4D5  8E A4 F6                   PUSH_imm2              $F6A4
  $D4D8  D6 92 D4                   JUMP_abs               $D492
 >$D4DB  04                         LOADL_quick   ; inline operand = 4
  $D4DC  D8 60 D4                   JUMPF_abs              $D460
  $D4DF  60                         PUSH_qimm   ; inline operand = 0
  $D4E0  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $D4E4  8E A7 F6                   PUSH_imm2              $F6A7
  $D4E7  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $D4EB  42                         LOADL_qimm   ; inline operand = 2
  $D4EC  CD                         SWAP
  $D4ED  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $D4F0  BC                         SUB
  $D4F1  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $D4F4  61                         PUSH_qimm   ; inline operand = 1
  $D4F5  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $D4F9  DE F4 FF                   LEAL_far               $FFF4
  $D4FC  B3                         PUSHL
  $D4FD  04                         LOADL_quick   ; inline operand = 4
  $D4FE  D1                         DEC
  $D4FF  24                         STORE_quick   ; inline operand = 4
  $D500  D0                         INC
  $D501  D2                         LSHIFT1
  $D502  B4                         POPR
  $D503  BB                         ADD
  $D504  B3                         PUSHL
  $D505  8A FF 00                   LOADL_imm2             $00FF
  $D508  B1                         POPSTORE
 >$D509  62                         PUSH_qimm   ; inline operand = 2
  $D50A  E9 3E D7 02                CALL_abs_imm1          $D73E (delay_loop) {bytecode}, $02
  $D50E  D6 60 D4                   JUMP_abs               $D460
 >$D511  0C                         LOADL_quick   ; inline operand = 12
  $D512  D1                         DEC
  $D513  14                         LOADR_quick   ; inline operand = 4
  $D514  C1                         CMPNE
  $D515  D8 60 D4                   JUMPF_abs              $D460
  $D518  04                         LOADL_quick   ; inline operand = 4
  $D519  D7 28 D5                   JUMPT_abs              $D528
  $D51C  DE F4 FF                   LEAL_far               $FFF4
  $D51F  B3                         PUSHL
  $D520  04                         LOADL_quick   ; inline operand = 4
  $D521  D2                         LSHIFT1
  $D522  B4                         POPR
  $D523  BB                         ADD
  $D524  B0                         DEREF
  $D525  D8 60 D4                   JUMPF_abs              $D460
 >$D528  60                         PUSH_qimm   ; inline operand = 0
  $D529  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $D52D  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $D530  D0                         INC
  $D531  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $D534  DE F4 FF                   LEAL_far               $FFF4
  $D537  B3                         PUSHL
  $D538  04                         LOADL_quick   ; inline operand = 4
  $D539  D0                         INC
  $D53A  24                         STORE_quick   ; inline operand = 4
  $D53B  D2                         LSHIFT1
  $D53C  B4                         POPR
  $D53D  BB                         ADD
  $D53E  B3                         PUSHL
  $D53F  40                         LOADL_qimm   ; inline operand = 0
  $D540  B1                         POPSTORE
  $D541  DE F4 FF                   LEAL_far               $FFF4
  $D544  B3                         PUSHL
  $D545  04                         LOADL_quick   ; inline operand = 4
  $D546  D2                         LSHIFT1
  $D547  B4                         POPR
  $D548  BB                         ADD
  $D549  B0                         DEREF
  $D54A  B3                         PUSHL
  $D54B  8E A9 F6                   PUSH_imm2              $F6A9
  $D54E  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $D552  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $D555  D1                         DEC
  $D556  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $D559  61                         PUSH_qimm   ; inline operand = 1
  $D55A  E9 9D D2 02                CALL_abs_imm1          $D29D (read_frame_timer) {bytecode}, $02
  $D55E  D6 09 D5                   JUMP_abs               $D509
 >$D561  DE F4 FF                   LEAL_far               $FFF4
  $D564  B3                         PUSHL
  $D565  05                         LOADL_quick   ; inline operand = 5
  $D566  D2                         LSHIFT1
  $D567  B4                         POPR
  $D568  BB                         ADD
  $D569  B0                         DEREF
  $D56A  B3                         PUSHL
  $D56B  03                         LOADL_quick   ; inline operand = 3
  $D56C  5A                         LOADR_qimm   ; inline operand = 10
  $D56D  B5                         MULT
  $D56E  B4                         POPR
  $D56F  BB                         ADD
  $D570  23                         STORE_quick   ; inline operand = 3
  $D571  05                         LOADL_quick   ; inline operand = 5
  $D572  D0                         INC
 >$D573  25                         STORE_quick   ; inline operand = 5
  $D574  DE F4 FF                   LEAL_far               $FFF4
  $D577  B3                         PUSHL
  $D578  05                         LOADL_quick   ; inline operand = 5
  $D579  D2                         LSHIFT1
  $D57A  B4                         POPR
  $D57B  BB                         ADD
  $D57C  B0                         DEREF
  $D57D  8C FF 00                   LOADR_imm2             $00FF
  $D580  C1                         CMPNE
  $D581  D7 61 D5                   JUMPT_abs              $D561
  $D584  03                         LOADL_quick   ; inline operand = 3
  $D585  CF                         RETURN

; ============================================================
; sub $D586   (frame_off=-2, body @ $D58B)
; ============================================================
  $D58B  40                         LOADL_qimm   ; inline operand = 0
  $D58C  D6 96 D5                   JUMP_abs               $D596
 >$D58F  4A                         LOADL_qimm   ; inline operand = 10
  $D590  CD                         SWAP
  $D591  0C                         LOADL_quick   ; inline operand = 12
  $D592  B6                         SDIV
  $D593  2C                         STORE_quick   ; inline operand = 12
  $D594  0B                         LOADL_quick   ; inline operand = 11
  $D595  D0                         INC
 >$D596  2B                         STORE_quick   ; inline operand = 11
  $D597  0C                         LOADL_quick   ; inline operand = 12
  $D598  D7 8F D5                   JUMPT_abs              $D58F
  $D59B  0B                         LOADL_quick   ; inline operand = 11
  $D59C  CF                         RETURN

; ============================================================
; sub $D59D   (frame_off=-10, body @ $D5A2)
; ============================================================
  $D5A2  3D                         PUSH_quick   ; inline operand = 13
  $D5A3  E9 86 D5 02                CALL_abs_imm1          $D586 (count_div_iterations_d586) {bytecode}, $02
  $D5A7  2B                         STORE_quick   ; inline operand = 11
  $D5A8  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $D5AB  29                         STORE_quick   ; inline operand = 9
  $D5AC  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $D5AF  28                         STORE_quick   ; inline operand = 8
 >$D5B0  38                         PUSH_quick   ; inline operand = 8
  $D5B1  39                         PUSH_quick   ; inline operand = 9
  $D5B2  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $D5B6  40                         LOADL_qimm   ; inline operand = 0
  $D5B7  D6 C2 D5                   JUMP_abs               $D5C2
 >$D5BA  8D 20                      BYTE_PUSH_imm1         +32
  $D5BC  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $D5C0  0A                         LOADL_quick   ; inline operand = 10
  $D5C1  D0                         INC
 >$D5C2  2A                         STORE_quick   ; inline operand = 10
  $D5C3  0A                         LOADL_quick   ; inline operand = 10
  $D5C4  1B                         LOADR_quick   ; inline operand = 11
  $D5C5  C2                         SCMPLT
  $D5C6  D7 BA D5                   JUMPT_abs              $D5BA
  $D5C9  38                         PUSH_quick   ; inline operand = 8
  $D5CA  39                         PUSH_quick   ; inline operand = 9
  $D5CB  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $D5CF  3B                         PUSH_quick   ; inline operand = 11
  $D5D0  E9 ED D3 02                CALL_abs_imm1          $D3ED (cursor_nav_loop) {bytecode}, $02
  $D5D4  27                         STORE_quick   ; inline operand = 7
  $D5D5  07                         LOADL_quick   ; inline operand = 7
  $D5D6  50                         LOADR_qimm   ; inline operand = 0
  $D5D7  C3                         SCMPLE
  $D5D8  D7 E7 D5                   JUMPT_abs              $D5E7
  $D5DB  07                         LOADL_quick   ; inline operand = 7
  $D5DC  1C                         LOADR_quick   ; inline operand = 12
  $D5DD  C5                         SCMPGE
  $D5DE  D8 B0 D5                   JUMPF_abs              $D5B0
  $D5E1  07                         LOADL_quick   ; inline operand = 7
  $D5E2  1D                         LOADR_quick   ; inline operand = 13
  $D5E3  C3                         SCMPLE
  $D5E4  D8 B0 D5                   JUMPF_abs              $D5B0
 >$D5E7  07                         LOADL_quick   ; inline operand = 7
  $D5E8  CF                         RETURN

; ============================================================
; sub $D5E9   (frame_off=-2, body @ $D5EE)
; ============================================================
  $D5EE  3D                         PUSH_quick   ; inline operand = 13
  $D5EF  3C                         PUSH_quick   ; inline operand = 12
  $D5F0  8E AC F6                   PUSH_imm2              $F6AC (msg_d_d_f6ac)
  $D5F3  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
  $D5F7  3D                         PUSH_quick   ; inline operand = 13
  $D5F8  3C                         PUSH_quick   ; inline operand = 12
  $D5F9  E9 9D D5 04                CALL_abs_imm1          $D59D (select_province_by_cursor) {bytecode}, $04
  $D5FD  2B                         STORE_quick   ; inline operand = 11
  $D5FE  0B                         LOADL_quick   ; inline operand = 11
  $D5FF  50                         LOADR_qimm   ; inline operand = 0
  $D600  C4                         SCMPGT
  $D601  D8 07 D6                   JUMPF_abs              $D607
  $D604  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
 >$D607  0B                         LOADL_quick   ; inline operand = 11
  $D608  CF                         RETURN

; ============================================================
; sub $D609   (frame_off=-2, body @ $D60E)
; ============================================================
  $D60E  8D 1A                      BYTE_PUSH_imm1         +26
  $D610  62                         PUSH_qimm   ; inline operand = 2
  $D611  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $D615  8E B7 F6                   PUSH_imm2              $F6B7 (msg_hit_any_key_f6b7)
  $D618  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $D61C  AC 87 D2                   CALL_abs               $D287 (wait_button_edge) {bytecode}
  $D61F  2B                         STORE_quick   ; inline operand = 11
  $D620  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $D623  AC E1 CC                   CALL_abs               $CCE1 (ui_get_cursor_sel_7fdf) {bytecode}
  $D626  0B                         LOADL_quick   ; inline operand = 11
  $D627  CF                         RETURN

; ============================================================
; sub $D628   (frame_off=-4, body @ $D62D)
; ============================================================
  $D62D  40                         LOADL_qimm   ; inline operand = 0
  $D62E  2A                         STORE_quick   ; inline operand = 10
  $D62F  2B                         STORE_quick   ; inline operand = 11
  $D630  D6 4E D6                   JUMP_abs               $D64E
 >$D633  0A                         LOADL_quick   ; inline operand = 10
  $D634  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $D637  BB                         ADD
  $D638  D3                         BYTE_DEREF
  $D639  D7 48 D6                   JUMPT_abs              $D648
  $D63C  3A                         PUSH_quick   ; inline operand = 10
  $D63D  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $D641  8C FF 00                   LOADR_imm2             $00FF
  $D644  C0                         CMPEQ
  $D645  D8 4B D6                   JUMPF_abs              $D64B
 >$D648  0B                         LOADL_quick   ; inline operand = 11
  $D649  D0                         INC
  $D64A  2B                         STORE_quick   ; inline operand = 11
 >$D64B  0A                         LOADL_quick   ; inline operand = 10
  $D64C  D0                         INC
  $D64D  2A                         STORE_quick   ; inline operand = 10
 >$D64E  0A                         LOADL_quick   ; inline operand = 10
  $D64F  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $D652  C6                         UCMPLT
  $D653  D7 33 D6                   JUMPT_abs              $D633
  $D656  0B                         LOADL_quick   ; inline operand = 11
  $D657  51                         LOADR_qimm   ; inline operand = 1
  $D658  C0                         CMPEQ
  $D659  D8 6B D6                   JUMPF_abs              $D66B
  $D65C  AC 82 D9                   CALL_abs               $D982 (get_6e09) {bytecode}
  $D65F  D8 66 D6                   JUMPF_abs              $D666
  $D662  40                         LOADL_qimm   ; inline operand = 0
  $D663  D6 67 D6                   JUMP_abs               $D667
 >$D666  41                         LOADL_qimm   ; inline operand = 1
 >$D667  CD                         SWAP
  $D668  0B                         LOADL_quick   ; inline operand = 11
  $D669  DA                         AND
  $D66A  2B                         STORE_quick   ; inline operand = 11
 >$D66B  0B                         LOADL_quick   ; inline operand = 11
  $D66C  51                         LOADR_qimm   ; inline operand = 1
  $D66D  C1                         CMPNE
  $D66E  D8 75 D6                   JUMPF_abs              $D675
  $D671  40                         LOADL_qimm   ; inline operand = 0
  $D672  D6 76 D6                   JUMP_abs               $D676
 >$D675  41                         LOADL_qimm   ; inline operand = 1
 >$D676  CF                         RETURN

; ============================================================
; sub $D677   (frame_off=+0, body @ $D67C)
; ============================================================
  $D67C  AA 9F 6D                   PUSH_abs               $6D9F (current_game_year)
  $D67F  8E C4 F6                   PUSH_imm2              $F6C4
  $D682  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $D686  CF                         RETURN

; ============================================================
; sub $D687   (frame_off=+0, body @ $D68C)
; ============================================================
  $D68C  A4 5F 6D                   LOADL_abs              $6D5F (current_season)
  $D68F  D5 00 00 04 00 A5 D6 9E D6 A6 D6 AC ... SWITCH_contig          limit=4   ; .table 4 word targets (contiguous); SWITCH 0=>$D69E 1=>$D6A6 2=>$D6AC 3=>$D6B2 default=>$D6A5
 >$D69E  8E C7 F6                   PUSH_imm2              $F6C7
 >$D6A1  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$D6A5  CF                         RETURN
 >$D6A6  8E CE F6                   PUSH_imm2              $F6CE
  $D6A9  D6 A1 D6                   JUMP_abs               $D6A1
 >$D6AC  8E D5 F6                   PUSH_imm2              $F6D5
  $D6AF  D6 A1 D6                   JUMP_abs               $D6A1
 >$D6B2  8E DA F6                   PUSH_imm2              $F6DA
  $D6B5  D6 A1 D6                   JUMP_abs               $D6A1

; ============================================================
; sub $D6B8   (frame_off=+0, body @ $D6BD)
; ============================================================
  $D6BD  0E                         LOADL_quick   ; inline operand = 14
  $D6BE  D8 DB D6                   JUMPF_abs              $D6DB
  $D6C1  0E                         LOADL_quick   ; inline operand = 14
  $D6C2  B7 25                      LONG                   $25
  $D6C4  B7 14                      LONG                   $14
  $D6C6  0D                         LOADL_quick   ; inline operand = 13
  $D6C7  B7 25                      LONG                   $25
  $D6C9  B7 14                      LONG                   $14
  $D6CB  0C                         LOADL_quick   ; inline operand = 12
  $D6CC  B7 25                      LONG                   $25
  $D6CE  B7 15                      LONG                   $15
  $D6D0  B7 01                      LONG                   $01
  $D6D2  B7 15                      LONG                   $15
  $D6D4  B7 02                      LONG                   $02
  $D6D6  B7 27                      LONG                   $27
  $D6D8  D6 DD D6                   JUMP_abs               $D6DD
 >$D6DB  89 FF                      BYTE_LOADL_imm1        -1
 >$D6DD  CF                         RETURN

; ============================================================
; sub $D6DE   (frame_off=+0, body @ $D6E3)
; ============================================================
  $D6E3  0C                         LOADL_quick   ; inline operand = 12
  $D6E4  D7 ED D6                   JUMPT_abs              $D6ED
  $D6E7  0D                         LOADL_quick   ; inline operand = 13
  $D6E8  D7 ED D6                   JUMPT_abs              $D6ED
  $D6EB  40                         LOADL_qimm   ; inline operand = 0
  $D6EC  CF                         RETURN
 >$D6ED  0D                         LOADL_quick   ; inline operand = 13
  $D6EE  B7 26                      LONG                   $26
  $D6F0  B7 14                      LONG                   $14
  $D6F2  0C                         LOADL_quick   ; inline operand = 12
  $D6F3  B7 26                      LONG                   $26
  $D6F5  B7 15                      LONG                   $15
  $D6F7  B7 03                      LONG                   $03
  $D6F9  B7 14                      LONG                   $14
  $D6FB  0C                         LOADL_quick   ; inline operand = 12
  $D6FC  B7 26                      LONG                   $26
  $D6FE  B7 19 64 00 00 00          LONG                   $19 $64 $00 $00 $00
  $D704  B7 01                      LONG                   $01
  $D706  B7 15                      LONG                   $15
  $D708  B7 02                      LONG                   $02
  $D70A  B7 27                      LONG                   $27
  $D70C  CF                         RETURN

; ============================================================
; sub $D70D   (frame_off=+0, body @ $D712)
; ============================================================
  $D712  0D                         LOADL_quick   ; inline operand = 13
  $D713  8B 64                      BYTE_LOADR_imm1        +100
  $D715  C0                         CMPEQ
  $D716  D8 1B D7                   JUMPF_abs              $D71B
  $D719  0C                         LOADL_quick   ; inline operand = 12
  $D71A  CF                         RETURN
 >$D71B  0C                         LOADL_quick   ; inline operand = 12
  $D71C  5A                         LOADR_qimm   ; inline operand = 10
  $D71D  B6                         SDIV
  $D71E  B3                         PUSHL
  $D71F  0D                         LOADL_quick   ; inline operand = 13
  $D720  5A                         LOADR_qimm   ; inline operand = 10
  $D721  B6                         SDIV
  $D722  B4                         POPR
  $D723  B5                         MULT
  $D724  B3                         PUSHL
  $D725  0C                         LOADL_quick   ; inline operand = 12
  $D726  5A                         LOADR_qimm   ; inline operand = 10
  $D727  B9                         SMOD
  $D728  1D                         LOADR_quick   ; inline operand = 13
  $D729  B5                         MULT
  $D72A  8B 64                      BYTE_LOADR_imm1        +100
  $D72C  B6                         SDIV
  $D72D  B3                         PUSHL
  $D72E  0C                         LOADL_quick   ; inline operand = 12
  $D72F  5A                         LOADR_qimm   ; inline operand = 10
  $D730  B6                         SDIV
  $D731  B3                         PUSHL
  $D732  0D                         LOADL_quick   ; inline operand = 13
  $D733  5A                         LOADR_qimm   ; inline operand = 10
  $D734  B9                         SMOD
  $D735  B4                         POPR
  $D736  B5                         MULT
  $D737  5A                         LOADR_qimm   ; inline operand = 10
  $D738  B6                         SDIV
  $D739  B4                         POPR
  $D73A  BB                         ADD
  $D73B  B4                         POPR
  $D73C  BB                         ADD
  $D73D  CF                         RETURN

; ============================================================
; sub $D73E   (frame_off=-2, body @ $D743)
; ============================================================
  $D743  D6 51 D7                   JUMP_abs               $D751
 >$D746  8A F0 00                   LOADL_imm2             $00F0
  $D749  2B                         STORE_quick   ; inline operand = 11
 >$D74A  0B                         LOADL_quick   ; inline operand = 11
  $D74B  D1                         DEC
  $D74C  2B                         STORE_quick   ; inline operand = 11
  $D74D  0B                         LOADL_quick   ; inline operand = 11
  $D74E  D7 4A D7                   JUMPT_abs              $D74A
 >$D751  0C                         LOADL_quick   ; inline operand = 12
  $D752  D1                         DEC
  $D753  2C                         STORE_quick   ; inline operand = 12
  $D754  D0                         INC
  $D755  D7 46 D7                   JUMPT_abs              $D746
  $D758  CF                         RETURN

; ============================================================
; sub $D759   (frame_off=+0, body @ $D75E)
; ============================================================
  $D75E  AA 65 6D                   PUSH_abs               $6D65 (delay_loop_count)
  $D761  E9 3E D7 02                CALL_abs_imm1          $D73E (delay_loop) {bytecode}, $02
  $D765  CF                         RETURN

; ============================================================
; sub $D766   (frame_off=+0, body @ $D76B)
; ============================================================
  $D76B  AC 59 D7                   CALL_abs               $D759 (ui_helper_d759) {bytecode}
  $D76E  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $D771  CF                         RETURN

; ============================================================
; sub $D772   (frame_off=+0, body @ $D777)
; ============================================================
  $D777  0C                         LOADL_quick   ; inline operand = 12
  $D778  8C 15 6E                   LOADR_imm2             $6E15 (fief_to_daimyo_map)
  $D77B  BB                         ADD
  $D77C  D3                         BYTE_DEREF
  $D77D  CF                         RETURN

; ============================================================
; sub $D77E   (frame_off=+0, body @ $D783)
; ============================================================
  $D783  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $D786  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $D78A  CF                         RETURN

; ============================================================
; sub $D78B   (frame_off=-2, body @ $D790)
; ============================================================
  $D790  8E E1 F6                   PUSH_imm2              $F6E1 (msg_lord_f6e1)
  $D793  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $D797  3C                         PUSH_quick   ; inline operand = 12
  $D798  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $D79C  59                         LOADR_qimm   ; inline operand = 9
  $D79D  B5                         MULT
  $D79E  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $D7A1  BB                         ADD
  $D7A2  2B                         STORE_quick   ; inline operand = 11
  $D7A3  B3                         PUSHL
  $D7A4  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $D7A8  8D 2C                      BYTE_PUSH_imm1         +44
  $D7AA  E9 81 CE 02                CALL_abs_imm1          $CE81 (char_advance_width) {bytecode}, $02
  $D7AE  CF                         RETURN

; ============================================================
; sub $D7AF   (frame_off=-2, body @ $D7B4)
; ============================================================
  $D7B4  8E E7 F6                   PUSH_imm2              $F6E7 (msg_lord_f6e7)
  $D7B7  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $D7BB  3C                         PUSH_quick   ; inline operand = 12
  $D7BC  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $D7C0  59                         LOADR_qimm   ; inline operand = 9
  $D7C1  B5                         MULT
  $D7C2  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $D7C5  BB                         ADD
  $D7C6  2B                         STORE_quick   ; inline operand = 11
  $D7C7  B3                         PUSHL
  $D7C8  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $D7CC  CF                         RETURN

; ============================================================
; sub $D7CD   (frame_off=+0, body @ $D7D2)
; ============================================================
  $D7D2  0C                         LOADL_quick   ; inline operand = 12
  $D7D3  57                         LOADR_qimm   ; inline operand = 7
  $D7D4  B5                         MULT
  $D7D5  8C 2F 75                   LOADR_imm2             $752F (daimyo_table_17)
  $D7D8  BB                         ADD
  $D7D9  CF                         RETURN

; ============================================================
; sub $D7DA   (frame_off=+0, body @ $D7DF)
; ============================================================
  $D7DF  3C                         PUSH_quick   ; inline operand = 12
  $D7E0  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $D7E4  B3                         PUSHL
  $D7E5  E9 CD D7 02                CALL_abs_imm1          $D7CD (daimyo_record_addr) {bytecode}, $02
  $D7E9  CF                         RETURN

; ============================================================
; sub $D7EA   (frame_off=+0, body @ $D7EF)
; ============================================================
  $D7EF  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $D7F2  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $D7F6  CF                         RETURN

; ============================================================
; sub $D7F7   (frame_off=-2, body @ $D7FC)
; ============================================================
  $D7FC  0C                         LOADL_quick   ; inline operand = 12
  $D7FD  8B 1A                      BYTE_LOADR_imm1        +26
  $D7FF  B5                         MULT
  $D800  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $D803  BB                         ADD
  $D804  2B                         STORE_quick   ; inline operand = 11
  $D805  0B                         LOADL_quick   ; inline operand = 11
  $D806  78                         ADD_qimm   ; inline operand = 8
  $D807  B0                         DEREF
  $D808  D7 14 D8                   JUMPT_abs              $D814
  $D80B  0B                         LOADL_quick   ; inline operand = 11
  $D80C  7C                         ADD_qimm   ; inline operand = 12
  $D80D  B3                         PUSHL
  $D80E  0B                         LOADL_quick   ; inline operand = 11
  $D80F  7E                         ADD_qimm   ; inline operand = 14
  $D810  B3                         PUSHL
  $D811  40                         LOADL_qimm   ; inline operand = 0
  $D812  B1                         POPSTORE
  $D813  B1                         POPSTORE
 >$D814  CF                         RETURN

; ============================================================
; sub $D815   (frame_off=-4, body @ $D81A)
; ============================================================
  $D81A  0C                         LOADL_quick   ; inline operand = 12
  $D81B  8B 1A                      BYTE_LOADR_imm1        +26
  $D81D  B5                         MULT
  $D81E  8C 11 70                   LOADR_imm2             $7011
  $D821  BB                         ADD
  $D822  2B                         STORE_quick   ; inline operand = 11
  $D823  0B                         LOADL_quick   ; inline operand = 11
  $D824  B0                         DEREF
  $D825  D7 35 D8                   JUMPT_abs              $D835
  $D828  0B                         LOADL_quick   ; inline operand = 11
  $D829  72                         ADD_qimm   ; inline operand = 2
  $D82A  B3                         PUSHL
  $D82B  0B                         LOADL_quick   ; inline operand = 11
  $D82C  74                         ADD_qimm   ; inline operand = 4
  $D82D  B3                         PUSHL
  $D82E  0B                         LOADL_quick   ; inline operand = 11
  $D82F  76                         ADD_qimm   ; inline operand = 6
  $D830  B3                         PUSHL
  $D831  40                         LOADL_qimm   ; inline operand = 0
  $D832  B1                         POPSTORE
  $D833  B1                         POPSTORE
  $D834  B1                         POPSTORE
 >$D835  CF                         RETURN

; ============================================================
; sub $D836   (frame_off=-12, body @ $D83B)
; ============================================================
  $D83B  0C                         LOADL_quick   ; inline operand = 12
  $D83C  8B 1A                      BYTE_LOADR_imm1        +26
  $D83E  B5                         MULT
  $D83F  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $D842  BB                         ADD
  $D843  27                         STORE_quick   ; inline operand = 7
  $D844  07                         LOADL_quick   ; inline operand = 7
  $D845  2A                         STORE_quick   ; inline operand = 10
  $D846  D6 63 D8                   JUMP_abs               $D863
 >$D849  3B                         PUSH_quick   ; inline operand = 11
  $D84A  07                         LOADL_quick   ; inline operand = 7
  $D84B  8F 18                      BYTE_ADD_imm1          +24
  $D84D  B0                         DEREF
  $D84E  B3                         PUSHL
  $D84F  0B                         LOADL_quick   ; inline operand = 11
  $D850  B0                         DEREF
  $D851  B3                         PUSHL
  $D852  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $D856  B1                         POPSTORE
  $D857  0B                         LOADL_quick   ; inline operand = 11
  $D858  B0                         DEREF
  $D859  50                         LOADR_qimm   ; inline operand = 0
  $D85A  C2                         SCMPLT
  $D85B  D8 61 D8                   JUMPF_abs              $D861
  $D85E  3B                         PUSH_quick   ; inline operand = 11
  $D85F  40                         LOADL_qimm   ; inline operand = 0
  $D860  B1                         POPSTORE
 >$D861  0B                         LOADL_quick   ; inline operand = 11
  $D862  72                         ADD_qimm   ; inline operand = 2
 >$D863  2B                         STORE_quick   ; inline operand = 11
  $D864  0A                         LOADL_quick   ; inline operand = 10
  $D865  8F 18                      BYTE_ADD_imm1          +24
  $D867  B3                         PUSHL
  $D868  0B                         LOADL_quick   ; inline operand = 11
  $D869  B4                         POPR
  $D86A  C6                         UCMPLT
  $D86B  D7 49 D8                   JUMPT_abs              $D849
  $D86E  07                         LOADL_quick   ; inline operand = 7
  $D86F  7A                         ADD_qimm   ; inline operand = 10
  $D870  B3                         PUSHL
  $D871  8D 64                      BYTE_PUSH_imm1         +100
  $D873  07                         LOADL_quick   ; inline operand = 7
  $D874  7A                         ADD_qimm   ; inline operand = 10
  $D875  B0                         DEREF
  $D876  B3                         PUSHL
  $D877  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $D87B  B1                         POPSTORE
  $D87C  40                         LOADL_qimm   ; inline operand = 0
  $D87D  29                         STORE_quick   ; inline operand = 9
  $D87E  3C                         PUSH_quick   ; inline operand = 12
  $D87F  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $D883  26                         STORE_quick   ; inline operand = 6
  $D884  28                         STORE_quick   ; inline operand = 8
  $D885  D6 A9 D8                   JUMP_abs               $D8A9
 >$D888  08                         LOADL_quick   ; inline operand = 8
  $D889  D3                         BYTE_DEREF
  $D88A  8C EB 00                   LOADR_imm2             $00EB
  $D88D  C4                         SCMPGT
  $D88E  D8 94 D8                   JUMPF_abs              $D894
  $D891  38                         PUSH_quick   ; inline operand = 8
  $D892  40                         LOADL_qimm   ; inline operand = 0
  $D893  D4                         BYTE_POPSTORE
 >$D894  08                         LOADL_quick   ; inline operand = 8
  $D895  D3                         BYTE_DEREF
  $D896  8C D2 00                   LOADR_imm2             $00D2
  $D899  C4                         SCMPGT
  $D89A  D8 A1 D8                   JUMPF_abs              $D8A1
  $D89D  38                         PUSH_quick   ; inline operand = 8
  $D89E  89 D2                      BYTE_LOADL_imm1        -46
  $D8A0  D4                         BYTE_POPSTORE
 >$D8A1  08                         LOADL_quick   ; inline operand = 8
  $D8A2  D0                         INC
  $D8A3  28                         STORE_quick   ; inline operand = 8
  $D8A4  D1                         DEC
  $D8A5  09                         LOADL_quick   ; inline operand = 9
  $D8A6  D0                         INC
  $D8A7  29                         STORE_quick   ; inline operand = 9
  $D8A8  D1                         DEC
 >$D8A9  09                         LOADL_quick   ; inline operand = 9
  $D8AA  56                         LOADR_qimm   ; inline operand = 6
  $D8AB  C6                         UCMPLT
  $D8AC  D7 88 D8                   JUMPT_abs              $D888
  $D8AF  3C                         PUSH_quick   ; inline operand = 12
  $D8B0  E9 15 D8 02                CALL_abs_imm1          $D815 (province_clear_fields_d815) {bytecode}, $02
  $D8B4  3C                         PUSH_quick   ; inline operand = 12
  $D8B5  E9 F7 D7 02                CALL_abs_imm1          $D7F7 (province_clear_fields_d7f7) {bytecode}, $02
  $D8B9  CF                         RETURN

; ============================================================
; sub $D8BA   (frame_off=-4, body @ $D8BF)
; ============================================================
  $D8BF  0C                         LOADL_quick   ; inline operand = 12
  $D8C0  51                         LOADR_qimm   ; inline operand = 1
  $D8C1  C2                         SCMPLT
  $D8C2  D8 C7 D8                   JUMPF_abs              $D8C7
  $D8C5  40                         LOADL_qimm   ; inline operand = 0
  $D8C6  CF                         RETURN
 >$D8C7  3C                         PUSH_quick   ; inline operand = 12
  $D8C8  E9 CD CB 02                CALL_abs_imm1          $CBCD (sqrt_int) {native}, $02
  $D8CC  B3                         PUSHL
  $D8CD  0E                         LOADL_quick   ; inline operand = 14
  $D8CE  B0                         DEREF
  $D8CF  B3                         PUSHL
  $D8D0  0D                         LOADL_quick   ; inline operand = 13
  $D8D1  B0                         DEREF
  $D8D2  B4                         POPR
  $D8D3  BB                         ADD
  $D8D4  52                         LOADR_qimm   ; inline operand = 2
  $D8D5  B6                         SDIV
  $D8D6  B3                         PUSHL
  $D8D7  E9 CD CB 02                CALL_abs_imm1          $CBCD (sqrt_int) {native}, $02
  $D8DB  B4                         POPR
  $D8DC  BB                         ADD
  $D8DD  B3                         PUSHL
  $D8DE  46                         LOADL_qimm   ; inline operand = 6
  $D8DF  A6 63 6D                   LOADR_abs              $6D63 (const_two)
  $D8E2  BC                         SUB
  $D8E3  B3                         PUSHL
  $D8E4  3C                         PUSH_quick   ; inline operand = 12
  $D8E5  E9 B8 D6 06                CALL_abs_imm1          $D6B8 (math32_3arg) {bytecode}, $06
  $D8E9  2B                         STORE_quick   ; inline operand = 11
  $D8EA  0B                         LOADL_quick   ; inline operand = 11
  $D8EB  D7 F0 D8                   JUMPT_abs              $D8F0
  $D8EE  41                         LOADL_qimm   ; inline operand = 1
  $D8EF  CF                         RETURN
 >$D8F0  0B                         LOADL_quick   ; inline operand = 11
  $D8F1  CF                         RETURN

; ============================================================
; sub $D8F2   (frame_off=-4, body @ $D8F7)
; ============================================================
  $D8F7  0C                         LOADL_quick   ; inline operand = 12
  $D8F8  78                         ADD_qimm   ; inline operand = 8
  $D8F9  B3                         PUSHL
  $D8FA  0C                         LOADL_quick   ; inline operand = 12
  $D8FB  7C                         ADD_qimm   ; inline operand = 12
  $D8FC  B3                         PUSHL
  $D8FD  3D                         PUSH_quick   ; inline operand = 13
  $D8FE  E9 BA D8 06                CALL_abs_imm1          $D8BA (develop_gain) {bytecode}, $06
  $D902  2B                         STORE_quick   ; inline operand = 11
  $D903  0C                         LOADL_quick   ; inline operand = 12
  $D904  7C                         ADD_qimm   ; inline operand = 12
  $D905  B0                         DEREF
  $D906  B3                         PUSHL
  $D907  0C                         LOADL_quick   ; inline operand = 12
  $D908  8F 18                      BYTE_ADD_imm1          +24
  $D90A  B0                         DEREF
  $D90B  B4                         POPR
  $D90C  BC                         SUB
  $D90D  2A                         STORE_quick   ; inline operand = 10
  $D90E  B3                         PUSHL
  $D90F  0B                         LOADL_quick   ; inline operand = 11
  $D910  B4                         POPR
  $D911  C4                         SCMPGT
  $D912  D8 17 D9                   JUMPF_abs              $D917
  $D915  0A                         LOADL_quick   ; inline operand = 10
  $D916  CF                         RETURN
 >$D917  0B                         LOADL_quick   ; inline operand = 11
  $D918  CF                         RETURN

; ============================================================
; sub $D919   (frame_off=-4, body @ $D91E)
; ============================================================
  $D91E  0C                         LOADL_quick   ; inline operand = 12
  $D91F  74                         ADD_qimm   ; inline operand = 4
  $D920  B3                         PUSHL
  $D921  0C                         LOADL_quick   ; inline operand = 12
  $D922  7E                         ADD_qimm   ; inline operand = 14
  $D923  B3                         PUSHL
  $D924  3D                         PUSH_quick   ; inline operand = 13
  $D925  E9 BA D8 06                CALL_abs_imm1          $D8BA (develop_gain) {bytecode}, $06
  $D929  2B                         STORE_quick   ; inline operand = 11
  $D92A  0C                         LOADL_quick   ; inline operand = 12
  $D92B  7E                         ADD_qimm   ; inline operand = 14
  $D92C  B0                         DEREF
  $D92D  B3                         PUSHL
  $D92E  0C                         LOADL_quick   ; inline operand = 12
  $D92F  8F 18                      BYTE_ADD_imm1          +24
  $D931  B0                         DEREF
  $D932  B4                         POPR
  $D933  BC                         SUB
  $D934  2A                         STORE_quick   ; inline operand = 10
  $D935  B3                         PUSHL
  $D936  0B                         LOADL_quick   ; inline operand = 11
  $D937  B4                         POPR
  $D938  C4                         SCMPGT
  $D939  D8 3E D9                   JUMPF_abs              $D93E
  $D93C  0A                         LOADL_quick   ; inline operand = 10
  $D93D  CF                         RETURN
 >$D93E  0B                         LOADL_quick   ; inline operand = 11
  $D93F  CF                         RETURN

; ============================================================
; sub $D940   (frame_off=+0, body @ $D945)
; ============================================================
  $D945  3D                         PUSH_quick   ; inline operand = 13
  $D946  3C                         PUSH_quick   ; inline operand = 12
  $D947  E9 F2 D8 04                CALL_abs_imm1          $D8F2 (record_grow_capped_d8f2) {bytecode}, $04
  $D94B  B3                         PUSHL
  $D94C  0C                         LOADL_quick   ; inline operand = 12
  $D94D  7C                         ADD_qimm   ; inline operand = 12
  $D94E  B4                         POPR
  $D94F  B3                         PUSHL
  $D950  B0                         DEREF
  $D951  BB                         ADD
  $D952  B1                         POPSTORE
  $D953  3D                         PUSH_quick   ; inline operand = 13
  $D954  3C                         PUSH_quick   ; inline operand = 12
  $D955  E9 19 D9 04                CALL_abs_imm1          $D919 (record_grow_capped_d919) {bytecode}, $04
  $D959  B3                         PUSHL
  $D95A  0C                         LOADL_quick   ; inline operand = 12
  $D95B  7E                         ADD_qimm   ; inline operand = 14
  $D95C  B4                         POPR
  $D95D  B3                         PUSHL
  $D95E  B0                         DEREF
  $D95F  BB                         ADD
  $D960  B1                         POPSTORE
  $D961  CF                         RETURN

; ============================================================
; sub $D962   (frame_off=+0, body @ $D967)
; ============================================================
  $D967  89 80                      BYTE_LOADL_imm1        -128
  $D969  CD                         SWAP
  $D96A  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $D96D  DB                         OR
  $D96E  A9 A1 6D                   BYTE_STORE_abs         $6DA1 (ai_turn_flags)
  $D971  CF                         RETURN

; ============================================================
; sub $D972   (frame_off=+0, body @ $D977)
; ============================================================
  $D977  3C                         PUSH_quick   ; inline operand = 12
  $D978  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $D97C  8C D4 6D                   LOADR_imm2             $6DD4 (daimyo_weakness_flag)
  $D97F  BB                         ADD
  $D980  D3                         BYTE_DEREF
  $D981  CF                         RETURN

; ============================================================
; sub $D982   (frame_off=+0, body @ $D987)
; ============================================================
  $D987  A4 09 6E                   LOADL_abs              $6E09 (ai_player_count)
  $D98A  58                         LOADR_qimm   ; inline operand = 8
  $D98B  C9                         UCMPGE
  $D98C  CF                         RETURN

; ============================================================
; sub $D98D   (frame_off=+0, body @ $D992)
; ============================================================
  $D992  0C                         LOADL_quick   ; inline operand = 12
  $D993  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $D996  BB                         ADD
  $D997  D3                         BYTE_DEREF
  $D998  CF                         RETURN

; ============================================================
; sub $D999   (frame_off=+0, body @ $D99E)
; ============================================================
  $D99E  0C                         LOADL_quick   ; inline operand = 12
  $D99F  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $D9A2  BB                         ADD
  $D9A3  D3                         BYTE_DEREF
  $D9A4  8C FF 00                   LOADR_imm2             $00FF
  $D9A7  C0                         CMPEQ
  $D9A8  CF                         RETURN

; ============================================================
; sub $D9A9   (frame_off=+0, body @ $D9AE)
; ============================================================
  $D9AE  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $D9B1  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $D9B4  BB                         ADD
  $D9B5  D3                         BYTE_DEREF
  $D9B6  CF                         RETURN

; ============================================================
; sub $D9B7   (frame_off=+0, body @ $D9BC)
; ============================================================
  $D9BC  AC 7E D7                   CALL_abs               $D77E (ui_helper_d77e) {bytecode}
  $D9BF  B3                         PUSHL
  $D9C0  3C                         PUSH_quick   ; inline operand = 12
  $D9C1  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $D9C5  B4                         POPR
  $D9C6  C0                         CMPEQ
  $D9C7  CF                         RETURN

; ============================================================
; sub $D9C8   (frame_off=+0, body @ $D9CD)
; ============================================================
  $D9CD  0C                         LOADL_quick   ; inline operand = 12
  $D9CE  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $D9D1  BB                         ADD
  $D9D2  CF                         RETURN

; ============================================================
; sub $D9D3   (frame_off=+0, body @ $D9D8)
; ============================================================
  $D9D8  0C                         LOADL_quick   ; inline operand = 12
  $D9D9  5A                         LOADR_qimm   ; inline operand = 10
  $D9DA  B5                         MULT
  $D9DB  8C 85 79                   LOADR_imm2             $7985
  $D9DE  BB                         ADD
  $D9DF  B3                         PUSHL
  $D9E0  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $D9E4  CF                         RETURN

; ============================================================
; sub $D9E5   (frame_off=+0, body @ $D9EA)
; ============================================================
  $D9EA  0C                         LOADL_quick   ; inline operand = 12
  $D9EB  8C 65 6F                   LOADR_imm2             $6F65 (war_side_state_flag)
  $D9EE  BB                         ADD
  $D9EF  D3                         BYTE_DEREF
  $D9F0  8C 80 00                   LOADR_imm2             $0080 (skip_vblank_wait)
  $D9F3  DA                         AND
  $D9F4  50                         LOADR_qimm   ; inline operand = 0
  $D9F5  C1                         CMPNE
  $D9F6  CF                         RETURN

; ============================================================
; sub $D9F7   (frame_off=-2, body @ $D9FC)
; ============================================================
  $D9FC  0C                         LOADL_quick   ; inline operand = 12
  $D9FD  8C 79 7B                   LOADR_imm2             $7B79
  $DA00  BB                         ADD
  $DA01  D3                         BYTE_DEREF
  $DA02  56                         LOADR_qimm   ; inline operand = 6
  $DA03  C0                         CMPEQ
  $DA04  D8 0D DA                   JUMPF_abs              $DA0D
  $DA07  8A ED F6                   LOADL_imm2             $F6ED (msg_pirates_f6ed)
  $DA0A  D6 21 DA                   JUMP_abs               $DA21
 >$DA0D  0C                         LOADL_quick   ; inline operand = 12
  $DA0E  8C 79 7B                   LOADR_imm2             $7B79
  $DA11  BB                         ADD
  $DA12  D3                         BYTE_DEREF
  $DA13  57                         LOADR_qimm   ; inline operand = 7
  $DA14  C0                         CMPEQ
  $DA15  D8 1E DA                   JUMPF_abs              $DA1E
  $DA18  8A F5 F6                   LOADL_imm2             $F6F5 (msg_christns_f6f5)
  $DA1B  D6 21 DA                   JUMP_abs               $DA21
 >$DA1E  8A FE F6                   LOADL_imm2             $F6FE (msg_rioters_f6fe)
 >$DA21  2B                         STORE_quick   ; inline operand = 11
  $DA22  0B                         LOADL_quick   ; inline operand = 11
  $DA23  CF                         RETURN

; ============================================================
; sub $DA24   (frame_off=+0, body @ $DA29)
; ============================================================
  $DA29  87 13                      PUSH_near              $13
  $DA2B  3F                         PUSH_quick   ; inline operand = 15
  $DA2C  3E                         PUSH_quick   ; inline operand = 14
  $DA2D  E9 DE D6 04                CALL_abs_imm1          $D6DE (math32_2arg) {bytecode}, $04
  $DA31  B3                         PUSHL
  $DA32  0D                         LOADL_quick   ; inline operand = 13
  $DA33  51                         LOADR_qimm   ; inline operand = 1
  $DA34  DB                         OR
  $DA35  B3                         PUSHL
  $DA36  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $DA3A  B3                         PUSHL
  $DA3B  3E                         PUSH_quick   ; inline operand = 14
  $DA3C  3F                         PUSH_quick   ; inline operand = 15
  $DA3D  E9 DE D6 04                CALL_abs_imm1          $D6DE (math32_2arg) {bytecode}, $04
  $DA41  B3                         PUSHL
  $DA42  3C                         PUSH_quick   ; inline operand = 12
  $DA43  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $DA47  B4                         POPR
  $DA48  BB                         ADD
  $DA49  B3                         PUSHL
  $DA4A  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $DA4E  CF                         RETURN

; ============================================================
; sub $DA4F   (frame_off=+0, body @ $DA54)
; ============================================================
  $DA54  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $DA57  A6 63 6F                   LOADR_abs              $6F63 (battle_defending_province)
  $DA5A  C6                         UCMPLT
  $DA5B  D8 6A DA                   JUMPF_abs              $DA6A
  $DA5E  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $DA61  8B 36                      BYTE_LOADR_imm1        +54
  $DA63  B5                         MULT
  $DA64  A6 63 6F                   LOADR_abs              $6F63 (battle_defending_province)
  $DA67  D6 73 DA                   JUMP_abs               $DA73
 >$DA6A  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $DA6D  8B 36                      BYTE_LOADR_imm1        +54
  $DA6F  B5                         MULT
  $DA70  A6 5F 6F                   LOADR_abs              $6F5F (selected_province_idx)
 >$DA73  BB                         ADD
  $DA74  8C 93 61                   LOADR_imm2             $6193
  $DA77  BB                         ADD
  $DA78  B3                         PUSHL
  $DA79  89 46                      BYTE_LOADL_imm1        +70
  $DA7B  D4                         BYTE_POPSTORE
  $DA7C  CF                         RETURN

; ============================================================
; sub $DA7D   (frame_off=-4, body @ $DA82)
; ============================================================
  $DA82  AC 7E D7                   CALL_abs               $D77E (ui_helper_d77e) {bytecode}
  $DA85  2B                         STORE_quick   ; inline operand = 11
  $DA86  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $DA89  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $DA8D  2A                         STORE_quick   ; inline operand = 10
  $DA8E  0B                         LOADL_quick   ; inline operand = 11
  $DA8F  1A                         LOADR_quick   ; inline operand = 10
  $DA90  C6                         UCMPLT
  $DA91  D8 9C DA                   JUMPF_abs              $DA9C
  $DA94  0A                         LOADL_quick   ; inline operand = 10
  $DA95  8B 36                      BYTE_LOADR_imm1        +54
  $DA97  B5                         MULT
  $DA98  1B                         LOADR_quick   ; inline operand = 11
  $DA99  D6 A1 DA                   JUMP_abs               $DAA1
 >$DA9C  0B                         LOADL_quick   ; inline operand = 11
  $DA9D  8B 36                      BYTE_LOADR_imm1        +54
  $DA9F  B5                         MULT
  $DAA0  1A                         LOADR_quick   ; inline operand = 10
 >$DAA1  BB                         ADD
  $DAA2  8C 93 61                   LOADR_imm2             $6193
  $DAA5  BB                         ADD
  $DAA6  B3                         PUSHL
  $DAA7  89 5A                      BYTE_LOADL_imm1        +90
  $DAA9  D4                         BYTE_POPSTORE
  $DAAA  CF                         RETURN

; ============================================================
; sub $DAAB   (frame_off=+0, body @ $DAB0)
; ============================================================
  $DAB0  68                         PUSH_qimm   ; inline operand = 8
  $DAB1  8E 4F 6F                   PUSH_imm2              $6F4F (deduped_owner_list)
  $DAB4  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $DAB7  8B 11                      BYTE_LOADR_imm1        +17
  $DAB9  C0                         CMPEQ
  $DABA  D8 C6 DA                   JUMPF_abs              $DAC6
  $DABD  0C                         LOADL_quick   ; inline operand = 12
  $DABE  53                         LOADR_qimm   ; inline operand = 3
  $DABF  BD                         LSHIFT
  $DAC0  8C 00 83                   LOADR_imm2             $8300 (relation_base_data_8300)
  $DAC3  D6 CC DA                   JUMP_abs               $DACC
 >$DAC6  0C                         LOADL_quick   ; inline operand = 12
  $DAC7  53                         LOADR_qimm   ; inline operand = 3
  $DAC8  BD                         LSHIFT
  $DAC9  8C 04 80                   LOADR_imm2             $8004 (relation_base_data_8004)
 >$DACC  BB                         ADD
  $DACD  B3                         PUSHL
  $DACE  64                         PUSH_qimm   ; inline operand = 4
  $DACF  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $DAD3  8A 4F 6F                   LOADL_imm2             $6F4F (deduped_owner_list)
  $DAD6  CF                         RETURN

; ============================================================
; sub $DAD7   (frame_off=-4, body @ $DADC)
; ============================================================
  $DADC  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $DADF  E9 AB DA 02                CALL_abs_imm1          $DAAB (relation_base_6f4f) {bytecode}, $02
  $DAE3  8A 4F 6F                   LOADL_imm2             $6F4F (deduped_owner_list)
  $DAE6  2A                         STORE_quick   ; inline operand = 10
  $DAE7  2B                         STORE_quick   ; inline operand = 11
  $DAE8  D6 04 DB                   JUMP_abs               $DB04
 >$DAEB  0A                         LOADL_quick   ; inline operand = 10
  $DAEC  D3                         BYTE_DEREF
  $DAED  B3                         PUSHL
  $DAEE  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $DAF2  8C FF 00                   LOADR_imm2             $00FF
  $DAF5  C1                         CMPNE
  $DAF6  D8 01 DB                   JUMPF_abs              $DB01
  $DAF9  0B                         LOADL_quick   ; inline operand = 11
  $DAFA  D0                         INC
  $DAFB  2B                         STORE_quick   ; inline operand = 11
  $DAFC  D1                         DEC
  $DAFD  B3                         PUSHL
  $DAFE  0A                         LOADL_quick   ; inline operand = 10
  $DAFF  D3                         BYTE_DEREF
  $DB00  D4                         BYTE_POPSTORE
 >$DB01  0A                         LOADL_quick   ; inline operand = 10
  $DB02  D0                         INC
  $DB03  2A                         STORE_quick   ; inline operand = 10
 >$DB04  0A                         LOADL_quick   ; inline operand = 10
  $DB05  D3                         BYTE_DEREF
  $DB06  8C FF 00                   LOADR_imm2             $00FF
  $DB09  C1                         CMPNE
  $DB0A  D7 EB DA                   JUMPT_abs              $DAEB
  $DB0D  3B                         PUSH_quick   ; inline operand = 11
  $DB0E  89 FF                      BYTE_LOADL_imm1        -1
  $DB10  D4                         BYTE_POPSTORE
  $DB11  CF                         RETURN

; ============================================================
; sub $DB12   (frame_off=+0, body @ $DB17)
; ============================================================
  $DB17  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $DB1A  8B 11                      BYTE_LOADR_imm1        +17
  $DB1C  C0                         CMPEQ
  $DB1D  D8 2A DB                   JUMPF_abs              $DB2A
  $DB20  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $DB23  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $DB27  53                         LOADR_qimm   ; inline operand = 3
  $DB28  C0                         CMPEQ
  $DB29  CF                         RETURN
 >$DB2A  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $DB2D  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $DB31  8B 14                      BYTE_LOADR_imm1        +20
  $DB33  C0                         CMPEQ
  $DB34  CF                         RETURN

; ============================================================
; sub $DB35   (frame_off=+0, body @ $DB3A)
; ============================================================
  $DB3A  A4 09 6E                   LOADL_abs              $6E09 (ai_player_count)
  $DB3D  D0                         INC
  $DB3E  A8 09 6E                   STORE_abs              $6E09 (ai_player_count)
  $DB41  AC 82 D9                   CALL_abs               $D982 (get_6e09) {bytecode}
  $DB44  D8 4A DB                   JUMPF_abs              $DB4A
  $DB47  AC 62 D9                   CALL_abs               $D962 (set_6da1_bit7) {bytecode}
 >$DB4A  CF                         RETURN

; ============================================================
; sub $DB4B   (frame_off=+0, body @ $DB50)
; ============================================================
  $DB50  0C                         LOADL_quick   ; inline operand = 12
  $DB51  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $DB54  BB                         ADD
  $DB55  D3                         BYTE_DEREF
  $DB56  8C FF 00                   LOADR_imm2             $00FF
  $DB59  C1                         CMPNE
  $DB5A  D8 6D DB                   JUMPF_abs              $DB6D
  $DB5D  3C                         PUSH_quick   ; inline operand = 12
  $DB5E  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $DB62  59                         LOADR_qimm   ; inline operand = 9
  $DB63  B5                         MULT
  $DB64  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $DB67  BB                         ADD
  $DB68  B3                         PUSHL
  $DB69  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
 >$DB6D  CF                         RETURN

; ============================================================
; sub $DB6E   (frame_off=+0, body @ $DB73)
; ============================================================
  $DB73  0C                         LOADL_quick   ; inline operand = 12
  $DB74  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $DB77  BB                         ADD
  $DB78  D3                         BYTE_DEREF
  $DB79  8C FF 00                   LOADR_imm2             $00FF
  $DB7C  C1                         CMPNE
  $DB7D  D8 8F DB                   JUMPF_abs              $DB8F
  $DB80  3C                         PUSH_quick   ; inline operand = 12
  $DB81  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $DB85  59                         LOADR_qimm   ; inline operand = 9
  $DB86  B5                         MULT
  $DB87  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $DB8A  BB                         ADD
  $DB8B  B3                         PUSHL
  $DB8C  D6 92 DB                   JUMP_abs               $DB92
 >$DB8F  8E 06 F7                   PUSH_imm2              $F706 (msg_no_lord)
 >$DB92  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $DB96  CF                         RETURN

; ============================================================
; sub $DB97   (frame_off=-8, body @ $DB9C)
; ============================================================
  $DB9C  3C                         PUSH_quick   ; inline operand = 12
  $DB9D  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $DBA1  76                         ADD_qimm   ; inline operand = 6
  $DBA2  B3                         PUSHL
  $DBA3  41                         LOADL_qimm   ; inline operand = 1
  $DBA4  D4                         BYTE_POPSTORE
  $DBA5  40                         LOADL_qimm   ; inline operand = 0
  $DBA6  28                         STORE_quick   ; inline operand = 8
 >$DBA7  65                         PUSH_qimm   ; inline operand = 5
  $DBA8  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $DBAC  B3                         PUSHL
  $DBAD  65                         PUSH_qimm   ; inline operand = 5
  $DBAE  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $DBB2  55                         LOADR_qimm   ; inline operand = 5
  $DBB3  B5                         MULT
  $DBB4  B3                         PUSHL
  $DBB5  65                         PUSH_qimm   ; inline operand = 5
  $DBB6  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $DBBA  8B 19                      BYTE_LOADR_imm1        +25
  $DBBC  B5                         MULT
  $DBBD  B3                         PUSHL
  $DBBE  65                         PUSH_qimm   ; inline operand = 5
  $DBBF  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $DBC3  8B 7D                      BYTE_LOADR_imm1        +125
  $DBC5  B5                         MULT
  $DBC6  B4                         POPR
  $DBC7  BB                         ADD
  $DBC8  B4                         POPR
  $DBC9  BB                         ADD
  $DBCA  B4                         POPR
  $DBCB  BB                         ADD
  $DBCC  2A                         STORE_quick   ; inline operand = 10
  $DBCD  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $DBD0  8B 32                      BYTE_LOADR_imm1        +50
  $DBD2  C0                         CMPEQ
  $DBD3  D8 DB DB                   JUMPF_abs              $DBDB
  $DBD6  89 35                      BYTE_LOADL_imm1        +53
  $DBD8  D6 DD DB                   JUMP_abs               $DBDD
 >$DBDB  89 11                      BYTE_LOADL_imm1        +17
 >$DBDD  29                         STORE_quick   ; inline operand = 9
  $DBDE  40                         LOADL_qimm   ; inline operand = 0
  $DBDF  2B                         STORE_quick   ; inline operand = 11
  $DBE0  41                         LOADL_qimm   ; inline operand = 1
  $DBE1  28                         STORE_quick   ; inline operand = 8
  $DBE2  D6 F6 DB                   JUMP_abs               $DBF6
 >$DBE5  0B                         LOADL_quick   ; inline operand = 11
  $DBE6  D2                         LSHIFT1
  $DBE7  8C B1 6E                   LOADR_imm2             $6EB1 (daimyo_face_code_table)
  $DBEA  BB                         ADD
  $DBEB  B0                         DEREF
  $DBEC  1A                         LOADR_quick   ; inline operand = 10
  $DBED  C0                         CMPEQ
  $DBEE  D8 F3 DB                   JUMPF_abs              $DBF3
  $DBF1  40                         LOADL_qimm   ; inline operand = 0
  $DBF2  28                         STORE_quick   ; inline operand = 8
 >$DBF3  0B                         LOADL_quick   ; inline operand = 11
  $DBF4  D0                         INC
  $DBF5  2B                         STORE_quick   ; inline operand = 11
 >$DBF6  0B                         LOADL_quick   ; inline operand = 11
  $DBF7  19                         LOADR_quick   ; inline operand = 9
  $DBF8  C6                         UCMPLT
  $DBF9  D7 E5 DB                   JUMPT_abs              $DBE5
  $DBFC  08                         LOADL_quick   ; inline operand = 8
  $DBFD  D8 A7 DB                   JUMPF_abs              $DBA7
  $DC00  3C                         PUSH_quick   ; inline operand = 12
  $DC01  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $DC05  D2                         LSHIFT1
  $DC06  8C B1 6E                   LOADR_imm2             $6EB1 (daimyo_face_code_table)
  $DC09  BB                         ADD
  $DC0A  B3                         PUSHL
  $DC0B  0A                         LOADL_quick   ; inline operand = 10
  $DC0C  B1                         POPSTORE
  $DC0D  CF                         RETURN

; ============================================================
; sub $DC0E   (frame_off=+0, body @ $DC13)
; ============================================================
  $DC13  0C                         LOADL_quick   ; inline operand = 12
  $DC14  8B 31                      BYTE_LOADR_imm1        +49
  $DC16  C8                         UCMPGT
  $DC17  D8 2A DC                   JUMPF_abs              $DC2A
  $DC1A  A5 4A 6E                   BYTE_LOADL_abs         $6E4A (daimyo_pool_sp_6e4a)
  $DC1D  D1                         DEC
  $DC1E  A9 4A 6E                   BYTE_STORE_abs         $6E4A (daimyo_pool_sp_6e4a)
  $DC21  A5 4A 6E                   BYTE_LOADL_abs         $6E4A (daimyo_pool_sp_6e4a)
  $DC24  8C 4B 6E                   LOADR_imm2             $6E4B
  $DC27  BB                         ADD
  $DC28  D3                         BYTE_DEREF
  $DC29  CF                         RETURN
 >$DC2A  A5 4A 6E                   BYTE_LOADL_abs         $6E4A (daimyo_pool_sp_6e4a)
  $DC2D  D0                         INC
  $DC2E  A9 4A 6E                   BYTE_STORE_abs         $6E4A (daimyo_pool_sp_6e4a)
  $DC31  A5 4A 6E                   BYTE_LOADL_abs         $6E4A (daimyo_pool_sp_6e4a)
  $DC34  8C 4A 6E                   LOADR_imm2             $6E4A (daimyo_pool_sp_6e4a)
  $DC37  BB                         ADD
  $DC38  B3                         PUSHL
  $DC39  0C                         LOADL_quick   ; inline operand = 12
  $DC3A  D4                         BYTE_POPSTORE
  $DC3B  CF                         RETURN

; ============================================================
; sub $DC3C   (frame_off=-4, body @ $DC41)
; ============================================================
  $DC41  8A 7F 6E                   LOADL_imm2             $6E7F
  $DC44  2A                         STORE_quick   ; inline operand = 10
  $DC45  40                         LOADL_qimm   ; inline operand = 0
  $DC46  2B                         STORE_quick   ; inline operand = 11
  $DC47  D6 5D DC                   JUMP_abs               $DC5D
 >$DC4A  0A                         LOADL_quick   ; inline operand = 10
  $DC4B  D3                         BYTE_DEREF
  $DC4C  1C                         LOADR_quick   ; inline operand = 12
  $DC4D  C0                         CMPEQ
  $DC4E  D8 55 DC                   JUMPF_abs              $DC55
  $DC51  3A                         PUSH_quick   ; inline operand = 10
  $DC52  89 FF                      BYTE_LOADL_imm1        -1
  $DC54  D4                         BYTE_POPSTORE
 >$DC55  0A                         LOADL_quick   ; inline operand = 10
  $DC56  D0                         INC
  $DC57  2A                         STORE_quick   ; inline operand = 10
  $DC58  D1                         DEC
  $DC59  0B                         LOADL_quick   ; inline operand = 11
  $DC5A  D0                         INC
  $DC5B  2B                         STORE_quick   ; inline operand = 11
  $DC5C  D1                         DEC
 >$DC5D  0B                         LOADL_quick   ; inline operand = 11
  $DC5E  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $DC61  C6                         UCMPLT
  $DC62  D7 4A DC                   JUMPT_abs              $DC4A
  $DC65  CF                         RETURN

; ============================================================
; sub $DC66   (frame_off=+0, body @ $DC6B)
; ============================================================
  $DC6B  0C                         LOADL_quick   ; inline operand = 12
  $DC6C  8B 32                      BYTE_LOADR_imm1        +50
  $DC6E  C8                         UCMPGT
  $DC6F  D8 74 DC                   JUMPF_abs              $DC74
  $DC72  0C                         LOADL_quick   ; inline operand = 12
  $DC73  CF                         RETURN
 >$DC74  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $DC77  8B 32                      BYTE_LOADR_imm1        +50
  $DC79  C0                         CMPEQ
  $DC7A  D8 81 DC                   JUMPF_abs              $DC81
  $DC7D  0C                         LOADL_quick   ; inline operand = 12
  $DC7E  D6 87 DC                   JUMP_abs               $DC87
 >$DC81  0C                         LOADL_quick   ; inline operand = 12
  $DC82  8C 0E F7                   LOADR_imm2             $F70E (province_to_mapid_table)
  $DC85  BB                         ADD
  $DC86  D3                         BYTE_DEREF
 >$DC87  CF                         RETURN

; ============================================================
; sub $DC88   (frame_off=-1, body @ $DC8D)
; ============================================================
  $DC8D  61                         PUSH_qimm   ; inline operand = 1
  $DC8E  DE FF FF                   LEAL_far               $FFFF
  $DC91  B3                         PUSHL
  $DC92  0D                         LOADL_quick   ; inline operand = 13
  $DC93  5B                         LOADR_qimm   ; inline operand = 11
  $DC94  B5                         MULT
  $DC95  B3                         PUSHL
  $DC96  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $DC99  E9 66 DC 02                CALL_abs_imm1          $DC66 (fief_to_mapid) {bytecode}, $02
  $DC9D  8B 37                      BYTE_LOADR_imm1        +55
  $DC9F  B5                         MULT
  $DCA0  B4                         POPR
  $DCA1  BB                         ADD
  $DCA2  1C                         LOADR_quick   ; inline operand = 12
  $DCA3  BB                         ADD
  $DCA4  8C 7E A5                   LOADR_imm2             $A57E (read_map_cell_data_a57e)
  $DCA7  BB                         ADD
  $DCA8  B3                         PUSHL
  $DCA9  64                         PUSH_qimm   ; inline operand = 4
  $DCAA  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $DCAE  A0 FF FF                   BYTE_LOADL_far         $FFFF
  $DCB1  CF                         RETURN

; ============================================================
; sub $DCB2   (frame_off=-13, body @ $DCB7)
; ============================================================
 >$DCB7  DE F3 FF                   LEAL_far               $FFF3
  $DCBA  29                         STORE_quick   ; inline operand = 9
  $DCBB  6B                         PUSH_qimm   ; inline operand = 11
  $DCBC  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $DCC0  D2                         LSHIFT1
  $DCC1  2B                         STORE_quick   ; inline operand = 11
  $DCC2  6B                         PUSH_qimm   ; inline operand = 11
  $DCC3  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $DCC7  D2                         LSHIFT1
  $DCC8  2A                         STORE_quick   ; inline operand = 10
  $DCC9  39                         PUSH_quick   ; inline operand = 9
  $DCCA  0B                         LOADL_quick   ; inline operand = 11
  $DCCB  8C 30 F9                   LOADR_imm2             $F930 (msg_aiaoieueoikakikusasisusotatuto)
  $DCCE  BB                         ADD
  $DCCF  D3                         BYTE_DEREF
  $DCD0  D4                         BYTE_POPSTORE
  $DCD1  09                         LOADL_quick   ; inline operand = 9
  $DCD2  D0                         INC
  $DCD3  29                         STORE_quick   ; inline operand = 9
  $DCD4  B3                         PUSHL
  $DCD5  0B                         LOADL_quick   ; inline operand = 11
  $DCD6  D0                         INC
  $DCD7  2B                         STORE_quick   ; inline operand = 11
  $DCD8  8C 30 F9                   LOADR_imm2             $F930 (msg_aiaoieueoikakikusasisusotatuto)
  $DCDB  BB                         ADD
  $DCDC  D3                         BYTE_DEREF
  $DCDD  D4                         BYTE_POPSTORE
  $DCDE  09                         LOADL_quick   ; inline operand = 9
  $DCDF  D0                         INC
  $DCE0  29                         STORE_quick   ; inline operand = 9
  $DCE1  B3                         PUSHL
  $DCE2  0A                         LOADL_quick   ; inline operand = 10
  $DCE3  8C 5D F9                   LOADR_imm2             $F95D (msg_setenohomamimemoyarawagagizaze)
  $DCE6  BB                         ADD
  $DCE7  D3                         BYTE_DEREF
  $DCE8  D4                         BYTE_POPSTORE
  $DCE9  09                         LOADL_quick   ; inline operand = 9
  $DCEA  D0                         INC
  $DCEB  29                         STORE_quick   ; inline operand = 9
  $DCEC  B3                         PUSHL
  $DCED  0A                         LOADL_quick   ; inline operand = 10
  $DCEE  D0                         INC
  $DCEF  2A                         STORE_quick   ; inline operand = 10
  $DCF0  8C 5D F9                   LOADR_imm2             $F95D (msg_setenohomamimemoyarawagagizaze)
  $DCF3  BB                         ADD
  $DCF4  D3                         BYTE_DEREF
  $DCF5  D4                         BYTE_POPSTORE
  $DCF6  09                         LOADL_quick   ; inline operand = 9
  $DCF7  D0                         INC
  $DCF8  29                         STORE_quick   ; inline operand = 9
  $DCF9  B3                         PUSHL
  $DCFA  40                         LOADL_qimm   ; inline operand = 0
  $DCFB  D4                         BYTE_POPSTORE
  $DCFC  40                         LOADL_qimm   ; inline operand = 0
  $DCFD  28                         STORE_quick   ; inline operand = 8
  $DCFE  40                         LOADL_qimm   ; inline operand = 0
  $DCFF  D6 1C DD                   JUMP_abs               $DD1C
 >$DD02  0B                         LOADL_quick   ; inline operand = 11
  $DD03  59                         LOADR_qimm   ; inline operand = 9
  $DD04  B5                         MULT
  $DD05  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $DD08  BB                         ADD
  $DD09  B3                         PUSHL
  $DD0A  DE F3 FF                   LEAL_far               $FFF3
  $DD0D  B3                         PUSHL
  $DD0E  E9 B0 CA 04                CALL_abs_imm1          $CAB0 (strcmp) {bytecode}, $04
  $DD12  D7 1A DD                   JUMPT_abs              $DD1A
  $DD15  41                         LOADL_qimm   ; inline operand = 1
  $DD16  28                         STORE_quick   ; inline operand = 8
  $DD17  D6 25 DD                   JUMP_abs               $DD25
 >$DD1A  0B                         LOADL_quick   ; inline operand = 11
  $DD1B  D0                         INC
 >$DD1C  2B                         STORE_quick   ; inline operand = 11
  $DD1D  0B                         LOADL_quick   ; inline operand = 11
  $DD1E  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $DD21  C6                         UCMPLT
  $DD22  D7 02 DD                   JUMPT_abs              $DD02
 >$DD25  08                         LOADL_quick   ; inline operand = 8
  $DD26  D7 B7 DC                   JUMPT_abs              $DCB7
  $DD29  DE F3 FF                   LEAL_far               $FFF3
  $DD2C  B3                         PUSHL
  $DD2D  0C                         LOADL_quick   ; inline operand = 12
  $DD2E  59                         LOADR_qimm   ; inline operand = 9
  $DD2F  B5                         MULT
  $DD30  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $DD33  BB                         ADD
  $DD34  B3                         PUSHL
  $DD35  E9 D9 CA 04                CALL_abs_imm1          $CAD9 (strcpy) {bytecode}, $04
  $DD39  CF                         RETURN

; ============================================================
; sub $DD3A   (frame_off=-12, body @ $DD3F)
; ============================================================
  $DD3F  DE F8 FF                   LEAL_far               $FFF8
  $DD42  26                         STORE_quick   ; inline operand = 6
  $DD43  0D                         LOADL_quick   ; inline operand = 13
  $DD44  D6 67 DD                   JUMP_abs               $DD67
 >$DD47  07                         LOADL_quick   ; inline operand = 7
  $DD48  D3                         BYTE_DEREF
  $DD49  B3                         PUSHL
  $DD4A  E9 B7 D9 02                CALL_abs_imm1          $D9B7 (is_enemy_owned) {bytecode}, $02
  $DD4E  1C                         LOADR_quick   ; inline operand = 12
  $DD4F  DC                         XOR
  $DD50  D7 65 DD                   JUMPT_abs              $DD65
  $DD53  07                         LOADL_quick   ; inline operand = 7
  $DD54  D3                         BYTE_DEREF
  $DD55  B3                         PUSHL
  $DD56  E9 99 D9 02                CALL_abs_imm1          $D999 (province_state_is_FF) {bytecode}, $02
  $DD5A  D7 65 DD                   JUMPT_abs              $DD65
  $DD5D  06                         LOADL_quick   ; inline operand = 6
  $DD5E  D0                         INC
  $DD5F  26                         STORE_quick   ; inline operand = 6
  $DD60  D1                         DEC
  $DD61  B3                         PUSHL
  $DD62  07                         LOADL_quick   ; inline operand = 7
  $DD63  D3                         BYTE_DEREF
  $DD64  D4                         BYTE_POPSTORE
 >$DD65  07                         LOADL_quick   ; inline operand = 7
  $DD66  D0                         INC
 >$DD67  27                         STORE_quick   ; inline operand = 7
  $DD68  07                         LOADL_quick   ; inline operand = 7
  $DD69  D3                         BYTE_DEREF
  $DD6A  8C FF 00                   LOADR_imm2             $00FF
  $DD6D  C1                         CMPNE
  $DD6E  D7 47 DD                   JUMPT_abs              $DD47
  $DD71  36                         PUSH_quick   ; inline operand = 6
  $DD72  89 FF                      BYTE_LOADL_imm1        -1
  $DD74  D4                         BYTE_POPSTORE
  $DD75  68                         PUSH_qimm   ; inline operand = 8
  $DD76  3D                         PUSH_quick   ; inline operand = 13
  $DD77  DE F8 FF                   LEAL_far               $FFF8
  $DD7A  B3                         PUSHL
  $DD7B  60                         PUSH_qimm   ; inline operand = 0
  $DD7C  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $DD80  CF                         RETURN

; ============================================================
; sub $DD81   (frame_off=-8, body @ $DD86)
; ============================================================
  $DD86  3C                         PUSH_quick   ; inline operand = 12
  $DD87  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $DD8B  B3                         PUSHL
  $DD8C  8D 14                      BYTE_PUSH_imm1         +20
  $DD8E  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $DD92  8F 14                      BYTE_ADD_imm1          +20
  $DD94  D4                         BYTE_POPSTORE
  $DD95  3C                         PUSH_quick   ; inline operand = 12
  $DD96  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $DD9A  D0                         INC
  $DD9B  2A                         STORE_quick   ; inline operand = 10
  $DD9C  D6 C8 DD                   JUMP_abs               $DDC8
 >$DD9F  3B                         PUSH_quick   ; inline operand = 11
  $DDA0  8D 14                      BYTE_PUSH_imm1         +20
  $DDA2  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $DDA6  8F 32                      BYTE_ADD_imm1          +50
  $DDA8  B3                         PUSHL
  $DDA9  0B                         LOADL_quick   ; inline operand = 11
  $DDAA  D3                         BYTE_DEREF
  $DDAB  B3                         PUSHL
  $DDAC  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $DDB0  D4                         BYTE_POPSTORE
  $DDB1  0B                         LOADL_quick   ; inline operand = 11
  $DDB2  D3                         BYTE_DEREF
  $DDB3  8B 1E                      BYTE_LOADR_imm1        +30
  $DDB5  C2                         SCMPLT
  $DDB6  D8 BE DD                   JUMPF_abs              $DDBE
  $DDB9  89 1E                      BYTE_LOADL_imm1        +30
  $DDBB  D6 BF DD                   JUMP_abs               $DDBF
 >$DDBE  40                         LOADL_qimm   ; inline operand = 0
 >$DDBF  B3                         PUSHL
  $DDC0  0B                         LOADL_quick   ; inline operand = 11
  $DDC1  B4                         POPR
  $DDC2  B3                         PUSHL
  $DDC3  D3                         BYTE_DEREF
  $DDC4  BB                         ADD
  $DDC5  D4                         BYTE_POPSTORE
  $DDC6  0B                         LOADL_quick   ; inline operand = 11
  $DDC7  D0                         INC
 >$DDC8  2B                         STORE_quick   ; inline operand = 11
  $DDC9  0A                         LOADL_quick   ; inline operand = 10
  $DDCA  74                         ADD_qimm   ; inline operand = 4
  $DDCB  B3                         PUSHL
  $DDCC  0B                         LOADL_quick   ; inline operand = 11
  $DDCD  B4                         POPR
  $DDCE  C7                         UCMPLE
  $DDCF  D7 9F DD                   JUMPT_abs              $DD9F
  $DDD2  0C                         LOADL_quick   ; inline operand = 12
  $DDD3  8B 1A                      BYTE_LOADR_imm1        +26
  $DDD5  B5                         MULT
  $DDD6  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $DDD9  BB                         ADD
  $DDDA  28                         STORE_quick   ; inline operand = 8
  $DDDB  D6 45 DE                   JUMP_abs               $DE45
 >$DDDE  0C                         LOADL_quick   ; inline operand = 12
  $DDDF  8B 1A                      BYTE_LOADR_imm1        +26
  $DDE1  B5                         MULT
  $DDE2  8C 17 70                   LOADR_imm2             $7017
  $DDE5  BB                         ADD
  $DDE6  19                         LOADR_quick   ; inline operand = 9
  $DDE7  C0                         CMPEQ
  $DDE8  D8 0A DE                   JUMPF_abs              $DE0A
  $DDEB  39                         PUSH_quick   ; inline operand = 9
  $DDEC  8D 1F                      BYTE_PUSH_imm1         +31
  $DDEE  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $DDF2  8F 32                      BYTE_ADD_imm1          +50
  $DDF4  B3                         PUSHL
  $DDF5  09                         LOADL_quick   ; inline operand = 9
  $DDF6  B0                         DEREF
  $DDF7  B3                         PUSHL
  $DDF8  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $DDFC  B1                         POPSTORE
  $DDFD  09                         LOADL_quick   ; inline operand = 9
  $DDFE  B0                         DEREF
  $DDFF  8B 32                      BYTE_LOADR_imm1        +50
  $DE01  C2                         SCMPLT
  $DE02  D8 3B DE                   JUMPF_abs              $DE3B
  $DE05  89 32                      BYTE_LOADL_imm1        +50
  $DE07  D6 3C DE                   JUMP_abs               $DE3C
 >$DE0A  39                         PUSH_quick   ; inline operand = 9
  $DE0B  0C                         LOADL_quick   ; inline operand = 12
  $DE0C  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $DE0F  BB                         ADD
  $DE10  D3                         BYTE_DEREF
  $DE11  D8 1F DE                   JUMPF_abs              $DE1F
  $DE14  8D 14                      BYTE_PUSH_imm1         +20
  $DE16  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $DE1A  8F 32                      BYTE_ADD_imm1          +50
  $DE1C  D6 27 DE                   JUMP_abs               $DE27
 >$DE1F  8D 1E                      BYTE_PUSH_imm1         +30
  $DE21  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $DE25  8F 1E                      BYTE_ADD_imm1          +30
 >$DE27  B3                         PUSHL
  $DE28  09                         LOADL_quick   ; inline operand = 9
  $DE29  B0                         DEREF
  $DE2A  B3                         PUSHL
  $DE2B  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $DE2F  B1                         POPSTORE
  $DE30  09                         LOADL_quick   ; inline operand = 9
  $DE31  B0                         DEREF
  $DE32  5A                         LOADR_qimm   ; inline operand = 10
  $DE33  C2                         SCMPLT
  $DE34  D8 3B DE                   JUMPF_abs              $DE3B
  $DE37  4A                         LOADL_qimm   ; inline operand = 10
  $DE38  D6 3C DE                   JUMP_abs               $DE3C
 >$DE3B  40                         LOADL_qimm   ; inline operand = 0
 >$DE3C  B3                         PUSHL
  $DE3D  09                         LOADL_quick   ; inline operand = 9
  $DE3E  B4                         POPR
  $DE3F  B3                         PUSHL
  $DE40  B0                         DEREF
  $DE41  BB                         ADD
  $DE42  B1                         POPSTORE
  $DE43  09                         LOADL_quick   ; inline operand = 9
  $DE44  72                         ADD_qimm   ; inline operand = 2
 >$DE45  29                         STORE_quick   ; inline operand = 9
  $DE46  08                         LOADL_quick   ; inline operand = 8
  $DE47  8F 18                      BYTE_ADD_imm1          +24
  $DE49  B3                         PUSHL
  $DE4A  09                         LOADL_quick   ; inline operand = 9
  $DE4B  B4                         POPR
  $DE4C  C6                         UCMPLT
  $DE4D  D7 DE DD                   JUMPT_abs              $DDDE
  $DE50  8D 32                      BYTE_PUSH_imm1         +50
  $DE52  0C                         LOADL_quick   ; inline operand = 12
  $DE53  8B 1A                      BYTE_LOADR_imm1        +26
  $DE55  B5                         MULT
  $DE56  8C 0D 70                   LOADR_imm2             $700D
  $DE59  BB                         ADD
  $DE5A  B4                         POPR
  $DE5B  B3                         PUSHL
  $DE5C  B0                         DEREF
  $DE5D  BB                         ADD
  $DE5E  B1                         POPSTORE
  $DE5F  8D 32                      BYTE_PUSH_imm1         +50
  $DE61  0C                         LOADL_quick   ; inline operand = 12
  $DE62  8B 1A                      BYTE_LOADR_imm1        +26
  $DE64  B5                         MULT
  $DE65  8C 13 70                   LOADR_imm2             $7013
  $DE68  BB                         ADD
  $DE69  B4                         POPR
  $DE6A  B3                         PUSHL
  $DE6B  B0                         DEREF
  $DE6C  BB                         ADD
  $DE6D  B1                         POPSTORE
  $DE6E  0C                         LOADL_quick   ; inline operand = 12
  $DE6F  8C 2D 6D                   LOADR_imm2             $6D2D (fief_tax_rate)
  $DE72  BB                         ADD
  $DE73  B3                         PUSHL
  $DE74  89 14                      BYTE_LOADL_imm1        +20
  $DE76  D4                         BYTE_POPSTORE
  $DE77  CF                         RETURN

; ============================================================
; sub $DE78   (frame_off=-2, body @ $DE7D)
; ============================================================
  $DE7D  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $DE80  8B 20                      BYTE_LOADR_imm1        +32
  $DE82  DA                         AND
  $DE83  D8 8A DE                   JUMPF_abs              $DE8A
  $DE86  8A 2E F7                   LOADL_imm2             $F72E (msg_rebels_f72e)
  $DE89  CF                         RETURN
 >$DE8A  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $DE8D  8B 10                      BYTE_LOADR_imm1        +16
  $DE8F  DA                         AND
  $DE90  D8 97 DE                   JUMPF_abs              $DE97
  $DE93  8A 6A 79                   LOADL_imm2             $796A
  $DE96  CF                         RETURN
 >$DE97  0C                         LOADL_quick   ; inline operand = 12
  $DE98  D9 04 00 07 00 AD DE 0D 00 B3 DE 17 ... SWITCH_noncontig       count=4   ; .table 4 (key,target) + default (noncontiguous); SWITCH 7=>$DEAD 13=>$DEB3 23=>$DEAD 30=>$DEB3 default=>$DEB9
 >$DEAD  8A 20 F7                   LOADL_imm2             $F720
 >$DEB0  2B                         STORE_quick   ; inline operand = 11
  $DEB1  0B                         LOADL_quick   ; inline operand = 11
  $DEB2  CF                         RETURN
 >$DEB3  8A 28 F7                   LOADL_imm2             $F728
  $DEB6  D6 B0 DE                   JUMP_abs               $DEB0
 >$DEB9  3C                         PUSH_quick   ; inline operand = 12
  $DEBA  E9 F7 D9 02                CALL_abs_imm1          $D9F7 (classify_7b79) {bytecode}, $02
  $DEBE  D6 B0 DE                   JUMP_abs               $DEB0

; ============================================================
; sub $DEC1   (frame_off=-8, body @ $DEC6)
; ============================================================
  $DEC6  A4 57 6F                   LOADL_abs              $6F57 (battle_winner_province_sel)
  $DEC9  A6 63 6F                   LOADR_abs              $6F63 (battle_defending_province)
  $DECC  C0                         CMPEQ
  $DECD  D8 D6 DE                   JUMPF_abs              $DED6
  $DED0  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $DED3  D6 D9 DE                   JUMP_abs               $DED9
 >$DED6  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
 >$DED9  28                         STORE_quick   ; inline operand = 8
  $DEDA  B3                         PUSHL
  $DEDB  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $DEDF  2A                         STORE_quick   ; inline operand = 10
  $DEE0  AA 57 6F                   PUSH_abs               $6F57 (battle_winner_province_sel)
  $DEE3  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $DEE7  29                         STORE_quick   ; inline operand = 9
  $DEE8  B3                         PUSHL
  $DEE9  E9 0E DC 02                CALL_abs_imm1          $DC0E (list_op_6e4a) {bytecode}, $02
  $DEED  39                         PUSH_quick   ; inline operand = 9
  $DEEE  E9 3C DC 02                CALL_abs_imm1          $DC3C (list_remove_6e7f) {bytecode}, $02
  $DEF2  40                         LOADL_qimm   ; inline operand = 0
  $DEF3  D6 33 DF                   JUMP_abs               $DF33
 >$DEF6  3B                         PUSH_quick   ; inline operand = 11
  $DEF7  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $DEFB  19                         LOADR_quick   ; inline operand = 9
  $DEFC  C0                         CMPEQ
  $DEFD  D8 31 DF                   JUMPF_abs              $DF31
  $DF00  3B                         PUSH_quick   ; inline operand = 11
  $DF01  E9 99 D9 02                CALL_abs_imm1          $D999 (province_state_is_FF) {bytecode}, $02
  $DF05  D7 31 DF                   JUMPT_abs              $DF31
  $DF08  0B                         LOADL_quick   ; inline operand = 11
  $DF09  8C 15 6E                   LOADR_imm2             $6E15 (fief_to_daimyo_map)
  $DF0C  BB                         ADD
  $DF0D  B3                         PUSHL
  $DF0E  0A                         LOADL_quick   ; inline operand = 10
  $DF0F  D4                         BYTE_POPSTORE
  $DF10  0B                         LOADL_quick   ; inline operand = 11
  $DF11  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $DF14  BB                         ADD
  $DF15  B3                         PUSHL
  $DF16  40                         LOADL_qimm   ; inline operand = 0
  $DF17  D4                         BYTE_POPSTORE
  $DF18  0B                         LOADL_quick   ; inline operand = 11
  $DF19  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $DF1C  BB                         ADD
  $DF1D  B3                         PUSHL
  $DF1E  38                         PUSH_quick   ; inline operand = 8
  $DF1F  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $DF23  D8 2A DF                   JUMPF_abs              $DF2A
  $DF26  45                         LOADL_qimm   ; inline operand = 5
  $DF27  D6 2B DF                   JUMP_abs               $DF2B
 >$DF2A  40                         LOADL_qimm   ; inline operand = 0
 >$DF2B  D4                         BYTE_POPSTORE
  $DF2C  3B                         PUSH_quick   ; inline operand = 11
  $DF2D  E9 54 E5 02                CALL_abs_imm1          $E554 (find_record_9e3c) {bytecode}, $02
 >$DF31  0B                         LOADL_quick   ; inline operand = 11
  $DF32  D0                         INC
 >$DF33  2B                         STORE_quick   ; inline operand = 11
  $DF34  0B                         LOADL_quick   ; inline operand = 11
  $DF35  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $DF38  C6                         UCMPLT
  $DF39  D7 F6 DE                   JUMPT_abs              $DEF6
  $DF3C  CF                         RETURN

; ============================================================
; sub $DF3D   (frame_off=-2, body @ $DF42)
; ============================================================
  $DF42  3C                         PUSH_quick   ; inline operand = 12
  $DF43  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $DF47  2B                         STORE_quick   ; inline operand = 11
  $DF48  0B                         LOADL_quick   ; inline operand = 11
  $DF49  72                         ADD_qimm   ; inline operand = 2
  $DF4A  B3                         PUSHL
  $DF4B  D3                         BYTE_DEREF
  $DF4C  D0                         INC
  $DF4D  D4                         BYTE_POPSTORE
  $DF4E  0B                         LOADL_quick   ; inline operand = 11
  $DF4F  74                         ADD_qimm   ; inline operand = 4
  $DF50  B3                         PUSHL
  $DF51  D3                         BYTE_DEREF
  $DF52  D0                         INC
  $DF53  D4                         BYTE_POPSTORE
  $DF54  0B                         LOADL_quick   ; inline operand = 11
  $DF55  75                         ADD_qimm   ; inline operand = 5
  $DF56  B3                         PUSHL
  $DF57  D3                         BYTE_DEREF
  $DF58  D0                         INC
  $DF59  D4                         BYTE_POPSTORE
  $DF5A  3D                         PUSH_quick   ; inline operand = 13
  $DF5B  E9 DA D7 02                CALL_abs_imm1          $D7DA (fief_to_daimyo_record_addr) {bytecode}, $02
  $DF5F  2B                         STORE_quick   ; inline operand = 11
  $DF60  0B                         LOADL_quick   ; inline operand = 11
  $DF61  72                         ADD_qimm   ; inline operand = 2
  $DF62  B3                         PUSHL
  $DF63  D3                         BYTE_DEREF
  $DF64  D1                         DEC
  $DF65  D4                         BYTE_POPSTORE
  $DF66  0B                         LOADL_quick   ; inline operand = 11
  $DF67  74                         ADD_qimm   ; inline operand = 4
  $DF68  B3                         PUSHL
  $DF69  D3                         BYTE_DEREF
  $DF6A  D1                         DEC
  $DF6B  D4                         BYTE_POPSTORE
  $DF6C  0B                         LOADL_quick   ; inline operand = 11
  $DF6D  75                         ADD_qimm   ; inline operand = 5
  $DF6E  B3                         PUSHL
  $DF6F  D3                         BYTE_DEREF
  $DF70  D1                         DEC
  $DF71  D4                         BYTE_POPSTORE
  $DF72  CF                         RETURN

; ============================================================
; sub $DF73   (frame_off=-8, body @ $DF78)
; ============================================================
  $DF78  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $DF7B  8B 1A                      BYTE_LOADR_imm1        +26
  $DF7D  B5                         MULT
  $DF7E  8C 13 70                   LOADR_imm2             $7013
  $DF81  BB                         ADD
  $DF82  29                         STORE_quick   ; inline operand = 9
  $DF83  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $DF86  8B 1A                      BYTE_LOADR_imm1        +26
  $DF88  B5                         MULT
  $DF89  8C 13 70                   LOADR_imm2             $7013
  $DF8C  BB                         ADD
  $DF8D  2A                         STORE_quick   ; inline operand = 10
  $DF8E  0A                         LOADL_quick   ; inline operand = 10
  $DF8F  76                         ADD_qimm   ; inline operand = 6
  $DF90  B0                         DEREF
  $DF91  2B                         STORE_quick   ; inline operand = 11
  $DF92  40                         LOADL_qimm   ; inline operand = 0
  $DF93  28                         STORE_quick   ; inline operand = 8
 >$DF94  3A                         PUSH_quick   ; inline operand = 10
  $DF95  3B                         PUSH_quick   ; inline operand = 11
  $DF96  AA 87 6F                   PUSH_abs               $6F87 (war_defender_men)
  $DF99  AA 81 6F                   PUSH_abs               $6F81 (war_attacker_men)
  $DF9C  09                         LOADL_quick   ; inline operand = 9
  $DF9D  B0                         DEREF
  $DF9E  B3                         PUSHL
  $DF9F  0A                         LOADL_quick   ; inline operand = 10
  $DFA0  B0                         DEREF
  $DFA1  B3                         PUSHL
  $DFA2  E9 24 DA 0A                CALL_abs_imm1          $DA24 (scaled_transfer_da24) {bytecode}, $0A
  $DFA6  B1                         POPSTORE
  $DFA7  08                         LOADL_quick   ; inline operand = 8
  $DFA8  D0                         INC
  $DFA9  28                         STORE_quick   ; inline operand = 8
  $DFAA  D1                         DEC
  $DFAB  0A                         LOADL_quick   ; inline operand = 10
  $DFAC  72                         ADD_qimm   ; inline operand = 2
  $DFAD  2A                         STORE_quick   ; inline operand = 10
  $DFAE  8F FE                      BYTE_ADD_imm1          -2
  $DFB0  09                         LOADL_quick   ; inline operand = 9
  $DFB1  72                         ADD_qimm   ; inline operand = 2
  $DFB2  29                         STORE_quick   ; inline operand = 9
  $DFB3  8F FE                      BYTE_ADD_imm1          -2
  $DFB5  08                         LOADL_quick   ; inline operand = 8
  $DFB6  53                         LOADR_qimm   ; inline operand = 3
  $DFB7  C6                         UCMPLT
  $DFB8  D7 94 DF                   JUMPT_abs              $DF94
  $DFBB  CF                         RETURN

; ============================================================
; sub $DFBC   (frame_off=-2, body @ $DFC1)
; ============================================================
  $DFC1  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $DFC4  2B                         STORE_quick   ; inline operand = 11
  $DFC5  40                         LOADL_qimm   ; inline operand = 0
  $DFC6  D6 EC DF                   JUMP_abs               $DFEC
 >$DFC9  AC 12 DB                   CALL_abs               $DB12 (tax_helper_db12) {bytecode}
  $DFCC  D8 E8 DF                   JUMPF_abs              $DFE8
  $DFCF  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $DFD2  8C 2D 6D                   LOADR_imm2             $6D2D (fief_tax_rate)
  $DFD5  BB                         ADD
  $DFD6  D3                         BYTE_DEREF
  $DFD7  8B 1E                      BYTE_LOADR_imm1        +30
  $DFD9  C4                         SCMPGT
  $DFDA  D8 E8 DF                   JUMPF_abs              $DFE8
  $DFDD  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $DFE0  8C 2D 6D                   LOADR_imm2             $6D2D (fief_tax_rate)
  $DFE3  BB                         ADD
  $DFE4  B3                         PUSHL
  $DFE5  89 1E                      BYTE_LOADL_imm1        +30
  $DFE7  D4                         BYTE_POPSTORE
 >$DFE8  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $DFEB  D0                         INC
 >$DFEC  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $DFEF  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $DFF2  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $DFF5  C6                         UCMPLT
  $DFF6  D7 C9 DF                   JUMPT_abs              $DFC9
  $DFF9  0B                         LOADL_quick   ; inline operand = 11
  $DFFA  A8 63 6F                   STORE_abs              $6F63 (battle_defending_province)
  $DFFD  CF                         RETURN

; ============================================================
; sub $DFFE   (frame_off=-2, body @ $E003)
; ============================================================
  $E003  0D                         LOADL_quick   ; inline operand = 13
  $E004  8F 16                      BYTE_ADD_imm1          +22
  $E006  B0                         DEREF
  $E007  8B 32                      BYTE_LOADR_imm1        +50
  $E009  B6                         SDIV
  $E00A  8F 14                      BYTE_ADD_imm1          +20
  $E00C  2B                         STORE_quick   ; inline operand = 11
  $E00D  0C                         LOADL_quick   ; inline operand = 12
  $E00E  55                         LOADR_qimm   ; inline operand = 5
  $E00F  B5                         MULT
  $E010  8C AB 76                   LOADR_imm2             $76AB
  $E013  BB                         ADD
  $E014  D3                         BYTE_DEREF
  $E015  1B                         LOADR_quick   ; inline operand = 11
  $E016  C8                         UCMPGT
  $E017  D8 3B E0                   JUMPF_abs              $E03B
  $E01A  0C                         LOADL_quick   ; inline operand = 12
  $E01B  55                         LOADR_qimm   ; inline operand = 5
  $E01C  B5                         MULT
  $E01D  8C AB 76                   LOADR_imm2             $76AB
  $E020  BB                         ADD
  $E021  D3                         BYTE_DEREF
  $E022  1B                         LOADR_quick   ; inline operand = 11
  $E023  BC                         SUB
  $E024  B3                         PUSHL
  $E025  0C                         LOADL_quick   ; inline operand = 12
  $E026  55                         LOADR_qimm   ; inline operand = 5
  $E027  B5                         MULT
  $E028  8C A9 76                   LOADR_imm2             $76A9
  $E02B  BB                         ADD
  $E02C  B4                         POPR
  $E02D  B3                         PUSHL
  $E02E  D3                         BYTE_DEREF
  $E02F  BB                         ADD
  $E030  D4                         BYTE_POPSTORE
  $E031  0C                         LOADL_quick   ; inline operand = 12
  $E032  55                         LOADR_qimm   ; inline operand = 5
  $E033  B5                         MULT
  $E034  8C AB 76                   LOADR_imm2             $76AB
  $E037  BB                         ADD
  $E038  B3                         PUSHL
  $E039  0B                         LOADL_quick   ; inline operand = 11
  $E03A  D4                         BYTE_POPSTORE
 >$E03B  CF                         RETURN

; ============================================================
; sub $E03C   (frame_off=-12, body @ $E041)
; ============================================================
  $E041  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $E044  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $E048  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $E04B  8B 1A                      BYTE_LOADR_imm1        +26
  $E04D  B5                         MULT
  $E04E  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $E051  BB                         ADD
  $E052  26                         STORE_quick   ; inline operand = 6
  $E053  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $E056  8B 32                      BYTE_LOADR_imm1        +50
  $E058  C0                         CMPEQ
  $E059  28                         STORE_quick   ; inline operand = 8
  $E05A  A4 57 6F                   LOADL_abs              $6F57 (battle_winner_province_sel)
  $E05D  A6 63 6F                   LOADR_abs              $6F63 (battle_defending_province)
  $E060  C0                         CMPEQ
  $E061  29                         STORE_quick   ; inline operand = 9
  $E062  09                         LOADL_quick   ; inline operand = 9
  $E063  D8 80 E0                   JUMPF_abs              $E080
  $E066  65                         PUSH_qimm   ; inline operand = 5
  $E067  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $E06A  55                         LOADR_qimm   ; inline operand = 5
  $E06B  B5                         MULT
  $E06C  8C A9 76                   LOADR_imm2             $76A9
  $E06F  BB                         ADD
  $E070  B3                         PUSHL
  $E071  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $E074  55                         LOADR_qimm   ; inline operand = 5
  $E075  B5                         MULT
  $E076  8C A9 76                   LOADR_imm2             $76A9
  $E079  BB                         ADD
  $E07A  B3                         PUSHL
  $E07B  64                         PUSH_qimm   ; inline operand = 4
  $E07C  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
 >$E080  08                         LOADL_quick   ; inline operand = 8
  $E081  D7 A6 E0                   JUMPT_abs              $E0A6
  $E084  AC 73 DF                   CALL_abs               $DF73 (transfer_force_triplet) {bytecode}
  $E087  36                         PUSH_quick   ; inline operand = 6
  $E088  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $E08B  E9 FE DF 04                CALL_abs_imm1          $DFFE (update_arms_table_dffe) {bytecode}, $04
  $E08F  09                         LOADL_quick   ; inline operand = 9
  $E090  D8 9C E0                   JUMPF_abs              $E09C
  $E093  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $E096  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $E099  D6 A2 E0                   JUMP_abs               $E0A2
 >$E09C  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $E09F  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
 >$E0A2  E9 3D DF 04                CALL_abs_imm1          $DF3D (daimyo_stat_transfer) {bytecode}, $04
 >$E0A6  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $E0A9  8B 20                      BYTE_LOADR_imm1        +32
  $E0AB  DA                         AND
  $E0AC  D7 B3 E0                   JUMPT_abs              $E0B3
  $E0AF  08                         LOADL_quick   ; inline operand = 8
  $E0B0  D7 B7 E0                   JUMPT_abs              $E0B7
 >$E0B3  40                         LOADL_qimm   ; inline operand = 0
  $E0B4  D6 B8 E0                   JUMP_abs               $E0B8
 >$E0B7  41                         LOADL_qimm   ; inline operand = 1
 >$E0B8  27                         STORE_quick   ; inline operand = 7
  $E0B9  07                         LOADL_quick   ; inline operand = 7
  $E0BA  D8 CB E0                   JUMPF_abs              $E0CB
  $E0BD  09                         LOADL_quick   ; inline operand = 9
  $E0BE  D7 CB E0                   JUMPT_abs              $E0CB
  $E0C1  40                         LOADL_qimm   ; inline operand = 0
  $E0C2  A8 81 6F                   STORE_abs              $6F81 (war_attacker_men)
  $E0C5  A8 7F 6F                   STORE_abs              $6F7F (war_attacker_rice)
  $E0C8  A8 7D 6F                   STORE_abs              $6F7D (war_attacker_gold)
 >$E0CB  36                         PUSH_quick   ; inline operand = 6
  $E0CC  A4 7D 6F                   LOADL_abs              $6F7D (war_attacker_gold)
  $E0CF  A6 83 6F                   LOADR_abs              $6F83 (war_defender_gold)
  $E0D2  BB                         ADD
  $E0D3  B1                         POPSTORE
  $E0D4  06                         LOADL_quick   ; inline operand = 6
  $E0D5  76                         ADD_qimm   ; inline operand = 6
  $E0D6  B3                         PUSHL
  $E0D7  A4 7F 6F                   LOADL_abs              $6F7F (war_attacker_rice)
  $E0DA  A6 85 6F                   LOADR_abs              $6F85 (war_defender_rice)
  $E0DD  BB                         ADD
  $E0DE  B1                         POPSTORE
  $E0DF  06                         LOADL_quick   ; inline operand = 6
  $E0E0  8F 10                      BYTE_ADD_imm1          +16
  $E0E2  B3                         PUSHL
  $E0E3  A4 81 6F                   LOADL_abs              $6F81 (war_attacker_men)
  $E0E6  A6 87 6F                   LOADR_abs              $6F87 (war_defender_men)
  $E0E9  BB                         ADD
  $E0EA  B1                         POPSTORE
  $E0EB  07                         LOADL_quick   ; inline operand = 7
  $E0EC  D8 06 E1                   JUMPF_abs              $E106
  $E0EF  6A                         PUSH_qimm   ; inline operand = 10
  $E0F0  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $E0F4  7A                         ADD_qimm   ; inline operand = 10
  $E0F5  B3                         PUSHL
  $E0F6  06                         LOADL_quick   ; inline operand = 6
  $E0F7  78                         ADD_qimm   ; inline operand = 8
  $E0F8  B0                         DEREF
  $E0F9  B3                         PUSHL
  $E0FA  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $E0FE  B3                         PUSHL
  $E0FF  06                         LOADL_quick   ; inline operand = 6
  $E100  78                         ADD_qimm   ; inline operand = 8
  $E101  B4                         POPR
  $E102  B3                         PUSHL
  $E103  B0                         DEREF
  $E104  BC                         SUB
  $E105  B1                         POPSTORE
 >$E106  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $E109  8C 15 6E                   LOADR_imm2             $6E15 (fief_to_daimyo_map)
  $E10C  BB                         ADD
  $E10D  2A                         STORE_quick   ; inline operand = 10
  $E10E  08                         LOADL_quick   ; inline operand = 8
  $E10F  D7 20 E1                   JUMPT_abs              $E120
  $E112  39                         PUSH_quick   ; inline operand = 9
  $E113  E9 E5 D9 02                CALL_abs_imm1          $D9E5 (test_6f65_bit7) {bytecode}, $02
  $E117  D8 20 E1                   JUMPF_abs              $E120
  $E11A  AC C1 DE                   CALL_abs               $DEC1 (reassign_fiefs_to_conqueror) {bytecode}
  $E11D  D6 9C E1                   JUMP_abs               $E19C
 >$E120  09                         LOADL_quick   ; inline operand = 9
  $E121  D8 9C E1                   JUMPF_abs              $E19C
  $E124  08                         LOADL_quick   ; inline operand = 8
  $E125  D8 78 E1                   JUMPF_abs              $E178
  $E128  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $E12B  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $E12E  BB                         ADD
  $E12F  D3                         BYTE_DEREF
  $E130  D8 6E E1                   JUMPF_abs              $E16E
  $E133  0A                         LOADL_quick   ; inline operand = 10
  $E134  D3                         BYTE_DEREF
  $E135  B3                         PUSHL
  $E136  E9 0E DC 02                CALL_abs_imm1          $DC0E (list_op_6e4a) {bytecode}, $02
  $E13A  0A                         LOADL_quick   ; inline operand = 10
  $E13B  D3                         BYTE_DEREF
  $E13C  B3                         PUSHL
  $E13D  E9 3C DC 02                CALL_abs_imm1          $DC3C (list_remove_6e7f) {bytecode}, $02
  $E141  40                         LOADL_qimm   ; inline operand = 0
  $E142  D6 65 E1                   JUMP_abs               $E165
 >$E145  0A                         LOADL_quick   ; inline operand = 10
  $E146  D3                         BYTE_DEREF
  $E147  B3                         PUSHL
  $E148  3B                         PUSH_quick   ; inline operand = 11
  $E149  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $E14D  B4                         POPR
  $E14E  C0                         CMPEQ
  $E14F  D8 63 E1                   JUMPF_abs              $E163
  $E152  0B                         LOADL_quick   ; inline operand = 11
  $E153  A6 63 6F                   LOADR_abs              $6F63 (battle_defending_province)
  $E156  C1                         CMPNE
  $E157  D8 63 E1                   JUMPF_abs              $E163
  $E15A  3B                         PUSH_quick   ; inline operand = 11
  $E15B  E9 C8 D9 02                CALL_abs_imm1          $D9C8 (province_ai_state_addr) {bytecode}, $02
  $E15F  B3                         PUSHL
  $E160  89 FF                      BYTE_LOADL_imm1        -1
  $E162  D4                         BYTE_POPSTORE
 >$E163  0B                         LOADL_quick   ; inline operand = 11
  $E164  D0                         INC
 >$E165  2B                         STORE_quick   ; inline operand = 11
  $E166  0B                         LOADL_quick   ; inline operand = 11
  $E167  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $E16A  C6                         UCMPLT
  $E16B  D7 45 E1                   JUMPT_abs              $E145
 >$E16E  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $E171  E9 1B E2 02                CALL_abs_imm1          $E21B (install_new_daimyo) {bytecode}, $02
  $E175  D6 9C E1                   JUMP_abs               $E19C
 >$E178  3A                         PUSH_quick   ; inline operand = 10
  $E179  AC 7E D7                   CALL_abs               $D77E (ui_helper_d77e) {bytecode}
  $E17C  D4                         BYTE_POPSTORE
  $E17D  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $E180  E9 C8 D9 02                CALL_abs_imm1          $D9C8 (province_ai_state_addr) {bytecode}, $02
  $E184  B3                         PUSHL
  $E185  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $E188  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $E18C  D8 93 E1                   JUMPF_abs              $E193
  $E18F  45                         LOADL_qimm   ; inline operand = 5
  $E190  D6 94 E1                   JUMP_abs               $E194
 >$E193  40                         LOADL_qimm   ; inline operand = 0
 >$E194  D4                         BYTE_POPSTORE
  $E195  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $E198  E9 54 E5 02                CALL_abs_imm1          $E554 (find_record_9e3c) {bytecode}, $02
 >$E19C  08                         LOADL_quick   ; inline operand = 8
  $E19D  D7 C7 E1                   JUMPT_abs              $E1C7
  $E1A0  09                         LOADL_quick   ; inline operand = 9
  $E1A1  D8 C7 E1                   JUMPF_abs              $E1C7
  $E1A4  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $E1A7  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $E1AA  BB                         ADD
  $E1AB  B3                         PUSHL
  $E1AC  A5 65 6F                   BYTE_LOADL_abs         $6F65 (war_side_state_flag)
  $E1AF  57                         LOADR_qimm   ; inline operand = 7
  $E1B0  BF                         SRSHIFT
  $E1B1  D4                         BYTE_POPSTORE
  $E1B2  A4 63 6F                   LOADL_abs              $6F63 (battle_defending_province)
  $E1B5  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $E1B8  BB                         ADD
  $E1B9  D3                         BYTE_DEREF
  $E1BA  B3                         PUSHL
  $E1BB  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $E1BE  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $E1C1  BB                         ADD
  $E1C2  B4                         POPR
  $E1C3  B3                         PUSHL
  $E1C4  D3                         BYTE_DEREF
  $E1C5  DC                         XOR
  $E1C6  D4                         BYTE_POPSTORE
 >$E1C7  89 8F                      BYTE_LOADL_imm1        -113
  $E1C9  CD                         SWAP
  $E1CA  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $E1CD  DA                         AND
  $E1CE  A9 A1 6D                   BYTE_STORE_abs         $6DA1 (ai_turn_flags)
  $E1D1  AC BC DF                   CALL_abs               $DFBC (clamp_field_6d2d_to_30) {bytecode}
  $E1D4  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $E1D7  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
  $E1DB  08                         LOADL_quick   ; inline operand = 8
  $E1DC  D7 E6 E1                   JUMPT_abs              $E1E6
  $E1DF  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $E1E2  E9 36 D8 02                CALL_abs_imm1          $D836 (cap_fief_stats) {bytecode}, $02
 >$E1E6  CF                         RETURN

; ============================================================
; sub $E1E7   (frame_off=-2, body @ $E1EC)
; ============================================================
  $E1EC  8D 1D                      BYTE_PUSH_imm1         +29
  $E1EE  E9 03 CA 02                CALL_abs_imm1          $CA03 (call_bank10_entry) {bytecode}, $02
  $E1F2  40                         LOADL_qimm   ; inline operand = 0
  $E1F3  D6 11 E2                   JUMP_abs               $E211
 >$E1F6  0C                         LOADL_quick   ; inline operand = 12
  $E1F7  8B 36                      BYTE_LOADR_imm1        +54
  $E1F9  B5                         MULT
  $E1FA  1B                         LOADR_quick   ; inline operand = 11
  $E1FB  BB                         ADD
  $E1FC  8C 93 61                   LOADR_imm2             $6193
  $E1FF  BB                         ADD
  $E200  B3                         PUSHL
  $E201  0B                         LOADL_quick   ; inline operand = 11
  $E202  8B 36                      BYTE_LOADR_imm1        +54
  $E204  B5                         MULT
  $E205  1C                         LOADR_quick   ; inline operand = 12
  $E206  BB                         ADD
  $E207  8C 93 61                   LOADR_imm2             $6193
  $E20A  BB                         ADD
  $E20B  B3                         PUSHL
  $E20C  40                         LOADL_qimm   ; inline operand = 0
  $E20D  D4                         BYTE_POPSTORE
  $E20E  D4                         BYTE_POPSTORE
  $E20F  0B                         LOADL_quick   ; inline operand = 11
  $E210  D0                         INC
 >$E211  2B                         STORE_quick   ; inline operand = 11
  $E212  0B                         LOADL_quick   ; inline operand = 11
  $E213  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $E216  C6                         UCMPLT
  $E217  D7 F6 E1                   JUMPT_abs              $E1F6
  $E21A  CF                         RETURN

; ============================================================
; sub $E21B   (frame_off=+0, body @ $E220)
; ============================================================
  $E220  0C                         LOADL_quick   ; inline operand = 12
  $E221  8C 15 6E                   LOADR_imm2             $6E15 (fief_to_daimyo_map)
  $E224  BB                         ADD
  $E225  B3                         PUSHL
  $E226  8E FF 00                   PUSH_imm2              $00FF
  $E229  E9 0E DC 02                CALL_abs_imm1          $DC0E (list_op_6e4a) {bytecode}, $02
  $E22D  D4                         BYTE_POPSTORE
  $E22E  3C                         PUSH_quick   ; inline operand = 12
  $E22F  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $E233  B3                         PUSHL
  $E234  E9 B2 DC 02                CALL_abs_imm1          $DCB2 (generate_daimyo_name) {bytecode}, $02
  $E238  3C                         PUSH_quick   ; inline operand = 12
  $E239  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $E23D  59                         LOADR_qimm   ; inline operand = 9
  $E23E  B5                         MULT
  $E23F  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $E242  BB                         ADD
  $E243  B3                         PUSHL
  $E244  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $E248  0C                         LOADL_quick   ; inline operand = 12
  $E249  D0                         INC
  $E24A  B3                         PUSHL
  $E24B  8E 35 F7                   PUSH_imm2              $F735 (msg_is_now_fief_2d_s_daimyo)
  $E24E  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $E252  0C                         LOADL_quick   ; inline operand = 12
  $E253  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $E256  BB                         ADD
  $E257  B3                         PUSHL
  $E258  40                         LOADL_qimm   ; inline operand = 0
  $E259  D4                         BYTE_POPSTORE
  $E25A  0C                         LOADL_quick   ; inline operand = 12
  $E25B  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $E25E  BB                         ADD
  $E25F  B3                         PUSHL
  $E260  41                         LOADL_qimm   ; inline operand = 1
  $E261  D4                         BYTE_POPSTORE
  $E262  3C                         PUSH_quick   ; inline operand = 12
  $E263  E9 81 DD 02                CALL_abs_imm1          $DD81 (init_new_daimyo_province_stats) {bytecode}, $02
  $E267  3C                         PUSH_quick   ; inline operand = 12
  $E268  E9 97 DB 02                CALL_abs_imm1          $DB97 (assign_unique_daimyo_face_code) {bytecode}, $02
  $E26C  3C                         PUSH_quick   ; inline operand = 12
  $E26D  E9 54 E5 02                CALL_abs_imm1          $E554 (find_record_9e3c) {bytecode}, $02
  $E271  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $E274  CF                         RETURN

; ============================================================
; sub $E275   (frame_off=+0, body @ $E27A)
; ============================================================
  $E27A  3C                         PUSH_quick   ; inline operand = 12
  $E27B  E9 E7 E1 02                CALL_abs_imm1          $E1E7 (clear_fief_pair_6193) {bytecode}, $02
  $E27F  3C                         PUSH_quick   ; inline operand = 12
  $E280  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $E284  59                         LOADR_qimm   ; inline operand = 9
  $E285  B5                         MULT
  $E286  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $E289  BB                         ADD
  $E28A  B3                         PUSHL
  $E28B  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $E28F  8E 4F F7                   PUSH_imm2              $F74F (msg_was_killed)
  $E292  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $E296  3C                         PUSH_quick   ; inline operand = 12
  $E297  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $E29B  D8 AB E2                   JUMPF_abs              $E2AB
  $E29E  AA 9F 6D                   PUSH_abs               $6D9F (current_game_year)
  $E2A1  0C                         LOADL_quick   ; inline operand = 12
  $E2A2  D0                         INC
  $E2A3  B3                         PUSHL
  $E2A4  8E 5B F7                   PUSH_imm2              $F75B (msg_in_fief_2d_in_the_year_d)
  $E2A7  E9 34 D1 06                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $06
 >$E2AB  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $E2AE  CF                         RETURN

; ============================================================
; sub $E2AF   (frame_off=-4, body @ $E2B4)
; ============================================================
  $E2B4  40                         LOADL_qimm   ; inline operand = 0
  $E2B5  2A                         STORE_quick   ; inline operand = 10
  $E2B6  0C                         LOADL_quick   ; inline operand = 12
  $E2B7  55                         LOADR_qimm   ; inline operand = 5
  $E2B8  B5                         MULT
  $E2B9  8C A9 76                   LOADR_imm2             $76A9
  $E2BC  BB                         ADD
  $E2BD  2B                         STORE_quick   ; inline operand = 11
  $E2BE  D6 CF E2                   JUMP_abs               $E2CF
 >$E2C1  0B                         LOADL_quick   ; inline operand = 11
  $E2C2  D0                         INC
  $E2C3  2B                         STORE_quick   ; inline operand = 11
  $E2C4  D1                         DEC
  $E2C5  B3                         PUSHL
  $E2C6  0D                         LOADL_quick   ; inline operand = 13
  $E2C7  D0                         INC
  $E2C8  2D                         STORE_quick   ; inline operand = 13
  $E2C9  D1                         DEC
  $E2CA  D3                         BYTE_DEREF
  $E2CB  D4                         BYTE_POPSTORE
  $E2CC  0A                         LOADL_quick   ; inline operand = 10
  $E2CD  D0                         INC
  $E2CE  2A                         STORE_quick   ; inline operand = 10
 >$E2CF  0A                         LOADL_quick   ; inline operand = 10
  $E2D0  55                         LOADR_qimm   ; inline operand = 5
  $E2D1  C6                         UCMPLT
  $E2D2  D7 C1 E2                   JUMPT_abs              $E2C1
  $E2D5  CF                         RETURN

; ============================================================
; sub $E2D6   (frame_off=+0, body @ $E2DB)
; ============================================================
  $E2DB  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $E2DE  8E 77 F7                   PUSH_imm2              $F777 (msg_lord_f777)
  $E2E1  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $E2E5  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $E2E8  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $E2EC  59                         LOADR_qimm   ; inline operand = 9
  $E2ED  B5                         MULT
  $E2EE  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $E2F1  BB                         ADD
  $E2F2  B3                         PUSHL
  $E2F3  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $E2F7  8E 7D F7                   PUSH_imm2              $F77D (draw_daimyo_name_menu_data_f77d)
  $E2FA  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $E2FE  AC 7E D7                   CALL_abs               $D77E (ui_helper_d77e) {bytecode}
  $E301  59                         LOADR_qimm   ; inline operand = 9
  $E302  B5                         MULT
  $E303  8C A8 77                   LOADR_imm2             $77A8 (daimyo_name_table)
  $E306  BB                         ADD
  $E307  B3                         PUSHL
  $E308  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $E30C  3C                         PUSH_quick   ; inline operand = 12
  $E30D  8E 7F F7                   PUSH_imm2              $F77F (msg_wants_a_s)
  $E310  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $E314  CF                         RETURN

; ============================================================
; sub $E315   (frame_off=-6, body @ $E31A)
; ============================================================
  $E31A  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $E31D  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $E321  D8 61 E3                   JUMPF_abs              $E361
  $E324  A4 D3 7F                   LOADL_abs              $7FD3 (ui_input_mode)
  $E327  29                         STORE_quick   ; inline operand = 9
  $E328  42                         LOADL_qimm   ; inline operand = 2
  $E329  A8 D3 7F                   STORE_abs              $7FD3 (ui_input_mode)
  $E32C  8E 98 F7                   PUSH_imm2              $F798 (msg_marriage_pact)
  $E32F  E9 D6 E2 02                CALL_abs_imm1          $E2D6 (draw_daimyo_name_menu) {bytecode}, $02
  $E333  8E A6 F7                   PUSH_imm2              $F7A6 (msg_accept)
  $E336  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $E33A  AC A7 D3                   CALL_abs               $D3A7 (ui_helper_d3a7) {bytecode}
  $E33D  D8 59 E3                   JUMPF_abs              $E359
  $E340  8E 8C F7                   PUSH_imm2              $F78C (msg_demand_gold)
  $E343  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $E347  8E 0F 27                   PUSH_imm2              $270F
  $E34A  61                         PUSH_qimm   ; inline operand = 1
  $E34B  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $E34F  2B                         STORE_quick   ; inline operand = 11
  $E350  D7 5B E3                   JUMPT_abs              $E35B
  $E353  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
  $E356  D6 5B E3                   JUMP_abs               $E35B
 >$E359  40                         LOADL_qimm   ; inline operand = 0
  $E35A  2B                         STORE_quick   ; inline operand = 11
 >$E35B  09                         LOADL_quick   ; inline operand = 9
  $E35C  A8 D3 7F                   STORE_abs              $7FD3 (ui_input_mode)
  $E35F  0B                         LOADL_quick   ; inline operand = 11
  $E360  CF                         RETURN
 >$E361  AA 63 6D                   PUSH_abs               $6D63 (const_two)
  $E364  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $E368  D7 A2 E3                   JUMPT_abs              $E3A2
  $E36B  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $E36E  E9 72 D9 02                CALL_abs_imm1          $D972 (war_helper_d972) {bytecode}, $02
  $E372  D8 7D E3                   JUMPF_abs              $E37D
  $E375  63                         PUSH_qimm   ; inline operand = 3
  $E376  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $E37A  D7 A2 E3                   JUMPT_abs              $E3A2
 >$E37D  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $E380  8B 1A                      BYTE_LOADR_imm1        +26
  $E382  B5                         MULT
  $E383  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $E386  BB                         ADD
  $E387  B0                         DEREF
  $E388  2A                         STORE_quick   ; inline operand = 10
  $E389  8C C8 00                   LOADR_imm2             $00C8
  $E38C  C4                         SCMPGT
  $E38D  D8 A2 E3                   JUMPF_abs              $E3A2
  $E390  8D 1E                      BYTE_PUSH_imm1         +30
  $E392  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $E396  8F 32                      BYTE_ADD_imm1          +50
  $E398  B3                         PUSHL
  $E399  3A                         PUSH_quick   ; inline operand = 10
  $E39A  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $E39E  90 C8 00                   ADD_imm2               $00C8
  $E3A1  CF                         RETURN
 >$E3A2  40                         LOADL_qimm   ; inline operand = 0
  $E3A3  CF                         RETURN

; ============================================================
; sub $E3A4   (frame_off=-6, body @ $E3A9)
; ============================================================
  $E3A9  AA 63 6F                   PUSH_abs               $6F63 (battle_defending_province)
  $E3AC  E9 8D D9 02                CALL_abs_imm1          $D98D (get_province_ai_state) {bytecode}, $02
  $E3B0  D8 DE E3                   JUMPF_abs              $E3DE
  $E3B3  A4 D3 7F                   LOADL_abs              $7FD3 (ui_input_mode)
  $E3B6  29                         STORE_quick   ; inline operand = 9
  $E3B7  42                         LOADL_qimm   ; inline operand = 2
  $E3B8  A8 D3 7F                   STORE_abs              $7FD3 (ui_input_mode)
  $E3BB  8E AD F7                   PUSH_imm2              $F7AD (msg_pact)
  $E3BE  E9 D6 E2 02                CALL_abs_imm1          $E2D6 (draw_daimyo_name_menu) {bytecode}, $02
  $E3C2  8E 8C F7                   PUSH_imm2              $F78C (msg_demand_gold)
  $E3C5  E9 C4 CE 02                CALL_abs_imm1          $CEC4 (redraw_window) {bytecode}, $02
  $E3C9  8E 0F 27                   PUSH_imm2              $270F
  $E3CC  61                         PUSH_qimm   ; inline operand = 1
  $E3CD  E9 E9 D5 04                CALL_abs_imm1          $D5E9 (number_input) {bytecode}, $04
  $E3D1  2B                         STORE_quick   ; inline operand = 11
  $E3D2  D7 D8 E3                   JUMPT_abs              $E3D8
  $E3D5  AC 89 CC                   CALL_abs               $CC89 (open_message_window) {bytecode}
 >$E3D8  09                         LOADL_quick   ; inline operand = 9
  $E3D9  A8 D3 7F                   STORE_abs              $7FD3 (ui_input_mode)
  $E3DC  0B                         LOADL_quick   ; inline operand = 11
  $E3DD  CF                         RETURN
 >$E3DE  AA 5F 6F                   PUSH_abs               $6F5F (selected_province_idx)
  $E3E1  E9 72 D9 02                CALL_abs_imm1          $D972 (war_helper_d972) {bytecode}, $02
  $E3E5  D8 F0 E3                   JUMPF_abs              $E3F0
  $E3E8  63                         PUSH_qimm   ; inline operand = 3
  $E3E9  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $E3ED  D7 23 E4                   JUMPT_abs              $E423
 >$E3F0  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $E3F3  8B 1A                      BYTE_LOADR_imm1        +26
  $E3F5  B5                         MULT
  $E3F6  8C 01 70                   LOADR_imm2             $7001 (province_table_live)
  $E3F9  BB                         ADD
  $E3FA  B0                         DEREF
  $E3FB  2A                         STORE_quick   ; inline operand = 10
  $E3FC  AA 63 6D                   PUSH_abs               $6D63 (const_two)
  $E3FF  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $E403  D7 21 E4                   JUMPT_abs              $E421
  $E406  8D 32                      BYTE_PUSH_imm1         +50
  $E408  E9 52 CA 02                CALL_abs_imm1          $CA52 (rng_mod) {bytecode}, $02
  $E40C  B3                         PUSHL
  $E40D  3A                         PUSH_quick   ; inline operand = 10
  $E40E  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $E412  B3                         PUSHL
  $E413  8D 32                      BYTE_PUSH_imm1         +50
  $E415  3A                         PUSH_quick   ; inline operand = 10
  $E416  E9 0D D7 04                CALL_abs_imm1          $D70D (pct_op) {bytecode}, $04
  $E41A  B4                         POPR
  $E41B  BB                         ADD
  $E41C  8F 14                      BYTE_ADD_imm1          +20
  $E41E  D6 22 E4                   JUMP_abs               $E422
 >$E421  40                         LOADL_qimm   ; inline operand = 0
 >$E422  CF                         RETURN
 >$E423  40                         LOADL_qimm   ; inline operand = 0
  $E424  CF                         RETURN

; ============================================================
; sub $E425   (frame_off=-2, body @ $E42A)
; ============================================================
  $E42A  3C                         PUSH_quick   ; inline operand = 12
  $E42B  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $E42F  2C                         STORE_quick   ; inline operand = 12
  $E430  3C                         PUSH_quick   ; inline operand = 12
  $E431  E9 3C DC 02                CALL_abs_imm1          $DC3C (list_remove_6e7f) {bytecode}, $02
  $E435  40                         LOADL_qimm   ; inline operand = 0
  $E436  D6 4A E4                   JUMP_abs               $E44A
 >$E439  3B                         PUSH_quick   ; inline operand = 11
  $E43A  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $E43E  1C                         LOADR_quick   ; inline operand = 12
  $E43F  C0                         CMPEQ
  $E440  D8 48 E4                   JUMPF_abs              $E448
  $E443  3B                         PUSH_quick   ; inline operand = 11
  $E444  E9 54 E4 02                CALL_abs_imm1          $E454 (neutralize_fief) {bytecode}, $02
 >$E448  0B                         LOADL_quick   ; inline operand = 11
  $E449  D0                         INC
 >$E44A  2B                         STORE_quick   ; inline operand = 11
  $E44B  0B                         LOADL_quick   ; inline operand = 11
  $E44C  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $E44F  C6                         UCMPLT
  $E450  D7 39 E4                   JUMPT_abs              $E439
  $E453  CF                         RETURN

; ============================================================
; sub $E454   (frame_off=+0, body @ $E459)
; ============================================================
  $E459  0C                         LOADL_quick   ; inline operand = 12
  $E45A  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $E45D  BB                         ADD
  $E45E  D3                         BYTE_DEREF
  $E45F  8C FF 00                   LOADR_imm2             $00FF
  $E462  C1                         CMPNE
  $E463  D8 A1 E4                   JUMPF_abs              $E4A1
  $E466  8E B2 F7                   PUSH_imm2              $F7B2 (msg_fief_f7b2)
  $E469  E9 26 D3 02                CALL_abs_imm1          $D326 (message_display) {bytecode}, $02
  $E46D  0C                         LOADL_quick   ; inline operand = 12
  $E46E  D0                         INC
  $E46F  B3                         PUSHL
  $E470  8E B8 F7                   PUSH_imm2              $F7B8 (msg_d_lost_its_leader)
  $E473  E9 34 D1 04                CALL_abs_imm1          $D134 (draw_message) {bytecode}, $04
  $E477  AC 66 D7                   CALL_abs               $D766 (confirm_prompt) {bytecode}
  $E47A  0C                         LOADL_quick   ; inline operand = 12
  $E47B  8C F7 6C                   LOADR_imm2             $6CF7 (province_ai_state)
  $E47E  BB                         ADD
  $E47F  B3                         PUSHL
  $E480  89 FF                      BYTE_LOADL_imm1        -1
  $E482  D4                         BYTE_POPSTORE
  $E483  0C                         LOADL_quick   ; inline operand = 12
  $E484  8C A2 6D                   LOADR_imm2             $6DA2 (fief_is_daimyo_capital)
  $E487  BB                         ADD
  $E488  B3                         PUSHL
  $E489  40                         LOADL_qimm   ; inline operand = 0
  $E48A  D4                         BYTE_POPSTORE
  $E48B  0C                         LOADL_quick   ; inline operand = 12
  $E48C  8C 2D 6D                   LOADR_imm2             $6D2D (fief_tax_rate)
  $E48F  BB                         ADD
  $E490  B3                         PUSHL
  $E491  89 14                      BYTE_LOADL_imm1        +20
  $E493  D4                         BYTE_POPSTORE
  $E494  8E A3 77                   PUSH_imm2              $77A3
  $E497  3C                         PUSH_quick   ; inline operand = 12
  $E498  E9 AF E2 04                CALL_abs_imm1          $E2AF (copy_arms_record_5) {bytecode}, $04
  $E49C  3C                         PUSH_quick   ; inline operand = 12
  $E49D  E9 54 E5 02                CALL_abs_imm1          $E554 (find_record_9e3c) {bytecode}, $02
 >$E4A1  CF                         RETURN

; ============================================================
; sub $E4A2   (frame_off=-4, body @ $E4A7)
; ============================================================
  $E4A7  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $E4AA  2A                         STORE_quick   ; inline operand = 10
  $E4AB  8A 89 6F                   LOADL_imm2             $6F89
  $E4AE  2B                         STORE_quick   ; inline operand = 11
  $E4AF  40                         LOADL_qimm   ; inline operand = 0
  $E4B0  D6 C6 E4                   JUMP_abs               $E4C6
 >$E4B3  AC A9 D9                   CALL_abs               $D9A9 (get_6da2_cur) {bytecode}
  $E4B6  D8 C2 E4                   JUMPF_abs              $E4C2
  $E4B9  0B                         LOADL_quick   ; inline operand = 11
  $E4BA  D0                         INC
  $E4BB  2B                         STORE_quick   ; inline operand = 11
  $E4BC  D1                         DEC
  $E4BD  B3                         PUSHL
  $E4BE  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $E4C1  D4                         BYTE_POPSTORE
 >$E4C2  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $E4C5  D0                         INC
 >$E4C6  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $E4C9  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $E4CC  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $E4CF  C6                         UCMPLT
  $E4D0  D7 B3 E4                   JUMPT_abs              $E4B3
  $E4D3  3B                         PUSH_quick   ; inline operand = 11
  $E4D4  89 FF                      BYTE_LOADL_imm1        -1
  $E4D6  D4                         BYTE_POPSTORE
  $E4D7  0A                         LOADL_quick   ; inline operand = 10
  $E4D8  A8 5F 6F                   STORE_abs              $6F5F (selected_province_idx)
  $E4DB  CF                         RETURN

; ============================================================
; sub $E4DC   (frame_off=-4, body @ $E4E1)
; ============================================================
  $E4E1  AC A2 E4                   CALL_abs               $E4A2 (build_owned_fief_list_6f89) {bytecode}
  $E4E4  8A 89 6F                   LOADL_imm2             $6F89
  $E4E7  2A                         STORE_quick   ; inline operand = 10
  $E4E8  D6 01 E5                   JUMP_abs               $E501
 >$E4EB  0B                         LOADL_quick   ; inline operand = 11
  $E4EC  D3                         BYTE_DEREF
  $E4ED  B3                         PUSHL
  $E4EE  E9 72 D7 02                CALL_abs_imm1          $D772 (fief_owner) {bytecode}, $02
  $E4F2  1C                         LOADR_quick   ; inline operand = 12
  $E4F3  C1                         CMPNE
  $E4F4  D8 FF E4                   JUMPF_abs              $E4FF
  $E4F7  0A                         LOADL_quick   ; inline operand = 10
  $E4F8  D0                         INC
  $E4F9  2A                         STORE_quick   ; inline operand = 10
  $E4FA  D1                         DEC
  $E4FB  B3                         PUSHL
  $E4FC  0B                         LOADL_quick   ; inline operand = 11
  $E4FD  D3                         BYTE_DEREF
  $E4FE  D4                         BYTE_POPSTORE
 >$E4FF  0B                         LOADL_quick   ; inline operand = 11
  $E500  D0                         INC
 >$E501  2B                         STORE_quick   ; inline operand = 11
  $E502  0B                         LOADL_quick   ; inline operand = 11
  $E503  D3                         BYTE_DEREF
  $E504  8C FF 00                   LOADR_imm2             $00FF
  $E507  C1                         CMPNE
  $E508  D7 EB E4                   JUMPT_abs              $E4EB
  $E50B  3A                         PUSH_quick   ; inline operand = 10
  $E50C  89 FF                      BYTE_LOADL_imm1        -1
  $E50E  D4                         BYTE_POPSTORE
  $E50F  CF                         RETURN

; ============================================================
; sub $E510   (frame_off=-6, body @ $E515)
; ============================================================
  $E515  8A 89 6F                   LOADL_imm2             $6F89
  $E518  29                         STORE_quick   ; inline operand = 9
  $E519  40                         LOADL_qimm   ; inline operand = 0
  $E51A  2A                         STORE_quick   ; inline operand = 10
  $E51B  40                         LOADL_qimm   ; inline operand = 0
  $E51C  D6 45 E5                   JUMP_abs               $E545
 >$E51F  3B                         PUSH_quick   ; inline operand = 11
  $E520  E9 99 D9 02                CALL_abs_imm1          $D999 (province_state_is_FF) {bytecode}, $02
  $E524  D7 43 E5                   JUMPT_abs              $E543
  $E527  3B                         PUSH_quick   ; inline operand = 11
  $E528  E9 B7 D9 02                CALL_abs_imm1          $D9B7 (is_enemy_owned) {bytecode}, $02
  $E52C  1C                         LOADR_quick   ; inline operand = 12
  $E52D  DC                         XOR
  $E52E  D7 43 E5                   JUMPT_abs              $E543
  $E531  A4 5F 6F                   LOADL_abs              $6F5F (selected_province_idx)
  $E534  1B                         LOADR_quick   ; inline operand = 11
  $E535  C1                         CMPNE
  $E536  D8 43 E5                   JUMPF_abs              $E543
  $E539  09                         LOADL_quick   ; inline operand = 9
  $E53A  D0                         INC
  $E53B  29                         STORE_quick   ; inline operand = 9
  $E53C  D1                         DEC
  $E53D  B3                         PUSHL
  $E53E  0B                         LOADL_quick   ; inline operand = 11
  $E53F  D4                         BYTE_POPSTORE
  $E540  0A                         LOADL_quick   ; inline operand = 10
  $E541  D0                         INC
  $E542  2A                         STORE_quick   ; inline operand = 10
 >$E543  0B                         LOADL_quick   ; inline operand = 11
  $E544  D0                         INC
 >$E545  2B                         STORE_quick   ; inline operand = 11
  $E546  0B                         LOADL_quick   ; inline operand = 11
  $E547  A6 9D 6D                   LOADR_abs              $6D9D (scenario_fief_count)
  $E54A  C6                         UCMPLT
  $E54B  D7 1F E5                   JUMPT_abs              $E51F
  $E54E  39                         PUSH_quick   ; inline operand = 9
  $E54F  89 FF                      BYTE_LOADL_imm1        -1
  $E551  D4                         BYTE_POPSTORE
  $E552  0A                         LOADL_quick   ; inline operand = 10
  $E553  CF                         RETURN

; ============================================================
; sub $E554   (frame_off=-40, body @ $E559)
; ============================================================
  $E559  A4 5D 6F                   LOADL_abs              $6F5D (selected_record_idx_9e3c)
  $E55C  58                         LOADR_qimm   ; inline operand = 8
  $E55D  C7                         UCMPLE
  $E55E  D8 94 E5                   JUMPF_abs              $E594
  $E561  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $E564  2B                         STORE_quick   ; inline operand = 11
  $E565  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $E568  2A                         STORE_quick   ; inline operand = 10
  $E569  8D 22                      BYTE_PUSH_imm1         +34
  $E56B  DE DA FF                   LEAL_far               $FFDA
  $E56E  B3                         PUSHL
  $E56F  A4 5D 6F                   LOADL_abs              $6F5D (selected_record_idx_9e3c)
  $E572  8B 22                      BYTE_LOADR_imm1        +34
  $E574  B5                         MULT
  $E575  8C 3C 9E                   LOADR_imm2             $9E3C (find_record_data_9e3c)
  $E578  BB                         ADD
  $E579  B3                         PUSHL
  $E57A  64                         PUSH_qimm   ; inline operand = 4
  $E57B  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $E57F  DE DA FF                   LEAL_far               $FFDA
  $E582  85 D8                      STORE_near             $D8
 >$E584  81 D8                      LOADL_near             $D8
  $E586  D3                         BYTE_DEREF
  $E587  8C FF 00                   LOADR_imm2             $00FF
  $E58A  C1                         CMPNE
  $E58B  D7 95 E5                   JUMPT_abs              $E595
 >$E58E  3A                         PUSH_quick   ; inline operand = 10
  $E58F  3B                         PUSH_quick   ; inline operand = 11
  $E590  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
 >$E594  CF                         RETURN
 >$E595  81 D8                      LOADL_near             $D8
  $E597  D0                         INC
  $E598  85 D8                      STORE_near             $D8
  $E59A  D1                         DEC
  $E59B  D3                         BYTE_DEREF
  $E59C  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $E59F  81 D8                      LOADL_near             $D8
  $E5A1  D0                         INC
  $E5A2  85 D8                      STORE_near             $D8
  $E5A4  D1                         DEC
  $E5A5  D3                         BYTE_DEREF
  $E5A6  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $E5A9  81 D8                      LOADL_near             $D8
  $E5AB  D0                         INC
  $E5AC  85 D8                      STORE_near             $D8
  $E5AE  D1                         DEC
  $E5AF  D3                         BYTE_DEREF
  $E5B0  1C                         LOADR_quick   ; inline operand = 12
  $E5B1  C0                         CMPEQ
  $E5B2  D8 84 E5                   JUMPF_abs              $E584
  $E5B5  64                         PUSH_qimm   ; inline operand = 4
  $E5B6  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $E5B9  8F FC                      BYTE_ADD_imm1          -4
  $E5BB  8B 1C                      BYTE_LOADR_imm1        +28
  $E5BD  B5                         MULT
  $E5BE  B3                         PUSHL
  $E5BF  A4 5D 6F                   LOADL_abs              $6F5D (selected_record_idx_9e3c)
  $E5C2  8C C0 01                   LOADR_imm2             $01C0
  $E5C5  B5                         MULT
  $E5C6  B4                         POPR
  $E5C7  BB                         ADD
  $E5C8  A6 CD 7F                   LOADR_abs              $7FCD (ui_window_col)
  $E5CB  BB                         ADD
  $E5CC  8C 5A 8D                   LOADR_imm2             $8D5A (find_record_data_8d5a)
  $E5CF  BB                         ADD
  $E5D0  B3                         PUSHL
  $E5D1  AA CF 7F                   PUSH_abs               $7FCF (ui_cursor_row)
  $E5D4  8D 1D                      BYTE_PUSH_imm1         +29
  $E5D6  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $E5D9  78                         ADD_qimm   ; inline operand = 8
  $E5DA  B3                         PUSHL
  $E5DB  E9 5E CB 04                CALL_abs_imm1          $CB5E (min_word) {bytecode}, $04
  $E5DF  B3                         PUSHL
  $E5E0  AA CF 7F                   PUSH_abs               $7FCF (ui_cursor_row)
  $E5E3  AA CD 7F                   PUSH_abs               $7FCD (ui_window_col)
  $E5E6  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_blit_from_bank_wrap) {bytecode}, $0C
  $E5EA  3C                         PUSH_quick   ; inline operand = 12
  $E5EB  E9 6E DB 02                CALL_abs_imm1          $DB6E (draw_window_f706) {bytecode}, $02
  $E5EF  D6 8E E5                   JUMP_abs               $E58E

; ============================================================
; sub $E5F2   (frame_off=-40, body @ $E5F7)
; ============================================================
  $E5F7  0C                         LOADL_quick   ; inline operand = 12
  $E5F8  A6 5D 6F                   LOADR_abs              $6F5D (selected_record_idx_9e3c)
  $E5FB  C1                         CMPNE
  $E5FC  D8 93 E6                   JUMPF_abs              $E693
  $E5FF  61                         PUSH_qimm   ; inline operand = 1
  $E600  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
  $E604  61                         PUSH_qimm   ; inline operand = 1
  $E605  8D 13                      BYTE_PUSH_imm1         +19
  $E607  8D 1F                      BYTE_PUSH_imm1         +31
  $E609  64                         PUSH_qimm   ; inline operand = 4
  $E60A  8D 1E                      BYTE_PUSH_imm1         +30
  $E60C  E9 42 CC 0A                CALL_abs_imm1          $CC42 (ppu_blit_nobank_wrap) {bytecode}, $0A
  $E610  64                         PUSH_qimm   ; inline operand = 4
  $E611  0C                         LOADL_quick   ; inline operand = 12
  $E612  8C C0 01                   LOADR_imm2             $01C0
  $E615  B5                         MULT
  $E616  8C 5C 8D                   LOADR_imm2             $8D5C (strategic_map_section_tilemaps)
  $E619  BB                         ADD
  $E61A  B3                         PUSHL
  $E61B  8D 13                      BYTE_PUSH_imm1         +19
  $E61D  8D 1D                      BYTE_PUSH_imm1         +29
  $E61F  64                         PUSH_qimm   ; inline operand = 4
  $E620  62                         PUSH_qimm   ; inline operand = 2
  $E621  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_blit_from_bank_wrap) {bytecode}, $0C
  $E625  62                         PUSH_qimm   ; inline operand = 2
  $E626  8E C8 23                   PUSH_imm2              $23C8
  $E629  0C                         LOADL_quick   ; inline operand = 12
  $E62A  55                         LOADR_qimm   ; inline operand = 5
  $E62B  BD                         LSHIFT
  $E62C  8C 1C 9D                   LOADR_imm2             $9D1C (strategic_map_section_attributes)
  $E62F  BB                         ADD
  $E630  B3                         PUSHL
  $E631  64                         PUSH_qimm   ; inline operand = 4
  $E632  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $E636  0C                         LOADL_quick   ; inline operand = 12
  $E637  A8 5D 6F                   STORE_abs              $6F5D (selected_record_idx_9e3c)
  $E63A  A4 CD 7F                   LOADL_abs              $7FCD (ui_window_col)
  $E63D  2B                         STORE_quick   ; inline operand = 11
  $E63E  A4 CF 7F                   LOADL_abs              $7FCF (ui_cursor_row)
  $E641  2A                         STORE_quick   ; inline operand = 10
  $E642  8D 22                      BYTE_PUSH_imm1         +34
  $E644  DE DA FF                   LEAL_far               $FFDA
  $E647  B3                         PUSHL
  $E648  0C                         LOADL_quick   ; inline operand = 12
  $E649  8B 22                      BYTE_LOADR_imm1        +34
  $E64B  B5                         MULT
  $E64C  8C 3C 9E                   LOADR_imm2             $9E3C (find_record_data_9e3c)
  $E64F  BB                         ADD
  $E650  B3                         PUSHL
  $E651  64                         PUSH_qimm   ; inline operand = 4
  $E652  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $E656  DE DA FF                   LEAL_far               $FFDA
  $E659  85 D8                      STORE_near             $D8
  $E65B  D6 7E E6                   JUMP_abs               $E67E
 >$E65E  81 D8                      LOADL_near             $D8
  $E660  D0                         INC
  $E661  85 D8                      STORE_near             $D8
  $E663  D1                         DEC
  $E664  D3                         BYTE_DEREF
  $E665  A8 CD 7F                   STORE_abs              $7FCD (ui_window_col)
  $E668  81 D8                      LOADL_near             $D8
  $E66A  D0                         INC
  $E66B  85 D8                      STORE_near             $D8
  $E66D  D1                         DEC
  $E66E  D3                         BYTE_DEREF
  $E66F  A8 CF 7F                   STORE_abs              $7FCF (ui_cursor_row)
  $E672  81 D8                      LOADL_near             $D8
  $E674  D0                         INC
  $E675  85 D8                      STORE_near             $D8
  $E677  D1                         DEC
  $E678  D3                         BYTE_DEREF
  $E679  B3                         PUSHL
  $E67A  E9 6E DB 02                CALL_abs_imm1          $DB6E (draw_window_f706) {bytecode}, $02
 >$E67E  81 D8                      LOADL_near             $D8
  $E680  D3                         BYTE_DEREF
  $E681  8C FF 00                   LOADR_imm2             $00FF
  $E684  C1                         CMPNE
  $E685  D7 5E E6                   JUMPT_abs              $E65E
  $E688  3A                         PUSH_quick   ; inline operand = 10
  $E689  3B                         PUSH_quick   ; inline operand = 11
  $E68A  E9 7B CC 04                CALL_abs_imm1          $CC7B (set_cursor) {bytecode}, $04
  $E68E  60                         PUSH_qimm   ; inline operand = 0
  $E68F  E9 35 CC 02                CALL_abs_imm1          $CC35 (marry_helper_cc35) {bytecode}, $02
 >$E693  CF                         RETURN

; ============================================================
; sub $E694   (frame_off=+0, body @ $E699)
; ============================================================
  $E699  A4 9D 6D                   LOADL_abs              $6D9D (scenario_fief_count)
  $E69C  8B 32                      BYTE_LOADR_imm1        +50
  $E69E  C0                         CMPEQ
  $E69F  D8 AB E6                   JUMPF_abs              $E6AB
  $E6A2  A4 DD 7F                   LOADL_abs              $7FDD (selected_province_idx_latch_7fdd)
  $E6A5  8C A6 FE                   LOADR_imm2             $FEA6 (province_to_map_section_50)
  $E6A8  D6 B1 E6                   JUMP_abs               $E6B1
 >$E6AB  A4 DD 7F                   LOADL_abs              $7FDD (selected_province_idx_latch_7fdd)
  $E6AE  8C D8 FE                   LOADR_imm2             $FED8 (province_to_map_section_17)
 >$E6B1  BB                         ADD
  $E6B2  D3                         BYTE_DEREF
  $E6B3  B3                         PUSHL
  $E6B4  E9 F2 E5 02                CALL_abs_imm1          $E5F2 (map_helper_e5f2) {bytecode}, $02
  $E6B8  CF                         RETURN

; ============================================================
; sub $E6B9   (frame_off=-10, body @ $E6BE)
; ============================================================
  $E6BE  A4 5B 6F                   LOADL_abs              $6F5B (active_province_idx_copy)
  $E6C1  D2                         LSHIFT1
  $E6C2  8C B1 6E                   LOADR_imm2             $6EB1 (daimyo_face_code_table)
  $E6C5  BB                         ADD
  $E6C6  B0                         DEREF
  $E6C7  2B                         STORE_quick   ; inline operand = 11
  $E6C8  0B                         LOADL_quick   ; inline operand = 11
  $E6C9  55                         LOADR_qimm   ; inline operand = 5
  $E6CA  B8                         UDIV
  $E6CB  29                         STORE_quick   ; inline operand = 9
  $E6CC  0B                         LOADL_quick   ; inline operand = 11
  $E6CD  55                         LOADR_qimm   ; inline operand = 5
  $E6CE  BA                         UMOD
  $E6CF  2A                         STORE_quick   ; inline operand = 10
  $E6D0  09                         LOADL_quick   ; inline operand = 9
  $E6D1  55                         LOADR_qimm   ; inline operand = 5
  $E6D2  B8                         UDIV
  $E6D3  28                         STORE_quick   ; inline operand = 8
  $E6D4  09                         LOADL_quick   ; inline operand = 9
  $E6D5  55                         LOADR_qimm   ; inline operand = 5
  $E6D6  BA                         UMOD
  $E6D7  29                         STORE_quick   ; inline operand = 9
  $E6D8  08                         LOADL_quick   ; inline operand = 8
  $E6D9  55                         LOADR_qimm   ; inline operand = 5
  $E6DA  B8                         UDIV
  $E6DB  27                         STORE_quick   ; inline operand = 7
  $E6DC  08                         LOADL_quick   ; inline operand = 8
  $E6DD  55                         LOADR_qimm   ; inline operand = 5
  $E6DE  BA                         UMOD
  $E6DF  28                         STORE_quick   ; inline operand = 8
  $E6E0  6C                         PUSH_qimm   ; inline operand = 12
  $E6E1  8E B0 15                   PUSH_imm2              $15B0
  $E6E4  0A                         LOADL_quick   ; inline operand = 10
  $E6E5  8C C0 00                   LOADR_imm2             $00C0
  $E6E8  B5                         MULT
  $E6E9  8C 04 A6                   LOADR_imm2             $A604 (unpack_record_to_sram_data_a604)
  $E6EC  BB                         ADD
  $E6ED  B3                         PUSHL
  $E6EE  68                         PUSH_qimm   ; inline operand = 8
  $E6EF  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $E6F3  66                         PUSH_qimm   ; inline operand = 6
  $E6F4  8E 70 16                   PUSH_imm2              $1670
  $E6F7  09                         LOADL_quick   ; inline operand = 9
  $E6F8  8B 60                      BYTE_LOADR_imm1        +96
  $E6FA  B5                         MULT
  $E6FB  8C C4 A9                   LOADR_imm2             $A9C4
  $E6FE  BB                         ADD
  $E6FF  B3                         PUSHL
  $E700  68                         PUSH_qimm   ; inline operand = 8
  $E701  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $E705  66                         PUSH_qimm   ; inline operand = 6
  $E706  8E D0 16                   PUSH_imm2              $16D0
  $E709  08                         LOADL_quick   ; inline operand = 8
  $E70A  8B 60                      BYTE_LOADR_imm1        +96
  $E70C  B5                         MULT
  $E70D  8C A4 AB                   LOADR_imm2             $ABA4 (unpack_record_to_sram_data_aba4)
  $E710  BB                         ADD
  $E711  B3                         PUSHL
  $E712  68                         PUSH_qimm   ; inline operand = 8
  $E713  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $E717  6C                         PUSH_qimm   ; inline operand = 12
  $E718  8E 30 17                   PUSH_imm2              $1730
  $E71B  07                         LOADL_quick   ; inline operand = 7
  $E71C  8C C0 00                   LOADR_imm2             $00C0
  $E71F  B5                         MULT
  $E720  8C 84 AD                   LOADR_imm2             $AD84 (unpack_record_to_sram_data_ad84)
  $E723  BB                         ADD
  $E724  B3                         PUSHL
  $E725  68                         PUSH_qimm   ; inline operand = 8
  $E726  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $E72A  6C                         PUSH_qimm   ; inline operand = 12
  $E72B  3C                         PUSH_quick   ; inline operand = 12
  $E72C  0A                         LOADL_quick   ; inline operand = 10
  $E72D  5C                         LOADR_qimm   ; inline operand = 12
  $E72E  B5                         MULT
  $E72F  8C 34 AE                   LOADR_imm2             $AE34 (unpack_record_to_sram_data_ae34)
  $E732  BB                         ADD
  $E733  B3                         PUSHL
  $E734  69                         PUSH_qimm   ; inline operand = 9
  $E735  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $E739  66                         PUSH_qimm   ; inline operand = 6
  $E73A  0C                         LOADL_quick   ; inline operand = 12
  $E73B  7C                         ADD_qimm   ; inline operand = 12
  $E73C  B3                         PUSHL
  $E73D  09                         LOADL_quick   ; inline operand = 9
  $E73E  56                         LOADR_qimm   ; inline operand = 6
  $E73F  B5                         MULT
  $E740  8C 70 AE                   LOADR_imm2             $AE70 (unpack_record_to_sram_data_ae70)
  $E743  BB                         ADD
  $E744  B3                         PUSHL
  $E745  69                         PUSH_qimm   ; inline operand = 9
  $E746  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $E74A  66                         PUSH_qimm   ; inline operand = 6
  $E74B  0C                         LOADL_quick   ; inline operand = 12
  $E74C  8F 12                      BYTE_ADD_imm1          +18
  $E74E  B3                         PUSHL
  $E74F  08                         LOADL_quick   ; inline operand = 8
  $E750  56                         LOADR_qimm   ; inline operand = 6
  $E751  B5                         MULT
  $E752  8C 8E AE                   LOADR_imm2             $AE8E (unpack_record_to_sram_data_ae8e)
  $E755  BB                         ADD
  $E756  B3                         PUSHL
  $E757  69                         PUSH_qimm   ; inline operand = 9
  $E758  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $E75C  6C                         PUSH_qimm   ; inline operand = 12
  $E75D  0C                         LOADL_quick   ; inline operand = 12
  $E75E  8F 18                      BYTE_ADD_imm1          +24
  $E760  B3                         PUSHL
  $E761  07                         LOADL_quick   ; inline operand = 7
  $E762  5C                         LOADR_qimm   ; inline operand = 12
  $E763  B5                         MULT
  $E764  8C AC AE                   LOADR_imm2             $AEAC (unpack_record_to_sram_data_aeac)
  $E767  BB                         ADD
  $E768  B3                         PUSHL
  $E769  69                         PUSH_qimm   ; inline operand = 9
  $E76A  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $E76E  CF                         RETURN

; ============================================================
; sub $E76F   (frame_off=-44, body @ $E774)
; ============================================================
  $E774  40                         LOADL_qimm   ; inline operand = 0
  $E775  85 DA                      STORE_near             $DA
 >$E777  81 DA                      LOADL_near             $DA
  $E779  D2                         LSHIFT1
  $E77A  8C CC F7                   LOADR_imm2             $F7CC (marry_helper_data_f7cc)
  $E77D  BB                         ADD
  $E77E  B0                         DEREF
  $E77F  B3                         PUSHL
  $E780  87 DA                      PUSH_near              $DA
  $E782  E9 8B CF 04                CALL_abs_imm1          $CF8B (palette_write_wrap) {bytecode}, $04
  $E786  81 DA                      LOADL_near             $DA
  $E788  D0                         INC
  $E789  85 DA                      STORE_near             $DA
  $E78B  81 DA                      LOADL_near             $DA
  $E78D  54                         LOADR_qimm   ; inline operand = 4
  $E78E  C6                         UCMPLT
  $E78F  D7 77 E7                   JUMPT_abs              $E777
  $E792  A4 5B 6F                   LOADL_abs              $6F5B (active_province_idx_copy)
  $E795  8B 35                      BYTE_LOADR_imm1        +53
  $E797  C9                         UCMPGE
  $E798  D7 A7 E7                   JUMPT_abs              $E7A7
  $E79B  AA 5B 6F                   PUSH_abs               $6F5B (active_province_idx_copy)
  $E79E  E9 CD D7 02                CALL_abs_imm1          $D7CD (daimyo_record_addr) {bytecode}, $02
  $E7A2  76                         ADD_qimm   ; inline operand = 6
  $E7A3  D3                         BYTE_DEREF
  $E7A4  D7 EE E7                   JUMPT_abs              $E7EE
 >$E7A7  AA 5B 6F                   PUSH_abs               $6F5B (active_province_idx_copy)
  $E7AA  E9 66 DC 02                CALL_abs_imm1          $DC66 (fief_to_mapid) {bytecode}, $02
  $E7AE  D2                         LSHIFT1
  $E7AF  D2                         LSHIFT1
  $E7B0  8C D0 BB                   LOADR_imm2             $BBD0 (msg_ng_to_pieces)
  $E7B3  BB                         ADD
  $E7B4  85 D8                      STORE_near             $D8
  $E7B6  64                         PUSH_qimm   ; inline operand = 4
  $E7B7  DE D4 FF                   LEAL_far               $FFD4
  $E7BA  B3                         PUSHL
  $E7BB  87 D8                      PUSH_near              $D8
  $E7BD  68                         PUSH_qimm   ; inline operand = 8
  $E7BE  E9 BD CB 08                CALL_abs_imm1          $CBBD (syscall16_sram_wrap) {bytecode}, $08
  $E7C2  DE D4 FF                   LEAL_far               $FFD4
  $E7C5  85 D8                      STORE_near             $D8
  $E7C7  81 D8                      LOADL_near             $D8
  $E7C9  D0                         INC
  $E7CA  D3                         BYTE_DEREF
  $E7CB  B3                         PUSHL
  $E7CC  8E B0 15                   PUSH_imm2              $15B0
  $E7CF  81 D8                      LOADL_near             $D8
  $E7D1  72                         ADD_qimm   ; inline operand = 2
  $E7D2  B0                         DEREF
  $E7D3  B3                         PUSHL
  $E7D4  81 D8                      LOADL_near             $D8
  $E7D6  D3                         BYTE_DEREF
  $E7D7  B3                         PUSHL
  $E7D8  E9 7C CF 08                CALL_abs_imm1          $CF7C (ppu_upload_block_wrap) {bytecode}, $08
  $E7DC  68                         PUSH_qimm   ; inline operand = 8
  $E7DD  AA 5B 6F                   PUSH_abs               $6F5B (active_province_idx_copy)
  $E7E0  E9 66 DC 02                CALL_abs_imm1          $DC66 (fief_to_mapid) {bytecode}, $02
  $E7E4  8B 24                      BYTE_LOADR_imm1        +36
  $E7E6  B5                         MULT
  $E7E7  8C 44 B1                   LOADR_imm2             $B144 (jumptab_b144)
  $E7EA  BB                         ADD
  $E7EB  D6 FA E7                   JUMP_abs               $E7FA
 >$E7EE  DE DC FF                   LEAL_far               $FFDC
  $E7F1  B3                         PUSHL
  $E7F2  E9 B9 E6 02                CALL_abs_imm1          $E6B9 (unpack_composite_face_record) {bytecode}, $02
  $E7F6  68                         PUSH_qimm   ; inline operand = 8
  $E7F7  DE DC FF                   LEAL_far               $FFDC
 >$E7FA  B3                         PUSHL
  $E7FB  0D                         LOADL_quick   ; inline operand = 13
  $E7FC  75                         ADD_qimm   ; inline operand = 5
  $E7FD  B3                         PUSHL
  $E7FE  0C                         LOADL_quick   ; inline operand = 12
  $E7FF  75                         ADD_qimm   ; inline operand = 5
  $E800  B3                         PUSHL
  $E801  3D                         PUSH_quick   ; inline operand = 13
  $E802  3C                         PUSH_quick   ; inline operand = 12
  $E803  E9 54 CC 0C                CALL_abs_imm1          $CC54 (ppu_blit_from_bank_wrap) {bytecode}, $0C
  $E807  41                         LOADL_qimm   ; inline operand = 1
  $E808  A8 C7 7F                   STORE_abs              $7FC7 (ui_pending_flag_7fc7)
  $E80B  CF                         RETURN

; ============================================================
; sub $E80C   (frame_off=+0, body @ $E811)
; ============================================================
  $E811  A5 A1 6D                   BYTE_LOADL_abs         $6DA1 (ai_turn_flags)
  $E814  54                         LOADR_qimm   ; inline operand = 4
  $E815  DA                         AND
  $E816  D8 22 E8                   JUMPF_abs              $E822
  $E819  0C                         LOADL_quick   ; inline operand = 12
  $E81A  A8 CB 7F                   STORE_abs              $7FCB
  $E81D  6E                         PUSH_qimm   ; inline operand = 14
  $E81E  E9 B1 CB 02                CALL_abs_imm1          $CBB1 (call_bank_wrap) {bytecode}, $02
 >$E822  CF                         RETURN

