.base $8000

bank1_entry:   jmp $b89b                   ; 4000:  4c 9b b8
prompt_message_and_redraw:   jsr $e823                   ; 4003:  20 23 e8
b01_8006:   brk                         ; 4006:  00
b01_8007:   brk                         ; 4007:  00
b01_8008:   stx $ba10                   ; 4008:  8e 10 ba
b01_800b:   sbc #$26                    ; 400B:  e9 26
b01_800d:   .db $d3                     ; 400D:  d3
b01_800e:   .db vm_sp_lo                     ; 400E:  02
b01_800f:   .db $0c                     ; 400F:  0c
b01_8010:   sty $00ff                   ; 4010:  8c ff 00
b01_8013:   cpy #$d8                    ; 4013:  c0 d8
b01_8015:   and (skip_vblank_wait,x)                 ; 4015:  21 80
b01_8017:   stx $b9fd                   ; 4017:  8e fd b9
b01_801a:   sbc #$c4                    ; 401A:  e9 c4
b01_801c:   dec $d602                   ; 401C:  ce 02 d6
b01_801f:   .db $44                     ; 401F:  44
b01_8020:   .db skip_vblank_wait                     ; 4020:  80
b01_8021:   and $8c0d,x                 ; 4021:  3d 0d 8c
b01_8024:   txa                         ; 4024:  8a
b01_8025:   sbc $d8c0,y                 ; 4025:  f9 c0 d8
b01_8028:   bmi $7faa                   ; 4028:  30 80
b01_802a:   txa                         ; 402A:  8a
b01_802b:   ora ($ba),y                 ; 402B:  11 ba
b01_802d:   dec $33,x                   ; 402D:  d6 33
b01_802f:   .db skip_vblank_wait                     ; 402F:  80
b01_8030:   txa                         ; 4030:  8a
b01_8031:   sty $f9,x                   ; 4031:  94 f9
b01_8033:   .db $b3                     ; 4033:  b3
b01_8034:   .db $0c                     ; 4034:  0c
b01_8035:   cmp ($d2),y                 ; 4035:  d1 d2
b01_8037:   sty $f816                   ; 4037:  8c 16 f8
b01_803a:   .db $bb                     ; 403A:  bb
b01_803b:   bcs $7ff0                   ; 403B:  b0 b3
b01_803d:   stx $b9f6                   ; 403D:  8e f6 b9
b01_8040:   sbc #$34                    ; 4040:  e9 34
b01_8042:   cmp ($08),y                 ; 4042:  d1 08
b01_8044:   stx $ba12                   ; 4044:  8e 12 ba
b01_8047:   sbc #$c4                    ; 4047:  e9 c4
b01_8049:   dec $cf02                   ; 4049:  ce 02 cf
province_select_prompt:   jsr $e823                   ; 404C:  20 23 e8
b01_804f:   sed                         ; 404F:  f8
b01_8050:   .db $ff                     ; 4050:  ff
b01_8051:   ldy $cd                     ; 4051:  a4 cd
b01_8053:   .db $7f                     ; 4053:  7f
b01_8054:   and #$a4                    ; 4054:  29 a4
b01_8056:   .db $cf                     ; 4056:  cf
b01_8057:   .db $7f                     ; 4057:  7f
b01_8058:   plp                         ; 4058:  28
b01_8059:   sec                         ; 4059:  38
b01_805a:   and $7be9,y                 ; 405A:  39 e9 7b
b01_805d:   cpy $0c04                   ; 405D:  cc 04 0c
b01_8060:   .db $2b                     ; 4060:  2b
b01_8061:   tax                         ; 4061:  aa
b01_8062:   sta $616d,x                 ; 4062:  9d 6d 61
b01_8065:   sbc #$9d                    ; 4065:  e9 9d
b01_8067:   cmp vm_fp_lo,x                   ; 4067:  d5 04
b01_8069:   rol a                       ; 4069:  2a
b01_806a:   .db $d7                     ; 406A:  d7
b01_806b:   dey                         ; 406B:  88
b01_806c:   .db skip_vblank_wait                     ; 406C:  80
b01_806d:   rti                         ; 406D:  40
b01_806e:   .db $cf                     ; 406E:  cf
b01_806f:   asl a                       ; 406F:  0a
b01_8070:   cmp ($b3),y                 ; 4070:  d1 b3
b01_8072:   .db $0b                     ; 4072:  0b
b01_8073:   .db $d3                     ; 4073:  d3
b01_8074:   ldy $c0,x                   ; 4074:  b4 c0
b01_8076:   cld                         ; 4076:  d8
b01_8077:   sta skip_vblank_wait                     ; 4077:  85 80
b01_8079:   asl a                       ; 4079:  0a
b01_807a:   cmp ($b3),y                 ; 407A:  d1 b3
b01_807c:   sbc #$99                    ; 407C:  e9 99
b01_807e:   cmp $d702,y                 ; 407E:  d9 02 d7
b01_8081:   sta skip_vblank_wait                     ; 4081:  85 80
b01_8083:   asl a                       ; 4083:  0a
b01_8084:   .db $cf                     ; 4084:  cf
b01_8085:   .db $0b                     ; 4085:  0b
b01_8086:   bne $80b3                   ; 4086:  d0 2b
b01_8088:   .db $0b                     ; 4088:  0b
b01_8089:   .db $d3                     ; 4089:  d3
b01_808a:   sty $00ff                   ; 408A:  8c ff 00
b01_808d:   cmp ($d7,x)                 ; 408D:  c1 d7
b01_808f:   .db p2_buttons                     ; 408F:  6f
b01_8090:   .db skip_vblank_wait                     ; 4090:  80
b01_8091:   dec $59,x                   ; 4091:  d6 59
b01_8093:   .db skip_vblank_wait                     ; 4093:  80
draw_market_rates:   jsr $e823                   ; 4094:  20 23 e8
b01_8097:   inc $8dff,x                 ; 4097:  fe ff 8d
b01_809a:   .db $14                     ; 409A:  14
b01_809b:   sta $e914                   ; 409B:  8d 14 e9
b01_809e:   .db music_ptr_hi                     ; 409E:  7b
b01_809f:   cpy $8e04                   ; 409F:  cc 04 8e
b01_80a2:   .db $14                     ; 40A2:  14
b01_80a3:   tsx                         ; 40A3:  ba
b01_80a4:   sbc #$c4                    ; 40A4:  e9 c4
b01_80a6:   dec $8d02                   ; 40A6:  ce 02 8d
b01_80a9:   ora $8d,x                   ; 40A9:  15 8d
b01_80ab:   .db $14                     ; 40AB:  14
b01_80ac:   sbc #$7b                    ; 40AC:  e9 7b
b01_80ae:   cpy $a404                   ; 40AE:  cc 04 a4
b01_80b1:   .db $0b                     ; 40B1:  0b
b01_80b2:   ror $5a2b                   ; 40B2:  6e 2b 5a
b01_80b5:   lda $0bb3,y                 ; 40B5:  b9 b3 0b
b01_80b8:   .db $5a                     ; 40B8:  5a
b01_80b9:   ldx $b3,y                   ; 40B9:  b6 b3
b01_80bb:   stx $ba1f                   ; 40BB:  8e 1f ba
b01_80be:   sbc #$34                    ; 40BE:  e9 34
b01_80c0:   cmp (vm_ip_lo),y                 ; 40C0:  d1 06
b01_80c2:   sta $8d16                   ; 40C2:  8d 16 8d
b01_80c5:   .db $14                     ; 40C5:  14
b01_80c6:   sbc #$7b                    ; 40C6:  e9 7b
b01_80c8:   cpy $a404                   ; 40C8:  cc 04 a4
b01_80cb:   ora $2b6e                   ; 40CB:  0d 6e 2b
b01_80ce:   .db $5a                     ; 40CE:  5a
b01_80cf:   lda $0bb3,y                 ; 40CF:  b9 b3 0b
b01_80d2:   .db $5a                     ; 40D2:  5a
b01_80d3:   ldx $b3,y                   ; 40D3:  b6 b3
b01_80d5:   stx $ba2d                   ; 40D5:  8e 2d ba
b01_80d8:   sbc #$34                    ; 40D8:  e9 34
b01_80da:   cmp (vm_ip_lo),y                 ; 40DA:  d1 06
b01_80dc:   sta $8d17                   ; 40DC:  8d 17 8d
b01_80df:   .db $14                     ; 40DF:  14
b01_80e0:   sbc #$7b                    ; 40E0:  e9 7b
b01_80e2:   cpy $a404                   ; 40E2:  cc 04 a4
b01_80e5:   .db $0f                     ; 40E5:  0f
b01_80e6:   ror $5a2b                   ; 40E6:  6e 2b 5a
b01_80e9:   lda $0bb3,y                 ; 40E9:  b9 b3 0b
b01_80ec:   .db $5a                     ; 40EC:  5a
b01_80ed:   ldx $b3,y                   ; 40ED:  b6 b3
b01_80ef:   stx $ba3b                   ; 40EF:  8e 3b ba
b01_80f2:   sbc #$34                    ; 40F2:  e9 34
b01_80f4:   cmp (vm_ip_lo),y                 ; 40F4:  d1 06
b01_80f6:   sta $8d18                   ; 40F6:  8d 18 8d
b01_80f9:   .db $14                     ; 40F9:  14
b01_80fa:   sbc #$7b                    ; 40FA:  e9 7b
b01_80fc:   cpy $a404                   ; 40FC:  cc 04 a4
b01_80ff:   ora (p1_buttons),y                 ; 40FF:  11 6e
b01_8101:   .db $2b                     ; 4101:  2b
b01_8102:   .db $5a                     ; 4102:  5a
b01_8103:   lda $0bb3,y                 ; 4103:  b9 b3 0b
b01_8106:   .db $5a                     ; 4106:  5a
b01_8107:   ldx $b3,y                   ; 4107:  b6 b3
b01_8109:   stx $ba49                   ; 4109:  8e 49 ba
b01_810c:   sbc #$34                    ; 410C:  e9 34
b01_810e:   cmp (vm_ip_lo),y                 ; 410E:  d1 06
b01_8110:   sta $8d19                   ; 4110:  8d 19 8d
b01_8113:   .db $14                     ; 4113:  14
b01_8114:   sbc #$7b                    ; 4114:  e9 7b
b01_8116:   cpy $a404                   ; 4116:  cc 04 a4
b01_8119:   .db $13                     ; 4119:  13
b01_811a:   ror $5a2b                   ; 411A:  6e 2b 5a
b01_811d:   lda $0bb3,y                 ; 411D:  b9 b3 0b
b01_8120:   .db $5a                     ; 4120:  5a
b01_8121:   ldx $b3,y                   ; 4121:  b6 b3
b01_8123:   stx $ba57                   ; 4123:  8e 57 ba
b01_8126:   sbc #$34                    ; 4126:  e9 34
b01_8128:   cmp (vm_ip_lo),y                 ; 4128:  d1 06
b01_812a:   eor ($a8,x)                 ; 412A:  41 a8
b01_812c:   sbc $cf7b,y                 ; 412C:  f9 7b cf
target_eligible_by_cmd:   jsr $e823                   ; 412F:  20 23 e8
b01_8132:   inc $0cff,x                 ; 4132:  fe ff 0c
b01_8135:   cmp $0008,y                 ; 4135:  d9 08 00
b01_8138:   ora (scratch_ptr_lo,x)                 ; 4138:  01 00
b01_813a:   .db $5a                     ; 413A:  5a
b01_813b:   sta (vm_sp_lo,x)                 ; 413B:  81 02
b01_813d:   brk                         ; 413D:  00
b01_813e:   ror nmi_busy                     ; 413E:  66 81
b01_8140:   .db vm_fp_lo                     ; 4140:  04
b01_8141:   brk                         ; 4141:  00
b01_8142:   .db $5a                     ; 4142:  5a
b01_8143:   sta (vm_ip_lo,x)                 ; 4143:  81 06
b01_8145:   brk                         ; 4145:  00
b01_8146:   ror nmi_busy                     ; 4146:  66 81
b01_8148:   php                         ; 4148:  08
b01_8149:   brk                         ; 4149:  00
b01_814a:   ror nmi_busy                     ; 414A:  66 81
b01_814c:   .db $0f                     ; 414C:  0f
b01_814d:   brk                         ; 414D:  00
b01_814e:   ror nmi_busy                     ; 414E:  66 81
b01_8150:   .db $13                     ; 4150:  13
b01_8151:   brk                         ; 4151:  00
b01_8152:   .db $5a                     ; 4152:  5a
b01_8153:   sta ($ff,x)                 ; 4153:  81 ff
b01_8155:   brk                         ; 4155:  00
b01_8156:   ror nmi_busy                     ; 4156:  66 81
b01_8158:   .db $64                     ; 4158:  64
b01_8159:   sta ($3d,x)                 ; 4159:  81 3d
b01_815b:   sbc #$b7                    ; 415B:  e9 b7
b01_815d:   cmp $d602,y                 ; 415D:  d9 02 d6
b01_8160:   .db $63                     ; 4160:  63
b01_8161:   sta ($40,x)                 ; 4161:  81 40
b01_8163:   .db $2b                     ; 4163:  2b
b01_8164:   .db $0b                     ; 4164:  0b
b01_8165:   .db $cf                     ; 4165:  cf
b01_8166:   and $b7e9,x                 ; 4166:  3d e9 b7
b01_8169:   cmp $d702,y                 ; 4169:  d9 02 d7
b01_816c:   .db $62                     ; 416C:  62
b01_816d:   sta ($41,x)                 ; 416D:  81 41
b01_816f:   dec $63,x                   ; 416F:  d6 63
b01_8171:   sta ($20,x)                 ; 4171:  81 20
b01_8173:   .db $23                     ; 4173:  23
b01_8174:   inx                         ; 4174:  e8
b01_8175:   .db $fc                     ; 4175:  fc
b01_8176:   .db $ff                     ; 4176:  ff
b01_8177:   rti                         ; 4177:  40
b01_8178:   rol a                       ; 4178:  2a
b01_8179:   rti                         ; 4179:  40
b01_817a:   .db $2b                     ; 417A:  2b
b01_817b:   dec $ee,x                   ; 417B:  d6 ee
b01_817d:   sta ($0d,x)                 ; 417D:  81 0d
b01_817f:   cmp ($d3),y                 ; 417F:  d1 d3
b01_8181:   .db $b3                     ; 4181:  b3
b01_8182:   .db $3c                     ; 4182:  3c
b01_8183:   sbc #$2f                    ; 4183:  e9 2f
b01_8185:   sta (vm_fp_lo,x)                 ; 4185:  81 04
b01_8187:   cld                         ; 4187:  d8
b01_8188:   inc $0d81                   ; 4188:  ee 81 0d
b01_818b:   cmp ($d3),y                 ; 418B:  d1 d3
b01_818d:   sty province_ai_state                   ; 418D:  8c f7 6c
b01_8190:   .db $bb                     ; 4190:  bb
b01_8191:   .db $d3                     ; 4191:  d3
b01_8192:   sty $00ff                   ; 4192:  8c ff 00
b01_8195:   cmp ($d8,x)                 ; 4195:  c1 d8
b01_8197:   inc $0b81                   ; 4197:  ee 81 0b
b01_819a:   bne $81c7                   ; 419A:  d0 2b
b01_819c:   asl $eed8                   ; 419C:  0e d8 ee
b01_819f:   sta ($0d,x)                 ; 419F:  81 0d
b01_81a1:   cmp ($d3),y                 ; 41A1:  d1 d3
b01_81a3:   bne $8158                   ; 41A3:  d0 b3
b01_81a5:   stx $ba65                   ; 41A5:  8e 65 ba
b01_81a8:   sbc #$34                    ; 41A8:  e9 34
b01_81aa:   cmp (vm_fp_lo),y                 ; 41AA:  d1 04
b01_81ac:   asl a                       ; 41AC:  0a
b01_81ad:   bne $81d9                   ; 41AD:  d0 2a
b01_81af:   asl a                       ; 41AF:  0a
b01_81b0:   .db $8b                     ; 41B0:  8b
b01_81b1:   .db $12                     ; 41B1:  12
b01_81b2:   cmp ($d8,x)                 ; 41B2:  c1 d8
b01_81b4:   .db $c7                     ; 41B4:  c7
b01_81b5:   sta ($0a,x)                 ; 41B5:  81 0a
b01_81b7:   lsr $ba,x                   ; 41B7:  56 ba
b01_81b9:   .db $d7                     ; 41B9:  d7
b01_81ba:   cpy #$81                    ; 41BA:  c0 81
b01_81bc:   lsr a                       ; 41BC:  4a
b01_81bd:   dec $c2,x                   ; 41BD:  d6 c2
b01_81bf:   sta (skip_wallclock,x)                 ; 41BF:  81 89
b01_81c1:   jsr $e9b3                   ; 41C1:  20 b3 e9
b01_81c4:   sta ($ce,x)                 ; 41C4:  81 ce
b01_81c6:   .db vm_sp_lo                     ; 41C6:  02
b01_81c7:   asl a                       ; 41C7:  0a
b01_81c8:   .db $8b                     ; 41C8:  8b
b01_81c9:   .db $12                     ; 41C9:  12
b01_81ca:   cpy #$d8                    ; 41CA:  c0 d8
b01_81cc:   inc $0d81                   ; 41CC:  ee 81 0d
b01_81cf:   .db $d3                     ; 41CF:  d3
b01_81d0:   sty $00ff                   ; 41D0:  8c ff 00
b01_81d3:   cmp ($d8,x)                 ; 41D3:  c1 d8
b01_81d5:   inc $ac81                   ; 41D5:  ee 81 ac
b01_81d8:   ora #$d6                    ; 41D8:  09 d6
b01_81da:   .db $52                     ; 41DA:  52
b01_81db:   cpy #$d8                    ; 41DB:  c0 d8
b01_81dd:   cpx nmi_busy                     ; 41DD:  e4 81
b01_81df:   rti                         ; 41DF:  40
b01_81e0:   .db $2b                     ; 41E0:  2b
b01_81e1:   dec $fa,x                   ; 41E1:  d6 fa
b01_81e3:   sta ($8e,x)                 ; 41E3:  81 8e
b01_81e5:   adc #$ba                    ; 41E5:  69 ba
b01_81e7:   .db $3c                     ; 41E7:  3c
b01_81e8:   sbc #$03                    ; 41E8:  e9 03
b01_81ea:   .db skip_vblank_wait                     ; 41EA:  80
b01_81eb:   .db vm_fp_lo                     ; 41EB:  04
b01_81ec:   rti                         ; 41EC:  40
b01_81ed:   rol a                       ; 41ED:  2a
b01_81ee:   ora $2dd0                   ; 41EE:  0d d0 2d
b01_81f1:   cmp ($d3),y                 ; 41F1:  d1 d3
b01_81f3:   sty $00ff                   ; 41F3:  8c ff 00
b01_81f6:   cmp ($d7,x)                 ; 41F6:  c1 d7
b01_81f8:   ror $0b81,x                 ; 41F8:  7e 81 0b
b01_81fb:   .db $cf                     ; 41FB:  cf
effect_war_a:   jsr $e823                   ; 41FC:  20 23 e8
b01_81ff:   .db $fc                     ; 41FF:  fc
b01_8200:   .db $ff                     ; 4200:  ff
b01_8201:   ldy $5f                     ; 4201:  a4 5f
b01_8203:   .db p2_buttons                     ; 4203:  6f
b01_8204:   ldx $63                     ; 4204:  a6 63
b01_8206:   .db p2_buttons                     ; 4206:  6f
b01_8207:   dec $d8                     ; 4207:  c6 d8
b01_8209:   .db $17                     ; 4209:  17
b01_820a:   .db $82                     ; 420A:  82
b01_820b:   ldy $5f                     ; 420B:  a4 5f
b01_820d:   .db p2_buttons                     ; 420D:  6f
b01_820e:   .db $8b                     ; 420E:  8b
b01_820f:   rol $b5,x                   ; 420F:  36 b5
b01_8211:   ldx $63                     ; 4211:  a6 63
b01_8213:   .db p2_buttons                     ; 4213:  6f
b01_8214:   dec $20,x                   ; 4214:  d6 20
b01_8216:   .db $82                     ; 4216:  82
b01_8217:   ldy $63                     ; 4217:  a4 63
b01_8219:   .db p2_buttons                     ; 4219:  6f
b01_821a:   .db $8b                     ; 421A:  8b
b01_821b:   rol $b5,x                   ; 421B:  36 b5
b01_821d:   ldx $5f                     ; 421D:  a6 5f
b01_821f:   .db p2_buttons                     ; 421F:  6f
b01_8220:   .db $bb                     ; 4220:  bb
b01_8221:   sty relations_matrix                   ; 4221:  8c 93 61
b01_8224:   .db $bb                     ; 4224:  bb
b01_8225:   .db $b3                     ; 4225:  b3
b01_8226:   rti                         ; 4226:  40
b01_8227:   .db $d4                     ; 4227:  d4
b01_8228:   ldy $d77e                   ; 4228:  ac 7e d7
b01_822b:   .db $2b                     ; 422B:  2b
b01_822c:   tax                         ; 422C:  aa
b01_822d:   .db $63                     ; 422D:  63
b01_822e:   .db p2_buttons                     ; 422E:  6f
b01_822f:   sbc #$72                    ; 422F:  e9 72
b01_8231:   .db $d7                     ; 4231:  d7
b01_8232:   .db vm_sp_lo                     ; 4232:  02
b01_8233:   rol a                       ; 4233:  2a
b01_8234:   .db $0b                     ; 4234:  0b
b01_8235:   .db $1a                     ; 4235:  1a
b01_8236:   dec $d8                     ; 4236:  c6 d8
b01_8238:   .db $42                     ; 4238:  42
b01_8239:   .db $82                     ; 4239:  82
b01_823a:   asl a                       ; 423A:  0a
b01_823b:   .db $8b                     ; 423B:  8b
b01_823c:   rol $b5,x                   ; 423C:  36 b5
b01_823e:   .db $1b                     ; 423E:  1b
b01_823f:   dec $47,x                   ; 423F:  d6 47
b01_8241:   .db $82                     ; 4241:  82
b01_8242:   .db $0b                     ; 4242:  0b
b01_8243:   .db $8b                     ; 4243:  8b
b01_8244:   rol $b5,x                   ; 4244:  36 b5
b01_8246:   .db $1a                     ; 4246:  1a
b01_8247:   .db $bb                     ; 4247:  bb
b01_8248:   sty relations_matrix                   ; 4248:  8c 93 61
b01_824b:   .db $bb                     ; 424B:  bb
b01_824c:   .db $b3                     ; 424C:  b3
b01_824d:   rti                         ; 424D:  40
b01_824e:   .db $d4                     ; 424E:  d4
b01_824f:   .db $cf                     ; 424F:  cf
relations_matrix_get:   jsr $e823                   ; 4250:  20 23 e8
b01_8253:   brk                         ; 4253:  00
b01_8254:   brk                         ; 4254:  00
b01_8255:   .db $0c                     ; 4255:  0c
b01_8256:   ora $1ec6,x                 ; 4256:  1d c6 1e
b01_8259:   .db $dc                     ; 4259:  dc
b01_825a:   cld                         ; 425A:  d8
b01_825b:   adc $82                     ; 425B:  65 82
b01_825d:   .db $0c                     ; 425D:  0c
b01_825e:   .db $8b                     ; 425E:  8b
b01_825f:   rol $b5,x                   ; 425F:  36 b5
b01_8261:   ora $6ad6,x                 ; 4261:  1d d6 6a
b01_8264:   .db $82                     ; 4264:  82
b01_8265:   ora $368b                   ; 4265:  0d 8b 36
b01_8268:   lda ppu_queue_a_lo,x                   ; 4268:  b5 1c
b01_826a:   .db $bb                     ; 426A:  bb
b01_826b:   sty relations_matrix                   ; 426B:  8c 93 61
b01_826e:   .db $bb                     ; 426E:  bb
b01_826f:   .db $d3                     ; 426F:  d3
b01_8270:   .db $cf                     ; 4270:  cf
relations_rng_predicate:   jsr $e823                   ; 4271:  20 23 e8
b01_8274:   brk                         ; 4274:  00
b01_8275:   brk                         ; 4275:  00
b01_8276:   adc ($3d,x)                 ; 4276:  61 3d
b01_8278:   sbc #$72                    ; 4278:  e9 72
b01_827a:   .db $d7                     ; 427A:  d7
b01_827b:   .db vm_sp_lo                     ; 427B:  02
b01_827c:   .db $b3                     ; 427C:  b3
b01_827d:   .db $3c                     ; 427D:  3c
b01_827e:   sbc #$72                    ; 427E:  e9 72
b01_8280:   .db $d7                     ; 4280:  d7
b01_8281:   .db vm_sp_lo                     ; 4281:  02
b01_8282:   .db $b3                     ; 4282:  b3
b01_8283:   sbc #$50                    ; 4283:  e9 50
b01_8285:   .db $82                     ; 4285:  82
b01_8286:   asl $b3                     ; 4286:  06 b3
b01_8288:   sta $e964                   ; 4288:  8d 64 e9
b01_828b:   .db $52                     ; 428B:  52
b01_828c:   dex                         ; 428C:  ca
b01_828d:   .db vm_sp_lo                     ; 428D:  02
b01_828e:   ldy $c6,x                   ; 428E:  b4 c6
b01_8290:   .db $d7                     ; 4290:  d7
b01_8291:   tax                         ; 4291:  aa
b01_8292:   .db $82                     ; 4292:  82
b01_8293:   rts                         ; 4293:  60
b01_8294:   and $e93c,x                 ; 4294:  3d 3c e9
b01_8297:   bvc $821b                   ; 4297:  50 82
b01_8299:   asl $b3                     ; 4299:  06 b3
b01_829b:   sta $e964                   ; 429B:  8d 64 e9
b01_829e:   .db $52                     ; 429E:  52
b01_829f:   dex                         ; 429F:  ca
b01_82a0:   .db vm_sp_lo                     ; 42A0:  02
b01_82a1:   ldy $c6,x                   ; 42A1:  b4 c6
b01_82a3:   .db $d7                     ; 42A3:  d7
b01_82a4:   tax                         ; 42A4:  aa
b01_82a5:   .db $82                     ; 42A5:  82
b01_82a6:   rti                         ; 42A6:  40
b01_82a7:   dec $ab,x                   ; 42A7:  d6 ab
b01_82a9:   .db $82                     ; 42A9:  82
b01_82aa:   eor ($cf,x)                 ; 42AA:  41 cf
clamp_amount_to_province_max:   jsr $e823                   ; 42AC:  20 23 e8
b01_82af:   brk                         ; 42AF:  00
b01_82b0:   brk                         ; 42B0:  00
b01_82b1:   .db $3c                     ; 42B1:  3c
b01_82b2:   .db $0c                     ; 42B2:  0c
b01_82b3:   bcs $8268                   ; 42B3:  b0 b3
b01_82b5:   ldy $5f                     ; 42B5:  a4 5f
b01_82b7:   .db p2_buttons                     ; 42B7:  6f
b01_82b8:   .db $8b                     ; 42B8:  8b
b01_82b9:   .db $1a                     ; 42B9:  1a
b01_82ba:   lda $8c,x                   ; 42BA:  b5 8c
b01_82bc:   ora $bb70,y                 ; 42BC:  19 70 bb
b01_82bf:   bcs $8274                   ; 42BF:  b0 b3
b01_82c1:   sbc #$5e                    ; 42C1:  e9 5e
b01_82c3:   .db $cb                     ; 42C3:  cb
b01_82c4:   .db vm_fp_lo                     ; 42C4:  04
b01_82c5:   lda ($3c),y                 ; 42C5:  b1 3c
b01_82c7:   .db $0c                     ; 42C7:  0c
b01_82c8:   bcs $831a                   ; 42C8:  b0 50
b01_82ca:   .db $c2                     ; 42CA:  c2
b01_82cb:   cld                         ; 42CB:  d8
b01_82cc:   .db $d2                     ; 42CC:  d2
b01_82cd:   .db $82                     ; 42CD:  82
b01_82ce:   rti                         ; 42CE:  40
b01_82cf:   dec $d4,x                   ; 42CF:  d6 d4
b01_82d1:   .db $82                     ; 42D1:  82
b01_82d2:   .db $0c                     ; 42D2:  0c
b01_82d3:   bcs $8286                   ; 42D3:  b0 b1
b01_82d5:   .db $cf                     ; 42D5:  cf
effect_tax:   jsr $e823                   ; 42D6:  20 23 e8
b01_82d9:   .db $fc                     ; 42D9:  fc
b01_82da:   .db $ff                     ; 42DA:  ff
b01_82db:   ora $c250                   ; 42DB:  0d 50 c2
b01_82de:   .db $2b                     ; 42DE:  2b
b01_82df:   cld                         ; 42DF:  d8
b01_82e0:   nop                         ; 42E0:  ea
b01_82e1:   .db $82                     ; 42E1:  82
b01_82e2:   and $4ce9,x                 ; 42E2:  3d e9 4c
b01_82e5:   .db $cb                     ; 42E5:  cb
b01_82e6:   .db vm_sp_lo                     ; 42E6:  02
b01_82e7:   dec $eb,x                   ; 42E7:  d6 eb
b01_82e9:   .db $82                     ; 42E9:  82
b01_82ea:   ora $3cb3                   ; 42EA:  0d b3 3c
b01_82ed:   sbc #$0d                    ; 42ED:  e9 0d
b01_82ef:   .db $d7                     ; 42EF:  d7
b01_82f0:   .db vm_fp_lo                     ; 42F0:  04
b01_82f1:   rol a                       ; 42F1:  2a
b01_82f2:   .db $0b                     ; 42F2:  0b
b01_82f3:   cld                         ; 42F3:  d8
b01_82f4:   .db $fc                     ; 42F4:  fc
b01_82f5:   .db $82                     ; 42F5:  82
b01_82f6:   .db $0c                     ; 42F6:  0c
b01_82f7:   .db $1a                     ; 42F7:  1a
b01_82f8:   ldy $00d6,x                 ; 42F8:  bc d6 00
b01_82fb:   .db clock_a_hi                     ; 42FB:  83
b01_82fc:   .db $0c                     ; 42FC:  0c
b01_82fd:   cmp $bb0a                   ; 42FD:  cd 0a bb
b01_8300:   rol a                       ; 4300:  2a
b01_8301:   asl a                       ; 4301:  0a
b01_8302:   .db $cf                     ; 4302:  cf
math32_muladddiv:   jsr $e823                   ; 4303:  20 23 e8
b01_8306:   brk                         ; 4306:  00
b01_8307:   brk                         ; 4307:  00
b01_8308:   ora $25b7                   ; 4308:  0d b7 25
b01_830b:   .db $b7                     ; 430B:  b7
b01_830c:   .db $14                     ; 430C:  14
b01_830d:   .db $0c                     ; 430D:  0c
b01_830e:   .db $b7                     ; 430E:  b7
b01_830f:   and $b7                     ; 430F:  25 b7
b01_8311:   ora $b7,x                   ; 4311:  15 b7
b01_8313:   ora ($b7,x)                 ; 4313:  01 b7
b01_8315:   ora $0009,y                 ; 4315:  19 09 00
b01_8318:   brk                         ; 4318:  00
b01_8319:   brk                         ; 4319:  00
b01_831a:   .db $b7                     ; 431A:  b7
b01_831b:   .db vm_sp_hi                     ; 431B:  03
b01_831c:   .db $b7                     ; 431C:  b7
b01_831d:   ora $000a,y                 ; 431D:  19 0a 00
b01_8320:   brk                         ; 4320:  00
b01_8321:   brk                         ; 4321:  00
b01_8322:   .db $b7                     ; 4322:  b7
b01_8323:   .db vm_sp_lo                     ; 4323:  02
b01_8324:   .db $b7                     ; 4324:  b7
b01_8325:   .db $27                     ; 4325:  27
b01_8326:   .db $cf                     ; 4326:  cf
scale_div10_capcheck:   jsr $e823                   ; 4327:  20 23 e8
b01_832a:   brk                         ; 432A:  00
b01_832b:   brk                         ; 432B:  00
b01_832c:   and $e93c,x                 ; 432C:  3d 3c e9
b01_832f:   .db vm_sp_hi                     ; 432F:  03
b01_8330:   .db clock_a_hi                     ; 4330:  83
b01_8331:   .db vm_fp_lo                     ; 4331:  04
b01_8332:   asl $d8c4,x                 ; 4332:  1e c4 d8
b01_8335:   rti                         ; 4335:  40
b01_8336:   .db clock_a_hi                     ; 4336:  83
b01_8337:   .db $b7                     ; 4337:  b7
b01_8338:   clc                         ; 4338:  18
b01_8339:   .db $ff                     ; 4339:  ff
b01_833a:   .db $ff                     ; 433A:  ff
b01_833b:   .db $ff                     ; 433B:  ff
b01_833c:   .db $ff                     ; 433C:  ff
b01_833d:   dec $54,x                   ; 433D:  d6 54
b01_833f:   .db clock_a_hi                     ; 433F:  83
b01_8340:   ora $25b7                   ; 4340:  0d b7 25
b01_8343:   .db $b7                     ; 4343:  b7
b01_8344:   .db $14                     ; 4344:  14
b01_8345:   .db $0c                     ; 4345:  0c
b01_8346:   .db $b7                     ; 4346:  b7
b01_8347:   and $b7                     ; 4347:  25 b7
b01_8349:   ora $b7,x                   ; 4349:  15 b7
b01_834b:   ora ($b7,x)                 ; 434B:  01 b7
b01_834d:   ora $000a,y                 ; 434D:  19 0a 00
b01_8350:   brk                         ; 4350:  00
b01_8351:   brk                         ; 4351:  00
b01_8352:   .db $b7                     ; 4352:  b7
b01_8353:   .db vm_sp_lo                     ; 4353:  02
b01_8354:   .db $b7                     ; 4354:  b7
b01_8355:   .db $27                     ; 4355:  27
b01_8356:   .db $cf                     ; 4356:  cf
ratio_times10_capped:   jsr $e823                   ; 4357:  20 23 e8
b01_835a:   brk                         ; 435A:  00
b01_835b:   brk                         ; 435B:  00
b01_835c:   rol $b70d,x                 ; 435C:  3e 0d b7
b01_835f:   and $b7                     ; 435F:  25 b7
b01_8361:   .db $14                     ; 4361:  14
b01_8362:   .db $0c                     ; 4362:  0c
b01_8363:   .db $b7                     ; 4363:  b7
b01_8364:   and $b7                     ; 4364:  25 b7
b01_8366:   ora $000a,y                 ; 4366:  19 0a 00
b01_8369:   brk                         ; 4369:  00
b01_836a:   brk                         ; 436A:  00
b01_836b:   .db $b7                     ; 436B:  b7
b01_836c:   ora ($b7,x)                 ; 436C:  01 b7
b01_836e:   ora $b7,x                   ; 436E:  15 b7
b01_8370:   .db vm_sp_lo                     ; 4370:  02
b01_8371:   .db $b7                     ; 4371:  b7
b01_8372:   .db $27                     ; 4372:  27
b01_8373:   .db $b3                     ; 4373:  b3
b01_8374:   sbc #$5e                    ; 4374:  e9 5e
b01_8376:   .db $cb                     ; 4376:  cb
b01_8377:   .db vm_fp_lo                     ; 4377:  04
b01_8378:   .db $cf                     ; 4378:  cf
apply_two_grows_const1_override:   jsr $e823                   ; 4379:  20 23 e8
b01_837c:   inc $a4ff,x                 ; 437C:  fe ff a4
b01_837f:   .db $63                     ; 437F:  63
b01_8380:   adc $412b                   ; 4380:  6d 2b 41
b01_8383:   tay                         ; 4383:  a8
b01_8384:   .db $63                     ; 4384:  63
b01_8385:   adc $3c3d                   ; 4385:  6d 3d 3c
b01_8388:   sbc #$40                    ; 4388:  e9 40
b01_838a:   cmp $3d04,y                 ; 438A:  d9 04 3d
b01_838d:   .db $0c                     ; 438D:  0c
b01_838e:   ldy $b3,x                   ; 438E:  b4 b3
b01_8390:   bcs $834e                   ; 4390:  b0 bc
b01_8392:   lda ($0c),y                 ; 4392:  b1 0c
b01_8394:   bcs $83e6                   ; 4394:  b0 50
b01_8396:   .db $c2                     ; 4396:  c2
b01_8397:   cld                         ; 4397:  d8
b01_8398:   sta $3c83,x                 ; 4398:  9d 83 3c
b01_839b:   rti                         ; 439B:  40
b01_839c:   lda ($0b),y                 ; 439C:  b1 0b
b01_839e:   tay                         ; 439E:  a8
b01_839f:   .db $63                     ; 439F:  63
b01_83a0:   adc $20cf                   ; 43A0:  6d cf 20
b01_83a3:   .db $23                     ; 43A3:  23
b01_83a4:   inx                         ; 43A4:  e8
b01_83a5:   brk                         ; 43A5:  00
b01_83a6:   brk                         ; 43A6:  00
b01_83a7:   .db $0c                     ; 43A7:  0c
b01_83a8:   sty province_ai_state                   ; 43A8:  8c f7 6c
b01_83ab:   .db $bb                     ; 43AB:  bb
b01_83ac:   .db $d3                     ; 43AC:  d3
b01_83ad:   sty $00ff                   ; 43AD:  8c ff 00
b01_83b0:   cmp ($d8,x)                 ; 43B0:  c1 d8
b01_83b2:   .db $bf                     ; 43B2:  bf
b01_83b3:   .db clock_a_hi                     ; 43B3:  83
b01_83b4:   and $6b8e,x                 ; 43B4:  3d 8e 6b
b01_83b7:   tsx                         ; 43B7:  ba
b01_83b8:   sbc #$34                    ; 43B8:  e9 34
b01_83ba:   cmp (vm_fp_lo),y                 ; 43BA:  d1 04
b01_83bc:   dec $c6,x                   ; 43BC:  d6 c6
b01_83be:   .db clock_a_hi                     ; 43BE:  83
b01_83bf:   stx $ba6f                   ; 43BF:  8e 6f ba
b01_83c2:   sbc #$c4                    ; 43C2:  e9 c4
b01_83c4:   dec $cf02                   ; 43C4:  ce 02 cf
draw_selected_province_stat:   jsr $e823                   ; 43C7:  20 23 e8
b01_83ca:   brk                         ; 43CA:  00
b01_83cb:   brk                         ; 43CB:  00
b01_83cc:   .db $3c                     ; 43CC:  3c
b01_83cd:   tax                         ; 43CD:  aa
b01_83ce:   .db $5f                     ; 43CE:  5f
b01_83cf:   .db p2_buttons                     ; 43CF:  6f
b01_83d0:   sbc #$a2                    ; 43D0:  e9 a2
b01_83d2:   .db clock_a_hi                     ; 43D2:  83
b01_83d3:   .db vm_fp_lo                     ; 43D3:  04
b01_83d4:   .db $cf                     ; 43D4:  cf
draw_province_stat3_or_dashes:   jsr $e823                   ; 43D5:  20 23 e8
b01_83d8:   brk                         ; 43D8:  00
b01_83d9:   brk                         ; 43D9:  00
b01_83da:   .db $0c                     ; 43DA:  0c
b01_83db:   sty province_ai_state                   ; 43DB:  8c f7 6c
b01_83de:   .db $bb                     ; 43DE:  bb
b01_83df:   .db $d3                     ; 43DF:  d3
b01_83e0:   sty $00ff                   ; 43E0:  8c ff 00
b01_83e3:   cmp ($d8,x)                 ; 43E3:  c1 d8
b01_83e5:   .db $f2                     ; 43E5:  f2
b01_83e6:   .db clock_a_hi                     ; 43E6:  83
b01_83e7:   and $748e,x                 ; 43E7:  3d 8e 74
b01_83ea:   tsx                         ; 43EA:  ba
b01_83eb:   sbc #$34                    ; 43EB:  e9 34
b01_83ed:   cmp (vm_fp_lo),y                 ; 43ED:  d1 04
b01_83ef:   dec $f9,x                   ; 43EF:  d6 f9
b01_83f1:   .db clock_a_hi                     ; 43F1:  83
b01_83f2:   stx $ba78                   ; 43F2:  8e 78 ba
b01_83f5:   sbc #$c4                    ; 43F5:  e9 c4
b01_83f7:   dec $cf02                   ; 43F7:  ce 02 cf
effect_view_a:   jsr $e823                   ; 43FA:  20 23 e8
b01_83fd:   .db $f4                     ; 43FD:  f4
b01_83fe:   .db $ff                     ; 43FE:  ff
b01_83ff:   ldy $cd20                   ; 43FF:  ac 20 cd
b01_8402:   adc ($e9,x)                 ; 4402:  61 e9
b01_8404:   and $cc,x                   ; 4404:  35 cc
b01_8406:   .db vm_sp_lo                     ; 4406:  02
b01_8407:   sta $6723                   ; 4407:  8d 23 67
b01_840a:   sbc #$8b                    ; 440A:  e9 8b
b01_840c:   .db $cf                     ; 440C:  cf
b01_840d:   .db vm_fp_lo                     ; 440D:  04
b01_840e:   sta $6b25                   ; 440E:  8d 25 6b
b01_8411:   sbc #$8b                    ; 4411:  e9 8b
b01_8413:   .db $cf                     ; 4413:  cf
b01_8414:   .db vm_fp_lo                     ; 4414:  04
b01_8415:   sta $6f2b                   ; 4415:  8d 2b 6f
b01_8418:   sbc #$8b                    ; 4418:  e9 8b
b01_841a:   .db $cf                     ; 441A:  cf
b01_841b:   .db vm_fp_lo                     ; 441B:  04
b01_841c:   .db $62                     ; 441C:  62
b01_841d:   .db $6b                     ; 441D:  6b
b01_841e:   ror $6b                     ; 441E:  66 6b
b01_8420:   .db $62                     ; 4420:  62
b01_8421:   sbc #$6a                    ; 4421:  e9 6a
b01_8423:   .db $cf                     ; 4423:  cf
b01_8424:   asl a                       ; 4424:  0a
b01_8425:   .db $63                     ; 4425:  63
b01_8426:   sta $6412                   ; 4426:  8d 12 64
b01_8429:   adc $e962                   ; 4429:  6d 62 e9
b01_842c:   ror a                       ; 442C:  6a
b01_842d:   .db $cf                     ; 442D:  cf
b01_842e:   asl a                       ; 442E:  0a
b01_842f:   .db $63                     ; 442F:  63
b01_8430:   adc $8d                     ; 4430:  65 8d
b01_8432:   .db $13                     ; 4432:  13
b01_8433:   .db $64                     ; 4433:  64
b01_8434:   ror a                       ; 4434:  6a
b01_8435:   sbc #$6a                    ; 4435:  e9 6a
b01_8437:   .db $cf                     ; 4437:  cf
b01_8438:   asl a                       ; 4438:  0a
b01_8439:   adc ($8d,x)                 ; 4439:  61 8d
b01_843b:   .db $12                     ; 443B:  12
b01_843c:   ror $6a67                   ; 443C:  6e 67 6a
b01_843f:   sbc #$6a                    ; 443F:  e9 6a
b01_8441:   .db $cf                     ; 4441:  cf
b01_8442:   asl a                       ; 4442:  0a
b01_8443:   .db $62                     ; 4443:  62
b01_8444:   .db $64                     ; 4444:  64
b01_8445:   sta $641d                   ; 4445:  8d 1d 64
b01_8448:   sta $e916                   ; 4448:  8d 16 e9
b01_844b:   ror a                       ; 444B:  6a
b01_844c:   .db $cf                     ; 444C:  cf
b01_844d:   asl a                       ; 444D:  0a
b01_844e:   .db $62                     ; 444E:  62
b01_844f:   sta $8d12                   ; 444F:  8d 12 8d
b01_8452:   .db $17                     ; 4452:  17
b01_8453:   ror $8d                     ; 4453:  66 8d
b01_8455:   .db $17                     ; 4455:  17
b01_8456:   sbc #$6a                    ; 4456:  e9 6a
b01_8458:   .db $cf                     ; 4458:  cf
b01_8459:   asl a                       ; 4459:  0a
b01_845a:   eor ($a8,x)                 ; 445A:  41 a8
b01_845c:   cmp #$7f                    ; 445C:  c9 7f
b01_845e:   .db $63                     ; 445E:  63
b01_845f:   .db $62                     ; 445F:  62
b01_8460:   sbc #$7b                    ; 4460:  e9 7b
b01_8462:   cpy $ac04                   ; 4462:  cc 04 ac
b01_8465:   .db $77                     ; 4465:  77
b01_8466:   dec $63,x                   ; 4466:  d6 63
b01_8468:   .db brk_scratch_hi                     ; 4468:  67
b01_8469:   sbc #$7b                    ; 4469:  e9 7b
b01_846b:   cpy $ac04                   ; 446B:  cc 04 ac
b01_846e:   .db $87                     ; 446E:  87
b01_846f:   dec $3c,x                   ; 446F:  d6 3c
b01_8471:   sbc #$36                    ; 4471:  e9 36
b01_8473:   cld                         ; 4473:  d8
b01_8474:   .db vm_sp_lo                     ; 4474:  02
b01_8475:   adc $6a                     ; 4475:  65 6a
b01_8477:   sbc #$7b                    ; 4477:  e9 7b
b01_8479:   cpy $3c04                   ; 4479:  cc 04 3c
b01_847c:   sbc #$99                    ; 447C:  e9 99
b01_847e:   cmp $d802,y                 ; 447E:  d9 02 d8
b01_8481:   .db $87                     ; 4481:  87
b01_8482:   sty $40                     ; 4482:  84 40
b01_8484:   dec $88,x                   ; 4484:  d6 88
b01_8486:   sty $41                     ; 4486:  84 41
b01_8488:   plp                         ; 4488:  28
b01_8489:   cld                         ; 4489:  d8
b01_848a:   .db $c3                     ; 448A:  c3
b01_848b:   sty $0c                     ; 448B:  84 0c
b01_848d:   sty fief_is_daimyo_capital                   ; 448D:  8c a2 6d
b01_8490:   .db $bb                     ; 4490:  bb
b01_8491:   .db $d3                     ; 4491:  d3
b01_8492:   rol $3c                     ; 4492:  26 3c
b01_8494:   sbc #$8d                    ; 4494:  e9 8d
b01_8496:   cmp $d802,y                 ; 4496:  d9 02 d8
b01_8499:   lda $0684,y                 ; 4499:  b9 84 06
b01_849c:   cld                         ; 449C:  d8
b01_849d:   .db $a3                     ; 449D:  a3
b01_849e:   sty $40                     ; 449E:  84 40
b01_84a0:   dec $a9,x                   ; 44A0:  d6 a9
b01_84a2:   sty $0c                     ; 44A2:  84 0c
b01_84a4:   sty province_ai_state                   ; 44A4:  8c f7 6c
b01_84a7:   .db $bb                     ; 44A7:  bb
b01_84a8:   .db $d3                     ; 44A8:  d3
b01_84a9:   .db $d2                     ; 44A9:  d2
b01_84aa:   sty $f7d4                   ; 44AA:  8c d4 f7
b01_84ad:   .db $bb                     ; 44AD:  bb
b01_84ae:   bcs $8486                   ; 44AE:  b0 d6
b01_84b0:   lda clock_a_lo,x                   ; 44B0:  b5 84
b01_84b2:   txa                         ; 44B2:  8a
b01_84b3:   .db $7c                     ; 44B3:  7c
b01_84b4:   tsx                         ; 44B4:  ba
b01_84b5:   .db $b3                     ; 44B5:  b3
b01_84b6:   dec $c6,x                   ; 44B6:  d6 c6
b01_84b8:   sty vm_ip_lo                     ; 44B8:  84 06
b01_84ba:   .db $d7                     ; 44BA:  d7
b01_84bb:   .db $b2                     ; 44BB:  b2
b01_84bc:   sty $8a                     ; 44BC:  84 8a
b01_84be:   stx $ba                     ; 44BE:  86 ba
b01_84c0:   dec $b5,x                   ; 44C0:  d6 b5
b01_84c2:   sty $8e                     ; 44C2:  84 8e
b01_84c4:   sta $e9ba                   ; 44C4:  8d ba e9
b01_84c7:   cpy $ce                     ; 44C7:  c4 ce
b01_84c9:   .db vm_sp_lo                     ; 44C9:  02
b01_84ca:   .db $63                     ; 44CA:  63
b01_84cb:   ror $7be9                   ; 44CB:  6e e9 7b
b01_84ce:   cpy $0c04                   ; 44CE:  cc 04 0c
b01_84d1:   bne $8486                   ; 44D1:  d0 b3
b01_84d3:   stx $ba93                   ; 44D3:  8e 93 ba
b01_84d6:   sbc #$34                    ; 44D6:  e9 34
b01_84d8:   cmp (vm_fp_lo),y                 ; 44D8:  d1 04
b01_84da:   .db $63                     ; 44DA:  63
b01_84db:   sta $e916                   ; 44DB:  8d 16 e9
b01_84de:   .db music_ptr_hi                     ; 44DE:  7b
b01_84df:   cpy $3c04                   ; 44DF:  cc 04 3c
b01_84e2:   sbc #$d3                    ; 44E2:  e9 d3
b01_84e4:   cmp $6402,y                 ; 44E4:  d9 02 64
b01_84e7:   ror a                       ; 44E7:  6a
b01_84e8:   sbc #$7b                    ; 44E8:  e9 7b
b01_84ea:   cpy $0804                   ; 44EA:  cc 04 08
b01_84ed:   cld                         ; 44ED:  d8
b01_84ee:   sed                         ; 44EE:  f8
b01_84ef:   sty $3c                     ; 44EF:  84 3c
b01_84f1:   sbc #$4b                    ; 44F1:  e9 4b
b01_84f3:   .db $db                     ; 44F3:  db
b01_84f4:   .db vm_sp_lo                     ; 44F4:  02
b01_84f5:   dec $ff,x                   ; 44F5:  d6 ff
b01_84f7:   sty $8e                     ; 44F7:  84 8e
b01_84f9:   .db $9c                     ; 44F9:  9c
b01_84fa:   tsx                         ; 44FA:  ba
b01_84fb:   sbc #$c4                    ; 44FB:  e9 c4
b01_84fd:   dec $3c02                   ; 44FD:  ce 02 3c
b01_8500:   sbc #$da                    ; 4500:  e9 da
b01_8502:   .db $d7                     ; 4502:  d7
b01_8503:   .db vm_sp_lo                     ; 4503:  02
b01_8504:   rol a                       ; 4504:  2a
b01_8505:   .db $0c                     ; 4505:  0c
b01_8506:   .db $8b                     ; 4506:  8b
b01_8507:   .db $1a                     ; 4507:  1a
b01_8508:   lda $8c,x                   ; 4508:  b5 8c
b01_850a:   ora ($70,x)                 ; 450A:  01 70
b01_850c:   .db $bb                     ; 450C:  bb
b01_850d:   .db $27                     ; 450D:  27
b01_850e:   and #$40                    ; 450E:  29 40
b01_8510:   .db $2b                     ; 4510:  2b
b01_8511:   .db $0b                     ; 4511:  0b
b01_8512:   lsr $c6,x                   ; 4512:  56 c6
b01_8514:   cld                         ; 4514:  d8
b01_8515:   asl $0b85,x                 ; 4515:  1e 85 0b
b01_8518:   adc $62b3,x                 ; 4518:  7d b3 62
b01_851b:   dec $22,x                   ; 451B:  d6 22
b01_851d:   sta $0b                     ; 451D:  85 0b
b01_851f:   bne $84d4                   ; 451F:  d0 b3
b01_8521:   ror a                       ; 4521:  6a
b01_8522:   sbc #$7b                    ; 4522:  e9 7b
b01_8524:   cpy $0b04                   ; 4524:  cc 04 0b
b01_8527:   .db $d2                     ; 4527:  d2
b01_8528:   sty $f8ae                   ; 4528:  8c ae f8
b01_852b:   .db $bb                     ; 452B:  bb
b01_852c:   bcs $84e1                   ; 452C:  b0 b3
b01_852e:   sbc #$c4                    ; 452E:  e9 c4
b01_8530:   dec $0b02                   ; 4530:  ce 02 0b
b01_8533:   lsr $c6,x                   ; 4533:  56 c6
b01_8535:   cld                         ; 4535:  d8
b01_8536:   lsr a                       ; 4536:  4a
b01_8537:   sta $46                     ; 4537:  85 46
b01_8539:   tay                         ; 4539:  a8
b01_853a:   cmp $0a7f                   ; 453A:  cd 7f 0a
b01_853d:   bne $8569                   ; 453D:  d0 2a
b01_853f:   cmp ($d3),y                 ; 453F:  d1 d3
b01_8541:   .db $b3                     ; 4541:  b3
b01_8542:   .db $3c                     ; 4542:  3c
b01_8543:   sbc #$d5                    ; 4543:  e9 d5
b01_8545:   .db clock_a_hi                     ; 4545:  83
b01_8546:   .db vm_fp_lo                     ; 4546:  04
b01_8547:   dec $5b,x                   ; 4547:  d6 5b
b01_8549:   sta skip_wallclock                     ; 4549:  85 89
b01_854b:   bpl $84f5                   ; 454B:  10 a8
b01_854d:   cmp $097f                   ; 454D:  cd 7f 09
b01_8550:   .db ppumask_shadow                     ; 4550:  72
b01_8551:   and #$8f                    ; 4551:  29 8f
b01_8553:   inc $b3b0,x                 ; 4553:  fe b0 b3
b01_8556:   .db $3c                     ; 4556:  3c
b01_8557:   sbc #$a2                    ; 4557:  e9 a2
b01_8559:   .db clock_a_hi                     ; 4559:  83
b01_855a:   .db vm_fp_lo                     ; 455A:  04
b01_855b:   .db $0b                     ; 455B:  0b
b01_855c:   bne $8589                   ; 455C:  d0 2b
b01_855e:   .db $0b                     ; 455E:  0b
b01_855f:   .db $8b                     ; 455F:  8b
b01_8560:   .db $12                     ; 4560:  12
b01_8561:   dec $d7                     ; 4561:  c6 d7
b01_8563:   ora (clock_b_hi),y                 ; 4563:  11 85
b01_8565:   php                         ; 4565:  08
b01_8566:   cld                         ; 4566:  d8
b01_8567:   sty $3c85                   ; 4567:  8c 85 3c
b01_856a:   sbc #$72                    ; 456A:  e9 72
b01_856c:   .db $d7                     ; 456C:  d7
b01_856d:   .db vm_sp_lo                     ; 456D:  02
b01_856e:   tay                         ; 456E:  a8
b01_856f:   .db $5b                     ; 456F:  5b
b01_8570:   .db p2_buttons                     ; 4570:  6f
b01_8571:   .db $64                     ; 4571:  64
b01_8572:   .db $62                     ; 4572:  62
b01_8573:   sbc #$6f                    ; 4573:  e9 6f
b01_8575:   .db $e7                     ; 4575:  e7
b01_8576:   .db vm_fp_lo                     ; 4576:  04
b01_8577:   .db $3c                     ; 4577:  3c
b01_8578:   sbc #$72                    ; 4578:  e9 72
b01_857a:   cmp $d802,y                 ; 457A:  d9 02 d8
b01_857d:   sty $6b85                   ; 457D:  8c 85 6b
b01_8580:   .db $62                     ; 4580:  62
b01_8581:   sbc #$7b                    ; 4581:  e9 7b
b01_8583:   cpy $8e04                   ; 4583:  cc 04 8e
b01_8586:   lda $ba                     ; 4586:  a5 ba
b01_8588:   sbc #$c4                    ; 4588:  e9 c4
b01_858a:   dec $6002                   ; 458A:  ce 02 60
b01_858d:   sbc #$1e                    ; 458D:  e9 1e
b01_858f:   .db $87                     ; 458F:  87
b01_8590:   .db vm_sp_lo                     ; 4590:  02
b01_8591:   ldy $8094                   ; 4591:  ac 94 80
b01_8594:   rts                         ; 4594:  60
b01_8595:   sbc #$35                    ; 4595:  e9 35
b01_8597:   cpy $cf02                   ; 4597:  cc 02 cf
effect_view_defending_province:   jsr $e823                   ; 459A:  20 23 e8
b01_859d:   brk                         ; 459D:  00
b01_859e:   brk                         ; 459E:  00
b01_859f:   tax                         ; 459F:  aa
b01_85a0:   .db $63                     ; 45A0:  63
b01_85a1:   .db p2_buttons                     ; 45A1:  6f
b01_85a2:   sbc #$fa                    ; 45A2:  e9 fa
b01_85a4:   .db clock_a_hi                     ; 45A4:  83
b01_85a5:   .db vm_sp_lo                     ; 45A5:  02
b01_85a6:   .db $cf                     ; 45A6:  cf
effect_view_c:   jsr $e823                   ; 45A7:  20 23 e8
b01_85aa:   brk                         ; 45AA:  00
b01_85ab:   brk                         ; 45AB:  00
b01_85ac:   tax                         ; 45AC:  aa
b01_85ad:   .db $5f                     ; 45AD:  5f
b01_85ae:   .db p2_buttons                     ; 45AE:  6f
b01_85af:   sbc #$fa                    ; 45AF:  e9 fa
b01_85b1:   .db clock_a_hi                     ; 45B1:  83
b01_85b2:   .db vm_sp_lo                     ; 45B2:  02
b01_85b3:   .db $cf                     ; 45B3:  cf
draw_fief_view_label:   jsr $e823                   ; 45B4:  20 23 e8
b01_85b7:   .db $fa                     ; 45B7:  fa
b01_85b8:   .db $ff                     ; 45B8:  ff
b01_85b9:   ldy $cd                     ; 45B9:  a4 cd
b01_85bb:   .db $7f                     ; 45BB:  7f
b01_85bc:   rol a                       ; 45BC:  2a
b01_85bd:   .db $0c                     ; 45BD:  0c
b01_85be:   sty fief_is_daimyo_capital                   ; 45BE:  8c a2 6d
b01_85c1:   .db $bb                     ; 45C1:  bb
b01_85c2:   .db $d3                     ; 45C2:  d3
b01_85c3:   cld                         ; 45C3:  d8
b01_85c4:   cmp $8e85,y                 ; 45C4:  d9 85 8e
b01_85c7:   tax                         ; 45C7:  aa
b01_85c8:   tsx                         ; 45C8:  ba
b01_85c9:   sbc #$c4                    ; 45C9:  e9 c4
b01_85cb:   dec $0a02                   ; 45CB:  ce 02 0a
b01_85ce:   tay                         ; 45CE:  a8
b01_85cf:   cmp $8e7f                   ; 45CF:  cd 7f 8e
b01_85d2:   bcs $858e                   ; 45D2:  b0 ba
b01_85d4:   sbc #$c4                    ; 45D4:  e9 c4
b01_85d6:   dec $cf02                   ; 45D6:  ce 02 cf
b01_85d9:   .db $3c                     ; 45D9:  3c
b01_85da:   sbc #$8d                    ; 45DA:  e9 8d
b01_85dc:   cmp $d202,y                 ; 45DC:  d9 02 d2
b01_85df:   sty $fee9                   ; 45DF:  8c e9 fe
b01_85e2:   .db $bb                     ; 45E2:  bb
b01_85e3:   bcs $8598                   ; 45E3:  b0 b3
b01_85e5:   sbc #$c4                    ; 45E5:  e9 c4
b01_85e7:   dec $cf02                   ; 45E7:  ce 02 cf
effect_view_b:   jsr $e823                   ; 45EA:  20 23 e8
b01_85ed:   .db $f2                     ; 45ED:  f2
b01_85ee:   .db $ff                     ; 45EE:  ff
b01_85ef:   txa                         ; 45EF:  8a
b01_85f0:   .db skip_wallclock                     ; 45F0:  89
b01_85f1:   .db p2_buttons                     ; 45F1:  6f
b01_85f2:   .db $2b                     ; 45F2:  2b
b01_85f3:   rti                         ; 45F3:  40
b01_85f4:   dec $15,x                   ; 45F4:  d6 15
b01_85f6:   stx $38                     ; 45F6:  86 38
b01_85f8:   sbc #$b7                    ; 45F8:  e9 b7
b01_85fa:   cmp $d802,y                 ; 45FA:  d9 02 d8
b01_85fd:   .db $13                     ; 45FD:  13
b01_85fe:   stx $08                     ; 45FE:  86 08
b01_8600:   sty province_ai_state                   ; 4600:  8c f7 6c
b01_8603:   .db $bb                     ; 4603:  bb
b01_8604:   .db $d3                     ; 4604:  d3
b01_8605:   sty $00ff                   ; 4605:  8c ff 00
b01_8608:   cmp ($d8,x)                 ; 4608:  c1 d8
b01_860a:   .db $13                     ; 460A:  13
b01_860b:   stx $0b                     ; 460B:  86 0b
b01_860d:   bne $863a                   ; 460D:  d0 2b
b01_860f:   cmp ($b3),y                 ; 460F:  d1 b3
b01_8611:   php                         ; 4611:  08
b01_8612:   .db $d4                     ; 4612:  d4
b01_8613:   php                         ; 4613:  08
b01_8614:   bne $863e                   ; 4614:  d0 28
b01_8616:   php                         ; 4616:  08
b01_8617:   ldx $9d                     ; 4617:  a6 9d
b01_8619:   adc $d7c6                   ; 4619:  6d c6 d7
b01_861c:   .db $f7                     ; 461C:  f7
b01_861d:   sta $3b                     ; 461D:  85 3b
b01_861f:   .db skip_wallclock                     ; 461F:  89
b01_8620:   .db $ff                     ; 4620:  ff
b01_8621:   .db $d4                     ; 4621:  d4
b01_8622:   rti                         ; 4622:  40
b01_8623:   rol a                       ; 4623:  2a
b01_8624:   txa                         ; 4624:  8a
b01_8625:   .db skip_wallclock                     ; 4625:  89
b01_8626:   .db p2_buttons                     ; 4626:  6f
b01_8627:   dec vm_fp_hi,x                   ; 4627:  d6 05
b01_8629:   .db $87                     ; 4629:  87
b01_862a:   asl a                       ; 462A:  0a
b01_862b:   .db $d7                     ; 462B:  d7
b01_862c:   .db $64                     ; 462C:  64
b01_862d:   stx $ac                     ; 462D:  86 ac
b01_862f:   jsr $61cd                   ; 462F:  20 cd 61
b01_8632:   sbc #$35                    ; 4632:  e9 35
b01_8634:   cpy $8d02                   ; 4634:  cc 02 8d
b01_8637:   .db $2b                     ; 4637:  2b
b01_8638:   .db brk_scratch_hi                     ; 4638:  67
b01_8639:   sbc #$8b                    ; 4639:  e9 8b
b01_863b:   .db $cf                     ; 463B:  cf
b01_863c:   .db vm_fp_lo                     ; 463C:  04
b01_863d:   sta $6b23                   ; 463D:  8d 23 6b
b01_8640:   sbc #$8b                    ; 4640:  e9 8b
b01_8642:   .db $cf                     ; 4642:  cf
b01_8643:   .db vm_fp_lo                     ; 4643:  04
b01_8644:   adc ($63,x)                 ; 4644:  61 63
b01_8646:   adc $63                     ; 4646:  65 63
b01_8648:   .db $62                     ; 4648:  62
b01_8649:   sbc #$6a                    ; 4649:  e9 6a
b01_864b:   .db $cf                     ; 464B:  cf
b01_864c:   asl a                       ; 464C:  0a
b01_864d:   .db $62                     ; 464D:  62
b01_864e:   sta $6711                   ; 464E:  8d 11 67
b01_8651:   adc $62                     ; 4651:  65 62
b01_8653:   sbc #$6a                    ; 4653:  e9 6a
b01_8655:   .db $cf                     ; 4655:  cf
b01_8656:   asl a                       ; 4656:  0a
b01_8657:   .db $63                     ; 4657:  63
b01_8658:   .db $62                     ; 4658:  62
b01_8659:   sbc #$7b                    ; 4659:  e9 7b
b01_865b:   cpy $8e04                   ; 465B:  cc 04 8e
b01_865e:   lda $ba,x                   ; 465E:  b5 ba
b01_8660:   sbc #$c4                    ; 4660:  e9 c4
b01_8662:   dec $0b02                   ; 4662:  ce 02 0b
b01_8665:   .db $d3                     ; 4665:  d3
b01_8666:   .db $b3                     ; 4666:  b3
b01_8667:   sbc #$36                    ; 4667:  e9 36
b01_8669:   cld                         ; 4669:  d8
b01_866a:   .db vm_sp_lo                     ; 466A:  02
b01_866b:   .db $43                     ; 466B:  43
b01_866c:   tay                         ; 466C:  a8
b01_866d:   .db $cf                     ; 466D:  cf
b01_866e:   .db $7f                     ; 466E:  7f
b01_866f:   asl a                       ; 466F:  0a
b01_8670:   eor $b5,x                   ; 4670:  55 b5
b01_8672:   .db music_ptr_hi                     ; 4672:  7b
b01_8673:   rol $a8                     ; 4673:  26 a8
b01_8675:   cmp $0b7f                   ; 4675:  cd 7f 0b
b01_8678:   .db $d3                     ; 4678:  d3
b01_8679:   bne $862e                   ; 4679:  d0 b3
b01_867b:   stx $bb02                   ; 467B:  8e 02 bb
b01_867e:   sbc #$34                    ; 467E:  e9 34
b01_8680:   cmp (vm_fp_lo),y                 ; 4680:  d1 04
b01_8682:   .db $0b                     ; 4682:  0b
b01_8683:   .db $d3                     ; 4683:  d3
b01_8684:   .db $8b                     ; 4684:  8b
b01_8685:   .db $1a                     ; 4685:  1a
b01_8686:   lda $8c,x                   ; 4686:  b5 8c
b01_8688:   ora ($70,x)                 ; 4688:  01 70
b01_868a:   .db $bb                     ; 468A:  bb
b01_868b:   and #$06                    ; 468B:  29 06
b01_868d:   cmp ($a8),y                 ; 468D:  d1 a8
b01_868f:   cmp $a47f                   ; 468F:  cd 7f a4
b01_8692:   .db $cf                     ; 4692:  cf
b01_8693:   .db $7f                     ; 4693:  7f
b01_8694:   .db ppumask_shadow                     ; 4694:  72
b01_8695:   tay                         ; 4695:  a8
b01_8696:   .db $cf                     ; 4696:  cf
b01_8697:   .db $7f                     ; 4697:  7f
b01_8698:   ora #$72                    ; 4698:  09 72
b01_869a:   and #$8f                    ; 469A:  29 8f
b01_869c:   inc $b3b0,x                 ; 469C:  fe b0 b3
b01_869f:   stx $bb06                   ; 469F:  8e 06 bb
b01_86a2:   sbc #$34                    ; 46A2:  e9 34
b01_86a4:   cmp (vm_fp_lo),y                 ; 46A4:  d1 04
b01_86a6:   rti                         ; 46A6:  40
b01_86a7:   plp                         ; 46A7:  28
b01_86a8:   asl $d1                     ; 46A8:  06 d1
b01_86aa:   tay                         ; 46AA:  a8
b01_86ab:   cmp $097f                   ; 46AB:  cd 7f 09
b01_86ae:   .db ppumask_shadow                     ; 46AE:  72
b01_86af:   and #$b0                    ; 46AF:  29 b0
b01_86b1:   .db $b3                     ; 46B1:  b3
b01_86b2:   stx $bb0b                   ; 46B2:  8e 0b bb
b01_86b5:   sbc #$34                    ; 46B5:  e9 34
b01_86b7:   cmp (vm_fp_lo),y                 ; 46B7:  d1 04
b01_86b9:   php                         ; 46B9:  08
b01_86ba:   bne $86e4                   ; 46BA:  d0 28
b01_86bc:   php                         ; 46BC:  08
b01_86bd:   .db $5a                     ; 46BD:  5a
b01_86be:   .db $c2                     ; 46BE:  c2
b01_86bf:   .db $d7                     ; 46BF:  d7
b01_86c0:   tay                         ; 46C0:  a8
b01_86c1:   stx vm_ip_lo                     ; 46C1:  86 06
b01_86c3:   cmp ($a8),y                 ; 46C3:  d1 a8
b01_86c5:   cmp $0b7f                   ; 46C5:  cd 7f 0b
b01_86c8:   .db $d3                     ; 46C8:  d3
b01_86c9:   sty fief_tax_rate                   ; 46C9:  8c 2d 6d
b01_86cc:   .db $bb                     ; 46CC:  bb
b01_86cd:   .db $d3                     ; 46CD:  d3
b01_86ce:   .db $b3                     ; 46CE:  b3
b01_86cf:   stx $bb10                   ; 46CF:  8e 10 bb
b01_86d2:   sbc #$34                    ; 46D2:  e9 34
b01_86d4:   cmp (vm_fp_lo),y                 ; 46D4:  d1 04
b01_86d6:   asl $d1                     ; 46D6:  06 d1
b01_86d8:   tay                         ; 46D8:  a8
b01_86d9:   cmp $0b7f                   ; 46D9:  cd 7f 0b
b01_86dc:   .db $d3                     ; 46DC:  d3
b01_86dd:   .db $b3                     ; 46DD:  b3
b01_86de:   sbc #$b4                    ; 46DE:  e9 b4
b01_86e0:   sta vm_sp_lo                     ; 46E0:  85 02
b01_86e2:   asl a                       ; 46E2:  0a
b01_86e3:   bne $870f                   ; 46E3:  d0 2a
b01_86e5:   .db $54                     ; 46E5:  54
b01_86e6:   cpy #$d7                    ; 46E6:  c0 d7
b01_86e8:   .db $f4                     ; 46E8:  f4
b01_86e9:   stx $0b                     ; 46E9:  86 0b
b01_86eb:   bne $86c0                   ; 46EB:  d0 d3
b01_86ed:   sty $00ff                   ; 46ED:  8c ff 00
b01_86f0:   cpy #$d8                    ; 46F0:  c0 d8
b01_86f2:   .db vm_sp_hi                     ; 46F2:  03
b01_86f3:   .db $87                     ; 46F3:  87
b01_86f4:   rts                         ; 46F4:  60
b01_86f5:   sbc #$35                    ; 46F5:  e9 35
b01_86f7:   cpy $ac02                   ; 46F7:  cc 02 ac
b01_86fa:   ora #$d6                    ; 46FA:  09 d6
b01_86fc:   .db $52                     ; 46FC:  52
b01_86fd:   cpy #$d7                    ; 46FD:  c0 d7
b01_86ff:   .db $0f                     ; 46FF:  0f
b01_8700:   .db $87                     ; 4700:  87
b01_8701:   rti                         ; 4701:  40
b01_8702:   rol a                       ; 4702:  2a
b01_8703:   .db $0b                     ; 4703:  0b
b01_8704:   bne $8731                   ; 4704:  d0 2b
b01_8706:   .db $0b                     ; 4706:  0b
b01_8707:   .db $d3                     ; 4707:  d3
b01_8708:   sty $00ff                   ; 4708:  8c ff 00
b01_870b:   cmp ($d7,x)                 ; 470B:  c1 d7
b01_870d:   rol a                       ; 470D:  2a
b01_870e:   stx $8d                     ; 470E:  86 8d
b01_8710:   and (brk_scratch_hi,x)                 ; 4710:  21 67
b01_8712:   sbc #$8b                    ; 4712:  e9 8b
b01_8714:   .db $cf                     ; 4714:  cf
b01_8715:   .db vm_fp_lo                     ; 4715:  04
b01_8716:   sta $6b30                   ; 4716:  8d 30 6b
b01_8719:   sbc #$8b                    ; 4719:  e9 8b
b01_871b:   .db $cf                     ; 471B:  cf
b01_871c:   .db vm_fp_lo                     ; 471C:  04
b01_871d:   .db $cf                     ; 471D:  cf
fief_info_display:   jsr $e823                   ; 471E:  20 23 e8
b01_8721:   inc $0cff,x                 ; 4721:  fe ff 0c
b01_8724:   tay                         ; 4724:  a8
b01_8725:   .db $e2                     ; 4725:  e2
b01_8726:   .db music_ptr_hi                     ; 4726:  7b
b01_8727:   adc $8d                     ; 4727:  65 8d
b01_8729:   asl $e9,x                   ; 4729:  16 e9
b01_872b:   .db music_ptr_hi                     ; 472B:  7b
b01_872c:   cpy $8e04                   ; 472C:  cc 04 8e
b01_872f:   ora $bb,x                   ; 472F:  15 bb
b01_8731:   sbc #$c4                    ; 4731:  e9 c4
b01_8733:   dec $ac02                   ; 4733:  ce 02 ac
b01_8736:   adc #$cc                    ; 4736:  69 cc
b01_8738:   ldy $e2                     ; 4738:  a4 e2
b01_873a:   .db music_ptr_hi                     ; 473A:  7b
b01_873b:   .db $d7                     ; 473B:  d7
b01_873c:   .db $6b                     ; 473C:  6b
b01_873d:   .db $87                     ; 473D:  87
b01_873e:   rti                         ; 473E:  40
b01_873f:   .db $2b                     ; 473F:  2b
b01_8740:   .db $0b                     ; 4740:  0b
b01_8741:   .db $77                     ; 4741:  77
b01_8742:   .db $b3                     ; 4742:  b3
b01_8743:   sta $e916                   ; 4743:  8d 16 e9
b01_8746:   .db music_ptr_hi                     ; 4746:  7b
b01_8747:   cpy $0b04                   ; 4747:  cc 04 0b
b01_874a:   bne $86ff                   ; 474A:  d0 b3
b01_874c:   stx $bb1e                   ; 474C:  8e 1e bb
b01_874f:   sbc #$34                    ; 474F:  e9 34
b01_8751:   cmp (vm_fp_lo),y                 ; 4751:  d1 04
b01_8753:   .db $0b                     ; 4753:  0b
b01_8754:   .db $d2                     ; 4754:  d2
b01_8755:   sty $f816                   ; 4755:  8c 16 f8
b01_8758:   .db $bb                     ; 4758:  bb
b01_8759:   bcs $870e                   ; 4759:  b0 b3
b01_875b:   sbc #$c4                    ; 475B:  e9 c4
b01_875d:   dec $0b02                   ; 475D:  ce 02 0b
b01_8760:   bne $878d                   ; 4760:  d0 2b
b01_8762:   .db $0b                     ; 4762:  0b
b01_8763:   .db $5c                     ; 4763:  5c
b01_8764:   dec $d7                     ; 4764:  c6 d7
b01_8766:   rti                         ; 4766:  40
b01_8767:   .db $87                     ; 4767:  87
b01_8768:   dec $97,x                   ; 4768:  d6 97
b01_876a:   .db $87                     ; 476A:  87
b01_876b:   jmp $0b2b                   ; 476B:  4c 2b 0b
b01_876e:   .db $8f                     ; 476E:  8f
b01_876f:   .db $fb                     ; 476F:  fb
b01_8770:   .db $b3                     ; 4770:  b3
b01_8771:   sta $e916                   ; 4771:  8d 16 e9
b01_8774:   .db music_ptr_hi                     ; 4774:  7b
b01_8775:   cpy $0b04                   ; 4775:  cc 04 0b
b01_8778:   bne $872d                   ; 4778:  d0 b3
b01_877a:   stx $bb22                   ; 477A:  8e 22 bb
b01_877d:   sbc #$34                    ; 477D:  e9 34
b01_877f:   cmp (vm_fp_lo),y                 ; 477F:  d1 04
b01_8781:   .db $0b                     ; 4781:  0b
b01_8782:   .db $d2                     ; 4782:  d2
b01_8783:   sty $f816                   ; 4783:  8c 16 f8
b01_8786:   .db $bb                     ; 4786:  bb
b01_8787:   bcs $873c                   ; 4787:  b0 b3
b01_8789:   sbc #$c4                    ; 4789:  e9 c4
b01_878b:   dec $0b02                   ; 478B:  ce 02 0b
b01_878e:   bne $87bb                   ; 478E:  d0 2b
b01_8790:   .db $0b                     ; 4790:  0b
b01_8791:   .db $8b                     ; 4791:  8b
b01_8792:   ora $c6,x                   ; 4792:  15 c6
b01_8794:   .db $d7                     ; 4794:  d7
b01_8795:   adc $a487                   ; 4795:  6d 87 a4
b01_8798:   .db $5f                     ; 4798:  5f
b01_8799:   .db p2_buttons                     ; 4799:  6f
b01_879a:   tay                         ; 479A:  a8
b01_879b:   .db $63                     ; 479B:  63
b01_879c:   .db p2_buttons                     ; 479C:  6f
b01_879d:   rti                         ; 479D:  40
b01_879e:   .db $cf                     ; 479E:  cf
province_select_helper:   jsr $e823                   ; 479F:  20 23 e8
b01_87a2:   brk                         ; 47A2:  00
b01_87a3:   brk                         ; 47A3:  00
b01_87a4:   rts                         ; 47A4:  60
b01_87a5:   and $e93c,x                 ; 47A5:  3d 3c e9
b01_87a8:   .db ppumask_shadow                     ; 47A8:  72
b01_87a9:   sta (vm_ip_lo,x)                 ; 47A9:  81 06
b01_87ab:   .db $d7                     ; 47AB:  d7
b01_87ac:   .db $bb                     ; 47AC:  bb
b01_87ad:   .db $87                     ; 47AD:  87
b01_87ae:   stx $f98a                   ; 47AE:  8e 8a f9
b01_87b1:   .db $3c                     ; 47B1:  3c
b01_87b2:   sbc #$03                    ; 47B2:  e9 03
b01_87b4:   .db skip_vblank_wait                     ; 47B4:  80
b01_87b5:   .db vm_fp_lo                     ; 47B5:  04
b01_87b6:   ldy $d766                   ; 47B6:  ac 66 d7
b01_87b9:   rti                         ; 47B9:  40
b01_87ba:   .db $cf                     ; 47BA:  cf
b01_87bb:   stx $bb26                   ; 47BB:  8e 26 bb
b01_87be:   .db $3c                     ; 47BE:  3c
b01_87bf:   sbc #$03                    ; 47BF:  e9 03
b01_87c1:   .db skip_vblank_wait                     ; 47C1:  80
b01_87c2:   .db vm_fp_lo                     ; 47C2:  04
b01_87c3:   adc ($3d,x)                 ; 47C3:  61 3d
b01_87c5:   .db $3c                     ; 47C5:  3c
b01_87c6:   sbc #$72                    ; 47C6:  e9 72
b01_87c8:   sta (vm_ip_lo,x)                 ; 47C8:  81 06
b01_87ca:   .db $cf                     ; 47CA:  cf
show_not_home_fief:   jsr $e823                   ; 47CB:  20 23 e8
b01_87ce:   brk                         ; 47CE:  00
b01_87cf:   brk                         ; 47CF:  00
b01_87d0:   stx $bb28                   ; 47D0:  8e 28 bb
b01_87d3:   sbc #$26                    ; 47D3:  e9 26
b01_87d5:   .db $d3                     ; 47D5:  d3
b01_87d6:   .db vm_sp_lo                     ; 47D6:  02
b01_87d7:   .db $cf                     ; 47D7:  cf
effect_dam:   jsr $e823                   ; 47D8:  20 23 e8
b01_87db:   brk                         ; 47DB:  00
b01_87dc:   brk                         ; 47DC:  00
b01_87dd:   .db $0c                     ; 47DD:  0c
b01_87de:   sei                         ; 47DE:  78
b01_87df:   bcs $87b8                   ; 47DF:  b0 d7
b01_87e1:   .db $e7                     ; 47E1:  e7
b01_87e2:   .db $87                     ; 47E2:  87
b01_87e3:   txa                         ; 47E3:  8a
b01_87e4:   bpl $880d                   ; 47E4:  10 27
b01_87e6:   .db $cf                     ; 47E6:  cf
b01_87e7:   .db $0c                     ; 47E7:  0c
b01_87e8:   sei                         ; 47E8:  78
b01_87e9:   bcs $879e                   ; 47E9:  b0 b3
b01_87eb:   sbc #$cd                    ; 47EB:  e9 cd
b01_87ed:   .db $cb                     ; 47ED:  cb
b01_87ee:   .db vm_sp_lo                     ; 47EE:  02
b01_87ef:   .db $cf                     ; 47EF:  cf
effect_grow:   jsr $e823                   ; 47F0:  20 23 e8
b01_87f3:   .db $fc                     ; 47F3:  fc
b01_87f4:   .db $ff                     ; 47F4:  ff
b01_87f5:   ora $c251                   ; 47F5:  0d 51 c2
b01_87f8:   cld                         ; 47F8:  d8
b01_87f9:   sbc $4087,x                 ; 47F9:  fd 87 40
b01_87fc:   .db $cf                     ; 47FC:  cf
b01_87fd:   .db $0c                     ; 47FD:  0c
b01_87fe:   sei                         ; 47FE:  78
b01_87ff:   bcs $881e                   ; 47FF:  b0 1d
b01_8801:   .db $bb                     ; 4801:  bb
b01_8802:   .db $b3                     ; 4802:  b3
b01_8803:   sbc #$cd                    ; 4803:  e9 cd
b01_8805:   .db $cb                     ; 4805:  cb
b01_8806:   .db vm_sp_lo                     ; 4806:  02
b01_8807:   .db $b3                     ; 4807:  b3
b01_8808:   lsr $a6                     ; 4808:  46 a6
b01_880a:   .db $63                     ; 480A:  63
b01_880b:   adc $b3bc                   ; 480B:  6d bc b3
b01_880e:   and $b8e9,x                 ; 480E:  3d e9 b8
b01_8811:   dec vm_ip_lo,x                   ; 4811:  d6 06
b01_8813:   .db $d2                     ; 4813:  d2
b01_8814:   .db $2b                     ; 4814:  2b
b01_8815:   .db $0b                     ; 4815:  0b
b01_8816:   .db $d7                     ; 4816:  d7
b01_8817:   .db $1b                     ; 4817:  1b
b01_8818:   dey                         ; 4818:  88
b01_8819:   eor ($2b,x)                 ; 4819:  41 2b
b01_881b:   .db $0c                     ; 481B:  0c
b01_881c:   sei                         ; 481C:  78
b01_881d:   bcs $87d2                   ; 481D:  b0 b3
b01_881f:   .db $0c                     ; 481F:  0c
b01_8820:   .db $8f                     ; 4820:  8f
b01_8821:   clc                         ; 4821:  18
b01_8822:   bcs $87d8                   ; 4822:  b0 b4
b01_8824:   ldy $b32a,x                 ; 4824:  bc 2a b3
b01_8827:   .db $0b                     ; 4827:  0b
b01_8828:   ldy $c4,x                   ; 4828:  b4 c4
b01_882a:   cld                         ; 482A:  d8
b01_882b:   .db $2f                     ; 482B:  2f
b01_882c:   dey                         ; 482C:  88
b01_882d:   asl a                       ; 482D:  0a
b01_882e:   .db $2b                     ; 482E:  2b
b01_882f:   .db $0c                     ; 482F:  0c
b01_8830:   sei                         ; 4830:  78
b01_8831:   bcs $87e6                   ; 4831:  b0 b3
b01_8833:   .db $0b                     ; 4833:  0b
b01_8834:   .db $52                     ; 4834:  52
b01_8835:   ldx $b4,y                   ; 4835:  b6 b4
b01_8837:   cpy $d8                     ; 4837:  c4 d8
b01_8839:   rti                         ; 4839:  40
b01_883a:   dey                         ; 483A:  88
b01_883b:   .db skip_wallclock                     ; 483B:  89
b01_883c:   .db $64                     ; 483C:  64
b01_883d:   dec $49,x                   ; 483D:  d6 49
b01_883f:   dey                         ; 483F:  88
b01_8840:   .db $0c                     ; 4840:  0c
b01_8841:   sei                         ; 4841:  78
b01_8842:   bcs $87f7                   ; 4842:  b0 b3
b01_8844:   .db $3b                     ; 4844:  3b
b01_8845:   sbc #$de                    ; 4845:  e9 de
b01_8847:   dec vm_fp_lo,x                   ; 4847:  d6 04
b01_8849:   rol a                       ; 4849:  2a
b01_884a:   .db $42                     ; 484A:  42
b01_884b:   cmp $b60a                   ; 484B:  cd 0a b6
b01_884e:   rol a                       ; 484E:  2a
b01_884f:   .db $3a                     ; 484F:  3a
b01_8850:   .db $0c                     ; 4850:  0c
b01_8851:   .db $7c                     ; 4851:  7c
b01_8852:   bcs $8807                   ; 4852:  b0 b3
b01_8854:   sbc #$0d                    ; 4854:  e9 0d
b01_8856:   .db $d7                     ; 4856:  d7
b01_8857:   .db vm_fp_lo                     ; 4857:  04
b01_8858:   .db $b3                     ; 4858:  b3
b01_8859:   .db $0c                     ; 4859:  0c
b01_885a:   .db $7c                     ; 485A:  7c
b01_885b:   ldy $b3,x                   ; 485B:  b4 b3
b01_885d:   bcs $881b                   ; 485D:  b0 bc
b01_885f:   lda ($3a),y                 ; 485F:  b1 3a
b01_8861:   .db $0c                     ; 4861:  0c
b01_8862:   .db music_ptr_lo                     ; 4862:  7a
b01_8863:   bcs $8818                   ; 4863:  b0 b3
b01_8865:   sbc #$0d                    ; 4865:  e9 0d
b01_8867:   .db $d7                     ; 4867:  d7
b01_8868:   .db vm_fp_lo                     ; 4868:  04
b01_8869:   .db $b3                     ; 4869:  b3
b01_886a:   .db $0c                     ; 486A:  0c
b01_886b:   .db music_ptr_lo                     ; 486B:  7a
b01_886c:   ldy $b3,x                   ; 486C:  b4 b3
b01_886e:   bcs $882c                   ; 486E:  b0 bc
b01_8870:   lda ($3b),y                 ; 4870:  b1 3b
b01_8872:   .db $0c                     ; 4872:  0c
b01_8873:   sei                         ; 4873:  78
b01_8874:   ldy $b3,x                   ; 4874:  b4 b3
b01_8876:   bcs $8833                   ; 4876:  b0 bb
b01_8878:   lda ($0b),y                 ; 4878:  b1 0b
b01_887a:   .db $52                     ; 487A:  52
b01_887b:   ldx $cf,y                   ; 487B:  b6 cf
add_effect_gain_clamped:   jsr $e823                   ; 487D:  20 23 e8
b01_8880:   inc $0cff,x                 ; 4880:  fe ff 0c
b01_8883:   .db $2b                     ; 4883:  2b
b01_8884:   tax                         ; 4884:  aa
b01_8885:   .db $5f                     ; 4885:  5f
b01_8886:   .db p2_buttons                     ; 4886:  6f
b01_8887:   sbc #$72                    ; 4887:  e9 72
b01_8889:   cmp $d802,y                 ; 4889:  d9 02 d8
b01_888c:   sta $4288,y                 ; 488C:  99 88 42
b01_888f:   cmp $b60b                   ; 488F:  cd 0b b6
b01_8892:   .db $2b                     ; 4892:  2b
b01_8893:   .db $d7                     ; 4893:  d7
b01_8894:   sta $0b88,y                 ; 4894:  99 88 0b
b01_8897:   bne $88c4                   ; 4897:  d0 2b
b01_8899:   .db $3b                     ; 4899:  3b
b01_889a:   ora $b3b4                   ; 489A:  0d b4 b3
b01_889d:   bcs $885a                   ; 489D:  b0 bb
b01_889f:   lda ($3d),y                 ; 489F:  b1 3d
b01_88a1:   sbc #$ac                    ; 48A1:  e9 ac
b01_88a3:   .db $82                     ; 48A3:  82
b01_88a4:   .db vm_sp_lo                     ; 48A4:  02
b01_88a5:   .db $cf                     ; 48A5:  cf
effect_build:   jsr $e823                   ; 48A6:  20 23 e8
b01_88a9:   .db $fc                     ; 48A9:  fc
b01_88aa:   .db $ff                     ; 48AA:  ff
b01_88ab:   ora $c251                   ; 48AB:  0d 51 c2
b01_88ae:   cld                         ; 48AE:  d8
b01_88af:   .db $b3                     ; 48AF:  b3
b01_88b0:   dey                         ; 48B0:  88
b01_88b1:   rti                         ; 48B1:  40
b01_88b2:   .db $cf                     ; 48B2:  cf
b01_88b3:   .db $0c                     ; 48B3:  0c
b01_88b4:   .db palette_dirty                     ; 48B4:  74
b01_88b5:   bcs $88d4                   ; 48B5:  b0 1d
b01_88b7:   .db $bb                     ; 48B7:  bb
b01_88b8:   .db $b3                     ; 48B8:  b3
b01_88b9:   sbc #$cd                    ; 48B9:  e9 cd
b01_88bb:   .db $cb                     ; 48BB:  cb
b01_88bc:   .db vm_sp_lo                     ; 48BC:  02
b01_88bd:   .db $b3                     ; 48BD:  b3
b01_88be:   lsr $a6                     ; 48BE:  46 a6
b01_88c0:   .db $63                     ; 48C0:  63
b01_88c1:   adc $b3bc                   ; 48C1:  6d bc b3
b01_88c4:   and $b8e9,x                 ; 48C4:  3d e9 b8
b01_88c7:   dec vm_ip_lo,x                   ; 48C7:  d6 06
b01_88c9:   .db $2b                     ; 48C9:  2b
b01_88ca:   .db $0b                     ; 48CA:  0b
b01_88cb:   .db $d7                     ; 48CB:  d7
b01_88cc:   bne $8856                   ; 48CC:  d0 88
b01_88ce:   eor ($2b,x)                 ; 48CE:  41 2b
b01_88d0:   .db $0c                     ; 48D0:  0c
b01_88d1:   .db palette_dirty                     ; 48D1:  74
b01_88d2:   bcs $8887                   ; 48D2:  b0 b3
b01_88d4:   .db $0c                     ; 48D4:  0c
b01_88d5:   .db $8f                     ; 48D5:  8f
b01_88d6:   clc                         ; 48D6:  18
b01_88d7:   bcs $888d                   ; 48D7:  b0 b4
b01_88d9:   ldy $b32a,x                 ; 48D9:  bc 2a b3
b01_88dc:   .db $0b                     ; 48DC:  0b
b01_88dd:   ldy $c4,x                   ; 48DD:  b4 c4
b01_88df:   cld                         ; 48DF:  d8
b01_88e0:   cpx $88                     ; 48E0:  e4 88
b01_88e2:   asl a                       ; 48E2:  0a
b01_88e3:   .db $2b                     ; 48E3:  2b
b01_88e4:   .db $0c                     ; 48E4:  0c
b01_88e5:   .db palette_dirty                     ; 48E5:  74
b01_88e6:   bcs $889b                   ; 48E6:  b0 b3
b01_88e8:   .db $0b                     ; 48E8:  0b
b01_88e9:   ldy $c4,x                   ; 48E9:  b4 c4
b01_88eb:   cld                         ; 48EB:  d8
b01_88ec:   .db $f3                     ; 48EC:  f3
b01_88ed:   dey                         ; 48ED:  88
b01_88ee:   .db skip_wallclock                     ; 48EE:  89
b01_88ef:   .db $64                     ; 48EF:  64
b01_88f0:   dec $fc,x                   ; 48F0:  d6 fc
b01_88f2:   dey                         ; 48F2:  88
b01_88f3:   .db $0c                     ; 48F3:  0c
b01_88f4:   .db palette_dirty                     ; 48F4:  74
b01_88f5:   bcs $88aa                   ; 48F5:  b0 b3
b01_88f7:   .db $3b                     ; 48F7:  3b
b01_88f8:   sbc #$de                    ; 48F8:  e9 de
b01_88fa:   dec vm_fp_lo,x                   ; 48FA:  d6 04
b01_88fc:   rol a                       ; 48FC:  2a
b01_88fd:   asl a                       ; 48FD:  0a
b01_88fe:   .db $52                     ; 48FE:  52
b01_88ff:   ldx $b3,y                   ; 48FF:  b6 b3
b01_8901:   .db $0c                     ; 4901:  0c
b01_8902:   ror $b3b0,x                 ; 4902:  7e b0 b3
b01_8905:   sbc #$0d                    ; 4905:  e9 0d
b01_8907:   .db $d7                     ; 4907:  d7
b01_8908:   .db vm_fp_lo                     ; 4908:  04
b01_8909:   .db $b3                     ; 4909:  b3
b01_890a:   .db $0c                     ; 490A:  0c
b01_890b:   ror $b3b4,x                 ; 490B:  7e b4 b3
b01_890e:   bcs $88cc                   ; 490E:  b0 bc
b01_8910:   lda ($0c),y                 ; 4910:  b1 0c
b01_8912:   .db palette_dirty                     ; 4912:  74
b01_8913:   .db $b3                     ; 4913:  b3
b01_8914:   .db $0b                     ; 4914:  0b
b01_8915:   .db $d2                     ; 4915:  d2
b01_8916:   .db $b3                     ; 4916:  b3
b01_8917:   sbc #$7d                    ; 4917:  e9 7d
b01_8919:   dey                         ; 4919:  88
b01_891a:   .db vm_fp_lo                     ; 491A:  04
b01_891b:   .db $0b                     ; 491B:  0b
b01_891c:   .db $cf                     ; 491C:  cf
develop_loyalty:   jsr $e823                   ; 491D:  20 23 e8
b01_8920:   .db $fc                     ; 4920:  fc
b01_8921:   .db $ff                     ; 4921:  ff
b01_8922:   ora $c251                   ; 4922:  0d 51 c2
b01_8925:   cld                         ; 4925:  d8
b01_8926:   rol a                       ; 4926:  2a
b01_8927:   .db skip_wallclock                     ; 4927:  89
b01_8928:   rti                         ; 4928:  40
b01_8929:   .db $cf                     ; 4929:  cf
b01_892a:   .db $0c                     ; 492A:  0c
b01_892b:   sei                         ; 492B:  78
b01_892c:   bcs $88e1                   ; 492C:  b0 b3
b01_892e:   .db $0c                     ; 492E:  0c
b01_892f:   .db $7c                     ; 492F:  7c
b01_8930:   bcs $88e6                   ; 4930:  b0 b4
b01_8932:   .db $bb                     ; 4932:  bb
b01_8933:   .db $52                     ; 4933:  52
b01_8934:   ldx ppu_queue_a_hi,y                   ; 4934:  b6 1d
b01_8936:   .db $bb                     ; 4936:  bb
b01_8937:   .db $b3                     ; 4937:  b3
b01_8938:   sbc #$cd                    ; 4938:  e9 cd
b01_893a:   .db $cb                     ; 493A:  cb
b01_893b:   .db vm_sp_lo                     ; 493B:  02
b01_893c:   .db $b3                     ; 493C:  b3
b01_893d:   lsr $a6                     ; 493D:  46 a6
b01_893f:   .db $63                     ; 493F:  63
b01_8940:   adc $b3bc                   ; 4940:  6d bc b3
b01_8943:   and $b8e9,x                 ; 4943:  3d e9 b8
b01_8946:   dec vm_ip_lo,x                   ; 4946:  d6 06
b01_8948:   .db $2b                     ; 4948:  2b
b01_8949:   .db $0b                     ; 4949:  0b
b01_894a:   .db $d7                     ; 494A:  d7
b01_894b:   .db $4f                     ; 494B:  4f
b01_894c:   .db skip_wallclock                     ; 494C:  89
b01_894d:   eor ($2b,x)                 ; 494D:  41 2b
b01_894f:   .db $0c                     ; 494F:  0c
b01_8950:   .db $7c                     ; 4950:  7c
b01_8951:   bcs $8906                   ; 4951:  b0 b3
b01_8953:   .db $0c                     ; 4953:  0c
b01_8954:   .db $8f                     ; 4954:  8f
b01_8955:   clc                         ; 4955:  18
b01_8956:   bcs $890c                   ; 4956:  b0 b4
b01_8958:   ldy $b32a,x                 ; 4958:  bc 2a b3
b01_895b:   .db $0b                     ; 495B:  0b
b01_895c:   ldy $c4,x                   ; 495C:  b4 c4
b01_895e:   cld                         ; 495E:  d8
b01_895f:   .db $63                     ; 495F:  63
b01_8960:   .db skip_wallclock                     ; 4960:  89
b01_8961:   asl a                       ; 4961:  0a
b01_8962:   .db $2b                     ; 4962:  2b
b01_8963:   .db $0b                     ; 4963:  0b
b01_8964:   .db $d2                     ; 4964:  d2
b01_8965:   .db $b3                     ; 4965:  b3
b01_8966:   .db $0c                     ; 4966:  0c
b01_8967:   .db $7c                     ; 4967:  7c
b01_8968:   ldy $b3,x                   ; 4968:  b4 b3
b01_896a:   bcs $8927                   ; 496A:  b0 bb
b01_896c:   lda ($0b),y                 ; 496C:  b1 0b
b01_896e:   .db $cf                     ; 496E:  cf
develop_wealth:   jsr $e823                   ; 496F:  20 23 e8
b01_8972:   .db $fc                     ; 4972:  fc
b01_8973:   .db $ff                     ; 4973:  ff
b01_8974:   ora $c251                   ; 4974:  0d 51 c2
b01_8977:   cld                         ; 4977:  d8
b01_8978:   .db $7c                     ; 4978:  7c
b01_8979:   .db skip_wallclock                     ; 4979:  89
b01_897a:   rti                         ; 497A:  40
b01_897b:   .db $cf                     ; 497B:  cf
b01_897c:   .db $0c                     ; 497C:  0c
b01_897d:   .db palette_dirty                     ; 497D:  74
b01_897e:   bcs $8933                   ; 497E:  b0 b3
b01_8980:   .db $0c                     ; 4980:  0c
b01_8981:   ror $b4b0,x                 ; 4981:  7e b0 b4
b01_8984:   .db $bb                     ; 4984:  bb
b01_8985:   .db $52                     ; 4985:  52
b01_8986:   ldx ppu_queue_a_hi,y                   ; 4986:  b6 1d
b01_8988:   .db $bb                     ; 4988:  bb
b01_8989:   .db $b3                     ; 4989:  b3
b01_898a:   sbc #$cd                    ; 498A:  e9 cd
b01_898c:   .db $cb                     ; 498C:  cb
b01_898d:   .db vm_sp_lo                     ; 498D:  02
b01_898e:   .db $b3                     ; 498E:  b3
b01_898f:   lsr $a6                     ; 498F:  46 a6
b01_8991:   .db $63                     ; 4991:  63
b01_8992:   adc $b3bc                   ; 4992:  6d bc b3
b01_8995:   and $b8e9,x                 ; 4995:  3d e9 b8
b01_8998:   dec vm_ip_lo,x                   ; 4998:  d6 06
b01_899a:   .db $2b                     ; 499A:  2b
b01_899b:   .db $0b                     ; 499B:  0b
b01_899c:   .db $d7                     ; 499C:  d7
b01_899d:   lda (skip_wallclock,x)                 ; 499D:  a1 89
b01_899f:   eor ($2b,x)                 ; 499F:  41 2b
b01_89a1:   .db $0c                     ; 49A1:  0c
b01_89a2:   ror $b3b0,x                 ; 49A2:  7e b0 b3
b01_89a5:   .db $0c                     ; 49A5:  0c
b01_89a6:   .db $8f                     ; 49A6:  8f
b01_89a7:   clc                         ; 49A7:  18
b01_89a8:   bcs $895e                   ; 49A8:  b0 b4
b01_89aa:   ldy $b32a,x                 ; 49AA:  bc 2a b3
b01_89ad:   .db $0b                     ; 49AD:  0b
b01_89ae:   ldy $c4,x                   ; 49AE:  b4 c4
b01_89b0:   cld                         ; 49B0:  d8
b01_89b1:   lda skip_wallclock,x                   ; 49B1:  b5 89
b01_89b3:   asl a                       ; 49B3:  0a
b01_89b4:   .db $2b                     ; 49B4:  2b
b01_89b5:   .db $0b                     ; 49B5:  0b
b01_89b6:   .db $d2                     ; 49B6:  d2
b01_89b7:   .db $b3                     ; 49B7:  b3
b01_89b8:   .db $0c                     ; 49B8:  0c
b01_89b9:   ror $b3b4,x                 ; 49B9:  7e b4 b3
b01_89bc:   bcs $8979                   ; 49BC:  b0 bb
b01_89be:   lda ($0b),y                 ; 49BE:  b1 0b
b01_89c0:   .db $cf                     ; 49C0:  cf
develop_morale:   jsr $e823                   ; 49C1:  20 23 e8
b01_89c4:   .db $fc                     ; 49C4:  fc
b01_89c5:   .db $ff                     ; 49C5:  ff
b01_89c6:   ora $c251                   ; 49C6:  0d 51 c2
b01_89c9:   cld                         ; 49C9:  d8
b01_89ca:   dec $4089                   ; 49CA:  ce 89 40
b01_89cd:   .db $cf                     ; 49CD:  cf
b01_89ce:   .db $0c                     ; 49CE:  0c
b01_89cf:   .db $8f                     ; 49CF:  8f
b01_89d0:   bpl $8982                   ; 49D0:  10 b0
b01_89d2:   .db $b3                     ; 49D2:  b3
b01_89d3:   .db $0c                     ; 49D3:  0c
b01_89d4:   .db $8f                     ; 49D4:  8f
b01_89d5:   .db $12                     ; 49D5:  12
b01_89d6:   bcs $898c                   ; 49D6:  b0 b4
b01_89d8:   .db $bb                     ; 49D8:  bb
b01_89d9:   .db $52                     ; 49D9:  52
b01_89da:   ldx ppu_queue_a_hi,y                   ; 49DA:  b6 1d
b01_89dc:   .db $bb                     ; 49DC:  bb
b01_89dd:   .db $b3                     ; 49DD:  b3
b01_89de:   sbc #$cd                    ; 49DE:  e9 cd
b01_89e0:   .db $cb                     ; 49E0:  cb
b01_89e1:   .db vm_sp_lo                     ; 49E1:  02
b01_89e2:   .db $b3                     ; 49E2:  b3
b01_89e3:   lsr $a6                     ; 49E3:  46 a6
b01_89e5:   .db $63                     ; 49E5:  63
b01_89e6:   adc $b3bc                   ; 49E6:  6d bc b3
b01_89e9:   and $b8e9,x                 ; 49E9:  3d e9 b8
b01_89ec:   dec vm_ip_lo,x                   ; 49EC:  d6 06
b01_89ee:   .db $2b                     ; 49EE:  2b
b01_89ef:   .db $0b                     ; 49EF:  0b
b01_89f0:   .db $d7                     ; 49F0:  d7
b01_89f1:   sbc skip_wallclock,x                   ; 49F1:  f5 89
b01_89f3:   eor ($2b,x)                 ; 49F3:  41 2b
b01_89f5:   .db $0c                     ; 49F5:  0c
b01_89f6:   .db $8f                     ; 49F6:  8f
b01_89f7:   .db $12                     ; 49F7:  12
b01_89f8:   bcs $89ad                   ; 49F8:  b0 b3
b01_89fa:   .db $0c                     ; 49FA:  0c
b01_89fb:   .db $8f                     ; 49FB:  8f
b01_89fc:   clc                         ; 49FC:  18
b01_89fd:   bcs $89b3                   ; 49FD:  b0 b4
b01_89ff:   ldy $b32a,x                 ; 49FF:  bc 2a b3
b01_8a02:   .db $0b                     ; 4A02:  0b
b01_8a03:   ldy $c4,x                   ; 4A03:  b4 c4
b01_8a05:   cld                         ; 4A05:  d8
b01_8a06:   asl a                       ; 4A06:  0a
b01_8a07:   txa                         ; 4A07:  8a
b01_8a08:   asl a                       ; 4A08:  0a
b01_8a09:   .db $2b                     ; 4A09:  2b
b01_8a0a:   .db $3b                     ; 4A0A:  3b
b01_8a0b:   .db $0c                     ; 4A0B:  0c
b01_8a0c:   .db $8f                     ; 4A0C:  8f
b01_8a0d:   .db $12                     ; 4A0D:  12
b01_8a0e:   ldy $b3,x                   ; 4A0E:  b4 b3
b01_8a10:   bcs $89cd                   ; 4A10:  b0 bb
b01_8a12:   lda ($0b),y                 ; 4A12:  b1 0b
b01_8a14:   .db $cf                     ; 4A14:  cf
effect_trade:   jsr $e823                   ; 4A15:  20 23 e8
b01_8a18:   brk                         ; 4A18:  00
b01_8a19:   brk                         ; 4A19:  00
b01_8a1a:   ldy $9d                     ; 4A1A:  a4 9d
b01_8a1c:   adc $328b                   ; 4A1C:  6d 8b 32
b01_8a1f:   cpy #$d8                    ; 4A1F:  c0 d8
b01_8a21:   plp                         ; 4A21:  28
b01_8a22:   txa                         ; 4A22:  8a
b01_8a23:   .db skip_wallclock                     ; 4A23:  89
b01_8a24:   asl $29d6,x                 ; 4A24:  1e d6 29
b01_8a27:   txa                         ; 4A27:  8a
b01_8a28:   eor $5fa6                   ; 4A28:  4d a6 5f
b01_8a2b:   .db p2_buttons                     ; 4A2B:  6f
b01_8a2c:   cpy #$d7                    ; 4A2C:  c0 d7
b01_8a2e:   lsr $8a                     ; 4A2E:  46 8a
b01_8a30:   ldy $9d                     ; 4A30:  a4 9d
b01_8a32:   adc $328b                   ; 4A32:  6d 8b 32
b01_8a35:   cpy #$d8                    ; 4A35:  c0 d8
b01_8a37:   rol $898a,x                 ; 4A37:  3e 8a 89
b01_8a3a:   jsr $3fd6                   ; 4A3A:  20 d6 3f
b01_8a3d:   txa                         ; 4A3D:  8a
b01_8a3e:   lsr $5fa6                   ; 4A3E:  4e a6 5f
b01_8a41:   .db p2_buttons                     ; 4A41:  6f
b01_8a42:   cpy #$d8                    ; 4A42:  c0 d8
b01_8a44:   pha                         ; 4A44:  48
b01_8a45:   txa                         ; 4A45:  8a
b01_8a46:   eor ($cf,x)                 ; 4A46:  41 cf
b01_8a48:   lda $a1                     ; 4A48:  a5 a1
b01_8a4a:   adc $da51                   ; 4A4A:  6d 51 da
b01_8a4d:   .db $cf                     ; 4A4D:  cf
cycle_economy_rate:   jsr $e823                   ; 4A4E:  20 23 e8
b01_8a51:   .db $fa                     ; 4A51:  fa
b01_8a52:   .db $ff                     ; 4A52:  ff
b01_8a53:   ldy $cd                     ; 4A53:  a4 cd
b01_8a55:   .db $7f                     ; 4A55:  7f
b01_8a56:   rol a                       ; 4A56:  2a
b01_8a57:   ldy $cf                     ; 4A57:  a4 cf
b01_8a59:   .db $7f                     ; 4A59:  7f
b01_8a5a:   and #$89                    ; 4A5A:  29 89
b01_8a5c:   .db $1a                     ; 4A5C:  1a
b01_8a5d:   tay                         ; 4A5D:  a8
b01_8a5e:   cmp $0c7f                   ; 4A5E:  cd 7f 0c
b01_8a61:   cmp scratch_ptr_lo,x                   ; 4A61:  d5 00
b01_8a63:   brk                         ; 4A63:  00
b01_8a64:   asl scratch_ptr_lo                     ; 4A64:  06 00
b01_8a66:   sty $8a,x                   ; 4A66:  94 8a
b01_8a68:   .db palette_dirty                     ; 4A68:  74
b01_8a69:   txa                         ; 4A69:  8a
b01_8a6a:   ldy $aa8a,x                 ; 4A6A:  bc 8a aa
b01_8a6d:   txa                         ; 4A6D:  8a
b01_8a6e:   inc $8a                     ; 4A6E:  e6 8a
b01_8a70:   .db $d4                     ; 4A70:  d4
b01_8a71:   txa                         ; 4A71:  8a
b01_8a72:   sed                         ; 4A72:  f8
b01_8a73:   txa                         ; 4A73:  8a
b01_8a74:   ldy $0b                     ; 4A74:  a4 0b
b01_8a76:   ror $a8d0                   ; 4A76:  6e d0 a8
b01_8a79:   .db $0b                     ; 4A79:  0b
b01_8a7a:   ror $0ba4                   ; 4A7A:  6e a4 0b
b01_8a7d:   ror $c45f                   ; 4A7D:  6e 5f c4
b01_8a80:   cld                         ; 4A80:  d8
b01_8a81:   .db $8b                     ; 4A81:  8b
b01_8a82:   txa                         ; 4A82:  8a
b01_8a83:   .db p2_buttons                     ; 4A83:  6f
b01_8a84:   sbc #$52                    ; 4A84:  e9 52
b01_8a86:   dex                         ; 4A86:  ca
b01_8a87:   .db vm_sp_lo                     ; 4A87:  02
b01_8a88:   tay                         ; 4A88:  a8
b01_8a89:   .db $0b                     ; 4A89:  0b
b01_8a8a:   ror $1589                   ; 4A8A:  6e 89 15
b01_8a8d:   tay                         ; 4A8D:  a8
b01_8a8e:   .db $cf                     ; 4A8E:  cf
b01_8a8f:   .db $7f                     ; 4A8F:  7f
b01_8a90:   ldy $0b                     ; 4A90:  a4 0b
b01_8a92:   ror $0b2b                   ; 4A92:  6e 2b 0b
b01_8a95:   .db $5a                     ; 4A95:  5a
b01_8a96:   lda $0bb3,y                 ; 4A96:  b9 b3 0b
b01_8a99:   .db $5a                     ; 4A99:  5a
b01_8a9a:   ldx $b3,y                   ; 4A9A:  b6 b3
b01_8a9c:   stx $bb36                   ; 4A9C:  8e 36 bb
b01_8a9f:   sbc #$34                    ; 4A9F:  e9 34
b01_8aa1:   cmp (vm_ip_lo),y                 ; 4AA1:  d1 06
b01_8aa3:   and $e93a,y                 ; 4AA3:  39 3a e9
b01_8aa6:   .db music_ptr_hi                     ; 4AA6:  7b
b01_8aa7:   cpy $cf04                   ; 4AA7:  cc 04 cf
b01_8aaa:   ldy $0d                     ; 4AAA:  a4 0d
b01_8aac:   ror $a8d0                   ; 4AAC:  6e d0 a8
b01_8aaf:   ora $896e                   ; 4AAF:  0d 6e 89
b01_8ab2:   asl $a8,x                   ; 4AB2:  16 a8
b01_8ab4:   .db $cf                     ; 4AB4:  cf
b01_8ab5:   .db $7f                     ; 4AB5:  7f
b01_8ab6:   ldy $0d                     ; 4AB6:  a4 0d
b01_8ab8:   ror $93d6                   ; 4AB8:  6e d6 93
b01_8abb:   txa                         ; 4ABB:  8a
b01_8abc:   ldy $0d                     ; 4ABC:  a4 0d
b01_8abe:   ror $c351                   ; 4ABE:  6e 51 c3
b01_8ac1:   cld                         ; 4AC1:  d8
b01_8ac2:   .db $cb                     ; 4AC2:  cb
b01_8ac3:   txa                         ; 4AC3:  8a
b01_8ac4:   ldy $0d                     ; 4AC4:  a4 0d
b01_8ac6:   ror $d6d1                   ; 4AC6:  6e d1 d6
b01_8ac9:   cpy $418a                   ; 4AC9:  cc 8a 41
b01_8acc:   cmp $0da4                   ; 4ACC:  cd a4 0d
b01_8acf:   ror $d6bc                   ; 4ACF:  6e bc d6
b01_8ad2:   ldx $a48a                   ; 4AD2:  ae 8a a4
b01_8ad5:   ora (p1_buttons),y                 ; 4AD5:  11 6e
b01_8ad7:   bne $8a81                   ; 4AD7:  d0 a8
b01_8ad9:   ora (p1_buttons),y                 ; 4AD9:  11 6e
b01_8adb:   .db skip_wallclock                     ; 4ADB:  89
b01_8adc:   clc                         ; 4ADC:  18
b01_8add:   tay                         ; 4ADD:  a8
b01_8ade:   .db $cf                     ; 4ADE:  cf
b01_8adf:   .db $7f                     ; 4ADF:  7f
b01_8ae0:   ldy $11                     ; 4AE0:  a4 11
b01_8ae2:   ror $93d6                   ; 4AE2:  6e d6 93
b01_8ae5:   txa                         ; 4AE5:  8a
b01_8ae6:   ldy $0f                     ; 4AE6:  a4 0f
b01_8ae8:   ror $a8d0                   ; 4AE8:  6e d0 a8
b01_8aeb:   .db $0f                     ; 4AEB:  0f
b01_8aec:   ror $1789                   ; 4AEC:  6e 89 17
b01_8aef:   tay                         ; 4AEF:  a8
b01_8af0:   .db $cf                     ; 4AF0:  cf
b01_8af1:   .db $7f                     ; 4AF1:  7f
b01_8af2:   ldy $0f                     ; 4AF2:  a4 0f
b01_8af4:   ror $93d6                   ; 4AF4:  6e d6 93
b01_8af7:   txa                         ; 4AF7:  8a
b01_8af8:   ldy $13                     ; 4AF8:  a4 13
b01_8afa:   ror $a8d0                   ; 4AFA:  6e d0 a8
b01_8afd:   .db $13                     ; 4AFD:  13
b01_8afe:   ror $1989                   ; 4AFE:  6e 89 19
b01_8b01:   tay                         ; 4B01:  a8
b01_8b02:   .db $cf                     ; 4B02:  cf
b01_8b03:   .db $7f                     ; 4B03:  7f
b01_8b04:   ldy $13                     ; 4B04:  a4 13
b01_8b06:   ror $93d6                   ; 4B06:  6e d6 93
b01_8b09:   txa                         ; 4B09:  8a
effect_sell_rice_for_gold:   jsr $e823                   ; 4B0A:  20 23 e8
b01_8b0d:   inc $ff,x                   ; 4B0D:  f6 ff
b01_8b0f:   ldy $5f                     ; 4B0F:  a4 5f
b01_8b11:   .db p2_buttons                     ; 4B11:  6f
b01_8b12:   .db $8b                     ; 4B12:  8b
b01_8b13:   .db $1a                     ; 4B13:  1a
b01_8b14:   lda $8c,x                   ; 4B14:  b5 8c
b01_8b16:   ora ($70,x)                 ; 4B16:  01 70
b01_8b18:   .db $bb                     ; 4B18:  bb
b01_8b19:   rol a                       ; 4B19:  2a
b01_8b1a:   asl a                       ; 4B1A:  0a
b01_8b1b:   ror $2b,x                   ; 4B1B:  76 2b
b01_8b1d:   .db $0b                     ; 4B1D:  0b
b01_8b1e:   .db $8f                     ; 4B1E:  8f
b01_8b1f:   .db $12                     ; 4B1F:  12
b01_8b20:   bcs $8b49                   ; 4B20:  b0 27
b01_8b22:   ldy $0d                     ; 4B22:  a4 0d
b01_8b24:   ror $3c29                   ; 4B24:  6e 29 3c
b01_8b27:   and $03e9,y                 ; 4B27:  39 e9 03
b01_8b2a:   .db clock_a_hi                     ; 4B2A:  83
b01_8b2b:   .db vm_fp_lo                     ; 4B2B:  04
b01_8b2c:   .db $b3                     ; 4B2C:  b3
b01_8b2d:   asl a                       ; 4B2D:  0a
b01_8b2e:   ldy $b3,x                   ; 4B2E:  b4 b3
b01_8b30:   bcs $8aed                   ; 4B30:  b0 bb
b01_8b32:   lda ($3c),y                 ; 4B32:  b1 3c
b01_8b34:   .db $0b                     ; 4B34:  0b
b01_8b35:   ldy $b3,x                   ; 4B35:  b4 b3
b01_8b37:   bcs $8af5                   ; 4B37:  b0 bc
b01_8b39:   lda ($61),y                 ; 4B39:  b1 61
b01_8b3b:   sbc #$4e                    ; 4B3B:  e9 4e
b01_8b3d:   txa                         ; 4B3D:  8a
b01_8b3e:   .db vm_sp_lo                     ; 4B3E:  02
b01_8b3f:   .db $cf                     ; 4B3F:  cf
effect_take_loan:   jsr $e823                   ; 4B40:  20 23 e8
b01_8b43:   inc $ff,x                   ; 4B43:  f6 ff
b01_8b45:   ldy $5f                     ; 4B45:  a4 5f
b01_8b47:   .db p2_buttons                     ; 4B47:  6f
b01_8b48:   .db $8b                     ; 4B48:  8b
b01_8b49:   .db $1a                     ; 4B49:  1a
b01_8b4a:   lda $8c,x                   ; 4B4A:  b5 8c
b01_8b4c:   ora ($70,x)                 ; 4B4C:  01 70
b01_8b4e:   .db $bb                     ; 4B4E:  bb
b01_8b4f:   .db $27                     ; 4B4F:  27
b01_8b50:   .db vm_ip_hi                     ; 4B50:  07
b01_8b51:   .db ppumask_shadow                     ; 4B51:  72
b01_8b52:   plp                         ; 4B52:  28
b01_8b53:   php                         ; 4B53:  08
b01_8b54:   .db ppumask_shadow                     ; 4B54:  72
b01_8b55:   bcs $8b80                   ; 4B55:  b0 29
b01_8b57:   ldy $0b                     ; 4B57:  a4 0b
b01_8b59:   ror $2a7a                   ; 4B59:  6e 7a 2a
b01_8b5c:   .db $0c                     ; 4B5C:  0c
b01_8b5d:   bvc $8b22                   ; 4B5D:  50 c3
b01_8b5f:   cld                         ; 4B5F:  d8
b01_8b60:   .db palette_dirty                     ; 4B60:  74
b01_8b61:   .db $8b                     ; 4B61:  8b
b01_8b62:   php                         ; 4B62:  08
b01_8b63:   bcs $8b18                   ; 4B63:  b0 b3
b01_8b65:   ora #$b4                    ; 4B65:  09 b4
b01_8b67:   ldy $3ab3,x                 ; 4B67:  bc b3 3a
b01_8b6a:   and $57e9,y                 ; 4B6A:  39 e9 57
b01_8b6d:   .db clock_a_hi                     ; 4B6D:  83
b01_8b6e:   asl $2c                     ; 4B6E:  06 2c
b01_8b70:   rti                         ; 4B70:  40
b01_8b71:   dec music_ptr_lo,x                   ; 4B71:  d6 7a
b01_8b73:   .db $8b                     ; 4B73:  8b
b01_8b74:   .db $3c                     ; 4B74:  3c
b01_8b75:   .db $3a                     ; 4B75:  3a
b01_8b76:   sbc #$03                    ; 4B76:  e9 03
b01_8b78:   .db clock_a_hi                     ; 4B78:  83
b01_8b79:   .db vm_fp_lo                     ; 4B79:  04
b01_8b7a:   .db $2b                     ; 4B7A:  2b
b01_8b7b:   .db $3b                     ; 4B7B:  3b
b01_8b7c:   php                         ; 4B7C:  08
b01_8b7d:   ldy $b3,x                   ; 4B7D:  b4 b3
b01_8b7f:   bcs $8b3c                   ; 4B7F:  b0 bb
b01_8b81:   lda ($3c),y                 ; 4B81:  b1 3c
b01_8b83:   .db vm_ip_hi                     ; 4B83:  07
b01_8b84:   ldy $b3,x                   ; 4B84:  b4 b3
b01_8b86:   bcs $8b43                   ; 4B86:  b0 bb
b01_8b88:   lda ($60),y                 ; 4B88:  b1 60
b01_8b8a:   sbc #$4e                    ; 4B8A:  e9 4e
b01_8b8c:   txa                         ; 4B8C:  8a
b01_8b8d:   .db vm_sp_lo                     ; 4B8D:  02
b01_8b8e:   .db $cf                     ; 4B8E:  cf
play_result_jingle:   jsr $e823                   ; 4B8F:  20 23 e8
b01_8b92:   brk                         ; 4B92:  00
b01_8b93:   brk                         ; 4B93:  00
b01_8b94:   rts                         ; 4B94:  60
b01_8b95:   rts                         ; 4B95:  60
b01_8b96:   ror a                       ; 4B96:  6a
b01_8b97:   sbc #$26                    ; 4B97:  e9 26
b01_8b99:   .db $f2                     ; 4B99:  f2
b01_8b9a:   asl $0c                     ; 4B9A:  06 0c
b01_8b9c:   .db $d7                     ; 4B9C:  d7
b01_8b9d:   .db $a3                     ; 4B9D:  a3
b01_8b9e:   .db $8b                     ; 4B9E:  8b
b01_8b9f:   .db $47                     ; 4B9F:  47
b01_8ba0:   dec $a4,x                   ; 4BA0:  d6 a4
b01_8ba2:   .db $8b                     ; 4BA2:  8b
b01_8ba3:   pha                         ; 4BA3:  48
b01_8ba4:   .db $b3                     ; 4BA4:  b3
b01_8ba5:   sbc #$03                    ; 4BA5:  e9 03
b01_8ba7:   dex                         ; 4BA7:  ca
b01_8ba8:   .db vm_sp_lo                     ; 4BA8:  02
b01_8ba9:   ldy $4d                     ; 4BA9:  a4 4d
b01_8bab:   .db p2_buttons                     ; 4BAB:  6f
b01_8bac:   eor ($c0),y                 ; 4BAC:  51 c0
b01_8bae:   cld                         ; 4BAE:  d8
b01_8baf:   .db $bb                     ; 4BAF:  bb
b01_8bb0:   .db $8b                     ; 4BB0:  8b
b01_8bb1:   .db $62                     ; 4BB1:  62
b01_8bb2:   adc ($6a,x)                 ; 4BB2:  61 6a
b01_8bb4:   sbc #$26                    ; 4BB4:  e9 26
b01_8bb6:   .db $f2                     ; 4BB6:  f2
b01_8bb7:   asl $d7                     ; 4BB7:  06 d7
b01_8bb9:   lda ($8b),y                 ; 4BB9:  b1 8b
b01_8bbb:   adc ($e9,x)                 ; 4BBB:  61 e9
b01_8bbd:   .db vm_sp_hi                     ; 4BBD:  03
b01_8bbe:   dex                         ; 4BBE:  ca
b01_8bbf:   .db vm_sp_lo                     ; 4BBF:  02
b01_8bc0:   .db $cf                     ; 4BC0:  cf
compute_bribe_effect_value:   jsr $e823                   ; 4BC1:  20 23 e8
b01_8bc4:   brk                         ; 4BC4:  00
b01_8bc5:   brk                         ; 4BC5:  00
b01_8bc6:   sta $e919                   ; 4BC6:  8d 19 e9
b01_8bc9:   .db $52                     ; 4BC9:  52
b01_8bca:   dex                         ; 4BCA:  ca
b01_8bcb:   .db vm_sp_lo                     ; 4BCB:  02
b01_8bcc:   .db $8f                     ; 4BCC:  8f
b01_8bcd:   asl $0cb3,x                 ; 4BCD:  1e b3 0c
b01_8bd0:   bcs $8b85                   ; 4BD0:  b0 b3
b01_8bd2:   and $5ee9,x                 ; 4BD2:  3d e9 5e
b01_8bd5:   .db $cb                     ; 4BD5:  cb
b01_8bd6:   .db vm_fp_lo                     ; 4BD6:  04
b01_8bd7:   bne $8b8c                   ; 4BD7:  d0 b3
b01_8bd9:   sbc #$0d                    ; 4BD9:  e9 0d
b01_8bdb:   .db $d7                     ; 4BDB:  d7
b01_8bdc:   .db vm_fp_lo                     ; 4BDC:  04
b01_8bdd:   bne $8b92                   ; 4BDD:  d0 b3
b01_8bdf:   .db $3c                     ; 4BDF:  3c
b01_8be0:   sbc #$31                    ; 4BE0:  e9 31
b01_8be2:   dex                         ; 4BE2:  ca
b01_8be3:   .db vm_fp_lo                     ; 4BE3:  04
b01_8be4:   .db $cf                     ; 4BE4:  cf
effect_send:   jsr $e823                   ; 4BE5:  20 23 e8
b01_8be8:   brk                         ; 4BE8:  00
b01_8be9:   brk                         ; 4BE9:  00
b01_8bea:   rol $1d0c,x                 ; 4BEA:  3e 0c 1d
b01_8bed:   ldy $e9b3,x                 ; 4BED:  bc b3 e9
b01_8bf0:   lsr $04cb,x                 ; 4BF0:  5e cb 04
b01_8bf3:   .db $cf                     ; 4BF3:  cf
apply_hire_unit_stats:   jsr $e823                   ; 4BF4:  20 23 e8
b01_8bf7:   brk                         ; 4BF7:  00
b01_8bf8:   brk                         ; 4BF8:  00
b01_8bf9:   .db $0c                     ; 4BF9:  0c
b01_8bfa:   .db $8f                     ; 4BFA:  8f
b01_8bfb:   .db $12                     ; 4BFB:  12
b01_8bfc:   .db $b3                     ; 4BFC:  b3
b01_8bfd:   .db $0c                     ; 4BFD:  0c
b01_8bfe:   .db $8f                     ; 4BFE:  8f
b01_8bff:   clc                         ; 4BFF:  18
b01_8c00:   bcs $8bb5                   ; 4C00:  b0 b3
b01_8c02:   .db $0c                     ; 4C02:  0c
b01_8c03:   .db $8f                     ; 4C03:  8f
b01_8c04:   bpl $8bb6                   ; 4C04:  10 b0
b01_8c06:   .db $b3                     ; 4C06:  b3
b01_8c07:   and $148d,x                 ; 4C07:  3d 8d 14
b01_8c0a:   sbc #$52                    ; 4C0A:  e9 52
b01_8c0c:   dex                         ; 4C0C:  ca
b01_8c0d:   .db vm_sp_lo                     ; 4C0D:  02
b01_8c0e:   .db $8f                     ; 4C0E:  8f
b01_8c0f:   plp                         ; 4C0F:  28
b01_8c10:   .db $b3                     ; 4C10:  b3
b01_8c11:   .db $0c                     ; 4C11:  0c
b01_8c12:   .db $8f                     ; 4C12:  8f
b01_8c13:   .db $12                     ; 4C13:  12
b01_8c14:   bcs $8bc9                   ; 4C14:  b0 b3
b01_8c16:   sbc #$24                    ; 4C16:  e9 24
b01_8c18:   .db $da                     ; 4C18:  da
b01_8c19:   asl a                       ; 4C19:  0a
b01_8c1a:   lda ($0c),y                 ; 4C1A:  b1 0c
b01_8c1c:   .db $8f                     ; 4C1C:  8f
b01_8c1d:   .db $14                     ; 4C1D:  14
b01_8c1e:   .db $b3                     ; 4C1E:  b3
b01_8c1f:   .db $0c                     ; 4C1F:  0c
b01_8c20:   .db $8f                     ; 4C20:  8f
b01_8c21:   clc                         ; 4C21:  18
b01_8c22:   bcs $8bd7                   ; 4C22:  b0 b3
b01_8c24:   .db $0c                     ; 4C24:  0c
b01_8c25:   .db $8f                     ; 4C25:  8f
b01_8c26:   bpl $8bd8                   ; 4C26:  10 b0
b01_8c28:   .db $b3                     ; 4C28:  b3
b01_8c29:   and $148d,x                 ; 4C29:  3d 8d 14
b01_8c2c:   sbc #$52                    ; 4C2C:  e9 52
b01_8c2e:   dex                         ; 4C2E:  ca
b01_8c2f:   .db vm_sp_lo                     ; 4C2F:  02
b01_8c30:   .db $8f                     ; 4C30:  8f
b01_8c31:   .db $3c                     ; 4C31:  3c
b01_8c32:   .db $b3                     ; 4C32:  b3
b01_8c33:   .db $0c                     ; 4C33:  0c
b01_8c34:   .db $8f                     ; 4C34:  8f
b01_8c35:   .db $14                     ; 4C35:  14
b01_8c36:   bcs $8beb                   ; 4C36:  b0 b3
b01_8c38:   sbc #$24                    ; 4C38:  e9 24
b01_8c3a:   .db $da                     ; 4C3A:  da
b01_8c3b:   asl a                       ; 4C3B:  0a
b01_8c3c:   lda ($0c),y                 ; 4C3C:  b1 0c
b01_8c3e:   .db $8f                     ; 4C3E:  8f
b01_8c3f:   asl $b3,x                   ; 4C3F:  16 b3
b01_8c41:   .db $0c                     ; 4C41:  0c
b01_8c42:   .db $8f                     ; 4C42:  8f
b01_8c43:   clc                         ; 4C43:  18
b01_8c44:   bcs $8bf9                   ; 4C44:  b0 b3
b01_8c46:   .db $0c                     ; 4C46:  0c
b01_8c47:   .db $8f                     ; 4C47:  8f
b01_8c48:   asl nmi_skip_all,x                   ; 4C48:  16 b0
b01_8c4a:   .db $b3                     ; 4C4A:  b3
b01_8c4b:   and $e96a,x                 ; 4C4B:  3d 6a e9
b01_8c4e:   .db $52                     ; 4C4E:  52
b01_8c4f:   dex                         ; 4C4F:  ca
b01_8c50:   .db vm_sp_lo                     ; 4C50:  02
b01_8c51:   .db $8f                     ; 4C51:  8f
b01_8c52:   .db $32                     ; 4C52:  32
b01_8c53:   .db $b3                     ; 4C53:  b3
b01_8c54:   .db $0c                     ; 4C54:  0c
b01_8c55:   .db $8f                     ; 4C55:  8f
b01_8c56:   asl nmi_skip_all,x                   ; 4C56:  16 b0
b01_8c58:   .db $b3                     ; 4C58:  b3
b01_8c59:   sbc #$24                    ; 4C59:  e9 24
b01_8c5b:   .db $da                     ; 4C5B:  da
b01_8c5c:   asl a                       ; 4C5C:  0a
b01_8c5d:   lda ($3d),y                 ; 4C5D:  b1 3d
b01_8c5f:   .db $0c                     ; 4C5F:  0c
b01_8c60:   .db $8f                     ; 4C60:  8f
b01_8c61:   bpl $8c17                   ; 4C61:  10 b4
b01_8c63:   .db $b3                     ; 4C63:  b3
b01_8c64:   bcs $8c21                   ; 4C64:  b0 bb
b01_8c66:   lda ($cf),y                 ; 4C66:  b1 cf
random_daimyo_stat_increment:   jsr $e823                   ; 4C68:  20 23 e8
b01_8c6b:   inc $aaff,x                 ; 4C6B:  fe ff aa
b01_8c6e:   .db $5f                     ; 4C6E:  5f
b01_8c6f:   .db p2_buttons                     ; 4C6F:  6f
b01_8c70:   sbc #$8d                    ; 4C70:  e9 8d
b01_8c72:   cmp $d702,y                 ; 4C72:  d9 02 d7
b01_8c75:   lda ($8c,x)                 ; 4C75:  a1 8c
b01_8c77:   ror a                       ; 4C77:  6a
b01_8c78:   sbc #$52                    ; 4C78:  e9 52
b01_8c7a:   dex                         ; 4C7A:  ca
b01_8c7b:   .db vm_sp_lo                     ; 4C7B:  02
b01_8c7c:   .db $d7                     ; 4C7C:  d7
b01_8c7d:   lda ($8c,x)                 ; 4C7D:  a1 8c
b01_8c7f:   ldy $d7ea                   ; 4C7F:  ac ea d7
b01_8c82:   .db $2b                     ; 4C82:  2b
b01_8c83:   .db $62                     ; 4C83:  62
b01_8c84:   adc $e9                     ; 4C84:  65 e9
b01_8c86:   .db $52                     ; 4C86:  52
b01_8c87:   dex                         ; 4C87:  ca
b01_8c88:   .db vm_sp_lo                     ; 4C88:  02
b01_8c89:   .db $1b                     ; 4C89:  1b
b01_8c8a:   .db $bb                     ; 4C8A:  bb
b01_8c8b:   bne $8c41                   ; 4C8B:  d0 b4
b01_8c8d:   .db $b3                     ; 4C8D:  b3
b01_8c8e:   .db $d3                     ; 4C8E:  d3
b01_8c8f:   .db $bb                     ; 4C8F:  bb
b01_8c90:   .db $d4                     ; 4C90:  d4
b01_8c91:   .db $0b                     ; 4C91:  0b
b01_8c92:   bne $8c67                   ; 4C92:  d0 d3
b01_8c94:   sty $00c8                   ; 4C94:  8c c8 00
b01_8c97:   cmp $d8                     ; 4C97:  c5 d8
b01_8c99:   lda ($8c,x)                 ; 4C99:  a1 8c
b01_8c9b:   .db $0b                     ; 4C9B:  0b
b01_8c9c:   bne $8c51                   ; 4C9C:  d0 b3
b01_8c9e:   .db skip_wallclock                     ; 4C9E:  89
b01_8c9f:   iny                         ; 4C9F:  c8
b01_8ca0:   .db $d4                     ; 4CA0:  d4
b01_8ca1:   txa                         ; 4CA1:  8a
b01_8ca2:   .db $ff                     ; 4CA2:  ff
b01_8ca3:   brk                         ; 4CA3:  00
b01_8ca4:   .db $cf                     ; 4CA4:  cf
effect_move:   jsr $e823                   ; 4CA5:  20 23 e8
b01_8ca8:   inc $ff,x                   ; 4CA8:  f6 ff
b01_8caa:   ldy $5f                     ; 4CAA:  a4 5f
b01_8cac:   .db p2_buttons                     ; 4CAC:  6f
b01_8cad:   .db $8b                     ; 4CAD:  8b
b01_8cae:   .db $1a                     ; 4CAE:  1a
b01_8caf:   lda $8c,x                   ; 4CAF:  b5 8c
b01_8cb1:   ora ($70),y                 ; 4CB1:  11 70
b01_8cb3:   .db $bb                     ; 4CB3:  bb
b01_8cb4:   rol a                       ; 4CB4:  2a
b01_8cb5:   asl a                       ; 4CB5:  0a
b01_8cb6:   .db ppumask_shadow                     ; 4CB6:  72
b01_8cb7:   plp                         ; 4CB7:  28
b01_8cb8:   ldy $63                     ; 4CB8:  a4 63
b01_8cba:   .db p2_buttons                     ; 4CBA:  6f
b01_8cbb:   .db $8b                     ; 4CBB:  8b
b01_8cbc:   .db $1a                     ; 4CBC:  1a
b01_8cbd:   lda $8c,x                   ; 4CBD:  b5 8c
b01_8cbf:   ora ($70),y                 ; 4CBF:  11 70
b01_8cc1:   .db $bb                     ; 4CC1:  bb
b01_8cc2:   and #$09                    ; 4CC2:  29 09
b01_8cc4:   .db ppumask_shadow                     ; 4CC4:  72
b01_8cc5:   .db $27                     ; 4CC5:  27
b01_8cc6:   rti                         ; 4CC6:  40
b01_8cc7:   .db $2b                     ; 4CC7:  2b
b01_8cc8:   .db $37                     ; 4CC8:  37
b01_8cc9:   ora #$78                    ; 4CC9:  09 78
b01_8ccb:   bcs $8c80                   ; 4CCB:  b0 b3
b01_8ccd:   ora #$b0                    ; 4CCD:  09 b0
b01_8ccf:   .db $b3                     ; 4CCF:  b3
b01_8cd0:   .db $3c                     ; 4CD0:  3c
b01_8cd1:   php                         ; 4CD1:  08
b01_8cd2:   .db ppumask_shadow                     ; 4CD2:  72
b01_8cd3:   plp                         ; 4CD3:  28
b01_8cd4:   .db $8f                     ; 4CD4:  8f
b01_8cd5:   inc $b3b0,x                 ; 4CD5:  fe b0 b3
b01_8cd8:   .db vm_ip_hi                     ; 4CD8:  07
b01_8cd9:   bcs $8c8e                   ; 4CD9:  b0 b3
b01_8cdb:   sbc #$24                    ; 4CDB:  e9 24
b01_8cdd:   .db $da                     ; 4CDD:  da
b01_8cde:   asl a                       ; 4CDE:  0a
b01_8cdf:   lda (vm_ip_hi),y                 ; 4CDF:  b1 07
b01_8ce1:   .db ppumask_shadow                     ; 4CE1:  72
b01_8ce2:   .db $27                     ; 4CE2:  27
b01_8ce3:   .db $0b                     ; 4CE3:  0b
b01_8ce4:   bne $8d11                   ; 4CE4:  d0 2b
b01_8ce6:   .db $0b                     ; 4CE6:  0b
b01_8ce7:   .db $53                     ; 4CE7:  53
b01_8ce8:   dec $d7                     ; 4CE8:  c6 d7
b01_8cea:   iny                         ; 4CEA:  c8
b01_8ceb:   sty $093c                   ; 4CEB:  8c 3c 09
b01_8cee:   ldy $b3,x                   ; 4CEE:  b4 b3
b01_8cf0:   bcs $8cad                   ; 4CF0:  b0 bb
b01_8cf2:   lda ($3c),y                 ; 4CF2:  b1 3c
b01_8cf4:   asl a                       ; 4CF4:  0a
b01_8cf5:   ldy $b3,x                   ; 4CF5:  b4 b3
b01_8cf7:   bcs $8cb5                   ; 4CF7:  b0 bc
b01_8cf9:   lda ($aa),y                 ; 4CF9:  b1 aa
b01_8cfb:   .db $5f                     ; 4CFB:  5f
b01_8cfc:   .db p2_buttons                     ; 4CFC:  6f
b01_8cfd:   sbc #$15                    ; 4CFD:  e9 15
b01_8cff:   cld                         ; 4CFF:  d8
b01_8d00:   .db vm_sp_lo                     ; 4D00:  02
b01_8d01:   .db $cf                     ; 4D01:  cf
bribe_success_check:   jsr $e823                   ; 4D02:  20 23 e8
b01_8d05:   .db $fc                     ; 4D05:  fc
b01_8d06:   .db $ff                     ; 4D06:  ff
b01_8d07:   .db $3c                     ; 4D07:  3c
b01_8d08:   sbc #$da                    ; 4D08:  e9 da
b01_8d0a:   .db $d7                     ; 4D0A:  d7
b01_8d0b:   .db vm_sp_lo                     ; 4D0B:  02
b01_8d0c:   .db palette_dirty                     ; 4D0C:  74
b01_8d0d:   .db $d3                     ; 4D0D:  d3
b01_8d0e:   .db $b3                     ; 4D0E:  b3
b01_8d0f:   .db $0c                     ; 4D0F:  0c
b01_8d10:   .db $8b                     ; 4D10:  8b
b01_8d11:   .db $1a                     ; 4D11:  1a
b01_8d12:   lda $8c,x                   ; 4D12:  b5 8c
b01_8d14:   ora $bb70                   ; 4D14:  0d 70 bb
b01_8d17:   bcs $8ccd                   ; 4D17:  b0 b4
b01_8d19:   .db $bb                     ; 4D19:  bb
b01_8d1a:   .db $2b                     ; 4D1A:  2b
b01_8d1b:   and $dae9,x                 ; 4D1B:  3d e9 da
b01_8d1e:   .db $d7                     ; 4D1E:  d7
b01_8d1f:   .db vm_sp_lo                     ; 4D1F:  02
b01_8d20:   .db palette_dirty                     ; 4D20:  74
b01_8d21:   .db $d3                     ; 4D21:  d3
b01_8d22:   .db $b3                     ; 4D22:  b3
b01_8d23:   ora $1a8b                   ; 4D23:  0d 8b 1a
b01_8d26:   lda $8c,x                   ; 4D26:  b5 8c
b01_8d28:   ora $bb70                   ; 4D28:  0d 70 bb
b01_8d2b:   bcs $8ce0                   ; 4D2B:  b0 b3
b01_8d2d:   ror a                       ; 4D2D:  6a
b01_8d2e:   sbc #$52                    ; 4D2E:  e9 52
b01_8d30:   dex                         ; 4D30:  ca
b01_8d31:   .db vm_sp_lo                     ; 4D31:  02
b01_8d32:   ldx $63                     ; 4D32:  a6 63
b01_8d34:   adc $b4b5                   ; 4D34:  6d b5 b4
b01_8d37:   .db $bb                     ; 4D37:  bb
b01_8d38:   ldy $bb,x                   ; 4D38:  b4 bb
b01_8d3a:   rol a                       ; 4D3A:  2a
b01_8d3b:   .db $0b                     ; 4D3B:  0b
b01_8d3c:   .db $1a                     ; 4D3C:  1a
b01_8d3d:   cpy $d8                     ; 4D3D:  c4 d8
b01_8d3f:   .db $4b                     ; 4D3F:  4b
b01_8d40:   sta $e962                   ; 4D40:  8d 62 e9
b01_8d43:   .db $52                     ; 4D43:  52
b01_8d44:   dex                         ; 4D44:  ca
b01_8d45:   .db vm_sp_lo                     ; 4D45:  02
b01_8d46:   cld                         ; 4D46:  d8
b01_8d47:   .db $4b                     ; 4D47:  4b
b01_8d48:   sta $cf41                   ; 4D48:  8d 41 cf
b01_8d4b:   rti                         ; 4D4B:  40
b01_8d4c:   .db $cf                     ; 4D4C:  cf
effect_bribe:   jsr $e823                   ; 4D4D:  20 23 e8
b01_8d50:   .db $f4                     ; 4D50:  f4
b01_8d51:   .db $ff                     ; 4D51:  ff
b01_8d52:   ldy $63                     ; 4D52:  a4 63
b01_8d54:   .db p2_buttons                     ; 4D54:  6f
b01_8d55:   .db $8b                     ; 4D55:  8b
b01_8d56:   .db $1a                     ; 4D56:  1a
b01_8d57:   lda $8c,x                   ; 4D57:  b5 8c
b01_8d59:   ora #$70                    ; 4D59:  09 70
b01_8d5b:   .db $bb                     ; 4D5B:  bb
b01_8d5c:   and #$09                    ; 4D5C:  29 09
b01_8d5e:   .db palette_dirty                     ; 4D5E:  74
b01_8d5f:   .db $2b                     ; 4D5F:  2b
b01_8d60:   .db $0b                     ; 4D60:  0b
b01_8d61:   .db ppumask_shadow                     ; 4D61:  72
b01_8d62:   rol a                       ; 4D62:  2a
b01_8d63:   ldy $5f                     ; 4D63:  a4 5f
b01_8d65:   .db p2_buttons                     ; 4D65:  6f
b01_8d66:   .db $8b                     ; 4D66:  8b
b01_8d67:   .db $1a                     ; 4D67:  1a
b01_8d68:   lda $8c,x                   ; 4D68:  b5 8c
b01_8d6a:   ora ($70,x)                 ; 4D6A:  01 70
b01_8d6c:   .db $bb                     ; 4D6C:  bb
b01_8d6d:   plp                         ; 4D6D:  28
b01_8d6e:   tax                         ; 4D6E:  aa
b01_8d6f:   .db $63                     ; 4D6F:  63
b01_8d70:   .db p2_buttons                     ; 4D70:  6f
b01_8d71:   tax                         ; 4D71:  aa
b01_8d72:   .db $5f                     ; 4D72:  5f
b01_8d73:   .db p2_buttons                     ; 4D73:  6f
b01_8d74:   sbc #$02                    ; 4D74:  e9 02
b01_8d76:   sta $d804                   ; 4D76:  8d 04 d8
b01_8d79:   .db $bf                     ; 4D79:  bf
b01_8d7a:   sta $e93c                   ; 4D7A:  8d 3c e9
b01_8d7d:   cmp $02cb                   ; 4D7D:  cd cb 02
b01_8d80:   .db $27                     ; 4D80:  27
b01_8d81:   .db $37                     ; 4D81:  37
b01_8d82:   .db $3b                     ; 4D82:  3b
b01_8d83:   sbc #$c1                    ; 4D83:  e9 c1
b01_8d85:   .db $8b                     ; 4D85:  8b
b01_8d86:   .db vm_fp_lo                     ; 4D86:  04
b01_8d87:   .db $37                     ; 4D87:  37
b01_8d88:   ora #$b4                    ; 4D88:  09 b4
b01_8d8a:   .db $b3                     ; 4D8A:  b3
b01_8d8b:   bcs $8d49                   ; 4D8B:  b0 bc
b01_8d8d:   lda ($37),y                 ; 4D8D:  b1 37
b01_8d8f:   php                         ; 4D8F:  08
b01_8d90:   sei                         ; 4D90:  78
b01_8d91:   ldy $b3,x                   ; 4D91:  b4 b3
b01_8d93:   bcs $8d50                   ; 4D93:  b0 bb
b01_8d95:   lda ($60),y                 ; 4D95:  b1 60
b01_8d97:   sbc #$8f                    ; 4D97:  e9 8f
b01_8d99:   .db $8b                     ; 4D99:  8b
b01_8d9a:   .db vm_sp_lo                     ; 4D9A:  02
b01_8d9b:   sta $e91a                   ; 4D9B:  8d 1a e9
b01_8d9e:   .db $0c                     ; 4D9E:  0c
b01_8d9f:   inx                         ; 4D9F:  e8
b01_8da0:   .db vm_sp_lo                     ; 4DA0:  02
b01_8da1:   stx $bb3e                   ; 4DA1:  8e 3e bb
b01_8da4:   sbc #$26                    ; 4DA4:  e9 26
b01_8da6:   .db $d3                     ; 4DA6:  d3
b01_8da7:   .db vm_sp_lo                     ; 4DA7:  02
b01_8da8:   .db $37                     ; 4DA8:  37
b01_8da9:   stx $fc36                   ; 4DA9:  8e 36 fc
b01_8dac:   sbc #$34                    ; 4DAC:  e9 34
b01_8dae:   cmp (vm_fp_lo),y                 ; 4DAE:  d1 04
b01_8db0:   ldy $d766                   ; 4DB0:  ac 66 d7
b01_8db3:   tax                         ; 4DB3:  aa
b01_8db4:   .db $63                     ; 4DB4:  63
b01_8db5:   .db p2_buttons                     ; 4DB5:  6f
b01_8db6:   sbc #$f7                    ; 4DB6:  e9 f7
b01_8db8:   .db $d7                     ; 4DB8:  d7
b01_8db9:   .db vm_sp_lo                     ; 4DB9:  02
b01_8dba:   eor ($26,x)                 ; 4DBA:  41 26
b01_8dbc:   dec $e6,x                   ; 4DBC:  d6 e6
b01_8dbe:   sta $e961                   ; 4DBE:  8d 61 e9
b01_8dc1:   .db $8f                     ; 4DC1:  8f
b01_8dc2:   .db $8b                     ; 4DC2:  8b
b01_8dc3:   .db vm_sp_lo                     ; 4DC3:  02
b01_8dc4:   adc ($ac,x)                 ; 4DC4:  61 ac
b01_8dc6:   nop                         ; 4DC6:  ea
b01_8dc7:   .db $d7                     ; 4DC7:  d7
b01_8dc8:   .db palette_dirty                     ; 4DC8:  74
b01_8dc9:   ldy $b3,x                   ; 4DC9:  b4 b3
b01_8dcb:   .db $d3                     ; 4DCB:  d3
b01_8dcc:   ldy $8ed4,x                 ; 4DCC:  bc d4 8e
b01_8dcf:   bvc $8dcd                   ; 4DCF:  50 fc
b01_8dd1:   sbc #$c4                    ; 4DD1:  e9 c4
b01_8dd3:   dec $ac02                   ; 4DD3:  ce 02 ac
b01_8dd6:   ror $d7                     ; 4DD6:  66 d7
b01_8dd8:   rti                         ; 4DD8:  40
b01_8dd9:   rol $0c                     ; 4DD9:  26 0c
b01_8ddb:   .db $52                     ; 4DDB:  52
b01_8ddc:   ldx $b3,y                   ; 4DDC:  b6 b3
b01_8dde:   ora #$8f                    ; 4DDE:  09 8f
b01_8de0:   sed                         ; 4DE0:  f8
dedup_owners:   ldy $b3,x                   ; 4DE1:  b4 b3
b01_8de3:   bcs $8da0                   ; 4DE3:  b0 bb
b01_8de5:   lda ($3c),y                 ; 4DE5:  b1 3c
b01_8de7:   php                         ; 4DE7:  08
b01_8de8:   ldy $b3,x                   ; 4DE8:  b4 b3
b01_8dea:   bcs $8da8                   ; 4DEA:  b0 bc
b01_8dec:   lda ($aa),y                 ; 4DEC:  b1 aa
b01_8dee:   .db $5f                     ; 4DEE:  5f
b01_8def:   .db p2_buttons                     ; 4DEF:  6f
b01_8df0:   sbc #$36                    ; 4DF0:  e9 36
b01_8df2:   cld                         ; 4DF2:  d8
b01_8df3:   .db vm_sp_lo                     ; 4DF3:  02
b01_8df4:   tax                         ; 4DF4:  aa
b01_8df5:   .db $63                     ; 4DF5:  63
b01_8df6:   .db p2_buttons                     ; 4DF6:  6f
b01_8df7:   sbc #$36                    ; 4DF7:  e9 36
b01_8df9:   cld                         ; 4DF9:  d8
b01_8dfa:   .db vm_sp_lo                     ; 4DFA:  02
b01_8dfb:   asl $cf                     ; 4DFB:  06 cf
resolve_siege_assault_outcome:   jsr $e823                   ; 4DFD:  20 23 e8
b01_8e00:   dec $40ff,x                 ; 4E00:  de ff 40
b01_8e03:   .db $27                     ; 4E03:  27
b01_8e04:   ldy $d77e                   ; 4E04:  ac 7e d7
b01_8e07:   and #$aa                    ; 4E07:  29 aa
b01_8e09:   .db $63                     ; 4E09:  63
b01_8e0a:   .db p2_buttons                     ; 4E0A:  6f
b01_8e0b:   sbc #$72                    ; 4E0B:  e9 72
b01_8e0d:   .db $d7                     ; 4E0D:  d7
b01_8e0e:   .db vm_sp_lo                     ; 4E0E:  02
b01_8e0f:   plp                         ; 4E0F:  28
b01_8e10:   txa                         ; 4E10:  8a
b01_8e11:   .db $7f                     ; 4E11:  7f
b01_8e12:   .db p2_buttons                     ; 4E12:  6f
b01_8e13:   bit $a4                     ; 4E13:  24 a4
b01_8e15:   .db $5f                     ; 4E15:  5f
b01_8e16:   .db p2_buttons                     ; 4E16:  6f
b01_8e17:   .db $8b                     ; 4E17:  8b
b01_8e18:   .db $1a                     ; 4E18:  1a
b01_8e19:   lda $8c,x                   ; 4E19:  b5 8c
b01_8e1b:   .db $13                     ; 4E1B:  13
b01_8e1c:   bvs $8dd9                   ; 4E1C:  70 bb
b01_8e1e:   .db $23                     ; 4E1E:  23
b01_8e1f:   .db vm_sp_hi                     ; 4E1F:  03
b01_8e20:   .db ppumask_shadow                     ; 4E20:  72
b01_8e21:   .db $22                     ; 4E21:  22
b01_8e22:   .db vm_sp_lo                     ; 4E22:  02
b01_8e23:   .db ppumask_shadow                     ; 4E23:  72
b01_8e24:   and (vm_fp_lo,x)                 ; 4E24:  21 04
b01_8e26:   .db ppumask_shadow                     ; 4E26:  72
b01_8e27:   jsr $858a                   ; 4E27:  20 8a 85
b01_8e2a:   .db p2_buttons                     ; 4E2A:  6f
b01_8e2b:   sta $e6                     ; 4E2B:  85 e6
b01_8e2d:   ldy $63                     ; 4E2D:  a4 63
b01_8e2f:   .db p2_buttons                     ; 4E2F:  6f
b01_8e30:   .db $8b                     ; 4E30:  8b
b01_8e31:   .db $1a                     ; 4E31:  1a
b01_8e32:   lda $8c,x                   ; 4E32:  b5 8c
b01_8e34:   .db $13                     ; 4E34:  13
b01_8e35:   bvs $8df2                   ; 4E35:  70 bb
b01_8e37:   sta $e4                     ; 4E37:  85 e4
b01_8e39:   sta ($e4,x)                 ; 4E39:  81 e4
b01_8e3b:   .db ppumask_shadow                     ; 4E3B:  72
b01_8e3c:   sta $e2                     ; 4E3C:  85 e2
b01_8e3e:   sta ($e2,x)                 ; 4E3E:  81 e2
b01_8e40:   .db ppumask_shadow                     ; 4E40:  72
b01_8e41:   sta $e0                     ; 4E41:  85 e0
b01_8e43:   sta ($e6,x)                 ; 4E43:  81 e6
b01_8e45:   .db ppumask_shadow                     ; 4E45:  72
b01_8e46:   sta $de                     ; 4E46:  85 de
b01_8e48:   .db $62                     ; 4E48:  62
b01_8e49:   sbc #$0c                    ; 4E49:  e9 0c
b01_8e4b:   inx                         ; 4E4B:  e8
b01_8e4c:   .db vm_sp_lo                     ; 4E4C:  02
b01_8e4d:   ldy $63                     ; 4E4D:  a4 63
b01_8e4f:   .db p2_buttons                     ; 4E4F:  6f
b01_8e50:   sty fief_is_daimyo_capital                   ; 4E50:  8c a2 6d
b01_8e53:   .db $bb                     ; 4E53:  bb
b01_8e54:   .db $d3                     ; 4E54:  d3
b01_8e55:   .db $57                     ; 4E55:  57
b01_8e56:   lda $66a9,x                 ; 4E56:  bd a9 66
b01_8e59:   .db p2_buttons                     ; 4E59:  6f
b01_8e5a:   .db vm_sp_hi                     ; 4E5A:  03
b01_8e5b:   bcs $8e10                   ; 4E5B:  b0 b3
b01_8e5d:   .db vm_sp_lo                     ; 4E5D:  02
b01_8e5e:   bcs $8eb2                   ; 4E5E:  b0 52
b01_8e60:   ldx $b3,y                   ; 4E60:  b6 b3
b01_8e62:   ora (nmi_skip_all,x)                 ; 4E62:  01 b0
b01_8e64:   .db $52                     ; 4E64:  52
b01_8e65:   ldx $b4,y                   ; 4E65:  b6 b4
b01_8e67:   .db $bb                     ; 4E67:  bb
b01_8e68:   .db $d2                     ; 4E68:  d2
b01_8e69:   .db $b3                     ; 4E69:  b3
b01_8e6a:   brk                         ; 4E6A:  00
b01_8e6b:   bcs $8e20                   ; 4E6B:  b0 b3
b01_8e6d:   lda $65                     ; 4E6D:  a5 65
b01_8e6f:   .db p2_buttons                     ; 4E6F:  6f
b01_8e70:   sty skip_vblank_wait                   ; 4E70:  8c 80 00
b01_8e73:   .db $da                     ; 4E73:  da
b01_8e74:   bvc $8e37                   ; 4E74:  50 c1
b01_8e76:   .db ppumask_shadow                     ; 4E76:  72
b01_8e77:   ldy $b5,x                   ; 4E77:  b4 b5
b01_8e79:   ldy $bb,x                   ; 4E79:  b4 bb
b01_8e7b:   ldy $bb,x                   ; 4E7B:  b4 bb
b01_8e7d:   .db $2b                     ; 4E7D:  2b
b01_8e7e:   sta ($e4,x)                 ; 4E7E:  81 e4
b01_8e80:   bcs $8e35                   ; 4E80:  b0 b3
b01_8e82:   sta ($e2,x)                 ; 4E82:  81 e2
b01_8e84:   bcs $8ed8                   ; 4E84:  b0 52
b01_8e86:   ldx $b3,y                   ; 4E86:  b6 b3
b01_8e88:   sta ($e0,x)                 ; 4E88:  81 e0
b01_8e8a:   bcs $8ede                   ; 4E8A:  b0 52
b01_8e8c:   ldx $b4,y                   ; 4E8C:  b6 b4
b01_8e8e:   .db $bb                     ; 4E8E:  bb
b01_8e8f:   .db $d2                     ; 4E8F:  d2
b01_8e90:   .db $b3                     ; 4E90:  b3
b01_8e91:   sta ($de,x)                 ; 4E91:  81 de
b01_8e93:   bcs $8e48                   ; 4E93:  b0 b3
b01_8e95:   ldy $63                     ; 4E95:  a4 63
b01_8e97:   .db p2_buttons                     ; 4E97:  6f
b01_8e98:   sty fief_is_daimyo_capital                   ; 4E98:  8c a2 6d
b01_8e9b:   .db $bb                     ; 4E9B:  bb
b01_8e9c:   .db $d3                     ; 4E9C:  d3
b01_8e9d:   .db ppumask_shadow                     ; 4E9D:  72
b01_8e9e:   ldy $b5,x                   ; 4E9E:  b4 b5
b01_8ea0:   ldy $bb,x                   ; 4EA0:  b4 bb
b01_8ea2:   ldy $bb,x                   ; 4EA2:  b4 bb
b01_8ea4:   rol a                       ; 4EA4:  2a
b01_8ea5:   tax                         ; 4EA5:  aa
b01_8ea6:   .db $63                     ; 4EA6:  63
b01_8ea7:   .db p2_buttons                     ; 4EA7:  6f
b01_8ea8:   sbc #$da                    ; 4EA8:  e9 da
b01_8eaa:   .db $d7                     ; 4EAA:  d7
b01_8eab:   .db vm_sp_lo                     ; 4EAB:  02
b01_8eac:   and ppumask_shadow                     ; 4EAC:  25 72
b01_8eae:   .db $d3                     ; 4EAE:  d3
b01_8eaf:   .db $b3                     ; 4EAF:  b3
b01_8eb0:   ldy $d7ea                   ; 4EB0:  ac ea d7
b01_8eb3:   rol ppumask_shadow                     ; 4EB3:  26 72
b01_8eb5:   .db $d3                     ; 4EB5:  d3
b01_8eb6:   ldy $c2,x                   ; 4EB6:  b4 c2
b01_8eb8:   cld                         ; 4EB8:  d8
b01_8eb9:   .db $cb                     ; 4EB9:  cb
b01_8eba:   stx $816a                   ; 4EBA:  8e 6a 81
b01_8ebd:   cpx nmi_skip_all                     ; 4EBD:  e4 b0
b01_8ebf:   .db $b3                     ; 4EBF:  b3
b01_8ec0:   sbc #$0d                    ; 4EC0:  e9 0d
b01_8ec2:   .db $d7                     ; 4EC2:  d7
b01_8ec3:   .db vm_fp_lo                     ; 4EC3:  04
b01_8ec4:   cmp $bb0a                   ; 4EC4:  cd 0a bb
b01_8ec7:   rol a                       ; 4EC7:  2a
b01_8ec8:   dec $d7,x                   ; 4EC8:  d6 d7
b01_8eca:   stx $036a                   ; 4ECA:  8e 6a 03
b01_8ecd:   bcs $8e82                   ; 4ECD:  b0 b3
b01_8ecf:   sbc #$0d                    ; 4ECF:  e9 0d
b01_8ed1:   .db $d7                     ; 4ED1:  d7
b01_8ed2:   .db vm_fp_lo                     ; 4ED2:  04
b01_8ed3:   cmp $bb0b                   ; 4ED3:  cd 0b bb
b01_8ed6:   .db $2b                     ; 4ED6:  2b
b01_8ed7:   asl a                       ; 4ED7:  0a
b01_8ed8:   .db $1b                     ; 4ED8:  1b
b01_8ed9:   dec $d8                     ; 4ED9:  c6 d8
b01_8edb:   .db $f4                     ; 4EDB:  f4
b01_8edc:   stx $63a4                   ; 4EDC:  8e a4 63
b01_8edf:   .db p2_buttons                     ; 4EDF:  6f
b01_8ee0:   tay                         ; 4EE0:  a8
b01_8ee1:   .db $57                     ; 4EE1:  57
b01_8ee2:   .db p2_buttons                     ; 4EE2:  6f
b01_8ee3:   ldy $87                     ; 4EE3:  a4 87
b01_8ee5:   .db p2_buttons                     ; 4EE5:  6f
b01_8ee6:   .db $52                     ; 4EE6:  52
b01_8ee7:   ldx $b3,y                   ; 4EE7:  b6 b3
b01_8ee9:   brk                         ; 4EE9:  00
b01_8eea:   ldy $b3,x                   ; 4EEA:  b4 b3
b01_8eec:   bcs $8ea9                   ; 4EEC:  b0 bb
b01_8eee:   lda ($87),y                 ; 4EEE:  b1 87
b01_8ef0:   dec $08d6,x                 ; 4EF0:  de d6 08
b01_8ef3:   .db $8f                     ; 4EF3:  8f
b01_8ef4:   ldy $5f                     ; 4EF4:  a4 5f
b01_8ef6:   .db p2_buttons                     ; 4EF6:  6f
b01_8ef7:   tay                         ; 4EF7:  a8
b01_8ef8:   .db $57                     ; 4EF8:  57
b01_8ef9:   .db p2_buttons                     ; 4EF9:  6f
b01_8efa:   ldy nmi_busy                     ; 4EFA:  a4 81
b01_8efc:   .db p2_buttons                     ; 4EFC:  6f
b01_8efd:   .db $52                     ; 4EFD:  52
b01_8efe:   ldx $b3,y                   ; 4EFE:  b6 b3
b01_8f00:   sta ($de,x)                 ; 4F00:  81 de
b01_8f02:   ldy $b3,x                   ; 4F02:  b4 b3
b01_8f04:   bcs $8ec1                   ; 4F04:  b0 bb
b01_8f06:   lda ($30),y                 ; 4F06:  b1 30
b01_8f08:   rti                         ; 4F08:  40
b01_8f09:   lda ($a4),y                 ; 4F09:  b1 a4
b01_8f0b:   .db $57                     ; 4F0B:  57
b01_8f0c:   .db p2_buttons                     ; 4F0C:  6f
b01_8f0d:   ldx $5f                     ; 4F0D:  a6 5f
b01_8f0f:   .db p2_buttons                     ; 4F0F:  6f
b01_8f10:   cpy #$d8                    ; 4F10:  c0 d8
b01_8f12:   .db $42                     ; 4F12:  42
b01_8f13:   .db $8f                     ; 4F13:  8f
b01_8f14:   lda $65                     ; 4F14:  a5 65
b01_8f16:   .db p2_buttons                     ; 4F16:  6f
b01_8f17:   sty skip_vblank_wait                   ; 4F17:  8c 80 00
b01_8f1a:   .db $da                     ; 4F1A:  da
b01_8f1b:   cld                         ; 4F1B:  d8
b01_8f1c:   lda ($8f,x)                 ; 4F1C:  a1 8f
b01_8f1e:   asl prg_bank_shadow                     ; 4F1E:  06 73
b01_8f20:   .db $d3                     ; 4F20:  d3
b01_8f21:   .db $5a                     ; 4F21:  5a
b01_8f22:   ldx $b3,y                   ; 4F22:  b6 b3
b01_8f24:   sbc #$52                    ; 4F24:  e9 52
b01_8f26:   dex                         ; 4F26:  ca
b01_8f27:   .db vm_sp_lo                     ; 4F27:  02
b01_8f28:   cld                         ; 4F28:  d8
b01_8f29:   rol $408f,x                 ; 4F29:  3e 8f 40
b01_8f2c:   lda #$65                    ; 4F2C:  a9 65
b01_8f2e:   .db p2_buttons                     ; 4F2E:  6f
b01_8f2f:   ldy $5f                     ; 4F2F:  a4 5f
b01_8f31:   .db p2_buttons                     ; 4F31:  6f
b01_8f32:   sty fief_is_daimyo_capital                   ; 4F32:  8c a2 6d
b01_8f35:   .db $bb                     ; 4F35:  bb
b01_8f36:   .db $b3                     ; 4F36:  b3
b01_8f37:   eor ($d4,x)                 ; 4F37:  41 d4
b01_8f39:   .db $43                     ; 4F39:  43
b01_8f3a:   .db $27                     ; 4F3A:  27
b01_8f3b:   dec $a1,x                   ; 4F3B:  d6 a1
b01_8f3d:   .db $8f                     ; 4F3D:  8f
b01_8f3e:   eor ($d6,x)                 ; 4F3E:  41 d6
b01_8f40:   .db $3a                     ; 4F40:  3a
b01_8f41:   .db $8f                     ; 4F41:  8f
b01_8f42:   ldy $63                     ; 4F42:  a4 63
b01_8f44:   .db p2_buttons                     ; 4F44:  6f
b01_8f45:   sty fief_is_daimyo_capital                   ; 4F45:  8c a2 6d
b01_8f48:   .db $bb                     ; 4F48:  bb
b01_8f49:   .db $d3                     ; 4F49:  d3
b01_8f4a:   cld                         ; 4F4A:  d8
b01_8f4b:   lda ($8f,x)                 ; 4F4B:  a1 8f
b01_8f4d:   stx selected_province_idx                   ; 4F4D:  8e 5f 6f
b01_8f50:   stx battle_defending_province                   ; 4F50:  8e 63 6f
b01_8f53:   sbc #$94                    ; 4F53:  e9 94
b01_8f55:   .db $cb                     ; 4F55:  cb
b01_8f56:   .db vm_fp_lo                     ; 4F56:  04
b01_8f57:   ldy $dad7                   ; 4F57:  ac d7 da
b01_8f5a:   stx deduped_owner_list                   ; 4F5A:  8e 4f 6f
b01_8f5d:   adc ($e9,x)                 ; 4F5D:  61 e9
b01_8f5f:   .db $3a                     ; 4F5F:  3a
b01_8f60:   cmp $a504,x                 ; 4F60:  dd 04 a5
b01_8f63:   .db $4f                     ; 4F63:  4f
b01_8f64:   .db p2_buttons                     ; 4F64:  6f
b01_8f65:   sty $00ff                   ; 4F65:  8c ff 00
b01_8f68:   cmp ($d8,x)                 ; 4F68:  c1 d8
b01_8f6a:   sta $8f,x                   ; 4F6A:  95 8f
b01_8f6c:   ora prg_bank_shadow                     ; 4F6C:  05 73
b01_8f6e:   .db $d3                     ; 4F6E:  d3
b01_8f6f:   .db $5a                     ; 4F6F:  5a
b01_8f70:   ldx $b3,y                   ; 4F70:  b6 b3
b01_8f72:   sbc #$52                    ; 4F72:  e9 52
b01_8f74:   dex                         ; 4F74:  ca
b01_8f75:   .db vm_sp_lo                     ; 4F75:  02
b01_8f76:   cld                         ; 4F76:  d8
b01_8f77:   sta $8f,x                   ; 4F77:  95 8f
b01_8f79:   ldy $5f                     ; 4F79:  a4 5f
b01_8f7b:   .db p2_buttons                     ; 4F7B:  6f
b01_8f7c:   sty fief_is_daimyo_capital                   ; 4F7C:  8c a2 6d
b01_8f7f:   .db $bb                     ; 4F7F:  bb
b01_8f80:   .db $b3                     ; 4F80:  b3
b01_8f81:   rti                         ; 4F81:  40
b01_8f82:   .db $d4                     ; 4F82:  d4
b01_8f83:   lda $4f                     ; 4F83:  a5 4f
b01_8f85:   .db p2_buttons                     ; 4F85:  6f
b01_8f86:   sty fief_is_daimyo_capital                   ; 4F86:  8c a2 6d
b01_8f89:   .db $bb                     ; 4F89:  bb
b01_8f8a:   .db $b3                     ; 4F8A:  b3
b01_8f8b:   eor ($d4,x)                 ; 4F8B:  41 d4
b01_8f8d:   rti                         ; 4F8D:  40
b01_8f8e:   lda #$66                    ; 4F8E:  a9 66
b01_8f90:   .db p2_buttons                     ; 4F90:  6f
b01_8f91:   .db $44                     ; 4F91:  44
b01_8f92:   dec $96,x                   ; 4F92:  d6 96
b01_8f94:   .db $8f                     ; 4F94:  8f
b01_8f95:   .db $42                     ; 4F95:  42
b01_8f96:   .db $27                     ; 4F96:  27
b01_8f97:   stx selected_province_idx                   ; 4F97:  8e 5f 6f
b01_8f9a:   stx battle_defending_province                   ; 4F9A:  8e 63 6f
b01_8f9d:   sbc #$94                    ; 4F9D:  e9 94
b01_8f9f:   .db $cb                     ; 4F9F:  cb
b01_8fa0:   .db vm_fp_lo                     ; 4FA0:  04
b01_8fa1:   tax                         ; 4FA1:  aa
b01_8fa2:   .db $57                     ; 4FA2:  57
b01_8fa3:   .db p2_buttons                     ; 4FA3:  6f
b01_8fa4:   sbc #$72                    ; 4FA4:  e9 72
b01_8fa6:   .db $d7                     ; 4FA6:  d7
b01_8fa7:   .db vm_sp_lo                     ; 4FA7:  02
b01_8fa8:   eor $8cb5,y                 ; 4FA8:  59 b5 8c
b01_8fab:   tay                         ; 4FAB:  a8
b01_8fac:   .db $77                     ; 4FAC:  77
b01_8fad:   .db $bb                     ; 4FAD:  bb
b01_8fae:   .db $b3                     ; 4FAE:  b3
b01_8faf:   sbc #$26                    ; 4FAF:  e9 26
b01_8fb1:   .db $d3                     ; 4FB1:  d3
b01_8fb2:   .db vm_sp_lo                     ; 4FB2:  02
b01_8fb3:   stx $bb3f                   ; 4FB3:  8e 3f bb
b01_8fb6:   sbc #$c4                    ; 4FB6:  e9 c4
b01_8fb8:   dec $ac02                   ; 4FB8:  ce 02 ac
b01_8fbb:   ror $d7                     ; 4FBB:  66 d7
b01_8fbd:   .db vm_ip_hi                     ; 4FBD:  07
b01_8fbe:   cmp $ff,x                   ; 4FBE:  d5 ff
b01_8fc0:   .db $ff                     ; 4FC0:  ff
b01_8fc1:   .db vm_fp_lo                     ; 4FC1:  04
b01_8fc2:   brk                         ; 4FC2:  00
b01_8fc3:   .db $d4                     ; 4FC3:  d4
b01_8fc4:   .db $8f                     ; 4FC4:  8f
b01_8fc5:   cmp $d88f                   ; 4FC5:  cd 8f d8
b01_8fc8:   .db $8f                     ; 4FC8:  8f
b01_8fc9:   dec $f78f,x                 ; 4FC9:  de 8f f7
b01_8fcc:   .db $8f                     ; 4FCC:  8f
b01_8fcd:   tax                         ; 4FCD:  aa
b01_8fce:   .db $5f                     ; 4FCE:  5f
b01_8fcf:   .db p2_buttons                     ; 4FCF:  6f
b01_8fd0:   sbc #$75                    ; 4FD0:  e9 75
b01_8fd2:   .db $e2                     ; 4FD2:  e2
b01_8fd3:   .db vm_sp_lo                     ; 4FD3:  02
b01_8fd4:   ldy $e03c                   ; 4FD4:  ac 3c e0
b01_8fd7:   .db $cf                     ; 4FD7:  cf
b01_8fd8:   tax                         ; 4FD8:  aa
b01_8fd9:   .db $63                     ; 4FD9:  63
b01_8fda:   .db p2_buttons                     ; 4FDA:  6f
b01_8fdb:   dec $d0,x                   ; 4FDB:  d6 d0
b01_8fdd:   .db $8f                     ; 4FDD:  8f
b01_8fde:   ora #$59                    ; 4FDE:  09 59
b01_8fe0:   lda $8c,x                   ; 4FE0:  b5 8c
b01_8fe2:   tay                         ; 4FE2:  a8
b01_8fe3:   .db $77                     ; 4FE3:  77
b01_8fe4:   .db $bb                     ; 4FE4:  bb
b01_8fe5:   .db $b3                     ; 4FE5:  b3
b01_8fe6:   sbc #$26                    ; 4FE6:  e9 26
b01_8fe8:   .db $d3                     ; 4FE8:  d3
b01_8fe9:   .db vm_sp_lo                     ; 4FE9:  02
b01_8fea:   stx $bb49                   ; 4FEA:  8e 49 bb
b01_8fed:   sbc #$c4                    ; 4FED:  e9 c4
b01_8fef:   dec $ac02                   ; 4FEF:  ce 02 ac
b01_8ff2:   ror $d7                     ; 4FF2:  66 d7
b01_8ff4:   dec $d4,x                   ; 4FF4:  d6 d4
b01_8ff6:   .db $8f                     ; 4FF6:  8f
b01_8ff7:   php                         ; 4FF7:  08
b01_8ff8:   eor $8cb5,y                 ; 4FF8:  59 b5 8c
b01_8ffb:   tay                         ; 4FFB:  a8
b01_8ffc:   .db $77                     ; 4FFC:  77
b01_8ffd:   .db $bb                     ; 4FFD:  bb
b01_8ffe:   .db $b3                     ; 4FFE:  b3
b01_8fff:   sbc #$26                    ; 4FFF:  e9 26
b01_9001:   .db $d3                     ; 5001:  d3
b01_9002:   .db vm_sp_lo                     ; 5002:  02
b01_9003:   stx $bb58                   ; 5003:  8e 58 bb
b01_9006:   dec $ed,x                   ; 5006:  d6 ed
b01_9008:   .db $8f                     ; 5008:  8f
ai_attack_announce_prompt:   jsr $e823                   ; 5009:  20 23 e8
b01_900c:   brk                         ; 500C:  00
b01_900d:   brk                         ; 500D:  00
b01_900e:   ldy $d77e                   ; 500E:  ac 7e d7
b01_9011:   eor $8cb5,y                 ; 5011:  59 b5 8c
b01_9014:   tay                         ; 5014:  a8
b01_9015:   .db $77                     ; 5015:  77
b01_9016:   .db $bb                     ; 5016:  bb
b01_9017:   .db $b3                     ; 5017:  b3
b01_9018:   sbc #$26                    ; 5018:  e9 26
b01_901a:   .db $d3                     ; 501A:  d3
b01_901b:   .db vm_sp_lo                     ; 501B:  02
b01_901c:   ldy $5f                     ; 501C:  a4 5f
b01_901e:   .db p2_buttons                     ; 501E:  6f
b01_901f:   bne $8fd4                   ; 501F:  d0 b3
b01_9021:   stx $bb62                   ; 5021:  8e 62 bb
b01_9024:   sbc #$34                    ; 5024:  e9 34
b01_9026:   cmp (vm_fp_lo),y                 ; 5026:  d1 04
b01_9028:   ldy $63                     ; 5028:  a4 63
b01_902a:   .db p2_buttons                     ; 502A:  6f
b01_902b:   bne $8fe0                   ; 502B:  d0 b3
b01_902d:   tax                         ; 502D:  aa
b01_902e:   .db $63                     ; 502E:  63
b01_902f:   .db p2_buttons                     ; 502F:  6f
b01_9030:   sbc #$72                    ; 5030:  e9 72
b01_9032:   .db $d7                     ; 5032:  d7
b01_9033:   .db vm_sp_lo                     ; 5033:  02
b01_9034:   eor $8cb5,y                 ; 5034:  59 b5 8c
b01_9037:   tay                         ; 5037:  a8
b01_9038:   .db $77                     ; 5038:  77
b01_9039:   .db $bb                     ; 5039:  bb
b01_903a:   .db $b3                     ; 503A:  b3
b01_903b:   stx $bb76                   ; 503B:  8e 76 bb
b01_903e:   sbc #$34                    ; 503E:  e9 34
b01_9040:   cmp (vm_ip_lo),y                 ; 5040:  d1 06
b01_9042:   ldy $d766                   ; 5042:  ac 66 d7
b01_9045:   .db $cf                     ; 5045:  cf
ai_commit_attack_deduct_resources:   jsr $e823                   ; 5046:  20 23 e8
b01_9049:   .db $fa                     ; 5049:  fa
b01_904a:   .db $ff                     ; 504A:  ff
b01_904b:   rti                         ; 504B:  40
b01_904c:   tay                         ; 504C:  a8
b01_904d:   adc $a46f,y                 ; 504D:  79 6f a4
b01_9050:   .db $5f                     ; 5050:  5f
b01_9051:   .db p2_buttons                     ; 5051:  6f
b01_9052:   sty rest_turns_remaining                   ; 5052:  8c 67 6d
b01_9055:   .db $bb                     ; 5055:  bb
b01_9056:   .db $d3                     ; 5056:  d3
b01_9057:   .db $d7                     ; 5057:  d7
b01_9058:   .db p2_buttons                     ; 5058:  6f
b01_9059:   bcc $8fff                   ; 5059:  90 a4
b01_905b:   .db $5f                     ; 505B:  5f
b01_905c:   .db p2_buttons                     ; 505C:  6f
b01_905d:   sty fief_is_daimyo_capital                   ; 505D:  8c a2 6d
b01_9060:   .db $bb                     ; 5060:  bb
b01_9061:   .db $d3                     ; 5061:  d3
b01_9062:   cld                         ; 5062:  d8
b01_9063:   .db p2_buttons                     ; 5063:  6f
b01_9064:   bcc $90c8                   ; 5064:  90 62
b01_9066:   sbc #$52                    ; 5066:  e9 52
b01_9068:   dex                         ; 5068:  ca
b01_9069:   .db vm_sp_lo                     ; 5069:  02
b01_906a:   .db $57                     ; 506A:  57
b01_906b:   lda $70d6,x                 ; 506B:  bd d6 70
b01_906e:   bcc $90b0                   ; 506E:  90 40
b01_9070:   lda #$65                    ; 5070:  a9 65
b01_9072:   .db p2_buttons                     ; 5072:  6f
b01_9073:   ldy $5f                     ; 5073:  a4 5f
b01_9075:   .db p2_buttons                     ; 5075:  6f
b01_9076:   .db $8b                     ; 5076:  8b
b01_9077:   .db $1a                     ; 5077:  1a
b01_9078:   lda $8c,x                   ; 5078:  b5 8c
b01_907a:   ora ($70,x)                 ; 507A:  01 70
b01_907c:   .db $bb                     ; 507C:  bb
b01_907d:   .db $2b                     ; 507D:  2b
b01_907e:   .db $0b                     ; 507E:  0b
b01_907f:   bcs $9034                   ; 507F:  b0 b3
b01_9081:   .db $0b                     ; 5081:  0b
b01_9082:   .db $8f                     ; 5082:  8f
b01_9083:   bpl $9035                   ; 5083:  10 b0
b01_9085:   .db $b3                     ; 5085:  b3
b01_9086:   sbc #$5e                    ; 5086:  e9 5e
b01_9088:   .db $cb                     ; 5088:  cb
b01_9089:   .db vm_fp_lo                     ; 5089:  04
b01_908a:   .db $b3                     ; 508A:  b3
b01_908b:   .db $0b                     ; 508B:  0b
b01_908c:   ror nmi_skip_all,x                   ; 508C:  76 b0
b01_908e:   .db $d2                     ; 508E:  d2
b01_908f:   .db $b3                     ; 508F:  b3
b01_9090:   sbc #$5e                    ; 5090:  e9 5e
b01_9092:   .db $cb                     ; 5092:  cb
b01_9093:   .db vm_fp_lo                     ; 5093:  04
b01_9094:   rol a                       ; 5094:  2a
b01_9095:   asl a                       ; 5095:  0a
b01_9096:   eor $c2,x                   ; 5096:  55 c2
b01_9098:   cld                         ; 5098:  d8
b01_9099:   sta $4090,x                 ; 5099:  9d 90 40
b01_909c:   .db $cf                     ; 509C:  cf
b01_909d:   ldy $63                     ; 509D:  a4 63
b01_909f:   .db p2_buttons                     ; 509F:  6f
b01_90a0:   .db $8b                     ; 50A0:  8b
b01_90a1:   .db $1a                     ; 50A1:  1a
b01_90a2:   lda $8c,x                   ; 50A2:  b5 8c
b01_90a4:   ora ($70),y                 ; 50A4:  11 70
b01_90a6:   .db $bb                     ; 50A6:  bb
b01_90a7:   bcs $905c                   ; 50A7:  b0 b3
b01_90a9:   ldy $63                     ; 50A9:  a4 63
b01_90ab:   .db p2_buttons                     ; 50AB:  6f
b01_90ac:   .db $8b                     ; 50AC:  8b
b01_90ad:   .db $1a                     ; 50AD:  1a
b01_90ae:   lda $8c,x                   ; 50AE:  b5 8c
b01_90b0:   .db vm_ip_hi                     ; 50B0:  07
b01_90b1:   bvs $906e                   ; 50B1:  70 bb
b01_90b3:   bcs $9068                   ; 50B3:  b0 b3
b01_90b5:   sbc #$5e                    ; 50B5:  e9 5e
b01_90b7:   .db $cb                     ; 50B7:  cb
b01_90b8:   .db vm_fp_lo                     ; 50B8:  04
b01_90b9:   .db $1a                     ; 50B9:  1a
b01_90ba:   cpy $d8                     ; 50BA:  c4 d8
b01_90bc:   cpy #$90                    ; 50BC:  c0 90
b01_90be:   rti                         ; 50BE:  40
b01_90bf:   .db $cf                     ; 50BF:  cf
b01_90c0:   tax                         ; 50C0:  aa
b01_90c1:   .db $5f                     ; 50C1:  5f
b01_90c2:   .db p2_buttons                     ; 50C2:  6f
b01_90c3:   tax                         ; 50C3:  aa
b01_90c4:   .db $63                     ; 50C4:  63
b01_90c5:   .db p2_buttons                     ; 50C5:  6f
b01_90c6:   sbc #$71                    ; 50C6:  e9 71
b01_90c8:   .db $82                     ; 50C8:  82
b01_90c9:   .db vm_fp_lo                     ; 50C9:  04
b01_90ca:   cld                         ; 50CA:  d8
b01_90cb:   .db $cf                     ; 50CB:  cf
b01_90cc:   bcc $910e                   ; 50CC:  90 40
b01_90ce:   .db $cf                     ; 50CE:  cf
b01_90cf:   lda $65                     ; 50CF:  a5 65
b01_90d1:   .db p2_buttons                     ; 50D1:  6f
b01_90d2:   .db $d7                     ; 50D2:  d7
b01_90d3:   cpx #$90                    ; 50D3:  e0 90
b01_90d5:   sta $e914                   ; 50D5:  8d 14 e9
b01_90d8:   .db $52                     ; 50D8:  52
b01_90d9:   dex                         ; 50D9:  ca
b01_90da:   .db vm_sp_lo                     ; 50DA:  02
b01_90db:   .db $8f                     ; 50DB:  8f
b01_90dc:   .db $32                     ; 50DC:  32
b01_90dd:   dec $e8,x                   ; 50DD:  d6 e8
b01_90df:   bcc $906e                   ; 50DF:  90 8d
b01_90e1:   asl $52e9,x                 ; 50E1:  1e e9 52
b01_90e4:   dex                         ; 50E4:  ca
b01_90e5:   .db vm_sp_lo                     ; 50E5:  02
b01_90e6:   .db $8f                     ; 50E6:  8f
b01_90e7:   .db $3c                     ; 50E7:  3c
b01_90e8:   .db $b3                     ; 50E8:  b3
b01_90e9:   .db $3a                     ; 50E9:  3a
b01_90ea:   sbc #$0d                    ; 50EA:  e9 0d
b01_90ec:   .db $d7                     ; 50EC:  d7
b01_90ed:   .db vm_fp_lo                     ; 50ED:  04
b01_90ee:   and #$09                    ; 50EE:  29 09
b01_90f0:   tay                         ; 50F0:  a8
b01_90f1:   sta (p2_buttons,x)                 ; 50F1:  81 6f
b01_90f3:   tay                         ; 50F3:  a8
b01_90f4:   adc $396f,x                 ; 50F4:  7d 6f 39
b01_90f7:   .db $0b                     ; 50F7:  0b
b01_90f8:   ldy $b3,x                   ; 50F8:  b4 b3
b01_90fa:   bcs $90b8                   ; 50FA:  b0 bc
b01_90fc:   lda ($39),y                 ; 50FC:  b1 39
b01_90fe:   .db $0b                     ; 50FE:  0b
b01_90ff:   .db $8f                     ; 50FF:  8f
b01_9100:   bpl $90b6                   ; 5100:  10 b4
b01_9102:   .db $b3                     ; 5102:  b3
b01_9103:   bcs $90c1                   ; 5103:  b0 bc
b01_9105:   lda ($39),y                 ; 5105:  b1 39
b01_9107:   .db $0b                     ; 5107:  0b
b01_9108:   ror nmi_skip_all,x                   ; 5108:  76 b0
b01_910a:   .db $b3                     ; 510A:  b3
b01_910b:   sbc #$de                    ; 510B:  e9 de
b01_910d:   dec vm_fp_lo,x                   ; 510D:  d6 04
b01_910f:   .db $8b                     ; 510F:  8b
b01_9110:   .db $37                     ; 5110:  37
b01_9111:   iny                         ; 5111:  c8
b01_9112:   cld                         ; 5112:  d8
b01_9113:   ora $0991,y                 ; 5113:  19 91 09
b01_9116:   dec $30,x                   ; 5116:  d6 30
b01_9118:   sta ($6a),y                 ; 5118:  91 6a
b01_911a:   sbc #$52                    ; 511A:  e9 52
b01_911c:   dex                         ; 511C:  ca
b01_911d:   .db vm_sp_lo                     ; 511D:  02
b01_911e:   .db $8f                     ; 511E:  8f
b01_911f:   .db $32                     ; 511F:  32
b01_9120:   .db $b3                     ; 5120:  b3
b01_9121:   and $0de9,y                 ; 5121:  39 e9 0d
b01_9124:   .db $d7                     ; 5124:  d7
b01_9125:   .db vm_fp_lo                     ; 5125:  04
b01_9126:   .db $b3                     ; 5126:  b3
b01_9127:   .db $0b                     ; 5127:  0b
b01_9128:   ror nmi_skip_all,x                   ; 5128:  76 b0
b01_912a:   cmp ($b3),y                 ; 512A:  d1 b3
b01_912c:   sbc #$5e                    ; 512C:  e9 5e
b01_912e:   .db $cb                     ; 512E:  cb
b01_912f:   .db vm_fp_lo                     ; 512F:  04
b01_9130:   tay                         ; 5130:  a8
b01_9131:   .db $7f                     ; 5131:  7f
b01_9132:   .db p2_buttons                     ; 5132:  6f
b01_9133:   tax                         ; 5133:  aa
b01_9134:   .db $7f                     ; 5134:  7f
b01_9135:   .db p2_buttons                     ; 5135:  6f
b01_9136:   .db $0b                     ; 5136:  0b
b01_9137:   ror $b4,x                   ; 5137:  76 b4
b01_9139:   .db $b3                     ; 5139:  b3
b01_913a:   bcs $90f8                   ; 513A:  b0 bc
b01_913c:   lda ($a4),y                 ; 513C:  b1 a4
b01_913e:   adc $d76e,x                 ; 513E:  7d 6e d7
b01_9141:   .db $4f                     ; 5141:  4f
b01_9142:   sta ($aa),y                 ; 5142:  91 aa
b01_9144:   .db $63                     ; 5144:  63
b01_9145:   .db p2_buttons                     ; 5145:  6f
b01_9146:   sbc #$8d                    ; 5146:  e9 8d
b01_9148:   cmp $5502,y                 ; 5148:  d9 02 55
b01_914b:   cpy #$d8                    ; 514B:  c0 d8
b01_914d:   eor $ac91,y                 ; 514D:  59 91 ac
b01_9150:   ora #$90                    ; 5150:  09 90
b01_9152:   eor ($a8,x)                 ; 5152:  41 a8
b01_9154:   adc $d66f,y                 ; 5154:  79 6f d6
b01_9157:   .db $7f                     ; 5157:  7f
b01_9158:   sta ($a4),y                 ; 5158:  91 a4
b01_915a:   .db $63                     ; 515A:  63
b01_915b:   .db p2_buttons                     ; 515B:  6f
b01_915c:   .db $8b                     ; 515C:  8b
b01_915d:   .db $1a                     ; 515D:  1a
b01_915e:   lda $8c,x                   ; 515E:  b5 8c
b01_9160:   ora ($70,x)                 ; 5160:  01 70
b01_9162:   .db $bb                     ; 5162:  bb
b01_9163:   .db $2b                     ; 5163:  2b
b01_9164:   bcs $910e                   ; 5164:  b0 a8
b01_9166:   .db clock_a_hi                     ; 5166:  83
b01_9167:   .db p2_buttons                     ; 5167:  6f
b01_9168:   .db $0b                     ; 5168:  0b
b01_9169:   ror nmi_skip_all,x                   ; 5169:  76 b0
b01_916b:   tay                         ; 516B:  a8
b01_916c:   sta p2_buttons                     ; 516C:  85 6f
b01_916e:   .db $0b                     ; 516E:  0b
b01_916f:   .db $8f                     ; 516F:  8f
b01_9170:   bpl $9122                   ; 5170:  10 b0
b01_9172:   tay                         ; 5172:  a8
b01_9173:   .db $87                     ; 5173:  87
b01_9174:   .db p2_buttons                     ; 5174:  6f
b01_9175:   rti                         ; 5175:  40
b01_9176:   tay                         ; 5176:  a8
b01_9177:   adc $ac6f,y                 ; 5177:  79 6f ac
b01_917a:   ora #$90                    ; 517A:  09 90
b01_917c:   ldy $8dfd                   ; 517C:  ac fd 8d
b01_917f:   eor ($cf,x)                 ; 517F:  41 cf
decrement_byte_at:   jsr $e823                   ; 5181:  20 23 e8
b01_9184:   brk                         ; 5184:  00
b01_9185:   brk                         ; 5185:  00
b01_9186:   adc ($3c,x)                 ; 5186:  61 3c
b01_9188:   sbc #$12                    ; 5188:  e9 12
b01_918a:   dex                         ; 518A:  ca
b01_918b:   .db vm_fp_lo                     ; 518B:  04
b01_918c:   .db $cf                     ; 518C:  cf
ninja_mission_resolve_vs_defender:   jsr $e823                   ; 518D:  20 23 e8
b01_9190:   cpx $acff                   ; 5190:  ec ff ac
b01_9193:   nop                         ; 5193:  ea
b01_9194:   .db $d7                     ; 5194:  d7
b01_9195:   .db $23                     ; 5195:  23
b01_9196:   .db palette_dirty                     ; 5196:  74
b01_9197:   and $aa                     ; 5197:  25 aa
b01_9199:   .db $63                     ; 5199:  63
b01_919a:   .db p2_buttons                     ; 519A:  6f
b01_919b:   sbc #$8d                    ; 519B:  e9 8d
b01_919d:   cmp $d702,y                 ; 519D:  d9 02 d7
b01_91a0:   .db $e3                     ; 51A0:  e3
b01_91a1:   .db $92                     ; 51A1:  92
b01_91a2:   rti                         ; 51A2:  40
b01_91a3:   and #$a4                    ; 51A3:  29 a4
b01_91a5:   .db $63                     ; 51A5:  63
b01_91a6:   .db p2_buttons                     ; 51A6:  6f
b01_91a7:   .db $8b                     ; 51A7:  8b
b01_91a8:   .db $1a                     ; 51A8:  1a
b01_91a9:   lda $8c,x                   ; 51A9:  b5 8c
b01_91ab:   ora ($70),y                 ; 51AB:  11 70
b01_91ad:   .db $bb                     ; 51AD:  bb
b01_91ae:   .db $2b                     ; 51AE:  2b
b01_91af:   tax                         ; 51AF:  aa
b01_91b0:   .db $63                     ; 51B0:  63
b01_91b1:   .db p2_buttons                     ; 51B1:  6f
b01_91b2:   sbc #$da                    ; 51B2:  e9 da
b01_91b4:   .db $d7                     ; 51B4:  d7
b01_91b5:   .db vm_sp_lo                     ; 51B5:  02
b01_91b6:   .db $22                     ; 51B6:  22
b01_91b7:   bne $91dd                   ; 51B7:  d0 24
b01_91b9:   .db vm_fp_lo                     ; 51B9:  04
b01_91ba:   .db ppumask_shadow                     ; 51BA:  72
b01_91bb:   .db $27                     ; 51BB:  27
b01_91bc:   .db vm_ip_hi                     ; 51BC:  07
b01_91bd:   bne $91e5                   ; 51BD:  d0 26
b01_91bf:   .db vm_sp_hi                     ; 51BF:  03
b01_91c0:   adc $d3,x                   ; 51C0:  75 d3
b01_91c2:   .db $b3                     ; 51C2:  b3
b01_91c3:   ora $d3                     ; 51C3:  05 d3
b01_91c5:   ldy $bb,x                   ; 51C5:  b4 bb
b01_91c7:   .db $b3                     ; 51C7:  b3
b01_91c8:   .db vm_sp_lo                     ; 51C8:  02
b01_91c9:   adc $d3,x                   ; 51C9:  75 d3
b01_91cb:   .db $b3                     ; 51CB:  b3
b01_91cc:   asl $d3                     ; 51CC:  06 d3
b01_91ce:   ldy $bb,x                   ; 51CE:  b4 bb
b01_91d0:   ldy $c3,x                   ; 51D0:  b4 c3
b01_91d2:   cld                         ; 51D2:  d8
b01_91d3:   .db $e3                     ; 51D3:  e3
b01_91d4:   .db $92                     ; 51D4:  92
b01_91d5:   ldy $63                     ; 51D5:  a4 63
b01_91d7:   adc $b55a                   ; 51D7:  6d 5a b5
b01_91da:   .db $b3                     ; 51DA:  b3
b01_91db:   sbc #$52                    ; 51DB:  e9 52
b01_91dd:   dex                         ; 51DD:  ca
b01_91de:   .db vm_sp_lo                     ; 51DE:  02
b01_91df:   .db $b3                     ; 51DF:  b3
b01_91e0:   ora $d3                     ; 51E0:  05 d3
b01_91e2:   ldy $bc,x                   ; 51E2:  b4 bc
b01_91e4:   .db $b3                     ; 51E4:  b3
b01_91e5:   ldy $63                     ; 51E5:  a4 63
b01_91e7:   adc $b55a                   ; 51E7:  6d 5a b5
b01_91ea:   .db $b3                     ; 51EA:  b3
b01_91eb:   sbc #$52                    ; 51EB:  e9 52
b01_91ed:   dex                         ; 51ED:  ca
b01_91ee:   .db vm_sp_lo                     ; 51EE:  02
b01_91ef:   .db $b3                     ; 51EF:  b3
b01_91f0:   asl $d3                     ; 51F0:  06 d3
b01_91f2:   ldy $bc,x                   ; 51F2:  b4 bc
b01_91f4:   ldy $c4,x                   ; 51F4:  b4 c4
b01_91f6:   cld                         ; 51F6:  d8
b01_91f7:   .db $13                     ; 51F7:  13
b01_91f8:   .db $92                     ; 51F8:  92
b01_91f9:   .db vm_sp_hi                     ; 51F9:  03
b01_91fa:   bne $9220                   ; 51FA:  d0 24
b01_91fc:   ora $26                     ; 51FC:  05 26
b01_91fe:   ldy $5f                     ; 51FE:  a4 5f
b01_9200:   .db p2_buttons                     ; 5200:  6f
b01_9201:   .db $8b                     ; 5201:  8b
b01_9202:   .db $1a                     ; 5202:  1a
b01_9203:   lda $8c,x                   ; 5203:  b5 8c
b01_9205:   ora ($70),y                 ; 5205:  11 70
b01_9207:   .db $bb                     ; 5207:  bb
b01_9208:   .db $2b                     ; 5208:  2b
b01_9209:   .db vm_fp_lo                     ; 5209:  04
b01_920a:   .db ppumask_shadow                     ; 520A:  72
b01_920b:   .db $27                     ; 520B:  27
b01_920c:   eor ($29,x)                 ; 520C:  41 29
b01_920e:   and $e9,x                   ; 520E:  35 e9
b01_9210:   sta ($91,x)                 ; 5210:  81 91
b01_9212:   .db vm_sp_lo                     ; 5212:  02
b01_9213:   eor ($28,x)                 ; 5213:  41 28
b01_9215:   ror a                       ; 5215:  6a
b01_9216:   sbc #$52                    ; 5216:  e9 52
b01_9218:   dex                         ; 5218:  ca
b01_9219:   .db vm_sp_lo                     ; 5219:  02
b01_921a:   bne $91cf                   ; 521A:  d0 b3
b01_921c:   .db $0b                     ; 521C:  0b
b01_921d:   bcs $91d3                   ; 521D:  b0 b4
b01_921f:   .db $c3                     ; 521F:  c3
b01_9220:   cld                         ; 5220:  d8
b01_9221:   rts                         ; 5221:  60
b01_9222:   .db $92                     ; 5222:  92
b01_9223:   asl $d3                     ; 5223:  06 d3
b01_9225:   .db $b3                     ; 5225:  b3
b01_9226:   sbc #$52                    ; 5226:  e9 52
b01_9228:   dex                         ; 5228:  ca
b01_9229:   .db vm_sp_lo                     ; 5229:  02
b01_922a:   .db $8f                     ; 522A:  8f
b01_922b:   .db $32                     ; 522B:  32
b01_922c:   rol a                       ; 522C:  2a
b01_922d:   .db $8b                     ; 522D:  8b
b01_922e:   .db $64                     ; 522E:  64
b01_922f:   cpy $d8                     ; 522F:  c4 d8
b01_9231:   rol $92,x                   ; 5231:  36 92
b01_9233:   .db skip_wallclock                     ; 5233:  89
b01_9234:   .db $64                     ; 5234:  64
b01_9235:   rol a                       ; 5235:  2a
b01_9236:   .db vm_ip_hi                     ; 5236:  07
b01_9237:   .db $d3                     ; 5237:  d3
b01_9238:   .db $5a                     ; 5238:  5a
b01_9239:   ldx $b3,y                   ; 5239:  b6 b3
b01_923b:   sbc #$52                    ; 523B:  e9 52
b01_923d:   dex                         ; 523D:  ca
b01_923e:   .db vm_sp_lo                     ; 523E:  02
b01_923f:   .db $b3                     ; 523F:  b3
b01_9240:   .db $3a                     ; 5240:  3a
b01_9241:   .db $0b                     ; 5241:  0b
b01_9242:   bcs $91f7                   ; 5242:  b0 b3
b01_9244:   sbc #$0d                    ; 5244:  e9 0d
b01_9246:   .db $d7                     ; 5246:  d7
b01_9247:   .db vm_fp_lo                     ; 5247:  04
b01_9248:   .db $b3                     ; 5248:  b3
b01_9249:   .db $0c                     ; 5249:  0c
b01_924a:   ldy $b6,x                   ; 524A:  b4 b6
b01_924c:   ldy $c3,x                   ; 524C:  b4 c3
b01_924e:   cld                         ; 524E:  d8
b01_924f:   rts                         ; 524F:  60
b01_9250:   .db $92                     ; 5250:  92
b01_9251:   .db vm_ip_hi                     ; 5251:  07
b01_9252:   .db $d3                     ; 5252:  d3
b01_9253:   .db $8b                     ; 5253:  8b
b01_9254:   .db $64                     ; 5254:  64
b01_9255:   ldx $b3,y                   ; 5255:  b6 b3
b01_9257:   sbc #$52                    ; 5257:  e9 52
b01_9259:   dex                         ; 5259:  ca
b01_925a:   .db vm_sp_lo                     ; 525A:  02
b01_925b:   cld                         ; 525B:  d8
b01_925c:   rts                         ; 525C:  60
b01_925d:   .db $92                     ; 525D:  92
b01_925e:   rti                         ; 525E:  40
b01_925f:   plp                         ; 525F:  28
b01_9260:   php                         ; 5260:  08
b01_9261:   cld                         ; 5261:  d8
b01_9262:   ldy $0992,x                 ; 5262:  bc 92 09
b01_9265:   bne $921a                   ; 5265:  d0 b3
b01_9267:   .db vm_fp_lo                     ; 5267:  04
b01_9268:   .db $d3                     ; 5268:  d3
b01_9269:   ldy $b8,x                   ; 5269:  b4 b8
b01_926b:   .db $b3                     ; 526B:  b3
b01_926c:   sbc #$52                    ; 526C:  e9 52
b01_926e:   dex                         ; 526E:  ca
b01_926f:   .db vm_sp_lo                     ; 526F:  02
b01_9270:   bne $9225                   ; 5270:  d0 b3
b01_9272:   .db $34                     ; 5272:  34
b01_9273:   sbc #$12                    ; 5273:  e9 12
b01_9275:   dex                         ; 5275:  ca
b01_9276:   .db vm_fp_lo                     ; 5276:  04
b01_9277:   ora #$d8                    ; 5277:  09 d8
b01_9279:   sta ($92,x)                 ; 5279:  81 92
b01_927b:   stx $bb8d                   ; 527B:  8e 8d bb
b01_927e:   dec clock_a_lo,x                   ; 527E:  d6 84
b01_9280:   .db $92                     ; 5280:  92
b01_9281:   stx $fbbb                   ; 5281:  8e bb fb
b01_9284:   sbc #$c4                    ; 5284:  e9 c4
b01_9286:   dec $ac02                   ; 5286:  ce 02 ac
b01_9289:   ror $d7                     ; 5289:  66 d7
b01_928b:   adc ($e9,x)                 ; 528B:  61 e9
b01_928d:   .db $0c                     ; 528D:  0c
b01_928e:   inx                         ; 528E:  e8
b01_928f:   .db vm_sp_lo                     ; 528F:  02
b01_9290:   .db vm_fp_lo                     ; 5290:  04
b01_9291:   .db $d3                     ; 5291:  d3
b01_9292:   .db $b3                     ; 5292:  b3
b01_9293:   txa                         ; 5293:  8a
b01_9294:   inc scratch_ptr_lo                     ; 5294:  e6 00
b01_9296:   ldy $c4,x                   ; 5296:  b4 c4
b01_9298:   .db $d7                     ; 5298:  d7
b01_9299:   ldy #$92                    ; 5299:  a0 92
b01_929b:   .db vm_fp_lo                     ; 529B:  04
b01_929c:   .db $d3                     ; 529C:  d3
b01_929d:   .db $d7                     ; 529D:  d7
b01_929e:   .db $f2                     ; 529E:  f2
b01_929f:   .db $92                     ; 529F:  92
b01_92a0:   ora #$d7                    ; 52A0:  09 d7
b01_92a2:   .db $f2                     ; 52A2:  f2
b01_92a3:   .db $92                     ; 52A3:  92
b01_92a4:   .db $34                     ; 52A4:  34
b01_92a5:   rti                         ; 52A5:  40
b01_92a6:   .db $d4                     ; 52A6:  d4
b01_92a7:   ldy $63                     ; 52A7:  a4 63
b01_92a9:   .db p2_buttons                     ; 52A9:  6f
b01_92aa:   sty fief_is_daimyo_capital                   ; 52AA:  8c a2 6d
b01_92ad:   .db $bb                     ; 52AD:  bb
b01_92ae:   .db $d3                     ; 52AE:  d3
b01_92af:   cld                         ; 52AF:  d8
b01_92b0:   cmp $aa92,y                 ; 52B0:  d9 92 aa
b01_92b3:   .db $63                     ; 52B3:  63
b01_92b4:   .db p2_buttons                     ; 52B4:  6f
b01_92b5:   sbc #$25                    ; 52B5:  e9 25
b01_92b7:   cpx vm_sp_lo                     ; 52B7:  e4 02
b01_92b9:   dec $f2,x                   ; 52B9:  d6 f2
b01_92bb:   .db $92                     ; 52BB:  92
b01_92bc:   .db vm_fp_lo                     ; 52BC:  04
b01_92bd:   .db $b3                     ; 52BD:  b3
b01_92be:   .db $d3                     ; 52BE:  d3
b01_92bf:   cmp ($d4),y                 ; 52BF:  d1 d4
b01_92c1:   ora #$d8                    ; 52C1:  09 d8
b01_92c3:   .db $e3                     ; 52C3:  e3
b01_92c4:   .db $92                     ; 52C4:  92
b01_92c5:   stx $bb8d                   ; 52C5:  8e 8d bb
b01_92c8:   sbc #$c4                    ; 52C8:  e9 c4
b01_92ca:   dec $8e02                   ; 52CA:  ce 02 8e
b01_92cd:   .db $9e                     ; 52CD:  9e
b01_92ce:   .db $bb                     ; 52CE:  bb
b01_92cf:   sbc #$c4                    ; 52CF:  e9 c4
b01_92d1:   dec $ac02                   ; 52D1:  ce 02 ac
b01_92d4:   ror $d7                     ; 52D4:  66 d7
b01_92d6:   dec palette_alt,x                   ; 52D6:  d6 90
b01_92d8:   .db $92                     ; 52D8:  92
b01_92d9:   tax                         ; 52D9:  aa
b01_92da:   .db $63                     ; 52DA:  63
b01_92db:   .db p2_buttons                     ; 52DB:  6f
b01_92dc:   sbc #$54                    ; 52DC:  e9 54
b01_92de:   cpx vm_sp_lo                     ; 52DE:  e4 02
b01_92e0:   dec $f2,x                   ; 52E0:  d6 f2
b01_92e2:   .db $92                     ; 52E2:  92
b01_92e3:   and $e9,x                   ; 52E3:  35 e9
b01_92e5:   sta ($91,x)                 ; 52E5:  81 91
b01_92e7:   .db vm_sp_lo                     ; 52E7:  02
b01_92e8:   stx $bbb2                   ; 52E8:  8e b2 bb
b01_92eb:   sbc #$c4                    ; 52EB:  e9 c4
b01_92ed:   dec $ac02                   ; 52ED:  ce 02 ac
b01_92f0:   ror $d7                     ; 52F0:  66 d7
b01_92f2:   tax                         ; 52F2:  aa
b01_92f3:   .db $5f                     ; 52F3:  5f
b01_92f4:   .db p2_buttons                     ; 52F4:  6f
b01_92f5:   sbc #$36                    ; 52F5:  e9 36
b01_92f7:   cld                         ; 52F7:  d8
b01_92f8:   .db vm_sp_lo                     ; 52F8:  02
b01_92f9:   tax                         ; 52F9:  aa
b01_92fa:   .db $63                     ; 52FA:  63
b01_92fb:   .db p2_buttons                     ; 52FB:  6f
b01_92fc:   sbc #$36                    ; 52FC:  e9 36
b01_92fe:   cld                         ; 52FE:  d8
b01_92ff:   .db vm_sp_lo                     ; 52FF:  02
b01_9300:   .db $cf                     ; 5300:  cf
war_prep_clamp_depleted_field_notify:   jsr $e823                   ; 5301:  20 23 e8
b01_9304:   brk                         ; 5304:  00
b01_9305:   brk                         ; 5305:  00
b01_9306:   asl $50b0                   ; 5306:  0e b0 50
b01_9309:   .db $c3                     ; 5309:  c3
b01_930a:   cld                         ; 530A:  d8
b01_930b:   jsr $3e93                   ; 530B:  20 93 3e
b01_930e:   rti                         ; 530E:  40
b01_930f:   lda ($3d),y                 ; 530F:  b1 3d
b01_9311:   sbc #$8d                    ; 5311:  e9 8d
b01_9313:   cmp $d802,y                 ; 5313:  d9 02 d8
b01_9316:   jsr $3c93                   ; 5316:  20 93 3c
b01_9319:   sbc #$26                    ; 5319:  e9 26
b01_931b:   .db $d3                     ; 531B:  d3
b01_931c:   .db vm_sp_lo                     ; 531C:  02
b01_931d:   ldy $d766                   ; 531D:  ac 66 d7
b01_9320:   asl $cfb0                   ; 5320:  0e b0 cf
effect_war_combat_prep_a:   jsr $e823                   ; 5323:  20 23 e8
b01_9326:   brk                         ; 5326:  00
b01_9327:   brk                         ; 5327:  00
b01_9328:   .db $0c                     ; 5328:  0c
b01_9329:   .db $8b                     ; 5329:  8b
b01_932a:   .db $1a                     ; 532A:  1a
b01_932b:   lda $8c,x                   ; 532B:  b5 8c
b01_932d:   .db vm_ip_hi                     ; 532D:  07
b01_932e:   bvs $92eb                   ; 532E:  70 bb
b01_9330:   .db $b3                     ; 5330:  b3
b01_9331:   .db $3c                     ; 5331:  3c
b01_9332:   stx $fdeb                   ; 5332:  8e eb fd
b01_9335:   sbc #$01                    ; 5335:  e9 01
b01_9337:   .db $93                     ; 5337:  93
b01_9338:   asl $cf                     ; 5338:  06 cf
effect_war_combat_prep_b:   jsr $e823                   ; 533A:  20 23 e8
b01_933d:   brk                         ; 533D:  00
b01_933e:   brk                         ; 533E:  00
b01_933f:   .db $0c                     ; 533F:  0c
b01_9340:   .db $8b                     ; 5340:  8b
b01_9341:   .db $1a                     ; 5341:  1a
b01_9342:   lda $8c,x                   ; 5342:  b5 8c
b01_9344:   ora ($70),y                 ; 5344:  11 70
b01_9346:   .db $bb                     ; 5346:  bb
b01_9347:   .db $b3                     ; 5347:  b3
b01_9348:   .db $3c                     ; 5348:  3c
b01_9349:   stx $fdfd                   ; 5349:  8e fd fd
b01_934c:   sbc #$01                    ; 534C:  e9 01
b01_934e:   .db $93                     ; 534E:  93
b01_934f:   asl $cf                     ; 534F:  06 cf
effect_war_combat_prep_c:   jsr $e823                   ; 5351:  20 23 e8
b01_9354:   brk                         ; 5354:  00
b01_9355:   brk                         ; 5355:  00
b01_9356:   .db $0c                     ; 5356:  0c
b01_9357:   .db $8b                     ; 5357:  8b
b01_9358:   .db $1a                     ; 5358:  1a
b01_9359:   lda $8c,x                   ; 5359:  b5 8c
b01_935b:   ora ($70,x)                 ; 535B:  01 70
b01_935d:   .db $bb                     ; 535D:  bb
b01_935e:   .db $b3                     ; 535E:  b3
b01_935f:   .db $3c                     ; 535F:  3c
b01_9360:   stx $fdd9                   ; 5360:  8e d9 fd
b01_9363:   sbc #$01                    ; 5363:  e9 01
b01_9365:   .db $93                     ; 5365:  93
b01_9366:   asl $cf                     ; 5366:  06 cf
effect_war_combat_prep_d:   jsr $e823                   ; 5368:  20 23 e8
b01_936b:   inc $3cff,x                 ; 536B:  fe ff 3c
b01_936e:   sbc #$72                    ; 536E:  e9 72
b01_9370:   cmp $2b02,y                 ; 5370:  d9 02 2b
b01_9373:   cld                         ; 5373:  d8
b01_9374:   .db skip_vblank_wait                     ; 5374:  80
b01_9375:   .db $93                     ; 5375:  93
b01_9376:   stx $fad6                   ; 5376:  8e d6 fa
b01_9379:   sbc #$c4                    ; 5379:  e9 c4
b01_937b:   dec $ac02                   ; 537B:  ce 02 ac
b01_937e:   ror $d7                     ; 537E:  66 d7
b01_9380:   .db $0b                     ; 5380:  0b
b01_9381:   .db $cf                     ; 5381:  cf
fief_men_if_provisioned:   jsr $e823                   ; 5382:  20 23 e8
b01_9385:   inc $0cff,x                 ; 5385:  fe ff 0c
b01_9388:   .db $8b                     ; 5388:  8b
b01_9389:   .db $1a                     ; 5389:  1a
b01_938a:   lda $8c,x                   ; 538A:  b5 8c
b01_938c:   ora ($70,x)                 ; 538C:  01 70
b01_938e:   .db $bb                     ; 538E:  bb
b01_938f:   .db $2b                     ; 538F:  2b
b01_9390:   .db $0b                     ; 5390:  0b
b01_9391:   ror nmi_skip_all,x                   ; 5391:  76 b0
b01_9393:   .db $d7                     ; 5393:  d7
b01_9394:   tya                         ; 5394:  98
b01_9395:   .db $93                     ; 5395:  93
b01_9396:   rti                         ; 5396:  40
b01_9397:   .db $cf                     ; 5397:  cf
b01_9398:   .db $0b                     ; 5398:  0b
b01_9399:   .db $8f                     ; 5399:  8f
b01_939a:   bpl $934c                   ; 539A:  10 b0
b01_939c:   .db $cf                     ; 539C:  cf
fief_men_ratio_pct:   jsr $e823                   ; 539D:  20 23 e8
b01_93a0:   brk                         ; 53A0:  00
b01_93a1:   brk                         ; 53A1:  00
b01_93a2:   and $82e9,x                 ; 53A2:  3d e9 82
b01_93a5:   .db $93                     ; 53A5:  93
b01_93a6:   .db vm_sp_lo                     ; 53A6:  02
b01_93a7:   .db $b3                     ; 53A7:  b3
b01_93a8:   .db $3c                     ; 53A8:  3c
b01_93a9:   sbc #$82                    ; 53A9:  e9 82
b01_93ab:   .db $93                     ; 53AB:  93
b01_93ac:   .db vm_sp_lo                     ; 53AC:  02
b01_93ad:   .db $b3                     ; 53AD:  b3
b01_93ae:   sbc #$de                    ; 53AE:  e9 de
b01_93b0:   dec vm_fp_lo,x                   ; 53B0:  d6 04
b01_93b2:   .db $cf                     ; 53B2:  cf
pick_weakest_men_fief:   jsr $e823                   ; 53B3:  20 23 e8
b01_93b6:   inc $0cff,x                 ; 53B6:  fe ff 0c
b01_93b9:   .db $d3                     ; 53B9:  d3
b01_93ba:   .db $2b                     ; 53BA:  2b
b01_93bb:   dec $d2,x                   ; 53BB:  d6 d2
b01_93bd:   .db $93                     ; 53BD:  93
b01_93be:   .db $0c                     ; 53BE:  0c
b01_93bf:   .db $d3                     ; 53BF:  d3
b01_93c0:   .db $b3                     ; 53C0:  b3
b01_93c1:   .db $3b                     ; 53C1:  3b
b01_93c2:   sbc #$9d                    ; 53C2:  e9 9d
b01_93c4:   .db $93                     ; 53C4:  93
b01_93c5:   .db vm_fp_lo                     ; 53C5:  04
b01_93c6:   .db $8b                     ; 53C6:  8b
b01_93c7:   .db $32                     ; 53C7:  32
b01_93c8:   iny                         ; 53C8:  c8
b01_93c9:   cld                         ; 53C9:  d8
b01_93ca:   .db $cf                     ; 53CA:  cf
b01_93cb:   .db $93                     ; 53CB:  93
b01_93cc:   .db $0c                     ; 53CC:  0c
b01_93cd:   .db $d3                     ; 53CD:  d3
b01_93ce:   .db $2b                     ; 53CE:  2b
b01_93cf:   .db $0c                     ; 53CF:  0c
b01_93d0:   bne $93fe                   ; 53D0:  d0 2c
b01_93d2:   .db $0c                     ; 53D2:  0c
b01_93d3:   .db $d3                     ; 53D3:  d3
b01_93d4:   sty $00ff                   ; 53D4:  8c ff 00
b01_93d7:   cmp ($d7,x)                 ; 53D7:  c1 d7
b01_93d9:   ldx $0b93,y                 ; 53D9:  be 93 0b
b01_93dc:   .db $cf                     ; 53DC:  cf
ai_relations_and_low_drive_skip_gate:   jsr $e823                   ; 53DD:  20 23 e8
b01_93e0:   brk                         ; 53E0:  00
b01_93e1:   brk                         ; 53E1:  00
b01_93e2:   sta $e964                   ; 53E2:  8d 64 e9
b01_93e5:   .db $52                     ; 53E5:  52
b01_93e6:   dex                         ; 53E6:  ca
b01_93e7:   .db vm_sp_lo                     ; 53E7:  02
b01_93e8:   .db $b3                     ; 53E8:  b3
b01_93e9:   rts                         ; 53E9:  60
b01_93ea:   tax                         ; 53EA:  aa
b01_93eb:   .db $5f                     ; 53EB:  5f
b01_93ec:   .db p2_buttons                     ; 53EC:  6f
b01_93ed:   .db $3c                     ; 53ED:  3c
b01_93ee:   sbc #$50                    ; 53EE:  e9 50
b01_93f0:   .db $82                     ; 53F0:  82
b01_93f1:   asl $b4                     ; 53F1:  06 b4
b01_93f3:   iny                         ; 53F3:  c8
b01_93f4:   .db $d7                     ; 53F4:  d7
b01_93f5:   .db $12                     ; 53F5:  12
b01_93f6:   sty $8d,x                   ; 53F6:  94 8d
b01_93f8:   .db $64                     ; 53F8:  64
b01_93f9:   sbc #$52                    ; 53F9:  e9 52
b01_93fb:   dex                         ; 53FB:  ca
b01_93fc:   .db vm_sp_lo                     ; 53FC:  02
b01_93fd:   .db $b3                     ; 53FD:  b3
b01_93fe:   adc ($ac,x)                 ; 53FE:  61 ac
b01_9400:   ror $b3d7,x                 ; 5400:  7e d7 b3
b01_9403:   .db $3c                     ; 5403:  3c
b01_9404:   sbc #$72                    ; 5404:  e9 72
b01_9406:   .db $d7                     ; 5406:  d7
b01_9407:   .db vm_sp_lo                     ; 5407:  02
b01_9408:   .db $b3                     ; 5408:  b3
b01_9409:   sbc #$50                    ; 5409:  e9 50
b01_940b:   .db $82                     ; 540B:  82
b01_940c:   asl $b4                     ; 540C:  06 b4
b01_940e:   iny                         ; 540E:  c8
b01_940f:   cld                         ; 540F:  d8
b01_9410:   ora $ac94,x                 ; 5410:  1d 94 ac
b01_9413:   nop                         ; 5413:  ea
b01_9414:   .db $d7                     ; 5414:  d7
b01_9415:   .db ppumask_shadow                     ; 5415:  72
b01_9416:   .db $d3                     ; 5416:  d3
b01_9417:   .db $8b                     ; 5417:  8b
b01_9418:   .db $32                     ; 5418:  32
b01_9419:   .db $c2                     ; 5419:  c2
b01_941a:   .db $d7                     ; 541A:  d7
b01_941b:   and ($94,x)                 ; 541B:  21 94
b01_941d:   rti                         ; 541D:  40
b01_941e:   dec $22,x                   ; 541E:  d6 22
b01_9420:   sty $41,x                   ; 5420:  94 41
b01_9422:   .db $cf                     ; 5422:  cf
pick_ai_attack_target_fief:   jsr $e823                   ; 5423:  20 23 e8
b01_9426:   inc $0cff,x                 ; 5426:  fe ff 0c
b01_9429:   .db $d3                     ; 5429:  d3
b01_942a:   .db $2b                     ; 542A:  2b
b01_942b:   dec $52,x                   ; 542B:  d6 52
b01_942d:   sty $3b,x                   ; 542D:  94 3b
b01_942f:   sbc #$8d                    ; 542F:  e9 8d
b01_9431:   cmp $d802,y                 ; 5431:  d9 02 d8
b01_9434:   .db $4f                     ; 5434:  4f
b01_9435:   sty $3b,x                   ; 5435:  94 3b
b01_9437:   sbc #$dd                    ; 5437:  e9 dd
b01_9439:   .db $93                     ; 5439:  93
b01_943a:   .db vm_sp_lo                     ; 543A:  02
b01_943b:   .db $d7                     ; 543B:  d7
b01_943c:   .db $4f                     ; 543C:  4f
b01_943d:   sty $0c,x                   ; 543D:  94 0c
b01_943f:   .db $d3                     ; 543F:  d3
b01_9440:   .db $b3                     ; 5440:  b3
b01_9441:   .db $3b                     ; 5441:  3b
b01_9442:   sbc #$9d                    ; 5442:  e9 9d
b01_9444:   .db $93                     ; 5444:  93
b01_9445:   .db vm_fp_lo                     ; 5445:  04
b01_9446:   .db $8b                     ; 5446:  8b
b01_9447:   .db $32                     ; 5447:  32
b01_9448:   iny                         ; 5448:  c8
b01_9449:   cld                         ; 5449:  d8
b01_944a:   .db $4f                     ; 544A:  4f
b01_944b:   sty $0c,x                   ; 544B:  94 0c
b01_944d:   .db $d3                     ; 544D:  d3
b01_944e:   .db $2b                     ; 544E:  2b
b01_944f:   .db $0c                     ; 544F:  0c
b01_9450:   bne $947e                   ; 5450:  d0 2c
b01_9452:   .db $0c                     ; 5452:  0c
b01_9453:   .db $d3                     ; 5453:  d3
b01_9454:   sty $00ff                   ; 5454:  8c ff 00
b01_9457:   cmp ($d7,x)                 ; 5457:  c1 d7
b01_9459:   rol $0b94                   ; 5459:  2e 94 0b
b01_945c:   .db $cf                     ; 545C:  cf
find_fief_by_owner_men_minority:   jsr $e823                   ; 545D:  20 23 e8
b01_9460:   inc $0dff,x                 ; 5460:  fe ff 0d
b01_9463:   sty $00ff                   ; 5463:  8c ff 00
b01_9466:   cmp ($d8,x)                 ; 5466:  c1 d8
b01_9468:   stx $94,y                   ; 5468:  96 94
b01_946a:   .db $0c                     ; 546A:  0c
b01_946b:   .db $d3                     ; 546B:  d3
b01_946c:   .db $2b                     ; 546C:  2b
b01_946d:   dec $8d,x                   ; 546D:  d6 8d
b01_946f:   sty $3b,x                   ; 546F:  94 3b
b01_9471:   sbc #$72                    ; 5471:  e9 72
b01_9473:   .db $d7                     ; 5473:  d7
b01_9474:   .db vm_sp_lo                     ; 5474:  02
b01_9475:   ora $d8c0,x                 ; 5475:  1d c0 d8
b01_9478:   txa                         ; 5478:  8a
b01_9479:   sty $aa,x                   ; 5479:  94 aa
b01_947b:   .db $5f                     ; 547B:  5f
b01_947c:   .db p2_buttons                     ; 547C:  6f
b01_947d:   .db $3b                     ; 547D:  3b
b01_947e:   sbc #$9d                    ; 547E:  e9 9d
b01_9480:   .db $93                     ; 5480:  93
b01_9481:   .db vm_fp_lo                     ; 5481:  04
b01_9482:   .db $8b                     ; 5482:  8b
b01_9483:   .db $32                     ; 5483:  32
b01_9484:   cmp #$d8                    ; 5484:  c9 d8
b01_9486:   stx $94,y                   ; 5486:  96 94
b01_9488:   .db $0b                     ; 5488:  0b
b01_9489:   .db $cf                     ; 5489:  cf
b01_948a:   .db $0c                     ; 548A:  0c
b01_948b:   bne $94b9                   ; 548B:  d0 2c
b01_948d:   .db $0c                     ; 548D:  0c
b01_948e:   .db $d3                     ; 548E:  d3
b01_948f:   sty $00ff                   ; 548F:  8c ff 00
b01_9492:   cmp ($d7,x)                 ; 5492:  c1 d7
b01_9494:   bvs $942a                   ; 5494:  70 94
b01_9496:   txa                         ; 5496:  8a
b01_9497:   .db $ff                     ; 5497:  ff
b01_9498:   brk                         ; 5498:  00
b01_9499:   .db $cf                     ; 5499:  cf
ai_try_war_attack:   jsr $e823                   ; 549A:  20 23 e8
b01_949d:   .db $f4                     ; 549D:  f4
b01_949e:   .db $ff                     ; 549E:  ff
b01_949f:   ldy $5f                     ; 549F:  a4 5f
b01_94a1:   .db p2_buttons                     ; 54A1:  6f
b01_94a2:   .db $2b                     ; 54A2:  2b
b01_94a3:   ldy $5f                     ; 54A3:  a4 5f
b01_94a5:   .db p2_buttons                     ; 54A5:  6f
b01_94a6:   .db $8b                     ; 54A6:  8b
b01_94a7:   .db $1a                     ; 54A7:  1a
b01_94a8:   lda $8c,x                   ; 54A8:  b5 8c
b01_94aa:   ora ($70,x)                 ; 54AA:  01 70
b01_94ac:   .db $bb                     ; 54AC:  bb
b01_94ad:   .db $27                     ; 54AD:  27
b01_94ae:   .db $3b                     ; 54AE:  3b
b01_94af:   sbc #$72                    ; 54AF:  e9 72
b01_94b1:   cmp $d702,y                 ; 54B1:  d9 02 d7
b01_94b4:   .db $c3                     ; 54B4:  c3
b01_94b5:   sty vm_ip_hi,x                   ; 54B5:  94 07
b01_94b7:   .db $8f                     ; 54B7:  8f
b01_94b8:   bpl $946a                   ; 54B8:  10 b0
b01_94ba:   cld                         ; 54BA:  d8
b01_94bb:   .db $c3                     ; 54BB:  c3
b01_94bc:   sty vm_ip_hi,x                   ; 54BC:  94 07
b01_94be:   ror nmi_skip_all,x                   ; 54BE:  76 b0
b01_94c0:   .db $d7                     ; 54C0:  d7
b01_94c1:   cmp $94                     ; 54C1:  c5 94
b01_94c3:   rti                         ; 54C3:  40
b01_94c4:   .db $cf                     ; 54C4:  cf
b01_94c5:   ldy $dad7                   ; 54C5:  ac d7 da
b01_94c8:   stx deduped_owner_list                   ; 54C8:  8e 4f 6f
b01_94cb:   rts                         ; 54CB:  60
b01_94cc:   sbc #$3a                    ; 54CC:  e9 3a
b01_94ce:   cmp $8e04,x                 ; 54CE:  dd 04 8e
b01_94d1:   .db $4f                     ; 54D1:  4f
b01_94d2:   .db p2_buttons                     ; 54D2:  6f
b01_94d3:   sbc #$b3                    ; 54D3:  e9 b3
b01_94d5:   .db $93                     ; 54D5:  93
b01_94d6:   .db vm_sp_lo                     ; 54D6:  02
b01_94d7:   rol a                       ; 54D7:  2a
b01_94d8:   asl a                       ; 54D8:  0a
b01_94d9:   sty $00ff                   ; 54D9:  8c ff 00
b01_94dc:   cpy #$d8                    ; 54DC:  c0 d8
b01_94de:   .db $e2                     ; 54DE:  e2
b01_94df:   sty $40,x                   ; 54DF:  94 40
b01_94e1:   .db $cf                     ; 54E1:  cf
b01_94e2:   stx deduped_owner_list                   ; 54E2:  8e 4f 6f
b01_94e5:   sbc #$23                    ; 54E5:  e9 23
b01_94e7:   sty vm_sp_lo,x                   ; 54E7:  94 02
b01_94e9:   and #$a4                    ; 54E9:  29 a4
b01_94eb:   .db $5f                     ; 54EB:  5f
b01_94ec:   .db p2_buttons                     ; 54EC:  6f
b01_94ed:   sty list_remove_matching_list                   ; 54ED:  8c 7f 6e
b01_94f0:   .db $bb                     ; 54F0:  bb
b01_94f1:   .db $d3                     ; 54F1:  d3
b01_94f2:   .db $b3                     ; 54F2:  b3
b01_94f3:   stx deduped_owner_list                   ; 54F3:  8e 4f 6f
b01_94f6:   sbc #$5d                    ; 54F6:  e9 5d
b01_94f8:   sty vm_fp_lo,x                   ; 54F8:  94 04
b01_94fa:   plp                         ; 54FA:  28
b01_94fb:   php                         ; 54FB:  08
b01_94fc:   sty $00ff                   ; 54FC:  8c ff 00
b01_94ff:   cmp ($d8,x)                 ; 54FF:  c1 d8
b01_9501:   ora $95                     ; 5501:  05 95
b01_9503:   php                         ; 5503:  08
b01_9504:   rol a                       ; 5504:  2a
b01_9505:   ldy $63                     ; 5505:  a4 63
b01_9507:   adc $b553                   ; 5507:  6d 53 b5
b01_950a:   .db $b3                     ; 550A:  b3
b01_950b:   sbc #$52                    ; 550B:  e9 52
b01_950d:   dex                         ; 550D:  ca
b01_950e:   .db vm_sp_lo                     ; 550E:  02
b01_950f:   .db $b3                     ; 550F:  b3
b01_9510:   .db $3a                     ; 5510:  3a
b01_9511:   .db $3b                     ; 5511:  3b
b01_9512:   sbc #$9d                    ; 5512:  e9 9d
b01_9514:   .db $93                     ; 5514:  93
b01_9515:   .db vm_fp_lo                     ; 5515:  04
b01_9516:   .db $8f                     ; 5516:  8f
b01_9517:   inc $b4,x                   ; 5517:  f6 b4
b01_9519:   ldy $3c8b,x                 ; 5519:  bc 8b 3c
b01_951c:   iny                         ; 551C:  c8
b01_951d:   .db $d7                     ; 551D:  d7
b01_951e:   and $8d95                   ; 551E:  2d 95 8d
b01_9521:   .db $64                     ; 5521:  64
b01_9522:   sbc #$52                    ; 5522:  e9 52
b01_9524:   dex                         ; 5524:  ca
b01_9525:   .db vm_sp_lo                     ; 5525:  02
b01_9526:   cld                         ; 5526:  d8
b01_9527:   and $4095                   ; 5527:  2d 95 40
b01_952a:   dec $2e,x                   ; 552A:  d6 2e
b01_952c:   sta $41,x                   ; 552C:  95 41
b01_952e:   rol $39                     ; 552E:  26 39
b01_9530:   sbc #$8d                    ; 5530:  e9 8d
b01_9532:   cmp $d802,y                 ; 5532:  d9 02 d8
b01_9535:   .db $47                     ; 5535:  47
b01_9536:   sta $39,x                   ; 5536:  95 39
b01_9538:   .db $3b                     ; 5538:  3b
b01_9539:   sbc #$9d                    ; 5539:  e9 9d
b01_953b:   .db $93                     ; 553B:  93
b01_953c:   .db vm_fp_lo                     ; 553C:  04
b01_953d:   .db $8b                     ; 553D:  8b
b01_953e:   .db $2f                     ; 553E:  2f
b01_953f:   iny                         ; 553F:  c8
b01_9540:   cld                         ; 5540:  d8
b01_9541:   .db $47                     ; 5541:  47
b01_9542:   sta $41,x                   ; 5542:  95 41
b01_9544:   rol $09                     ; 5544:  26 09
b01_9546:   rol a                       ; 5546:  2a
b01_9547:   asl a                       ; 5547:  0a
b01_9548:   .db $8b                     ; 5548:  8b
b01_9549:   asl $d8c0,x                 ; 5549:  1e c0 d8
b01_954c:   adc ($95,x)                 ; 554C:  61 95
b01_954e:   sta $e950                   ; 554E:  8d 50 e9
b01_9551:   .db $52                     ; 5551:  52
b01_9552:   dex                         ; 5552:  ca
b01_9553:   .db vm_sp_lo                     ; 5553:  02
b01_9554:   .db $8f                     ; 5554:  8f
b01_9555:   .db $5a                     ; 5555:  5a
b01_9556:   .db $b3                     ; 5556:  b3
b01_9557:   ldy $d7ea                   ; 5557:  ac ea d7
b01_955a:   .db ppumask_shadow                     ; 555A:  72
b01_955b:   .db $d3                     ; 555B:  d3
b01_955c:   ldy $c2,x                   ; 555C:  b4 c2
b01_955e:   .db $d7                     ; 555E:  d7
b01_955f:   sty $95                     ; 555F:  84 95
b01_9561:   .db $3a                     ; 5561:  3a
b01_9562:   sbc #$8d                    ; 5562:  e9 8d
b01_9564:   cmp $d702,y                 ; 5564:  d9 02 d7
b01_9567:   adc ($95),y                 ; 5567:  71 95
b01_9569:   .db $62                     ; 5569:  62
b01_956a:   sbc #$52                    ; 556A:  e9 52
b01_956c:   dex                         ; 556C:  ca
b01_956d:   .db vm_sp_lo                     ; 556D:  02
b01_956e:   cld                         ; 556E:  d8
b01_956f:   sty $95                     ; 556F:  84 95
b01_9571:   asl $d8                     ; 5571:  06 d8
b01_9573:   sty $95                     ; 5573:  84 95
b01_9575:   asl a                       ; 5575:  0a
b01_9576:   tay                         ; 5576:  a8
b01_9577:   .db $63                     ; 5577:  63
b01_9578:   .db p2_buttons                     ; 5578:  6f
b01_9579:   ldy $9046                   ; 5579:  ac 46 90
b01_957c:   cld                         ; 557C:  d8
b01_957d:   sty $95                     ; 557D:  84 95
b01_957f:   ldy $81fc                   ; 557F:  ac fc 81
b01_9582:   .db $42                     ; 5582:  42
b01_9583:   .db $cf                     ; 5583:  cf
b01_9584:   rti                         ; 5584:  40
b01_9585:   .db $cf                     ; 5585:  cf
effect_train:   jsr $e823                   ; 5586:  20 23 e8
b01_9589:   .db $fc                     ; 5589:  fc
b01_958a:   .db $ff                     ; 558A:  ff
b01_958b:   ldy $d7ea                   ; 558B:  ac ea d7
b01_958e:   rol a                       ; 558E:  2a
b01_958f:   ldy $5f                     ; 558F:  a4 5f
b01_9591:   .db p2_buttons                     ; 5591:  6f
b01_9592:   .db $8b                     ; 5592:  8b
b01_9593:   .db $1a                     ; 5593:  1a
b01_9594:   lda $8c,x                   ; 5594:  b5 8c
b01_9596:   ora $70,x                   ; 5596:  15 70
b01_9598:   .db $bb                     ; 5598:  bb
b01_9599:   .db $2b                     ; 5599:  2b
b01_959a:   sta $e914                   ; 559A:  8d 14 e9
b01_959d:   .db $52                     ; 559D:  52
b01_959e:   dex                         ; 559E:  ca
b01_959f:   .db vm_sp_lo                     ; 559F:  02
b01_95a0:   .db music_ptr_lo                     ; 55A0:  7a
b01_95a1:   .db $d2                     ; 55A1:  d2
b01_95a2:   .db $d2                     ; 55A2:  d2
b01_95a3:   .db $b3                     ; 55A3:  b3
b01_95a4:   .db $0b                     ; 55A4:  0b
b01_95a5:   ldy $b3,x                   ; 55A5:  b4 b3
b01_95a7:   bcs $9564                   ; 55A7:  b0 bb
b01_95a9:   lda ($6a),y                 ; 55A9:  b1 6a
b01_95ab:   sbc #$52                    ; 55AB:  e9 52
b01_95ad:   dex                         ; 55AD:  ca
b01_95ae:   .db vm_sp_lo                     ; 55AE:  02
b01_95af:   .db $8f                     ; 55AF:  8f
b01_95b0:   .db $5a                     ; 55B0:  5a
b01_95b1:   .db $b3                     ; 55B1:  b3
b01_95b2:   asl a                       ; 55B2:  0a
b01_95b3:   .db prg_bank_shadow                     ; 55B3:  73
b01_95b4:   .db $d3                     ; 55B4:  d3
b01_95b5:   .db $b3                     ; 55B5:  b3
b01_95b6:   asl a                       ; 55B6:  0a
b01_95b7:   adc $d3,x                   ; 55B7:  75 d3
b01_95b9:   ldy $bb,x                   ; 55B9:  b4 bb
b01_95bb:   ldy $c4,x                   ; 55BB:  b4 c4
b01_95bd:   cld                         ; 55BD:  d8
b01_95be:   .db $c7                     ; 55BE:  c7
b01_95bf:   sta $6a,x                   ; 55BF:  95 6a
b01_95c1:   .db $0b                     ; 55C1:  0b
b01_95c2:   ldy $b3,x                   ; 55C2:  b4 b3
b01_95c4:   bcs $9581                   ; 55C4:  b0 bb
b01_95c6:   lda ($4b),y                 ; 55C6:  b1 4b
b01_95c8:   .db $cf                     ; 55C8:  cf
ai_develop_grow_if_men_exceeds_gold:   jsr $e823                   ; 55C9:  20 23 e8
b01_95cc:   .db $fc                     ; 55CC:  fc
b01_95cd:   .db $ff                     ; 55CD:  ff
b01_95ce:   .db $62                     ; 55CE:  62
b01_95cf:   sbc #$52                    ; 55CF:  e9 52
b01_95d1:   dex                         ; 55D1:  ca
b01_95d2:   .db vm_sp_lo                     ; 55D2:  02
b01_95d3:   .db $d7                     ; 55D3:  d7
b01_95d4:   dec $ac95,x                 ; 55D4:  de 95 ac
b01_95d7:   nop                         ; 55D7:  ea
b01_95d8:   .db $d7                     ; 55D8:  d7
b01_95d9:   .db palette_dirty                     ; 55D9:  74
b01_95da:   .db $b3                     ; 55DA:  b3
b01_95db:   .db $d3                     ; 55DB:  d3
b01_95dc:   bne $95b2                   ; 55DC:  d0 d4
b01_95de:   ldy $5f                     ; 55DE:  a4 5f
b01_95e0:   .db p2_buttons                     ; 55E0:  6f
b01_95e1:   .db $8b                     ; 55E1:  8b
b01_95e2:   .db $1a                     ; 55E2:  1a
b01_95e3:   lda $8c,x                   ; 55E3:  b5 8c
b01_95e5:   ora ($70,x)                 ; 55E5:  01 70
b01_95e7:   .db $bb                     ; 55E7:  bb
b01_95e8:   .db $2b                     ; 55E8:  2b
b01_95e9:   rti                         ; 55E9:  40
b01_95ea:   rol a                       ; 55EA:  2a
b01_95eb:   .db $0b                     ; 55EB:  0b
b01_95ec:   .db $8f                     ; 55EC:  8f
b01_95ed:   bpl $959f                   ; 55ED:  10 b0
b01_95ef:   .db $b3                     ; 55EF:  b3
b01_95f0:   .db $0b                     ; 55F0:  0b
b01_95f1:   bcs $95a7                   ; 55F1:  b0 b4
b01_95f3:   ldy $c551,x                 ; 55F3:  bc 51 c5
b01_95f6:   cld                         ; 55F6:  d8
b01_95f7:   asl a                       ; 55F7:  0a
b01_95f8:   stx $0b,y                   ; 55F8:  96 0b
b01_95fa:   .db $8f                     ; 55FA:  8f
b01_95fb:   bpl $95ad                   ; 55FB:  10 b0
b01_95fd:   .db $b3                     ; 55FD:  b3
b01_95fe:   .db $0b                     ; 55FE:  0b
b01_95ff:   bcs $95b5                   ; 55FF:  b0 b4
b01_9601:   ldy $3bb3,x                 ; 5601:  bc b3 3b
b01_9604:   sbc #$79                    ; 5604:  e9 79
b01_9606:   .db clock_a_hi                     ; 5606:  83
b01_9607:   .db vm_fp_lo                     ; 5607:  04
b01_9608:   lsr $0a2a                   ; 5608:  4e 2a 0a
b01_960b:   .db $cf                     ; 560B:  cf
ai_reinforce_province_arms_and_econ_10pct:   jsr $e823                   ; 560C:  20 23 e8
b01_960f:   .db $f7                     ; 560F:  f7
b01_9610:   .db $ff                     ; 5610:  ff
b01_9611:   ldy $63                     ; 5611:  a4 63
b01_9613:   adc $b3d0                   ; 5613:  6d d0 b3
b01_9616:   sbc #$52                    ; 5616:  e9 52
b01_9618:   dex                         ; 5618:  ca
b01_9619:   .db vm_sp_lo                     ; 5619:  02
b01_961a:   .db $b3                     ; 561A:  b3
b01_961b:   ldy $d7ea                   ; 561B:  ac ea d7
b01_961e:   .db ppumask_shadow                     ; 561E:  72
b01_961f:   ldy $b3,x                   ; 561F:  b4 b3
b01_9621:   .db $d3                     ; 5621:  d3
b01_9622:   .db $bb                     ; 5622:  bb
b01_9623:   .db $d4                     ; 5623:  d4
b01_9624:   ldy $5f                     ; 5624:  a4 5f
b01_9626:   .db p2_buttons                     ; 5626:  6f
b01_9627:   .db $8b                     ; 5627:  8b
b01_9628:   .db $1a                     ; 5628:  1a
b01_9629:   lda $8c,x                   ; 5629:  b5 8c
b01_962b:   ora ($70,x)                 ; 562B:  01 70
b01_962d:   .db $bb                     ; 562D:  bb
b01_962e:   sta $f7                     ; 562E:  85 f7
b01_9630:   .db $8f                     ; 5630:  8f
b01_9631:   bpl $95e3                   ; 5631:  10 b0
b01_9633:   cli                         ; 5633:  58
b01_9634:   cpy $d8                     ; 5634:  c4 d8
b01_9636:   .db $93                     ; 5636:  93
b01_9637:   stx skip_wallclock,y                   ; 5637:  96 89
b01_9639:   .db $32                     ; 5639:  32
b01_963a:   ldx #$fb                    ; 563A:  a2 fb
b01_963c:   .db $ff                     ; 563C:  ff
b01_963d:   eor (clock_b_hi,x)                 ; 563D:  41 85
b01_963f:   sbc $fbde,y                 ; 563F:  f9 de fb
b01_9642:   .db $ff                     ; 5642:  ff
b01_9643:   .db $b3                     ; 5643:  b3
b01_9644:   sta ($f9,x)                 ; 5644:  81 f9
b01_9646:   ldy $bb,x                   ; 5646:  b4 bb
b01_9648:   .db $b3                     ; 5648:  b3
b01_9649:   eor $d4                     ; 5649:  45 d4
b01_964b:   sta ($f9,x)                 ; 564B:  81 f9
b01_964d:   bne $95d4                   ; 564D:  d0 85
b01_964f:   sbc $f981,y                 ; 564F:  f9 81 f9
b01_9652:   eor $c6,x                   ; 5652:  55 c6
b01_9654:   .db $d7                     ; 5654:  d7
b01_9655:   rti                         ; 5655:  40
b01_9656:   stx $40,y                   ; 5656:  96 40
b01_9658:   sta $f9                     ; 5658:  85 f9
b01_965a:   adc $de                     ; 565A:  65 de
b01_965c:   .db $fb                     ; 565C:  fb
b01_965d:   .db $ff                     ; 565D:  ff
b01_965e:   .db $b3                     ; 565E:  b3
b01_965f:   adc $e9                     ; 565F:  65 e9
b01_9661:   .db $52                     ; 5661:  52
b01_9662:   dex                         ; 5662:  ca
b01_9663:   .db vm_sp_lo                     ; 5663:  02
b01_9664:   ldy $bb,x                   ; 5664:  b4 bb
b01_9666:   ldy $b3,x                   ; 5666:  b4 b3
b01_9668:   .db $d3                     ; 5668:  d3
b01_9669:   .db $bb                     ; 5669:  bb
b01_966a:   .db $d4                     ; 566A:  d4
b01_966b:   sta ($f9,x)                 ; 566B:  81 f9
b01_966d:   bne $95f4                   ; 566D:  d0 85
b01_966f:   sbc $f981,y                 ; 566F:  f9 81 f9
b01_9672:   eor $c6,x                   ; 5672:  55 c6
b01_9674:   .db $d7                     ; 5674:  d7
b01_9675:   .db $5a                     ; 5675:  5a
b01_9676:   stx $65,y                   ; 5676:  96 65
b01_9678:   dec $fffc,x                 ; 5678:  de fc ff
b01_967b:   .db $b3                     ; 567B:  b3
b01_967c:   .db $62                     ; 567C:  62
b01_967d:   sbc #$52                    ; 567D:  e9 52
b01_967f:   dex                         ; 567F:  ca
b01_9680:   .db vm_sp_lo                     ; 5680:  02
b01_9681:   ldy $bb,x                   ; 5681:  b4 bb
b01_9683:   ldy $b3,x                   ; 5683:  b4 b3
b01_9685:   .db $d3                     ; 5685:  d3
b01_9686:   .db $bb                     ; 5686:  bb
b01_9687:   .db $d4                     ; 5687:  d4
b01_9688:   dec $fffb,x                 ; 5688:  de fb ff
b01_968b:   .db $b3                     ; 568B:  b3
b01_968c:   tax                         ; 568C:  aa
b01_968d:   .db $5f                     ; 568D:  5f
b01_968e:   .db p2_buttons                     ; 568E:  6f
b01_968f:   sbc #$af                    ; 568F:  e9 af
b01_9691:   .db $e2                     ; 5691:  e2
b01_9692:   .db vm_fp_lo                     ; 5692:  04
b01_9693:   ror a                       ; 5693:  6a
b01_9694:   sta ($f7,x)                 ; 5694:  81 f7
b01_9696:   bcs $9668                   ; 5696:  b0 d0
b01_9698:   .db $b3                     ; 5698:  b3
b01_9699:   sbc #$0d                    ; 5699:  e9 0d
b01_969b:   .db $d7                     ; 569B:  d7
b01_969c:   .db vm_fp_lo                     ; 569C:  04
b01_969d:   .db $b3                     ; 569D:  b3
b01_969e:   sta ($f7,x)                 ; 569E:  81 f7
b01_96a0:   ldy $b3,x                   ; 56A0:  b4 b3
b01_96a2:   bcs $965f                   ; 56A2:  b0 bb
b01_96a4:   lda ($6a),y                 ; 56A4:  b1 6a
b01_96a6:   sta ($f7,x)                 ; 56A6:  81 f7
b01_96a8:   ror nmi_skip_all,x                   ; 56A8:  76 b0
b01_96aa:   bne $965f                   ; 56AA:  d0 b3
b01_96ac:   sbc #$0d                    ; 56AC:  e9 0d
b01_96ae:   .db $d7                     ; 56AE:  d7
b01_96af:   .db vm_fp_lo                     ; 56AF:  04
b01_96b0:   .db $b3                     ; 56B0:  b3
b01_96b1:   sta ($f7,x)                 ; 56B1:  81 f7
b01_96b3:   ror $b4,x                   ; 56B3:  76 b4
b01_96b5:   .db $b3                     ; 56B5:  b3
b01_96b6:   bcs $9673                   ; 56B6:  b0 bb
b01_96b8:   lda ($6a),y                 ; 56B8:  b1 6a
b01_96ba:   sta ($f7,x)                 ; 56BA:  81 f7
b01_96bc:   .db $8f                     ; 56BC:  8f
b01_96bd:   bpl $966f                   ; 56BD:  10 b0
b01_96bf:   bne $9674                   ; 56BF:  d0 b3
b01_96c1:   sbc #$0d                    ; 56C1:  e9 0d
b01_96c3:   .db $d7                     ; 56C3:  d7
b01_96c4:   .db vm_fp_lo                     ; 56C4:  04
b01_96c5:   .db $b3                     ; 56C5:  b3
b01_96c6:   sta ($f7,x)                 ; 56C6:  81 f7
b01_96c8:   .db $8f                     ; 56C8:  8f
b01_96c9:   bpl $967f                   ; 56C9:  10 b4
b01_96cb:   .db $b3                     ; 56CB:  b3
b01_96cc:   bcs $9689                   ; 56CC:  b0 bb
b01_96ce:   lda ($40),y                 ; 56CE:  b1 40
b01_96d0:   .db $cf                     ; 56D0:  cf
driver_move:   jsr $e823                   ; 56D1:  20 23 e8
b01_96d4:   sed                         ; 56D4:  f8
b01_96d5:   .db $ff                     ; 56D5:  ff
b01_96d6:   tax                         ; 56D6:  aa
b01_96d7:   .db $5f                     ; 56D7:  5f
b01_96d8:   .db p2_buttons                     ; 56D8:  6f
b01_96d9:   sbc #$3a                    ; 56D9:  e9 3a
b01_96db:   .db $93                     ; 56DB:  93
b01_96dc:   .db vm_sp_lo                     ; 56DC:  02
b01_96dd:   .db $d7                     ; 56DD:  d7
b01_96de:   .db $e2                     ; 56DE:  e2
b01_96df:   stx $40,y                   ; 56DF:  96 40
b01_96e1:   .db $cf                     ; 56E1:  cf
b01_96e2:   ldy $dad7                   ; 56E2:  ac d7 da
b01_96e5:   stx deduped_owner_list                   ; 56E5:  8e 4f 6f
b01_96e8:   adc ($e9,x)                 ; 56E8:  61 e9
b01_96ea:   .db $3a                     ; 56EA:  3a
b01_96eb:   cmp $8e04,x                 ; 56EB:  dd 04 8e
b01_96ee:   .db $4f                     ; 56EE:  4f
b01_96ef:   .db p2_buttons                     ; 56EF:  6f
b01_96f0:   adc ($e9,x)                 ; 56F0:  61 e9
b01_96f2:   .db $9f                     ; 56F2:  9f
b01_96f3:   .db $87                     ; 56F3:  87
b01_96f4:   .db vm_fp_lo                     ; 56F4:  04
b01_96f5:   cld                         ; 56F5:  d8
b01_96f6:   .db $bf                     ; 56F6:  bf
b01_96f7:   .db $97                     ; 56F7:  97
b01_96f8:   stx $f9cd                   ; 56F8:  8e cd f9
b01_96fb:   sbc #$c4                    ; 56FB:  e9 c4
b01_96fd:   dec $8e02                   ; 56FD:  ce 02 8e
b01_9700:   .db $4f                     ; 5700:  4f
b01_9701:   .db p2_buttons                     ; 5701:  6f
b01_9702:   sbc #$4c                    ; 5702:  e9 4c
b01_9704:   .db skip_vblank_wait                     ; 5704:  80
b01_9705:   .db vm_sp_lo                     ; 5705:  02
b01_9706:   tay                         ; 5706:  a8
b01_9707:   .db $63                     ; 5707:  63
b01_9708:   .db p2_buttons                     ; 5708:  6f
b01_9709:   cld                         ; 5709:  d8
b01_970a:   .db $bf                     ; 570A:  bf
b01_970b:   .db $97                     ; 570B:  97
b01_970c:   ldy $63                     ; 570C:  a4 63
b01_970e:   .db p2_buttons                     ; 570E:  6f
b01_970f:   cmp ($a8),y                 ; 570F:  d1 a8
b01_9711:   .db $63                     ; 5711:  63
b01_9712:   .db p2_buttons                     ; 5712:  6f
b01_9713:   ldy $cc89                   ; 5713:  ac 89 cc
b01_9716:   ldy $63                     ; 5716:  a4 63
b01_9718:   .db p2_buttons                     ; 5718:  6f
b01_9719:   .db $8b                     ; 5719:  8b
b01_971a:   .db $1a                     ; 571A:  1a
b01_971b:   lda $8c,x                   ; 571B:  b5 8c
b01_971d:   ora ($70,x)                 ; 571D:  01 70
b01_971f:   .db $bb                     ; 571F:  bb
b01_9720:   and #$a4                    ; 5720:  29 a4
b01_9722:   .db $5f                     ; 5722:  5f
b01_9723:   .db p2_buttons                     ; 5723:  6f
b01_9724:   .db $8b                     ; 5724:  8b
b01_9725:   .db $1a                     ; 5725:  1a
b01_9726:   lda $8c,x                   ; 5726:  b5 8c
b01_9728:   ora ($70,x)                 ; 5728:  01 70
b01_972a:   .db $bb                     ; 572A:  bb
b01_972b:   plp                         ; 572B:  28
b01_972c:   ora #$8f                    ; 572C:  09 8f
b01_972e:   bpl $96e0                   ; 572E:  10 b0
b01_9730:   .db $b3                     ; 5730:  b3
b01_9731:   ora #$8f                    ; 5731:  09 8f
b01_9733:   clc                         ; 5733:  18
b01_9734:   bcs $96ea                   ; 5734:  b0 b4
b01_9736:   ldy $08b3,x                 ; 5736:  bc b3 08
b01_9739:   .db $8f                     ; 5739:  8f
b01_973a:   bpl $96ec                   ; 573A:  10 b0
b01_973c:   .db $b3                     ; 573C:  b3
b01_973d:   sbc #$5e                    ; 573D:  e9 5e
b01_973f:   .db $cb                     ; 573F:  cb
b01_9740:   .db vm_fp_lo                     ; 5740:  04
b01_9741:   rol a                       ; 5741:  2a
b01_9742:   asl a                       ; 5742:  0a
b01_9743:   cld                         ; 5743:  d8
b01_9744:   lda $97,x                   ; 5744:  b5 97
b01_9746:   stx $f9db                   ; 5746:  8e db f9
b01_9749:   sbc #$c4                    ; 5749:  e9 c4
b01_974b:   dec $3a02                   ; 574B:  ce 02 3a
b01_974e:   adc ($e9,x)                 ; 574E:  61 e9
b01_9750:   sbc #$d5                    ; 5750:  e9 d5
b01_9752:   .db vm_fp_lo                     ; 5752:  04
b01_9753:   .db $2b                     ; 5753:  2b
b01_9754:   cld                         ; 5754:  d8
b01_9755:   .db $bf                     ; 5755:  bf
b01_9756:   .db $97                     ; 5756:  97
b01_9757:   ldy $5f                     ; 5757:  a4 5f
b01_9759:   .db p2_buttons                     ; 5759:  6f
b01_975a:   sty fief_is_daimyo_capital                   ; 575A:  8c a2 6d
b01_975d:   .db $bb                     ; 575D:  bb
b01_975e:   .db $d3                     ; 575E:  d3
b01_975f:   cld                         ; 575F:  d8
b01_9760:   .db $97                     ; 5760:  97
b01_9761:   .db $97                     ; 5761:  97
b01_9762:   tax                         ; 5762:  aa
b01_9763:   .db $5f                     ; 5763:  5f
b01_9764:   .db p2_buttons                     ; 5764:  6f
b01_9765:   sbc #$68                    ; 5765:  e9 68
b01_9767:   .db $93                     ; 5767:  93
b01_9768:   .db vm_sp_lo                     ; 5768:  02
b01_9769:   .db $d7                     ; 5769:  d7
b01_976a:   .db $97                     ; 576A:  97
b01_976b:   .db $97                     ; 576B:  97
b01_976c:   stx $f9e8                   ; 576C:  8e e8 f9
b01_976f:   sbc #$c4                    ; 576F:  e9 c4
b01_9771:   dec $ac02                   ; 5771:  ce 02 ac
b01_9774:   .db $a7                     ; 5774:  a7
b01_9775:   .db $d3                     ; 5775:  d3
b01_9776:   cld                         ; 5776:  d8
b01_9777:   .db $97                     ; 5777:  97
b01_9778:   .db $97                     ; 5778:  97
b01_9779:   ldy $5f                     ; 5779:  a4 5f
b01_977b:   .db p2_buttons                     ; 577B:  6f
b01_977c:   sty fief_is_daimyo_capital                   ; 577C:  8c a2 6d
b01_977f:   .db $bb                     ; 577F:  bb
b01_9780:   .db $b3                     ; 5780:  b3
b01_9781:   rti                         ; 5781:  40
b01_9782:   .db $d4                     ; 5782:  d4
b01_9783:   ldy $63                     ; 5783:  a4 63
b01_9785:   .db p2_buttons                     ; 5785:  6f
b01_9786:   sty fief_is_daimyo_capital                   ; 5786:  8c a2 6d
b01_9789:   .db $bb                     ; 5789:  bb
b01_978a:   .db $b3                     ; 578A:  b3
b01_978b:   eor ($d4,x)                 ; 578B:  41 d4
b01_978d:   ldy $63                     ; 578D:  a4 63
b01_978f:   .db p2_buttons                     ; 578F:  6f
b01_9790:   sty province_ai_state                   ; 5790:  8c f7 6c
b01_9793:   .db $bb                     ; 5793:  bb
b01_9794:   .db $b3                     ; 5794:  b3
b01_9795:   eor $d4                     ; 5795:  45 d4
b01_9797:   pla                         ; 5797:  68
b01_9798:   sbc #$0c                    ; 5798:  e9 0c
b01_979a:   inx                         ; 579A:  e8
b01_979b:   .db vm_sp_lo                     ; 579B:  02
b01_979c:   stx $fa06                   ; 579C:  8e 06 fa
b01_979f:   sbc #$26                    ; 579F:  e9 26
b01_97a1:   .db $d3                     ; 57A1:  d3
b01_97a2:   .db vm_sp_lo                     ; 57A2:  02
b01_97a3:   ldy $d766                   ; 57A3:  ac 66 d7
b01_97a6:   .db $3b                     ; 57A6:  3b
b01_97a7:   sbc #$a5                    ; 57A7:  e9 a5
b01_97a9:   sty $3902                   ; 57A9:  8c 02 39
b01_97ac:   tax                         ; 57AC:  aa
b01_97ad:   .db $63                     ; 57AD:  63
b01_97ae:   .db p2_buttons                     ; 57AE:  6f
b01_97af:   sbc #$fe                    ; 57AF:  e9 fe
b01_97b1:   .db $df                     ; 57B1:  df
b01_97b2:   .db vm_fp_lo                     ; 57B2:  04
b01_97b3:   eor ($cf,x)                 ; 57B3:  41 cf
b01_97b5:   stx $bbc4                   ; 57B5:  8e c4 bb
b01_97b8:   sbc #$26                    ; 57B8:  e9 26
b01_97ba:   .db $d3                     ; 57BA:  d3
b01_97bb:   .db vm_sp_lo                     ; 57BB:  02
b01_97bc:   ldy $d766                   ; 57BC:  ac 66 d7
b01_97bf:   rti                         ; 57BF:  40
b01_97c0:   .db $cf                     ; 57C0:  cf
fief_list_parallel_lookup:   jsr $e823                   ; 57C1:  20 23 e8
b01_97c4:   inc $8aff,x                 ; 57C4:  fe ff 8a
b01_97c7:   .db $4f                     ; 57C7:  4f
b01_97c8:   .db p2_buttons                     ; 57C8:  6f
b01_97c9:   .db $2b                     ; 57C9:  2b
b01_97ca:   dec $e0,x                   ; 57CA:  d6 e0
b01_97cc:   .db $97                     ; 57CC:  97
b01_97cd:   .db $0b                     ; 57CD:  0b
b01_97ce:   .db $d3                     ; 57CE:  d3
b01_97cf:   .db ppu_queue_a_lo                     ; 57CF:  1c
b01_97d0:   cpy #$d8                    ; 57D0:  c0 d8
b01_97d2:   .db $d7                     ; 57D2:  d7
b01_97d3:   .db $97                     ; 57D3:  97
b01_97d4:   ora $cfb0                   ; 57D4:  0d b0 cf
b01_97d7:   .db $0b                     ; 57D7:  0b
b01_97d8:   bne $9805                   ; 57D8:  d0 2b
b01_97da:   cmp ($0d),y                 ; 57DA:  d1 0d
b01_97dc:   .db ppumask_shadow                     ; 57DC:  72
b01_97dd:   and $fe8f                   ; 57DD:  2d 8f fe
b01_97e0:   .db $0b                     ; 57E0:  0b
b01_97e1:   .db $d3                     ; 57E1:  d3
b01_97e2:   sty $00ff                   ; 57E2:  8c ff 00
b01_97e5:   cmp ($d7,x)                 ; 57E5:  c1 d7
b01_97e7:   cmp $cf97                   ; 57E7:  cd 97 cf
relations_roll_vs_owner:   jsr $e823                   ; 57EA:  20 23 e8
b01_97ed:   brk                         ; 57ED:  00
b01_97ee:   brk                         ; 57EE:  00
b01_97ef:   sta $e964                   ; 57EF:  8d 64 e9
b01_97f2:   .db $52                     ; 57F2:  52
b01_97f3:   dex                         ; 57F3:  ca
b01_97f4:   .db vm_sp_lo                     ; 57F4:  02
b01_97f5:   .db $b3                     ; 57F5:  b3
b01_97f6:   ora $08d8                   ; 57F6:  0d d8 08
b01_97f9:   tya                         ; 57F9:  98
b01_97fa:   adc ($3c,x)                 ; 57FA:  61 3c
b01_97fc:   sbc #$72                    ; 57FC:  e9 72
b01_97fe:   .db $d7                     ; 57FE:  d7
b01_97ff:   .db vm_sp_lo                     ; 57FF:  02
b01_9800:   .db $b3                     ; 5800:  b3
b01_9801:   ldy $d77e                   ; 5801:  ac 7e d7
b01_9804:   .db $b3                     ; 5804:  b3
b01_9805:   dec $0d,x                   ; 5805:  d6 0d
b01_9807:   tya                         ; 5807:  98
b01_9808:   and $aa3c,x                 ; 5808:  3d 3c aa
b01_980b:   .db $5f                     ; 580B:  5f
b01_980c:   .db p2_buttons                     ; 580C:  6f
b01_980d:   sbc #$50                    ; 580D:  e9 50
b01_980f:   .db $82                     ; 580F:  82
b01_9810:   asl $b4                     ; 5810:  06 b4
b01_9812:   iny                         ; 5812:  c8
b01_9813:   .db $cf                     ; 5813:  cf
effect_war_e:   jsr $e823                   ; 5814:  20 23 e8
b01_9817:   inc $8aff,x                 ; 5817:  fe ff 8a
b01_981a:   .db $4f                     ; 581A:  4f
b01_981b:   .db p2_buttons                     ; 581B:  6f
b01_981c:   .db $2b                     ; 581C:  2b
b01_981d:   dec $46,x                   ; 581D:  d6 46
b01_981f:   tya                         ; 581F:  98
b01_9820:   .db $3c                     ; 5820:  3c
b01_9821:   adc ($0b,x)                 ; 5821:  61 0b
b01_9823:   .db $d3                     ; 5823:  d3
b01_9824:   .db $b3                     ; 5824:  b3
b01_9825:   sbc #$ea                    ; 5825:  e9 ea
b01_9827:   .db $97                     ; 5827:  97
b01_9828:   .db vm_fp_lo                     ; 5828:  04
b01_9829:   .db $d7                     ; 5829:  d7
b01_982a:   .db $3b                     ; 582A:  3b
b01_982b:   tya                         ; 582B:  98
b01_982c:   rts                         ; 582C:  60
b01_982d:   .db $0b                     ; 582D:  0b
b01_982e:   .db $d3                     ; 582E:  d3
b01_982f:   .db $b3                     ; 582F:  b3
b01_9830:   sbc #$ea                    ; 5830:  e9 ea
b01_9832:   .db $97                     ; 5832:  97
b01_9833:   .db vm_fp_lo                     ; 5833:  04
b01_9834:   .db $d7                     ; 5834:  d7
b01_9835:   .db $3b                     ; 5835:  3b
b01_9836:   tya                         ; 5836:  98
b01_9837:   rti                         ; 5837:  40
b01_9838:   dec $3c,x                   ; 5838:  d6 3c
b01_983a:   tya                         ; 583A:  98
b01_983b:   eor ($b1,x)                 ; 583B:  41 b1
b01_983d:   .db $0b                     ; 583D:  0b
b01_983e:   bne $986b                   ; 583E:  d0 2b
b01_9840:   cmp ($0c),y                 ; 5840:  d1 0c
b01_9842:   .db ppumask_shadow                     ; 5842:  72
b01_9843:   bit $fe8f                   ; 5843:  2c 8f fe
b01_9846:   .db $0b                     ; 5846:  0b
b01_9847:   .db $d3                     ; 5847:  d3
b01_9848:   sty $00ff                   ; 5848:  8c ff 00
b01_984b:   cmp ($d7,x)                 ; 584B:  c1 d7
b01_984d:   jsr $cf98                   ; 584D:  20 98 cf
driver_war:   jsr $e823                   ; 5850:  20 23 e8
b01_9853:   nop                         ; 5853:  ea
b01_9854:   .db $ff                     ; 5854:  ff
b01_9855:   ldy $5f                     ; 5855:  a4 5f
b01_9857:   .db p2_buttons                     ; 5857:  6f
b01_9858:   and #$09                    ; 5858:  29 09
b01_985a:   sty fief_is_daimyo_capital                   ; 585A:  8c a2 6d
b01_985d:   .db $bb                     ; 585D:  bb
b01_985e:   .db $d3                     ; 585E:  d3
b01_985f:   cld                         ; 585F:  d8
b01_9860:   jmp ($3998)                 ; 5860:  6c 98 39
b01_9863:   sbc #$68                    ; 5863:  e9 68
b01_9865:   .db $93                     ; 5865:  93
b01_9866:   .db vm_sp_lo                     ; 5866:  02
b01_9867:   cld                         ; 5867:  d8
b01_9868:   jmp ($4098)                 ; 5868:  6c 98 40
b01_986b:   .db $cf                     ; 586B:  cf
b01_986c:   and $51e9,y                 ; 586C:  39 e9 51
b01_986f:   .db $93                     ; 586F:  93
b01_9870:   .db vm_sp_lo                     ; 5870:  02
b01_9871:   cld                         ; 5871:  d8
b01_9872:   tya                         ; 5872:  98
b01_9873:   sta $e939,y                 ; 5873:  99 39 e9
b01_9876:   .db $23                     ; 5876:  23
b01_9877:   .db $93                     ; 5877:  93
b01_9878:   .db vm_sp_lo                     ; 5878:  02
b01_9879:   cld                         ; 5879:  d8
b01_987a:   tya                         ; 587A:  98
b01_987b:   sta $e939,y                 ; 587B:  99 39 e9
b01_987e:   .db $3a                     ; 587E:  3a
b01_987f:   .db $93                     ; 587F:  93
b01_9880:   .db vm_sp_lo                     ; 5880:  02
b01_9881:   cld                         ; 5881:  d8
b01_9882:   tya                         ; 5882:  98
b01_9883:   sta $d7ac,y                 ; 5883:  99 ac d7
b01_9886:   .db $da                     ; 5886:  da
b01_9887:   stx deduped_owner_list                   ; 5887:  8e 4f 6f
b01_988a:   rts                         ; 588A:  60
b01_988b:   sbc #$3a                    ; 588B:  e9 3a
b01_988d:   cmp $de04,x                 ; 588D:  dd 04 de
b01_9890:   nop                         ; 5890:  ea
b01_9891:   .db $ff                     ; 5891:  ff
b01_9892:   .db $b3                     ; 5892:  b3
b01_9893:   sbc #$14                    ; 5893:  e9 14
b01_9895:   tya                         ; 5895:  98
b01_9896:   .db vm_sp_lo                     ; 5896:  02
b01_9897:   stx deduped_owner_list                   ; 5897:  8e 4f 6f
b01_989a:   .db $62                     ; 589A:  62
b01_989b:   sbc #$9f                    ; 589B:  e9 9f
b01_989d:   .db $87                     ; 589D:  87
b01_989e:   .db vm_fp_lo                     ; 589E:  04
b01_989f:   cld                         ; 589F:  d8
b01_98a0:   tya                         ; 58A0:  98
b01_98a1:   sta $1f8e,y                 ; 58A1:  99 8e 1f
b01_98a4:   .db $fa                     ; 58A4:  fa
b01_98a5:   sbc #$c4                    ; 58A5:  e9 c4
b01_98a7:   dec $8e02                   ; 58A7:  ce 02 8e
b01_98aa:   .db $4f                     ; 58AA:  4f
b01_98ab:   .db p2_buttons                     ; 58AB:  6f
b01_98ac:   sbc #$4c                    ; 58AC:  e9 4c
b01_98ae:   .db skip_vblank_wait                     ; 58AE:  80
b01_98af:   .db vm_sp_lo                     ; 58AF:  02
b01_98b0:   tay                         ; 58B0:  a8
b01_98b1:   .db $63                     ; 58B1:  63
b01_98b2:   .db p2_buttons                     ; 58B2:  6f
b01_98b3:   cld                         ; 58B3:  d8
b01_98b4:   tya                         ; 58B4:  98
b01_98b5:   sta $89ac,y                 ; 58B5:  99 ac 89
b01_98b8:   cpy $63a4                   ; 58B8:  cc a4 63
b01_98bb:   .db p2_buttons                     ; 58BB:  6f
b01_98bc:   cmp ($a8),y                 ; 58BC:  d1 a8
b01_98be:   .db $63                     ; 58BE:  63
b01_98bf:   .db p2_buttons                     ; 58BF:  6f
b01_98c0:   dec $ffea,x                 ; 58C0:  de ea ff
b01_98c3:   .db $b3                     ; 58C3:  b3
b01_98c4:   tax                         ; 58C4:  aa
b01_98c5:   .db $63                     ; 58C5:  63
b01_98c6:   .db p2_buttons                     ; 58C6:  6f
b01_98c7:   sbc #$c1                    ; 58C7:  e9 c1
b01_98c9:   .db $97                     ; 58C9:  97
b01_98ca:   .db vm_fp_lo                     ; 58CA:  04
b01_98cb:   cld                         ; 58CB:  d8
b01_98cc:   .db $da                     ; 58CC:  da
b01_98cd:   tya                         ; 58CD:  98
b01_98ce:   stx $fe29                   ; 58CE:  8e 29 fe
b01_98d1:   sbc #$c4                    ; 58D1:  e9 c4
b01_98d3:   dec $ac02                   ; 58D3:  ce 02 ac
b01_98d6:   ror $d7                     ; 58D6:  66 d7
b01_98d8:   eor ($cf,x)                 ; 58D8:  41 cf
b01_98da:   ldy $5f                     ; 58DA:  a4 5f
b01_98dc:   .db p2_buttons                     ; 58DC:  6f
b01_98dd:   .db $8b                     ; 58DD:  8b
b01_98de:   .db $1a                     ; 58DE:  1a
b01_98df:   lda $8c,x                   ; 58DF:  b5 8c
b01_98e1:   ora ($70,x)                 ; 58E1:  01 70
b01_98e3:   .db $bb                     ; 58E3:  bb
b01_98e4:   .db $2b                     ; 58E4:  2b
b01_98e5:   .db $0b                     ; 58E5:  0b
b01_98e6:   bcs $989b                   ; 58E6:  b0 b3
b01_98e8:   .db $0b                     ; 58E8:  0b
b01_98e9:   .db $8f                     ; 58E9:  8f
b01_98ea:   bpl $989c                   ; 58EA:  10 b0
b01_98ec:   .db $b3                     ; 58EC:  b3
b01_98ed:   sbc #$5e                    ; 58ED:  e9 5e
b01_98ef:   .db $cb                     ; 58EF:  cb
b01_98f0:   .db vm_fp_lo                     ; 58F0:  04
b01_98f1:   rol a                       ; 58F1:  2a
b01_98f2:   and $72e9,y                 ; 58F2:  39 e9 72
b01_98f5:   cmp $d802,y                 ; 58F5:  d9 02 d8
b01_98f8:   asl $99                     ; 58F8:  06 99
b01_98fa:   .db $44                     ; 58FA:  44
b01_98fb:   cmp $b60a                   ; 58FB:  cd 0a b6
b01_98fe:   rol a                       ; 58FE:  2a
b01_98ff:   asl a                       ; 58FF:  0a
b01_9900:   .db $d7                     ; 5900:  d7
b01_9901:   asl $99                     ; 5901:  06 99
b01_9903:   asl a                       ; 5903:  0a
b01_9904:   bne $9930                   ; 5904:  d0 2a
b01_9906:   stx $fa2f                   ; 5906:  8e 2f fa
b01_9909:   sbc #$c4                    ; 5909:  e9 c4
b01_990b:   dec $3a02                   ; 590B:  ce 02 3a
b01_990e:   adc ($e9,x)                 ; 590E:  61 e9
b01_9910:   sbc #$d5                    ; 5910:  e9 d5
b01_9912:   .db vm_fp_lo                     ; 5912:  04
b01_9913:   tay                         ; 5913:  a8
b01_9914:   sta (p2_buttons,x)                 ; 5914:  81 6f
b01_9916:   cld                         ; 5916:  d8
b01_9917:   tya                         ; 5917:  98
b01_9918:   sta $3c8e,y                 ; 5918:  99 8e 3c
b01_991b:   .db $fa                     ; 591B:  fa
b01_991c:   sbc #$26                    ; 591C:  e9 26
b01_991e:   .db $d3                     ; 591E:  d3
b01_991f:   .db vm_sp_lo                     ; 591F:  02
b01_9920:   tax                         ; 5920:  aa
b01_9921:   sta (p2_buttons,x)                 ; 5921:  81 6f
b01_9923:   .db $0b                     ; 5923:  0b
b01_9924:   ror nmi_skip_all,x                   ; 5924:  76 b0
b01_9926:   .db $b3                     ; 5926:  b3
b01_9927:   sbc #$5e                    ; 5927:  e9 5e
b01_9929:   .db $cb                     ; 5929:  cb
b01_992a:   .db vm_fp_lo                     ; 592A:  04
b01_992b:   .db $b3                     ; 592B:  b3
b01_992c:   adc ($e9,x)                 ; 592C:  61 e9
b01_992e:   sbc #$d5                    ; 592E:  e9 d5
b01_9930:   .db vm_fp_lo                     ; 5930:  04
b01_9931:   tay                         ; 5931:  a8
b01_9932:   .db $7f                     ; 5932:  7f
b01_9933:   .db p2_buttons                     ; 5933:  6f
b01_9934:   cld                         ; 5934:  d8
b01_9935:   tya                         ; 5935:  98
b01_9936:   sta $a940,y                 ; 5936:  99 40 a9
b01_9939:   adc p2_buttons                     ; 5939:  65 6f
b01_993b:   ora #$8c                    ; 593B:  09 8c
b01_993d:   ldx #$6d                    ; 593D:  a2 6d
b01_993f:   .db $bb                     ; 593F:  bb
b01_9940:   .db $d3                     ; 5940:  d3
b01_9941:   cld                         ; 5941:  d8
b01_9942:   eor $ac99,y                 ; 5942:  59 99 ac
b01_9945:   .db skip_wallclock                     ; 5945:  89
b01_9946:   cpy $598e                   ; 5946:  cc 8e 59
b01_9949:   .db $fa                     ; 5949:  fa
b01_994a:   sbc #$26                    ; 594A:  e9 26
b01_994c:   .db $d3                     ; 594C:  d3
b01_994d:   .db vm_sp_lo                     ; 594D:  02
b01_994e:   ldy $d3a7                   ; 594E:  ac a7 d3
b01_9951:   cld                         ; 5951:  d8
b01_9952:   eor $8999,y                 ; 5952:  59 99 89
b01_9955:   .db skip_vblank_wait                     ; 5955:  80
b01_9956:   lda #$65                    ; 5956:  a9 65
b01_9958:   .db p2_buttons                     ; 5958:  6f
b01_9959:   ldy nmi_busy                     ; 5959:  a4 81
b01_995b:   .db p2_buttons                     ; 595B:  6f
b01_995c:   tay                         ; 595C:  a8
b01_995d:   adc $aa6f,x                 ; 595D:  7d 6f aa
b01_9960:   adc $0b6f,x                 ; 5960:  7d 6f 0b
b01_9963:   ldy $b3,x                   ; 5963:  b4 b3
b01_9965:   bcs $9923                   ; 5965:  b0 bc
b01_9967:   lda ($aa),y                 ; 5967:  b1 aa
b01_9969:   .db $7f                     ; 5969:  7f
b01_996a:   .db p2_buttons                     ; 596A:  6f
b01_996b:   .db $0b                     ; 596B:  0b
b01_996c:   ror $b4,x                   ; 596C:  76 b4
b01_996e:   .db $b3                     ; 596E:  b3
b01_996f:   bcs $992d                   ; 596F:  b0 bc
b01_9971:   lda ($aa),y                 ; 5971:  b1 aa
b01_9973:   sta (p2_buttons,x)                 ; 5973:  81 6f
b01_9975:   .db $0b                     ; 5975:  0b
b01_9976:   .db $8f                     ; 5976:  8f
b01_9977:   bpl $992d                   ; 5977:  10 b4
b01_9979:   .db $b3                     ; 5979:  b3
b01_997a:   bcs $9938                   ; 597A:  b0 bc
b01_997c:   lda ($41),y                 ; 597C:  b1 41
b01_997e:   tay                         ; 597E:  a8
b01_997f:   adc $896f,y                 ; 597F:  79 6f 89
b01_9982:   .db $8f                     ; 5982:  8f
b01_9983:   cmp $a1a5                   ; 5983:  cd a5 a1
b01_9986:   adc $a9da                   ; 5986:  6d da a9
b01_9989:   lda ($6d,x)                 ; 5989:  a1 6d
b01_998b:   ldy $cc89                   ; 598B:  ac 89 cc
b01_998e:   adc $0ce9                   ; 598E:  6d e9 0c
b01_9991:   inx                         ; 5991:  e8
b01_9992:   .db vm_sp_lo                     ; 5992:  02
b01_9993:   ldy $81fc                   ; 5993:  ac fc 81
b01_9996:   eor ($cf,x)                 ; 5996:  41 cf
b01_9998:   rti                         ; 5998:  40
b01_9999:   .db $cf                     ; 5999:  cf
driver_tax:   jsr $e823                   ; 599A:  20 23 e8
b01_999d:   .db $f2                     ; 599D:  f2
b01_999e:   .db $ff                     ; 599E:  ff
b01_999f:   ldy $5f                     ; 599F:  a4 5f
b01_99a1:   .db p2_buttons                     ; 59A1:  6f
b01_99a2:   sty fief_tax_rate                   ; 59A2:  8c 2d 6d
b01_99a5:   .db $bb                     ; 59A5:  bb
b01_99a6:   rol $a4                     ; 59A6:  26 a4
b01_99a8:   .db $5f                     ; 59A8:  5f
b01_99a9:   .db p2_buttons                     ; 59A9:  6f
b01_99aa:   .db $8b                     ; 59AA:  8b
b01_99ab:   .db $1a                     ; 59AB:  1a
b01_99ac:   lda $8c,x                   ; 59AC:  b5 8c
b01_99ae:   ora $bb70                   ; 59AE:  0d 70 bb
b01_99b1:   .db $2b                     ; 59B1:  2b
b01_99b2:   .db $0b                     ; 59B2:  0b
b01_99b3:   .db ppumask_shadow                     ; 59B3:  72
b01_99b4:   rol a                       ; 59B4:  2a
b01_99b5:   stx $bbe2                   ; 59B5:  8e e2 bb
b01_99b8:   sbc #$26                    ; 59B8:  e9 26
b01_99ba:   .db $d3                     ; 59BA:  d3
b01_99bb:   .db vm_sp_lo                     ; 59BB:  02
b01_99bc:   asl $d3                     ; 59BC:  06 d3
b01_99be:   .db $b3                     ; 59BE:  b3
b01_99bf:   stx $fa77                   ; 59BF:  8e 77 fa
b01_99c2:   sbc #$34                    ; 59C2:  e9 34
b01_99c4:   cmp (vm_fp_lo),y                 ; 59C4:  d1 04
b01_99c6:   ldy $5f                     ; 59C6:  a4 5f
b01_99c8:   .db p2_buttons                     ; 59C8:  6f
b01_99c9:   tay                         ; 59C9:  a8
b01_99ca:   .db $63                     ; 59CA:  63
b01_99cb:   .db p2_buttons                     ; 59CB:  6f
b01_99cc:   ldy $db12                   ; 59CC:  ac 12 db
b01_99cf:   cld                         ; 59CF:  d8
b01_99d0:   .db $d7                     ; 59D0:  d7
b01_99d1:   sta $1e89,y                 ; 59D1:  99 89 1e
b01_99d4:   dec $d9,x                   ; 59D4:  d6 d9
b01_99d6:   sta $6489,y                 ; 59D6:  99 89 64
b01_99d9:   .db $b3                     ; 59D9:  b3
b01_99da:   adc ($e9,x)                 ; 59DA:  61 e9
b01_99dc:   sbc #$d5                    ; 59DC:  e9 d5
b01_99de:   .db vm_fp_lo                     ; 59DE:  04
b01_99df:   and $d8                     ; 59DF:  25 d8
b01_99e1:   .db $5b                     ; 59E1:  5b
b01_99e2:   txs                         ; 59E2:  9a
b01_99e3:   asl $d3                     ; 59E3:  06 d3
b01_99e5:   ora $c1,x                   ; 59E5:  15 c1
b01_99e7:   cld                         ; 59E7:  d8
b01_99e8:   .db $5b                     ; 59E8:  5b
b01_99e9:   txs                         ; 59E9:  9a
b01_99ea:   asl $d3                     ; 59EA:  06 d3
b01_99ec:   .db $b3                     ; 59EC:  b3
b01_99ed:   ora $b4                     ; 59ED:  05 b4
b01_99ef:   cpy $d8                     ; 59EF:  c4 d8
b01_99f1:   .db $ff                     ; 59F1:  ff
b01_99f2:   sta $138d,y                 ; 59F2:  99 8d 13
b01_99f5:   sbc #$0c                    ; 59F5:  e9 0c
b01_99f7:   inx                         ; 59F7:  e8
b01_99f8:   .db vm_sp_lo                     ; 59F8:  02
b01_99f9:   stx $faab                   ; 59F9:  8e ab fa
b01_99fc:   dec $08,x                   ; 59FC:  d6 08
b01_99fe:   txs                         ; 59FE:  9a
b01_99ff:   sta $e912                   ; 59FF:  8d 12 e9
b01_9a02:   .db $0c                     ; 5A02:  0c
b01_9a03:   inx                         ; 5A03:  e8
b01_9a04:   .db vm_sp_lo                     ; 5A04:  02
b01_9a05:   stx $fa8f                   ; 5A05:  8e 8f fa
b01_9a08:   sbc #$26                    ; 5A08:  e9 26
b01_9a0a:   .db $d3                     ; 5A0A:  d3
b01_9a0b:   .db vm_sp_lo                     ; 5A0B:  02
b01_9a0c:   asl $d3                     ; 5A0C:  06 d3
b01_9a0e:   ora $bc,x                   ; 5A0E:  15 bc
b01_9a10:   bvc $99d6                   ; 5A10:  50 c4
b01_9a12:   cld                         ; 5A12:  d8
b01_9a13:   ora $419a,y                 ; 5A13:  19 9a 41
b01_9a16:   dec $1b,x                   ; 5A16:  d6 1b
b01_9a18:   txs                         ; 5A18:  9a
b01_9a19:   .db skip_wallclock                     ; 5A19:  89
b01_9a1a:   .db $ff                     ; 5A1A:  ff
b01_9a1b:   .db $27                     ; 5A1B:  27
b01_9a1c:   .db vm_ip_hi                     ; 5A1C:  07
b01_9a1d:   .db $8b                     ; 5A1D:  8b
b01_9a1e:   .db $ff                     ; 5A1E:  ff
b01_9a1f:   cpy #$d8                    ; 5A1F:  c0 d8
b01_9a21:   and $ac9a                   ; 5A21:  2d 9a ac
b01_9a24:   nop                         ; 5A24:  ea
b01_9a25:   .db $d7                     ; 5A25:  d7
b01_9a26:   .db palette_dirty                     ; 5A26:  74
b01_9a27:   .db $d3                     ; 5A27:  d3
b01_9a28:   eor ($c2),y                 ; 5A28:  51 c2
b01_9a2a:   .db $d7                     ; 5A2A:  d7
b01_9a2b:   sec                         ; 5A2B:  38
b01_9a2c:   txs                         ; 5A2C:  9a
b01_9a2d:   .db vm_ip_hi                     ; 5A2D:  07
b01_9a2e:   .db $b3                     ; 5A2E:  b3
b01_9a2f:   ldy $d7ea                   ; 5A2F:  ac ea d7
b01_9a32:   .db palette_dirty                     ; 5A32:  74
b01_9a33:   ldy $b3,x                   ; 5A33:  b4 b3
b01_9a35:   .db $d3                     ; 5A35:  d3
b01_9a36:   .db $bb                     ; 5A36:  bb
b01_9a37:   .db $d4                     ; 5A37:  d4
b01_9a38:   asl $d3                     ; 5A38:  06 d3
b01_9a3a:   plp                         ; 5A3A:  28
b01_9a3b:   rol vm_fp_hi,x                   ; 5A3B:  36 05
b01_9a3d:   .db $d4                     ; 5A3D:  d4
b01_9a3e:   php                         ; 5A3E:  08
b01_9a3f:   ora $bc,x                   ; 5A3F:  15 bc
b01_9a41:   and $3b                     ; 5A41:  25 3b
b01_9a43:   and $0b,x                   ; 5A43:  35 0b
b01_9a45:   bcs $99fa                   ; 5A45:  b0 b3
b01_9a47:   sbc #$d6                    ; 5A47:  e9 d6
b01_9a49:   .db $82                     ; 5A49:  82
b01_9a4a:   .db vm_fp_lo                     ; 5A4A:  04
b01_9a4b:   lda ($3a),y                 ; 5A4B:  b1 3a
b01_9a4d:   and $0a,x                   ; 5A4D:  35 0a
b01_9a4f:   bcs $9a04                   ; 5A4F:  b0 b3
b01_9a51:   sbc #$d6                    ; 5A51:  e9 d6
b01_9a53:   .db $82                     ; 5A53:  82
b01_9a54:   .db vm_fp_lo                     ; 5A54:  04
b01_9a55:   lda ($ac),y                 ; 5A55:  b1 ac
b01_9a57:   ror $d7                     ; 5A57:  66 d7
b01_9a59:   eor ($cf,x)                 ; 5A59:  41 cf
b01_9a5b:   rti                         ; 5A5B:  40
b01_9a5c:   .db $cf                     ; 5A5C:  cf
driver_send:   jsr $e823                   ; 5A5D:  20 23 e8
b01_9a60:   .db $f4                     ; 5A60:  f4
b01_9a61:   .db $ff                     ; 5A61:  ff
b01_9a62:   adc ($e9,x)                 ; 5A62:  61 e9
b01_9a64:   bpl $9a4b                   ; 5A64:  10 e5
b01_9a66:   .db vm_sp_lo                     ; 5A66:  02
b01_9a67:   stx fief_index_list                   ; 5A67:  8e 89 6f
b01_9a6a:   .db $64                     ; 5A6A:  64
b01_9a6b:   sbc #$9f                    ; 5A6B:  e9 9f
b01_9a6d:   .db $87                     ; 5A6D:  87
b01_9a6e:   .db vm_fp_lo                     ; 5A6E:  04
b01_9a6f:   cld                         ; 5A6F:  d8
b01_9a70:   .db $7c                     ; 5A70:  7c
b01_9a71:   .db $9b                     ; 5A71:  9b
b01_9a72:   stx $fac8                   ; 5A72:  8e c8 fa
b01_9a75:   sbc #$c4                    ; 5A75:  e9 c4
b01_9a77:   dec $8e02                   ; 5A77:  ce 02 8e
b01_9a7a:   .db skip_wallclock                     ; 5A7A:  89
b01_9a7b:   .db p2_buttons                     ; 5A7B:  6f
b01_9a7c:   sbc #$4c                    ; 5A7C:  e9 4c
b01_9a7e:   .db skip_vblank_wait                     ; 5A7E:  80
b01_9a7f:   .db vm_sp_lo                     ; 5A7F:  02
b01_9a80:   plp                         ; 5A80:  28
b01_9a81:   cld                         ; 5A81:  d8
b01_9a82:   .db $7c                     ; 5A82:  7c
b01_9a83:   .db $9b                     ; 5A83:  9b
b01_9a84:   php                         ; 5A84:  08
b01_9a85:   cmp ($28),y                 ; 5A85:  d1 28
b01_9a87:   .db $8b                     ; 5A87:  8b
b01_9a88:   .db $1a                     ; 5A88:  1a
b01_9a89:   lda $8c,x                   ; 5A89:  b5 8c
b01_9a8b:   ora ($70,x)                 ; 5A8B:  01 70
b01_9a8d:   .db $bb                     ; 5A8D:  bb
b01_9a8e:   rol $8f                     ; 5A8E:  26 8f
b01_9a90:   clc                         ; 5A90:  18
b01_9a91:   bcs $9aba                   ; 5A91:  b0 27
b01_9a93:   rti                         ; 5A93:  40
b01_9a94:   .db $2b                     ; 5A94:  2b
b01_9a95:   rol a                       ; 5A95:  2a
b01_9a96:   ldy $cc89                   ; 5A96:  ac 89 cc
b01_9a99:   tax                         ; 5A99:  aa
b01_9a9a:   .db $5f                     ; 5A9A:  5f
b01_9a9b:   .db p2_buttons                     ; 5A9B:  6f
b01_9a9c:   sbc #$23                    ; 5A9C:  e9 23
b01_9a9e:   .db $93                     ; 5A9E:  93
b01_9a9f:   .db vm_sp_lo                     ; 5A9F:  02
b01_9aa0:   and #$d8                    ; 5AA0:  29 d8
b01_9aa2:   .db $e3                     ; 5AA2:  e3
b01_9aa3:   txs                         ; 5AA3:  9a
b01_9aa4:   and $7606,y                 ; 5AA4:  39 06 76
b01_9aa7:   bcs $9a5c                   ; 5AA7:  b0 b3
b01_9aa9:   .db $37                     ; 5AA9:  37
b01_9aaa:   sbc #$e5                    ; 5AAA:  e9 e5
b01_9aac:   .db $8b                     ; 5AAC:  8b
b01_9aad:   asl $29                     ; 5AAD:  06 29
b01_9aaf:   cld                         ; 5AAF:  d8
b01_9ab0:   cmp $8e9a,y                 ; 5AB0:  d9 9a 8e
b01_9ab3:   .db $ff                     ; 5AB3:  ff
b01_9ab4:   .db $fa                     ; 5AB4:  fa
b01_9ab5:   sbc #$c4                    ; 5AB5:  e9 c4
b01_9ab7:   dec $4102                   ; 5AB7:  ce 02 41
b01_9aba:   tay                         ; 5ABA:  a8
b01_9abb:   cpx #$7b                    ; 5ABB:  e0 7b
b01_9abd:   and $e961,y                 ; 5ABD:  39 61 e9
b01_9ac0:   sbc #$d5                    ; 5AC0:  e9 d5
b01_9ac2:   .db vm_fp_lo                     ; 5AC2:  04
b01_9ac3:   rol a                       ; 5AC3:  2a
b01_9ac4:   rti                         ; 5AC4:  40
b01_9ac5:   tay                         ; 5AC5:  a8
b01_9ac6:   cpx #$7b                    ; 5AC6:  e0 7b
b01_9ac8:   asl a                       ; 5AC8:  0a
b01_9ac9:   bvc $9a8e                   ; 5AC9:  50 c3
b01_9acb:   cld                         ; 5ACB:  d8
b01_9acc:   .db $e3                     ; 5ACC:  e3
b01_9acd:   txs                         ; 5ACD:  9a
b01_9ace:   ldy $cc89                   ; 5ACE:  ac 89 cc
b01_9ad1:   asl a                       ; 5AD1:  0a
b01_9ad2:   bvc $9a96                   ; 5AD2:  50 c2
b01_9ad4:   cld                         ; 5AD4:  d8
b01_9ad5:   .db $e3                     ; 5AD5:  e3
b01_9ad6:   txs                         ; 5AD6:  9a
b01_9ad7:   rti                         ; 5AD7:  40
b01_9ad8:   .db $cf                     ; 5AD8:  cf
b01_9ad9:   stx $fdc6                   ; 5AD9:  8e c6 fd
b01_9adc:   sbc #$c4                    ; 5ADC:  e9 c4
b01_9ade:   dec $ac02                   ; 5ADE:  ce 02 ac
b01_9ae1:   ror $d7                     ; 5AE1:  66 d7
b01_9ae3:   tax                         ; 5AE3:  aa
b01_9ae4:   .db $5f                     ; 5AE4:  5f
b01_9ae5:   .db p2_buttons                     ; 5AE5:  6f
b01_9ae6:   sbc #$51                    ; 5AE6:  e9 51
b01_9ae8:   .db $93                     ; 5AE8:  93
b01_9ae9:   .db vm_sp_lo                     ; 5AE9:  02
b01_9aea:   and #$d8                    ; 5AEA:  29 d8
b01_9aec:   bit $399b                   ; 5AEC:  2c 9b 39
b01_9aef:   asl nmi_skip_all                     ; 5AEF:  06 b0
b01_9af1:   .db $b3                     ; 5AF1:  b3
b01_9af2:   .db $37                     ; 5AF2:  37
b01_9af3:   sbc #$e5                    ; 5AF3:  e9 e5
b01_9af5:   .db $8b                     ; 5AF5:  8b
b01_9af6:   asl $29                     ; 5AF6:  06 29
b01_9af8:   cld                         ; 5AF8:  d8
b01_9af9:   .db $22                     ; 5AF9:  22
b01_9afa:   .db $9b                     ; 5AFA:  9b
b01_9afb:   stx $fafa                   ; 5AFB:  8e fa fa
b01_9afe:   sbc #$c4                    ; 5AFE:  e9 c4
b01_9b00:   dec $4102                   ; 5B00:  ce 02 41
b01_9b03:   tay                         ; 5B03:  a8
b01_9b04:   cpx #$7b                    ; 5B04:  e0 7b
b01_9b06:   and $e961,y                 ; 5B06:  39 61 e9
b01_9b09:   sbc #$d5                    ; 5B09:  e9 d5
b01_9b0b:   .db vm_fp_lo                     ; 5B0B:  04
b01_9b0c:   .db $2b                     ; 5B0C:  2b
b01_9b0d:   rti                         ; 5B0D:  40
b01_9b0e:   tay                         ; 5B0E:  a8
b01_9b0f:   cpx #$7b                    ; 5B0F:  e0 7b
b01_9b11:   .db $0b                     ; 5B11:  0b
b01_9b12:   bvc $9ad7                   ; 5B12:  50 c3
b01_9b14:   cld                         ; 5B14:  d8
b01_9b15:   bit $ac9b                   ; 5B15:  2c 9b ac
b01_9b18:   .db skip_wallclock                     ; 5B18:  89
b01_9b19:   cpy $500b                   ; 5B19:  cc 0b 50
b01_9b1c:   .db $c2                     ; 5B1C:  c2
b01_9b1d:   cld                         ; 5B1D:  d8
b01_9b1e:   bit $409b                   ; 5B1E:  2c 9b 40
b01_9b21:   .db $cf                     ; 5B21:  cf
b01_9b22:   stx $fdc6                   ; 5B22:  8e c6 fd
b01_9b25:   sbc #$c4                    ; 5B25:  e9 c4
b01_9b27:   dec $ac02                   ; 5B27:  ce 02 ac
b01_9b2a:   ror $d7                     ; 5B2A:  66 d7
b01_9b2c:   .db $0b                     ; 5B2C:  0b
b01_9b2d:   .db $d7                     ; 5B2D:  d7
b01_9b2e:   .db $34                     ; 5B2E:  34
b01_9b2f:   .db $9b                     ; 5B2F:  9b
b01_9b30:   asl a                       ; 5B30:  0a
b01_9b31:   cld                         ; 5B31:  d8
b01_9b32:   .db $7c                     ; 5B32:  7c
b01_9b33:   .db $9b                     ; 5B33:  9b
b01_9b34:   stx $bbe3                   ; 5B34:  8e e3 bb
b01_9b37:   sbc #$c4                    ; 5B37:  e9 c4
b01_9b39:   dec $ac02                   ; 5B39:  ce 02 ac
b01_9b3c:   .db $a7                     ; 5B3C:  a7
b01_9b3d:   .db $d3                     ; 5B3D:  d3
b01_9b3e:   cld                         ; 5B3E:  d8
b01_9b3f:   .db $7c                     ; 5B3F:  7c
b01_9b40:   .db $9b                     ; 5B40:  9b
b01_9b41:   .db $3b                     ; 5B41:  3b
b01_9b42:   asl $b4                     ; 5B42:  06 b4
b01_9b44:   .db $b3                     ; 5B44:  b3
b01_9b45:   bcs $9b02                   ; 5B45:  b0 bb
b01_9b47:   lda ($3a),y                 ; 5B47:  b1 3a
b01_9b49:   asl mul_acc_hi                     ; 5B49:  06 76
b01_9b4b:   ldy $b3,x                   ; 5B4B:  b4 b3
b01_9b4d:   bcs $9b0a                   ; 5B4D:  b0 bb
b01_9b4f:   lda ($a4),y                 ; 5B4F:  b1 a4
b01_9b51:   .db $5f                     ; 5B51:  5f
b01_9b52:   .db p2_buttons                     ; 5B52:  6f
b01_9b53:   .db $8b                     ; 5B53:  8b
b01_9b54:   .db $1a                     ; 5B54:  1a
b01_9b55:   lda $8c,x                   ; 5B55:  b5 8c
b01_9b57:   ora ($70,x)                 ; 5B57:  01 70
b01_9b59:   .db $bb                     ; 5B59:  bb
b01_9b5a:   rol $3b                     ; 5B5A:  26 3b
b01_9b5c:   asl $b4                     ; 5B5C:  06 b4
b01_9b5e:   .db $b3                     ; 5B5E:  b3
b01_9b5f:   bcs $9b1d                   ; 5B5F:  b0 bc
b01_9b61:   lda ($3a),y                 ; 5B61:  b1 3a
b01_9b63:   asl mul_acc_hi                     ; 5B63:  06 76
b01_9b65:   ldy $b3,x                   ; 5B65:  b4 b3
b01_9b67:   bcs $9b25                   ; 5B67:  b0 bc
b01_9b69:   lda ($8d),y                 ; 5B69:  b1 8d
b01_9b6b:   ora ($e9),y                 ; 5B6B:  11 e9
b01_9b6d:   .db $0c                     ; 5B6D:  0c
b01_9b6e:   inx                         ; 5B6E:  e8
b01_9b6f:   .db vm_sp_lo                     ; 5B6F:  02
b01_9b70:   stx $fb04                   ; 5B70:  8e 04 fb
b01_9b73:   sbc #$c4                    ; 5B73:  e9 c4
b01_9b75:   dec $ac02                   ; 5B75:  ce 02 ac
b01_9b78:   ror $d7                     ; 5B78:  66 d7
b01_9b7a:   eor ($cf,x)                 ; 5B7A:  41 cf
b01_9b7c:   rti                         ; 5B7C:  40
b01_9b7d:   .db $cf                     ; 5B7D:  cf
driver_dam:   jsr $e823                   ; 5B7E:  20 23 e8
b01_9b81:   sed                         ; 5B81:  f8
b01_9b82:   .db $ff                     ; 5B82:  ff
b01_9b83:   ldy $5f                     ; 5B83:  a4 5f
b01_9b85:   .db p2_buttons                     ; 5B85:  6f
b01_9b86:   .db $8b                     ; 5B86:  8b
b01_9b87:   .db $1a                     ; 5B87:  1a
b01_9b88:   lda $8c,x                   ; 5B88:  b5 8c
b01_9b8a:   ora #$70                    ; 5B8A:  09 70
b01_9b8c:   .db $bb                     ; 5B8C:  bb
b01_9b8d:   bcs $9b66                   ; 5B8D:  b0 d7
b01_9b8f:   sta $8e9b,x                 ; 5B8F:  9d 9b 8e
b01_9b92:   .db $13                     ; 5B92:  13
b01_9b93:   inc $26e9,x                 ; 5B93:  fe e9 26
b01_9b96:   .db $d3                     ; 5B96:  d3
b01_9b97:   .db vm_sp_lo                     ; 5B97:  02
b01_9b98:   ldy $d766                   ; 5B98:  ac 66 d7
b01_9b9b:   rti                         ; 5B9B:  40
b01_9b9c:   .db $cf                     ; 5B9C:  cf
b01_9b9d:   ldy $5f                     ; 5B9D:  a4 5f
b01_9b9f:   .db p2_buttons                     ; 5B9F:  6f
b01_9ba0:   .db $8b                     ; 5BA0:  8b
b01_9ba1:   .db $1a                     ; 5BA1:  1a
b01_9ba2:   lda $8c,x                   ; 5BA2:  b5 8c
b01_9ba4:   ora ($70,x)                 ; 5BA4:  01 70
b01_9ba6:   .db $bb                     ; 5BA6:  bb
b01_9ba7:   plp                         ; 5BA7:  28
b01_9ba8:   .db music_ptr_lo                     ; 5BA8:  7a
b01_9ba9:   rol a                       ; 5BA9:  2a
b01_9baa:   asl a                       ; 5BAA:  0a
b01_9bab:   bcs $9b38                   ; 5BAB:  b0 8b
b01_9bad:   .db $64                     ; 5BAD:  64
b01_9bae:   cmp $d8                     ; 5BAE:  c5 d8
b01_9bb0:   ldx $8e9b,y                 ; 5BB0:  be 9b 8e
b01_9bb3:   dec $fd                     ; 5BB3:  c6 fd
b01_9bb5:   sbc #$26                    ; 5BB5:  e9 26
b01_9bb7:   .db $d3                     ; 5BB7:  d3
b01_9bb8:   .db vm_sp_lo                     ; 5BB8:  02
b01_9bb9:   ldy $d766                   ; 5BB9:  ac 66 d7
b01_9bbc:   rti                         ; 5BBC:  40
b01_9bbd:   .db $cf                     ; 5BBD:  cf
b01_9bbe:   php                         ; 5BBE:  08
b01_9bbf:   bcs $9b98                   ; 5BBF:  b0 d7
b01_9bc1:   .db $cf                     ; 5BC1:  cf
b01_9bc2:   .db $9b                     ; 5BC2:  9b
b01_9bc3:   stx $fdd9                   ; 5BC3:  8e d9 fd
b01_9bc6:   sbc #$26                    ; 5BC6:  e9 26
b01_9bc8:   .db $d3                     ; 5BC8:  d3
b01_9bc9:   .db vm_sp_lo                     ; 5BC9:  02
b01_9bca:   ldy $d766                   ; 5BCA:  ac 66 d7
b01_9bcd:   rti                         ; 5BCD:  40
b01_9bce:   .db $cf                     ; 5BCE:  cf
b01_9bcf:   php                         ; 5BCF:  08
b01_9bd0:   .db music_ptr_lo                     ; 5BD0:  7a
b01_9bd1:   bcs $9b86                   ; 5BD1:  b0 b3
b01_9bd3:   .db skip_wallclock                     ; 5BD3:  89
b01_9bd4:   .db $64                     ; 5BD4:  64
b01_9bd5:   ldy $bc,x                   ; 5BD5:  b4 bc
b01_9bd7:   .db $b3                     ; 5BD7:  b3
b01_9bd8:   sec                         ; 5BD8:  38
b01_9bd9:   sbc #$d8                    ; 5BD9:  e9 d8
b01_9bdb:   .db $87                     ; 5BDB:  87
b01_9bdc:   .db vm_sp_lo                     ; 5BDC:  02
b01_9bdd:   ldy $b5,x                   ; 5BDD:  b4 b5
b01_9bdf:   .db $52                     ; 5BDF:  52
b01_9be0:   ldx $b3,y                   ; 5BE0:  b6 b3
b01_9be2:   php                         ; 5BE2:  08
b01_9be3:   bcs $9b98                   ; 5BE3:  b0 b3
b01_9be5:   sbc #$5e                    ; 5BE5:  e9 5e
b01_9be7:   .db $cb                     ; 5BE7:  cb
b01_9be8:   .db vm_fp_lo                     ; 5BE8:  04
b01_9be9:   .db $2b                     ; 5BE9:  2b
b01_9bea:   stx $bbee                   ; 5BEA:  8e ee bb
b01_9bed:   sbc #$26                    ; 5BED:  e9 26
b01_9bef:   .db $d3                     ; 5BEF:  d3
b01_9bf0:   .db vm_sp_lo                     ; 5BF0:  02
b01_9bf1:   asl a                       ; 5BF1:  0a
b01_9bf2:   bcs $9ba7                   ; 5BF2:  b0 b3
b01_9bf4:   stx $bbef                   ; 5BF4:  8e ef bb
b01_9bf7:   stx $fb25                   ; 5BF7:  8e 25 fb
b01_9bfa:   sbc #$34                    ; 5BFA:  e9 34
b01_9bfc:   cmp (vm_ip_lo),y                 ; 5BFC:  d1 06
b01_9bfe:   .db $3b                     ; 5BFE:  3b
b01_9bff:   adc ($e9,x)                 ; 5BFF:  61 e9
b01_9c01:   sbc #$d5                    ; 5C01:  e9 d5
b01_9c03:   .db vm_fp_lo                     ; 5C03:  04
b01_9c04:   and #$d8                    ; 5C04:  29 d8
b01_9c06:   lsr $399c                   ; 5C06:  4e 9c 39
b01_9c09:   php                         ; 5C09:  08
b01_9c0a:   ldy $b3,x                   ; 5C0A:  b4 b3
b01_9c0c:   bcs $9bca                   ; 5C0C:  b0 bc
b01_9c0e:   lda ($38),y                 ; 5C0E:  b1 38
b01_9c10:   sbc #$d8                    ; 5C10:  e9 d8
b01_9c12:   .db $87                     ; 5C12:  87
b01_9c13:   .db vm_sp_lo                     ; 5C13:  02
b01_9c14:   .db $b3                     ; 5C14:  b3
b01_9c15:   ora #$d2                    ; 5C15:  09 d2
b01_9c17:   ldy $b6,x                   ; 5C17:  b4 b6
b01_9c19:   and #$d7                    ; 5C19:  29 d7
b01_9c1b:   jsr $099c                   ; 5C1B:  20 9c 09
b01_9c1e:   bne $9c49                   ; 5C1E:  d0 29
b01_9c20:   .db $3a                     ; 5C20:  3a
b01_9c21:   and $7de9,y                 ; 5C21:  39 e9 7d
b01_9c24:   dey                         ; 5C24:  88
b01_9c25:   .db vm_fp_lo                     ; 5C25:  04
b01_9c26:   sta $e915                   ; 5C26:  8d 15 e9
b01_9c29:   .db $0c                     ; 5C29:  0c
b01_9c2a:   inx                         ; 5C2A:  e8
b01_9c2b:   .db vm_sp_lo                     ; 5C2B:  02
b01_9c2c:   asl a                       ; 5C2C:  0a
b01_9c2d:   bcs $9bba                   ; 5C2D:  b0 8b
b01_9c2f:   .db $64                     ; 5C2F:  64
b01_9c30:   cpy $d8                     ; 5C30:  c4 d8
b01_9c32:   sec                         ; 5C32:  38
b01_9c33:   .db $9c                     ; 5C33:  9c
b01_9c34:   .db $3a                     ; 5C34:  3a
b01_9c35:   .db skip_wallclock                     ; 5C35:  89
b01_9c36:   .db $64                     ; 5C36:  64
b01_9c37:   lda ($8e),y                 ; 5C37:  b1 8e
b01_9c39:   .db $fa                     ; 5C39:  fa
b01_9c3a:   .db $bb                     ; 5C3A:  bb
b01_9c3b:   sbc #$26                    ; 5C3B:  e9 26
b01_9c3d:   .db $d3                     ; 5C3D:  d3
b01_9c3e:   .db vm_sp_lo                     ; 5C3E:  02
b01_9c3f:   asl a                       ; 5C3F:  0a
b01_9c40:   bcs $9bf5                   ; 5C40:  b0 b3
b01_9c42:   stx $fb43                   ; 5C42:  8e 43 fb
b01_9c45:   sbc #$34                    ; 5C45:  e9 34
b01_9c47:   cmp (vm_fp_lo),y                 ; 5C47:  d1 04
b01_9c49:   ldy $d766                   ; 5C49:  ac 66 d7
b01_9c4c:   eor ($cf,x)                 ; 5C4C:  41 cf
b01_9c4e:   .db $cf                     ; 5C4E:  cf
driver_pact:   jsr $e823                   ; 5C4F:  20 23 e8
b01_9c52:   .db $fa                     ; 5C52:  fa
b01_9c53:   .db $ff                     ; 5C53:  ff
b01_9c54:   ldy $5f                     ; 5C54:  a4 5f
b01_9c56:   .db p2_buttons                     ; 5C56:  6f
b01_9c57:   .db $8b                     ; 5C57:  8b
b01_9c58:   .db $1a                     ; 5C58:  1a
b01_9c59:   lda $8c,x                   ; 5C59:  b5 8c
b01_9c5b:   ora ($70,x)                 ; 5C5B:  01 70
b01_9c5d:   .db $bb                     ; 5C5D:  bb
b01_9c5e:   .db $2b                     ; 5C5E:  2b
b01_9c5f:   rti                         ; 5C5F:  40
b01_9c60:   and #$60                    ; 5C60:  29 60
b01_9c62:   sbc #$10                    ; 5C62:  e9 10
b01_9c64:   sbc vm_sp_lo                     ; 5C64:  e5 02
b01_9c66:   stx fief_index_list                   ; 5C66:  8e 89 6f
b01_9c69:   ror $e9                     ; 5C69:  66 e9
b01_9c6b:   .db $9f                     ; 5C6B:  9f
b01_9c6c:   .db $87                     ; 5C6C:  87
b01_9c6d:   .db vm_fp_lo                     ; 5C6D:  04
b01_9c6e:   cld                         ; 5C6E:  d8
b01_9c6f:   .db $3b                     ; 5C6F:  3b
b01_9c70:   sta $9c8e,x                 ; 5C70:  9d 8e 9c
b01_9c73:   .db $fc                     ; 5C73:  fc
b01_9c74:   sbc #$c4                    ; 5C74:  e9 c4
b01_9c76:   dec $8e02                   ; 5C76:  ce 02 8e
b01_9c79:   .db skip_wallclock                     ; 5C79:  89
b01_9c7a:   .db p2_buttons                     ; 5C7A:  6f
b01_9c7b:   sbc #$4c                    ; 5C7B:  e9 4c
b01_9c7d:   .db skip_vblank_wait                     ; 5C7D:  80
b01_9c7e:   .db vm_sp_lo                     ; 5C7E:  02
b01_9c7f:   tay                         ; 5C7F:  a8
b01_9c80:   .db $63                     ; 5C80:  63
b01_9c81:   .db p2_buttons                     ; 5C81:  6f
b01_9c82:   cld                         ; 5C82:  d8
b01_9c83:   and $a49d,y                 ; 5C83:  39 9d a4
b01_9c86:   .db $63                     ; 5C86:  63
b01_9c87:   .db p2_buttons                     ; 5C87:  6f
b01_9c88:   cmp ($a8),y                 ; 5C88:  d1 a8
b01_9c8a:   .db $63                     ; 5C8A:  63
b01_9c8b:   .db p2_buttons                     ; 5C8B:  6f
b01_9c8c:   ldy $d7ea                   ; 5C8C:  ac ea d7
b01_9c8f:   .db ppumask_shadow                     ; 5C8F:  72
b01_9c90:   .db $b3                     ; 5C90:  b3
b01_9c91:   .db $d3                     ; 5C91:  d3
b01_9c92:   cmp ($d4),y                 ; 5C92:  d1 d4
b01_9c94:   eor ($29,x)                 ; 5C94:  41 29
b01_9c96:   ldy $cc89                   ; 5C96:  ac 89 cc
b01_9c99:   ldy $e3a4                   ; 5C99:  ac a4 e3
b01_9c9c:   rol a                       ; 5C9C:  2a
b01_9c9d:   cld                         ; 5C9D:  d8
b01_9c9e:   ora $3a9d,y                 ; 5C9E:  19 9d 3a
b01_9ca1:   tax                         ; 5CA1:  aa
b01_9ca2:   .db $63                     ; 5CA2:  63
b01_9ca3:   .db p2_buttons                     ; 5CA3:  6f
b01_9ca4:   sbc #$72                    ; 5CA4:  e9 72
b01_9ca6:   .db $d7                     ; 5CA6:  d7
b01_9ca7:   .db vm_sp_lo                     ; 5CA7:  02
b01_9ca8:   eor $8cb5,y                 ; 5CA8:  59 b5 8c
b01_9cab:   tay                         ; 5CAB:  a8
b01_9cac:   .db $77                     ; 5CAC:  77
b01_9cad:   .db $bb                     ; 5CAD:  bb
b01_9cae:   .db $b3                     ; 5CAE:  b3
b01_9caf:   ldy $d77e                   ; 5CAF:  ac 7e d7
b01_9cb2:   eor $8cb5,y                 ; 5CB2:  59 b5 8c
b01_9cb5:   tay                         ; 5CB5:  a8
b01_9cb6:   .db $77                     ; 5CB6:  77
b01_9cb7:   .db $bb                     ; 5CB7:  bb
b01_9cb8:   .db $b3                     ; 5CB8:  b3
b01_9cb9:   stx $fd27                   ; 5CB9:  8e 27 fd
b01_9cbc:   sbc #$34                    ; 5CBC:  e9 34
b01_9cbe:   cmp ($08),y                 ; 5CBE:  d1 08
b01_9cc0:   ldy $d3a7                   ; 5CC0:  ac a7 d3
b01_9cc3:   cld                         ; 5CC3:  d8
b01_9cc4:   ora $9d                     ; 5CC4:  05 9d
b01_9cc6:   .db $0b                     ; 5CC6:  0b
b01_9cc7:   bcs $9ce3                   ; 5CC7:  b0 1a
b01_9cc9:   .db $c2                     ; 5CC9:  c2
b01_9cca:   cld                         ; 5CCA:  d8
b01_9ccb:   .db $d7                     ; 5CCB:  d7
b01_9ccc:   .db $9c                     ; 5CCC:  9c
b01_9ccd:   stx $fdd9                   ; 5CCD:  8e d9 fd
b01_9cd0:   sbc #$26                    ; 5CD0:  e9 26
b01_9cd2:   .db $d3                     ; 5CD2:  d3
b01_9cd3:   .db vm_sp_lo                     ; 5CD3:  02
b01_9cd4:   dec $14,x                   ; 5CD4:  d6 14
b01_9cd6:   sta $e960,x                 ; 5CD6:  9d 60 e9
b01_9cd9:   .db $8f                     ; 5CD9:  8f
b01_9cda:   .db $8b                     ; 5CDA:  8b
b01_9cdb:   .db vm_sp_lo                     ; 5CDB:  02
b01_9cdc:   .db $3a                     ; 5CDC:  3a
b01_9cdd:   .db $0b                     ; 5CDD:  0b
b01_9cde:   ldy $b3,x                   ; 5CDE:  b4 b3
b01_9ce0:   bcs $9c9e                   ; 5CE0:  b0 bc
b01_9ce2:   lda ($3a),y                 ; 5CE2:  b1 3a
b01_9ce4:   ldy $63                     ; 5CE4:  a4 63
b01_9ce6:   .db p2_buttons                     ; 5CE6:  6f
b01_9ce7:   .db $8b                     ; 5CE7:  8b
b01_9ce8:   .db $1a                     ; 5CE8:  1a
b01_9ce9:   lda $8c,x                   ; 5CE9:  b5 8c
b01_9ceb:   ora ($70,x)                 ; 5CEB:  01 70
b01_9ced:   .db $bb                     ; 5CED:  bb
b01_9cee:   ldy $b3,x                   ; 5CEE:  b4 b3
b01_9cf0:   bcs $9cad                   ; 5CF0:  b0 bb
b01_9cf2:   lda ($ac),y                 ; 5CF2:  b1 ac
b01_9cf4:   .db $4f                     ; 5CF4:  4f
b01_9cf5:   .db $da                     ; 5CF5:  da
b01_9cf6:   .db $63                     ; 5CF6:  63
b01_9cf7:   sbc #$0c                    ; 5CF7:  e9 0c
b01_9cf9:   inx                         ; 5CF9:  e8
b01_9cfa:   .db vm_sp_lo                     ; 5CFA:  02
b01_9cfb:   stx $fd63                   ; 5CFB:  8e 63 fd
b01_9cfe:   sbc #$26                    ; 5CFE:  e9 26
b01_9d00:   .db $d3                     ; 5D00:  d3
b01_9d01:   .db vm_sp_lo                     ; 5D01:  02
b01_9d02:   dec $14,x                   ; 5D02:  d6 14
b01_9d04:   sta $938e,x                 ; 5D04:  9d 8e 93
b01_9d07:   sbc $26e9,x                 ; 5D07:  fd e9 26
b01_9d0a:   .db $d3                     ; 5D0A:  d3
b01_9d0b:   .db vm_sp_lo                     ; 5D0B:  02
b01_9d0c:   ldy $d7ea                   ; 5D0C:  ac ea d7
b01_9d0f:   .db ppumask_shadow                     ; 5D0F:  72
b01_9d10:   .db $b3                     ; 5D10:  b3
b01_9d11:   .db $d3                     ; 5D11:  d3
b01_9d12:   cmp ($d4),y                 ; 5D12:  d1 d4
b01_9d14:   ldy $d766                   ; 5D14:  ac 66 d7
b01_9d17:   ora #$cf                    ; 5D17:  09 cf
b01_9d19:   adc ($e9,x)                 ; 5D19:  61 e9
b01_9d1b:   .db $8f                     ; 5D1B:  8f
b01_9d1c:   .db $8b                     ; 5D1C:  8b
b01_9d1d:   .db vm_sp_lo                     ; 5D1D:  02
b01_9d1e:   stx $bbfb                   ; 5D1E:  8e fb bb
b01_9d21:   sbc #$26                    ; 5D21:  e9 26
b01_9d23:   .db $d3                     ; 5D23:  d3
b01_9d24:   .db vm_sp_lo                     ; 5D24:  02
b01_9d25:   ldy $d77e                   ; 5D25:  ac 7e d7
b01_9d28:   eor $8cb5,y                 ; 5D28:  59 b5 8c
b01_9d2b:   tay                         ; 5D2B:  a8
b01_9d2c:   .db $77                     ; 5D2C:  77
b01_9d2d:   .db $bb                     ; 5D2D:  bb
b01_9d2e:   .db $b3                     ; 5D2E:  b3
b01_9d2f:   stx $fcaa                   ; 5D2F:  8e aa fc
b01_9d32:   sbc #$34                    ; 5D32:  e9 34
b01_9d34:   cmp (vm_fp_lo),y                 ; 5D34:  d1 04
b01_9d36:   dec $0c,x                   ; 5D36:  d6 0c
b01_9d38:   sta $cf09,x                 ; 5D38:  9d 09 cf
b01_9d3b:   ora #$cf                    ; 5D3B:  09 cf
driver_grow:   jsr $e823                   ; 5D3D:  20 23 e8
b01_9d40:   .db $fc                     ; 5D40:  fc
b01_9d41:   .db $ff                     ; 5D41:  ff
b01_9d42:   ldy $5f                     ; 5D42:  a4 5f
b01_9d44:   .db p2_buttons                     ; 5D44:  6f
b01_9d45:   .db $8b                     ; 5D45:  8b
b01_9d46:   .db $1a                     ; 5D46:  1a
b01_9d47:   lda $8c,x                   ; 5D47:  b5 8c
b01_9d49:   ora ($70,x)                 ; 5D49:  01 70
b01_9d4b:   .db $bb                     ; 5D4B:  bb
b01_9d4c:   .db $2b                     ; 5D4C:  2b
b01_9d4d:   .db $0b                     ; 5D4D:  0b
b01_9d4e:   sei                         ; 5D4E:  78
b01_9d4f:   bcs $9d04                   ; 5D4F:  b0 b3
b01_9d51:   .db $0b                     ; 5D51:  0b
b01_9d52:   .db $8f                     ; 5D52:  8f
b01_9d53:   clc                         ; 5D53:  18
b01_9d54:   bcs $9d0a                   ; 5D54:  b0 b4
b01_9d56:   .db $c3                     ; 5D56:  c3
b01_9d57:   cld                         ; 5D57:  d8
b01_9d58:   ror $9d                     ; 5D58:  66 9d
b01_9d5a:   stx $fdc6                   ; 5D5A:  8e c6 fd
b01_9d5d:   sbc #$26                    ; 5D5D:  e9 26
b01_9d5f:   .db $d3                     ; 5D5F:  d3
b01_9d60:   .db vm_sp_lo                     ; 5D60:  02
b01_9d61:   ldy $d766                   ; 5D61:  ac 66 d7
b01_9d64:   rti                         ; 5D64:  40
b01_9d65:   .db $cf                     ; 5D65:  cf
b01_9d66:   .db $0b                     ; 5D66:  0b
b01_9d67:   bcs $9d41                   ; 5D67:  b0 d8
b01_9d69:   clv                         ; 5D69:  b8
b01_9d6a:   sta $fc8e,x                 ; 5D6A:  9d 8e fc
b01_9d6d:   .db $bb                     ; 5D6D:  bb
b01_9d6e:   sbc #$26                    ; 5D6E:  e9 26
b01_9d70:   .db $d3                     ; 5D70:  d3
b01_9d71:   .db vm_sp_lo                     ; 5D71:  02
b01_9d72:   .db $0b                     ; 5D72:  0b
b01_9d73:   sei                         ; 5D73:  78
b01_9d74:   bcs $9d29                   ; 5D74:  b0 b3
b01_9d76:   stx $bbfd                   ; 5D76:  8e fd bb
b01_9d79:   stx $fb25                   ; 5D79:  8e 25 fb
b01_9d7c:   sbc #$34                    ; 5D7C:  e9 34
b01_9d7e:   cmp (vm_ip_lo),y                 ; 5D7E:  d1 06
b01_9d80:   .db $0b                     ; 5D80:  0b
b01_9d81:   bcs $9d36                   ; 5D81:  b0 b3
b01_9d83:   adc ($e9,x)                 ; 5D83:  61 e9
b01_9d85:   sbc #$d5                    ; 5D85:  e9 d5
b01_9d87:   .db vm_fp_lo                     ; 5D87:  04
b01_9d88:   rol a                       ; 5D88:  2a
b01_9d89:   cld                         ; 5D89:  d8
b01_9d8a:   ldx $9d,y                   ; 5D8A:  b6 9d
b01_9d8c:   .db $3a                     ; 5D8C:  3a
b01_9d8d:   .db $0b                     ; 5D8D:  0b
b01_9d8e:   ldy $b3,x                   ; 5D8E:  b4 b3
b01_9d90:   bcs $9d4e                   ; 5D90:  b0 bc
b01_9d92:   lda ($3a),y                 ; 5D92:  b1 3a
b01_9d94:   .db $3b                     ; 5D94:  3b
b01_9d95:   sbc #$f0                    ; 5D95:  e9 f0
b01_9d97:   .db $87                     ; 5D97:  87
b01_9d98:   .db vm_fp_lo                     ; 5D98:  04
b01_9d99:   rol a                       ; 5D99:  2a
b01_9d9a:   adc #$e9                    ; 5D9A:  69 e9
b01_9d9c:   .db $0c                     ; 5D9C:  0c
b01_9d9d:   inx                         ; 5D9D:  e8
b01_9d9e:   .db vm_sp_lo                     ; 5D9E:  02
b01_9d9f:   stx $bc04                   ; 5D9F:  8e 04 bc
b01_9da2:   sbc #$26                    ; 5DA2:  e9 26
b01_9da4:   .db $d3                     ; 5DA4:  d3
b01_9da5:   .db vm_sp_lo                     ; 5DA5:  02
b01_9da6:   .db $0b                     ; 5DA6:  0b
b01_9da7:   sei                         ; 5DA7:  78
b01_9da8:   bcs $9d5d                   ; 5DA8:  b0 b3
b01_9daa:   stx $fb58                   ; 5DAA:  8e 58 fb
b01_9dad:   sbc #$34                    ; 5DAD:  e9 34
b01_9daf:   cmp (vm_fp_lo),y                 ; 5DAF:  d1 04
b01_9db1:   ldy $d766                   ; 5DB1:  ac 66 d7
b01_9db4:   eor ($cf,x)                 ; 5DB4:  41 cf
b01_9db6:   rti                         ; 5DB6:  40
b01_9db7:   .db $cf                     ; 5DB7:  cf
b01_9db8:   stx $fdd9                   ; 5DB8:  8e d9 fd
b01_9dbb:   sbc #$26                    ; 5DBB:  e9 26
b01_9dbd:   .db $d3                     ; 5DBD:  d3
b01_9dbe:   .db vm_sp_lo                     ; 5DBE:  02
b01_9dbf:   ldy $d766                   ; 5DBF:  ac 66 d7
b01_9dc2:   rti                         ; 5DC2:  40
b01_9dc3:   .db $cf                     ; 5DC3:  cf
driver_marry:   jsr $e823                   ; 5DC4:  20 23 e8
b01_9dc7:   sed                         ; 5DC7:  f8
b01_9dc8:   .db $ff                     ; 5DC8:  ff
b01_9dc9:   rti                         ; 5DC9:  40
b01_9dca:   rol a                       ; 5DCA:  2a
b01_9dcb:   ldy $d7ea                   ; 5DCB:  ac ea d7
b01_9dce:   plp                         ; 5DCE:  28
b01_9dcf:   ldy $5f                     ; 5DCF:  a4 5f
b01_9dd1:   .db p2_buttons                     ; 5DD1:  6f
b01_9dd2:   sty fief_is_daimyo_capital                   ; 5DD2:  8c a2 6d
b01_9dd5:   .db $bb                     ; 5DD5:  bb
b01_9dd6:   .db $d3                     ; 5DD6:  d3
b01_9dd7:   cld                         ; 5DD7:  d8
b01_9dd8:   .db $fc                     ; 5DD8:  fc
b01_9dd9:   .db $9e                     ; 5DD9:  9e
b01_9dda:   ldy $d77e                   ; 5DDA:  ac 7e d7
b01_9ddd:   .db $b3                     ; 5DDD:  b3
b01_9dde:   sbc #$dc                    ; 5DDE:  e9 dc
b01_9de0:   cpx vm_sp_lo                     ; 5DE0:  e4 02
b01_9de2:   stx fief_index_list                   ; 5DE2:  8e 89 6f
b01_9de5:   pla                         ; 5DE5:  68
b01_9de6:   sbc #$9f                    ; 5DE6:  e9 9f
b01_9de8:   .db $87                     ; 5DE8:  87
b01_9de9:   .db vm_fp_lo                     ; 5DE9:  04
b01_9dea:   cld                         ; 5DEA:  d8
b01_9deb:   .db $fa                     ; 5DEB:  fa
b01_9dec:   .db $9e                     ; 5DEC:  9e
b01_9ded:   stx $fc9c                   ; 5DED:  8e 9c fc
b01_9df0:   sbc #$c4                    ; 5DF0:  e9 c4
b01_9df2:   dec $8e02                   ; 5DF2:  ce 02 8e
b01_9df5:   .db skip_wallclock                     ; 5DF5:  89
b01_9df6:   .db p2_buttons                     ; 5DF6:  6f
b01_9df7:   sbc #$4c                    ; 5DF7:  e9 4c
b01_9df9:   .db skip_vblank_wait                     ; 5DF9:  80
b01_9dfa:   .db vm_sp_lo                     ; 5DFA:  02
b01_9dfb:   tay                         ; 5DFB:  a8
b01_9dfc:   .db $63                     ; 5DFC:  63
b01_9dfd:   .db p2_buttons                     ; 5DFD:  6f
b01_9dfe:   cld                         ; 5DFE:  d8
b01_9dff:   sed                         ; 5DFF:  f8
b01_9e00:   .db $9e                     ; 5E00:  9e
b01_9e01:   php                         ; 5E01:  08
b01_9e02:   .db ppumask_shadow                     ; 5E02:  72
b01_9e03:   .db $b3                     ; 5E03:  b3
b01_9e04:   .db $d3                     ; 5E04:  d3
b01_9e05:   cmp ($d4),y                 ; 5E05:  d1 d4
b01_9e07:   eor ($2a,x)                 ; 5E07:  41 2a
b01_9e09:   ldy $63                     ; 5E09:  a4 63
b01_9e0b:   .db p2_buttons                     ; 5E0B:  6f
b01_9e0c:   cmp ($a8),y                 ; 5E0C:  d1 a8
b01_9e0e:   .db $63                     ; 5E0E:  63
b01_9e0f:   .db p2_buttons                     ; 5E0F:  6f
b01_9e10:   ldy $cc89                   ; 5E10:  ac 89 cc
b01_9e13:   ldy $e315                   ; 5E13:  ac 15 e3
b01_9e16:   .db $2b                     ; 5E16:  2b
b01_9e17:   cld                         ; 5E17:  d8
b01_9e18:   dec $9e                     ; 5E18:  c6 9e
b01_9e1a:   sta $e916                   ; 5E1A:  8d 16 e9
b01_9e1d:   .db $52                     ; 5E1D:  52
b01_9e1e:   dex                         ; 5E1E:  ca
b01_9e1f:   .db vm_sp_lo                     ; 5E1F:  02
b01_9e20:   .db $8f                     ; 5E20:  8f
b01_9e21:   and $a8,x                   ; 5E21:  35 a8
b01_9e23:   .db $5b                     ; 5E23:  5b
b01_9e24:   .db p2_buttons                     ; 5E24:  6f
b01_9e25:   adc ($e9,x)                 ; 5E25:  61 e9
b01_9e27:   and $cc,x                   ; 5E27:  35 cc
b01_9e29:   .db vm_sp_lo                     ; 5E29:  02
b01_9e2a:   .db $64                     ; 5E2A:  64
b01_9e2b:   .db $62                     ; 5E2B:  62
b01_9e2c:   sbc #$6f                    ; 5E2C:  e9 6f
b01_9e2e:   .db $e7                     ; 5E2E:  e7
b01_9e2f:   .db vm_fp_lo                     ; 5E2F:  04
b01_9e30:   rts                         ; 5E30:  60
b01_9e31:   sbc #$35                    ; 5E31:  e9 35
b01_9e33:   cpy $3b02                   ; 5E33:  cc 02 3b
b01_9e36:   tax                         ; 5E36:  aa
b01_9e37:   .db $63                     ; 5E37:  63
b01_9e38:   .db p2_buttons                     ; 5E38:  6f
b01_9e39:   sbc #$72                    ; 5E39:  e9 72
b01_9e3b:   .db $d7                     ; 5E3B:  d7
record_sram_9e3c:   .db vm_sp_lo                     ; 5E3C:  02
b01_9e3d:   eor $8cb5,y                 ; 5E3D:  59 b5 8c
b01_9e40:   tay                         ; 5E40:  a8
b01_9e41:   .db $77                     ; 5E41:  77
b01_9e42:   .db $bb                     ; 5E42:  bb
b01_9e43:   .db $b3                     ; 5E43:  b3
b01_9e44:   ldy $d77e                   ; 5E44:  ac 7e d7
b01_9e47:   eor $8cb5,y                 ; 5E47:  59 b5 8c
b01_9e4a:   tay                         ; 5E4A:  a8
b01_9e4b:   .db $77                     ; 5E4B:  77
b01_9e4c:   .db $bb                     ; 5E4C:  bb
b01_9e4d:   .db $b3                     ; 5E4D:  b3
b01_9e4e:   stx $fd45                   ; 5E4E:  8e 45 fd
b01_9e51:   sbc #$34                    ; 5E51:  e9 34
b01_9e53:   cmp ($08),y                 ; 5E53:  d1 08
b01_9e55:   ldy $d3a7                   ; 5E55:  ac a7 d3
b01_9e58:   cld                         ; 5E58:  d8
b01_9e59:   ldy $9e                     ; 5E59:  a4 9e
b01_9e5b:   ldy $5f                     ; 5E5B:  a4 5f
b01_9e5d:   .db p2_buttons                     ; 5E5D:  6f
b01_9e5e:   .db $8b                     ; 5E5E:  8b
b01_9e5f:   .db $1a                     ; 5E5F:  1a
b01_9e60:   lda $8c,x                   ; 5E60:  b5 8c
b01_9e62:   ora ($70,x)                 ; 5E62:  01 70
b01_9e64:   .db $bb                     ; 5E64:  bb
b01_9e65:   and #$09                    ; 5E65:  29 09
b01_9e67:   bcs $9e1c                   ; 5E67:  b0 b3
b01_9e69:   .db $0b                     ; 5E69:  0b
b01_9e6a:   ldy $c3,x                   ; 5E6A:  b4 c3
b01_9e6c:   cld                         ; 5E6C:  d8
b01_9e6d:   .db $9e                     ; 5E6D:  9e
b01_9e6e:   .db $9e                     ; 5E6E:  9e
b01_9e6f:   ldy $da7d                   ; 5E6F:  ac 7d da
b01_9e72:   rts                         ; 5E72:  60
b01_9e73:   sbc #$8f                    ; 5E73:  e9 8f
b01_9e75:   .db $8b                     ; 5E75:  8b
b01_9e76:   .db vm_sp_lo                     ; 5E76:  02
b01_9e77:   sta $e910                   ; 5E77:  8d 10 e9
b01_9e7a:   .db $0c                     ; 5E7A:  0c
b01_9e7b:   inx                         ; 5E7B:  e8
b01_9e7c:   .db vm_sp_lo                     ; 5E7C:  02
b01_9e7d:   stx $fcc3                   ; 5E7D:  8e c3 fc
b01_9e80:   sbc #$26                    ; 5E80:  e9 26
b01_9e82:   .db $d3                     ; 5E82:  d3
b01_9e83:   .db vm_sp_lo                     ; 5E83:  02
b01_9e84:   .db $3b                     ; 5E84:  3b
b01_9e85:   ora #$b4                    ; 5E85:  09 b4
b01_9e87:   .db $b3                     ; 5E87:  b3
b01_9e88:   bcs $9e46                   ; 5E88:  b0 bc
b01_9e8a:   lda ($3b),y                 ; 5E8A:  b1 3b
b01_9e8c:   ldy $63                     ; 5E8C:  a4 63
b01_9e8e:   .db p2_buttons                     ; 5E8E:  6f
b01_9e8f:   .db $8b                     ; 5E8F:  8b
b01_9e90:   .db $1a                     ; 5E90:  1a
b01_9e91:   lda $8c,x                   ; 5E91:  b5 8c
b01_9e93:   ora ($70,x)                 ; 5E93:  01 70
b01_9e95:   .db $bb                     ; 5E95:  bb
b01_9e96:   ldy $b3,x                   ; 5E96:  b4 b3
b01_9e98:   bcs $9e55                   ; 5E98:  b0 bb
b01_9e9a:   lda ($d6),y                 ; 5E9A:  b1 d6
b01_9e9c:   .db $ab                     ; 5E9C:  ab
b01_9e9d:   .db $9e                     ; 5E9D:  9e
b01_9e9e:   stx $fdd9                   ; 5E9E:  8e d9 fd
b01_9ea1:   dec $a7,x                   ; 5EA1:  d6 a7
b01_9ea3:   .db $9e                     ; 5EA3:  9e
b01_9ea4:   stx $fce0                   ; 5EA4:  8e e0 fc
b01_9ea7:   sbc #$26                    ; 5EA7:  e9 26
b01_9ea9:   .db $d3                     ; 5EA9:  d3
b01_9eaa:   .db vm_sp_lo                     ; 5EAA:  02
b01_9eab:   ldy $d766                   ; 5EAB:  ac 66 d7
b01_9eae:   ldy $d77e                   ; 5EAE:  ac 7e d7
b01_9eb1:   tay                         ; 5EB1:  a8
b01_9eb2:   .db $5b                     ; 5EB2:  5b
b01_9eb3:   .db p2_buttons                     ; 5EB3:  6f
b01_9eb4:   adc ($e9,x)                 ; 5EB4:  61 e9
b01_9eb6:   and $cc,x                   ; 5EB6:  35 cc
b01_9eb8:   .db vm_sp_lo                     ; 5EB8:  02
b01_9eb9:   .db $64                     ; 5EB9:  64
b01_9eba:   .db $62                     ; 5EBA:  62
b01_9ebb:   sbc #$6f                    ; 5EBB:  e9 6f
b01_9ebd:   .db $e7                     ; 5EBD:  e7
b01_9ebe:   .db vm_fp_lo                     ; 5EBE:  04
b01_9ebf:   rts                         ; 5EBF:  60
b01_9ec0:   sbc #$35                    ; 5EC0:  e9 35
b01_9ec2:   cpy $0a02                   ; 5EC2:  cc 02 0a
b01_9ec5:   .db $cf                     ; 5EC5:  cf
b01_9ec6:   adc ($e9,x)                 ; 5EC6:  61 e9
b01_9ec8:   .db $8f                     ; 5EC8:  8f
b01_9ec9:   .db $8b                     ; 5EC9:  8b
b01_9eca:   .db vm_sp_lo                     ; 5ECA:  02
b01_9ecb:   stx $bc05                   ; 5ECB:  8e 05 bc
b01_9ece:   sbc #$26                    ; 5ECE:  e9 26
b01_9ed0:   .db $d3                     ; 5ED0:  d3
b01_9ed1:   .db vm_sp_lo                     ; 5ED1:  02
b01_9ed2:   ldy $d77e                   ; 5ED2:  ac 7e d7
b01_9ed5:   eor $8cb5,y                 ; 5ED5:  59 b5 8c
b01_9ed8:   tay                         ; 5ED8:  a8
b01_9ed9:   .db $77                     ; 5ED9:  77
b01_9eda:   .db $bb                     ; 5EDA:  bb
b01_9edb:   .db $b3                     ; 5EDB:  b3
b01_9edc:   stx $fcaa                   ; 5EDC:  8e aa fc
b01_9edf:   sbc #$34                    ; 5EDF:  e9 34
b01_9ee1:   cmp (vm_fp_lo),y                 ; 5EE1:  d1 04
b01_9ee3:   php                         ; 5EE3:  08
b01_9ee4:   .db ppumask_shadow                     ; 5EE4:  72
b01_9ee5:   .db $b3                     ; 5EE5:  b3
b01_9ee6:   .db $d3                     ; 5EE6:  d3
b01_9ee7:   cmp ($d4),y                 ; 5EE7:  d1 d4
b01_9ee9:   php                         ; 5EE9:  08
b01_9eea:   .db palette_dirty                     ; 5EEA:  74
b01_9eeb:   .db $b3                     ; 5EEB:  b3
b01_9eec:   .db $d3                     ; 5EEC:  d3
b01_9eed:   cmp ($d4),y                 ; 5EED:  d1 d4
b01_9eef:   php                         ; 5EEF:  08
b01_9ef0:   .db prg_bank_shadow                     ; 5EF0:  73
b01_9ef1:   .db $b3                     ; 5EF1:  b3
b01_9ef2:   .db $d3                     ; 5EF2:  d3
b01_9ef3:   cmp ($d4),y                 ; 5EF3:  d1 d4
b01_9ef5:   dec $ff,x                   ; 5EF5:  d6 ff
b01_9ef7:   .db $9e                     ; 5EF7:  9e
b01_9ef8:   asl a                       ; 5EF8:  0a
b01_9ef9:   .db $cf                     ; 5EF9:  cf
b01_9efa:   asl a                       ; 5EFA:  0a
b01_9efb:   .db $cf                     ; 5EFB:  cf
b01_9efc:   ldy $87cb                   ; 5EFC:  ac cb 87
b01_9eff:   ldy $d766                   ; 5EFF:  ac 66 d7
b01_9f02:   asl a                       ; 5F02:  0a
b01_9f03:   .db $cf                     ; 5F03:  cf
effect_loan:   jsr $e823                   ; 5F04:  20 23 e8
b01_9f07:   .db $fc                     ; 5F07:  fc
b01_9f08:   .db $ff                     ; 5F08:  ff
b01_9f09:   stx $bc06                   ; 5F09:  8e 06 bc
b01_9f0c:   sbc #$26                    ; 5F0C:  e9 26
b01_9f0e:   .db $d3                     ; 5F0E:  d3
b01_9f0f:   .db vm_sp_lo                     ; 5F0F:  02
b01_9f10:   .db $0c                     ; 5F10:  0c
b01_9f11:   .db $8f                     ; 5F11:  8f
b01_9f12:   clc                         ; 5F12:  18
b01_9f13:   bcs $9ec8                   ; 5F13:  b0 b3
b01_9f15:   .db $0c                     ; 5F15:  0c
b01_9f16:   bcs $9ecc                   ; 5F16:  b0 b4
b01_9f18:   cmp $d8                     ; 5F18:  c5 d8
b01_9f1a:   .db $2f                     ; 5F1A:  2f
b01_9f1b:   .db $9f                     ; 5F1B:  9f
b01_9f1c:   tax                         ; 5F1C:  aa
b01_9f1d:   .db $5f                     ; 5F1D:  5f
b01_9f1e:   .db p2_buttons                     ; 5F1E:  6f
b01_9f1f:   sbc #$8b                    ; 5F1F:  e9 8b
b01_9f21:   .db $d7                     ; 5F21:  d7
b01_9f22:   .db vm_sp_lo                     ; 5F22:  02
b01_9f23:   stx $bc07                   ; 5F23:  8e 07 bc
b01_9f26:   sbc #$c4                    ; 5F26:  e9 c4
b01_9f28:   dec $ac02                   ; 5F28:  ce 02 ac
b01_9f2b:   ror $d7                     ; 5F2B:  66 d7
b01_9f2d:   rti                         ; 5F2D:  40
b01_9f2e:   .db $cf                     ; 5F2E:  cf
b01_9f2f:   .db $0c                     ; 5F2F:  0c
b01_9f30:   .db ppumask_shadow                     ; 5F30:  72
b01_9f31:   bcs $9ee6                   ; 5F31:  b0 b3
b01_9f33:   .db $0c                     ; 5F33:  0c
b01_9f34:   .db palette_dirty                     ; 5F34:  74
b01_9f35:   bcs $9eeb                   ; 5F35:  b0 b4
b01_9f37:   cpy $d8                     ; 5F37:  c4 d8
b01_9f39:   .db $a3                     ; 5F39:  a3
b01_9f3a:   .db $9f                     ; 5F3A:  9f
b01_9f3b:   .db $0c                     ; 5F3B:  0c
b01_9f3c:   bcs $9ef1                   ; 5F3C:  b0 b3
b01_9f3e:   .db $0c                     ; 5F3E:  0c
b01_9f3f:   .db $8f                     ; 5F3F:  8f
b01_9f40:   clc                         ; 5F40:  18
b01_9f41:   bcs $9ef7                   ; 5F41:  b0 b4
b01_9f43:   ldy $a4b3,x                 ; 5F43:  bc b3 a4
b01_9f46:   .db $0b                     ; 5F46:  0b
b01_9f47:   ror $b37a                   ; 5F47:  6e 7a b3
b01_9f4a:   .db $0c                     ; 5F4A:  0c
b01_9f4b:   .db ppumask_shadow                     ; 5F4B:  72
b01_9f4c:   bcs $9f01                   ; 5F4C:  b0 b3
b01_9f4e:   .db $0c                     ; 5F4E:  0c
b01_9f4f:   .db palette_dirty                     ; 5F4F:  74
b01_9f50:   bcs $9f06                   ; 5F50:  b0 b4
b01_9f52:   ldy $e9b3,x                 ; 5F52:  bc b3 e9
b01_9f55:   .db $57                     ; 5F55:  57
b01_9f56:   .db clock_a_hi                     ; 5F56:  83
b01_9f57:   asl $2a                     ; 5F57:  06 2a
b01_9f59:   cld                         ; 5F59:  d8
b01_9f5a:   .db $a3                     ; 5F5A:  a3
b01_9f5b:   .db $9f                     ; 5F5B:  9f
b01_9f5c:   stx $f99d                   ; 5F5C:  8e 9d f9
b01_9f5f:   stx $bc2b                   ; 5F5F:  8e 2b bc
b01_9f62:   sbc #$34                    ; 5F62:  e9 34
b01_9f64:   cmp (vm_fp_lo),y                 ; 5F64:  d1 04
b01_9f66:   .db $3a                     ; 5F66:  3a
b01_9f67:   adc ($e9,x)                 ; 5F67:  61 e9
b01_9f69:   sbc #$d5                    ; 5F69:  e9 d5
b01_9f6b:   .db vm_fp_lo                     ; 5F6B:  04
b01_9f6c:   .db $2b                     ; 5F6C:  2b
b01_9f6d:   cld                         ; 5F6D:  d8
b01_9f6e:   .db $9e                     ; 5F6E:  9e
b01_9f6f:   .db $9f                     ; 5F6F:  9f
b01_9f70:   .db $3b                     ; 5F70:  3b
b01_9f71:   sbc #$40                    ; 5F71:  e9 40
b01_9f73:   .db $8b                     ; 5F73:  8b
b01_9f74:   .db vm_sp_lo                     ; 5F74:  02
b01_9f75:   .db $3c                     ; 5F75:  3c
b01_9f76:   sbc #$ac                    ; 5F76:  e9 ac
b01_9f78:   .db $82                     ; 5F78:  82
b01_9f79:   .db vm_sp_lo                     ; 5F79:  02
b01_9f7a:   rts                         ; 5F7A:  60
b01_9f7b:   sbc #$4e                    ; 5F7B:  e9 4e
b01_9f7d:   txa                         ; 5F7D:  8a
b01_9f7e:   .db vm_sp_lo                     ; 5F7E:  02
b01_9f7f:   .db brk_scratch_hi                     ; 5F7F:  67
b01_9f80:   sta $e910                   ; 5F80:  8d 10 e9
b01_9f83:   .db music_ptr_hi                     ; 5F83:  7b
b01_9f84:   cpy $0c04                   ; 5F84:  cc 04 0c
b01_9f87:   bcs $9f3c                   ; 5F87:  b0 b3
b01_9f89:   sbc #$c7                    ; 5F89:  e9 c7
b01_9f8b:   .db clock_a_hi                     ; 5F8B:  83
b01_9f8c:   .db vm_sp_lo                     ; 5F8C:  02
b01_9f8d:   pla                         ; 5F8D:  68
b01_9f8e:   sta $e910                   ; 5F8E:  8d 10 e9
b01_9f91:   .db music_ptr_hi                     ; 5F91:  7b
b01_9f92:   cpy $0c04                   ; 5F92:  cc 04 0c
b01_9f95:   .db ppumask_shadow                     ; 5F95:  72
b01_9f96:   bcs $9f4b                   ; 5F96:  b0 b3
b01_9f98:   sbc #$c7                    ; 5F98:  e9 c7
b01_9f9a:   .db clock_a_hi                     ; 5F9A:  83
b01_9f9b:   .db vm_sp_lo                     ; 5F9B:  02
b01_9f9c:   eor ($cf,x)                 ; 5F9C:  41 cf
b01_9f9e:   ldy $cc89                   ; 5F9E:  ac 89 cc
b01_9fa1:   rti                         ; 5FA1:  40
b01_9fa2:   .db $cf                     ; 5FA2:  cf
b01_9fa3:   stx $bc47                   ; 5FA3:  8e 47 bc
b01_9fa6:   sbc #$c4                    ; 5FA6:  e9 c4
b01_9fa8:   dec $ac02                   ; 5FA8:  ce 02 ac
b01_9fab:   ror $d7                     ; 5FAB:  66 d7
b01_9fad:   rti                         ; 5FAD:  40
b01_9fae:   .db $cf                     ; 5FAE:  cf
prompt_repay_debt:   jsr $e823                   ; 5FAF:  20 23 e8
b01_9fb2:   inc $8eff,x                 ; 5FB2:  fe ff 8e
b01_9fb5:   eor $e9bc,y                 ; 5FB5:  59 bc e9
b01_9fb8:   rol $d3                     ; 5FB8:  26 d3
b01_9fba:   .db vm_sp_lo                     ; 5FBA:  02
b01_9fbb:   .db $0c                     ; 5FBB:  0c
b01_9fbc:   .db ppumask_shadow                     ; 5FBC:  72
b01_9fbd:   bcs $9f97                   ; 5FBD:  b0 d8
b01_9fbf:   .db $f7                     ; 5FBF:  f7
b01_9fc0:   .db $9f                     ; 5FC0:  9f
b01_9fc1:   .db $0c                     ; 5FC1:  0c
b01_9fc2:   bcs $9f9c                   ; 5FC2:  b0 d8
b01_9fc4:   sbc ($9f),y                 ; 5FC4:  f1 9f
b01_9fc6:   .db $0c                     ; 5FC6:  0c
b01_9fc7:   bcs $9f7c                   ; 5FC7:  b0 b3
b01_9fc9:   .db $0c                     ; 5FC9:  0c
b01_9fca:   .db ppumask_shadow                     ; 5FCA:  72
b01_9fcb:   bcs $9f80                   ; 5FCB:  b0 b3
b01_9fcd:   sbc #$5e                    ; 5FCD:  e9 5e
b01_9fcf:   .db $cb                     ; 5FCF:  cb
b01_9fd0:   .db vm_fp_lo                     ; 5FD0:  04
b01_9fd1:   .db $b3                     ; 5FD1:  b3
b01_9fd2:   adc ($e9,x)                 ; 5FD2:  61 e9
b01_9fd4:   sbc #$d5                    ; 5FD4:  e9 d5
b01_9fd6:   .db vm_fp_lo                     ; 5FD6:  04
b01_9fd7:   .db $2b                     ; 5FD7:  2b
b01_9fd8:   cld                         ; 5FD8:  d8
b01_9fd9:   cpx $3b9f                   ; 5FD9:  ec 9f 3b
b01_9fdc:   .db $0c                     ; 5FDC:  0c
b01_9fdd:   ldy $b3,x                   ; 5FDD:  b4 b3
b01_9fdf:   bcs $9f9d                   ; 5FDF:  b0 bc
b01_9fe1:   lda ($3b),y                 ; 5FE1:  b1 3b
b01_9fe3:   .db $0c                     ; 5FE3:  0c
b01_9fe4:   .db ppumask_shadow                     ; 5FE4:  72
b01_9fe5:   ldy $b3,x                   ; 5FE5:  b4 b3
b01_9fe7:   bcs $9fa5                   ; 5FE7:  b0 bc
b01_9fe9:   lda ($41),y                 ; 5FE9:  b1 41
b01_9feb:   .db $cf                     ; 5FEB:  cf
b01_9fec:   ldy $cc89                   ; 5FEC:  ac 89 cc
b01_9fef:   rti                         ; 5FEF:  40
b01_9ff0:   .db $cf                     ; 5FF0:  cf
b01_9ff1:   stx $bc5a                   ; 5FF1:  8e 5a bc
b01_9ff4:   dec $fa,x                   ; 5FF4:  d6 fa
b01_9ff6:   .db $9f                     ; 5FF6:  9f
b01_9ff7:   stx $bc63                   ; 5FF7:  8e 63 bc
b01_9ffa:   sbc #$c4                    ; 5FFA:  e9 c4
b01_9ffc:   dec $ac02                   ; 5FFC:  ce 02 ac
b01_9fff:   ror $d7                     ; 5FFF:  66 d7
b01_a001:   rti                         ; 6001:  40
b01_a002:   .db $cf                     ; 6002:  cf
effect_sell_rice:   jsr $e823                   ; 6003:  20 23 e8
b01_a006:   .db $fc                     ; 6006:  fc
b01_a007:   .db $ff                     ; 6007:  ff
b01_a008:   stx $bc75                   ; 6008:  8e 75 bc
b01_a00b:   sbc #$26                    ; 600B:  e9 26
b01_a00d:   .db $d3                     ; 600D:  d3
b01_a00e:   .db vm_sp_lo                     ; 600E:  02
b01_a00f:   .db $0c                     ; 600F:  0c
b01_a010:   ror nmi_skip_all,x                   ; 6010:  76 b0
b01_a012:   cld                         ; 6012:  d8
b01_a013:   eor $0ca0,y                 ; 6013:  59 a0 0c
b01_a016:   ror nmi_skip_all,x                   ; 6016:  76 b0
b01_a018:   .db $b3                     ; 6018:  b3
b01_a019:   tax                         ; 6019:  aa
b01_a01a:   ora $0c6e                   ; 601A:  0d 6e 0c
b01_a01d:   bcs $9fd2                   ; 601D:  b0 b3
b01_a01f:   .db $0c                     ; 601F:  0c
b01_a020:   .db $8f                     ; 6020:  8f
b01_a021:   clc                         ; 6021:  18
b01_a022:   bcs $9fd8                   ; 6022:  b0 b4
b01_a024:   ldy $e9b3,x                 ; 6024:  bc b3 e9
b01_a027:   .db $57                     ; 6027:  57
b01_a028:   .db clock_a_hi                     ; 6028:  83
b01_a029:   asl $2a                     ; 6029:  06 2a
b01_a02b:   cld                         ; 602B:  d8
b01_a02c:   .db $53                     ; 602C:  53
b01_a02d:   ldy #$8e                    ; 602D:  a0 8e
b01_a02f:   sta $8ef9,x                 ; 602F:  9d f9 8e
b01_a032:   ror $bc,x                   ; 6032:  76 bc
b01_a034:   sbc #$34                    ; 6034:  e9 34
b01_a036:   cmp (vm_fp_lo),y                 ; 6036:  d1 04
b01_a038:   .db $3a                     ; 6038:  3a
b01_a039:   adc ($e9,x)                 ; 6039:  61 e9
b01_a03b:   sbc #$d5                    ; 603B:  e9 d5
b01_a03d:   .db vm_fp_lo                     ; 603D:  04
b01_a03e:   .db $2b                     ; 603E:  2b
b01_a03f:   cld                         ; 603F:  d8
b01_a040:   .db $63                     ; 6040:  63
b01_a041:   ldy #$3b                    ; 6041:  a0 3b
b01_a043:   sbc #$0a                    ; 6043:  e9 0a
b01_a045:   .db $8b                     ; 6045:  8b
b01_a046:   .db vm_sp_lo                     ; 6046:  02
b01_a047:   .db $3c                     ; 6047:  3c
b01_a048:   sbc #$ac                    ; 6048:  e9 ac
b01_a04a:   .db $82                     ; 604A:  82
b01_a04b:   .db vm_sp_lo                     ; 604B:  02
b01_a04c:   adc ($e9,x)                 ; 604C:  61 e9
b01_a04e:   lsr $028a                   ; 604E:  4e 8a 02
b01_a051:   eor ($cf,x)                 ; 6051:  41 cf
b01_a053:   stx $bc8c                   ; 6053:  8e 8c bc
b01_a056:   dec $5c,x                   ; 6056:  d6 5c
b01_a058:   ldy #$8e                    ; 6058:  a0 8e
b01_a05a:   txs                         ; 605A:  9a
b01_a05b:   ldy $c4e9,x                 ; 605B:  bc e9 c4
b01_a05e:   dec $ac02                   ; 605E:  ce 02 ac
b01_a061:   eor $acd7,y                 ; 6061:  59 d7 ac
b01_a064:   .db skip_wallclock                     ; 6064:  89
b01_a065:   cpy $cf40                   ; 6065:  cc 40 cf
effect_buy_rice:   jsr $e823                   ; 6068:  20 23 e8
b01_a06b:   .db $fc                     ; 606B:  fc
b01_a06c:   .db $ff                     ; 606C:  ff
b01_a06d:   stx $bca2                   ; 606D:  8e a2 bc
b01_a070:   sbc #$26                    ; 6070:  e9 26
b01_a072:   .db $d3                     ; 6072:  d3
b01_a073:   .db vm_sp_lo                     ; 6073:  02
b01_a074:   ldy $5f                     ; 6074:  a4 5f
b01_a076:   .db p2_buttons                     ; 6076:  6f
b01_a077:   .db $8b                     ; 6077:  8b
b01_a078:   .db $1a                     ; 6078:  1a
b01_a079:   lda $8c,x                   ; 6079:  b5 8c
b01_a07b:   ora ($70,x)                 ; 607B:  01 70
b01_a07d:   .db $bb                     ; 607D:  bb
b01_a07e:   bcs $a058                   ; 607E:  b0 d8
b01_a080:   dec $0ca0,x                 ; 6080:  de a0 0c
b01_a083:   ror nmi_skip_all,x                   ; 6083:  76 b0
b01_a085:   .db $b3                     ; 6085:  b3
b01_a086:   .db $0c                     ; 6086:  0c
b01_a087:   .db $8f                     ; 6087:  8f
b01_a088:   clc                         ; 6088:  18
b01_a089:   bcs $a03f                   ; 6089:  b0 b4
b01_a08b:   ldy $aab3,x                 ; 608B:  bc b3 aa
b01_a08e:   ora $0c6e                   ; 608E:  0d 6e 0c
b01_a091:   bcs $a046                   ; 6091:  b0 b3
b01_a093:   sbc #$57                    ; 6093:  e9 57
b01_a095:   .db clock_a_hi                     ; 6095:  83
b01_a096:   asl $2b                     ; 6096:  06 2b
b01_a098:   cld                         ; 6098:  d8
b01_a099:   cld                         ; 6099:  d8
b01_a09a:   ldy #$8e                    ; 609A:  a0 8e
b01_a09c:   sta $e9f9,x                 ; 609C:  9d f9 e9
b01_a09f:   cpy $ce                     ; 609F:  c4 ce
b01_a0a1:   .db vm_sp_lo                     ; 60A1:  02
b01_a0a2:   stx $bca3                   ; 60A2:  8e a3 bc
b01_a0a5:   sbc #$c4                    ; 60A5:  e9 c4
b01_a0a7:   dec $3b02                   ; 60A7:  ce 02 3b
b01_a0aa:   adc ($e9,x)                 ; 60AA:  61 e9
b01_a0ac:   sbc #$d5                    ; 60AC:  e9 d5
b01_a0ae:   .db vm_fp_lo                     ; 60AE:  04
b01_a0af:   rol a                       ; 60AF:  2a
b01_a0b0:   cld                         ; 60B0:  d8
b01_a0b1:   inx                         ; 60B1:  e8
b01_a0b2:   ldy #$3a                    ; 60B2:  a0 3a
b01_a0b4:   tax                         ; 60B4:  aa
b01_a0b5:   ora $e96e                   ; 60B5:  0d 6e e9
b01_a0b8:   .db vm_sp_hi                     ; 60B8:  03
b01_a0b9:   .db clock_a_hi                     ; 60B9:  83
b01_a0ba:   .db vm_fp_lo                     ; 60BA:  04
b01_a0bb:   .db $b3                     ; 60BB:  b3
b01_a0bc:   .db $0c                     ; 60BC:  0c
b01_a0bd:   ldy $b3,x                   ; 60BD:  b4 b3
b01_a0bf:   bcs $a07d                   ; 60BF:  b0 bc
b01_a0c1:   lda ($3a),y                 ; 60C1:  b1 3a
b01_a0c3:   .db $0c                     ; 60C3:  0c
b01_a0c4:   ror $b4,x                   ; 60C4:  76 b4
b01_a0c6:   .db $b3                     ; 60C6:  b3
b01_a0c7:   bcs $a084                   ; 60C7:  b0 bb
b01_a0c9:   lda ($0c),y                 ; 60C9:  b1 0c
b01_a0cb:   ror $b3,x                   ; 60CB:  76 b3
b01_a0cd:   sbc #$ac                    ; 60CD:  e9 ac
b01_a0cf:   .db $82                     ; 60CF:  82
b01_a0d0:   .db vm_sp_lo                     ; 60D0:  02
b01_a0d1:   .db $62                     ; 60D1:  62
b01_a0d2:   sbc #$4e                    ; 60D2:  e9 4e
b01_a0d4:   txa                         ; 60D4:  8a
b01_a0d5:   .db vm_sp_lo                     ; 60D5:  02
b01_a0d6:   eor ($cf,x)                 ; 60D6:  41 cf
b01_a0d8:   stx $bcb6                   ; 60D8:  8e b6 bc
b01_a0db:   dec $e1,x                   ; 60DB:  d6 e1
b01_a0dd:   ldy #$8e                    ; 60DD:  a0 8e
b01_a0df:   dec $bc                     ; 60DF:  c6 bc
b01_a0e1:   sbc #$c4                    ; 60E1:  e9 c4
b01_a0e3:   dec $ac02                   ; 60E3:  ce 02 ac
b01_a0e6:   eor $acd7,y                 ; 60E6:  59 d7 ac
b01_a0e9:   .db skip_wallclock                     ; 60E9:  89
b01_a0ea:   cpy $cf40                   ; 60EA:  cc 40 cf
amount_div_force_factor:   jsr $e823                   ; 60ED:  20 23 e8
b01_a0f0:   inc $0cff,x                 ; 60F0:  fe ff 0c
b01_a0f3:   .db $8f                     ; 60F3:  8f
b01_a0f4:   clc                         ; 60F4:  18
b01_a0f5:   bcs $a0aa                   ; 60F5:  b0 b3
b01_a0f7:   adc $0c                     ; 60F7:  65 0c
b01_a0f9:   .db $8f                     ; 60F9:  8f
b01_a0fa:   bpl $a0ac                   ; 60FA:  10 b0
b01_a0fc:   .db $b3                     ; 60FC:  b3
b01_a0fd:   .db $0c                     ; 60FD:  0c
b01_a0fe:   .db $8f                     ; 60FE:  8f
b01_a0ff:   asl nmi_skip_all,x                   ; 60FF:  16 b0
b01_a101:   ldy $bb,x                   ; 6101:  b4 bb
b01_a103:   .db $b3                     ; 6103:  b3
b01_a104:   sbc #$b8                    ; 6104:  e9 b8
b01_a106:   dec vm_ip_lo,x                   ; 6106:  d6 06
b01_a108:   .db $2b                     ; 6108:  2b
b01_a109:   .db $0b                     ; 6109:  0b
b01_a10a:   .db $d7                     ; 610A:  d7
b01_a10b:   .db $0f                     ; 610B:  0f
b01_a10c:   lda ($41,x)                 ; 610C:  a1 41
b01_a10e:   .db $2b                     ; 610E:  2b
b01_a10f:   ora $b61b                   ; 610F:  0d 1b b6
b01_a112:   .db $cf                     ; 6112:  cf
effect_buy_arms:   jsr $e823                   ; 6113:  20 23 e8
b01_a116:   .db $fc                     ; 6116:  fc
b01_a117:   .db $ff                     ; 6117:  ff
b01_a118:   .db $0c                     ; 6118:  0c
b01_a119:   .db $8f                     ; 6119:  8f
b01_a11a:   bpl $a0cc                   ; 611A:  10 b0
b01_a11c:   bvc $a0e1                   ; 611C:  50 c3
b01_a11e:   cld                         ; 611E:  d8
b01_a11f:   and $8ea1                   ; 611F:  2d a1 8e
b01_a122:   .db $d7                     ; 6122:  d7
b01_a123:   ldy $26e9,x                 ; 6123:  bc e9 26
b01_a126:   .db $d3                     ; 6126:  d3
b01_a127:   .db vm_sp_lo                     ; 6127:  02
b01_a128:   ldy $d766                   ; 6128:  ac 66 d7
b01_a12b:   rti                         ; 612B:  40
b01_a12c:   .db $cf                     ; 612C:  cf
b01_a12d:   stx $bce9                   ; 612D:  8e e9 bc
b01_a130:   sbc #$26                    ; 6130:  e9 26
b01_a132:   .db $d3                     ; 6132:  d3
b01_a133:   .db vm_sp_lo                     ; 6133:  02
b01_a134:   ldy $0f                     ; 6134:  a4 0f
b01_a136:   ror $5a79                   ; 6136:  6e 79 5a
b01_a139:   ldx $2b,y                   ; 6139:  b6 2b
b01_a13b:   .db $0c                     ; 613B:  0c
b01_a13c:   bcs $a159                   ; 613C:  b0 1b
b01_a13e:   cmp $d8                     ; 613E:  c5 d8
b01_a140:   ldy #$a1                    ; 6140:  a0 a1
b01_a142:   .db $0c                     ; 6142:  0c
b01_a143:   .db $8f                     ; 6143:  8f
b01_a144:   asl nmi_skip_all,x                   ; 6144:  16 b0
b01_a146:   .db $b3                     ; 6146:  b3
b01_a147:   .db $0c                     ; 6147:  0c
b01_a148:   .db $8f                     ; 6148:  8f
b01_a149:   clc                         ; 6149:  18
b01_a14a:   bcs $a100                   ; 614A:  b0 b4
b01_a14c:   ldy $aab3,x                 ; 614C:  bc b3 aa
b01_a14f:   .db $0f                     ; 614F:  0f
b01_a150:   ror $b00c                   ; 6150:  6e 0c b0
b01_a153:   .db $b3                     ; 6153:  b3
b01_a154:   sbc #$57                    ; 6154:  e9 57
b01_a156:   .db clock_a_hi                     ; 6156:  83
b01_a157:   asl $2b                     ; 6157:  06 2b
b01_a159:   cld                         ; 6159:  d8
b01_a15a:   txs                         ; 615A:  9a
b01_a15b:   lda ($8e,x)                 ; 615B:  a1 8e
b01_a15d:   ldx $f9                     ; 615D:  a6 f9
b01_a15f:   sbc #$c4                    ; 615F:  e9 c4
b01_a161:   dec $3b02                   ; 6161:  ce 02 3b
b01_a164:   adc ($e9,x)                 ; 6164:  61 e9
b01_a166:   sbc #$d5                    ; 6166:  e9 d5
b01_a168:   .db vm_fp_lo                     ; 6168:  04
b01_a169:   rol a                       ; 6169:  2a
b01_a16a:   cld                         ; 616A:  d8
b01_a16b:   tax                         ; 616B:  aa
b01_a16c:   lda ($3a,x)                 ; 616C:  a1 3a
b01_a16e:   tax                         ; 616E:  aa
b01_a16f:   .db $0f                     ; 616F:  0f
b01_a170:   ror $03e9                   ; 6170:  6e e9 03
b01_a173:   .db clock_a_hi                     ; 6173:  83
b01_a174:   .db vm_fp_lo                     ; 6174:  04
b01_a175:   .db $b3                     ; 6175:  b3
b01_a176:   .db $0c                     ; 6176:  0c
b01_a177:   ldy $b3,x                   ; 6177:  b4 b3
b01_a179:   bcs $a137                   ; 6179:  b0 bc
b01_a17b:   lda ($3a),y                 ; 617B:  b1 3a
b01_a17d:   .db $3c                     ; 617D:  3c
b01_a17e:   sbc #$ed                    ; 617E:  e9 ed
b01_a180:   ldy #$04                    ; 6180:  a0 04
b01_a182:   .db $b3                     ; 6182:  b3
b01_a183:   .db $0c                     ; 6183:  0c
b01_a184:   .db $8f                     ; 6184:  8f
b01_a185:   asl $b4,x                   ; 6185:  16 b4
b01_a187:   .db $b3                     ; 6187:  b3
b01_a188:   bcs $a145                   ; 6188:  b0 bb
b01_a18a:   lda ($0c),y                 ; 618A:  b1 0c
b01_a18c:   .db $8f                     ; 618C:  8f
b01_a18d:   asl $b3,x                   ; 618D:  16 b3
b01_a18f:   sbc #$ac                    ; 618F:  e9 ac
b01_a191:   .db $82                     ; 6191:  82
b01_a192:   .db vm_sp_lo                     ; 6192:  02
b01_a193:   .db $63                     ; 6193:  63
b01_a194:   sbc #$4e                    ; 6194:  e9 4e
b01_a196:   txa                         ; 6196:  8a
b01_a197:   .db vm_sp_lo                     ; 6197:  02
b01_a198:   eor ($cf,x)                 ; 6198:  41 cf
b01_a19a:   stx $bcea                   ; 619A:  8e ea bc
b01_a19d:   dec $a3,x                   ; 619D:  d6 a3
b01_a19f:   lda ($8e,x)                 ; 619F:  a1 8e
b01_a1a1:   inc $bc,x                   ; 61A1:  f6 bc
b01_a1a3:   sbc #$c4                    ; 61A3:  e9 c4
b01_a1a5:   dec $ac02                   ; 61A5:  ce 02 ac
b01_a1a8:   eor $acd7,y                 ; 61A8:  59 d7 ac
b01_a1ab:   .db skip_wallclock                     ; 61AB:  89
b01_a1ac:   cpy $cf40                   ; 61AC:  cc 40 cf
noop_command_handler:   jsr $e823                   ; 61AF:  20 23 e8
b01_a1b2:   brk                         ; 61B2:  00
b01_a1b3:   brk                         ; 61B3:  00
b01_a1b4:   rti                         ; 61B4:  40
b01_a1b5:   .db $cf                     ; 61B5:  cf
driver_trade:   jsr $e823                   ; 61B6:  20 23 e8
b01_a1b9:   .db $fc                     ; 61B9:  fc
b01_a1ba:   .db $ff                     ; 61BA:  ff
b01_a1bb:   ldy $8a15                   ; 61BB:  ac 15 8a
b01_a1be:   cld                         ; 61BE:  d8
b01_a1bf:   eor #$a2                    ; 61BF:  49 a2
b01_a1c1:   ldy $cc69                   ; 61C1:  ac 69 cc
b01_a1c4:   rti                         ; 61C4:  40
b01_a1c5:   dec $e9,x                   ; 61C5:  d6 e9
b01_a1c7:   lda ($0b,x)                 ; 61C7:  a1 0b
b01_a1c9:   .db $77                     ; 61C9:  77
b01_a1ca:   .db $b3                     ; 61CA:  b3
b01_a1cb:   sta $e916                   ; 61CB:  8d 16 e9
b01_a1ce:   .db music_ptr_hi                     ; 61CE:  7b
b01_a1cf:   cpy $0b04                   ; 61CF:  cc 04 0b
b01_a1d2:   bne $a187                   ; 61D2:  d0 b3
b01_a1d4:   stx $bd15                   ; 61D4:  8e 15 bd
b01_a1d7:   sbc #$34                    ; 61D7:  e9 34
b01_a1d9:   cmp (vm_fp_lo),y                 ; 61D9:  d1 04
b01_a1db:   .db $0b                     ; 61DB:  0b
b01_a1dc:   .db $d2                     ; 61DC:  d2
b01_a1dd:   sty $ff4f                   ; 61DD:  8c 4f ff
b01_a1e0:   .db $bb                     ; 61E0:  bb
b01_a1e1:   bcs $a196                   ; 61E1:  b0 b3
b01_a1e3:   sbc #$c4                    ; 61E3:  e9 c4
b01_a1e5:   dec $0b02                   ; 61E5:  ce 02 0b
b01_a1e8:   bne $a215                   ; 61E8:  d0 2b
b01_a1ea:   .db $0b                     ; 61EA:  0b
b01_a1eb:   lsr $c2,x                   ; 61EB:  56 c2
b01_a1ed:   .db $d7                     ; 61ED:  d7
b01_a1ee:   iny                         ; 61EE:  c8
b01_a1ef:   lda ($8e,x)                 ; 61EF:  a1 8e
b01_a1f1:   ora $e9bd,y                 ; 61F1:  19 bd e9
b01_a1f4:   rol $d3                     ; 61F4:  26 d3
b01_a1f6:   .db vm_sp_lo                     ; 61F6:  02
b01_a1f7:   ror $e9                     ; 61F7:  66 e9
b01_a1f9:   ldx $b1                     ; 61F9:  a6 b1
b01_a1fb:   .db vm_sp_lo                     ; 61FB:  02
b01_a1fc:   .db $2b                     ; 61FC:  2b
b01_a1fd:   .db $d2                     ; 61FD:  d2
b01_a1fe:   sty $b9dc                   ; 61FE:  8c dc b9
b01_a201:   .db $bb                     ; 6201:  bb
b01_a202:   bcs $a22e                   ; 6202:  b0 2a
b01_a204:   ldy $5f                     ; 6204:  a4 5f
b01_a206:   .db p2_buttons                     ; 6206:  6f
b01_a207:   .db $8b                     ; 6207:  8b
b01_a208:   .db $1a                     ; 6208:  1a
b01_a209:   lda $8c,x                   ; 6209:  b5 8c
b01_a20b:   ora ($70,x)                 ; 620B:  01 70
b01_a20d:   .db $bb                     ; 620D:  bb
b01_a20e:   .db $b3                     ; 620E:  b3
b01_a20f:   asl a                       ; 620F:  0a
b01_a210:   nop                         ; 6210:  ea
b01_a211:   .db vm_sp_lo                     ; 6211:  02
b01_a212:   cld                         ; 6212:  d8
b01_a213:   and ($a2),y                 ; 6213:  31 a2
b01_a215:   rts                         ; 6215:  60
b01_a216:   sbc #$0c                    ; 6216:  e9 0c
b01_a218:   inx                         ; 6218:  e8
b01_a219:   .db vm_sp_lo                     ; 6219:  02
b01_a21a:   stx $bd33                   ; 621A:  8e 33 bd
b01_a21d:   sbc #$26                    ; 621D:  e9 26
b01_a21f:   .db $d3                     ; 621F:  d3
b01_a220:   .db vm_sp_lo                     ; 6220:  02
b01_a221:   ldy $d766                   ; 6221:  ac 66 d7
b01_a224:   .db $0b                     ; 6224:  0b
b01_a225:   .db $d7                     ; 6225:  d7
b01_a226:   .db $2f                     ; 6226:  2f
b01_a227:   ldx #$60                    ; 6227:  a2 60
b01_a229:   sbc #$1e                    ; 6229:  e9 1e
b01_a22b:   .db $87                     ; 622B:  87
b01_a22c:   .db vm_sp_lo                     ; 622C:  02
b01_a22d:   rti                         ; 622D:  40
b01_a22e:   .db $cf                     ; 622E:  cf
b01_a22f:   eor ($cf,x)                 ; 622F:  41 cf
b01_a231:   .db $0b                     ; 6231:  0b
b01_a232:   eor $c0,x                   ; 6232:  55 c0
b01_a234:   cld                         ; 6234:  d8
b01_a235:   beq $a1d8                   ; 6235:  f0 a1
b01_a237:   stx $bd4b                   ; 6237:  8e 4b bd
b01_a23a:   sbc #$26                    ; 623A:  e9 26
b01_a23c:   .db $d3                     ; 623C:  d3
b01_a23d:   .db vm_sp_lo                     ; 623D:  02
b01_a23e:   ldy $d766                   ; 623E:  ac 66 d7
b01_a241:   rts                         ; 6241:  60
b01_a242:   sbc #$1e                    ; 6242:  e9 1e
b01_a244:   .db $87                     ; 6244:  87
b01_a245:   .db vm_sp_lo                     ; 6245:  02
b01_a246:   dec $53,x                   ; 6246:  d6 53
b01_a248:   ldx #$8e                    ; 6248:  a2 8e
b01_a24a:   adc #$fb                    ; 624A:  69 fb
b01_a24c:   sbc #$26                    ; 624C:  e9 26
b01_a24e:   .db $d3                     ; 624E:  d3
b01_a24f:   .db vm_sp_lo                     ; 624F:  02
b01_a250:   ldy $d766                   ; 6250:  ac 66 d7
b01_a253:   rti                         ; 6253:  40
b01_a254:   .db $cf                     ; 6254:  cf
hire_stat_drain_rng:   jsr $e823                   ; 6255:  20 23 e8
b01_a258:   brk                         ; 6258:  00
b01_a259:   brk                         ; 6259:  00
b01_a25a:   adc ($3d,x)                 ; 625A:  61 3d
b01_a25c:   sbc #$cd                    ; 625C:  e9 cd
b01_a25e:   .db $cb                     ; 625E:  cb
b01_a25f:   .db vm_sp_lo                     ; 625F:  02
b01_a260:   .db $b3                     ; 6260:  b3
b01_a261:   .db $3c                     ; 6261:  3c
b01_a262:   sbc #$0d                    ; 6262:  e9 0d
b01_a264:   .db $d7                     ; 6264:  d7
b01_a265:   .db vm_fp_lo                     ; 6265:  04
b01_a266:   .db $b3                     ; 6266:  b3
b01_a267:   sbc #$6f                    ; 6267:  e9 6f
b01_a269:   .db $cb                     ; 6269:  cb
b01_a26a:   .db vm_fp_lo                     ; 626A:  04
b01_a26b:   .db $b3                     ; 626B:  b3
b01_a26c:   sbc #$52                    ; 626C:  e9 52
b01_a26e:   dex                         ; 626E:  ca
b01_a26f:   .db vm_sp_lo                     ; 626F:  02
b01_a270:   bne $a2c7                   ; 6270:  d0 55
b01_a272:   lda $cf,x                   ; 6272:  b5 cf
report_fief_stat_decline:   jsr $e823                   ; 6274:  20 23 e8
b01_a277:   brk                         ; 6277:  00
b01_a278:   brk                         ; 6278:  00
b01_a279:   and $570c,x                 ; 6279:  3d 0c 57
b01_a27c:   cpy #$d8                    ; 627C:  c0 d8
b01_a27e:   stx $a2                     ; 627E:  86 a2
b01_a280:   txa                         ; 6280:  8a
b01_a281:   adc ($bd),y                 ; 6281:  71 bd
b01_a283:   dec $8d,x                   ; 6283:  d6 8d
b01_a285:   ldx #$0c                    ; 6285:  a2 0c
b01_a287:   .db $d2                     ; 6287:  d2
b01_a288:   sty $f8ae                   ; 6288:  8c ae f8
b01_a28b:   .db $bb                     ; 628B:  bb
b01_a28c:   bcs $a241                   ; 628C:  b0 b3
b01_a28e:   ldy $63                     ; 628E:  a4 63
b01_a290:   .db p2_buttons                     ; 6290:  6f
b01_a291:   bne $a246                   ; 6291:  d0 b3
b01_a293:   stx $bd50                   ; 6293:  8e 50 bd
b01_a296:   sbc #$34                    ; 6296:  e9 34
b01_a298:   cmp ($08),y                 ; 6298:  d1 08
b01_a29a:   .db $cf                     ; 629A:  cf
effect_ninja_failed:   jsr $e823                   ; 629B:  20 23 e8
b01_a29e:   brk                         ; 629E:  00
b01_a29f:   brk                         ; 629F:  00
b01_a2a0:   adc ($ac,x)                 ; 62A0:  61 ac
b01_a2a2:   nop                         ; 62A2:  ea
b01_a2a3:   .db $d7                     ; 62A3:  d7
b01_a2a4:   .db palette_dirty                     ; 62A4:  74
b01_a2a5:   .db $b3                     ; 62A5:  b3
b01_a2a6:   sbc #$12                    ; 62A6:  e9 12
b01_a2a8:   dex                         ; 62A8:  ca
b01_a2a9:   .db vm_fp_lo                     ; 62A9:  04
b01_a2aa:   stx $bd7c                   ; 62AA:  8e 7c bd
b01_a2ad:   sbc #$c4                    ; 62AD:  e9 c4
b01_a2af:   dec $ac02                   ; 62AF:  ce 02 ac
b01_a2b2:   eor $3dd7,y                 ; 62B2:  59 d7 3d
b01_a2b5:   tax                         ; 62B5:  aa
b01_a2b6:   .db $13                     ; 62B6:  13
b01_a2b7:   ror $03e9                   ; 62B7:  6e e9 03
b01_a2ba:   .db clock_a_hi                     ; 62BA:  83
b01_a2bb:   .db vm_fp_lo                     ; 62BB:  04
b01_a2bc:   .db $b3                     ; 62BC:  b3
b01_a2bd:   ldy $5f                     ; 62BD:  a4 5f
b01_a2bf:   .db p2_buttons                     ; 62BF:  6f
b01_a2c0:   .db $8b                     ; 62C0:  8b
b01_a2c1:   .db $1a                     ; 62C1:  1a
b01_a2c2:   lda $8c,x                   ; 62C2:  b5 8c
b01_a2c4:   ora ($70,x)                 ; 62C4:  01 70
b01_a2c6:   .db $bb                     ; 62C6:  bb
b01_a2c7:   ldy $b3,x                   ; 62C7:  b4 b3
b01_a2c9:   bcs $a287                   ; 62C9:  b0 bc
b01_a2cb:   lda ($65),y                 ; 62CB:  b1 65
b01_a2cd:   sbc #$4e                    ; 62CD:  e9 4e
b01_a2cf:   txa                         ; 62CF:  8a
b01_a2d0:   .db vm_sp_lo                     ; 62D0:  02
b01_a2d1:   .db $cf                     ; 62D1:  cf
effect_ninja_sabotage:   jsr $e823                   ; 62D2:  20 23 e8
b01_a2d5:   inc $ff,x                   ; 62D5:  f6 ff
b01_a2d7:   .db $0c                     ; 62D7:  0c
b01_a2d8:   .db $8f                     ; 62D8:  8f
b01_a2d9:   clc                         ; 62D9:  18
b01_a2da:   bcs $a28f                   ; 62DA:  b0 b3
b01_a2dc:   tax                         ; 62DC:  aa
b01_a2dd:   .db $13                     ; 62DD:  13
b01_a2de:   ror $b00c                   ; 62DE:  6e 0c b0
b01_a2e1:   .db $b3                     ; 62E1:  b3
b01_a2e2:   sbc #$57                    ; 62E2:  e9 57
b01_a2e4:   .db clock_a_hi                     ; 62E4:  83
b01_a2e5:   asl $2b                     ; 62E5:  06 2b
b01_a2e7:   cld                         ; 62E7:  d8
b01_a2e8:   rts                         ; 62E8:  60
b01_a2e9:   .db $a3                     ; 62E9:  a3
b01_a2ea:   stx $f9a6                   ; 62EA:  8e a6 f9
b01_a2ed:   sbc #$26                    ; 62ED:  e9 26
b01_a2ef:   .db $d3                     ; 62EF:  d3
b01_a2f0:   .db vm_sp_lo                     ; 62F0:  02
b01_a2f1:   .db $3b                     ; 62F1:  3b
b01_a2f2:   adc ($e9,x)                 ; 62F2:  61 e9
b01_a2f4:   sbc #$d5                    ; 62F4:  e9 d5
b01_a2f6:   .db vm_fp_lo                     ; 62F6:  04
b01_a2f7:   and #$d8                    ; 62F7:  29 d8
b01_a2f9:   eor ($a5),y                 ; 62F9:  51 a5
b01_a2fb:   rts                         ; 62FB:  60
b01_a2fc:   sbc #$10                    ; 62FC:  e9 10
b01_a2fe:   sbc vm_sp_lo                     ; 62FE:  e5 02
b01_a300:   stx fief_index_list                   ; 6300:  8e 89 6f
b01_a303:   stx $00ff                   ; 6303:  8e ff 00
b01_a306:   sbc #$9f                    ; 6306:  e9 9f
b01_a308:   .db $87                     ; 6308:  87
b01_a309:   .db vm_fp_lo                     ; 6309:  04
b01_a30a:   cld                         ; 630A:  d8
b01_a30b:   eor ($a5),y                 ; 630B:  51 a5
b01_a30d:   stx $fac8                   ; 630D:  8e c8 fa
b01_a310:   sbc #$c4                    ; 6310:  e9 c4
b01_a312:   dec $8e02                   ; 6312:  ce 02 8e
b01_a315:   .db skip_wallclock                     ; 6315:  89
b01_a316:   .db p2_buttons                     ; 6316:  6f
b01_a317:   sbc #$4c                    ; 6317:  e9 4c
b01_a319:   .db skip_vblank_wait                     ; 6319:  80
b01_a31a:   .db vm_sp_lo                     ; 631A:  02
b01_a31b:   tay                         ; 631B:  a8
b01_a31c:   .db $63                     ; 631C:  63
b01_a31d:   .db p2_buttons                     ; 631D:  6f
b01_a31e:   cld                         ; 631E:  d8
b01_a31f:   eor ($a5),y                 ; 631F:  51 a5
b01_a321:   ldy $63                     ; 6321:  a4 63
b01_a323:   .db p2_buttons                     ; 6323:  6f
b01_a324:   cmp ($a8),y                 ; 6324:  d1 a8
b01_a326:   .db $63                     ; 6326:  63
b01_a327:   .db p2_buttons                     ; 6327:  6f
b01_a328:   ldy $cc89                   ; 6328:  ac 89 cc
b01_a32b:   stx $fbae                   ; 632B:  8e ae fb
b01_a32e:   sbc #$26                    ; 632E:  e9 26
b01_a330:   .db $d3                     ; 6330:  d3
b01_a331:   .db vm_sp_lo                     ; 6331:  02
b01_a332:   stx $bd8f                   ; 6332:  8e 8f bd
b01_a335:   sbc #$c4                    ; 6335:  e9 c4
b01_a337:   dec $6502                   ; 6337:  ce 02 65
b01_a33a:   adc ($e9,x)                 ; 633A:  61 e9
b01_a33c:   sbc #$d5                    ; 633C:  e9 d5
b01_a33e:   .db vm_fp_lo                     ; 633E:  04
b01_a33f:   rol a                       ; 633F:  2a
b01_a340:   cld                         ; 6340:  d8
b01_a341:   eor ($a5),y                 ; 6341:  51 a5
b01_a343:   asl a                       ; 6343:  0a
b01_a344:   .db $54                     ; 6344:  54
b01_a345:   cpy #$d8                    ; 6345:  c0 d8
b01_a347:   jmp ($a4a3)                 ; 6347:  6c a3 a4
b01_a34a:   .db $63                     ; 634A:  63
b01_a34b:   .db p2_buttons                     ; 634B:  6f
b01_a34c:   sty fief_is_daimyo_capital                   ; 634C:  8c a2 6d
b01_a34f:   .db $bb                     ; 634F:  bb
b01_a350:   .db $d3                     ; 6350:  d3
b01_a351:   .db $d7                     ; 6351:  d7
b01_a352:   jmp ($8ea3)                 ; 6352:  6c a3 8e
b01_a355:   lda $e9bd,x                 ; 6355:  bd bd e9
b01_a358:   rol $d3                     ; 6358:  26 d3
b01_a35a:   .db vm_sp_lo                     ; 635A:  02
b01_a35b:   ldy $d759                   ; 635B:  ac 59 d7
b01_a35e:   rti                         ; 635E:  40
b01_a35f:   .db $cf                     ; 635F:  cf
b01_a360:   stx $fdd9                   ; 6360:  8e d9 fd
b01_a363:   sbc #$26                    ; 6363:  e9 26
b01_a365:   .db $d3                     ; 6365:  d3
b01_a366:   .db vm_sp_lo                     ; 6366:  02
b01_a367:   ldy $d766                   ; 6367:  ac 66 d7
b01_a36a:   rti                         ; 636A:  40
b01_a36b:   .db $cf                     ; 636B:  cf
b01_a36c:   jmp ($0ce9)                 ; 636C:  6c e9 0c
b01_a36f:   inx                         ; 636F:  e8
b01_a370:   .db vm_sp_lo                     ; 6370:  02
b01_a371:   ldy $63                     ; 6371:  a4 63
b01_a373:   .db p2_buttons                     ; 6373:  6f
b01_a374:   .db $8b                     ; 6374:  8b
b01_a375:   .db $1a                     ; 6375:  1a
b01_a376:   lda $8c,x                   ; 6376:  b5 8c
b01_a378:   ora ($70,x)                 ; 6378:  01 70
b01_a37a:   .db $bb                     ; 637A:  bb
b01_a37b:   bit $cf8e                   ; 637B:  2c 8e cf
b01_a37e:   lda $26e9,x                 ; 637E:  bd e9 26
b01_a381:   .db $d3                     ; 6381:  d3
b01_a382:   .db vm_sp_lo                     ; 6382:  02
b01_a383:   ldy $d7ea                   ; 6383:  ac ea d7
b01_a386:   .db prg_bank_shadow                     ; 6386:  73
b01_a387:   .db $d3                     ; 6387:  d3
b01_a388:   .db $8f                     ; 6388:  8f
b01_a389:   asl $aab3,x                 ; 6389:  1e b3 aa
b01_a38c:   .db $63                     ; 638C:  63
b01_a38d:   .db p2_buttons                     ; 638D:  6f
b01_a38e:   sbc #$da                    ; 638E:  e9 da
b01_a390:   .db $d7                     ; 6390:  d7
b01_a391:   .db vm_sp_lo                     ; 6391:  02
b01_a392:   .db prg_bank_shadow                     ; 6392:  73
b01_a393:   .db $d3                     ; 6393:  d3
b01_a394:   ldy $c2,x                   ; 6394:  b4 c2
b01_a396:   cld                         ; 6396:  d8
b01_a397:   eor #$a5                    ; 6397:  49 a5
b01_a399:   asl a                       ; 6399:  0a
b01_a39a:   cmp $ff,x                   ; 639A:  d5 ff
b01_a39c:   .db $ff                     ; 639C:  ff
b01_a39d:   ora scratch_ptr_lo                     ; 639D:  05 00
b01_a39f:   ora $aba4,x                 ; 639F:  1d a4 ab
b01_a3a2:   .db $a3                     ; 63A2:  a3
b01_a3a3:   .db $5a                     ; 63A3:  5a
b01_a3a4:   ldy $97                     ; 63A4:  a4 97
b01_a3a6:   ldy $08                     ; 63A6:  a4 08
b01_a3a8:   lda $10                     ; 63A8:  a5 10
b01_a3aa:   lda $0c                     ; 63AA:  a5 0c
b01_a3ac:   .db $7c                     ; 63AC:  7c
b01_a3ad:   bcs $a386                   ; 63AD:  b0 d7
b01_a3af:   .db $bf                     ; 63AF:  bf
b01_a3b0:   .db $a3                     ; 63B0:  a3
b01_a3b1:   .db $0c                     ; 63B1:  0c
b01_a3b2:   ror $d7b0,x                 ; 63B2:  7e b0 d7
b01_a3b5:   .db $bf                     ; 63B5:  bf
b01_a3b6:   .db $a3                     ; 63B6:  a3
b01_a3b7:   and $e938,y                 ; 63B7:  39 38 e9
b01_a3ba:   .db $9b                     ; 63BA:  9b
b01_a3bb:   ldx #$04                    ; 63BB:  a2 04
b01_a3bd:   eor ($cf,x)                 ; 63BD:  41 cf
b01_a3bf:   sta $e91c                   ; 63BF:  8d 1c e9
b01_a3c2:   .db $0c                     ; 63C2:  0c
b01_a3c3:   inx                         ; 63C3:  e8
b01_a3c4:   .db vm_sp_lo                     ; 63C4:  02
b01_a3c5:   and $7c0c,y                 ; 63C5:  39 0c 7c
b01_a3c8:   bcs $a37d                   ; 63C8:  b0 b3
b01_a3ca:   sbc #$55                    ; 63CA:  e9 55
b01_a3cc:   ldx #$04                    ; 63CC:  a2 04
b01_a3ce:   .db $27                     ; 63CE:  27
b01_a3cf:   .db $0c                     ; 63CF:  0c
b01_a3d0:   .db $7c                     ; 63D0:  7c
b01_a3d1:   bcs $a3ea                   ; 63D1:  b0 17
b01_a3d3:   cmp $d8                     ; 63D3:  c5 d8
b01_a3d5:   .db $db                     ; 63D5:  db
b01_a3d6:   .db $a3                     ; 63D6:  a3
b01_a3d7:   .db vm_ip_hi                     ; 63D7:  07
b01_a3d8:   dec $de,x                   ; 63D8:  d6 de
b01_a3da:   .db $a3                     ; 63DA:  a3
b01_a3db:   .db $0c                     ; 63DB:  0c
b01_a3dc:   .db $7c                     ; 63DC:  7c
b01_a3dd:   bcs $a406                   ; 63DD:  b0 27
b01_a3df:   .db vm_ip_hi                     ; 63DF:  07
b01_a3e0:   cld                         ; 63E0:  d8
b01_a3e1:   sbc ($a3),y                 ; 63E1:  f1 a3
b01_a3e3:   .db $37                     ; 63E3:  37
b01_a3e4:   .db $0c                     ; 63E4:  0c
b01_a3e5:   .db $7c                     ; 63E5:  7c
b01_a3e6:   ldy $b3,x                   ; 63E6:  b4 b3
b01_a3e8:   bcs $a3a6                   ; 63E8:  b0 bc
b01_a3ea:   lda ($37),y                 ; 63EA:  b1 37
b01_a3ec:   jmp ($74e9)                 ; 63EC:  6c e9 74
b01_a3ef:   ldx #$04                    ; 63EF:  a2 04
b01_a3f1:   and $7e0c,y                 ; 63F1:  39 0c 7e
b01_a3f4:   bcs $a3a9                   ; 63F4:  b0 b3
b01_a3f6:   sbc #$55                    ; 63F6:  e9 55
b01_a3f8:   ldx #$04                    ; 63F8:  a2 04
b01_a3fa:   .db $27                     ; 63FA:  27
b01_a3fb:   .db $0c                     ; 63FB:  0c
b01_a3fc:   ror $17b0,x                 ; 63FC:  7e b0 17
b01_a3ff:   cmp $d8                     ; 63FF:  c5 d8
b01_a401:   .db vm_ip_hi                     ; 6401:  07
b01_a402:   ldy vm_ip_hi                     ; 6402:  a4 07
b01_a404:   dec $0a,x                   ; 6404:  d6 0a
b01_a406:   ldy $0c                     ; 6406:  a4 0c
b01_a408:   ror $27b0,x                 ; 6408:  7e b0 27
b01_a40b:   .db vm_ip_hi                     ; 640B:  07
b01_a40c:   cld                         ; 640C:  d8
b01_a40d:   ora $37a4,x                 ; 640D:  1d a4 37
b01_a410:   .db $0c                     ; 6410:  0c
b01_a411:   ror $b3b4,x                 ; 6411:  7e b4 b3
b01_a414:   bcs $a3d2                   ; 6414:  b0 bc
b01_a416:   lda ($37),y                 ; 6416:  b1 37
b01_a418:   adc $74e9                   ; 6418:  6d e9 74
b01_a41b:   ldx #$04                    ; 641B:  a2 04
b01_a41d:   tax                         ; 641D:  aa
b01_a41e:   .db $5f                     ; 641E:  5f
b01_a41f:   .db p2_buttons                     ; 641F:  6f
b01_a420:   sbc #$36                    ; 6420:  e9 36
b01_a422:   cld                         ; 6422:  d8
b01_a423:   .db vm_sp_lo                     ; 6423:  02
b01_a424:   asl a                       ; 6424:  0a
b01_a425:   .db $54                     ; 6425:  54
b01_a426:   cpy #$d7                    ; 6426:  c0 d7
b01_a428:   .db $3b                     ; 6428:  3b
b01_a429:   ldy $0a                     ; 6429:  a4 0a
b01_a42b:   cld                         ; 642B:  d8
b01_a42c:   .db $3b                     ; 642C:  3b
b01_a42d:   ldy $ac                     ; 642D:  a4 ac
b01_a42f:   ror $d7                     ; 642F:  66 d7
b01_a431:   stx $fbbb                   ; 6431:  8e bb fb
b01_a434:   sbc #$26                    ; 6434:  e9 26
b01_a436:   .db $d3                     ; 6436:  d3
b01_a437:   .db vm_sp_lo                     ; 6437:  02
b01_a438:   ldy $d766                   ; 6438:  ac 66 d7
b01_a43b:   and $13aa,y                 ; 643B:  39 aa 13
b01_a43e:   ror $03e9                   ; 643E:  6e e9 03
b01_a441:   .db clock_a_hi                     ; 6441:  83
b01_a442:   .db vm_fp_lo                     ; 6442:  04
b01_a443:   .db $b3                     ; 6443:  b3
b01_a444:   ldy $5f                     ; 6444:  a4 5f
b01_a446:   .db p2_buttons                     ; 6446:  6f
b01_a447:   .db $8b                     ; 6447:  8b
b01_a448:   .db $1a                     ; 6448:  1a
b01_a449:   lda $8c,x                   ; 6449:  b5 8c
b01_a44b:   ora ($70,x)                 ; 644B:  01 70
b01_a44d:   .db $bb                     ; 644D:  bb
b01_a44e:   ldy $b3,x                   ; 644E:  b4 b3
b01_a450:   bcs $a40e                   ; 6450:  b0 bc
b01_a452:   lda ($65),y                 ; 6452:  b1 65
b01_a454:   sbc #$4e                    ; 6454:  e9 4e
b01_a456:   txa                         ; 6456:  8a
b01_a457:   .db vm_sp_lo                     ; 6457:  02
b01_a458:   eor ($cf,x)                 ; 6458:  41 cf
b01_a45a:   and $8f0c,y                 ; 645A:  39 0c 8f
b01_a45d:   .db $12                     ; 645D:  12
b01_a45e:   bcs $a413                   ; 645E:  b0 b3
b01_a460:   sbc #$55                    ; 6460:  e9 55
b01_a462:   ldx #$04                    ; 6462:  a2 04
b01_a464:   .db $27                     ; 6464:  27
b01_a465:   .db $0c                     ; 6465:  0c
b01_a466:   .db $8f                     ; 6466:  8f
b01_a467:   .db $12                     ; 6467:  12
b01_a468:   bcs $a481                   ; 6468:  b0 17
b01_a46a:   cmp $d8                     ; 646A:  c5 d8
b01_a46c:   .db ppumask_shadow                     ; 646C:  72
b01_a46d:   ldy vm_ip_hi                     ; 646D:  a4 07
b01_a46f:   dec mul_acc_hi,x                   ; 646F:  d6 76
b01_a471:   ldy $0c                     ; 6471:  a4 0c
b01_a473:   .db $8f                     ; 6473:  8f
b01_a474:   .db $12                     ; 6474:  12
b01_a475:   bcs $a49e                   ; 6475:  b0 27
b01_a477:   .db vm_ip_hi                     ; 6477:  07
b01_a478:   .db $d7                     ; 6478:  d7
b01_a479:   .db clock_a_hi                     ; 6479:  83
b01_a47a:   ldy $39                     ; 647A:  a4 39
b01_a47c:   sec                         ; 647C:  38
b01_a47d:   sbc #$9b                    ; 647D:  e9 9b
b01_a47f:   ldx #$04                    ; 647F:  a2 04
b01_a481:   eor ($cf,x)                 ; 6481:  41 cf
b01_a483:   sta $e91b                   ; 6483:  8d 1b e9
b01_a486:   .db $0c                     ; 6486:  0c
b01_a487:   inx                         ; 6487:  e8
b01_a488:   .db vm_sp_lo                     ; 6488:  02
b01_a489:   .db $37                     ; 6489:  37
b01_a48a:   .db $0c                     ; 648A:  0c
b01_a48b:   .db $8f                     ; 648B:  8f
b01_a48c:   .db $12                     ; 648C:  12
b01_a48d:   ldy $b3,x                   ; 648D:  b4 b3
b01_a48f:   bcs $a44d                   ; 648F:  b0 bc
b01_a491:   lda ($37),y                 ; 6491:  b1 37
b01_a493:   .db p2_buttons                     ; 6493:  6f
b01_a494:   dec $19,x                   ; 6494:  d6 19
b01_a496:   ldy $0c                     ; 6496:  a4 0c
b01_a498:   .db music_ptr_lo                     ; 6498:  7a
b01_a499:   bcs $a472                   ; 6499:  b0 d7
b01_a49b:   .db $ab                     ; 649B:  ab
b01_a49c:   ldy $0c                     ; 649C:  a4 0c
b01_a49e:   ror nmi_skip_all,x                   ; 649E:  76 b0
b01_a4a0:   .db $d7                     ; 64A0:  d7
b01_a4a1:   .db $ab                     ; 64A1:  ab
b01_a4a2:   ldy $39                     ; 64A2:  a4 39
b01_a4a4:   sec                         ; 64A4:  38
b01_a4a5:   sbc #$9b                    ; 64A5:  e9 9b
b01_a4a7:   ldx #$04                    ; 64A7:  a2 04
b01_a4a9:   eor ($cf,x)                 ; 64A9:  41 cf
b01_a4ab:   sta $e91e                   ; 64AB:  8d 1e e9
b01_a4ae:   .db $0c                     ; 64AE:  0c
b01_a4af:   inx                         ; 64AF:  e8
b01_a4b0:   .db vm_sp_lo                     ; 64B0:  02
b01_a4b1:   and $7a0c,y                 ; 64B1:  39 0c 7a
b01_a4b4:   bcs $a469                   ; 64B4:  b0 b3
b01_a4b6:   sbc #$55                    ; 64B6:  e9 55
b01_a4b8:   ldx #$04                    ; 64B8:  a2 04
b01_a4ba:   .db $27                     ; 64BA:  27
b01_a4bb:   .db $0c                     ; 64BB:  0c
b01_a4bc:   .db music_ptr_lo                     ; 64BC:  7a
b01_a4bd:   bcs $a4d6                   ; 64BD:  b0 17
b01_a4bf:   cmp $d8                     ; 64BF:  c5 d8
b01_a4c1:   .db $c7                     ; 64C1:  c7
b01_a4c2:   ldy vm_ip_hi                     ; 64C2:  a4 07
b01_a4c4:   dec $ca,x                   ; 64C4:  d6 ca
b01_a4c6:   ldy $0c                     ; 64C6:  a4 0c
b01_a4c8:   .db music_ptr_lo                     ; 64C8:  7a
b01_a4c9:   bcs $a4f2                   ; 64C9:  b0 27
b01_a4cb:   .db vm_ip_hi                     ; 64CB:  07
b01_a4cc:   cld                         ; 64CC:  d8
b01_a4cd:   cmp $37a4,x                 ; 64CD:  dd a4 37
b01_a4d0:   .db $0c                     ; 64D0:  0c
b01_a4d1:   .db music_ptr_lo                     ; 64D1:  7a
b01_a4d2:   ldy $b3,x                   ; 64D2:  b4 b3
b01_a4d4:   bcs $a492                   ; 64D4:  b0 bc
b01_a4d6:   lda ($37),y                 ; 64D6:  b1 37
b01_a4d8:   .db $6b                     ; 64D8:  6b
b01_a4d9:   sbc #$74                    ; 64D9:  e9 74
b01_a4db:   ldx #$04                    ; 64DB:  a2 04
b01_a4dd:   and $760c,y                 ; 64DD:  39 0c 76
b01_a4e0:   bcs $a495                   ; 64E0:  b0 b3
b01_a4e2:   sbc #$55                    ; 64E2:  e9 55
b01_a4e4:   ldx #$04                    ; 64E4:  a2 04
b01_a4e6:   .db $27                     ; 64E6:  27
b01_a4e7:   .db $0c                     ; 64E7:  0c
b01_a4e8:   ror nmi_skip_all,x                   ; 64E8:  76 b0
b01_a4ea:   .db $17                     ; 64EA:  17
b01_a4eb:   cmp $d8                     ; 64EB:  c5 d8
b01_a4ed:   .db $f3                     ; 64ED:  f3
b01_a4ee:   ldy vm_ip_hi                     ; 64EE:  a4 07
b01_a4f0:   dec $f6,x                   ; 64F0:  d6 f6
b01_a4f2:   ldy $0c                     ; 64F2:  a4 0c
b01_a4f4:   ror nmi_skip_all,x                   ; 64F4:  76 b0
b01_a4f6:   .db $27                     ; 64F6:  27
b01_a4f7:   .db vm_ip_hi                     ; 64F7:  07
b01_a4f8:   cld                         ; 64F8:  d8
b01_a4f9:   ora $37a4,x                 ; 64F9:  1d a4 37
b01_a4fc:   .db $0c                     ; 64FC:  0c
b01_a4fd:   ror $b4,x                   ; 64FD:  76 b4
b01_a4ff:   .db $b3                     ; 64FF:  b3
b01_a500:   bcs $a4be                   ; 6500:  b0 bc
b01_a502:   lda ($37),y                 ; 6502:  b1 37
b01_a504:   adc #$d6                    ; 6504:  69 d6
b01_a506:   ora $39a4,y                 ; 6506:  19 a4 39
b01_a509:   sbc #$8d                    ; 6509:  e9 8d
b01_a50b:   sta (vm_sp_lo),y                 ; 650B:  91 02
b01_a50d:   dec ppu_queue_a_hi,x                   ; 650D:  d6 1d
b01_a50f:   ldy $39                     ; 650F:  a4 39
b01_a511:   .db $0c                     ; 6511:  0c
b01_a512:   .db palette_dirty                     ; 6512:  74
b01_a513:   bcs $a4c8                   ; 6513:  b0 b3
b01_a515:   sbc #$55                    ; 6515:  e9 55
b01_a517:   ldx #$04                    ; 6517:  a2 04
b01_a519:   .db $27                     ; 6519:  27
b01_a51a:   .db $0c                     ; 651A:  0c
b01_a51b:   .db palette_dirty                     ; 651B:  74
b01_a51c:   bcs $a535                   ; 651C:  b0 17
b01_a51e:   cmp $d8                     ; 651E:  c5 d8
b01_a520:   rol $a5                     ; 6520:  26 a5
b01_a522:   .db vm_ip_hi                     ; 6522:  07
b01_a523:   dec $29,x                   ; 6523:  d6 29
b01_a525:   lda $0c                     ; 6525:  a5 0c
b01_a527:   .db palette_dirty                     ; 6527:  74
b01_a528:   bcs $a551                   ; 6528:  b0 27
b01_a52a:   .db vm_ip_hi                     ; 652A:  07
b01_a52b:   .db $d7                     ; 652B:  d7
b01_a52c:   rol $a5,x                   ; 652C:  36 a5
b01_a52e:   and $e938,y                 ; 652E:  39 38 e9
b01_a531:   .db $9b                     ; 6531:  9b
b01_a532:   ldx #$04                    ; 6532:  a2 04
b01_a534:   eor ($cf,x)                 ; 6534:  41 cf
b01_a536:   sta $e91d                   ; 6536:  8d 1d e9
b01_a539:   .db $0c                     ; 6539:  0c
b01_a53a:   inx                         ; 653A:  e8
b01_a53b:   .db vm_sp_lo                     ; 653B:  02
b01_a53c:   .db $37                     ; 653C:  37
b01_a53d:   .db $0c                     ; 653D:  0c
b01_a53e:   .db palette_dirty                     ; 653E:  74
b01_a53f:   ldy $b3,x                   ; 653F:  b4 b3
b01_a541:   bcs $a4ff                   ; 6541:  b0 bc
b01_a543:   lda ($37),y                 ; 6543:  b1 37
b01_a545:   .db brk_scratch_hi                     ; 6545:  67
b01_a546:   dec $19,x                   ; 6546:  d6 19
b01_a548:   ldy $39                     ; 6548:  a4 39
b01_a54a:   sec                         ; 654A:  38
b01_a54b:   sbc #$9b                    ; 654B:  e9 9b
b01_a54d:   ldx #$04                    ; 654D:  a2 04
b01_a54f:   eor ($cf,x)                 ; 654F:  41 cf
b01_a551:   rti                         ; 6551:  40
b01_a552:   .db $cf                     ; 6552:  cf
effect_hire_men:   jsr $e823                   ; 6553:  20 23 e8
b01_a556:   .db $fa                     ; 6556:  fa
b01_a557:   .db $ff                     ; 6557:  ff
b01_a558:   .db $0c                     ; 6558:  0c
b01_a559:   .db $8f                     ; 6559:  8f
b01_a55a:   bpl $a50c                   ; 655A:  10 b0
b01_a55c:   .db $b3                     ; 655C:  b3
b01_a55d:   .db $0c                     ; 655D:  0c
b01_a55e:   .db $8f                     ; 655E:  8f
b01_a55f:   clc                         ; 655F:  18
b01_a560:   bcs $a516                   ; 6560:  b0 b4
b01_a562:   ldy $b329,x                 ; 6562:  bc 29 b3
b01_a565:   tax                         ; 6565:  aa
b01_a566:   ora (p1_buttons),y                 ; 6566:  11 6e
b01_a568:   .db $0c                     ; 6568:  0c
b01_a569:   bcs $a51e                   ; 6569:  b0 b3
b01_a56b:   sbc #$57                    ; 656B:  e9 57
b01_a56d:   .db clock_a_hi                     ; 656D:  83
b01_a56e:   asl $2b                     ; 656E:  06 2b
b01_a570:   cld                         ; 6570:  d8
b01_a571:   cmp $8ea5,x                 ; 6571:  dd a5 8e
b01_a574:   ldx $f9                     ; 6574:  a6 f9
b01_a576:   sbc #$26                    ; 6576:  e9 26
b01_a578:   .db $d3                     ; 6578:  d3
b01_a579:   .db vm_sp_lo                     ; 6579:  02
b01_a57a:   .db $3b                     ; 657A:  3b
b01_a57b:   adc ($e9,x)                 ; 657B:  61 e9
b01_a57d:   sbc #$d5                    ; 657D:  e9 d5
b01_a57f:   .db vm_fp_lo                     ; 657F:  04
b01_a580:   rol a                       ; 6580:  2a
b01_a581:   cld                         ; 6581:  d8
b01_a582:   .db $f2                     ; 6582:  f2
b01_a583:   lda $3a                     ; 6583:  a5 3a
b01_a585:   tax                         ; 6585:  aa
b01_a586:   ora (p1_buttons),y                 ; 6586:  11 6e
b01_a588:   sbc #$03                    ; 6588:  e9 03
b01_a58a:   .db clock_a_hi                     ; 658A:  83
b01_a58b:   .db vm_fp_lo                     ; 658B:  04
b01_a58c:   .db $b3                     ; 658C:  b3
b01_a58d:   .db $0c                     ; 658D:  0c
b01_a58e:   ldy $b3,x                   ; 658E:  b4 b3
b01_a590:   bcs $a54e                   ; 6590:  b0 bc
b01_a592:   lda ($3a),y                 ; 6592:  b1 3a
b01_a594:   .db $3c                     ; 6594:  3c
b01_a595:   sbc #$f4                    ; 6595:  e9 f4
b01_a597:   .db $8b                     ; 6597:  8b
b01_a598:   .db vm_fp_lo                     ; 6598:  04
b01_a599:   .db $3c                     ; 6599:  3c
b01_a59a:   tax                         ; 659A:  aa
b01_a59b:   .db $5f                     ; 659B:  5f
b01_a59c:   .db p2_buttons                     ; 659C:  6f
b01_a59d:   sbc #$fe                    ; 659D:  e9 fe
b01_a59f:   .db $df                     ; 659F:  df
b01_a5a0:   .db vm_fp_lo                     ; 65A0:  04
b01_a5a1:   .db $64                     ; 65A1:  64
b01_a5a2:   sbc #$4e                    ; 65A2:  e9 4e
b01_a5a4:   txa                         ; 65A4:  8a
b01_a5a5:   .db vm_sp_lo                     ; 65A5:  02
b01_a5a6:   .db $0c                     ; 65A6:  0c
b01_a5a7:   .db $8f                     ; 65A7:  8f
b01_a5a8:   bpl $a55d                   ; 65A8:  10 b3
b01_a5aa:   sbc #$ac                    ; 65AA:  e9 ac
b01_a5ac:   .db $82                     ; 65AC:  82
b01_a5ad:   .db vm_sp_lo                     ; 65AD:  02
b01_a5ae:   sta $e921                   ; 65AE:  8d 21 e9
b01_a5b1:   .db $0c                     ; 65B1:  0c
b01_a5b2:   inx                         ; 65B2:  e8
b01_a5b3:   .db vm_sp_lo                     ; 65B3:  02
b01_a5b4:   stx $bdd0                   ; 65B4:  8e d0 bd
b01_a5b7:   sbc #$26                    ; 65B7:  e9 26
b01_a5b9:   .db $d3                     ; 65B9:  d3
b01_a5ba:   .db vm_sp_lo                     ; 65BA:  02
b01_a5bb:   ldy $5f                     ; 65BB:  a4 5f
b01_a5bd:   .db p2_buttons                     ; 65BD:  6f
b01_a5be:   .db $8b                     ; 65BE:  8b
b01_a5bf:   .db $1a                     ; 65BF:  1a
b01_a5c0:   lda $8c,x                   ; 65C0:  b5 8c
b01_a5c2:   ora ($70),y                 ; 65C2:  11 70
b01_a5c4:   .db $bb                     ; 65C4:  bb
b01_a5c5:   bcs $a57a                   ; 65C5:  b0 b3
b01_a5c7:   ldy $d77e                   ; 65C7:  ac 7e d7
b01_a5ca:   eor $8cb5,y                 ; 65CA:  59 b5 8c
b01_a5cd:   tay                         ; 65CD:  a8
b01_a5ce:   .db $77                     ; 65CE:  77
b01_a5cf:   .db $bb                     ; 65CF:  bb
b01_a5d0:   .db $b3                     ; 65D0:  b3
b01_a5d1:   stx $fb90                   ; 65D1:  8e 90 fb
b01_a5d4:   sbc #$34                    ; 65D4:  e9 34
b01_a5d6:   cmp (vm_ip_lo),y                 ; 65D6:  d1 06
b01_a5d8:   ldy $d766                   ; 65D8:  ac 66 d7
b01_a5db:   eor ($cf,x)                 ; 65DB:  41 cf
b01_a5dd:   ora #$d8                    ; 65DD:  09 d8
b01_a5df:   .db $e7                     ; 65DF:  e7
b01_a5e0:   lda $8a                     ; 65E0:  a5 8a
b01_a5e2:   cmp $d6fd,y                 ; 65E2:  d9 fd d6
b01_a5e5:   nop                         ; 65E5:  ea
b01_a5e6:   lda $8a                     ; 65E6:  a5 8a
b01_a5e8:   dec $fd                     ; 65E8:  c6 fd
b01_a5ea:   .db $b3                     ; 65EA:  b3
b01_a5eb:   sbc #$26                    ; 65EB:  e9 26
b01_a5ed:   .db $d3                     ; 65ED:  d3
b01_a5ee:   .db vm_sp_lo                     ; 65EE:  02
b01_a5ef:   ldy $d766                   ; 65EF:  ac 66 d7
b01_a5f2:   rti                         ; 65F2:  40
b01_a5f3:   .db $cf                     ; 65F3:  cf
driver_hire:   jsr $e823                   ; 65F4:  20 23 e8
b01_a5f7:   .db $fc                     ; 65F7:  fc
b01_a5f8:   .db $ff                     ; 65F8:  ff
b01_a5f9:   tax                         ; 65F9:  aa
b01_a5fa:   .db $5f                     ; 65FA:  5f
b01_a5fb:   .db p2_buttons                     ; 65FB:  6f
b01_a5fc:   sbc #$51                    ; 65FC:  e9 51
b01_a5fe:   .db $93                     ; 65FE:  93
b01_a5ff:   .db vm_sp_lo                     ; 65FF:  02
b01_a600:   cld                         ; 6600:  d8
b01_a601:   and $a6,x                   ; 6601:  35 a6
b01_a603:   stx $fb81                   ; 6603:  8e 81 fb
b01_a606:   sbc #$26                    ; 6606:  e9 26
b01_a608:   .db $d3                     ; 6608:  d3
b01_a609:   .db vm_sp_lo                     ; 6609:  02
b01_a60a:   ldy $5f                     ; 660A:  a4 5f
b01_a60c:   .db p2_buttons                     ; 660C:  6f
b01_a60d:   .db $8b                     ; 660D:  8b
b01_a60e:   .db $1a                     ; 660E:  1a
b01_a60f:   lda $8c,x                   ; 660F:  b5 8c
b01_a611:   ora ($70,x)                 ; 6611:  01 70
b01_a613:   .db $bb                     ; 6613:  bb
b01_a614:   .db $2b                     ; 6614:  2b
b01_a615:   stx $bdd1                   ; 6615:  8e d1 bd
b01_a618:   sbc #$51                    ; 6618:  e9 51
b01_a61a:   .db $d3                     ; 661A:  d3
b01_a61b:   .db vm_sp_lo                     ; 661B:  02
b01_a61c:   cmp vm_sp_lo,y                 ; 661C:  d9 02 00
b01_a61f:   brk                         ; 661F:  00
b01_a620:   brk                         ; 6620:  00
b01_a621:   and #$a6                    ; 6621:  29 a6
b01_a623:   ora (scratch_ptr_lo,x)                 ; 6623:  01 00
b01_a625:   .db $2f                     ; 6625:  2f
b01_a626:   ldx $35                     ; 6626:  a6 35
b01_a628:   ldx $3b                     ; 6628:  a6 3b
b01_a62a:   sbc #$d2                    ; 662A:  e9 d2
b01_a62c:   ldx #$02                    ; 662C:  a2 02
b01_a62e:   .db $cf                     ; 662E:  cf
b01_a62f:   .db $3b                     ; 662F:  3b
b01_a630:   sbc #$53                    ; 6630:  e9 53
b01_a632:   lda vm_sp_lo                     ; 6632:  a5 02
b01_a634:   .db $cf                     ; 6634:  cf
b01_a635:   rti                         ; 6635:  40
b01_a636:   .db $cf                     ; 6636:  cf
driver_train:   jsr $e823                   ; 6637:  20 23 e8
b01_a63a:   inc $a4ff,x                 ; 663A:  fe ff a4
b01_a63d:   .db $5f                     ; 663D:  5f
b01_a63e:   .db p2_buttons                     ; 663E:  6f
b01_a63f:   .db $8b                     ; 663F:  8b
b01_a640:   .db $1a                     ; 6640:  1a
b01_a641:   lda $8c,x                   ; 6641:  b5 8c
b01_a643:   ora ($70,x)                 ; 6643:  01 70
b01_a645:   .db $bb                     ; 6645:  bb
b01_a646:   .db $2b                     ; 6646:  2b
b01_a647:   .db $0b                     ; 6647:  0b
b01_a648:   .db $8f                     ; 6648:  8f
b01_a649:   clc                         ; 6649:  18
b01_a64a:   bcs $a5ff                   ; 664A:  b0 b3
b01_a64c:   .db $0b                     ; 664C:  0b
b01_a64d:   .db $8f                     ; 664D:  8f
b01_a64e:   .db $14                     ; 664E:  14
b01_a64f:   bcs $a605                   ; 664F:  b0 b4
b01_a651:   .db $c2                     ; 6651:  c2
b01_a652:   cld                         ; 6652:  d8
b01_a653:   .db $a7                     ; 6653:  a7
b01_a654:   ldx $0b                     ; 6654:  a6 0b
b01_a656:   .db $8f                     ; 6656:  8f
b01_a657:   bpl $a609                   ; 6657:  10 b0
b01_a659:   bvc $a61e                   ; 6659:  50 c3
b01_a65b:   cld                         ; 665B:  d8
b01_a65c:   adc ($a6),y                 ; 665C:  71 a6
b01_a65e:   stx $fdfd                   ; 665E:  8e fd fd
b01_a661:   sbc #$c4                    ; 6661:  e9 c4
b01_a663:   dec $aa02                   ; 6663:  ce 02 aa
b01_a666:   .db $5f                     ; 6666:  5f
b01_a667:   .db p2_buttons                     ; 6667:  6f
b01_a668:   sbc #$15                    ; 6668:  e9 15
b01_a66a:   cld                         ; 666A:  d8
b01_a66b:   .db vm_sp_lo                     ; 666B:  02
b01_a66c:   ldy $d766                   ; 666C:  ac 66 d7
b01_a66f:   rti                         ; 666F:  40
b01_a670:   .db $cf                     ; 6670:  cf
b01_a671:   ror a                       ; 6671:  6a
b01_a672:   sbc #$0c                    ; 6672:  e9 0c
b01_a674:   inx                         ; 6674:  e8
b01_a675:   .db vm_sp_lo                     ; 6675:  02
b01_a676:   ldy $9586                   ; 6676:  ac 86 95
b01_a679:   .db $0b                     ; 6679:  0b
b01_a67a:   .db $8f                     ; 667A:  8f
b01_a67b:   .db $14                     ; 667B:  14
b01_a67c:   .db $b3                     ; 667C:  b3
b01_a67d:   .db $0b                     ; 667D:  0b
b01_a67e:   .db $8f                     ; 667E:  8f
b01_a67f:   clc                         ; 667F:  18
b01_a680:   bcs $a635                   ; 6680:  b0 b3
b01_a682:   .db $0b                     ; 6682:  0b
b01_a683:   .db $8f                     ; 6683:  8f
b01_a684:   .db $14                     ; 6684:  14
b01_a685:   bcs $a63b                   ; 6685:  b0 b4
b01_a687:   cpy $d8                     ; 6687:  c4 d8
b01_a689:   sta ($a6),y                 ; 6689:  91 a6
b01_a68b:   .db $0b                     ; 668B:  0b
b01_a68c:   .db $8f                     ; 668C:  8f
b01_a68d:   clc                         ; 668D:  18
b01_a68e:   dec $94,x                   ; 668E:  d6 94
b01_a690:   ldx $0b                     ; 6690:  a6 0b
b01_a692:   .db $8f                     ; 6692:  8f
b01_a693:   .db $14                     ; 6693:  14
b01_a694:   bcs $a647                   ; 6694:  b0 b1
b01_a696:   .db $0b                     ; 6696:  0b
b01_a697:   .db $8f                     ; 6697:  8f
b01_a698:   .db $14                     ; 6698:  14
b01_a699:   bcs $a64e                   ; 6699:  b0 b3
b01_a69b:   stx $fbde                   ; 669B:  8e de fb
b01_a69e:   sbc #$34                    ; 669E:  e9 34
b01_a6a0:   cmp (vm_fp_lo),y                 ; 66A0:  d1 04
b01_a6a2:   ldy $d766                   ; 66A2:  ac 66 d7
b01_a6a5:   eor ($cf,x)                 ; 66A5:  41 cf
b01_a6a7:   stx $bde0                   ; 66A7:  8e e0 bd
b01_a6aa:   sbc #$26                    ; 66AA:  e9 26
b01_a6ac:   .db $d3                     ; 66AC:  d3
b01_a6ad:   .db vm_sp_lo                     ; 66AD:  02
b01_a6ae:   ldy $d766                   ; 66AE:  ac 66 d7
b01_a6b1:   rti                         ; 66B1:  40
b01_a6b2:   .db $cf                     ; 66B2:  cf
effect_view_d:   jsr $e823                   ; 66B3:  20 23 e8
b01_a6b6:   brk                         ; 66B6:  00
b01_a6b7:   brk                         ; 66B7:  00
b01_a6b8:   .db $0c                     ; 66B8:  0c
b01_a6b9:   adc $d3,x                   ; 66B9:  75 d3
b01_a6bb:   .db $b3                     ; 66BB:  b3
b01_a6bc:   .db $0c                     ; 66BC:  0c
b01_a6bd:   .db prg_bank_shadow                     ; 66BD:  73
b01_a6be:   .db $d3                     ; 66BE:  d3
b01_a6bf:   .db $b3                     ; 66BF:  b3
b01_a6c0:   sbc #$52                    ; 66C0:  e9 52
b01_a6c2:   dex                         ; 66C2:  ca
b01_a6c3:   .db vm_sp_lo                     ; 66C3:  02
b01_a6c4:   ldy $bb,x                   ; 66C4:  b4 bb
b01_a6c6:   .db $cf                     ; 66C6:  cf
driver_view:   jsr $e823                   ; 66C7:  20 23 e8
b01_a6ca:   inc $ff,x                   ; 66CA:  f6 ff
b01_a6cc:   ldy $5f                     ; 66CC:  a4 5f
b01_a6ce:   .db p2_buttons                     ; 66CE:  6f
b01_a6cf:   plp                         ; 66CF:  28
b01_a6d0:   rti                         ; 66D0:  40
b01_a6d1:   .db $27                     ; 66D1:  27
b01_a6d2:   adc ($e9,x)                 ; 66D2:  61 e9
b01_a6d4:   bpl $a6bb                   ; 66D4:  10 e5
b01_a6d6:   .db vm_sp_lo                     ; 66D6:  02
b01_a6d7:   and #$d8                    ; 66D7:  29 d8
b01_a6d9:   cmp $41a6,x                 ; 66D9:  dd a6 41
b01_a6dc:   .db $27                     ; 66DC:  27
b01_a6dd:   .db vm_ip_hi                     ; 66DD:  07
b01_a6de:   .db $d7                     ; 66DE:  d7
b01_a6df:   .db $13                     ; 66DF:  13
b01_a6e0:   .db $a7                     ; 66E0:  a7
b01_a6e1:   ldy $5f                     ; 66E1:  a4 5f
b01_a6e3:   .db p2_buttons                     ; 66E3:  6f
b01_a6e4:   .db $8b                     ; 66E4:  8b
b01_a6e5:   .db $1a                     ; 66E5:  1a
b01_a6e6:   lda $8c,x                   ; 66E6:  b5 8c
b01_a6e8:   ora ($70,x)                 ; 66E8:  01 70
b01_a6ea:   .db $bb                     ; 66EA:  bb
b01_a6eb:   bcs $a747                   ; 66EB:  b0 5a
b01_a6ed:   .db $c2                     ; 66ED:  c2
b01_a6ee:   cld                         ; 66EE:  d8
b01_a6ef:   .db $13                     ; 66EF:  13
b01_a6f0:   .db $a7                     ; 66F0:  a7
b01_a6f1:   stx $fdd9                   ; 66F1:  8e d9 fd
b01_a6f4:   sbc #$26                    ; 66F4:  e9 26
b01_a6f6:   .db $d3                     ; 66F6:  d3
b01_a6f7:   .db vm_sp_lo                     ; 66F7:  02
b01_a6f8:   ldy $d766                   ; 66F8:  ac 66 d7
b01_a6fb:   rti                         ; 66FB:  40
b01_a6fc:   .db $cf                     ; 66FC:  cf
b01_a6fd:   php                         ; 66FD:  08
b01_a6fe:   sty $fed8                   ; 66FE:  8c d8 fe
b01_a701:   dec $53,x                   ; 6701:  d6 53
b01_a703:   .db $a7                     ; 6703:  a7
b01_a704:   asl a                       ; 6704:  0a
b01_a705:   .db $8b                     ; 6705:  8b
b01_a706:   .db $63                     ; 6706:  63
b01_a707:   cpy #$d8                    ; 6707:  c0 d8
b01_a709:   jmp ($aca7)                 ; 6709:  6c a7 ac
b01_a70c:   nop                         ; 670C:  ea
b01_a70d:   sta $38                     ; 670D:  85 38
b01_a70f:   sbc #$fa                    ; 670F:  e9 fa
b01_a711:   .db clock_a_hi                     ; 6711:  83
b01_a712:   .db vm_sp_lo                     ; 6712:  02
b01_a713:   stx $fbef                   ; 6713:  8e ef fb
b01_a716:   sbc #$26                    ; 6716:  e9 26
b01_a718:   .db $d3                     ; 6718:  d3
b01_a719:   .db vm_sp_lo                     ; 6719:  02
b01_a71a:   adc ($e9,x)                 ; 671A:  61 e9
b01_a71c:   bpl $a703                   ; 671C:  10 e5
b01_a71e:   .db vm_sp_lo                     ; 671E:  02
b01_a71f:   and #$d8                    ; 671F:  29 d8
b01_a721:   bit $8ea7                   ; 6721:  2c a7 8e
b01_a724:   brk                         ; 6724:  00
b01_a725:   ldx $c4e9,y                 ; 6725:  be e9 c4
b01_a728:   dec $4102                   ; 6728:  ce 02 41
b01_a72b:   .db $27                     ; 672B:  27
b01_a72c:   eor ($a8,x)                 ; 672C:  41 a8
b01_a72e:   cpx #$7b                    ; 672E:  e0 7b
b01_a730:   sta $6163                   ; 6730:  8d 63 61
b01_a733:   sbc #$9d                    ; 6733:  e9 9d
b01_a735:   cmp vm_fp_lo,x                   ; 6735:  d5 04
b01_a737:   rol a                       ; 6737:  2a
b01_a738:   rti                         ; 6738:  40
b01_a739:   tay                         ; 6739:  a8
b01_a73a:   cpx #$7b                    ; 673A:  e0 7b
b01_a73c:   asl a                       ; 673C:  0a
b01_a73d:   .db $8b                     ; 673D:  8b
b01_a73e:   .db $ff                     ; 673E:  ff
b01_a73f:   cpy #$d8                    ; 673F:  c0 d8
b01_a741:   pla                         ; 6741:  68
b01_a742:   .db $a7                     ; 6742:  a7
b01_a743:   ldy $cd20                   ; 6743:  ac 20 cd
b01_a746:   ldy $9d                     ; 6746:  a4 9d
b01_a748:   adc $328b                   ; 6748:  6d 8b 32
b01_a74b:   cpy #$d8                    ; 674B:  c0 d8
b01_a74d:   sbc $08a6,x                 ; 674D:  fd a6 08
b01_a750:   sty $fea6                   ; 6750:  8c a6 fe
b01_a753:   .db $bb                     ; 6753:  bb
b01_a754:   .db $d3                     ; 6754:  d3
b01_a755:   .db $2b                     ; 6755:  2b
b01_a756:   .db $b3                     ; 6756:  b3
b01_a757:   sbc #$f2                    ; 6757:  e9 f2
b01_a759:   sbc vm_sp_lo                     ; 6759:  e5 02
b01_a75b:   .db $3b                     ; 675B:  3b
b01_a75c:   sbc #$10                    ; 675C:  e9 10
b01_a75e:   .db $af                     ; 675E:  af
b01_a75f:   .db vm_sp_lo                     ; 675F:  02
b01_a760:   sec                         ; 6760:  38
b01_a761:   sbc #$fa                    ; 6761:  e9 fa
b01_a763:   .db clock_a_hi                     ; 6763:  83
b01_a764:   .db vm_sp_lo                     ; 6764:  02
b01_a765:   dec $d0,x                   ; 6765:  d6 d0
b01_a767:   ldx $09                     ; 6767:  a6 09
b01_a769:   .db $d7                     ; 6769:  d7
b01_a76a:   .db vm_fp_lo                     ; 676A:  04
b01_a76b:   .db $a7                     ; 676B:  a7
b01_a76c:   asl a                       ; 676C:  0a
b01_a76d:   cld                         ; 676D:  d8
b01_a76e:   .db music_ptr_lo                     ; 676E:  7a
b01_a76f:   .db $a7                     ; 676F:  a7
b01_a770:   asl a                       ; 6770:  0a
b01_a771:   cmp ($2a),y                 ; 6771:  d1 2a
b01_a773:   ldx $5f                     ; 6773:  a6 5f
b01_a775:   .db p2_buttons                     ; 6775:  6f
b01_a776:   cpy #$d8                    ; 6776:  c0 d8
b01_a778:   .db $87                     ; 6778:  87
b01_a779:   .db $a7                     ; 6779:  a7
b01_a77a:   php                         ; 677A:  08
b01_a77b:   ldx $5f                     ; 677B:  a6 5f
b01_a77d:   .db p2_buttons                     ; 677D:  6f
b01_a77e:   cpy #$d8                    ; 677E:  c0 d8
b01_a780:   cpy #$a7                    ; 6780:  c0 a7
b01_a782:   ldy $cc89                   ; 6782:  ac 89 cc
b01_a785:   rti                         ; 6785:  40
b01_a786:   .db $cf                     ; 6786:  cf
b01_a787:   asl a                       ; 6787:  0a
b01_a788:   ldx $9d                     ; 6788:  a6 9d
b01_a78a:   adc $d8c6                   ; 678A:  6d c6 d8
b01_a78d:   .db $13                     ; 678D:  13
b01_a78e:   .db $a7                     ; 678E:  a7
b01_a78f:   .db $3a                     ; 678F:  3a
b01_a790:   sbc #$72                    ; 6790:  e9 72
b01_a792:   .db $d7                     ; 6792:  d7
b01_a793:   .db vm_sp_lo                     ; 6793:  02
b01_a794:   .db $b3                     ; 6794:  b3
b01_a795:   ldy $d77e                   ; 6795:  ac 7e d7
b01_a798:   ldy $c1,x                   ; 6798:  b4 c1
b01_a79a:   cld                         ; 679A:  d8
b01_a79b:   .db $33                     ; 679B:  33
b01_a79c:   tay                         ; 679C:  a8
b01_a79d:   ldy $5f                     ; 679D:  a4 5f
b01_a79f:   .db p2_buttons                     ; 679F:  6f
b01_a7a0:   .db $8b                     ; 67A0:  8b
b01_a7a1:   .db $1a                     ; 67A1:  1a
b01_a7a2:   lda $8c,x                   ; 67A2:  b5 8c
b01_a7a4:   ora ($70,x)                 ; 67A4:  01 70
b01_a7a6:   .db $bb                     ; 67A6:  bb
b01_a7a7:   bcs $a803                   ; 67A7:  b0 5a
b01_a7a9:   .db $c2                     ; 67A9:  c2
b01_a7aa:   cld                         ; 67AA:  d8
b01_a7ab:   dec $a7                     ; 67AB:  c6 a7
b01_a7ad:   ldy $cc89                   ; 67AD:  ac 89 cc
b01_a7b0:   stx $fdd9                   ; 67B0:  8e d9 fd
b01_a7b3:   sbc #$26                    ; 67B3:  e9 26
b01_a7b5:   .db $d3                     ; 67B5:  d3
b01_a7b6:   .db vm_sp_lo                     ; 67B6:  02
b01_a7b7:   ldy $d766                   ; 67B7:  ac 66 d7
b01_a7ba:   .db vm_ip_hi                     ; 67BA:  07
b01_a7bb:   eor ($c0),y                 ; 67BB:  51 c0
b01_a7bd:   .db $d7                     ; 67BD:  d7
b01_a7be:   .db $13                     ; 67BE:  13
b01_a7bf:   .db $a7                     ; 67BF:  a7
b01_a7c0:   ldy $85a7                   ; 67C0:  ac a7 85
b01_a7c3:   dec clock_b_hi,x                   ; 67C3:  d6 85
b01_a7c5:   .db $a7                     ; 67C5:  a7
b01_a7c6:   ror a                       ; 67C6:  6a
b01_a7c7:   ldy $5f                     ; 67C7:  a4 5f
b01_a7c9:   .db p2_buttons                     ; 67C9:  6f
b01_a7ca:   .db $8b                     ; 67CA:  8b
b01_a7cb:   .db $1a                     ; 67CB:  1a
b01_a7cc:   lda $8c,x                   ; 67CC:  b5 8c
b01_a7ce:   ora ($70,x)                 ; 67CE:  01 70
b01_a7d0:   .db $bb                     ; 67D0:  bb
b01_a7d1:   ldy $b3,x                   ; 67D1:  b4 b3
b01_a7d3:   bcs $a791                   ; 67D3:  b0 bc
b01_a7d5:   lda ($08),y                 ; 67D5:  b1 08
b01_a7d7:   ldx $5f                     ; 67D7:  a6 5f
b01_a7d9:   .db p2_buttons                     ; 67D9:  6f
b01_a7da:   cpy #$d8                    ; 67DA:  c0 d8
b01_a7dc:   sbc $a7,x                   ; 67DC:  f5 a7
b01_a7de:   .db brk_scratch_hi                     ; 67DE:  67
b01_a7df:   sta $e910                   ; 67DF:  8d 10 e9
b01_a7e2:   .db music_ptr_hi                     ; 67E2:  7b
b01_a7e3:   cpy $a404                   ; 67E3:  cc 04 a4
b01_a7e6:   .db $5f                     ; 67E6:  5f
b01_a7e7:   .db p2_buttons                     ; 67E7:  6f
b01_a7e8:   .db $8b                     ; 67E8:  8b
b01_a7e9:   .db $1a                     ; 67E9:  1a
b01_a7ea:   lda $8c,x                   ; 67EA:  b5 8c
b01_a7ec:   ora ($70,x)                 ; 67EC:  01 70
b01_a7ee:   .db $bb                     ; 67EE:  bb
b01_a7ef:   bcs $a7a4                   ; 67EF:  b0 b3
b01_a7f1:   sbc #$c7                    ; 67F1:  e9 c7
b01_a7f3:   .db clock_a_hi                     ; 67F3:  83
b01_a7f4:   .db vm_sp_lo                     ; 67F4:  02
b01_a7f5:   .db $3a                     ; 67F5:  3a
b01_a7f6:   sbc #$da                    ; 67F6:  e9 da
b01_a7f8:   .db $d7                     ; 67F8:  d7
b01_a7f9:   .db vm_sp_lo                     ; 67F9:  02
b01_a7fa:   .db $b3                     ; 67FA:  b3
b01_a7fb:   sbc #$b3                    ; 67FB:  e9 b3
b01_a7fd:   ldx vm_sp_lo                     ; 67FD:  a6 02
b01_a7ff:   .db $b3                     ; 67FF:  b3
b01_a800:   ldy $d7ea                   ; 6800:  ac ea d7
b01_a803:   .db $b3                     ; 6803:  b3
b01_a804:   sbc #$b3                    ; 6804:  e9 b3
b01_a806:   ldx vm_sp_lo                     ; 6806:  a6 02
b01_a808:   ldy $c4,x                   ; 6808:  b4 c4
b01_a80a:   cld                         ; 680A:  d8
b01_a80b:   .db $17                     ; 680B:  17
b01_a80c:   tay                         ; 680C:  a8
b01_a80d:   tax                         ; 680D:  aa
b01_a80e:   .db $63                     ; 680E:  63
b01_a80f:   adc $52e9                   ; 680F:  6d e9 52
b01_a812:   dex                         ; 6812:  ca
b01_a813:   .db vm_sp_lo                     ; 6813:  02
b01_a814:   cld                         ; 6814:  d8
b01_a815:   .db $2b                     ; 6815:  2b
b01_a816:   tay                         ; 6816:  a8
b01_a817:   .db $63                     ; 6817:  63
b01_a818:   sbc #$52                    ; 6818:  e9 52
b01_a81a:   dex                         ; 681A:  ca
b01_a81b:   .db vm_sp_lo                     ; 681B:  02
b01_a81c:   .db $d7                     ; 681C:  d7
b01_a81d:   .db $2b                     ; 681D:  2b
b01_a81e:   tay                         ; 681E:  a8
b01_a81f:   .db $3a                     ; 681F:  3a
b01_a820:   sbc #$8d                    ; 6820:  e9 8d
b01_a822:   cmp $8c02,y                 ; 6822:  d9 02 8c
b01_a825:   .db $ff                     ; 6825:  ff
b01_a826:   brk                         ; 6826:  00
b01_a827:   cpy #$d8                    ; 6827:  c0 d8
b01_a829:   .db $43                     ; 6829:  43
b01_a82a:   tay                         ; 682A:  a8
b01_a82b:   ldy $cc89                   ; 682B:  ac 89 cc
b01_a82e:   ror $0ce9                   ; 682E:  6e e9 0c
b01_a831:   inx                         ; 6831:  e8
b01_a832:   .db vm_sp_lo                     ; 6832:  02
b01_a833:   asl a                       ; 6833:  0a
b01_a834:   clc                         ; 6834:  18
b01_a835:   cmp ($d8,x)                 ; 6835:  c1 d8
b01_a837:   .db $13                     ; 6837:  13
b01_a838:   .db $a7                     ; 6838:  a7
b01_a839:   .db $3a                     ; 6839:  3a
b01_a83a:   sbc #$fa                    ; 683A:  e9 fa
b01_a83c:   .db clock_a_hi                     ; 683C:  83
b01_a83d:   .db vm_sp_lo                     ; 683D:  02
b01_a83e:   asl a                       ; 683E:  0a
b01_a83f:   plp                         ; 683F:  28
b01_a840:   dec $13,x                   ; 6840:  d6 13
b01_a842:   .db $a7                     ; 6842:  a7
b01_a843:   ldy $cc89                   ; 6843:  ac 89 cc
b01_a846:   stx $fc01                   ; 6846:  8e 01 fc
b01_a849:   sbc #$26                    ; 6849:  e9 26
b01_a84b:   .db $d3                     ; 684B:  d3
b01_a84c:   .db vm_sp_lo                     ; 684C:  02
b01_a84d:   ldy $d766                   ; 684D:  ac 66 d7
b01_a850:   dec $13,x                   ; 6850:  d6 13
b01_a852:   .db $a7                     ; 6852:  a7
driver_build:   jsr $e823                   ; 6853:  20 23 e8
b01_a856:   .db $fc                     ; 6856:  fc
b01_a857:   .db $ff                     ; 6857:  ff
b01_a858:   ldy $5f                     ; 6858:  a4 5f
b01_a85a:   .db p2_buttons                     ; 685A:  6f
b01_a85b:   .db $8b                     ; 685B:  8b
b01_a85c:   .db $1a                     ; 685C:  1a
b01_a85d:   lda $8c,x                   ; 685D:  b5 8c
b01_a85f:   ora ($70,x)                 ; 685F:  01 70
b01_a861:   .db $bb                     ; 6861:  bb
b01_a862:   .db $2b                     ; 6862:  2b
b01_a863:   .db $0b                     ; 6863:  0b
b01_a864:   .db palette_dirty                     ; 6864:  74
b01_a865:   bcs $a81a                   ; 6865:  b0 b3
b01_a867:   .db $0b                     ; 6867:  0b
b01_a868:   .db $8f                     ; 6868:  8f
b01_a869:   clc                         ; 6869:  18
b01_a86a:   bcs $a820                   ; 686A:  b0 b4
b01_a86c:   .db $c3                     ; 686C:  c3
b01_a86d:   cld                         ; 686D:  d8
b01_a86e:   .db $7c                     ; 686E:  7c
b01_a86f:   tay                         ; 686F:  a8
b01_a870:   stx $fdc6                   ; 6870:  8e c6 fd
b01_a873:   sbc #$26                    ; 6873:  e9 26
b01_a875:   .db $d3                     ; 6875:  d3
b01_a876:   .db vm_sp_lo                     ; 6876:  02
b01_a877:   ldy $d766                   ; 6877:  ac 66 d7
b01_a87a:   rti                         ; 687A:  40
b01_a87b:   .db $cf                     ; 687B:  cf
b01_a87c:   .db $0b                     ; 687C:  0b
b01_a87d:   bcs $a857                   ; 687D:  b0 d8
b01_a87f:   dec $a8                     ; 687F:  c6 a8
b01_a881:   stx $be13                   ; 6881:  8e 13 be
b01_a884:   sbc #$26                    ; 6884:  e9 26
b01_a886:   .db $d3                     ; 6886:  d3
b01_a887:   .db vm_sp_lo                     ; 6887:  02
b01_a888:   .db $0b                     ; 6888:  0b
b01_a889:   .db palette_dirty                     ; 6889:  74
b01_a88a:   bcs $a83f                   ; 688A:  b0 b3
b01_a88c:   stx $be14                   ; 688C:  8e 14 be
b01_a88f:   stx $fb25                   ; 688F:  8e 25 fb
b01_a892:   sbc #$34                    ; 6892:  e9 34
b01_a894:   cmp (vm_ip_lo),y                 ; 6894:  d1 06
b01_a896:   .db $0b                     ; 6896:  0b
b01_a897:   bcs $a84c                   ; 6897:  b0 b3
b01_a899:   adc ($e9,x)                 ; 6899:  61 e9
b01_a89b:   sbc #$d5                    ; 689B:  e9 d5
b01_a89d:   .db vm_fp_lo                     ; 689D:  04
b01_a89e:   rol a                       ; 689E:  2a
b01_a89f:   cld                         ; 689F:  d8
b01_a8a0:   .db $d2                     ; 68A0:  d2
b01_a8a1:   tay                         ; 68A1:  a8
b01_a8a2:   .db $3a                     ; 68A2:  3a
b01_a8a3:   .db $0b                     ; 68A3:  0b
b01_a8a4:   ldy $b3,x                   ; 68A4:  b4 b3
b01_a8a6:   bcs $a864                   ; 68A6:  b0 bc
b01_a8a8:   lda ($3a),y                 ; 68A8:  b1 3a
b01_a8aa:   .db $3b                     ; 68AA:  3b
b01_a8ab:   sbc #$a6                    ; 68AB:  e9 a6
b01_a8ad:   dey                         ; 68AD:  88
b01_a8ae:   .db vm_fp_lo                     ; 68AE:  04
b01_a8af:   rol a                       ; 68AF:  2a
b01_a8b0:   sta $e918                   ; 68B0:  8d 18 e9
b01_a8b3:   .db $0c                     ; 68B3:  0c
b01_a8b4:   inx                         ; 68B4:  e8
b01_a8b5:   .db vm_sp_lo                     ; 68B5:  02
b01_a8b6:   .db $0b                     ; 68B6:  0b
b01_a8b7:   .db palette_dirty                     ; 68B7:  74
b01_a8b8:   bcs $a86d                   ; 68B8:  b0 b3
b01_a8ba:   stx $fc14                   ; 68BA:  8e 14 fc
b01_a8bd:   sbc #$34                    ; 68BD:  e9 34
b01_a8bf:   cmp (vm_fp_lo),y                 ; 68BF:  d1 04
b01_a8c1:   ldy $d766                   ; 68C1:  ac 66 d7
b01_a8c4:   eor ($cf,x)                 ; 68C4:  41 cf
b01_a8c6:   stx $fdd9                   ; 68C6:  8e d9 fd
b01_a8c9:   sbc #$26                    ; 68C9:  e9 26
b01_a8cb:   .db $d3                     ; 68CB:  d3
b01_a8cc:   .db vm_sp_lo                     ; 68CC:  02
b01_a8cd:   ldy $d766                   ; 68CD:  ac 66 d7
b01_a8d0:   rti                         ; 68D0:  40
b01_a8d1:   .db $cf                     ; 68D1:  cf
b01_a8d2:   .db $cf                     ; 68D2:  cf
give_transfer_apply:   jsr $e823                   ; 68D3:  20 23 e8
b01_a8d6:   .db $fc                     ; 68D6:  fc
b01_a8d7:   .db $ff                     ; 68D7:  ff
b01_a8d8:   ora $c051                   ; 68D8:  0d 51 c0
b01_a8db:   cld                         ; 68DB:  d8
b01_a8dc:   .db $e2                     ; 68DC:  e2
b01_a8dd:   tay                         ; 68DD:  a8
b01_a8de:   .db $0c                     ; 68DE:  0c
b01_a8df:   dec $e4,x                   ; 68DF:  d6 e4
b01_a8e1:   tay                         ; 68E1:  a8
b01_a8e2:   .db $0c                     ; 68E2:  0c
b01_a8e3:   ror $2b,x                   ; 68E3:  76 2b
b01_a8e5:   stx $fda8                   ; 68E5:  8e a8 fd
b01_a8e8:   sbc #$26                    ; 68E8:  e9 26
b01_a8ea:   .db $d3                     ; 68EA:  d3
b01_a8eb:   .db vm_sp_lo                     ; 68EB:  02
b01_a8ec:   .db $0b                     ; 68EC:  0b
b01_a8ed:   bcs $a8a2                   ; 68ED:  b0 b3
b01_a8ef:   adc ($e9,x)                 ; 68EF:  61 e9
b01_a8f1:   sbc #$d5                    ; 68F1:  e9 d5
b01_a8f3:   .db vm_fp_lo                     ; 68F3:  04
b01_a8f4:   rol a                       ; 68F4:  2a
b01_a8f5:   cld                         ; 68F5:  d8
b01_a8f6:   .db ppu_queue_a_lo                     ; 68F6:  1c
b01_a8f7:   lda #$3a                    ; 68F7:  a9 3a
b01_a8f9:   .db $0b                     ; 68F9:  0b
b01_a8fa:   ldy $b3,x                   ; 68FA:  b4 b3
b01_a8fc:   bcs $a8ba                   ; 68FC:  b0 bc
b01_a8fe:   lda ($0e),y                 ; 68FE:  b1 0e
b01_a900:   eor ($c0),y                 ; 6900:  51 c0
b01_a902:   cld                         ; 6902:  d8
b01_a903:   .db $14                     ; 6903:  14
b01_a904:   lda #$3a                    ; 6904:  a9 3a
b01_a906:   .db $3c                     ; 6906:  3c
b01_a907:   sbc #$1d                    ; 6907:  e9 1d
b01_a909:   .db skip_wallclock                     ; 6909:  89
b01_a90a:   .db vm_fp_lo                     ; 690A:  04
b01_a90b:   .db $3a                     ; 690B:  3a
b01_a90c:   .db $3c                     ; 690C:  3c
b01_a90d:   sbc #$6f                    ; 690D:  e9 6f
b01_a90f:   .db skip_wallclock                     ; 690F:  89
b01_a910:   .db vm_fp_lo                     ; 6910:  04
b01_a911:   dec $1a,x                   ; 6911:  d6 1a
b01_a913:   lda #$3a                    ; 6913:  a9 3a
b01_a915:   .db $3c                     ; 6915:  3c
b01_a916:   sbc #$c1                    ; 6916:  e9 c1
b01_a918:   .db skip_wallclock                     ; 6918:  89
b01_a919:   .db vm_fp_lo                     ; 6919:  04
b01_a91a:   eor ($cf,x)                 ; 691A:  41 cf
b01_a91c:   rti                         ; 691C:  40
b01_a91d:   .db $cf                     ; 691D:  cf
give_eligibility_flags:   jsr $e823                   ; 691E:  20 23 e8
b01_a921:   inc $40ff,x                 ; 6921:  fe ff 40
b01_a924:   .db $2b                     ; 6924:  2b
b01_a925:   ora $c450                   ; 6925:  0d 50 c4
b01_a928:   cld                         ; 6928:  d8
b01_a929:   and $42a9                   ; 6929:  2d a9 42
b01_a92c:   .db $2b                     ; 692C:  2b
b01_a92d:   .db $0c                     ; 692D:  0c
b01_a92e:   bvc $a8f4                   ; 692E:  50 c4
b01_a930:   cld                         ; 6930:  d8
b01_a931:   sec                         ; 6931:  38
b01_a932:   lda #$41                    ; 6932:  a9 41
b01_a934:   cmp $db0b                   ; 6934:  cd 0b db
b01_a937:   .db $2b                     ; 6937:  2b
b01_a938:   .db $0b                     ; 6938:  0b
b01_a939:   .db $cf                     ; 6939:  cf
effect_give_a:   jsr $e823                   ; 693A:  20 23 e8
b01_a93d:   brk                         ; 693D:  00
b01_a93e:   brk                         ; 693E:  00
b01_a93f:   .db $0c                     ; 693F:  0c
b01_a940:   .db $8f                     ; 6940:  8f
b01_a941:   bpl $a8f3                   ; 6941:  10 b0
b01_a943:   .db $b3                     ; 6943:  b3
b01_a944:   .db $0c                     ; 6944:  0c
b01_a945:   sei                         ; 6945:  78
b01_a946:   bcs $a8fb                   ; 6946:  b0 b3
b01_a948:   sbc #$1e                    ; 6948:  e9 1e
b01_a94a:   lda #$04                    ; 694A:  a9 04
b01_a94c:   .db $cf                     ; 694C:  cf
give_rice_gold_eligibility:   jsr $e823                   ; 694D:  20 23 e8
b01_a950:   brk                         ; 6950:  00
b01_a951:   brk                         ; 6951:  00
b01_a952:   .db $0c                     ; 6952:  0c
b01_a953:   ror nmi_skip_all,x                   ; 6953:  76 b0
b01_a955:   .db $b3                     ; 6955:  b3
b01_a956:   .db $0c                     ; 6956:  0c
b01_a957:   bcs $a90c                   ; 6957:  b0 b3
b01_a959:   sbc #$1e                    ; 6959:  e9 1e
b01_a95b:   lda #$04                    ; 695B:  a9 04
b01_a95d:   .db $cf                     ; 695D:  cf
effect_give_b:   jsr $e823                   ; 695E:  20 23 e8
b01_a961:   .db $fc                     ; 6961:  fc
b01_a962:   .db $ff                     ; 6962:  ff
b01_a963:   .db $3c                     ; 6963:  3c
b01_a964:   sbc #$4d                    ; 6964:  e9 4d
b01_a966:   lda #$02                    ; 6966:  a9 02
b01_a968:   .db $2b                     ; 6968:  2b
b01_a969:   cld                         ; 6969:  d8
b01_a96a:   .db $bb                     ; 696A:  bb
b01_a96b:   lda #$0b                    ; 696B:  a9 0b
b01_a96d:   rol a                       ; 696D:  2a
b01_a96e:   stx $be1f                   ; 696E:  8e 1f be
b01_a971:   sbc #$26                    ; 6971:  e9 26
b01_a973:   .db $d3                     ; 6973:  d3
b01_a974:   .db vm_sp_lo                     ; 6974:  02
b01_a975:   stx $be20                   ; 6975:  8e 20 be
b01_a978:   sbc #$51                    ; 6978:  e9 51
b01_a97a:   .db $d3                     ; 697A:  d3
b01_a97b:   .db vm_sp_lo                     ; 697B:  02
b01_a97c:   .db $2b                     ; 697C:  2b
b01_a97d:   .db $0b                     ; 697D:  0b
b01_a97e:   .db $d7                     ; 697E:  d7
b01_a97f:   sta $a9                     ; 697F:  85 a9
b01_a981:   .db $42                     ; 6981:  42
b01_a982:   dec $8c,x                   ; 6982:  d6 8c
b01_a984:   lda #$0b                    ; 6984:  a9 0b
b01_a986:   .db $52                     ; 6986:  52
b01_a987:   cpy #$d8                    ; 6987:  c0 d8
b01_a989:   sta $40a9                   ; 6989:  8d a9 40
b01_a98c:   .db $2b                     ; 698C:  2b
b01_a98d:   .db $0b                     ; 698D:  0b
b01_a98e:   cld                         ; 698E:  d8
b01_a98f:   .db $af                     ; 698F:  af
b01_a990:   lda #$0a                    ; 6990:  a9 0a
b01_a992:   .db $1b                     ; 6992:  1b
b01_a993:   .db $da                     ; 6993:  da
b01_a994:   .db $d7                     ; 6994:  d7
b01_a995:   .db $af                     ; 6995:  af
b01_a996:   lda #$0a                    ; 6996:  a9 0a
b01_a998:   cmp ($2a),y                 ; 6998:  d1 2a
b01_a99a:   cld                         ; 699A:  d8
b01_a99b:   .db $a3                     ; 699B:  a3
b01_a99c:   lda #$8e                    ; 699C:  a9 8e
b01_a99e:   cmp $d6fd,y                 ; 699E:  d9 fd d6
b01_a9a1:   ldx $a9                     ; 69A1:  a6 a9
b01_a9a3:   stx $fdeb                   ; 69A3:  8e eb fd
b01_a9a6:   sbc #$26                    ; 69A6:  e9 26
b01_a9a8:   .db $d3                     ; 69A8:  d3
b01_a9a9:   .db vm_sp_lo                     ; 69A9:  02
b01_a9aa:   ldy $d766                   ; 69AA:  ac 66 d7
b01_a9ad:   rti                         ; 69AD:  40
b01_a9ae:   .db $cf                     ; 69AE:  cf
b01_a9af:   .db $0b                     ; 69AF:  0b
b01_a9b0:   cld                         ; 69B0:  d8
b01_a9b1:   .db $d3                     ; 69B1:  d3
b01_a9b2:   lda #$3d                    ; 69B2:  a9 3d
b01_a9b4:   .db $3b                     ; 69B4:  3b
b01_a9b5:   .db $3c                     ; 69B5:  3c
b01_a9b6:   sbc #$d3                    ; 69B6:  e9 d3
b01_a9b8:   tay                         ; 69B8:  a8
b01_a9b9:   asl $cf                     ; 69B9:  06 cf
b01_a9bb:   stx $fdd9                   ; 69BB:  8e d9 fd
b01_a9be:   sbc #$26                    ; 69BE:  e9 26
b01_a9c0:   .db $d3                     ; 69C0:  d3
b01_a9c1:   .db vm_sp_lo                     ; 69C1:  02
b01_a9c2:   stx $be2e                   ; 69C2:  8e 2e be
b01_a9c5:   sbc #$c4                    ; 69C5:  e9 c4
b01_a9c7:   dec $8e02                   ; 69C7:  ce 02 8e
b01_a9ca:   .db $eb                     ; 69CA:  eb
b01_a9cb:   sbc $c4e9,x                 ; 69CB:  fd e9 c4
b01_a9ce:   dec $ac02                   ; 69CE:  ce 02 ac
b01_a9d1:   ror $d7                     ; 69D1:  66 d7
b01_a9d3:   rti                         ; 69D3:  40
b01_a9d4:   .db $cf                     ; 69D4:  cf
effect_give_c:   jsr $e823                   ; 69D5:  20 23 e8
b01_a9d8:   inc $3cff,x                 ; 69D8:  fe ff 3c
b01_a9db:   sbc #$3a                    ; 69DB:  e9 3a
b01_a9dd:   lda #$02                    ; 69DD:  a9 02
b01_a9df:   .db $2b                     ; 69DF:  2b
b01_a9e0:   cld                         ; 69E0:  d8
b01_a9e1:   ora $aa                     ; 69E1:  05 aa
b01_a9e3:   stx $be30                   ; 69E3:  8e 30 be
b01_a9e6:   sbc #$26                    ; 69E6:  e9 26
b01_a9e8:   .db $d3                     ; 69E8:  d3
b01_a9e9:   .db vm_sp_lo                     ; 69E9:  02
b01_a9ea:   stx $be31                   ; 69EA:  8e 31 be
b01_a9ed:   sbc #$51                    ; 69ED:  e9 51
b01_a9ef:   .db $d3                     ; 69EF:  d3
b01_a9f0:   .db vm_sp_lo                     ; 69F0:  02
b01_a9f1:   .db $2b                     ; 69F1:  2b
b01_a9f2:   .db $0b                     ; 69F2:  0b
b01_a9f3:   .db $d7                     ; 69F3:  d7
b01_a9f4:   .db $fb                     ; 69F4:  fb
b01_a9f5:   lda #$42                    ; 69F5:  a9 42
b01_a9f7:   .db $2b                     ; 69F7:  2b
b01_a9f8:   dec ppu_queue_a_hi,x                   ; 69F8:  d6 1d
b01_a9fa:   tax                         ; 69FA:  aa
b01_a9fb:   .db $0b                     ; 69FB:  0b
b01_a9fc:   .db $52                     ; 69FC:  52
b01_a9fd:   cpy #$d8                    ; 69FD:  c0 d8
b01_a9ff:   ora $40aa,x                 ; 69FF:  1d aa 40
b01_aa02:   dec $f7,x                   ; 6A02:  d6 f7
b01_aa04:   lda #$8e                    ; 6A04:  a9 8e
b01_aa06:   sbc $e9fd,x                 ; 6A06:  fd fd e9
b01_aa09:   rol $d3                     ; 6A09:  26 d3
b01_aa0b:   .db vm_sp_lo                     ; 6A0B:  02
b01_aa0c:   stx $be41                   ; 6A0C:  8e 41 be
b01_aa0f:   sbc #$c4                    ; 6A0F:  e9 c4
b01_aa11:   dec $8e02                   ; 6A11:  ce 02 8e
b01_aa14:   .db $13                     ; 6A14:  13
b01_aa15:   inc $c4e9,x                 ; 6A15:  fe e9 c4
b01_aa18:   dec $ac02                   ; 6A18:  ce 02 ac
b01_aa1b:   ror $d7                     ; 6A1B:  66 d7
b01_aa1d:   .db $0b                     ; 6A1D:  0b
b01_aa1e:   .db $cf                     ; 6A1E:  cf
driver_give:   jsr $e823                   ; 6A1F:  20 23 e8
b01_aa22:   .db $fa                     ; 6A22:  fa
b01_aa23:   .db $ff                     ; 6A23:  ff
b01_aa24:   ldy $5f                     ; 6A24:  a4 5f
b01_aa26:   .db p2_buttons                     ; 6A26:  6f
b01_aa27:   .db $8b                     ; 6A27:  8b
b01_aa28:   .db $1a                     ; 6A28:  1a
b01_aa29:   lda $8c,x                   ; 6A29:  b5 8c
b01_aa2b:   ora ($70,x)                 ; 6A2B:  01 70
b01_aa2d:   .db $bb                     ; 6A2D:  bb
b01_aa2e:   and #$39                    ; 6A2E:  29 39
b01_aa30:   sbc #$3a                    ; 6A30:  e9 3a
b01_aa32:   lda #$02                    ; 6A32:  a9 02
b01_aa34:   rol a                       ; 6A34:  2a
b01_aa35:   and $d5e9,y                 ; 6A35:  39 e9 d5
b01_aa38:   lda #$02                    ; 6A38:  a9 02
b01_aa3a:   .db $2b                     ; 6A3A:  2b
b01_aa3b:   cld                         ; 6A3B:  d8
b01_aa3c:   ldy $0aaa                   ; 6A3C:  ac aa 0a
b01_aa3f:   .db $1b                     ; 6A3F:  1b
b01_aa40:   .db $da                     ; 6A40:  da
b01_aa41:   .db $d7                     ; 6A41:  d7
b01_aa42:   .db $5c                     ; 6A42:  5c
b01_aa43:   tax                         ; 6A43:  aa
b01_aa44:   asl a                       ; 6A44:  0a
b01_aa45:   cmp ($2a),y                 ; 6A45:  d1 2a
b01_aa47:   cld                         ; 6A47:  d8
b01_aa48:   bvc $a9f4                   ; 6A48:  50 aa
b01_aa4a:   stx $fe13                   ; 6A4A:  8e 13 fe
b01_aa4d:   dec $53,x                   ; 6A4D:  d6 53
b01_aa4f:   tax                         ; 6A4F:  aa
b01_aa50:   stx $fdfd                   ; 6A50:  8e fd fd
b01_aa53:   sbc #$26                    ; 6A53:  e9 26
b01_aa55:   .db $d3                     ; 6A55:  d3
b01_aa56:   .db vm_sp_lo                     ; 6A56:  02
b01_aa57:   ldy $d766                   ; 6A57:  ac 66 d7
b01_aa5a:   rti                         ; 6A5A:  40
b01_aa5b:   .db $cf                     ; 6A5B:  cf
b01_aa5c:   ora #$8f                    ; 6A5C:  09 8f
b01_aa5e:   clc                         ; 6A5E:  18
b01_aa5f:   bcs $aa14                   ; 6A5F:  b0 b3
b01_aa61:   .db $0b                     ; 6A61:  0b
b01_aa62:   eor ($c0),y                 ; 6A62:  51 c0
b01_aa64:   cld                         ; 6A64:  d8
b01_aa65:   adc $aa,x                   ; 6A65:  75 aa
b01_aa67:   ora #$7e                    ; 6A67:  09 7e
b01_aa69:   bcs $aa1e                   ; 6A69:  b0 b3
b01_aa6b:   ora #$7c                    ; 6A6B:  09 7c
b01_aa6d:   bcs $aa23                   ; 6A6D:  b0 b4
b01_aa6f:   .db $bb                     ; 6A6F:  bb
b01_aa70:   .db $52                     ; 6A70:  52
b01_aa71:   ldx $d6,y                   ; 6A71:  b6 d6
b01_aa73:   adc $09aa,y                 ; 6A73:  79 aa 09
b01_aa76:   .db $8f                     ; 6A76:  8f
b01_aa77:   .db $12                     ; 6A77:  12
b01_aa78:   bcs $aa2e                   ; 6A78:  b0 b4
b01_aa7a:   cmp $d8                     ; 6A7A:  c5 d8
b01_aa7c:   txa                         ; 6A7C:  8a
b01_aa7d:   tax                         ; 6A7D:  aa
b01_aa7e:   stx $fdc6                   ; 6A7E:  8e c6 fd
b01_aa81:   sbc #$26                    ; 6A81:  e9 26
b01_aa83:   .db $d3                     ; 6A83:  d3
b01_aa84:   .db vm_sp_lo                     ; 6A84:  02
b01_aa85:   ldy $d766                   ; 6A85:  ac 66 d7
b01_aa88:   rti                         ; 6A88:  40
b01_aa89:   .db $cf                     ; 6A89:  cf
b01_aa8a:   .db $3b                     ; 6A8A:  3b
b01_aa8b:   and $5ee9,y                 ; 6A8B:  39 e9 5e
b01_aa8e:   lda #$04                    ; 6A8E:  a9 04
b01_aa90:   cld                         ; 6A90:  d8
b01_aa91:   ldy $66aa                   ; 6A91:  ac aa 66
b01_aa94:   sbc #$0c                    ; 6A94:  e9 0c
b01_aa96:   inx                         ; 6A96:  e8
b01_aa97:   .db vm_sp_lo                     ; 6A97:  02
b01_aa98:   ldy $d7ea                   ; 6A98:  ac ea d7
b01_aa9b:   .db palette_dirty                     ; 6A9B:  74
b01_aa9c:   .db $b3                     ; 6A9C:  b3
b01_aa9d:   .db $d3                     ; 6A9D:  d3
b01_aa9e:   bne $aa74                   ; 6A9E:  d0 d4
b01_aaa0:   stx $fdb6                   ; 6AA0:  8e b6 fd
b01_aaa3:   sbc #$26                    ; 6AA3:  e9 26
b01_aaa5:   .db $d3                     ; 6AA5:  d3
b01_aaa6:   .db vm_sp_lo                     ; 6AA6:  02
b01_aaa7:   ldy $d766                   ; 6AA7:  ac 66 d7
b01_aaaa:   eor ($cf,x)                 ; 6AAA:  41 cf
b01_aaac:   rti                         ; 6AAC:  40
b01_aaad:   .db $cf                     ; 6AAD:  cf
driver_bribe:   jsr $e823                   ; 6AAE:  20 23 e8
b01_aab1:   .db $fc                     ; 6AB1:  fc
b01_aab2:   .db $ff                     ; 6AB2:  ff
b01_aab3:   ldy $5f                     ; 6AB3:  a4 5f
b01_aab5:   .db p2_buttons                     ; 6AB5:  6f
b01_aab6:   .db $8b                     ; 6AB6:  8b
b01_aab7:   .db $1a                     ; 6AB7:  1a
b01_aab8:   lda $8c,x                   ; 6AB8:  b5 8c
b01_aaba:   ora ($70,x)                 ; 6ABA:  01 70
b01_aabc:   .db $bb                     ; 6ABC:  bb
b01_aabd:   .db $2b                     ; 6ABD:  2b
b01_aabe:   .db $0b                     ; 6ABE:  0b
b01_aabf:   bcs $ab1b                   ; 6ABF:  b0 5a
b01_aac1:   cpy $d8                     ; 6AC1:  c4 d8
b01_aac3:   asl $ab,x                   ; 6AC3:  16 ab
b01_aac5:   rts                         ; 6AC5:  60
b01_aac6:   sbc #$10                    ; 6AC6:  e9 10
b01_aac8:   sbc vm_sp_lo                     ; 6AC8:  e5 02
b01_aaca:   stx fief_index_list                   ; 6ACA:  8e 89 6f
b01_aacd:   .db p2_buttons                     ; 6ACD:  6f
b01_aace:   sbc #$9f                    ; 6ACE:  e9 9f
b01_aad0:   .db $87                     ; 6AD0:  87
b01_aad1:   .db vm_fp_lo                     ; 6AD1:  04
b01_aad2:   cld                         ; 6AD2:  d8
b01_aad3:   jsr $8eab                   ; 6AD3:  20 ab 8e
b01_aad6:   .db $97                     ; 6AD6:  97
b01_aad7:   inc $c4e9,x                 ; 6AD7:  fe e9 c4
b01_aada:   dec $8e02                   ; 6ADA:  ce 02 8e
b01_aadd:   .db skip_wallclock                     ; 6ADD:  89
b01_aade:   .db p2_buttons                     ; 6ADE:  6f
b01_aadf:   sbc #$4c                    ; 6ADF:  e9 4c
b01_aae1:   .db skip_vblank_wait                     ; 6AE1:  80
b01_aae2:   .db vm_sp_lo                     ; 6AE2:  02
b01_aae3:   tay                         ; 6AE3:  a8
b01_aae4:   .db $63                     ; 6AE4:  63
b01_aae5:   .db p2_buttons                     ; 6AE5:  6f
b01_aae6:   cld                         ; 6AE6:  d8
b01_aae7:   jsr $acab                   ; 6AE7:  20 ab ac
b01_aaea:   .db skip_wallclock                     ; 6AEA:  89
b01_aaeb:   cpy $63a4                   ; 6AEB:  cc a4 63
b01_aaee:   .db p2_buttons                     ; 6AEE:  6f
b01_aaef:   cmp ($a8),y                 ; 6AEF:  d1 a8
b01_aaf1:   .db $63                     ; 6AF1:  63
b01_aaf2:   .db p2_buttons                     ; 6AF2:  6f
b01_aaf3:   stx $fc29                   ; 6AF3:  8e 29 fc
b01_aaf6:   sbc #$26                    ; 6AF6:  e9 26
b01_aaf8:   .db $d3                     ; 6AF8:  d3
b01_aaf9:   .db vm_sp_lo                     ; 6AF9:  02
b01_aafa:   .db $0b                     ; 6AFA:  0b
b01_aafb:   bcs $aa8c                   ; 6AFB:  b0 8f
b01_aafd:   inc $b3,x                   ; 6AFD:  f6 b3
b01_aaff:   adc ($e9,x)                 ; 6AFF:  61 e9
b01_ab01:   sbc #$d5                    ; 6B01:  e9 d5
b01_ab03:   .db vm_fp_lo                     ; 6B03:  04
b01_ab04:   rol a                       ; 6B04:  2a
b01_ab05:   cld                         ; 6B05:  d8
b01_ab06:   jsr $6aab                   ; 6B06:  20 ab 6a
b01_ab09:   .db $0b                     ; 6B09:  0b
b01_ab0a:   ldy $b3,x                   ; 6B0A:  b4 b3
b01_ab0c:   bcs $aaca                   ; 6B0C:  b0 bc
b01_ab0e:   lda ($3a),y                 ; 6B0E:  b1 3a
b01_ab10:   sbc #$4d                    ; 6B10:  e9 4d
b01_ab12:   sta $4102                   ; 6B12:  8d 02 41
b01_ab15:   .db $cf                     ; 6B15:  cf
b01_ab16:   stx $fdd9                   ; 6B16:  8e d9 fd
b01_ab19:   sbc #$26                    ; 6B19:  e9 26
b01_ab1b:   .db $d3                     ; 6B1B:  d3
b01_ab1c:   .db vm_sp_lo                     ; 6B1C:  02
b01_ab1d:   ldy $d766                   ; 6B1D:  ac 66 d7
b01_ab20:   rti                         ; 6B20:  40
b01_ab21:   .db $cf                     ; 6B21:  cf
render_arms_edit_screen:   jsr $e823                   ; 6B22:  20 23 e8
b01_ab25:   .db $fc                     ; 6B25:  fc
b01_ab26:   .db $ff                     ; 6B26:  ff
b01_ab27:   rti                         ; 6B27:  40
b01_ab28:   .db $2b                     ; 6B28:  2b
b01_ab29:   .db $0b                     ; 6B29:  0b
b01_ab2a:   .db $d2                     ; 6B2A:  d2
b01_ab2b:   ora $b3bb,x                 ; 6B2B:  1d bb b3
b01_ab2e:   ldy $5f                     ; 6B2E:  a4 5f
b01_ab30:   .db p2_buttons                     ; 6B30:  6f
b01_ab31:   eor $b5,x                   ; 6B31:  55 b5
b01_ab33:   .db $1b                     ; 6B33:  1b
b01_ab34:   .db $bb                     ; 6B34:  bb
b01_ab35:   sty province_unit_type_pct                   ; 6B35:  8c a9 76
b01_ab38:   .db $bb                     ; 6B38:  bb
b01_ab39:   .db $d3                     ; 6B39:  d3
b01_ab3a:   lda ($0b),y                 ; 6B3A:  b1 0b
b01_ab3c:   .db $8f                     ; 6B3C:  8f
b01_ab3d:   .db $14                     ; 6B3D:  14
b01_ab3e:   .db $b3                     ; 6B3E:  b3
b01_ab3f:   ror $7be9                   ; 6B3F:  6e e9 7b
b01_ab42:   cpy $0b04                   ; 6B42:  cc 04 0b
b01_ab45:   .db $d2                     ; 6B45:  d2
b01_ab46:   ora $b0bb,x                 ; 6B46:  1d bb b0
b01_ab49:   sty $270f                   ; 6B49:  8c 0f 27
b01_ab4c:   cpy $d8                     ; 6B4C:  c4 d8
b01_ab4e:   eor $0bab,y                 ; 6B4E:  59 ab 0b
b01_ab51:   .db $d2                     ; 6B51:  d2
b01_ab52:   ora $b3bb,x                 ; 6B52:  1d bb b3
b01_ab55:   txa                         ; 6B55:  8a
b01_ab56:   .db $0f                     ; 6B56:  0f
b01_ab57:   .db $27                     ; 6B57:  27
b01_ab58:   lda ($0b),y                 ; 6B58:  b1 0b
b01_ab5a:   .db $d2                     ; 6B5A:  d2
b01_ab5b:   ora $b0bb,x                 ; 6B5B:  1d bb b0
b01_ab5e:   .db $b3                     ; 6B5E:  b3
b01_ab5f:   stx $be43                   ; 6B5F:  8e 43 be
b01_ab62:   sbc #$34                    ; 6B62:  e9 34
b01_ab64:   cmp (vm_fp_lo),y                 ; 6B64:  d1 04
b01_ab66:   .db $0b                     ; 6B66:  0b
b01_ab67:   .db $8f                     ; 6B67:  8f
b01_ab68:   .db $14                     ; 6B68:  14
b01_ab69:   .db $b3                     ; 6B69:  b3
b01_ab6a:   adc $e9                     ; 6B6A:  65 e9
b01_ab6c:   .db music_ptr_hi                     ; 6B6C:  7b
b01_ab6d:   cpy $0b04                   ; 6B6D:  cc 04 0b
b01_ab70:   cmp vm_sp_lo,y                 ; 6B70:  d9 02 00
b01_ab73:   ora (scratch_ptr_lo,x)                 ; 6B73:  01 00
b01_ab75:   adc $02ab,x                 ; 6B75:  7d ab 02
b01_ab78:   brk                         ; 6B78:  00
b01_ab79:   lda $ab,x                   ; 6B79:  b5 ab
b01_ab7b:   lda $42ab,y                 ; 6B7B:  b9 ab 42
b01_ab7e:   rol a                       ; 6B7E:  2a
b01_ab7f:   asl a                       ; 6B7F:  0a
b01_ab80:   .db $d2                     ; 6B80:  d2
b01_ab81:   sty $f9af                   ; 6B81:  8c af f9
b01_ab84:   .db $bb                     ; 6B84:  bb
b01_ab85:   bcs $ab3a                   ; 6B85:  b0 b3
b01_ab87:   .db $0b                     ; 6B87:  0b
b01_ab88:   bne $ab3d                   ; 6B88:  d0 b3
b01_ab8a:   stx $be47                   ; 6B8A:  8e 47 be
b01_ab8d:   sbc #$34                    ; 6B8D:  e9 34
b01_ab8f:   cmp (vm_ip_lo),y                 ; 6B8F:  d1 06
b01_ab91:   sta $6519                   ; 6B91:  8d 19 65
b01_ab94:   sbc #$7b                    ; 6B94:  e9 7b
b01_ab96:   cpy $8e04                   ; 6B96:  cc 04 8e
b01_ab99:   jmp $e9be                   ; 6B99:  4c be e9
b01_ab9c:   cpy $ce                     ; 6B9C:  c4 ce
b01_ab9e:   .db vm_sp_lo                     ; 6B9E:  02
b01_ab9f:   sta $6414                   ; 6B9F:  8d 14 64
b01_aba2:   sbc #$7b                    ; 6BA2:  e9 7b
b01_aba4:   cpy $6204                   ; 6BA4:  cc 04 62
b01_aba7:   sbc #$9d                    ; 6BA7:  e9 9d
b01_aba9:   .db $d2                     ; 6BA9:  d2
b01_abaa:   .db vm_sp_lo                     ; 6BAA:  02
b01_abab:   .db $0b                     ; 6BAB:  0b
b01_abac:   bne $abd9                   ; 6BAC:  d0 2b
b01_abae:   .db $0b                     ; 6BAE:  0b
b01_abaf:   eor $c6,x                   ; 6BAF:  55 c6
b01_abb1:   .db $d7                     ; 6BB1:  d7
b01_abb2:   and #$ab                    ; 6BB2:  29 ab
b01_abb4:   .db $cf                     ; 6BB4:  cf
b01_abb5:   rti                         ; 6BB5:  40
b01_abb6:   dec $7e,x                   ; 6BB6:  d6 7e
b01_abb8:   .db $ab                     ; 6BB8:  ab
b01_abb9:   eor ($d6,x)                 ; 6BB9:  41 d6
b01_abbb:   ror $20ab,x                 ; 6BBB:  7e ab 20
b01_abbe:   .db $23                     ; 6BBE:  23
b01_abbf:   inx                         ; 6BBF:  e8
b01_abc0:   .db $fa                     ; 6BC0:  fa
b01_abc1:   .db $ff                     ; 6BC1:  ff
b01_abc2:   rti                         ; 6BC2:  40
b01_abc3:   and #$a4                    ; 6BC3:  29 a4
b01_abc5:   .db $5f                     ; 6BC5:  5f
b01_abc6:   .db p2_buttons                     ; 6BC6:  6f
b01_abc7:   eor $b5,x                   ; 6BC7:  55 b5
b01_abc9:   sty province_unit_type_pct                   ; 6BC9:  8c a9 76
b01_abcc:   .db $bb                     ; 6BCC:  bb
b01_abcd:   rol a                       ; 6BCD:  2a
b01_abce:   rti                         ; 6BCE:  40
b01_abcf:   .db $2b                     ; 6BCF:  2b
b01_abd0:   .db $0b                     ; 6BD0:  0b
b01_abd1:   .db $d2                     ; 6BD1:  d2
b01_abd2:   .db ppu_queue_a_lo                     ; 6BD2:  1c
b01_abd3:   .db $bb                     ; 6BD3:  bb
b01_abd4:   bcs $ab89                   ; 6BD4:  b0 b3
b01_abd6:   asl a                       ; 6BD6:  0a
b01_abd7:   .db $1b                     ; 6BD7:  1b
b01_abd8:   .db $bb                     ; 6BD8:  bb
b01_abd9:   .db $d3                     ; 6BD9:  d3
b01_abda:   ldy $c1,x                   ; 6BDA:  b4 c1
b01_abdc:   cld                         ; 6BDC:  d8
b01_abdd:   sbc ($ab,x)                 ; 6BDD:  e1 ab
b01_abdf:   eor ($29,x)                 ; 6BDF:  41 29
b01_abe1:   .db $0b                     ; 6BE1:  0b
b01_abe2:   bne $ac0f                   ; 6BE2:  d0 2b
b01_abe4:   .db $0b                     ; 6BE4:  0b
b01_abe5:   eor $c6,x                   ; 6BE5:  55 c6
b01_abe7:   .db $d7                     ; 6BE7:  d7
b01_abe8:   bne $ab95                   ; 6BE8:  d0 ab
b01_abea:   ora $f2d7                   ; 6BEA:  0d d7 f2
b01_abed:   .db $ab                     ; 6BED:  ab
b01_abee:   ora #$d7                    ; 6BEE:  09 d7
b01_abf0:   .db $f4                     ; 6BF0:  f4
b01_abf1:   .db $ab                     ; 6BF1:  ab
b01_abf2:   rti                         ; 6BF2:  40
b01_abf3:   .db $cf                     ; 6BF3:  cf
b01_abf4:   rti                         ; 6BF4:  40
b01_abf5:   .db $2b                     ; 6BF5:  2b
b01_abf6:   asl a                       ; 6BF6:  0a
b01_abf7:   .db $1b                     ; 6BF7:  1b
b01_abf8:   .db $bb                     ; 6BF8:  bb
b01_abf9:   .db $b3                     ; 6BF9:  b3
b01_abfa:   .db $0b                     ; 6BFA:  0b
b01_abfb:   .db $d2                     ; 6BFB:  d2
b01_abfc:   .db ppu_queue_a_lo                     ; 6BFC:  1c
b01_abfd:   .db $bb                     ; 6BFD:  bb
b01_abfe:   bcs $abd4                   ; 6BFE:  b0 d4
b01_ac00:   .db $0b                     ; 6C00:  0b
b01_ac01:   bne $ac2e                   ; 6C01:  d0 2b
b01_ac03:   .db $0b                     ; 6C03:  0b
b01_ac04:   eor $c6,x                   ; 6C04:  55 c6
b01_ac06:   .db $d7                     ; 6C06:  d7
b01_ac07:   inc $ab,x                   ; 6C07:  f6 ab
b01_ac09:   sta $e916                   ; 6C09:  8d 16 e9
b01_ac0c:   .db $0c                     ; 6C0C:  0c
b01_ac0d:   inx                         ; 6C0D:  e8
b01_ac0e:   .db vm_sp_lo                     ; 6C0E:  02
b01_ac0f:   eor ($cf,x)                 ; 6C0F:  41 cf
effect_assign:   jsr $e823                   ; 6C11:  20 23 e8
b01_ac14:   inc $a4ff                   ; 6C14:  ee ff a4
b01_ac17:   .db $5f                     ; 6C17:  5f
b01_ac18:   .db p2_buttons                     ; 6C18:  6f
b01_ac19:   .db $8b                     ; 6C19:  8b
b01_ac1a:   .db $1a                     ; 6C1A:  1a
b01_ac1b:   lda $8c,x                   ; 6C1B:  b5 8c
b01_ac1d:   .db $17                     ; 6C1D:  17
b01_ac1e:   bvs $abdb                   ; 6C1E:  70 bb
b01_ac20:   .db $23                     ; 6C20:  23
b01_ac21:   dec $fff0,x                 ; 6C21:  de f0 ff
b01_ac24:   .db $b3                     ; 6C24:  b3
b01_ac25:   .db $3c                     ; 6C25:  3c
b01_ac26:   sbc #$22                    ; 6C26:  e9 22
b01_ac28:   .db $ab                     ; 6C28:  ab
b01_ac29:   .db vm_fp_lo                     ; 6C29:  04
b01_ac2a:   ldy $d287                   ; 6C2A:  ac 87 d2
b01_ac2d:   .db skip_wallclock                     ; 6C2D:  89
b01_ac2e:   .db $14                     ; 6C2E:  14
b01_ac2f:   and #$40                    ; 6C2F:  29 40
b01_ac31:   rol a                       ; 6C31:  2a
b01_ac32:   .db $2b                     ; 6C32:  2b
b01_ac33:   ldy $d14e                   ; 6C33:  ac 4e d1
b01_ac36:   cmp vm_ip_lo,y                 ; 6C36:  d9 06 00
b01_ac39:   ora (scratch_ptr_lo,x)                 ; 6C39:  01 00
b01_ac3b:   .db $4b                     ; 6C3B:  4b
b01_ac3c:   lda vm_sp_lo                   ; 6C3C:  ad 02 00
b01_ac3f:   eor $10ad,x                 ; 6C3F:  5d ad 10
b01_ac42:   brk                         ; 6C42:  00
b01_ac43:   .db $92                     ; 6C43:  92
b01_ac44:   ldy $0020                   ; 6C44:  ac 20 00
b01_ac47:   .db $fa                     ; 6C47:  fa
b01_ac48:   ldy $0040                   ; 6C48:  ac 40 00
b01_ac4b:   .db $53                     ; 6C4B:  53
b01_ac4c:   ldy skip_vblank_wait                   ; 6C4C:  ac 80 00
b01_ac4f:   .db music_ptr_hi                     ; 6C4F:  7b
b01_ac50:   ldy $ac33                   ; 6C50:  ac 33 ac
b01_ac53:   rts                         ; 6C53:  60
b01_ac54:   sbc #$9d                    ; 6C54:  e9 9d
b01_ac56:   .db $d2                     ; 6C56:  d2
b01_ac57:   .db vm_sp_lo                     ; 6C57:  02
b01_ac58:   ora #$d1                    ; 6C58:  09 d1
b01_ac5a:   and #$0a                    ; 6C5A:  29 0a
b01_ac5c:   cmp ($2a),y                 ; 6C5C:  d1 2a
b01_ac5e:   bvc $ac22                   ; 6C5E:  50 c2
b01_ac60:   cld                         ; 6C60:  d8
b01_ac61:   pla                         ; 6C61:  68
b01_ac62:   ldy $2a44                   ; 6C62:  ac 44 2a
b01_ac65:   .db skip_wallclock                     ; 6C65:  89
b01_ac66:   clc                         ; 6C66:  18
b01_ac67:   and #$39                    ; 6C67:  29 39
b01_ac69:   .db $64                     ; 6C69:  64
b01_ac6a:   sbc #$7b                    ; 6C6A:  e9 7b
b01_ac6c:   cpy $6204                   ; 6C6C:  cc 04 62
b01_ac6f:   sbc #$9d                    ; 6C6F:  e9 9d
b01_ac71:   .db $d2                     ; 6C71:  d2
b01_ac72:   .db vm_sp_lo                     ; 6C72:  02
b01_ac73:   .db $62                     ; 6C73:  62
b01_ac74:   sbc #$3e                    ; 6C74:  e9 3e
b01_ac76:   .db $d7                     ; 6C76:  d7
b01_ac77:   .db vm_sp_lo                     ; 6C77:  02
b01_ac78:   dec $33,x                   ; 6C78:  d6 33
b01_ac7a:   ldy $e960                   ; 6C7A:  ac 60 e9
b01_ac7d:   sta $02d2,x                 ; 6C7D:  9d d2 02
b01_ac80:   ora #$d0                    ; 6C80:  09 d0
b01_ac82:   and #$0a                    ; 6C82:  29 0a
b01_ac84:   bne $acb0                   ; 6C84:  d0 2a
b01_ac86:   eor $c5,x                   ; 6C86:  55 c5
b01_ac88:   cld                         ; 6C88:  d8
b01_ac89:   pla                         ; 6C89:  68
b01_ac8a:   ldy $2a40                   ; 6C8A:  ac 40 2a
b01_ac8d:   .db skip_wallclock                     ; 6C8D:  89
b01_ac8e:   .db $14                     ; 6C8E:  14
b01_ac8f:   dec brk_scratch_hi,x                   ; 6C8F:  d6 67
b01_ac91:   ldy $d80b                   ; 6C91:  ac 0b d8
b01_ac94:   .db $33                     ; 6C94:  33
b01_ac95:   ldy $520a                   ; 6C95:  ac 0a 52
b01_ac98:   cpy #$d8                    ; 6C98:  c0 d8
b01_ac9a:   .db $b2                     ; 6C9A:  b2
b01_ac9b:   ldy $b003                   ; 6C9B:  ac 03 b0
b01_ac9e:   .db $8b                     ; 6C9E:  8b
b01_ac9f:   .db $32                     ; 6C9F:  32
b01_aca0:   ldx $8f,y                   ; 6CA0:  b6 8f
b01_aca2:   .db $14                     ; 6CA2:  14
b01_aca3:   .db $b3                     ; 6CA3:  b3
b01_aca4:   dec $fff0,x                 ; 6CA4:  de f0 ff
b01_aca7:   .db $b3                     ; 6CA7:  b3
b01_aca8:   asl a                       ; 6CA8:  0a
b01_aca9:   .db $d2                     ; 6CA9:  d2
b01_acaa:   ldy $bb,x                   ; 6CAA:  b4 bb
b01_acac:   bcs $ac62                   ; 6CAC:  b0 b4
b01_acae:   .db $c2                     ; 6CAE:  c2
b01_acaf:   cld                         ; 6CAF:  d8
b01_acb0:   cmp ($ac,x)                 ; 6CB0:  c1 ac
b01_acb2:   .db $0b                     ; 6CB2:  0b
b01_acb3:   cmp ($2b),y                 ; 6CB3:  d1 2b
b01_acb5:   dec $fff0,x                 ; 6CB5:  de f0 ff
b01_acb8:   .db $b3                     ; 6CB8:  b3
b01_acb9:   asl a                       ; 6CB9:  0a
b01_acba:   .db $d2                     ; 6CBA:  d2
b01_acbb:   ldy $bb,x                   ; 6CBB:  b4 bb
b01_acbd:   .db $b3                     ; 6CBD:  b3
b01_acbe:   bcs $ac90                   ; 6CBE:  b0 d0
b01_acc0:   lda ($60),y                 ; 6CC0:  b1 60
b01_acc2:   sbc #$9d                    ; 6CC2:  e9 9d
b01_acc4:   .db $d2                     ; 6CC4:  d2
b01_acc5:   .db vm_sp_lo                     ; 6CC5:  02
b01_acc6:   and $e96e,y                 ; 6CC6:  39 6e e9
b01_acc9:   .db music_ptr_hi                     ; 6CC9:  7b
b01_acca:   cpy $de04                   ; 6CCA:  cc 04 de
b01_accd:   beq $acce                   ; 6CCD:  f0 ff
b01_accf:   .db $b3                     ; 6CCF:  b3
b01_acd0:   asl a                       ; 6CD0:  0a
b01_acd1:   .db $d2                     ; 6CD1:  d2
b01_acd2:   ldy $bb,x                   ; 6CD2:  b4 bb
b01_acd4:   bcs $ac89                   ; 6CD4:  b0 b3
b01_acd6:   stx $be59                   ; 6CD6:  8e 59 be
b01_acd9:   sbc #$34                    ; 6CD9:  e9 34
b01_acdb:   cmp (vm_fp_lo),y                 ; 6CDB:  d1 04
b01_acdd:   sta $6e19                   ; 6CDD:  8d 19 6e
b01_ace0:   sbc #$7b                    ; 6CE0:  e9 7b
b01_ace2:   cpy $3b04                   ; 6CE2:  cc 04 3b
b01_ace5:   stx $be5d                   ; 6CE5:  8e 5d be
b01_ace8:   sbc #$34                    ; 6CE8:  e9 34
b01_acea:   cmp (vm_fp_lo),y                 ; 6CEA:  d1 04
b01_acec:   and $e964,y                 ; 6CEC:  39 64 e9
b01_acef:   .db music_ptr_hi                     ; 6CEF:  7b
b01_acf0:   cpy $6204                   ; 6CF0:  cc 04 62
b01_acf3:   sbc #$9d                    ; 6CF3:  e9 9d
b01_acf5:   .db $d2                     ; 6CF5:  d2
b01_acf6:   .db vm_sp_lo                     ; 6CF6:  02
b01_acf7:   dec $33,x                   ; 6CF7:  d6 33
b01_acf9:   ldy $d70a                   ; 6CF9:  ac 0a d7
b01_acfc:   .db vm_sp_lo                     ; 6CFC:  02
b01_acfd:   lda $d641                   ; 6CFD:  ad 41 d6
b01_ad00:   .db vm_sp_hi                     ; 6D00:  03
b01_ad01:   lda $b340                   ; 6D01:  ad 40 b3
b01_ad04:   dec $fff0,x                 ; 6D04:  de f0 ff
b01_ad07:   .db $b3                     ; 6D07:  b3
b01_ad08:   asl a                       ; 6D08:  0a
b01_ad09:   .db $d2                     ; 6D09:  d2
b01_ad0a:   ldy $bb,x                   ; 6D0A:  b4 bb
b01_ad0c:   bcs $acc2                   ; 6D0C:  b0 b4
b01_ad0e:   cpy $d8                     ; 6D0E:  c4 d8
b01_ad10:   .db $33                     ; 6D10:  33
b01_ad11:   ldy $d00b                   ; 6D11:  ac 0b d0
b01_ad14:   .db $2b                     ; 6D14:  2b
b01_ad15:   dec $fff0,x                 ; 6D15:  de f0 ff
b01_ad18:   .db $b3                     ; 6D18:  b3
b01_ad19:   asl a                       ; 6D19:  0a
b01_ad1a:   .db $d2                     ; 6D1A:  d2
b01_ad1b:   ldy $bb,x                   ; 6D1B:  b4 bb
b01_ad1d:   .db $b3                     ; 6D1D:  b3
b01_ad1e:   bcs $acf1                   ; 6D1E:  b0 d1
b01_ad20:   lda ($60),y                 ; 6D20:  b1 60
b01_ad22:   sbc #$9d                    ; 6D22:  e9 9d
b01_ad24:   .db $d2                     ; 6D24:  d2
b01_ad25:   .db vm_sp_lo                     ; 6D25:  02
b01_ad26:   and $e96e,y                 ; 6D26:  39 6e e9
b01_ad29:   .db music_ptr_hi                     ; 6D29:  7b
b01_ad2a:   cpy $de04                   ; 6D2A:  cc 04 de
b01_ad2d:   beq $ad2e                   ; 6D2D:  f0 ff
b01_ad2f:   .db $b3                     ; 6D2F:  b3
b01_ad30:   asl a                       ; 6D30:  0a
b01_ad31:   .db $d2                     ; 6D31:  d2
b01_ad32:   ldy $bb,x                   ; 6D32:  b4 bb
b01_ad34:   bcs $ace9                   ; 6D34:  b0 b3
b01_ad36:   stx $be61                   ; 6D36:  8e 61 be
b01_ad39:   sbc #$34                    ; 6D39:  e9 34
b01_ad3b:   cmp (vm_fp_lo),y                 ; 6D3B:  d1 04
b01_ad3d:   sta $6e19                   ; 6D3D:  8d 19 6e
b01_ad40:   sbc #$7b                    ; 6D40:  e9 7b
b01_ad42:   cpy $3b04                   ; 6D42:  cc 04 3b
b01_ad45:   stx $be65                   ; 6D45:  8e 65 be
b01_ad48:   dec $e8,x                   ; 6D48:  d6 e8
b01_ad4a:   ldy $e960                   ; 6D4A:  ac 60 e9
b01_ad4d:   sta $02d2,x                 ; 6D4D:  9d d2 02
b01_ad50:   ldy $cc89                   ; 6D50:  ac 89 cc
b01_ad53:   .db $3b                     ; 6D53:  3b
b01_ad54:   dec $fff0,x                 ; 6D54:  de f0 ff
b01_ad57:   .db $b3                     ; 6D57:  b3
b01_ad58:   sbc #$bd                    ; 6D58:  e9 bd
b01_ad5a:   .db $ab                     ; 6D5A:  ab
b01_ad5b:   .db vm_fp_lo                     ; 6D5B:  04
b01_ad5c:   .db $cf                     ; 6D5C:  cf
b01_ad5d:   rts                         ; 6D5D:  60
b01_ad5e:   sbc #$9d                    ; 6D5E:  e9 9d
b01_ad60:   .db $d2                     ; 6D60:  d2
b01_ad61:   .db vm_sp_lo                     ; 6D61:  02
b01_ad62:   ldy $cc89                   ; 6D62:  ac 89 cc
b01_ad65:   rti                         ; 6D65:  40
b01_ad66:   .db $cf                     ; 6D66:  cf
driver_assign:   jsr $e823                   ; 6D67:  20 23 e8
b01_ad6a:   inc $a4ff,x                 ; 6D6A:  fe ff a4
b01_ad6d:   .db $5f                     ; 6D6D:  5f
b01_ad6e:   .db p2_buttons                     ; 6D6E:  6f
b01_ad6f:   .db $8b                     ; 6D6F:  8b
b01_ad70:   .db $1a                     ; 6D70:  1a
b01_ad71:   lda $8c,x                   ; 6D71:  b5 8c
b01_ad73:   ora ($70,x)                 ; 6D73:  01 70
b01_ad75:   .db $bb                     ; 6D75:  bb
b01_ad76:   .db $2b                     ; 6D76:  2b
b01_ad77:   .db $0b                     ; 6D77:  0b
b01_ad78:   .db $8f                     ; 6D78:  8f
b01_ad79:   bpl $ad2b                   ; 6D79:  10 b0
b01_ad7b:   bvc $ad40                   ; 6D7B:  50 c3
b01_ad7d:   cld                         ; 6D7D:  d8
b01_ad7e:   sty $8ead                   ; 6D7E:  8c ad 8e
b01_ad81:   sbc $e9fd,x                 ; 6D81:  fd fd e9
b01_ad84:   rol $d3                     ; 6D84:  26 d3
b01_ad86:   .db vm_sp_lo                     ; 6D86:  02
b01_ad87:   ldy $d766                   ; 6D87:  ac 66 d7
b01_ad8a:   rti                         ; 6D8A:  40
b01_ad8b:   .db $cf                     ; 6D8B:  cf
b01_ad8c:   .db $0b                     ; 6D8C:  0b
b01_ad8d:   bcs $ad1a                   ; 6D8D:  b0 8b
b01_ad8f:   asl $d8c5,x                 ; 6D8F:  1e c5 d8
b01_ad92:   .db $a7                     ; 6D92:  a7
b01_ad93:   lda $1e8d                   ; 6D93:  ad 8d 1e
b01_ad96:   sbc #$11                    ; 6D96:  e9 11
b01_ad98:   ldy $d802                   ; 6D98:  ac 02 d8
b01_ad9b:   lda ($ad),y                 ; 6D9B:  b1 ad
b01_ad9d:   sta $0b1e                   ; 6D9D:  8d 1e 0b
b01_ada0:   ldy $b3,x                   ; 6DA0:  b4 b3
b01_ada2:   bcs $ad60                   ; 6DA2:  b0 bc
b01_ada4:   lda ($41),y                 ; 6DA4:  b1 41
b01_ada6:   .db $cf                     ; 6DA6:  cf
b01_ada7:   stx $fdd9                   ; 6DA7:  8e d9 fd
b01_adaa:   sbc #$26                    ; 6DAA:  e9 26
b01_adac:   .db $d3                     ; 6DAC:  d3
b01_adad:   .db vm_sp_lo                     ; 6DAD:  02
b01_adae:   ldy $d766                   ; 6DAE:  ac 66 d7
b01_adb1:   rti                         ; 6DB1:  40
b01_adb2:   .db $cf                     ; 6DB2:  cf
driver_rest:   jsr $e823                   ; 6DB3:  20 23 e8
b01_adb6:   brk                         ; 6DB6:  00
b01_adb7:   brk                         ; 6DB7:  00
b01_adb8:   ldy $5f                     ; 6DB8:  a4 5f
b01_adba:   .db p2_buttons                     ; 6DBA:  6f
b01_adbb:   sty fief_is_daimyo_capital                   ; 6DBB:  8c a2 6d
b01_adbe:   .db $bb                     ; 6DBE:  bb
b01_adbf:   .db $d3                     ; 6DBF:  d3
b01_adc0:   cld                         ; 6DC0:  d8
b01_adc1:   inc $8ead                   ; 6DC1:  ee ad 8e
b01_adc4:   ror $fc                     ; 6DC4:  66 fc
b01_adc6:   sbc #$26                    ; 6DC6:  e9 26
b01_adc8:   .db $d3                     ; 6DC8:  d3
b01_adc9:   .db vm_sp_lo                     ; 6DC9:  02
b01_adca:   ldy $d77e                   ; 6DCA:  ac 7e d7
b01_adcd:   sty rest_turns_remaining                   ; 6DCD:  8c 67 6d
b01_add0:   .db $bb                     ; 6DD0:  bb
b01_add1:   .db $b3                     ; 6DD1:  b3
b01_add2:   ror a                       ; 6DD2:  6a
b01_add3:   adc ($e9,x)                 ; 6DD3:  61 e9
b01_add5:   sbc #$d5                    ; 6DD5:  e9 d5
b01_add7:   .db vm_fp_lo                     ; 6DD7:  04
b01_add8:   .db $d4                     ; 6DD8:  d4
b01_add9:   cld                         ; 6DD9:  d8
b01_adda:   .db $f4                     ; 6DDA:  f4
b01_addb:   lda $6e8e                   ; 6DDB:  ad 8e 6e
b01_adde:   .db $fc                     ; 6DDE:  fc
b01_addf:   sbc #$26                    ; 6DDF:  e9 26
b01_ade1:   .db $d3                     ; 6DE1:  d3
b01_ade2:   .db vm_sp_lo                     ; 6DE2:  02
b01_ade3:   ldy $d766                   ; 6DE3:  ac 66 d7
b01_ade6:   sta $e920                   ; 6DE6:  8d 20 e9
b01_ade9:   .db $0c                     ; 6DE9:  0c
b01_adea:   inx                         ; 6DEA:  e8
b01_adeb:   .db vm_sp_lo                     ; 6DEB:  02
b01_adec:   eor ($cf,x)                 ; 6DEC:  41 cf
b01_adee:   ldy $87cb                   ; 6DEE:  ac cb 87
b01_adf1:   ldy $d766                   ; 6DF1:  ac 66 d7
b01_adf4:   rti                         ; 6DF4:  40
b01_adf5:   .db $cf                     ; 6DF5:  cf
fief_select_input_loop:   jsr $e823                   ; 6DF6:  20 23 e8
b01_adf9:   .db $d3                     ; 6DF9:  d3
b01_adfa:   .db $ff                     ; 6DFA:  ff
b01_adfb:   .db $0c                     ; 6DFB:  0c
b01_adfc:   ldx #$d7                    ; 6DFC:  a2 d7
b01_adfe:   .db $ff                     ; 6DFE:  ff
b01_adff:   sta $de22                   ; 6DFF:  8d 22 de
b01_ae02:   .db $da                     ; 6E02:  da
b01_ae03:   .db $ff                     ; 6E03:  ff
b01_ae04:   .db $b3                     ; 6E04:  b3
b01_ae05:   ldy $5d                     ; 6E05:  a4 5d
b01_ae07:   .db p2_buttons                     ; 6E07:  6f
b01_ae08:   .db $8b                     ; 6E08:  8b
b01_ae09:   .db $22                     ; 6E09:  22
b01_ae0a:   lda $8c,x                   ; 6E0A:  b5 8c
b01_ae0c:   .db $3c                     ; 6E0C:  3c
b01_ae0d:   .db $9e                     ; 6E0D:  9e
b01_ae0e:   .db $bb                     ; 6E0E:  bb
b01_ae0f:   .db $b3                     ; 6E0F:  b3
b01_ae10:   .db $64                     ; 6E10:  64
b01_ae11:   sbc #$bd                    ; 6E11:  e9 bd
b01_ae13:   .db $cb                     ; 6E13:  cb
b01_ae14:   php                         ; 6E14:  08
b01_ae15:   dec $ffda,x                 ; 6E15:  de da ff
b01_ae18:   sta $d8                     ; 6E18:  85 d8
b01_ae1a:   rti                         ; 6E1A:  40
b01_ae1b:   sta $d3                     ; 6E1B:  85 d3
b01_ae1d:   sta ($d8,x)                 ; 6E1D:  81 d8
b01_ae1f:   .db $d3                     ; 6E1F:  d3
b01_ae20:   sty $00ff                   ; 6E20:  8c ff 00
b01_ae23:   cmp ($d7,x)                 ; 6E23:  c1 d7
b01_ae25:   lsr $ae,x                   ; 6E25:  56 ae
b01_ae27:   dec $77,x                   ; 6E27:  d6 77
b01_ae29:   ldx $0a64                   ; 6E29:  ae 64 0a
b01_ae2c:   .db $8f                     ; 6E2C:  8f
b01_ae2d:   .db $fc                     ; 6E2D:  fc
b01_ae2e:   .db $8b                     ; 6E2E:  8b
b01_ae2f:   .db ppu_queue_a_lo                     ; 6E2F:  1c
b01_ae30:   lda $b3,x                   ; 6E30:  b5 b3
b01_ae32:   ldy $5d                     ; 6E32:  a4 5d
b01_ae34:   .db p2_buttons                     ; 6E34:  6f
b01_ae35:   sty $01c0                   ; 6E35:  8c c0 01
b01_ae38:   lda $b4,x                   ; 6E38:  b5 b4
b01_ae3a:   .db $bb                     ; 6E3A:  bb
b01_ae3b:   .db $1b                     ; 6E3B:  1b
b01_ae3c:   .db $bb                     ; 6E3C:  bb
b01_ae3d:   sty $8d5a                   ; 6E3D:  8c 5a 8d
b01_ae40:   .db $bb                     ; 6E40:  bb
b01_ae41:   .db $b3                     ; 6E41:  b3
b01_ae42:   .db $3a                     ; 6E42:  3a
b01_ae43:   sta $0b1d                   ; 6E43:  8d 1d 0b
b01_ae46:   sei                         ; 6E46:  78
b01_ae47:   .db $b3                     ; 6E47:  b3
b01_ae48:   sbc #$5e                    ; 6E48:  e9 5e
b01_ae4a:   .db $cb                     ; 6E4A:  cb
b01_ae4b:   .db vm_fp_lo                     ; 6E4B:  04
b01_ae4c:   .db $b3                     ; 6E4C:  b3
b01_ae4d:   .db $3a                     ; 6E4D:  3a
b01_ae4e:   .db $3b                     ; 6E4E:  3b
b01_ae4f:   sbc #$54                    ; 6E4F:  e9 54
b01_ae51:   cpy $d60c                   ; 6E51:  cc 0c d6
b01_ae54:   ldx #$ae                    ; 6E54:  a2 ae
b01_ae56:   sta ($d8,x)                 ; 6E56:  81 d8
b01_ae58:   bne $addf                   ; 6E58:  d0 85
b01_ae5a:   cld                         ; 6E5A:  d8
b01_ae5b:   cmp ($d3),y                 ; 6E5B:  d1 d3
b01_ae5d:   .db $2b                     ; 6E5D:  2b
b01_ae5e:   sta ($d8,x)                 ; 6E5E:  81 d8
b01_ae60:   bne $ade7                   ; 6E60:  d0 85
b01_ae62:   cld                         ; 6E62:  d8
b01_ae63:   cmp ($d3),y                 ; 6E63:  d1 d3
b01_ae65:   rol a                       ; 6E65:  2a
b01_ae66:   sta ($d8,x)                 ; 6E66:  81 d8
b01_ae68:   bne $adef                   ; 6E68:  d0 85
b01_ae6a:   cld                         ; 6E6A:  d8
b01_ae6b:   cmp ($d3),y                 ; 6E6B:  d1 d3
b01_ae6d:   ldx $5f                     ; 6E6D:  a6 5f
b01_ae6f:   .db p2_buttons                     ; 6E6F:  6f
b01_ae70:   cpy #$d8                    ; 6E70:  c0 d8
b01_ae72:   ora $41ae,x                 ; 6E72:  1d ae 41
b01_ae75:   sta $d3                     ; 6E75:  85 d3
b01_ae77:   rti                         ; 6E77:  40
b01_ae78:   sta $d5                     ; 6E78:  85 d5
b01_ae7a:   sta ($d3,x)                 ; 6E7A:  81 d3
b01_ae7c:   eor ($c0),y                 ; 6E7C:  51 c0
b01_ae7e:   cld                         ; 6E7E:  d8
b01_ae7f:   ldx #$ae                    ; 6E7F:  a2 ae
b01_ae81:   sta ($d5,x)                 ; 6E81:  81 d5
b01_ae83:   .db $8b                     ; 6E83:  8b
b01_ae84:   .db $64                     ; 6E84:  64
b01_ae85:   cpy #$d7                    ; 6E85:  c0 d7
b01_ae87:   rol a                       ; 6E87:  2a
b01_ae88:   ldx $d581                   ; 6E88:  ae 81 d5
b01_ae8b:   sty $00c8                   ; 6E8B:  8c c8 00
b01_ae8e:   cpy #$d8                    ; 6E8E:  c0 d8
b01_ae90:   ldx #$ae                    ; 6E90:  a2 ae
b01_ae92:   .db $3a                     ; 6E92:  3a
b01_ae93:   .db $3b                     ; 6E93:  3b
b01_ae94:   sbc #$7b                    ; 6E94:  e9 7b
b01_ae96:   cpy $aa04                   ; 6E96:  cc 04 aa
b01_ae99:   .db $5f                     ; 6E99:  5f
b01_ae9a:   .db p2_buttons                     ; 6E9A:  6f
b01_ae9b:   sbc #$6e                    ; 6E9B:  e9 6e
b01_ae9d:   .db $db                     ; 6E9D:  db
b01_ae9e:   .db vm_sp_lo                     ; 6E9E:  02
b01_ae9f:   rti                         ; 6E9F:  40
b01_aea0:   sta $d5                     ; 6EA0:  85 d5
b01_aea2:   ldy $d14e                   ; 6EA2:  ac 4e d1
b01_aea5:   cmp vm_fp_hi,y                 ; 6EA5:  d9 05 00
b01_aea8:   ora (scratch_ptr_lo,x)                 ; 6EA8:  01 00
b01_aeaa:   ldx $10ae,y                 ; 6EAA:  be ae 10
b01_aead:   brk                         ; 6EAD:  00
b01_aeae:   cmp $20ae,x                 ; 6EAE:  dd ae 20
b01_aeb1:   brk                         ; 6EB1:  00
b01_aeb2:   inc $40ae                   ; 6EB2:  ee ae 40
b01_aeb5:   brk                         ; 6EB5:  00
b01_aeb6:   inc $80ae                   ; 6EB6:  ee ae 80
b01_aeb9:   brk                         ; 6EB9:  00
b01_aeba:   cmp $cfae,x                 ; 6EBA:  dd ae cf
b01_aebd:   ldx $2c4a                   ; 6EBD:  ae 4a 2c
b01_aec0:   .db $0c                     ; 6EC0:  0c
b01_aec1:   .db $cf                     ; 6EC1:  cf
b01_aec2:   .db $0c                     ; 6EC2:  0c
b01_aec3:   .db $52                     ; 6EC3:  52
b01_aec4:   cpy #$d8                    ; 6EC4:  c0 d8
b01_aec6:   cpy $42ae                   ; 6EC6:  cc ae 42
b01_aec9:   dec $ce,x                   ; 6EC9:  d6 ce
b01_aecb:   ldx $d10c                   ; 6ECB:  ae 0c d1
b01_aece:   bit $d7a0                   ; 6ECE:  2c a0 d7
b01_aed1:   .db $ff                     ; 6ED1:  ff
b01_aed2:   .db ppu_queue_a_lo                     ; 6ED2:  1c
b01_aed3:   cmp ($d7,x)                 ; 6ED3:  c1 d7
b01_aed5:   cpy #$ae                    ; 6ED5:  c0 ae
b01_aed7:   sta ($d5,x)                 ; 6ED7:  81 d5
b01_aed9:   bne $aeb1                   ; 6ED9:  d0 d6
b01_aedb:   sei                         ; 6EDB:  78
b01_aedc:   ldx $9da4                   ; 6EDC:  ae a4 9d
b01_aedf:   adc $328b                   ; 6EDF:  6d 8b 32
b01_aee2:   cpy #$d7                    ; 6EE2:  c0 d7
b01_aee4:   .db $c2                     ; 6EE4:  c2
b01_aee5:   ldx $d70c                   ; 6EE5:  ae 0c d7
b01_aee8:   cpy $40ae                   ; 6EE8:  cc ae 40
b01_aeeb:   dec $ce,x                   ; 6EEB:  d6 ce
b01_aeed:   ldx $9da4                   ; 6EED:  ae a4 9d
b01_aef0:   adc $328b                   ; 6EF0:  6d 8b 32
b01_aef3:   cpy #$d8                    ; 6EF3:  c0 d8
b01_aef5:   asl $af                     ; 6EF5:  06 af
b01_aef7:   .db $0c                     ; 6EF7:  0c
b01_aef8:   cli                         ; 6EF8:  58
b01_aef9:   cpy #$d8                    ; 6EF9:  c0 d8
b01_aefb:   ora ($af,x)                 ; 6EFB:  01 af
b01_aefd:   pha                         ; 6EFD:  48
b01_aefe:   dec $ce,x                   ; 6EFE:  d6 ce
b01_af00:   ldx $d00c                   ; 6F00:  ae 0c d0
b01_af03:   dec $ce,x                   ; 6F03:  d6 ce
b01_af05:   ldx $510c                   ; 6F05:  ae 0c 51
b01_af08:   cpy #$d8                    ; 6F08:  c0 d8
b01_af0a:   ora ($af,x)                 ; 6F0A:  01 af
b01_af0c:   eor ($d6,x)                 ; 6F0C:  41 d6
b01_af0e:   dec $20ae                   ; 6F0E:  ce ae 20
b01_af11:   .db $23                     ; 6F11:  23
b01_af12:   inx                         ; 6F12:  e8
b01_af13:   .db $fc                     ; 6F13:  fc
b01_af14:   .db $ff                     ; 6F14:  ff
b01_af15:   stx $be69                   ; 6F15:  8e 69 be
b01_af18:   sbc #$26                    ; 6F18:  e9 26
b01_af1a:   .db $d3                     ; 6F1A:  d3
b01_af1b:   .db vm_sp_lo                     ; 6F1B:  02
b01_af1c:   stx $be86                   ; 6F1C:  8e 86 be
b01_af1f:   sbc #$c4                    ; 6F1F:  e9 c4
b01_af21:   dec $d602                   ; 6F21:  ce 02 d6
b01_af24:   .db $2b                     ; 6F24:  2b
b01_af25:   .db $af                     ; 6F25:  af
b01_af26:   .db $3c                     ; 6F26:  3c
b01_af27:   sbc #$f2                    ; 6F27:  e9 f2
b01_af29:   sbc vm_sp_lo                     ; 6F29:  e5 02
b01_af2b:   .db $3c                     ; 6F2B:  3c
b01_af2c:   sbc #$f6                    ; 6F2C:  e9 f6
b01_af2e:   lda $2c02                   ; 6F2E:  ad 02 2c
b01_af31:   .db $5a                     ; 6F31:  5a
b01_af32:   cmp ($d7,x)                 ; 6F32:  c1 d7
b01_af34:   rol $af                     ; 6F34:  26 af
b01_af36:   rti                         ; 6F36:  40
b01_af37:   .db $cf                     ; 6F37:  cf
driver_map:   jsr $e823                   ; 6F38:  20 23 e8
b01_af3b:   inc $acff,x                 ; 6F3B:  fe ff ac
b01_af3e:   jsr $a4cd                   ; 6F3E:  20 cd a4
b01_af41:   sta $8b6d,x                 ; 6F41:  9d 6d 8b
b01_af44:   .db $32                     ; 6F44:  32
b01_af45:   cpy #$d8                    ; 6F45:  c0 d8
b01_af47:   .db $52                     ; 6F47:  52
b01_af48:   .db $af                     ; 6F48:  af
b01_af49:   ldy $5f                     ; 6F49:  a4 5f
b01_af4b:   .db p2_buttons                     ; 6F4B:  6f
b01_af4c:   sty $fea6                   ; 6F4C:  8c a6 fe
b01_af4f:   dec $58,x                   ; 6F4F:  d6 58
b01_af51:   .db $af                     ; 6F51:  af
b01_af52:   ldy $5f                     ; 6F52:  a4 5f
b01_af54:   .db p2_buttons                     ; 6F54:  6f
b01_af55:   sty $fed8                   ; 6F55:  8c d8 fe
b01_af58:   .db $bb                     ; 6F58:  bb
b01_af59:   .db $d3                     ; 6F59:  d3
b01_af5a:   .db $2b                     ; 6F5A:  2b
b01_af5b:   .db $b3                     ; 6F5B:  b3
b01_af5c:   sbc #$f2                    ; 6F5C:  e9 f2
b01_af5e:   sbc vm_sp_lo                     ; 6F5E:  e5 02
b01_af60:   .db $3b                     ; 6F60:  3b
b01_af61:   sbc #$10                    ; 6F61:  e9 10
b01_af63:   .db $af                     ; 6F63:  af
b01_af64:   .db vm_sp_lo                     ; 6F64:  02
b01_af65:   .db $cf                     ; 6F65:  cf
driver_grant:   jsr $e823                   ; 6F66:  20 23 e8
b01_af69:   .db $fa                     ; 6F69:  fa
b01_af6a:   .db $ff                     ; 6F6A:  ff
b01_af6b:   ldy $5f                     ; 6F6B:  a4 5f
b01_af6d:   .db p2_buttons                     ; 6F6D:  6f
b01_af6e:   sty fief_is_daimyo_capital                   ; 6F6E:  8c a2 6d
b01_af71:   .db $bb                     ; 6F71:  bb
b01_af72:   .db $d3                     ; 6F72:  d3
b01_af73:   .db $d7                     ; 6F73:  d7
b01_af74:   ror $acaf,x                 ; 6F74:  7e af ac
b01_af77:   .db $cb                     ; 6F77:  cb
b01_af78:   .db $87                     ; 6F78:  87
b01_af79:   ldy $d766                   ; 6F79:  ac 66 d7
b01_af7c:   rti                         ; 6F7C:  40
b01_af7d:   .db $cf                     ; 6F7D:  cf
b01_af7e:   adc ($e9,x)                 ; 6F7E:  61 e9
b01_af80:   bpl $af67                   ; 6F80:  10 e5
b01_af82:   .db vm_sp_lo                     ; 6F82:  02
b01_af83:   rti                         ; 6F83:  40
b01_af84:   rol a                       ; 6F84:  2a
b01_af85:   stx fief_index_list                   ; 6F85:  8e 89 6f
b01_af88:   sta $e913                   ; 6F88:  8d 13 e9
b01_af8b:   .db $9f                     ; 6F8B:  9f
b01_af8c:   .db $87                     ; 6F8C:  87
b01_af8d:   .db vm_fp_lo                     ; 6F8D:  04
b01_af8e:   .db $d7                     ; 6F8E:  d7
b01_af8f:   .db $9c                     ; 6F8F:  9c
b01_af90:   .db $af                     ; 6F90:  af
b01_af91:   asl a                       ; 6F91:  0a
b01_af92:   cld                         ; 6F92:  d8
b01_af93:   txs                         ; 6F93:  9a
b01_af94:   .db $af                     ; 6F94:  af
b01_af95:   adc ($e9,x)                 ; 6F95:  61 e9
b01_af97:   asl $0287,x                 ; 6F97:  1e 87 02
b01_af9a:   rti                         ; 6F9A:  40
b01_af9b:   .db $cf                     ; 6F9B:  cf
b01_af9c:   stx $fe40                   ; 6F9C:  8e 40 fe
b01_af9f:   sbc #$c4                    ; 6F9F:  e9 c4
b01_afa1:   dec $8e02                   ; 6FA1:  ce 02 8e
b01_afa4:   .db skip_wallclock                     ; 6FA4:  89
b01_afa5:   .db p2_buttons                     ; 6FA5:  6f
b01_afa6:   sbc #$4c                    ; 6FA6:  e9 4c
b01_afa8:   .db skip_vblank_wait                     ; 6FA8:  80
b01_afa9:   .db vm_sp_lo                     ; 6FA9:  02
b01_afaa:   tay                         ; 6FAA:  a8
b01_afab:   .db $63                     ; 6FAB:  63
b01_afac:   .db p2_buttons                     ; 6FAC:  6f
b01_afad:   cld                         ; 6FAD:  d8
b01_afae:   rts                         ; 6FAE:  60
b01_afaf:   bcs $af55                   ; 6FAF:  b0 a4
b01_afb1:   .db $63                     ; 6FB1:  63
b01_afb2:   .db p2_buttons                     ; 6FB2:  6f
b01_afb3:   cmp ($a8),y                 ; 6FB3:  d1 a8
b01_afb5:   .db $63                     ; 6FB5:  63
b01_afb6:   .db p2_buttons                     ; 6FB6:  6f
b01_afb7:   ldy $cc89                   ; 6FB7:  ac 89 cc
b01_afba:   stx $fe4d                   ; 6FBA:  8e 4d fe
b01_afbd:   sbc #$26                    ; 6FBD:  e9 26
b01_afbf:   .db $d3                     ; 6FBF:  d3
b01_afc0:   .db vm_sp_lo                     ; 6FC0:  02
b01_afc1:   asl a                       ; 6FC1:  0a
b01_afc2:   .db $d7                     ; 6FC2:  d7
b01_afc3:   sbc $af,x                   ; 6FC3:  f5 af
b01_afc5:   eor ($2a,x)                 ; 6FC5:  41 2a
b01_afc7:   ldy $cc69                   ; 6FC7:  ac 69 cc
b01_afca:   rti                         ; 6FCA:  40
b01_afcb:   and #$09                    ; 6FCB:  29 09
b01_afcd:   .db $77                     ; 6FCD:  77
b01_afce:   .db $b3                     ; 6FCE:  b3
b01_afcf:   sta $e917                   ; 6FCF:  8d 17 e9
b01_afd2:   .db music_ptr_hi                     ; 6FD2:  7b
b01_afd3:   cpy $0904                   ; 6FD3:  cc 04 09
b01_afd6:   bne $af8b                   ; 6FD6:  d0 b3
b01_afd8:   stx $be98                   ; 6FD8:  8e 98 be
b01_afdb:   sbc #$34                    ; 6FDB:  e9 34
b01_afdd:   cmp (vm_fp_lo),y                 ; 6FDD:  d1 04
b01_afdf:   ora #$d0                    ; 6FDF:  09 d0
b01_afe1:   .db $d2                     ; 6FE1:  d2
b01_afe2:   sty $fee9                   ; 6FE2:  8c e9 fe
b01_afe5:   .db $bb                     ; 6FE5:  bb
b01_afe6:   bcs $af9b                   ; 6FE6:  b0 b3
b01_afe8:   sbc #$c4                    ; 6FE8:  e9 c4
b01_afea:   dec $0902                   ; 6FEA:  ce 02 09
b01_afed:   bne $b018                   ; 6FED:  d0 29
b01_afef:   ora #$56                    ; 6FEF:  09 56
b01_aff1:   .db $c2                     ; 6FF1:  c2
b01_aff2:   .db $d7                     ; 6FF2:  d7
b01_aff3:   cpy $66af                   ; 6FF3:  cc af 66
b01_aff6:   sbc #$a6                    ; 6FF6:  e9 a6
b01_aff8:   lda (vm_sp_lo),y                 ; 6FF8:  b1 02
b01_affa:   bne $b027                   ; 6FFA:  d0 2b
b01_affc:   lsr $c1,x                   ; 6FFC:  56 c1
b01_affe:   cld                         ; 6FFE:  d8
b01_afff:   sta $af                     ; 6FFF:  85 af
b01_b001:   ldy $63                     ; 7001:  a4 63
b01_b003:   .db p2_buttons                     ; 7003:  6f
b01_b004:   sty province_ai_state                   ; 7004:  8c f7 6c
b01_b007:   .db $bb                     ; 7007:  bb
b01_b008:   .db $d3                     ; 7008:  d3
b01_b009:   .db $1b                     ; 7009:  1b
b01_b00a:   cpy #$d8                    ; 700A:  c0 d8
b01_b00c:   .db $23                     ; 700C:  23
b01_b00d:   bcs $b01a                   ; 700D:  b0 0b
b01_b00f:   .db $d2                     ; 700F:  d2
b01_b010:   sty $f7d4                   ; 7010:  8c d4 f7
b01_b013:   .db $bb                     ; 7013:  bb
b01_b014:   bcs $afc9                   ; 7014:  b0 b3
b01_b016:   stx $be9b                   ; 7016:  8e 9b be
b01_b019:   sbc #$34                    ; 7019:  e9 34
b01_b01b:   cmp (vm_fp_lo),y                 ; 701B:  d1 04
b01_b01d:   ldy $d766                   ; 701D:  ac 66 d7
b01_b020:   dec clock_b_hi,x                   ; 7020:  d6 85
b01_b022:   .db $af                     ; 7022:  af
b01_b023:   .db $0b                     ; 7023:  0b
b01_b024:   .db $d2                     ; 7024:  d2
b01_b025:   sty $f7d4                   ; 7025:  8c d4 f7
b01_b028:   .db $bb                     ; 7028:  bb
b01_b029:   bcs $afde                   ; 7029:  b0 b3
b01_b02b:   ldy $63                     ; 702B:  a4 63
b01_b02d:   .db p2_buttons                     ; 702D:  6f
b01_b02e:   sty province_ai_state                   ; 702E:  8c f7 6c
b01_b031:   .db $bb                     ; 7031:  bb
b01_b032:   .db $d3                     ; 7032:  d3
b01_b033:   .db $d2                     ; 7033:  d2
b01_b034:   sty $f7d4                   ; 7034:  8c d4 f7
b01_b037:   .db $bb                     ; 7037:  bb
b01_b038:   bcs $afed                   ; 7038:  b0 b3
b01_b03a:   stx $fe64                   ; 703A:  8e 64 fe
b01_b03d:   sbc #$34                    ; 703D:  e9 34
b01_b03f:   cmp (vm_ip_lo),y                 ; 703F:  d1 06
b01_b041:   ldy $d3a7                   ; 7041:  ac a7 d3
b01_b044:   cld                         ; 7044:  d8
b01_b045:   sta $af                     ; 7045:  85 af
b01_b047:   ldy $63                     ; 7047:  a4 63
b01_b049:   .db p2_buttons                     ; 7049:  6f
b01_b04a:   sty province_ai_state                   ; 704A:  8c f7 6c
b01_b04d:   .db $bb                     ; 704D:  bb
b01_b04e:   .db $b3                     ; 704E:  b3
b01_b04f:   .db $0b                     ; 704F:  0b
b01_b050:   .db $d4                     ; 7050:  d4
b01_b051:   .db $6b                     ; 7051:  6b
b01_b052:   sbc #$0c                    ; 7052:  e9 0c
b01_b054:   inx                         ; 7054:  e8
b01_b055:   .db vm_sp_lo                     ; 7055:  02
b01_b056:   stx $fc82                   ; 7056:  8e 82 fc
b01_b059:   sbc #$c4                    ; 7059:  e9 c4
b01_b05b:   dec $d602                   ; 705B:  ce 02 d6
b01_b05e:   ora $acb0,x                 ; 705E:  1d b0 ac
b01_b061:   .db skip_wallclock                     ; 7061:  89
b01_b062:   cpy $91d6                   ; 7062:  cc d6 91
b01_b065:   .db $af                     ; 7065:  af
setting_sound_on_off:   jsr $e823                   ; 7066:  20 23 e8
b01_b069:   inc $8eff,x                 ; 7069:  fe ff 8e
b01_b06c:   .db $b3                     ; 706C:  b3
b01_b06d:   ldx $26e9,y                 ; 706D:  be e9 26
b01_b070:   .db $d3                     ; 7070:  d3
b01_b071:   .db vm_sp_lo                     ; 7071:  02
b01_b072:   stx $beba                   ; 7072:  8e ba be
b01_b075:   sbc #$51                    ; 7075:  e9 51
b01_b077:   .db $d3                     ; 7077:  d3
b01_b078:   .db vm_sp_lo                     ; 7078:  02
b01_b079:   .db $2b                     ; 7079:  2b
b01_b07a:   .db $0b                     ; 707A:  0b
b01_b07b:   .db $52                     ; 707B:  52
b01_b07c:   cpy #$d8                    ; 707C:  c0 d8
b01_b07e:   .db $82                     ; 707E:  82
b01_b07f:   bcs $b0c1                   ; 707F:  b0 40
b01_b081:   .db $cf                     ; 7081:  cf
b01_b082:   .db $0b                     ; 7082:  0b
b01_b083:   tay                         ; 7083:  a8
b01_b084:   eor $a46f                   ; 7084:  4d 6f a4
b01_b087:   eor $d76f                   ; 7087:  4d 6f d7
b01_b08a:   stx nmi_skip_all,y                   ; 708A:  96 b0
b01_b08c:   rts                         ; 708C:  60
b01_b08d:   rts                         ; 708D:  60
b01_b08e:   ror a                       ; 708E:  6a
b01_b08f:   sbc #$26                    ; 708F:  e9 26
b01_b091:   .db $f2                     ; 7091:  f2
b01_b092:   asl $d6                     ; 7092:  06 d6
b01_b094:   .db $9b                     ; 7094:  9b
b01_b095:   bcs $b0f8                   ; 7095:  b0 61
b01_b097:   sbc #$03                    ; 7097:  e9 03
b01_b099:   dex                         ; 7099:  ca
b01_b09a:   .db vm_sp_lo                     ; 709A:  02
b01_b09b:   rti                         ; 709B:  40
b01_b09c:   .db $cf                     ; 709C:  cf
setting_animation_on_off:   jsr $e823                   ; 709D:  20 23 e8
b01_b0a0:   brk                         ; 70A0:  00
b01_b0a1:   brk                         ; 70A1:  00
b01_b0a2:   stx $bec5                   ; 70A2:  8e c5 be
b01_b0a5:   sbc #$26                    ; 70A5:  e9 26
b01_b0a7:   .db $d3                     ; 70A7:  d3
b01_b0a8:   .db vm_sp_lo                     ; 70A8:  02
b01_b0a9:   stx $bed0                   ; 70A9:  8e d0 be
b01_b0ac:   sbc #$51                    ; 70AC:  e9 51
b01_b0ae:   .db $d3                     ; 70AE:  d3
b01_b0af:   .db vm_sp_lo                     ; 70AF:  02
b01_b0b0:   cmp vm_sp_lo,y                 ; 70B0:  d9 02 00
b01_b0b3:   ora (scratch_ptr_lo,x)                 ; 70B3:  01 00
b01_b0b5:   lda nmi_skip_all,x                 ; 70B5:  bd b0 00
b01_b0b8:   brk                         ; 70B8:  00
b01_b0b9:   iny                         ; 70B9:  c8
b01_b0ba:   bcs $b082                   ; 70BA:  b0 c6
b01_b0bc:   bcs $b102                   ; 70BC:  b0 44
b01_b0be:   cmp $a1a5                   ; 70BE:  cd a5 a1
b01_b0c1:   adc $a9db                   ; 70C1:  6d db a9
b01_b0c4:   lda ($6d,x)                 ; 70C4:  a1 6d
b01_b0c6:   rti                         ; 70C6:  40
b01_b0c7:   .db $cf                     ; 70C7:  cf
b01_b0c8:   .db skip_wallclock                     ; 70C8:  89
b01_b0c9:   .db $fb                     ; 70C9:  fb
b01_b0ca:   cmp $a1a5                   ; 70CA:  cd a5 a1
b01_b0cd:   adc $d6da                   ; 70CD:  6d da d6
b01_b0d0:   .db $c3                     ; 70D0:  c3
b01_b0d1:   bcs $b0f3                   ; 70D1:  b0 20
b01_b0d3:   .db $23                     ; 70D3:  23
b01_b0d4:   inx                         ; 70D4:  e8
b01_b0d5:   inc $8eff,x                 ; 70D5:  fe ff 8e
b01_b0d8:   .db $db                     ; 70D8:  db
b01_b0d9:   ldx $26e9,y                 ; 70D9:  be e9 26
b01_b0dc:   .db $d3                     ; 70DC:  d3
b01_b0dd:   .db vm_sp_lo                     ; 70DD:  02
b01_b0de:   ldy $65                     ; 70DE:  a4 65
b01_b0e0:   adc $b652                   ; 70E0:  6d 52 b6
b01_b0e3:   .db $b3                     ; 70E3:  b3
b01_b0e4:   sbc #$cd                    ; 70E4:  e9 cd
b01_b0e6:   .db $cb                     ; 70E6:  cb
b01_b0e7:   .db vm_sp_lo                     ; 70E7:  02
b01_b0e8:   .db $b3                     ; 70E8:  b3
b01_b0e9:   stx $bee8                   ; 70E9:  8e e8 be
b01_b0ec:   sbc #$34                    ; 70EC:  e9 34
b01_b0ee:   cmp (vm_fp_lo),y                 ; 70EE:  d1 04
b01_b0f0:   ror a                       ; 70F0:  6a
b01_b0f1:   adc ($e9,x)                 ; 70F1:  61 e9
b01_b0f3:   sbc #$d5                    ; 70F3:  e9 d5
b01_b0f5:   .db vm_fp_lo                     ; 70F5:  04
b01_b0f6:   .db $2b                     ; 70F6:  2b
b01_b0f7:   cld                         ; 70F7:  d8
b01_b0f8:   .db vm_fp_lo                     ; 70F8:  04
b01_b0f9:   lda ($0b),y                 ; 70F9:  b1 0b
b01_b0fb:   .db $1b                     ; 70FB:  1b
b01_b0fc:   lda $d2,x                   ; 70FC:  b5 d2
b01_b0fe:   tay                         ; 70FE:  a8
b01_b0ff:   adc $6d                     ; 70FF:  65 6d
b01_b101:   dec vm_ip_hi,x                   ; 7101:  d6 07
b01_b103:   lda ($ac),y                 ; 7103:  b1 ac
b01_b105:   .db skip_wallclock                     ; 7105:  89
b01_b106:   cpy $cf40                   ; 7106:  cc 40 cf
setting_save_game:   jsr $e823                   ; 7109:  20 23 e8
b01_b10c:   brk                         ; 710C:  00
b01_b10d:   brk                         ; 710D:  00
b01_b10e:   stx $befa                   ; 710E:  8e fa be
b01_b111:   sbc #$26                    ; 7111:  e9 26
b01_b113:   .db $d3                     ; 7113:  d3
b01_b114:   .db vm_sp_lo                     ; 7114:  02
b01_b115:   ldy $d3a7                   ; 7115:  ac a7 d3
b01_b118:   cld                         ; 7118:  d8
b01_b119:   and #$b1                    ; 7119:  29 b1
b01_b11b:   eor ($a8,x)                 ; 711B:  41 a8
b01_b11d:   adc (p2_buttons,x)                 ; 711D:  61 6f
b01_b11f:   stx $bf07                   ; 711F:  8e 07 bf
b01_b122:   sbc #$26                    ; 7122:  e9 26
b01_b124:   .db $d3                     ; 7124:  d3
b01_b125:   .db vm_sp_lo                     ; 7125:  02
b01_b126:   ldy $d766                   ; 7126:  ac 66 d7
b01_b129:   rti                         ; 7129:  40
b01_b12a:   .db $cf                     ; 712A:  cf
setting_watch_battles:   jsr $e823                   ; 712B:  20 23 e8
b01_b12e:   inc $8eff,x                 ; 712E:  fe ff 8e
b01_b131:   .db $27                     ; 7131:  27
b01_b132:   .db $bf                     ; 7132:  bf
b01_b133:   sbc #$26                    ; 7133:  e9 26
b01_b135:   .db $d3                     ; 7135:  d3
b01_b136:   .db vm_sp_lo                     ; 7136:  02
b01_b137:   stx $bf3c                   ; 7137:  8e 3c bf
b01_b13a:   sbc #$51                    ; 713A:  e9 51
b01_b13c:   .db $d3                     ; 713C:  d3
b01_b13d:   .db vm_sp_lo                     ; 713D:  02
b01_b13e:   .db $2b                     ; 713E:  2b
b01_b13f:   .db $0b                     ; 713F:  0b
b01_b140:   .db $52                     ; 7140:  52
b01_b141:   cmp ($d8,x)                 ; 7141:  c1 d8
b01_b143:   eor #$b1                    ; 7143:  49 b1
b01_b145:   .db $0b                     ; 7145:  0b
b01_b146:   tay                         ; 7146:  a8
b01_b147:   adc $406e,x                 ; 7147:  7d 6e 40
b01_b14a:   .db $cf                     ; 714A:  cf
command_end_game:   jsr $e823                   ; 714B:  20 23 e8
b01_b14e:   .db $fc                     ; 714E:  fc
b01_b14f:   .db $ff                     ; 714F:  ff
b01_b150:   stx $bf44                   ; 7150:  8e 44 bf
b01_b153:   sbc #$26                    ; 7153:  e9 26
b01_b155:   .db $d3                     ; 7155:  d3
b01_b156:   .db vm_sp_lo                     ; 7156:  02
b01_b157:   ldy $d3a7                   ; 7157:  ac a7 d3
b01_b15a:   cld                         ; 715A:  d8
b01_b15b:   ldy $b1                     ; 715B:  a4 b1
b01_b15d:   ldy $db35                   ; 715D:  ac 35 db
b01_b160:   lda $a1                     ; 7160:  a5 a1
b01_b162:   adc $808c                   ; 7162:  6d 8c 80
b01_b165:   brk                         ; 7165:  00
b01_b166:   .db $da                     ; 7166:  da
b01_b167:   cld                         ; 7167:  d8
b01_b168:   adc $acb1,x                 ; 7168:  7d b1 ac
b01_b16b:   jsr $6ecd                   ; 716B:  20 cd 6e
b01_b16e:   jmp ($7be9)                 ; 716E:  6c e9 7b
b01_b171:   cpy $8e04                   ; 7171:  cc 04 8e
b01_b174:   .db brk_scratch_hi                     ; 7174:  67
b01_b175:   .db $bf                     ; 7175:  bf
b01_b176:   sbc #$c4                    ; 7176:  e9 c4
b01_b178:   dec $d602                   ; 7178:  ce 02 d6
b01_b17b:   .db music_ptr_lo                     ; 717B:  7a
b01_b17c:   lda ($ac),y                 ; 717C:  b1 ac
b01_b17e:   ror $2bd7,x                 ; 717E:  7e d7 2b
b01_b181:   rti                         ; 7181:  40
b01_b182:   dec $99,x                   ; 7182:  d6 99
b01_b184:   lda ($3a),y                 ; 7184:  b1 3a
b01_b186:   sbc #$72                    ; 7186:  e9 72
b01_b188:   .db $d7                     ; 7188:  d7
b01_b189:   .db vm_sp_lo                     ; 7189:  02
b01_b18a:   .db $1b                     ; 718A:  1b
b01_b18b:   cpy #$d8                    ; 718B:  c0 d8
b01_b18d:   .db $97                     ; 718D:  97
b01_b18e:   lda ($0a),y                 ; 718E:  b1 0a
b01_b190:   sty province_ai_state                   ; 7190:  8c f7 6c
b01_b193:   .db $bb                     ; 7193:  bb
b01_b194:   .db $b3                     ; 7194:  b3
b01_b195:   rti                         ; 7195:  40
b01_b196:   .db $d4                     ; 7196:  d4
b01_b197:   asl a                       ; 7197:  0a
b01_b198:   bne $b1c4                   ; 7198:  d0 2a
b01_b19a:   asl a                       ; 719A:  0a
b01_b19b:   ldx $9d                     ; 719B:  a6 9d
b01_b19d:   adc $d7c6                   ; 719D:  6d c6 d7
b01_b1a0:   sta $b1                     ; 71A0:  85 b1
b01_b1a2:   eor ($cf,x)                 ; 71A2:  41 cf
b01_b1a4:   rti                         ; 71A4:  40
b01_b1a5:   .db $cf                     ; 71A5:  cf
submenu_prompt:   jsr $e823                   ; 71A6:  20 23 e8
b01_b1a9:   .db $fc                     ; 71A9:  fc
b01_b1aa:   .db $ff                     ; 71AA:  ff
b01_b1ab:   .db brk_scratch_hi                     ; 71AB:  67
b01_b1ac:   sta $e915                   ; 71AC:  8d 15 e9
b01_b1af:   .db music_ptr_hi                     ; 71AF:  7b
b01_b1b0:   cpy $6204                   ; 71B0:  cc 04 62
b01_b1b3:   sbc #$9d                    ; 71B3:  e9 9d
b01_b1b5:   .db $d2                     ; 71B5:  d2
b01_b1b6:   .db vm_sp_lo                     ; 71B6:  02
b01_b1b7:   ldy $d287                   ; 71B7:  ac 87 d2
b01_b1ba:   rti                         ; 71BA:  40
b01_b1bb:   rol a                       ; 71BB:  2a
b01_b1bc:   rti                         ; 71BC:  40
b01_b1bd:   .db $2b                     ; 71BD:  2b
b01_b1be:   .db $0b                     ; 71BE:  0b
b01_b1bf:   cld                         ; 71BF:  d8
b01_b1c0:   cpy $b1                     ; 71C0:  c4 b1
b01_b1c2:   asl a                       ; 71C2:  0a
b01_b1c3:   .db $cf                     ; 71C3:  cf
b01_b1c4:   ldy $d14e                   ; 71C4:  ac 4e d1
b01_b1c7:   cmp vm_fp_lo,y                 ; 71C7:  d9 04 00
b01_b1ca:   ora (scratch_ptr_lo,x)                 ; 71CA:  01 00
b01_b1cc:   .db $df                     ; 71CC:  df
b01_b1cd:   lda (vm_sp_lo),y                 ; 71CD:  b1 02
b01_b1cf:   brk                         ; 71CF:  00
b01_b1d0:   .db $dc                     ; 71D0:  dc
b01_b1d1:   lda ($10),y                 ; 71D1:  b1 10
b01_b1d3:   brk                         ; 71D3:  00
b01_b1d4:   cpx $20b1                   ; 71D4:  ec b1 20
b01_b1d7:   brk                         ; 71D7:  00
b01_b1d8:   .db $1a                     ; 71D8:  1a
b01_b1d9:   .db $b2                     ; 71D9:  b2
b01_b1da:   ldx $0cb1,y                 ; 71DA:  be b1 0c
b01_b1dd:   cmp ($2a),y                 ; 71DD:  d1 2a
b01_b1df:   rts                         ; 71DF:  60
b01_b1e0:   sbc #$9d                    ; 71E0:  e9 9d
b01_b1e2:   .db $d2                     ; 71E2:  d2
b01_b1e3:   .db vm_sp_lo                     ; 71E3:  02
b01_b1e4:   eor ($2b,x)                 ; 71E4:  41 2b
b01_b1e6:   ldy $cc89                   ; 71E6:  ac 89 cc
b01_b1e9:   dec $be,x                   ; 71E9:  d6 be
b01_b1eb:   lda ($60),y                 ; 71EB:  b1 60
b01_b1ed:   sbc #$9d                    ; 71ED:  e9 9d
b01_b1ef:   .db $d2                     ; 71EF:  d2
b01_b1f0:   .db vm_sp_lo                     ; 71F0:  02
b01_b1f1:   ldy $cf                     ; 71F1:  a4 cf
b01_b1f3:   .db $7f                     ; 71F3:  7f
b01_b1f4:   cmp ($a8),y                 ; 71F4:  d1 a8
b01_b1f6:   .db $cf                     ; 71F6:  cf
b01_b1f7:   .db $7f                     ; 71F7:  7f
b01_b1f8:   lsr $c0,x                   ; 71F8:  56 c0
b01_b1fa:   cld                         ; 71FA:  d8
b01_b1fb:   asl a                       ; 71FB:  0a
b01_b1fc:   .db $b2                     ; 71FC:  b2
b01_b1fd:   .db $0c                     ; 71FD:  0c
b01_b1fe:   ror $b3,x                   ; 71FE:  76 b3
b01_b200:   sta $e915                   ; 7200:  8d 15 e9
b01_b203:   .db music_ptr_hi                     ; 7203:  7b
b01_b204:   cpy $0c04                   ; 7204:  cc 04 0c
b01_b207:   dec $0b,x                   ; 7207:  d6 0b
b01_b209:   .db $b2                     ; 7209:  b2
b01_b20a:   asl a                       ; 720A:  0a
b01_b20b:   cmp ($2a),y                 ; 720B:  d1 2a
b01_b20d:   .db $62                     ; 720D:  62
b01_b20e:   sbc #$9d                    ; 720E:  e9 9d
b01_b210:   .db $d2                     ; 7210:  d2
b01_b211:   .db vm_sp_lo                     ; 7211:  02
b01_b212:   .db $62                     ; 7212:  62
b01_b213:   sbc #$3e                    ; 7213:  e9 3e
b01_b215:   .db $d7                     ; 7215:  d7
b01_b216:   .db vm_sp_lo                     ; 7216:  02
b01_b217:   dec $be,x                   ; 7217:  d6 be
b01_b219:   lda ($60),y                 ; 7219:  b1 60
b01_b21b:   sbc #$9d                    ; 721B:  e9 9d
b01_b21d:   .db $d2                     ; 721D:  d2
b01_b21e:   .db vm_sp_lo                     ; 721E:  02
b01_b21f:   ldy $cf                     ; 721F:  a4 cf
b01_b221:   .db $7f                     ; 7221:  7f
b01_b222:   bne $b1cc                   ; 7222:  d0 a8
b01_b224:   .db $cf                     ; 7224:  cf
b01_b225:   .db $7f                     ; 7225:  7f
b01_b226:   .db $b3                     ; 7226:  b3
b01_b227:   .db $0c                     ; 7227:  0c
b01_b228:   .db $77                     ; 7228:  77
b01_b229:   ldy $c0,x                   ; 7229:  b4 c0
b01_b22b:   cld                         ; 722B:  d8
b01_b22c:   and $67b2,y                 ; 722C:  39 b2 67
b01_b22f:   sta $e915                   ; 722F:  8d 15 e9
b01_b232:   .db music_ptr_hi                     ; 7232:  7b
b01_b233:   cpy $4004                   ; 7233:  cc 04 40
b01_b236:   dec $0c,x                   ; 7236:  d6 0c
b01_b238:   .db $b2                     ; 7238:  b2
b01_b239:   asl a                       ; 7239:  0a
b01_b23a:   bne $b212                   ; 723A:  d0 d6
b01_b23c:   .db $0c                     ; 723C:  0c
b01_b23d:   .db $b2                     ; 723D:  b2
driver_other:   jsr $e823                   ; 723E:  20 23 e8
b01_b241:   sbc $acff,y                 ; 7241:  f9 ff ac
b01_b244:   adc #$cc                    ; 7244:  69 cc
b01_b246:   rti                         ; 7246:  40
b01_b247:   and #$09                    ; 7247:  29 09
b01_b249:   .db $77                     ; 7249:  77
b01_b24a:   .db $b3                     ; 724A:  b3
b01_b24b:   sta $e916                   ; 724B:  8d 16 e9
b01_b24e:   .db music_ptr_hi                     ; 724E:  7b
b01_b24f:   cpy $0904                   ; 724F:  cc 04 09
b01_b252:   bne $b207                   ; 7252:  d0 b3
b01_b254:   stx $bf71                   ; 7254:  8e 71 bf
b01_b257:   sbc #$34                    ; 7257:  e9 34
b01_b259:   cmp (vm_fp_lo),y                 ; 7259:  d1 04
b01_b25b:   ora #$d2                    ; 725B:  09 d2
b01_b25d:   sty $ff1a                   ; 725D:  8c 1a ff
b01_b260:   .db $bb                     ; 7260:  bb
b01_b261:   bcs $b216                   ; 7261:  b0 b3
b01_b263:   sbc #$c4                    ; 7263:  e9 c4
b01_b265:   dec $0902                   ; 7265:  ce 02 09
b01_b268:   bne $b293                   ; 7268:  d0 29
b01_b26a:   ora #$57                    ; 726A:  09 57
b01_b26c:   .db $c2                     ; 726C:  c2
b01_b26d:   .db $d7                     ; 726D:  d7
b01_b26e:   pha                         ; 726E:  48
b01_b26f:   .db $b2                     ; 726F:  b2
b01_b270:   stx $bf75                   ; 7270:  8e 75 bf
b01_b273:   sbc #$26                    ; 7273:  e9 26
b01_b275:   .db $d3                     ; 7275:  d3
b01_b276:   .db vm_sp_lo                     ; 7276:  02
b01_b277:   .db brk_scratch_hi                     ; 7277:  67
b01_b278:   sbc #$a6                    ; 7278:  e9 a6
b01_b27a:   lda (vm_sp_lo),y                 ; 727A:  b1 02
b01_b27c:   rol a                       ; 727C:  2a
b01_b27d:   asl a                       ; 727D:  0a
b01_b27e:   .db $d2                     ; 727E:  d2
b01_b27f:   sty $b9e8                   ; 727F:  8c e8 b9
b01_b282:   .db $bb                     ; 7282:  bb
b01_b283:   bcs $b2b0                   ; 7283:  b0 2b
b01_b285:   .db $0b                     ; 7285:  0b
b01_b286:   cmp $f9a2,x                 ; 7286:  dd a2 f9
b01_b289:   .db $ff                     ; 7289:  ff
b01_b28a:   asl a                       ; 728A:  0a
b01_b28b:   lsr $c1,x                   ; 728B:  56 c1
b01_b28d:   cld                         ; 728D:  d8
b01_b28e:   tya                         ; 728E:  98
b01_b28f:   .db $b2                     ; 728F:  b2
b01_b290:   ldy #$f9                    ; 7290:  a0 f9
b01_b292:   .db $ff                     ; 7292:  ff
b01_b293:   eor ($c1),y                 ; 7293:  51 c1
b01_b295:   .db $d7                     ; 7295:  d7
b01_b296:   bvs $b24a                   ; 7296:  70 b2
b01_b298:   rts                         ; 7298:  60
b01_b299:   sbc #$1e                    ; 7299:  e9 1e
b01_b29b:   .db $87                     ; 729B:  87
b01_b29c:   .db vm_sp_lo                     ; 729C:  02
b01_b29d:   asl a                       ; 729D:  0a
b01_b29e:   eor $c0,x                   ; 729E:  55 c0
b01_b2a0:   .db $cf                     ; 72A0:  cf
driver_pass:   jsr $e823                   ; 72A1:  20 23 e8
b01_b2a4:   brk                         ; 72A4:  00
b01_b2a5:   brk                         ; 72A5:  00
b01_b2a6:   stx $bf83                   ; 72A6:  8e 83 bf
b01_b2a9:   sbc #$26                    ; 72A9:  e9 26
b01_b2ab:   .db $d3                     ; 72AB:  d3
b01_b2ac:   .db vm_sp_lo                     ; 72AC:  02
b01_b2ad:   ldy $d766                   ; 72AD:  ac 66 d7
b01_b2b0:   eor ($cf,x)                 ; 72B0:  41 cf
ai_seed_fief_tax_rate:   jsr $e823                   ; 72B2:  20 23 e8
b01_b2b5:   brk                         ; 72B5:  00
b01_b2b6:   brk                         ; 72B6:  00
b01_b2b7:   stx battle_defending_province                   ; 72B7:  8e 63 6f
b01_b2ba:   dec $000b,x                 ; 72BA:  de 0b 00
b01_b2bd:   .db $b3                     ; 72BD:  b3
b01_b2be:   sbc #$94                    ; 72BE:  e9 94
b01_b2c0:   .db $cb                     ; 72C0:  cb
b01_b2c1:   .db vm_fp_lo                     ; 72C1:  04
b01_b2c2:   ldy $63                     ; 72C2:  a4 63
b01_b2c4:   .db p2_buttons                     ; 72C4:  6f
b01_b2c5:   sty fief_tax_rate                   ; 72C5:  8c 2d 6d
b01_b2c8:   .db $bb                     ; 72C8:  bb
b01_b2c9:   .db $b3                     ; 72C9:  b3
b01_b2ca:   ldy $db12                   ; 72CA:  ac 12 db
b01_b2cd:   cld                         ; 72CD:  d8
b01_b2ce:   .db $da                     ; 72CE:  da
b01_b2cf:   .db $b2                     ; 72CF:  b2
b01_b2d0:   .db p2_buttons                     ; 72D0:  6f
b01_b2d1:   sbc #$52                    ; 72D1:  e9 52
b01_b2d3:   dex                         ; 72D3:  ca
b01_b2d4:   .db vm_sp_lo                     ; 72D4:  02
b01_b2d5:   .db $8f                     ; 72D5:  8f
b01_b2d6:   bpl $b2ae                   ; 72D6:  10 d6
b01_b2d8:   .db $e2                     ; 72D8:  e2
b01_b2d9:   .db $b2                     ; 72D9:  b2
b01_b2da:   sta $e91e                   ; 72DA:  8d 1e e9
b01_b2dd:   .db $52                     ; 72DD:  52
b01_b2de:   dex                         ; 72DE:  ca
b01_b2df:   .db vm_sp_lo                     ; 72DF:  02
b01_b2e0:   .db $8f                     ; 72E0:  8f
b01_b2e1:   .db $23                     ; 72E1:  23
b01_b2e2:   .db $d4                     ; 72E2:  d4
b01_b2e3:   stx battle_defending_province                   ; 72E3:  8e 63 6f
b01_b2e6:   dec $000b,x                 ; 72E6:  de 0b 00
b01_b2e9:   .db $b3                     ; 72E9:  b3
b01_b2ea:   sbc #$94                    ; 72EA:  e9 94
b01_b2ec:   .db $cb                     ; 72EC:  cb
b01_b2ed:   .db vm_fp_lo                     ; 72ED:  04
b01_b2ee:   .db $cf                     ; 72EE:  cf
ai_calc_men_surplus_over_gold_and_rice:   jsr $e823                   ; 72EF:  20 23 e8
b01_b2f2:   inc $a4ff,x                 ; 72F2:  fe ff a4
b01_b2f5:   .db $5f                     ; 72F5:  5f
b01_b2f6:   .db p2_buttons                     ; 72F6:  6f
b01_b2f7:   .db $8b                     ; 72F7:  8b
b01_b2f8:   .db $1a                     ; 72F8:  1a
b01_b2f9:   lda $8c,x                   ; 72F9:  b5 8c
b01_b2fb:   ora ($70,x)                 ; 72FB:  01 70
b01_b2fd:   .db $bb                     ; 72FD:  bb
b01_b2fe:   .db $2b                     ; 72FE:  2b
b01_b2ff:   .db $3c                     ; 72FF:  3c
b01_b300:   .db $0b                     ; 7300:  0b
b01_b301:   .db $8f                     ; 7301:  8f
b01_b302:   bpl $b2b4                   ; 7302:  10 b0
b01_b304:   .db $b3                     ; 7304:  b3
b01_b305:   .db $0b                     ; 7305:  0b
b01_b306:   bcs $b2bc                   ; 7306:  b0 b4
b01_b308:   ldy $3db1,x                 ; 7308:  bc b1 3d
b01_b30b:   .db $0b                     ; 730B:  0b
b01_b30c:   .db $8f                     ; 730C:  8f
b01_b30d:   bpl $b2bf                   ; 730D:  10 b0
b01_b30f:   .db $b3                     ; 730F:  b3
b01_b310:   .db $0b                     ; 7310:  0b
b01_b311:   ror nmi_skip_all,x                   ; 7311:  76 b0
b01_b313:   ldy $bc,x                   ; 7313:  b4 bc
b01_b315:   lda ($0c),y                 ; 7315:  b1 0c
b01_b317:   bcs $b369                   ; 7317:  b0 50
b01_b319:   .db $c2                     ; 7319:  c2
b01_b31a:   cld                         ; 731A:  d8
b01_b31b:   jsr $3cb3                   ; 731B:  20 b3 3c
b01_b31e:   rti                         ; 731E:  40
b01_b31f:   lda ($0d),y                 ; 731F:  b1 0d
b01_b321:   bcs $b373                   ; 7321:  b0 50
b01_b323:   .db $c2                     ; 7323:  c2
b01_b324:   cld                         ; 7324:  d8
b01_b325:   rol a                       ; 7325:  2a
b01_b326:   .db $b3                     ; 7326:  b3
b01_b327:   and $b140,x                 ; 7327:  3d 40 b1
b01_b32a:   .db $cf                     ; 732A:  cf
rng_threshold_10_29:   jsr $e823                   ; 732B:  20 23 e8
b01_b32e:   brk                         ; 732E:  00
b01_b32f:   brk                         ; 732F:  00
b01_b330:   sta $e914                   ; 7330:  8d 14 e9
b01_b333:   .db $52                     ; 7333:  52
b01_b334:   dex                         ; 7334:  ca
b01_b335:   .db vm_sp_lo                     ; 7335:  02
b01_b336:   .db music_ptr_lo                     ; 7336:  7a
b01_b337:   .db $cf                     ; 7337:  cf
ai_province_gold_to_rice_convert:   jsr $e823                   ; 7338:  20 23 e8
b01_b33b:   .db $fc                     ; 733B:  fc
b01_b33c:   .db $ff                     ; 733C:  ff
b01_b33d:   .db $64                     ; 733D:  64
b01_b33e:   sbc #$52                    ; 733E:  e9 52
b01_b340:   dex                         ; 7340:  ca
b01_b341:   .db vm_sp_lo                     ; 7341:  02
b01_b342:   .db $d7                     ; 7342:  d7
b01_b343:   lsr $b3                     ; 7343:  46 b3
b01_b345:   .db $cf                     ; 7345:  cf
b01_b346:   ldy $5f                     ; 7346:  a4 5f
b01_b348:   .db p2_buttons                     ; 7348:  6f
b01_b349:   .db $8b                     ; 7349:  8b
b01_b34a:   .db $1a                     ; 734A:  1a
b01_b34b:   lda $8c,x                   ; 734B:  b5 8c
b01_b34d:   ora ($70,x)                 ; 734D:  01 70
b01_b34f:   .db $bb                     ; 734F:  bb
b01_b350:   .db $2b                     ; 7350:  2b
b01_b351:   ldy $b32b                   ; 7351:  ac 2b b3
b01_b354:   ldx $0d                     ; 7354:  a6 0d
b01_b356:   ror $d8c6                   ; 7356:  6e c6 d8
b01_b359:   .db brk_scratch_hi                     ; 7359:  67
b01_b35a:   .db $b3                     ; 735A:  b3
b01_b35b:   ora $52b0                   ; 735B:  0d b0 52
b01_b35e:   ldx $b3,y                   ; 735E:  b6 b3
b01_b360:   sbc #$0a                    ; 7360:  e9 0a
b01_b362:   .db $8b                     ; 7362:  8b
b01_b363:   .db vm_sp_lo                     ; 7363:  02
b01_b364:   dec $a3,x                   ; 7364:  d6 a3
b01_b366:   .db $b3                     ; 7366:  b3
b01_b367:   ldy $b32b                   ; 7367:  ac 2b b3
b01_b36a:   ldx $0d                     ; 736A:  a6 0d
b01_b36c:   ror $d8c8                   ; 736C:  6e c8 d8
b01_b36f:   .db $a3                     ; 736F:  a3
b01_b370:   .db $b3                     ; 7370:  b3
b01_b371:   .db $0b                     ; 7371:  0b
b01_b372:   ror nmi_skip_all,x                   ; 7372:  76 b0
b01_b374:   .db $b3                     ; 7374:  b3
b01_b375:   .db $0b                     ; 7375:  0b
b01_b376:   .db $8f                     ; 7376:  8f
b01_b377:   clc                         ; 7377:  18
b01_b378:   bcs $b32e                   ; 7378:  b0 b4
b01_b37a:   ldy $aab3,x                 ; 737A:  bc b3 aa
b01_b37d:   ora $0c6e                   ; 737D:  0d 6e 0c
b01_b380:   bcs $b335                   ; 7380:  b0 b3
b01_b382:   sbc #$57                    ; 7382:  e9 57
b01_b384:   .db clock_a_hi                     ; 7384:  83
b01_b385:   asl $2a                     ; 7385:  06 2a
b01_b387:   .db $3a                     ; 7387:  3a
b01_b388:   tax                         ; 7388:  aa
b01_b389:   ora $e96e                   ; 7389:  0d 6e e9
b01_b38c:   .db vm_sp_hi                     ; 738C:  03
b01_b38d:   .db clock_a_hi                     ; 738D:  83
b01_b38e:   .db vm_fp_lo                     ; 738E:  04
b01_b38f:   .db $b3                     ; 738F:  b3
b01_b390:   .db $0b                     ; 7390:  0b
b01_b391:   ldy $b3,x                   ; 7391:  b4 b3
b01_b393:   bcs $b351                   ; 7393:  b0 bc
b01_b395:   lda ($3a),y                 ; 7395:  b1 3a
b01_b397:   .db $0b                     ; 7397:  0b
b01_b398:   ror $b4,x                   ; 7398:  76 b4
b01_b39a:   .db $b3                     ; 739A:  b3
b01_b39b:   bcs $b358                   ; 739B:  b0 bb
b01_b39d:   lda ($62),y                 ; 739D:  b1 62
b01_b39f:   sbc #$4e                    ; 739F:  e9 4e
b01_b3a1:   txa                         ; 73A1:  8a
b01_b3a2:   .db vm_sp_lo                     ; 73A2:  02
b01_b3a3:   and $e93c,x                 ; 73A3:  3d 3c e9
b01_b3a6:   .db $ef                     ; 73A6:  ef
b01_b3a7:   .db $b2                     ; 73A7:  b2
b01_b3a8:   .db vm_fp_lo                     ; 73A8:  04
b01_b3a9:   .db $cf                     ; 73A9:  cf
ai_develop_town_handler:   jsr $e823                   ; 73AA:  20 23 e8
b01_b3ad:   sed                         ; 73AD:  f8
b01_b3ae:   .db $ff                     ; 73AE:  ff
b01_b3af:   rti                         ; 73AF:  40
b01_b3b0:   and #$2a                    ; 73B0:  29 2a
b01_b3b2:   ldy $5f                     ; 73B2:  a4 5f
b01_b3b4:   .db p2_buttons                     ; 73B4:  6f
b01_b3b5:   .db $8b                     ; 73B5:  8b
b01_b3b6:   .db $1a                     ; 73B6:  1a
b01_b3b7:   lda $8c,x                   ; 73B7:  b5 8c
b01_b3b9:   ora ($70,x)                 ; 73B9:  01 70
b01_b3bb:   .db $bb                     ; 73BB:  bb
b01_b3bc:   .db $2b                     ; 73BC:  2b
b01_b3bd:   dec $fffa,x                 ; 73BD:  de fa ff
b01_b3c0:   .db $b3                     ; 73C0:  b3
b01_b3c1:   dec $fffc,x                 ; 73C1:  de fc ff
b01_b3c4:   .db $b3                     ; 73C4:  b3
b01_b3c5:   sbc #$ef                    ; 73C5:  e9 ef
b01_b3c7:   .db $b2                     ; 73C7:  b2
b01_b3c8:   .db vm_fp_lo                     ; 73C8:  04
b01_b3c9:   tax                         ; 73C9:  aa
b01_b3ca:   .db $5f                     ; 73CA:  5f
b01_b3cb:   .db p2_buttons                     ; 73CB:  6f
b01_b3cc:   sbc #$b2                    ; 73CC:  e9 b2
b01_b3ce:   .db $b2                     ; 73CE:  b2
b01_b3cf:   .db vm_sp_lo                     ; 73CF:  02
b01_b3d0:   dec $fffa,x                 ; 73D0:  de fa ff
b01_b3d3:   .db $b3                     ; 73D3:  b3
b01_b3d4:   dec $fffc,x                 ; 73D4:  de fc ff
b01_b3d7:   .db $b3                     ; 73D7:  b3
b01_b3d8:   sbc #$38                    ; 73D8:  e9 38
b01_b3da:   .db $b3                     ; 73DA:  b3
b01_b3db:   .db vm_fp_lo                     ; 73DB:  04
b01_b3dc:   .db $3a                     ; 73DC:  3a
b01_b3dd:   .db $0b                     ; 73DD:  0b
b01_b3de:   .db palette_dirty                     ; 73DE:  74
b01_b3df:   bcs $b394                   ; 73DF:  b0 b3
b01_b3e1:   .db $0b                     ; 73E1:  0b
b01_b3e2:   .db $8f                     ; 73E2:  8f
b01_b3e3:   clc                         ; 73E3:  18
b01_b3e4:   bcs $b399                   ; 73E4:  b0 b3
b01_b3e6:   ldy $9f                     ; 73E6:  a4 9f
b01_b3e8:   adc $e990                   ; 73E8:  6d 90 e9
b01_b3eb:   sbc $648b,y                 ; 73EB:  f9 8b 64
b01_b3ee:   lda $8f,x                   ; 73EE:  b5 8f
b01_b3f0:   .db $64                     ; 73F0:  64
b01_b3f1:   .db $b3                     ; 73F1:  b3
b01_b3f2:   sbc #$5e                    ; 73F2:  e9 5e
b01_b3f4:   .db $cb                     ; 73F4:  cb
b01_b3f5:   .db vm_fp_lo                     ; 73F5:  04
b01_b3f6:   .db $b3                     ; 73F6:  b3
b01_b3f7:   sbc #$e5                    ; 73F7:  e9 e5
b01_b3f9:   .db $8b                     ; 73F9:  8b
b01_b3fa:   asl $28                     ; 73FA:  06 28
b01_b3fc:   .db $0b                     ; 73FC:  0b
b01_b3fd:   .db $8f                     ; 73FD:  8f
b01_b3fe:   clc                         ; 73FE:  18
b01_b3ff:   bcs $b3b4                   ; 73FF:  b0 b3
b01_b401:   .db $0b                     ; 7401:  0b
b01_b402:   .db palette_dirty                     ; 7402:  74
b01_b403:   bcs $b3b9                   ; 7403:  b0 b4
b01_b405:   .db $c2                     ; 7405:  c2
b01_b406:   cld                         ; 7406:  d8
b01_b407:   rol $b4                     ; 7407:  26 b4
b01_b409:   .db $63                     ; 7409:  63
b01_b40a:   sbc #$52                    ; 740A:  e9 52
b01_b40c:   dex                         ; 740C:  ca
b01_b40d:   .db vm_sp_lo                     ; 740D:  02
b01_b40e:   .db $d7                     ; 740E:  d7
b01_b40f:   rol $b4                     ; 740F:  26 b4
b01_b411:   php                         ; 7411:  08
b01_b412:   bvc $b3d8                   ; 7412:  50 c4
b01_b414:   cld                         ; 7414:  d8
b01_b415:   rol $b4                     ; 7415:  26 b4
b01_b417:   sec                         ; 7417:  38
b01_b418:   .db $0b                     ; 7418:  0b
b01_b419:   .db palette_dirty                     ; 7419:  74
b01_b41a:   ldy $b3,x                   ; 741A:  b4 b3
b01_b41c:   bcs $b3d9                   ; 741C:  b0 bb
b01_b41e:   lda ($38),y                 ; 741E:  b1 38
b01_b420:   .db $0b                     ; 7420:  0b
b01_b421:   ldy $b3,x                   ; 7421:  b4 b3
b01_b423:   bcs $b3e1                   ; 7423:  b0 bc
b01_b425:   lda ($ac),y                 ; 7425:  b1 ac
b01_b427:   cmp #$95                    ; 7427:  c9 95
b01_b429:   eor ($cf,x)                 ; 7429:  41 cf
ai_develop_dam_and_grow:   jsr $e823                   ; 742B:  20 23 e8
b01_b42e:   .db $f4                     ; 742E:  f4
b01_b42f:   .db $ff                     ; 742F:  ff
b01_b430:   rti                         ; 7430:  40
b01_b431:   and #$2a                    ; 7431:  29 2a
b01_b433:   dec $fffa,x                 ; 7433:  de fa ff
b01_b436:   .db $b3                     ; 7436:  b3
b01_b437:   dec $fffc,x                 ; 7437:  de fc ff
b01_b43a:   .db $b3                     ; 743A:  b3
b01_b43b:   sbc #$ef                    ; 743B:  e9 ef
b01_b43d:   .db $b2                     ; 743D:  b2
b01_b43e:   .db vm_fp_lo                     ; 743E:  04
b01_b43f:   tax                         ; 743F:  aa
b01_b440:   .db $5f                     ; 7440:  5f
b01_b441:   .db p2_buttons                     ; 7441:  6f
b01_b442:   sbc #$b2                    ; 7442:  e9 b2
b01_b444:   .db $b2                     ; 7444:  b2
b01_b445:   .db vm_sp_lo                     ; 7445:  02
b01_b446:   .db $0b                     ; 7446:  0b
b01_b447:   sei                         ; 7447:  78
b01_b448:   bcs $b3fd                   ; 7448:  b0 b3
b01_b44a:   ldy $5f                     ; 744A:  a4 5f
b01_b44c:   .db p2_buttons                     ; 744C:  6f
b01_b44d:   .db $8b                     ; 744D:  8b
b01_b44e:   .db $1a                     ; 744E:  1a
b01_b44f:   lda $8c,x                   ; 744F:  b5 8c
b01_b451:   ora ($70,x)                 ; 7451:  01 70
b01_b453:   .db $bb                     ; 7453:  bb
b01_b454:   .db $2b                     ; 7454:  2b
b01_b455:   .db $7c                     ; 7455:  7c
b01_b456:   bcs $b40c                   ; 7456:  b0 b4
b01_b458:   cpy $d8                     ; 7458:  c4 d8
b01_b45a:   cmp #$b4                    ; 745A:  c9 b4
b01_b45c:   .db $0b                     ; 745C:  0b
b01_b45d:   sei                         ; 745D:  78
b01_b45e:   bcs $b438                   ; 745E:  b0 d8
b01_b460:   .db $97                     ; 7460:  97
b01_b461:   ldy $0b,x                   ; 7461:  b4 0b
b01_b463:   .db music_ptr_lo                     ; 7463:  7a
b01_b464:   bcs $b419                   ; 7464:  b0 b3
b01_b466:   .db skip_wallclock                     ; 7466:  89
b01_b467:   .db $64                     ; 7467:  64
b01_b468:   ldy $bc,x                   ; 7468:  b4 bc
b01_b46a:   .db $b3                     ; 746A:  b3
b01_b46b:   .db $3b                     ; 746B:  3b
b01_b46c:   sbc #$d8                    ; 746C:  e9 d8
b01_b46e:   .db $87                     ; 746E:  87
b01_b46f:   .db vm_sp_lo                     ; 746F:  02
b01_b470:   ldy $b5,x                   ; 7470:  b4 b5
b01_b472:   .db $b3                     ; 7472:  b3
b01_b473:   .db $3a                     ; 7473:  3a
b01_b474:   sbc #$5e                    ; 7474:  e9 5e
b01_b476:   .db $cb                     ; 7476:  cb
b01_b477:   .db vm_fp_lo                     ; 7477:  04
b01_b478:   .db $27                     ; 7478:  27
b01_b479:   .db $37                     ; 7479:  37
b01_b47a:   .db $0b                     ; 747A:  0b
b01_b47b:   ldy $b3,x                   ; 747B:  b4 b3
b01_b47d:   bcs $b43b                   ; 747D:  b0 bc
b01_b47f:   lda ($3b),y                 ; 747F:  b1 3b
b01_b481:   sbc #$d8                    ; 7481:  e9 d8
b01_b483:   .db $87                     ; 7483:  87
b01_b484:   .db vm_sp_lo                     ; 7484:  02
b01_b485:   .db $b3                     ; 7485:  b3
b01_b486:   .db vm_ip_hi                     ; 7486:  07
b01_b487:   ldy $b6,x                   ; 7487:  b4 b6
b01_b489:   .db $27                     ; 7489:  27
b01_b48a:   .db $0b                     ; 748A:  0b
b01_b48b:   .db music_ptr_lo                     ; 748B:  7a
b01_b48c:   .db $b3                     ; 748C:  b3
b01_b48d:   .db $37                     ; 748D:  37
b01_b48e:   sbc #$7d                    ; 748E:  e9 7d
b01_b490:   dey                         ; 7490:  88
b01_b491:   .db vm_fp_lo                     ; 7491:  04
b01_b492:   .db vm_ip_hi                     ; 7492:  07
b01_b493:   cmp $bc0a                   ; 7493:  cd 0a bc
b01_b496:   rol a                       ; 7496:  2a
b01_b497:   .db $3a                     ; 7497:  3a
b01_b498:   .db $0b                     ; 7498:  0b
b01_b499:   sei                         ; 7499:  78
b01_b49a:   bcs $b44f                   ; 749A:  b0 b3
b01_b49c:   .db $0b                     ; 749C:  0b
b01_b49d:   .db $8f                     ; 749D:  8f
b01_b49e:   clc                         ; 749E:  18
b01_b49f:   bcs $b454                   ; 749F:  b0 b3
b01_b4a1:   ldy $9f                     ; 74A1:  a4 9f
b01_b4a3:   adc $e990                   ; 74A3:  6d 90 e9
b01_b4a6:   sbc $328b,y                 ; 74A6:  f9 8b 32
b01_b4a9:   lda palette_alt,x                   ; 74A9:  b5 90
b01_b4ab:   .db $fa                     ; 74AB:  fa
b01_b4ac:   brk                         ; 74AC:  00
b01_b4ad:   .db $b3                     ; 74AD:  b3
b01_b4ae:   sbc #$5e                    ; 74AE:  e9 5e
b01_b4b0:   .db $cb                     ; 74B0:  cb
b01_b4b1:   .db vm_fp_lo                     ; 74B1:  04
b01_b4b2:   .db $b3                     ; 74B2:  b3
b01_b4b3:   sbc #$e5                    ; 74B3:  e9 e5
b01_b4b5:   .db $8b                     ; 74B5:  8b
b01_b4b6:   asl $26                     ; 74B6:  06 26
b01_b4b8:   rol $0b,x                   ; 74B8:  36 0b
b01_b4ba:   sei                         ; 74BA:  78
b01_b4bb:   ldy $b3,x                   ; 74BB:  b4 b3
b01_b4bd:   bcs $b47a                   ; 74BD:  b0 bb
b01_b4bf:   lda ($36),y                 ; 74BF:  b1 36
b01_b4c1:   .db $3b                     ; 74C1:  3b
b01_b4c2:   sbc #$f0                    ; 74C2:  e9 f0
b01_b4c4:   .db $87                     ; 74C4:  87
b01_b4c5:   .db vm_fp_lo                     ; 74C5:  04
b01_b4c6:   dec $cc,x                   ; 74C6:  d6 cc
b01_b4c8:   ldy $ac,x                   ; 74C8:  b4 ac
b01_b4ca:   cmp #$95                    ; 74CA:  c9 95
b01_b4cc:   tax                         ; 74CC:  aa
b01_b4cd:   .db $5f                     ; 74CD:  5f
b01_b4ce:   .db p2_buttons                     ; 74CE:  6f
b01_b4cf:   sbc #$36                    ; 74CF:  e9 36
b01_b4d1:   cld                         ; 74D1:  d8
b01_b4d2:   .db vm_sp_lo                     ; 74D2:  02
b01_b4d3:   eor ($cf,x)                 ; 74D3:  41 cf
ai_state2_recruit_arm_train:   jsr $e823                   ; 74D5:  20 23 e8
b01_b4d8:   sed                         ; 74D8:  f8
b01_b4d9:   .db $ff                     ; 74D9:  ff
b01_b4da:   ldy $949a                   ; 74DA:  ac 9a 94
b01_b4dd:   cld                         ; 74DD:  d8
b01_b4de:   .db $e2                     ; 74DE:  e2
b01_b4df:   ldy $41,x                   ; 74DF:  b4 41
b01_b4e1:   .db $cf                     ; 74E1:  cf
b01_b4e2:   rti                         ; 74E2:  40
b01_b4e3:   and #$2a                    ; 74E3:  29 2a
b01_b4e5:   dec $fffa,x                 ; 74E5:  de fa ff
b01_b4e8:   .db $b3                     ; 74E8:  b3
b01_b4e9:   dec $fffc,x                 ; 74E9:  de fc ff
b01_b4ec:   .db $b3                     ; 74EC:  b3
b01_b4ed:   sbc #$ef                    ; 74ED:  e9 ef
b01_b4ef:   .db $b2                     ; 74EF:  b2
b01_b4f0:   .db vm_fp_lo                     ; 74F0:  04
b01_b4f1:   ldy $5f                     ; 74F1:  a4 5f
b01_b4f3:   .db p2_buttons                     ; 74F3:  6f
b01_b4f4:   .db $8b                     ; 74F4:  8b
b01_b4f5:   .db $1a                     ; 74F5:  1a
b01_b4f6:   lda $8c,x                   ; 74F6:  b5 8c
b01_b4f8:   ora ($70,x)                 ; 74F8:  01 70
b01_b4fa:   .db $bb                     ; 74FA:  bb
b01_b4fb:   .db $2b                     ; 74FB:  2b
b01_b4fc:   .db $0b                     ; 74FC:  0b
b01_b4fd:   .db $8f                     ; 74FD:  8f
b01_b4fe:   bpl $b4b0                   ; 74FE:  10 b0
b01_b500:   .db $b3                     ; 7500:  b3
b01_b501:   .db $0b                     ; 7501:  0b
b01_b502:   .db $8f                     ; 7502:  8f
b01_b503:   clc                         ; 7503:  18
b01_b504:   bcs $b4b9                   ; 7504:  b0 b3
b01_b506:   ldy $9f                     ; 7506:  a4 9f
b01_b508:   adc $e990                   ; 7508:  6d 90 e9
b01_b50b:   sbc $288b,y                 ; 750B:  f9 8b 28
b01_b50e:   lda $b3,x                   ; 750E:  b5 b3
b01_b510:   sbc #$5e                    ; 7510:  e9 5e
b01_b512:   .db $cb                     ; 7512:  cb
b01_b513:   .db vm_fp_lo                     ; 7513:  04
b01_b514:   ldy $c4,x                   ; 7514:  b4 c4
b01_b516:   cld                         ; 7516:  d8
b01_b517:   adc ($b5),y                 ; 7517:  71 b5
b01_b519:   .db $0b                     ; 7519:  0b
b01_b51a:   .db $8f                     ; 751A:  8f
b01_b51b:   bpl $b4cd                   ; 751B:  10 b0
b01_b51d:   .db $b3                     ; 751D:  b3
b01_b51e:   .db $0b                     ; 751E:  0b
b01_b51f:   .db $8f                     ; 751F:  8f
b01_b520:   clc                         ; 7520:  18
b01_b521:   bcs $b4d6                   ; 7521:  b0 b3
b01_b523:   ldy $9f                     ; 7523:  a4 9f
b01_b525:   adc $e990                   ; 7525:  6d 90 e9
b01_b528:   sbc $648b,y                 ; 7528:  f9 8b 64
b01_b52b:   lda $b3,x                   ; 752B:  b5 b3
b01_b52d:   sbc #$5e                    ; 752D:  e9 5e
b01_b52f:   .db $cb                     ; 752F:  cb
b01_b530:   .db vm_fp_lo                     ; 7530:  04
b01_b531:   ldy $bc,x                   ; 7531:  b4 bc
b01_b533:   .db $b3                     ; 7533:  b3
b01_b534:   tax                         ; 7534:  aa
b01_b535:   ora (p1_buttons),y                 ; 7535:  11 6e
b01_b537:   asl a                       ; 7537:  0a
b01_b538:   .db $52                     ; 7538:  52
b01_b539:   ldx $b3,y                   ; 7539:  b6 b3
b01_b53b:   sbc #$57                    ; 753B:  e9 57
b01_b53d:   .db clock_a_hi                     ; 753D:  83
b01_b53e:   asl $28                     ; 753E:  06 28
b01_b540:   php                         ; 7540:  08
b01_b541:   bvc $b507                   ; 7541:  50 c4
b01_b543:   cld                         ; 7543:  d8
b01_b544:   adc ($b5),y                 ; 7544:  71 b5
b01_b546:   ldy $63                     ; 7546:  a4 63
b01_b548:   adc $b373                   ; 7548:  6d 73 b3
b01_b54b:   ror a                       ; 754B:  6a
b01_b54c:   sbc #$52                    ; 754C:  e9 52
b01_b54e:   dex                         ; 754E:  ca
b01_b54f:   .db vm_sp_lo                     ; 754F:  02
b01_b550:   ldy $c6,x                   ; 7550:  b4 c6
b01_b552:   cld                         ; 7552:  d8
b01_b553:   adc ($b5),y                 ; 7553:  71 b5
b01_b555:   asl a                       ; 7555:  0a
b01_b556:   .db $52                     ; 7556:  52
b01_b557:   ldx $b3,y                   ; 7557:  b6 b3
b01_b559:   .db $0b                     ; 7559:  0b
b01_b55a:   ldy $b3,x                   ; 755A:  b4 b3
b01_b55c:   bcs $b51a                   ; 755C:  b0 bc
b01_b55e:   lda ($38),y                 ; 755E:  b1 38
b01_b560:   .db $3b                     ; 7560:  3b
b01_b561:   sbc #$f4                    ; 7561:  e9 f4
b01_b563:   .db $8b                     ; 7563:  8b
b01_b564:   .db vm_fp_lo                     ; 7564:  04
b01_b565:   dec $fffa,x                 ; 7565:  de fa ff
b01_b568:   .db $b3                     ; 7568:  b3
b01_b569:   dec $fffc,x                 ; 7569:  de fc ff
b01_b56c:   .db $b3                     ; 756C:  b3
b01_b56d:   sbc #$ef                    ; 756D:  e9 ef
b01_b56f:   .db $b2                     ; 756F:  b2
b01_b570:   .db vm_fp_lo                     ; 7570:  04
b01_b571:   .db $0b                     ; 7571:  0b
b01_b572:   .db $8f                     ; 7572:  8f
b01_b573:   bpl $b525                   ; 7573:  10 b0
b01_b575:   .db $b3                     ; 7575:  b3
b01_b576:   ora #$b4                    ; 7576:  09 b4
b01_b578:   ldx $b3,y                   ; 7578:  b6 b3
b01_b57a:   .db $0b                     ; 757A:  0b
b01_b57b:   .db $8f                     ; 757B:  8f
b01_b57c:   .db $12                     ; 757C:  12
b01_b57d:   bcs $b532                   ; 757D:  b0 b3
b01_b57f:   .db $0b                     ; 757F:  0b
b01_b580:   .db $8f                     ; 7580:  8f
b01_b581:   clc                         ; 7581:  18
b01_b582:   bcs $b537                   ; 7582:  b0 b3
b01_b584:   sbc #$e5                    ; 7584:  e9 e5
b01_b586:   .db $8b                     ; 7586:  8b
b01_b587:   asl $28                     ; 7587:  06 28
b01_b589:   sec                         ; 7589:  38
b01_b58a:   .db $0b                     ; 758A:  0b
b01_b58b:   .db $8f                     ; 758B:  8f
b01_b58c:   .db $12                     ; 758C:  12
b01_b58d:   ldy $b3,x                   ; 758D:  b4 b3
b01_b58f:   bcs $b54c                   ; 758F:  b0 bb
b01_b591:   lda ($0b),y                 ; 7591:  b1 0b
b01_b593:   .db $8f                     ; 7593:  8f
b01_b594:   bpl $b546                   ; 7594:  10 b0
b01_b596:   clc                         ; 7596:  18
b01_b597:   lda $b3,x                   ; 7597:  b5 b3
b01_b599:   .db $0b                     ; 7599:  0b
b01_b59a:   ror $b4,x                   ; 759A:  76 b4
b01_b59c:   .db $b3                     ; 759C:  b3
b01_b59d:   bcs $b55b                   ; 759D:  b0 bc
b01_b59f:   lda ($0b),y                 ; 759F:  b1 0b
b01_b5a1:   .db $8f                     ; 75A1:  8f
b01_b5a2:   clc                         ; 75A2:  18
b01_b5a3:   bcs $b558                   ; 75A3:  b0 b3
b01_b5a5:   tax                         ; 75A5:  aa
b01_b5a6:   .db $0f                     ; 75A6:  0f
b01_b5a7:   ror $8f0b                   ; 75A7:  6e 0b 8f
b01_b5aa:   bpl $b55c                   ; 75AA:  10 b0
b01_b5ac:   .db $b3                     ; 75AC:  b3
b01_b5ad:   sbc #$27                    ; 75AD:  e9 27
b01_b5af:   .db clock_a_hi                     ; 75AF:  83
b01_b5b0:   asl $28                     ; 75B0:  06 28
b01_b5b2:   .db $0b                     ; 75B2:  0b
b01_b5b3:   bcs $b5cd                   ; 75B3:  b0 18
b01_b5b5:   cmp $d8                     ; 75B5:  c5 d8
b01_b5b7:   sbc ($b5),y                 ; 75B7:  f1 b5
b01_b5b9:   php                         ; 75B9:  08
b01_b5ba:   .db $8b                     ; 75BA:  8b
b01_b5bb:   .db $ff                     ; 75BB:  ff
b01_b5bc:   cmp ($d8,x)                 ; 75BC:  c1 d8
b01_b5be:   sbc ($b5),y                 ; 75BE:  f1 b5
b01_b5c0:   asl a                       ; 75C0:  0a
b01_b5c1:   clc                         ; 75C1:  18
b01_b5c2:   ldx $28,y                   ; 75C2:  b6 28
b01_b5c4:   cld                         ; 75C4:  d8
b01_b5c5:   sbc ($b5),y                 ; 75C5:  f1 b5
b01_b5c7:   .db $0b                     ; 75C7:  0b
b01_b5c8:   bcs $b57d                   ; 75C8:  b0 b3
b01_b5ca:   tax                         ; 75CA:  aa
b01_b5cb:   .db $0f                     ; 75CB:  0f
b01_b5cc:   ror $e938                   ; 75CC:  6e 38 e9
b01_b5cf:   .db $27                     ; 75CF:  27
b01_b5d0:   .db clock_a_hi                     ; 75D0:  83
b01_b5d1:   asl $b3                     ; 75D1:  06 b3
b01_b5d3:   .db $0b                     ; 75D3:  0b
b01_b5d4:   ldy $b3,x                   ; 75D4:  b4 b3
b01_b5d6:   bcs $b594                   ; 75D6:  b0 bc
b01_b5d8:   lda ($08),y                 ; 75D8:  b1 08
b01_b5da:   .db $d2                     ; 75DA:  d2
b01_b5db:   .db $b3                     ; 75DB:  b3
b01_b5dc:   .db $0b                     ; 75DC:  0b
b01_b5dd:   .db $8f                     ; 75DD:  8f
b01_b5de:   asl $b4,x                   ; 75DE:  16 b4
b01_b5e0:   .db $b3                     ; 75E0:  b3
b01_b5e1:   bcs $b59e                   ; 75E1:  b0 bb
b01_b5e3:   lda ($0b),y                 ; 75E3:  b1 0b
b01_b5e5:   .db $8f                     ; 75E5:  8f
b01_b5e6:   asl $b3,x                   ; 75E6:  16 b3
b01_b5e8:   sbc #$ac                    ; 75E8:  e9 ac
b01_b5ea:   .db $82                     ; 75EA:  82
b01_b5eb:   .db vm_sp_lo                     ; 75EB:  02
b01_b5ec:   .db $63                     ; 75EC:  63
b01_b5ed:   sbc #$4e                    ; 75ED:  e9 4e
b01_b5ef:   txa                         ; 75EF:  8a
b01_b5f0:   .db vm_sp_lo                     ; 75F0:  02
b01_b5f1:   dec $fffa,x                 ; 75F1:  de fa ff
b01_b5f4:   .db $b3                     ; 75F4:  b3
b01_b5f5:   dec $fffc,x                 ; 75F5:  de fc ff
b01_b5f8:   .db $b3                     ; 75F8:  b3
b01_b5f9:   sbc #$ef                    ; 75F9:  e9 ef
b01_b5fb:   .db $b2                     ; 75FB:  b2
b01_b5fc:   .db vm_fp_lo                     ; 75FC:  04
b01_b5fd:   .db $0b                     ; 75FD:  0b
b01_b5fe:   .db $8f                     ; 75FE:  8f
b01_b5ff:   bpl $b5b1                   ; 75FF:  10 b0
b01_b601:   .db $b3                     ; 7601:  b3
b01_b602:   asl a                       ; 7602:  0a
b01_b603:   ldy $b6,x                   ; 7603:  b4 b6
b01_b605:   .db $b3                     ; 7605:  b3
b01_b606:   .db $0b                     ; 7606:  0b
b01_b607:   .db $8f                     ; 7607:  8f
b01_b608:   .db $12                     ; 7608:  12
b01_b609:   bcs $b5be                   ; 7609:  b0 b3
b01_b60b:   .db $0b                     ; 760B:  0b
b01_b60c:   .db $8f                     ; 760C:  8f
b01_b60d:   clc                         ; 760D:  18
b01_b60e:   bcs $b5c3                   ; 760E:  b0 b3
b01_b610:   sbc #$e5                    ; 7610:  e9 e5
b01_b612:   .db $8b                     ; 7612:  8b
b01_b613:   asl $28                     ; 7613:  06 28
b01_b615:   ror a                       ; 7615:  6a
b01_b616:   sbc #$52                    ; 7616:  e9 52
b01_b618:   dex                         ; 7618:  ca
b01_b619:   .db vm_sp_lo                     ; 7619:  02
b01_b61a:   clc                         ; 761A:  18
b01_b61b:   .db $bb                     ; 761B:  bb
b01_b61c:   .db $b3                     ; 761C:  b3
b01_b61d:   .db $0b                     ; 761D:  0b
b01_b61e:   .db $8f                     ; 761E:  8f
b01_b61f:   .db $12                     ; 761F:  12
b01_b620:   ldy $b3,x                   ; 7620:  b4 b3
b01_b622:   bcs $b5df                   ; 7622:  b0 bb
b01_b624:   lda ($0b),y                 ; 7624:  b1 0b
b01_b626:   .db $8f                     ; 7626:  8f
b01_b627:   bpl $b5d9                   ; 7627:  10 b0
b01_b629:   clc                         ; 7629:  18
b01_b62a:   lda $b3,x                   ; 762A:  b5 b3
b01_b62c:   .db $0b                     ; 762C:  0b
b01_b62d:   ldy $b3,x                   ; 762D:  b4 b3
b01_b62f:   bcs $b5ed                   ; 762F:  b0 bc
b01_b631:   lda ($62),y                 ; 7631:  b1 62
b01_b633:   sbc #$52                    ; 7633:  e9 52
b01_b635:   dex                         ; 7635:  ca
b01_b636:   .db vm_sp_lo                     ; 7636:  02
b01_b637:   cld                         ; 7637:  d8
b01_b638:   and $acb6,x                 ; 7638:  3d b6 ac
b01_b63b:   stx $95                     ; 763B:  86 95
b01_b63d:   sta $e964                   ; 763D:  8d 64 e9
b01_b640:   .db $52                     ; 7640:  52
b01_b641:   dex                         ; 7641:  ca
b01_b642:   .db vm_sp_lo                     ; 7642:  02
b01_b643:   .db $d7                     ; 7643:  d7
b01_b644:   eor #$b6                    ; 7644:  49 b6
b01_b646:   ldy $960c                   ; 7646:  ac 0c 96
b01_b649:   rti                         ; 7649:  40
b01_b64a:   .db $cf                     ; 764A:  cf
ai_econ_command_dispatch:   jsr $e823                   ; 764B:  20 23 e8
b01_b64e:   inc $a4ff,x                 ; 764E:  fe ff a4
b01_b651:   .db $5f                     ; 7651:  5f
b01_b652:   .db p2_buttons                     ; 7652:  6f
b01_b653:   .db $8b                     ; 7653:  8b
b01_b654:   .db $1a                     ; 7654:  1a
b01_b655:   lda $8c,x                   ; 7655:  b5 8c
b01_b657:   ora ($70,x)                 ; 7657:  01 70
b01_b659:   .db $bb                     ; 7659:  bb
b01_b65a:   .db $2b                     ; 765A:  2b
b01_b65b:   .db $0b                     ; 765B:  0b
b01_b65c:   ror nmi_skip_all,x                   ; 765C:  76 b0
b01_b65e:   .db $d7                     ; 765E:  d7
b01_b65f:   ror $6ab6                   ; 765F:  6e b6 6a
b01_b662:   sbc #$52                    ; 7662:  e9 52
b01_b664:   dex                         ; 7664:  ca
b01_b665:   .db vm_sp_lo                     ; 7665:  02
b01_b666:   .db $b3                     ; 7666:  b3
b01_b667:   .db $0b                     ; 7667:  0b
b01_b668:   ror $b4,x                   ; 7668:  76 b4
b01_b66a:   .db $b3                     ; 766A:  b3
b01_b66b:   bcs $b628                   ; 766B:  b0 bb
b01_b66d:   lda ($a4),y                 ; 766D:  b1 a4
b01_b66f:   .db $5f                     ; 766F:  5f
b01_b670:   .db p2_buttons                     ; 7670:  6f
b01_b671:   sty fief_is_daimyo_capital                   ; 7671:  8c a2 6d
b01_b674:   .db $bb                     ; 7674:  bb
b01_b675:   .db $d3                     ; 7675:  d3
b01_b676:   cld                         ; 7676:  d8
b01_b677:   stx $b6,y                   ; 7677:  96 b6
b01_b679:   tax                         ; 7679:  aa
b01_b67a:   .db $5f                     ; 767A:  5f
b01_b67b:   .db p2_buttons                     ; 767B:  6f
b01_b67c:   sbc #$8d                    ; 767C:  e9 8d
b01_b67e:   cmp $d702,y                 ; 767E:  d9 02 d7
b01_b681:   stx $b6,y                   ; 7681:  96 b6
b01_b683:   .db $0b                     ; 7683:  0b
b01_b684:   .db $8f                     ; 7684:  8f
b01_b685:   bpl $b637                   ; 7685:  10 b0
b01_b687:   .db $d7                     ; 7687:  d7
b01_b688:   stx $b6,y                   ; 7688:  96 b6
b01_b68a:   .db $0b                     ; 768A:  0b
b01_b68b:   .db $8f                     ; 768B:  8f
b01_b68c:   bpl $b641                   ; 768C:  10 b3
b01_b68e:   .db $42                     ; 768E:  42
b01_b68f:   lda ($0b),y                 ; 768F:  b1 0b
b01_b691:   ror $b3,x                   ; 7691:  76 b3
b01_b693:   bcs $b665                   ; 7693:  b0 d0
b01_b695:   lda ($6a),y                 ; 7695:  b1 6a
b01_b697:   sbc #$52                    ; 7697:  e9 52
b01_b699:   dex                         ; 7699:  ca
b01_b69a:   .db vm_sp_lo                     ; 769A:  02
b01_b69b:   cld                         ; 769B:  d8
b01_b69c:   lda $b6                     ; 769C:  a5 b6
b01_b69e:   ldy $b4d5                   ; 769E:  ac d5 b4
b01_b6a1:   cld                         ; 76A1:  d8
b01_b6a2:   lda $b6                     ; 76A2:  a5 b6
b01_b6a4:   .db $cf                     ; 76A4:  cf
b01_b6a5:   ror a                       ; 76A5:  6a
b01_b6a6:   sbc #$52                    ; 76A6:  e9 52
b01_b6a8:   dex                         ; 76A8:  ca
b01_b6a9:   .db vm_sp_lo                     ; 76A9:  02
b01_b6aa:   cld                         ; 76AA:  d8
b01_b6ab:   bcs $b663                   ; 76AB:  b0 b6
b01_b6ad:   ldy $b3aa                   ; 76AD:  ac aa b3
b01_b6b0:   ldy $b42b                   ; 76B0:  ac 2b b4
b01_b6b3:   .db $cf                     ; 76B3:  cf
command_menu_select_loop:   jsr $e823                   ; 76B4:  20 23 e8
b01_b6b7:   .db $fc                     ; 76B7:  fc
b01_b6b8:   .db $ff                     ; 76B8:  ff
b01_b6b9:   .db brk_scratch_hi                     ; 76B9:  67
b01_b6ba:   sta $e915                   ; 76BA:  8d 15 e9
b01_b6bd:   .db music_ptr_hi                     ; 76BD:  7b
b01_b6be:   cpy $6204                   ; 76BE:  cc 04 62
b01_b6c1:   sbc #$9d                    ; 76C1:  e9 9d
b01_b6c3:   .db $d2                     ; 76C3:  d2
b01_b6c4:   .db vm_sp_lo                     ; 76C4:  02
b01_b6c5:   ldy $d287                   ; 76C5:  ac 87 d2
b01_b6c8:   ldy $e2                     ; 76C8:  a4 e2
b01_b6ca:   .db music_ptr_hi                     ; 76CA:  7b
b01_b6cb:   cld                         ; 76CB:  d8
b01_b6cc:   .db $d2                     ; 76CC:  d2
b01_b6cd:   ldx $4c,y                   ; 76CD:  b6 4c
b01_b6cf:   dec $d3,x                   ; 76CF:  d6 d3
b01_b6d1:   ldx $40,y                   ; 76D1:  b6 40
b01_b6d3:   rol a                       ; 76D3:  2a
b01_b6d4:   rti                         ; 76D4:  40
b01_b6d5:   .db $2b                     ; 76D5:  2b
b01_b6d6:   ldy $d14e                   ; 76D6:  ac 4e d1
b01_b6d9:   cmp vm_ip_lo,y                 ; 76D9:  d9 06 00
b01_b6dc:   ora (scratch_ptr_lo,x)                 ; 76DC:  01 00
b01_b6de:   sbc $02b6,y                 ; 76DE:  f9 b6 02
b01_b6e1:   brk                         ; 76E1:  00
b01_b6e2:   inc $b6,x                   ; 76E2:  f6 b6
b01_b6e4:   bpl $b6e6                   ; 76E4:  10 00
b01_b6e6:   eor $20b7,x                 ; 76E6:  5d b7 20
b01_b6e9:   brk                         ; 76E9:  00
b01_b6ea:   .db prg_bank_shadow                     ; 76EA:  73
b01_b6eb:   .db $b7                     ; 76EB:  b7
b01_b6ec:   rti                         ; 76EC:  40
b01_b6ed:   brk                         ; 76ED:  00
b01_b6ee:   ora #$b7                    ; 76EE:  09 b7
b01_b6f0:   .db skip_vblank_wait                     ; 76F0:  80
b01_b6f1:   brk                         ; 76F1:  00
b01_b6f2:   ora #$b7                    ; 76F2:  09 b7
b01_b6f4:   .db vm_sp_hi                     ; 76F4:  03
b01_b6f5:   .db $b7                     ; 76F5:  b7
b01_b6f6:   .db skip_wallclock                     ; 76F6:  89
b01_b6f7:   ora ($2a),y                 ; 76F7:  11 2a
b01_b6f9:   rts                         ; 76F9:  60
b01_b6fa:   sbc #$9d                    ; 76FA:  e9 9d
b01_b6fc:   .db $d2                     ; 76FC:  d2
b01_b6fd:   .db vm_sp_lo                     ; 76FD:  02
b01_b6fe:   eor ($2b,x)                 ; 76FE:  41 2b
b01_b700:   ldy $cc89                   ; 7700:  ac 89 cc
b01_b703:   .db $0b                     ; 7703:  0b
b01_b704:   cld                         ; 7704:  d8
b01_b705:   dec $b6,x                   ; 7705:  d6 b6
b01_b707:   asl a                       ; 7707:  0a
b01_b708:   .db $cf                     ; 7708:  cf
b01_b709:   rts                         ; 7709:  60
b01_b70a:   sbc #$9d                    ; 770A:  e9 9d
b01_b70c:   .db $d2                     ; 770C:  d2
b01_b70d:   .db vm_sp_lo                     ; 770D:  02
b01_b70e:   ldy $e2                     ; 770E:  a4 e2
b01_b710:   .db music_ptr_hi                     ; 7710:  7b
b01_b711:   .db $d7                     ; 7711:  d7
b01_b712:   bit $b7                     ; 7712:  24 b7
b01_b714:   adc ($e9,x)                 ; 7714:  61 e9
b01_b716:   asl $0287,x                 ; 7716:  1e 87 02
b01_b719:   .db brk_scratch_hi                     ; 7719:  67
b01_b71a:   sta $e915                   ; 771A:  8d 15 e9
b01_b71d:   .db music_ptr_hi                     ; 771D:  7b
b01_b71e:   cpy $4c04                   ; 771E:  cc 04 4c
b01_b721:   dec $4f,x                   ; 7721:  d6 4f
b01_b723:   .db $b7                     ; 7723:  b7
b01_b724:   rts                         ; 7724:  60
b01_b725:   sbc #$1e                    ; 7725:  e9 1e
b01_b727:   .db $87                     ; 7727:  87
b01_b728:   .db vm_sp_lo                     ; 7728:  02
b01_b729:   .db brk_scratch_hi                     ; 7729:  67
b01_b72a:   sta $e915                   ; 772A:  8d 15 e9
b01_b72d:   .db music_ptr_hi                     ; 772D:  7b
b01_b72e:   cpy $4004                   ; 772E:  cc 04 40
b01_b731:   dec $4f,x                   ; 7731:  d6 4f
b01_b733:   .db $b7                     ; 7733:  b7
b01_b734:   ldy $e2                     ; 7734:  a4 e2
b01_b736:   .db music_ptr_hi                     ; 7736:  7b
b01_b737:   .db $d7                     ; 7737:  d7
b01_b738:   lsr $b7                     ; 7738:  46 b7
b01_b73a:   sta $8d12                   ; 773A:  8d 12 8d
b01_b73d:   ora $e9,x                   ; 773D:  15 e9
b01_b73f:   .db music_ptr_hi                     ; 773F:  7b
b01_b740:   cpy $4b04                   ; 7740:  cc 04 4b
b01_b743:   dec $4f,x                   ; 7743:  d6 4f
b01_b745:   .db $b7                     ; 7745:  b7
b01_b746:   .db p2_buttons                     ; 7746:  6f
b01_b747:   sta $e915                   ; 7747:  8d 15 e9
b01_b74a:   .db music_ptr_hi                     ; 774A:  7b
b01_b74b:   cpy $8904                   ; 774B:  cc 04 89
b01_b74e:   .db $14                     ; 774E:  14
b01_b74f:   rol a                       ; 774F:  2a
b01_b750:   .db $62                     ; 7750:  62
b01_b751:   sbc #$9d                    ; 7751:  e9 9d
b01_b753:   .db $d2                     ; 7753:  d2
b01_b754:   .db vm_sp_lo                     ; 7754:  02
b01_b755:   .db $62                     ; 7755:  62
b01_b756:   sbc #$3e                    ; 7756:  e9 3e
b01_b758:   .db $d7                     ; 7758:  d7
b01_b759:   .db vm_sp_lo                     ; 7759:  02
b01_b75a:   dec vm_sp_hi,x                   ; 775A:  d6 03
b01_b75c:   .db $b7                     ; 775C:  b7
b01_b75d:   rts                         ; 775D:  60
b01_b75e:   sbc #$9d                    ; 775E:  e9 9d
b01_b760:   .db $d2                     ; 7760:  d2
b01_b761:   .db vm_sp_lo                     ; 7761:  02
b01_b762:   ldy $cf                     ; 7762:  a4 cf
b01_b764:   .db $7f                     ; 7764:  7f
b01_b765:   cmp ($a8),y                 ; 7765:  d1 a8
b01_b767:   .db $cf                     ; 7767:  cf
b01_b768:   .db $7f                     ; 7768:  7f
b01_b769:   lsr $c0,x                   ; 7769:  56 c0
b01_b76b:   .db $d7                     ; 776B:  d7
b01_b76c:   .db $34                     ; 776C:  34
b01_b76d:   .db $b7                     ; 776D:  b7
b01_b76e:   asl a                       ; 776E:  0a
b01_b76f:   cmp ($d6),y                 ; 776F:  d1 d6
b01_b771:   .db $4f                     ; 7771:  4f
b01_b772:   .db $b7                     ; 7772:  b7
b01_b773:   rts                         ; 7773:  60
b01_b774:   sbc #$9d                    ; 7774:  e9 9d
b01_b776:   .db $d2                     ; 7776:  d2
b01_b777:   .db vm_sp_lo                     ; 7777:  02
b01_b778:   ldy $cf                     ; 7778:  a4 cf
b01_b77a:   .db $7f                     ; 777A:  7f
b01_b77b:   bne $b725                   ; 777B:  d0 a8
b01_b77d:   .db $cf                     ; 777D:  cf
b01_b77e:   .db $7f                     ; 777E:  7f
b01_b77f:   .db $8b                     ; 777F:  8b
b01_b780:   .db $13                     ; 7780:  13
b01_b781:   cpy #$d7                    ; 7781:  c0 d7
b01_b783:   and #$b7                    ; 7783:  29 b7
b01_b785:   ldy $cf                     ; 7785:  a4 cf
b01_b787:   .db $7f                     ; 7787:  7f
b01_b788:   .db $8b                     ; 7788:  8b
b01_b789:   bpl $b74b                   ; 7789:  10 c0
b01_b78b:   cld                         ; 778B:  d8
b01_b78c:   stx $b7,y                   ; 778C:  96 b7
b01_b78e:   ldy $e2                     ; 778E:  a4 e2
b01_b790:   .db music_ptr_hi                     ; 7790:  7b
b01_b791:   eor ($c0),y                 ; 7791:  51 c0
b01_b793:   .db $d7                     ; 7793:  d7
b01_b794:   ora $0ab7,y                 ; 7794:  19 b7 0a
b01_b797:   bne $b76f                   ; 7797:  d0 d6
b01_b799:   .db $4f                     ; 7799:  4f
b01_b79a:   .db $b7                     ; 779A:  b7
issue_province_command:   jsr $e823                   ; 779B:  20 23 e8
b01_b79e:   beq $b79f                   ; 779E:  f0 ff
b01_b7a0:   ldy $5f                     ; 77A0:  a4 5f
b01_b7a2:   .db p2_buttons                     ; 77A2:  6f
b01_b7a3:   tay                         ; 77A3:  a8
b01_b7a4:   cmp $3c7f,x                 ; 77A4:  dd 7f 3c
b01_b7a7:   sbc #$72                    ; 77A7:  e9 72
b01_b7a9:   .db $d7                     ; 77A9:  d7
b01_b7aa:   .db vm_sp_lo                     ; 77AA:  02
b01_b7ab:   sty rest_turns_remaining                   ; 77AB:  8c 67 6d
b01_b7ae:   .db $bb                     ; 77AE:  bb
b01_b7af:   plp                         ; 77AF:  28
b01_b7b0:   php                         ; 77B0:  08
b01_b7b1:   .db $d3                     ; 77B1:  d3
b01_b7b2:   cld                         ; 77B2:  d8
b01_b7b3:   .db $da                     ; 77B3:  da
b01_b7b4:   .db $b7                     ; 77B4:  b7
b01_b7b5:   .db $0c                     ; 77B5:  0c
b01_b7b6:   sty fief_is_daimyo_capital                   ; 77B6:  8c a2 6d
b01_b7b9:   .db $bb                     ; 77B9:  bb
b01_b7ba:   .db $d3                     ; 77BA:  d3
b01_b7bb:   cld                         ; 77BB:  d8
b01_b7bc:   .db palette_dirty                     ; 77BC:  74
b01_b7bd:   clv                         ; 77BD:  b8
b01_b7be:   .db $3c                     ; 77BE:  3c
b01_b7bf:   sbc #$fa                    ; 77BF:  e9 fa
b01_b7c1:   .db clock_a_hi                     ; 77C1:  83
b01_b7c2:   .db vm_sp_lo                     ; 77C2:  02
b01_b7c3:   ldy $d759                   ; 77C3:  ac 59 d7
b01_b7c6:   php                         ; 77C6:  08
b01_b7c7:   .db $b3                     ; 77C7:  b3
b01_b7c8:   .db $d3                     ; 77C8:  d3
b01_b7c9:   cmp ($d4),y                 ; 77C9:  d1 d4
b01_b7cb:   .db $64                     ; 77CB:  64
b01_b7cc:   .db $3c                     ; 77CC:  3c
b01_b7cd:   sbc #$da                    ; 77CD:  e9 da
b01_b7cf:   .db $d7                     ; 77CF:  d7
b01_b7d0:   .db vm_sp_lo                     ; 77D0:  02
b01_b7d1:   bne $b787                   ; 77D1:  d0 b4
b01_b7d3:   .db $b3                     ; 77D3:  b3
b01_b7d4:   .db $d3                     ; 77D4:  d3
b01_b7d5:   .db $bb                     ; 77D5:  bb
b01_b7d6:   .db $d4                     ; 77D6:  d4
b01_b7d7:   dec palette_dirty,x                   ; 77D7:  d6 74
b01_b7d9:   clv                         ; 77D9:  b8
b01_b7da:   ldy $85a7                   ; 77DA:  ac a7 85
b01_b7dd:   sta $e91b                   ; 77DD:  8d 1b e9
b01_b7e0:   .db vm_sp_hi                     ; 77E0:  03
b01_b7e1:   dex                         ; 77E1:  ca
b01_b7e2:   .db vm_sp_lo                     ; 77E2:  02
b01_b7e3:   rti                         ; 77E3:  40
b01_b7e4:   .db $27                     ; 77E4:  27
b01_b7e5:   dec $10,x                   ; 77E5:  d6 10
b01_b7e7:   clv                         ; 77E7:  b8
b01_b7e8:   .db vm_ip_hi                     ; 77E8:  07
b01_b7e9:   .db $8b                     ; 77E9:  8b
b01_b7ea:   ora ($c0),y                 ; 77EA:  11 c0
b01_b7ec:   cld                         ; 77EC:  d8
b01_b7ed:   .db $f2                     ; 77ED:  f2
b01_b7ee:   .db $b7                     ; 77EE:  b7
b01_b7ef:   ldy $85a7                   ; 77EF:  ac a7 85
b01_b7f2:   ldy $cc89                   ; 77F2:  ac 89 cc
b01_b7f5:   tax                         ; 77F5:  aa
b01_b7f6:   .db $5f                     ; 77F6:  5f
b01_b7f7:   .db p2_buttons                     ; 77F7:  6f
b01_b7f8:   sbc #$8b                    ; 77F8:  e9 8b
b01_b7fa:   .db $d7                     ; 77FA:  d7
b01_b7fb:   .db vm_sp_lo                     ; 77FB:  02
b01_b7fc:   stx $bf91                   ; 77FC:  8e 91 bf
b01_b7ff:   sbc #$c4                    ; 77FF:  e9 c4
b01_b801:   dec $ac02                   ; 7801:  ce 02 ac
b01_b804:   ldy $b6,x                   ; 7804:  b4 b6
b01_b806:   .db $27                     ; 7806:  27
b01_b807:   .db $d2                     ; 7807:  d2
b01_b808:   sty $b9b2                   ; 7808:  8c b2 b9
b01_b80b:   .db $bb                     ; 780B:  bb
b01_b80c:   bcs $b833                   ; 780C:  b0 25
b01_b80e:   ora $dd                     ; 780E:  05 dd
b01_b810:   rol vm_ip_lo                     ; 7810:  26 06
b01_b812:   cld                         ; 7812:  d8
b01_b813:   inx                         ; 7813:  e8
b01_b814:   .db $b7                     ; 7814:  b7
b01_b815:   .db vm_ip_hi                     ; 7815:  07
b01_b816:   eor ($c0),y                 ; 7816:  51 c0
b01_b818:   .db $d7                     ; 7818:  d7
b01_b819:   .db palette_dirty                     ; 7819:  74
b01_b81a:   clv                         ; 781A:  b8
b01_b81b:   .db vm_ip_hi                     ; 781B:  07
b01_b81c:   .db $8b                     ; 781C:  8b
b01_b81d:   .db $14                     ; 781D:  14
b01_b81e:   cpy #$d7                    ; 781E:  c0 d7
b01_b820:   .db palette_dirty                     ; 7820:  74
b01_b821:   clv                         ; 7821:  b8
b01_b822:   .db $3c                     ; 7822:  3c
b01_b823:   sbc #$36                    ; 7823:  e9 36
b01_b825:   cld                         ; 7825:  d8
b01_b826:   .db vm_sp_lo                     ; 7826:  02
b01_b827:   .db $3c                     ; 7827:  3c
b01_b828:   sbc #$da                    ; 7828:  e9 da
b01_b82a:   .db $d7                     ; 782A:  d7
b01_b82b:   .db vm_sp_lo                     ; 782B:  02
b01_b82c:   rol a                       ; 782C:  2a
b01_b82d:   .db $0c                     ; 782D:  0c
b01_b82e:   .db $8b                     ; 782E:  8b
b01_b82f:   .db $1a                     ; 782F:  1a
b01_b830:   lda $8c,x                   ; 7830:  b5 8c
b01_b832:   ora ($70,x)                 ; 7832:  01 70
b01_b834:   .db $bb                     ; 7834:  bb
b01_b835:   bit $29                     ; 7835:  24 29
b01_b837:   rti                         ; 7837:  40
b01_b838:   .db $2b                     ; 7838:  2b
b01_b839:   .db $0b                     ; 7839:  0b
b01_b83a:   lsr $c6,x                   ; 783A:  56 c6
b01_b83c:   cld                         ; 783C:  d8
b01_b83d:   eor $b8,x                   ; 783D:  55 b8
b01_b83f:   .db $0b                     ; 783F:  0b
b01_b840:   adc $66b3,x                 ; 7840:  7d b3 66
b01_b843:   sbc #$7b                    ; 7843:  e9 7b
b01_b845:   cpy $0a04                   ; 7845:  cc 04 0a
b01_b848:   bne $b874                   ; 7848:  d0 2a
b01_b84a:   cmp ($d3),y                 ; 784A:  d1 d3
b01_b84c:   .db $b3                     ; 784C:  b3
b01_b84d:   .db $3c                     ; 784D:  3c
b01_b84e:   sbc #$d5                    ; 784E:  e9 d5
b01_b850:   .db clock_a_hi                     ; 7850:  83
b01_b851:   .db vm_fp_lo                     ; 7851:  04
b01_b852:   dec $6a,x                   ; 7852:  d6 6a
b01_b854:   clv                         ; 7854:  b8
b01_b855:   .db $0b                     ; 7855:  0b
b01_b856:   bne $b80b                   ; 7856:  d0 b3
b01_b858:   sta $e910                   ; 7858:  8d 10 e9
b01_b85b:   .db music_ptr_hi                     ; 785B:  7b
b01_b85c:   cpy $0904                   ; 785C:  cc 04 09
b01_b85f:   .db ppumask_shadow                     ; 785F:  72
b01_b860:   and #$8f                    ; 7860:  29 8f
b01_b862:   inc $b3b0,x                 ; 7862:  fe b0 b3
b01_b865:   .db $3c                     ; 7865:  3c
b01_b866:   sbc #$a2                    ; 7866:  e9 a2
b01_b868:   .db clock_a_hi                     ; 7868:  83
b01_b869:   .db vm_fp_lo                     ; 7869:  04
b01_b86a:   .db $0b                     ; 786A:  0b
b01_b86b:   bne $b898                   ; 786B:  d0 2b
b01_b86d:   .db $0b                     ; 786D:  0b
b01_b86e:   .db $8b                     ; 786E:  8b
b01_b86f:   .db $12                     ; 786F:  12
b01_b870:   dec $d7                     ; 7870:  c6 d7
b01_b872:   and $cfb8,y                 ; 7872:  39 b8 cf
ai_econ_action_state0:   jsr $e823                   ; 7875:  20 23 e8
b01_b878:   inc $acff,x                 ; 7878:  fe ff ac
b01_b87b:   .db $4b                     ; 787B:  4b
b01_b87c:   ldx $ac,y                   ; 787C:  b6 ac
b01_b87e:   pla                         ; 787E:  68
b01_b87f:   sty $5fa4                   ; 787F:  8c a4 5f
b01_b882:   .db p2_buttons                     ; 7882:  6f
b01_b883:   .db $8b                     ; 7883:  8b
b01_b884:   .db $1a                     ; 7884:  1a
b01_b885:   lda $8c,x                   ; 7885:  b5 8c
b01_b887:   ora ($70,x)                 ; 7887:  01 70
b01_b889:   .db $bb                     ; 7889:  bb
b01_b88a:   .db $2b                     ; 788A:  2b
b01_b88b:   .db $64                     ; 788B:  64
b01_b88c:   sbc #$52                    ; 788C:  e9 52
b01_b88e:   dex                         ; 788E:  ca
b01_b88f:   .db vm_sp_lo                     ; 788F:  02
b01_b890:   .db $d7                     ; 7890:  d7
b01_b891:   txs                         ; 7891:  9a
b01_b892:   clv                         ; 7892:  b8
b01_b893:   .db $0b                     ; 7893:  0b
b01_b894:   .db $8f                     ; 7894:  8f
b01_b895:   asl $b3,x                   ; 7895:  16 b3
b01_b897:   bcs $b869                   ; 7897:  b0 d0
b01_b899:   lda ($cf),y                 ; 7899:  b1 cf
ai_per_fief_command_driver:   jsr $e823                   ; 789B:  20 23 e8
b01_b89e:   .db $fc                     ; 789E:  fc
b01_b89f:   .db $ff                     ; 789F:  ff
b01_b8a0:   eor ($a8,x)                 ; 78A0:  41 a8
b01_b8a2:   .db $d3                     ; 78A2:  d3
b01_b8a3:   .db $7f                     ; 78A3:  7f
b01_b8a4:   ldy scratch_ptr_hi                     ; 78A4:  a4 01
b01_b8a6:   rts                         ; 78A6:  60
b01_b8a7:   dec $9e,x                   ; 78A7:  d6 9e
b01_b8a9:   lda $fe89,y                 ; 78A9:  b9 89 fe
b01_b8ac:   cmp $a1a5                   ; 78AC:  cd a5 a1
b01_b8af:   adc $a9da                   ; 78AF:  6d da a9
b01_b8b2:   lda ($6d,x)                 ; 78B2:  a1 6d
b01_b8b4:   ldy $63                     ; 78B4:  a4 63
b01_b8b6:   adc $b555                   ; 78B6:  6d 55 b5
b01_b8b9:   .db $b3                     ; 78B9:  b3
b01_b8ba:   .db skip_wallclock                     ; 78BA:  89
b01_b8bb:   .db $37                     ; 78BB:  37
b01_b8bc:   ldy $bc,x                   ; 78BC:  b4 bc
b01_b8be:   .db $b3                     ; 78BE:  b3
b01_b8bf:   sta $e964                   ; 78BF:  8d 64 e9
b01_b8c2:   .db $52                     ; 78C2:  52
b01_b8c3:   dex                         ; 78C3:  ca
b01_b8c4:   .db vm_sp_lo                     ; 78C4:  02
b01_b8c5:   ldy $c6,x                   ; 78C5:  b4 c6
b01_b8c7:   cmp $a1a5                   ; 78C7:  cd a5 a1
b01_b8ca:   adc $a9db                   ; 78CA:  6d db a9
b01_b8cd:   lda ($6d,x)                 ; 78CD:  a1 6d
b01_b8cf:   tax                         ; 78CF:  aa
b01_b8d0:   .db $5f                     ; 78D0:  5f
b01_b8d1:   .db p2_buttons                     ; 78D1:  6f
b01_b8d2:   sbc #$72                    ; 78D2:  e9 72
b01_b8d4:   cmp $d802,y                 ; 78D4:  d9 02 d8
b01_b8d7:   inc $64b8                   ; 78D7:  ee b8 64
b01_b8da:   sbc #$52                    ; 78DA:  e9 52
b01_b8dc:   dex                         ; 78DC:  ca
b01_b8dd:   .db vm_sp_lo                     ; 78DD:  02
b01_b8de:   .db $d7                     ; 78DE:  d7
b01_b8df:   sbc $b8                     ; 78DF:  e5 b8
b01_b8e1:   eor ($d6,x)                 ; 78E1:  41 d6
b01_b8e3:   inc $b8                     ; 78E3:  e6 b8
b01_b8e5:   rti                         ; 78E5:  40
b01_b8e6:   cmp $a1a5                   ; 78E6:  cd a5 a1
b01_b8e9:   adc $a9db                   ; 78E9:  6d db a9
b01_b8ec:   lda ($6d,x)                 ; 78EC:  a1 6d
b01_b8ee:   ldy $d628                   ; 78EE:  ac 28 d6
b01_b8f1:   .db $d7                     ; 78F1:  d7
b01_b8f2:   .db $fa                     ; 78F2:  fa
b01_b8f3:   clv                         ; 78F3:  b8
b01_b8f4:   ldy $d982                   ; 78F4:  ac 82 d9
b01_b8f7:   cld                         ; 78F7:  d8
b01_b8f8:   asl $89b9                   ; 78F8:  0e b9 89
b01_b8fb:   .db skip_vblank_wait                     ; 78FB:  80
b01_b8fc:   cmp $a1a5                   ; 78FC:  cd a5 a1
b01_b8ff:   adc $a9db                   ; 78FF:  6d db a9
b01_b902:   lda ($6d,x)                 ; 7902:  a1 6d
b01_b904:   ldy $d628                   ; 7904:  ac 28 d6
b01_b907:   cld                         ; 7907:  d8
b01_b908:   ora $acb9                   ; 7908:  0d b9 ac
b01_b90b:   ora #$d6                    ; 790B:  09 d6
b01_b90d:   .db $cf                     ; 790D:  cf
b01_b90e:   rti                         ; 790E:  40
b01_b90f:   tay                         ; 790F:  a8
b01_b910:   adc $0b6f,y                 ; 7910:  79 6f 0b
b01_b913:   sty daimyo_turn_order                   ; 7913:  8c 1b 6f
b01_b916:   .db $bb                     ; 7916:  bb
b01_b917:   .db $d3                     ; 7917:  d3
b01_b918:   tay                         ; 7918:  a8
b01_b919:   .db $5f                     ; 7919:  5f
b01_b91a:   .db p2_buttons                     ; 791A:  6f
b01_b91b:   rol a                       ; 791B:  2a
b01_b91c:   sta $621a                   ; 791C:  8d 1a 62
b01_b91f:   sbc #$7b                    ; 791F:  e9 7b
b01_b921:   cpy $0a04                   ; 7921:  cc 04 0a
b01_b924:   bne $b8d9                   ; 7924:  d0 b3
b01_b926:   .db $0b                     ; 7926:  0b
b01_b927:   bne $b8dc                   ; 7927:  d0 b3
b01_b929:   stx $bf9f                   ; 7929:  8e 9f bf
b01_b92c:   sbc #$34                    ; 792C:  e9 34
b01_b92e:   cmp (vm_ip_lo),y                 ; 792E:  d1 06
b01_b930:   ldy $f9                     ; 7930:  a4 f9
b01_b932:   .db music_ptr_hi                     ; 7932:  7b
b01_b933:   .db $d7                     ; 7933:  d7
b01_b934:   and $acb9,y                 ; 7934:  39 b9 ac
b01_b937:   sty skip_vblank_wait,x                   ; 7937:  94 80
b01_b939:   .db $3a                     ; 7939:  3a
b01_b93a:   sbc #$72                    ; 793A:  e9 72
b01_b93c:   .db $d7                     ; 793C:  d7
b01_b93d:   .db vm_sp_lo                     ; 793D:  02
b01_b93e:   sty rest_turns_remaining                   ; 793E:  8c 67 6d
b01_b941:   .db $bb                     ; 7941:  bb
b01_b942:   .db $d3                     ; 7942:  d3
b01_b943:   .db $d7                     ; 7943:  d7
b01_b944:   adc $0ab9,x                 ; 7944:  7d b9 0a
b01_b947:   sty province_ai_state                   ; 7947:  8c f7 6c
b01_b94a:   .db $bb                     ; 794A:  bb
b01_b94b:   .db $d3                     ; 794B:  d3
b01_b94c:   cmp scratch_ptr_lo,x                   ; 794C:  d5 00
b01_b94e:   brk                         ; 794E:  00
b01_b94f:   asl scratch_ptr_lo                     ; 794F:  06 00
b01_b951:   sta $5fb9                   ; 7951:  8d b9 5f
b01_b954:   lda $b965,y                 ; 7954:  b9 65 b9
b01_b957:   .db $6b                     ; 7957:  6b
b01_b958:   lda $b971,y                 ; 7958:  b9 71 b9
b01_b95b:   .db $77                     ; 795B:  77
b01_b95c:   lda $b988,y                 ; 795C:  b9 88 b9
b01_b95f:   ldy $b875                   ; 795F:  ac 75 b8
b01_b962:   dec $8d,x                   ; 7962:  d6 8d
b01_b964:   lda $aaac,y                 ; 7964:  b9 ac aa
b01_b967:   .db $b3                     ; 7967:  b3
b01_b968:   dec $8d,x                   ; 7968:  d6 8d
b01_b96a:   lda $d5ac,y                 ; 796A:  b9 ac d5
b01_b96d:   ldy $d6,x                   ; 796D:  b4 d6
b01_b96f:   sta $acb9                   ; 796F:  8d b9 ac
b01_b972:   .db $4b                     ; 7972:  4b
b01_b973:   ldx $d6,y                   ; 7973:  b6 d6
b01_b975:   sta $acb9                   ; 7975:  8d b9 ac
b01_b978:   .db $2b                     ; 7978:  2b
b01_b979:   ldy $d6,x                   ; 7979:  b4 d6
b01_b97b:   sta $0ab9                   ; 797B:  8d b9 0a
b01_b97e:   sty province_ai_state                   ; 797E:  8c f7 6c
b01_b981:   .db $bb                     ; 7981:  bb
b01_b982:   .db $d3                     ; 7982:  d3
b01_b983:   eor $c0,x                   ; 7983:  55 c0
b01_b985:   cld                         ; 7985:  d8
b01_b986:   sta $3ab9                   ; 7986:  8d b9 3a
b01_b989:   sbc #$9b                    ; 7989:  e9 9b
b01_b98b:   .db $b7                     ; 798B:  b7
b01_b98c:   .db vm_sp_lo                     ; 798C:  02
b01_b98d:   ldy music_voice_idx                     ; 798D:  a4 79
b01_b98f:   .db p2_buttons                     ; 798F:  6f
b01_b990:   cld                         ; 7990:  d8
b01_b991:   .db $9c                     ; 7991:  9c
b01_b992:   lda $d00b,y                 ; 7992:  b9 0b d0
b01_b995:   .db $2b                     ; 7995:  2b
b01_b996:   tay                         ; 7996:  a8
b01_b997:   ora ($60,x)                 ; 7997:  01 60
b01_b999:   dec $a7,x                   ; 7999:  d6 a7
b01_b99b:   lda $d00b,y                 ; 799B:  b9 0b d0
b01_b99e:   .db $2b                     ; 799E:  2b
b01_b99f:   .db $0b                     ; 799F:  0b
b01_b9a0:   ldx $9d                     ; 79A0:  a6 9d
b01_b9a2:   adc $d7c6                   ; 79A2:  6d c6 d7
b01_b9a5:   tax                         ; 79A5:  aa
b01_b9a6:   clv                         ; 79A6:  b8
b01_b9a7:   ldy music_voice_idx                     ; 79A7:  a4 79
b01_b9a9:   .db p2_buttons                     ; 79A9:  6f
b01_b9aa:   .db $d7                     ; 79AA:  d7
b01_b9ab:   lda ($b9),y                 ; 79AB:  b1 b9
b01_b9ad:   rti                         ; 79AD:  40
b01_b9ae:   tay                         ; 79AE:  a8
b01_b9af:   ora ($60,x)                 ; 79AF:  01 60
b01_b9b1:   .db $cf                     ; 79B1:  cf
command_driver_table:   cmp ($96),y                 ; 79B2:  d1 96
b01_b9b4:   bvc $b94e                   ; 79B4:  50 98
b01_b9b6:   txs                         ; 79B6:  9a
b01_b9b7:   sta $9a5d,y                 ; 79B7:  99 5d 9a
b01_b9ba:   ror $4f9b,x                 ; 79BA:  7e 9b 4f
b01_b9bd:   .db $9c                     ; 79BD:  9c
b01_b9be:   and $c49d,x                 ; 79BE:  3d 9d c4
b01_b9c1:   sta $a1b6,x                 ; 79C1:  9d b6 a1
b01_b9c4:   .db $f4                     ; 79C4:  f4
b01_b9c5:   lda $37                     ; 79C5:  a5 37
b01_b9c7:   ldx $c7                     ; 79C7:  a6 c7
b01_b9c9:   ldx $53                     ; 79C9:  a6 53
b01_b9cb:   tay                         ; 79CB:  a8
b01_b9cc:   .db ppu_queue_b_hi                     ; 79CC:  1f
b01_b9cd:   tax                         ; 79CD:  aa
b01_b9ce:   ldx $67aa                   ; 79CE:  ae aa 67
b01_b9d1:   lda $adb3                   ; 79D1:  ad b3 ad
b01_b9d4:   sec                         ; 79D4:  38
b01_b9d5:   .db $af                     ; 79D5:  af
b01_b9d6:   ror $af                     ; 79D6:  66 af
b01_b9d8:   rol $a1b2,x                 ; 79D8:  3e b2 a1
b01_b9db:   .db $b2                     ; 79DB:  b2
jumptab_b9dc:   .db vm_fp_lo                     ; 79DC:  04
b01_b9dd:   .db $9f                     ; 79DD:  9f
b01_b9de:   .db $af                     ; 79DE:  af
b01_b9df:   .db $9f                     ; 79DF:  9f
b01_b9e0:   .db vm_sp_hi                     ; 79E0:  03
b01_b9e1:   ldy #$68                    ; 79E1:  a0 68
b01_b9e3:   ldy #$13                    ; 79E3:  a0 13
b01_b9e5:   lda ($af,x)                 ; 79E5:  a1 af
b01_b9e7:   lda (brk_scratch_lo,x)                 ; 79E7:  a1 66
b01_b9e9:   bcs $b988                   ; 79E9:  b0 9d
b01_b9eb:   bcs $b9bf                   ; 79EB:  b0 d2
b01_b9ed:   bcs $b9f8                   ; 79ED:  b0 09
b01_b9ef:   lda ($2b),y                 ; 79EF:  b1 2b
b01_b9f1:   lda ($4b),y                 ; 79F1:  b1 4b
b01_b9f3:   lda ($af),y                 ; 79F3:  b1 af
b01_b9f5:   lda ($25,x)                 ; 79F5:  a1 25
b01_b9f7:   .db prg_bank_shadow                     ; 79F7:  73
b01_b9f8:   and prg_bank_shadow                     ; 79F8:  25 73
b01_b9fa:   and prg_bank_shadow                     ; 79FA:  25 73
b01_b9fc:   brk                         ; 79FC:  00
msg_attack:   eor (palette_dirty,x)                 ; 79FD:  41 74
b01_b9ff:   .db palette_dirty                     ; 79FF:  74
b01_ba00:   adc ($63,x)                 ; 7A00:  61 63
b01_ba02:   .db $6b                     ; 7A02:  6b
b01_ba03:   brk                         ; 7A03:  00
b01_ba04:   brk                         ; 7A04:  00
b01_ba05:   brk                         ; 7A05:  00
b01_ba06:   brk                         ; 7A06:  00
b01_ba07:   brk                         ; 7A07:  00
b01_ba08:   brk                         ; 7A08:  00
b01_ba09:   brk                         ; 7A09:  00
b01_ba0a:   brk                         ; 7A0A:  00
b01_ba0b:   brk                         ; 7A0B:  00
b01_ba0c:   brk                         ; 7A0C:  00
b01_ba0d:   brk                         ; 7A0D:  00
b01_ba0e:   brk                         ; 7A0E:  00
b01_ba0f:   brk                         ; 7A0F:  00
str_market_panel_nl2:   brk                         ; 7A10:  00
str_market_panel_nl1:   brk                         ; 7A11:  00
str_market_panel:   asl a                       ; 7A12:  0a
b01_ba13:   brk                         ; 7A13:  00
msg_market:   .db $5f                     ; 7A14:  5f
b01_ba15:   .db $5f                     ; 7A15:  5f
b01_ba16:   eor $7261                   ; 7A16:  4d 61 72
b01_ba19:   .db $6b                     ; 7A19:  6b
b01_ba1a:   adc palette_dirty                     ; 7A1A:  65 74
b01_ba1c:   .db $5f                     ; 7A1C:  5f
b01_ba1d:   .db $5f                     ; 7A1D:  5f
b01_ba1e:   brk                         ; 7A1E:  00
msg_rate_2d_1d:   .db $52                     ; 7A1F:  52
b01_ba20:   adc (palette_dirty,x)                 ; 7A20:  61 74
b01_ba22:   adc $20                     ; 7A22:  65 20
b01_ba24:   jsr $3225                   ; 7A24:  20 25 32
b01_ba27:   .db $64                     ; 7A27:  64
b01_ba28:   rol $3125                   ; 7A28:  2e 25 31
b01_ba2b:   .db $64                     ; 7A2B:  64
b01_ba2c:   brk                         ; 7A2C:  00
msg_rice_2d_1d:   .db $52                     ; 7A2D:  52
b01_ba2e:   adc #$63                    ; 7A2E:  69 63
b01_ba30:   adc $20                     ; 7A30:  65 20
b01_ba32:   jsr $3225                   ; 7A32:  20 25 32
b01_ba35:   .db $64                     ; 7A35:  64
b01_ba36:   rol $3125                   ; 7A36:  2e 25 31
b01_ba39:   .db $64                     ; 7A39:  64
b01_ba3a:   brk                         ; 7A3A:  00
msg_arms_2d_1d:   eor (ppumask_shadow,x)                 ; 7A3B:  41 72
b01_ba3d:   adc $2073                   ; 7A3D:  6d 73 20
b01_ba40:   jsr $3225                   ; 7A40:  20 25 32
b01_ba43:   .db $64                     ; 7A43:  64
b01_ba44:   rol $3125                   ; 7A44:  2e 25 31
b01_ba47:   .db $64                     ; 7A47:  64
b01_ba48:   brk                         ; 7A48:  00
msg_men_2d_1d:   eor $6e65                   ; 7A49:  4d 65 6e
b01_ba4c:   jsr $2020                   ; 7A4C:  20 20 20
b01_ba4f:   and $32                     ; 7A4F:  25 32
b01_ba51:   .db $64                     ; 7A51:  64
b01_ba52:   rol $3125                   ; 7A52:  2e 25 31
b01_ba55:   .db $64                     ; 7A55:  64
b01_ba56:   brk                         ; 7A56:  00
str_passed_from_lord:   lsr $6e69                   ; 7A57:  4e 69 6e
b01_ba5a:   ror a                       ; 7A5A:  6a
b01_ba5b:   adc ($20,x)                 ; 7A5B:  61 20
b01_ba5d:   and $32                     ; 7A5D:  25 32
b01_ba5f:   .db $64                     ; 7A5F:  64
b01_ba60:   rol $3125                   ; 7A60:  2e 25 31
b01_ba63:   .db $64                     ; 7A63:  64
b01_ba64:   brk                         ; 7A64:  00
count_eligible_targets_fmt_2d:   and $32                     ; 7A65:  25 32
b01_ba67:   .db $64                     ; 7A67:  64
b01_ba68:   brk                         ; 7A68:  00
str_fief_list_columns:   and $2500                   ; 7A69:  2d 00 25
b01_ba6c:   .db $34                     ; 7A6C:  34
b01_ba6d:   .db $64                     ; 7A6D:  64
b01_ba6e:   brk                         ; 7A6E:  00
str_field_dashes:   and $2d2d                   ; 7A6F:  2d 2d 2d
b01_ba72:   and $2500                   ; 7A72:  2d 00 25
b01_ba75:   .db $33                     ; 7A75:  33
b01_ba76:   .db $64                     ; 7A76:  64
b01_ba77:   brk                         ; 7A77:  00
str_field_dashes3:   and $2d2d                   ; 7A78:  2d 2d 2d
b01_ba7b:   brk                         ; 7A7B:  00
msg_home_fief:   pha                         ; 7A7C:  48
b01_ba7d:   .db p2_buttons                     ; 7A7D:  6f
b01_ba7e:   adc $2065                   ; 7A7E:  6d 65 20
b01_ba81:   ror brk_jmp_target_hi                     ; 7A81:  66 69
b01_ba83:   adc brk_scratch_lo                     ; 7A83:  65 66
b01_ba85:   brk                         ; 7A85:  00
msg_direct:   .db $44                     ; 7A86:  44
b01_ba87:   adc #$72                    ; 7A87:  69 72
b01_ba89:   adc $63                     ; 7A89:  65 63
b01_ba8b:   .db palette_dirty                     ; 7A8B:  74
b01_ba8c:   brk                         ; 7A8C:  00
msg_empty:   eor $6d                     ; 7A8D:  45 6d
b01_ba8f:   bvs $bb05                   ; 7A8F:  70 74
b01_ba91:   adc $4600,y                 ; 7A91:  79 00 46
b01_ba94:   adc #$65                    ; 7A94:  69 65
b01_ba96:   ror $20                     ; 7A96:  66 20
b01_ba98:   and $32                     ; 7A98:  25 32
b01_ba9a:   .db $64                     ; 7A9A:  64
b01_ba9b:   brk                         ; 7A9B:  00
str_fief_info_labels:   and $2d2d                   ; 7A9C:  2d 2d 2d
b01_ba9f:   and $2d2d                   ; 7A9F:  2d 2d 2d
b01_baa2:   and $002d                   ; 7AA2:  2d 2d 00
msg_sick:   .db $53                     ; 7AA5:  53
b01_baa6:   adc #$63                    ; 7AA6:  69 63
b01_baa8:   .db $6b                     ; 7AA8:  6b
b01_baa9:   brk                         ; 7AA9:  00
msg_home:   pha                         ; 7AAA:  48
b01_baab:   .db p2_buttons                     ; 7AAB:  6f
b01_baac:   adc $0a65                   ; 7AAC:  6d 65 0a
b01_baaf:   brk                         ; 7AAF:  00
draw_fief_view_label_msg:   lsr brk_jmp_target_hi                     ; 7AB0:  46 69
b01_bab2:   adc brk_scratch_lo                     ; 7AB2:  65 66
b01_bab4:   brk                         ; 7AB4:  00
msg_fief_gold_town_rice_output_dam:   lsr brk_jmp_target_hi                     ; 7AB5:  46 69
b01_bab7:   adc brk_scratch_lo                     ; 7AB7:  65 66
b01_bab9:   asl a                       ; 7AB9:  0a
b01_baba:   asl a                       ; 7ABA:  0a
b01_babb:   .db $47                     ; 7ABB:  47
b01_babc:   .db p2_buttons                     ; 7ABC:  6f
b01_babd:   jmp ($0a64)                 ; 7ABD:  6c 64 0a
b01_bac0:   .db $54                     ; 7AC0:  54
b01_bac1:   .db p2_buttons                     ; 7AC1:  6f
b01_bac2:   .db $77                     ; 7AC2:  77
b01_bac3:   ror $520a                   ; 7AC3:  6e 0a 52
b01_bac6:   adc #$63                    ; 7AC6:  69 63
b01_bac8:   adc $0a                     ; 7AC8:  65 0a
b01_baca:   .db $4f                     ; 7ACA:  4f
b01_bacb:   adc palette_dirty,x                   ; 7ACB:  75 74
b01_bacd:   bvs $bb44                   ; 7ACD:  70 75
b01_bacf:   .db palette_dirty                     ; 7ACF:  74
b01_bad0:   asl a                       ; 7AD0:  0a
b01_bad1:   .db $44                     ; 7AD1:  44
b01_bad2:   adc ($6d,x)                 ; 7AD2:  61 6d
b01_bad4:   .db prg_bank_shadow                     ; 7AD4:  73
b01_bad5:   asl a                       ; 7AD5:  0a
b01_bad6:   jmp $6c79                   ; 7AD6:  4c 79 6c
b01_bad9:   .db palette_dirty                     ; 7AD9:  74
b01_bada:   adc $570a,y                 ; 7ADA:  79 0a 57
b01_badd:   adc $61                     ; 7ADD:  65 61
b01_badf:   jmp ($6874)                 ; 7ADF:  6c 74 68
b01_bae2:   asl a                       ; 7AE2:  0a
b01_bae3:   eor $6e65                   ; 7AE3:  4d 65 6e
b01_bae6:   asl a                       ; 7AE6:  0a
b01_bae7:   eor $726f                   ; 7AE7:  4d 6f 72
b01_baea:   adc ($6c,x)                 ; 7AEA:  61 6c
b01_baec:   adc $0a                     ; 7AEC:  65 0a
b01_baee:   .db $53                     ; 7AEE:  53
b01_baef:   .db $6b                     ; 7AEF:  6b
b01_baf0:   adc #$6c                    ; 7AF0:  69 6c
b01_baf2:   jmp ($410a)                 ; 7AF2:  6c 0a 41
b01_baf5:   .db ppumask_shadow                     ; 7AF5:  72
b01_baf6:   adc $0a73                   ; 7AF6:  6d 73 0a
b01_baf9:   .db $54                     ; 7AF9:  54
b01_bafa:   adc ($78,x)                 ; 7AFA:  61 78
b01_bafc:   asl a                       ; 7AFC:  0a
b01_bafd:   lsr brk_jmp_target_hi                     ; 7AFD:  46 69
b01_baff:   adc brk_scratch_lo                     ; 7AFF:  65 66
b01_bb01:   brk                         ; 7B01:  00
effect_view_b_fmt_2d:   and $32                     ; 7B02:  25 32
b01_bb04:   .db $64                     ; 7B04:  64
b01_bb05:   brk                         ; 7B05:  00
effect_view_b_fmt_4d_1:   and $34                     ; 7B06:  25 34
b01_bb08:   .db $64                     ; 7B08:  64
b01_bb09:   asl a                       ; 7B09:  0a
b01_bb0a:   brk                         ; 7B0A:  00
effect_view_b_fmt_4d_2:   and $34                     ; 7B0B:  25 34
b01_bb0d:   .db $64                     ; 7B0D:  64
b01_bb0e:   asl a                       ; 7B0E:  0a
b01_bb0f:   brk                         ; 7B0F:  00
effect_view_b_fmt_4d_3:   and $34                     ; 7B10:  25 34
b01_bb12:   .db $64                     ; 7B12:  64
b01_bb13:   asl a                       ; 7B13:  0a
b01_bb14:   brk                         ; 7B14:  00
msg_menu:   .db $5f                     ; 7B15:  5f
b01_bb16:   .db $5f                     ; 7B16:  5f
b01_bb17:   eor $6e65                   ; 7B17:  4d 65 6e
b01_bb1a:   adc $5f,x                   ; 7B1A:  75 5f
b01_bb1c:   .db $5f                     ; 7B1C:  5f
b01_bb1d:   brk                         ; 7B1D:  00
fief_info_display_fmt_2d_1:   and $32                     ; 7B1E:  25 32
b01_bb20:   .db $64                     ; 7B20:  64
b01_bb21:   brk                         ; 7B21:  00
fief_info_display_fmt_2d_2:   and $32                     ; 7B22:  25 32
b01_bb24:   .db $64                     ; 7B24:  64
b01_bb25:   brk                         ; 7B25:  00
str_not_home_and_status:   and $4e00                   ; 7B26:  2d 00 4e
b01_bb29:   .db p2_buttons                     ; 7B29:  6f
b01_bb2a:   .db palette_dirty                     ; 7B2A:  74
b01_bb2b:   jsr battle_staging_entry_flag_array                   ; 7B2B:  20 68 6f
b01_bb2e:   adc $2065                   ; 7B2E:  6d 65 20
b01_bb31:   ror brk_jmp_target_hi                     ; 7B31:  66 69
b01_bb33:   adc brk_scratch_lo                     ; 7B33:  65 66
b01_bb35:   brk                         ; 7B35:  00
cycle_economy_rate_fmt:   and $32                     ; 7B36:  25 32
b01_bb38:   .db $64                     ; 7B38:  64
b01_bb39:   rol $3125                   ; 7B39:  2e 25 31
b01_bb3c:   .db $64                     ; 7B3C:  64
b01_bb3d:   brk                         ; 7B3D:  00
str_daimyo_status_msgs:   brk                         ; 7B3E:  00
msg_has_lost:   jsr $6168                   ; 7B3F:  20 68 61
b01_bb42:   .db prg_bank_shadow                     ; 7B42:  73
b01_bb43:   jsr $6f6c                   ; 7B43:  20 6c 6f
b01_bb46:   .db prg_bank_shadow                     ; 7B46:  73
b01_bb47:   .db palette_dirty                     ; 7B47:  74
b01_bb48:   brk                         ; 7B48:  00
msg_has_retreated:   jsr $6168                   ; 7B49:  20 68 61
b01_bb4c:   .db prg_bank_shadow                     ; 7B4C:  73
b01_bb4d:   asl a                       ; 7B4D:  0a
b01_bb4e:   .db ppumask_shadow                     ; 7B4E:  72
b01_bb4f:   adc palette_dirty                     ; 7B4F:  65 74
b01_bb51:   .db ppumask_shadow                     ; 7B51:  72
b01_bb52:   adc $61                     ; 7B52:  65 61
b01_bb54:   .db palette_dirty                     ; 7B54:  74
b01_bb55:   adc $64                     ; 7B55:  65 64
b01_bb57:   brk                         ; 7B57:  00
msg_has_fled:   jsr $6168                   ; 7B58:  20 68 61
b01_bb5b:   .db prg_bank_shadow                     ; 7B5B:  73
b01_bb5c:   jsr $6c66                   ; 7B5C:  20 66 6c
b01_bb5f:   adc $64                     ; 7B5F:  65 64
b01_bb61:   brk                         ; 7B61:  00
msg_from_fief_2d_has:   jsr $7266                   ; 7B62:  20 66 72
b01_bb65:   .db p2_buttons                     ; 7B65:  6f
b01_bb66:   adc $660a                   ; 7B66:  6d 0a 66
b01_bb69:   adc #$65                    ; 7B69:  69 65
b01_bb6b:   ror $20                     ; 7B6B:  66 20
b01_bb6d:   and $32                     ; 7B6D:  25 32
b01_bb6f:   .db $64                     ; 7B6F:  64
b01_bb70:   jsr $6168                   ; 7B70:  20 68 61
b01_bb73:   .db prg_bank_shadow                     ; 7B73:  73
b01_bb74:   asl a                       ; 7B74:  0a
b01_bb75:   brk                         ; 7B75:  00
msg_invaded_s_in_fief_2d:   adc #$6e                    ; 7B76:  69 6e
b01_bb78:   ror $61,x                   ; 7B78:  76 61
b01_bb7a:   .db $64                     ; 7B7A:  64
b01_bb7b:   adc $64                     ; 7B7B:  65 64
b01_bb7d:   jsr $7325                   ; 7B7D:  20 25 73
b01_bb80:   asl a                       ; 7B80:  0a
b01_bb81:   adc #$6e                    ; 7B81:  69 6e
b01_bb83:   jsr $6966                   ; 7B83:  20 66 69
b01_bb86:   adc brk_scratch_lo                     ; 7B86:  65 66
b01_bb88:   jsr $3225                   ; 7B88:  20 25 32
b01_bb8b:   .db $64                     ; 7B8B:  64
b01_bb8c:   brk                         ; 7B8C:  00
msg_counterattacked:   .db $43                     ; 7B8D:  43
b01_bb8e:   .db p2_buttons                     ; 7B8E:  6f
b01_bb8f:   adc p1_buttons,x                   ; 7B8F:  75 6e
b01_bb91:   .db palette_dirty                     ; 7B91:  74
b01_bb92:   adc ppumask_shadow                     ; 7B92:  65 72
b01_bb94:   adc (palette_dirty,x)                 ; 7B94:  61 74
b01_bb96:   .db palette_dirty                     ; 7B96:  74
b01_bb97:   adc ($63,x)                 ; 7B97:  61 63
b01_bb99:   .db $6b                     ; 7B99:  6b
b01_bb9a:   adc $64                     ; 7B9A:  65 64
b01_bb9c:   and (scratch_ptr_lo,x)                 ; 7B9C:  21 00
msg_you_have_repelled:   asl a                       ; 7B9E:  0a
b01_bb9f:   eor $756f,y                 ; 7B9F:  59 6f 75
b01_bba2:   jsr $6168                   ; 7BA2:  20 68 61
b01_bba5:   ror $65,x                   ; 7BA5:  76 65
b01_bba7:   jsr $6572                   ; 7BA7:  20 72 65
b01_bbaa:   bvs $bc11                   ; 7BAA:  70 65
b01_bbac:   jmp ($656c)                 ; 7BAC:  6c 6c 65
b01_bbaf:   .db $64                     ; 7BAF:  64
b01_bbb0:   and (scratch_ptr_lo,x)                 ; 7BB0:  21 00
msg_your_ninja_failed:   eor $756f,y                 ; 7BB2:  59 6f 75
b01_bbb5:   .db ppumask_shadow                     ; 7BB5:  72
b01_bbb6:   jsr $696e                   ; 7BB6:  20 6e 69
b01_bbb9:   ror $616a                   ; 7BB9:  6e 6a 61
b01_bbbc:   jsr $6166                   ; 7BBC:  20 66 61
b01_bbbf:   adc #$6c                    ; 7BBF:  69 6c
b01_bbc1:   adc $64                     ; 7BC1:  65 64
b01_bbc3:   brk                         ; 7BC3:  00
msg_that_fief_can_t_hold_more_men:   .db $54                     ; 7BC4:  54
b01_bbc5:   pla                         ; 7BC5:  68
b01_bbc6:   adc (palette_dirty,x)                 ; 7BC6:  61 74
b01_bbc8:   jsr $6966                   ; 7BC8:  20 66 69
b01_bbcb:   adc brk_scratch_lo                     ; 7BCB:  65 66
b01_bbcd:   jsr $6163                   ; 7BCD:  20 63 61
b01_bbd0:   ror $7460                   ; 7BD0:  6e 60 74
b01_bbd3:   asl a                       ; 7BD3:  0a
b01_bbd4:   pla                         ; 7BD4:  68
b01_bbd5:   .db p2_buttons                     ; 7BD5:  6f
b01_bbd6:   jmp ($2064)                 ; 7BD6:  6c 64 20
b01_bbd9:   adc $726f                   ; 7BD9:  6d 6f 72
b01_bbdc:   adc $20                     ; 7BDC:  65 20
b01_bbde:   adc $6e65                   ; 7BDE:  6d 65 6e
b01_bbe1:   brk                         ; 7BE1:  00
str_is_this_ok:   brk                         ; 7BE2:  00
driver_send_is_this_ok:   eor #$73                    ; 7BE3:  49 73
b01_bbe5:   jsr $6874                   ; 7BE5:  20 74 68
b01_bbe8:   adc #$73                    ; 7BE8:  69 73
b01_bbea:   jsr $4b4f                   ; 7BEA:  20 4f 4b
b01_bbed:   brk                         ; 7BED:  00
str_dams_value_label:   brk                         ; 7BEE:  00
msg_dams_value:   .db $44                     ; 7BEF:  44
b01_bbf0:   adc ($6d,x)                 ; 7BF0:  61 6d
b01_bbf2:   .db prg_bank_shadow                     ; 7BF2:  73
b01_bbf3:   jsr $6176                   ; 7BF3:  20 76 61
b01_bbf6:   jmp ($6575)                 ; 7BF6:  6c 75 65
b01_bbf9:   brk                         ; 7BF9:  00
str_output_label:   brk                         ; 7BFA:  00
str_output_label_alias1:   brk                         ; 7BFB:  00
str_output_label_alias2:   brk                         ; 7BFC:  00
msg_output:   .db $4f                     ; 7BFD:  4f
b01_bbfe:   adc palette_dirty,x                   ; 7BFE:  75 74
b01_bc00:   bvs $bc77                   ; 7C00:  70 75
b01_bc02:   .db palette_dirty                     ; 7C02:  74
b01_bc03:   brk                         ; 7C03:  00
str_treasure_room_full:   brk                         ; 7C04:  00
str_treasure_room_full_alias:   brk                         ; 7C05:  00
msg_loan_prompt:   brk                         ; 7C06:  00
msg_the_treasure_room_is_already_f:   asl a                       ; 7C07:  0a
b01_bc08:   .db $54                     ; 7C08:  54
b01_bc09:   pla                         ; 7C09:  68
b01_bc0a:   adc $20                     ; 7C0A:  65 20
b01_bc0c:   .db palette_dirty                     ; 7C0C:  74
b01_bc0d:   .db ppumask_shadow                     ; 7C0D:  72
b01_bc0e:   adc $61                     ; 7C0E:  65 61
b01_bc10:   .db prg_bank_shadow                     ; 7C10:  73
b01_bc11:   adc ppumask_shadow,x                   ; 7C11:  75 72
b01_bc13:   adc $20                     ; 7C13:  65 20
b01_bc15:   .db ppumask_shadow                     ; 7C15:  72
b01_bc16:   .db p2_buttons                     ; 7C16:  6f
b01_bc17:   .db p2_buttons                     ; 7C17:  6f
b01_bc18:   adc $690a                   ; 7C18:  6d 0a 69
b01_bc1b:   .db prg_bank_shadow                     ; 7C1B:  73
b01_bc1c:   jsr $6c61                   ; 7C1C:  20 61 6c
b01_bc1f:   .db ppumask_shadow                     ; 7C1F:  72
b01_bc20:   adc $61                     ; 7C20:  65 61
b01_bc22:   .db $64                     ; 7C22:  64
b01_bc23:   adc $6620,y                 ; 7C23:  79 20 66
b01_bc26:   adc $6c,x                   ; 7C26:  75 6c
b01_bc28:   jmp ($0021)                 ; 7C28:  6c 21 00
msg_s_would_you_like_to_borrow:   and prg_bank_shadow                     ; 7C2B:  25 73
b01_bc2d:   jsr $6f77                   ; 7C2D:  20 77 6f
b01_bc30:   adc $6c,x                   ; 7C30:  75 6c
b01_bc32:   .db $64                     ; 7C32:  64
b01_bc33:   asl a                       ; 7C33:  0a
b01_bc34:   adc $756f,y                 ; 7C34:  79 6f 75
b01_bc37:   jsr $696c                   ; 7C37:  20 6c 69
b01_bc3a:   .db $6b                     ; 7C3A:  6b
b01_bc3b:   adc $20                     ; 7C3B:  65 20
b01_bc3d:   .db palette_dirty                     ; 7C3D:  74
b01_bc3e:   .db p2_buttons                     ; 7C3E:  6f
b01_bc3f:   asl a                       ; 7C3F:  0a
b01_bc40:   .db $62                     ; 7C40:  62
b01_bc41:   .db p2_buttons                     ; 7C41:  6f
b01_bc42:   .db ppumask_shadow                     ; 7C42:  72
b01_bc43:   .db ppumask_shadow                     ; 7C43:  72
b01_bc44:   .db p2_buttons                     ; 7C44:  6f
b01_bc45:   .db $77                     ; 7C45:  77
b01_bc46:   brk                         ; 7C46:  00
msg_you_can_t_borrow:   eor $756f,y                 ; 7C47:  59 6f 75
b01_bc4a:   jsr $6163                   ; 7C4A:  20 63 61
b01_bc4d:   ror $7460                   ; 7C4D:  6e 60 74
b01_bc50:   jsr $6f62                   ; 7C50:  20 62 6f
b01_bc53:   .db ppumask_shadow                     ; 7C53:  72
b01_bc54:   .db ppumask_shadow                     ; 7C54:  72
b01_bc55:   .db p2_buttons                     ; 7C55:  6f
b01_bc56:   .db $77                     ; 7C56:  77
b01_bc57:   and (scratch_ptr_lo,x)                 ; 7C57:  21 00
msg_repay_debt:   brk                         ; 7C59:  00
msg_no_gold:   asl a                       ; 7C5A:  0a
b01_bc5b:   lsr $206f                   ; 7C5B:  4e 6f 20
b01_bc5e:   .db brk_scratch_hi                     ; 7C5E:  67
b01_bc5f:   .db p2_buttons                     ; 7C5F:  6f
b01_bc60:   jmp ($0064)                 ; 7C60:  6c 64 00
msg_debt_what_debt:   asl a                       ; 7C63:  0a
b01_bc64:   .db $44                     ; 7C64:  44
b01_bc65:   adc $62                     ; 7C65:  65 62
b01_bc67:   .db palette_dirty                     ; 7C67:  74
b01_bc68:   .db $3f                     ; 7C68:  3f
b01_bc69:   jsr $6857                   ; 7C69:  20 57 68
b01_bc6c:   adc (palette_dirty,x)                 ; 7C6C:  61 74
b01_bc6e:   jsr $6564                   ; 7C6E:  20 64 65
b01_bc71:   .db $62                     ; 7C71:  62
b01_bc72:   .db palette_dirty                     ; 7C72:  74
b01_bc73:   .db $3f                     ; 7C73:  3f
b01_bc74:   brk                         ; 7C74:  00
msg_sell_rice_prompt:   brk                         ; 7C75:  00
msg_s_rice_will_you_sell:   and prg_bank_shadow                     ; 7C76:  25 73
b01_bc78:   jsr $6972                   ; 7C78:  20 72 69
b01_bc7b:   .db $63                     ; 7C7B:  63
b01_bc7c:   adc $0a                     ; 7C7C:  65 0a
b01_bc7e:   .db $77                     ; 7C7E:  77
b01_bc7f:   adc #$6c                    ; 7C7F:  69 6c
b01_bc81:   jmp ($7920)                 ; 7C81:  6c 20 79
b01_bc84:   .db p2_buttons                     ; 7C84:  6f
b01_bc85:   adc $20,x                   ; 7C85:  75 20
b01_bc87:   .db prg_bank_shadow                     ; 7C87:  73
b01_bc88:   adc $6c                     ; 7C88:  65 6c
b01_bc8a:   jmp ($5400)                 ; 7C8A:  6c 00 54
b01_bc8d:   .db ppumask_shadow                     ; 7C8D:  72
b01_bc8e:   adc $61                     ; 7C8E:  65 61
b01_bc90:   .db prg_bank_shadow                     ; 7C90:  73
b01_bc91:   adc ppumask_shadow,x                   ; 7C91:  75 72
b01_bc93:   adc $6620,y                 ; 7C93:  79 20 66
b01_bc96:   adc $6c,x                   ; 7C96:  75 6c
b01_bc98:   jmp ($4e00)                 ; 7C98:  6c 00 4e
b01_bc9b:   .db p2_buttons                     ; 7C9B:  6f
b01_bc9c:   jsr $6972                   ; 7C9C:  20 72 69
b01_bc9f:   .db $63                     ; 7C9F:  63
b01_bca0:   adc scratch_ptr_lo                     ; 7CA0:  65 00
msg_buy_rice_prompt:   brk                         ; 7CA2:  00
msg_rice_will_you_buy:   jsr $6972                   ; 7CA3:  20 72 69
b01_bca6:   .db $63                     ; 7CA6:  63
b01_bca7:   adc $0a                     ; 7CA7:  65 0a
b01_bca9:   .db $77                     ; 7CA9:  77
b01_bcaa:   adc #$6c                    ; 7CAA:  69 6c
b01_bcac:   jmp ($7920)                 ; 7CAC:  6c 20 79
b01_bcaf:   .db p2_buttons                     ; 7CAF:  6f
b01_bcb0:   adc $20,x                   ; 7CB0:  75 20
b01_bcb2:   .db $62                     ; 7CB2:  62
b01_bcb3:   adc music_voice_idx,x                   ; 7CB3:  75 79
b01_bcb5:   brk                         ; 7CB5:  00
msg_storehouse_full:   .db $53                     ; 7CB6:  53
b01_bcb7:   .db palette_dirty                     ; 7CB7:  74
b01_bcb8:   .db p2_buttons                     ; 7CB8:  6f
b01_bcb9:   .db ppumask_shadow                     ; 7CB9:  72
b01_bcba:   adc brk_jmp_target_lo                     ; 7CBA:  65 68
b01_bcbc:   .db p2_buttons                     ; 7CBC:  6f
b01_bcbd:   adc prg_bank_shadow,x                   ; 7CBD:  75 73
b01_bcbf:   adc $20                     ; 7CBF:  65 20
b01_bcc1:   ror mul_acc_lo                     ; 7CC1:  66 75
b01_bcc3:   jmp ($006c)                 ; 7CC3:  6c 6c 00
msg_sorry_no_credit:   .db $53                     ; 7CC6:  53
b01_bcc7:   .db p2_buttons                     ; 7CC7:  6f
b01_bcc8:   .db ppumask_shadow                     ; 7CC8:  72
b01_bcc9:   .db ppumask_shadow                     ; 7CC9:  72
b01_bcca:   adc $202c,y                 ; 7CCA:  79 2c 20
b01_bccd:   ror $206f                   ; 7CCD:  6e 6f 20
b01_bcd0:   .db $63                     ; 7CD0:  63
b01_bcd1:   .db ppumask_shadow                     ; 7CD1:  72
b01_bcd2:   adc $64                     ; 7CD2:  65 64
b01_bcd4:   adc #$74                    ; 7CD4:  69 74
b01_bcd6:   brk                         ; 7CD6:  00
msg_weapons_for_who:   .db $57                     ; 7CD7:  57
b01_bcd8:   adc $61                     ; 7CD8:  65 61
b01_bcda:   bvs $bd4b                   ; 7CDA:  70 6f
b01_bcdc:   ror $3f73                   ; 7CDC:  6e 73 3f
b01_bcdf:   jsr $6f46                   ; 7CDF:  20 46 6f
b01_bce2:   .db ppumask_shadow                     ; 7CE2:  72
b01_bce3:   jsr $6877                   ; 7CE3:  20 77 68
b01_bce6:   .db p2_buttons                     ; 7CE6:  6f
b01_bce7:   .db $3f                     ; 7CE7:  3f
b01_bce8:   brk                         ; 7CE8:  00
msg_buy_arms_prompt:   brk                         ; 7CE9:  00
msg_armory_full:   eor (ppumask_shadow,x)                 ; 7CEA:  41 72
b01_bcec:   adc $726f                   ; 7CEC:  6d 6f 72
b01_bcef:   adc $6620,y                 ; 7CEF:  79 20 66
b01_bcf2:   adc $6c,x                   ; 7CF2:  75 6c
b01_bcf4:   jmp ($5700)                 ; 7CF4:  6c 00 57
b01_bcf7:   adc $20                     ; 7CF7:  65 20
b01_bcf9:   adc $7265                   ; 7CF9:  6d 65 72
b01_bcfc:   .db $63                     ; 7CFC:  63
b01_bcfd:   pla                         ; 7CFD:  68
b01_bcfe:   adc (p1_buttons,x)                 ; 7CFE:  61 6e
b01_bd00:   .db palette_dirty                     ; 7D00:  74
b01_bd01:   .db prg_bank_shadow                     ; 7D01:  73
b01_bd02:   jsr $6564                   ; 7D02:  20 64 65
b01_bd05:   adc ($6c,x)                 ; 7D05:  61 6c
b01_bd07:   asl a                       ; 7D07:  0a
b01_bd08:   .db p2_buttons                     ; 7D08:  6f
b01_bd09:   ror $796c                   ; 7D09:  6e 6c 79
b01_bd0c:   jsr $6e69                   ; 7D0C:  20 69 6e
b01_bd0f:   jsr $6163                   ; 7D0F:  20 63 61
b01_bd12:   .db prg_bank_shadow                     ; 7D12:  73
b01_bd13:   pla                         ; 7D13:  68
b01_bd14:   brk                         ; 7D14:  00
driver_trade_fmt_2d:   and $32                     ; 7D15:  25 32
b01_bd17:   .db $64                     ; 7D17:  64
b01_bd18:   brk                         ; 7D18:  00
msg_lord_how_may_i_serve_you:   jmp $726f                   ; 7D19:  4c 6f 72
b01_bd1c:   .db $64                     ; 7D1C:  64
b01_bd1d:   bit battle_staging_entry_flag_array                   ; 7D1D:  2c 68 6f
b01_bd20:   .db $77                     ; 7D20:  77
b01_bd21:   jsr $616d                   ; 7D21:  20 6d 61
b01_bd24:   adc $4920,y                 ; 7D24:  79 20 49
b01_bd27:   asl a                       ; 7D27:  0a
b01_bd28:   .db prg_bank_shadow                     ; 7D28:  73
b01_bd29:   adc ppumask_shadow                     ; 7D29:  65 72
b01_bd2b:   ror $65,x                   ; 7D2B:  76 65
b01_bd2d:   jsr ai_turn_loop_redispatch_flag                   ; 7D2D:  20 79 6f
b01_bd30:   adc $3f,x                   ; 7D30:  75 3f
b01_bd32:   brk                         ; 7D32:  00
msg_let_s_do_business_again:   jmp $7465                   ; 7D33:  4c 65 74
b01_bd36:   rts                         ; 7D36:  60
b01_bd37:   .db prg_bank_shadow                     ; 7D37:  73
b01_bd38:   jsr $6f64                   ; 7D38:  20 64 6f
b01_bd3b:   jsr $7562                   ; 7D3B:  20 62 75
b01_bd3e:   .db prg_bank_shadow                     ; 7D3E:  73
b01_bd3f:   adc #$6e                    ; 7D3F:  69 6e
b01_bd41:   adc prg_bank_shadow                     ; 7D41:  65 73
b01_bd43:   .db prg_bank_shadow                     ; 7D43:  73
b01_bd44:   asl a                       ; 7D44:  0a
b01_bd45:   adc (brk_scratch_hi,x)                 ; 7D45:  61 67
b01_bd47:   adc (brk_jmp_target_hi,x)                 ; 7D47:  61 69
b01_bd49:   ror $4200                   ; 7D49:  6e 00 42
b01_bd4c:   adc $2165,y                 ; 7D4C:  79 65 21
b01_bd4f:   brk                         ; 7D4F:  00
msg_fief_d_s_s_has_declined_by_d:   ror brk_jmp_target_hi                     ; 7D50:  66 69
b01_bd52:   adc brk_scratch_lo                     ; 7D52:  65 66
b01_bd54:   jsr $6425                   ; 7D54:  20 25 64
b01_bd57:   rts                         ; 7D57:  60
b01_bd58:   .db prg_bank_shadow                     ; 7D58:  73
b01_bd59:   asl a                       ; 7D59:  0a
b01_bd5a:   and prg_bank_shadow                     ; 7D5A:  25 73
b01_bd5c:   jsr $6168                   ; 7D5C:  20 68 61
b01_bd5f:   .db prg_bank_shadow                     ; 7D5F:  73
b01_bd60:   asl a                       ; 7D60:  0a
b01_bd61:   .db $64                     ; 7D61:  64
b01_bd62:   adc $63                     ; 7D62:  65 63
b01_bd64:   jmp ($6e69)                 ; 7D64:  6c 69 6e
b01_bd67:   adc $64                     ; 7D67:  65 64
b01_bd69:   jsr $7962                   ; 7D69:  20 62 79
b01_bd6c:   jsr $6425                   ; 7D6C:  20 25 64
b01_bd6f:   asl a                       ; 7D6F:  0a
b01_bd70:   brk                         ; 7D70:  00
msg_town_value:   .db $54                     ; 7D71:  54
b01_bd72:   .db p2_buttons                     ; 7D72:  6f
b01_bd73:   .db $77                     ; 7D73:  77
b01_bd74:   ror $7620                   ; 7D74:  6e 20 76
b01_bd77:   adc ($6c,x)                 ; 7D77:  61 6c
b01_bd79:   adc $65,x                   ; 7D79:  75 65
b01_bd7b:   brk                         ; 7D7B:  00
effect_ninja_failed_your_ninja_failed:   eor $756f,y                 ; 7D7C:  59 6f 75
b01_bd7f:   .db ppumask_shadow                     ; 7D7F:  72
b01_bd80:   jsr $696e                   ; 7D80:  20 6e 69
b01_bd83:   ror $616a                   ; 7D83:  6e 6a 61
b01_bd86:   asl a                       ; 7D86:  0a
b01_bd87:   ror $61                     ; 7D87:  66 61
b01_bd89:   adc #$6c                    ; 7D89:  69 6c
b01_bd8b:   adc $64                     ; 7D8B:  65 64
b01_bd8d:   and (scratch_ptr_lo,x)                 ; 7D8D:  21 00
msg_uprisng_2_revolt_3_dams_4_assa:   asl a                       ; 7D8F:  0a
b01_bd90:   and ($2d),y                 ; 7D90:  31 2d
b01_bd92:   eor $70,x                   ; 7D92:  55 70
b01_bd94:   .db ppumask_shadow                     ; 7D94:  72
b01_bd95:   adc #$73                    ; 7D95:  69 73
b01_bd97:   ror $2067                   ; 7D97:  6e 67 20
b01_bd9a:   .db $32                     ; 7D9A:  32
b01_bd9b:   and $6552                   ; 7D9B:  2d 52 65
b01_bd9e:   ror p2_buttons,x                   ; 7D9E:  76 6f
b01_bda0:   jmp ($0a74)                 ; 7DA0:  6c 74 0a
b01_bda3:   .db $33                     ; 7DA3:  33
b01_bda4:   and $6144                   ; 7DA4:  2d 44 61
b01_bda7:   adc $2073                   ; 7DA7:  6d 73 20
b01_bdaa:   .db $34                     ; 7DAA:  34
b01_bdab:   and $7341                   ; 7DAB:  2d 41 73
b01_bdae:   .db prg_bank_shadow                     ; 7DAE:  73
b01_bdaf:   adc (prg_bank_shadow,x)                 ; 7DAF:  61 73
b01_bdb1:   .db prg_bank_shadow                     ; 7DB1:  73
b01_bdb2:   adc #$6e                    ; 7DB2:  69 6e
b01_bdb4:   asl a                       ; 7DB4:  0a
b01_bdb5:   and $2d,x                   ; 7DB5:  35 2d
b01_bdb7:   eor (ppumask_shadow,x)                 ; 7DB7:  41 72
b01_bdb9:   .db prg_bank_shadow                     ; 7DB9:  73
b01_bdba:   .db p2_buttons                     ; 7DBA:  6f
b01_bdbb:   ror $7400                   ; 7DBB:  6e 00 74
b01_bdbe:   pla                         ; 7DBE:  68
b01_bdbf:   adc $20                     ; 7DBF:  65 20
b01_bdc1:   .db $64                     ; 7DC1:  64
b01_bdc2:   adc (brk_jmp_target_hi,x)                 ; 7DC2:  61 69
b01_bdc4:   adc ai_turn_loop_redispatch_flag                   ; 7DC4:  6d 79 6f
b01_bdc7:   jsr $7369                   ; 7DC7:  20 69 73
b01_bdca:   jsr $756f                   ; 7DCA:  20 6f 75
b01_bdcd:   .db palette_dirty                     ; 7DCD:  74
b01_bdce:   brk                         ; 7DCE:  00
str_men_ninja_train_msgs:   brk                         ; 7DCF:  00
msg_men_or_ninja:   brk                         ; 7DD0:  00
msg_men_ninja:   asl a                       ; 7DD1:  0a
b01_bdd2:   plp                         ; 7DD2:  28
b01_bdd3:   eor $6e65                   ; 7DD3:  4d 65 6e
b01_bdd6:   .db $2f                     ; 7DD6:  2f
b01_bdd7:   lsr $6e69                   ; 7DD7:  4e 69 6e
b01_bdda:   ror a                       ; 7DDA:  6a
b01_bddb:   adc ($29,x)                 ; 7DDB:  61 29
b01_bddd:   .db $3f                     ; 7DDD:  3f
b01_bdde:   jsr $5400                   ; 7DDE:  20 00 54
b01_bde1:   pla                         ; 7DE1:  68
b01_bde2:   adc $20                     ; 7DE2:  65 20
b01_bde4:   adc $6e65                   ; 7DE4:  6d 65 6e
b01_bde7:   jsr $6163                   ; 7DE7:  20 63 61
b01_bdea:   ror $7460                   ; 7DEA:  6e 60 74
b01_bded:   asl a                       ; 7DED:  0a
b01_bdee:   .db palette_dirty                     ; 7DEE:  74
b01_bdef:   .db ppumask_shadow                     ; 7DEF:  72
b01_bdf0:   adc (brk_jmp_target_hi,x)                 ; 7DF0:  61 69
b01_bdf2:   ror $6120                   ; 7DF2:  6e 20 61
b01_bdf5:   ror $2079                   ; 7DF5:  6e 79 20
b01_bdf8:   ror mul_acc_lo                     ; 7DF8:  66 75
b01_bdfa:   .db ppumask_shadow                     ; 7DFA:  72
b01_bdfb:   .db palette_dirty                     ; 7DFB:  74
b01_bdfc:   pla                         ; 7DFC:  68
b01_bdfd:   adc ppumask_shadow                     ; 7DFD:  65 72
b01_bdff:   brk                         ; 7DFF:  00
msg_view_vassals:   plp                         ; 7E00:  28
b01_be01:   and $2d39,y                 ; 7E01:  39 39 2d
b01_be04:   ror brk_jmp_target_hi,x                   ; 7E04:  76 69
b01_be06:   adc $77                     ; 7E06:  65 77
b01_be08:   jsr $6176                   ; 7E08:  20 76 61
b01_be0b:   .db prg_bank_shadow                     ; 7E0B:  73
b01_be0c:   .db prg_bank_shadow                     ; 7E0C:  73
b01_be0d:   adc ($6c,x)                 ; 7E0D:  61 6c
b01_be0f:   .db prg_bank_shadow                     ; 7E0F:  73
b01_be10:   and #$0a                    ; 7E10:  29 0a
b01_be12:   brk                         ; 7E12:  00
str_town_value_label:   brk                         ; 7E13:  00
driver_build_town_value:   .db $54                     ; 7E14:  54
b01_be15:   .db p2_buttons                     ; 7E15:  6f
b01_be16:   .db $77                     ; 7E16:  77
b01_be17:   ror $7620                   ; 7E17:  6e 20 76
b01_be1a:   adc ($6c,x)                 ; 7E1A:  61 6c
b01_be1c:   adc $65,x                   ; 7E1C:  75 65
b01_be1e:   brk                         ; 7E1E:  00
str_gold_rice_prompt:   brk                         ; 7E1F:  00
msg_gold_rice:   plp                         ; 7E20:  28
b01_be21:   .db $47                     ; 7E21:  47
b01_be22:   .db p2_buttons                     ; 7E22:  6f
b01_be23:   jmp ($2f64)                 ; 7E23:  6c 64 2f
b01_be26:   .db $52                     ; 7E26:  52
b01_be27:   adc #$63                    ; 7E27:  69 63
b01_be29:   adc $29                     ; 7E29:  65 29
b01_be2b:   .db $3f                     ; 7E2B:  3f
b01_be2c:   jsr $0a00                   ; 7E2C:  20 00 0a
b01_be2f:   brk                         ; 7E2F:  00
str_peasants_men_prompt:   brk                         ; 7E30:  00
msg_peasnts_men:   plp                         ; 7E31:  28
b01_be32:   bvc $be99                   ; 7E32:  50 65
b01_be34:   adc (prg_bank_shadow,x)                 ; 7E34:  61 73
b01_be36:   ror $7374                   ; 7E36:  6e 74 73
b01_be39:   .db $2f                     ; 7E39:  2f
b01_be3a:   eor $6e65                   ; 7E3A:  4d 65 6e
b01_be3d:   and #$3f                    ; 7E3D:  29 3f
b01_be3f:   jsr $0a00                   ; 7E3F:  20 00 0a
b01_be42:   brk                         ; 7E42:  00
render_arms_edit_screen_fmt_3d:   and $33                     ; 7E43:  25 33
b01_be45:   .db $64                     ; 7E45:  64
b01_be46:   brk                         ; 7E46:  00
msg_d_s:   and $64                     ; 7E47:  25 64
b01_be49:   and prg_bank_shadow                     ; 7E49:  25 73
b01_be4b:   brk                         ; 7E4B:  00
msg_available_0:   adc (mul_acc_hi,x)                 ; 7E4C:  61 76
b01_be4e:   adc (brk_jmp_target_hi,x)                 ; 7E4E:  61 69
b01_be50:   jmp ($6261)                 ; 7E50:  6c 61 62
b01_be53:   jmp ($2065)                 ; 7E53:  6c 65 20
b01_be56:   jsr $0030                   ; 7E56:  20 30 00
effect_assign_fmt_3d_1:   and $33                     ; 7E59:  25 33
b01_be5b:   .db $64                     ; 7E5B:  64
b01_be5c:   brk                         ; 7E5C:  00
effect_assign_fmt_3d_2:   and $33                     ; 7E5D:  25 33
b01_be5f:   .db $64                     ; 7E5F:  64
b01_be60:   brk                         ; 7E60:  00
effect_assign_fmt_3d_3:   and $33                     ; 7E61:  25 33
b01_be63:   .db $64                     ; 7E63:  64
b01_be64:   brk                         ; 7E64:  00
effect_assign_fmt_3d_4:   and $33                     ; 7E65:  25 33
b01_be67:   .db $64                     ; 7E67:  64
b01_be68:   brk                         ; 7E68:  00
msg_arrows_other_sections:   plp                         ; 7E69:  28
b01_be6a:   adc (ppumask_shadow,x)                 ; 7E6A:  61 72
b01_be6c:   .db ppumask_shadow                     ; 7E6C:  72
b01_be6d:   .db p2_buttons                     ; 7E6D:  6f
b01_be6e:   .db $77                     ; 7E6E:  77
b01_be6f:   .db prg_bank_shadow                     ; 7E6F:  73
b01_be70:   jsr $2920                   ; 7E70:  20 20 29
b01_be73:   rol $2e2e                   ; 7E73:  2e 2e 2e
b01_be76:   .db p2_buttons                     ; 7E76:  6f
b01_be77:   .db palette_dirty                     ; 7E77:  74
b01_be78:   pla                         ; 7E78:  68
b01_be79:   adc ppumask_shadow                     ; 7E79:  65 72
b01_be7b:   jsr $6573                   ; 7E7B:  20 73 65
b01_be7e:   .db $63                     ; 7E7E:  63
b01_be7f:   .db palette_dirty                     ; 7E7F:  74
b01_be80:   adc #$6f                    ; 7E80:  69 6f
b01_be82:   ror $0a73                   ; 7E82:  6e 73 0a
b01_be85:   brk                         ; 7E85:  00
msg_a_button_menu:   plp                         ; 7E86:  28
b01_be87:   eor ($20,x)                 ; 7E87:  41 20
b01_be89:   .db $42                     ; 7E89:  42
b01_be8a:   adc palette_dirty,x                   ; 7E8A:  75 74
b01_be8c:   .db palette_dirty                     ; 7E8C:  74
b01_be8d:   .db p2_buttons                     ; 7E8D:  6f
b01_be8e:   ror $2e29                   ; 7E8E:  6e 29 2e
b01_be91:   rol $6d2e                   ; 7E91:  2e 2e 6d
b01_be94:   adc p1_buttons                     ; 7E94:  65 6e
b01_be96:   adc scratch_ptr_lo,x                   ; 7E96:  75 00
driver_grant_fmt_d:   and $64                     ; 7E98:  25 64
b01_be9a:   brk                         ; 7E9A:  00
msg_it_s_already_a_s_state:   eor #$74                    ; 7E9B:  49 74
b01_be9d:   rts                         ; 7E9D:  60
b01_be9e:   .db prg_bank_shadow                     ; 7E9E:  73
b01_be9f:   jsr $6c61                   ; 7E9F:  20 61 6c
b01_bea2:   .db ppumask_shadow                     ; 7EA2:  72
b01_bea3:   adc $61                     ; 7EA3:  65 61
b01_bea5:   .db $64                     ; 7EA5:  64
b01_bea6:   adc $6120,y                 ; 7EA6:  79 20 61
b01_bea9:   asl a                       ; 7EA9:  0a
b01_beaa:   and prg_bank_shadow                     ; 7EAA:  25 73
b01_beac:   asl a                       ; 7EAC:  0a
b01_bead:   .db prg_bank_shadow                     ; 7EAD:  73
b01_beae:   .db palette_dirty                     ; 7EAE:  74
b01_beaf:   adc (palette_dirty,x)                 ; 7EAF:  61 74
b01_beb1:   adc scratch_ptr_lo                     ; 7EB1:  65 00
msg_sound:   .db $53                     ; 7EB3:  53
b01_beb4:   .db p2_buttons                     ; 7EB4:  6f
b01_beb5:   adc p1_buttons,x                   ; 7EB5:  75 6e
b01_beb7:   .db $64                     ; 7EB7:  64
b01_beb8:   jsr $2800                   ; 7EB8:  20 00 28
b01_bebb:   .db p2_buttons                     ; 7EBB:  6f
b01_bebc:   ror $6f2f                   ; 7EBC:  6e 2f 6f
b01_bebf:   ror brk_scratch_lo                     ; 7EBF:  66 66
b01_bec1:   and #$3f                    ; 7EC1:  29 3f
b01_bec3:   jsr $4100                   ; 7EC3:  20 00 41
b01_bec6:   ror $6d69                   ; 7EC6:  6e 69 6d
b01_bec9:   adc (palette_dirty,x)                 ; 7EC9:  61 74
b01_becb:   adc #$6f                    ; 7ECB:  69 6f
b01_becd:   ror $000a                   ; 7ECD:  6e 0a 00
setting_animation_on_off_msg:   plp                         ; 7ED0:  28
b01_bed1:   .db p2_buttons                     ; 7ED1:  6f
b01_bed2:   ror $6f2f                   ; 7ED2:  6e 2f 6f
b01_bed5:   ror brk_scratch_lo                     ; 7ED5:  66 66
b01_bed7:   and #$3f                    ; 7ED7:  29 3f
b01_bed9:   jsr $5700                   ; 7ED9:  20 00 57
b01_bedc:   adc (brk_jmp_target_hi,x)                 ; 7EDC:  61 69
b01_bede:   .db palette_dirty                     ; 7EDE:  74
b01_bedf:   jsr $7369                   ; 7EDF:  20 69 73
b01_bee2:   jsr $6f6e                   ; 7EE2:  20 6e 6f
b01_bee5:   .db $77                     ; 7EE5:  77
b01_bee6:   jsr $2500                   ; 7EE6:  20 00 25
b01_bee9:   .db $64                     ; 7EE9:  64
b01_beea:   asl a                       ; 7EEA:  0a
b01_beeb:   eor p1_buttons                     ; 7EEB:  45 6e
b01_beed:   .db palette_dirty                     ; 7EED:  74
b01_beee:   adc ppumask_shadow                     ; 7EEE:  65 72
b01_bef0:   jsr $656e                   ; 7EF0:  20 6e 65
b01_bef3:   .db $77                     ; 7EF3:  77
b01_bef4:   jsr $6177                   ; 7EF4:  20 77 61
b01_bef7:   adc #$74                    ; 7EF7:  69 74
b01_bef9:   brk                         ; 7EF9:  00
msg_are_you_sure:   eor (ppumask_shadow,x)                 ; 7EFA:  41 72
b01_befc:   adc $20                     ; 7EFC:  65 20
b01_befe:   adc $756f,y                 ; 7EFE:  79 6f 75
b01_bf01:   jsr $7573                   ; 7F01:  20 73 75
b01_bf04:   .db ppumask_shadow                     ; 7F04:  72
b01_bf05:   adc scratch_ptr_lo                     ; 7F05:  65 00
msg_game_will_save_at_end_of_seaso:   .db $47                     ; 7F07:  47
b01_bf08:   adc ($6d,x)                 ; 7F08:  61 6d
b01_bf0a:   adc $20                     ; 7F0A:  65 20
b01_bf0c:   .db $77                     ; 7F0C:  77
b01_bf0d:   adc #$6c                    ; 7F0D:  69 6c
b01_bf0f:   jmp ($7320)                 ; 7F0F:  6c 20 73
b01_bf12:   adc (mul_acc_hi,x)                 ; 7F12:  61 76
b01_bf14:   adc $20                     ; 7F14:  65 20
b01_bf16:   adc (palette_dirty,x)                 ; 7F16:  61 74
b01_bf18:   asl a                       ; 7F18:  0a
b01_bf19:   adc p1_buttons                     ; 7F19:  65 6e
b01_bf1b:   .db $64                     ; 7F1B:  64
b01_bf1c:   jsr $666f                   ; 7F1C:  20 6f 66
b01_bf1f:   jsr $6573                   ; 7F1F:  20 73 65
b01_bf22:   adc (prg_bank_shadow,x)                 ; 7F22:  61 73
b01_bf24:   .db p2_buttons                     ; 7F24:  6f
b01_bf25:   ror $5700                   ; 7F25:  6e 00 57
b01_bf28:   adc (palette_dirty,x)                 ; 7F28:  61 74
b01_bf2a:   .db $63                     ; 7F2A:  63
b01_bf2b:   pla                         ; 7F2B:  68
b01_bf2c:   jsr $746f                   ; 7F2C:  20 6f 74
b01_bf2f:   pla                         ; 7F2F:  68
b01_bf30:   adc ppumask_shadow                     ; 7F30:  65 72
b01_bf32:   .db prg_bank_shadow                     ; 7F32:  73
b01_bf33:   asl a                       ; 7F33:  0a
b01_bf34:   .db $62                     ; 7F34:  62
b01_bf35:   adc (palette_dirty,x)                 ; 7F35:  61 74
b01_bf37:   .db palette_dirty                     ; 7F37:  74
b01_bf38:   jmp ($2065)                 ; 7F38:  6c 65 20
b01_bf3b:   brk                         ; 7F3B:  00
msg_y_n:   plp                         ; 7F3C:  28
b01_bf3d:   eor $4e2f,y                 ; 7F3D:  59 2f 4e
b01_bf40:   and #$3f                    ; 7F40:  29 3f
b01_bf42:   jsr $4400                   ; 7F42:  20 00 44
b01_bf45:   .db p2_buttons                     ; 7F45:  6f
b01_bf46:   jsr ai_turn_loop_redispatch_flag                   ; 7F46:  20 79 6f
b01_bf49:   adc $20,x                   ; 7F49:  75 20
b01_bf4b:   .db ppumask_shadow                     ; 7F4B:  72
b01_bf4c:   adc $61                     ; 7F4C:  65 61
b01_bf4e:   jmp ($796c)                 ; 7F4E:  6c 6c 79
b01_bf51:   asl a                       ; 7F51:  0a
b01_bf52:   .db $77                     ; 7F52:  77
b01_bf53:   adc (p1_buttons,x)                 ; 7F53:  61 6e
b01_bf55:   .db palette_dirty                     ; 7F55:  74
b01_bf56:   jsr $6f74                   ; 7F56:  20 74 6f
b01_bf59:   jsr $6e65                   ; 7F59:  20 65 6e
b01_bf5c:   .db $64                     ; 7F5C:  64
b01_bf5d:   jsr $6874                   ; 7F5D:  20 74 68
b01_bf60:   adc $0a                     ; 7F60:  65 0a
b01_bf62:   .db brk_scratch_hi                     ; 7F62:  67
b01_bf63:   adc ($6d,x)                 ; 7F63:  61 6d
b01_bf65:   adc scratch_ptr_lo                     ; 7F65:  65 00
command_end_game_game_over:   .db $47                     ; 7F67:  47
b01_bf68:   adc ($6d,x)                 ; 7F68:  61 6d
b01_bf6a:   adc $20                     ; 7F6A:  65 20
b01_bf6c:   .db p2_buttons                     ; 7F6C:  6f
b01_bf6d:   ror $65,x                   ; 7F6D:  76 65
b01_bf6f:   .db ppumask_shadow                     ; 7F6F:  72
b01_bf70:   brk                         ; 7F70:  00
driver_other_fmt_2d:   and $32                     ; 7F71:  25 32
b01_bf73:   .db $64                     ; 7F73:  64
b01_bf74:   brk                         ; 7F74:  00
msg_change_which:   .db $43                     ; 7F75:  43
b01_bf76:   pla                         ; 7F76:  68
b01_bf77:   adc (p1_buttons,x)                 ; 7F77:  61 6e
b01_bf79:   .db brk_scratch_hi                     ; 7F79:  67
b01_bf7a:   adc $20                     ; 7F7A:  65 20
b01_bf7c:   .db $77                     ; 7F7C:  77
b01_bf7d:   pla                         ; 7F7D:  68
b01_bf7e:   adc #$63                    ; 7F7E:  69 63
b01_bf80:   pla                         ; 7F80:  68
b01_bf81:   .db $3f                     ; 7F81:  3f
b01_bf82:   brk                         ; 7F82:  00
msg_what_a_waste:   .db $57                     ; 7F83:  57
b01_bf84:   pla                         ; 7F84:  68
b01_bf85:   adc (palette_dirty,x)                 ; 7F85:  61 74
b01_bf87:   jsr $2061                   ; 7F87:  20 61 20
b01_bf8a:   .db $77                     ; 7F8A:  77
b01_bf8b:   adc (prg_bank_shadow,x)                 ; 7F8B:  61 73
b01_bf8d:   .db palette_dirty                     ; 7F8D:  74
b01_bf8e:   adc $21                     ; 7F8E:  65 21
b01_bf90:   brk                         ; 7F90:  00
msg_your_orders:   asl a                       ; 7F91:  0a
b01_bf92:   adc $756f,y                 ; 7F92:  79 6f 75
b01_bf95:   .db ppumask_shadow                     ; 7F95:  72
b01_bf96:   jsr $726f                   ; 7F96:  20 6f 72
b01_bf99:   .db $64                     ; 7F99:  64
b01_bf9a:   adc ppumask_shadow                     ; 7F9A:  65 72
b01_bf9c:   .db prg_bank_shadow                     ; 7F9C:  73
b01_bf9d:   .db $3f                     ; 7F9D:  3f
b01_bf9e:   brk                         ; 7F9E:  00
msg_turn_2d_fief_2d:   .db $54                     ; 7F9F:  54
b01_bfa0:   adc ppumask_shadow,x                   ; 7FA0:  75 72
b01_bfa2:   ror $2520                   ; 7FA2:  6e 20 25
b01_bfa5:   .db $32                     ; 7FA5:  32
b01_bfa6:   .db $64                     ; 7FA6:  64
b01_bfa7:   jsr $4620                   ; 7FA7:  20 20 46
b01_bfaa:   adc #$65                    ; 7FAA:  69 65
b01_bfac:   ror $20                     ; 7FAC:  66 20
b01_bfae:   and $32                     ; 7FAE:  25 32
b01_bfb0:   .db $64                     ; 7FB0:  64
b01_bfb1:   brk                         ; 7FB1:  00
b01_bfb2:   .db $ff                     ; 7FB2:  ff
b01_bfb3:   .db $ff                     ; 7FB3:  ff
b01_bfb4:   .db $ff                     ; 7FB4:  ff
b01_bfb5:   .db $ff                     ; 7FB5:  ff
b01_bfb6:   .db $ff                     ; 7FB6:  ff
b01_bfb7:   .db $ff                     ; 7FB7:  ff
b01_bfb8:   .db $ff                     ; 7FB8:  ff
b01_bfb9:   .db $ff                     ; 7FB9:  ff
b01_bfba:   .db $ff                     ; 7FBA:  ff
b01_bfbb:   .db $ff                     ; 7FBB:  ff
b01_bfbc:   .db $ff                     ; 7FBC:  ff
b01_bfbd:   .db $ff                     ; 7FBD:  ff
b01_bfbe:   .db $ff                     ; 7FBE:  ff
b01_bfbf:   .db $ff                     ; 7FBF:  ff
b01_bfc0:   .db $ff                     ; 7FC0:  ff
b01_bfc1:   .db $ff                     ; 7FC1:  ff
b01_bfc2:   .db $ff                     ; 7FC2:  ff
b01_bfc3:   .db $ff                     ; 7FC3:  ff
b01_bfc4:   .db $ff                     ; 7FC4:  ff
b01_bfc5:   .db $ff                     ; 7FC5:  ff
b01_bfc6:   .db $ff                     ; 7FC6:  ff
b01_bfc7:   .db $ff                     ; 7FC7:  ff
b01_bfc8:   .db $ff                     ; 7FC8:  ff
b01_bfc9:   .db $ff                     ; 7FC9:  ff
b01_bfca:   .db $ff                     ; 7FCA:  ff
b01_bfcb:   .db $ff                     ; 7FCB:  ff
b01_bfcc:   .db $ff                     ; 7FCC:  ff
b01_bfcd:   .db $ff                     ; 7FCD:  ff
b01_bfce:   .db $ff                     ; 7FCE:  ff
b01_bfcf:   .db $ff                     ; 7FCF:  ff
b01_bfd0:   .db $ff                     ; 7FD0:  ff
b01_bfd1:   .db $ff                     ; 7FD1:  ff
b01_bfd2:   .db $ff                     ; 7FD2:  ff
b01_bfd3:   .db $ff                     ; 7FD3:  ff
b01_bfd4:   .db $ff                     ; 7FD4:  ff
b01_bfd5:   .db $ff                     ; 7FD5:  ff
b01_bfd6:   .db $ff                     ; 7FD6:  ff
b01_bfd7:   .db $ff                     ; 7FD7:  ff
b01_bfd8:   .db $ff                     ; 7FD8:  ff
b01_bfd9:   .db $ff                     ; 7FD9:  ff
b01_bfda:   .db $ff                     ; 7FDA:  ff
b01_bfdb:   .db $ff                     ; 7FDB:  ff
b01_bfdc:   .db $ff                     ; 7FDC:  ff
b01_bfdd:   .db $ff                     ; 7FDD:  ff
b01_bfde:   .db $ff                     ; 7FDE:  ff
b01_bfdf:   .db $ff                     ; 7FDF:  ff
b01_bfe0:   .db $ff                     ; 7FE0:  ff
b01_bfe1:   .db $ff                     ; 7FE1:  ff
b01_bfe2:   .db $ff                     ; 7FE2:  ff
b01_bfe3:   .db $ff                     ; 7FE3:  ff
b01_bfe4:   .db $ff                     ; 7FE4:  ff
b01_bfe5:   .db $ff                     ; 7FE5:  ff
b01_bfe6:   .db $ff                     ; 7FE6:  ff
b01_bfe7:   .db $ff                     ; 7FE7:  ff
b01_bfe8:   .db $ff                     ; 7FE8:  ff
b01_bfe9:   .db $ff                     ; 7FE9:  ff
b01_bfea:   .db $ff                     ; 7FEA:  ff
b01_bfeb:   .db $ff                     ; 7FEB:  ff
b01_bfec:   .db $ff                     ; 7FEC:  ff
b01_bfed:   .db $ff                     ; 7FED:  ff
b01_bfee:   .db $ff                     ; 7FEE:  ff
b01_bfef:   .db $ff                     ; 7FEF:  ff
b01_bff0:   .db $ff                     ; 7FF0:  ff
b01_bff1:   .db $ff                     ; 7FF1:  ff
b01_bff2:   .db $ff                     ; 7FF2:  ff
b01_bff3:   .db $ff                     ; 7FF3:  ff
b01_bff4:   .db $ff                     ; 7FF4:  ff
b01_bff5:   .db $ff                     ; 7FF5:  ff
b01_bff6:   .db $ff                     ; 7FF6:  ff
b01_bff7:   .db $ff                     ; 7FF7:  ff
b01_bff8:   .db $ff                     ; 7FF8:  ff
b01_bff9:   .db $ff                     ; 7FF9:  ff
b01_bffa:   .db $ff                     ; 7FFA:  ff
b01_bffb:   .db $ff                     ; 7FFB:  ff
b01_bffc:   .db $ff                     ; 7FFC:  ff
b01_bffd:   .db $ff                     ; 7FFD:  ff
b01_bffe:   .db $ff                     ; 7FFE:  ff
b01_bfff:   .db $ff                     ; 7FFF:  ff