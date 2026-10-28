.base $c000

reset_handler:   sei                         ; 3C000:  78
b15_c001:   cld                         ; 3C001:  d8
b15_c002:   ldx #$fd                    ; 3C002:  a2 fd
b15_c004:   txs                         ; 3C004:  9a
b15_c005:   lda #$ff                    ; 3C005:  a9 ff
b15_c007:   sta $9fff                   ; 3C007:  8d ff 9f
b15_c00a:   lda #$0e                    ; 3C00A:  a9 0e
b15_c00c:   sta $9fff                   ; 3C00C:  8d ff 9f
b15_c00f:   lsr a                       ; 3C00F:  4a
b15_c010:   sta $9fff                   ; 3C010:  8d ff 9f
b15_c013:   lsr a                       ; 3C013:  4a
b15_c014:   sta $9fff                   ; 3C014:  8d ff 9f
b15_c017:   lsr a                       ; 3C017:  4a
b15_c018:   sta $9fff                   ; 3C018:  8d ff 9f
b15_c01b:   lsr a                       ; 3C01B:  4a
b15_c01c:   sta $9fff                   ; 3C01C:  8d ff 9f
b15_c01f:   lda #$00                    ; 3C01F:  a9 00
b15_c021:   sta $bfff                   ; 3C021:  8d ff bf
b15_c024:   sta $bfff                   ; 3C024:  8d ff bf
b15_c027:   sta $bfff                   ; 3C027:  8d ff bf
b15_c02a:   sta $bfff                   ; 3C02A:  8d ff bf
b15_c02d:   sta $bfff                   ; 3C02D:  8d ff bf
b15_c030:   sta $fff0                   ; 3C030:  8d f0 ff
b15_c033:   sta $fff0                   ; 3C033:  8d f0 ff
b15_c036:   sta $fff0                   ; 3C036:  8d f0 ff
b15_c039:   sta $fff0                   ; 3C039:  8d f0 ff
b15_c03c:   sta $fff0                   ; 3C03C:  8d f0 ff
b15_c03f:   sta prg_bank_shadow                   ; 3C03F:  8d 73 00
b15_c042:   lda #$00                    ; 3C042:  a9 00
b15_c044:   sta skip_vblank_wait                   ; 3C044:  8d 80 00
b15_c047:   sta nmi_skip_all                   ; 3C047:  8d b0 00
b15_c04a:   lda #$10                    ; 3C04A:  a9 10
b15_c04c:   jsr $c6a6                   ; 3C04C:  20 a6 c6
b15_c04f:   jsr $c537                   ; 3C04F:  20 37 c5
b15_c052:   jsr $c537                   ; 3C052:  20 37 c5
b15_c055:   lda #$1e                    ; 3C055:  a9 1e
b15_c057:   jsr $c570                   ; 3C057:  20 70 c5
b15_c05a:   ldx #$00                    ; 3C05A:  a2 00
b15_c05c:   lda #$3e                    ; 3C05C:  a9 3e
b15_c05e:   sta palette_alt,x                 ; 3C05E:  9d 90 00
b15_c061:   sta palette_shadow,x                 ; 3C061:  9d 00 07
b15_c064:   inx                         ; 3C064:  e8
b15_c065:   cpx #$20                    ; 3C065:  e0 20
b15_c067:   bne $c05e                   ; 3C067:  d0 f5
b15_c069:   lda #$ff                    ; 3C069:  a9 ff
b15_c06b:   sta palette_dirty                   ; 3C06B:  8d 74 00
b15_c06e:   ldx #$00                    ; 3C06E:  a2 00
b15_c070:   lda #$f8                    ; 3C070:  a9 f8
b15_c072:   sta oam_shadow,x                 ; 3C072:  9d 00 06
b15_c075:   sta $0603,x                 ; 3C075:  9d 03 06
b15_c078:   inx                         ; 3C078:  e8
b15_c079:   inx                         ; 3C079:  e8
b15_c07a:   inx                         ; 3C07A:  e8
b15_c07b:   inx                         ; 3C07B:  e8
b15_c07c:   bne $c072                   ; 3C07C:  d0 f4
b15_c07e:   lda #$ff                    ; 3C07E:  a9 ff
b15_c080:   sta vm_sp_lo                     ; 3C080:  85 02
b15_c082:   lda #$05                    ; 3C082:  a9 05
b15_c084:   sta vm_sp_hi                     ; 3C084:  85 03
b15_c086:   lda #$20                    ; 3C086:  a9 20
b15_c088:   sta ppu_queue_a_lo                     ; 3C088:  85 1c
b15_c08a:   lda #$00                    ; 3C08A:  a9 00
b15_c08c:   sta ppu_queue_a_hi                     ; 3C08C:  85 1d
b15_c08e:   lda #$30                    ; 3C08E:  a9 30
b15_c090:   sta ppu_queue_b_lo                     ; 3C090:  85 1e
b15_c092:   lda #$00                    ; 3C092:  a9 00
b15_c094:   sta ppu_queue_b_hi                     ; 3C094:  85 1f
b15_c096:   lda #$1f                    ; 3C096:  a9 1f
b15_c098:   sta $4015                   ; 3C098:  8d 15 40
b15_c09b:   lda #$c0                    ; 3C09B:  a9 c0
b15_c09d:   sta $4017                   ; 3C09D:  8d 17 40
b15_c0a0:   ldx #$00                    ; 3C0A0:  a2 00
b15_c0a2:   lda #$00                    ; 3C0A2:  a9 00
b15_c0a4:   sta audio_mute_triangle,x                 ; 3C0A4:  9d 20 07
b15_c0a7:   inx                         ; 3C0A7:  e8
b15_c0a8:   cpx #$05                    ; 3C0A8:  e0 05
b15_c0aa:   bne $c0a4                   ; 3C0AA:  d0 f8
b15_c0ac:   ldx #$00                    ; 3C0AC:  a2 00
b15_c0ae:   lda #$00                    ; 3C0AE:  a9 00
b15_c0b0:   sta v0_trigger,x                 ; 3C0B0:  9d 34 07
b15_c0b3:   txa                         ; 3C0B3:  8a
b15_c0b4:   clc                         ; 3C0B4:  18
b15_c0b5:   adc #$09                    ; 3C0B5:  69 09
b15_c0b7:   tax                         ; 3C0B7:  aa
b15_c0b8:   cpx #$2d                    ; 3C0B8:  e0 2d
b15_c0ba:   bne $c0ae                   ; 3C0BA:  d0 f2
b15_c0bc:   lda #$04                    ; 3C0BC:  a9 04
b15_c0be:   sta clock_a_hi                   ; 3C0BE:  8d 83 00
b15_c0c1:   sta clock_b_hi                   ; 3C0C1:  8d 85 00
b15_c0c4:   lda #$d2                    ; 3C0C4:  a9 d2
b15_c0c6:   sta clock_a_lo                   ; 3C0C6:  8d 84 00
b15_c0c9:   sta clock_b_lo                   ; 3C0C9:  8d 86 00
b15_c0cc:   lda #$00                    ; 3C0CC:  a9 00
b15_c0ce:   sta skip_wallclock                   ; 3C0CE:  8d 89 00
b15_c0d1:   jsr $c68a                   ; 3C0D1:  20 8a c6
b15_c0d4:   jsr $c757                   ; 3C0D4:  20 57 c7
b15_c0d7:   jmp $8000                   ; 3C0D7:  4c 00 80
nmi_handler:   pha                         ; 3C0DA:  48
b15_c0db:   txa                         ; 3C0DB:  8a
b15_c0dc:   pha                         ; 3C0DC:  48
b15_c0dd:   tya                         ; 3C0DD:  98
b15_c0de:   pha                         ; 3C0DE:  48
b15_c0df:   lda $2002                   ; 3C0DF:  ad 02 20
b15_c0e2:   jsr $c54f                   ; 3C0E2:  20 4f c5
b15_c0e5:   lda #$00                    ; 3C0E5:  a9 00
b15_c0e7:   sta $2003                   ; 3C0E7:  8d 03 20
b15_c0ea:   lda #$06                    ; 3C0EA:  a9 06
b15_c0ec:   sta $4014                   ; 3C0EC:  8d 14 40
b15_c0ef:   lda nmi_skip_all                   ; 3C0EF:  ad b0 00
b15_c0f2:   bne $c12b                   ; 3C0F2:  d0 37
b15_c0f4:   lda #$00                    ; 3C0F4:  a9 00
b15_c0f6:   jsr $c628                   ; 3C0F6:  20 28 c6
b15_c0f9:   lda #$01                    ; 3C0F9:  a9 01
b15_c0fb:   jsr $c628                   ; 3C0FB:  20 28 c6
b15_c0fe:   jsr $c6d4                   ; 3C0FE:  20 d4 c6
b15_c101:   jsr $c7a5                   ; 3C101:  20 a5 c7
b15_c104:   lda skip_wallclock                   ; 3C104:  ad 89 00
b15_c107:   bne $c12b                   ; 3C107:  d0 22
b15_c109:   clc                         ; 3C109:  18
b15_c10a:   lda clock_b_lo                   ; 3C10A:  ad 86 00
b15_c10d:   adc #$02                    ; 3C10D:  69 02
b15_c10f:   sta clock_b_lo                   ; 3C10F:  8d 86 00
b15_c112:   lda clock_b_hi                   ; 3C112:  ad 85 00
b15_c115:   adc #$00                    ; 3C115:  69 00
b15_c117:   sta clock_b_hi                   ; 3C117:  8d 85 00
b15_c11a:   clc                         ; 3C11A:  18
b15_c11b:   lda clock_a_lo                   ; 3C11B:  ad 84 00
b15_c11e:   adc #$02                    ; 3C11E:  69 02
b15_c120:   sta clock_a_lo                   ; 3C120:  8d 84 00
b15_c123:   lda clock_a_hi                   ; 3C123:  ad 83 00
b15_c126:   adc #$00                    ; 3C126:  69 00
b15_c128:   sta clock_a_hi                   ; 3C128:  8d 83 00
b15_c12b:   lda #$00                    ; 3C12B:  a9 00
b15_c12d:   sta nmi_busy                   ; 3C12D:  8d 81 00
b15_c130:   jsr $c68a                   ; 3C130:  20 8a c6
b15_c133:   pla                         ; 3C133:  68
b15_c134:   tay                         ; 3C134:  a8
b15_c135:   pla                         ; 3C135:  68
b15_c136:   tax                         ; 3C136:  aa
b15_c137:   pla                         ; 3C137:  68
b15_c138:   rti                         ; 3C138:  40
irq_handler:   pha                         ; 3C139:  48
b15_c13a:   txa                         ; 3C13A:  8a
b15_c13b:   pha                         ; 3C13B:  48
b15_c13c:   tya                         ; 3C13C:  98
b15_c13d:   pha                         ; 3C13D:  48
b15_c13e:   tsx                         ; 3C13E:  ba
b15_c13f:   lda $0104,x                 ; 3C13F:  bd 04 01
b15_c142:   and #$10                    ; 3C142:  29 10
b15_c144:   beq $c16c                   ; 3C144:  f0 26
b15_c146:   lda #$00                    ; 3C146:  a9 00
b15_c148:   sta brk_scratch_lo                   ; 3C148:  8d 66 00
b15_c14b:   sta brk_scratch_hi                   ; 3C14B:  8d 67 00
b15_c14e:   lda #$c1                    ; 3C14E:  a9 c1
b15_c150:   pha                         ; 3C150:  48
b15_c151:   lda #$6c                    ; 3C151:  a9 6c
b15_c153:   pha                         ; 3C153:  48
b15_c154:   ldx brk_dispatch_id                   ; 3C154:  ae 50 00
b15_c157:   ldy #$03                    ; 3C157:  a0 03
b15_c159:   jsr $c6ad                   ; 3C159:  20 ad c6
b15_c15c:   clc                         ; 3C15C:  18
b15_c15d:   tya                         ; 3C15D:  98
b15_c15e:   adc #$73                    ; 3C15E:  69 73
b15_c160:   sta brk_jmp_target_lo                   ; 3C160:  8d 68 00
b15_c163:   txa                         ; 3C163:  8a
b15_c164:   adc #$c1                    ; 3C164:  69 c1
b15_c166:   sta brk_jmp_target_hi                   ; 3C166:  8d 69 00
b15_c169:   jmp (brk_jmp_target_lo)                 ; 3C169:  6c 68 00
b15_c16c:   nop                         ; 3C16C:  ea
b15_c16d:   pla                         ; 3C16D:  68
b15_c16e:   tay                         ; 3C16E:  a8
b15_c16f:   pla                         ; 3C16F:  68
b15_c170:   tax                         ; 3C170:  aa
b15_c171:   pla                         ; 3C171:  68
b15_c172:   rti                         ; 3C172:  40
syscall_dispatch_table:   jmp $c000                   ; 3C173:  4c 00 c0
b15_c176:   jmp $c264                   ; 3C176:  4c 64 c2
b15_c179:   jmp $c34b                   ; 3C179:  4c 4b c3
b15_c17c:   jmp $c2cb                   ; 3C17C:  4c cb c2
b15_c17f:   jmp $c34c                   ; 3C17F:  4c 4c c3
b15_c182:   jmp $c312                   ; 3C182:  4c 12 c3
b15_c185:   jmp $c39e                   ; 3C185:  4c 9e c3
b15_c188:   jmp $c339                   ; 3C188:  4c 39 c3
b15_c18b:   jmp $c2f0                   ; 3C18B:  4c f0 c2
b15_c18e:   jmp $c3ad                   ; 3C18E:  4c ad c3
b15_c191:   jmp $c3cf                   ; 3C191:  4c cf c3
b15_c194:   jmp $c427                   ; 3C194:  4c 27 c4
b15_c197:   jmp $c437                   ; 3C197:  4c 37 c4
b15_c19a:   jmp $c4e0                   ; 3C19A:  4c e0 c4
b15_c19d:   jmp $c535                   ; 3C19D:  4c 35 c5
b15_c1a0:   jmp $c536                   ; 3C1A0:  4c 36 c5
b15_c1a3:   jmp $c22c                   ; 3C1A3:  4c 2c c2
b15_c1a6:   jmp $c1c3                   ; 3C1A6:  4c c3 c1
b15_c1a9:   jmp $c36c                   ; 3C1A9:  4c 6c c3
b15_c1ac:   jmp $c1b8                   ; 3C1AC:  4c b8 c1
b15_c1af:   jmp $c428                   ; 3C1AF:  4c 28 c4
b15_c1b2:   jmp $c60c                   ; 3C1B2:  4c 0c c6
b15_c1b5:   jmp $c5aa                   ; 3C1B5:  4c aa c5
syscall_wait_for_nmi:   lda #$01                    ; 3C1B8:  a9 01
b15_c1ba:   sta nmi_busy                   ; 3C1BA:  8d 81 00
b15_c1bd:   lda nmi_busy                   ; 3C1BD:  ad 81 00
b15_c1c0:   bne $c1bd                   ; 3C1C0:  d0 fb
b15_c1c2:   rts                         ; 3C1C2:  60
syscall_rng_next:   lda $0088                   ; 3C1C3:  ad 88 00
b15_c1c6:   ora #$01                    ; 3C1C6:  09 01
b15_c1c8:   sta $0088                   ; 3C1C8:  8d 88 00
b15_c1cb:   ldy #$05                    ; 3C1CB:  a0 05
b15_c1cd:   lda #$00                    ; 3C1CD:  a9 00
b15_c1cf:   sta $008a,y                 ; 3C1CF:  99 8a 00
b15_c1d2:   dey                         ; 3C1D2:  88
b15_c1d3:   bpl $c1cf                   ; 3C1D3:  10 fa
b15_c1d5:   ldy #$05                    ; 3C1D5:  a0 05
b15_c1d7:   lda $c226,y                 ; 3C1D7:  b9 26 c2
b15_c1da:   sta mul_acc_lo                   ; 3C1DA:  8d 75 00
b15_c1dd:   lda #$08                    ; 3C1DD:  a9 08
b15_c1df:   sta $006c                   ; 3C1DF:  8d 6c 00
b15_c1e2:   ldx #$05                    ; 3C1E2:  a2 05
b15_c1e4:   clc                         ; 3C1E4:  18
b15_c1e5:   rol $008a,x                 ; 3C1E5:  3e 8a 00
b15_c1e8:   dex                         ; 3C1E8:  ca
b15_c1e9:   bpl $c1e5                   ; 3C1E9:  10 fa
b15_c1eb:   asl mul_acc_lo                   ; 3C1EB:  0e 75 00
b15_c1ee:   bcc $c1ff                   ; 3C1EE:  90 0f
b15_c1f0:   ldx #$05                    ; 3C1F0:  a2 05
b15_c1f2:   clc                         ; 3C1F2:  18
b15_c1f3:   lda clock_a_hi,x                 ; 3C1F3:  bd 83 00
b15_c1f6:   adc $008a,x                 ; 3C1F6:  7d 8a 00
b15_c1f9:   sta $008a,x                 ; 3C1F9:  9d 8a 00
b15_c1fc:   dex                         ; 3C1FC:  ca
b15_c1fd:   bpl $c1f3                   ; 3C1FD:  10 f4
b15_c1ff:   dec $006c                   ; 3C1FF:  ce 6c 00
b15_c202:   bne $c1e2                   ; 3C202:  d0 de
b15_c204:   dey                         ; 3C204:  88
b15_c205:   bpl $c1d7                   ; 3C205:  10 d0
b15_c207:   sec                         ; 3C207:  38
b15_c208:   ldx #$05                    ; 3C208:  a2 05
b15_c20a:   lda $008a,x                 ; 3C20A:  bd 8a 00
b15_c20d:   eor #$ff                    ; 3C20D:  49 ff
b15_c20f:   adc #$00                    ; 3C20F:  69 00
b15_c211:   sta clock_a_hi,x                 ; 3C211:  9d 83 00
b15_c214:   dex                         ; 3C214:  ca
b15_c215:   bpl $c20a                   ; 3C215:  10 f3
b15_c217:   lda clock_a_hi                   ; 3C217:  ad 83 00
b15_c21a:   and #$7f                    ; 3C21A:  29 7f
b15_c21c:   sta brk_scratch_hi                   ; 3C21C:  8d 67 00
b15_c21f:   lda clock_a_lo                   ; 3C21F:  ad 84 00
b15_c222:   sta brk_scratch_lo                   ; 3C222:  8d 66 00
b15_c225:   rts                         ; 3C225:  60
b15_c226:   cmp $87                     ; 3C226:  c5 87
b15_c228:   ora ($0e,x)                 ; 3C228:  01 0e
b15_c22a:   bcc $c20c                   ; 3C22A:  90 e0
syscall_memcpy_banked:   lda prg_bank_shadow                   ; 3C22C:  ad 73 00
b15_c22f:   pha                         ; 3C22F:  48
b15_c230:   lda $0052                   ; 3C230:  ad 52 00
b15_c233:   jsr $c577                   ; 3C233:  20 77 c5
b15_c236:   ldx #$00                    ; 3C236:  a2 00
b15_c238:   lda $0058                   ; 3C238:  ad 58 00
b15_c23b:   bne $c245                   ; 3C23B:  d0 08
b15_c23d:   lda $0059                   ; 3C23D:  ad 59 00
b15_c240:   beq $c25f                   ; 3C240:  f0 1d
b15_c242:   dec $0059                   ; 3C242:  ce 59 00
b15_c245:   lda ($54,x)                 ; 3C245:  a1 54
b15_c247:   sta ($56,x)                 ; 3C247:  81 56
b15_c249:   inc $0054                   ; 3C249:  ee 54 00
b15_c24c:   bne $c251                   ; 3C24C:  d0 03
b15_c24e:   inc $0055                   ; 3C24E:  ee 55 00
b15_c251:   inc $0056                   ; 3C251:  ee 56 00
b15_c254:   bne $c259                   ; 3C254:  d0 03
b15_c256:   inc $0057                   ; 3C256:  ee 57 00
b15_c259:   dec $0058                   ; 3C259:  ce 58 00
b15_c25c:   jmp $c238                   ; 3C25C:  4c 38 c2
b15_c25f:   pla                         ; 3C25F:  68
b15_c260:   jsr $c577                   ; 3C260:  20 77 c5
b15_c263:   rts                         ; 3C263:  60
syscall_ppu_upload_block:   lda prg_bank_shadow                   ; 3C264:  ad 73 00
b15_c267:   pha                         ; 3C267:  48
b15_c268:   lda $0052                   ; 3C268:  ad 52 00
b15_c26b:   jsr $c577                   ; 3C26B:  20 77 c5
b15_c26e:   lda $0057                   ; 3C26E:  ad 57 00
b15_c271:   sta $006b                   ; 3C271:  8d 6b 00
b15_c274:   lda $0056                   ; 3C274:  ad 56 00
b15_c277:   sta $006a                   ; 3C277:  8d 6a 00
b15_c27a:   lda $0055                   ; 3C27A:  ad 55 00
b15_c27d:   sta brk_jmp_target_hi                   ; 3C27D:  8d 69 00
b15_c280:   lda $0054                   ; 3C280:  ad 54 00
b15_c283:   sta brk_jmp_target_lo                   ; 3C283:  8d 68 00
b15_c286:   ldy #$00                    ; 3C286:  a0 00
b15_c288:   lda $0058                   ; 3C288:  ad 58 00
b15_c28b:   sta $006c                   ; 3C28B:  8d 6c 00
b15_c28e:   ldx #$10                    ; 3C28E:  a2 10
b15_c290:   jsr $c693                   ; 3C290:  20 93 c6
b15_c293:   lda $006b                   ; 3C293:  ad 6b 00
b15_c296:   sta $2006                   ; 3C296:  8d 06 20
b15_c299:   lda $006a                   ; 3C299:  ad 6a 00
b15_c29c:   sta $2006                   ; 3C29C:  8d 06 20
b15_c29f:   lda (brk_jmp_target_lo),y                 ; 3C29F:  b1 68
b15_c2a1:   sta $2007                   ; 3C2A1:  8d 07 20
b15_c2a4:   iny                         ; 3C2A4:  c8
b15_c2a5:   bne $c2aa                   ; 3C2A5:  d0 03
b15_c2a7:   inc brk_jmp_target_hi                   ; 3C2A7:  ee 69 00
b15_c2aa:   dex                         ; 3C2AA:  ca
b15_c2ab:   bne $c29f                   ; 3C2AB:  d0 f2
b15_c2ad:   clc                         ; 3C2AD:  18
b15_c2ae:   lda $006a                   ; 3C2AE:  ad 6a 00
b15_c2b1:   adc #$10                    ; 3C2B1:  69 10
b15_c2b3:   sta $006a                   ; 3C2B3:  8d 6a 00
b15_c2b6:   lda $006b                   ; 3C2B6:  ad 6b 00
b15_c2b9:   adc #$00                    ; 3C2B9:  69 00
b15_c2bb:   sta $006b                   ; 3C2BB:  8d 6b 00
b15_c2be:   jsr $c558                   ; 3C2BE:  20 58 c5
b15_c2c1:   dec $006c                   ; 3C2C1:  ce 6c 00
b15_c2c4:   bne $c28e                   ; 3C2C4:  d0 c8
b15_c2c6:   pla                         ; 3C2C6:  68
b15_c2c7:   jsr $c577                   ; 3C2C7:  20 77 c5
b15_c2ca:   rts                         ; 3C2CA:  60
syscall_set_sprite:   jsr $c54f                   ; 3C2CB:  20 4f c5
b15_c2ce:   lda $0052                   ; 3C2CE:  ad 52 00
b15_c2d1:   asl a                       ; 3C2D1:  0a
b15_c2d2:   asl a                       ; 3C2D2:  0a
b15_c2d3:   tax                         ; 3C2D3:  aa
b15_c2d4:   lda $0056                   ; 3C2D4:  ad 56 00
b15_c2d7:   sta oam_shadow,x                 ; 3C2D7:  9d 00 06
b15_c2da:   lda $005a                   ; 3C2DA:  ad 5a 00
b15_c2dd:   sta $0601,x                 ; 3C2DD:  9d 01 06
b15_c2e0:   lda $0058                   ; 3C2E0:  ad 58 00
b15_c2e3:   sta $0602,x                 ; 3C2E3:  9d 02 06
b15_c2e6:   lda $0054                   ; 3C2E6:  ad 54 00
b15_c2e9:   sta $0603,x                 ; 3C2E9:  9d 03 06
b15_c2ec:   jsr $c68a                   ; 3C2EC:  20 8a c6
b15_c2ef:   rts                         ; 3C2EF:  60
syscall_fill_attr_quadrant:   jsr $c693                   ; 3C2F0:  20 93 c6
b15_c2f3:   lda $0052                   ; 3C2F3:  ad 52 00
b15_c2f6:   asl a                       ; 3C2F6:  0a
b15_c2f7:   asl a                       ; 3C2F7:  0a
b15_c2f8:   clc                         ; 3C2F8:  18
b15_c2f9:   adc #$23                    ; 3C2F9:  69 23
b15_c2fb:   sta $2006                   ; 3C2FB:  8d 06 20
b15_c2fe:   lda #$c0                    ; 3C2FE:  a9 c0
b15_c300:   sta $2006                   ; 3C300:  8d 06 20
b15_c303:   lda $0054                   ; 3C303:  ad 54 00
b15_c306:   ldx #$40                    ; 3C306:  a2 40
b15_c308:   sta $2007                   ; 3C308:  8d 07 20
b15_c30b:   dex                         ; 3C30B:  ca
b15_c30c:   bne $c308                   ; 3C30C:  d0 fa
b15_c30e:   jsr $c558                   ; 3C30E:  20 58 c5
b15_c311:   rts                         ; 3C311:  60
syscall_fill_nametable:   jsr $c693                   ; 3C312:  20 93 c6
b15_c315:   lda $0052                   ; 3C315:  ad 52 00
b15_c318:   asl a                       ; 3C318:  0a
b15_c319:   asl a                       ; 3C319:  0a
b15_c31a:   clc                         ; 3C31A:  18
b15_c31b:   adc #$20                    ; 3C31B:  69 20
b15_c31d:   sta $2006                   ; 3C31D:  8d 06 20
b15_c320:   lda #$00                    ; 3C320:  a9 00
b15_c322:   sta $2006                   ; 3C322:  8d 06 20
b15_c325:   ldy #$1e                    ; 3C325:  a0 1e
b15_c327:   lda $0054                   ; 3C327:  ad 54 00
b15_c32a:   ldx #$20                    ; 3C32A:  a2 20
b15_c32c:   sta $2007                   ; 3C32C:  8d 07 20
b15_c32f:   dex                         ; 3C32F:  ca
b15_c330:   bne $c32c                   ; 3C330:  d0 fa
b15_c332:   dey                         ; 3C332:  88
b15_c333:   bne $c32a                   ; 3C333:  d0 f5
b15_c335:   jsr $c558                   ; 3C335:  20 58 c5
b15_c338:   rts                         ; 3C338:  60
syscall_call_bank:   lda prg_bank_shadow                   ; 3C339:  ad 73 00
b15_c33c:   pha                         ; 3C33C:  48
b15_c33d:   lda $0052                   ; 3C33D:  ad 52 00
b15_c340:   jsr $c577                   ; 3C340:  20 77 c5
b15_c343:   jsr $8000                   ; 3C343:  20 00 80
b15_c346:   pla                         ; 3C346:  68
b15_c347:   jsr $c577                   ; 3C347:  20 77 c5
b15_c34a:   rts                         ; 3C34A:  60
syscall_noop_02:   rts                         ; 3C34B:  60
syscall_palette_write:   lda skip_vblank_wait                   ; 3C34C:  ad 80 00
b15_c34f:   beq $c35d                   ; 3C34F:  f0 0c
b15_c351:   ldx $0052                   ; 3C351:  ae 52 00
b15_c354:   lda $0054                   ; 3C354:  ad 54 00
b15_c357:   sta palette_alt,x                 ; 3C357:  9d 90 00
b15_c35a:   jmp $c36b                   ; 3C35A:  4c 6b c3
b15_c35d:   ldx $0052                   ; 3C35D:  ae 52 00
b15_c360:   lda $0054                   ; 3C360:  ad 54 00
b15_c363:   sta palette_shadow,x                 ; 3C363:  9d 00 07
b15_c366:   lda #$ff                    ; 3C366:  a9 ff
b15_c368:   sta palette_dirty                   ; 3C368:  8d 74 00
b15_c36b:   rts                         ; 3C36B:  60
syscall_palette_swap:   lda palette_dirty                   ; 3C36C:  ad 74 00
b15_c36f:   bne $c36c                   ; 3C36F:  d0 fb
b15_c371:   lda $0052                   ; 3C371:  ad 52 00
b15_c374:   eor skip_vblank_wait                   ; 3C374:  4d 80 00
b15_c377:   beq $c39d                   ; 3C377:  f0 24
b15_c379:   ldx #$00                    ; 3C379:  a2 00
b15_c37b:   lda palette_shadow,x                 ; 3C37B:  bd 00 07
b15_c37e:   ldy palette_alt,x                 ; 3C37E:  bc 90 00
b15_c381:   sta palette_alt,x                 ; 3C381:  9d 90 00
b15_c384:   tya                         ; 3C384:  98
b15_c385:   sta palette_shadow,x                 ; 3C385:  9d 00 07
b15_c388:   inx                         ; 3C388:  e8
b15_c389:   cpx #$20                    ; 3C389:  e0 20
b15_c38b:   bne $c37b                   ; 3C38B:  d0 ee
b15_c38d:   lda #$ff                    ; 3C38D:  a9 ff
b15_c38f:   sta palette_dirty                   ; 3C38F:  8d 74 00
b15_c392:   lda palette_dirty                   ; 3C392:  ad 74 00
b15_c395:   bne $c392                   ; 3C395:  d0 fb
b15_c397:   lda $0052                   ; 3C397:  ad 52 00
b15_c39a:   sta skip_vblank_wait                   ; 3C39A:  8d 80 00
b15_c39d:   rts                         ; 3C39D:  60
syscall_read_controller:   ldx $0052                   ; 3C39E:  ae 52 00
b15_c3a1:   lda p1_buttons,x                 ; 3C3A1:  bd 6e 00
b15_c3a4:   sta brk_scratch_lo                   ; 3C3A4:  8d 66 00
b15_c3a7:   beq $c3ac                   ; 3C3A7:  f0 03
b15_c3a9:   sta skip_wallclock                   ; 3C3A9:  8d 89 00
b15_c3ac:   rts                         ; 3C3AC:  60
syscall_audio_load_voice:   jsr $c54f                   ; 3C3AD:  20 4f c5
b15_c3b0:   lda $0052                   ; 3C3B0:  ad 52 00
b15_c3b3:   asl a                       ; 3C3B3:  0a
b15_c3b4:   clc                         ; 3C3B4:  18
b15_c3b5:   adc $0052                   ; 3C3B5:  6d 52 00
b15_c3b8:   tax                         ; 3C3B8:  aa
b15_c3b9:   lda $0056                   ; 3C3B9:  ad 56 00
b15_c3bc:   sta $0726,x                 ; 3C3BC:  9d 26 07
b15_c3bf:   lda $0057                   ; 3C3BF:  ad 57 00
b15_c3c2:   sta $0727,x                 ; 3C3C2:  9d 27 07
b15_c3c5:   lda $0054                   ; 3C3C5:  ad 54 00
b15_c3c8:   sta v0_config,x                 ; 3C3C8:  9d 25 07
b15_c3cb:   jsr $c68a                   ; 3C3CB:  20 8a c6
b15_c3ce:   rts                         ; 3C3CE:  60
syscall_audio_control:   ldx $0052                   ; 3C3CF:  ae 52 00
b15_c3d2:   lda $0054                   ; 3C3D2:  ad 54 00
b15_c3d5:   beq $c3f9                   ; 3C3D5:  f0 22
b15_c3d7:   cmp #$02                    ; 3C3D7:  c9 02
b15_c3d9:   beq $c3f0                   ; 3C3D9:  f0 15
b15_c3db:   jsr $c54f                   ; 3C3DB:  20 4f c5
b15_c3de:   lda #$01                    ; 3C3DE:  a9 01
b15_c3e0:   sta audio_mute_triangle,x                 ; 3C3E0:  9d 20 07
b15_c3e3:   ldy #$09                    ; 3C3E3:  a0 09
b15_c3e5:   jsr $c6ad                   ; 3C3E5:  20 ad c6
b15_c3e8:   lda #$00                    ; 3C3E8:  a9 00
b15_c3ea:   sta v0_trigger,y                 ; 3C3EA:  99 34 07
b15_c3ed:   jmp $c423                   ; 3C3ED:  4c 23 c4
b15_c3f0:   lda audio_mute_triangle,x                 ; 3C3F0:  bd 20 07
b15_c3f3:   sta brk_scratch_lo                   ; 3C3F3:  8d 66 00
b15_c3f6:   jmp $c426                   ; 3C3F6:  4c 26 c4
b15_c3f9:   jsr $c54f                   ; 3C3F9:  20 4f c5
b15_c3fc:   ldx #$00                    ; 3C3FC:  a2 00
b15_c3fe:   lda #$00                    ; 3C3FE:  a9 00
b15_c400:   sta audio_mute_triangle,x                 ; 3C400:  9d 20 07
b15_c403:   inx                         ; 3C403:  e8
b15_c404:   cpx #$05                    ; 3C404:  e0 05
b15_c406:   bne $c400                   ; 3C406:  d0 f8
b15_c408:   ldx #$00                    ; 3C408:  a2 00
b15_c40a:   lda #$00                    ; 3C40A:  a9 00
b15_c40c:   sta v0_trigger,x                 ; 3C40C:  9d 34 07
b15_c40f:   txa                         ; 3C40F:  8a
b15_c410:   clc                         ; 3C410:  18
b15_c411:   adc #$09                    ; 3C411:  69 09
b15_c413:   tax                         ; 3C413:  aa
b15_c414:   cpx #$2d                    ; 3C414:  e0 2d
b15_c416:   bne $c40a                   ; 3C416:  d0 f2
b15_c418:   lda #$00                    ; 3C418:  a9 00
b15_c41a:   sta $4000                   ; 3C41A:  8d 00 40
b15_c41d:   sta $4004                   ; 3C41D:  8d 04 40
b15_c420:   sta $4008                   ; 3C420:  8d 08 40
b15_c423:   jsr $c68a                   ; 3C423:  20 8a c6
b15_c426:   rts                         ; 3C426:  60
syscall_noop_0b:   rts                         ; 3C427:  60
syscall_ppu_copy_rect:   lda prg_bank_shadow                   ; 3C428:  ad 73 00
b15_c42b:   pha                         ; 3C42B:  48
b15_c42c:   lda $005e                   ; 3C42C:  ad 5e 00
b15_c42f:   jsr $c577                   ; 3C42F:  20 77 c5
b15_c432:   lda #$01                    ; 3C432:  a9 01
b15_c434:   jmp $c439                   ; 3C434:  4c 39 c4
syscall_ppu_fill_rect:   lda #$00                    ; 3C437:  a9 00
b15_c439:   sta $0082                   ; 3C439:  8d 82 00
b15_c43c:   ldy $0056                   ; 3C43C:  ac 56 00
b15_c43f:   ldx #$20                    ; 3C43F:  a2 20
b15_c441:   jsr $c6ad                   ; 3C441:  20 ad c6
b15_c444:   tya                         ; 3C444:  98
b15_c445:   clc                         ; 3C445:  18
b15_c446:   adc $0054                   ; 3C446:  6d 54 00
b15_c449:   tay                         ; 3C449:  a8
b15_c44a:   txa                         ; 3C44A:  8a
b15_c44b:   adc #$00                    ; 3C44B:  69 00
b15_c44d:   sta brk_jmp_target_lo                   ; 3C44D:  8d 68 00
b15_c450:   lda $0052                   ; 3C450:  ad 52 00
b15_c453:   asl a                       ; 3C453:  0a
b15_c454:   asl a                       ; 3C454:  0a
b15_c455:   clc                         ; 3C455:  18
b15_c456:   adc #$20                    ; 3C456:  69 20
b15_c458:   adc brk_jmp_target_lo                   ; 3C458:  6d 68 00
b15_c45b:   sta brk_jmp_target_lo                   ; 3C45B:  8d 68 00
b15_c45e:   sty brk_jmp_target_hi                   ; 3C45E:  8c 69 00
b15_c461:   inc $005a                   ; 3C461:  ee 5a 00
b15_c464:   lda $005a                   ; 3C464:  ad 5a 00
b15_c467:   sec                         ; 3C467:  38
b15_c468:   sbc $0056                   ; 3C468:  ed 56 00
b15_c46b:   sta $006c                   ; 3C46B:  8d 6c 00
b15_c46e:   inc $0058                   ; 3C46E:  ee 58 00
b15_c471:   lda $0058                   ; 3C471:  ad 58 00
b15_c474:   sec                         ; 3C474:  38
b15_c475:   sbc $0054                   ; 3C475:  ed 54 00
b15_c478:   sta mul_acc_lo                   ; 3C478:  8d 75 00
b15_c47b:   ldx #$00                    ; 3C47B:  a2 00
b15_c47d:   jsr $c693                   ; 3C47D:  20 93 c6
b15_c480:   lda brk_jmp_target_lo                   ; 3C480:  ad 68 00
b15_c483:   sta $2006                   ; 3C483:  8d 06 20
b15_c486:   lda brk_jmp_target_hi                   ; 3C486:  ad 69 00
b15_c489:   sta $2006                   ; 3C489:  8d 06 20
b15_c48c:   lda mul_acc_lo                   ; 3C48C:  ad 75 00
b15_c48f:   sta $006d                   ; 3C48F:  8d 6d 00
b15_c492:   lda $005c                   ; 3C492:  ad 5c 00
b15_c495:   lda $0082                   ; 3C495:  ad 82 00
b15_c498:   beq $c4b2                   ; 3C498:  f0 18
b15_c49a:   lda ($5c,x)                 ; 3C49A:  a1 5c
b15_c49c:   pha                         ; 3C49C:  48
b15_c49d:   clc                         ; 3C49D:  18
b15_c49e:   lda $005c                   ; 3C49E:  ad 5c 00
b15_c4a1:   adc #$01                    ; 3C4A1:  69 01
b15_c4a3:   sta $005c                   ; 3C4A3:  8d 5c 00
b15_c4a6:   lda $005d                   ; 3C4A6:  ad 5d 00
b15_c4a9:   adc #$00                    ; 3C4A9:  69 00
b15_c4ab:   sta $005d                   ; 3C4AB:  8d 5d 00
b15_c4ae:   pla                         ; 3C4AE:  68
b15_c4af:   jmp $c4b5                   ; 3C4AF:  4c b5 c4
b15_c4b2:   lda $005c                   ; 3C4B2:  ad 5c 00
b15_c4b5:   sta $2007                   ; 3C4B5:  8d 07 20
b15_c4b8:   dec $006d                   ; 3C4B8:  ce 6d 00
b15_c4bb:   bne $c495                   ; 3C4BB:  d0 d8
b15_c4bd:   lda brk_jmp_target_hi                   ; 3C4BD:  ad 69 00
b15_c4c0:   clc                         ; 3C4C0:  18
b15_c4c1:   adc #$20                    ; 3C4C1:  69 20
b15_c4c3:   sta brk_jmp_target_hi                   ; 3C4C3:  8d 69 00
b15_c4c6:   lda brk_jmp_target_lo                   ; 3C4C6:  ad 68 00
b15_c4c9:   adc #$00                    ; 3C4C9:  69 00
b15_c4cb:   sta brk_jmp_target_lo                   ; 3C4CB:  8d 68 00
b15_c4ce:   jsr $c558                   ; 3C4CE:  20 58 c5
b15_c4d1:   dec $006c                   ; 3C4D1:  ce 6c 00
b15_c4d4:   bne $c47d                   ; 3C4D4:  d0 a7
b15_c4d6:   lda $0082                   ; 3C4D6:  ad 82 00
b15_c4d9:   beq $c4df                   ; 3C4D9:  f0 04
b15_c4db:   pla                         ; 3C4DB:  68
ui_unused:   jsr $c577                   ; 3C4DC:  20 77 c5
b15_c4df:   rts                         ; 3C4DF:  60
syscall_ppu_render_rect:   inc $0058                   ; 3C4E0:  ee 58 00
b15_c4e3:   lda $0058                   ; 3C4E3:  ad 58 00
b15_c4e6:   sec                         ; 3C4E6:  38
b15_c4e7:   sbc $0054                   ; 3C4E7:  ed 54 00
b15_c4ea:   sta $0077                   ; 3C4EA:  8d 77 00
b15_c4ed:   sta $006c                   ; 3C4ED:  8d 6c 00
b15_c4f0:   inc $005a                   ; 3C4F0:  ee 5a 00
b15_c4f3:   lda $005a                   ; 3C4F3:  ad 5a 00
b15_c4f6:   sec                         ; 3C4F6:  38
b15_c4f7:   sbc $0056                   ; 3C4F7:  ed 56 00
b15_c4fa:   sta $006d                   ; 3C4FA:  8d 6d 00
b15_c4fd:   lda $0054                   ; 3C4FD:  ad 54 00
b15_c500:   sta $0078                   ; 3C500:  8d 78 00
b15_c503:   lda $0077                   ; 3C503:  ad 77 00
b15_c506:   sta $006c                   ; 3C506:  8d 6c 00
b15_c509:   lda $0078                   ; 3C509:  ad 78 00
b15_c50c:   sta $0054                   ; 3C50C:  8d 54 00
b15_c50f:   lda $005c                   ; 3C50F:  ad 5c 00
b15_c512:   sta $0058                   ; 3C512:  8d 58 00
b15_c515:   jsr $c693                   ; 3C515:  20 93 c6
b15_c518:   jsr $c640                   ; 3C518:  20 40 c6
b15_c51b:   jsr $c673                   ; 3C51B:  20 73 c6
b15_c51e:   jsr $c711                   ; 3C51E:  20 11 c7
b15_c521:   jsr $c558                   ; 3C521:  20 58 c5
b15_c524:   inc $0054                   ; 3C524:  ee 54 00
b15_c527:   dec $006c                   ; 3C527:  ce 6c 00
b15_c52a:   bne $c50f                   ; 3C52A:  d0 e3
b15_c52c:   inc $0056                   ; 3C52C:  ee 56 00
b15_c52f:   dec $006d                   ; 3C52F:  ce 6d 00
b15_c532:   bne $c503                   ; 3C532:  d0 cf
b15_c534:   rts                         ; 3C534:  60
syscall_noop_0e:   rts                         ; 3C535:  60
syscall_noop_0f:   rts                         ; 3C536:  60
wait_vblank:   lda skip_vblank_wait                   ; 3C537:  ad 80 00
b15_c53a:   bne $c54e                   ; 3C53A:  d0 12
b15_c53c:   pha                         ; 3C53C:  48
b15_c53d:   txa                         ; 3C53D:  8a
b15_c53e:   pha                         ; 3C53E:  48
b15_c53f:   tya                         ; 3C53F:  98
b15_c540:   pha                         ; 3C540:  48
b15_c541:   jsr $c7a5                   ; 3C541:  20 a5 c7
b15_c544:   pla                         ; 3C544:  68
b15_c545:   tay                         ; 3C545:  a8
b15_c546:   pla                         ; 3C546:  68
b15_c547:   tax                         ; 3C547:  aa
b15_c548:   pla                         ; 3C548:  68
b15_c549:   lda $2002                   ; 3C549:  ad 02 20
b15_c54c:   bpl $c549                   ; 3C54C:  10 fb
b15_c54e:   rts                         ; 3C54E:  60
nmi_off:   lda ppuctrl_shadow                   ; 3C54F:  ad 71 00
b15_c552:   and #$7f                    ; 3C552:  29 7f
b15_c554:   jsr $c6a6                   ; 3C554:  20 a6 c6
b15_c557:   rts                         ; 3C557:  60
screen_on:   lda #$00                    ; 3C558:  a9 00
b15_c55a:   sta $2005                   ; 3C55A:  8d 05 20
b15_c55d:   sta $2005                   ; 3C55D:  8d 05 20
b15_c560:   jsr $c567                   ; 3C560:  20 67 c5
b15_c563:   jsr $c68a                   ; 3C563:  20 8a c6
b15_c566:   rts                         ; 3C566:  60
rendering_on:   lda ppumask_shadow                   ; 3C567:  ad 72 00
b15_c56a:   ora #$18                    ; 3C56A:  09 18
b15_c56c:   jsr $c570                   ; 3C56C:  20 70 c5
b15_c56f:   rts                         ; 3C56F:  60
write_ppumask:   sta $2001                   ; 3C570:  8d 01 20
b15_c573:   sta ppumask_shadow                   ; 3C573:  8d 72 00
b15_c576:   rts                         ; 3C576:  60
set_prg_bank:   cmp prg_bank_shadow                   ; 3C577:  cd 73 00
b15_c57a:   beq $c5a9                   ; 3C57A:  f0 2d
b15_c57c:   pha                         ; 3C57C:  48
b15_c57d:   lda ppuctrl_shadow                   ; 3C57D:  ad 71 00
b15_c580:   pha                         ; 3C580:  48
b15_c581:   bpl $c586                   ; 3C581:  10 03
b15_c583:   jsr $c54f                   ; 3C583:  20 4f c5
b15_c586:   pla                         ; 3C586:  68
b15_c587:   sta ppuctrl_shadow                   ; 3C587:  8d 71 00
b15_c58a:   pla                         ; 3C58A:  68
b15_c58b:   sta prg_bank_shadow                   ; 3C58B:  8d 73 00
b15_c58e:   sta $fff0                   ; 3C58E:  8d f0 ff
b15_c591:   lsr a                       ; 3C591:  4a
b15_c592:   sta $fff0                   ; 3C592:  8d f0 ff
b15_c595:   lsr a                       ; 3C595:  4a
b15_c596:   sta $fff0                   ; 3C596:  8d f0 ff
b15_c599:   lsr a                       ; 3C599:  4a
b15_c59a:   sta $fff0                   ; 3C59A:  8d f0 ff
b15_c59d:   lsr a                       ; 3C59D:  4a
b15_c59e:   sta $fff0                   ; 3C59E:  8d f0 ff
b15_c5a1:   lda ppuctrl_shadow                   ; 3C5A1:  ad 71 00
b15_c5a4:   bpl $c5a9                   ; 3C5A4:  10 03
b15_c5a6:   jsr $c68a                   ; 3C5A6:  20 8a c6
b15_c5a9:   rts                         ; 3C5A9:  60
syscall_sram_block_with_checksum:   lda vm_sp_hi                     ; 3C5AA:  a5 03
b15_c5ac:   cmp #$02                    ; 3C5AC:  c9 02
b15_c5ae:   beq $c5aa                   ; 3C5AE:  f0 fa
b15_c5b0:   jsr $c54f                   ; 3C5B0:  20 4f c5
b15_c5b3:   lda #$00                    ; 3C5B3:  a9 00
b15_c5b5:   sta $bfff                   ; 3C5B5:  8d ff bf
b15_c5b8:   sta $bfff                   ; 3C5B8:  8d ff bf
b15_c5bb:   sta $bfff                   ; 3C5BB:  8d ff bf
b15_c5be:   lda $0052                   ; 3C5BE:  ad 52 00
b15_c5c1:   sta $bfff                   ; 3C5C1:  8d ff bf
b15_c5c4:   lsr a                       ; 3C5C4:  4a
b15_c5c5:   sta $bfff                   ; 3C5C5:  8d ff bf
b15_c5c8:   ldy #$00                    ; 3C5C8:  a0 00
b15_c5ca:   lda ($56),y                 ; 3C5CA:  b1 56
b15_c5cc:   sta $0200,y                 ; 3C5CC:  99 00 02
b15_c5cf:   iny                         ; 3C5CF:  c8
b15_c5d0:   tya                         ; 3C5D0:  98
b15_c5d1:   cmp $0058                   ; 3C5D1:  cd 58 00
b15_c5d4:   bne $c5ca                   ; 3C5D4:  d0 f4
b15_c5d6:   lda #$00                    ; 3C5D6:  a9 00
b15_c5d8:   sta $bfff                   ; 3C5D8:  8d ff bf
b15_c5db:   sta $bfff                   ; 3C5DB:  8d ff bf
b15_c5de:   sta $bfff                   ; 3C5DE:  8d ff bf
b15_c5e1:   lda $0054                   ; 3C5E1:  ad 54 00
b15_c5e4:   sta $bfff                   ; 3C5E4:  8d ff bf
b15_c5e7:   lsr a                       ; 3C5E7:  4a
b15_c5e8:   sta $bfff                   ; 3C5E8:  8d ff bf
b15_c5eb:   ldy #$00                    ; 3C5EB:  a0 00
b15_c5ed:   lda $0200,y                 ; 3C5ED:  b9 00 02
b15_c5f0:   sta ($56),y                 ; 3C5F0:  91 56
b15_c5f2:   clc                         ; 3C5F2:  18
b15_c5f3:   adc brk_scratch_lo                   ; 3C5F3:  6d 66 00
b15_c5f6:   sta brk_scratch_lo                   ; 3C5F6:  8d 66 00
b15_c5f9:   lda brk_scratch_hi                   ; 3C5F9:  ad 67 00
b15_c5fc:   adc #$00                    ; 3C5FC:  69 00
b15_c5fe:   sta brk_scratch_hi                   ; 3C5FE:  8d 67 00
b15_c601:   iny                         ; 3C601:  c8
b15_c602:   tya                         ; 3C602:  98
b15_c603:   cmp $0058                   ; 3C603:  cd 58 00
b15_c606:   bne $c5ed                   ; 3C606:  d0 e5
b15_c608:   jsr $c68a                   ; 3C608:  20 8a c6
b15_c60b:   rts                         ; 3C60B:  60
syscall_set_chr_bank0_reg:   jsr $c54f                   ; 3C60C:  20 4f c5
b15_c60f:   lda #$00                    ; 3C60F:  a9 00
b15_c611:   sta $bfff                   ; 3C611:  8d ff bf
b15_c614:   sta $bfff                   ; 3C614:  8d ff bf
b15_c617:   sta $bfff                   ; 3C617:  8d ff bf
b15_c61a:   lda $0052                   ; 3C61A:  ad 52 00
b15_c61d:   sta $bfff                   ; 3C61D:  8d ff bf
b15_c620:   lsr a                       ; 3C620:  4a
b15_c621:   sta $bfff                   ; 3C621:  8d ff bf
b15_c624:   jsr $c68a                   ; 3C624:  20 8a c6
b15_c627:   rts                         ; 3C627:  60
controller_poll:   tax                         ; 3C628:  aa
b15_c629:   lda #$01                    ; 3C629:  a9 01
b15_c62b:   sta $4016                   ; 3C62B:  8d 16 40
b15_c62e:   lda #$00                    ; 3C62E:  a9 00
b15_c630:   sta $4016                   ; 3C630:  8d 16 40
b15_c633:   ldy #$08                    ; 3C633:  a0 08
b15_c635:   lda $4016,x                 ; 3C635:  bd 16 40
b15_c638:   lsr a                       ; 3C638:  4a
b15_c639:   ror p1_buttons,x                 ; 3C639:  7e 6e 00
b15_c63c:   dey                         ; 3C63C:  88
b15_c63d:   bne $c635                   ; 3C63D:  d0 f6
b15_c63f:   rts                         ; 3C63F:  60
ppu_rect_attr_addr:   lda $0056                   ; 3C640:  ad 56 00
b15_c643:   lsr a                       ; 3C643:  4a
b15_c644:   lsr a                       ; 3C644:  4a
b15_c645:   asl a                       ; 3C645:  0a
b15_c646:   asl a                       ; 3C646:  0a
b15_c647:   asl a                       ; 3C647:  0a
b15_c648:   sta brk_jmp_target_lo                   ; 3C648:  8d 68 00
b15_c64b:   lda $0054                   ; 3C64B:  ad 54 00
b15_c64e:   lsr a                       ; 3C64E:  4a
b15_c64f:   lsr a                       ; 3C64F:  4a
b15_c650:   clc                         ; 3C650:  18
b15_c651:   adc brk_jmp_target_lo                   ; 3C651:  6d 68 00
b15_c654:   sta brk_jmp_target_lo                   ; 3C654:  8d 68 00
b15_c657:   lda $0052                   ; 3C657:  ad 52 00
b15_c65a:   asl a                       ; 3C65A:  0a
b15_c65b:   asl a                       ; 3C65B:  0a
b15_c65c:   adc #$20                    ; 3C65C:  69 20
b15_c65e:   sta brk_jmp_target_hi                   ; 3C65E:  8d 69 00
b15_c661:   clc                         ; 3C661:  18
b15_c662:   lda #$c0                    ; 3C662:  a9 c0
b15_c664:   adc brk_jmp_target_lo                   ; 3C664:  6d 68 00
b15_c667:   sta brk_jmp_target_lo                   ; 3C667:  8d 68 00
b15_c66a:   lda #$03                    ; 3C66A:  a9 03
b15_c66c:   adc brk_jmp_target_hi                   ; 3C66C:  6d 69 00
b15_c66f:   sta brk_jmp_target_hi                   ; 3C66F:  8d 69 00
b15_c672:   rts                         ; 3C672:  60
ppu_rect_attr_shift:   lda $0054                   ; 3C673:  ad 54 00
b15_c676:   and #$03                    ; 3C676:  29 03
b15_c678:   lsr a                       ; 3C678:  4a
b15_c679:   sta mul_acc_lo                   ; 3C679:  8d 75 00
b15_c67c:   lda $0056                   ; 3C67C:  ad 56 00
b15_c67f:   and #$03                    ; 3C67F:  29 03
b15_c681:   lsr a                       ; 3C681:  4a
b15_c682:   asl a                       ; 3C682:  0a
b15_c683:   adc mul_acc_lo                   ; 3C683:  6d 75 00
b15_c686:   sta mul_acc_lo                   ; 3C686:  8d 75 00
b15_c689:   rts                         ; 3C689:  60
nmi_on:   lda ppuctrl_shadow                   ; 3C68A:  ad 71 00
b15_c68d:   ora #$80                    ; 3C68D:  09 80
b15_c68f:   jsr $c6a6                   ; 3C68F:  20 a6 c6
b15_c692:   rts                         ; 3C692:  60
ppu_safe_gate:   jsr $c54f                   ; 3C693:  20 4f c5
b15_c696:   jsr $c537                   ; 3C696:  20 37 c5
b15_c699:   jsr $c69d                   ; 3C699:  20 9d c6
b15_c69c:   rts                         ; 3C69C:  60
rendering_off:   lda ppumask_shadow                   ; 3C69D:  ad 72 00
b15_c6a0:   and #$e7                    ; 3C6A0:  29 e7
b15_c6a2:   jsr $c570                   ; 3C6A2:  20 70 c5
b15_c6a5:   rts                         ; 3C6A5:  60
write_ppuctrl:   sta $2000                   ; 3C6A6:  8d 00 20
b15_c6a9:   sta ppuctrl_shadow                   ; 3C6A9:  8d 71 00
b15_c6ac:   rts                         ; 3C6AC:  60
mul_xy_by_3:   lda #$00                    ; 3C6AD:  a9 00
b15_c6af:   sta mul_acc_lo                   ; 3C6AF:  8d 75 00
b15_c6b2:   sta mul_acc_hi                   ; 3C6B2:  8d 76 00
b15_c6b5:   cpx #$00                    ; 3C6B5:  e0 00
b15_c6b7:   beq $c6cd                   ; 3C6B7:  f0 14
b15_c6b9:   clc                         ; 3C6B9:  18
b15_c6ba:   tya                         ; 3C6BA:  98
b15_c6bb:   adc mul_acc_lo                   ; 3C6BB:  6d 75 00
b15_c6be:   sta mul_acc_lo                   ; 3C6BE:  8d 75 00
b15_c6c1:   lda mul_acc_hi                   ; 3C6C1:  ad 76 00
b15_c6c4:   adc #$00                    ; 3C6C4:  69 00
b15_c6c6:   sta mul_acc_hi                   ; 3C6C6:  8d 76 00
b15_c6c9:   dex                         ; 3C6C9:  ca
b15_c6ca:   jmp $c6b7                   ; 3C6CA:  4c b7 c6
b15_c6cd:   ldy mul_acc_lo                   ; 3C6CD:  ac 75 00
b15_c6d0:   ldx mul_acc_hi                   ; 3C6D0:  ae 76 00
b15_c6d3:   rts                         ; 3C6D3:  60
palette_upload:   lda palette_dirty                   ; 3C6D4:  ad 74 00
b15_c6d7:   beq $c710                   ; 3C6D7:  f0 37
b15_c6d9:   jsr $c69d                   ; 3C6D9:  20 9d c6
b15_c6dc:   lda #$3f                    ; 3C6DC:  a9 3f
b15_c6de:   sta $2006                   ; 3C6DE:  8d 06 20
b15_c6e1:   lda #$00                    ; 3C6E1:  a9 00
b15_c6e3:   sta $2006                   ; 3C6E3:  8d 06 20
b15_c6e6:   tax                         ; 3C6E6:  aa
b15_c6e7:   lda palette_shadow,x                 ; 3C6E7:  bd 00 07
b15_c6ea:   sta $2007                   ; 3C6EA:  8d 07 20
b15_c6ed:   inx                         ; 3C6ED:  e8
b15_c6ee:   cpx #$20                    ; 3C6EE:  e0 20
b15_c6f0:   bne $c6e7                   ; 3C6F0:  d0 f5
b15_c6f2:   lda #$3f                    ; 3C6F2:  a9 3f
b15_c6f4:   sta $2006                   ; 3C6F4:  8d 06 20
b15_c6f7:   lda #$00                    ; 3C6F7:  a9 00
b15_c6f9:   sta $2006                   ; 3C6F9:  8d 06 20
b15_c6fc:   sta $2006                   ; 3C6FC:  8d 06 20
b15_c6ff:   sta $2006                   ; 3C6FF:  8d 06 20
b15_c702:   sta $2005                   ; 3C702:  8d 05 20
b15_c705:   sta $2005                   ; 3C705:  8d 05 20
b15_c708:   jsr $c567                   ; 3C708:  20 67 c5
b15_c70b:   lda #$00                    ; 3C70B:  a9 00
b15_c70d:   sta palette_dirty                   ; 3C70D:  8d 74 00
b15_c710:   rts                         ; 3C710:  60
ppu_rect_attr_rmw:   lda brk_jmp_target_hi                   ; 3C711:  ad 69 00
b15_c714:   sta $2006                   ; 3C714:  8d 06 20
b15_c717:   lda brk_jmp_target_lo                   ; 3C717:  ad 68 00
b15_c71a:   sta $2006                   ; 3C71A:  8d 06 20
b15_c71d:   lda $2007                   ; 3C71D:  ad 07 20
b15_c720:   lda $2007                   ; 3C720:  ad 07 20
b15_c723:   sta mul_acc_hi                   ; 3C723:  8d 76 00
b15_c726:   lda #$fc                    ; 3C726:  a9 fc
b15_c728:   ldx mul_acc_lo                   ; 3C728:  ae 75 00
b15_c72b:   beq $c73b                   ; 3C72B:  f0 0e
b15_c72d:   sec                         ; 3C72D:  38
b15_c72e:   rol a                       ; 3C72E:  2a
b15_c72f:   rol a                       ; 3C72F:  2a
b15_c730:   clc                         ; 3C730:  18
b15_c731:   rol $0058                   ; 3C731:  2e 58 00
b15_c734:   rol $0058                   ; 3C734:  2e 58 00
b15_c737:   dex                         ; 3C737:  ca
b15_c738:   jmp $c72b                   ; 3C738:  4c 2b c7
b15_c73b:   and mul_acc_hi                   ; 3C73B:  2d 76 00
b15_c73e:   ora $0058                   ; 3C73E:  0d 58 00
b15_c741:   sta mul_acc_hi                   ; 3C741:  8d 76 00
b15_c744:   lda brk_jmp_target_hi                   ; 3C744:  ad 69 00
b15_c747:   sta $2006                   ; 3C747:  8d 06 20
b15_c74a:   lda brk_jmp_target_lo                   ; 3C74A:  ad 68 00
b15_c74d:   sta $2006                   ; 3C74D:  8d 06 20
b15_c750:   lda mul_acc_hi                   ; 3C750:  ad 76 00
b15_c753:   sta $2007                   ; 3C753:  8d 07 20
b15_c756:   rts                         ; 3C756:  60
reset_ppu_init:   jsr $c693                   ; 3C757:  20 93 c6
b15_c75a:   lda #$00                    ; 3C75A:  a9 00
b15_c75c:   sta $2006                   ; 3C75C:  8d 06 20
b15_c75f:   sta $2006                   ; 3C75F:  8d 06 20
b15_c762:   ldx #$00                    ; 3C762:  a2 00
b15_c764:   lda #$ff                    ; 3C764:  a9 ff
b15_c766:   lda $c775,x                 ; 3C766:  bd 75 c7
b15_c769:   sta $2007                   ; 3C769:  8d 07 20
b15_c76c:   inx                         ; 3C76C:  e8
b15_c76d:   cpx #$30                    ; 3C76D:  e0 30
b15_c76f:   bne $c766                   ; 3C76F:  d0 f5
b15_c771:   jsr $c558                   ; 3C771:  20 58 c5
b15_c774:   rts                         ; 3C774:  60
b15_c775:   .db $ff                     ; 3C775:  ff
b15_c776:   .db $ff                     ; 3C776:  ff
b15_c777:   .db $ff                     ; 3C777:  ff
b15_c778:   .db $ff                     ; 3C778:  ff
b15_c779:   .db $ff                     ; 3C779:  ff
b15_c77a:   .db $ff                     ; 3C77A:  ff
b15_c77b:   .db $ff                     ; 3C77B:  ff
b15_c77c:   .db $ff                     ; 3C77C:  ff
b15_c77d:   .db $ff                     ; 3C77D:  ff
b15_c77e:   .db $ff                     ; 3C77E:  ff
b15_c77f:   .db $ff                     ; 3C77F:  ff
b15_c780:   .db $ff                     ; 3C780:  ff
b15_c781:   .db $ff                     ; 3C781:  ff
b15_c782:   .db $ff                     ; 3C782:  ff
b15_c783:   .db $ff                     ; 3C783:  ff
b15_c784:   .db $ff                     ; 3C784:  ff
b15_c785:   rts                         ; 3C785:  60
b15_c786:   sei                         ; 3C786:  78
b15_c787:   ror $7e7f,x                 ; 3C787:  7e 7f 7e
b15_c78a:   sei                         ; 3C78A:  78
b15_c78b:   rts                         ; 3C78B:  60
b15_c78c:   brk                         ; 3C78C:  00
b15_c78d:   rts                         ; 3C78D:  60
b15_c78e:   sei                         ; 3C78E:  78
b15_c78f:   ror $7e7f,x                 ; 3C78F:  7e 7f 7e
b15_c792:   sei                         ; 3C792:  78
b15_c793:   rts                         ; 3C793:  60
b15_c794:   brk                         ; 3C794:  00
b15_c795:   brk                         ; 3C795:  00
b15_c796:   brk                         ; 3C796:  00
b15_c797:   brk                         ; 3C797:  00
b15_c798:   brk                         ; 3C798:  00
b15_c799:   brk                         ; 3C799:  00
b15_c79a:   brk                         ; 3C79A:  00
b15_c79b:   brk                         ; 3C79B:  00
b15_c79c:   brk                         ; 3C79C:  00
b15_c79d:   brk                         ; 3C79D:  00
b15_c79e:   brk                         ; 3C79E:  00
b15_c79f:   brk                         ; 3C79F:  00
b15_c7a0:   brk                         ; 3C7A0:  00
b15_c7a1:   brk                         ; 3C7A1:  00
b15_c7a2:   brk                         ; 3C7A2:  00
b15_c7a3:   brk                         ; 3C7A3:  00
b15_c7a4:   brk                         ; 3C7A4:  00
music_driver:   jsr $c7ac                   ; 3C7A5:  20 ac c7
b15_c7a8:   jsr $c817                   ; 3C7A8:  20 17 c8
b15_c7ab:   rts                         ; 3C7AB:  60
music_trigger_pass:   lda #$00                    ; 3C7AC:  a9 00
b15_c7ae:   sta music_voice_idx                   ; 3C7AE:  8d 79 00
b15_c7b1:   lda #$34                    ; 3C7B1:  a9 34
b15_c7b3:   sta music_ptr_lo                   ; 3C7B3:  8d 7a 00
b15_c7b6:   lda #$07                    ; 3C7B6:  a9 07
b15_c7b8:   sta music_ptr_hi                   ; 3C7B8:  8d 7b 00
b15_c7bb:   jsr $c7de                   ; 3C7BB:  20 de c7
b15_c7be:   jsr $c7c9                   ; 3C7BE:  20 c9 c7
b15_c7c1:   lda music_voice_idx                   ; 3C7C1:  ad 79 00
b15_c7c4:   cmp #$05                    ; 3C7C4:  c9 05
b15_c7c6:   bne $c7bb                   ; 3C7C6:  d0 f3
b15_c7c8:   rts                         ; 3C7C8:  60
music_advance_voice:   inc music_voice_idx                   ; 3C7C9:  ee 79 00
b15_c7cc:   lda music_ptr_lo                   ; 3C7CC:  ad 7a 00
b15_c7cf:   clc                         ; 3C7CF:  18
b15_c7d0:   adc #$09                    ; 3C7D0:  69 09
b15_c7d2:   sta music_ptr_lo                   ; 3C7D2:  8d 7a 00
b15_c7d5:   lda music_ptr_hi                   ; 3C7D5:  ad 7b 00
b15_c7d8:   adc #$00                    ; 3C7D8:  69 00
b15_c7da:   sta music_ptr_hi                   ; 3C7DA:  8d 7b 00
b15_c7dd:   rts                         ; 3C7DD:  60
music_voice_check:   ldy #$00                    ; 3C7DE:  a0 00
b15_c7e0:   lda (music_ptr_lo),y                 ; 3C7E0:  b1 7a
b15_c7e2:   beq $c7ee                   ; 3C7E2:  f0 0a
b15_c7e4:   cmp #$05                    ; 3C7E4:  c9 05
b15_c7e6:   bcc $c7eb                   ; 3C7E6:  90 03
b15_c7e8:   jmp $c7ee                   ; 3C7E8:  4c ee c7
b15_c7eb:   jsr $c7ef                   ; 3C7EB:  20 ef c7
b15_c7ee:   rts                         ; 3C7EE:  60
music_voice_play:   tax                         ; 3C7EF:  aa
b15_c7f0:   dex                         ; 3C7F0:  ca
b15_c7f1:   txa                         ; 3C7F1:  8a
b15_c7f2:   clc                         ; 3C7F2:  18
b15_c7f3:   adc #$05                    ; 3C7F3:  69 05
b15_c7f5:   ldy #$00                    ; 3C7F5:  a0 00
b15_c7f7:   sta (music_ptr_lo),y                 ; 3C7F7:  91 7a
b15_c7f9:   txa                         ; 3C7F9:  8a
b15_c7fa:   asl a                       ; 3C7FA:  0a
b15_c7fb:   asl a                       ; 3C7FB:  0a
b15_c7fc:   tax                         ; 3C7FC:  aa
b15_c7fd:   lda audio_mute_triangle                   ; 3C7FD:  ad 20 07
b15_c800:   beq $c809                   ; 3C800:  f0 07
b15_c802:   lda music_voice_idx                   ; 3C802:  ad 79 00
b15_c805:   cmp #$02                    ; 3C805:  c9 02
b15_c807:   beq $c816                   ; 3C807:  f0 0d
b15_c809:   ldy #$01                    ; 3C809:  a0 01
b15_c80b:   lda (music_ptr_lo),y                 ; 3C80B:  b1 7a
b15_c80d:   sta $4000,x                 ; 3C80D:  9d 00 40
b15_c810:   inx                         ; 3C810:  e8
b15_c811:   iny                         ; 3C811:  c8
b15_c812:   cpy #$05                    ; 3C812:  c0 05
b15_c814:   bne $c80b                   ; 3C814:  d0 f5
b15_c816:   rts                         ; 3C816:  60
music_sequencer_pass:   lda #$00                    ; 3C817:  a9 00
b15_c819:   sta music_voice_idx                   ; 3C819:  8d 79 00
b15_c81c:   lda #$34                    ; 3C81C:  a9 34
b15_c81e:   sta music_ptr_lo                   ; 3C81E:  8d 7a 00
b15_c821:   lda #$07                    ; 3C821:  a9 07
b15_c823:   sta music_ptr_hi                   ; 3C823:  8d 7b 00
b15_c826:   lda music_voice_idx                   ; 3C826:  ad 79 00
b15_c829:   tax                         ; 3C829:  aa
b15_c82a:   lda audio_mute_triangle,x                 ; 3C82A:  bd 20 07
b15_c82d:   beq $c832                   ; 3C82D:  f0 03
b15_c82f:   jsr $c83d                   ; 3C82F:  20 3d c8
b15_c832:   jsr $c7c9                   ; 3C832:  20 c9 c7
b15_c835:   lda music_voice_idx                   ; 3C835:  ad 79 00
b15_c838:   cmp #$05                    ; 3C838:  c9 05
b15_c83a:   bne $c826                   ; 3C83A:  d0 ea
b15_c83c:   rts                         ; 3C83C:  60
music_voice_step:   ldy #$00                    ; 3C83D:  a0 00
b15_c83f:   lda (music_ptr_lo),y                 ; 3C83F:  b1 7a
b15_c841:   cmp #$05                    ; 3C841:  c9 05
b15_c843:   bcc $c850                   ; 3C843:  90 0b
b15_c845:   jsr $c8c4                   ; 3C845:  20 c4 c8
b15_c848:   bne $c856                   ; 3C848:  d0 0c
b15_c84a:   jsr $c8ce                   ; 3C84A:  20 ce c8
b15_c84d:   jmp $c856                   ; 3C84D:  4c 56 c8
b15_c850:   jsr $c857                   ; 3C850:  20 57 c8
b15_c853:   jmp $c84a                   ; 3C853:  4c 4a c8
b15_c856:   rts                         ; 3C856:  60
music_load_note:   jsr $c877                   ; 3C857:  20 77 c8
b15_c85a:   jsr $c894                   ; 3C85A:  20 94 c8
b15_c85d:   ldy #$00                    ; 3C85D:  a0 00
b15_c85f:   sta (music_ptr_lo),y                 ; 3C85F:  91 7a
b15_c861:   jsr $c894                   ; 3C861:  20 94 c8
b15_c864:   ldy #$01                    ; 3C864:  a0 01
b15_c866:   sta (music_ptr_lo),y                 ; 3C866:  91 7a
b15_c868:   jsr $c894                   ; 3C868:  20 94 c8
b15_c86b:   ldy #$02                    ; 3C86B:  a0 02
b15_c86d:   sta (music_ptr_lo),y                 ; 3C86D:  91 7a
b15_c86f:   jsr $c894                   ; 3C86F:  20 94 c8
b15_c872:   ldy #$04                    ; 3C872:  a0 04
b15_c874:   sta (music_ptr_lo),y                 ; 3C874:  91 7a
b15_c876:   rts                         ; 3C876:  60
music_load_voice_cfg:   lda music_voice_idx                   ; 3C877:  ad 79 00
b15_c87a:   asl a                       ; 3C87A:  0a
b15_c87b:   clc                         ; 3C87B:  18
b15_c87c:   adc music_voice_idx                   ; 3C87C:  6d 79 00
b15_c87f:   tax                         ; 3C87F:  aa
b15_c880:   lda v0_config,x                 ; 3C880:  bd 25 07
b15_c883:   ldy #$05                    ; 3C883:  a0 05
b15_c885:   sta (music_ptr_lo),y                 ; 3C885:  91 7a
b15_c887:   lda $0726,x                 ; 3C887:  bd 26 07
b15_c88a:   iny                         ; 3C88A:  c8
b15_c88b:   sta (music_ptr_lo),y                 ; 3C88B:  91 7a
b15_c88d:   iny                         ; 3C88D:  c8
b15_c88e:   lda $0727,x                 ; 3C88E:  bd 27 07
b15_c891:   sta (music_ptr_lo),y                 ; 3C891:  91 7a
b15_c893:   rts                         ; 3C893:  60
music_read_stream_byte:   lda prg_bank_shadow                   ; 3C894:  ad 73 00
b15_c897:   pha                         ; 3C897:  48
b15_c898:   ldy #$05                    ; 3C898:  a0 05
b15_c89a:   lda (music_ptr_lo),y                 ; 3C89A:  b1 7a
b15_c89c:   jsr $c577                   ; 3C89C:  20 77 c5
b15_c89f:   ldy #$06                    ; 3C89F:  a0 06
b15_c8a1:   lda (music_ptr_lo),y                 ; 3C8A1:  b1 7a
b15_c8a3:   sta $007c                   ; 3C8A3:  8d 7c 00
b15_c8a6:   clc                         ; 3C8A6:  18
b15_c8a7:   adc #$01                    ; 3C8A7:  69 01
b15_c8a9:   sta (music_ptr_lo),y                 ; 3C8A9:  91 7a
b15_c8ab:   iny                         ; 3C8AB:  c8
b15_c8ac:   lda (music_ptr_lo),y                 ; 3C8AC:  b1 7a
b15_c8ae:   sta $007d                   ; 3C8AE:  8d 7d 00
b15_c8b1:   adc #$00                    ; 3C8B1:  69 00
b15_c8b3:   sta (music_ptr_lo),y                 ; 3C8B3:  91 7a
b15_c8b5:   ldx #$00                    ; 3C8B5:  a2 00
b15_c8b7:   lda ($7c,x)                 ; 3C8B7:  a1 7c
b15_c8b9:   sta $007e                   ; 3C8B9:  8d 7e 00
b15_c8bc:   pla                         ; 3C8BC:  68
b15_c8bd:   jsr $c577                   ; 3C8BD:  20 77 c5
b15_c8c0:   lda $007e                   ; 3C8C0:  ad 7e 00
b15_c8c3:   rts                         ; 3C8C3:  60
music_dec_duration:   ldy #$08                    ; 3C8C4:  a0 08
b15_c8c6:   lda (music_ptr_lo),y                 ; 3C8C6:  b1 7a
b15_c8c8:   tax                         ; 3C8C8:  aa
b15_c8c9:   dex                         ; 3C8C9:  ca
b15_c8ca:   txa                         ; 3C8CA:  8a
b15_c8cb:   sta (music_ptr_lo),y                 ; 3C8CB:  91 7a
b15_c8cd:   rts                         ; 3C8CD:  60
music_next_event:   jsr $c894                   ; 3C8CE:  20 94 c8
b15_c8d1:   cmp #$f0                    ; 3C8D1:  c9 f0
b15_c8d3:   bcs $c8de                   ; 3C8D3:  b0 09
b15_c8d5:   jsr $c929                   ; 3C8D5:  20 29 c9
b15_c8d8:   jsr $c990                   ; 3C8D8:  20 90 c9
b15_c8db:   jmp $c8e3                   ; 3C8DB:  4c e3 c8
b15_c8de:   jsr $c8e4                   ; 3C8DE:  20 e4 c8
b15_c8e1:   bcc $c8ce                   ; 3C8E1:  90 eb
b15_c8e3:   rts                         ; 3C8E3:  60
music_handle_command:   cmp #$f0                    ; 3C8E4:  c9 f0
b15_c8e6:   beq $c8eb                   ; 3C8E6:  f0 03
b15_c8e8:   jmp $c906                   ; 3C8E8:  4c 06 c9
b15_c8eb:   ldy #$00                    ; 3C8EB:  a0 00
b15_c8ed:   lda (music_ptr_lo),y                 ; 3C8ED:  b1 7a
b15_c8ef:   sec                         ; 3C8EF:  38
b15_c8f0:   sbc #$05                    ; 3C8F0:  e9 05
b15_c8f2:   asl a                       ; 3C8F2:  0a
b15_c8f3:   asl a                       ; 3C8F3:  0a
b15_c8f4:   tax                         ; 3C8F4:  aa
b15_c8f5:   lda #$00                    ; 3C8F5:  a9 00
b15_c8f7:   sta $4000,x                 ; 3C8F7:  9d 00 40
b15_c8fa:   ldx music_voice_idx                   ; 3C8FA:  ae 79 00
b15_c8fd:   lda #$00                    ; 3C8FD:  a9 00
b15_c8ff:   sta audio_mute_triangle,x                 ; 3C8FF:  9d 20 07
b15_c902:   sta (music_ptr_lo),y                 ; 3C902:  91 7a
b15_c904:   sec                         ; 3C904:  38
b15_c905:   rts                         ; 3C905:  60
music_restart_stream:   lda music_voice_idx                   ; 3C906:  ad 79 00
b15_c909:   asl a                       ; 3C909:  0a
b15_c90a:   clc                         ; 3C90A:  18
b15_c90b:   adc music_voice_idx                   ; 3C90B:  6d 79 00
b15_c90e:   tax                         ; 3C90E:  aa
b15_c90f:   ldy #$05                    ; 3C90F:  a0 05
b15_c911:   lda v0_config,x                 ; 3C911:  bd 25 07
b15_c914:   sta (music_ptr_lo),y                 ; 3C914:  91 7a
b15_c916:   iny                         ; 3C916:  c8
b15_c917:   lda $0726,x                 ; 3C917:  bd 26 07
b15_c91a:   sta (music_ptr_lo),y                 ; 3C91A:  91 7a
b15_c91c:   iny                         ; 3C91C:  c8
b15_c91d:   lda $0727,x                 ; 3C91D:  bd 27 07
b15_c920:   sta (music_ptr_lo),y                 ; 3C920:  91 7a
b15_c922:   ldy #$00                    ; 3C922:  a0 00
b15_c924:   lda #$00                    ; 3C924:  a9 00
b15_c926:   sta (music_ptr_lo),y                 ; 3C926:  91 7a
b15_c928:   rts                         ; 3C928:  60
music_set_pitch:   jsr $c94b                   ; 3C929:  20 4b c9
b15_c92c:   ldy #$04                    ; 3C92C:  a0 04
b15_c92e:   lda (music_ptr_lo),y                 ; 3C92E:  b1 7a
b15_c930:   and #$f8                    ; 3C930:  29 f8
b15_c932:   ora $007f                   ; 3C932:  0d 7f 00
b15_c935:   sta (music_ptr_lo),y                 ; 3C935:  91 7a
b15_c937:   dey                         ; 3C937:  88
b15_c938:   lda $007e                   ; 3C938:  ad 7e 00
b15_c93b:   sta (music_ptr_lo),y                 ; 3C93B:  91 7a
b15_c93d:   ldy #$00                    ; 3C93D:  a0 00
b15_c93f:   lda (music_ptr_lo),y                 ; 3C93F:  b1 7a
b15_c941:   cmp #$05                    ; 3C941:  c9 05
b15_c943:   bcc $c94a                   ; 3C943:  90 05
b15_c945:   sec                         ; 3C945:  38
b15_c946:   sbc #$04                    ; 3C946:  e9 04
b15_c948:   sta (music_ptr_lo),y                 ; 3C948:  91 7a
b15_c94a:   rts                         ; 3C94A:  60
music_note_to_period:   pha                         ; 3C94B:  48
b15_c94c:   and #$0f                    ; 3C94C:  29 0f
b15_c94e:   asl a                       ; 3C94E:  0a
b15_c94f:   tax                         ; 3C94F:  aa
b15_c950:   lda $c970,x                 ; 3C950:  bd 70 c9
b15_c953:   sta $007e                   ; 3C953:  8d 7e 00
b15_c956:   inx                         ; 3C956:  e8
b15_c957:   lda $c970,x                 ; 3C957:  bd 70 c9
b15_c95a:   sta $007f                   ; 3C95A:  8d 7f 00
b15_c95d:   pla                         ; 3C95D:  68
b15_c95e:   lsr a                       ; 3C95E:  4a
b15_c95f:   lsr a                       ; 3C95F:  4a
b15_c960:   lsr a                       ; 3C960:  4a
b15_c961:   lsr a                       ; 3C961:  4a
b15_c962:   tax                         ; 3C962:  aa
b15_c963:   beq $c96f                   ; 3C963:  f0 0a
b15_c965:   lsr $007f                   ; 3C965:  4e 7f 00
b15_c968:   ror $007e                   ; 3C968:  6e 7e 00
b15_c96b:   dex                         ; 3C96B:  ca
b15_c96c:   jmp $c963                   ; 3C96C:  4c 63 c9
b15_c96f:   rts                         ; 3C96F:  60
b15_c970:   sbc $c003,y                 ; 3C970:  f9 03 c0
b15_c973:   .db vm_sp_hi                     ; 3C973:  03
b15_c974:   txa                         ; 3C974:  8a
b15_c975:   .db vm_sp_hi                     ; 3C975:  03
b15_c976:   .db $57                     ; 3C976:  57
b15_c977:   .db vm_sp_hi                     ; 3C977:  03
b15_c978:   .db $27                     ; 3C978:  27
b15_c979:   .db vm_sp_hi                     ; 3C979:  03
b15_c97a:   .db $fa                     ; 3C97A:  fa
b15_c97b:   .db vm_sp_lo                     ; 3C97B:  02
b15_c97c:   .db $cf                     ; 3C97C:  cf
b15_c97d:   .db vm_sp_lo                     ; 3C97D:  02
b15_c97e:   .db $a7                     ; 3C97E:  a7
b15_c97f:   .db vm_sp_lo                     ; 3C97F:  02
b15_c980:   sta (vm_sp_lo,x)                 ; 3C980:  81 02
b15_c982:   eor $3b02,x                 ; 3C982:  5d 02 3b
b15_c985:   .db vm_sp_lo                     ; 3C985:  02
b15_c986:   .db $1b                     ; 3C986:  1b
b15_c987:   .db vm_sp_lo                     ; 3C987:  02
b15_c988:   brk                         ; 3C988:  00
b15_c989:   brk                         ; 3C989:  00
b15_c98a:   brk                         ; 3C98A:  00
b15_c98b:   brk                         ; 3C98B:  00
b15_c98c:   brk                         ; 3C98C:  00
b15_c98d:   brk                         ; 3C98D:  00
b15_c98e:   brk                         ; 3C98E:  00
b15_c98f:   brk                         ; 3C98F:  00
music_set_duration:   jsr $c894                   ; 3C990:  20 94 c8
b15_c993:   asl a                       ; 3C993:  0a
b15_c994:   asl a                       ; 3C994:  0a
b15_c995:   asl a                       ; 3C995:  0a
b15_c996:   ldy #$08                    ; 3C996:  a0 08
b15_c998:   sta (music_ptr_lo),y                 ; 3C998:  91 7a
b15_c99a:   rts                         ; 3C99A:  60
b15_c99b:   .db $ff                     ; 3C99B:  ff
b15_c99c:   .db $ff                     ; 3C99C:  ff
b15_c99d:   .db $ff                     ; 3C99D:  ff
b15_c99e:   .db $ff                     ; 3C99E:  ff
b15_c99f:   .db $ff                     ; 3C99F:  ff
b15_c9a0:   .db $ff                     ; 3C9A0:  ff
b15_c9a1:   .db $ff                     ; 3C9A1:  ff
b15_c9a2:   .db $ff                     ; 3C9A2:  ff
b15_c9a3:   .db $ff                     ; 3C9A3:  ff
b15_c9a4:   .db $ff                     ; 3C9A4:  ff
b15_c9a5:   .db $ff                     ; 3C9A5:  ff
b15_c9a6:   .db $ff                     ; 3C9A6:  ff
b15_c9a7:   .db $ff                     ; 3C9A7:  ff
b15_c9a8:   .db $ff                     ; 3C9A8:  ff
b15_c9a9:   .db $ff                     ; 3C9A9:  ff
b15_c9aa:   .db $ff                     ; 3C9AA:  ff
b15_c9ab:   .db $ff                     ; 3C9AB:  ff
b15_c9ac:   .db $ff                     ; 3C9AC:  ff
b15_c9ad:   .db $ff                     ; 3C9AD:  ff
b15_c9ae:   .db $ff                     ; 3C9AE:  ff
b15_c9af:   .db $ff                     ; 3C9AF:  ff
b15_c9b0:   .db $ff                     ; 3C9B0:  ff
b15_c9b1:   .db $ff                     ; 3C9B1:  ff
b15_c9b2:   .db $ff                     ; 3C9B2:  ff
b15_c9b3:   .db $ff                     ; 3C9B3:  ff
b15_c9b4:   .db $ff                     ; 3C9B4:  ff
b15_c9b5:   .db $ff                     ; 3C9B5:  ff
b15_c9b6:   .db $ff                     ; 3C9B6:  ff
b15_c9b7:   .db $ff                     ; 3C9B7:  ff
b15_c9b8:   .db $ff                     ; 3C9B8:  ff
b15_c9b9:   .db $ff                     ; 3C9B9:  ff
b15_c9ba:   .db $ff                     ; 3C9BA:  ff
b15_c9bb:   .db $ff                     ; 3C9BB:  ff
b15_c9bc:   .db $ff                     ; 3C9BC:  ff
b15_c9bd:   .db $ff                     ; 3C9BD:  ff
b15_c9be:   .db $ff                     ; 3C9BE:  ff
b15_c9bf:   .db $ff                     ; 3C9BF:  ff
b15_c9c0:   .db $ff                     ; 3C9C0:  ff
b15_c9c1:   .db $ff                     ; 3C9C1:  ff
b15_c9c2:   .db $ff                     ; 3C9C2:  ff
b15_c9c3:   .db $ff                     ; 3C9C3:  ff
b15_c9c4:   .db $ff                     ; 3C9C4:  ff
b15_c9c5:   .db $ff                     ; 3C9C5:  ff
b15_c9c6:   .db $ff                     ; 3C9C6:  ff
b15_c9c7:   .db $ff                     ; 3C9C7:  ff
b15_c9c8:   .db $ff                     ; 3C9C8:  ff
b15_c9c9:   .db $ff                     ; 3C9C9:  ff
b15_c9ca:   .db $ff                     ; 3C9CA:  ff
b15_c9cb:   .db $ff                     ; 3C9CB:  ff
b15_c9cc:   .db $ff                     ; 3C9CC:  ff
b15_c9cd:   .db $ff                     ; 3C9CD:  ff
b15_c9ce:   .db $ff                     ; 3C9CE:  ff
b15_c9cf:   .db $ff                     ; 3C9CF:  ff
b15_c9d0:   .db $ff                     ; 3C9D0:  ff
b15_c9d1:   .db $ff                     ; 3C9D1:  ff
b15_c9d2:   .db $ff                     ; 3C9D2:  ff
b15_c9d3:   .db $ff                     ; 3C9D3:  ff
b15_c9d4:   .db $ff                     ; 3C9D4:  ff
b15_c9d5:   .db $ff                     ; 3C9D5:  ff
b15_c9d6:   .db $ff                     ; 3C9D6:  ff
b15_c9d7:   .db $ff                     ; 3C9D7:  ff
b15_c9d8:   .db $ff                     ; 3C9D8:  ff
b15_c9d9:   .db $ff                     ; 3C9D9:  ff
b15_c9da:   .db $ff                     ; 3C9DA:  ff
b15_c9db:   .db $ff                     ; 3C9DB:  ff
b15_c9dc:   .db $ff                     ; 3C9DC:  ff
b15_c9dd:   .db $ff                     ; 3C9DD:  ff
b15_c9de:   .db $ff                     ; 3C9DE:  ff
b15_c9df:   .db $ff                     ; 3C9DF:  ff
b15_c9e0:   .db $ff                     ; 3C9E0:  ff
b15_c9e1:   .db $ff                     ; 3C9E1:  ff
b15_c9e2:   .db $ff                     ; 3C9E2:  ff
b15_c9e3:   .db $ff                     ; 3C9E3:  ff
b15_c9e4:   .db $ff                     ; 3C9E4:  ff
b15_c9e5:   .db $ff                     ; 3C9E5:  ff
b15_c9e6:   .db $ff                     ; 3C9E6:  ff
b15_c9e7:   .db $ff                     ; 3C9E7:  ff
b15_c9e8:   .db $ff                     ; 3C9E8:  ff
b15_c9e9:   .db $ff                     ; 3C9E9:  ff
b15_c9ea:   .db $ff                     ; 3C9EA:  ff
b15_c9eb:   .db $ff                     ; 3C9EB:  ff
b15_c9ec:   .db $ff                     ; 3C9EC:  ff
b15_c9ed:   .db $ff                     ; 3C9ED:  ff
b15_c9ee:   .db $ff                     ; 3C9EE:  ff
b15_c9ef:   .db $ff                     ; 3C9EF:  ff
b15_c9f0:   .db $ff                     ; 3C9F0:  ff
b15_c9f1:   .db $ff                     ; 3C9F1:  ff
b15_c9f2:   .db $ff                     ; 3C9F2:  ff
b15_c9f3:   .db $ff                     ; 3C9F3:  ff
b15_c9f4:   .db $ff                     ; 3C9F4:  ff
b15_c9f5:   .db $ff                     ; 3C9F5:  ff
b15_c9f6:   .db $ff                     ; 3C9F6:  ff
b15_c9f7:   .db $ff                     ; 3C9F7:  ff
b15_c9f8:   .db $ff                     ; 3C9F8:  ff
b15_c9f9:   .db $ff                     ; 3C9F9:  ff
b15_c9fa:   .db $ff                     ; 3C9FA:  ff
b15_c9fb:   .db $ff                     ; 3C9FB:  ff
b15_c9fc:   .db $ff                     ; 3C9FC:  ff
b15_c9fd:   .db $ff                     ; 3C9FD:  ff
b15_c9fe:   .db $ff                     ; 3C9FE:  ff
b15_c9ff:   .db $ff                     ; 3C9FF:  ff
b15_ca00:   jmp scratch_ptr_lo                   ; 3CA00:  4c 00 00
call_bank10_entry:   jsr $e823                   ; 3CA03:  20 23 e8
b15_ca06:   brk                         ; 3CA06:  00
b15_ca07:   brk                         ; 3CA07:  00
b15_ca08:   .db $0c                     ; 3CA08:  0c
b15_ca09:   tay                         ; 3CA09:  a8
b15_ca0a:   sbc $7f                     ; 3CA0A:  e5 7f
b15_ca0c:   ror a                       ; 3CA0C:  6a
b15_ca0d:   sbc #$b1                    ; 3CA0D:  e9 b1
b15_ca0f:   .db $cb                     ; 3CA0F:  cb
b15_ca10:   .db vm_sp_lo                     ; 3CA10:  02
b15_ca11:   .db $cf                     ; 3CA11:  cf
deduct_byte_at:   jsr $e823                   ; 3CA12:  20 23 e8
b15_ca15:   brk                         ; 3CA15:  00
b15_ca16:   brk                         ; 3CA16:  00
b15_ca17:   .db $3c                     ; 3CA17:  3c
b15_ca18:   ldy #$0d                    ; 3CA18:  a0 0d
b15_ca1a:   brk                         ; 3CA1A:  00
b15_ca1b:   .db $b3                     ; 3CA1B:  b3
b15_ca1c:   .db $0c                     ; 3CA1C:  0c
b15_ca1d:   .db $d3                     ; 3CA1D:  d3
b15_ca1e:   ldy $c2,x                   ; 3CA1E:  b4 c2
b15_ca20:   cld                         ; 3CA20:  d8
b15_ca21:   .db $27                     ; 3CA21:  27
b15_ca22:   dex                         ; 3CA22:  ca
b15_ca23:   rti                         ; 3CA23:  40
b15_ca24:   dec $2f,x                   ; 3CA24:  d6 2f
b15_ca26:   dex                         ; 3CA26:  ca
b15_ca27:   ldy #$0d                    ; 3CA27:  a0 0d
b15_ca29:   brk                         ; 3CA29:  00
b15_ca2a:   .db $b3                     ; 3CA2A:  b3
b15_ca2b:   .db $0c                     ; 3CA2B:  0c
b15_ca2c:   .db $d3                     ; 3CA2C:  d3
b15_ca2d:   ldy $bc,x                   ; 3CA2D:  b4 bc
b15_ca2f:   .db $d4                     ; 3CA2F:  d4
b15_ca30:   .db $cf                     ; 3CA30:  cf
word_sub_saturating:   jsr $e823                   ; 3CA31:  20 23 e8
b15_ca34:   inc $0cff,x                 ; 3CA34:  fe ff 0c
b15_ca37:   bcs $ca56                   ; 3CA37:  b0 1d
b15_ca39:   ldy $502b,x                 ; 3CA39:  bc 2b 50
b15_ca3c:   .db $c2                     ; 3CA3C:  c2
b15_ca3d:   cld                         ; 3CA3D:  d8
b15_ca3e:   .db $42                     ; 3CA3E:  42
b15_ca3f:   dex                         ; 3CA3F:  ca
b15_ca40:   rti                         ; 3CA40:  40
b15_ca41:   .db $2b                     ; 3CA41:  2b
b15_ca42:   .db $3c                     ; 3CA42:  3c
b15_ca43:   .db $0b                     ; 3CA43:  0b
b15_ca44:   lda ($cf),y                 ; 3CA44:  b1 cf
rng_next_wrapper:   jsr $e823                   ; 3CA46:  20 23 e8
b15_ca49:   brk                         ; 3CA49:  00
b15_ca4a:   brk                         ; 3CA4A:  00
b15_ca4b:   sta $e911                   ; 3CA4B:  8d 11 e9
b15_ca4e:   rol $f2                     ; 3CA4E:  26 f2
b15_ca50:   .db vm_sp_lo                     ; 3CA50:  02
b15_ca51:   .db $cf                     ; 3CA51:  cf
rng_mod:   jsr $e823                   ; 3CA52:  20 23 e8
b15_ca55:   brk                         ; 3CA55:  00
b15_ca56:   brk                         ; 3CA56:  00
b15_ca57:   .db $0c                     ; 3CA57:  0c
b15_ca58:   eor ($c2),y                 ; 3CA58:  51 c2
b15_ca5a:   cld                         ; 3CA5A:  d8
b15_ca5b:   .db $5f                     ; 3CA5B:  5f
b15_ca5c:   dex                         ; 3CA5C:  ca
b15_ca5d:   rti                         ; 3CA5D:  40
b15_ca5e:   .db $cf                     ; 3CA5E:  cf
b15_ca5f:   ldy $ca46                   ; 3CA5F:  ac 46 ca
b15_ca62:   .db ppu_queue_a_lo                     ; 3CA62:  1c
b15_ca63:   lda $20cf,y                 ; 3CA63:  b9 cf 20
b15_ca66:   .db $23                     ; 3CA66:  23
b15_ca67:   inx                         ; 3CA67:  e8
b15_ca68:   brk                         ; 3CA68:  00
b15_ca69:   brk                         ; 3CA69:  00
b15_ca6a:   .db skip_wallclock                     ; 3CA6A:  89
b15_ca6b:   bmi $ca89                   ; 3CA6B:  30 1c
b15_ca6d:   .db $c7                     ; 3CA6D:  c7
b15_ca6e:   cld                         ; 3CA6E:  d8
b15_ca6f:   sei                         ; 3CA6F:  78
b15_ca70:   dex                         ; 3CA70:  ca
b15_ca71:   .db $0c                     ; 3CA71:  0c
b15_ca72:   .db $8b                     ; 3CA72:  8b
b15_ca73:   and $d7c7,y                 ; 3CA73:  39 c7 d7
b15_ca76:   .db $7c                     ; 3CA76:  7c
b15_ca77:   dex                         ; 3CA77:  ca
b15_ca78:   rti                         ; 3CA78:  40
b15_ca79:   dec $7d,x                   ; 3CA79:  d6 7d
b15_ca7b:   dex                         ; 3CA7B:  ca
b15_ca7c:   eor ($cf,x)                 ; 3CA7C:  41 cf
strlen:   jsr $e823                   ; 3CA7E:  20 23 e8
b15_ca81:   inc $40ff,x                 ; 3CA81:  fe ff 40
b15_ca84:   .db $2b                     ; 3CA84:  2b
b15_ca85:   dec palette_alt,x                   ; 3CA85:  d6 90
b15_ca87:   dex                         ; 3CA87:  ca
b15_ca88:   .db $0c                     ; 3CA88:  0c
b15_ca89:   bne $cab7                   ; 3CA89:  d0 2c
b15_ca8b:   cmp ($0b),y                 ; 3CA8B:  d1 0b
b15_ca8d:   bne $caba                   ; 3CA8D:  d0 2b
b15_ca8f:   cmp ($0c),y                 ; 3CA8F:  d1 0c
b15_ca91:   .db $d3                     ; 3CA91:  d3
b15_ca92:   .db $d7                     ; 3CA92:  d7
b15_ca93:   dey                         ; 3CA93:  88
b15_ca94:   dex                         ; 3CA94:  ca
b15_ca95:   .db $0b                     ; 3CA95:  0b
b15_ca96:   .db $cf                     ; 3CA96:  cf
fill_bytes:   jsr $e823                   ; 3CA97:  20 23 e8
b15_ca9a:   brk                         ; 3CA9A:  00
b15_ca9b:   brk                         ; 3CA9B:  00
b15_ca9c:   dec $ab,x                   ; 3CA9C:  d6 ab
b15_ca9e:   dex                         ; 3CA9E:  ca
b15_ca9f:   .db $0c                     ; 3CA9F:  0c
b15_caa0:   bne $cace                   ; 3CAA0:  d0 2c
b15_caa2:   cmp ($b3),y                 ; 3CAA2:  d1 b3
b15_caa4:   ldy #$0f                    ; 3CAA4:  a0 0f
b15_caa6:   brk                         ; 3CAA6:  00
b15_caa7:   .db $d4                     ; 3CAA7:  d4
b15_caa8:   ora $2dd1                   ; 3CAA8:  0d d1 2d
b15_caab:   ora $9fd7                   ; 3CAAB:  0d d7 9f
b15_caae:   dex                         ; 3CAAE:  ca
b15_caaf:   .db $cf                     ; 3CAAF:  cf
strcmp:   jsr $e823                   ; 3CAB0:  20 23 e8
b15_cab3:   brk                         ; 3CAB3:  00
b15_cab4:   brk                         ; 3CAB4:  00
b15_cab5:   dec $c7,x                   ; 3CAB5:  d6 c7
b15_cab7:   dex                         ; 3CAB7:  ca
b15_cab8:   .db $0c                     ; 3CAB8:  0c
b15_cab9:   .db $d3                     ; 3CAB9:  d3
b15_caba:   .db $d7                     ; 3CABA:  d7
b15_cabb:   .db $bf                     ; 3CABB:  bf
b15_cabc:   dex                         ; 3CABC:  ca
b15_cabd:   rti                         ; 3CABD:  40
b15_cabe:   .db $cf                     ; 3CABE:  cf
b15_cabf:   .db $0c                     ; 3CABF:  0c
b15_cac0:   bne $caee                   ; 3CAC0:  d0 2c
b15_cac2:   cmp ($0d),y                 ; 3CAC2:  d1 0d
b15_cac4:   bne $caf3                   ; 3CAC4:  d0 2d
b15_cac6:   cmp ($0d),y                 ; 3CAC6:  d1 0d
b15_cac8:   .db $d3                     ; 3CAC8:  d3
b15_cac9:   .db $b3                     ; 3CAC9:  b3
b15_caca:   .db $0c                     ; 3CACA:  0c
b15_cacb:   .db $d3                     ; 3CACB:  d3
b15_cacc:   ldy $c0,x                   ; 3CACC:  b4 c0
b15_cace:   .db $d7                     ; 3CACE:  d7
b15_cacf:   clv                         ; 3CACF:  b8
b15_cad0:   dex                         ; 3CAD0:  ca
b15_cad1:   ora $b3d3                   ; 3CAD1:  0d d3 b3
b15_cad4:   .db $0c                     ; 3CAD4:  0c
b15_cad5:   .db $d3                     ; 3CAD5:  d3
b15_cad6:   ldy $bc,x                   ; 3CAD6:  b4 bc
b15_cad8:   .db $cf                     ; 3CAD8:  cf
strcpy:   jsr $e823                   ; 3CAD9:  20 23 e8
b15_cadc:   inc $0cff,x                 ; 3CADC:  fe ff 0c
b15_cadf:   .db $2b                     ; 3CADF:  2b
b15_cae0:   .db $0c                     ; 3CAE0:  0c
b15_cae1:   bne $cb0f                   ; 3CAE1:  d0 2c
b15_cae3:   cmp ($b3),y                 ; 3CAE3:  d1 b3
b15_cae5:   ora $2dd0                   ; 3CAE5:  0d d0 2d
b15_cae8:   cmp ($d3),y                 ; 3CAE8:  d1 d3
b15_caea:   .db $d4                     ; 3CAEA:  d4
b15_caeb:   .db $d7                     ; 3CAEB:  d7
b15_caec:   cpx #$ca                    ; 3CAEC:  e0 ca
b15_caee:   .db $0b                     ; 3CAEE:  0b
b15_caef:   .db $cf                     ; 3CAEF:  cf
memchr:   jsr $e823                   ; 3CAF0:  20 23 e8
b15_caf3:   brk                         ; 3CAF3:  00
b15_caf4:   brk                         ; 3CAF4:  00
b15_caf5:   dec $0b,x                   ; 3CAF5:  d6 0b
b15_caf7:   .db $cb                     ; 3CAF7:  cb
b15_caf8:   ldy #$0d                    ; 3CAF8:  a0 0d
b15_cafa:   brk                         ; 3CAFA:  00
b15_cafb:   .db $b3                     ; 3CAFB:  b3
b15_cafc:   .db $0c                     ; 3CAFC:  0c
b15_cafd:   .db $d3                     ; 3CAFD:  d3
b15_cafe:   ldy $c0,x                   ; 3CAFE:  b4 c0
b15_cb00:   cld                         ; 3CB00:  d8
b15_cb01:   ora $cb                     ; 3CB01:  05 cb
b15_cb03:   .db $0c                     ; 3CB03:  0c
b15_cb04:   .db $cf                     ; 3CB04:  cf
b15_cb05:   .db $0c                     ; 3CB05:  0c
b15_cb06:   bne $cb34                   ; 3CB06:  d0 2c
b15_cb08:   asl $2ed1                   ; 3CB08:  0e d1 2e
b15_cb0b:   asl $f8d7                   ; 3CB0B:  0e d7 f8
b15_cb0e:   dex                         ; 3CB0E:  ca
b15_cb0f:   rti                         ; 3CB0F:  40
b15_cb10:   .db $cf                     ; 3CB10:  cf
is_lower:   jsr $e823                   ; 3CB11:  20 23 e8
b15_cb14:   brk                         ; 3CB14:  00
b15_cb15:   brk                         ; 3CB15:  00
b15_cb16:   ldy #$0b                    ; 3CB16:  a0 0b
b15_cb18:   brk                         ; 3CB18:  00
b15_cb19:   .db $b3                     ; 3CB19:  b3
b15_cb1a:   .db skip_wallclock                     ; 3CB1A:  89
b15_cb1b:   adc ($b4,x)                 ; 3CB1B:  61 b4
b15_cb1d:   .db $c3                     ; 3CB1D:  c3
b15_cb1e:   cld                         ; 3CB1E:  d8
b15_cb1f:   rol a                       ; 3CB1F:  2a
b15_cb20:   .db $cb                     ; 3CB20:  cb
b15_cb21:   ldy #$0b                    ; 3CB21:  a0 0b
b15_cb23:   brk                         ; 3CB23:  00
b15_cb24:   .db $8b                     ; 3CB24:  8b
b15_cb25:   .db music_ptr_lo                     ; 3CB25:  7a
b15_cb26:   .db $c3                     ; 3CB26:  c3
b15_cb27:   .db $d7                     ; 3CB27:  d7
b15_cb28:   rol $40cb                   ; 3CB28:  2e cb 40
b15_cb2b:   dec $2f,x                   ; 3CB2B:  d6 2f
b15_cb2d:   .db $cb                     ; 3CB2D:  cb
b15_cb2e:   eor ($cf,x)                 ; 3CB2E:  41 cf
to_upper:   jsr $e823                   ; 3CB30:  20 23 e8
b15_cb33:   brk                         ; 3CB33:  00
b15_cb34:   brk                         ; 3CB34:  00
b15_cb35:   ldy #$0b                    ; 3CB35:  a0 0b
b15_cb37:   brk                         ; 3CB37:  00
b15_cb38:   .db $b3                     ; 3CB38:  b3
b15_cb39:   sbc #$11                    ; 3CB39:  e9 11
b15_cb3b:   .db $cb                     ; 3CB3B:  cb
b15_cb3c:   .db vm_sp_lo                     ; 3CB3C:  02
b15_cb3d:   cld                         ; 3CB3D:  d8
b15_cb3e:   pha                         ; 3CB3E:  48
b15_cb3f:   .db $cb                     ; 3CB3F:  cb
b15_cb40:   ldy #$0b                    ; 3CB40:  a0 0b
b15_cb42:   brk                         ; 3CB42:  00
b15_cb43:   .db $8f                     ; 3CB43:  8f
b15_cb44:   cpx #$d6                    ; 3CB44:  e0 d6
b15_cb46:   .db $4b                     ; 3CB46:  4b
b15_cb47:   .db $cb                     ; 3CB47:  cb
b15_cb48:   ldy #$0b                    ; 3CB48:  a0 0b
b15_cb4a:   brk                         ; 3CB4A:  00
b15_cb4b:   .db $cf                     ; 3CB4B:  cf
abs16:   jsr $e823                   ; 3CB4C:  20 23 e8
b15_cb4f:   brk                         ; 3CB4F:  00
b15_cb50:   brk                         ; 3CB50:  00
b15_cb51:   .db $0c                     ; 3CB51:  0c
b15_cb52:   bvc $cb16                   ; 3CB52:  50 c2
b15_cb54:   cld                         ; 3CB54:  d8
b15_cb55:   .db $5c                     ; 3CB55:  5c
b15_cb56:   .db $cb                     ; 3CB56:  cb
b15_cb57:   .db $0c                     ; 3CB57:  0c
b15_cb58:   .db $cb                     ; 3CB58:  cb
b15_cb59:   dec $5d,x                   ; 3CB59:  d6 5d
b15_cb5b:   .db $cb                     ; 3CB5B:  cb
b15_cb5c:   .db $0c                     ; 3CB5C:  0c
b15_cb5d:   .db $cf                     ; 3CB5D:  cf
min_word:   jsr $e823                   ; 3CB5E:  20 23 e8
b15_cb61:   brk                         ; 3CB61:  00
b15_cb62:   brk                         ; 3CB62:  00
b15_cb63:   .db $0c                     ; 3CB63:  0c
b15_cb64:   ora $d8c2,x                 ; 3CB64:  1d c2 d8
b15_cb67:   adc $0ccb                   ; 3CB67:  6d cb 0c
b15_cb6a:   dec p1_buttons,x                   ; 3CB6A:  d6 6e
b15_cb6c:   .db $cb                     ; 3CB6C:  cb
b15_cb6d:   ora $20cf                   ; 3CB6D:  0d cf 20
b15_cb70:   .db $23                     ; 3CB70:  23
b15_cb71:   inx                         ; 3CB71:  e8
b15_cb72:   brk                         ; 3CB72:  00
b15_cb73:   brk                         ; 3CB73:  00
b15_cb74:   .db $0c                     ; 3CB74:  0c
b15_cb75:   ora $d8c4,x                 ; 3CB75:  1d c4 d8
b15_cb78:   ror $0ccb,x                 ; 3CB78:  7e cb 0c
b15_cb7b:   dec $7f,x                   ; 3CB7B:  d6 7f
b15_cb7d:   .db $cb                     ; 3CB7D:  cb
b15_cb7e:   ora $20cf                   ; 3CB7E:  0d cf 20
b15_cb81:   .db $23                     ; 3CB81:  23
b15_cb82:   inx                         ; 3CB82:  e8
b15_cb83:   .db $ff                     ; 3CB83:  ff
b15_cb84:   .db $ff                     ; 3CB84:  ff
b15_cb85:   .db $0c                     ; 3CB85:  0c
b15_cb86:   .db $d3                     ; 3CB86:  d3
b15_cb87:   ldx #$ff                    ; 3CB87:  a2 ff
b15_cb89:   .db $ff                     ; 3CB89:  ff
b15_cb8a:   .db $3c                     ; 3CB8A:  3c
b15_cb8b:   ora $d4d3                   ; 3CB8B:  0d d3 d4
b15_cb8e:   and $ffa0,x                 ; 3CB8E:  3d a0 ff
b15_cb91:   .db $ff                     ; 3CB91:  ff
b15_cb92:   .db $d4                     ; 3CB92:  d4
b15_cb93:   .db $cf                     ; 3CB93:  cf
swap_word:   jsr $e823                   ; 3CB94:  20 23 e8
b15_cb97:   inc $0cff,x                 ; 3CB97:  fe ff 0c
b15_cb9a:   bcs $cbc7                   ; 3CB9A:  b0 2b
b15_cb9c:   .db $3c                     ; 3CB9C:  3c
b15_cb9d:   ora $b1b0                   ; 3CB9D:  0d b0 b1
b15_cba0:   and $b10b,x                 ; 3CBA0:  3d 0b b1
b15_cba3:   .db $cf                     ; 3CBA3:  cf
chr_bank0_set_wrap:   jsr $e823                   ; 3CBA4:  20 23 e8
b15_cba7:   brk                         ; 3CBA7:  00
b15_cba8:   brk                         ; 3CBA8:  00
b15_cba9:   .db $3c                     ; 3CBA9:  3c
b15_cbaa:   sta $e915                   ; 3CBAA:  8d 15 e9
b15_cbad:   rol $f2                     ; 3CBAD:  26 f2
b15_cbaf:   .db vm_fp_lo                     ; 3CBAF:  04
b15_cbb0:   .db $cf                     ; 3CBB0:  cf
call_bank_wrap:   jsr $e823                   ; 3CBB1:  20 23 e8
b15_cbb4:   brk                         ; 3CBB4:  00
b15_cbb5:   brk                         ; 3CBB5:  00
b15_cbb6:   .db $3c                     ; 3CBB6:  3c
b15_cbb7:   .db brk_scratch_hi                     ; 3CBB7:  67
b15_cbb8:   sbc #$26                    ; 3CBB8:  e9 26
b15_cbba:   .db $f2                     ; 3CBBA:  f2
b15_cbbb:   .db vm_fp_lo                     ; 3CBBB:  04
b15_cbbc:   .db $cf                     ; 3CBBC:  cf
syscall16_sram_wrap:   jsr $e823                   ; 3CBBD:  20 23 e8
b15_cbc0:   brk                         ; 3CBC0:  00
b15_cbc1:   brk                         ; 3CBC1:  00
b15_cbc2:   .db $3f                     ; 3CBC2:  3f
b15_cbc3:   rol $3c3d,x                 ; 3CBC3:  3e 3d 3c
b15_cbc6:   sta $e910                   ; 3CBC6:  8d 10 e9
b15_cbc9:   rol $f2                     ; 3CBC9:  26 f2
b15_cbcb:   asl a                       ; 3CBCB:  0a
b15_cbcc:   .db $cf                     ; 3CBCC:  cf
sqrt_int:   lda #$ff                    ; 3CBCD:  a9 ff
b15_cbcf:   sta $08                     ; 3CBCF:  85 08
b15_cbd1:   sta $09                     ; 3CBD1:  85 09
b15_cbd3:   ldy #$03                    ; 3CBD3:  a0 03
b15_cbd5:   lda (vm_sp_lo),y                 ; 3CBD5:  b1 02
b15_cbd7:   bmi $cc34                   ; 3CBD7:  30 5b
b15_cbd9:   sta $44                     ; 3CBD9:  85 44
b15_cbdb:   dey                         ; 3CBDB:  88
b15_cbdc:   lda (vm_sp_lo),y                 ; 3CBDC:  b1 02
b15_cbde:   sta $45                     ; 3CBDE:  85 45
b15_cbe0:   lda #$00                    ; 3CBE0:  a9 00
b15_cbe2:   sta $40                     ; 3CBE2:  85 40
b15_cbe4:   sta $41                     ; 3CBE4:  85 41
b15_cbe6:   sta $42                     ; 3CBE6:  85 42
b15_cbe8:   sta $43                     ; 3CBE8:  85 43
b15_cbea:   ldx #$08                    ; 3CBEA:  a2 08
b15_cbec:   asl $45                     ; 3CBEC:  06 45
b15_cbee:   rol $44                     ; 3CBEE:  26 44
b15_cbf0:   rol $43                     ; 3CBF0:  26 43
b15_cbf2:   rol $42                     ; 3CBF2:  26 42
b15_cbf4:   asl $45                     ; 3CBF4:  06 45
b15_cbf6:   rol $44                     ; 3CBF6:  26 44
b15_cbf8:   rol $43                     ; 3CBF8:  26 43
b15_cbfa:   rol $42                     ; 3CBFA:  26 42
b15_cbfc:   sec                         ; 3CBFC:  38
b15_cbfd:   rol $41                     ; 3CBFD:  26 41
b15_cbff:   rol $40                     ; 3CBFF:  26 40
b15_cc01:   ldy #$02                    ; 3CC01:  a0 02
b15_cc03:   sec                         ; 3CC03:  38
b15_cc04:   lda $43                     ; 3CC04:  a5 43
b15_cc06:   sbc $41                     ; 3CC06:  e5 41
b15_cc08:   sta $43                     ; 3CC08:  85 43
b15_cc0a:   lda $42                     ; 3CC0A:  a5 42
b15_cc0c:   sbc $40                     ; 3CC0C:  e5 40
b15_cc0e:   sta $42                     ; 3CC0E:  85 42
b15_cc10:   bcs $cc20                   ; 3CC10:  b0 0e
b15_cc12:   ldy #$00                    ; 3CC12:  a0 00
b15_cc14:   lda $43                     ; 3CC14:  a5 43
b15_cc16:   adc $41                     ; 3CC16:  65 41
b15_cc18:   sta $43                     ; 3CC18:  85 43
b15_cc1a:   lda $42                     ; 3CC1A:  a5 42
b15_cc1c:   adc $40                     ; 3CC1C:  65 40
b15_cc1e:   sta $42                     ; 3CC1E:  85 42
b15_cc20:   tya                         ; 3CC20:  98
b15_cc21:   ora $41                     ; 3CC21:  05 41
b15_cc23:   and #$fe                    ; 3CC23:  29 fe
b15_cc25:   sta $41                     ; 3CC25:  85 41
b15_cc27:   dex                         ; 3CC27:  ca
b15_cc28:   bne $cbec                   ; 3CC28:  d0 c2
b15_cc2a:   lda $40                     ; 3CC2A:  a5 40
b15_cc2c:   lsr a                       ; 3CC2C:  4a
b15_cc2d:   sta $09                     ; 3CC2D:  85 09
b15_cc2f:   lda $41                     ; 3CC2F:  a5 41
b15_cc31:   ror a                       ; 3CC31:  6a
b15_cc32:   sta $08                     ; 3CC32:  85 08
b15_cc34:   rts                         ; 3CC34:  60
palette_swap:   jsr $e823                   ; 3CC35:  20 23 e8
b15_cc38:   brk                         ; 3CC38:  00
b15_cc39:   brk                         ; 3CC39:  00
b15_cc3a:   .db $3c                     ; 3CC3A:  3c
b15_cc3b:   sta $e912                   ; 3CC3B:  8d 12 e9
b15_cc3e:   rol $f2                     ; 3CC3E:  26 f2
b15_cc40:   .db vm_fp_lo                     ; 3CC40:  04
b15_cc41:   .db $cf                     ; 3CC41:  cf
ppu_fill_rect_wrap:   jsr $e823                   ; 3CC42:  20 23 e8
b15_cc45:   brk                         ; 3CC45:  00
b15_cc46:   brk                         ; 3CC46:  00
b15_cc47:   .db $87                     ; 3CC47:  87
b15_cc48:   .db $13                     ; 3CC48:  13
b15_cc49:   .db $3f                     ; 3CC49:  3f
b15_cc4a:   rol $3c3d,x                 ; 3CC4A:  3e 3d 3c
b15_cc4d:   rts                         ; 3CC4D:  60
b15_cc4e:   jmp ($26e9)                 ; 3CC4E:  6c e9 26
b15_cc51:   .db $f2                     ; 3CC51:  f2
b15_cc52:   asl $20cf                   ; 3CC52:  0e cf 20
b15_cc55:   .db $23                     ; 3CC55:  23
b15_cc56:   inx                         ; 3CC56:  e8
b15_cc57:   brk                         ; 3CC57:  00
b15_cc58:   brk                         ; 3CC58:  00
b15_cc59:   .db $87                     ; 3CC59:  87
b15_cc5a:   ora $87,x                   ; 3CC5A:  15 87
b15_cc5c:   .db $13                     ; 3CC5C:  13
b15_cc5d:   .db $3f                     ; 3CC5D:  3f
b15_cc5e:   rol $3c3d,x                 ; 3CC5E:  3e 3d 3c
b15_cc61:   rts                         ; 3CC61:  60
b15_cc62:   sta $e914                   ; 3CC62:  8d 14 e9
b15_cc65:   rol $f2                     ; 3CC65:  26 f2
b15_cc67:   bpl $cc38                   ; 3CC67:  10 cf
clear_rect_right_panel:   jsr $e823                   ; 3CC69:  20 23 e8
b15_cc6c:   brk                         ; 3CC6C:  00
b15_cc6d:   brk                         ; 3CC6D:  00
b15_cc6e:   adc ($8d,x)                 ; 3CC6E:  61 8d
b15_cc70:   .db $12                     ; 3CC70:  12
b15_cc71:   sta $671d                   ; 3CC71:  8d 1d 67
b15_cc74:   sta $e916                   ; 3CC74:  8d 16 e9
b15_cc77:   .db $42                     ; 3CC77:  42
b15_cc78:   cpy $cf0a                   ; 3CC78:  cc 0a cf
set_cursor:   jsr $e823                   ; 3CC7B:  20 23 e8
b15_cc7e:   brk                         ; 3CC7E:  00
b15_cc7f:   brk                         ; 3CC7F:  00
b15_cc80:   .db $0c                     ; 3CC80:  0c
b15_cc81:   tay                         ; 3CC81:  a8
b15_cc82:   cmp $0d7f                   ; 3CC82:  cd 7f 0d
b15_cc85:   tay                         ; 3CC85:  a8
b15_cc86:   .db $cf                     ; 3CC86:  cf
b15_cc87:   .db $7f                     ; 3CC87:  7f
b15_cc88:   .db $cf                     ; 3CC88:  cf
open_message_window:   jsr $e823                   ; 3CC89:  20 23 e8
b15_cc8c:   brk                         ; 3CC8C:  00
b15_cc8d:   brk                         ; 3CC8D:  00
b15_cc8e:   adc ($8d,x)                 ; 3CC8E:  61 8d
b15_cc90:   ora $138d,y                 ; 3CC90:  19 8d 13
b15_cc93:   ldy $d1                     ; 3CC93:  a4 d1
b15_cc95:   .db $7f                     ; 3CC95:  7f
b15_cc96:   cld                         ; 3CC96:  d8
b15_cc97:   .db $9e                     ; 3CC97:  9e
b15_cc98:   cpy $1489                   ; 3CC98:  cc 89 14
b15_cc9b:   dec $a0,x                   ; 3CC9B:  d6 a0
b15_cc9d:   cpy $1689                   ; 3CC9D:  cc 89 16
b15_cca0:   .db $b3                     ; 3CCA0:  b3
b15_cca1:   .db $62                     ; 3CCA1:  62
b15_cca2:   sbc #$42                    ; 3CCA2:  e9 42
b15_cca4:   cpy $a40a                   ; 3CCA4:  cc 0a a4
b15_cca7:   cmp ($7f),y                 ; 3CCA7:  d1 7f
b15_cca9:   cld                         ; 3CCA9:  d8
b15_ccaa:   lda ($cc),y                 ; 3CCAA:  b1 cc
b15_ccac:   .db skip_wallclock                     ; 3CCAC:  89
b15_ccad:   .db $14                     ; 3CCAD:  14
b15_ccae:   dec $b3,x                   ; 3CCAE:  d6 b3
b15_ccb0:   cpy $1689                   ; 3CCB0:  cc 89 16
b15_ccb3:   .db $b3                     ; 3CCB3:  b3
b15_ccb4:   .db $62                     ; 3CCB4:  62
b15_ccb5:   sbc #$7b                    ; 3CCB5:  e9 7b
b15_ccb7:   cpy $cf04                   ; 3CCB7:  cc 04 cf
clear_rect_lower_right:   jsr $e823                   ; 3CCBA:  20 23 e8
b15_ccbd:   brk                         ; 3CCBD:  00
b15_ccbe:   brk                         ; 3CCBE:  00
b15_ccbf:   adc ($8d,x)                 ; 3CCBF:  61 8d
b15_ccc1:   ora $1d8d,y                 ; 3CCC1:  19 8d 1d
b15_ccc4:   sta $8d14                   ; 3CCC4:  8d 14 8d
b15_ccc7:   .db $14                     ; 3CCC7:  14
b15_ccc8:   sbc #$42                    ; 3CCC8:  e9 42
b15_ccca:   cpy $400a                   ; 3CCCA:  cc 0a 40
b15_cccd:   tay                         ; 3CCCD:  a8
b15_ccce:   sbc $cf7b,y                 ; 3CCCE:  f9 7b cf
clear_rect_top_strip:   jsr $e823                   ; 3CCD1:  20 23 e8
b15_ccd4:   brk                         ; 3CCD4:  00
b15_ccd5:   brk                         ; 3CCD5:  00
b15_ccd6:   adc ($63,x)                 ; 3CCD6:  61 63
b15_ccd8:   sta $631d                   ; 3CCD8:  8d 1d 63
b15_ccdb:   .db $62                     ; 3CCDB:  62
b15_ccdc:   sbc #$42                    ; 3CCDC:  e9 42
b15_ccde:   cpy $cf0a                   ; 3CCDE:  cc 0a cf
reset_prompt_selection:   jsr $e823                   ; 3CCE1:  20 23 e8
b15_cce4:   brk                         ; 3CCE4:  00
b15_cce5:   brk                         ; 3CCE5:  00
b15_cce6:   adc ($8d,x)                 ; 3CCE6:  61 8d
b15_cce8:   .db $1a                     ; 3CCE8:  1a
b15_cce9:   sta $8d1d                   ; 3CCE9:  8d 1d 8d
b15_ccec:   .db $1a                     ; 3CCEC:  1a
b15_cced:   .db $62                     ; 3CCED:  62
b15_ccee:   sbc #$42                    ; 3CCEE:  e9 42
b15_ccf0:   cpy $8a0a                   ; 3CCF0:  cc 0a 8a
b15_ccf3:   .db $ff                     ; 3CCF3:  ff
b15_ccf4:   brk                         ; 3CCF4:  00
b15_ccf5:   tay                         ; 3CCF5:  a8
b15_ccf6:   .db $df                     ; 3CCF6:  df
b15_ccf7:   .db $7f                     ; 3CCF7:  7f
b15_ccf8:   .db $cf                     ; 3CCF8:  cf
get_6f5d_or_ff:   jsr $e823                   ; 3CCF9:  20 23 e8
b15_ccfc:   brk                         ; 3CCFC:  00
b15_ccfd:   brk                         ; 3CCFD:  00
b15_ccfe:   adc ($8d,x)                 ; 3CCFE:  61 8d
b15_cd00:   .db $13                     ; 3CD00:  13
b15_cd01:   sta $641f                   ; 3CD01:  8d 1f 64
b15_cd04:   rts                         ; 3CD04:  60
b15_cd05:   sbc #$42                    ; 3CD05:  e9 42
b15_cd07:   cpy $a40a                   ; 3CD07:  cc 0a a4
b15_cd0a:   eor $8c6f,x                 ; 3CD0A:  5d 6f 8c
b15_cd0d:   .db $ff                     ; 3CD0D:  ff
b15_cd0e:   brk                         ; 3CD0E:  00
b15_cd0f:   cmp ($d8,x)                 ; 3CD0F:  c1 d8
b15_cd11:   .db ppu_queue_b_hi                     ; 3CD11:  1f
b15_cd12:   cmp $5da4                   ; 3CD12:  cd a4 5d
b15_cd15:   .db p2_buttons                     ; 3CD15:  6f
b15_cd16:   tay                         ; 3CD16:  a8
b15_cd17:   inc music_ptr_hi                     ; 3CD17:  e6 7b
b15_cd19:   txa                         ; 3CD19:  8a
b15_cd1a:   .db $ff                     ; 3CD1A:  ff
b15_cd1b:   brk                         ; 3CD1B:  00
b15_cd1c:   tay                         ; 3CD1C:  a8
b15_cd1d:   eor $cf6f,x                 ; 3CD1D:  5d 6f cf
repaint_screen:   jsr $e823                   ; 3CD20:  20 23 e8
b15_cd23:   inc $61ff,x                 ; 3CD23:  fe ff 61
b15_cd26:   sbc #$35                    ; 3CD26:  e9 35
b15_cd28:   cpy $ac02                   ; 3CD28:  cc 02 ac
b15_cd2b:   bvc $ccfc                   ; 3CD2B:  50 cf
b15_cd2d:   ldy $cf5d                   ; 3CD2D:  ac 5d cf
b15_cd30:   ldy $c9                     ; 3CD30:  a4 c9
b15_cd32:   .db $7f                     ; 3CD32:  7f
b15_cd33:   cld                         ; 3CD33:  d8
b15_cd34:   .db $4f                     ; 3CD34:  4f
b15_cd35:   cmp $218d                   ; 3CD35:  cd 8d 21
b15_cd38:   .db brk_scratch_hi                     ; 3CD38:  67
b15_cd39:   sbc #$8b                    ; 3CD39:  e9 8b
b15_cd3b:   .db $cf                     ; 3CD3B:  cf
b15_cd3c:   .db vm_fp_lo                     ; 3CD3C:  04
b15_cd3d:   sta $6b30                   ; 3CD3D:  8d 30 6b
b15_cd40:   sbc #$8b                    ; 3CD40:  e9 8b
b15_cd42:   .db $cf                     ; 3CD42:  cf
b15_cd43:   .db vm_fp_lo                     ; 3CD43:  04
b15_cd44:   sta $6f30                   ; 3CD44:  8d 30 6f
b15_cd47:   sbc #$8b                    ; 3CD47:  e9 8b
b15_cd49:   .db $cf                     ; 3CD49:  cf
b15_cd4a:   .db vm_fp_lo                     ; 3CD4A:  04
b15_cd4b:   rti                         ; 3CD4B:  40
b15_cd4c:   tay                         ; 3CD4C:  a8
b15_cd4d:   cmp #$7f                    ; 3CD4D:  c9 7f
b15_cd4f:   ldy $c7                     ; 3CD4F:  a4 c7
b15_cd51:   .db $7f                     ; 3CD51:  7f
b15_cd52:   cld                         ; 3CD52:  d8
b15_cd53:   ror $40cd,x                 ; 3CD53:  7e cd 40
b15_cd56:   .db $2b                     ; 3CD56:  2b
b15_cd57:   .db $0b                     ; 3CD57:  0b
b15_cd58:   .db $d2                     ; 3CD58:  d2
b15_cd59:   sty $f67a                   ; 3CD59:  8c 7a f6
b15_cd5c:   .db $bb                     ; 3CD5C:  bb
b15_cd5d:   bcs $cd12                   ; 3CD5D:  b0 b3
b15_cd5f:   .db $3b                     ; 3CD5F:  3b
b15_cd60:   sbc #$8b                    ; 3CD60:  e9 8b
b15_cd62:   .db $cf                     ; 3CD62:  cf
b15_cd63:   .db vm_fp_lo                     ; 3CD63:  04
b15_cd64:   .db $0b                     ; 3CD64:  0b
b15_cd65:   bne $cd92                   ; 3CD65:  d0 2b
b15_cd67:   .db $0b                     ; 3CD67:  0b
b15_cd68:   .db $54                     ; 3CD68:  54
b15_cd69:   dec $d7                     ; 3CD69:  c6 d7
b15_cd6b:   .db $57                     ; 3CD6B:  57
b15_cd6c:   cmp $248d                   ; 3CD6C:  cd 8d 24
b15_cd6f:   stx $15b0                   ; 3CD6F:  8e b0 15
b15_cd72:   stx $845c                   ; 3CD72:  8e 5c 84
b15_cd75:   .db $64                     ; 3CD75:  64
b15_cd76:   sbc #$7c                    ; 3CD76:  e9 7c
b15_cd78:   .db $cf                     ; 3CD78:  cf
b15_cd79:   php                         ; 3CD79:  08
b15_cd7a:   rti                         ; 3CD7A:  40
b15_cd7b:   tay                         ; 3CD7B:  a8
b15_cd7c:   .db $c7                     ; 3CD7C:  c7
b15_cd7d:   .db $7f                     ; 3CD7D:  7f
b15_cd7e:   rts                         ; 3CD7E:  60
b15_cd7f:   sbc #$35                    ; 3CD7F:  e9 35
b15_cd81:   cpy $a402                   ; 3CD81:  cc 02 a4
b15_cd84:   eor $8c6f,x                 ; 3CD84:  5d 6f 8c
b15_cd87:   .db $ff                     ; 3CD87:  ff
b15_cd88:   brk                         ; 3CD88:  00
b15_cd89:   cmp ($d8,x)                 ; 3CD89:  c1 d8
b15_cd8b:   sta $a4cd,y                 ; 3CD8B:  99 cd a4
b15_cd8e:   eor $a86f,x                 ; 3CD8E:  5d 6f a8
b15_cd91:   inc music_ptr_hi                     ; 3CD91:  e6 7b
b15_cd93:   txa                         ; 3CD93:  8a
b15_cd94:   .db $ff                     ; 3CD94:  ff
b15_cd95:   brk                         ; 3CD95:  00
b15_cd96:   tay                         ; 3CD96:  a8
b15_cd97:   eor $8a6f,x                 ; 3CD97:  5d 6f 8a
b15_cd9a:   .db $ff                     ; 3CD9A:  ff
b15_cd9b:   brk                         ; 3CD9B:  00
b15_cd9c:   tay                         ; 3CD9C:  a8
b15_cd9d:   .db $df                     ; 3CD9D:  df
b15_cd9e:   .db $7f                     ; 3CD9E:  7f
b15_cd9f:   sta $6214                   ; 3CD9F:  8d 14 62
b15_cda2:   sbc #$7b                    ; 3CDA2:  e9 7b
b15_cda4:   cpy $4004                   ; 3CDA4:  cc 04 40
b15_cda7:   tay                         ; 3CDA7:  a8
b15_cda8:   sbc $407b,y                 ; 3CDA8:  f9 7b 40
b15_cdab:   tay                         ; 3CDAB:  a8
b15_cdac:   .db $fb                     ; 3CDAC:  fb
b15_cdad:   .db music_ptr_hi                     ; 3CDAD:  7b
b15_cdae:   .db $cf                     ; 3CDAE:  cf
cursor_advance_row:   jsr $e823                   ; 3CDAF:  20 23 e8
b15_cdb2:   brk                         ; 3CDB2:  00
b15_cdb3:   brk                         ; 3CDB3:  00
b15_cdb4:   .db $42                     ; 3CDB4:  42
b15_cdb5:   tay                         ; 3CDB5:  a8
b15_cdb6:   cmp $a47f                   ; 3CDB6:  cd 7f a4
b15_cdb9:   .db $cf                     ; 3CDB9:  cf
b15_cdba:   .db $7f                     ; 3CDBA:  7f
b15_cdbb:   bne $cd65                   ; 3CDBB:  d0 a8
b15_cdbd:   .db $cf                     ; 3CDBD:  cf
b15_cdbe:   .db $7f                     ; 3CDBE:  7f
b15_cdbf:   .db $8b                     ; 3CDBF:  8b
b15_cdc0:   .db $1b                     ; 3CDC0:  1b
b15_cdc1:   iny                         ; 3CDC1:  c8
b15_cdc2:   cld                         ; 3CDC2:  d8
b15_cdc3:   cmp #$cd                    ; 3CDC3:  c9 cd
b15_cdc5:   .db $43                     ; 3CDC5:  43
b15_cdc6:   tay                         ; 3CDC6:  a8
b15_cdc7:   .db $cf                     ; 3CDC7:  cf
b15_cdc8:   .db $7f                     ; 3CDC8:  7f
b15_cdc9:   .db $cf                     ; 3CDC9:  cf
char_classify:   jsr $e823                   ; 3CDCA:  20 23 e8
b15_cdcd:   brk                         ; 3CDCD:  00
b15_cdce:   brk                         ; 3CDCE:  00
b15_cdcf:   ldy #$0b                    ; 3CDCF:  a0 0b
b15_cdd1:   brk                         ; 3CDD1:  00
b15_cdd2:   .db $8b                     ; 3CDD2:  8b
b15_cdd3:   .db $5f                     ; 3CDD3:  5f
b15_cdd4:   cmp $d8                     ; 3CDD4:  c5 d8
b15_cdd6:   .db $f4                     ; 3CDD6:  f4
b15_cdd7:   cmp $0ba0                   ; 3CDD7:  cd a0 0b
b15_cdda:   brk                         ; 3CDDA:  00
b15_cddb:   .db $8b                     ; 3CDDB:  8b
b15_cddc:   .db music_ptr_lo                     ; 3CDDC:  7a
b15_cddd:   .db $c3                     ; 3CDDD:  c3
b15_cdde:   cld                         ; 3CDDE:  d8
b15_cddf:   .db $f4                     ; 3CDDF:  f4
b15_cde0:   cmp $2f89                   ; 3CDE0:  cd 89 2f
b15_cde3:   dec $11,x                   ; 3CDE3:  d6 11
b15_cde5:   dec $0ba0                   ; 3CDE5:  ce a0 0b
b15_cde8:   brk                         ; 3CDE8:  00
b15_cde9:   .db $8b                     ; 3CDE9:  8b
b15_cdea:   .db $5a                     ; 3CDEA:  5a
b15_cdeb:   .db $c3                     ; 3CDEB:  c3
b15_cdec:   cld                         ; 3CDEC:  d8
b15_cded:   sbc $89cd,x                 ; 3CDED:  fd cd 89
b15_cdf0:   .db $2b                     ; 3CDF0:  2b
b15_cdf1:   dec $11,x                   ; 3CDF1:  d6 11
b15_cdf3:   dec $0ba0                   ; 3CDF3:  ce a0 0b
b15_cdf6:   brk                         ; 3CDF6:  00
b15_cdf7:   .db $8b                     ; 3CDF7:  8b
b15_cdf8:   eor ($c5,x)                 ; 3CDF8:  41 c5
b15_cdfa:   .db $d7                     ; 3CDFA:  d7
b15_cdfb:   inc $cd                     ; 3CDFB:  e6 cd
b15_cdfd:   ldy #$0b                    ; 3CDFD:  a0 0b
b15_cdff:   brk                         ; 3CDFF:  00
b15_ce00:   .db $8b                     ; 3CE00:  8b
b15_ce01:   and $d8c5                   ; 3CE01:  2d c5 d8
b15_ce04:   ora $a0ce,x                 ; 3CE04:  1d ce a0
b15_ce07:   .db $0b                     ; 3CE07:  0b
b15_ce08:   brk                         ; 3CE08:  00
b15_ce09:   .db $8b                     ; 3CE09:  8b
b15_ce0a:   .db $3a                     ; 3CE0A:  3a
b15_ce0b:   .db $c3                     ; 3CE0B:  c3
b15_ce0c:   cld                         ; 3CE0C:  d8
b15_ce0d:   ora $89ce,x                 ; 3CE0D:  1d ce 89
b15_ce10:   plp                         ; 3CE10:  28
b15_ce11:   cmp $0ba0                   ; 3CE11:  cd a0 0b
b15_ce14:   brk                         ; 3CE14:  00
b15_ce15:   ldy $0ba2,x                 ; 3CE15:  bc a2 0b
b15_ce18:   brk                         ; 3CE18:  00
b15_ce19:   ldy #$0b                    ; 3CE19:  a0 0b
b15_ce1b:   brk                         ; 3CE1B:  00
b15_ce1c:   .db $cf                     ; 3CE1C:  cf
b15_ce1d:   ldy #$0b                    ; 3CE1D:  a0 0b
b15_ce1f:   brk                         ; 3CE1F:  00
b15_ce20:   cmp $000c,y                 ; 3CE20:  d9 0c 00
b15_ce23:   jsr $5500                   ; 3CE23:  20 00 55
b15_ce26:   dec $0021                   ; 3CE26:  ce 21 00
b15_ce29:   eor $ce,x                   ; 3CE29:  55 ce
b15_ce2b:   .db $23                     ; 3CE2B:  23
b15_ce2c:   brk                         ; 3CE2C:  00
b15_ce2d:   .db $5a                     ; 3CE2D:  5a
b15_ce2e:   dec $0025                   ; 3CE2E:  ce 25 00
b15_ce31:   .db $5f                     ; 3CE31:  5f
b15_ce32:   dec $0028                   ; 3CE32:  ce 28 00
b15_ce35:   .db $64                     ; 3CE35:  64
b15_ce36:   dec $0029                   ; 3CE36:  ce 29 00
b15_ce39:   .db $64                     ; 3CE39:  64
b15_ce3a:   dec $002a                   ; 3CE3A:  ce 2a 00
b15_ce3d:   adc #$ce                    ; 3CE3D:  69 ce
b15_ce3f:   .db $2b                     ; 3CE3F:  2b
b15_ce40:   brk                         ; 3CE40:  00
b15_ce41:   adc #$ce                    ; 3CE41:  69 ce
b15_ce43:   bit $6900                   ; 3CE43:  2c 00 69
b15_ce46:   dec $003c                   ; 3CE46:  ce 3c 00
b15_ce49:   .db prg_bank_shadow                     ; 3CE49:  73
b15_ce4a:   dec $003e                   ; 3CE4A:  ce 3e 00
b15_ce4d:   sei                         ; 3CE4D:  78
b15_ce4e:   dec $003f                   ; 3CE4E:  ce 3f 00
b15_ce51:   sei                         ; 3CE51:  78
b15_ce52:   dec $ce7d                   ; 3CE52:  ce 7d ce
b15_ce55:   .db skip_wallclock                     ; 3CE55:  89
b15_ce56:   .db ppu_queue_b_hi                     ; 3CE56:  1f
b15_ce57:   dec $11,x                   ; 3CE57:  d6 11
b15_ce59:   dec $4c89                   ; 3CE59:  ce 89 4c
b15_ce5c:   dec $16,x                   ; 3CE5C:  d6 16
b15_ce5e:   dec $4d89                   ; 3CE5E:  ce 89 4d
b15_ce61:   dec $16,x                   ; 3CE61:  d6 16
b15_ce63:   dec $2589                   ; 3CE63:  ce 89 25
b15_ce66:   dec $11,x                   ; 3CE66:  d6 11
b15_ce68:   dec $2489                   ; 3CE68:  ce 89 24
b15_ce6b:   cmp $0ba0                   ; 3CE6B:  cd a0 0b
b15_ce6e:   brk                         ; 3CE6E:  00
b15_ce6f:   .db $bb                     ; 3CE6F:  bb
b15_ce70:   dec $16,x                   ; 3CE70:  d6 16
b15_ce72:   dec $1389                   ; 3CE72:  ce 89 13
b15_ce75:   dec $16,x                   ; 3CE75:  d6 16
b15_ce77:   dec $2a89                   ; 3CE77:  ce 89 2a
b15_ce7a:   dec $11,x                   ; 3CE7A:  d6 11
b15_ce7c:   dec $d640                   ; 3CE7C:  ce 40 d6
b15_ce7f:   asl $ce,x                   ; 3CE7F:  16 ce
char_advance_width:   jsr $e823                   ; 3CE81:  20 23 e8
b15_ce84:   brk                         ; 3CE84:  00
b15_ce85:   brk                         ; 3CE85:  00
b15_ce86:   ldy #$0b                    ; 3CE86:  a0 0b
b15_ce88:   brk                         ; 3CE88:  00
b15_ce89:   .db $5a                     ; 3CE89:  5a
b15_ce8a:   cpy #$d8                    ; 3CE8A:  c0 d8
b15_ce8c:   .db $92                     ; 3CE8C:  92
b15_ce8d:   dec $afac                   ; 3CE8D:  ce ac af
b15_ce90:   cmp $a0cf                   ; 3CE90:  cd cf a0
b15_ce93:   .db $0b                     ; 3CE93:  0b
b15_ce94:   brk                         ; 3CE94:  00
b15_ce95:   .db $b3                     ; 3CE95:  b3
b15_ce96:   sbc #$ca                    ; 3CE96:  e9 ca
b15_ce98:   cmp $a202                   ; 3CE98:  cd 02 a2
b15_ce9b:   .db $0b                     ; 3CE9B:  0b
b15_ce9c:   brk                         ; 3CE9C:  00
b15_ce9d:   ldy #$0b                    ; 3CE9D:  a0 0b
b15_ce9f:   brk                         ; 3CE9F:  00
b15_cea0:   .db $b3                     ; 3CEA0:  b3
b15_cea1:   tax                         ; 3CEA1:  aa
b15_cea2:   .db $cf                     ; 3CEA2:  cf
b15_cea3:   .db $7f                     ; 3CEA3:  7f
b15_cea4:   tax                         ; 3CEA4:  aa
b15_cea5:   cmp $aa7f                   ; 3CEA5:  cd 7f aa
b15_cea8:   .db $cf                     ; 3CEA8:  cf
b15_cea9:   .db $7f                     ; 3CEA9:  7f
b15_ceaa:   tax                         ; 3CEAA:  aa
b15_ceab:   cmp $607f                   ; 3CEAB:  cd 7f 60
b15_ceae:   jmp ($26e9)                 ; 3CEAE:  6c e9 26
b15_ceb1:   .db $f2                     ; 3CEB1:  f2
b15_ceb2:   asl $cda4                   ; 3CEB2:  0e a4 cd
b15_ceb5:   .db $7f                     ; 3CEB5:  7f
b15_ceb6:   bne $ce60                   ; 3CEB6:  d0 a8
b15_ceb8:   cmp $8b7f                   ; 3CEB8:  cd 7f 8b
b15_cebb:   .db ppu_queue_b_hi                     ; 3CEBB:  1f
b15_cebc:   iny                         ; 3CEBC:  c8
b15_cebd:   cld                         ; 3CEBD:  d8
b15_cebe:   .db $c3                     ; 3CEBE:  c3
b15_cebf:   dec $afac                   ; 3CEBF:  ce ac af
b15_cec2:   cmp $20cf                   ; 3CEC2:  cd cf 20
b15_cec5:   .db $23                     ; 3CEC5:  23
b15_cec6:   inx                         ; 3CEC6:  e8
b15_cec7:   .db $db                     ; 3CEC7:  db
b15_cec8:   .db $ff                     ; 3CEC8:  ff
b15_cec9:   dec ppu_queue_b_lo,x                   ; 3CEC9:  d6 1e
b15_cecb:   .db $cf                     ; 3CECB:  cf
b15_cecc:   ldy #$fd                    ; 3CECC:  a0 fd
b15_cece:   .db $ff                     ; 3CECE:  ff
b15_cecf:   .db $5a                     ; 3CECF:  5a
b15_ced0:   cpy #$d8                    ; 3CED0:  c0 d8
b15_ced2:   cpx $0bce                   ; 3CED2:  ec ce 0b
b15_ced5:   ldx $cd                     ; 3CED5:  a6 cd
b15_ced7:   .db $7f                     ; 3CED7:  7f
b15_ced8:   cmp ($d8,x)                 ; 3CED8:  c1 d8
b15_ceda:   .db $1b                     ; 3CEDA:  1b
b15_cedb:   .db $cf                     ; 3CEDB:  cf
b15_cedc:   .db $64                     ; 3CEDC:  64
b15_cedd:   dec $ffdb,x                 ; 3CEDD:  de db ff
b15_cee0:   .db $b3                     ; 3CEE0:  b3
b15_cee1:   tax                         ; 3CEE1:  aa
b15_cee2:   .db $cf                     ; 3CEE2:  cf
b15_cee3:   .db $7f                     ; 3CEE3:  7f
b15_cee4:   ldy $cd                     ; 3CEE4:  a4 cd
b15_cee6:   .db $7f                     ; 3CEE6:  7f
b15_cee7:   cmp ($b3),y                 ; 3CEE7:  d1 b3
b15_cee9:   dec $13,x                   ; 3CEE9:  d6 13
b15_ceeb:   .db $cf                     ; 3CEEB:  cf
b15_ceec:   sta ($fb,x)                 ; 3CEEC:  81 fb
b15_ceee:   bne $ce75                   ; 3CEEE:  d0 85
b15_cef0:   .db $fb                     ; 3CEF0:  fb
b15_cef1:   cmp ($b3),y                 ; 3CEF1:  d1 b3
b15_cef3:   ldy #$fd                    ; 3CEF3:  a0 fd
b15_cef5:   .db $ff                     ; 3CEF5:  ff
b15_cef6:   .db $b3                     ; 3CEF6:  b3
b15_cef7:   sbc #$ca                    ; 3CEF7:  e9 ca
b15_cef9:   cmp $d402                   ; 3CEF9:  cd 02 d4
b15_cefc:   ldy $cd                     ; 3CEFC:  a4 cd
b15_cefe:   .db $7f                     ; 3CEFE:  7f
b15_ceff:   bne $cea9                   ; 3CEFF:  d0 a8
b15_cf01:   cmp $8b7f                   ; 3CF01:  cd 7f 8b
b15_cf04:   jsr $d8c0                   ; 3CF04:  20 c0 d8
b15_cf07:   .db $27                     ; 3CF07:  27
b15_cf08:   .db $cf                     ; 3CF08:  cf
b15_cf09:   .db $64                     ; 3CF09:  64
b15_cf0a:   dec $ffdb,x                 ; 3CF0A:  de db ff
b15_cf0d:   .db $b3                     ; 3CF0D:  b3
b15_cf0e:   tax                         ; 3CF0E:  aa
b15_cf0f:   .db $cf                     ; 3CF0F:  cf
b15_cf10:   .db $7f                     ; 3CF10:  7f
b15_cf11:   sta $aa1f                   ; 3CF11:  8d 1f aa
b15_cf14:   .db $cf                     ; 3CF14:  cf
b15_cf15:   .db $7f                     ; 3CF15:  7f
b15_cf16:   .db $3b                     ; 3CF16:  3b
b15_cf17:   sbc #$54                    ; 3CF17:  e9 54
b15_cf19:   cpy $ac0c                   ; 3CF19:  cc 0c ac
b15_cf1c:   .db $af                     ; 3CF1C:  af
b15_cf1d:   cmp $cda4                   ; 3CF1D:  cd a4 cd
b15_cf20:   .db $7f                     ; 3CF20:  7f
b15_cf21:   .db $2b                     ; 3CF21:  2b
b15_cf22:   dec $ffdb,x                 ; 3CF22:  de db ff
b15_cf25:   sta $fb                     ; 3CF25:  85 fb
b15_cf27:   .db $0c                     ; 3CF27:  0c
b15_cf28:   bne $cf56                   ; 3CF28:  d0 2c
b15_cf2a:   cmp ($d3),y                 ; 3CF2A:  d1 d3
b15_cf2c:   ldx #$fd                    ; 3CF2C:  a2 fd
b15_cf2e:   .db $ff                     ; 3CF2E:  ff
b15_cf2f:   .db $d7                     ; 3CF2F:  d7
b15_cf30:   cpy $0bce                   ; 3CF30:  cc ce 0b
b15_cf33:   ldx $cd                     ; 3CF33:  a6 cd
b15_cf35:   .db $7f                     ; 3CF35:  7f
b15_cf36:   cmp ($d8,x)                 ; 3CF36:  c1 d8
b15_cf38:   .db $4f                     ; 3CF38:  4f
b15_cf39:   .db $cf                     ; 3CF39:  cf
b15_cf3a:   .db $64                     ; 3CF3A:  64
b15_cf3b:   dec $ffdb,x                 ; 3CF3B:  de db ff
b15_cf3e:   .db $b3                     ; 3CF3E:  b3
b15_cf3f:   tax                         ; 3CF3F:  aa
b15_cf40:   .db $cf                     ; 3CF40:  cf
b15_cf41:   .db $7f                     ; 3CF41:  7f
b15_cf42:   ldy $cd                     ; 3CF42:  a4 cd
b15_cf44:   .db $7f                     ; 3CF44:  7f
b15_cf45:   cmp ($b3),y                 ; 3CF45:  d1 b3
b15_cf47:   tax                         ; 3CF47:  aa
b15_cf48:   .db $cf                     ; 3CF48:  cf
b15_cf49:   .db $7f                     ; 3CF49:  7f
b15_cf4a:   .db $3b                     ; 3CF4A:  3b
b15_cf4b:   sbc #$54                    ; 3CF4B:  e9 54
b15_cf4d:   cpy $cf0c                   ; 3CF4D:  cc 0c cf
fill_nametable_wrap:   jsr $e823                   ; 3CF50:  20 23 e8
b15_cf53:   brk                         ; 3CF53:  00
b15_cf54:   brk                         ; 3CF54:  00
b15_cf55:   adc ($60,x)                 ; 3CF55:  61 60
b15_cf57:   adc $e9                     ; 3CF57:  65 e9
b15_cf59:   rol $f2                     ; 3CF59:  26 f2
b15_cf5b:   asl $cf                     ; 3CF5B:  06 cf
fill_attr_wrap:   jsr $e823                   ; 3CF5D:  20 23 e8
b15_cf60:   brk                         ; 3CF60:  00
b15_cf61:   brk                         ; 3CF61:  00
b15_cf62:   rts                         ; 3CF62:  60
b15_cf63:   rts                         ; 3CF63:  60
b15_cf64:   pla                         ; 3CF64:  68
b15_cf65:   sbc #$26                    ; 3CF65:  e9 26
b15_cf67:   .db $f2                     ; 3CF67:  f2
b15_cf68:   asl $cf                     ; 3CF68:  06 cf
ppu_render_rect_wrap:   jsr $e823                   ; 3CF6A:  20 23 e8
b15_cf6d:   brk                         ; 3CF6D:  00
b15_cf6e:   brk                         ; 3CF6E:  00
b15_cf6f:   .db $87                     ; 3CF6F:  87
b15_cf70:   .db $13                     ; 3CF70:  13
b15_cf71:   .db $3f                     ; 3CF71:  3f
b15_cf72:   rol $3c3d,x                 ; 3CF72:  3e 3d 3c
b15_cf75:   rts                         ; 3CF75:  60
b15_cf76:   adc $26e9                   ; 3CF76:  6d e9 26
b15_cf79:   .db $f2                     ; 3CF79:  f2
b15_cf7a:   asl $20cf                   ; 3CF7A:  0e cf 20
b15_cf7d:   .db $23                     ; 3CF7D:  23
b15_cf7e:   inx                         ; 3CF7E:  e8
b15_cf7f:   brk                         ; 3CF7F:  00
b15_cf80:   brk                         ; 3CF80:  00
b15_cf81:   .db $3f                     ; 3CF81:  3f
b15_cf82:   rol $3c3d,x                 ; 3CF82:  3e 3d 3c
b15_cf85:   adc ($e9,x)                 ; 3CF85:  61 e9
b15_cf87:   rol $f2                     ; 3CF87:  26 f2
b15_cf89:   asl a                       ; 3CF89:  0a
b15_cf8a:   .db $cf                     ; 3CF8A:  cf
palette_write_wrap:   jsr $e823                   ; 3CF8B:  20 23 e8
b15_cf8e:   brk                         ; 3CF8E:  00
b15_cf8f:   brk                         ; 3CF8F:  00
b15_cf90:   and $643c,x                 ; 3CF90:  3d 3c 64
b15_cf93:   sbc #$26                    ; 3CF93:  e9 26
b15_cf95:   .db $f2                     ; 3CF95:  f2
b15_cf96:   asl $cf                     ; 3CF96:  06 cf
num_to_ascii:   jsr $e823                   ; 3CF98:  20 23 e8
b15_cf9b:   inc $0dff,x                 ; 3CF9B:  fe ff 0d
b15_cf9e:   asl $d8c6,x                 ; 3CF9E:  1e c6 d8
b15_cfa1:   ldy $0ccf,x                 ; 3CFA1:  bc cf 0c
b15_cfa4:   .db $b3                     ; 3CFA4:  b3
b15_cfa5:   bcs $cf77                   ; 3CFA5:  b0 d0
b15_cfa7:   lda ($d1),y                 ; 3CFA7:  b1 d1
b15_cfa9:   .db $b3                     ; 3CFA9:  b3
b15_cfaa:   ora $c65a                   ; 3CFAA:  0d 5a c6
b15_cfad:   cld                         ; 3CFAD:  d8
b15_cfae:   ldx $cf,y                   ; 3CFAE:  b6 cf
b15_cfb0:   ora $308f                   ; 3CFB0:  0d 8f 30
b15_cfb3:   dec $b9,x                   ; 3CFB3:  d6 b9
b15_cfb5:   .db $cf                     ; 3CFB5:  cf
b15_cfb6:   ora $378f                   ; 3CFB6:  0d 8f 37
b15_cfb9:   .db $d4                     ; 3CFB9:  d4
b15_cfba:   eor ($cf,x)                 ; 3CFBA:  41 cf
b15_cfbc:   rol $1e0d,x                 ; 3CFBC:  3e 0d 1e
b15_cfbf:   clv                         ; 3CFBF:  b8
b15_cfc0:   .db $b3                     ; 3CFC0:  b3
b15_cfc1:   .db $3c                     ; 3CFC1:  3c
b15_cfc2:   sbc #$98                    ; 3CFC2:  e9 98
b15_cfc4:   .db $cf                     ; 3CFC4:  cf
b15_cfc5:   asl $2b                     ; 3CFC5:  06 2b
b15_cfc7:   rol $1e0d,x                 ; 3CFC7:  3e 0d 1e
b15_cfca:   tsx                         ; 3CFCA:  ba
b15_cfcb:   .db $b3                     ; 3CFCB:  b3
b15_cfcc:   .db $3c                     ; 3CFCC:  3c
b15_cfcd:   sbc #$98                    ; 3CFCD:  e9 98
b15_cfcf:   .db $cf                     ; 3CFCF:  cf
b15_cfd0:   asl $0b                     ; 3CFD0:  06 0b
b15_cfd2:   bne $cfa3                   ; 3CFD2:  d0 cf
atoi_decimal:   jsr $e823                   ; 3CFD4:  20 23 e8
b15_cfd7:   sbc $40ff,x                 ; 3CFD7:  fd ff 40
b15_cfda:   .db $2b                     ; 3CFDA:  2b
b15_cfdb:   dec $ed,x                   ; 3CFDB:  d6 ed
b15_cfdd:   .db $cf                     ; 3CFDD:  cf
b15_cfde:   .db $0b                     ; 3CFDE:  0b
b15_cfdf:   .db $5a                     ; 3CFDF:  5a
b15_cfe0:   lda $b3,x                   ; 3CFE0:  b5 b3
b15_cfe2:   ldy #$fd                    ; 3CFE2:  a0 fd
b15_cfe4:   .db $ff                     ; 3CFE4:  ff
b15_cfe5:   ldy $bb,x                   ; 3CFE5:  b4 bb
b15_cfe7:   .db $2b                     ; 3CFE7:  2b
b15_cfe8:   .db $0c                     ; 3CFE8:  0c
b15_cfe9:   .db $b3                     ; 3CFE9:  b3
b15_cfea:   bcs $cfbc                   ; 3CFEA:  b0 d0
b15_cfec:   lda ($0c),y                 ; 3CFEC:  b1 0c
b15_cfee:   bcs $cfc3                   ; 3CFEE:  b0 d3
b15_cff0:   .db $8f                     ; 3CFF0:  8f
b15_cff1:   bne $cf95                   ; 3CFF1:  d0 a2
b15_cff3:   sbc $5aff,x                 ; 3CFF3:  fd ff 5a
b15_cff6:   .db $c2                     ; 3CFF6:  c2
b15_cff7:   .db $d7                     ; 3CFF7:  d7
b15_cff8:   dec $0bcf,x                 ; 3CFF8:  de cf 0b
b15_cffb:   .db $cf                     ; 3CFFB:  cf
format_string:   jsr $e823                   ; 3CFFC:  20 23 e8
b15_cfff:   sbc #$ff                    ; 3CFFF:  e9 ff
b15_d001:   .db $0c                     ; 3D001:  0c
b15_d002:   .db ppumask_shadow                     ; 3D002:  72
b15_d003:   bit $fe8f                   ; 3D003:  2c 8f fe
b15_d006:   bcs $cf8d                   ; 3D006:  b0 85
b15_d008:   sbc $850c,x                 ; 3D008:  fd 0c 85
b15_d00b:   sbc #$d6                    ; 3D00B:  e9 d6
b15_d00d:   clc                         ; 3D00D:  18
b15_d00e:   bne $d01d                   ; 3D00E:  d0 0d
b15_d010:   bne $d03f                   ; 3D010:  d0 2d
b15_d012:   cmp ($b3),y                 ; 3D012:  d1 b3
b15_d014:   ldy #$ff                    ; 3D014:  a0 ff
b15_d016:   .db $ff                     ; 3D016:  ff
b15_d017:   .db $d4                     ; 3D017:  d4
b15_d018:   sta ($fd,x)                 ; 3D018:  81 fd
b15_d01a:   bne $cfa1                   ; 3D01A:  d0 85
b15_d01c:   sbc $d3d1,x                 ; 3D01C:  fd d1 d3
b15_d01f:   ldx #$ff                    ; 3D01F:  a2 ff
b15_d021:   .db $ff                     ; 3D021:  ff
b15_d022:   cld                         ; 3D022:  d8
b15_d023:   bmi $cff6                   ; 3D023:  30 d1
b15_d025:   ldy #$ff                    ; 3D025:  a0 ff
b15_d027:   .db $ff                     ; 3D027:  ff
b15_d028:   .db $8b                     ; 3D028:  8b
b15_d029:   and $c0                     ; 3D029:  25 c0
b15_d02b:   cld                         ; 3D02B:  d8
b15_d02c:   .db $0f                     ; 3D02C:  0f
b15_d02d:   bne $d00d                   ; 3D02D:  d0 de
b15_d02f:   .db $f3                     ; 3D02F:  f3
b15_d030:   .db $ff                     ; 3D030:  ff
b15_d031:   sta $f1                     ; 3D031:  85 f1
b15_d033:   lsr clock_b_hi                     ; 3D033:  46 85
b15_d035:   .db $eb                     ; 3D035:  eb
b15_d036:   rti                         ; 3D036:  40
b15_d037:   sta $ef                     ; 3D037:  85 ef
b15_d039:   sta ($fd,x)                 ; 3D039:  81 fd
b15_d03b:   .db $d3                     ; 3D03B:  d3
b15_d03c:   ldx #$ff                    ; 3D03C:  a2 ff
b15_d03e:   .db $ff                     ; 3D03E:  ff
b15_d03f:   ldy #$ff                    ; 3D03F:  a0 ff
b15_d041:   .db $ff                     ; 3D041:  ff
b15_d042:   .db $b3                     ; 3D042:  b3
b15_d043:   sbc #$65                    ; 3D043:  e9 65
b15_d045:   dex                         ; 3D045:  ca
b15_d046:   .db vm_sp_lo                     ; 3D046:  02
b15_d047:   cld                         ; 3D047:  d8
b15_d048:   eor $d0,x                   ; 3D048:  55 d0
b15_d04a:   dec $fffd,x                 ; 3D04A:  de fd ff
b15_d04d:   .db $b3                     ; 3D04D:  b3
b15_d04e:   sbc #$d4                    ; 3D04E:  e9 d4
b15_d050:   .db $cf                     ; 3D050:  cf
b15_d051:   .db vm_sp_lo                     ; 3D051:  02
b15_d052:   dec $56,x                   ; 3D052:  d6 56
b15_d054:   bne $d096                   ; 3D054:  d0 40
b15_d056:   sta $ed                     ; 3D056:  85 ed
b15_d058:   sta ($fd,x)                 ; 3D058:  81 fd
b15_d05a:   bne $cfe1                   ; 3D05A:  d0 85
b15_d05c:   sbc $d3d1,x                 ; 3D05C:  fd d1 d3
b15_d05f:   ldx #$ff                    ; 3D05F:  a2 ff
b15_d061:   .db $ff                     ; 3D061:  ff
b15_d062:   .db $8b                     ; 3D062:  8b
b15_d063:   rol $d8c0                   ; 3D063:  2e c0 d8
b15_d066:   .db $7f                     ; 3D066:  7f
b15_d067:   bne $d047                   ; 3D067:  d0 de
b15_d069:   sbc $b3ff,x                 ; 3D069:  fd ff b3
b15_d06c:   sbc #$d4                    ; 3D06C:  e9 d4
b15_d06e:   .db $cf                     ; 3D06E:  cf
b15_d06f:   .db vm_sp_lo                     ; 3D06F:  02
b15_d070:   sta $eb                     ; 3D070:  85 eb
b15_d072:   eor (clock_b_hi,x)                 ; 3D072:  41 85
b15_d074:   .db $ef                     ; 3D074:  ef
b15_d075:   sta ($fd,x)                 ; 3D075:  81 fd
b15_d077:   bne $cffe                   ; 3D077:  d0 85
b15_d079:   sbc $d3d1,x                 ; 3D079:  fd d1 d3
b15_d07c:   ldx #$ff                    ; 3D07C:  a2 ff
b15_d07e:   .db $ff                     ; 3D07E:  ff
b15_d07f:   ldy #$ff                    ; 3D07F:  a0 ff
b15_d081:   .db $ff                     ; 3D081:  ff
b15_d082:   .db $b3                     ; 3D082:  b3
b15_d083:   sbc #$30                    ; 3D083:  e9 30
b15_d085:   .db $cb                     ; 3D085:  cb
b15_d086:   .db vm_sp_lo                     ; 3D086:  02
b15_d087:   cmp vm_fp_lo,y                 ; 3D087:  d9 04 00
b15_d08a:   brk                         ; 3D08A:  00
b15_d08b:   brk                         ; 3D08B:  00
b15_d08c:   .db $2f                     ; 3D08C:  2f
b15_d08d:   cmp ($43),y                 ; 3D08D:  d1 43
b15_d08f:   brk                         ; 3D08F:  00
b15_d090:   bne $d062                   ; 3D090:  d0 d0
b15_d092:   .db $44                     ; 3D092:  44
b15_d093:   brk                         ; 3D093:  00
b15_d094:   .db $9c                     ; 3D094:  9c
b15_d095:   bne $d0ea                   ; 3D095:  d0 53
b15_d097:   brk                         ; 3D097:  00
b15_d098:   .db $b7                     ; 3D098:  b7
b15_d099:   bne $d0aa                   ; 3D099:  d0 0f
b15_d09b:   bne $d107                   ; 3D09B:  d0 6a
b15_d09d:   sta ($e9,x)                 ; 3D09D:  81 e9
b15_d09f:   .db ppumask_shadow                     ; 3D09F:  72
b15_d0a0:   sta $e9                     ; 3D0A0:  85 e9
b15_d0a2:   .db $8f                     ; 3D0A2:  8f
b15_d0a3:   inc $b3b0,x                 ; 3D0A3:  fe b0 b3
b15_d0a6:   dec $fff1,x                 ; 3D0A6:  de f1 ff
b15_d0a9:   .db $b3                     ; 3D0A9:  b3
b15_d0aa:   sbc #$98                    ; 3D0AA:  e9 98
b15_d0ac:   .db $cf                     ; 3D0AC:  cf
b15_d0ad:   asl $cd                     ; 3D0AD:  06 cd
b15_d0af:   sta ($ed,x)                 ; 3D0AF:  81 ed
b15_d0b1:   ldy $ed85,x                 ; 3D0B1:  bc 85 ed
b15_d0b4:   dec $e5,x                   ; 3D0B4:  d6 e5
b15_d0b6:   bne $d039                   ; 3D0B6:  d0 81
b15_d0b8:   sbc #$72                    ; 3D0B8:  e9 72
b15_d0ba:   sta $e9                     ; 3D0BA:  85 e9
b15_d0bc:   .db $8f                     ; 3D0BC:  8f
b15_d0bd:   inc $85b0,x                 ; 3D0BD:  fe b0 85
b15_d0c0:   sbc ($87),y                 ; 3D0C0:  f1 87
b15_d0c2:   sbc ($e9),y                 ; 3D0C2:  f1 e9
b15_d0c4:   ror $02ca,x                 ; 3D0C4:  7e ca 02
b15_d0c7:   cmp $ed81                   ; 3D0C7:  cd 81 ed
b15_d0ca:   ldy $ed85,x                 ; 3D0CA:  bc 85 ed
b15_d0cd:   dec $fc,x                   ; 3D0CD:  d6 fc
b15_d0cf:   bne $d052                   ; 3D0CF:  d0 81
b15_d0d1:   sbc $85d1                   ; 3D0D1:  ed d1 85
b15_d0d4:   sbc $f181                   ; 3D0D4:  ed 81 f1
b15_d0d7:   bne $d05e                   ; 3D0D7:  d0 85
b15_d0d9:   sbc ($d1),y                 ; 3D0D9:  f1 d1
b15_d0db:   .db $b3                     ; 3D0DB:  b3
b15_d0dc:   sta ($e9,x)                 ; 3D0DC:  81 e9
b15_d0de:   .db ppumask_shadow                     ; 3D0DE:  72
b15_d0df:   sta $e9                     ; 3D0DF:  85 e9
b15_d0e1:   .db $8f                     ; 3D0E1:  8f
b15_d0e2:   inc $d4b0,x                 ; 3D0E2:  fe b0 d4
b15_d0e5:   .db $87                     ; 3D0E5:  87
b15_d0e6:   sbc ($40),y                 ; 3D0E6:  f1 40
b15_d0e8:   .db $d4                     ; 3D0E8:  d4
b15_d0e9:   dec $fff3,x                 ; 3D0E9:  de f3 ff
b15_d0ec:   sta $f1                     ; 3D0EC:  85 f1
b15_d0ee:   rti                         ; 3D0EE:  40
b15_d0ef:   sta $ef                     ; 3D0EF:  85 ef
b15_d0f1:   dec $fc,x                   ; 3D0F1:  d6 fc
b15_d0f3:   bne $d102                   ; 3D0F3:  d0 0d
b15_d0f5:   bne $d124                   ; 3D0F5:  d0 2d
b15_d0f7:   cmp ($b3),y                 ; 3D0F7:  d1 b3
b15_d0f9:   .db skip_wallclock                     ; 3D0F9:  89
b15_d0fa:   jsr $81d4                   ; 3D0FA:  20 d4 81
b15_d0fd:   sbc $85d1                   ; 3D0FD:  ed d1 85
b15_d100:   sbc $50d0                   ; 3D100:  ed d0 50
b15_d103:   cpy $d7                     ; 3D103:  c4 d7
b15_d105:   .db $f4                     ; 3D105:  f4
b15_d106:   bne $d089                   ; 3D106:  d0 81
b15_d108:   sbc ($d3),y                 ; 3D108:  f1 d3
b15_d10a:   cld                         ; 3D10A:  d8
b15_d10b:   clc                         ; 3D10B:  18
b15_d10c:   bne $d08f                   ; 3D10C:  d0 81
b15_d10e:   .db $ef                     ; 3D10E:  ef
b15_d10f:   cld                         ; 3D10F:  d8
b15_d110:   ora $81d1,y                 ; 3D110:  19 d1 81
b15_d113:   .db $eb                     ; 3D113:  eb
b15_d114:   bvc $d0da                   ; 3D114:  50 c4
b15_d116:   cld                         ; 3D116:  d8
b15_d117:   .db $27                     ; 3D117:  27
b15_d118:   cmp ($0d),y                 ; 3D118:  d1 0d
b15_d11a:   bne $d149                   ; 3D11A:  d0 2d
b15_d11c:   cmp ($b3),y                 ; 3D11C:  d1 b3
b15_d11e:   sta ($f1,x)                 ; 3D11E:  81 f1
b15_d120:   .db $d3                     ; 3D120:  d3
b15_d121:   .db $d4                     ; 3D121:  d4
b15_d122:   sta ($eb,x)                 ; 3D122:  81 eb
b15_d124:   cmp (clock_b_hi),y                 ; 3D124:  d1 85
b15_d126:   .db $eb                     ; 3D126:  eb
b15_d127:   sta ($f1,x)                 ; 3D127:  81 f1
b15_d129:   bne $d0b0                   ; 3D129:  d0 85
b15_d12b:   sbc ($d6),y                 ; 3D12B:  f1 d6
b15_d12d:   .db vm_ip_hi                     ; 3D12D:  07
b15_d12e:   cmp ($cf),y                 ; 3D12E:  d1 cf
b15_d130:   and $d440,x                 ; 3D130:  3d 40 d4
b15_d133:   .db $cf                     ; 3D133:  cf
draw_message:   jsr $e823                   ; 3D134:  20 23 e8
b15_d137:   ror a                       ; 3D137:  6a
b15_d138:   .db $ff                     ; 3D138:  ff
b15_d139:   dec $ff6a,x                 ; 3D139:  de 6a ff
b15_d13c:   .db $b3                     ; 3D13C:  b3
b15_d13d:   dec $000b,x                 ; 3D13D:  de 0b 00
b15_d140:   .db $b3                     ; 3D140:  b3
b15_d141:   sbc #$fc                    ; 3D141:  e9 fc
b15_d143:   .db $cf                     ; 3D143:  cf
b15_d144:   .db vm_fp_lo                     ; 3D144:  04
b15_d145:   dec $ff6a,x                 ; 3D145:  de 6a ff
b15_d148:   .db $b3                     ; 3D148:  b3
b15_d149:   sbc #$c4                    ; 3D149:  e9 c4
b15_d14b:   dec $cf02                   ; 3D14B:  ce 02 cf
poll_input:   jsr $e823                   ; 3D14E:  20 23 e8
b15_d151:   sed                         ; 3D151:  f8
b15_d152:   .db $ff                     ; 3D152:  ff
b15_d153:   .db $42                     ; 3D153:  42
b15_d154:   .db $2b                     ; 3D154:  2b
b15_d155:   ldy $d3                     ; 3D155:  a4 d3
b15_d157:   .db $7f                     ; 3D157:  7f
b15_d158:   cmp scratch_ptr_lo,x                   ; 3D158:  d5 00
b15_d15a:   brk                         ; 3D15A:  00
b15_d15b:   ora scratch_ptr_lo                     ; 3D15B:  05 00
b15_d15d:   .db $6b                     ; 3D15D:  6b
b15_d15e:   cmp (brk_jmp_target_hi),y                 ; 3D15E:  d1 69
b15_d160:   cmp ($e1),y                 ; 3D160:  d1 e1
b15_d162:   cmp ($e8),y                 ; 3D162:  d1 e8
b15_d164:   cmp ($ee),y                 ; 3D164:  d1 ee
b15_d166:   cmp ($4e),y                 ; 3D166:  d1 4e
b15_d168:   .db $d2                     ; 3D168:  d2
b15_d169:   rti                         ; 3D169:  40
b15_d16a:   .db $2b                     ; 3D16A:  2b
b15_d16b:   .db $0b                     ; 3D16B:  0b
b15_d16c:   eor ($c8),y                 ; 3D16C:  51 c8
b15_d16e:   .db $d7                     ; 3D16E:  d7
b15_d16f:   cmp #$d1                    ; 3D16F:  c9 d1
b15_d171:   .db $0b                     ; 3D171:  0b
b15_d172:   eor ($da),y                 ; 3D172:  51 da
b15_d174:   .db $2b                     ; 3D174:  2b
b15_d175:   ldx $df                     ; 3D175:  a6 df
b15_d177:   .db $7f                     ; 3D177:  7f
b15_d178:   cmp ($d8,x)                 ; 3D178:  c1 d8
b15_d17a:   lda $a4d1                   ; 3D17A:  ad d1 a4
b15_d17d:   cmp $297f                   ; 3D17D:  cd 7f 29
b15_d180:   ldy $cf                     ; 3D180:  a4 cf
b15_d182:   .db $7f                     ; 3D182:  7f
b15_d183:   plp                         ; 3D183:  28
b15_d184:   adc ($8d,x)                 ; 3D184:  61 8d
b15_d186:   .db $1a                     ; 3D186:  1a
b15_d187:   sta $8d1d                   ; 3D187:  8d 1d 8d
b15_d18a:   .db $1a                     ; 3D18A:  1a
b15_d18b:   sta $e914                   ; 3D18B:  8d 14 e9
b15_d18e:   ror a                       ; 3D18E:  6a
b15_d18f:   .db $cf                     ; 3D18F:  cf
b15_d190:   asl a                       ; 3D190:  0a
b15_d191:   sta $8d1a                   ; 3D191:  8d 1a 8d
b15_d194:   ora $e9,x                   ; 3D194:  15 e9
b15_d196:   .db music_ptr_hi                     ; 3D196:  7b
b15_d197:   cpy $0b04                   ; 3D197:  cc 04 0b
b15_d19a:   bne $d14f                   ; 3D19A:  d0 b3
b15_d19c:   stx $f68a                   ; 3D19C:  8e 8a f6
b15_d19f:   sbc #$34                    ; 3D19F:  e9 34
b15_d1a1:   cmp (vm_fp_lo),y                 ; 3D1A1:  d1 04
b15_d1a3:   sec                         ; 3D1A3:  38
b15_d1a4:   and $7be9,y                 ; 3D1A4:  39 e9 7b
b15_d1a7:   cpy $0b04                   ; 3D1A7:  cc 04 0b
b15_d1aa:   tay                         ; 3D1AA:  a8
b15_d1ab:   .db $df                     ; 3D1AB:  df
b15_d1ac:   .db $7f                     ; 3D1AC:  7f
b15_d1ad:   ldy $e7                     ; 3D1AD:  a4 e7
b15_d1af:   .db $7f                     ; 3D1AF:  7f
b15_d1b0:   .db $52                     ; 3D1B0:  52
b15_d1b1:   cmp ($d8,x)                 ; 3D1B1:  c1 d8
b15_d1b3:   adc #$d2                    ; 3D1B3:  69 d2
b15_d1b5:   ldy $e9                     ; 3D1B5:  a4 e9
b15_d1b7:   .db $7f                     ; 3D1B7:  7f
b15_d1b8:   cmp ($a8),y                 ; 3D1B8:  d1 a8
b15_d1ba:   sbc #$7f                    ; 3D1BA:  e9 7f
b15_d1bc:   cmp vm_sp_lo,y                 ; 3D1BC:  d9 02 00
b15_d1bf:   .db $64                     ; 3D1BF:  64
b15_d1c0:   brk                         ; 3D1C0:  00
b15_d1c1:   .db $52                     ; 3D1C1:  52
b15_d1c2:   .db $d2                     ; 3D1C2:  d2
b15_d1c3:   brk                         ; 3D1C3:  00
b15_d1c4:   brk                         ; 3D1C4:  00
b15_d1c5:   bvs $d199                   ; 3D1C5:  70 d2
b15_d1c7:   adc #$d2                    ; 3D1C7:  69 d2
b15_d1c9:   rti                         ; 3D1C9:  40
b15_d1ca:   .db $2b                     ; 3D1CA:  2b
b15_d1cb:   .db $3a                     ; 3D1CB:  3a
b15_d1cc:   sbc #$72                    ; 3D1CC:  e9 72
b15_d1ce:   .db $d7                     ; 3D1CE:  d7
b15_d1cf:   .db vm_sp_lo                     ; 3D1CF:  02
b15_d1d0:   .db $b3                     ; 3D1D0:  b3
b15_d1d1:   .db $0b                     ; 3D1D1:  0b
b15_d1d2:   sty player_daimyo                   ; 3D1D2:  8c d5 7f
b15_d1d5:   .db $bb                     ; 3D1D5:  bb
b15_d1d6:   .db $d3                     ; 3D1D6:  d3
b15_d1d7:   ldy $c1,x                   ; 3D1D7:  b4 c1
b15_d1d9:   cld                         ; 3D1D9:  d8
b15_d1da:   adc ($d1),y                 ; 3D1DA:  71 d1
b15_d1dc:   .db $0b                     ; 3D1DC:  0b
b15_d1dd:   bne $d1b5                   ; 3D1DD:  d0 d6
b15_d1df:   dex                         ; 3D1DF:  ca
b15_d1e0:   cmp ($a4),y                 ; 3D1E0:  d1 a4
b15_d1e2:   .db $5f                     ; 3D1E2:  5f
b15_d1e3:   .db p2_buttons                     ; 3D1E3:  6f
b15_d1e4:   rol a                       ; 3D1E4:  2a
b15_d1e5:   dec $6b,x                   ; 3D1E5:  d6 6b
b15_d1e7:   cmp ($a4),y                 ; 3D1E7:  d1 a4
b15_d1e9:   .db $63                     ; 3D1E9:  63
b15_d1ea:   .db p2_buttons                     ; 3D1EA:  6f
b15_d1eb:   dec $e4,x                   ; 3D1EB:  d6 e4
b15_d1ed:   cmp ($a4),y                 ; 3D1ED:  d1 a4
b15_d1ef:   sbc ($7f,x)                 ; 3D1EF:  e1 7f
b15_d1f1:   sty $00ff                   ; 3D1F1:  8c ff 00
b15_d1f4:   cpy #$d8                    ; 3D1F4:  c0 d8
b15_d1f6:   and $40d2,x                 ; 3D1F6:  3d d2 40
b15_d1f9:   dec $fe,x                   ; 3D1F9:  d6 fe
b15_d1fb:   cmp ($0b),y                 ; 3D1FB:  d1 0b
b15_d1fd:   bne $d22a                   ; 3D1FD:  d0 2b
b15_d1ff:   ldy $d77e                   ; 3D1FF:  ac 7e d7
b15_d202:   .db $b3                     ; 3D202:  b3
b15_d203:   .db $0b                     ; 3D203:  0b
b15_d204:   sty player_daimyo                   ; 3D204:  8c d5 7f
b15_d207:   .db $bb                     ; 3D207:  bb
b15_d208:   .db $d3                     ; 3D208:  d3
b15_d209:   ldy $c1,x                   ; 3D209:  b4 c1
b15_d20b:   cld                         ; 3D20B:  d8
b15_d20c:   .db $14                     ; 3D20C:  14
b15_d20d:   .db $d2                     ; 3D20D:  d2
b15_d20e:   .db $0b                     ; 3D20E:  0b
b15_d20f:   cli                         ; 3D20F:  58
b15_d210:   dec $d7                     ; 3D210:  c6 d7
b15_d212:   .db $fc                     ; 3D212:  fc
b15_d213:   cmp ($0b),y                 ; 3D213:  d1 0b
b15_d215:   cli                         ; 3D215:  58
b15_d216:   cmp #$d8                    ; 3D216:  c9 d8
b15_d218:   .db $37                     ; 3D218:  37
b15_d219:   .db $d2                     ; 3D219:  d2
b15_d21a:   rti                         ; 3D21A:  40
b15_d21b:   dec $20,x                   ; 3D21B:  d6 20
b15_d21d:   .db $d2                     ; 3D21D:  d2
b15_d21e:   .db $0b                     ; 3D21E:  0b
b15_d21f:   bne $d24c                   ; 3D21F:  d0 2b
b15_d221:   tax                         ; 3D221:  aa
b15_d222:   .db $63                     ; 3D222:  63
b15_d223:   .db p2_buttons                     ; 3D223:  6f
b15_d224:   sbc #$72                    ; 3D224:  e9 72
b15_d226:   .db $d7                     ; 3D226:  d7
b15_d227:   .db vm_sp_lo                     ; 3D227:  02
b15_d228:   .db $b3                     ; 3D228:  b3
b15_d229:   .db $0b                     ; 3D229:  0b
b15_d22a:   sty player_daimyo                   ; 3D22A:  8c d5 7f
b15_d22d:   .db $bb                     ; 3D22D:  bb
b15_d22e:   .db $d3                     ; 3D22E:  d3
b15_d22f:   ldy $c1,x                   ; 3D22F:  b4 c1
b15_d231:   .db $d7                     ; 3D231:  d7
b15_d232:   asl $0bd2,x                 ; 3D232:  1e d2 0b
b15_d235:   bne $d262                   ; 3D235:  d0 2b
b15_d237:   .db $0b                     ; 3D237:  0b
b15_d238:   eor ($da),y                 ; 3D238:  51 da
b15_d23a:   tay                         ; 3D23A:  a8
b15_d23b:   sbc ($7f,x)                 ; 3D23B:  e1 7f
b15_d23d:   ldy $e1                     ; 3D23D:  a4 e1
b15_d23f:   .db $7f                     ; 3D23F:  7f
b15_d240:   .db $2b                     ; 3D240:  2b
b15_d241:   ldy $e8                     ; 3D241:  a4 e8
b15_d243:   .db music_ptr_hi                     ; 3D243:  7b
b15_d244:   cld                         ; 3D244:  d8
b15_d245:   .db $6b                     ; 3D245:  6b
b15_d246:   cmp ($41),y                 ; 3D246:  d1 41
b15_d248:   cmp $dc0b                   ; 3D248:  cd 0b dc
b15_d24b:   dec $6a,x                   ; 3D24B:  d6 6a
b15_d24d:   cmp ($41),y                 ; 3D24D:  d1 41
b15_d24f:   dec $6a,x                   ; 3D24F:  d6 6a
b15_d251:   cmp ($aa),y                 ; 3D251:  d1 aa
b15_d253:   .db $e7                     ; 3D253:  e7
b15_d254:   .db $7f                     ; 3D254:  7f
b15_d255:   rts                         ; 3D255:  60
b15_d256:   ldy $cf                     ; 3D256:  a4 cf
b15_d258:   .db $7f                     ; 3D258:  7f
b15_d259:   .db $53                     ; 3D259:  53
b15_d25a:   lda $b3d1,x                 ; 3D25A:  bd d1 b3
b15_d25d:   ldy $cd                     ; 3D25D:  a4 cd
b15_d25f:   .db $7f                     ; 3D25F:  7f
b15_d260:   .db $53                     ; 3D260:  53
b15_d261:   lda $60b3,x                 ; 3D261:  bd b3 60
b15_d264:   .db $63                     ; 3D264:  63
b15_d265:   sbc #$26                    ; 3D265:  e9 26
b15_d267:   .db $f2                     ; 3D267:  f2
b15_d268:   .db $0c                     ; 3D268:  0c
b15_d269:   .db $3b                     ; 3D269:  3b
b15_d26a:   ror $e9                     ; 3D26A:  66 e9
b15_d26c:   rol $f2                     ; 3D26C:  26 f2
b15_d26e:   .db vm_fp_lo                     ; 3D26E:  04
b15_d26f:   .db $cf                     ; 3D26F:  cf
b15_d270:   .db $62                     ; 3D270:  62
b15_d271:   rts                         ; 3D271:  60
b15_d272:   stx $00f8                   ; 3D272:  8e f8 00
b15_d275:   stx $00f8                   ; 3D275:  8e f8 00
b15_d278:   rts                         ; 3D278:  60
b15_d279:   .db $63                     ; 3D279:  63
b15_d27a:   sbc #$26                    ; 3D27A:  e9 26
b15_d27c:   .db $f2                     ; 3D27C:  f2
b15_d27d:   .db $0c                     ; 3D27D:  0c
b15_d27e:   txa                         ; 3D27E:  8a
b15_d27f:   iny                         ; 3D27F:  c8
b15_d280:   brk                         ; 3D280:  00
b15_d281:   tay                         ; 3D281:  a8
b15_d282:   sbc #$7f                    ; 3D282:  e9 7f
b15_d284:   dec brk_jmp_target_hi,x                   ; 3D284:  d6 69
b15_d286:   .db $d2                     ; 3D286:  d2
wait_button_edge:   jsr $e823                   ; 3D287:  20 23 e8
b15_d28a:   inc $acff,x                 ; 3D28A:  fe ff ac
b15_d28d:   lsr $d7d1                   ; 3D28D:  4e d1 d7
b15_d290:   sty $40d2                   ; 3D290:  8c d2 40
b15_d293:   .db $2b                     ; 3D293:  2b
b15_d294:   ldy $d14e                   ; 3D294:  ac 4e d1
b15_d297:   .db $2b                     ; 3D297:  2b
b15_d298:   cld                         ; 3D298:  d8
b15_d299:   sty $d2,x                   ; 3D299:  94 d2
b15_d29b:   .db $0b                     ; 3D29B:  0b
b15_d29c:   .db $cf                     ; 3D29C:  cf
read_frame_timer:   jsr $e823                   ; 3D29D:  20 23 e8
b15_d2a0:   brk                         ; 3D2A0:  00
b15_d2a1:   brk                         ; 3D2A1:  00
b15_d2a2:   .db $0c                     ; 3D2A2:  0c
b15_d2a3:   cld                         ; 3D2A3:  d8
b15_d2a4:   .db $ab                     ; 3D2A4:  ab
b15_d2a5:   .db $d2                     ; 3D2A5:  d2
b15_d2a6:   .db $0c                     ; 3D2A6:  0c
b15_d2a7:   cmp ($d6),y                 ; 3D2A7:  d1 d6
b15_d2a9:   ldy $42d2                   ; 3D2A9:  ac d2 42
b15_d2ac:   tay                         ; 3D2AC:  a8
b15_d2ad:   .db $e7                     ; 3D2AD:  e7
b15_d2ae:   .db $7f                     ; 3D2AE:  7f
b15_d2af:   .db $0c                     ; 3D2AF:  0c
b15_d2b0:   .db $d7                     ; 3D2B0:  d7
b15_d2b1:   dex                         ; 3D2B1:  ca
b15_d2b2:   .db $d2                     ; 3D2B2:  d2
b15_d2b3:   .db $62                     ; 3D2B3:  62
b15_d2b4:   rts                         ; 3D2B4:  60
b15_d2b5:   stx $00f8                   ; 3D2B5:  8e f8 00
b15_d2b8:   stx $00f8                   ; 3D2B8:  8e f8 00
b15_d2bb:   rts                         ; 3D2BB:  60
b15_d2bc:   .db $63                     ; 3D2BC:  63
b15_d2bd:   sbc #$26                    ; 3D2BD:  e9 26
b15_d2bf:   .db $f2                     ; 3D2BF:  f2
b15_d2c0:   .db $0c                     ; 3D2C0:  0c
b15_d2c1:   sta $e913                   ; 3D2C1:  8d 13 e9
b15_d2c4:   rol $f2                     ; 3D2C4:  26 f2
b15_d2c6:   .db vm_sp_lo                     ; 3D2C6:  02
b15_d2c7:   dec $f8,x                   ; 3D2C7:  d6 f8
b15_d2c9:   .db $d2                     ; 3D2C9:  d2
b15_d2ca:   .db $0c                     ; 3D2CA:  0c
b15_d2cb:   eor ($c0),y                 ; 3D2CB:  51 c0
b15_d2cd:   cld                         ; 3D2CD:  d8
b15_d2ce:   .db $db                     ; 3D2CE:  db
b15_d2cf:   .db $d2                     ; 3D2CF:  d2
b15_d2d0:   .db $62                     ; 3D2D0:  62
b15_d2d1:   rts                         ; 3D2D1:  60
b15_d2d2:   stx $00f8                   ; 3D2D2:  8e f8 00
b15_d2d5:   stx $00f8                   ; 3D2D5:  8e f8 00
b15_d2d8:   dec $ec,x                   ; 3D2D8:  d6 ec
b15_d2da:   .db $d2                     ; 3D2DA:  d2
b15_d2db:   tax                         ; 3D2DB:  aa
b15_d2dc:   .db $e7                     ; 3D2DC:  e7
b15_d2dd:   .db $7f                     ; 3D2DD:  7f
b15_d2de:   rts                         ; 3D2DE:  60
b15_d2df:   ldy $cf                     ; 3D2DF:  a4 cf
b15_d2e1:   .db $7f                     ; 3D2E1:  7f
b15_d2e2:   .db $53                     ; 3D2E2:  53
b15_d2e3:   lda $b3d1,x                 ; 3D2E3:  bd d1 b3
b15_d2e6:   ldy $cd                     ; 3D2E6:  a4 cd
b15_d2e8:   .db $7f                     ; 3D2E8:  7f
b15_d2e9:   .db $53                     ; 3D2E9:  53
b15_d2ea:   lda $60b3,x                 ; 3D2EA:  bd b3 60
b15_d2ed:   .db $63                     ; 3D2ED:  63
b15_d2ee:   sbc #$26                    ; 3D2EE:  e9 26
b15_d2f0:   .db $f2                     ; 3D2F0:  f2
b15_d2f1:   .db $0c                     ; 3D2F1:  0c
b15_d2f2:   txa                         ; 3D2F2:  8a
b15_d2f3:   iny                         ; 3D2F3:  c8
b15_d2f4:   brk                         ; 3D2F4:  00
b15_d2f5:   tay                         ; 3D2F5:  a8
b15_d2f6:   sbc #$7f                    ; 3D2F6:  e9 7f
b15_d2f8:   .db $cf                     ; 3D2F8:  cf
clear_rect_left_upper:   jsr $e823                   ; 3D2F9:  20 23 e8
b15_d2fc:   brk                         ; 3D2FC:  00
b15_d2fd:   brk                         ; 3D2FD:  00
b15_d2fe:   adc ($8d,x)                 ; 3D2FE:  61 8d
b15_d300:   .db $13                     ; 3D300:  13
b15_d301:   adc #$68                    ; 3D301:  69 68
b15_d303:   .db $62                     ; 3D303:  62
b15_d304:   sbc #$42                    ; 3D304:  e9 42
b15_d306:   cpy $cf0a                   ; 3D306:  cc 0a cf
clear_rect_left_lower:   jsr $e823                   ; 3D309:  20 23 e8
b15_d30c:   brk                         ; 3D30C:  00
b15_d30d:   brk                         ; 3D30D:  00
b15_d30e:   adc ($8d,x)                 ; 3D30E:  61 8d
b15_d310:   .db $1a                     ; 3D310:  1a
b15_d311:   adc #$8d                    ; 3D311:  69 8d
b15_d313:   .db $14                     ; 3D313:  14
b15_d314:   .db $62                     ; 3D314:  62
b15_d315:   sbc #$42                    ; 3D315:  e9 42
b15_d317:   cpy $cf0a                   ; 3D317:  cc 0a cf
clear_rect_left_lower_alt:   jsr $e823                   ; 3D31A:  20 23 e8
b15_d31d:   brk                         ; 3D31D:  00
b15_d31e:   brk                         ; 3D31E:  00
b15_d31f:   ldy $d759                   ; 3D31F:  ac 59 d7
b15_d322:   ldy $d309                   ; 3D322:  ac 09 d3
b15_d325:   .db $cf                     ; 3D325:  cf
message_display:   jsr $e823                   ; 3D326:  20 23 e8
b15_d329:   brk                         ; 3D329:  00
b15_d32a:   brk                         ; 3D32A:  00
b15_d32b:   ldy $c5                     ; 3D32B:  a4 c5
b15_d32d:   .db $7f                     ; 3D32D:  7f
b15_d32e:   cld                         ; 3D32E:  d8
b15_d32f:   sec                         ; 3D32F:  38
b15_d330:   .db $d3                     ; 3D330:  d3
b15_d331:   ldy $d309                   ; 3D331:  ac 09 d3
b15_d334:   rti                         ; 3D334:  40
b15_d335:   tay                         ; 3D335:  a8
b15_d336:   cmp $7f                     ; 3D336:  c5 7f
b15_d338:   ldy $d1                     ; 3D338:  a4 d1
b15_d33a:   .db $7f                     ; 3D33A:  7f
b15_d33b:   cld                         ; 3D33B:  d8
b15_d33c:   .db $43                     ; 3D33C:  43
b15_d33d:   .db $d3                     ; 3D33D:  d3
b15_d33e:   .db skip_wallclock                     ; 3D33E:  89
b15_d33f:   .db $14                     ; 3D33F:  14
b15_d340:   dec $45,x                   ; 3D340:  d6 45
b15_d342:   .db $d3                     ; 3D342:  d3
b15_d343:   .db skip_wallclock                     ; 3D343:  89
b15_d344:   asl $b3,x                   ; 3D344:  16 b3
b15_d346:   .db $62                     ; 3D346:  62
b15_d347:   sbc #$7b                    ; 3D347:  e9 7b
b15_d349:   cpy $3c04                   ; 3D349:  cc 04 3c
b15_d34c:   sbc #$c4                    ; 3D34C:  e9 c4
b15_d34e:   dec $cf02                   ; 3D34E:  ce 02 cf
prompt_ab_window:   jsr $e823                   ; 3D351:  20 23 e8
b15_d354:   inc $3cff,x                 ; 3D354:  fe ff 3c
b15_d357:   sbc #$c4                    ; 3D357:  e9 c4
b15_d359:   dec $6102                   ; 3D359:  ce 02 61
b15_d35c:   sbc #$9d                    ; 3D35C:  e9 9d
b15_d35e:   .db $d2                     ; 3D35E:  d2
b15_d35f:   .db vm_sp_lo                     ; 3D35F:  02
b15_d360:   ldy $d287                   ; 3D360:  ac 87 d2
b15_d363:   .db $2b                     ; 3D363:  2b
b15_d364:   .db $8b                     ; 3D364:  8b
b15_d365:   rti                         ; 3D365:  40
b15_d366:   cmp ($d8,x)                 ; 3D366:  c1 d8
b15_d368:   sei                         ; 3D368:  78
b15_d369:   .db $d3                     ; 3D369:  d3
b15_d36a:   .db $0b                     ; 3D36A:  0b
b15_d36b:   sty skip_vblank_wait                   ; 3D36B:  8c 80 00
b15_d36e:   cmp ($d8,x)                 ; 3D36E:  c1 d8
b15_d370:   sei                         ; 3D370:  78
b15_d371:   .db $d3                     ; 3D371:  d3
b15_d372:   .db $0b                     ; 3D372:  0b
b15_d373:   .db $52                     ; 3D373:  52
b15_d374:   cmp ($d7,x)                 ; 3D374:  c1 d7
b15_d376:   rts                         ; 3D376:  60
b15_d377:   .db $d3                     ; 3D377:  d3
b15_d378:   rts                         ; 3D378:  60
b15_d379:   sbc #$9d                    ; 3D379:  e9 9d
b15_d37b:   .db $d2                     ; 3D37B:  d2
b15_d37c:   .db vm_sp_lo                     ; 3D37C:  02
b15_d37d:   .db $0b                     ; 3D37D:  0b
b15_d37e:   .db $8b                     ; 3D37E:  8b
b15_d37f:   rti                         ; 3D37F:  40
b15_d380:   cpy #$d8                    ; 3D380:  c0 d8
b15_d382:   stx $8dd3                   ; 3D382:  8e d3 8d
b15_d385:   .db $3c                     ; 3D385:  3c
b15_d386:   sbc #$81                    ; 3D386:  e9 81
b15_d388:   dec $4102                   ; 3D388:  ce 02 41
b15_d38b:   dec $a1,x                   ; 3D38B:  d6 a1
b15_d38d:   .db $d3                     ; 3D38D:  d3
b15_d38e:   .db $0b                     ; 3D38E:  0b
b15_d38f:   sty skip_vblank_wait                   ; 3D38F:  8c 80 00
b15_d392:   cpy #$d8                    ; 3D392:  c0 d8
b15_d394:   ldy #$d3                    ; 3D394:  a0 d3
b15_d396:   sta $e93e                   ; 3D396:  8d 3e e9
b15_d399:   sta ($ce,x)                 ; 3D399:  81 ce
b15_d39b:   .db vm_sp_lo                     ; 3D39B:  02
b15_d39c:   rti                         ; 3D39C:  40
b15_d39d:   dec $a1,x                   ; 3D39D:  d6 a1
b15_d39f:   .db $d3                     ; 3D39F:  d3
b15_d3a0:   .db $42                     ; 3D3A0:  42
b15_d3a1:   .db $2b                     ; 3D3A1:  2b
b15_d3a2:   ldy $cc89                   ; 3D3A2:  ac 89 cc
b15_d3a5:   .db $0b                     ; 3D3A5:  0b
b15_d3a6:   .db $cf                     ; 3D3A6:  cf
prompt_y_n:   jsr $e823                   ; 3D3A7:  20 23 e8
b15_d3aa:   inc $8eff,x                 ; 3D3AA:  fe ff 8e
b15_d3ad:   sta $f6,x                   ; 3D3AD:  95 f6
b15_d3af:   sbc #$c4                    ; 3D3AF:  e9 c4
b15_d3b1:   dec $6102                   ; 3D3B1:  ce 02 61
b15_d3b4:   sbc #$9d                    ; 3D3B4:  e9 9d
b15_d3b6:   .db $d2                     ; 3D3B6:  d2
b15_d3b7:   .db vm_sp_lo                     ; 3D3B7:  02
b15_d3b8:   ldy $d287                   ; 3D3B8:  ac 87 d2
b15_d3bb:   .db $2b                     ; 3D3BB:  2b
b15_d3bc:   .db $8b                     ; 3D3BC:  8b
b15_d3bd:   rti                         ; 3D3BD:  40
b15_d3be:   cmp ($d8,x)                 ; 3D3BE:  c1 d8
b15_d3c0:   dex                         ; 3D3C0:  ca
b15_d3c1:   .db $d3                     ; 3D3C1:  d3
b15_d3c2:   .db $0b                     ; 3D3C2:  0b
b15_d3c3:   sty skip_vblank_wait                   ; 3D3C3:  8c 80 00
b15_d3c6:   cmp ($d7,x)                 ; 3D3C6:  c1 d7
b15_d3c8:   clv                         ; 3D3C8:  b8
b15_d3c9:   .db $d3                     ; 3D3C9:  d3
b15_d3ca:   rts                         ; 3D3CA:  60
b15_d3cb:   sbc #$9d                    ; 3D3CB:  e9 9d
b15_d3cd:   .db $d2                     ; 3D3CD:  d2
b15_d3ce:   .db vm_sp_lo                     ; 3D3CE:  02
b15_d3cf:   .db $0b                     ; 3D3CF:  0b
b15_d3d0:   .db $8b                     ; 3D3D0:  8b
b15_d3d1:   rti                         ; 3D3D1:  40
b15_d3d2:   cpy #$d8                    ; 3D3D2:  c0 d8
b15_d3d4:   cpx #$d3                    ; 3D3D4:  e0 d3
b15_d3d6:   sta $e959                   ; 3D3D6:  8d 59 e9
b15_d3d9:   sta ($ce,x)                 ; 3D3D9:  81 ce
b15_d3db:   .db vm_sp_lo                     ; 3D3DB:  02
b15_d3dc:   eor ($d6,x)                 ; 3D3DC:  41 d6
b15_d3de:   .db $e7                     ; 3D3DE:  e7
b15_d3df:   .db $d3                     ; 3D3DF:  d3
b15_d3e0:   sta $e94e                   ; 3D3E0:  8d 4e e9
b15_d3e3:   sta ($ce,x)                 ; 3D3E3:  81 ce
b15_d3e5:   .db vm_sp_lo                     ; 3D3E5:  02
b15_d3e6:   rti                         ; 3D3E6:  40
b15_d3e7:   .db $2b                     ; 3D3E7:  2b
b15_d3e8:   ldy $cc89                   ; 3D3E8:  ac 89 cc
b15_d3eb:   .db $0b                     ; 3D3EB:  0b
b15_d3ec:   .db $cf                     ; 3D3EC:  cf
cursor_nav_loop:   jsr $e823                   ; 3D3ED:  20 23 e8
b15_d3f0:   cpx $40ff                   ; 3D3F0:  ec ff 40
b15_d3f3:   bit $40                     ; 3D3F3:  24 40
b15_d3f5:   rol $41                     ; 3D3F5:  26 41
b15_d3f7:   and $de                     ; 3D3F7:  25 de
b15_d3f9:   .db $f4                     ; 3D3F9:  f4
b15_d3fa:   .db $ff                     ; 3D3FA:  ff
b15_d3fb:   .db $b3                     ; 3D3FB:  b3
b15_d3fc:   ora $d2                     ; 3D3FC:  05 d2
b15_d3fe:   ldy $bb,x                   ; 3D3FE:  b4 bb
b15_d400:   .db $b3                     ; 3D400:  b3
b15_d401:   txa                         ; 3D401:  8a
b15_d402:   .db $ff                     ; 3D402:  ff
b15_d403:   brk                         ; 3D403:  00
b15_d404:   lda (vm_fp_hi),y                 ; 3D404:  b1 05
b15_d406:   bne $d42d                   ; 3D406:  d0 25
b15_d408:   ora $55                     ; 3D408:  05 55
b15_d40a:   .db $c3                     ; 3D40A:  c3
b15_d40b:   .db $d7                     ; 3D40B:  d7
b15_d40c:   sed                         ; 3D40C:  f8
b15_d40d:   .db $d3                     ; 3D40D:  d3
b15_d40e:   rol $8e,x                   ; 3D40E:  36 8e
b15_d410:   .db $9e                     ; 3D410:  9e
b15_d411:   inc $e9,x                   ; 3D411:  f6 e9
b15_d413:   .db $34                     ; 3D413:  34
b15_d414:   cmp (vm_fp_lo),y                 ; 3D414:  d1 04
b15_d416:   ldy $cd                     ; 3D416:  a4 cd
b15_d418:   .db $7f                     ; 3D418:  7f
b15_d419:   cmp ($a8),y                 ; 3D419:  d1 a8
b15_d41b:   cmp $617f                   ; 3D41B:  cd 7f 61
b15_d41e:   sbc #$9d                    ; 3D41E:  e9 9d
b15_d420:   .db $d2                     ; 3D420:  d2
b15_d421:   .db vm_sp_lo                     ; 3D421:  02
b15_d422:   ldy $d287                   ; 3D422:  ac 87 d2
b15_d425:   rti                         ; 3D425:  40
b15_d426:   .db $22                     ; 3D426:  22
b15_d427:   ldy $d14e                   ; 3D427:  ac 4e d1
b15_d42a:   cmp vm_ip_lo,y                 ; 3D42A:  d9 06 00
b15_d42d:   ora (scratch_ptr_lo,x)                 ; 3D42D:  01 00
b15_d42f:   eor $02d4,y                 ; 3D42F:  59 d4 02
b15_d432:   brk                         ; 3D432:  00
b15_d433:   .db $47                     ; 3D433:  47
b15_d434:   .db $d4                     ; 3D434:  d4
b15_d435:   bpl $d437                   ; 3D435:  10 00
b15_d437:   adc #$d4                    ; 3D437:  69 d4
b15_d439:   jsr $af00                   ; 3D439:  20 00 af
b15_d43c:   .db $d4                     ; 3D43C:  d4
b15_d43d:   rti                         ; 3D43D:  40
b15_d43e:   brk                         ; 3D43E:  00
b15_d43f:   .db $db                     ; 3D43F:  db
b15_d440:   .db $d4                     ; 3D440:  d4
b15_d441:   .db skip_vblank_wait                     ; 3D441:  80
b15_d442:   brk                         ; 3D442:  00
b15_d443:   ora ($d5),y                 ; 3D443:  11 d5
b15_d445:   rts                         ; 3D445:  60
b15_d446:   .db $d4                     ; 3D446:  d4
b15_d447:   rts                         ; 3D447:  60
b15_d448:   sbc #$9d                    ; 3D448:  e9 9d
b15_d44a:   .db $d2                     ; 3D44A:  d2
b15_d44b:   .db vm_sp_lo                     ; 3D44B:  02
b15_d44c:   ldy $e0                     ; 3D44C:  a4 e0
b15_d44e:   .db music_ptr_hi                     ; 3D44E:  7b
b15_d44f:   eor ($c0),y                 ; 3D44F:  51 c0
b15_d451:   cld                         ; 3D451:  d8
b15_d452:   .db $57                     ; 3D452:  57
b15_d453:   .db $d4                     ; 3D453:  d4
b15_d454:   .db skip_wallclock                     ; 3D454:  89
b15_d455:   .db $ff                     ; 3D455:  ff
b15_d456:   .db $cf                     ; 3D456:  cf
b15_d457:   rti                         ; 3D457:  40
b15_d458:   .db $cf                     ; 3D458:  cf
b15_d459:   rts                         ; 3D459:  60
b15_d45a:   sbc #$9d                    ; 3D45A:  e9 9d
b15_d45c:   .db $d2                     ; 3D45C:  d2
b15_d45d:   .db vm_sp_lo                     ; 3D45D:  02
b15_d45e:   eor ($22,x)                 ; 3D45E:  41 22
b15_d460:   .db vm_sp_lo                     ; 3D460:  02
b15_d461:   cld                         ; 3D461:  d8
b15_d462:   .db $27                     ; 3D462:  27
b15_d463:   .db $d4                     ; 3D463:  d4
b15_d464:   rti                         ; 3D464:  40
b15_d465:   .db $23                     ; 3D465:  23
b15_d466:   dec prg_bank_shadow,x                   ; 3D466:  d6 73
b15_d468:   cmp $de,x                   ; 3D468:  d5 de
b15_d46a:   .db $f4                     ; 3D46A:  f4
b15_d46b:   .db $ff                     ; 3D46B:  ff
b15_d46c:   .db $b3                     ; 3D46C:  b3
b15_d46d:   .db vm_fp_lo                     ; 3D46D:  04
b15_d46e:   .db $d2                     ; 3D46E:  d2
b15_d46f:   ldy $bb,x                   ; 3D46F:  b4 bb
b15_d471:   .db $b3                     ; 3D471:  b3
b15_d472:   bcs $d444                   ; 3D472:  b0 d0
b15_d474:   lda ($5a),y                 ; 3D474:  b1 5a
b15_d476:   cmp #$d8                    ; 3D476:  c9 d8
b15_d478:   sta $d4                     ; 3D478:  85 d4
b15_d47a:   dec $fff4,x                 ; 3D47A:  de f4 ff
b15_d47d:   .db $b3                     ; 3D47D:  b3
b15_d47e:   .db vm_fp_lo                     ; 3D47E:  04
b15_d47f:   .db $d2                     ; 3D47F:  d2
b15_d480:   ldy $bb,x                   ; 3D480:  b4 bb
b15_d482:   .db $b3                     ; 3D482:  b3
b15_d483:   rti                         ; 3D483:  40
b15_d484:   lda ($de),y                 ; 3D484:  b1 de
b15_d486:   .db $f4                     ; 3D486:  f4
b15_d487:   .db $ff                     ; 3D487:  ff
b15_d488:   .db $b3                     ; 3D488:  b3
b15_d489:   .db vm_fp_lo                     ; 3D489:  04
b15_d48a:   .db $d2                     ; 3D48A:  d2
b15_d48b:   ldy $bb,x                   ; 3D48B:  b4 bb
b15_d48d:   bcs $d442                   ; 3D48D:  b0 b3
b15_d48f:   stx $f6a1                   ; 3D48F:  8e a1 f6
b15_d492:   sbc #$34                    ; 3D492:  e9 34
b15_d494:   cmp (vm_fp_lo),y                 ; 3D494:  d1 04
b15_d496:   ldy $cd                     ; 3D496:  a4 cd
b15_d498:   .db $7f                     ; 3D498:  7f
b15_d499:   cmp ($a8),y                 ; 3D499:  d1 a8
b15_d49b:   cmp $607f                   ; 3D49B:  cd 7f 60
b15_d49e:   sbc #$9d                    ; 3D49E:  e9 9d
b15_d4a0:   .db $d2                     ; 3D4A0:  d2
b15_d4a1:   .db vm_sp_lo                     ; 3D4A1:  02
b15_d4a2:   .db $62                     ; 3D4A2:  62
b15_d4a3:   sbc #$3e                    ; 3D4A3:  e9 3e
b15_d4a5:   .db $d7                     ; 3D4A5:  d7
b15_d4a6:   .db vm_sp_lo                     ; 3D4A6:  02
b15_d4a7:   adc ($e9,x)                 ; 3D4A7:  61 e9
b15_d4a9:   sta $02d2,x                 ; 3D4A9:  9d d2 02
b15_d4ac:   dec $60,x                   ; 3D4AC:  d6 60
b15_d4ae:   .db $d4                     ; 3D4AE:  d4
b15_d4af:   dec $fff4,x                 ; 3D4AF:  de f4 ff
b15_d4b2:   .db $b3                     ; 3D4B2:  b3
b15_d4b3:   .db vm_fp_lo                     ; 3D4B3:  04
b15_d4b4:   .db $d2                     ; 3D4B4:  d2
b15_d4b5:   ldy $bb,x                   ; 3D4B5:  b4 bb
b15_d4b7:   .db $b3                     ; 3D4B7:  b3
b15_d4b8:   bcs $d48b                   ; 3D4B8:  b0 d1
b15_d4ba:   lda ($5a),y                 ; 3D4BA:  b1 5a
b15_d4bc:   cmp #$d8                    ; 3D4BC:  c9 d8
b15_d4be:   .db $cb                     ; 3D4BE:  cb
b15_d4bf:   .db $d4                     ; 3D4BF:  d4
b15_d4c0:   dec $fff4,x                 ; 3D4C0:  de f4 ff
b15_d4c3:   .db $b3                     ; 3D4C3:  b3
b15_d4c4:   .db vm_fp_lo                     ; 3D4C4:  04
b15_d4c5:   .db $d2                     ; 3D4C5:  d2
b15_d4c6:   ldy $bb,x                   ; 3D4C6:  b4 bb
b15_d4c8:   .db $b3                     ; 3D4C8:  b3
b15_d4c9:   eor #$b1                    ; 3D4C9:  49 b1
b15_d4cb:   dec $fff4,x                 ; 3D4CB:  de f4 ff
b15_d4ce:   .db $b3                     ; 3D4CE:  b3
b15_d4cf:   .db vm_fp_lo                     ; 3D4CF:  04
b15_d4d0:   .db $d2                     ; 3D4D0:  d2
b15_d4d1:   ldy $bb,x                   ; 3D4D1:  b4 bb
b15_d4d3:   bcs $d488                   ; 3D4D3:  b0 b3
b15_d4d5:   stx $f6a4                   ; 3D4D5:  8e a4 f6
b15_d4d8:   dec $92,x                   ; 3D4D8:  d6 92
b15_d4da:   .db $d4                     ; 3D4DA:  d4
b15_d4db:   .db vm_fp_lo                     ; 3D4DB:  04
b15_d4dc:   cld                         ; 3D4DC:  d8
b15_d4dd:   rts                         ; 3D4DD:  60
b15_d4de:   .db $d4                     ; 3D4DE:  d4
b15_d4df:   rts                         ; 3D4DF:  60
b15_d4e0:   sbc #$9d                    ; 3D4E0:  e9 9d
b15_d4e2:   .db $d2                     ; 3D4E2:  d2
b15_d4e3:   .db vm_sp_lo                     ; 3D4E3:  02
b15_d4e4:   stx $f6a7                   ; 3D4E4:  8e a7 f6
b15_d4e7:   sbc #$c4                    ; 3D4E7:  e9 c4
b15_d4e9:   dec $4202                   ; 3D4E9:  ce 02 42
b15_d4ec:   cmp $cda4                   ; 3D4EC:  cd a4 cd
b15_d4ef:   .db $7f                     ; 3D4EF:  7f
b15_d4f0:   ldy $cda8,x                 ; 3D4F0:  bc a8 cd
b15_d4f3:   .db $7f                     ; 3D4F3:  7f
b15_d4f4:   adc ($e9,x)                 ; 3D4F4:  61 e9
b15_d4f6:   sta $02d2,x                 ; 3D4F6:  9d d2 02
b15_d4f9:   dec $fff4,x                 ; 3D4F9:  de f4 ff
b15_d4fc:   .db $b3                     ; 3D4FC:  b3
b15_d4fd:   .db vm_fp_lo                     ; 3D4FD:  04
b15_d4fe:   cmp ($24),y                 ; 3D4FE:  d1 24
b15_d500:   bne $d4d4                   ; 3D500:  d0 d2
b15_d502:   ldy $bb,x                   ; 3D502:  b4 bb
b15_d504:   .db $b3                     ; 3D504:  b3
b15_d505:   txa                         ; 3D505:  8a
b15_d506:   .db $ff                     ; 3D506:  ff
b15_d507:   brk                         ; 3D507:  00
b15_d508:   lda ($62),y                 ; 3D508:  b1 62
b15_d50a:   sbc #$3e                    ; 3D50A:  e9 3e
b15_d50c:   .db $d7                     ; 3D50C:  d7
b15_d50d:   .db vm_sp_lo                     ; 3D50D:  02
b15_d50e:   dec $60,x                   ; 3D50E:  d6 60
b15_d510:   .db $d4                     ; 3D510:  d4
b15_d511:   .db $0c                     ; 3D511:  0c
b15_d512:   cmp ($14),y                 ; 3D512:  d1 14
b15_d514:   cmp ($d8,x)                 ; 3D514:  c1 d8
b15_d516:   rts                         ; 3D516:  60
b15_d517:   .db $d4                     ; 3D517:  d4
b15_d518:   .db vm_fp_lo                     ; 3D518:  04
b15_d519:   .db $d7                     ; 3D519:  d7
b15_d51a:   plp                         ; 3D51A:  28
b15_d51b:   cmp $de,x                   ; 3D51B:  d5 de
b15_d51d:   .db $f4                     ; 3D51D:  f4
b15_d51e:   .db $ff                     ; 3D51E:  ff
b15_d51f:   .db $b3                     ; 3D51F:  b3
b15_d520:   .db vm_fp_lo                     ; 3D520:  04
b15_d521:   .db $d2                     ; 3D521:  d2
b15_d522:   ldy $bb,x                   ; 3D522:  b4 bb
b15_d524:   bcs $d4fe                   ; 3D524:  b0 d8
b15_d526:   rts                         ; 3D526:  60
b15_d527:   .db $d4                     ; 3D527:  d4
b15_d528:   rts                         ; 3D528:  60
b15_d529:   sbc #$9d                    ; 3D529:  e9 9d
b15_d52b:   .db $d2                     ; 3D52B:  d2
b15_d52c:   .db vm_sp_lo                     ; 3D52C:  02
b15_d52d:   ldy $cd                     ; 3D52D:  a4 cd
b15_d52f:   .db $7f                     ; 3D52F:  7f
b15_d530:   bne $d4da                   ; 3D530:  d0 a8
b15_d532:   cmp $de7f                   ; 3D532:  cd 7f de
b15_d535:   .db $f4                     ; 3D535:  f4
b15_d536:   .db $ff                     ; 3D536:  ff
b15_d537:   .db $b3                     ; 3D537:  b3
b15_d538:   .db vm_fp_lo                     ; 3D538:  04
b15_d539:   bne $d55f                   ; 3D539:  d0 24
b15_d53b:   .db $d2                     ; 3D53B:  d2
b15_d53c:   ldy $bb,x                   ; 3D53C:  b4 bb
b15_d53e:   .db $b3                     ; 3D53E:  b3
b15_d53f:   rti                         ; 3D53F:  40
b15_d540:   lda ($de),y                 ; 3D540:  b1 de
b15_d542:   .db $f4                     ; 3D542:  f4
b15_d543:   .db $ff                     ; 3D543:  ff
b15_d544:   .db $b3                     ; 3D544:  b3
b15_d545:   .db vm_fp_lo                     ; 3D545:  04
b15_d546:   .db $d2                     ; 3D546:  d2
b15_d547:   ldy $bb,x                   ; 3D547:  b4 bb
b15_d549:   bcs $d4fe                   ; 3D549:  b0 b3
b15_d54b:   stx $f6a9                   ; 3D54B:  8e a9 f6
b15_d54e:   sbc #$34                    ; 3D54E:  e9 34
b15_d550:   cmp (vm_fp_lo),y                 ; 3D550:  d1 04
b15_d552:   ldy $cd                     ; 3D552:  a4 cd
b15_d554:   .db $7f                     ; 3D554:  7f
b15_d555:   cmp ($a8),y                 ; 3D555:  d1 a8
b15_d557:   cmp $617f                   ; 3D557:  cd 7f 61
b15_d55a:   sbc #$9d                    ; 3D55A:  e9 9d
b15_d55c:   .db $d2                     ; 3D55C:  d2
b15_d55d:   .db vm_sp_lo                     ; 3D55D:  02
b15_d55e:   dec $09,x                   ; 3D55E:  d6 09
b15_d560:   cmp $de,x                   ; 3D560:  d5 de
b15_d562:   .db $f4                     ; 3D562:  f4
b15_d563:   .db $ff                     ; 3D563:  ff
b15_d564:   .db $b3                     ; 3D564:  b3
b15_d565:   ora $d2                     ; 3D565:  05 d2
b15_d567:   ldy $bb,x                   ; 3D567:  b4 bb
b15_d569:   bcs $d51e                   ; 3D569:  b0 b3
b15_d56b:   .db vm_sp_hi                     ; 3D56B:  03
b15_d56c:   .db $5a                     ; 3D56C:  5a
b15_d56d:   lda $b4,x                   ; 3D56D:  b5 b4
b15_d56f:   .db $bb                     ; 3D56F:  bb
b15_d570:   .db $23                     ; 3D570:  23
b15_d571:   ora $d0                     ; 3D571:  05 d0
b15_d573:   and $de                     ; 3D573:  25 de
b15_d575:   .db $f4                     ; 3D575:  f4
b15_d576:   .db $ff                     ; 3D576:  ff
b15_d577:   .db $b3                     ; 3D577:  b3
b15_d578:   ora $d2                     ; 3D578:  05 d2
b15_d57a:   ldy $bb,x                   ; 3D57A:  b4 bb
b15_d57c:   bcs $d50a                   ; 3D57C:  b0 8c
b15_d57e:   .db $ff                     ; 3D57E:  ff
b15_d57f:   brk                         ; 3D57F:  00
b15_d580:   cmp ($d7,x)                 ; 3D580:  c1 d7
b15_d582:   adc ($d5,x)                 ; 3D582:  61 d5
b15_d584:   .db vm_sp_hi                     ; 3D584:  03
b15_d585:   .db $cf                     ; 3D585:  cf
count_decimal_digits:   jsr $e823                   ; 3D586:  20 23 e8
b15_d589:   inc $40ff,x                 ; 3D589:  fe ff 40
b15_d58c:   dec $96,x                   ; 3D58C:  d6 96
b15_d58e:   cmp $4a,x                   ; 3D58E:  d5 4a
b15_d590:   cmp $b60c                   ; 3D590:  cd 0c b6
b15_d593:   bit $d00b                   ; 3D593:  2c 0b d0
b15_d596:   .db $2b                     ; 3D596:  2b
b15_d597:   .db $0c                     ; 3D597:  0c
b15_d598:   .db $d7                     ; 3D598:  d7
b15_d599:   .db $8f                     ; 3D599:  8f
b15_d59a:   cmp $0b,x                   ; 3D59A:  d5 0b
b15_d59c:   .db $cf                     ; 3D59C:  cf
select_province_by_cursor:   jsr $e823                   ; 3D59D:  20 23 e8
b15_d5a0:   inc $ff,x                   ; 3D5A0:  f6 ff
b15_d5a2:   and $86e9,x                 ; 3D5A2:  3d e9 86
b15_d5a5:   cmp vm_sp_lo,x                   ; 3D5A5:  d5 02
b15_d5a7:   .db $2b                     ; 3D5A7:  2b
b15_d5a8:   ldy $cd                     ; 3D5A8:  a4 cd
b15_d5aa:   .db $7f                     ; 3D5AA:  7f
b15_d5ab:   and #$a4                    ; 3D5AB:  29 a4
b15_d5ad:   .db $cf                     ; 3D5AD:  cf
b15_d5ae:   .db $7f                     ; 3D5AE:  7f
b15_d5af:   plp                         ; 3D5AF:  28
b15_d5b0:   sec                         ; 3D5B0:  38
b15_d5b1:   and $7be9,y                 ; 3D5B1:  39 e9 7b
b15_d5b4:   cpy $4004                   ; 3D5B4:  cc 04 40
b15_d5b7:   dec $c2,x                   ; 3D5B7:  d6 c2
b15_d5b9:   cmp $8d,x                   ; 3D5B9:  d5 8d
b15_d5bb:   jsr $81e9                   ; 3D5BB:  20 e9 81
b15_d5be:   dec $0a02                   ; 3D5BE:  ce 02 0a
b15_d5c1:   bne $d5ed                   ; 3D5C1:  d0 2a
b15_d5c3:   asl a                       ; 3D5C3:  0a
b15_d5c4:   .db $1b                     ; 3D5C4:  1b
b15_d5c5:   .db $c2                     ; 3D5C5:  c2
b15_d5c6:   .db $d7                     ; 3D5C6:  d7
b15_d5c7:   tsx                         ; 3D5C7:  ba
b15_d5c8:   cmp $38,x                   ; 3D5C8:  d5 38
b15_d5ca:   and $7be9,y                 ; 3D5CA:  39 e9 7b
b15_d5cd:   cpy $3b04                   ; 3D5CD:  cc 04 3b
b15_d5d0:   sbc #$ed                    ; 3D5D0:  e9 ed
b15_d5d2:   .db $d3                     ; 3D5D2:  d3
b15_d5d3:   .db vm_sp_lo                     ; 3D5D3:  02
b15_d5d4:   .db $27                     ; 3D5D4:  27
b15_d5d5:   .db vm_ip_hi                     ; 3D5D5:  07
b15_d5d6:   bvc $d59b                   ; 3D5D6:  50 c3
b15_d5d8:   .db $d7                     ; 3D5D8:  d7
b15_d5d9:   .db $e7                     ; 3D5D9:  e7
b15_d5da:   cmp vm_ip_hi,x                   ; 3D5DA:  d5 07
b15_d5dc:   .db ppu_queue_a_lo                     ; 3D5DC:  1c
b15_d5dd:   cmp $d8                     ; 3D5DD:  c5 d8
b15_d5df:   bcs $d5b6                   ; 3D5DF:  b0 d5
b15_d5e1:   .db vm_ip_hi                     ; 3D5E1:  07
b15_d5e2:   ora $d8c3,x                 ; 3D5E2:  1d c3 d8
b15_d5e5:   bcs $d5bc                   ; 3D5E5:  b0 d5
b15_d5e7:   .db vm_ip_hi                     ; 3D5E7:  07
b15_d5e8:   .db $cf                     ; 3D5E8:  cf
number_input:   jsr $e823                   ; 3D5E9:  20 23 e8
b15_d5ec:   inc $3dff,x                 ; 3D5EC:  fe ff 3d
b15_d5ef:   .db $3c                     ; 3D5EF:  3c
b15_d5f0:   stx $f6ac                   ; 3D5F0:  8e ac f6
b15_d5f3:   sbc #$34                    ; 3D5F3:  e9 34
b15_d5f5:   cmp (vm_ip_lo),y                 ; 3D5F5:  d1 06
b15_d5f7:   and $e93c,x                 ; 3D5F7:  3d 3c e9
b15_d5fa:   sta $04d5,x                 ; 3D5FA:  9d d5 04
b15_d5fd:   .db $2b                     ; 3D5FD:  2b
b15_d5fe:   .db $0b                     ; 3D5FE:  0b
b15_d5ff:   bvc $d5c5                   ; 3D5FF:  50 c4
b15_d601:   cld                         ; 3D601:  d8
b15_d602:   .db vm_ip_hi                     ; 3D602:  07
b15_d603:   dec $ac,x                   ; 3D603:  d6 ac
b15_d605:   .db skip_wallclock                     ; 3D605:  89
b15_d606:   cpy $cf0b                   ; 3D606:  cc 0b cf
ui_prompt_redraw:   jsr $e823                   ; 3D609:  20 23 e8
b15_d60c:   inc $8dff,x                 ; 3D60C:  fe ff 8d
b15_d60f:   .db $1a                     ; 3D60F:  1a
b15_d610:   .db $62                     ; 3D610:  62
b15_d611:   sbc #$7b                    ; 3D611:  e9 7b
b15_d613:   cpy $8e04                   ; 3D613:  cc 04 8e
b15_d616:   .db $b7                     ; 3D616:  b7
b15_d617:   inc $e9,x                   ; 3D617:  f6 e9
b15_d619:   cpy $ce                     ; 3D619:  c4 ce
b15_d61b:   .db vm_sp_lo                     ; 3D61B:  02
b15_d61c:   ldy $d287                   ; 3D61C:  ac 87 d2
b15_d61f:   .db $2b                     ; 3D61F:  2b
b15_d620:   ldy $cc89                   ; 3D620:  ac 89 cc
b15_d623:   ldy $cce1                   ; 3D623:  ac e1 cc
b15_d626:   .db $0b                     ; 3D626:  0b
b15_d627:   .db $cf                     ; 3D627:  cf
count_6da2_set:   jsr $e823                   ; 3D628:  20 23 e8
b15_d62b:   .db $fc                     ; 3D62B:  fc
b15_d62c:   .db $ff                     ; 3D62C:  ff
b15_d62d:   rti                         ; 3D62D:  40
b15_d62e:   rol a                       ; 3D62E:  2a
b15_d62f:   .db $2b                     ; 3D62F:  2b
b15_d630:   dec $4e,x                   ; 3D630:  d6 4e
b15_d632:   dec $0a,x                   ; 3D632:  d6 0a
b15_d634:   sty fief_is_daimyo_capital                   ; 3D634:  8c a2 6d
b15_d637:   .db $bb                     ; 3D637:  bb
b15_d638:   .db $d3                     ; 3D638:  d3
b15_d639:   .db $d7                     ; 3D639:  d7
b15_d63a:   pha                         ; 3D63A:  48
b15_d63b:   dec $3a,x                   ; 3D63B:  d6 3a
b15_d63d:   sbc #$8d                    ; 3D63D:  e9 8d
b15_d63f:   cmp $8c02,y                 ; 3D63F:  d9 02 8c
b15_d642:   .db $ff                     ; 3D642:  ff
b15_d643:   brk                         ; 3D643:  00
b15_d644:   cpy #$d8                    ; 3D644:  c0 d8
b15_d646:   .db $4b                     ; 3D646:  4b
b15_d647:   dec $0b,x                   ; 3D647:  d6 0b
b15_d649:   bne $d676                   ; 3D649:  d0 2b
b15_d64b:   asl a                       ; 3D64B:  0a
b15_d64c:   bne $d678                   ; 3D64C:  d0 2a
b15_d64e:   asl a                       ; 3D64E:  0a
b15_d64f:   ldx $9d                     ; 3D64F:  a6 9d
b15_d651:   adc $d7c6                   ; 3D651:  6d c6 d7
b15_d654:   .db $33                     ; 3D654:  33
b15_d655:   dec $0b,x                   ; 3D655:  d6 0b
b15_d657:   eor ($c0),y                 ; 3D657:  51 c0
b15_d659:   cld                         ; 3D659:  d8
b15_d65a:   .db $6b                     ; 3D65A:  6b
b15_d65b:   dec $ac,x                   ; 3D65B:  d6 ac
b15_d65d:   .db $82                     ; 3D65D:  82
b15_d65e:   cmp $66d8,y                 ; 3D65E:  d9 d8 66
b15_d661:   dec $40,x                   ; 3D661:  d6 40
b15_d663:   dec brk_scratch_hi,x                   ; 3D663:  d6 67
b15_d665:   dec $41,x                   ; 3D665:  d6 41
b15_d667:   cmp $da0b                   ; 3D667:  cd 0b da
b15_d66a:   .db $2b                     ; 3D66A:  2b
b15_d66b:   .db $0b                     ; 3D66B:  0b
b15_d66c:   eor ($c1),y                 ; 3D66C:  51 c1
b15_d66e:   cld                         ; 3D66E:  d8
b15_d66f:   adc $d6,x                   ; 3D66F:  75 d6
b15_d671:   rti                         ; 3D671:  40
b15_d672:   dec mul_acc_hi,x                   ; 3D672:  d6 76
b15_d674:   dec $41,x                   ; 3D674:  d6 41
b15_d676:   .db $cf                     ; 3D676:  cf
draw_current_year:   jsr $e823                   ; 3D677:  20 23 e8
b15_d67a:   brk                         ; 3D67A:  00
b15_d67b:   brk                         ; 3D67B:  00
b15_d67c:   tax                         ; 3D67C:  aa
b15_d67d:   .db $9f                     ; 3D67D:  9f
b15_d67e:   adc $c48e                   ; 3D67E:  6d 8e c4
b15_d681:   inc $e9,x                   ; 3D681:  f6 e9
b15_d683:   .db $34                     ; 3D683:  34
b15_d684:   cmp (vm_fp_lo),y                 ; 3D684:  d1 04
b15_d686:   .db $cf                     ; 3D686:  cf
draw_current_season:   jsr $e823                   ; 3D687:  20 23 e8
b15_d68a:   brk                         ; 3D68A:  00
b15_d68b:   brk                         ; 3D68B:  00
b15_d68c:   ldy $5f                     ; 3D68C:  a4 5f
b15_d68e:   adc $00d5                   ; 3D68E:  6d d5 00
b15_d691:   brk                         ; 3D691:  00
b15_d692:   .db vm_fp_lo                     ; 3D692:  04
b15_d693:   brk                         ; 3D693:  00
b15_d694:   lda $d6                     ; 3D694:  a5 d6
b15_d696:   .db $9e                     ; 3D696:  9e
b15_d697:   dec $a6,x                   ; 3D697:  d6 a6
b15_d699:   dec $ac,x                   ; 3D699:  d6 ac
b15_d69b:   dec $b2,x                   ; 3D69B:  d6 b2
b15_d69d:   dec $8e,x                   ; 3D69D:  d6 8e
b15_d69f:   .db $c7                     ; 3D69F:  c7
b15_d6a0:   inc $e9,x                   ; 3D6A0:  f6 e9
b15_d6a2:   cpy $ce                     ; 3D6A2:  c4 ce
b15_d6a4:   .db vm_sp_lo                     ; 3D6A4:  02
b15_d6a5:   .db $cf                     ; 3D6A5:  cf
b15_d6a6:   stx $f6ce                   ; 3D6A6:  8e ce f6
b15_d6a9:   dec $a1,x                   ; 3D6A9:  d6 a1
b15_d6ab:   dec $8e,x                   ; 3D6AB:  d6 8e
b15_d6ad:   cmp $f6,x                   ; 3D6AD:  d5 f6
b15_d6af:   dec $a1,x                   ; 3D6AF:  d6 a1
b15_d6b1:   dec $8e,x                   ; 3D6B1:  d6 8e
b15_d6b3:   .db $da                     ; 3D6B3:  da
b15_d6b4:   inc $d6,x                   ; 3D6B4:  f6 d6
b15_d6b6:   lda ($d6,x)                 ; 3D6B6:  a1 d6
math32_3arg:   jsr $e823                   ; 3D6B8:  20 23 e8
b15_d6bb:   brk                         ; 3D6BB:  00
b15_d6bc:   brk                         ; 3D6BC:  00
b15_d6bd:   asl $dbd8                   ; 3D6BD:  0e d8 db
b15_d6c0:   dec $0e,x                   ; 3D6C0:  d6 0e
b15_d6c2:   .db $b7                     ; 3D6C2:  b7
b15_d6c3:   and $b7                     ; 3D6C3:  25 b7
b15_d6c5:   .db $14                     ; 3D6C5:  14
b15_d6c6:   ora $25b7                   ; 3D6C6:  0d b7 25
b15_d6c9:   .db $b7                     ; 3D6C9:  b7
b15_d6ca:   .db $14                     ; 3D6CA:  14
b15_d6cb:   .db $0c                     ; 3D6CB:  0c
b15_d6cc:   .db $b7                     ; 3D6CC:  b7
b15_d6cd:   and $b7                     ; 3D6CD:  25 b7
b15_d6cf:   ora $b7,x                   ; 3D6CF:  15 b7
b15_d6d1:   ora ($b7,x)                 ; 3D6D1:  01 b7
b15_d6d3:   ora $b7,x                   ; 3D6D3:  15 b7
b15_d6d5:   .db vm_sp_lo                     ; 3D6D5:  02
b15_d6d6:   .db $b7                     ; 3D6D6:  b7
b15_d6d7:   .db $27                     ; 3D6D7:  27
b15_d6d8:   dec $dd,x                   ; 3D6D8:  d6 dd
b15_d6da:   dec skip_wallclock,x                   ; 3D6DA:  d6 89
b15_d6dc:   .db $ff                     ; 3D6DC:  ff
b15_d6dd:   .db $cf                     ; 3D6DD:  cf
math32_2arg:   jsr $e823                   ; 3D6DE:  20 23 e8
b15_d6e1:   brk                         ; 3D6E1:  00
b15_d6e2:   brk                         ; 3D6E2:  00
b15_d6e3:   .db $0c                     ; 3D6E3:  0c
b15_d6e4:   .db $d7                     ; 3D6E4:  d7
b15_d6e5:   sbc $0dd6                   ; 3D6E5:  ed d6 0d
b15_d6e8:   .db $d7                     ; 3D6E8:  d7
b15_d6e9:   sbc $40d6                   ; 3D6E9:  ed d6 40
b15_d6ec:   .db $cf                     ; 3D6EC:  cf
b15_d6ed:   ora $26b7                   ; 3D6ED:  0d b7 26
b15_d6f0:   .db $b7                     ; 3D6F0:  b7
b15_d6f1:   .db $14                     ; 3D6F1:  14
b15_d6f2:   .db $0c                     ; 3D6F2:  0c
b15_d6f3:   .db $b7                     ; 3D6F3:  b7
b15_d6f4:   rol $b7                     ; 3D6F4:  26 b7
b15_d6f6:   ora $b7,x                   ; 3D6F6:  15 b7
b15_d6f8:   .db vm_sp_hi                     ; 3D6F8:  03
b15_d6f9:   .db $b7                     ; 3D6F9:  b7
b15_d6fa:   .db $14                     ; 3D6FA:  14
b15_d6fb:   .db $0c                     ; 3D6FB:  0c
b15_d6fc:   .db $b7                     ; 3D6FC:  b7
b15_d6fd:   rol $b7                     ; 3D6FD:  26 b7
b15_d6ff:   ora $0064,y                 ; 3D6FF:  19 64 00
b15_d702:   brk                         ; 3D702:  00
b15_d703:   brk                         ; 3D703:  00
b15_d704:   .db $b7                     ; 3D704:  b7
b15_d705:   ora ($b7,x)                 ; 3D705:  01 b7
b15_d707:   ora $b7,x                   ; 3D707:  15 b7
b15_d709:   .db vm_sp_lo                     ; 3D709:  02
b15_d70a:   .db $b7                     ; 3D70A:  b7
b15_d70b:   .db $27                     ; 3D70B:  27
b15_d70c:   .db $cf                     ; 3D70C:  cf
pct_op:   jsr $e823                   ; 3D70D:  20 23 e8
b15_d710:   brk                         ; 3D710:  00
b15_d711:   brk                         ; 3D711:  00
b15_d712:   ora $648b                   ; 3D712:  0d 8b 64
b15_d715:   cpy #$d8                    ; 3D715:  c0 d8
b15_d717:   .db $1b                     ; 3D717:  1b
b15_d718:   .db $d7                     ; 3D718:  d7
b15_d719:   .db $0c                     ; 3D719:  0c
b15_d71a:   .db $cf                     ; 3D71A:  cf
b15_d71b:   .db $0c                     ; 3D71B:  0c
b15_d71c:   .db $5a                     ; 3D71C:  5a
b15_d71d:   ldx $b3,y                   ; 3D71D:  b6 b3
b15_d71f:   ora $b65a                   ; 3D71F:  0d 5a b6
b15_d722:   ldy $b5,x                   ; 3D722:  b4 b5
b15_d724:   .db $b3                     ; 3D724:  b3
b15_d725:   .db $0c                     ; 3D725:  0c
b15_d726:   .db $5a                     ; 3D726:  5a
b15_d727:   lda $b51d,y                 ; 3D727:  b9 1d b5
b15_d72a:   .db $8b                     ; 3D72A:  8b
b15_d72b:   .db $64                     ; 3D72B:  64
b15_d72c:   ldx $b3,y                   ; 3D72C:  b6 b3
b15_d72e:   .db $0c                     ; 3D72E:  0c
b15_d72f:   .db $5a                     ; 3D72F:  5a
b15_d730:   ldx $b3,y                   ; 3D730:  b6 b3
b15_d732:   ora $b95a                   ; 3D732:  0d 5a b9
b15_d735:   ldy $b5,x                   ; 3D735:  b4 b5
b15_d737:   .db $5a                     ; 3D737:  5a
b15_d738:   ldx $b4,y                   ; 3D738:  b6 b4
b15_d73a:   .db $bb                     ; 3D73A:  bb
b15_d73b:   ldy $bb,x                   ; 3D73B:  b4 bb
b15_d73d:   .db $cf                     ; 3D73D:  cf
delay_loop:   jsr $e823                   ; 3D73E:  20 23 e8
b15_d741:   inc $d6ff,x                 ; 3D741:  fe ff d6
b15_d744:   eor ($d7),y                 ; 3D744:  51 d7
b15_d746:   txa                         ; 3D746:  8a
b15_d747:   beq $d749                   ; 3D747:  f0 00
b15_d749:   .db $2b                     ; 3D749:  2b
b15_d74a:   .db $0b                     ; 3D74A:  0b
b15_d74b:   cmp ($2b),y                 ; 3D74B:  d1 2b
b15_d74d:   .db $0b                     ; 3D74D:  0b
b15_d74e:   .db $d7                     ; 3D74E:  d7
b15_d74f:   lsr a                       ; 3D74F:  4a
b15_d750:   .db $d7                     ; 3D750:  d7
b15_d751:   .db $0c                     ; 3D751:  0c
b15_d752:   cmp ($2c),y                 ; 3D752:  d1 2c
b15_d754:   bne $d72d                   ; 3D754:  d0 d7
b15_d756:   lsr $d7                     ; 3D756:  46 d7
b15_d758:   .db $cf                     ; 3D758:  cf
standard_delay:   jsr $e823                   ; 3D759:  20 23 e8
b15_d75c:   brk                         ; 3D75C:  00
b15_d75d:   brk                         ; 3D75D:  00
b15_d75e:   tax                         ; 3D75E:  aa
b15_d75f:   adc $6d                     ; 3D75F:  65 6d
b15_d761:   sbc #$3e                    ; 3D761:  e9 3e
b15_d763:   .db $d7                     ; 3D763:  d7
b15_d764:   .db vm_sp_lo                     ; 3D764:  02
b15_d765:   .db $cf                     ; 3D765:  cf
confirm_prompt:   jsr $e823                   ; 3D766:  20 23 e8
b15_d769:   brk                         ; 3D769:  00
b15_d76a:   brk                         ; 3D76A:  00
b15_d76b:   ldy $d759                   ; 3D76B:  ac 59 d7
b15_d76e:   ldy $cc89                   ; 3D76E:  ac 89 cc
b15_d771:   .db $cf                     ; 3D771:  cf
fief_owner:   jsr $e823                   ; 3D772:  20 23 e8
b15_d775:   brk                         ; 3D775:  00
b15_d776:   brk                         ; 3D776:  00
b15_d777:   .db $0c                     ; 3D777:  0c
b15_d778:   sty fief_to_daimyo_map                   ; 3D778:  8c 15 6e
b15_d77b:   .db $bb                     ; 3D77B:  bb
b15_d77c:   .db $d3                     ; 3D77C:  d3
b15_d77d:   .db $cf                     ; 3D77D:  cf
selected_province_owner:   jsr $e823                   ; 3D77E:  20 23 e8
b15_d781:   brk                         ; 3D781:  00
b15_d782:   brk                         ; 3D782:  00
b15_d783:   tax                         ; 3D783:  aa
b15_d784:   .db $5f                     ; 3D784:  5f
b15_d785:   .db p2_buttons                     ; 3D785:  6f
b15_d786:   sbc #$72                    ; 3D786:  e9 72
b15_d788:   .db $d7                     ; 3D788:  d7
b15_d789:   .db vm_sp_lo                     ; 3D789:  02
b15_d78a:   .db $cf                     ; 3D78A:  cf
daimyo_name_width:   jsr $e823                   ; 3D78B:  20 23 e8
b15_d78e:   inc $8eff,x                 ; 3D78E:  fe ff 8e
b15_d791:   sbc ($f6,x)                 ; 3D791:  e1 f6
b15_d793:   sbc #$c4                    ; 3D793:  e9 c4
b15_d795:   dec $3c02                   ; 3D795:  ce 02 3c
b15_d798:   sbc #$72                    ; 3D798:  e9 72
b15_d79a:   .db $d7                     ; 3D79A:  d7
b15_d79b:   .db vm_sp_lo                     ; 3D79B:  02
b15_d79c:   eor $8cb5,y                 ; 3D79C:  59 b5 8c
b15_d79f:   tay                         ; 3D79F:  a8
b15_d7a0:   .db $77                     ; 3D7A0:  77
b15_d7a1:   .db $bb                     ; 3D7A1:  bb
b15_d7a2:   .db $2b                     ; 3D7A2:  2b
b15_d7a3:   .db $b3                     ; 3D7A3:  b3
b15_d7a4:   sbc #$c4                    ; 3D7A4:  e9 c4
b15_d7a6:   dec $8d02                   ; 3D7A6:  ce 02 8d
b15_d7a9:   bit $81e9                   ; 3D7A9:  2c e9 81
b15_d7ac:   dec $cf02                   ; 3D7AC:  ce 02 cf
draw_daimyo_name:   jsr $e823                   ; 3D7AF:  20 23 e8
b15_d7b2:   inc $8eff,x                 ; 3D7B2:  fe ff 8e
b15_d7b5:   .db $e7                     ; 3D7B5:  e7
b15_d7b6:   inc $e9,x                   ; 3D7B6:  f6 e9
b15_d7b8:   cpy $ce                     ; 3D7B8:  c4 ce
b15_d7ba:   .db vm_sp_lo                     ; 3D7BA:  02
b15_d7bb:   .db $3c                     ; 3D7BB:  3c
b15_d7bc:   sbc #$72                    ; 3D7BC:  e9 72
b15_d7be:   .db $d7                     ; 3D7BE:  d7
b15_d7bf:   .db vm_sp_lo                     ; 3D7BF:  02
b15_d7c0:   eor $8cb5,y                 ; 3D7C0:  59 b5 8c
b15_d7c3:   tay                         ; 3D7C3:  a8
b15_d7c4:   .db $77                     ; 3D7C4:  77
b15_d7c5:   .db $bb                     ; 3D7C5:  bb
b15_d7c6:   .db $2b                     ; 3D7C6:  2b
b15_d7c7:   .db $b3                     ; 3D7C7:  b3
b15_d7c8:   sbc #$c4                    ; 3D7C8:  e9 c4
b15_d7ca:   dec $cf02                   ; 3D7CA:  ce 02 cf
daimyo_record_addr:   jsr $e823                   ; 3D7CD:  20 23 e8
b15_d7d0:   brk                         ; 3D7D0:  00
b15_d7d1:   brk                         ; 3D7D1:  00
b15_d7d2:   .db $0c                     ; 3D7D2:  0c
b15_d7d3:   .db $57                     ; 3D7D3:  57
b15_d7d4:   lda $8c,x                   ; 3D7D4:  b5 8c
b15_d7d6:   .db $2f                     ; 3D7D6:  2f
b15_d7d7:   adc $bb,x                   ; 3D7D7:  75 bb
b15_d7d9:   .db $cf                     ; 3D7D9:  cf
fief_to_daimyo_record_addr:   jsr $e823                   ; 3D7DA:  20 23 e8
b15_d7dd:   brk                         ; 3D7DD:  00
b15_d7de:   brk                         ; 3D7DE:  00
b15_d7df:   .db $3c                     ; 3D7DF:  3c
b15_d7e0:   sbc #$72                    ; 3D7E0:  e9 72
b15_d7e2:   .db $d7                     ; 3D7E2:  d7
b15_d7e3:   .db vm_sp_lo                     ; 3D7E3:  02
b15_d7e4:   .db $b3                     ; 3D7E4:  b3
b15_d7e5:   sbc #$cd                    ; 3D7E5:  e9 cd
b15_d7e7:   .db $d7                     ; 3D7E7:  d7
b15_d7e8:   .db vm_sp_lo                     ; 3D7E8:  02
b15_d7e9:   .db $cf                     ; 3D7E9:  cf
selected_province_daimyo_record:   jsr $e823                   ; 3D7EA:  20 23 e8
b15_d7ed:   brk                         ; 3D7ED:  00
b15_d7ee:   brk                         ; 3D7EE:  00
b15_d7ef:   tax                         ; 3D7EF:  aa
b15_d7f0:   .db $5f                     ; 3D7F0:  5f
b15_d7f1:   .db p2_buttons                     ; 3D7F1:  6f
b15_d7f2:   sbc #$da                    ; 3D7F2:  e9 da
b15_d7f4:   .db $d7                     ; 3D7F4:  d7
b15_d7f5:   .db vm_sp_lo                     ; 3D7F5:  02
b15_d7f6:   .db $cf                     ; 3D7F6:  cf
clear_econ_stats_if_no_output:   jsr $e823                   ; 3D7F7:  20 23 e8
b15_d7fa:   inc $0cff,x                 ; 3D7FA:  fe ff 0c
b15_d7fd:   .db $8b                     ; 3D7FD:  8b
b15_d7fe:   .db $1a                     ; 3D7FE:  1a
b15_d7ff:   lda $8c,x                   ; 3D7FF:  b5 8c
b15_d801:   ora ($70,x)                 ; 3D801:  01 70
b15_d803:   .db $bb                     ; 3D803:  bb
b15_d804:   .db $2b                     ; 3D804:  2b
b15_d805:   .db $0b                     ; 3D805:  0b
b15_d806:   sei                         ; 3D806:  78
b15_d807:   bcs $d7e0                   ; 3D807:  b0 d7
b15_d809:   .db $14                     ; 3D809:  14
b15_d80a:   cld                         ; 3D80A:  d8
b15_d80b:   .db $0b                     ; 3D80B:  0b
b15_d80c:   .db $7c                     ; 3D80C:  7c
b15_d80d:   .db $b3                     ; 3D80D:  b3
b15_d80e:   .db $0b                     ; 3D80E:  0b
b15_d80f:   ror $40b3,x                 ; 3D80F:  7e b3 40
b15_d812:   lda ($b1),y                 ; 3D812:  b1 b1
b15_d814:   .db $cf                     ; 3D814:  cf
clear_military_stats_if_no_men:   jsr $e823                   ; 3D815:  20 23 e8
b15_d818:   .db $fc                     ; 3D818:  fc
b15_d819:   .db $ff                     ; 3D819:  ff
b15_d81a:   .db $0c                     ; 3D81A:  0c
b15_d81b:   .db $8b                     ; 3D81B:  8b
b15_d81c:   .db $1a                     ; 3D81C:  1a
b15_d81d:   lda $8c,x                   ; 3D81D:  b5 8c
b15_d81f:   ora ($70),y                 ; 3D81F:  11 70
b15_d821:   .db $bb                     ; 3D821:  bb
b15_d822:   .db $2b                     ; 3D822:  2b
b15_d823:   .db $0b                     ; 3D823:  0b
b15_d824:   bcs $d7fd                   ; 3D824:  b0 d7
b15_d826:   and $d8,x                   ; 3D826:  35 d8
b15_d828:   .db $0b                     ; 3D828:  0b
b15_d829:   .db ppumask_shadow                     ; 3D829:  72
b15_d82a:   .db $b3                     ; 3D82A:  b3
b15_d82b:   .db $0b                     ; 3D82B:  0b
b15_d82c:   .db palette_dirty                     ; 3D82C:  74
b15_d82d:   .db $b3                     ; 3D82D:  b3
b15_d82e:   .db $0b                     ; 3D82E:  0b
b15_d82f:   ror $b3,x                   ; 3D82F:  76 b3
b15_d831:   rti                         ; 3D831:  40
b15_d832:   lda ($b1),y                 ; 3D832:  b1 b1
b15_d834:   lda ($cf),y                 ; 3D834:  b1 cf
cap_fief_stats:   jsr $e823                   ; 3D836:  20 23 e8
b15_d839:   .db $f4                     ; 3D839:  f4
b15_d83a:   .db $ff                     ; 3D83A:  ff
b15_d83b:   .db $0c                     ; 3D83B:  0c
b15_d83c:   .db $8b                     ; 3D83C:  8b
b15_d83d:   .db $1a                     ; 3D83D:  1a
b15_d83e:   lda $8c,x                   ; 3D83E:  b5 8c
b15_d840:   ora ($70,x)                 ; 3D840:  01 70
b15_d842:   .db $bb                     ; 3D842:  bb
b15_d843:   .db $27                     ; 3D843:  27
b15_d844:   .db vm_ip_hi                     ; 3D844:  07
b15_d845:   rol a                       ; 3D845:  2a
b15_d846:   dec $63,x                   ; 3D846:  d6 63
b15_d848:   cld                         ; 3D848:  d8
b15_d849:   .db $3b                     ; 3D849:  3b
b15_d84a:   .db vm_ip_hi                     ; 3D84A:  07
b15_d84b:   .db $8f                     ; 3D84B:  8f
b15_d84c:   clc                         ; 3D84C:  18
b15_d84d:   bcs $d802                   ; 3D84D:  b0 b3
b15_d84f:   .db $0b                     ; 3D84F:  0b
b15_d850:   bcs $d805                   ; 3D850:  b0 b3
b15_d852:   sbc #$5e                    ; 3D852:  e9 5e
b15_d854:   .db $cb                     ; 3D854:  cb
b15_d855:   .db vm_fp_lo                     ; 3D855:  04
b15_d856:   lda ($0b),y                 ; 3D856:  b1 0b
b15_d858:   bcs $d8aa                   ; 3D858:  b0 50
b15_d85a:   .db $c2                     ; 3D85A:  c2
b15_d85b:   cld                         ; 3D85B:  d8
b15_d85c:   adc ($d8,x)                 ; 3D85C:  61 d8
b15_d85e:   .db $3b                     ; 3D85E:  3b
b15_d85f:   rti                         ; 3D85F:  40
b15_d860:   lda ($0b),y                 ; 3D860:  b1 0b
b15_d862:   .db ppumask_shadow                     ; 3D862:  72
b15_d863:   .db $2b                     ; 3D863:  2b
b15_d864:   asl a                       ; 3D864:  0a
b15_d865:   .db $8f                     ; 3D865:  8f
b15_d866:   clc                         ; 3D866:  18
b15_d867:   .db $b3                     ; 3D867:  b3
b15_d868:   .db $0b                     ; 3D868:  0b
b15_d869:   ldy $c6,x                   ; 3D869:  b4 c6
b15_d86b:   .db $d7                     ; 3D86B:  d7
b15_d86c:   eor #$d8                    ; 3D86C:  49 d8
b15_d86e:   .db vm_ip_hi                     ; 3D86E:  07
b15_d86f:   .db music_ptr_lo                     ; 3D86F:  7a
b15_d870:   .db $b3                     ; 3D870:  b3
b15_d871:   sta $0764                   ; 3D871:  8d 64 07
b15_d874:   .db music_ptr_lo                     ; 3D874:  7a
b15_d875:   bcs $d82a                   ; 3D875:  b0 b3
b15_d877:   sbc #$5e                    ; 3D877:  e9 5e
b15_d879:   .db $cb                     ; 3D879:  cb
b15_d87a:   .db vm_fp_lo                     ; 3D87A:  04
b15_d87b:   lda ($40),y                 ; 3D87B:  b1 40
b15_d87d:   and #$3c                    ; 3D87D:  29 3c
b15_d87f:   sbc #$da                    ; 3D87F:  e9 da
b15_d881:   .db $d7                     ; 3D881:  d7
b15_d882:   .db vm_sp_lo                     ; 3D882:  02
b15_d883:   rol $28                     ; 3D883:  26 28
b15_d885:   dec $a9,x                   ; 3D885:  d6 a9
b15_d887:   cld                         ; 3D887:  d8
b15_d888:   php                         ; 3D888:  08
b15_d889:   .db $d3                     ; 3D889:  d3
b15_d88a:   sty $00eb                   ; 3D88A:  8c eb 00
b15_d88d:   cpy $d8                     ; 3D88D:  c4 d8
b15_d88f:   sty $d8,x                   ; 3D88F:  94 d8
b15_d891:   sec                         ; 3D891:  38
b15_d892:   rti                         ; 3D892:  40
b15_d893:   .db $d4                     ; 3D893:  d4
b15_d894:   php                         ; 3D894:  08
b15_d895:   .db $d3                     ; 3D895:  d3
b15_d896:   sty $00d2                   ; 3D896:  8c d2 00
b15_d899:   cpy $d8                     ; 3D899:  c4 d8
b15_d89b:   lda ($d8,x)                 ; 3D89B:  a1 d8
b15_d89d:   sec                         ; 3D89D:  38
b15_d89e:   .db skip_wallclock                     ; 3D89E:  89
b15_d89f:   .db $d2                     ; 3D89F:  d2
b15_d8a0:   .db $d4                     ; 3D8A0:  d4
b15_d8a1:   php                         ; 3D8A1:  08
b15_d8a2:   bne $d8cc                   ; 3D8A2:  d0 28
b15_d8a4:   cmp ($09),y                 ; 3D8A4:  d1 09
b15_d8a6:   bne $d8d1                   ; 3D8A6:  d0 29
b15_d8a8:   cmp ($09),y                 ; 3D8A8:  d1 09
b15_d8aa:   lsr $c6,x                   ; 3D8AA:  56 c6
b15_d8ac:   .db $d7                     ; 3D8AC:  d7
b15_d8ad:   dey                         ; 3D8AD:  88
b15_d8ae:   cld                         ; 3D8AE:  d8
b15_d8af:   .db $3c                     ; 3D8AF:  3c
b15_d8b0:   sbc #$15                    ; 3D8B0:  e9 15
b15_d8b2:   cld                         ; 3D8B2:  d8
b15_d8b3:   .db vm_sp_lo                     ; 3D8B3:  02
b15_d8b4:   .db $3c                     ; 3D8B4:  3c
b15_d8b5:   sbc #$f7                    ; 3D8B5:  e9 f7
b15_d8b7:   .db $d7                     ; 3D8B7:  d7
b15_d8b8:   .db vm_sp_lo                     ; 3D8B8:  02
b15_d8b9:   .db $cf                     ; 3D8B9:  cf
develop_gain:   jsr $e823                   ; 3D8BA:  20 23 e8
b15_d8bd:   .db $fc                     ; 3D8BD:  fc
b15_d8be:   .db $ff                     ; 3D8BE:  ff
b15_d8bf:   .db $0c                     ; 3D8BF:  0c
b15_d8c0:   eor ($c2),y                 ; 3D8C0:  51 c2
b15_d8c2:   cld                         ; 3D8C2:  d8
b15_d8c3:   .db $c7                     ; 3D8C3:  c7
b15_d8c4:   cld                         ; 3D8C4:  d8
b15_d8c5:   rti                         ; 3D8C5:  40
b15_d8c6:   .db $cf                     ; 3D8C6:  cf
b15_d8c7:   .db $3c                     ; 3D8C7:  3c
b15_d8c8:   sbc #$cd                    ; 3D8C8:  e9 cd
b15_d8ca:   .db $cb                     ; 3D8CA:  cb
b15_d8cb:   .db vm_sp_lo                     ; 3D8CB:  02
b15_d8cc:   .db $b3                     ; 3D8CC:  b3
b15_d8cd:   asl $b3b0                   ; 3D8CD:  0e b0 b3
b15_d8d0:   ora $b4b0                   ; 3D8D0:  0d b0 b4
b15_d8d3:   .db $bb                     ; 3D8D3:  bb
b15_d8d4:   .db $52                     ; 3D8D4:  52
b15_d8d5:   ldx $b3,y                   ; 3D8D5:  b6 b3
b15_d8d7:   sbc #$cd                    ; 3D8D7:  e9 cd
b15_d8d9:   .db $cb                     ; 3D8D9:  cb
b15_d8da:   .db vm_sp_lo                     ; 3D8DA:  02
b15_d8db:   ldy $bb,x                   ; 3D8DB:  b4 bb
b15_d8dd:   .db $b3                     ; 3D8DD:  b3
b15_d8de:   lsr $a6                     ; 3D8DE:  46 a6
b15_d8e0:   .db $63                     ; 3D8E0:  63
b15_d8e1:   adc $b3bc                   ; 3D8E1:  6d bc b3
b15_d8e4:   .db $3c                     ; 3D8E4:  3c
b15_d8e5:   sbc #$b8                    ; 3D8E5:  e9 b8
b15_d8e7:   dec vm_ip_lo,x                   ; 3D8E7:  d6 06
b15_d8e9:   .db $2b                     ; 3D8E9:  2b
b15_d8ea:   .db $0b                     ; 3D8EA:  0b
b15_d8eb:   .db $d7                     ; 3D8EB:  d7
b15_d8ec:   beq $d8c6                   ; 3D8EC:  f0 d8
b15_d8ee:   eor ($cf,x)                 ; 3D8EE:  41 cf
b15_d8f0:   .db $0b                     ; 3D8F0:  0b
b15_d8f1:   .db $cf                     ; 3D8F1:  cf
develop_gain_capped_loyalty:   jsr $e823                   ; 3D8F2:  20 23 e8
b15_d8f5:   .db $fc                     ; 3D8F5:  fc
b15_d8f6:   .db $ff                     ; 3D8F6:  ff
b15_d8f7:   .db $0c                     ; 3D8F7:  0c
b15_d8f8:   sei                         ; 3D8F8:  78
b15_d8f9:   .db $b3                     ; 3D8F9:  b3
b15_d8fa:   .db $0c                     ; 3D8FA:  0c
b15_d8fb:   .db $7c                     ; 3D8FB:  7c
b15_d8fc:   .db $b3                     ; 3D8FC:  b3
b15_d8fd:   and $bae9,x                 ; 3D8FD:  3d e9 ba
b15_d900:   cld                         ; 3D900:  d8
b15_d901:   asl $2b                     ; 3D901:  06 2b
b15_d903:   .db $0c                     ; 3D903:  0c
b15_d904:   .db $7c                     ; 3D904:  7c
b15_d905:   bcs $d8ba                   ; 3D905:  b0 b3
b15_d907:   .db $0c                     ; 3D907:  0c
b15_d908:   .db $8f                     ; 3D908:  8f
b15_d909:   clc                         ; 3D909:  18
b15_d90a:   bcs $d8c0                   ; 3D90A:  b0 b4
b15_d90c:   ldy $b32a,x                 ; 3D90C:  bc 2a b3
b15_d90f:   .db $0b                     ; 3D90F:  0b
b15_d910:   ldy $c4,x                   ; 3D910:  b4 c4
b15_d912:   cld                         ; 3D912:  d8
b15_d913:   .db $17                     ; 3D913:  17
b15_d914:   cmp $cf0a,y                 ; 3D914:  d9 0a cf
b15_d917:   .db $0b                     ; 3D917:  0b
b15_d918:   .db $cf                     ; 3D918:  cf
develop_gain_capped_wealth:   jsr $e823                   ; 3D919:  20 23 e8
b15_d91c:   .db $fc                     ; 3D91C:  fc
b15_d91d:   .db $ff                     ; 3D91D:  ff
b15_d91e:   .db $0c                     ; 3D91E:  0c
b15_d91f:   .db palette_dirty                     ; 3D91F:  74
b15_d920:   .db $b3                     ; 3D920:  b3
b15_d921:   .db $0c                     ; 3D921:  0c
b15_d922:   ror $3db3,x                 ; 3D922:  7e b3 3d
b15_d925:   sbc #$ba                    ; 3D925:  e9 ba
b15_d927:   cld                         ; 3D927:  d8
b15_d928:   asl $2b                     ; 3D928:  06 2b
b15_d92a:   .db $0c                     ; 3D92A:  0c
b15_d92b:   ror $b3b0,x                 ; 3D92B:  7e b0 b3
b15_d92e:   .db $0c                     ; 3D92E:  0c
b15_d92f:   .db $8f                     ; 3D92F:  8f
b15_d930:   clc                         ; 3D930:  18
b15_d931:   bcs $d8e7                   ; 3D931:  b0 b4
b15_d933:   ldy $b32a,x                 ; 3D933:  bc 2a b3
b15_d936:   .db $0b                     ; 3D936:  0b
b15_d937:   ldy $c4,x                   ; 3D937:  b4 c4
b15_d939:   cld                         ; 3D939:  d8
b15_d93a:   rol $0ad9,x                 ; 3D93A:  3e d9 0a
b15_d93d:   .db $cf                     ; 3D93D:  cf
b15_d93e:   .db $0b                     ; 3D93E:  0b
b15_d93f:   .db $cf                     ; 3D93F:  cf
record_apply_two_grows:   jsr $e823                   ; 3D940:  20 23 e8
b15_d943:   brk                         ; 3D943:  00
b15_d944:   brk                         ; 3D944:  00
b15_d945:   and $e93c,x                 ; 3D945:  3d 3c e9
b15_d948:   .db $f2                     ; 3D948:  f2
b15_d949:   cld                         ; 3D949:  d8
b15_d94a:   .db vm_fp_lo                     ; 3D94A:  04
b15_d94b:   .db $b3                     ; 3D94B:  b3
b15_d94c:   .db $0c                     ; 3D94C:  0c
b15_d94d:   .db $7c                     ; 3D94D:  7c
b15_d94e:   ldy $b3,x                   ; 3D94E:  b4 b3
b15_d950:   bcs $d90d                   ; 3D950:  b0 bb
b15_d952:   lda ($3d),y                 ; 3D952:  b1 3d
b15_d954:   .db $3c                     ; 3D954:  3c
b15_d955:   sbc #$19                    ; 3D955:  e9 19
b15_d957:   cmp $b304,y                 ; 3D957:  d9 04 b3
b15_d95a:   .db $0c                     ; 3D95A:  0c
b15_d95b:   ror $b3b4,x                 ; 3D95B:  7e b4 b3
b15_d95e:   bcs $d91b                   ; 3D95E:  b0 bb
b15_d960:   lda ($cf),y                 ; 3D960:  b1 cf
set_6da1_bit7:   jsr $e823                   ; 3D962:  20 23 e8
b15_d965:   brk                         ; 3D965:  00
b15_d966:   brk                         ; 3D966:  00
b15_d967:   .db skip_wallclock                     ; 3D967:  89
b15_d968:   .db skip_vblank_wait                     ; 3D968:  80
b15_d969:   cmp $a1a5                   ; 3D969:  cd a5 a1
b15_d96c:   adc $a9db                   ; 3D96C:  6d db a9
b15_d96f:   lda ($6d,x)                 ; 3D96F:  a1 6d
b15_d971:   .db $cf                     ; 3D971:  cf
fief_owner_weakness:   jsr $e823                   ; 3D972:  20 23 e8
b15_d975:   brk                         ; 3D975:  00
b15_d976:   brk                         ; 3D976:  00
b15_d977:   .db $3c                     ; 3D977:  3c
b15_d978:   sbc #$72                    ; 3D978:  e9 72
b15_d97a:   .db $d7                     ; 3D97A:  d7
b15_d97b:   .db vm_sp_lo                     ; 3D97B:  02
b15_d97c:   sty daimyo_weakness_flag                   ; 3D97C:  8c d4 6d
b15_d97f:   .db $bb                     ; 3D97F:  bb
b15_d980:   .db $d3                     ; 3D980:  d3
b15_d981:   .db $cf                     ; 3D981:  cf
is_ai_count_ge_8:   jsr $e823                   ; 3D982:  20 23 e8
b15_d985:   brk                         ; 3D985:  00
b15_d986:   brk                         ; 3D986:  00
b15_d987:   ldy $09                     ; 3D987:  a4 09
b15_d989:   ror $c958                   ; 3D989:  6e 58 c9
b15_d98c:   .db $cf                     ; 3D98C:  cf
get_province_ai_state:   jsr $e823                   ; 3D98D:  20 23 e8
b15_d990:   brk                         ; 3D990:  00
b15_d991:   brk                         ; 3D991:  00
b15_d992:   .db $0c                     ; 3D992:  0c
b15_d993:   sty province_ai_state                   ; 3D993:  8c f7 6c
b15_d996:   .db $bb                     ; 3D996:  bb
b15_d997:   .db $d3                     ; 3D997:  d3
b15_d998:   .db $cf                     ; 3D998:  cf
province_state_is_FF:   jsr $e823                   ; 3D999:  20 23 e8
b15_d99c:   brk                         ; 3D99C:  00
b15_d99d:   brk                         ; 3D99D:  00
b15_d99e:   .db $0c                     ; 3D99E:  0c
b15_d99f:   sty province_ai_state                   ; 3D99F:  8c f7 6c
b15_d9a2:   .db $bb                     ; 3D9A2:  bb
b15_d9a3:   .db $d3                     ; 3D9A3:  d3
b15_d9a4:   sty $00ff                   ; 3D9A4:  8c ff 00
b15_d9a7:   cpy #$cf                    ; 3D9A7:  c0 cf
get_6da2_cur:   jsr $e823                   ; 3D9A9:  20 23 e8
b15_d9ac:   brk                         ; 3D9AC:  00
b15_d9ad:   brk                         ; 3D9AD:  00
b15_d9ae:   ldy $5f                     ; 3D9AE:  a4 5f
b15_d9b0:   .db p2_buttons                     ; 3D9B0:  6f
b15_d9b1:   sty fief_is_daimyo_capital                   ; 3D9B1:  8c a2 6d
b15_d9b4:   .db $bb                     ; 3D9B4:  bb
b15_d9b5:   .db $d3                     ; 3D9B5:  d3
b15_d9b6:   .db $cf                     ; 3D9B6:  cf
is_enemy_owned:   jsr $e823                   ; 3D9B7:  20 23 e8
b15_d9ba:   brk                         ; 3D9BA:  00
b15_d9bb:   brk                         ; 3D9BB:  00
b15_d9bc:   ldy $d77e                   ; 3D9BC:  ac 7e d7
b15_d9bf:   .db $b3                     ; 3D9BF:  b3
b15_d9c0:   .db $3c                     ; 3D9C0:  3c
b15_d9c1:   sbc #$72                    ; 3D9C1:  e9 72
b15_d9c3:   .db $d7                     ; 3D9C3:  d7
b15_d9c4:   .db vm_sp_lo                     ; 3D9C4:  02
b15_d9c5:   ldy $c0,x                   ; 3D9C5:  b4 c0
b15_d9c7:   .db $cf                     ; 3D9C7:  cf
province_ai_state_addr:   jsr $e823                   ; 3D9C8:  20 23 e8
b15_d9cb:   brk                         ; 3D9CB:  00
b15_d9cc:   brk                         ; 3D9CC:  00
b15_d9cd:   .db $0c                     ; 3D9CD:  0c
b15_d9ce:   sty province_ai_state                   ; 3D9CE:  8c f7 6c
b15_d9d1:   .db $bb                     ; 3D9D1:  bb
b15_d9d2:   .db $cf                     ; 3D9D2:  cf
redraw_window_row:   jsr $e823                   ; 3D9D3:  20 23 e8
b15_d9d6:   brk                         ; 3D9D6:  00
b15_d9d7:   brk                         ; 3D9D7:  00
b15_d9d8:   .db $0c                     ; 3D9D8:  0c
b15_d9d9:   .db $5a                     ; 3D9D9:  5a
b15_d9da:   lda $8c,x                   ; 3D9DA:  b5 8c
b15_d9dc:   sta music_voice_idx                     ; 3D9DC:  85 79
b15_d9de:   .db $bb                     ; 3D9DE:  bb
b15_d9df:   .db $b3                     ; 3D9DF:  b3
b15_d9e0:   sbc #$c4                    ; 3D9E0:  e9 c4
b15_d9e2:   dec $cf02                   ; 3D9E2:  ce 02 cf
test_6f65_bit7:   jsr $e823                   ; 3D9E5:  20 23 e8
b15_d9e8:   brk                         ; 3D9E8:  00
b15_d9e9:   brk                         ; 3D9E9:  00
b15_d9ea:   .db $0c                     ; 3D9EA:  0c
b15_d9eb:   sty war_side_state_flag                   ; 3D9EB:  8c 65 6f
b15_d9ee:   .db $bb                     ; 3D9EE:  bb
b15_d9ef:   .db $d3                     ; 3D9EF:  d3
b15_d9f0:   sty skip_vblank_wait                   ; 3D9F0:  8c 80 00
b15_d9f3:   .db $da                     ; 3D9F3:  da
b15_d9f4:   bvc $d9b7                   ; 3D9F4:  50 c1
b15_d9f6:   .db $cf                     ; 3D9F6:  cf
revolt_type_message:   jsr $e823                   ; 3D9F7:  20 23 e8
b15_d9fa:   inc $0cff,x                 ; 3D9FA:  fe ff 0c
b15_d9fd:   sty fief_revolt_type                   ; 3D9FD:  8c 79 7b
b15_da00:   .db $bb                     ; 3DA00:  bb
b15_da01:   .db $d3                     ; 3DA01:  d3
b15_da02:   lsr $c0,x                   ; 3DA02:  56 c0
b15_da04:   cld                         ; 3DA04:  d8
b15_da05:   ora $8ada                   ; 3DA05:  0d da 8a
b15_da08:   sbc $d6f6                   ; 3DA08:  ed f6 d6
b15_da0b:   and ($da,x)                 ; 3DA0B:  21 da
b15_da0d:   .db $0c                     ; 3DA0D:  0c
b15_da0e:   sty fief_revolt_type                   ; 3DA0E:  8c 79 7b
b15_da11:   .db $bb                     ; 3DA11:  bb
b15_da12:   .db $d3                     ; 3DA12:  d3
b15_da13:   .db $57                     ; 3DA13:  57
b15_da14:   cpy #$d8                    ; 3DA14:  c0 d8
b15_da16:   asl $8ada,x                 ; 3DA16:  1e da 8a
b15_da19:   sbc $f6,x                   ; 3DA19:  f5 f6
b15_da1b:   dec $21,x                   ; 3DA1B:  d6 21
b15_da1d:   .db $da                     ; 3DA1D:  da
b15_da1e:   txa                         ; 3DA1E:  8a
b15_da1f:   inc $2bf6,x                 ; 3DA1F:  fe f6 2b
b15_da22:   .db $0b                     ; 3DA22:  0b
b15_da23:   .db $cf                     ; 3DA23:  cf
scaled_force_transfer:   jsr $e823                   ; 3DA24:  20 23 e8
b15_da27:   brk                         ; 3DA27:  00
b15_da28:   brk                         ; 3DA28:  00
b15_da29:   .db $87                     ; 3DA29:  87
b15_da2a:   .db $13                     ; 3DA2A:  13
b15_da2b:   .db $3f                     ; 3DA2B:  3f
b15_da2c:   rol $dee9,x                 ; 3DA2C:  3e e9 de
b15_da2f:   dec vm_fp_lo,x                   ; 3DA2F:  d6 04
b15_da31:   .db $b3                     ; 3DA31:  b3
b15_da32:   ora $db51                   ; 3DA32:  0d 51 db
b15_da35:   .db $b3                     ; 3DA35:  b3
b15_da36:   sbc #$0d                    ; 3DA36:  e9 0d
b15_da38:   .db $d7                     ; 3DA38:  d7
b15_da39:   .db vm_fp_lo                     ; 3DA39:  04
b15_da3a:   .db $b3                     ; 3DA3A:  b3
b15_da3b:   rol $e93f,x                 ; 3DA3B:  3e 3f e9
b15_da3e:   dec $04d6,x                 ; 3DA3E:  de d6 04
b15_da41:   .db $b3                     ; 3DA41:  b3
b15_da42:   .db $3c                     ; 3DA42:  3c
b15_da43:   sbc #$0d                    ; 3DA43:  e9 0d
b15_da45:   .db $d7                     ; 3DA45:  d7
b15_da46:   .db vm_fp_lo                     ; 3DA46:  04
b15_da47:   ldy $bb,x                   ; 3DA47:  b4 bb
b15_da49:   .db $b3                     ; 3DA49:  b3
b15_da4a:   sbc #$5e                    ; 3DA4A:  e9 5e
b15_da4c:   .db $cb                     ; 3DA4C:  cb
b15_da4d:   .db vm_fp_lo                     ; 3DA4D:  04
b15_da4e:   .db $cf                     ; 3DA4E:  cf
set_pact_relation:   jsr $e823                   ; 3DA4F:  20 23 e8
b15_da52:   brk                         ; 3DA52:  00
b15_da53:   brk                         ; 3DA53:  00
b15_da54:   ldy $5f                     ; 3DA54:  a4 5f
b15_da56:   .db p2_buttons                     ; 3DA56:  6f
b15_da57:   ldx $63                     ; 3DA57:  a6 63
b15_da59:   .db p2_buttons                     ; 3DA59:  6f
b15_da5a:   dec $d8                     ; 3DA5A:  c6 d8
b15_da5c:   ror a                       ; 3DA5C:  6a
b15_da5d:   .db $da                     ; 3DA5D:  da
b15_da5e:   ldy $5f                     ; 3DA5E:  a4 5f
b15_da60:   .db p2_buttons                     ; 3DA60:  6f
b15_da61:   .db $8b                     ; 3DA61:  8b
b15_da62:   rol $b5,x                   ; 3DA62:  36 b5
b15_da64:   ldx $63                     ; 3DA64:  a6 63
b15_da66:   .db p2_buttons                     ; 3DA66:  6f
b15_da67:   dec prg_bank_shadow,x                   ; 3DA67:  d6 73
b15_da69:   .db $da                     ; 3DA69:  da
b15_da6a:   ldy $63                     ; 3DA6A:  a4 63
b15_da6c:   .db p2_buttons                     ; 3DA6C:  6f
b15_da6d:   .db $8b                     ; 3DA6D:  8b
b15_da6e:   rol $b5,x                   ; 3DA6E:  36 b5
b15_da70:   ldx $5f                     ; 3DA70:  a6 5f
b15_da72:   .db p2_buttons                     ; 3DA72:  6f
b15_da73:   .db $bb                     ; 3DA73:  bb
b15_da74:   sty relations_matrix                   ; 3DA74:  8c 93 61
b15_da77:   .db $bb                     ; 3DA77:  bb
b15_da78:   .db $b3                     ; 3DA78:  b3
b15_da79:   .db skip_wallclock                     ; 3DA79:  89
b15_da7a:   lsr $d4                     ; 3DA7A:  46 d4
b15_da7c:   .db $cf                     ; 3DA7C:  cf
set_marriage_relation:   jsr $e823                   ; 3DA7D:  20 23 e8
b15_da80:   .db $fc                     ; 3DA80:  fc
b15_da81:   .db $ff                     ; 3DA81:  ff
b15_da82:   ldy $d77e                   ; 3DA82:  ac 7e d7
b15_da85:   .db $2b                     ; 3DA85:  2b
b15_da86:   tax                         ; 3DA86:  aa
b15_da87:   .db $63                     ; 3DA87:  63
b15_da88:   .db p2_buttons                     ; 3DA88:  6f
b15_da89:   sbc #$72                    ; 3DA89:  e9 72
b15_da8b:   .db $d7                     ; 3DA8B:  d7
b15_da8c:   .db vm_sp_lo                     ; 3DA8C:  02
b15_da8d:   rol a                       ; 3DA8D:  2a
b15_da8e:   .db $0b                     ; 3DA8E:  0b
b15_da8f:   .db $1a                     ; 3DA8F:  1a
b15_da90:   dec $d8                     ; 3DA90:  c6 d8
b15_da92:   .db $9c                     ; 3DA92:  9c
b15_da93:   .db $da                     ; 3DA93:  da
b15_da94:   asl a                       ; 3DA94:  0a
b15_da95:   .db $8b                     ; 3DA95:  8b
b15_da96:   rol $b5,x                   ; 3DA96:  36 b5
b15_da98:   .db $1b                     ; 3DA98:  1b
b15_da99:   dec $a1,x                   ; 3DA99:  d6 a1
b15_da9b:   .db $da                     ; 3DA9B:  da
b15_da9c:   .db $0b                     ; 3DA9C:  0b
b15_da9d:   .db $8b                     ; 3DA9D:  8b
b15_da9e:   rol $b5,x                   ; 3DA9E:  36 b5
b15_daa0:   .db $1a                     ; 3DAA0:  1a
b15_daa1:   .db $bb                     ; 3DAA1:  bb
b15_daa2:   sty relations_matrix                   ; 3DAA2:  8c 93 61
b15_daa5:   .db $bb                     ; 3DAA5:  bb
b15_daa6:   .db $b3                     ; 3DAA6:  b3
b15_daa7:   .db skip_wallclock                     ; 3DAA7:  89
b15_daa8:   .db $5a                     ; 3DAA8:  5a
b15_daa9:   .db $d4                     ; 3DAA9:  d4
b15_daaa:   .db $cf                     ; 3DAAA:  cf
load_daimyo_relation_row:   jsr $e823                   ; 3DAAB:  20 23 e8
b15_daae:   brk                         ; 3DAAE:  00
b15_daaf:   brk                         ; 3DAAF:  00
b15_dab0:   pla                         ; 3DAB0:  68
b15_dab1:   stx deduped_owner_list                   ; 3DAB1:  8e 4f 6f
b15_dab4:   ldy $9d                     ; 3DAB4:  a4 9d
b15_dab6:   adc $118b                   ; 3DAB6:  6d 8b 11
b15_dab9:   cpy #$d8                    ; 3DAB9:  c0 d8
b15_dabb:   dec $da                     ; 3DABB:  c6 da
b15_dabd:   .db $0c                     ; 3DABD:  0c
b15_dabe:   .db $53                     ; 3DABE:  53
b15_dabf:   lda $008c,x                 ; 3DABF:  bd 8c 00
b15_dac2:   .db clock_a_hi                     ; 3DAC2:  83
b15_dac3:   dec $cc,x                   ; 3DAC3:  d6 cc
b15_dac5:   .db $da                     ; 3DAC5:  da
b15_dac6:   .db $0c                     ; 3DAC6:  0c
b15_dac7:   .db $53                     ; 3DAC7:  53
b15_dac8:   lda $048c,x                 ; 3DAC8:  bd 8c 04
b15_dacb:   .db skip_vblank_wait                     ; 3DACB:  80
b15_dacc:   .db $bb                     ; 3DACC:  bb
b15_dacd:   .db $b3                     ; 3DACD:  b3
b15_dace:   .db $64                     ; 3DACE:  64
b15_dacf:   sbc #$bd                    ; 3DACF:  e9 bd
b15_dad1:   .db $cb                     ; 3DAD1:  cb
b15_dad2:   php                         ; 3DAD2:  08
b15_dad3:   txa                         ; 3DAD3:  8a
b15_dad4:   .db $4f                     ; 3DAD4:  4f
b15_dad5:   .db p2_buttons                     ; 3DAD5:  6f
b15_dad6:   .db $cf                     ; 3DAD6:  cf
compact_relation_list:   jsr $e823                   ; 3DAD7:  20 23 e8
b15_dada:   .db $fc                     ; 3DADA:  fc
b15_dadb:   .db $ff                     ; 3DADB:  ff
b15_dadc:   tax                         ; 3DADC:  aa
b15_dadd:   .db $5f                     ; 3DADD:  5f
b15_dade:   .db p2_buttons                     ; 3DADE:  6f
b15_dadf:   sbc #$ab                    ; 3DADF:  e9 ab
b15_dae1:   .db $da                     ; 3DAE1:  da
b15_dae2:   .db vm_sp_lo                     ; 3DAE2:  02
b15_dae3:   txa                         ; 3DAE3:  8a
b15_dae4:   .db $4f                     ; 3DAE4:  4f
b15_dae5:   .db p2_buttons                     ; 3DAE5:  6f
b15_dae6:   rol a                       ; 3DAE6:  2a
b15_dae7:   .db $2b                     ; 3DAE7:  2b
b15_dae8:   dec vm_fp_lo,x                   ; 3DAE8:  d6 04
b15_daea:   .db $db                     ; 3DAEA:  db
b15_daeb:   asl a                       ; 3DAEB:  0a
b15_daec:   .db $d3                     ; 3DAEC:  d3
b15_daed:   .db $b3                     ; 3DAED:  b3
b15_daee:   sbc #$8d                    ; 3DAEE:  e9 8d
b15_daf0:   cmp $8c02,y                 ; 3DAF0:  d9 02 8c
b15_daf3:   .db $ff                     ; 3DAF3:  ff
b15_daf4:   brk                         ; 3DAF4:  00
b15_daf5:   cmp ($d8,x)                 ; 3DAF5:  c1 d8
b15_daf7:   ora ($db,x)                 ; 3DAF7:  01 db
b15_daf9:   .db $0b                     ; 3DAF9:  0b
b15_dafa:   bne $db27                   ; 3DAFA:  d0 2b
b15_dafc:   cmp ($b3),y                 ; 3DAFC:  d1 b3
b15_dafe:   asl a                       ; 3DAFE:  0a
b15_daff:   .db $d3                     ; 3DAFF:  d3
b15_db00:   .db $d4                     ; 3DB00:  d4
b15_db01:   asl a                       ; 3DB01:  0a
b15_db02:   bne $db2e                   ; 3DB02:  d0 2a
b15_db04:   asl a                       ; 3DB04:  0a
b15_db05:   .db $d3                     ; 3DB05:  d3
b15_db06:   sty $00ff                   ; 3DB06:  8c ff 00
b15_db09:   cmp ($d7,x)                 ; 3DB09:  c1 d7
b15_db0b:   .db $eb                     ; 3DB0B:  eb
b15_db0c:   .db $da                     ; 3DB0C:  da
b15_db0d:   .db $3b                     ; 3DB0D:  3b
b15_db0e:   .db skip_wallclock                     ; 3DB0E:  89
b15_db0f:   .db $ff                     ; 3DB0F:  ff
b15_db10:   .db $d4                     ; 3DB10:  d4
b15_db11:   .db $cf                     ; 3DB11:  cf
defender_owner_is_keyed_daimyo:   jsr $e823                   ; 3DB12:  20 23 e8
b15_db15:   brk                         ; 3DB15:  00
b15_db16:   brk                         ; 3DB16:  00
b15_db17:   ldy $9d                     ; 3DB17:  a4 9d
b15_db19:   adc $118b                   ; 3DB19:  6d 8b 11
b15_db1c:   cpy #$d8                    ; 3DB1C:  c0 d8
b15_db1e:   rol a                       ; 3DB1E:  2a
b15_db1f:   .db $db                     ; 3DB1F:  db
b15_db20:   tax                         ; 3DB20:  aa
b15_db21:   .db $63                     ; 3DB21:  63
b15_db22:   .db p2_buttons                     ; 3DB22:  6f
b15_db23:   sbc #$72                    ; 3DB23:  e9 72
b15_db25:   .db $d7                     ; 3DB25:  d7
b15_db26:   .db vm_sp_lo                     ; 3DB26:  02
b15_db27:   .db $53                     ; 3DB27:  53
b15_db28:   cpy #$cf                    ; 3DB28:  c0 cf
b15_db2a:   tax                         ; 3DB2A:  aa
b15_db2b:   .db $63                     ; 3DB2B:  63
b15_db2c:   .db p2_buttons                     ; 3DB2C:  6f
b15_db2d:   sbc #$72                    ; 3DB2D:  e9 72
b15_db2f:   .db $d7                     ; 3DB2F:  d7
b15_db30:   .db vm_sp_lo                     ; 3DB30:  02
b15_db31:   .db $8b                     ; 3DB31:  8b
b15_db32:   .db $14                     ; 3DB32:  14
b15_db33:   cpy #$cf                    ; 3DB33:  c0 cf
increment_ai_player_count:   jsr $e823                   ; 3DB35:  20 23 e8
b15_db38:   brk                         ; 3DB38:  00
b15_db39:   brk                         ; 3DB39:  00
b15_db3a:   ldy $09                     ; 3DB3A:  a4 09
b15_db3c:   ror $a8d0                   ; 3DB3C:  6e d0 a8
b15_db3f:   ora #$6e                    ; 3DB3F:  09 6e
b15_db41:   ldy $d982                   ; 3DB41:  ac 82 d9
b15_db44:   cld                         ; 3DB44:  d8
b15_db45:   lsr a                       ; 3DB45:  4a
b15_db46:   .db $db                     ; 3DB46:  db
b15_db47:   ldy $d962                   ; 3DB47:  ac 62 d9
b15_db4a:   .db $cf                     ; 3DB4A:  cf
draw_owner_name:   jsr $e823                   ; 3DB4B:  20 23 e8
b15_db4e:   brk                         ; 3DB4E:  00
b15_db4f:   brk                         ; 3DB4F:  00
b15_db50:   .db $0c                     ; 3DB50:  0c
b15_db51:   sty province_ai_state                   ; 3DB51:  8c f7 6c
b15_db54:   .db $bb                     ; 3DB54:  bb
b15_db55:   .db $d3                     ; 3DB55:  d3
b15_db56:   sty $00ff                   ; 3DB56:  8c ff 00
b15_db59:   cmp ($d8,x)                 ; 3DB59:  c1 d8
b15_db5b:   adc $3cdb                   ; 3DB5B:  6d db 3c
b15_db5e:   sbc #$72                    ; 3DB5E:  e9 72
b15_db60:   .db $d7                     ; 3DB60:  d7
b15_db61:   .db vm_sp_lo                     ; 3DB61:  02
b15_db62:   eor $8cb5,y                 ; 3DB62:  59 b5 8c
b15_db65:   tay                         ; 3DB65:  a8
b15_db66:   .db $77                     ; 3DB66:  77
b15_db67:   .db $bb                     ; 3DB67:  bb
b15_db68:   .db $b3                     ; 3DB68:  b3
b15_db69:   sbc #$c4                    ; 3DB69:  e9 c4
b15_db6b:   dec $cf02                   ; 3DB6B:  ce 02 cf
draw_province_lord_name:   jsr $e823                   ; 3DB6E:  20 23 e8
b15_db71:   brk                         ; 3DB71:  00
b15_db72:   brk                         ; 3DB72:  00
b15_db73:   .db $0c                     ; 3DB73:  0c
b15_db74:   sty province_ai_state                   ; 3DB74:  8c f7 6c
b15_db77:   .db $bb                     ; 3DB77:  bb
b15_db78:   .db $d3                     ; 3DB78:  d3
b15_db79:   sty $00ff                   ; 3DB79:  8c ff 00
b15_db7c:   cmp ($d8,x)                 ; 3DB7C:  c1 d8
b15_db7e:   .db $8f                     ; 3DB7E:  8f
b15_db7f:   .db $db                     ; 3DB7F:  db
b15_db80:   .db $3c                     ; 3DB80:  3c
b15_db81:   sbc #$72                    ; 3DB81:  e9 72
b15_db83:   .db $d7                     ; 3DB83:  d7
b15_db84:   .db vm_sp_lo                     ; 3DB84:  02
b15_db85:   eor $8cb5,y                 ; 3DB85:  59 b5 8c
b15_db88:   tay                         ; 3DB88:  a8
b15_db89:   .db $77                     ; 3DB89:  77
b15_db8a:   .db $bb                     ; 3DB8A:  bb
b15_db8b:   .db $b3                     ; 3DB8B:  b3
b15_db8c:   dec $92,x                   ; 3DB8C:  d6 92
b15_db8e:   .db $db                     ; 3DB8E:  db
b15_db8f:   stx $f706                   ; 3DB8F:  8e 06 f7
b15_db92:   sbc #$c4                    ; 3DB92:  e9 c4
b15_db94:   dec $cf02                   ; 3DB94:  ce 02 cf
assign_unique_daimyo_face_code:   jsr $e823                   ; 3DB97:  20 23 e8
b15_db9a:   sed                         ; 3DB9A:  f8
b15_db9b:   .db $ff                     ; 3DB9B:  ff
b15_db9c:   .db $3c                     ; 3DB9C:  3c
b15_db9d:   sbc #$da                    ; 3DB9D:  e9 da
b15_db9f:   .db $d7                     ; 3DB9F:  d7
b15_dba0:   .db vm_sp_lo                     ; 3DBA0:  02
b15_dba1:   ror $b3,x                   ; 3DBA1:  76 b3
b15_dba3:   eor ($d4,x)                 ; 3DBA3:  41 d4
b15_dba5:   rti                         ; 3DBA5:  40
b15_dba6:   plp                         ; 3DBA6:  28
b15_dba7:   adc $e9                     ; 3DBA7:  65 e9
b15_dba9:   .db $52                     ; 3DBA9:  52
b15_dbaa:   dex                         ; 3DBAA:  ca
b15_dbab:   .db vm_sp_lo                     ; 3DBAB:  02
b15_dbac:   .db $b3                     ; 3DBAC:  b3
b15_dbad:   adc $e9                     ; 3DBAD:  65 e9
b15_dbaf:   .db $52                     ; 3DBAF:  52
b15_dbb0:   dex                         ; 3DBB0:  ca
b15_dbb1:   .db vm_sp_lo                     ; 3DBB1:  02
b15_dbb2:   eor $b5,x                   ; 3DBB2:  55 b5
b15_dbb4:   .db $b3                     ; 3DBB4:  b3
b15_dbb5:   adc $e9                     ; 3DBB5:  65 e9
b15_dbb7:   .db $52                     ; 3DBB7:  52
b15_dbb8:   dex                         ; 3DBB8:  ca
b15_dbb9:   .db vm_sp_lo                     ; 3DBB9:  02
b15_dbba:   .db $8b                     ; 3DBBA:  8b
b15_dbbb:   ora $b3b5,y                 ; 3DBBB:  19 b5 b3
b15_dbbe:   adc $e9                     ; 3DBBE:  65 e9
b15_dbc0:   .db $52                     ; 3DBC0:  52
b15_dbc1:   dex                         ; 3DBC1:  ca
b15_dbc2:   .db vm_sp_lo                     ; 3DBC2:  02
b15_dbc3:   .db $8b                     ; 3DBC3:  8b
b15_dbc4:   adc $b4b5,x                 ; 3DBC4:  7d b5 b4
b15_dbc7:   .db $bb                     ; 3DBC7:  bb
b15_dbc8:   ldy $bb,x                   ; 3DBC8:  b4 bb
b15_dbca:   ldy $bb,x                   ; 3DBCA:  b4 bb
b15_dbcc:   rol a                       ; 3DBCC:  2a
b15_dbcd:   ldy $9d                     ; 3DBCD:  a4 9d
b15_dbcf:   adc $328b                   ; 3DBCF:  6d 8b 32
b15_dbd2:   cpy #$d8                    ; 3DBD2:  c0 d8
b15_dbd4:   .db $db                     ; 3DBD4:  db
b15_dbd5:   .db $db                     ; 3DBD5:  db
b15_dbd6:   .db skip_wallclock                     ; 3DBD6:  89
b15_dbd7:   and $d6,x                   ; 3DBD7:  35 d6
b15_dbd9:   cmp $89db,x                 ; 3DBD9:  dd db 89
b15_dbdc:   ora ($29),y                 ; 3DBDC:  11 29
b15_dbde:   rti                         ; 3DBDE:  40
b15_dbdf:   .db $2b                     ; 3DBDF:  2b
b15_dbe0:   eor ($28,x)                 ; 3DBE0:  41 28
b15_dbe2:   dec $f6,x                   ; 3DBE2:  d6 f6
b15_dbe4:   .db $db                     ; 3DBE4:  db
b15_dbe5:   .db $0b                     ; 3DBE5:  0b
b15_dbe6:   .db $d2                     ; 3DBE6:  d2
b15_dbe7:   sty daimyo_face_code_table                   ; 3DBE7:  8c b1 6e
b15_dbea:   .db $bb                     ; 3DBEA:  bb
b15_dbeb:   bcs $dc07                   ; 3DBEB:  b0 1a
b15_dbed:   cpy #$d8                    ; 3DBED:  c0 d8
b15_dbef:   .db $f3                     ; 3DBEF:  f3
b15_dbf0:   .db $db                     ; 3DBF0:  db
b15_dbf1:   rti                         ; 3DBF1:  40
b15_dbf2:   plp                         ; 3DBF2:  28
b15_dbf3:   .db $0b                     ; 3DBF3:  0b
b15_dbf4:   bne $dc21                   ; 3DBF4:  d0 2b
b15_dbf6:   .db $0b                     ; 3DBF6:  0b
b15_dbf7:   ora $d7c6,y                 ; 3DBF7:  19 c6 d7
b15_dbfa:   sbc $db                     ; 3DBFA:  e5 db
b15_dbfc:   php                         ; 3DBFC:  08
b15_dbfd:   cld                         ; 3DBFD:  d8
b15_dbfe:   .db $a7                     ; 3DBFE:  a7
b15_dbff:   .db $db                     ; 3DBFF:  db
b15_dc00:   .db $3c                     ; 3DC00:  3c
b15_dc01:   sbc #$72                    ; 3DC01:  e9 72
b15_dc03:   .db $d7                     ; 3DC03:  d7
b15_dc04:   .db vm_sp_lo                     ; 3DC04:  02
b15_dc05:   .db $d2                     ; 3DC05:  d2
b15_dc06:   sty daimyo_face_code_table                   ; 3DC06:  8c b1 6e
b15_dc09:   .db $bb                     ; 3DC09:  bb
b15_dc0a:   .db $b3                     ; 3DC0A:  b3
b15_dc0b:   asl a                       ; 3DC0B:  0a
b15_dc0c:   lda ($cf),y                 ; 3DC0C:  b1 cf
pool_push_pop:   jsr $e823                   ; 3DC0E:  20 23 e8
b15_dc11:   brk                         ; 3DC11:  00
b15_dc12:   brk                         ; 3DC12:  00
b15_dc13:   .db $0c                     ; 3DC13:  0c
b15_dc14:   .db $8b                     ; 3DC14:  8b
b15_dc15:   and ($c8),y                 ; 3DC15:  31 c8
b15_dc17:   cld                         ; 3DC17:  d8
b15_dc18:   rol a                       ; 3DC18:  2a
b15_dc19:   .db $dc                     ; 3DC19:  dc
b15_dc1a:   lda $4a                     ; 3DC1A:  a5 4a
b15_dc1c:   ror $a9d1                   ; 3DC1C:  6e d1 a9
b15_dc1f:   lsr a                       ; 3DC1F:  4a
b15_dc20:   ror $4aa5                   ; 3DC20:  6e a5 4a
b15_dc23:   ror $4b8c                   ; 3DC23:  6e 8c 4b
b15_dc26:   ror $d3bb                   ; 3DC26:  6e bb d3
b15_dc29:   .db $cf                     ; 3DC29:  cf
b15_dc2a:   lda $4a                     ; 3DC2A:  a5 4a
b15_dc2c:   ror $a9d0                   ; 3DC2C:  6e d0 a9
b15_dc2f:   lsr a                       ; 3DC2F:  4a
b15_dc30:   ror $4aa5                   ; 3DC30:  6e a5 4a
b15_dc33:   ror $4a8c                   ; 3DC33:  6e 8c 4a
b15_dc36:   ror $b3bb                   ; 3DC36:  6e bb b3
b15_dc39:   .db $0c                     ; 3DC39:  0c
b15_dc3a:   .db $d4                     ; 3DC3A:  d4
b15_dc3b:   .db $cf                     ; 3DC3B:  cf
list_remove_matching:   jsr $e823                   ; 3DC3C:  20 23 e8
b15_dc3f:   .db $fc                     ; 3DC3F:  fc
b15_dc40:   .db $ff                     ; 3DC40:  ff
b15_dc41:   txa                         ; 3DC41:  8a
b15_dc42:   .db $7f                     ; 3DC42:  7f
b15_dc43:   ror $402a                   ; 3DC43:  6e 2a 40
b15_dc46:   .db $2b                     ; 3DC46:  2b
b15_dc47:   dec $5d,x                   ; 3DC47:  d6 5d
b15_dc49:   .db $dc                     ; 3DC49:  dc
b15_dc4a:   asl a                       ; 3DC4A:  0a
b15_dc4b:   .db $d3                     ; 3DC4B:  d3
b15_dc4c:   .db ppu_queue_a_lo                     ; 3DC4C:  1c
b15_dc4d:   cpy #$d8                    ; 3DC4D:  c0 d8
b15_dc4f:   eor $dc,x                   ; 3DC4F:  55 dc
b15_dc51:   .db $3a                     ; 3DC51:  3a
b15_dc52:   .db skip_wallclock                     ; 3DC52:  89
b15_dc53:   .db $ff                     ; 3DC53:  ff
b15_dc54:   .db $d4                     ; 3DC54:  d4
b15_dc55:   asl a                       ; 3DC55:  0a
b15_dc56:   bne $dc82                   ; 3DC56:  d0 2a
b15_dc58:   cmp ($0b),y                 ; 3DC58:  d1 0b
b15_dc5a:   bne $dc87                   ; 3DC5A:  d0 2b
b15_dc5c:   cmp ($0b),y                 ; 3DC5C:  d1 0b
b15_dc5e:   ldx $9d                     ; 3DC5E:  a6 9d
b15_dc60:   adc $d7c6                   ; 3DC60:  6d c6 d7
b15_dc63:   lsr a                       ; 3DC63:  4a
b15_dc64:   .db $dc                     ; 3DC64:  dc
b15_dc65:   .db $cf                     ; 3DC65:  cf
fief_to_mapid:   jsr $e823                   ; 3DC66:  20 23 e8
b15_dc69:   brk                         ; 3DC69:  00
b15_dc6a:   brk                         ; 3DC6A:  00
b15_dc6b:   .db $0c                     ; 3DC6B:  0c
b15_dc6c:   .db $8b                     ; 3DC6C:  8b
b15_dc6d:   .db $32                     ; 3DC6D:  32
b15_dc6e:   iny                         ; 3DC6E:  c8
b15_dc6f:   cld                         ; 3DC6F:  d8
b15_dc70:   .db palette_dirty                     ; 3DC70:  74
b15_dc71:   .db $dc                     ; 3DC71:  dc
b15_dc72:   .db $0c                     ; 3DC72:  0c
b15_dc73:   .db $cf                     ; 3DC73:  cf
b15_dc74:   ldy $9d                     ; 3DC74:  a4 9d
b15_dc76:   adc $328b                   ; 3DC76:  6d 8b 32
b15_dc79:   cpy #$d8                    ; 3DC79:  c0 d8
b15_dc7b:   sta ($dc,x)                 ; 3DC7B:  81 dc
b15_dc7d:   .db $0c                     ; 3DC7D:  0c
b15_dc7e:   dec $87,x                   ; 3DC7E:  d6 87
b15_dc80:   .db $dc                     ; 3DC80:  dc
b15_dc81:   .db $0c                     ; 3DC81:  0c
b15_dc82:   sty $f70e                   ; 3DC82:  8c 0e f7
b15_dc85:   .db $bb                     ; 3DC85:  bb
b15_dc86:   .db $d3                     ; 3DC86:  d3
b15_dc87:   .db $cf                     ; 3DC87:  cf
read_map_cell:   jsr $e823                   ; 3DC88:  20 23 e8
b15_dc8b:   .db $ff                     ; 3DC8B:  ff
b15_dc8c:   .db $ff                     ; 3DC8C:  ff
b15_dc8d:   adc ($de,x)                 ; 3DC8D:  61 de
b15_dc8f:   .db $ff                     ; 3DC8F:  ff
b15_dc90:   .db $ff                     ; 3DC90:  ff
b15_dc91:   .db $b3                     ; 3DC91:  b3
b15_dc92:   ora $b55b                   ; 3DC92:  0d 5b b5
b15_dc95:   .db $b3                     ; 3DC95:  b3
b15_dc96:   tax                         ; 3DC96:  aa
b15_dc97:   .db $63                     ; 3DC97:  63
b15_dc98:   .db p2_buttons                     ; 3DC98:  6f
b15_dc99:   sbc #$66                    ; 3DC99:  e9 66
b15_dc9b:   .db $dc                     ; 3DC9B:  dc
b15_dc9c:   .db vm_sp_lo                     ; 3DC9C:  02
b15_dc9d:   .db $8b                     ; 3DC9D:  8b
b15_dc9e:   .db $37                     ; 3DC9E:  37
b15_dc9f:   lda $b4,x                   ; 3DC9F:  b5 b4
b15_dca1:   .db $bb                     ; 3DCA1:  bb
b15_dca2:   .db ppu_queue_a_lo                     ; 3DCA2:  1c
b15_dca3:   .db $bb                     ; 3DCA3:  bb
b15_dca4:   sty $a57e                   ; 3DCA4:  8c 7e a5
b15_dca7:   .db $bb                     ; 3DCA7:  bb
b15_dca8:   .db $b3                     ; 3DCA8:  b3
b15_dca9:   .db $64                     ; 3DCA9:  64
b15_dcaa:   sbc #$bd                    ; 3DCAA:  e9 bd
b15_dcac:   .db $cb                     ; 3DCAC:  cb
b15_dcad:   php                         ; 3DCAD:  08
b15_dcae:   ldy #$ff                    ; 3DCAE:  a0 ff
b15_dcb0:   .db $ff                     ; 3DCB0:  ff
b15_dcb1:   .db $cf                     ; 3DCB1:  cf
generate_daimyo_name:   jsr $e823                   ; 3DCB2:  20 23 e8
b15_dcb5:   .db $f3                     ; 3DCB5:  f3
b15_dcb6:   .db $ff                     ; 3DCB6:  ff
b15_dcb7:   dec $fff3,x                 ; 3DCB7:  de f3 ff
b15_dcba:   and #$6b                    ; 3DCBA:  29 6b
b15_dcbc:   sbc #$52                    ; 3DCBC:  e9 52
b15_dcbe:   dex                         ; 3DCBE:  ca
b15_dcbf:   .db vm_sp_lo                     ; 3DCBF:  02
b15_dcc0:   .db $d2                     ; 3DCC0:  d2
b15_dcc1:   .db $2b                     ; 3DCC1:  2b
b15_dcc2:   .db $6b                     ; 3DCC2:  6b
b15_dcc3:   sbc #$52                    ; 3DCC3:  e9 52
b15_dcc5:   dex                         ; 3DCC5:  ca
b15_dcc6:   .db vm_sp_lo                     ; 3DCC6:  02
b15_dcc7:   .db $d2                     ; 3DCC7:  d2
b15_dcc8:   rol a                       ; 3DCC8:  2a
b15_dcc9:   and $8c0b,y                 ; 3DCC9:  39 0b 8c
b15_dccc:   bmi $dcc7                   ; 3DCCC:  30 f9
b15_dcce:   .db $bb                     ; 3DCCE:  bb
b15_dccf:   .db $d3                     ; 3DCCF:  d3
b15_dcd0:   .db $d4                     ; 3DCD0:  d4
b15_dcd1:   ora #$d0                    ; 3DCD1:  09 d0
b15_dcd3:   and #$b3                    ; 3DCD3:  29 b3
b15_dcd5:   .db $0b                     ; 3DCD5:  0b
b15_dcd6:   bne $dd03                   ; 3DCD6:  d0 2b
b15_dcd8:   sty $f930                   ; 3DCD8:  8c 30 f9
b15_dcdb:   .db $bb                     ; 3DCDB:  bb
b15_dcdc:   .db $d3                     ; 3DCDC:  d3
b15_dcdd:   .db $d4                     ; 3DCDD:  d4
b15_dcde:   ora #$d0                    ; 3DCDE:  09 d0
b15_dce0:   and #$b3                    ; 3DCE0:  29 b3
b15_dce2:   asl a                       ; 3DCE2:  0a
b15_dce3:   sty $f95d                   ; 3DCE3:  8c 5d f9
b15_dce6:   .db $bb                     ; 3DCE6:  bb
b15_dce7:   .db $d3                     ; 3DCE7:  d3
b15_dce8:   .db $d4                     ; 3DCE8:  d4
b15_dce9:   ora #$d0                    ; 3DCE9:  09 d0
b15_dceb:   and #$b3                    ; 3DCEB:  29 b3
b15_dced:   asl a                       ; 3DCED:  0a
b15_dcee:   bne $dd1a                   ; 3DCEE:  d0 2a
b15_dcf0:   sty $f95d                   ; 3DCF0:  8c 5d f9
b15_dcf3:   .db $bb                     ; 3DCF3:  bb
b15_dcf4:   .db $d3                     ; 3DCF4:  d3
b15_dcf5:   .db $d4                     ; 3DCF5:  d4
b15_dcf6:   ora #$d0                    ; 3DCF6:  09 d0
b15_dcf8:   and #$b3                    ; 3DCF8:  29 b3
b15_dcfa:   rti                         ; 3DCFA:  40
b15_dcfb:   .db $d4                     ; 3DCFB:  d4
b15_dcfc:   rti                         ; 3DCFC:  40
b15_dcfd:   plp                         ; 3DCFD:  28
b15_dcfe:   rti                         ; 3DCFE:  40
b15_dcff:   dec ppu_queue_a_lo,x                   ; 3DCFF:  d6 1c
b15_dd01:   cmp $590b,x                 ; 3DD01:  dd 0b 59
b15_dd04:   lda $8c,x                   ; 3DD04:  b5 8c
b15_dd06:   tay                         ; 3DD06:  a8
b15_dd07:   .db $77                     ; 3DD07:  77
b15_dd08:   .db $bb                     ; 3DD08:  bb
b15_dd09:   .db $b3                     ; 3DD09:  b3
b15_dd0a:   dec $fff3,x                 ; 3DD0A:  de f3 ff
b15_dd0d:   .db $b3                     ; 3DD0D:  b3
b15_dd0e:   sbc #$b0                    ; 3DD0E:  e9 b0
b15_dd10:   dex                         ; 3DD10:  ca
b15_dd11:   .db vm_fp_lo                     ; 3DD11:  04
b15_dd12:   .db $d7                     ; 3DD12:  d7
b15_dd13:   .db $1a                     ; 3DD13:  1a
b15_dd14:   cmp $2841,x                 ; 3DD14:  dd 41 28
b15_dd17:   dec $25,x                   ; 3DD17:  d6 25
b15_dd19:   cmp $d00b,x                 ; 3DD19:  dd 0b d0
b15_dd1c:   .db $2b                     ; 3DD1C:  2b
b15_dd1d:   .db $0b                     ; 3DD1D:  0b
b15_dd1e:   ldx $9d                     ; 3DD1E:  a6 9d
b15_dd20:   adc $d7c6                   ; 3DD20:  6d c6 d7
b15_dd23:   .db vm_sp_lo                     ; 3DD23:  02
b15_dd24:   cmp $d708,x                 ; 3DD24:  dd 08 d7
b15_dd27:   .db $b7                     ; 3DD27:  b7
b15_dd28:   .db $dc                     ; 3DD28:  dc
b15_dd29:   dec $fff3,x                 ; 3DD29:  de f3 ff
b15_dd2c:   .db $b3                     ; 3DD2C:  b3
b15_dd2d:   .db $0c                     ; 3DD2D:  0c
b15_dd2e:   eor $8cb5,y                 ; 3DD2E:  59 b5 8c
b15_dd31:   tay                         ; 3DD31:  a8
b15_dd32:   .db $77                     ; 3DD32:  77
b15_dd33:   .db $bb                     ; 3DD33:  bb
b15_dd34:   .db $b3                     ; 3DD34:  b3
b15_dd35:   sbc #$d9                    ; 3DD35:  e9 d9
b15_dd37:   dex                         ; 3DD37:  ca
b15_dd38:   .db vm_fp_lo                     ; 3DD38:  04
b15_dd39:   .db $cf                     ; 3DD39:  cf
filter_province_list_by_owner:   jsr $e823                   ; 3DD3A:  20 23 e8
b15_dd3d:   .db $f4                     ; 3DD3D:  f4
b15_dd3e:   .db $ff                     ; 3DD3E:  ff
b15_dd3f:   dec $fff8,x                 ; 3DD3F:  de f8 ff
b15_dd42:   rol $0d                     ; 3DD42:  26 0d
b15_dd44:   dec brk_scratch_hi,x                   ; 3DD44:  d6 67
b15_dd46:   cmp $d307,x                 ; 3DD46:  dd 07 d3
b15_dd49:   .db $b3                     ; 3DD49:  b3
b15_dd4a:   sbc #$b7                    ; 3DD4A:  e9 b7
b15_dd4c:   cmp $1c02,y                 ; 3DD4C:  d9 02 1c
b15_dd4f:   .db $dc                     ; 3DD4F:  dc
b15_dd50:   .db $d7                     ; 3DD50:  d7
b15_dd51:   adc $dd                     ; 3DD51:  65 dd
b15_dd53:   .db vm_ip_hi                     ; 3DD53:  07
b15_dd54:   .db $d3                     ; 3DD54:  d3
b15_dd55:   .db $b3                     ; 3DD55:  b3
b15_dd56:   sbc #$99                    ; 3DD56:  e9 99
b15_dd58:   cmp $d702,y                 ; 3DD58:  d9 02 d7
b15_dd5b:   adc $dd                     ; 3DD5B:  65 dd
b15_dd5d:   asl $d0                     ; 3DD5D:  06 d0
b15_dd5f:   rol $d1                     ; 3DD5F:  26 d1
b15_dd61:   .db $b3                     ; 3DD61:  b3
b15_dd62:   .db vm_ip_hi                     ; 3DD62:  07
b15_dd63:   .db $d3                     ; 3DD63:  d3
b15_dd64:   .db $d4                     ; 3DD64:  d4
b15_dd65:   .db vm_ip_hi                     ; 3DD65:  07
b15_dd66:   bne $dd8f                   ; 3DD66:  d0 27
b15_dd68:   .db vm_ip_hi                     ; 3DD68:  07
b15_dd69:   .db $d3                     ; 3DD69:  d3
b15_dd6a:   sty $00ff                   ; 3DD6A:  8c ff 00
b15_dd6d:   cmp ($d7,x)                 ; 3DD6D:  c1 d7
b15_dd6f:   .db $47                     ; 3DD6F:  47
b15_dd70:   cmp $8936,x                 ; 3DD70:  dd 36 89
b15_dd73:   .db $ff                     ; 3DD73:  ff
b15_dd74:   .db $d4                     ; 3DD74:  d4
b15_dd75:   pla                         ; 3DD75:  68
b15_dd76:   and $f8de,x                 ; 3DD76:  3d de f8
b15_dd79:   .db $ff                     ; 3DD79:  ff
b15_dd7a:   .db $b3                     ; 3DD7A:  b3
b15_dd7b:   rts                         ; 3DD7B:  60
b15_dd7c:   sbc #$bd                    ; 3DD7C:  e9 bd
b15_dd7e:   .db $cb                     ; 3DD7E:  cb
b15_dd7f:   php                         ; 3DD7F:  08
b15_dd80:   .db $cf                     ; 3DD80:  cf
init_new_daimyo_province_stats:   jsr $e823                   ; 3DD81:  20 23 e8
b15_dd84:   sed                         ; 3DD84:  f8
b15_dd85:   .db $ff                     ; 3DD85:  ff
b15_dd86:   .db $3c                     ; 3DD86:  3c
b15_dd87:   sbc #$da                    ; 3DD87:  e9 da
b15_dd89:   .db $d7                     ; 3DD89:  d7
b15_dd8a:   .db vm_sp_lo                     ; 3DD8A:  02
b15_dd8b:   .db $b3                     ; 3DD8B:  b3
b15_dd8c:   sta $e914                   ; 3DD8C:  8d 14 e9
b15_dd8f:   .db $52                     ; 3DD8F:  52
b15_dd90:   dex                         ; 3DD90:  ca
b15_dd91:   .db vm_sp_lo                     ; 3DD91:  02
b15_dd92:   .db $8f                     ; 3DD92:  8f
b15_dd93:   .db $14                     ; 3DD93:  14
b15_dd94:   .db $d4                     ; 3DD94:  d4
b15_dd95:   .db $3c                     ; 3DD95:  3c
b15_dd96:   sbc #$da                    ; 3DD96:  e9 da
b15_dd98:   .db $d7                     ; 3DD98:  d7
b15_dd99:   .db vm_sp_lo                     ; 3DD99:  02
b15_dd9a:   bne $ddc6                   ; 3DD9A:  d0 2a
b15_dd9c:   dec $c8,x                   ; 3DD9C:  d6 c8
b15_dd9e:   cmp $8d3b,x                 ; 3DD9E:  dd 3b 8d
b15_dda1:   .db $14                     ; 3DDA1:  14
b15_dda2:   sbc #$52                    ; 3DDA2:  e9 52
b15_dda4:   dex                         ; 3DDA4:  ca
b15_dda5:   .db vm_sp_lo                     ; 3DDA5:  02
b15_dda6:   .db $8f                     ; 3DDA6:  8f
b15_dda7:   .db $32                     ; 3DDA7:  32
b15_dda8:   .db $b3                     ; 3DDA8:  b3
b15_dda9:   .db $0b                     ; 3DDA9:  0b
b15_ddaa:   .db $d3                     ; 3DDAA:  d3
b15_ddab:   .db $b3                     ; 3DDAB:  b3
b15_ddac:   sbc #$0d                    ; 3DDAC:  e9 0d
b15_ddae:   .db $d7                     ; 3DDAE:  d7
b15_ddaf:   .db vm_fp_lo                     ; 3DDAF:  04
b15_ddb0:   .db $d4                     ; 3DDB0:  d4
b15_ddb1:   .db $0b                     ; 3DDB1:  0b
b15_ddb2:   .db $d3                     ; 3DDB2:  d3
b15_ddb3:   .db $8b                     ; 3DDB3:  8b
b15_ddb4:   asl $d8c2,x                 ; 3DDB4:  1e c2 d8
b15_ddb7:   ldx $89dd,y                 ; 3DDB7:  be dd 89
b15_ddba:   asl $bfd6,x                 ; 3DDBA:  1e d6 bf
b15_ddbd:   cmp $b340,x                 ; 3DDBD:  dd 40 b3
b15_ddc0:   .db $0b                     ; 3DDC0:  0b
b15_ddc1:   ldy $b3,x                   ; 3DDC1:  b4 b3
b15_ddc3:   .db $d3                     ; 3DDC3:  d3
b15_ddc4:   .db $bb                     ; 3DDC4:  bb
b15_ddc5:   .db $d4                     ; 3DDC5:  d4
b15_ddc6:   .db $0b                     ; 3DDC6:  0b
b15_ddc7:   bne $ddf4                   ; 3DDC7:  d0 2b
b15_ddc9:   asl a                       ; 3DDC9:  0a
b15_ddca:   .db palette_dirty                     ; 3DDCA:  74
b15_ddcb:   .db $b3                     ; 3DDCB:  b3
b15_ddcc:   .db $0b                     ; 3DDCC:  0b
b15_ddcd:   ldy $c7,x                   ; 3DDCD:  b4 c7
b15_ddcf:   .db $d7                     ; 3DDCF:  d7
b15_ddd0:   .db $9f                     ; 3DDD0:  9f
b15_ddd1:   cmp $8b0c,x                 ; 3DDD1:  dd 0c 8b
b15_ddd4:   .db $1a                     ; 3DDD4:  1a
b15_ddd5:   lda $8c,x                   ; 3DDD5:  b5 8c
b15_ddd7:   ora ($70,x)                 ; 3DDD7:  01 70
b15_ddd9:   .db $bb                     ; 3DDD9:  bb
b15_ddda:   plp                         ; 3DDDA:  28
b15_dddb:   dec $45,x                   ; 3DDDB:  d6 45
b15_dddd:   dec $8b0c,x                 ; 3DDDD:  de 0c 8b
b15_dde0:   .db $1a                     ; 3DDE0:  1a
b15_dde1:   lda $8c,x                   ; 3DDE1:  b5 8c
b15_dde3:   .db $17                     ; 3DDE3:  17
b15_dde4:   bvs $dda1                   ; 3DDE4:  70 bb
b15_dde6:   ora $d8c0,y                 ; 3DDE6:  19 c0 d8
b15_dde9:   asl a                       ; 3DDE9:  0a
b15_ddea:   dec $8d39,x                 ; 3DDEA:  de 39 8d
b15_dded:   .db ppu_queue_b_hi                     ; 3DDED:  1f
b15_ddee:   sbc #$52                    ; 3DDEE:  e9 52
b15_ddf0:   dex                         ; 3DDF0:  ca
b15_ddf1:   .db vm_sp_lo                     ; 3DDF1:  02
b15_ddf2:   .db $8f                     ; 3DDF2:  8f
b15_ddf3:   .db $32                     ; 3DDF3:  32
b15_ddf4:   .db $b3                     ; 3DDF4:  b3
b15_ddf5:   ora #$b0                    ; 3DDF5:  09 b0
b15_ddf7:   .db $b3                     ; 3DDF7:  b3
b15_ddf8:   sbc #$0d                    ; 3DDF8:  e9 0d
b15_ddfa:   .db $d7                     ; 3DDFA:  d7
b15_ddfb:   .db vm_fp_lo                     ; 3DDFB:  04
b15_ddfc:   lda ($09),y                 ; 3DDFC:  b1 09
b15_ddfe:   bcs $dd8b                   ; 3DDFE:  b0 8b
b15_de00:   .db $32                     ; 3DE00:  32
b15_de01:   .db $c2                     ; 3DE01:  c2
b15_de02:   cld                         ; 3DE02:  d8
b15_de03:   .db $3b                     ; 3DE03:  3b
b15_de04:   dec $3289,x                 ; 3DE04:  de 89 32
b15_de07:   dec $3c,x                   ; 3DE07:  d6 3c
b15_de09:   dec $0c39,x                 ; 3DE09:  de 39 0c
b15_de0c:   sty fief_is_daimyo_capital                   ; 3DE0C:  8c a2 6d
b15_de0f:   .db $bb                     ; 3DE0F:  bb
b15_de10:   .db $d3                     ; 3DE10:  d3
b15_de11:   cld                         ; 3DE11:  d8
b15_de12:   .db ppu_queue_b_hi                     ; 3DE12:  1f
b15_de13:   dec $148d,x                 ; 3DE13:  de 8d 14
b15_de16:   sbc #$52                    ; 3DE16:  e9 52
b15_de18:   dex                         ; 3DE18:  ca
b15_de19:   .db vm_sp_lo                     ; 3DE19:  02
b15_de1a:   .db $8f                     ; 3DE1A:  8f
b15_de1b:   .db $32                     ; 3DE1B:  32
b15_de1c:   dec $27,x                   ; 3DE1C:  d6 27
b15_de1e:   dec $1e8d,x                 ; 3DE1E:  de 8d 1e
b15_de21:   sbc #$52                    ; 3DE21:  e9 52
b15_de23:   dex                         ; 3DE23:  ca
b15_de24:   .db vm_sp_lo                     ; 3DE24:  02
b15_de25:   .db $8f                     ; 3DE25:  8f
b15_de26:   asl $09b3,x                 ; 3DE26:  1e b3 09
b15_de29:   bcs $ddde                   ; 3DE29:  b0 b3
b15_de2b:   sbc #$0d                    ; 3DE2B:  e9 0d
b15_de2d:   .db $d7                     ; 3DE2D:  d7
b15_de2e:   .db vm_fp_lo                     ; 3DE2E:  04
b15_de2f:   lda ($09),y                 ; 3DE2F:  b1 09
b15_de31:   bcs $de8d                   ; 3DE31:  b0 5a
b15_de33:   .db $c2                     ; 3DE33:  c2
b15_de34:   cld                         ; 3DE34:  d8
b15_de35:   .db $3b                     ; 3DE35:  3b
b15_de36:   dec $d64a,x                 ; 3DE36:  de 4a d6
b15_de39:   .db $3c                     ; 3DE39:  3c
b15_de3a:   dec $b340,x                 ; 3DE3A:  de 40 b3
b15_de3d:   ora #$b4                    ; 3DE3D:  09 b4
b15_de3f:   .db $b3                     ; 3DE3F:  b3
b15_de40:   bcs $ddfd                   ; 3DE40:  b0 bb
b15_de42:   lda ($09),y                 ; 3DE42:  b1 09
b15_de44:   .db ppumask_shadow                     ; 3DE44:  72
b15_de45:   and #$08                    ; 3DE45:  29 08
b15_de47:   .db $8f                     ; 3DE47:  8f
b15_de48:   clc                         ; 3DE48:  18
b15_de49:   .db $b3                     ; 3DE49:  b3
b15_de4a:   ora #$b4                    ; 3DE4A:  09 b4
b15_de4c:   dec $d7                     ; 3DE4C:  c6 d7
b15_de4e:   dec $8ddd,x                 ; 3DE4E:  de dd 8d
b15_de51:   .db $32                     ; 3DE51:  32
b15_de52:   .db $0c                     ; 3DE52:  0c
b15_de53:   .db $8b                     ; 3DE53:  8b
b15_de54:   .db $1a                     ; 3DE54:  1a
b15_de55:   lda $8c,x                   ; 3DE55:  b5 8c
b15_de57:   ora $bb70                   ; 3DE57:  0d 70 bb
b15_de5a:   ldy $b3,x                   ; 3DE5A:  b4 b3
b15_de5c:   bcs $de19                   ; 3DE5C:  b0 bb
b15_de5e:   lda ($8d),y                 ; 3DE5E:  b1 8d
b15_de60:   .db $32                     ; 3DE60:  32
b15_de61:   .db $0c                     ; 3DE61:  0c
b15_de62:   .db $8b                     ; 3DE62:  8b
b15_de63:   .db $1a                     ; 3DE63:  1a
b15_de64:   lda $8c,x                   ; 3DE64:  b5 8c
b15_de66:   .db $13                     ; 3DE66:  13
b15_de67:   bvs $de24                   ; 3DE67:  70 bb
b15_de69:   ldy $b3,x                   ; 3DE69:  b4 b3
b15_de6b:   bcs $de28                   ; 3DE6B:  b0 bb
b15_de6d:   lda ($0c),y                 ; 3DE6D:  b1 0c
b15_de6f:   sty fief_tax_rate                   ; 3DE6F:  8c 2d 6d
b15_de72:   .db $bb                     ; 3DE72:  bb
b15_de73:   .db $b3                     ; 3DE73:  b3
b15_de74:   .db skip_wallclock                     ; 3DE74:  89
b15_de75:   .db $14                     ; 3DE75:  14
b15_de76:   .db $d4                     ; 3DE76:  d4
b15_de77:   .db $cf                     ; 3DE77:  cf
select_uprising_message:   jsr $e823                   ; 3DE78:  20 23 e8
b15_de7b:   inc $a5ff,x                 ; 3DE7B:  fe ff a5
b15_de7e:   lda ($6d,x)                 ; 3DE7E:  a1 6d
b15_de80:   .db $8b                     ; 3DE80:  8b
b15_de81:   jsr $d8da                   ; 3DE81:  20 da d8
b15_de84:   txa                         ; 3DE84:  8a
b15_de85:   dec $2e8a,x                 ; 3DE85:  de 8a 2e
b15_de88:   .db $f7                     ; 3DE88:  f7
b15_de89:   .db $cf                     ; 3DE89:  cf
b15_de8a:   lda $a1                     ; 3DE8A:  a5 a1
b15_de8c:   adc $108b                   ; 3DE8C:  6d 8b 10
b15_de8f:   .db $da                     ; 3DE8F:  da
b15_de90:   cld                         ; 3DE90:  d8
b15_de91:   .db $97                     ; 3DE91:  97
b15_de92:   dec $6a8a,x                 ; 3DE92:  de 8a 6a
b15_de95:   adc $0ccf,y                 ; 3DE95:  79 cf 0c
b15_de98:   cmp vm_fp_lo,y                 ; 3DE98:  d9 04 00
b15_de9b:   .db vm_ip_hi                     ; 3DE9B:  07
b15_de9c:   brk                         ; 3DE9C:  00
b15_de9d:   lda $0dde                   ; 3DE9D:  ad de 0d
b15_dea0:   brk                         ; 3DEA0:  00
b15_dea1:   .db $b3                     ; 3DEA1:  b3
b15_dea2:   dec $0017,x                 ; 3DEA2:  de 17 00
b15_dea5:   lda $1ede                   ; 3DEA5:  ad de 1e
b15_dea8:   brk                         ; 3DEA8:  00
b15_dea9:   .db $b3                     ; 3DEA9:  b3
b15_deaa:   dec $deb9,x                 ; 3DEAA:  de b9 de
b15_dead:   txa                         ; 3DEAD:  8a
b15_deae:   jsr $2bf7                   ; 3DEAE:  20 f7 2b
b15_deb1:   .db $0b                     ; 3DEB1:  0b
b15_deb2:   .db $cf                     ; 3DEB2:  cf
b15_deb3:   txa                         ; 3DEB3:  8a
b15_deb4:   plp                         ; 3DEB4:  28
b15_deb5:   .db $f7                     ; 3DEB5:  f7
b15_deb6:   dec nmi_skip_all,x                   ; 3DEB6:  d6 b0
b15_deb8:   dec $e93c,x                 ; 3DEB8:  de 3c e9
b15_debb:   .db $f7                     ; 3DEBB:  f7
b15_debc:   cmp $d602,y                 ; 3DEBC:  d9 02 d6
b15_debf:   bcs $de9f                   ; 3DEBF:  b0 de
reassign_fiefs_to_conqueror:   jsr $e823                   ; 3DEC1:  20 23 e8
b15_dec4:   sed                         ; 3DEC4:  f8
b15_dec5:   .db $ff                     ; 3DEC5:  ff
b15_dec6:   ldy $57                     ; 3DEC6:  a4 57
b15_dec8:   .db p2_buttons                     ; 3DEC8:  6f
b15_dec9:   ldx $63                     ; 3DEC9:  a6 63
b15_decb:   .db p2_buttons                     ; 3DECB:  6f
b15_decc:   cpy #$d8                    ; 3DECC:  c0 d8
b15_dece:   dec $de,x                   ; 3DECE:  d6 de
b15_ded0:   ldy $5f                     ; 3DED0:  a4 5f
b15_ded2:   .db p2_buttons                     ; 3DED2:  6f
b15_ded3:   dec $d9,x                   ; 3DED3:  d6 d9
b15_ded5:   dec $63a4,x                 ; 3DED5:  de a4 63
b15_ded8:   .db p2_buttons                     ; 3DED8:  6f
b15_ded9:   plp                         ; 3DED9:  28
b15_deda:   .db $b3                     ; 3DEDA:  b3
b15_dedb:   sbc #$72                    ; 3DEDB:  e9 72
b15_dedd:   .db $d7                     ; 3DEDD:  d7
b15_dede:   .db vm_sp_lo                     ; 3DEDE:  02
b15_dedf:   rol a                       ; 3DEDF:  2a
b15_dee0:   tax                         ; 3DEE0:  aa
b15_dee1:   .db $57                     ; 3DEE1:  57
b15_dee2:   .db p2_buttons                     ; 3DEE2:  6f
b15_dee3:   sbc #$72                    ; 3DEE3:  e9 72
b15_dee5:   .db $d7                     ; 3DEE5:  d7
b15_dee6:   .db vm_sp_lo                     ; 3DEE6:  02
b15_dee7:   and #$b3                    ; 3DEE7:  29 b3
b15_dee9:   sbc #$0e                    ; 3DEE9:  e9 0e
b15_deeb:   .db $dc                     ; 3DEEB:  dc
b15_deec:   .db vm_sp_lo                     ; 3DEEC:  02
b15_deed:   and $3ce9,y                 ; 3DEED:  39 e9 3c
b15_def0:   .db $dc                     ; 3DEF0:  dc
b15_def1:   .db vm_sp_lo                     ; 3DEF1:  02
b15_def2:   rti                         ; 3DEF2:  40
b15_def3:   dec $33,x                   ; 3DEF3:  d6 33
b15_def5:   .db $df                     ; 3DEF5:  df
b15_def6:   .db $3b                     ; 3DEF6:  3b
b15_def7:   sbc #$72                    ; 3DEF7:  e9 72
b15_def9:   .db $d7                     ; 3DEF9:  d7
b15_defa:   .db vm_sp_lo                     ; 3DEFA:  02
b15_defb:   ora $d8c0,y                 ; 3DEFB:  19 c0 d8
b15_defe:   and ($df),y                 ; 3DEFE:  31 df
b15_df00:   .db $3b                     ; 3DF00:  3b
b15_df01:   sbc #$99                    ; 3DF01:  e9 99
b15_df03:   cmp $d702,y                 ; 3DF03:  d9 02 d7
b15_df06:   and ($df),y                 ; 3DF06:  31 df
b15_df08:   .db $0b                     ; 3DF08:  0b
b15_df09:   sty fief_to_daimyo_map                   ; 3DF09:  8c 15 6e
b15_df0c:   .db $bb                     ; 3DF0C:  bb
b15_df0d:   .db $b3                     ; 3DF0D:  b3
b15_df0e:   asl a                       ; 3DF0E:  0a
b15_df0f:   .db $d4                     ; 3DF0F:  d4
b15_df10:   .db $0b                     ; 3DF10:  0b
b15_df11:   sty fief_is_daimyo_capital                   ; 3DF11:  8c a2 6d
b15_df14:   .db $bb                     ; 3DF14:  bb
b15_df15:   .db $b3                     ; 3DF15:  b3
b15_df16:   rti                         ; 3DF16:  40
b15_df17:   .db $d4                     ; 3DF17:  d4
b15_df18:   .db $0b                     ; 3DF18:  0b
b15_df19:   sty province_ai_state                   ; 3DF19:  8c f7 6c
b15_df1c:   .db $bb                     ; 3DF1C:  bb
b15_df1d:   .db $b3                     ; 3DF1D:  b3
b15_df1e:   sec                         ; 3DF1E:  38
b15_df1f:   sbc #$8d                    ; 3DF1F:  e9 8d
b15_df21:   cmp $d802,y                 ; 3DF21:  d9 02 d8
b15_df24:   rol a                       ; 3DF24:  2a
b15_df25:   .db $df                     ; 3DF25:  df
b15_df26:   eor $d6                     ; 3DF26:  45 d6
b15_df28:   .db $2b                     ; 3DF28:  2b
b15_df29:   .db $df                     ; 3DF29:  df
b15_df2a:   rti                         ; 3DF2A:  40
b15_df2b:   .db $d4                     ; 3DF2B:  d4
b15_df2c:   .db $3b                     ; 3DF2C:  3b
b15_df2d:   sbc #$54                    ; 3DF2D:  e9 54
b15_df2f:   sbc vm_sp_lo                     ; 3DF2F:  e5 02
b15_df31:   .db $0b                     ; 3DF31:  0b
b15_df32:   bne $df5f                   ; 3DF32:  d0 2b
b15_df34:   .db $0b                     ; 3DF34:  0b
b15_df35:   ldx $9d                     ; 3DF35:  a6 9d
b15_df37:   adc $d7c6                   ; 3DF37:  6d c6 d7
b15_df3a:   inc $de,x                   ; 3DF3A:  f6 de
b15_df3c:   .db $cf                     ; 3DF3C:  cf
daimyo_stat_transfer:   jsr $e823                   ; 3DF3D:  20 23 e8
b15_df40:   inc $3cff,x                 ; 3DF40:  fe ff 3c
b15_df43:   sbc #$da                    ; 3DF43:  e9 da
b15_df45:   .db $d7                     ; 3DF45:  d7
b15_df46:   .db vm_sp_lo                     ; 3DF46:  02
b15_df47:   .db $2b                     ; 3DF47:  2b
b15_df48:   .db $0b                     ; 3DF48:  0b
b15_df49:   .db ppumask_shadow                     ; 3DF49:  72
b15_df4a:   .db $b3                     ; 3DF4A:  b3
b15_df4b:   .db $d3                     ; 3DF4B:  d3
b15_df4c:   bne $df22                   ; 3DF4C:  d0 d4
b15_df4e:   .db $0b                     ; 3DF4E:  0b
b15_df4f:   .db palette_dirty                     ; 3DF4F:  74
b15_df50:   .db $b3                     ; 3DF50:  b3
b15_df51:   .db $d3                     ; 3DF51:  d3
b15_df52:   bne $df28                   ; 3DF52:  d0 d4
b15_df54:   .db $0b                     ; 3DF54:  0b
b15_df55:   adc $b3,x                   ; 3DF55:  75 b3
b15_df57:   .db $d3                     ; 3DF57:  d3
b15_df58:   bne $df2e                   ; 3DF58:  d0 d4
b15_df5a:   and $dae9,x                 ; 3DF5A:  3d e9 da
b15_df5d:   .db $d7                     ; 3DF5D:  d7
b15_df5e:   .db vm_sp_lo                     ; 3DF5E:  02
b15_df5f:   .db $2b                     ; 3DF5F:  2b
b15_df60:   .db $0b                     ; 3DF60:  0b
b15_df61:   .db ppumask_shadow                     ; 3DF61:  72
b15_df62:   .db $b3                     ; 3DF62:  b3
b15_df63:   .db $d3                     ; 3DF63:  d3
b15_df64:   cmp ($d4),y                 ; 3DF64:  d1 d4
b15_df66:   .db $0b                     ; 3DF66:  0b
b15_df67:   .db palette_dirty                     ; 3DF67:  74
b15_df68:   .db $b3                     ; 3DF68:  b3
b15_df69:   .db $d3                     ; 3DF69:  d3
b15_df6a:   cmp ($d4),y                 ; 3DF6A:  d1 d4
b15_df6c:   .db $0b                     ; 3DF6C:  0b
b15_df6d:   adc $b3,x                   ; 3DF6D:  75 b3
b15_df6f:   .db $d3                     ; 3DF6F:  d3
b15_df70:   cmp ($d4),y                 ; 3DF70:  d1 d4
b15_df72:   .db $cf                     ; 3DF72:  cf
transfer_force_triplet:   jsr $e823                   ; 3DF73:  20 23 e8
b15_df76:   sed                         ; 3DF76:  f8
b15_df77:   .db $ff                     ; 3DF77:  ff
b15_df78:   ldy $5f                     ; 3DF78:  a4 5f
b15_df7a:   .db p2_buttons                     ; 3DF7A:  6f
b15_df7b:   .db $8b                     ; 3DF7B:  8b
b15_df7c:   .db $1a                     ; 3DF7C:  1a
b15_df7d:   lda $8c,x                   ; 3DF7D:  b5 8c
b15_df7f:   .db $13                     ; 3DF7F:  13
b15_df80:   bvs $df3d                   ; 3DF80:  70 bb
b15_df82:   and #$a4                    ; 3DF82:  29 a4
b15_df84:   .db $63                     ; 3DF84:  63
b15_df85:   .db p2_buttons                     ; 3DF85:  6f
b15_df86:   .db $8b                     ; 3DF86:  8b
b15_df87:   .db $1a                     ; 3DF87:  1a
b15_df88:   lda $8c,x                   ; 3DF88:  b5 8c
b15_df8a:   .db $13                     ; 3DF8A:  13
b15_df8b:   bvs $df48                   ; 3DF8B:  70 bb
b15_df8d:   rol a                       ; 3DF8D:  2a
b15_df8e:   asl a                       ; 3DF8E:  0a
b15_df8f:   ror nmi_skip_all,x                   ; 3DF8F:  76 b0
b15_df91:   .db $2b                     ; 3DF91:  2b
b15_df92:   rti                         ; 3DF92:  40
b15_df93:   plp                         ; 3DF93:  28
b15_df94:   .db $3a                     ; 3DF94:  3a
b15_df95:   .db $3b                     ; 3DF95:  3b
b15_df96:   tax                         ; 3DF96:  aa
b15_df97:   .db $87                     ; 3DF97:  87
b15_df98:   .db p2_buttons                     ; 3DF98:  6f
b15_df99:   tax                         ; 3DF99:  aa
b15_df9a:   sta (p2_buttons,x)                 ; 3DF9A:  81 6f
b15_df9c:   ora #$b0                    ; 3DF9C:  09 b0
b15_df9e:   .db $b3                     ; 3DF9E:  b3
b15_df9f:   asl a                       ; 3DF9F:  0a
b15_dfa0:   bcs $df55                   ; 3DFA0:  b0 b3
b15_dfa2:   sbc #$24                    ; 3DFA2:  e9 24
b15_dfa4:   .db $da                     ; 3DFA4:  da
b15_dfa5:   asl a                       ; 3DFA5:  0a
b15_dfa6:   lda ($08),y                 ; 3DFA6:  b1 08
b15_dfa8:   bne $dfd2                   ; 3DFA8:  d0 28
b15_dfaa:   cmp ($0a),y                 ; 3DFAA:  d1 0a
b15_dfac:   .db ppumask_shadow                     ; 3DFAC:  72
b15_dfad:   rol a                       ; 3DFAD:  2a
b15_dfae:   .db $8f                     ; 3DFAE:  8f
b15_dfaf:   inc $7209,x                 ; 3DFAF:  fe 09 72
b15_dfb2:   and #$8f                    ; 3DFB2:  29 8f
b15_dfb4:   inc $5308,x                 ; 3DFB4:  fe 08 53
b15_dfb7:   dec $d7                     ; 3DFB7:  c6 d7
b15_dfb9:   sty $df,x                   ; 3DFB9:  94 df
b15_dfbb:   .db $cf                     ; 3DFBB:  cf
clamp_field_6d2d_to_30:   jsr $e823                   ; 3DFBC:  20 23 e8
b15_dfbf:   inc $a4ff,x                 ; 3DFBF:  fe ff a4
b15_dfc2:   .db $63                     ; 3DFC2:  63
b15_dfc3:   .db p2_buttons                     ; 3DFC3:  6f
b15_dfc4:   .db $2b                     ; 3DFC4:  2b
b15_dfc5:   rti                         ; 3DFC5:  40
b15_dfc6:   dec $ec,x                   ; 3DFC6:  d6 ec
b15_dfc8:   .db $df                     ; 3DFC8:  df
b15_dfc9:   ldy $db12                   ; 3DFC9:  ac 12 db
b15_dfcc:   cld                         ; 3DFCC:  d8
b15_dfcd:   inx                         ; 3DFCD:  e8
b15_dfce:   .db $df                     ; 3DFCE:  df
b15_dfcf:   ldy $63                     ; 3DFCF:  a4 63
b15_dfd1:   .db p2_buttons                     ; 3DFD1:  6f
b15_dfd2:   sty fief_tax_rate                   ; 3DFD2:  8c 2d 6d
b15_dfd5:   .db $bb                     ; 3DFD5:  bb
b15_dfd6:   .db $d3                     ; 3DFD6:  d3
b15_dfd7:   .db $8b                     ; 3DFD7:  8b
b15_dfd8:   asl $d8c4,x                 ; 3DFD8:  1e c4 d8
b15_dfdb:   inx                         ; 3DFDB:  e8
b15_dfdc:   .db $df                     ; 3DFDC:  df
b15_dfdd:   ldy $63                     ; 3DFDD:  a4 63
b15_dfdf:   .db p2_buttons                     ; 3DFDF:  6f
b15_dfe0:   sty fief_tax_rate                   ; 3DFE0:  8c 2d 6d
b15_dfe3:   .db $bb                     ; 3DFE3:  bb
b15_dfe4:   .db $b3                     ; 3DFE4:  b3
b15_dfe5:   .db skip_wallclock                     ; 3DFE5:  89
b15_dfe6:   asl $a4d4,x                 ; 3DFE6:  1e d4 a4
b15_dfe9:   .db $63                     ; 3DFE9:  63
b15_dfea:   .db p2_buttons                     ; 3DFEA:  6f
b15_dfeb:   bne $df95                   ; 3DFEB:  d0 a8
b15_dfed:   .db $63                     ; 3DFED:  63
b15_dfee:   .db p2_buttons                     ; 3DFEE:  6f
b15_dfef:   ldy $63                     ; 3DFEF:  a4 63
b15_dff1:   .db p2_buttons                     ; 3DFF1:  6f
b15_dff2:   ldx $9d                     ; 3DFF2:  a6 9d
b15_dff4:   adc $d7c6                   ; 3DFF4:  6d c6 d7
b15_dff7:   cmp #$df                    ; 3DFF7:  c9 df
b15_dff9:   .db $0b                     ; 3DFF9:  0b
b15_dffa:   tay                         ; 3DFFA:  a8
b15_dffb:   .db $63                     ; 3DFFB:  63
b15_dffc:   .db p2_buttons                     ; 3DFFC:  6f
b15_dffd:   .db $cf                     ; 3DFFD:  cf
cap_arms_at_index:   jsr $e823                   ; 3DFFE:  20 23 e8
b15_e001:   inc $0dff,x                 ; 3E001:  fe ff 0d
b15_e004:   .db $8f                     ; 3E004:  8f
b15_e005:   asl nmi_skip_all,x                   ; 3E005:  16 b0
b15_e007:   .db $8b                     ; 3E007:  8b
b15_e008:   .db $32                     ; 3E008:  32
b15_e009:   ldx $8f,y                   ; 3E009:  b6 8f
b15_e00b:   .db $14                     ; 3E00B:  14
b15_e00c:   .db $2b                     ; 3E00C:  2b
b15_e00d:   .db $0c                     ; 3E00D:  0c
b15_e00e:   eor $b5,x                   ; 3E00E:  55 b5
b15_e010:   sty $76ab                   ; 3E010:  8c ab 76
b15_e013:   .db $bb                     ; 3E013:  bb
b15_e014:   .db $d3                     ; 3E014:  d3
b15_e015:   .db $1b                     ; 3E015:  1b
b15_e016:   iny                         ; 3E016:  c8
b15_e017:   cld                         ; 3E017:  d8
b15_e018:   .db $3b                     ; 3E018:  3b
b15_e019:   cpx #$0c                    ; 3E019:  e0 0c
b15_e01b:   eor $b5,x                   ; 3E01B:  55 b5
b15_e01d:   sty $76ab                   ; 3E01D:  8c ab 76
b15_e020:   .db $bb                     ; 3E020:  bb
b15_e021:   .db $d3                     ; 3E021:  d3
b15_e022:   .db $1b                     ; 3E022:  1b
b15_e023:   ldy $0cb3,x                 ; 3E023:  bc b3 0c
b15_e026:   eor $b5,x                   ; 3E026:  55 b5
b15_e028:   sty province_unit_type_pct                   ; 3E028:  8c a9 76
b15_e02b:   .db $bb                     ; 3E02B:  bb
b15_e02c:   ldy $b3,x                   ; 3E02C:  b4 b3
b15_e02e:   .db $d3                     ; 3E02E:  d3
b15_e02f:   .db $bb                     ; 3E02F:  bb
b15_e030:   .db $d4                     ; 3E030:  d4
b15_e031:   .db $0c                     ; 3E031:  0c
b15_e032:   eor $b5,x                   ; 3E032:  55 b5
b15_e034:   sty $76ab                   ; 3E034:  8c ab 76
b15_e037:   .db $bb                     ; 3E037:  bb
b15_e038:   .db $b3                     ; 3E038:  b3
b15_e039:   .db $0b                     ; 3E039:  0b
b15_e03a:   .db $d4                     ; 3E03A:  d4
b15_e03b:   .db $cf                     ; 3E03B:  cf
apply_conquest_outcome:   jsr $e823                   ; 3E03C:  20 23 e8
b15_e03f:   .db $f4                     ; 3E03F:  f4
b15_e040:   .db $ff                     ; 3E040:  ff
b15_e041:   tax                         ; 3E041:  aa
b15_e042:   .db $63                     ; 3E042:  63
b15_e043:   .db p2_buttons                     ; 3E043:  6f
b15_e044:   sbc #$36                    ; 3E044:  e9 36
b15_e046:   cld                         ; 3E046:  d8
b15_e047:   .db vm_sp_lo                     ; 3E047:  02
b15_e048:   ldy $63                     ; 3E048:  a4 63
b15_e04a:   .db p2_buttons                     ; 3E04A:  6f
b15_e04b:   .db $8b                     ; 3E04B:  8b
b15_e04c:   .db $1a                     ; 3E04C:  1a
b15_e04d:   lda $8c,x                   ; 3E04D:  b5 8c
b15_e04f:   ora ($70,x)                 ; 3E04F:  01 70
b15_e051:   .db $bb                     ; 3E051:  bb
b15_e052:   rol $a4                     ; 3E052:  26 a4
b15_e054:   .db $5f                     ; 3E054:  5f
b15_e055:   .db p2_buttons                     ; 3E055:  6f
b15_e056:   .db $8b                     ; 3E056:  8b
b15_e057:   .db $32                     ; 3E057:  32
b15_e058:   cpy #$28                    ; 3E058:  c0 28
b15_e05a:   ldy $57                     ; 3E05A:  a4 57
b15_e05c:   .db p2_buttons                     ; 3E05C:  6f
b15_e05d:   ldx $63                     ; 3E05D:  a6 63
b15_e05f:   .db p2_buttons                     ; 3E05F:  6f
b15_e060:   cpy #$29                    ; 3E060:  c0 29
b15_e062:   ora #$d8                    ; 3E062:  09 d8
b15_e064:   .db skip_vblank_wait                     ; 3E064:  80
b15_e065:   cpx #$65                    ; 3E065:  e0 65
b15_e067:   ldy $63                     ; 3E067:  a4 63
b15_e069:   .db p2_buttons                     ; 3E069:  6f
b15_e06a:   eor $b5,x                   ; 3E06A:  55 b5
b15_e06c:   sty province_unit_type_pct                   ; 3E06C:  8c a9 76
b15_e06f:   .db $bb                     ; 3E06F:  bb
b15_e070:   .db $b3                     ; 3E070:  b3
b15_e071:   ldy $5f                     ; 3E071:  a4 5f
b15_e073:   .db p2_buttons                     ; 3E073:  6f
b15_e074:   eor $b5,x                   ; 3E074:  55 b5
b15_e076:   sty province_unit_type_pct                   ; 3E076:  8c a9 76
b15_e079:   .db $bb                     ; 3E079:  bb
b15_e07a:   .db $b3                     ; 3E07A:  b3
b15_e07b:   .db $64                     ; 3E07B:  64
b15_e07c:   sbc #$bd                    ; 3E07C:  e9 bd
b15_e07e:   .db $cb                     ; 3E07E:  cb
b15_e07f:   php                         ; 3E07F:  08
b15_e080:   php                         ; 3E080:  08
b15_e081:   .db $d7                     ; 3E081:  d7
b15_e082:   ldx $e0                     ; 3E082:  a6 e0
b15_e084:   ldy $df73                   ; 3E084:  ac 73 df
b15_e087:   rol $aa,x                   ; 3E087:  36 aa
b15_e089:   .db $63                     ; 3E089:  63
b15_e08a:   .db p2_buttons                     ; 3E08A:  6f
b15_e08b:   sbc #$fe                    ; 3E08B:  e9 fe
b15_e08d:   .db $df                     ; 3E08D:  df
b15_e08e:   .db vm_fp_lo                     ; 3E08E:  04
b15_e08f:   ora #$d8                    ; 3E08F:  09 d8
b15_e091:   .db $9c                     ; 3E091:  9c
b15_e092:   cpx #$aa                    ; 3E092:  e0 aa
b15_e094:   .db $63                     ; 3E094:  63
b15_e095:   .db p2_buttons                     ; 3E095:  6f
b15_e096:   tax                         ; 3E096:  aa
b15_e097:   .db $5f                     ; 3E097:  5f
b15_e098:   .db p2_buttons                     ; 3E098:  6f
b15_e099:   dec $a2,x                   ; 3E099:  d6 a2
b15_e09b:   cpx #$aa                    ; 3E09B:  e0 aa
b15_e09d:   .db $5f                     ; 3E09D:  5f
b15_e09e:   .db p2_buttons                     ; 3E09E:  6f
b15_e09f:   tax                         ; 3E09F:  aa
b15_e0a0:   .db $63                     ; 3E0A0:  63
b15_e0a1:   .db p2_buttons                     ; 3E0A1:  6f
b15_e0a2:   sbc #$3d                    ; 3E0A2:  e9 3d
b15_e0a4:   .db $df                     ; 3E0A4:  df
b15_e0a5:   .db vm_fp_lo                     ; 3E0A5:  04
b15_e0a6:   lda $a1                     ; 3E0A6:  a5 a1
b15_e0a8:   adc $208b                   ; 3E0A8:  6d 8b 20
b15_e0ab:   .db $da                     ; 3E0AB:  da
b15_e0ac:   .db $d7                     ; 3E0AC:  d7
b15_e0ad:   .db $b3                     ; 3E0AD:  b3
b15_e0ae:   cpx #$08                    ; 3E0AE:  e0 08
b15_e0b0:   .db $d7                     ; 3E0B0:  d7
b15_e0b1:   .db $b7                     ; 3E0B1:  b7
b15_e0b2:   cpx #$40                    ; 3E0B2:  e0 40
b15_e0b4:   dec $b8,x                   ; 3E0B4:  d6 b8
b15_e0b6:   cpx #$41                    ; 3E0B6:  e0 41
b15_e0b8:   .db $27                     ; 3E0B8:  27
b15_e0b9:   .db vm_ip_hi                     ; 3E0B9:  07
b15_e0ba:   cld                         ; 3E0BA:  d8
b15_e0bb:   .db $cb                     ; 3E0BB:  cb
b15_e0bc:   cpx #$09                    ; 3E0BC:  e0 09
b15_e0be:   .db $d7                     ; 3E0BE:  d7
b15_e0bf:   .db $cb                     ; 3E0BF:  cb
b15_e0c0:   cpx #$40                    ; 3E0C0:  e0 40
b15_e0c2:   tay                         ; 3E0C2:  a8
b15_e0c3:   sta (p2_buttons,x)                 ; 3E0C3:  81 6f
b15_e0c5:   tay                         ; 3E0C5:  a8
b15_e0c6:   .db $7f                     ; 3E0C6:  7f
b15_e0c7:   .db p2_buttons                     ; 3E0C7:  6f
b15_e0c8:   tay                         ; 3E0C8:  a8
b15_e0c9:   adc $366f,x                 ; 3E0C9:  7d 6f 36
b15_e0cc:   ldy $7d                     ; 3E0CC:  a4 7d
b15_e0ce:   .db p2_buttons                     ; 3E0CE:  6f
b15_e0cf:   ldx clock_a_hi                     ; 3E0CF:  a6 83
b15_e0d1:   .db p2_buttons                     ; 3E0D1:  6f
b15_e0d2:   .db $bb                     ; 3E0D2:  bb
b15_e0d3:   lda (vm_ip_lo),y                 ; 3E0D3:  b1 06
b15_e0d5:   ror $b3,x                   ; 3E0D5:  76 b3
b15_e0d7:   ldy $7f                     ; 3E0D7:  a4 7f
b15_e0d9:   .db p2_buttons                     ; 3E0D9:  6f
b15_e0da:   ldx clock_b_hi                     ; 3E0DA:  a6 85
b15_e0dc:   .db p2_buttons                     ; 3E0DC:  6f
b15_e0dd:   .db $bb                     ; 3E0DD:  bb
b15_e0de:   lda (vm_ip_lo),y                 ; 3E0DE:  b1 06
b15_e0e0:   .db $8f                     ; 3E0E0:  8f
b15_e0e1:   bpl $e096                   ; 3E0E1:  10 b3
b15_e0e3:   ldy nmi_busy                     ; 3E0E3:  a4 81
b15_e0e5:   .db p2_buttons                     ; 3E0E5:  6f
b15_e0e6:   ldx $87                     ; 3E0E6:  a6 87
b15_e0e8:   .db p2_buttons                     ; 3E0E8:  6f
b15_e0e9:   .db $bb                     ; 3E0E9:  bb
b15_e0ea:   lda (vm_ip_hi),y                 ; 3E0EA:  b1 07
b15_e0ec:   cld                         ; 3E0EC:  d8
b15_e0ed:   asl $e1                     ; 3E0ED:  06 e1
b15_e0ef:   ror a                       ; 3E0EF:  6a
b15_e0f0:   sbc #$52                    ; 3E0F0:  e9 52
b15_e0f2:   dex                         ; 3E0F2:  ca
b15_e0f3:   .db vm_sp_lo                     ; 3E0F3:  02
b15_e0f4:   .db music_ptr_lo                     ; 3E0F4:  7a
b15_e0f5:   .db $b3                     ; 3E0F5:  b3
b15_e0f6:   asl $78                     ; 3E0F6:  06 78
b15_e0f8:   bcs $e0ad                   ; 3E0F8:  b0 b3
b15_e0fa:   sbc #$0d                    ; 3E0FA:  e9 0d
b15_e0fc:   .db $d7                     ; 3E0FC:  d7
b15_e0fd:   .db vm_fp_lo                     ; 3E0FD:  04
b15_e0fe:   .db $b3                     ; 3E0FE:  b3
b15_e0ff:   asl $78                     ; 3E0FF:  06 78
b15_e101:   ldy $b3,x                   ; 3E101:  b4 b3
b15_e103:   bcs $e0c1                   ; 3E103:  b0 bc
b15_e105:   lda ($a4),y                 ; 3E105:  b1 a4
b15_e107:   .db $63                     ; 3E107:  63
b15_e108:   .db p2_buttons                     ; 3E108:  6f
b15_e109:   sty fief_to_daimyo_map                   ; 3E109:  8c 15 6e
b15_e10c:   .db $bb                     ; 3E10C:  bb
b15_e10d:   rol a                       ; 3E10D:  2a
b15_e10e:   php                         ; 3E10E:  08
b15_e10f:   .db $d7                     ; 3E10F:  d7
b15_e110:   jsr $39e1                   ; 3E110:  20 e1 39
b15_e113:   sbc #$e5                    ; 3E113:  e9 e5
b15_e115:   cmp $d802,y                 ; 3E115:  d9 02 d8
b15_e118:   jsr $ace1                   ; 3E118:  20 e1 ac
b15_e11b:   cmp ($de,x)                 ; 3E11B:  c1 de
b15_e11d:   dec $9c,x                   ; 3E11D:  d6 9c
b15_e11f:   sbc ($09,x)                 ; 3E11F:  e1 09
b15_e121:   cld                         ; 3E121:  d8
b15_e122:   .db $9c                     ; 3E122:  9c
b15_e123:   sbc ($08,x)                 ; 3E123:  e1 08
b15_e125:   cld                         ; 3E125:  d8
b15_e126:   sei                         ; 3E126:  78
b15_e127:   sbc ($a4,x)                 ; 3E127:  e1 a4
b15_e129:   .db $63                     ; 3E129:  63
b15_e12a:   .db p2_buttons                     ; 3E12A:  6f
b15_e12b:   sty fief_is_daimyo_capital                   ; 3E12B:  8c a2 6d
b15_e12e:   .db $bb                     ; 3E12E:  bb
b15_e12f:   .db $d3                     ; 3E12F:  d3
b15_e130:   cld                         ; 3E130:  d8
b15_e131:   ror $0ae1                   ; 3E131:  6e e1 0a
b15_e134:   .db $d3                     ; 3E134:  d3
b15_e135:   .db $b3                     ; 3E135:  b3
b15_e136:   sbc #$0e                    ; 3E136:  e9 0e
b15_e138:   .db $dc                     ; 3E138:  dc
b15_e139:   .db vm_sp_lo                     ; 3E139:  02
b15_e13a:   asl a                       ; 3E13A:  0a
b15_e13b:   .db $d3                     ; 3E13B:  d3
b15_e13c:   .db $b3                     ; 3E13C:  b3
b15_e13d:   sbc #$3c                    ; 3E13D:  e9 3c
b15_e13f:   .db $dc                     ; 3E13F:  dc
b15_e140:   .db vm_sp_lo                     ; 3E140:  02
b15_e141:   rti                         ; 3E141:  40
b15_e142:   dec $65,x                   ; 3E142:  d6 65
b15_e144:   sbc ($0a,x)                 ; 3E144:  e1 0a
b15_e146:   .db $d3                     ; 3E146:  d3
b15_e147:   .db $b3                     ; 3E147:  b3
b15_e148:   .db $3b                     ; 3E148:  3b
b15_e149:   sbc #$72                    ; 3E149:  e9 72
b15_e14b:   .db $d7                     ; 3E14B:  d7
b15_e14c:   .db vm_sp_lo                     ; 3E14C:  02
b15_e14d:   ldy $c0,x                   ; 3E14D:  b4 c0
b15_e14f:   cld                         ; 3E14F:  d8
b15_e150:   .db $63                     ; 3E150:  63
b15_e151:   sbc ($0b,x)                 ; 3E151:  e1 0b
b15_e153:   ldx $63                     ; 3E153:  a6 63
b15_e155:   .db p2_buttons                     ; 3E155:  6f
b15_e156:   cmp ($d8,x)                 ; 3E156:  c1 d8
b15_e158:   .db $63                     ; 3E158:  63
b15_e159:   sbc ($3b,x)                 ; 3E159:  e1 3b
b15_e15b:   sbc #$c8                    ; 3E15B:  e9 c8
b15_e15d:   cmp $b302,y                 ; 3E15D:  d9 02 b3
b15_e160:   .db skip_wallclock                     ; 3E160:  89
b15_e161:   .db $ff                     ; 3E161:  ff
b15_e162:   .db $d4                     ; 3E162:  d4
b15_e163:   .db $0b                     ; 3E163:  0b
b15_e164:   bne $e191                   ; 3E164:  d0 2b
b15_e166:   .db $0b                     ; 3E166:  0b
b15_e167:   ldx $9d                     ; 3E167:  a6 9d
b15_e169:   adc $d7c6                   ; 3E169:  6d c6 d7
b15_e16c:   eor $e1                     ; 3E16C:  45 e1
b15_e16e:   tax                         ; 3E16E:  aa
b15_e16f:   .db $63                     ; 3E16F:  63
b15_e170:   .db p2_buttons                     ; 3E170:  6f
b15_e171:   sbc #$1b                    ; 3E171:  e9 1b
b15_e173:   .db $e2                     ; 3E173:  e2
b15_e174:   .db vm_sp_lo                     ; 3E174:  02
b15_e175:   dec $9c,x                   ; 3E175:  d6 9c
b15_e177:   sbc ($3a,x)                 ; 3E177:  e1 3a
b15_e179:   ldy $d77e                   ; 3E179:  ac 7e d7
b15_e17c:   .db $d4                     ; 3E17C:  d4
b15_e17d:   tax                         ; 3E17D:  aa
b15_e17e:   .db $63                     ; 3E17E:  63
b15_e17f:   .db p2_buttons                     ; 3E17F:  6f
b15_e180:   sbc #$c8                    ; 3E180:  e9 c8
b15_e182:   cmp $b302,y                 ; 3E182:  d9 02 b3
b15_e185:   tax                         ; 3E185:  aa
b15_e186:   .db $5f                     ; 3E186:  5f
b15_e187:   .db p2_buttons                     ; 3E187:  6f
b15_e188:   sbc #$8d                    ; 3E188:  e9 8d
b15_e18a:   cmp $d802,y                 ; 3E18A:  d9 02 d8
b15_e18d:   .db $93                     ; 3E18D:  93
b15_e18e:   sbc ($45,x)                 ; 3E18E:  e1 45
b15_e190:   dec $94,x                   ; 3E190:  d6 94
b15_e192:   sbc ($40,x)                 ; 3E192:  e1 40
b15_e194:   .db $d4                     ; 3E194:  d4
b15_e195:   tax                         ; 3E195:  aa
b15_e196:   .db $63                     ; 3E196:  63
b15_e197:   .db p2_buttons                     ; 3E197:  6f
b15_e198:   sbc #$54                    ; 3E198:  e9 54
b15_e19a:   sbc vm_sp_lo                     ; 3E19A:  e5 02
b15_e19c:   php                         ; 3E19C:  08
b15_e19d:   .db $d7                     ; 3E19D:  d7
b15_e19e:   .db $c7                     ; 3E19E:  c7
b15_e19f:   sbc ($09,x)                 ; 3E19F:  e1 09
b15_e1a1:   cld                         ; 3E1A1:  d8
b15_e1a2:   .db $c7                     ; 3E1A2:  c7
b15_e1a3:   sbc ($a4,x)                 ; 3E1A3:  e1 a4
b15_e1a5:   .db $63                     ; 3E1A5:  63
b15_e1a6:   .db p2_buttons                     ; 3E1A6:  6f
b15_e1a7:   sty fief_is_daimyo_capital                   ; 3E1A7:  8c a2 6d
b15_e1aa:   .db $bb                     ; 3E1AA:  bb
b15_e1ab:   .db $b3                     ; 3E1AB:  b3
b15_e1ac:   lda $65                     ; 3E1AC:  a5 65
b15_e1ae:   .db p2_buttons                     ; 3E1AE:  6f
b15_e1af:   .db $57                     ; 3E1AF:  57
b15_e1b0:   .db $bf                     ; 3E1B0:  bf
b15_e1b1:   .db $d4                     ; 3E1B1:  d4
b15_e1b2:   ldy $63                     ; 3E1B2:  a4 63
b15_e1b4:   .db p2_buttons                     ; 3E1B4:  6f
b15_e1b5:   sty fief_is_daimyo_capital                   ; 3E1B5:  8c a2 6d
b15_e1b8:   .db $bb                     ; 3E1B8:  bb
b15_e1b9:   .db $d3                     ; 3E1B9:  d3
b15_e1ba:   .db $b3                     ; 3E1BA:  b3
b15_e1bb:   ldy $5f                     ; 3E1BB:  a4 5f
b15_e1bd:   .db p2_buttons                     ; 3E1BD:  6f
b15_e1be:   sty fief_is_daimyo_capital                   ; 3E1BE:  8c a2 6d
b15_e1c1:   .db $bb                     ; 3E1C1:  bb
b15_e1c2:   ldy $b3,x                   ; 3E1C2:  b4 b3
b15_e1c4:   .db $d3                     ; 3E1C4:  d3
b15_e1c5:   .db $dc                     ; 3E1C5:  dc
b15_e1c6:   .db $d4                     ; 3E1C6:  d4
b15_e1c7:   .db skip_wallclock                     ; 3E1C7:  89
b15_e1c8:   .db $8f                     ; 3E1C8:  8f
b15_e1c9:   cmp $a1a5                   ; 3E1C9:  cd a5 a1
b15_e1cc:   adc $a9da                   ; 3E1CC:  6d da a9
b15_e1cf:   lda ($6d,x)                 ; 3E1CF:  a1 6d
b15_e1d1:   ldy $dfbc                   ; 3E1D1:  ac bc df
b15_e1d4:   tax                         ; 3E1D4:  aa
b15_e1d5:   .db $63                     ; 3E1D5:  63
b15_e1d6:   .db p2_buttons                     ; 3E1D6:  6f
b15_e1d7:   sbc #$36                    ; 3E1D7:  e9 36
b15_e1d9:   cld                         ; 3E1D9:  d8
b15_e1da:   .db vm_sp_lo                     ; 3E1DA:  02
b15_e1db:   php                         ; 3E1DB:  08
b15_e1dc:   .db $d7                     ; 3E1DC:  d7
b15_e1dd:   inc $e1                     ; 3E1DD:  e6 e1
b15_e1df:   tax                         ; 3E1DF:  aa
b15_e1e0:   .db $5f                     ; 3E1E0:  5f
b15_e1e1:   .db p2_buttons                     ; 3E1E1:  6f
b15_e1e2:   sbc #$36                    ; 3E1E2:  e9 36
b15_e1e4:   cld                         ; 3E1E4:  d8
b15_e1e5:   .db vm_sp_lo                     ; 3E1E5:  02
b15_e1e6:   .db $cf                     ; 3E1E6:  cf
clear_fief_pair_matrix:   jsr $e823                   ; 3E1E7:  20 23 e8
b15_e1ea:   inc $8dff,x                 ; 3E1EA:  fe ff 8d
b15_e1ed:   ora $03e9,x                 ; 3E1ED:  1d e9 03
b15_e1f0:   dex                         ; 3E1F0:  ca
b15_e1f1:   .db vm_sp_lo                     ; 3E1F1:  02
b15_e1f2:   rti                         ; 3E1F2:  40
b15_e1f3:   dec $11,x                   ; 3E1F3:  d6 11
b15_e1f5:   .db $e2                     ; 3E1F5:  e2
b15_e1f6:   .db $0c                     ; 3E1F6:  0c
b15_e1f7:   .db $8b                     ; 3E1F7:  8b
b15_e1f8:   rol $b5,x                   ; 3E1F8:  36 b5
b15_e1fa:   .db $1b                     ; 3E1FA:  1b
b15_e1fb:   .db $bb                     ; 3E1FB:  bb
b15_e1fc:   sty relations_matrix                   ; 3E1FC:  8c 93 61
b15_e1ff:   .db $bb                     ; 3E1FF:  bb
b15_e200:   .db $b3                     ; 3E200:  b3
b15_e201:   .db $0b                     ; 3E201:  0b
b15_e202:   .db $8b                     ; 3E202:  8b
b15_e203:   rol $b5,x                   ; 3E203:  36 b5
b15_e205:   .db ppu_queue_a_lo                     ; 3E205:  1c
b15_e206:   .db $bb                     ; 3E206:  bb
b15_e207:   sty relations_matrix                   ; 3E207:  8c 93 61
b15_e20a:   .db $bb                     ; 3E20A:  bb
b15_e20b:   .db $b3                     ; 3E20B:  b3
b15_e20c:   rti                         ; 3E20C:  40
b15_e20d:   .db $d4                     ; 3E20D:  d4
b15_e20e:   .db $d4                     ; 3E20E:  d4
b15_e20f:   .db $0b                     ; 3E20F:  0b
b15_e210:   bne $e23d                   ; 3E210:  d0 2b
b15_e212:   .db $0b                     ; 3E212:  0b
b15_e213:   ldx $9d                     ; 3E213:  a6 9d
b15_e215:   adc $d7c6                   ; 3E215:  6d c6 d7
b15_e218:   inc $e1,x                   ; 3E218:  f6 e1
b15_e21a:   .db $cf                     ; 3E21A:  cf
install_new_daimyo:   jsr $e823                   ; 3E21B:  20 23 e8
b15_e21e:   brk                         ; 3E21E:  00
b15_e21f:   brk                         ; 3E21F:  00
b15_e220:   .db $0c                     ; 3E220:  0c
b15_e221:   sty fief_to_daimyo_map                   ; 3E221:  8c 15 6e
b15_e224:   .db $bb                     ; 3E224:  bb
b15_e225:   .db $b3                     ; 3E225:  b3
b15_e226:   stx $00ff                   ; 3E226:  8e ff 00
b15_e229:   sbc #$0e                    ; 3E229:  e9 0e
b15_e22b:   .db $dc                     ; 3E22B:  dc
b15_e22c:   .db vm_sp_lo                     ; 3E22C:  02
b15_e22d:   .db $d4                     ; 3E22D:  d4
b15_e22e:   .db $3c                     ; 3E22E:  3c
b15_e22f:   sbc #$72                    ; 3E22F:  e9 72
b15_e231:   .db $d7                     ; 3E231:  d7
b15_e232:   .db vm_sp_lo                     ; 3E232:  02
b15_e233:   .db $b3                     ; 3E233:  b3
b15_e234:   sbc #$b2                    ; 3E234:  e9 b2
b15_e236:   .db $dc                     ; 3E236:  dc
b15_e237:   .db vm_sp_lo                     ; 3E237:  02
b15_e238:   .db $3c                     ; 3E238:  3c
b15_e239:   sbc #$72                    ; 3E239:  e9 72
b15_e23b:   .db $d7                     ; 3E23B:  d7
b15_e23c:   .db vm_sp_lo                     ; 3E23C:  02
b15_e23d:   eor $8cb5,y                 ; 3E23D:  59 b5 8c
b15_e240:   tay                         ; 3E240:  a8
b15_e241:   .db $77                     ; 3E241:  77
b15_e242:   .db $bb                     ; 3E242:  bb
b15_e243:   .db $b3                     ; 3E243:  b3
b15_e244:   sbc #$26                    ; 3E244:  e9 26
b15_e246:   .db $d3                     ; 3E246:  d3
b15_e247:   .db vm_sp_lo                     ; 3E247:  02
b15_e248:   .db $0c                     ; 3E248:  0c
b15_e249:   bne $e1fe                   ; 3E249:  d0 b3
b15_e24b:   stx $f735                   ; 3E24B:  8e 35 f7
b15_e24e:   sbc #$34                    ; 3E24E:  e9 34
b15_e250:   cmp (vm_fp_lo),y                 ; 3E250:  d1 04
b15_e252:   .db $0c                     ; 3E252:  0c
b15_e253:   sty province_ai_state                   ; 3E253:  8c f7 6c
b15_e256:   .db $bb                     ; 3E256:  bb
b15_e257:   .db $b3                     ; 3E257:  b3
b15_e258:   rti                         ; 3E258:  40
b15_e259:   .db $d4                     ; 3E259:  d4
b15_e25a:   .db $0c                     ; 3E25A:  0c
b15_e25b:   sty fief_is_daimyo_capital                   ; 3E25B:  8c a2 6d
b15_e25e:   .db $bb                     ; 3E25E:  bb
b15_e25f:   .db $b3                     ; 3E25F:  b3
b15_e260:   eor ($d4,x)                 ; 3E260:  41 d4
b15_e262:   .db $3c                     ; 3E262:  3c
b15_e263:   sbc #$81                    ; 3E263:  e9 81
b15_e265:   cmp $3c02,x                 ; 3E265:  dd 02 3c
b15_e268:   sbc #$97                    ; 3E268:  e9 97
b15_e26a:   .db $db                     ; 3E26A:  db
b15_e26b:   .db vm_sp_lo                     ; 3E26B:  02
b15_e26c:   .db $3c                     ; 3E26C:  3c
b15_e26d:   sbc #$54                    ; 3E26D:  e9 54
b15_e26f:   sbc vm_sp_lo                     ; 3E26F:  e5 02
b15_e271:   ldy $d766                   ; 3E271:  ac 66 d7
b15_e274:   .db $cf                     ; 3E274:  cf
announce_daimyo_death:   jsr $e823                   ; 3E275:  20 23 e8
b15_e278:   brk                         ; 3E278:  00
b15_e279:   brk                         ; 3E279:  00
b15_e27a:   .db $3c                     ; 3E27A:  3c
b15_e27b:   sbc #$e7                    ; 3E27B:  e9 e7
b15_e27d:   sbc (vm_sp_lo,x)                 ; 3E27D:  e1 02
b15_e27f:   .db $3c                     ; 3E27F:  3c
b15_e280:   sbc #$72                    ; 3E280:  e9 72
b15_e282:   .db $d7                     ; 3E282:  d7
b15_e283:   .db vm_sp_lo                     ; 3E283:  02
b15_e284:   eor $8cb5,y                 ; 3E284:  59 b5 8c
b15_e287:   tay                         ; 3E287:  a8
b15_e288:   .db $77                     ; 3E288:  77
b15_e289:   .db $bb                     ; 3E289:  bb
b15_e28a:   .db $b3                     ; 3E28A:  b3
b15_e28b:   sbc #$26                    ; 3E28B:  e9 26
b15_e28d:   .db $d3                     ; 3E28D:  d3
b15_e28e:   .db vm_sp_lo                     ; 3E28E:  02
b15_e28f:   stx $f74f                   ; 3E28F:  8e 4f f7
b15_e292:   sbc #$c4                    ; 3E292:  e9 c4
b15_e294:   dec $3c02                   ; 3E294:  ce 02 3c
b15_e297:   sbc #$8d                    ; 3E297:  e9 8d
b15_e299:   cmp $d802,y                 ; 3E299:  d9 02 d8
b15_e29c:   .db $ab                     ; 3E29C:  ab
b15_e29d:   .db $e2                     ; 3E29D:  e2
b15_e29e:   tax                         ; 3E29E:  aa
b15_e29f:   .db $9f                     ; 3E29F:  9f
b15_e2a0:   adc $d00c                   ; 3E2A0:  6d 0c d0
b15_e2a3:   .db $b3                     ; 3E2A3:  b3
b15_e2a4:   stx $f75b                   ; 3E2A4:  8e 5b f7
b15_e2a7:   sbc #$34                    ; 3E2A7:  e9 34
b15_e2a9:   cmp (vm_ip_lo),y                 ; 3E2A9:  d1 06
b15_e2ab:   ldy $d766                   ; 3E2AB:  ac 66 d7
b15_e2ae:   .db $cf                     ; 3E2AE:  cf
copy_arms_record_5:   jsr $e823                   ; 3E2AF:  20 23 e8
b15_e2b2:   .db $fc                     ; 3E2B2:  fc
b15_e2b3:   .db $ff                     ; 3E2B3:  ff
b15_e2b4:   rti                         ; 3E2B4:  40
b15_e2b5:   rol a                       ; 3E2B5:  2a
b15_e2b6:   .db $0c                     ; 3E2B6:  0c
b15_e2b7:   eor $b5,x                   ; 3E2B7:  55 b5
b15_e2b9:   sty province_unit_type_pct                   ; 3E2B9:  8c a9 76
b15_e2bc:   .db $bb                     ; 3E2BC:  bb
b15_e2bd:   .db $2b                     ; 3E2BD:  2b
b15_e2be:   dec $cf,x                   ; 3E2BE:  d6 cf
b15_e2c0:   .db $e2                     ; 3E2C0:  e2
b15_e2c1:   .db $0b                     ; 3E2C1:  0b
b15_e2c2:   bne $e2ef                   ; 3E2C2:  d0 2b
b15_e2c4:   cmp ($b3),y                 ; 3E2C4:  d1 b3
b15_e2c6:   ora $2dd0                   ; 3E2C6:  0d d0 2d
b15_e2c9:   cmp ($d3),y                 ; 3E2C9:  d1 d3
b15_e2cb:   .db $d4                     ; 3E2CB:  d4
b15_e2cc:   asl a                       ; 3E2CC:  0a
b15_e2cd:   bne $e2f9                   ; 3E2CD:  d0 2a
b15_e2cf:   asl a                       ; 3E2CF:  0a
b15_e2d0:   eor $c6,x                   ; 3E2D0:  55 c6
b15_e2d2:   .db $d7                     ; 3E2D2:  d7
b15_e2d3:   cmp ($e2,x)                 ; 3E2D3:  c1 e2
b15_e2d5:   .db $cf                     ; 3E2D5:  cf
draw_daimyo_name_menu:   jsr $e823                   ; 3E2D6:  20 23 e8
b15_e2d9:   brk                         ; 3E2D9:  00
b15_e2da:   brk                         ; 3E2DA:  00
b15_e2db:   ldy $cc89                   ; 3E2DB:  ac 89 cc
b15_e2de:   stx $f777                   ; 3E2DE:  8e 77 f7
b15_e2e1:   sbc #$26                    ; 3E2E1:  e9 26
b15_e2e3:   .db $d3                     ; 3E2E3:  d3
b15_e2e4:   .db vm_sp_lo                     ; 3E2E4:  02
b15_e2e5:   tax                         ; 3E2E5:  aa
b15_e2e6:   .db $63                     ; 3E2E6:  63
b15_e2e7:   .db p2_buttons                     ; 3E2E7:  6f
b15_e2e8:   sbc #$72                    ; 3E2E8:  e9 72
b15_e2ea:   .db $d7                     ; 3E2EA:  d7
b15_e2eb:   .db vm_sp_lo                     ; 3E2EB:  02
b15_e2ec:   eor $8cb5,y                 ; 3E2EC:  59 b5 8c
b15_e2ef:   tay                         ; 3E2EF:  a8
b15_e2f0:   .db $77                     ; 3E2F0:  77
b15_e2f1:   .db $bb                     ; 3E2F1:  bb
b15_e2f2:   .db $b3                     ; 3E2F2:  b3
b15_e2f3:   sbc #$c4                    ; 3E2F3:  e9 c4
b15_e2f5:   dec $8e02                   ; 3E2F5:  ce 02 8e
b15_e2f8:   adc $e9f7,x                 ; 3E2F8:  7d f7 e9
b15_e2fb:   cpy $ce                     ; 3E2FB:  c4 ce
b15_e2fd:   .db vm_sp_lo                     ; 3E2FD:  02
b15_e2fe:   ldy $d77e                   ; 3E2FE:  ac 7e d7
b15_e301:   eor $8cb5,y                 ; 3E301:  59 b5 8c
b15_e304:   tay                         ; 3E304:  a8
b15_e305:   .db $77                     ; 3E305:  77
b15_e306:   .db $bb                     ; 3E306:  bb
b15_e307:   .db $b3                     ; 3E307:  b3
b15_e308:   sbc #$c4                    ; 3E308:  e9 c4
b15_e30a:   dec $3c02                   ; 3E30A:  ce 02 3c
b15_e30d:   stx $f77f                   ; 3E30D:  8e 7f f7
b15_e310:   sbc #$34                    ; 3E310:  e9 34
b15_e312:   cmp (vm_fp_lo),y                 ; 3E312:  d1 04
b15_e314:   .db $cf                     ; 3E314:  cf
marriage_pact_handler:   jsr $e823                   ; 3E315:  20 23 e8
b15_e318:   .db $fa                     ; 3E318:  fa
b15_e319:   .db $ff                     ; 3E319:  ff
b15_e31a:   tax                         ; 3E31A:  aa
b15_e31b:   .db $63                     ; 3E31B:  63
b15_e31c:   .db p2_buttons                     ; 3E31C:  6f
b15_e31d:   sbc #$8d                    ; 3E31D:  e9 8d
b15_e31f:   cmp $d802,y                 ; 3E31F:  d9 02 d8
b15_e322:   adc ($e3,x)                 ; 3E322:  61 e3
b15_e324:   ldy $d3                     ; 3E324:  a4 d3
b15_e326:   .db $7f                     ; 3E326:  7f
b15_e327:   and #$42                    ; 3E327:  29 42
b15_e329:   tay                         ; 3E329:  a8
b15_e32a:   .db $d3                     ; 3E32A:  d3
b15_e32b:   .db $7f                     ; 3E32B:  7f
b15_e32c:   stx $f798                   ; 3E32C:  8e 98 f7
b15_e32f:   sbc #$d6                    ; 3E32F:  e9 d6
b15_e331:   .db $e2                     ; 3E331:  e2
b15_e332:   .db vm_sp_lo                     ; 3E332:  02
b15_e333:   stx $f7a6                   ; 3E333:  8e a6 f7
b15_e336:   sbc #$c4                    ; 3E336:  e9 c4
b15_e338:   dec $ac02                   ; 3E338:  ce 02 ac
b15_e33b:   .db $a7                     ; 3E33B:  a7
b15_e33c:   .db $d3                     ; 3E33C:  d3
b15_e33d:   cld                         ; 3E33D:  d8
b15_e33e:   eor $8ee3,y                 ; 3E33E:  59 e3 8e
b15_e341:   sty $e9f7                   ; 3E341:  8c f7 e9
b15_e344:   rol $d3                     ; 3E344:  26 d3
b15_e346:   .db vm_sp_lo                     ; 3E346:  02
b15_e347:   stx $270f                   ; 3E347:  8e 0f 27
b15_e34a:   adc ($e9,x)                 ; 3E34A:  61 e9
b15_e34c:   sbc #$d5                    ; 3E34C:  e9 d5
b15_e34e:   .db vm_fp_lo                     ; 3E34E:  04
b15_e34f:   .db $2b                     ; 3E34F:  2b
b15_e350:   .db $d7                     ; 3E350:  d7
b15_e351:   .db $5b                     ; 3E351:  5b
b15_e352:   .db $e3                     ; 3E352:  e3
b15_e353:   ldy $cc89                   ; 3E353:  ac 89 cc
b15_e356:   dec $5b,x                   ; 3E356:  d6 5b
b15_e358:   .db $e3                     ; 3E358:  e3
b15_e359:   rti                         ; 3E359:  40
b15_e35a:   .db $2b                     ; 3E35A:  2b
b15_e35b:   ora #$a8                    ; 3E35B:  09 a8
b15_e35d:   .db $d3                     ; 3E35D:  d3
b15_e35e:   .db $7f                     ; 3E35E:  7f
b15_e35f:   .db $0b                     ; 3E35F:  0b
b15_e360:   .db $cf                     ; 3E360:  cf
b15_e361:   tax                         ; 3E361:  aa
b15_e362:   .db $63                     ; 3E362:  63
b15_e363:   adc $52e9                   ; 3E363:  6d e9 52
b15_e366:   dex                         ; 3E366:  ca
b15_e367:   .db vm_sp_lo                     ; 3E367:  02
b15_e368:   .db $d7                     ; 3E368:  d7
b15_e369:   ldx #$e3                    ; 3E369:  a2 e3
b15_e36b:   tax                         ; 3E36B:  aa
b15_e36c:   .db $5f                     ; 3E36C:  5f
b15_e36d:   .db p2_buttons                     ; 3E36D:  6f
b15_e36e:   sbc #$72                    ; 3E36E:  e9 72
b15_e370:   cmp $d802,y                 ; 3E370:  d9 02 d8
b15_e373:   adc $63e3,x                 ; 3E373:  7d e3 63
b15_e376:   sbc #$52                    ; 3E376:  e9 52
b15_e378:   dex                         ; 3E378:  ca
b15_e379:   .db vm_sp_lo                     ; 3E379:  02
b15_e37a:   .db $d7                     ; 3E37A:  d7
b15_e37b:   ldx #$e3                    ; 3E37B:  a2 e3
b15_e37d:   ldy $5f                     ; 3E37D:  a4 5f
b15_e37f:   .db p2_buttons                     ; 3E37F:  6f
b15_e380:   .db $8b                     ; 3E380:  8b
b15_e381:   .db $1a                     ; 3E381:  1a
b15_e382:   lda $8c,x                   ; 3E382:  b5 8c
b15_e384:   ora ($70,x)                 ; 3E384:  01 70
b15_e386:   .db $bb                     ; 3E386:  bb
b15_e387:   bcs $e3b3                   ; 3E387:  b0 2a
b15_e389:   sty $00c8                   ; 3E389:  8c c8 00
b15_e38c:   cpy $d8                     ; 3E38C:  c4 d8
b15_e38e:   ldx #$e3                    ; 3E38E:  a2 e3
b15_e390:   sta $e91e                   ; 3E390:  8d 1e e9
b15_e393:   .db $52                     ; 3E393:  52
b15_e394:   dex                         ; 3E394:  ca
b15_e395:   .db vm_sp_lo                     ; 3E395:  02
b15_e396:   .db $8f                     ; 3E396:  8f
b15_e397:   .db $32                     ; 3E397:  32
b15_e398:   .db $b3                     ; 3E398:  b3
b15_e399:   .db $3a                     ; 3E399:  3a
b15_e39a:   sbc #$0d                    ; 3E39A:  e9 0d
b15_e39c:   .db $d7                     ; 3E39C:  d7
b15_e39d:   .db vm_fp_lo                     ; 3E39D:  04
b15_e39e:   bcc $e368                   ; 3E39E:  90 c8
b15_e3a0:   brk                         ; 3E3A0:  00
b15_e3a1:   .db $cf                     ; 3E3A1:  cf
b15_e3a2:   rti                         ; 3E3A2:  40
b15_e3a3:   .db $cf                     ; 3E3A3:  cf
prompt_diplomacy_pact:   jsr $e823                   ; 3E3A4:  20 23 e8
b15_e3a7:   .db $fa                     ; 3E3A7:  fa
b15_e3a8:   .db $ff                     ; 3E3A8:  ff
b15_e3a9:   tax                         ; 3E3A9:  aa
b15_e3aa:   .db $63                     ; 3E3AA:  63
b15_e3ab:   .db p2_buttons                     ; 3E3AB:  6f
b15_e3ac:   sbc #$8d                    ; 3E3AC:  e9 8d
b15_e3ae:   cmp $d802,y                 ; 3E3AE:  d9 02 d8
b15_e3b1:   dec $a4e3,x                 ; 3E3B1:  de e3 a4
b15_e3b4:   .db $d3                     ; 3E3B4:  d3
b15_e3b5:   .db $7f                     ; 3E3B5:  7f
b15_e3b6:   and #$42                    ; 3E3B6:  29 42
b15_e3b8:   tay                         ; 3E3B8:  a8
b15_e3b9:   .db $d3                     ; 3E3B9:  d3
b15_e3ba:   .db $7f                     ; 3E3BA:  7f
b15_e3bb:   stx $f7ad                   ; 3E3BB:  8e ad f7
b15_e3be:   sbc #$d6                    ; 3E3BE:  e9 d6
b15_e3c0:   .db $e2                     ; 3E3C0:  e2
b15_e3c1:   .db vm_sp_lo                     ; 3E3C1:  02
b15_e3c2:   stx $f78c                   ; 3E3C2:  8e 8c f7
b15_e3c5:   sbc #$c4                    ; 3E3C5:  e9 c4
b15_e3c7:   dec $8e02                   ; 3E3C7:  ce 02 8e
b15_e3ca:   .db $0f                     ; 3E3CA:  0f
b15_e3cb:   .db $27                     ; 3E3CB:  27
b15_e3cc:   adc ($e9,x)                 ; 3E3CC:  61 e9
b15_e3ce:   sbc #$d5                    ; 3E3CE:  e9 d5
b15_e3d0:   .db vm_fp_lo                     ; 3E3D0:  04
b15_e3d1:   .db $2b                     ; 3E3D1:  2b
b15_e3d2:   .db $d7                     ; 3E3D2:  d7
b15_e3d3:   cld                         ; 3E3D3:  d8
b15_e3d4:   .db $e3                     ; 3E3D4:  e3
b15_e3d5:   ldy $cc89                   ; 3E3D5:  ac 89 cc
b15_e3d8:   ora #$a8                    ; 3E3D8:  09 a8
b15_e3da:   .db $d3                     ; 3E3DA:  d3
b15_e3db:   .db $7f                     ; 3E3DB:  7f
b15_e3dc:   .db $0b                     ; 3E3DC:  0b
b15_e3dd:   .db $cf                     ; 3E3DD:  cf
b15_e3de:   tax                         ; 3E3DE:  aa
b15_e3df:   .db $5f                     ; 3E3DF:  5f
b15_e3e0:   .db p2_buttons                     ; 3E3E0:  6f
b15_e3e1:   sbc #$72                    ; 3E3E1:  e9 72
b15_e3e3:   cmp $d802,y                 ; 3E3E3:  d9 02 d8
b15_e3e6:   beq $e3cb                   ; 3E3E6:  f0 e3
b15_e3e8:   .db $63                     ; 3E3E8:  63
b15_e3e9:   sbc #$52                    ; 3E3E9:  e9 52
b15_e3eb:   dex                         ; 3E3EB:  ca
b15_e3ec:   .db vm_sp_lo                     ; 3E3EC:  02
b15_e3ed:   .db $d7                     ; 3E3ED:  d7
b15_e3ee:   .db $23                     ; 3E3EE:  23
b15_e3ef:   cpx $a4                     ; 3E3EF:  e4 a4
b15_e3f1:   .db $5f                     ; 3E3F1:  5f
b15_e3f2:   .db p2_buttons                     ; 3E3F2:  6f
b15_e3f3:   .db $8b                     ; 3E3F3:  8b
b15_e3f4:   .db $1a                     ; 3E3F4:  1a
b15_e3f5:   lda $8c,x                   ; 3E3F5:  b5 8c
b15_e3f7:   ora ($70,x)                 ; 3E3F7:  01 70
b15_e3f9:   .db $bb                     ; 3E3F9:  bb
b15_e3fa:   bcs $e426                   ; 3E3FA:  b0 2a
b15_e3fc:   tax                         ; 3E3FC:  aa
b15_e3fd:   .db $63                     ; 3E3FD:  63
b15_e3fe:   adc $52e9                   ; 3E3FE:  6d e9 52
b15_e401:   dex                         ; 3E401:  ca
b15_e402:   .db vm_sp_lo                     ; 3E402:  02
b15_e403:   .db $d7                     ; 3E403:  d7
b15_e404:   and ($e4,x)                 ; 3E404:  21 e4
b15_e406:   sta $e932                   ; 3E406:  8d 32 e9
b15_e409:   .db $52                     ; 3E409:  52
b15_e40a:   dex                         ; 3E40A:  ca
b15_e40b:   .db vm_sp_lo                     ; 3E40B:  02
b15_e40c:   .db $b3                     ; 3E40C:  b3
b15_e40d:   .db $3a                     ; 3E40D:  3a
b15_e40e:   sbc #$0d                    ; 3E40E:  e9 0d
b15_e410:   .db $d7                     ; 3E410:  d7
b15_e411:   .db vm_fp_lo                     ; 3E411:  04
b15_e412:   .db $b3                     ; 3E412:  b3
b15_e413:   sta $3a32                   ; 3E413:  8d 32 3a
b15_e416:   sbc #$0d                    ; 3E416:  e9 0d
b15_e418:   .db $d7                     ; 3E418:  d7
b15_e419:   .db vm_fp_lo                     ; 3E419:  04
b15_e41a:   ldy $bb,x                   ; 3E41A:  b4 bb
b15_e41c:   .db $8f                     ; 3E41C:  8f
b15_e41d:   .db $14                     ; 3E41D:  14
b15_e41e:   dec $22,x                   ; 3E41E:  d6 22
b15_e420:   cpx $40                     ; 3E420:  e4 40
b15_e422:   .db $cf                     ; 3E422:  cf
b15_e423:   rti                         ; 3E423:  40
b15_e424:   .db $cf                     ; 3E424:  cf
find_fiefs_of_owner:   jsr $e823                   ; 3E425:  20 23 e8
b15_e428:   inc $3cff,x                 ; 3E428:  fe ff 3c
b15_e42b:   sbc #$72                    ; 3E42B:  e9 72
b15_e42d:   .db $d7                     ; 3E42D:  d7
b15_e42e:   .db vm_sp_lo                     ; 3E42E:  02
b15_e42f:   bit $e93c                   ; 3E42F:  2c 3c e9
b15_e432:   .db $3c                     ; 3E432:  3c
b15_e433:   .db $dc                     ; 3E433:  dc
b15_e434:   .db vm_sp_lo                     ; 3E434:  02
b15_e435:   rti                         ; 3E435:  40
b15_e436:   dec $4a,x                   ; 3E436:  d6 4a
b15_e438:   cpx $3b                     ; 3E438:  e4 3b
b15_e43a:   sbc #$72                    ; 3E43A:  e9 72
b15_e43c:   .db $d7                     ; 3E43C:  d7
b15_e43d:   .db vm_sp_lo                     ; 3E43D:  02
b15_e43e:   .db ppu_queue_a_lo                     ; 3E43E:  1c
b15_e43f:   cpy #$d8                    ; 3E43F:  c0 d8
b15_e441:   pha                         ; 3E441:  48
b15_e442:   cpx $3b                     ; 3E442:  e4 3b
b15_e444:   sbc #$54                    ; 3E444:  e9 54
b15_e446:   cpx vm_sp_lo                     ; 3E446:  e4 02
b15_e448:   .db $0b                     ; 3E448:  0b
b15_e449:   bne $e476                   ; 3E449:  d0 2b
b15_e44b:   .db $0b                     ; 3E44B:  0b
b15_e44c:   ldx $9d                     ; 3E44C:  a6 9d
b15_e44e:   adc $d7c6                   ; 3E44E:  6d c6 d7
b15_e451:   and $cfe4,y                 ; 3E451:  39 e4 cf
neutralize_fief:   jsr $e823                   ; 3E454:  20 23 e8
b15_e457:   brk                         ; 3E457:  00
b15_e458:   brk                         ; 3E458:  00
b15_e459:   .db $0c                     ; 3E459:  0c
b15_e45a:   sty province_ai_state                   ; 3E45A:  8c f7 6c
b15_e45d:   .db $bb                     ; 3E45D:  bb
b15_e45e:   .db $d3                     ; 3E45E:  d3
b15_e45f:   sty $00ff                   ; 3E45F:  8c ff 00
b15_e462:   cmp ($d8,x)                 ; 3E462:  c1 d8
b15_e464:   lda ($e4,x)                 ; 3E464:  a1 e4
b15_e466:   stx $f7b2                   ; 3E466:  8e b2 f7
b15_e469:   sbc #$26                    ; 3E469:  e9 26
b15_e46b:   .db $d3                     ; 3E46B:  d3
b15_e46c:   .db vm_sp_lo                     ; 3E46C:  02
b15_e46d:   .db $0c                     ; 3E46D:  0c
b15_e46e:   bne $e423                   ; 3E46E:  d0 b3
b15_e470:   stx $f7b8                   ; 3E470:  8e b8 f7
b15_e473:   sbc #$34                    ; 3E473:  e9 34
b15_e475:   cmp (vm_fp_lo),y                 ; 3E475:  d1 04
b15_e477:   ldy $d766                   ; 3E477:  ac 66 d7
b15_e47a:   .db $0c                     ; 3E47A:  0c
b15_e47b:   sty province_ai_state                   ; 3E47B:  8c f7 6c
b15_e47e:   .db $bb                     ; 3E47E:  bb
b15_e47f:   .db $b3                     ; 3E47F:  b3
b15_e480:   .db skip_wallclock                     ; 3E480:  89
b15_e481:   .db $ff                     ; 3E481:  ff
b15_e482:   .db $d4                     ; 3E482:  d4
b15_e483:   .db $0c                     ; 3E483:  0c
b15_e484:   sty fief_is_daimyo_capital                   ; 3E484:  8c a2 6d
b15_e487:   .db $bb                     ; 3E487:  bb
b15_e488:   .db $b3                     ; 3E488:  b3
b15_e489:   rti                         ; 3E489:  40
b15_e48a:   .db $d4                     ; 3E48A:  d4
b15_e48b:   .db $0c                     ; 3E48B:  0c
b15_e48c:   sty fief_tax_rate                   ; 3E48C:  8c 2d 6d
b15_e48f:   .db $bb                     ; 3E48F:  bb
b15_e490:   .db $b3                     ; 3E490:  b3
b15_e491:   .db skip_wallclock                     ; 3E491:  89
b15_e492:   .db $14                     ; 3E492:  14
b15_e493:   .db $d4                     ; 3E493:  d4
b15_e494:   stx $77a3                   ; 3E494:  8e a3 77
b15_e497:   .db $3c                     ; 3E497:  3c
b15_e498:   sbc #$af                    ; 3E498:  e9 af
b15_e49a:   .db $e2                     ; 3E49A:  e2
b15_e49b:   .db vm_fp_lo                     ; 3E49B:  04
b15_e49c:   .db $3c                     ; 3E49C:  3c
b15_e49d:   sbc #$54                    ; 3E49D:  e9 54
b15_e49f:   sbc vm_sp_lo                     ; 3E49F:  e5 02
b15_e4a1:   .db $cf                     ; 3E4A1:  cf
build_owned_fief_list:   jsr $e823                   ; 3E4A2:  20 23 e8
b15_e4a5:   .db $fc                     ; 3E4A5:  fc
b15_e4a6:   .db $ff                     ; 3E4A6:  ff
b15_e4a7:   ldy $5f                     ; 3E4A7:  a4 5f
b15_e4a9:   .db p2_buttons                     ; 3E4A9:  6f
b15_e4aa:   rol a                       ; 3E4AA:  2a
b15_e4ab:   txa                         ; 3E4AB:  8a
b15_e4ac:   .db skip_wallclock                     ; 3E4AC:  89
b15_e4ad:   .db p2_buttons                     ; 3E4AD:  6f
b15_e4ae:   .db $2b                     ; 3E4AE:  2b
b15_e4af:   rti                         ; 3E4AF:  40
b15_e4b0:   dec $c6,x                   ; 3E4B0:  d6 c6
b15_e4b2:   cpx $ac                     ; 3E4B2:  e4 ac
b15_e4b4:   lda #$d9                    ; 3E4B4:  a9 d9
b15_e4b6:   cld                         ; 3E4B6:  d8
b15_e4b7:   .db $c2                     ; 3E4B7:  c2
b15_e4b8:   cpx $0b                     ; 3E4B8:  e4 0b
b15_e4ba:   bne $e4e7                   ; 3E4BA:  d0 2b
b15_e4bc:   cmp ($b3),y                 ; 3E4BC:  d1 b3
b15_e4be:   ldy $5f                     ; 3E4BE:  a4 5f
b15_e4c0:   .db p2_buttons                     ; 3E4C0:  6f
b15_e4c1:   .db $d4                     ; 3E4C1:  d4
b15_e4c2:   ldy $5f                     ; 3E4C2:  a4 5f
b15_e4c4:   .db p2_buttons                     ; 3E4C4:  6f
b15_e4c5:   bne $e46f                   ; 3E4C5:  d0 a8
b15_e4c7:   .db $5f                     ; 3E4C7:  5f
b15_e4c8:   .db p2_buttons                     ; 3E4C8:  6f
b15_e4c9:   ldy $5f                     ; 3E4C9:  a4 5f
b15_e4cb:   .db p2_buttons                     ; 3E4CB:  6f
b15_e4cc:   ldx $9d                     ; 3E4CC:  a6 9d
b15_e4ce:   adc $d7c6                   ; 3E4CE:  6d c6 d7
b15_e4d1:   .db $b3                     ; 3E4D1:  b3
b15_e4d2:   cpx $3b                     ; 3E4D2:  e4 3b
b15_e4d4:   .db skip_wallclock                     ; 3E4D4:  89
b15_e4d5:   .db $ff                     ; 3E4D5:  ff
b15_e4d6:   .db $d4                     ; 3E4D6:  d4
b15_e4d7:   asl a                       ; 3E4D7:  0a
b15_e4d8:   tay                         ; 3E4D8:  a8
b15_e4d9:   .db $5f                     ; 3E4D9:  5f
b15_e4da:   .db p2_buttons                     ; 3E4DA:  6f
b15_e4db:   .db $cf                     ; 3E4DB:  cf
build_fiefs_excluding_daimyo:   jsr $e823                   ; 3E4DC:  20 23 e8
b15_e4df:   .db $fc                     ; 3E4DF:  fc
b15_e4e0:   .db $ff                     ; 3E4E0:  ff
b15_e4e1:   ldy $e4a2                   ; 3E4E1:  ac a2 e4
b15_e4e4:   txa                         ; 3E4E4:  8a
b15_e4e5:   .db skip_wallclock                     ; 3E4E5:  89
b15_e4e6:   .db p2_buttons                     ; 3E4E6:  6f
b15_e4e7:   rol a                       ; 3E4E7:  2a
b15_e4e8:   dec scratch_ptr_hi,x                   ; 3E4E8:  d6 01
b15_e4ea:   sbc $0b                     ; 3E4EA:  e5 0b
b15_e4ec:   .db $d3                     ; 3E4EC:  d3
b15_e4ed:   .db $b3                     ; 3E4ED:  b3
b15_e4ee:   sbc #$72                    ; 3E4EE:  e9 72
b15_e4f0:   .db $d7                     ; 3E4F0:  d7
b15_e4f1:   .db vm_sp_lo                     ; 3E4F1:  02
b15_e4f2:   .db ppu_queue_a_lo                     ; 3E4F2:  1c
b15_e4f3:   cmp ($d8,x)                 ; 3E4F3:  c1 d8
b15_e4f5:   .db $ff                     ; 3E4F5:  ff
b15_e4f6:   cpx $0a                     ; 3E4F6:  e4 0a
b15_e4f8:   bne $e524                   ; 3E4F8:  d0 2a
b15_e4fa:   cmp ($b3),y                 ; 3E4FA:  d1 b3
b15_e4fc:   .db $0b                     ; 3E4FC:  0b
b15_e4fd:   .db $d3                     ; 3E4FD:  d3
b15_e4fe:   .db $d4                     ; 3E4FE:  d4
b15_e4ff:   .db $0b                     ; 3E4FF:  0b
b15_e500:   bne $e52d                   ; 3E500:  d0 2b
b15_e502:   .db $0b                     ; 3E502:  0b
b15_e503:   .db $d3                     ; 3E503:  d3
b15_e504:   sty $00ff                   ; 3E504:  8c ff 00
b15_e507:   cmp ($d7,x)                 ; 3E507:  c1 d7
b15_e509:   .db $eb                     ; 3E509:  eb
b15_e50a:   cpx $3a                     ; 3E50A:  e4 3a
b15_e50c:   .db skip_wallclock                     ; 3E50C:  89
b15_e50d:   .db $ff                     ; 3E50D:  ff
b15_e50e:   .db $d4                     ; 3E50E:  d4
b15_e50f:   .db $cf                     ; 3E50F:  cf
build_eligible_province_list:   jsr $e823                   ; 3E510:  20 23 e8
b15_e513:   .db $fa                     ; 3E513:  fa
b15_e514:   .db $ff                     ; 3E514:  ff
b15_e515:   txa                         ; 3E515:  8a
b15_e516:   .db skip_wallclock                     ; 3E516:  89
b15_e517:   .db p2_buttons                     ; 3E517:  6f
b15_e518:   and #$40                    ; 3E518:  29 40
b15_e51a:   rol a                       ; 3E51A:  2a
b15_e51b:   rti                         ; 3E51B:  40
b15_e51c:   dec $45,x                   ; 3E51C:  d6 45
b15_e51e:   sbc $3b                     ; 3E51E:  e5 3b
b15_e520:   sbc #$99                    ; 3E520:  e9 99
b15_e522:   cmp $d702,y                 ; 3E522:  d9 02 d7
b15_e525:   .db $43                     ; 3E525:  43
b15_e526:   sbc $3b                     ; 3E526:  e5 3b
b15_e528:   sbc #$b7                    ; 3E528:  e9 b7
b15_e52a:   cmp $1c02,y                 ; 3E52A:  d9 02 1c
b15_e52d:   .db $dc                     ; 3E52D:  dc
b15_e52e:   .db $d7                     ; 3E52E:  d7
b15_e52f:   .db $43                     ; 3E52F:  43
b15_e530:   sbc $a4                     ; 3E530:  e5 a4
b15_e532:   .db $5f                     ; 3E532:  5f
b15_e533:   .db p2_buttons                     ; 3E533:  6f
b15_e534:   .db $1b                     ; 3E534:  1b
b15_e535:   cmp ($d8,x)                 ; 3E535:  c1 d8
b15_e537:   .db $43                     ; 3E537:  43
b15_e538:   sbc $09                     ; 3E538:  e5 09
b15_e53a:   bne $e565                   ; 3E53A:  d0 29
b15_e53c:   cmp ($b3),y                 ; 3E53C:  d1 b3
b15_e53e:   .db $0b                     ; 3E53E:  0b
b15_e53f:   .db $d4                     ; 3E53F:  d4
b15_e540:   asl a                       ; 3E540:  0a
b15_e541:   bne $e56d                   ; 3E541:  d0 2a
b15_e543:   .db $0b                     ; 3E543:  0b
b15_e544:   bne $e571                   ; 3E544:  d0 2b
b15_e546:   .db $0b                     ; 3E546:  0b
b15_e547:   ldx $9d                     ; 3E547:  a6 9d
b15_e549:   adc $d7c6                   ; 3E549:  6d c6 d7
b15_e54c:   .db ppu_queue_b_hi                     ; 3E54C:  1f
b15_e54d:   sbc $39                     ; 3E54D:  e5 39
b15_e54f:   .db skip_wallclock                     ; 3E54F:  89
b15_e550:   .db $ff                     ; 3E550:  ff
b15_e551:   .db $d4                     ; 3E551:  d4
b15_e552:   asl a                       ; 3E552:  0a
b15_e553:   .db $cf                     ; 3E553:  cf
redraw_fief_on_map:   jsr $e823                   ; 3E554:  20 23 e8
b15_e557:   cld                         ; 3E557:  d8
b15_e558:   .db $ff                     ; 3E558:  ff
b15_e559:   ldy $5d                     ; 3E559:  a4 5d
b15_e55b:   .db p2_buttons                     ; 3E55B:  6f
b15_e55c:   cli                         ; 3E55C:  58
b15_e55d:   .db $c7                     ; 3E55D:  c7
b15_e55e:   cld                         ; 3E55E:  d8
b15_e55f:   sty $e5,x                   ; 3E55F:  94 e5
b15_e561:   ldy $cd                     ; 3E561:  a4 cd
b15_e563:   .db $7f                     ; 3E563:  7f
b15_e564:   .db $2b                     ; 3E564:  2b
b15_e565:   ldy $cf                     ; 3E565:  a4 cf
b15_e567:   .db $7f                     ; 3E567:  7f
b15_e568:   rol a                       ; 3E568:  2a
b15_e569:   sta $de22                   ; 3E569:  8d 22 de
b15_e56c:   .db $da                     ; 3E56C:  da
b15_e56d:   .db $ff                     ; 3E56D:  ff
b15_e56e:   .db $b3                     ; 3E56E:  b3
b15_e56f:   ldy $5d                     ; 3E56F:  a4 5d
b15_e571:   .db p2_buttons                     ; 3E571:  6f
b15_e572:   .db $8b                     ; 3E572:  8b
b15_e573:   .db $22                     ; 3E573:  22
b15_e574:   lda $8c,x                   ; 3E574:  b5 8c
b15_e576:   .db $3c                     ; 3E576:  3c
b15_e577:   .db $9e                     ; 3E577:  9e
b15_e578:   .db $bb                     ; 3E578:  bb
b15_e579:   .db $b3                     ; 3E579:  b3
b15_e57a:   .db $64                     ; 3E57A:  64
b15_e57b:   sbc #$bd                    ; 3E57B:  e9 bd
b15_e57d:   .db $cb                     ; 3E57D:  cb
b15_e57e:   php                         ; 3E57E:  08
b15_e57f:   dec $ffda,x                 ; 3E57F:  de da ff
b15_e582:   sta $d8                     ; 3E582:  85 d8
b15_e584:   sta ($d8,x)                 ; 3E584:  81 d8
b15_e586:   .db $d3                     ; 3E586:  d3
b15_e587:   sty $00ff                   ; 3E587:  8c ff 00
b15_e58a:   cmp ($d7,x)                 ; 3E58A:  c1 d7
b15_e58c:   sta $e5,x                   ; 3E58C:  95 e5
b15_e58e:   .db $3a                     ; 3E58E:  3a
b15_e58f:   .db $3b                     ; 3E58F:  3b
b15_e590:   sbc #$7b                    ; 3E590:  e9 7b
b15_e592:   cpy $cf04                   ; 3E592:  cc 04 cf
b15_e595:   sta ($d8,x)                 ; 3E595:  81 d8
b15_e597:   bne $e51e                   ; 3E597:  d0 85
b15_e599:   cld                         ; 3E599:  d8
b15_e59a:   cmp ($d3),y                 ; 3E59A:  d1 d3
b15_e59c:   tay                         ; 3E59C:  a8
b15_e59d:   cmp $817f                   ; 3E59D:  cd 7f 81
b15_e5a0:   cld                         ; 3E5A0:  d8
b15_e5a1:   bne $e528                   ; 3E5A1:  d0 85
b15_e5a3:   cld                         ; 3E5A3:  d8
b15_e5a4:   cmp ($d3),y                 ; 3E5A4:  d1 d3
b15_e5a6:   tay                         ; 3E5A6:  a8
b15_e5a7:   .db $cf                     ; 3E5A7:  cf
b15_e5a8:   .db $7f                     ; 3E5A8:  7f
b15_e5a9:   sta ($d8,x)                 ; 3E5A9:  81 d8
b15_e5ab:   bne $e532                   ; 3E5AB:  d0 85
b15_e5ad:   cld                         ; 3E5AD:  d8
b15_e5ae:   cmp ($d3),y                 ; 3E5AE:  d1 d3
b15_e5b0:   .db ppu_queue_a_lo                     ; 3E5B0:  1c
b15_e5b1:   cpy #$d8                    ; 3E5B1:  c0 d8
b15_e5b3:   sty $e5                     ; 3E5B3:  84 e5
b15_e5b5:   .db $64                     ; 3E5B5:  64
b15_e5b6:   ldy $cf                     ; 3E5B6:  a4 cf
b15_e5b8:   .db $7f                     ; 3E5B8:  7f
b15_e5b9:   .db $8f                     ; 3E5B9:  8f
b15_e5ba:   .db $fc                     ; 3E5BA:  fc
b15_e5bb:   .db $8b                     ; 3E5BB:  8b
b15_e5bc:   .db ppu_queue_a_lo                     ; 3E5BC:  1c
b15_e5bd:   lda $b3,x                   ; 3E5BD:  b5 b3
b15_e5bf:   ldy $5d                     ; 3E5BF:  a4 5d
b15_e5c1:   .db p2_buttons                     ; 3E5C1:  6f
b15_e5c2:   sty $01c0                   ; 3E5C2:  8c c0 01
b15_e5c5:   lda $b4,x                   ; 3E5C5:  b5 b4
b15_e5c7:   .db $bb                     ; 3E5C7:  bb
b15_e5c8:   ldx $cd                     ; 3E5C8:  a6 cd
b15_e5ca:   .db $7f                     ; 3E5CA:  7f
b15_e5cb:   .db $bb                     ; 3E5CB:  bb
b15_e5cc:   sty $8d5a                   ; 3E5CC:  8c 5a 8d
b15_e5cf:   .db $bb                     ; 3E5CF:  bb
b15_e5d0:   .db $b3                     ; 3E5D0:  b3
b15_e5d1:   tax                         ; 3E5D1:  aa
b15_e5d2:   .db $cf                     ; 3E5D2:  cf
b15_e5d3:   .db $7f                     ; 3E5D3:  7f
b15_e5d4:   sta $a41d                   ; 3E5D4:  8d 1d a4
b15_e5d7:   cmp $787f                   ; 3E5D7:  cd 7f 78
b15_e5da:   .db $b3                     ; 3E5DA:  b3
b15_e5db:   sbc #$5e                    ; 3E5DB:  e9 5e
b15_e5dd:   .db $cb                     ; 3E5DD:  cb
b15_e5de:   .db vm_fp_lo                     ; 3E5DE:  04
b15_e5df:   .db $b3                     ; 3E5DF:  b3
b15_e5e0:   tax                         ; 3E5E0:  aa
b15_e5e1:   .db $cf                     ; 3E5E1:  cf
b15_e5e2:   .db $7f                     ; 3E5E2:  7f
b15_e5e3:   tax                         ; 3E5E3:  aa
b15_e5e4:   cmp $e97f                   ; 3E5E4:  cd 7f e9
b15_e5e7:   .db $54                     ; 3E5E7:  54
b15_e5e8:   cpy $3c0c                   ; 3E5E8:  cc 0c 3c
b15_e5eb:   sbc #$6e                    ; 3E5EB:  e9 6e
b15_e5ed:   .db $db                     ; 3E5ED:  db
b15_e5ee:   .db vm_sp_lo                     ; 3E5EE:  02
b15_e5ef:   dec $8e,x                   ; 3E5EF:  d6 8e
b15_e5f1:   sbc $20                     ; 3E5F1:  e5 20
b15_e5f3:   .db $23                     ; 3E5F3:  23
b15_e5f4:   inx                         ; 3E5F4:  e8
b15_e5f5:   cld                         ; 3E5F5:  d8
b15_e5f6:   .db $ff                     ; 3E5F6:  ff
b15_e5f7:   .db $0c                     ; 3E5F7:  0c
b15_e5f8:   ldx $5d                     ; 3E5F8:  a6 5d
b15_e5fa:   .db p2_buttons                     ; 3E5FA:  6f
b15_e5fb:   cmp ($d8,x)                 ; 3E5FB:  c1 d8
b15_e5fd:   .db $93                     ; 3E5FD:  93
b15_e5fe:   inc $61                     ; 3E5FE:  e6 61
b15_e600:   sbc #$35                    ; 3E600:  e9 35
b15_e602:   cpy $6102                   ; 3E602:  cc 02 61
b15_e605:   sta $8d13                   ; 3E605:  8d 13 8d
b15_e608:   .db ppu_queue_b_hi                     ; 3E608:  1f
b15_e609:   .db $64                     ; 3E609:  64
b15_e60a:   sta $e91e                   ; 3E60A:  8d 1e e9
b15_e60d:   .db $42                     ; 3E60D:  42
b15_e60e:   cpy $640a                   ; 3E60E:  cc 0a 64
b15_e611:   .db $0c                     ; 3E611:  0c
b15_e612:   sty $01c0                   ; 3E612:  8c c0 01
b15_e615:   lda $8c,x                   ; 3E615:  b5 8c
b15_e617:   .db $5c                     ; 3E617:  5c
b15_e618:   sta $b3bb                   ; 3E618:  8d bb b3
b15_e61b:   sta $8d13                   ; 3E61B:  8d 13 8d
b15_e61e:   ora $6264,x                 ; 3E61E:  1d 64 62
b15_e621:   sbc #$54                    ; 3E621:  e9 54
b15_e623:   cpy $620c                   ; 3E623:  cc 0c 62
b15_e626:   stx $23c8                   ; 3E626:  8e c8 23
b15_e629:   .db $0c                     ; 3E629:  0c
b15_e62a:   eor $bd,x                   ; 3E62A:  55 bd
b15_e62c:   sty $9d1c                   ; 3E62C:  8c 1c 9d
b15_e62f:   .db $bb                     ; 3E62F:  bb
b15_e630:   .db $b3                     ; 3E630:  b3
b15_e631:   .db $64                     ; 3E631:  64
b15_e632:   sbc #$7c                    ; 3E632:  e9 7c
b15_e634:   .db $cf                     ; 3E634:  cf
b15_e635:   php                         ; 3E635:  08
b15_e636:   .db $0c                     ; 3E636:  0c
b15_e637:   tay                         ; 3E637:  a8
b15_e638:   eor $a46f,x                 ; 3E638:  5d 6f a4
b15_e63b:   cmp $2b7f                   ; 3E63B:  cd 7f 2b
b15_e63e:   ldy $cf                     ; 3E63E:  a4 cf
b15_e640:   .db $7f                     ; 3E640:  7f
b15_e641:   rol a                       ; 3E641:  2a
b15_e642:   sta $de22                   ; 3E642:  8d 22 de
b15_e645:   .db $da                     ; 3E645:  da
b15_e646:   .db $ff                     ; 3E646:  ff
b15_e647:   .db $b3                     ; 3E647:  b3
b15_e648:   .db $0c                     ; 3E648:  0c
b15_e649:   .db $8b                     ; 3E649:  8b
b15_e64a:   .db $22                     ; 3E64A:  22
b15_e64b:   lda $8c,x                   ; 3E64B:  b5 8c
b15_e64d:   .db $3c                     ; 3E64D:  3c
b15_e64e:   .db $9e                     ; 3E64E:  9e
b15_e64f:   .db $bb                     ; 3E64F:  bb
b15_e650:   .db $b3                     ; 3E650:  b3
b15_e651:   .db $64                     ; 3E651:  64
b15_e652:   sbc #$bd                    ; 3E652:  e9 bd
b15_e654:   .db $cb                     ; 3E654:  cb
b15_e655:   php                         ; 3E655:  08
b15_e656:   dec $ffda,x                 ; 3E656:  de da ff
b15_e659:   sta $d8                     ; 3E659:  85 d8
b15_e65b:   dec $7e,x                   ; 3E65B:  d6 7e
b15_e65d:   inc nmi_busy                     ; 3E65D:  e6 81
b15_e65f:   cld                         ; 3E65F:  d8
b15_e660:   bne $e5e7                   ; 3E660:  d0 85
b15_e662:   cld                         ; 3E662:  d8
b15_e663:   cmp ($d3),y                 ; 3E663:  d1 d3
b15_e665:   tay                         ; 3E665:  a8
b15_e666:   cmp $817f                   ; 3E666:  cd 7f 81
b15_e669:   cld                         ; 3E669:  d8
b15_e66a:   bne $e5f1                   ; 3E66A:  d0 85
b15_e66c:   cld                         ; 3E66C:  d8
b15_e66d:   cmp ($d3),y                 ; 3E66D:  d1 d3
b15_e66f:   tay                         ; 3E66F:  a8
b15_e670:   .db $cf                     ; 3E670:  cf
b15_e671:   .db $7f                     ; 3E671:  7f
b15_e672:   sta ($d8,x)                 ; 3E672:  81 d8
b15_e674:   bne $e5fb                   ; 3E674:  d0 85
b15_e676:   cld                         ; 3E676:  d8
b15_e677:   cmp ($d3),y                 ; 3E677:  d1 d3
b15_e679:   .db $b3                     ; 3E679:  b3
b15_e67a:   sbc #$6e                    ; 3E67A:  e9 6e
b15_e67c:   .db $db                     ; 3E67C:  db
b15_e67d:   .db vm_sp_lo                     ; 3E67D:  02
b15_e67e:   sta ($d8,x)                 ; 3E67E:  81 d8
b15_e680:   .db $d3                     ; 3E680:  d3
b15_e681:   sty $00ff                   ; 3E681:  8c ff 00
b15_e684:   cmp ($d7,x)                 ; 3E684:  c1 d7
b15_e686:   lsr $3ae6,x                 ; 3E686:  5e e6 3a
b15_e689:   .db $3b                     ; 3E689:  3b
b15_e68a:   sbc #$7b                    ; 3E68A:  e9 7b
b15_e68c:   cpy $6004                   ; 3E68C:  cc 04 60
b15_e68f:   sbc #$35                    ; 3E68F:  e9 35
b15_e691:   cpy $cf02                   ; 3E691:  cc 02 cf
render_section_for_selected_province:   jsr $e823                   ; 3E694:  20 23 e8
b15_e697:   brk                         ; 3E697:  00
b15_e698:   brk                         ; 3E698:  00
b15_e699:   ldy $9d                     ; 3E699:  a4 9d
b15_e69b:   adc $328b                   ; 3E69B:  6d 8b 32
b15_e69e:   cpy #$d8                    ; 3E69E:  c0 d8
b15_e6a0:   .db $ab                     ; 3E6A0:  ab
b15_e6a1:   inc $a4                     ; 3E6A1:  e6 a4
b15_e6a3:   cmp $8c7f,x                 ; 3E6A3:  dd 7f 8c
b15_e6a6:   ldx $fe                     ; 3E6A6:  a6 fe
b15_e6a8:   dec $b1,x                   ; 3E6A8:  d6 b1
b15_e6aa:   inc $a4                     ; 3E6AA:  e6 a4
b15_e6ac:   cmp $8c7f,x                 ; 3E6AC:  dd 7f 8c
b15_e6af:   cld                         ; 3E6AF:  d8
b15_e6b0:   inc $d3bb,x                 ; 3E6B0:  fe bb d3
b15_e6b3:   .db $b3                     ; 3E6B3:  b3
b15_e6b4:   sbc #$f2                    ; 3E6B4:  e9 f2
b15_e6b6:   sbc vm_sp_lo                     ; 3E6B6:  e5 02
b15_e6b8:   .db $cf                     ; 3E6B8:  cf
unpack_composite_face_record:   jsr $e823                   ; 3E6B9:  20 23 e8
b15_e6bc:   inc $ff,x                   ; 3E6BC:  f6 ff
b15_e6be:   ldy $5b                     ; 3E6BE:  a4 5b
b15_e6c0:   .db p2_buttons                     ; 3E6C0:  6f
b15_e6c1:   .db $d2                     ; 3E6C1:  d2
b15_e6c2:   sty daimyo_face_code_table                   ; 3E6C2:  8c b1 6e
b15_e6c5:   .db $bb                     ; 3E6C5:  bb
b15_e6c6:   bcs $e6f3                   ; 3E6C6:  b0 2b
b15_e6c8:   .db $0b                     ; 3E6C8:  0b
b15_e6c9:   eor $b8,x                   ; 3E6C9:  55 b8
b15_e6cb:   and #$0b                    ; 3E6CB:  29 0b
b15_e6cd:   eor $ba,x                   ; 3E6CD:  55 ba
b15_e6cf:   rol a                       ; 3E6CF:  2a
b15_e6d0:   ora #$55                    ; 3E6D0:  09 55
b15_e6d2:   clv                         ; 3E6D2:  b8
b15_e6d3:   plp                         ; 3E6D3:  28
b15_e6d4:   ora #$55                    ; 3E6D4:  09 55
b15_e6d6:   tsx                         ; 3E6D6:  ba
b15_e6d7:   and #$08                    ; 3E6D7:  29 08
b15_e6d9:   eor $b8,x                   ; 3E6D9:  55 b8
b15_e6db:   .db $27                     ; 3E6DB:  27
b15_e6dc:   php                         ; 3E6DC:  08
b15_e6dd:   eor $ba,x                   ; 3E6DD:  55 ba
b15_e6df:   plp                         ; 3E6DF:  28
b15_e6e0:   jmp ($b08e)                 ; 3E6E0:  6c 8e b0
b15_e6e3:   ora $0a,x                   ; 3E6E3:  15 0a
b15_e6e5:   sty $00c0                   ; 3E6E5:  8c c0 00
b15_e6e8:   lda $8c,x                   ; 3E6E8:  b5 8c
b15_e6ea:   .db vm_fp_lo                     ; 3E6EA:  04
b15_e6eb:   ldx $bb                     ; 3E6EB:  a6 bb
b15_e6ed:   .db $b3                     ; 3E6ED:  b3
b15_e6ee:   pla                         ; 3E6EE:  68
b15_e6ef:   sbc #$7c                    ; 3E6EF:  e9 7c
b15_e6f1:   .db $cf                     ; 3E6F1:  cf
b15_e6f2:   php                         ; 3E6F2:  08
b15_e6f3:   ror $8e                     ; 3E6F3:  66 8e
b15_e6f5:   bvs $e70d                   ; 3E6F5:  70 16
b15_e6f7:   ora #$8b                    ; 3E6F7:  09 8b
b15_e6f9:   rts                         ; 3E6F9:  60
b15_e6fa:   lda $8c,x                   ; 3E6FA:  b5 8c
b15_e6fc:   cpy $a9                     ; 3E6FC:  c4 a9
b15_e6fe:   .db $bb                     ; 3E6FE:  bb
b15_e6ff:   .db $b3                     ; 3E6FF:  b3
b15_e700:   pla                         ; 3E700:  68
b15_e701:   sbc #$7c                    ; 3E701:  e9 7c
b15_e703:   .db $cf                     ; 3E703:  cf
b15_e704:   php                         ; 3E704:  08
b15_e705:   ror $8e                     ; 3E705:  66 8e
b15_e707:   bne $e71f                   ; 3E707:  d0 16
b15_e709:   php                         ; 3E709:  08
b15_e70a:   .db $8b                     ; 3E70A:  8b
b15_e70b:   rts                         ; 3E70B:  60
b15_e70c:   lda $8c,x                   ; 3E70C:  b5 8c
b15_e70e:   ldy $ab                     ; 3E70E:  a4 ab
b15_e710:   .db $bb                     ; 3E710:  bb
b15_e711:   .db $b3                     ; 3E711:  b3
b15_e712:   pla                         ; 3E712:  68
b15_e713:   sbc #$7c                    ; 3E713:  e9 7c
b15_e715:   .db $cf                     ; 3E715:  cf
b15_e716:   php                         ; 3E716:  08
b15_e717:   jmp ($308e)                 ; 3E717:  6c 8e 30
b15_e71a:   .db $17                     ; 3E71A:  17
b15_e71b:   .db vm_ip_hi                     ; 3E71B:  07
b15_e71c:   sty $00c0                   ; 3E71C:  8c c0 00
b15_e71f:   lda $8c,x                   ; 3E71F:  b5 8c
b15_e721:   sty $ad                     ; 3E721:  84 ad
b15_e723:   .db $bb                     ; 3E723:  bb
b15_e724:   .db $b3                     ; 3E724:  b3
b15_e725:   pla                         ; 3E725:  68
b15_e726:   sbc #$7c                    ; 3E726:  e9 7c
b15_e728:   .db $cf                     ; 3E728:  cf
b15_e729:   php                         ; 3E729:  08
b15_e72a:   jmp ($0a3c)                 ; 3E72A:  6c 3c 0a
b15_e72d:   .db $5c                     ; 3E72D:  5c
b15_e72e:   lda $8c,x                   ; 3E72E:  b5 8c
b15_e730:   .db $34                     ; 3E730:  34
b15_e731:   ldx $b3bb                   ; 3E731:  ae bb b3
b15_e734:   adc #$e9                    ; 3E734:  69 e9
b15_e736:   lda $08cb,x                 ; 3E736:  bd cb 08
b15_e739:   ror $0c                     ; 3E739:  66 0c
b15_e73b:   .db $7c                     ; 3E73B:  7c
b15_e73c:   .db $b3                     ; 3E73C:  b3
b15_e73d:   ora #$56                    ; 3E73D:  09 56
b15_e73f:   lda $8c,x                   ; 3E73F:  b5 8c
b15_e741:   bvs $e6f1                   ; 3E741:  70 ae
b15_e743:   .db $bb                     ; 3E743:  bb
b15_e744:   .db $b3                     ; 3E744:  b3
b15_e745:   adc #$e9                    ; 3E745:  69 e9
b15_e747:   lda $08cb,x                 ; 3E747:  bd cb 08
b15_e74a:   ror $0c                     ; 3E74A:  66 0c
b15_e74c:   .db $8f                     ; 3E74C:  8f
b15_e74d:   .db $12                     ; 3E74D:  12
b15_e74e:   .db $b3                     ; 3E74E:  b3
b15_e74f:   php                         ; 3E74F:  08
b15_e750:   lsr $b5,x                   ; 3E750:  56 b5
b15_e752:   sty $ae8e                   ; 3E752:  8c 8e ae
b15_e755:   .db $bb                     ; 3E755:  bb
b15_e756:   .db $b3                     ; 3E756:  b3
b15_e757:   adc #$e9                    ; 3E757:  69 e9
b15_e759:   lda $08cb,x                 ; 3E759:  bd cb 08
b15_e75c:   jmp ($8f0c)                 ; 3E75C:  6c 0c 8f
b15_e75f:   clc                         ; 3E75F:  18
b15_e760:   .db $b3                     ; 3E760:  b3
b15_e761:   .db vm_ip_hi                     ; 3E761:  07
b15_e762:   .db $5c                     ; 3E762:  5c
b15_e763:   lda $8c,x                   ; 3E763:  b5 8c
b15_e765:   ldy $bbae                   ; 3E765:  ac ae bb
b15_e768:   .db $b3                     ; 3E768:  b3
b15_e769:   adc #$e9                    ; 3E769:  69 e9
b15_e76b:   lda $08cb,x                 ; 3E76B:  bd cb 08
b15_e76e:   .db $cf                     ; 3E76E:  cf
draw_daimyo_portrait:   jsr $e823                   ; 3E76F:  20 23 e8
b15_e772:   .db $d4                     ; 3E772:  d4
b15_e773:   .db $ff                     ; 3E773:  ff
b15_e774:   rti                         ; 3E774:  40
b15_e775:   sta $da                     ; 3E775:  85 da
b15_e777:   sta ($da,x)                 ; 3E777:  81 da
b15_e779:   .db $d2                     ; 3E779:  d2
b15_e77a:   sty $f7cc                   ; 3E77A:  8c cc f7
b15_e77d:   .db $bb                     ; 3E77D:  bb
b15_e77e:   bcs $e733                   ; 3E77E:  b0 b3
b15_e780:   .db $87                     ; 3E780:  87
b15_e781:   .db $da                     ; 3E781:  da
b15_e782:   sbc #$8b                    ; 3E782:  e9 8b
b15_e784:   .db $cf                     ; 3E784:  cf
b15_e785:   .db vm_fp_lo                     ; 3E785:  04
b15_e786:   sta ($da,x)                 ; 3E786:  81 da
b15_e788:   bne $e70f                   ; 3E788:  d0 85
b15_e78a:   .db $da                     ; 3E78A:  da
b15_e78b:   sta ($da,x)                 ; 3E78B:  81 da
b15_e78d:   .db $54                     ; 3E78D:  54
b15_e78e:   dec $d7                     ; 3E78E:  c6 d7
b15_e790:   .db $77                     ; 3E790:  77
b15_e791:   .db $e7                     ; 3E791:  e7
b15_e792:   ldy $5b                     ; 3E792:  a4 5b
b15_e794:   .db p2_buttons                     ; 3E794:  6f
b15_e795:   .db $8b                     ; 3E795:  8b
b15_e796:   and $c9,x                   ; 3E796:  35 c9
b15_e798:   .db $d7                     ; 3E798:  d7
b15_e799:   .db $a7                     ; 3E799:  a7
b15_e79a:   .db $e7                     ; 3E79A:  e7
b15_e79b:   tax                         ; 3E79B:  aa
b15_e79c:   .db $5b                     ; 3E79C:  5b
b15_e79d:   .db p2_buttons                     ; 3E79D:  6f
b15_e79e:   sbc #$cd                    ; 3E79E:  e9 cd
b15_e7a0:   .db $d7                     ; 3E7A0:  d7
b15_e7a1:   .db vm_sp_lo                     ; 3E7A1:  02
b15_e7a2:   ror $d3,x                   ; 3E7A2:  76 d3
b15_e7a4:   .db $d7                     ; 3E7A4:  d7
b15_e7a5:   inc $aae7                   ; 3E7A5:  ee e7 aa
b15_e7a8:   .db $5b                     ; 3E7A8:  5b
b15_e7a9:   .db p2_buttons                     ; 3E7A9:  6f
b15_e7aa:   sbc #$66                    ; 3E7AA:  e9 66
b15_e7ac:   .db $dc                     ; 3E7AC:  dc
b15_e7ad:   .db vm_sp_lo                     ; 3E7AD:  02
b15_e7ae:   .db $d2                     ; 3E7AE:  d2
b15_e7af:   .db $d2                     ; 3E7AF:  d2
b15_e7b0:   sty $bbd0                   ; 3E7B0:  8c d0 bb
b15_e7b3:   .db $bb                     ; 3E7B3:  bb
b15_e7b4:   sta $d8                     ; 3E7B4:  85 d8
b15_e7b6:   .db $64                     ; 3E7B6:  64
b15_e7b7:   dec $ffd4,x                 ; 3E7B7:  de d4 ff
b15_e7ba:   .db $b3                     ; 3E7BA:  b3
b15_e7bb:   .db $87                     ; 3E7BB:  87
b15_e7bc:   cld                         ; 3E7BC:  d8
b15_e7bd:   pla                         ; 3E7BD:  68
b15_e7be:   sbc #$bd                    ; 3E7BE:  e9 bd
b15_e7c0:   .db $cb                     ; 3E7C0:  cb
b15_e7c1:   php                         ; 3E7C1:  08
b15_e7c2:   dec $ffd4,x                 ; 3E7C2:  de d4 ff
b15_e7c5:   sta $d8                     ; 3E7C5:  85 d8
b15_e7c7:   sta ($d8,x)                 ; 3E7C7:  81 d8
b15_e7c9:   bne $e79e                   ; 3E7C9:  d0 d3
b15_e7cb:   .db $b3                     ; 3E7CB:  b3
b15_e7cc:   stx $15b0                   ; 3E7CC:  8e b0 15
b15_e7cf:   sta ($d8,x)                 ; 3E7CF:  81 d8
b15_e7d1:   .db ppumask_shadow                     ; 3E7D1:  72
b15_e7d2:   bcs $e787                   ; 3E7D2:  b0 b3
b15_e7d4:   sta ($d8,x)                 ; 3E7D4:  81 d8
b15_e7d6:   .db $d3                     ; 3E7D6:  d3
b15_e7d7:   .db $b3                     ; 3E7D7:  b3
b15_e7d8:   sbc #$7c                    ; 3E7D8:  e9 7c
b15_e7da:   .db $cf                     ; 3E7DA:  cf
b15_e7db:   php                         ; 3E7DB:  08
b15_e7dc:   pla                         ; 3E7DC:  68
b15_e7dd:   tax                         ; 3E7DD:  aa
b15_e7de:   .db $5b                     ; 3E7DE:  5b
b15_e7df:   .db p2_buttons                     ; 3E7DF:  6f
b15_e7e0:   sbc #$66                    ; 3E7E0:  e9 66
b15_e7e2:   .db $dc                     ; 3E7E2:  dc
b15_e7e3:   .db vm_sp_lo                     ; 3E7E3:  02
b15_e7e4:   .db $8b                     ; 3E7E4:  8b
b15_e7e5:   bit $b5                     ; 3E7E5:  24 b5
b15_e7e7:   sty $b144                   ; 3E7E7:  8c 44 b1
b15_e7ea:   .db $bb                     ; 3E7EA:  bb
b15_e7eb:   dec $fa,x                   ; 3E7EB:  d6 fa
b15_e7ed:   .db $e7                     ; 3E7ED:  e7
b15_e7ee:   dec $ffdc,x                 ; 3E7EE:  de dc ff
b15_e7f1:   .db $b3                     ; 3E7F1:  b3
b15_e7f2:   sbc #$b9                    ; 3E7F2:  e9 b9
b15_e7f4:   inc vm_sp_lo                     ; 3E7F4:  e6 02
b15_e7f6:   pla                         ; 3E7F6:  68
b15_e7f7:   dec $ffdc,x                 ; 3E7F7:  de dc ff
b15_e7fa:   .db $b3                     ; 3E7FA:  b3
b15_e7fb:   ora $b375                   ; 3E7FB:  0d 75 b3
b15_e7fe:   .db $0c                     ; 3E7FE:  0c
b15_e7ff:   adc $b3,x                   ; 3E7FF:  75 b3
b15_e801:   and $e93c,x                 ; 3E801:  3d 3c e9
b15_e804:   .db $54                     ; 3E804:  54
b15_e805:   cpy $410c                   ; 3E805:  cc 0c 41
b15_e808:   tay                         ; 3E808:  a8
b15_e809:   .db $c7                     ; 3E809:  c7
b15_e80a:   .db $7f                     ; 3E80A:  7f
b15_e80b:   .db $cf                     ; 3E80B:  cf
trigger_cutscene:   jsr $e823                   ; 3E80C:  20 23 e8
b15_e80f:   brk                         ; 3E80F:  00
b15_e810:   brk                         ; 3E810:  00
b15_e811:   lda $a1                     ; 3E811:  a5 a1
b15_e813:   adc $da54                   ; 3E813:  6d 54 da
b15_e816:   cld                         ; 3E816:  d8
b15_e817:   .db $22                     ; 3E817:  22
b15_e818:   inx                         ; 3E818:  e8
b15_e819:   .db $0c                     ; 3E819:  0c
b15_e81a:   tay                         ; 3E81A:  a8
b15_e81b:   .db $cb                     ; 3E81B:  cb
b15_e81c:   .db $7f                     ; 3E81C:  7f
b15_e81d:   ror $b1e9                   ; 3E81D:  6e e9 b1
b15_e820:   .db $cb                     ; 3E820:  cb
b15_e821:   .db vm_sp_lo                     ; 3E821:  02
b15_e822:   .db $cf                     ; 3E822:  cf
vm_entry:   pla                         ; 3E823:  68
b15_e824:   sta $08                     ; 3E824:  85 08
b15_e826:   pla                         ; 3E826:  68
b15_e827:   sta $09                     ; 3E827:  85 09
b15_e829:   pla                         ; 3E829:  68
b15_e82a:   sta scratch_ptr_lo                     ; 3E82A:  85 00
b15_e82c:   pla                         ; 3E82C:  68
b15_e82d:   sta scratch_ptr_hi                     ; 3E82D:  85 01
b15_e82f:   ldy #$07                    ; 3E82F:  a0 07
b15_e831:   sec                         ; 3E831:  38
b15_e832:   lda vm_sp_lo                     ; 3E832:  a5 02
b15_e834:   sbc #$09                    ; 3E834:  e9 09
b15_e836:   sta $0c                     ; 3E836:  85 0c
b15_e838:   lda vm_sp_hi                     ; 3E838:  a5 03
b15_e83a:   sbc #$00                    ; 3E83A:  e9 00
b15_e83c:   sta $0d                     ; 3E83C:  85 0d
b15_e83e:   lda scratch_ptr_lo,y                 ; 3E83E:  b9 00 00
b15_e841:   sta ($0c),y                 ; 3E841:  91 0c
b15_e843:   dey                         ; 3E843:  88
b15_e844:   bpl $e83e                   ; 3E844:  10 f8
b15_e846:   ldy #$01                    ; 3E846:  a0 01
b15_e848:   clc                         ; 3E848:  18
b15_e849:   lda $0c                     ; 3E849:  a5 0c
b15_e84b:   sta vm_fp_lo                     ; 3E84B:  85 04
b15_e84d:   adc ($08),y                 ; 3E84D:  71 08
b15_e84f:   sta vm_sp_lo                     ; 3E84F:  85 02
b15_e851:   iny                         ; 3E851:  c8
b15_e852:   lda $0d                     ; 3E852:  a5 0d
b15_e854:   sta vm_fp_hi                     ; 3E854:  85 05
b15_e856:   adc ($08),y                 ; 3E856:  71 08
b15_e858:   sta vm_sp_hi                     ; 3E858:  85 03
b15_e85a:   clc                         ; 3E85A:  18
b15_e85b:   lda $08                     ; 3E85B:  a5 08
b15_e85d:   adc #$03                    ; 3E85D:  69 03
b15_e85f:   sta vm_ip_lo                     ; 3E85F:  85 06
b15_e861:   lda $09                     ; 3E861:  a5 09
b15_e863:   adc #$00                    ; 3E863:  69 00
b15_e865:   sta vm_ip_hi                     ; 3E865:  85 07
vm_dispatch:   ldy #$00                    ; 3E867:  a0 00
b15_e869:   lda (vm_ip_lo),y                 ; 3E869:  b1 06
b15_e86b:   inc vm_ip_lo                     ; 3E86B:  e6 06
b15_e86d:   bne $e871                   ; 3E86D:  d0 02
b15_e86f:   inc vm_ip_hi                     ; 3E86F:  e6 07
b15_e871:   tax                         ; 3E871:  aa
b15_e872:   lda $f026,x                 ; 3E872:  bd 26 f0
b15_e875:   sta scratch_ptr_lo                     ; 3E875:  85 00
b15_e877:   lda $f126,x                 ; 3E877:  bd 26 f1
b15_e87a:   sta scratch_ptr_hi                     ; 3E87A:  85 01
b15_e87c:   jmp (scratch_ptr_lo)                 ; 3E87C:  6c 00 00
vm_op_00_load_offset:   lda #$e8                    ; 3E87F:  a9 e8
b15_e881:   bne $e8ad                   ; 3E881:  d0 2a
vm_op_01_loadA_local_neg:   lda #$ea                    ; 3E883:  a9 ea
b15_e885:   bne $e8ad                   ; 3E885:  d0 26
vm_op_02_loadA_local_neg:   lda #$ec                    ; 3E887:  a9 ec
b15_e889:   bne $e8ad                   ; 3E889:  d0 22
vm_op_03_loadA_local_neg:   lda #$ee                    ; 3E88B:  a9 ee
b15_e88d:   bne $e8ad                   ; 3E88D:  d0 1e
vm_op_04_loadA_local_neg:   lda #$f0                    ; 3E88F:  a9 f0
b15_e891:   bne $e8ad                   ; 3E891:  d0 1a
vm_op_05_loadA_local_neg:   lda #$f2                    ; 3E893:  a9 f2
b15_e895:   bne $e8ad                   ; 3E895:  d0 16
vm_op_06_loadA_local_neg:   lda #$f4                    ; 3E897:  a9 f4
b15_e899:   bne $e8ad                   ; 3E899:  d0 12
vm_op_07_loadA_local_neg:   lda #$f6                    ; 3E89B:  a9 f6
b15_e89d:   bne $e8ad                   ; 3E89D:  d0 0e
vm_op_08_loadA_local_neg:   lda #$f8                    ; 3E89F:  a9 f8
b15_e8a1:   bne $e8ad                   ; 3E8A1:  d0 0a
vm_op_09_loadA_local_neg:   lda #$fa                    ; 3E8A3:  a9 fa
b15_e8a5:   bne $e8ad                   ; 3E8A5:  d0 06
vm_op_0A_loadA_local_neg:   lda #$fc                    ; 3E8A7:  a9 fc
b15_e8a9:   bne $e8ad                   ; 3E8A9:  d0 02
vm_op_0B_loadA_local_neg:   lda #$fe                    ; 3E8AB:  a9 fe
vm_op_load_tail:   clc                         ; 3E8AD:  18
b15_e8ae:   adc vm_fp_lo                     ; 3E8AE:  65 04
b15_e8b0:   sta scratch_ptr_lo                     ; 3E8B0:  85 00
b15_e8b2:   lda #$ff                    ; 3E8B2:  a9 ff
b15_e8b4:   adc vm_fp_hi                     ; 3E8B4:  65 05
b15_e8b6:   sta scratch_ptr_hi                     ; 3E8B6:  85 01
b15_e8b8:   lda (scratch_ptr_lo),y                 ; 3E8B8:  b1 00
b15_e8ba:   sta $08                     ; 3E8BA:  85 08
b15_e8bc:   iny                         ; 3E8BC:  c8
b15_e8bd:   lda (scratch_ptr_lo),y                 ; 3E8BD:  b1 00
b15_e8bf:   sta $09                     ; 3E8BF:  85 09
b15_e8c1:   jmp $e867                   ; 3E8C1:  4c 67 e8
vm_op_0F_loadA_local_pos:   ldy #$11                    ; 3E8C4:  a0 11
b15_e8c6:   bne $e8d2                   ; 3E8C6:  d0 0a
vm_op_0E_loadA_local_pos:   ldy #$0f                    ; 3E8C8:  a0 0f
b15_e8ca:   bne $e8d2                   ; 3E8CA:  d0 06
vm_op_0D_loadA_local_pos:   ldy #$0d                    ; 3E8CC:  a0 0d
b15_e8ce:   bne $e8d2                   ; 3E8CE:  d0 02
vm_op_0C_loadA_local_pos:   ldy #$0b                    ; 3E8D0:  a0 0b
b15_e8d2:   lda (vm_fp_lo),y                 ; 3E8D2:  b1 04
b15_e8d4:   sta $08                     ; 3E8D4:  85 08
b15_e8d6:   iny                         ; 3E8D6:  c8
b15_e8d7:   lda (vm_fp_lo),y                 ; 3E8D7:  b1 04
b15_e8d9:   sta $09                     ; 3E8D9:  85 09
b15_e8db:   jmp $e867                   ; 3E8DB:  4c 67 e8
vm_op_10_loadB_local_neg:   lda #$e8                    ; 3E8DE:  a9 e8
b15_e8e0:   bne $e90c                   ; 3E8E0:  d0 2a
vm_op_11_loadB_local_neg:   lda #$ea                    ; 3E8E2:  a9 ea
b15_e8e4:   bne $e90c                   ; 3E8E4:  d0 26
vm_op_12_loadB_local_neg:   lda #$ec                    ; 3E8E6:  a9 ec
b15_e8e8:   bne $e90c                   ; 3E8E8:  d0 22
vm_op_13_loadB_local_neg:   lda #$ee                    ; 3E8EA:  a9 ee
b15_e8ec:   bne $e90c                   ; 3E8EC:  d0 1e
vm_op_14_loadB_local_neg:   lda #$f0                    ; 3E8EE:  a9 f0
b15_e8f0:   bne $e90c                   ; 3E8F0:  d0 1a
vm_op_15_loadB_local_neg:   lda #$f2                    ; 3E8F2:  a9 f2
b15_e8f4:   bne $e90c                   ; 3E8F4:  d0 16
vm_op_16_loadB_local_neg:   lda #$f4                    ; 3E8F6:  a9 f4
b15_e8f8:   bne $e90c                   ; 3E8F8:  d0 12
vm_op_17_loadB_local_neg:   lda #$f6                    ; 3E8FA:  a9 f6
b15_e8fc:   bne $e90c                   ; 3E8FC:  d0 0e
vm_op_18_loadB_local_neg:   lda #$f8                    ; 3E8FE:  a9 f8
b15_e900:   bne $e90c                   ; 3E900:  d0 0a
vm_op_19_loadB_local_neg:   lda #$fa                    ; 3E902:  a9 fa
b15_e904:   bne $e90c                   ; 3E904:  d0 06
vm_op_1A_loadB_local_neg:   lda #$fc                    ; 3E906:  a9 fc
b15_e908:   bne $e90c                   ; 3E908:  d0 02
vm_op_1B_loadB_local_neg:   lda #$fe                    ; 3E90A:  a9 fe
b15_e90c:   clc                         ; 3E90C:  18
b15_e90d:   adc vm_fp_lo                     ; 3E90D:  65 04
b15_e90f:   sta scratch_ptr_lo                     ; 3E90F:  85 00
b15_e911:   lda #$ff                    ; 3E911:  a9 ff
b15_e913:   adc vm_fp_hi                     ; 3E913:  65 05
b15_e915:   sta scratch_ptr_hi                     ; 3E915:  85 01
b15_e917:   lda (scratch_ptr_lo),y                 ; 3E917:  b1 00
b15_e919:   sta $0c                     ; 3E919:  85 0c
b15_e91b:   iny                         ; 3E91B:  c8
b15_e91c:   lda (scratch_ptr_lo),y                 ; 3E91C:  b1 00
b15_e91e:   sta $0d                     ; 3E91E:  85 0d
b15_e920:   jmp $e867                   ; 3E920:  4c 67 e8
vm_op_1F_loadB_local_pos:   ldy #$11                    ; 3E923:  a0 11
b15_e925:   bne $e931                   ; 3E925:  d0 0a
vm_op_1E_loadB_local_pos:   ldy #$0f                    ; 3E927:  a0 0f
b15_e929:   bne $e931                   ; 3E929:  d0 06
vm_op_1D_loadB_local_pos:   ldy #$0d                    ; 3E92B:  a0 0d
b15_e92d:   bne $e931                   ; 3E92D:  d0 02
vm_op_1C_loadB_local_pos:   ldy #$0b                    ; 3E92F:  a0 0b
b15_e931:   lda (vm_fp_lo),y                 ; 3E931:  b1 04
b15_e933:   sta $0c                     ; 3E933:  85 0c
b15_e935:   iny                         ; 3E935:  c8
b15_e936:   lda (vm_fp_lo),y                 ; 3E936:  b1 04
b15_e938:   sta $0d                     ; 3E938:  85 0d
b15_e93a:   jmp $e867                   ; 3E93A:  4c 67 e8
vm_op_20_storeA_local_neg:   lda #$e8                    ; 3E93D:  a9 e8
b15_e93f:   bne $e96b                   ; 3E93F:  d0 2a
vm_op_21_storeA_local_neg:   lda #$ea                    ; 3E941:  a9 ea
b15_e943:   bne $e96b                   ; 3E943:  d0 26
vm_op_22_storeA_local_neg:   lda #$ec                    ; 3E945:  a9 ec
b15_e947:   bne $e96b                   ; 3E947:  d0 22
vm_op_23_storeA_local_neg:   lda #$ee                    ; 3E949:  a9 ee
b15_e94b:   bne $e96b                   ; 3E94B:  d0 1e
vm_op_24_storeA_local_neg:   lda #$f0                    ; 3E94D:  a9 f0
b15_e94f:   bne $e96b                   ; 3E94F:  d0 1a
vm_op_25_storeA_local_neg:   lda #$f2                    ; 3E951:  a9 f2
b15_e953:   bne $e96b                   ; 3E953:  d0 16
vm_op_26_storeA_local_neg:   lda #$f4                    ; 3E955:  a9 f4
b15_e957:   bne $e96b                   ; 3E957:  d0 12
vm_op_27_storeA_local_neg:   lda #$f6                    ; 3E959:  a9 f6
b15_e95b:   bne $e96b                   ; 3E95B:  d0 0e
vm_op_28_storeA_local_neg:   lda #$f8                    ; 3E95D:  a9 f8
b15_e95f:   bne $e96b                   ; 3E95F:  d0 0a
vm_op_29_storeA_local_neg:   lda #$fa                    ; 3E961:  a9 fa
b15_e963:   bne $e96b                   ; 3E963:  d0 06
vm_op_2A_storeA_local_neg:   lda #$fc                    ; 3E965:  a9 fc
b15_e967:   bne $e96b                   ; 3E967:  d0 02
vm_op_2B_storeA_local_neg:   lda #$fe                    ; 3E969:  a9 fe
b15_e96b:   clc                         ; 3E96B:  18
b15_e96c:   adc vm_fp_lo                     ; 3E96C:  65 04
b15_e96e:   sta scratch_ptr_lo                     ; 3E96E:  85 00
b15_e970:   lda #$ff                    ; 3E970:  a9 ff
b15_e972:   adc vm_fp_hi                     ; 3E972:  65 05
b15_e974:   sta scratch_ptr_hi                     ; 3E974:  85 01
b15_e976:   lda $08                     ; 3E976:  a5 08
b15_e978:   sta (scratch_ptr_lo),y                 ; 3E978:  91 00
b15_e97a:   iny                         ; 3E97A:  c8
b15_e97b:   lda $09                     ; 3E97B:  a5 09
b15_e97d:   sta (scratch_ptr_lo),y                 ; 3E97D:  91 00
b15_e97f:   jmp $e867                   ; 3E97F:  4c 67 e8
vm_op_2F_storeA_local_pos:   ldy #$11                    ; 3E982:  a0 11
b15_e984:   bne $e990                   ; 3E984:  d0 0a
vm_op_2E_storeA_local_pos:   ldy #$0f                    ; 3E986:  a0 0f
b15_e988:   bne $e990                   ; 3E988:  d0 06
vm_op_2D_storeA_local_pos:   ldy #$0d                    ; 3E98A:  a0 0d
b15_e98c:   bne $e990                   ; 3E98C:  d0 02
vm_op_2C_storeA_local_pos:   ldy #$0b                    ; 3E98E:  a0 0b
b15_e990:   lda $08                     ; 3E990:  a5 08
b15_e992:   sta (vm_fp_lo),y                 ; 3E992:  91 04
b15_e994:   iny                         ; 3E994:  c8
b15_e995:   lda $09                     ; 3E995:  a5 09
b15_e997:   sta (vm_fp_lo),y                 ; 3E997:  91 04
b15_e999:   jmp $e867                   ; 3E999:  4c 67 e8
vm_op_30_storeB_local_neg:   lda #$e8                    ; 3E99C:  a9 e8
b15_e99e:   bne $e9ca                   ; 3E99E:  d0 2a
vm_op_31_storeB_local_neg:   lda #$ea                    ; 3E9A0:  a9 ea
b15_e9a2:   bne $e9ca                   ; 3E9A2:  d0 26
vm_op_32_storeB_local_neg:   lda #$ec                    ; 3E9A4:  a9 ec
b15_e9a6:   bne $e9ca                   ; 3E9A6:  d0 22
vm_op_33_storeB_local_neg:   lda #$ee                    ; 3E9A8:  a9 ee
b15_e9aa:   bne $e9ca                   ; 3E9AA:  d0 1e
vm_op_34_storeB_local_neg:   lda #$f0                    ; 3E9AC:  a9 f0
b15_e9ae:   bne $e9ca                   ; 3E9AE:  d0 1a
vm_op_35_storeB_local_neg:   lda #$f2                    ; 3E9B0:  a9 f2
b15_e9b2:   bne $e9ca                   ; 3E9B2:  d0 16
vm_op_36_storeB_local_neg:   lda #$f4                    ; 3E9B4:  a9 f4
b15_e9b6:   bne $e9ca                   ; 3E9B6:  d0 12
vm_op_37_storeB_local_neg:   lda #$f6                    ; 3E9B8:  a9 f6
b15_e9ba:   bne $e9ca                   ; 3E9BA:  d0 0e
vm_op_38_storeB_local_neg:   lda #$f8                    ; 3E9BC:  a9 f8
b15_e9be:   bne $e9ca                   ; 3E9BE:  d0 0a
vm_op_39_storeB_local_neg:   lda #$fa                    ; 3E9C0:  a9 fa
b15_e9c2:   bne $e9ca                   ; 3E9C2:  d0 06
vm_op_3A_storeB_local_neg:   lda #$fc                    ; 3E9C4:  a9 fc
b15_e9c6:   bne $e9ca                   ; 3E9C6:  d0 02
vm_op_3B_storeB_local_neg:   lda #$fe                    ; 3E9C8:  a9 fe
b15_e9ca:   clc                         ; 3E9CA:  18
b15_e9cb:   adc vm_fp_lo                     ; 3E9CB:  65 04
b15_e9cd:   sta scratch_ptr_lo                     ; 3E9CD:  85 00
b15_e9cf:   lda #$ff                    ; 3E9CF:  a9 ff
b15_e9d1:   adc vm_fp_hi                     ; 3E9D1:  65 05
b15_e9d3:   sta scratch_ptr_hi                     ; 3E9D3:  85 01
b15_e9d5:   iny                         ; 3E9D5:  c8
b15_e9d6:   lda (scratch_ptr_lo),y                 ; 3E9D6:  b1 00
b15_e9d8:   tax                         ; 3E9D8:  aa
b15_e9d9:   dey                         ; 3E9D9:  88
b15_e9da:   lda (scratch_ptr_lo),y                 ; 3E9DA:  b1 00
b15_e9dc:   jmp $f008                   ; 3E9DC:  4c 08 f0
vm_op_3F_storeB_local_pos:   ldy #$12                    ; 3E9DF:  a0 12
b15_e9e1:   bne $e9ed                   ; 3E9E1:  d0 0a
vm_op_3E_storeB_local_pos:   ldy #$10                    ; 3E9E3:  a0 10
b15_e9e5:   bne $e9ed                   ; 3E9E5:  d0 06
vm_op_3D_storeB_local_pos:   ldy #$0e                    ; 3E9E7:  a0 0e
b15_e9e9:   bne $e9ed                   ; 3E9E9:  d0 02
vm_op_3C_storeB_local_pos:   ldy #$0c                    ; 3E9EB:  a0 0c
b15_e9ed:   lda (vm_fp_lo),y                 ; 3E9ED:  b1 04
b15_e9ef:   tax                         ; 3E9EF:  aa
b15_e9f0:   dey                         ; 3E9F0:  88
b15_e9f1:   lda (vm_fp_lo),y                 ; 3E9F1:  b1 04
b15_e9f3:   jmp $f008                   ; 3E9F3:  4c 08 f0
vm_op_clearA_shared:   txa                         ; 3E9F6:  8a
b15_e9f7:   and #$0f                    ; 3E9F7:  29 0f
b15_e9f9:   sta $08                     ; 3E9F9:  85 08
b15_e9fb:   sty $09                     ; 3E9FB:  84 09
b15_e9fd:   jmp $e867                   ; 3E9FD:  4c 67 e8
vm_op_40_clearA_40:   sty $08                     ; 3EA00:  84 08
b15_ea02:   sty $09                     ; 3EA02:  84 09
b15_ea04:   jmp $e867                   ; 3EA04:  4c 67 e8
vm_op_setB_imm4_shared:   txa                         ; 3EA07:  8a
b15_ea08:   and #$0f                    ; 3EA08:  29 0f
b15_ea0a:   sta $0c                     ; 3EA0A:  85 0c
b15_ea0c:   sty $0d                     ; 3EA0C:  84 0d
b15_ea0e:   jmp $e867                   ; 3EA0E:  4c 67 e8
vm_op_50_setB_imm4_50:   sty $0c                     ; 3EA11:  84 0c
b15_ea13:   sty $0d                     ; 3EA13:  84 0d
b15_ea15:   jmp $e867                   ; 3EA15:  4c 67 e8
vm_op_push_imm4_shared:   txa                         ; 3EA18:  8a
b15_ea19:   and #$0f                    ; 3EA19:  29 0f
b15_ea1b:   ldx #$00                    ; 3EA1B:  a2 00
b15_ea1d:   jmp $f008                   ; 3EA1D:  4c 08 f0
vm_op_addA_imm4_shared:   txa                         ; 3EA20:  8a
b15_ea21:   and #$0f                    ; 3EA21:  29 0f
b15_ea23:   clc                         ; 3EA23:  18
b15_ea24:   adc $08                     ; 3EA24:  65 08
b15_ea26:   sta $08                     ; 3EA26:  85 08
b15_ea28:   bcc $ea2c                   ; 3EA28:  90 02
b15_ea2a:   inc $09                     ; 3EA2A:  e6 09
vm_op_70_nop:   jmp $e867                   ; 3EA2C:  4c 67 e8
vm_op_82_bb:   jsr $efec                   ; 3EA2F:  20 ec ef
b15_ea32:   bcc $ea37                   ; 3EA32:  90 03
vm_op_81_byte:   jsr $efa6                   ; 3EA34:  20 a6 ef
b15_ea37:   lda (scratch_ptr_lo),y                 ; 3EA37:  b1 00
b15_ea39:   sta $08                     ; 3EA39:  85 08
b15_ea3b:   iny                         ; 3EA3B:  c8
b15_ea3c:   lda (scratch_ptr_lo),y                 ; 3EA3C:  b1 00
b15_ea3e:   sta $09                     ; 3EA3E:  85 09
b15_ea40:   jmp $e867                   ; 3EA40:  4c 67 e8
vm_op_A4_loadA_mem_word:   jsr $efd5                   ; 3EA43:  20 d5 ef
b15_ea46:   bcc $ea37                   ; 3EA46:  90 ef
vm_op_83_byte:   jsr $efa6                   ; 3EA48:  20 a6 ef
b15_ea4b:   lda (scratch_ptr_lo),y                 ; 3EA4B:  b1 00
b15_ea4d:   sta $0c                     ; 3EA4D:  85 0c
b15_ea4f:   iny                         ; 3EA4F:  c8
b15_ea50:   lda (scratch_ptr_lo),y                 ; 3EA50:  b1 00
b15_ea52:   sta $0d                     ; 3EA52:  85 0d
b15_ea54:   jmp $e867                   ; 3EA54:  4c 67 e8
vm_op_84_bwb:   jsr $efec                   ; 3EA57:  20 ec ef
b15_ea5a:   bcc $ea4b                   ; 3EA5A:  90 ef
vm_op_A6_loadB_mem_word:   jsr $efd5                   ; 3EA5C:  20 d5 ef
b15_ea5f:   bcc $ea4b                   ; 3EA5F:  90 ea
vm_op_85_byte:   jsr $efa6                   ; 3EA61:  20 a6 ef
b15_ea64:   lda $08                     ; 3EA64:  a5 08
b15_ea66:   sta (scratch_ptr_lo),y                 ; 3EA66:  91 00
b15_ea68:   iny                         ; 3EA68:  c8
b15_ea69:   lda $09                     ; 3EA69:  a5 09
b15_ea6b:   sta (scratch_ptr_lo),y                 ; 3EA6B:  91 00
b15_ea6d:   jmp $e867                   ; 3EA6D:  4c 67 e8
vm_op_86_bwb:   jsr $efec                   ; 3EA70:  20 ec ef
b15_ea73:   bcc $ea64                   ; 3EA73:  90 ef
vm_op_A8_loadA_mem_word:   jsr $efd5                   ; 3EA75:  20 d5 ef
b15_ea78:   bcc $ea64                   ; 3EA78:  90 ea
vm_op_87_byte:   jsr $efa6                   ; 3EA7A:  20 a6 ef
b15_ea7d:   iny                         ; 3EA7D:  c8
b15_ea7e:   lda (scratch_ptr_lo),y                 ; 3EA7E:  b1 00
b15_ea80:   tax                         ; 3EA80:  aa
b15_ea81:   dey                         ; 3EA81:  88
b15_ea82:   lda (scratch_ptr_lo),y                 ; 3EA82:  b1 00
b15_ea84:   jmp $f008                   ; 3EA84:  4c 08 f0
vm_op_88_bwb:   jsr $efec                   ; 3EA87:  20 ec ef
b15_ea8a:   bcc $ea7d                   ; 3EA8A:  90 f1
vm_op_AA:   jsr $efd5                   ; 3EA8C:  20 d5 ef
b15_ea8f:   bcc $ea7d                   ; 3EA8F:  90 ec
vm_op_DE_loadA_frameaddr:   jsr $efbf                   ; 3EA91:  20 bf ef
b15_ea94:   adc vm_fp_lo                     ; 3EA94:  65 04
b15_ea96:   sta $08                     ; 3EA96:  85 08
b15_ea98:   txa                         ; 3EA98:  8a
b15_ea99:   adc vm_fp_hi                     ; 3EA99:  65 05
b15_ea9b:   sta $09                     ; 3EA9B:  85 09
b15_ea9d:   jmp $e867                   ; 3EA9D:  4c 67 e8
vm_op_DF_loadB_frameaddr:   jsr $efbf                   ; 3EAA0:  20 bf ef
b15_eaa3:   adc vm_fp_lo                     ; 3EAA3:  65 04
b15_eaa5:   sta $0c                     ; 3EAA5:  85 0c
b15_eaa7:   txa                         ; 3EAA7:  8a
b15_eaa8:   adc vm_fp_hi                     ; 3EAA8:  65 05
b15_eaaa:   sta $0d                     ; 3EAAA:  85 0d
b15_eaac:   jmp $e867                   ; 3EAAC:  4c 67 e8
vm_op_89_loadA_imm_sbyte:   jsr $ef97                   ; 3EAAF:  20 97 ef
b15_eab2:   sta $08                     ; 3EAB2:  85 08
b15_eab4:   stx $09                     ; 3EAB4:  86 09
b15_eab6:   jmp $e867                   ; 3EAB6:  4c 67 e8
vm_op_8A_loadA_imm_word:   jsr $efbf                   ; 3EAB9:  20 bf ef
b15_eabc:   bcc $eab2                   ; 3EABC:  90 f4
vm_op_8B_loadB_imm_byte:   jsr $ef97                   ; 3EABE:  20 97 ef
b15_eac1:   sta $0c                     ; 3EAC1:  85 0c
b15_eac3:   stx $0d                     ; 3EAC3:  86 0d
b15_eac5:   jmp $e867                   ; 3EAC5:  4c 67 e8
vm_op_8C_loadB_imm_word:   jsr $efbf                   ; 3EAC8:  20 bf ef
b15_eacb:   bcc $eac1                   ; 3EACB:  90 f4
vm_op_8D_sbyte:   jsr $ef97                   ; 3EACD:  20 97 ef
b15_ead0:   jmp $f008                   ; 3EAD0:  4c 08 f0
vm_op_8E_push_imm_word:   jsr $efbf                   ; 3EAD3:  20 bf ef
b15_ead6:   jmp $f008                   ; 3EAD6:  4c 08 f0
vm_op_8F_addA_imm_sbyte:   jsr $ef97                   ; 3EAD9:  20 97 ef
b15_eadc:   adc $08                     ; 3EADC:  65 08
b15_eade:   sta $08                     ; 3EADE:  85 08
b15_eae0:   txa                         ; 3EAE0:  8a
b15_eae1:   adc $09                     ; 3EAE1:  65 09
b15_eae3:   sta $09                     ; 3EAE3:  85 09
b15_eae5:   jmp $e867                   ; 3EAE5:  4c 67 e8
vm_op_90_bb:   jsr $efbf                   ; 3EAE8:  20 bf ef
b15_eaeb:   bcc $eadc                   ; 3EAEB:  90 ef
vm_op_A0_A3_byte:   jsr $efec                   ; 3EAED:  20 ec ef
b15_eaf0:   lda (scratch_ptr_lo),y                 ; 3EAF0:  b1 00
b15_eaf2:   sta $08                     ; 3EAF2:  85 08
b15_eaf4:   sty $09                     ; 3EAF4:  84 09
b15_eaf6:   jmp $e867                   ; 3EAF6:  4c 67 e8
vm_op_A5_loadA_mem_byte:   jsr $efd5                   ; 3EAF9:  20 d5 ef
b15_eafc:   bcc $eaf0                   ; 3EAFC:  90 f2
vm_op_A1_A3_byte:   jsr $efec                   ; 3EAFE:  20 ec ef
b15_eb01:   lda (scratch_ptr_lo),y                 ; 3EB01:  b1 00
b15_eb03:   sta $0c                     ; 3EB03:  85 0c
b15_eb05:   sty $0d                     ; 3EB05:  84 0d
b15_eb07:   jmp $e867                   ; 3EB07:  4c 67 e8
vm_op_A7_loadA_addr_word:   jsr $efd5                   ; 3EB0A:  20 d5 ef
b15_eb0d:   bcc $eb01                   ; 3EB0D:  90 f2
vm_op_A2_A3_byte:   jsr $efec                   ; 3EB0F:  20 ec ef
b15_eb12:   lda $08                     ; 3EB12:  a5 08
b15_eb14:   sta (scratch_ptr_lo),y                 ; 3EB14:  91 00
b15_eb16:   jmp $e867                   ; 3EB16:  4c 67 e8
vm_op_A9_storeA_mem_byte:   jsr $efd5                   ; 3EB19:  20 d5 ef
b15_eb1c:   bcc $eb12                   ; 3EB1C:  90 f4
vm_op_A3_A3_byte:   jsr $efec                   ; 3EB1E:  20 ec ef
b15_eb21:   lda (scratch_ptr_lo),y                 ; 3EB21:  b1 00
b15_eb23:   ldx #$00                    ; 3EB23:  a2 00
b15_eb25:   jmp $f008                   ; 3EB25:  4c 08 f0
vm_op_AB_word:   jsr $efd5                   ; 3EB28:  20 d5 ef
b15_eb2b:   bcc $eb21                   ; 3EB2B:  90 f4
vm_op_EA_host_call_indirect:   lda $08                     ; 3EB2D:  a5 08
b15_eb2f:   sta scratch_ptr_lo                     ; 3EB2F:  85 00
b15_eb31:   lda $09                     ; 3EB31:  a5 09
b15_eb33:   sta scratch_ptr_hi                     ; 3EB33:  85 01
b15_eb35:   jmp $eb3b                   ; 3EB35:  4c 3b eb
vm_op_E9_host_call:   jsr $efd5                   ; 3EB38:  20 d5 ef
b15_eb3b:   jsr $eb57                   ; 3EB3B:  20 57 eb
b15_eb3e:   ldy #$00                    ; 3EB3E:  a0 00
b15_eb40:   jmp $eb9e                   ; 3EB40:  4c 9e eb
vm_op_DD_host_call_indirect_simple:   lda $08                     ; 3EB43:  a5 08
b15_eb45:   sta scratch_ptr_lo                     ; 3EB45:  85 00
b15_eb47:   lda $09                     ; 3EB47:  a5 09
b15_eb49:   sta scratch_ptr_hi                     ; 3EB49:  85 01
b15_eb4b:   jmp $eb51                   ; 3EB4B:  4c 51 eb
vm_op_AC_host_call_simple:   jsr $efd5                   ; 3EB4E:  20 d5 ef
b15_eb51:   jsr $eb57                   ; 3EB51:  20 57 eb
b15_eb54:   jmp $e867                   ; 3EB54:  4c 67 e8
vm_call_native:   sec                         ; 3EB57:  38
b15_eb58:   lda vm_sp_lo                     ; 3EB58:  a5 02
b15_eb5a:   sbc #$02                    ; 3EB5A:  e9 02
b15_eb5c:   sta vm_sp_lo                     ; 3EB5C:  85 02
b15_eb5e:   bcs $eb62                   ; 3EB5E:  b0 02
b15_eb60:   dec vm_sp_hi                     ; 3EB60:  c6 03
b15_eb62:   lda vm_ip_lo                     ; 3EB62:  a5 06
b15_eb64:   sta (vm_sp_lo),y                 ; 3EB64:  91 02
b15_eb66:   iny                         ; 3EB66:  c8
b15_eb67:   lda vm_ip_hi                     ; 3EB67:  a5 07
b15_eb69:   sta (vm_sp_lo),y                 ; 3EB69:  91 02
b15_eb6b:   jsr $eb7a                   ; 3EB6B:  20 7a eb
b15_eb6e:   clc                         ; 3EB6E:  18
b15_eb6f:   lda vm_sp_lo                     ; 3EB6F:  a5 02
b15_eb71:   adc #$02                    ; 3EB71:  69 02
b15_eb73:   sta vm_sp_lo                     ; 3EB73:  85 02
b15_eb75:   bcc $eb79                   ; 3EB75:  90 02
b15_eb77:   inc vm_sp_hi                     ; 3EB77:  e6 03
b15_eb79:   rts                         ; 3EB79:  60
indirect_jmp_trampoline:   jmp (scratch_ptr_lo)                 ; 3EB7A:  6c 00 00
vm_op_AD_byte:   jsr $efbf                   ; 3EB7D:  20 bf ef
b15_eb80:   ldy #$00                    ; 3EB80:  a0 00
b15_eb82:   stx scratch_ptr_lo                     ; 3EB82:  86 00
b15_eb84:   tax                         ; 3EB84:  aa
b15_eb85:   bne $eb8e                   ; 3EB85:  d0 07
b15_eb87:   dec scratch_ptr_lo                     ; 3EB87:  c6 00
b15_eb89:   bpl $eb8e                   ; 3EB89:  10 03
b15_eb8b:   jmp $e867                   ; 3EB8B:  4c 67 e8
b15_eb8e:   lda ($08),y                 ; 3EB8E:  b1 08
b15_eb90:   sta ($0c),y                 ; 3EB90:  91 0c
b15_eb92:   iny                         ; 3EB92:  c8
b15_eb93:   bne $eb99                   ; 3EB93:  d0 04
b15_eb95:   inc $09                     ; 3EB95:  e6 09
b15_eb97:   inc $0d                     ; 3EB97:  e6 0d
b15_eb99:   dex                         ; 3EB99:  ca
b15_eb9a:   beq $eb87                   ; 3EB9A:  f0 eb
b15_eb9c:   bne $eb8e                   ; 3EB9C:  d0 f0
vm_dispatch_with_ptr1_adjust:   jsr $ef97                   ; 3EB9E:  20 97 ef
b15_eba1:   adc vm_sp_lo                     ; 3EBA1:  65 02
b15_eba3:   sta vm_sp_lo                     ; 3EBA3:  85 02
b15_eba5:   bcc $eba9                   ; 3EBA5:  90 02
b15_eba7:   inc vm_sp_hi                     ; 3EBA7:  e6 03
b15_eba9:   jmp $e867                   ; 3EBA9:  4c 67 e8
vm_op_AF:   jsr $efbf                   ; 3EBAC:  20 bf ef
b15_ebaf:   adc vm_sp_lo                     ; 3EBAF:  65 02
b15_ebb1:   sta vm_sp_lo                     ; 3EBB1:  85 02
b15_ebb3:   txa                         ; 3EBB3:  8a
b15_ebb4:   adc vm_sp_hi                     ; 3EBB4:  65 03
b15_ebb6:   sta vm_sp_hi                     ; 3EBB6:  85 03
b15_ebb8:   jmp $e867                   ; 3EBB8:  4c 67 e8
vm_op_D6_jump_abs:   jsr $efbf                   ; 3EBBB:  20 bf ef
b15_ebbe:   sta vm_ip_lo                     ; 3EBBE:  85 06
b15_ebc0:   stx vm_ip_hi                     ; 3EBC0:  86 07
b15_ebc2:   jmp $e867                   ; 3EBC2:  4c 67 e8
vm_op_D7_branch_nz_abs:   lda $08                     ; 3EBC5:  a5 08
b15_ebc7:   ora $09                     ; 3EBC7:  05 09
b15_ebc9:   bne $ebbb                   ; 3EBC9:  d0 f0
b15_ebcb:   jsr $efbf                   ; 3EBCB:  20 bf ef
b15_ebce:   jmp $e867                   ; 3EBCE:  4c 67 e8
vm_op_D8_branch_z_abs:   lda $08                     ; 3EBD1:  a5 08
b15_ebd3:   ora $09                     ; 3EBD3:  05 09
b15_ebd5:   beq $ebbb                   ; 3EBD5:  f0 e4
b15_ebd7:   bne $ebcb                   ; 3EBD7:  d0 f2
vm_op_E3:   jsr $ef97                   ; 3EBD9:  20 97 ef
b15_ebdc:   adc vm_ip_lo                     ; 3EBDC:  65 06
b15_ebde:   sta vm_ip_lo                     ; 3EBDE:  85 06
b15_ebe0:   bcs $ebe4                   ; 3EBE0:  b0 02
b15_ebe2:   dec vm_ip_hi                     ; 3EBE2:  c6 07
b15_ebe4:   jmp $e867                   ; 3EBE4:  4c 67 e8
vm_op_E4_branch_nz_rel:   lda $08                     ; 3EBE7:  a5 08
b15_ebe9:   ora $09                     ; 3EBE9:  05 09
b15_ebeb:   bne $ebd9                   ; 3EBEB:  d0 ec
b15_ebed:   jsr $ef97                   ; 3EBED:  20 97 ef
b15_ebf0:   jmp $e867                   ; 3EBF0:  4c 67 e8
vm_op_E5_branch_z_rel:   lda $08                     ; 3EBF3:  a5 08
b15_ebf5:   ora $09                     ; 3EBF5:  05 09
b15_ebf7:   beq $ebd9                   ; 3EBF7:  f0 e0
b15_ebf9:   bne $ebed                   ; 3EBF9:  d0 f2
vm_op_E6_jump_rel_fwd:   jsr $ef97                   ; 3EBFB:  20 97 ef
b15_ebfe:   adc vm_ip_lo                     ; 3EBFE:  65 06
b15_ec00:   sta vm_ip_lo                     ; 3EC00:  85 06
b15_ec02:   bcc $ec06                   ; 3EC02:  90 02
b15_ec04:   inc vm_ip_hi                     ; 3EC04:  e6 07
b15_ec06:   jmp $e867                   ; 3EC06:  4c 67 e8
vm_op_E7_branch_nz_rel_fwd:   lda $08                     ; 3EC09:  a5 08
b15_ec0b:   ora $09                     ; 3EC0B:  05 09
b15_ec0d:   bne $ebfb                   ; 3EC0D:  d0 ec
b15_ec0f:   jsr $ef97                   ; 3EC0F:  20 97 ef
b15_ec12:   jmp $e867                   ; 3EC12:  4c 67 e8
vm_op_E8_branch_z_rel_fwd:   lda $08                     ; 3EC15:  a5 08
b15_ec17:   ora $09                     ; 3EC17:  05 09
b15_ec19:   beq $ebfb                   ; 3EC19:  f0 e0
b15_ec1b:   bne $ec0f                   ; 3EC1B:  d0 f2
vm_op_D9_switch:   lda (vm_ip_lo),y                 ; 3EC1D:  b1 06
b15_ec1f:   tax                         ; 3EC1F:  aa
b15_ec20:   iny                         ; 3EC20:  c8
b15_ec21:   lda (vm_ip_lo),y                 ; 3EC21:  b1 06
b15_ec23:   sta $0c                     ; 3EC23:  85 0c
b15_ec25:   clc                         ; 3EC25:  18
b15_ec26:   lda vm_ip_lo                     ; 3EC26:  a5 06
b15_ec28:   adc #$02                    ; 3EC28:  69 02
b15_ec2a:   sta vm_ip_lo                     ; 3EC2A:  85 06
b15_ec2c:   bcc $ec30                   ; 3EC2C:  90 02
b15_ec2e:   inc vm_ip_hi                     ; 3EC2E:  e6 07
b15_ec30:   ldy #$00                    ; 3EC30:  a0 00
b15_ec32:   txa                         ; 3EC32:  8a
b15_ec33:   bne $ec3c                   ; 3EC33:  d0 07
b15_ec35:   dec $0c                     ; 3EC35:  c6 0c
b15_ec37:   bpl $ec3c                   ; 3EC37:  10 03
b15_ec39:   dey                         ; 3EC39:  88
b15_ec3a:   bne $ec57                   ; 3EC3A:  d0 1b
b15_ec3c:   dex                         ; 3EC3C:  ca
b15_ec3d:   lda (vm_ip_lo),y                 ; 3EC3D:  b1 06
b15_ec3f:   cmp $08                     ; 3EC3F:  c5 08
b15_ec41:   bne $ec4a                   ; 3EC41:  d0 07
b15_ec43:   iny                         ; 3EC43:  c8
b15_ec44:   lda (vm_ip_lo),y                 ; 3EC44:  b1 06
b15_ec46:   cmp $09                     ; 3EC46:  c5 09
b15_ec48:   beq $ec57                   ; 3EC48:  f0 0d
b15_ec4a:   clc                         ; 3EC4A:  18
b15_ec4b:   lda vm_ip_lo                     ; 3EC4B:  a5 06
b15_ec4d:   adc #$04                    ; 3EC4D:  69 04
b15_ec4f:   sta vm_ip_lo                     ; 3EC4F:  85 06
b15_ec51:   bcc $ec30                   ; 3EC51:  90 dd
b15_ec53:   inc vm_ip_hi                     ; 3EC53:  e6 07
b15_ec55:   bcs $ec30                   ; 3EC55:  b0 d9
b15_ec57:   iny                         ; 3EC57:  c8
b15_ec58:   lda (vm_ip_lo),y                 ; 3EC58:  b1 06
b15_ec5a:   tax                         ; 3EC5A:  aa
b15_ec5b:   iny                         ; 3EC5B:  c8
b15_ec5c:   lda (vm_ip_lo),y                 ; 3EC5C:  b1 06
b15_ec5e:   sta vm_ip_hi                     ; 3EC5E:  85 07
b15_ec60:   stx vm_ip_lo                     ; 3EC60:  86 06
b15_ec62:   jmp $e867                   ; 3EC62:  4c 67 e8
vm_op_D5_switch:   clc                         ; 3EC65:  18
b15_ec66:   lda (vm_ip_lo),y                 ; 3EC66:  b1 06
b15_ec68:   adc $08                     ; 3EC68:  65 08
b15_ec6a:   sta $08                     ; 3EC6A:  85 08
b15_ec6c:   iny                         ; 3EC6C:  c8
b15_ec6d:   lda (vm_ip_lo),y                 ; 3EC6D:  b1 06
b15_ec6f:   adc $09                     ; 3EC6F:  65 09
b15_ec71:   sta $09                     ; 3EC71:  85 09
b15_ec73:   iny                         ; 3EC73:  c8
b15_ec74:   lda $08                     ; 3EC74:  a5 08
b15_ec76:   cmp (vm_ip_lo),y                 ; 3EC76:  d1 06
b15_ec78:   iny                         ; 3EC78:  c8
b15_ec79:   lda $09                     ; 3EC79:  a5 09
b15_ec7b:   sbc (vm_ip_lo),y                 ; 3EC7B:  f1 06
b15_ec7d:   iny                         ; 3EC7D:  c8
b15_ec7e:   bcs $ec91                   ; 3EC7E:  b0 11
b15_ec80:   lda $08                     ; 3EC80:  a5 08
b15_ec82:   asl a                       ; 3EC82:  0a
b15_ec83:   rol $09                     ; 3EC83:  26 09
b15_ec85:   adc vm_ip_lo                     ; 3EC85:  65 06
b15_ec87:   sta vm_ip_lo                     ; 3EC87:  85 06
b15_ec89:   lda $09                     ; 3EC89:  a5 09
b15_ec8b:   adc vm_ip_hi                     ; 3EC8B:  65 07
b15_ec8d:   sta vm_ip_hi                     ; 3EC8D:  85 07
b15_ec8f:   ldy #$06                    ; 3EC8F:  a0 06
b15_ec91:   lda (vm_ip_lo),y                 ; 3EC91:  b1 06
b15_ec93:   tax                         ; 3EC93:  aa
b15_ec94:   iny                         ; 3EC94:  c8
b15_ec95:   lda (vm_ip_lo),y                 ; 3EC95:  b1 06
b15_ec97:   sta vm_ip_hi                     ; 3EC97:  85 07
b15_ec99:   stx vm_ip_lo                     ; 3EC99:  86 06
b15_ec9b:   jmp $e867                   ; 3EC9B:  4c 67 e8
vm_op_B0_loadA_ind_word:   lda ($08),y                 ; 3EC9E:  b1 08
b15_eca0:   tax                         ; 3ECA0:  aa
b15_eca1:   iny                         ; 3ECA1:  c8
b15_eca2:   lda ($08),y                 ; 3ECA2:  b1 08
b15_eca4:   stx $08                     ; 3ECA4:  86 08
b15_eca6:   sta $09                     ; 3ECA6:  85 09
b15_eca8:   jmp $e867                   ; 3ECA8:  4c 67 e8
vm_op_D3_loadA_ind_byte:   lda ($08),y                 ; 3ECAB:  b1 08
b15_ecad:   sta $08                     ; 3ECAD:  85 08
b15_ecaf:   sty $09                     ; 3ECAF:  84 09
b15_ecb1:   jmp $e867                   ; 3ECB1:  4c 67 e8
vm_op_B1_storeA_ind_word:   jsr $ecdb                   ; 3ECB4:  20 db ec
b15_ecb7:   lda $09                     ; 3ECB7:  a5 09
b15_ecb9:   sta ($0c),y                 ; 3ECB9:  91 0c
b15_ecbb:   dey                         ; 3ECBB:  88
b15_ecbc:   lda $08                     ; 3ECBC:  a5 08
b15_ecbe:   sta ($0c),y                 ; 3ECBE:  91 0c
b15_ecc0:   jmp $e867                   ; 3ECC0:  4c 67 e8
vm_op_D4_storeA_ind_byte:   jsr $ecdb                   ; 3ECC3:  20 db ec
b15_ecc6:   dey                         ; 3ECC6:  88
b15_ecc7:   lda $08                     ; 3ECC7:  a5 08
b15_ecc9:   sta ($0c),y                 ; 3ECC9:  91 0c
b15_eccb:   jmp $e867                   ; 3ECCB:  4c 67 e8
vm_op_B3_pushA:   lda $08                     ; 3ECCE:  a5 08
b15_ecd0:   ldx $09                     ; 3ECD0:  a6 09
b15_ecd2:   jmp $f008                   ; 3ECD2:  4c 08 f0
vm_op_B4_popB:   jsr $ecdb                   ; 3ECD5:  20 db ec
b15_ecd8:   jmp $e867                   ; 3ECD8:  4c 67 e8
vm_pop_operand16:   lda (vm_sp_lo),y                 ; 3ECDB:  b1 02
b15_ecdd:   sta $0c                     ; 3ECDD:  85 0c
b15_ecdf:   iny                         ; 3ECDF:  c8
b15_ece0:   lda (vm_sp_lo),y                 ; 3ECE0:  b1 02
b15_ece2:   sta $0d                     ; 3ECE2:  85 0d
b15_ece4:   clc                         ; 3ECE4:  18
b15_ece5:   lda vm_sp_lo                     ; 3ECE5:  a5 02
b15_ece7:   adc #$02                    ; 3ECE7:  69 02
b15_ece9:   sta vm_sp_lo                     ; 3ECE9:  85 02
b15_eceb:   bcc $ecef                   ; 3ECEB:  90 02
b15_eced:   inc vm_sp_hi                     ; 3ECED:  e6 03
b15_ecef:   rts                         ; 3ECEF:  60
vm_op_B5_mul:   ldy #$00                    ; 3ECF0:  a0 00
b15_ecf2:   sty scratch_ptr_lo                     ; 3ECF2:  84 00
b15_ecf4:   sty scratch_ptr_hi                     ; 3ECF4:  84 01
b15_ecf6:   ldy #$10                    ; 3ECF6:  a0 10
b15_ecf8:   lda $08                     ; 3ECF8:  a5 08
b15_ecfa:   lsr a                       ; 3ECFA:  4a
b15_ecfb:   bcc $ed0a                   ; 3ECFB:  90 0d
b15_ecfd:   clc                         ; 3ECFD:  18
b15_ecfe:   lda scratch_ptr_lo                     ; 3ECFE:  a5 00
b15_ed00:   adc $0c                     ; 3ED00:  65 0c
b15_ed02:   sta scratch_ptr_lo                     ; 3ED02:  85 00
b15_ed04:   lda scratch_ptr_hi                     ; 3ED04:  a5 01
b15_ed06:   adc $0d                     ; 3ED06:  65 0d
b15_ed08:   sta scratch_ptr_hi                     ; 3ED08:  85 01
b15_ed0a:   ror scratch_ptr_hi                     ; 3ED0A:  66 01
b15_ed0c:   ror scratch_ptr_lo                     ; 3ED0C:  66 00
b15_ed0e:   ror $09                     ; 3ED0E:  66 09
b15_ed10:   ror $08                     ; 3ED10:  66 08
b15_ed12:   dey                         ; 3ED12:  88
b15_ed13:   bne $ecf8                   ; 3ED13:  d0 e3
b15_ed15:   jmp $e867                   ; 3ED15:  4c 67 e8
vm_op_B8_div_unsigned:   jsr $ed2e                   ; 3ED18:  20 2e ed
b15_ed1b:   jmp $e867                   ; 3ED1B:  4c 67 e8
vm_op_B6_div_signed:   jsr $ed7a                   ; 3ED1E:  20 7a ed
b15_ed21:   jsr $ed2e                   ; 3ED21:  20 2e ed
b15_ed24:   lda $0a                     ; 3ED24:  a5 0a
b15_ed26:   bpl $ed2b                   ; 3ED26:  10 03
b15_ed28:   jmp $ef09                   ; 3ED28:  4c 09 ef
b15_ed2b:   jmp $e867                   ; 3ED2B:  4c 67 e8
udiv16:   ldy #$00                    ; 3ED2E:  a0 00
b15_ed30:   sty scratch_ptr_lo                     ; 3ED30:  84 00
b15_ed32:   sty scratch_ptr_hi                     ; 3ED32:  84 01
b15_ed34:   ldy #$10                    ; 3ED34:  a0 10
b15_ed36:   asl $08                     ; 3ED36:  06 08
b15_ed38:   rol $09                     ; 3ED38:  26 09
b15_ed3a:   rol scratch_ptr_lo                     ; 3ED3A:  26 00
b15_ed3c:   rol scratch_ptr_hi                     ; 3ED3C:  26 01
b15_ed3e:   sec                         ; 3ED3E:  38
b15_ed3f:   lda scratch_ptr_lo                     ; 3ED3F:  a5 00
b15_ed41:   sbc $0c                     ; 3ED41:  e5 0c
b15_ed43:   tax                         ; 3ED43:  aa
b15_ed44:   lda scratch_ptr_hi                     ; 3ED44:  a5 01
b15_ed46:   sbc $0d                     ; 3ED46:  e5 0d
b15_ed48:   bcc $ed50                   ; 3ED48:  90 06
b15_ed4a:   stx scratch_ptr_lo                     ; 3ED4A:  86 00
b15_ed4c:   sta scratch_ptr_hi                     ; 3ED4C:  85 01
b15_ed4e:   inc $08                     ; 3ED4E:  e6 08
b15_ed50:   dey                         ; 3ED50:  88
b15_ed51:   bne $ed36                   ; 3ED51:  d0 e3
b15_ed53:   rts                         ; 3ED53:  60
vm_op_B9_mod_signed:   jsr $ed7a                   ; 3ED54:  20 7a ed
b15_ed57:   jsr $ed2e                   ; 3ED57:  20 2e ed
b15_ed5a:   lda scratch_ptr_lo                     ; 3ED5A:  a5 00
b15_ed5c:   sta $08                     ; 3ED5C:  85 08
b15_ed5e:   lda scratch_ptr_hi                     ; 3ED5E:  a5 01
b15_ed60:   sta $09                     ; 3ED60:  85 09
b15_ed62:   lda $0b                     ; 3ED62:  a5 0b
b15_ed64:   bpl $ed69                   ; 3ED64:  10 03
b15_ed66:   jmp $ef09                   ; 3ED66:  4c 09 ef
b15_ed69:   jmp $e867                   ; 3ED69:  4c 67 e8
vm_op_BA_mod_unsigned:   jsr $ed2e                   ; 3ED6C:  20 2e ed
b15_ed6f:   lda scratch_ptr_lo                     ; 3ED6F:  a5 00
b15_ed71:   sta $08                     ; 3ED71:  85 08
b15_ed73:   lda scratch_ptr_hi                     ; 3ED73:  a5 01
b15_ed75:   sta $09                     ; 3ED75:  85 09
b15_ed77:   jmp $e867                   ; 3ED77:  4c 67 e8
sdiv16_setup_signs:   lda $09                     ; 3ED7A:  a5 09
b15_ed7c:   sta $0b                     ; 3ED7C:  85 0b
b15_ed7e:   eor $0d                     ; 3ED7E:  45 0d
b15_ed80:   sta $0a                     ; 3ED80:  85 0a
b15_ed82:   lda $09                     ; 3ED82:  a5 09
b15_ed84:   bpl $ed91                   ; 3ED84:  10 0b
b15_ed86:   sec                         ; 3ED86:  38
b15_ed87:   tya                         ; 3ED87:  98
b15_ed88:   sbc $08                     ; 3ED88:  e5 08
b15_ed8a:   sta $08                     ; 3ED8A:  85 08
b15_ed8c:   tya                         ; 3ED8C:  98
b15_ed8d:   sbc $09                     ; 3ED8D:  e5 09
b15_ed8f:   sta $09                     ; 3ED8F:  85 09
b15_ed91:   lda $0d                     ; 3ED91:  a5 0d
b15_ed93:   bpl $eda0                   ; 3ED93:  10 0b
b15_ed95:   sec                         ; 3ED95:  38
b15_ed96:   tya                         ; 3ED96:  98
b15_ed97:   sbc $0c                     ; 3ED97:  e5 0c
b15_ed99:   sta $0c                     ; 3ED99:  85 0c
b15_ed9b:   tya                         ; 3ED9B:  98
b15_ed9c:   sbc $0d                     ; 3ED9C:  e5 0d
b15_ed9e:   sta $0d                     ; 3ED9E:  85 0d
b15_eda0:   rts                         ; 3EDA0:  60
vm_op_BB_add:   clc                         ; 3EDA1:  18
b15_eda2:   lda $08                     ; 3EDA2:  a5 08
b15_eda4:   adc $0c                     ; 3EDA4:  65 0c
b15_eda6:   sta $08                     ; 3EDA6:  85 08
b15_eda8:   lda $09                     ; 3EDA8:  a5 09
b15_edaa:   adc $0d                     ; 3EDAA:  65 0d
b15_edac:   sta $09                     ; 3EDAC:  85 09
b15_edae:   jmp $e867                   ; 3EDAE:  4c 67 e8
vm_op_BC_sub:   sec                         ; 3EDB1:  38
b15_edb2:   lda $08                     ; 3EDB2:  a5 08
b15_edb4:   sbc $0c                     ; 3EDB4:  e5 0c
b15_edb6:   sta $08                     ; 3EDB6:  85 08
b15_edb8:   lda $09                     ; 3EDB8:  a5 09
b15_edba:   sbc $0d                     ; 3EDBA:  e5 0d
b15_edbc:   sta $09                     ; 3EDBC:  85 09
b15_edbe:   jmp $e867                   ; 3EDBE:  4c 67 e8
vm_op_BD_shl_by_regB:   ldx $0c                     ; 3EDC1:  a6 0c
b15_edc3:   bne $edcc                   ; 3EDC3:  d0 07
b15_edc5:   dec $0d                     ; 3EDC5:  c6 0d
b15_edc7:   bpl $edcc                   ; 3EDC7:  10 03
b15_edc9:   jmp $e867                   ; 3EDC9:  4c 67 e8
b15_edcc:   asl $08                     ; 3EDCC:  06 08
b15_edce:   rol $09                     ; 3EDCE:  26 09
b15_edd0:   dex                         ; 3EDD0:  ca
b15_edd1:   beq $edc5                   ; 3EDD1:  f0 f2
b15_edd3:   bne $edcc                   ; 3EDD3:  d0 f7
vm_op_BF_ashr_by_regB:   lda $09                     ; 3EDD5:  a5 09
b15_edd7:   bpl $edee                   ; 3EDD7:  10 15
b15_edd9:   ldx $0c                     ; 3EDD9:  a6 0c
b15_eddb:   bne $ede4                   ; 3EDDB:  d0 07
b15_eddd:   dec $0d                     ; 3EDDD:  c6 0d
b15_eddf:   bpl $ede4                   ; 3EDDF:  10 03
b15_ede1:   jmp $e867                   ; 3EDE1:  4c 67 e8
b15_ede4:   sec                         ; 3EDE4:  38
b15_ede5:   ror $09                     ; 3EDE5:  66 09
b15_ede7:   ror $08                     ; 3EDE7:  66 08
b15_ede9:   dex                         ; 3EDE9:  ca
b15_edea:   beq $eddd                   ; 3EDEA:  f0 f1
b15_edec:   bne $ede4                   ; 3EDEC:  d0 f6
vm_op_BE_lshr_by_regB:   ldx $0c                     ; 3EDEE:  a6 0c
b15_edf0:   bne $edf9                   ; 3EDF0:  d0 07
b15_edf2:   dec $0d                     ; 3EDF2:  c6 0d
b15_edf4:   bpl $edf9                   ; 3EDF4:  10 03
b15_edf6:   jmp $e867                   ; 3EDF6:  4c 67 e8
b15_edf9:   lsr $09                     ; 3EDF9:  46 09
b15_edfb:   ror $08                     ; 3EDFB:  66 08
b15_edfd:   dex                         ; 3EDFD:  ca
b15_edfe:   beq $edf2                   ; 3EDFE:  f0 f2
b15_ee00:   bne $edf9                   ; 3EE00:  d0 f7
vm_op_DA_bitand:   lda $08                     ; 3EE02:  a5 08
b15_ee04:   and $0c                     ; 3EE04:  25 0c
b15_ee06:   sta $08                     ; 3EE06:  85 08
b15_ee08:   lda $09                     ; 3EE08:  a5 09
b15_ee0a:   and $0d                     ; 3EE0A:  25 0d
b15_ee0c:   sta $09                     ; 3EE0C:  85 09
b15_ee0e:   jmp $e867                   ; 3EE0E:  4c 67 e8
vm_op_DB_bitor:   lda $08                     ; 3EE11:  a5 08
b15_ee13:   ora $0c                     ; 3EE13:  05 0c
b15_ee15:   sta $08                     ; 3EE15:  85 08
b15_ee17:   lda $09                     ; 3EE17:  a5 09
b15_ee19:   ora $0d                     ; 3EE19:  05 0d
b15_ee1b:   sta $09                     ; 3EE1B:  85 09
b15_ee1d:   jmp $e867                   ; 3EE1D:  4c 67 e8
vm_op_DC_bitxor:   lda $08                     ; 3EE20:  a5 08
b15_ee22:   eor $0c                     ; 3EE22:  45 0c
b15_ee24:   sta $08                     ; 3EE24:  85 08
b15_ee26:   lda $09                     ; 3EE26:  a5 09
b15_ee28:   eor $0d                     ; 3EE28:  45 0d
b15_ee2a:   sta $09                     ; 3EE2A:  85 09
b15_ee2c:   jmp $e867                   ; 3EE2C:  4c 67 e8
vm_op_C0_cmp_eq:   lda $09                     ; 3EE2F:  a5 09
b15_ee31:   cmp $0d                     ; 3EE31:  c5 0d
b15_ee33:   sty $09                     ; 3EE33:  84 09
b15_ee35:   bne $ee3e                   ; 3EE35:  d0 07
b15_ee37:   lda $08                     ; 3EE37:  a5 08
b15_ee39:   cmp $0c                     ; 3EE39:  c5 0c
b15_ee3b:   bne $ee3e                   ; 3EE3B:  d0 01
b15_ee3d:   iny                         ; 3EE3D:  c8
b15_ee3e:   sty $08                     ; 3EE3E:  84 08
b15_ee40:   jmp $e867                   ; 3EE40:  4c 67 e8
vm_op_C1_cmp_ne:   lda $09                     ; 3EE43:  a5 09
b15_ee45:   cmp $0d                     ; 3EE45:  c5 0d
b15_ee47:   sty $09                     ; 3EE47:  84 09
b15_ee49:   bne $ee51                   ; 3EE49:  d0 06
b15_ee4b:   lda $08                     ; 3EE4B:  a5 08
b15_ee4d:   cmp $0c                     ; 3EE4D:  c5 0c
b15_ee4f:   beq $ee52                   ; 3EE4F:  f0 01
b15_ee51:   iny                         ; 3EE51:  c8
b15_ee52:   sty $08                     ; 3EE52:  84 08
b15_ee54:   jmp $e867                   ; 3EE54:  4c 67 e8
vm_op_C2_cmp_slt:   lda $08                     ; 3EE57:  a5 08
b15_ee59:   cmp $0c                     ; 3EE59:  c5 0c
b15_ee5b:   lda $09                     ; 3EE5B:  a5 09
b15_ee5d:   sbc $0d                     ; 3EE5D:  e5 0d
b15_ee5f:   sty $09                     ; 3EE5F:  84 09
b15_ee61:   bpl $ee64                   ; 3EE61:  10 01
b15_ee63:   iny                         ; 3EE63:  c8
b15_ee64:   tya                         ; 3EE64:  98
b15_ee65:   bvc $ee69                   ; 3EE65:  50 02
b15_ee67:   eor #$01                    ; 3EE67:  49 01
b15_ee69:   sta $08                     ; 3EE69:  85 08
b15_ee6b:   jmp $e867                   ; 3EE6B:  4c 67 e8
vm_op_C4_cmp_sgt:   lda $0c                     ; 3EE6E:  a5 0c
b15_ee70:   cmp $08                     ; 3EE70:  c5 08
b15_ee72:   lda $0d                     ; 3EE72:  a5 0d
b15_ee74:   sbc $09                     ; 3EE74:  e5 09
b15_ee76:   sty $09                     ; 3EE76:  84 09
b15_ee78:   bpl $ee7b                   ; 3EE78:  10 01
b15_ee7a:   iny                         ; 3EE7A:  c8
b15_ee7b:   tya                         ; 3EE7B:  98
b15_ee7c:   bvc $ee80                   ; 3EE7C:  50 02
b15_ee7e:   eor #$01                    ; 3EE7E:  49 01
b15_ee80:   sta $08                     ; 3EE80:  85 08
b15_ee82:   jmp $e867                   ; 3EE82:  4c 67 e8
vm_op_C3_cmp_sge:   lda $0c                     ; 3EE85:  a5 0c
b15_ee87:   cmp $08                     ; 3EE87:  c5 08
b15_ee89:   lda $0d                     ; 3EE89:  a5 0d
b15_ee8b:   sbc $09                     ; 3EE8B:  e5 09
b15_ee8d:   sty $09                     ; 3EE8D:  84 09
b15_ee8f:   bmi $ee92                   ; 3EE8F:  30 01
b15_ee91:   iny                         ; 3EE91:  c8
b15_ee92:   tya                         ; 3EE92:  98
b15_ee93:   bvc $ee97                   ; 3EE93:  50 02
b15_ee95:   eor #$01                    ; 3EE95:  49 01
b15_ee97:   sta $08                     ; 3EE97:  85 08
b15_ee99:   jmp $e867                   ; 3EE99:  4c 67 e8
vm_op_C5_cmp_sle:   lda $08                     ; 3EE9C:  a5 08
b15_ee9e:   cmp $0c                     ; 3EE9E:  c5 0c
b15_eea0:   lda $09                     ; 3EEA0:  a5 09
b15_eea2:   sbc $0d                     ; 3EEA2:  e5 0d
b15_eea4:   sty $09                     ; 3EEA4:  84 09
b15_eea6:   bmi $eea9                   ; 3EEA6:  30 01
b15_eea8:   iny                         ; 3EEA8:  c8
b15_eea9:   tya                         ; 3EEA9:  98
b15_eeaa:   bvc $eeae                   ; 3EEAA:  50 02
b15_eeac:   eor #$01                    ; 3EEAC:  49 01
b15_eeae:   sta $08                     ; 3EEAE:  85 08
b15_eeb0:   jmp $e867                   ; 3EEB0:  4c 67 e8
vm_op_C6_cmp_uge:   lda $08                     ; 3EEB3:  a5 08
b15_eeb5:   cmp $0c                     ; 3EEB5:  c5 0c
b15_eeb7:   lda $09                     ; 3EEB7:  a5 09
b15_eeb9:   sbc $0d                     ; 3EEB9:  e5 0d
b15_eebb:   sty $09                     ; 3EEBB:  84 09
b15_eebd:   bcs $eec0                   ; 3EEBD:  b0 01
b15_eebf:   iny                         ; 3EEBF:  c8
b15_eec0:   sty $08                     ; 3EEC0:  84 08
b15_eec2:   jmp $e867                   ; 3EEC2:  4c 67 e8
vm_op_C8_cmp_ugt:   lda $0c                     ; 3EEC5:  a5 0c
b15_eec7:   cmp $08                     ; 3EEC7:  c5 08
b15_eec9:   lda $0d                     ; 3EEC9:  a5 0d
b15_eecb:   sbc $09                     ; 3EECB:  e5 09
b15_eecd:   sty $09                     ; 3EECD:  84 09
b15_eecf:   bcs $eed2                   ; 3EECF:  b0 01
b15_eed1:   iny                         ; 3EED1:  c8
b15_eed2:   sty $08                     ; 3EED2:  84 08
b15_eed4:   jmp $e867                   ; 3EED4:  4c 67 e8
vm_op_C7_cmp_ule:   lda $0c                     ; 3EED7:  a5 0c
b15_eed9:   cmp $08                     ; 3EED9:  c5 08
b15_eedb:   lda $0d                     ; 3EEDB:  a5 0d
b15_eedd:   sbc $09                     ; 3EEDD:  e5 09
b15_eedf:   sty $09                     ; 3EEDF:  84 09
b15_eee1:   bcc $eee4                   ; 3EEE1:  90 01
b15_eee3:   iny                         ; 3EEE3:  c8
b15_eee4:   sty $08                     ; 3EEE4:  84 08
b15_eee6:   jmp $e867                   ; 3EEE6:  4c 67 e8
vm_op_C9_cmp_ult:   lda $08                     ; 3EEE9:  a5 08
b15_eeeb:   cmp $0c                     ; 3EEEB:  c5 0c
b15_eeed:   lda $09                     ; 3EEED:  a5 09
b15_eeef:   sbc $0d                     ; 3EEEF:  e5 0d
b15_eef1:   sty $09                     ; 3EEF1:  84 09
b15_eef3:   bcc $eef6                   ; 3EEF3:  90 01
b15_eef5:   iny                         ; 3EEF5:  c8
b15_eef6:   sty $08                     ; 3EEF6:  84 08
b15_eef8:   jmp $e867                   ; 3EEF8:  4c 67 e8
vm_op_CA_is_zero:   lda $09                     ; 3EEFB:  a5 09
b15_eefd:   sty $09                     ; 3EEFD:  84 09
b15_eeff:   ora $08                     ; 3EEFF:  05 08
b15_ef01:   bne $ef04                   ; 3EF01:  d0 01
b15_ef03:   iny                         ; 3EF03:  c8
b15_ef04:   sty $08                     ; 3EF04:  84 08
b15_ef06:   jmp $e867                   ; 3EF06:  4c 67 e8
vm_op_CB:   sec                         ; 3EF09:  38
b15_ef0a:   tya                         ; 3EF0A:  98
b15_ef0b:   sbc $08                     ; 3EF0B:  e5 08
b15_ef0d:   sta $08                     ; 3EF0D:  85 08
b15_ef0f:   tya                         ; 3EF0F:  98
b15_ef10:   sbc $09                     ; 3EF10:  e5 09
b15_ef12:   sta $09                     ; 3EF12:  85 09
b15_ef14:   jmp $e867                   ; 3EF14:  4c 67 e8
vm_op_CC:   lda $08                     ; 3EF17:  a5 08
b15_ef19:   eor #$ff                    ; 3EF19:  49 ff
b15_ef1b:   sta $08                     ; 3EF1B:  85 08
b15_ef1d:   lda $09                     ; 3EF1D:  a5 09
b15_ef1f:   eor #$ff                    ; 3EF1F:  49 ff
b15_ef21:   sta $09                     ; 3EF21:  85 09
b15_ef23:   jmp $e867                   ; 3EF23:  4c 67 e8
vm_op_CD_swap_AB:   lda $08                     ; 3EF26:  a5 08
b15_ef28:   ldx $0c                     ; 3EF28:  a6 0c
b15_ef2a:   stx $08                     ; 3EF2A:  86 08
b15_ef2c:   sta $0c                     ; 3EF2C:  85 0c
b15_ef2e:   lda $09                     ; 3EF2E:  a5 09
b15_ef30:   ldx $0d                     ; 3EF30:  a6 0d
b15_ef32:   stx $09                     ; 3EF32:  86 09
b15_ef34:   sta $0d                     ; 3EF34:  85 0d
b15_ef36:   jmp $e867                   ; 3EF36:  4c 67 e8
vm_op_D0_incA:   inc $08                     ; 3EF39:  e6 08
b15_ef3b:   bne $ef3f                   ; 3EF3B:  d0 02
b15_ef3d:   inc $09                     ; 3EF3D:  e6 09
b15_ef3f:   jmp $e867                   ; 3EF3F:  4c 67 e8
vm_op_D1_decA:   lda $08                     ; 3EF42:  a5 08
b15_ef44:   bne $ef48                   ; 3EF44:  d0 02
b15_ef46:   dec $09                     ; 3EF46:  c6 09
b15_ef48:   dec $08                     ; 3EF48:  c6 08
b15_ef4a:   jmp $e867                   ; 3EF4A:  4c 67 e8
vm_op_D2_aslA:   asl $08                     ; 3EF4D:  06 08
b15_ef4f:   rol $09                     ; 3EF4F:  26 09
b15_ef51:   jmp $e867                   ; 3EF51:  4c 67 e8
vm_op_E0_byte:   jsr $efbf                   ; 3EF54:  20 bf ef
b15_ef57:   ldy #$08                    ; 3EF57:  a0 08
b15_ef59:   jsr $f603                   ; 3EF59:  20 03 f6
b15_ef5c:   jmp $e867                   ; 3EF5C:  4c 67 e8
vm_op_E1_byte:   jsr $efbf                   ; 3EF5F:  20 bf ef
b15_ef62:   ldy #$08                    ; 3EF62:  a0 08
b15_ef64:   jsr $f5cd                   ; 3EF64:  20 cd f5
b15_ef67:   jmp $e867                   ; 3EF67:  4c 67 e8
vm_op_E2_byte:   jsr $efbf                   ; 3EF6A:  20 bf ef
b15_ef6d:   ldy #$0c                    ; 3EF6D:  a0 0c
b15_ef6f:   jsr $f62c                   ; 3EF6F:  20 2c f6
b15_ef72:   jmp $e867                   ; 3EF72:  4c 67 e8
vm_op_CF_vm_return:   ldy #$07                    ; 3EF75:  a0 07
b15_ef77:   lda vm_fp_lo                     ; 3EF77:  a5 04
b15_ef79:   sta $0c                     ; 3EF79:  85 0c
b15_ef7b:   lda vm_fp_hi                     ; 3EF7B:  a5 05
b15_ef7d:   sta $0d                     ; 3EF7D:  85 0d
b15_ef7f:   lda ($0c),y                 ; 3EF7F:  b1 0c
b15_ef81:   sta scratch_ptr_lo,y                 ; 3EF81:  99 00 00
b15_ef84:   dey                         ; 3EF84:  88
b15_ef85:   bpl $ef7f                   ; 3EF85:  10 f8
b15_ef87:   inc scratch_ptr_lo                     ; 3EF87:  e6 00
b15_ef89:   bne $ef8f                   ; 3EF89:  d0 04
b15_ef8b:   inc scratch_ptr_hi                     ; 3EF8B:  e6 01
b15_ef8d:   ldx #$00                    ; 3EF8D:  a2 00
b15_ef8f:   jmp (scratch_ptr_lo)                 ; 3EF8F:  6c 00 00
vm_op_trigger_syscall_shared:   brk                         ; 3EF92:  00
vm_op_FF:   brk                         ; 3EF93:  00
b15_ef94:   jmp $e867                   ; 3EF94:  4c 67 e8
vm_fetch_sbyte:   ldx #$00                    ; 3EF97:  a2 00
b15_ef99:   lda (vm_ip_lo),y                 ; 3EF99:  b1 06
b15_ef9b:   bpl $ef9e                   ; 3EF9B:  10 01
b15_ef9d:   dex                         ; 3EF9D:  ca
b15_ef9e:   inc vm_ip_lo                     ; 3EF9E:  e6 06
b15_efa0:   bne $efa4                   ; 3EFA0:  d0 02
b15_efa2:   inc vm_ip_hi                     ; 3EFA2:  e6 07
b15_efa4:   clc                         ; 3EFA4:  18
b15_efa5:   rts                         ; 3EFA5:  60
vm_addr_ptr2_plus_sbyte:   clc                         ; 3EFA6:  18
b15_efa7:   ldx #$00                    ; 3EFA7:  a2 00
b15_efa9:   lda (vm_ip_lo),y                 ; 3EFA9:  b1 06
b15_efab:   bpl $efae                   ; 3EFAB:  10 01
b15_efad:   dex                         ; 3EFAD:  ca
b15_efae:   adc vm_fp_lo                     ; 3EFAE:  65 04
b15_efb0:   sta scratch_ptr_lo                     ; 3EFB0:  85 00
b15_efb2:   txa                         ; 3EFB2:  8a
b15_efb3:   adc vm_fp_hi                     ; 3EFB3:  65 05
b15_efb5:   sta scratch_ptr_hi                     ; 3EFB5:  85 01
b15_efb7:   inc vm_ip_lo                     ; 3EFB7:  e6 06
b15_efb9:   bne $efbd                   ; 3EFB9:  d0 02
b15_efbb:   inc vm_ip_hi                     ; 3EFBB:  e6 07
b15_efbd:   clc                         ; 3EFBD:  18
b15_efbe:   rts                         ; 3EFBE:  60
vm_fetch_word:   iny                         ; 3EFBF:  c8
b15_efc0:   lda (vm_ip_lo),y                 ; 3EFC0:  b1 06
b15_efc2:   tax                         ; 3EFC2:  aa
b15_efc3:   dey                         ; 3EFC3:  88
b15_efc4:   lda (vm_ip_lo),y                 ; 3EFC4:  b1 06
b15_efc6:   pha                         ; 3EFC6:  48
b15_efc7:   clc                         ; 3EFC7:  18
b15_efc8:   lda vm_ip_lo                     ; 3EFC8:  a5 06
b15_efca:   adc #$02                    ; 3EFCA:  69 02
b15_efcc:   sta vm_ip_lo                     ; 3EFCC:  85 06
b15_efce:   bcc $efd3                   ; 3EFCE:  90 03
b15_efd0:   inc vm_ip_hi                     ; 3EFD0:  e6 07
b15_efd2:   clc                         ; 3EFD2:  18
b15_efd3:   pla                         ; 3EFD3:  68
b15_efd4:   rts                         ; 3EFD4:  60
vm_read_word_into_ptr0:   lda (vm_ip_lo),y                 ; 3EFD5:  b1 06
b15_efd7:   sta scratch_ptr_lo                     ; 3EFD7:  85 00
b15_efd9:   iny                         ; 3EFD9:  c8
b15_efda:   lda (vm_ip_lo),y                 ; 3EFDA:  b1 06
b15_efdc:   sta scratch_ptr_hi                     ; 3EFDC:  85 01
b15_efde:   dey                         ; 3EFDE:  88
b15_efdf:   clc                         ; 3EFDF:  18
b15_efe0:   lda vm_ip_lo                     ; 3EFE0:  a5 06
b15_efe2:   adc #$02                    ; 3EFE2:  69 02
b15_efe4:   sta vm_ip_lo                     ; 3EFE4:  85 06
b15_efe6:   bcc $efeb                   ; 3EFE6:  90 03
b15_efe8:   inc vm_ip_hi                     ; 3EFE8:  e6 07
b15_efea:   clc                         ; 3EFEA:  18
b15_efeb:   rts                         ; 3EFEB:  60
vm_addr_ptr2_plus_word:   clc                         ; 3EFEC:  18
b15_efed:   lda (vm_ip_lo),y                 ; 3EFED:  b1 06
b15_efef:   adc vm_fp_lo                     ; 3EFEF:  65 04
b15_eff1:   sta scratch_ptr_lo                     ; 3EFF1:  85 00
b15_eff3:   iny                         ; 3EFF3:  c8
b15_eff4:   lda (vm_ip_lo),y                 ; 3EFF4:  b1 06
b15_eff6:   adc vm_fp_hi                     ; 3EFF6:  65 05
b15_eff8:   sta scratch_ptr_hi                     ; 3EFF8:  85 01
b15_effa:   dey                         ; 3EFFA:  88
b15_effb:   clc                         ; 3EFFB:  18
b15_effc:   lda vm_ip_lo                     ; 3EFFC:  a5 06
b15_effe:   adc #$02                    ; 3EFFE:  69 02
b15_f000:   sta vm_ip_lo                     ; 3F000:  85 06
b15_f002:   bcc $f007                   ; 3F002:  90 03
b15_f004:   inc vm_ip_hi                     ; 3F004:  e6 07
b15_f006:   clc                         ; 3F006:  18
b15_f007:   rts                         ; 3F007:  60
vm_push16_AX:   tay                         ; 3F008:  a8
b15_f009:   sec                         ; 3F009:  38
b15_f00a:   lda vm_sp_lo                     ; 3F00A:  a5 02
b15_f00c:   sbc #$02                    ; 3F00C:  e9 02
b15_f00e:   sta vm_sp_lo                     ; 3F00E:  85 02
b15_f010:   bcs $f014                   ; 3F010:  b0 02
b15_f012:   dec vm_sp_hi                     ; 3F012:  c6 03
b15_f014:   tya                         ; 3F014:  98
b15_f015:   ldy #$00                    ; 3F015:  a0 00
b15_f017:   sta (vm_sp_lo),y                 ; 3F017:  91 02
b15_f019:   iny                         ; 3F019:  c8
b15_f01a:   txa                         ; 3F01A:  8a
b15_f01b:   sta (vm_sp_lo),y                 ; 3F01B:  91 02
b15_f01d:   jmp $e867                   ; 3F01D:  4c 67 e8
vm_op_B2_pushA_B2:   jsr $f679                   ; 3F020:  20 79 f6
b15_f023:   jmp $e867                   ; 3F023:  4c 67 e8
vm_opcode_lo_table:   .db $7f                     ; 3F026:  7f
b15_f027:   .db clock_a_hi                     ; 3F027:  83
b15_f028:   .db $87                     ; 3F028:  87
b15_f029:   .db $8b                     ; 3F029:  8b
b15_f02a:   .db $8f                     ; 3F02A:  8f
b15_f02b:   .db $93                     ; 3F02B:  93
b15_f02c:   .db $97                     ; 3F02C:  97
b15_f02d:   .db $9b                     ; 3F02D:  9b
b15_f02e:   .db $9f                     ; 3F02E:  9f
b15_f02f:   .db $a3                     ; 3F02F:  a3
b15_f030:   .db $a7                     ; 3F030:  a7
b15_f031:   .db $ab                     ; 3F031:  ab
b15_f032:   bne $f000                   ; 3F032:  d0 cc
b15_f034:   iny                         ; 3F034:  c8
b15_f035:   cpy $de                     ; 3F035:  c4 de
b15_f037:   .db $e2                     ; 3F037:  e2
b15_f038:   inc $ea                     ; 3F038:  e6 ea
b15_f03a:   inc $f6f2                   ; 3F03A:  ee f2 f6
b15_f03d:   .db $fa                     ; 3F03D:  fa
b15_f03e:   inc $0602,x                 ; 3F03E:  fe 02 06
b15_f041:   asl a                       ; 3F041:  0a
b15_f042:   .db $2f                     ; 3F042:  2f
b15_f043:   .db $2b                     ; 3F043:  2b
b15_f044:   .db $27                     ; 3F044:  27
b15_f045:   .db $23                     ; 3F045:  23
b15_f046:   and $4541,x                 ; 3F046:  3d 41 45
b15_f049:   eor #$4d                    ; 3F049:  49 4d
b15_f04b:   eor ($55),y                 ; 3F04B:  51 55
b15_f04d:   eor $615d,y                 ; 3F04D:  59 5d 61
b15_f050:   adc brk_jmp_target_hi                     ; 3F050:  65 69
b15_f052:   stx $868a                   ; 3F052:  8e 8a 86
b15_f055:   .db $82                     ; 3F055:  82
b15_f056:   .db $9c                     ; 3F056:  9c
b15_f057:   ldy #$a4                    ; 3F057:  a0 a4
b15_f059:   tay                         ; 3F059:  a8
b15_f05a:   ldy $b4b0                   ; 3F05A:  ac b0 b4
b15_f05d:   clv                         ; 3F05D:  b8
b15_f05e:   ldy $c4c0,x                 ; 3F05E:  bc c0 c4
b15_f061:   iny                         ; 3F061:  c8
b15_f062:   .db $eb                     ; 3F062:  eb
b15_f063:   .db $e7                     ; 3F063:  e7
b15_f064:   .db $e3                     ; 3F064:  e3
b15_f065:   .db $df                     ; 3F065:  df
b15_f066:   brk                         ; 3F066:  00
b15_f067:   inc $f6,x                   ; 3F067:  f6 f6
b15_f069:   inc $f6,x                   ; 3F069:  f6 f6
b15_f06b:   inc $f6,x                   ; 3F06B:  f6 f6
b15_f06d:   inc $f6,x                   ; 3F06D:  f6 f6
b15_f06f:   inc $f6,x                   ; 3F06F:  f6 f6
b15_f071:   inc $f6,x                   ; 3F071:  f6 f6
b15_f073:   inc $f6,x                   ; 3F073:  f6 f6
b15_f075:   inc $11,x                   ; 3F075:  f6 11
b15_f077:   .db vm_ip_hi                     ; 3F077:  07
b15_f078:   .db vm_ip_hi                     ; 3F078:  07
b15_f079:   .db vm_ip_hi                     ; 3F079:  07
b15_f07a:   .db vm_ip_hi                     ; 3F07A:  07
b15_f07b:   .db vm_ip_hi                     ; 3F07B:  07
b15_f07c:   .db vm_ip_hi                     ; 3F07C:  07
b15_f07d:   .db vm_ip_hi                     ; 3F07D:  07
b15_f07e:   .db vm_ip_hi                     ; 3F07E:  07
b15_f07f:   .db vm_ip_hi                     ; 3F07F:  07
b15_f080:   .db vm_ip_hi                     ; 3F080:  07
b15_f081:   .db vm_ip_hi                     ; 3F081:  07
b15_f082:   .db vm_ip_hi                     ; 3F082:  07
b15_f083:   .db vm_ip_hi                     ; 3F083:  07
b15_f084:   .db vm_ip_hi                     ; 3F084:  07
b15_f085:   .db vm_ip_hi                     ; 3F085:  07
b15_f086:   clc                         ; 3F086:  18
b15_f087:   clc                         ; 3F087:  18
b15_f088:   clc                         ; 3F088:  18
b15_f089:   clc                         ; 3F089:  18
b15_f08a:   clc                         ; 3F08A:  18
b15_f08b:   clc                         ; 3F08B:  18
b15_f08c:   clc                         ; 3F08C:  18
b15_f08d:   clc                         ; 3F08D:  18
b15_f08e:   clc                         ; 3F08E:  18
b15_f08f:   clc                         ; 3F08F:  18
b15_f090:   clc                         ; 3F090:  18
b15_f091:   clc                         ; 3F091:  18
b15_f092:   clc                         ; 3F092:  18
b15_f093:   clc                         ; 3F093:  18
b15_f094:   clc                         ; 3F094:  18
b15_f095:   clc                         ; 3F095:  18
b15_f096:   bit $2020                   ; 3F096:  2c 20 20
b15_f099:   jsr $2020                   ; 3F099:  20 20 20
b15_f09c:   jsr $2020                   ; 3F09C:  20 20 20
b15_f09f:   jsr $2020                   ; 3F09F:  20 20 20
b15_f0a2:   jsr $2020                   ; 3F0A2:  20 20 20
b15_f0a5:   jsr $3492                   ; 3F0A5:  20 92 34
b15_f0a8:   .db $2f                     ; 3F0A8:  2f
b15_f0a9:   pha                         ; 3F0A9:  48
b15_f0aa:   .db $57                     ; 3F0AA:  57
b15_f0ab:   adc ($70,x)                 ; 3F0AB:  61 70
b15_f0ad:   .db music_ptr_lo                     ; 3F0AD:  7a
b15_f0ae:   .db $87                     ; 3F0AE:  87
b15_f0af:   .db $af                     ; 3F0AF:  af
b15_f0b0:   lda $c8be,y                 ; 3F0B0:  b9 be c8
b15_f0b3:   cmp $d9d3                   ; 3F0B3:  cd d3 d9
b15_f0b6:   inx                         ; 3F0B6:  e8
b15_f0b7:   .db $92                     ; 3F0B7:  92
b15_f0b8:   .db $92                     ; 3F0B8:  92
b15_f0b9:   .db $92                     ; 3F0B9:  92
b15_f0ba:   .db $92                     ; 3F0BA:  92
b15_f0bb:   .db $92                     ; 3F0BB:  92
b15_f0bc:   .db $92                     ; 3F0BC:  92
b15_f0bd:   .db $92                     ; 3F0BD:  92
b15_f0be:   .db $92                     ; 3F0BE:  92
b15_f0bf:   .db $92                     ; 3F0BF:  92
b15_f0c0:   .db $92                     ; 3F0C0:  92
b15_f0c1:   .db $92                     ; 3F0C1:  92
b15_f0c2:   .db $92                     ; 3F0C2:  92
b15_f0c3:   .db $92                     ; 3F0C3:  92
b15_f0c4:   .db $92                     ; 3F0C4:  92
b15_f0c5:   .db $92                     ; 3F0C5:  92
b15_f0c6:   sbc $0ffe                   ; 3F0C6:  ed fe 0f
b15_f0c9:   asl $f943,x                 ; 3F0C9:  1e 43 f9
b15_f0cc:   .db $5c                     ; 3F0CC:  5c
b15_f0cd:   asl a                       ; 3F0CD:  0a
b15_f0ce:   adc $19,x                   ; 3F0CE:  75 19
b15_f0d0:   sty $4e28                   ; 3F0D0:  8c 28 4e
b15_f0d3:   adc $ac9e,x                 ; 3F0D3:  7d 9e ac
b15_f0d6:   .db $9e                     ; 3F0D6:  9e
b15_f0d7:   ldy $20,x                   ; 3F0D7:  b4 20
b15_f0d9:   dec $f0d5                   ; 3F0D9:  ce d5 f0
b15_f0dc:   asl $1846,x                 ; 3F0DC:  1e 46 18
b15_f0df:   .db $54                     ; 3F0DF:  54
b15_f0e0:   jmp ($b1a1)                 ; 3F0E0:  6c a1 b1
b15_f0e3:   cmp ($ee,x)                 ; 3F0E3:  c1 ee
b15_f0e5:   cmp $2f,x                   ; 3F0E5:  d5 2f
b15_f0e7:   .db $43                     ; 3F0E7:  43
b15_f0e8:   .db $57                     ; 3F0E8:  57
b15_f0e9:   sta p1_buttons                     ; 3F0E9:  85 6e
b15_f0eb:   .db $9c                     ; 3F0EB:  9c
b15_f0ec:   .db $b3                     ; 3F0EC:  b3
b15_f0ed:   .db $d7                     ; 3F0ED:  d7
b15_f0ee:   cmp $e9                     ; 3F0EE:  c5 e9
b15_f0f0:   .db $fb                     ; 3F0F0:  fb
b15_f0f1:   ora #$17                    ; 3F0F1:  09 17
b15_f0f3:   rol $92                     ; 3F0F3:  26 92
b15_f0f5:   adc $39,x                   ; 3F0F5:  75 39
b15_f0f7:   .db $42                     ; 3F0F7:  42
b15_f0f8:   eor $c3ab                   ; 3F0F8:  4d ab c3
b15_f0fb:   adc $bb                     ; 3F0FB:  65 bb
b15_f0fd:   cmp $d1                     ; 3F0FD:  c5 d1
b15_f0ff:   ora $1102,x                 ; 3F0FF:  1d 02 11
b15_f102:   jsr $9143                   ; 3F102:  20 43 91
b15_f105:   ldy #$54                    ; 3F105:  a0 54
b15_f107:   .db $5f                     ; 3F107:  5f
b15_f108:   ror a                       ; 3F108:  6a
b15_f109:   cmp $f3e7,y                 ; 3F109:  d9 e7 f3
b15_f10c:   .db $fb                     ; 3F10C:  fb
b15_f10d:   ora #$15                    ; 3F10D:  09 15
b15_f10f:   sec                         ; 3F10F:  38
b15_f110:   and $9292                   ; 3F110:  2d 92 92
b15_f113:   .db $92                     ; 3F113:  92
b15_f114:   .db $92                     ; 3F114:  92
b15_f115:   .db $92                     ; 3F115:  92
b15_f116:   .db $92                     ; 3F116:  92
b15_f117:   .db $92                     ; 3F117:  92
b15_f118:   .db $92                     ; 3F118:  92
b15_f119:   .db $92                     ; 3F119:  92
b15_f11a:   .db $92                     ; 3F11A:  92
b15_f11b:   .db $92                     ; 3F11B:  92
b15_f11c:   .db $92                     ; 3F11C:  92
b15_f11d:   .db $92                     ; 3F11D:  92
b15_f11e:   .db $92                     ; 3F11E:  92
b15_f11f:   .db $92                     ; 3F11F:  92
b15_f120:   .db $92                     ; 3F120:  92
b15_f121:   .db $92                     ; 3F121:  92
b15_f122:   .db $92                     ; 3F122:  92
b15_f123:   .db $92                     ; 3F123:  92
b15_f124:   .db $92                     ; 3F124:  92
b15_f125:   .db $93                     ; 3F125:  93
vm_opcode_hi_table:   inx                         ; 3F126:  e8
b15_f127:   inx                         ; 3F127:  e8
b15_f128:   inx                         ; 3F128:  e8
b15_f129:   inx                         ; 3F129:  e8
b15_f12a:   inx                         ; 3F12A:  e8
b15_f12b:   inx                         ; 3F12B:  e8
b15_f12c:   inx                         ; 3F12C:  e8
b15_f12d:   inx                         ; 3F12D:  e8
b15_f12e:   inx                         ; 3F12E:  e8
b15_f12f:   inx                         ; 3F12F:  e8
b15_f130:   inx                         ; 3F130:  e8
b15_f131:   inx                         ; 3F131:  e8
b15_f132:   inx                         ; 3F132:  e8
b15_f133:   inx                         ; 3F133:  e8
b15_f134:   inx                         ; 3F134:  e8
b15_f135:   inx                         ; 3F135:  e8
b15_f136:   inx                         ; 3F136:  e8
b15_f137:   inx                         ; 3F137:  e8
b15_f138:   inx                         ; 3F138:  e8
b15_f139:   inx                         ; 3F139:  e8
b15_f13a:   inx                         ; 3F13A:  e8
b15_f13b:   inx                         ; 3F13B:  e8
b15_f13c:   inx                         ; 3F13C:  e8
b15_f13d:   inx                         ; 3F13D:  e8
b15_f13e:   inx                         ; 3F13E:  e8
b15_f13f:   sbc #$e9                    ; 3F13F:  e9 e9
b15_f141:   sbc #$e9                    ; 3F141:  e9 e9
b15_f143:   sbc #$e9                    ; 3F143:  e9 e9
b15_f145:   sbc #$e9                    ; 3F145:  e9 e9
b15_f147:   sbc #$e9                    ; 3F147:  e9 e9
b15_f149:   sbc #$e9                    ; 3F149:  e9 e9
b15_f14b:   sbc #$e9                    ; 3F14B:  e9 e9
b15_f14d:   sbc #$e9                    ; 3F14D:  e9 e9
b15_f14f:   sbc #$e9                    ; 3F14F:  e9 e9
b15_f151:   sbc #$e9                    ; 3F151:  e9 e9
b15_f153:   sbc #$e9                    ; 3F153:  e9 e9
b15_f155:   sbc #$e9                    ; 3F155:  e9 e9
b15_f157:   sbc #$e9                    ; 3F157:  e9 e9
b15_f159:   sbc #$e9                    ; 3F159:  e9 e9
b15_f15b:   sbc #$e9                    ; 3F15B:  e9 e9
b15_f15d:   sbc #$e9                    ; 3F15D:  e9 e9
b15_f15f:   sbc #$e9                    ; 3F15F:  e9 e9
b15_f161:   sbc #$e9                    ; 3F161:  e9 e9
b15_f163:   sbc #$e9                    ; 3F163:  e9 e9
b15_f165:   sbc #$ea                    ; 3F165:  e9 ea
b15_f167:   sbc #$e9                    ; 3F167:  e9 e9
b15_f169:   sbc #$e9                    ; 3F169:  e9 e9
b15_f16b:   sbc #$e9                    ; 3F16B:  e9 e9
b15_f16d:   sbc #$e9                    ; 3F16D:  e9 e9
b15_f16f:   sbc #$e9                    ; 3F16F:  e9 e9
b15_f171:   sbc #$e9                    ; 3F171:  e9 e9
b15_f173:   sbc #$e9                    ; 3F173:  e9 e9
b15_f175:   sbc #$ea                    ; 3F175:  e9 ea
b15_f177:   nop                         ; 3F177:  ea
b15_f178:   nop                         ; 3F178:  ea
b15_f179:   nop                         ; 3F179:  ea
b15_f17a:   nop                         ; 3F17A:  ea
b15_f17b:   nop                         ; 3F17B:  ea
b15_f17c:   nop                         ; 3F17C:  ea
b15_f17d:   nop                         ; 3F17D:  ea
b15_f17e:   nop                         ; 3F17E:  ea
b15_f17f:   nop                         ; 3F17F:  ea
b15_f180:   nop                         ; 3F180:  ea
b15_f181:   nop                         ; 3F181:  ea
b15_f182:   nop                         ; 3F182:  ea
b15_f183:   nop                         ; 3F183:  ea
b15_f184:   nop                         ; 3F184:  ea
b15_f185:   nop                         ; 3F185:  ea
b15_f186:   nop                         ; 3F186:  ea
b15_f187:   nop                         ; 3F187:  ea
b15_f188:   nop                         ; 3F188:  ea
b15_f189:   nop                         ; 3F189:  ea
b15_f18a:   nop                         ; 3F18A:  ea
b15_f18b:   nop                         ; 3F18B:  ea
b15_f18c:   nop                         ; 3F18C:  ea
b15_f18d:   nop                         ; 3F18D:  ea
b15_f18e:   nop                         ; 3F18E:  ea
b15_f18f:   nop                         ; 3F18F:  ea
b15_f190:   nop                         ; 3F190:  ea
b15_f191:   nop                         ; 3F191:  ea
b15_f192:   nop                         ; 3F192:  ea
b15_f193:   nop                         ; 3F193:  ea
b15_f194:   nop                         ; 3F194:  ea
b15_f195:   nop                         ; 3F195:  ea
b15_f196:   nop                         ; 3F196:  ea
b15_f197:   nop                         ; 3F197:  ea
b15_f198:   nop                         ; 3F198:  ea
b15_f199:   nop                         ; 3F199:  ea
b15_f19a:   nop                         ; 3F19A:  ea
b15_f19b:   nop                         ; 3F19B:  ea
b15_f19c:   nop                         ; 3F19C:  ea
b15_f19d:   nop                         ; 3F19D:  ea
b15_f19e:   nop                         ; 3F19E:  ea
b15_f19f:   nop                         ; 3F19F:  ea
b15_f1a0:   nop                         ; 3F1A0:  ea
b15_f1a1:   nop                         ; 3F1A1:  ea
b15_f1a2:   nop                         ; 3F1A2:  ea
b15_f1a3:   nop                         ; 3F1A3:  ea
b15_f1a4:   nop                         ; 3F1A4:  ea
b15_f1a5:   nop                         ; 3F1A5:  ea
b15_f1a6:   .db $ef                     ; 3F1A6:  ef
b15_f1a7:   nop                         ; 3F1A7:  ea
b15_f1a8:   nop                         ; 3F1A8:  ea
b15_f1a9:   nop                         ; 3F1A9:  ea
b15_f1aa:   nop                         ; 3F1AA:  ea
b15_f1ab:   nop                         ; 3F1AB:  ea
b15_f1ac:   nop                         ; 3F1AC:  ea
b15_f1ad:   nop                         ; 3F1AD:  ea
b15_f1ae:   nop                         ; 3F1AE:  ea
b15_f1af:   nop                         ; 3F1AF:  ea
b15_f1b0:   nop                         ; 3F1B0:  ea
b15_f1b1:   nop                         ; 3F1B1:  ea
b15_f1b2:   nop                         ; 3F1B2:  ea
b15_f1b3:   nop                         ; 3F1B3:  ea
b15_f1b4:   nop                         ; 3F1B4:  ea
b15_f1b5:   nop                         ; 3F1B5:  ea
b15_f1b6:   nop                         ; 3F1B6:  ea
b15_f1b7:   .db $ef                     ; 3F1B7:  ef
b15_f1b8:   .db $ef                     ; 3F1B8:  ef
b15_f1b9:   .db $ef                     ; 3F1B9:  ef
b15_f1ba:   .db $ef                     ; 3F1BA:  ef
b15_f1bb:   .db $ef                     ; 3F1BB:  ef
b15_f1bc:   .db $ef                     ; 3F1BC:  ef
b15_f1bd:   .db $ef                     ; 3F1BD:  ef
b15_f1be:   .db $ef                     ; 3F1BE:  ef
b15_f1bf:   .db $ef                     ; 3F1BF:  ef
b15_f1c0:   .db $ef                     ; 3F1C0:  ef
b15_f1c1:   .db $ef                     ; 3F1C1:  ef
b15_f1c2:   .db $ef                     ; 3F1C2:  ef
b15_f1c3:   .db $ef                     ; 3F1C3:  ef
b15_f1c4:   .db $ef                     ; 3F1C4:  ef
b15_f1c5:   .db $ef                     ; 3F1C5:  ef
b15_f1c6:   nop                         ; 3F1C6:  ea
b15_f1c7:   nop                         ; 3F1C7:  ea
b15_f1c8:   .db $eb                     ; 3F1C8:  eb
b15_f1c9:   .db $eb                     ; 3F1C9:  eb
b15_f1ca:   nop                         ; 3F1CA:  ea
b15_f1cb:   nop                         ; 3F1CB:  ea
b15_f1cc:   nop                         ; 3F1CC:  ea
b15_f1cd:   .db $eb                     ; 3F1CD:  eb
b15_f1ce:   nop                         ; 3F1CE:  ea
b15_f1cf:   .db $eb                     ; 3F1CF:  eb
b15_f1d0:   nop                         ; 3F1D0:  ea
b15_f1d1:   .db $eb                     ; 3F1D1:  eb
b15_f1d2:   .db $eb                     ; 3F1D2:  eb
b15_f1d3:   .db $eb                     ; 3F1D3:  eb
b15_f1d4:   .db $eb                     ; 3F1D4:  eb
b15_f1d5:   .db $eb                     ; 3F1D5:  eb
b15_f1d6:   cpx $f0ec                   ; 3F1D6:  ec ec f0
b15_f1d9:   cpx $ecec                   ; 3F1D9:  ec ec ec
b15_f1dc:   sbc $edf2                   ; 3F1DC:  ed f2 ed
b15_f1df:   sbc $eded                   ; 3F1DF:  ed ed ed
b15_f1e2:   sbc $eded                   ; 3F1E2:  ed ed ed
b15_f1e5:   sbc $eeee                   ; 3F1E5:  ed ee ee
b15_f1e8:   inc $eeee                   ; 3F1E8:  ee ee ee
b15_f1eb:   inc $eeee                   ; 3F1EB:  ee ee ee
b15_f1ee:   inc $eeee                   ; 3F1EE:  ee ee ee
b15_f1f1:   .db $ef                     ; 3F1F1:  ef
b15_f1f2:   .db $ef                     ; 3F1F2:  ef
b15_f1f3:   .db $ef                     ; 3F1F3:  ef
b15_f1f4:   .db $ef                     ; 3F1F4:  ef
b15_f1f5:   .db $ef                     ; 3F1F5:  ef
b15_f1f6:   .db $ef                     ; 3F1F6:  ef
b15_f1f7:   .db $ef                     ; 3F1F7:  ef
b15_f1f8:   .db $ef                     ; 3F1F8:  ef
b15_f1f9:   cpx $ecec                   ; 3F1F9:  ec ec ec
b15_f1fc:   .db $eb                     ; 3F1FC:  eb
b15_f1fd:   .db $eb                     ; 3F1FD:  eb
b15_f1fe:   .db $eb                     ; 3F1FE:  eb
b15_f1ff:   cpx $eeee                   ; 3F1FF:  ec ee ee
b15_f202:   inc $eaeb                   ; 3F202:  ee eb ea
b15_f205:   nop                         ; 3F205:  ea
b15_f206:   .db $ef                     ; 3F206:  ef
b15_f207:   .db $ef                     ; 3F207:  ef
b15_f208:   .db $ef                     ; 3F208:  ef
b15_f209:   .db $eb                     ; 3F209:  eb
b15_f20a:   .db $eb                     ; 3F20A:  eb
b15_f20b:   .db $eb                     ; 3F20B:  eb
b15_f20c:   .db $eb                     ; 3F20C:  eb
b15_f20d:   cpx $ebec                   ; 3F20D:  ec ec eb
b15_f210:   .db $eb                     ; 3F210:  eb
b15_f211:   .db $ef                     ; 3F211:  ef
b15_f212:   .db $ef                     ; 3F212:  ef
b15_f213:   .db $ef                     ; 3F213:  ef
b15_f214:   .db $ef                     ; 3F214:  ef
b15_f215:   .db $ef                     ; 3F215:  ef
b15_f216:   .db $ef                     ; 3F216:  ef
b15_f217:   .db $ef                     ; 3F217:  ef
b15_f218:   .db $ef                     ; 3F218:  ef
b15_f219:   .db $ef                     ; 3F219:  ef
b15_f21a:   .db $ef                     ; 3F21A:  ef
b15_f21b:   .db $ef                     ; 3F21B:  ef
b15_f21c:   .db $ef                     ; 3F21C:  ef
b15_f21d:   .db $ef                     ; 3F21D:  ef
b15_f21e:   .db $ef                     ; 3F21E:  ef
b15_f21f:   .db $ef                     ; 3F21F:  ef
b15_f220:   .db $ef                     ; 3F220:  ef
b15_f221:   .db $ef                     ; 3F221:  ef
b15_f222:   .db $ef                     ; 3F222:  ef
b15_f223:   .db $ef                     ; 3F223:  ef
b15_f224:   .db $ef                     ; 3F224:  ef
b15_f225:   .db $ef                     ; 3F225:  ef
syscall_dispatch:   ldy #$17                    ; 3F226:  a0 17
b15_f228:   lda (vm_sp_lo),y                 ; 3F228:  b1 02
b15_f22a:   sta $004e,y                 ; 3F22A:  99 4e 00
b15_f22d:   dey                         ; 3F22D:  88
b15_f22e:   cpy #$01                    ; 3F22E:  c0 01
b15_f230:   bne $f228                   ; 3F230:  d0 f6
b15_f232:   lda #$f2                    ; 3F232:  a9 f2
b15_f234:   pha                         ; 3F234:  48
b15_f235:   lda #$3c                    ; 3F235:  a9 3c
b15_f237:   pha                         ; 3F237:  48
b15_f238:   php                         ; 3F238:  08
b15_f239:   jmp ($fffe)                 ; 3F239:  6c fe ff
b15_f23c:   nop                         ; 3F23C:  ea
b15_f23d:   lda brk_scratch_lo                     ; 3F23D:  a5 66
b15_f23f:   sta $08                     ; 3F23F:  85 08
b15_f241:   lda brk_scratch_hi                     ; 3F241:  a5 67
b15_f243:   sta $09                     ; 3F243:  85 09
b15_f245:   rts                         ; 3F245:  60
ext_op_dispatch:   lda (vm_ip_lo),y                 ; 3F246:  b1 06
b15_f248:   inc vm_ip_lo                     ; 3F248:  e6 06
b15_f24a:   bne $f24e                   ; 3F24A:  d0 02
b15_f24c:   inc vm_ip_hi                     ; 3F24C:  e6 07
b15_f24e:   asl a                       ; 3F24E:  0a
b15_f24f:   tax                         ; 3F24F:  aa
b15_f250:   lda $f261,x                 ; 3F250:  bd 61 f2
b15_f253:   sta scratch_ptr_lo                     ; 3F253:  85 00
b15_f255:   lda $f262,x                 ; 3F255:  bd 62 f2
b15_f258:   sta scratch_ptr_hi                     ; 3F258:  85 01
b15_f25a:   lda #$e8                    ; 3F25A:  a9 e8
b15_f25c:   pha                         ; 3F25C:  48
b15_f25d:   lda #$66                    ; 3F25D:  a9 66
b15_f25f:   pha                         ; 3F25F:  48
b15_f260:   jmp (scratch_ptr_lo)                 ; 3F260:  6c 00 00
ext_op_table:   cmp ($f2,x)                 ; 3F263:  c1 f2
b15_f265:   beq $f259                   ; 3F265:  f0 f2
b15_f267:   .db $7f                     ; 3F267:  7f
b15_f268:   .db $f3                     ; 3F268:  f3
b15_f269:   sty $27f3                   ; 3F269:  8c f3 27
b15_f26c:   .db $f4                     ; 3F26C:  f4
b15_f26d:   lsr $f4                     ; 3F26D:  46 f4
b15_f26f:   .db $57                     ; 3F26F:  57
b15_f270:   .db $f4                     ; 3F270:  f4
b15_f271:   .db brk_scratch_hi                     ; 3F271:  67
b15_f272:   .db $f4                     ; 3F272:  f4
b15_f273:   sta $f4,x                   ; 3F273:  95 f4
b15_f275:   ror $acf4,x                 ; 3F275:  7e f4 ac
b15_f278:   .db $f4                     ; 3F278:  f4
b15_f279:   eor $5bf5                   ; 3F279:  4d f5 5b
b15_f27c:   sbc brk_jmp_target_hi,x                   ; 3F27C:  f5 69
b15_f27e:   sbc $77,x                   ; 3F27E:  f5 77
b15_f280:   sbc $7c,x                   ; 3F280:  f5 7c
b15_f282:   sbc nmi_busy,x                   ; 3F282:  f5 81
b15_f284:   sbc clock_b_lo,x                   ; 3F284:  f5 86
b15_f286:   sbc $8b,x                   ; 3F286:  f5 8b
b15_f288:   sbc $a3,x                   ; 3F288:  f5 a3
b15_f28a:   sbc $ac,x                   ; 3F28A:  f5 ac
b15_f28c:   sbc $c2,x                   ; 3F28C:  f5 c2
b15_f28e:   sbc $31,x                   ; 3F28E:  f5 31
b15_f290:   sbc $f4,x                   ; 3F290:  f5 f4
b15_f292:   .db $f4                     ; 3F292:  f4
b15_f293:   brk                         ; 3F293:  00
b15_f294:   sbc $3f,x                   ; 3F294:  f5 3f
b15_f296:   sbc $1a,x                   ; 3F296:  f5 1a
b15_f298:   sbc $15,x                   ; 3F298:  f5 15
b15_f29a:   sbc $3b,x                   ; 3F29A:  f5 3b
b15_f29c:   .db $f4                     ; 3F29C:  f4
b15_f29d:   .db $6b                     ; 3F29D:  6b
b15_f29e:   .db $f3                     ; 3F29E:  f3
b15_f29f:   sta $b5f3,y                 ; 3F29F:  99 f3 b5
b15_f2a2:   .db $f3                     ; 3F2A2:  f3
b15_f2a3:   .db $f7                     ; 3F2A3:  f7
b15_f2a4:   .db $f3                     ; 3F2A4:  f3
b15_f2a5:   .db vm_sp_hi                     ; 3F2A5:  03
b15_f2a6:   .db $f4                     ; 3F2A6:  f4
b15_f2a7:   .db $0f                     ; 3F2A7:  0f
b15_f2a8:   .db $f4                     ; 3F2A8:  f4
b15_f2a9:   .db $1b                     ; 3F2A9:  1b
b15_f2aa:   .db $f4                     ; 3F2AA:  f4
b15_f2ab:   sbc #$f4                    ; 3F2AB:  e9 f4
b15_f2ad:   .db $ef                     ; 3F2AD:  ef
b15_f2ae:   .db $f4                     ; 3F2AE:  f4
b15_f2af:   .db $f3                     ; 3F2AF:  f3
b15_f2b0:   .db $f4                     ; 3F2B0:  f4
b15_f2b1:   .db $33                     ; 3F2B1:  33
b15_f2b2:   .db $f4                     ; 3F2B2:  f4
b15_f2b3:   adc $f4,x                   ; 3F2B3:  75 f4
b15_f2b5:   .db $a3                     ; 3F2B5:  a3
b15_f2b6:   .db $f4                     ; 3F2B6:  f4
b15_f2b7:   sty $baf4                   ; 3F2B7:  8c f4 ba
b15_f2ba:   .db $f4                     ; 3F2BA:  f4
b15_f2bb:   .db $db                     ; 3F2BB:  db
b15_f2bc:   .db $f3                     ; 3F2BC:  f3
b15_f2bd:   .db $fb                     ; 3F2BD:  fb
b15_f2be:   .db $f2                     ; 3F2BE:  f2
b15_f2bf:   .db $62                     ; 3F2BF:  62
b15_f2c0:   .db $f3                     ; 3F2C0:  f3
umul32:   sty $10                     ; 3F2C1:  84 10
b15_f2c3:   sty $11                     ; 3F2C3:  84 11
b15_f2c5:   sty $12                     ; 3F2C5:  84 12
b15_f2c7:   sty $13                     ; 3F2C7:  84 13
b15_f2c9:   ldy #$20                    ; 3F2C9:  a0 20
b15_f2cb:   lda $08                     ; 3F2CB:  a5 08
b15_f2cd:   lsr a                       ; 3F2CD:  4a
b15_f2ce:   bcc $f2dc                   ; 3F2CE:  90 0c
b15_f2d0:   clc                         ; 3F2D0:  18
b15_f2d1:   ldx #$fc                    ; 3F2D1:  a2 fc
b15_f2d3:   lda $14,x                   ; 3F2D3:  b5 14
b15_f2d5:   adc $10,x                   ; 3F2D5:  75 10
b15_f2d7:   sta $14,x                   ; 3F2D7:  95 14
b15_f2d9:   inx                         ; 3F2D9:  e8
b15_f2da:   bne $f2d3                   ; 3F2DA:  d0 f7
b15_f2dc:   lsr $13                     ; 3F2DC:  46 13
b15_f2de:   ror $12                     ; 3F2DE:  66 12
b15_f2e0:   ror $11                     ; 3F2E0:  66 11
b15_f2e2:   ror $10                     ; 3F2E2:  66 10
b15_f2e4:   ror $0b                     ; 3F2E4:  66 0b
b15_f2e6:   ror $0a                     ; 3F2E6:  66 0a
b15_f2e8:   ror $09                     ; 3F2E8:  66 09
b15_f2ea:   ror $08                     ; 3F2EA:  66 08
b15_f2ec:   dey                         ; 3F2EC:  88
b15_f2ed:   bne $f2cb                   ; 3F2ED:  d0 dc
b15_f2ef:   rts                         ; 3F2EF:  60
sdiv32:   jsr $f2fe                   ; 3F2F0:  20 fe f2
b15_f2f3:   lda $40                     ; 3F2F3:  a5 40
b15_f2f5:   bpl $f2fa                   ; 3F2F5:  10 03
b15_f2f7:   jmp $f427                   ; 3F2F7:  4c 27 f4
b15_f2fa:   rts                         ; 3F2FA:  60
udiv32_entry:   jmp $f31c                   ; 3F2FB:  4c 1c f3
sdiv32_setup:   lda $0b                     ; 3F2FE:  a5 0b
b15_f300:   sta $41                     ; 3F300:  85 41
b15_f302:   eor $0f                     ; 3F302:  45 0f
b15_f304:   sta $40                     ; 3F304:  85 40
b15_f306:   lda $0b                     ; 3F306:  a5 0b
b15_f308:   bpl $f30d                   ; 3F308:  10 03
b15_f30a:   jsr $f427                   ; 3F30A:  20 27 f4
b15_f30d:   lda $0f                     ; 3F30D:  a5 0f
b15_f30f:   bpl $f31c                   ; 3F30F:  10 0b
b15_f311:   ldx #$fc                    ; 3F311:  a2 fc
b15_f313:   lda #$00                    ; 3F313:  a9 00
b15_f315:   sbc $10,x                   ; 3F315:  f5 10
b15_f317:   sta $10,x                   ; 3F317:  95 10
b15_f319:   inx                         ; 3F319:  e8
b15_f31a:   bne $f313                   ; 3F31A:  d0 f7
udiv32:   lda #$00                    ; 3F31C:  a9 00
b15_f31e:   sta $10                     ; 3F31E:  85 10
b15_f320:   sta $11                     ; 3F320:  85 11
b15_f322:   sta $12                     ; 3F322:  85 12
b15_f324:   sta $13                     ; 3F324:  85 13
b15_f326:   ldy #$20                    ; 3F326:  a0 20
b15_f328:   asl $08                     ; 3F328:  06 08
b15_f32a:   rol $09                     ; 3F32A:  26 09
b15_f32c:   rol $0a                     ; 3F32C:  26 0a
b15_f32e:   rol $0b                     ; 3F32E:  26 0b
b15_f330:   rol $10                     ; 3F330:  26 10
b15_f332:   rol $11                     ; 3F332:  26 11
b15_f334:   rol $12                     ; 3F334:  26 12
b15_f336:   rol $13                     ; 3F336:  26 13
b15_f338:   sec                         ; 3F338:  38
b15_f339:   lda $10                     ; 3F339:  a5 10
b15_f33b:   sbc $0c                     ; 3F33B:  e5 0c
b15_f33d:   sta scratch_ptr_lo                     ; 3F33D:  85 00
b15_f33f:   lda $11                     ; 3F33F:  a5 11
b15_f341:   sbc $0d                     ; 3F341:  e5 0d
b15_f343:   sta scratch_ptr_hi                     ; 3F343:  85 01
b15_f345:   lda $12                     ; 3F345:  a5 12
b15_f347:   sbc $0e                     ; 3F347:  e5 0e
b15_f349:   tax                         ; 3F349:  aa
b15_f34a:   lda $13                     ; 3F34A:  a5 13
b15_f34c:   sbc $0f                     ; 3F34C:  e5 0f
b15_f34e:   bcc $f35e                   ; 3F34E:  90 0e
b15_f350:   stx $12                     ; 3F350:  86 12
b15_f352:   sta $13                     ; 3F352:  85 13
b15_f354:   lda scratch_ptr_lo                     ; 3F354:  a5 00
b15_f356:   sta $10                     ; 3F356:  85 10
b15_f358:   lda scratch_ptr_hi                     ; 3F358:  a5 01
b15_f35a:   sta $11                     ; 3F35A:  85 11
b15_f35c:   inc $08                     ; 3F35C:  e6 08
b15_f35e:   dey                         ; 3F35E:  88
b15_f35f:   bne $f328                   ; 3F35F:  d0 c7
b15_f361:   rts                         ; 3F361:  60
umod32:   jsr $f31c                   ; 3F362:  20 1c f3
b15_f365:   sty $41                     ; 3F365:  84 41
b15_f367:   ldx #$03                    ; 3F367:  a2 03
b15_f369:   bne $f370                   ; 3F369:  d0 05
smod32:   jsr $f2fe                   ; 3F36B:  20 fe f2
b15_f36e:   ldx #$03                    ; 3F36E:  a2 03
b15_f370:   lda $10,x                   ; 3F370:  b5 10
b15_f372:   sta $08,x                   ; 3F372:  95 08
b15_f374:   dex                         ; 3F374:  ca
b15_f375:   bpl $f370                   ; 3F375:  10 f9
b15_f377:   lda $41                     ; 3F377:  a5 41
b15_f379:   bmi $f37c                   ; 3F379:  30 01
b15_f37b:   rts                         ; 3F37B:  60
b15_f37c:   jmp $f427                   ; 3F37C:  4c 27 f4
add32:   clc                         ; 3F37F:  18
b15_f380:   ldx #$fc                    ; 3F380:  a2 fc
b15_f382:   lda $0c,x                   ; 3F382:  b5 0c
b15_f384:   adc $10,x                   ; 3F384:  75 10
b15_f386:   sta $0c,x                   ; 3F386:  95 0c
b15_f388:   inx                         ; 3F388:  e8
b15_f389:   bne $f382                   ; 3F389:  d0 f7
b15_f38b:   rts                         ; 3F38B:  60
sub32:   sec                         ; 3F38C:  38
b15_f38d:   ldx #$fc                    ; 3F38D:  a2 fc
b15_f38f:   lda $0c,x                   ; 3F38F:  b5 0c
b15_f391:   sbc $10,x                   ; 3F391:  f5 10
b15_f393:   sta $0c,x                   ; 3F393:  95 0c
b15_f395:   inx                         ; 3F395:  e8
b15_f396:   bne $f38f                   ; 3F396:  d0 f7
b15_f398:   rts                         ; 3F398:  60
shl32_var:   clc                         ; 3F399:  18
b15_f39a:   ldy #$ff                    ; 3F39A:  a0 ff
b15_f39c:   ldx #$fc                    ; 3F39C:  a2 fc
b15_f39e:   tya                         ; 3F39E:  98
b15_f39f:   adc $10,x                   ; 3F39F:  75 10
b15_f3a1:   sta $10,x                   ; 3F3A1:  95 10
b15_f3a3:   inx                         ; 3F3A3:  e8
b15_f3a4:   bne $f39e                   ; 3F3A4:  d0 f8
b15_f3a6:   tax                         ; 3F3A6:  aa
b15_f3a7:   bpl $f3aa                   ; 3F3A7:  10 01
b15_f3a9:   rts                         ; 3F3A9:  60
b15_f3aa:   asl $08                     ; 3F3AA:  06 08
b15_f3ac:   rol $09                     ; 3F3AC:  26 09
b15_f3ae:   rol $0a                     ; 3F3AE:  26 0a
b15_f3b0:   rol $0b                     ; 3F3B0:  26 0b
b15_f3b2:   jmp $f399                   ; 3F3B2:  4c 99 f3
shr32_var_arith:   clc                         ; 3F3B5:  18
b15_f3b6:   lda $0b                     ; 3F3B6:  a5 0b
b15_f3b8:   bpl $f3bb                   ; 3F3B8:  10 01
b15_f3ba:   sec                         ; 3F3BA:  38
b15_f3bb:   php                         ; 3F3BB:  08
b15_f3bc:   clc                         ; 3F3BC:  18
b15_f3bd:   ldy #$ff                    ; 3F3BD:  a0 ff
b15_f3bf:   ldx #$fc                    ; 3F3BF:  a2 fc
b15_f3c1:   tya                         ; 3F3C1:  98
b15_f3c2:   adc $10,x                   ; 3F3C2:  75 10
b15_f3c4:   sta $10,x                   ; 3F3C4:  95 10
b15_f3c6:   inx                         ; 3F3C6:  e8
b15_f3c7:   bne $f3c1                   ; 3F3C7:  d0 f8
b15_f3c9:   tax                         ; 3F3C9:  aa
b15_f3ca:   bpl $f3ce                   ; 3F3CA:  10 02
b15_f3cc:   plp                         ; 3F3CC:  28
b15_f3cd:   rts                         ; 3F3CD:  60
b15_f3ce:   plp                         ; 3F3CE:  28
b15_f3cf:   php                         ; 3F3CF:  08
b15_f3d0:   ror $0b                     ; 3F3D0:  66 0b
b15_f3d2:   ror $0a                     ; 3F3D2:  66 0a
b15_f3d4:   ror $09                     ; 3F3D4:  66 09
b15_f3d6:   ror $08                     ; 3F3D6:  66 08
b15_f3d8:   jmp $f3bc                   ; 3F3D8:  4c bc f3
shr32_var_logical:   clc                         ; 3F3DB:  18
b15_f3dc:   ldy #$ff                    ; 3F3DC:  a0 ff
b15_f3de:   ldx #$fc                    ; 3F3DE:  a2 fc
b15_f3e0:   tya                         ; 3F3E0:  98
b15_f3e1:   adc $10,x                   ; 3F3E1:  75 10
b15_f3e3:   sta $10,x                   ; 3F3E3:  95 10
b15_f3e5:   inx                         ; 3F3E5:  e8
b15_f3e6:   bne $f3e0                   ; 3F3E6:  d0 f8
b15_f3e8:   tax                         ; 3F3E8:  aa
b15_f3e9:   bpl $f3ec                   ; 3F3E9:  10 01
b15_f3eb:   rts                         ; 3F3EB:  60
b15_f3ec:   lsr $0b                     ; 3F3EC:  46 0b
b15_f3ee:   ror $0a                     ; 3F3EE:  66 0a
b15_f3f0:   ror $09                     ; 3F3F0:  66 09
b15_f3f2:   ror $08                     ; 3F3F2:  66 08
b15_f3f4:   jmp $f3db                   ; 3F3F4:  4c db f3
not32:   ldx #$03                    ; 3F3F7:  a2 03
b15_f3f9:   lda $08,x                   ; 3F3F9:  b5 08
b15_f3fb:   eor #$ff                    ; 3F3FB:  49 ff
b15_f3fd:   sta $08,x                   ; 3F3FD:  95 08
b15_f3ff:   dex                         ; 3F3FF:  ca
b15_f400:   bpl $f3f9                   ; 3F400:  10 f7
b15_f402:   rts                         ; 3F402:  60
and32:   ldx #$03                    ; 3F403:  a2 03
b15_f405:   lda $08,x                   ; 3F405:  b5 08
b15_f407:   and $0c,x                   ; 3F407:  35 0c
b15_f409:   sta $08,x                   ; 3F409:  95 08
b15_f40b:   dex                         ; 3F40B:  ca
b15_f40c:   bpl $f405                   ; 3F40C:  10 f7
b15_f40e:   rts                         ; 3F40E:  60
or32:   ldx #$03                    ; 3F40F:  a2 03
b15_f411:   lda $08,x                   ; 3F411:  b5 08
b15_f413:   ora $0c,x                   ; 3F413:  15 0c
b15_f415:   sta $08,x                   ; 3F415:  95 08
b15_f417:   dex                         ; 3F417:  ca
b15_f418:   bpl $f411                   ; 3F418:  10 f7
b15_f41a:   rts                         ; 3F41A:  60
xor32:   ldx #$03                    ; 3F41B:  a2 03
b15_f41d:   lda $08,x                   ; 3F41D:  b5 08
b15_f41f:   eor $0c,x                   ; 3F41F:  55 0c
b15_f421:   sta $08,x                   ; 3F421:  95 08
b15_f423:   dex                         ; 3F423:  ca
b15_f424:   bpl $f41d                   ; 3F424:  10 f7
b15_f426:   rts                         ; 3F426:  60
negate32_operand:   sec                         ; 3F427:  38
b15_f428:   ldx #$fc                    ; 3F428:  a2 fc
b15_f42a:   tya                         ; 3F42A:  98
b15_f42b:   sbc $0c,x                   ; 3F42B:  f5 0c
b15_f42d:   sta $0c,x                   ; 3F42D:  95 0c
b15_f42f:   inx                         ; 3F42F:  e8
b15_f430:   bne $f42a                   ; 3F430:  d0 f8
b15_f432:   rts                         ; 3F432:  60
logical_not32:   jsr $f43b                   ; 3F433:  20 3b f4
b15_f436:   lda $08                     ; 3F436:  a5 08
b15_f438:   eor #$01                    ; 3F438:  49 01
b15_f43a:   rts                         ; 3F43A:  60
test_nonzero32:   ldx #$03                    ; 3F43B:  a2 03
b15_f43d:   lda $08,x                   ; 3F43D:  b5 08
b15_f43f:   bne $f451                   ; 3F43F:  d0 10
b15_f441:   dex                         ; 3F441:  ca
b15_f442:   bpl $f43d                   ; 3F442:  10 f9
b15_f444:   bmi $f462                   ; 3F444:  30 1c
cmp32_eq:   ldx #$03                    ; 3F446:  a2 03
b15_f448:   lda $08,x                   ; 3F448:  b5 08
b15_f44a:   cmp $0c,x                   ; 3F44A:  d5 0c
b15_f44c:   bne $f462                   ; 3F44C:  d0 14
b15_f44e:   dex                         ; 3F44E:  ca
b15_f44f:   bpl $f448                   ; 3F44F:  10 f7
b15_f451:   sty $09                     ; 3F451:  84 09
b15_f453:   iny                         ; 3F453:  c8
b15_f454:   sty $08                     ; 3F454:  84 08
b15_f456:   rts                         ; 3F456:  60
cmp32_ne:   ldx #$03                    ; 3F457:  a2 03
b15_f459:   lda $08,x                   ; 3F459:  b5 08
b15_f45b:   cmp $0c,x                   ; 3F45B:  d5 0c
b15_f45d:   bne $f451                   ; 3F45D:  d0 f2
b15_f45f:   dex                         ; 3F45F:  ca
b15_f460:   bpl $f459                   ; 3F460:  10 f7
b15_f462:   sty $09                     ; 3F462:  84 09
b15_f464:   sty $08                     ; 3F464:  84 08
b15_f466:   rts                         ; 3F466:  60
cmp32_a_lt_b_signed:   jsr $f4c3                   ; 3F467:  20 c3 f4
b15_f46a:   bpl $f46d                   ; 3F46A:  10 01
b15_f46c:   iny                         ; 3F46C:  c8
b15_f46d:   tya                         ; 3F46D:  98
b15_f46e:   bvc $f472                   ; 3F46E:  50 02
b15_f470:   eor #$01                    ; 3F470:  49 01
b15_f472:   sta $08                     ; 3F472:  85 08
b15_f474:   rts                         ; 3F474:  60
cmp32_a_lt_b_unsigned:   jsr $f4c3                   ; 3F475:  20 c3 f4
b15_f478:   bcs $f47b                   ; 3F478:  b0 01
b15_f47a:   iny                         ; 3F47A:  c8
b15_f47b:   sty $08                     ; 3F47B:  84 08
b15_f47d:   rts                         ; 3F47D:  60
cmp32_a_gt_b_signed:   jsr $f4d6                   ; 3F47E:  20 d6 f4
b15_f481:   bpl $f484                   ; 3F481:  10 01
b15_f483:   iny                         ; 3F483:  c8
b15_f484:   tya                         ; 3F484:  98
b15_f485:   bvc $f489                   ; 3F485:  50 02
b15_f487:   eor #$01                    ; 3F487:  49 01
b15_f489:   sta $08                     ; 3F489:  85 08
b15_f48b:   rts                         ; 3F48B:  60
cmp32_a_gt_b_unsigned:   jsr $f4d6                   ; 3F48C:  20 d6 f4
b15_f48f:   bcs $f492                   ; 3F48F:  b0 01
b15_f491:   iny                         ; 3F491:  c8
b15_f492:   sty $08                     ; 3F492:  84 08
b15_f494:   rts                         ; 3F494:  60
cmp32_a_le_b_signed:   jsr $f4d6                   ; 3F495:  20 d6 f4
b15_f498:   bmi $f49b                   ; 3F498:  30 01
b15_f49a:   iny                         ; 3F49A:  c8
b15_f49b:   tya                         ; 3F49B:  98
b15_f49c:   bvc $f4a0                   ; 3F49C:  50 02
b15_f49e:   eor #$01                    ; 3F49E:  49 01
b15_f4a0:   sta $08                     ; 3F4A0:  85 08
b15_f4a2:   rts                         ; 3F4A2:  60
cmp32_a_le_b_unsigned:   jsr $f4d6                   ; 3F4A3:  20 d6 f4
b15_f4a6:   bcc $f4a9                   ; 3F4A6:  90 01
b15_f4a8:   iny                         ; 3F4A8:  c8
b15_f4a9:   sty $08                     ; 3F4A9:  84 08
b15_f4ab:   rts                         ; 3F4AB:  60
cmp32_a_ge_b_signed:   jsr $f4c3                   ; 3F4AC:  20 c3 f4
b15_f4af:   bmi $f4b2                   ; 3F4AF:  30 01
b15_f4b1:   iny                         ; 3F4B1:  c8
b15_f4b2:   tya                         ; 3F4B2:  98
b15_f4b3:   bvc $f4b7                   ; 3F4B3:  50 02
b15_f4b5:   eor #$01                    ; 3F4B5:  49 01
b15_f4b7:   sta $08                     ; 3F4B7:  85 08
b15_f4b9:   rts                         ; 3F4B9:  60
cmp32_a_ge_b_unsigned:   jsr $f4c3                   ; 3F4BA:  20 c3 f4
b15_f4bd:   bcc $f4c0                   ; 3F4BD:  90 01
b15_f4bf:   iny                         ; 3F4BF:  c8
b15_f4c0:   sty $08                     ; 3F4C0:  84 08
b15_f4c2:   rts                         ; 3F4C2:  60
cmp32_a_minus_b:   lda $08                     ; 3F4C3:  a5 08
b15_f4c5:   cmp $0c                     ; 3F4C5:  c5 0c
b15_f4c7:   lda $09                     ; 3F4C7:  a5 09
b15_f4c9:   sbc $0d                     ; 3F4C9:  e5 0d
b15_f4cb:   sty $09                     ; 3F4CB:  84 09
b15_f4cd:   lda $0a                     ; 3F4CD:  a5 0a
b15_f4cf:   sbc $0e                     ; 3F4CF:  e5 0e
b15_f4d1:   lda $0b                     ; 3F4D1:  a5 0b
b15_f4d3:   sbc $0f                     ; 3F4D3:  e5 0f
b15_f4d5:   rts                         ; 3F4D5:  60
cmp32_b_minus_a:   lda $0c                     ; 3F4D6:  a5 0c
b15_f4d8:   cmp $08                     ; 3F4D8:  c5 08
b15_f4da:   lda $0d                     ; 3F4DA:  a5 0d
b15_f4dc:   sbc $09                     ; 3F4DC:  e5 09
b15_f4de:   sty $09                     ; 3F4DE:  84 09
b15_f4e0:   lda $0e                     ; 3F4E0:  a5 0e
b15_f4e2:   sbc $0a                     ; 3F4E2:  e5 0a
b15_f4e4:   lda $0f                     ; 3F4E4:  a5 0f
b15_f4e6:   sbc $0b                     ; 3F4E6:  e5 0b
b15_f4e8:   rts                         ; 3F4E8:  60
sign_extend16_to_32:   lda $09                     ; 3F4E9:  a5 09
b15_f4eb:   bpl $f4ef                   ; 3F4EB:  10 02
b15_f4ed:   ldy #$ff                    ; 3F4ED:  a0 ff
clear_a_high16:   sty $0a                     ; 3F4EF:  84 0a
b15_f4f1:   sty $0b                     ; 3F4F1:  84 0b
ext_op_nop:   rts                         ; 3F4F3:  60
load_a32_from_ptr3:   lda (vm_ip_lo),y                 ; 3F4F4:  b1 06
b15_f4f6:   sta $0008,y                 ; 3F4F6:  99 08 00
b15_f4f9:   iny                         ; 3F4F9:  c8
b15_f4fa:   cpy #$04                    ; 3F4FA:  c0 04
b15_f4fc:   bne $f4f4                   ; 3F4FC:  d0 f6
b15_f4fe:   beq $f50a                   ; 3F4FE:  f0 0a
load_b32_from_ptr3:   lda (vm_ip_lo),y                 ; 3F500:  b1 06
b15_f502:   sta $000c,y                 ; 3F502:  99 0c 00
b15_f505:   iny                         ; 3F505:  c8
b15_f506:   cpy #$04                    ; 3F506:  c0 04
b15_f508:   bne $f500                   ; 3F508:  d0 f6
b15_f50a:   lda vm_ip_lo                     ; 3F50A:  a5 06
b15_f50c:   adc #$03                    ; 3F50C:  69 03
b15_f50e:   sta vm_ip_lo                     ; 3F50E:  85 06
b15_f510:   bcc $f514                   ; 3F510:  90 02
b15_f512:   inc vm_ip_hi                     ; 3F512:  e6 07
b15_f514:   rts                         ; 3F514:  60
halve_a32_rounded:   ldy #$ff                    ; 3F515:  a0 ff
b15_f517:   tya                         ; 3F517:  98
b15_f518:   bne $f51c                   ; 3F518:  d0 02
halve_a32:   lda #$01                    ; 3F51A:  a9 01
b15_f51c:   clc                         ; 3F51C:  18
b15_f51d:   ldx #$01                    ; 3F51D:  a2 01
b15_f51f:   adc $08                     ; 3F51F:  65 08
b15_f521:   sta $08                     ; 3F521:  85 08
b15_f523:   ror a                       ; 3F523:  6a
b15_f524:   rol a                       ; 3F524:  2a
b15_f525:   tya                         ; 3F525:  98
b15_f526:   adc $08,x                   ; 3F526:  75 08
b15_f528:   sta $08,x                   ; 3F528:  95 08
b15_f52a:   ror a                       ; 3F52A:  6a
b15_f52b:   inx                         ; 3F52B:  e8
b15_f52c:   cpx #$04                    ; 3F52C:  e0 04
b15_f52e:   bne $f524                   ; 3F52E:  d0 f4
b15_f530:   rts                         ; 3F530:  60
store_a32_via_popped_ptr:   jsr $ecdb                   ; 3F531:  20 db ec
b15_f534:   ldy #$03                    ; 3F534:  a0 03
b15_f536:   lda $0008,y                 ; 3F536:  b9 08 00
b15_f539:   sta ($0c),y                 ; 3F539:  91 0c
b15_f53b:   dey                         ; 3F53B:  88
b15_f53c:   bpl $f536                   ; 3F53C:  10 f8
b15_f53e:   rts                         ; 3F53E:  60
swap_a_b32:   ldx #$03                    ; 3F53F:  a2 03
b15_f541:   lda $08,x                   ; 3F541:  b5 08
b15_f543:   ldy $0c,x                   ; 3F543:  b4 0c
b15_f545:   sta $0c,x                   ; 3F545:  95 0c
b15_f547:   sty $08,x                   ; 3F547:  94 08
b15_f549:   dex                         ; 3F549:  ca
b15_f54a:   bpl $f541                   ; 3F54A:  10 f5
b15_f54c:   rts                         ; 3F54C:  60
load_a32_from_addr:   jsr $efec                   ; 3F54D:  20 ec ef
load_a32_from_ptr0:   ldy #$03                    ; 3F550:  a0 03
b15_f552:   lda (scratch_ptr_lo),y                 ; 3F552:  b1 00
b15_f554:   sta $0008,y                 ; 3F554:  99 08 00
b15_f557:   dey                         ; 3F557:  88
b15_f558:   bpl $f552                   ; 3F558:  10 f8
b15_f55a:   rts                         ; 3F55A:  60
load_b32_from_addr:   jsr $efec                   ; 3F55B:  20 ec ef
b15_f55e:   ldy #$03                    ; 3F55E:  a0 03
b15_f560:   lda (scratch_ptr_lo),y                 ; 3F560:  b1 00
b15_f562:   sta $000c,y                 ; 3F562:  99 0c 00
b15_f565:   dey                         ; 3F565:  88
b15_f566:   bpl $f560                   ; 3F566:  10 f8
b15_f568:   rts                         ; 3F568:  60
store_a32_to_addr:   jsr $efec                   ; 3F569:  20 ec ef
b15_f56c:   ldy #$03                    ; 3F56C:  a0 03
b15_f56e:   lda $0008,y                 ; 3F56E:  b9 08 00
b15_f571:   sta (scratch_ptr_lo),y                 ; 3F571:  91 00
b15_f573:   dey                         ; 3F573:  88
b15_f574:   bpl $f56e                   ; 3F574:  10 f8
b15_f576:   rts                         ; 3F576:  60
store_a32_to_addr_or_push:   jsr $efec                   ; 3F577:  20 ec ef
b15_f57a:   bcc $f58e                   ; 3F57A:  90 12
load_a32_indirect:   jsr $efd5                   ; 3F57C:  20 d5 ef
b15_f57f:   bcc $f550                   ; 3F57F:  90 cf
load_b32_indirect:   jsr $efd5                   ; 3F581:  20 d5 ef
b15_f584:   bcc $f55e                   ; 3F584:  90 d8
store_a32_indirect:   jsr $efd5                   ; 3F586:  20 d5 ef
b15_f589:   bcc $f56c                   ; 3F589:  90 e1
push_value32_to_vm_stack:   jsr $efd5                   ; 3F58B:  20 d5 ef
vm_push32_tail:   sec                         ; 3F58E:  38
b15_f58f:   lda vm_sp_lo                     ; 3F58F:  a5 02
b15_f591:   sbc #$04                    ; 3F591:  e9 04
b15_f593:   sta vm_sp_lo                     ; 3F593:  85 02
b15_f595:   bcs $f599                   ; 3F595:  b0 02
b15_f597:   dec vm_sp_hi                     ; 3F597:  c6 03
b15_f599:   ldy #$03                    ; 3F599:  a0 03
b15_f59b:   lda (scratch_ptr_lo),y                 ; 3F59B:  b1 00
b15_f59d:   sta (vm_sp_lo),y                 ; 3F59D:  91 02
b15_f59f:   dey                         ; 3F59F:  88
b15_f5a0:   bpl $f59b                   ; 3F5A0:  10 f9
b15_f5a2:   rts                         ; 3F5A2:  60
push_a32_to_vm_stack:   lda #$08                    ; 3F5A3:  a9 08
b15_f5a5:   sta scratch_ptr_lo                     ; 3F5A5:  85 00
b15_f5a7:   sty scratch_ptr_hi                     ; 3F5A7:  84 01
b15_f5a9:   jmp $f58e                   ; 3F5A9:  4c 8e f5
pop_b32_from_vm_stack:   ldy #$03                    ; 3F5AC:  a0 03
b15_f5ae:   lda (vm_sp_lo),y                 ; 3F5AE:  b1 02
b15_f5b0:   sta $000c,y                 ; 3F5B0:  99 0c 00
b15_f5b3:   dey                         ; 3F5B3:  88
b15_f5b4:   bpl $f5ae                   ; 3F5B4:  10 f8
b15_f5b6:   clc                         ; 3F5B6:  18
b15_f5b7:   lda vm_sp_lo                     ; 3F5B7:  a5 02
b15_f5b9:   adc #$04                    ; 3F5B9:  69 04
b15_f5bb:   sta vm_sp_lo                     ; 3F5BB:  85 02
b15_f5bd:   bcc $f5c1                   ; 3F5BD:  90 02
b15_f5bf:   inc vm_sp_hi                     ; 3F5BF:  e6 03
b15_f5c1:   rts                         ; 3F5C1:  60
load_a32_via_a_ptr:   lda $08                     ; 3F5C2:  a5 08
b15_f5c4:   sta scratch_ptr_lo                     ; 3F5C4:  85 00
b15_f5c6:   lda $09                     ; 3F5C6:  a5 09
b15_f5c8:   sta scratch_ptr_hi                     ; 3F5C8:  85 01
b15_f5ca:   jmp $f550                   ; 3F5CA:  4c 50 f5
vm_bitfield_read:   pha                         ; 3F5CD:  48
b15_f5ce:   lda scratch_ptr_lo,y                 ; 3F5CE:  b9 00 00
b15_f5d1:   sta scratch_ptr_lo                     ; 3F5D1:  85 00
b15_f5d3:   lda scratch_ptr_hi,y                 ; 3F5D3:  b9 01 00
b15_f5d6:   sta scratch_ptr_hi                     ; 3F5D6:  85 01
b15_f5d8:   ldy #$00                    ; 3F5D8:  a0 00
b15_f5da:   lda (scratch_ptr_lo),y                 ; 3F5DA:  b1 00
b15_f5dc:   sta $08                     ; 3F5DC:  85 08
b15_f5de:   iny                         ; 3F5DE:  c8
b15_f5df:   lda (scratch_ptr_lo),y                 ; 3F5DF:  b1 00
b15_f5e1:   sta $09                     ; 3F5E1:  85 09
b15_f5e3:   txa                         ; 3F5E3:  8a
b15_f5e4:   beq $f5ed                   ; 3F5E4:  f0 07
b15_f5e6:   lsr $09                     ; 3F5E6:  46 09
b15_f5e8:   ror $08                     ; 3F5E8:  66 08
b15_f5ea:   dex                         ; 3F5EA:  ca
b15_f5eb:   bne $f5e6                   ; 3F5EB:  d0 f9
b15_f5ed:   pla                         ; 3F5ED:  68
b15_f5ee:   jsr $f669                   ; 3F5EE:  20 69 f6
b15_f5f1:   lda $08                     ; 3F5F1:  a5 08
b15_f5f3:   and $0a                     ; 3F5F3:  25 0a
b15_f5f5:   sta $08                     ; 3F5F5:  85 08
b15_f5f7:   lda $09                     ; 3F5F7:  a5 09
b15_f5f9:   and $0b                     ; 3F5F9:  25 0b
b15_f5fb:   sta $09                     ; 3F5FB:  85 09
b15_f5fd:   lda #$00                    ; 3F5FD:  a9 00
b15_f5ff:   tax                         ; 3F5FF:  aa
b15_f600:   ldy #$01                    ; 3F600:  a0 01
b15_f602:   rts                         ; 3F602:  60
vm_bitfield_read_test:   jsr $f5cd                   ; 3F603:  20 cd f5
b15_f606:   lda $0b                     ; 3F606:  a5 0b
b15_f608:   eor #$ff                    ; 3F608:  49 ff
b15_f60a:   sta $0b                     ; 3F60A:  85 0b
b15_f60c:   lsr a                       ; 3F60C:  4a
b15_f60d:   and $09                     ; 3F60D:  25 09
b15_f60f:   sta scratch_ptr_lo                     ; 3F60F:  85 00
b15_f611:   lda $0a                     ; 3F611:  a5 0a
b15_f613:   eor #$ff                    ; 3F613:  49 ff
b15_f615:   sta $0a                     ; 3F615:  85 0a
b15_f617:   ror a                       ; 3F617:  6a
b15_f618:   and $08                     ; 3F618:  25 08
b15_f61a:   ora scratch_ptr_lo                     ; 3F61A:  05 00
b15_f61c:   beq $f62a                   ; 3F61C:  f0 0c
b15_f61e:   lda $08                     ; 3F61E:  a5 08
b15_f620:   ora $0a                     ; 3F620:  05 0a
b15_f622:   sta $08                     ; 3F622:  85 08
b15_f624:   lda $09                     ; 3F624:  a5 09
b15_f626:   ora $0b                     ; 3F626:  05 0b
b15_f628:   sta $09                     ; 3F628:  85 09
b15_f62a:   txa                         ; 3F62A:  8a
b15_f62b:   rts                         ; 3F62B:  60
vm_bitfield_write:   pha                         ; 3F62C:  48
b15_f62d:   lda scratch_ptr_lo,y                 ; 3F62D:  b9 00 00
b15_f630:   sta scratch_ptr_lo                     ; 3F630:  85 00
b15_f632:   lda scratch_ptr_hi,y                 ; 3F632:  b9 01 00
b15_f635:   sta scratch_ptr_hi                     ; 3F635:  85 01
b15_f637:   pla                         ; 3F637:  68
b15_f638:   jsr $f669                   ; 3F638:  20 69 f6
b15_f63b:   txa                         ; 3F63B:  8a
b15_f63c:   beq $f649                   ; 3F63C:  f0 0b
b15_f63e:   asl $08                     ; 3F63E:  06 08
b15_f640:   rol $09                     ; 3F640:  26 09
b15_f642:   asl $0a                     ; 3F642:  06 0a
b15_f644:   rol $0b                     ; 3F644:  26 0b
b15_f646:   dex                         ; 3F646:  ca
b15_f647:   bne $f63e                   ; 3F647:  d0 f5
b15_f649:   lda $08                     ; 3F649:  a5 08
b15_f64b:   and $0a                     ; 3F64B:  25 0a
b15_f64d:   sta $08                     ; 3F64D:  85 08
b15_f64f:   lda $09                     ; 3F64F:  a5 09
b15_f651:   and $0b                     ; 3F651:  25 0b
b15_f653:   sta $09                     ; 3F653:  85 09
b15_f655:   iny                         ; 3F655:  c8
b15_f656:   lda $000a,y                 ; 3F656:  b9 0a 00
b15_f659:   eor #$ff                    ; 3F659:  49 ff
b15_f65b:   and (scratch_ptr_lo),y                 ; 3F65B:  31 00
b15_f65d:   ora $0008,y                 ; 3F65D:  19 08 00
b15_f660:   sta (scratch_ptr_lo),y                 ; 3F660:  91 00
b15_f662:   dey                         ; 3F662:  88
b15_f663:   bpl $f656                   ; 3F663:  10 f1
b15_f665:   txa                         ; 3F665:  8a
b15_f666:   ldy #$01                    ; 3F666:  a0 01
b15_f668:   rts                         ; 3F668:  60
make_bitmask:   tay                         ; 3F669:  a8
b15_f66a:   lda #$00                    ; 3F66A:  a9 00
b15_f66c:   sta $0a                     ; 3F66C:  85 0a
b15_f66e:   sta $0b                     ; 3F66E:  85 0b
b15_f670:   sec                         ; 3F670:  38
b15_f671:   rol $0a                     ; 3F671:  26 0a
b15_f673:   rol $0b                     ; 3F673:  26 0b
b15_f675:   dey                         ; 3F675:  88
b15_f676:   bne $f670                   ; 3F676:  d0 f8
b15_f678:   rts                         ; 3F678:  60
b15_f679:   rts                         ; 3F679:  60
strategic_map_bg_palette:   rol $1200,x                 ; 3F67A:  3e 00 12
b15_f67d:   brk                         ; 3F67D:  00
b15_f67e:   and #$00                    ; 3F67E:  29 00
b15_f680:   bmi $f682                   ; 3F680:  30 00
b15_f682:   rol $1600,x                 ; 3F682:  3e 00 16
b15_f685:   brk                         ; 3F685:  00
b15_f686:   sec                         ; 3F686:  38
b15_f687:   brk                         ; 3F687:  00
b15_f688:   bmi $f68a                   ; 3F688:  30 00
msg_control_n:   .db $43                     ; 3F68A:  43
b15_f68b:   .db p2_buttons                     ; 3F68B:  6f
b15_f68c:   ror $7274                   ; 3F68C:  6e 74 72
b15_f68f:   .db p2_buttons                     ; 3F68F:  6f
b15_f690:   jmp ($2520)                 ; 3F690:  6c 20 25
b15_f693:   .db $64                     ; 3F693:  64
b15_f694:   brk                         ; 3F694:  00
msg_y_n_f695:   asl a                       ; 3F695:  0a
b15_f696:   plp                         ; 3F696:  28
b15_f697:   eor $4e2f,y                 ; 3F697:  59 2f 4e
b15_f69a:   and #$3f                    ; 3F69A:  29 3f
b15_f69c:   jsr $2500                   ; 3F69C:  20 00 25
b15_f69f:   .db $64                     ; 3F69F:  64
b15_f6a0:   brk                         ; 3F6A0:  00
cursor_nav_fmt_d_1:   and $64                     ; 3F6A1:  25 64
b15_f6a3:   brk                         ; 3F6A3:  00
cursor_nav_fmt_d_2:   and $64                     ; 3F6A4:  25 64
b15_f6a6:   brk                         ; 3F6A6:  00
cursor_nav_space:   jsr $2500                   ; 3F6A7:  20 00 25
b15_f6aa:   .db $64                     ; 3F6AA:  64
b15_f6ab:   brk                         ; 3F6AB:  00
msg_d_d_f6ac:   asl a                       ; 3F6AC:  0a
b15_f6ad:   plp                         ; 3F6AD:  28
b15_f6ae:   and $64                     ; 3F6AE:  25 64
b15_f6b0:   and $6425                   ; 3F6B0:  2d 25 64
b15_f6b3:   and #$3f                    ; 3F6B3:  29 3f
b15_f6b5:   jsr $4800                   ; 3F6B5:  20 00 48
b15_f6b8:   adc #$74                    ; 3F6B8:  69 74
b15_f6ba:   jsr $6e61                   ; 3F6BA:  20 61 6e
b15_f6bd:   adc $6b20,y                 ; 3F6BD:  79 20 6b
b15_f6c0:   adc music_voice_idx                     ; 3F6C0:  65 79
b15_f6c2:   brk                         ; 3F6C2:  00
b15_f6c3:   brk                         ; 3F6C3:  00
draw_current_year_fmt:   and $64                     ; 3F6C4:  25 64
b15_f6c6:   brk                         ; 3F6C6:  00
msg_spring:   .db $53                     ; 3F6C7:  53
b15_f6c8:   bvs $f73c                   ; 3F6C8:  70 72
b15_f6ca:   adc #$6e                    ; 3F6CA:  69 6e
b15_f6cc:   .db brk_scratch_hi                     ; 3F6CC:  67
b15_f6cd:   brk                         ; 3F6CD:  00
msg_summer:   .db $53                     ; 3F6CE:  53
b15_f6cf:   adc $6d,x                   ; 3F6CF:  75 6d
b15_f6d1:   adc $7265                   ; 3F6D1:  6d 65 72
b15_f6d4:   brk                         ; 3F6D4:  00
msg_fall:   lsr $61                     ; 3F6D5:  46 61
b15_f6d7:   jmp ($006c)                 ; 3F6D7:  6c 6c 00
msg_winter:   .db $57                     ; 3F6DA:  57
b15_f6db:   adc #$6e                    ; 3F6DB:  69 6e
b15_f6dd:   .db palette_dirty                     ; 3F6DD:  74
b15_f6de:   adc ppumask_shadow                     ; 3F6DE:  65 72
b15_f6e0:   brk                         ; 3F6E0:  00
msg_lord_f6e1:   jmp $726f                   ; 3F6E1:  4c 6f 72
b15_f6e4:   .db $64                     ; 3F6E4:  64
b15_f6e5:   jsr $4c00                   ; 3F6E5:  20 00 4c
b15_f6e8:   .db p2_buttons                     ; 3F6E8:  6f
b15_f6e9:   .db ppumask_shadow                     ; 3F6E9:  72
b15_f6ea:   .db $64                     ; 3F6EA:  64
b15_f6eb:   asl a                       ; 3F6EB:  0a
b15_f6ec:   brk                         ; 3F6EC:  00
msg_pirates_f6ed:   bvc $f758                   ; 3F6ED:  50 69
b15_f6ef:   .db ppumask_shadow                     ; 3F6EF:  72
b15_f6f0:   adc (palette_dirty,x)                 ; 3F6F0:  61 74
b15_f6f2:   adc prg_bank_shadow                     ; 3F6F2:  65 73
b15_f6f4:   brk                         ; 3F6F4:  00
msg_christns_f6f5:   .db $43                     ; 3F6F5:  43
b15_f6f6:   pla                         ; 3F6F6:  68
b15_f6f7:   .db ppumask_shadow                     ; 3F6F7:  72
b15_f6f8:   adc #$73                    ; 3F6F8:  69 73
b15_f6fa:   .db palette_dirty                     ; 3F6FA:  74
b15_f6fb:   ror prg_bank_shadow                   ; 3F6FB:  6e 73 00
msg_rioters_f6fe:   .db $52                     ; 3F6FE:  52
b15_f6ff:   adc #$6f                    ; 3F6FF:  69 6f
b15_f701:   .db palette_dirty                     ; 3F701:  74
b15_f702:   adc ppumask_shadow                     ; 3F702:  65 72
b15_f704:   .db prg_bank_shadow                     ; 3F704:  73
b15_f705:   brk                         ; 3F705:  00
msg_no_lord:   ror $206f                   ; 3F706:  6e 6f 20
b15_f709:   jmp ($726f)                 ; 3F709:  6c 6f 72
b15_f70c:   .db $64                     ; 3F70C:  64
b15_f70d:   brk                         ; 3F70D:  00
province_to_mapid_table:   .db $0f                     ; 3F70E:  0f
b15_f70f:   ora #$0d                    ; 3F70F:  09 0d
b15_f711:   .db $14                     ; 3F711:  14
b15_f712:   ora $11,x                   ; 3F712:  15 11
b15_f714:   .db $13                     ; 3F714:  13
b15_f715:   .db $17                     ; 3F715:  17
b15_f716:   asl ppu_queue_b_hi,x                   ; 3F716:  16 1f
b15_f718:   .db $1a                     ; 3F718:  1a
b15_f719:   .db $1b                     ; 3F719:  1b
b15_f71a:   ora $201e,y                 ; 3F71A:  19 1e 20
b15_f71d:   asl $0018                   ; 3F71D:  0e 18 00
uprising_label_zealots:   .db $5a                     ; 3F720:  5a
b15_f721:   adc $61                     ; 3F721:  65 61
b15_f723:   jmp ($746f)                 ; 3F723:  6c 6f 74
b15_f726:   .db prg_bank_shadow                     ; 3F726:  73
b15_f727:   brk                         ; 3F727:  00
uprising_label_monks:   eor $6e6f                   ; 3F728:  4d 6f 6e
b15_f72b:   .db $6b                     ; 3F72B:  6b
b15_f72c:   .db prg_bank_shadow                     ; 3F72C:  73
b15_f72d:   brk                         ; 3F72D:  00
msg_rebels_f72e:   .db $52                     ; 3F72E:  52
b15_f72f:   adc $62                     ; 3F72F:  65 62
b15_f731:   adc $6c                     ; 3F731:  65 6c
b15_f733:   .db prg_bank_shadow                     ; 3F733:  73
b15_f734:   brk                         ; 3F734:  00
msg_is_now_fief_2d_s_daimyo:   jsr $7369                   ; 3F735:  20 69 73
b15_f738:   jsr $6f6e                   ; 3F738:  20 6e 6f
b15_f73b:   .db $77                     ; 3F73B:  77
b15_f73c:   asl a                       ; 3F73C:  0a
b15_f73d:   ror brk_jmp_target_hi                     ; 3F73D:  66 69
b15_f73f:   adc brk_scratch_lo                     ; 3F73F:  65 66
b15_f741:   jsr $3225                   ; 3F741:  20 25 32
b15_f744:   .db $64                     ; 3F744:  64
b15_f745:   rts                         ; 3F745:  60
b15_f746:   .db prg_bank_shadow                     ; 3F746:  73
b15_f747:   jsr $6164                   ; 3F747:  20 64 61
b15_f74a:   adc #$6d                    ; 3F74A:  69 6d
b15_f74c:   adc p2_buttons,y                 ; 3F74C:  79 6f 00
msg_was_killed:   jsr $6177                   ; 3F74F:  20 77 61
b15_f752:   .db prg_bank_shadow                     ; 3F752:  73
b15_f753:   asl a                       ; 3F753:  0a
b15_f754:   .db $6b                     ; 3F754:  6b
b15_f755:   adc #$6c                    ; 3F755:  69 6c
b15_f757:   jmp ($6465)                 ; 3F757:  6c 65 64
b15_f75a:   brk                         ; 3F75A:  00
msg_in_fief_2d_in_the_year_d:   jsr $6e69                   ; 3F75B:  20 69 6e
b15_f75e:   jsr $6966                   ; 3F75E:  20 66 69
b15_f761:   adc brk_scratch_lo                     ; 3F761:  65 66
b15_f763:   jsr $3225                   ; 3F763:  20 25 32
b15_f766:   .db $64                     ; 3F766:  64
b15_f767:   asl a                       ; 3F767:  0a
b15_f768:   adc #$6e                    ; 3F768:  69 6e
b15_f76a:   jsr $6874                   ; 3F76A:  20 74 68
b15_f76d:   adc $20                     ; 3F76D:  65 20
b15_f76f:   adc $6165,y                 ; 3F76F:  79 65 61
b15_f772:   .db ppumask_shadow                     ; 3F772:  72
b15_f773:   jsr $6425                   ; 3F773:  20 25 64
b15_f776:   brk                         ; 3F776:  00
msg_lord_f777:   jmp $726f                   ; 3F777:  4c 6f 72
b15_f77a:   .db $64                     ; 3F77A:  64
b15_f77b:   jsr $0a00                   ; 3F77B:  20 00 0a
b15_f77e:   brk                         ; 3F77E:  00
msg_wants_a_s:   jsr $6177                   ; 3F77F:  20 77 61
b15_f782:   ror $7374                   ; 3F782:  6e 74 73
b15_f785:   jsr $0a61                   ; 3F785:  20 61 0a
b15_f788:   and prg_bank_shadow                     ; 3F788:  25 73
b15_f78a:   asl a                       ; 3F78A:  0a
b15_f78b:   brk                         ; 3F78B:  00
msg_demand_gold:   .db $44                     ; 3F78C:  44
b15_f78d:   adc $6d                     ; 3F78D:  65 6d
b15_f78f:   adc (p1_buttons,x)                 ; 3F78F:  61 6e
b15_f791:   .db $64                     ; 3F791:  64
b15_f792:   jsr battle_defender_province_staging                   ; 3F792:  20 67 6f
b15_f795:   jmp ($0064)                 ; 3F795:  6c 64 00
msg_marriage_pact:   adc $7261                   ; 3F798:  6d 61 72
b15_f79b:   .db ppumask_shadow                     ; 3F79B:  72
b15_f79c:   adc #$61                    ; 3F79C:  69 61
b15_f79e:   .db brk_scratch_hi                     ; 3F79E:  67
b15_f79f:   adc $20                     ; 3F79F:  65 20
b15_f7a1:   bvs $f804                   ; 3F7A1:  70 61
b15_f7a3:   .db $63                     ; 3F7A3:  63
b15_f7a4:   .db palette_dirty                     ; 3F7A4:  74
b15_f7a5:   brk                         ; 3F7A5:  00
msg_accept:   adc ($63,x)                 ; 3F7A6:  61 63
b15_f7a8:   .db $63                     ; 3F7A8:  63
b15_f7a9:   adc $70                     ; 3F7A9:  65 70
b15_f7ab:   .db palette_dirty                     ; 3F7AB:  74
b15_f7ac:   brk                         ; 3F7AC:  00
msg_pact:   bvs $f810                   ; 3F7AD:  70 61
b15_f7af:   .db $63                     ; 3F7AF:  63
b15_f7b0:   .db palette_dirty                     ; 3F7B0:  74
b15_f7b1:   brk                         ; 3F7B1:  00
msg_fief_f7b2:   lsr brk_jmp_target_hi                     ; 3F7B2:  46 69
b15_f7b4:   adc brk_scratch_lo                     ; 3F7B4:  65 66
b15_f7b6:   jsr $2500                   ; 3F7B6:  20 00 25
b15_f7b9:   .db $64                     ; 3F7B9:  64
b15_f7ba:   jsr $6f6c                   ; 3F7BA:  20 6c 6f
b15_f7bd:   .db prg_bank_shadow                     ; 3F7BD:  73
b15_f7be:   .db palette_dirty                     ; 3F7BE:  74
b15_f7bf:   jsr $7469                   ; 3F7BF:  20 69 74
b15_f7c2:   .db prg_bank_shadow                     ; 3F7C2:  73
b15_f7c3:   asl a                       ; 3F7C3:  0a
b15_f7c4:   jmp ($6165)                 ; 3F7C4:  6c 65 61
b15_f7c7:   .db $64                     ; 3F7C7:  64
b15_f7c8:   adc ppumask_shadow                     ; 3F7C8:  65 72
b15_f7ca:   brk                         ; 3F7CA:  00
b15_f7cb:   brk                         ; 3F7CB:  00
marry_palette:   rol $3800,x                 ; 3F7CC:  3e 00 38
b15_f7cf:   brk                         ; 3F7CF:  00
b15_f7d0:   plp                         ; 3F7D0:  28
b15_f7d1:   brk                         ; 3F7D1:  00
b15_f7d2:   bmi $f7d4                   ; 3F7D2:  30 00
governance_policy_name_ptrs:   cpx #$f7                    ; 3F7D4:  e0 f7
b15_f7d6:   nop                         ; 3F7D6:  ea
b15_f7d7:   .db $f7                     ; 3F7D7:  f7
b15_f7d8:   sbc $f7,x                   ; 3F7D8:  f5 f7
b15_f7da:   inc $07f7,x                 ; 3F7DA:  fe f7 07
b15_f7dd:   sed                         ; 3F7DD:  f8
b15_f7de:   .db $0f                     ; 3F7DE:  0f
b15_f7df:   sed                         ; 3F7DF:  f8
b15_f7e0:   pha                         ; 3F7E0:  48
b15_f7e1:   .db p2_buttons                     ; 3F7E1:  6f
b15_f7e2:   adc $2065                   ; 3F7E2:  6d 65 20
b15_f7e5:   ror brk_jmp_target_hi                     ; 3F7E5:  66 69
b15_f7e7:   adc brk_scratch_lo                     ; 3F7E7:  65 66
b15_f7e9:   brk                         ; 3F7E9:  00
b15_f7ea:   eor #$6e                    ; 3F7EA:  49 6e
b15_f7ec:   .db $64                     ; 3F7EC:  64
b15_f7ed:   adc prg_bank_shadow,x                   ; 3F7ED:  75 73
b15_f7ef:   .db palette_dirty                     ; 3F7EF:  74
b15_f7f0:   .db ppumask_shadow                     ; 3F7F0:  72
b15_f7f1:   adc #$61                    ; 3F7F1:  69 61
b15_f7f3:   jmp ($4d00)                 ; 3F7F3:  6c 00 4d
b15_f7f6:   adc #$6c                    ; 3F7F6:  69 6c
b15_f7f8:   adc #$74                    ; 3F7F8:  69 74
b15_f7fa:   adc (ppumask_shadow,x)                 ; 3F7FA:  61 72
b15_f7fc:   adc $4200,y                 ; 3F7FC:  79 00 42
b15_f7ff:   adc ($6c,x)                 ; 3F7FF:  61 6c
b15_f801:   adc (p1_buttons,x)                 ; 3F801:  61 6e
b15_f803:   .db $63                     ; 3F803:  63
b15_f804:   adc $64                     ; 3F804:  65 64
b15_f806:   brk                         ; 3F806:  00
b15_f807:   lsr $61                     ; 3F807:  46 61
b15_f809:   .db ppumask_shadow                     ; 3F809:  72
b15_f80a:   adc $6e69                   ; 3F80A:  6d 69 6e
b15_f80d:   .db brk_scratch_hi                     ; 3F80D:  67
b15_f80e:   brk                         ; 3F80E:  00
b15_f80f:   .db $44                     ; 3F80F:  44
b15_f810:   adc #$72                    ; 3F810:  69 72
b15_f812:   adc $63                     ; 3F812:  65 63
b15_f814:   .db palette_dirty                     ; 3F814:  74
b15_f815:   brk                         ; 3F815:  00
lord_command_name_ptrs:   rti                         ; 3F816:  40
b15_f817:   sed                         ; 3F817:  f8
b15_f818:   eor $f8                     ; 3F818:  45 f8
b15_f81a:   eor #$f8                    ; 3F81A:  49 f8
b15_f81c:   eor $52f8                   ; 3F81C:  4d f8 52
b15_f81f:   sed                         ; 3F81F:  f8
b15_f820:   lsr $f8,x                   ; 3F820:  56 f8
b15_f822:   .db $5b                     ; 3F822:  5b
b15_f823:   sed                         ; 3F823:  f8
b15_f824:   rts                         ; 3F824:  60
b15_f825:   sed                         ; 3F825:  f8
b15_f826:   ror $f8                     ; 3F826:  66 f8
b15_f828:   jmp ($71f8)                 ; 3F828:  6c f8 71
b15_f82b:   sed                         ; 3F82B:  f8
b15_f82c:   .db $77                     ; 3F82C:  77
b15_f82d:   sed                         ; 3F82D:  f8
b15_f82e:   .db $7c                     ; 3F82E:  7c
b15_f82f:   sed                         ; 3F82F:  f8
b15_f830:   .db $82                     ; 3F830:  82
b15_f831:   sed                         ; 3F831:  f8
b15_f832:   .db $87                     ; 3F832:  87
b15_f833:   sed                         ; 3F833:  f8
b15_f834:   sta $94f8                   ; 3F834:  8d f8 94
b15_f837:   sed                         ; 3F837:  f8
b15_f838:   sta $9df8,y                 ; 3F838:  99 f8 9d
b15_f83b:   sed                         ; 3F83B:  f8
b15_f83c:   .db $a3                     ; 3F83C:  a3
b15_f83d:   sed                         ; 3F83D:  f8
b15_f83e:   lda #$f8                    ; 3F83E:  a9 f8
b15_f840:   eor $766f                   ; 3F840:  4d 6f 76
b15_f843:   adc scratch_ptr_lo                     ; 3F843:  65 00
b15_f845:   .db $57                     ; 3F845:  57
b15_f846:   adc (ppumask_shadow,x)                 ; 3F846:  61 72
b15_f848:   brk                         ; 3F848:  00
b15_f849:   .db $54                     ; 3F849:  54
b15_f84a:   adc ($78,x)                 ; 3F84A:  61 78
b15_f84c:   brk                         ; 3F84C:  00
b15_f84d:   .db $53                     ; 3F84D:  53
b15_f84e:   adc p1_buttons                     ; 3F84E:  65 6e
b15_f850:   .db $64                     ; 3F850:  64
b15_f851:   brk                         ; 3F851:  00
b15_f852:   .db $44                     ; 3F852:  44
b15_f853:   adc ($6d,x)                 ; 3F853:  61 6d
b15_f855:   brk                         ; 3F855:  00
b15_f856:   bvc $f8b9                   ; 3F856:  50 61
b15_f858:   .db $63                     ; 3F858:  63
b15_f859:   .db palette_dirty                     ; 3F859:  74
b15_f85a:   brk                         ; 3F85A:  00
b15_f85b:   .db $47                     ; 3F85B:  47
b15_f85c:   .db ppumask_shadow                     ; 3F85C:  72
b15_f85d:   .db p2_buttons                     ; 3F85D:  6f
b15_f85e:   .db $77                     ; 3F85E:  77
b15_f85f:   brk                         ; 3F85F:  00
b15_f860:   eor $7261                   ; 3F860:  4d 61 72
b15_f863:   .db ppumask_shadow                     ; 3F863:  72
b15_f864:   adc $5400,y                 ; 3F864:  79 00 54
b15_f867:   .db ppumask_shadow                     ; 3F867:  72
b15_f868:   adc ($64,x)                 ; 3F868:  61 64
b15_f86a:   adc scratch_ptr_lo                     ; 3F86A:  65 00
b15_f86c:   pha                         ; 3F86C:  48
b15_f86d:   adc #$72                    ; 3F86D:  69 72
b15_f86f:   adc scratch_ptr_lo                     ; 3F86F:  65 00
b15_f871:   .db $54                     ; 3F871:  54
b15_f872:   .db ppumask_shadow                     ; 3F872:  72
b15_f873:   adc (brk_jmp_target_hi,x)                 ; 3F873:  61 69
b15_f875:   ror $5600                   ; 3F875:  6e 00 56
b15_f878:   adc #$65                    ; 3F878:  69 65
b15_f87a:   .db $77                     ; 3F87A:  77
b15_f87b:   brk                         ; 3F87B:  00
b15_f87c:   .db $42                     ; 3F87C:  42
b15_f87d:   adc brk_jmp_target_hi,x                   ; 3F87D:  75 69
b15_f87f:   jmp ($0064)                 ; 3F87F:  6c 64 00
b15_f882:   .db $47                     ; 3F882:  47
b15_f883:   adc #$76                    ; 3F883:  69 76
b15_f885:   adc scratch_ptr_lo                     ; 3F885:  65 00
b15_f887:   .db $42                     ; 3F887:  42
b15_f888:   .db ppumask_shadow                     ; 3F888:  72
b15_f889:   adc #$62                    ; 3F889:  69 62
b15_f88b:   adc scratch_ptr_lo                     ; 3F88B:  65 00
b15_f88d:   eor (prg_bank_shadow,x)                 ; 3F88D:  41 73
b15_f88f:   .db prg_bank_shadow                     ; 3F88F:  73
b15_f890:   adc #$67                    ; 3F890:  69 67
b15_f892:   ror $5200                   ; 3F892:  6e 00 52
b15_f895:   adc prg_bank_shadow                     ; 3F895:  65 73
b15_f897:   .db palette_dirty                     ; 3F897:  74
b15_f898:   brk                         ; 3F898:  00
b15_f899:   eor $7061                   ; 3F899:  4d 61 70
b15_f89c:   brk                         ; 3F89C:  00
b15_f89d:   .db $47                     ; 3F89D:  47
b15_f89e:   .db ppumask_shadow                     ; 3F89E:  72
b15_f89f:   adc (p1_buttons,x)                 ; 3F89F:  61 6e
b15_f8a1:   .db palette_dirty                     ; 3F8A1:  74
b15_f8a2:   brk                         ; 3F8A2:  00
b15_f8a3:   .db $4f                     ; 3F8A3:  4f
b15_f8a4:   .db palette_dirty                     ; 3F8A4:  74
b15_f8a5:   pla                         ; 3F8A5:  68
b15_f8a6:   adc ppumask_shadow                     ; 3F8A6:  65 72
b15_f8a8:   brk                         ; 3F8A8:  00
b15_f8a9:   bvc $f90c                   ; 3F8A9:  50 61
b15_f8ab:   .db prg_bank_shadow                     ; 3F8AB:  73
b15_f8ac:   .db prg_bank_shadow                     ; 3F8AC:  73
b15_f8ad:   brk                         ; 3F8AD:  00
fief_stat_name_ptrs:   .db $d2                     ; 3F8AE:  d2
b15_f8af:   sed                         ; 3F8AF:  f8
b15_f8b0:   dec $f8,x                   ; 3F8B0:  d6 f8
b15_f8b2:   .db $db                     ; 3F8B2:  db
b15_f8b3:   sed                         ; 3F8B3:  f8
b15_f8b4:   cpx #$f8                    ; 3F8B4:  e0 f8
b15_f8b6:   sbc $f8                     ; 3F8B6:  e5 f8
b15_f8b8:   nop                         ; 3F8B8:  ea
b15_f8b9:   sed                         ; 3F8B9:  f8
b15_f8ba:   sbc $f2f8                   ; 3F8BA:  ed f8 f2
b15_f8bd:   sed                         ; 3F8BD:  f8
b15_f8be:   .db $f7                     ; 3F8BE:  f7
b15_f8bf:   sed                         ; 3F8BF:  f8
b15_f8c0:   .db $fc                     ; 3F8C0:  fc
b15_f8c1:   sed                         ; 3F8C1:  f8
b15_f8c2:   ora ($f9,x)                 ; 3F8C2:  01 f9
b15_f8c4:   php                         ; 3F8C4:  08
b15_f8c5:   sbc $f90d,y                 ; 3F8C5:  f9 0d f9
b15_f8c8:   .db $13                     ; 3F8C8:  13
b15_f8c9:   sbc $f91a,y                 ; 3F8C9:  f9 1a f9
b15_f8cc:   asl $25f9,x                 ; 3F8CC:  1e f9 25
b15_f8cf:   sbc $f92b,y                 ; 3F8CF:  f9 2b f9
b15_f8d2:   eor (brk_scratch_hi,x)                 ; 3F8D2:  41 67
b15_f8d4:   adc scratch_ptr_lo                     ; 3F8D4:  65 00
b15_f8d6:   pha                         ; 3F8D6:  48
b15_f8d7:   jmp ($6874)                 ; 3F8D7:  6c 74 68
b15_f8da:   brk                         ; 3F8DA:  00
b15_f8db:   .db $44                     ; 3F8DB:  44
b15_f8dc:   .db ppumask_shadow                     ; 3F8DC:  72
b15_f8dd:   adc #$76                    ; 3F8DD:  69 76
b15_f8df:   brk                         ; 3F8DF:  00
b15_f8e0:   jmp $6375                   ; 3F8E0:  4c 75 63
b15_f8e3:   .db $6b                     ; 3F8E3:  6b
b15_f8e4:   brk                         ; 3F8E4:  00
b15_f8e5:   .db $43                     ; 3F8E5:  43
b15_f8e6:   pla                         ; 3F8E6:  68
b15_f8e7:   adc (ppumask_shadow,x)                 ; 3F8E7:  61 72
b15_f8e9:   brk                         ; 3F8E9:  00
b15_f8ea:   eor #$51                    ; 3F8EA:  49 51
b15_f8ec:   brk                         ; 3F8EC:  00
b15_f8ed:   .db $47                     ; 3F8ED:  47
b15_f8ee:   .db p2_buttons                     ; 3F8EE:  6f
b15_f8ef:   jmp ($0064)                 ; 3F8EF:  6c 64 00
b15_f8f2:   .db $44                     ; 3F8F2:  44
b15_f8f3:   adc $62                     ; 3F8F3:  65 62
b15_f8f5:   .db palette_dirty                     ; 3F8F5:  74
b15_f8f6:   brk                         ; 3F8F6:  00
b15_f8f7:   .db $54                     ; 3F8F7:  54
b15_f8f8:   .db p2_buttons                     ; 3F8F8:  6f
b15_f8f9:   .db $77                     ; 3F8F9:  77
b15_f8fa:   ror $5200                   ; 3F8FA:  6e 00 52
b15_f8fd:   adc #$63                    ; 3F8FD:  69 63
b15_f8ff:   adc scratch_ptr_lo                     ; 3F8FF:  65 00
b15_f901:   .db $4f                     ; 3F901:  4f
b15_f902:   adc palette_dirty,x                   ; 3F902:  75 74
b15_f904:   bvs $f97b                   ; 3F904:  70 75
b15_f906:   .db palette_dirty                     ; 3F906:  74
b15_f907:   brk                         ; 3F907:  00
b15_f908:   .db $44                     ; 3F908:  44
b15_f909:   adc ($6d,x)                 ; 3F909:  61 6d
b15_f90b:   .db prg_bank_shadow                     ; 3F90B:  73
b15_f90c:   brk                         ; 3F90C:  00
b15_f90d:   jmp $6c79                   ; 3F90D:  4c 79 6c
b15_f910:   .db palette_dirty                     ; 3F910:  74
b15_f911:   adc $5700,y                 ; 3F911:  79 00 57
b15_f914:   adc $61                     ; 3F914:  65 61
b15_f916:   jmp ($6874)                 ; 3F916:  6c 74 68
b15_f919:   brk                         ; 3F919:  00
b15_f91a:   eor $6e65                   ; 3F91A:  4d 65 6e
b15_f91d:   brk                         ; 3F91D:  00
b15_f91e:   eor $726f                   ; 3F91E:  4d 6f 72
b15_f921:   adc ($6c,x)                 ; 3F921:  61 6c
b15_f923:   adc scratch_ptr_lo                     ; 3F923:  65 00
b15_f925:   .db $53                     ; 3F925:  53
b15_f926:   .db $6b                     ; 3F926:  6b
b15_f927:   adc #$6c                    ; 3F927:  69 6c
b15_f929:   jmp ($4100)                 ; 3F929:  6c 00 41
b15_f92c:   .db ppumask_shadow                     ; 3F92C:  72
b15_f92d:   adc prg_bank_shadow                   ; 3F92D:  6d 73 00
msg_aiaoieueoikakikusasisusotatuto:   eor (brk_jmp_target_hi,x)                 ; 3F930:  41 69
b15_f932:   eor (p2_buttons,x)                 ; 3F932:  41 6f
b15_f934:   eor #$65                    ; 3F934:  49 65
b15_f936:   eor $65,x                   ; 3F936:  55 65
b15_f938:   .db $4f                     ; 3F938:  4f
b15_f939:   adc #$4b                    ; 3F939:  69 4b
b15_f93b:   adc ($4b,x)                 ; 3F93B:  61 4b
b15_f93d:   adc #$4b                    ; 3F93D:  69 4b
b15_f93f:   adc $53,x                   ; 3F93F:  75 53
b15_f941:   adc ($53,x)                 ; 3F941:  61 53
b15_f943:   adc #$53                    ; 3F943:  69 53
b15_f945:   adc $53,x                   ; 3F945:  75 53
b15_f947:   .db p2_buttons                     ; 3F947:  6f
b15_f948:   .db $54                     ; 3F948:  54
b15_f949:   adc ($54,x)                 ; 3F949:  61 54
b15_f94b:   adc $54,x                   ; 3F94B:  75 54
b15_f94d:   .db p2_buttons                     ; 3F94D:  6f
b15_f94e:   lsr $4e61                   ; 3F94E:  4e 61 4e
b15_f951:   .db p2_buttons                     ; 3F951:  6f
b15_f952:   pha                         ; 3F952:  48
b15_f953:   adc ($48,x)                 ; 3F953:  61 48
b15_f955:   adc #$48                    ; 3F955:  69 48
b15_f957:   adc $59,x                   ; 3F957:  75 59
b15_f959:   adc $59,x                   ; 3F959:  75 59
b15_f95b:   .db p2_buttons                     ; 3F95B:  6f
b15_f95c:   brk                         ; 3F95C:  00
msg_setenohomamimemoyarawagagizaze:   .db prg_bank_shadow                     ; 3F95D:  73
b15_f95e:   adc palette_dirty                     ; 3F95E:  65 74
b15_f960:   adc p1_buttons                     ; 3F960:  65 6e
b15_f962:   .db p2_buttons                     ; 3F962:  6f
b15_f963:   pla                         ; 3F963:  68
b15_f964:   .db p2_buttons                     ; 3F964:  6f
b15_f965:   adc newgame_player_count                   ; 3F965:  6d 61 6d
b15_f968:   adc #$6d                    ; 3F968:  69 6d
b15_f96a:   adc $6d                     ; 3F96A:  65 6d
b15_f96c:   .db p2_buttons                     ; 3F96C:  6f
b15_f96d:   adc $7261,y                 ; 3F96D:  79 61 72
b15_f970:   adc ($77,x)                 ; 3F970:  61 77
b15_f972:   adc (brk_scratch_hi,x)                 ; 3F972:  61 67
b15_f974:   adc (brk_scratch_hi,x)                 ; 3F974:  61 67
b15_f976:   adc #$7a                    ; 3F976:  69 7a
b15_f978:   adc (music_ptr_lo,x)                 ; 3F978:  61 7a
b15_f97a:   adc $64                     ; 3F97A:  65 64
b15_f97c:   adc ($64,x)                 ; 3F97C:  61 64
b15_f97e:   adc $62,x                   ; 3F97E:  75 62
b15_f980:   adc ($62,x)                 ; 3F980:  61 62
b15_f982:   adc #$62                    ; 3F982:  69 62
b15_f984:   ror $62,x                   ; 3F984:  76 62
b15_f986:   adc $6a                     ; 3F986:  65 6a
b15_f988:   .db p2_buttons                     ; 3F988:  6f
b15_f989:   brk                         ; 3F989:  00
msg_no_fiefs:   asl a                       ; 3F98A:  0a
b15_f98b:   ror $206f                   ; 3F98B:  6e 6f 20
b15_f98e:   ror brk_jmp_target_hi                     ; 3F98E:  66 69
b15_f990:   adc brk_scratch_lo                     ; 3F990:  65 66
b15_f992:   .db prg_bank_shadow                     ; 3F992:  73
b15_f993:   brk                         ; 3F993:  00
msg_fiefs:   jsr $4620                   ; 3F994:  20 20 46
b15_f997:   adc #$65                    ; 3F997:  69 65
b15_f999:   ror prg_bank_shadow                     ; 3F999:  66 73
b15_f99b:   jsr $4800                   ; 3F99B:  20 00 48
b15_f99e:   .db p2_buttons                     ; 3F99E:  6f
b15_f99f:   .db $77                     ; 3F99F:  77
b15_f9a0:   jsr $756d                   ; 3F9A0:  20 6d 75
b15_f9a3:   .db $63                     ; 3F9A3:  63
b15_f9a4:   pla                         ; 3F9A4:  68
b15_f9a5:   brk                         ; 3F9A5:  00
msg_how_many:   pha                         ; 3F9A6:  48
b15_f9a7:   .db p2_buttons                     ; 3F9A7:  6f
b15_f9a8:   .db $77                     ; 3F9A8:  77
b15_f9a9:   jsr $616d                   ; 3F9A9:  20 6d 61
b15_f9ac:   ror music_voice_idx                   ; 3F9AC:  6e 79 00
unit_type_name_table:   lda $f9,x                   ; 3F9AF:  b5 f9
b15_f9b1:   lda $c5f9,x                 ; 3F9B1:  bd f9 c5
b15_f9b4:   sbc $6952,y                 ; 3F9B4:  f9 52 69
b15_f9b7:   ror $6c                     ; 3F9B7:  66 6c
b15_f9b9:   adc prg_bank_shadow                     ; 3F9B9:  65 73
b15_f9bb:   jsr $4900                   ; 3F9BB:  20 00 49
b15_f9be:   ror $6e66                   ; 3F9BE:  6e 66 6e
b15_f9c1:   .db palette_dirty                     ; 3F9C1:  74
b15_f9c2:   .db ppumask_shadow                     ; 3F9C2:  72
b15_f9c3:   adc $4300,y                 ; 3F9C3:  79 00 43
b15_f9c6:   adc (mul_acc_hi,x)                 ; 3F9C6:  61 76
b15_f9c8:   adc ($6c,x)                 ; 3F9C8:  61 6c
b15_f9ca:   .db ppumask_shadow                     ; 3F9CA:  72
b15_f9cb:   adc $0a00,y                 ; 3F9CB:  79 00 0a
b15_f9ce:   eor $766f                   ; 3F9CE:  4d 6f 76
b15_f9d1:   adc $20                     ; 3F9D1:  65 20
b15_f9d3:   .db $77                     ; 3F9D3:  77
b15_f9d4:   pla                         ; 3F9D4:  68
b15_f9d5:   adc ppumask_shadow                     ; 3F9D5:  65 72
b15_f9d7:   adc $3f                     ; 3F9D7:  65 3f
b15_f9d9:   asl a                       ; 3F9D9:  0a
b15_f9da:   brk                         ; 3F9DA:  00
msg_how_many_men:   pha                         ; 3F9DB:  48
b15_f9dc:   .db p2_buttons                     ; 3F9DC:  6f
b15_f9dd:   .db $77                     ; 3F9DD:  77
b15_f9de:   jsr $616d                   ; 3F9DE:  20 6d 61
b15_f9e1:   ror $2079                   ; 3F9E1:  6e 79 20
b15_f9e4:   adc $6e65                   ; 3F9E4:  6d 65 6e
b15_f9e7:   brk                         ; 3F9E7:  00
msg_will_you_lead_them_personally:   .db $57                     ; 3F9E8:  57
b15_f9e9:   adc #$6c                    ; 3F9E9:  69 6c
b15_f9eb:   jmp ($7920)                 ; 3F9EB:  6c 20 79
b15_f9ee:   .db p2_buttons                     ; 3F9EE:  6f
b15_f9ef:   adc $20,x                   ; 3F9EF:  75 20
b15_f9f1:   jmp ($6165)                 ; 3F9F1:  6c 65 61
b15_f9f4:   .db $64                     ; 3F9F4:  64
b15_f9f5:   asl a                       ; 3F9F5:  0a
b15_f9f6:   .db palette_dirty                     ; 3F9F6:  74
b15_f9f7:   pla                         ; 3F9F7:  68
b15_f9f8:   adc $6d                     ; 3F9F8:  65 6d
b15_f9fa:   jsr $6570                   ; 3F9FA:  20 70 65
b15_f9fd:   .db ppumask_shadow                     ; 3F9FD:  72
b15_f9fe:   .db prg_bank_shadow                     ; 3F9FE:  73
b15_f9ff:   .db p2_buttons                     ; 3F9FF:  6f
b15_fa00:   ror $6c61                   ; 3FA00:  6e 61 6c
b15_fa03:   jmp (music_voice_idx)                 ; 3FA03:  6c 79 00
msg_they_have_arrived_safely:   .db $54                     ; 3FA06:  54
b15_fa07:   pla                         ; 3FA07:  68
b15_fa08:   adc music_voice_idx                     ; 3FA08:  65 79
b15_fa0a:   jsr $6168                   ; 3FA0A:  20 68 61
b15_fa0d:   ror $65,x                   ; 3FA0D:  76 65
b15_fa0f:   asl a                       ; 3FA0F:  0a
b15_fa10:   adc (ppumask_shadow,x)                 ; 3FA10:  61 72
b15_fa12:   .db ppumask_shadow                     ; 3FA12:  72
b15_fa13:   adc #$76                    ; 3FA13:  69 76
b15_fa15:   adc $64                     ; 3FA15:  65 64
b15_fa17:   jsr $6173                   ; 3FA17:  20 73 61
b15_fa1a:   ror $65                     ; 3FA1A:  66 65
b15_fa1c:   jmp (music_voice_idx)                 ; 3FA1C:  6c 79 00
msg_attack_where:   asl a                       ; 3FA1F:  0a
b15_fa20:   eor (palette_dirty,x)                 ; 3FA20:  41 74
b15_fa22:   .db palette_dirty                     ; 3FA22:  74
b15_fa23:   adc ($63,x)                 ; 3FA23:  61 63
b15_fa25:   .db $6b                     ; 3FA25:  6b
b15_fa26:   jsr $6877                   ; 3FA26:  20 77 68
b15_fa29:   adc ppumask_shadow                     ; 3FA29:  65 72
b15_fa2b:   adc $3f                     ; 3FA2B:  65 3f
b15_fa2d:   asl a                       ; 3FA2D:  0a
b15_fa2e:   brk                         ; 3FA2E:  00
msg_how_many_men_fa2f:   pha                         ; 3FA2F:  48
b15_fa30:   .db p2_buttons                     ; 3FA30:  6f
b15_fa31:   .db $77                     ; 3FA31:  77
b15_fa32:   jsr $616d                   ; 3FA32:  20 6d 61
b15_fa35:   ror $2079                   ; 3FA35:  6e 79 20
b15_fa38:   adc $6e65                   ; 3FA38:  6d 65 6e
b15_fa3b:   brk                         ; 3FA3B:  00
msg_how_much_rice_will_they_take:   pha                         ; 3FA3C:  48
b15_fa3d:   .db p2_buttons                     ; 3FA3D:  6f
b15_fa3e:   .db $77                     ; 3FA3E:  77
b15_fa3f:   jsr $756d                   ; 3FA3F:  20 6d 75
b15_fa42:   .db $63                     ; 3FA42:  63
b15_fa43:   pla                         ; 3FA43:  68
b15_fa44:   jsr $6972                   ; 3FA44:  20 72 69
b15_fa47:   .db $63                     ; 3FA47:  63
b15_fa48:   adc $0a                     ; 3FA48:  65 0a
b15_fa4a:   .db $77                     ; 3FA4A:  77
b15_fa4b:   adc #$6c                    ; 3FA4B:  69 6c
b15_fa4d:   jmp ($7420)                 ; 3FA4D:  6c 20 74
b15_fa50:   pla                         ; 3FA50:  68
b15_fa51:   adc music_voice_idx                     ; 3FA51:  65 79
b15_fa53:   jsr $6174                   ; 3FA53:  20 74 61
b15_fa56:   .db $6b                     ; 3FA56:  6b
b15_fa57:   adc scratch_ptr_lo                     ; 3FA57:  65 00
msg_will_you_lead_them_personally_fa59:   .db $57                     ; 3FA59:  57
b15_fa5a:   adc #$6c                    ; 3FA5A:  69 6c
b15_fa5c:   jmp ($7920)                 ; 3FA5C:  6c 20 79
b15_fa5f:   .db p2_buttons                     ; 3FA5F:  6f
b15_fa60:   adc $20,x                   ; 3FA60:  75 20
b15_fa62:   jmp ($6165)                 ; 3FA62:  6c 65 61
b15_fa65:   .db $64                     ; 3FA65:  64
b15_fa66:   asl a                       ; 3FA66:  0a
b15_fa67:   .db palette_dirty                     ; 3FA67:  74
b15_fa68:   pla                         ; 3FA68:  68
b15_fa69:   adc $6d                     ; 3FA69:  65 6d
b15_fa6b:   jsr $6570                   ; 3FA6B:  20 70 65
b15_fa6e:   .db ppumask_shadow                     ; 3FA6E:  72
b15_fa6f:   .db prg_bank_shadow                     ; 3FA6F:  73
b15_fa70:   .db p2_buttons                     ; 3FA70:  6f
b15_fa71:   ror $6c61                   ; 3FA71:  6e 61 6c
b15_fa74:   jmp (music_voice_idx)                 ; 3FA74:  6c 79 00
msg_tax_is_d_enter_new_tax:   .db $54                     ; 3FA77:  54
b15_fa78:   adc ($78,x)                 ; 3FA78:  61 78
b15_fa7a:   jsr $7369                   ; 3FA7A:  20 69 73
b15_fa7d:   jsr $6425                   ; 3FA7D:  20 25 64
b15_fa80:   asl a                       ; 3FA80:  0a
b15_fa81:   eor p1_buttons                     ; 3FA81:  45 6e
b15_fa83:   .db palette_dirty                     ; 3FA83:  74
b15_fa84:   adc ppumask_shadow                     ; 3FA84:  65 72
b15_fa86:   jsr $656e                   ; 3FA86:  20 6e 65
b15_fa89:   .db $77                     ; 3FA89:  77
b15_fa8a:   jsr $6174                   ; 3FA8A:  20 74 61
b15_fa8d:   sei                         ; 3FA8D:  78
b15_fa8e:   brk                         ; 3FA8E:  00
msg_the_peasants_are_delighted:   .db $54                     ; 3FA8F:  54
b15_fa90:   pla                         ; 3FA90:  68
b15_fa91:   adc $20                     ; 3FA91:  65 20
b15_fa93:   bvs $fafa                   ; 3FA93:  70 65
b15_fa95:   adc (prg_bank_shadow,x)                 ; 3FA95:  61 73
b15_fa97:   adc (p1_buttons,x)                 ; 3FA97:  61 6e
b15_fa99:   .db palette_dirty                     ; 3FA99:  74
b15_fa9a:   .db prg_bank_shadow                     ; 3FA9A:  73
b15_fa9b:   jsr $7261                   ; 3FA9B:  20 61 72
b15_fa9e:   adc $0a                     ; 3FA9E:  65 0a
b15_faa0:   .db $64                     ; 3FAA0:  64
b15_faa1:   adc $6c                     ; 3FAA1:  65 6c
b15_faa3:   adc #$67                    ; 3FAA3:  69 67
b15_faa5:   pla                         ; 3FAA5:  68
b15_faa6:   .db palette_dirty                     ; 3FAA6:  74
b15_faa7:   adc $64                     ; 3FAA7:  65 64
b15_faa9:   and (scratch_ptr_lo,x)                 ; 3FAA9:  21 00
msg_the_peasants_are_protesting:   .db $54                     ; 3FAAB:  54
b15_faac:   pla                         ; 3FAAC:  68
b15_faad:   adc $20                     ; 3FAAD:  65 20
b15_faaf:   bvs $fb16                   ; 3FAAF:  70 65
b15_fab1:   adc (prg_bank_shadow,x)                 ; 3FAB1:  61 73
b15_fab3:   adc (p1_buttons,x)                 ; 3FAB3:  61 6e
b15_fab5:   .db palette_dirty                     ; 3FAB5:  74
b15_fab6:   .db prg_bank_shadow                     ; 3FAB6:  73
b15_fab7:   jsr $7261                   ; 3FAB7:  20 61 72
b15_faba:   adc $0a                     ; 3FABA:  65 0a
b15_fabc:   bvs $fb30                   ; 3FABC:  70 72
b15_fabe:   .db p2_buttons                     ; 3FABE:  6f
b15_fabf:   .db palette_dirty                     ; 3FABF:  74
b15_fac0:   adc prg_bank_shadow                     ; 3FAC0:  65 73
b15_fac2:   .db palette_dirty                     ; 3FAC2:  74
b15_fac3:   adc #$6e                    ; 3FAC3:  69 6e
b15_fac5:   .db brk_scratch_hi                     ; 3FAC5:  67
b15_fac6:   and (scratch_ptr_lo,x)                 ; 3FAC6:  21 00
msg_send_where:   asl a                       ; 3FAC8:  0a
b15_fac9:   .db $53                     ; 3FAC9:  53
b15_faca:   adc p1_buttons                     ; 3FACA:  65 6e
b15_facc:   .db $64                     ; 3FACC:  64
b15_facd:   jsr $6877                   ; 3FACD:  20 77 68
b15_fad0:   adc ppumask_shadow                     ; 3FAD0:  65 72
b15_fad2:   adc $3f                     ; 3FAD2:  65 3f
b15_fad4:   jsr $4c00                   ; 3FAD4:  20 00 4c
b15_fad7:   .db p2_buttons                     ; 3FAD7:  6f
b15_fad8:   .db ppumask_shadow                     ; 3FAD8:  72
b15_fad9:   .db $64                     ; 3FAD9:  64
b15_fada:   bit $7920                   ; 3FADA:  2c 20 79
b15_fadd:   .db p2_buttons                     ; 3FADD:  6f
b15_fade:   adc $20,x                   ; 3FADE:  75 20
b15_fae0:   adc (ppumask_shadow,x)                 ; 3FAE0:  61 72
b15_fae2:   adc $20                     ; 3FAE2:  65 20
b15_fae4:   .db palette_dirty                     ; 3FAE4:  74
b15_fae5:   .db p2_buttons                     ; 3FAE5:  6f
b15_fae6:   .db p2_buttons                     ; 3FAE6:  6f
b15_fae7:   asl a                       ; 3FAE7:  0a
b15_fae8:   .db $77                     ; 3FAE8:  77
b15_fae9:   adc $61                     ; 3FAE9:  65 61
b15_faeb:   .db $6b                     ; 3FAEB:  6b
b15_faec:   jsr battle_defender_status_flag_6f66                   ; 3FAEC:  20 66 6f
b15_faef:   .db ppumask_shadow                     ; 3FAEF:  72
b15_faf0:   jsr $6162                   ; 3FAF0:  20 62 61
b15_faf3:   .db palette_dirty                     ; 3FAF3:  74
b15_faf4:   .db palette_dirty                     ; 3FAF4:  74
b15_faf5:   jmp ($2165)                 ; 3FAF5:  6c 65 21
b15_faf8:   brk                         ; 3FAF8:  00
b15_faf9:   brk                         ; 3FAF9:  00
msg_gold:   .db $47                     ; 3FAFA:  47
b15_fafb:   .db p2_buttons                     ; 3FAFB:  6f
b15_fafc:   jmp ($0064)                 ; 3FAFC:  6c 64 00
msg_rice:   .db $52                     ; 3FAFF:  52
b15_fb00:   adc #$63                    ; 3FB00:  69 63
b15_fb02:   adc scratch_ptr_lo                     ; 3FB02:  65 00
msg_the_supplies_have_arrived_safe:   .db $54                     ; 3FB04:  54
b15_fb05:   pla                         ; 3FB05:  68
b15_fb06:   adc $20                     ; 3FB06:  65 20
b15_fb08:   .db prg_bank_shadow                     ; 3FB08:  73
b15_fb09:   adc $70,x                   ; 3FB09:  75 70
b15_fb0b:   bvs $fb79                   ; 3FB0B:  70 6c
b15_fb0d:   adc #$65                    ; 3FB0D:  69 65
b15_fb0f:   .db prg_bank_shadow                     ; 3FB0F:  73
b15_fb10:   jsr $6168                   ; 3FB10:  20 68 61
b15_fb13:   ror $65,x                   ; 3FB13:  76 65
b15_fb15:   asl a                       ; 3FB15:  0a
b15_fb16:   adc (ppumask_shadow,x)                 ; 3FB16:  61 72
b15_fb18:   .db ppumask_shadow                     ; 3FB18:  72
b15_fb19:   adc #$76                    ; 3FB19:  69 76
b15_fb1b:   adc $64                     ; 3FB1B:  65 64
b15_fb1d:   jsr $6173                   ; 3FB1D:  20 73 61
b15_fb20:   ror $65                     ; 3FB20:  66 65
b15_fb22:   jmp (music_voice_idx)                 ; 3FB22:  6c 79 00
msg_s_is_d_spend_how_much_on_it:   and prg_bank_shadow                     ; 3FB25:  25 73
b15_fb27:   jsr $7369                   ; 3FB27:  20 69 73
b15_fb2a:   jsr $6425                   ; 3FB2A:  20 25 64
b15_fb2d:   asl a                       ; 3FB2D:  0a
b15_fb2e:   .db $53                     ; 3FB2E:  53
b15_fb2f:   bvs $fb96                   ; 3FB2F:  70 65
b15_fb31:   ror $2064                   ; 3FB31:  6e 64 20
b15_fb34:   pla                         ; 3FB34:  68
b15_fb35:   .db p2_buttons                     ; 3FB35:  6f
b15_fb36:   .db $77                     ; 3FB36:  77
b15_fb37:   jsr $756d                   ; 3FB37:  20 6d 75
b15_fb3a:   .db $63                     ; 3FB3A:  63
b15_fb3b:   pla                         ; 3FB3B:  68
b15_fb3c:   asl a                       ; 3FB3C:  0a
b15_fb3d:   .db p2_buttons                     ; 3FB3D:  6f
b15_fb3e:   ror $6920                   ; 3FB3E:  6e 20 69
b15_fb41:   .db palette_dirty                     ; 3FB41:  74
b15_fb42:   brk                         ; 3FB42:  00
msg_dams_value_is_now_d:   .db $44                     ; 3FB43:  44
b15_fb44:   adc ($6d,x)                 ; 3FB44:  61 6d
b15_fb46:   .db prg_bank_shadow                     ; 3FB46:  73
b15_fb47:   jsr $6176                   ; 3FB47:  20 76 61
b15_fb4a:   jmp ($6575)                 ; 3FB4A:  6c 75 65
b15_fb4d:   jsr $7369                   ; 3FB4D:  20 69 73
b15_fb50:   asl a                       ; 3FB50:  0a
b15_fb51:   ror $776f                   ; 3FB51:  6e 6f 77
b15_fb54:   jsr $6425                   ; 3FB54:  20 25 64
b15_fb57:   brk                         ; 3FB57:  00
msg_output_is_now_d:   .db $4f                     ; 3FB58:  4f
b15_fb59:   adc palette_dirty,x                   ; 3FB59:  75 74
b15_fb5b:   bvs $fbd2                   ; 3FB5B:  70 75
b15_fb5d:   .db palette_dirty                     ; 3FB5D:  74
b15_fb5e:   jsr $7369                   ; 3FB5E:  20 69 73
b15_fb61:   jsr $6f6e                   ; 3FB61:  20 6e 6f
b15_fb64:   .db $77                     ; 3FB64:  77
b15_fb65:   asl a                       ; 3FB65:  0a
b15_fb66:   and $64                     ; 3FB66:  25 64
b15_fb68:   brk                         ; 3FB68:  00
msg_no_merchant_in_the_area:   lsr $206f                   ; 3FB69:  4e 6f 20
b15_fb6c:   adc $7265                   ; 3FB6C:  6d 65 72
b15_fb6f:   .db $63                     ; 3FB6F:  63
b15_fb70:   pla                         ; 3FB70:  68
b15_fb71:   adc (p1_buttons,x)                 ; 3FB71:  61 6e
b15_fb73:   .db palette_dirty                     ; 3FB73:  74
b15_fb74:   jsr $6e69                   ; 3FB74:  20 69 6e
b15_fb77:   asl a                       ; 3FB77:  0a
b15_fb78:   .db palette_dirty                     ; 3FB78:  74
b15_fb79:   pla                         ; 3FB79:  68
b15_fb7a:   adc $20                     ; 3FB7A:  65 20
b15_fb7c:   adc (ppumask_shadow,x)                 ; 3FB7C:  61 72
b15_fb7e:   adc $61                     ; 3FB7E:  65 61
b15_fb80:   brk                         ; 3FB80:  00
msg_recruit_which:   .db $52                     ; 3FB81:  52
b15_fb82:   adc $63                     ; 3FB82:  65 63
b15_fb84:   .db ppumask_shadow                     ; 3FB84:  72
b15_fb85:   adc brk_jmp_target_hi,x                   ; 3FB85:  75 69
b15_fb87:   .db palette_dirty                     ; 3FB87:  74
b15_fb88:   jsr $6877                   ; 3FB88:  20 77 68
b15_fb8b:   adc #$63                    ; 3FB8B:  69 63
b15_fb8d:   pla                         ; 3FB8D:  68
b15_fb8e:   brk                         ; 3FB8E:  00
b15_fb8f:   brk                         ; 3FB8F:  00
msg_lord_s_we_now_have_d_men:   jmp $726f                   ; 3FB90:  4c 6f 72
b15_fb93:   .db $64                     ; 3FB93:  64
b15_fb94:   jsr $7325                   ; 3FB94:  20 25 73
b15_fb97:   bit $7720                   ; 3FB97:  2c 20 77
b15_fb9a:   adc $0a                     ; 3FB9A:  65 0a
b15_fb9c:   ror $776f                   ; 3FB9C:  6e 6f 77
b15_fb9f:   jsr $6168                   ; 3FB9F:  20 68 61
b15_fba2:   ror $65,x                   ; 3FBA2:  76 65
b15_fba4:   jsr $6425                   ; 3FBA4:  20 25 64
b15_fba7:   jsr $656d                   ; 3FBA7:  20 6d 65
b15_fbaa:   ror scratch_ptr_lo                   ; 3FBAA:  6e 00 00
b15_fbad:   brk                         ; 3FBAD:  00
msg_what_mission:   .db $57                     ; 3FBAE:  57
b15_fbaf:   pla                         ; 3FBAF:  68
b15_fbb0:   adc (palette_dirty,x)                 ; 3FBB0:  61 74
b15_fbb2:   jsr $696d                   ; 3FBB2:  20 6d 69
b15_fbb5:   .db prg_bank_shadow                     ; 3FBB5:  73
b15_fbb6:   .db prg_bank_shadow                     ; 3FBB6:  73
b15_fbb7:   adc #$6f                    ; 3FBB7:  69 6f
b15_fbb9:   ror $4500                   ; 3FBB9:  6e 00 45
b15_fbbc:   ror delay_loop_count                   ; 3FBBC:  6e 65 6d
b15_fbbf:   adc $6d20,y                 ; 3FBBF:  79 20 6d
b15_fbc2:   .db p2_buttons                     ; 3FBC2:  6f
b15_fbc3:   .db ppumask_shadow                     ; 3FBC3:  72
b15_fbc4:   adc ($6c,x)                 ; 3FBC4:  61 6c
b15_fbc6:   adc $20                     ; 3FBC6:  65 20
b15_fbc8:   adc #$73                    ; 3FBC8:  69 73
b15_fbca:   asl a                       ; 3FBCA:  0a
b15_fbcb:   ror $61                     ; 3FBCB:  66 61
b15_fbcd:   jmp ($696c)                 ; 3FBCD:  6c 6c 69
b15_fbd0:   ror $2067                   ; 3FBD0:  6e 67 20
b15_fbd3:   .db palette_dirty                     ; 3FBD3:  74
b15_fbd4:   .db p2_buttons                     ; 3FBD4:  6f
b15_fbd5:   jsr $6970                   ; 3FBD5:  20 70 69
b15_fbd8:   adc $63                     ; 3FBD8:  65 63
b15_fbda:   adc prg_bank_shadow                     ; 3FBDA:  65 73
b15_fbdc:   and (scratch_ptr_lo,x)                 ; 3FBDC:  21 00
msg_skill_is_now_d:   .db $53                     ; 3FBDE:  53
b15_fbdf:   .db $6b                     ; 3FBDF:  6b
b15_fbe0:   adc #$6c                    ; 3FBE0:  69 6c
b15_fbe2:   jmp ($6920)                 ; 3FBE2:  6c 20 69
b15_fbe5:   .db prg_bank_shadow                     ; 3FBE5:  73
b15_fbe6:   jsr $6f6e                   ; 3FBE6:  20 6e 6f
b15_fbe9:   .db $77                     ; 3FBE9:  77
b15_fbea:   jsr $6425                   ; 3FBEA:  20 25 64
b15_fbed:   brk                         ; 3FBED:  00
b15_fbee:   brk                         ; 3FBEE:  00
msg_view_which_fief:   lsr brk_jmp_target_hi,x                   ; 3FBEF:  56 69
b15_fbf1:   adc $77                     ; 3FBF1:  65 77
b15_fbf3:   jsr $6877                   ; 3FBF3:  20 77 68
b15_fbf6:   adc #$63                    ; 3FBF6:  69 63
b15_fbf8:   pla                         ; 3FBF8:  68
b15_fbf9:   jsr $6966                   ; 3FBF9:  20 66 69
b15_fbfc:   adc brk_scratch_lo                     ; 3FBFC:  65 66
b15_fbfe:   .db $3f                     ; 3FBFE:  3f
b15_fbff:   asl a                       ; 3FBFF:  0a
b15_fc00:   brk                         ; 3FC00:  00
msg_our_spy_was_caught:   .db $4f                     ; 3FC01:  4f
b15_fc02:   adc ppumask_shadow,x                   ; 3FC02:  75 72
b15_fc04:   jsr $7073                   ; 3FC04:  20 73 70
b15_fc07:   adc $7720,y                 ; 3FC07:  79 20 77
b15_fc0a:   adc (prg_bank_shadow,x)                 ; 3FC0A:  61 73
b15_fc0c:   asl a                       ; 3FC0C:  0a
b15_fc0d:   .db $63                     ; 3FC0D:  63
b15_fc0e:   adc (mul_acc_lo,x)                 ; 3FC0E:  61 75
b15_fc10:   .db brk_scratch_hi                     ; 3FC10:  67
b15_fc11:   pla                         ; 3FC11:  68
b15_fc12:   .db palette_dirty                     ; 3FC12:  74
b15_fc13:   brk                         ; 3FC13:  00
msg_town_value_is_now_d:   .db $54                     ; 3FC14:  54
b15_fc15:   .db p2_buttons                     ; 3FC15:  6f
b15_fc16:   .db $77                     ; 3FC16:  77
b15_fc17:   ror $7620                   ; 3FC17:  6e 20 76
b15_fc1a:   adc ($6c,x)                 ; 3FC1A:  61 6c
b15_fc1c:   adc $65,x                   ; 3FC1C:  75 65
b15_fc1e:   jsr $7369                   ; 3FC1E:  20 69 73
b15_fc21:   jsr $6f6e                   ; 3FC21:  20 6e 6f
b15_fc24:   .db $77                     ; 3FC24:  77
b15_fc25:   asl a                       ; 3FC25:  0a
b15_fc26:   and $64                     ; 3FC26:  25 64
b15_fc28:   brk                         ; 3FC28:  00
msg_gold_for_spy:   .db $47                     ; 3FC29:  47
b15_fc2a:   .db p2_buttons                     ; 3FC2A:  6f
b15_fc2b:   jmp ($2064)                 ; 3FC2B:  6c 64 20
b15_fc2e:   ror p2_buttons                     ; 3FC2E:  66 6f
b15_fc30:   .db ppumask_shadow                     ; 3FC30:  72
b15_fc31:   jsr $7073                   ; 3FC31:  20 73 70
b15_fc34:   adc $2500,y                 ; 3FC34:  79 00 25
b15_fc37:   .db $64                     ; 3FC37:  64
b15_fc38:   jsr $6570                   ; 3FC38:  20 70 65
b15_fc3b:   adc (prg_bank_shadow,x)                 ; 3FC3B:  61 73
b15_fc3d:   adc (p1_buttons,x)                 ; 3FC3D:  61 6e
b15_fc3f:   .db palette_dirty                     ; 3FC3F:  74
b15_fc40:   .db prg_bank_shadow                     ; 3FC40:  73
b15_fc41:   asl a                       ; 3FC41:  0a
b15_fc42:   pla                         ; 3FC42:  68
b15_fc43:   adc (mul_acc_hi,x)                 ; 3FC43:  61 76
b15_fc45:   adc $20                     ; 3FC45:  65 20
b15_fc47:   .db $64                     ; 3FC47:  64
b15_fc48:   adc brk_scratch_lo                     ; 3FC48:  65 66
b15_fc4a:   adc $63                     ; 3FC4A:  65 63
b15_fc4c:   .db palette_dirty                     ; 3FC4C:  74
b15_fc4d:   adc $64                     ; 3FC4D:  65 64
b15_fc4f:   brk                         ; 3FC4F:  00
msg_no_peasants_defected:   lsr $206f                   ; 3FC50:  4e 6f 20
b15_fc53:   bvs $fcba                   ; 3FC53:  70 65
b15_fc55:   adc (prg_bank_shadow,x)                 ; 3FC55:  61 73
b15_fc57:   adc (p1_buttons,x)                 ; 3FC57:  61 6e
b15_fc59:   .db palette_dirty                     ; 3FC59:  74
b15_fc5a:   .db prg_bank_shadow                     ; 3FC5A:  73
b15_fc5b:   asl a                       ; 3FC5B:  0a
b15_fc5c:   .db $64                     ; 3FC5C:  64
b15_fc5d:   adc brk_scratch_lo                     ; 3FC5D:  65 66
b15_fc5f:   adc $63                     ; 3FC5F:  65 63
b15_fc61:   .db palette_dirty                     ; 3FC61:  74
b15_fc62:   adc $64                     ; 3FC62:  65 64
b15_fc64:   and (scratch_ptr_lo,x)                 ; 3FC64:  21 00
msg_seasons:   .db $53                     ; 3FC66:  53
b15_fc67:   adc $61                     ; 3FC67:  65 61
b15_fc69:   .db prg_bank_shadow                     ; 3FC69:  73
b15_fc6a:   .db p2_buttons                     ; 3FC6A:  6f
b15_fc6b:   ror prg_bank_shadow                   ; 3FC6B:  6e 73 00
msg_it_will_do_you_good:   eor #$74                    ; 3FC6E:  49 74
b15_fc70:   jsr $6977                   ; 3FC70:  20 77 69
b15_fc73:   jmp ($206c)                 ; 3FC73:  6c 6c 20
b15_fc76:   .db $64                     ; 3FC76:  64
b15_fc77:   .db p2_buttons                     ; 3FC77:  6f
b15_fc78:   jsr ai_turn_loop_redispatch_flag                   ; 3FC78:  20 79 6f
b15_fc7b:   adc $0a,x                   ; 3FC7B:  75 0a
b15_fc7d:   .db brk_scratch_hi                     ; 3FC7D:  67
b15_fc7e:   .db p2_buttons                     ; 3FC7E:  6f
b15_fc7f:   .db p2_buttons                     ; 3FC7F:  6f
b15_fc80:   .db $64                     ; 3FC80:  64
b15_fc81:   brk                         ; 3FC81:  00
msg_lord_you_are_truly_wise:   jmp $726f                   ; 3FC82:  4c 6f 72
b15_fc85:   .db $64                     ; 3FC85:  64
b15_fc86:   bit $7920                   ; 3FC86:  2c 20 79
b15_fc89:   .db p2_buttons                     ; 3FC89:  6f
b15_fc8a:   adc $20,x                   ; 3FC8A:  75 20
b15_fc8c:   adc (ppumask_shadow,x)                 ; 3FC8C:  61 72
b15_fc8e:   adc $0a                     ; 3FC8E:  65 0a
b15_fc90:   .db palette_dirty                     ; 3FC90:  74
b15_fc91:   .db ppumask_shadow                     ; 3FC91:  72
b15_fc92:   adc $6c,x                   ; 3FC92:  75 6c
b15_fc94:   adc $7720,y                 ; 3FC94:  79 20 77
b15_fc97:   adc #$73                    ; 3FC97:  69 73
b15_fc99:   adc $21                     ; 3FC99:  65 21
b15_fc9b:   brk                         ; 3FC9B:  00
msg_which_fief:   asl a                       ; 3FC9C:  0a
b15_fc9d:   .db $57                     ; 3FC9D:  57
b15_fc9e:   pla                         ; 3FC9E:  68
b15_fc9f:   adc #$63                    ; 3FC9F:  69 63
b15_fca1:   pla                         ; 3FCA1:  68
b15_fca2:   jsr $6966                   ; 3FCA2:  20 66 69
b15_fca5:   adc brk_scratch_lo                     ; 3FCA5:  65 66
b15_fca7:   .db $3f                     ; 3FCA7:  3f
b15_fca8:   jsr $4c00                   ; 3FCA8:  20 00 4c
b15_fcab:   .db p2_buttons                     ; 3FCAB:  6f
b15_fcac:   .db ppumask_shadow                     ; 3FCAC:  72
b15_fcad:   .db $64                     ; 3FCAD:  64
b15_fcae:   jsr $7325                   ; 3FCAE:  20 25 73
b15_fcb1:   asl a                       ; 3FCB1:  0a
b15_fcb2:   .db palette_dirty                     ; 3FCB2:  74
b15_fcb3:   pla                         ; 3FCB3:  68
b15_fcb4:   adc music_voice_idx                     ; 3FCB4:  65 79
b15_fcb6:   rts                         ; 3FCB6:  60
b15_fcb7:   ror $65,x                   ; 3FCB7:  76 65
b15_fcb9:   jsr $6572                   ; 3FCB9:  20 72 65
b15_fcbc:   ror mul_acc_lo                     ; 3FCBC:  66 75
b15_fcbe:   .db prg_bank_shadow                     ; 3FCBE:  73
b15_fcbf:   adc $64                     ; 3FCBF:  65 64
b15_fcc1:   and (scratch_ptr_lo,x)                 ; 3FCC1:  21 00
msg_your_bride_to_be_has_arrived:   eor $756f,y                 ; 3FCC3:  59 6f 75
b15_fcc6:   .db ppumask_shadow                     ; 3FCC6:  72
b15_fcc7:   jsr $7262                   ; 3FCC7:  20 62 72
b15_fcca:   adc #$64                    ; 3FCCA:  69 64
b15_fccc:   adc $2d                     ; 3FCCC:  65 2d
b15_fcce:   .db palette_dirty                     ; 3FCCE:  74
b15_fccf:   .db p2_buttons                     ; 3FCCF:  6f
b15_fcd0:   and $6562                   ; 3FCD0:  2d 62 65
b15_fcd3:   asl a                       ; 3FCD3:  0a
b15_fcd4:   pla                         ; 3FCD4:  68
b15_fcd5:   adc (prg_bank_shadow,x)                 ; 3FCD5:  61 73
b15_fcd7:   jsr $7261                   ; 3FCD7:  20 61 72
b15_fcda:   .db ppumask_shadow                     ; 3FCDA:  72
b15_fcdb:   adc #$76                    ; 3FCDB:  69 76
b15_fcdd:   adc $64                     ; 3FCDD:  65 64
b15_fcdf:   brk                         ; 3FCDF:  00
msg_don_t_you_long_to_hear_the_pit:   .db $44                     ; 3FCE0:  44
b15_fce1:   .db p2_buttons                     ; 3FCE1:  6f
b15_fce2:   ror $7460                   ; 3FCE2:  6e 60 74
b15_fce5:   jsr ai_turn_loop_redispatch_flag                   ; 3FCE5:  20 79 6f
b15_fce8:   adc $20,x                   ; 3FCE8:  75 20
b15_fcea:   jmp ($6e6f)                 ; 3FCEA:  6c 6f 6e
b15_fced:   .db brk_scratch_hi                     ; 3FCED:  67
b15_fcee:   jsr $6f74                   ; 3FCEE:  20 74 6f
b15_fcf1:   asl a                       ; 3FCF1:  0a
b15_fcf2:   pla                         ; 3FCF2:  68
b15_fcf3:   adc $61                     ; 3FCF3:  65 61
b15_fcf5:   .db ppumask_shadow                     ; 3FCF5:  72
b15_fcf6:   jsr $6874                   ; 3FCF6:  20 74 68
b15_fcf9:   adc $0a                     ; 3FCF9:  65 0a
b15_fcfb:   bvs $fd66                   ; 3FCFB:  70 69
b15_fcfd:   .db palette_dirty                     ; 3FCFD:  74
b15_fcfe:   .db palette_dirty                     ; 3FCFE:  74
b15_fcff:   adc ppumask_shadow                     ; 3FCFF:  65 72
b15_fd01:   and $6170                   ; 3FD01:  2d 70 61
b15_fd04:   .db palette_dirty                     ; 3FD04:  74
b15_fd05:   .db palette_dirty                     ; 3FD05:  74
b15_fd06:   adc ppumask_shadow                     ; 3FD06:  65 72
b15_fd08:   jsr $666f                   ; 3FD08:  20 6f 66
b15_fd0b:   asl a                       ; 3FD0B:  0a
b15_fd0c:   adc ($20,x)                 ; 3FD0C:  61 20
b15_fd0e:   jmp ($7469)                 ; 3FD0E:  6c 69 74
b15_fd11:   .db palette_dirty                     ; 3FD11:  74
b15_fd12:   jmp ($2065)                 ; 3FD12:  6c 65 20
b15_fd15:   jmp ($726f)                 ; 3FD15:  6c 6f 72
b15_fd18:   .db $64                     ; 3FD18:  64
b15_fd19:   rts                         ; 3FD19:  60
b15_fd1a:   .db prg_bank_shadow                     ; 3FD1A:  73
b15_fd1b:   asl a                       ; 3FD1B:  0a
b15_fd1c:   ror p2_buttons                     ; 3FD1C:  66 6f
b15_fd1e:   .db p2_buttons                     ; 3FD1E:  6f
b15_fd1f:   .db palette_dirty                     ; 3FD1F:  74
b15_fd20:   .db prg_bank_shadow                     ; 3FD20:  73
b15_fd21:   .db palette_dirty                     ; 3FD21:  74
b15_fd22:   adc $70                     ; 3FD22:  65 70
b15_fd24:   .db prg_bank_shadow                     ; 3FD24:  73
b15_fd25:   brk                         ; 3FD25:  00
b15_fd26:   brk                         ; 3FD26:  00
msg_lord_s_s_wants_d_gold_pay:   jmp $726f                   ; 3FD27:  4c 6f 72
b15_fd2a:   .db $64                     ; 3FD2A:  64
b15_fd2b:   jsr $7325                   ; 3FD2B:  20 25 73
b15_fd2e:   bit $250a                   ; 3FD2E:  2c 0a 25
b15_fd31:   .db prg_bank_shadow                     ; 3FD31:  73
b15_fd32:   jsr $6177                   ; 3FD32:  20 77 61
b15_fd35:   ror $7374                   ; 3FD35:  6e 74 73
b15_fd38:   asl a                       ; 3FD38:  0a
b15_fd39:   and $64                     ; 3FD39:  25 64
b15_fd3b:   jsr battle_defender_province_staging                   ; 3FD3B:  20 67 6f
b15_fd3e:   jmp ($0a64)                 ; 3FD3E:  6c 64 0a
b15_fd41:   bvc $fda4                   ; 3FD41:  50 61
b15_fd43:   adc $4c00,y                 ; 3FD43:  79 00 4c
b15_fd46:   .db p2_buttons                     ; 3FD46:  6f
b15_fd47:   .db ppumask_shadow                     ; 3FD47:  72
b15_fd48:   .db $64                     ; 3FD48:  64
b15_fd49:   jsr $7325                   ; 3FD49:  20 25 73
b15_fd4c:   bit $250a                   ; 3FD4C:  2c 0a 25
b15_fd4f:   .db prg_bank_shadow                     ; 3FD4F:  73
b15_fd50:   jsr $6177                   ; 3FD50:  20 77 61
b15_fd53:   ror $7374                   ; 3FD53:  6e 74 73
b15_fd56:   asl a                       ; 3FD56:  0a
b15_fd57:   and $64                     ; 3FD57:  25 64
b15_fd59:   jsr battle_defender_province_staging                   ; 3FD59:  20 67 6f
b15_fd5c:   jmp ($0a64)                 ; 3FD5C:  6c 64 0a
b15_fd5f:   bvc $fdc2                   ; 3FD5F:  50 61
b15_fd61:   adc $5700,y                 ; 3FD61:  79 00 57
b15_fd64:   adc (ppumask_shadow,x)                 ; 3FD64:  61 72
b15_fd66:   jsr $7369                   ; 3FD66:  20 69 73
b15_fd69:   jsr $6e69                   ; 3FD69:  20 69 6e
b15_fd6c:   adc mul_acc_hi                     ; 3FD6C:  65 76
b15_fd6e:   adc #$74                    ; 3FD6E:  69 74
b15_fd70:   adc ($62,x)                 ; 3FD70:  61 62
b15_fd72:   jmp ($0a65)                 ; 3FD72:  6c 65 0a
b15_fd75:   .db prg_bank_shadow                     ; 3FD75:  73
b15_fd76:   .db p2_buttons                     ; 3FD76:  6f
b15_fd77:   jsr $6f64                   ; 3FD77:  20 64 6f
b15_fd7a:   ror $7460                   ; 3FD7A:  6e 60 74
b15_fd7d:   jsr $656c                   ; 3FD7D:  20 6c 65
b15_fd80:   .db palette_dirty                     ; 3FD80:  74
b15_fd81:   jsr ai_turn_loop_redispatch_flag                   ; 3FD81:  20 79 6f
b15_fd84:   adc ppumask_shadow,x                   ; 3FD84:  75 72
b15_fd86:   asl a                       ; 3FD86:  0a
b15_fd87:   .db brk_scratch_hi                     ; 3FD87:  67
b15_fd88:   adc $61,x                   ; 3FD88:  75 61
b15_fd8a:   .db ppumask_shadow                     ; 3FD8A:  72
b15_fd8b:   .db $64                     ; 3FD8B:  64
b15_fd8c:   jsr $6f64                   ; 3FD8C:  20 64 6f
b15_fd8f:   .db $77                     ; 3FD8F:  77
b15_fd90:   ror $0021                   ; 3FD90:  6e 21 00
msg_who_needs_him_anyway:   .db $57                     ; 3FD93:  57
b15_fd94:   pla                         ; 3FD94:  68
b15_fd95:   .db p2_buttons                     ; 3FD95:  6f
b15_fd96:   jsr $656e                   ; 3FD96:  20 6e 65
b15_fd99:   adc $64                     ; 3FD99:  65 64
b15_fd9b:   .db prg_bank_shadow                     ; 3FD9B:  73
b15_fd9c:   jsr $6968                   ; 3FD9C:  20 68 69
b15_fd9f:   adc $610a                   ; 3FD9F:  6d 0a 61
b15_fda2:   ror $7779                   ; 3FDA2:  6e 79 77
b15_fda5:   adc (music_voice_idx,x)                 ; 3FDA5:  61 79
b15_fda7:   brk                         ; 3FDA7:  00
msg_give_how_much:   .db $47                     ; 3FDA8:  47
b15_fda9:   adc #$76                    ; 3FDA9:  69 76
b15_fdab:   adc $20                     ; 3FDAB:  65 20
b15_fdad:   pla                         ; 3FDAD:  68
b15_fdae:   .db p2_buttons                     ; 3FDAE:  6f
b15_fdaf:   .db $77                     ; 3FDAF:  77
b15_fdb0:   jsr $756d                   ; 3FDB0:  20 6d 75
b15_fdb3:   .db $63                     ; 3FDB3:  63
b15_fdb4:   pla                         ; 3FDB4:  68
b15_fdb5:   brk                         ; 3FDB5:  00
msg_thank_you_lord:   .db $54                     ; 3FDB6:  54
b15_fdb7:   pla                         ; 3FDB7:  68
b15_fdb8:   adc (p1_buttons,x)                 ; 3FDB8:  61 6e
b15_fdba:   .db $6b                     ; 3FDBA:  6b
b15_fdbb:   jsr ai_turn_loop_redispatch_flag                   ; 3FDBB:  20 79 6f
b15_fdbe:   adc $20,x                   ; 3FDBE:  75 20
b15_fdc0:   jmp $726f                   ; 3FDC0:  4c 6f 72
b15_fdc3:   .db $64                     ; 3FDC3:  64
b15_fdc4:   and (scratch_ptr_lo,x)                 ; 3FDC4:  21 00
msg_we_re_at_our_limit:   .db $57                     ; 3FDC6:  57
b15_fdc7:   adc $60                     ; 3FDC7:  65 60
b15_fdc9:   .db ppumask_shadow                     ; 3FDC9:  72
b15_fdca:   adc $20                     ; 3FDCA:  65 20
b15_fdcc:   adc (palette_dirty,x)                 ; 3FDCC:  61 74
b15_fdce:   jsr $756f                   ; 3FDCE:  20 6f 75
b15_fdd1:   .db ppumask_shadow                     ; 3FDD1:  72
b15_fdd2:   asl a                       ; 3FDD2:  0a
b15_fdd3:   jmp ($6d69)                 ; 3FDD3:  6c 69 6d
b15_fdd6:   adc #$74                    ; 3FDD6:  69 74
str_you_have_no_units:   brk                         ; 3FDD8:  00
msg_you_have_no_gold:   eor $756f,y                 ; 3FDD9:  59 6f 75
b15_fddc:   jsr $6168                   ; 3FDDC:  20 68 61
b15_fddf:   ror $65,x                   ; 3FDDF:  76 65
b15_fde1:   jsr $6f6e                   ; 3FDE1:  20 6e 6f
b15_fde4:   jsr battle_defender_province_staging                   ; 3FDE4:  20 67 6f
b15_fde7:   jmp ($2164)                 ; 3FDE7:  6c 64 21
b15_fdea:   brk                         ; 3FDEA:  00
msg_you_have_no_rice:   eor $756f,y                 ; 3FDEB:  59 6f 75
b15_fdee:   jsr $6168                   ; 3FDEE:  20 68 61
b15_fdf1:   ror $65,x                   ; 3FDF1:  76 65
b15_fdf3:   jsr $6f6e                   ; 3FDF3:  20 6e 6f
b15_fdf6:   jsr $6972                   ; 3FDF6:  20 72 69
b15_fdf9:   .db $63                     ; 3FDF9:  63
b15_fdfa:   adc $21                     ; 3FDFA:  65 21
b15_fdfc:   brk                         ; 3FDFC:  00
msg_you_have_no_soldiers:   eor $756f,y                 ; 3FDFD:  59 6f 75
b15_fe00:   jsr $6168                   ; 3FE00:  20 68 61
b15_fe03:   ror $65,x                   ; 3FE03:  76 65
b15_fe05:   jsr $6f6e                   ; 3FE05:  20 6e 6f
b15_fe08:   asl a                       ; 3FE08:  0a
b15_fe09:   .db prg_bank_shadow                     ; 3FE09:  73
b15_fe0a:   .db p2_buttons                     ; 3FE0A:  6f
b15_fe0b:   jmp ($6964)                 ; 3FE0B:  6c 64 69
b15_fe0e:   adc ppumask_shadow                     ; 3FE0E:  65 72
b15_fe10:   .db prg_bank_shadow                     ; 3FE10:  73
b15_fe11:   and (scratch_ptr_lo,x)                 ; 3FE11:  21 00
msg_you_have_no_peasants:   eor $756f,y                 ; 3FE13:  59 6f 75
b15_fe16:   jsr $6168                   ; 3FE16:  20 68 61
b15_fe19:   ror $65,x                   ; 3FE19:  76 65
b15_fe1b:   jsr $6f6e                   ; 3FE1B:  20 6e 6f
b15_fe1e:   asl a                       ; 3FE1E:  0a
b15_fe1f:   bvs $fe86                   ; 3FE1F:  70 65
b15_fe21:   adc (prg_bank_shadow,x)                 ; 3FE21:  61 73
b15_fe23:   adc (p1_buttons,x)                 ; 3FE23:  61 6e
b15_fe25:   .db palette_dirty                     ; 3FE25:  74
b15_fe26:   .db prg_bank_shadow                     ; 3FE26:  73
b15_fe27:   and (scratch_ptr_lo,x)                 ; 3FE27:  21 00
msg_they_are_your_allies:   .db $54                     ; 3FE29:  54
b15_fe2a:   pla                         ; 3FE2A:  68
b15_fe2b:   adc music_voice_idx                     ; 3FE2B:  65 79
b15_fe2d:   jsr $7261                   ; 3FE2D:  20 61 72
b15_fe30:   adc $20                     ; 3FE30:  65 20
b15_fe32:   adc $756f,y                 ; 3FE32:  79 6f 75
b15_fe35:   .db ppumask_shadow                     ; 3FE35:  72
b15_fe36:   asl a                       ; 3FE36:  0a
b15_fe37:   adc ($6c,x)                 ; 3FE37:  61 6c
b15_fe39:   jmp ($6569)                 ; 3FE39:  6c 69 65
b15_fe3c:   .db prg_bank_shadow                     ; 3FE3C:  73
b15_fe3d:   and (scratch_ptr_lo,x)                 ; 3FE3D:  21 00
b15_fe3f:   brk                         ; 3FE3F:  00
msg_which_fief_fe40:   asl a                       ; 3FE40:  0a
b15_fe41:   .db $57                     ; 3FE41:  57
b15_fe42:   pla                         ; 3FE42:  68
b15_fe43:   adc #$63                    ; 3FE43:  69 63
b15_fe45:   pla                         ; 3FE45:  68
b15_fe46:   jsr $6966                   ; 3FE46:  20 66 69
b15_fe49:   adc brk_scratch_lo                     ; 3FE49:  65 66
b15_fe4b:   jsr $0a00                   ; 3FE4B:  20 00 0a
b15_fe4e:   .db $57                     ; 3FE4E:  57
b15_fe4f:   pla                         ; 3FE4F:  68
b15_fe50:   adc (palette_dirty,x)                 ; 3FE50:  61 74
b15_fe52:   jsr $7261                   ; 3FE52:  20 61 72
b15_fe55:   adc $20                     ; 3FE55:  65 20
b15_fe57:   adc $756f,y                 ; 3FE57:  79 6f 75
b15_fe5a:   .db ppumask_shadow                     ; 3FE5A:  72
b15_fe5b:   asl a                       ; 3FE5B:  0a
b15_fe5c:   .db p2_buttons                     ; 3FE5C:  6f
b15_fe5d:   .db ppumask_shadow                     ; 3FE5D:  72
b15_fe5e:   .db $64                     ; 3FE5E:  64
b15_fe5f:   adc ppumask_shadow                     ; 3FE5F:  65 72
b15_fe61:   .db prg_bank_shadow                     ; 3FE61:  73
b15_fe62:   .db $3f                     ; 3FE62:  3f
b15_fe63:   brk                         ; 3FE63:  00
msg_it_s_currently_a_s_state_ok_to:   eor #$74                    ; 3FE64:  49 74
b15_fe66:   rts                         ; 3FE66:  60
b15_fe67:   .db prg_bank_shadow                     ; 3FE67:  73
b15_fe68:   jsr $7563                   ; 3FE68:  20 63 75
b15_fe6b:   .db ppumask_shadow                     ; 3FE6B:  72
b15_fe6c:   .db ppumask_shadow                     ; 3FE6C:  72
b15_fe6d:   adc p1_buttons                     ; 3FE6D:  65 6e
b15_fe6f:   .db palette_dirty                     ; 3FE6F:  74
b15_fe70:   jmp ($2079)                 ; 3FE70:  6c 79 20
b15_fe73:   adc ($0a,x)                 ; 3FE73:  61 0a
b15_fe75:   and prg_bank_shadow                     ; 3FE75:  25 73
b15_fe77:   jsr $7473                   ; 3FE77:  20 73 74
b15_fe7a:   adc (palette_dirty,x)                 ; 3FE7A:  61 74
b15_fe7c:   adc $0a                     ; 3FE7C:  65 0a
b15_fe7e:   .db $4f                     ; 3FE7E:  4f
b15_fe7f:   .db $4b                     ; 3FE7F:  4b
b15_fe80:   jsr $6f74                   ; 3FE80:  20 74 6f
b15_fe83:   jsr $616d                   ; 3FE83:  20 6d 61
b15_fe86:   .db $6b                     ; 3FE86:  6b
b15_fe87:   adc $20                     ; 3FE87:  65 20
b15_fe89:   adc #$74                    ; 3FE89:  69 74
b15_fe8b:   jsr $0a61                   ; 3FE8B:  20 61 0a
b15_fe8e:   and prg_bank_shadow                     ; 3FE8E:  25 73
b15_fe90:   jsr $7473                   ; 3FE90:  20 73 74
b15_fe93:   adc (palette_dirty,x)                 ; 3FE93:  61 74
b15_fe95:   adc scratch_ptr_lo                     ; 3FE95:  65 00
msg_bribe_which:   asl a                       ; 3FE97:  0a
b15_fe98:   .db $42                     ; 3FE98:  42
b15_fe99:   .db ppumask_shadow                     ; 3FE99:  72
b15_fe9a:   adc #$62                    ; 3FE9A:  69 62
b15_fe9c:   adc $20                     ; 3FE9C:  65 20
b15_fe9e:   .db $77                     ; 3FE9E:  77
b15_fe9f:   pla                         ; 3FE9F:  68
b15_fea0:   adc #$63                    ; 3FEA0:  69 63
b15_fea2:   pla                         ; 3FEA2:  68
b15_fea3:   .db $3f                     ; 3FEA3:  3f
b15_fea4:   jsr $0200                   ; 3FEA4:  20 00 02
b15_fea7:   .db vm_sp_lo                     ; 3FEA7:  02
b15_fea8:   .db vm_sp_lo                     ; 3FEA8:  02
b15_fea9:   .db vm_sp_lo                     ; 3FEA9:  02
b15_feaa:   .db vm_sp_lo                     ; 3FEAA:  02
b15_feab:   .db vm_sp_lo                     ; 3FEAB:  02
b15_feac:   .db vm_sp_lo                     ; 3FEAC:  02
b15_fead:   .db vm_fp_lo                     ; 3FEAD:  04
b15_feae:   .db vm_fp_lo                     ; 3FEAE:  04
b15_feaf:   .db vm_fp_lo                     ; 3FEAF:  04
b15_feb0:   .db vm_fp_lo                     ; 3FEB0:  04
b15_feb1:   .db vm_fp_lo                     ; 3FEB1:  04
b15_feb2:   .db vm_fp_lo                     ; 3FEB2:  04
b15_feb3:   .db vm_fp_lo                     ; 3FEB3:  04
b15_feb4:   .db vm_sp_hi                     ; 3FEB4:  03
b15_feb5:   .db vm_sp_hi                     ; 3FEB5:  03
b15_feb6:   .db vm_sp_hi                     ; 3FEB6:  03
b15_feb7:   .db vm_sp_hi                     ; 3FEB7:  03
b15_feb8:   .db vm_sp_hi                     ; 3FEB8:  03
b15_feb9:   ora vm_sp_hi                     ; 3FEB9:  05 03
b15_febb:   ora vm_fp_hi                     ; 3FEBB:  05 05
b15_febd:   ora vm_fp_hi                     ; 3FEBD:  05 05
b15_febf:   asl vm_ip_lo                     ; 3FEBF:  06 06
b15_fec1:   asl vm_ip_lo                     ; 3FEC1:  06 06
b15_fec3:   asl vm_ip_lo                     ; 3FEC3:  06 06
b15_fec5:   asl vm_ip_lo                     ; 3FEC5:  06 06
b15_fec7:   asl vm_ip_hi                     ; 3FEC7:  06 07
b15_fec9:   .db vm_ip_hi                     ; 3FEC9:  07
b15_feca:   .db vm_ip_hi                     ; 3FECA:  07
b15_fecb:   .db vm_ip_hi                     ; 3FECB:  07
b15_fecc:   php                         ; 3FECC:  08
b15_fecd:   .db vm_ip_hi                     ; 3FECD:  07
b15_fece:   .db vm_ip_hi                     ; 3FECE:  07
b15_fecf:   .db vm_ip_hi                     ; 3FECF:  07
b15_fed0:   .db vm_ip_hi                     ; 3FED0:  07
b15_fed1:   .db vm_ip_hi                     ; 3FED1:  07
b15_fed2:   php                         ; 3FED2:  08
b15_fed3:   php                         ; 3FED3:  08
b15_fed4:   php                         ; 3FED4:  08
b15_fed5:   php                         ; 3FED5:  08
b15_fed6:   php                         ; 3FED6:  08
b15_fed7:   php                         ; 3FED7:  08
province_to_map_section_17:   brk                         ; 3FED8:  00
b15_fed9:   brk                         ; 3FED9:  00
b15_feda:   brk                         ; 3FEDA:  00
b15_fedb:   brk                         ; 3FEDB:  00
b15_fedc:   ora (scratch_ptr_lo,x)                 ; 3FEDC:  01 00
b15_fede:   brk                         ; 3FEDE:  00
b15_fedf:   brk                         ; 3FEDF:  00
b15_fee0:   brk                         ; 3FEE0:  00
b15_fee1:   ora (scratch_ptr_hi,x)                 ; 3FEE1:  01 01
b15_fee3:   ora (scratch_ptr_hi,x)                 ; 3FEE3:  01 01
b15_fee5:   ora (scratch_ptr_hi,x)                 ; 3FEE5:  01 01
b15_fee7:   brk                         ; 3FEE7:  00
b15_fee8:   brk                         ; 3FEE8:  00
governance_state_label_ptrs:   .db $f7                     ; 3FEE9:  f7
b15_feea:   inc $ff00,x                 ; 3FEEA:  fe 00 ff
b15_feed:   .db vm_fp_lo                     ; 3FEED:  04
b15_feee:   .db $ff                     ; 3FEEE:  ff
b15_feef:   php                         ; 3FEEF:  08
b15_fef0:   .db $ff                     ; 3FEF0:  ff
b15_fef1:   .db $0c                     ; 3FEF1:  0c
b15_fef2:   .db $ff                     ; 3FEF2:  ff
b15_fef3:   ora ($ff),y                 ; 3FEF3:  11 ff
b15_fef5:   ora $ff,x                   ; 3FEF5:  15 ff
b15_fef7:   eor (prg_bank_shadow,x)                 ; 3FEF7:  41 73
b15_fef9:   .db prg_bank_shadow                     ; 3FEF9:  73
b15_fefa:   adc #$67                    ; 3FEFA:  69 67
b15_fefc:   ror $0a0a                   ; 3FEFC:  6e 0a 0a
b15_feff:   brk                         ; 3FEFF:  00
b15_ff00:   eor #$6e                    ; 3FF00:  49 6e
b15_ff02:   .db $64                     ; 3FF02:  64
b15_ff03:   brk                         ; 3FF03:  00
b15_ff04:   eor $6c69                   ; 3FF04:  4d 69 6c
b15_ff07:   brk                         ; 3FF07:  00
b15_ff08:   .db $42                     ; 3FF08:  42
b15_ff09:   adc ($6c,x)                 ; 3FF09:  61 6c
b15_ff0b:   brk                         ; 3FF0B:  00
b15_ff0c:   lsr $61                     ; 3FF0C:  46 61
b15_ff0e:   .db ppumask_shadow                     ; 3FF0E:  72
b15_ff0f:   adc $4400                   ; 3FF0F:  6d 00 44
b15_ff12:   adc #$72                    ; 3FF12:  69 72
b15_ff14:   brk                         ; 3FF14:  00
b15_ff15:   eor $6e65                   ; 3FF15:  4d 65 6e
b15_ff18:   adc scratch_ptr_lo,x                   ; 3FF18:  75 00
settings_menu_str_ptrs:   plp                         ; 3FF1A:  28
b15_ff1b:   .db $ff                     ; 3FF1B:  ff
b15_ff1c:   rol $35ff                   ; 3FF1C:  2e ff 35
b15_ff1f:   .db $ff                     ; 3FF1F:  ff
b15_ff20:   .db $3a                     ; 3FF20:  3a
b15_ff21:   .db $ff                     ; 3FF21:  ff
b15_ff22:   .db $3f                     ; 3FF22:  3f
b15_ff23:   .db $ff                     ; 3FF23:  ff
b15_ff24:   lsr $ff                     ; 3FF24:  46 ff
b15_ff26:   lsr a                       ; 3FF26:  4a
b15_ff27:   .db $ff                     ; 3FF27:  ff
b15_ff28:   .db $53                     ; 3FF28:  53
b15_ff29:   .db p2_buttons                     ; 3FF29:  6f
b15_ff2a:   adc p1_buttons,x                   ; 3FF2A:  75 6e
b15_ff2c:   .db $64                     ; 3FF2C:  64
b15_ff2d:   brk                         ; 3FF2D:  00
b15_ff2e:   eor (p1_buttons,x)                 ; 3FF2E:  41 6e
b15_ff30:   adc #$6d                    ; 3FF30:  69 6d
b15_ff32:   adc (palette_dirty,x)                 ; 3FF32:  61 74
b15_ff34:   brk                         ; 3FF34:  00
b15_ff35:   .db $57                     ; 3FF35:  57
b15_ff36:   adc (brk_jmp_target_hi,x)                 ; 3FF36:  61 69
b15_ff38:   .db palette_dirty                     ; 3FF38:  74
b15_ff39:   brk                         ; 3FF39:  00
b15_ff3a:   .db $53                     ; 3FF3A:  53
b15_ff3b:   adc (mul_acc_hi,x)                 ; 3FF3B:  61 76
b15_ff3d:   adc scratch_ptr_lo                     ; 3FF3D:  65 00
b15_ff3f:   .db $42                     ; 3FF3F:  42
b15_ff40:   adc (palette_dirty,x)                 ; 3FF40:  61 74
b15_ff42:   .db palette_dirty                     ; 3FF42:  74
b15_ff43:   jmp ($0065)                 ; 3FF43:  6c 65 00
b15_ff46:   eor p1_buttons                     ; 3FF46:  45 6e
b15_ff48:   .db $64                     ; 3FF48:  64
b15_ff49:   brk                         ; 3FF49:  00
b15_ff4a:   eor $6e65                   ; 3FF4A:  4d 65 6e
b15_ff4d:   adc scratch_ptr_lo,x                   ; 3FF4D:  75 00
trade_menu_str_ptrs:   .db $5b                     ; 3FF4F:  5b
b15_ff50:   .db $ff                     ; 3FF50:  ff
b15_ff51:   rts                         ; 3FF51:  60
b15_ff52:   .db $ff                     ; 3FF52:  ff
b15_ff53:   ror $ff                     ; 3FF53:  66 ff
b15_ff55:   .db $6b                     ; 3FF55:  6b
b15_ff56:   .db $ff                     ; 3FF56:  ff
b15_ff57:   .db p2_buttons                     ; 3FF57:  6f
b15_ff58:   .db $ff                     ; 3FF58:  ff
b15_ff59:   .db palette_dirty                     ; 3FF59:  74
b15_ff5a:   .db $ff                     ; 3FF5A:  ff
b15_ff5b:   jmp $616f                   ; 3FF5B:  4c 6f 61
b15_ff5e:   ror $5200                   ; 3FF5E:  6e 00 52
b15_ff61:   adc $70                     ; 3FF61:  65 70
b15_ff63:   adc (music_voice_idx,x)                 ; 3FF63:  61 79
b15_ff65:   brk                         ; 3FF65:  00
b15_ff66:   .db $53                     ; 3FF66:  53
b15_ff67:   adc $6c                     ; 3FF67:  65 6c
b15_ff69:   jmp ($4200)                 ; 3FF69:  6c 00 42
b15_ff6c:   adc music_voice_idx,x                   ; 3FF6C:  75 79
b15_ff6e:   brk                         ; 3FF6E:  00
b15_ff6f:   eor (ppumask_shadow,x)                 ; 3FF6F:  41 72
b15_ff71:   adc prg_bank_shadow                   ; 3FF71:  6d 73 00
b15_ff74:   eor $6e65                   ; 3FF74:  4d 65 6e
b15_ff77:   adc scratch_ptr_lo,x                   ; 3FF77:  75 00
b15_ff79:   brk                         ; 3FF79:  00
b15_ff7a:   .db $ff                     ; 3FF7A:  ff
b15_ff7b:   .db $ff                     ; 3FF7B:  ff
b15_ff7c:   .db $ff                     ; 3FF7C:  ff
b15_ff7d:   .db $ff                     ; 3FF7D:  ff
b15_ff7e:   .db $ff                     ; 3FF7E:  ff
b15_ff7f:   .db $ff                     ; 3FF7F:  ff
b15_ff80:   .db $ff                     ; 3FF80:  ff
b15_ff81:   .db $ff                     ; 3FF81:  ff
b15_ff82:   .db $ff                     ; 3FF82:  ff
b15_ff83:   .db $ff                     ; 3FF83:  ff
b15_ff84:   .db $ff                     ; 3FF84:  ff
b15_ff85:   .db $ff                     ; 3FF85:  ff
b15_ff86:   .db $ff                     ; 3FF86:  ff
b15_ff87:   .db $ff                     ; 3FF87:  ff
b15_ff88:   .db $ff                     ; 3FF88:  ff
b15_ff89:   .db $ff                     ; 3FF89:  ff
b15_ff8a:   .db $ff                     ; 3FF8A:  ff
b15_ff8b:   .db $ff                     ; 3FF8B:  ff
b15_ff8c:   .db $ff                     ; 3FF8C:  ff
b15_ff8d:   .db $ff                     ; 3FF8D:  ff
b15_ff8e:   .db $ff                     ; 3FF8E:  ff
b15_ff8f:   .db $ff                     ; 3FF8F:  ff
b15_ff90:   .db $ff                     ; 3FF90:  ff
b15_ff91:   .db $ff                     ; 3FF91:  ff
b15_ff92:   .db $ff                     ; 3FF92:  ff
b15_ff93:   .db $ff                     ; 3FF93:  ff
b15_ff94:   .db $ff                     ; 3FF94:  ff
b15_ff95:   .db $ff                     ; 3FF95:  ff
b15_ff96:   .db $ff                     ; 3FF96:  ff
b15_ff97:   .db $ff                     ; 3FF97:  ff
b15_ff98:   .db $ff                     ; 3FF98:  ff
b15_ff99:   .db $ff                     ; 3FF99:  ff
b15_ff9a:   .db $ff                     ; 3FF9A:  ff
b15_ff9b:   .db $ff                     ; 3FF9B:  ff
b15_ff9c:   .db $ff                     ; 3FF9C:  ff
b15_ff9d:   .db $ff                     ; 3FF9D:  ff
b15_ff9e:   .db $ff                     ; 3FF9E:  ff
b15_ff9f:   .db $ff                     ; 3FF9F:  ff
b15_ffa0:   .db $ff                     ; 3FFA0:  ff
b15_ffa1:   .db $ff                     ; 3FFA1:  ff
b15_ffa2:   .db $ff                     ; 3FFA2:  ff
b15_ffa3:   .db $ff                     ; 3FFA3:  ff
b15_ffa4:   .db $ff                     ; 3FFA4:  ff
b15_ffa5:   .db $ff                     ; 3FFA5:  ff
b15_ffa6:   .db $ff                     ; 3FFA6:  ff
b15_ffa7:   .db $ff                     ; 3FFA7:  ff
b15_ffa8:   .db $ff                     ; 3FFA8:  ff
b15_ffa9:   .db $ff                     ; 3FFA9:  ff
b15_ffaa:   .db $ff                     ; 3FFAA:  ff
b15_ffab:   .db $ff                     ; 3FFAB:  ff
b15_ffac:   .db $ff                     ; 3FFAC:  ff
b15_ffad:   .db $ff                     ; 3FFAD:  ff
b15_ffae:   .db $ff                     ; 3FFAE:  ff
b15_ffaf:   .db $ff                     ; 3FFAF:  ff
b15_ffb0:   .db $ff                     ; 3FFB0:  ff
b15_ffb1:   .db $ff                     ; 3FFB1:  ff
b15_ffb2:   .db $ff                     ; 3FFB2:  ff
b15_ffb3:   .db $ff                     ; 3FFB3:  ff
b15_ffb4:   .db $ff                     ; 3FFB4:  ff
b15_ffb5:   .db $ff                     ; 3FFB5:  ff
b15_ffb6:   .db $ff                     ; 3FFB6:  ff
b15_ffb7:   .db $ff                     ; 3FFB7:  ff
b15_ffb8:   .db $ff                     ; 3FFB8:  ff
b15_ffb9:   .db $ff                     ; 3FFB9:  ff
b15_ffba:   .db $ff                     ; 3FFBA:  ff
b15_ffbb:   .db $ff                     ; 3FFBB:  ff
b15_ffbc:   .db $ff                     ; 3FFBC:  ff
b15_ffbd:   .db $ff                     ; 3FFBD:  ff
b15_ffbe:   .db $ff                     ; 3FFBE:  ff
b15_ffbf:   .db $ff                     ; 3FFBF:  ff
b15_ffc0:   .db $ff                     ; 3FFC0:  ff
b15_ffc1:   .db $ff                     ; 3FFC1:  ff
b15_ffc2:   .db $ff                     ; 3FFC2:  ff
b15_ffc3:   .db $ff                     ; 3FFC3:  ff
b15_ffc4:   .db $ff                     ; 3FFC4:  ff
b15_ffc5:   .db $ff                     ; 3FFC5:  ff
b15_ffc6:   .db $ff                     ; 3FFC6:  ff
b15_ffc7:   .db $ff                     ; 3FFC7:  ff
b15_ffc8:   .db $ff                     ; 3FFC8:  ff
b15_ffc9:   .db $ff                     ; 3FFC9:  ff
b15_ffca:   .db $ff                     ; 3FFCA:  ff
b15_ffcb:   .db $ff                     ; 3FFCB:  ff
b15_ffcc:   .db $ff                     ; 3FFCC:  ff
b15_ffcd:   .db $ff                     ; 3FFCD:  ff
b15_ffce:   .db $ff                     ; 3FFCE:  ff
b15_ffcf:   .db $ff                     ; 3FFCF:  ff
b15_ffd0:   .db $ff                     ; 3FFD0:  ff
b15_ffd1:   .db $ff                     ; 3FFD1:  ff
b15_ffd2:   .db $ff                     ; 3FFD2:  ff
b15_ffd3:   .db $ff                     ; 3FFD3:  ff
b15_ffd4:   .db $ff                     ; 3FFD4:  ff
b15_ffd5:   .db $ff                     ; 3FFD5:  ff
b15_ffd6:   .db $ff                     ; 3FFD6:  ff
b15_ffd7:   .db $ff                     ; 3FFD7:  ff
b15_ffd8:   .db $ff                     ; 3FFD8:  ff
b15_ffd9:   .db $ff                     ; 3FFD9:  ff
b15_ffda:   .db $ff                     ; 3FFDA:  ff
b15_ffdb:   .db $ff                     ; 3FFDB:  ff
b15_ffdc:   .db $ff                     ; 3FFDC:  ff
b15_ffdd:   .db $ff                     ; 3FFDD:  ff
b15_ffde:   .db $ff                     ; 3FFDE:  ff
b15_ffdf:   .db $ff                     ; 3FFDF:  ff
b15_ffe0:   lsr $424f                   ; 3FFE0:  4e 4f 42
b15_ffe3:   eor $2d,x                   ; 3FFE3:  55 2d
b15_ffe5:   lsr $5345                   ; 3FFE5:  4e 45 53
b15_ffe8:   and ($30),y                 ; 3FFE8:  31 30
b15_ffea:   jsr $2020                   ; 3FFEA:  20 20 20
b15_ffed:   jsr $2020                   ; 3FFED:  20 20 20
b15_fff0:   .db $ff                     ; 3FFF0:  ff
b15_fff1:   .db $ff                     ; 3FFF1:  ff
b15_fff2:   .db $ff                     ; 3FFF2:  ff
b15_fff3:   .db $ff                     ; 3FFF3:  ff
b15_fff4:   .db $ff                     ; 3FFF4:  ff
b15_fff5:   .db $ff                     ; 3FFF5:  ff
b15_fff6:   .db $ff                     ; 3FFF6:  ff
b15_fff7:   ora #$ff                    ; 3FFF7:  09 ff
b15_fff9:   .db $ff                     ; 3FFF9:  ff
b15_fffa:   .db $da                     ; 3FFFA:  da
b15_fffb:   cpy #$00                    ; 3FFFB:  c0 00
b15_fffd:   cpy #$39                    ; 3FFFD:  c0 39
b15_ffff:   .db $c1                     ; 3FFFF:  c1