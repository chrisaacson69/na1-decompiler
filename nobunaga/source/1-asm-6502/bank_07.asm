.base $8000

b07_8000:   jmp $0000                   ; 1C000:  4c 00 00
b07_8003:   brk                         ; 1C003:  00
b07_8004:   brk                         ; 1C004:  00
b07_8005:   brk                         ; 1C005:  00
b07_8006:   brk                         ; 1C006:  00
b07_8007:   brk                         ; 1C007:  00
b07_8008:   brk                         ; 1C008:  00
b07_8009:   brk                         ; 1C009:  00
b07_800a:   brk                         ; 1C00A:  00
b07_800b:   brk                         ; 1C00B:  00
b07_800c:   tax                         ; 1C00C:  aa
b07_800d:   tax                         ; 1C00D:  aa
b07_800e:   tax                         ; 1C00E:  aa
b07_800f:   tax                         ; 1C00F:  aa
b07_8010:   tax                         ; 1C010:  aa
b07_8011:   tax                         ; 1C011:  aa
b07_8012:   tax                         ; 1C012:  aa
b07_8013:   tax                         ; 1C013:  aa
b07_8014:   brk                         ; 1C014:  00
b07_8015:   brk                         ; 1C015:  00
b07_8016:   brk                         ; 1C016:  00
b07_8017:   brk                         ; 1C017:  00
b07_8018:   ora ($07,x)                 ; 1C018:  01 07
b07_801a:   .db $0f                     ; 1C01A:  0f
b07_801b:   .db $1f                     ; 1C01B:  1f
b07_801c:   tax                         ; 1C01C:  aa
b07_801d:   tax                         ; 1C01D:  aa
b07_801e:   tax                         ; 1C01E:  aa
b07_801f:   tay                         ; 1C01F:  a8
b07_8020:   ldy #$a0                    ; 1C020:  a0 a0
b07_8022:   .db $80                     ; 1C022:  80
b07_8023:   .db $80                     ; 1C023:  80
b07_8024:   .db $1f                     ; 1C024:  1f
b07_8025:   .db $0f                     ; 1C025:  0f
b07_8026:   .db $0f                     ; 1C026:  0f
b07_8027:   .db $3f                     ; 1C027:  3f
b07_8028:   .db $3f                     ; 1C028:  3f
b07_8029:   .db $7f                     ; 1C029:  7f
b07_802a:   .db $7f                     ; 1C02A:  7f
b07_802b:   .db $7f                     ; 1C02B:  7f
b07_802c:   .db $80                     ; 1C02C:  80
b07_802d:   .db $80                     ; 1C02D:  80
b07_802e:   .db $80                     ; 1C02E:  80
b07_802f:   brk                         ; 1C02F:  00
b07_8030:   brk                         ; 1C030:  00
b07_8031:   brk                         ; 1C031:  00
b07_8032:   brk                         ; 1C032:  00
b07_8033:   brk                         ; 1C033:  00
b07_8034:   brk                         ; 1C034:  00
b07_8035:   brk                         ; 1C035:  00
b07_8036:   brk                         ; 1C036:  00
b07_8037:   .db $3f                     ; 1C037:  3f
b07_8038:   .db $ff                     ; 1C038:  ff
b07_8039:   .db $ff                     ; 1C039:  ff
b07_803a:   .db $ff                     ; 1C03A:  ff
b07_803b:   .db $ff                     ; 1C03B:  ff
b07_803c:   tax                         ; 1C03C:  aa
b07_803d:   tax                         ; 1C03D:  aa
b07_803e:   brk                         ; 1C03E:  00
b07_803f:   brk                         ; 1C03F:  00
b07_8040:   brk                         ; 1C040:  00
b07_8041:   brk                         ; 1C041:  00
b07_8042:   brk                         ; 1C042:  00
b07_8043:   brk                         ; 1C043:  00
b07_8044:   brk                         ; 1C044:  00
b07_8045:   brk                         ; 1C045:  00
b07_8046:   brk                         ; 1C046:  00
b07_8047:   cpx #$f0                    ; 1C047:  e0 f0
b07_8049:   sed                         ; 1C049:  f8
b07_804a:   beq $800c                   ; 1C04A:  f0 c0
b07_804c:   .db $80                     ; 1C04C:  80
b07_804d:   .db $80                     ; 1C04D:  80
b07_804e:   brk                         ; 1C04E:  00
b07_804f:   .db $1c                     ; 1C04F:  1c
b07_8050:   .db $0f                     ; 1C050:  0f
b07_8051:   .db $04                     ; 1C051:  04
b07_8052:   brk                         ; 1C052:  00
b07_8053:   brk                         ; 1C053:  00
b07_8054:   .db $ff                     ; 1C054:  ff
b07_8055:   .db $ff                     ; 1C055:  ff
b07_8056:   inc $ffff,x                 ; 1C056:  fe ff ff
b07_8059:   .db $ff                     ; 1C059:  ff
b07_805a:   .db $ff                     ; 1C05A:  ff
b07_805b:   .db $ff                     ; 1C05B:  ff
b07_805c:   brk                         ; 1C05C:  00
b07_805d:   brk                         ; 1C05D:  00
b07_805e:   brk                         ; 1C05E:  00
b07_805f:   brk                         ; 1C05F:  00
b07_8060:   brk                         ; 1C060:  00
b07_8061:   brk                         ; 1C061:  00
b07_8062:   brk                         ; 1C062:  00
b07_8063:   brk                         ; 1C063:  00
b07_8064:   .db $80                     ; 1C064:  80
b07_8065:   brk                         ; 1C065:  00
b07_8066:   brk                         ; 1C066:  00
b07_8067:   sed                         ; 1C067:  f8
b07_8068:   sed                         ; 1C068:  f8
b07_8069:   sed                         ; 1C069:  f8
b07_806a:   sed                         ; 1C06A:  f8
b07_806b:   sed                         ; 1C06B:  f8
b07_806c:   brk                         ; 1C06C:  00
b07_806d:   brk                         ; 1C06D:  00
b07_806e:   brk                         ; 1C06E:  00
b07_806f:   brk                         ; 1C06F:  00
b07_8070:   asl $07                     ; 1C070:  06 07
b07_8072:   asl $04                     ; 1C072:  06 04
b07_8074:   brk                         ; 1C074:  00
b07_8075:   brk                         ; 1C075:  00
b07_8076:   brk                         ; 1C076:  00
b07_8077:   brk                         ; 1C077:  00
b07_8078:   brk                         ; 1C078:  00
b07_8079:   brk                         ; 1C079:  00
b07_807a:   bpl $80b4                   ; 1C07A:  10 38
b07_807c:   tax                         ; 1C07C:  aa
b07_807d:   rol a                       ; 1C07D:  2a
b07_807e:   rol a                       ; 1C07E:  2a
b07_807f:   asl a                       ; 1C07F:  0a
b07_8080:   txa                         ; 1C080:  8a
b07_8081:   .db $02                     ; 1C081:  02
b07_8082:   .db $12                     ; 1C082:  12
b07_8083:   .db $3a                     ; 1C083:  3a
b07_8084:   plp                         ; 1C084:  28
b07_8085:   brk                         ; 1C085:  00
b07_8086:   brk                         ; 1C086:  00
b07_8087:   brk                         ; 1C087:  00
b07_8088:   brk                         ; 1C088:  00
b07_8089:   brk                         ; 1C089:  00
b07_808a:   brk                         ; 1C08A:  00
b07_808b:   brk                         ; 1C08B:  00
b07_808c:   rol a                       ; 1C08C:  2a
b07_808d:   brk                         ; 1C08D:  00
b07_808e:   brk                         ; 1C08E:  00
b07_808f:   brk                         ; 1C08F:  00
b07_8090:   brk                         ; 1C090:  00
b07_8091:   brk                         ; 1C091:  00
b07_8092:   brk                         ; 1C092:  00
b07_8093:   brk                         ; 1C093:  00
b07_8094:   .db $7f                     ; 1C094:  7f
b07_8095:   adc $68,x                   ; 1C095:  75 68
b07_8097:   and $203c,x                 ; 1C097:  3d 3c 20
b07_809a:   sec                         ; 1C09A:  38
b07_809b:   .db $3f                     ; 1C09B:  3f
b07_809c:   brk                         ; 1C09C:  00
b07_809d:   brk                         ; 1C09D:  00
b07_809e:   brk                         ; 1C09E:  00
b07_809f:   .db $02                     ; 1C09F:  02
b07_80a0:   .db $83                     ; 1C0A0:  83
b07_80a1:   sta ($88,x)                 ; 1C0A1:  81 88
b07_80a3:   .db $80                     ; 1C0A3:  80
b07_80a4:   .db $7f                     ; 1C0A4:  7f
b07_80a5:   .db $7f                     ; 1C0A5:  7f
b07_80a6:   .db $7f                     ; 1C0A6:  7f
b07_80a7:   ror $7f7e,x                 ; 1C0A7:  7e 7e 7f
b07_80aa:   .db $7f                     ; 1C0AA:  7f
b07_80ab:   .db $3f                     ; 1C0AB:  3f
b07_80ac:   .db $80                     ; 1C0AC:  80
b07_80ad:   .db $80                     ; 1C0AD:  80
b07_80ae:   .db $80                     ; 1C0AE:  80
b07_80af:   .db $80                     ; 1C0AF:  80
b07_80b0:   .db $80                     ; 1C0B0:  80
b07_80b1:   .db $80                     ; 1C0B1:  80
b07_80b2:   .db $80                     ; 1C0B2:  80
b07_80b3:   .db $80                     ; 1C0B3:  80
b07_80b4:   .db $ff                     ; 1C0B4:  ff
b07_80b5:   .db $fa                     ; 1C0B5:  fa
b07_80b6:   beq $80a9                   ; 1C0B6:  f0 f1
b07_80b8:   .db $e7                     ; 1C0B8:  e7
b07_80b9:   cpx $ffff                   ; 1C0B9:  ec ff ff
b07_80bc:   brk                         ; 1C0BC:  00
b07_80bd:   brk                         ; 1C0BD:  00
b07_80be:   brk                         ; 1C0BE:  00
b07_80bf:   asl $1018                   ; 1C0BF:  0e 18 10
b07_80c2:   ora ($00,x)                 ; 1C0C2:  01 00
b07_80c4:   beq $80b6                   ; 1C0C4:  f0 f0
b07_80c6:   rti                         ; 1C0C6:  40
b07_80c7:   sed                         ; 1C0C7:  f8
b07_80c8:   .db $fc                     ; 1C0C8:  fc
b07_80c9:   clc                         ; 1C0C9:  18
b07_80ca:   plp                         ; 1C0CA:  28
b07_80cb:   sed                         ; 1C0CB:  f8
b07_80cc:   .db $0f                     ; 1C0CC:  0f
b07_80cd:   asl $071f                   ; 1C0CD:  0e 1f 07
b07_80d0:   .db $03                     ; 1C0D0:  03
b07_80d1:   .db $07                     ; 1C0D1:  07
b07_80d2:   .db $27                     ; 1C0D2:  27
b07_80d3:   .db $07                     ; 1C0D3:  07
b07_80d4:   .db $ff                     ; 1C0D4:  ff
b07_80d5:   .db $6f                     ; 1C0D5:  6f
b07_80d6:   .db $e7                     ; 1C0D6:  e7
b07_80d7:   .db $f7                     ; 1C0D7:  f7
b07_80d8:   .db $c7                     ; 1C0D8:  c7
b07_80d9:   .db $0f                     ; 1C0D9:  0f
b07_80da:   .db $ff                     ; 1C0DA:  ff
b07_80db:   .db $ff                     ; 1C0DB:  ff
b07_80dc:   brk                         ; 1C0DC:  00
b07_80dd:   bcc $80f7                   ; 1C0DD:  90 18
b07_80df:   php                         ; 1C0DF:  08
b07_80e0:   php                         ; 1C0E0:  08
b07_80e1:   bvs $80e3                   ; 1C0E1:  70 00
b07_80e3:   brk                         ; 1C0E3:  00
b07_80e4:   sed                         ; 1C0E4:  f8
b07_80e5:   .db $fc                     ; 1C0E5:  fc
b07_80e6:   .db $fc                     ; 1C0E6:  fc
b07_80e7:   .db $fc                     ; 1C0E7:  fc
b07_80e8:   .db $fc                     ; 1C0E8:  fc
b07_80e9:   .db $fc                     ; 1C0E9:  fc
b07_80ea:   sed                         ; 1C0EA:  f8
b07_80eb:   sed                         ; 1C0EB:  f8
b07_80ec:   .db $07                     ; 1C0EC:  07
b07_80ed:   .db $03                     ; 1C0ED:  03
b07_80ee:   .db $03                     ; 1C0EE:  03
b07_80ef:   .db $03                     ; 1C0EF:  03
b07_80f0:   .db $03                     ; 1C0F0:  03
b07_80f1:   .db $03                     ; 1C0F1:  03
b07_80f2:   .db $07                     ; 1C0F2:  07
b07_80f3:   .db $07                     ; 1C0F3:  07
b07_80f4:   brk                         ; 1C0F4:  00
b07_80f5:   brk                         ; 1C0F5:  00
b07_80f6:   brk                         ; 1C0F6:  00
b07_80f7:   brk                         ; 1C0F7:  00
b07_80f8:   brk                         ; 1C0F8:  00
b07_80f9:   brk                         ; 1C0F9:  00
b07_80fa:   brk                         ; 1C0FA:  00
b07_80fb:   brk                         ; 1C0FB:  00
b07_80fc:   brk                         ; 1C0FC:  00
b07_80fd:   brk                         ; 1C0FD:  00
b07_80fe:   brk                         ; 1C0FE:  00
b07_80ff:   .db $0c                     ; 1C0FF:  0c
b07_8100:   .db $92                     ; 1C100:  92
b07_8101:   .db $22                     ; 1C101:  22
b07_8102:   ldx $5a                     ; 1C102:  a6 5a
b07_8104:   brk                         ; 1C104:  00
b07_8105:   brk                         ; 1C105:  00
b07_8106:   brk                         ; 1C106:  00
b07_8107:   brk                         ; 1C107:  00
b07_8108:   brk                         ; 1C108:  00
b07_8109:   brk                         ; 1C109:  00
b07_810a:   brk                         ; 1C10A:  00
b07_810b:   brk                         ; 1C10B:  00
b07_810c:   inc $ee                     ; 1C10C:  e6 ee
b07_810e:   dec $fc                     ; 1C10E:  c6 fc
b07_8110:   .db $f2                     ; 1C110:  f2
b07_8111:   .db $c2                     ; 1C111:  c2
b07_8112:   .db $e2                     ; 1C112:  e2
b07_8113:   .db $c2                     ; 1C113:  c2
b07_8114:   .db $3f                     ; 1C114:  3f
b07_8115:   rol $1f1f,x                 ; 1C115:  3e 1f 1f
b07_8118:   .db $0f                     ; 1C118:  0f
b07_8119:   .db $0f                     ; 1C119:  0f
b07_811a:   .db $07                     ; 1C11A:  07
b07_811b:   .db $03                     ; 1C11B:  03
b07_811c:   .db $80                     ; 1C11C:  80
b07_811d:   .db $80                     ; 1C11D:  80
b07_811e:   .db $80                     ; 1C11E:  80
b07_811f:   ldy #$a0                    ; 1C11F:  a0 a0
b07_8121:   ldy #$a0                    ; 1C121:  a0 a0
b07_8123:   ldy #$00                    ; 1C123:  a0 00
b07_8125:   brk                         ; 1C125:  00
b07_8126:   .db $17                     ; 1C126:  17
b07_8127:   cmp $dd77,x                 ; 1C127:  dd 77 dd
b07_812a:   .db $77                     ; 1C12A:  77
b07_812b:   cmp $aaaa,x                 ; 1C12B:  dd aa aa
b07_812e:   .db $b7                     ; 1C12E:  b7
b07_812f:   cmp $dd77,x                 ; 1C12F:  dd 77 dd
b07_8132:   .db $77                     ; 1C132:  77
b07_8133:   cmp $cc06,x                 ; 1C133:  dd 06 cc
b07_8136:   lsr $dc,x                   ; 1C136:  56 dc
b07_8138:   rol $9c,x                   ; 1C138:  36 9c
b07_813a:   adc $5c,x                   ; 1C13A:  75 5c
b07_813c:   ldx $cc                     ; 1C13C:  a6 cc
b07_813e:   lsr $dc,x                   ; 1C13E:  56 dc
b07_8140:   rol $9d,x                   ; 1C140:  36 9d
b07_8142:   .db $74                     ; 1C142:  74
b07_8143:   eor $700f,x                 ; 1C143:  5d 0f 70
b07_8146:   brk                         ; 1C146:  00
b07_8147:   .db $ff                     ; 1C147:  ff
b07_8148:   .db $8f                     ; 1C148:  8f
b07_8149:   .db $8f                     ; 1C149:  8f
b07_814a:   .db $ff                     ; 1C14A:  ff
b07_814b:   .db $ff                     ; 1C14B:  ff
b07_814c:   brk                         ; 1C14C:  00
b07_814d:   adc ($00),y                 ; 1C14D:  71 00
b07_814f:   brk                         ; 1C14F:  00
b07_8150:   jsr $0070                   ; 1C150:  20 70 00
b07_8153:   brk                         ; 1C153:  00
b07_8154:   sed                         ; 1C154:  f8
b07_8155:   sed                         ; 1C155:  f8
b07_8156:   beq $8148                   ; 1C156:  f0 f0
b07_8158:   cpx #$e0                    ; 1C158:  e0 e0
b07_815a:   cpy #$80                    ; 1C15A:  c0 80
b07_815c:   .db $07                     ; 1C15C:  07
b07_815d:   .db $07                     ; 1C15D:  07
b07_815e:   .db $0f                     ; 1C15E:  0f
b07_815f:   asl $191c                   ; 1C15F:  0e 1c 19
b07_8162:   .db $33                     ; 1C162:  33
b07_8163:   .db $47                     ; 1C163:  47
b07_8164:   .db $ff                     ; 1C164:  ff
b07_8165:   sei                         ; 1C165:  78
b07_8166:   .db $80                     ; 1C166:  80
b07_8167:   cpy #$50                    ; 1C167:  c0 50
b07_8169:   .db $df                     ; 1C169:  df
b07_816a:   .db $6f                     ; 1C16A:  6f
b07_816b:   .db $b7                     ; 1C16B:  b7
b07_816c:   brk                         ; 1C16C:  00
b07_816d:   brk                         ; 1C16D:  00
b07_816e:   .db $80                     ; 1C16E:  80
b07_816f:   cmp ($cf,x)                 ; 1C16F:  c1 cf
b07_8171:   rti                         ; 1C171:  40
b07_8172:   cpx #$71                    ; 1C172:  e0 71
b07_8174:   brk                         ; 1C174:  00
b07_8175:   ora ($03,x)                 ; 1C175:  01 03
b07_8177:   asl $7c,x                   ; 1C177:  16 7c
b07_8179:   sbc $e5f2,y                 ; 1C179:  f9 f2 e5
b07_817c:   .db $0f                     ; 1C17C:  0f
b07_817d:   .db $1f                     ; 1C17D:  1f
b07_817e:   .db $7f                     ; 1C17E:  7f
b07_817f:   inc $1a8d                   ; 1C17F:  ee 8d 1a
b07_8182:   adc $ea,x                   ; 1C182:  75 ea
b07_8184:   brk                         ; 1C184:  00
b07_8185:   bpl $8197                   ; 1C185:  10 10
b07_8187:   bpl $81bd                   ; 1C187:  10 34
b07_8189:   jsr $5166                   ; 1C189:  20 66 51
b07_818c:   .db $c2                     ; 1C18C:  c2
b07_818d:   .db $f2                     ; 1C18D:  f2
b07_818e:   .db $72                     ; 1C18E:  72
b07_818f:   .db $f2                     ; 1C18F:  f2
b07_8190:   inc $e0,x                   ; 1C190:  f6 e0
b07_8192:   inc $c1                     ; 1C192:  e6 c1
b07_8194:   brk                         ; 1C194:  00
b07_8195:   brk                         ; 1C195:  00
b07_8196:   brk                         ; 1C196:  00
b07_8197:   brk                         ; 1C197:  00
b07_8198:   brk                         ; 1C198:  00
b07_8199:   brk                         ; 1C199:  00
b07_819a:   brk                         ; 1C19A:  00
b07_819b:   .db $80                     ; 1C19B:  80
b07_819c:   tax                         ; 1C19C:  aa
b07_819d:   tax                         ; 1C19D:  aa
b07_819e:   tax                         ; 1C19E:  aa
b07_819f:   tax                         ; 1C19F:  aa
b07_81a0:   tax                         ; 1C1A0:  aa
b07_81a1:   tax                         ; 1C1A1:  aa
b07_81a2:   tax                         ; 1C1A2:  aa
b07_81a3:   tax                         ; 1C1A3:  aa
b07_81a4:   dec $89                     ; 1C1A4:  c6 89
b07_81a6:   rol $49                     ; 1C1A6:  26 49
b07_81a8:   ldx $8e5b                   ; 1C1A8:  ae 5b 8e
b07_81ab:   .db $5b                     ; 1C1AB:  5b
b07_81ac:   dec $a9,x                   ; 1C1AC:  d6 a9
b07_81ae:   lsr $a9                     ; 1C1AE:  46 a9
b07_81b0:   lsr $4e9b                   ; 1C1B0:  4e 9b 4e
b07_81b3:   .db $9b                     ; 1C1B3:  9b
b07_81b4:   brk                         ; 1C1B4:  00
b07_81b5:   tya                         ; 1C1B5:  98
b07_81b6:   rol $99                     ; 1C1B6:  26 99
b07_81b8:   rol $9b                     ; 1C1B8:  26 9b
b07_81ba:   rol $2abb                   ; 1C1BA:  2e bb 2a
b07_81bd:   txs                         ; 1C1BD:  9a
b07_81be:   rol $99                     ; 1C1BE:  26 99
b07_81c0:   rol $9b                     ; 1C1C0:  26 9b
b07_81c2:   rol $00bb                   ; 1C1C2:  2e bb 00
b07_81c5:   brk                         ; 1C1C5:  00
b07_81c6:   brk                         ; 1C1C6:  00
b07_81c7:   brk                         ; 1C1C7:  00
b07_81c8:   brk                         ; 1C1C8:  00
b07_81c9:   brk                         ; 1C1C9:  00
b07_81ca:   brk                         ; 1C1CA:  00
b07_81cb:   brk                         ; 1C1CB:  00
b07_81cc:   .db $ff                     ; 1C1CC:  ff
b07_81cd:   tax                         ; 1C1CD:  aa
b07_81ce:   .db $ff                     ; 1C1CE:  ff
b07_81cf:   tax                         ; 1C1CF:  aa
b07_81d0:   .db $ff                     ; 1C1D0:  ff
b07_81d1:   tax                         ; 1C1D1:  aa
b07_81d2:   .db $ff                     ; 1C1D2:  ff
b07_81d3:   tax                         ; 1C1D3:  aa
b07_81d4:   brk                         ; 1C1D4:  00
b07_81d5:   brk                         ; 1C1D5:  00
b07_81d6:   brk                         ; 1C1D6:  00
b07_81d7:   brk                         ; 1C1D7:  00
b07_81d8:   brk                         ; 1C1D8:  00
b07_81d9:   brk                         ; 1C1D9:  00
b07_81da:   brk                         ; 1C1DA:  00
b07_81db:   ora ($ff,x)                 ; 1C1DB:  01 ff
b07_81dd:   tax                         ; 1C1DD:  aa
b07_81de:   .db $ff                     ; 1C1DE:  ff
b07_81df:   tax                         ; 1C1DF:  aa
b07_81e0:   .db $fc                     ; 1C1E0:  fc
b07_81e1:   tay                         ; 1C1E1:  a8
b07_81e2:   beq $8184                   ; 1C1E2:  f0 a0
b07_81e4:   .db $1b                     ; 1C1E4:  1b
b07_81e5:   .db $13                     ; 1C1E5:  13
b07_81e6:   ora #$00                    ; 1C1E6:  09 00
b07_81e8:   .db $03                     ; 1C1E8:  03
b07_81e9:   .db $07                     ; 1C1E9:  07
b07_81ea:   .db $07                     ; 1C1EA:  07
b07_81eb:   .db $07                     ; 1C1EB:  07
b07_81ec:   cld                         ; 1C1EC:  d8
b07_81ed:   bcc $8177                   ; 1C1ED:  90 88
b07_81ef:   .db $80                     ; 1C1EF:  80
b07_81f0:   .db $80                     ; 1C1F0:  80
b07_81f1:   brk                         ; 1C1F1:  00
b07_81f2:   brk                         ; 1C1F2:  00
b07_81f3:   brk                         ; 1C1F3:  00
b07_81f4:   brk                         ; 1C1F4:  00
b07_81f5:   brk                         ; 1C1F5:  00
b07_81f6:   brk                         ; 1C1F6:  00
b07_81f7:   brk                         ; 1C1F7:  00
b07_81f8:   .db $1f                     ; 1C1F8:  1f
b07_81f9:   .db $7f                     ; 1C1F9:  7f
b07_81fa:   .db $ff                     ; 1C1FA:  ff
b07_81fb:   .db $ff                     ; 1C1FB:  ff
b07_81fc:   .db $c7                     ; 1C1FC:  c7
b07_81fd:   .db $82                     ; 1C1FD:  82
b07_81fe:   .db $43                     ; 1C1FE:  43
b07_81ff:   .db $80                     ; 1C1FF:  80
b07_8200:   brk                         ; 1C200:  00
b07_8201:   brk                         ; 1C201:  00
b07_8202:   brk                         ; 1C202:  00
b07_8203:   brk                         ; 1C203:  00
b07_8204:   brk                         ; 1C204:  00
b07_8205:   brk                         ; 1C205:  00
b07_8206:   brk                         ; 1C206:  00
b07_8207:   brk                         ; 1C207:  00
b07_8208:   cpx #$f8                    ; 1C208:  e0 f8
b07_820a:   .db $fc                     ; 1C20A:  fc
b07_820b:   inc $aaff,x                 ; 1C20B:  fe ff aa
b07_820e:   .db $ff                     ; 1C20E:  ff
b07_820f:   .db $02                     ; 1C20F:  02
b07_8210:   ora $0306,y                 ; 1C210:  19 06 03
b07_8213:   ora ($ff,x)                 ; 1C213:  01 ff
b07_8215:   .db $ff                     ; 1C215:  ff
b07_8216:   .db $ff                     ; 1C216:  ff
b07_8217:   .db $7f                     ; 1C217:  7f
b07_8218:   .db $ff                     ; 1C218:  ff
b07_8219:   .db $ff                     ; 1C219:  ff
b07_821a:   .db $ff                     ; 1C21A:  ff
b07_821b:   .db $ff                     ; 1C21B:  ff
b07_821c:   brk                         ; 1C21C:  00
b07_821d:   brk                         ; 1C21D:  00
b07_821e:   brk                         ; 1C21E:  00
b07_821f:   brk                         ; 1C21F:  00
b07_8220:   brk                         ; 1C220:  00
b07_8221:   brk                         ; 1C221:  00
b07_8222:   brk                         ; 1C222:  00
b07_8223:   brk                         ; 1C223:  00
b07_8224:   .db $ff                     ; 1C224:  ff
b07_8225:   .db $ff                     ; 1C225:  ff
b07_8226:   .db $ff                     ; 1C226:  ff
b07_8227:   .db $ff                     ; 1C227:  ff
b07_8228:   .db $ff                     ; 1C228:  ff
b07_8229:   .db $ff                     ; 1C229:  ff
b07_822a:   .db $ff                     ; 1C22A:  ff
b07_822b:   .db $ff                     ; 1C22B:  ff
b07_822c:   brk                         ; 1C22C:  00
b07_822d:   brk                         ; 1C22D:  00
b07_822e:   brk                         ; 1C22E:  00
b07_822f:   brk                         ; 1C22F:  00
b07_8230:   brk                         ; 1C230:  00
b07_8231:   brk                         ; 1C231:  00
b07_8232:   brk                         ; 1C232:  00
b07_8233:   brk                         ; 1C233:  00
b07_8234:   brk                         ; 1C234:  00
b07_8235:   brk                         ; 1C235:  00
b07_8236:   brk                         ; 1C236:  00
b07_8237:   brk                         ; 1C237:  00
b07_8238:   brk                         ; 1C238:  00
b07_8239:   brk                         ; 1C239:  00
b07_823a:   brk                         ; 1C23A:  00
b07_823b:   brk                         ; 1C23B:  00
b07_823c:   .db $ff                     ; 1C23C:  ff
b07_823d:   tax                         ; 1C23D:  aa
b07_823e:   .db $ff                     ; 1C23E:  ff
b07_823f:   tax                         ; 1C23F:  aa
b07_8240:   .db $ff                     ; 1C240:  ff
b07_8241:   rol a                       ; 1C241:  2a
b07_8242:   .db $3f                     ; 1C242:  3f
b07_8243:   txa                         ; 1C243:  8a
b07_8244:   brk                         ; 1C244:  00
b07_8245:   brk                         ; 1C245:  00
b07_8246:   .db $80                     ; 1C246:  80
b07_8247:   .db $80                     ; 1C247:  80
b07_8248:   .db $80                     ; 1C248:  80
b07_8249:   cpy #$e0                    ; 1C249:  c0 e0
b07_824b:   cpx #$cf                    ; 1C24B:  e0 cf
b07_824d:   dex                         ; 1C24D:  ca
b07_824e:   .db $67                     ; 1C24E:  67
b07_824f:   .db $62                     ; 1C24F:  62
b07_8250:   .db $73                     ; 1C250:  73
b07_8251:   bmi $8266                   ; 1C251:  30 13
b07_8253:   .db $12                     ; 1C253:  12
b07_8254:   .db $0f                     ; 1C254:  0f
b07_8255:   .db $0f                     ; 1C255:  0f
b07_8256:   .db $0f                     ; 1C256:  0f
b07_8257:   .db $07                     ; 1C257:  07
b07_8258:   .db $07                     ; 1C258:  07
b07_8259:   .db $67                     ; 1C259:  67
b07_825a:   .db $57                     ; 1C25A:  57
b07_825b:   .db $4f                     ; 1C25B:  4f
b07_825c:   brk                         ; 1C25C:  00
b07_825d:   .db $80                     ; 1C25D:  80
b07_825e:   brk                         ; 1C25E:  00
b07_825f:   .db $80                     ; 1C25F:  80
b07_8260:   .db $80                     ; 1C260:  80
b07_8261:   brk                         ; 1C261:  00
b07_8262:   brk                         ; 1C262:  00
b07_8263:   brk                         ; 1C263:  00
b07_8264:   .db $47                     ; 1C264:  47
b07_8265:   .db $4f                     ; 1C265:  4f
b07_8266:   .db $47                     ; 1C266:  47
b07_8267:   .db $27                     ; 1C267:  27
b07_8268:   .db $1f                     ; 1C268:  1f
b07_8269:   .db $03                     ; 1C269:  03
b07_826a:   .db $03                     ; 1C26A:  03
b07_826b:   .db $03                     ; 1C26B:  03
b07_826c:   bmi $826e                   ; 1C26C:  30 00
b07_826e:   jsr $c090                   ; 1C26E:  20 90 c0
b07_8271:   ldy #$e0                    ; 1C271:  a0 e0
b07_8273:   ldy #$c1                    ; 1C273:  a0 c1
b07_8275:   bvs $826f                   ; 1C275:  70 f8
b07_8277:   .db $fc                     ; 1C277:  fc
b07_8278:   cpx #$d2                    ; 1C278:  e0 d2
b07_827a:   inc $00fd,x                 ; 1C27A:  fe fd 00
b07_827d:   php                         ; 1C27D:  08
b07_827e:   .db $07                     ; 1C27E:  07
b07_827f:   .db $03                     ; 1C27F:  03
b07_8280:   brk                         ; 1C280:  00
b07_8281:   .db $12                     ; 1C281:  12
b07_8282:   ora ($02,x)                 ; 1C282:  01 02
b07_8284:   ldx $3138,y                 ; 1C284:  be 38 31
b07_8287:   .db $73                     ; 1C287:  73
b07_8288:   bvs $82fc                   ; 1C288:  70 72
b07_828a:   .db $f3                     ; 1C28A:  f3
b07_828b:   sbc ($40),y                 ; 1C28B:  f1 40
b07_828d:   cpy #$46                    ; 1C28D:  c0 46
b07_828f:   sty $8a8c                   ; 1C28F:  8c 8c 8a
b07_8292:   .db $0c                     ; 1C292:  0c
b07_8293:   asl $fffb                   ; 1C293:  0e fb ff
b07_8296:   .db $ff                     ; 1C296:  ff
b07_8297:   inc $fdfe,x                 ; 1C297:  fe fe fd
b07_829a:   .db $ff                     ; 1C29A:  ff
b07_829b:   sbc $0004,x                 ; 1C29B:  fd 04 00
b07_829e:   brk                         ; 1C29E:  00
b07_829f:   ora ($01,x)                 ; 1C29F:  01 01
b07_82a1:   .db $02                     ; 1C2A1:  02
b07_82a2:   brk                         ; 1C2A2:  00
b07_82a3:   .db $02                     ; 1C2A3:  02
b07_82a4:   .db $fb                     ; 1C2A4:  fb
b07_82a5:   .db $7b                     ; 1C2A5:  7b
b07_82a6:   and $38fd,y                 ; 1C2A6:  39 fd 38
b07_82a9:   brk                         ; 1C2A9:  00
b07_82aa:   .db $80                     ; 1C2AA:  80
b07_82ab:   .db $fc                     ; 1C2AB:  fc
b07_82ac:   .db $04                     ; 1C2AC:  04
b07_82ad:   sty $82                     ; 1C2AD:  84 82
b07_82af:   .db $02                     ; 1C2AF:  02
b07_82b0:   .db $03                     ; 1C2B0:  03
b07_82b1:   .db $87                     ; 1C2B1:  87
b07_82b2:   .db $7f                     ; 1C2B2:  7f
b07_82b3:   .db $03                     ; 1C2B3:  03
b07_82b4:   brk                         ; 1C2B4:  00
b07_82b5:   brk                         ; 1C2B5:  00
b07_82b6:   brk                         ; 1C2B6:  00
b07_82b7:   brk                         ; 1C2B7:  00
b07_82b8:   brk                         ; 1C2B8:  00
b07_82b9:   rti                         ; 1C2B9:  40
b07_82ba:   cpx #$c0                    ; 1C2BA:  e0 c0
b07_82bc:   .db $77                     ; 1C2BC:  77
b07_82bd:   .db $d2                     ; 1C2BD:  d2
b07_82be:   .db $f7                     ; 1C2BE:  f7
b07_82bf:   .db $f2                     ; 1C2BF:  f2
b07_82c0:   .db $13                     ; 1C2C0:  13
b07_82c1:   .db $54                     ; 1C2C1:  54
b07_82c2:   ora $e034,x                 ; 1C2C2:  1d 34 e0
b07_82c5:   cpx #$e0                    ; 1C2C5:  e0 e0
b07_82c7:   cpx #$e0                    ; 1C2C7:  e0 e0
b07_82c9:   cpy #$40                    ; 1C2C9:  c0 40
b07_82cb:   brk                         ; 1C2CB:  00
b07_82cc:   ora $1b14,x                 ; 1C2CC:  1d 14 1b
b07_82cf:   .db $1a                     ; 1C2CF:  1a
b07_82d0:   .db $1b                     ; 1C2D0:  1b
b07_82d1:   .db $3a                     ; 1C2D1:  3a
b07_82d2:   .db $bb                     ; 1C2D2:  bb
b07_82d3:   .db $f2                     ; 1C2D3:  f2
b07_82d4:   brk                         ; 1C2D4:  00
b07_82d5:   brk                         ; 1C2D5:  00
b07_82d6:   brk                         ; 1C2D6:  00
b07_82d7:   brk                         ; 1C2D7:  00
b07_82d8:   brk                         ; 1C2D8:  00
b07_82d9:   brk                         ; 1C2D9:  00
b07_82da:   brk                         ; 1C2DA:  00
b07_82db:   .db $04                     ; 1C2DB:  04
b07_82dc:   .db $ff                     ; 1C2DC:  ff
b07_82dd:   tax                         ; 1C2DD:  aa
b07_82de:   .db $ff                     ; 1C2DE:  ff
b07_82df:   tax                         ; 1C2DF:  aa
b07_82e0:   .db $ff                     ; 1C2E0:  ff
b07_82e1:   tax                         ; 1C2E1:  aa
b07_82e2:   sed                         ; 1C2E2:  f8
b07_82e3:   asl $03                     ; 1C2E3:  06 03
b07_82e5:   ora ($07,x)                 ; 1C2E5:  01 07
b07_82e7:   asl $0b07                   ; 1C2E7:  0e 07 0b
b07_82ea:   .db $33                     ; 1C2EA:  33
b07_82eb:   sta $a8f8                   ; 1C2EB:  8d f8 a8
b07_82ee:   .db $f4                     ; 1C2EE:  f4
b07_82ef:   ldy $8aee                   ; 1C2EF:  ac ee 8a
b07_82f2:   .db $3b                     ; 1C2F2:  3b
b07_82f3:   lda $cc33                   ; 1C2F3:  ad 33 cc
b07_82f6:   .db $33                     ; 1C2F6:  33
b07_82f7:   cpy $cc33                   ; 1C2F7:  cc 33 cc
b07_82fa:   .db $33                     ; 1C2FA:  33
b07_82fb:   cpy $eebb                   ; 1C2FB:  cc bb ee
b07_82fe:   .db $bb                     ; 1C2FE:  bb
b07_82ff:   inc $eebb                   ; 1C2FF:  ee bb ee
b07_8302:   .db $bb                     ; 1C302:  bb
b07_8303:   inc $8c31                   ; 1C303:  ee 31 8c
b07_8306:   .db $32                     ; 1C306:  32
b07_8307:   cpy $cc13                   ; 1C307:  cc 13 cc
b07_830a:   .db $13                     ; 1C30A:  13
b07_830b:   cpy $aeb9                   ; 1C30B:  cc b9 ae
b07_830e:   tsx                         ; 1C30E:  ba
b07_830f:   dec $ce9b                   ; 1C30F:  ce 9b ce
b07_8312:   .db $9b                     ; 1C312:  9b
b07_8313:   inc $fff8                   ; 1C313:  ee f8 ff
b07_8316:   .db $ff                     ; 1C316:  ff
b07_8317:   .db $ff                     ; 1C317:  ff
b07_8318:   .db $7f                     ; 1C318:  7f
b07_8319:   .db $9f                     ; 1C319:  9f
b07_831a:   .db $c7                     ; 1C31A:  c7
b07_831b:   sbc ($04,x)                 ; 1C31B:  e1 04
b07_831d:   brk                         ; 1C31D:  00
b07_831e:   brk                         ; 1C31E:  00
b07_831f:   brk                         ; 1C31F:  00
b07_8320:   brk                         ; 1C320:  00
b07_8321:   brk                         ; 1C321:  00
b07_8322:   brk                         ; 1C322:  00
b07_8323:   bpl $8365                   ; 1C323:  10 40
b07_8325:   .db $fc                     ; 1C325:  fc
b07_8326:   .db $80                     ; 1C326:  80
b07_8327:   brk                         ; 1C327:  00
b07_8328:   beq $8322                   ; 1C328:  f0 f8
b07_832a:   sed                         ; 1C32A:  f8
b07_832b:   sed                         ; 1C32B:  f8
b07_832c:   ora ($03,x)                 ; 1C32C:  01 03
b07_832e:   .db $07                     ; 1C32E:  07
b07_832f:   .db $57                     ; 1C32F:  57
b07_8330:   .db $0f                     ; 1C330:  0f
b07_8331:   .db $07                     ; 1C331:  07
b07_8332:   .db $07                     ; 1C332:  07
b07_8333:   .db $04                     ; 1C333:  04
b07_8334:   beq $832e                   ; 1C334:  f0 f8
b07_8336:   inc $3f7f,x                 ; 1C336:  fe 7f 3f
b07_8339:   .db $df                     ; 1C339:  df
b07_833a:   .db $2f                     ; 1C33A:  2f
b07_833b:   .db $c7                     ; 1C33B:  c7
b07_833c:   sty $c187                   ; 1C33C:  8c 87 c1
b07_833f:   rts                         ; 1C33F:  60
b07_8340:   bcs $831a                   ; 1C340:  b0 d8
b07_8342:   ldy $00e6                   ; 1C342:  ac e6 00
b07_8345:   brk                         ; 1C345:  00
b07_8346:   brk                         ; 1C346:  00
b07_8347:   sbc ($e1,x)                 ; 1C347:  e1 e1
b07_8349:   .db $e3                     ; 1C349:  e3
b07_834a:   .db $e3                     ; 1C34A:  e3
b07_834b:   dec $00                     ; 1C34B:  c6 00
b07_834d:   ora ($ff,x)                 ; 1C34D:  01 ff
b07_834f:   .db $1f                     ; 1C34F:  1f
b07_8350:   .db $1f                     ; 1C350:  1f
b07_8351:   .db $1f                     ; 1C351:  1f
b07_8352:   .db $1f                     ; 1C352:  1f
b07_8353:   rol $0000,x                 ; 1C353:  3e 00 00
b07_8356:   brk                         ; 1C356:  00
b07_8357:   brk                         ; 1C357:  00
b07_8358:   brk                         ; 1C358:  00
b07_8359:   brk                         ; 1C359:  00
b07_835a:   jsr $f700                   ; 1C35A:  20 00 f7
b07_835d:   .db $f2                     ; 1C35D:  f2
b07_835e:   .db $ef                     ; 1C35E:  ef
b07_835f:   nop                         ; 1C35F:  ea
b07_8360:   .db $df                     ; 1C360:  df
b07_8361:   txa                         ; 1C361:  8a
b07_8362:   .db $27                     ; 1C362:  27
b07_8363:   brk                         ; 1C363:  00
b07_8364:   brk                         ; 1C364:  00
b07_8365:   brk                         ; 1C365:  00
b07_8366:   brk                         ; 1C366:  00
b07_8367:   brk                         ; 1C367:  00
b07_8368:   brk                         ; 1C368:  00
b07_8369:   brk                         ; 1C369:  00
b07_836a:   brk                         ; 1C36A:  00
b07_836b:   brk                         ; 1C36B:  00
b07_836c:   .db $ff                     ; 1C36C:  ff
b07_836d:   tax                         ; 1C36D:  aa
b07_836e:   .db $ff                     ; 1C36E:  ff
b07_836f:   tax                         ; 1C36F:  aa
b07_8370:   .db $ff                     ; 1C370:  ff
b07_8371:   tax                         ; 1C371:  aa
b07_8372:   .db $ff                     ; 1C372:  ff
b07_8373:   rol a                       ; 1C373:  2a
b07_8374:   ldx #$80                    ; 1C374:  a2 80
b07_8376:   ldx #$80                    ; 1C376:  a2 80
b07_8378:   .db $22                     ; 1C378:  22
b07_8379:   clc                         ; 1C379:  18
b07_837a:   .db $62                     ; 1C37A:  62
b07_837b:   sta $80a3,y                 ; 1C37B:  99 a3 80
b07_837e:   .db $b3                     ; 1C37E:  b3
b07_837f:   .db $80                     ; 1C37F:  80
b07_8380:   .db $33                     ; 1C380:  33
b07_8381:   cli                         ; 1C381:  58
b07_8382:   .db $73                     ; 1C382:  73
b07_8383:   cmp $8800,y                 ; 1C383:  d9 00 88
b07_8386:   rol $89                     ; 1C386:  26 89
b07_8388:   rol $99                     ; 1C388:  26 99
b07_838a:   ror $99                     ; 1C38A:  66 99
b07_838c:   .db $07                     ; 1C38C:  07
b07_838d:   iny                         ; 1C38D:  c8
b07_838e:   .db $37                     ; 1C38E:  37
b07_838f:   cmp $dd37                   ; 1C38F:  cd 37 dd
b07_8392:   .db $77                     ; 1C392:  77
b07_8393:   cmp $4411,x                 ; 1C393:  dd 11 44
b07_8396:   ora ($44),y                 ; 1C396:  11 44
b07_8398:   ora ($44),y                 ; 1C398:  11 44
b07_839a:   ora ($44),y                 ; 1C39A:  11 44
b07_839c:   .db $22                     ; 1C39C:  22
b07_839d:   dey                         ; 1C39D:  88
b07_839e:   .db $22                     ; 1C39E:  22
b07_839f:   dey                         ; 1C39F:  88
b07_83a0:   .db $22                     ; 1C3A0:  22
b07_83a1:   dey                         ; 1C3A1:  88
b07_83a2:   .db $22                     ; 1C3A2:  22
b07_83a3:   dey                         ; 1C3A3:  88
b07_83a4:   ora ($44),y                 ; 1C3A4:  11 44
b07_83a6:   ora ($44),y                 ; 1C3A6:  11 44
b07_83a8:   bpl $83ea                   ; 1C3A8:  10 40
b07_83aa:   bpl $83ec                   ; 1C3AA:  10 40
b07_83ac:   .db $22                     ; 1C3AC:  22
b07_83ad:   dey                         ; 1C3AD:  88
b07_83ae:   .db $22                     ; 1C3AE:  22
b07_83af:   dey                         ; 1C3AF:  88
b07_83b0:   jsr $2088                   ; 1C3B0:  20 88 20
b07_83b3:   sta ($00,x)                 ; 1C3B3:  81 00
b07_83b5:   rti                         ; 1C3B5:  40
b07_83b6:   brk                         ; 1C3B6:  00
b07_83b7:   rti                         ; 1C3B7:  40
b07_83b8:   brk                         ; 1C3B8:  00
b07_83b9:   rti                         ; 1C3B9:  40
b07_83ba:   brk                         ; 1C3BA:  00
b07_83bb:   rti                         ; 1C3BB:  40
b07_83bc:   and ($83,x)                 ; 1C3BC:  21 83
b07_83be:   .db $23                     ; 1C3BE:  23
b07_83bf:   .db $87                     ; 1C3BF:  87
b07_83c0:   .db $07                     ; 1C3C0:  07
b07_83c1:   .db $87                     ; 1C3C1:  87
b07_83c2:   .db $07                     ; 1C3C2:  07
b07_83c3:   .db $87                     ; 1C3C3:  87
b07_83c4:   bpl $840a                   ; 1C3C4:  10 44
b07_83c6:   brk                         ; 1C3C6:  00
b07_83c7:   brk                         ; 1C3C7:  00
b07_83c8:   .db $03                     ; 1C3C8:  03
b07_83c9:   .db $0f                     ; 1C3C9:  0f
b07_83ca:   .db $1f                     ; 1C3CA:  1f
b07_83cb:   .db $3f                     ; 1C3CB:  3f
b07_83cc:   and ($88,x)                 ; 1C3CC:  21 88
b07_83ce:   jsr $1c00                   ; 1C3CE:  20 00 1c
b07_83d1:   bvs $83b3                   ; 1C3D1:  70 e0
b07_83d3:   cpy #$01                    ; 1C3D3:  c0 01
b07_83d5:   brk                         ; 1C3D5:  00
b07_83d6:   ora ($00,x)                 ; 1C3D6:  01 00
b07_83d8:   .db $fc                     ; 1C3D8:  fc
b07_83d9:   .db $ff                     ; 1C3D9:  ff
b07_83da:   .db $ff                     ; 1C3DA:  ff
b07_83db:   .db $ff                     ; 1C3DB:  ff
b07_83dc:   .db $12                     ; 1C3DC:  12
b07_83dd:   brk                         ; 1C3DD:  00
b07_83de:   .db $02                     ; 1C3DE:  02
b07_83df:   brk                         ; 1C3DF:  00
b07_83e0:   brk                         ; 1C3E0:  00
b07_83e1:   brk                         ; 1C3E1:  00
b07_83e2:   brk                         ; 1C3E2:  00
b07_83e3:   brk                         ; 1C3E3:  00
b07_83e4:   .db $3f                     ; 1C3E4:  3f
b07_83e5:   .db $3f                     ; 1C3E5:  3f
b07_83e6:   .db $3f                     ; 1C3E6:  3f
b07_83e7:   .db $7f                     ; 1C3E7:  7f
b07_83e8:   .db $7f                     ; 1C3E8:  7f
b07_83e9:   .db $7f                     ; 1C3E9:  7f
b07_83ea:   .db $7f                     ; 1C3EA:  7f
b07_83eb:   .db $7f                     ; 1C3EB:  7f
b07_83ec:   cpy #$c0                    ; 1C3EC:  c0 c0
b07_83ee:   cpy #$80                    ; 1C3EE:  c0 80
b07_83f0:   .db $80                     ; 1C3F0:  80
b07_83f1:   .db $80                     ; 1C3F1:  80
b07_83f2:   .db $80                     ; 1C3F2:  80
b07_83f3:   .db $80                     ; 1C3F3:  80
b07_83f4:   .db $ff                     ; 1C3F4:  ff
b07_83f5:   .db $ff                     ; 1C3F5:  ff
b07_83f6:   .db $ff                     ; 1C3F6:  ff
b07_83f7:   .db $ff                     ; 1C3F7:  ff
b07_83f8:   .db $ff                     ; 1C3F8:  ff
b07_83f9:   .db $ff                     ; 1C3F9:  ff
b07_83fa:   .db $ff                     ; 1C3FA:  ff
b07_83fb:   .db $ff                     ; 1C3FB:  ff
b07_83fc:   brk                         ; 1C3FC:  00
b07_83fd:   brk                         ; 1C3FD:  00
b07_83fe:   brk                         ; 1C3FE:  00
b07_83ff:   brk                         ; 1C3FF:  00
b07_8400:   brk                         ; 1C400:  00
b07_8401:   brk                         ; 1C401:  00
b07_8402:   brk                         ; 1C402:  00
b07_8403:   brk                         ; 1C403:  00
b07_8404:   ora ($44),y                 ; 1C404:  11 44
b07_8406:   ora ($04),y                 ; 1C406:  11 04
b07_8408:   ora ($04,x)                 ; 1C408:  01 04
b07_840a:   sta ($c4,x)                 ; 1C40A:  81 c4
b07_840c:   .db $22                     ; 1C40C:  22
b07_840d:   dey                         ; 1C40D:  88
b07_840e:   .db $22                     ; 1C40E:  22
b07_840f:   php                         ; 1C40F:  08
b07_8410:   .db $02                     ; 1C410:  02
b07_8411:   php                         ; 1C411:  08
b07_8412:   .db $02                     ; 1C412:  02
b07_8413:   brk                         ; 1C413:  00
b07_8414:   cmp ($e0,x)                 ; 1C414:  c1 e0
b07_8416:   sbc ($f0,x)                 ; 1C416:  e1 f0
b07_8418:   sbc ($f0),y                 ; 1C418:  f1 f0
b07_841a:   sbc ($f0),y                 ; 1C41A:  f1 f0
b07_841c:   .db $02                     ; 1C41C:  02
b07_841d:   brk                         ; 1C41D:  00
b07_841e:   .db $02                     ; 1C41E:  02
b07_841f:   brk                         ; 1C41F:  00
b07_8420:   brk                         ; 1C420:  00
b07_8421:   brk                         ; 1C421:  00
b07_8422:   brk                         ; 1C422:  00
b07_8423:   brk                         ; 1C423:  00
b07_8424:   brk                         ; 1C424:  00
b07_8425:   rti                         ; 1C425:  40
b07_8426:   brk                         ; 1C426:  00
b07_8427:   jsr $2000                   ; 1C427:  20 00 20
b07_842a:   jsr $0720                   ; 1C42A:  20 20 07
b07_842d:   .db $87                     ; 1C42D:  87
b07_842e:   .db $07                     ; 1C42E:  07
b07_842f:   sty $07                     ; 1C42F:  84 07
b07_8431:   .db $87                     ; 1C431:  87
b07_8432:   .db $07                     ; 1C432:  07
b07_8433:   .db $8f                     ; 1C433:  8f
b07_8434:   brk                         ; 1C434:  00
b07_8435:   rti                         ; 1C435:  40
b07_8436:   bpl $8480                   ; 1C436:  10 48
b07_8438:   bpl $847a                   ; 1C438:  10 40
b07_843a:   bpl $847c                   ; 1C43A:  10 40
b07_843c:   .db $17                     ; 1C43C:  17
b07_843d:   .db $97                     ; 1C43D:  97
b07_843e:   .db $0f                     ; 1C43E:  0f
b07_843f:   .db $87                     ; 1C43F:  87
b07_8440:   .db $27                     ; 1C440:  27
b07_8441:   .db $87                     ; 1C441:  87
b07_8442:   .db $27                     ; 1C442:  27
b07_8443:   .db $8b                     ; 1C443:  8b
b07_8444:   .db $7f                     ; 1C444:  7f
b07_8445:   .db $ff                     ; 1C445:  ff
b07_8446:   .db $ff                     ; 1C446:  ff
b07_8447:   .db $0f                     ; 1C447:  0f
b07_8448:   .db $03                     ; 1C448:  03
b07_8449:   ora ($20,x)                 ; 1C449:  01 20
b07_844b:   sed                         ; 1C44B:  f8
b07_844c:   .db $80                     ; 1C44C:  80
b07_844d:   brk                         ; 1C44D:  00
b07_844e:   brk                         ; 1C44E:  00
b07_844f:   brk                         ; 1C44F:  00
b07_8450:   beq $8458                   ; 1C450:  f0 06
b07_8452:   .db $a3                     ; 1C452:  a3
b07_8453:   .db $03                     ; 1C453:  03
b07_8454:   .db $ff                     ; 1C454:  ff
b07_8455:   .db $ff                     ; 1C455:  ff
b07_8456:   .db $ff                     ; 1C456:  ff
b07_8457:   sed                         ; 1C457:  f8
b07_8458:   .db $e7                     ; 1C458:  e7
b07_8459:   cpx #$c4                    ; 1C459:  e0 c4
b07_845b:   .db $cf                     ; 1C45B:  cf
b07_845c:   brk                         ; 1C45C:  00
b07_845d:   brk                         ; 1C45D:  00
b07_845e:   brk                         ; 1C45E:  00
b07_845f:   brk                         ; 1C45F:  00
b07_8460:   brk                         ; 1C460:  00
b07_8461:   bpl $8487                   ; 1C461:  10 24
b07_8463:   bmi $84d6                   ; 1C463:  30 71
b07_8465:   and ($f9,x)                 ; 1C465:  21 f9
b07_8467:   sbc $f3fb,y                 ; 1C467:  f9 fb f3
b07_846a:   beq $84dc                   ; 1C46A:  f0 70
b07_846c:   stx $de                     ; 1C46C:  86 de
b07_846e:   asl $04                     ; 1C46E:  06 04
b07_8470:   .db $04                     ; 1C470:  04
b07_8471:   .db $0c                     ; 1C471:  0c
b07_8472:   ora $e78e                   ; 1C472:  0d 8e e7
b07_8475:   .db $f7                     ; 1C475:  f7
b07_8476:   .db $ff                     ; 1C476:  ff
b07_8477:   .db $ff                     ; 1C477:  ff
b07_8478:   .db $ff                     ; 1C478:  ff
b07_8479:   .db $ff                     ; 1C479:  ff
b07_847a:   .db $cf                     ; 1C47A:  cf
b07_847b:   .db $17                     ; 1C47B:  17
b07_847c:   bpl $8486                   ; 1C47C:  10 08
b07_847e:   brk                         ; 1C47E:  00
b07_847f:   brk                         ; 1C47F:  00
b07_8480:   brk                         ; 1C480:  00
b07_8481:   brk                         ; 1C481:  00
b07_8482:   bpl $84ac                   ; 1C482:  10 28
b07_8484:   sbc ($f0),y                 ; 1C484:  f1 f0
b07_8486:   beq $849a                   ; 1C486:  f0 12
b07_8488:   beq $84fc                   ; 1C488:  f0 72
b07_848a:   .db $f2                     ; 1C48A:  f2
b07_848b:   .db $fa                     ; 1C48B:  fa
b07_848c:   brk                         ; 1C48C:  00
b07_848d:   brk                         ; 1C48D:  00
b07_848e:   brk                         ; 1C48E:  00
b07_848f:   brk                         ; 1C48F:  00
b07_8490:   brk                         ; 1C490:  00
b07_8491:   brk                         ; 1C491:  00
b07_8492:   brk                         ; 1C492:  00
b07_8493:   brk                         ; 1C493:  00
b07_8494:   sbc $f4,x                   ; 1C494:  f5 f4
b07_8496:   sbc $f1f8,x                 ; 1C496:  fd f8 f1
b07_8499:   .db $f4                     ; 1C499:  f4
b07_849a:   sbc ($e4),y                 ; 1C49A:  f1 e4
b07_849c:   brk                         ; 1C49C:  00
b07_849d:   brk                         ; 1C49D:  00
b07_849e:   brk                         ; 1C49E:  00
b07_849f:   brk                         ; 1C49F:  00
b07_84a0:   .db $02                     ; 1C4A0:  02
b07_84a1:   php                         ; 1C4A1:  08
b07_84a2:   .db $02                     ; 1C4A2:  02
b07_84a3:   php                         ; 1C4A3:  08
b07_84a4:   ora ($44),y                 ; 1C4A4:  11 44
b07_84a6:   ora ($44),y                 ; 1C4A6:  11 44
b07_84a8:   ora ($44),y                 ; 1C4A8:  11 44
b07_84aa:   bpl $84ac                   ; 1C4AA:  10 00
b07_84ac:   .db $22                     ; 1C4AC:  22
b07_84ad:   dey                         ; 1C4AD:  88
b07_84ae:   .db $22                     ; 1C4AE:  22
b07_84af:   dey                         ; 1C4AF:  88
b07_84b0:   .db $22                     ; 1C4B0:  22
b07_84b1:   dey                         ; 1C4B1:  88
b07_84b2:   .db $22                     ; 1C4B2:  22
b07_84b3:   .db $57                     ; 1C4B3:  57
b07_84b4:   bpl $84f6                   ; 1C4B4:  10 40
b07_84b6:   bpl $84f8                   ; 1C4B6:  10 40
b07_84b8:   bpl $84fa                   ; 1C4B8:  10 40
b07_84ba:   brk                         ; 1C4BA:  00
b07_84bb:   brk                         ; 1C4BB:  00
b07_84bc:   .db $23                     ; 1C4BC:  23
b07_84bd:   .db $8b                     ; 1C4BD:  8b
b07_84be:   and ($89,x)                 ; 1C4BE:  21 89
b07_84c0:   .db $22                     ; 1C4C0:  22
b07_84c1:   sty $a2                     ; 1C4C1:  84 a2
b07_84c3:   inc $00                     ; 1C4C3:  e6 00
b07_84c5:   brk                         ; 1C4C5:  00
b07_84c6:   .db $80                     ; 1C4C6:  80
b07_84c7:   bvc $8473                   ; 1C4C7:  50 aa
b07_84c9:   eor $aa,x                   ; 1C4C9:  55 aa
b07_84cb:   eor $ff,x                   ; 1C4CB:  55 ff
b07_84cd:   .db $ff                     ; 1C4CD:  ff
b07_84ce:   .db $7f                     ; 1C4CE:  7f
b07_84cf:   .db $af                     ; 1C4CF:  af
b07_84d0:   eor $aa,x                   ; 1C4D0:  55 aa
b07_84d2:   eor $aa,x                   ; 1C4D2:  55 aa
b07_84d4:   brk                         ; 1C4D4:  00
b07_84d5:   brk                         ; 1C4D5:  00
b07_84d6:   ora ($00,x)                 ; 1C4D6:  01 00
b07_84d8:   ora ($00,x)                 ; 1C4D8:  01 00
b07_84da:   sta ($00,x)                 ; 1C4DA:  81 00
b07_84dc:   inc $ec                     ; 1C4DC:  e6 ec
b07_84de:   sbc $cdcd                   ; 1C4DE:  ed cd cd
b07_84e1:   cmp $dd5d,x                 ; 1C4E1:  dd 5d dd
b07_84e4:   jmp ($283f)                 ; 1C4E4:  6c 3f 28
b07_84e7:   .db $03                     ; 1C4E7:  03
b07_84e8:   brk                         ; 1C4E8:  00
b07_84e9:   brk                         ; 1C4E9:  00
b07_84ea:   sta ($83,x)                 ; 1C4EA:  81 83
b07_84ec:   .db $93                     ; 1C4EC:  93
b07_84ed:   cpy #$d0                    ; 1C4ED:  c0 d0
b07_84ef:   cpx $ee                     ; 1C4EF:  e4 ee
b07_84f1:   adc $bcbe,x                 ; 1C4F1:  7d be bc
b07_84f4:   .db $3f                     ; 1C4F4:  3f
b07_84f5:   .db $ff                     ; 1C4F5:  ff
b07_84f6:   .db $8b                     ; 1C4F6:  8b
b07_84f7:   .db $f3                     ; 1C4F7:  f3
b07_84f8:   .db $3b                     ; 1C4F8:  3b
b07_84f9:   .db $1f                     ; 1C4F9:  1f
b07_84fa:   inc $c0fe,x                 ; 1C4FA:  fe fe c0
b07_84fd:   brk                         ; 1C4FD:  00
b07_84fe:   .db $04                     ; 1C4FE:  04
b07_84ff:   brk                         ; 1C4FF:  00
b07_8500:   .db $04                     ; 1C500:  04
b07_8501:   cpy #$00                    ; 1C501:  c0 00
b07_8503:   brk                         ; 1C503:  00
b07_8504:   .db $83                     ; 1C504:  83
b07_8505:   cmp ($40,x)                 ; 1C505:  c1 40
b07_8507:   rti                         ; 1C507:  40
b07_8508:   rts                         ; 1C508:  60
b07_8509:   .db $63                     ; 1C509:  63
b07_850a:   .db $33                     ; 1C50A:  33
b07_850b:   .db $b3                     ; 1C50B:  b3
b07_850c:   .db $9c                     ; 1C50C:  9c
b07_850d:   dec $5047                   ; 1C50D:  ce 47 50
b07_8510:   sei                         ; 1C510:  78
b07_8511:   .db $7c                     ; 1C511:  7c
b07_8512:   ldy $7cbc,x                 ; 1C512:  bc bc 7c
b07_8515:   adc $0503,y                 ; 1C515:  79 03 05
b07_8518:   .db $1f                     ; 1C518:  1f
b07_8519:   .db $fb                     ; 1C519:  fb
b07_851a:   .db $ff                     ; 1C51A:  ff
b07_851b:   inc $80,x                   ; 1C51B:  f6 80
b07_851d:   ora ($71,x)                 ; 1C51D:  01 71
b07_851f:   ora ($03,x)                 ; 1C51F:  01 03
b07_8521:   .db $03                     ; 1C521:  03
b07_8522:   .db $07                     ; 1C522:  07
b07_8523:   .db $07                     ; 1C523:  07
b07_8524:   sbc ($e4,x)                 ; 1C524:  e1 e4
b07_8526:   cmp ($c4,x)                 ; 1C526:  c1 c4
b07_8528:   sta ($24,x)                 ; 1C528:  81 24
b07_852a:   sta $a2,x                   ; 1C52A:  95 a2
b07_852c:   .db $02                     ; 1C52C:  02
b07_852d:   php                         ; 1C52D:  08
b07_852e:   .db $22                     ; 1C52E:  22
b07_852f:   php                         ; 1C52F:  08
b07_8530:   .db $22                     ; 1C530:  22
b07_8531:   bpl $84d5                   ; 1C531:  10 a2
b07_8533:   sta $11,x                   ; 1C533:  95 11
b07_8535:   .db $44                     ; 1C535:  44
b07_8536:   ora ($44),y                 ; 1C536:  11 44
b07_8538:   ora ($44),y                 ; 1C538:  11 44
b07_853a:   ora ($a4),y                 ; 1C53A:  11 a4
b07_853c:   .db $22                     ; 1C53C:  22
b07_853d:   dey                         ; 1C53D:  88
b07_853e:   .db $22                     ; 1C53E:  22
b07_853f:   dey                         ; 1C53F:  88
b07_8540:   .db $22                     ; 1C540:  22
b07_8541:   dey                         ; 1C541:  88
b07_8542:   .db $22                     ; 1C542:  22
b07_8543:   cli                         ; 1C543:  58
b07_8544:   sta $8a,x                   ; 1C544:  95 8a
b07_8546:   eor ($8a),y                 ; 1C546:  51 8a
b07_8548:   eor ($88),y                 ; 1C548:  51 88
b07_854a:   eor $88,x                   ; 1C54A:  55 88
b07_854c:   ldx #$d1                    ; 1C54C:  a2 d1
b07_854e:   dex                         ; 1C54E:  ca
b07_854f:   cmp ($ca),y                 ; 1C54F:  d1 ca
b07_8551:   cmp $c8,x                   ; 1C551:  d5 c8
b07_8553:   cmp $55,x                   ; 1C553:  d5 55
b07_8555:   tax                         ; 1C555:  aa
b07_8556:   eor $aa,x                   ; 1C556:  55 aa
b07_8558:   eor $aa,x                   ; 1C558:  55 aa
b07_855a:   eor $8a,x                   ; 1C55A:  55 8a
b07_855c:   tax                         ; 1C55C:  aa
b07_855d:   eor $aa,x                   ; 1C55D:  55 aa
b07_855f:   eor $aa,x                   ; 1C55F:  55 aa
b07_8561:   eor $aa,x                   ; 1C561:  55 aa
b07_8563:   adc $55,x                   ; 1C563:  75 55
b07_8565:   brk                         ; 1C565:  00
b07_8566:   eor $00,x                   ; 1C566:  55 00
b07_8568:   eor $00,x                   ; 1C568:  55 00
b07_856a:   eor $00,x                   ; 1C56A:  55 00
b07_856c:   tax                         ; 1C56C:  aa
b07_856d:   brk                         ; 1C56D:  00
b07_856e:   tax                         ; 1C56E:  aa
b07_856f:   brk                         ; 1C56F:  00
b07_8570:   tax                         ; 1C570:  aa
b07_8571:   brk                         ; 1C571:  00
b07_8572:   tax                         ; 1C572:  aa
b07_8573:   brk                         ; 1C573:  00
b07_8574:   eor $00                     ; 1C574:  45 00
b07_8576:   rti                         ; 1C576:  40
b07_8577:   ora ($43,x)                 ; 1C577:  01 43
b07_8579:   .db $07                     ; 1C579:  07
b07_857a:   .db $4f                     ; 1C57A:  4f
b07_857b:   .db $0f                     ; 1C57B:  0f
b07_857c:   ldx #$00                    ; 1C57C:  a2 00
b07_857e:   .db $80                     ; 1C57E:  80
b07_857f:   brk                         ; 1C57F:  00
b07_8580:   .db $80                     ; 1C580:  80
b07_8581:   brk                         ; 1C581:  00
b07_8582:   .db $80                     ; 1C582:  80
b07_8583:   brk                         ; 1C583:  00
b07_8584:   .db $0f                     ; 1C584:  0f
b07_8585:   .db $07                     ; 1C585:  07
b07_8586:   .db $13                     ; 1C586:  13
b07_8587:   and $020c,y                 ; 1C587:  39 0c 02
b07_858a:   ora ($00,x)                 ; 1C58A:  01 00
b07_858c:   .db $80                     ; 1C58C:  80
b07_858d:   brk                         ; 1C58D:  00
b07_858e:   bcc $85c8                   ; 1C58E:  90 38
b07_8590:   sty $8102                   ; 1C590:  8c 02 81
b07_8593:   brk                         ; 1C593:  00
b07_8594:   eor $00,x                   ; 1C594:  55 00
b07_8596:   .db $7f                     ; 1C596:  7f
b07_8597:   .db $ff                     ; 1C597:  ff
b07_8598:   .db $ff                     ; 1C598:  ff
b07_8599:   .db $ff                     ; 1C599:  ff
b07_859a:   .db $ff                     ; 1C59A:  ff
b07_859b:   .db $ff                     ; 1C59B:  ff
b07_859c:   tax                         ; 1C59C:  aa
b07_859d:   brk                         ; 1C59D:  00
b07_859e:   brk                         ; 1C59E:  00
b07_859f:   brk                         ; 1C59F:  00
b07_85a0:   brk                         ; 1C5A0:  00
b07_85a1:   brk                         ; 1C5A1:  00
b07_85a2:   brk                         ; 1C5A2:  00
b07_85a3:   brk                         ; 1C5A3:  00
b07_85a4:   eor $00,x                   ; 1C5A4:  55 00
b07_85a6:   cmp $f8,x                   ; 1C5A6:  d5 f8
b07_85a8:   inc $ffff,x                 ; 1C5A8:  fe ff ff
b07_85ab:   .db $ff                     ; 1C5AB:  ff
b07_85ac:   tax                         ; 1C5AC:  aa
b07_85ad:   brk                         ; 1C5AD:  00
b07_85ae:   rol a                       ; 1C5AE:  2a
b07_85af:   .db $07                     ; 1C5AF:  07
b07_85b0:   ora ($00,x)                 ; 1C5B0:  01 00
b07_85b2:   brk                         ; 1C5B2:  00
b07_85b3:   brk                         ; 1C5B3:  00
b07_85b4:   .db $ff                     ; 1C5B4:  ff
b07_85b5:   .db $ff                     ; 1C5B5:  ff
b07_85b6:   .db $ff                     ; 1C5B6:  ff
b07_85b7:   .db $ff                     ; 1C5B7:  ff
b07_85b8:   .db $ff                     ; 1C5B8:  ff
b07_85b9:   .db $7f                     ; 1C5B9:  7f
b07_85ba:   .db $1f                     ; 1C5BA:  1f
b07_85bb:   .db $0f                     ; 1C5BB:  0f
b07_85bc:   brk                         ; 1C5BC:  00
b07_85bd:   brk                         ; 1C5BD:  00
b07_85be:   brk                         ; 1C5BE:  00
b07_85bf:   brk                         ; 1C5BF:  00
b07_85c0:   brk                         ; 1C5C0:  00
b07_85c1:   brk                         ; 1C5C1:  00
b07_85c2:   brk                         ; 1C5C2:  00
b07_85c3:   brk                         ; 1C5C3:  00
b07_85c4:   .db $ff                     ; 1C5C4:  ff
b07_85c5:   .db $ff                     ; 1C5C5:  ff
b07_85c6:   .db $ff                     ; 1C5C6:  ff
b07_85c7:   .db $ff                     ; 1C5C7:  ff
b07_85c8:   .db $ff                     ; 1C5C8:  ff
b07_85c9:   .db $ff                     ; 1C5C9:  ff
b07_85ca:   .db $ff                     ; 1C5CA:  ff
b07_85cb:   .db $ff                     ; 1C5CB:  ff
b07_85cc:   brk                         ; 1C5CC:  00
b07_85cd:   brk                         ; 1C5CD:  00
b07_85ce:   brk                         ; 1C5CE:  00
b07_85cf:   brk                         ; 1C5CF:  00
b07_85d0:   brk                         ; 1C5D0:  00
b07_85d1:   brk                         ; 1C5D1:  00
b07_85d2:   brk                         ; 1C5D2:  00
b07_85d3:   brk                         ; 1C5D3:  00
b07_85d4:   eor $00,x                   ; 1C5D4:  55 00
b07_85d6:   eor $00,x                   ; 1C5D6:  55 00
b07_85d8:   ora $80,x                   ; 1C5D8:  15 80
b07_85da:   cmp $e0                     ; 1C5DA:  c5 e0
b07_85dc:   tax                         ; 1C5DC:  aa
b07_85dd:   brk                         ; 1C5DD:  00
b07_85de:   tax                         ; 1C5DE:  aa
b07_85df:   brk                         ; 1C5DF:  00
b07_85e0:   dex                         ; 1C5E0:  ca
b07_85e1:   rts                         ; 1C5E1:  60
b07_85e2:   .db $32                     ; 1C5E2:  32
b07_85e3:   clc                         ; 1C5E3:  18
b07_85e4:   sbc ($f0,x)                 ; 1C5E4:  e1 f0
b07_85e6:   sbc ($f0),y                 ; 1C5E6:  f1 f0
b07_85e8:   sed                         ; 1C5E8:  f8
b07_85e9:   sed                         ; 1C5E9:  f8
b07_85ea:   sed                         ; 1C5EA:  f8
b07_85eb:   .db $fc                     ; 1C5EB:  fc
b07_85ec:   .db $1a                     ; 1C5EC:  1a
b07_85ed:   .db $0c                     ; 1C5ED:  0c
b07_85ee:   .db $0c                     ; 1C5EE:  0c
b07_85ef:   asl $0606                   ; 1C5EF:  0e 06 06
b07_85f2:   .db $07                     ; 1C5F2:  07
b07_85f3:   .db $03                     ; 1C5F3:  03
b07_85f4:   eor $00,x                   ; 1C5F4:  55 00
b07_85f6:   eor $00,x                   ; 1C5F6:  55 00
b07_85f8:   eor $00,x                   ; 1C5F8:  55 00
b07_85fa:   eor $00,x                   ; 1C5FA:  55 00
b07_85fc:   tax                         ; 1C5FC:  aa
b07_85fd:   brk                         ; 1C5FD:  00
b07_85fe:   tax                         ; 1C5FE:  aa
b07_85ff:   brk                         ; 1C5FF:  00
b07_8600:   tax                         ; 1C600:  aa
b07_8601:   brk                         ; 1C601:  00
b07_8602:   rol a                       ; 1C602:  2a
b07_8603:   brk                         ; 1C603:  00
b07_8604:   brk                         ; 1C604:  00
b07_8605:   brk                         ; 1C605:  00
b07_8606:   brk                         ; 1C606:  00
b07_8607:   brk                         ; 1C607:  00
b07_8608:   sec                         ; 1C608:  38
b07_8609:   .db $44                     ; 1C609:  44
b07_860a:   .db $42                     ; 1C60A:  42
b07_860b:   eor ($80,x)                 ; 1C60B:  41 80
b07_860d:   brk                         ; 1C60D:  00
b07_860e:   .db $80                     ; 1C60E:  80
b07_860f:   brk                         ; 1C60F:  00
b07_8610:   .db $80                     ; 1C610:  80
b07_8611:   brk                         ; 1C611:  00
b07_8612:   php                         ; 1C612:  08
b07_8613:   .db $04                     ; 1C613:  04
b07_8614:   eor ($23,x)                 ; 1C614:  41 23
b07_8616:   and ($1c),y                 ; 1C616:  31 1c
b07_8618:   .db $5b                     ; 1C618:  5b
b07_8619:   .db $0f                     ; 1C619:  0f
b07_861a:   bvc $861c                   ; 1C61A:  50 00
b07_861c:   plp                         ; 1C61C:  28
b07_861d:   php                         ; 1C61D:  08
b07_861e:   sty $8000                   ; 1C61E:  8c 00 80
b07_8621:   brk                         ; 1C621:  00
b07_8622:   ldy #$00                    ; 1C622:  a0 00
b07_8624:   .db $07                     ; 1C624:  07
b07_8625:   .db $0f                     ; 1C625:  0f
b07_8626:   lsr $1f2d,x                 ; 1C626:  5e 2d 1f
b07_8629:   .db $3f                     ; 1C629:  3f
b07_862a:   .db $7f                     ; 1C62A:  7f
b07_862b:   .db $7f                     ; 1C62B:  7f
b07_862c:   brk                         ; 1C62C:  00
b07_862d:   brk                         ; 1C62D:  00
b07_862e:   rti                         ; 1C62E:  40
b07_862f:   jsr $0000                   ; 1C62F:  20 00 00
b07_8632:   brk                         ; 1C632:  00
b07_8633:   brk                         ; 1C633:  00
b07_8634:   .db $ff                     ; 1C634:  ff
b07_8635:   .db $fa                     ; 1C635:  fa
b07_8636:   .db $80                     ; 1C636:  80
b07_8637:   rts                         ; 1C637:  60
b07_8638:   ora ($9b,x)                 ; 1C638:  01 9b
b07_863a:   .db $f3                     ; 1C63A:  f3
b07_863b:   .db $f7                     ; 1C63B:  f7
b07_863c:   brk                         ; 1C63C:  00
b07_863d:   brk                         ; 1C63D:  00
b07_863e:   ora ($15,x)                 ; 1C63E:  01 15
b07_8640:   .db $02                     ; 1C640:  02
b07_8641:   clc                         ; 1C641:  18
b07_8642:   .db $0c                     ; 1C642:  0c
b07_8643:   php                         ; 1C643:  08
b07_8644:   .db $7f                     ; 1C644:  7f
b07_8645:   .db $ff                     ; 1C645:  ff
b07_8646:   .db $ff                     ; 1C646:  ff
b07_8647:   .db $df                     ; 1C647:  df
b07_8648:   .db $ef                     ; 1C648:  ef
b07_8649:   .db $e7                     ; 1C649:  e7
b07_864a:   .db $f7                     ; 1C64A:  f7
b07_864b:   .db $ff                     ; 1C64B:  ff
b07_864c:   brk                         ; 1C64C:  00
b07_864d:   brk                         ; 1C64D:  00
b07_864e:   brk                         ; 1C64E:  00
b07_864f:   jsr $1810                   ; 1C64F:  20 10 18
b07_8652:   php                         ; 1C652:  08
b07_8653:   brk                         ; 1C653:  00
b07_8654:   .db $ef                     ; 1C654:  ef
b07_8655:   inc $fffc,x                 ; 1C655:  fe fc ff
b07_8658:   sed                         ; 1C658:  f8
b07_8659:   inc $ff,x                   ; 1C659:  f6 ff
b07_865b:   .db $ff                     ; 1C65B:  ff
b07_865c:   bpl $865f                   ; 1C65C:  10 01
b07_865e:   .db $02                     ; 1C65E:  02
b07_865f:   brk                         ; 1C65F:  00
b07_8660:   .db $02                     ; 1C660:  02
b07_8661:   ora ($00,x)                 ; 1C661:  01 00
b07_8663:   brk                         ; 1C663:  00
b07_8664:   inc $e0ee,x                 ; 1C664:  fe ee e0
b07_8667:   .db $44                     ; 1C667:  44
b07_8668:   .db $80                     ; 1C668:  80
b07_8669:   sty $dc                     ; 1C669:  84 dc
b07_866b:   cld                         ; 1C66B:  d8
b07_866c:   ora ($01,x)                 ; 1C66C:  01 01
b07_866e:   ora ($88,x)                 ; 1C66E:  01 88
b07_8670:   .db $02                     ; 1C670:  02
b07_8671:   lsr $22                     ; 1C671:  46 22
b07_8673:   .db $07                     ; 1C673:  07
b07_8674:   eor $00,x                   ; 1C674:  55 00
b07_8676:   eor $00,x                   ; 1C676:  55 00
b07_8678:   eor $00,x                   ; 1C678:  55 00
b07_867a:   eor $00,x                   ; 1C67A:  55 00
b07_867c:   rol a                       ; 1C67C:  2a
b07_867d:   brk                         ; 1C67D:  00
b07_867e:   rol a                       ; 1C67E:  2a
b07_867f:   brk                         ; 1C67F:  00
b07_8680:   tax                         ; 1C680:  aa
b07_8681:   brk                         ; 1C681:  00
b07_8682:   tax                         ; 1C682:  aa
b07_8683:   brk                         ; 1C683:  00
b07_8684:   cpy $eccc                   ; 1C684:  cc cc ec
b07_8687:   cpx $60                     ; 1C687:  e4 60
b07_8689:   brk                         ; 1C689:  00
b07_868a:   ora ($c0,x)                 ; 1C68A:  01 c0
b07_868c:   .db $33                     ; 1C68C:  33
b07_868d:   .db $13                     ; 1C68D:  13
b07_868e:   .db $03                     ; 1C68E:  03
b07_868f:   asl a                       ; 1C68F:  0a
b07_8690:   asl $fc1e                   ; 1C690:  0e 1e fc
b07_8693:   .db $3c                     ; 1C693:  3c
b07_8694:   eor $00,x                   ; 1C694:  55 00
b07_8696:   eor $00,x                   ; 1C696:  55 00
b07_8698:   eor $00,x                   ; 1C698:  55 00
b07_869a:   .db $54                     ; 1C69A:  54
b07_869b:   .db $02                     ; 1C69B:  02
b07_869c:   tax                         ; 1C69C:  aa
b07_869d:   brk                         ; 1C69D:  00
b07_869e:   tax                         ; 1C69E:  aa
b07_869f:   brk                         ; 1C69F:  00
b07_86a0:   tax                         ; 1C6A0:  aa
b07_86a1:   brk                         ; 1C6A1:  00
b07_86a2:   tay                         ; 1C6A2:  a8
b07_86a3:   .db $03                     ; 1C6A3:  03
b07_86a4:   .db $53                     ; 1C6A4:  53
b07_86a5:   .db $07                     ; 1C6A5:  07
b07_86a6:   .db $57                     ; 1C6A6:  57
b07_86a7:   .db $03                     ; 1C6A7:  03
b07_86a8:   .db $4b                     ; 1C6A8:  4b
b07_86a9:   ora ($09,x)                 ; 1C6A9:  01 09
b07_86ab:   .db $22                     ; 1C6AB:  22
b07_86ac:   tay                         ; 1C6AC:  a8
b07_86ad:   .db $04                     ; 1C6AD:  04
b07_86ae:   ldy $02                     ; 1C6AE:  a4 02
b07_86b0:   stx $4d11                   ; 1C6B0:  8e 11 4d
b07_86b3:   .db $23                     ; 1C6B3:  23
b07_86b4:   php                         ; 1C6B4:  08
b07_86b5:   .db $22                     ; 1C6B5:  22
b07_86b6:   dey                         ; 1C6B6:  88
b07_86b7:   .db $22                     ; 1C6B7:  22
b07_86b8:   dey                         ; 1C6B8:  88
b07_86b9:   .db $22                     ; 1C6B9:  22
b07_86ba:   php                         ; 1C6BA:  08
b07_86bb:   .db $22                     ; 1C6BB:  22
b07_86bc:   jmp $cc33                   ; 1C6BC:  4c 33 cc
b07_86bf:   .db $33                     ; 1C6BF:  33
b07_86c0:   cpy $4c33                   ; 1C6C0:  cc 33 4c
b07_86c3:   .db $33                     ; 1C6C3:  33
b07_86c4:   .db $80                     ; 1C6C4:  80
b07_86c5:   .db $22                     ; 1C6C5:  22
b07_86c6:   dey                         ; 1C6C6:  88
b07_86c7:   .db $22                     ; 1C6C7:  22
b07_86c8:   dey                         ; 1C6C8:  88
b07_86c9:   jsr $2288                   ; 1C6C9:  20 88 22
b07_86cc:   cpy $33                     ; 1C6CC:  c4 33
b07_86ce:   iny                         ; 1C6CE:  c8
b07_86cf:   .db $33                     ; 1C6CF:  33
b07_86d0:   cpy $cc31                   ; 1C6D0:  cc 31 cc
b07_86d3:   .db $32                     ; 1C6D3:  32
b07_86d4:   .db $ff                     ; 1C6D4:  ff
b07_86d5:   .db $7f                     ; 1C6D5:  7f
b07_86d6:   .db $7f                     ; 1C6D6:  7f
b07_86d7:   .db $bf                     ; 1C6D7:  bf
b07_86d8:   .db $df                     ; 1C6D8:  df
b07_86d9:   .db $ef                     ; 1C6D9:  ef
b07_86da:   .db $f7                     ; 1C6DA:  f7
b07_86db:   sbc ($00),y                 ; 1C6DB:  f1 00
b07_86dd:   brk                         ; 1C6DD:  00
b07_86de:   brk                         ; 1C6DE:  00
b07_86df:   brk                         ; 1C6DF:  00
b07_86e0:   brk                         ; 1C6E0:  00
b07_86e1:   brk                         ; 1C6E1:  00
b07_86e2:   .db $80                     ; 1C6E2:  80
b07_86e3:   iny                         ; 1C6E3:  c8
b07_86e4:   inx                         ; 1C6E4:  e8
b07_86e5:   .db $e7                     ; 1C6E5:  e7
b07_86e6:   .db $ef                     ; 1C6E6:  ef
b07_86e7:   inc $fffe,x                 ; 1C6E7:  fe fe ff
b07_86ea:   .db $ff                     ; 1C6EA:  ff
b07_86eb:   .db $ff                     ; 1C6EB:  ff
b07_86ec:   brk                         ; 1C6EC:  00
b07_86ed:   brk                         ; 1C6ED:  00
b07_86ee:   brk                         ; 1C6EE:  00
b07_86ef:   brk                         ; 1C6EF:  00
b07_86f0:   ora ($00,x)                 ; 1C6F0:  01 00
b07_86f2:   brk                         ; 1C6F2:  00
b07_86f3:   brk                         ; 1C6F3:  00
b07_86f4:   sei                         ; 1C6F4:  78
b07_86f5:   .db $3c                     ; 1C6F5:  3c
b07_86f6:   .db $9e                     ; 1C6F6:  9e
b07_86f7:   .db $2f                     ; 1C6F7:  2f
b07_86f8:   .db $87                     ; 1C6F8:  87
b07_86f9:   .db $23                     ; 1C6F9:  23
b07_86fa:   .db $89                     ; 1C6FA:  89
b07_86fb:   .db $22                     ; 1C6FB:  22
b07_86fc:   .db $64                     ; 1C6FC:  64
b07_86fd:   .db $32                     ; 1C6FD:  32
b07_86fe:   cmp $c63c,y                 ; 1C6FE:  d9 3c c6
b07_8701:   .db $33                     ; 1C701:  33
b07_8702:   cmp $3f32                   ; 1C702:  cd 32 3f
b07_8705:   brk                         ; 1C705:  00
b07_8706:   ora ($01,x)                 ; 1C706:  01 01
b07_8708:   cmp ($f1,x)                 ; 1C708:  c1 f1
b07_870a:   sbc ($f3),y                 ; 1C70A:  f1 f3
b07_870c:   brk                         ; 1C70C:  00
b07_870d:   brk                         ; 1C70D:  00
b07_870e:   sta ($fd,x)                 ; 1C70E:  81 fd
b07_8710:   and $8d0d,x                 ; 1C710:  3d 0d 8d
b07_8713:   .db $cb                     ; 1C713:  cb
b07_8714:   sta ($c0,x)                 ; 1C714:  81 c0
b07_8716:   cmp ($00,x)                 ; 1C716:  c1 00
b07_8718:   ora $c0                     ; 1C718:  05 c0
b07_871a:   eor $00                     ; 1C71A:  45 00
b07_871c:   .db $1a                     ; 1C71C:  1a
b07_871d:   clc                         ; 1C71D:  18
b07_871e:   .db $3a                     ; 1C71E:  3a
b07_871f:   bvs $8713                   ; 1C71F:  70 f2
b07_8721:   bmi $86cd                   ; 1C721:  30 aa
b07_8723:   cpx #$05                    ; 1C723:  e0 05
b07_8725:   jsr $2208                   ; 1C725:  20 08 22
b07_8728:   dey                         ; 1C728:  88
b07_8729:   .db $02                     ; 1C729:  02
b07_872a:   dey                         ; 1C72A:  88
b07_872b:   .db $02                     ; 1C72B:  02
b07_872c:   .db $c2                     ; 1C72C:  c2
b07_872d:   bmi $873b                   ; 1C72D:  30 0c
b07_872f:   .db $33                     ; 1C72F:  33
b07_8730:   cpy $cc13                   ; 1C730:  cc 13 cc
b07_8733:   .db $03                     ; 1C733:  03
b07_8734:   eor $00,x                   ; 1C734:  55 00
b07_8736:   sta $20                     ; 1C736:  85 20
b07_8738:   dey                         ; 1C738:  88
b07_8739:   .db $22                     ; 1C739:  22
b07_873a:   .db $80                     ; 1C73A:  80
b07_873b:   .db $22                     ; 1C73B:  22
b07_873c:   tax                         ; 1C73C:  aa
b07_873d:   brk                         ; 1C73D:  00
b07_873e:   txa                         ; 1C73E:  8a
b07_873f:   bmi $870d                   ; 1C73F:  30 cc
b07_8741:   .db $33                     ; 1C741:  33
b07_8742:   cpy $33                     ; 1C742:  c4 33
b07_8744:   .db $44                     ; 1C744:  44
b07_8745:   .db $22                     ; 1C745:  22
b07_8746:   ora ($88),y                 ; 1C746:  11 88
b07_8748:   .db $44                     ; 1C748:  44
b07_8749:   .db $22                     ; 1C749:  22
b07_874a:   ora ($88),y                 ; 1C74A:  11 88
b07_874c:   cmp $77ee,x                 ; 1C74C:  dd ee 77
b07_874f:   tax                         ; 1C74F:  aa
b07_8750:   cmp $77ee,x                 ; 1C750:  dd ee 77
b07_8753:   tax                         ; 1C753:  aa
b07_8754:   .db $44                     ; 1C754:  44
b07_8755:   .db $22                     ; 1C755:  22
b07_8756:   ora ($88),y                 ; 1C756:  11 88
b07_8758:   rti                         ; 1C758:  40
b07_8759:   jsr $8000                   ; 1C759:  20 00 80
b07_875c:   cmp $77ee,x                 ; 1C75C:  dd ee 77
b07_875f:   tay                         ; 1C75F:  a8
b07_8760:   cld                         ; 1C760:  d8
b07_8761:   sbc ($63,x)                 ; 1C761:  e1 63
b07_8763:   .db $a7                     ; 1C763:  a7
b07_8764:   rti                         ; 1C764:  40
b07_8765:   brk                         ; 1C765:  00
b07_8766:   ora ($81,x)                 ; 1C766:  01 81
b07_8768:   eor ($00,x)                 ; 1C768:  41 00
b07_876a:   ora ($83,x)                 ; 1C76A:  01 83
b07_876c:   .db $c7                     ; 1C76C:  c7
b07_876d:   .db $cf                     ; 1C76D:  cf
b07_876e:   lsr $de8e                   ; 1C76E:  4e 8e de
b07_8771:   .db $9f                     ; 1C771:  9f
b07_8772:   asl $44bc,x                 ; 1C772:  1e bc 44
b07_8775:   jsr $0701                   ; 1C775:  20 01 07
b07_8778:   .db $1f                     ; 1C778:  1f
b07_8779:   .db $3f                     ; 1C779:  3f
b07_877a:   .db $7f                     ; 1C77A:  7f
b07_877b:   .db $7f                     ; 1C77B:  7f
b07_877c:   cmp $0ee0,x                 ; 1C77C:  dd e0 0e
b07_877f:   sei                         ; 1C77F:  78
b07_8780:   cpx #$c0                    ; 1C780:  e0 c0
b07_8782:   .db $80                     ; 1C782:  80
b07_8783:   .db $80                     ; 1C783:  80
b07_8784:   rti                         ; 1C784:  40
b07_8785:   brk                         ; 1C785:  00
b07_8786:   inc $ffff,x                 ; 1C786:  fe ff ff
b07_8789:   .db $ff                     ; 1C789:  ff
b07_878a:   .db $ff                     ; 1C78A:  ff
b07_878b:   .db $ff                     ; 1C78B:  ff
b07_878c:   cld                         ; 1C78C:  d8
b07_878d:   brk                         ; 1C78D:  00
b07_878e:   brk                         ; 1C78E:  00
b07_878f:   brk                         ; 1C78F:  00
b07_8790:   brk                         ; 1C790:  00
b07_8791:   brk                         ; 1C791:  00
b07_8792:   brk                         ; 1C792:  00
b07_8793:   brk                         ; 1C793:  00
b07_8794:   .db $ff                     ; 1C794:  ff
b07_8795:   .db $ff                     ; 1C795:  ff
b07_8796:   .db $ff                     ; 1C796:  ff
b07_8797:   .db $ff                     ; 1C797:  ff
b07_8798:   .db $ff                     ; 1C798:  ff
b07_8799:   .db $ff                     ; 1C799:  ff
b07_879a:   .db $ff                     ; 1C79A:  ff
b07_879b:   .db $ff                     ; 1C79B:  ff
b07_879c:   brk                         ; 1C79C:  00
b07_879d:   brk                         ; 1C79D:  00
b07_879e:   brk                         ; 1C79E:  00
b07_879f:   brk                         ; 1C79F:  00
b07_87a0:   brk                         ; 1C7A0:  00
b07_87a1:   brk                         ; 1C7A1:  00
b07_87a2:   brk                         ; 1C7A2:  00
b07_87a3:   brk                         ; 1C7A3:  00
b07_87a4:   .db $04                     ; 1C7A4:  04
b07_87a5:   .db $02                     ; 1C7A5:  02
b07_87a6:   ora ($80,x)                 ; 1C7A6:  01 80
b07_87a8:   cpy #$e0                    ; 1C7A8:  c0 e0
b07_87aa:   beq $879c                   ; 1C7AA:  f0 f0
b07_87ac:   ora $4e                     ; 1C7AC:  05 4e
b07_87ae:   .db $07                     ; 1C7AE:  07
b07_87af:   .db $02                     ; 1C7AF:  02
b07_87b0:   ora ($00,x)                 ; 1C7B0:  01 00
b07_87b2:   brk                         ; 1C7B2:  00
b07_87b3:   brk                         ; 1C7B3:  00
b07_87b4:   beq $87ae                   ; 1C7B4:  f0 f8
b07_87b6:   sed                         ; 1C7B6:  f8
b07_87b7:   sed                         ; 1C7B7:  f8
b07_87b8:   sed                         ; 1C7B8:  f8
b07_87b9:   sed                         ; 1C7B9:  f8
b07_87ba:   sed                         ; 1C7BA:  f8
b07_87bb:   beq $87bd                   ; 1C7BB:  f0 00
b07_87bd:   brk                         ; 1C7BD:  00
b07_87be:   brk                         ; 1C7BE:  00
b07_87bf:   brk                         ; 1C7BF:  00
b07_87c0:   brk                         ; 1C7C0:  00
b07_87c1:   brk                         ; 1C7C1:  00
b07_87c2:   brk                         ; 1C7C2:  00
b07_87c3:   brk                         ; 1C7C3:  00
b07_87c4:   .db $44                     ; 1C7C4:  44
b07_87c5:   .db $22                     ; 1C7C5:  22
b07_87c6:   ora ($08),y                 ; 1C7C6:  11 08
b07_87c8:   .db $04                     ; 1C7C8:  04
b07_87c9:   .db $22                     ; 1C7C9:  22
b07_87ca:   ora ($08),y                 ; 1C7CA:  11 08
b07_87cc:   eor $376e,x                 ; 1C7CC:  5d 6e 37
b07_87cf:   rol a                       ; 1C7CF:  2a
b07_87d0:   ora $372e,x                 ; 1C7D0:  1d 2e 37
b07_87d3:   rol a                       ; 1C7D3:  2a
b07_87d4:   .db $07                     ; 1C7D4:  07
b07_87d5:   .db $07                     ; 1C7D5:  07
b07_87d6:   ora ($00,x)                 ; 1C7D6:  01 00
b07_87d8:   rti                         ; 1C7D8:  40
b07_87d9:   rti                         ; 1C7D9:  40
b07_87da:   rti                         ; 1C7DA:  40
b07_87db:   .db $43                     ; 1C7DB:  43
b07_87dc:   clv                         ; 1C7DC:  b8
b07_87dd:   clv                         ; 1C7DD:  b8
b07_87de:   bmi $8808                   ; 1C7DE:  30 28
b07_87e0:   .db $17                     ; 1C7E0:  17
b07_87e1:   .db $1c                     ; 1C7E1:  1c
b07_87e2:   clc                         ; 1C7E2:  18
b07_87e3:   .db $3c                     ; 1C7E3:  3c
b07_87e4:   .db $43                     ; 1C7E4:  43
b07_87e5:   ora ($07,x)                 ; 1C7E5:  01 07
b07_87e7:   .db $8f                     ; 1C7E7:  8f
b07_87e8:   .db $0f                     ; 1C7E8:  0f
b07_87e9:   .db $07                     ; 1C7E9:  07
b07_87ea:   asl $80                     ; 1C7EA:  06 80
b07_87ec:   .db $3c                     ; 1C7EC:  3c
b07_87ed:   rol $b038,x                 ; 1C7ED:  3e 38 b0
b07_87f0:   bcs $87aa                   ; 1C7F0:  b0 b8
b07_87f2:   eor $ff9f,y                 ; 1C7F2:  59 9f ff
b07_87f5:   .db $ff                     ; 1C7F5:  ff
b07_87f6:   .db $ff                     ; 1C7F6:  ff
b07_87f7:   .db $7f                     ; 1C7F7:  7f
b07_87f8:   .db $0f                     ; 1C7F8:  0f
b07_87f9:   .db $0f                     ; 1C7F9:  0f
b07_87fa:   .db $43                     ; 1C7FA:  43
b07_87fb:   .db $c7                     ; 1C7FB:  c7
b07_87fc:   brk                         ; 1C7FC:  00
b07_87fd:   brk                         ; 1C7FD:  00
b07_87fe:   brk                         ; 1C7FE:  00
b07_87ff:   brk                         ; 1C7FF:  00
b07_8800:   ldy #$10                    ; 1C800:  a0 10
b07_8802:   .db $5c                     ; 1C802:  5c
b07_8803:   plp                         ; 1C803:  28
b07_8804:   .db $ff                     ; 1C804:  ff
b07_8805:   .db $ff                     ; 1C805:  ff
b07_8806:   .db $ff                     ; 1C806:  ff
b07_8807:   cpx #$a7                    ; 1C807:  e0 a7
b07_8809:   .db $8f                     ; 1C809:  8f
b07_880a:   ora ($92,x)                 ; 1C80A:  01 92
b07_880c:   brk                         ; 1C80C:  00
b07_880d:   brk                         ; 1C80D:  00
b07_880e:   brk                         ; 1C80E:  00
b07_880f:   brk                         ; 1C80F:  00
b07_8810:   brk                         ; 1C810:  00
b07_8811:   rti                         ; 1C811:  40
b07_8812:   ldy #$72                    ; 1C812:  a0 72
b07_8814:   .db $cf                     ; 1C814:  cf
b07_8815:   .db $8f                     ; 1C815:  8f
b07_8816:   .db $8f                     ; 1C816:  8f
b07_8817:   .db $8f                     ; 1C817:  8f
b07_8818:   .db $1f                     ; 1C818:  1f
b07_8819:   .db $1f                     ; 1C819:  1f
b07_881a:   .db $0c                     ; 1C81A:  0c
b07_881b:   brk                         ; 1C81B:  00
b07_881c:   bmi $886e                   ; 1C81C:  30 50
b07_881e:   bvs $8870                   ; 1C81E:  70 50
b07_8820:   ldy #$c0                    ; 1C820:  a0 c0
b07_8822:   cpy #$f1                    ; 1C822:  c0 f1
b07_8824:   .db $9f                     ; 1C824:  9f
b07_8825:   .db $cf                     ; 1C825:  cf
b07_8826:   .db $e7                     ; 1C826:  e7
b07_8827:   .db $bf                     ; 1C827:  bf
b07_8828:   .db $df                     ; 1C828:  df
b07_8829:   .db $8f                     ; 1C829:  8f
b07_882a:   .db $0f                     ; 1C82A:  0f
b07_882b:   .db $67                     ; 1C82B:  67
b07_882c:   rts                         ; 1C82C:  60
b07_882d:   bmi $8847                   ; 1C82D:  30 18
b07_882f:   brk                         ; 1C82F:  00
b07_8830:   brk                         ; 1C830:  00
b07_8831:   brk                         ; 1C831:  00
b07_8832:   bvs $87cc                   ; 1C832:  70 98
b07_8834:   cpx #$f8                    ; 1C834:  e0 f8
b07_8836:   sed                         ; 1C836:  f8
b07_8837:   .db $7c                     ; 1C837:  7c
b07_8838:   .db $dc                     ; 1C838:  dc
b07_8839:   .db $fc                     ; 1C839:  fc
b07_883a:   sbc $007f,x                 ; 1C83A:  fd 7f 00
b07_883d:   brk                         ; 1C83D:  00
b07_883e:   brk                         ; 1C83E:  00
b07_883f:   brk                         ; 1C83F:  00
b07_8840:   brk                         ; 1C840:  00
b07_8841:   brk                         ; 1C841:  00
b07_8842:   brk                         ; 1C842:  00
b07_8843:   brk                         ; 1C843:  00
b07_8844:   .db $04                     ; 1C844:  04
b07_8845:   .db $22                     ; 1C845:  22
b07_8846:   ora ($08),y                 ; 1C846:  11 08
b07_8848:   .db $04                     ; 1C848:  04
b07_8849:   .db $e2                     ; 1C849:  e2
b07_884a:   sbc ($28,x)                 ; 1C84A:  e1 28
b07_884c:   ora $772e,x                 ; 1C84C:  1d 2e 77
b07_884f:   rol a                       ; 1C84F:  2a
b07_8850:   ora $070e,x                 ; 1C850:  1d 0e 07
b07_8853:   asl a                       ; 1C853:  0a
b07_8854:   inc $fefc,x                 ; 1C854:  fe fc fe
b07_8857:   inc $fffc,x                 ; 1C857:  fe fc ff
b07_885a:   .db $ff                     ; 1C85A:  ff
b07_885b:   sed                         ; 1C85B:  f8
b07_885c:   brk                         ; 1C85C:  00
b07_885d:   brk                         ; 1C85D:  00
b07_885e:   brk                         ; 1C85E:  00
b07_885f:   brk                         ; 1C85F:  00
b07_8860:   brk                         ; 1C860:  00
b07_8861:   brk                         ; 1C861:  00
b07_8862:   brk                         ; 1C862:  00
b07_8863:   brk                         ; 1C863:  00
b07_8864:   ldy $62                     ; 1C864:  a4 62
b07_8866:   cmp ($c8),y                 ; 1C866:  d1 c8
b07_8868:   sty $a2                     ; 1C868:  84 a2
b07_886a:   ora ($88),y                 ; 1C86A:  11 88
b07_886c:   ora $170e                   ; 1C86C:  0d 0e 17
b07_886f:   asl a                       ; 1C86F:  0a
b07_8870:   ora $772e,x                 ; 1C870:  1d 2e 77
b07_8873:   tax                         ; 1C873:  aa
b07_8874:   .db $44                     ; 1C874:  44
b07_8875:   .db $22                     ; 1C875:  22
b07_8876:   ora ($88),y                 ; 1C876:  11 88
b07_8878:   .db $44                     ; 1C878:  44
b07_8879:   .db $22                     ; 1C879:  22
b07_887a:   ora ($88),y                 ; 1C87A:  11 88
b07_887c:   cmp $77ee,x                 ; 1C87C:  dd ee 77
b07_887f:   tax                         ; 1C87F:  aa
b07_8880:   cmp $77ee,x                 ; 1C880:  dd ee 77
b07_8883:   tay                         ; 1C883:  a8
b07_8884:   rti                         ; 1C884:  40
b07_8885:   brk                         ; 1C885:  00
b07_8886:   brk                         ; 1C886:  00
b07_8887:   .db $80                     ; 1C887:  80
b07_8888:   rti                         ; 1C888:  40
b07_8889:   jsr $0000                   ; 1C889:  20 00 00
b07_888c:   .db $df                     ; 1C88C:  df
b07_888d:   .db $df                     ; 1C88D:  df
b07_888e:   .db $5f                     ; 1C88E:  5f
b07_888f:   .db $9f                     ; 1C88F:  9f
b07_8890:   .db $cf                     ; 1C890:  cf
b07_8891:   .db $e7                     ; 1C891:  e7
b07_8892:   .db $67                     ; 1C892:  67
b07_8893:   .db $13                     ; 1C893:  13
b07_8894:   brk                         ; 1C894:  00
b07_8895:   brk                         ; 1C895:  00
b07_8896:   .db $80                     ; 1C896:  80
b07_8897:   jsr $2288                   ; 1C897:  20 88 22
b07_889a:   dey                         ; 1C89A:  88
b07_889b:   .db $22                     ; 1C89B:  22
b07_889c:   .db $07                     ; 1C89C:  07
b07_889d:   cmp $fdf7,x                 ; 1C89D:  dd f7 fd
b07_88a0:   .db $ff                     ; 1C8A0:  ff
b07_88a1:   .db $ff                     ; 1C8A1:  ff
b07_88a2:   inc $00fe,x                 ; 1C8A2:  fe fe 00
b07_88a5:   .db $04                     ; 1C8A5:  04
b07_88a6:   .db $04                     ; 1C8A6:  04
b07_88a7:   .db $04                     ; 1C8A7:  04
b07_88a8:   asl $16                     ; 1C8A8:  06 16
b07_88aa:   .db $43                     ; 1C8AA:  43
b07_88ab:   .db $13                     ; 1C8AB:  13
b07_88ac:   .db $53                     ; 1C8AC:  53
b07_88ad:   ldy $34                     ; 1C8AD:  a4 34
b07_88af:   adc $36                     ; 1C8AF:  65 36
b07_88b1:   ror $fb,x                   ; 1C8B1:  76 fb
b07_88b3:   .db $fb                     ; 1C8B3:  fb
b07_88b4:   ora ($0b,x)                 ; 1C8B4:  01 0b
b07_88b6:   .db $7f                     ; 1C8B6:  7f
b07_88b7:   .db $04                     ; 1C8B7:  04
b07_88b8:   .db $1f                     ; 1C8B8:  1f
b07_88b9:   ora ($00,x)                 ; 1C8B9:  01 00
b07_88bb:   brk                         ; 1C8BB:  00
b07_88bc:   .db $fc                     ; 1C8BC:  fc
b07_88bd:   beq $883f                   ; 1C8BD:  f0 80
b07_88bf:   brk                         ; 1C8BF:  00
b07_88c0:   ldy #$f0                    ; 1C8C0:  a0 f0
b07_88c2:   .db $fa                     ; 1C8C2:  fa
b07_88c3:   .db $ff                     ; 1C8C3:  ff
b07_88c4:   .db $f3                     ; 1C8C4:  f3
b07_88c5:   .db $fb                     ; 1C8C5:  fb
b07_88c6:   sbc $c73d,x                 ; 1C8C6:  fd 3d c7
b07_88c9:   .db $f7                     ; 1C8C9:  f7
b07_88ca:   .db $ff                     ; 1C8CA:  ff
b07_88cb:   .db $ff                     ; 1C8CB:  ff
b07_88cc:   .db $0c                     ; 1C8CC:  0c
b07_88cd:   .db $04                     ; 1C8CD:  04
b07_88ce:   .db $02                     ; 1C8CE:  02
b07_88cf:   .db $02                     ; 1C8CF:  02
b07_88d0:   brk                         ; 1C8D0:  00
b07_88d1:   brk                         ; 1C8D1:  00
b07_88d2:   brk                         ; 1C8D2:  00
b07_88d3:   brk                         ; 1C8D3:  00
b07_88d4:   .db $0f                     ; 1C8D4:  0f
b07_88d5:   .db $1f                     ; 1C8D5:  1f
b07_88d6:   .db $1f                     ; 1C8D6:  1f
b07_88d7:   .db $1f                     ; 1C8D7:  1f
b07_88d8:   brk                         ; 1C8D8:  00
b07_88d9:   brk                         ; 1C8D9:  00
b07_88da:   brk                         ; 1C8DA:  00
b07_88db:   .db $87                     ; 1C8DB:  87
b07_88dc:   beq $88be                   ; 1C8DC:  f0 e0
b07_88de:   jsr $8000                   ; 1C8DE:  20 00 80
b07_88e1:   cpy #$7f                    ; 1C8E1:  c0 7f
b07_88e3:   clv                         ; 1C8E3:  b8
b07_88e4:   .db $ff                     ; 1C8E4:  ff
b07_88e5:   .db $ff                     ; 1C8E5:  ff
b07_88e6:   sed                         ; 1C8E6:  f8
b07_88e7:   .db $c3                     ; 1C8E7:  c3
b07_88e8:   .db $07                     ; 1C8E8:  07
b07_88e9:   ora $df77,x                 ; 1C8E9:  1d 77 df
b07_88ec:   brk                         ; 1C8EC:  00
b07_88ed:   brk                         ; 1C8ED:  00
b07_88ee:   brk                         ; 1C8EE:  00
b07_88ef:   brk                         ; 1C8EF:  00
b07_88f0:   clc                         ; 1C8F0:  18
b07_88f1:   sbc ($87,x)                 ; 1C8F1:  e1 87
b07_88f3:   .db $1f                     ; 1C8F3:  1f
b07_88f4:   .db $fc                     ; 1C8F4:  fc
b07_88f5:   inc $f8f9,x                 ; 1C8F5:  fe f9 f8
b07_88f8:   .db $fc                     ; 1C8F8:  fc
b07_88f9:   .db $fc                     ; 1C8F9:  fc
b07_88fa:   .db $fc                     ; 1C8FA:  fc
b07_88fb:   cmp $0201,x                 ; 1C8FB:  dd 01 02
b07_88fe:   .db $07                     ; 1C8FE:  07
b07_88ff:   brk                         ; 1C8FF:  00
b07_8900:   .db $04                     ; 1C900:  04
b07_8901:   .db $04                     ; 1C901:  04
b07_8902:   ora $05                     ; 1C902:  05 05
b07_8904:   .db $44                     ; 1C904:  44
b07_8905:   .db $22                     ; 1C905:  22
b07_8906:   ora ($88),y                 ; 1C906:  11 88
b07_8908:   .db $44                     ; 1C908:  44
b07_8909:   .db $22                     ; 1C909:  22
b07_890a:   ora ($08),y                 ; 1C90A:  11 08
b07_890c:   cmp $77ee,x                 ; 1C90C:  dd ee 77
b07_890f:   tax                         ; 1C90F:  aa
b07_8910:   cmp $77ee,x                 ; 1C910:  dd ee 77
b07_8913:   tax                         ; 1C913:  aa
b07_8914:   ldy $d869,x                 ; 1C914:  bc 69 d8
b07_8917:   lda ($65),y                 ; 1C917:  b1 65
b07_8919:   cmp $85,x                   ; 1C919:  d5 85
b07_891b:   ora ($0d),y                 ; 1C91B:  11 0d
b07_891d:   .db $0b                     ; 1C91D:  0b
b07_891e:   .db $1b                     ; 1C91E:  1b
b07_891f:   .db $37                     ; 1C91F:  37
b07_8920:   .db $6f                     ; 1C920:  6f
b07_8921:   .db $df                     ; 1C921:  df
b07_8922:   .db $bf                     ; 1C922:  bf
b07_8923:   .db $7f                     ; 1C923:  7f
b07_8924:   .db $04                     ; 1C924:  04
b07_8925:   bpl $892b                   ; 1C925:  10 04
b07_8927:   ora ($04),y                 ; 1C927:  11 04
b07_8929:   ora ($15),y                 ; 1C929:  11 15
b07_892b:   ora $8d,x                   ; 1C92B:  15 8d
b07_892d:   bcs $88ee                   ; 1C92D:  b0 bf
b07_892f:   .db $bf                     ; 1C92F:  bf
b07_8930:   .db $bf                     ; 1C930:  bf
b07_8931:   .db $bf                     ; 1C931:  bf
b07_8932:   .db $bf                     ; 1C932:  bf
b07_8933:   .db $bf                     ; 1C933:  bf
b07_8934:   ora ($08),y                 ; 1C934:  11 08
b07_8936:   .db $04                     ; 1C936:  04
b07_8937:   jsr $8810                   ; 1C937:  20 10 88
b07_893a:   .db $44                     ; 1C93A:  44
b07_893b:   .db $22                     ; 1C93B:  22
b07_893c:   .db $77                     ; 1C93C:  77
b07_893d:   nop                         ; 1C93D:  ea
b07_893e:   cmp $77ab,x                 ; 1C93E:  dd ab 77
b07_8941:   tsx                         ; 1C941:  ba
b07_8942:   cmp $11ae,x                 ; 1C942:  dd ae 11
b07_8945:   php                         ; 1C945:  08
b07_8946:   .db $04                     ; 1C946:  04
b07_8947:   jsr $8810                   ; 1C947:  20 10 88
b07_894a:   eor ($23,x)                 ; 1C94A:  41 23
b07_894c:   .db $77                     ; 1C94C:  77
b07_894d:   nop                         ; 1C94D:  ea
b07_894e:   cmp $75aa,x                 ; 1C94E:  dd aa 75
b07_8951:   .db $bb                     ; 1C951:  bb
b07_8952:   dec $ac,x                   ; 1C952:  d6 ac
b07_8954:   .db $03                     ; 1C954:  03
b07_8955:   .db $03                     ; 1C955:  03
b07_8956:   .db $07                     ; 1C956:  07
b07_8957:   .db $07                     ; 1C957:  07
b07_8958:   .db $07                     ; 1C958:  07
b07_8959:   .db $87                     ; 1C959:  87
b07_895a:   .db $47                     ; 1C95A:  47
b07_895b:   .db $0f                     ; 1C95B:  0f
b07_895c:   jmp ($c8ec)                 ; 1C95C:  6c ec c8
b07_895f:   tya                         ; 1C95F:  98
b07_8960:   cli                         ; 1C960:  58
b07_8961:   tya                         ; 1C961:  98
b07_8962:   cld                         ; 1C962:  d8
b07_8963:   bcc $8976                   ; 1C963:  90 11
b07_8965:   php                         ; 1C965:  08
b07_8966:   .db $07                     ; 1C966:  07
b07_8967:   .db $1f                     ; 1C967:  1f
b07_8968:   .db $7f                     ; 1C968:  7f
b07_8969:   .db $ff                     ; 1C969:  ff
b07_896a:   .db $ff                     ; 1C96A:  ff
b07_896b:   .db $ff                     ; 1C96B:  ff
b07_896c:   .db $77                     ; 1C96C:  77
b07_896d:   nop                         ; 1C96D:  ea
b07_896e:   dey                         ; 1C96E:  88
b07_896f:   rts                         ; 1C96F:  60
b07_8970:   .db $80                     ; 1C970:  80
b07_8971:   brk                         ; 1C971:  00
b07_8972:   brk                         ; 1C972:  00
b07_8973:   brk                         ; 1C973:  00
b07_8974:   brk                         ; 1C974:  00
b07_8975:   brk                         ; 1C975:  00
b07_8976:   .db $ff                     ; 1C976:  ff
b07_8977:   .db $ff                     ; 1C977:  ff
b07_8978:   .db $ff                     ; 1C978:  ff
b07_8979:   .db $ff                     ; 1C979:  ff
b07_897a:   .db $ff                     ; 1C97A:  ff
b07_897b:   .db $ff                     ; 1C97B:  ff
b07_897c:   rts                         ; 1C97C:  60
b07_897d:   cpx #$00                    ; 1C97D:  e0 00
b07_897f:   brk                         ; 1C97F:  00
b07_8980:   brk                         ; 1C980:  00
b07_8981:   brk                         ; 1C981:  00
b07_8982:   brk                         ; 1C982:  00
b07_8983:   brk                         ; 1C983:  00
b07_8984:   .db $ff                     ; 1C984:  ff
b07_8985:   .db $ff                     ; 1C985:  ff
b07_8986:   .db $ff                     ; 1C986:  ff
b07_8987:   .db $ff                     ; 1C987:  ff
b07_8988:   .db $ff                     ; 1C988:  ff
b07_8989:   .db $ff                     ; 1C989:  ff
b07_898a:   .db $ff                     ; 1C98A:  ff
b07_898b:   .db $ff                     ; 1C98B:  ff
b07_898c:   brk                         ; 1C98C:  00
b07_898d:   brk                         ; 1C98D:  00
b07_898e:   brk                         ; 1C98E:  00
b07_898f:   brk                         ; 1C98F:  00
b07_8990:   brk                         ; 1C990:  00
b07_8991:   brk                         ; 1C991:  00
b07_8992:   brk                         ; 1C992:  00
b07_8993:   brk                         ; 1C993:  00
b07_8994:   .db $ff                     ; 1C994:  ff
b07_8995:   .db $ff                     ; 1C995:  ff
b07_8996:   .db $ff                     ; 1C996:  ff
b07_8997:   .db $ff                     ; 1C997:  ff
b07_8998:   inc $fffc,x                 ; 1C998:  fe fc ff
b07_899b:   .db $ff                     ; 1C99B:  ff
b07_899c:   brk                         ; 1C99C:  00
b07_899d:   brk                         ; 1C99D:  00
b07_899e:   brk                         ; 1C99E:  00
b07_899f:   brk                         ; 1C99F:  00
b07_89a0:   brk                         ; 1C9A0:  00
b07_89a1:   brk                         ; 1C9A1:  00
b07_89a2:   brk                         ; 1C9A2:  00
b07_89a3:   brk                         ; 1C9A3:  00
b07_89a4:   ora ($08,x)                 ; 1C9A4:  01 08
b07_89a6:   .db $04                     ; 1C9A6:  04
b07_89a7:   cpx #$f0                    ; 1C9A7:  e0 f0
b07_89a9:   sed                         ; 1C9A9:  f8
b07_89aa:   .db $fc                     ; 1C9AA:  fc
b07_89ab:   sbc $0a07,x                 ; 1C9AB:  fd 07 0a
b07_89ae:   ora $03                     ; 1C9AE:  05 03
b07_89b0:   ora ($00,x)                 ; 1C9B0:  01 00
b07_89b2:   brk                         ; 1C9B2:  00
b07_89b3:   ora ($11,x)                 ; 1C9B3:  01 11
b07_89b5:   php                         ; 1C9B5:  08
b07_89b6:   .db $04                     ; 1C9B6:  04
b07_89b7:   jsr $8810                   ; 1C9B7:  20 10 88
b07_89ba:   cpy $c2                     ; 1C9BA:  c4 c2
b07_89bc:   .db $77                     ; 1C9BC:  77
b07_89bd:   nop                         ; 1C9BD:  ea
b07_89be:   cmp $77ab,x                 ; 1C9BE:  dd ab 77
b07_89c1:   tsx                         ; 1C9C1:  ba
b07_89c2:   cmp $fece,x                 ; 1C9C2:  dd ce fe
b07_89c5:   .db $fc                     ; 1C9C5:  fc
b07_89c6:   cpx #$80                    ; 1C9C6:  e0 80
b07_89c8:   brk                         ; 1C9C8:  00
b07_89c9:   brk                         ; 1C9C9:  00
b07_89ca:   brk                         ; 1C9CA:  00
b07_89cb:   .db $80                     ; 1C9CB:  80
b07_89cc:   brk                         ; 1C9CC:  00
b07_89cd:   brk                         ; 1C9CD:  00
b07_89ce:   brk                         ; 1C9CE:  00
b07_89cf:   brk                         ; 1C9CF:  00
b07_89d0:   brk                         ; 1C9D0:  00
b07_89d1:   brk                         ; 1C9D1:  00
b07_89d2:   brk                         ; 1C9D2:  00
b07_89d3:   brk                         ; 1C9D3:  00
b07_89d4:   cmp ($00,x)                 ; 1C9D4:  c1 00
b07_89d6:   brk                         ; 1C9D6:  00
b07_89d7:   jsr $0000                   ; 1C9D7:  20 00 00
b07_89da:   .db $04                     ; 1C9DA:  04
b07_89db:   .db $22                     ; 1C9DB:  22
b07_89dc:   .db $c7                     ; 1C9DC:  c7
b07_89dd:   .db $02                     ; 1C9DD:  02
b07_89de:   eor ($23,x)                 ; 1C9DE:  41 23
b07_89e0:   .db $23                     ; 1C9E0:  23
b07_89e1:   .db $02                     ; 1C9E1:  02
b07_89e2:   ora $0f2e,x                 ; 1C9E2:  1d 2e 0f
b07_89e5:   .db $07                     ; 1C9E5:  07
b07_89e6:   ora ($00,x)                 ; 1C9E6:  01 00
b07_89e8:   brk                         ; 1C9E8:  00
b07_89e9:   .db $92                     ; 1C9E9:  92
b07_89ea:   rti                         ; 1C9EA:  40
b07_89eb:   brk                         ; 1C9EB:  00
b07_89ec:   jsr $a080                   ; 1C9EC:  20 80 a0
b07_89ef:   ldy $9240,x                 ; 1C9EF:  bc 40 92
b07_89f2:   dec $0cbe,x                 ; 1C9F2:  de be 0c
b07_89f5:   .db $1c                     ; 1C9F5:  1c
b07_89f6:   ora $1919,y                 ; 1C9F6:  19 19 19
b07_89f9:   .db $89                     ; 1C9F9:  89
b07_89fa:   rti                         ; 1C9FA:  40
b07_89fb:   brk                         ; 1C9FB:  00
b07_89fc:   .db $32                     ; 1C9FC:  32
b07_89fd:   ldx #$a4                    ; 1C9FD:  a2 a4
b07_89ff:   ldy $24                     ; 1C9FF:  a4 24
b07_8a01:   sty $de,x                   ; 1CA01:  94 de
b07_8a03:   .db $9f                     ; 1CA03:  9f
b07_8a04:   .db $ff                     ; 1CA04:  ff
b07_8a05:   .db $fc                     ; 1CA05:  fc
b07_8a06:   cpy #$e1                    ; 1CA06:  c0 e1
b07_8a08:   beq $8a7c                   ; 1CA08:  f0 72
b07_8a0a:   .db $7b                     ; 1CA0A:  7b
b07_8a0b:   sbc $0000,x                 ; 1CA0B:  fd 00 00
b07_8a0e:   brk                         ; 1CA0E:  00
b07_8a0f:   asl $08                     ; 1CA0F:  06 08
b07_8a11:   asl a                       ; 1CA11:  0a
b07_8a12:   .db $04                     ; 1CA12:  04
b07_8a13:   .db $02                     ; 1CA13:  02
b07_8a14:   .db $5f                     ; 1CA14:  5f
b07_8a15:   .db $2f                     ; 1CA15:  2f
b07_8a16:   .db $7f                     ; 1CA16:  7f
b07_8a17:   .db $ff                     ; 1CA17:  ff
b07_8a18:   .db $0f                     ; 1CA18:  0f
b07_8a19:   .db $5f                     ; 1CA19:  5f
b07_8a1a:   .db $ff                     ; 1CA1A:  ff
b07_8a1b:   .db $ff                     ; 1CA1B:  ff
b07_8a1c:   brk                         ; 1CA1C:  00
b07_8a1d:   brk                         ; 1CA1D:  00
b07_8a1e:   brk                         ; 1CA1E:  00
b07_8a1f:   brk                         ; 1CA1F:  00
b07_8a20:   brk                         ; 1CA20:  00
b07_8a21:   rti                         ; 1CA21:  40
b07_8a22:   brk                         ; 1CA22:  00
b07_8a23:   brk                         ; 1CA23:  00
b07_8a24:   .db $ff                     ; 1CA24:  ff
b07_8a25:   .db $ff                     ; 1CA25:  ff
b07_8a26:   .db $ef                     ; 1CA26:  ef
b07_8a27:   .db $ff                     ; 1CA27:  ff
b07_8a28:   .db $f7                     ; 1CA28:  f7
b07_8a29:   .db $87                     ; 1CA29:  87
b07_8a2a:   .db $1b                     ; 1CA2A:  1b
b07_8a2b:   and $0000,x                 ; 1CA2B:  3d 00 00
b07_8a2e:   brk                         ; 1CA2E:  00
b07_8a2f:   brk                         ; 1CA2F:  00
b07_8a30:   php                         ; 1CA30:  08
b07_8a31:   php                         ; 1CA31:  08
b07_8a32:   bit $c2                     ; 1CA32:  24 c2
b07_8a34:   .db $80                     ; 1CA34:  80
b07_8a35:   .db $80                     ; 1CA35:  80
b07_8a36:   cpy #$c0                    ; 1CA36:  c0 c0
b07_8a38:   cpy #$c7                    ; 1CA38:  c0 c7
b07_8a3a:   iny                         ; 1CA3A:  c8
b07_8a3b:   bne $8a3d                   ; 1CA3B:  d0 00
b07_8a3d:   brk                         ; 1CA3D:  00
b07_8a3e:   brk                         ; 1CA3E:  00
b07_8a3f:   brk                         ; 1CA3F:  00
b07_8a40:   brk                         ; 1CA40:  00
b07_8a41:   brk                         ; 1CA41:  00
b07_8a42:   brk                         ; 1CA42:  00
b07_8a43:   asl $11                     ; 1CA43:  06 11
b07_8a45:   php                         ; 1CA45:  08
b07_8a46:   .db $04                     ; 1CA46:  04
b07_8a47:   jsr $0810                   ; 1CA47:  20 10 08
b07_8a4a:   sty $a2                     ; 1CA4A:  84 a2
b07_8a4c:   .db $37                     ; 1CA4C:  37
b07_8a4d:   rol a                       ; 1CA4D:  2a
b07_8a4e:   ora $772b,x                 ; 1CA4E:  1d 2b 77
b07_8a51:   .db $3a                     ; 1CA51:  3a
b07_8a52:   ora $d02e,x                 ; 1CA52:  1d 2e d0
b07_8a55:   sbc ($f1),y                 ; 1CA55:  f1 f1
b07_8a57:   .db $e3                     ; 1CA57:  e3
b07_8a58:   inc $fc,x                   ; 1CA58:  f6 fc
b07_8a5a:   cld                         ; 1CA5A:  d8
b07_8a5b:   .db $c2                     ; 1CA5B:  c2
b07_8a5c:   .db $02                     ; 1CA5C:  02
b07_8a5d:   .db $04                     ; 1CA5D:  04
b07_8a5e:   .db $04                     ; 1CA5E:  04
b07_8a5f:   php                         ; 1CA5F:  08
b07_8a60:   brk                         ; 1CA60:  00
b07_8a61:   brk                         ; 1CA61:  00
b07_8a62:   ora ($02,x)                 ; 1CA62:  01 02
b07_8a64:   sta ($88),y                 ; 1CA64:  91 88
b07_8a66:   .db $04                     ; 1CA66:  04
b07_8a67:   jsr $8810                   ; 1CA67:  20 10 88
b07_8a6a:   .db $44                     ; 1CA6A:  44
b07_8a6b:   .db $22                     ; 1CA6B:  22
b07_8a6c:   .db $37                     ; 1CA6C:  37
b07_8a6d:   rol a                       ; 1CA6D:  2a
b07_8a6e:   eor $772b,x                 ; 1CA6E:  5d 2b 77
b07_8a71:   tsx                         ; 1CA71:  ba
b07_8a72:   cmp $01ae,x                 ; 1CA72:  dd ae 01
b07_8a75:   brk                         ; 1CA75:  00
b07_8a76:   brk                         ; 1CA76:  00
b07_8a77:   jsr $8810                   ; 1CA77:  20 10 88
b07_8a7a:   rti                         ; 1CA7A:  40
b07_8a7b:   jsr $ee6e                   ; 1CA7B:  20 6e ee
b07_8a7e:   .db $d7                     ; 1CA7E:  d7
b07_8a7f:   .db $a7                     ; 1CA7F:  a7
b07_8a80:   .db $73                     ; 1CA80:  73
b07_8a81:   .db $bb                     ; 1CA81:  bb
b07_8a82:   .db $db                     ; 1CA82:  db
b07_8a83:   lda $0811                   ; 1CA83:  ad 11 08
b07_8a86:   .db $04                     ; 1CA86:  04
b07_8a87:   brk                         ; 1CA87:  00
b07_8a88:   rti                         ; 1CA88:  40
b07_8a89:   ora ($44),y                 ; 1CA89:  11 44
b07_8a8b:   ora ($77),y                 ; 1CA8B:  11 77
b07_8a8d:   nop                         ; 1CA8D:  ea
b07_8a8e:   .db $dc                     ; 1CA8E:  dc
b07_8a8f:   .db $02                     ; 1CA8F:  02
b07_8a90:   dey                         ; 1CA90:  88
b07_8a91:   .db $22                     ; 1CA91:  22
b07_8a92:   dey                         ; 1CA92:  88
b07_8a93:   .db $22                     ; 1CA93:  22
b07_8a94:   bpl $8a9e                   ; 1CA94:  10 08
b07_8a96:   brk                         ; 1CA96:  00
b07_8a97:   brk                         ; 1CA97:  00
b07_8a98:   brk                         ; 1CA98:  00
b07_8a99:   brk                         ; 1CA99:  00
b07_8a9a:   rti                         ; 1CA9A:  40
b07_8a9b:   bpl $8b12                   ; 1CA9B:  10 75
b07_8a9d:   inx                         ; 1CA9D:  e8
b07_8a9e:   brk                         ; 1CA9E:  00
b07_8a9f:   .db $22                     ; 1CA9F:  22
b07_8aa0:   dey                         ; 1CAA0:  88
b07_8aa1:   jsr $2288                   ; 1CAA1:  20 88 22
b07_8aa4:   .db $ff                     ; 1CAA4:  ff
b07_8aa5:   .db $43                     ; 1CAA5:  43
b07_8aa6:   sed                         ; 1CAA6:  f8
b07_8aa7:   asl $3f0f,x                 ; 1CAA7:  1e 0f 3f
b07_8aaa:   .db $7f                     ; 1CAAA:  7f
b07_8aab:   .db $7f                     ; 1CAAB:  7f
b07_8aac:   brk                         ; 1CAAC:  00
b07_8aad:   brk                         ; 1CAAD:  00
b07_8aae:   ora ($01,x)                 ; 1CAAE:  01 01
b07_8ab0:   ldy #$c0                    ; 1CAB0:  a0 c0
b07_8ab2:   .db $80                     ; 1CAB2:  80
b07_8ab3:   .db $80                     ; 1CAB3:  80
b07_8ab4:   .db $ff                     ; 1CAB4:  ff
b07_8ab5:   .db $ff                     ; 1CAB5:  ff
b07_8ab6:   .db $ff                     ; 1CAB6:  ff
b07_8ab7:   .db $ff                     ; 1CAB7:  ff
b07_8ab8:   .db $ff                     ; 1CAB8:  ff
b07_8ab9:   .db $ff                     ; 1CAB9:  ff
b07_8aba:   inc $00f9,x                 ; 1CABA:  fe f9 00
b07_8abd:   brk                         ; 1CABD:  00
b07_8abe:   brk                         ; 1CABE:  00
b07_8abf:   brk                         ; 1CABF:  00
b07_8ac0:   brk                         ; 1CAC0:  00
b07_8ac1:   brk                         ; 1CAC1:  00
b07_8ac2:   brk                         ; 1CAC2:  00
b07_8ac3:   brk                         ; 1CAC3:  00
b07_8ac4:   .db $7f                     ; 1CAC4:  7f
b07_8ac5:   .db $3f                     ; 1CAC5:  3f
b07_8ac6:   brk                         ; 1CAC6:  00
b07_8ac7:   brk                         ; 1CAC7:  00
b07_8ac8:   brk                         ; 1CAC8:  00
b07_8ac9:   .db $43                     ; 1CAC9:  43
b07_8aca:   .db $03                     ; 1CACA:  03
b07_8acb:   .db $43                     ; 1CACB:  43
b07_8acc:   .db $80                     ; 1CACC:  80
b07_8acd:   cpy #$00                    ; 1CACD:  c0 00
b07_8acf:   brk                         ; 1CACF:  00
b07_8ad0:   .db $9f                     ; 1CAD0:  9f
b07_8ad1:   .db $0c                     ; 1CAD1:  0c
b07_8ad2:   jmp ($e32c)                 ; 1CAD2:  6c 2c e3
b07_8ad5:   .db $07                     ; 1CAD5:  07
b07_8ad6:   .db $0f                     ; 1CAD6:  0f
b07_8ad7:   asl $f97c,x                 ; 1CAD7:  1e 7c f9
b07_8ada:   .db $f2                     ; 1CADA:  f2
b07_8adb:   sbc $00                     ; 1CADB:  e5 00
b07_8add:   ora #$33                    ; 1CADD:  09 33
b07_8adf:   inc $8d                     ; 1CADF:  e6 8d
b07_8ae1:   .db $1a                     ; 1CAE1:  1a
b07_8ae2:   and $6a,x                   ; 1CAE2:  35 6a
b07_8ae4:   cmp ($cc,x)                 ; 1CAE4:  c1 cc
b07_8ae6:   cpy $b898                   ; 1CAE6:  cc 98 b8
b07_8ae9:   bvs $8adb                   ; 1CAE9:  70 f0
b07_8aeb:   sbc ($13,x)                 ; 1CAEB:  e1 13
b07_8aed:   asl $1d,x                   ; 1CAED:  16 1d
b07_8aef:   and #$58                    ; 1CAEF:  29 58
b07_8af1:   .db $12                     ; 1CAF1:  12
b07_8af2:   bmi $8b5e                   ; 1CAF2:  30 6a
b07_8af4:   ora ($08),y                 ; 1CAF4:  11 08
b07_8af6:   .db $04                     ; 1CAF6:  04
b07_8af7:   jsr $8810                   ; 1CAF7:  20 10 88
b07_8afa:   .db $44                     ; 1CAFA:  44
b07_8afb:   .db $22                     ; 1CAFB:  22
b07_8afc:   .db $77                     ; 1CAFC:  77
b07_8afd:   nop                         ; 1CAFD:  ea
b07_8afe:   cmp $77ab,x                 ; 1CAFE:  dd ab 77
b07_8b01:   tsx                         ; 1CB01:  ba
b07_8b02:   eor $c42e,x                 ; 1CB02:  5d 2e c4
b07_8b05:   sta ($24),y                 ; 1CB05:  91 24
b07_8b07:   eor ($84,x)                 ; 1CB07:  41 84
b07_8b09:   eor ($84),y                 ; 1CB09:  51 84
b07_8b0b:   ora ($d0),y                 ; 1CB0B:  11 d0
b07_8b0d:   ldx #$48                    ; 1CB0D:  a2 48
b07_8b0f:   ldx #$48                    ; 1CB0F:  a2 48
b07_8b11:   .db $82                     ; 1CB11:  82
b07_8b12:   php                         ; 1CB12:  08
b07_8b13:   ldx #$01                    ; 1CB13:  a2 01
b07_8b15:   bpl $8b1b                   ; 1CB15:  10 04
b07_8b17:   ora ($04),y                 ; 1CB17:  11 04
b07_8b19:   ora ($44),y                 ; 1CB19:  11 44
b07_8b1b:   ora ($87),y                 ; 1CB1B:  11 87
b07_8b1d:   jsr $2288                   ; 1CB1D:  20 88 22
b07_8b20:   dey                         ; 1CB20:  88
b07_8b21:   .db $22                     ; 1CB21:  22
b07_8b22:   php                         ; 1CB22:  08
b07_8b23:   .db $22                     ; 1CB23:  22
b07_8b24:   ora ($44),y                 ; 1CB24:  11 44
b07_8b26:   ora ($44),y                 ; 1CB26:  11 44
b07_8b28:   ora ($44),y                 ; 1CB28:  11 44
b07_8b2a:   ora ($44),y                 ; 1CB2A:  11 44
b07_8b2c:   cmp $dd77,x                 ; 1CB2C:  dd 77 dd
b07_8b2f:   .db $77                     ; 1CB2F:  77
b07_8b30:   cmp $dd77,x                 ; 1CB30:  dd 77 dd
b07_8b33:   .db $77                     ; 1CB33:  77
b07_8b34:   brk                         ; 1CB34:  00
b07_8b35:   ora ($01,x)                 ; 1CB35:  01 01
b07_8b37:   brk                         ; 1CB37:  00
b07_8b38:   .db $03                     ; 1CB38:  03
b07_8b39:   .db $47                     ; 1CB39:  47
b07_8b3a:   .db $07                     ; 1CB3A:  07
b07_8b3b:   .db $47                     ; 1CB3B:  47
b07_8b3c:   cpy #$01                    ; 1CB3C:  c0 01
b07_8b3e:   sta ($04,x)                 ; 1CB3E:  81 04
b07_8b40:   .db $80                     ; 1CB40:  80
b07_8b41:   rti                         ; 1CB41:  40
b07_8b42:   cpy #$40                    ; 1CB42:  c0 40
b07_8b44:   .db $07                     ; 1CB44:  07
b07_8b45:   .db $07                     ; 1CB45:  07
b07_8b46:   .db $03                     ; 1CB46:  03
b07_8b47:   .db $03                     ; 1CB47:  03
b07_8b48:   ora ($00,x)                 ; 1CB48:  01 00
b07_8b4a:   ora ($00,x)                 ; 1CB4A:  01 00
b07_8b4c:   .db $80                     ; 1CB4C:  80
b07_8b4d:   brk                         ; 1CB4D:  00
b07_8b4e:   .db $80                     ; 1CB4E:  80
b07_8b4f:   brk                         ; 1CB4F:  00
b07_8b50:   brk                         ; 1CB50:  00
b07_8b51:   brk                         ; 1CB51:  00
b07_8b52:   brk                         ; 1CB52:  00
b07_8b53:   brk                         ; 1CB53:  00
b07_8b54:   cpy #$80                    ; 1CB54:  c0 80
b07_8b56:   brk                         ; 1CB56:  00
b07_8b57:   inc $ffff,x                 ; 1CB57:  fe ff ff
b07_8b5a:   .db $ff                     ; 1CB5A:  ff
b07_8b5b:   .db $ff                     ; 1CB5B:  ff
b07_8b5c:   cpy #$80                    ; 1CB5C:  c0 80
b07_8b5e:   brk                         ; 1CB5E:  00
b07_8b5f:   brk                         ; 1CB5F:  00
b07_8b60:   brk                         ; 1CB60:  00
b07_8b61:   brk                         ; 1CB61:  00
b07_8b62:   brk                         ; 1CB62:  00
b07_8b63:   brk                         ; 1CB63:  00
b07_8b64:   ora ($00,x)                 ; 1CB64:  01 00
b07_8b66:   brk                         ; 1CB66:  00
b07_8b67:   brk                         ; 1CB67:  00
b07_8b68:   .db $80                     ; 1CB68:  80
b07_8b69:   sbc $ffff,y                 ; 1CB69:  f9 ff ff
b07_8b6c:   ora $0003                   ; 1CB6C:  0d 03 00
b07_8b6f:   .db $03                     ; 1CB6F:  03
b07_8b70:   .db $0f                     ; 1CB70:  0f
b07_8b71:   asl $00                     ; 1CB71:  06 00
b07_8b73:   brk                         ; 1CB73:  00
b07_8b74:   .db $ff                     ; 1CB74:  ff
b07_8b75:   .db $ff                     ; 1CB75:  ff
b07_8b76:   .db $ff                     ; 1CB76:  ff
b07_8b77:   .db $ff                     ; 1CB77:  ff
b07_8b78:   .db $ff                     ; 1CB78:  ff
b07_8b79:   .db $ff                     ; 1CB79:  ff
b07_8b7a:   .db $7f                     ; 1CB7A:  7f
b07_8b7b:   .db $bf                     ; 1CB7B:  bf
b07_8b7c:   brk                         ; 1CB7C:  00
b07_8b7d:   brk                         ; 1CB7D:  00
b07_8b7e:   brk                         ; 1CB7E:  00
b07_8b7f:   brk                         ; 1CB7F:  00
b07_8b80:   brk                         ; 1CB80:  00
b07_8b81:   brk                         ; 1CB81:  00
b07_8b82:   brk                         ; 1CB82:  00
b07_8b83:   brk                         ; 1CB83:  00
b07_8b84:   .db $ff                     ; 1CB84:  ff
b07_8b85:   .db $ff                     ; 1CB85:  ff
b07_8b86:   .db $ff                     ; 1CB86:  ff
b07_8b87:   .db $ff                     ; 1CB87:  ff
b07_8b88:   .db $ff                     ; 1CB88:  ff
b07_8b89:   .db $ff                     ; 1CB89:  ff
b07_8b8a:   .db $ef                     ; 1CB8A:  ef
b07_8b8b:   .db $e7                     ; 1CB8B:  e7
b07_8b8c:   brk                         ; 1CB8C:  00
b07_8b8d:   brk                         ; 1CB8D:  00
b07_8b8e:   brk                         ; 1CB8E:  00
b07_8b8f:   brk                         ; 1CB8F:  00
b07_8b90:   brk                         ; 1CB90:  00
b07_8b91:   brk                         ; 1CB91:  00
b07_8b92:   bpl $8ba4                   ; 1CB92:  10 10
b07_8b94:   ora ($44),y                 ; 1CB94:  11 44
b07_8b96:   ora ($04),y                 ; 1CB96:  11 04
b07_8b98:   ora ($04),y                 ; 1CB98:  11 04
b07_8b9a:   cmp ($e0,x)                 ; 1CB9A:  c1 e0
b07_8b9c:   cmp $dd77,x                 ; 1CB9C:  dd 77 dd
b07_8b9f:   .db $37                     ; 1CB9F:  37
b07_8ba0:   cmp $35e7,x                 ; 1CBA0:  dd e7 35
b07_8ba3:   .db $1b                     ; 1CBA3:  1b
b07_8ba4:   sbc ($f0,x)                 ; 1CBA4:  e1 f0
b07_8ba6:   sbc ($f0),y                 ; 1CBA6:  f1 f0
b07_8ba8:   beq $8ba6                   ; 1CBA8:  f0 fc
b07_8baa:   .db $fc                     ; 1CBAA:  fc
b07_8bab:   cld                         ; 1CBAB:  d8
b07_8bac:   ora $0d0d,y                 ; 1CBAC:  19 0d 0d
b07_8baf:   ora $020e                   ; 1CBAF:  0d 0e 02
b07_8bb2:   .db $02                     ; 1CBB2:  02
b07_8bb3:   asl $00                     ; 1CBB3:  06 00
b07_8bb5:   brk                         ; 1CBB5:  00
b07_8bb6:   brk                         ; 1CBB6:  00
b07_8bb7:   brk                         ; 1CBB7:  00
b07_8bb8:   brk                         ; 1CBB8:  00
b07_8bb9:   bvs $8c03                   ; 1CBB9:  70 48
b07_8bbb:   .db $44                     ; 1CBBB:  44
b07_8bbc:   brk                         ; 1CBBC:  00
b07_8bbd:   brk                         ; 1CBBD:  00
b07_8bbe:   brk                         ; 1CBBE:  00
b07_8bbf:   brk                         ; 1CBBF:  00
b07_8bc0:   brk                         ; 1CBC0:  00
b07_8bc1:   brk                         ; 1CBC1:  00
b07_8bc2:   brk                         ; 1CBC2:  00
b07_8bc3:   bpl $8c05                   ; 1CBC3:  10 40
b07_8bc5:   rti                         ; 1CBC5:  40
b07_8bc6:   .db $62                     ; 1CBC6:  62
b07_8bc7:   .db $34                     ; 1CBC7:  34
b07_8bc8:   sec                         ; 1CBC8:  38
b07_8bc9:   lsr $410e,x                 ; 1CBC9:  5e 0e 41
b07_8bcc:   brk                         ; 1CBCC:  00
b07_8bcd:   php                         ; 1CBCD:  08
b07_8bce:   php                         ; 1CBCE:  08
b07_8bcf:   php                         ; 1CBCF:  08
b07_8bd0:   .db $80                     ; 1CBD0:  80
b07_8bd1:   rti                         ; 1CBD1:  40
b07_8bd2:   cpy #$60                    ; 1CBD2:  c0 60
b07_8bd4:   .db $7f                     ; 1CBD4:  7f
b07_8bd5:   .db $7f                     ; 1CBD5:  7f
b07_8bd6:   .db $77                     ; 1CBD6:  77
b07_8bd7:   inx                         ; 1CBD7:  e8
b07_8bd8:   .db $d4                     ; 1CBD8:  d4
b07_8bd9:   inc $fff9,x                 ; 1CBD9:  fe f9 ff
b07_8bdc:   brk                         ; 1CBDC:  00
b07_8bdd:   brk                         ; 1CBDD:  00
b07_8bde:   brk                         ; 1CBDE:  00
b07_8bdf:   brk                         ; 1CBDF:  00
b07_8be0:   .db $03                     ; 1CBE0:  03
b07_8be1:   brk                         ; 1CBE1:  00
b07_8be2:   ora ($00,x)                 ; 1CBE2:  01 00
b07_8be4:   .db $e3                     ; 1CBE4:  e3
b07_8be5:   .db $f3                     ; 1CBE5:  f3
b07_8be6:   sbc ($31),y                 ; 1CBE6:  f1 31
b07_8be8:   brk                         ; 1CBE8:  00
b07_8be9:   .db $03                     ; 1CBE9:  03
b07_8bea:   .db $33                     ; 1CBEA:  33
b07_8beb:   .db $e7                     ; 1CBEB:  e7
b07_8bec:   clc                         ; 1CBEC:  18
b07_8bed:   php                         ; 1CBED:  08
b07_8bee:   .db $0c                     ; 1CBEE:  0c
b07_8bef:   php                         ; 1CBEF:  08
b07_8bf0:   .db $03                     ; 1CBF0:  03
b07_8bf1:   .db $04                     ; 1CBF1:  04
b07_8bf2:   .db $34                     ; 1CBF2:  34
b07_8bf3:   clc                         ; 1CBF3:  18
b07_8bf4:   .db $7f                     ; 1CBF4:  7f
b07_8bf5:   .db $3f                     ; 1CBF5:  3f
b07_8bf6:   .db $5f                     ; 1CBF6:  5f
b07_8bf7:   .db $7f                     ; 1CBF7:  7f
b07_8bf8:   .db $bf                     ; 1CBF8:  bf
b07_8bf9:   .db $5f                     ; 1CBF9:  5f
b07_8bfa:   .db $3f                     ; 1CBFA:  3f
b07_8bfb:   .db $1f                     ; 1CBFB:  1f
b07_8bfc:   brk                         ; 1CBFC:  00
b07_8bfd:   brk                         ; 1CBFD:  00
b07_8bfe:   brk                         ; 1CBFE:  00
b07_8bff:   brk                         ; 1CBFF:  00
b07_8c00:   brk                         ; 1CC00:  00
b07_8c01:   brk                         ; 1CC01:  00
b07_8c02:   brk                         ; 1CC02:  00
b07_8c03:   brk                         ; 1CC03:  00
b07_8c04:   .db $e7                     ; 1CC04:  e7
b07_8c05:   .db $cf                     ; 1CC05:  cf
b07_8c06:   .db $ff                     ; 1CC06:  ff
b07_8c07:   sbc $f0fb,x                 ; 1CC07:  fd fb f0
b07_8c0a:   inc $10de                   ; 1CC0A:  ee de 10
b07_8c0d:   jsr $0000                   ; 1CC0D:  20 00 00
b07_8c10:   brk                         ; 1CC10:  00
b07_8c11:   .db $04                     ; 1CC11:  04
b07_8c12:   ora ($21),y                 ; 1CC12:  11 21
b07_8c14:   beq $8bd6                   ; 1CC14:  f0 c0
b07_8c16:   .db $80                     ; 1CC16:  80
b07_8c17:   brk                         ; 1CC17:  00
b07_8c18:   ora ($08,x)                 ; 1CC18:  01 08
b07_8c1a:   lda ($b0),y                 ; 1CC1A:  b1 b0
b07_8c1c:   .db $0c                     ; 1CC1C:  0c
b07_8c1d:   .db $12                     ; 1CC1D:  12
b07_8c1e:   bit $8e                     ; 1CC1E:  24 8e
b07_8c20:   sta ($0d,x)                 ; 1CC20:  81 0d
b07_8c22:   ora $804e                   ; 1CC22:  0d 4e 80
b07_8c25:   tya                         ; 1CC25:  98
b07_8c26:   cld                         ; 1CC26:  d8
b07_8c27:   iny                         ; 1CC27:  c8
b07_8c28:   cpy #$40                    ; 1CC28:  c0 40
b07_8c2a:   ora ($00,x)                 ; 1CC2A:  01 00
b07_8c2c:   rol $2626,x                 ; 1CC2C:  3e 26 26
b07_8c2f:   asl $1e,x                   ; 1CC2F:  16 1e
b07_8c31:   asl $fd3d,x                 ; 1CC31:  1e 3d fd
b07_8c34:   ora ($44),y                 ; 1CC34:  11 44
b07_8c36:   ora ($44),y                 ; 1CC36:  11 44
b07_8c38:   ora ($44),y                 ; 1CC38:  11 44
b07_8c3a:   brk                         ; 1CC3A:  00
b07_8c3b:   brk                         ; 1CC3B:  00
b07_8c3c:   cmp $dd77,x                 ; 1CC3C:  dd 77 dd
b07_8c3f:   .db $77                     ; 1CC3F:  77
b07_8c40:   cmp $0174,x                 ; 1CC40:  dd 74 01
b07_8c43:   .db $77                     ; 1CC43:  77
b07_8c44:   brk                         ; 1CC44:  00
b07_8c45:   lsr $05                     ; 1CC45:  46 05
b07_8c47:   .db $47                     ; 1CC47:  47
b07_8c48:   .db $02                     ; 1CC48:  02
b07_8c49:   .db $0b                     ; 1CC49:  0b
b07_8c4a:   ora ($09,x)                 ; 1CC4A:  01 09
b07_8c4c:   bne $8cb2                   ; 1CC4C:  d0 64
b07_8c4e:   cpy $56                     ; 1CC4E:  c4 56
b07_8c50:   .db $da                     ; 1CC50:  da
b07_8c51:   .db $3b                     ; 1CC51:  3b
b07_8c52:   eor $027d,x                 ; 1CC52:  5d 7d 02
b07_8c55:   php                         ; 1CC55:  08
b07_8c56:   .db $22                     ; 1CC56:  22
b07_8c57:   dey                         ; 1CC57:  88
b07_8c58:   .db $22                     ; 1CC58:  22
b07_8c59:   .db $80                     ; 1CC59:  80
b07_8c5a:   .db $22                     ; 1CC5A:  22
b07_8c5b:   .db $80                     ; 1CC5B:  80
b07_8c5c:   .db $df                     ; 1CC5C:  df
b07_8c5d:   .db $7f                     ; 1CC5D:  7f
b07_8c5e:   .db $ff                     ; 1CC5E:  ff
b07_8c5f:   .db $ff                     ; 1CC5F:  ff
b07_8c60:   .db $ff                     ; 1CC60:  ff
b07_8c61:   .db $f7                     ; 1CC61:  f7
b07_8c62:   .db $eb                     ; 1CC62:  eb
b07_8c63:   cmp $0822,x                 ; 1CC63:  dd 22 08
b07_8c66:   .db $22                     ; 1CC66:  22
b07_8c67:   dey                         ; 1CC67:  88
b07_8c68:   .db $22                     ; 1CC68:  22
b07_8c69:   dey                         ; 1CC69:  88
b07_8c6a:   brk                         ; 1CC6A:  00
b07_8c6b:   dey                         ; 1CC6B:  88
b07_8c6c:   ror $bf7e,x                 ; 1CC6C:  7e 7e bf
b07_8c6f:   .db $bf                     ; 1CC6F:  bf
b07_8c70:   .db $bf                     ; 1CC70:  bf
b07_8c71:   .db $bf                     ; 1CC71:  bf
b07_8c72:   cmp $bfdf,x                 ; 1CC72:  dd df bf
b07_8c75:   .db $bf                     ; 1CC75:  bf
b07_8c76:   .db $ff                     ; 1CC76:  ff
b07_8c77:   .db $7f                     ; 1CC77:  7f
b07_8c78:   .db $bf                     ; 1CC78:  bf
b07_8c79:   .db $df                     ; 1CC79:  df
b07_8c7a:   .db $6f                     ; 1CC7A:  6f
b07_8c7b:   .db $f7                     ; 1CC7B:  f7
b07_8c7c:   brk                         ; 1CC7C:  00
b07_8c7d:   brk                         ; 1CC7D:  00
b07_8c7e:   brk                         ; 1CC7E:  00
b07_8c7f:   brk                         ; 1CC7F:  00
b07_8c80:   brk                         ; 1CC80:  00
b07_8c81:   brk                         ; 1CC81:  00
b07_8c82:   brk                         ; 1CC82:  00
b07_8c83:   .db $80                     ; 1CC83:  80
b07_8c84:   .db $df                     ; 1CC84:  df
b07_8c85:   tya                         ; 1CC85:  98
b07_8c86:   .db $87                     ; 1CC86:  87
b07_8c87:   .db $9e                     ; 1CC87:  9e
b07_8c88:   bcs $8c42                   ; 1CC88:  b0 b8
b07_8c8a:   .db $ff                     ; 1CC8A:  ff
b07_8c8b:   .db $ff                     ; 1CC8B:  ff
b07_8c8c:   jsr $4040                   ; 1CC8C:  20 40 40
b07_8c8f:   brk                         ; 1CC8F:  00
b07_8c90:   jmp $0043                   ; 1CC90:  4c 43 00
b07_8c93:   brk                         ; 1CC93:  00
b07_8c94:   lda ($f8),y                 ; 1CC94:  b1 f8
b07_8c96:   .db $5c                     ; 1CC96:  5c
b07_8c97:   .db $7f                     ; 1CC97:  7f
b07_8c98:   .db $2f                     ; 1CC98:  2f
b07_8c99:   .db $37                     ; 1CC99:  37
b07_8c9a:   .db $1b                     ; 1CC9A:  1b
b07_8c9b:   ora $c488                   ; 1CC9B:  0d 88 c4
b07_8c9e:   .db $43                     ; 1CC9E:  43
b07_8c9f:   rts                         ; 1CC9F:  60
b07_8ca0:   ldy #$30                    ; 1CCA0:  a0 30
b07_8ca2:   cld                         ; 1CCA2:  d8
b07_8ca3:   jmp ($3eff)                 ; 1CCA3:  6c ff 3e
b07_8ca6:   brk                         ; 1CCA6:  00
b07_8ca7:   ora ($c1,x)                 ; 1CCA7:  01 c1
b07_8ca9:   sbc ($e2,x)                 ; 1CCA9:  e1 e2
b07_8cab:   .db $e2                     ; 1CCAB:  e2
b07_8cac:   brk                         ; 1CCAC:  00
b07_8cad:   ora ($80,x)                 ; 1CCAD:  01 80
b07_8caf:   sbc $1d3d,x                 ; 1CCAF:  fd 3d 1d
b07_8cb2:   .db $1b                     ; 1CCB2:  1b
b07_8cb3:   .db $1b                     ; 1CCB3:  1b
b07_8cb4:   sta ($00,x)                 ; 1CCB4:  81 00
b07_8cb6:   sta ($00,x)                 ; 1CCB6:  81 00
b07_8cb8:   ora ($00,x)                 ; 1CCB8:  01 00
b07_8cba:   brk                         ; 1CCBA:  00
b07_8cbb:   .db $80                     ; 1CCBB:  80
b07_8cbc:   adc $599b,x                 ; 1CCBC:  7d 9b 59
b07_8cbf:   .db $7b                     ; 1CCBF:  7b
b07_8cc0:   adc $e1,x                   ; 1CCC0:  75 e1
b07_8cc2:   inx                         ; 1CCC2:  e8
b07_8cc3:   .db $62                     ; 1CCC3:  62
b07_8cc4:   ora ($44),y                 ; 1CCC4:  11 44
b07_8cc6:   ora ($44),y                 ; 1CCC6:  11 44
b07_8cc8:   ora ($44),y                 ; 1CCC8:  11 44
b07_8cca:   ora ($00,x)                 ; 1CCCA:  01 00
b07_8ccc:   cmp $dd77,x                 ; 1CCCC:  dd 77 dd
b07_8ccf:   .db $77                     ; 1CCCF:  77
b07_8cd0:   cmp $0577,x                 ; 1CCD0:  dd 77 05
b07_8cd3:   and ($80,x)                 ; 1CCD3:  21 80
b07_8cd5:   brk                         ; 1CCD5:  00
b07_8cd6:   brk                         ; 1CCD6:  00
b07_8cd7:   brk                         ; 1CCD7:  00
b07_8cd8:   brk                         ; 1CCD8:  00
b07_8cd9:   brk                         ; 1CCD9:  00
b07_8cda:   brk                         ; 1CCDA:  00
b07_8cdb:   brk                         ; 1CCDB:  00
b07_8cdc:   pha                         ; 1CCDC:  48
b07_8cdd:   ldx #$08                    ; 1CCDD:  a2 08
b07_8cdf:   .db $13                     ; 1CCDF:  13
b07_8ce0:   sta $d527                   ; 1CCE0:  8d 27 d5
b07_8ce3:   .db $77                     ; 1CCE3:  77
b07_8ce4:   brk                         ; 1CCE4:  00
b07_8ce5:   brk                         ; 1CCE5:  00
b07_8ce6:   brk                         ; 1CCE6:  00
b07_8ce7:   brk                         ; 1CCE7:  00
b07_8ce8:   brk                         ; 1CCE8:  00
b07_8ce9:   brk                         ; 1CCE9:  00
b07_8cea:   brk                         ; 1CCEA:  00
b07_8ceb:   brk                         ; 1CCEB:  00
b07_8cec:   .db $9c                     ; 1CCEC:  9c
b07_8ced:   .db $77                     ; 1CCED:  77
b07_8cee:   cmp $d973,y                 ; 1CCEE:  d9 73 d9
b07_8cf1:   eor $ad,x                   ; 1CCF1:  55 ad
b07_8cf3:   adc $aa,x                   ; 1CCF3:  75 aa
b07_8cf5:   tax                         ; 1CCF5:  aa
b07_8cf6:   tax                         ; 1CCF6:  aa
b07_8cf7:   tax                         ; 1CCF7:  aa
b07_8cf8:   tax                         ; 1CCF8:  aa
b07_8cf9:   tax                         ; 1CCF9:  aa
b07_8cfa:   tax                         ; 1CCFA:  aa
b07_8cfb:   tax                         ; 1CCFB:  aa
b07_8cfc:   tax                         ; 1CCFC:  aa
b07_8cfd:   tax                         ; 1CCFD:  aa
b07_8cfe:   tax                         ; 1CCFE:  aa
b07_8cff:   tax                         ; 1CCFF:  aa
b07_8d00:   tax                         ; 1CD00:  aa
b07_8d01:   tax                         ; 1CD01:  aa
b07_8d02:   tax                         ; 1CD02:  aa
b07_8d03:   tax                         ; 1CD03:  aa
b07_8d04:   ldy #$a8                    ; 1CD04:  a0 a8
b07_8d06:   ldy #$a0                    ; 1CD06:  a0 a0
b07_8d08:   tay                         ; 1CD08:  a8
b07_8d09:   lda ($a1,x)                 ; 1CD09:  a1 a1
b07_8d0b:   .db $a3                     ; 1CD0B:  a3
b07_8d0c:   ldy #$a8                    ; 1CD0C:  a0 a8
b07_8d0e:   ldy #$a1                    ; 1CD0E:  a0 a1
b07_8d10:   .db $ab                     ; 1CD10:  ab
b07_8d11:   ldx $a6                     ; 1CD11:  a6 a6
b07_8d13:   ldy $83a3                   ; 1CD13:  ac a3 83
b07_8d16:   .db $80                     ; 1CD16:  80
b07_8d17:   sta ($81,x)                 ; 1CD17:  81 81
b07_8d19:   .db $80                     ; 1CD19:  80
b07_8d1a:   .db $80                     ; 1CD1A:  80
b07_8d1b:   .db $80                     ; 1CD1B:  80
b07_8d1c:   ldy $8084                   ; 1CD1C:  ac 84 80
b07_8d1f:   .db $80                     ; 1CD1F:  80
b07_8d20:   .db $82                     ; 1CD20:  82
b07_8d21:   .db $83                     ; 1CD21:  83
b07_8d22:   .db $83                     ; 1CD22:  83
b07_8d23:   .db $87                     ; 1CD23:  87
b07_8d24:   tax                         ; 1CD24:  aa
b07_8d25:   .db $9f                     ; 1CD25:  9f
b07_8d26:   .db $3f                     ; 1CD26:  3f
b07_8d27:   .db $7f                     ; 1CD27:  7f
b07_8d28:   .db $ff                     ; 1CD28:  ff
b07_8d29:   .db $ff                     ; 1CD29:  ff
b07_8d2a:   .db $ff                     ; 1CD2A:  ff
b07_8d2b:   .db $ff                     ; 1CD2B:  ff
b07_8d2c:   tax                         ; 1CD2C:  aa
b07_8d2d:   ldy #$c0                    ; 1CD2D:  a0 c0
b07_8d2f:   .db $80                     ; 1CD2F:  80
b07_8d30:   brk                         ; 1CD30:  00
b07_8d31:   brk                         ; 1CD31:  00
b07_8d32:   brk                         ; 1CD32:  00
b07_8d33:   brk                         ; 1CD33:  00
b07_8d34:   tax                         ; 1CD34:  aa
b07_8d35:   .db $fa                     ; 1CD35:  fa
b07_8d36:   inc $ffff,x                 ; 1CD36:  fe ff ff
b07_8d39:   .db $ff                     ; 1CD39:  ff
b07_8d3a:   .db $ff                     ; 1CD3A:  ff
b07_8d3b:   .db $ff                     ; 1CD3B:  ff
b07_8d3c:   tax                         ; 1CD3C:  aa
b07_8d3d:   asl a                       ; 1CD3D:  0a
b07_8d3e:   brk                         ; 1CD3E:  00
b07_8d3f:   brk                         ; 1CD3F:  00
b07_8d40:   brk                         ; 1CD40:  00
b07_8d41:   brk                         ; 1CD41:  00
b07_8d42:   brk                         ; 1CD42:  00
b07_8d43:   brk                         ; 1CD43:  00
b07_8d44:   .db $ff                     ; 1CD44:  ff
b07_8d45:   .db $ff                     ; 1CD45:  ff
b07_8d46:   .db $ff                     ; 1CD46:  ff
b07_8d47:   .db $ff                     ; 1CD47:  ff
b07_8d48:   .db $ff                     ; 1CD48:  ff
b07_8d49:   .db $fc                     ; 1CD49:  fc
b07_8d4a:   beq $8d18                   ; 1CD4A:  f0 cc
b07_8d4c:   brk                         ; 1CD4C:  00
b07_8d4d:   brk                         ; 1CD4D:  00
b07_8d4e:   brk                         ; 1CD4E:  00
b07_8d4f:   brk                         ; 1CD4F:  00
b07_8d50:   brk                         ; 1CD50:  00
b07_8d51:   brk                         ; 1CD51:  00
b07_8d52:   brk                         ; 1CD52:  00
b07_8d53:   .db $03                     ; 1CD53:  03
b07_8d54:   .db $ff                     ; 1CD54:  ff
b07_8d55:   .db $ff                     ; 1CD55:  ff
b07_8d56:   .db $ff                     ; 1CD56:  ff
b07_8d57:   .db $df                     ; 1CD57:  df
b07_8d58:   ldx $3e1e,y                 ; 1CD58:  be 1e 3e
b07_8d5b:   .db $3c                     ; 1CD5B:  3c
b07_8d5c:   brk                         ; 1CD5C:  00
b07_8d5d:   brk                         ; 1CD5D:  00
b07_8d5e:   brk                         ; 1CD5E:  00
b07_8d5f:   brk                         ; 1CD5F:  00
b07_8d60:   brk                         ; 1CD60:  00
b07_8d61:   brk                         ; 1CD61:  00
b07_8d62:   brk                         ; 1CD62:  00
b07_8d63:   .db $c3                     ; 1CD63:  c3
b07_8d64:   tax                         ; 1CD64:  aa
b07_8d65:   tax                         ; 1CD65:  aa
b07_8d66:   tax                         ; 1CD66:  aa
b07_8d67:   tax                         ; 1CD67:  aa
b07_8d68:   nop                         ; 1CD68:  ea
b07_8d69:   nop                         ; 1CD69:  ea
b07_8d6a:   .db $f2                     ; 1CD6A:  f2
b07_8d6b:   .db $f2                     ; 1CD6B:  f2
b07_8d6c:   tax                         ; 1CD6C:  aa
b07_8d6d:   tax                         ; 1CD6D:  aa
b07_8d6e:   tax                         ; 1CD6E:  aa
b07_8d6f:   rol a                       ; 1CD6F:  2a
b07_8d70:   rol a                       ; 1CD70:  2a
b07_8d71:   asl a                       ; 1CD71:  0a
b07_8d72:   .db $02                     ; 1CD72:  02
b07_8d73:   .db $02                     ; 1CD73:  02
b07_8d74:   .db $fa                     ; 1CD74:  fa
b07_8d75:   .db $fa                     ; 1CD75:  fa
b07_8d76:   sed                         ; 1CD76:  f8
b07_8d77:   .db $fc                     ; 1CD77:  fc
b07_8d78:   sty $3814                   ; 1CD78:  8c 14 38
b07_8d7b:   sec                         ; 1CD7B:  38
b07_8d7c:   .db $02                     ; 1CD7C:  02
b07_8d7d:   .db $02                     ; 1CD7D:  02
b07_8d7e:   brk                         ; 1CD7E:  00
b07_8d7f:   brk                         ; 1CD7F:  00
b07_8d80:   brk                         ; 1CD80:  00
b07_8d81:   brk                         ; 1CD81:  00
b07_8d82:   brk                         ; 1CD82:  00
b07_8d83:   cpy $80                     ; 1CD83:  c4 80
b07_8d85:   .db $80                     ; 1CD85:  80
b07_8d86:   bcs $8dd1                   ; 1CD86:  b0 49
b07_8d88:   eor ($41,x)                 ; 1CD88:  41 41
b07_8d8a:   .db $4b                     ; 1CD8A:  4b
b07_8d8b:   .db $4b                     ; 1CD8B:  4b
b07_8d8c:   .db $87                     ; 1CD8C:  87
b07_8d8d:   .db $87                     ; 1CD8D:  87
b07_8d8e:   .db $87                     ; 1CD8E:  87
b07_8d8f:   asl $2e                     ; 1CD8F:  06 2e
b07_8d91:   asl $24                     ; 1CD91:  06 24
b07_8d93:   bit $63                     ; 1CD93:  24 63
b07_8d95:   .db $bb                     ; 1CD95:  bb
b07_8d96:   sta $a9a1,y                 ; 1CD96:  99 a1 a9
b07_8d99:   tay                         ; 1CD99:  a8
b07_8d9a:   tay                         ; 1CD9A:  a8
b07_8d9b:   tay                         ; 1CD9B:  a8
b07_8d9c:   .db $14                     ; 1CD9C:  14
b07_8d9d:   sty $86                     ; 1CD9D:  84 86
b07_8d9f:   ldx $ae                     ; 1CD9F:  a6 ae
b07_8da1:   .db $af                     ; 1CDA1:  af
b07_8da2:   .db $ab                     ; 1CDA2:  ab
b07_8da3:   .db $ab                     ; 1CDA3:  ab
b07_8da4:   sec                         ; 1CDA4:  38
b07_8da5:   .db $72                     ; 1CDA5:  72
b07_8da6:   jmp ($9c3f)                 ; 1CDA6:  6c 3f 9c
b07_8da9:   .db $ff                     ; 1CDA9:  ff
b07_8daa:   .db $ff                     ; 1CDAA:  ff
b07_8dab:   inc $82c0,x                 ; 1CDAB:  fe c0 82
b07_8dae:   sty $63c0                   ; 1CDAE:  8c c0 63
b07_8db1:   brk                         ; 1CDB1:  00
b07_8db2:   brk                         ; 1CDB2:  00
b07_8db3:   ora ($1c,x)                 ; 1CDB3:  01 1c
b07_8db5:   .db $1c                     ; 1CDB5:  1c
b07_8db6:   sta $3f3e,x                 ; 1CDB6:  9d 3e 3f
b07_8db9:   .db $3f                     ; 1CDB9:  3f
b07_8dba:   .db $ff                     ; 1CDBA:  ff
b07_8dbb:   dec $e3                     ; 1CDBB:  c6 e3
b07_8dbd:   .db $62                     ; 1CDBD:  62
b07_8dbe:   .db $63                     ; 1CDBE:  63
b07_8dbf:   cpy #$c0                    ; 1CDBF:  c0 c0
b07_8dc1:   .db $80                     ; 1CDC1:  80
b07_8dc2:   brk                         ; 1CDC2:  00
b07_8dc3:   jsr $fcfe                   ; 1CDC3:  20 fe fc
b07_8dc6:   sbc $ffff,x                 ; 1CDC6:  fd ff ff
b07_8dc9:   .db $ff                     ; 1CDC9:  ff
b07_8dca:   .db $ff                     ; 1CDCA:  ff
b07_8dcb:   inc $0301,x                 ; 1CDCB:  fe 01 03
b07_8dce:   .db $02                     ; 1CDCE:  02
b07_8dcf:   brk                         ; 1CDCF:  00
b07_8dd0:   brk                         ; 1CDD0:  00
b07_8dd1:   brk                         ; 1CDD1:  00
b07_8dd2:   brk                         ; 1CDD2:  00
b07_8dd3:   brk                         ; 1CDD3:  00
b07_8dd4:   brk                         ; 1CDD4:  00
b07_8dd5:   brk                         ; 1CDD5:  00
b07_8dd6:   .db $80                     ; 1CDD6:  80
b07_8dd7:   .db $e3                     ; 1CDD7:  e3
b07_8dd8:   .db $ff                     ; 1CDD8:  ff
b07_8dd9:   sty $3e                     ; 1CDD9:  84 3e
b07_8ddb:   adc ($46,x)                 ; 1CDDB:  61 46
b07_8ddd:   .db $92                     ; 1CDDD:  92
b07_8dde:   .db $7f                     ; 1CDDE:  7f
b07_8ddf:   .db $1c                     ; 1CDDF:  1c
b07_8de0:   brk                         ; 1CDE0:  00
b07_8de1:   brk                         ; 1CDE1:  00
b07_8de2:   brk                         ; 1CDE2:  00
b07_8de3:   brk                         ; 1CDE3:  00
b07_8de4:   clc                         ; 1CDE4:  18
b07_8de5:   tay                         ; 1CDE5:  a8
b07_8de6:   tya                         ; 1CDE6:  98
b07_8de7:   .db $fc                     ; 1CDE7:  fc
b07_8de8:   .db $7c                     ; 1CDE8:  7c
b07_8de9:   ror $befe,x                 ; 1CDE9:  7e fe be
b07_8dec:   .db $04                     ; 1CDEC:  04
b07_8ded:   ldy $84                     ; 1CDED:  a4 84
b07_8def:   .db $02                     ; 1CDEF:  02
b07_8df0:   .db $82                     ; 1CDF0:  82
b07_8df1:   brk                         ; 1CDF1:  00
b07_8df2:   brk                         ; 1CDF2:  00
b07_8df3:   brk                         ; 1CDF3:  00
b07_8df4:   tax                         ; 1CDF4:  aa
b07_8df5:   tax                         ; 1CDF5:  aa
b07_8df6:   tax                         ; 1CDF6:  aa
b07_8df7:   rol a                       ; 1CDF7:  2a
b07_8df8:   rol a                       ; 1CDF8:  2a
b07_8df9:   rol a                       ; 1CDF9:  2a
b07_8dfa:   rol a                       ; 1CDFA:  2a
b07_8dfb:   rol a                       ; 1CDFB:  2a
b07_8dfc:   tax                         ; 1CDFC:  aa
b07_8dfd:   tax                         ; 1CDFD:  aa
b07_8dfe:   tax                         ; 1CDFE:  aa
b07_8dff:   rol a                       ; 1CDFF:  2a
b07_8e00:   rol a                       ; 1CE00:  2a
b07_8e01:   rol a                       ; 1CE01:  2a
b07_8e02:   rol a                       ; 1CE02:  2a
b07_8e03:   rol a                       ; 1CE03:  2a
b07_8e04:   rol $de3e,x                 ; 1CE04:  3e 3e de
b07_8e07:   inc $fcfc,x                 ; 1CE07:  fe fc fc
b07_8e0a:   .db $7c                     ; 1CE0A:  7c
b07_8e0b:   sei                         ; 1CE0B:  78
b07_8e0c:   .db $80                     ; 1CE0C:  80
b07_8e0d:   rti                         ; 1CE0D:  40
b07_8e0e:   jsr $0200                   ; 1CE0E:  20 00 02
b07_8e11:   .db $02                     ; 1CE11:  02
b07_8e12:   .db $02                     ; 1CE12:  02
b07_8e13:   .db $04                     ; 1CE13:  04
b07_8e14:   tay                         ; 1CE14:  a8
b07_8e15:   tay                         ; 1CE15:  a8
b07_8e16:   tay                         ; 1CE16:  a8
b07_8e17:   ldy $a2                     ; 1CE17:  a4 a2
b07_8e19:   tax                         ; 1CE19:  aa
b07_8e1a:   txa                         ; 1CE1A:  8a
b07_8e1b:   .db $1a                     ; 1CE1B:  1a
b07_8e1c:   .db $ab                     ; 1CE1C:  ab
b07_8e1d:   lda #$aa                    ; 1CE1D:  a9 aa
b07_8e1f:   .db $a3                     ; 1CE1F:  a3
b07_8e20:   .db $a3                     ; 1CE20:  a3
b07_8e21:   .db $ab                     ; 1CE21:  ab
b07_8e22:   .db $82                     ; 1CE22:  82
b07_8e23:   asl a                       ; 1CE23:  0a
b07_8e24:   ldy #$1b                    ; 1CE24:  a0 1b
b07_8e26:   inc $ffff                   ; 1CE26:  ee ff ff
b07_8e29:   .db $ff                     ; 1CE29:  ff
b07_8e2a:   .db $ff                     ; 1CE2A:  ff
b07_8e2b:   .db $ff                     ; 1CE2B:  ff
b07_8e2c:   ldy #$0a                    ; 1CE2C:  a0 0a
b07_8e2e:   brk                         ; 1CE2E:  00
b07_8e2f:   tax                         ; 1CE2F:  aa
b07_8e30:   brk                         ; 1CE30:  00
b07_8e31:   tax                         ; 1CE31:  aa
b07_8e32:   brk                         ; 1CE32:  00
b07_8e33:   tax                         ; 1CE33:  aa
b07_8e34:   .db $cb                     ; 1CE34:  cb
b07_8e35:   .db $9b                     ; 1CE35:  9b
b07_8e36:   .db $cb                     ; 1CE36:  cb
b07_8e37:   sta $ddcd,x                 ; 1CE37:  9d cd dd
b07_8e3a:   cmp $03de                   ; 1CE3A:  cd de 03
b07_8e3d:   .db $8b                     ; 1CE3D:  8b
b07_8e3e:   .db $03                     ; 1CE3E:  03
b07_8e3f:   .db $89                     ; 1CE3F:  89
b07_8e40:   ora ($89,x)                 ; 1CE40:  01 89
b07_8e42:   ora ($8a,x)                 ; 1CE42:  01 8a
b07_8e44:   .db $7f                     ; 1CE44:  7f
b07_8e45:   .db $7f                     ; 1CE45:  7f
b07_8e46:   .db $3f                     ; 1CE46:  3f
b07_8e47:   .db $0f                     ; 1CE47:  0f
b07_8e48:   brk                         ; 1CE48:  00
b07_8e49:   brk                         ; 1CE49:  00
b07_8e4a:   brk                         ; 1CE4A:  00
b07_8e4b:   brk                         ; 1CE4B:  00
b07_8e4c:   .db $80                     ; 1CE4C:  80
b07_8e4d:   .db $80                     ; 1CE4D:  80
b07_8e4e:   cpy #$70                    ; 1CE4E:  c0 70
b07_8e50:   .db $9f                     ; 1CE50:  9f
b07_8e51:   cmp ($e0,x)                 ; 1CE51:  c1 e0
b07_8e53:   sed                         ; 1CE53:  f8
b07_8e54:   cpy #$9e                    ; 1CE54:  c0 9e
b07_8e56:   .db $ff                     ; 1CE56:  ff
b07_8e57:   .db $ff                     ; 1CE57:  ff
b07_8e58:   .db $ff                     ; 1CE58:  ff
b07_8e59:   .db $7f                     ; 1CE59:  7f
b07_8e5a:   .db $07                     ; 1CE5A:  07
b07_8e5b:   brk                         ; 1CE5B:  00
b07_8e5c:   ora $61,x                   ; 1CE5C:  15 61
b07_8e5e:   brk                         ; 1CE5E:  00
b07_8e5f:   brk                         ; 1CE5F:  00
b07_8e60:   brk                         ; 1CE60:  00
b07_8e61:   .db $80                     ; 1CE61:  80
b07_8e62:   sei                         ; 1CE62:  78
b07_8e63:   brk                         ; 1CE63:  00
b07_8e64:   brk                         ; 1CE64:  00
b07_8e65:   clc                         ; 1CE65:  18
b07_8e66:   .db $1f                     ; 1CE66:  1f
b07_8e67:   .db $1f                     ; 1CE67:  1f
b07_8e68:   .db $8f                     ; 1CE68:  8f
b07_8e69:   .db $8f                     ; 1CE69:  8f
b07_8e6a:   dec $ffcd                   ; 1CE6A:  ce cd ff
b07_8e6d:   .db $e7                     ; 1CE6D:  e7
b07_8e6e:   rts                         ; 1CE6E:  60
b07_8e6f:   rts                         ; 1CE6F:  60
b07_8e70:   bcs $8e22                   ; 1CE70:  b0 b0
b07_8e72:   bne $8e35                   ; 1CE72:  d0 c1
b07_8e74:   ora ($03,x)                 ; 1CE74:  01 03
b07_8e76:   asl $fd                     ; 1CE76:  06 fd
b07_8e78:   .db $fb                     ; 1CE78:  fb
b07_8e79:   .db $f7                     ; 1CE79:  f7
b07_8e7a:   .db $ef                     ; 1CE7A:  ef
b07_8e7b:   .db $df                     ; 1CE7B:  df
b07_8e7c:   ora ($fb,x)                 ; 1CE7C:  01 fb
b07_8e7e:   inc $180c,x                 ; 1CE7E:  fe 0c 18
b07_8e81:   .db $72                     ; 1CE81:  72
b07_8e82:   cpx #$ca                    ; 1CE82:  e0 ca
b07_8e84:   sed                         ; 1CE84:  f8
b07_8e85:   .db $f2                     ; 1CE85:  f2
b07_8e86:   .db $f2                     ; 1CE86:  f2
b07_8e87:   .db $e2                     ; 1CE87:  e2
b07_8e88:   sty $5e9c                   ; 1CE88:  8c 9c 5e
b07_8e8b:   ldx $0a04,y                 ; 1CE8B:  be 04 0a
b07_8e8e:   asl a                       ; 1CE8E:  0a
b07_8e8f:   .db $12                     ; 1CE8F:  12
b07_8e90:   jsr $4008                   ; 1CE90:  20 08 40
b07_8e93:   tax                         ; 1CE93:  aa
b07_8e94:   tax                         ; 1CE94:  aa
b07_8e95:   tax                         ; 1CE95:  aa
b07_8e96:   tax                         ; 1CE96:  aa
b07_8e97:   tax                         ; 1CE97:  aa
b07_8e98:   tax                         ; 1CE98:  aa
b07_8e99:   rol a                       ; 1CE99:  2a
b07_8e9a:   txa                         ; 1CE9A:  8a
b07_8e9b:   beq $8e47                   ; 1CE9B:  f0 aa
b07_8e9d:   tax                         ; 1CE9D:  aa
b07_8e9e:   tax                         ; 1CE9E:  aa
b07_8e9f:   tax                         ; 1CE9F:  aa
b07_8ea0:   tax                         ; 1CEA0:  aa
b07_8ea1:   rol a                       ; 1CEA1:  2a
b07_8ea2:   asl a                       ; 1CEA2:  0a
b07_8ea3:   ldy #$be                    ; 1CEA3:  a0 be
b07_8ea5:   adc $fbfd,x                 ; 1CEA5:  7d fd fb
b07_8ea8:   .db $fb                     ; 1CEA8:  fb
b07_8ea9:   .db $f7                     ; 1CEA9:  f7
b07_8eaa:   .db $f7                     ; 1CEAA:  f7
b07_8eab:   .db $ef                     ; 1CEAB:  ef
b07_8eac:   .db $80                     ; 1CEAC:  80
b07_8ead:   plp                         ; 1CEAD:  28
b07_8eae:   brk                         ; 1CEAE:  00
b07_8eaf:   tax                         ; 1CEAF:  aa
b07_8eb0:   brk                         ; 1CEB0:  00
b07_8eb1:   ldx #$00                    ; 1CEB1:  a2 00
b07_8eb3:   tax                         ; 1CEB3:  aa
b07_8eb4:   .db $ff                     ; 1CEB4:  ff
b07_8eb5:   .db $ff                     ; 1CEB5:  ff
b07_8eb6:   .db $ff                     ; 1CEB6:  ff
b07_8eb7:   .db $ff                     ; 1CEB7:  ff
b07_8eb8:   .db $ff                     ; 1CEB8:  ff
b07_8eb9:   .db $ff                     ; 1CEB9:  ff
b07_8eba:   .db $ff                     ; 1CEBA:  ff
b07_8ebb:   .db $ff                     ; 1CEBB:  ff
b07_8ebc:   brk                         ; 1CEBC:  00
b07_8ebd:   tax                         ; 1CEBD:  aa
b07_8ebe:   brk                         ; 1CEBE:  00
b07_8ebf:   tax                         ; 1CEBF:  aa
b07_8ec0:   brk                         ; 1CEC0:  00
b07_8ec1:   tax                         ; 1CEC1:  aa
b07_8ec2:   brk                         ; 1CEC2:  00
b07_8ec3:   tax                         ; 1CEC3:  aa
b07_8ec4:   eor $00,x                   ; 1CEC4:  55 00
b07_8ec6:   eor $00,x                   ; 1CEC6:  55 00
b07_8ec8:   eor $00,x                   ; 1CEC8:  55 00
b07_8eca:   eor $00,x                   ; 1CECA:  55 00
b07_8ecc:   tax                         ; 1CECC:  aa
b07_8ecd:   brk                         ; 1CECD:  00
b07_8ece:   tax                         ; 1CECE:  aa
b07_8ecf:   brk                         ; 1CECF:  00
b07_8ed0:   tax                         ; 1CED0:  aa
b07_8ed1:   brk                         ; 1CED1:  00
b07_8ed2:   tax                         ; 1CED2:  aa
b07_8ed3:   brk                         ; 1CED3:  00
b07_8ed4:   eor $00,x                   ; 1CED4:  55 00
b07_8ed6:   eor $00,x                   ; 1CED6:  55 00
b07_8ed8:   .db $54                     ; 1CED8:  54
b07_8ed9:   brk                         ; 1CED9:  00
b07_8eda:   eor ($03),y                 ; 1CEDA:  51 03
b07_8edc:   tax                         ; 1CEDC:  aa
b07_8edd:   brk                         ; 1CEDD:  00
b07_8ede:   tax                         ; 1CEDE:  aa
b07_8edf:   brk                         ; 1CEDF:  00
b07_8ee0:   lda #$03                    ; 1CEE0:  a9 03
b07_8ee2:   ldx $0c                     ; 1CEE2:  a6 0c
b07_8ee4:   .db $43                     ; 1CEE4:  43
b07_8ee5:   .db $07                     ; 1CEE5:  07
b07_8ee6:   .db $47                     ; 1CEE6:  47
b07_8ee7:   .db $07                     ; 1CEE7:  07
b07_8ee8:   .db $47                     ; 1CEE8:  47
b07_8ee9:   .db $03                     ; 1CEE9:  03
b07_8eea:   .db $0f                     ; 1CEEA:  0f
b07_8eeb:   .db $0f                     ; 1CEEB:  0f
b07_8eec:   ldy $9808                   ; 1CEEC:  ac 08 98
b07_8eef:   clc                         ; 1CEEF:  18
b07_8ef0:   tya                         ; 1CEF0:  98
b07_8ef1:   .db $3c                     ; 1CEF1:  3c
b07_8ef2:   bcs $8f24                   ; 1CEF2:  b0 30
b07_8ef4:   eor $00,x                   ; 1CEF4:  55 00
b07_8ef6:   brk                         ; 1CEF6:  00
b07_8ef7:   .db $0f                     ; 1CEF7:  0f
b07_8ef8:   .db $3f                     ; 1CEF8:  3f
b07_8ef9:   .db $ff                     ; 1CEF9:  ff
b07_8efa:   .db $ff                     ; 1CEFA:  ff
b07_8efb:   .db $ff                     ; 1CEFB:  ff
b07_8efc:   tax                         ; 1CEFC:  aa
b07_8efd:   brk                         ; 1CEFD:  00
b07_8efe:   .db $80                     ; 1CEFE:  80
b07_8eff:   bvs $8ec1                   ; 1CEFF:  70 c0
b07_8f01:   brk                         ; 1CF01:  00
b07_8f02:   brk                         ; 1CF02:  00
b07_8f03:   brk                         ; 1CF03:  00
b07_8f04:   bvc $8f06                   ; 1CF04:  50 00
b07_8f06:   brk                         ; 1CF06:  00
b07_8f07:   .db $fc                     ; 1CF07:  fc
b07_8f08:   .db $ff                     ; 1CF08:  ff
b07_8f09:   .db $ff                     ; 1CF09:  ff
b07_8f0a:   .db $ff                     ; 1CF0A:  ff
b07_8f0b:   .db $ff                     ; 1CF0B:  ff
b07_8f0c:   tay                         ; 1CF0C:  a8
b07_8f0d:   brk                         ; 1CF0D:  00
b07_8f0e:   brk                         ; 1CF0E:  00
b07_8f0f:   brk                         ; 1CF0F:  00
b07_8f10:   brk                         ; 1CF10:  00
b07_8f11:   brk                         ; 1CF11:  00
b07_8f12:   brk                         ; 1CF12:  00
b07_8f13:   brk                         ; 1CF13:  00
b07_8f14:   .db $ff                     ; 1CF14:  ff
b07_8f15:   .db $ff                     ; 1CF15:  ff
b07_8f16:   .db $ff                     ; 1CF16:  ff
b07_8f17:   .db $ff                     ; 1CF17:  ff
b07_8f18:   .db $f7                     ; 1CF18:  f7
b07_8f19:   .db $ef                     ; 1CF19:  ef
b07_8f1a:   .db $ff                     ; 1CF1A:  ff
b07_8f1b:   .db $ff                     ; 1CF1B:  ff
b07_8f1c:   brk                         ; 1CF1C:  00
b07_8f1d:   brk                         ; 1CF1D:  00
b07_8f1e:   brk                         ; 1CF1E:  00
b07_8f1f:   brk                         ; 1CF1F:  00
b07_8f20:   php                         ; 1CF20:  08
b07_8f21:   bpl $8f23                   ; 1CF21:  10 00
b07_8f23:   brk                         ; 1CF23:  00
b07_8f24:   .db $ff                     ; 1CF24:  ff
b07_8f25:   .db $ff                     ; 1CF25:  ff
b07_8f26:   .db $ff                     ; 1CF26:  ff
b07_8f27:   .db $ff                     ; 1CF27:  ff
b07_8f28:   .db $ff                     ; 1CF28:  ff
b07_8f29:   .db $ff                     ; 1CF29:  ff
b07_8f2a:   .db $ff                     ; 1CF2A:  ff
b07_8f2b:   .db $ff                     ; 1CF2B:  ff
b07_8f2c:   brk                         ; 1CF2C:  00
b07_8f2d:   brk                         ; 1CF2D:  00
b07_8f2e:   brk                         ; 1CF2E:  00
b07_8f2f:   brk                         ; 1CF2F:  00
b07_8f30:   brk                         ; 1CF30:  00
b07_8f31:   brk                         ; 1CF31:  00
b07_8f32:   brk                         ; 1CF32:  00
b07_8f33:   brk                         ; 1CF33:  00
b07_8f34:   ora $00,x                   ; 1CF34:  15 00
b07_8f36:   ora $00,x                   ; 1CF36:  15 00
b07_8f38:   eor $80,x                   ; 1CF38:  55 80
b07_8f3a:   cmp $e0,x                   ; 1CF3A:  d5 e0
b07_8f3c:   rol a                       ; 1CF3C:  2a
b07_8f3d:   brk                         ; 1CF3D:  00
b07_8f3e:   rol a                       ; 1CF3E:  2a
b07_8f3f:   brk                         ; 1CF3F:  00
b07_8f40:   rol a                       ; 1CF40:  2a
b07_8f41:   brk                         ; 1CF41:  00
b07_8f42:   rol a                       ; 1CF42:  2a
b07_8f43:   brk                         ; 1CF43:  00
b07_8f44:   sbc $e0                     ; 1CF44:  e5 e0
b07_8f46:   cmp $c0                     ; 1CF46:  c5 c0
b07_8f48:   sta ($80,x)                 ; 1CF48:  81 80
b07_8f4a:   ora ($00,x)                 ; 1CF4A:  01 00
b07_8f4c:   asl a                       ; 1CF4C:  0a
b07_8f4d:   brk                         ; 1CF4D:  00
b07_8f4e:   .db $02                     ; 1CF4E:  02
b07_8f4f:   brk                         ; 1CF4F:  00
b07_8f50:   .db $02                     ; 1CF50:  02
b07_8f51:   brk                         ; 1CF51:  00
b07_8f52:   .db $02                     ; 1CF52:  02
b07_8f53:   brk                         ; 1CF53:  00
b07_8f54:   .db $0f                     ; 1CF54:  0f
b07_8f55:   ora ($40,x)                 ; 1CF55:  01 40
b07_8f57:   asl $41                     ; 1CF57:  06 41
b07_8f59:   .db $02                     ; 1CF59:  02
b07_8f5a:   lsr $b006                   ; 1CF5A:  4e 06 b0
b07_8f5d:   plp                         ; 1CF5D:  28
b07_8f5e:   .db $9c                     ; 1CF5E:  9c
b07_8f5f:   ora $1290,y                 ; 1CF5F:  19 90 12
b07_8f62:   sta ($39),y                 ; 1CF62:  91 39
b07_8f64:   brk                         ; 1CF64:  00
b07_8f65:   .db $0c                     ; 1CF65:  0c
b07_8f66:   .db $0c                     ; 1CF66:  0c
b07_8f67:   .db $0c                     ; 1CF67:  0c
b07_8f68:   jmp $440c                   ; 1CF68:  4c 0c 44
b07_8f6b:   brk                         ; 1CF6B:  00
b07_8f6c:   .db $bf                     ; 1CF6C:  bf
b07_8f6d:   .db $33                     ; 1CF6D:  33
b07_8f6e:   .db $b2                     ; 1CF6E:  b2
b07_8f6f:   .db $32                     ; 1CF6F:  32
b07_8f70:   .db $92                     ; 1CF70:  92
b07_8f71:   .db $13                     ; 1CF71:  13
b07_8f72:   .db $9b                     ; 1CF72:  9b
b07_8f73:   .db $1f                     ; 1CF73:  1f
b07_8f74:   .db $df                     ; 1CF74:  df
b07_8f75:   iny                         ; 1CF75:  c8
b07_8f76:   cpx #$61                    ; 1CF76:  e0 61
b07_8f78:   rts                         ; 1CF78:  60
b07_8f79:   bvs $8fec                   ; 1CF79:  70 71
b07_8f7b:   adc $2020,x                 ; 1CF7B:  7d 20 20
b07_8f7e:   ora ($1e),y                 ; 1CF7E:  11 1e
b07_8f80:   tya                         ; 1CF80:  98
b07_8f81:   .db $0c                     ; 1CF81:  0c
b07_8f82:   stx $fe02                   ; 1CF82:  8e 02 fe
b07_8f85:   .db $5f                     ; 1CF85:  5f
b07_8f86:   .db $ef                     ; 1CF86:  ef
b07_8f87:   .db $ff                     ; 1CF87:  ff
b07_8f88:   .db $7f                     ; 1CF88:  7f
b07_8f89:   .db $9f                     ; 1CF89:  9f
b07_8f8a:   .db $ff                     ; 1CF8A:  ff
b07_8f8b:   .db $ff                     ; 1CF8B:  ff
b07_8f8c:   brk                         ; 1CF8C:  00
b07_8f8d:   brk                         ; 1CF8D:  00
b07_8f8e:   brk                         ; 1CF8E:  00
b07_8f8f:   brk                         ; 1CF8F:  00
b07_8f90:   brk                         ; 1CF90:  00
b07_8f91:   .db $80                     ; 1CF91:  80
b07_8f92:   brk                         ; 1CF92:  00
b07_8f93:   brk                         ; 1CF93:  00
b07_8f94:   ror $f3e7,x                 ; 1CF94:  7e e7 f3
b07_8f97:   .db $f3                     ; 1CF97:  f3
b07_8f98:   cmp $0d                     ; 1CF98:  c5 0d
b07_8f9a:   asl $813e,x                 ; 1CF9A:  1e 3e 81
b07_8f9d:   clc                         ; 1CF9D:  18
b07_8f9e:   .db $0c                     ; 1CF9E:  0c
b07_8f9f:   .db $04                     ; 1CF9F:  04
b07_8fa0:   .db $02                     ; 1CFA0:  02
b07_8fa1:   .db $12                     ; 1CFA1:  12
b07_8fa2:   lda ($c1,x)                 ; 1CFA2:  a1 c1
b07_8fa4:   .db $ff                     ; 1CFA4:  ff
b07_8fa5:   .db $ff                     ; 1CFA5:  ff
b07_8fa6:   sbc $f3f9,x                 ; 1CFA6:  fd f9 f3
b07_8fa9:   .db $e7                     ; 1CFA9:  e7
b07_8faa:   .db $ef                     ; 1CFAA:  ef
b07_8fab:   .db $ef                     ; 1CFAB:  ef
b07_8fac:   brk                         ; 1CFAC:  00
b07_8fad:   brk                         ; 1CFAD:  00
b07_8fae:   .db $02                     ; 1CFAE:  02
b07_8faf:   asl $0c                     ; 1CFAF:  06 0c
b07_8fb1:   clc                         ; 1CFB1:  18
b07_8fb2:   bpl $8fc4                   ; 1CFB2:  10 10
b07_8fb4:   ora ($80,x)                 ; 1CFB4:  01 80
b07_8fb6:   sta ($80,x)                 ; 1CFB6:  81 80
b07_8fb8:   sta ($9c,x)                 ; 1CFB8:  81 9c
b07_8fba:   lda $c4                     ; 1CFBA:  a5 c4
b07_8fbc:   .db $02                     ; 1CFBC:  02
b07_8fbd:   brk                         ; 1CFBD:  00
b07_8fbe:   .db $02                     ; 1CFBE:  02
b07_8fbf:   brk                         ; 1CFBF:  00
b07_8fc0:   .db $02                     ; 1CFC0:  02
b07_8fc1:   brk                         ; 1CFC1:  00
b07_8fc2:   brk                         ; 1CFC2:  00
b07_8fc3:   bpl $8f52                   ; 1CFC3:  10 8d
b07_8fc5:   cpy $98c9                   ; 1CFC5:  cc c9 98
b07_8fc8:   sbc $80,x                   ; 1CFC8:  f5 80
b07_8fca:   cmp $c0,x                   ; 1CFCA:  d5 c0
b07_8fcc:   rti                         ; 1CFCC:  40
b07_8fcd:   jsr $6002                   ; 1CFCD:  20 02 60
b07_8fd0:   .db $02                     ; 1CFD0:  02
b07_8fd1:   brk                         ; 1CFD1:  00
b07_8fd2:   rol a                       ; 1CFD2:  2a
b07_8fd3:   rti                         ; 1CFD3:  40
b07_8fd4:   eor $00,x                   ; 1CFD4:  55 00
b07_8fd6:   eor $00,x                   ; 1CFD6:  55 00
b07_8fd8:   eor $00,x                   ; 1CFD8:  55 00
b07_8fda:   .db $54                     ; 1CFDA:  54
b07_8fdb:   brk                         ; 1CFDB:  00
b07_8fdc:   tax                         ; 1CFDC:  aa
b07_8fdd:   brk                         ; 1CFDD:  00
b07_8fde:   tax                         ; 1CFDE:  aa
b07_8fdf:   brk                         ; 1CFDF:  00
b07_8fe0:   tax                         ; 1CFE0:  aa
b07_8fe1:   brk                         ; 1CFE1:  00
b07_8fe2:   tay                         ; 1CFE2:  a8
b07_8fe3:   ora ($40,x)                 ; 1CFE3:  01 40
b07_8fe5:   brk                         ; 1CFE5:  00
b07_8fe6:   rti                         ; 1CFE6:  40
b07_8fe7:   brk                         ; 1CFE7:  00
b07_8fe8:   bvc $8fea                   ; 1CFE8:  50 00
b07_8fea:   php                         ; 1CFEA:  08
b07_8feb:   jsr $0faf                   ; 1CFEB:  20 af 0f
b07_8fee:   .db $af                     ; 1CFEE:  af
b07_8fef:   .db $0f                     ; 1CFEF:  0f
b07_8ff0:   .db $a7                     ; 1CFF0:  a7
b07_8ff1:   .db $03                     ; 1CFF1:  03
b07_8ff2:   ora $10                     ; 1CFF2:  05 10
b07_8ff4:   plp                         ; 1CFF4:  28
b07_8ff5:   rol a                       ; 1CFF5:  2a
b07_8ff6:   tax                         ; 1CFF6:  aa
b07_8ff7:   tax                         ; 1CFF7:  aa
b07_8ff8:   tax                         ; 1CFF8:  aa
b07_8ff9:   tax                         ; 1CFF9:  aa
b07_8ffa:   tax                         ; 1CFFA:  aa
b07_8ffb:   tax                         ; 1CFFB:  aa
b07_8ffc:   sty $11                     ; 1CFFC:  84 11
b07_8ffe:   .db $44                     ; 1CFFE:  44
b07_8fff:   ora ($44),y                 ; 1CFFF:  11 44
b07_9001:   ora ($44),y                 ; 1D001:  11 44
b07_9003:   ora ($88),y                 ; 1D003:  11 88
b07_9005:   jsr $a288                   ; 1D005:  20 88 a2
b07_9008:   tay                         ; 1D008:  a8
b07_9009:   ldx #$aa                    ; 1D009:  a2 aa
b07_900b:   tax                         ; 1D00B:  aa
b07_900c:   .db $44                     ; 1D00C:  44
b07_900d:   ora ($40),y                 ; 1D00D:  11 40
b07_900f:   ora ($40),y                 ; 1D00F:  11 40
b07_9011:   ora ($40),y                 ; 1D011:  11 40
b07_9013:   ora ($7f),y                 ; 1D013:  11 7f
b07_9015:   .db $47                     ; 1D015:  47
b07_9016:   sbc $0f0f,y                 ; 1D016:  f9 0f 0f
b07_9019:   .db $3f                     ; 1D019:  3f
b07_901a:   .db $7f                     ; 1D01A:  7f
b07_901b:   .db $7f                     ; 1D01B:  7f
b07_901c:   .db $80                     ; 1D01C:  80
b07_901d:   brk                         ; 1D01D:  00
b07_901e:   brk                         ; 1D01E:  00
b07_901f:   .db $80                     ; 1D01F:  80
b07_9020:   cpx #$c0                    ; 1D020:  e0 c0
b07_9022:   .db $80                     ; 1D022:  80
b07_9023:   .db $80                     ; 1D023:  80
b07_9024:   .db $7f                     ; 1D024:  7f
b07_9025:   .db $7f                     ; 1D025:  7f
b07_9026:   .db $7f                     ; 1D026:  7f
b07_9027:   inc $fbfd,x                 ; 1D027:  fe fd fb
b07_902a:   .db $e7                     ; 1D02A:  e7
b07_902b:   .db $8f                     ; 1D02B:  8f
b07_902c:   .db $80                     ; 1D02C:  80
b07_902d:   .db $80                     ; 1D02D:  80
b07_902e:   .db $80                     ; 1D02E:  80
b07_902f:   brk                         ; 1D02F:  00
b07_9030:   brk                         ; 1D030:  00
b07_9031:   brk                         ; 1D031:  00
b07_9032:   ora ($03,x)                 ; 1D032:  01 03
b07_9034:   rol $8000,x                 ; 1D034:  3e 00 80
b07_9037:   eor ($a3,x)                 ; 1D037:  41 a3
b07_9039:   .db $e7                     ; 1D039:  e7
b07_903a:   .db $e3                     ; 1D03A:  e3
b07_903b:   .db $b3                     ; 1D03B:  b3
b07_903c:   cpy #$00                    ; 1D03C:  c0 00
b07_903e:   ora ($6e,x)                 ; 1D03E:  01 6e
b07_9040:   .db $34                     ; 1D040:  34
b07_9041:   sei                         ; 1D041:  78
b07_9042:   .db $7c                     ; 1D042:  7c
b07_9043:   .db $3c                     ; 1D043:  3c
b07_9044:   .db $1f                     ; 1D044:  1f
b07_9045:   rol $fe7e,x                 ; 1D045:  3e 7e fe
b07_9048:   inc $fafa,x                 ; 1D048:  fe fa fa
b07_904b:   nop                         ; 1D04B:  ea
b07_904c:   .db $23                     ; 1D04C:  23
b07_904d:   .db $47                     ; 1D04D:  47
b07_904e:   stx $1c0d                   ; 1D04E:  8e 0d 1c
b07_9051:   and $f174,y                 ; 1D051:  39 74 f1
b07_9054:   cmp $40,x                   ; 1D054:  d5 40
b07_9056:   sbc $e0                     ; 1D056:  e5 e0
b07_9058:   sbc $a8                     ; 1D058:  e5 a8
b07_905a:   tax                         ; 1D05A:  aa
b07_905b:   tax                         ; 1D05B:  aa
b07_905c:   lsr a                       ; 1D05C:  4a
b07_905d:   rti                         ; 1D05D:  40
b07_905e:   lsr a                       ; 1D05E:  4a
b07_905f:   cpy #$c2                    ; 1D05F:  c0 c2
b07_9061:   bcc $9023                   ; 1D061:  90 c0
b07_9063:   ora ($55),y                 ; 1D063:  11 55
b07_9065:   brk                         ; 1D065:  00
b07_9066:   eor $00,x                   ; 1D066:  55 00
b07_9068:   eor $00,x                   ; 1D068:  55 00
b07_906a:   ora $a0                     ; 1D06A:  05 a0
b07_906c:   tax                         ; 1D06C:  aa
b07_906d:   brk                         ; 1D06D:  00
b07_906e:   tax                         ; 1D06E:  aa
b07_906f:   brk                         ; 1D06F:  00
b07_9070:   tax                         ; 1D070:  aa
b07_9071:   brk                         ; 1D071:  00
b07_9072:   asl a                       ; 1D072:  0a
b07_9073:   bpl $901f                   ; 1D073:  10 aa
b07_9075:   tax                         ; 1D075:  aa
b07_9076:   tax                         ; 1D076:  aa
b07_9077:   ldx #$a2                    ; 1D077:  a2 a2
b07_9079:   ldx #$aa                    ; 1D079:  a2 aa
b07_907b:   tax                         ; 1D07B:  aa
b07_907c:   rti                         ; 1D07C:  40
b07_907d:   ora ($40),y                 ; 1D07D:  11 40
b07_907f:   ora ($44),y                 ; 1D07F:  11 44
b07_9081:   ora ($44),y                 ; 1D081:  11 44
b07_9083:   ora ($aa,x)                 ; 1D083:  01 aa
b07_9085:   tax                         ; 1D085:  aa
b07_9086:   tax                         ; 1D086:  aa
b07_9087:   tax                         ; 1D087:  aa
b07_9088:   tax                         ; 1D088:  aa
b07_9089:   tax                         ; 1D089:  aa
b07_908a:   tax                         ; 1D08A:  aa
b07_908b:   tax                         ; 1D08B:  aa
b07_908c:   .db $44                     ; 1D08C:  44
b07_908d:   ora ($44),y                 ; 1D08D:  11 44
b07_908f:   ora ($44),y                 ; 1D08F:  11 44
b07_9091:   ora ($44),y                 ; 1D091:  11 44
b07_9093:   ora ($22),y                 ; 1D093:  11 22
b07_9095:   bpl $9017                   ; 1D095:  10 80
b07_9097:   rti                         ; 1D097:  40
b07_9098:   .db $22                     ; 1D098:  22
b07_9099:   ora ($88),y                 ; 1D099:  11 88
b07_909b:   .db $44                     ; 1D09B:  44
b07_909c:   tax                         ; 1D09C:  aa
b07_909d:   .db $74                     ; 1D09D:  74
b07_909e:   .db $b2                     ; 1D09E:  b2
b07_909f:   cld                         ; 1D09F:  d8
b07_90a0:   tax                         ; 1D0A0:  aa
b07_90a1:   .db $77                     ; 1D0A1:  77
b07_90a2:   tsx                         ; 1D0A2:  ba
b07_90a3:   cmp $2800,x                 ; 1D0A3:  dd 00 28
b07_90a6:   brk                         ; 1D0A6:  00
b07_90a7:   brk                         ; 1D0A7:  00
b07_90a8:   brk                         ; 1D0A8:  00
b07_90a9:   brk                         ; 1D0A9:  00
b07_90aa:   .db $80                     ; 1D0AA:  80
b07_90ab:   php                         ; 1D0AB:  08
b07_90ac:   brk                         ; 1D0AC:  00
b07_90ad:   brk                         ; 1D0AD:  00
b07_90ae:   .db $80                     ; 1D0AE:  80
b07_90af:   brk                         ; 1D0AF:  00
b07_90b0:   brk                         ; 1D0B0:  00
b07_90b1:   brk                         ; 1D0B1:  00
b07_90b2:   ldy #$90                    ; 1D0B2:  a0 90
b07_90b4:   .db $22                     ; 1D0B4:  22
b07_90b5:   ora ($88),y                 ; 1D0B5:  11 88
b07_90b7:   .db $44                     ; 1D0B7:  44
b07_90b8:   .db $22                     ; 1D0B8:  22
b07_90b9:   bpl $9043                   ; 1D0B9:  10 88
b07_90bb:   .db $44                     ; 1D0BB:  44
b07_90bc:   tax                         ; 1D0BC:  aa
b07_90bd:   .db $77                     ; 1D0BD:  77
b07_90be:   tsx                         ; 1D0BE:  ba
b07_90bf:   cmp $76aa,x                 ; 1D0BF:  dd aa 76
b07_90c2:   tsx                         ; 1D0C2:  ba
b07_90c3:   .db $dc                     ; 1D0C3:  dc
b07_90c4:   ora $00                     ; 1D0C4:  05 00
b07_90c6:   brk                         ; 1D0C6:  00
b07_90c7:   brk                         ; 1D0C7:  00
b07_90c8:   brk                         ; 1D0C8:  00
b07_90c9:   brk                         ; 1D0C9:  00
b07_90ca:   brk                         ; 1D0CA:  00
b07_90cb:   ora ($82,x)                 ; 1D0CB:  01 82
b07_90cd:   brk                         ; 1D0CD:  00
b07_90ce:   brk                         ; 1D0CE:  00
b07_90cf:   brk                         ; 1D0CF:  00
b07_90d0:   brk                         ; 1D0D0:  00
b07_90d1:   brk                         ; 1D0D1:  00
b07_90d2:   brk                         ; 1D0D2:  00
b07_90d3:   ora ($20,x)                 ; 1D0D3:  01 20
b07_90d5:   jsr $4020                   ; 1D0D5:  20 20 40
b07_90d8:   rti                         ; 1D0D8:  40
b07_90d9:   rti                         ; 1D0D9:  40
b07_90da:   rti                         ; 1D0DA:  40
b07_90db:   rti                         ; 1D0DB:  40
b07_90dc:   .db $02                     ; 1D0DC:  02
b07_90dd:   jsr $0002                   ; 1D0DD:  20 02 00
b07_90e0:   .db $42                     ; 1D0E0:  42
b07_90e1:   brk                         ; 1D0E1:  00
b07_90e2:   .db $42                     ; 1D0E2:  42
b07_90e3:   brk                         ; 1D0E3:  00
b07_90e4:   .db $22                     ; 1D0E4:  22
b07_90e5:   dey                         ; 1D0E5:  88
b07_90e6:   .db $22                     ; 1D0E6:  22
b07_90e7:   dey                         ; 1D0E7:  88
b07_90e8:   .db $22                     ; 1D0E8:  22
b07_90e9:   dey                         ; 1D0E9:  88
b07_90ea:   .db $22                     ; 1D0EA:  22
b07_90eb:   dey                         ; 1D0EB:  88
b07_90ec:   .db $22                     ; 1D0EC:  22
b07_90ed:   php                         ; 1D0ED:  08
b07_90ee:   .db $22                     ; 1D0EE:  22
b07_90ef:   php                         ; 1D0EF:  08
b07_90f0:   .db $22                     ; 1D0F0:  22
b07_90f1:   php                         ; 1D0F1:  08
b07_90f2:   .db $22                     ; 1D0F2:  22
b07_90f3:   php                         ; 1D0F3:  08
b07_90f4:   brk                         ; 1D0F4:  00
b07_90f5:   .db $ff                     ; 1D0F5:  ff
b07_90f6:   brk                         ; 1D0F6:  00
b07_90f7:   rti                         ; 1D0F7:  40
b07_90f8:   .db $03                     ; 1D0F8:  03
b07_90f9:   .db $87                     ; 1D0F9:  87
b07_90fa:   .db $07                     ; 1D0FA:  07
b07_90fb:   .db $07                     ; 1D0FB:  07
b07_90fc:   brk                         ; 1D0FC:  00
b07_90fd:   .db $1f                     ; 1D0FD:  1f
b07_90fe:   brk                         ; 1D0FE:  00
b07_90ff:   .db $5f                     ; 1D0FF:  5f
b07_9100:   .db $1c                     ; 1D100:  1c
b07_9101:   clv                         ; 1D101:  b8
b07_9102:   sec                         ; 1D102:  38
b07_9103:   sei                         ; 1D103:  78
b07_9104:   brk                         ; 1D104:  00
b07_9105:   .db $ff                     ; 1D105:  ff
b07_9106:   brk                         ; 1D106:  00
b07_9107:   .db $ff                     ; 1D107:  ff
b07_9108:   .db $ff                     ; 1D108:  ff
b07_9109:   .db $ff                     ; 1D109:  ff
b07_910a:   .db $ff                     ; 1D10A:  ff
b07_910b:   .db $ff                     ; 1D10B:  ff
b07_910c:   brk                         ; 1D10C:  00
b07_910d:   .db $ff                     ; 1D10D:  ff
b07_910e:   brk                         ; 1D10E:  00
b07_910f:   brk                         ; 1D10F:  00
b07_9110:   brk                         ; 1D110:  00
b07_9111:   brk                         ; 1D111:  00
b07_9112:   brk                         ; 1D112:  00
b07_9113:   brk                         ; 1D113:  00
b07_9114:   .db $12                     ; 1D114:  12
b07_9115:   .db $89                     ; 1D115:  89
b07_9116:   plp                         ; 1D116:  28
b07_9117:   dey                         ; 1D117:  88
b07_9118:   bit $85                     ; 1D118:  24 85
b07_911a:   bit $80                     ; 1D11A:  24 80
b07_911c:   asl $8b,x                   ; 1D11C:  16 8b
b07_911e:   .db $2b                     ; 1D11E:  2b
b07_911f:   .db $89                     ; 1D11F:  89
b07_9120:   bit $85                     ; 1D120:  24 85
b07_9122:   and $81                     ; 1D122:  25 81
b07_9124:   .db $22                     ; 1D124:  22
b07_9125:   ora ($88),y                 ; 1D125:  11 88
b07_9127:   .db $44                     ; 1D127:  44
b07_9128:   .db $22                     ; 1D128:  22
b07_9129:   ora ($88),y                 ; 1D129:  11 88
b07_912b:   .db $44                     ; 1D12B:  44
b07_912c:   tax                         ; 1D12C:  aa
b07_912d:   .db $77                     ; 1D12D:  77
b07_912e:   .db $bb                     ; 1D12E:  bb
b07_912f:   cmp $77aa,x                 ; 1D12F:  dd aa 77
b07_9132:   .db $bb                     ; 1D132:  bb
b07_9133:   cmp $c138,x                 ; 1D133:  dd 38 c1
b07_9136:   sec                         ; 1D136:  38
b07_9137:   .db $fc                     ; 1D137:  fc
b07_9138:   .db $fc                     ; 1D138:  fc
b07_9139:   inc $f8fe,x                 ; 1D139:  fe fe f8
b07_913c:   .db $34                     ; 1D13C:  34
b07_913d:   cmp ($00,x)                 ; 1D13D:  c1 00
b07_913f:   ora ($00,x)                 ; 1D13F:  01 00
b07_9141:   brk                         ; 1D141:  00
b07_9142:   brk                         ; 1D142:  00
b07_9143:   brk                         ; 1D143:  00
b07_9144:   jsr $8810                   ; 1D144:  20 10 88
b07_9147:   rti                         ; 1D147:  40
b07_9148:   jsr $8010                   ; 1D148:  20 10 80
b07_914b:   rti                         ; 1D14B:  40
b07_914c:   tay                         ; 1D14C:  a8
b07_914d:   .db $74                     ; 1D14D:  74
b07_914e:   clv                         ; 1D14E:  b8
b07_914f:   cld                         ; 1D14F:  d8
b07_9150:   tay                         ; 1D150:  a8
b07_9151:   bvs $9103                   ; 1D151:  70 b0
b07_9153:   cpy #$00                    ; 1D153:  c0 00
b07_9155:   ora ($00,x)                 ; 1D155:  01 00
b07_9157:   ora ($00,x)                 ; 1D157:  01 00
b07_9159:   ora ($00,x)                 ; 1D159:  01 00
b07_915b:   .db $02                     ; 1D15B:  02
b07_915c:   brk                         ; 1D15C:  00
b07_915d:   ora ($00,x)                 ; 1D15D:  01 00
b07_915f:   ora ($00,x)                 ; 1D15F:  01 00
b07_9161:   ora ($00,x)                 ; 1D161:  01 00
b07_9163:   .db $02                     ; 1D163:  02
b07_9164:   jsr $8000                   ; 1D164:  20 00 80
b07_9167:   rti                         ; 1D167:  40
b07_9168:   brk                         ; 1D168:  00
b07_9169:   brk                         ; 1D169:  00
b07_916a:   .db $80                     ; 1D16A:  80
b07_916b:   brk                         ; 1D16B:  00
b07_916c:   ldy #$60                    ; 1D16C:  a0 60
b07_916e:   .db $80                     ; 1D16E:  80
b07_916f:   cpy #$81                    ; 1D16F:  c0 81
b07_9171:   brk                         ; 1D171:  00
b07_9172:   .db $82                     ; 1D172:  82
b07_9173:   brk                         ; 1D173:  00
b07_9174:   brk                         ; 1D174:  00
b07_9175:   .db $02                     ; 1D175:  02
b07_9176:   brk                         ; 1D176:  00
b07_9177:   .db $02                     ; 1D177:  02
b07_9178:   brk                         ; 1D178:  00
b07_9179:   .db $12                     ; 1D179:  12
b07_917a:   brk                         ; 1D17A:  00
b07_917b:   .db $12                     ; 1D17B:  12
b07_917c:   brk                         ; 1D17C:  00
b07_917d:   .db $82                     ; 1D17D:  82
b07_917e:   brk                         ; 1D17E:  00
b07_917f:   .db $02                     ; 1D17F:  02
b07_9180:   brk                         ; 1D180:  00
b07_9181:   .db $02                     ; 1D181:  02
b07_9182:   brk                         ; 1D182:  00
b07_9183:   .db $02                     ; 1D183:  02
b07_9184:   .db $04                     ; 1D184:  04
b07_9185:   brk                         ; 1D185:  00
b07_9186:   asl $0f                     ; 1D186:  06 0f
b07_9188:   brk                         ; 1D188:  00
b07_9189:   ora ($03,x)                 ; 1D189:  01 03
b07_918b:   .db $03                     ; 1D18B:  03
b07_918c:   bvs $91f6                   ; 1D18C:  70 68
b07_918e:   adc $7870,y                 ; 1D18E:  79 70 78
b07_9191:   adc $fc7c,x                 ; 1D191:  7d 7c fc
b07_9194:   .db $7f                     ; 1D194:  7f
b07_9195:   ora $0103,x                 ; 1D195:  1d 03 01
b07_9198:   .db $03                     ; 1D198:  03
b07_9199:   .db $27                     ; 1D199:  27
b07_919a:   .db $e7                     ; 1D19A:  e7
b07_919b:   .db $cf                     ; 1D19B:  cf
b07_919c:   brk                         ; 1D19C:  00
b07_919d:   brk                         ; 1D19D:  00
b07_919e:   .db $80                     ; 1D19E:  80
b07_919f:   inc $2804                   ; 1D19F:  ee 04 28
b07_91a2:   clc                         ; 1D1A2:  18
b07_91a3:   bmi $91a8                   ; 1D1A3:  30 03
b07_91a5:   .db $07                     ; 1D1A5:  07
b07_91a6:   .db $07                     ; 1D1A6:  07
b07_91a7:   .db $07                     ; 1D1A7:  07
b07_91a8:   .db $07                     ; 1D1A8:  07
b07_91a9:   .db $03                     ; 1D1A9:  03
b07_91aa:   ora ($01,x)                 ; 1D1AA:  01 01
b07_91ac:   .db $fc                     ; 1D1AC:  fc
b07_91ad:   sei                         ; 1D1AD:  78
b07_91ae:   sed                         ; 1D1AE:  f8
b07_91af:   sei                         ; 1D1AF:  78
b07_91b0:   sei                         ; 1D1B0:  78
b07_91b1:   .db $3c                     ; 1D1B1:  3c
b07_91b2:   lsr $9f2e,x                 ; 1D1B2:  5e 2e 9f
b07_91b5:   .db $ff                     ; 1D1B5:  ff
b07_91b6:   .db $ff                     ; 1D1B6:  ff
b07_91b7:   sbc $f0fb,x                 ; 1D1B7:  fd fb f0
b07_91ba:   .db $f4                     ; 1D1BA:  f4
b07_91bb:   cpx $60                     ; 1D1BB:  e4 60
b07_91bd:   brk                         ; 1D1BD:  00
b07_91be:   brk                         ; 1D1BE:  00
b07_91bf:   brk                         ; 1D1BF:  00
b07_91c0:   .db $04                     ; 1D1C0:  04
b07_91c1:   .db $0c                     ; 1D1C1:  0c
b07_91c2:   .db $0b                     ; 1D1C2:  0b
b07_91c3:   ora ($f2),y                 ; 1D1C3:  11 f2
b07_91c5:   dec $c6                     ; 1D1C5:  c6 c6
b07_91c7:   .db $82                     ; 1D1C7:  82
b07_91c8:   ldx $9f                     ; 1D1C8:  a6 9f
b07_91ca:   .db $8f                     ; 1D1CA:  8f
b07_91cb:   .db $ff                     ; 1D1CB:  ff
b07_91cc:   brk                         ; 1D1CC:  00
b07_91cd:   brk                         ; 1D1CD:  00
b07_91ce:   clc                         ; 1D1CE:  18
b07_91cf:   brk                         ; 1D1CF:  00
b07_91d0:   bit $20                     ; 1D1D0:  24 20
b07_91d2:   bmi $91d4                   ; 1D1D2:  30 00
b07_91d4:   .db $22                     ; 1D1D4:  22
b07_91d5:   ora ($88),y                 ; 1D1D5:  11 88
b07_91d7:   .db $44                     ; 1D1D7:  44
b07_91d8:   .db $22                     ; 1D1D8:  22
b07_91d9:   ora ($88),y                 ; 1D1D9:  11 88
b07_91db:   .db $44                     ; 1D1DB:  44
b07_91dc:   tax                         ; 1D1DC:  aa
b07_91dd:   .db $77                     ; 1D1DD:  77
b07_91de:   .db $bb                     ; 1D1DE:  bb
b07_91df:   cmp $77aa,x                 ; 1D1DF:  dd aa 77
b07_91e2:   .db $bb                     ; 1D1E2:  bb
b07_91e3:   eor $dfff,x                 ; 1D1E3:  5d ff df
b07_91e6:   .db $df                     ; 1D1E6:  df
b07_91e7:   .db $df                     ; 1D1E7:  df
b07_91e8:   .db $ef                     ; 1D1E8:  ef
b07_91e9:   .db $ef                     ; 1D1E9:  ef
b07_91ea:   asl $0004                   ; 1D1EA:  0e 04 00
b07_91ed:   brk                         ; 1D1ED:  00
b07_91ee:   brk                         ; 1D1EE:  00
b07_91ef:   brk                         ; 1D1EF:  00
b07_91f0:   brk                         ; 1D1F0:  00
b07_91f1:   brk                         ; 1D1F1:  00
b07_91f2:   brk                         ; 1D1F2:  00
b07_91f3:   rti                         ; 1D1F3:  40
b07_91f4:   .db $22                     ; 1D1F4:  22
b07_91f5:   ora ($08),y                 ; 1D1F5:  11 08
b07_91f7:   .db $44                     ; 1D1F7:  44
b07_91f8:   .db $22                     ; 1D1F8:  22
b07_91f9:   ora ($08),y                 ; 1D1F9:  11 08
b07_91fb:   .db $04                     ; 1D1FB:  04
b07_91fc:   rol a                       ; 1D1FC:  2a
b07_91fd:   .db $77                     ; 1D1FD:  77
b07_91fe:   .db $3b                     ; 1D1FE:  3b
b07_91ff:   eor $372a,x                 ; 1D1FF:  5d 2a 37
b07_9202:   .db $3b                     ; 1D202:  3b
b07_9203:   ora $0000,x                 ; 1D203:  1d 00 00
b07_9206:   brk                         ; 1D206:  00
b07_9207:   brk                         ; 1D207:  00
b07_9208:   brk                         ; 1D208:  00
b07_9209:   brk                         ; 1D209:  00
b07_920a:   .db $80                     ; 1D20A:  80
b07_920b:   brk                         ; 1D20B:  00
b07_920c:   .db $02                     ; 1D20C:  02
b07_920d:   .db $04                     ; 1D20D:  04
b07_920e:   brk                         ; 1D20E:  00
b07_920f:   sty $c8                     ; 1D20F:  84 c8
b07_9211:   rts                         ; 1D211:  60
b07_9212:   tay                         ; 1D212:  a8
b07_9213:   .db $80                     ; 1D213:  80
b07_9214:   brk                         ; 1D214:  00
b07_9215:   .db $22                     ; 1D215:  22
b07_9216:   brk                         ; 1D216:  00
b07_9217:   .db $22                     ; 1D217:  22
b07_9218:   brk                         ; 1D218:  00
b07_9219:   .db $22                     ; 1D219:  22
b07_921a:   brk                         ; 1D21A:  00
b07_921b:   .db $42                     ; 1D21B:  42
b07_921c:   brk                         ; 1D21C:  00
b07_921d:   .db $02                     ; 1D21D:  02
b07_921e:   brk                         ; 1D21E:  00
b07_921f:   .db $02                     ; 1D21F:  02
b07_9220:   brk                         ; 1D220:  00
b07_9221:   .db $02                     ; 1D221:  02
b07_9222:   brk                         ; 1D222:  00
b07_9223:   .db $02                     ; 1D223:  02
b07_9224:   brk                         ; 1D224:  00
b07_9225:   brk                         ; 1D225:  00
b07_9226:   brk                         ; 1D226:  00
b07_9227:   brk                         ; 1D227:  00
b07_9228:   rti                         ; 1D228:  40
b07_9229:   brk                         ; 1D229:  00
b07_922a:   .db $44                     ; 1D22A:  44
b07_922b:   ora ($20,x)                 ; 1D22B:  01 20
b07_922d:   iny                         ; 1D22D:  c8
b07_922e:   jsr $61cc                   ; 1D22E:  20 cc 61
b07_9231:   cpy $cd75                   ; 1D231:  cc 75 cd
b07_9234:   .db $04                     ; 1D234:  04
b07_9235:   rti                         ; 1D235:  40
b07_9236:   .db $04                     ; 1D236:  04
b07_9237:   brk                         ; 1D237:  00
b07_9238:   .db $04                     ; 1D238:  04
b07_9239:   ora ($04,x)                 ; 1D239:  01 04
b07_923b:   ora ($04),y                 ; 1D23B:  11 04
b07_923d:   brk                         ; 1D23D:  00
b07_923e:   .db $04                     ; 1D23E:  04
b07_923f:   .db $80                     ; 1D23F:  80
b07_9240:   and $81                     ; 1D240:  25 81
b07_9242:   and $99,x                   ; 1D242:  35 99
b07_9244:   ora ($01,x)                 ; 1D244:  01 01
b07_9246:   ora ($00,x)                 ; 1D246:  01 00
b07_9248:   .db $80                     ; 1D248:  80
b07_9249:   cpy #$60                    ; 1D249:  c0 60
b07_924b:   bcs $925b                   ; 1D24B:  b0 0e
b07_924d:   asl $08                     ; 1D24D:  06 08
b07_924f:   .db $44                     ; 1D24F:  44
b07_9250:   cpy #$e0                    ; 1D250:  c0 e0
b07_9252:   bvs $920d                   ; 1D252:  70 b9
b07_9254:   cpy #$c0                    ; 1D254:  c0 c0
b07_9256:   .db $83                     ; 1D256:  83
b07_9257:   stx $04                     ; 1D257:  86 04
b07_9259:   asl a                       ; 1D259:  0a
b07_925a:   .db $04                     ; 1D25A:  04
b07_925b:   brk                         ; 1D25B:  00
b07_925c:   brk                         ; 1D25C:  00
b07_925d:   brk                         ; 1D25D:  00
b07_925e:   brk                         ; 1D25E:  00
b07_925f:   brk                         ; 1D25F:  00
b07_9260:   .db $02                     ; 1D260:  02
b07_9261:   brk                         ; 1D261:  00
b07_9262:   brk                         ; 1D262:  00
b07_9263:   brk                         ; 1D263:  00
b07_9264:   clc                         ; 1D264:  18
b07_9265:   sty $8b26                   ; 1D265:  8c 26 8b
b07_9268:   and ($08,x)                 ; 1D268:  21 08
b07_926a:   .db $22                     ; 1D26A:  22
b07_926b:   php                         ; 1D26B:  08
b07_926c:   asl $278f,x                 ; 1D26C:  1e 8f 27
b07_926f:   .db $8b                     ; 1D26F:  8b
b07_9270:   and ($08,x)                 ; 1D270:  21 08
b07_9272:   .db $22                     ; 1D272:  22
b07_9273:   dey                         ; 1D273:  88
b07_9274:   brk                         ; 1D274:  00
b07_9275:   brk                         ; 1D275:  00
b07_9276:   brk                         ; 1D276:  00
b07_9277:   jsr $ffbf                   ; 1D277:  20 bf ff
b07_927a:   .db $7f                     ; 1D27A:  7f
b07_927b:   .db $9f                     ; 1D27B:  9f
b07_927c:   brk                         ; 1D27C:  00
b07_927d:   ldy #$c4                    ; 1D27D:  a0 c4
b07_927f:   dex                         ; 1D27F:  ca
b07_9280:   cpy #$e0                    ; 1D280:  c0 e0
b07_9282:   sei                         ; 1D282:  78
b07_9283:   .db $9e                     ; 1D283:  9e
b07_9284:   .db $44                     ; 1D284:  44
b07_9285:   .db $80                     ; 1D285:  80
b07_9286:   beq $92b8                   ; 1D286:  f0 30
b07_9288:   jsr $0000                   ; 1D288:  20 00 00
b07_928b:   brk                         ; 1D28B:  00
b07_928c:   .db $80                     ; 1D28C:  80
b07_928d:   brk                         ; 1D28D:  00
b07_928e:   brk                         ; 1D28E:  00
b07_928f:   brk                         ; 1D28F:  00
b07_9290:   sta ($00,x)                 ; 1D290:  81 00
b07_9292:   brk                         ; 1D292:  00
b07_9293:   brk                         ; 1D293:  00
b07_9294:   .db $02                     ; 1D294:  02
b07_9295:   ora ($08),y                 ; 1D295:  11 08
b07_9297:   .db $04                     ; 1D297:  04
b07_9298:   .db $02                     ; 1D298:  02
b07_9299:   ora ($00,x)                 ; 1D299:  01 00
b07_929b:   brk                         ; 1D29B:  00
b07_929c:   asl a                       ; 1D29C:  0a
b07_929d:   .db $17                     ; 1D29D:  17
b07_929e:   .db $1b                     ; 1D29E:  1b
b07_929f:   ora $070a,x                 ; 1D29F:  1d 0a 07
b07_92a2:   .db $03                     ; 1D2A2:  03
b07_92a3:   cpy $080a                   ; 1D2A3:  cc 0a 08
b07_92a6:   asl a                       ; 1D2A6:  0a
b07_92a7:   clv                         ; 1D2A7:  b8
b07_92a8:   .db $da                     ; 1D2A8:  da
b07_92a9:   beq $925d                   ; 1D2A9:  f0 b2
b07_92ab:   pla                         ; 1D2AB:  68
b07_92ac:   asl a                       ; 1D2AC:  0a
b07_92ad:   php                         ; 1D2AD:  08
b07_92ae:   lsr a                       ; 1D2AE:  4a
b07_92af:   clc                         ; 1D2AF:  18
b07_92b0:   .db $1a                     ; 1D2B0:  1a
b07_92b1:   bmi $92e5                   ; 1D2B1:  30 32
b07_92b3:   pla                         ; 1D2B3:  68
b07_92b4:   .db $44                     ; 1D2B4:  44
b07_92b5:   ora ($04),y                 ; 1D2B5:  11 04
b07_92b7:   sta ($00),y                 ; 1D2B7:  91 00
b07_92b9:   sta ($00),y                 ; 1D2B9:  91 00
b07_92bb:   sta ($67),y                 ; 1D2BB:  91 67
b07_92bd:   eor $37,x                   ; 1D2BD:  55 37
b07_92bf:   sta $33,x                   ; 1D2BF:  95 33
b07_92c1:   sta $9913,y                 ; 1D2C1:  99 13 99
b07_92c4:   brk                         ; 1D2C4:  00
b07_92c5:   tax                         ; 1D2C5:  aa
b07_92c6:   brk                         ; 1D2C6:  00
b07_92c7:   tax                         ; 1D2C7:  aa
b07_92c8:   brk                         ; 1D2C8:  00
b07_92c9:   tax                         ; 1D2C9:  aa
b07_92ca:   brk                         ; 1D2CA:  00
b07_92cb:   tax                         ; 1D2CB:  aa
b07_92cc:   dey                         ; 1D2CC:  88
b07_92cd:   cmp $7722,x                 ; 1D2CD:  dd 22 77
b07_92d0:   dey                         ; 1D2D0:  88
b07_92d1:   cmp $7722,x                 ; 1D2D1:  dd 22 77
b07_92d4:   brk                         ; 1D2D4:  00
b07_92d5:   tax                         ; 1D2D5:  aa
b07_92d6:   brk                         ; 1D2D6:  00
b07_92d7:   tax                         ; 1D2D7:  aa
b07_92d8:   brk                         ; 1D2D8:  00
b07_92d9:   tax                         ; 1D2D9:  aa
b07_92da:   brk                         ; 1D2DA:  00
b07_92db:   tay                         ; 1D2DB:  a8
b07_92dc:   dey                         ; 1D2DC:  88
b07_92dd:   cmp $7722,x                 ; 1D2DD:  dd 22 77
b07_92e0:   dey                         ; 1D2E0:  88
b07_92e1:   cmp $7422,x                 ; 1D2E1:  dd 22 74
b07_92e4:   brk                         ; 1D2E4:  00
b07_92e5:   tay                         ; 1D2E5:  a8
b07_92e6:   brk                         ; 1D2E6:  00
b07_92e7:   ldy #$00                    ; 1D2E7:  a0 00
b07_92e9:   ldy #$00                    ; 1D2E9:  a0 00
b07_92eb:   ldy #$88                    ; 1D2EB:  a0 88
b07_92ed:   cld                         ; 1D2ED:  d8
b07_92ee:   jsr $8171                   ; 1D2EE:  20 71 81
b07_92f1:   cmp ($23),y                 ; 1D2F1:  d1 23
b07_92f3:   .db $73                     ; 1D2F3:  73
b07_92f4:   brk                         ; 1D2F4:  00
b07_92f5:   tax                         ; 1D2F5:  aa
b07_92f6:   brk                         ; 1D2F6:  00
b07_92f7:   tay                         ; 1D2F7:  a8
b07_92f8:   brk                         ; 1D2F8:  00
b07_92f9:   .db $80                     ; 1D2F9:  80
b07_92fa:   brk                         ; 1D2FA:  00
b07_92fb:   brk                         ; 1D2FB:  00
b07_92fc:   dey                         ; 1D2FC:  88
b07_92fd:   .db $dc                     ; 1D2FD:  dc
b07_92fe:   .db $22                     ; 1D2FE:  22
b07_92ff:   bvs $9281                   ; 1D2FF:  70 80
b07_9301:   .db $80                     ; 1D301:  80
b07_9302:   brk                         ; 1D302:  00
b07_9303:   brk                         ; 1D303:  00
b07_9304:   brk                         ; 1D304:  00
b07_9305:   .db $02                     ; 1D305:  02
b07_9306:   brk                         ; 1D306:  00
b07_9307:   brk                         ; 1D307:  00
b07_9308:   brk                         ; 1D308:  00
b07_9309:   brk                         ; 1D309:  00
b07_930a:   brk                         ; 1D30A:  00
b07_930b:   brk                         ; 1D30B:  00
b07_930c:   php                         ; 1D30C:  08
b07_930d:   ora $02                     ; 1D30D:  05 02
b07_930f:   ora ($00,x)                 ; 1D30F:  01 00
b07_9311:   brk                         ; 1D311:  00
b07_9312:   brk                         ; 1D312:  00
b07_9313:   brk                         ; 1D313:  00
b07_9314:   brk                         ; 1D314:  00
b07_9315:   sec                         ; 1D315:  38
b07_9316:   .db $3c                     ; 1D316:  3c
b07_9317:   .db $7f                     ; 1D317:  7f
b07_9318:   .db $7f                     ; 1D318:  7f
b07_9319:   .db $7f                     ; 1D319:  7f
b07_931a:   .db $7f                     ; 1D31A:  7f
b07_931b:   .db $7f                     ; 1D31B:  7f
b07_931c:   brk                         ; 1D31C:  00
b07_931d:   cpy #$40                    ; 1D31D:  c0 40
b07_931f:   .db $80                     ; 1D31F:  80
b07_9320:   .db $80                     ; 1D320:  80
b07_9321:   .db $80                     ; 1D321:  80
b07_9322:   .db $80                     ; 1D322:  80
b07_9323:   .db $80                     ; 1D323:  80
b07_9324:   brk                         ; 1D324:  00
b07_9325:   .db $0f                     ; 1D325:  0f
b07_9326:   .db $7f                     ; 1D326:  7f
b07_9327:   .db $ff                     ; 1D327:  ff
b07_9328:   .db $ff                     ; 1D328:  ff
b07_9329:   .db $ff                     ; 1D329:  ff
b07_932a:   .db $ff                     ; 1D32A:  ff
b07_932b:   .db $ff                     ; 1D32B:  ff
b07_932c:   brk                         ; 1D32C:  00
b07_932d:   brk                         ; 1D32D:  00
b07_932e:   brk                         ; 1D32E:  00
b07_932f:   brk                         ; 1D32F:  00
b07_9330:   brk                         ; 1D330:  00
b07_9331:   brk                         ; 1D331:  00
b07_9332:   brk                         ; 1D332:  00
b07_9333:   brk                         ; 1D333:  00
b07_9334:   brk                         ; 1D334:  00
b07_9335:   tax                         ; 1D335:  aa
b07_9336:   brk                         ; 1D336:  00
b07_9337:   tax                         ; 1D337:  aa
b07_9338:   brk                         ; 1D338:  00
b07_9339:   asl a                       ; 1D339:  0a
b07_933a:   brk                         ; 1D33A:  00
b07_933b:   .db $02                     ; 1D33B:  02
b07_933c:   dey                         ; 1D33C:  88
b07_933d:   cmp $7722,x                 ; 1D33D:  dd 22 77
b07_9340:   php                         ; 1D340:  08
b07_9341:   ora $0702,x                 ; 1D341:  1d 02 07
b07_9344:   brk                         ; 1D344:  00
b07_9345:   .db $82                     ; 1D345:  82
b07_9346:   .db $80                     ; 1D346:  80
b07_9347:   cpx #$f0                    ; 1D347:  e0 f0
b07_9349:   beq $933b                   ; 1D349:  f0 f0
b07_934b:   beq $934d                   ; 1D34B:  f0 00
b07_934d:   ora ($02,x)                 ; 1D34D:  01 02
b07_934f:   ora ($00,x)                 ; 1D34F:  01 00
b07_9351:   ora ($00,x)                 ; 1D351:  01 00
b07_9353:   ora ($00,x)                 ; 1D353:  01 00
b07_9355:   ldy #$01                    ; 1D355:  a0 01
b07_9357:   lda ($08,x)                 ; 1D357:  a1 08
b07_9359:   lda ($01,x)                 ; 1D359:  a1 01
b07_935b:   lda ($82,x)                 ; 1D35B:  a1 82
b07_935d:   .db $d3                     ; 1D35D:  d3
b07_935e:   .db $22                     ; 1D35E:  22
b07_935f:   .db $72                     ; 1D35F:  72
b07_9360:   .db $82                     ; 1D360:  82
b07_9361:   .db $c2                     ; 1D361:  c2
b07_9362:   .db $22                     ; 1D362:  22
b07_9363:   .db $62                     ; 1D363:  62
b07_9364:   ora #$a1                    ; 1D364:  09 a1
b07_9366:   ora $a8                     ; 1D366:  05 a8
b07_9368:   brk                         ; 1D368:  00
b07_9369:   tay                         ; 1D369:  a8
b07_936a:   brk                         ; 1D36A:  00
b07_936b:   tay                         ; 1D36B:  a8
b07_936c:   stx $d2                     ; 1D36C:  86 d2
b07_936e:   .db $22                     ; 1D36E:  22
b07_936f:   .db $73                     ; 1D36F:  73
b07_9370:   .db $8b                     ; 1D370:  8b
b07_9371:   cmp $7521,x                 ; 1D371:  dd 21 75
b07_9374:   .db $0f                     ; 1D374:  0f
b07_9375:   .db $e7                     ; 1D375:  e7
b07_9376:   .db $e7                     ; 1D376:  e7
b07_9377:   .db $83                     ; 1D377:  83
b07_9378:   .db $23                     ; 1D378:  23
b07_9379:   .db $c7                     ; 1D379:  c7
b07_937a:   sbc $80f9,x                 ; 1D37A:  fd f9 80
b07_937d:   brk                         ; 1D37D:  00
b07_937e:   clc                         ; 1D37E:  18
b07_937f:   .db $0c                     ; 1D37F:  0c
b07_9380:   bit $c8                     ; 1D380:  24 c8
b07_9382:   .db $02                     ; 1D382:  02
b07_9383:   .db $04                     ; 1D383:  04
b07_9384:   cpx #$c7                    ; 1D384:  e0 c7
b07_9386:   .db $cf                     ; 1D386:  cf
b07_9387:   cmp ($ca,x)                 ; 1D387:  c1 ca
b07_9389:   cpx $ffff                   ; 1D389:  ec ff ff
b07_938c:   brk                         ; 1D38C:  00
b07_938d:   php                         ; 1D38D:  08
b07_938e:   bmi $93c0                   ; 1D38E:  30 30
b07_9390:   rol a                       ; 1D390:  2a
b07_9391:   .db $1c                     ; 1D391:  1c
b07_9392:   brk                         ; 1D392:  00
b07_9393:   brk                         ; 1D393:  00
b07_9394:   .db $fb                     ; 1D394:  fb
b07_9395:   .db $f3                     ; 1D395:  f3
b07_9396:   beq $9388                   ; 1D396:  f0 f0
b07_9398:   sbc $f1ff,y                 ; 1D398:  f9 ff f1
b07_939b:   .db $77                     ; 1D39B:  77
b07_939c:   .db $04                     ; 1D39C:  04
b07_939d:   php                         ; 1D39D:  08
b07_939e:   ora #$0d                    ; 1D39E:  09 0d
b07_93a0:   asl $00                     ; 1D3A0:  06 00
b07_93a2:   brk                         ; 1D3A2:  00
b07_93a3:   .db $80                     ; 1D3A3:  80
b07_93a4:   .db $ff                     ; 1D3A4:  ff
b07_93a5:   .db $ff                     ; 1D3A5:  ff
b07_93a6:   .db $3f                     ; 1D3A6:  3f
b07_93a7:   .db $7f                     ; 1D3A7:  7f
b07_93a8:   .db $ff                     ; 1D3A8:  ff
b07_93a9:   .db $ff                     ; 1D3A9:  ff
b07_93aa:   .db $0f                     ; 1D3AA:  0f
b07_93ab:   .db $e7                     ; 1D3AB:  e7
b07_93ac:   brk                         ; 1D3AC:  00
b07_93ad:   brk                         ; 1D3AD:  00
b07_93ae:   brk                         ; 1D3AE:  00
b07_93af:   .db $80                     ; 1D3AF:  80
b07_93b0:   brk                         ; 1D3B0:  00
b07_93b1:   brk                         ; 1D3B1:  00
b07_93b2:   brk                         ; 1D3B2:  00
b07_93b3:   brk                         ; 1D3B3:  00
b07_93b4:   ldy #$e0                    ; 1D3B4:  a0 e0
b07_93b6:   cpx #$e0                    ; 1D3B6:  e0 e0
b07_93b8:   ror $ea                     ; 1D3B8:  66 ea
b07_93ba:   .db $e2                     ; 1D3BA:  e2
b07_93bb:   .db $e2                     ; 1D3BB:  e2
b07_93bc:   brk                         ; 1D3BC:  00
b07_93bd:   ora ($00,x)                 ; 1D3BD:  01 00
b07_93bf:   ora ($00,x)                 ; 1D3BF:  01 00
b07_93c1:   brk                         ; 1D3C1:  00
b07_93c2:   bpl $93dc                   ; 1D3C2:  10 18
b07_93c4:   cpx $fc                     ; 1D3C4:  e4 fc
b07_93c6:   sed                         ; 1D3C6:  f8
b07_93c7:   .db $e2                     ; 1D3C7:  e2
b07_93c8:   cpx #$ea                    ; 1D3C8:  e0 ea
b07_93ca:   cpy #$ca                    ; 1D3CA:  c0 ca
b07_93cc:   bpl $93cf                   ; 1D3CC:  10 01
b07_93ce:   .db $02                     ; 1D3CE:  02
b07_93cf:   .db $07                     ; 1D3CF:  07
b07_93d0:   brk                         ; 1D3D0:  00
b07_93d1:   ora $1702                   ; 1D3D1:  0d 02 17
b07_93d4:   brk                         ; 1D3D4:  00
b07_93d5:   tax                         ; 1D3D5:  aa
b07_93d6:   brk                         ; 1D3D6:  00
b07_93d7:   tax                         ; 1D3D7:  aa
b07_93d8:   brk                         ; 1D3D8:  00
b07_93d9:   tax                         ; 1D3D9:  aa
b07_93da:   brk                         ; 1D3DA:  00
b07_93db:   ldy #$88                    ; 1D3DB:  a0 88
b07_93dd:   .db $dc                     ; 1D3DD:  dc
b07_93de:   .db $22                     ; 1D3DE:  22
b07_93df:   .db $77                     ; 1D3DF:  77
b07_93e0:   dey                         ; 1D3E0:  88
b07_93e1:   cmp $7020,x                 ; 1D3E1:  dd 20 70
b07_93e4:   brk                         ; 1D3E4:  00
b07_93e5:   tax                         ; 1D3E5:  aa
b07_93e6:   brk                         ; 1D3E6:  00
b07_93e7:   ldx #$0d                    ; 1D3E7:  a2 0d
b07_93e9:   .db $97                     ; 1D3E9:  97
b07_93ea:   ora $88b7,x                 ; 1D3EA:  1d b7 88
b07_93ed:   cmp $7220,x                 ; 1D3ED:  dd 20 72
b07_93f0:   sta $1dd7                   ; 1D3F0:  8d d7 1d
b07_93f3:   .db $37                     ; 1D3F3:  37
b07_93f4:   ora #$22                    ; 1D3F4:  09 22
b07_93f6:   sta $9166,y                 ; 1D3F6:  99 66 91
b07_93f9:   .db $67                     ; 1D3F9:  67
b07_93fa:   cmp ($77),y                 ; 1D3FA:  d1 77
b07_93fc:   .db $89                     ; 1D3FC:  89
b07_93fd:   .db $22                     ; 1D3FD:  22
b07_93fe:   sta $9166,y                 ; 1D3FE:  99 66 91
b07_9401:   .db $67                     ; 1D401:  67
b07_9402:   cmp ($77),y                 ; 1D402:  d1 77
b07_9404:   .db $7c                     ; 1D404:  7c
b07_9405:   .db $3c                     ; 1D405:  3c
b07_9406:   .db $3f                     ; 1D406:  3f
b07_9407:   .db $9f                     ; 1D407:  9f
b07_9408:   .db $07                     ; 1D408:  07
b07_9409:   jsr $1090                   ; 1D409:  20 90 10
b07_940c:   .db $80                     ; 1D40C:  80
b07_940d:   .db $c3                     ; 1D40D:  c3
b07_940e:   rti                         ; 1D40E:  40
b07_940f:   jsr $2798                   ; 1D40F:  20 98 27
b07_9412:   bcc $9430                   ; 1D412:  90 1c
b07_9414:   .db $7f                     ; 1D414:  7f
b07_9415:   .db $3f                     ; 1D415:  3f
b07_9416:   .db $ff                     ; 1D416:  ff
b07_9417:   inc $03f9,x                 ; 1D417:  fe f9 03
b07_941a:   .db $07                     ; 1D41A:  07
b07_941b:   asl $c000                   ; 1D41B:  0e 00 c0
b07_941e:   brk                         ; 1D41E:  00
b07_941f:   brk                         ; 1D41F:  00
b07_9420:   brk                         ; 1D420:  00
b07_9421:   sbc ($09,x)                 ; 1D421:  e1 09
b07_9423:   .db $32                     ; 1D423:  32
b07_9424:   dey                         ; 1D424:  88
b07_9425:   .db $0f                     ; 1D425:  0f
b07_9426:   .db $87                     ; 1D426:  87
b07_9427:   .db $07                     ; 1D427:  07
b07_9428:   .db $a3                     ; 1D428:  a3
b07_9429:   ora ($a8),y                 ; 1D429:  11 a8
b07_942b:   .db $14                     ; 1D42B:  14
b07_942c:   .db $af                     ; 1D42C:  af
b07_942d:   plp                         ; 1D42D:  28
b07_942e:   sty $16,x                   ; 1D42E:  94 16
b07_9430:   .db $8b                     ; 1D430:  8b
b07_9431:   and $92                     ; 1D431:  25 92
b07_9433:   and #$3e                    ; 1D433:  29 3e
b07_9435:   .db $fc                     ; 1D435:  fc
b07_9436:   sed                         ; 1D436:  f8
b07_9437:   beq $941b                   ; 1D437:  f0 e2
b07_9439:   cpy $8a                     ; 1D439:  c4 8a
b07_943b:   .db $14                     ; 1D43B:  14
b07_943c:   dec $0d                     ; 1D43C:  c6 0d
b07_943e:   .db $1a                     ; 1D43E:  1a
b07_943f:   and $68,x                   ; 1D43F:  35 68
b07_9441:   .db $d2                     ; 1D441:  d2
b07_9442:   ldy $4a                     ; 1D442:  a4 4a
b07_9444:   .db $80                     ; 1D444:  80
b07_9445:   txa                         ; 1D445:  8a
b07_9446:   brk                         ; 1D446:  00
b07_9447:   tax                         ; 1D447:  aa
b07_9448:   .db $80                     ; 1D448:  80
b07_9449:   .db $32                     ; 1D449:  32
b07_944a:   sec                         ; 1D44A:  38
b07_944b:   .db $32                     ; 1D44B:  32
b07_944c:   php                         ; 1D44C:  08
b07_944d:   ora $a702,x                 ; 1D44D:  1d 02 a7
b07_9450:   dey                         ; 1D450:  88
b07_9451:   and $38,x                   ; 1D451:  35 38
b07_9453:   .db $b2                     ; 1D453:  b2
b07_9454:   brk                         ; 1D454:  00
b07_9455:   tax                         ; 1D455:  aa
b07_9456:   brk                         ; 1D456:  00
b07_9457:   tax                         ; 1D457:  aa
b07_9458:   brk                         ; 1D458:  00
b07_9459:   tax                         ; 1D459:  aa
b07_945a:   brk                         ; 1D45A:  00
b07_945b:   rol a                       ; 1D45B:  2a
b07_945c:   dey                         ; 1D45C:  88
b07_945d:   cmp $7722,x                 ; 1D45D:  dd 22 77
b07_9460:   dey                         ; 1D460:  88
b07_9461:   cmp $7722,x                 ; 1D461:  dd 22 77
b07_9464:   adc $597b,y                 ; 1D464:  79 7b 59
b07_9467:   .db $7b                     ; 1D467:  7b
b07_9468:   cmp $d973,y                 ; 1D468:  d9 73 d9
b07_946b:   .db $73                     ; 1D46B:  73
b07_946c:   adc $597b,y                 ; 1D46C:  79 7b 59
b07_946f:   .db $7b                     ; 1D46F:  7b
b07_9470:   cmp $d973,y                 ; 1D470:  d9 73 d9
b07_9473:   .db $73                     ; 1D473:  73
b07_9474:   .db $80                     ; 1D474:  80
b07_9475:   .db $62                     ; 1D475:  62
b07_9476:   cld                         ; 1D476:  d8
b07_9477:   inc $7fff,x                 ; 1D477:  fe ff 7f
b07_947a:   cmp $8877,x                 ; 1D47A:  dd 77 88
b07_947d:   adc $d8                     ; 1D47D:  65 d8
b07_947f:   inc $7fff,x                 ; 1D47F:  fe ff 7f
b07_9482:   cmp $0077,x                 ; 1D482:  dd 77 00
b07_9485:   brk                         ; 1D485:  00
b07_9486:   brk                         ; 1D486:  00
b07_9487:   brk                         ; 1D487:  00
b07_9488:   brk                         ; 1D488:  00
b07_9489:   brk                         ; 1D489:  00
b07_948a:   brk                         ; 1D48A:  00
b07_948b:   brk                         ; 1D48B:  00
b07_948c:   .db $22                     ; 1D48C:  22
b07_948d:   dey                         ; 1D48D:  88
b07_948e:   .db $22                     ; 1D48E:  22
b07_948f:   dey                         ; 1D48F:  88
b07_9490:   .db $22                     ; 1D490:  22
b07_9491:   dey                         ; 1D491:  88
b07_9492:   .db $22                     ; 1D492:  22
b07_9493:   dey                         ; 1D493:  88
b07_9494:   brk                         ; 1D494:  00
b07_9495:   brk                         ; 1D495:  00
b07_9496:   brk                         ; 1D496:  00
b07_9497:   brk                         ; 1D497:  00
b07_9498:   brk                         ; 1D498:  00
b07_9499:   ora ($03,x)                 ; 1D499:  01 03
b07_949b:   .db $07                     ; 1D49B:  07
b07_949c:   .db $22                     ; 1D49C:  22
b07_949d:   dey                         ; 1D49D:  88
b07_949e:   .db $22                     ; 1D49E:  22
b07_949f:   dey                         ; 1D49F:  88
b07_94a0:   .db $22                     ; 1D4A0:  22
b07_94a1:   dey                         ; 1D4A1:  88
b07_94a2:   jsr $0f80                   ; 1D4A2:  20 80 0f
b07_94a5:   .db $0f                     ; 1D4A5:  0f
b07_94a6:   asl $1c1e                   ; 1D4A6:  0e 1e 1c
b07_94a9:   .db $1c                     ; 1D4A9:  1c
b07_94aa:   sec                         ; 1D4AA:  38
b07_94ab:   bmi $94cd                   ; 1D4AB:  30 20
b07_94ad:   .db $80                     ; 1D4AD:  80
b07_94ae:   and ($81,x)                 ; 1D4AE:  21 81
b07_94b0:   .db $23                     ; 1D4B0:  23
b07_94b1:   .db $83                     ; 1D4B1:  83
b07_94b2:   .db $07                     ; 1D4B2:  07
b07_94b3:   .db $8f                     ; 1D4B3:  8f
b07_94b4:   brk                         ; 1D4B4:  00
b07_94b5:   brk                         ; 1D4B5:  00
b07_94b6:   brk                         ; 1D4B6:  00
b07_94b7:   .db $0f                     ; 1D4B7:  0f
b07_94b8:   .db $7c                     ; 1D4B8:  7c
b07_94b9:   cpx #$c0                    ; 1D4B9:  e0 c0
b07_94bb:   .db $80                     ; 1D4BB:  80
b07_94bc:   .db $22                     ; 1D4BC:  22
b07_94bd:   dey                         ; 1D4BD:  88
b07_94be:   .db $22                     ; 1D4BE:  22
b07_94bf:   .db $80                     ; 1D4BF:  80
b07_94c0:   .db $03                     ; 1D4C0:  03
b07_94c1:   .db $1f                     ; 1D4C1:  1f
b07_94c2:   .db $3f                     ; 1D4C2:  3f
b07_94c3:   .db $7f                     ; 1D4C3:  7f
b07_94c4:   brk                         ; 1D4C4:  00
b07_94c5:   brk                         ; 1D4C5:  00
b07_94c6:   brk                         ; 1D4C6:  00
b07_94c7:   inc $0001,x                 ; 1D4C7:  fe 01 00
b07_94ca:   brk                         ; 1D4CA:  00
b07_94cb:   brk                         ; 1D4CB:  00
b07_94cc:   jsr $2280                   ; 1D4CC:  20 80 22
b07_94cf:   brk                         ; 1D4CF:  00
b07_94d0:   inc $f0ff,x                 ; 1D4D0:  fe ff f0
b07_94d3:   .db $80                     ; 1D4D3:  80
b07_94d4:   brk                         ; 1D4D4:  00
b07_94d5:   brk                         ; 1D4D5:  00
b07_94d6:   brk                         ; 1D4D6:  00
b07_94d7:   brk                         ; 1D4D7:  00
b07_94d8:   brk                         ; 1D4D8:  00
b07_94d9:   brk                         ; 1D4D9:  00
b07_94da:   brk                         ; 1D4DA:  00
b07_94db:   rti                         ; 1D4DB:  40
b07_94dc:   inc $ffff,x                 ; 1D4DC:  fe ff ff
b07_94df:   .db $ff                     ; 1D4DF:  ff
b07_94e0:   .db $ff                     ; 1D4E0:  ff
b07_94e1:   .db $ff                     ; 1D4E1:  ff
b07_94e2:   .db $ff                     ; 1D4E2:  ff
b07_94e3:   lda ($00),y                 ; 1D4E3:  b1 00
b07_94e5:   brk                         ; 1D4E5:  00
b07_94e6:   brk                         ; 1D4E6:  00
b07_94e7:   brk                         ; 1D4E7:  00
b07_94e8:   brk                         ; 1D4E8:  00
b07_94e9:   brk                         ; 1D4E9:  00
b07_94ea:   brk                         ; 1D4EA:  00
b07_94eb:   brk                         ; 1D4EB:  00
b07_94ec:   brk                         ; 1D4EC:  00
b07_94ed:   cpx #$f0                    ; 1D4ED:  e0 f0
b07_94ef:   sed                         ; 1D4EF:  f8
b07_94f0:   sed                         ; 1D4F0:  f8
b07_94f1:   .db $fc                     ; 1D4F1:  fc
b07_94f2:   inc $20ff,x                 ; 1D4F2:  fe ff 20
b07_94f5:   sei                         ; 1D4F5:  78
b07_94f6:   sec                         ; 1D4F6:  38
b07_94f7:   .db $1c                     ; 1D4F7:  1c
b07_94f8:   cpy #$30                    ; 1D4F8:  c0 30
b07_94fa:   brk                         ; 1D4FA:  00
b07_94fb:   brk                         ; 1D4FB:  00
b07_94fc:   .db $22                     ; 1D4FC:  22
b07_94fd:   sei                         ; 1D4FD:  78
b07_94fe:   .db $3a                     ; 1D4FE:  3a
b07_94ff:   .db $1c                     ; 1D4FF:  1c
b07_9500:   brk                         ; 1D500:  00
b07_9501:   cpy #$00                    ; 1D501:  c0 00
b07_9503:   brk                         ; 1D503:  00
b07_9504:   brk                         ; 1D504:  00
b07_9505:   brk                         ; 1D505:  00
b07_9506:   brk                         ; 1D506:  00
b07_9507:   brk                         ; 1D507:  00
b07_9508:   brk                         ; 1D508:  00
b07_9509:   brk                         ; 1D509:  00
b07_950a:   brk                         ; 1D50A:  00
b07_950b:   brk                         ; 1D50B:  00
b07_950c:   brk                         ; 1D50C:  00
b07_950d:   brk                         ; 1D50D:  00
b07_950e:   brk                         ; 1D50E:  00
b07_950f:   brk                         ; 1D50F:  00
b07_9510:   brk                         ; 1D510:  00
b07_9511:   brk                         ; 1D511:  00
b07_9512:   brk                         ; 1D512:  00
b07_9513:   .db $80                     ; 1D513:  80
b07_9514:   brk                         ; 1D514:  00
b07_9515:   brk                         ; 1D515:  00
b07_9516:   brk                         ; 1D516:  00
b07_9517:   brk                         ; 1D517:  00
b07_9518:   brk                         ; 1D518:  00
b07_9519:   brk                         ; 1D519:  00
b07_951a:   brk                         ; 1D51A:  00
b07_951b:   brk                         ; 1D51B:  00
b07_951c:   .db $22                     ; 1D51C:  22
b07_951d:   dey                         ; 1D51D:  88
b07_951e:   .db $22                     ; 1D51E:  22
b07_951f:   php                         ; 1D51F:  08
b07_9520:   .db $22                     ; 1D520:  22
b07_9521:   php                         ; 1D521:  08
b07_9522:   .db $22                     ; 1D522:  22
b07_9523:   php                         ; 1D523:  08
b07_9524:   brk                         ; 1D524:  00
b07_9525:   jsr $3830                   ; 1D525:  20 30 38
b07_9528:   ora ($05,x)                 ; 1D528:  01 05
b07_952a:   .db $13                     ; 1D52A:  13
b07_952b:   .db $32                     ; 1D52B:  32
b07_952c:   .db $0f                     ; 1D52C:  0f
b07_952d:   .db $87                     ; 1D52D:  87
b07_952e:   .db $0b                     ; 1D52E:  0b
b07_952f:   .db $87                     ; 1D52F:  87
b07_9530:   .db $02                     ; 1D530:  02
b07_9531:   sty $2c                     ; 1D531:  84 2c
b07_9533:   sta $3022                   ; 1D533:  8d 22 30
b07_9536:   .db $34                     ; 1D536:  34
b07_9537:   .db $34                     ; 1D537:  34
b07_9538:   .db $14                     ; 1D538:  14
b07_9539:   clc                         ; 1D539:  18
b07_953a:   .db $1c                     ; 1D53A:  1c
b07_953b:   .db $1f                     ; 1D53B:  1f
b07_953c:   ora $038b,y                 ; 1D53C:  19 8b 03
b07_953f:   .db $83                     ; 1D53F:  83
b07_9540:   .db $22                     ; 1D540:  22
b07_9541:   .db $80                     ; 1D541:  80
b07_9542:   and ($80,x)                 ; 1D542:  21 80
b07_9544:   rti                         ; 1D544:  40
b07_9545:   brk                         ; 1D545:  00
b07_9546:   .db $0c                     ; 1D546:  0c
b07_9547:   .db $1c                     ; 1D547:  1c
b07_9548:   brk                         ; 1D548:  00
b07_9549:   .db $03                     ; 1D549:  03
b07_954a:   brk                         ; 1D54A:  00
b07_954b:   brk                         ; 1D54B:  00
b07_954c:   .db $87                     ; 1D54C:  87
b07_954d:   .db $9f                     ; 1D54D:  9f
b07_954e:   .db $f3                     ; 1D54E:  f3
b07_954f:   .db $e3                     ; 1D54F:  e3
b07_9550:   cpx #$f3                    ; 1D550:  e0 f3
b07_9552:   .db $ff                     ; 1D552:  ff
b07_9553:   .db $ff                     ; 1D553:  ff
b07_9554:   brk                         ; 1D554:  00
b07_9555:   brk                         ; 1D555:  00
b07_9556:   brk                         ; 1D556:  00
b07_9557:   brk                         ; 1D557:  00
b07_9558:   brk                         ; 1D558:  00
b07_9559:   brk                         ; 1D559:  00
b07_955a:   brk                         ; 1D55A:  00
b07_955b:   brk                         ; 1D55B:  00
b07_955c:   .db $7f                     ; 1D55C:  7f
b07_955d:   inc $ffff,x                 ; 1D55D:  fe ff ff
b07_9560:   .db $3f                     ; 1D560:  3f
b07_9561:   .db $7f                     ; 1D561:  7f
b07_9562:   .db $ff                     ; 1D562:  ff
b07_9563:   .db $ff                     ; 1D563:  ff
b07_9564:   clc                         ; 1D564:  18
b07_9565:   .db $1c                     ; 1D565:  1c
b07_9566:   .db $1c                     ; 1D566:  1c
b07_9567:   .db $1c                     ; 1D567:  1c
b07_9568:   .db $0c                     ; 1D568:  0c
b07_9569:   asl $02                     ; 1D569:  06 02
b07_956b:   brk                         ; 1D56B:  00
b07_956c:   .db $e7                     ; 1D56C:  e7
b07_956d:   .db $e3                     ; 1D56D:  e3
b07_956e:   .db $e3                     ; 1D56E:  e3
b07_956f:   .db $c3                     ; 1D56F:  c3
b07_9570:   .db $43                     ; 1D570:  43
b07_9571:   lda ($fd),y                 ; 1D571:  b1 fd
b07_9573:   .db $ff                     ; 1D573:  ff
b07_9574:   brk                         ; 1D574:  00
b07_9575:   brk                         ; 1D575:  00
b07_9576:   brk                         ; 1D576:  00
b07_9577:   brk                         ; 1D577:  00
b07_9578:   brk                         ; 1D578:  00
b07_9579:   brk                         ; 1D579:  00
b07_957a:   brk                         ; 1D57A:  00
b07_957b:   brk                         ; 1D57B:  00
b07_957c:   .db $ff                     ; 1D57C:  ff
b07_957d:   .db $ff                     ; 1D57D:  ff
b07_957e:   .db $ff                     ; 1D57E:  ff
b07_957f:   .db $ff                     ; 1D57F:  ff
b07_9580:   .db $ff                     ; 1D580:  ff
b07_9581:   .db $ff                     ; 1D581:  ff
b07_9582:   .db $ff                     ; 1D582:  ff
b07_9583:   .db $ff                     ; 1D583:  ff
b07_9584:   brk                         ; 1D584:  00
b07_9585:   brk                         ; 1D585:  00
b07_9586:   brk                         ; 1D586:  00
b07_9587:   brk                         ; 1D587:  00
b07_9588:   brk                         ; 1D588:  00
b07_9589:   brk                         ; 1D589:  00
b07_958a:   brk                         ; 1D58A:  00
b07_958b:   brk                         ; 1D58B:  00
b07_958c:   brk                         ; 1D58C:  00
b07_958d:   brk                         ; 1D58D:  00
b07_958e:   brk                         ; 1D58E:  00
b07_958f:   brk                         ; 1D58F:  00
b07_9590:   asl $ad92                   ; 1D590:  0e 92 ad
b07_9593:   sta ($00),y                 ; 1D593:  91 00
b07_9595:   brk                         ; 1D595:  00
b07_9596:   brk                         ; 1D596:  00
b07_9597:   brk                         ; 1D597:  00
b07_9598:   brk                         ; 1D598:  00
b07_9599:   brk                         ; 1D599:  00
b07_959a:   brk                         ; 1D59A:  00
b07_959b:   brk                         ; 1D59B:  00
b07_959c:   .db $22                     ; 1D59C:  22
b07_959d:   php                         ; 1D59D:  08
b07_959e:   .db $22                     ; 1D59E:  22
b07_959f:   dey                         ; 1D59F:  88
b07_95a0:   .db $22                     ; 1D5A0:  22
b07_95a1:   dey                         ; 1D5A1:  88
b07_95a2:   .db $22                     ; 1D5A2:  22
b07_95a3:   php                         ; 1D5A3:  08
b07_95a4:   brk                         ; 1D5A4:  00
b07_95a5:   brk                         ; 1D5A5:  00
b07_95a6:   brk                         ; 1D5A6:  00
b07_95a7:   brk                         ; 1D5A7:  00
b07_95a8:   brk                         ; 1D5A8:  00
b07_95a9:   brk                         ; 1D5A9:  00
b07_95aa:   brk                         ; 1D5AA:  00
b07_95ab:   brk                         ; 1D5AB:  00
b07_95ac:   .db $eb                     ; 1D5AC:  eb
b07_95ad:   .db $cf                     ; 1D5AD:  cf
b07_95ae:   dec $fc,x                   ; 1D5AE:  d6 fc
b07_95b0:   .db $fa                     ; 1D5B0:  fa
b07_95b1:   cpx #$d2                    ; 1D5B1:  e0 d2
b07_95b3:   cld                         ; 1D5B3:  d8
b07_95b4:   brk                         ; 1D5B4:  00
b07_95b5:   brk                         ; 1D5B5:  00
b07_95b6:   brk                         ; 1D5B6:  00
b07_95b7:   brk                         ; 1D5B7:  00
b07_95b8:   brk                         ; 1D5B8:  00
b07_95b9:   brk                         ; 1D5B9:  00
b07_95ba:   brk                         ; 1D5BA:  00
b07_95bb:   brk                         ; 1D5BB:  00
b07_95bc:   .db $22                     ; 1D5BC:  22
b07_95bd:   php                         ; 1D5BD:  08
b07_95be:   .db $22                     ; 1D5BE:  22
b07_95bf:   dey                         ; 1D5BF:  88
b07_95c0:   .db $22                     ; 1D5C0:  22
b07_95c1:   dey                         ; 1D5C1:  88
b07_95c2:   .db $22                     ; 1D5C2:  22
b07_95c3:   dey                         ; 1D5C3:  88
b07_95c4:   .db $0c                     ; 1D5C4:  0c
b07_95c5:   php                         ; 1D5C5:  08
b07_95c6:   .db $07                     ; 1D5C6:  07
b07_95c7:   .db $04                     ; 1D5C7:  04
b07_95c8:   .db $02                     ; 1D5C8:  02
b07_95c9:   .db $03                     ; 1D5C9:  03
b07_95ca:   .db $03                     ; 1D5CA:  03
b07_95cb:   ora ($23,x)                 ; 1D5CB:  01 23
b07_95cd:   .db $82                     ; 1D5CD:  82
b07_95ce:   jsr $2089                   ; 1D5CE:  20 89 20
b07_95d1:   dey                         ; 1D5D1:  88
b07_95d2:   jsr $0088                   ; 1D5D2:  20 88 00
b07_95d5:   brk                         ; 1D5D5:  00
b07_95d6:   brk                         ; 1D5D6:  00
b07_95d7:   brk                         ; 1D5D7:  00
b07_95d8:   brk                         ; 1D5D8:  00
b07_95d9:   .db $03                     ; 1D5D9:  03
b07_95da:   asl $221d                   ; 1D5DA:  0e 1d 22
b07_95dd:   dey                         ; 1D5DD:  88
b07_95de:   .db $22                     ; 1D5DE:  22
b07_95df:   dey                         ; 1D5DF:  88
b07_95e0:   jsr $2582                   ; 1D5E0:  20 82 25
b07_95e3:   txa                         ; 1D5E3:  8a
b07_95e4:   ora ($00,x)                 ; 1D5E4:  01 00
b07_95e6:   brk                         ; 1D5E6:  00
b07_95e7:   .db $03                     ; 1D5E7:  03
b07_95e8:   rol $bafc,x                 ; 1D5E8:  3e fc ba
b07_95eb:   .db $54                     ; 1D5EB:  54
b07_95ec:   .db $22                     ; 1D5EC:  22
b07_95ed:   dey                         ; 1D5ED:  88
b07_95ee:   jsr $1582                   ; 1D5EE:  20 82 15
b07_95f1:   tax                         ; 1D5F1:  aa
b07_95f2:   .db $54                     ; 1D5F2:  54
b07_95f3:   tax                         ; 1D5F3:  aa
b07_95f4:   brk                         ; 1D5F4:  00
b07_95f5:   brk                         ; 1D5F5:  00
b07_95f6:   cpy #$00                    ; 1D5F6:  c0 00
b07_95f8:   brk                         ; 1D5F8:  00
b07_95f9:   brk                         ; 1D5F9:  00
b07_95fa:   .db $80                     ; 1D5FA:  80
b07_95fb:   brk                         ; 1D5FB:  00
b07_95fc:   .db $ff                     ; 1D5FC:  ff
b07_95fd:   .db $1f                     ; 1D5FD:  1f
b07_95fe:   .db $27                     ; 1D5FE:  27
b07_95ff:   .db $f7                     ; 1D5FF:  f7
b07_9600:   .db $3f                     ; 1D600:  3f
b07_9601:   .db $ff                     ; 1D601:  ff
b07_9602:   .db $7f                     ; 1D602:  7f
b07_9603:   .db $ff                     ; 1D603:  ff
b07_9604:   brk                         ; 1D604:  00
b07_9605:   brk                         ; 1D605:  00
b07_9606:   brk                         ; 1D606:  00
b07_9607:   brk                         ; 1D607:  00
b07_9608:   brk                         ; 1D608:  00
b07_9609:   brk                         ; 1D609:  00
b07_960a:   brk                         ; 1D60A:  00
b07_960b:   brk                         ; 1D60B:  00
b07_960c:   .db $ff                     ; 1D60C:  ff
b07_960d:   .db $ff                     ; 1D60D:  ff
b07_960e:   .db $ff                     ; 1D60E:  ff
b07_960f:   .db $ff                     ; 1D60F:  ff
b07_9610:   inc $fbfd,x                 ; 1D610:  fe fd fb
b07_9613:   .db $e7                     ; 1D613:  e7
b07_9614:   brk                         ; 1D614:  00
b07_9615:   .db $80                     ; 1D615:  80
b07_9616:   brk                         ; 1D616:  00
b07_9617:   rti                         ; 1D617:  40
b07_9618:   pla                         ; 1D618:  68
b07_9619:   .db $d4                     ; 1D619:  d4
b07_961a:   .db $b7                     ; 1D61A:  b7
b07_961b:   .db $d7                     ; 1D61B:  d7
b07_961c:   .db $ff                     ; 1D61C:  ff
b07_961d:   sei                         ; 1D61D:  78
b07_961e:   brk                         ; 1D61E:  00
b07_961f:   and ($47,x)                 ; 1D61F:  21 47
b07_9621:   .db $b3                     ; 1D621:  b3
b07_9622:   bvc $95d4                   ; 1D622:  50 b0
b07_9624:   brk                         ; 1D624:  00
b07_9625:   brk                         ; 1D625:  00
b07_9626:   brk                         ; 1D626:  00
b07_9627:   brk                         ; 1D627:  00
b07_9628:   ora ($03,x)                 ; 1D628:  01 03
b07_962a:   .db $07                     ; 1D62A:  07
b07_962b:   asl $1f8f                   ; 1D62B:  0e 8f 1f
b07_962e:   .db $7f                     ; 1D62E:  7f
b07_962f:   .db $ff                     ; 1D62F:  ff
b07_9630:   .db $ff                     ; 1D630:  ff
b07_9631:   .db $ff                     ; 1D631:  ff
b07_9632:   .db $ff                     ; 1D632:  ff
b07_9633:   inc $0000,x                 ; 1D633:  fe 00 00
b07_9636:   brk                         ; 1D636:  00
b07_9637:   brk                         ; 1D637:  00
b07_9638:   .db $04                     ; 1D638:  04
b07_9639:   .db $0c                     ; 1D639:  0c
b07_963a:   asl a                       ; 1D63A:  0a
b07_963b:   ora $f0f2,y                 ; 1D63B:  19 f2 f0
b07_963e:   .db $f2                     ; 1D63E:  f2
b07_963f:   bvs $9635                   ; 1D63F:  70 f4
b07_9641:   .db $fc                     ; 1D641:  fc
b07_9642:   sbc $10fa,y                 ; 1D642:  f9 fa 10
b07_9645:   .db $34                     ; 1D645:  34
b07_9646:   pla                         ; 1D646:  68
b07_9647:   cpx #$c8                    ; 1D647:  e0 c8
b07_9649:   bcc $966b                   ; 1D649:  90 20
b07_964b:   bvc $963e                   ; 1D64B:  50 f1
b07_964d:   .db $f2                     ; 1D64D:  f2
b07_964e:   sbc $ea                     ; 1D64E:  e5 ea
b07_9650:   .db $d4                     ; 1D650:  d4
b07_9651:   tax                         ; 1D651:  aa
b07_9652:   eor $a8,x                   ; 1D652:  55 a8
b07_9654:   .db $80                     ; 1D654:  80
b07_9655:   bpl $965f                   ; 1D655:  10 08
b07_9657:   brk                         ; 1D657:  00
b07_9658:   brk                         ; 1D658:  00
b07_9659:   brk                         ; 1D659:  00
b07_965a:   brk                         ; 1D65A:  00
b07_965b:   brk                         ; 1D65B:  00
b07_965c:   .db $02                     ; 1D65C:  02
b07_965d:   tay                         ; 1D65D:  a8
b07_965e:   .db $57                     ; 1D65E:  57
b07_965f:   rol a                       ; 1D65F:  2a
b07_9660:   eor $aa,x                   ; 1D660:  55 aa
b07_9662:   eor $aa,x                   ; 1D662:  55 aa
b07_9664:   .db $44                     ; 1D664:  44
b07_9665:   ora ($44),y                 ; 1D665:  11 44
b07_9667:   ora ($44),y                 ; 1D667:  11 44
b07_9669:   ora ($44),y                 ; 1D669:  11 44
b07_966b:   ora ($88),y                 ; 1D66B:  11 88
b07_966d:   .db $22                     ; 1D66D:  22
b07_966e:   dey                         ; 1D66E:  88
b07_966f:   .db $22                     ; 1D66F:  22
b07_9670:   dey                         ; 1D670:  88
b07_9671:   .db $22                     ; 1D671:  22
b07_9672:   dey                         ; 1D672:  88
b07_9673:   .db $22                     ; 1D673:  22
b07_9674:   .db $42                     ; 1D674:  42
b07_9675:   ora $1c4e,y                 ; 1D675:  19 4e 1c
b07_9678:   cli                         ; 1D678:  58
b07_9679:   brk                         ; 1D679:  00
b07_967a:   rti                         ; 1D67A:  40
b07_967b:   brk                         ; 1D67B:  00
b07_967c:   txa                         ; 1D67C:  8a
b07_967d:   and #$8e                    ; 1D67D:  29 8e
b07_967f:   and $079b,x                 ; 1D67F:  3d 9b 07
b07_9682:   .db $8f                     ; 1D682:  8f
b07_9683:   .db $0f                     ; 1D683:  0f
b07_9684:   brk                         ; 1D684:  00
b07_9685:   jsr $7c30                   ; 1D685:  20 30 7c
b07_9688:   .db $3f                     ; 1D688:  3f
b07_9689:   .db $6f                     ; 1D689:  6f
b07_968a:   rol $9f0b,x                 ; 1D68A:  3e 0b 9f
b07_968d:   .db $2f                     ; 1D68D:  2f
b07_968e:   .db $b3                     ; 1D68E:  b3
b07_968f:   .db $7c                     ; 1D68F:  7c
b07_9690:   .db $3f                     ; 1D690:  3f
b07_9691:   .db $6f                     ; 1D691:  6f
b07_9692:   rol $840b,x                 ; 1D692:  3e 0b 84
b07_9695:   ora ($0f),y                 ; 1D695:  11 0f
b07_9697:   .db $1f                     ; 1D697:  1f
b07_9698:   .db $3f                     ; 1D698:  3f
b07_9699:   .db $3f                     ; 1D699:  3f
b07_969a:   .db $3f                     ; 1D69A:  3f
b07_969b:   .db $3f                     ; 1D69B:  3f
b07_969c:   dey                         ; 1D69C:  88
b07_969d:   .db $22                     ; 1D69D:  22
b07_969e:   bmi $9680                   ; 1D69E:  30 e0
b07_96a0:   cpy #$c0                    ; 1D6A0:  c0 c0
b07_96a2:   cpy #$c0                    ; 1D6A2:  c0 c0
b07_96a4:   .db $44                     ; 1D6A4:  44
b07_96a5:   ora ($e4),y                 ; 1D6A5:  11 e4
b07_96a7:   sbc $ffff,x                 ; 1D6A7:  fd ff ff
b07_96aa:   .db $ff                     ; 1D6AA:  ff
b07_96ab:   .db $ff                     ; 1D6AB:  ff
b07_96ac:   dey                         ; 1D6AC:  88
b07_96ad:   .db $22                     ; 1D6AD:  22
b07_96ae:   php                         ; 1D6AE:  08
b07_96af:   .db $02                     ; 1D6AF:  02
b07_96b0:   brk                         ; 1D6B0:  00
b07_96b1:   brk                         ; 1D6B1:  00
b07_96b2:   brk                         ; 1D6B2:  00
b07_96b3:   brk                         ; 1D6B3:  00
b07_96b4:   .db $3f                     ; 1D6B4:  3f
b07_96b5:   .db $1f                     ; 1D6B5:  1f
b07_96b6:   .db $1f                     ; 1D6B6:  1f
b07_96b7:   .db $0f                     ; 1D6B7:  0f
b07_96b8:   .db $8f                     ; 1D6B8:  8f
b07_96b9:   .db $07                     ; 1D6B9:  07
b07_96ba:   .db $02                     ; 1D6BA:  02
b07_96bb:   brk                         ; 1D6BB:  00
b07_96bc:   cpy #$e0                    ; 1D6BC:  c0 e0
b07_96be:   cpx #$f0                    ; 1D6BE:  e0 f0
b07_96c0:   bcs $973a                   ; 1D6C0:  b0 78
b07_96c2:   sed                         ; 1D6C2:  f8
b07_96c3:   .db $f4                     ; 1D6C3:  f4
b07_96c4:   .db $ff                     ; 1D6C4:  ff
b07_96c5:   .db $ff                     ; 1D6C5:  ff
b07_96c6:   .db $ff                     ; 1D6C6:  ff
b07_96c7:   .db $ff                     ; 1D6C7:  ff
b07_96c8:   .db $ff                     ; 1D6C8:  ff
b07_96c9:   .db $ff                     ; 1D6C9:  ff
b07_96ca:   .db $7f                     ; 1D6CA:  7f
b07_96cb:   .db $3f                     ; 1D6CB:  3f
b07_96cc:   brk                         ; 1D6CC:  00
b07_96cd:   brk                         ; 1D6CD:  00
b07_96ce:   brk                         ; 1D6CE:  00
b07_96cf:   brk                         ; 1D6CF:  00
b07_96d0:   brk                         ; 1D6D0:  00
b07_96d1:   brk                         ; 1D6D1:  00
b07_96d2:   brk                         ; 1D6D2:  00
b07_96d3:   brk                         ; 1D6D3:  00
b07_96d4:   .db $44                     ; 1D6D4:  44
b07_96d5:   ora ($44),y                 ; 1D6D5:  11 44
b07_96d7:   ora ($44),y                 ; 1D6D7:  11 44
b07_96d9:   sta ($c4),y                 ; 1D6D9:  91 c4
b07_96db:   sbc ($88),y                 ; 1D6DB:  f1 88
b07_96dd:   .db $22                     ; 1D6DD:  22
b07_96de:   dey                         ; 1D6DE:  88
b07_96df:   .db $22                     ; 1D6DF:  22
b07_96e0:   dey                         ; 1D6E0:  88
b07_96e1:   .db $22                     ; 1D6E1:  22
b07_96e2:   php                         ; 1D6E2:  08
b07_96e3:   .db $02                     ; 1D6E3:  02
b07_96e4:   .db $f4                     ; 1D6E4:  f4
b07_96e5:   sbc ($f4),y                 ; 1D6E5:  f1 f4
b07_96e7:   sbc $fdf8,y                 ; 1D6E7:  f9 f8 fd
b07_96ea:   .db $fc                     ; 1D6EA:  fc
b07_96eb:   cmp $08,x                   ; 1D6EB:  d5 08
b07_96ed:   .db $02                     ; 1D6ED:  02
b07_96ee:   php                         ; 1D6EE:  08
b07_96ef:   .db $02                     ; 1D6EF:  02
b07_96f0:   brk                         ; 1D6F0:  00
b07_96f1:   .db $02                     ; 1D6F1:  02
b07_96f2:   brk                         ; 1D6F2:  00
b07_96f3:   .db $02                     ; 1D6F3:  02
b07_96f4:   .db $22                     ; 1D6F4:  22
b07_96f5:   php                         ; 1D6F5:  08
b07_96f6:   .db $02                     ; 1D6F6:  02
b07_96f7:   sec                         ; 1D6F7:  38
b07_96f8:   lsr $40                     ; 1D6F8:  46 40
b07_96fa:   rti                         ; 1D6FA:  40
b07_96fb:   rts                         ; 1D6FB:  60
b07_96fc:   ldx #$09                    ; 1D6FC:  a2 09
b07_96fe:   .db $83                     ; 1D6FE:  83
b07_96ff:   ora ($03,x)                 ; 1D6FF:  01 03
b07_9701:   ora $0723,y                 ; 1D701:  19 23 07
b07_9704:   jsr $5c30                   ; 1D704:  20 30 5c
b07_9707:   .db $04                     ; 1D707:  04
b07_9708:   rti                         ; 1D708:  40
b07_9709:   bpl $974b                   ; 1D709:  10 40
b07_970b:   bpl $96a8                   ; 1D70B:  10 9b
b07_970d:   .db $0b                     ; 1D70D:  0b
b07_970e:   .db $83                     ; 1D70E:  83
b07_970f:   .db $23                     ; 1D70F:  23
b07_9710:   sta ($25,x)                 ; 1D710:  81 25
b07_9712:   sta $27                     ; 1D712:  85 27
b07_9714:   .db $03                     ; 1D714:  03
b07_9715:   .db $07                     ; 1D715:  07
b07_9716:   .db $0f                     ; 1D716:  0f
b07_9717:   php                         ; 1D717:  08
b07_9718:   .db $13                     ; 1D718:  13
b07_9719:   .db $0f                     ; 1D719:  0f
b07_971a:   .db $07                     ; 1D71A:  07
b07_971b:   .db $1f                     ; 1D71B:  1f
b07_971c:   .db $fc                     ; 1D71C:  fc
b07_971d:   sed                         ; 1D71D:  f8
b07_971e:   beq $9700                   ; 1D71E:  f0 e0
b07_9720:   cpx #$d0                    ; 1D720:  e0 d0
b07_9722:   sed                         ; 1D722:  f8
b07_9723:   cpx #$97                    ; 1D723:  e0 97
b07_9725:   .db $c7                     ; 1D725:  c7
b07_9726:   inc $ce0e                   ; 1D726:  ee 0e ce
b07_9729:   .db $9e                     ; 1D729:  9e
b07_972a:   .db $3f                     ; 1D72A:  3f
b07_972b:   .db $ff                     ; 1D72B:  ff
b07_972c:   php                         ; 1D72C:  08
b07_972d:   plp                         ; 1D72D:  28
b07_972e:   bpl $9740                   ; 1D72E:  10 10
b07_9730:   bmi $9772                   ; 1D730:  30 40
b07_9732:   .db $80                     ; 1D732:  80
b07_9733:   brk                         ; 1D733:  00
b07_9734:   .db $1f                     ; 1D734:  1f
b07_9735:   .db $1f                     ; 1D735:  1f
b07_9736:   .db $0f                     ; 1D736:  0f
b07_9737:   brk                         ; 1D737:  00
b07_9738:   brk                         ; 1D738:  00
b07_9739:   asl $0e0f                   ; 1D739:  0e 0f 0e
b07_973c:   cpx #$e0                    ; 1D73C:  e0 e0
b07_973e:   bcs $971f                   ; 1D73E:  b0 df
b07_9740:   .db $e7                     ; 1D740:  e7
b07_9741:   sbc ($f1),y                 ; 1D741:  f1 f1
b07_9743:   .db $f2                     ; 1D743:  f2
b07_9744:   .db $e7                     ; 1D744:  e7
b07_9745:   .db $cf                     ; 1D745:  cf
b07_9746:   .db $80                     ; 1D746:  80
b07_9747:   brk                         ; 1D747:  00
b07_9748:   ora $566b,y                 ; 1D748:  19 6b 56
b07_974b:   .db $02                     ; 1D74B:  02
b07_974c:   bpl $976e                   ; 1D74C:  10 20
b07_974e:   eor #$a2                    ; 1D74E:  49 a2
b07_9750:   .db $ff                     ; 1D750:  ff
b07_9751:   .db $eb                     ; 1D751:  eb
b07_9752:   .db $54                     ; 1D752:  54
b07_9753:   brk                         ; 1D753:  00
b07_9754:   sty $3d                     ; 1D754:  84 3d
b07_9756:   .db $3c                     ; 1D756:  3c
b07_9757:   ora #$f4                    ; 1D757:  09 f4
b07_9759:   adc $3d1c,y                 ; 1D759:  79 1c 3d
b07_975c:   brk                         ; 1D75C:  00
b07_975d:   .db $42                     ; 1D75D:  42
b07_975e:   cpy #$02                    ; 1D75E:  c0 02
b07_9760:   brk                         ; 1D760:  00
b07_9761:   .db $82                     ; 1D761:  82
b07_9762:   rts                         ; 1D762:  60
b07_9763:   .db $42                     ; 1D763:  42
b07_9764:   ldy $98bd,x                 ; 1D764:  bc bd 98
b07_9767:   ora ($ec,x)                 ; 1D767:  01 ec
b07_9769:   adc #$bc                    ; 1D769:  69 bc
b07_976b:   ora $0240,y                 ; 1D76B:  19 40 02
b07_976e:   bit $3e                     ; 1D76E:  24 3e
b07_9770:   bcc $97c4                   ; 1D770:  90 52
b07_9772:   ldy #$12                    ; 1D772:  a0 12
b07_9774:   .db $44                     ; 1D774:  44
b07_9775:   ora ($44),y                 ; 1D775:  11 44
b07_9777:   ora ($44),y                 ; 1D777:  11 44
b07_9779:   ora ($44),y                 ; 1D779:  11 44
b07_977b:   bpl $9705                   ; 1D77B:  10 88
b07_977d:   .db $22                     ; 1D77D:  22
b07_977e:   dey                         ; 1D77E:  88
b07_977f:   .db $22                     ; 1D77F:  22
b07_9780:   dey                         ; 1D780:  88
b07_9781:   .db $22                     ; 1D781:  22
b07_9782:   dey                         ; 1D782:  88
b07_9783:   jsr $1440                   ; 1D783:  20 40 14
b07_9786:   .db $44                     ; 1D786:  44
b07_9787:   asl $42                     ; 1D787:  06 42
b07_9789:   .db $03                     ; 1D789:  03
b07_978a:   ora ($01,x)                 ; 1D78A:  01 01
b07_978c:   stx $27                     ; 1D78C:  86 27
b07_978e:   .db $87                     ; 1D78E:  87
b07_978f:   .db $27                     ; 1D78F:  27
b07_9790:   .db $83                     ; 1D790:  83
b07_9791:   .db $0b                     ; 1D791:  0b
b07_9792:   ora ($89,x)                 ; 1D792:  01 89
b07_9794:   brk                         ; 1D794:  00
b07_9795:   brk                         ; 1D795:  00
b07_9796:   brk                         ; 1D796:  00
b07_9797:   brk                         ; 1D797:  00
b07_9798:   brk                         ; 1D798:  00
b07_9799:   brk                         ; 1D799:  00
b07_979a:   .db $1c                     ; 1D79A:  1c
b07_979b:   rol $8802,x                 ; 1D79B:  3e 02 88
b07_979e:   .db $22                     ; 1D79E:  22
b07_979f:   dey                         ; 1D79F:  88
b07_97a0:   .db $22                     ; 1D7A0:  22
b07_97a1:   .db $80                     ; 1D7A1:  80
b07_97a2:   brk                         ; 1D7A2:  00
b07_97a3:   .db $80                     ; 1D7A3:  80
b07_97a4:   brk                         ; 1D7A4:  00
b07_97a5:   brk                         ; 1D7A5:  00
b07_97a6:   brk                         ; 1D7A6:  00
b07_97a7:   brk                         ; 1D7A7:  00
b07_97a8:   brk                         ; 1D7A8:  00
b07_97a9:   brk                         ; 1D7A9:  00
b07_97aa:   brk                         ; 1D7AA:  00
b07_97ab:   brk                         ; 1D7AB:  00
b07_97ac:   brk                         ; 1D7AC:  00
b07_97ad:   dey                         ; 1D7AD:  88
b07_97ae:   .db $22                     ; 1D7AE:  22
b07_97af:   dey                         ; 1D7AF:  88
b07_97b0:   .db $22                     ; 1D7B0:  22
b07_97b1:   dey                         ; 1D7B1:  88
b07_97b2:   .db $22                     ; 1D7B2:  22
b07_97b3:   .db $80                     ; 1D7B3:  80
b07_97b4:   ora $3306                   ; 1D7B4:  0d 06 33
b07_97b7:   ora $0d,x                   ; 1D7B7:  15 0d
b07_97b9:   ora $81                     ; 1D7B9:  05 81
b07_97bb:   cpy #$f5                    ; 1D7BB:  c0 f5
b07_97bd:   adc $d6bc,y                 ; 1D7BD:  79 bc d6
b07_97c0:   .db $ef                     ; 1D7C0:  ef
b07_97c1:   sbc $f9,x                   ; 1D7C1:  f5 f9
b07_97c3:   .db $fc                     ; 1D7C3:  fc
b07_97c4:   .db $3f                     ; 1D7C4:  3f
b07_97c5:   bvs $9827                   ; 1D7C5:  70 60
b07_97c7:   .db $e7                     ; 1D7C7:  e7
b07_97c8:   .db $ff                     ; 1D7C8:  ff
b07_97c9:   sbc $a969,x                 ; 1D7C9:  fd 69 a9
b07_97cc:   brk                         ; 1D7CC:  00
b07_97cd:   dey                         ; 1D7CD:  88
b07_97ce:   stx $1a,y                   ; 1D7CE:  96 1a
b07_97d0:   asl $6d                     ; 1D7D0:  06 6d
b07_97d2:   adc #$a9                    ; 1D7D2:  69 a9
b07_97d4:   cpx #$70                    ; 1D7D4:  e0 70
b07_97d6:   tsx                         ; 1D7D6:  ba
b07_97d7:   .db $5f                     ; 1D7D7:  5f
b07_97d8:   .db $6f                     ; 1D7D8:  6f
b07_97d9:   .db $37                     ; 1D7D9:  37
b07_97da:   .db $3b                     ; 1D7DA:  3b
b07_97db:   ora $7ffe,x                 ; 1D7DB:  1d fe 7f
b07_97de:   lda $2e5c,x                 ; 1D7DE:  bd 5c 2e
b07_97e1:   .db $97                     ; 1D7E1:  97
b07_97e2:   .db $2b                     ; 1D7E2:  2b
b07_97e3:   sta $00,x                   ; 1D7E3:  95 00
b07_97e5:   eor ($15),y                 ; 1D7E5:  51 15
b07_97e7:   brk                         ; 1D7E7:  00
b07_97e8:   cpy #$f8                    ; 1D7E8:  c0 f8
b07_97ea:   sbc $00f9,y                 ; 1D7EA:  f9 f9 00
b07_97ed:   eor ($d5),y                 ; 1D7ED:  51 d5
b07_97ef:   .db $fc                     ; 1D7EF:  fc
b07_97f0:   rol $8506,x                 ; 1D7F0:  3e 06 85
b07_97f3:   cmp $8c                     ; 1D7F3:  c5 8c
b07_97f5:   lda ($e4),y                 ; 1D7F5:  b1 e4
b07_97f7:   sbc ($e4,x)                 ; 1D7F7:  e1 e4
b07_97f9:   cmp ($04),y                 ; 1D7F9:  d1 04
b07_97fb:   rti                         ; 1D7FB:  40
b07_97fc:   rti                         ; 1D7FC:  40
b07_97fd:   .db $42                     ; 1D7FD:  42
b07_97fe:   php                         ; 1D7FE:  08
b07_97ff:   .db $22                     ; 1D7FF:  22
b07_9800:   pla                         ; 1D800:  68
b07_9801:   .db $c2                     ; 1D801:  c2
b07_9802:   brk                         ; 1D802:  00
b07_9803:   pha                         ; 1D803:  48
b07_9804:   rti                         ; 1D804:  40
b07_9805:   rti                         ; 1D805:  40
b07_9806:   rti                         ; 1D806:  40
b07_9807:   cpy #$c0                    ; 1D807:  c0 c0
b07_9809:   cpx #$e0                    ; 1D809:  e0 e0
b07_980b:   cpx #$42                    ; 1D80B:  e0 42
b07_980d:   rti                         ; 1D80D:  40
b07_980e:   .db $02                     ; 1D80E:  02
b07_980f:   iny                         ; 1D80F:  c8
b07_9810:   .db $82                     ; 1D810:  82
b07_9811:   iny                         ; 1D811:  c8
b07_9812:   ldy #$c8                    ; 1D812:  a0 c8
b07_9814:   .db $04                     ; 1D814:  04
b07_9815:   brk                         ; 1D815:  00
b07_9816:   brk                         ; 1D816:  00
b07_9817:   brk                         ; 1D817:  00
b07_9818:   brk                         ; 1D818:  00
b07_9819:   bmi $9853                   ; 1D819:  30 38
b07_981b:   sec                         ; 1D81B:  38
b07_981c:   brk                         ; 1D81C:  00
b07_981d:   dey                         ; 1D81D:  88
b07_981e:   .db $22                     ; 1D81E:  22
b07_981f:   dey                         ; 1D81F:  88
b07_9820:   .db $02                     ; 1D820:  02
b07_9821:   .db $80                     ; 1D821:  80
b07_9822:   .db $02                     ; 1D822:  02
b07_9823:   .db $80                     ; 1D823:  80
b07_9824:   brk                         ; 1D824:  00
b07_9825:   brk                         ; 1D825:  00
b07_9826:   brk                         ; 1D826:  00
b07_9827:   brk                         ; 1D827:  00
b07_9828:   brk                         ; 1D828:  00
b07_9829:   brk                         ; 1D829:  00
b07_982a:   brk                         ; 1D82A:  00
b07_982b:   brk                         ; 1D82B:  00
b07_982c:   tax                         ; 1D82C:  aa
b07_982d:   .db $ff                     ; 1D82D:  ff
b07_982e:   tax                         ; 1D82E:  aa
b07_982f:   .db $ff                     ; 1D82F:  ff
b07_9830:   tax                         ; 1D830:  aa
b07_9831:   .db $ff                     ; 1D831:  ff
b07_9832:   tax                         ; 1D832:  aa
b07_9833:   .db $ff                     ; 1D833:  ff
b07_9834:   brk                         ; 1D834:  00
b07_9835:   brk                         ; 1D835:  00
b07_9836:   jsr $0004                   ; 1D836:  20 04 00
b07_9839:   brk                         ; 1D839:  00
b07_983a:   brk                         ; 1D83A:  00
b07_983b:   brk                         ; 1D83B:  00
b07_983c:   tax                         ; 1D83C:  aa
b07_983d:   beq $983f                   ; 1D83D:  f0 00
b07_983f:   .db $02                     ; 1D83F:  02
b07_9840:   .db $80                     ; 1D840:  80
b07_9841:   cpx #$a0                    ; 1D841:  e0 a0
b07_9843:   cpx #$00                    ; 1D843:  e0 00
b07_9845:   ora ($01,x)                 ; 1D845:  01 01
b07_9847:   brk                         ; 1D847:  00
b07_9848:   ora ($01,x)                 ; 1D848:  01 01
b07_984a:   .db $03                     ; 1D84A:  03
b07_984b:   ora ($80,x)                 ; 1D84B:  01 80
b07_984d:   cpy #$80                    ; 1D84D:  c0 80
b07_984f:   .db $80                     ; 1D84F:  80
b07_9850:   .db $80                     ; 1D850:  80
b07_9851:   .db $80                     ; 1D851:  80
b07_9852:   .db $80                     ; 1D852:  80
b07_9853:   .db $80                     ; 1D853:  80
b07_9854:   brk                         ; 1D854:  00
b07_9855:   brk                         ; 1D855:  00
b07_9856:   brk                         ; 1D856:  00
b07_9857:   brk                         ; 1D857:  00
b07_9858:   .db $80                     ; 1D858:  80
b07_9859:   .db $1c                     ; 1D859:  1c
b07_985a:   .db $03                     ; 1D85A:  03
b07_985b:   brk                         ; 1D85B:  00
b07_985c:   brk                         ; 1D85C:  00
b07_985d:   brk                         ; 1D85D:  00
b07_985e:   brk                         ; 1D85E:  00
b07_985f:   brk                         ; 1D85F:  00
b07_9860:   cpy #$14                    ; 1D860:  c0 14
b07_9862:   .db $02                     ; 1D862:  02
b07_9863:   brk                         ; 1D863:  00
b07_9864:   brk                         ; 1D864:  00
b07_9865:   bpl $9877                   ; 1D865:  10 10
b07_9867:   php                         ; 1D867:  08
b07_9868:   php                         ; 1D868:  08
b07_9869:   php                         ; 1D869:  08
b07_986a:   cpx $3f                     ; 1D86A:  e4 3f
b07_986c:   .db $12                     ; 1D86C:  12
b07_986d:   brk                         ; 1D86D:  00
b07_986e:   bpl $9870                   ; 1D86E:  10 00
b07_9870:   php                         ; 1D870:  08
b07_9871:   php                         ; 1D871:  08
b07_9872:   cpx $3c                     ; 1D872:  e4 3c
b07_9874:   brk                         ; 1D874:  00
b07_9875:   cpx #$fc                    ; 1D875:  e0 fc
b07_9877:   .db $ff                     ; 1D877:  ff
b07_9878:   .db $7f                     ; 1D878:  7f
b07_9879:   .db $ff                     ; 1D879:  ff
b07_987a:   .db $ff                     ; 1D87A:  ff
b07_987b:   .db $ff                     ; 1D87B:  ff
b07_987c:   brk                         ; 1D87C:  00
b07_987d:   brk                         ; 1D87D:  00
b07_987e:   brk                         ; 1D87E:  00
b07_987f:   brk                         ; 1D87F:  00
b07_9880:   brk                         ; 1D880:  00
b07_9881:   brk                         ; 1D881:  00
b07_9882:   brk                         ; 1D882:  00
b07_9883:   brk                         ; 1D883:  00
b07_9884:   .db $04                     ; 1D884:  04
b07_9885:   .db $04                     ; 1D885:  04
b07_9886:   brk                         ; 1D886:  00
b07_9887:   brk                         ; 1D887:  00
b07_9888:   cpy #$ff                    ; 1D888:  c0 ff
b07_988a:   .db $ff                     ; 1D88A:  ff
b07_988b:   .db $ff                     ; 1D88B:  ff
b07_988c:   .db $04                     ; 1D88C:  04
b07_988d:   .db $04                     ; 1D88D:  04
b07_988e:   brk                         ; 1D88E:  00
b07_988f:   .db $c3                     ; 1D88F:  c3
b07_9890:   .db $3f                     ; 1D890:  3f
b07_9891:   brk                         ; 1D891:  00
b07_9892:   brk                         ; 1D892:  00
b07_9893:   brk                         ; 1D893:  00
b07_9894:   brk                         ; 1D894:  00
b07_9895:   brk                         ; 1D895:  00
b07_9896:   brk                         ; 1D896:  00
b07_9897:   .db $04                     ; 1D897:  04
b07_9898:   php                         ; 1D898:  08
b07_9899:   jsr $0080                   ; 1D899:  20 80 00
b07_989c:   tax                         ; 1D89C:  aa
b07_989d:   .db $7f                     ; 1D89D:  7f
b07_989e:   .db $02                     ; 1D89E:  02
b07_989f:   .db $03                     ; 1D89F:  03
b07_98a0:   .db $02                     ; 1D8A0:  02
b07_98a1:   .db $17                     ; 1D8A1:  17
b07_98a2:   lsr a                       ; 1D8A2:  4a
b07_98a3:   .db $0f                     ; 1D8A3:  0f
b07_98a4:   brk                         ; 1D8A4:  00
b07_98a5:   brk                         ; 1D8A5:  00
b07_98a6:   brk                         ; 1D8A6:  00
b07_98a7:   brk                         ; 1D8A7:  00
b07_98a8:   cpy #$c0                    ; 1D8A8:  c0 c0
b07_98aa:   cpx #$e0                    ; 1D8AA:  e0 e0
b07_98ac:   asl a                       ; 1D8AC:  0a
b07_98ad:   .db $0f                     ; 1D8AD:  0f
b07_98ae:   .db $e2                     ; 1D8AE:  e2
b07_98af:   .db $e7                     ; 1D8AF:  e7
b07_98b0:   .db $32                     ; 1D8B0:  32
b07_98b1:   .db $37                     ; 1D8B1:  37
b07_98b2:   .db $1a                     ; 1D8B2:  1a
b07_98b3:   .db $1b                     ; 1D8B3:  1b
b07_98b4:   .db $03                     ; 1D8B4:  03
b07_98b5:   ora ($05,x)                 ; 1D8B5:  01 05
b07_98b7:   .db $03                     ; 1D8B7:  03
b07_98b8:   and $3b,x                   ; 1D8B8:  35 3b
b07_98ba:   .db $27                     ; 1D8BA:  27
b07_98bb:   .db $23                     ; 1D8BB:  23
b07_98bc:   .db $80                     ; 1D8BC:  80
b07_98bd:   .db $80                     ; 1D8BD:  80
b07_98be:   .db $80                     ; 1D8BE:  80
b07_98bf:   .db $80                     ; 1D8BF:  80
b07_98c0:   .db $80                     ; 1D8C0:  80
b07_98c1:   .db $80                     ; 1D8C1:  80
b07_98c2:   .db $80                     ; 1D8C2:  80
b07_98c3:   dey                         ; 1D8C3:  88
b07_98c4:   and ($23,x)                 ; 1D8C4:  21 23
b07_98c6:   ora ($19),y                 ; 1D8C6:  11 19
b07_98c8:   .db $0f                     ; 1D8C8:  0f
b07_98c9:   ora ($01,x)                 ; 1D8C9:  01 01
b07_98cb:   ora ($80,x)                 ; 1D8CB:  01 80
b07_98cd:   dey                         ; 1D8CD:  88
b07_98ce:   sty $a0c2                   ; 1D8CE:  8c c2 a0
b07_98d1:   beq $9873                   ; 1D8D1:  f0 a0
b07_98d3:   .db $fa                     ; 1D8D3:  fa
b07_98d4:   .db $ff                     ; 1D8D4:  ff
b07_98d5:   .db $eb                     ; 1D8D5:  eb
b07_98d6:   bne $98d6                   ; 1D8D6:  d0 fe
b07_98d8:   .db $ff                     ; 1D8D8:  ff
b07_98d9:   beq $989e                   ; 1D8D9:  f0 c3
b07_98db:   .db $ff                     ; 1D8DB:  ff
b07_98dc:   brk                         ; 1D8DC:  00
b07_98dd:   brk                         ; 1D8DD:  00
b07_98de:   brk                         ; 1D8DE:  00
b07_98df:   ora ($00,x)                 ; 1D8DF:  01 00
b07_98e1:   brk                         ; 1D8E1:  00
b07_98e2:   .db $23                     ; 1D8E2:  23
b07_98e3:   brk                         ; 1D8E3:  00
b07_98e4:   .db $ff                     ; 1D8E4:  ff
b07_98e5:   .db $ff                     ; 1D8E5:  ff
b07_98e6:   .db $7f                     ; 1D8E6:  7f
b07_98e7:   ror $8c1c,x                 ; 1D8E7:  7e 1c 8c
b07_98ea:   .db $5c                     ; 1D8EA:  5c
b07_98eb:   inc $0000,x                 ; 1D8EB:  fe 00 00
b07_98ee:   brk                         ; 1D8EE:  00
b07_98ef:   sta ($e1,x)                 ; 1D8EF:  81 e1
b07_98f1:   bvs $9914                   ; 1D8F1:  70 21
b07_98f3:   brk                         ; 1D8F3:  00
b07_98f4:   .db $ff                     ; 1D8F4:  ff
b07_98f5:   .db $ff                     ; 1D8F5:  ff
b07_98f6:   .db $ff                     ; 1D8F6:  ff
b07_98f7:   .db $ff                     ; 1D8F7:  ff
b07_98f8:   .db $ff                     ; 1D8F8:  ff
b07_98f9:   .db $ff                     ; 1D8F9:  ff
b07_98fa:   .db $ff                     ; 1D8FA:  ff
b07_98fb:   inc $0000,x                 ; 1D8FB:  fe 00 00
b07_98fe:   brk                         ; 1D8FE:  00
b07_98ff:   brk                         ; 1D8FF:  00
b07_9900:   brk                         ; 1D900:  00
b07_9901:   brk                         ; 1D901:  00
b07_9902:   brk                         ; 1D902:  00
b07_9903:   ora ($fe,x)                 ; 1D903:  01 fe
b07_9905:   inc $dfee,x                 ; 1D905:  fe ee df
b07_9908:   .db $df                     ; 1D908:  df
b07_9909:   stx $10                     ; 1D909:  86 10
b07_990b:   plp                         ; 1D90B:  28
b07_990c:   brk                         ; 1D90C:  00
b07_990d:   brk                         ; 1D90D:  00
b07_990e:   bpl $9930                   ; 1D90E:  10 20
b07_9910:   jsr $c960                   ; 1D910:  20 60 c9
b07_9913:   .db $82                     ; 1D913:  82
b07_9914:   cpy #$80                    ; 1D914:  c0 80
b07_9916:   brk                         ; 1D916:  00
b07_9917:   rts                         ; 1D917:  60
b07_9918:   brk                         ; 1D918:  00
b07_9919:   bmi $997b                   ; 1D919:  30 60
b07_991b:   brk                         ; 1D91B:  00
b07_991c:   .db $12                     ; 1D91C:  12
b07_991d:   .db $0b                     ; 1D91D:  0b
b07_991e:   .db $3a                     ; 1D91E:  3a
b07_991f:   .db $9b                     ; 1D91F:  9b
b07_9920:   asl a                       ; 1D920:  0a
b07_9921:   .db $3b                     ; 1D921:  3b
b07_9922:   txs                         ; 1D922:  9a
b07_9923:   .db $fb                     ; 1D923:  fb
b07_9924:   rts                         ; 1D924:  60
b07_9925:   bvs $9997                   ; 1D925:  70 70
b07_9927:   bmi $9949                   ; 1D927:  30 20
b07_9929:   brk                         ; 1D929:  00
b07_992a:   brk                         ; 1D92A:  00
b07_992b:   brk                         ; 1D92B:  00
b07_992c:   txs                         ; 1D92C:  9a
b07_992d:   .db $8b                     ; 1D92D:  8b
b07_992e:   txa                         ; 1D92E:  8a
b07_992f:   .db $4b                     ; 1D92F:  4b
b07_9930:   .db $5a                     ; 1D930:  5a
b07_9931:   .db $f7                     ; 1D931:  f7
b07_9932:   .db $f2                     ; 1D932:  f2
b07_9933:   .db $77                     ; 1D933:  77
b07_9934:   brk                         ; 1D934:  00
b07_9935:   brk                         ; 1D935:  00
b07_9936:   brk                         ; 1D936:  00
b07_9937:   brk                         ; 1D937:  00
b07_9938:   brk                         ; 1D938:  00
b07_9939:   brk                         ; 1D939:  00
b07_993a:   brk                         ; 1D93A:  00
b07_993b:   tax                         ; 1D93B:  aa
b07_993c:   tax                         ; 1D93C:  aa
b07_993d:   .db $ff                     ; 1D93D:  ff
b07_993e:   tax                         ; 1D93E:  aa
b07_993f:   .db $ff                     ; 1D93F:  ff
b07_9940:   tax                         ; 1D940:  aa
b07_9941:   inc $1100,x                 ; 1D941:  fe 00 11
b07_9944:   .db $04                     ; 1D944:  04
b07_9945:   .db $04                     ; 1D945:  04
b07_9946:   ora $0b                     ; 1D946:  05 0b
b07_9948:   .db $0b                     ; 1D948:  0b
b07_9949:   .db $0b                     ; 1D949:  0b
b07_994a:   txa                         ; 1D94A:  8a
b07_994b:   .db $8b                     ; 1D94B:  8b
b07_994c:   ldx $a6f7                   ; 1D94C:  ae f7 a6
b07_994f:   .db $e2                     ; 1D94F:  e2
b07_9950:   .db $82                     ; 1D950:  82
b07_9951:   .db $12                     ; 1D951:  12
b07_9952:   .db $43                     ; 1D952:  43
b07_9953:   .db $13                     ; 1D953:  13
b07_9954:   tax                         ; 1D954:  aa
b07_9955:   tax                         ; 1D955:  aa
b07_9956:   tay                         ; 1D956:  a8
b07_9957:   tax                         ; 1D957:  aa
b07_9958:   ldx #$a2                    ; 1D958:  a2 a2
b07_995a:   .db $9c                     ; 1D95A:  9c
b07_995b:   .db $9e                     ; 1D95B:  9e
b07_995c:   .db $44                     ; 1D95C:  44
b07_995d:   ora ($44),y                 ; 1D95D:  11 44
b07_995f:   ora ($40),y                 ; 1D95F:  11 40
b07_9961:   ora ($58,x)                 ; 1D961:  01 58
b07_9963:   bpl $98ee                   ; 1D963:  10 89
b07_9965:   .db $89                     ; 1D965:  89
b07_9966:   .db $89                     ; 1D966:  89
b07_9967:   txa                         ; 1D967:  8a
b07_9968:   txa                         ; 1D968:  8a
b07_9969:   txa                         ; 1D969:  8a
b07_996a:   txa                         ; 1D96A:  8a
b07_996b:   txa                         ; 1D96B:  8a
b07_996c:   eor $11                     ; 1D96C:  45 11
b07_996e:   eor $10                     ; 1D96E:  45 10
b07_9970:   .db $44                     ; 1D970:  44
b07_9971:   bpl $99b7                   ; 1D971:  10 44
b07_9973:   ora ($fe),y                 ; 1D973:  11 fe
b07_9975:   sed                         ; 1D975:  f8
b07_9976:   ror $bffe,x                 ; 1D976:  7e fe bf
b07_9979:   .db $df                     ; 1D979:  df
b07_997a:   .db $ef                     ; 1D97A:  ef
b07_997b:   .db $f3                     ; 1D97B:  f3
b07_997c:   brk                         ; 1D97C:  00
b07_997d:   ora ($01,x)                 ; 1D97D:  01 01
b07_997f:   ora ($00,x)                 ; 1D97F:  01 00
b07_9981:   brk                         ; 1D981:  00
b07_9982:   brk                         ; 1D982:  00
b07_9983:   brk                         ; 1D983:  00
b07_9984:   .db $04                     ; 1D984:  04
b07_9985:   .db $04                     ; 1D985:  04
b07_9986:   .db $ff                     ; 1D986:  ff
b07_9987:   beq $9969                   ; 1D987:  f0 e0
b07_9989:   .db $fc                     ; 1D989:  fc
b07_998a:   inc $00fe,x                 ; 1D98A:  fe fe 00
b07_998d:   brk                         ; 1D98D:  00
b07_998e:   brk                         ; 1D98E:  00
b07_998f:   ora ($0d,x)                 ; 1D98F:  01 0d
b07_9991:   .db $03                     ; 1D991:  03
b07_9992:   ora ($01,x)                 ; 1D992:  01 01
b07_9994:   sei                         ; 1D994:  78
b07_9995:   .db $7c                     ; 1D995:  7c
b07_9996:   ldx $dfbf,y                 ; 1D996:  be bf df
b07_9999:   .db $df                     ; 1D999:  df
b07_999a:   .db $6f                     ; 1D99A:  6f
b07_999b:   .db $77                     ; 1D99B:  77
b07_999c:   .db $80                     ; 1D99C:  80
b07_999d:   .db $80                     ; 1D99D:  80
b07_999e:   cmp ($c0,x)                 ; 1D99E:  c1 c0
b07_99a0:   cpx #$e0                    ; 1D9A0:  e0 e0
b07_99a2:   bvs $9a1c                   ; 1D9A2:  70 78
b07_99a4:   inc $003e,x                 ; 1D9A4:  fe 3e 00
b07_99a7:   brk                         ; 1D9A7:  00
b07_99a8:   .db $80                     ; 1D9A8:  80
b07_99a9:   cpx #$f0                    ; 1D9A9:  e0 f0
b07_99ab:   beq $99ae                   ; 1D9AB:  f0 01
b07_99ad:   brk                         ; 1D9AD:  00
b07_99ae:   brk                         ; 1D9AE:  00
b07_99af:   sbc $0b73,y                 ; 1D9AF:  f9 73 0b
b07_99b2:   asl $000e                   ; 1D9B2:  0e 0e 00
b07_99b5:   brk                         ; 1D9B5:  00
b07_99b6:   brk                         ; 1D9B6:  00
b07_99b7:   brk                         ; 1D9B7:  00
b07_99b8:   brk                         ; 1D9B8:  00
b07_99b9:   php                         ; 1D9B9:  08
b07_99ba:   rol a                       ; 1D9BA:  2a
b07_99bb:   .db $22                     ; 1D9BB:  22
b07_99bc:   .db $12                     ; 1D9BC:  12
b07_99bd:   .db $ef                     ; 1D9BD:  ef
b07_99be:   nop                         ; 1D9BE:  ea
b07_99bf:   .db $ef                     ; 1D9BF:  ef
b07_99c0:   .db $c2                     ; 1D9C0:  c2
b07_99c1:   cpy #$84                    ; 1D9C1:  c0 84
b07_99c3:   sta ($00),y                 ; 1D9C3:  91 00
b07_99c5:   brk                         ; 1D9C5:  00
b07_99c6:   brk                         ; 1D9C6:  00
b07_99c7:   brk                         ; 1D9C7:  00
b07_99c8:   brk                         ; 1D9C8:  00
b07_99c9:   brk                         ; 1D9C9:  00
b07_99ca:   tay                         ; 1D9CA:  a8
b07_99cb:   tax                         ; 1D9CB:  aa
b07_99cc:   tax                         ; 1D9CC:  aa
b07_99cd:   .db $ff                     ; 1D9CD:  ff
b07_99ce:   tax                         ; 1D9CE:  aa
b07_99cf:   .db $ff                     ; 1D9CF:  ff
b07_99d0:   tax                         ; 1D9D0:  aa
b07_99d1:   .db $07                     ; 1D9D1:  07
b07_99d2:   rti                         ; 1D9D2:  40
b07_99d3:   ora ($42),y                 ; 1D9D3:  11 42
b07_99d5:   lsr a                       ; 1D9D5:  4a
b07_99d6:   lsr a                       ; 1D9D6:  4a
b07_99d7:   lsr a                       ; 1D9D7:  4a
b07_99d8:   pha                         ; 1D9D8:  48
b07_99d9:   iny                         ; 1D9D9:  c8
b07_99da:   iny                         ; 1D9DA:  c8
b07_99db:   iny                         ; 1D9DB:  c8
b07_99dc:   .db $44                     ; 1D9DC:  44
b07_99dd:   eor ($40),y                 ; 1D9DD:  51 40
b07_99df:   eor ($44),y                 ; 1D9DF:  51 44
b07_99e1:   cmp ($c4),y                 ; 1D9E1:  d1 c4
b07_99e3:   cmp ($aa),y                 ; 1D9E3:  d1 aa
b07_99e5:   rol a                       ; 1D9E5:  2a
b07_99e6:   tax                         ; 1D9E6:  aa
b07_99e7:   .db $82                     ; 1D9E7:  82
b07_99e8:   .db $82                     ; 1D9E8:  82
b07_99e9:   txs                         ; 1D9E9:  9a
b07_99ea:   ldy $44bc,x                 ; 1D9EA:  bc bc 44
b07_99ed:   ora ($04),y                 ; 1D9ED:  11 04
b07_99ef:   ora ($44,x)                 ; 1D9EF:  01 44
b07_99f1:   ora $2130,y                 ; 1D9F1:  19 30 21
b07_99f4:   brk                         ; 1D9F4:  00
b07_99f5:   tax                         ; 1D9F5:  aa
b07_99f6:   brk                         ; 1D9F6:  00
b07_99f7:   tax                         ; 1D9F7:  aa
b07_99f8:   brk                         ; 1D9F8:  00
b07_99f9:   tax                         ; 1D9F9:  aa
b07_99fa:   brk                         ; 1D9FA:  00
b07_99fb:   tax                         ; 1D9FB:  aa
b07_99fc:   dey                         ; 1D9FC:  88
b07_99fd:   cmp $7722,x                 ; 1D9FD:  dd 22 77
b07_9a00:   dey                         ; 1DA00:  88
b07_9a01:   cmp $7722,x                 ; 1DA01:  dd 22 77
b07_9a04:   brk                         ; 1DA04:  00
b07_9a05:   tax                         ; 1DA05:  aa
b07_9a06:   brk                         ; 1DA06:  00
b07_9a07:   tax                         ; 1DA07:  aa
b07_9a08:   brk                         ; 1DA08:  00
b07_9a09:   tay                         ; 1DA09:  a8
b07_9a0a:   brk                         ; 1DA0A:  00
b07_9a0b:   tay                         ; 1DA0B:  a8
b07_9a0c:   dey                         ; 1DA0C:  88
b07_9a0d:   cmp $7722,x                 ; 1DA0D:  dd 22 77
b07_9a10:   dey                         ; 1DA10:  88
b07_9a11:   cmp $7723,x                 ; 1DA11:  dd 23 77
b07_9a14:   brk                         ; 1DA14:  00
b07_9a15:   lda ($01,x)                 ; 1DA15:  a1 01
b07_9a17:   lda ($01,x)                 ; 1DA17:  a1 01
b07_9a19:   sta ($07,x)                 ; 1DA19:  81 07
b07_9a1b:   .db $87                     ; 1DA1B:  87
b07_9a1c:   .db $87                     ; 1DA1C:  87
b07_9a1d:   dec $2e,x                   ; 1DA1D:  d6 2e
b07_9a1f:   ror $de8e                   ; 1DA1F:  6e 8e de
b07_9a22:   clc                         ; 1DA22:  18
b07_9a23:   bvc $9a25                   ; 1DA23:  50 00
b07_9a25:   tax                         ; 1DA25:  aa
b07_9a26:   brk                         ; 1DA26:  00
b07_9a27:   .db $83                     ; 1DA27:  83
b07_9a28:   .db $0f                     ; 1DA28:  0f
b07_9a29:   .db $3f                     ; 1DA29:  3f
b07_9a2a:   .db $7f                     ; 1DA2A:  7f
b07_9a2b:   .db $ff                     ; 1DA2B:  ff
b07_9a2c:   dey                         ; 1DA2C:  88
b07_9a2d:   cmp $5c23,x                 ; 1DA2D:  dd 23 5c
b07_9a30:   beq $99f2                   ; 1DA30:  f0 c0
b07_9a32:   .db $80                     ; 1DA32:  80
b07_9a33:   brk                         ; 1DA33:  00
b07_9a34:   brk                         ; 1DA34:  00
b07_9a35:   tax                         ; 1DA35:  aa
b07_9a36:   inc $ffff,x                 ; 1DA36:  fe ff ff
b07_9a39:   .db $ff                     ; 1DA39:  ff
b07_9a3a:   .db $ff                     ; 1DA3A:  ff
b07_9a3b:   .db $ff                     ; 1DA3B:  ff
b07_9a3c:   dey                         ; 1DA3C:  88
b07_9a3d:   cmp $0000,x                 ; 1DA3D:  dd 00 00
b07_9a40:   brk                         ; 1DA40:  00
b07_9a41:   brk                         ; 1DA41:  00
b07_9a42:   brk                         ; 1DA42:  00
b07_9a43:   brk                         ; 1DA43:  00
b07_9a44:   .db $ff                     ; 1DA44:  ff
b07_9a45:   .db $ff                     ; 1DA45:  ff
b07_9a46:   .db $ff                     ; 1DA46:  ff
b07_9a47:   .db $ff                     ; 1DA47:  ff
b07_9a48:   .db $ff                     ; 1DA48:  ff
b07_9a49:   .db $f7                     ; 1DA49:  f7
b07_9a4a:   .db $ef                     ; 1DA4A:  ef
b07_9a4b:   .db $cf                     ; 1DA4B:  cf
b07_9a4c:   brk                         ; 1DA4C:  00
b07_9a4d:   brk                         ; 1DA4D:  00
b07_9a4e:   brk                         ; 1DA4E:  00
b07_9a4f:   brk                         ; 1DA4F:  00
b07_9a50:   brk                         ; 1DA50:  00
b07_9a51:   php                         ; 1DA51:  08
b07_9a52:   bpl $9a84                   ; 1DA52:  10 30
b07_9a54:   .db $ff                     ; 1DA54:  ff
b07_9a55:   .db $ff                     ; 1DA55:  ff
b07_9a56:   .db $ff                     ; 1DA56:  ff
b07_9a57:   .db $ff                     ; 1DA57:  ff
b07_9a58:   .db $ff                     ; 1DA58:  ff
b07_9a59:   .db $ff                     ; 1DA59:  ff
b07_9a5a:   .db $ff                     ; 1DA5A:  ff
b07_9a5b:   .db $d7                     ; 1DA5B:  d7
b07_9a5c:   brk                         ; 1DA5C:  00
b07_9a5d:   brk                         ; 1DA5D:  00
b07_9a5e:   brk                         ; 1DA5E:  00
b07_9a5f:   brk                         ; 1DA5F:  00
b07_9a60:   brk                         ; 1DA60:  00
b07_9a61:   brk                         ; 1DA61:  00
b07_9a62:   brk                         ; 1DA62:  00
b07_9a63:   brk                         ; 1DA63:  00
b07_9a64:   brk                         ; 1DA64:  00
b07_9a65:   tax                         ; 1DA65:  aa
b07_9a66:   brk                         ; 1DA66:  00
b07_9a67:   tax                         ; 1DA67:  aa
b07_9a68:   cpy #$ea                    ; 1DA68:  c0 ea
b07_9a6a:   beq $9a66                   ; 1DA6A:  f0 fa
b07_9a6c:   dey                         ; 1DA6C:  88
b07_9a6d:   cmp $7722,x                 ; 1DA6D:  dd 22 77
b07_9a70:   php                         ; 1DA70:  08
b07_9a71:   ora $0702,x                 ; 1DA71:  1d 02 07
b07_9a74:   sed                         ; 1DA74:  f8
b07_9a75:   .db $fc                     ; 1DA75:  fc
b07_9a76:   .db $fc                     ; 1DA76:  fc
b07_9a77:   .db $fc                     ; 1DA77:  fc
b07_9a78:   sed                         ; 1DA78:  f8
b07_9a79:   cpx #$00                    ; 1DA79:  e0 00
b07_9a7b:   .db $80                     ; 1DA7B:  80
b07_9a7c:   brk                         ; 1DA7C:  00
b07_9a7d:   ora ($00,x)                 ; 1DA7D:  01 00
b07_9a7f:   brk                         ; 1DA7F:  00
b07_9a80:   brk                         ; 1DA80:  00
b07_9a81:   brk                         ; 1DA81:  00
b07_9a82:   brk                         ; 1DA82:  00
b07_9a83:   brk                         ; 1DA83:  00
b07_9a84:   .db $03                     ; 1DA84:  03
b07_9a85:   .db $80                     ; 1DA85:  80
b07_9a86:   brk                         ; 1DA86:  00
b07_9a87:   .db $80                     ; 1DA87:  80
b07_9a88:   ora ($86,x)                 ; 1DA88:  01 86
b07_9a8a:   asl $84                     ; 1DA8A:  06 84
b07_9a8c:   .db $80                     ; 1DA8C:  80
b07_9a8d:   cld                         ; 1DA8D:  d8
b07_9a8e:   .db $1c                     ; 1DA8E:  1c
b07_9a8f:   bvc $9a2a                   ; 1DA8F:  50 99
b07_9a91:   lda $3b39,y                 ; 1DA91:  b9 39 3b
b07_9a94:   .db $04                     ; 1DA94:  04
b07_9a95:   .db $80                     ; 1DA95:  80
b07_9a96:   brk                         ; 1DA96:  00
b07_9a97:   .db $80                     ; 1DA97:  80
b07_9a98:   brk                         ; 1DA98:  00
b07_9a99:   .db $80                     ; 1DA99:  80
b07_9a9a:   brk                         ; 1DA9A:  00
b07_9a9b:   .db $80                     ; 1DA9B:  80
b07_9a9c:   .db $bb                     ; 1DA9C:  bb
b07_9a9d:   ldx $5e3e,y                 ; 1DA9D:  be 3e 5e
b07_9aa0:   .db $9f                     ; 1DAA0:  9f
b07_9aa1:   dec $4910,x                 ; 1DAA1:  de 10 49
b07_9aa4:   inc $60d0,x                 ; 1DAA4:  fe d0 60
b07_9aa7:   bvs $9ae2                   ; 1DAA7:  70 39
b07_9aa9:   sei                         ; 1DAA9:  78
b07_9aaa:   ror $00ff,x                 ; 1DAAA:  7e ff 00
b07_9aad:   brk                         ; 1DAAD:  00
b07_9aae:   brk                         ; 1DAAE:  00
b07_9aaf:   .db $0c                     ; 1DAAF:  0c
b07_9ab0:   .db $07                     ; 1DAB0:  07
b07_9ab1:   ora $80                     ; 1DAB1:  05 80
b07_9ab3:   brk                         ; 1DAB3:  00
b07_9ab4:   .db $07                     ; 1DAB4:  07
b07_9ab5:   .db $1b                     ; 1DAB5:  1b
b07_9ab6:   .db $3f                     ; 1DAB6:  3f
b07_9ab7:   .db $07                     ; 1DAB7:  07
b07_9ab8:   .db $2f                     ; 1DAB8:  2f
b07_9ab9:   .db $ff                     ; 1DAB9:  ff
b07_9aba:   .db $3f                     ; 1DABA:  3f
b07_9abb:   .db $ff                     ; 1DABB:  ff
b07_9abc:   brk                         ; 1DABC:  00
b07_9abd:   rts                         ; 1DABD:  60
b07_9abe:   cpy #$00                    ; 1DABE:  c0 00
b07_9ac0:   jsr $c000                   ; 1DAC0:  20 00 c0
b07_9ac3:   brk                         ; 1DAC3:  00
b07_9ac4:   .db $ff                     ; 1DAC4:  ff
b07_9ac5:   .db $f7                     ; 1DAC5:  f7
b07_9ac6:   .db $fb                     ; 1DAC6:  fb
b07_9ac7:   cmp ($0c,x)                 ; 1DAC7:  c1 0c
b07_9ac9:   .db $0b                     ; 1DAC9:  0b
b07_9aca:   ora ($20,x)                 ; 1DACA:  01 20
b07_9acc:   brk                         ; 1DACC:  00
b07_9acd:   brk                         ; 1DACD:  00
b07_9ace:   .db $04                     ; 1DACE:  04
b07_9acf:   asl $13                     ; 1DACF:  06 13
b07_9ad1:   rti                         ; 1DAD1:  40
b07_9ad2:   rts                         ; 1DAD2:  60
b07_9ad3:   brk                         ; 1DAD3:  00
b07_9ad4:   .db $ff                     ; 1DAD4:  ff
b07_9ad5:   .db $ff                     ; 1DAD5:  ff
b07_9ad6:   .db $ff                     ; 1DAD6:  ff
b07_9ad7:   .db $ff                     ; 1DAD7:  ff
b07_9ad8:   .db $ff                     ; 1DAD8:  ff
b07_9ad9:   ror $3eff,x                 ; 1DAD9:  7e ff 3e
b07_9adc:   brk                         ; 1DADC:  00
b07_9add:   brk                         ; 1DADD:  00
b07_9ade:   brk                         ; 1DADE:  00
b07_9adf:   brk                         ; 1DADF:  00
b07_9ae0:   brk                         ; 1DAE0:  00
b07_9ae1:   .db $80                     ; 1DAE1:  80
b07_9ae2:   brk                         ; 1DAE2:  00
b07_9ae3:   brk                         ; 1DAE3:  00
b07_9ae4:   .db $80                     ; 1DAE4:  80
b07_9ae5:   cpy #$c0                    ; 1DAE5:  c0 c0
b07_9ae7:   cpy #$c7                    ; 1DAE7:  c0 c7
b07_9ae9:   cmp #$d1                    ; 1DAE9:  c9 d1
b07_9aeb:   cmp ($00,x)                 ; 1DAEB:  c1 00
b07_9aed:   brk                         ; 1DAED:  00
b07_9aee:   brk                         ; 1DAEE:  00
b07_9aef:   brk                         ; 1DAEF:  00
b07_9af0:   brk                         ; 1DAF0:  00
b07_9af1:   brk                         ; 1DAF1:  00
b07_9af2:   brk                         ; 1DAF2:  00
b07_9af3:   .db $1a                     ; 1DAF3:  1a
b07_9af4:   brk                         ; 1DAF4:  00
b07_9af5:   tax                         ; 1DAF5:  aa
b07_9af6:   brk                         ; 1DAF6:  00
b07_9af7:   tax                         ; 1DAF7:  aa
b07_9af8:   brk                         ; 1DAF8:  00
b07_9af9:   rol a                       ; 1DAF9:  2a
b07_9afa:   brk                         ; 1DAFA:  00
b07_9afb:   rol a                       ; 1DAFB:  2a
b07_9afc:   dey                         ; 1DAFC:  88
b07_9afd:   cmp $7722,x                 ; 1DAFD:  dd 22 77
b07_9b00:   php                         ; 1DB00:  08
b07_9b01:   eor $7722,x                 ; 1DB01:  5d 22 77
b07_9b04:   sta ($c2,x)                 ; 1DB04:  81 c2
b07_9b06:   sty $48                     ; 1DB06:  84 48
b07_9b08:   brk                         ; 1DB08:  00
b07_9b09:   .db $80                     ; 1DB09:  80
b07_9b0a:   bvc $9a8e                   ; 1DB0A:  50 82
b07_9b0c:   .db $1a                     ; 1DB0C:  1a
b07_9b0d:   .db $04                     ; 1DB0D:  04
b07_9b0e:   clc                         ; 1DB0E:  18
b07_9b0f:   ora ($02,x)                 ; 1DB0F:  01 02
b07_9b11:   ora ($02,x)                 ; 1DB11:  01 02
b07_9b13:   .db $03                     ; 1DB13:  03
b07_9b14:   brk                         ; 1DB14:  00
b07_9b15:   tax                         ; 1DB15:  aa
b07_9b16:   brk                         ; 1DB16:  00
b07_9b17:   tax                         ; 1DB17:  aa
b07_9b18:   brk                         ; 1DB18:  00
b07_9b19:   tax                         ; 1DB19:  aa
b07_9b1a:   brk                         ; 1DB1A:  00
b07_9b1b:   tax                         ; 1DB1B:  aa
b07_9b1c:   php                         ; 1DB1C:  08
b07_9b1d:   cmp $7722,x                 ; 1DB1D:  dd 22 77
b07_9b20:   dey                         ; 1DB20:  88
b07_9b21:   cmp $7722,x                 ; 1DB21:  dd 22 77
b07_9b24:   brk                         ; 1DB24:  00
b07_9b25:   tax                         ; 1DB25:  aa
b07_9b26:   brk                         ; 1DB26:  00
b07_9b27:   tax                         ; 1DB27:  aa
b07_9b28:   brk                         ; 1DB28:  00
b07_9b29:   tax                         ; 1DB29:  aa
b07_9b2a:   brk                         ; 1DB2A:  00
b07_9b2b:   ldy #$88                    ; 1DB2B:  a0 88
b07_9b2d:   cmp $7722,x                 ; 1DB2D:  dd 22 77
b07_9b30:   dey                         ; 1DB30:  88
b07_9b31:   cmp $6022,x                 ; 1DB31:  dd 22 60
b07_9b34:   brk                         ; 1DB34:  00
b07_9b35:   .db $80                     ; 1DB35:  80
b07_9b36:   brk                         ; 1DB36:  00
b07_9b37:   ldy #$00                    ; 1DB37:  a0 00
b07_9b39:   tay                         ; 1DB39:  a8
b07_9b3a:   brk                         ; 1DB3A:  00
b07_9b3b:   .db $22                     ; 1DB3B:  22
b07_9b3c:   .db $af                     ; 1DB3C:  af
b07_9b3d:   .db $cf                     ; 1DB3D:  cf
b07_9b3e:   .db $27                     ; 1DB3E:  27
b07_9b3f:   .db $77                     ; 1DB3F:  77
b07_9b40:   .db $8b                     ; 1DB40:  8b
b07_9b41:   cmp $0000,y                 ; 1DB41:  d9 00 00
b07_9b44:   asl a                       ; 1DB44:  0a
b07_9b45:   ror a                       ; 1DB45:  6a
b07_9b46:   tsx                         ; 1DB46:  ba
b07_9b47:   inc $eebb                   ; 1DB47:  ee bb ee
b07_9b4a:   .db $bb                     ; 1DB4A:  bb
b07_9b4b:   inc $4000                   ; 1DB4B:  ee 00 40
b07_9b4e:   bpl $9b94                   ; 1DB4E:  10 44
b07_9b50:   ora ($44),y                 ; 1DB50:  11 44
b07_9b52:   ora ($44),y                 ; 1DB52:  11 44
b07_9b54:   .db $80                     ; 1DB54:  80
b07_9b55:   .db $82                     ; 1DB55:  82
b07_9b56:   dey                         ; 1DB56:  88
b07_9b57:   ldx #$88                    ; 1DB57:  a2 88
b07_9b59:   .db $22                     ; 1DB59:  22
b07_9b5a:   php                         ; 1DB5A:  08
b07_9b5b:   .db $22                     ; 1DB5B:  22
b07_9b5c:   brk                         ; 1DB5C:  00
b07_9b5d:   .db $02                     ; 1DB5D:  02
b07_9b5e:   brk                         ; 1DB5E:  00
b07_9b5f:   .db $02                     ; 1DB5F:  02
b07_9b60:   brk                         ; 1DB60:  00
b07_9b61:   .db $02                     ; 1DB61:  02
b07_9b62:   brk                         ; 1DB62:  00
b07_9b63:   .db $02                     ; 1DB63:  02
b07_9b64:   sbc $0fff,y                 ; 1DB64:  f9 ff 0f
b07_9b67:   .db $07                     ; 1DB67:  07
b07_9b68:   .db $1f                     ; 1DB68:  1f
b07_9b69:   .db $7f                     ; 1DB69:  7f
b07_9b6a:   .db $7f                     ; 1DB6A:  7f
b07_9b6b:   rol $0000,x                 ; 1DB6B:  3e 00 00
b07_9b6e:   .db $80                     ; 1DB6E:  80
b07_9b6f:   beq $9b51                   ; 1DB6F:  f0 e0
b07_9b71:   .db $80                     ; 1DB71:  80
b07_9b72:   .db $80                     ; 1DB72:  80
b07_9b73:   cpy #$5f                    ; 1DB73:  c0 5f
b07_9b75:   .db $fc                     ; 1DB75:  fc
b07_9b76:   .db $fa                     ; 1DB76:  fa
b07_9b77:   .db $fc                     ; 1DB77:  fc
b07_9b78:   sed                         ; 1DB78:  f8
b07_9b79:   sbc ($c3),y                 ; 1DB79:  f1 c3
b07_9b7b:   .db $07                     ; 1DB7B:  07
b07_9b7c:   brk                         ; 1DB7C:  00
b07_9b7d:   brk                         ; 1DB7D:  00
b07_9b7e:   brk                         ; 1DB7E:  00
b07_9b7f:   brk                         ; 1DB7F:  00
b07_9b80:   ora ($02,x)                 ; 1DB80:  01 02
b07_9b82:   .db $04                     ; 1DB82:  04
b07_9b83:   clc                         ; 1DB83:  18
b07_9b84:   brk                         ; 1DB84:  00
b07_9b85:   brk                         ; 1DB85:  00
b07_9b86:   .db $80                     ; 1DB86:  80
b07_9b87:   .db $80                     ; 1DB87:  80
b07_9b88:   sta ($41,x)                 ; 1DB88:  81 41
b07_9b8a:   .db $c3                     ; 1DB8A:  c3
b07_9b8b:   .db $63                     ; 1DB8B:  63
b07_9b8c:   brk                         ; 1DB8C:  00
b07_9b8d:   .db $1f                     ; 1DB8D:  1f
b07_9b8e:   sta $bf                     ; 1DB8E:  85 bf
b07_9b90:   ldx $dd5e,y                 ; 1DB90:  be 5e dd
b07_9b93:   .db $6f                     ; 1DB93:  6f
b07_9b94:   .db $0f                     ; 1DB94:  0f
b07_9b95:   rol $f91c,x                 ; 1DB95:  3e 1c f9
b07_9b98:   sbc ($e7),y                 ; 1DB98:  f1 e7
b07_9b9a:   cmp $7117                   ; 1DB9A:  cd 17 71
b07_9b9d:   dec $ec                     ; 1DB9D:  c6 ec
b07_9b9f:   ora $6731,y                 ; 1DB9F:  19 31 67
b07_9ba2:   cmp $1817                   ; 1DBA2:  cd 17 18
b07_9ba5:   asl a                       ; 1DBA5:  0a
b07_9ba6:   bmi $9bfa                   ; 1DBA6:  30 52
b07_9ba8:   ror a                       ; 1DBA8:  6a
b07_9ba9:   .db $c3                     ; 1DBA9:  c3
b07_9baa:   .db $da                     ; 1DBAA:  da
b07_9bab:   .db $93                     ; 1DBAB:  93
b07_9bac:   brk                         ; 1DBAC:  00
b07_9bad:   ora ($00,x)                 ; 1DBAD:  01 00
b07_9baf:   brk                         ; 1DBAF:  00
b07_9bb0:   php                         ; 1DBB0:  08
b07_9bb1:   ora ($58,x)                 ; 1DBB1:  01 58
b07_9bb3:   sta ($00),y                 ; 1DBB3:  91 00
b07_9bb5:   tax                         ; 1DBB5:  aa
b07_9bb6:   brk                         ; 1DBB6:  00
b07_9bb7:   tax                         ; 1DBB7:  aa
b07_9bb8:   brk                         ; 1DBB8:  00
b07_9bb9:   asl a                       ; 1DBB9:  0a
b07_9bba:   jsr $883a                   ; 1DBBA:  20 3a 88
b07_9bbd:   cmp $7722,x                 ; 1DBBD:  dd 22 77
b07_9bc0:   php                         ; 1DBC0:  08
b07_9bc1:   ora $1000,x                 ; 1DBC1:  1d 00 10
b07_9bc4:   asl $73,x                   ; 1DBC4:  16 73
b07_9bc6:   dec $73,x                   ; 1DBC6:  d6 73
b07_9bc8:   dec $73,x                   ; 1DBC8:  d6 73
b07_9bca:   dec $146b                   ; 1DBCA:  ce 6b 14
b07_9bcd:   adc ($d4),y                 ; 1DBCD:  71 d4
b07_9bcf:   adc ($d4),y                 ; 1DBCF:  71 d4
b07_9bd1:   adc ($c4),y                 ; 1DBD1:  71 c4
b07_9bd3:   adc ($ae,x)                 ; 1DBD3:  61 ae
b07_9bd5:   tsx                         ; 1DBD5:  ba
b07_9bd6:   ldx $aeba                   ; 1DBD6:  ae ba ae
b07_9bd9:   tsx                         ; 1DBD9:  ba
b07_9bda:   ldx $04ba                   ; 1DBDA:  ae ba 04
b07_9bdd:   bpl $9be3                   ; 1DBDD:  10 04
b07_9bdf:   bpl $9be5                   ; 1DBDF:  10 04
b07_9be1:   bpl $9be7                   ; 1DBE1:  10 04
b07_9be3:   bpl $9be5                   ; 1DBE3:  10 00
b07_9be5:   brk                         ; 1DBE5:  00
b07_9be6:   brk                         ; 1DBE6:  00
b07_9be7:   brk                         ; 1DBE7:  00
b07_9be8:   brk                         ; 1DBE8:  00
b07_9be9:   brk                         ; 1DBE9:  00
b07_9bea:   brk                         ; 1DBEA:  00
b07_9beb:   brk                         ; 1DBEB:  00
b07_9bec:   tax                         ; 1DBEC:  aa
b07_9bed:   tax                         ; 1DBED:  aa
b07_9bee:   tax                         ; 1DBEE:  aa
b07_9bef:   tax                         ; 1DBEF:  aa
b07_9bf0:   tax                         ; 1DBF0:  aa
b07_9bf1:   tax                         ; 1DBF1:  aa
b07_9bf2:   tax                         ; 1DBF2:  aa
b07_9bf3:   tax                         ; 1DBF3:  aa
b07_9bf4:   brk                         ; 1DBF4:  00
b07_9bf5:   brk                         ; 1DBF5:  00
b07_9bf6:   brk                         ; 1DBF6:  00
b07_9bf7:   brk                         ; 1DBF7:  00
b07_9bf8:   brk                         ; 1DBF8:  00
b07_9bf9:   brk                         ; 1DBF9:  00
b07_9bfa:   brk                         ; 1DBFA:  00
b07_9bfb:   brk                         ; 1DBFB:  00
b07_9bfc:   tax                         ; 1DBFC:  aa
b07_9bfd:   tax                         ; 1DBFD:  aa
b07_9bfe:   tax                         ; 1DBFE:  aa
b07_9bff:   tax                         ; 1DBFF:  aa
b07_9c00:   tax                         ; 1DC00:  aa
b07_9c01:   tax                         ; 1DC01:  aa
b07_9c02:   lda #$a3                    ; 1DC02:  a9 a3
b07_9c04:   brk                         ; 1DC04:  00
b07_9c05:   brk                         ; 1DC05:  00
b07_9c06:   brk                         ; 1DC06:  00
b07_9c07:   brk                         ; 1DC07:  00
b07_9c08:   brk                         ; 1DC08:  00
b07_9c09:   brk                         ; 1DC09:  00
b07_9c0a:   brk                         ; 1DC0A:  00
b07_9c0b:   brk                         ; 1DC0B:  00
b07_9c0c:   .db $a7                     ; 1DC0C:  a7
b07_9c0d:   .db $a7                     ; 1DC0D:  a7
b07_9c0e:   .db $af                     ; 1DC0E:  af
b07_9c0f:   .db $af                     ; 1DC0F:  af
b07_9c10:   .db $af                     ; 1DC10:  af
b07_9c11:   .db $9f                     ; 1DC11:  9f
b07_9c12:   .db $9f                     ; 1DC12:  9f
b07_9c13:   .db $9f                     ; 1DC13:  9f
b07_9c14:   brk                         ; 1DC14:  00
b07_9c15:   brk                         ; 1DC15:  00
b07_9c16:   brk                         ; 1DC16:  00
b07_9c17:   .db $03                     ; 1DC17:  03
b07_9c18:   .db $03                     ; 1DC18:  03
b07_9c19:   .db $07                     ; 1DC19:  07
b07_9c1a:   .db $07                     ; 1DC1A:  07
b07_9c1b:   .db $0f                     ; 1DC1B:  0f
b07_9c1c:   tax                         ; 1DC1C:  aa
b07_9c1d:   tay                         ; 1DC1D:  a8
b07_9c1e:   .db $a7                     ; 1DC1E:  a7
b07_9c1f:   .db $9c                     ; 1DC1F:  9c
b07_9c20:   .db $7c                     ; 1DC20:  7c
b07_9c21:   sed                         ; 1DC21:  f8
b07_9c22:   sed                         ; 1DC22:  f8
b07_9c23:   beq $9c25                   ; 1DC23:  f0 00
b07_9c25:   brk                         ; 1DC25:  00
b07_9c26:   .db $fc                     ; 1DC26:  fc
b07_9c27:   .db $ff                     ; 1DC27:  ff
b07_9c28:   .db $ff                     ; 1DC28:  ff
b07_9c29:   .db $ff                     ; 1DC29:  ff
b07_9c2a:   .db $ff                     ; 1DC2A:  ff
b07_9c2b:   .db $ff                     ; 1DC2B:  ff
b07_9c2c:   tay                         ; 1DC2C:  a8
b07_9c2d:   tay                         ; 1DC2D:  a8
b07_9c2e:   brk                         ; 1DC2E:  00
b07_9c2f:   brk                         ; 1DC2F:  00
b07_9c30:   brk                         ; 1DC30:  00
b07_9c31:   brk                         ; 1DC31:  00
b07_9c32:   brk                         ; 1DC32:  00
b07_9c33:   brk                         ; 1DC33:  00
b07_9c34:   .db $0f                     ; 1DC34:  0f
b07_9c35:   .db $0f                     ; 1DC35:  0f
b07_9c36:   .db $0f                     ; 1DC36:  0f
b07_9c37:   .db $0f                     ; 1DC37:  0f
b07_9c38:   .db $0f                     ; 1DC38:  0f
b07_9c39:   asl $0301                   ; 1DC39:  0e 01 03
b07_9c3c:   beq $9c2e                   ; 1DC3C:  f0 f0
b07_9c3e:   beq $9c30                   ; 1DC3E:  f0 f0
b07_9c40:   beq $9c33                   ; 1DC40:  f0 f1
b07_9c42:   .db $fa                     ; 1DC42:  fa
b07_9c43:   .db $f4                     ; 1DC43:  f4
b07_9c44:   .db $ff                     ; 1DC44:  ff
b07_9c45:   .db $ff                     ; 1DC45:  ff
b07_9c46:   .db $ff                     ; 1DC46:  ff
b07_9c47:   .db $ff                     ; 1DC47:  ff
b07_9c48:   .db $ff                     ; 1DC48:  ff
b07_9c49:   .db $7f                     ; 1DC49:  7f
b07_9c4a:   .db $ff                     ; 1DC4A:  ff
b07_9c4b:   .db $ff                     ; 1DC4B:  ff
b07_9c4c:   brk                         ; 1DC4C:  00
b07_9c4d:   brk                         ; 1DC4D:  00
b07_9c4e:   brk                         ; 1DC4E:  00
b07_9c4f:   brk                         ; 1DC4F:  00
b07_9c50:   brk                         ; 1DC50:  00
b07_9c51:   .db $80                     ; 1DC51:  80
b07_9c52:   brk                         ; 1DC52:  00
b07_9c53:   brk                         ; 1DC53:  00
b07_9c54:   brk                         ; 1DC54:  00
b07_9c55:   brk                         ; 1DC55:  00
b07_9c56:   brk                         ; 1DC56:  00
b07_9c57:   .db $80                     ; 1DC57:  80
b07_9c58:   cpx #$f0                    ; 1DC58:  e0 f0
b07_9c5a:   sed                         ; 1DC5A:  f8
b07_9c5b:   sed                         ; 1DC5B:  f8
b07_9c5c:   rol a                       ; 1DC5C:  2a
b07_9c5d:   rol a                       ; 1DC5D:  2a
b07_9c5e:   rol a                       ; 1DC5E:  2a
b07_9c5f:   asl a                       ; 1DC5F:  0a
b07_9c60:   asl a                       ; 1DC60:  0a
b07_9c61:   .db $02                     ; 1DC61:  02
b07_9c62:   .db $02                     ; 1DC62:  02
b07_9c63:   .db $02                     ; 1DC63:  02
b07_9c64:   sed                         ; 1DC64:  f8
b07_9c65:   sed                         ; 1DC65:  f8
b07_9c66:   beq $9c48                   ; 1DC66:  f0 e0
b07_9c68:   .db $80                     ; 1DC68:  80
b07_9c69:   cpx #$f0                    ; 1DC69:  e0 f0
b07_9c6b:   beq $9c6f                   ; 1DC6B:  f0 02
b07_9c6d:   brk                         ; 1DC6D:  00
b07_9c6e:   brk                         ; 1DC6E:  00
b07_9c6f:   brk                         ; 1DC6F:  00
b07_9c70:   brk                         ; 1DC70:  00
b07_9c71:   brk                         ; 1DC71:  00
b07_9c72:   brk                         ; 1DC72:  00
b07_9c73:   brk                         ; 1DC73:  00
b07_9c74:   brk                         ; 1DC74:  00
b07_9c75:   brk                         ; 1DC75:  00
b07_9c76:   brk                         ; 1DC76:  00
b07_9c77:   brk                         ; 1DC77:  00
b07_9c78:   brk                         ; 1DC78:  00
b07_9c79:   .db $02                     ; 1DC79:  02
b07_9c7a:   brk                         ; 1DC7A:  00
b07_9c7b:   .db $02                     ; 1DC7B:  02
b07_9c7c:   .db $9f                     ; 1DC7C:  9f
b07_9c7d:   .db $87                     ; 1DC7D:  87
b07_9c7e:   .db $93                     ; 1DC7E:  93
b07_9c7f:   sta $aa90,y                 ; 1DC7F:  99 90 aa
b07_9c82:   .db $af                     ; 1DC82:  af
b07_9c83:   ldy $0606                   ; 1DC83:  ac 06 06
b07_9c86:   asl $02                     ; 1DC86:  06 02
b07_9c88:   brk                         ; 1DC88:  00
b07_9c89:   brk                         ; 1DC89:  00
b07_9c8a:   brk                         ; 1DC8A:  00
b07_9c8b:   brk                         ; 1DC8B:  00
b07_9c8c:   tay                         ; 1DC8C:  a8
b07_9c8d:   lda #$a9                    ; 1DC8D:  a9 a9
b07_9c8f:   lda $afaf                   ; 1DC8F:  ad af af
b07_9c92:   .db $a7                     ; 1DC92:  a7
b07_9c93:   .db $a7                     ; 1DC93:  a7
b07_9c94:   .db $07                     ; 1DC94:  07
b07_9c95:   .db $8f                     ; 1DC95:  8f
b07_9c96:   .db $8f                     ; 1DC96:  8f
b07_9c97:   .db $80                     ; 1DC97:  80
b07_9c98:   brk                         ; 1DC98:  00
b07_9c99:   ora ($10,x)                 ; 1DC99:  01 10
b07_9c9b:   sec                         ; 1DC9B:  38
b07_9c9c:   sed                         ; 1DC9C:  f8
b07_9c9d:   bvs $9cff                   ; 1DC9D:  70 60
b07_9c9f:   bvs $9d01                   ; 1DC9F:  70 60
b07_9ca1:   and ($2c),y                 ; 1DCA1:  31 2c
b07_9ca3:   lsr $c7                     ; 1DCA3:  46 c7
b07_9ca5:   .db $8f                     ; 1DCA5:  8f
b07_9ca6:   .db $1f                     ; 1DCA6:  1f
b07_9ca7:   .db $37                     ; 1DCA7:  37
b07_9ca8:   .db $0f                     ; 1DCA8:  0f
b07_9ca9:   .db $9f                     ; 1DCA9:  9f
b07_9caa:   .db $ff                     ; 1DCAA:  ff
b07_9cab:   .db $7f                     ; 1DCAB:  7f
b07_9cac:   brk                         ; 1DCAC:  00
b07_9cad:   brk                         ; 1DCAD:  00
b07_9cae:   jsr $00c0                   ; 1DCAE:  20 c0 00
b07_9cb1:   .db $80                     ; 1DCB1:  80
b07_9cb2:   brk                         ; 1DCB2:  00
b07_9cb3:   .db $80                     ; 1DCB3:  80
b07_9cb4:   bmi $9ce6                   ; 1DCB4:  30 30
b07_9cb6:   .db $3c                     ; 1DCB6:  3c
b07_9cb7:   .db $3c                     ; 1DCB7:  3c
b07_9cb8:   bmi $9cbd                   ; 1DCB8:  30 03
b07_9cba:   .db $07                     ; 1DCBA:  07
b07_9cbb:   .db $0f                     ; 1DCBB:  0f
b07_9cbc:   .db $4f                     ; 1DCBC:  4f
b07_9cbd:   .db $4f                     ; 1DCBD:  4f
b07_9cbe:   eor ($40,x)                 ; 1DCBE:  41 40
b07_9cc0:   eor ($64,x)                 ; 1DCC0:  41 64
b07_9cc2:   dey                         ; 1DCC2:  88
b07_9cc3:   beq $9ce4                   ; 1DCC3:  f0 1f
b07_9cc5:   .db $ff                     ; 1DCC5:  ff
b07_9cc6:   .db $ff                     ; 1DCC6:  ff
b07_9cc7:   .db $ff                     ; 1DCC7:  ff
b07_9cc8:   .db $7f                     ; 1DCC8:  7f
b07_9cc9:   .db $1f                     ; 1DCC9:  1f
b07_9cca:   .db $8f                     ; 1DCCA:  8f
b07_9ccb:   .db $cf                     ; 1DCCB:  cf
b07_9ccc:   rti                         ; 1DCCC:  40
b07_9ccd:   brk                         ; 1DCCD:  00
b07_9cce:   brk                         ; 1DCCE:  00
b07_9ccf:   brk                         ; 1DCCF:  00
b07_9cd0:   brk                         ; 1DCD0:  00
b07_9cd1:   ldy #$70                    ; 1DCD1:  a0 70
b07_9cd3:   bmi $9cc5                   ; 1DCD3:  30 f0
b07_9cd5:   sed                         ; 1DCD5:  f8
b07_9cd6:   sed                         ; 1DCD6:  f8
b07_9cd7:   sed                         ; 1DCD7:  f8
b07_9cd8:   .db $fb                     ; 1DCD8:  fb
b07_9cd9:   .db $fc                     ; 1DCD9:  fc
b07_9cda:   sed                         ; 1DCDA:  f8
b07_9cdb:   sed                         ; 1DCDB:  f8
b07_9cdc:   brk                         ; 1DCDC:  00
b07_9cdd:   brk                         ; 1DCDD:  00
b07_9cde:   brk                         ; 1DCDE:  00
b07_9cdf:   brk                         ; 1DCDF:  00
b07_9ce0:   brk                         ; 1DCE0:  00
b07_9ce1:   brk                         ; 1DCE1:  00
b07_9ce2:   .db $04                     ; 1DCE2:  04
b07_9ce3:   .db $02                     ; 1DCE3:  02
b07_9ce4:   brk                         ; 1DCE4:  00
b07_9ce5:   brk                         ; 1DCE5:  00
b07_9ce6:   brk                         ; 1DCE6:  00
b07_9ce7:   brk                         ; 1DCE7:  00
b07_9ce8:   .db $80                     ; 1DCE8:  80
b07_9ce9:   .db $80                     ; 1DCE9:  80
b07_9cea:   .db $80                     ; 1DCEA:  80
b07_9ceb:   .db $80                     ; 1DCEB:  80
b07_9cec:   tax                         ; 1DCEC:  aa
b07_9ced:   tax                         ; 1DCED:  aa
b07_9cee:   tax                         ; 1DCEE:  aa
b07_9cef:   rol a                       ; 1DCEF:  2a
b07_9cf0:   rol a                       ; 1DCF0:  2a
b07_9cf1:   rol a                       ; 1DCF1:  2a
b07_9cf2:   rol a                       ; 1DCF2:  2a
b07_9cf3:   rol a                       ; 1DCF3:  2a
b07_9cf4:   sbc $fff9,y                 ; 1DCF4:  f9 f9 ff
b07_9cf7:   inc $f0,x                   ; 1DCF7:  f6 f0
b07_9cf9:   beq $9cef                   ; 1DCF9:  f0 f4
b07_9cfb:   inc $04                     ; 1DCFB:  e6 04
b07_9cfd:   brk                         ; 1DCFD:  00
b07_9cfe:   brk                         ; 1DCFE:  00
b07_9cff:   brk                         ; 1DCFF:  00
b07_9d00:   brk                         ; 1DD00:  00
b07_9d01:   .db $02                     ; 1DD01:  02
b07_9d02:   .db $04                     ; 1DD02:  04
b07_9d03:   .db $04                     ; 1DD03:  04
b07_9d04:   .db $80                     ; 1DD04:  80
b07_9d05:   .db $80                     ; 1DD05:  80
b07_9d06:   brk                         ; 1DD06:  00
b07_9d07:   brk                         ; 1DD07:  00
b07_9d08:   brk                         ; 1DD08:  00
b07_9d09:   brk                         ; 1DD09:  00
b07_9d0a:   brk                         ; 1DD0A:  00
b07_9d0b:   brk                         ; 1DD0B:  00
b07_9d0c:   rol a                       ; 1DD0C:  2a
b07_9d0d:   rol a                       ; 1DD0D:  2a
b07_9d0e:   rol a                       ; 1DD0E:  2a
b07_9d0f:   tax                         ; 1DD0F:  aa
b07_9d10:   tax                         ; 1DD10:  aa
b07_9d11:   tax                         ; 1DD11:  aa
b07_9d12:   tax                         ; 1DD12:  aa
b07_9d13:   tax                         ; 1DD13:  aa
b07_9d14:   brk                         ; 1DD14:  00
b07_9d15:   brk                         ; 1DD15:  00
b07_9d16:   brk                         ; 1DD16:  00
b07_9d17:   brk                         ; 1DD17:  00
b07_9d18:   brk                         ; 1DD18:  00
b07_9d19:   ora ($dc,x)                 ; 1DD19:  01 dc
b07_9d1b:   .db $77                     ; 1DD1B:  77
b07_9d1c:   tax                         ; 1DD1C:  aa
b07_9d1d:   tax                         ; 1DD1D:  aa
b07_9d1e:   tax                         ; 1DD1E:  aa
b07_9d1f:   tax                         ; 1DD1F:  aa
b07_9d20:   tax                         ; 1DD20:  aa
b07_9d21:   brk                         ; 1DD21:  00
b07_9d22:   bpl $9d68                   ; 1DD22:  10 44
b07_9d24:   brk                         ; 1DD24:  00
b07_9d25:   brk                         ; 1DD25:  00
b07_9d26:   brk                         ; 1DD26:  00
b07_9d27:   brk                         ; 1DD27:  00
b07_9d28:   .db $04                     ; 1DD28:  04
b07_9d29:   .db $32                     ; 1DD29:  32
b07_9d2a:   cpy $a732                   ; 1DD2A:  cc 32 a7
b07_9d2d:   .db $ab                     ; 1DD2D:  ab
b07_9d2e:   .db $ab                     ; 1DD2E:  ab
b07_9d2f:   lda #$00                    ; 1DD2F:  a9 00
b07_9d31:   brk                         ; 1DD31:  00
b07_9d32:   brk                         ; 1DD32:  00
b07_9d33:   brk                         ; 1DD33:  00
b07_9d34:   eor $5d77,x                 ; 1DD34:  5d 77 5d
b07_9d37:   .db $77                     ; 1DD37:  77
b07_9d38:   ora $1d37,x                 ; 1DD38:  1d 37 1d
b07_9d3b:   .db $17                     ; 1DD3B:  17
b07_9d3c:   ora ($44),y                 ; 1DD3C:  11 44
b07_9d3e:   ora ($44),y                 ; 1DD3E:  11 44
b07_9d40:   sta ($84),y                 ; 1DD40:  91 84
b07_9d42:   cmp ($c4),y                 ; 1DD42:  d1 c4
b07_9d44:   cpy $cc71                   ; 1DD44:  cc 71 cc
b07_9d47:   adc ($d9),y                 ; 1DD47:  71 d9
b07_9d49:   .db $73                     ; 1DD49:  73
b07_9d4a:   cmp $0073,y                 ; 1DD4A:  d9 73 00
b07_9d4d:   rti                         ; 1DD4D:  40
b07_9d4e:   brk                         ; 1DD4E:  00
b07_9d4f:   rti                         ; 1DD4F:  40
b07_9d50:   ora ($40),y                 ; 1DD50:  11 40
b07_9d52:   ora ($40),y                 ; 1DD52:  11 40
b07_9d54:   bpl $9d95                   ; 1DD54:  10 3f
b07_9d56:   .db $07                     ; 1DD56:  07
b07_9d57:   .db $03                     ; 1DD57:  03
b07_9d58:   .db $1f                     ; 1DD58:  1f
b07_9d59:   .db $1f                     ; 1DD59:  1f
b07_9d5a:   .db $1f                     ; 1DD5A:  1f
b07_9d5b:   .db $4f                     ; 1DD5B:  4f
b07_9d5c:   brk                         ; 1DD5C:  00
b07_9d5d:   .db $80                     ; 1DD5D:  80
b07_9d5e:   cpx #$f8                    ; 1DD5E:  e0 f8
b07_9d60:   cpx #$60                    ; 1DD60:  e0 60
b07_9d62:   jsr $4f50                   ; 1DD62:  20 50 4f
b07_9d65:   .db $0f                     ; 1DD65:  0f
b07_9d66:   .db $cf                     ; 1DD66:  cf
b07_9d67:   .db $ff                     ; 1DD67:  ff
b07_9d68:   inc $e1f8,x                 ; 1DD68:  fe f8 e1
b07_9d6b:   .db $03                     ; 1DD6B:  03
b07_9d6c:   bpl $9d7e                   ; 1DD6C:  10 10
b07_9d6e:   bpl $9d70                   ; 1DD6E:  10 00
b07_9d70:   brk                         ; 1DD70:  00
b07_9d71:   ora ($02,x)                 ; 1DD71:  01 02
b07_9d73:   .db $04                     ; 1DD73:  04
b07_9d74:   rti                         ; 1DD74:  40
b07_9d75:   rti                         ; 1DD75:  40
b07_9d76:   rti                         ; 1DD76:  40
b07_9d77:   rts                         ; 1DD77:  60
b07_9d78:   ldy #$20                    ; 1DD78:  a0 20
b07_9d7a:   ldy #$30                    ; 1DD7A:  a0 30
b07_9d7c:   rti                         ; 1DD7C:  40
b07_9d7d:   rti                         ; 1DD7D:  40
b07_9d7e:   .db $5f                     ; 1DD7E:  5f
b07_9d7f:   .db $7f                     ; 1DD7F:  7f
b07_9d80:   .db $3f                     ; 1DD80:  3f
b07_9d81:   .db $2f                     ; 1DD81:  2f
b07_9d82:   .db $2f                     ; 1DD82:  2f
b07_9d83:   .db $37                     ; 1DD83:  37
b07_9d84:   .db $07                     ; 1DD84:  07
b07_9d85:   asl $fb3d                   ; 1DD85:  0e 3d fb
b07_9d88:   .db $f7                     ; 1DD88:  f7
b07_9d89:   .db $4f                     ; 1DD89:  4f
b07_9d8a:   ora $1837,x                 ; 1DD8A:  1d 37 18
b07_9d8d:   bvs $9d50                   ; 1DD8D:  70 c1
b07_9d8f:   .db $03                     ; 1DD8F:  03
b07_9d90:   .db $07                     ; 1DD90:  07
b07_9d91:   ldy $b4d9                   ; 1DD91:  ac d9 b4
b07_9d94:   cpx $c7                     ; 1DD94:  e4 c7
b07_9d96:   sta $dd6f                   ; 1DD96:  8d 6f dd
b07_9d99:   .db $d7                     ; 1DD99:  d7
b07_9d9a:   lda $0477,x                 ; 1DD9A:  bd 77 04
b07_9d9d:   .db $04                     ; 1DD9D:  04
b07_9d9e:   ora #$0c                    ; 1DD9E:  09 0c
b07_9da0:   ora $3114,y                 ; 1DDA0:  19 14 31
b07_9da3:   .db $64                     ; 1DDA3:  64
b07_9da4:   brk                         ; 1DDA4:  00
b07_9da5:   brk                         ; 1DDA5:  00
b07_9da6:   brk                         ; 1DDA6:  00
b07_9da7:   brk                         ; 1DDA7:  00
b07_9da8:   tya                         ; 1DDA8:  98
b07_9da9:   .db $37                     ; 1DDA9:  37
b07_9daa:   eor $aa77,x                 ; 1DDAA:  5d 77 aa
b07_9dad:   rol a                       ; 1DDAD:  2a
b07_9dae:   rol a                       ; 1DDAE:  2a
b07_9daf:   .db $02                     ; 1DDAF:  02
b07_9db0:   brk                         ; 1DDB0:  00
b07_9db1:   brk                         ; 1DDB1:  00
b07_9db2:   ora ($44),y                 ; 1DDB2:  11 44
b07_9db4:   eor $dcf6,x                 ; 1DDB4:  5d f6 dc
b07_9db7:   ror $dd,x                   ; 1DDB7:  76 dd
b07_9db9:   adc $d9,x                   ; 1DDB9:  75 d9
b07_9dbb:   .db $73                     ; 1DDBB:  73
b07_9dbc:   eor ($c4),y                 ; 1DDBC:  51 c4
b07_9dbe:   bcc $9e04                   ; 1DDBE:  90 44
b07_9dc0:   ora ($44),y                 ; 1DDC0:  11 44
b07_9dc2:   ora ($40),y                 ; 1DDC2:  11 40
b07_9dc4:   eor $dd77,x                 ; 1DDC4:  5d 77 dd
b07_9dc7:   .db $77                     ; 1DDC7:  77
b07_9dc8:   cmp $dd77,x                 ; 1DDC8:  dd 77 dd
b07_9dcb:   .db $77                     ; 1DDCB:  77
b07_9dcc:   ora ($44),y                 ; 1DDCC:  11 44
b07_9dce:   ora ($44),y                 ; 1DDCE:  11 44
b07_9dd0:   ora ($44),y                 ; 1DDD0:  11 44
b07_9dd2:   ora ($44),y                 ; 1DDD2:  11 44
b07_9dd4:   brk                         ; 1DDD4:  00
b07_9dd5:   brk                         ; 1DDD5:  00
b07_9dd6:   brk                         ; 1DDD6:  00
b07_9dd7:   brk                         ; 1DDD7:  00
b07_9dd8:   brk                         ; 1DDD8:  00
b07_9dd9:   brk                         ; 1DDD9:  00
b07_9dda:   brk                         ; 1DDDA:  00
b07_9ddb:   brk                         ; 1DDDB:  00
b07_9ddc:   tax                         ; 1DDDC:  aa
b07_9ddd:   .db $ff                     ; 1DDDD:  ff
b07_9dde:   tax                         ; 1DDDE:  aa
b07_9ddf:   .db $ff                     ; 1DDDF:  ff
b07_9de0:   tax                         ; 1DDE0:  aa
b07_9de1:   .db $ff                     ; 1DDE1:  ff
b07_9de2:   tax                         ; 1DDE2:  aa
b07_9de3:   .db $ff                     ; 1DDE3:  ff
b07_9de4:   brk                         ; 1DDE4:  00
b07_9de5:   brk                         ; 1DDE5:  00
b07_9de6:   ora ($03,x)                 ; 1DDE6:  01 03
b07_9de8:   .db $07                     ; 1DDE8:  07
b07_9de9:   .db $0f                     ; 1DDE9:  0f
b07_9dea:   .db $0f                     ; 1DDEA:  0f
b07_9deb:   .db $0f                     ; 1DDEB:  0f
b07_9dec:   tax                         ; 1DDEC:  aa
b07_9ded:   inc $e0a8,x                 ; 1DDED:  fe a8 e0
b07_9df0:   .db $80                     ; 1DDF0:  80
b07_9df1:   .db $80                     ; 1DDF1:  80
b07_9df2:   .db $80                     ; 1DDF2:  80
b07_9df3:   brk                         ; 1DDF3:  00
b07_9df4:   brk                         ; 1DDF4:  00
b07_9df5:   brk                         ; 1DDF5:  00
b07_9df6:   brk                         ; 1DDF6:  00
b07_9df7:   brk                         ; 1DDF7:  00
b07_9df8:   brk                         ; 1DDF8:  00
b07_9df9:   brk                         ; 1DDF9:  00
b07_9dfa:   brk                         ; 1DDFA:  00
b07_9dfb:   brk                         ; 1DDFB:  00
b07_9dfc:   tax                         ; 1DDFC:  aa
b07_9dfd:   .db $ff                     ; 1DDFD:  ff
b07_9dfe:   tax                         ; 1DDFE:  aa
b07_9dff:   .db $ff                     ; 1DDFF:  ff
b07_9e00:   tax                         ; 1DE00:  aa
b07_9e01:   inc $feaa,x                 ; 1DE01:  fe aa fe
b07_9e04:   .db $0f                     ; 1DE04:  0f
b07_9e05:   .db $07                     ; 1DE05:  07
b07_9e06:   ora ($00,x)                 ; 1DE06:  01 00
b07_9e08:   brk                         ; 1DE08:  00
b07_9e09:   brk                         ; 1DE09:  00
b07_9e0a:   brk                         ; 1DE0A:  00
b07_9e0b:   ora ($00,x)                 ; 1DE0B:  01 00
b07_9e0d:   brk                         ; 1DE0D:  00
b07_9e0e:   brk                         ; 1DE0E:  00
b07_9e0f:   brk                         ; 1DE0F:  00
b07_9e10:   brk                         ; 1DE10:  00
b07_9e11:   brk                         ; 1DE11:  00
b07_9e12:   brk                         ; 1DE12:  00
b07_9e13:   brk                         ; 1DE13:  00
b07_9e14:   brk                         ; 1DE14:  00
b07_9e15:   .db $7f                     ; 1DE15:  7f
b07_9e16:   .db $ff                     ; 1DE16:  ff
b07_9e17:   .db $ff                     ; 1DE17:  ff
b07_9e18:   .db $ff                     ; 1DE18:  ff
b07_9e19:   .db $ff                     ; 1DE19:  ff
b07_9e1a:   .db $ff                     ; 1DE1A:  ff
b07_9e1b:   .db $ff                     ; 1DE1B:  ff
b07_9e1c:   tax                         ; 1DE1C:  aa
b07_9e1d:   brk                         ; 1DE1D:  00
b07_9e1e:   brk                         ; 1DE1E:  00
b07_9e1f:   brk                         ; 1DE1F:  00
b07_9e20:   brk                         ; 1DE20:  00
b07_9e21:   brk                         ; 1DE21:  00
b07_9e22:   brk                         ; 1DE22:  00
b07_9e23:   brk                         ; 1DE23:  00
b07_9e24:   brk                         ; 1DE24:  00
b07_9e25:   cpy #$f8                    ; 1DE25:  c0 f8
b07_9e27:   inc $ffff,x                 ; 1DE27:  fe ff ff
b07_9e2a:   .db $ff                     ; 1DE2A:  ff
b07_9e2b:   .db $ff                     ; 1DE2B:  ff
b07_9e2c:   tax                         ; 1DE2C:  aa
b07_9e2d:   .db $3c                     ; 1DE2D:  3c
b07_9e2e:   .db $07                     ; 1DE2E:  07
b07_9e2f:   ora ($00,x)                 ; 1DE2F:  01 00
b07_9e31:   brk                         ; 1DE31:  00
b07_9e32:   brk                         ; 1DE32:  00
b07_9e33:   brk                         ; 1DE33:  00
b07_9e34:   .db $ff                     ; 1DE34:  ff
b07_9e35:   .db $ff                     ; 1DE35:  ff
b07_9e36:   .db $ff                     ; 1DE36:  ff
b07_9e37:   .db $ff                     ; 1DE37:  ff
b07_9e38:   .db $7f                     ; 1DE38:  7f
b07_9e39:   .db $3f                     ; 1DE39:  3f
b07_9e3a:   sta $60,x                   ; 1DE3A:  95 60
b07_9e3c:   brk                         ; 1DE3C:  00
b07_9e3d:   brk                         ; 1DE3D:  00
b07_9e3e:   brk                         ; 1DE3E:  00
b07_9e3f:   brk                         ; 1DE3F:  00
b07_9e40:   brk                         ; 1DE40:  00
b07_9e41:   brk                         ; 1DE41:  00
b07_9e42:   brk                         ; 1DE42:  00
b07_9e43:   .db $02                     ; 1DE43:  02
b07_9e44:   .db $ff                     ; 1DE44:  ff
b07_9e45:   .db $ff                     ; 1DE45:  ff
b07_9e46:   .db $ff                     ; 1DE46:  ff
b07_9e47:   .db $ff                     ; 1DE47:  ff
b07_9e48:   .db $df                     ; 1DE48:  df
b07_9e49:   .db $e7                     ; 1DE49:  e7
b07_9e4a:   .db $f7                     ; 1DE4A:  f7
b07_9e4b:   .db $7f                     ; 1DE4B:  7f
b07_9e4c:   brk                         ; 1DE4C:  00
b07_9e4d:   brk                         ; 1DE4D:  00
b07_9e4e:   brk                         ; 1DE4E:  00
b07_9e4f:   brk                         ; 1DE4F:  00
b07_9e50:   jsr $0818                   ; 1DE50:  20 18 08
b07_9e53:   .db $80                     ; 1DE53:  80
b07_9e54:   brk                         ; 1DE54:  00
b07_9e55:   brk                         ; 1DE55:  00
b07_9e56:   brk                         ; 1DE56:  00
b07_9e57:   brk                         ; 1DE57:  00
b07_9e58:   brk                         ; 1DE58:  00
b07_9e59:   .db $80                     ; 1DE59:  80
b07_9e5a:   .db $80                     ; 1DE5A:  80
b07_9e5b:   cpy #$aa                    ; 1DE5B:  c0 aa
b07_9e5d:   .db $ff                     ; 1DE5D:  ff
b07_9e5e:   rol a                       ; 1DE5E:  2a
b07_9e5f:   .db $bf                     ; 1DE5F:  bf
b07_9e60:   dex                         ; 1DE60:  ca
b07_9e61:   .db $6f                     ; 1DE61:  6f
b07_9e62:   .db $72                     ; 1DE62:  72
b07_9e63:   .db $33                     ; 1DE63:  33
b07_9e64:   cpy #$80                    ; 1DE64:  c0 80
b07_9e66:   cpy #$e0                    ; 1DE66:  c0 e0
b07_9e68:   beq $9e5a                   ; 1DE68:  f0 f0
b07_9e6a:   bcc $9e6c                   ; 1DE6A:  90 00
b07_9e6c:   .db $3a                     ; 1DE6C:  3a
b07_9e6d:   adc $1d3c,y                 ; 1DE6D:  79 3c 1d
b07_9e70:   php                         ; 1DE70:  08
b07_9e71:   ora #$00                    ; 1DE71:  09 00
b07_9e73:   eor $0000                   ; 1DE73:  4d 00 00
b07_9e76:   brk                         ; 1DE76:  00
b07_9e77:   brk                         ; 1DE77:  00
b07_9e78:   brk                         ; 1DE78:  00
b07_9e79:   brk                         ; 1DE79:  00
b07_9e7a:   brk                         ; 1DE7A:  00
b07_9e7b:   brk                         ; 1DE7B:  00
b07_9e7c:   tax                         ; 1DE7C:  aa
b07_9e7d:   inc $feaa,x                 ; 1DE7D:  fe aa fe
b07_9e80:   tax                         ; 1DE80:  aa
b07_9e81:   inc $feaa,x                 ; 1DE81:  fe aa fe
b07_9e84:   brk                         ; 1DE84:  00
b07_9e85:   ora ($01,x)                 ; 1DE85:  01 01
b07_9e87:   adc ($d3,x)                 ; 1DE87:  61 d3
b07_9e89:   .db $89                     ; 1DE89:  89
b07_9e8a:   .db $8b                     ; 1DE8A:  8b
b07_9e8b:   sta $00                     ; 1DE8B:  85 00
b07_9e8d:   brk                         ; 1DE8D:  00
b07_9e8e:   brk                         ; 1DE8E:  00
b07_9e8f:   brk                         ; 1DE8F:  00
b07_9e90:   brk                         ; 1DE90:  00
b07_9e91:   brk                         ; 1DE91:  00
b07_9e92:   jsr $0010                   ; 1DE92:  20 10 00
b07_9e95:   brk                         ; 1DE95:  00
b07_9e96:   brk                         ; 1DE96:  00
b07_9e97:   brk                         ; 1DE97:  00
b07_9e98:   brk                         ; 1DE98:  00
b07_9e99:   brk                         ; 1DE99:  00
b07_9e9a:   brk                         ; 1DE9A:  00
b07_9e9b:   brk                         ; 1DE9B:  00
b07_9e9c:   tax                         ; 1DE9C:  aa
b07_9e9d:   .db $fc                     ; 1DE9D:  fc
b07_9e9e:   tax                         ; 1DE9E:  aa
b07_9e9f:   inc $fea9,x                 ; 1DE9F:  fe a9 fe
b07_9ea2:   tax                         ; 1DEA2:  aa
b07_9ea3:   inc $4f8f,x                 ; 1DEA3:  fe 8f 4f
b07_9ea6:   .db $47                     ; 1DEA6:  47
b07_9ea7:   .db $6f                     ; 1DEA7:  6f
b07_9ea8:   .db $3f                     ; 1DEA8:  3f
b07_9ea9:   .db $1f                     ; 1DEA9:  1f
b07_9eaa:   .db $03                     ; 1DEAA:  03
b07_9eab:   .db $03                     ; 1DEAB:  03
b07_9eac:   brk                         ; 1DEAC:  00
b07_9ead:   jsr $0030                   ; 1DEAD:  20 30 00
b07_9eb0:   brk                         ; 1DEB0:  00
b07_9eb1:   brk                         ; 1DEB1:  00
b07_9eb2:   brk                         ; 1DEB2:  00
b07_9eb3:   .db $80                     ; 1DEB3:  80
b07_9eb4:   cpy #$bc                    ; 1DEB4:  c0 bc
b07_9eb6:   inc $83e0,x                 ; 1DEB6:  fe e0 83
b07_9eb9:   .db $ff                     ; 1DEB9:  ff
b07_9eba:   .db $ff                     ; 1DEBA:  ff
b07_9ebb:   inc $0300,x                 ; 1DEBB:  fe 00 03
b07_9ebe:   ora ($10,x)                 ; 1DEBE:  01 10
b07_9ec0:   .db $63                     ; 1DEC0:  63
b07_9ec1:   brk                         ; 1DEC1:  00
b07_9ec2:   brk                         ; 1DEC2:  00
b07_9ec3:   ora ($3f,x)                 ; 1DEC3:  01 3f
b07_9ec5:   asl $0c                     ; 1DEC5:  06 0c
b07_9ec7:   .db $0c                     ; 1DEC7:  0c
b07_9ec8:   .db $1c                     ; 1DEC8:  1c
b07_9ec9:   .db $3c                     ; 1DEC9:  3c
b07_9eca:   .db $7c                     ; 1DECA:  7c
b07_9ecb:   inc $5800,x                 ; 1DECB:  fe 00 58
b07_9ece:   .db $f3                     ; 1DECE:  f3
b07_9ecf:   .db $33                     ; 1DECF:  33
b07_9ed0:   .db $62                     ; 1DED0:  62
b07_9ed1:   cmp ($81,x)                 ; 1DED1:  c1 81
b07_9ed3:   ora ($ff,x)                 ; 1DED3:  01 ff
b07_9ed5:   .db $ff                     ; 1DED5:  ff
b07_9ed6:   .db $ff                     ; 1DED6:  ff
b07_9ed7:   .db $ff                     ; 1DED7:  ff
b07_9ed8:   .db $ff                     ; 1DED8:  ff
b07_9ed9:   .db $ff                     ; 1DED9:  ff
b07_9eda:   inc $00fd,x                 ; 1DEDA:  fe fd 00
b07_9edd:   brk                         ; 1DEDD:  00
b07_9ede:   brk                         ; 1DEDE:  00
b07_9edf:   brk                         ; 1DEDF:  00
b07_9ee0:   brk                         ; 1DEE0:  00
b07_9ee1:   brk                         ; 1DEE1:  00
b07_9ee2:   ora ($02,x)                 ; 1DEE2:  01 02
b07_9ee4:   inc $dede,x                 ; 1DEE4:  fe de de
b07_9ee7:   stx $00                     ; 1DEE7:  86 00
b07_9ee9:   rts                         ; 1DEE9:  60
b07_9eea:   sed                         ; 1DEEA:  f8
b07_9eeb:   .db $ff                     ; 1DEEB:  ff
b07_9eec:   brk                         ; 1DEEC:  00
b07_9eed:   brk                         ; 1DEED:  00
b07_9eee:   brk                         ; 1DEEE:  00
b07_9eef:   rts                         ; 1DEEF:  60
b07_9ef0:   beq $9e8d                   ; 1DEF0:  f0 9b
b07_9ef2:   .db $07                     ; 1DEF2:  07
b07_9ef3:   brk                         ; 1DEF3:  00
b07_9ef4:   brk                         ; 1DEF4:  00
b07_9ef5:   jsr $0060                   ; 1DEF5:  20 60 00
b07_9ef8:   rts                         ; 1DEF8:  60
b07_9ef9:   cpx #$60                    ; 1DEF9:  e0 60
b07_9efb:   brk                         ; 1DEFB:  00
b07_9efc:   .db $04                     ; 1DEFC:  04
b07_9efd:   cmp $0d9c,y                 ; 1DEFD:  d9 9c 0d
b07_9f00:   jmp ($9c1d)                 ; 1DF00:  6c 1d 9c
b07_9f03:   inc $7010,x                 ; 1DF03:  fe 10 70
b07_9f06:   bvs $9f78                   ; 1DF06:  70 70
b07_9f08:   bvs $9f2a                   ; 1DF08:  70 20
b07_9f0a:   brk                         ; 1DF0A:  00
b07_9f0b:   brk                         ; 1DF0B:  00
b07_9f0c:   inc $8e8e                   ; 1DF0C:  ee 8e 8e
b07_9f0f:   asl $dd0e                   ; 1DF0F:  0e 0e dd
b07_9f12:   .db $fc                     ; 1DF12:  fc
b07_9f13:   sbc $0000,x                 ; 1DF13:  fd 00 00
b07_9f16:   brk                         ; 1DF16:  00
b07_9f17:   brk                         ; 1DF17:  00
b07_9f18:   brk                         ; 1DF18:  00
b07_9f19:   brk                         ; 1DF19:  00
b07_9f1a:   brk                         ; 1DF1A:  00
b07_9f1b:   brk                         ; 1DF1B:  00
b07_9f1c:   tax                         ; 1DF1C:  aa
b07_9f1d:   .db $ff                     ; 1DF1D:  ff
b07_9f1e:   tax                         ; 1DF1E:  aa
b07_9f1f:   .db $ff                     ; 1DF1F:  ff
b07_9f20:   tax                         ; 1DF20:  aa
b07_9f21:   .db $ff                     ; 1DF21:  ff
b07_9f22:   tax                         ; 1DF22:  aa
b07_9f23:   sed                         ; 1DF23:  f8
b07_9f24:   .db $03                     ; 1DF24:  03
b07_9f25:   ora $04                     ; 1DF25:  05 04
b07_9f27:   asl $07                     ; 1DF27:  06 07
b07_9f29:   .db $17                     ; 1DF29:  17
b07_9f2a:   .db $03                     ; 1DF2A:  03
b07_9f2b:   .db $13                     ; 1DF2B:  13
b07_9f2c:   sty $82                     ; 1DF2C:  84 82
b07_9f2e:   .db $22                     ; 1DF2E:  22
b07_9f2f:   cmp $a4                     ; 1DF2F:  c5 a4
b07_9f31:   dec $8a                     ; 1DF31:  c6 8a
b07_9f33:   .db $23                     ; 1DF33:  23
b07_9f34:   .db $04                     ; 1DF34:  04
b07_9f35:   ora ($44),y                 ; 1DF35:  11 44
b07_9f37:   ora ($44),y                 ; 1DF37:  11 44
b07_9f39:   ora ($44),y                 ; 1DF39:  11 44
b07_9f3b:   ora ($00),y                 ; 1DF3B:  11 00
b07_9f3d:   .db $22                     ; 1DF3D:  22
b07_9f3e:   dey                         ; 1DF3E:  88
b07_9f3f:   .db $22                     ; 1DF3F:  22
b07_9f40:   dey                         ; 1DF40:  88
b07_9f41:   .db $22                     ; 1DF41:  22
b07_9f42:   dey                         ; 1DF42:  88
b07_9f43:   .db $22                     ; 1DF43:  22
b07_9f44:   ora ($10,x)                 ; 1DF44:  01 10
b07_9f46:   .db $04                     ; 1DF46:  04
b07_9f47:   bpl $9f8d                   ; 1DF47:  10 44
b07_9f49:   bpl $9f8f                   ; 1DF49:  10 44
b07_9f4b:   ora ($89),y                 ; 1DF4B:  11 89
b07_9f4d:   jsr $2088                   ; 1DF4D:  20 88 20
b07_9f50:   dey                         ; 1DF50:  88
b07_9f51:   .db $02                     ; 1DF51:  02
b07_9f52:   dey                         ; 1DF52:  88
b07_9f53:   .db $02                     ; 1DF53:  02
b07_9f54:   .db $ff                     ; 1DF54:  ff
b07_9f55:   .db $ff                     ; 1DF55:  ff
b07_9f56:   .db $ff                     ; 1DF56:  ff
b07_9f57:   .db $7f                     ; 1DF57:  7f
b07_9f58:   .db $3f                     ; 1DF58:  3f
b07_9f59:   .db $9f                     ; 1DF59:  9f
b07_9f5a:   .db $cf                     ; 1DF5A:  cf
b07_9f5b:   .db $e7                     ; 1DF5B:  e7
b07_9f5c:   brk                         ; 1DF5C:  00
b07_9f5d:   brk                         ; 1DF5D:  00
b07_9f5e:   brk                         ; 1DF5E:  00
b07_9f5f:   brk                         ; 1DF5F:  00
b07_9f60:   .db $80                     ; 1DF60:  80
b07_9f61:   brk                         ; 1DF61:  00
b07_9f62:   brk                         ; 1DF62:  00
b07_9f63:   brk                         ; 1DF63:  00
b07_9f64:   cpx $1e                     ; 1DF64:  e4 1e
b07_9f66:   .db $3f                     ; 1DF66:  3f
b07_9f67:   bvs $9f49                   ; 1DF67:  70 e0
b07_9f69:   .db $fc                     ; 1DF69:  fc
b07_9f6a:   .db $fc                     ; 1DF6A:  fc
b07_9f6b:   inc $8000,x                 ; 1DF6B:  fe 00 80
b07_9f6e:   brk                         ; 1DF6E:  00
b07_9f6f:   sta ($0f,x)                 ; 1DF6F:  81 0f
b07_9f71:   .db $03                     ; 1DF71:  03
b07_9f72:   .db $03                     ; 1DF72:  03
b07_9f73:   ora ($f1,x)                 ; 1DF73:  01 f1
b07_9f75:   sed                         ; 1DF75:  f8
b07_9f76:   .db $7c                     ; 1DF76:  7c
b07_9f77:   rol $0f1f,x                 ; 1DF77:  3e 1f 0f
b07_9f7a:   .db $07                     ; 1DF7A:  07
b07_9f7b:   .db $03                     ; 1DF7B:  03
b07_9f7c:   .db $80                     ; 1DF7C:  80
b07_9f7d:   cpy #$62                    ; 1DF7D:  c0 62
b07_9f7f:   and ($18),y                 ; 1DF7F:  31 18
b07_9f81:   .db $0c                     ; 1DF81:  0c
b07_9f82:   asl $03                     ; 1DF82:  06 03
b07_9f84:   inc $007e,x                 ; 1DF84:  fe 7e 00
b07_9f87:   ora ($01,x)                 ; 1DF87:  01 01
b07_9f89:   sta ($83,x)                 ; 1DF89:  81 83
b07_9f8b:   .db $82                     ; 1DF8B:  82
b07_9f8c:   ora ($01,x)                 ; 1DF8C:  01 01
b07_9f8e:   brk                         ; 1DF8E:  00
b07_9f8f:   sta ($fd,x)                 ; 1DF8F:  81 fd
b07_9f91:   adc $7a7b,x                 ; 1DF91:  7d 7b 7a
b07_9f94:   brk                         ; 1DF94:  00
b07_9f95:   brk                         ; 1DF95:  00
b07_9f96:   brk                         ; 1DF96:  00
b07_9f97:   brk                         ; 1DF97:  00
b07_9f98:   brk                         ; 1DF98:  00
b07_9f99:   brk                         ; 1DF99:  00
b07_9f9a:   brk                         ; 1DF9A:  00
b07_9f9b:   brk                         ; 1DF9B:  00
b07_9f9c:   .db $fa                     ; 1DF9C:  fa
b07_9f9d:   .db $7b                     ; 1DF9D:  7b
b07_9f9e:   .db $72                     ; 1DF9E:  72
b07_9f9f:   .db $f7                     ; 1DF9F:  f7
b07_9fa0:   nop                         ; 1DFA0:  ea
b07_9fa1:   .db $ef                     ; 1DFA1:  ef
b07_9fa2:   dex                         ; 1DFA2:  ca
b07_9fa3:   .db $a3                     ; 1DFA3:  a3
b07_9fa4:   .db $04                     ; 1DFA4:  04
b07_9fa5:   ora ($84),y                 ; 1DFA5:  11 84
b07_9fa7:   sta ($00),y                 ; 1DFA7:  91 00
b07_9fa9:   ora ($04,x)                 ; 1DFA9:  01 04
b07_9fab:   ora ($88,x)                 ; 1DFAB:  01 88
b07_9fad:   .db $22                     ; 1DFAD:  22
b07_9fae:   .db $80                     ; 1DFAE:  80
b07_9faf:   .db $82                     ; 1DFAF:  82
b07_9fb0:   php                         ; 1DFB0:  08
b07_9fb1:   brk                         ; 1DFB1:  00
b07_9fb2:   php                         ; 1DFB2:  08
b07_9fb3:   brk                         ; 1DFB3:  00
b07_9fb4:   brk                         ; 1DFB4:  00
b07_9fb5:   brk                         ; 1DFB5:  00
b07_9fb6:   .db $44                     ; 1DFB6:  44
b07_9fb7:   ora ($44),y                 ; 1DFB7:  11 44
b07_9fb9:   ora ($44),y                 ; 1DFB9:  11 44
b07_9fbb:   ora ($2a),y                 ; 1DFBB:  11 2a
b07_9fbd:   .db $03                     ; 1DFBD:  03
b07_9fbe:   dey                         ; 1DFBE:  88
b07_9fbf:   .db $22                     ; 1DFBF:  22
b07_9fc0:   dey                         ; 1DFC0:  88
b07_9fc1:   .db $22                     ; 1DFC1:  22
b07_9fc2:   dey                         ; 1DFC2:  88
b07_9fc3:   .db $22                     ; 1DFC3:  22
b07_9fc4:   brk                         ; 1DFC4:  00
b07_9fc5:   brk                         ; 1DFC5:  00
b07_9fc6:   brk                         ; 1DFC6:  00
b07_9fc7:   brk                         ; 1DFC7:  00
b07_9fc8:   brk                         ; 1DFC8:  00
b07_9fc9:   brk                         ; 1DFC9:  00
b07_9fca:   brk                         ; 1DFCA:  00
b07_9fcb:   brk                         ; 1DFCB:  00
b07_9fcc:   .db $22                     ; 1DFCC:  22
b07_9fcd:   dey                         ; 1DFCD:  88
b07_9fce:   .db $22                     ; 1DFCE:  22
b07_9fcf:   dey                         ; 1DFCF:  88
b07_9fd0:   .db $22                     ; 1DFD0:  22
b07_9fd1:   dey                         ; 1DFD1:  88
b07_9fd2:   .db $22                     ; 1DFD2:  22
b07_9fd3:   dey                         ; 1DFD3:  88
b07_9fd4:   brk                         ; 1DFD4:  00
b07_9fd5:   brk                         ; 1DFD5:  00
b07_9fd6:   brk                         ; 1DFD6:  00
b07_9fd7:   brk                         ; 1DFD7:  00
b07_9fd8:   brk                         ; 1DFD8:  00
b07_9fd9:   brk                         ; 1DFD9:  00
b07_9fda:   ora ($03,x)                 ; 1DFDA:  01 03
b07_9fdc:   .db $22                     ; 1DFDC:  22
b07_9fdd:   dey                         ; 1DFDD:  88
b07_9fde:   .db $22                     ; 1DFDE:  22
b07_9fdf:   dey                         ; 1DFDF:  88
b07_9fe0:   .db $22                     ; 1DFE0:  22
b07_9fe1:   dey                         ; 1DFE1:  88
b07_9fe2:   .db $22                     ; 1DFE2:  22
b07_9fe3:   dey                         ; 1DFE3:  88
b07_9fe4:   .db $07                     ; 1DFE4:  07
b07_9fe5:   .db $07                     ; 1DFE5:  07
b07_9fe6:   .db $0f                     ; 1DFE6:  0f
b07_9fe7:   .db $0f                     ; 1DFE7:  0f
b07_9fe8:   .db $0f                     ; 1DFE8:  0f
b07_9fe9:   .db $1f                     ; 1DFE9:  1f
b07_9fea:   .db $1f                     ; 1DFEA:  1f
b07_9feb:   .db $1f                     ; 1DFEB:  1f
b07_9fec:   jsr $2088                   ; 1DFEC:  20 88 20
b07_9fef:   .db $80                     ; 1DFEF:  80
b07_9ff0:   jsr $2080                   ; 1DFF0:  20 80 20
b07_9ff3:   .db $80                     ; 1DFF3:  80
b07_9ff4:   brk                         ; 1DFF4:  00
b07_9ff5:   brk                         ; 1DFF5:  00
b07_9ff6:   brk                         ; 1DFF6:  00
b07_9ff7:   .db $07                     ; 1DFF7:  07
b07_9ff8:   .db $3f                     ; 1DFF8:  3f
b07_9ff9:   .db $ff                     ; 1DFF9:  ff
b07_9ffa:   .db $ff                     ; 1DFFA:  ff
b07_9ffb:   .db $ff                     ; 1DFFB:  ff
b07_9ffc:   .db $22                     ; 1DFFC:  22
b07_9ffd:   dey                         ; 1DFFD:  88
b07_9ffe:   .db $22                     ; 1DFFE:  22
b07_9fff:   dey                         ; 1DFFF:  88
b07_a000:   brk                         ; 1E000:  00
b07_a001:   brk                         ; 1E001:  00
b07_a002:   brk                         ; 1E002:  00
b07_a003:   brk                         ; 1E003:  00
b07_a004:   brk                         ; 1E004:  00
b07_a005:   brk                         ; 1E005:  00
b07_a006:   brk                         ; 1E006:  00
b07_a007:   beq $9ff9                   ; 1E007:  f0 f0
b07_a009:   sed                         ; 1E009:  f8
b07_a00a:   .db $fc                     ; 1E00A:  fc
b07_a00b:   .db $fc                     ; 1E00B:  fc
b07_a00c:   .db $22                     ; 1E00C:  22
b07_a00d:   .db $80                     ; 1E00D:  80
b07_a00e:   brk                         ; 1E00E:  00
b07_a00f:   brk                         ; 1E00F:  00
b07_a010:   asl $0307                   ; 1E010:  0e 07 03
b07_a013:   .db $03                     ; 1E013:  03
b07_a014:   .db $ff                     ; 1E014:  ff
b07_a015:   .db $ff                     ; 1E015:  ff
b07_a016:   .db $ff                     ; 1E016:  ff
b07_a017:   .db $ff                     ; 1E017:  ff
b07_a018:   .db $ff                     ; 1E018:  ff
b07_a019:   .db $ff                     ; 1E019:  ff
b07_a01a:   .db $ff                     ; 1E01A:  ff
b07_a01b:   .db $ff                     ; 1E01B:  ff
b07_a01c:   brk                         ; 1E01C:  00
b07_a01d:   brk                         ; 1E01D:  00
b07_a01e:   brk                         ; 1E01E:  00
b07_a01f:   brk                         ; 1E01F:  00
b07_a020:   brk                         ; 1E020:  00
b07_a021:   brk                         ; 1E021:  00
b07_a022:   brk                         ; 1E022:  00
b07_a023:   brk                         ; 1E023:  00
b07_a024:   inc $fefe,x                 ; 1E024:  fe fe fe
b07_a027:   inc $fefe,x                 ; 1E027:  fe fe fe
b07_a02a:   .db $fc                     ; 1E02A:  fc
b07_a02b:   .db $fc                     ; 1E02B:  fc
b07_a02c:   ora ($01,x)                 ; 1E02C:  01 01
b07_a02e:   ora ($01,x)                 ; 1E02E:  01 01
b07_a030:   ora ($01,x)                 ; 1E030:  01 01
b07_a032:   .db $03                     ; 1E032:  03
b07_a033:   .db $03                     ; 1E033:  03
b07_a034:   brk                         ; 1E034:  00
b07_a035:   brk                         ; 1E035:  00
b07_a036:   brk                         ; 1E036:  00
b07_a037:   brk                         ; 1E037:  00
b07_a038:   brk                         ; 1E038:  00
b07_a039:   brk                         ; 1E039:  00
b07_a03a:   brk                         ; 1E03A:  00
b07_a03b:   brk                         ; 1E03B:  00
b07_a03c:   .db $22                     ; 1E03C:  22
b07_a03d:   dey                         ; 1E03D:  88
b07_a03e:   .db $22                     ; 1E03E:  22
b07_a03f:   dey                         ; 1E03F:  88
b07_a040:   .db $22                     ; 1E040:  22
b07_a041:   dey                         ; 1E041:  88
b07_a042:   .db $c2                     ; 1E042:  c2
b07_a043:   inx                         ; 1E043:  e8
b07_a044:   brk                         ; 1E044:  00
b07_a045:   brk                         ; 1E045:  00
b07_a046:   brk                         ; 1E046:  00
b07_a047:   brk                         ; 1E047:  00
b07_a048:   brk                         ; 1E048:  00
b07_a049:   brk                         ; 1E049:  00
b07_a04a:   brk                         ; 1E04A:  00
b07_a04b:   brk                         ; 1E04B:  00
b07_a04c:   .db $f2                     ; 1E04C:  f2
b07_a04d:   beq $a049                   ; 1E04D:  f0 fa
b07_a04f:   sed                         ; 1E04F:  f8
b07_a050:   .db $fa                     ; 1E050:  fa
b07_a051:   sed                         ; 1E051:  f8
b07_a052:   .db $f2                     ; 1E052:  f2
b07_a053:   beq $a074                   ; 1E053:  f0 1f
b07_a055:   .db $1f                     ; 1E055:  1f
b07_a056:   asl $1910,x                 ; 1E056:  1e 10 19
b07_a059:   .db $17                     ; 1E059:  17
b07_a05a:   asl $201d                   ; 1E05A:  0e 1d 20
b07_a05d:   .db $80                     ; 1E05D:  80
b07_a05e:   jsr $0080                   ; 1E05E:  20 80 00
b07_a061:   .db $80                     ; 1E061:  80
b07_a062:   brk                         ; 1E062:  00
b07_a063:   sta ($0f,x)                 ; 1E063:  81 0f
b07_a065:   .db $0f                     ; 1E065:  0f
b07_a066:   .db $0f                     ; 1E066:  0f
b07_a067:   .db $0f                     ; 1E067:  0f
b07_a068:   .db $0f                     ; 1E068:  0f
b07_a069:   .db $0f                     ; 1E069:  0f
b07_a06a:   .db $0f                     ; 1E06A:  0f
b07_a06b:   .db $07                     ; 1E06B:  07
b07_a06c:   bpl $9ffe                   ; 1E06C:  10 90
b07_a06e:   bpl $a000                   ; 1E06E:  10 90
b07_a070:   jsr $2080                   ; 1E070:  20 80 20
b07_a073:   dey                         ; 1E073:  88
b07_a074:   .db $ef                     ; 1E074:  ef
b07_a075:   sbc $0ccc                   ; 1E075:  ed cc 0c
b07_a078:   php                         ; 1E078:  08
b07_a079:   sty $0c0c                   ; 1E079:  8c 0c 0c
b07_a07c:   bpl $a08e                   ; 1E07C:  10 10
b07_a07e:   ora ($11),y                 ; 1E07E:  11 11
b07_a080:   .db $c2                     ; 1E080:  c2
b07_a081:   .db $63                     ; 1E081:  63
b07_a082:   .db $23                     ; 1E082:  23
b07_a083:   .db $03                     ; 1E083:  03
b07_a084:   sed                         ; 1E084:  f8
b07_a085:   .db $fc                     ; 1E085:  fc
b07_a086:   ror $000a,x                 ; 1E086:  7e 0a 00
b07_a089:   cpy #$00                    ; 1E089:  c0 00
b07_a08b:   jsr $0307                   ; 1E08B:  20 07 03
b07_a08e:   ora ($00,x)                 ; 1E08E:  01 00
b07_a090:   sbc ($3f,x)                 ; 1E090:  e1 3f
b07_a092:   .db $07                     ; 1E092:  07
b07_a093:   .db $a3                     ; 1E093:  a3
b07_a094:   .db $dc                     ; 1E094:  dc
b07_a095:   .db $dc                     ; 1E095:  dc
b07_a096:   .db $9c                     ; 1E096:  9c
b07_a097:   cld                         ; 1E097:  d8
b07_a098:   .db $db                     ; 1E098:  db
b07_a099:   .db $ff                     ; 1E099:  ff
b07_a09a:   cld                         ; 1E09A:  d8
b07_a09b:   cpx #$23                    ; 1E09B:  e0 23
b07_a09d:   .db $23                     ; 1E09D:  23
b07_a09e:   .db $43                     ; 1E09E:  43
b07_a09f:   asl $04                     ; 1E09F:  06 04
b07_a0a1:   brk                         ; 1E0A1:  00
b07_a0a2:   brk                         ; 1E0A2:  00
b07_a0a3:   .db $07                     ; 1E0A3:  07
b07_a0a4:   bvs $a0d6                   ; 1E0A4:  70 30
b07_a0a6:   bpl $a0a8                   ; 1E0A6:  10 00
b07_a0a8:   brk                         ; 1E0A8:  00
b07_a0a9:   brk                         ; 1E0A9:  00
b07_a0aa:   brk                         ; 1E0AA:  00
b07_a0ab:   brk                         ; 1E0AB:  00
b07_a0ac:   .db $8f                     ; 1E0AC:  8f
b07_a0ad:   .db $8f                     ; 1E0AD:  8f
b07_a0ae:   .db $cf                     ; 1E0AE:  cf
b07_a0af:   .db $ff                     ; 1E0AF:  ff
b07_a0b0:   .db $ff                     ; 1E0B0:  ff
b07_a0b1:   .db $7f                     ; 1E0B1:  7f
b07_a0b2:   .db $ff                     ; 1E0B2:  ff
b07_a0b3:   .db $ff                     ; 1E0B3:  ff
b07_a0b4:   brk                         ; 1E0B4:  00
b07_a0b5:   brk                         ; 1E0B5:  00
b07_a0b6:   brk                         ; 1E0B6:  00
b07_a0b7:   brk                         ; 1E0B7:  00
b07_a0b8:   brk                         ; 1E0B8:  00
b07_a0b9:   brk                         ; 1E0B9:  00
b07_a0ba:   asl $0a                     ; 1E0BA:  06 0a
b07_a0bc:   .db $f2                     ; 1E0BC:  f2
b07_a0bd:   cpx #$f2                    ; 1E0BD:  e0 f2
b07_a0bf:   cpx #$f2                    ; 1E0BF:  e0 f2
b07_a0c1:   rts                         ; 1E0C1:  60
b07_a0c2:   cpx #$e0                    ; 1E0C2:  e0 e0
b07_a0c4:   .db $12                     ; 1E0C4:  12
b07_a0c5:   .db $02                     ; 1E0C5:  02
b07_a0c6:   brk                         ; 1E0C6:  00
b07_a0c7:   brk                         ; 1E0C7:  00
b07_a0c8:   brk                         ; 1E0C8:  00
b07_a0c9:   brk                         ; 1E0C9:  00
b07_a0ca:   brk                         ; 1E0CA:  00
b07_a0cb:   brk                         ; 1E0CB:  00
b07_a0cc:   cpx #$e8                    ; 1E0CC:  e0 e8
b07_a0ce:   .db $f4                     ; 1E0CE:  f4
b07_a0cf:   cpx $fc                     ; 1E0CF:  e4 fc
b07_a0d1:   sed                         ; 1E0D1:  f8
b07_a0d2:   .db $c2                     ; 1E0D2:  c2
b07_a0d3:   iny                         ; 1E0D3:  c8
b07_a0d4:   brk                         ; 1E0D4:  00
b07_a0d5:   brk                         ; 1E0D5:  00
b07_a0d6:   brk                         ; 1E0D6:  00
b07_a0d7:   brk                         ; 1E0D7:  00
b07_a0d8:   brk                         ; 1E0D8:  00
b07_a0d9:   brk                         ; 1E0D9:  00
b07_a0da:   brk                         ; 1E0DA:  00
b07_a0db:   brk                         ; 1E0DB:  00
b07_a0dc:   .db $22                     ; 1E0DC:  22
b07_a0dd:   dey                         ; 1E0DD:  88
b07_a0de:   .db $22                     ; 1E0DE:  22
b07_a0df:   dey                         ; 1E0DF:  88
b07_a0e0:   .db $22                     ; 1E0E0:  22
b07_a0e1:   dey                         ; 1E0E1:  88
b07_a0e2:   jsr $0783                   ; 1E0E2:  20 83 07
b07_a0e5:   .db $07                     ; 1E0E5:  07
b07_a0e6:   .db $03                     ; 1E0E6:  03
b07_a0e7:   .db $03                     ; 1E0E7:  03
b07_a0e8:   ora ($01,x)                 ; 1E0E8:  01 01
b07_a0ea:   brk                         ; 1E0EA:  00
b07_a0eb:   brk                         ; 1E0EB:  00
b07_a0ec:   jsr $2088                   ; 1E0EC:  20 88 20
b07_a0ef:   dey                         ; 1E0EF:  88
b07_a0f0:   jsr $1d80                   ; 1E0F0:  20 80 1d
b07_a0f3:   adc $00,x                   ; 1E0F3:  75 00
b07_a0f5:   brk                         ; 1E0F5:  00
b07_a0f6:   brk                         ; 1E0F6:  00
b07_a0f7:   brk                         ; 1E0F7:  00
b07_a0f8:   brk                         ; 1E0F8:  00
b07_a0f9:   brk                         ; 1E0F9:  00
b07_a0fa:   brk                         ; 1E0FA:  00
b07_a0fb:   brk                         ; 1E0FB:  00
b07_a0fc:   ora $5d77,x                 ; 1E0FC:  1d 77 5d
b07_a0ff:   .db $77                     ; 1E0FF:  77
b07_a100:   cmp $dd77,x                 ; 1E100:  dd 77 dd
b07_a103:   .db $77                     ; 1E103:  77
b07_a104:   brk                         ; 1E104:  00
b07_a105:   brk                         ; 1E105:  00
b07_a106:   brk                         ; 1E106:  00
b07_a107:   ora ($00,x)                 ; 1E107:  01 00
b07_a109:   ora ($00,x)                 ; 1E109:  01 00
b07_a10b:   ora ($d8,x)                 ; 1E10B:  01 d8
b07_a10d:   .db $72                     ; 1E10D:  72
b07_a10e:   .db $d4                     ; 1E10E:  d4
b07_a10f:   .db $74                     ; 1E10F:  74
b07_a110:   cmp $cd64                   ; 1E110:  cd 64 cd
b07_a113:   .db $54                     ; 1E113:  54
b07_a114:   sbc ($ff),y                 ; 1E114:  f1 ff
b07_a116:   .db $c2                     ; 1E116:  c2
b07_a117:   .db $df                     ; 1E117:  df
b07_a118:   beq $a112                   ; 1E118:  f0 f8
b07_a11a:   inc $0eff,x                 ; 1E11A:  fe ff 0e
b07_a11d:   brk                         ; 1E11D:  00
b07_a11e:   brk                         ; 1E11E:  00
b07_a11f:   brk                         ; 1E11F:  00
b07_a120:   brk                         ; 1E120:  00
b07_a121:   .db $02                     ; 1E121:  02
b07_a122:   ora ($80,x)                 ; 1E122:  01 80
b07_a124:   .db $80                     ; 1E124:  80
b07_a125:   cpy #$00                    ; 1E125:  c0 00
b07_a127:   cpy #$00                    ; 1E127:  c0 00
b07_a129:   brk                         ; 1E129:  00
b07_a12a:   brk                         ; 1E12A:  00
b07_a12b:   brk                         ; 1E12B:  00
b07_a12c:   .db $7f                     ; 1E12C:  7f
b07_a12d:   .db $3f                     ; 1E12D:  3f
b07_a12e:   .db $3f                     ; 1E12E:  3f
b07_a12f:   .db $1f                     ; 1E12F:  1f
b07_a130:   inc $f9fd,x                 ; 1E130:  fe fd f9
b07_a133:   .db $f3                     ; 1E133:  f3
b07_a134:   .db $bf                     ; 1E134:  bf
b07_a135:   stx $90a0                   ; 1E135:  8e a0 90
b07_a138:   cld                         ; 1E138:  d8
b07_a139:   jmp $77ee                   ; 1E139:  4c ee 77
b07_a13c:   .db $80                     ; 1E13C:  80
b07_a13d:   sta ($80,x)                 ; 1E13D:  81 80
b07_a13f:   dey                         ; 1E13F:  88
b07_a140:   .db $47                     ; 1E140:  47
b07_a141:   .db $c3                     ; 1E141:  c3
b07_a142:   adc ($b0,x)                 ; 1E142:  61 b0
b07_a144:   brk                         ; 1E144:  00
b07_a145:   brk                         ; 1E145:  00
b07_a146:   ora ($01,x)                 ; 1E146:  01 01
b07_a148:   .db $03                     ; 1E148:  03
b07_a149:   asl $0c                     ; 1E149:  06 0c
b07_a14b:   ora $87e3,y                 ; 1E14B:  19 e3 87
b07_a14e:   .db $0f                     ; 1E14E:  0f
b07_a14f:   .db $3f                     ; 1E14F:  3f
b07_a150:   .db $ff                     ; 1E150:  ff
b07_a151:   inc $fafd,x                 ; 1E151:  fe fd fa
b07_a154:   brk                         ; 1E154:  00
b07_a155:   jsr $2020                   ; 1E155:  20 20 20
b07_a158:   jsr $4060                   ; 1E158:  20 60 40
b07_a15b:   rti                         ; 1E15B:  40
b07_a15c:   ldx #$e8                    ; 1E15C:  a2 e8
b07_a15e:   .db $62                     ; 1E15E:  62
b07_a15f:   bvs $a151                   ; 1E15F:  70 f0
b07_a161:   .db $f2                     ; 1E161:  f2
b07_a162:   cmp $00d5,x                 ; 1E162:  dd d5 00
b07_a165:   brk                         ; 1E165:  00
b07_a166:   brk                         ; 1E166:  00
b07_a167:   brk                         ; 1E167:  00
b07_a168:   brk                         ; 1E168:  00
b07_a169:   brk                         ; 1E169:  00
b07_a16a:   brk                         ; 1E16A:  00
b07_a16b:   brk                         ; 1E16B:  00
b07_a16c:   .db $22                     ; 1E16C:  22
b07_a16d:   dey                         ; 1E16D:  88
b07_a16e:   .db $22                     ; 1E16E:  22
b07_a16f:   dey                         ; 1E16F:  88
b07_a170:   .db $22                     ; 1E170:  22
b07_a171:   php                         ; 1E171:  08
b07_a172:   cpy #$77                    ; 1E172:  c0 77
b07_a174:   cpy #$80                    ; 1E174:  c0 80
b07_a176:   .db $80                     ; 1E176:  80
b07_a177:   rti                         ; 1E177:  40
b07_a178:   brk                         ; 1E178:  00
b07_a179:   rti                         ; 1E179:  40
b07_a17a:   .db $80                     ; 1E17A:  80
b07_a17b:   rti                         ; 1E17B:  40
b07_a17c:   cmp $9c95,x                 ; 1E17C:  dd 95 9c
b07_a17f:   asl $5c,x                   ; 1E17F:  16 5c
b07_a181:   stx $5c,y                   ; 1E181:  96 5c
b07_a183:   stx $00,y                   ; 1E183:  96 00
b07_a185:   brk                         ; 1E185:  00
b07_a186:   brk                         ; 1E186:  00
b07_a187:   brk                         ; 1E187:  00
b07_a188:   brk                         ; 1E188:  00
b07_a189:   brk                         ; 1E189:  00
b07_a18a:   brk                         ; 1E18A:  00
b07_a18b:   brk                         ; 1E18B:  00
b07_a18c:   cmp $dd77,x                 ; 1E18C:  dd 77 dd
b07_a18f:   .db $77                     ; 1E18F:  77
b07_a190:   cmp $dd77,x                 ; 1E190:  dd 77 dd
b07_a193:   .db $77                     ; 1E193:  77
b07_a194:   .db $44                     ; 1E194:  44
b07_a195:   ora ($44),y                 ; 1E195:  11 44
b07_a197:   ora ($44),y                 ; 1E197:  11 44
b07_a199:   ora ($44),y                 ; 1E199:  11 44
b07_a19b:   ora ($88),y                 ; 1E19B:  11 88
b07_a19d:   .db $22                     ; 1E19D:  22
b07_a19e:   dey                         ; 1E19E:  88
b07_a19f:   .db $22                     ; 1E19F:  22
b07_a1a0:   dey                         ; 1E1A0:  88
b07_a1a1:   .db $22                     ; 1E1A1:  22
b07_a1a2:   dey                         ; 1E1A2:  88
b07_a1a3:   .db $22                     ; 1E1A3:  22
b07_a1a4:   .db $44                     ; 1E1A4:  44
b07_a1a5:   ora ($44),y                 ; 1E1A5:  11 44
b07_a1a7:   bpl $a1e9                   ; 1E1A7:  10 40
b07_a1a9:   bpl $a1eb                   ; 1E1A9:  10 40
b07_a1ab:   ora ($88,x)                 ; 1E1AB:  01 88
b07_a1ad:   .db $22                     ; 1E1AD:  22
b07_a1ae:   dey                         ; 1E1AE:  88
b07_a1af:   and ($8b,x)                 ; 1E1AF:  21 8b
b07_a1b1:   .db $27                     ; 1E1B1:  27
b07_a1b2:   .db $8f                     ; 1E1B2:  8f
b07_a1b3:   rol $0f57                   ; 1E1B3:  2e 57 0f
b07_a1b6:   .db $1f                     ; 1E1B6:  1f
b07_a1b7:   .db $3f                     ; 1E1B7:  3f
b07_a1b8:   .db $3f                     ; 1E1B8:  3f
b07_a1b9:   .db $7f                     ; 1E1B9:  7f
b07_a1ba:   .db $7f                     ; 1E1BA:  7f
b07_a1bb:   .db $7f                     ; 1E1BB:  7f
b07_a1bc:   dey                         ; 1E1BC:  88
b07_a1bd:   bpl $a15f                   ; 1E1BD:  10 a0
b07_a1bf:   brk                         ; 1E1BF:  00
b07_a1c0:   .db $80                     ; 1E1C0:  80
b07_a1c1:   brk                         ; 1E1C1:  00
b07_a1c2:   brk                         ; 1E1C2:  00
b07_a1c3:   brk                         ; 1E1C3:  00
b07_a1c4:   .db $44                     ; 1E1C4:  44
b07_a1c5:   brk                         ; 1E1C5:  00
b07_a1c6:   brk                         ; 1E1C6:  00
b07_a1c7:   brk                         ; 1E1C7:  00
b07_a1c8:   brk                         ; 1E1C8:  00
b07_a1c9:   brk                         ; 1E1C9:  00
b07_a1ca:   brk                         ; 1E1CA:  00
b07_a1cb:   .db $fc                     ; 1E1CB:  fc
b07_a1cc:   dey                         ; 1E1CC:  88
b07_a1cd:   .db $2f                     ; 1E1CD:  2f
b07_a1ce:   .db $7f                     ; 1E1CE:  7f
b07_a1cf:   .db $ff                     ; 1E1CF:  ff
b07_a1d0:   .db $ff                     ; 1E1D0:  ff
b07_a1d1:   .db $ff                     ; 1E1D1:  ff
b07_a1d2:   .db $ff                     ; 1E1D2:  ff
b07_a1d3:   .db $03                     ; 1E1D3:  03
b07_a1d4:   .db $44                     ; 1E1D4:  44
b07_a1d5:   brk                         ; 1E1D5:  00
b07_a1d6:   brk                         ; 1E1D6:  00
b07_a1d7:   brk                         ; 1E1D7:  00
b07_a1d8:   brk                         ; 1E1D8:  00
b07_a1d9:   brk                         ; 1E1D9:  00
b07_a1da:   brk                         ; 1E1DA:  00
b07_a1db:   brk                         ; 1E1DB:  00
b07_a1dc:   dey                         ; 1E1DC:  88
b07_a1dd:   .db $fc                     ; 1E1DD:  fc
b07_a1de:   .db $ff                     ; 1E1DE:  ff
b07_a1df:   .db $ff                     ; 1E1DF:  ff
b07_a1e0:   .db $ff                     ; 1E1E0:  ff
b07_a1e1:   .db $ff                     ; 1E1E1:  ff
b07_a1e2:   .db $ff                     ; 1E1E2:  ff
b07_a1e3:   .db $ff                     ; 1E1E3:  ff
b07_a1e4:   inc $ffff,x                 ; 1E1E4:  fe ff ff
b07_a1e7:   .db $ff                     ; 1E1E7:  ff
b07_a1e8:   .db $ff                     ; 1E1E8:  ff
b07_a1e9:   inc $f8fc,x                 ; 1E1E9:  fe fc f8
b07_a1ec:   ora ($00,x)                 ; 1E1EC:  01 00
b07_a1ee:   brk                         ; 1E1EE:  00
b07_a1ef:   brk                         ; 1E1EF:  00
b07_a1f0:   brk                         ; 1E1F0:  00
b07_a1f1:   ora ($03,x)                 ; 1E1F1:  01 03
b07_a1f3:   asl $00                     ; 1E1F3:  06 00
b07_a1f5:   brk                         ; 1E1F5:  00
b07_a1f6:   .db $80                     ; 1E1F6:  80
b07_a1f7:   .db $80                     ; 1E1F7:  80
b07_a1f8:   .db $80                     ; 1E1F8:  80
b07_a1f9:   brk                         ; 1E1F9:  00
b07_a1fa:   brk                         ; 1E1FA:  00
b07_a1fb:   brk                         ; 1E1FB:  00
b07_a1fc:   .db $ff                     ; 1E1FC:  ff
b07_a1fd:   .db $ff                     ; 1E1FD:  ff
b07_a1fe:   ror $7e7f,x                 ; 1E1FE:  7e 7f 7e
b07_a201:   .db $fc                     ; 1E201:  fc
b07_a202:   .db $af                     ; 1E202:  af
b07_a203:   .db $57                     ; 1E203:  57
b07_a204:   brk                         ; 1E204:  00
b07_a205:   ora ($00,x)                 ; 1E205:  01 00
b07_a207:   ora ($04,x)                 ; 1E207:  01 04
b07_a209:   ora ($00,x)                 ; 1E209:  01 00
b07_a20b:   brk                         ; 1E20B:  00
b07_a20c:   brk                         ; 1E20C:  00
b07_a20d:   brk                         ; 1E20D:  00
b07_a20e:   .db $80                     ; 1E20E:  80
b07_a20f:   .db $e2                     ; 1E20F:  e2
b07_a210:   beq $a202                   ; 1E210:  f0 f0
b07_a212:   cpy #$80                    ; 1E212:  c0 80
b07_a214:   .db $44                     ; 1E214:  44
b07_a215:   ora ($44),y                 ; 1E215:  11 44
b07_a217:   ora ($44),y                 ; 1E217:  11 44
b07_a219:   ora ($04),y                 ; 1E219:  11 04
b07_a21b:   ora ($88),y                 ; 1E21B:  11 88
b07_a21d:   .db $22                     ; 1E21D:  22
b07_a21e:   dey                         ; 1E21E:  88
b07_a21f:   .db $22                     ; 1E21F:  22
b07_a220:   dey                         ; 1E220:  88
b07_a221:   .db $22                     ; 1E221:  22
b07_a222:   php                         ; 1E222:  08
b07_a223:   .db $02                     ; 1E223:  02
b07_a224:   brk                         ; 1E224:  00
b07_a225:   brk                         ; 1E225:  00
b07_a226:   brk                         ; 1E226:  00
b07_a227:   brk                         ; 1E227:  00
b07_a228:   brk                         ; 1E228:  00
b07_a229:   brk                         ; 1E229:  00
b07_a22a:   brk                         ; 1E22A:  00
b07_a22b:   brk                         ; 1E22B:  00
b07_a22c:   brk                         ; 1E22C:  00
b07_a22d:   brk                         ; 1E22D:  00
b07_a22e:   brk                         ; 1E22E:  00
b07_a22f:   brk                         ; 1E22F:  00
b07_a230:   brk                         ; 1E230:  00
b07_a231:   brk                         ; 1E231:  00
b07_a232:   .db $80                     ; 1E232:  80
b07_a233:   cpy #$04                    ; 1E233:  c0 04
b07_a235:   ora ($44),y                 ; 1E235:  11 44
b07_a237:   ora ($44),y                 ; 1E237:  11 44
b07_a239:   ora ($44),y                 ; 1E239:  11 44
b07_a23b:   ora ($08),y                 ; 1E23B:  11 08
b07_a23d:   .db $22                     ; 1E23D:  22
b07_a23e:   dey                         ; 1E23E:  88
b07_a23f:   .db $22                     ; 1E23F:  22
b07_a240:   dey                         ; 1E240:  88
b07_a241:   .db $22                     ; 1E241:  22
b07_a242:   php                         ; 1E242:  08
b07_a243:   .db $22                     ; 1E243:  22
b07_a244:   .db $1f                     ; 1E244:  1f
b07_a245:   ora $00                     ; 1E245:  05 00
b07_a247:   rti                         ; 1E247:  40
b07_a248:   and ($10,x)                 ; 1E248:  21 10
b07_a24a:   rti                         ; 1E24A:  40
b07_a24b:   .db $0c                     ; 1E24B:  0c
b07_a24c:   rts                         ; 1E24C:  60
b07_a24d:   .db $7a                     ; 1E24D:  7a
b07_a24e:   .db $2f                     ; 1E24E:  2f
b07_a24f:   .db $07                     ; 1E24F:  07
b07_a250:   .db $80                     ; 1E250:  80
b07_a251:   .db $0c                     ; 1E251:  0c
b07_a252:   bcc $a268                   ; 1E252:  90 14
b07_a254:   .db $5a                     ; 1E254:  5a
b07_a255:   .db $07                     ; 1E255:  07
b07_a256:   rti                         ; 1E256:  40
b07_a257:   brk                         ; 1E257:  00
b07_a258:   eor ($0b,x)                 ; 1E258:  41 0b
b07_a25a:   .db $47                     ; 1E25A:  47
b07_a25b:   .db $17                     ; 1E25B:  17
b07_a25c:   .db $80                     ; 1E25C:  80
b07_a25d:   plp                         ; 1E25D:  28
b07_a25e:   .db $8f                     ; 1E25E:  8f
b07_a25f:   .db $2f                     ; 1E25F:  2f
b07_a260:   stx $8024                   ; 1E260:  8e 24 80
b07_a263:   jsr $80a0                   ; 1E263:  20 a0 80
b07_a266:   brk                         ; 1E266:  00
b07_a267:   brk                         ; 1E267:  00
b07_a268:   cpy $c5                     ; 1E268:  c4 c5
b07_a26a:   brk                         ; 1E26A:  00
b07_a26b:   ora ($5e,x)                 ; 1E26B:  01 5e
b07_a26d:   .db $7c                     ; 1E26D:  7c
b07_a26e:   beq $a211                   ; 1E26E:  f0 a1
b07_a270:   .db $12                     ; 1E270:  12
b07_a271:   and $fef8,y                 ; 1E271:  39 f8 fe
b07_a274:   php                         ; 1E274:  08
b07_a275:   .db $3c                     ; 1E275:  3c
b07_a276:   .db $0c                     ; 1E276:  0c
b07_a277:   .db $04                     ; 1E277:  04
b07_a278:   .db $0c                     ; 1E278:  0c
b07_a279:   tya                         ; 1E279:  98
b07_a27a:   beq $a2bc                   ; 1E27A:  f0 40
b07_a27c:   .db $03                     ; 1E27C:  03
b07_a27d:   .db $03                     ; 1E27D:  03
b07_a27e:   .db $f3                     ; 1E27E:  f3
b07_a27f:   .db $e3                     ; 1E27F:  e3
b07_a280:   .db $03                     ; 1E280:  03
b07_a281:   .db $87                     ; 1E281:  87
b07_a282:   .db $07                     ; 1E282:  07
b07_a283:   .db $1f                     ; 1E283:  1f
b07_a284:   brk                         ; 1E284:  00
b07_a285:   jsr $2130                   ; 1E285:  20 30 21
b07_a288:   and #$3d                    ; 1E288:  29 3d
b07_a28a:   rts                         ; 1E28A:  60
b07_a28b:   jsr $df7f                   ; 1E28B:  20 7f df
b07_a28e:   .db $cf                     ; 1E28E:  cf
b07_a28f:   lsr $40d2,x                 ; 1E28F:  5e d2 40
b07_a292:   ora ($0f,x)                 ; 1E292:  01 0f
b07_a294:   brk                         ; 1E294:  00
b07_a295:   .db $03                     ; 1E295:  03
b07_a296:   .db $0f                     ; 1E296:  0f
b07_a297:   .db $1f                     ; 1E297:  1f
b07_a298:   .db $ff                     ; 1E298:  ff
b07_a299:   .db $ff                     ; 1E299:  ff
b07_a29a:   inc $fffe,x                 ; 1E29A:  fe fe ff
b07_a29d:   .db $fc                     ; 1E29D:  fc
b07_a29e:   beq $a280                   ; 1E29E:  f0 e0
b07_a2a0:   brk                         ; 1E2A0:  00
b07_a2a1:   brk                         ; 1E2A1:  00
b07_a2a2:   ora ($01,x)                 ; 1E2A2:  01 01
b07_a2a4:   .db $07                     ; 1E2A4:  07
b07_a2a5:   ora #$09                    ; 1E2A5:  09 09
b07_a2a7:   ora ($05),y                 ; 1E2A7:  11 05
b07_a2a9:   ora #$19                    ; 1E2A9:  09 19
b07_a2ab:   .db $02                     ; 1E2AB:  02
b07_a2ac:   cpy #$c0                    ; 1E2AC:  c0 c0
b07_a2ae:   cpy #$e0                    ; 1E2AE:  c0 e0
b07_a2b0:   beq $a2a2                   ; 1E2B0:  f0 f0
b07_a2b2:   cpx #$f0                    ; 1E2B2:  e0 f0
b07_a2b4:   .db $44                     ; 1E2B4:  44
b07_a2b5:   ora ($44),y                 ; 1E2B5:  11 44
b07_a2b7:   ora ($44),y                 ; 1E2B7:  11 44
b07_a2b9:   ora ($44),y                 ; 1E2B9:  11 44
b07_a2bb:   ora ($08),y                 ; 1E2BB:  11 08
b07_a2bd:   .db $22                     ; 1E2BD:  22
b07_a2be:   php                         ; 1E2BE:  08
b07_a2bf:   .db $22                     ; 1E2BF:  22
b07_a2c0:   php                         ; 1E2C0:  08
b07_a2c1:   .db $22                     ; 1E2C1:  22
b07_a2c2:   php                         ; 1E2C2:  08
b07_a2c3:   .db $22                     ; 1E2C3:  22
b07_a2c4:   asl $808c                   ; 1E2C4:  0e 8c 80
b07_a2c7:   brk                         ; 1E2C7:  00
b07_a2c8:   brk                         ; 1E2C8:  00
b07_a2c9:   brk                         ; 1E2C9:  00
b07_a2ca:   brk                         ; 1E2CA:  00
b07_a2cb:   bpl $a2bd                   ; 1E2CB:  10 f0
b07_a2cd:   bvs $a347                   ; 1E2CD:  70 78
b07_a2cf:   .db $fa                     ; 1E2CF:  fa
b07_a2d0:   inc $f7f6,x                 ; 1E2D0:  fe f6 f7
b07_a2d3:   .db $e7                     ; 1E2D3:  e7
b07_a2d4:   .db $44                     ; 1E2D4:  44
b07_a2d5:   ora ($44),y                 ; 1E2D5:  11 44
b07_a2d7:   ora ($44),y                 ; 1E2D7:  11 44
b07_a2d9:   ora ($04),y                 ; 1E2D9:  11 04
b07_a2db:   eor ($08),y                 ; 1E2DB:  51 08
b07_a2dd:   .db $22                     ; 1E2DD:  22
b07_a2de:   dey                         ; 1E2DE:  88
b07_a2df:   .db $22                     ; 1E2DF:  22
b07_a2e0:   dey                         ; 1E2E0:  88
b07_a2e1:   .db $22                     ; 1E2E1:  22
b07_a2e2:   php                         ; 1E2E2:  08
b07_a2e3:   .db $42                     ; 1E2E3:  42
b07_a2e4:   .db $44                     ; 1E2E4:  44
b07_a2e5:   ora ($44),y                 ; 1E2E5:  11 44
b07_a2e7:   ora ($44),y                 ; 1E2E7:  11 44
b07_a2e9:   bpl $a332                   ; 1E2E9:  10 47
b07_a2eb:   .db $3b                     ; 1E2EB:  3b
b07_a2ec:   dey                         ; 1E2EC:  88
b07_a2ed:   .db $22                     ; 1E2ED:  22
b07_a2ee:   dey                         ; 1E2EE:  88
b07_a2ef:   .db $22                     ; 1E2EF:  22
b07_a2f0:   dey                         ; 1E2F0:  88
b07_a2f1:   jsr $3b87                   ; 1E2F1:  20 87 3b
b07_a2f4:   .db $43                     ; 1E2F4:  43
b07_a2f5:   .db $13                     ; 1E2F5:  13
b07_a2f6:   eor $02                     ; 1E2F6:  45 02
b07_a2f8:   asl $b0f6,x                 ; 1E2F8:  1e f6 b0
b07_a2fb:   .db $80                     ; 1E2FB:  80
b07_a2fc:   dey                         ; 1E2FC:  88
b07_a2fd:   jsr $2288                   ; 1E2FD:  20 88 22
b07_a300:   asl $b0f6,x                 ; 1E300:  1e f6 b0
b07_a303:   .db $83                     ; 1E303:  83
b07_a304:   .db $3a                     ; 1E304:  3a
b07_a305:   bmi $a307                   ; 1E305:  30 00
b07_a307:   brk                         ; 1E307:  00
b07_a308:   brk                         ; 1E308:  00
b07_a309:   brk                         ; 1E309:  00
b07_a30a:   brk                         ; 1E30A:  00
b07_a30b:   brk                         ; 1E30B:  00
b07_a30c:   tsx                         ; 1E30C:  ba
b07_a30d:   bmi $a295                   ; 1E30D:  30 86
b07_a30f:   .db $37                     ; 1E30F:  37
b07_a310:   .db $7c                     ; 1E310:  7c
b07_a311:   adc ($0d,x)                 ; 1E311:  61 0d
b07_a313:   jmp ($0000)                 ; 1E313:  6c 00 00
b07_a316:   brk                         ; 1E316:  00
b07_a317:   brk                         ; 1E317:  00
b07_a318:   brk                         ; 1E318:  00
b07_a319:   .db $02                     ; 1E319:  02
b07_a31a:   jsr $1b88                   ; 1E31A:  20 88 1b
b07_a31d:   dec $86f0,x                 ; 1E31D:  de f0 86
b07_a320:   bmi $a2a4                   ; 1E320:  30 82
b07_a322:   jsr $8088                   ; 1E322:  20 88 80
b07_a325:   .db $bf                     ; 1E325:  bf
b07_a326:   cpy $df                     ; 1E326:  c4 df
b07_a328:   adc ($3a),y                 ; 1E328:  71 3a
b07_a32a:   .db $1f                     ; 1E32A:  1f
b07_a32b:   .db $0f                     ; 1E32B:  0f
b07_a32c:   .db $7f                     ; 1E32C:  7f
b07_a32d:   rti                         ; 1E32D:  40
b07_a32e:   brk                         ; 1E32E:  00
b07_a32f:   brk                         ; 1E32F:  00
b07_a330:   brk                         ; 1E330:  00
b07_a331:   brk                         ; 1E331:  00
b07_a332:   rti                         ; 1E332:  40
b07_a333:   rts                         ; 1E333:  60
b07_a334:   .db $7f                     ; 1E334:  7f
b07_a335:   .db $3f                     ; 1E335:  3f
b07_a336:   .db $9f                     ; 1E336:  9f
b07_a337:   .db $1f                     ; 1E337:  1f
b07_a338:   .db $df                     ; 1E338:  df
b07_a339:   .db $ff                     ; 1E339:  ff
b07_a33a:   inc $80fc,x                 ; 1E33A:  fe fc 80
b07_a33d:   rti                         ; 1E33D:  40
b07_a33e:   jsr $0000                   ; 1E33E:  20 00 00
b07_a341:   brk                         ; 1E341:  00
b07_a342:   brk                         ; 1E342:  00
b07_a343:   brk                         ; 1E343:  00
b07_a344:   .db $0f                     ; 1E344:  0f
b07_a345:   .db $03                     ; 1E345:  03
b07_a346:   brk                         ; 1E346:  00
b07_a347:   asl a                       ; 1E347:  0a
b07_a348:   .db $02                     ; 1E348:  02
b07_a349:   asl a                       ; 1E349:  0a
b07_a34a:   .db $83                     ; 1E34A:  83
b07_a34b:   .db $8b                     ; 1E34B:  8b
b07_a34c:   cpy #$00                    ; 1E34C:  c0 00
b07_a34e:   .db $80                     ; 1E34E:  80
b07_a34f:   asl a                       ; 1E34F:  0a
b07_a350:   .db $02                     ; 1E350:  02
b07_a351:   asl a                       ; 1E351:  0a
b07_a352:   .db $83                     ; 1E352:  83
b07_a353:   .db $8b                     ; 1E353:  8b
b07_a354:   sbc $07e3,y                 ; 1E354:  f9 e3 07
b07_a357:   .db $0f                     ; 1E357:  0f
b07_a358:   inc $7bfd,x                 ; 1E358:  fe fd 7b
b07_a35b:   .db $77                     ; 1E35B:  77
b07_a35c:   brk                         ; 1E35C:  00
b07_a35d:   brk                         ; 1E35D:  00
b07_a35e:   brk                         ; 1E35E:  00
b07_a35f:   brk                         ; 1E35F:  00
b07_a360:   brk                         ; 1E360:  00
b07_a361:   ora ($03,x)                 ; 1E361:  01 03
b07_a363:   .db $07                     ; 1E363:  07
b07_a364:   jsr $c060                   ; 1E364:  20 60 c0
b07_a367:   iny                         ; 1E367:  c8
b07_a368:   tya                         ; 1E368:  98
b07_a369:   and $f67b,y                 ; 1E369:  39 7b f6
b07_a36c:   .db $cf                     ; 1E36C:  cf
b07_a36d:   .db $8f                     ; 1E36D:  8f
b07_a36e:   .db $1f                     ; 1E36E:  1f
b07_a36f:   .db $17                     ; 1E36F:  17
b07_a370:   rol $45                     ; 1E370:  26 45
b07_a372:   .db $03                     ; 1E372:  03
b07_a373:   asl $24                     ; 1E373:  06 24
b07_a375:   bmi $a3da                   ; 1E375:  30 63
b07_a377:   ora $6e6d,x                 ; 1E377:  1d 6d 6e
b07_a37a:   bmi $a2fc                   ; 1E37A:  30 80
b07_a37c:   tay                         ; 1E37C:  a8
b07_a37d:   bcs $a3e2                   ; 1E37D:  b0 63
b07_a37f:   ora $6e6d,x                 ; 1E37F:  1d 6d 6e
b07_a382:   and ($8d),y                 ; 1E382:  31 8d
b07_a384:   cpx $b0da                   ; 1E384:  ec da b0
b07_a387:   ror a                       ; 1E387:  6a
b07_a388:   cpy #$c8                    ; 1E388:  c0 c8
b07_a38a:   ldy #$02                    ; 1E38A:  a0 02
b07_a38c:   .db $0c                     ; 1E38C:  0c
b07_a38d:   .db $1a                     ; 1E38D:  1a
b07_a38e:   bmi $a3fa                   ; 1E38E:  30 6a
b07_a390:   cpy #$c8                    ; 1E390:  c0 c8
b07_a392:   ldy #$02                    ; 1E392:  a0 02
b07_a394:   brk                         ; 1E394:  00
b07_a395:   .db $80                     ; 1E395:  80
b07_a396:   jsr $a020                   ; 1E396:  20 20 a0
b07_a399:   dey                         ; 1E399:  88
b07_a39a:   .db $80                     ; 1E39A:  80
b07_a39b:   dey                         ; 1E39B:  88
b07_a39c:   .db $1f                     ; 1E39C:  1f
b07_a39d:   sty $2723                   ; 1E39D:  8c 23 27
b07_a3a0:   ldx #$89                    ; 1E3A0:  a2 89
b07_a3a2:   sta ($88,x)                 ; 1E3A2:  81 88
b07_a3a4:   .db $22                     ; 1E3A4:  22
b07_a3a5:   bpl $a32f                   ; 1E3A5:  10 88
b07_a3a7:   .db $44                     ; 1E3A7:  44
b07_a3a8:   .db $22                     ; 1E3A8:  22
b07_a3a9:   ora ($88),y                 ; 1E3A9:  11 88
b07_a3ab:   .db $44                     ; 1E3AB:  44
b07_a3ac:   inc $aa74                   ; 1E3AC:  ee 74 aa
b07_a3af:   cmp $77ee,x                 ; 1E3AF:  dd ee 77
b07_a3b2:   tax                         ; 1E3B2:  aa
b07_a3b3:   cmp $0000,x                 ; 1E3B3:  dd 00 00
b07_a3b6:   brk                         ; 1E3B6:  00
b07_a3b7:   rti                         ; 1E3B7:  40
b07_a3b8:   brk                         ; 1E3B8:  00
b07_a3b9:   brk                         ; 1E3B9:  00
b07_a3ba:   .db $80                     ; 1E3BA:  80
b07_a3bb:   rti                         ; 1E3BB:  40
b07_a3bc:   cpy #$00                    ; 1E3BC:  c0 00
b07_a3be:   brk                         ; 1E3BE:  00
b07_a3bf:   cpy #$c0                    ; 1E3BF:  c0 c0
b07_a3c1:   .db $62                     ; 1E3C1:  62
b07_a3c2:   lda $cb                     ; 1E3C2:  a5 cb
b07_a3c4:   .db $22                     ; 1E3C4:  22
b07_a3c5:   ora ($88),y                 ; 1E3C5:  11 88
b07_a3c7:   .db $44                     ; 1E3C7:  44
b07_a3c8:   .db $22                     ; 1E3C8:  22
b07_a3c9:   ora ($88),y                 ; 1E3C9:  11 88
b07_a3cb:   .db $44                     ; 1E3CB:  44
b07_a3cc:   inc $aa77                   ; 1E3CC:  ee 77 aa
b07_a3cf:   cmp $77ee,x                 ; 1E3CF:  dd ee 77
b07_a3d2:   tax                         ; 1E3D2:  aa
b07_a3d3:   cmp $0000,x                 ; 1E3D3:  dd 00 00
b07_a3d6:   .db $80                     ; 1E3D6:  80
b07_a3d7:   brk                         ; 1E3D7:  00
b07_a3d8:   brk                         ; 1E3D8:  00
b07_a3d9:   brk                         ; 1E3D9:  00
b07_a3da:   .db $80                     ; 1E3DA:  80
b07_a3db:   brk                         ; 1E3DB:  00
b07_a3dc:   .db $cb                     ; 1E3DC:  cb
b07_a3dd:   .db $47                     ; 1E3DD:  47
b07_a3de:   .db $87                     ; 1E3DE:  87
b07_a3df:   .db $87                     ; 1E3DF:  87
b07_a3e0:   .db $83                     ; 1E3E0:  83
b07_a3e1:   brk                         ; 1E3E1:  00
b07_a3e2:   sta ($80,x)                 ; 1E3E2:  81 80
b07_a3e4:   brk                         ; 1E3E4:  00
b07_a3e5:   rol $0001                   ; 1E3E5:  2e 01 00
b07_a3e8:   brk                         ; 1E3E8:  00
b07_a3e9:   brk                         ; 1E3E9:  00
b07_a3ea:   brk                         ; 1E3EA:  00
b07_a3eb:   brk                         ; 1E3EB:  00
b07_a3ec:   brk                         ; 1E3EC:  00
b07_a3ed:   rol $0001                   ; 1E3ED:  2e 01 00
b07_a3f0:   brk                         ; 1E3F0:  00
b07_a3f1:   cpy #$f8                    ; 1E3F1:  c0 f8
b07_a3f3:   .db $ff                     ; 1E3F3:  ff
b07_a3f4:   .db $02                     ; 1E3F4:  02
b07_a3f5:   ora ($c0,x)                 ; 1E3F5:  01 c0
b07_a3f7:   sec                         ; 1E3F7:  38
b07_a3f8:   asl $00                     ; 1E3F8:  06 00
b07_a3fa:   ora ($00,x)                 ; 1E3FA:  01 00
b07_a3fc:   .db $02                     ; 1E3FC:  02
b07_a3fd:   ora ($c0,x)                 ; 1E3FD:  01 c0
b07_a3ff:   sec                         ; 1E3FF:  38
b07_a400:   asl $00                     ; 1E400:  06 00
b07_a402:   ora ($00,x)                 ; 1E402:  01 00
b07_a404:   .db $0c                     ; 1E404:  0c
b07_a405:   .db $1f                     ; 1E405:  1f
b07_a406:   .db $1f                     ; 1E406:  1f
b07_a407:   .db $1f                     ; 1E407:  1f
b07_a408:   .db $1f                     ; 1E408:  1f
b07_a409:   .db $3f                     ; 1E409:  3f
b07_a40a:   .db $3f                     ; 1E40A:  3f
b07_a40b:   .db $0b                     ; 1E40B:  0b
b07_a40c:   .db $f3                     ; 1E40C:  f3
b07_a40d:   cpx #$e0                    ; 1E40D:  e0 e0
b07_a40f:   cpx #$e0                    ; 1E40F:  e0 e0
b07_a411:   cpy #$c0                    ; 1E411:  c0 c0
b07_a413:   cpx #$01                    ; 1E413:  e0 01
b07_a415:   brk                         ; 1E415:  00
b07_a416:   .db $c3                     ; 1E416:  c3
b07_a417:   .db $ff                     ; 1E417:  ff
b07_a418:   .db $ff                     ; 1E418:  ff
b07_a419:   .db $ff                     ; 1E419:  ff
b07_a41a:   .db $ff                     ; 1E41A:  ff
b07_a41b:   .db $ff                     ; 1E41B:  ff
b07_a41c:   cmp ($ff,x)                 ; 1E41C:  c1 ff
b07_a41e:   .db $3c                     ; 1E41E:  3c
b07_a41f:   brk                         ; 1E41F:  00
b07_a420:   brk                         ; 1E420:  00
b07_a421:   brk                         ; 1E421:  00
b07_a422:   brk                         ; 1E422:  00
b07_a423:   brk                         ; 1E423:  00
b07_a424:   ldx #$41                    ; 1E424:  a2 41
b07_a426:   tay                         ; 1E426:  a8
b07_a427:   cpy $82                     ; 1E427:  c4 82
b07_a429:   sta ($28),y                 ; 1E429:  91 28
b07_a42b:   ldy $ae,x                   ; 1E42B:  b4 ae
b07_a42d:   .db $47                     ; 1E42D:  47
b07_a42e:   tax                         ; 1E42E:  aa
b07_a42f:   cmp $978e,x                 ; 1E42F:  dd 8e 97
b07_a432:   asl a                       ; 1E432:  0a
b07_a433:   sta $72                     ; 1E433:  85 72
b07_a435:   sbc $fcf8,y                 ; 1E435:  f9 f8 fc
b07_a438:   .db $fc                     ; 1E438:  fc
b07_a439:   sbc $d6fe,x                 ; 1E439:  fd fe d6
b07_a43c:   asl $03                     ; 1E43C:  06 03
b07_a43e:   .db $02                     ; 1E43E:  02
b07_a43f:   ora ($00,x)                 ; 1E43F:  01 00
b07_a441:   ora ($00,x)                 ; 1E441:  01 00
b07_a443:   brk                         ; 1E443:  00
b07_a444:   .db $22                     ; 1E444:  22
b07_a445:   ora ($88),y                 ; 1E445:  11 88
b07_a447:   .db $44                     ; 1E447:  44
b07_a448:   .db $22                     ; 1E448:  22
b07_a449:   bpl $a3d3                   ; 1E449:  10 88
b07_a44b:   .db $44                     ; 1E44B:  44
b07_a44c:   inc $aa77                   ; 1E44C:  ee 77 aa
b07_a44f:   cmp $76ee,x                 ; 1E44F:  dd ee 76
b07_a452:   tax                         ; 1E452:  aa
b07_a453:   .db $dc                     ; 1E453:  dc
b07_a454:   brk                         ; 1E454:  00
b07_a455:   brk                         ; 1E455:  00
b07_a456:   .db $80                     ; 1E456:  80
b07_a457:   brk                         ; 1E457:  00
b07_a458:   cpx #$90                    ; 1E458:  e0 90
b07_a45a:   .db $80                     ; 1E45A:  80
b07_a45b:   .db $80                     ; 1E45B:  80
b07_a45c:   sta ($01,x)                 ; 1E45C:  81 01
b07_a45e:   sta ($03,x)                 ; 1E45E:  81 03
b07_a460:   ora ($03,x)                 ; 1E460:  01 03
b07_a462:   and #$41                    ; 1E462:  29 41
b07_a464:   .db $80                     ; 1E464:  80
b07_a465:   rti                         ; 1E465:  40
b07_a466:   rti                         ; 1E466:  40
b07_a467:   jsr $0010                   ; 1E467:  20 10 00
b07_a46a:   .db $80                     ; 1E46A:  80
b07_a46b:   rti                         ; 1E46B:  40
b07_a46c:   eor $2d                     ; 1E46C:  45 2d
b07_a46e:   and ($95),y                 ; 1E46E:  31 95
b07_a470:   cmp $a161                   ; 1E470:  cd 61 a1
b07_a473:   bne $a476                   ; 1E473:  d0 01
b07_a475:   brk                         ; 1E475:  00
b07_a476:   .db $0f                     ; 1E476:  0f
b07_a477:   .db $1f                     ; 1E477:  1f
b07_a478:   brk                         ; 1E478:  00
b07_a479:   ora #$1f                    ; 1E479:  09 1f
b07_a47b:   .db $2f                     ; 1E47B:  2f
b07_a47c:   bne $a472                   ; 1E47C:  d0 f4
b07_a47e:   beq $a460                   ; 1E47E:  f0 e0
b07_a480:   cpy #$e9                    ; 1E480:  c0 e9
b07_a482:   cpx #$d0                    ; 1E482:  e0 d0
b07_a484:   .db $7f                     ; 1E484:  7f
b07_a485:   .db $3f                     ; 1E485:  3f
b07_a486:   asl $04cc,x                 ; 1E486:  1e cc 04
b07_a489:   .db $0c                     ; 1E489:  0c
b07_a48a:   sty $0006                   ; 1E48A:  8c 06 00
b07_a48d:   brk                         ; 1E48D:  00
b07_a48e:   cpx #$31                    ; 1E48E:  e0 31
b07_a490:   adc $3170,y                 ; 1E490:  79 70 31
b07_a493:   sei                         ; 1E493:  78
b07_a494:   .db $7c                     ; 1E494:  7c
b07_a495:   .db $7f                     ; 1E495:  7f
b07_a496:   .db $7f                     ; 1E496:  7f
b07_a497:   .db $7f                     ; 1E497:  7f
b07_a498:   .db $7f                     ; 1E498:  7f
b07_a499:   .db $7f                     ; 1E499:  7f
b07_a49a:   rol $811c,x                 ; 1E49A:  3e 1c 81
b07_a49d:   .db $80                     ; 1E49D:  80
b07_a49e:   .db $80                     ; 1E49E:  80
b07_a49f:   .db $80                     ; 1E49F:  80
b07_a4a0:   .db $80                     ; 1E4A0:  80
b07_a4a1:   .db $80                     ; 1E4A1:  80
b07_a4a2:   cpy #$e1                    ; 1E4A2:  c0 e1
b07_a4a4:   lsr $c6                     ; 1E4A4:  46 c6
b07_a4a6:   dec $cf                     ; 1E4A6:  c6 cf
b07_a4a8:   .db $8f                     ; 1E4A8:  8f
b07_a4a9:   asl $40                     ; 1E4A9:  06 40
b07_a4ab:   sbc ($b8,x)                 ; 1E4AB:  e1 b8
b07_a4ad:   sec                         ; 1E4AD:  38
b07_a4ae:   plp                         ; 1E4AE:  28
b07_a4af:   bpl $a4c1                   ; 1E4AF:  10 10
b07_a4b1:   rti                         ; 1E4B1:  40
b07_a4b2:   lda $ca1e,y                 ; 1E4B2:  b9 1e ca
b07_a4b5:   asl $74                     ; 1E4B5:  06 74
b07_a4b7:   .db $fc                     ; 1E4B7:  fc
b07_a4b8:   .db $04                     ; 1E4B8:  04
b07_a4b9:   sta $fc,x                   ; 1E4B9:  95 fc
b07_a4bb:   .db $7c                     ; 1E4BB:  7c
b07_a4bc:   brk                         ; 1E4BC:  00
b07_a4bd:   bpl $a447                   ; 1E4BD:  10 88
b07_a4bf:   ora ($00,x)                 ; 1E4BF:  01 00
b07_a4c1:   sta ($00),y                 ; 1E4C1:  91 00
b07_a4c3:   sta ($3c,x)                 ; 1E4C3:  81 3c
b07_a4c5:   sbc $7cfc,x                 ; 1E4C5:  fd fc 7c
b07_a4c8:   .db $7c                     ; 1E4C8:  7c
b07_a4c9:   adc $b8b8,x                 ; 1E4C9:  7d b8 b8
b07_a4cc:   cpy #$01                    ; 1E4CC:  c0 01
b07_a4ce:   brk                         ; 1E4CE:  00
b07_a4cf:   ora ($00,x)                 ; 1E4CF:  01 00
b07_a4d1:   ora ($02,x)                 ; 1E4D1:  01 02
b07_a4d3:   eor ($22,x)                 ; 1E4D3:  41 22
b07_a4d5:   ora ($88),y                 ; 1E4D5:  11 88
b07_a4d7:   .db $44                     ; 1E4D7:  44
b07_a4d8:   .db $22                     ; 1E4D8:  22
b07_a4d9:   ora ($88),y                 ; 1E4D9:  11 88
b07_a4db:   rti                         ; 1E4DB:  40
b07_a4dc:   inc $aa77                   ; 1E4DC:  ee 77 aa
b07_a4df:   cmp $77ee,x                 ; 1E4DF:  dd ee 77
b07_a4e2:   tax                         ; 1E4E2:  aa
b07_a4e3:   cld                         ; 1E4E3:  d8
b07_a4e4:   jsr $8010                   ; 1E4E4:  20 10 80
b07_a4e7:   rti                         ; 1E4E7:  40
b07_a4e8:   bpl $a4ea                   ; 1E4E8:  10 00
b07_a4ea:   clv                         ; 1E4EA:  b8
b07_a4eb:   plp                         ; 1E4EB:  28
b07_a4ec:   inc $74                     ; 1E4EC:  e6 74
b07_a4ee:   ldy $c6                     ; 1E4EE:  a4 c6
b07_a4f0:   .db $d7                     ; 1E4F0:  d7
b07_a4f1:   .db $47                     ; 1E4F1:  47
b07_a4f2:   .db $bb                     ; 1E4F2:  bb
b07_a4f3:   .db $2b                     ; 1E4F3:  2b
b07_a4f4:   .db $03                     ; 1E4F4:  03
b07_a4f5:   inc $eebb                   ; 1E4F5:  ee bb ee
b07_a4f8:   .db $fb                     ; 1E4F8:  fb
b07_a4f9:   inc $ffff,x                 ; 1E4F9:  fe ff ff
b07_a4fc:   .db $03                     ; 1E4FC:  03
b07_a4fd:   inc $eebb                   ; 1E4FD:  ee bb ee
b07_a500:   .db $fb                     ; 1E500:  fb
b07_a501:   inc $ffff,x                 ; 1E501:  fe ff ff
b07_a504:   clv                         ; 1E504:  b8
b07_a505:   ldy $aeba                   ; 1E505:  ac ba ae
b07_a508:   .db $bb                     ; 1E508:  bb
b07_a509:   .db $af                     ; 1E509:  af
b07_a50a:   .db $bf                     ; 1E50A:  bf
b07_a50b:   .db $af                     ; 1E50B:  af
b07_a50c:   lda $baad,y                 ; 1E50C:  b9 ad ba
b07_a50f:   ldx $afbb                   ; 1E50F:  ae bb af
b07_a512:   .db $bf                     ; 1E512:  bf
b07_a513:   .db $af                     ; 1E513:  af
b07_a514:   ora $1c1d,x                 ; 1E514:  1d 1d 1c
b07_a517:   .db $0c                     ; 1E517:  0c
b07_a518:   asl $0707                   ; 1E518:  0e 07 07
b07_a51b:   .db $03                     ; 1E51B:  03
b07_a51c:   .db $e2                     ; 1E51C:  e2
b07_a51d:   .db $e2                     ; 1E51D:  e2
b07_a51e:   .db $e2                     ; 1E51E:  e2
b07_a51f:   .db $f2                     ; 1E51F:  f2
b07_a520:   adc ($78),y                 ; 1E520:  71 78
b07_a522:   clv                         ; 1E522:  b8
b07_a523:   cpy $84ff                   ; 1E523:  cc ff 84
b07_a526:   .db $3f                     ; 1E526:  3f
b07_a527:   sbc ($e1),y                 ; 1E527:  f1 e1
b07_a529:   sbc ($ff),y                 ; 1E529:  f1 ff
b07_a52b:   .db $ff                     ; 1E52B:  ff
b07_a52c:   brk                         ; 1E52C:  00
b07_a52d:   brk                         ; 1E52D:  00
b07_a52e:   brk                         ; 1E52E:  00
b07_a52f:   brk                         ; 1E52F:  00
b07_a530:   .db $0c                     ; 1E530:  0c
b07_a531:   asl $0000                   ; 1E531:  0e 00 00
b07_a534:   ora ($00,x)                 ; 1E534:  01 00
b07_a536:   brk                         ; 1E536:  00
b07_a537:   brk                         ; 1E537:  00
b07_a538:   brk                         ; 1E538:  00
b07_a539:   rti                         ; 1E539:  40
b07_a53a:   ldy #$90                    ; 1E53A:  a0 90
b07_a53c:   .db $e2                     ; 1E53C:  e2
b07_a53d:   beq $a53b                   ; 1E53D:  f0 fc
b07_a53f:   ror $5d3d,x                 ; 1E53F:  7e 3d 5d
b07_a542:   ldx $ffb7                   ; 1E542:  ae b7 ff
b07_a545:   .db $7f                     ; 1E545:  7f
b07_a546:   brk                         ; 1E546:  00
b07_a547:   brk                         ; 1E547:  00
b07_a548:   asl $06                     ; 1E548:  06 06
b07_a54a:   ora ($36),y                 ; 1E54A:  11 36
b07_a54c:   brk                         ; 1E54C:  00
b07_a54d:   .db $80                     ; 1E54D:  80
b07_a54e:   brk                         ; 1E54E:  00
b07_a54f:   brk                         ; 1E54F:  00
b07_a550:   iny                         ; 1E550:  c8
b07_a551:   bcc $a573                   ; 1E551:  90 20
b07_a553:   .db $80                     ; 1E553:  80
b07_a554:   tsx                         ; 1E554:  ba
b07_a555:   and $b4b0,y                 ; 1E555:  39 b0 b4
b07_a558:   .db $f2                     ; 1E558:  f2
b07_a559:   sbc ($e8,x)                 ; 1E559:  e1 e8
b07_a55b:   cpy #$42                    ; 1E55B:  c0 42
b07_a55d:   .db $43                     ; 1E55D:  43
b07_a55e:   .db $02                     ; 1E55E:  02
b07_a55f:   eor $06                     ; 1E55F:  45 06
b07_a561:   .db $07                     ; 1E561:  07
b07_a562:   asl a                       ; 1E562:  0a
b07_a563:   ora ($ae,x)                 ; 1E563:  01 ae
b07_a565:   .db $17                     ; 1E565:  17
b07_a566:   .db $17                     ; 1E566:  17
b07_a567:   .db $9b                     ; 1E567:  9b
b07_a568:   .db $8b                     ; 1E568:  8b
b07_a569:   and $ad4d                   ; 1E569:  2d 4d ad
b07_a56c:   rol $1717                   ; 1E56C:  2e 17 17
b07_a56f:   .db $1b                     ; 1E56F:  1b
b07_a570:   .db $0b                     ; 1E570:  0b
b07_a571:   and $ed6d                   ; 1E571:  2d 6d ed
b07_a574:   .db $02                     ; 1E574:  02
b07_a575:   .db $fc                     ; 1E575:  fc
b07_a576:   .db $ff                     ; 1E576:  ff
b07_a577:   .db $ff                     ; 1E577:  ff
b07_a578:   .db $ff                     ; 1E578:  ff
b07_a579:   .db $ff                     ; 1E579:  ff
b07_a57a:   .db $ff                     ; 1E57A:  ff
b07_a57b:   .db $ff                     ; 1E57B:  ff
b07_a57c:   .db $02                     ; 1E57C:  02
b07_a57d:   .db $fc                     ; 1E57D:  fc
b07_a57e:   .db $ff                     ; 1E57E:  ff
b07_a57f:   .db $ff                     ; 1E57F:  ff
b07_a580:   .db $ff                     ; 1E580:  ff
b07_a581:   .db $ff                     ; 1E581:  ff
b07_a582:   .db $ff                     ; 1E582:  ff
b07_a583:   .db $ff                     ; 1E583:  ff
b07_a584:   .db $44                     ; 1E584:  44
b07_a585:   ora ($44),y                 ; 1E585:  11 44
b07_a587:   ora ($44),y                 ; 1E587:  11 44
b07_a589:   ora ($44),y                 ; 1E589:  11 44
b07_a58b:   ora ($77),y                 ; 1E58B:  11 77
b07_a58d:   cmp $dd77,x                 ; 1E58D:  dd 77 dd
b07_a590:   .db $77                     ; 1E590:  77
b07_a591:   cmp $dd77,x                 ; 1E591:  dd 77 dd
b07_a594:   .db $44                     ; 1E594:  44
b07_a595:   ora ($44),y                 ; 1E595:  11 44
b07_a597:   .db $13                     ; 1E597:  13
b07_a598:   .db $47                     ; 1E598:  47
b07_a599:   .db $1f                     ; 1E599:  1f
b07_a59a:   .db $5f                     ; 1E59A:  5f
b07_a59b:   .db $1f                     ; 1E59B:  1f
b07_a59c:   .db $77                     ; 1E59C:  77
b07_a59d:   cmp $dc77,x                 ; 1E59D:  dd 77 dc
b07_a5a0:   bvs $a572                   ; 1E5A0:  70 d0
b07_a5a2:   rts                         ; 1E5A2:  60
b07_a5a3:   cpy #$44                    ; 1E5A3:  c0 44
b07_a5a5:   ora ($44),y                 ; 1E5A5:  11 44
b07_a5a7:   ora ($44),y                 ; 1E5A7:  11 44
b07_a5a9:   ora ($44),y                 ; 1E5A9:  11 44
b07_a5ab:   bpl $a624                   ; 1E5AB:  10 77
b07_a5ad:   cmp $dd77,x                 ; 1E5AD:  dd 77 dd
b07_a5b0:   .db $77                     ; 1E5B0:  77
b07_a5b1:   cmp $dc77,x                 ; 1E5B1:  dd 77 dc
b07_a5b4:   .db $5f                     ; 1E5B4:  5f
b07_a5b5:   .db $3f                     ; 1E5B5:  3f
b07_a5b6:   .db $1f                     ; 1E5B6:  1f
b07_a5b7:   .db $3f                     ; 1E5B7:  3f
b07_a5b8:   .db $1f                     ; 1E5B8:  1f
b07_a5b9:   .db $0f                     ; 1E5B9:  0f
b07_a5ba:   .db $17                     ; 1E5BA:  17
b07_a5bb:   asl a                       ; 1E5BB:  0a
b07_a5bc:   rti                         ; 1E5BC:  40
b07_a5bd:   .db $80                     ; 1E5BD:  80
b07_a5be:   brk                         ; 1E5BE:  00
b07_a5bf:   brk                         ; 1E5BF:  00
b07_a5c0:   brk                         ; 1E5C0:  00
b07_a5c1:   brk                         ; 1E5C1:  00
b07_a5c2:   brk                         ; 1E5C2:  00
b07_a5c3:   brk                         ; 1E5C3:  00
b07_a5c4:   .db $44                     ; 1E5C4:  44
b07_a5c5:   .db $1f                     ; 1E5C5:  1f
b07_a5c6:   .db $ff                     ; 1E5C6:  ff
b07_a5c7:   .db $ff                     ; 1E5C7:  ff
b07_a5c8:   .db $ff                     ; 1E5C8:  ff
b07_a5c9:   .db $ff                     ; 1E5C9:  ff
b07_a5ca:   .db $ff                     ; 1E5CA:  ff
b07_a5cb:   .db $ff                     ; 1E5CB:  ff
b07_a5cc:   .db $77                     ; 1E5CC:  77
b07_a5cd:   cpy #$00                    ; 1E5CD:  c0 00
b07_a5cf:   brk                         ; 1E5CF:  00
b07_a5d0:   brk                         ; 1E5D0:  00
b07_a5d1:   brk                         ; 1E5D1:  00
b07_a5d2:   brk                         ; 1E5D2:  00
b07_a5d3:   brk                         ; 1E5D3:  00
b07_a5d4:   .db $44                     ; 1E5D4:  44
b07_a5d5:   sbc ($f8),y                 ; 1E5D5:  f1 f8
b07_a5d7:   .db $fc                     ; 1E5D7:  fc
b07_a5d8:   inc $ffff,x                 ; 1E5D8:  fe ff ff
b07_a5db:   .db $ff                     ; 1E5DB:  ff
b07_a5dc:   .db $77                     ; 1E5DC:  77
b07_a5dd:   ora $06                     ; 1E5DD:  05 06
b07_a5df:   .db $03                     ; 1E5DF:  03
b07_a5e0:   ora ($00,x)                 ; 1E5E0:  01 00
b07_a5e2:   brk                         ; 1E5E2:  00
b07_a5e3:   brk                         ; 1E5E3:  00
b07_a5e4:   .db $ff                     ; 1E5E4:  ff
b07_a5e5:   .db $ff                     ; 1E5E5:  ff
b07_a5e6:   .db $ff                     ; 1E5E6:  ff
b07_a5e7:   .db $ff                     ; 1E5E7:  ff
b07_a5e8:   .db $ff                     ; 1E5E8:  ff
b07_a5e9:   .db $ff                     ; 1E5E9:  ff
b07_a5ea:   .db $ff                     ; 1E5EA:  ff
b07_a5eb:   .db $f3                     ; 1E5EB:  f3
b07_a5ec:   brk                         ; 1E5EC:  00
b07_a5ed:   brk                         ; 1E5ED:  00
b07_a5ee:   brk                         ; 1E5EE:  00
b07_a5ef:   brk                         ; 1E5EF:  00
b07_a5f0:   brk                         ; 1E5F0:  00
b07_a5f1:   brk                         ; 1E5F1:  00
b07_a5f2:   brk                         ; 1E5F2:  00
b07_a5f3:   brk                         ; 1E5F3:  00
b07_a5f4:   .db $ff                     ; 1E5F4:  ff
b07_a5f5:   .db $ff                     ; 1E5F5:  ff
b07_a5f6:   .db $ff                     ; 1E5F6:  ff
b07_a5f7:   .db $ff                     ; 1E5F7:  ff
b07_a5f8:   .db $ff                     ; 1E5F8:  ff
b07_a5f9:   .db $df                     ; 1E5F9:  df
b07_a5fa:   .db $e7                     ; 1E5FA:  e7
b07_a5fb:   .db $f7                     ; 1E5FB:  f7
b07_a5fc:   brk                         ; 1E5FC:  00
b07_a5fd:   brk                         ; 1E5FD:  00
b07_a5fe:   brk                         ; 1E5FE:  00
b07_a5ff:   brk                         ; 1E5FF:  00
b07_a600:   brk                         ; 1E600:  00
b07_a601:   jsr $0818                   ; 1E601:  20 18 08
b07_a604:   .db $44                     ; 1E604:  44
b07_a605:   ora ($44),y                 ; 1E605:  11 44
b07_a607:   ora ($04),y                 ; 1E607:  11 04
b07_a609:   ora ($04),y                 ; 1E609:  11 04
b07_a60b:   sta ($77,x)                 ; 1E60B:  81 77
b07_a60d:   cmp $5d77,x                 ; 1E60D:  dd 77 5d
b07_a610:   .db $b7                     ; 1E610:  b7
b07_a611:   cmp $75e7,x                 ; 1E611:  dd e7 75
b07_a614:   sty $c1                     ; 1E614:  84 c1
b07_a616:   cpy #$c1                    ; 1E616:  c0 c1
b07_a618:   cpy #$c1                    ; 1E618:  c0 c1
b07_a61a:   cpx #$f1                    ; 1E61A:  e0 f1
b07_a61c:   .db $77                     ; 1E61C:  77
b07_a61d:   and $393b,y                 ; 1E61D:  39 3b 39
b07_a620:   .db $3b                     ; 1E620:  3b
b07_a621:   and $0d1b,y                 ; 1E621:  39 1b 0d
b07_a624:   .db $44                     ; 1E624:  44
b07_a625:   ora ($45),y                 ; 1E625:  11 45
b07_a627:   ora ($45),y                 ; 1E627:  11 45
b07_a629:   ora ($45),y                 ; 1E629:  11 45
b07_a62b:   ora ($76),y                 ; 1E62B:  11 76
b07_a62d:   .db $dc                     ; 1E62D:  dc
b07_a62e:   .db $74                     ; 1E62E:  74
b07_a62f:   .db $dc                     ; 1E62F:  dc
b07_a630:   .db $74                     ; 1E630:  74
b07_a631:   .db $dc                     ; 1E631:  dc
b07_a632:   .db $74                     ; 1E632:  74
b07_a633:   .db $dc                     ; 1E633:  dc
b07_a634:   ora ($c3,x)                 ; 1E634:  01 c3
b07_a636:   .db $23                     ; 1E636:  23
b07_a637:   .db $13                     ; 1E637:  13
b07_a638:   .db $0b                     ; 1E638:  0b
b07_a639:   .db $0b                     ; 1E639:  0b
b07_a63a:   .db $0f                     ; 1E63A:  0f
b07_a63b:   .db $8f                     ; 1E63B:  8f
b07_a63c:   brk                         ; 1E63C:  00
b07_a63d:   brk                         ; 1E63D:  00
b07_a63e:   brk                         ; 1E63E:  00
b07_a63f:   brk                         ; 1E63F:  00
b07_a640:   rti                         ; 1E640:  40
b07_a641:   .db $80                     ; 1E641:  80
b07_a642:   ldy #$60                    ; 1E642:  a0 60
b07_a644:   .db $44                     ; 1E644:  44
b07_a645:   bpl $a68b                   ; 1E645:  10 44
b07_a647:   ora ($44),y                 ; 1E647:  11 44
b07_a649:   ora ($c4),y                 ; 1E649:  11 c4
b07_a64b:   sbc ($76),y                 ; 1E64B:  f1 76
b07_a64d:   .db $dc                     ; 1E64D:  dc
b07_a64e:   ror $dd,x                   ; 1E64E:  76 dd
b07_a650:   .db $77                     ; 1E650:  77
b07_a651:   ora $f1c7,x                 ; 1E651:  1d c7 f1
b07_a654:   .db $c7                     ; 1E654:  c7
b07_a655:   .db $67                     ; 1E655:  67
b07_a656:   .db $27                     ; 1E656:  27
b07_a657:   asl $06                     ; 1E657:  06 06
b07_a659:   .db $07                     ; 1E659:  07
b07_a65a:   .db $07                     ; 1E65A:  07
b07_a65b:   .db $0b                     ; 1E65B:  0b
b07_a65c:   brk                         ; 1E65C:  00
b07_a65d:   clc                         ; 1E65D:  18
b07_a65e:   clc                         ; 1E65E:  18
b07_a65f:   ora ($01,x)                 ; 1E65F:  01 01
b07_a661:   .db $80                     ; 1E661:  80
b07_a662:   brk                         ; 1E662:  00
b07_a663:   cpy #$e0                    ; 1E663:  c0 e0
b07_a665:   .db $fc                     ; 1E665:  fc
b07_a666:   inc $e0fe,x                 ; 1E666:  fe fe e0
b07_a669:   .db $d2                     ; 1E669:  d2
b07_a66a:   dec $00ec,x                 ; 1E66A:  de ec 00
b07_a66d:   .db $02                     ; 1E66D:  02
b07_a66e:   ora ($01,x)                 ; 1E66E:  01 01
b07_a670:   ora ($22,x)                 ; 1E670:  01 22
b07_a672:   ora ($12,x)                 ; 1E672:  01 12
b07_a674:   .db $ff                     ; 1E674:  ff
b07_a675:   .db $3f                     ; 1E675:  3f
b07_a676:   .db $1f                     ; 1E676:  1f
b07_a677:   .db $0f                     ; 1E677:  0f
b07_a678:   asl $3c1c,x                 ; 1E678:  1e 1c 3c
b07_a67b:   .db $fc                     ; 1E67B:  fc
b07_a67c:   brk                         ; 1E67C:  00
b07_a67d:   brk                         ; 1E67D:  00
b07_a67e:   cpy #$70                    ; 1E67E:  c0 70
b07_a680:   ldy #$20                    ; 1E680:  a0 20
b07_a682:   rti                         ; 1E682:  40
b07_a683:   .db $02                     ; 1E683:  02
b07_a684:   .db $fb                     ; 1E684:  fb
b07_a685:   .db $ff                     ; 1E685:  ff
b07_a686:   .db $ff                     ; 1E686:  ff
b07_a687:   .db $ff                     ; 1E687:  ff
b07_a688:   .db $ff                     ; 1E688:  ff
b07_a689:   ror $b93c,x                 ; 1E689:  7e 3c b9
b07_a68c:   .db $04                     ; 1E68C:  04
b07_a68d:   brk                         ; 1E68D:  00
b07_a68e:   brk                         ; 1E68E:  00
b07_a68f:   brk                         ; 1E68F:  00
b07_a690:   brk                         ; 1E690:  00
b07_a691:   .db $80                     ; 1E691:  80
b07_a692:   cmp ($42,x)                 ; 1E692:  c1 42
b07_a694:   .db $fc                     ; 1E694:  fc
b07_a695:   dec $9ece,x                 ; 1E695:  de ce 9e
b07_a698:   .db $1f                     ; 1E698:  1f
b07_a699:   .db $1f                     ; 1E699:  1f
b07_a69a:   dec $e0                     ; 1E69A:  c6 e0
b07_a69c:   ora ($21,x)                 ; 1E69C:  01 21
b07_a69e:   bmi $a6e0                   ; 1E69E:  30 40
b07_a6a0:   .db $80                     ; 1E6A0:  80
b07_a6a1:   cpy #$20                    ; 1E6A1:  c0 20
b07_a6a3:   ora $e1f0,y                 ; 1E6A3:  19 f0 e1
b07_a6a6:   cpy #$01                    ; 1E6A6:  c0 01
b07_a6a8:   rti                         ; 1E6A8:  40
b07_a6a9:   cmp ($04,x)                 ; 1E6A9:  c1 04
b07_a6ab:   eor ($0d,x)                 ; 1E6AB:  41 0d
b07_a6ad:   ora $01                     ; 1E6AD:  05 01
b07_a6af:   and $39bb,x                 ; 1E6AF:  3d bb 39
b07_a6b2:   .db $17                     ; 1E6B2:  17
b07_a6b3:   eor $e4,x                   ; 1E6B3:  55 e4
b07_a6b5:   eor ($64,x)                 ; 1E6B5:  41 64
b07_a6b7:   adc ($64,x)                 ; 1E6B7:  61 64
b07_a6b9:   eor ($44,x)                 ; 1E6B9:  41 44
b07_a6bb:   ora ($17,x)                 ; 1E6BB:  01 17
b07_a6bd:   lda $97,x                   ; 1E6BD:  b5 97
b07_a6bf:   sta $17,x                   ; 1E6BF:  95 17
b07_a6c1:   and $eda7                   ; 1E6C1:  2d a7 ed
b07_a6c4:   .db $dc                     ; 1E6C4:  dc
b07_a6c5:   .db $df                     ; 1E6C5:  df
b07_a6c6:   .db $1b                     ; 1E6C6:  1b
b07_a6c7:   .db $0b                     ; 1E6C7:  0b
b07_a6c8:   .db $82                     ; 1E6C8:  82
b07_a6c9:   bcc $a65b                   ; 1E6C9:  90 90
b07_a6cb:   .db $62                     ; 1E6CB:  62
b07_a6cc:   .db $dc                     ; 1E6CC:  dc
b07_a6cd:   .db $df                     ; 1E6CD:  df
b07_a6ce:   .db $1b                     ; 1E6CE:  1b
b07_a6cf:   .db $0b                     ; 1E6CF:  0b
b07_a6d0:   .db $82                     ; 1E6D0:  82
b07_a6d1:   bcc $a663                   ; 1E6D1:  90 90
b07_a6d3:   .db $62                     ; 1E6D3:  62
b07_a6d4:   .db $4b                     ; 1E6D4:  4b
b07_a6d5:   ora $1edd                   ; 1E6D5:  0d dd 1e
b07_a6d8:   rol $a70f                   ; 1E6D8:  2e 0f a7
b07_a6db:   .db $47                     ; 1E6DB:  47
b07_a6dc:   rts                         ; 1E6DC:  60
b07_a6dd:   brk                         ; 1E6DD:  00
b07_a6de:   .db $c2                     ; 1E6DE:  c2
b07_a6df:   ora ($01,x)                 ; 1E6DF:  01 01
b07_a6e1:   brk                         ; 1E6E1:  00
b07_a6e2:   .db $80                     ; 1E6E2:  80
b07_a6e3:   rti                         ; 1E6E3:  40
b07_a6e4:   ora ($0a),y                 ; 1E6E4:  11 0a
b07_a6e6:   ora ($08,x)                 ; 1E6E6:  01 08
b07_a6e8:   .db $03                     ; 1E6E8:  03
b07_a6e9:   .db $8b                     ; 1E6E9:  8b
b07_a6ea:   .db $22                     ; 1E6EA:  22
b07_a6eb:   .db $82                     ; 1E6EB:  82
b07_a6ec:   .db $13                     ; 1E6EC:  13
b07_a6ed:   .db $03                     ; 1E6ED:  03
b07_a6ee:   .db $03                     ; 1E6EE:  03
b07_a6ef:   brk                         ; 1E6EF:  00
b07_a6f0:   ora ($02,x)                 ; 1E6F0:  01 02
b07_a6f2:   brk                         ; 1E6F2:  00
b07_a6f3:   brk                         ; 1E6F3:  00
b07_a6f4:   .db $23                     ; 1E6F4:  23
b07_a6f5:   ora ($00),y                 ; 1E6F5:  11 00
b07_a6f7:   .db $3c                     ; 1E6F7:  3c
b07_a6f8:   cpx $2252                   ; 1E6F8:  ec 52 22
b07_a6fb:   .db $32                     ; 1E6FB:  32
b07_a6fc:   rts                         ; 1E6FC:  60
b07_a6fd:   bmi $a67f                   ; 1E6FD:  30 80
b07_a6ff:   plp                         ; 1E6FF:  28
b07_a700:   bvc $a682                   ; 1E700:  50 80
b07_a702:   dey                         ; 1E702:  88
b07_a703:   dey                         ; 1E703:  88
b07_a704:   sbc ($f8),y                 ; 1E704:  f1 f8
b07_a706:   sbc $7ffb,y                 ; 1E706:  f9 fb 7f
b07_a709:   .db $3f                     ; 1E709:  3f
b07_a70a:   .db $9f                     ; 1E70A:  9f
b07_a70b:   .db $87                     ; 1E70B:  87
b07_a70c:   asl a                       ; 1E70C:  0a
b07_a70d:   .db $04                     ; 1E70D:  04
b07_a70e:   .db $04                     ; 1E70E:  04
b07_a70f:   .db $04                     ; 1E70F:  04
b07_a710:   brk                         ; 1E710:  00
b07_a711:   .db $80                     ; 1E711:  80
b07_a712:   rti                         ; 1E712:  40
b07_a713:   rts                         ; 1E713:  60
b07_a714:   beq $a72e                   ; 1E714:  f0 18
b07_a716:   cpx #$fc                    ; 1E716:  e0 fc
b07_a718:   .db $80                     ; 1E718:  80
b07_a719:   cpy #$f0                    ; 1E719:  c0 f0
b07_a71b:   sbc ($0f),y                 ; 1E71B:  f1 0f
b07_a71d:   .db $03                     ; 1E71D:  03
b07_a71e:   ora ($03,x)                 ; 1E71E:  01 03
b07_a720:   asl $3e                     ; 1E720:  06 3e
b07_a722:   ora $c10d                   ; 1E722:  0d 0d c1
b07_a725:   cpx #$f0                    ; 1E725:  e0 f0
b07_a727:   .db $7c                     ; 1E727:  7c
b07_a728:   .db $3f                     ; 1E728:  3f
b07_a729:   .db $0f                     ; 1E729:  0f
b07_a72a:   brk                         ; 1E72A:  00
b07_a72b:   eor $30,x                   ; 1E72B:  55 30
b07_a72d:   .db $1c                     ; 1E72D:  1c
b07_a72e:   .db $0f                     ; 1E72E:  0f
b07_a72f:   .db $03                     ; 1E72F:  03
b07_a730:   brk                         ; 1E730:  00
b07_a731:   brk                         ; 1E731:  00
b07_a732:   bvs $a75e                   ; 1E732:  70 2a
b07_a734:   cpx #$00                    ; 1E734:  e0 00
b07_a736:   .db $02                     ; 1E736:  02
b07_a737:   brk                         ; 1E737:  00
b07_a738:   brk                         ; 1E738:  00
b07_a739:   .db $04                     ; 1E739:  04
b07_a73a:   asl a                       ; 1E73A:  0a
b07_a73b:   eor $19,x                   ; 1E73B:  55 19
b07_a73d:   .db $02                     ; 1E73D:  02
b07_a73e:   .db $c2                     ; 1E73E:  c2
b07_a73f:   bne $a6f3                   ; 1E73F:  d0 b2
b07_a741:   cpx #$15                    ; 1E741:  e0 15
b07_a743:   tay                         ; 1E743:  a8
b07_a744:   brk                         ; 1E744:  00
b07_a745:   .db $1f                     ; 1E745:  1f
b07_a746:   ora $01,x                   ; 1E746:  15 01
b07_a748:   rti                         ; 1E748:  40
b07_a749:   brk                         ; 1E749:  00
b07_a74a:   brk                         ; 1E74A:  00
b07_a74b:   php                         ; 1E74B:  08
b07_a74c:   cpy #$df                    ; 1E74C:  c0 df
b07_a74e:   sta $41,x                   ; 1E74E:  95 41
b07_a750:   rti                         ; 1E750:  40
b07_a751:   rti                         ; 1E751:  40
b07_a752:   brk                         ; 1E752:  00
b07_a753:   jsr $0144                   ; 1E753:  20 44 01
b07_a756:   inc $0555,x                 ; 1E756:  fe 55 05
b07_a759:   brk                         ; 1E759:  00
b07_a75a:   .db $80                     ; 1E75A:  80
b07_a75b:   plp                         ; 1E75B:  28
b07_a75c:   .db $77                     ; 1E75C:  77
b07_a75d:   ora ($fe,x)                 ; 1E75D:  01 fe
b07_a75f:   eor $05,x                   ; 1E75F:  55 05
b07_a761:   brk                         ; 1E761:  00
b07_a762:   .db $80                     ; 1E762:  80
b07_a763:   plp                         ; 1E763:  28
b07_a764:   ldx #$00                    ; 1E764:  a2 00
b07_a766:   .db $fc                     ; 1E766:  fc
b07_a767:   .db $f4                     ; 1E767:  f4
b07_a768:   stx $62,y                   ; 1E768:  96 62
b07_a76a:   .db $4f                     ; 1E76A:  4f
b07_a76b:   adc ($a0),y                 ; 1E76B:  71 a0
b07_a76d:   brk                         ; 1E76D:  00
b07_a76e:   .db $54                     ; 1E76E:  54
b07_a76f:   .db $80                     ; 1E76F:  80
b07_a770:   plp                         ; 1E770:  28
b07_a771:   .db $0c                     ; 1E771:  0c
b07_a772:   bvc $a77e                   ; 1E772:  50 0a
b07_a774:   and $88                     ; 1E774:  25 88
b07_a776:   jsr $2288                   ; 1E776:  20 88 22
b07_a779:   dey                         ; 1E779:  88
b07_a77a:   .db $22                     ; 1E77A:  22
b07_a77b:   php                         ; 1E77B:  08
b07_a77c:   ora $00                     ; 1E77C:  05 00
b07_a77e:   brk                         ; 1E77E:  00
b07_a77f:   brk                         ; 1E77F:  00
b07_a780:   brk                         ; 1E780:  00
b07_a781:   brk                         ; 1E781:  00
b07_a782:   brk                         ; 1E782:  00
b07_a783:   brk                         ; 1E783:  00
b07_a784:   eor $00,x                   ; 1E784:  55 00
b07_a786:   eor $00,x                   ; 1E786:  55 00
b07_a788:   eor $00,x                   ; 1E788:  55 00
b07_a78a:   eor $00,x                   ; 1E78A:  55 00
b07_a78c:   tax                         ; 1E78C:  aa
b07_a78d:   brk                         ; 1E78D:  00
b07_a78e:   tax                         ; 1E78E:  aa
b07_a78f:   brk                         ; 1E78F:  00
b07_a790:   tax                         ; 1E790:  aa
b07_a791:   brk                         ; 1E791:  00
b07_a792:   tax                         ; 1E792:  aa
b07_a793:   brk                         ; 1E793:  00
b07_a794:   eor $00,x                   ; 1E794:  55 00
b07_a796:   eor $01,x                   ; 1E796:  55 01
b07_a798:   .db $53                     ; 1E798:  53
b07_a799:   .db $07                     ; 1E799:  07
b07_a79a:   .db $4f                     ; 1E79A:  4f
b07_a79b:   .db $0f                     ; 1E79B:  0f
b07_a79c:   tax                         ; 1E79C:  aa
b07_a79d:   brk                         ; 1E79D:  00
b07_a79e:   tax                         ; 1E79E:  aa
b07_a79f:   brk                         ; 1E79F:  00
b07_a7a0:   tay                         ; 1E7A0:  a8
b07_a7a1:   brk                         ; 1E7A1:  00
b07_a7a2:   ldy #$00                    ; 1E7A2:  a0 00
b07_a7a4:   .db $5f                     ; 1E7A4:  5f
b07_a7a5:   .db $1f                     ; 1E7A5:  1f
b07_a7a6:   .db $5f                     ; 1E7A6:  5f
b07_a7a7:   .db $3f                     ; 1E7A7:  3f
b07_a7a8:   .db $3f                     ; 1E7A8:  3f
b07_a7a9:   .db $3f                     ; 1E7A9:  3f
b07_a7aa:   .db $3f                     ; 1E7AA:  3f
b07_a7ab:   .db $17                     ; 1E7AB:  17
b07_a7ac:   .db $80                     ; 1E7AC:  80
b07_a7ad:   brk                         ; 1E7AD:  00
b07_a7ae:   .db $80                     ; 1E7AE:  80
b07_a7af:   brk                         ; 1E7AF:  00
b07_a7b0:   .db $80                     ; 1E7B0:  80
b07_a7b1:   brk                         ; 1E7B1:  00
b07_a7b2:   .db $80                     ; 1E7B2:  80
b07_a7b3:   brk                         ; 1E7B3:  00
b07_a7b4:   eor $00,x                   ; 1E7B4:  55 00
b07_a7b6:   .db $7f                     ; 1E7B6:  7f
b07_a7b7:   .db $ff                     ; 1E7B7:  ff
b07_a7b8:   .db $ff                     ; 1E7B8:  ff
b07_a7b9:   .db $ff                     ; 1E7B9:  ff
b07_a7ba:   .db $ff                     ; 1E7BA:  ff
b07_a7bb:   .db $ff                     ; 1E7BB:  ff
b07_a7bc:   tax                         ; 1E7BC:  aa
b07_a7bd:   brk                         ; 1E7BD:  00
b07_a7be:   .db $80                     ; 1E7BE:  80
b07_a7bf:   brk                         ; 1E7BF:  00
b07_a7c0:   brk                         ; 1E7C0:  00
b07_a7c1:   brk                         ; 1E7C1:  00
b07_a7c2:   brk                         ; 1E7C2:  00
b07_a7c3:   brk                         ; 1E7C3:  00
b07_a7c4:   eor $00,x                   ; 1E7C4:  55 00
b07_a7c6:   .db $fc                     ; 1E7C6:  fc
b07_a7c7:   inc $fffe,x                 ; 1E7C7:  fe fe ff
b07_a7ca:   .db $ff                     ; 1E7CA:  ff
b07_a7cb:   .db $ff                     ; 1E7CB:  ff
b07_a7cc:   tax                         ; 1E7CC:  aa
b07_a7cd:   brk                         ; 1E7CD:  00
b07_a7ce:   brk                         ; 1E7CE:  00
b07_a7cf:   ora ($01,x)                 ; 1E7CF:  01 01
b07_a7d1:   brk                         ; 1E7D1:  00
b07_a7d2:   brk                         ; 1E7D2:  00
b07_a7d3:   brk                         ; 1E7D3:  00
b07_a7d4:   .db $ff                     ; 1E7D4:  ff
b07_a7d5:   .db $ff                     ; 1E7D5:  ff
b07_a7d6:   .db $ff                     ; 1E7D6:  ff
b07_a7d7:   .db $ff                     ; 1E7D7:  ff
b07_a7d8:   .db $ff                     ; 1E7D8:  ff
b07_a7d9:   .db $ff                     ; 1E7D9:  ff
b07_a7da:   .db $ff                     ; 1E7DA:  ff
b07_a7db:   .db $ff                     ; 1E7DB:  ff
b07_a7dc:   brk                         ; 1E7DC:  00
b07_a7dd:   brk                         ; 1E7DD:  00
b07_a7de:   brk                         ; 1E7DE:  00
b07_a7df:   brk                         ; 1E7DF:  00
b07_a7e0:   brk                         ; 1E7E0:  00
b07_a7e1:   brk                         ; 1E7E1:  00
b07_a7e2:   brk                         ; 1E7E2:  00
b07_a7e3:   brk                         ; 1E7E3:  00
b07_a7e4:   .db $ff                     ; 1E7E4:  ff
b07_a7e5:   inc $fcfe,x                 ; 1E7E5:  fe fe fc
b07_a7e8:   sed                         ; 1E7E8:  f8
b07_a7e9:   beq $a7e3                   ; 1E7E9:  f0 f8
b07_a7eb:   bne $a7ed                   ; 1E7EB:  d0 00
b07_a7ed:   ora ($01,x)                 ; 1E7ED:  01 01
b07_a7ef:   .db $03                     ; 1E7EF:  03
b07_a7f0:   .db $07                     ; 1E7F0:  07
b07_a7f1:   .db $0f                     ; 1E7F1:  0f
b07_a7f2:   asl $07                     ; 1E7F2:  06 07
b07_a7f4:   eor $00,x                   ; 1E7F4:  55 00
b07_a7f6:   ora $00                     ; 1E7F6:  05 00
b07_a7f8:   ora $00                     ; 1E7F8:  05 00
b07_a7fa:   ora $00                     ; 1E7FA:  05 00
b07_a7fc:   tax                         ; 1E7FC:  aa
b07_a7fd:   brk                         ; 1E7FD:  00
b07_a7fe:   asl a                       ; 1E7FE:  0a
b07_a7ff:   .db $80                     ; 1E7FF:  80
b07_a800:   .db $c2                     ; 1E800:  c2
b07_a801:   cpx #$f2                    ; 1E801:  e0 f2
b07_a803:   beq $a806                   ; 1E803:  f0 01
b07_a805:   brk                         ; 1E805:  00
b07_a806:   ora ($00,x)                 ; 1E806:  01 00
b07_a808:   ora ($00,x)                 ; 1E808:  01 00
b07_a80a:   ora ($00,x)                 ; 1E80A:  01 00
b07_a80c:   .db $f2                     ; 1E80C:  f2
b07_a80d:   cpx #$e0                    ; 1E80D:  e0 e0
b07_a80f:   cpy #$80                    ; 1E80F:  c0 80
b07_a811:   brk                         ; 1E811:  00
b07_a812:   brk                         ; 1E812:  00
b07_a813:   brk                         ; 1E813:  00
b07_a814:   ora ($30,x)                 ; 1E814:  01 30
b07_a816:   sec                         ; 1E816:  38
b07_a817:   brk                         ; 1E817:  00
b07_a818:   .db $52                     ; 1E818:  52
b07_a819:   .db $1c                     ; 1E819:  1c
b07_a81a:   .db $7c                     ; 1E81A:  7c
b07_a81b:   and $0080,x                 ; 1E81B:  3d 80 00
b07_a81e:   stx $20                     ; 1E81E:  86 20
b07_a820:   .db $b2                     ; 1E820:  b2
b07_a821:   .db $03                     ; 1E821:  03
b07_a822:   .db $83                     ; 1E822:  83
b07_a823:   .db $02                     ; 1E823:  02
b07_a824:   adc $7d3d,x                 ; 1E824:  7d 3d 7d
b07_a827:   and $3e7d,x                 ; 1E827:  3d 7d 3e
b07_a82a:   .db $5c                     ; 1E82A:  5c
b07_a82b:   .db $1c                     ; 1E82B:  1c
b07_a82c:   .db $82                     ; 1E82C:  82
b07_a82d:   brk                         ; 1E82D:  00
b07_a82e:   .db $80                     ; 1E82E:  80
b07_a82f:   brk                         ; 1E82F:  00
b07_a830:   .db $80                     ; 1E830:  80
b07_a831:   brk                         ; 1E831:  00
b07_a832:   .db $a3                     ; 1E832:  a3
b07_a833:   brk                         ; 1E833:  00
b07_a834:   sed                         ; 1E834:  f8
b07_a835:   cpx #$f0                    ; 1E835:  e0 f0
b07_a837:   beq $a82a                   ; 1E837:  f0 f1
b07_a839:   .db $fb                     ; 1E839:  fb
b07_a83a:   sbc $00fe,x                 ; 1E83A:  fd fe 00
b07_a83d:   brk                         ; 1E83D:  00
b07_a83e:   .db $03                     ; 1E83E:  03
b07_a83f:   .db $0c                     ; 1E83F:  0c
b07_a840:   ora $0204                   ; 1E840:  0d 04 02
b07_a843:   ora ($00,x)                 ; 1E843:  01 00
b07_a845:   bvs $a837                   ; 1E845:  70 f0
b07_a847:   php                         ; 1E847:  08
b07_a848:   bmi $a842                   ; 1E848:  30 f8
b07_a84a:   beq $a844                   ; 1E84A:  f0 f8
b07_a84c:   .db $07                     ; 1E84C:  07
b07_a84d:   .db $8f                     ; 1E84D:  8f
b07_a84e:   .db $0f                     ; 1E84E:  0f
b07_a84f:   .db $07                     ; 1E84F:  07
b07_a850:   .db $37                     ; 1E850:  37
b07_a851:   .db $07                     ; 1E851:  07
b07_a852:   .db $0f                     ; 1E852:  0f
b07_a853:   .db $07                     ; 1E853:  07
b07_a854:   .db $ff                     ; 1E854:  ff
b07_a855:   .db $ff                     ; 1E855:  ff
b07_a856:   .db $ef                     ; 1E856:  ef
b07_a857:   .db $e7                     ; 1E857:  e7
b07_a858:   .db $83                     ; 1E858:  83
b07_a859:   ora ($44,x)                 ; 1E859:  01 44
b07_a85b:   brk                         ; 1E85B:  00
b07_a85c:   brk                         ; 1E85C:  00
b07_a85d:   brk                         ; 1E85D:  00
b07_a85e:   bpl $a868                   ; 1E85E:  10 08
b07_a860:   .db $1c                     ; 1E860:  1c
b07_a861:   lsr $03,x                   ; 1E861:  56 03
b07_a863:   ora ($fc,x)                 ; 1E863:  01 fc
b07_a865:   .db $fc                     ; 1E865:  fc
b07_a866:   .db $fc                     ; 1E866:  fc
b07_a867:   .db $fc                     ; 1E867:  fc
b07_a868:   sed                         ; 1E868:  f8
b07_a869:   sed                         ; 1E869:  f8
b07_a86a:   sed                         ; 1E86A:  f8
b07_a86b:   sed                         ; 1E86B:  f8
b07_a86c:   .db $03                     ; 1E86C:  03
b07_a86d:   .db $03                     ; 1E86D:  03
b07_a86e:   .db $03                     ; 1E86E:  03
b07_a86f:   .db $03                     ; 1E86F:  03
b07_a870:   .db $07                     ; 1E870:  07
b07_a871:   .db $07                     ; 1E871:  07
b07_a872:   .db $07                     ; 1E872:  07
b07_a873:   .db $07                     ; 1E873:  07
b07_a874:   ora ($00,x)                 ; 1E874:  01 00
b07_a876:   ora ($00,x)                 ; 1E876:  01 00
b07_a878:   ora $0212                   ; 1E878:  0d 12 02
b07_a87b:   .db $04                     ; 1E87B:  04
b07_a87c:   brk                         ; 1E87C:  00
b07_a87d:   .db $80                     ; 1E87D:  80
b07_a87e:   .db $80                     ; 1E87E:  80
b07_a87f:   .db $80                     ; 1E87F:  80
b07_a880:   .db $80                     ; 1E880:  80
b07_a881:   .db $80                     ; 1E881:  80
b07_a882:   tay                         ; 1E882:  a8
b07_a883:   .db $80                     ; 1E883:  80
b07_a884:   ora $0908                   ; 1E884:  0d 08 09
b07_a887:   bpl $a88e                   ; 1E887:  10 05
b07_a889:   brk                         ; 1E889:  00
b07_a88a:   ora $00,x                   ; 1E88A:  15 00
b07_a88c:   cpy #$a0                    ; 1E88C:  c0 a0
b07_a88e:   .db $d2                     ; 1E88E:  d2
b07_a88f:   cpx #$ea                    ; 1E88F:  e0 ea
b07_a891:   .db $80                     ; 1E891:  80
b07_a892:   tax                         ; 1E892:  aa
b07_a893:   ldy #$5c                    ; 1E893:  a0 5c
b07_a895:   .db $1a                     ; 1E895:  1a
b07_a896:   .db $5f                     ; 1E896:  5f
b07_a897:   .db $0f                     ; 1E897:  0f
b07_a898:   .db $57                     ; 1E898:  57
b07_a899:   .db $07                     ; 1E899:  07
b07_a89a:   .db $53                     ; 1E89A:  53
b07_a89b:   .db $03                     ; 1E89B:  03
b07_a89c:   ldy #$00                    ; 1E89C:  a0 00
b07_a89e:   ldy #$00                    ; 1E89E:  a0 00
b07_a8a0:   tay                         ; 1E8A0:  a8
b07_a8a1:   brk                         ; 1E8A1:  00
b07_a8a2:   tay                         ; 1E8A2:  a8
b07_a8a3:   brk                         ; 1E8A3:  00
b07_a8a4:   eor $00,x                   ; 1E8A4:  55 00
b07_a8a6:   .db $07                     ; 1E8A6:  07
b07_a8a7:   rol a                       ; 1E8A7:  2a
b07_a8a8:   .db $ff                     ; 1E8A8:  ff
b07_a8a9:   tax                         ; 1E8A9:  aa
b07_a8aa:   .db $ff                     ; 1E8AA:  ff
b07_a8ab:   tax                         ; 1E8AB:  aa
b07_a8ac:   tax                         ; 1E8AC:  aa
b07_a8ad:   brk                         ; 1E8AD:  00
b07_a8ae:   .db $87                     ; 1E8AE:  87
b07_a8af:   .db $7f                     ; 1E8AF:  7f
b07_a8b0:   .db $ff                     ; 1E8B0:  ff
b07_a8b1:   .db $ff                     ; 1E8B1:  ff
b07_a8b2:   .db $ff                     ; 1E8B2:  ff
b07_a8b3:   .db $ff                     ; 1E8B3:  ff
b07_a8b4:   ora $28                     ; 1E8B4:  05 28
b07_a8b6:   .db $fa                     ; 1E8B6:  fa
b07_a8b7:   tax                         ; 1E8B7:  aa
b07_a8b8:   inc $a1,x                   ; 1E8B8:  f6 a1
b07_a8ba:   cpx $84a9                   ; 1E8BA:  ec a9 84
b07_a8bd:   .db $7c                     ; 1E8BD:  7c
b07_a8be:   .db $fa                     ; 1E8BE:  fa
b07_a8bf:   .db $fa                     ; 1E8BF:  fa
b07_a8c0:   inc $f5,x                   ; 1E8C0:  f6 f5
b07_a8c2:   sbc $40ed                   ; 1E8C2:  ed ed 40
b07_a8c5:   sbc $ff,x                   ; 1E8C5:  f5 ff
b07_a8c7:   .db $07                     ; 1E8C7:  07
b07_a8c8:   .db $03                     ; 1E8C8:  03
b07_a8c9:   .db $fb                     ; 1E8C9:  fb
b07_a8ca:   .db $ff                     ; 1E8CA:  ff
b07_a8cb:   .db $ff                     ; 1E8CB:  ff
b07_a8cc:   brk                         ; 1E8CC:  00
b07_a8cd:   brk                         ; 1E8CD:  00
b07_a8ce:   brk                         ; 1E8CE:  00
b07_a8cf:   dey                         ; 1E8CF:  88
b07_a8d0:   .db $74                     ; 1E8D0:  74
b07_a8d1:   .db $04                     ; 1E8D1:  04
b07_a8d2:   brk                         ; 1E8D2:  00
b07_a8d3:   brk                         ; 1E8D3:  00
b07_a8d4:   sei                         ; 1E8D4:  78
b07_a8d5:   bvs $a947                   ; 1E8D5:  70 70
b07_a8d7:   beq $a8b9                   ; 1E8D7:  f0 e0
b07_a8d9:   cpx #$c0                    ; 1E8D9:  e0 c0
b07_a8db:   sta ($87,x)                 ; 1E8DB:  81 87
b07_a8dd:   .db $0f                     ; 1E8DD:  0f
b07_a8de:   .db $8f                     ; 1E8DE:  8f
b07_a8df:   .db $0f                     ; 1E8DF:  0f
b07_a8e0:   .db $1f                     ; 1E8E0:  1f
b07_a8e1:   ora $773b,x                 ; 1E8E1:  1d 3b 77
b07_a8e4:   .db $ff                     ; 1E8E4:  ff
b07_a8e5:   .db $fc                     ; 1E8E5:  fc
b07_a8e6:   brk                         ; 1E8E6:  00
b07_a8e7:   .db $80                     ; 1E8E7:  80
b07_a8e8:   ldy #$b8                    ; 1E8E8:  a0 b8
b07_a8ea:   .db $df                     ; 1E8EA:  df
b07_a8eb:   .db $5f                     ; 1E8EB:  5f
b07_a8ec:   brk                         ; 1E8EC:  00
b07_a8ed:   .db $02                     ; 1E8ED:  02
b07_a8ee:   brk                         ; 1E8EE:  00
b07_a8ef:   sta ($9f,x)                 ; 1E8EF:  81 9f
b07_a8f1:   .db $87                     ; 1E8F1:  87
b07_a8f2:   cpy #$c1                    ; 1E8F2:  c0 c1
b07_a8f4:   .db $03                     ; 1E8F4:  03
b07_a8f5:   asl $0c                     ; 1E8F5:  06 0c
b07_a8f7:   clc                         ; 1E8F7:  18
b07_a8f8:   bvs $a8de                   ; 1E8F8:  70 e4
b07_a8fa:   dex                         ; 1E8FA:  ca
b07_a8fb:   sta $cf,x                   ; 1E8FB:  95 cf
b07_a8fd:   asl $fa7d,x                 ; 1E8FD:  1e 7d fa
b07_a900:   lda $6e,x                   ; 1E900:  b5 6e
b07_a902:   .db $df                     ; 1E902:  df
b07_a903:   .db $bf                     ; 1E903:  bf
b07_a904:   ora $00                     ; 1E904:  05 00
b07_a906:   and $28                     ; 1E906:  25 28
b07_a908:   adc ($48,x)                 ; 1E908:  61 48
b07_a90a:   bne $a894                   ; 1E90A:  d0 88
b07_a90c:   tax                         ; 1E90C:  aa
b07_a90d:   rts                         ; 1E90D:  60
b07_a90e:   .db $e2                     ; 1E90E:  e2
b07_a90f:   inx                         ; 1E90F:  e8
b07_a910:   .db $e2                     ; 1E910:  e2
b07_a911:   .db $dc                     ; 1E911:  dc
b07_a912:   bne $a8b1                   ; 1E912:  d0 9d
b07_a914:   eor $00,x                   ; 1E914:  55 00
b07_a916:   eor $00,x                   ; 1E916:  55 00
b07_a918:   eor $00,x                   ; 1E918:  55 00
b07_a91a:   eor $80,x                   ; 1E91A:  55 80
b07_a91c:   tax                         ; 1E91C:  aa
b07_a91d:   brk                         ; 1E91D:  00
b07_a91e:   tax                         ; 1E91E:  aa
b07_a91f:   brk                         ; 1E91F:  00
b07_a920:   tax                         ; 1E920:  aa
b07_a921:   brk                         ; 1E921:  00
b07_a922:   rol a                       ; 1E922:  2a
b07_a923:   .db $80                     ; 1E923:  80
b07_a924:   ora ($28),y                 ; 1E924:  11 28
b07_a926:   and ($28),y                 ; 1E926:  31 28
b07_a928:   and ($28),y                 ; 1E928:  31 28
b07_a92a:   adc $28,x                   ; 1E92A:  75 28
b07_a92c:   eor ($bd),y                 ; 1E92C:  51 bd
b07_a92e:   and ($bd),y                 ; 1E92E:  31 bd
b07_a930:   and ($7d),y                 ; 1E930:  31 7d
b07_a932:   adc $7d,x                   ; 1E932:  75 7d
b07_a934:   bvc $a8e0                   ; 1E934:  50 aa
b07_a936:   .db $5f                     ; 1E936:  5f
b07_a937:   tax                         ; 1E937:  aa
b07_a938:   .db $7f                     ; 1E938:  7f
b07_a939:   tax                         ; 1E939:  aa
b07_a93a:   .db $ff                     ; 1E93A:  ff
b07_a93b:   tax                         ; 1E93B:  aa
b07_a93c:   bvc $a93d                   ; 1E93C:  50 ff
b07_a93e:   .db $5f                     ; 1E93E:  5f
b07_a93f:   .db $ff                     ; 1E93F:  ff
b07_a940:   .db $7f                     ; 1E940:  7f
b07_a941:   .db $ff                     ; 1E941:  ff
b07_a942:   .db $ff                     ; 1E942:  ff
b07_a943:   .db $ff                     ; 1E943:  ff
b07_a944:   brk                         ; 1E944:  00
b07_a945:   brk                         ; 1E945:  00
b07_a946:   brk                         ; 1E946:  00
b07_a947:   brk                         ; 1E947:  00
b07_a948:   brk                         ; 1E948:  00
b07_a949:   brk                         ; 1E949:  00
b07_a94a:   brk                         ; 1E94A:  00
b07_a94b:   brk                         ; 1E94B:  00
b07_a94c:   .db $22                     ; 1E94C:  22
b07_a94d:   dey                         ; 1E94D:  88
b07_a94e:   .db $22                     ; 1E94E:  22
b07_a94f:   dey                         ; 1E94F:  88
b07_a950:   .db $22                     ; 1E950:  22
b07_a951:   dey                         ; 1E951:  88
b07_a952:   .db $22                     ; 1E952:  22
b07_a953:   dey                         ; 1E953:  88
b07_a954:   brk                         ; 1E954:  00
b07_a955:   brk                         ; 1E955:  00
b07_a956:   brk                         ; 1E956:  00
b07_a957:   brk                         ; 1E957:  00
b07_a958:   brk                         ; 1E958:  00
b07_a959:   brk                         ; 1E959:  00
b07_a95a:   brk                         ; 1E95A:  00
b07_a95b:   ora ($22,x)                 ; 1E95B:  01 22
b07_a95d:   dey                         ; 1E95D:  88
b07_a95e:   jsr $2288                   ; 1E95E:  20 88 22
b07_a961:   dey                         ; 1E961:  88
b07_a962:   jsr $0180                   ; 1E962:  20 80 01
b07_a965:   brk                         ; 1E965:  00
b07_a966:   ora ($00,x)                 ; 1E966:  01 00
b07_a968:   brk                         ; 1E968:  00
b07_a969:   brk                         ; 1E969:  00
b07_a96a:   brk                         ; 1E96A:  00
b07_a96b:   brk                         ; 1E96B:  00
b07_a96c:   jsr $0080                   ; 1E96C:  20 80 00
b07_a96f:   .db $80                     ; 1E96F:  80
b07_a970:   brk                         ; 1E970:  00
b07_a971:   .db $80                     ; 1E971:  80
b07_a972:   brk                         ; 1E972:  00
b07_a973:   .db $80                     ; 1E973:  80
b07_a974:   brk                         ; 1E974:  00
b07_a975:   brk                         ; 1E975:  00
b07_a976:   brk                         ; 1E976:  00
b07_a977:   .db $0f                     ; 1E977:  0f
b07_a978:   .db $3f                     ; 1E978:  3f
b07_a979:   .db $7f                     ; 1E979:  7f
b07_a97a:   .db $ff                     ; 1E97A:  ff
b07_a97b:   .db $ff                     ; 1E97B:  ff
b07_a97c:   ldx #$08                    ; 1E97C:  a2 08
b07_a97e:   .db $02                     ; 1E97E:  02
b07_a97f:   brk                         ; 1E97F:  00
b07_a980:   brk                         ; 1E980:  00
b07_a981:   brk                         ; 1E981:  00
b07_a982:   brk                         ; 1E982:  00
b07_a983:   brk                         ; 1E983:  00
b07_a984:   brk                         ; 1E984:  00
b07_a985:   brk                         ; 1E985:  00
b07_a986:   brk                         ; 1E986:  00
b07_a987:   sed                         ; 1E987:  f8
b07_a988:   inc $ffff,x                 ; 1E988:  fe ff ff
b07_a98b:   .db $ff                     ; 1E98B:  ff
b07_a98c:   .db $22                     ; 1E98C:  22
b07_a98d:   dey                         ; 1E98D:  88
b07_a98e:   .db $22                     ; 1E98E:  22
b07_a98f:   .db $04                     ; 1E98F:  04
b07_a990:   ora ($00,x)                 ; 1E990:  01 00
b07_a992:   brk                         ; 1E992:  00
b07_a993:   brk                         ; 1E993:  00
b07_a994:   .db $ff                     ; 1E994:  ff
b07_a995:   .db $ff                     ; 1E995:  ff
b07_a996:   .db $ff                     ; 1E996:  ff
b07_a997:   .db $ff                     ; 1E997:  ff
b07_a998:   .db $5f                     ; 1E998:  5f
b07_a999:   .db $af                     ; 1E999:  af
b07_a99a:   .db $17                     ; 1E99A:  17
b07_a99b:   .db $0b                     ; 1E99B:  0b
b07_a99c:   brk                         ; 1E99C:  00
b07_a99d:   brk                         ; 1E99D:  00
b07_a99e:   brk                         ; 1E99E:  00
b07_a99f:   brk                         ; 1E99F:  00
b07_a9a0:   brk                         ; 1E9A0:  00
b07_a9a1:   brk                         ; 1E9A1:  00
b07_a9a2:   brk                         ; 1E9A2:  00
b07_a9a3:   brk                         ; 1E9A3:  00
b07_a9a4:   .db $ff                     ; 1E9A4:  ff
b07_a9a5:   .db $ff                     ; 1E9A5:  ff
b07_a9a6:   .db $ff                     ; 1E9A6:  ff
b07_a9a7:   .db $ff                     ; 1E9A7:  ff
b07_a9a8:   .db $ff                     ; 1E9A8:  ff
b07_a9a9:   .db $ff                     ; 1E9A9:  ff
b07_a9aa:   .db $ff                     ; 1E9AA:  ff
b07_a9ab:   .db $ff                     ; 1E9AB:  ff
b07_a9ac:   brk                         ; 1E9AC:  00
b07_a9ad:   brk                         ; 1E9AD:  00
b07_a9ae:   brk                         ; 1E9AE:  00
b07_a9af:   brk                         ; 1E9AF:  00
b07_a9b0:   brk                         ; 1E9B0:  00
b07_a9b1:   brk                         ; 1E9B1:  00
b07_a9b2:   brk                         ; 1E9B2:  00
b07_a9b3:   brk                         ; 1E9B3:  00
b07_a9b4:   brk                         ; 1E9B4:  00
b07_a9b5:   brk                         ; 1E9B5:  00
b07_a9b6:   brk                         ; 1E9B6:  00
b07_a9b7:   brk                         ; 1E9B7:  00
b07_a9b8:   brk                         ; 1E9B8:  00
b07_a9b9:   brk                         ; 1E9B9:  00
b07_a9ba:   .db $80                     ; 1E9BA:  80
b07_a9bb:   cpy #$22                    ; 1E9BB:  c0 22
b07_a9bd:   dey                         ; 1E9BD:  88
b07_a9be:   .db $22                     ; 1E9BE:  22
b07_a9bf:   dey                         ; 1E9BF:  88
b07_a9c0:   .db $22                     ; 1E9C0:  22
b07_a9c1:   iny                         ; 1E9C1:  c8
b07_a9c2:   .db $62                     ; 1E9C2:  62
b07_a9c3:   bmi $a9a5                   ; 1E9C3:  30 e0
b07_a9c5:   beq $a9b7                   ; 1E9C5:  f0 f0
b07_a9c7:   beq $a9c1                   ; 1E9C7:  f0 f8
b07_a9c9:   sed                         ; 1E9C9:  f8
b07_a9ca:   clv                         ; 1E9CA:  b8
b07_a9cb:   ldy $081a,x                 ; 1E9CB:  bc 1a 08
b07_a9ce:   .db $0c                     ; 1E9CE:  0c
b07_a9cf:   .db $0c                     ; 1E9CF:  0c
b07_a9d0:   asl $06                     ; 1E9D0:  06 06
b07_a9d2:   .db $47                     ; 1E9D2:  47
b07_a9d3:   .db $43                     ; 1E9D3:  43
b07_a9d4:   brk                         ; 1E9D4:  00
b07_a9d5:   brk                         ; 1E9D5:  00
b07_a9d6:   brk                         ; 1E9D6:  00
b07_a9d7:   brk                         ; 1E9D7:  00
b07_a9d8:   brk                         ; 1E9D8:  00
b07_a9d9:   brk                         ; 1E9D9:  00
b07_a9da:   brk                         ; 1E9DA:  00
b07_a9db:   brk                         ; 1E9DB:  00
b07_a9dc:   .db $22                     ; 1E9DC:  22
b07_a9dd:   dey                         ; 1E9DD:  88
b07_a9de:   .db $22                     ; 1E9DE:  22
b07_a9df:   dey                         ; 1E9DF:  88
b07_a9e0:   .db $22                     ; 1E9E0:  22
b07_a9e1:   dey                         ; 1E9E1:  88
b07_a9e2:   .db $22                     ; 1E9E2:  22
b07_a9e3:   php                         ; 1E9E3:  08
b07_a9e4:   brk                         ; 1E9E4:  00
b07_a9e5:   brk                         ; 1E9E5:  00
b07_a9e6:   brk                         ; 1E9E6:  00
b07_a9e7:   brk                         ; 1E9E7:  00
b07_a9e8:   brk                         ; 1E9E8:  00
b07_a9e9:   .db $1c                     ; 1E9E9:  1c
b07_a9ea:   .db $12                     ; 1E9EA:  12
b07_a9eb:   ora ($00),y                 ; 1E9EB:  11 00
b07_a9ed:   .db $80                     ; 1E9ED:  80
b07_a9ee:   brk                         ; 1E9EE:  00
b07_a9ef:   .db $80                     ; 1E9EF:  80
b07_a9f0:   brk                         ; 1E9F0:  00
b07_a9f1:   .db $80                     ; 1E9F1:  80
b07_a9f2:   brk                         ; 1E9F2:  00
b07_a9f3:   sty $10                     ; 1E9F3:  84 10
b07_a9f5:   clc                         ; 1E9F5:  18
b07_a9f6:   php                         ; 1E9F6:  08
b07_a9f7:   .db $0c                     ; 1E9F7:  0c
b07_a9f8:   .db $07                     ; 1E9F8:  07
b07_a9f9:   .db $03                     ; 1E9F9:  03
b07_a9fa:   brk                         ; 1E9FA:  00
b07_a9fb:   brk                         ; 1E9FB:  00
b07_a9fc:   brk                         ; 1E9FC:  00
b07_a9fd:   sta ($22,x)                 ; 1E9FD:  81 22
b07_a9ff:   .db $80                     ; 1E9FF:  80
b07_aa00:   jsr $2088                   ; 1EA00:  20 88 20
b07_aa03:   .db $89                     ; 1EA03:  89
b07_aa04:   ora $0f,x                   ; 1EA04:  15 0f
b07_aa06:   .db $0f                     ; 1EA06:  0f
b07_aa07:   .db $1f                     ; 1EA07:  1f
b07_aa08:   .db $3f                     ; 1EA08:  3f
b07_aa09:   .db $3f                     ; 1EA09:  3f
b07_aa0a:   .db $3f                     ; 1EA0A:  3f
b07_aa0b:   .db $3f                     ; 1EA0B:  3f
b07_aa0c:   brk                         ; 1EA0C:  00
b07_aa0d:   brk                         ; 1EA0D:  00
b07_aa0e:   brk                         ; 1EA0E:  00
b07_aa0f:   brk                         ; 1EA0F:  00
b07_aa10:   brk                         ; 1EA10:  00
b07_aa11:   brk                         ; 1EA11:  00
b07_aa12:   brk                         ; 1EA12:  00
b07_aa13:   brk                         ; 1EA13:  00
b07_aa14:   .db $ff                     ; 1EA14:  ff
b07_aa15:   .db $df                     ; 1EA15:  df
b07_aa16:   .db $a7                     ; 1EA16:  a7
b07_aa17:   bne $aa11                   ; 1EA17:  d0 f8
b07_aa19:   cpy #$e6                    ; 1EA19:  c0 e6
b07_aa1b:   .db $fc                     ; 1EA1B:  fc
b07_aa1c:   brk                         ; 1EA1C:  00
b07_aa1d:   brk                         ; 1EA1D:  00
b07_aa1e:   brk                         ; 1EA1E:  00
b07_aa1f:   ora ($00,x)                 ; 1EA1F:  01 00
b07_aa21:   brk                         ; 1EA21:  00
b07_aa22:   asl $01                     ; 1EA22:  06 01
b07_aa24:   .db $3f                     ; 1EA24:  3f
b07_aa25:   .db $7f                     ; 1EA25:  7f
b07_aa26:   .db $77                     ; 1EA26:  77
b07_aa27:   .db $77                     ; 1EA27:  77
b07_aa28:   .db $fb                     ; 1EA28:  fb
b07_aa29:   sbc $7d7c,y                 ; 1EA29:  f9 7c 7d
b07_aa2c:   .db $80                     ; 1EA2C:  80
b07_aa2d:   .db $80                     ; 1EA2D:  80
b07_aa2e:   dey                         ; 1EA2E:  88
b07_aa2f:   dey                         ; 1EA2F:  88
b07_aa30:   .db $04                     ; 1EA30:  04
b07_aa31:   asl $03                     ; 1EA31:  06 03
b07_aa33:   .db $02                     ; 1EA33:  02
b07_aa34:   sbc #$ff                    ; 1EA34:  e9 ff
b07_aa36:   .db $ff                     ; 1EA36:  ff
b07_aa37:   .db $ff                     ; 1EA37:  ff
b07_aa38:   inc $fdfc,x                 ; 1EA38:  fe fc fd
b07_aa3b:   .db $fb                     ; 1EA3B:  fb
b07_aa3c:   .db $02                     ; 1EA3C:  02
b07_aa3d:   brk                         ; 1EA3D:  00
b07_aa3e:   brk                         ; 1EA3E:  00
b07_aa3f:   brk                         ; 1EA3F:  00
b07_aa40:   brk                         ; 1EA40:  00
b07_aa41:   ora ($02,x)                 ; 1EA41:  01 02
b07_aa43:   .db $04                     ; 1EA43:  04
b07_aa44:   .db $9c                     ; 1EA44:  9c
b07_aa45:   bne $aa07                   ; 1EA45:  d0 c0
b07_aa47:   brk                         ; 1EA47:  00
b07_aa48:   jsr $3022                   ; 1EA48:  20 22 30
b07_aa4b:   beq $aaaf                   ; 1EA4B:  f0 62
b07_aa4d:   .db $04                     ; 1EA4D:  04
b07_aa4e:   ora ($37),y                 ; 1EA4E:  11 37
b07_aa50:   dey                         ; 1EA50:  88
b07_aa51:   .db $42                     ; 1EA51:  42
b07_aa52:   dec $02                     ; 1EA52:  c6 02
b07_aa54:   brk                         ; 1EA54:  00
b07_aa55:   brk                         ; 1EA55:  00
b07_aa56:   brk                         ; 1EA56:  00
b07_aa57:   brk                         ; 1EA57:  00
b07_aa58:   brk                         ; 1EA58:  00
b07_aa59:   brk                         ; 1EA59:  00
b07_aa5a:   brk                         ; 1EA5A:  00
b07_aa5b:   brk                         ; 1EA5B:  00
b07_aa5c:   .db $22                     ; 1EA5C:  22
b07_aa5d:   php                         ; 1EA5D:  08
b07_aa5e:   .db $22                     ; 1EA5E:  22
b07_aa5f:   php                         ; 1EA5F:  08
b07_aa60:   .db $22                     ; 1EA60:  22
b07_aa61:   dey                         ; 1EA61:  88
b07_aa62:   .db $22                     ; 1EA62:  22
b07_aa63:   dey                         ; 1EA63:  88
b07_aa64:   sed                         ; 1EA64:  f8
b07_aa65:   clv                         ; 1EA65:  b8
b07_aa66:   ldy $001c,x                 ; 1EA66:  bc 1c 00
b07_aa69:   cpx #$f0                    ; 1EA69:  e0 f0
b07_aa6b:   .db $80                     ; 1EA6B:  80
b07_aa6c:   .db $02                     ; 1EA6C:  02
b07_aa6d:   .db $02                     ; 1EA6D:  02
b07_aa6e:   brk                         ; 1EA6E:  00
b07_aa6f:   brk                         ; 1EA6F:  00
b07_aa70:   cpx #$1c                    ; 1EA70:  e0 1c
b07_aa72:   .db $0c                     ; 1EA72:  0c
b07_aa73:   bpl $aa75                   ; 1EA73:  10 00
b07_aa75:   brk                         ; 1EA75:  00
b07_aa76:   brk                         ; 1EA76:  00
b07_aa77:   brk                         ; 1EA77:  00
b07_aa78:   brk                         ; 1EA78:  00
b07_aa79:   ora ($0a,x)                 ; 1EA79:  01 0a
b07_aa7b:   eor $22,x                   ; 1EA7B:  55 22
b07_aa7d:   dey                         ; 1EA7D:  88
b07_aa7e:   .db $22                     ; 1EA7E:  22
b07_aa7f:   dey                         ; 1EA7F:  88
b07_aa80:   .db $22                     ; 1EA80:  22
b07_aa81:   .db $80                     ; 1EA81:  80
b07_aa82:   ora $aa,x                   ; 1EA82:  15 aa
b07_aa84:   .db $02                     ; 1EA84:  02
b07_aa85:   .db $02                     ; 1EA85:  02
b07_aa86:   .db $0b                     ; 1EA86:  0b
b07_aa87:   ora $29                     ; 1EA87:  05 29
b07_aa89:   .db $44                     ; 1EA89:  44
b07_aa8a:   tax                         ; 1EA8A:  aa
b07_aa8b:   eor $23                     ; 1EA8B:  45 23
b07_aa8d:   .db $83                     ; 1EA8D:  83
b07_aa8e:   .db $23                     ; 1EA8E:  23
b07_aa8f:   .db $89                     ; 1EA8F:  89
b07_aa90:   ora $aa                     ; 1EA90:  05 aa
b07_aa92:   .db $44                     ; 1EA92:  44
b07_aa93:   tax                         ; 1EA93:  aa
b07_aa94:   tax                         ; 1EA94:  aa
b07_aa95:   eor $8a,x                   ; 1EA95:  55 8a
b07_aa97:   eor $a2                     ; 1EA97:  45 a2
b07_aa99:   eor $a2                     ; 1EA99:  45 a2
b07_aa9b:   eor $55,x                   ; 1EA9B:  55 55
b07_aa9d:   tax                         ; 1EA9D:  aa
b07_aa9e:   adc $aa                     ; 1EA9E:  65 aa
b07_aaa0:   eor $a2                     ; 1EAA0:  45 a2
b07_aaa2:   eor $a2,x                   ; 1EAA2:  55 a2
b07_aaa4:   ldx #$55                    ; 1EAA4:  a2 55
b07_aaa6:   .db $82                     ; 1EAA6:  82
b07_aaa7:   eor $aa,x                   ; 1EAA7:  55 aa
b07_aaa9:   eor ($aa),y                 ; 1EAA9:  51 aa
b07_aaab:   eor $55,x                   ; 1EAAB:  55 55
b07_aaad:   ldx #$75                    ; 1EAAD:  a2 75
b07_aaaf:   ldx #$51                    ; 1EAAF:  a2 51
b07_aab1:   tax                         ; 1EAB1:  aa
b07_aab2:   eor ($a8),y                 ; 1EAB2:  51 a8
b07_aab4:   .db $7f                     ; 1EAB4:  7f
b07_aab5:   .db $3f                     ; 1EAB5:  3f
b07_aab6:   .db $bf                     ; 1EAB6:  bf
b07_aab7:   .db $df                     ; 1EAB7:  df
b07_aab8:   .db $f7                     ; 1EAB8:  f7
b07_aab9:   sbc $7efc,y                 ; 1EAB9:  f9 fc 7e
b07_aabc:   brk                         ; 1EABC:  00
b07_aabd:   .db $80                     ; 1EABD:  80
b07_aabe:   rti                         ; 1EABE:  40
b07_aabf:   jsr $8080                   ; 1EABF:  20 80 80
b07_aac2:   .db $c2                     ; 1EAC2:  c2
b07_aac3:   eor ($fe,x)                 ; 1EAC3:  41 fe
b07_aac5:   inc $fffe,x                 ; 1EAC5:  fe fe ff
b07_aac8:   .db $ff                     ; 1EAC8:  ff
b07_aac9:   .db $ff                     ; 1EAC9:  ff
b07_aaca:   .db $3f                     ; 1EACA:  3f
b07_aacb:   .db $07                     ; 1EACB:  07
b07_aacc:   ora ($00,x)                 ; 1EACC:  01 00
b07_aace:   ora ($00,x)                 ; 1EACE:  01 00
b07_aad0:   brk                         ; 1EAD0:  00
b07_aad1:   brk                         ; 1EAD1:  00
b07_aad2:   brk                         ; 1EAD2:  00
b07_aad3:   brk                         ; 1EAD3:  00
b07_aad4:   .db $7f                     ; 1EAD4:  7f
b07_aad5:   .db $3f                     ; 1EAD5:  3f
b07_aad6:   .db $9f                     ; 1EAD6:  9f
b07_aad7:   .db $4f                     ; 1EAD7:  4f
b07_aad8:   .db $a7                     ; 1EAD8:  a7
b07_aad9:   .db $53                     ; 1EAD9:  53
b07_aada:   lda #$54                    ; 1EADA:  a9 54
b07_aadc:   rts                         ; 1EADC:  60
b07_aadd:   bcs $ab37                   ; 1EADD:  b0 58
b07_aadf:   ldy $ab56                   ; 1EADF:  ac 56 ab
b07_aae2:   eor $aa,x                   ; 1EAE2:  55 aa
b07_aae4:   brk                         ; 1EAE4:  00
b07_aae5:   .db $80                     ; 1EAE5:  80
b07_aae6:   cpy #$f0                    ; 1EAE6:  c0 f0
b07_aae8:   .db $fc                     ; 1EAE8:  fc
b07_aae9:   inc $fcfc,x                 ; 1EAE9:  fe fc fc
b07_aaec:   cpy #$78                    ; 1EAEC:  c0 78
b07_aaee:   rol $030f,x                 ; 1EAEE:  3e 0f 03
b07_aaf1:   ora ($83,x)                 ; 1EAF1:  01 83
b07_aaf3:   .db $c3                     ; 1EAF3:  c3
b07_aaf4:   bvs $ab56                   ; 1EAF4:  70 60
b07_aaf6:   .db $c2                     ; 1EAF6:  c2
b07_aaf7:   cmp ($e0,x)                 ; 1EAF7:  c1 e0
b07_aaf9:   cpx #$e0                    ; 1EAF9:  e0 e0
b07_aafb:   cpy #$08                    ; 1EAFB:  c0 08
b07_aafd:   brk                         ; 1EAFD:  00
b07_aafe:   ora ($3a),y                 ; 1EAFE:  11 3a
b07_ab00:   ora $1510,y                 ; 1EB00:  19 10 15
b07_ab03:   php                         ; 1EB03:  08
b07_ab04:   brk                         ; 1EB04:  00
b07_ab05:   brk                         ; 1EB05:  00
b07_ab06:   brk                         ; 1EB06:  00
b07_ab07:   bvc $ab13                   ; 1EB07:  50 0a
b07_ab09:   ora $0a                     ; 1EB09:  05 0a
b07_ab0b:   .db $14                     ; 1EB0B:  14
b07_ab0c:   .db $22                     ; 1EB0C:  22
b07_ab0d:   dey                         ; 1EB0D:  88
b07_ab0e:   .db $02                     ; 1EB0E:  02
b07_ab0f:   ldy #$55                    ; 1EB0F:  a0 55
b07_ab11:   tax                         ; 1EB11:  aa
b07_ab12:   eor $aa,x                   ; 1EB12:  55 aa
b07_ab14:   clc                         ; 1EB14:  18
b07_ab15:   bpl $ab2f                   ; 1EB15:  10 18
b07_ab17:   .db $14                     ; 1EB17:  14
b07_ab18:   clc                         ; 1EB18:  18
b07_ab19:   .db $14                     ; 1EB19:  14
b07_ab1a:   plp                         ; 1EB1A:  28
b07_ab1b:   .db $34                     ; 1EB1B:  34
b07_ab1c:   ora $1a,x                   ; 1EB1C:  15 1a
b07_ab1e:   .db $14                     ; 1EB1E:  14
b07_ab1f:   .db $da                     ; 1EB1F:  da
b07_ab20:   .db $d4                     ; 1EB20:  d4
b07_ab21:   txs                         ; 1EB21:  9a
b07_ab22:   ldy $aa,x                   ; 1EB22:  b4 aa
b07_ab24:   rol a                       ; 1EB24:  2a
b07_ab25:   ora $0a,x                   ; 1EB25:  15 0a
b07_ab27:   eor $2a,x                   ; 1EB27:  55 2a
b07_ab29:   eor $aa,x                   ; 1EB29:  55 aa
b07_ab2b:   eor $54,x                   ; 1EB2B:  55 54
b07_ab2d:   tax                         ; 1EB2D:  aa
b07_ab2e:   adc $aa,x                   ; 1EB2E:  75 aa
b07_ab30:   eor $aa,x                   ; 1EB30:  55 aa
b07_ab32:   eor $aa,x                   ; 1EB32:  55 aa
b07_ab34:   sta $9966,y                 ; 1EB34:  99 66 99
b07_ab37:   ror $99                     ; 1EB37:  66 99
b07_ab39:   ror $99                     ; 1EB39:  66 99
b07_ab3b:   ror $44                     ; 1EB3B:  66 44
b07_ab3d:   ora ($44),y                 ; 1EB3D:  11 44
b07_ab3f:   ora ($44),y                 ; 1EB3F:  11 44
b07_ab41:   ora ($44),y                 ; 1EB41:  11 44
b07_ab43:   ora ($99),y                 ; 1EB43:  11 99
b07_ab45:   ror $99                     ; 1EB45:  66 99
b07_ab47:   ror $98                     ; 1EB47:  66 98
b07_ab49:   rts                         ; 1EB49:  60
b07_ab4a:   tya                         ; 1EB4A:  98
b07_ab4b:   rts                         ; 1EB4B:  60
b07_ab4c:   .db $44                     ; 1EB4C:  44
b07_ab4d:   ora ($44),y                 ; 1EB4D:  11 44
b07_ab4f:   ora ($44),y                 ; 1EB4F:  11 44
b07_ab51:   bpl $ab94                   ; 1EB51:  10 41
b07_ab53:   ora ($90),y                 ; 1EB53:  11 90
b07_ab55:   rts                         ; 1EB55:  60
b07_ab56:   .db $80                     ; 1EB56:  80
b07_ab57:   adc ($81,x)                 ; 1EB57:  61 81
b07_ab59:   adc ($81,x)                 ; 1EB59:  61 81
b07_ab5b:   .db $63                     ; 1EB5B:  63
b07_ab5c:   .db $43                     ; 1EB5C:  43
b07_ab5d:   .db $03                     ; 1EB5D:  03
b07_ab5e:   .db $47                     ; 1EB5E:  47
b07_ab5f:   asl $46                     ; 1EB5F:  06 46
b07_ab61:   asl $0c4e                   ; 1EB61:  0e 4e 0c
b07_ab64:   sta $8166,y                 ; 1EB64:  99 66 81
b07_ab67:   .db $07                     ; 1EB67:  07
b07_ab68:   .db $1f                     ; 1EB68:  1f
b07_ab69:   .db $3f                     ; 1EB69:  3f
b07_ab6a:   .db $7f                     ; 1EB6A:  7f
b07_ab6b:   .db $7f                     ; 1EB6B:  7f
b07_ab6c:   .db $44                     ; 1EB6C:  44
b07_ab6d:   ora ($42),y                 ; 1EB6D:  11 42
b07_ab6f:   clc                         ; 1EB6F:  18
b07_ab70:   rts                         ; 1EB70:  60
b07_ab71:   cpy #$80                    ; 1EB71:  c0 80
b07_ab73:   .db $80                     ; 1EB73:  80
b07_ab74:   ora ($02,x)                 ; 1EB74:  01 02
b07_ab76:   sed                         ; 1EB76:  f8
b07_ab77:   .db $ff                     ; 1EB77:  ff
b07_ab78:   .db $ff                     ; 1EB78:  ff
b07_ab79:   .db $ff                     ; 1EB79:  ff
b07_ab7a:   .db $ff                     ; 1EB7A:  ff
b07_ab7b:   .db $ff                     ; 1EB7B:  ff
b07_ab7c:   brk                         ; 1EB7C:  00
b07_ab7d:   .db $02                     ; 1EB7D:  02
b07_ab7e:   brk                         ; 1EB7E:  00
b07_ab7f:   brk                         ; 1EB7F:  00
b07_ab80:   brk                         ; 1EB80:  00
b07_ab81:   brk                         ; 1EB81:  00
b07_ab82:   brk                         ; 1EB82:  00
b07_ab83:   brk                         ; 1EB83:  00
b07_ab84:   .db $ff                     ; 1EB84:  ff
b07_ab85:   .db $ff                     ; 1EB85:  ff
b07_ab86:   .db $ff                     ; 1EB86:  ff
b07_ab87:   .db $ff                     ; 1EB87:  ff
b07_ab88:   .db $ff                     ; 1EB88:  ff
b07_ab89:   .db $ff                     ; 1EB89:  ff
b07_ab8a:   .db $ff                     ; 1EB8A:  ff
b07_ab8b:   .db $ff                     ; 1EB8B:  ff
b07_ab8c:   brk                         ; 1EB8C:  00
b07_ab8d:   brk                         ; 1EB8D:  00
b07_ab8e:   brk                         ; 1EB8E:  00
b07_ab8f:   brk                         ; 1EB8F:  00
b07_ab90:   brk                         ; 1EB90:  00
b07_ab91:   brk                         ; 1EB91:  00
b07_ab92:   brk                         ; 1EB92:  00
b07_ab93:   brk                         ; 1EB93:  00
b07_ab94:   sta $9966,y                 ; 1EB94:  99 66 99
b07_ab97:   rol $99                     ; 1EB97:  26 99
b07_ab99:   dec $e1                     ; 1EB99:  c6 e1
b07_ab9b:   inc $44                     ; 1EB9B:  e6 44
b07_ab9d:   ora ($44),y                 ; 1EB9D:  11 44
b07_ab9f:   ora ($04),y                 ; 1EB9F:  11 04
b07_aba1:   ora ($04,x)                 ; 1EBA1:  01 04
b07_aba3:   ora ($f1,x)                 ; 1EBA3:  01 f1
b07_aba5:   .db $f2                     ; 1EBA5:  f2
b07_aba6:   sbc ($e2),y                 ; 1EBA6:  f1 e2
b07_aba8:   sbc ($c2),y                 ; 1EBA8:  f1 c2
b07_abaa:   sbc ($82,x)                 ; 1EBAA:  e1 82
b07_abac:   brk                         ; 1EBAC:  00
b07_abad:   ora ($00,x)                 ; 1EBAD:  01 00
b07_abaf:   ora ($00,x)                 ; 1EBAF:  01 00
b07_abb1:   ora ($00,x)                 ; 1EBB1:  01 00
b07_abb3:   ora ($82,x)                 ; 1EBB3:  01 82
b07_abb5:   rts                         ; 1EBB5:  60
b07_abb6:   .db $80                     ; 1EBB6:  80
b07_abb7:   eor ($80,x)                 ; 1EBB7:  41 80
b07_abb9:   eor ($81,x)                 ; 1EBB9:  41 81
b07_abbb:   .db $43                     ; 1EBBB:  43
b07_abbc:   pha                         ; 1EBBC:  48
b07_abbd:   php                         ; 1EBBD:  08
b07_abbe:   lsr $440e                   ; 1EBBE:  4e 0e 44
b07_abc1:   .db $07                     ; 1EBC1:  07
b07_abc2:   lsr $0c                     ; 1EBC2:  46 0c
b07_abc4:   .db $83                     ; 1EBC4:  83
b07_abc5:   .db $63                     ; 1EBC5:  63
b07_abc6:   .db $83                     ; 1EBC6:  83
b07_abc7:   .db $63                     ; 1EBC7:  63
b07_abc8:   sta ($60,x)                 ; 1EBC8:  81 60
b07_abca:   bcc $ac2c                   ; 1EBCA:  90 60
b07_abcc:   jmp $4c0c                   ; 1EBCC:  4c 0c 4c
b07_abcf:   .db $0c                     ; 1EBCF:  0c
b07_abd0:   lsr $17                     ; 1EBD0:  46 17
b07_abd2:   .db $47                     ; 1EBD2:  47
b07_abd3:   .db $13                     ; 1EBD3:  13
b07_abd4:   .db $ff                     ; 1EBD4:  ff
b07_abd5:   .db $7f                     ; 1EBD5:  7f
b07_abd6:   .db $3f                     ; 1EBD6:  3f
b07_abd7:   stx $270f                   ; 1EBD7:  8e 0f 27
b07_abda:   .db $e7                     ; 1EBDA:  e7
b07_abdb:   .db $c7                     ; 1EBDB:  c7
b07_abdc:   brk                         ; 1EBDC:  00
b07_abdd:   brk                         ; 1EBDD:  00
b07_abde:   brk                         ; 1EBDE:  00
b07_abdf:   rti                         ; 1EBDF:  40
b07_abe0:   brk                         ; 1EBE0:  00
b07_abe1:   jsr $3818                   ; 1EBE1:  20 18 38
b07_abe4:   .db $fa                     ; 1EBE4:  fa
b07_abe5:   beq $ab6a                   ; 1EBE5:  f0 83
b07_abe7:   .db $1f                     ; 1EBE7:  1f
b07_abe8:   ora ($27,x)                 ; 1EBE8:  01 27
b07_abea:   .db $bf                     ; 1EBEA:  bf
b07_abeb:   .db $df                     ; 1EBEB:  df
b07_abec:   brk                         ; 1EBEC:  00
b07_abed:   brk                         ; 1EBED:  00
b07_abee:   brk                         ; 1EBEE:  00
b07_abef:   jsr $a4c0                   ; 1EBEF:  20 c0 a4
b07_abf2:   rti                         ; 1EBF2:  40
b07_abf3:   jsr $cfe7                   ; 1EBF3:  20 e7 cf
b07_abf6:   .db $cf                     ; 1EBF6:  cf
b07_abf7:   .db $df                     ; 1EBF7:  df
b07_abf8:   sty $1180                   ; 1EBF8:  8c 80 11
b07_abfb:   .db $1f                     ; 1EBFB:  1f
b07_abfc:   clc                         ; 1EBFC:  18
b07_abfd:   jsr $2030                   ; 1EBFD:  20 30 20
b07_ac00:   rts                         ; 1EC00:  60
b07_ac01:   adc ($ee),y                 ; 1EC01:  71 ee
b07_ac03:   cpx #$ff                    ; 1EC03:  e0 ff
b07_ac05:   .db $ff                     ; 1EC05:  ff
b07_ac06:   .db $ff                     ; 1EC06:  ff
b07_ac07:   .db $7f                     ; 1EC07:  7f
b07_ac08:   .db $3f                     ; 1EC08:  3f
b07_ac09:   .db $5f                     ; 1EC09:  5f
b07_ac0a:   .db $ff                     ; 1EC0A:  ff
b07_ac0b:   .db $ff                     ; 1EC0B:  ff
b07_ac0c:   brk                         ; 1EC0C:  00
b07_ac0d:   brk                         ; 1EC0D:  00
b07_ac0e:   brk                         ; 1EC0E:  00
b07_ac0f:   brk                         ; 1EC0F:  00
b07_ac10:   rti                         ; 1EC10:  40
b07_ac11:   ldy #$00                    ; 1EC11:  a0 00
b07_ac13:   brk                         ; 1EC13:  00
b07_ac14:   cmp ($e0,x)                 ; 1EC14:  c1 e0
b07_ac16:   inc $ea                     ; 1EC16:  e6 ea
b07_ac18:   .db $f2                     ; 1EC18:  f2
b07_ac19:   .db $e2                     ; 1EC19:  e2
b07_ac1a:   .db $e2                     ; 1EC1A:  e2
b07_ac1b:   inc $00                     ; 1EC1B:  e6 00
b07_ac1d:   ora ($00,x)                 ; 1EC1D:  01 00
b07_ac1f:   brk                         ; 1EC1F:  00
b07_ac20:   brk                         ; 1EC20:  00
b07_ac21:   .db $14                     ; 1EC21:  14
b07_ac22:   brk                         ; 1EC22:  00
b07_ac23:   bpl $ac0a                   ; 1EC23:  10 e5
b07_ac25:   nop                         ; 1EC25:  ea
b07_ac26:   sbc $e9f6,y                 ; 1EC26:  f9 f6 e9
b07_ac29:   inc $e9                     ; 1EC29:  e6 e9
b07_ac2b:   dec $00                     ; 1EC2B:  c6 00
b07_ac2d:   ora ($00,x)                 ; 1EC2D:  01 00
b07_ac2f:   ora ($04,x)                 ; 1EC2F:  01 04
b07_ac31:   ora ($04,x)                 ; 1EC31:  01 04
b07_ac33:   ora ($99),y                 ; 1EC33:  11 99
b07_ac35:   ror $99                     ; 1EC35:  66 99
b07_ac37:   ror $99                     ; 1EC37:  66 99
b07_ac39:   ror $80                     ; 1EC39:  66 80
b07_ac3b:   brk                         ; 1EC3B:  00
b07_ac3c:   .db $44                     ; 1EC3C:  44
b07_ac3d:   ora ($44),y                 ; 1EC3D:  11 44
b07_ac3f:   ora ($44),y                 ; 1EC3F:  11 44
b07_ac41:   ora ($40),y                 ; 1EC41:  11 40
b07_ac43:   .db $02                     ; 1EC43:  02
b07_ac44:   tya                         ; 1EC44:  98
b07_ac45:   rts                         ; 1EC45:  60
b07_ac46:   tya                         ; 1EC46:  98
b07_ac47:   .db $64                     ; 1EC47:  64
b07_ac48:   tya                         ; 1EC48:  98
b07_ac49:   brk                         ; 1EC49:  00
b07_ac4a:   brk                         ; 1EC4A:  00
b07_ac4b:   brk                         ; 1EC4B:  00
b07_ac4c:   .db $43                     ; 1EC4C:  43
b07_ac4d:   .db $13                     ; 1EC4D:  13
b07_ac4e:   eor $11                     ; 1EC4E:  45 11
b07_ac50:   rti                         ; 1EC50:  40
b07_ac51:   .db $02                     ; 1EC51:  02
b07_ac52:   php                         ; 1EC52:  08
b07_ac53:   .db $22                     ; 1EC53:  22
b07_ac54:   rti                         ; 1EC54:  40
b07_ac55:   ora ($44),y                 ; 1EC55:  11 44
b07_ac57:   ora ($44),y                 ; 1EC57:  11 44
b07_ac59:   ora ($44),y                 ; 1EC59:  11 44
b07_ac5b:   ora ($08),y                 ; 1EC5B:  11 08
b07_ac5d:   .db $22                     ; 1EC5D:  22
b07_ac5e:   dey                         ; 1EC5E:  88
b07_ac5f:   .db $22                     ; 1EC5F:  22
b07_ac60:   dey                         ; 1EC60:  88
b07_ac61:   .db $22                     ; 1EC61:  22
b07_ac62:   dey                         ; 1EC62:  88
b07_ac63:   .db $22                     ; 1EC63:  22
b07_ac64:   brk                         ; 1EC64:  00
b07_ac65:   brk                         ; 1EC65:  00
b07_ac66:   brk                         ; 1EC66:  00
b07_ac67:   brk                         ; 1EC67:  00
b07_ac68:   .db $44                     ; 1EC68:  44
b07_ac69:   ora ($45,x)                 ; 1EC69:  01 45
b07_ac6b:   ora ($80),y                 ; 1EC6B:  11 80
b07_ac6d:   .db $22                     ; 1EC6D:  22
b07_ac6e:   dey                         ; 1EC6E:  88
b07_ac6f:   .db $22                     ; 1EC6F:  22
b07_ac70:   dey                         ; 1EC70:  88
b07_ac71:   brk                         ; 1EC71:  00
b07_ac72:   dey                         ; 1EC72:  88
b07_ac73:   brk                         ; 1EC73:  00
b07_ac74:   .db $02                     ; 1EC74:  02
b07_ac75:   .db $0f                     ; 1EC75:  0f
b07_ac76:   clc                         ; 1EC76:  18
b07_ac77:   brk                         ; 1EC77:  00
b07_ac78:   brk                         ; 1EC78:  00
b07_ac79:   .db $0f                     ; 1EC79:  0f
b07_ac7a:   .db $0f                     ; 1EC7A:  0f
b07_ac7b:   .db $07                     ; 1EC7B:  07
b07_ac7c:   cpx #$c0                    ; 1EC7C:  e0 c0
b07_ac7e:   cpx #$fb                    ; 1EC7E:  e0 fb
b07_ac80:   .db $ff                     ; 1EC80:  ff
b07_ac81:   bvs $acb3                   ; 1EC81:  70 30
b07_ac83:   cli                         ; 1EC83:  58
b07_ac84:   .db $5f                     ; 1EC84:  5f
b07_ac85:   .db $9f                     ; 1EC85:  9f
b07_ac86:   .db $df                     ; 1EC86:  df
b07_ac87:   .db $7f                     ; 1EC87:  7f
b07_ac88:   ror $f3fd,x                 ; 1EC88:  7e fd f3
b07_ac8b:   .db $c7                     ; 1EC8B:  c7
b07_ac8c:   jsr $2000                   ; 1EC8C:  20 00 20
b07_ac8f:   brk                         ; 1EC8F:  00
b07_ac90:   .db $80                     ; 1EC90:  80
b07_ac91:   brk                         ; 1EC91:  00
b07_ac92:   brk                         ; 1EC92:  00
b07_ac93:   brk                         ; 1EC93:  00
b07_ac94:   .db $80                     ; 1EC94:  80
b07_ac95:   .db $80                     ; 1EC95:  80
b07_ac96:   cpy #$41                    ; 1EC96:  c0 41
b07_ac98:   .db $47                     ; 1EC98:  47
b07_ac99:   .db $67                     ; 1EC99:  67
b07_ac9a:   .db $a3                     ; 1EC9A:  a3
b07_ac9b:   .db $33                     ; 1EC9B:  33
b07_ac9c:   ldy #$b0                    ; 1EC9C:  a0 b0
b07_ac9e:   .db $df                     ; 1EC9E:  df
b07_ac9f:   lsr $6858,x                 ; 1EC9F:  5e 58 68
b07_aca2:   bit $0f34                   ; 1ECA2:  2c 34 0f
b07_aca5:   .db $1f                     ; 1ECA5:  1f
b07_aca6:   .db $7f                     ; 1ECA6:  7f
b07_aca7:   .db $ff                     ; 1ECA7:  ff
b07_aca8:   inc $f9fd,x                 ; 1ECA8:  fe fd f9
b07_acab:   .db $f7                     ; 1ECAB:  f7
b07_acac:   bpl $ad0f                   ; 1ECAC:  10 61
b07_acae:   sta ($03,x)                 ; 1ECAE:  81 03
b07_acb0:   asl $0c                     ; 1ECB0:  06 0c
b07_acb2:   clc                         ; 1ECB2:  18
b07_acb3:   bmi $ac8e                   ; 1ECB3:  30 d9
b07_acb5:   stx $c9                     ; 1ECB5:  86 c9
b07_acb7:   lsr $c1                     ; 1ECB7:  46 c1
b07_acb9:   bne $ac7b                   ; 1ECB9:  d0 c0
b07_acbb:   cmp ($04),y                 ; 1ECBB:  d1 04
b07_acbd:   ora ($04),y                 ; 1ECBD:  11 04
b07_acbf:   ora ($00),y                 ; 1ECBF:  11 00
b07_acc1:   .db $42                     ; 1ECC1:  42
b07_acc2:   pha                         ; 1ECC2:  48
b07_acc3:   .db $c2                     ; 1ECC3:  c2
b07_acc4:   sta $9966,y                 ; 1ECC4:  99 66 99
b07_acc7:   ror $99                     ; 1ECC7:  66 99
b07_acc9:   asl $40                     ; 1ECC9:  06 40
b07_accb:   ora ($44),y                 ; 1ECCB:  11 44
b07_accd:   ora ($44),y                 ; 1ECCD:  11 44
b07_accf:   ora ($44),y                 ; 1ECCF:  11 44
b07_acd1:   ora ($80),y                 ; 1ECD1:  11 80
b07_acd3:   .db $22                     ; 1ECD3:  22
b07_acd4:   .db $80                     ; 1ECD4:  80
b07_acd5:   sta ($44),y                 ; 1ECD5:  91 44
b07_acd7:   eor ($c4),y                 ; 1ECD7:  51 c4
b07_acd9:   ora ($84),y                 ; 1ECD9:  11 84
b07_acdb:   ora ($88),y                 ; 1ECDB:  11 88
b07_acdd:   .db $82                     ; 1ECDD:  82
b07_acde:   php                         ; 1ECDE:  08
b07_acdf:   brk                         ; 1ECDF:  00
b07_ace0:   php                         ; 1ECE0:  08
b07_ace1:   jsr $2008                   ; 1ECE1:  20 08 20
b07_ace4:   .db $44                     ; 1ECE4:  44
b07_ace5:   ora ($44),y                 ; 1ECE5:  11 44
b07_ace7:   ora ($44),y                 ; 1ECE7:  11 44
b07_ace9:   ora ($44),y                 ; 1ECE9:  11 44
b07_aceb:   ora ($88),y                 ; 1ECEB:  11 88
b07_aced:   .db $22                     ; 1ECED:  22
b07_acee:   dey                         ; 1ECEE:  88
b07_acef:   .db $22                     ; 1ECEF:  22
b07_acf0:   dey                         ; 1ECF0:  88
b07_acf1:   .db $22                     ; 1ECF1:  22
b07_acf2:   dey                         ; 1ECF2:  88
b07_acf3:   .db $22                     ; 1ECF3:  22
b07_acf4:   ora ($08),y                 ; 1ECF4:  11 08
b07_acf6:   .db $04                     ; 1ECF6:  04
b07_acf7:   jsr $8810                   ; 1ECF7:  20 10 88
b07_acfa:   .db $44                     ; 1ECFA:  44
b07_acfb:   .db $22                     ; 1ECFB:  22
b07_acfc:   .db $77                     ; 1ECFC:  77
b07_acfd:   nop                         ; 1ECFD:  ea
b07_acfe:   cmp $77ab,x                 ; 1ECFE:  dd ab 77
b07_ad01:   tsx                         ; 1ED01:  ba
b07_ad02:   cmp $18ae,x                 ; 1ED02:  dd ae 18
b07_ad05:   .db $0c                     ; 1ED05:  0c
b07_ad06:   asl $1c3d                   ; 1ED06:  0e 3d 1c
b07_ad09:   sta $2353,y                 ; 1ED09:  99 53 23
b07_ad0c:   sei                         ; 1ED0C:  78
b07_ad0d:   cpx $bdde                   ; 1ED0D:  ec de bd
b07_ad10:   .db $7c                     ; 1ED10:  7c
b07_ad11:   clv                         ; 1ED11:  b8
b07_ad12:   bne $acb4                   ; 1ED12:  d0 a0
b07_ad14:   .db $03                     ; 1ED14:  03
b07_ad15:   ora ($00,x)                 ; 1ED15:  01 00
b07_ad17:   brk                         ; 1ED17:  00
b07_ad18:   brk                         ; 1ED18:  00
b07_ad19:   brk                         ; 1ED19:  00
b07_ad1a:   brk                         ; 1ED1A:  00
b07_ad1b:   brk                         ; 1ED1B:  00
b07_ad1c:   rti                         ; 1ED1C:  40
b07_ad1d:   cpy #$80                    ; 1ED1D:  c0 80
b07_ad1f:   .db $80                     ; 1ED1F:  80
b07_ad20:   brk                         ; 1ED20:  00
b07_ad21:   brk                         ; 1ED21:  00
b07_ad22:   brk                         ; 1ED22:  00
b07_ad23:   brk                         ; 1ED23:  00
b07_ad24:   ora ($08,x)                 ; 1ED24:  01 08
b07_ad26:   .db $04                     ; 1ED26:  04
b07_ad27:   .db $1f                     ; 1ED27:  1f
b07_ad28:   .db $ff                     ; 1ED28:  ff
b07_ad29:   .db $ff                     ; 1ED29:  ff
b07_ad2a:   .db $ff                     ; 1ED2A:  ff
b07_ad2b:   .db $ff                     ; 1ED2B:  ff
b07_ad2c:   .db $07                     ; 1ED2C:  07
b07_ad2d:   asl a                       ; 1ED2D:  0a
b07_ad2e:   eor $0000,x                 ; 1ED2E:  5d 00 00
b07_ad31:   brk                         ; 1ED31:  00
b07_ad32:   brk                         ; 1ED32:  00
b07_ad33:   brk                         ; 1ED33:  00
b07_ad34:   ora ($08),y                 ; 1ED34:  11 08
b07_ad36:   .db $04                     ; 1ED36:  04
b07_ad37:   beq $ad37                   ; 1ED37:  f0 fe
b07_ad39:   .db $ff                     ; 1ED39:  ff
b07_ad3a:   .db $ff                     ; 1ED3A:  ff
b07_ad3b:   .db $ff                     ; 1ED3B:  ff
b07_ad3c:   .db $77                     ; 1ED3C:  77
b07_ad3d:   nop                         ; 1ED3D:  ea
b07_ad3e:   cmp $010e,x                 ; 1ED3E:  dd 0e 01
b07_ad41:   brk                         ; 1ED41:  00
b07_ad42:   brk                         ; 1ED42:  00
b07_ad43:   brk                         ; 1ED43:  00
b07_ad44:   .db $ff                     ; 1ED44:  ff
b07_ad45:   .db $ff                     ; 1ED45:  ff
b07_ad46:   .db $ff                     ; 1ED46:  ff
b07_ad47:   .db $7f                     ; 1ED47:  7f
b07_ad48:   .db $1f                     ; 1ED48:  1f
b07_ad49:   .db $3f                     ; 1ED49:  3f
b07_ad4a:   lsr $00b8,x                 ; 1ED4A:  5e b8 00
b07_ad4d:   brk                         ; 1ED4D:  00
b07_ad4e:   brk                         ; 1ED4E:  00
b07_ad4f:   brk                         ; 1ED4F:  00
b07_ad50:   brk                         ; 1ED50:  00
b07_ad51:   brk                         ; 1ED51:  00
b07_ad52:   brk                         ; 1ED52:  00
b07_ad53:   brk                         ; 1ED53:  00
b07_ad54:   .db $ff                     ; 1ED54:  ff
b07_ad55:   .db $ff                     ; 1ED55:  ff
b07_ad56:   .db $ff                     ; 1ED56:  ff
b07_ad57:   .db $ff                     ; 1ED57:  ff
b07_ad58:   .db $ff                     ; 1ED58:  ff
b07_ad59:   .db $ff                     ; 1ED59:  ff
b07_ad5a:   .db $7f                     ; 1ED5A:  7f
b07_ad5b:   .db $0f                     ; 1ED5B:  0f
b07_ad5c:   brk                         ; 1ED5C:  00
b07_ad5d:   brk                         ; 1ED5D:  00
b07_ad5e:   brk                         ; 1ED5E:  00
b07_ad5f:   brk                         ; 1ED5F:  00
b07_ad60:   brk                         ; 1ED60:  00
b07_ad61:   brk                         ; 1ED61:  00
b07_ad62:   brk                         ; 1ED62:  00
b07_ad63:   brk                         ; 1ED63:  00
b07_ad64:   ora ($08),y                 ; 1ED64:  11 08
b07_ad66:   .db $04                     ; 1ED66:  04
b07_ad67:   jsr $8810                   ; 1ED67:  20 10 88
b07_ad6a:   cpy $e2                     ; 1ED6A:  c4 e2
b07_ad6c:   .db $77                     ; 1ED6C:  77
b07_ad6d:   nop                         ; 1ED6D:  ea
b07_ad6e:   cmp $97ab,x                 ; 1ED6E:  dd ab 97
b07_ad71:   ror a                       ; 1ED71:  6a
b07_ad72:   and $1a,x                   ; 1ED72:  35 1a
b07_ad74:   sbc ($f8),y                 ; 1ED74:  f1 f8
b07_ad76:   sed                         ; 1ED76:  f8
b07_ad77:   sed                         ; 1ED77:  f8
b07_ad78:   .db $fc                     ; 1ED78:  fc
b07_ad79:   .db $fc                     ; 1ED79:  fc
b07_ad7a:   .db $fc                     ; 1ED7A:  fc
b07_ad7b:   inc $040d,x                 ; 1ED7B:  fe 0d 04
b07_ad7e:   asl $06                     ; 1ED7E:  06 06
b07_ad80:   .db $03                     ; 1ED80:  03
b07_ad81:   .db $03                     ; 1ED81:  03
b07_ad82:   .db $03                     ; 1ED82:  03
b07_ad83:   ora ($11,x)                 ; 1ED83:  01 11
b07_ad85:   php                         ; 1ED85:  08
b07_ad86:   .db $04                     ; 1ED86:  04
b07_ad87:   jsr $0810                   ; 1ED87:  20 10 08
b07_ad8a:   .db $44                     ; 1ED8A:  44
b07_ad8b:   .db $22                     ; 1ED8B:  22
b07_ad8c:   .db $77                     ; 1ED8C:  77
b07_ad8d:   nop                         ; 1ED8D:  ea
b07_ad8e:   cmp $77ab,x                 ; 1ED8E:  dd ab 77
b07_ad91:   .db $3a                     ; 1ED91:  3a
b07_ad92:   eor $00ae,x                 ; 1ED92:  5d ae 00
b07_ad95:   brk                         ; 1ED95:  00
b07_ad96:   brk                         ; 1ED96:  00
b07_ad97:   clc                         ; 1ED97:  18
b07_ad98:   bit $22                     ; 1ED98:  24 22
b07_ad9a:   and ($21,x)                 ; 1ED9A:  21 21
b07_ad9c:   brk                         ; 1ED9C:  00
b07_ad9d:   brk                         ; 1ED9D:  00
b07_ad9e:   brk                         ; 1ED9E:  00
b07_ad9f:   brk                         ; 1ED9F:  00
b07_ada0:   brk                         ; 1EDA0:  00
b07_ada1:   php                         ; 1EDA1:  08
b07_ada2:   brk                         ; 1EDA2:  00
b07_ada3:   bpl $adc6                   ; 1EDA3:  10 21
b07_ada5:   ora ($18),y                 ; 1EDA5:  11 18
b07_ada7:   ora $8307                   ; 1EDA7:  0d 07 83
b07_adaa:   rti                         ; 1EDAA:  40
b07_adab:   jsr $8c1a                   ; 1EDAB:  20 1a 8c
b07_adae:   .db $80                     ; 1EDAE:  80
b07_adaf:   .db $80                     ; 1EDAF:  80
b07_adb0:   rti                         ; 1EDB0:  40
b07_adb1:   .db $80                     ; 1EDB1:  80
b07_adb2:   cpy #$a0                    ; 1EDB2:  c0 a0
b07_adb4:   .db $7f                     ; 1EDB4:  7f
b07_adb5:   .db $7f                     ; 1EDB5:  7f
b07_adb6:   sed                         ; 1EDB6:  f8
b07_adb7:   adc $7fff,x                 ; 1EDB7:  7d ff 7f
b07_adba:   .db $7f                     ; 1EDBA:  7f
b07_adbb:   .db $7f                     ; 1EDBB:  7f
b07_adbc:   brk                         ; 1EDBC:  00
b07_adbd:   brk                         ; 1EDBD:  00
b07_adbe:   brk                         ; 1EDBE:  00
b07_adbf:   ora ($00,x)                 ; 1EDBF:  01 00
b07_adc1:   brk                         ; 1EDC1:  00
b07_adc2:   brk                         ; 1EDC2:  00
b07_adc3:   brk                         ; 1EDC3:  00
b07_adc4:   .db $82                     ; 1EDC4:  82
b07_adc5:   cpy #$01                    ; 1EDC5:  c0 01
b07_adc7:   .db $23                     ; 1EDC7:  23
b07_adc8:   .db $f7                     ; 1EDC8:  f7
b07_adc9:   .db $ef                     ; 1EDC9:  ef
b07_adca:   .db $ff                     ; 1EDCA:  ff
b07_adcb:   .db $ff                     ; 1EDCB:  ff
b07_adcc:   ora ($20,x)                 ; 1EDCC:  01 20
b07_adce:   .db $0c                     ; 1EDCE:  0c
b07_adcf:   bit $08                     ; 1EDCF:  24 08
b07_add1:   bpl $add3                   ; 1EDD1:  10 00
b07_add3:   brk                         ; 1EDD3:  00
b07_add4:   .db $ff                     ; 1EDD4:  ff
b07_add5:   .db $ff                     ; 1EDD5:  ff
b07_add6:   .db $ff                     ; 1EDD6:  ff
b07_add7:   .db $ff                     ; 1EDD7:  ff
b07_add8:   .db $ff                     ; 1EDD8:  ff
b07_add9:   .db $7f                     ; 1EDD9:  7f
b07_adda:   .db $7f                     ; 1EDDA:  7f
b07_addb:   .db $7f                     ; 1EDDB:  7f
b07_addc:   brk                         ; 1EDDC:  00
b07_addd:   brk                         ; 1EDDD:  00
b07_adde:   brk                         ; 1EDDE:  00
b07_addf:   brk                         ; 1EDDF:  00
b07_ade0:   brk                         ; 1EDE0:  00
b07_ade1:   brk                         ; 1EDE1:  00
b07_ade2:   brk                         ; 1EDE2:  00
b07_ade3:   brk                         ; 1EDE3:  00
b07_ade4:   .db $ff                     ; 1EDE4:  ff
b07_ade5:   .db $ff                     ; 1EDE5:  ff
b07_ade6:   sbc $fcff,x                 ; 1EDE6:  fd ff fc
b07_ade9:   .db $fc                     ; 1EDE9:  fc
b07_adea:   inx                         ; 1EDEA:  e8
b07_adeb:   cmp ($00,x)                 ; 1EDEB:  c1 00
b07_aded:   brk                         ; 1EDED:  00
b07_adee:   brk                         ; 1EDEE:  00
b07_adef:   brk                         ; 1EDEF:  00
b07_adf0:   .db $02                     ; 1EDF0:  02
b07_adf1:   ora ($00,x)                 ; 1EDF1:  01 00
b07_adf3:   brk                         ; 1EDF3:  00
b07_adf4:   cpx $c0e0                   ; 1EDF4:  ec e0 c0
b07_adf7:   cpy #$92                    ; 1EDF7:  c0 92
b07_adf9:   dec $e6ce                   ; 1EDF9:  ce ce e6
b07_adfc:   bpl $ae0e                   ; 1EDFC:  10 10
b07_adfe:   .db $07                     ; 1EDFE:  07
b07_adff:   brk                         ; 1EDFF:  00
b07_ae00:   .db $12                     ; 1EE00:  12
b07_ae01:   ora ($11),y                 ; 1EE01:  11 11
b07_ae03:   ora #$11                    ; 1EE03:  09 11
b07_ae05:   php                         ; 1EE05:  08
b07_ae06:   .db $04                     ; 1EE06:  04
b07_ae07:   jsr $0810                   ; 1EE07:  20 10 08
b07_ae0a:   .db $44                     ; 1EE0A:  44
b07_ae0b:   .db $22                     ; 1EE0B:  22
b07_ae0c:   .db $37                     ; 1EE0C:  37
b07_ae0d:   rol a                       ; 1EE0D:  2a
b07_ae0e:   eor $772b,x                 ; 1EE0E:  5d 2b 77
b07_ae11:   .db $3a                     ; 1EE11:  3a
b07_ae12:   eor $e62e,x                 ; 1EE12:  5d 2e e6
b07_ae15:   inc $f2                     ; 1EE15:  e6 f2
b07_ae17:   beq $ae89                   ; 1EE17:  f0 70
b07_ae19:   brk                         ; 1EE19:  00
b07_ae1a:   brk                         ; 1EE1A:  00
b07_ae1b:   .db $80                     ; 1EE1B:  80
b07_ae1c:   ora #$09                    ; 1EE1C:  09 09
b07_ae1e:   ora $07                     ; 1EE1E:  05 07
b07_ae20:   .db $07                     ; 1EE20:  07
b07_ae21:   .db $8f                     ; 1EE21:  8f
b07_ae22:   ldx $110e                   ; 1EE22:  ae 0e 11
b07_ae25:   php                         ; 1EE25:  08
b07_ae26:   .db $04                     ; 1EE26:  04
b07_ae27:   jsr $0810                   ; 1EE27:  20 10 08
b07_ae2a:   .db $44                     ; 1EE2A:  44
b07_ae2b:   .db $22                     ; 1EE2B:  22
b07_ae2c:   .db $77                     ; 1EE2C:  77
b07_ae2d:   ror a                       ; 1EE2D:  6a
b07_ae2e:   eor $772b,x                 ; 1EE2E:  5d 2b 77
b07_ae31:   .db $3a                     ; 1EE31:  3a
b07_ae32:   cmp $10ae,x                 ; 1EE32:  dd ae 10
b07_ae35:   php                         ; 1EE35:  08
b07_ae36:   ora ($21,x)                 ; 1EE36:  01 21
b07_ae38:   .db $13                     ; 1EE38:  13
b07_ae39:   .db $8b                     ; 1EE39:  8b
b07_ae3a:   .db $4b                     ; 1EE3A:  4b
b07_ae3b:   ora $e971,x                 ; 1EE3B:  1d 71 e9
b07_ae3e:   cld                         ; 1EE3E:  d8
b07_ae3f:   tay                         ; 1EE3F:  a8
b07_ae40:   .db $72                     ; 1EE40:  72
b07_ae41:   tax                         ; 1EE41:  aa
b07_ae42:   .db $c3                     ; 1EE42:  c3
b07_ae43:   .db $89                     ; 1EE43:  89
b07_ae44:   ora ($08),y                 ; 1EE44:  11 08
b07_ae46:   .db $02                     ; 1EE46:  02
b07_ae47:   .db $ff                     ; 1EE47:  ff
b07_ae48:   tax                         ; 1EE48:  aa
b07_ae49:   .db $ff                     ; 1EE49:  ff
b07_ae4a:   tax                         ; 1EE4A:  aa
b07_ae4b:   .db $ff                     ; 1EE4B:  ff
b07_ae4c:   .db $77                     ; 1EE4C:  77
b07_ae4d:   inx                         ; 1EE4D:  e8
b07_ae4e:   ora $aa                     ; 1EE4E:  05 aa
b07_ae50:   eor $aa,x                   ; 1EE50:  55 aa
b07_ae52:   eor $aa,x                   ; 1EE52:  55 aa
b07_ae54:   and #$3e                    ; 1EE54:  29 3e
b07_ae56:   tax                         ; 1EE56:  aa
b07_ae57:   .db $bf                     ; 1EE57:  bf
b07_ae58:   txa                         ; 1EE58:  8a
b07_ae59:   .db $df                     ; 1EE59:  df
b07_ae5a:   txa                         ; 1EE5A:  8a
b07_ae5b:   .db $ef                     ; 1EE5B:  ef
b07_ae5c:   ora $2a,x                   ; 1EE5C:  15 2a
b07_ae5e:   .db $14                     ; 1EE5E:  14
b07_ae5f:   tax                         ; 1EE5F:  aa
b07_ae60:   eor $8a,x                   ; 1EE60:  55 8a
b07_ae62:   eor $aa,x                   ; 1EE62:  55 aa
b07_ae64:   .db $7f                     ; 1EE64:  7f
b07_ae65:   .db $3f                     ; 1EE65:  3f
b07_ae66:   .db $3f                     ; 1EE66:  3f
b07_ae67:   .db $9f                     ; 1EE67:  9f
b07_ae68:   .db $ff                     ; 1EE68:  ff
b07_ae69:   .db $ef                     ; 1EE69:  ef
b07_ae6a:   .db $f3                     ; 1EE6A:  f3
b07_ae6b:   sed                         ; 1EE6B:  f8
b07_ae6c:   brk                         ; 1EE6C:  00
b07_ae6d:   .db $80                     ; 1EE6D:  80
b07_ae6e:   .db $80                     ; 1EE6E:  80
b07_ae6f:   rti                         ; 1EE6F:  40
b07_ae70:   brk                         ; 1EE70:  00
b07_ae71:   brk                         ; 1EE71:  00
b07_ae72:   brk                         ; 1EE72:  00
b07_ae73:   .db $04                     ; 1EE73:  04
b07_ae74:   brk                         ; 1EE74:  00
b07_ae75:   .db $c3                     ; 1EE75:  c3
b07_ae76:   .db $cf                     ; 1EE76:  cf
b07_ae77:   .db $fc                     ; 1EE77:  fc
b07_ae78:   .db $fc                     ; 1EE78:  fc
b07_ae79:   .db $ff                     ; 1EE79:  ff
b07_ae7a:   .db $ff                     ; 1EE7A:  ff
b07_ae7b:   .db $ff                     ; 1EE7B:  ff
b07_ae7c:   brk                         ; 1EE7C:  00
b07_ae7d:   jsr $0020                   ; 1EE7D:  20 20 00
b07_ae80:   .db $02                     ; 1EE80:  02
b07_ae81:   brk                         ; 1EE81:  00
b07_ae82:   brk                         ; 1EE82:  00
b07_ae83:   brk                         ; 1EE83:  00
b07_ae84:   .db $fc                     ; 1EE84:  fc
b07_ae85:   .db $ff                     ; 1EE85:  ff
b07_ae86:   .db $ff                     ; 1EE86:  ff
b07_ae87:   .db $7f                     ; 1EE87:  7f
b07_ae88:   .db $7f                     ; 1EE88:  7f
b07_ae89:   .db $bf                     ; 1EE89:  bf
b07_ae8a:   .db $9f                     ; 1EE8A:  9f
b07_ae8b:   .db $ef                     ; 1EE8B:  ef
b07_ae8c:   .db $82                     ; 1EE8C:  82
b07_ae8d:   cpy #$c0                    ; 1EE8D:  c0 c0
b07_ae8f:   rts                         ; 1EE8F:  60
b07_ae90:   bvs $ae4a                   ; 1EE90:  70 b8
b07_ae92:   .db $5c                     ; 1EE92:  5c
b07_ae93:   ldx $073f                   ; 1EE93:  ae 3f 07
b07_ae96:   .db $80                     ; 1EE96:  80
b07_ae97:   cpx #$f8                    ; 1EE97:  e0 f8
b07_ae99:   inc $fcfe,x                 ; 1EE99:  fe fe fc
b07_ae9c:   brk                         ; 1EE9C:  00
b07_ae9d:   .db $80                     ; 1EE9D:  80
b07_ae9e:   rts                         ; 1EE9E:  60
b07_ae9f:   clc                         ; 1EE9F:  18
b07_aea0:   .db $07                     ; 1EEA0:  07
b07_aea1:   ora ($01,x)                 ; 1EEA1:  01 01
b07_aea3:   .db $03                     ; 1EEA3:  03
b07_aea4:   brk                         ; 1EEA4:  00
b07_aea5:   cpx #$e0                    ; 1EEA5:  e0 e0
b07_aea7:   brk                         ; 1EEA7:  00
b07_aea8:   brk                         ; 1EEA8:  00
b07_aea9:   brk                         ; 1EEA9:  00
b07_aeaa:   cpy $c2                     ; 1EEAA:  c4 c2
b07_aeac:   stx $02                     ; 1EEAC:  86 02
b07_aeae:   ora $bb3d                   ; 1EEAE:  0d 3d bb
b07_aeb1:   .db $fa                     ; 1EEB1:  fa
b07_aeb2:   and $36,x                   ; 1EEB2:  35 36
b07_aeb4:   cmp ($c8,x)                 ; 1EEB4:  c1 c8
b07_aeb6:   bit $00                     ; 1EEB6:  24 00
b07_aeb8:   .db $22                     ; 1EEB8:  22
b07_aeb9:   .db $17                     ; 1EEB9:  17
b07_aeba:   lsr a                       ; 1EEBA:  4a
b07_aebb:   .db $5b                     ; 1EEBB:  5b
b07_aebc:   .db $27                     ; 1EEBC:  27
b07_aebd:   asl a                       ; 1EEBD:  0a
b07_aebe:   ora $00                     ; 1EEBE:  05 00
b07_aec0:   ldy #$82                    ; 1EEC0:  a0 82
b07_aec2:   rti                         ; 1EEC2:  40
b07_aec3:   lsr a                       ; 1EEC3:  4a
b07_aec4:   ora ($08),y                 ; 1EEC4:  11 08
b07_aec6:   .db $04                     ; 1EEC6:  04
b07_aec7:   jsr $fc80                   ; 1EEC7:  20 80 fc
b07_aeca:   tax                         ; 1EECA:  aa
b07_aecb:   .db $ff                     ; 1EECB:  ff
b07_aecc:   .db $77                     ; 1EECC:  77
b07_aecd:   nop                         ; 1EECD:  ea
b07_aece:   cmp $032b,x                 ; 1EECE:  dd 2b 03
b07_aed1:   tay                         ; 1EED1:  a8
b07_aed2:   ora $aa,x                   ; 1EED2:  15 aa
b07_aed4:   .db $44                     ; 1EED4:  44
b07_aed5:   ora ($44),y                 ; 1EED5:  11 44
b07_aed7:   ora ($44),y                 ; 1EED7:  11 44
b07_aed9:   ora ($44),y                 ; 1EED9:  11 44
b07_aedb:   ora ($88),y                 ; 1EEDB:  11 88
b07_aedd:   .db $22                     ; 1EEDD:  22
b07_aede:   dey                         ; 1EEDE:  88
b07_aedf:   .db $22                     ; 1EEDF:  22
b07_aee0:   dey                         ; 1EEE0:  88
b07_aee1:   .db $22                     ; 1EEE1:  22
b07_aee2:   dey                         ; 1EEE2:  88
b07_aee3:   .db $22                     ; 1EEE3:  22
b07_aee4:   .db $44                     ; 1EEE4:  44
b07_aee5:   ora ($44),y                 ; 1EEE5:  11 44
b07_aee7:   bpl $af2d                   ; 1EEE7:  10 44
b07_aee9:   bpl $af2b                   ; 1EEE9:  10 40
b07_aeeb:   bpl $ae75                   ; 1EEEB:  10 88
b07_aeed:   .db $22                     ; 1EEED:  22
b07_aeee:   dey                         ; 1EEEE:  88
b07_aeef:   .db $22                     ; 1EEEF:  22
b07_aef0:   dey                         ; 1EEF0:  88
b07_aef1:   jsr $2088                   ; 1EEF1:  20 88 20
b07_aef4:   rti                         ; 1EEF4:  40
b07_aef5:   bpl $af38                   ; 1EEF5:  10 41
b07_aef7:   ora ($43),y                 ; 1EEF7:  11 43
b07_aef9:   .db $13                     ; 1EEF9:  13
b07_aefa:   .db $43                     ; 1EEFA:  43
b07_aefb:   ora ($88),y                 ; 1EEFB:  11 88
b07_aefd:   jsr $2080                   ; 1EEFD:  20 80 20
b07_af00:   .db $80                     ; 1EF00:  80
b07_af01:   jsr $2080                   ; 1EF01:  20 80 20
b07_af04:   rti                         ; 1EF04:  40
b07_af05:   brk                         ; 1EF05:  00
b07_af06:   brk                         ; 1EF06:  00
b07_af07:   brk                         ; 1EF07:  00
b07_af08:   bpl $af0a                   ; 1EF08:  10 00
b07_af0a:   clc                         ; 1EF0A:  18
b07_af0b:   rti                         ; 1EF0B:  40
b07_af0c:   dey                         ; 1EF0C:  88
b07_af0d:   brk                         ; 1EF0D:  00
b07_af0e:   brk                         ; 1EF0E:  00
b07_af0f:   brk                         ; 1EF0F:  00
b07_af10:   bpl $af12                   ; 1EF10:  10 00
b07_af12:   clc                         ; 1EF12:  18
b07_af13:   brk                         ; 1EF13:  00
b07_af14:   brk                         ; 1EF14:  00
b07_af15:   brk                         ; 1EF15:  00
b07_af16:   brk                         ; 1EF16:  00
b07_af17:   brk                         ; 1EF17:  00
b07_af18:   brk                         ; 1EF18:  00
b07_af19:   brk                         ; 1EF19:  00
b07_af1a:   brk                         ; 1EF1A:  00
b07_af1b:   brk                         ; 1EF1B:  00
b07_af1c:   brk                         ; 1EF1C:  00
b07_af1d:   brk                         ; 1EF1D:  00
b07_af1e:   brk                         ; 1EF1E:  00
b07_af1f:   brk                         ; 1EF1F:  00
b07_af20:   brk                         ; 1EF20:  00
b07_af21:   brk                         ; 1EF21:  00
b07_af22:   brk                         ; 1EF22:  00
b07_af23:   ora ($d1,x)                 ; 1EF23:  01 d1
b07_af25:   nop                         ; 1EF25:  ea
b07_af26:   .db $ff                     ; 1EF26:  ff
b07_af27:   .db $ff                     ; 1EF27:  ff
b07_af28:   .db $ff                     ; 1EF28:  ff
b07_af29:   .db $ff                     ; 1EF29:  ff
b07_af2a:   .db $ff                     ; 1EF2A:  ff
b07_af2b:   .db $ff                     ; 1EF2B:  ff
b07_af2c:   brk                         ; 1EF2C:  00
b07_af2d:   brk                         ; 1EF2D:  00
b07_af2e:   brk                         ; 1EF2E:  00
b07_af2f:   brk                         ; 1EF2F:  00
b07_af30:   brk                         ; 1EF30:  00
b07_af31:   brk                         ; 1EF31:  00
b07_af32:   brk                         ; 1EF32:  00
b07_af33:   brk                         ; 1EF33:  00
b07_af34:   jsr $feae                   ; 1EF34:  20 ae fe
b07_af37:   inc $fefe,x                 ; 1EF37:  fe fe fe
b07_af3a:   inc $03ff,x                 ; 1EF3A:  fe ff 03
b07_af3d:   ora ($01,x)                 ; 1EF3D:  01 01
b07_af3f:   ora ($01,x)                 ; 1EF3F:  01 01
b07_af41:   ora ($01,x)                 ; 1EF41:  01 01
b07_af43:   brk                         ; 1EF43:  00
b07_af44:   .db $04                     ; 1EF44:  04
b07_af45:   and ($14,x)                 ; 1EF45:  21 14
b07_af47:   ora ($04,x)                 ; 1EF47:  01 04
b07_af49:   ora ($00,x)                 ; 1EF49:  01 00
b07_af4b:   ora ($88,x)                 ; 1EF4B:  01 88
b07_af4d:   .db $22                     ; 1EF4D:  22
b07_af4e:   bpl $af52                   ; 1EF4E:  10 02
b07_af50:   brk                         ; 1EF50:  00
b07_af51:   .db $02                     ; 1EF51:  02
b07_af52:   brk                         ; 1EF52:  00
b07_af53:   brk                         ; 1EF53:  00
b07_af54:   brk                         ; 1EF54:  00
b07_af55:   brk                         ; 1EF55:  00
b07_af56:   brk                         ; 1EF56:  00
b07_af57:   brk                         ; 1EF57:  00
b07_af58:   brk                         ; 1EF58:  00
b07_af59:   brk                         ; 1EF59:  00
b07_af5a:   brk                         ; 1EF5A:  00
b07_af5b:   brk                         ; 1EF5B:  00
b07_af5c:   .db $80                     ; 1EF5C:  80
b07_af5d:   cpy #$e0                    ; 1EF5D:  c0 e0
b07_af5f:   beq $af51                   ; 1EF5F:  f0 f0
b07_af61:   beq $af43                   ; 1EF61:  f0 e0
b07_af63:   cpy #$43                    ; 1EF63:  c0 43
b07_af65:   .db $12                     ; 1EF65:  12
b07_af66:   .db $43                     ; 1EF66:  43
b07_af67:   .db $03                     ; 1EF67:  03
b07_af68:   .db $4b                     ; 1EF68:  4b
b07_af69:   .db $0f                     ; 1EF69:  0f
b07_af6a:   .db $4b                     ; 1EF6A:  4b
b07_af6b:   .db $0b                     ; 1EF6B:  0b
b07_af6c:   .db $80                     ; 1EF6C:  80
b07_af6d:   jsr $2080                   ; 1EF6D:  20 80 20
b07_af70:   .db $80                     ; 1EF70:  80
b07_af71:   jsr $2080                   ; 1EF71:  20 80 20
b07_af74:   .db $4b                     ; 1EF74:  4b
b07_af75:   .db $0b                     ; 1EF75:  0b
b07_af76:   .db $47                     ; 1EF76:  47
b07_af77:   .db $13                     ; 1EF77:  13
b07_af78:   .db $47                     ; 1EF78:  47
b07_af79:   .db $13                     ; 1EF79:  13
b07_af7a:   eor $11                     ; 1EF7A:  45 11
b07_af7c:   sty $20                     ; 1EF7C:  84 20
b07_af7e:   .db $80                     ; 1EF7E:  80
b07_af7f:   jsr $2088                   ; 1EF7F:  20 88 20
b07_af82:   dey                         ; 1EF82:  88
b07_af83:   .db $22                     ; 1EF83:  22
b07_af84:   .db $ff                     ; 1EF84:  ff
b07_af85:   .db $8f                     ; 1EF85:  8f
b07_af86:   .db $e7                     ; 1EF86:  e7
b07_af87:   adc ($f9),y                 ; 1EF87:  71 f9
b07_af89:   brk                         ; 1EF89:  00
b07_af8a:   .db $f3                     ; 1EF8A:  f3
b07_af8b:   .db $f2                     ; 1EF8B:  f2
b07_af8c:   brk                         ; 1EF8C:  00
b07_af8d:   brk                         ; 1EF8D:  00
b07_af8e:   brk                         ; 1EF8E:  00
b07_af8f:   brk                         ; 1EF8F:  00
b07_af90:   .db $04                     ; 1EF90:  04
b07_af91:   asl $08                     ; 1EF91:  06 08
b07_af93:   php                         ; 1EF93:  08
b07_af94:   .db $ff                     ; 1EF94:  ff
b07_af95:   sed                         ; 1EF95:  f8
b07_af96:   cpx #$c4                    ; 1EF96:  e0 c4
b07_af98:   .db $df                     ; 1EF98:  df
b07_af99:   bcc $af22                   ; 1EF99:  90 87
b07_af9b:   .db $8f                     ; 1EF9B:  8f
b07_af9c:   brk                         ; 1EF9C:  00
b07_af9d:   brk                         ; 1EF9D:  00
b07_af9e:   .db $03                     ; 1EF9E:  03
b07_af9f:   .db $1b                     ; 1EF9F:  1b
b07_afa0:   jsr $6060                   ; 1EFA0:  20 60 60
b07_afa3:   bvs $af8c                   ; 1EFA3:  70 e7
b07_afa5:   .db $ff                     ; 1EFA5:  ff
b07_afa6:   .db $ff                     ; 1EFA6:  ff
b07_afa7:   sbc $f9fb,x                 ; 1EFA7:  fd fb f9
b07_afaa:   .db $f4                     ; 1EFAA:  f4
b07_afab:   .db $e7                     ; 1EFAB:  e7
b07_afac:   bpl $afae                   ; 1EFAC:  10 00
b07_afae:   brk                         ; 1EFAE:  00
b07_afaf:   brk                         ; 1EFAF:  00
b07_afb0:   brk                         ; 1EFB0:  00
b07_afb1:   brk                         ; 1EFB1:  00
b07_afb2:   .db $02                     ; 1EFB2:  02
b07_afb3:   php                         ; 1EFB3:  08
b07_afb4:   bcc $af53                   ; 1EFB4:  90 9d
b07_afb6:   .db $8f                     ; 1EFB6:  8f
b07_afb7:   .db $a7                     ; 1EFB7:  a7
b07_afb8:   bcs $af3a                   ; 1EFB8:  b0 80
b07_afba:   brk                         ; 1EFBA:  00
b07_afbb:   brk                         ; 1EFBB:  00
b07_afbc:   .db $67                     ; 1EFBC:  67
b07_afbd:   .db $62                     ; 1EFBD:  62
b07_afbe:   bvs $b008                   ; 1EFBE:  70 48
b07_afc0:   .db $4f                     ; 1EFC0:  4f
b07_afc1:   .db $47                     ; 1EFC1:  47
b07_afc2:   .db $3b                     ; 1EFC2:  3b
b07_afc3:   .db $ff                     ; 1EFC3:  ff
b07_afc4:   brk                         ; 1EFC4:  00
b07_afc5:   brk                         ; 1EFC5:  00
b07_afc6:   brk                         ; 1EFC6:  00
b07_afc7:   brk                         ; 1EFC7:  00
b07_afc8:   .db $07                     ; 1EFC8:  07
b07_afc9:   ora #$80                    ; 1EFC9:  09 80
b07_afcb:   brk                         ; 1EFCB:  00
b07_afcc:   cpx #$a0                    ; 1EFCC:  e0 a0
b07_afce:   cpx #$e0                    ; 1EFCE:  e0 e0
b07_afd0:   cpx #$60                    ; 1EFD0:  e0 60
b07_afd2:   adc $e3,x                   ; 1EFD2:  75 e3
b07_afd4:   .db $44                     ; 1EFD4:  44
b07_afd5:   ora ($44),y                 ; 1EFD5:  11 44
b07_afd7:   ora ($44),y                 ; 1EFD7:  11 44
b07_afd9:   ora ($44),y                 ; 1EFD9:  11 44
b07_afdb:   ora ($88),y                 ; 1EFDB:  11 88
b07_afdd:   .db $22                     ; 1EFDD:  22
b07_afde:   dey                         ; 1EFDE:  88
b07_afdf:   .db $22                     ; 1EFDF:  22
b07_afe0:   php                         ; 1EFE0:  08
b07_afe1:   .db $22                     ; 1EFE1:  22
b07_afe2:   php                         ; 1EFE2:  08
b07_afe3:   .db $22                     ; 1EFE3:  22
b07_afe4:   .db $80                     ; 1EFE4:  80
b07_afe5:   .db $80                     ; 1EFE5:  80
b07_afe6:   .db $80                     ; 1EFE6:  80
b07_afe7:   ora ($00,x)                 ; 1EFE7:  01 00
b07_afe9:   ora ($04,x)                 ; 1EFE9:  01 04
b07_afeb:   ora ($76,x)                 ; 1EFEB:  01 76
b07_afed:   ror $6c                     ; 1EFED:  66 6c
b07_afef:   .db $fa                     ; 1EFEF:  fa
b07_aff0:   cpx #$e2                    ; 1EFF0:  e0 e2
b07_aff2:   cpx #$e2                    ; 1EFF2:  e0 e2
b07_aff4:   .db $44                     ; 1EFF4:  44
b07_aff5:   ora ($44),y                 ; 1EFF5:  11 44
b07_aff7:   ora ($44),y                 ; 1EFF7:  11 44
b07_aff9:   ora ($44),y                 ; 1EFF9:  11 44
b07_affb:   brk                         ; 1EFFB:  00
b07_affc:   dey                         ; 1EFFC:  88
b07_affd:   .db $22                     ; 1EFFD:  22
b07_affe:   dey                         ; 1EFFE:  88
b07_afff:   .db $22                     ; 1EFFF:  22
b07_b000:   dey                         ; 1F000:  88
b07_b001:   .db $22                     ; 1F001:  22
b07_b002:   dey                         ; 1F002:  88
b07_b003:   ora ($45,x)                 ; 1F003:  01 45
b07_b005:   ora ($44),y                 ; 1F005:  11 44
b07_b007:   ora ($44),y                 ; 1F007:  11 44
b07_b009:   bpl $b00b                   ; 1F009:  10 00
b07_b00b:   brk                         ; 1F00B:  00
b07_b00c:   dey                         ; 1F00C:  88
b07_b00d:   .db $22                     ; 1F00D:  22
b07_b00e:   dey                         ; 1F00E:  88
b07_b00f:   .db $22                     ; 1F00F:  22
b07_b010:   dey                         ; 1F010:  88
b07_b011:   jsr $7505                   ; 1F011:  20 05 75
b07_b014:   brk                         ; 1F014:  00
b07_b015:   brk                         ; 1F015:  00
b07_b016:   brk                         ; 1F016:  00
b07_b017:   brk                         ; 1F017:  00
b07_b018:   brk                         ; 1F018:  00
b07_b019:   brk                         ; 1F019:  00
b07_b01a:   brk                         ; 1F01A:  00
b07_b01b:   brk                         ; 1F01B:  00
b07_b01c:   eor $dd77,x                 ; 1F01C:  5d 77 dd
b07_b01f:   .db $57                     ; 1F01F:  57
b07_b020:   cmp $9d57,x                 ; 1F020:  dd 57 9d
b07_b023:   .db $17                     ; 1F023:  17
b07_b024:   brk                         ; 1F024:  00
b07_b025:   brk                         ; 1F025:  00
b07_b026:   brk                         ; 1F026:  00
b07_b027:   brk                         ; 1F027:  00
b07_b028:   brk                         ; 1F028:  00
b07_b029:   brk                         ; 1F029:  00
b07_b02a:   brk                         ; 1F02A:  00
b07_b02b:   brk                         ; 1F02B:  00
b07_b02c:   cmp $d973,x                 ; 1F02C:  dd 73 d9
b07_b02f:   .db $73                     ; 1F02F:  73
b07_b030:   cmp $77,x                   ; 1F030:  d5 77
b07_b032:   cmp $77,x                   ; 1F032:  d5 77
b07_b034:   .db $ef                     ; 1F034:  ef
b07_b035:   cpx #$ef                    ; 1F035:  e0 ef
b07_b037:   .db $fc                     ; 1F037:  fc
b07_b038:   ror $1f3f,x                 ; 1F038:  7e 3f 1f
b07_b03b:   .db $0f                     ; 1F03B:  0f
b07_b03c:   bpl $b03e                   ; 1F03C:  10 00
b07_b03e:   brk                         ; 1F03E:  00
b07_b03f:   brk                         ; 1F03F:  00
b07_b040:   brk                         ; 1F040:  00
b07_b041:   brk                         ; 1F041:  00
b07_b042:   .db $80                     ; 1F042:  80
b07_b043:   brk                         ; 1F043:  00
b07_b044:   beq $afc6                   ; 1F044:  f0 80
b07_b046:   beq $b048                   ; 1F046:  f0 00
b07_b048:   brk                         ; 1F048:  00
b07_b049:   .db $80                     ; 1F049:  80
b07_b04a:   cpx #$e0                    ; 1F04A:  e0 e0
b07_b04c:   ora $0d01                   ; 1F04C:  0d 01 0d
b07_b04f:   .db $1f                     ; 1F04F:  1f
b07_b050:   .db $bf                     ; 1F050:  bf
b07_b051:   .db $7f                     ; 1F051:  7f
b07_b052:   asl $271c,x                 ; 1F052:  1e 1c 27
b07_b055:   .db $23                     ; 1F055:  23
b07_b056:   pla                         ; 1F056:  68
b07_b057:   bit $1776                   ; 1F057:  2c 76 17
b07_b05a:   .db $7b                     ; 1F05A:  7b
b07_b05b:   .db $1b                     ; 1F05B:  1b
b07_b05c:   ldy #$20                    ; 1F05C:  a0 20
b07_b05e:   bit $62                     ; 1F05E:  24 62
b07_b060:   and ($50),y                 ; 1F060:  31 50
b07_b062:   clc                         ; 1F062:  18
b07_b063:   pha                         ; 1F063:  48
b07_b064:   cpx #$e0                    ; 1F064:  e0 e0
b07_b066:   ora ($01,x)                 ; 1F066:  01 01
b07_b068:   .db $03                     ; 1F068:  03
b07_b069:   .db $03                     ; 1F069:  03
b07_b06a:   stx $fd                     ; 1F06A:  86 fd
b07_b06c:   clc                         ; 1F06C:  18
b07_b06d:   ora ($03,x)                 ; 1F06D:  01 03
b07_b06f:   .db $07                     ; 1F06F:  07
b07_b070:   .db $ff                     ; 1F070:  ff
b07_b071:   inc $047f,x                 ; 1F071:  fe 7f 04
b07_b074:   .db $04                     ; 1F074:  04
b07_b075:   ora ($00,x)                 ; 1F075:  01 00
b07_b077:   ora ($20,x)                 ; 1F077:  01 20
b07_b079:   jsr $4060                   ; 1F079:  20 60 40
b07_b07c:   cpy #$c2                    ; 1F07C:  c0 c2
b07_b07e:   iny                         ; 1F07E:  c8
b07_b07f:   cpy #$ac                    ; 1F07F:  c0 ac
b07_b081:   .db $22                     ; 1F081:  22
b07_b082:   jmp ($4442)                 ; 1F082:  6c 42 44
b07_b085:   ora ($44),y                 ; 1F085:  11 44
b07_b087:   ora ($44),y                 ; 1F087:  11 44
b07_b089:   ora ($00),y                 ; 1F089:  11 00
b07_b08b:   brk                         ; 1F08B:  00
b07_b08c:   dey                         ; 1F08C:  88
b07_b08d:   .db $22                     ; 1F08D:  22
b07_b08e:   dey                         ; 1F08E:  88
b07_b08f:   .db $22                     ; 1F08F:  22
b07_b090:   dey                         ; 1F090:  88
b07_b091:   .db $02                     ; 1F091:  02
b07_b092:   cpy #$33                    ; 1F092:  c0 33
b07_b094:   cpx #$80                    ; 1F094:  e0 80
b07_b096:   cpy #$80                    ; 1F096:  c0 80
b07_b098:   rti                         ; 1F098:  40
b07_b099:   .db $80                     ; 1F099:  80
b07_b09a:   rti                         ; 1F09A:  40
b07_b09b:   .db $80                     ; 1F09B:  80
b07_b09c:   cpy $9cc3                   ; 1F09C:  cc c3 9c
b07_b09f:   .db $57                     ; 1F09F:  57
b07_b0a0:   .db $1c                     ; 1F0A0:  1c
b07_b0a1:   .db $57                     ; 1F0A1:  57
b07_b0a2:   .db $1c                     ; 1F0A2:  1c
b07_b0a3:   .db $57                     ; 1F0A3:  57
b07_b0a4:   brk                         ; 1F0A4:  00
b07_b0a5:   brk                         ; 1F0A5:  00
b07_b0a6:   brk                         ; 1F0A6:  00
b07_b0a7:   brk                         ; 1F0A7:  00
b07_b0a8:   brk                         ; 1F0A8:  00
b07_b0a9:   brk                         ; 1F0A9:  00
b07_b0aa:   brk                         ; 1F0AA:  00
b07_b0ab:   brk                         ; 1F0AB:  00
b07_b0ac:   eor $4d37                   ; 1F0AC:  4d 37 4d
b07_b0af:   .db $37                     ; 1F0AF:  37
b07_b0b0:   eor $5d37,x                 ; 1F0B0:  5d 37 5d
b07_b0b3:   .db $77                     ; 1F0B3:  77
b07_b0b4:   eor $00,x                   ; 1F0B4:  55 00
b07_b0b6:   eor $00,x                   ; 1F0B6:  55 00
b07_b0b8:   eor $00,x                   ; 1F0B8:  55 00
b07_b0ba:   eor $00,x                   ; 1F0BA:  55 00
b07_b0bc:   tax                         ; 1F0BC:  aa
b07_b0bd:   brk                         ; 1F0BD:  00
b07_b0be:   tax                         ; 1F0BE:  aa
b07_b0bf:   brk                         ; 1F0BF:  00
b07_b0c0:   tax                         ; 1F0C0:  aa
b07_b0c1:   brk                         ; 1F0C1:  00
b07_b0c2:   tax                         ; 1F0C2:  aa
b07_b0c3:   brk                         ; 1F0C3:  00
b07_b0c4:   eor $00,x                   ; 1F0C4:  55 00
b07_b0c6:   eor $00,x                   ; 1F0C6:  55 00
b07_b0c8:   .db $54                     ; 1F0C8:  54
b07_b0c9:   brk                         ; 1F0C9:  00
b07_b0ca:   bvc $b0cd                   ; 1F0CA:  50 01
b07_b0cc:   tax                         ; 1F0CC:  aa
b07_b0cd:   brk                         ; 1F0CD:  00
b07_b0ce:   tax                         ; 1F0CE:  aa
b07_b0cf:   brk                         ; 1F0CF:  00
b07_b0d0:   tax                         ; 1F0D0:  aa
b07_b0d1:   ora ($ab,x)                 ; 1F0D1:  01 ab
b07_b0d3:   asl $41                     ; 1F0D3:  06 41
b07_b0d5:   .db $03                     ; 1F0D5:  03
b07_b0d6:   .db $43                     ; 1F0D6:  43
b07_b0d7:   .db $03                     ; 1F0D7:  03
b07_b0d8:   .db $43                     ; 1F0D8:  43
b07_b0d9:   .db $03                     ; 1F0D9:  03
b07_b0da:   .db $43                     ; 1F0DA:  43
b07_b0db:   .db $07                     ; 1F0DB:  07
b07_b0dc:   ldx $0c                     ; 1F0DC:  a6 0c
b07_b0de:   sty $8c0c                   ; 1F0DE:  8c 0c 8c
b07_b0e1:   .db $1c                     ; 1F0E1:  1c
b07_b0e2:   .db $9c                     ; 1F0E2:  9c
b07_b0e3:   clc                         ; 1F0E3:  18
b07_b0e4:   eor $03,x                   ; 1F0E4:  55 03
b07_b0e6:   .db $07                     ; 1F0E6:  07
b07_b0e7:   .db $1f                     ; 1F0E7:  1f
b07_b0e8:   .db $3f                     ; 1F0E8:  3f
b07_b0e9:   .db $7f                     ; 1F0E9:  7f
b07_b0ea:   .db $ff                     ; 1F0EA:  ff
b07_b0eb:   .db $ff                     ; 1F0EB:  ff
b07_b0ec:   tax                         ; 1F0EC:  aa
b07_b0ed:   brk                         ; 1F0ED:  00
b07_b0ee:   tya                         ; 1F0EE:  98
b07_b0ef:   rts                         ; 1F0EF:  60
b07_b0f0:   cpy #$80                    ; 1F0F0:  c0 80
b07_b0f2:   brk                         ; 1F0F2:  00
b07_b0f3:   brk                         ; 1F0F3:  00
b07_b0f4:   eor $ff,x                   ; 1F0F4:  55 ff
b07_b0f6:   .db $ff                     ; 1F0F6:  ff
b07_b0f7:   .db $ff                     ; 1F0F7:  ff
b07_b0f8:   .db $ff                     ; 1F0F8:  ff
b07_b0f9:   .db $ff                     ; 1F0F9:  ff
b07_b0fa:   .db $ff                     ; 1F0FA:  ff
b07_b0fb:   .db $ff                     ; 1F0FB:  ff
b07_b0fc:   tax                         ; 1F0FC:  aa
b07_b0fd:   brk                         ; 1F0FD:  00
b07_b0fe:   brk                         ; 1F0FE:  00
b07_b0ff:   brk                         ; 1F0FF:  00
b07_b100:   brk                         ; 1F100:  00
b07_b101:   brk                         ; 1F101:  00
b07_b102:   brk                         ; 1F102:  00
b07_b103:   brk                         ; 1F103:  00
b07_b104:   .db $ff                     ; 1F104:  ff
b07_b105:   .db $ff                     ; 1F105:  ff
b07_b106:   .db $ff                     ; 1F106:  ff
b07_b107:   .db $ff                     ; 1F107:  ff
b07_b108:   .db $ff                     ; 1F108:  ff
b07_b109:   .db $ff                     ; 1F109:  ff
b07_b10a:   .db $ff                     ; 1F10A:  ff
b07_b10b:   .db $ff                     ; 1F10B:  ff
b07_b10c:   brk                         ; 1F10C:  00
b07_b10d:   brk                         ; 1F10D:  00
b07_b10e:   brk                         ; 1F10E:  00
b07_b10f:   brk                         ; 1F10F:  00
b07_b110:   brk                         ; 1F110:  00
b07_b111:   brk                         ; 1F111:  00
b07_b112:   brk                         ; 1F112:  00
b07_b113:   brk                         ; 1F113:  00
b07_b114:   ora ($00,x)                 ; 1F114:  01 00
b07_b116:   cpx #$f0                    ; 1F116:  e0 f0
b07_b118:   sbc $fefc,y                 ; 1F118:  f9 fc fe
b07_b11b:   inc $0080,x                 ; 1F11B:  fe 80 00
b07_b11e:   .db $04                     ; 1F11E:  04
b07_b11f:   brk                         ; 1F11F:  00
b07_b120:   brk                         ; 1F120:  00
b07_b121:   brk                         ; 1F121:  00
b07_b122:   brk                         ; 1F122:  00
b07_b123:   brk                         ; 1F123:  00
b07_b124:   inc $fefe,x                 ; 1F124:  fe fe fe
b07_b127:   .db $fc                     ; 1F127:  fc
b07_b128:   .db $fc                     ; 1F128:  fc
b07_b129:   sed                         ; 1F129:  f8
b07_b12a:   beq $b10c                   ; 1F12A:  f0 e0
b07_b12c:   brk                         ; 1F12C:  00
b07_b12d:   brk                         ; 1F12D:  00
b07_b12e:   brk                         ; 1F12E:  00
b07_b12f:   brk                         ; 1F12F:  00
b07_b130:   brk                         ; 1F130:  00
b07_b131:   brk                         ; 1F131:  00
b07_b132:   brk                         ; 1F132:  00
b07_b133:   brk                         ; 1F133:  00
b07_b134:   eor $00,x                   ; 1F134:  55 00
b07_b136:   ora $00,x                   ; 1F136:  15 00
b07_b138:   ora $00,x                   ; 1F138:  15 00
b07_b13a:   eor $00,x                   ; 1F13A:  55 00
b07_b13c:   rol a                       ; 1F13C:  2a
b07_b13d:   brk                         ; 1F13D:  00
b07_b13e:   rol a                       ; 1F13E:  2a
b07_b13f:   brk                         ; 1F13F:  00
b07_b140:   rol a                       ; 1F140:  2a
b07_b141:   brk                         ; 1F141:  00
b07_b142:   rol a                       ; 1F142:  2a
b07_b143:   brk                         ; 1F143:  00
b07_b144:   .db $47                     ; 1F144:  47
b07_b145:   ora ($40,x)                 ; 1F145:  01 40
b07_b147:   brk                         ; 1F147:  00
b07_b148:   rti                         ; 1F148:  40
b07_b149:   ora ($46,x)                 ; 1F149:  01 46
b07_b14b:   .db $0c                     ; 1F14B:  0c
b07_b14c:   .db $80                     ; 1F14C:  80
b07_b14d:   bpl $b0eb                   ; 1F14D:  10 9c
b07_b14f:   asl $09a0                   ; 1F14F:  0e a0 09
b07_b152:   sta $4e13,y                 ; 1F152:  99 13 4e
b07_b155:   asl $054e                   ; 1F155:  0e 4e 05
b07_b158:   eor $04                     ; 1F158:  45 04
b07_b15a:   .db $44                     ; 1F15A:  44
b07_b15b:   brk                         ; 1F15B:  00
b07_b15c:   sta ($11),y                 ; 1F15C:  91 11
b07_b15e:   sta ($1a),y                 ; 1F15E:  91 1a
b07_b160:   tax                         ; 1F160:  aa
b07_b161:   asl a                       ; 1F161:  0a
b07_b162:   .db $ab                     ; 1F162:  ab
b07_b163:   .db $0f                     ; 1F163:  0f
b07_b164:   .db $ff                     ; 1F164:  ff
b07_b165:   .db $ff                     ; 1F165:  ff
b07_b166:   beq $b148                   ; 1F166:  f0 e0
b07_b168:   .db $e3                     ; 1F168:  e3
b07_b169:   bvs $b1dd                   ; 1F169:  70 72
b07_b16b:   .db $7b                     ; 1F16B:  7b
b07_b16c:   brk                         ; 1F16C:  00
b07_b16d:   brk                         ; 1F16D:  00
b07_b16e:   brk                         ; 1F16E:  00
b07_b16f:   ora ($1c,x)                 ; 1F16F:  01 1c
b07_b171:   .db $0c                     ; 1F171:  0c
b07_b172:   asl a                       ; 1F172:  0a
b07_b173:   sty $ff                     ; 1F173:  84 ff
b07_b175:   inc $f71f,x                 ; 1F175:  fe 1f f7
b07_b178:   .db $ff                     ; 1F178:  ff
b07_b179:   .db $3f                     ; 1F179:  3f
b07_b17a:   .db $4f                     ; 1F17A:  4f
b07_b17b:   .db $ff                     ; 1F17B:  ff
b07_b17c:   brk                         ; 1F17C:  00
b07_b17d:   brk                         ; 1F17D:  00
b07_b17e:   brk                         ; 1F17E:  00
b07_b17f:   brk                         ; 1F17F:  00
b07_b180:   brk                         ; 1F180:  00
b07_b181:   brk                         ; 1F181:  00
b07_b182:   rti                         ; 1F182:  40
b07_b183:   brk                         ; 1F183:  00
b07_b184:   .db $ff                     ; 1F184:  ff
b07_b185:   .db $ff                     ; 1F185:  ff
b07_b186:   .db $ff                     ; 1F186:  ff
b07_b187:   .db $ef                     ; 1F187:  ef
b07_b188:   .db $ef                     ; 1F188:  ef
b07_b189:   .db $87                     ; 1F189:  87
b07_b18a:   .db $1f                     ; 1F18A:  1f
b07_b18b:   .db $7f                     ; 1F18B:  7f
b07_b18c:   brk                         ; 1F18C:  00
b07_b18d:   brk                         ; 1F18D:  00
b07_b18e:   brk                         ; 1F18E:  00
b07_b18f:   bpl $b1a1                   ; 1F18F:  10 10
b07_b191:   clc                         ; 1F191:  18
b07_b192:   rts                         ; 1F192:  60
b07_b193:   .db $80                     ; 1F193:  80
b07_b194:   .db $80                     ; 1F194:  80
b07_b195:   brk                         ; 1F195:  00
b07_b196:   brk                         ; 1F196:  00
b07_b197:   .db $80                     ; 1F197:  80
b07_b198:   stx $a292                   ; 1F198:  8e 92 a2
b07_b19b:   ldx #$00                    ; 1F19B:  a2 00
b07_b19d:   brk                         ; 1F19D:  00
b07_b19e:   brk                         ; 1F19E:  00
b07_b19f:   brk                         ; 1F19F:  00
b07_b1a0:   brk                         ; 1F1A0:  00
b07_b1a1:   brk                         ; 1F1A1:  00
b07_b1a2:   .db $04                     ; 1F1A2:  04
b07_b1a3:   php                         ; 1F1A3:  08
b07_b1a4:   eor $00,x                   ; 1F1A4:  55 00
b07_b1a6:   eor $00,x                   ; 1F1A6:  55 00
b07_b1a8:   eor $00,x                   ; 1F1A8:  55 00
b07_b1aa:   eor $00,x                   ; 1F1AA:  55 00
b07_b1ac:   rol a                       ; 1F1AC:  2a
b07_b1ad:   brk                         ; 1F1AD:  00
b07_b1ae:   rol a                       ; 1F1AE:  2a
b07_b1af:   brk                         ; 1F1AF:  00
b07_b1b0:   tax                         ; 1F1B0:  aa
b07_b1b1:   brk                         ; 1F1B1:  00
b07_b1b2:   tax                         ; 1F1B2:  aa
b07_b1b3:   brk                         ; 1F1B3:  00
b07_b1b4:   .db $82                     ; 1F1B4:  82
b07_b1b5:   ldx $cd                     ; 1F1B5:  a6 cd
b07_b1b7:   sed                         ; 1F1B7:  f8
b07_b1b8:   sbc ($c0),y                 ; 1F1B8:  f1 c0
b07_b1ba:   cmp $c0                     ; 1F1BA:  c5 c0
b07_b1bc:   php                         ; 1F1BC:  08
b07_b1bd:   bpl $b1df                   ; 1F1BD:  10 20
b07_b1bf:   brk                         ; 1F1BF:  00
b07_b1c0:   .db $02                     ; 1F1C0:  02
b07_b1c1:   brk                         ; 1F1C1:  00
b07_b1c2:   .db $02                     ; 1F1C2:  02
b07_b1c3:   brk                         ; 1F1C3:  00
b07_b1c4:   eor $00,x                   ; 1F1C4:  55 00
b07_b1c6:   eor $00,x                   ; 1F1C6:  55 00
b07_b1c8:   eor $00,x                   ; 1F1C8:  55 00
b07_b1ca:   rti                         ; 1F1CA:  40
b07_b1cb:   .db $37                     ; 1F1CB:  37
b07_b1cc:   tax                         ; 1F1CC:  aa
b07_b1cd:   brk                         ; 1F1CD:  00
b07_b1ce:   tax                         ; 1F1CE:  aa
b07_b1cf:   brk                         ; 1F1CF:  00
b07_b1d0:   tax                         ; 1F1D0:  aa
b07_b1d1:   brk                         ; 1F1D1:  00
b07_b1d2:   .db $80                     ; 1F1D2:  80
b07_b1d3:   brk                         ; 1F1D3:  00
b07_b1d4:   bvc $b1d6                   ; 1F1D4:  50 00
b07_b1d6:   bvc $b1d8                   ; 1F1D6:  50 00
b07_b1d8:   .db $54                     ; 1F1D8:  54
b07_b1d9:   brk                         ; 1F1D9:  00
b07_b1da:   php                         ; 1F1DA:  08
b07_b1db:   .db $22                     ; 1F1DB:  22
b07_b1dc:   .db $a7                     ; 1F1DC:  a7
b07_b1dd:   .db $07                     ; 1F1DD:  07
b07_b1de:   .db $ab                     ; 1F1DE:  ab
b07_b1df:   .db $03                     ; 1F1DF:  03
b07_b1e0:   lda #$01                    ; 1F1E0:  a9 01
b07_b1e2:   brk                         ; 1F1E2:  00
b07_b1e3:   brk                         ; 1F1E3:  00
b07_b1e4:   cmp $dd77,x                 ; 1F1E4:  dd 77 dd
b07_b1e7:   .db $77                     ; 1F1E7:  77
b07_b1e8:   cmp $dd77,x                 ; 1F1E8:  dd 77 dd
b07_b1eb:   .db $77                     ; 1F1EB:  77
b07_b1ec:   brk                         ; 1F1EC:  00
b07_b1ed:   brk                         ; 1F1ED:  00
b07_b1ee:   brk                         ; 1F1EE:  00
b07_b1ef:   brk                         ; 1F1EF:  00
b07_b1f0:   brk                         ; 1F1F0:  00
b07_b1f1:   brk                         ; 1F1F1:  00
b07_b1f2:   brk                         ; 1F1F2:  00
b07_b1f3:   brk                         ; 1F1F3:  00
b07_b1f4:   .db $89                     ; 1F1F4:  89
b07_b1f5:   rts                         ; 1F1F5:  60
b07_b1f6:   cmp #$73                    ; 1F1F6:  c9 73
b07_b1f8:   cmp $d476,y                 ; 1F1F8:  d9 76 d4
b07_b1fb:   ror $00                     ; 1F1FB:  66 00
b07_b1fd:   brk                         ; 1F1FD:  00
b07_b1fe:   brk                         ; 1F1FE:  00
b07_b1ff:   brk                         ; 1F1FF:  00
b07_b200:   brk                         ; 1F200:  00
b07_b201:   brk                         ; 1F201:  00
b07_b202:   brk                         ; 1F202:  00
b07_b203:   brk                         ; 1F203:  00
b07_b204:   .db $2b                     ; 1F204:  2b
b07_b205:   .db $f3                     ; 1F205:  f3
b07_b206:   .db $1b                     ; 1F206:  1b
b07_b207:   .db $0f                     ; 1F207:  0f
b07_b208:   .db $7f                     ; 1F208:  7f
b07_b209:   .db $7f                     ; 1F209:  7f
b07_b20a:   .db $7f                     ; 1F20A:  7f
b07_b20b:   rol $0004,x                 ; 1F20B:  3e 04 00
b07_b20e:   .db $80                     ; 1F20E:  80
b07_b20f:   cpx #$80                    ; 1F20F:  e0 80
b07_b211:   .db $80                     ; 1F211:  80
b07_b212:   .db $80                     ; 1F212:  80
b07_b213:   rti                         ; 1F213:  40
b07_b214:   .db $ff                     ; 1F214:  ff
b07_b215:   .db $ff                     ; 1F215:  ff
b07_b216:   .db $ff                     ; 1F216:  ff
b07_b217:   inc $f3fd,x                 ; 1F217:  fe fd f3
b07_b21a:   .db $c7                     ; 1F21A:  c7
b07_b21b:   .db $0f                     ; 1F21B:  0f
b07_b21c:   brk                         ; 1F21C:  00
b07_b21d:   brk                         ; 1F21D:  00
b07_b21e:   brk                         ; 1F21E:  00
b07_b21f:   ora ($00,x)                 ; 1F21F:  01 00
b07_b221:   brk                         ; 1F221:  00
b07_b222:   ora ($13,x)                 ; 1F222:  01 13
b07_b224:   brk                         ; 1F224:  00
b07_b225:   rti                         ; 1F225:  40
b07_b226:   eor ($23,x)                 ; 1F226:  41 23
b07_b228:   .db $23                     ; 1F228:  23
b07_b229:   lda ($11,x)                 ; 1F229:  a1 11
b07_b22b:   .db $93                     ; 1F22B:  93
b07_b22c:   brk                         ; 1F22C:  00
b07_b22d:   .db $43                     ; 1F22D:  43
b07_b22e:   lsr $2c2c,x                 ; 1F22E:  5e 2c 2c
b07_b231:   ldx $9717                   ; 1F231:  ae 17 97
b07_b234:   asl $fa7c,x                 ; 1F234:  1e 7c fa
b07_b237:   beq $b21a                   ; 1F237:  f0 e1
b07_b239:   cmp #$a1                    ; 1F239:  c9 a1
b07_b23b:   .db $0b                     ; 1F23B:  0b
b07_b23c:   ror $8c                     ; 1F23C:  66 8c
b07_b23e:   .db $1a                     ; 1F23E:  1a
b07_b23f:   bmi $b2a1                   ; 1F23F:  30 60
b07_b241:   iny                         ; 1F241:  c8
b07_b242:   ldy #$08                    ; 1F242:  a0 08
b07_b244:   lda $a0                     ; 1F244:  a5 a0
b07_b246:   adc #$c4                    ; 1F246:  69 c4
b07_b248:   cmp $9cd6,x                 ; 1F248:  dd d6 9c
b07_b24b:   rol $02,x                   ; 1F24B:  36 02
b07_b24d:   jsr $40a2                   ; 1F24D:  20 a2 40
b07_b250:   rti                         ; 1F250:  40
b07_b251:   cpy #$80                    ; 1F251:  c0 80
b07_b253:   brk                         ; 1F253:  00
b07_b254:   eor $00,x                   ; 1F254:  55 00
b07_b256:   eor $00,x                   ; 1F256:  55 00
b07_b258:   eor $00,x                   ; 1F258:  55 00
b07_b25a:   cpy #$77                    ; 1F25A:  c0 77
b07_b25c:   tax                         ; 1F25C:  aa
b07_b25d:   brk                         ; 1F25D:  00
b07_b25e:   tax                         ; 1F25E:  aa
b07_b25f:   brk                         ; 1F25F:  00
b07_b260:   tax                         ; 1F260:  aa
b07_b261:   brk                         ; 1F261:  00
b07_b262:   brk                         ; 1F262:  00
b07_b263:   brk                         ; 1F263:  00
b07_b264:   .db $5c                     ; 1F264:  5c
b07_b265:   adc $dd,x                   ; 1F265:  75 dd
b07_b267:   adc $dd,x                   ; 1F267:  75 dd
b07_b269:   .db $73                     ; 1F269:  73
b07_b26a:   cmp $0073,y                 ; 1F26A:  d9 73 00
b07_b26d:   brk                         ; 1F26D:  00
b07_b26e:   brk                         ; 1F26E:  00
b07_b26f:   brk                         ; 1F26F:  00
b07_b270:   brk                         ; 1F270:  00
b07_b271:   brk                         ; 1F271:  00
b07_b272:   brk                         ; 1F272:  00
b07_b273:   brk                         ; 1F273:  00
b07_b274:   brk                         ; 1F274:  00
b07_b275:   brk                         ; 1F275:  00
b07_b276:   brk                         ; 1F276:  00
b07_b277:   brk                         ; 1F277:  00
b07_b278:   brk                         ; 1F278:  00
b07_b279:   brk                         ; 1F279:  00
b07_b27a:   brk                         ; 1F27A:  00
b07_b27b:   brk                         ; 1F27B:  00
b07_b27c:   tax                         ; 1F27C:  aa
b07_b27d:   .db $ff                     ; 1F27D:  ff
b07_b27e:   tax                         ; 1F27E:  aa
b07_b27f:   .db $ff                     ; 1F27F:  ff
b07_b280:   tax                         ; 1F280:  aa
b07_b281:   .db $ff                     ; 1F281:  ff
b07_b282:   tax                         ; 1F282:  aa
b07_b283:   .db $ff                     ; 1F283:  ff
b07_b284:   brk                         ; 1F284:  00
b07_b285:   brk                         ; 1F285:  00
b07_b286:   brk                         ; 1F286:  00
b07_b287:   brk                         ; 1F287:  00
b07_b288:   brk                         ; 1F288:  00
b07_b289:   brk                         ; 1F289:  00
b07_b28a:   brk                         ; 1F28A:  00
b07_b28b:   ora ($aa,x)                 ; 1F28B:  01 aa
b07_b28d:   .db $ff                     ; 1F28D:  ff
b07_b28e:   tax                         ; 1F28E:  aa
b07_b28f:   .db $ff                     ; 1F28F:  ff
b07_b290:   tax                         ; 1F290:  aa
b07_b291:   .db $ff                     ; 1F291:  ff
b07_b292:   tax                         ; 1F292:  aa
b07_b293:   inc $0703,x                 ; 1F293:  fe 03 07
b07_b296:   .db $07                     ; 1F296:  07
b07_b297:   .db $0f                     ; 1F297:  0f
b07_b298:   .db $0f                     ; 1F298:  0f
b07_b299:   .db $0f                     ; 1F299:  0f
b07_b29a:   .db $0f                     ; 1F29A:  0f
b07_b29b:   .db $1a                     ; 1F29B:  1a
b07_b29c:   tay                         ; 1F29C:  a8
b07_b29d:   sed                         ; 1F29D:  f8
b07_b29e:   tay                         ; 1F29E:  a8
b07_b29f:   beq $b241                   ; 1F29F:  f0 a0
b07_b2a1:   beq $b243                   ; 1F2A1:  f0 a0
b07_b2a3:   cpx #$00                    ; 1F2A3:  e0 00
b07_b2a5:   brk                         ; 1F2A5:  00
b07_b2a6:   brk                         ; 1F2A6:  00
b07_b2a7:   .db $07                     ; 1F2A7:  07
b07_b2a8:   .db $1f                     ; 1F2A8:  1f
b07_b2a9:   .db $7f                     ; 1F2A9:  7f
b07_b2aa:   .db $ff                     ; 1F2AA:  ff
b07_b2ab:   .db $ff                     ; 1F2AB:  ff
b07_b2ac:   tax                         ; 1F2AC:  aa
b07_b2ad:   .db $ff                     ; 1F2AD:  ff
b07_b2ae:   tax                         ; 1F2AE:  aa
b07_b2af:   sed                         ; 1F2AF:  f8
b07_b2b0:   ldy #$80                    ; 1F2B0:  a0 80
b07_b2b2:   brk                         ; 1F2B2:  00
b07_b2b3:   brk                         ; 1F2B3:  00
b07_b2b4:   brk                         ; 1F2B4:  00
b07_b2b5:   brk                         ; 1F2B5:  00
b07_b2b6:   brk                         ; 1F2B6:  00
b07_b2b7:   .db $fc                     ; 1F2B7:  fc
b07_b2b8:   .db $ff                     ; 1F2B8:  ff
b07_b2b9:   .db $ff                     ; 1F2B9:  ff
b07_b2ba:   .db $ff                     ; 1F2BA:  ff
b07_b2bb:   .db $ff                     ; 1F2BB:  ff
b07_b2bc:   tay                         ; 1F2BC:  a8
b07_b2bd:   .db $fc                     ; 1F2BD:  fc
b07_b2be:   tay                         ; 1F2BE:  a8
b07_b2bf:   .db $03                     ; 1F2BF:  03
b07_b2c0:   brk                         ; 1F2C0:  00
b07_b2c1:   brk                         ; 1F2C1:  00
b07_b2c2:   brk                         ; 1F2C2:  00
b07_b2c3:   brk                         ; 1F2C3:  00
b07_b2c4:   .db $ff                     ; 1F2C4:  ff
b07_b2c5:   .db $ff                     ; 1F2C5:  ff
b07_b2c6:   .db $ff                     ; 1F2C6:  ff
b07_b2c7:   .db $ff                     ; 1F2C7:  ff
b07_b2c8:   .db $ff                     ; 1F2C8:  ff
b07_b2c9:   .db $ff                     ; 1F2C9:  ff
b07_b2ca:   .db $ff                     ; 1F2CA:  ff
b07_b2cb:   .db $ff                     ; 1F2CB:  ff
b07_b2cc:   brk                         ; 1F2CC:  00
b07_b2cd:   brk                         ; 1F2CD:  00
b07_b2ce:   brk                         ; 1F2CE:  00
b07_b2cf:   brk                         ; 1F2CF:  00
b07_b2d0:   brk                         ; 1F2D0:  00
b07_b2d1:   brk                         ; 1F2D1:  00
b07_b2d2:   brk                         ; 1F2D2:  00
b07_b2d3:   brk                         ; 1F2D3:  00
b07_b2d4:   .db $ff                     ; 1F2D4:  ff
b07_b2d5:   .db $ff                     ; 1F2D5:  ff
b07_b2d6:   .db $ff                     ; 1F2D6:  ff
b07_b2d7:   .db $ff                     ; 1F2D7:  ff
b07_b2d8:   .db $ff                     ; 1F2D8:  ff
b07_b2d9:   .db $ff                     ; 1F2D9:  ff
b07_b2da:   .db $ff                     ; 1F2DA:  ff
b07_b2db:   .db $97                     ; 1F2DB:  97
b07_b2dc:   brk                         ; 1F2DC:  00
b07_b2dd:   brk                         ; 1F2DD:  00
b07_b2de:   brk                         ; 1F2DE:  00
b07_b2df:   brk                         ; 1F2DF:  00
b07_b2e0:   brk                         ; 1F2E0:  00
b07_b2e1:   brk                         ; 1F2E1:  00
b07_b2e2:   brk                         ; 1F2E2:  00
b07_b2e3:   brk                         ; 1F2E3:  00
b07_b2e4:   sec                         ; 1F2E4:  38
b07_b2e5:   .db $1c                     ; 1F2E5:  1c
b07_b2e6:   .db $0c                     ; 1F2E6:  0c
b07_b2e7:   asl $8606                   ; 1F2E7:  0e 06 86
b07_b2ea:   dec $c0                     ; 1F2EA:  c6 c0
b07_b2ec:   .db $3a                     ; 1F2EC:  3a
b07_b2ed:   .db $5f                     ; 1F2ED:  5f
b07_b2ee:   ldx $c62f                   ; 1F2EE:  ae 2f c6
b07_b2f1:   .db $67                     ; 1F2F1:  67
b07_b2f2:   rol $38,x                   ; 1F2F2:  36 38
b07_b2f4:   cpy #$c0                    ; 1F2F4:  c0 c0
b07_b2f6:   cpy #$c0                    ; 1F2F6:  c0 c0
b07_b2f8:   cpy #$80                    ; 1F2F8:  c0 80
b07_b2fa:   .db $80                     ; 1F2FA:  80
b07_b2fb:   .db $80                     ; 1F2FB:  80
b07_b2fc:   sec                         ; 1F2FC:  38
b07_b2fd:   .db $3c                     ; 1F2FD:  3c
b07_b2fe:   .db $3c                     ; 1F2FE:  3c
b07_b2ff:   and $7c3c,x                 ; 1F2FF:  3d 3c 7c
b07_b302:   sei                         ; 1F302:  78
b07_b303:   .db $7c                     ; 1F303:  7c
b07_b304:   .db $1c                     ; 1F304:  1c
b07_b305:   .db $17                     ; 1F305:  17
b07_b306:   .db $1f                     ; 1F306:  1f
b07_b307:   .db $1f                     ; 1F307:  1f
b07_b308:   .db $0c                     ; 1F308:  0c
b07_b309:   asl $1f0f                   ; 1F309:  0e 0f 1f
b07_b30c:   ldy #$e0                    ; 1F30C:  a0 e0
b07_b30e:   ldy #$e0                    ; 1F30E:  a0 e0
b07_b310:   ldy #$f2                    ; 1F310:  a0 f2
b07_b312:   ldy #$e0                    ; 1F312:  a0 e0
b07_b314:   .db $1f                     ; 1F314:  1f
b07_b315:   .db $1f                     ; 1F315:  1f
b07_b316:   .db $1f                     ; 1F316:  1f
b07_b317:   .db $1f                     ; 1F317:  1f
b07_b318:   .db $1f                     ; 1F318:  1f
b07_b319:   .db $1f                     ; 1F319:  1f
b07_b31a:   .db $1f                     ; 1F31A:  1f
b07_b31b:   asl $e0a0,x                 ; 1F31B:  1e a0 e0
b07_b31e:   ldy #$e0                    ; 1F31E:  a0 e0
b07_b320:   ldy #$e0                    ; 1F320:  a0 e0
b07_b322:   ldy #$e0                    ; 1F322:  a0 e0
b07_b324:   .db $7f                     ; 1F324:  7f
b07_b325:   rol $9e5f,x                 ; 1F325:  3e 5f 9e
b07_b328:   .db $0c                     ; 1F328:  0c
b07_b329:   sty $9cde                   ; 1F329:  8c de 9c
b07_b32c:   brk                         ; 1F32C:  00
b07_b32d:   brk                         ; 1F32D:  00
b07_b32e:   .db $80                     ; 1F32E:  80
b07_b32f:   eor ($63,x)                 ; 1F32F:  41 63
b07_b331:   .db $a3                     ; 1F331:  a3
b07_b332:   and ($43,x)                 ; 1F332:  21 43
b07_b334:   .db $0b                     ; 1F334:  0b
b07_b335:   ldx $7f7e,y                 ; 1F335:  be 7e 7f
b07_b338:   brk                         ; 1F338:  00
b07_b339:   lsr $3d7e                   ; 1F339:  4e 7e 3d
b07_b33c:   brk                         ; 1F33C:  00
b07_b33d:   rti                         ; 1F33D:  40
b07_b33e:   sta ($80,x)                 ; 1F33E:  81 80
b07_b340:   .db $83                     ; 1F340:  83
b07_b341:   eor #$81                    ; 1F341:  49 81
b07_b343:   .db $82                     ; 1F343:  82
b07_b344:   inc $b8be,x                 ; 1F344:  fe be b8
b07_b347:   .db $80                     ; 1F347:  80
b07_b348:   .db $43                     ; 1F348:  43
b07_b349:   .db $e7                     ; 1F349:  e7
b07_b34a:   .db $7f                     ; 1F34A:  7f
b07_b34b:   .db $3f                     ; 1F34B:  3f
b07_b34c:   ora ($00,x)                 ; 1F34C:  01 00
b07_b34e:   brk                         ; 1F34E:  00
b07_b34f:   .db $03                     ; 1F34F:  03
b07_b350:   .db $34                     ; 1F350:  34
b07_b351:   php                         ; 1F351:  08
b07_b352:   brk                         ; 1F352:  00
b07_b353:   brk                         ; 1F353:  00
b07_b354:   .db $97                     ; 1F354:  97
b07_b355:   .db $ff                     ; 1F355:  ff
b07_b356:   .db $ff                     ; 1F356:  ff
b07_b357:   .db $7f                     ; 1F357:  7f
b07_b358:   .db $3f                     ; 1F358:  3f
b07_b359:   .db $bf                     ; 1F359:  bf
b07_b35a:   .db $9f                     ; 1F35A:  9f
b07_b35b:   .db $5f                     ; 1F35B:  5f
b07_b35c:   rti                         ; 1F35C:  40
b07_b35d:   brk                         ; 1F35D:  00
b07_b35e:   brk                         ; 1F35E:  00
b07_b35f:   brk                         ; 1F35F:  00
b07_b360:   .db $80                     ; 1F360:  80
b07_b361:   rti                         ; 1F361:  40
b07_b362:   jsr $8000                   ; 1F362:  20 00 80
b07_b365:   brk                         ; 1F365:  00
b07_b366:   brk                         ; 1F366:  00
b07_b367:   brk                         ; 1F367:  00
b07_b368:   brk                         ; 1F368:  00
b07_b369:   brk                         ; 1F369:  00
b07_b36a:   .db $03                     ; 1F36A:  03
b07_b36b:   sty $70                     ; 1F36B:  84 70
b07_b36d:   sed                         ; 1F36D:  f8
b07_b36e:   beq $b368                   ; 1F36E:  f0 f8
b07_b370:   beq $b36a                   ; 1F370:  f0 f8
b07_b372:   sed                         ; 1F372:  f8
b07_b373:   adc ($00),y                 ; 1F373:  71 00
b07_b375:   brk                         ; 1F375:  00
b07_b376:   brk                         ; 1F376:  00
b07_b377:   brk                         ; 1F377:  00
b07_b378:   brk                         ; 1F378:  00
b07_b379:   brk                         ; 1F379:  00
b07_b37a:   brk                         ; 1F37A:  00
b07_b37b:   brk                         ; 1F37B:  00
b07_b37c:   tax                         ; 1F37C:  aa
b07_b37d:   .db $ff                     ; 1F37D:  ff
b07_b37e:   tax                         ; 1F37E:  aa
b07_b37f:   .db $ff                     ; 1F37F:  ff
b07_b380:   tax                         ; 1F380:  aa
b07_b381:   .db $ff                     ; 1F381:  ff
b07_b382:   rol a                       ; 1F382:  2a
b07_b383:   .db $7f                     ; 1F383:  7f
b07_b384:   cpy #$c0                    ; 1F384:  c0 c0
b07_b386:   iny                         ; 1F386:  c8
b07_b387:   iny                         ; 1F387:  c8
b07_b388:   cpy $88                     ; 1F388:  c4 88
b07_b38a:   tya                         ; 1F38A:  98
b07_b38b:   bcc $b3c6                   ; 1F38B:  90 39
b07_b38d:   and ($32),y                 ; 1F38D:  31 32
b07_b38f:   .db $32                     ; 1F38F:  32
b07_b390:   .db $32                     ; 1F390:  32
b07_b391:   adc ($64),y                 ; 1F391:  71 64
b07_b393:   adc $0000                   ; 1F393:  6d 00 00
b07_b396:   brk                         ; 1F396:  00
b07_b397:   brk                         ; 1F397:  00
b07_b398:   brk                         ; 1F398:  00
b07_b399:   brk                         ; 1F399:  00
b07_b39a:   brk                         ; 1F39A:  00
b07_b39b:   brk                         ; 1F39B:  00
b07_b39c:   rol a                       ; 1F39C:  2a
b07_b39d:   .db $7f                     ; 1F39D:  7f
b07_b39e:   tax                         ; 1F39E:  aa
b07_b39f:   .db $ff                     ; 1F39F:  ff
b07_b3a0:   tax                         ; 1F3A0:  aa
b07_b3a1:   .db $ff                     ; 1F3A1:  ff
b07_b3a2:   tax                         ; 1F3A2:  aa
b07_b3a3:   .db $ff                     ; 1F3A3:  ff
b07_b3a4:   asl $0f0d                   ; 1F3A4:  0e 0d 0f
b07_b3a7:   .db $07                     ; 1F3A7:  07
b07_b3a8:   .db $07                     ; 1F3A8:  07
b07_b3a9:   .db $03                     ; 1F3A9:  03
b07_b3aa:   ora ($02,x)                 ; 1F3AA:  01 02
b07_b3ac:   ldy #$f0                    ; 1F3AC:  a0 f0
b07_b3ae:   ldy #$f8                    ; 1F3AE:  a0 f8
b07_b3b0:   tay                         ; 1F3B0:  a8
b07_b3b1:   .db $fc                     ; 1F3B1:  fc
b07_b3b2:   tay                         ; 1F3B2:  a8
b07_b3b3:   .db $fa                     ; 1F3B3:  fa
b07_b3b4:   brk                         ; 1F3B4:  00
b07_b3b5:   brk                         ; 1F3B5:  00
b07_b3b6:   ora $dd77,x                 ; 1F3B6:  1d 77 dd
b07_b3b9:   .db $77                     ; 1F3B9:  77
b07_b3ba:   cmp $aa77,x                 ; 1F3BA:  dd 77 aa
b07_b3bd:   cpx #$1d                    ; 1F3BD:  e0 1d
b07_b3bf:   .db $77                     ; 1F3BF:  77
b07_b3c0:   cmp $dd77,x                 ; 1F3C0:  dd 77 dd
b07_b3c3:   .db $77                     ; 1F3C3:  77
b07_b3c4:   ora ($37,x)                 ; 1F3C4:  01 37
b07_b3c6:   cpy $dc66                   ; 1F3C6:  cc 66 dc
b07_b3c9:   lsr $9c,x                   ; 1F3C9:  56 9c
b07_b3cb:   rol $81,x                   ; 1F3CB:  36 81
b07_b3cd:   .db $37                     ; 1F3CD:  37
b07_b3ce:   cpy $dc66                   ; 1F3CE:  cc 66 dc
b07_b3d1:   lsr $9c,x                   ; 1F3D1:  56 9c
b07_b3d3:   rol $41,x                   ; 1F3D3:  36 41
b07_b3d5:   ldx $e1ff,y                 ; 1F3D5:  be ff e1
b07_b3d8:   cpy #$ee                    ; 1F3D8:  c0 ee
b07_b3da:   .db $ff                     ; 1F3DA:  ff
b07_b3db:   .db $7f                     ; 1F3DB:  7f
b07_b3dc:   brk                         ; 1F3DC:  00
b07_b3dd:   brk                         ; 1F3DD:  00
b07_b3de:   brk                         ; 1F3DE:  00
b07_b3df:   .db $02                     ; 1F3DF:  02
b07_b3e0:   and $10,x                   ; 1F3E0:  35 10
b07_b3e2:   brk                         ; 1F3E2:  00
b07_b3e3:   brk                         ; 1F3E3:  00
b07_b3e4:   .db $8f                     ; 1F3E4:  8f
b07_b3e5:   .db $4f                     ; 1F3E5:  4f
b07_b3e6:   .db $87                     ; 1F3E6:  87
b07_b3e7:   .db $ef                     ; 1F3E7:  ef
b07_b3e8:   ror $f87c,x                 ; 1F3E8:  7e 7c f8
b07_b3eb:   beq $b3ed                   ; 1F3EB:  f0 00
b07_b3ed:   brk                         ; 1F3ED:  00
b07_b3ee:   bpl $b400                   ; 1F3EE:  10 10
b07_b3f0:   sta ($83,x)                 ; 1F3F0:  81 83
b07_b3f2:   .db $07                     ; 1F3F2:  07
b07_b3f3:   .db $0c                     ; 1F3F3:  0c
b07_b3f4:   .db $3f                     ; 1F3F4:  3f
b07_b3f5:   .db $9f                     ; 1F3F5:  9f
b07_b3f6:   .db $80                     ; 1F3F6:  80
b07_b3f7:   rti                         ; 1F3F7:  40
b07_b3f8:   rts                         ; 1F3F8:  60
b07_b3f9:   .db $37                     ; 1F3F9:  37
b07_b3fa:   .db $9b                     ; 1F3FA:  9b
b07_b3fb:   eor $8000                   ; 1F3FB:  4d 00 80
b07_b3fe:   ldy #$50                    ; 1F3FE:  a0 50
b07_b400:   .db $6f                     ; 1F400:  6f
b07_b401:   bcs $b45b                   ; 1F401:  b0 58
b07_b403:   lda $00c0                   ; 1F403:  ad c0 00
b07_b406:   ora ($0b,x)                 ; 1F406:  01 0b
b07_b408:   rol $f2fd,x                 ; 1F408:  3e fd f2
b07_b40b:   cmp $31                     ; 1F40B:  c5 31
b07_b40d:   .db $c7                     ; 1F40D:  c7
b07_b40e:   .db $1f                     ; 1F40E:  1f
b07_b40f:   .db $77                     ; 1F40F:  77
b07_b410:   dec $1c                     ; 1F410:  c6 1c
b07_b412:   adc ($ca),y                 ; 1F412:  71 ca
b07_b414:   .db $80                     ; 1F414:  80
b07_b415:   .db $80                     ; 1F415:  80
b07_b416:   php                         ; 1F416:  08
b07_b417:   php                         ; 1F417:  08
b07_b418:   bpl $b430                   ; 1F418:  10 16
b07_b41a:   and ($26),y                 ; 1F41A:  31 26
b07_b41c:   ror a                       ; 1F41C:  6a
b07_b41d:   .db $63                     ; 1F41D:  63
b07_b41e:   nop                         ; 1F41E:  ea
b07_b41f:   sbc #$d0                    ; 1F41F:  e9 d0
b07_b421:   inc $71,x                   ; 1F421:  f6 71
b07_b423:   inc $00                     ; 1F423:  e6 00
b07_b425:   brk                         ; 1F425:  00
b07_b426:   brk                         ; 1F426:  00
b07_b427:   brk                         ; 1F427:  00
b07_b428:   brk                         ; 1F428:  00
b07_b429:   brk                         ; 1F429:  00
b07_b42a:   brk                         ; 1F42A:  00
b07_b42b:   brk                         ; 1F42B:  00
b07_b42c:   tax                         ; 1F42C:  aa
b07_b42d:   .db $ff                     ; 1F42D:  ff
b07_b42e:   tax                         ; 1F42E:  aa
b07_b42f:   .db $ff                     ; 1F42F:  ff
b07_b430:   tax                         ; 1F430:  aa
b07_b431:   .db $ff                     ; 1F431:  ff
b07_b432:   rol a                       ; 1F432:  2a
b07_b433:   .db $1f                     ; 1F433:  1f
b07_b434:   adc #$c6                    ; 1F434:  69 c6
b07_b436:   lda #$56                    ; 1F436:  a9 56
b07_b438:   sta $9d36,y                 ; 1F438:  99 36 9d
b07_b43b:   .db $77                     ; 1F43B:  77
b07_b43c:   sbc #$c6                    ; 1F43C:  e9 c6
b07_b43e:   .db $89                     ; 1F43E:  89
b07_b43f:   asl $59,x                   ; 1F43F:  16 59
b07_b441:   ldx $1d,y                   ; 1F441:  b6 1d
b07_b443:   .db $77                     ; 1F443:  77
b07_b444:   .db $80                     ; 1F444:  80
b07_b445:   rol $99                     ; 1F445:  26 99
b07_b447:   .db $27                     ; 1F447:  27
b07_b448:   ora $1d77,x                 ; 1F448:  1d 77 1d
b07_b44b:   .db $77                     ; 1F44B:  77
b07_b44c:   .db $80                     ; 1F44C:  80
b07_b44d:   rol $99                     ; 1F44D:  26 99
b07_b44f:   .db $27                     ; 1F44F:  27
b07_b450:   ora $1d77,x                 ; 1F450:  1d 77 1d
b07_b453:   .db $77                     ; 1F453:  77
b07_b454:   cmp $dd77,x                 ; 1F454:  dd 77 dd
b07_b457:   .db $77                     ; 1F457:  77
b07_b458:   cmp $dd77,x                 ; 1F458:  dd 77 dd
b07_b45b:   .db $77                     ; 1F45B:  77
b07_b45c:   dey                         ; 1F45C:  88
b07_b45d:   eor $88,x                   ; 1F45D:  55 88
b07_b45f:   eor $88,x                   ; 1F45F:  55 88
b07_b461:   eor $88,x                   ; 1F461:  55 88
b07_b463:   eor $dc,x                   ; 1F463:  55 dc
b07_b465:   ror $dc,x                   ; 1F465:  76 dc
b07_b467:   .db $72                     ; 1F467:  72
b07_b468:   .db $d4                     ; 1F468:  d4
b07_b469:   rts                         ; 1F469:  60
b07_b46a:   .db $d4                     ; 1F46A:  d4
b07_b46b:   bvs $b3f5                   ; 1F46B:  70 88
b07_b46d:   .db $54                     ; 1F46D:  54
b07_b46e:   dey                         ; 1F46E:  88
b07_b46f:   .db $52                     ; 1F46F:  52
b07_b470:   sty $41                     ; 1F470:  84 41
b07_b472:   sty $51                     ; 1F472:  84 51
b07_b474:   cmp $dc76,x                 ; 1F474:  dd 76 dc
b07_b477:   ror $d0,x                   ; 1F477:  76 d0
b07_b479:   .db $43                     ; 1F479:  43
b07_b47a:   .db $8f                     ; 1F47A:  8f
b07_b47b:   .db $1f                     ; 1F47B:  1f
b07_b47c:   dey                         ; 1F47C:  88
b07_b47d:   .db $54                     ; 1F47D:  54
b07_b47e:   dey                         ; 1F47E:  88
b07_b47f:   .db $54                     ; 1F47F:  54
b07_b480:   .db $80                     ; 1F480:  80
b07_b481:   jmp $60b0                   ; 1F481:  4c b0 60
b07_b484:   eor $1d97,x                 ; 1F484:  5d 97 1d
b07_b487:   .db $17                     ; 1F487:  17
b07_b488:   ora $f9                     ; 1F488:  05 f9
b07_b48a:   inc $48ff,x                 ; 1F48A:  fe ff 48
b07_b48d:   sta $08,x                   ; 1F48D:  95 08
b07_b48f:   ora $00,x                   ; 1F48F:  15 00
b07_b491:   ora ($00,x)                 ; 1F491:  01 00
b07_b493:   brk                         ; 1F493:  00
b07_b494:   .db $1f                     ; 1F494:  1f
b07_b495:   .db $1f                     ; 1F495:  1f
b07_b496:   .db $3f                     ; 1F496:  3f
b07_b497:   .db $3f                     ; 1F497:  3f
b07_b498:   .db $3f                     ; 1F498:  3f
b07_b499:   .db $3f                     ; 1F499:  3f
b07_b49a:   .db $3f                     ; 1F49A:  3f
b07_b49b:   .db $7f                     ; 1F49B:  7f
b07_b49c:   rts                         ; 1F49C:  60
b07_b49d:   cpx #$c0                    ; 1F49D:  e0 c0
b07_b49f:   rti                         ; 1F49F:  40
b07_b4a0:   cpy #$40                    ; 1F4A0:  c0 40
b07_b4a2:   cpy #$80                    ; 1F4A2:  c0 80
b07_b4a4:   .db $ff                     ; 1F4A4:  ff
b07_b4a5:   .db $ff                     ; 1F4A5:  ff
b07_b4a6:   .db $ff                     ; 1F4A6:  ff
b07_b4a7:   .db $ff                     ; 1F4A7:  ff
b07_b4a8:   .db $ff                     ; 1F4A8:  ff
b07_b4a9:   .db $ff                     ; 1F4A9:  ff
b07_b4aa:   .db $ff                     ; 1F4AA:  ff
b07_b4ab:   .db $ff                     ; 1F4AB:  ff
b07_b4ac:   brk                         ; 1F4AC:  00
b07_b4ad:   brk                         ; 1F4AD:  00
b07_b4ae:   brk                         ; 1F4AE:  00
b07_b4af:   brk                         ; 1F4AF:  00
b07_b4b0:   brk                         ; 1F4B0:  00
b07_b4b1:   brk                         ; 1F4B1:  00
b07_b4b2:   brk                         ; 1F4B2:  00
b07_b4b3:   brk                         ; 1F4B3:  00
b07_b4b4:   ora $9db7,x                 ; 1F4B4:  1d b7 9d
b07_b4b7:   .db $07                     ; 1F4B7:  07
b07_b4b8:   sta $43,x                   ; 1F4B8:  95 43
b07_b4ba:   sta $c7                     ; 1F4BA:  85 c7
b07_b4bc:   php                         ; 1F4BC:  08
b07_b4bd:   ora $08,x                   ; 1F4BD:  15 08
b07_b4bf:   ora $10                     ; 1F4BF:  05 10
b07_b4c1:   ora ($00,x)                 ; 1F4C1:  01 00
b07_b4c3:   ora $d0                     ; 1F4C3:  05 d0
b07_b4c5:   bvs $b497                   ; 1F4C5:  70 d0
b07_b4c7:   rts                         ; 1F4C7:  60
b07_b4c8:   cpy #$60                    ; 1F4C8:  c0 60
b07_b4ca:   cpy #$70                    ; 1F4CA:  c0 70
b07_b4cc:   sta ($51,x)                 ; 1F4CC:  81 51
b07_b4ce:   sta ($49,x)                 ; 1F4CE:  81 49
b07_b4d0:   sta $4b                     ; 1F4D0:  85 4b
b07_b4d2:   .db $8b                     ; 1F4D2:  8b
b07_b4d3:   .db $53                     ; 1F4D3:  53
b07_b4d4:   cmp ($71),y                 ; 1F4D4:  d1 71
b07_b4d6:   cld                         ; 1F4D6:  d8
b07_b4d7:   .db $74                     ; 1F4D7:  74
b07_b4d8:   .db $dc                     ; 1F4D8:  dc
b07_b4d9:   .db $74                     ; 1F4D9:  74
b07_b4da:   .db $dc                     ; 1F4DA:  dc
b07_b4db:   .db $74                     ; 1F4DB:  74
b07_b4dc:   stx $52                     ; 1F4DC:  86 52
b07_b4de:   .db $8b                     ; 1F4DE:  8b
b07_b4df:   eor $88,x                   ; 1F4DF:  55 88
b07_b4e1:   eor $89,x                   ; 1F4E1:  55 89
b07_b4e3:   .db $54                     ; 1F4E3:  54
b07_b4e4:   .db $ff                     ; 1F4E4:  ff
b07_b4e5:   .db $ab                     ; 1F4E5:  ab
b07_b4e6:   .db $07                     ; 1F4E6:  07
b07_b4e7:   and ($78),y                 ; 1F4E7:  31 78
b07_b4e9:   brk                         ; 1F4E9:  00
b07_b4ea:   pha                         ; 1F4EA:  48
b07_b4eb:   sed                         ; 1F4EB:  f8
b07_b4ec:   brk                         ; 1F4EC:  00
b07_b4ed:   brk                         ; 1F4ED:  00
b07_b4ee:   rti                         ; 1F4EE:  40
b07_b4ef:   cpy $8787                   ; 1F4EF:  cc 87 87
b07_b4f2:   dex                         ; 1F4F2:  ca
b07_b4f3:   .db $07                     ; 1F4F3:  07
b07_b4f4:   .db $ff                     ; 1F4F4:  ff
b07_b4f5:   nop                         ; 1F4F5:  ea
b07_b4f6:   cmp ($c7),y                 ; 1F4F6:  d1 c7
b07_b4f8:   .db $ef                     ; 1F4F8:  ef
b07_b4f9:   cpy #$c9                    ; 1F4F9:  c0 c9
b07_b4fb:   .db $ff                     ; 1F4FB:  ff
b07_b4fc:   brk                         ; 1F4FC:  00
b07_b4fd:   brk                         ; 1F4FD:  00
b07_b4fe:   jsr $1018                   ; 1F4FE:  20 18 10
b07_b501:   bmi $b52c                   ; 1F501:  30 29
b07_b503:   brk                         ; 1F503:  00
b07_b504:   beq $b4fa                   ; 1F504:  f0 f4
b07_b506:   cpx $397c                   ; 1F506:  ec 7c 39
b07_b509:   bmi $b53b                   ; 1F509:  30 30
b07_b50b:   jsr $020a                   ; 1F50B:  20 0a 02
b07_b50e:   .db $12                     ; 1F50E:  12
b07_b50f:   sta ($c6,x)                 ; 1F50F:  81 c6
b07_b511:   pha                         ; 1F511:  48
b07_b512:   rti                         ; 1F512:  40
b07_b513:   cpy #$ef                    ; 1F513:  c0 ef
b07_b515:   .db $e7                     ; 1F515:  e7
b07_b516:   .db $f3                     ; 1F516:  f3
b07_b517:   .db $cf                     ; 1F517:  cf
b07_b518:   .db $ef                     ; 1F518:  ef
b07_b519:   .db $8f                     ; 1F519:  8f
b07_b51a:   .db $07                     ; 1F51A:  07
b07_b51b:   .db $83                     ; 1F51B:  83
b07_b51c:   brk                         ; 1F51C:  00
b07_b51d:   bpl $b52b                   ; 1F51D:  10 0c
b07_b51f:   bpl $b531                   ; 1F51F:  10 10
b07_b521:   brk                         ; 1F521:  00
b07_b522:   brk                         ; 1F522:  00
b07_b523:   brk                         ; 1F523:  00
b07_b524:   cmp $c7                     ; 1F524:  c5 c7
b07_b526:   eor $cb                     ; 1F526:  45 cb
b07_b528:   cmp ($eb),y                 ; 1F528:  d1 eb
b07_b52a:   sbc #$e7                    ; 1F52A:  e9 e7
b07_b52c:   brk                         ; 1F52C:  00
b07_b52d:   ora $00                     ; 1F52D:  05 00
b07_b52f:   ora ($00,x)                 ; 1F52F:  01 00
b07_b531:   ora ($00,x)                 ; 1F531:  01 00
b07_b533:   ora $e5                     ; 1F533:  05 e5
b07_b535:   .db $e7                     ; 1F535:  e7
b07_b536:   sbc $9dd7                   ; 1F536:  ed d7 9d
b07_b539:   .db $17                     ; 1F539:  17
b07_b53a:   ora $1017,x                 ; 1F53A:  1d 17 10
b07_b53d:   ora $08                     ; 1F53D:  05 08
b07_b53f:   ora $08,x                   ; 1F53F:  15 08
b07_b541:   eor $48,x                   ; 1F541:  55 48
b07_b543:   sta $dd,x                   ; 1F543:  95 dd
b07_b545:   .db $77                     ; 1F545:  77
b07_b546:   cld                         ; 1F546:  d8
b07_b547:   rti                         ; 1F547:  40
b07_b548:   ldx #$28                    ; 1F548:  a2 28
b07_b54a:   tax                         ; 1F54A:  aa
b07_b54b:   tay                         ; 1F54B:  a8
b07_b54c:   dey                         ; 1F54C:  88
b07_b54d:   eor $88,x                   ; 1F54D:  55 88
b07_b54f:   rti                         ; 1F54F:  40
b07_b550:   .db $22                     ; 1F550:  22
b07_b551:   plp                         ; 1F551:  28
b07_b552:   tax                         ; 1F552:  aa
b07_b553:   tay                         ; 1F553:  a8
b07_b554:   .db $dc                     ; 1F554:  dc
b07_b555:   .db $42                     ; 1F555:  42
b07_b556:   rol a                       ; 1F556:  2a
b07_b557:   txa                         ; 1F557:  8a
b07_b558:   .db $22                     ; 1F558:  22
b07_b559:   .db $82                     ; 1F559:  82
b07_b55a:   .db $22                     ; 1F55A:  22
b07_b55b:   .db $82                     ; 1F55B:  82
b07_b55c:   dey                         ; 1F55C:  88
b07_b55d:   .db $42                     ; 1F55D:  42
b07_b55e:   rol a                       ; 1F55E:  2a
b07_b55f:   txa                         ; 1F55F:  8a
b07_b560:   .db $22                     ; 1F560:  22
b07_b561:   .db $82                     ; 1F561:  82
b07_b562:   .db $22                     ; 1F562:  22
b07_b563:   .db $82                     ; 1F563:  82
b07_b564:   dey                         ; 1F564:  88
b07_b565:   .db $80                     ; 1F565:  80
b07_b566:   .db $80                     ; 1F566:  80
b07_b567:   brk                         ; 1F567:  00
b07_b568:   php                         ; 1F568:  08
b07_b569:   plp                         ; 1F569:  28
b07_b56a:   tay                         ; 1F56A:  a8
b07_b56b:   tax                         ; 1F56B:  aa
b07_b56c:   dey                         ; 1F56C:  88
b07_b56d:   .db $80                     ; 1F56D:  80
b07_b56e:   .db $80                     ; 1F56E:  80
b07_b56f:   brk                         ; 1F56F:  00
b07_b570:   php                         ; 1F570:  08
b07_b571:   plp                         ; 1F571:  28
b07_b572:   tay                         ; 1F572:  a8
b07_b573:   tax                         ; 1F573:  aa
b07_b574:   ldx #$82                    ; 1F574:  a2 82
b07_b576:   rol a                       ; 1F576:  2a
b07_b577:   .db $82                     ; 1F577:  82
b07_b578:   tax                         ; 1F578:  aa
b07_b579:   .db $82                     ; 1F579:  82
b07_b57a:   tax                         ; 1F57A:  aa
b07_b57b:   tax                         ; 1F57B:  aa
b07_b57c:   ldx #$82                    ; 1F57C:  a2 82
b07_b57e:   rol a                       ; 1F57E:  2a
b07_b57f:   .db $82                     ; 1F57F:  82
b07_b580:   tax                         ; 1F580:  aa
b07_b581:   .db $82                     ; 1F581:  82
b07_b582:   tax                         ; 1F582:  aa
b07_b583:   tax                         ; 1F583:  aa
b07_b584:   .db $03                     ; 1F584:  03
b07_b585:   brk                         ; 1F585:  00
b07_b586:   brk                         ; 1F586:  00
b07_b587:   ora ($00,x)                 ; 1F587:  01 00
b07_b589:   brk                         ; 1F589:  00
b07_b58a:   brk                         ; 1F58A:  00
b07_b58b:   .db $80                     ; 1F58B:  80
b07_b58c:   cpy $5e                     ; 1F58C:  c4 5e
b07_b58e:   eor $460e                   ; 1F58E:  4d 0e 46
b07_b591:   .db $62                     ; 1F591:  62
b07_b592:   rts                         ; 1F592:  60
b07_b593:   clv                         ; 1F593:  b8
b07_b594:   sbc ($31),y                 ; 1F594:  f1 31
b07_b596:   ora $3178,y                 ; 1F596:  19 78 31
b07_b599:   and ($02,x)                 ; 1F599:  21 02
b07_b59b:   .db $02                     ; 1F59B:  02
b07_b59c:   brk                         ; 1F59C:  00
b07_b59d:   .db $0c                     ; 1F59D:  0c
b07_b59e:   rti                         ; 1F59E:  40
b07_b59f:   brk                         ; 1F59F:  00
b07_b5a0:   ora ($01,x)                 ; 1F5A0:  01 01
b07_b5a2:   .db $03                     ; 1F5A2:  03
b07_b5a3:   .db $0b                     ; 1F5A3:  0b
b07_b5a4:   bcc $b53e                   ; 1F5A4:  90 98
b07_b5a6:   .db $5f                     ; 1F5A6:  5f
b07_b5a7:   .db $df                     ; 1F5A7:  df
b07_b5a8:   .db $2f                     ; 1F5A8:  2f
b07_b5a9:   ldx $39,y                   ; 1F5A9:  b6 39
b07_b5ab:   .db $8b                     ; 1F5AB:  8b
b07_b5ac:   tax                         ; 1F5AC:  aa
b07_b5ad:   ldx $c0                     ; 1F5AD:  a6 c0
b07_b5af:   cpy #$e0                    ; 1F5AF:  c0 e0
b07_b5b1:   beq $b5ac                   ; 1F5B1:  f0 f9
b07_b5b3:   .db $fb                     ; 1F5B3:  fb
b07_b5b4:   asl $2c                     ; 1F5B4:  06 2c
b07_b5b6:   .db $da                     ; 1F5B6:  da
b07_b5b7:   clv                         ; 1F5B7:  b8
b07_b5b8:   adc ($c8,x)                 ; 1F5B8:  61 c8
b07_b5ba:   .db $a3                     ; 1F5BA:  a3
b07_b5bb:   txa                         ; 1F5BB:  8a
b07_b5bc:   ldx $8e                     ; 1F5BC:  a6 8e
b07_b5be:   asl $7d3c,x                 ; 1F5BE:  1e 3c 7d
b07_b5c1:   .db $fc                     ; 1F5C1:  fc
b07_b5c2:   .db $fb                     ; 1F5C2:  fb
b07_b5c3:   .db $fa                     ; 1F5C3:  fa
b07_b5c4:   ora $6127,x                 ; 1F5C4:  1d 27 61
b07_b5c7:   tax                         ; 1F5C7:  aa
b07_b5c8:   .db $67                     ; 1F5C8:  67
b07_b5c9:   rol a                       ; 1F5C9:  2a
b07_b5ca:   .db $67                     ; 1F5CA:  67
b07_b5cb:   rol a                       ; 1F5CB:  2a
b07_b5cc:   dey                         ; 1F5CC:  88
b07_b5cd:   and $60                     ; 1F5CD:  25 60
b07_b5cf:   tax                         ; 1F5CF:  aa
b07_b5d0:   .db $67                     ; 1F5D0:  67
b07_b5d1:   rol a                       ; 1F5D1:  2a
b07_b5d2:   .db $67                     ; 1F5D2:  67
b07_b5d3:   rol a                       ; 1F5D3:  2a
b07_b5d4:   cmp $dd77,x                 ; 1F5D4:  dd 77 dd
b07_b5d7:   .db $07                     ; 1F5D7:  07
b07_b5d8:   sbc ($aa),y                 ; 1F5D8:  f1 aa
b07_b5da:   inc $88aa,x                 ; 1F5DA:  fe aa 88
b07_b5dd:   eor $88,x                   ; 1F5DD:  55 88
b07_b5df:   ora $f0                     ; 1F5DF:  05 f0
b07_b5e1:   tax                         ; 1F5E1:  aa
b07_b5e2:   inc $e7aa,x                 ; 1F5E2:  fe aa e7
b07_b5e5:   tax                         ; 1F5E5:  aa
b07_b5e6:   .db $e7                     ; 1F5E6:  e7
b07_b5e7:   tax                         ; 1F5E7:  aa
b07_b5e8:   .db $e7                     ; 1F5E8:  e7
b07_b5e9:   tax                         ; 1F5E9:  aa
b07_b5ea:   .db $ef                     ; 1F5EA:  ef
b07_b5eb:   tax                         ; 1F5EB:  aa
b07_b5ec:   .db $e7                     ; 1F5EC:  e7
b07_b5ed:   tax                         ; 1F5ED:  aa
b07_b5ee:   .db $e7                     ; 1F5EE:  e7
b07_b5ef:   tax                         ; 1F5EF:  aa
b07_b5f0:   .db $e7                     ; 1F5F0:  e7
b07_b5f1:   tax                         ; 1F5F1:  aa
b07_b5f2:   .db $ef                     ; 1F5F2:  ef
b07_b5f3:   tax                         ; 1F5F3:  aa
b07_b5f4:   dec $288a,x                 ; 1F5F4:  de 8a 28
b07_b5f7:   .db $1a                     ; 1F5F7:  1a
b07_b5f8:   .db $80                     ; 1F5F8:  80
b07_b5f9:   dex                         ; 1F5F9:  ca
b07_b5fa:   dey                         ; 1F5FA:  88
b07_b5fb:   tax                         ; 1F5FB:  aa
b07_b5fc:   dec $288a,x                 ; 1F5FC:  de 8a 28
b07_b5ff:   .db $1a                     ; 1F5FF:  1a
b07_b600:   .db $80                     ; 1F600:  80
b07_b601:   dex                         ; 1F601:  ca
b07_b602:   dey                         ; 1F602:  88
b07_b603:   tax                         ; 1F603:  aa
b07_b604:   ora ($80),y                 ; 1F604:  11 80
b07_b606:   rti                         ; 1F606:  40
b07_b607:   .db $02                     ; 1F607:  02
b07_b608:   ora ($88,x)                 ; 1F608:  01 88
b07_b60a:   .db $44                     ; 1F60A:  44
b07_b60b:   .db $22                     ; 1F60B:  22
b07_b60c:   .db $77                     ; 1F60C:  77
b07_b60d:   ldx $badd                   ; 1F60D:  ae dd ba
b07_b610:   .db $77                     ; 1F610:  77
b07_b611:   .db $ab                     ; 1F611:  ab
b07_b612:   cmp $18ea,x                 ; 1F612:  dd ea 18
b07_b615:   .db $9c                     ; 1F615:  9c
b07_b616:   eor $0703,y                 ; 1F616:  59 03 07
b07_b619:   .db $8f                     ; 1F619:  8f
b07_b61a:   .db $0f                     ; 1F61A:  0f
b07_b61b:   .db $0f                     ; 1F61B:  0f
b07_b61c:   sei                         ; 1F61C:  78
b07_b61d:   ldy $a0d8,x                 ; 1F61D:  bc d8 a0
b07_b620:   rti                         ; 1F620:  40
b07_b621:   .db $80                     ; 1F621:  80
b07_b622:   .db $80                     ; 1F622:  80
b07_b623:   brk                         ; 1F623:  00
b07_b624:   ora ($80),y                 ; 1F624:  11 80
b07_b626:   rti                         ; 1F626:  40
b07_b627:   .db $02                     ; 1F627:  02
b07_b628:   brk                         ; 1F628:  00
b07_b629:   dey                         ; 1F629:  88
b07_b62a:   .db $44                     ; 1F62A:  44
b07_b62b:   .db $22                     ; 1F62B:  22
b07_b62c:   .db $77                     ; 1F62C:  77
b07_b62d:   ldx $badc                   ; 1F62D:  ae dc ba
b07_b630:   ror $aa,x                   ; 1F630:  76 aa
b07_b632:   .db $dc                     ; 1F632:  dc
b07_b633:   nop                         ; 1F633:  ea
b07_b634:   .db $07                     ; 1F634:  07
b07_b635:   .db $0f                     ; 1F635:  0f
b07_b636:   .db $03                     ; 1F636:  03
b07_b637:   .db $07                     ; 1F637:  07
b07_b638:   ora ($02,x)                 ; 1F638:  01 02
b07_b63a:   brk                         ; 1F63A:  00
b07_b63b:   brk                         ; 1F63B:  00
b07_b63c:   brk                         ; 1F63C:  00
b07_b63d:   brk                         ; 1F63D:  00
b07_b63e:   brk                         ; 1F63E:  00
b07_b63f:   brk                         ; 1F63F:  00
b07_b640:   brk                         ; 1F640:  00
b07_b641:   brk                         ; 1F641:  00
b07_b642:   brk                         ; 1F642:  00
b07_b643:   brk                         ; 1F643:  00
b07_b644:   ora ($3f,x)                 ; 1F644:  01 3f
b07_b646:   .db $ff                     ; 1F646:  ff
b07_b647:   .db $ff                     ; 1F647:  ff
b07_b648:   .db $ff                     ; 1F648:  ff
b07_b649:   .db $ff                     ; 1F649:  ff
b07_b64a:   .db $ff                     ; 1F64A:  ff
b07_b64b:   .db $ff                     ; 1F64B:  ff
b07_b64c:   cmp ($00,x)                 ; 1F64C:  c1 00
b07_b64e:   brk                         ; 1F64E:  00
b07_b64f:   brk                         ; 1F64F:  00
b07_b650:   brk                         ; 1F650:  00
b07_b651:   brk                         ; 1F651:  00
b07_b652:   brk                         ; 1F652:  00
b07_b653:   brk                         ; 1F653:  00
b07_b654:   ora ($c0),y                 ; 1F654:  11 c0
b07_b656:   beq $b654                   ; 1F656:  f0 fc
b07_b658:   .db $ff                     ; 1F658:  ff
b07_b659:   .db $ff                     ; 1F659:  ff
b07_b65a:   .db $ff                     ; 1F65A:  ff
b07_b65b:   .db $ff                     ; 1F65B:  ff
b07_b65c:   .db $77                     ; 1F65C:  77
b07_b65d:   .db $02                     ; 1F65D:  02
b07_b65e:   .db $0c                     ; 1F65E:  0c
b07_b65f:   .db $03                     ; 1F65F:  03
b07_b660:   brk                         ; 1F660:  00
b07_b661:   brk                         ; 1F661:  00
b07_b662:   brk                         ; 1F662:  00
b07_b663:   brk                         ; 1F663:  00
b07_b664:   .db $ff                     ; 1F664:  ff
b07_b665:   .db $ff                     ; 1F665:  ff
b07_b666:   .db $ff                     ; 1F666:  ff
b07_b667:   .db $ff                     ; 1F667:  ff
b07_b668:   .db $ff                     ; 1F668:  ff
b07_b669:   .db $ff                     ; 1F669:  ff
b07_b66a:   .db $7f                     ; 1F66A:  7f
b07_b66b:   .db $ff                     ; 1F66B:  ff
b07_b66c:   brk                         ; 1F66C:  00
b07_b66d:   brk                         ; 1F66D:  00
b07_b66e:   brk                         ; 1F66E:  00
b07_b66f:   brk                         ; 1F66F:  00
b07_b670:   brk                         ; 1F670:  00
b07_b671:   brk                         ; 1F671:  00
b07_b672:   brk                         ; 1F672:  00
b07_b673:   brk                         ; 1F673:  00
b07_b674:   .db $ff                     ; 1F674:  ff
b07_b675:   .db $ff                     ; 1F675:  ff
b07_b676:   .db $ff                     ; 1F676:  ff
b07_b677:   .db $ff                     ; 1F677:  ff
b07_b678:   .db $ff                     ; 1F678:  ff
b07_b679:   .db $ff                     ; 1F679:  ff
b07_b67a:   .db $ff                     ; 1F67A:  ff
b07_b67b:   .db $ff                     ; 1F67B:  ff
b07_b67c:   brk                         ; 1F67C:  00
b07_b67d:   brk                         ; 1F67D:  00
b07_b67e:   brk                         ; 1F67E:  00
b07_b67f:   brk                         ; 1F67F:  00
b07_b680:   brk                         ; 1F680:  00
b07_b681:   brk                         ; 1F681:  00
b07_b682:   brk                         ; 1F682:  00
b07_b683:   brk                         ; 1F683:  00
b07_b684:   ora ($80),y                 ; 1F684:  11 80
b07_b686:   rti                         ; 1F686:  40
b07_b687:   .db $02                     ; 1F687:  02
b07_b688:   ora ($88,x)                 ; 1F688:  01 88
b07_b68a:   cpy $c2                     ; 1F68A:  c4 c2
b07_b68c:   .db $77                     ; 1F68C:  77
b07_b68d:   ldx $3add                   ; 1F68D:  ae dd 3a
b07_b690:   .db $d7                     ; 1F690:  d7
b07_b691:   .db $6b                     ; 1F691:  6b
b07_b692:   and $32,x                   ; 1F692:  35 32
b07_b694:   sbc ($e0,x)                 ; 1F694:  e1 e0
b07_b696:   cpx #$f0                    ; 1F696:  e0 f0
b07_b698:   sbc ($f0),y                 ; 1F698:  f1 f0
b07_b69a:   sed                         ; 1F69A:  f8
b07_b69b:   .db $fc                     ; 1F69B:  fc
b07_b69c:   .db $1b                     ; 1F69C:  1b
b07_b69d:   .db $1a                     ; 1F69D:  1a
b07_b69e:   ora $0d0c,y                 ; 1F69E:  19 0c 0d
b07_b6a1:   ora $0206                   ; 1F6A1:  0d 06 02
b07_b6a4:   bpl $b626                   ; 1F6A4:  10 80
b07_b6a6:   rti                         ; 1F6A6:  40
b07_b6a7:   .db $02                     ; 1F6A7:  02
b07_b6a8:   ora ($88,x)                 ; 1F6A8:  01 88
b07_b6aa:   .db $44                     ; 1F6AA:  44
b07_b6ab:   .db $22                     ; 1F6AB:  22
b07_b6ac:   ror $ae,x                   ; 1F6AC:  76 ae
b07_b6ae:   cmp $77ba,x                 ; 1F6AE:  dd ba 77
b07_b6b1:   .db $ab                     ; 1F6B1:  ab
b07_b6b2:   .db $dc                     ; 1F6B2:  dc
b07_b6b3:   nop                         ; 1F6B3:  ea
b07_b6b4:   brk                         ; 1F6B4:  00
b07_b6b5:   brk                         ; 1F6B5:  00
b07_b6b6:   brk                         ; 1F6B6:  00
b07_b6b7:   brk                         ; 1F6B7:  00
b07_b6b8:   brk                         ; 1F6B8:  00
b07_b6b9:   adc ($89),y                 ; 1F6B9:  71 89
b07_b6bb:   .db $89                     ; 1F6BB:  89
b07_b6bc:   brk                         ; 1F6BC:  00
b07_b6bd:   brk                         ; 1F6BD:  00
b07_b6be:   brk                         ; 1F6BE:  00
b07_b6bf:   brk                         ; 1F6BF:  00
b07_b6c0:   brk                         ; 1F6C0:  00
b07_b6c1:   brk                         ; 1F6C1:  00
b07_b6c2:   brk                         ; 1F6C2:  00
b07_b6c3:   jsr $8010                   ; 1F6C3:  20 10 80
b07_b6c6:   rti                         ; 1F6C6:  40
b07_b6c7:   .db $02                     ; 1F6C7:  02
b07_b6c8:   ora ($88,x)                 ; 1F6C8:  01 88
b07_b6ca:   .db $44                     ; 1F6CA:  44
b07_b6cb:   .db $22                     ; 1F6CB:  22
b07_b6cc:   ror $ae,x                   ; 1F6CC:  76 ae
b07_b6ce:   cmp $77ba,x                 ; 1F6CE:  dd ba 77
b07_b6d1:   .db $ab                     ; 1F6D1:  ab
b07_b6d2:   cmp $85ea,x                 ; 1F6D2:  dd ea 85
b07_b6d5:   sta ($47,x)                 ; 1F6D5:  81 47
b07_b6d7:   .db $23                     ; 1F6D7:  23
b07_b6d8:   .db $23                     ; 1F6D8:  23
b07_b6d9:   .db $93                     ; 1F6D9:  93
b07_b6da:   eor ($21,x)                 ; 1F6DA:  41 21
b07_b6dc:   jsr $3050                   ; 1F6DC:  20 50 30
b07_b6df:   bcc $b6f5                   ; 1F6DF:  90 14
b07_b6e1:   sty $e0cc                   ; 1F6E1:  8c cc e0
b07_b6e4:   .db $3f                     ; 1F6E4:  3f
b07_b6e5:   .db $3f                     ; 1F6E5:  3f
b07_b6e6:   .db $ff                     ; 1F6E6:  ff
b07_b6e7:   bvs $b6e5                   ; 1F6E7:  70 fc
b07_b6e9:   .db $ff                     ; 1F6E9:  ff
b07_b6ea:   .db $fc                     ; 1F6EA:  fc
b07_b6eb:   .db $ff                     ; 1F6EB:  ff
b07_b6ec:   brk                         ; 1F6EC:  00
b07_b6ed:   brk                         ; 1F6ED:  00
b07_b6ee:   brk                         ; 1F6EE:  00
b07_b6ef:   brk                         ; 1F6EF:  00
b07_b6f0:   brk                         ; 1F6F0:  00
b07_b6f1:   brk                         ; 1F6F1:  00
b07_b6f2:   brk                         ; 1F6F2:  00
b07_b6f3:   ora ($ff,x)                 ; 1F6F3:  01 ff
b07_b6f5:   .db $ff                     ; 1F6F5:  ff
b07_b6f6:   .db $ff                     ; 1F6F6:  ff
b07_b6f7:   .db $ff                     ; 1F6F7:  ff
b07_b6f8:   ora $01                     ; 1F6F8:  05 01
b07_b6fa:   ora ($33,x)                 ; 1F6FA:  01 33
b07_b6fc:   brk                         ; 1F6FC:  00
b07_b6fd:   brk                         ; 1F6FD:  00
b07_b6fe:   brk                         ; 1F6FE:  00
b07_b6ff:   brk                         ; 1F6FF:  00
b07_b700:   brk                         ; 1F700:  00
b07_b701:   .db $82                     ; 1F701:  82
b07_b702:   asl $fb34                   ; 1F702:  0e 34 fb
b07_b705:   .db $f7                     ; 1F705:  f7
b07_b706:   .db $ef                     ; 1F706:  ef
b07_b707:   inc $fdff,x                 ; 1F707:  fe ff fd
b07_b70a:   sed                         ; 1F70A:  f8
b07_b70b:   inc $04,x                   ; 1F70B:  f6 04
b07_b70d:   php                         ; 1F70D:  08
b07_b70e:   bpl $b710                   ; 1F70E:  10 00
b07_b710:   brk                         ; 1F710:  00
b07_b711:   brk                         ; 1F711:  00
b07_b712:   .db $04                     ; 1F712:  04
b07_b713:   ora #$fc                    ; 1F713:  09 fc
b07_b715:   .db $fc                     ; 1F715:  fc
b07_b716:   beq $b6f8                   ; 1F716:  f0 e0
b07_b718:   cmp ($80,x)                 ; 1F718:  c1 80
b07_b71a:   dey                         ; 1F71A:  88
b07_b71b:   .db $80                     ; 1F71B:  80
b07_b71c:   .db $02                     ; 1F71C:  02
b07_b71d:   brk                         ; 1F71D:  00
b07_b71e:   .db $02                     ; 1F71E:  02
b07_b71f:   .db $04                     ; 1F71F:  04
b07_b720:   ora ($05),y                 ; 1F720:  11 05
b07_b722:   ora $813c                   ; 1F722:  0d 3c 81
b07_b725:   cld                         ; 1F725:  d8
b07_b726:   cld                         ; 1F726:  d8
b07_b727:   cld                         ; 1F727:  d8
b07_b728:   sbc #$e0                    ; 1F728:  e9 e0
b07_b72a:   rts                         ; 1F72A:  60
b07_b72b:   .db $02                     ; 1F72B:  02
b07_b72c:   and $0504,x                 ; 1F72C:  3d 04 05
b07_b72f:   .db $04                     ; 1F72F:  04
b07_b730:   ora $0b                     ; 1F730:  05 0b
b07_b732:   ora #$0a                    ; 1F732:  09 0a
b07_b734:   ora ($80),y                 ; 1F734:  11 80
b07_b736:   rti                         ; 1F736:  40
b07_b737:   .db $02                     ; 1F737:  02
b07_b738:   ora ($88,x)                 ; 1F738:  01 88
b07_b73a:   .db $44                     ; 1F73A:  44
b07_b73b:   jsr $ae77                   ; 1F73B:  20 77 ae
b07_b73e:   cmp $77ba,x                 ; 1F73E:  dd ba 77
b07_b741:   .db $ab                     ; 1F741:  ab
b07_b742:   .db $dc                     ; 1F742:  dc
b07_b743:   cpx #$11                    ; 1F743:  e0 11
b07_b745:   sty $44                     ; 1F745:  84 44
b07_b747:   .db $03                     ; 1F747:  03
b07_b748:   .db $13                     ; 1F748:  13
b07_b749:   and #$14                    ; 1F749:  29 14
b07_b74b:   rol a                       ; 1F74B:  2a
b07_b74c:   .db $74                     ; 1F74C:  74
b07_b74d:   ldx $c7                     ; 1F74D:  a6 c7
b07_b74f:   ldx #$4b                    ; 1F74F:  a2 4b
b07_b751:   and #$28                    ; 1F751:  29 28
b07_b753:   rol a                       ; 1F753:  2a
b07_b754:   ora $00,x                   ; 1F754:  15 00
b07_b756:   eor $00,x                   ; 1F756:  55 00
b07_b758:   eor $00,x                   ; 1F758:  55 00
b07_b75a:   eor $00,x                   ; 1F75A:  55 00
b07_b75c:   asl a                       ; 1F75C:  0a
b07_b75d:   brk                         ; 1F75D:  00
b07_b75e:   tax                         ; 1F75E:  aa
b07_b75f:   brk                         ; 1F75F:  00
b07_b760:   tax                         ; 1F760:  aa
b07_b761:   brk                         ; 1F761:  00
b07_b762:   .db $82                     ; 1F762:  82
b07_b763:   brk                         ; 1F763:  00
b07_b764:   .db $14                     ; 1F764:  14
b07_b765:   rol a                       ; 1F765:  2a
b07_b766:   ora $0a,x                   ; 1F766:  15 0a
b07_b768:   eor $0a,x                   ; 1F768:  55 0a
b07_b76a:   eor $00                     ; 1F76A:  45 00
b07_b76c:   tax                         ; 1F76C:  aa
b07_b76d:   rol a                       ; 1F76D:  2a
b07_b76e:   tax                         ; 1F76E:  aa
b07_b76f:   asl a                       ; 1F76F:  0a
b07_b770:   txa                         ; 1F770:  8a
b07_b771:   asl a                       ; 1F771:  0a
b07_b772:   tax                         ; 1F772:  aa
b07_b773:   brk                         ; 1F773:  00
b07_b774:   .db $ff                     ; 1F774:  ff
b07_b775:   .db $ff                     ; 1F775:  ff
b07_b776:   .db $7f                     ; 1F776:  7f
b07_b777:   .db $bf                     ; 1F777:  bf
b07_b778:   .db $df                     ; 1F778:  df
b07_b779:   .db $ef                     ; 1F779:  ef
b07_b77a:   .db $f3                     ; 1F77A:  f3
b07_b77b:   sei                         ; 1F77B:  78
b07_b77c:   brk                         ; 1F77C:  00
b07_b77d:   brk                         ; 1F77D:  00
b07_b77e:   .db $80                     ; 1F77E:  80
b07_b77f:   brk                         ; 1F77F:  00
b07_b780:   brk                         ; 1F780:  00
b07_b781:   .db $80                     ; 1F781:  80
b07_b782:   cpy #$64                    ; 1F782:  c0 64
b07_b784:   .db $ef                     ; 1F784:  ef
b07_b785:   .db $ff                     ; 1F785:  ff
b07_b786:   sed                         ; 1F786:  f8
b07_b787:   .db $f7                     ; 1F787:  f7
b07_b788:   inc $fffe,x                 ; 1F788:  fe fe ff
b07_b78b:   .db $ff                     ; 1F78B:  ff
b07_b78c:   bpl $b78e                   ; 1F78C:  10 00
b07_b78e:   brk                         ; 1F78E:  00
b07_b78f:   brk                         ; 1F78F:  00
b07_b790:   brk                         ; 1F790:  00
b07_b791:   ora ($00,x)                 ; 1F791:  01 00
b07_b793:   brk                         ; 1F793:  00
b07_b794:   .db $7c                     ; 1F794:  7c
b07_b795:   rol $8f1f,x                 ; 1F795:  3e 1f 8f
b07_b798:   .db $07                     ; 1F798:  07
b07_b799:   .db $83                     ; 1F799:  83
b07_b79a:   eor ($00,x)                 ; 1F79A:  41 00
b07_b79c:   .db $72                     ; 1F79C:  72
b07_b79d:   and $8e5c,y                 ; 1F79D:  39 5c 8e
b07_b7a0:   .db $a7                     ; 1F7A0:  a7
b07_b7a1:   .db $83                     ; 1F7A1:  83
b07_b7a2:   .db $89                     ; 1F7A2:  89
b07_b7a3:   brk                         ; 1F7A3:  00
b07_b7a4:   .db $1f                     ; 1F7A4:  1f
b07_b7a5:   brk                         ; 1F7A5:  00
b07_b7a6:   .db $80                     ; 1F7A6:  80
b07_b7a7:   cpx #$fc                    ; 1F7A7:  e0 fc
b07_b7a9:   .db $fc                     ; 1F7A9:  fc
b07_b7aa:   sed                         ; 1F7AA:  f8
b07_b7ab:   adc $8000,y                 ; 1F7AB:  79 00 80
b07_b7ae:   rts                         ; 1F7AE:  60
b07_b7af:   .db $1f                     ; 1F7AF:  1f
b07_b7b0:   .db $02                     ; 1F7B0:  02
b07_b7b1:   .db $82                     ; 1F7B1:  82
b07_b7b2:   inc $75                     ; 1F7B2:  e6 75
b07_b7b4:   ora ($c0,x)                 ; 1F7B4:  01 c0
b07_b7b6:   jsr $01c2                   ; 1F7B6:  20 c2 01
b07_b7b9:   brk                         ; 1F7B9:  00
b07_b7ba:   cpy #$e0                    ; 1F7BA:  c0 e0
b07_b7bc:   .db $fb                     ; 1F7BC:  fb
b07_b7bd:   asl a                       ; 1F7BD:  0a
b07_b7be:   ora $3312,y                 ; 1F7BE:  19 12 33
b07_b7c1:   cpx #$2a                    ; 1F7C1:  e0 2a
b07_b7c3:   brk                         ; 1F7C3:  00
b07_b7c4:   ora ($80),y                 ; 1F7C4:  11 80
b07_b7c6:   rti                         ; 1F7C6:  40
b07_b7c7:   .db $02                     ; 1F7C7:  02
b07_b7c8:   ora ($08,x)                 ; 1F7C8:  01 08
b07_b7ca:   brk                         ; 1F7CA:  00
b07_b7cb:   brk                         ; 1F7CB:  00
b07_b7cc:   .db $77                     ; 1F7CC:  77
b07_b7cd:   ldx $badd                   ; 1F7CD:  ae dd ba
b07_b7d0:   .db $77                     ; 1F7D0:  77
b07_b7d1:   .db $0b                     ; 1F7D1:  0b
b07_b7d2:   lda ($00,x)                 ; 1F7D2:  a1 00
b07_b7d4:   .db $80                     ; 1F7D4:  80
b07_b7d5:   brk                         ; 1F7D5:  00
b07_b7d6:   ora ($00,x)                 ; 1F7D6:  01 00
b07_b7d8:   sta $80                     ; 1F7D8:  85 80
b07_b7da:   sta ($80,x)                 ; 1F7DA:  81 80
b07_b7dc:   asl a                       ; 1F7DC:  0a
b07_b7dd:   brk                         ; 1F7DD:  00
b07_b7de:   rol a                       ; 1F7DE:  2a
b07_b7df:   brk                         ; 1F7DF:  00
b07_b7e0:   .db $82                     ; 1F7E0:  82
b07_b7e1:   .db $80                     ; 1F7E1:  80
b07_b7e2:   tax                         ; 1F7E2:  aa
b07_b7e3:   ldy #$55                    ; 1F7E3:  a0 55
b07_b7e5:   brk                         ; 1F7E5:  00
b07_b7e6:   eor ($00),y                 ; 1F7E6:  51 00
b07_b7e8:   eor $00                     ; 1F7E8:  45 00
b07_b7ea:   .db $44                     ; 1F7EA:  44
b07_b7eb:   brk                         ; 1F7EB:  00
b07_b7ec:   tax                         ; 1F7EC:  aa
b07_b7ed:   brk                         ; 1F7ED:  00
b07_b7ee:   tax                         ; 1F7EE:  aa
b07_b7ef:   brk                         ; 1F7EF:  00
b07_b7f0:   plp                         ; 1F7F0:  28
b07_b7f1:   brk                         ; 1F7F1:  00
b07_b7f2:   .db $82                     ; 1F7F2:  82
b07_b7f3:   brk                         ; 1F7F3:  00
b07_b7f4:   .db $07                     ; 1F7F4:  07
b07_b7f5:   .db $07                     ; 1F7F5:  07
b07_b7f6:   .db $07                     ; 1F7F6:  07
b07_b7f7:   .db $03                     ; 1F7F7:  03
b07_b7f8:   ora ($01,x)                 ; 1F7F8:  01 01
b07_b7fa:   ora ($01,x)                 ; 1F7FA:  01 01
b07_b7fc:   .db $27                     ; 1F7FC:  27
b07_b7fd:   .db $87                     ; 1F7FD:  87
b07_b7fe:   .db $27                     ; 1F7FE:  27
b07_b7ff:   .db $8b                     ; 1F7FF:  8b
b07_b800:   and ($89,x)                 ; 1F800:  21 89
b07_b802:   and ($89,x)                 ; 1F802:  21 89
b07_b804:   rti                         ; 1F804:  40
b07_b805:   tay                         ; 1F805:  a8
b07_b806:   bvc $b788                   ; 1F806:  50 80
b07_b808:   tya                         ; 1F808:  98
b07_b809:   bne $b7eb                   ; 1F809:  d0 e0
b07_b80b:   .db $80                     ; 1F80B:  80
b07_b80c:   cpx #$e0                    ; 1F80C:  e0 e0
b07_b80e:   cpy #$80                    ; 1F80E:  c0 80
b07_b810:   .db $80                     ; 1F810:  80
b07_b811:   cpy #$e8                    ; 1F811:  c0 e8
b07_b813:   .db $80                     ; 1F813:  80
b07_b814:   ora ($01,x)                 ; 1F814:  01 01
b07_b816:   brk                         ; 1F816:  00
b07_b817:   brk                         ; 1F817:  00
b07_b818:   .db $07                     ; 1F818:  07
b07_b819:   asl $06                     ; 1F819:  06 06
b07_b81b:   .db $02                     ; 1F81B:  02
b07_b81c:   and ($89,x)                 ; 1F81C:  21 89
b07_b81e:   .db $22                     ; 1F81E:  22
b07_b81f:   dey                         ; 1F81F:  88
b07_b820:   .db $27                     ; 1F820:  27
b07_b821:   stx $26                     ; 1F821:  86 26
b07_b823:   txa                         ; 1F823:  8a
b07_b824:   brk                         ; 1F824:  00
b07_b825:   brk                         ; 1F825:  00
b07_b826:   brk                         ; 1F826:  00
b07_b827:   brk                         ; 1F827:  00
b07_b828:   brk                         ; 1F828:  00
b07_b829:   brk                         ; 1F829:  00
b07_b82a:   brk                         ; 1F82A:  00
b07_b82b:   brk                         ; 1F82B:  00
b07_b82c:   brk                         ; 1F82C:  00
b07_b82d:   brk                         ; 1F82D:  00
b07_b82e:   brk                         ; 1F82E:  00
b07_b82f:   brk                         ; 1F82F:  00
b07_b830:   brk                         ; 1F830:  00
b07_b831:   brk                         ; 1F831:  00
b07_b832:   .db $1f                     ; 1F832:  1f
b07_b833:   .db $7f                     ; 1F833:  7f
b07_b834:   brk                         ; 1F834:  00
b07_b835:   brk                         ; 1F835:  00
b07_b836:   bpl $b858                   ; 1F836:  10 20
b07_b838:   brk                         ; 1F838:  00
b07_b839:   ora #$05                    ; 1F839:  09 05
b07_b83b:   brk                         ; 1F83B:  00
b07_b83c:   brk                         ; 1F83C:  00
b07_b83d:   brk                         ; 1F83D:  00
b07_b83e:   brk                         ; 1F83E:  00
b07_b83f:   brk                         ; 1F83F:  00
b07_b840:   jsr $0000                   ; 1F840:  20 00 00
b07_b843:   brk                         ; 1F843:  00
b07_b844:   .db $23                     ; 1F844:  23
b07_b845:   .db $1c                     ; 1F845:  1c
b07_b846:   brk                         ; 1F846:  00
b07_b847:   brk                         ; 1F847:  00
b07_b848:   beq $b83a                   ; 1F848:  f0 f0
b07_b84a:   rts                         ; 1F84A:  60
b07_b84b:   brk                         ; 1F84B:  00
b07_b84c:   brk                         ; 1F84C:  00
b07_b84d:   brk                         ; 1F84D:  00
b07_b84e:   brk                         ; 1F84E:  00
b07_b84f:   brk                         ; 1F84F:  00
b07_b850:   php                         ; 1F850:  08
b07_b851:   php                         ; 1F851:  08
b07_b852:   bpl $b834                   ; 1F852:  10 e0
b07_b854:   brk                         ; 1F854:  00
b07_b855:   php                         ; 1F855:  08
b07_b856:   bpl $b858                   ; 1F856:  10 00
b07_b858:   brk                         ; 1F858:  00
b07_b859:   brk                         ; 1F859:  00
b07_b85a:   brk                         ; 1F85A:  00
b07_b85b:   brk                         ; 1F85B:  00
b07_b85c:   brk                         ; 1F85C:  00
b07_b85d:   .db $04                     ; 1F85D:  04
b07_b85e:   .db $03                     ; 1F85E:  03
b07_b85f:   bpl $b861                   ; 1F85F:  10 00
b07_b861:   brk                         ; 1F861:  00
b07_b862:   brk                         ; 1F862:  00
b07_b863:   cpy #$00                    ; 1F863:  c0 00
b07_b865:   brk                         ; 1F865:  00
b07_b866:   php                         ; 1F866:  08
b07_b867:   .db $04                     ; 1F867:  04
b07_b868:   brk                         ; 1F868:  00
b07_b869:   brk                         ; 1F869:  00
b07_b86a:   ora ($02,x)                 ; 1F86A:  01 02
b07_b86c:   brk                         ; 1F86C:  00
b07_b86d:   brk                         ; 1F86D:  00
b07_b86e:   brk                         ; 1F86E:  00
b07_b86f:   brk                         ; 1F86F:  00
b07_b870:   brk                         ; 1F870:  00
b07_b871:   brk                         ; 1F871:  00
b07_b872:   ora ($02,x)                 ; 1F872:  01 02
b07_b874:   .db $d4                     ; 1F874:  d4
b07_b875:   brk                         ; 1F875:  00
b07_b876:   brk                         ; 1F876:  00
b07_b877:   brk                         ; 1F877:  00
b07_b878:   brk                         ; 1F878:  00
b07_b879:   brk                         ; 1F879:  00
b07_b87a:   .db $07                     ; 1F87A:  07
b07_b87b:   .db $0f                     ; 1F87B:  0f
b07_b87c:   rol a                       ; 1F87C:  2a
b07_b87d:   ora ($00,x)                 ; 1F87D:  01 00
b07_b87f:   brk                         ; 1F87F:  00
b07_b880:   brk                         ; 1F880:  00
b07_b881:   brk                         ; 1F881:  00
b07_b882:   .db $07                     ; 1F882:  07
b07_b883:   .db $0f                     ; 1F883:  0f
b07_b884:   .db $7a                     ; 1F884:  7a
b07_b885:   .db $34                     ; 1F885:  34
b07_b886:   clc                         ; 1F886:  18
b07_b887:   bpl $b8b1                   ; 1F887:  10 28
b07_b889:   beq $b86b                   ; 1F889:  f0 e0
b07_b88b:   bne $b90c                   ; 1F88B:  d0 7f
b07_b88d:   rol $585c,x                 ; 1F88D:  3e 5c 58
b07_b890:   .db $3a                     ; 1F890:  3a
b07_b891:   beq $b885                   ; 1F891:  f0 f2
b07_b893:   beq $b8b4                   ; 1F893:  f0 1f
b07_b895:   .db $1f                     ; 1F895:  1f
b07_b896:   asl $6a15,x                 ; 1F896:  1e 15 6a
b07_b899:   .db $f4                     ; 1F899:  f4
b07_b89a:   sed                         ; 1F89A:  f8
b07_b89b:   .db $fc                     ; 1F89B:  fc
b07_b89c:   .db $1f                     ; 1F89C:  1f
b07_b89d:   .db $1f                     ; 1F89D:  1f
b07_b89e:   .db $1f                     ; 1F89E:  1f
b07_b89f:   .db $1f                     ; 1F89F:  1f
b07_b8a0:   .db $6f                     ; 1F8A0:  6f
b07_b8a1:   .db $f7                     ; 1F8A1:  f7
b07_b8a2:   .db $fb                     ; 1F8A2:  fb
b07_b8a3:   .db $fc                     ; 1F8A3:  fc
b07_b8a4:   ldy #$40                    ; 1F8A4:  a0 40
b07_b8a6:   ldy #$08                    ; 1F8A6:  a0 08
b07_b8a8:   .db $44                     ; 1F8A8:  44
b07_b8a9:   clc                         ; 1F8A9:  18
b07_b8aa:   .db $22                     ; 1F8AA:  22
b07_b8ab:   ora ($e2),y                 ; 1F8AB:  11 e2
b07_b8ad:   cpx #$e2                    ; 1F8AD:  e0 e2
b07_b8af:   cpx $e0                     ; 1F8AF:  e4 e0
b07_b8b1:   cpy $91                     ; 1F8B1:  c4 91
b07_b8b3:   rti                         ; 1F8B3:  40
b07_b8b4:   ora ($00,x)                 ; 1F8B4:  01 00
b07_b8b6:   brk                         ; 1F8B6:  00
b07_b8b7:   brk                         ; 1F8B7:  00
b07_b8b8:   brk                         ; 1F8B8:  00
b07_b8b9:   brk                         ; 1F8B9:  00
b07_b8ba:   brk                         ; 1F8BA:  00
b07_b8bb:   brk                         ; 1F8BB:  00
b07_b8bc:   and ($88,x)                 ; 1F8BC:  21 88
b07_b8be:   .db $22                     ; 1F8BE:  22
b07_b8bf:   dey                         ; 1F8BF:  88
b07_b8c0:   .db $22                     ; 1F8C0:  22
b07_b8c1:   dey                         ; 1F8C1:  88
b07_b8c2:   .db $22                     ; 1F8C2:  22
b07_b8c3:   dey                         ; 1F8C3:  88
b07_b8c4:   brk                         ; 1F8C4:  00
b07_b8c5:   .db $03                     ; 1F8C5:  03
b07_b8c6:   .db $07                     ; 1F8C6:  07
b07_b8c7:   .db $83                     ; 1F8C7:  83
b07_b8c8:   brk                         ; 1F8C8:  00
b07_b8c9:   bcc $b8d7                   ; 1F8C9:  90 0c
b07_b8cb:   ora $6c5f                   ; 1F8CB:  0d 5f 6c
b07_b8ce:   rti                         ; 1F8CE:  40
b07_b8cf:   bmi $b8f4                   ; 1F8CF:  30 23
b07_b8d1:   and ($30),y                 ; 1F8D1:  31 30
b07_b8d3:   bmi $b8d5                   ; 1F8D3:  30 00
b07_b8d5:   brk                         ; 1F8D5:  00
b07_b8d6:   brk                         ; 1F8D6:  00
b07_b8d7:   brk                         ; 1F8D7:  00
b07_b8d8:   .db $02                     ; 1F8D8:  02
b07_b8d9:   brk                         ; 1F8D9:  00
b07_b8da:   .db $02                     ; 1F8DA:  02
b07_b8db:   brk                         ; 1F8DB:  00
b07_b8dc:   jsr $2088                   ; 1F8DC:  20 88 20
b07_b8df:   dey                         ; 1F8DF:  88
b07_b8e0:   jsr $2088                   ; 1F8E0:  20 88 20
b07_b8e3:   dey                         ; 1F8E3:  88
b07_b8e4:   ora $01                     ; 1F8E4:  05 01
b07_b8e6:   ora ($03,x)                 ; 1F8E6:  01 03
b07_b8e8:   .db $03                     ; 1F8E8:  03
b07_b8e9:   .db $03                     ; 1F8E9:  03
b07_b8ea:   brk                         ; 1F8EA:  00
b07_b8eb:   brk                         ; 1F8EB:  00
b07_b8ec:   .db $3a                     ; 1F8EC:  3a
b07_b8ed:   .db $3c                     ; 1F8ED:  3c
b07_b8ee:   .db $1c                     ; 1F8EE:  1c
b07_b8ef:   clc                         ; 1F8EF:  18
b07_b8f0:   clc                         ; 1F8F0:  18
b07_b8f1:   clc                         ; 1F8F1:  18
b07_b8f2:   .db $0c                     ; 1F8F2:  0c
b07_b8f3:   .db $0f                     ; 1F8F3:  0f
b07_b8f4:   brk                         ; 1F8F4:  00
b07_b8f5:   beq $b8f1                   ; 1F8F5:  f0 fa
b07_b8f7:   bvs $b8f9                   ; 1F8F7:  70 00
b07_b8f9:   brk                         ; 1F8F9:  00
b07_b8fa:   .db $c7                     ; 1F8FA:  c7
b07_b8fb:   .db $f3                     ; 1F8FB:  f3
b07_b8fc:   sed                         ; 1F8FC:  f8
b07_b8fd:   .db $0f                     ; 1F8FD:  0f
b07_b8fe:   brk                         ; 1F8FE:  00
b07_b8ff:   brk                         ; 1F8FF:  00
b07_b900:   .db $83                     ; 1F900:  83
b07_b901:   cpy #$37                    ; 1F901:  c0 37
b07_b903:   .db $0c                     ; 1F903:  0c
b07_b904:   ora ($00,x)                 ; 1F904:  01 00
b07_b906:   php                         ; 1F906:  08
b07_b907:   sei                         ; 1F907:  78
b07_b908:   cpx $3e1e                   ; 1F908:  ec 1e 3e
b07_b90b:   .db $ff                     ; 1F90B:  ff
b07_b90c:   ora #$7c                    ; 1F90C:  09 7c
b07_b90e:   ldx $87,y                   ; 1F90E:  b6 87
b07_b910:   .db $03                     ; 1F910:  03
b07_b911:   ora ($01,x)                 ; 1F911:  01 01
b07_b913:   brk                         ; 1F913:  00
b07_b914:   sbc $dffc,y                 ; 1F914:  f9 fc df
b07_b917:   .db $ef                     ; 1F917:  ef
b07_b918:   .db $e7                     ; 1F918:  e7
b07_b919:   .db $03                     ; 1F919:  03
b07_b91a:   ora $063c,y                 ; 1F91A:  19 3c 06
b07_b91d:   .db $03                     ; 1F91D:  03
b07_b91e:   brk                         ; 1F91E:  00
b07_b91f:   brk                         ; 1F91F:  00
b07_b920:   brk                         ; 1F920:  00
b07_b921:   clc                         ; 1F921:  18
b07_b922:   .db $64                     ; 1F922:  64
b07_b923:   .db $c3                     ; 1F923:  c3
b07_b924:   .db $ff                     ; 1F924:  ff
b07_b925:   .db $ff                     ; 1F925:  ff
b07_b926:   .db $ff                     ; 1F926:  ff
b07_b927:   inc $fefe,x                 ; 1F927:  fe fe fe
b07_b92a:   sbc $00fc,x                 ; 1F92A:  fd fc 00
b07_b92d:   brk                         ; 1F92D:  00
b07_b92e:   brk                         ; 1F92E:  00
b07_b92f:   brk                         ; 1F92F:  00
b07_b930:   brk                         ; 1F930:  00
b07_b931:   brk                         ; 1F931:  00
b07_b932:   brk                         ; 1F932:  00
b07_b933:   ora ($78,x)                 ; 1F933:  01 78
b07_b935:   lda ($56),y                 ; 1F935:  b1 56
b07_b937:   brk                         ; 1F937:  00
b07_b938:   lsr $09                     ; 1F938:  46 09
b07_b93a:   lsr $01                     ; 1F93A:  46 01
b07_b93c:   adc $50b0,y                 ; 1F93C:  79 b0 50
b07_b93f:   brk                         ; 1F93F:  00
b07_b940:   ora ($44,x)                 ; 1F940:  01 44
b07_b942:   ora ($40,x)                 ; 1F942:  01 40
b07_b944:   ror $88                     ; 1F944:  66 88
b07_b946:   rol $99                     ; 1F946:  26 99
b07_b948:   .db $62                     ; 1F948:  62
b07_b949:   sta ($66),y                 ; 1F949:  91 66
b07_b94b:   ora $0401,y                 ; 1F94B:  19 01 04
b07_b94e:   bpl $b994                   ; 1F94E:  10 44
b07_b950:   ora ($44),y                 ; 1F950:  11 44
b07_b952:   ora ($04,x)                 ; 1F952:  01 04
b07_b954:   rti                         ; 1F954:  40
b07_b955:   ora ($42,x)                 ; 1F955:  01 42
b07_b957:   ora ($80,x)                 ; 1F957:  01 80
b07_b959:   brk                         ; 1F959:  00
b07_b95a:   .db $02                     ; 1F95A:  02
b07_b95b:   ora ($10,x)                 ; 1F95B:  01 10
b07_b95d:   bvc $b968                   ; 1F95D:  50 09
b07_b95f:   bpl $b982                   ; 1F95F:  10 21
b07_b961:   .db $80                     ; 1F961:  80
b07_b962:   eor ($48,x)                 ; 1F962:  41 48
b07_b964:   ror $98                     ; 1F964:  66 98
b07_b966:   .db $64                     ; 1F966:  64
b07_b967:   sta ($06),y                 ; 1F967:  91 06
b07_b969:   ora $9866,y                 ; 1F969:  19 66 98
b07_b96c:   ora ($44),y                 ; 1F96C:  11 44
b07_b96e:   ora ($40),y                 ; 1F96E:  11 40
b07_b970:   ora ($44,x)                 ; 1F970:  01 44
b07_b972:   ora ($44),y                 ; 1F972:  11 44
b07_b974:   .db $02                     ; 1F974:  02
b07_b975:   brk                         ; 1F975:  00
b07_b976:   .db $02                     ; 1F976:  02
b07_b977:   brk                         ; 1F977:  00
b07_b978:   .db $da                     ; 1F978:  da
b07_b979:   adc ($da),y                 ; 1F979:  71 da
b07_b97b:   adc $20,x                   ; 1F97B:  75 20
b07_b97d:   dey                         ; 1F97D:  88
b07_b97e:   jsr $d800                   ; 1F97E:  20 00 d8
b07_b981:   .db $72                     ; 1F981:  72
b07_b982:   cmp $0074,y                 ; 1F982:  d9 74 00
b07_b985:   brk                         ; 1F985:  00
b07_b986:   brk                         ; 1F986:  00
b07_b987:   brk                         ; 1F987:  00
b07_b988:   php                         ; 1F988:  08
b07_b989:   .db $22                     ; 1F989:  22
b07_b98a:   ora #$62                    ; 1F98A:  09 62
b07_b98c:   asl $07                     ; 1F98C:  06 07
b07_b98e:   .db $03                     ; 1F98E:  03
b07_b98f:   ora ($08,x)                 ; 1F98F:  01 08
b07_b991:   .db $22                     ; 1F991:  22
b07_b992:   ora #$62                    ; 1F992:  09 62
b07_b994:   .db $dc                     ; 1F994:  dc
b07_b995:   .db $77                     ; 1F995:  77
b07_b996:   cmp $5d77,x                 ; 1F996:  dd 77 5d
b07_b999:   .db $77                     ; 1F999:  77
b07_b99a:   eor $dc77,x                 ; 1F99A:  5d 77 dc
b07_b99d:   .db $77                     ; 1F99D:  77
b07_b99e:   cmp $5d77,x                 ; 1F99E:  dd 77 5d
b07_b9a1:   .db $77                     ; 1F9A1:  77
b07_b9a2:   eor $1c77,x                 ; 1F9A2:  5d 77 1c
b07_b9a5:   rts                         ; 1F9A5:  60
b07_b9a6:   cmp $d972,x                 ; 1F9A6:  dd 72 d9
b07_b9a9:   .db $77                     ; 1F9A9:  77
b07_b9aa:   bne $ba22                   ; 1F9AA:  d0 76
b07_b9ac:   .db $1c                     ; 1F9AC:  1c
b07_b9ad:   rts                         ; 1F9AD:  60
b07_b9ae:   cmp $d972,x                 ; 1F9AE:  dd 72 d9
b07_b9b1:   .db $77                     ; 1F9B1:  77
b07_b9b2:   bne $ba2a                   ; 1F9B2:  d0 76
b07_b9b4:   .db $7c                     ; 1F9B4:  7c
b07_b9b5:   brk                         ; 1F9B5:  00
b07_b9b6:   inc $070f,x                 ; 1F9B6:  fe 0f 07
b07_b9b9:   and ($0a,x)                 ; 1F9B9:  21 0a
b07_b9bb:   ora ($01,x)                 ; 1F9BB:  01 01
b07_b9bd:   brk                         ; 1F9BD:  00
b07_b9be:   ora ($70,x)                 ; 1F9BE:  01 70
b07_b9c0:   brk                         ; 1F9C0:  00
b07_b9c1:   rti                         ; 1F9C1:  40
b07_b9c2:   .db $04                     ; 1F9C2:  04
b07_b9c3:   bvs $b9bf                   ; 1F9C3:  70 fa
b07_b9c5:   sed                         ; 1F9C5:  f8
b07_b9c6:   .db $f4                     ; 1F9C6:  f4
b07_b9c7:   beq $b9b2                   ; 1F9C7:  f0 e9
b07_b9c9:   bne $b9eb                   ; 1F9C9:  d0 20
b07_b9cb:   rti                         ; 1F9CB:  40
b07_b9cc:   brk                         ; 1F9CC:  00
b07_b9cd:   .db $02                     ; 1F9CD:  02
b07_b9ce:   ora ($05,x)                 ; 1F9CE:  01 05
b07_b9d0:   .db $02                     ; 1F9D0:  02
b07_b9d1:   .db $04                     ; 1F9D1:  04
b07_b9d2:   brk                         ; 1F9D2:  00
b07_b9d3:   .db $80                     ; 1F9D3:  80
b07_b9d4:   .db $80                     ; 1F9D4:  80
b07_b9d5:   rti                         ; 1F9D5:  40
b07_b9d6:   .db $d2                     ; 1F9D6:  d2
b07_b9d7:   and ($b6),y                 ; 1F9D7:  31 b6
b07_b9d9:   ror $dded                   ; 1F9D9:  6e ed dd
b07_b9dc:   ldx $c540,y                 ; 1F9DC:  be 40 c5
b07_b9df:   bpl $b983                   ; 1F9DF:  10 a2
b07_b9e1:   .db $44                     ; 1F9E1:  44
b07_b9e2:   tay                         ; 1F9E2:  a8
b07_b9e3:   eor $00,x                   ; 1F9E3:  55 00
b07_b9e5:   ora $aa                     ; 1F9E5:  05 aa
b07_b9e7:   eor ($0b),y                 ; 1F9E7:  51 0b
b07_b9e9:   .db $db                     ; 1F9E9:  db
b07_b9ea:   cmp $01dd,x                 ; 1F9EA:  dd dd 01
b07_b9ed:   asl a                       ; 1F9ED:  0a
b07_b9ee:   .db $54                     ; 1F9EE:  54
b07_b9ef:   lda ($0a,x)                 ; 1F9EF:  a1 0a
b07_b9f1:   eor ($88),y                 ; 1F9F1:  51 88
b07_b9f3:   eor $00,x                   ; 1F9F3:  55 00
b07_b9f5:   rti                         ; 1F9F5:  40
b07_b9f6:   .db $80                     ; 1F9F6:  80
b07_b9f7:   .db $80                     ; 1F9F7:  80
b07_b9f8:   brk                         ; 1F9F8:  00
b07_b9f9:   .db $02                     ; 1F9F9:  02
b07_b9fa:   php                         ; 1F9FA:  08
b07_b9fb:   .db $42                     ; 1F9FB:  42
b07_b9fc:   cmp $1898,x                 ; 1F9FC:  dd 98 18
b07_b9ff:   bmi $ba21                   ; 1F9FF:  30 20
b07_ba01:   .db $02                     ; 1FA01:  02
b07_ba02:   pha                         ; 1FA02:  48
b07_ba03:   .db $82                     ; 1FA03:  82
b07_ba04:   .db $62                     ; 1FA04:  62
b07_ba05:   ora #$66                    ; 1FA05:  09 66
b07_ba07:   sta $1966,y                 ; 1FA07:  99 66 19
b07_ba0a:   .db $02                     ; 1FA0A:  02
b07_ba0b:   eor $11,x                   ; 1FA0B:  55 11
b07_ba0d:   .db $04                     ; 1FA0D:  04
b07_ba0e:   ora ($44),y                 ; 1FA0E:  11 44
b07_ba10:   bpl $ba52                   ; 1FA10:  10 40
b07_ba12:   ora $2a                     ; 1FA12:  05 2a
b07_ba14:   bcc $ba7c                   ; 1FA14:  90 66
b07_ba16:   rts                         ; 1FA16:  60
b07_ba17:   ror $b1,x                   ; 1FA17:  76 b1
b07_ba19:   tsx                         ; 1FA19:  ba
b07_ba1a:   cmp $10d3,y                 ; 1FA1A:  d9 d3 10
b07_ba1d:   lsr $20                     ; 1FA1D:  46 20
b07_ba1f:   lsr $a1,x                   ; 1FA1F:  56 a1
b07_ba21:   .db $12                     ; 1FA21:  12
b07_ba22:   .db $89                     ; 1FA22:  89
b07_ba23:   .db $53                     ; 1FA23:  53
b07_ba24:   tax                         ; 1FA24:  aa
b07_ba25:   .db $54                     ; 1FA25:  54
b07_ba26:   .db $80                     ; 1FA26:  80
b07_ba27:   .db $02                     ; 1FA27:  02
b07_ba28:   ora ($47,x)                 ; 1FA28:  01 47
b07_ba2a:   cmp $5547,x                 ; 1FA2A:  dd 47 55
b07_ba2d:   tax                         ; 1FA2D:  aa
b07_ba2e:   bvs $ba32                   ; 1FA2E:  70 02
b07_ba30:   ora ($47,x)                 ; 1FA30:  01 47
b07_ba32:   cmp $0047,x                 ; 1FA32:  dd 47 00
b07_ba35:   brk                         ; 1FA35:  00
b07_ba36:   brk                         ; 1FA36:  00
b07_ba37:   brk                         ; 1FA37:  00
b07_ba38:   brk                         ; 1FA38:  00
b07_ba39:   brk                         ; 1FA39:  00
b07_ba3a:   brk                         ; 1FA3A:  00
b07_ba3b:   brk                         ; 1FA3B:  00
b07_ba3c:   .db $22                     ; 1FA3C:  22
b07_ba3d:   dey                         ; 1FA3D:  88
b07_ba3e:   jsr $2288                   ; 1FA3E:  20 88 22
b07_ba41:   dey                         ; 1FA41:  88
b07_ba42:   .db $22                     ; 1FA42:  22
b07_ba43:   dey                         ; 1FA43:  88
b07_ba44:   brk                         ; 1FA44:  00
b07_ba45:   brk                         ; 1FA45:  00
b07_ba46:   .db $03                     ; 1FA46:  03
b07_ba47:   .db $07                     ; 1FA47:  07
b07_ba48:   asl $04                     ; 1FA48:  06 04
b07_ba4a:   ora ($03,x)                 ; 1FA4A:  01 03
b07_ba4c:   brk                         ; 1FA4C:  00
b07_ba4d:   .db $80                     ; 1FA4D:  80
b07_ba4e:   .db $03                     ; 1FA4E:  03
b07_ba4f:   .db $07                     ; 1FA4F:  07
b07_ba50:   asl $04                     ; 1FA50:  06 04
b07_ba52:   jsr $0080                   ; 1FA52:  20 80 00
b07_ba55:   brk                         ; 1FA55:  00
b07_ba56:   brk                         ; 1FA56:  00
b07_ba57:   brk                         ; 1FA57:  00
b07_ba58:   brk                         ; 1FA58:  00
b07_ba59:   brk                         ; 1FA59:  00
b07_ba5a:   brk                         ; 1FA5A:  00
b07_ba5b:   brk                         ; 1FA5B:  00
b07_ba5c:   .db $22                     ; 1FA5C:  22
b07_ba5d:   dey                         ; 1FA5D:  88
b07_ba5e:   .db $22                     ; 1FA5E:  22
b07_ba5f:   dey                         ; 1FA5F:  88
b07_ba60:   .db $22                     ; 1FA60:  22
b07_ba61:   dey                         ; 1FA61:  88
b07_ba62:   .db $22                     ; 1FA62:  22
b07_ba63:   dey                         ; 1FA63:  88
b07_ba64:   .db $03                     ; 1FA64:  03
b07_ba65:   ora ($02,x)                 ; 1FA65:  01 02
b07_ba67:   ora ($00,x)                 ; 1FA67:  01 00
b07_ba69:   brk                         ; 1FA69:  00
b07_ba6a:   brk                         ; 1FA6A:  00
b07_ba6b:   brk                         ; 1FA6B:  00
b07_ba6c:   jsr $0080                   ; 1FA6C:  20 80 00
b07_ba6f:   .db $80                     ; 1FA6F:  80
b07_ba70:   brk                         ; 1FA70:  00
b07_ba71:   .db $80                     ; 1FA71:  80
b07_ba72:   brk                         ; 1FA72:  00
b07_ba73:   .db $80                     ; 1FA73:  80
b07_ba74:   brk                         ; 1FA74:  00
b07_ba75:   brk                         ; 1FA75:  00
b07_ba76:   brk                         ; 1FA76:  00
b07_ba77:   .db $80                     ; 1FA77:  80
b07_ba78:   .db $3f                     ; 1FA78:  3f
b07_ba79:   .db $ff                     ; 1FA79:  ff
b07_ba7a:   .db $ff                     ; 1FA7A:  ff
b07_ba7b:   .db $ff                     ; 1FA7B:  ff
b07_ba7c:   .db $22                     ; 1FA7C:  22
b07_ba7d:   php                         ; 1FA7D:  08
b07_ba7e:   .db $22                     ; 1FA7E:  22
b07_ba7f:   .db $80                     ; 1FA7F:  80
b07_ba80:   brk                         ; 1FA80:  00
b07_ba81:   brk                         ; 1FA81:  00
b07_ba82:   brk                         ; 1FA82:  00
b07_ba83:   brk                         ; 1FA83:  00
b07_ba84:   brk                         ; 1FA84:  00
b07_ba85:   brk                         ; 1FA85:  00
b07_ba86:   brk                         ; 1FA86:  00
b07_ba87:   brk                         ; 1FA87:  00
b07_ba88:   beq $ba88                   ; 1FA88:  f0 fe
b07_ba8a:   .db $ff                     ; 1FA8A:  ff
b07_ba8b:   .db $ff                     ; 1FA8B:  ff
b07_ba8c:   .db $22                     ; 1FA8C:  22
b07_ba8d:   dey                         ; 1FA8D:  88
b07_ba8e:   .db $22                     ; 1FA8E:  22
b07_ba8f:   dey                         ; 1FA8F:  88
b07_ba90:   asl $0001                   ; 1FA90:  0e 01 00
b07_ba93:   brk                         ; 1FA93:  00
b07_ba94:   .db $ff                     ; 1FA94:  ff
b07_ba95:   .db $ff                     ; 1FA95:  ff
b07_ba96:   .db $ff                     ; 1FA96:  ff
b07_ba97:   .db $7f                     ; 1FA97:  7f
b07_ba98:   .db $7f                     ; 1FA98:  7f
b07_ba99:   .db $7f                     ; 1FA99:  7f
b07_ba9a:   .db $3c                     ; 1FA9A:  3c
b07_ba9b:   .db $7a                     ; 1FA9B:  7a
b07_ba9c:   brk                         ; 1FA9C:  00
b07_ba9d:   brk                         ; 1FA9D:  00
b07_ba9e:   brk                         ; 1FA9E:  00
b07_ba9f:   brk                         ; 1FA9F:  00
b07_baa0:   brk                         ; 1FAA0:  00
b07_baa1:   brk                         ; 1FAA1:  00
b07_baa2:   brk                         ; 1FAA2:  00
b07_baa3:   brk                         ; 1FAA3:  00
b07_baa4:   .db $ff                     ; 1FAA4:  ff
b07_baa5:   .db $ff                     ; 1FAA5:  ff
b07_baa6:   .db $ff                     ; 1FAA6:  ff
b07_baa7:   .db $ff                     ; 1FAA7:  ff
b07_baa8:   .db $ff                     ; 1FAA8:  ff
b07_baa9:   .db $ff                     ; 1FAA9:  ff
b07_baaa:   .db $bf                     ; 1FAAA:  bf
b07_baab:   .db $5f                     ; 1FAAB:  5f
b07_baac:   brk                         ; 1FAAC:  00
b07_baad:   brk                         ; 1FAAD:  00
b07_baae:   brk                         ; 1FAAE:  00
b07_baaf:   brk                         ; 1FAAF:  00
b07_bab0:   brk                         ; 1FAB0:  00
b07_bab1:   brk                         ; 1FAB1:  00
b07_bab2:   brk                         ; 1FAB2:  00
b07_bab3:   brk                         ; 1FAB3:  00
b07_bab4:   brk                         ; 1FAB4:  00
b07_bab5:   brk                         ; 1FAB5:  00
b07_bab6:   brk                         ; 1FAB6:  00
b07_bab7:   brk                         ; 1FAB7:  00
b07_bab8:   brk                         ; 1FAB8:  00
b07_bab9:   brk                         ; 1FAB9:  00
b07_baba:   .db $80                     ; 1FABA:  80
b07_babb:   cpy #$22                    ; 1FABB:  c0 22
b07_babd:   dey                         ; 1FABD:  88
b07_babe:   .db $22                     ; 1FABE:  22
b07_babf:   dey                         ; 1FABF:  88
b07_bac0:   .db $22                     ; 1FAC0:  22
b07_bac1:   dey                         ; 1FAC1:  88
b07_bac2:   .db $62                     ; 1FAC2:  62
b07_bac3:   bmi $baa5                   ; 1FAC3:  30 e0
b07_bac5:   beq $bab7                   ; 1FAC5:  f0 f0
b07_bac7:   beq $bac1                   ; 1FAC7:  f0 f8
b07_bac9:   sed                         ; 1FAC9:  f8
b07_baca:   .db $fc                     ; 1FACA:  fc
b07_bacb:   ldx $081a,y                 ; 1FACB:  be 1a 08
b07_bace:   .db $0c                     ; 1FACE:  0c
b07_bacf:   .db $0c                     ; 1FACF:  0c
b07_bad0:   asl $06                     ; 1FAD0:  06 06
b07_bad2:   .db $03                     ; 1FAD2:  03
b07_bad3:   ora ($00,x)                 ; 1FAD3:  01 00
b07_bad5:   brk                         ; 1FAD5:  00
b07_bad6:   brk                         ; 1FAD6:  00
b07_bad7:   brk                         ; 1FAD7:  00
b07_bad8:   sei                         ; 1FAD8:  78
b07_bad9:   sty $8286                   ; 1FAD9:  8c 86 82
b07_badc:   brk                         ; 1FADC:  00
b07_badd:   .db $80                     ; 1FADD:  80
b07_bade:   brk                         ; 1FADE:  00
b07_badf:   .db $80                     ; 1FADF:  80
b07_bae0:   brk                         ; 1FAE0:  00
b07_bae1:   brk                         ; 1FAE1:  00
b07_bae2:   bmi $bb24                   ; 1FAE2:  30 40
b07_bae4:   .db $80                     ; 1FAE4:  80
b07_bae5:   .db $42                     ; 1FAE5:  42
b07_bae6:   .db $62                     ; 1FAE6:  62
b07_bae7:   bmi $bafb                   ; 1FAE7:  30 12
b07_bae9:   asl $080c,x                 ; 1FAE9:  1e 0c 08
b07_baec:   cli                         ; 1FAEC:  58
b07_baed:   bpl $baff                   ; 1FAED:  10 10
b07_baef:   dey                         ; 1FAEF:  88
b07_baf0:   php                         ; 1FAF0:  08
b07_baf1:   .db $80                     ; 1FAF1:  80
b07_baf2:   .db $22                     ; 1FAF2:  22
b07_baf3:   stx $fc                     ; 1FAF3:  86 fc
b07_baf5:   .db $7f                     ; 1FAF5:  7f
b07_baf6:   .db $ff                     ; 1FAF6:  ff
b07_baf7:   .db $ff                     ; 1FAF7:  ff
b07_baf8:   .db $fc                     ; 1FAF8:  fc
b07_baf9:   .db $ff                     ; 1FAF9:  ff
b07_bafa:   .db $ff                     ; 1FAFA:  ff
b07_bafb:   .db $ff                     ; 1FAFB:  ff
b07_bafc:   brk                         ; 1FAFC:  00
b07_bafd:   brk                         ; 1FAFD:  00
b07_bafe:   brk                         ; 1FAFE:  00
b07_baff:   brk                         ; 1FAFF:  00
b07_bb00:   brk                         ; 1FB00:  00
b07_bb01:   brk                         ; 1FB01:  00
b07_bb02:   brk                         ; 1FB02:  00
b07_bb03:   brk                         ; 1FB03:  00
b07_bb04:   .db $0f                     ; 1FB04:  0f
b07_bb05:   .db $83                     ; 1FB05:  83
b07_bb06:   cpy #$00                    ; 1FB06:  c0 00
b07_bb08:   bcc $ba9b                   ; 1FB08:  90 91
b07_bb0a:   .db $f3                     ; 1FB0A:  f3
b07_bb0b:   .db $e7                     ; 1FB0B:  e7
b07_bb0c:   brk                         ; 1FB0C:  00
b07_bb0d:   .db $44                     ; 1FB0D:  44
b07_bb0e:   and ($04),y                 ; 1FB0E:  31 04
b07_bb10:   .db $93                     ; 1FB10:  93
b07_bb11:   stx $08,y                   ; 1FB11:  96 08
b07_bb13:   bpl $bb14                   ; 1FB13:  10 ff
b07_bb15:   .db $ff                     ; 1FB15:  ff
b07_bb16:   .db $6f                     ; 1FB16:  6f
b07_bb17:   .db $6f                     ; 1FB17:  6f
b07_bb18:   .db $a7                     ; 1FB18:  a7
b07_bb19:   adc ($59),y                 ; 1FB19:  71 59
b07_bb1b:   ora $0000,y                 ; 1FB1B:  19 00 00
b07_bb1e:   brk                         ; 1FB1E:  00
b07_bb1f:   brk                         ; 1FB1F:  00
b07_bb20:   bpl $bb2e                   ; 1FB20:  10 0c
b07_bb22:   asl $06                     ; 1FB22:  06 06
b07_bb24:   .db $8f                     ; 1FB24:  8f
b07_bb25:   inc $fcfc,x                 ; 1FB25:  fe fc fc
b07_bb28:   beq $bb0c                   ; 1FB28:  f0 e2
b07_bb2a:   cpx $60f0                   ; 1FB2A:  ec f0 60
b07_bb2d:   ora ($03,x)                 ; 1FB2D:  01 03
b07_bb2f:   .db $02                     ; 1FB2F:  02
b07_bb30:   .db $0c                     ; 1FB30:  0c
b07_bb31:   ora ($00),y                 ; 1FB31:  11 00
b07_bb33:   brk                         ; 1FB33:  00
b07_bb34:   ldx $00ad                   ; 1FB34:  ae ad 00
b07_bb37:   brk                         ; 1FB37:  00
b07_bb38:   cpy #$e2                    ; 1FB38:  c0 e2
b07_bb3a:   .db $e3                     ; 1FB3A:  e3
b07_bb3b:   beq $bb8d                   ; 1FB3B:  f0 50
b07_bb3d:   bpl $bba7                   ; 1FB3D:  10 68
b07_bb3f:   .db $e3                     ; 1FB3F:  e3
b07_bb40:   bpl $bb44                   ; 1FB40:  10 02
b07_bb42:   .db $02                     ; 1FB42:  02
b07_bb43:   .db $07                     ; 1FB43:  07
b07_bb44:   brk                         ; 1FB44:  00
b07_bb45:   brk                         ; 1FB45:  00
b07_bb46:   brk                         ; 1FB46:  00
b07_bb47:   brk                         ; 1FB47:  00
b07_bb48:   brk                         ; 1FB48:  00
b07_bb49:   brk                         ; 1FB49:  00
b07_bb4a:   brk                         ; 1FB4A:  00
b07_bb4b:   brk                         ; 1FB4B:  00
b07_bb4c:   ldx #$08                    ; 1FB4C:  a2 08
b07_bb4e:   .db $22                     ; 1FB4E:  22
b07_bb4f:   php                         ; 1FB4F:  08
b07_bb50:   .db $22                     ; 1FB50:  22
b07_bb51:   php                         ; 1FB51:  08
b07_bb52:   .db $22                     ; 1FB52:  22
b07_bb53:   php                         ; 1FB53:  08
b07_bb54:   beq $bbd1                   ; 1FB54:  f0 7b
b07_bb56:   .db $fb                     ; 1FB56:  fb
b07_bb57:   .db $fb                     ; 1FB57:  fb
b07_bb58:   .db $1b                     ; 1FB58:  1b
b07_bb59:   .db $02                     ; 1FB59:  02
b07_bb5a:   brk                         ; 1FB5A:  00
b07_bb5b:   jsr $0007                   ; 1FB5B:  20 07 00
b07_bb5e:   brk                         ; 1FB5E:  00
b07_bb5f:   brk                         ; 1FB5F:  00
b07_bb60:   brk                         ; 1FB60:  00
b07_bb61:   cmp $77                     ; 1FB61:  c5 77
b07_bb63:   .db $02                     ; 1FB63:  02
b07_bb64:   brk                         ; 1FB64:  00
b07_bb65:   brk                         ; 1FB65:  00
b07_bb66:   brk                         ; 1FB66:  00
b07_bb67:   brk                         ; 1FB67:  00
b07_bb68:   brk                         ; 1FB68:  00
b07_bb69:   brk                         ; 1FB69:  00
b07_bb6a:   brk                         ; 1FB6A:  00
b07_bb6b:   brk                         ; 1FB6B:  00
b07_bb6c:   ldx #$88                    ; 1FB6C:  a2 88
b07_bb6e:   ldx #$88                    ; 1FB6E:  a2 88
b07_bb70:   .db $22                     ; 1FB70:  22
b07_bb71:   php                         ; 1FB71:  08
b07_bb72:   .db $22                     ; 1FB72:  22
b07_bb73:   dey                         ; 1FB73:  88
b07_bb74:   brk                         ; 1FB74:  00
b07_bb75:   brk                         ; 1FB75:  00
b07_bb76:   brk                         ; 1FB76:  00
b07_bb77:   .db $04                     ; 1FB77:  04
b07_bb78:   asl $17                     ; 1FB78:  06 17
b07_bb7a:   .db $02                     ; 1FB7A:  02
b07_bb7b:   .db $3b                     ; 1FB7B:  3b
b07_bb7c:   jsr $2584                   ; 1FB7C:  20 84 25
b07_bb7f:   .db $82                     ; 1FB7F:  82
b07_bb80:   bpl $bb02                   ; 1FB80:  10 80
b07_bb82:   bpl $bb24                   ; 1FB82:  10 a0
b07_bb84:   brk                         ; 1FB84:  00
b07_bb85:   brk                         ; 1FB85:  00
b07_bb86:   asl $ba                     ; 1FB86:  06 ba
b07_bb88:   inc $6ebb                   ; 1FB88:  ee bb 6e
b07_bb8b:   .db $9b                     ; 1FB8B:  9b
b07_bb8c:   .db $22                     ; 1FB8C:  22
b07_bb8d:   .db $80                     ; 1FB8D:  80
b07_bb8e:   brk                         ; 1FB8E:  00
b07_bb8f:   ror $99                     ; 1FB8F:  66 99
b07_bb91:   ror $19                     ; 1FB91:  66 19
b07_bb93:   lsr $63                     ; 1FB93:  46 63
b07_bb95:   and $b8ed,y                 ; 1FB95:  39 ed b8
b07_bb98:   ror $ae3b                   ; 1FB98:  6e 3b ae
b07_bb9b:   .db $9b                     ; 1FB9B:  9b
b07_bb9c:   bpl $bc02                   ; 1FB9C:  10 64
b07_bb9e:   tya                         ; 1FB9E:  98
b07_bb9f:   .db $64                     ; 1FB9F:  64
b07_bba0:   ora $9966,y                 ; 1FBA0:  19 66 99
b07_bba3:   asl $1f                     ; 1FBA3:  06 1f
b07_bba5:   .db $0f                     ; 1FBA5:  0f
b07_bba6:   .db $0f                     ; 1FBA6:  0f
b07_bba7:   .db $27                     ; 1FBA7:  27
b07_bba8:   ora ($41,x)                 ; 1FBA8:  01 41
b07_bbaa:   .db $80                     ; 1FBAA:  80
b07_bbab:   .db $80                     ; 1FBAB:  80
b07_bbac:   jsr $1020                   ; 1FBAC:  20 20 10
b07_bbaf:   php                         ; 1FBAF:  08
b07_bbb0:   .db $04                     ; 1FBB0:  04
b07_bbb1:   .db $02                     ; 1FBB1:  02
b07_bbb2:   .db $02                     ; 1FBB2:  02
b07_bbb3:   brk                         ; 1FBB3:  00
b07_bbb4:   cpx #$01                    ; 1FBB4:  e0 01
b07_bbb6:   .db $c3                     ; 1FBB6:  c3
b07_bbb7:   .db $b2                     ; 1FBB7:  b2
b07_bbb8:   ror $3fff                   ; 1FBB8:  6e ff 3f
b07_bbbb:   rol $0000                   ; 1FBBB:  2e 00 00
b07_bbbe:   brk                         ; 1FBBE:  00
b07_bbbf:   brk                         ; 1FBBF:  00
b07_bbc0:   brk                         ; 1FBC0:  00
b07_bbc1:   brk                         ; 1FBC1:  00
b07_bbc2:   .db $80                     ; 1FBC2:  80
b07_bbc3:   brk                         ; 1FBC3:  00
b07_bbc4:   tay                         ; 1FBC4:  a8
b07_bbc5:   cpx #$f8                    ; 1FBC5:  e0 f8
b07_bbc7:   .db $fa                     ; 1FBC7:  fa
b07_bbc8:   rol $439f,x                 ; 1FBC8:  3e 9f 43
b07_bbcb:   dey                         ; 1FBCB:  88
b07_bbcc:   brk                         ; 1FBCC:  00
b07_bbcd:   brk                         ; 1FBCD:  00
b07_bbce:   .db $02                     ; 1FBCE:  02
b07_bbcf:   brk                         ; 1FBCF:  00
b07_bbd0:   brk                         ; 1FBD0:  00
b07_bbd1:   brk                         ; 1FBD1:  00
b07_bbd2:   brk                         ; 1FBD2:  00
b07_bbd3:   .db $44                     ; 1FBD3:  44
b07_bbd4:   ora ($00,x)                 ; 1FBD4:  01 00
b07_bbd6:   brk                         ; 1FBD6:  00
b07_bbd7:   brk                         ; 1FBD7:  00
b07_bbd8:   brk                         ; 1FBD8:  00
b07_bbd9:   cpy #$f0                    ; 1FBD9:  c0 f0
b07_bbdb:   sec                         ; 1FBDB:  38
b07_bbdc:   bit $0008                   ; 1FBDC:  2c 08 00
b07_bbdf:   tay                         ; 1FBDF:  a8
b07_bbe0:   ldy $34                     ; 1FBE0:  a4 34
b07_bbe2:   asl $e007                   ; 1FBE2:  0e 07 e0
b07_bbe5:   beq $bbe7                   ; 1FBE5:  f0 00
b07_bbe7:   brk                         ; 1FBE7:  00
b07_bbe8:   brk                         ; 1FBE8:  00
b07_bbe9:   rti                         ; 1FBE9:  40
b07_bbea:   beq $bbbc                   ; 1FBEA:  f0 d0
b07_bbec:   .db $02                     ; 1FBEC:  02
b07_bbed:   .db $02                     ; 1FBED:  02
b07_bbee:   bpl $bc42                   ; 1FBEE:  10 52
b07_bbf0:   tya                         ; 1FBF0:  98
b07_bbf1:   clc                         ; 1FBF1:  18
b07_bbf2:   asl a                       ; 1FBF2:  0a
b07_bbf3:   brk                         ; 1FBF3:  00
b07_bbf4:   brk                         ; 1FBF4:  00
b07_bbf5:   brk                         ; 1FBF5:  00
b07_bbf6:   brk                         ; 1FBF6:  00
b07_bbf7:   brk                         ; 1FBF7:  00
b07_bbf8:   .db $04                     ; 1FBF8:  04
b07_bbf9:   ora ($00),y                 ; 1FBF9:  11 00
b07_bbfb:   ora ($02),y                 ; 1FBFB:  11 02
b07_bbfd:   brk                         ; 1FBFD:  00
b07_bbfe:   .db $02                     ; 1FBFE:  02
b07_bbff:   brk                         ; 1FBFF:  00
b07_bc00:   eor ($80),y                 ; 1FC00:  51 80
b07_bc02:   sta ($04),y                 ; 1FC02:  91 04
b07_bc04:   brk                         ; 1FC04:  00
b07_bc05:   brk                         ; 1FC05:  00
b07_bc06:   brk                         ; 1FC06:  00
b07_bc07:   brk                         ; 1FC07:  00
b07_bc08:   brk                         ; 1FC08:  00
b07_bc09:   ora ($46),y                 ; 1FC09:  11 46
b07_bc0b:   ora $8822,y                 ; 1FC0B:  19 22 88
b07_bc0e:   .db $22                     ; 1FC0E:  22
b07_bc0f:   dey                         ; 1FC0F:  88
b07_bc10:   brk                         ; 1FC10:  00
b07_bc11:   .db $44                     ; 1FC11:  44
b07_bc12:   ora ($44),y                 ; 1FC12:  11 44
b07_bc14:   .db $22                     ; 1FC14:  22
b07_bc15:   ora ($88),y                 ; 1FC15:  11 88
b07_bc17:   .db $44                     ; 1FC17:  44
b07_bc18:   .db $22                     ; 1FC18:  22
b07_bc19:   ora ($88),y                 ; 1FC19:  11 88
b07_bc1b:   .db $44                     ; 1FC1B:  44
b07_bc1c:   inc $aa77                   ; 1FC1C:  ee 77 aa
b07_bc1f:   cmp $77ee,x                 ; 1FC1F:  dd ee 77
b07_bc22:   tax                         ; 1FC22:  aa
b07_bc23:   cmp $0020,x                 ; 1FC23:  dd 20 00
b07_bc26:   .db $80                     ; 1FC26:  80
b07_bc27:   rti                         ; 1FC27:  40
b07_bc28:   and ($11,x)                 ; 1FC28:  21 11
b07_bc2a:   .db $80                     ; 1FC2A:  80
b07_bc2b:   pha                         ; 1FC2B:  48
b07_bc2c:   cpx #$18                    ; 1FC2C:  e0 18
b07_bc2e:   sty $c2                     ; 1FC2E:  84 c2
b07_bc30:   sbc ($71,x)                 ; 1FC30:  e1 71
b07_bc32:   ldy #$c8                    ; 1FC32:  a0 c8
b07_bc34:   and $9d11                   ; 1FC34:  2d 11 9d
b07_bc37:   eor ($00,x)                 ; 1FC37:  41 00
b07_bc39:   .db $0c                     ; 1FC39:  0c
b07_bc3a:   .db $8f                     ; 1FC3A:  8f
b07_bc3b:   .db $1f                     ; 1FC3B:  1f
b07_bc3c:   sbc $9d51                   ; 1FC3C:  ed 51 9d
b07_bc3f:   cmp ($de,x)                 ; 1FC3F:  c1 de
b07_bc41:   .db $33                     ; 1FC41:  33
b07_bc42:   bcs $bbe4                   ; 1FC42:  b0 a0
b07_bc44:   .db $04                     ; 1FC44:  04
b07_bc45:   php                         ; 1FC45:  08
b07_bc46:   clc                         ; 1FC46:  18
b07_bc47:   bpl $bc6c                   ; 1FC47:  10 23
b07_bc49:   bit $28                     ; 1FC49:  24 28
b07_bc4b:   ora ($04,x)                 ; 1FC4B:  01 04
b07_bc4d:   php                         ; 1FC4D:  08
b07_bc4e:   clc                         ; 1FC4E:  18
b07_bc4f:   bpl $bc74                   ; 1FC4F:  10 23
b07_bc51:   bit $28                     ; 1FC51:  24 28
b07_bc53:   ora ($00,x)                 ; 1FC53:  01 00
b07_bc55:   .db $02                     ; 1FC55:  02
b07_bc56:   .db $34                     ; 1FC56:  34
b07_bc57:   cpx #$00                    ; 1FC57:  e0 00
b07_bc59:   brk                         ; 1FC59:  00
b07_bc5a:   brk                         ; 1FC5A:  00
b07_bc5b:   cpy #$00                    ; 1FC5B:  c0 00
b07_bc5d:   .db $02                     ; 1FC5D:  02
b07_bc5e:   .db $34                     ; 1FC5E:  34
b07_bc5f:   cpx #$00                    ; 1FC5F:  e0 00
b07_bc61:   brk                         ; 1FC61:  00
b07_bc62:   brk                         ; 1FC62:  00
b07_bc63:   cpy #$aa                    ; 1FC63:  c0 aa
b07_bc65:   iny                         ; 1FC65:  c8
b07_bc66:   .db $5b                     ; 1FC66:  5b
b07_bc67:   sei                         ; 1FC67:  78
b07_bc68:   .db $07                     ; 1FC68:  07
b07_bc69:   .db $0f                     ; 1FC69:  0f
b07_bc6a:   .db $ff                     ; 1FC6A:  ff
b07_bc6b:   .db $ff                     ; 1FC6B:  ff
b07_bc6c:   tax                         ; 1FC6C:  aa
b07_bc6d:   iny                         ; 1FC6D:  c8
b07_bc6e:   .db $5b                     ; 1FC6E:  5b
b07_bc6f:   sei                         ; 1FC6F:  78
b07_bc70:   brk                         ; 1FC70:  00
b07_bc71:   beq $bc73                   ; 1FC71:  f0 00
b07_bc73:   brk                         ; 1FC73:  00
b07_bc74:   cpy #$2f                    ; 1FC74:  c0 2f
b07_bc76:   .db $ef                     ; 1FC76:  ef
b07_bc77:   .db $07                     ; 1FC77:  07
b07_bc78:   sed                         ; 1FC78:  f8
b07_bc79:   inc $fffe,x                 ; 1FC79:  fe fe ff
b07_bc7c:   cpy #$2f                    ; 1FC7C:  c0 2f
b07_bc7e:   .db $ef                     ; 1FC7E:  ef
b07_bc7f:   .db $07                     ; 1FC7F:  07
b07_bc80:   brk                         ; 1FC80:  00
b07_bc81:   ora ($00,x)                 ; 1FC81:  01 00
b07_bc83:   brk                         ; 1FC83:  00
b07_bc84:   brk                         ; 1FC84:  00
b07_bc85:   .db $80                     ; 1FC85:  80
b07_bc86:   brk                         ; 1FC86:  00
b07_bc87:   brk                         ; 1FC87:  00
b07_bc88:   brk                         ; 1FC88:  00
b07_bc89:   ora ($00,x)                 ; 1FC89:  01 00
b07_bc8b:   brk                         ; 1FC8B:  00
b07_bc8c:   brk                         ; 1FC8C:  00
b07_bc8d:   nop                         ; 1FC8D:  ea
b07_bc8e:   brk                         ; 1FC8E:  00
b07_bc8f:   brk                         ; 1FC8F:  00
b07_bc90:   brk                         ; 1FC90:  00
b07_bc91:   ora ($00,x)                 ; 1FC91:  01 00
b07_bc93:   brk                         ; 1FC93:  00
b07_bc94:   .db $22                     ; 1FC94:  22
b07_bc95:   ora ($08),y                 ; 1FC95:  11 08
b07_bc97:   .db $04                     ; 1FC97:  04
b07_bc98:   .db $22                     ; 1FC98:  22
b07_bc99:   ora ($88),y                 ; 1FC99:  11 88
b07_bc9b:   .db $44                     ; 1FC9B:  44
b07_bc9c:   ror $0a97                   ; 1FC9C:  6e 97 0a
b07_bc9f:   ora $77ee,x                 ; 1FC9F:  1d ee 77
b07_bca2:   tax                         ; 1FCA2:  aa
b07_bca3:   eor $f000,x                 ; 1FCA3:  5d 00 f0
b07_bca6:   .db $ff                     ; 1FCA6:  ff
b07_bca7:   .db $ff                     ; 1FCA7:  ff
b07_bca8:   .db $1f                     ; 1FCA8:  1f
b07_bca9:   .db $03                     ; 1FCA9:  03
b07_bcaa:   brk                         ; 1FCAA:  00
b07_bcab:   .db $02                     ; 1FCAB:  02
b07_bcac:   brk                         ; 1FCAC:  00
b07_bcad:   beq $bcae                   ; 1FCAD:  f0 ff
b07_bcaf:   .db $ff                     ; 1FCAF:  ff
b07_bcb0:   .db $1f                     ; 1FCB0:  1f
b07_bcb1:   .db $83                     ; 1FCB1:  83
b07_bcb2:   brk                         ; 1FCB2:  00
b07_bcb3:   .db $c2                     ; 1FCB3:  c2
b07_bcb4:   .db $22                     ; 1FCB4:  22
b07_bcb5:   ora ($08),y                 ; 1FCB5:  11 08
b07_bcb7:   .db $44                     ; 1FCB7:  44
b07_bcb8:   .db $22                     ; 1FCB8:  22
b07_bcb9:   ora ($08),y                 ; 1FCB9:  11 08
b07_bcbb:   .db $44                     ; 1FCBB:  44
b07_bcbc:   ror $2a77                   ; 1FCBC:  6e 77 2a
b07_bcbf:   eor $776e,x                 ; 1FCBF:  5d 6e 77
b07_bcc2:   rol a                       ; 1FCC2:  2a
b07_bcc3:   eor $1903,x                 ; 1FCC3:  5d 03 19
b07_bcc6:   bcc $bce4                   ; 1FCC6:  90 1c
b07_bcc8:   .db $0c                     ; 1FCC8:  0c
b07_bcc9:   brk                         ; 1FCC9:  00
b07_bcca:   .db $92                     ; 1FCCA:  92
b07_bccb:   bpl $bc6d                   ; 1FCCB:  10 a0
b07_bccd:   .db $04                     ; 1FCCD:  04
b07_bcce:   ldx $d2a1                   ; 1FCCE:  ae a1 d2
b07_bcd1:   eor ($92,x)                 ; 1FCD1:  41 92
b07_bcd3:   ldy $3900                   ; 1FCD3:  ac 00 39
b07_bcd6:   and $1319,y                 ; 1FCD6:  39 19 13
b07_bcd9:   .db $03                     ; 1FCD9:  03
b07_bcda:   .db $83                     ; 1FCDA:  83
b07_bcdb:   rti                         ; 1FCDB:  40
b07_bcdc:   ror a                       ; 1FCDC:  6a
b07_bcdd:   .db $44                     ; 1FCDD:  44
b07_bcde:   .db $44                     ; 1FCDE:  44
b07_bcdf:   ldy $a8                     ; 1FCDF:  a4 a8
b07_bce1:   cli                         ; 1FCE1:  58
b07_bce2:   tya                         ; 1FCE2:  98
b07_bce3:   cpy $e9fc                   ; 1FCE3:  cc fc e9
b07_bce6:   cpx #$e1                    ; 1FCE6:  e0 e1
b07_bce8:   .db $f3                     ; 1FCE8:  f3
b07_bce9:   sei                         ; 1FCE9:  78
b07_bcea:   .db $fa                     ; 1FCEA:  fa
b07_bceb:   sbc $0000,y                 ; 1FCEB:  f9 00 00
b07_bcee:   .db $17                     ; 1FCEE:  17
b07_bcef:   .db $1a                     ; 1FCEF:  1a
b07_bcf0:   .db $04                     ; 1FCF0:  04
b07_bcf1:   brk                         ; 1FCF1:  00
b07_bcf2:   .db $02                     ; 1FCF2:  02
b07_bcf3:   asl $1f                     ; 1FCF3:  06 1f
b07_bcf5:   .db $f7                     ; 1FCF5:  f7
b07_bcf6:   .db $3f                     ; 1FCF6:  3f
b07_bcf7:   .db $ff                     ; 1FCF7:  ff
b07_bcf8:   .db $fb                     ; 1FCF8:  fb
b07_bcf9:   .db $0f                     ; 1FCF9:  0f
b07_bcfa:   .db $5b                     ; 1FCFA:  5b
b07_bcfb:   .db $ff                     ; 1FCFB:  ff
b07_bcfc:   brk                         ; 1FCFC:  00
b07_bcfd:   brk                         ; 1FCFD:  00
b07_bcfe:   cpy #$00                    ; 1FCFE:  c0 00
b07_bd00:   brk                         ; 1FD00:  00
b07_bd01:   brk                         ; 1FD01:  00
b07_bd02:   rti                         ; 1FD02:  40
b07_bd03:   brk                         ; 1FD03:  00
b07_bd04:   .db $fc                     ; 1FD04:  fc
b07_bd05:   inc $e7ff,x                 ; 1FD05:  fe ff e7
b07_bd08:   .db $fb                     ; 1FD08:  fb
b07_bd09:   .db $f3                     ; 1FD09:  f3
b07_bd0a:   sta ($0c,x)                 ; 1FD0A:  81 0c
b07_bd0c:   ora ($00,x)                 ; 1FD0C:  01 00
b07_bd0e:   brk                         ; 1FD0E:  00
b07_bd0f:   brk                         ; 1FD0F:  00
b07_bd10:   brk                         ; 1FD10:  00
b07_bd11:   php                         ; 1FD11:  08
b07_bd12:   .db $0c                     ; 1FD12:  0c
b07_bd13:   .db $32                     ; 1FD13:  32
b07_bd14:   .db $77                     ; 1FD14:  77
b07_bd15:   .db $0f                     ; 1FD15:  0f
b07_bd16:   .db $ff                     ; 1FD16:  ff
b07_bd17:   .db $ff                     ; 1FD17:  ff
b07_bd18:   .db $ff                     ; 1FD18:  ff
b07_bd19:   inc $60f8,x                 ; 1FD19:  fe f8 60
b07_bd1c:   .db $80                     ; 1FD1C:  80
b07_bd1d:   rts                         ; 1FD1D:  60
b07_bd1e:   brk                         ; 1FD1E:  00
b07_bd1f:   brk                         ; 1FD1F:  00
b07_bd20:   brk                         ; 1FD20:  00
b07_bd21:   brk                         ; 1FD21:  00
b07_bd22:   ora ($1d,x)                 ; 1FD22:  01 1d
b07_bd24:   sty $c0                     ; 1FD24:  84 c0
b07_bd26:   cpx #$e0                    ; 1FD26:  e0 e0
b07_bd28:   beq $bd0d                   ; 1FD28:  f0 e3
b07_bd2a:   .db $f4                     ; 1FD2A:  f4
b07_bd2b:   inx                         ; 1FD2B:  e8
b07_bd2c:   .db $04                     ; 1FD2C:  04
b07_bd2d:   brk                         ; 1FD2D:  00
b07_bd2e:   brk                         ; 1FD2E:  00
b07_bd2f:   brk                         ; 1FD2F:  00
b07_bd30:   brk                         ; 1FD30:  00
b07_bd31:   brk                         ; 1FD31:  00
b07_bd32:   brk                         ; 1FD32:  00
b07_bd33:   .db $03                     ; 1FD33:  03
b07_bd34:   .db $22                     ; 1FD34:  22
b07_bd35:   ora ($88),y                 ; 1FD35:  11 88
b07_bd37:   .db $44                     ; 1FD37:  44
b07_bd38:   .db $22                     ; 1FD38:  22
b07_bd39:   cmp ($28),y                 ; 1FD39:  d1 28
b07_bd3b:   bit $6e                     ; 1FD3B:  24 6e
b07_bd3d:   .db $77                     ; 1FD3D:  77
b07_bd3e:   tax                         ; 1FD3E:  aa
b07_bd3f:   cmp $172e,x                 ; 1FD3F:  dd 2e 17
b07_bd42:   asl a                       ; 1FD42:  0a
b07_bd43:   sta $b8f0                   ; 1FD43:  8d f0 b8
b07_bd46:   clv                         ; 1FD46:  b8
b07_bd47:   bmi $bd82                   ; 1FD47:  30 39
b07_bd49:   ror $e0ee,x                 ; 1FD49:  7e ee e0
b07_bd4c:   .db $04                     ; 1FD4C:  04
b07_bd4d:   rti                         ; 1FD4D:  40
b07_bd4e:   .db $42                     ; 1FD4E:  42
b07_bd4f:   .db $43                     ; 1FD4F:  43
b07_bd50:   .db $42                     ; 1FD50:  42
b07_bd51:   .db $80                     ; 1FD51:  80
b07_bd52:   brk                         ; 1FD52:  00
b07_bd53:   ora ($22,x)                 ; 1FD53:  01 22
b07_bd55:   and ($68,x)                 ; 1FD55:  21 68
b07_bd57:   cpy $22                     ; 1FD57:  c4 22
b07_bd59:   ora ($88),y                 ; 1FD59:  11 88
b07_bd5b:   .db $44                     ; 1FD5B:  44
b07_bd5c:   stx $8a87                   ; 1FD5C:  8e 87 8a
b07_bd5f:   ora $772e,x                 ; 1FD5F:  1d 2e 77
b07_bd62:   tax                         ; 1FD62:  aa
b07_bd63:   cmp $0020,x                 ; 1FD63:  dd 20 00
b07_bd66:   .db $80                     ; 1FD66:  80
b07_bd67:   .db $43                     ; 1FD67:  43
b07_bd68:   jsr $8810                   ; 1FD68:  20 10 88
b07_bd6b:   rti                         ; 1FD6B:  40
b07_bd6c:   cpx $a069                   ; 1FD6C:  ec 69 a0
b07_bd6f:   cpy $73ee                   ; 1FD6F:  cc ee 73
b07_bd72:   lda #$c0                    ; 1FD72:  a9 c0
b07_bd74:   brk                         ; 1FD74:  00
b07_bd75:   inc $fefb                   ; 1FD75:  ee fb fe
b07_bd78:   .db $ff                     ; 1FD78:  ff
b07_bd79:   .db $ff                     ; 1FD79:  ff
b07_bd7a:   .db $ff                     ; 1FD7A:  ff
b07_bd7b:   .db $ff                     ; 1FD7B:  ff
b07_bd7c:   brk                         ; 1FD7C:  00
b07_bd7d:   inc $fefb                   ; 1FD7D:  ee fb fe
b07_bd80:   .db $ff                     ; 1FD80:  ff
b07_bd81:   .db $ff                     ; 1FD81:  ff
b07_bd82:   .db $ff                     ; 1FD82:  ff
b07_bd83:   .db $ff                     ; 1FD83:  ff
b07_bd84:   sec                         ; 1FD84:  38
b07_bd85:   cpx $ecb9                   ; 1FD85:  ec b9 ec
b07_bd88:   lda $f9eb,y                 ; 1FD88:  b9 eb f9
b07_bd8b:   .db $fb                     ; 1FD8B:  fb
b07_bd8c:   sec                         ; 1FD8C:  38
b07_bd8d:   cpx $ecb9                   ; 1FD8D:  ec b9 ec
b07_bd90:   lda $f9eb,y                 ; 1FD90:  b9 eb f9
b07_bd93:   .db $fb                     ; 1FD93:  fb
b07_bd94:   asl $00,x                   ; 1FD94:  16 00
b07_bd96:   .db $04                     ; 1FD96:  04
b07_bd97:   beq $bdb8                   ; 1FD97:  f0 1f
b07_bd99:   .db $0f                     ; 1FD99:  0f
b07_bd9a:   .db $0f                     ; 1FD9A:  0f
b07_bd9b:   .db $7f                     ; 1FD9B:  7f
b07_bd9c:   eor ($80,x)                 ; 1FD9C:  41 80
b07_bd9e:   brk                         ; 1FD9E:  00
b07_bd9f:   brk                         ; 1FD9F:  00
b07_bda0:   brk                         ; 1FDA0:  00
b07_bda1:   rti                         ; 1FDA1:  40
b07_bda2:   ldy #$80                    ; 1FDA2:  a0 80
b07_bda4:   and ($33),y                 ; 1FDA4:  31 33
b07_bda6:   .db $37                     ; 1FDA6:  37
b07_bda7:   .db $37                     ; 1FDA7:  37
b07_bda8:   cmp $f0f8,x                 ; 1FDA8:  dd f8 f0
b07_bdab:   sbc ($8a,x)                 ; 1FDAB:  e1 8a
b07_bdad:   dey                         ; 1FDAD:  88
b07_bdae:   php                         ; 1FDAE:  08
b07_bdaf:   php                         ; 1FDAF:  08
b07_bdb0:   brk                         ; 1FDB0:  00
b07_bdb1:   brk                         ; 1FDB1:  00
b07_bdb2:   ora $00                     ; 1FDB2:  05 00
b07_bdb4:   .db $7f                     ; 1FDB4:  7f
b07_bdb5:   adc $0028,x                 ; 1FDB5:  7d 28 00
b07_bdb8:   sty $00,x                   ; 1FDB8:  94 00
b07_bdba:   ora ($2b,x)                 ; 1FDBA:  01 2b
b07_bdbc:   .db $80                     ; 1FDBC:  80
b07_bdbd:   brk                         ; 1FDBD:  00
b07_bdbe:   brk                         ; 1FDBE:  00
b07_bdbf:   brk                         ; 1FDBF:  00
b07_bdc0:   .db $80                     ; 1FDC0:  80
b07_bdc1:   ora $28                     ; 1FDC1:  05 28
b07_bdc3:   brk                         ; 1FDC3:  00
b07_bdc4:   eor ($03,x)                 ; 1FDC4:  41 03
b07_bdc6:   .db $07                     ; 1FDC6:  07
b07_bdc7:   .db $1f                     ; 1FDC7:  1f
b07_bdc8:   rol $f87c,x                 ; 1FDC8:  3e 7c f8
b07_bdcb:   cpx #$04                    ; 1FDCB:  e0 04
b07_bdcd:   bmi $be3f                   ; 1FDCD:  30 70
b07_bdcf:   ldy #$c0                    ; 1FDCF:  a0 c0
b07_bdd1:   .db $80                     ; 1FDD1:  80
b07_bdd2:   brk                         ; 1FDD2:  00
b07_bdd3:   brk                         ; 1FDD3:  00
b07_bdd4:   .db $e2                     ; 1FDD4:  e2
b07_bdd5:   cmp ($82,x)                 ; 1FDD5:  c1 82
b07_bdd7:   .db $32                     ; 1FDD7:  32
b07_bdd8:   .db $37                     ; 1FDD8:  37
b07_bdd9:   .db $77                     ; 1FDD9:  77
b07_bdda:   .db $ef                     ; 1FDDA:  ef
b07_bddb:   .db $ef                     ; 1FDDB:  ef
b07_bddc:   asl a                       ; 1FDDC:  0a
b07_bddd:   ora $4a3a,y                 ; 1FDDD:  19 3a 4a
b07_bde0:   .db $47                     ; 1FDE0:  47
b07_bde1:   .db $87                     ; 1FDE1:  87
b07_bde2:   .db $0f                     ; 1FDE2:  0f
b07_bde3:   .db $0f                     ; 1FDE3:  0f
b07_bde4:   .db $22                     ; 1FDE4:  22
b07_bde5:   ora ($88),y                 ; 1FDE5:  11 88
b07_bde7:   .db $44                     ; 1FDE7:  44
b07_bde8:   .db $22                     ; 1FDE8:  22
b07_bde9:   ora ($80),y                 ; 1FDE9:  11 80
b07_bdeb:   clv                         ; 1FDEB:  b8
b07_bdec:   inc $aa77                   ; 1FDEC:  ee 77 aa
b07_bdef:   cmp $776e,x                 ; 1FDEF:  dd 6e 77
b07_bdf2:   .db $82                     ; 1FDF2:  82
b07_bdf3:   clv                         ; 1FDF3:  b8
b07_bdf4:   .db $df                     ; 1FDF4:  df
b07_bdf5:   .db $df                     ; 1FDF5:  df
b07_bdf6:   .db $bf                     ; 1FDF6:  bf
b07_bdf7:   .db $3f                     ; 1FDF7:  3f
b07_bdf8:   .db $7f                     ; 1FDF8:  7f
b07_bdf9:   ror $fefe,x                 ; 1FDF9:  7e fe fe
b07_bdfc:   .db $1f                     ; 1FDFC:  1f
b07_bdfd:   .db $1f                     ; 1FDFD:  1f
b07_bdfe:   .db $3f                     ; 1FDFE:  3f
b07_bdff:   .db $3f                     ; 1FDFF:  3f
b07_be00:   .db $7f                     ; 1FE00:  7f
b07_be01:   ror $fefe,x                 ; 1FE01:  7e fe fe
b07_be04:   .db $bf                     ; 1FE04:  bf
b07_be05:   .db $7f                     ; 1FE05:  7f
b07_be06:   .db $7f                     ; 1FE06:  7f
b07_be07:   .db $7f                     ; 1FE07:  7f
b07_be08:   .db $7f                     ; 1FE08:  7f
b07_be09:   .db $ff                     ; 1FE09:  ff
b07_be0a:   .db $ff                     ; 1FE0A:  ff
b07_be0b:   .db $ff                     ; 1FE0B:  ff
b07_be0c:   .db $bf                     ; 1FE0C:  bf
b07_be0d:   .db $7f                     ; 1FE0D:  7f
b07_be0e:   .db $7f                     ; 1FE0E:  7f
b07_be0f:   .db $7f                     ; 1FE0F:  7f
b07_be10:   .db $7f                     ; 1FE10:  7f
b07_be11:   .db $ff                     ; 1FE11:  ff
b07_be12:   .db $ff                     ; 1FE12:  ff
b07_be13:   .db $ff                     ; 1FE13:  ff
b07_be14:   .db $ff                     ; 1FE14:  ff
b07_be15:   .db $ff                     ; 1FE15:  ff
b07_be16:   .db $ff                     ; 1FE16:  ff
b07_be17:   .db $ff                     ; 1FE17:  ff
b07_be18:   .db $ff                     ; 1FE18:  ff
b07_be19:   .db $ff                     ; 1FE19:  ff
b07_be1a:   .db $ff                     ; 1FE1A:  ff
b07_be1b:   .db $ff                     ; 1FE1B:  ff
b07_be1c:   .db $ff                     ; 1FE1C:  ff
b07_be1d:   .db $ff                     ; 1FE1D:  ff
b07_be1e:   .db $ff                     ; 1FE1E:  ff
b07_be1f:   .db $ff                     ; 1FE1F:  ff
b07_be20:   .db $ff                     ; 1FE20:  ff
b07_be21:   .db $ff                     ; 1FE21:  ff
b07_be22:   .db $ff                     ; 1FE22:  ff
b07_be23:   .db $ff                     ; 1FE23:  ff
b07_be24:   .db $ff                     ; 1FE24:  ff
b07_be25:   .db $ff                     ; 1FE25:  ff
b07_be26:   .db $ff                     ; 1FE26:  ff
b07_be27:   .db $ff                     ; 1FE27:  ff
b07_be28:   .db $ff                     ; 1FE28:  ff
b07_be29:   .db $ff                     ; 1FE29:  ff
b07_be2a:   .db $ff                     ; 1FE2A:  ff
b07_be2b:   .db $ff                     ; 1FE2B:  ff
b07_be2c:   .db $ff                     ; 1FE2C:  ff
b07_be2d:   .db $ff                     ; 1FE2D:  ff
b07_be2e:   .db $ff                     ; 1FE2E:  ff
b07_be2f:   .db $ff                     ; 1FE2F:  ff
b07_be30:   .db $ff                     ; 1FE30:  ff
b07_be31:   .db $ff                     ; 1FE31:  ff
b07_be32:   .db $ff                     ; 1FE32:  ff
b07_be33:   .db $ff                     ; 1FE33:  ff
b07_be34:   .db $ff                     ; 1FE34:  ff
b07_be35:   .db $ff                     ; 1FE35:  ff
b07_be36:   .db $ff                     ; 1FE36:  ff
b07_be37:   .db $ff                     ; 1FE37:  ff
b07_be38:   .db $ff                     ; 1FE38:  ff
b07_be39:   .db $ff                     ; 1FE39:  ff
b07_be3a:   .db $ff                     ; 1FE3A:  ff
b07_be3b:   .db $ff                     ; 1FE3B:  ff
b07_be3c:   .db $ff                     ; 1FE3C:  ff
b07_be3d:   .db $ff                     ; 1FE3D:  ff
b07_be3e:   .db $ff                     ; 1FE3E:  ff
b07_be3f:   .db $ff                     ; 1FE3F:  ff
b07_be40:   .db $ff                     ; 1FE40:  ff
b07_be41:   .db $ff                     ; 1FE41:  ff
b07_be42:   .db $ff                     ; 1FE42:  ff
b07_be43:   .db $ff                     ; 1FE43:  ff
b07_be44:   .db $ff                     ; 1FE44:  ff
b07_be45:   .db $ff                     ; 1FE45:  ff
b07_be46:   .db $ff                     ; 1FE46:  ff
b07_be47:   .db $ff                     ; 1FE47:  ff
b07_be48:   .db $ff                     ; 1FE48:  ff
b07_be49:   .db $ff                     ; 1FE49:  ff
b07_be4a:   .db $ff                     ; 1FE4A:  ff
b07_be4b:   .db $ff                     ; 1FE4B:  ff
b07_be4c:   .db $ff                     ; 1FE4C:  ff
b07_be4d:   .db $ff                     ; 1FE4D:  ff
b07_be4e:   .db $ff                     ; 1FE4E:  ff
b07_be4f:   .db $ff                     ; 1FE4F:  ff
b07_be50:   .db $ff                     ; 1FE50:  ff
b07_be51:   .db $ff                     ; 1FE51:  ff
b07_be52:   .db $ff                     ; 1FE52:  ff
b07_be53:   .db $ff                     ; 1FE53:  ff
b07_be54:   .db $ff                     ; 1FE54:  ff
b07_be55:   .db $ff                     ; 1FE55:  ff
b07_be56:   .db $ff                     ; 1FE56:  ff
b07_be57:   .db $ff                     ; 1FE57:  ff
b07_be58:   .db $ff                     ; 1FE58:  ff
b07_be59:   .db $ff                     ; 1FE59:  ff
b07_be5a:   .db $ff                     ; 1FE5A:  ff
b07_be5b:   .db $ff                     ; 1FE5B:  ff
b07_be5c:   .db $ff                     ; 1FE5C:  ff
b07_be5d:   .db $ff                     ; 1FE5D:  ff
b07_be5e:   .db $ff                     ; 1FE5E:  ff
b07_be5f:   .db $ff                     ; 1FE5F:  ff
b07_be60:   .db $ff                     ; 1FE60:  ff
b07_be61:   .db $ff                     ; 1FE61:  ff
b07_be62:   .db $ff                     ; 1FE62:  ff
b07_be63:   .db $ff                     ; 1FE63:  ff
b07_be64:   .db $ff                     ; 1FE64:  ff
b07_be65:   .db $ff                     ; 1FE65:  ff
b07_be66:   .db $ff                     ; 1FE66:  ff
b07_be67:   .db $ff                     ; 1FE67:  ff
b07_be68:   .db $ff                     ; 1FE68:  ff
b07_be69:   .db $ff                     ; 1FE69:  ff
b07_be6a:   .db $ff                     ; 1FE6A:  ff
b07_be6b:   .db $ff                     ; 1FE6B:  ff
b07_be6c:   .db $ff                     ; 1FE6C:  ff
b07_be6d:   .db $ff                     ; 1FE6D:  ff
b07_be6e:   .db $ff                     ; 1FE6E:  ff
b07_be6f:   .db $ff                     ; 1FE6F:  ff
b07_be70:   .db $ff                     ; 1FE70:  ff
b07_be71:   .db $ff                     ; 1FE71:  ff
b07_be72:   .db $ff                     ; 1FE72:  ff
b07_be73:   .db $ff                     ; 1FE73:  ff
b07_be74:   .db $ff                     ; 1FE74:  ff
b07_be75:   .db $ff                     ; 1FE75:  ff
b07_be76:   .db $ff                     ; 1FE76:  ff
b07_be77:   .db $ff                     ; 1FE77:  ff
b07_be78:   .db $ff                     ; 1FE78:  ff
b07_be79:   .db $ff                     ; 1FE79:  ff
b07_be7a:   .db $ff                     ; 1FE7A:  ff
b07_be7b:   .db $ff                     ; 1FE7B:  ff
b07_be7c:   .db $ff                     ; 1FE7C:  ff
b07_be7d:   .db $ff                     ; 1FE7D:  ff
b07_be7e:   .db $ff                     ; 1FE7E:  ff
b07_be7f:   .db $ff                     ; 1FE7F:  ff
b07_be80:   .db $ff                     ; 1FE80:  ff
b07_be81:   .db $ff                     ; 1FE81:  ff
b07_be82:   .db $ff                     ; 1FE82:  ff
b07_be83:   .db $ff                     ; 1FE83:  ff
b07_be84:   .db $ff                     ; 1FE84:  ff
b07_be85:   .db $ff                     ; 1FE85:  ff
b07_be86:   .db $ff                     ; 1FE86:  ff
b07_be87:   .db $ff                     ; 1FE87:  ff
b07_be88:   .db $ff                     ; 1FE88:  ff
b07_be89:   .db $ff                     ; 1FE89:  ff
b07_be8a:   .db $ff                     ; 1FE8A:  ff
b07_be8b:   .db $ff                     ; 1FE8B:  ff
b07_be8c:   .db $ff                     ; 1FE8C:  ff
b07_be8d:   .db $ff                     ; 1FE8D:  ff
b07_be8e:   .db $ff                     ; 1FE8E:  ff
b07_be8f:   .db $ff                     ; 1FE8F:  ff
b07_be90:   .db $ff                     ; 1FE90:  ff
b07_be91:   .db $ff                     ; 1FE91:  ff
b07_be92:   .db $ff                     ; 1FE92:  ff
b07_be93:   .db $ff                     ; 1FE93:  ff
b07_be94:   .db $ff                     ; 1FE94:  ff
b07_be95:   .db $ff                     ; 1FE95:  ff
b07_be96:   .db $ff                     ; 1FE96:  ff
b07_be97:   .db $ff                     ; 1FE97:  ff
b07_be98:   .db $ff                     ; 1FE98:  ff
b07_be99:   .db $ff                     ; 1FE99:  ff
b07_be9a:   .db $ff                     ; 1FE9A:  ff
b07_be9b:   .db $ff                     ; 1FE9B:  ff
b07_be9c:   .db $ff                     ; 1FE9C:  ff
b07_be9d:   .db $ff                     ; 1FE9D:  ff
b07_be9e:   .db $ff                     ; 1FE9E:  ff
b07_be9f:   .db $ff                     ; 1FE9F:  ff
b07_bea0:   .db $ff                     ; 1FEA0:  ff
b07_bea1:   .db $ff                     ; 1FEA1:  ff
b07_bea2:   .db $ff                     ; 1FEA2:  ff
b07_bea3:   .db $ff                     ; 1FEA3:  ff
b07_bea4:   .db $ff                     ; 1FEA4:  ff
b07_bea5:   .db $ff                     ; 1FEA5:  ff
b07_bea6:   .db $ff                     ; 1FEA6:  ff
b07_bea7:   .db $ff                     ; 1FEA7:  ff
b07_bea8:   .db $ff                     ; 1FEA8:  ff
b07_bea9:   .db $ff                     ; 1FEA9:  ff
b07_beaa:   .db $ff                     ; 1FEAA:  ff
b07_beab:   .db $ff                     ; 1FEAB:  ff
b07_beac:   .db $ff                     ; 1FEAC:  ff
b07_bead:   .db $ff                     ; 1FEAD:  ff
b07_beae:   .db $ff                     ; 1FEAE:  ff
b07_beaf:   .db $ff                     ; 1FEAF:  ff
b07_beb0:   .db $ff                     ; 1FEB0:  ff
b07_beb1:   .db $ff                     ; 1FEB1:  ff
b07_beb2:   .db $ff                     ; 1FEB2:  ff
b07_beb3:   .db $ff                     ; 1FEB3:  ff
b07_beb4:   .db $ff                     ; 1FEB4:  ff
b07_beb5:   .db $ff                     ; 1FEB5:  ff
b07_beb6:   .db $ff                     ; 1FEB6:  ff
b07_beb7:   .db $ff                     ; 1FEB7:  ff
b07_beb8:   .db $ff                     ; 1FEB8:  ff
b07_beb9:   .db $ff                     ; 1FEB9:  ff
b07_beba:   .db $ff                     ; 1FEBA:  ff
b07_bebb:   .db $ff                     ; 1FEBB:  ff
b07_bebc:   .db $ff                     ; 1FEBC:  ff
b07_bebd:   .db $ff                     ; 1FEBD:  ff
b07_bebe:   .db $ff                     ; 1FEBE:  ff
b07_bebf:   .db $ff                     ; 1FEBF:  ff
b07_bec0:   .db $ff                     ; 1FEC0:  ff
b07_bec1:   .db $ff                     ; 1FEC1:  ff
b07_bec2:   .db $ff                     ; 1FEC2:  ff
b07_bec3:   .db $ff                     ; 1FEC3:  ff
b07_bec4:   .db $ff                     ; 1FEC4:  ff
b07_bec5:   .db $ff                     ; 1FEC5:  ff
b07_bec6:   .db $ff                     ; 1FEC6:  ff
b07_bec7:   .db $ff                     ; 1FEC7:  ff
b07_bec8:   .db $ff                     ; 1FEC8:  ff
b07_bec9:   .db $ff                     ; 1FEC9:  ff
b07_beca:   .db $ff                     ; 1FECA:  ff
b07_becb:   .db $ff                     ; 1FECB:  ff
b07_becc:   .db $ff                     ; 1FECC:  ff
b07_becd:   .db $ff                     ; 1FECD:  ff
b07_bece:   .db $ff                     ; 1FECE:  ff
b07_becf:   .db $ff                     ; 1FECF:  ff
b07_bed0:   .db $ff                     ; 1FED0:  ff
b07_bed1:   .db $ff                     ; 1FED1:  ff
b07_bed2:   .db $ff                     ; 1FED2:  ff
b07_bed3:   .db $ff                     ; 1FED3:  ff
b07_bed4:   .db $ff                     ; 1FED4:  ff
b07_bed5:   .db $ff                     ; 1FED5:  ff
b07_bed6:   .db $ff                     ; 1FED6:  ff
b07_bed7:   .db $ff                     ; 1FED7:  ff
b07_bed8:   .db $ff                     ; 1FED8:  ff
b07_bed9:   .db $ff                     ; 1FED9:  ff
b07_beda:   .db $ff                     ; 1FEDA:  ff
b07_bedb:   .db $ff                     ; 1FEDB:  ff
b07_bedc:   .db $ff                     ; 1FEDC:  ff
b07_bedd:   .db $ff                     ; 1FEDD:  ff
b07_bede:   .db $ff                     ; 1FEDE:  ff
b07_bedf:   .db $ff                     ; 1FEDF:  ff
b07_bee0:   .db $ff                     ; 1FEE0:  ff
b07_bee1:   .db $ff                     ; 1FEE1:  ff
b07_bee2:   .db $ff                     ; 1FEE2:  ff
b07_bee3:   .db $ff                     ; 1FEE3:  ff
b07_bee4:   .db $ff                     ; 1FEE4:  ff
b07_bee5:   .db $ff                     ; 1FEE5:  ff
b07_bee6:   .db $ff                     ; 1FEE6:  ff
b07_bee7:   .db $ff                     ; 1FEE7:  ff
b07_bee8:   .db $ff                     ; 1FEE8:  ff
b07_bee9:   .db $ff                     ; 1FEE9:  ff
b07_beea:   .db $ff                     ; 1FEEA:  ff
b07_beeb:   .db $ff                     ; 1FEEB:  ff
b07_beec:   .db $ff                     ; 1FEEC:  ff
b07_beed:   .db $ff                     ; 1FEED:  ff
b07_beee:   .db $ff                     ; 1FEEE:  ff
b07_beef:   .db $ff                     ; 1FEEF:  ff
b07_bef0:   .db $ff                     ; 1FEF0:  ff
b07_bef1:   .db $ff                     ; 1FEF1:  ff
b07_bef2:   .db $ff                     ; 1FEF2:  ff
b07_bef3:   .db $ff                     ; 1FEF3:  ff
b07_bef4:   .db $ff                     ; 1FEF4:  ff
b07_bef5:   .db $ff                     ; 1FEF5:  ff
b07_bef6:   .db $ff                     ; 1FEF6:  ff
b07_bef7:   .db $ff                     ; 1FEF7:  ff
b07_bef8:   .db $ff                     ; 1FEF8:  ff
b07_bef9:   .db $ff                     ; 1FEF9:  ff
b07_befa:   .db $ff                     ; 1FEFA:  ff
b07_befb:   .db $ff                     ; 1FEFB:  ff
b07_befc:   .db $ff                     ; 1FEFC:  ff
b07_befd:   .db $ff                     ; 1FEFD:  ff
b07_befe:   .db $ff                     ; 1FEFE:  ff
b07_beff:   .db $ff                     ; 1FEFF:  ff
b07_bf00:   .db $ff                     ; 1FF00:  ff
b07_bf01:   .db $ff                     ; 1FF01:  ff
b07_bf02:   .db $ff                     ; 1FF02:  ff
b07_bf03:   .db $ff                     ; 1FF03:  ff
b07_bf04:   .db $ff                     ; 1FF04:  ff
b07_bf05:   .db $ff                     ; 1FF05:  ff
b07_bf06:   .db $ff                     ; 1FF06:  ff
b07_bf07:   .db $ff                     ; 1FF07:  ff
b07_bf08:   .db $ff                     ; 1FF08:  ff
b07_bf09:   .db $ff                     ; 1FF09:  ff
b07_bf0a:   .db $ff                     ; 1FF0A:  ff
b07_bf0b:   .db $ff                     ; 1FF0B:  ff
b07_bf0c:   .db $ff                     ; 1FF0C:  ff
b07_bf0d:   .db $ff                     ; 1FF0D:  ff
b07_bf0e:   .db $ff                     ; 1FF0E:  ff
b07_bf0f:   .db $ff                     ; 1FF0F:  ff
b07_bf10:   .db $ff                     ; 1FF10:  ff
b07_bf11:   .db $ff                     ; 1FF11:  ff
b07_bf12:   .db $ff                     ; 1FF12:  ff
b07_bf13:   .db $ff                     ; 1FF13:  ff
b07_bf14:   .db $ff                     ; 1FF14:  ff
b07_bf15:   .db $ff                     ; 1FF15:  ff
b07_bf16:   .db $ff                     ; 1FF16:  ff
b07_bf17:   .db $ff                     ; 1FF17:  ff
b07_bf18:   .db $ff                     ; 1FF18:  ff
b07_bf19:   .db $ff                     ; 1FF19:  ff
b07_bf1a:   .db $ff                     ; 1FF1A:  ff
b07_bf1b:   .db $ff                     ; 1FF1B:  ff
b07_bf1c:   .db $ff                     ; 1FF1C:  ff
b07_bf1d:   .db $ff                     ; 1FF1D:  ff
b07_bf1e:   .db $ff                     ; 1FF1E:  ff
b07_bf1f:   .db $ff                     ; 1FF1F:  ff
b07_bf20:   .db $ff                     ; 1FF20:  ff
b07_bf21:   .db $ff                     ; 1FF21:  ff
b07_bf22:   .db $ff                     ; 1FF22:  ff
b07_bf23:   .db $ff                     ; 1FF23:  ff
b07_bf24:   .db $ff                     ; 1FF24:  ff
b07_bf25:   .db $ff                     ; 1FF25:  ff
b07_bf26:   .db $ff                     ; 1FF26:  ff
b07_bf27:   .db $ff                     ; 1FF27:  ff
b07_bf28:   .db $ff                     ; 1FF28:  ff
b07_bf29:   .db $ff                     ; 1FF29:  ff
b07_bf2a:   .db $ff                     ; 1FF2A:  ff
b07_bf2b:   .db $ff                     ; 1FF2B:  ff
b07_bf2c:   .db $ff                     ; 1FF2C:  ff
b07_bf2d:   .db $ff                     ; 1FF2D:  ff
b07_bf2e:   .db $ff                     ; 1FF2E:  ff
b07_bf2f:   .db $ff                     ; 1FF2F:  ff
b07_bf30:   .db $ff                     ; 1FF30:  ff
b07_bf31:   .db $ff                     ; 1FF31:  ff
b07_bf32:   .db $ff                     ; 1FF32:  ff
b07_bf33:   .db $ff                     ; 1FF33:  ff
b07_bf34:   .db $ff                     ; 1FF34:  ff
b07_bf35:   .db $ff                     ; 1FF35:  ff
b07_bf36:   .db $ff                     ; 1FF36:  ff
b07_bf37:   .db $ff                     ; 1FF37:  ff
b07_bf38:   .db $ff                     ; 1FF38:  ff
b07_bf39:   .db $ff                     ; 1FF39:  ff
b07_bf3a:   .db $ff                     ; 1FF3A:  ff
b07_bf3b:   .db $ff                     ; 1FF3B:  ff
b07_bf3c:   .db $ff                     ; 1FF3C:  ff
b07_bf3d:   .db $ff                     ; 1FF3D:  ff
b07_bf3e:   .db $ff                     ; 1FF3E:  ff
b07_bf3f:   .db $ff                     ; 1FF3F:  ff
b07_bf40:   .db $ff                     ; 1FF40:  ff
b07_bf41:   .db $ff                     ; 1FF41:  ff
b07_bf42:   .db $ff                     ; 1FF42:  ff
b07_bf43:   .db $ff                     ; 1FF43:  ff
b07_bf44:   .db $ff                     ; 1FF44:  ff
b07_bf45:   .db $ff                     ; 1FF45:  ff
b07_bf46:   .db $ff                     ; 1FF46:  ff
b07_bf47:   .db $ff                     ; 1FF47:  ff
b07_bf48:   .db $ff                     ; 1FF48:  ff
b07_bf49:   .db $ff                     ; 1FF49:  ff
b07_bf4a:   .db $ff                     ; 1FF4A:  ff
b07_bf4b:   .db $ff                     ; 1FF4B:  ff
b07_bf4c:   .db $ff                     ; 1FF4C:  ff
b07_bf4d:   .db $ff                     ; 1FF4D:  ff
b07_bf4e:   .db $ff                     ; 1FF4E:  ff
b07_bf4f:   .db $ff                     ; 1FF4F:  ff
b07_bf50:   .db $ff                     ; 1FF50:  ff
b07_bf51:   .db $ff                     ; 1FF51:  ff
b07_bf52:   .db $ff                     ; 1FF52:  ff
b07_bf53:   .db $ff                     ; 1FF53:  ff
b07_bf54:   .db $ff                     ; 1FF54:  ff
b07_bf55:   .db $ff                     ; 1FF55:  ff
b07_bf56:   .db $ff                     ; 1FF56:  ff
b07_bf57:   .db $ff                     ; 1FF57:  ff
b07_bf58:   .db $ff                     ; 1FF58:  ff
b07_bf59:   .db $ff                     ; 1FF59:  ff
b07_bf5a:   .db $ff                     ; 1FF5A:  ff
b07_bf5b:   .db $ff                     ; 1FF5B:  ff
b07_bf5c:   .db $ff                     ; 1FF5C:  ff
b07_bf5d:   .db $ff                     ; 1FF5D:  ff
b07_bf5e:   .db $ff                     ; 1FF5E:  ff
b07_bf5f:   .db $ff                     ; 1FF5F:  ff
b07_bf60:   .db $ff                     ; 1FF60:  ff
b07_bf61:   .db $ff                     ; 1FF61:  ff
b07_bf62:   .db $ff                     ; 1FF62:  ff
b07_bf63:   .db $ff                     ; 1FF63:  ff
b07_bf64:   .db $ff                     ; 1FF64:  ff
b07_bf65:   .db $ff                     ; 1FF65:  ff
b07_bf66:   .db $ff                     ; 1FF66:  ff
b07_bf67:   .db $ff                     ; 1FF67:  ff
b07_bf68:   .db $ff                     ; 1FF68:  ff
b07_bf69:   .db $ff                     ; 1FF69:  ff
b07_bf6a:   .db $ff                     ; 1FF6A:  ff
b07_bf6b:   .db $ff                     ; 1FF6B:  ff
b07_bf6c:   .db $ff                     ; 1FF6C:  ff
b07_bf6d:   .db $ff                     ; 1FF6D:  ff
b07_bf6e:   .db $ff                     ; 1FF6E:  ff
b07_bf6f:   .db $ff                     ; 1FF6F:  ff
b07_bf70:   .db $ff                     ; 1FF70:  ff
b07_bf71:   .db $ff                     ; 1FF71:  ff
b07_bf72:   .db $ff                     ; 1FF72:  ff
b07_bf73:   .db $ff                     ; 1FF73:  ff
b07_bf74:   .db $ff                     ; 1FF74:  ff
b07_bf75:   .db $ff                     ; 1FF75:  ff
b07_bf76:   .db $ff                     ; 1FF76:  ff
b07_bf77:   .db $ff                     ; 1FF77:  ff
b07_bf78:   .db $ff                     ; 1FF78:  ff
b07_bf79:   .db $ff                     ; 1FF79:  ff
b07_bf7a:   .db $ff                     ; 1FF7A:  ff
b07_bf7b:   .db $ff                     ; 1FF7B:  ff
b07_bf7c:   .db $ff                     ; 1FF7C:  ff
b07_bf7d:   .db $ff                     ; 1FF7D:  ff
b07_bf7e:   .db $ff                     ; 1FF7E:  ff
b07_bf7f:   .db $ff                     ; 1FF7F:  ff
b07_bf80:   .db $ff                     ; 1FF80:  ff
b07_bf81:   .db $ff                     ; 1FF81:  ff
b07_bf82:   .db $ff                     ; 1FF82:  ff
b07_bf83:   .db $ff                     ; 1FF83:  ff
b07_bf84:   .db $ff                     ; 1FF84:  ff
b07_bf85:   .db $ff                     ; 1FF85:  ff
b07_bf86:   .db $ff                     ; 1FF86:  ff
b07_bf87:   .db $ff                     ; 1FF87:  ff
b07_bf88:   .db $ff                     ; 1FF88:  ff
b07_bf89:   .db $ff                     ; 1FF89:  ff
b07_bf8a:   .db $ff                     ; 1FF8A:  ff
b07_bf8b:   .db $ff                     ; 1FF8B:  ff
b07_bf8c:   .db $ff                     ; 1FF8C:  ff
b07_bf8d:   .db $ff                     ; 1FF8D:  ff
b07_bf8e:   .db $ff                     ; 1FF8E:  ff
b07_bf8f:   .db $ff                     ; 1FF8F:  ff
b07_bf90:   .db $ff                     ; 1FF90:  ff
b07_bf91:   .db $ff                     ; 1FF91:  ff
b07_bf92:   .db $ff                     ; 1FF92:  ff
b07_bf93:   .db $ff                     ; 1FF93:  ff
b07_bf94:   .db $ff                     ; 1FF94:  ff
b07_bf95:   .db $ff                     ; 1FF95:  ff
b07_bf96:   .db $ff                     ; 1FF96:  ff
b07_bf97:   .db $ff                     ; 1FF97:  ff
b07_bf98:   .db $ff                     ; 1FF98:  ff
b07_bf99:   .db $ff                     ; 1FF99:  ff
b07_bf9a:   .db $ff                     ; 1FF9A:  ff
b07_bf9b:   .db $ff                     ; 1FF9B:  ff
b07_bf9c:   .db $ff                     ; 1FF9C:  ff
b07_bf9d:   .db $ff                     ; 1FF9D:  ff
b07_bf9e:   .db $ff                     ; 1FF9E:  ff
b07_bf9f:   .db $ff                     ; 1FF9F:  ff
b07_bfa0:   .db $ff                     ; 1FFA0:  ff
b07_bfa1:   .db $ff                     ; 1FFA1:  ff
b07_bfa2:   .db $ff                     ; 1FFA2:  ff
b07_bfa3:   .db $ff                     ; 1FFA3:  ff
b07_bfa4:   .db $ff                     ; 1FFA4:  ff
b07_bfa5:   .db $ff                     ; 1FFA5:  ff
b07_bfa6:   .db $ff                     ; 1FFA6:  ff
b07_bfa7:   .db $ff                     ; 1FFA7:  ff
b07_bfa8:   .db $ff                     ; 1FFA8:  ff
b07_bfa9:   .db $ff                     ; 1FFA9:  ff
b07_bfaa:   .db $ff                     ; 1FFAA:  ff
b07_bfab:   .db $ff                     ; 1FFAB:  ff
b07_bfac:   .db $ff                     ; 1FFAC:  ff
b07_bfad:   .db $ff                     ; 1FFAD:  ff
b07_bfae:   .db $ff                     ; 1FFAE:  ff
b07_bfaf:   .db $ff                     ; 1FFAF:  ff
b07_bfb0:   .db $ff                     ; 1FFB0:  ff
b07_bfb1:   .db $ff                     ; 1FFB1:  ff
b07_bfb2:   .db $ff                     ; 1FFB2:  ff
b07_bfb3:   .db $ff                     ; 1FFB3:  ff
b07_bfb4:   .db $ff                     ; 1FFB4:  ff
b07_bfb5:   .db $ff                     ; 1FFB5:  ff
b07_bfb6:   .db $ff                     ; 1FFB6:  ff
b07_bfb7:   .db $ff                     ; 1FFB7:  ff
b07_bfb8:   .db $ff                     ; 1FFB8:  ff
b07_bfb9:   .db $ff                     ; 1FFB9:  ff
b07_bfba:   .db $ff                     ; 1FFBA:  ff
b07_bfbb:   .db $ff                     ; 1FFBB:  ff
b07_bfbc:   .db $ff                     ; 1FFBC:  ff
b07_bfbd:   .db $ff                     ; 1FFBD:  ff
b07_bfbe:   .db $ff                     ; 1FFBE:  ff
b07_bfbf:   .db $ff                     ; 1FFBF:  ff
b07_bfc0:   .db $ff                     ; 1FFC0:  ff
b07_bfc1:   .db $ff                     ; 1FFC1:  ff
b07_bfc2:   .db $ff                     ; 1FFC2:  ff
b07_bfc3:   .db $ff                     ; 1FFC3:  ff
b07_bfc4:   .db $ff                     ; 1FFC4:  ff
b07_bfc5:   .db $ff                     ; 1FFC5:  ff
b07_bfc6:   .db $ff                     ; 1FFC6:  ff
b07_bfc7:   .db $ff                     ; 1FFC7:  ff
b07_bfc8:   .db $ff                     ; 1FFC8:  ff
b07_bfc9:   .db $ff                     ; 1FFC9:  ff
b07_bfca:   .db $ff                     ; 1FFCA:  ff
b07_bfcb:   .db $ff                     ; 1FFCB:  ff
b07_bfcc:   .db $ff                     ; 1FFCC:  ff
b07_bfcd:   .db $ff                     ; 1FFCD:  ff
b07_bfce:   .db $ff                     ; 1FFCE:  ff
b07_bfcf:   .db $ff                     ; 1FFCF:  ff
b07_bfd0:   .db $ff                     ; 1FFD0:  ff
b07_bfd1:   .db $ff                     ; 1FFD1:  ff
b07_bfd2:   .db $ff                     ; 1FFD2:  ff
b07_bfd3:   .db $ff                     ; 1FFD3:  ff
b07_bfd4:   .db $ff                     ; 1FFD4:  ff
b07_bfd5:   .db $ff                     ; 1FFD5:  ff
b07_bfd6:   .db $ff                     ; 1FFD6:  ff
b07_bfd7:   .db $ff                     ; 1FFD7:  ff
b07_bfd8:   .db $ff                     ; 1FFD8:  ff
b07_bfd9:   .db $ff                     ; 1FFD9:  ff
b07_bfda:   .db $ff                     ; 1FFDA:  ff
b07_bfdb:   .db $ff                     ; 1FFDB:  ff
b07_bfdc:   .db $ff                     ; 1FFDC:  ff
b07_bfdd:   .db $ff                     ; 1FFDD:  ff
b07_bfde:   .db $ff                     ; 1FFDE:  ff
b07_bfdf:   .db $ff                     ; 1FFDF:  ff
b07_bfe0:   .db $ff                     ; 1FFE0:  ff
b07_bfe1:   .db $ff                     ; 1FFE1:  ff
b07_bfe2:   .db $ff                     ; 1FFE2:  ff
b07_bfe3:   .db $ff                     ; 1FFE3:  ff
b07_bfe4:   .db $ff                     ; 1FFE4:  ff
b07_bfe5:   .db $ff                     ; 1FFE5:  ff
b07_bfe6:   .db $ff                     ; 1FFE6:  ff
b07_bfe7:   .db $ff                     ; 1FFE7:  ff
b07_bfe8:   .db $ff                     ; 1FFE8:  ff
b07_bfe9:   .db $ff                     ; 1FFE9:  ff
b07_bfea:   .db $ff                     ; 1FFEA:  ff
b07_bfeb:   .db $ff                     ; 1FFEB:  ff
b07_bfec:   .db $ff                     ; 1FFEC:  ff
b07_bfed:   .db $ff                     ; 1FFED:  ff
b07_bfee:   .db $ff                     ; 1FFEE:  ff
b07_bfef:   .db $ff                     ; 1FFEF:  ff
b07_bff0:   .db $ff                     ; 1FFF0:  ff
b07_bff1:   .db $ff                     ; 1FFF1:  ff
b07_bff2:   .db $ff                     ; 1FFF2:  ff
b07_bff3:   .db $ff                     ; 1FFF3:  ff
b07_bff4:   .db $ff                     ; 1FFF4:  ff
b07_bff5:   .db $ff                     ; 1FFF5:  ff
b07_bff6:   .db $ff                     ; 1FFF6:  ff
b07_bff7:   .db $ff                     ; 1FFF7:  ff
b07_bff8:   .db $ff                     ; 1FFF8:  ff
b07_bff9:   .db $ff                     ; 1FFF9:  ff
b07_bffa:   .db $ff                     ; 1FFFA:  ff
b07_bffb:   .db $ff                     ; 1FFFB:  ff
b07_bffc:   .db $ff                     ; 1FFFC:  ff
b07_bffd:   .db $ff                     ; 1FFFD:  ff
b07_bffe:   .db $ff                     ; 1FFFE:  ff
b07_bfff:   .db $ff                     ; 1FFFF:  ff
