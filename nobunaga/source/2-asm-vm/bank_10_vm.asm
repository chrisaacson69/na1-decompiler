VM bytecode disassembly
  ROM:          Nobunaga's Ambition (USA).nes
  mode:         bulk dump of bank 10
  opcode spec:  vm-opcodes-v2.toml via nobunaga_vm.OPCODE_INFO (execution-validated lengths)
  labels:       1329 CPU addresses named

  bank 10: found 1 bytecode-subroutine stubs

; ============================================================
; sub $8003   (frame_off=-6, body @ $8008)
; ============================================================
  $8008  A4 4D 6F                   LOADL_abs              $6F4D (audio_wait_gate)
  $800B  51                         LOADR_qimm   ; inline operand = 1
  $800C  C0                         CMPEQ
  $800D  D8 8E 80                   JUMPF_abs              $808E
  $8010  A4 E5 7F                   LOADL_abs              $7FE5 (sound_request_id)
  $8013  8B 40                      BYTE_LOADR_imm1        +64
  $8015  C8                         UCMPGT
  $8016  D8 1A 80                   JUMPF_abs              $801A
  $8019  CF                         RETURN
 >$801A  A4 E5 7F                   LOADL_abs              $7FE5 (sound_request_id)
  $801D  8B 1B                      BYTE_LOADR_imm1        +27
  $801F  C6                         UCMPLT
  $8020  D8 70 80                   JUMPF_abs              $8070
  $8023  A4 E5 7F                   LOADL_abs              $7FE5 (sound_request_id)
  $8026  53                         LOADR_qimm   ; inline operand = 3
  $8027  B5                         MULT
  $8028  2B                         STORE_quick   ; inline operand = 11
  $8029  0B                         LOADL_quick   ; inline operand = 11
  $802A  D2                         LSHIFT1
  $802B  8C 17 86                   LOADR_imm2             $8617
  $802E  BB                         ADD
  $802F  B0                         DEREF
  $8030  B3                         PUSHL
  $8031  6A                         PUSH_qimm   ; inline operand = 10
  $8032  61                         PUSH_qimm   ; inline operand = 1
  $8033  69                         PUSH_qimm   ; inline operand = 9
  $8034  E9 26 F2 08                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $08
  $8038  0B                         LOADL_quick   ; inline operand = 11
  $8039  D0                         INC
  $803A  D2                         LSHIFT1
  $803B  8C 17 86                   LOADR_imm2             $8617
  $803E  BB                         ADD
  $803F  B0                         DEREF
  $8040  B3                         PUSHL
  $8041  6A                         PUSH_qimm   ; inline operand = 10
  $8042  62                         PUSH_qimm   ; inline operand = 2
  $8043  69                         PUSH_qimm   ; inline operand = 9
  $8044  E9 26 F2 08                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $08
  $8048  0B                         LOADL_quick   ; inline operand = 11
  $8049  72                         ADD_qimm   ; inline operand = 2
  $804A  D2                         LSHIFT1
  $804B  8C 17 86                   LOADR_imm2             $8617
  $804E  BB                         ADD
  $804F  B0                         DEREF
  $8050  B3                         PUSHL
  $8051  6A                         PUSH_qimm   ; inline operand = 10
  $8052  63                         PUSH_qimm   ; inline operand = 3
  $8053  69                         PUSH_qimm   ; inline operand = 9
  $8054  E9 26 F2 08                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $08
  $8058  61                         PUSH_qimm   ; inline operand = 1
  $8059  61                         PUSH_qimm   ; inline operand = 1
  $805A  6A                         PUSH_qimm   ; inline operand = 10
  $805B  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $805F  61                         PUSH_qimm   ; inline operand = 1
  $8060  62                         PUSH_qimm   ; inline operand = 2
  $8061  6A                         PUSH_qimm   ; inline operand = 10
  $8062  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $8066  61                         PUSH_qimm   ; inline operand = 1
  $8067  63                         PUSH_qimm   ; inline operand = 3
  $8068  6A                         PUSH_qimm   ; inline operand = 10
  $8069  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
  $806D  D6 8E 80                   JUMP_abs               $808E
 >$8070  A4 E5 7F                   LOADL_abs              $7FE5 (sound_request_id)
  $8073  D2                         LSHIFT1
  $8074  8C 17 86                   LOADR_imm2             $8617
  $8077  BB                         ADD
  $8078  B0                         DEREF
  $8079  29                         STORE_quick   ; inline operand = 9
  $807A  09                         LOADL_quick   ; inline operand = 9
  $807B  D3                         BYTE_DEREF
  $807C  54                         LOADR_qimm   ; inline operand = 4
  $807D  DA                         AND
  $807E  2A                         STORE_quick   ; inline operand = 10
  $807F  39                         PUSH_quick   ; inline operand = 9
  $8080  6A                         PUSH_qimm   ; inline operand = 10
  $8081  3A                         PUSH_quick   ; inline operand = 10
  $8082  69                         PUSH_qimm   ; inline operand = 9
  $8083  E9 26 F2 08                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $08
  $8087  61                         PUSH_qimm   ; inline operand = 1
  $8088  3A                         PUSH_quick   ; inline operand = 10
  $8089  6A                         PUSH_qimm   ; inline operand = 10
  $808A  E9 26 F2 06                CALL_abs_imm1          $F226 (syscall_dispatch) {native}, $06
 >$808E  CF                         RETURN

