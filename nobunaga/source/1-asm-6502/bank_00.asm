.base $8000

b00_8000:   jmp $a778                   ; 0:  4c 78 a7
b00_8003:   jsr $e823                   ; 3:  20 23 e8
b00_8006:   .db $fa                     ; 6:  fa
b00_8007:   .db $ff                     ; 7:  ff
b00_8008:   rts                         ; 8:  60
b00_8009:   rts                         ; 9:  60
b00_800a:   ror a                       ; A:  6a
b00_800b:   sbc #$26                    ; B:  e9 26
b00_800d:   .db $f2                     ; D:  f2
b00_800e:   asl $ac                     ; E:  06 ac
b00_8010:   jsr $accd                   ; 10:  20 cd ac
b00_8013:   plp                         ; 13:  28
b00_8014:   dec $d8,x                   ; 14:  d6 d8
b00_8016:   .db $1c                     ; 16:  1c
b00_8017:   sta ($61,x)                 ; 17:  81 61
b00_8019:   sbc #$35                    ; 19:  e9 35
b00_801b:   cpy $8e02                   ; 1B:  cc 02 8e
b00_801e:   ldx $8e00                   ; 1E:  ae 00 8e
b00_8021:   bpl $8038                   ; 21:  10 15
b00_8023:   stx $9054                   ; 23:  8e 54 90
b00_8026:   ror $e9                     ; 26:  66 e9
b00_8028:   .db $7c                     ; 28:  7c
b00_8029:   .db $cf                     ; 29:  cf
b00_802a:   php                         ; 2A:  08
b00_802b:   ror $8e                     ; 2B:  66 8e
b00_802d:   .db $74                     ; 2D:  74
b00_802e:   sta $168d                   ; 2E:  8d 8d 16
b00_8031:   sta $601f                   ; 31:  8d 1f 60
b00_8034:   rts                         ; 34:  60
b00_8035:   sbc #$54                    ; 35:  e9 54
b00_8037:   cpy $610c                   ; 37:  cc 0c 61
b00_803a:   adc $118d                   ; 3A:  6d 8d 11
b00_803d:   pla                         ; 3D:  68
b00_803e:   sta $e910                   ; 3E:  8d 10 e9
b00_8041:   ror a                       ; 41:  6a
b00_8042:   .db $cf                     ; 42:  cf
b00_8043:   asl a                       ; 43:  0a
b00_8044:   adc ($8d,x)                 ; 44:  61 8d
b00_8046:   .db $1a                     ; 46:  1a
b00_8047:   sta $8d1f                   ; 47:  8d 1f 8d
b00_804a:   clc                         ; 4A:  18
b00_804b:   .db $62                     ; 4B:  62
b00_804c:   sbc #$6a                    ; 4C:  e9 6a
b00_804e:   .db $cf                     ; 4E:  cf
b00_804f:   asl a                       ; 4F:  0a
b00_8050:   rti                         ; 50:  40
b00_8051:   .db $2b                     ; 51:  2b
b00_8052:   .db $0b                     ; 52:  0b
b00_8053:   sty $b7ca                   ; 53:  8c ca b7
b00_8056:   .db $bb                     ; 56:  bb
b00_8057:   .db $d3                     ; 57:  d3
b00_8058:   .db $b3                     ; 58:  b3
b00_8059:   .db $3b                     ; 59:  3b
b00_805a:   sbc #$8b                    ; 5A:  e9 8b
b00_805c:   .db $cf                     ; 5C:  cf
b00_805d:   .db $04                     ; 5D:  04
b00_805e:   .db $0b                     ; 5E:  0b
b00_805f:   bne $808c                   ; 5F:  d0 2b
b00_8061:   .db $0b                     ; 61:  0b
b00_8062:   cli                         ; 62:  58
b00_8063:   dec $d7                     ; 63:  c6 d7
b00_8065:   .db $52                     ; 65:  52
b00_8066:   .db $80                     ; 66:  80
b00_8067:   rts                         ; 67:  60
b00_8068:   sbc #$35                    ; 68:  e9 35
b00_806a:   cpy $8d02                   ; 6A:  cc 02 8d
b00_806d:   clc                         ; 6D:  18
b00_806e:   .db $62                     ; 6E:  62
b00_806f:   sbc #$7b                    ; 6F:  e9 7b
b00_8071:   cpy $8e04                   ; 71:  cc 04 8e
b00_8074:   .db $da                     ; 74:  da
b00_8075:   .db $b7                     ; 75:  b7
b00_8076:   sbc #$c4                    ; 76:  e9 c4
b00_8078:   dec $aa02                   ; 78:  ce 02 aa
b00_807b:   .db $9f                     ; 7B:  9f
b00_807c:   adc $f48e                   ; 7C:  6d 8e f4
b00_807f:   .db $b7                     ; 7F:  b7
b00_8080:   sbc #$34                    ; 80:  e9 34
b00_8082:   cmp ($04),y                 ; 82:  d1 04
b00_8084:   stx $b805                   ; 84:  8e 05 b8
b00_8087:   sbc #$c4                    ; 87:  e9 c4
b00_8089:   dec $6502                   ; 89:  ce 02 65
b00_808c:   sbc #$03                    ; 8C:  e9 03
b00_808e:   dex                         ; 8E:  ca
b00_808f:   .db $02                     ; 8F:  02
b00_8090:   ldy $4d                     ; 90:  a4 4d
b00_8092:   .db $6f                     ; 92:  6f
b00_8093:   .db $d7                     ; 93:  d7
b00_8094:   clv                         ; 94:  b8
b00_8095:   .db $80                     ; 95:  80
b00_8096:   ldy $d759                   ; 96:  ac 59 d7
b00_8099:   rti                         ; 99:  40
b00_809a:   tay                         ; 9A:  a8
b00_809b:   .db $d3                     ; 9B:  d3
b00_809c:   .db $7f                     ; 9C:  7f
b00_809d:   txa                         ; 9D:  8a
b00_809e:   .db $ff                     ; 9E:  ff
b00_809f:   brk                         ; 9F:  00
b00_80a0:   tay                         ; A0:  a8
b00_80a1:   .db $df                     ; A1:  df
b00_80a2:   .db $7f                     ; A2:  7f
b00_80a3:   rts                         ; A3:  60
b00_80a4:   ror $e9                     ; A4:  66 e9
b00_80a6:   rol $f2                     ; A6:  26 f2
b00_80a8:   .db $04                     ; A8:  04
b00_80a9:   .db $d7                     ; A9:  d7
b00_80aa:   .db $a3                     ; AA:  a3
b00_80ab:   .db $80                     ; AB:  80
b00_80ac:   adc ($66,x)                 ; AC:  61 66
b00_80ae:   sbc #$26                    ; AE:  e9 26
b00_80b0:   .db $f2                     ; B0:  f2
b00_80b1:   .db $04                     ; B1:  04
b00_80b2:   cld                         ; B2:  d8
b00_80b3:   cmp $80                     ; B3:  c5 80
b00_80b5:   dec $a3,x                   ; B5:  d6 a3
b00_80b7:   .db $80                     ; B7:  80
b00_80b8:   .db $62                     ; B8:  62
b00_80b9:   adc ($6a,x)                 ; B9:  61 6a
b00_80bb:   sbc #$26                    ; BB:  e9 26
b00_80bd:   .db $f2                     ; BD:  f2
b00_80be:   asl $d8                     ; BE:  06 d8
b00_80c0:   sta $d680,y                 ; C0:  99 80 d6
b00_80c3:   clv                         ; C3:  b8
b00_80c4:   .db $80                     ; C4:  80
b00_80c5:   rts                         ; C5:  60
b00_80c6:   ror $e9                     ; C6:  66 e9
b00_80c8:   rol $f2                     ; C8:  26 f2
b00_80ca:   .db $04                     ; CA:  04
b00_80cb:   .db $d7                     ; CB:  d7
b00_80cc:   .db $d7                     ; CC:  d7
b00_80cd:   .db $80                     ; CD:  80
b00_80ce:   adc ($66,x)                 ; CE:  61 66
b00_80d0:   sbc #$26                    ; D0:  e9 26
b00_80d2:   .db $f2                     ; D2:  f2
b00_80d3:   .db $04                     ; D3:  04
b00_80d4:   cld                         ; D4:  d8
b00_80d5:   cmp $80                     ; D5:  c5 80
b00_80d7:   adc ($e9,x)                 ; D7:  61 e9
b00_80d9:   and $cc,x                   ; D9:  35 cc
b00_80db:   .db $02                     ; DB:  02
b00_80dc:   stx $00fe                   ; DC:  8e fe 00
b00_80df:   stx $1000                   ; DF:  8e 00 10
b00_80e2:   stx $9d04                   ; E2:  8e 04 9d
b00_80e5:   ror $e9                     ; E5:  66 e9
b00_80e7:   .db $7c                     ; E7:  7c
b00_80e8:   .db $cf                     ; E8:  cf
b00_80e9:   php                         ; E9:  08
b00_80ea:   rts                         ; EA:  60
b00_80eb:   rts                         ; EB:  60
b00_80ec:   adc $e9                     ; EC:  65 e9
b00_80ee:   rol $f2                     ; EE:  26 f2
b00_80f0:   asl $ac                     ; F0:  06 ac
b00_80f2:   eor $66cf,x                 ; F2:  5d cf 66
b00_80f5:   stx $9b24                   ; F5:  8e 24 9b
b00_80f8:   sta $8d13                   ; F8:  8d 13 8d
b00_80fb:   .db $1f                     ; FB:  1f
b00_80fc:   adc $60                     ; FC:  65 60
b00_80fe:   sbc #$54                    ; FE:  e9 54
b00_8100:   cpy $400c                   ; 100:  cc 0c 40
b00_8103:   .db $2b                     ; 103:  2b
b00_8104:   .db $0b                     ; 104:  0b
b00_8105:   sty $b7d2                   ; 105:  8c d2 b7
b00_8108:   .db $bb                     ; 108:  bb
b00_8109:   .db $d3                     ; 109:  d3
b00_810a:   .db $b3                     ; 10A:  b3
b00_810b:   .db $3b                     ; 10B:  3b
b00_810c:   sbc #$8b                    ; 10C:  e9 8b
b00_810e:   .db $cf                     ; 10E:  cf
b00_810f:   .db $04                     ; 10F:  04
b00_8110:   .db $0b                     ; 110:  0b
b00_8111:   bne $813e                   ; 111:  d0 2b
b00_8113:   .db $0b                     ; 113:  0b
b00_8114:   .db $54                     ; 114:  54
b00_8115:   dec $d7                     ; 115:  c6 d7
b00_8117:   .db $04                     ; 117:  04
b00_8118:   sta ($d6,x)                 ; 118:  81 d6
b00_811a:   lda ($81),y                 ; 11A:  b1 81
b00_811c:   ror $e9                     ; 11C:  66 e9
b00_811e:   .db $03                     ; 11E:  03
b00_811f:   dex                         ; 11F:  ca
b00_8120:   .db $02                     ; 120:  02
b00_8121:   sta $6b1a                   ; 121:  8d 1a 6b
b00_8124:   sbc #$7b                    ; 124:  e9 7b
b00_8126:   cpy $8e04                   ; 126:  cc 04 8e
b00_8129:   .db $17                     ; 129:  17
b00_812a:   clv                         ; 12A:  b8
b00_812b:   sbc #$c4                    ; 12B:  e9 c4
b00_812d:   dec $4002                   ; 12D:  ce 02 40
b00_8130:   and #$40                    ; 130:  29 40
b00_8132:   .db $2b                     ; 132:  2b
b00_8133:   .db $3b                     ; 133:  3b
b00_8134:   .db $63                     ; 134:  63
b00_8135:   sbc #$8b                    ; 135:  e9 8b
b00_8137:   .db $cf                     ; 137:  cf
b00_8138:   .db $04                     ; 138:  04
b00_8139:   sta $e913                   ; 139:  8d 13 e9
b00_813c:   rol $f2                     ; 13C:  26 f2
b00_813e:   .db $02                     ; 13E:  02
b00_813f:   .db $0b                     ; 13F:  0b
b00_8140:   .db $5f                     ; 140:  5f
b00_8141:   .db $da                     ; 141:  da
b00_8142:   .db $5c                     ; 142:  5c
b00_8143:   cpy #$d8                    ; 143:  c0 d8
b00_8145:   jmp $4381                   ; 145:  4c 81 43
b00_8148:   cmp $bb0b                   ; 148:  cd 0b bb
b00_814b:   .db $2b                     ; 14B:  2b
b00_814c:   .db $0b                     ; 14C:  0b
b00_814d:   bne $817a                   ; 14D:  d0 2b
b00_814f:   .db $0b                     ; 14F:  0b
b00_8150:   .db $8b                     ; 150:  8b
b00_8151:   rti                         ; 151:  40
b00_8152:   dec $d7                     ; 152:  c6 d7
b00_8154:   .db $33                     ; 154:  33
b00_8155:   sta ($09,x)                 ; 155:  81 09
b00_8157:   bne $8182                   ; 157:  d0 29
b00_8159:   ora #$56                    ; 159:  09 56
b00_815b:   dec $d7                     ; 15B:  c6 d7
b00_815d:   and ($81),y                 ; 15D:  31 81
b00_815f:   ldy $4d                     ; 15F:  a4 4d
b00_8161:   .db $6f                     ; 161:  6f
b00_8162:   cld                         ; 162:  d8
b00_8163:   .db $6f                     ; 163:  6f
b00_8164:   sta ($62,x)                 ; 164:  81 62
b00_8166:   adc ($6a,x)                 ; 166:  61 6a
b00_8168:   sbc #$26                    ; 168:  e9 26
b00_816a:   .db $f2                     ; 16A:  f2
b00_816b:   asl $d7                     ; 16B:  06 d7
b00_816d:   adc $81                     ; 16D:  65 81
b00_816f:   adc ($e9,x)                 ; 16F:  61 e9
b00_8171:   and $cc,x                   ; 171:  35 cc
b00_8173:   .db $02                     ; 173:  02
b00_8174:   stx $00f8                   ; 174:  8e f8 00
b00_8177:   stx $1000                   ; 177:  8e 00 10
b00_817a:   stx $af64                   ; 17A:  8e 64 af
b00_817d:   ror $e9                     ; 17D:  66 e9
b00_817f:   .db $7c                     ; 17F:  7c
b00_8180:   .db $cf                     ; 180:  cf
b00_8181:   php                         ; 181:  08
b00_8182:   rts                         ; 182:  60
b00_8183:   rts                         ; 183:  60
b00_8184:   adc $e9                     ; 184:  65 e9
b00_8186:   rol $f2                     ; 186:  26 f2
b00_8188:   asl $ac                     ; 188:  06 ac
b00_818a:   eor $66cf,x                 ; 18A:  5d cf 66
b00_818d:   stx $ace4                   ; 18D:  8e e4 ac
b00_8190:   sta $8d18                   ; 190:  8d 18 8d
b00_8193:   .db $1f                     ; 193:  1f
b00_8194:   adc $60                     ; 194:  65 60
b00_8196:   sbc #$54                    ; 196:  e9 54
b00_8198:   cpy $400c                   ; 198:  cc 0c 40
b00_819b:   .db $2b                     ; 19B:  2b
b00_819c:   .db $0b                     ; 19C:  0b
b00_819d:   sty $b7d6                   ; 19D:  8c d6 b7
b00_81a0:   .db $bb                     ; 1A0:  bb
b00_81a1:   .db $d3                     ; 1A1:  d3
b00_81a2:   .db $b3                     ; 1A2:  b3
b00_81a3:   .db $3b                     ; 1A3:  3b
b00_81a4:   sbc #$8b                    ; 1A4:  e9 8b
b00_81a6:   .db $cf                     ; 1A6:  cf
b00_81a7:   .db $04                     ; 1A7:  04
b00_81a8:   .db $0b                     ; 1A8:  0b
b00_81a9:   bne $81d6                   ; 1A9:  d0 2b
b00_81ab:   .db $0b                     ; 1AB:  0b
b00_81ac:   .db $54                     ; 1AC:  54
b00_81ad:   dec $d7                     ; 1AD:  c6 d7
b00_81af:   .db $9c                     ; 1AF:  9c
b00_81b0:   sta ($60,x)                 ; 1B0:  81 60
b00_81b2:   sbc #$35                    ; 1B2:  e9 35
b00_81b4:   cpy $6002                   ; 1B4:  cc 02 60
b00_81b7:   sbc #$03                    ; 1B7:  e9 03
b00_81b9:   dex                         ; 1B9:  ca
b00_81ba:   .db $02                     ; 1BA:  02
b00_81bb:   rti                         ; 1BB:  40
b00_81bc:   tay                         ; 1BC:  a8
b00_81bd:   .db $d3                     ; 1BD:  d3
b00_81be:   .db $7f                     ; 1BE:  7f
b00_81bf:   txa                         ; 1BF:  8a
b00_81c0:   .db $ff                     ; 1C0:  ff
b00_81c1:   brk                         ; 1C1:  00
b00_81c2:   tay                         ; 1C2:  a8
b00_81c3:   .db $df                     ; 1C3:  df
b00_81c4:   .db $7f                     ; 1C4:  7f
b00_81c5:   rts                         ; 1C5:  60
b00_81c6:   ror $e9                     ; 1C6:  66 e9
b00_81c8:   rol $f2                     ; 1C8:  26 f2
b00_81ca:   .db $04                     ; 1CA:  04
b00_81cb:   .db $d7                     ; 1CB:  d7
b00_81cc:   cmp $81                     ; 1CC:  c5 81
b00_81ce:   adc ($66,x)                 ; 1CE:  61 66
b00_81d0:   sbc #$26                    ; 1D0:  e9 26
b00_81d2:   .db $f2                     ; 1D2:  f2
b00_81d3:   .db $04                     ; 1D3:  04
b00_81d4:   .db $d7                     ; 1D4:  d7
b00_81d5:   cmp $81                     ; 1D5:  c5 81
b00_81d7:   rts                         ; 1D7:  60
b00_81d8:   ror $e9                     ; 1D8:  66 e9
b00_81da:   rol $f2                     ; 1DA:  26 f2
b00_81dc:   .db $04                     ; 1DC:  04
b00_81dd:   .db $d7                     ; 1DD:  d7
b00_81de:   sbc #$81                    ; 1DE:  e9 81
b00_81e0:   adc ($66,x)                 ; 1E0:  61 66
b00_81e2:   sbc #$26                    ; 1E2:  e9 26
b00_81e4:   .db $f2                     ; 1E4:  f2
b00_81e5:   .db $04                     ; 1E5:  04
b00_81e6:   cld                         ; 1E6:  d8
b00_81e7:   .db $d7                     ; 1E7:  d7
b00_81e8:   sta ($61,x)                 ; 1E8:  81 61
b00_81ea:   sbc #$35                    ; 1EA:  e9 35
b00_81ec:   cpy $8d02                   ; 1EC:  cc 02 8d
b00_81ef:   eor ($8e),y                 ; 1EF:  51 8e
b00_81f1:   brk                         ; 1F1:  00
b00_81f2:   bpl $8182                   ; 1F2:  10 8e
b00_81f4:   tsx                         ; 1F4:  ba
b00_81f5:   .db $b2                     ; 1F5:  b2
b00_81f6:   rts                         ; 1F6:  60
b00_81f7:   sbc #$7c                    ; 1F7:  e9 7c
b00_81f9:   .db $cf                     ; 1F9:  cf
b00_81fa:   php                         ; 1FA:  08
b00_81fb:   ldy $cf50                   ; 1FB:  ac 50 cf
b00_81fe:   ldy $cf5d                   ; 1FE:  ac 5d cf
b00_8201:   rts                         ; 201:  60
b00_8202:   sbc #$35                    ; 202:  e9 35
b00_8204:   cpy $8e02                   ; 204:  cc 02 8e
b00_8207:   and ($b8,x)                 ; 207:  21 b8
b00_8209:   sbc #$26                    ; 209:  e9 26
b00_820b:   .db $d3                     ; 20B:  d3
b00_820c:   .db $02                     ; 20C:  02
b00_820d:   ldy $d3a7                   ; 20D:  ac a7 d3
b00_8210:   .db $d7                     ; 210:  d7
b00_8211:   ora $8e82,x                 ; 211:  1d 82 8e
b00_8214:   rol $e9b8,x                 ; 214:  3e b8 e9
b00_8217:   rol $d3                     ; 217:  26 d3
b00_8219:   .db $02                     ; 219:  02
b00_821a:   dec $1a,x                   ; 21A:  d6 1a
b00_821c:   .db $82                     ; 21C:  82
b00_821d:   .db $cf                     ; 21D:  cf
b00_821e:   jsr $e823                   ; 21E:  20 23 e8
b00_8221:   sed                         ; 221:  f8
b00_8222:   .db $ff                     ; 222:  ff
b00_8223:   dec $35,x                   ; 223:  d6 35
b00_8225:   .db $82                     ; 225:  82
b00_8226:   rts                         ; 226:  60
b00_8227:   sbc #$a4                    ; 227:  e9 a4
b00_8229:   .db $cb                     ; 229:  cb
b00_822a:   .db $02                     ; 22A:  02
b00_822b:   stx $b890                   ; 22B:  8e 90 b8
b00_822e:   sbc #$26                    ; 22E:  e9 26
b00_8230:   .db $d3                     ; 230:  d3
b00_8231:   .db $02                     ; 231:  02
b00_8232:   ldy $d766                   ; 232:  ac 66 d7
b00_8235:   stx $b882                   ; 235:  8e 82 b8
b00_8238:   sbc #$26                    ; 238:  e9 26
b00_823a:   .db $d3                     ; 23A:  d3
b00_823b:   .db $02                     ; 23B:  02
b00_823c:   ldy $d3a7                   ; 23C:  ac a7 d3
b00_823f:   cld                         ; 23F:  d8
b00_8240:   .db $44                     ; 240:  44
b00_8241:   .db $82                     ; 241:  82
b00_8242:   rti                         ; 242:  40
b00_8243:   .db $cf                     ; 243:  cf
b00_8244:   adc ($e9,x)                 ; 244:  61 e9
b00_8246:   ldy $cb                     ; 246:  a4 cb
b00_8248:   .db $02                     ; 248:  02
b00_8249:   stx $b88b                   ; 249:  8e 8b b8
b00_824c:   stx $7fed                   ; 24C:  8e ed 7f
b00_824f:   sbc #$b0                    ; 24F:  e9 b0
b00_8251:   dex                         ; 251:  ca
b00_8252:   .db $04                     ; 252:  04
b00_8253:   .db $d7                     ; 253:  d7
b00_8254:   rol $82                     ; 254:  26 82
b00_8256:   rts                         ; 256:  60
b00_8257:   sbc #$a4                    ; 257:  e9 a4
b00_8259:   .db $cb                     ; 259:  cb
b00_825a:   .db $02                     ; 25A:  02
b00_825b:   stx $00ff                   ; 25B:  8e ff 00
b00_825e:   stx $6001                   ; 25E:  8e 01 60
b00_8261:   rts                         ; 261:  60
b00_8262:   adc ($8d,x)                 ; 262:  61 8d
b00_8264:   asl $e9,x                   ; 264:  16 e9
b00_8266:   rol $f2                     ; 266:  26 f2
b00_8268:   asl a                       ; 268:  0a
b00_8269:   plp                         ; 269:  28
b00_826a:   txa                         ; 26A:  8a
b00_826b:   brk                         ; 26B:  00
b00_826c:   adc ($2b,x)                 ; 26C:  61 2b
b00_826e:   stx $0100                   ; 26E:  8e 00 01
b00_8271:   .db $3b                     ; 271:  3b
b00_8272:   rts                         ; 272:  60
b00_8273:   adc ($8d,x)                 ; 273:  61 8d
b00_8275:   asl $e9,x                   ; 275:  16 e9
b00_8277:   rol $f2                     ; 277:  26 f2
b00_8279:   asl a                       ; 279:  0a
b00_827a:   cmp $bb08                   ; 27A:  cd 08 bb
b00_827d:   plp                         ; 27D:  28
b00_827e:   txa                         ; 27E:  8a
b00_827f:   brk                         ; 27F:  00
b00_8280:   ora ($cd,x)                 ; 280:  01 cd
b00_8282:   .db $0b                     ; 282:  0b
b00_8283:   .db $bb                     ; 283:  bb
b00_8284:   .db $2b                     ; 284:  2b
b00_8285:   .db $0b                     ; 285:  0b
b00_8286:   sty $7000                   ; 286:  8c 00 70
b00_8289:   dec $d7                     ; 289:  c6 d7
b00_828b:   ror $8e82                   ; 28B:  6e 82 8e
b00_828e:   .db $ff                     ; 28E:  ff
b00_828f:   brk                         ; 28F:  00
b00_8290:   stx $7001                   ; 290:  8e 01 70
b00_8293:   rts                         ; 293:  60
b00_8294:   adc ($8d,x)                 ; 294:  61 8d
b00_8296:   asl $e9,x                   ; 296:  16 e9
b00_8298:   rol $f2                     ; 298:  26 f2
b00_829a:   asl a                       ; 29A:  0a
b00_829b:   cmp $bb08                   ; 29B:  cd 08 bb
b00_829e:   plp                         ; 29E:  28
b00_829f:   txa                         ; 29F:  8a
b00_82a0:   brk                         ; 2A0:  00
b00_82a1:   adc ($2b),y                 ; 2A1:  71 2b
b00_82a3:   stx $0100                   ; 2A3:  8e 00 01
b00_82a6:   .db $3b                     ; 2A6:  3b
b00_82a7:   rts                         ; 2A7:  60
b00_82a8:   adc ($8d,x)                 ; 2A8:  61 8d
b00_82aa:   asl $e9,x                   ; 2AA:  16 e9
b00_82ac:   rol $f2                     ; 2AC:  26 f2
b00_82ae:   asl a                       ; 2AE:  0a
b00_82af:   cmp $bb08                   ; 2AF:  cd 08 bb
b00_82b2:   plp                         ; 2B2:  28
b00_82b3:   txa                         ; 2B3:  8a
b00_82b4:   brk                         ; 2B4:  00
b00_82b5:   ora ($cd,x)                 ; 2B5:  01 cd
b00_82b7:   .db $0b                     ; 2B7:  0b
b00_82b8:   .db $bb                     ; 2B8:  bb
b00_82b9:   .db $2b                     ; 2B9:  2b
b00_82ba:   .db $0b                     ; 2BA:  0b
b00_82bb:   sty $7f00                   ; 2BB:  8c 00 7f
b00_82be:   dec $d7                     ; 2BE:  c6 d7
b00_82c0:   .db $a3                     ; 2C0:  a3
b00_82c1:   .db $82                     ; 2C1:  82
b00_82c2:   stx $81eb                   ; 2C2:  8e eb 81
b00_82c5:   stx $7f00                   ; 2C5:  8e 00 7f
b00_82c8:   rts                         ; 2C8:  60
b00_82c9:   adc ($8d,x)                 ; 2C9:  61 8d
b00_82cb:   asl $e9,x                   ; 2CB:  16 e9
b00_82cd:   rol $f2                     ; 2CD:  26 f2
b00_82cf:   asl a                       ; 2CF:  0a
b00_82d0:   cmp $bb08                   ; 2D0:  cd 08 bb
b00_82d3:   plp                         ; 2D3:  28
b00_82d4:   adc ($e9,x)                 ; 2D4:  61 e9
b00_82d6:   ldy $cb                     ; 2D6:  a4 cb
b00_82d8:   .db $02                     ; 2D8:  02
b00_82d9:   ldy $eb                     ; 2D9:  a4 eb
b00_82db:   .db $7f                     ; 2DB:  7f
b00_82dc:   clc                         ; 2DC:  18
b00_82dd:   cpy #$d8                    ; 2DD:  c0 d8
b00_82df:   .db $43                     ; 2DF:  43
b00_82e0:   .db $83                     ; 2E0:  83
b00_82e1:   rts                         ; 2E1:  60
b00_82e2:   sbc #$a4                    ; 2E2:  e9 a4
b00_82e4:   .db $cb                     ; 2E4:  cb
b00_82e5:   .db $02                     ; 2E5:  02
b00_82e6:   rti                         ; 2E6:  40
b00_82e7:   tay                         ; 2E7:  a8
b00_82e8:   cmp ($7f),y                 ; 2E8:  d1 7f
b00_82ea:   rti                         ; 2EA:  40
b00_82eb:   tay                         ; 2EB:  a8
b00_82ec:   adc ($6f,x)                 ; 2EC:  61 6f
b00_82ee:   stx $b89e                   ; 2EE:  8e 9e b8
b00_82f1:   sbc #$26                    ; 2F1:  e9 26
b00_82f3:   .db $d3                     ; 2F3:  d3
b00_82f4:   .db $02                     ; 2F4:  02
b00_82f5:   stx $b89f                   ; 2F5:  8e 9f b8
b00_82f8:   sbc #$c4                    ; 2F8:  e9 c4
b00_82fa:   dec $ac02                   ; 2FA:  ce 02 ac
b00_82fd:   eor $acd7,y                 ; 2FD:  59 d7 ac
b00_8300:   jsr $61cd                   ; 300:  20 cd 61
b00_8303:   sbc #$35                    ; 303:  e9 35
b00_8305:   cpy $6402                   ; 305:  cc 02 64
b00_8308:   stx $14d0                   ; 308:  8e d0 14
b00_830b:   stx $b78a                   ; 30B:  8e 8a b7
b00_830e:   rts                         ; 30E:  60
b00_830f:   sbc #$7c                    ; 30F:  e9 7c
b00_8311:   .db $cf                     ; 311:  cf
b00_8312:   php                         ; 312:  08
b00_8313:   stx $009a                   ; 313:  8e 9a 00
b00_8316:   stx $1510                   ; 316:  8e 10 15
b00_8319:   stx $83bc                   ; 319:  8e bc 83
b00_831c:   .db $64                     ; 31C:  64
b00_831d:   sbc #$7c                    ; 31D:  e9 7c
b00_831f:   .db $cf                     ; 31F:  cf
b00_8320:   php                         ; 320:  08
b00_8321:   rti                         ; 321:  40
b00_8322:   and #$09                    ; 322:  29 09
b00_8324:   sty $b852                   ; 324:  8c 52 b8
b00_8327:   .db $bb                     ; 327:  bb
b00_8328:   .db $d3                     ; 328:  d3
b00_8329:   .db $b3                     ; 329:  b3
b00_832a:   and $8be9,y                 ; 32A:  39 e9 8b
b00_832d:   .db $cf                     ; 32D:  cf
b00_832e:   .db $04                     ; 32E:  04
b00_832f:   ora #$d0                    ; 32F:  09 d0
b00_8331:   and #$09                    ; 331:  29 09
b00_8333:   cli                         ; 333:  58
b00_8334:   dec $d7                     ; 334:  c6 d7
b00_8336:   .db $23                     ; 336:  23
b00_8337:   .db $83                     ; 337:  83
b00_8338:   rts                         ; 338:  60
b00_8339:   sbc #$35                    ; 339:  e9 35
b00_833b:   cpy $4102                   ; 33B:  cc 02 41
b00_833e:   tay                         ; 33E:  a8
b00_833f:   cmp ($7f),y                 ; 33F:  d1 7f
b00_8341:   eor ($cf,x)                 ; 341:  41 cf
b00_8343:   stx $b8ab                   ; 343:  8e ab b8
b00_8346:   stx $7fed                   ; 346:  8e ed 7f
b00_8349:   sbc #$d9                    ; 349:  e9 d9
b00_834b:   dex                         ; 34B:  ca
b00_834c:   .db $04                     ; 34C:  04
b00_834d:   rts                         ; 34D:  60
b00_834e:   sbc #$a4                    ; 34E:  e9 a4
b00_8350:   .db $cb                     ; 350:  cb
b00_8351:   .db $02                     ; 351:  02
b00_8352:   .db $89                     ; 352:  89
b00_8353:   .db $32                     ; 353:  32
b00_8354:   tay                         ; 354:  a8
b00_8355:   adc $6d                     ; 355:  65 6d
b00_8357:   eor ($a8,x)                 ; 357:  41 a8
b00_8359:   eor $406f                   ; 359:  4d 6f 40
b00_835c:   tay                         ; 35C:  a8
b00_835d:   .db $c7                     ; 35D:  c7
b00_835e:   .db $7f                     ; 35E:  7f
b00_835f:   rti                         ; 35F:  40
b00_8360:   tay                         ; 360:  a8
b00_8361:   .db $d3                     ; 361:  d3
b00_8362:   .db $7f                     ; 362:  7f
b00_8363:   rti                         ; 363:  40
b00_8364:   tay                         ; 364:  a8
b00_8365:   cmp ($7f),y                 ; 365:  d1 7f
b00_8367:   ldy $cc89                   ; 367:  ac 89 cc
b00_836a:   stx $b8b0                   ; 36A:  8e b0 b8
b00_836d:   sbc #$26                    ; 36D:  e9 26
b00_836f:   .db $d3                     ; 36F:  d3
b00_8370:   .db $02                     ; 370:  02
b00_8371:   ldy $d609                   ; 371:  ac 09 d6
b00_8374:   dec $35,x                   ; 374:  d6 35
b00_8376:   .db $82                     ; 376:  82
b00_8377:   jsr $e823                   ; 377:  20 23 e8
b00_837a:   .db $ff                     ; 37A:  ff
b00_837b:   .db $ff                     ; 37B:  ff
b00_837c:   rol $d30d,x                 ; 37C:  3e 0d d3
b00_837f:   .db $b3                     ; 37F:  b3
b00_8380:   sbc #$0d                    ; 380:  e9 0d
b00_8382:   .db $d7                     ; 382:  d7
b00_8383:   .db $04                     ; 383:  04
b00_8384:   ldx #$ff                    ; 384:  a2 ff
b00_8386:   .db $ff                     ; 386:  ff
b00_8387:   .db $a3                     ; 387:  a3
b00_8388:   .db $ff                     ; 388:  ff
b00_8389:   .db $ff                     ; 389:  ff
b00_838a:   .db $0c                     ; 38A:  0c
b00_838b:   ldy $b3,x                   ; 38B:  b4 b3
b00_838d:   .db $d3                     ; 38D:  d3
b00_838e:   .db $bb                     ; 38E:  bb
b00_838f:   .db $d4                     ; 38F:  d4
b00_8390:   .db $a3                     ; 390:  a3
b00_8391:   .db $ff                     ; 391:  ff
b00_8392:   .db $ff                     ; 392:  ff
b00_8393:   ora $b3b4                   ; 393:  0d b4 b3
b00_8396:   .db $d3                     ; 396:  d3
b00_8397:   ldy $cfd4,x                 ; 397:  bc d4 cf
b00_839a:   jsr $e823                   ; 39A:  20 23 e8
b00_839d:   inc $0cff,x                 ; 39D:  fe ff 0c
b00_83a0:   eor $b5,x                   ; 3A0:  55 b5
b00_83a2:   sty $76a9                   ; 3A2:  8c a9 76
b00_83a5:   .db $bb                     ; 3A5:  bb
b00_83a6:   .db $2b                     ; 3A6:  2b
b00_83a7:   sta $0b1e                   ; 3A7:  8d 1e 0b
b00_83aa:   .db $73                     ; 3AA:  73
b00_83ab:   .db $b3                     ; 3AB:  b3
b00_83ac:   .db $3b                     ; 3AC:  3b
b00_83ad:   sbc #$77                    ; 3AD:  e9 77
b00_83af:   .db $83                     ; 3AF:  83
b00_83b0:   asl $8d                     ; 3B0:  06 8d
b00_83b2:   .db $14                     ; 3B2:  14
b00_83b3:   sbc #$52                    ; 3B3:  e9 52
b00_83b5:   dex                         ; 3B5:  ca
b00_83b6:   .db $02                     ; 3B6:  02
b00_83b7:   .db $8f                     ; 3B7:  8f
b00_83b8:   .db $14                     ; 3B8:  14
b00_83b9:   .db $b3                     ; 3B9:  b3
b00_83ba:   .db $0b                     ; 3BA:  0b
b00_83bb:   .db $74                     ; 3BB:  74
b00_83bc:   .db $b3                     ; 3BC:  b3
b00_83bd:   .db $3b                     ; 3BD:  3b
b00_83be:   sbc #$77                    ; 3BE:  e9 77
b00_83c0:   .db $83                     ; 3C0:  83
b00_83c1:   asl $8d                     ; 3C1:  06 8d
b00_83c3:   asl $740b,x                 ; 3C3:  1e 0b 74
b00_83c6:   .db $b3                     ; 3C6:  b3
b00_83c7:   .db $0b                     ; 3C7:  0b
b00_83c8:   bne $837d                   ; 3C8:  d0 b3
b00_83ca:   sbc #$77                    ; 3CA:  e9 77
b00_83cc:   .db $83                     ; 3CC:  83
b00_83cd:   asl $8d                     ; 3CD:  06 8d
b00_83cf:   .db $14                     ; 3CF:  14
b00_83d0:   sbc #$52                    ; 3D0:  e9 52
b00_83d2:   dex                         ; 3D2:  ca
b00_83d3:   .db $02                     ; 3D3:  02
b00_83d4:   .db $8f                     ; 3D4:  8f
b00_83d5:   .db $14                     ; 3D5:  14
b00_83d6:   .db $b3                     ; 3D6:  b3
b00_83d7:   .db $0b                     ; 3D7:  0b
b00_83d8:   .db $73                     ; 3D8:  73
b00_83d9:   .db $b3                     ; 3D9:  b3
b00_83da:   .db $0b                     ; 3DA:  0b
b00_83db:   bne $8390                   ; 3DB:  d0 b3
b00_83dd:   sbc #$77                    ; 3DD:  e9 77
b00_83df:   .db $83                     ; 3DF:  83
b00_83e0:   asl $cf                     ; 3E0:  06 cf
b00_83e2:   jsr $e823                   ; 3E2:  20 23 e8
b00_83e5:   cld                         ; 3E5:  d8
b00_83e6:   .db $ff                     ; 3E6:  ff
b00_83e7:   ror $e9                     ; 3E7:  66 e9
b00_83e9:   .db $52                     ; 3E9:  52
b00_83ea:   dex                         ; 3EA:  ca
b00_83eb:   .db $02                     ; 3EB:  02
b00_83ec:   .db $8f                     ; 3EC:  8f
b00_83ed:   .db $14                     ; 3ED:  14
b00_83ee:   tay                         ; 3EE:  a8
b00_83ef:   ora $406e                   ; 3EF:  0d 6e 40
b00_83f2:   .db $2b                     ; 3F2:  2b
b00_83f3:   and #$d6                    ; 3F3:  29 d6
b00_83f5:   ldy $85,x                   ; 3F5:  b4 85
b00_83f7:   .db $3b                     ; 3F7:  3b
b00_83f8:   sbc #$8d                    ; 3F8:  e9 8d
b00_83fa:   cmp $d702,y                 ; 3FA:  d9 02 d7
b00_83fd:   .db $93                     ; 3FD:  93
b00_83fe:   sta $3b                     ; 3FE:  85 3b
b00_8400:   sbc #$72                    ; 400:  e9 72
b00_8402:   .db $d7                     ; 402:  d7
b00_8403:   .db $02                     ; 403:  02
b00_8404:   .db $57                     ; 404:  57
b00_8405:   lda $8c,x                   ; 405:  b5 8c
b00_8407:   bmi $847e                   ; 407:  30 75
b00_8409:   .db $bb                     ; 409:  bb
b00_840a:   sta $d8                     ; 40A:  85 d8
b00_840c:   rti                         ; 40C:  40
b00_840d:   dec $23,x                   ; 40D:  d6 23
b00_840f:   sty $a4                     ; 40F:  84 a4
b00_8411:   .db $63                     ; 411:  63
b00_8412:   adc $b555                   ; 412:  6d 55 b5
b00_8415:   .db $b3                     ; 415:  b3
b00_8416:   sta ($d8,x)                 ; 416:  81 d8
b00_8418:   bne $839f                   ; 418:  d0 85
b00_841a:   cld                         ; 41A:  d8
b00_841b:   cmp ($b4),y                 ; 41B:  d1 b4
b00_841d:   .db $b3                     ; 41D:  b3
b00_841e:   .db $d3                     ; 41E:  d3
b00_841f:   .db $bb                     ; 41F:  bb
b00_8420:   .db $d4                     ; 420:  d4
b00_8421:   asl a                       ; 421:  0a
b00_8422:   bne $844e                   ; 422:  d0 2a
b00_8424:   asl a                       ; 424:  0a
b00_8425:   eor $c6,x                   ; 425:  55 c6
b00_8427:   .db $d7                     ; 427:  d7
b00_8428:   bpl $83ae                   ; 428:  10 84
b00_842a:   .db $0b                     ; 42A:  0b
b00_842b:   .db $8b                     ; 42B:  8b
b00_842c:   .db $1a                     ; 42C:  1a
b00_842d:   lda $8c,x                   ; 42D:  b5 8c
b00_842f:   ora ($70,x)                 ; 42F:  01 70
b00_8431:   .db $bb                     ; 431:  bb
b00_8432:   plp                         ; 432:  28
b00_8433:   ldy $63                     ; 433:  a4 63
b00_8435:   adc $b55a                   ; 435:  6d 5a b5
b00_8438:   .db $b3                     ; 438:  b3
b00_8439:   php                         ; 439:  08
b00_843a:   .db $72                     ; 43A:  72
b00_843b:   plp                         ; 43B:  28
b00_843c:   .db $8f                     ; 43C:  8f
b00_843d:   inc $b3b4,x                 ; 43D:  fe b4 b3
b00_8440:   bcs $83fd                   ; 440:  b0 bb
b00_8442:   lda ($40),y                 ; 442:  b1 40
b00_8444:   rol a                       ; 444:  2a
b00_8445:   ldy $63                     ; 445:  a4 63
b00_8447:   adc $b555                   ; 447:  6d 55 b5
b00_844a:   .db $b3                     ; 44A:  b3
b00_844b:   php                         ; 44B:  08
b00_844c:   .db $72                     ; 44C:  72
b00_844d:   plp                         ; 44D:  28
b00_844e:   ldy $b3,x                   ; 44E:  b4 b3
b00_8450:   bcs $840d                   ; 450:  b0 bb
b00_8452:   lda ($0a),y                 ; 452:  b1 0a
b00_8454:   bne $8480                   ; 454:  d0 2a
b00_8456:   asl a                       ; 456:  0a
b00_8457:   .db $5a                     ; 457:  5a
b00_8458:   dec $d7                     ; 458:  c6 d7
b00_845a:   eor $84                     ; 45A:  45 84
b00_845c:   ldy $9d                     ; 45C:  a4 9d
b00_845e:   adc $328b                   ; 45E:  6d 8b 32
b00_8461:   cpy #$d8                    ; 461:  c0 d8
b00_8463:   .db $07                     ; 463:  07
b00_8464:   sta $0b                     ; 464:  85 0b
b00_8466:   eor $c0,x                   ; 466:  55 c0
b00_8468:   .db $d7                     ; 468:  d7
b00_8469:   lda $84,x                   ; 469:  b5 84
b00_846b:   .db $0b                     ; 46B:  0b
b00_846c:   eor $d7c0,y                 ; 46C:  59 c0 d7
b00_846f:   lda $84,x                   ; 46F:  b5 84
b00_8471:   .db $0b                     ; 471:  0b
b00_8472:   eor $d7c0,x                 ; 472:  5d c0 d7
b00_8475:   lda $84,x                   ; 475:  b5 84
b00_8477:   .db $0b                     ; 477:  0b
b00_8478:   lsr $d7c0,x                 ; 478:  5e c0 d7
b00_847b:   lda $84,x                   ; 47B:  b5 84
b00_847d:   .db $0b                     ; 47D:  0b
b00_847e:   .db $8b                     ; 47E:  8b
b00_847f:   .db $13                     ; 47F:  13
b00_8480:   cpy #$d7                    ; 480:  c0 d7
b00_8482:   lda $84,x                   ; 482:  b5 84
b00_8484:   .db $0b                     ; 484:  0b
b00_8485:   .db $8b                     ; 485:  8b
b00_8486:   .db $17                     ; 486:  17
b00_8487:   cpy #$d7                    ; 487:  c0 d7
b00_8489:   lda $84,x                   ; 489:  b5 84
b00_848b:   .db $0b                     ; 48B:  0b
b00_848c:   .db $8b                     ; 48C:  8b
b00_848d:   .db $1a                     ; 48D:  1a
b00_848e:   cpy #$d7                    ; 48E:  c0 d7
b00_8490:   lda $84,x                   ; 490:  b5 84
b00_8492:   .db $0b                     ; 492:  0b
b00_8493:   .db $8b                     ; 493:  8b
b00_8494:   ora $c0,x                   ; 494:  15 c0
b00_8496:   .db $d7                     ; 496:  d7
b00_8497:   lda $84,x                   ; 497:  b5 84
b00_8499:   .db $0b                     ; 499:  0b
b00_849a:   .db $8b                     ; 49A:  8b
b00_849b:   rol $c0                     ; 49B:  26 c0
b00_849d:   .db $d7                     ; 49D:  d7
b00_849e:   lda $84,x                   ; 49E:  b5 84
b00_84a0:   .db $0b                     ; 4A0:  0b
b00_84a1:   .db $8b                     ; 4A1:  8b
b00_84a2:   rol a                       ; 4A2:  2a
b00_84a3:   cpy #$d7                    ; 4A3:  c0 d7
b00_84a5:   lda $84,x                   ; 4A5:  b5 84
b00_84a7:   .db $0b                     ; 4A7:  0b
b00_84a8:   .db $8b                     ; 4A8:  8b
b00_84a9:   and ($c0),y                 ; 4A9:  31 c0
b00_84ab:   .db $d7                     ; 4AB:  d7
b00_84ac:   lda $84,x                   ; 4AC:  b5 84
b00_84ae:   .db $0b                     ; 4AE:  0b
b00_84af:   .db $8b                     ; 4AF:  8b
b00_84b0:   clc                         ; 4B0:  18
b00_84b1:   cpy #$d8                    ; 4B1:  c0 d8
b00_84b3:   stx $6285                   ; 4B3:  8e 85 62
b00_84b6:   sbc #$52                    ; 4B6:  e9 52
b00_84b8:   dex                         ; 4B8:  ca
b00_84b9:   .db $02                     ; 4B9:  02
b00_84ba:   cld                         ; 4BA:  d8
b00_84bb:   stx $de85                   ; 4BB:  8e 85 de
b00_84be:   .db $da                     ; 4BE:  da
b00_84bf:   .db $ff                     ; 4BF:  ff
b00_84c0:   .db $b3                     ; 4C0:  b3
b00_84c1:   ora #$d2                    ; 4C1:  09 d2
b00_84c3:   ldy $bb,x                   ; 4C3:  b4 bb
b00_84c5:   .db $b3                     ; 4C5:  b3
b00_84c6:   .db $0b                     ; 4C6:  0b
b00_84c7:   lda ($09),y                 ; 4C7:  b1 09
b00_84c9:   bne $84f4                   ; 4C9:  d0 29
b00_84cb:   .db $62                     ; 4CB:  62
b00_84cc:   .db $0b                     ; 4CC:  0b
b00_84cd:   .db $8b                     ; 4CD:  8b
b00_84ce:   .db $1a                     ; 4CE:  1a
b00_84cf:   lda $8c,x                   ; 4CF:  b5 8c
b00_84d1:   ora ($70,x)                 ; 4D1:  01 70
b00_84d3:   .db $bb                     ; 4D3:  bb
b00_84d4:   ldy $b3,x                   ; 4D4:  b4 b3
b00_84d6:   bcs $848d                   ; 4D6:  b0 b5
b00_84d8:   lda ($64),y                 ; 4D8:  b1 64
b00_84da:   .db $0b                     ; 4DA:  0b
b00_84db:   .db $8b                     ; 4DB:  8b
b00_84dc:   .db $1a                     ; 4DC:  1a
b00_84dd:   lda $8c,x                   ; 4DD:  b5 8c
b00_84df:   .db $07                     ; 4DF:  07
b00_84e0:   bvs $849d                   ; 4E0:  70 bb
b00_84e2:   ldy $b3,x                   ; 4E2:  b4 b3
b00_84e4:   bcs $849b                   ; 4E4:  b0 b5
b00_84e6:   lda ($62),y                 ; 4E6:  b1 62
b00_84e8:   .db $0b                     ; 4E8:  0b
b00_84e9:   .db $8b                     ; 4E9:  8b
b00_84ea:   .db $1a                     ; 4EA:  1a
b00_84eb:   lda $8c,x                   ; 4EB:  b5 8c
b00_84ed:   ora $bb70                   ; 4ED:  0d 70 bb
b00_84f0:   ldy $b3,x                   ; 4F0:  b4 b3
b00_84f2:   bcs $84a9                   ; 4F2:  b0 b5
b00_84f4:   lda ($62),y                 ; 4F4:  b1 62
b00_84f6:   .db $0b                     ; 4F6:  0b
b00_84f7:   .db $8b                     ; 4F7:  8b
b00_84f8:   .db $1a                     ; 4F8:  1a
b00_84f9:   lda $8c,x                   ; 4F9:  b5 8c
b00_84fb:   .db $13                     ; 4FB:  13
b00_84fc:   bvs $84b9                   ; 4FC:  70 bb
b00_84fe:   ldy $b3,x                   ; 4FE:  b4 b3
b00_8500:   bcs $84b7                   ; 500:  b0 b5
b00_8502:   lda ($63),y                 ; 502:  b1 63
b00_8504:   dec $81,x                   ; 504:  d6 81
b00_8506:   sta $0b                     ; 506:  85 0b
b00_8508:   eor ($c0),y                 ; 508:  51 c0
b00_850a:   .db $d7                     ; 50A:  d7
b00_850b:   .db $32                     ; 50B:  32
b00_850c:   sta $0b                     ; 50C:  85 0b
b00_850e:   .db $52                     ; 50E:  52
b00_850f:   cpy #$d7                    ; 50F:  c0 d7
b00_8511:   .db $32                     ; 511:  32
b00_8512:   sta $0b                     ; 512:  85 0b
b00_8514:   .db $54                     ; 514:  54
b00_8515:   cpy #$d7                    ; 515:  c0 d7
b00_8517:   .db $32                     ; 517:  32
b00_8518:   sta $0b                     ; 518:  85 0b
b00_851a:   .db $57                     ; 51A:  57
b00_851b:   cpy #$d7                    ; 51B:  c0 d7
b00_851d:   .db $32                     ; 51D:  32
b00_851e:   sta $0b                     ; 51E:  85 0b
b00_8520:   .db $5a                     ; 520:  5a
b00_8521:   cpy #$d7                    ; 521:  c0 d7
b00_8523:   .db $32                     ; 523:  32
b00_8524:   sta $0b                     ; 524:  85 0b
b00_8526:   .db $5f                     ; 526:  5f
b00_8527:   cpy #$d7                    ; 527:  c0 d7
b00_8529:   .db $32                     ; 529:  32
b00_852a:   sta $0b                     ; 52A:  85 0b
b00_852c:   .db $8b                     ; 52C:  8b
b00_852d:   bpl $84ef                   ; 52D:  10 c0
b00_852f:   cld                         ; 52F:  d8
b00_8530:   stx $6285                   ; 530:  8e 85 62
b00_8533:   sbc #$52                    ; 533:  e9 52
b00_8535:   dex                         ; 535:  ca
b00_8536:   .db $02                     ; 536:  02
b00_8537:   cld                         ; 537:  d8
b00_8538:   stx $de85                   ; 538:  8e 85 de
b00_853b:   .db $da                     ; 53B:  da
b00_853c:   .db $ff                     ; 53C:  ff
b00_853d:   .db $b3                     ; 53D:  b3
b00_853e:   ora #$d2                    ; 53E:  09 d2
b00_8540:   ldy $bb,x                   ; 540:  b4 bb
b00_8542:   .db $b3                     ; 542:  b3
b00_8543:   .db $0b                     ; 543:  0b
b00_8544:   lda ($09),y                 ; 544:  b1 09
b00_8546:   bne $8571                   ; 546:  d0 29
b00_8548:   .db $62                     ; 548:  62
b00_8549:   .db $0b                     ; 549:  0b
b00_854a:   .db $8b                     ; 54A:  8b
b00_854b:   .db $1a                     ; 54B:  1a
b00_854c:   lda $8c,x                   ; 54C:  b5 8c
b00_854e:   ora ($70,x)                 ; 54E:  01 70
b00_8550:   .db $bb                     ; 550:  bb
b00_8551:   ldy $b3,x                   ; 551:  b4 b3
b00_8553:   bcs $850a                   ; 553:  b0 b5
b00_8555:   lda ($63),y                 ; 555:  b1 63
b00_8557:   .db $0b                     ; 557:  0b
b00_8558:   .db $8b                     ; 558:  8b
b00_8559:   .db $1a                     ; 559:  1a
b00_855a:   lda $8c,x                   ; 55A:  b5 8c
b00_855c:   .db $07                     ; 55C:  07
b00_855d:   bvs $851a                   ; 55D:  70 bb
b00_855f:   ldy $b3,x                   ; 55F:  b4 b3
b00_8561:   bcs $8518                   ; 561:  b0 b5
b00_8563:   lda ($62),y                 ; 563:  b1 62
b00_8565:   .db $0b                     ; 565:  0b
b00_8566:   .db $8b                     ; 566:  8b
b00_8567:   .db $1a                     ; 567:  1a
b00_8568:   lda $8c,x                   ; 568:  b5 8c
b00_856a:   ora $bb70                   ; 56A:  0d 70 bb
b00_856d:   ldy $b3,x                   ; 56D:  b4 b3
b00_856f:   bcs $8526                   ; 56F:  b0 b5
b00_8571:   lda ($62),y                 ; 571:  b1 62
b00_8573:   .db $0b                     ; 573:  0b
b00_8574:   .db $8b                     ; 574:  8b
b00_8575:   .db $1a                     ; 575:  1a
b00_8576:   lda $8c,x                   ; 576:  b5 8c
b00_8578:   .db $13                     ; 578:  13
b00_8579:   bvs $8536                   ; 579:  70 bb
b00_857b:   ldy $b3,x                   ; 57B:  b4 b3
b00_857d:   bcs $8534                   ; 57D:  b0 b5
b00_857f:   lda ($62),y                 ; 57F:  b1 62
b00_8581:   .db $0b                     ; 581:  0b
b00_8582:   .db $8b                     ; 582:  8b
b00_8583:   .db $1a                     ; 583:  1a
b00_8584:   lda $8c,x                   ; 584:  b5 8c
b00_8586:   ora ($70),y                 ; 586:  11 70
b00_8588:   .db $bb                     ; 588:  bb
b00_8589:   ldy $b3,x                   ; 589:  b4 b3
b00_858b:   bcs $8542                   ; 58B:  b0 b5
b00_858d:   lda ($3b),y                 ; 58D:  b1 3b
b00_858f:   sbc #$9a                    ; 58F:  e9 9a
b00_8591:   .db $83                     ; 591:  83
b00_8592:   .db $02                     ; 592:  02
b00_8593:   .db $0b                     ; 593:  0b
b00_8594:   .db $8b                     ; 594:  8b
b00_8595:   .db $1a                     ; 595:  1a
b00_8596:   lda $8c,x                   ; 596:  b5 8c
b00_8598:   ora $bb70,y                 ; 598:  19 70 bb
b00_859b:   plp                         ; 59B:  28
b00_859c:   sec                         ; 59C:  38
b00_859d:   sta $e914                   ; 59D:  8d 14 e9
b00_85a0:   .db $52                     ; 5A0:  52
b00_85a1:   dex                         ; 5A1:  ca
b00_85a2:   .db $02                     ; 5A2:  02
b00_85a3:   .db $8f                     ; 5A3:  8f
b00_85a4:   bvc $8559                   ; 5A4:  50 b3
b00_85a6:   php                         ; 5A6:  08
b00_85a7:   bcs $8539                   ; 5A7:  b0 90
b00_85a9:   inx                         ; 5A9:  e8
b00_85aa:   .db $03                     ; 5AA:  03
b00_85ab:   .db $b3                     ; 5AB:  b3
b00_85ac:   sbc #$0d                    ; 5AC:  e9 0d
b00_85ae:   .db $d7                     ; 5AE:  d7
b00_85af:   .db $04                     ; 5AF:  04
b00_85b0:   lda ($0b),y                 ; 5B0:  b1 0b
b00_85b2:   bne $85df                   ; 5B2:  d0 2b
b00_85b4:   .db $0b                     ; 5B4:  0b
b00_85b5:   ldx $9d                     ; 5B5:  a6 9d
b00_85b7:   adc $d7c6                   ; 5B7:  6d c6 d7
b00_85ba:   .db $f7                     ; 5BA:  f7
b00_85bb:   .db $83                     ; 5BB:  83
b00_85bc:   rti                         ; 5BC:  40
b00_85bd:   dec $f4,x                   ; 5BD:  d6 f4
b00_85bf:   sta $40                     ; 5BF:  85 40
b00_85c1:   dec $eb,x                   ; 5C1:  d6 eb
b00_85c3:   sta $de                     ; 5C3:  85 de
b00_85c5:   .db $da                     ; 5C5:  da
b00_85c6:   .db $ff                     ; 5C6:  ff
b00_85c7:   .db $b3                     ; 5C7:  b3
b00_85c8:   .db $0b                     ; 5C8:  0b
b00_85c9:   .db $d2                     ; 5C9:  d2
b00_85ca:   ldy $bb,x                   ; 5CA:  b4 bb
b00_85cc:   bcs $8576                   ; 5CC:  b0 a8
b00_85ce:   .db $5f                     ; 5CE:  5f
b00_85cf:   .db $6f                     ; 5CF:  6f
b00_85d0:   dec $ffda,x                 ; 5D0:  de da ff
b00_85d3:   .db $b3                     ; 5D3:  b3
b00_85d4:   asl a                       ; 5D4:  0a
b00_85d5:   .db $d2                     ; 5D5:  d2
b00_85d6:   ldy $bb,x                   ; 5D6:  b4 bb
b00_85d8:   bcs $8582                   ; 5D8:  b0 a8
b00_85da:   .db $63                     ; 5DA:  63
b00_85db:   .db $6f                     ; 5DB:  6f
b00_85dc:   ldy $5f                     ; 5DC:  a4 5f
b00_85de:   .db $6f                     ; 5DE:  6f
b00_85df:   ldx $63                     ; 5DF:  a6 63
b00_85e1:   .db $6f                     ; 5E1:  6f
b00_85e2:   cmp ($d8,x)                 ; 5E2:  c1 d8
b00_85e4:   sbc #$85                    ; 5E4:  e9 85
b00_85e6:   ldy $da7d                   ; 5E6:  ac 7d da
b00_85e9:   asl a                       ; 5E9:  0a
b00_85ea:   bne $8616                   ; 5EA:  d0 2a
b00_85ec:   asl a                       ; 5EC:  0a
b00_85ed:   ora $d7c6,y                 ; 5ED:  19 c6 d7
b00_85f0:   cpy $85                     ; 5F0:  c4 85
b00_85f2:   .db $0b                     ; 5F2:  0b
b00_85f3:   bne $8620                   ; 5F3:  d0 2b
b00_85f5:   .db $0b                     ; 5F5:  0b
b00_85f6:   ora $d7c6,y                 ; 5F6:  19 c6 d7
b00_85f9:   cpy #$85                    ; 5F9:  c0 85
b00_85fb:   .db $cf                     ; 5FB:  cf
b00_85fc:   jsr $e823                   ; 5FC:  20 23 e8
b00_85ff:   .db $fc                     ; 5FF:  fc
b00_8600:   .db $ff                     ; 600:  ff
b00_8601:   ldy $cd                     ; 601:  a4 cd
b00_8603:   .db $7f                     ; 603:  7f
b00_8604:   .db $2b                     ; 604:  2b
b00_8605:   ldy $d14e                   ; 605:  ac 4e d1
b00_8608:   .db $d7                     ; 608:  d7
b00_8609:   ora $86                     ; 609:  05 86
b00_860b:   dec $12,x                   ; 60B:  d6 12
b00_860d:   stx $0b                     ; 60D:  86 0b
b00_860f:   tay                         ; 60F:  a8
b00_8610:   cmp $8d7f                   ; 610:  cd 7f 8d
b00_8613:   .db $32                     ; 613:  32
b00_8614:   sbc #$52                    ; 614:  e9 52
b00_8616:   dex                         ; 616:  ca
b00_8617:   .db $02                     ; 617:  02
b00_8618:   .db $8f                     ; 618:  8f
b00_8619:   .db $3c                     ; 619:  3c
b00_861a:   rol a                       ; 61A:  2a
b00_861b:   .db $b3                     ; 61B:  b3
b00_861c:   stx $b8c3                   ; 61C:  8e c3 b8
b00_861f:   sbc #$34                    ; 61F:  e9 34
b00_8621:   cmp ($04),y                 ; 621:  d1 04
b00_8623:   ldy $d14e                   ; 623:  ac 4e d1
b00_8626:   cld                         ; 626:  d8
b00_8627:   asl $0a86                   ; 627:  0e 86 0a
b00_862a:   .db $cf                     ; 62A:  cf
b00_862b:   jsr $e823                   ; 62B:  20 23 e8
b00_862e:   .db $fc                     ; 62E:  fc
b00_862f:   .db $ff                     ; 62F:  ff
b00_8630:   stx $b8c7                   ; 630:  8e c7 b8
b00_8633:   sbc #$26                    ; 633:  e9 26
b00_8635:   .db $d3                     ; 635:  d3
b00_8636:   .db $02                     ; 636:  02
b00_8637:   stx $b8c8                   ; 637:  8e c8 b8
b00_863a:   sbc #$51                    ; 63A:  e9 51
b00_863c:   .db $d3                     ; 63C:  d3
b00_863d:   .db $02                     ; 63D:  02
b00_863e:   rol a                       ; 63E:  2a
b00_863f:   asl a                       ; 63F:  0a
b00_8640:   .db $52                     ; 640:  52
b00_8641:   cpy #$d7                    ; 641:  c0 d7
b00_8643:   bmi $85cb                   ; 643:  30 86
b00_8645:   asl a                       ; 645:  0a
b00_8646:   eor ($c0),y                 ; 646:  51 c0
b00_8648:   cld                         ; 648:  d8
b00_8649:   lsr $86,x                   ; 649:  56 86
b00_864b:   .db $89                     ; 64B:  89
b00_864c:   ora ($a8),y                 ; 64C:  11 a8
b00_864e:   sta $8a6d,x                 ; 64E:  9d 6d 8a
b00_8651:   .db $04                     ; 651:  04
b00_8652:   ldy #$d6                    ; 652:  a0 d6
b00_8654:   lsr $8986,x                 ; 654:  5e 86 89
b00_8657:   .db $32                     ; 657:  32
b00_8658:   tay                         ; 658:  a8
b00_8659:   sta $8a6d,x                 ; 659:  9d 6d 8a
b00_865c:   .db $04                     ; 65C:  04
b00_865d:   .db $80                     ; 65D:  80
b00_865e:   .db $2b                     ; 65E:  2b
b00_865f:   txa                         ; 65F:  8a
b00_8660:   .db $cf                     ; 660:  cf
b00_8661:   .db $7f                     ; 661:  7f
b00_8662:   sty $6001                   ; 662:  8c 01 60
b00_8665:   ldy $b372,x                 ; 665:  bc 72 b3
b00_8668:   stx $6001                   ; 668:  8e 01 60
b00_866b:   .db $3b                     ; 66B:  3b
b00_866c:   .db $63                     ; 66C:  63
b00_866d:   sbc #$bd                    ; 66D:  e9 bd
b00_866f:   .db $cb                     ; 66F:  cb
b00_8670:   php                         ; 670:  08
b00_8671:   stx $b8dd                   ; 671:  8e dd b8
b00_8674:   sbc #$26                    ; 674:  e9 26
b00_8676:   .db $d3                     ; 676:  d3
b00_8677:   .db $02                     ; 677:  02
b00_8678:   ldy $d3a7                   ; 678:  ac a7 d3
b00_867b:   tay                         ; 67B:  a8
b00_867c:   adc $cf6e,x                 ; 67C:  7d 6e cf
b00_867f:   jsr $e823                   ; 67F:  20 23 e8
b00_8682:   brk                         ; 682:  00
b00_8683:   brk                         ; 683:  00
b00_8684:   stx $b8f8                   ; 684:  8e f8 b8
b00_8687:   sbc #$26                    ; 687:  e9 26
b00_8689:   .db $d3                     ; 689:  d3
b00_868a:   .db $02                     ; 68A:  02
b00_868b:   .db $3c                     ; 68B:  3c
b00_868c:   stx $b900                   ; 68C:  8e 00 b9
b00_868f:   sbc #$34                    ; 68F:  e9 34
b00_8691:   cmp ($04),y                 ; 691:  d1 04
b00_8693:   .db $cf                     ; 693:  cf
b00_8694:   jsr $e823                   ; 694:  20 23 e8
b00_8697:   .db $fc                     ; 697:  fc
b00_8698:   .db $ff                     ; 698:  ff
b00_8699:   ldy $9d                     ; 699:  a4 9d
b00_869b:   adc $328b                   ; 69B:  6d 8b 32
b00_869e:   cpy #$d8                    ; 69E:  c0 d8
b00_86a0:   ldx $86                     ; 6A0:  a6 86
b00_86a2:   .db $42                     ; 6A2:  42
b00_86a3:   dec $a7,x                   ; 6A3:  d6 a7
b00_86a5:   stx $40                     ; 6A5:  86 40
b00_86a7:   .db $b3                     ; 6A7:  b3
b00_86a8:   sbc #$f2                    ; 6A8:  e9 f2
b00_86aa:   sbc $02                     ; 6AA:  e5 02
b00_86ac:   eor ($a8,x)                 ; 6AC:  41 a8
b00_86ae:   cpx #$7b                    ; 6AE:  e0 7b
b00_86b0:   .db $42                     ; 6B0:  42
b00_86b1:   .db $2b                     ; 6B1:  2b
b00_86b2:   .db $3c                     ; 6B2:  3c
b00_86b3:   sbc #$7f                    ; 6B3:  e9 7f
b00_86b5:   stx $02                     ; 6B5:  86 02
b00_86b7:   dec $f1,x                   ; 6B7:  d6 f1
b00_86b9:   stx $a4                     ; 6B9:  86 a4
b00_86bb:   .db $cf                     ; 6BB:  cf
b00_86bc:   .db $7f                     ; 6BC:  7f
b00_86bd:   cmp ($a8),y                 ; 6BD:  d1 a8
b00_86bf:   .db $cf                     ; 6BF:  cf
b00_86c0:   .db $7f                     ; 6C0:  7f
b00_86c1:   asl a                       ; 6C1:  0a
b00_86c2:   .db $8b                     ; 6C2:  8b
b00_86c3:   .db $ff                     ; 6C3:  ff
b00_86c4:   cpy #$d8                    ; 6C4:  c0 d8
b00_86c6:   sbc ($86),y                 ; 6C6:  f1 86
b00_86c8:   ldy $9d                     ; 6C8:  a4 9d
b00_86ca:   adc $328b                   ; 6CA:  6d 8b 32
b00_86cd:   cpy #$d8                    ; 6CD:  c0 d8
b00_86cf:   .db $df                     ; 6CF:  df
b00_86d0:   stx $0b                     ; 6D0:  86 0b
b00_86d2:   bne $86ff                   ; 6D2:  d0 2b
b00_86d4:   eor $d8c9,y                 ; 6D4:  59 c9 d8
b00_86d7:   .db $db                     ; 6D7:  db
b00_86d8:   stx $42                     ; 6D8:  86 42
b00_86da:   .db $2b                     ; 6DA:  2b
b00_86db:   .db $3b                     ; 6DB:  3b
b00_86dc:   dec $ed,x                   ; 6DC:  d6 ed
b00_86de:   stx $0b                     ; 6DE:  86 0b
b00_86e0:   bne $870d                   ; 6E0:  d0 2b
b00_86e2:   .db $54                     ; 6E2:  54
b00_86e3:   cmp #$d8                    ; 6E3:  c9 d8
b00_86e5:   sbc #$86                    ; 6E5:  e9 86
b00_86e7:   .db $42                     ; 6E7:  42
b00_86e8:   .db $2b                     ; 6E8:  2b
b00_86e9:   .db $0b                     ; 6E9:  0b
b00_86ea:   .db $8f                     ; 6EA:  8f
b00_86eb:   inc $e9b3,x                 ; 6EB:  fe b3 e9
b00_86ee:   .db $f2                     ; 6EE:  f2
b00_86ef:   sbc $02                     ; 6EF:  e5 02
b00_86f1:   tax                         ; 6F1:  aa
b00_86f2:   sta $616d,x                 ; 6F2:  9d 6d 61
b00_86f5:   sbc #$e9                    ; 6F5:  e9 e9
b00_86f7:   cmp $04,x                   ; 6F7:  d5 04
b00_86f9:   rol a                       ; 6F9:  2a
b00_86fa:   bvc $86bf                   ; 6FA:  50 c3
b00_86fc:   .db $d7                     ; 6FC:  d7
b00_86fd:   tsx                         ; 6FD:  ba
b00_86fe:   stx $0a                     ; 6FE:  86 0a
b00_8700:   cmp ($2a),y                 ; 700:  d1 2a
b00_8702:   sty $6cf7                   ; 702:  8c f7 6c
b00_8705:   .db $bb                     ; 705:  bb
b00_8706:   .db $d3                     ; 706:  d3
b00_8707:   eor $c1,x                   ; 707:  55 c1
b00_8709:   cld                         ; 709:  d8
b00_870a:   .db $34                     ; 70A:  34
b00_870b:   .db $87                     ; 70B:  87
b00_870c:   stx $b926                   ; 70C:  8e 26 b9
b00_870f:   sbc #$26                    ; 70F:  e9 26
b00_8711:   .db $d3                     ; 711:  d3
b00_8712:   .db $02                     ; 712:  02
b00_8713:   asl a                       ; 713:  0a
b00_8714:   eor $8cb5,y                 ; 714:  59 b5 8c
b00_8717:   tay                         ; 717:  a8
b00_8718:   .db $77                     ; 718:  77
b00_8719:   .db $bb                     ; 719:  bb
b00_871a:   .db $b3                     ; 71A:  b3
b00_871b:   sbc #$c4                    ; 71B:  e9 c4
b00_871d:   dec $0a02                   ; 71D:  ce 02 0a
b00_8720:   bne $86d5                   ; 720:  d0 b3
b00_8722:   stx $b92a                   ; 722:  8e 2a b9
b00_8725:   sbc #$34                    ; 725:  e9 34
b00_8727:   cmp ($04),y                 ; 727:  d1 04
b00_8729:   ldy $d3a7                   ; 729:  ac a7 d3
b00_872c:   cld                         ; 72C:  d8
b00_872d:   rol $4987,x                 ; 72D:  3e 87 49
b00_8730:   .db $2b                     ; 730:  2b
b00_8731:   dec $3e,x                   ; 731:  d6 3e
b00_8733:   .db $87                     ; 733:  87
b00_8734:   stx $b93a                   ; 734:  8e 3a b9
b00_8737:   sbc #$26                    ; 737:  e9 26
b00_8739:   .db $d3                     ; 739:  d3
b00_873a:   .db $02                     ; 73A:  02
b00_873b:   ldy $d766                   ; 73B:  ac 66 d7
b00_873e:   .db $0b                     ; 73E:  0b
b00_873f:   eor $d7c1,y                 ; 73F:  59 c1 d7
b00_8742:   .db $b2                     ; 742:  b2
b00_8743:   stx $40                     ; 743:  86 40
b00_8745:   tay                         ; 745:  a8
b00_8746:   cpx #$7b                    ; 746:  e0 7b
b00_8748:   asl a                       ; 748:  0a
b00_8749:   sty $6cf7                   ; 749:  8c f7 6c
b00_874c:   .db $bb                     ; 74C:  bb
b00_874d:   .db $b3                     ; 74D:  b3
b00_874e:   eor $d4                     ; 74E:  45 d4
b00_8750:   asl a                       ; 750:  0a
b00_8751:   tay                         ; 751:  a8
b00_8752:   .db $5f                     ; 752:  5f
b00_8753:   .db $6f                     ; 753:  6f
b00_8754:   asl a                       ; 754:  0a
b00_8755:   tay                         ; 755:  a8
b00_8756:   cmp $0c7f,x                 ; 756:  dd 7f 0c
b00_8759:   sty $7fd4                   ; 759:  8c d4 7f
b00_875c:   .db $bb                     ; 75C:  bb
b00_875d:   .db $b3                     ; 75D:  b3
b00_875e:   ldy $d77e                   ; 75E:  ac 7e d7
b00_8761:   .db $d4                     ; 761:  d4
b00_8762:   .db $cf                     ; 762:  cf
b00_8763:   jsr $e823                   ; 763:  20 23 e8
b00_8766:   .db $fa                     ; 766:  fa
b00_8767:   .db $ff                     ; 767:  ff
b00_8768:   ldy $cd20                   ; 768:  ac 20 cd
b00_876b:   adc ($e9,x)                 ; 76B:  61 e9
b00_876d:   and $cc,x                   ; 76D:  35 cc
b00_876f:   .db $02                     ; 76F:  02
b00_8770:   sta $672b                   ; 770:  8d 2b 67
b00_8773:   sbc #$8b                    ; 773:  e9 8b
b00_8775:   .db $cf                     ; 775:  cf
b00_8776:   .db $04                     ; 776:  04
b00_8777:   sta $6b25                   ; 777:  8d 25 6b
b00_877a:   sbc #$8b                    ; 77A:  e9 8b
b00_877c:   .db $cf                     ; 77C:  cf
b00_877d:   .db $04                     ; 77D:  04
b00_877e:   adc ($6a,x)                 ; 77E:  61 6a
b00_8780:   ror a                       ; 780:  6a
b00_8781:   ror $62                     ; 781:  66 62
b00_8783:   sbc #$6a                    ; 783:  e9 6a
b00_8785:   .db $cf                     ; 785:  cf
b00_8786:   asl a                       ; 786:  0a
b00_8787:   adc ($8d,x)                 ; 787:  61 8d
b00_8789:   bpl $8718                   ; 789:  10 8d
b00_878b:   .db $1a                     ; 78B:  1a
b00_878c:   jmp ($108d)                 ; 78C:  6c 8d 10
b00_878f:   sbc #$6a                    ; 78F:  e9 6a
b00_8791:   .db $cf                     ; 791:  cf
b00_8792:   asl a                       ; 792:  0a
b00_8793:   .db $62                     ; 793:  62
b00_8794:   sta $8d12                   ; 794:  8d 12 8d
b00_8797:   .db $1a                     ; 797:  1a
b00_8798:   sta $6e12                   ; 798:  8d 12 6e
b00_879b:   sbc #$6a                    ; 79B:  e9 6a
b00_879d:   .db $cf                     ; 79D:  cf
b00_879e:   asl a                       ; 79E:  0a
b00_879f:   .db $64                     ; 79F:  64
b00_87a0:   .db $63                     ; 7A0:  63
b00_87a1:   sbc #$7b                    ; 7A1:  e9 7b
b00_87a3:   cpy $a404                   ; 7A3:  cc 04 a4
b00_87a6:   .db $5f                     ; 7A6:  5f
b00_87a7:   .db $6f                     ; 7A7:  6f
b00_87a8:   bne $875d                   ; 7A8:  d0 b3
b00_87aa:   stx $b957                   ; 7AA:  8e 57 b9
b00_87ad:   sbc #$34                    ; 7AD:  e9 34
b00_87af:   cmp ($04),y                 ; 7AF:  d1 04
b00_87b1:   ror $63                     ; 7B1:  66 63
b00_87b3:   sbc #$7b                    ; 7B3:  e9 7b
b00_87b5:   cpy $a404                   ; 7B5:  cc 04 a4
b00_87b8:   .db $5f                     ; 7B8:  5f
b00_87b9:   .db $6f                     ; 7B9:  6f
b00_87ba:   .db $5a                     ; 7BA:  5a
b00_87bb:   lda $8c,x                   ; 7BB:  b5 8c
b00_87bd:   sta $79                     ; 7BD:  85 79
b00_87bf:   .db $bb                     ; 7BF:  bb
b00_87c0:   .db $b3                     ; 7C0:  b3
b00_87c1:   sbc #$c4                    ; 7C1:  e9 c4
b00_87c3:   dec $6802                   ; 7C3:  ce 02 68
b00_87c6:   .db $63                     ; 7C6:  63
b00_87c7:   sbc #$7b                    ; 7C7:  e9 7b
b00_87c9:   cpy $a404                   ; 7C9:  cc 04 a4
b00_87cc:   .db $5f                     ; 7CC:  5f
b00_87cd:   .db $6f                     ; 7CD:  6f
b00_87ce:   eor $8cb5,y                 ; 7CE:  59 b5 8c
b00_87d1:   tay                         ; 7D1:  a8
b00_87d2:   .db $77                     ; 7D2:  77
b00_87d3:   .db $bb                     ; 7D3:  bb
b00_87d4:   .db $b3                     ; 7D4:  b3
b00_87d5:   sbc #$c4                    ; 7D5:  e9 c4
b00_87d7:   dec $6a02                   ; 7D7:  ce 02 6a
b00_87da:   .db $63                     ; 7DA:  63
b00_87db:   sbc #$7b                    ; 7DB:  e9 7b
b00_87dd:   cpy $ac04                   ; 7DD:  cc 04 ac
b00_87e0:   nop                         ; 7E0:  ea
b00_87e1:   .db $d7                     ; 7E1:  d7
b00_87e2:   .db $2b                     ; 7E2:  2b
b00_87e3:   .db $0b                     ; 7E3:  0b
b00_87e4:   bne $8811                   ; 7E4:  d0 2b
b00_87e6:   cmp ($d3),y                 ; 7E6:  d1 d3
b00_87e8:   .db $b3                     ; 7E8:  b3
b00_87e9:   stx $b960                   ; 7E9:  8e 60 b9
b00_87ec:   sbc #$34                    ; 7EC:  e9 34
b00_87ee:   cmp ($04),y                 ; 7EE:  d1 04
b00_87f0:   ldy $5f                     ; 7F0:  a4 5f
b00_87f2:   .db $6f                     ; 7F2:  6f
b00_87f3:   tay                         ; 7F3:  a8
b00_87f4:   .db $5b                     ; 7F4:  5b
b00_87f5:   .db $6f                     ; 7F5:  6f
b00_87f6:   jmp ($e964)                 ; 7F6:  6c 64 e9
b00_87f9:   .db $6f                     ; 7F9:  6f
b00_87fa:   .db $e7                     ; 7FA:  e7
b00_87fb:   .db $04                     ; 7FB:  04
b00_87fc:   ror $6d                     ; 7FC:  66 6d
b00_87fe:   sbc #$7b                    ; 7FE:  e9 7b
b00_8800:   cpy $8e04                   ; 800:  cc 04 8e
b00_8803:   adc #$b9                    ; 803:  69 b9
b00_8805:   sbc #$c4                    ; 805:  e9 c4
b00_8807:   dec $6702                   ; 807:  ce 02 67
b00_880a:   adc $7be9                   ; 80A:  6d e9 7b
b00_880d:   cpy $8e04                   ; 80D:  cc 04 8e
b00_8810:   .db $74                     ; 810:  74
b00_8811:   lda $c4e9,y                 ; 811:  b9 e9 c4
b00_8814:   dec $6902                   ; 814:  ce 02 69
b00_8817:   adc $7be9                   ; 817:  6d e9 7b
b00_881a:   cpy $8e04                   ; 81A:  cc 04 8e
b00_881d:   sta $b9                     ; 81D:  85 b9
b00_881f:   sbc #$c4                    ; 81F:  e9 c4
b00_8821:   dec $6a02                   ; 821:  ce 02 6a
b00_8824:   adc $7be9                   ; 824:  6d e9 7b
b00_8827:   cpy $8e04                   ; 827:  cc 04 8e
b00_882a:   stx $b9,y                   ; 82A:  96 b9
b00_882c:   sbc #$c4                    ; 82C:  e9 c4
b00_882e:   dec $4102                   ; 82E:  ce 02 41
b00_8831:   and #$09                    ; 831:  29 09
b00_8833:   .db $7b                     ; 833:  7b
b00_8834:   .db $b3                     ; 834:  b3
b00_8835:   sta $e910                   ; 835:  8d 10 e9
b00_8838:   .db $7b                     ; 838:  7b
b00_8839:   cpy $0904                   ; 839:  cc 04 09
b00_883c:   .db $d2                     ; 83C:  d2
b00_883d:   sty $f8ae                   ; 83D:  8c ae f8
b00_8840:   .db $bb                     ; 840:  bb
b00_8841:   bcs $87f6                   ; 841:  b0 b3
b00_8843:   sbc #$c4                    ; 843:  e9 c4
b00_8845:   dec $8902                   ; 845:  ce 02 89
b00_8848:   asl $a8,x                   ; 848:  16 a8
b00_884a:   cmp $8e7f                   ; 84A:  cd 7f 8e
b00_884d:   .db $a7                     ; 84D:  a7
b00_884e:   lda $34e9,y                 ; 84E:  b9 e9 34
b00_8851:   cmp ($02),y                 ; 851:  d1 02
b00_8853:   ora #$d0                    ; 853:  09 d0
b00_8855:   and #$09                    ; 855:  29 09
b00_8857:   lsr $c2,x                   ; 857:  56 c2
b00_8859:   .db $d7                     ; 859:  d7
b00_885a:   .db $32                     ; 85A:  32
b00_885b:   dey                         ; 85B:  88
b00_885c:   rts                         ; 85C:  60
b00_885d:   sbc #$35                    ; 85D:  e9 35
b00_885f:   cpy $4002                   ; 85F:  cc 02 40
b00_8862:   and #$a4                    ; 862:  29 a4
b00_8864:   .db $5f                     ; 864:  5f
b00_8865:   .db $6f                     ; 865:  6f
b00_8866:   .db $57                     ; 866:  57
b00_8867:   lda $8c,x                   ; 867:  b5 8c
b00_8869:   bmi $88e0                   ; 869:  30 75
b00_886b:   .db $bb                     ; 86B:  bb
b00_886c:   .db $2b                     ; 86C:  2b
b00_886d:   eor ($2a,x)                 ; 86D:  41 2a
b00_886f:   asl a                       ; 86F:  0a
b00_8870:   .db $7b                     ; 870:  7b
b00_8871:   .db $b3                     ; 871:  b3
b00_8872:   sta $e917                   ; 872:  8d 17 e9
b00_8875:   .db $7b                     ; 875:  7b
b00_8876:   cpy $3b04                   ; 876:  cc 04 3b
b00_8879:   ldy $85fc                   ; 879:  ac fc 85
b00_887c:   .db $d4                     ; 87C:  d4
b00_887d:   .db $0b                     ; 87D:  0b
b00_887e:   bne $88ab                   ; 87E:  d0 2b
b00_8880:   cmp ($d3),y                 ; 880:  d1 d3
b00_8882:   cmp $bb09                   ; 882:  cd 09 bb
b00_8885:   and #$0a                    ; 885:  29 0a
b00_8887:   bne $88b3                   ; 887:  d0 2a
b00_8889:   asl a                       ; 889:  0a
b00_888a:   eor $c7,x                   ; 88A:  55 c7
b00_888c:   .db $d7                     ; 88C:  d7
b00_888d:   .db $6f                     ; 88D:  6f
b00_888e:   dey                         ; 88E:  88
b00_888f:   sta $6f12                   ; 88F:  8d 12 6f
b00_8892:   sbc #$7b                    ; 892:  e9 7b
b00_8894:   cpy $3904                   ; 894:  cc 04 39
b00_8897:   stx $b9ad                   ; 897:  8e ad b9
b00_889a:   sbc #$34                    ; 89A:  e9 34
b00_889c:   cmp ($04),y                 ; 89C:  d1 04
b00_889e:   stx $b9b8                   ; 89E:  8e b8 b9
b00_88a1:   sbc #$26                    ; 8A1:  e9 26
b00_88a3:   .db $d3                     ; 8A3:  d3
b00_88a4:   .db $02                     ; 8A4:  02
b00_88a5:   ldy $d3a7                   ; 8A5:  ac a7 d3
b00_88a8:   cld                         ; 8A8:  d8
b00_88a9:   adc ($88,x)                 ; 8A9:  61 88
b00_88ab:   .db $cf                     ; 8AB:  cf
b00_88ac:   jsr $e823                   ; 8AC:  20 23 e8
b00_88af:   inc $40ff,x                 ; 8AF:  fe ff 40
b00_88b2:   tay                         ; 8B2:  a8
b00_88b3:   cmp $7f                     ; 8B3:  c5 7f
b00_88b5:   adc ($e9,x)                 ; 8B5:  61 e9
b00_88b7:   and $cc,x                   ; 8B7:  35 cc
b00_88b9:   .db $02                     ; 8B9:  02
b00_88ba:   sta $8e66                   ; 8BA:  8d 66 8e
b00_88bd:   brk                         ; 8BD:  00
b00_88be:   bpl $884e                   ; 8BE:  10 8e
b00_88c0:   lsr a                       ; 8C0:  4a
b00_88c1:   ldy $e960                   ; 8C1:  ac 60 e9
b00_88c4:   .db $7c                     ; 8C4:  7c
b00_88c5:   .db $cf                     ; 8C5:  cf
b00_88c6:   php                         ; 8C6:  08
b00_88c7:   .db $64                     ; 8C7:  64
b00_88c8:   stx $23c0                   ; 8C8:  8e c0 23
b00_88cb:   stx $a84a                   ; 8CB:  8e 4a a8
b00_88ce:   rts                         ; 8CE:  60
b00_88cf:   sbc #$7c                    ; 8CF:  e9 7c
b00_88d1:   .db $cf                     ; 8D1:  cf
b00_88d2:   php                         ; 8D2:  08
b00_88d3:   rts                         ; 8D3:  60
b00_88d4:   stx $a88a                   ; 8D4:  8e 8a a8
b00_88d7:   sta $8d1d                   ; 8D7:  8d 1d 8d
b00_88da:   .db $1f                     ; 8DA:  1f
b00_88db:   rts                         ; 8DB:  60
b00_88dc:   rts                         ; 8DC:  60
b00_88dd:   sbc #$54                    ; 8DD:  e9 54
b00_88df:   cpy $400c                   ; 8DF:  cc 0c 40
b00_88e2:   .db $2b                     ; 8E2:  2b
b00_88e3:   .db $0b                     ; 8E3:  0b
b00_88e4:   sty $b862                   ; 8E4:  8c 62 b8
b00_88e7:   .db $bb                     ; 8E7:  bb
b00_88e8:   .db $d3                     ; 8E8:  d3
b00_88e9:   .db $b3                     ; 8E9:  b3
b00_88ea:   .db $3b                     ; 8EA:  3b
b00_88eb:   sbc #$8b                    ; 8EB:  e9 8b
b00_88ed:   .db $cf                     ; 8ED:  cf
b00_88ee:   .db $04                     ; 8EE:  04
b00_88ef:   .db $0b                     ; 8EF:  0b
b00_88f0:   bne $891d                   ; 8F0:  d0 2b
b00_88f2:   .db $0b                     ; 8F2:  0b
b00_88f3:   .db $8b                     ; 8F3:  8b
b00_88f4:   jsr $d7c6                   ; 8F4:  20 c6 d7
b00_88f7:   .db $e3                     ; 8F7:  e3
b00_88f8:   dey                         ; 8F8:  88
b00_88f9:   rts                         ; 8F9:  60
b00_88fa:   sbc #$35                    ; 8FA:  e9 35
b00_88fc:   cpy $8a02                   ; 8FC:  cc 02 8a
b00_88ff:   .db $ff                     ; 8FF:  ff
b00_8900:   brk                         ; 900:  00
b00_8901:   tay                         ; 901:  a8
b00_8902:   .db $df                     ; 902:  df
b00_8903:   .db $7f                     ; 903:  7f
b00_8904:   rti                         ; 904:  40
b00_8905:   tay                         ; 905:  a8
b00_8906:   .db $d3                     ; 906:  d3
b00_8907:   .db $7f                     ; 907:  7f
b00_8908:   rts                         ; 908:  60
b00_8909:   ror $e9                     ; 909:  66 e9
b00_890b:   rol $f2                     ; 90B:  26 f2
b00_890d:   .db $04                     ; 90D:  04
b00_890e:   .db $d7                     ; 90E:  d7
b00_890f:   php                         ; 90F:  08
b00_8910:   .db $89                     ; 910:  89
b00_8911:   adc ($66,x)                 ; 911:  61 66
b00_8913:   sbc #$26                    ; 913:  e9 26
b00_8915:   .db $f2                     ; 915:  f2
b00_8916:   .db $04                     ; 916:  04
b00_8917:   .db $d7                     ; 917:  d7
b00_8918:   php                         ; 918:  08
b00_8919:   .db $89                     ; 919:  89
b00_891a:   rts                         ; 91A:  60
b00_891b:   ror $e9                     ; 91B:  66 e9
b00_891d:   rol $f2                     ; 91D:  26 f2
b00_891f:   .db $04                     ; 91F:  04
b00_8920:   .db $d7                     ; 920:  d7
b00_8921:   bit $6189                   ; 921:  2c 89 61
b00_8924:   ror $e9                     ; 924:  66 e9
b00_8926:   rol $f2                     ; 926:  26 f2
b00_8928:   .db $04                     ; 928:  04
b00_8929:   cld                         ; 929:  d8
b00_892a:   .db $1a                     ; 92A:  1a
b00_892b:   .db $89                     ; 92B:  89
b00_892c:   adc ($e9,x)                 ; 92C:  61 e9
b00_892e:   and $cc,x                   ; 92E:  35 cc
b00_8930:   .db $02                     ; 930:  02
b00_8931:   sta $8e51                   ; 931:  8d 51 8e
b00_8934:   brk                         ; 934:  00
b00_8935:   bpl $88c5                   ; 935:  10 8e
b00_8937:   tsx                         ; 937:  ba
b00_8938:   .db $b2                     ; 938:  b2
b00_8939:   rts                         ; 939:  60
b00_893a:   sbc #$7c                    ; 93A:  e9 7c
b00_893c:   .db $cf                     ; 93C:  cf
b00_893d:   php                         ; 93D:  08
b00_893e:   stx $00b1                   ; 93E:  8e b1 00
b00_8941:   stx $14d0                   ; 941:  8e d0 14
b00_8944:   stx $8264                   ; 944:  8e 64 82
b00_8947:   ror $e9                     ; 947:  66 e9
b00_8949:   .db $7c                     ; 949:  7c
b00_894a:   .db $cf                     ; 94A:  cf
b00_894b:   php                         ; 94B:  08
b00_894c:   ldy $cf50                   ; 94C:  ac 50 cf
b00_894f:   ldy $cf5d                   ; 94F:  ac 5d cf
b00_8952:   ror $8e                     ; 952:  66 8e
b00_8954:   .db $04                     ; 954:  04
b00_8955:   .db $80                     ; 955:  80
b00_8956:   sta $8d15                   ; 956:  8d 15 8d
b00_8959:   .db $1f                     ; 959:  1f
b00_895a:   .db $63                     ; 95A:  63
b00_895b:   rts                         ; 95B:  60
b00_895c:   sbc #$54                    ; 95C:  e9 54
b00_895e:   cpy $610c                   ; 95E:  cc 0c 61
b00_8961:   .db $67                     ; 961:  67
b00_8962:   sta $6311                   ; 962:  8d 11 63
b00_8965:   rts                         ; 965:  60
b00_8966:   sbc #$6a                    ; 966:  e9 6a
b00_8968:   .db $cf                     ; 968:  cf
b00_8969:   asl a                       ; 969:  0a
b00_896a:   adc ($8d,x)                 ; 96A:  61 8d
b00_896c:   .db $1a                     ; 96C:  1a
b00_896d:   sta $8d1d                   ; 96D:  8d 1d 8d
b00_8970:   .db $1a                     ; 970:  1a
b00_8971:   sta $e914                   ; 971:  8d 14 e9
b00_8974:   ror a                       ; 974:  6a
b00_8975:   .db $cf                     ; 975:  cf
b00_8976:   asl a                       ; 976:  0a
b00_8977:   sta $8d1a                   ; 977:  8d 1a 8d
b00_897a:   ora $e9,x                   ; 97A:  15 e9
b00_897c:   .db $7b                     ; 97C:  7b
b00_897d:   cpy $8e04                   ; 97D:  cc 04 8e
b00_8980:   .db $c3                     ; 980:  c3
b00_8981:   lda $c4e9,y                 ; 981:  b9 e9 c4
b00_8984:   dec $4002                   ; 984:  ce 02 40
b00_8987:   .db $2b                     ; 987:  2b
b00_8988:   .db $0b                     ; 988:  0b
b00_8989:   sty $b85a                   ; 989:  8c 5a b8
b00_898c:   .db $bb                     ; 98C:  bb
b00_898d:   .db $d3                     ; 98D:  d3
b00_898e:   .db $b3                     ; 98E:  b3
b00_898f:   .db $3b                     ; 98F:  3b
b00_8990:   sbc #$8b                    ; 990:  e9 8b
b00_8992:   .db $cf                     ; 992:  cf
b00_8993:   .db $04                     ; 993:  04
b00_8994:   .db $0b                     ; 994:  0b
b00_8995:   bne $89c2                   ; 995:  d0 2b
b00_8997:   .db $0b                     ; 997:  0b
b00_8998:   cli                         ; 998:  58
b00_8999:   dec $d7                     ; 999:  c6 d7
b00_899b:   dey                         ; 99B:  88
b00_899c:   .db $89                     ; 99C:  89
b00_899d:   rts                         ; 99D:  60
b00_899e:   sbc #$35                    ; 99E:  e9 35
b00_89a0:   cpy $cf02                   ; 9A0:  cc 02 cf
b00_89a3:   jsr $e823                   ; 9A3:  20 23 e8
b00_89a6:   inc $41ff,x                 ; 9A6:  fe ff 41
b00_89a9:   tay                         ; 9A9:  a8
b00_89aa:   eor $606f                   ; 9AA:  4d 6f 60
b00_89ad:   sbc #$03                    ; 9AD:  e9 03
b00_89af:   dex                         ; 9AF:  ca
b00_89b0:   .db $02                     ; 9B0:  02
b00_89b1:   ldy $88ac                   ; 9B1:  ac ac 88
b00_89b4:   rti                         ; 9B4:  40
b00_89b5:   tay                         ; 9B5:  a8
b00_89b6:   .db $e7                     ; 9B6:  e7
b00_89b7:   .db $7f                     ; 9B7:  7f
b00_89b8:   .db $89                     ; 9B8:  89
b00_89b9:   .db $32                     ; 9B9:  32
b00_89ba:   tay                         ; 9BA:  a8
b00_89bb:   adc $6d                     ; 9BB:  65 6d
b00_89bd:   rti                         ; 9BD:  40
b00_89be:   tay                         ; 9BE:  a8
b00_89bf:   .db $c7                     ; 9BF:  c7
b00_89c0:   .db $7f                     ; 9C0:  7f
b00_89c1:   rti                         ; 9C1:  40
b00_89c2:   tay                         ; 9C2:  a8
b00_89c3:   .db $d3                     ; 9C3:  d3
b00_89c4:   .db $7f                     ; 9C4:  7f
b00_89c5:   rti                         ; 9C5:  40
b00_89c6:   tay                         ; 9C6:  a8
b00_89c7:   cmp ($7f),y                 ; 9C7:  d1 7f
b00_89c9:   ldy $821e                   ; 9C9:  ac 1e 82
b00_89cc:   cld                         ; 9CC:  d8
b00_89cd:   .db $d7                     ; 9CD:  d7
b00_89ce:   .db $89                     ; 9CE:  89
b00_89cf:   rts                         ; 9CF:  60
b00_89d0:   rts                         ; 9D0:  60
b00_89d1:   ror a                       ; 9D1:  6a
b00_89d2:   sbc #$26                    ; 9D2:  e9 26
b00_89d4:   .db $f2                     ; 9D4:  f2
b00_89d5:   asl $cf                     ; 9D5:  06 cf
b00_89d7:   rti                         ; 9D7:  40
b00_89d8:   .db $2b                     ; 9D8:  2b
b00_89d9:   .db $0b                     ; 9D9:  0b
b00_89da:   sty $7fd5                   ; 9DA:  8c d5 7f
b00_89dd:   .db $bb                     ; 9DD:  bb
b00_89de:   .db $b3                     ; 9DE:  b3
b00_89df:   .db $89                     ; 9DF:  89
b00_89e0:   .db $ff                     ; 9E0:  ff
b00_89e1:   .db $d4                     ; 9E1:  d4
b00_89e2:   .db $0b                     ; 9E2:  0b
b00_89e3:   bne $8a10                   ; 9E3:  d0 2b
b00_89e5:   .db $0b                     ; 9E5:  0b
b00_89e6:   cli                         ; 9E6:  58
b00_89e7:   dec $d7                     ; 9E7:  c6 d7
b00_89e9:   cmp $ac89,y                 ; 9E9:  d9 89 ac
b00_89ec:   .db $2b                     ; 9EC:  2b
b00_89ed:   stx $40                     ; 9ED:  86 40
b00_89ef:   dec $fc,x                   ; 9EF:  d6 fc
b00_89f1:   .db $89                     ; 9F1:  89
b00_89f2:   .db $0b                     ; 9F2:  0b
b00_89f3:   sty $6f1b                   ; 9F3:  8c 1b 6f
b00_89f6:   .db $bb                     ; 9F6:  bb
b00_89f7:   .db $b3                     ; 9F7:  b3
b00_89f8:   .db $0b                     ; 9F8:  0b
b00_89f9:   .db $d4                     ; 9F9:  d4
b00_89fa:   .db $0b                     ; 9FA:  0b
b00_89fb:   bne $8a28                   ; 9FB:  d0 2b
b00_89fd:   .db $0b                     ; 9FD:  0b
b00_89fe:   ldx $9d                     ; 9FE:  a6 9d
b00_8a00:   adc $d7c6                   ; A00:  6d c6 d7
b00_8a03:   .db $f2                     ; A03:  f2
b00_8a04:   .db $89                     ; A04:  89
b00_8a05:   rti                         ; A05:  40
b00_8a06:   dec $13,x                   ; A06:  d6 13
b00_8a08:   txa                         ; A08:  8a
b00_8a09:   .db $0b                     ; A09:  0b
b00_8a0a:   sty $6cf7                   ; A0A:  8c f7 6c
b00_8a0d:   .db $bb                     ; A0D:  bb
b00_8a0e:   .db $b3                     ; A0E:  b3
b00_8a0f:   rti                         ; A0F:  40
b00_8a10:   .db $d4                     ; A10:  d4
b00_8a11:   .db $0b                     ; A11:  0b
b00_8a12:   bne $8a3f                   ; A12:  d0 2b
b00_8a14:   ldy $9d                     ; A14:  a4 9d
b00_8a16:   adc $b374                   ; A16:  6d 74 b3
b00_8a19:   .db $0b                     ; A19:  0b
b00_8a1a:   ldy $c6,x                   ; A1A:  b4 c6
b00_8a1c:   .db $d7                     ; A1C:  d7
b00_8a1d:   ora #$8a                    ; A1D:  09 8a
b00_8a1f:   stx $b9cd                   ; A1F:  8e cd b9
b00_8a22:   sbc #$26                    ; A22:  e9 26
b00_8a24:   .db $d3                     ; A24:  d3
b00_8a25:   .db $02                     ; A25:  02
b00_8a26:   pla                         ; A26:  68
b00_8a27:   adc ($e9,x)                 ; A27:  61 e9
b00_8a29:   sbc #$d5                    ; A29:  e9 d5
b00_8a2b:   .db $04                     ; A2B:  04
b00_8a2c:   tay                         ; A2C:  a8
b00_8a2d:   adc ($6d,x)                 ; A2D:  61 6d
b00_8a2f:   cld                         ; A2F:  d8
b00_8a30:   .db $1f                     ; A30:  1f
b00_8a31:   txa                         ; A31:  8a
b00_8a32:   rti                         ; A32:  40
b00_8a33:   .db $2b                     ; A33:  2b
b00_8a34:   .db $0b                     ; A34:  0b
b00_8a35:   .db $d2                     ; A35:  d2
b00_8a36:   sty $6e0b                   ; A36:  8c 0b 6e
b00_8a39:   .db $bb                     ; A39:  bb
b00_8a3a:   .db $b3                     ; A3A:  b3
b00_8a3b:   ror a                       ; A3B:  6a
b00_8a3c:   sbc #$52                    ; A3C:  e9 52
b00_8a3e:   dex                         ; A3E:  ca
b00_8a3f:   .db $02                     ; A3F:  02
b00_8a40:   sei                         ; A40:  78
b00_8a41:   lda ($0b),y                 ; A41:  b1 0b
b00_8a43:   bne $8a70                   ; A43:  d0 2b
b00_8a45:   .db $0b                     ; A45:  0b
b00_8a46:   eor $c6,x                   ; A46:  55 c6
b00_8a48:   .db $d7                     ; A48:  d7
b00_8a49:   .db $34                     ; A49:  34
b00_8a4a:   txa                         ; A4A:  8a
b00_8a4b:   ldy $cd20                   ; A4B:  ac 20 cd
b00_8a4e:   eor ($a8,x)                 ; A4E:  41 a8
b00_8a50:   cmp ($7f),y                 ; A50:  d1 7f
b00_8a52:   adc ($e9,x)                 ; A52:  61 e9
b00_8a54:   and $cc,x                   ; A54:  35 cc
b00_8a56:   .db $02                     ; A56:  02
b00_8a57:   .db $64                     ; A57:  64
b00_8a58:   stx $14d0                   ; A58:  8e d0 14
b00_8a5b:   stx $b78a                   ; A5B:  8e 8a b7
b00_8a5e:   rts                         ; A5E:  60
b00_8a5f:   sbc #$7c                    ; A5F:  e9 7c
b00_8a61:   .db $cf                     ; A61:  cf
b00_8a62:   php                         ; A62:  08
b00_8a63:   stx $009a                   ; A63:  8e 9a 00
b00_8a66:   stx $1510                   ; A66:  8e 10 15
b00_8a69:   stx $83bc                   ; A69:  8e bc 83
b00_8a6c:   .db $64                     ; A6C:  64
b00_8a6d:   sbc #$7c                    ; A6D:  e9 7c
b00_8a6f:   .db $cf                     ; A6F:  cf
b00_8a70:   php                         ; A70:  08
b00_8a71:   rti                         ; A71:  40
b00_8a72:   .db $2b                     ; A72:  2b
b00_8a73:   .db $0b                     ; A73:  0b
b00_8a74:   sty $b852                   ; A74:  8c 52 b8
b00_8a77:   .db $bb                     ; A77:  bb
b00_8a78:   .db $d3                     ; A78:  d3
b00_8a79:   .db $b3                     ; A79:  b3
b00_8a7a:   .db $3b                     ; A7A:  3b
b00_8a7b:   sbc #$8b                    ; A7B:  e9 8b
b00_8a7d:   .db $cf                     ; A7D:  cf
b00_8a7e:   .db $04                     ; A7E:  04
b00_8a7f:   .db $0b                     ; A7F:  0b
b00_8a80:   bne $8aad                   ; A80:  d0 2b
b00_8a82:   .db $0b                     ; A82:  0b
b00_8a83:   cli                         ; A83:  58
b00_8a84:   dec $d7                     ; A84:  c6 d7
b00_8a86:   .db $73                     ; A86:  73
b00_8a87:   txa                         ; A87:  8a
b00_8a88:   rts                         ; A88:  60
b00_8a89:   sbc #$35                    ; A89:  e9 35
b00_8a8b:   cpy $4102                   ; A8B:  cc 02 41
b00_8a8e:   dec $bc,x                   ; A8E:  d6 bc
b00_8a90:   txa                         ; A90:  8a
b00_8a91:   ldy $cd20                   ; A91:  ac 20 cd
b00_8a94:   sta $6721                   ; A94:  8d 21 67
b00_8a97:   sbc #$8b                    ; A97:  e9 8b
b00_8a99:   .db $cf                     ; A99:  cf
b00_8a9a:   .db $04                     ; A9A:  04
b00_8a9b:   sta $6b30                   ; A9B:  8d 30 6b
b00_8a9e:   sbc #$8b                    ; A9E:  e9 8b
b00_8aa0:   .db $cf                     ; AA0:  cf
b00_8aa1:   .db $04                     ; AA1:  04
b00_8aa2:   .db $0b                     ; AA2:  0b
b00_8aa3:   eor ($da),y                 ; AA3:  51 da
b00_8aa5:   eor ($c0),y                 ; AA5:  51 c0
b00_8aa7:   cld                         ; AA7:  d8
b00_8aa8:   ldx $408a                   ; AA8:  ae 8a 40
b00_8aab:   dec $af,x                   ; AAB:  d6 af
b00_8aad:   txa                         ; AAD:  8a
b00_8aae:   .db $44                     ; AAE:  44
b00_8aaf:   tay                         ; AAF:  a8
b00_8ab0:   .db $d3                     ; AB0:  d3
b00_8ab1:   .db $7f                     ; AB1:  7f
b00_8ab2:   .db $3b                     ; AB2:  3b
b00_8ab3:   sbc #$94                    ; AB3:  e9 94
b00_8ab5:   stx $02                     ; AB5:  86 02
b00_8ab7:   ldy $8763                   ; AB7:  ac 63 87
b00_8aba:   .db $0b                     ; ABA:  0b
b00_8abb:   bne $8ae8                   ; ABB:  d0 2b
b00_8abd:   .db $0b                     ; ABD:  0b
b00_8abe:   ldx $61                     ; ABE:  a6 61
b00_8ac0:   adc $d7c7                   ; AC0:  6d c7 d7
b00_8ac3:   sta ($8a),y                 ; AC3:  91 8a
b00_8ac5:   rti                         ; AC5:  40
b00_8ac6:   tay                         ; AC6:  a8
b00_8ac7:   .db $d3                     ; AC7:  d3
b00_8ac8:   .db $7f                     ; AC8:  7f
b00_8ac9:   stx $b9de                   ; AC9:  8e de b9
b00_8acc:   sbc #$26                    ; ACC:  e9 26
b00_8ace:   .db $d3                     ; ACE:  d3
b00_8acf:   .db $02                     ; ACF:  02
b00_8ad0:   adc $61                     ; AD0:  65 61
b00_8ad2:   sbc #$e9                    ; AD2:  e9 e9
b00_8ad4:   cmp $04,x                   ; AD4:  d5 04
b00_8ad6:   tay                         ; AD6:  a8
b00_8ad7:   .db $63                     ; AD7:  63
b00_8ad8:   adc $c9d8                   ; AD8:  6d d8 c9
b00_8adb:   txa                         ; ADB:  8a
b00_8adc:   stx $b9f8                   ; ADC:  8e f8 b9
b00_8adf:   sbc #$26                    ; ADF:  e9 26
b00_8ae1:   .db $d3                     ; AE1:  d3
b00_8ae2:   .db $02                     ; AE2:  02
b00_8ae3:   ldy $d3a7                   ; AE3:  ac a7 d3
b00_8ae6:   .db $d7                     ; AE6:  d7
b00_8ae7:   .db $44                     ; AE7:  44
b00_8ae8:   .db $8b                     ; AE8:  8b
b00_8ae9:   ldy $cd20                   ; AE9:  ac 20 cd
b00_8aec:   adc ($e9,x)                 ; AEC:  61 e9
b00_8aee:   and $cc,x                   ; AEE:  35 cc
b00_8af0:   .db $02                     ; AF0:  02
b00_8af1:   stx $00b1                   ; AF1:  8e b1 00
b00_8af4:   stx $14d0                   ; AF4:  8e d0 14
b00_8af7:   stx $8264                   ; AF7:  8e 64 82
b00_8afa:   ror $e9                     ; AFA:  66 e9
b00_8afc:   .db $7c                     ; AFC:  7c
b00_8afd:   .db $cf                     ; AFD:  cf
b00_8afe:   php                         ; AFE:  08
b00_8aff:   ror $8e                     ; AFF:  66 8e
b00_8b01:   .db $04                     ; B01:  04
b00_8b02:   .db $80                     ; B02:  80
b00_8b03:   sta $8d15                   ; B03:  8d 15 8d
b00_8b06:   .db $1f                     ; B06:  1f
b00_8b07:   .db $63                     ; B07:  63
b00_8b08:   rts                         ; B08:  60
b00_8b09:   sbc #$54                    ; B09:  e9 54
b00_8b0b:   cpy $610c                   ; B0B:  cc 0c 61
b00_8b0e:   .db $67                     ; B0E:  67
b00_8b0f:   sta $6311                   ; B0F:  8d 11 63
b00_8b12:   rts                         ; B12:  60
b00_8b13:   sbc #$6a                    ; B13:  e9 6a
b00_8b15:   .db $cf                     ; B15:  cf
b00_8b16:   asl a                       ; B16:  0a
b00_8b17:   rti                         ; B17:  40
b00_8b18:   .db $2b                     ; B18:  2b
b00_8b19:   .db $0b                     ; B19:  0b
b00_8b1a:   cli                         ; B1A:  58
b00_8b1b:   dec $d8                     ; B1B:  c6 d8
b00_8b1d:   rol $8b                     ; B1D:  26 8b
b00_8b1f:   .db $0b                     ; B1F:  0b
b00_8b20:   sty $b85a                   ; B20:  8c 5a b8
b00_8b23:   dec $2a,x                   ; B23:  d6 2a
b00_8b25:   .db $8b                     ; B25:  8b
b00_8b26:   .db $0b                     ; B26:  0b
b00_8b27:   sty $b862                   ; B27:  8c 62 b8
b00_8b2a:   .db $bb                     ; B2A:  bb
b00_8b2b:   .db $d3                     ; B2B:  d3
b00_8b2c:   .db $b3                     ; B2C:  b3
b00_8b2d:   .db $3b                     ; B2D:  3b
b00_8b2e:   sbc #$8b                    ; B2E:  e9 8b
b00_8b30:   .db $cf                     ; B30:  cf
b00_8b31:   .db $04                     ; B31:  04
b00_8b32:   .db $0b                     ; B32:  0b
b00_8b33:   bne $8b60                   ; B33:  d0 2b
b00_8b35:   .db $0b                     ; B35:  0b
b00_8b36:   .db $8b                     ; B36:  8b
b00_8b37:   jsr $d7c6                   ; B37:  20 c6 d7
b00_8b3a:   ora $608b,y                 ; B3A:  19 8b 60
b00_8b3d:   sbc #$35                    ; B3D:  e9 35
b00_8b3f:   cpy $d602                   ; B3F:  cc 02 d6
b00_8b42:   cmp ($89,x)                 ; B42:  c1 89
b00_8b44:   stx $ba10                   ; B44:  8e 10 ba
b00_8b47:   sbc #$26                    ; B47:  e9 26
b00_8b49:   .db $d3                     ; B49:  d3
b00_8b4a:   .db $02                     ; B4A:  02
b00_8b4b:   pha                         ; B4B:  48
b00_8b4c:   ldx $61                     ; B4C:  a6 61
b00_8b4e:   adc $a8bc                   ; B4E:  6d bc a8
b00_8b51:   ora #$6e                    ; B51:  09 6e
b00_8b53:   ldy $83e2                   ; B53:  ac e2 83
b00_8b56:   eor ($a8,x)                 ; B56:  41 a8
b00_8b58:   .db $c7                     ; B58:  c7
b00_8b59:   .db $7f                     ; B59:  7f
b00_8b5a:   rts                         ; B5A:  60
b00_8b5b:   rts                         ; B5B:  60
b00_8b5c:   ror a                       ; B5C:  6a
b00_8b5d:   sbc #$26                    ; B5D:  e9 26
b00_8b5f:   .db $f2                     ; B5F:  f2
b00_8b60:   asl $8d                     ; B60:  06 8d
b00_8b62:   and ($67,x)                 ; B62:  21 67
b00_8b64:   sbc #$8b                    ; B64:  e9 8b
b00_8b66:   .db $cf                     ; B66:  cf
b00_8b67:   .db $04                     ; B67:  04
b00_8b68:   sta $6b30                   ; B68:  8d 30 6b
b00_8b6b:   sbc #$8b                    ; B6B:  e9 8b
b00_8b6d:   .db $cf                     ; B6D:  cf
b00_8b6e:   .db $04                     ; B6E:  04
b00_8b6f:   .db $cf                     ; B6F:  cf
b00_8b70:   jsr $e823                   ; B70:  20 23 e8
b00_8b73:   inc $0cff,x                 ; B73:  fe ff 0c
b00_8b76:   sty $7b79                   ; B76:  8c 79 7b
b00_8b79:   .db $bb                     ; B79:  bb
b00_8b7a:   .db $d3                     ; B7A:  d3
b00_8b7b:   lsr $c0,x                   ; B7B:  56 c0
b00_8b7d:   cld                         ; B7D:  d8
b00_8b7e:   stx $8b                     ; B7E:  86 8b
b00_8b80:   txa                         ; B80:  8a
b00_8b81:   plp                         ; B81:  28
b00_8b82:   tsx                         ; B82:  ba
b00_8b83:   dec $9a,x                   ; B83:  d6 9a
b00_8b85:   .db $8b                     ; B85:  8b
b00_8b86:   .db $0c                     ; B86:  0c
b00_8b87:   sty $7b79                   ; B87:  8c 79 7b
b00_8b8a:   .db $bb                     ; B8A:  bb
b00_8b8b:   .db $d3                     ; B8B:  d3
b00_8b8c:   .db $57                     ; B8C:  57
b00_8b8d:   cpy #$d8                    ; B8D:  c0 d8
b00_8b8f:   .db $97                     ; B8F:  97
b00_8b90:   .db $8b                     ; B90:  8b
b00_8b91:   txa                         ; B91:  8a
b00_8b92:   and ($ba),y                 ; B92:  31 ba
b00_8b94:   dec $9a,x                   ; B94:  d6 9a
b00_8b96:   .db $8b                     ; B96:  8b
b00_8b97:   txa                         ; B97:  8a
b00_8b98:   .db $3a                     ; B98:  3a
b00_8b99:   tsx                         ; B99:  ba
b00_8b9a:   .db $2b                     ; B9A:  2b
b00_8b9b:   .db $0b                     ; B9B:  0b
b00_8b9c:   .db $cf                     ; B9C:  cf
b00_8b9d:   jsr $e823                   ; B9D:  20 23 e8
b00_8ba0:   inc $a5ff,x                 ; BA0:  fe ff a5
b00_8ba3:   lda ($6d,x)                 ; BA3:  a1 6d
b00_8ba5:   .db $8b                     ; BA5:  8b
b00_8ba6:   jsr $d8da                   ; BA6:  20 da d8
b00_8ba9:   .db $af                     ; BA9:  af
b00_8baa:   .db $8b                     ; BAA:  8b
b00_8bab:   txa                         ; BAB:  8a
b00_8bac:   eor $ba,x                   ; BAC:  55 ba
b00_8bae:   .db $cf                     ; BAE:  cf
b00_8baf:   lda $a1                     ; BAF:  a5 a1
b00_8bb1:   adc $108b                   ; BB1:  6d 8b 10
b00_8bb4:   .db $da                     ; BB4:  da
b00_8bb5:   cld                         ; BB5:  d8
b00_8bb6:   ldy $8a8b,x                 ; BB6:  bc 8b 8a
b00_8bb9:   ror a                       ; BB9:  6a
b00_8bba:   adc $0ccf,y                 ; BBA:  79 cf 0c
b00_8bbd:   cmp $0004,y                 ; BBD:  d9 04 00
b00_8bc0:   .db $07                     ; BC0:  07
b00_8bc1:   brk                         ; BC1:  00
b00_8bc2:   .db $d2                     ; BC2:  d2
b00_8bc3:   .db $8b                     ; BC3:  8b
b00_8bc4:   ora $d800                   ; BC4:  0d 00 d8
b00_8bc7:   .db $8b                     ; BC7:  8b
b00_8bc8:   .db $17                     ; BC8:  17
b00_8bc9:   brk                         ; BC9:  00
b00_8bca:   .db $d2                     ; BCA:  d2
b00_8bcb:   .db $8b                     ; BCB:  8b
b00_8bcc:   asl $d800,x                 ; BCC:  1e 00 d8
b00_8bcf:   .db $8b                     ; BCF:  8b
b00_8bd0:   dec $8a8b,x                 ; BD0:  de 8b 8a
b00_8bd3:   .db $43                     ; BD3:  43
b00_8bd4:   tsx                         ; BD4:  ba
b00_8bd5:   .db $2b                     ; BD5:  2b
b00_8bd6:   .db $0b                     ; BD6:  0b
b00_8bd7:   .db $cf                     ; BD7:  cf
b00_8bd8:   txa                         ; BD8:  8a
b00_8bd9:   jmp $d6ba                   ; BD9:  4c ba d6
b00_8bdc:   cmp $8b,x                   ; BDC:  d5 8b
b00_8bde:   .db $3c                     ; BDE:  3c
b00_8bdf:   sbc #$70                    ; BDF:  e9 70
b00_8be1:   .db $8b                     ; BE1:  8b
b00_8be2:   .db $02                     ; BE2:  02
b00_8be3:   dec $d5,x                   ; BE3:  d6 d5
b00_8be5:   .db $8b                     ; BE5:  8b
b00_8be6:   jsr $e823                   ; BE6:  20 23 e8
b00_8be9:   inc $acff,x                 ; BE9:  fe ff ac
b00_8bec:   ldx #$e4                    ; BEC:  a2 e4
b00_8bee:   txa                         ; BEE:  8a
b00_8bef:   .db $89                     ; BEF:  89
b00_8bf0:   .db $6f                     ; BF0:  6f
b00_8bf1:   dec $03,x                   ; BF1:  d6 03
b00_8bf3:   sty $d30b                   ; BF3:  8c 0b d3
b00_8bf6:   .db $b3                     ; BF6:  b3
b00_8bf7:   sbc #$b7                    ; BF7:  e9 b7
b00_8bf9:   cmp $d802,y                 ; BF9:  d9 02 d8
b00_8bfc:   ora ($8c,x)                 ; BFC:  01 8c
b00_8bfe:   .db $0b                     ; BFE:  0b
b00_8bff:   .db $d3                     ; BFF:  d3
b00_8c00:   .db $cf                     ; C00:  cf
b00_8c01:   .db $0b                     ; C01:  0b
b00_8c02:   bne $8c2f                   ; C02:  d0 2b
b00_8c04:   .db $0b                     ; C04:  0b
b00_8c05:   .db $d3                     ; C05:  d3
b00_8c06:   sty $00ff                   ; C06:  8c ff 00
b00_8c09:   cmp ($d7,x)                 ; C09:  c1 d7
b00_8c0b:   .db $f4                     ; C0B:  f4
b00_8c0c:   .db $8b                     ; C0C:  8b
b00_8c0d:   .db $cf                     ; C0D:  cf
b00_8c0e:   jsr $e823                   ; C0E:  20 23 e8
b00_8c11:   brk                         ; C11:  00
b00_8c12:   brk                         ; C12:  00
b00_8c13:   ldy $5f                     ; C13:  a4 5f
b00_8c15:   .db $6f                     ; C15:  6f
b00_8c16:   sty $6cf7                   ; C16:  8c f7 6c
b00_8c19:   .db $bb                     ; C19:  bb
b00_8c1a:   .db $d3                     ; C1A:  d3
b00_8c1b:   eor $c0,x                   ; C1B:  55 c0
b00_8c1d:   .db $cf                     ; C1D:  cf
b00_8c1e:   jsr $e823                   ; C1E:  20 23 e8
b00_8c21:   brk                         ; C21:  00
b00_8c22:   brk                         ; C22:  00
b00_8c23:   ldy $d9a9                   ; C23:  ac a9 d9
b00_8c26:   cld                         ; C26:  d8
b00_8c27:   .db $2f                     ; C27:  2f
b00_8c28:   sty $0eac                   ; C28:  8c ac 0e
b00_8c2b:   sty $33d7                   ; C2B:  8c d7 33
b00_8c2e:   sty $d640                   ; C2E:  8c 40 d6
b00_8c31:   .db $34                     ; C31:  34
b00_8c32:   sty $cf41                   ; C32:  8c 41 cf
b00_8c35:   jsr $e823                   ; C35:  20 23 e8
b00_8c38:   brk                         ; C38:  00
b00_8c39:   brk                         ; C39:  00
b00_8c3a:   .db $0c                     ; C3A:  0c
b00_8c3b:   .db $8b                     ; C3B:  8b
b00_8c3c:   rol $b5,x                   ; C3C:  36 b5
b00_8c3e:   ora $8cbb,x                 ; C3E:  1d bb 8c
b00_8c41:   .db $93                     ; C41:  93
b00_8c42:   adc ($bb,x)                 ; C42:  61 bb
b00_8c44:   .db $cf                     ; C44:  cf
b00_8c45:   jsr $e823                   ; C45:  20 23 e8
b00_8c48:   .db $fc                     ; C48:  fc
b00_8c49:   .db $ff                     ; C49:  ff
b00_8c4a:   rti                         ; C4A:  40
b00_8c4b:   .db $2b                     ; C4B:  2b
b00_8c4c:   ldy $9d                     ; C4C:  a4 9d
b00_8c4e:   adc $68d6                   ; C4E:  6d d6 68
b00_8c51:   sty $8c0a                   ; C51:  8c 0a 8c
b00_8c54:   .db $1a                     ; C54:  1a
b00_8c55:   .db $6f                     ; C55:  6f
b00_8c56:   .db $bb                     ; C56:  bb
b00_8c57:   .db $d3                     ; C57:  d3
b00_8c58:   tay                         ; C58:  a8
b00_8c59:   .db $5f                     ; C59:  5f
b00_8c5a:   .db $6f                     ; C5A:  6f
b00_8c5b:   ldy $8c1e                   ; C5B:  ac 1e 8c
b00_8c5e:   cld                         ; C5E:  d8
b00_8c5f:   ror $8c                     ; C5F:  66 8c
b00_8c61:   eor ($2b,x)                 ; C61:  41 2b
b00_8c63:   dec $6d,x                   ; C63:  d6 6d
b00_8c65:   sty $d10a                   ; C65:  8c 0a d1
b00_8c68:   rol a                       ; C68:  2a
b00_8c69:   asl a                       ; C69:  0a
b00_8c6a:   .db $d7                     ; C6A:  d7
b00_8c6b:   .db $52                     ; C6B:  52
b00_8c6c:   sty $d70b                   ; C6C:  8c 0b d7
b00_8c6f:   .db $74                     ; C6F:  74
b00_8c70:   sty $62ac                   ; C70:  8c ac 62
b00_8c73:   cmp $20cf,y                 ; C73:  d9 cf 20
b00_8c76:   .db $23                     ; C76:  23
b00_8c77:   inx                         ; C77:  e8
b00_8c78:   .db $f4                     ; C78:  f4
b00_8c79:   .db $ff                     ; C79:  ff
b00_8c7a:   rti                         ; C7A:  40
b00_8c7b:   .db $27                     ; C7B:  27
b00_8c7c:   rti                         ; C7C:  40
b00_8c7d:   plp                         ; C7D:  28
b00_8c7e:   .db $0c                     ; C7E:  0c
b00_8c7f:   .db $52                     ; C7F:  52
b00_8c80:   dec $d8                     ; C80:  c6 d8
b00_8c82:   sty $aa8c                   ; C82:  8c 8c aa
b00_8c85:   .db $63                     ; C85:  63
b00_8c86:   .db $6f                     ; C86:  6f
b00_8c87:   sbc #$1b                    ; C87:  e9 1b
b00_8c89:   .db $e2                     ; C89:  e2
b00_8c8a:   .db $02                     ; C8A:  02
b00_8c8b:   .db $cf                     ; C8B:  cf
b00_8c8c:   rti                         ; C8C:  40
b00_8c8d:   .db $2b                     ; C8D:  2b
b00_8c8e:   txa                         ; C8E:  8a
b00_8c8f:   .db $4f                     ; C8F:  4f
b00_8c90:   .db $6f                     ; C90:  6f
b00_8c91:   and #$d6                    ; C91:  29 d6
b00_8c93:   rol $8d,x                   ; C93:  36 8d
b00_8c95:   ora #$d3                    ; C95:  09 d3
b00_8c97:   tay                         ; C97:  a8
b00_8c98:   .db $5f                     ; C98:  5f
b00_8c99:   .db $6f                     ; C99:  6f
b00_8c9a:   ldy $8be6                   ; C9A:  ac e6 8b
b00_8c9d:   tay                         ; C9D:  a8
b00_8c9e:   .db $5f                     ; C9E:  5f
b00_8c9f:   .db $6f                     ; C9F:  6f
b00_8ca0:   tax                         ; CA0:  aa
b00_8ca1:   .db $5f                     ; CA1:  5f
b00_8ca2:   .db $6f                     ; CA2:  6f
b00_8ca3:   sbc #$8d                    ; CA3:  e9 8d
b00_8ca5:   cmp $d802,y                 ; CA5:  d9 02 d8
b00_8ca8:   asl a                       ; CA8:  0a
b00_8ca9:   sta $7eac                   ; CA9:  8d ac 7e
b00_8cac:   .db $d7                     ; CAC:  d7
b00_8cad:   sty $6d67                   ; CAD:  8c 67 6d
b00_8cb0:   .db $bb                     ; CB0:  bb
b00_8cb1:   .db $d3                     ; CB1:  d3
b00_8cb2:   .db $d7                     ; CB2:  d7
b00_8cb3:   .db $22                     ; CB3:  22
b00_8cb4:   sta $5fa4                   ; CB4:  8d a4 5f
b00_8cb7:   .db $6f                     ; CB7:  6f
b00_8cb8:   .db $8b                     ; CB8:  8b
b00_8cb9:   .db $1a                     ; CB9:  1a
b00_8cba:   lda $8c,x                   ; CBA:  b5 8c
b00_8cbc:   ora ($70,x)                 ; CBC:  01 70
b00_8cbe:   .db $bb                     ; CBE:  bb
b00_8cbf:   bcs $8d11                   ; CBF:  b0 50
b00_8cc1:   cpy $d8                     ; CC1:  c4 d8
b00_8cc3:   .db $22                     ; CC3:  22
b00_8cc4:   sta $1c8d                   ; CC4:  8d 8d 1c
b00_8cc7:   sbc #$03                    ; CC7:  e9 03
b00_8cc9:   dex                         ; CC9:  ca
b00_8cca:   .db $02                     ; CCA:  02
b00_8ccb:   stx $ba5e                   ; CCB:  8e 5e ba
b00_8cce:   sbc #$26                    ; CCE:  e9 26
b00_8cd0:   .db $d3                     ; CD0:  d3
b00_8cd1:   .db $02                     ; CD1:  02
b00_8cd2:   ora #$d3                    ; CD2:  09 d3
b00_8cd4:   .db $b3                     ; CD4:  b3
b00_8cd5:   sbc #$8b                    ; CD5:  e9 8b
b00_8cd7:   .db $d7                     ; CD7:  d7
b00_8cd8:   .db $02                     ; CD8:  02
b00_8cd9:   ldy $63                     ; CD9:  a4 63
b00_8cdb:   .db $6f                     ; CDB:  6f
b00_8cdc:   bne $8c91                   ; CDC:  d0 b3
b00_8cde:   stx $ba5f                   ; CDE:  8e 5f ba
b00_8ce1:   sbc #$34                    ; CE1:  e9 34
b00_8ce3:   cmp ($04),y                 ; CE3:  d1 04
b00_8ce5:   ldy $d3a7                   ; CE5:  ac a7 d3
b00_8ce8:   cld                         ; CE8:  d8
b00_8ce9:   .db $22                     ; CE9:  22
b00_8cea:   sta $838e                   ; CEA:  8d 8e 83
b00_8ced:   tsx                         ; CED:  ba
b00_8cee:   sbc #$26                    ; CEE:  e9 26
b00_8cf0:   .db $d3                     ; CF0:  d3
b00_8cf1:   .db $02                     ; CF1:  02
b00_8cf2:   ldy $5f                     ; CF2:  a4 5f
b00_8cf4:   .db $6f                     ; CF4:  6f
b00_8cf5:   .db $8b                     ; CF5:  8b
b00_8cf6:   .db $1a                     ; CF6:  1a
b00_8cf7:   lda $8c,x                   ; CF7:  b5 8c
b00_8cf9:   ora ($70,x)                 ; CF9:  01 70
b00_8cfb:   .db $bb                     ; CFB:  bb
b00_8cfc:   bcs $8cb1                   ; CFC:  b0 b3
b00_8cfe:   adc ($e9,x)                 ; CFE:  61 e9
b00_8d00:   sbc #$d5                    ; D00:  e9 d5
b00_8d02:   .db $04                     ; D02:  04
b00_8d03:   plp                         ; D03:  28
b00_8d04:   ldy $cc89                   ; D04:  ac 89 cc
b00_8d07:   dec $22,x                   ; D07:  d6 22
b00_8d09:   sta $5fa4                   ; D09:  8d a4 5f
b00_8d0c:   .db $6f                     ; D0C:  6f
b00_8d0d:   .db $8b                     ; D0D:  8b
b00_8d0e:   .db $1a                     ; D0E:  1a
b00_8d0f:   lda $8c,x                   ; D0F:  b5 8c
b00_8d11:   ora ($70,x)                 ; D11:  01 70
b00_8d13:   .db $bb                     ; D13:  bb
b00_8d14:   bcs $8d3c                   ; D14:  b0 26
b00_8d16:   asl $18                     ; D16:  06 18
b00_8d18:   cpy $d8                     ; D18:  c4 d8
b00_8d1a:   .db $22                     ; D1A:  22
b00_8d1b:   sta $e936                   ; D1B:  8d 36 e9
b00_8d1e:   .db $52                     ; D1E:  52
b00_8d1f:   dex                         ; D1F:  ca
b00_8d20:   .db $02                     ; D20:  02
b00_8d21:   plp                         ; D21:  28
b00_8d22:   .db $07                     ; D22:  07
b00_8d23:   clc                         ; D23:  18
b00_8d24:   .db $c2                     ; D24:  c2
b00_8d25:   cld                         ; D25:  d8
b00_8d26:   rol $088d                   ; D26:  2e 8d 08
b00_8d29:   .db $27                     ; D29:  27
b00_8d2a:   ldy $5f                     ; D2A:  a4 5f
b00_8d2c:   .db $6f                     ; D2C:  6f
b00_8d2d:   rol a                       ; D2D:  2a
b00_8d2e:   ora #$d0                    ; D2E:  09 d0
b00_8d30:   and #$d1                    ; D30:  29 d1
b00_8d32:   .db $0b                     ; D32:  0b
b00_8d33:   bne $8d60                   ; D33:  d0 2b
b00_8d35:   cmp ($09),y                 ; D35:  d1 09
b00_8d37:   .db $d3                     ; D37:  d3
b00_8d38:   sty $00ff                   ; D38:  8c ff 00
b00_8d3b:   cmp ($d7,x)                 ; D3B:  c1 d7
b00_8d3d:   sta $8c,x                   ; D3D:  95 8c
b00_8d3f:   .db $07                     ; D3F:  07
b00_8d40:   .db $d7                     ; D40:  d7
b00_8d41:   eor $aa8d                   ; D41:  4d 8d aa
b00_8d44:   .db $63                     ; D44:  63
b00_8d45:   .db $6f                     ; D45:  6f
b00_8d46:   sbc #$1b                    ; D46:  e9 1b
b00_8d48:   .db $e2                     ; D48:  e2
b00_8d49:   .db $02                     ; D49:  02
b00_8d4a:   dec $e0,x                   ; D4A:  d6 e0
b00_8d4c:   sta $63a4                   ; D4C:  8d a4 63
b00_8d4f:   .db $6f                     ; D4F:  6f
b00_8d50:   sty $6cf7                   ; D50:  8c f7 6c
b00_8d53:   .db $bb                     ; D53:  bb
b00_8d54:   .db $b3                     ; D54:  b3
b00_8d55:   .db $3a                     ; D55:  3a
b00_8d56:   sbc #$8d                    ; D56:  e9 8d
b00_8d58:   cmp $d802,y                 ; D58:  d9 02 d8
b00_8d5b:   adc ($8d,x)                 ; D5B:  61 8d
b00_8d5d:   eor $d6                     ; D5D:  45 d6
b00_8d5f:   .db $62                     ; D5F:  62
b00_8d60:   sta $d440                   ; D60:  8d 40 d4
b00_8d63:   ldy $63                     ; D63:  a4 63
b00_8d65:   .db $6f                     ; D65:  6f
b00_8d66:   sty $6da2                   ; D66:  8c a2 6d
b00_8d69:   .db $bb                     ; D69:  bb
b00_8d6a:   .db $b3                     ; D6A:  b3
b00_8d6b:   rti                         ; D6B:  40
b00_8d6c:   .db $d4                     ; D6C:  d4
b00_8d6d:   ldy $63                     ; D6D:  a4 63
b00_8d6f:   .db $6f                     ; D6F:  6f
b00_8d70:   sty $6e15                   ; D70:  8c 15 6e
b00_8d73:   .db $bb                     ; D73:  bb
b00_8d74:   .db $b3                     ; D74:  b3
b00_8d75:   .db $3a                     ; D75:  3a
b00_8d76:   sbc #$72                    ; D76:  e9 72
b00_8d78:   .db $d7                     ; D78:  d7
b00_8d79:   .db $02                     ; D79:  02
b00_8d7a:   .db $d4                     ; D7A:  d4
b00_8d7b:   sec                         ; D7B:  38
b00_8d7c:   asl a                       ; D7C:  0a
b00_8d7d:   .db $8b                     ; D7D:  8b
b00_8d7e:   .db $1a                     ; D7E:  1a
b00_8d7f:   lda $8c,x                   ; D7F:  b5 8c
b00_8d81:   ora ($70,x)                 ; D81:  01 70
b00_8d83:   .db $bb                     ; D83:  bb
b00_8d84:   ldy $b3,x                   ; D84:  b4 b3
b00_8d86:   bcs $8d44                   ; D86:  b0 bc
b00_8d88:   lda ($3a),y                 ; D88:  b1 3a
b00_8d8a:   sbc #$8d                    ; D8A:  e9 8d
b00_8d8c:   cmp $d802,y                 ; D8C:  d9 02 d8
b00_8d8f:   ldy $8e8d                   ; D8F:  ac 8d 8e
b00_8d92:   sty $e9ba                   ; D92:  8c ba e9
b00_8d95:   rol $d3                     ; D95:  26 d3
b00_8d97:   .db $02                     ; D97:  02
b00_8d98:   .db $3a                     ; D98:  3a
b00_8d99:   sbc #$8b                    ; D99:  e9 8b
b00_8d9b:   .db $d7                     ; D9B:  d7
b00_8d9c:   .db $02                     ; D9C:  02
b00_8d9d:   ldy $63                     ; D9D:  a4 63
b00_8d9f:   .db $6f                     ; D9F:  6f
b00_8da0:   bne $8d55                   ; DA0:  d0 b3
b00_8da2:   stx $ba8d                   ; DA2:  8e 8d ba
b00_8da5:   sbc #$34                    ; DA5:  e9 34
b00_8da7:   cmp ($04),y                 ; DA7:  d1 04
b00_8da9:   dec $d6,x                   ; DA9:  d6 d6
b00_8dab:   sta $a18e                   ; DAB:  8d 8e a1
b00_8dae:   tsx                         ; DAE:  ba
b00_8daf:   sbc #$26                    ; DAF:  e9 26
b00_8db1:   .db $d3                     ; DB1:  d3
b00_8db2:   .db $02                     ; DB2:  02
b00_8db3:   ldy $63                     ; DB3:  a4 63
b00_8db5:   .db $6f                     ; DB5:  6f
b00_8db6:   bne $8d6b                   ; DB6:  d0 b3
b00_8db8:   stx $baa7                   ; DB8:  8e a7 ba
b00_8dbb:   sbc #$34                    ; DBB:  e9 34
b00_8dbd:   cmp ($04),y                 ; DBD:  d1 04
b00_8dbf:   .db $3a                     ; DBF:  3a
b00_8dc0:   sbc #$72                    ; DC0:  e9 72
b00_8dc2:   .db $d7                     ; DC2:  d7
b00_8dc3:   .db $02                     ; DC3:  02
b00_8dc4:   eor $8cb5,y                 ; DC4:  59 b5 8c
b00_8dc7:   tay                         ; DC7:  a8
b00_8dc8:   .db $77                     ; DC8:  77
b00_8dc9:   .db $bb                     ; DC9:  bb
b00_8dca:   .db $b3                     ; DCA:  b3
b00_8dcb:   sbc #$c4                    ; DCB:  e9 c4
b00_8dcd:   dec $8e02                   ; DCD:  ce 02 8e
b00_8dd0:   .db $b3                     ; DD0:  b3
b00_8dd1:   tsx                         ; DD1:  ba
b00_8dd2:   sbc #$c4                    ; DD2:  e9 c4
b00_8dd4:   dec $aa02                   ; DD4:  ce 02 aa
b00_8dd7:   .db $63                     ; DD7:  63
b00_8dd8:   .db $6f                     ; DD8:  6f
b00_8dd9:   sbc #$54                    ; DD9:  e9 54
b00_8ddb:   sbc $02                     ; DDB:  e5 02
b00_8ddd:   ldy $d766                   ; DDD:  ac 66 d7
b00_8de0:   .db $cf                     ; DE0:  cf
b00_8de1:   jsr $e823                   ; DE1:  20 23 e8
b00_8de4:   .db $f2                     ; DE4:  f2
b00_8de5:   .db $ff                     ; DE5:  ff
b00_8de6:   .db $0c                     ; DE6:  0c
b00_8de7:   bne $8e15                   ; DE7:  d0 2c
b00_8de9:   cmp ($d3),y                 ; DE9:  d1 d3
b00_8deb:   ldx #$f2                    ; DEB:  a2 f2
b00_8ded:   .db $ff                     ; DED:  ff
b00_8dee:   eor ($2a,x)                 ; DEE:  41 2a
b00_8df0:   dec $33,x                   ; DF0:  d6 33
b00_8df2:   stx $2940                   ; DF2:  8e 40 29
b00_8df5:   rti                         ; DF5:  40
b00_8df6:   dec $17,x                   ; DF6:  d6 17
b00_8df8:   stx $d30c                   ; DF8:  8e 0c d3
b00_8dfb:   .db $b3                     ; DFB:  b3
b00_8dfc:   sbc #$72                    ; DFC:  e9 72
b00_8dfe:   .db $d7                     ; DFE:  d7
b00_8dff:   .db $02                     ; DFF:  02
b00_8e00:   .db $b3                     ; E00:  b3
b00_8e01:   dec $fff2,x                 ; E01:  de f2 ff
b00_8e04:   .db $b3                     ; E04:  b3
b00_8e05:   .db $0b                     ; E05:  0b
b00_8e06:   ldy $bb,x                   ; E06:  b4 bb
b00_8e08:   .db $d3                     ; E08:  d3
b00_8e09:   .db $b3                     ; E09:  b3
b00_8e0a:   sbc #$72                    ; E0A:  e9 72
b00_8e0c:   .db $d7                     ; E0C:  d7
b00_8e0d:   .db $02                     ; E0D:  02
b00_8e0e:   ldy $c0,x                   ; E0E:  b4 c0
b00_8e10:   cld                         ; E10:  d8
b00_8e11:   ora $8e,x                   ; E11:  15 8e
b00_8e13:   eor ($29,x)                 ; E13:  41 29
b00_8e15:   .db $0b                     ; E15:  0b
b00_8e16:   bne $8e43                   ; E16:  d0 2b
b00_8e18:   .db $0b                     ; E18:  0b
b00_8e19:   .db $1a                     ; E19:  1a
b00_8e1a:   dec $d7                     ; E1A:  c6 d7
b00_8e1c:   sbc $098d,y                 ; E1C:  f9 8d 09
b00_8e1f:   .db $d7                     ; E1F:  d7
b00_8e20:   bmi $8db0                   ; E20:  30 8e
b00_8e22:   dec $fff2,x                 ; E22:  de f2 ff
b00_8e25:   .db $b3                     ; E25:  b3
b00_8e26:   asl a                       ; E26:  0a
b00_8e27:   bne $8e53                   ; E27:  d0 2a
b00_8e29:   cmp ($b4),y                 ; E29:  d1 b4
b00_8e2b:   .db $bb                     ; E2B:  bb
b00_8e2c:   .db $b3                     ; E2C:  b3
b00_8e2d:   .db $0c                     ; E2D:  0c
b00_8e2e:   .db $d3                     ; E2E:  d3
b00_8e2f:   .db $d4                     ; E2F:  d4
b00_8e30:   .db $0c                     ; E30:  0c
b00_8e31:   bne $8e5f                   ; E31:  d0 2c
b00_8e33:   .db $0c                     ; E33:  0c
b00_8e34:   .db $d3                     ; E34:  d3
b00_8e35:   sty $00ff                   ; E35:  8c ff 00
b00_8e38:   cmp ($d7,x)                 ; E38:  c1 d7
b00_8e3a:   .db $f3                     ; E3A:  f3
b00_8e3b:   sta $d640                   ; E3B:  8d 40 d6
b00_8e3e:   eor ($8e),y                 ; E3E:  51 8e
b00_8e40:   .db $0b                     ; E40:  0b
b00_8e41:   sty $6f4f                   ; E41:  8c 4f 6f
b00_8e44:   .db $bb                     ; E44:  bb
b00_8e45:   .db $b3                     ; E45:  b3
b00_8e46:   dec $fff2,x                 ; E46:  de f2 ff
b00_8e49:   .db $b3                     ; E49:  b3
b00_8e4a:   .db $0b                     ; E4A:  0b
b00_8e4b:   ldy $bb,x                   ; E4B:  b4 bb
b00_8e4d:   .db $d3                     ; E4D:  d3
b00_8e4e:   .db $d4                     ; E4E:  d4
b00_8e4f:   .db $0b                     ; E4F:  0b
b00_8e50:   bne $8e7d                   ; E50:  d0 2b
b00_8e52:   .db $0b                     ; E52:  0b
b00_8e53:   .db $1a                     ; E53:  1a
b00_8e54:   dec $d7                     ; E54:  c6 d7
b00_8e56:   rti                         ; E56:  40
b00_8e57:   stx $8c0b                   ; E57:  8e 0b 8c
b00_8e5a:   .db $4f                     ; E5A:  4f
b00_8e5b:   .db $6f                     ; E5B:  6f
b00_8e5c:   .db $bb                     ; E5C:  bb
b00_8e5d:   .db $b3                     ; E5D:  b3
b00_8e5e:   .db $89                     ; E5E:  89
b00_8e5f:   .db $ff                     ; E5F:  ff
b00_8e60:   .db $d4                     ; E60:  d4
b00_8e61:   asl a                       ; E61:  0a
b00_8e62:   .db $cf                     ; E62:  cf
b00_8e63:   jsr $e823                   ; E63:  20 23 e8
b00_8e66:   inc $40ff,x                 ; E66:  fe ff 40
b00_8e69:   dec $8f,x                   ; E69:  d6 8f
b00_8e6b:   stx $e93b                   ; E6B:  8e 3b e9
b00_8e6e:   sta $02d9,y                 ; E6E:  99 d9 02
b00_8e71:   cld                         ; E71:  d8
b00_8e72:   sta $0b8e                   ; E72:  8d 8e 0b
b00_8e75:   tay                         ; E75:  a8
b00_8e76:   .db $5f                     ; E76:  5f
b00_8e77:   .db $6f                     ; E77:  6f
b00_8e78:   ldy $5f                     ; E78:  a4 5f
b00_8e7a:   .db $6f                     ; E7A:  6f
b00_8e7b:   tay                         ; E7B:  a8
b00_8e7c:   .db $63                     ; E7C:  63
b00_8e7d:   .db $6f                     ; E7D:  6f
b00_8e7e:   ldy $dad7                   ; E7E:  ac d7 da
b00_8e81:   stx $6f4f                   ; E81:  8e 4f 6f
b00_8e84:   sbc #$e1                    ; E84:  e9 e1
b00_8e86:   sta $b302                   ; E86:  8d 02 b3
b00_8e89:   sbc #$75                    ; E89:  e9 75
b00_8e8b:   sty $0b02                   ; E8B:  8c 02 0b
b00_8e8e:   bne $8ebb                   ; E8E:  d0 2b
b00_8e90:   .db $0b                     ; E90:  0b
b00_8e91:   ldx $9d                     ; E91:  a6 9d
b00_8e93:   adc $d7c6                   ; E93:  6d c6 d7
b00_8e96:   jmp ($cf8e)                 ; E96:  6c 8e cf
b00_8e99:   jsr $e823                   ; E99:  20 23 e8
b00_8e9c:   brk                         ; E9C:  00
b00_8e9d:   brk                         ; E9D:  00
b00_8e9e:   ora $8cd2                   ; E9E:  0d d2 8c
b00_8ea1:   .db $67                     ; EA1:  67
b00_8ea2:   .db $6f                     ; EA2:  6f
b00_8ea3:   .db $bb                     ; EA3:  bb
b00_8ea4:   .db $b3                     ; EA4:  b3
b00_8ea5:   .db $0c                     ; EA5:  0c
b00_8ea6:   .db $d4                     ; EA6:  d4
b00_8ea7:   ora $8cd2                   ; EA7:  0d d2 8c
b00_8eaa:   pla                         ; EAA:  68
b00_8eab:   .db $6f                     ; EAB:  6f
b00_8eac:   .db $bb                     ; EAC:  bb
b00_8ead:   .db $b3                     ; EAD:  b3
b00_8eae:   asl $0dd4                   ; EAE:  0e d4 0d
b00_8eb1:   bne $8e85                   ; EB1:  d0 d2
b00_8eb3:   sty $6f67                   ; EB3:  8c 67 6f
b00_8eb6:   .db $bb                     ; EB6:  bb
b00_8eb7:   .db $b3                     ; EB7:  b3
b00_8eb8:   .db $89                     ; EB8:  89
b00_8eb9:   .db $ff                     ; EB9:  ff
b00_8eba:   .db $d4                     ; EBA:  d4
b00_8ebb:   .db $cf                     ; EBB:  cf
b00_8ebc:   jsr $e823                   ; EBC:  20 23 e8
b00_8ebf:   brk                         ; EBF:  00
b00_8ec0:   brk                         ; EC0:  00
b00_8ec1:   .db $0c                     ; EC1:  0c
b00_8ec2:   ora $d8c0,x                 ; EC2:  1d c0 d8
b00_8ec5:   .db $cf                     ; EC5:  cf
b00_8ec6:   stx $e962                   ; EC6:  8e 62 e9
b00_8ec9:   .db $52                     ; EC9:  52
b00_8eca:   dex                         ; ECA:  ca
b00_8ecb:   .db $02                     ; ECB:  02
b00_8ecc:   bvc $8e8e                   ; ECC:  50 c0
b00_8ece:   .db $cf                     ; ECE:  cf
b00_8ecf:   ora $c21c                   ; ECF:  0d 1c c2
b00_8ed2:   .db $cf                     ; ED2:  cf
b00_8ed3:   jsr $e823                   ; ED3:  20 23 e8
b00_8ed6:   .db $fa                     ; ED6:  fa
b00_8ed7:   .db $ff                     ; ED7:  ff
b00_8ed8:   rol $78e9,x                 ; ED8:  3e e9 78
b00_8edb:   dec $2b02,x                 ; EDB:  de 02 2b
b00_8ede:   rol $9de9,x                 ; EDE:  3e e9 9d
b00_8ee1:   .db $8b                     ; EE1:  8b
b00_8ee2:   .db $02                     ; EE2:  02
b00_8ee3:   rol a                       ; EE3:  2a
b00_8ee4:   stx $bac0                   ; EE4:  8e c0 ba
b00_8ee7:   sbc #$26                    ; EE7:  e9 26
b00_8ee9:   .db $d3                     ; EE9:  d3
b00_8eea:   .db $02                     ; EEA:  02
b00_8eeb:   .db $3b                     ; EEB:  3b
b00_8eec:   asl $b3d0                   ; EEC:  0e d0 b3
b00_8eef:   stx $bac9                   ; EEF:  8e c9 ba
b00_8ef2:   sbc #$34                    ; EF2:  e9 34
b00_8ef4:   cmp ($06),y                 ; EF4:  d1 06
b00_8ef6:   .db $3c                     ; EF6:  3c
b00_8ef7:   .db $3a                     ; EF7:  3a
b00_8ef8:   and $cf8e,x                 ; EF8:  3d 8e cf
b00_8efb:   tsx                         ; EFB:  ba
b00_8efc:   sbc #$34                    ; EFC:  e9 34
b00_8efe:   cmp ($08),y                 ; EFE:  d1 08
b00_8f00:   ldy $d766                   ; F00:  ac 66 d7
b00_8f03:   and $e93c,x                 ; F03:  3d 3c e9
b00_8f06:   ldy $048e,x                 ; F06:  bc 8e 04
b00_8f09:   .db $cf                     ; F09:  cf
b00_8f0a:   jsr $e823                   ; F0A:  20 23 e8
b00_8f0d:   .db $f2                     ; F0D:  f2
b00_8f0e:   .db $ff                     ; F0E:  ff
b00_8f0f:   .db $3c                     ; F0F:  3c
b00_8f10:   sbc #$78                    ; F10:  e9 78
b00_8f12:   dec $2a02,x                 ; F12:  de 02 2a
b00_8f15:   sta $e91e                   ; F15:  8d 1e e9
b00_8f18:   .db $03                     ; F18:  03
b00_8f19:   dex                         ; F19:  ca
b00_8f1a:   .db $02                     ; F1A:  02
b00_8f1b:   .db $0c                     ; F1B:  0c
b00_8f1c:   .db $8b                     ; F1C:  8b
b00_8f1d:   .db $1a                     ; F1D:  1a
b00_8f1e:   lda $8c,x                   ; F1E:  b5 8c
b00_8f20:   ora ($70,x)                 ; F20:  01 70
b00_8f22:   .db $bb                     ; F22:  bb
b00_8f23:   .db $2b                     ; F23:  2b
b00_8f24:   sta $e914                   ; F24:  8d 14 e9
b00_8f27:   .db $52                     ; F27:  52
b00_8f28:   dex                         ; F28:  ca
b00_8f29:   .db $02                     ; F29:  02
b00_8f2a:   .db $b3                     ; F2A:  b3
b00_8f2b:   .db $0b                     ; F2B:  0b
b00_8f2c:   ror $b3b0,x                 ; F2C:  7e b0 b3
b00_8f2f:   sbc #$cd                    ; F2F:  e9 cd
b00_8f31:   .db $cb                     ; F31:  cb
b00_8f32:   .db $02                     ; F32:  02
b00_8f33:   .db $b3                     ; F33:  b3
b00_8f34:   .db $0b                     ; F34:  0b
b00_8f35:   sei                         ; F35:  78
b00_8f36:   bcs $8eeb                   ; F36:  b0 b3
b00_8f38:   sbc #$cd                    ; F38:  e9 cd
b00_8f3a:   .db $cb                     ; F3A:  cb
b00_8f3b:   .db $02                     ; F3B:  02
b00_8f3c:   ldy $bb,x                   ; F3C:  b4 bb
b00_8f3e:   ldy $bb,x                   ; F3E:  b4 bb
b00_8f40:   .db $7a                     ; F40:  7a
b00_8f41:   and #$0b                    ; F41:  29 0b
b00_8f43:   .db $8f                     ; F43:  8f
b00_8f44:   bpl $8ef6                   ; F44:  10 b0
b00_8f46:   plp                         ; F46:  28
b00_8f47:   .db $3c                     ; F47:  3c
b00_8f48:   sec                         ; F48:  38
b00_8f49:   and $d3e9,y                 ; F49:  39 e9 d3
b00_8f4c:   stx $d806                   ; F4C:  8e 06 d8
b00_8f4f:   stx $8f,y                   ; F4F:  96 8f
b00_8f51:   stx $bafd                   ; F51:  8e fd ba
b00_8f54:   sbc #$26                    ; F54:  e9 26
b00_8f56:   .db $d3                     ; F56:  d3
b00_8f57:   .db $02                     ; F57:  02
b00_8f58:   .db $3a                     ; F58:  3a
b00_8f59:   stx $bafe                   ; F59:  8e fe ba
b00_8f5c:   sbc #$34                    ; F5C:  e9 34
b00_8f5e:   cmp ($04),y                 ; F5E:  d1 04
b00_8f60:   ldy $d766                   ; F60:  ac 66 d7
b00_8f63:   .db $0c                     ; F63:  0c
b00_8f64:   sty $6da2                   ; F64:  8c a2 6d
b00_8f67:   .db $bb                     ; F67:  bb
b00_8f68:   .db $d3                     ; F68:  d3
b00_8f69:   cld                         ; F69:  d8
b00_8f6a:   stx $3c8f                   ; F6A:  8e 8f 3c
b00_8f6d:   sbc #$72                    ; F6D:  e9 72
b00_8f6f:   .db $d7                     ; F6F:  d7
b00_8f70:   .db $02                     ; F70:  02
b00_8f71:   and $3c                     ; F71:  25 3c
b00_8f73:   sbc #$75                    ; F73:  e9 75
b00_8f75:   .db $e2                     ; F75:  e2
b00_8f76:   .db $02                     ; F76:  02
b00_8f77:   and $e9,x                   ; F77:  35 e9
b00_8f79:   asl $02dc                   ; F79:  0e dc 02
b00_8f7c:   and $e9,x                   ; F7C:  35 e9
b00_8f7e:   .db $3c                     ; F7E:  3c
b00_8f7f:   .db $dc                     ; F7F:  dc
b00_8f80:   .db $02                     ; F80:  02
b00_8f81:   .db $3c                     ; F81:  3c
b00_8f82:   sbc #$25                    ; F82:  e9 25
b00_8f84:   cpx $02                     ; F84:  e4 02
b00_8f86:   .db $3c                     ; F86:  3c
b00_8f87:   sbc #$1b                    ; F87:  e9 1b
b00_8f89:   .db $e2                     ; F89:  e2
b00_8f8a:   .db $02                     ; F8A:  02
b00_8f8b:   dec $d2,x                   ; F8B:  d6 d2
b00_8f8d:   .db $8f                     ; F8D:  8f
b00_8f8e:   .db $3c                     ; F8E:  3c
b00_8f8f:   sbc #$54                    ; F8F:  e9 54
b00_8f91:   cpx $02                     ; F91:  e4 02
b00_8f93:   dec $d2,x                   ; F93:  d6 d2
b00_8f95:   .db $8f                     ; F95:  8f
b00_8f96:   stx $bb0b                   ; F96:  8e 0b bb
b00_8f99:   sbc #$26                    ; F99:  e9 26
b00_8f9b:   .db $d3                     ; F9B:  d3
b00_8f9c:   .db $02                     ; F9C:  02
b00_8f9d:   sta $e932                   ; F9D:  8d 32 e9
b00_8fa0:   .db $52                     ; FA0:  52
b00_8fa1:   dex                         ; FA1:  ca
b00_8fa2:   .db $02                     ; FA2:  02
b00_8fa3:   .db $7a                     ; FA3:  7a
b00_8fa4:   .db $b3                     ; FA4:  b3
b00_8fa5:   .db $0b                     ; FA5:  0b
b00_8fa6:   .db $8f                     ; FA6:  8f
b00_8fa7:   bpl $8f59                   ; FA7:  10 b0
b00_8fa9:   .db $b3                     ; FA9:  b3
b00_8faa:   sbc #$0d                    ; FAA:  e9 0d
b00_8fac:   .db $d7                     ; FAC:  d7
b00_8fad:   .db $04                     ; FAD:  04
b00_8fae:   .db $b3                     ; FAE:  b3
b00_8faf:   .db $0b                     ; FAF:  0b
b00_8fb0:   .db $8f                     ; FB0:  8f
b00_8fb1:   bpl $8f67                   ; FB1:  10 b4
b00_8fb3:   .db $b3                     ; FB3:  b3
b00_8fb4:   bcs $8f72                   ; FB4:  b0 bc
b00_8fb6:   lda ($8d),y                 ; FB6:  b1 8d
b00_8fb8:   .db $32                     ; FB8:  32
b00_8fb9:   sbc #$52                    ; FB9:  e9 52
b00_8fbb:   dex                         ; FBB:  ca
b00_8fbc:   .db $02                     ; FBC:  02
b00_8fbd:   .db $7a                     ; FBD:  7a
b00_8fbe:   .db $b3                     ; FBE:  b3
b00_8fbf:   .db $0b                     ; FBF:  0b
b00_8fc0:   sei                         ; FC0:  78
b00_8fc1:   bcs $8f76                   ; FC1:  b0 b3
b00_8fc3:   sbc #$0d                    ; FC3:  e9 0d
b00_8fc5:   .db $d7                     ; FC5:  d7
b00_8fc6:   .db $04                     ; FC6:  04
b00_8fc7:   .db $b3                     ; FC7:  b3
b00_8fc8:   .db $0b                     ; FC8:  0b
b00_8fc9:   sei                         ; FC9:  78
b00_8fca:   ldy $b3,x                   ; FCA:  b4 b3
b00_8fcc:   bcs $8f8a                   ; FCC:  b0 bc
b00_8fce:   lda ($ac),y                 ; FCE:  b1 ac
b00_8fd0:   ror $d7                     ; FD0:  66 d7
b00_8fd2:   .db $cf                     ; FD2:  cf
b00_8fd3:   jsr $e823                   ; FD3:  20 23 e8
b00_8fd6:   brk                         ; FD6:  00
b00_8fd7:   brk                         ; FD7:  00
b00_8fd8:   rts                         ; FD8:  60
b00_8fd9:   and $e93c,x                 ; FD9:  3d 3c e9
b00_8fdc:   sta $068e,y                 ; FDC:  99 8e 06
b00_8fdf:   .db $cf                     ; FDF:  cf
b00_8fe0:   jsr $e823                   ; FE0:  20 23 e8
b00_8fe3:   brk                         ; FE3:  00
b00_8fe4:   brk                         ; FE4:  00
b00_8fe5:   ora $198b                   ; FE5:  0d 8b 19
b00_8fe8:   cpy $d8                     ; FE8:  c4 d8
b00_8fea:   inc $8f,x                   ; FEA:  f6 8f
b00_8fec:   ora $bc1c                   ; FEC:  0d 1c bc
b00_8fef:   eor $c4,x                   ; FEF:  55 c4
b00_8ff1:   cld                         ; FF1:  d8
b00_8ff2:   inc $8f,x                   ; FF2:  f6 8f
b00_8ff4:   eor ($cf,x)                 ; FF4:  41 cf
b00_8ff6:   rti                         ; FF6:  40
b00_8ff7:   .db $cf                     ; FF7:  cf
b00_8ff8:   jsr $e823                   ; FF8:  20 23 e8
b00_8ffb:   .db $f2                     ; FFB:  f2
b00_8ffc:   .db $ff                     ; FFC:  ff
b00_8ffd:   txa                         ; FFD:  8a
b00_8ffe:   lda $2b7b                   ; FFE:  ad 7b 2b
b00_9001:   rti                         ; 1001:  40
b00_9002:   and #$d6                    ; 1002:  29 d6
b00_9004:   ldx $90,y                   ; 1004:  b6 90
b00_9006:   ldy $8c1e                   ; 1006:  ac 1e 8c
b00_9009:   cld                         ; 1009:  d8
b00_900a:   .db $97                     ; 100A:  97
b00_900b:   bcc $8fb1                   ; 100B:  90 a4
b00_900d:   .db $5f                     ; 100D:  5f
b00_900e:   .db $6f                     ; 100E:  6f
b00_900f:   .db $8b                     ; 100F:  8b
b00_9010:   .db $1a                     ; 1010:  1a
b00_9011:   lda $8c,x                   ; 1011:  b5 8c
b00_9013:   ora ($70,x)                 ; 1013:  01 70
b00_9015:   .db $bb                     ; 1015:  bb
b00_9016:   and $28                     ; 1016:  25 28
b00_9018:   ora $7c                     ; 1018:  05 7c
b00_901a:   .db $27                     ; 101A:  27
b00_901b:   .db $07                     ; 101B:  07
b00_901c:   bcs $9044                   ; 101C:  b0 26
b00_901e:   php                         ; 101E:  08
b00_901f:   bcs $8ff9                   ; 101F:  b0 d8
b00_9021:   txa                         ; 1021:  8a
b00_9022:   bcc $8fd0                   ; 1022:  90 ac
b00_9024:   ror $8cd7,x                 ; 1024:  7e d7 8c
b00_9027:   .db $67                     ; 1027:  67
b00_9028:   adc $d3bb                   ; 1028:  6d bb d3
b00_902b:   .db $d7                     ; 102B:  d7
b00_902c:   txa                         ; 102C:  8a
b00_902d:   bcc $8fbd                   ; 102D:  90 8e
b00_902f:   rol $bb                     ; 102F:  26 bb
b00_9031:   sbc #$26                    ; 1031:  e9 26
b00_9033:   .db $d3                     ; 1033:  d3
b00_9034:   .db $02                     ; 1034:  02
b00_9035:   tax                         ; 1035:  aa
b00_9036:   .db $5f                     ; 1036:  5f
b00_9037:   .db $6f                     ; 1037:  6f
b00_9038:   sbc #$8b                    ; 1038:  e9 8b
b00_903a:   .db $d7                     ; 103A:  d7
b00_903b:   .db $02                     ; 103B:  02
b00_903c:   stx $bb27                   ; 103C:  8e 27 bb
b00_903f:   sbc #$c4                    ; 103F:  e9 c4
b00_9041:   dec $ac02                   ; 1041:  ce 02 ac
b00_9044:   .db $a7                     ; 1044:  a7
b00_9045:   .db $d3                     ; 1045:  d3
b00_9046:   cld                         ; 1046:  d8
b00_9047:   txa                         ; 1047:  8a
b00_9048:   bcc $904f                   ; 1048:  90 05
b00_904a:   bcs $8fff                   ; 104A:  b0 b3
b00_904c:   and $e9,x                   ; 104C:  35 e9
b00_904e:   rti                         ; 104E:  40
b00_904f:   cmp $3504,y                 ; 104F:  d9 04 35
b00_9052:   rti                         ; 1052:  40
b00_9053:   lda ($8e),y                 ; 1053:  b1 8e
b00_9055:   .db $62                     ; 1055:  62
b00_9056:   .db $bb                     ; 1056:  bb
b00_9057:   sbc #$26                    ; 1057:  e9 26
b00_9059:   .db $d3                     ; 1059:  d3
b00_905a:   .db $02                     ; 105A:  02
b00_905b:   .db $07                     ; 105B:  07
b00_905c:   bcs $9011                   ; 105C:  b0 b3
b00_905e:   rol $e9,x                   ; 105E:  36 e9
b00_9060:   cpx #$8f                    ; 1060:  e0 8f
b00_9062:   .db $04                     ; 1062:  04
b00_9063:   .db $d7                     ; 1063:  d7
b00_9064:   adc $8e90,x                 ; 1064:  7d 90 8e
b00_9067:   .db $74                     ; 1067:  74
b00_9068:   .db $bb                     ; 1068:  bb
b00_9069:   sbc #$c4                    ; 1069:  e9 c4
b00_906b:   dec $ac02                   ; 106B:  ce 02 ac
b00_906e:   eor $09d7,y                 ; 106E:  59 d7 09
b00_9071:   bne $909c                   ; 1071:  d0 29
b00_9073:   cmp ($b3),y                 ; 1073:  d1 b3
b00_9075:   tax                         ; 1075:  aa
b00_9076:   .db $5f                     ; 1076:  5f
b00_9077:   .db $6f                     ; 1077:  6f
b00_9078:   sbc #$d3                    ; 1078:  e9 d3
b00_907a:   .db $8f                     ; 107A:  8f
b00_907b:   .db $04                     ; 107B:  04
b00_907c:   .db $cf                     ; 107C:  cf
b00_907d:   stx $bb84                   ; 107D:  8e 84 bb
b00_9080:   sbc #$c4                    ; 1080:  e9 c4
b00_9082:   dec $ac02                   ; 1082:  ce 02 ac
b00_9085:   ror $d7                     ; 1085:  66 d7
b00_9087:   dec $b6,x                   ; 1087:  d6 b6
b00_9089:   bcc $9094                   ; 1089:  90 09
b00_908b:   bne $90b6                   ; 108B:  d0 29
b00_908d:   cmp ($b3),y                 ; 108D:  d1 b3
b00_908f:   tax                         ; 108F:  aa
b00_9090:   .db $5f                     ; 1090:  5f
b00_9091:   .db $6f                     ; 1091:  6f
b00_9092:   sbc #$d3                    ; 1092:  e9 d3
b00_9094:   .db $8f                     ; 1094:  8f
b00_9095:   .db $04                     ; 1095:  04
b00_9096:   .db $cf                     ; 1096:  cf
b00_9097:   tax                         ; 1097:  aa
b00_9098:   .db $5f                     ; 1098:  5f
b00_9099:   .db $6f                     ; 1099:  6f
b00_909a:   sbc #$0a                    ; 109A:  e9 0a
b00_909c:   .db $8f                     ; 109C:  8f
b00_909d:   .db $02                     ; 109D:  02
b00_909e:   sta $e91e                   ; 109E:  8d 1e e9
b00_90a1:   .db $52                     ; 10A1:  52
b00_90a2:   dex                         ; 10A2:  ca
b00_90a3:   .db $02                     ; 10A3:  02
b00_90a4:   .db $8f                     ; 10A4:  8f
b00_90a5:   .db $32                     ; 10A5:  32
b00_90a6:   .db $b3                     ; 10A6:  b3
b00_90a7:   ldy $5f                     ; 10A7:  a4 5f
b00_90a9:   .db $6f                     ; 10A9:  6f
b00_90aa:   .db $8b                     ; 10AA:  8b
b00_90ab:   .db $1a                     ; 10AB:  1a
b00_90ac:   lda $8c,x                   ; 10AC:  b5 8c
b00_90ae:   ora $bb70                   ; 10AE:  0d 70 bb
b00_90b1:   ldy $b3,x                   ; 10B1:  b4 b3
b00_90b3:   bcs $9070                   ; 10B3:  b0 bb
b00_90b5:   lda ($0b),y                 ; 10B5:  b1 0b
b00_90b7:   bne $90e4                   ; 10B7:  d0 2b
b00_90b9:   cmp ($d3),y                 ; 10B9:  d1 d3
b00_90bb:   tay                         ; 10BB:  a8
b00_90bc:   .db $5f                     ; 10BC:  5f
b00_90bd:   .db $6f                     ; 10BD:  6f
b00_90be:   sty $00ff                   ; 10BE:  8c ff 00
b00_90c1:   cmp ($d7,x)                 ; 10C1:  c1 d7
b00_90c3:   asl $90                     ; 10C3:  06 90
b00_90c5:   .db $cf                     ; 10C5:  cf
b00_90c6:   jsr $e823                   ; 10C6:  20 23 e8
b00_90c9:   brk                         ; 10C9:  00
b00_90ca:   brk                         ; 10CA:  00
b00_90cb:   .db $0c                     ; 10CB:  0c
b00_90cc:   .db $d3                     ; 10CC:  d3
b00_90cd:   .db $8b                     ; 10CD:  8b
b00_90ce:   .db $64                     ; 10CE:  64
b00_90cf:   cmp $d8                     ; 10CF:  c5 d8
b00_90d1:   dec $90,x                   ; 10D1:  d6 90
b00_90d3:   .db $3c                     ; 10D3:  3c
b00_90d4:   rti                         ; 10D4:  40
b00_90d5:   .db $d4                     ; 10D5:  d4
b00_90d6:   .db $cf                     ; 10D6:  cf
b00_90d7:   jsr $e823                   ; 10D7:  20 23 e8
b00_90da:   brk                         ; 10DA:  00
b00_90db:   brk                         ; 10DB:  00
b00_90dc:   and $e93c,x                 ; 10DC:  3d 3c e9
b00_90df:   .db $12                     ; 10DF:  12
b00_90e0:   dex                         ; 10E0:  ca
b00_90e1:   .db $04                     ; 10E1:  04
b00_90e2:   .db $3c                     ; 10E2:  3c
b00_90e3:   sbc #$c6                    ; 10E3:  e9 c6
b00_90e5:   bcc $90e9                   ; 10E5:  90 02
b00_90e7:   .db $cf                     ; 10E7:  cf
b00_90e8:   jsr $e823                   ; 10E8:  20 23 e8
b00_90eb:   .db $fc                     ; 10EB:  fc
b00_90ec:   .db $ff                     ; 10EC:  ff
b00_90ed:   rti                         ; 10ED:  40
b00_90ee:   dec $14,x                   ; 10EE:  d6 14
b00_90f0:   sta ($40),y                 ; 10F0:  91 40
b00_90f2:   dec $09,x                   ; 10F2:  d6 09
b00_90f4:   sta ($0b),y                 ; 10F4:  91 0b
b00_90f6:   .db $1a                     ; 10F6:  1a
b00_90f7:   dec $d8                     ; 10F7:  c6 d8
b00_90f9:   .db $07                     ; 10F9:  07
b00_90fa:   sta ($3c),y                 ; 10FA:  91 3c
b00_90fc:   .db $3a                     ; 10FC:  3a
b00_90fd:   .db $3b                     ; 10FD:  3b
b00_90fe:   sbc #$35                    ; 10FE:  e9 35
b00_9100:   sty $b304                   ; 1100:  8c 04 b3
b00_9103:   sbc #$d7                    ; 1103:  e9 d7
b00_9105:   bcc $910b                   ; 1105:  90 04
b00_9107:   asl a                       ; 1107:  0a
b00_9108:   bne $9134                   ; 1108:  d0 2a
b00_910a:   asl a                       ; 110A:  0a
b00_910b:   ldx $9d                     ; 110B:  a6 9d
b00_910d:   adc $d7c6                   ; 110D:  6d c6 d7
b00_9110:   sbc $90,x                   ; 1110:  f5 90
b00_9112:   .db $0b                     ; 1112:  0b
b00_9113:   bne $9140                   ; 1113:  d0 2b
b00_9115:   .db $0b                     ; 1115:  0b
b00_9116:   ldx $9d                     ; 1116:  a6 9d
b00_9118:   adc $d7c6                   ; 1118:  6d c6 d7
b00_911b:   sbc ($90),y                 ; 111B:  f1 90
b00_911d:   .db $cf                     ; 111D:  cf
b00_911e:   jsr $e823                   ; 111E:  20 23 e8
b00_9121:   .db $fc                     ; 1121:  fc
b00_9122:   .db $ff                     ; 1122:  ff
b00_9123:   rti                         ; 1123:  40
b00_9124:   dec $4a,x                   ; 1124:  d6 4a
b00_9126:   sta ($40),y                 ; 1126:  91 40
b00_9128:   dec $3f,x                   ; 1128:  d6 3f
b00_912a:   sta ($0b),y                 ; 112A:  91 0b
b00_912c:   .db $1a                     ; 112C:  1a
b00_912d:   dec $d8                     ; 112D:  c6 d8
b00_912f:   and $3c91,x                 ; 112F:  3d 91 3c
b00_9132:   .db $3b                     ; 1132:  3b
b00_9133:   .db $3a                     ; 1133:  3a
b00_9134:   sbc #$35                    ; 1134:  e9 35
b00_9136:   sty $b304                   ; 1136:  8c 04 b3
b00_9139:   sbc #$d7                    ; 1139:  e9 d7
b00_913b:   bcc $9141                   ; 113B:  90 04
b00_913d:   asl a                       ; 113D:  0a
b00_913e:   bne $916a                   ; 113E:  d0 2a
b00_9140:   asl a                       ; 1140:  0a
b00_9141:   ldx $9d                     ; 1141:  a6 9d
b00_9143:   adc $d7c6                   ; 1143:  6d c6 d7
b00_9146:   .db $2b                     ; 1146:  2b
b00_9147:   sta ($0b),y                 ; 1147:  91 0b
b00_9149:   bne $9176                   ; 1149:  d0 2b
b00_914b:   .db $0b                     ; 114B:  0b
b00_914c:   ldx $9d                     ; 114C:  a6 9d
b00_914e:   adc $d7c6                   ; 114E:  6d c6 d7
b00_9151:   .db $27                     ; 1151:  27
b00_9152:   sta ($cf),y                 ; 1152:  91 cf
b00_9154:   jsr $e823                   ; 1154:  20 23 e8
b00_9157:   inc $3cff,x                 ; 1157:  fe ff 3c
b00_915a:   sbc #$cd                    ; 115A:  e9 cd
b00_915c:   .db $d7                     ; 115C:  d7
b00_915d:   .db $02                     ; 115D:  02
b00_915e:   .db $2b                     ; 115E:  2b
b00_915f:   .db $0b                     ; 115F:  0b
b00_9160:   bne $9135                   ; 1160:  d0 d3
b00_9162:   .db $d7                     ; 1162:  d7
b00_9163:   .db $67                     ; 1163:  67
b00_9164:   sta ($42),y                 ; 1164:  91 42
b00_9166:   .db $cf                     ; 1166:  cf
b00_9167:   .db $0b                     ; 1167:  0b
b00_9168:   .db $d3                     ; 1168:  d3
b00_9169:   .db $8b                     ; 1169:  8b
b00_916a:   lsr $c2                     ; 116A:  46 c2
b00_916c:   cld                         ; 116C:  d8
b00_916d:   adc ($91),y                 ; 116D:  71 91
b00_916f:   rti                         ; 116F:  40
b00_9170:   .db $cf                     ; 1170:  cf
b00_9171:   .db $0b                     ; 1171:  0b
b00_9172:   bne $9147                   ; 1172:  d0 d3
b00_9174:   .db $54                     ; 1174:  54
b00_9175:   ldx $b3,y                   ; 1175:  b6 b3
b00_9177:   .db $0b                     ; 1177:  0b
b00_9178:   .db $d3                     ; 1178:  d3
b00_9179:   .db $8f                     ; 1179:  8f
b00_917a:   inc $b4,x                   ; 117A:  f6 b4
b00_917c:   ldy $8eb3,x                 ; 117C:  bc b3 8e
b00_917f:   bit $e901                   ; 117F:  2c 01 e9
b00_9182:   .db $52                     ; 1182:  52
b00_9183:   dex                         ; 1183:  ca
b00_9184:   .db $02                     ; 1184:  02
b00_9185:   ldy $c2,x                   ; 1185:  b4 c2
b00_9187:   cld                         ; 1187:  d8
b00_9188:   .db $92                     ; 1188:  92
b00_9189:   sta ($0c),y                 ; 1189:  91 0c
b00_918b:   sty $6dd4                   ; 118B:  8c d4 6d
b00_918e:   .db $bb                     ; 118E:  bb
b00_918f:   .db $d3                     ; 118F:  d3
b00_9190:   bne $9161                   ; 1190:  d0 cf
b00_9192:   rti                         ; 1192:  40
b00_9193:   .db $cf                     ; 1193:  cf
b00_9194:   jsr $e823                   ; 1194:  20 23 e8
b00_9197:   .db $fc                     ; 1197:  fc
b00_9198:   .db $ff                     ; 1198:  ff
b00_9199:   .db $0c                     ; 1199:  0c
b00_919a:   sty $6da2                   ; 119A:  8c a2 6d
b00_919d:   .db $bb                     ; 119D:  bb
b00_919e:   .db $d3                     ; 119E:  d3
b00_919f:   cld                         ; 119F:  d8
b00_91a0:   .db $fc                     ; 11A0:  fc
b00_91a1:   sta ($3c),y                 ; 11A1:  91 3c
b00_91a3:   sbc #$72                    ; 11A3:  e9 72
b00_91a5:   .db $d7                     ; 11A5:  d7
b00_91a6:   .db $02                     ; 11A6:  02
b00_91a7:   .db $2b                     ; 11A7:  2b
b00_91a8:   .db $3b                     ; 11A8:  3b
b00_91a9:   sbc #$54                    ; 11A9:  e9 54
b00_91ab:   sta ($02),y                 ; 11AB:  91 02
b00_91ad:   rol a                       ; 11AD:  2a
b00_91ae:   cld                         ; 11AE:  d8
b00_91af:   .db $fc                     ; 11AF:  fc
b00_91b0:   sta ($0a),y                 ; 11B0:  91 0a
b00_91b2:   eor ($c0),y                 ; 11B2:  51 c0
b00_91b4:   cld                         ; 11B4:  d8
b00_91b5:   ldx $a491,y                 ; 11B5:  be 91 a4
b00_91b8:   .db $5f                     ; 11B8:  5f
b00_91b9:   adc $bed8                   ; 11B9:  6d d8 be
b00_91bc:   sta ($cf),y                 ; 11BC:  91 cf
b00_91be:   .db $3b                     ; 11BE:  3b
b00_91bf:   sbc #$0e                    ; 11BF:  e9 0e
b00_91c1:   .db $dc                     ; 11C1:  dc
b00_91c2:   .db $02                     ; 11C2:  02
b00_91c3:   .db $3b                     ; 11C3:  3b
b00_91c4:   sbc #$3c                    ; 11C4:  e9 3c
b00_91c6:   .db $dc                     ; 11C6:  dc
b00_91c7:   .db $02                     ; 11C7:  02
b00_91c8:   .db $3c                     ; 11C8:  3c
b00_91c9:   sbc #$8d                    ; 11C9:  e9 8d
b00_91cb:   cmp $d802,y                 ; 11CB:  d9 02 d8
b00_91ce:   .db $d3                     ; 11CE:  d3
b00_91cf:   sta ($ac),y                 ; 11CF:  91 ac
b00_91d1:   and $db,x                   ; 11D1:  35 db
b00_91d3:   .db $0b                     ; 11D3:  0b
b00_91d4:   eor $8cb5,y                 ; 11D4:  59 b5 8c
b00_91d7:   tay                         ; 11D7:  a8
b00_91d8:   .db $77                     ; 11D8:  77
b00_91d9:   .db $bb                     ; 11D9:  bb
b00_91da:   .db $b3                     ; 11DA:  b3
b00_91db:   sbc #$26                    ; 11DB:  e9 26
b00_91dd:   .db $d3                     ; 11DD:  d3
b00_91de:   .db $02                     ; 11DE:  02
b00_91df:   asl a                       ; 11DF:  0a
b00_91e0:   cmp ($d2),y                 ; 11E0:  d1 d2
b00_91e2:   sty $bba5                   ; 11E2:  8c a5 bb
b00_91e5:   .db $bb                     ; 11E5:  bb
b00_91e6:   bcs $919b                   ; 11E6:  b0 b3
b00_91e8:   stx $bbba                   ; 11E8:  8e ba bb
b00_91eb:   sbc #$34                    ; 11EB:  e9 34
b00_91ed:   cmp ($04),y                 ; 11ED:  d1 04
b00_91ef:   .db $3c                     ; 11EF:  3c
b00_91f0:   sbc #$e7                    ; 11F0:  e9 e7
b00_91f2:   sbc ($02,x)                 ; 11F2:  e1 02
b00_91f4:   ldy $d766                   ; 11F4:  ac 66 d7
b00_91f7:   .db $3c                     ; 11F7:  3c
b00_91f8:   sbc #$25                    ; 11F8:  e9 25
b00_91fa:   cpx $02                     ; 11FA:  e4 02
b00_91fc:   .db $cf                     ; 11FC:  cf
b00_91fd:   jsr $e823                   ; 11FD:  20 23 e8
b00_9200:   brk                         ; 1200:  00
b00_9201:   brk                         ; 1201:  00
b00_9202:   .db $0c                     ; 1202:  0c
b00_9203:   ora $d8c4,x                 ; 1203:  1d c4 d8
b00_9206:   asl a                       ; 1206:  0a
b00_9207:   .db $92                     ; 1207:  92
b00_9208:   .db $0c                     ; 1208:  0c
b00_9209:   .db $cf                     ; 1209:  cf
b00_920a:   ora $c41e                   ; 120A:  0d 1e c4
b00_920d:   cld                         ; 120D:  d8
b00_920e:   .db $12                     ; 120E:  12
b00_920f:   .db $92                     ; 120F:  92
b00_9210:   asl $0dcf                   ; 1210:  0e cf 0d
b00_9213:   .db $cf                     ; 1213:  cf
b00_9214:   jsr $e823                   ; 1214:  20 23 e8
b00_9217:   brk                         ; 1217:  00
b00_9218:   brk                         ; 1218:  00
b00_9219:   sta $e933                   ; 1219:  8d 33 e9
b00_921c:   .db $52                     ; 121C:  52
b00_921d:   dex                         ; 121D:  ca
b00_921e:   .db $02                     ; 121E:  02
b00_921f:   .db $b3                     ; 121F:  b3
b00_9220:   ldy $9f                     ; 1220:  a4 9f
b00_9222:   adc $e890                   ; 1222:  6d 90 e8
b00_9225:   sbc $b652,y                 ; 1225:  f9 52 b6
b00_9228:   .db $72                     ; 1228:  72
b00_9229:   .db $5a                     ; 1229:  5a
b00_922a:   lda $b4,x                   ; 122A:  b5 b4
b00_922c:   .db $bb                     ; 122C:  bb
b00_922d:   .db $cf                     ; 122D:  cf
b00_922e:   jsr $e823                   ; 122E:  20 23 e8
b00_9231:   brk                         ; 1231:  00
b00_9232:   brk                         ; 1232:  00
b00_9233:   .db $62                     ; 1233:  62
b00_9234:   sbc #$52                    ; 1234:  e9 52
b00_9236:   dex                         ; 1236:  ca
b00_9237:   .db $02                     ; 1237:  02
b00_9238:   cld                         ; 1238:  d8
b00_9239:   .db $42                     ; 1239:  42
b00_923a:   .db $92                     ; 123A:  92
b00_923b:   ror $e9                     ; 123B:  66 e9
b00_923d:   .db $52                     ; 123D:  52
b00_923e:   dex                         ; 123E:  ca
b00_923f:   .db $02                     ; 123F:  02
b00_9240:   adc $cf,x                   ; 1240:  75 cf
b00_9242:   ror a                       ; 1242:  6a
b00_9243:   sbc #$52                    ; 1243:  e9 52
b00_9245:   dex                         ; 1245:  ca
b00_9246:   .db $02                     ; 1246:  02
b00_9247:   .db $8f                     ; 1247:  8f
b00_9248:   asl $20cf,x                 ; 1248:  1e cf 20
b00_924b:   .db $23                     ; 124B:  23
b00_924c:   inx                         ; 124C:  e8
b00_924d:   .db $fc                     ; 124D:  fc
b00_924e:   .db $ff                     ; 124E:  ff
b00_924f:   ror a                       ; 124F:  6a
b00_9250:   sbc #$52                    ; 1250:  e9 52
b00_9252:   dex                         ; 1252:  ca
b00_9253:   .db $02                     ; 1253:  02
b00_9254:   bne $91fe                   ; 1254:  d0 a8
b00_9256:   .db $0b                     ; 1256:  0b
b00_9257:   ror $e965                   ; 1257:  6e 65 e9
b00_925a:   .db $52                     ; 125A:  52
b00_925b:   dex                         ; 125B:  ca
b00_925c:   .db $02                     ; 125C:  02
b00_925d:   cld                         ; 125D:  d8
b00_925e:   ror $92,x                   ; 125E:  76 92
b00_9260:   sta $6b1e                   ; 1260:  8d 1e 6b
b00_9263:   sbc #$52                    ; 1263:  e9 52
b00_9265:   dex                         ; 1265:  ca
b00_9266:   .db $02                     ; 1266:  02
b00_9267:   ldx $0d                     ; 1267:  a6 0d
b00_9269:   ror $8fbb                   ; 1269:  6e bb 8f
b00_926c:   .db $fb                     ; 126C:  fb
b00_926d:   .db $b3                     ; 126D:  b3
b00_926e:   ror a                       ; 126E:  6a
b00_926f:   sbc #$fd                    ; 126F:  e9 fd
b00_9271:   sta ($06),y                 ; 1271:  91 06
b00_9273:   dec $79,x                   ; 1273:  d6 79
b00_9275:   .db $92                     ; 1275:  92
b00_9276:   ldy $922e                   ; 1276:  ac 2e 92
b00_9279:   tay                         ; 1279:  a8
b00_927a:   ora $ac6e                   ; 127A:  0d 6e ac
b00_927d:   .db $14                     ; 127D:  14
b00_927e:   .db $92                     ; 127E:  92
b00_927f:   .db $52                     ; 127F:  52
b00_9280:   ldx $a8,y                   ; 1280:  b6 a8
b00_9282:   .db $0f                     ; 1282:  0f
b00_9283:   ror $468d                   ; 1283:  6e 8d 46
b00_9286:   ldy $9214                   ; 1286:  ac 14 92
b00_9289:   .db $b3                     ; 1289:  b3
b00_928a:   sbc #$0d                    ; 128A:  e9 0d
b00_928c:   .db $d7                     ; 128C:  d7
b00_928d:   .db $04                     ; 128D:  04
b00_928e:   tay                         ; 128E:  a8
b00_928f:   ora ($6e),y                 ; 128F:  11 6e
b00_9291:   ldy $9f                     ; 1291:  a4 9f
b00_9293:   adc $e890                   ; 1293:  6d 90 e8
b00_9296:   sbc $b55a,y                 ; 1296:  f9 5a b5
b00_9299:   .db $b3                     ; 1299:  b3
b00_929a:   sta $e965                   ; 129A:  8d 65 e9
b00_929d:   .db $52                     ; 129D:  52
b00_929e:   dex                         ; 129E:  ca
b00_929f:   .db $02                     ; 129F:  02
b00_92a0:   ldy $bb,x                   ; 12A0:  b4 bb
b00_92a2:   .db $74                     ; 12A2:  74
b00_92a3:   .db $54                     ; 12A3:  54
b00_92a4:   ldx $a8,y                   ; 12A4:  b6 a8
b00_92a6:   .db $13                     ; 12A6:  13
b00_92a7:   ror $20cf                   ; 12A7:  6e cf 20
b00_92aa:   .db $23                     ; 12AA:  23
b00_92ab:   inx                         ; 12AB:  e8
b00_92ac:   brk                         ; 12AC:  00
b00_92ad:   brk                         ; 12AD:  00
b00_92ae:   .db $0c                     ; 12AE:  0c
b00_92af:   .db $72                     ; 12AF:  72
b00_92b0:   bcs $9289                   ; 12B0:  b0 d7
b00_92b2:   ldx $92,y                   ; 12B2:  b6 92
b00_92b4:   eor ($cf,x)                 ; 12B4:  41 cf
b00_92b6:   .db $0c                     ; 12B6:  0c
b00_92b7:   .db $72                     ; 12B7:  72
b00_92b8:   bcs $926d                   ; 12B8:  b0 b3
b00_92ba:   .db $0c                     ; 12BA:  0c
b00_92bb:   bcs $9270                   ; 12BB:  b0 b3
b00_92bd:   sbc #$5e                    ; 12BD:  e9 5e
b00_92bf:   .db $cb                     ; 12BF:  cb
b00_92c0:   .db $04                     ; 12C0:  04
b00_92c1:   .db $b3                     ; 12C1:  b3
b00_92c2:   and $5ee9,x                 ; 12C2:  3d e9 5e
b00_92c5:   .db $cb                     ; 12C5:  cb
b00_92c6:   .db $04                     ; 12C6:  04
b00_92c7:   and $0c3d                   ; 12C7:  2d 3d 0c
b00_92ca:   ldy $b3,x                   ; 12CA:  b4 b3
b00_92cc:   bcs $928a                   ; 12CC:  b0 bc
b00_92ce:   lda ($3d),y                 ; 12CE:  b1 3d
b00_92d0:   .db $0c                     ; 12D0:  0c
b00_92d1:   .db $72                     ; 12D1:  72
b00_92d2:   ldy $b3,x                   ; 12D2:  b4 b3
b00_92d4:   bcs $9292                   ; 12D4:  b0 bc
b00_92d6:   lda ($40),y                 ; 12D6:  b1 40
b00_92d8:   .db $cf                     ; 12D8:  cf
b00_92d9:   jsr $e823                   ; 12D9:  20 23 e8
b00_92dc:   brk                         ; 12DC:  00
b00_92dd:   brk                         ; 12DD:  00
b00_92de:   .db $0c                     ; 12DE:  0c
b00_92df:   bcs $9331                   ; 12DF:  b0 50
b00_92e1:   .db $c3                     ; 12E1:  c3
b00_92e2:   .db $d7                     ; 12E2:  d7
b00_92e3:   sbc $92,x                   ; 12E3:  f5 92
b00_92e5:   ora $b3b0                   ; 12E5:  0d b0 b3
b00_92e8:   .db $0c                     ; 12E8:  0c
b00_92e9:   ldy $b3,x                   ; 12E9:  b4 b3
b00_92eb:   bcs $92a9                   ; 12EB:  b0 bc
b00_92ed:   lda ($0c),y                 ; 12ED:  b1 0c
b00_92ef:   bcs $9341                   ; 12EF:  b0 50
b00_92f1:   .db $c2                     ; 12F1:  c2
b00_92f2:   cld                         ; 12F2:  d8
b00_92f3:   sed                         ; 12F3:  f8
b00_92f4:   .db $92                     ; 12F4:  92
b00_92f5:   and $b140,x                 ; 12F5:  3d 40 b1
b00_92f8:   .db $cf                     ; 12F8:  cf
b00_92f9:   jsr $e823                   ; 12F9:  20 23 e8
b00_92fc:   brk                         ; 12FC:  00
b00_92fd:   brk                         ; 12FD:  00
b00_92fe:   .db $62                     ; 12FE:  62
b00_92ff:   sbc #$52                    ; 12FF:  e9 52
b00_9301:   dex                         ; 1301:  ca
b00_9302:   .db $02                     ; 1302:  02
b00_9303:   .db $d7                     ; 1303:  d7
b00_9304:   ora $0c93                   ; 1304:  0d 93 0c
b00_9307:   bcs $9359                   ; 1307:  b0 50
b00_9309:   .db $c3                     ; 1309:  c3
b00_930a:   cld                         ; 130A:  d8
b00_930b:   .db $0f                     ; 130B:  0f
b00_930c:   .db $93                     ; 130C:  93
b00_930d:   rti                         ; 130D:  40
b00_930e:   .db $cf                     ; 130E:  cf
b00_930f:   .db $3c                     ; 130F:  3c
b00_9310:   sta $e91e                   ; 1310:  8d 1e e9
b00_9313:   .db $52                     ; 1313:  52
b00_9314:   dex                         ; 1314:  ca
b00_9315:   .db $02                     ; 1315:  02
b00_9316:   .db $8f                     ; 1316:  8f
b00_9317:   plp                         ; 1317:  28
b00_9318:   .db $b3                     ; 1318:  b3
b00_9319:   .db $0c                     ; 1319:  0c
b00_931a:   bcs $92cf                   ; 131A:  b0 b3
b00_931c:   sbc #$0d                    ; 131C:  e9 0d
b00_931e:   .db $d7                     ; 131E:  d7
b00_931f:   .db $04                     ; 131F:  04
b00_9320:   lda ($41),y                 ; 1320:  b1 41
b00_9322:   .db $cf                     ; 1322:  cf
b00_9323:   jsr $e823                   ; 1323:  20 23 e8
b00_9326:   brk                         ; 1326:  00
b00_9327:   brk                         ; 1327:  00
b00_9328:   ldy $63                     ; 1328:  a4 63
b00_932a:   .db $6f                     ; 132A:  6f
b00_932b:   .db $8b                     ; 132B:  8b
b00_932c:   .db $1a                     ; 132C:  1a
b00_932d:   lda $8c,x                   ; 132D:  b5 8c
b00_932f:   .db $0b                     ; 132F:  0b
b00_9330:   bvs $92ed                   ; 1330:  70 bb
b00_9332:   .db $b3                     ; 1332:  b3
b00_9333:   sbc #$f9                    ; 1333:  e9 f9
b00_9335:   .db $92                     ; 1335:  92
b00_9336:   .db $02                     ; 1336:  02
b00_9337:   .db $cf                     ; 1337:  cf
b00_9338:   jsr $e823                   ; 1338:  20 23 e8
b00_933b:   brk                         ; 133B:  00
b00_933c:   brk                         ; 133C:  00
b00_933d:   ldy $63                     ; 133D:  a4 63
b00_933f:   .db $6f                     ; 133F:  6f
b00_9340:   .db $8b                     ; 1340:  8b
b00_9341:   .db $1a                     ; 1341:  1a
b00_9342:   lda $8c,x                   ; 1342:  b5 8c
b00_9344:   ora #$70                    ; 1344:  09 70
b00_9346:   .db $bb                     ; 1346:  bb
b00_9347:   .db $b3                     ; 1347:  b3
b00_9348:   sbc #$f9                    ; 1348:  e9 f9
b00_934a:   .db $92                     ; 134A:  92
b00_934b:   .db $02                     ; 134B:  02
b00_934c:   cld                         ; 134C:  d8
b00_934d:   adc #$93                    ; 134D:  69 93
b00_934f:   sta $e964                   ; 134F:  8d 64 e9
b00_9352:   .db $52                     ; 1352:  52
b00_9353:   dex                         ; 1353:  ca
b00_9354:   .db $02                     ; 1354:  02
b00_9355:   .db $8f                     ; 1355:  8f
b00_9356:   .db $64                     ; 1356:  64
b00_9357:   .db $b3                     ; 1357:  b3
b00_9358:   ldy $5f                     ; 1358:  a4 5f
b00_935a:   .db $6f                     ; 135A:  6f
b00_935b:   .db $8b                     ; 135B:  8b
b00_935c:   .db $1a                     ; 135C:  1a
b00_935d:   lda $8c,x                   ; 135D:  b5 8c
b00_935f:   .db $0f                     ; 135F:  0f
b00_9360:   bvs $931d                   ; 1360:  70 bb
b00_9362:   ldy $b3,x                   ; 1362:  b4 b3
b00_9364:   bcs $9321                   ; 1364:  b0 bb
b00_9366:   lda ($41),y                 ; 1366:  b1 41
b00_9368:   .db $cf                     ; 1368:  cf
b00_9369:   rti                         ; 1369:  40
b00_936a:   .db $cf                     ; 136A:  cf
b00_936b:   jsr $e823                   ; 136B:  20 23 e8
b00_936e:   brk                         ; 136E:  00
b00_936f:   brk                         ; 136F:  00
b00_9370:   ldy $63                     ; 1370:  a4 63
b00_9372:   .db $6f                     ; 1372:  6f
b00_9373:   .db $8b                     ; 1373:  8b
b00_9374:   .db $1a                     ; 1374:  1a
b00_9375:   lda $8c,x                   ; 1375:  b5 8c
b00_9377:   ora $70                     ; 1377:  05 70
b00_9379:   .db $bb                     ; 1379:  bb
b00_937a:   .db $b3                     ; 137A:  b3
b00_937b:   sbc #$f9                    ; 137B:  e9 f9
b00_937d:   .db $92                     ; 137D:  92
b00_937e:   .db $02                     ; 137E:  02
b00_937f:   .db $cf                     ; 137F:  cf
b00_9380:   jsr $e823                   ; 1380:  20 23 e8
b00_9383:   brk                         ; 1383:  00
b00_9384:   brk                         ; 1384:  00
b00_9385:   ldy $63                     ; 1385:  a4 63
b00_9387:   .db $6f                     ; 1387:  6f
b00_9388:   .db $8b                     ; 1388:  8b
b00_9389:   .db $1a                     ; 1389:  1a
b00_938a:   lda $8c,x                   ; 138A:  b5 8c
b00_938c:   .db $0f                     ; 138C:  0f
b00_938d:   bvs $934a                   ; 138D:  70 bb
b00_938f:   .db $b3                     ; 138F:  b3
b00_9390:   sbc #$f9                    ; 1390:  e9 f9
b00_9392:   .db $92                     ; 1392:  92
b00_9393:   .db $02                     ; 1393:  02
b00_9394:   .db $cf                     ; 1394:  cf
b00_9395:   jsr $e823                   ; 1395:  20 23 e8
b00_9398:   brk                         ; 1398:  00
b00_9399:   brk                         ; 1399:  00
b00_939a:   ldy $63                     ; 139A:  a4 63
b00_939c:   .db $6f                     ; 139C:  6f
b00_939d:   .db $8b                     ; 139D:  8b
b00_939e:   .db $1a                     ; 139E:  1a
b00_939f:   lda $8c,x                   ; 139F:  b5 8c
b00_93a1:   .db $13                     ; 13A1:  13
b00_93a2:   bvs $935f                   ; 13A2:  70 bb
b00_93a4:   .db $b3                     ; 13A4:  b3
b00_93a5:   sbc #$f9                    ; 13A5:  e9 f9
b00_93a7:   .db $92                     ; 13A7:  92
b00_93a8:   .db $02                     ; 13A8:  02
b00_93a9:   .db $cf                     ; 13A9:  cf
b00_93aa:   jsr $e823                   ; 13AA:  20 23 e8
b00_93ad:   brk                         ; 13AD:  00
b00_93ae:   brk                         ; 13AE:  00
b00_93af:   ldy $63                     ; 13AF:  a4 63
b00_93b1:   .db $6f                     ; 13B1:  6f
b00_93b2:   .db $8b                     ; 13B2:  8b
b00_93b3:   .db $1a                     ; 13B3:  1a
b00_93b4:   lda $8c,x                   ; 13B4:  b5 8c
b00_93b6:   ora $bb70                   ; 13B6:  0d 70 bb
b00_93b9:   .db $b3                     ; 13B9:  b3
b00_93ba:   sbc #$f9                    ; 13BA:  e9 f9
b00_93bc:   .db $92                     ; 13BC:  92
b00_93bd:   .db $02                     ; 13BD:  02
b00_93be:   .db $cf                     ; 13BE:  cf
b00_93bf:   jsr $e823                   ; 13BF:  20 23 e8
b00_93c2:   .db $fc                     ; 13C2:  fc
b00_93c3:   .db $ff                     ; 13C3:  ff
b00_93c4:   stx $bbc6                   ; 13C4:  8e c6 bb
b00_93c7:   sbc #$26                    ; 13C7:  e9 26
b00_93c9:   .db $d3                     ; 13C9:  d3
b00_93ca:   .db $02                     ; 13CA:  02
b00_93cb:   tax                         ; 13CB:  aa
b00_93cc:   .db $63                     ; 13CC:  63
b00_93cd:   .db $6f                     ; 13CD:  6f
b00_93ce:   sbc #$8b                    ; 13CE:  e9 8b
b00_93d0:   .db $d7                     ; 13D0:  d7
b00_93d1:   .db $02                     ; 13D1:  02
b00_93d2:   stx $bbc7                   ; 13D2:  8e c7 bb
b00_93d5:   sbc #$c4                    ; 13D5:  e9 c4
b00_93d7:   dec $a402                   ; 13D7:  ce 02 a4
b00_93da:   .db $63                     ; 13DA:  63
b00_93db:   .db $6f                     ; 13DB:  6f
b00_93dc:   bne $9391                   ; 13DC:  d0 b3
b00_93de:   stx $bbec                   ; 13DE:  8e ec bb
b00_93e1:   sbc #$34                    ; 13E1:  e9 34
b00_93e3:   cmp ($04),y                 ; 13E3:  d1 04
b00_93e5:   ldy $d766                   ; 13E5:  ac 66 d7
b00_93e8:   .db $6f                     ; 13E8:  6f
b00_93e9:   sbc #$0c                    ; 13E9:  e9 0c
b00_93eb:   inx                         ; 13EB:  e8
b00_93ec:   .db $02                     ; 13EC:  02
b00_93ed:   ldy $9323                   ; 13ED:  ac 23 93
b00_93f0:   .db $d7                     ; 13F0:  d7
b00_93f1:   lsr $ac94                   ; 13F1:  4e 94 ac
b00_93f4:   .db $6b                     ; 13F4:  6b
b00_93f5:   .db $93                     ; 13F5:  93
b00_93f6:   .db $d7                     ; 13F6:  d7
b00_93f7:   lsr $ac94                   ; 13F7:  4e 94 ac
b00_93fa:   tax                         ; 13FA:  aa
b00_93fb:   .db $93                     ; 13FB:  93
b00_93fc:   .db $d7                     ; 13FC:  d7
b00_93fd:   lsr $ac94                   ; 13FD:  4e 94 ac
b00_9400:   sta $93,x                   ; 1400:  95 93
b00_9402:   .db $d7                     ; 1402:  d7
b00_9403:   lsr $ac94                   ; 1403:  4e 94 ac
b00_9406:   .db $80                     ; 1406:  80
b00_9407:   .db $93                     ; 1407:  93
b00_9408:   .db $d7                     ; 1408:  d7
b00_9409:   lsr $ac94                   ; 1409:  4e 94 ac
b00_940c:   sec                         ; 140C:  38
b00_940d:   .db $93                     ; 140D:  93
b00_940e:   .db $d7                     ; 140E:  d7
b00_940f:   lsr $6294                   ; 140F:  4e 94 62
b00_9412:   sbc #$52                    ; 1412:  e9 52
b00_9414:   dex                         ; 1414:  ca
b00_9415:   .db $02                     ; 1415:  02
b00_9416:   cld                         ; 1416:  d8
b00_9417:   .db $6b                     ; 1417:  6b
b00_9418:   sty $a4,x                   ; 1418:  94 a4
b00_941a:   .db $63                     ; 141A:  63
b00_941b:   .db $6f                     ; 141B:  6f
b00_941c:   .db $8b                     ; 141C:  8b
b00_941d:   .db $1a                     ; 141D:  1a
b00_941e:   lda $8c,x                   ; 141E:  b5 8c
b00_9420:   ora ($70,x)                 ; 1420:  01 70
b00_9422:   .db $bb                     ; 1422:  bb
b00_9423:   .db $2b                     ; 1423:  2b
b00_9424:   tax                         ; 1424:  aa
b00_9425:   .db $63                     ; 1425:  63
b00_9426:   .db $6f                     ; 1426:  6f
b00_9427:   sbc #$da                    ; 1427:  e9 da
b00_9429:   .db $d7                     ; 1429:  d7
b00_942a:   .db $02                     ; 142A:  02
b00_942b:   rol a                       ; 142B:  2a
b00_942c:   .db $0b                     ; 142C:  0b
b00_942d:   .db $7a                     ; 142D:  7a
b00_942e:   bcs $9480                   ; 142E:  b0 50
b00_9430:   .db $c3                     ; 1430:  c3
b00_9431:   cld                         ; 1431:  d8
b00_9432:   .db $53                     ; 1432:  53
b00_9433:   sty $65,x                   ; 1433:  94 65
b00_9435:   sbc #$52                    ; 1435:  e9 52
b00_9437:   dex                         ; 1437:  ca
b00_9438:   .db $02                     ; 1438:  02
b00_9439:   .db $b3                     ; 1439:  b3
b00_943a:   asl a                       ; 143A:  0a
b00_943b:   .db $74                     ; 143B:  74
b00_943c:   .db $b3                     ; 143C:  b3
b00_943d:   sbc #$12                    ; 143D:  e9 12
b00_943f:   dex                         ; 143F:  ca
b00_9440:   .db $04                     ; 1440:  04
b00_9441:   adc $e9                     ; 1441:  65 e9
b00_9443:   .db $52                     ; 1443:  52
b00_9444:   dex                         ; 1444:  ca
b00_9445:   .db $02                     ; 1445:  02
b00_9446:   .db $b3                     ; 1446:  b3
b00_9447:   asl a                       ; 1447:  0a
b00_9448:   bne $93fd                   ; 1448:  d0 b3
b00_944a:   sbc #$12                    ; 144A:  e9 12
b00_944c:   dex                         ; 144C:  ca
b00_944d:   .db $04                     ; 144D:  04
b00_944e:   ldy $d766                   ; 144E:  ac 66 d7
b00_9451:   eor ($cf,x)                 ; 1451:  41 cf
b00_9453:   .db $0b                     ; 1453:  0b
b00_9454:   .db $7a                     ; 1454:  7a
b00_9455:   .db $b3                     ; 1455:  b3
b00_9456:   sta $e91e                   ; 1456:  8d 1e e9
b00_9459:   .db $52                     ; 1459:  52
b00_945a:   dex                         ; 145A:  ca
b00_945b:   .db $02                     ; 145B:  02
b00_945c:   .db $8f                     ; 145C:  8f
b00_945d:   .db $3c                     ; 145D:  3c
b00_945e:   .db $b3                     ; 145E:  b3
b00_945f:   .db $0b                     ; 145F:  0b
b00_9460:   .db $7a                     ; 1460:  7a
b00_9461:   bcs $9416                   ; 1461:  b0 b3
b00_9463:   sbc #$0d                    ; 1463:  e9 0d
b00_9465:   .db $d7                     ; 1465:  d7
b00_9466:   .db $04                     ; 1466:  04
b00_9467:   lda ($d6),y                 ; 1467:  b1 d6
b00_9469:   lsr $4094                   ; 1469:  4e 94 40
b00_946c:   .db $cf                     ; 146C:  cf
b00_946d:   jsr $e823                   ; 146D:  20 23 e8
b00_9470:   brk                         ; 1470:  00
b00_9471:   brk                         ; 1471:  00
b00_9472:   .db $3c                     ; 1472:  3c
b00_9473:   sbc #$da                    ; 1473:  e9 da
b00_9475:   .db $d7                     ; 1475:  d7
b00_9476:   .db $02                     ; 1476:  02
b00_9477:   .db $74                     ; 1477:  74
b00_9478:   .db $d3                     ; 1478:  d3
b00_9479:   .db $cf                     ; 1479:  cf
b00_947a:   jsr $e823                   ; 147A:  20 23 e8
b00_947d:   .db $fa                     ; 147D:  fa
b00_947e:   .db $ff                     ; 147E:  ff
b00_947f:   stx $00ff                   ; 147F:  8e ff 00
b00_9482:   sbc #$dc                    ; 1482:  e9 dc
b00_9484:   cpx $02                     ; 1484:  e4 02
b00_9486:   rti                         ; 1486:  40
b00_9487:   and #$40                    ; 1487:  29 40
b00_9489:   rol a                       ; 1489:  2a
b00_948a:   txa                         ; 148A:  8a
b00_948b:   .db $89                     ; 148B:  89
b00_948c:   .db $6f                     ; 148C:  6f
b00_948d:   .db $2b                     ; 148D:  2b
b00_948e:   dec $a4,x                   ; 148E:  d6 a4
b00_9490:   sty $0b,x                   ; 1490:  94 0b
b00_9492:   .db $d3                     ; 1492:  d3
b00_9493:   .db $b3                     ; 1493:  b3
b00_9494:   sbc #$6d                    ; 1494:  e9 6d
b00_9496:   sty $02,x                   ; 1496:  94 02
b00_9498:   cmp $bb0a                   ; 1498:  cd 0a bb
b00_949b:   rol a                       ; 149B:  2a
b00_949c:   .db $0b                     ; 149C:  0b
b00_949d:   bne $94ca                   ; 149D:  d0 2b
b00_949f:   cmp ($09),y                 ; 149F:  d1 09
b00_94a1:   bne $94cc                   ; 14A1:  d0 29
b00_94a3:   cmp ($0b),y                 ; 14A3:  d1 0b
b00_94a5:   .db $d3                     ; 14A5:  d3
b00_94a6:   sty $00ff                   ; 14A6:  8c ff 00
b00_94a9:   cmp ($d7,x)                 ; 14A9:  c1 d7
b00_94ab:   sta ($94),y                 ; 14AB:  91 94
b00_94ad:   asl a                       ; 14AD:  0a
b00_94ae:   ora $cfb8,y                 ; 14AE:  19 b8 cf
b00_94b1:   jsr $e823                   ; 14B1:  20 23 e8
b00_94b4:   .db $fc                     ; 14B4:  fc
b00_94b5:   .db $ff                     ; 14B5:  ff
b00_94b6:   .db $0c                     ; 14B6:  0c
b00_94b7:   cmp $0002,y                 ; 14B7:  d9 02 00
b00_94ba:   ora ($00,x)                 ; 14BA:  01 00
b00_94bc:   cpy $94                     ; 14BC:  c4 94
b00_94be:   .db $02                     ; 14BE:  02
b00_94bf:   brk                         ; 14BF:  00
b00_94c0:   sbc #$94                    ; 14C0:  e9 94
b00_94c2:   dec $8e94                   ; 14C2:  ce 94 8e
b00_94c5:   sbc ($bb),y                 ; 14C5:  f1 bb
b00_94c7:   sbc #$26                    ; 14C7:  e9 26
b00_94c9:   .db $d3                     ; 14C9:  d3
b00_94ca:   .db $02                     ; 14CA:  02
b00_94cb:   ldy $d766                   ; 14CB:  ac 66 d7
b00_94ce:   rti                         ; 14CE:  40
b00_94cf:   .db $2b                     ; 14CF:  2b
b00_94d0:   dec $1d,x                   ; 14D0:  d6 1d
b00_94d2:   sta $3a,x                   ; 14D2:  95 3a
b00_94d4:   sbc #$8d                    ; 14D4:  e9 8d
b00_94d6:   cmp $d802,y                 ; 14D6:  d9 02 d8
b00_94d9:   ora $0c95,x                 ; 14D9:  1d 95 0c
b00_94dc:   cmp $0002,y                 ; 14DC:  d9 02 00
b00_94df:   ora ($00,x)                 ; 14DF:  01 00
b00_94e1:   .db $ef                     ; 14E1:  ef
b00_94e2:   sty $02,x                   ; 14E2:  94 02
b00_94e4:   brk                         ; 14E4:  00
b00_94e5:   .db $04                     ; 14E5:  04
b00_94e6:   sta $1d,x                   ; 14E6:  95 1d
b00_94e8:   sta $8e,x                   ; 14E8:  95 8e
b00_94ea:   .db $13                     ; 14EA:  13
b00_94eb:   ldy $c7d6,x                 ; 14EB:  bc d6 c7
b00_94ee:   sty $8e,x                   ; 14EE:  94 8e
b00_94f0:   rol a                       ; 14F0:  2a
b00_94f1:   ldy $26e9,x                 ; 14F1:  bc e9 26
b00_94f4:   .db $d3                     ; 14F4:  d3
b00_94f5:   .db $02                     ; 14F5:  02
b00_94f6:   .db $3a                     ; 14F6:  3a
b00_94f7:   sbc #$8b                    ; 14F7:  e9 8b
b00_94f9:   .db $d7                     ; 14F9:  d7
b00_94fa:   .db $02                     ; 14FA:  02
b00_94fb:   asl a                       ; 14FB:  0a
b00_94fc:   bne $94b1                   ; 14FC:  d0 b3
b00_94fe:   stx $bc2b                   ; 14FE:  8e 2b bc
b00_9501:   dec $16,x                   ; 1501:  d6 16
b00_9503:   sta $8e,x                   ; 1503:  95 8e
b00_9505:   .db $4b                     ; 1505:  4b
b00_9506:   ldy $26e9,x                 ; 1506:  bc e9 26
b00_9509:   .db $d3                     ; 1509:  d3
b00_950a:   .db $02                     ; 150A:  02
b00_950b:   .db $3a                     ; 150B:  3a
b00_950c:   sbc #$8b                    ; 150C:  e9 8b
b00_950e:   .db $d7                     ; 150E:  d7
b00_950f:   .db $02                     ; 150F:  02
b00_9510:   asl a                       ; 1510:  0a
b00_9511:   bne $94c6                   ; 1511:  d0 b3
b00_9513:   stx $bc4c                   ; 1513:  8e 4c bc
b00_9516:   sbc #$34                    ; 1516:  e9 34
b00_9518:   cmp ($04),y                 ; 1518:  d1 04
b00_951a:   ldy $d766                   ; 151A:  ac 66 d7
b00_951d:   .db $0b                     ; 151D:  0b
b00_951e:   bne $954b                   ; 151E:  d0 2b
b00_9520:   cmp ($8c),y                 ; 1520:  d1 8c
b00_9522:   lda $bb7b                   ; 1522:  ad 7b bb
b00_9525:   .db $d3                     ; 1525:  d3
b00_9526:   rol a                       ; 1526:  2a
b00_9527:   sty $00ff                   ; 1527:  8c ff 00
b00_952a:   cmp ($d7,x)                 ; 152A:  c1 d7
b00_952c:   .db $d3                     ; 152C:  d3
b00_952d:   sty $cf,x                   ; 152D:  94 cf
b00_952f:   jsr $e823                   ; 152F:  20 23 e8
b00_9532:   .db $fc                     ; 1532:  fc
b00_9533:   .db $ff                     ; 1533:  ff
b00_9534:   rti                         ; 1534:  40
b00_9535:   .db $2b                     ; 1535:  2b
b00_9536:   rti                         ; 1536:  40
b00_9537:   dec $46,x                   ; 1537:  d6 46
b00_9539:   sta $0a,x                   ; 1539:  95 0a
b00_953b:   sty $6d2d                   ; 153B:  8c 2d 6d
b00_953e:   .db $bb                     ; 153E:  bb
b00_953f:   .db $d3                     ; 153F:  d3
b00_9540:   cmp $bb0b                   ; 1540:  cd 0b bb
b00_9543:   .db $2b                     ; 1543:  2b
b00_9544:   asl a                       ; 1544:  0a
b00_9545:   bne $9571                   ; 1545:  d0 2a
b00_9547:   asl a                       ; 1547:  0a
b00_9548:   ldx $9d                     ; 1548:  a6 9d
b00_954a:   adc $d7c6                   ; 154A:  6d c6 d7
b00_954d:   .db $3a                     ; 154D:  3a
b00_954e:   sta $a4,x                   ; 154E:  95 a4
b00_9550:   sta $cd6d,x                 ; 1550:  9d 6d cd
b00_9553:   .db $0b                     ; 1553:  0b
b00_9554:   clv                         ; 1554:  b8
b00_9555:   .db $2b                     ; 1555:  2b
b00_9556:   .db $0b                     ; 1556:  0b
b00_9557:   .db $cf                     ; 1557:  cf
b00_9558:   jsr $e823                   ; 1558:  20 23 e8
b00_955b:   sed                         ; 155B:  f8
b00_955c:   .db $ff                     ; 155C:  ff
b00_955d:   rti                         ; 155D:  40
b00_955e:   plp                         ; 155E:  28
b00_955f:   rti                         ; 155F:  40
b00_9560:   .db $2b                     ; 1560:  2b
b00_9561:   rti                         ; 1561:  40
b00_9562:   rol a                       ; 1562:  2a
b00_9563:   dec $85,x                   ; 1563:  d6 85
b00_9565:   sta $08,x                   ; 1565:  95 08
b00_9567:   .db $8b                     ; 1567:  8b
b00_9568:   .db $1a                     ; 1568:  1a
b00_9569:   lda $8c,x                   ; 1569:  b5 8c
b00_956b:   .db $0f                     ; 156B:  0f
b00_956c:   bvs $9529                   ; 156C:  70 bb
b00_956e:   bcs $9599                   ; 156E:  b0 29
b00_9570:   ora #$a6                    ; 1570:  09 a6
b00_9572:   sta $b86d,x                 ; 1572:  9d 6d b8
b00_9575:   cmp $bb0b                   ; 1575:  cd 0b bb
b00_9578:   .db $2b                     ; 1578:  2b
b00_9579:   ora #$a6                    ; 1579:  09 a6
b00_957b:   sta $ba6d,x                 ; 157B:  9d 6d ba
b00_957e:   cmp $bb0a                   ; 157E:  cd 0a bb
b00_9581:   rol a                       ; 1581:  2a
b00_9582:   php                         ; 1582:  08
b00_9583:   bne $95ad                   ; 1583:  d0 28
b00_9585:   php                         ; 1585:  08
b00_9586:   ldx $9d                     ; 1586:  a6 9d
b00_9588:   adc $d7c6                   ; 1588:  6d c6 d7
b00_958b:   ror $95                     ; 158B:  66 95
b00_958d:   asl a                       ; 158D:  0a
b00_958e:   ldx $9d                     ; 158E:  a6 9d
b00_9590:   adc $1bb8                   ; 1590:  6d b8 1b
b00_9593:   .db $bb                     ; 1593:  bb
b00_9594:   .db $cf                     ; 1594:  cf
b00_9595:   jsr $e823                   ; 1595:  20 23 e8
b00_9598:   .db $fa                     ; 1598:  fa
b00_9599:   .db $ff                     ; 1599:  ff
b00_959a:   stx $bc6a                   ; 159A:  8e 6a bc
b00_959d:   sbc #$26                    ; 159D:  e9 26
b00_959f:   .db $d3                     ; 159F:  d3
b00_95a0:   .db $02                     ; 15A0:  02
b00_95a1:   .db $0c                     ; 15A1:  0c
b00_95a2:   bne $9557                   ; 15A2:  d0 b3
b00_95a4:   stx $bc73                   ; 15A4:  8e 73 bc
b00_95a7:   sbc #$34                    ; 15A7:  e9 34
b00_95a9:   cmp ($04),y                 ; 15A9:  d1 04
b00_95ab:   .db $0c                     ; 15AB:  0c
b00_95ac:   .db $8b                     ; 15AC:  8b
b00_95ad:   .db $1a                     ; 15AD:  1a
b00_95ae:   lda $8c,x                   ; 15AE:  b5 8c
b00_95b0:   ora ($70,x)                 ; 15B0:  01 70
b00_95b2:   .db $bb                     ; 15B2:  bb
b00_95b3:   .db $2b                     ; 15B3:  2b
b00_95b4:   sta $e91f                   ; 15B4:  8d 1f e9
b00_95b7:   .db $52                     ; 15B7:  52
b00_95b8:   dex                         ; 15B8:  ca
b00_95b9:   .db $02                     ; 15B9:  02
b00_95ba:   .db $b3                     ; 15BA:  b3
b00_95bb:   .db $3c                     ; 15BB:  3c
b00_95bc:   sbc #$da                    ; 15BC:  e9 da
b00_95be:   .db $d7                     ; 15BE:  d7
b00_95bf:   .db $02                     ; 15BF:  02
b00_95c0:   .db $74                     ; 15C0:  74
b00_95c1:   .db $d3                     ; 15C1:  d3
b00_95c2:   .db $b3                     ; 15C2:  b3
b00_95c3:   stx $00c8                   ; 15C3:  8e c8 00
b00_95c6:   sbc #$5e                    ; 15C6:  e9 5e
b00_95c8:   .db $cb                     ; 15C8:  cb
b00_95c9:   .db $04                     ; 15C9:  04
b00_95ca:   .db $53                     ; 15CA:  53
b00_95cb:   lda $8b,x                   ; 15CB:  b5 8b
b00_95cd:   .db $14                     ; 15CD:  14
b00_95ce:   ldx $b3,y                   ; 15CE:  b6 b3
b00_95d0:   .db $0b                     ; 15D0:  0b
b00_95d1:   .db $8f                     ; 15D1:  8f
b00_95d2:   .db $12                     ; 15D2:  12
b00_95d3:   bcs $9588                   ; 15D3:  b0 b3
b00_95d5:   sta $e964                   ; 15D5:  8d 64 e9
b00_95d8:   lsr $04cb,x                 ; 15D8:  5e cb 04
b00_95db:   .db $53                     ; 15DB:  53
b00_95dc:   lda $5a,x                   ; 15DC:  b5 5a
b00_95de:   ldx $b4,y                   ; 15DE:  b6 b4
b00_95e0:   .db $bb                     ; 15E0:  bb
b00_95e1:   ldy $bb,x                   ; 15E1:  b4 bb
b00_95e3:   .db $7a                     ; 15E3:  7a
b00_95e4:   .db $b3                     ; 15E4:  b3
b00_95e5:   .db $0b                     ; 15E5:  0b
b00_95e6:   .db $8f                     ; 15E6:  8f
b00_95e7:   bpl $9599                   ; 15E7:  10 b0
b00_95e9:   .db $b3                     ; 15E9:  b3
b00_95ea:   sbc #$0d                    ; 15EA:  e9 0d
b00_95ec:   .db $d7                     ; 15EC:  d7
b00_95ed:   .db $04                     ; 15ED:  04
b00_95ee:   rol a                       ; 15EE:  2a
b00_95ef:   .db $0b                     ; 15EF:  0b
b00_95f0:   .db $8f                     ; 15F0:  8f
b00_95f1:   bpl $95a3                   ; 15F1:  10 b0
b00_95f3:   .db $1a                     ; 15F3:  1a
b00_95f4:   ldy $3929,x                 ; 15F4:  bc 29 39
b00_95f7:   .db $3a                     ; 15F7:  3a
b00_95f8:   stx $bc78                   ; 15F8:  8e 78 bc
b00_95fb:   sbc #$34                    ; 15FB:  e9 34
b00_95fd:   cmp ($06),y                 ; 15FD:  d1 06
b00_95ff:   ldy $d766                   ; 15FF:  ac 66 d7
b00_9602:   asl a                       ; 1602:  0a
b00_9603:   ora $d8c0,y                 ; 1603:  19 c0 d8
b00_9606:   bpl $959e                   ; 1606:  10 96
b00_9608:   .db $62                     ; 1608:  62
b00_9609:   sbc #$52                    ; 1609:  e9 52
b00_960b:   dex                         ; 160B:  ca
b00_960c:   .db $02                     ; 160C:  02
b00_960d:   bvc $95cf                   ; 160D:  50 c0
b00_960f:   .db $cf                     ; 160F:  cf
b00_9610:   asl a                       ; 1610:  0a
b00_9611:   ora $cfc2,y                 ; 1611:  19 c2 cf
b00_9614:   jsr $e823                   ; 1614:  20 23 e8
b00_9617:   brk                         ; 1617:  00
b00_9618:   brk                         ; 1618:  00
b00_9619:   adc ($3d,x)                 ; 1619:  61 3d
b00_961b:   .db $3c                     ; 161B:  3c
b00_961c:   sbc #$99                    ; 161C:  e9 99
b00_961e:   stx $cf06                   ; 161E:  8e 06 cf
b00_9621:   jsr $e823                   ; 1621:  20 23 e8
b00_9624:   .db $fb                     ; 1624:  fb
b00_9625:   .db $ff                     ; 1625:  ff
b00_9626:   ldy $ab                     ; 1626:  a4 ab
b00_9628:   .db $7b                     ; 1628:  7b
b00_9629:   tay                         ; 1629:  a8
b00_962a:   .db $5f                     ; 162A:  5f
b00_962b:   .db $6f                     ; 162B:  6f
b00_962c:   .db $89                     ; 162C:  89
b00_962d:   asl $63a8,x                 ; 162D:  1e a8 63
b00_9630:   .db $6f                     ; 1630:  6f
b00_9631:   rti                         ; 1631:  40
b00_9632:   dec $59,x                   ; 1632:  d6 59
b00_9634:   stx $3b,y                   ; 1634:  96 3b
b00_9636:   sbc #$72                    ; 1636:  e9 72
b00_9638:   .db $d7                     ; 1638:  d7
b00_9639:   .db $02                     ; 1639:  02
b00_963a:   .db $8b                     ; 163A:  8b
b00_963b:   clc                         ; 163B:  18
b00_963c:   cpy #$d8                    ; 163C:  c0 d8
b00_963e:   .db $57                     ; 163E:  57
b00_963f:   stx $0b,y                   ; 163F:  96 0b
b00_9641:   sty $6da2                   ; 1641:  8c a2 6d
b00_9644:   .db $bb                     ; 1644:  bb
b00_9645:   .db $d3                     ; 1645:  d3
b00_9646:   .db $d7                     ; 1646:  d7
b00_9647:   .db $57                     ; 1647:  57
b00_9648:   stx $0b,y                   ; 1648:  96 0b
b00_964a:   sty $6e15                   ; 164A:  8c 15 6e
b00_964d:   .db $bb                     ; 164D:  bb
b00_964e:   .db $b3                     ; 164E:  b3
b00_964f:   .db $89                     ; 164F:  89
b00_9650:   .db $32                     ; 1650:  32
b00_9651:   .db $d4                     ; 1651:  d4
b00_9652:   .db $3b                     ; 1652:  3b
b00_9653:   sbc #$54                    ; 1653:  e9 54
b00_9655:   sbc $02                     ; 1655:  e5 02
b00_9657:   .db $0b                     ; 1657:  0b
b00_9658:   bne $9685                   ; 1658:  d0 2b
b00_965a:   .db $0b                     ; 165A:  0b
b00_965b:   ldx $9d                     ; 165B:  a6 9d
b00_965d:   adc $d7c6                   ; 165D:  6d c6 d7
b00_9660:   and $96,x                   ; 1660:  35 96
b00_9662:   ldy $5f                     ; 1662:  a4 5f
b00_9664:   .db $6f                     ; 1664:  6f
b00_9665:   sty $6cf7                   ; 1665:  8c f7 6c
b00_9668:   .db $bb                     ; 1668:  bb
b00_9669:   .db $b3                     ; 1669:  b3
b00_966a:   rti                         ; 166A:  40
b00_966b:   .db $d4                     ; 166B:  d4
b00_966c:   ldy $4d                     ; 166C:  a4 4d
b00_966e:   .db $6f                     ; 166E:  6f
b00_966f:   rol a                       ; 166F:  2a
b00_9670:   lda $a1                     ; 1670:  a5 a1
b00_9672:   adc $fba2                   ; 1672:  6d a2 fb
b00_9675:   .db $ff                     ; 1675:  ff
b00_9676:   eor ($a8,x)                 ; 1676:  41 a8
b00_9678:   eor $446f                   ; 1678:  4d 6f 44
b00_967b:   cmp $a1a5                   ; 167B:  cd a5 a1
b00_967e:   adc $a9db                   ; 167E:  6d db a9
b00_9681:   lda ($6d,x)                 ; 1681:  a1 6d
b00_9683:   stx $bcac                   ; 1683:  8e ac bc
b00_9686:   sbc #$26                    ; 1686:  e9 26
b00_9688:   .db $d3                     ; 1688:  d3
b00_9689:   .db $02                     ; 1689:  02
b00_968a:   sta $e962                   ; 168A:  8d 62 e9
b00_968d:   rol $02d7,x                 ; 168D:  3e d7 02
b00_9690:   ldy $cc89                   ; 1690:  ac 89 cc
b00_9693:   adc $e9                     ; 1693:  65 e9
b00_9695:   .db $0c                     ; 1695:  0c
b00_9696:   inx                         ; 1696:  e8
b00_9697:   .db $02                     ; 1697:  02
b00_9698:   asl a                       ; 1698:  0a
b00_9699:   tay                         ; 1699:  a8
b00_969a:   eor $a06f                   ; 169A:  4d 6f a0
b00_969d:   .db $fb                     ; 169D:  fb
b00_969e:   .db $ff                     ; 169E:  ff
b00_969f:   lda #$a1                    ; 169F:  a9 a1
b00_96a1:   adc $a940                   ; 16A1:  6d 40 a9
b00_96a4:   adc $6f                     ; 16A4:  65 6f
b00_96a6:   ldy $81                     ; 16A6:  a4 81
b00_96a8:   .db $6f                     ; 16A8:  6f
b00_96a9:   tay                         ; 16A9:  a8
b00_96aa:   .db $7f                     ; 16AA:  7f
b00_96ab:   .db $6f                     ; 16AB:  6f
b00_96ac:   tay                         ; 16AC:  a8
b00_96ad:   adc $cf6f,x                 ; 16AD:  7d 6f cf
b00_96b0:   jsr $e823                   ; 16B0:  20 23 e8
b00_96b3:   inc $ff,x                   ; 16B3:  f6 ff
b00_96b5:   rti                         ; 16B5:  40
b00_96b6:   rol a                       ; 16B6:  2a
b00_96b7:   ldy $9d                     ; 16B7:  a4 9d
b00_96b9:   adc $328b                   ; 16B9:  6d 8b 32
b00_96bc:   cpy #$d8                    ; 16BC:  c0 d8
b00_96be:   ror $97,x                   ; 16BE:  76 97
b00_96c0:   .db $0c                     ; 16C0:  0c
b00_96c1:   .db $8b                     ; 16C1:  8b
b00_96c2:   asl $d8c0,x                 ; 16C2:  1e c0 d8
b00_96c5:   ror $97,x                   ; 16C5:  76 97
b00_96c7:   .db $3c                     ; 16C7:  3c
b00_96c8:   sbc #$72                    ; 16C8:  e9 72
b00_96ca:   .db $d7                     ; 16CA:  d7
b00_96cb:   .db $02                     ; 16CB:  02
b00_96cc:   .db $8b                     ; 16CC:  8b
b00_96cd:   clc                         ; 16CD:  18
b00_96ce:   cpy #$d8                    ; 16CE:  c0 d8
b00_96d0:   ror $97,x                   ; 16D0:  76 97
b00_96d2:   sta $e91e                   ; 16D2:  8d 1e e9
b00_96d5:   .db $da                     ; 16D5:  da
b00_96d6:   .db $d7                     ; 16D6:  d7
b00_96d7:   .db $02                     ; 16D7:  02
b00_96d8:   .db $d3                     ; 16D8:  d3
b00_96d9:   .db $8b                     ; 16D9:  8b
b00_96da:   plp                         ; 16DA:  28
b00_96db:   cmp $d8                     ; 16DB:  c5 d8
b00_96dd:   ror $97,x                   ; 16DD:  76 97
b00_96df:   ldy $5f                     ; 16DF:  a4 5f
b00_96e1:   .db $6f                     ; 16E1:  6f
b00_96e2:   plp                         ; 16E2:  28
b00_96e3:   .db $89                     ; 16E3:  89
b00_96e4:   asl $5fa8,x                 ; 16E4:  1e a8 5f
b00_96e7:   .db $6f                     ; 16E7:  6f
b00_96e8:   ldy $8c1e                   ; 16E8:  ac 1e 8c
b00_96eb:   cld                         ; 16EB:  d8
b00_96ec:   ror $a597                   ; 16EC:  6e 97 a5
b00_96ef:   lda ($6d,x)                 ; 16EF:  a1 6d
b00_96f1:   .db $52                     ; 16F1:  52
b00_96f2:   .db $da                     ; 16F2:  da
b00_96f3:   .db $d7                     ; 16F3:  d7
b00_96f4:   ror $ac97                   ; 16F4:  6e 97 ac
b00_96f7:   .db $d7                     ; 16F7:  d7
b00_96f8:   .db $da                     ; 16F8:  da
b00_96f9:   stx $6f4f                   ; 16F9:  8e 4f 6f
b00_96fc:   adc ($e9,x)                 ; 16FC:  61 e9
b00_96fe:   .db $3a                     ; 16FE:  3a
b00_96ff:   cmp $4004,x                 ; 16FF:  dd 04 40
b00_9702:   tay                         ; 1702:  a8
b00_9703:   sta ($6f,x)                 ; 1703:  81 6f
b00_9705:   txa                         ; 1705:  8a
b00_9706:   .db $4f                     ; 1706:  4f
b00_9707:   .db $6f                     ; 1707:  6f
b00_9708:   dec $34,x                   ; 1708:  d6 34
b00_970a:   .db $97                     ; 170A:  97
b00_970b:   .db $0b                     ; 170B:  0b
b00_970c:   .db $d3                     ; 170C:  d3
b00_970d:   tay                         ; 170D:  a8
b00_970e:   .db $ab                     ; 170E:  ab
b00_970f:   .db $7b                     ; 170F:  7b
b00_9710:   .db $0b                     ; 1710:  0b
b00_9711:   .db $d3                     ; 1711:  d3
b00_9712:   .db $8b                     ; 1712:  8b
b00_9713:   .db $1a                     ; 1713:  1a
b00_9714:   lda $8c,x                   ; 1714:  b5 8c
b00_9716:   ora ($70),y                 ; 1716:  11 70
b00_9718:   .db $bb                     ; 1718:  bb
b00_9719:   bcs $96e8                   ; 1719:  b0 cd
b00_971b:   ldy $81                     ; 171B:  a4 81
b00_971d:   .db $6f                     ; 171D:  6f
b00_971e:   .db $bb                     ; 171E:  bb
b00_971f:   tay                         ; 171F:  a8
b00_9720:   sta ($6f,x)                 ; 1720:  81 6f
b00_9722:   ldy $81                     ; 1722:  a4 81
b00_9724:   .db $6f                     ; 1724:  6f
b00_9725:   sty $270f                   ; 1725:  8c 0f 27
b00_9728:   cpy $d8                     ; 1728:  c4 d8
b00_972a:   .db $32                     ; 172A:  32
b00_972b:   .db $97                     ; 172B:  97
b00_972c:   txa                         ; 172C:  8a
b00_972d:   .db $0f                     ; 172D:  0f
b00_972e:   .db $27                     ; 172E:  27
b00_972f:   tay                         ; 172F:  a8
b00_9730:   sta ($6f,x)                 ; 1730:  81 6f
b00_9732:   .db $0b                     ; 1732:  0b
b00_9733:   bne $9760                   ; 1733:  d0 2b
b00_9735:   .db $0b                     ; 1735:  0b
b00_9736:   .db $d3                     ; 1736:  d3
b00_9737:   sty $00ff                   ; 1737:  8c ff 00
b00_973a:   cmp ($d7,x)                 ; 173A:  c1 d7
b00_973c:   .db $0b                     ; 173C:  0b
b00_973d:   .db $97                     ; 173D:  97
b00_973e:   ldy $5f                     ; 173E:  a4 5f
b00_9740:   .db $6f                     ; 1740:  6f
b00_9741:   .db $8b                     ; 1741:  8b
b00_9742:   .db $1a                     ; 1742:  1a
b00_9743:   lda $8c,x                   ; 1743:  b5 8c
b00_9745:   ora ($70),y                 ; 1745:  11 70
b00_9747:   .db $bb                     ; 1747:  bb
b00_9748:   bcs $96fd                   ; 1748:  b0 b3
b00_974a:   ldy $81                     ; 174A:  a4 81
b00_974c:   .db $6f                     ; 174C:  6f
b00_974d:   ldy $c4,x                   ; 174D:  b4 c4
b00_974f:   cld                         ; 174F:  d8
b00_9750:   ror $6197                   ; 1750:  6e 97 61
b00_9753:   sbc #$10                    ; 1753:  e9 10
b00_9755:   sbc $02                     ; 1755:  e5 02
b00_9757:   .db $53                     ; 1757:  53
b00_9758:   cmp #$d8                    ; 1758:  c9 d8
b00_975a:   ror $4297                   ; 175A:  6e 97 42
b00_975d:   cmp $a1a5                   ; 175D:  cd a5 a1
b00_9760:   adc $a9db                   ; 1760:  6d db a9
b00_9763:   lda ($6d,x)                 ; 1763:  a1 6d
b00_9765:   ldy $9621                   ; 1765:  ac 21 96
b00_9768:   eor ($a8,x)                 ; 1768:  41 a8
b00_976a:   pha                         ; 176A:  48
b00_976b:   ror $2a41                   ; 176B:  6e 41 2a
b00_976e:   asl a                       ; 176E:  0a
b00_976f:   .db $d7                     ; 176F:  d7
b00_9770:   ror $97,x                   ; 1770:  76 97
b00_9772:   php                         ; 1772:  08
b00_9773:   tay                         ; 1773:  a8
b00_9774:   .db $5f                     ; 1774:  5f
b00_9775:   .db $6f                     ; 1775:  6f
b00_9776:   asl a                       ; 1776:  0a
b00_9777:   .db $cf                     ; 1777:  cf
b00_9778:   jsr $e823                   ; 1778:  20 23 e8
b00_977b:   .db $f2                     ; 177B:  f2
b00_977c:   .db $ff                     ; 177C:  ff
b00_977d:   rti                         ; 177D:  40
b00_977e:   .db $27                     ; 177E:  27
b00_977f:   txa                         ; 177F:  8a
b00_9780:   lda $d67b                   ; 1780:  ad 7b d6
b00_9783:   ror $0b98                   ; 1783:  6e 98 0b
b00_9786:   .db $d3                     ; 1786:  d3
b00_9787:   .db $b3                     ; 1787:  b3
b00_9788:   sbc #$b0                    ; 1788:  e9 b0
b00_978a:   stx $02,y                   ; 178A:  96 02
b00_978c:   .db $d7                     ; 178C:  d7
b00_978d:   sei                         ; 178D:  78
b00_978e:   tya                         ; 178E:  98
b00_978f:   .db $0b                     ; 178F:  0b
b00_9790:   .db $d3                     ; 1790:  d3
b00_9791:   tay                         ; 1791:  a8
b00_9792:   .db $5f                     ; 1792:  5f
b00_9793:   .db $6f                     ; 1793:  6f
b00_9794:   sta $e91e                   ; 1794:  8d 1e e9
b00_9797:   .db $03                     ; 1797:  03
b00_9798:   dex                         ; 1798:  ca
b00_9799:   .db $02                     ; 1799:  02
b00_979a:   ldy $8c1e                   ; 179A:  ac 1e 8c
b00_979d:   cld                         ; 179D:  d8
b00_979e:   .db $af                     ; 179E:  af
b00_979f:   .db $97                     ; 179F:  97
b00_97a0:   .db $07                     ; 17A0:  07
b00_97a1:   bne $97ca                   ; 17A1:  d0 27
b00_97a3:   cmp ($b3),y                 ; 17A3:  d1 b3
b00_97a5:   .db $0b                     ; 17A5:  0b
b00_97a6:   .db $d3                     ; 17A6:  d3
b00_97a7:   .db $b3                     ; 17A7:  b3
b00_97a8:   sbc #$14                    ; 17A8:  e9 14
b00_97aa:   stx $04,y                   ; 17AA:  96 04
b00_97ac:   dec $6c,x                   ; 17AC:  d6 6c
b00_97ae:   tya                         ; 17AE:  98
b00_97af:   .db $0b                     ; 17AF:  0b
b00_97b0:   .db $d3                     ; 17B0:  d3
b00_97b1:   .db $b3                     ; 17B1:  b3
b00_97b2:   sbc #$95                    ; 17B2:  e9 95
b00_97b4:   sta $02,x                   ; 17B4:  95 02
b00_97b6:   cld                         ; 17B6:  d8
b00_97b7:   ora $8e98,y                 ; 17B7:  19 98 8e
b00_97ba:   sbc ($bc),y                 ; 17BA:  f1 bc
b00_97bc:   sbc #$26                    ; 17BC:  e9 26
b00_97be:   .db $d3                     ; 17BE:  d3
b00_97bf:   .db $02                     ; 17BF:  02
b00_97c0:   ldy $d766                   ; 17C0:  ac 66 d7
b00_97c3:   .db $0b                     ; 17C3:  0b
b00_97c4:   .db $d3                     ; 17C4:  d3
b00_97c5:   sty $6e15                   ; 17C5:  8c 15 6e
b00_97c8:   .db $bb                     ; 17C8:  bb
b00_97c9:   rol a                       ; 17C9:  2a
b00_97ca:   .db $0b                     ; 17CA:  0b
b00_97cb:   .db $d3                     ; 17CB:  d3
b00_97cc:   sty $6da2                   ; 17CC:  8c a2 6d
b00_97cf:   .db $bb                     ; 17CF:  bb
b00_97d0:   .db $d3                     ; 17D0:  d3
b00_97d1:   cld                         ; 17D1:  d8
b00_97d2:   .db $fc                     ; 17D2:  fc
b00_97d3:   .db $97                     ; 17D3:  97
b00_97d4:   .db $0b                     ; 17D4:  0b
b00_97d5:   .db $d3                     ; 17D5:  d3
b00_97d6:   .db $b3                     ; 17D6:  b3
b00_97d7:   sbc #$75                    ; 17D7:  e9 75
b00_97d9:   .db $e2                     ; 17D9:  e2
b00_97da:   .db $02                     ; 17DA:  02
b00_97db:   asl a                       ; 17DB:  0a
b00_97dc:   .db $d3                     ; 17DC:  d3
b00_97dd:   .db $b3                     ; 17DD:  b3
b00_97de:   sbc #$0e                    ; 17DE:  e9 0e
b00_97e0:   .db $dc                     ; 17E0:  dc
b00_97e1:   .db $02                     ; 17E1:  02
b00_97e2:   asl a                       ; 17E2:  0a
b00_97e3:   .db $d3                     ; 17E3:  d3
b00_97e4:   .db $b3                     ; 17E4:  b3
b00_97e5:   sbc #$3c                    ; 17E5:  e9 3c
b00_97e7:   .db $dc                     ; 17E7:  dc
b00_97e8:   .db $02                     ; 17E8:  02
b00_97e9:   .db $0b                     ; 17E9:  0b
b00_97ea:   .db $d3                     ; 17EA:  d3
b00_97eb:   sty $6da2                   ; 17EB:  8c a2 6d
b00_97ee:   .db $bb                     ; 17EE:  bb
b00_97ef:   .db $b3                     ; 17EF:  b3
b00_97f0:   rti                         ; 17F0:  40
b00_97f1:   .db $d4                     ; 17F1:  d4
b00_97f2:   .db $0b                     ; 17F2:  0b
b00_97f3:   .db $d3                     ; 17F3:  d3
b00_97f4:   .db $b3                     ; 17F4:  b3
b00_97f5:   sbc #$25                    ; 17F5:  e9 25
b00_97f7:   cpx $02                     ; 17F7:  e4 02
b00_97f9:   dec $06,x                   ; 17F9:  d6 06
b00_97fb:   tya                         ; 17FB:  98
b00_97fc:   .db $0b                     ; 17FC:  0b
b00_97fd:   .db $d3                     ; 17FD:  d3
b00_97fe:   sty $6e7f                   ; 17FE:  8c 7f 6e
b00_9801:   .db $bb                     ; 1801:  bb
b00_9802:   .db $b3                     ; 1802:  b3
b00_9803:   asl a                       ; 1803:  0a
b00_9804:   .db $d3                     ; 1804:  d3
b00_9805:   .db $d4                     ; 1805:  d4
b00_9806:   .db $0b                     ; 1806:  0b
b00_9807:   .db $d3                     ; 1807:  d3
b00_9808:   .db $b3                     ; 1808:  b3
b00_9809:   sbc #$1b                    ; 1809:  e9 1b
b00_980b:   .db $e2                     ; 180B:  e2
b00_980c:   .db $02                     ; 180C:  02
b00_980d:   .db $0b                     ; 180D:  0b
b00_980e:   .db $d3                     ; 180E:  d3
b00_980f:   sty $6cf7                   ; 180F:  8c f7 6c
b00_9812:   .db $bb                     ; 1812:  bb
b00_9813:   .db $b3                     ; 1813:  b3
b00_9814:   rti                         ; 1814:  40
b00_9815:   .db $d4                     ; 1815:  d4
b00_9816:   dec $69,x                   ; 1816:  d6 69
b00_9818:   tya                         ; 1818:  98
b00_9819:   stx $bd06                   ; 1819:  8e 06 bd
b00_981c:   sbc #$26                    ; 181C:  e9 26
b00_981e:   .db $d3                     ; 181E:  d3
b00_981f:   .db $02                     ; 181F:  02
b00_9820:   .db $0b                     ; 1820:  0b
b00_9821:   .db $d3                     ; 1821:  d3
b00_9822:   .db $8b                     ; 1822:  8b
b00_9823:   .db $1a                     ; 1823:  1a
b00_9824:   lda $8c,x                   ; 1824:  b5 8c
b00_9826:   ora ($70,x)                 ; 1826:  01 70
b00_9828:   .db $bb                     ; 1828:  bb
b00_9829:   and $8d                     ; 1829:  25 8d
b00_982b:   asl $52e9,x                 ; 182B:  1e e9 52
b00_982e:   dex                         ; 182E:  ca
b00_982f:   .db $02                     ; 182F:  02
b00_9830:   .db $b3                     ; 1830:  b3
b00_9831:   ror a                       ; 1831:  6a
b00_9832:   sbc #$52                    ; 1832:  e9 52
b00_9834:   dex                         ; 1834:  ca
b00_9835:   .db $02                     ; 1835:  02
b00_9836:   .db $8f                     ; 1836:  8f
b00_9837:   asl $05b3,x                 ; 1837:  1e b3 05
b00_983a:   .db $8f                     ; 183A:  8f
b00_983b:   .db $12                     ; 183B:  12
b00_983c:   bcs $97f1                   ; 183C:  b0 b3
b00_983e:   sbc #$0d                    ; 183E:  e9 0d
b00_9840:   .db $d7                     ; 1840:  d7
b00_9841:   .db $04                     ; 1841:  04
b00_9842:   ldy $bb,x                   ; 1842:  b4 bb
b00_9844:   .db $8f                     ; 1844:  8f
b00_9845:   asl $05b3,x                 ; 1845:  1e b3 05
b00_9848:   .db $8f                     ; 1848:  8f
b00_9849:   .db $12                     ; 1849:  12
b00_984a:   ldy $b3,x                   ; 184A:  b4 b3
b00_984c:   bcs $9809                   ; 184C:  b0 bb
b00_984e:   lda ($8d),y                 ; 184E:  b1 8d
b00_9850:   .db $14                     ; 1850:  14
b00_9851:   sbc #$52                    ; 1851:  e9 52
b00_9853:   dex                         ; 1853:  ca
b00_9854:   .db $02                     ; 1854:  02
b00_9855:   .db $7a                     ; 1855:  7a
b00_9856:   .db $b3                     ; 1856:  b3
b00_9857:   ora $8f                     ; 1857:  05 8f
b00_9859:   bpl $980b                   ; 1859:  10 b0
b00_985b:   .db $b3                     ; 185B:  b3
b00_985c:   sbc #$0d                    ; 185C:  e9 0d
b00_985e:   .db $d7                     ; 185E:  d7
b00_985f:   .db $04                     ; 185F:  04
b00_9860:   .db $b3                     ; 1860:  b3
b00_9861:   ora $8f                     ; 1861:  05 8f
b00_9863:   bpl $9819                   ; 1863:  10 b4
b00_9865:   .db $b3                     ; 1865:  b3
b00_9866:   bcs $9824                   ; 1866:  b0 bc
b00_9868:   lda ($ac),y                 ; 1868:  b1 ac
b00_986a:   ror $d7                     ; 186A:  66 d7
b00_986c:   .db $0b                     ; 186C:  0b
b00_986d:   bne $989a                   ; 186D:  d0 2b
b00_986f:   .db $0b                     ; 186F:  0b
b00_9870:   .db $d3                     ; 1870:  d3
b00_9871:   sty $00ff                   ; 1871:  8c ff 00
b00_9874:   cmp ($d7,x)                 ; 1874:  c1 d7
b00_9876:   sta $97                     ; 1876:  85 97
b00_9878:   .db $cf                     ; 1878:  cf
b00_9879:   jsr $e823                   ; 1879:  20 23 e8
b00_987c:   inc $8aff,x                 ; 187C:  fe ff 8a
b00_987f:   .db $89                     ; 187F:  89
b00_9880:   .db $6f                     ; 1880:  6f
b00_9881:   dec $98,x                   ; 1881:  d6 98
b00_9883:   tya                         ; 1883:  98
b00_9884:   ldy #$0b                    ; 1884:  a0 0b
b00_9886:   brk                         ; 1886:  00
b00_9887:   .db $b3                     ; 1887:  b3
b00_9888:   .db $0b                     ; 1888:  0b
b00_9889:   .db $d3                     ; 1889:  d3
b00_988a:   ldy $c0,x                   ; 188A:  b4 c0
b00_988c:   cld                         ; 188C:  d8
b00_988d:   stx $98,y                   ; 188D:  96 98
b00_988f:   .db $3b                     ; 188F:  3b
b00_9890:   .db $89                     ; 1890:  89
b00_9891:   iny                         ; 1891:  c8
b00_9892:   .db $d4                     ; 1892:  d4
b00_9893:   dec $a2,x                   ; 1893:  d6 a2
b00_9895:   tya                         ; 1895:  98
b00_9896:   .db $0b                     ; 1896:  0b
b00_9897:   bne $98c4                   ; 1897:  d0 2b
b00_9899:   .db $0b                     ; 1899:  0b
b00_989a:   .db $d3                     ; 189A:  d3
b00_989b:   sty $00ff                   ; 189B:  8c ff 00
b00_989e:   cmp ($d7,x)                 ; 189E:  c1 d7
b00_98a0:   sty $98                     ; 18A0:  84 98
b00_98a2:   .db $cf                     ; 18A2:  cf
b00_98a3:   jsr $e823                   ; 18A3:  20 23 e8
b00_98a6:   inc $0fff,x                 ; 18A6:  fe ff 0f
b00_98a9:   sty $6e15                   ; 18A9:  8c 15 6e
b00_98ac:   .db $bb                     ; 18AC:  bb
b00_98ad:   .db $b3                     ; 18AD:  b3
b00_98ae:   .db $0c                     ; 18AE:  0c
b00_98af:   .db $d4                     ; 18AF:  d4
b00_98b0:   .db $0f                     ; 18B0:  0f
b00_98b1:   sty $6da2                   ; 18B1:  8c a2 6d
b00_98b4:   .db $bb                     ; 18B4:  bb
b00_98b5:   .db $b3                     ; 18B5:  b3
b00_98b6:   ora $0fd4                   ; 18B6:  0d d4 0f
b00_98b9:   sty $6cf7                   ; 18B9:  8c f7 6c
b00_98bc:   .db $bb                     ; 18BC:  bb
b00_98bd:   .db $b3                     ; 18BD:  b3
b00_98be:   asl $3fd4                   ; 18BE:  0e d4 3f
b00_98c1:   sbc #$54                    ; 18C1:  e9 54
b00_98c3:   sbc $02                     ; 18C3:  e5 02
b00_98c5:   .db $cf                     ; 18C5:  cf
b00_98c6:   jsr $e823                   ; 18C6:  20 23 e8
b00_98c9:   dec $ff                     ; 18C9:  c6 ff
b00_98cb:   ldy $dad7                   ; 18CB:  ac d7 da
b00_98ce:   stx $6f4f                   ; 18CE:  8e 4f 6f
b00_98d1:   adc ($e9,x)                 ; 18D1:  61 e9
b00_98d3:   .db $3a                     ; 18D3:  3a
b00_98d4:   cmp $de04,x                 ; 18D4:  dd 04 de
b00_98d7:   dex                         ; 18D7:  ca
b00_98d8:   .db $ff                     ; 18D8:  ff
b00_98d9:   rol a                       ; 18D9:  2a
b00_98da:   txa                         ; 18DA:  8a
b00_98db:   .db $4f                     ; 18DB:  4f
b00_98dc:   .db $6f                     ; 18DC:  6f
b00_98dd:   .db $2b                     ; 18DD:  2b
b00_98de:   rti                         ; 18DE:  40
b00_98df:   sta $c8                     ; 18DF:  85 c8
b00_98e1:   dec $06,x                   ; 18E1:  d6 06
b00_98e3:   sta $d30b,y                 ; 18E3:  99 0b d3
b00_98e6:   sty $00ff                   ; 18E6:  8c ff 00
b00_98e9:   cpy #$d7                    ; 18E9:  c0 d7
b00_98eb:   ora $0a99                   ; 18EB:  0d 99 0a
b00_98ee:   bne $991a                   ; 18EE:  d0 2a
b00_98f0:   cmp ($b3),y                 ; 18F0:  d1 b3
b00_98f2:   .db $0b                     ; 18F2:  0b
b00_98f3:   .db $d3                     ; 18F3:  d3
b00_98f4:   .db $d4                     ; 18F4:  d4
b00_98f5:   .db $0b                     ; 18F5:  0b
b00_98f6:   .db $d3                     ; 18F6:  d3
b00_98f7:   .db $b3                     ; 18F7:  b3
b00_98f8:   sbc #$79                    ; 18F8:  e9 79
b00_98fa:   tya                         ; 18FA:  98
b00_98fb:   .db $02                     ; 18FB:  02
b00_98fc:   .db $0b                     ; 18FC:  0b
b00_98fd:   bne $992a                   ; 18FD:  d0 2b
b00_98ff:   cmp ($81),y                 ; 18FF:  d1 81
b00_9901:   iny                         ; 1901:  c8
b00_9902:   bne $9889                   ; 1902:  d0 85
b00_9904:   iny                         ; 1904:  c8
b00_9905:   cmp ($81),y                 ; 1905:  d1 81
b00_9907:   iny                         ; 1907:  c8
b00_9908:   .db $1c                     ; 1908:  1c
b00_9909:   dec $d7                     ; 1909:  c6 d7
b00_990b:   cpx $98                     ; 190B:  e4 98
b00_990d:   sta ($c8,x)                 ; 190D:  81 c8
b00_990f:   .db $1c                     ; 190F:  1c
b00_9910:   dec $d8                     ; 1910:  c6 d8
b00_9912:   .db $4b                     ; 1912:  4b
b00_9913:   sta $830c,y                 ; 1913:  99 0c 83
b00_9916:   iny                         ; 1916:  c8
b00_9917:   ldy $2ad6,x                 ; 1917:  bc d6 2a
b00_991a:   sta $d00a,y                 ; 191A:  99 0a d0
b00_991d:   rol a                       ; 191D:  2a
b00_991e:   cmp ($b3),y                 ; 191E:  d1 b3
b00_9920:   ora $d4d3                   ; 1920:  0d d3 d4
b00_9923:   and $c889,x                 ; 1923:  3d 89 c8
b00_9926:   .db $d4                     ; 1926:  d4
b00_9927:   sta ($c6,x)                 ; 1927:  81 c6
b00_9929:   cmp ($85),y                 ; 1929:  d1 85
b00_992b:   dec $d6                     ; 192B:  c6 d6
b00_992d:   .db $44                     ; 192D:  44
b00_992e:   sta $d30d,y                 ; 192E:  99 0d d3
b00_9931:   sty $00c8                   ; 1931:  8c c8 00
b00_9934:   cmp ($d7,x)                 ; 1934:  c1 d7
b00_9936:   .db $1b                     ; 1936:  1b
b00_9937:   sta $d00d,y                 ; 1937:  99 0d d0
b00_993a:   and $d30d                   ; 193A:  2d 0d d3
b00_993d:   sty $00ff                   ; 193D:  8c ff 00
b00_9940:   cmp ($d7,x)                 ; 1940:  c1 d7
b00_9942:   .db $2f                     ; 1942:  2f
b00_9943:   sta $c681,y                 ; 1943:  99 81 c6
b00_9946:   bvc $9910                   ; 1946:  50 c8
b00_9948:   .db $d7                     ; 1948:  d7
b00_9949:   .db $3b                     ; 1949:  3b
b00_994a:   sta $893a,y                 ; 194A:  99 3a 89
b00_994d:   .db $ff                     ; 194D:  ff
b00_994e:   .db $d4                     ; 194E:  d4
b00_994f:   dec $ffca,x                 ; 194F:  de ca ff
b00_9952:   dec $69,x                   ; 1952:  d6 69
b00_9954:   sta $d30a,y                 ; 1954:  99 0a d3
b00_9957:   .db $b3                     ; 1957:  b3
b00_9958:   asl a                       ; 1958:  0a
b00_9959:   .db $d3                     ; 1959:  d3
b00_995a:   sty $6cf7                   ; 195A:  8c f7 6c
b00_995d:   .db $bb                     ; 195D:  bb
b00_995e:   .db $d3                     ; 195E:  d3
b00_995f:   .db $b3                     ; 195F:  b3
b00_9960:   rts                         ; 1960:  60
b00_9961:   sta $e933                   ; 1961:  8d 33 e9
b00_9964:   .db $a3                     ; 1964:  a3
b00_9965:   tya                         ; 1965:  98
b00_9966:   php                         ; 1966:  08
b00_9967:   asl a                       ; 1967:  0a
b00_9968:   bne $9994                   ; 1968:  d0 2a
b00_996a:   asl a                       ; 196A:  0a
b00_996b:   .db $d3                     ; 196B:  d3
b00_996c:   sty $00ff                   ; 196C:  8c ff 00
b00_996f:   cmp ($d7,x)                 ; 196F:  c1 d7
b00_9971:   eor $99,x                   ; 1971:  55 99
b00_9973:   .db $cf                     ; 1973:  cf
b00_9974:   jsr $e823                   ; 1974:  20 23 e8
b00_9977:   inc $41ff,x                 ; 1977:  fe ff 41
b00_997a:   .db $2b                     ; 197A:  2b
b00_997b:   dec $a6,x                   ; 197B:  d6 a6
b00_997d:   sta $d30d,y                 ; 197D:  99 0d d3
b00_9980:   sty $00ff                   ; 1980:  8c ff 00
b00_9983:   cpy #$d7                    ; 1983:  c0 d7
b00_9985:   tax                         ; 1985:  aa
b00_9986:   sta $d30d,y                 ; 1986:  99 0d d3
b00_9989:   sty $00c8                   ; 1989:  8c c8 00
b00_998c:   cmp ($d8,x)                 ; 198C:  c1 d8
b00_998e:   .db $a3                     ; 198E:  a3
b00_998f:   sta $d30d,y                 ; 198F:  99 0d d3
b00_9992:   .db $b3                     ; 1992:  b3
b00_9993:   rts                         ; 1993:  60
b00_9994:   .db $3b                     ; 1994:  3b
b00_9995:   rol $a3e9,x                 ; 1995:  3e e9 a3
b00_9998:   tya                         ; 1998:  98
b00_9999:   php                         ; 1999:  08
b00_999a:   and $c889,x                 ; 199A:  3d 89 c8
b00_999d:   .db $d4                     ; 199D:  d4
b00_999e:   rti                         ; 199E:  40
b00_999f:   .db $2b                     ; 199F:  2b
b00_99a0:   .db $0c                     ; 19A0:  0c
b00_99a1:   cmp ($2c),y                 ; 19A1:  d1 2c
b00_99a3:   ora $2dd0                   ; 19A3:  0d d0 2d
b00_99a6:   .db $0c                     ; 19A6:  0c
b00_99a7:   .db $d7                     ; 19A7:  d7
b00_99a8:   ror $cf99,x                 ; 19A8:  7e 99 cf
b00_99ab:   jsr $e823                   ; 19AB:  20 23 e8
b00_99ae:   sed                         ; 19AE:  f8
b00_99af:   .db $ff                     ; 19AF:  ff
b00_99b0:   ldy $cd20                   ; 19B0:  ac 20 cd
b00_99b3:   adc ($e9,x)                 ; 19B3:  61 e9
b00_99b5:   and $cc,x                   ; 19B5:  35 cc
b00_99b7:   .db $02                     ; 19B7:  02
b00_99b8:   ldy $57                     ; 19B8:  a4 57
b00_99ba:   .db $6f                     ; 19BA:  6f
b00_99bb:   ldx $5f                     ; 19BB:  a6 5f
b00_99bd:   .db $6f                     ; 19BD:  6f
b00_99be:   cpy #$d8                    ; 19BE:  c0 d8
b00_99c0:   .db $04                     ; 19C0:  04
b00_99c1:   txs                         ; 19C1:  9a
b00_99c2:   ldy $5f                     ; 19C2:  a4 5f
b00_99c4:   .db $6f                     ; 19C4:  6f
b00_99c5:   sty $6cf7                   ; 19C5:  8c f7 6c
b00_99c8:   .db $bb                     ; 19C8:  bb
b00_99c9:   .db $b3                     ; 19C9:  b3
b00_99ca:   eor $d4                     ; 19CA:  45 d4
b00_99cc:   adc $62                     ; 19CC:  65 62
b00_99ce:   sbc #$7b                    ; 19CE:  e9 7b
b00_99d0:   cpy $8e04                   ; 19D0:  cc 04 8e
b00_99d3:   asl $e9bd,x                 ; 19D3:  1e bd e9
b00_99d6:   cpy $ce                     ; 19D6:  c4 ce
b00_99d8:   .db $02                     ; 19D8:  02
b00_99d9:   rti                         ; 19D9:  40
b00_99da:   dec $f8,x                   ; 19DA:  d6 f8
b00_99dc:   sta $e93b,y                 ; 19DC:  99 3b e9
b00_99df:   .db $72                     ; 19DF:  72
b00_99e0:   .db $d7                     ; 19E0:  d7
b00_99e1:   .db $02                     ; 19E1:  02
b00_99e2:   .db $8b                     ; 19E2:  8b
b00_99e3:   .db $32                     ; 19E3:  32
b00_99e4:   cpy #$d8                    ; 19E4:  c0 d8
b00_99e6:   inc $99,x                   ; 19E6:  f6 99
b00_99e8:   .db $0b                     ; 19E8:  0b
b00_99e9:   sty $6e15                   ; 19E9:  8c 15 6e
b00_99ec:   .db $bb                     ; 19EC:  bb
b00_99ed:   .db $b3                     ; 19ED:  b3
b00_99ee:   .db $89                     ; 19EE:  89
b00_99ef:   clc                         ; 19EF:  18
b00_99f0:   .db $d4                     ; 19F0:  d4
b00_99f1:   .db $3b                     ; 19F1:  3b
b00_99f2:   sbc #$54                    ; 19F2:  e9 54
b00_99f4:   sbc $02                     ; 19F4:  e5 02
b00_99f6:   .db $0b                     ; 19F6:  0b
b00_99f7:   bne $9a24                   ; 19F7:  d0 2b
b00_99f9:   .db $0b                     ; 19F9:  0b
b00_99fa:   ldx $9d                     ; 19FA:  a6 9d
b00_99fc:   adc $d7c6                   ; 19FC:  6d c6 d7
b00_99ff:   cmp $d699,x                 ; 19FF:  dd 99 d6
b00_9a02:   .db $9e                     ; 1A02:  9e
b00_9a03:   txs                         ; 1A03:  9a
b00_9a04:   ldy $5f                     ; 1A04:  a4 5f
b00_9a06:   .db $6f                     ; 1A06:  6f
b00_9a07:   sty $6cf7                   ; 1A07:  8c f7 6c
b00_9a0a:   .db $bb                     ; 1A0A:  bb
b00_9a0b:   .db $b3                     ; 1A0B:  b3
b00_9a0c:   eor $d4                     ; 1A0C:  45 d4
b00_9a0e:   .db $89                     ; 1A0E:  89
b00_9a0f:   asl $5fa8,x                 ; 1A0F:  1e a8 5f
b00_9a12:   .db $6f                     ; 1A12:  6f
b00_9a13:   adc ($e9,x)                 ; 1A13:  61 e9
b00_9a15:   bpl $99fc                   ; 1A15:  10 e5
b00_9a17:   .db $02                     ; 1A17:  02
b00_9a18:   bne $9a44                   ; 1A18:  d0 2a
b00_9a1a:   asl a                       ; 1A1A:  0a
b00_9a1b:   .db $53                     ; 1A1B:  53
b00_9a1c:   clv                         ; 1A1C:  b8
b00_9a1d:   .db $2b                     ; 1A1D:  2b
b00_9a1e:   stx $6f89                   ; 1A1E:  8e 89 6f
b00_9a21:   .db $0b                     ; 1A21:  0b
b00_9a22:   cmp ($b3),y                 ; 1A22:  d1 b3
b00_9a24:   sbc #$c6                    ; 1A24:  e9 c6
b00_9a26:   tya                         ; 1A26:  98
b00_9a27:   .db $04                     ; 1A27:  04
b00_9a28:   sta $8e34                   ; 1A28:  8d 34 8e
b00_9a2b:   .db $89                     ; 1A2B:  89
b00_9a2c:   .db $6f                     ; 1A2C:  6f
b00_9a2d:   .db $3b                     ; 1A2D:  3b
b00_9a2e:   sbc #$74                    ; 1A2E:  e9 74
b00_9a30:   sta $8d06,y                 ; 1A30:  99 06 8d
b00_9a33:   .db $32                     ; 1A33:  32
b00_9a34:   stx $6f89                   ; 1A34:  8e 89 6f
b00_9a37:   .db $0b                     ; 1A37:  0b
b00_9a38:   .db $d2                     ; 1A38:  d2
b00_9a39:   .db $b3                     ; 1A39:  b3
b00_9a3a:   asl a                       ; 1A3A:  0a
b00_9a3b:   ldy $bc,x                   ; 1A3B:  b4 bc
b00_9a3d:   .db $b3                     ; 1A3D:  b3
b00_9a3e:   sbc #$74                    ; 1A3E:  e9 74
b00_9a40:   sta $8906,y                 ; 1A40:  99 06 89
b00_9a43:   .db $33                     ; 1A43:  33
b00_9a44:   lda #$33                    ; 1A44:  a9 33
b00_9a46:   ror $a941                   ; 1A46:  6e 41 a9
b00_9a49:   cpy #$6d                    ; 1A49:  c0 6d
b00_9a4b:   eor $a9                     ; 1A4B:  45 a9
b00_9a4d:   ora $6d,x                   ; 1A4D:  15 6d
b00_9a4f:   sta $e91e                   ; 1A4F:  8d 1e e9
b00_9a52:   .db $54                     ; 1A52:  54
b00_9a53:   sbc $02                     ; 1A53:  e5 02
b00_9a55:   rti                         ; 1A55:  40
b00_9a56:   plp                         ; 1A56:  28
b00_9a57:   php                         ; 1A57:  08
b00_9a58:   sty $7fd5                   ; 1A58:  8c d5 7f
b00_9a5b:   .db $bb                     ; 1A5B:  bb
b00_9a5c:   .db $d3                     ; 1A5C:  d3
b00_9a5d:   .db $8b                     ; 1A5D:  8b
b00_9a5e:   clc                         ; 1A5E:  18
b00_9a5f:   cpy #$d8                    ; 1A5F:  c0 d8
b00_9a61:   jmp ($089a)                 ; 1A61:  6c 9a 08
b00_9a64:   sty $7fd5                   ; 1A64:  8c d5 7f
b00_9a67:   .db $bb                     ; 1A67:  bb
b00_9a68:   .db $b3                     ; 1A68:  b3
b00_9a69:   .db $89                     ; 1A69:  89
b00_9a6a:   .db $33                     ; 1A6A:  33
b00_9a6b:   .db $d4                     ; 1A6B:  d4
b00_9a6c:   php                         ; 1A6C:  08
b00_9a6d:   bne $9a97                   ; 1A6D:  d0 28
b00_9a6f:   php                         ; 1A6F:  08
b00_9a70:   cli                         ; 1A70:  58
b00_9a71:   dec $d7                     ; 1A71:  c6 d7
b00_9a73:   .db $57                     ; 1A73:  57
b00_9a74:   txs                         ; 1A74:  9a
b00_9a75:   adc $62                     ; 1A75:  65 62
b00_9a77:   sbc #$7b                    ; 1A77:  e9 7b
b00_9a79:   cpy $8e04                   ; 1A79:  cc 04 8e
b00_9a7c:   lsr $bd,x                   ; 1A7C:  56 bd
b00_9a7e:   sbc #$c4                    ; 1A7E:  e9 c4
b00_9a80:   dec $8e02                   ; 1A80:  ce 02 8e
b00_9a83:   rts                         ; 1A83:  60
b00_9a84:   lda $c4e9,x                 ; 1A84:  bd e9 c4
b00_9a87:   dec $8e02                   ; 1A87:  ce 02 8e
b00_9a8a:   dey                         ; 1A8A:  88
b00_9a8b:   lda $c4e9,x                 ; 1A8B:  bd e9 c4
b00_9a8e:   dec $8e02                   ; 1A8E:  ce 02 8e
b00_9a91:   .db $9c                     ; 1A91:  9c
b00_9a92:   lda $c4e9,x                 ; 1A92:  bd e9 c4
b00_9a95:   dec $8e02                   ; 1A95:  ce 02 8e
b00_9a98:   cld                         ; 1A98:  d8
b00_9a99:   lda $c4e9,x                 ; 1A99:  bd e9 c4
b00_9a9c:   dec $6002                   ; 1A9C:  ce 02 60
b00_9a9f:   sbc #$35                    ; 1A9F:  e9 35
b00_9aa1:   cpy $ac02                   ; 1AA1:  cc 02 ac
b00_9aa4:   ora #$d6                    ; 1AA4:  09 d6
b00_9aa6:   ror $e9                     ; 1AA6:  66 e9
b00_9aa8:   .db $f2                     ; 1AA8:  f2
b00_9aa9:   sbc $02                     ; 1AA9:  e5 02
b00_9aab:   .db $cf                     ; 1AAB:  cf
b00_9aac:   jsr $e823                   ; 1AAC:  20 23 e8
b00_9aaf:   inc $acff,x                 ; 1AAF:  fe ff ac
b00_9ab2:   ldy $e3                     ; 1AB2:  a4 e3
b00_9ab4:   .db $2b                     ; 1AB4:  2b
b00_9ab5:   cld                         ; 1AB5:  d8
b00_9ab6:   ora ($9b),y                 ; 1AB6:  11 9b
b00_9ab8:   ldy $cc89                   ; 1AB8:  ac 89 cc
b00_9abb:   tax                         ; 1ABB:  aa
b00_9abc:   .db $5f                     ; 1ABC:  5f
b00_9abd:   .db $6f                     ; 1ABD:  6f
b00_9abe:   sbc #$8b                    ; 1ABE:  e9 8b
b00_9ac0:   .db $d7                     ; 1AC0:  d7
b00_9ac1:   .db $02                     ; 1AC1:  02
b00_9ac2:   .db $3b                     ; 1AC2:  3b
b00_9ac3:   ldy $63                     ; 1AC3:  a4 63
b00_9ac5:   .db $6f                     ; 1AC5:  6f
b00_9ac6:   bne $9a7b                   ; 1AC6:  d0 b3
b00_9ac8:   stx $bdfe                   ; 1AC8:  8e fe bd
b00_9acb:   sbc #$34                    ; 1ACB:  e9 34
b00_9acd:   cmp ($06),y                 ; 1ACD:  d1 06
b00_9acf:   ldy $d3a7                   ; 1ACF:  ac a7 d3
b00_9ad2:   cld                         ; 1AD2:  d8
b00_9ad3:   .db $07                     ; 1AD3:  07
b00_9ad4:   .db $9b                     ; 1AD4:  9b
b00_9ad5:   .db $67                     ; 1AD5:  67
b00_9ad6:   sbc #$0c                    ; 1AD6:  e9 0c
b00_9ad8:   inx                         ; 1AD8:  e8
b00_9ad9:   .db $02                     ; 1AD9:  02
b00_9ada:   .db $3b                     ; 1ADA:  3b
b00_9adb:   ldy $5f                     ; 1ADB:  a4 5f
b00_9add:   .db $6f                     ; 1ADD:  6f
b00_9ade:   .db $8b                     ; 1ADE:  8b
b00_9adf:   .db $1a                     ; 1ADF:  1a
b00_9ae0:   lda $8c,x                   ; 1AE0:  b5 8c
b00_9ae2:   ora ($70,x)                 ; 1AE2:  01 70
b00_9ae4:   .db $bb                     ; 1AE4:  bb
b00_9ae5:   ldy $b3,x                   ; 1AE5:  b4 b3
b00_9ae7:   bcs $9aa4                   ; 1AE7:  b0 bb
b00_9ae9:   lda ($8e),y                 ; 1AE9:  b1 8e
b00_9aeb:   and ($be),y                 ; 1AEB:  31 be
b00_9aed:   sbc #$26                    ; 1AED:  e9 26
b00_9aef:   .db $d3                     ; 1AEF:  d3
b00_9af0:   .db $02                     ; 1AF0:  02
b00_9af1:   ldy $da4f                   ; 1AF1:  ac 4f da
b00_9af4:   .db $3b                     ; 1AF4:  3b
b00_9af5:   ldy $63                     ; 1AF5:  a4 63
b00_9af7:   .db $6f                     ; 1AF7:  6f
b00_9af8:   .db $8b                     ; 1AF8:  8b
b00_9af9:   .db $1a                     ; 1AF9:  1a
b00_9afa:   lda $8c,x                   ; 1AFA:  b5 8c
b00_9afc:   ora ($70,x)                 ; 1AFC:  01 70
b00_9afe:   .db $bb                     ; 1AFE:  bb
b00_9aff:   ldy $b3,x                   ; 1AFF:  b4 b3
b00_9b01:   bcs $9abf                   ; 1B01:  b0 bc
b00_9b03:   lda ($d6),y                 ; 1B03:  b1 d6
b00_9b05:   asl $8e9b                   ; 1B05:  0e 9b 8e
b00_9b08:   .db $57                     ; 1B08:  57
b00_9b09:   ldx $26e9,y                 ; 1B09:  be e9 26
b00_9b0c:   .db $d3                     ; 1B0C:  d3
b00_9b0d:   .db $02                     ; 1B0D:  02
b00_9b0e:   ldy $d766                   ; 1B0E:  ac 66 d7
b00_9b11:   .db $cf                     ; 1B11:  cf
b00_9b12:   jsr $e823                   ; 1B12:  20 23 e8
b00_9b15:   inc $40ff,x                 ; 1B15:  fe ff 40
b00_9b18:   dec $71,x                   ; 1B18:  d6 71
b00_9b1a:   .db $9b                     ; 1B1A:  9b
b00_9b1b:   ldy $5f                     ; 1B1B:  a4 5f
b00_9b1d:   .db $6f                     ; 1B1D:  6f
b00_9b1e:   sty $6da2                   ; 1B1E:  8c a2 6d
b00_9b21:   .db $bb                     ; 1B21:  bb
b00_9b22:   .db $d3                     ; 1B22:  d3
b00_9b23:   cld                         ; 1B23:  d8
b00_9b24:   adc $aa9b                   ; 1B24:  6d 9b aa
b00_9b27:   .db $5f                     ; 1B27:  5f
b00_9b28:   .db $6f                     ; 1B28:  6f
b00_9b29:   sbc #$8d                    ; 1B29:  e9 8d
b00_9b2b:   cmp $d702,y                 ; 1B2B:  d9 02 d7
b00_9b2e:   adc $ac9b                   ; 1B2E:  6d 9b ac
b00_9b31:   .db $d7                     ; 1B31:  d7
b00_9b32:   .db $da                     ; 1B32:  da
b00_9b33:   txa                         ; 1B33:  8a
b00_9b34:   .db $4f                     ; 1B34:  4f
b00_9b35:   .db $6f                     ; 1B35:  6f
b00_9b36:   dec $63,x                   ; 1B36:  d6 63
b00_9b38:   .db $9b                     ; 1B38:  9b
b00_9b39:   ldy $5f                     ; 1B39:  a4 5f
b00_9b3b:   .db $6f                     ; 1B3B:  6f
b00_9b3c:   tay                         ; 1B3C:  a8
b00_9b3d:   .db $63                     ; 1B3D:  63
b00_9b3e:   .db $6f                     ; 1B3E:  6f
b00_9b3f:   .db $0b                     ; 1B3F:  0b
b00_9b40:   .db $d3                     ; 1B40:  d3
b00_9b41:   tay                         ; 1B41:  a8
b00_9b42:   .db $5f                     ; 1B42:  5f
b00_9b43:   .db $6f                     ; 1B43:  6f
b00_9b44:   ldy $8c1e                   ; 1B44:  ac 1e 8c
b00_9b47:   cld                         ; 1B47:  d8
b00_9b48:   .db $5b                     ; 1B48:  5b
b00_9b49:   .db $9b                     ; 1B49:  9b
b00_9b4a:   ldy $d77e                   ; 1B4A:  ac 7e d7
b00_9b4d:   sty $6d67                   ; 1B4D:  8c 67 6d
b00_9b50:   .db $bb                     ; 1B50:  bb
b00_9b51:   .db $d3                     ; 1B51:  d3
b00_9b52:   .db $d7                     ; 1B52:  d7
b00_9b53:   .db $5b                     ; 1B53:  5b
b00_9b54:   .db $9b                     ; 1B54:  9b
b00_9b55:   ldy $9aac                   ; 1B55:  ac ac 9a
b00_9b58:   dec $7e,x                   ; 1B58:  d6 7e
b00_9b5a:   .db $9b                     ; 1B5A:  9b
b00_9b5b:   ldy $63                     ; 1B5B:  a4 63
b00_9b5d:   .db $6f                     ; 1B5D:  6f
b00_9b5e:   tay                         ; 1B5E:  a8
b00_9b5f:   .db $5f                     ; 1B5F:  5f
b00_9b60:   .db $6f                     ; 1B60:  6f
b00_9b61:   .db $0b                     ; 1B61:  0b
b00_9b62:   bne $9b8f                   ; 1B62:  d0 2b
b00_9b64:   .db $0b                     ; 1B64:  0b
b00_9b65:   .db $d3                     ; 1B65:  d3
b00_9b66:   sty $00ff                   ; 1B66:  8c ff 00
b00_9b69:   cmp ($d7,x)                 ; 1B69:  c1 d7
b00_9b6b:   and $a49b,y                 ; 1B6B:  39 9b a4
b00_9b6e:   .db $5f                     ; 1B6E:  5f
b00_9b6f:   .db $6f                     ; 1B6F:  6f
b00_9b70:   bne $9b1a                   ; 1B70:  d0 a8
b00_9b72:   .db $5f                     ; 1B72:  5f
b00_9b73:   .db $6f                     ; 1B73:  6f
b00_9b74:   ldy $5f                     ; 1B74:  a4 5f
b00_9b76:   .db $6f                     ; 1B76:  6f
b00_9b77:   ldx $9d                     ; 1B77:  a6 9d
b00_9b79:   adc $d7c6                   ; 1B79:  6d c6 d7
b00_9b7c:   .db $1b                     ; 1B7C:  1b
b00_9b7d:   .db $9b                     ; 1B7D:  9b
b00_9b7e:   .db $cf                     ; 1B7E:  cf
b00_9b7f:   jsr $e823                   ; 1B7F:  20 23 e8
b00_9b82:   inc $acff,x                 ; 1B82:  fe ff ac
b00_9b85:   ora $e3,x                   ; 1B85:  15 e3
b00_9b87:   .db $2b                     ; 1B87:  2b
b00_9b88:   cld                         ; 1B88:  d8
b00_9b89:   cpx $9b                     ; 1B89:  e4 9b
b00_9b8b:   ldy $cc89                   ; 1B8B:  ac 89 cc
b00_9b8e:   tax                         ; 1B8E:  aa
b00_9b8f:   .db $5f                     ; 1B8F:  5f
b00_9b90:   .db $6f                     ; 1B90:  6f
b00_9b91:   sbc #$8b                    ; 1B91:  e9 8b
b00_9b93:   .db $d7                     ; 1B93:  d7
b00_9b94:   .db $02                     ; 1B94:  02
b00_9b95:   ldy $63                     ; 1B95:  a4 63
b00_9b97:   .db $6f                     ; 1B97:  6f
b00_9b98:   bne $9b4d                   ; 1B98:  d0 b3
b00_9b9a:   .db $3b                     ; 1B9A:  3b
b00_9b9b:   stx $be78                   ; 1B9B:  8e 78 be
b00_9b9e:   sbc #$34                    ; 1B9E:  e9 34
b00_9ba0:   cmp ($06),y                 ; 1BA0:  d1 06
b00_9ba2:   ldy $d3a7                   ; 1BA2:  ac a7 d3
b00_9ba5:   cld                         ; 1BA5:  d8
b00_9ba6:   .db $da                     ; 1BA6:  da
b00_9ba7:   .db $9b                     ; 1BA7:  9b
b00_9ba8:   .db $64                     ; 1BA8:  64
b00_9ba9:   sbc #$0c                    ; 1BA9:  e9 0c
b00_9bab:   inx                         ; 1BAB:  e8
b00_9bac:   .db $02                     ; 1BAC:  02
b00_9bad:   .db $3b                     ; 1BAD:  3b
b00_9bae:   ldy $5f                     ; 1BAE:  a4 5f
b00_9bb0:   .db $6f                     ; 1BB0:  6f
b00_9bb1:   .db $8b                     ; 1BB1:  8b
b00_9bb2:   .db $1a                     ; 1BB2:  1a
b00_9bb3:   lda $8c,x                   ; 1BB3:  b5 8c
b00_9bb5:   ora ($70,x)                 ; 1BB5:  01 70
b00_9bb7:   .db $bb                     ; 1BB7:  bb
b00_9bb8:   ldy $b3,x                   ; 1BB8:  b4 b3
b00_9bba:   bcs $9b77                   ; 1BBA:  b0 bb
b00_9bbc:   lda ($8e),y                 ; 1BBC:  b1 8e
b00_9bbe:   tsx                         ; 1BBE:  ba
b00_9bbf:   ldx $26e9,y                 ; 1BBF:  be e9 26
b00_9bc2:   .db $d3                     ; 1BC2:  d3
b00_9bc3:   .db $02                     ; 1BC3:  02
b00_9bc4:   ldy $da7d                   ; 1BC4:  ac 7d da
b00_9bc7:   .db $3b                     ; 1BC7:  3b
b00_9bc8:   ldy $63                     ; 1BC8:  a4 63
b00_9bca:   .db $6f                     ; 1BCA:  6f
b00_9bcb:   .db $8b                     ; 1BCB:  8b
b00_9bcc:   .db $1a                     ; 1BCC:  1a
b00_9bcd:   lda $8c,x                   ; 1BCD:  b5 8c
b00_9bcf:   ora ($70,x)                 ; 1BCF:  01 70
b00_9bd1:   .db $bb                     ; 1BD1:  bb
b00_9bd2:   ldy $b3,x                   ; 1BD2:  b4 b3
b00_9bd4:   bcs $9b92                   ; 1BD4:  b0 bc
b00_9bd6:   lda ($d6),y                 ; 1BD6:  b1 d6
b00_9bd8:   sbc ($9b,x)                 ; 1BD8:  e1 9b
b00_9bda:   stx $bee9                   ; 1BDA:  8e e9 be
b00_9bdd:   sbc #$26                    ; 1BDD:  e9 26
b00_9bdf:   .db $d3                     ; 1BDF:  d3
b00_9be0:   .db $02                     ; 1BE0:  02
b00_9be1:   ldy $d766                   ; 1BE1:  ac 66 d7
b00_9be4:   .db $cf                     ; 1BE4:  cf
b00_9be5:   jsr $e823                   ; 1BE5:  20 23 e8
b00_9be8:   .db $fc                     ; 1BE8:  fc
b00_9be9:   .db $ff                     ; 1BE9:  ff
b00_9bea:   rti                         ; 1BEA:  40
b00_9beb:   dec $18,x                   ; 1BEB:  d6 18
b00_9bed:   .db $9c                     ; 1BED:  9c
b00_9bee:   tax                         ; 1BEE:  aa
b00_9bef:   sta $e96d,x                 ; 1BEF:  9d 6d e9
b00_9bf2:   .db $52                     ; 1BF2:  52
b00_9bf3:   dex                         ; 1BF3:  ca
b00_9bf4:   .db $02                     ; 1BF4:  02
b00_9bf5:   rol a                       ; 1BF5:  2a
b00_9bf6:   .db $3a                     ; 1BF6:  3a
b00_9bf7:   sbc #$8d                    ; 1BF7:  e9 8d
b00_9bf9:   cmp $d702,y                 ; 1BF9:  d9 02 d7
b00_9bfc:   asl $9c,x                   ; 1BFC:  16 9c
b00_9bfe:   ldy $8c45                   ; 1BFE:  ac 45 8c
b00_9c01:   ldy $d77e                   ; 1C01:  ac 7e d7
b00_9c04:   sty $6d67                   ; 1C04:  8c 67 6d
b00_9c07:   .db $bb                     ; 1C07:  bb
b00_9c08:   .db $d3                     ; 1C08:  d3
b00_9c09:   .db $d7                     ; 1C09:  d7
b00_9c0a:   asl $9c,x                   ; 1C0A:  16 9c
b00_9c0c:   asl a                       ; 1C0C:  0a
b00_9c0d:   tay                         ; 1C0D:  a8
b00_9c0e:   .db $63                     ; 1C0E:  63
b00_9c0f:   .db $6f                     ; 1C0F:  6f
b00_9c10:   ldy $9b7f                   ; 1C10:  ac 7f 9b
b00_9c13:   dec $21,x                   ; 1C13:  d6 21
b00_9c15:   .db $9c                     ; 1C15:  9c
b00_9c16:   .db $0b                     ; 1C16:  0b
b00_9c17:   bne $9c44                   ; 1C17:  d0 2b
b00_9c19:   .db $0b                     ; 1C19:  0b
b00_9c1a:   ldx $9d                     ; 1C1A:  a6 9d
b00_9c1c:   adc $d7c6                   ; 1C1C:  6d c6 d7
b00_9c1f:   inc $cf9b                   ; 1C1F:  ee 9b cf
b00_9c22:   jsr $e823                   ; 1C22:  20 23 e8
b00_9c25:   .db $fc                     ; 1C25:  fc
b00_9c26:   .db $ff                     ; 1C26:  ff
b00_9c27:   rti                         ; 1C27:  40
b00_9c28:   rol a                       ; 1C28:  2a
b00_9c29:   .db $62                     ; 1C29:  62
b00_9c2a:   sbc #$52                    ; 1C2A:  e9 52
b00_9c2c:   dex                         ; 1C2C:  ca
b00_9c2d:   .db $02                     ; 1C2D:  02
b00_9c2e:   cld                         ; 1C2E:  d8
b00_9c2f:   .db $83                     ; 1C2F:  83
b00_9c30:   .db $9c                     ; 1C30:  9c
b00_9c31:   rti                         ; 1C31:  40
b00_9c32:   dec $7a,x                   ; 1C32:  d6 7a
b00_9c34:   .db $9c                     ; 1C34:  9c
b00_9c35:   sta $e914                   ; 1C35:  8d 14 e9
b00_9c38:   .db $52                     ; 1C38:  52
b00_9c39:   dex                         ; 1C39:  ca
b00_9c3a:   .db $02                     ; 1C3A:  02
b00_9c3b:   .db $53                     ; 1C3B:  53
b00_9c3c:   .db $c2                     ; 1C3C:  c2
b00_9c3d:   cld                         ; 1C3D:  d8
b00_9c3e:   sei                         ; 1C3E:  78
b00_9c3f:   .db $9c                     ; 1C3F:  9c
b00_9c40:   .db $3b                     ; 1C40:  3b
b00_9c41:   sbc #$8d                    ; 1C41:  e9 8d
b00_9c43:   cmp $d702,y                 ; 1C43:  d9 02 d7
b00_9c46:   sei                         ; 1C46:  78
b00_9c47:   .db $9c                     ; 1C47:  9c
b00_9c48:   pha                         ; 1C48:  48
b00_9c49:   ldx $09                     ; 1C49:  a6 09
b00_9c4b:   ror $b3bc                   ; 1C4B:  6e bc b3
b00_9c4e:   asl a                       ; 1C4E:  0a
b00_9c4f:   bne $9c7b                   ; 1C4F:  d0 2a
b00_9c51:   cmp ($b4),y                 ; 1C51:  d1 b4
b00_9c53:   dec $d8                     ; 1C53:  c6 d8
b00_9c55:   sei                         ; 1C55:  78
b00_9c56:   .db $9c                     ; 1C56:  9c
b00_9c57:   ldy $8c45                   ; 1C57:  ac 45 8c
b00_9c5a:   .db $0b                     ; 1C5A:  0b
b00_9c5b:   tay                         ; 1C5B:  a8
b00_9c5c:   .db $63                     ; 1C5C:  63
b00_9c5d:   .db $6f                     ; 1C5D:  6f
b00_9c5e:   stx $6f5f                   ; 1C5E:  8e 5f 6f
b00_9c61:   stx $6f63                   ; 1C61:  8e 63 6f
b00_9c64:   sbc #$94                    ; 1C64:  e9 94
b00_9c66:   .db $cb                     ; 1C66:  cb
b00_9c67:   .db $04                     ; 1C67:  04
b00_9c68:   ldy $93bf                   ; 1C68:  ac bf 93
b00_9c6b:   stx $6f5f                   ; 1C6B:  8e 5f 6f
b00_9c6e:   stx $6f63                   ; 1C6E:  8e 63 6f
b00_9c71:   sbc #$94                    ; 1C71:  e9 94
b00_9c73:   .db $cb                     ; 1C73:  cb
b00_9c74:   .db $04                     ; 1C74:  04
b00_9c75:   dec $83,x                   ; 1C75:  d6 83
b00_9c77:   .db $9c                     ; 1C77:  9c
b00_9c78:   .db $0b                     ; 1C78:  0b
b00_9c79:   bne $9ca6                   ; 1C79:  d0 2b
b00_9c7b:   .db $0b                     ; 1C7B:  0b
b00_9c7c:   ldx $9d                     ; 1C7C:  a6 9d
b00_9c7e:   adc $d7c6                   ; 1C7E:  6d c6 d7
b00_9c81:   and $9c,x                   ; 1C81:  35 9c
b00_9c83:   .db $cf                     ; 1C83:  cf
b00_9c84:   jsr $e823                   ; 1C84:  20 23 e8
b00_9c87:   brk                         ; 1C87:  00
b00_9c88:   brk                         ; 1C88:  00
b00_9c89:   .db $62                     ; 1C89:  62
b00_9c8a:   sbc #$52                    ; 1C8A:  e9 52
b00_9c8c:   dex                         ; 1C8C:  ca
b00_9c8d:   .db $02                     ; 1C8D:  02
b00_9c8e:   cld                         ; 1C8E:  d8
b00_9c8f:   ldx $9c                     ; 1C8F:  a6 9c
b00_9c91:   .db $64                     ; 1C91:  64
b00_9c92:   sbc #$52                    ; 1C92:  e9 52
b00_9c94:   dex                         ; 1C94:  ca
b00_9c95:   .db $02                     ; 1C95:  02
b00_9c96:   cmp $0002,y                 ; 1C96:  d9 02 00
b00_9c99:   brk                         ; 1C99:  00
b00_9c9a:   brk                         ; 1C9A:  00
b00_9c9b:   .db $a3                     ; 1C9B:  a3
b00_9c9c:   .db $9c                     ; 1C9C:  9c
b00_9c9d:   ora ($00,x)                 ; 1C9D:  01 00
b00_9c9f:   .db $a7                     ; 1C9F:  a7
b00_9ca0:   .db $9c                     ; 1CA0:  9c
b00_9ca1:   lda $ac9c                   ; 1CA1:  ad 9c ac
b00_9ca4:   sbc $9b                     ; 1CA4:  e5 9b
b00_9ca6:   .db $cf                     ; 1CA6:  cf
b00_9ca7:   ldy $9b12                   ; 1CA7:  ac 12 9b
b00_9caa:   dec $a6,x                   ; 1CAA:  d6 a6
b00_9cac:   .db $9c                     ; 1CAC:  9c
b00_9cad:   ldy $9c22                   ; 1CAD:  ac 22 9c
b00_9cb0:   dec $a6,x                   ; 1CB0:  d6 a6
b00_9cb2:   .db $9c                     ; 1CB2:  9c
b00_9cb3:   jsr $e823                   ; 1CB3:  20 23 e8
b00_9cb6:   .db $fc                     ; 1CB6:  fc
b00_9cb7:   .db $ff                     ; 1CB7:  ff
b00_9cb8:   sta $e914                   ; 1CB8:  8d 14 e9
b00_9cbb:   .db $0c                     ; 1CBB:  0c
b00_9cbc:   inx                         ; 1CBC:  e8
b00_9cbd:   .db $02                     ; 1CBD:  02
b00_9cbe:   txa                         ; 1CBE:  8a
b00_9cbf:   lda $d67b                   ; 1CBF:  ad 7b d6
b00_9cc2:   sbc $9c,x                   ; 1CC2:  f5 9c
b00_9cc4:   .db $0b                     ; 1CC4:  0b
b00_9cc5:   .db $d3                     ; 1CC5:  d3
b00_9cc6:   .db $8b                     ; 1CC6:  8b
b00_9cc7:   .db $1a                     ; 1CC7:  1a
b00_9cc8:   lda $8c,x                   ; 1CC8:  b5 8c
b00_9cca:   ora ($70,x)                 ; 1CCA:  01 70
b00_9ccc:   .db $bb                     ; 1CCC:  bb
b00_9ccd:   rol a                       ; 1CCD:  2a
b00_9cce:   .db $64                     ; 1CCE:  64
b00_9ccf:   sbc #$52                    ; 1CCF:  e9 52
b00_9cd1:   dex                         ; 1CD1:  ca
b00_9cd2:   .db $02                     ; 1CD2:  02
b00_9cd3:   bne $9c88                   ; 1CD3:  d0 b3
b00_9cd5:   asl a                       ; 1CD5:  0a
b00_9cd6:   ror $b3b4,x                 ; 1CD6:  7e b4 b3
b00_9cd9:   bcs $9c97                   ; 1CD9:  b0 bc
b00_9cdb:   lda ($0a),y                 ; 1CDB:  b1 0a
b00_9cdd:   sei                         ; 1CDD:  78
b00_9cde:   .db $b3                     ; 1CDE:  b3
b00_9cdf:   sta $0a5a                   ; 1CDF:  8d 5a 0a
b00_9ce2:   .db $7a                     ; 1CE2:  7a
b00_9ce3:   bcs $9c98                   ; 1CE3:  b0 b3
b00_9ce5:   sbc #$0d                    ; 1CE5:  e9 0d
b00_9ce7:   .db $d7                     ; 1CE7:  d7
b00_9ce8:   .db $04                     ; 1CE8:  04
b00_9ce9:   .db $b3                     ; 1CE9:  b3
b00_9cea:   asl a                       ; 1CEA:  0a
b00_9ceb:   sei                         ; 1CEB:  78
b00_9cec:   bcs $9ca1                   ; 1CEC:  b0 b3
b00_9cee:   sbc #$0d                    ; 1CEE:  e9 0d
b00_9cf0:   .db $d7                     ; 1CF0:  d7
b00_9cf1:   .db $04                     ; 1CF1:  04
b00_9cf2:   lda ($0b),y                 ; 1CF2:  b1 0b
b00_9cf4:   bne $9d21                   ; 1CF4:  d0 2b
b00_9cf6:   .db $0b                     ; 1CF6:  0b
b00_9cf7:   .db $d3                     ; 1CF7:  d3
b00_9cf8:   sty $00ff                   ; 1CF8:  8c ff 00
b00_9cfb:   cmp ($d7,x)                 ; 1CFB:  c1 d7
b00_9cfd:   cpy $9c                     ; 1CFD:  c4 9c
b00_9cff:   .db $cf                     ; 1CFF:  cf
b00_9d00:   jsr $e823                   ; 1D00:  20 23 e8
b00_9d03:   .db $fa                     ; 1D03:  fa
b00_9d04:   .db $ff                     ; 1D04:  ff
b00_9d05:   sta $e91f                   ; 1D05:  8d 1f e9
b00_9d08:   .db $0c                     ; 1D08:  0c
b00_9d09:   inx                         ; 1D09:  e8
b00_9d0a:   .db $02                     ; 1D0A:  02
b00_9d0b:   txa                         ; 1D0B:  8a
b00_9d0c:   lda $d67b                   ; 1D0C:  ad 7b d6
b00_9d0f:   .db $7b                     ; 1D0F:  7b
b00_9d10:   sta $d30b,x                 ; 1D10:  9d 0b d3
b00_9d13:   .db $8b                     ; 1D13:  8b
b00_9d14:   .db $1a                     ; 1D14:  1a
b00_9d15:   lda $8c,x                   ; 1D15:  b5 8c
b00_9d17:   ora ($70,x)                 ; 1D17:  01 70
b00_9d19:   .db $bb                     ; 1D19:  bb
b00_9d1a:   rol a                       ; 1D1A:  2a
b00_9d1b:   asl a                       ; 1D1B:  0a
b00_9d1c:   .db $8f                     ; 1D1C:  8f
b00_9d1d:   bpl $9cd2                   ; 1D1D:  10 b3
b00_9d1f:   sta $e932                   ; 1D1F:  8d 32 e9
b00_9d22:   .db $52                     ; 1D22:  52
b00_9d23:   dex                         ; 1D23:  ca
b00_9d24:   .db $02                     ; 1D24:  02
b00_9d25:   .db $8f                     ; 1D25:  8f
b00_9d26:   .db $32                     ; 1D26:  32
b00_9d27:   .db $b3                     ; 1D27:  b3
b00_9d28:   asl a                       ; 1D28:  0a
b00_9d29:   .db $8f                     ; 1D29:  8f
b00_9d2a:   bpl $9cdc                   ; 1D2A:  10 b0
b00_9d2c:   .db $b3                     ; 1D2C:  b3
b00_9d2d:   sbc #$0d                    ; 1D2D:  e9 0d
b00_9d2f:   .db $d7                     ; 1D2F:  d7
b00_9d30:   .db $04                     ; 1D30:  04
b00_9d31:   lda ($0a),y                 ; 1D31:  b1 0a
b00_9d33:   sei                         ; 1D33:  78
b00_9d34:   .db $b3                     ; 1D34:  b3
b00_9d35:   sta $e932                   ; 1D35:  8d 32 e9
b00_9d38:   .db $52                     ; 1D38:  52
b00_9d39:   dex                         ; 1D39:  ca
b00_9d3a:   .db $02                     ; 1D3A:  02
b00_9d3b:   .db $8f                     ; 1D3B:  8f
b00_9d3c:   .db $32                     ; 1D3C:  32
b00_9d3d:   .db $b3                     ; 1D3D:  b3
b00_9d3e:   asl a                       ; 1D3E:  0a
b00_9d3f:   sei                         ; 1D3F:  78
b00_9d40:   bcs $9cf5                   ; 1D40:  b0 b3
b00_9d42:   sbc #$0d                    ; 1D42:  e9 0d
b00_9d44:   .db $d7                     ; 1D44:  d7
b00_9d45:   .db $04                     ; 1D45:  04
b00_9d46:   lda ($0b),y                 ; 1D46:  b1 0b
b00_9d48:   .db $d3                     ; 1D48:  d3
b00_9d49:   sty $6da2                   ; 1D49:  8c a2 6d
b00_9d4c:   .db $bb                     ; 1D4C:  bb
b00_9d4d:   .db $d3                     ; 1D4D:  d3
b00_9d4e:   cld                         ; 1D4E:  d8
b00_9d4f:   adc $699d,y                 ; 1D4F:  79 9d 69
b00_9d52:   sbc #$52                    ; 1D52:  e9 52
b00_9d54:   dex                         ; 1D54:  ca
b00_9d55:   .db $02                     ; 1D55:  02
b00_9d56:   bne $9d0b                   ; 1D56:  d0 b3
b00_9d58:   .db $0b                     ; 1D58:  0b
b00_9d59:   .db $d3                     ; 1D59:  d3
b00_9d5a:   .db $b3                     ; 1D5A:  b3
b00_9d5b:   sbc #$da                    ; 1D5B:  e9 da
b00_9d5d:   .db $d7                     ; 1D5D:  d7
b00_9d5e:   .db $02                     ; 1D5E:  02
b00_9d5f:   and #$d0                    ; 1D5F:  29 d0
b00_9d61:   .db $b3                     ; 1D61:  b3
b00_9d62:   sbc #$12                    ; 1D62:  e9 12
b00_9d64:   dex                         ; 1D64:  ca
b00_9d65:   .db $04                     ; 1D65:  04
b00_9d66:   .db $0b                     ; 1D66:  0b
b00_9d67:   .db $d3                     ; 1D67:  d3
b00_9d68:   .db $b3                     ; 1D68:  b3
b00_9d69:   sbc #$72                    ; 1D69:  e9 72
b00_9d6b:   .db $d7                     ; 1D6B:  d7
b00_9d6c:   .db $02                     ; 1D6C:  02
b00_9d6d:   sty $6dd4                   ; 1D6D:  8c d4 6d
b00_9d70:   .db $bb                     ; 1D70:  bb
b00_9d71:   .db $b3                     ; 1D71:  b3
b00_9d72:   ora #$d0                    ; 1D72:  09 d0
b00_9d74:   .db $d3                     ; 1D74:  d3
b00_9d75:   .db $8b                     ; 1D75:  8b
b00_9d76:   .db $32                     ; 1D76:  32
b00_9d77:   .db $c3                     ; 1D77:  c3
b00_9d78:   .db $d4                     ; 1D78:  d4
b00_9d79:   .db $0b                     ; 1D79:  0b
b00_9d7a:   bne $9da7                   ; 1D7A:  d0 2b
b00_9d7c:   .db $0b                     ; 1D7C:  0b
b00_9d7d:   .db $d3                     ; 1D7D:  d3
b00_9d7e:   sty $00ff                   ; 1D7E:  8c ff 00
b00_9d81:   cmp ($d7,x)                 ; 1D81:  c1 d7
b00_9d83:   ora ($9d),y                 ; 1D83:  11 9d
b00_9d85:   .db $cf                     ; 1D85:  cf
b00_9d86:   jsr $e823                   ; 1D86:  20 23 e8
b00_9d89:   brk                         ; 1D89:  00
b00_9d8a:   brk                         ; 1D8A:  00
b00_9d8b:   .db $0c                     ; 1D8B:  0c
b00_9d8c:   .db $8b                     ; 1D8C:  8b
b00_9d8d:   .db $32                     ; 1D8D:  32
b00_9d8e:   cpy $d8                     ; 1D8E:  c4 d8
b00_9d90:   sta $9d,x                   ; 1D90:  95 9d
b00_9d92:   .db $89                     ; 1D92:  89
b00_9d93:   .db $32                     ; 1D93:  32
b00_9d94:   bit $e98e                   ; 1D94:  2c 8e e9
b00_9d97:   .db $07                     ; 1D97:  07
b00_9d98:   sbc #$52                    ; 1D98:  e9 52
b00_9d9a:   dex                         ; 1D9A:  ca
b00_9d9b:   .db $02                     ; 1D9B:  02
b00_9d9c:   .db $b3                     ; 1D9C:  b3
b00_9d9d:   .db $0c                     ; 1D9D:  0c
b00_9d9e:   .db $1c                     ; 1D9E:  1c
b00_9d9f:   lda $b4,x                   ; 1D9F:  b5 b4
b00_9da1:   .db $c2                     ; 1DA1:  c2
b00_9da2:   .db $cf                     ; 1DA2:  cf
b00_9da3:   jsr $e823                   ; 1DA3:  20 23 e8
b00_9da6:   brk                         ; 1DA6:  00
b00_9da7:   brk                         ; 1DA7:  00
b00_9da8:   .db $0c                     ; 1DA8:  0c
b00_9da9:   tay                         ; 1DA9:  a8
b00_9daa:   .db $63                     ; 1DAA:  63
b00_9dab:   .db $6f                     ; 1DAB:  6f
b00_9dac:   .db $0c                     ; 1DAC:  0c
b00_9dad:   .db $8b                     ; 1DAD:  8b
b00_9dae:   .db $1a                     ; 1DAE:  1a
b00_9daf:   lda $8c,x                   ; 1DAF:  b5 8c
b00_9db1:   ora $bb70                   ; 1DB1:  0d 70 bb
b00_9db4:   bcs $9d69                   ; 1DB4:  b0 b3
b00_9db6:   sbc #$86                    ; 1DB6:  e9 86
b00_9db8:   sta $d702,x                 ; 1DB8:  9d 02 d7
b00_9dbb:   sbc #$9d                    ; 1DBB:  e9 9d
b00_9dbd:   .db $0c                     ; 1DBD:  0c
b00_9dbe:   sty $6d2d                   ; 1DBE:  8c 2d 6d
b00_9dc1:   .db $bb                     ; 1DC1:  bb
b00_9dc2:   .db $d3                     ; 1DC2:  d3
b00_9dc3:   .db $b3                     ; 1DC3:  b3
b00_9dc4:   .db $89                     ; 1DC4:  89
b00_9dc5:   .db $64                     ; 1DC5:  64
b00_9dc6:   ldy $bc,x                   ; 1DC6:  b4 bc
b00_9dc8:   .db $b3                     ; 1DC8:  b3
b00_9dc9:   sbc #$86                    ; 1DC9:  e9 86
b00_9dcb:   sta $d702,x                 ; 1DCB:  9d 02 d7
b00_9dce:   sbc #$9d                    ; 1DCE:  e9 9d
b00_9dd0:   .db $3c                     ; 1DD0:  3c
b00_9dd1:   sbc #$da                    ; 1DD1:  e9 da
b00_9dd3:   .db $d7                     ; 1DD3:  d7
b00_9dd4:   .db $02                     ; 1DD4:  02
b00_9dd5:   .db $74                     ; 1DD5:  74
b00_9dd6:   .db $d3                     ; 1DD6:  d3
b00_9dd7:   .db $b3                     ; 1DD7:  b3
b00_9dd8:   sbc #$86                    ; 1DD8:  e9 86
b00_9dda:   sta $d702,x                 ; 1DDA:  9d 02 d7
b00_9ddd:   sbc #$9d                    ; 1DDD:  e9 9d
b00_9ddf:   stx $03e8                   ; 1DDF:  8e e8 03
b00_9de2:   sbc #$52                    ; 1DE2:  e9 52
b00_9de4:   dex                         ; 1DE4:  ca
b00_9de5:   .db $02                     ; 1DE5:  02
b00_9de6:   .db $d7                     ; 1DE6:  d7
b00_9de7:   .db $1b                     ; 1DE7:  1b
b00_9de8:   .db $9e                     ; 1DE8:  9e
b00_9de9:   .db $0c                     ; 1DE9:  0c
b00_9dea:   .db $8b                     ; 1DEA:  8b
b00_9deb:   .db $1a                     ; 1DEB:  1a
b00_9dec:   lda $8c,x                   ; 1DEC:  b5 8c
b00_9dee:   ora #$70                    ; 1DEE:  09 70
b00_9df0:   .db $bb                     ; 1DF0:  bb
b00_9df1:   bcs $9e43                   ; 1DF1:  b0 50
b00_9df3:   cpy $d8                     ; 1DF3:  c4 d8
b00_9df5:   .db $1b                     ; 1DF5:  1b
b00_9df6:   .db $9e                     ; 1DF6:  9e
b00_9df7:   .db $0c                     ; 1DF7:  0c
b00_9df8:   .db $8b                     ; 1DF8:  8b
b00_9df9:   .db $1a                     ; 1DF9:  1a
b00_9dfa:   lda $8c,x                   ; 1DFA:  b5 8c
b00_9dfc:   ora ($70),y                 ; 1DFC:  11 70
b00_9dfe:   .db $bb                     ; 1DFE:  bb
b00_9dff:   bcs $9e53                   ; 1DFF:  b0 52
b00_9e01:   cpy $d8                     ; 1E01:  c4 d8
b00_9e03:   .db $1b                     ; 1E03:  1b
b00_9e04:   .db $9e                     ; 1E04:  9e
b00_9e05:   ldy $db12                   ; 1E05:  ac 12 db
b00_9e08:   .db $d7                     ; 1E08:  d7
b00_9e09:   .db $1b                     ; 1E09:  1b
b00_9e0a:   .db $9e                     ; 1E0A:  9e
b00_9e0b:   .db $3c                     ; 1E0B:  3c
b00_9e0c:   sbc #$99                    ; 1E0C:  e9 99
b00_9e0e:   cmp $d702,y                 ; 1E0E:  d9 02 d7
b00_9e11:   .db $1b                     ; 1E11:  1b
b00_9e12:   .db $9e                     ; 1E12:  9e
b00_9e13:   .db $64                     ; 1E13:  64
b00_9e14:   sbc #$52                    ; 1E14:  e9 52
b00_9e16:   dex                         ; 1E16:  ca
b00_9e17:   .db $02                     ; 1E17:  02
b00_9e18:   cld                         ; 1E18:  d8
b00_9e19:   .db $1f                     ; 1E19:  1f
b00_9e1a:   .db $9e                     ; 1E1A:  9e
b00_9e1b:   rti                         ; 1E1B:  40
b00_9e1c:   dec $20,x                   ; 1E1C:  d6 20
b00_9e1e:   .db $9e                     ; 1E1E:  9e
b00_9e1f:   eor ($cf,x)                 ; 1E1F:  41 cf
b00_9e21:   jsr $e823                   ; 1E21:  20 23 e8
b00_9e24:   brk                         ; 1E24:  00
b00_9e25:   brk                         ; 1E25:  00
b00_9e26:   .db $0c                     ; 1E26:  0c
b00_9e27:   tay                         ; 1E27:  a8
b00_9e28:   .db $63                     ; 1E28:  63
b00_9e29:   .db $6f                     ; 1E29:  6f
b00_9e2a:   .db $0c                     ; 1E2A:  0c
b00_9e2b:   .db $8b                     ; 1E2B:  8b
b00_9e2c:   .db $1a                     ; 1E2C:  1a
b00_9e2d:   lda $8c,x                   ; 1E2D:  b5 8c
b00_9e2f:   .db $13                     ; 1E2F:  13
b00_9e30:   bvs $9ded                   ; 1E30:  70 bb
b00_9e32:   bcs $9de7                   ; 1E32:  b0 b3
b00_9e34:   sbc #$86                    ; 1E34:  e9 86
b00_9e36:   sta $d702,x                 ; 1E36:  9d 02 d7
b00_9e39:   rts                         ; 1E39:  60
b00_9e3a:   .db $9e                     ; 1E3A:  9e
b00_9e3b:   .db $3c                     ; 1E3B:  3c
b00_9e3c:   sbc #$da                    ; 1E3C:  e9 da
b00_9e3e:   .db $d7                     ; 1E3E:  d7
b00_9e3f:   .db $02                     ; 1E3F:  02
b00_9e40:   .db $74                     ; 1E40:  74
b00_9e41:   .db $d3                     ; 1E41:  d3
b00_9e42:   .db $b3                     ; 1E42:  b3
b00_9e43:   sbc #$86                    ; 1E43:  e9 86
b00_9e45:   sta $d702,x                 ; 1E45:  9d 02 d7
b00_9e48:   rts                         ; 1E48:  60
b00_9e49:   .db $9e                     ; 1E49:  9e
b00_9e4a:   ldy $db12                   ; 1E4A:  ac 12 db
b00_9e4d:   cld                         ; 1E4D:  d8
b00_9e4e:   eor $9e,x                   ; 1E4E:  55 9e
b00_9e50:   .db $89                     ; 1E50:  89
b00_9e51:   .db $14                     ; 1E51:  14
b00_9e52:   dec $58,x                   ; 1E52:  d6 58
b00_9e54:   .db $9e                     ; 1E54:  9e
b00_9e55:   txa                         ; 1E55:  8a
b00_9e56:   inx                         ; 1E56:  e8
b00_9e57:   .db $03                     ; 1E57:  03
b00_9e58:   .db $b3                     ; 1E58:  b3
b00_9e59:   sbc #$52                    ; 1E59:  e9 52
b00_9e5b:   dex                         ; 1E5B:  ca
b00_9e5c:   .db $02                     ; 1E5C:  02
b00_9e5d:   .db $d7                     ; 1E5D:  d7
b00_9e5e:   ror $9e,x                   ; 1E5E:  76 9e
b00_9e60:   .db $0c                     ; 1E60:  0c
b00_9e61:   .db $8b                     ; 1E61:  8b
b00_9e62:   .db $1a                     ; 1E62:  1a
b00_9e63:   lda $8c,x                   ; 1E63:  b5 8c
b00_9e65:   ora ($70),y                 ; 1E65:  11 70
b00_9e67:   .db $bb                     ; 1E67:  bb
b00_9e68:   bcs $9ebc                   ; 1E68:  b0 52
b00_9e6a:   cpy $d8                     ; 1E6A:  c4 d8
b00_9e6c:   ror $9e,x                   ; 1E6C:  76 9e
b00_9e6e:   .db $3c                     ; 1E6E:  3c
b00_9e6f:   sbc #$99                    ; 1E6F:  e9 99
b00_9e71:   cmp $d802,y                 ; 1E71:  d9 02 d8
b00_9e74:   .db $7a                     ; 1E74:  7a
b00_9e75:   .db $9e                     ; 1E75:  9e
b00_9e76:   rti                         ; 1E76:  40
b00_9e77:   dec $7b,x                   ; 1E77:  d6 7b
b00_9e79:   .db $9e                     ; 1E79:  9e
b00_9e7a:   eor ($cf,x)                 ; 1E7A:  41 cf
b00_9e7c:   jsr $e823                   ; 1E7C:  20 23 e8
b00_9e7f:   brk                         ; 1E7F:  00
b00_9e80:   brk                         ; 1E80:  00
b00_9e81:   and $99e9,x                 ; 1E81:  3d e9 99
b00_9e84:   cmp $d802,y                 ; 1E84:  d9 02 d8
b00_9e87:   .db $8b                     ; 1E87:  8b
b00_9e88:   .db $9e                     ; 1E88:  9e
b00_9e89:   rti                         ; 1E89:  40
b00_9e8a:   .db $cf                     ; 1E8A:  cf
b00_9e8b:   .db $0c                     ; 1E8B:  0c
b00_9e8c:   eor ($c0),y                 ; 1E8C:  51 c0
b00_9e8e:   cld                         ; 1E8E:  d8
b00_9e8f:   .db $97                     ; 1E8F:  97
b00_9e90:   .db $9e                     ; 1E90:  9e
b00_9e91:   and $a3e9,x                 ; 1E91:  3d e9 a3
b00_9e94:   sta $cf02,x                 ; 1E94:  9d 02 cf
b00_9e97:   and $21e9,x                 ; 1E97:  3d e9 21
b00_9e9a:   .db $9e                     ; 1E9A:  9e
b00_9e9b:   .db $02                     ; 1E9B:  02
b00_9e9c:   .db $cf                     ; 1E9C:  cf
b00_9e9d:   jsr $e823                   ; 1E9D:  20 23 e8
b00_9ea0:   .db $fa                     ; 1EA0:  fa
b00_9ea1:   .db $ff                     ; 1EA1:  ff
b00_9ea2:   rti                         ; 1EA2:  40
b00_9ea3:   and #$8a                    ; 1EA3:  29 8a
b00_9ea5:   lda $2b7b                   ; 1EA5:  ad 7b 2b
b00_9ea8:   rti                         ; 1EA8:  40
b00_9ea9:   dec $ca,x                   ; 1EA9:  d6 ca
b00_9eab:   .db $9e                     ; 1EAB:  9e
b00_9eac:   asl a                       ; 1EAC:  0a
b00_9ead:   sty $6f1b                   ; 1EAD:  8c 1b 6f
b00_9eb0:   .db $bb                     ; 1EB0:  bb
b00_9eb1:   .db $d3                     ; 1EB1:  d3
b00_9eb2:   .db $b3                     ; 1EB2:  b3
b00_9eb3:   .db $3c                     ; 1EB3:  3c
b00_9eb4:   sbc #$7c                    ; 1EB4:  e9 7c
b00_9eb6:   .db $9e                     ; 1EB6:  9e
b00_9eb7:   .db $04                     ; 1EB7:  04
b00_9eb8:   cld                         ; 1EB8:  d8
b00_9eb9:   iny                         ; 1EB9:  c8
b00_9eba:   .db $9e                     ; 1EBA:  9e
b00_9ebb:   .db $3b                     ; 1EBB:  3b
b00_9ebc:   asl a                       ; 1EBC:  0a
b00_9ebd:   sty $6f1b                   ; 1EBD:  8c 1b 6f
b00_9ec0:   .db $bb                     ; 1EC0:  bb
b00_9ec1:   .db $d3                     ; 1EC1:  d3
b00_9ec2:   .db $d4                     ; 1EC2:  d4
b00_9ec3:   .db $0b                     ; 1EC3:  0b
b00_9ec4:   bne $9ef1                   ; 1EC4:  d0 2b
b00_9ec6:   eor ($29,x)                 ; 1EC6:  41 29
b00_9ec8:   asl a                       ; 1EC8:  0a
b00_9ec9:   bne $9ef5                   ; 1EC9:  d0 2a
b00_9ecb:   asl a                       ; 1ECB:  0a
b00_9ecc:   ldx $9d                     ; 1ECC:  a6 9d
b00_9ece:   adc $d7c6                   ; 1ECE:  6d c6 d7
b00_9ed1:   ldy $3b9e                   ; 1ED1:  ac 9e 3b
b00_9ed4:   .db $89                     ; 1ED4:  89
b00_9ed5:   .db $ff                     ; 1ED5:  ff
b00_9ed6:   .db $d4                     ; 1ED6:  d4
b00_9ed7:   ora #$cf                    ; 1ED7:  09 cf
b00_9ed9:   jsr $e823                   ; 1ED9:  20 23 e8
b00_9edc:   .db $fa                     ; 1EDC:  fa
b00_9edd:   .db $ff                     ; 1EDD:  ff
b00_9ede:   eor ($2b,x)                 ; 1EDE:  41 2b
b00_9ee0:   .db $62                     ; 1EE0:  62
b00_9ee1:   sbc #$52                    ; 1EE1:  e9 52
b00_9ee3:   dex                         ; 1EE3:  ca
b00_9ee4:   .db $02                     ; 1EE4:  02
b00_9ee5:   rol a                       ; 1EE5:  2a
b00_9ee6:   rti                         ; 1EE6:  40
b00_9ee7:   dec $00,x                   ; 1EE7:  d6 00
b00_9ee9:   .db $9f                     ; 1EE9:  9f
b00_9eea:   asl a                       ; 1EEA:  0a
b00_9eeb:   bne $9ea0                   ; 1EEB:  d0 b3
b00_9eed:   sbc #$9d                    ; 1EED:  e9 9d
b00_9eef:   .db $9e                     ; 1EEF:  9e
b00_9ef0:   .db $02                     ; 1EF0:  02
b00_9ef1:   cld                         ; 1EF1:  d8
b00_9ef2:   sbc $409e,y                 ; 1EF2:  f9 9e 40
b00_9ef5:   .db $2b                     ; 1EF5:  2b
b00_9ef6:   dec $07,x                   ; 1EF6:  d6 07
b00_9ef8:   .db $9f                     ; 1EF8:  9f
b00_9ef9:   eor ($cd,x)                 ; 1EF9:  41 cd
b00_9efb:   asl a                       ; 1EFB:  0a
b00_9efc:   .db $dc                     ; 1EFC:  dc
b00_9efd:   rol a                       ; 1EFD:  2a
b00_9efe:   ora #$d0                    ; 1EFE:  09 d0
b00_9f00:   and #$09                    ; 1F00:  29 09
b00_9f02:   .db $52                     ; 1F02:  52
b00_9f03:   dec $d7                     ; 1F03:  c6 d7
b00_9f05:   nop                         ; 1F05:  ea
b00_9f06:   .db $9e                     ; 1F06:  9e
b00_9f07:   .db $0b                     ; 1F07:  0b
b00_9f08:   eor ($c0),y                 ; 1F08:  51 c0
b00_9f0a:   cld                         ; 1F0A:  d8
b00_9f0b:   ora ($9f),y                 ; 1F0B:  11 9f
b00_9f0d:   ldy $9c84                   ; 1F0D:  ac 84 9c
b00_9f10:   .db $cf                     ; 1F10:  cf
b00_9f11:   asl a                       ; 1F11:  0a
b00_9f12:   cmp $0002,y                 ; 1F12:  d9 02 00
b00_9f15:   brk                         ; 1F15:  00
b00_9f16:   brk                         ; 1F16:  00
b00_9f17:   .db $1f                     ; 1F17:  1f
b00_9f18:   .db $9f                     ; 1F18:  9f
b00_9f19:   ora ($00,x)                 ; 1F19:  01 00
b00_9f1b:   .db $3b                     ; 1F1B:  3b
b00_9f1c:   .db $9f                     ; 1F1C:  9f
b00_9f1d:   bpl $9ebe                   ; 1F1D:  10 9f
b00_9f1f:   sta $e91e                   ; 1F1F:  8d 1e e9
b00_9f22:   .db $03                     ; 1F22:  03
b00_9f23:   dex                         ; 1F23:  ca
b00_9f24:   .db $02                     ; 1F24:  02
b00_9f25:   stx $bf0b                   ; 1F25:  8e 0b bf
b00_9f28:   sbc #$26                    ; 1F28:  e9 26
b00_9f2a:   .db $d3                     ; 1F2A:  d3
b00_9f2b:   .db $02                     ; 1F2B:  02
b00_9f2c:   ldy $d766                   ; 1F2C:  ac 66 d7
b00_9f2f:   sta $e917                   ; 1F2F:  8d 17 e9
b00_9f32:   .db $0c                     ; 1F32:  0c
b00_9f33:   inx                         ; 1F33:  e8
b00_9f34:   .db $02                     ; 1F34:  02
b00_9f35:   ldy $8ff8                   ; 1F35:  ac f8 8f
b00_9f38:   dec $10,x                   ; 1F38:  d6 10
b00_9f3a:   .db $9f                     ; 1F3A:  9f
b00_9f3b:   sta $e91e                   ; 1F3B:  8d 1e e9
b00_9f3e:   .db $03                     ; 1F3E:  03
b00_9f3f:   dex                         ; 1F3F:  ca
b00_9f40:   .db $02                     ; 1F40:  02
b00_9f41:   stx $bf10                   ; 1F41:  8e 10 bf
b00_9f44:   sbc #$26                    ; 1F44:  e9 26
b00_9f46:   .db $d3                     ; 1F46:  d3
b00_9f47:   .db $02                     ; 1F47:  02
b00_9f48:   ldy $d766                   ; 1F48:  ac 66 d7
b00_9f4b:   sta $e919                   ; 1F4B:  8d 19 e9
b00_9f4e:   .db $0c                     ; 1F4E:  0c
b00_9f4f:   inx                         ; 1F4F:  e8
b00_9f50:   .db $02                     ; 1F50:  02
b00_9f51:   ldy $9778                   ; 1F51:  ac 78 97
b00_9f54:   dec $10,x                   ; 1F54:  d6 10
b00_9f56:   .db $9f                     ; 1F56:  9f
b00_9f57:   jsr $e823                   ; 1F57:  20 23 e8
b00_9f5a:   inc $3cff,x                 ; 1F5A:  fe ff 3c
b00_9f5d:   sbc #$6d                    ; 1F5D:  e9 6d
b00_9f5f:   sty $02,x                   ; 1F5F:  94 02
b00_9f61:   .db $5a                     ; 1F61:  5a
b00_9f62:   ldx $2b,y                   ; 1F62:  b6 2b
b00_9f64:   .db $62                     ; 1F64:  62
b00_9f65:   sbc #$52                    ; 1F65:  e9 52
b00_9f67:   dex                         ; 1F67:  ca
b00_9f68:   .db $02                     ; 1F68:  02
b00_9f69:   cld                         ; 1F69:  d8
b00_9f6a:   .db $8b                     ; 1F6A:  8b
b00_9f6b:   .db $9f                     ; 1F6B:  9f
b00_9f6c:   ror a                       ; 1F6C:  6a
b00_9f6d:   sbc #$52                    ; 1F6D:  e9 52
b00_9f6f:   dex                         ; 1F6F:  ca
b00_9f70:   .db $02                     ; 1F70:  02
b00_9f71:   .db $1b                     ; 1F71:  1b
b00_9f72:   .db $bb                     ; 1F72:  bb
b00_9f73:   .db $b3                     ; 1F73:  b3
b00_9f74:   ora $b47e                   ; 1F74:  0d 7e b4
b00_9f77:   .db $b3                     ; 1F77:  b3
b00_9f78:   bcs $9f35                   ; 1F78:  b0 bb
b00_9f7a:   lda ($8d),y                 ; 1F7A:  b1 8d
b00_9f7c:   plp                         ; 1F7C:  28
b00_9f7d:   sbc #$52                    ; 1F7D:  e9 52
b00_9f7f:   dex                         ; 1F7F:  ca
b00_9f80:   .db $02                     ; 1F80:  02
b00_9f81:   .db $1b                     ; 1F81:  1b
b00_9f82:   .db $bb                     ; 1F82:  bb
b00_9f83:   .db $b3                     ; 1F83:  b3
b00_9f84:   ora $b47c                   ; 1F84:  0d 7c b4
b00_9f87:   .db $b3                     ; 1F87:  b3
b00_9f88:   bcs $9f45                   ; 1F88:  b0 bb
b00_9f8a:   lda ($cf),y                 ; 1F8A:  b1 cf
b00_9f8c:   jsr $e823                   ; 1F8C:  20 23 e8
b00_9f8f:   sed                         ; 1F8F:  f8
b00_9f90:   .db $ff                     ; 1F90:  ff
b00_9f91:   ldy $9f                     ; 1F91:  a4 9f
b00_9f93:   adc $188c                   ; 1F93:  6d 8c 18
b00_9f96:   asl $c1                     ; 1F96:  06 c1
b00_9f98:   cld                         ; 1F98:  d8
b00_9f99:   .db $37                     ; 1F99:  37
b00_9f9a:   ldy #$64                    ; 1F9A:  a0 64
b00_9f9c:   sbc #$e8                    ; 1F9C:  e9 e8
b00_9f9e:   bcc $9fa2                   ; 1F9E:  90 02
b00_9fa0:   .db $62                     ; 1FA0:  62
b00_9fa1:   sbc #$1e                    ; 1FA1:  e9 1e
b00_9fa3:   sta ($02),y                 ; 1FA3:  91 02
b00_9fa5:   rti                         ; 1FA5:  40
b00_9fa6:   .db $2b                     ; 1FA6:  2b
b00_9fa7:   rts                         ; 1FA7:  60
b00_9fa8:   sbc #$cd                    ; 1FA8:  e9 cd
b00_9faa:   .db $d7                     ; 1FAA:  d7
b00_9fab:   .db $02                     ; 1FAB:  02
b00_9fac:   and #$d6                    ; 1FAC:  29 d6
b00_9fae:   cpy $9f                     ; 1FAE:  c4 9f
b00_9fb0:   ora #$b3                    ; 1FB0:  09 b3
b00_9fb2:   .db $d3                     ; 1FB2:  d3
b00_9fb3:   bne $9f89                   ; 1FB3:  d0 d4
b00_9fb5:   ora #$d0                    ; 1FB5:  09 d0
b00_9fb7:   .db $b3                     ; 1FB7:  b3
b00_9fb8:   .db $d3                     ; 1FB8:  d3
b00_9fb9:   cmp ($d4),y                 ; 1FB9:  d1 d4
b00_9fbb:   .db $0b                     ; 1FBB:  0b
b00_9fbc:   bne $9fe9                   ; 1FBC:  d0 2b
b00_9fbe:   cmp ($09),y                 ; 1FBE:  d1 09
b00_9fc0:   .db $77                     ; 1FC0:  77
b00_9fc1:   and #$8f                    ; 1FC1:  29 8f
b00_9fc3:   sbc $9da4,y                 ; 1FC3:  f9 a4 9d
b00_9fc6:   adc $b373                   ; 1FC6:  6d 73 b3
b00_9fc9:   .db $0b                     ; 1FC9:  0b
b00_9fca:   ldy $c6,x                   ; 1FCA:  b4 c6
b00_9fcc:   .db $d7                     ; 1FCC:  d7
b00_9fcd:   bcs $9f6e                   ; 1FCD:  b0 9f
b00_9fcf:   rti                         ; 1FCF:  40
b00_9fd0:   dec $2b,x                   ; 1FD0:  d6 2b
b00_9fd2:   ldy #$3b                    ; 1FD2:  a0 3b
b00_9fd4:   sbc #$8d                    ; 1FD4:  e9 8d
b00_9fd6:   cmp $d702,y                 ; 1FD6:  d9 02 d7
b00_9fd9:   sbc #$9f                    ; 1FD9:  e9 9f
b00_9fdb:   .db $0b                     ; 1FDB:  0b
b00_9fdc:   .db $8b                     ; 1FDC:  8b
b00_9fdd:   .db $1a                     ; 1FDD:  1a
b00_9fde:   lda $8c,x                   ; 1FDE:  b5 8c
b00_9fe0:   ora ($70,x)                 ; 1FE0:  01 70
b00_9fe2:   .db $bb                     ; 1FE2:  bb
b00_9fe3:   .db $b3                     ; 1FE3:  b3
b00_9fe4:   .db $3b                     ; 1FE4:  3b
b00_9fe5:   sbc #$57                    ; 1FE5:  e9 57
b00_9fe7:   .db $9f                     ; 1FE7:  9f
b00_9fe8:   .db $04                     ; 1FE8:  04
b00_9fe9:   .db $0b                     ; 1FE9:  0b
b00_9fea:   .db $8b                     ; 1FEA:  8b
b00_9feb:   .db $1a                     ; 1FEB:  1a
b00_9fec:   lda $8c,x                   ; 1FEC:  b5 8c
b00_9fee:   ora $bb70                   ; 1FEE:  0d 70 bb
b00_9ff1:   rol a                       ; 1FF1:  2a
b00_9ff2:   .db $3b                     ; 1FF2:  3b
b00_9ff3:   sbc #$8d                    ; 1FF3:  e9 8d
b00_9ff5:   cmp $d802,y                 ; 1FF5:  d9 02 d8
b00_9ff8:   and #$a0                    ; 1FF8:  29 a0
b00_9ffa:   ldy $63                     ; 1FFA:  a4 63
b00_9ffc:   adc $c151                   ; 1FFC:  6d 51 c1
b00_9fff:   cld                         ; 1FFF:  d8
b00_a000:   and #$a0                    ; 2000:  29 a0
b00_a002:   tax                         ; 2002:  aa
b00_a003:   .db $63                     ; 2003:  63
b00_a004:   adc $52e9                   ; 2004:  6d e9 52
b00_a007:   dex                         ; 2007:  ca
b00_a008:   .db $02                     ; 2008:  02
b00_a009:   plp                         ; 2009:  28
b00_a00a:   sec                         ; 200A:  38
b00_a00b:   asl a                       ; 200B:  0a
b00_a00c:   .db $72                     ; 200C:  72
b00_a00d:   rol a                       ; 200D:  2a
b00_a00e:   .db $8f                     ; 200E:  8f
b00_a00f:   inc $b3b4,x                 ; 200F:  fe b4 b3
b00_a012:   bcs $9fd0                   ; 2012:  b0 bc
b00_a014:   lda ($38),y                 ; 2014:  b1 38
b00_a016:   asl a                       ; 2016:  0a
b00_a017:   .db $72                     ; 2017:  72
b00_a018:   rol a                       ; 2018:  2a
b00_a019:   .db $8f                     ; 2019:  8f
b00_a01a:   inc $b3b4,x                 ; 201A:  fe b4 b3
b00_a01d:   bcs $9fdb                   ; 201D:  b0 bc
b00_a01f:   lda ($38),y                 ; 201F:  b1 38
b00_a021:   asl a                       ; 2021:  0a
b00_a022:   .db $72                     ; 2022:  72
b00_a023:   rol a                       ; 2023:  2a
b00_a024:   ldy $b3,x                   ; 2024:  b4 b3
b00_a026:   bcs $9fe4                   ; 2026:  b0 bc
b00_a028:   lda ($0b),y                 ; 2028:  b1 0b
b00_a02a:   bne $a057                   ; 202A:  d0 2b
b00_a02c:   .db $0b                     ; 202C:  0b
b00_a02d:   ldx $9d                     ; 202D:  a6 9d
b00_a02f:   adc $d7c6                   ; 202F:  6d c6 d7
b00_a032:   .db $d3                     ; 2032:  d3
b00_a033:   .db $9f                     ; 2033:  9f
b00_a034:   dec $65,x                   ; 2034:  d6 65
b00_a036:   ldy #$8d                    ; 2036:  a0 8d
b00_a038:   clc                         ; 2038:  18
b00_a039:   sbc #$8d                    ; 2039:  e9 8d
b00_a03b:   cmp $d802,y                 ; 203B:  d9 02 d8
b00_a03e:   lsr $a4a0                   ; 203E:  4e a0 a4
b00_a041:   sta $8b6d,x                 ; 2041:  9d 6d 8b
b00_a044:   .db $32                     ; 2044:  32
b00_a045:   cpy #$d8                    ; 2045:  c0 d8
b00_a047:   lsr $89a0                   ; 2047:  4e a0 89
b00_a04a:   .db $64                     ; 204A:  64
b00_a04b:   tay                         ; 204B:  a8
b00_a04c:   adc ($72),y                 ; 204C:  71 72
b00_a04e:   sta $e910                   ; 204E:  8d 10 e9
b00_a051:   sta $02d9                   ; 2051:  8d d9 02
b00_a054:   cld                         ; 2054:  d8
b00_a055:   adc $a0                     ; 2055:  65 a0
b00_a057:   ldy $9d                     ; 2057:  a4 9d
b00_a059:   adc $118b                   ; 2059:  6d 8b 11
b00_a05c:   cpy #$d8                    ; 205C:  c0 d8
b00_a05e:   adc $a0                     ; 205E:  65 a0
b00_a060:   .db $89                     ; 2060:  89
b00_a061:   .db $64                     ; 2061:  64
b00_a062:   tay                         ; 2062:  a8
b00_a063:   lda ($71,x)                 ; 2063:  a1 71
b00_a065:   .db $cf                     ; 2065:  cf
b00_a066:   jsr $e823                   ; 2066:  20 23 e8
b00_a069:   sed                         ; 2069:  f8
b00_a06a:   .db $ff                     ; 206A:  ff
b00_a06b:   .db $62                     ; 206B:  62
b00_a06c:   sbc #$e8                    ; 206C:  e9 e8
b00_a06e:   bcc $a072                   ; 206E:  90 02
b00_a070:   rti                         ; 2070:  40
b00_a071:   dec $9f,x                   ; 2071:  d6 9f
b00_a073:   ldy #$0b                    ; 2073:  a0 0b
b00_a075:   .db $53                     ; 2075:  53
b00_a076:   lda $038c,x                 ; 2076:  bd 8c 03
b00_a079:   rts                         ; 2079:  60
b00_a07a:   .db $bb                     ; 207A:  bb
b00_a07b:   and #$0b                    ; 207B:  29 0b
b00_a07d:   .db $8b                     ; 207D:  8b
b00_a07e:   .db $1a                     ; 207E:  1a
b00_a07f:   lda $8c,x                   ; 207F:  b5 8c
b00_a081:   ora #$70                    ; 2081:  09 70
b00_a083:   .db $bb                     ; 2083:  bb
b00_a084:   plp                         ; 2084:  28
b00_a085:   rti                         ; 2085:  40
b00_a086:   rol a                       ; 2086:  2a
b00_a087:   ora #$72                    ; 2087:  09 72
b00_a089:   and #$8f                    ; 2089:  29 8f
b00_a08b:   inc $08b3,x                 ; 208B:  fe b3 08
b00_a08e:   .db $72                     ; 208E:  72
b00_a08f:   plp                         ; 208F:  28
b00_a090:   .db $8f                     ; 2090:  8f
b00_a091:   inc $b1b0,x                 ; 2091:  fe b0 b1
b00_a094:   asl a                       ; 2094:  0a
b00_a095:   bne $a0c1                   ; 2095:  d0 2a
b00_a097:   asl a                       ; 2097:  0a
b00_a098:   .db $54                     ; 2098:  54
b00_a099:   dec $d7                     ; 2099:  c6 d7
b00_a09b:   .db $87                     ; 209B:  87
b00_a09c:   ldy #$0b                    ; 209C:  a0 0b
b00_a09e:   bne $a0cb                   ; 209E:  d0 2b
b00_a0a0:   .db $0b                     ; 20A0:  0b
b00_a0a1:   ldx $9d                     ; 20A1:  a6 9d
b00_a0a3:   adc $d7c6                   ; 20A3:  6d c6 d7
b00_a0a6:   .db $74                     ; 20A6:  74
b00_a0a7:   ldy #$cf                    ; 20A7:  a0 cf
b00_a0a9:   jsr $e823                   ; 20A9:  20 23 e8
b00_a0ac:   .db $fc                     ; 20AC:  fc
b00_a0ad:   .db $ff                     ; 20AD:  ff
b00_a0ae:   .db $0c                     ; 20AE:  0c
b00_a0af:   .db $8b                     ; 20AF:  8b
b00_a0b0:   .db $1a                     ; 20B0:  1a
b00_a0b1:   lda $8c,x                   ; 20B1:  b5 8c
b00_a0b3:   ora ($70,x)                 ; 20B3:  01 70
b00_a0b5:   .db $bb                     ; 20B5:  bb
b00_a0b6:   .db $2b                     ; 20B6:  2b
b00_a0b7:   .db $0b                     ; 20B7:  0b
b00_a0b8:   sei                         ; 20B8:  78
b00_a0b9:   bcs $a0e5                   ; 20B9:  b0 2a
b00_a0bb:   .db $b3                     ; 20BB:  b3
b00_a0bc:   .db $0c                     ; 20BC:  0c
b00_a0bd:   .db $53                     ; 20BD:  53
b00_a0be:   lda $038c,x                 ; 20BE:  bd 8c 03
b00_a0c1:   rts                         ; 20C1:  60
b00_a0c2:   .db $bb                     ; 20C2:  bb
b00_a0c3:   bcs $a079                   ; 20C3:  b0 b4
b00_a0c5:   cmp $d8                     ; 20C5:  c5 d8
b00_a0c7:   .db $d3                     ; 20C7:  d3
b00_a0c8:   ldy #$0c                    ; 20C8:  a0 0c
b00_a0ca:   .db $53                     ; 20CA:  53
b00_a0cb:   lda $038c,x                 ; 20CB:  bd 8c 03
b00_a0ce:   rts                         ; 20CE:  60
b00_a0cf:   .db $bb                     ; 20CF:  bb
b00_a0d0:   .db $b3                     ; 20D0:  b3
b00_a0d1:   asl a                       ; 20D1:  0a
b00_a0d2:   lda ($0b),y                 ; 20D2:  b1 0b
b00_a0d4:   .db $7a                     ; 20D4:  7a
b00_a0d5:   bcs $a101                   ; 20D5:  b0 2a
b00_a0d7:   .db $b3                     ; 20D7:  b3
b00_a0d8:   .db $0c                     ; 20D8:  0c
b00_a0d9:   .db $53                     ; 20D9:  53
b00_a0da:   lda $058c,x                 ; 20DA:  bd 8c 05
b00_a0dd:   rts                         ; 20DD:  60
b00_a0de:   .db $bb                     ; 20DE:  bb
b00_a0df:   bcs $a095                   ; 20DF:  b0 b4
b00_a0e1:   cmp $d8                     ; 20E1:  c5 d8
b00_a0e3:   .db $ef                     ; 20E3:  ef
b00_a0e4:   ldy #$0c                    ; 20E4:  a0 0c
b00_a0e6:   .db $53                     ; 20E6:  53
b00_a0e7:   lda $058c,x                 ; 20E7:  bd 8c 05
b00_a0ea:   rts                         ; 20EA:  60
b00_a0eb:   .db $bb                     ; 20EB:  bb
b00_a0ec:   .db $b3                     ; 20EC:  b3
b00_a0ed:   asl a                       ; 20ED:  0a
b00_a0ee:   lda ($0b),y                 ; 20EE:  b1 0b
b00_a0f0:   .db $7c                     ; 20F0:  7c
b00_a0f1:   bcs $a11d                   ; 20F1:  b0 2a
b00_a0f3:   .db $b3                     ; 20F3:  b3
b00_a0f4:   .db $0c                     ; 20F4:  0c
b00_a0f5:   .db $53                     ; 20F5:  53
b00_a0f6:   lda $078c,x                 ; 20F6:  bd 8c 07
b00_a0f9:   rts                         ; 20F9:  60
b00_a0fa:   .db $bb                     ; 20FA:  bb
b00_a0fb:   bcs $a0b1                   ; 20FB:  b0 b4
b00_a0fd:   cmp $d8                     ; 20FD:  c5 d8
b00_a0ff:   .db $0b                     ; 20FF:  0b
b00_a100:   lda ($0c,x)                 ; 2100:  a1 0c
b00_a102:   .db $53                     ; 2102:  53
b00_a103:   lda $078c,x                 ; 2103:  bd 8c 07
b00_a106:   rts                         ; 2106:  60
b00_a107:   .db $bb                     ; 2107:  bb
b00_a108:   .db $b3                     ; 2108:  b3
b00_a109:   asl a                       ; 2109:  0a
b00_a10a:   lda ($0b),y                 ; 210A:  b1 0b
b00_a10c:   ror $2ab0,x                 ; 210C:  7e b0 2a
b00_a10f:   .db $b3                     ; 210F:  b3
b00_a110:   .db $0c                     ; 2110:  0c
b00_a111:   .db $53                     ; 2111:  53
b00_a112:   lda $098c,x                 ; 2112:  bd 8c 09
b00_a115:   rts                         ; 2115:  60
b00_a116:   .db $bb                     ; 2116:  bb
b00_a117:   bcs $a0cd                   ; 2117:  b0 b4
b00_a119:   cmp $d8                     ; 2119:  c5 d8
b00_a11b:   .db $27                     ; 211B:  27
b00_a11c:   lda ($0c,x)                 ; 211C:  a1 0c
b00_a11e:   .db $53                     ; 211E:  53
b00_a11f:   lda $098c,x                 ; 211F:  bd 8c 09
b00_a122:   rts                         ; 2122:  60
b00_a123:   .db $bb                     ; 2123:  bb
b00_a124:   .db $b3                     ; 2124:  b3
b00_a125:   asl a                       ; 2125:  0a
b00_a126:   lda ($cf),y                 ; 2126:  b1 cf
b00_a128:   jsr $e823                   ; 2128:  20 23 e8
b00_a12b:   inc $3cff,x                 ; 212B:  fe ff 3c
b00_a12e:   sbc #$6d                    ; 212E:  e9 6d
b00_a130:   sty $02,x                   ; 2130:  94 02
b00_a132:   .db $5a                     ; 2132:  5a
b00_a133:   ldx $2b,y                   ; 2133:  b6 2b
b00_a135:   ror a                       ; 2135:  6a
b00_a136:   sbc #$52                    ; 2136:  e9 52
b00_a138:   dex                         ; 2138:  ca
b00_a139:   .db $02                     ; 2139:  02
b00_a13a:   .db $1b                     ; 213A:  1b
b00_a13b:   .db $bb                     ; 213B:  bb
b00_a13c:   .db $b3                     ; 213C:  b3
b00_a13d:   ora $b3b4                   ; 213D:  0d b4 b3
b00_a140:   bcs $a0fd                   ; 2140:  b0 bb
b00_a142:   lda ($62),y                 ; 2142:  b1 62
b00_a144:   sbc #$52                    ; 2144:  e9 52
b00_a146:   dex                         ; 2146:  ca
b00_a147:   .db $02                     ; 2147:  02
b00_a148:   cld                         ; 2148:  d8
b00_a149:   .db $5a                     ; 2149:  5a
b00_a14a:   lda ($6a,x)                 ; 214A:  a1 6a
b00_a14c:   sbc #$52                    ; 214C:  e9 52
b00_a14e:   dex                         ; 214E:  ca
b00_a14f:   .db $02                     ; 214F:  02
b00_a150:   .db $1b                     ; 2150:  1b
b00_a151:   .db $bb                     ; 2151:  bb
b00_a152:   .db $b3                     ; 2152:  b3
b00_a153:   ora $b478                   ; 2153:  0d 78 b4
b00_a156:   .db $b3                     ; 2156:  b3
b00_a157:   bcs $a114                   ; 2157:  b0 bb
b00_a159:   lda ($cf),y                 ; 2159:  b1 cf
b00_a15b:   jsr $e823                   ; 215B:  20 23 e8
b00_a15e:   .db $fc                     ; 215E:  fc
b00_a15f:   .db $ff                     ; 215F:  ff
b00_a160:   .db $0c                     ; 2160:  0c
b00_a161:   .db $8f                     ; 2161:  8f
b00_a162:   bpl $a114                   ; 2162:  10 b0
b00_a164:   .db $52                     ; 2164:  52
b00_a165:   ldx $2b,y                   ; 2165:  b6 2b
b00_a167:   .db $0c                     ; 2167:  0c
b00_a168:   ror $b0,x                   ; 2168:  76 b0
b00_a16a:   .db $b3                     ; 216A:  b3
b00_a16b:   .db $0c                     ; 216B:  0c
b00_a16c:   bcs $a121                   ; 216C:  b0 b3
b00_a16e:   sbc #$5e                    ; 216E:  e9 5e
b00_a170:   .db $cb                     ; 2170:  cb
b00_a171:   .db $04                     ; 2171:  04
b00_a172:   rol a                       ; 2172:  2a
b00_a173:   .db $1b                     ; 2173:  1b
b00_a174:   .db $c2                     ; 2174:  c2
b00_a175:   cld                         ; 2175:  d8
b00_a176:   sta ($a1,x)                 ; 2176:  81 a1
b00_a178:   asl a                       ; 2178:  0a
b00_a179:   .db $2b                     ; 2179:  2b
b00_a17a:   .db $0c                     ; 217A:  0c
b00_a17b:   .db $8f                     ; 217B:  8f
b00_a17c:   bpl $a131                   ; 217C:  10 b3
b00_a17e:   asl a                       ; 217E:  0a
b00_a17f:   .db $d2                     ; 217F:  d2
b00_a180:   lda ($3b),y                 ; 2180:  b1 3b
b00_a182:   .db $0c                     ; 2182:  0c
b00_a183:   ldy $b3,x                   ; 2183:  b4 b3
b00_a185:   bcs $a143                   ; 2185:  b0 bc
b00_a187:   lda ($3b),y                 ; 2187:  b1 3b
b00_a189:   .db $0c                     ; 2189:  0c
b00_a18a:   ror $b4,x                   ; 218A:  76 b4
b00_a18c:   .db $b3                     ; 218C:  b3
b00_a18d:   bcs $a14b                   ; 218D:  b0 bc
b00_a18f:   lda ($cf),y                 ; 218F:  b1 cf
b00_a191:   jsr $e823                   ; 2191:  20 23 e8
b00_a194:   brk                         ; 2194:  00
b00_a195:   brk                         ; 2195:  00
b00_a196:   .db $0c                     ; 2196:  0c
b00_a197:   sty $6d2d                   ; 2197:  8c 2d 6d
b00_a19a:   .db $bb                     ; 219A:  bb
b00_a19b:   .db $d3                     ; 219B:  d3
b00_a19c:   .db $b3                     ; 219C:  b3
b00_a19d:   .db $3c                     ; 219D:  3c
b00_a19e:   sbc #$6d                    ; 219E:  e9 6d
b00_a1a0:   sty $02,x                   ; 21A0:  94 02
b00_a1a2:   .db $52                     ; 21A2:  52
b00_a1a3:   ldx $b3,y                   ; 21A3:  b6 b3
b00_a1a5:   sbc #$0d                    ; 21A5:  e9 0d
b00_a1a7:   .db $d7                     ; 21A7:  d7
b00_a1a8:   .db $04                     ; 21A8:  04
b00_a1a9:   .db $cf                     ; 21A9:  cf
b00_a1aa:   jsr $e823                   ; 21AA:  20 23 e8
b00_a1ad:   brk                         ; 21AD:  00
b00_a1ae:   brk                         ; 21AE:  00
b00_a1af:   .db $0c                     ; 21AF:  0c
b00_a1b0:   sty $6d2d                   ; 21B0:  8c 2d 6d
b00_a1b3:   .db $bb                     ; 21B3:  bb
b00_a1b4:   .db $d3                     ; 21B4:  d3
b00_a1b5:   .db $b3                     ; 21B5:  b3
b00_a1b6:   sta $0c28                   ; 21B6:  8d 28 0c
b00_a1b9:   .db $53                     ; 21B9:  53
b00_a1ba:   lda $078c,x                 ; 21BA:  bd 8c 07
b00_a1bd:   rts                         ; 21BD:  60
b00_a1be:   .db $bb                     ; 21BE:  bb
b00_a1bf:   bcs $a174                   ; 21BF:  b0 b3
b00_a1c1:   sbc #$0d                    ; 21C1:  e9 0d
b00_a1c3:   .db $d7                     ; 21C3:  d7
b00_a1c4:   .db $04                     ; 21C4:  04
b00_a1c5:   .db $b3                     ; 21C5:  b3
b00_a1c6:   sbc #$0d                    ; 21C6:  e9 0d
b00_a1c8:   .db $d7                     ; 21C8:  d7
b00_a1c9:   .db $04                     ; 21C9:  04
b00_a1ca:   .db $b3                     ; 21CA:  b3
b00_a1cb:   .db $0c                     ; 21CB:  0c
b00_a1cc:   sty $6d2d                   ; 21CC:  8c 2d 6d
b00_a1cf:   .db $bb                     ; 21CF:  bb
b00_a1d0:   .db $d3                     ; 21D0:  d3
b00_a1d1:   .db $b3                     ; 21D1:  b3
b00_a1d2:   .db $0c                     ; 21D2:  0c
b00_a1d3:   .db $53                     ; 21D3:  53
b00_a1d4:   lda $098c,x                 ; 21D4:  bd 8c 09
b00_a1d7:   rts                         ; 21D7:  60
b00_a1d8:   .db $bb                     ; 21D8:  bb
b00_a1d9:   bcs $a18e                   ; 21D9:  b0 b3
b00_a1db:   sbc #$0d                    ; 21DB:  e9 0d
b00_a1dd:   .db $d7                     ; 21DD:  d7
b00_a1de:   .db $04                     ; 21DE:  04
b00_a1df:   ldy $bb,x                   ; 21DF:  b4 bb
b00_a1e1:   .db $cf                     ; 21E1:  cf
b00_a1e2:   jsr $e823                   ; 21E2:  20 23 e8
b00_a1e5:   inc $3cff,x                 ; 21E5:  fe ff 3c
b00_a1e8:   sbc #$91                    ; 21E8:  e9 91
b00_a1ea:   lda ($02,x)                 ; 21EA:  a1 02
b00_a1ec:   bne $a1a1                   ; 21EC:  d0 b3
b00_a1ee:   sbc #$52                    ; 21EE:  e9 52
b00_a1f0:   dex                         ; 21F0:  ca
b00_a1f1:   .db $02                     ; 21F1:  02
b00_a1f2:   .db $b3                     ; 21F2:  b3
b00_a1f3:   .db $0c                     ; 21F3:  0c
b00_a1f4:   sty $6d2d                   ; 21F4:  8c 2d 6d
b00_a1f7:   .db $bb                     ; 21F7:  bb
b00_a1f8:   .db $d3                     ; 21F8:  d3
b00_a1f9:   .db $b3                     ; 21F9:  b3
b00_a1fa:   ora $b074                   ; 21FA:  0d 74 b0
b00_a1fd:   .db $b3                     ; 21FD:  b3
b00_a1fe:   sbc #$0d                    ; 21FE:  e9 0d
b00_a200:   .db $d7                     ; 2200:  d7
b00_a201:   .db $04                     ; 2201:  04
b00_a202:   .db $b3                     ; 2202:  b3
b00_a203:   .db $3c                     ; 2203:  3c
b00_a204:   sbc #$aa                    ; 2204:  e9 aa
b00_a206:   lda ($02,x)                 ; 2206:  a1 02
b00_a208:   ldy $bb,x                   ; 2208:  b4 bb
b00_a20a:   ldy $bb,x                   ; 220A:  b4 bb
b00_a20c:   .db $2b                     ; 220C:  2b
b00_a20d:   ora $188f                   ; 220D:  0d 8f 18
b00_a210:   bcs $a1c5                   ; 2210:  b0 b3
b00_a212:   .db $0b                     ; 2212:  0b
b00_a213:   ldy $c4,x                   ; 2213:  b4 c4
b00_a215:   cld                         ; 2215:  d8
b00_a216:   ora $0da2,x                 ; 2216:  1d a2 0d
b00_a219:   .db $8f                     ; 2219:  8f
b00_a21a:   clc                         ; 221A:  18
b00_a21b:   bcs $a248                   ; 221B:  b0 2b
b00_a21d:   .db $0b                     ; 221D:  0b
b00_a21e:   .db $cf                     ; 221E:  cf
b00_a21f:   jsr $e823                   ; 221F:  20 23 e8
b00_a222:   inc $3cff,x                 ; 2222:  fe ff 3c
b00_a225:   sbc #$91                    ; 2225:  e9 91
b00_a227:   lda ($02,x)                 ; 2227:  a1 02
b00_a229:   bne $a1de                   ; 2229:  d0 b3
b00_a22b:   sbc #$52                    ; 222B:  e9 52
b00_a22d:   dex                         ; 222D:  ca
b00_a22e:   .db $02                     ; 222E:  02
b00_a22f:   .db $b3                     ; 222F:  b3
b00_a230:   .db $0c                     ; 2230:  0c
b00_a231:   sty $6d2d                   ; 2231:  8c 2d 6d
b00_a234:   .db $bb                     ; 2234:  bb
b00_a235:   .db $d3                     ; 2235:  d3
b00_a236:   .db $b3                     ; 2236:  b3
b00_a237:   .db $0c                     ; 2237:  0c
b00_a238:   .db $53                     ; 2238:  53
b00_a239:   lda $058c,x                 ; 2239:  bd 8c 05
b00_a23c:   rts                         ; 223C:  60
b00_a23d:   .db $bb                     ; 223D:  bb
b00_a23e:   bcs $a1f3                   ; 223E:  b0 b3
b00_a240:   .db $0c                     ; 2240:  0c
b00_a241:   .db $53                     ; 2241:  53
b00_a242:   lda $038c,x                 ; 2242:  bd 8c 03
b00_a245:   rts                         ; 2245:  60
b00_a246:   .db $bb                     ; 2246:  bb
b00_a247:   bcs $a1fc                   ; 2247:  b0 b3
b00_a249:   sbc #$0d                    ; 2249:  e9 0d
b00_a24b:   .db $d7                     ; 224B:  d7
b00_a24c:   .db $04                     ; 224C:  04
b00_a24d:   .db $b3                     ; 224D:  b3
b00_a24e:   sbc #$0d                    ; 224E:  e9 0d
b00_a250:   .db $d7                     ; 2250:  d7
b00_a251:   .db $04                     ; 2251:  04
b00_a252:   .db $b3                     ; 2252:  b3
b00_a253:   .db $3c                     ; 2253:  3c
b00_a254:   sbc #$aa                    ; 2254:  e9 aa
b00_a256:   lda ($02,x)                 ; 2256:  a1 02
b00_a258:   ldy $bb,x                   ; 2258:  b4 bb
b00_a25a:   ldy $bb,x                   ; 225A:  b4 bb
b00_a25c:   .db $2b                     ; 225C:  2b
b00_a25d:   ora $188f                   ; 225D:  0d 8f 18
b00_a260:   bcs $a215                   ; 2260:  b0 b3
b00_a262:   .db $0b                     ; 2262:  0b
b00_a263:   ldy $c4,x                   ; 2263:  b4 c4
b00_a265:   cld                         ; 2265:  d8
b00_a266:   adc $0da2                   ; 2266:  6d a2 0d
b00_a269:   .db $8f                     ; 2269:  8f
b00_a26a:   clc                         ; 226A:  18
b00_a26b:   bcs $a298                   ; 226B:  b0 2b
b00_a26d:   .db $0b                     ; 226D:  0b
b00_a26e:   .db $cf                     ; 226E:  cf
b00_a26f:   jsr $e823                   ; 226F:  20 23 e8
b00_a272:   .db $fa                     ; 2272:  fa
b00_a273:   .db $ff                     ; 2273:  ff
b00_a274:   .db $62                     ; 2274:  62
b00_a275:   sbc #$e8                    ; 2275:  e9 e8
b00_a277:   bcc $a27b                   ; 2277:  90 02
b00_a279:   rti                         ; 2279:  40
b00_a27a:   dec $d5,x                   ; 227A:  d6 d5
b00_a27c:   ldx #$3a                    ; 227C:  a2 3a
b00_a27e:   sbc #$a9                    ; 227E:  e9 a9
b00_a280:   ldy #$02                    ; 2280:  a0 02
b00_a282:   asl a                       ; 2282:  0a
b00_a283:   .db $8b                     ; 2283:  8b
b00_a284:   .db $1a                     ; 2284:  1a
b00_a285:   lda $8c,x                   ; 2285:  b5 8c
b00_a287:   ora ($70,x)                 ; 2287:  01 70
b00_a289:   .db $bb                     ; 2289:  bb
b00_a28a:   .db $2b                     ; 228A:  2b
b00_a28b:   .db $3a                     ; 228B:  3a
b00_a28c:   sbc #$8d                    ; 228C:  e9 8d
b00_a28e:   cmp $d702,y                 ; 228E:  d9 02 d7
b00_a291:   sta $3ba2,y                 ; 2291:  99 a2 3b
b00_a294:   .db $3a                     ; 2294:  3a
b00_a295:   sbc #$28                    ; 2295:  e9 28
b00_a297:   lda ($04,x)                 ; 2297:  a1 04
b00_a299:   .db $0b                     ; 2299:  0b
b00_a29a:   .db $7c                     ; 229A:  7c
b00_a29b:   bcs $a275                   ; 229B:  b0 d8
b00_a29d:   cmp ($a2,x)                 ; 229D:  c1 a2
b00_a29f:   asl a                       ; 229F:  0a
b00_a2a0:   sty $6d2d                   ; 22A0:  8c 2d 6d
b00_a2a3:   .db $bb                     ; 22A3:  bb
b00_a2a4:   .db $d3                     ; 22A4:  d3
b00_a2a5:   and #$3b                    ; 22A5:  29 3b
b00_a2a7:   .db $3a                     ; 22A7:  3a
b00_a2a8:   sbc #$e2                    ; 22A8:  e9 e2
b00_a2aa:   lda ($04,x)                 ; 22AA:  a1 04
b00_a2ac:   .db $b3                     ; 22AC:  b3
b00_a2ad:   .db $0b                     ; 22AD:  0b
b00_a2ae:   ldy $b3,x                   ; 22AE:  b4 b3
b00_a2b0:   bcs $a26d                   ; 22B0:  b0 bb
b00_a2b2:   lda ($3b),y                 ; 22B2:  b1 3b
b00_a2b4:   .db $3a                     ; 22B4:  3a
b00_a2b5:   sbc #$1f                    ; 22B5:  e9 1f
b00_a2b7:   ldx #$04                    ; 22B7:  a2 04
b00_a2b9:   .db $b3                     ; 22B9:  b3
b00_a2ba:   .db $0b                     ; 22BA:  0b
b00_a2bb:   ror $b4,x                   ; 22BB:  76 b4
b00_a2bd:   .db $b3                     ; 22BD:  b3
b00_a2be:   bcs $a27b                   ; 22BE:  b0 bb
b00_a2c0:   lda ($0b),y                 ; 22C0:  b1 0b
b00_a2c2:   bcs $a277                   ; 22C2:  b0 b3
b00_a2c4:   .db $3b                     ; 22C4:  3b
b00_a2c5:   sbc #$a9                    ; 22C5:  e9 a9
b00_a2c7:   .db $92                     ; 22C7:  92
b00_a2c8:   .db $04                     ; 22C8:  04
b00_a2c9:   .db $3b                     ; 22C9:  3b
b00_a2ca:   sbc #$5b                    ; 22CA:  e9 5b
b00_a2cc:   lda ($02,x)                 ; 22CC:  a1 02
b00_a2ce:   .db $3a                     ; 22CE:  3a
b00_a2cf:   sbc #$36                    ; 22CF:  e9 36
b00_a2d1:   cld                         ; 22D1:  d8
b00_a2d2:   .db $02                     ; 22D2:  02
b00_a2d3:   asl a                       ; 22D3:  0a
b00_a2d4:   bne $a300                   ; 22D4:  d0 2a
b00_a2d6:   asl a                       ; 22D6:  0a
b00_a2d7:   ldx $9d                     ; 22D7:  a6 9d
b00_a2d9:   adc $d7c6                   ; 22D9:  6d c6 d7
b00_a2dc:   adc $cfa2,x                 ; 22DC:  7d a2 cf
b00_a2df:   jsr $e823                   ; 22DF:  20 23 e8
b00_a2e2:   brk                         ; 22E2:  00
b00_a2e3:   brk                         ; 22E3:  00
b00_a2e4:   sta $e964                   ; 22E4:  8d 64 e9
b00_a2e7:   .db $52                     ; 22E7:  52
b00_a2e8:   dex                         ; 22E8:  ca
b00_a2e9:   .db $02                     ; 22E9:  02
b00_a2ea:   .db $53                     ; 22EA:  53
b00_a2eb:   .db $c2                     ; 22EB:  c2
b00_a2ec:   .db $cf                     ; 22EC:  cf
b00_a2ed:   jsr $e823                   ; 22ED:  20 23 e8
b00_a2f0:   inc $3cff,x                 ; 22F0:  fe ff 3c
b00_a2f3:   sbc #$cd                    ; 22F3:  e9 cd
b00_a2f5:   .db $d7                     ; 22F5:  d7
b00_a2f6:   .db $02                     ; 22F6:  02
b00_a2f7:   .db $73                     ; 22F7:  73
b00_a2f8:   .db $2b                     ; 22F8:  2b
b00_a2f9:   .db $6b                     ; 22F9:  6b
b00_a2fa:   sbc #$52                    ; 22FA:  e9 52
b00_a2fc:   dex                         ; 22FC:  ca
b00_a2fd:   .db $02                     ; 22FD:  02
b00_a2fe:   .db $b3                     ; 22FE:  b3
b00_a2ff:   .db $0b                     ; 22FF:  0b
b00_a300:   ldy $b3,x                   ; 2300:  b4 b3
b00_a302:   .db $d3                     ; 2302:  d3
b00_a303:   .db $bb                     ; 2303:  bb
b00_a304:   .db $d4                     ; 2304:  d4
b00_a305:   adc $0b                     ; 2305:  65 0b
b00_a307:   ldy $b3,x                   ; 2307:  b4 b3
b00_a309:   .db $d3                     ; 2309:  d3
b00_a30a:   ldy $cfd4,x                 ; 230A:  bc d4 cf
b00_a30d:   jsr $e823                   ; 230D:  20 23 e8
b00_a310:   inc $40ff,x                 ; 2310:  fe ff 40
b00_a313:   dec $49,x                   ; 2313:  d6 49
b00_a315:   .db $a3                     ; 2315:  a3
b00_a316:   .db $3b                     ; 2316:  3b
b00_a317:   sbc #$ed                    ; 2317:  e9 ed
b00_a319:   ldx #$02                    ; 2319:  a2 02
b00_a31b:   .db $89                     ; 231B:  89
b00_a31c:   .db $5a                     ; 231C:  5a
b00_a31d:   ldx $63                     ; 231D:  a6 63
b00_a31f:   adc $b3bc                   ; 231F:  6d bc b3
b00_a322:   .db $0b                     ; 2322:  0b
b00_a323:   sty $6d2d                   ; 2323:  8c 2d 6d
b00_a326:   .db $bb                     ; 2326:  bb
b00_a327:   .db $d3                     ; 2327:  d3
b00_a328:   ldy $c9,x                   ; 2328:  b4 c9
b00_a32a:   cld                         ; 232A:  d8
b00_a32b:   .db $47                     ; 232B:  47
b00_a32c:   .db $a3                     ; 232C:  a3
b00_a32d:   .db $0b                     ; 232D:  0b
b00_a32e:   .db $8b                     ; 232E:  8b
b00_a32f:   .db $1a                     ; 232F:  1a
b00_a330:   lda $8c,x                   ; 2330:  b5 8c
b00_a332:   ora $bb70                   ; 2332:  0d 70 bb
b00_a335:   .db $b3                     ; 2335:  b3
b00_a336:   sta $0b5a                   ; 2336:  8d 5a 0b
b00_a339:   .db $8b                     ; 2339:  8b
b00_a33a:   .db $1a                     ; 233A:  1a
b00_a33b:   lda $8c,x                   ; 233B:  b5 8c
b00_a33d:   ora $bb70                   ; 233D:  0d 70 bb
b00_a340:   bcs $a2f5                   ; 2340:  b0 b3
b00_a342:   sbc #$0d                    ; 2342:  e9 0d
b00_a344:   .db $d7                     ; 2344:  d7
b00_a345:   .db $04                     ; 2345:  04
b00_a346:   lda ($0b),y                 ; 2346:  b1 0b
b00_a348:   bne $a375                   ; 2348:  d0 2b
b00_a34a:   .db $0b                     ; 234A:  0b
b00_a34b:   ldx $9d                     ; 234B:  a6 9d
b00_a34d:   adc $d7c6                   ; 234D:  6d c6 d7
b00_a350:   asl $a3,x                   ; 2350:  16 a3
b00_a352:   .db $63                     ; 2352:  63
b00_a353:   .db $62                     ; 2353:  62
b00_a354:   sbc #$7b                    ; 2354:  e9 7b
b00_a356:   cpy $ac04                   ; 2356:  cc 04 ac
b00_a359:   .db $77                     ; 2359:  77
b00_a35a:   dec $63,x                   ; 235A:  d6 63
b00_a35c:   .db $67                     ; 235C:  67
b00_a35d:   sbc #$7b                    ; 235D:  e9 7b
b00_a35f:   cpy $ac04                   ; 235F:  cc 04 ac
b00_a362:   .db $87                     ; 2362:  87
b00_a363:   dec $ac,x                   ; 2363:  d6 ac
b00_a365:   .db $63                     ; 2365:  63
b00_a366:   stx $ff89                   ; 2366:  8e 89 ff
b00_a369:   lda #$67                    ; 2369:  a9 67
b00_a36b:   .db $6f                     ; 236B:  6f
b00_a36c:   ldy $5f                     ; 236C:  a4 5f
b00_a36e:   adc $00d5                   ; 236E:  6d d5 00
b00_a371:   brk                         ; 2371:  00
b00_a372:   .db $04                     ; 2372:  04
b00_a373:   brk                         ; 2373:  00
b00_a374:   sta ($a3,x)                 ; 2374:  81 a3
b00_a376:   ror $85a3,x                 ; 2376:  7e a3 85
b00_a379:   .db $a3                     ; 2379:  a3
b00_a37a:   .db $8b                     ; 237A:  8b
b00_a37b:   .db $a3                     ; 237B:  a3
b00_a37c:   sta ($a3),y                 ; 237C:  91 a3
b00_a37e:   ldy $9f8c                   ; 237E:  ac 8c 9f
b00_a381:   rti                         ; 2381:  40
b00_a382:   dec $a0,x                   ; 2382:  d6 a0
b00_a384:   .db $a3                     ; 2384:  a3
b00_a385:   ldy $a066                   ; 2385:  ac 66 a0
b00_a388:   dec $81,x                   ; 2388:  d6 81
b00_a38a:   .db $a3                     ; 238A:  a3
b00_a38b:   ldy $a26f                   ; 238B:  ac 6f a2
b00_a38e:   dec $81,x                   ; 238E:  d6 81
b00_a390:   .db $a3                     ; 2390:  a3
b00_a391:   .db $62                     ; 2391:  62
b00_a392:   sbc #$e8                    ; 2392:  e9 e8
b00_a394:   bcc $a398                   ; 2394:  90 02
b00_a396:   dec $81,x                   ; 2396:  d6 81
b00_a398:   .db $a3                     ; 2398:  a3
b00_a399:   .db $3b                     ; 2399:  3b
b00_a39a:   sbc #$94                    ; 239A:  e9 94
b00_a39c:   sta ($02),y                 ; 239C:  91 02
b00_a39e:   .db $0b                     ; 239E:  0b
b00_a39f:   bne $a3cc                   ; 239F:  d0 2b
b00_a3a1:   .db $0b                     ; 23A1:  0b
b00_a3a2:   ldx $9d                     ; 23A2:  a6 9d
b00_a3a4:   adc $d7c6                   ; 23A4:  6d c6 d7
b00_a3a7:   sta $cfa3,y                 ; 23A7:  99 a3 cf
b00_a3aa:   jsr $e823                   ; 23AA:  20 23 e8
b00_a3ad:   .db $fa                     ; 23AD:  fa
b00_a3ae:   .db $ff                     ; 23AE:  ff
b00_a3af:   ldy $61                     ; 23AF:  a4 61
b00_a3b1:   .db $6f                     ; 23B1:  6f
b00_a3b2:   and #$8e                    ; 23B2:  29 8e
b00_a3b4:   .db $ff                     ; 23B4:  ff
b00_a3b5:   brk                         ; 23B5:  00
b00_a3b6:   stx $6001                   ; 23B6:  8e 01 60
b00_a3b9:   and $8d60,y                 ; 23B9:  39 60 8d
b00_a3bc:   asl $e9,x                   ; 23BC:  16 e9
b00_a3be:   rol $f2                     ; 23BE:  26 f2
b00_a3c0:   asl a                       ; 23C0:  0a
b00_a3c1:   rol a                       ; 23C1:  2a
b00_a3c2:   txa                         ; 23C2:  8a
b00_a3c3:   brk                         ; 23C3:  00
b00_a3c4:   adc ($2b,x)                 ; 23C4:  61 2b
b00_a3c6:   stx $0100                   ; 23C6:  8e 00 01
b00_a3c9:   .db $3b                     ; 23C9:  3b
b00_a3ca:   and $8d60,y                 ; 23CA:  39 60 8d
b00_a3cd:   asl $e9,x                   ; 23CD:  16 e9
b00_a3cf:   rol $f2                     ; 23CF:  26 f2
b00_a3d1:   asl a                       ; 23D1:  0a
b00_a3d2:   cmp $bb0a                   ; 23D2:  cd 0a bb
b00_a3d5:   rol a                       ; 23D5:  2a
b00_a3d6:   txa                         ; 23D6:  8a
b00_a3d7:   brk                         ; 23D7:  00
b00_a3d8:   ora ($cd,x)                 ; 23D8:  01 cd
b00_a3da:   .db $0b                     ; 23DA:  0b
b00_a3db:   .db $bb                     ; 23DB:  bb
b00_a3dc:   .db $2b                     ; 23DC:  2b
b00_a3dd:   .db $0b                     ; 23DD:  0b
b00_a3de:   sty $7000                   ; 23DE:  8c 00 70
b00_a3e1:   dec $d7                     ; 23E1:  c6 d7
b00_a3e3:   dec $a3                     ; 23E3:  c6 a3
b00_a3e5:   stx $00ff                   ; 23E5:  8e ff 00
b00_a3e8:   stx $7001                   ; 23E8:  8e 01 70
b00_a3eb:   and $8d60,y                 ; 23EB:  39 60 8d
b00_a3ee:   asl $e9,x                   ; 23EE:  16 e9
b00_a3f0:   rol $f2                     ; 23F0:  26 f2
b00_a3f2:   asl a                       ; 23F2:  0a
b00_a3f3:   cmp $bb0a                   ; 23F3:  cd 0a bb
b00_a3f6:   rol a                       ; 23F6:  2a
b00_a3f7:   txa                         ; 23F7:  8a
b00_a3f8:   brk                         ; 23F8:  00
b00_a3f9:   adc ($2b),y                 ; 23F9:  71 2b
b00_a3fb:   stx $0100                   ; 23FB:  8e 00 01
b00_a3fe:   .db $3b                     ; 23FE:  3b
b00_a3ff:   and $8d60,y                 ; 23FF:  39 60 8d
b00_a402:   asl $e9,x                   ; 2402:  16 e9
b00_a404:   rol $f2                     ; 2404:  26 f2
b00_a406:   asl a                       ; 2406:  0a
b00_a407:   cmp $bb0a                   ; 2407:  cd 0a bb
b00_a40a:   rol a                       ; 240A:  2a
b00_a40b:   txa                         ; 240B:  8a
b00_a40c:   brk                         ; 240C:  00
b00_a40d:   ora ($cd,x)                 ; 240D:  01 cd
b00_a40f:   .db $0b                     ; 240F:  0b
b00_a410:   .db $bb                     ; 2410:  bb
b00_a411:   .db $2b                     ; 2411:  2b
b00_a412:   .db $0b                     ; 2412:  0b
b00_a413:   sty $7f00                   ; 2413:  8c 00 7f
b00_a416:   dec $d7                     ; 2416:  c6 d7
b00_a418:   .db $fb                     ; 2418:  fb
b00_a419:   .db $a3                     ; 2419:  a3
b00_a41a:   stx $81eb                   ; 241A:  8e eb 81
b00_a41d:   stx $7f00                   ; 241D:  8e 00 7f
b00_a420:   and $8d60,y                 ; 2420:  39 60 8d
b00_a423:   asl $e9,x                   ; 2423:  16 e9
b00_a425:   rol $f2                     ; 2425:  26 f2
b00_a427:   asl a                       ; 2427:  0a
b00_a428:   cmp $bb0a                   ; 2428:  cd 0a bb
b00_a42b:   rol a                       ; 242B:  2a
b00_a42c:   asl a                       ; 242C:  0a
b00_a42d:   tay                         ; 242D:  a8
b00_a42e:   .db $eb                     ; 242E:  eb
b00_a42f:   .db $7f                     ; 242F:  7f
b00_a430:   stx $bf17                   ; 2430:  8e 17 bf
b00_a433:   stx $7fed                   ; 2433:  8e ed 7f
b00_a436:   sbc #$d9                    ; 2436:  e9 d9
b00_a438:   dex                         ; 2438:  ca
b00_a439:   .db $04                     ; 2439:  04
b00_a43a:   rts                         ; 243A:  60
b00_a43b:   sbc #$a4                    ; 243B:  e9 a4
b00_a43d:   .db $cb                     ; 243D:  cb
b00_a43e:   .db $02                     ; 243E:  02
b00_a43f:   rti                         ; 243F:  40
b00_a440:   tay                         ; 2440:  a8
b00_a441:   adc ($6f,x)                 ; 2441:  61 6f
b00_a443:   stx $bf1c                   ; 2443:  8e 1c bf
b00_a446:   sbc #$26                    ; 2446:  e9 26
b00_a448:   .db $d3                     ; 2448:  d3
b00_a449:   .db $02                     ; 2449:  02
b00_a44a:   stx $bf1d                   ; 244A:  8e 1d bf
b00_a44d:   sbc #$c4                    ; 244D:  e9 c4
b00_a44f:   dec $ac02                   ; 244F:  ce 02 ac
b00_a452:   ror $d7                     ; 2452:  66 d7
b00_a454:   .db $cf                     ; 2454:  cf
b00_a455:   jsr $e823                   ; 2455:  20 23 e8
b00_a458:   sed                         ; 2458:  f8
b00_a459:   .db $ff                     ; 2459:  ff
b00_a45a:   eor ($a8,x)                 ; 245A:  41 a8
b00_a45c:   .db $d3                     ; 245C:  d3
b00_a45d:   .db $7f                     ; 245D:  7f
b00_a45e:   ldy $cd20                   ; 245E:  ac 20 cd
b00_a461:   ldy $48                     ; 2461:  a4 48
b00_a463:   ror $c051                   ; 2463:  6e 51 c0
b00_a466:   cld                         ; 2466:  d8
b00_a467:   .db $73                     ; 2467:  73
b00_a468:   ldy $ac                     ; 2468:  a4 ac
b00_a46a:   .db $ab                     ; 246A:  ab
b00_a46b:   sta $a842,y                 ; 246B:  99 42 a8
b00_a46e:   pha                         ; 246E:  48
b00_a46f:   ror $d4d6                   ; 246F:  6e d6 d4
b00_a472:   lda $ac                     ; 2472:  a5 ac
b00_a474:   sty $e6,x                   ; 2474:  94 e6
b00_a476:   ldy $61                     ; 2476:  a4 61
b00_a478:   .db $6f                     ; 2478:  6f
b00_a479:   cld                         ; 2479:  d8
b00_a47a:   .db $7f                     ; 247A:  7f
b00_a47b:   ldy $ac                     ; 247B:  a4 ac
b00_a47d:   tax                         ; 247D:  aa
b00_a47e:   .db $a3                     ; 247E:  a3
b00_a47f:   ldy $5f                     ; 247F:  a4 5f
b00_a481:   adc $a8d0                   ; 2481:  6d d0 a8
b00_a484:   .db $5f                     ; 2484:  5f
b00_a485:   adc $da53                   ; 2485:  6d 53 da
b00_a488:   tay                         ; 2488:  a8
b00_a489:   .db $5f                     ; 2489:  5f
b00_a48a:   adc $98d7                   ; 248A:  6d d7 98
b00_a48d:   ldy $a4                     ; 248D:  a4 a4
b00_a48f:   .db $9f                     ; 248F:  9f
b00_a490:   adc $a8d0                   ; 2490:  6d d0 a8
b00_a493:   .db $9f                     ; 2493:  9f
b00_a494:   adc $4aac                   ; 2494:  6d ac 4a
b00_a497:   .db $92                     ; 2497:  92
b00_a498:   ldy $a30d                   ; 2498:  ac 0d a3
b00_a49b:   rti                         ; 249B:  40
b00_a49c:   dec $ae,x                   ; 249C:  d6 ae
b00_a49e:   ldy $39                     ; 249E:  a4 39
b00_a4a0:   sbc #$36                    ; 24A0:  e9 36
b00_a4a2:   cld                         ; 24A2:  d8
b00_a4a3:   .db $02                     ; 24A3:  02
b00_a4a4:   ora #$8c                    ; 24A4:  09 8c
b00_a4a6:   .db $d4                     ; 24A6:  d4
b00_a4a7:   adc $b3bb                   ; 24A7:  6d bb b3
b00_a4aa:   rti                         ; 24AA:  40
b00_a4ab:   .db $d4                     ; 24AB:  d4
b00_a4ac:   ora #$d0                    ; 24AC:  09 d0
b00_a4ae:   and #$09                    ; 24AE:  29 09
b00_a4b0:   ldx $9d                     ; 24B0:  a6 9d
b00_a4b2:   adc $d7c6                   ; 24B2:  6d c6 d7
b00_a4b5:   .db $9f                     ; 24B5:  9f
b00_a4b6:   ldy $a5                     ; 24B6:  a4 a5
b00_a4b8:   lda ($6d,x)                 ; 24B8:  a1 6d
b00_a4ba:   sty $0080                   ; 24BA:  8c 80 00
b00_a4bd:   .db $da                     ; 24BD:  da
b00_a4be:   cld                         ; 24BE:  d8
b00_a4bf:   .db $c2                     ; 24BF:  c2
b00_a4c0:   ldy $cf                     ; 24C0:  a4 cf
b00_a4c2:   rti                         ; 24C2:  40
b00_a4c3:   tay                         ; 24C3:  a8
b00_a4c4:   .db $7b                     ; 24C4:  7b
b00_a4c5:   .db $6f                     ; 24C5:  6f
b00_a4c6:   ldy $5f                     ; 24C6:  a4 5f
b00_a4c8:   adc $c051                   ; 24C8:  6d 51 c0
b00_a4cb:   cld                         ; 24CB:  d8
b00_a4cc:   dec $62a4,x                 ; 24CC:  de a4 62
b00_a4cf:   sbc #$52                    ; 24CF:  e9 52
b00_a4d1:   dex                         ; 24D1:  ca
b00_a4d2:   .db $02                     ; 24D2:  02
b00_a4d3:   cld                         ; 24D3:  d8
b00_a4d4:   dec $41a4,x                 ; 24D4:  de a4 41
b00_a4d7:   tay                         ; 24D7:  a8
b00_a4d8:   .db $7b                     ; 24D8:  7b
b00_a4d9:   .db $6f                     ; 24D9:  6f
b00_a4da:   txa                         ; 24DA:  8a
b00_a4db:   .db $b3                     ; 24DB:  b3
b00_a4dc:   .db $9c                     ; 24DC:  9c
b00_a4dd:   .db $2b                     ; 24DD:  2b
b00_a4de:   ldy $7b                     ; 24DE:  a4 7b
b00_a4e0:   .db $6f                     ; 24E0:  6f
b00_a4e1:   .db $d7                     ; 24E1:  d7
b00_a4e2:   inc $64a4,x                 ; 24E2:  fe a4 64
b00_a4e5:   sbc #$52                    ; 24E5:  e9 52
b00_a4e7:   dex                         ; 24E7:  ca
b00_a4e8:   .db $02                     ; 24E8:  02
b00_a4e9:   .db $d7                     ; 24E9:  d7
b00_a4ea:   inc $a4,x                   ; 24EA:  f6 a4
b00_a4ec:   .db $42                     ; 24EC:  42
b00_a4ed:   tay                         ; 24ED:  a8
b00_a4ee:   .db $7b                     ; 24EE:  7b
b00_a4ef:   .db $6f                     ; 24EF:  6f
b00_a4f0:   txa                         ; 24F0:  8a
b00_a4f1:   brk                         ; 24F1:  00
b00_a4f2:   sta $fdd6,x                 ; 24F2:  9d d6 fd
b00_a4f5:   ldy $43                     ; 24F5:  a4 43
b00_a4f7:   tay                         ; 24F7:  a8
b00_a4f8:   .db $7b                     ; 24F8:  7b
b00_a4f9:   .db $6f                     ; 24F9:  6f
b00_a4fa:   txa                         ; 24FA:  8a
b00_a4fb:   cmp $2b9e,y                 ; 24FB:  d9 9e 2b
b00_a4fe:   rti                         ; 24FE:  40
b00_a4ff:   and #$40                    ; 24FF:  29 40
b00_a501:   plp                         ; 2501:  28
b00_a502:   dec $34,x                   ; 2502:  d6 34
b00_a504:   lda $39                     ; 2504:  a5 39
b00_a506:   sbc #$99                    ; 2506:  e9 99
b00_a508:   cmp $d702,y                 ; 2508:  d9 02 d7
b00_a50b:   and ($a5),y                 ; 250B:  31 a5
b00_a50d:   ldy $7b                     ; 250D:  a4 7b
b00_a50f:   .db $6f                     ; 250F:  6f
b00_a510:   .db $53                     ; 2510:  53
b00_a511:   cmp ($d8,x)                 ; 2511:  c1 d8
b00_a513:   jsr $8da5                   ; 2513:  20 a5 8d
b00_a516:   plp                         ; 2516:  28
b00_a517:   sbc #$52                    ; 2517:  e9 52
b00_a519:   dex                         ; 2519:  ca
b00_a51a:   .db $02                     ; 251A:  02
b00_a51b:   .db $53                     ; 251B:  53
b00_a51c:   .db $c2                     ; 251C:  c2
b00_a51d:   dec $23,x                   ; 251D:  d6 23
b00_a51f:   lda $ac                     ; 251F:  a5 ac
b00_a521:   .db $df                     ; 2521:  df
b00_a522:   ldx #$d8                    ; 2522:  a2 d8
b00_a524:   and ($a5),y                 ; 2524:  31 a5
b00_a526:   php                         ; 2526:  08
b00_a527:   bne $a551                   ; 2527:  d0 28
b00_a529:   cmp ($8c),y                 ; 2529:  d1 8c
b00_a52b:   lda $bb7b                   ; 252B:  ad 7b bb
b00_a52e:   .db $b3                     ; 252E:  b3
b00_a52f:   ora #$d4                    ; 252F:  09 d4
b00_a531:   ora #$d0                    ; 2531:  09 d0
b00_a533:   and #$09                    ; 2533:  29 09
b00_a535:   ldx $9d                     ; 2535:  a6 9d
b00_a537:   adc $d7c6                   ; 2537:  6d c6 d7
b00_a53a:   ora $a5                     ; 253A:  05 a5
b00_a53c:   php                         ; 253C:  08
b00_a53d:   sty $7bad                   ; 253D:  8c ad 7b
b00_a540:   .db $bb                     ; 2540:  bb
b00_a541:   .db $b3                     ; 2541:  b3
b00_a542:   .db $89                     ; 2542:  89
b00_a543:   .db $ff                     ; 2543:  ff
b00_a544:   .db $d4                     ; 2544:  d4
b00_a545:   php                         ; 2545:  08
b00_a546:   cld                         ; 2546:  d8
b00_a547:   .db $5b                     ; 2547:  5b
b00_a548:   lda $aa                     ; 2548:  a5 aa
b00_a54a:   .db $7b                     ; 254A:  7b
b00_a54b:   .db $6f                     ; 254B:  6f
b00_a54c:   sbc #$b1                    ; 254C:  e9 b1
b00_a54e:   sty $02,x                   ; 254E:  94 02
b00_a550:   .db $0b                     ; 2550:  0b
b00_a551:   cmp $48a4,x                 ; 2551:  dd a4 48
b00_a554:   ror $c051                   ; 2554:  6e 51 c0
b00_a557:   cld                         ; 2557:  d8
b00_a558:   .db $5b                     ; 2558:  5b
b00_a559:   lda $cf                     ; 2559:  a5 cf
b00_a55b:   rti                         ; 255B:  40
b00_a55c:   dec $cb,x                   ; 255C:  d6 cb
b00_a55e:   lda $39                     ; 255E:  a5 39
b00_a560:   sbc #$cd                    ; 2560:  e9 cd
b00_a562:   .db $d7                     ; 2562:  d7
b00_a563:   .db $02                     ; 2563:  02
b00_a564:   rol a                       ; 2564:  2a
b00_a565:   asl a                       ; 2565:  0a
b00_a566:   bne $a53b                   ; 2566:  d0 d3
b00_a568:   .db $8b                     ; 2568:  8b
b00_a569:   .db $63                     ; 2569:  63
b00_a56a:   cpy $d7                     ; 256A:  c4 d7
b00_a56c:   cmp #$a5                    ; 256C:  c9 a5
b00_a56e:   and $72e9,y                 ; 256E:  39 e9 72
b00_a571:   .db $d7                     ; 2571:  d7
b00_a572:   .db $02                     ; 2572:  02
b00_a573:   sty $6d67                   ; 2573:  8c 67 6d
b00_a576:   .db $bb                     ; 2576:  bb
b00_a577:   .db $d3                     ; 2577:  d3
b00_a578:   .db $d7                     ; 2578:  d7
b00_a579:   cmp #$a5                    ; 2579:  c9 a5
b00_a57b:   ora #$8c                    ; 257B:  09 8c
b00_a57d:   .db $d4                     ; 257D:  d4
b00_a57e:   adc $b3bb                   ; 257E:  6d bb b3
b00_a581:   ora #$8c                    ; 2581:  09 8c
b00_a583:   .db $d4                     ; 2583:  d4
b00_a584:   adc $d3bb                   ; 2584:  6d bb d3
b00_a587:   .db $b3                     ; 2587:  b3
b00_a588:   asl a                       ; 2588:  0a
b00_a589:   bne $a55e                   ; 2589:  d0 d3
b00_a58b:   .db $b3                     ; 258B:  b3
b00_a58c:   .db $89                     ; 258C:  89
b00_a58d:   .db $64                     ; 258D:  64
b00_a58e:   ldy $bc,x                   ; 258E:  b4 bc
b00_a590:   .db $b3                     ; 2590:  b3
b00_a591:   stx $0190                   ; 2591:  8e 90 01
b00_a594:   sbc #$52                    ; 2594:  e9 52
b00_a596:   dex                         ; 2596:  ca
b00_a597:   .db $02                     ; 2597:  02
b00_a598:   ldy $c2,x                   ; 2598:  b4 c2
b00_a59a:   ldy $db,x                   ; 259A:  b4 db
b00_a59c:   .db $d4                     ; 259C:  d4
b00_a59d:   ora #$a8                    ; 259D:  09 a8
b00_a59f:   .db $5f                     ; 259F:  5f
b00_a5a0:   .db $6f                     ; 25A0:  6f
b00_a5a1:   and $72e9,y                 ; 25A1:  39 e9 72
b00_a5a4:   cmp $d802,y                 ; 25A4:  d9 02 d8
b00_a5a7:   cmp #$a5                    ; 25A7:  c9 a5
b00_a5a9:   ldy $8c1e                   ; 25A9:  ac 1e 8c
b00_a5ac:   cld                         ; 25AC:  d8
b00_a5ad:   cmp #$a5                    ; 25AD:  c9 a5
b00_a5af:   and $72e9,y                 ; 25AF:  39 e9 72
b00_a5b2:   .db $d7                     ; 25B2:  d7
b00_a5b3:   .db $02                     ; 25B3:  02
b00_a5b4:   eor $8cb5,y                 ; 25B4:  59 b5 8c
b00_a5b7:   tay                         ; 25B7:  a8
b00_a5b8:   .db $77                     ; 25B8:  77
b00_a5b9:   .db $bb                     ; 25B9:  bb
b00_a5ba:   .db $b3                     ; 25BA:  b3
b00_a5bb:   sbc #$26                    ; 25BB:  e9 26
b00_a5bd:   .db $d3                     ; 25BD:  d3
b00_a5be:   .db $02                     ; 25BE:  02
b00_a5bf:   stx $bf31                   ; 25BF:  8e 31 bf
b00_a5c2:   sbc #$c4                    ; 25C2:  e9 c4
b00_a5c4:   dec $ac02                   ; 25C4:  ce 02 ac
b00_a5c7:   ror $d7                     ; 25C7:  66 d7
b00_a5c9:   ora #$d0                    ; 25C9:  09 d0
b00_a5cb:   and #$09                    ; 25CB:  29 09
b00_a5cd:   ldx $9d                     ; 25CD:  a6 9d
b00_a5cf:   adc $d7c6                   ; 25CF:  6d c6 d7
b00_a5d2:   .db $5f                     ; 25D2:  5f
b00_a5d3:   lda $cf                     ; 25D3:  a5 cf
b00_a5d5:   jsr $e823                   ; 25D5:  20 23 e8
b00_a5d8:   brk                         ; 25D8:  00
b00_a5d9:   brk                         ; 25D9:  00
b00_a5da:   ldy $63                     ; 25DA:  a4 63
b00_a5dc:   adc $5ad0                   ; 25DC:  6d d0 5a
b00_a5df:   lda $b3,x                   ; 25DF:  b5 b3
b00_a5e1:   sbc #$52                    ; 25E1:  e9 52
b00_a5e3:   dex                         ; 25E3:  ca
b00_a5e4:   .db $02                     ; 25E4:  02
b00_a5e5:   .db $cf                     ; 25E5:  cf
b00_a5e6:   jsr $e823                   ; 25E6:  20 23 e8
b00_a5e9:   .db $f2                     ; 25E9:  f2
b00_a5ea:   .db $ff                     ; 25EA:  ff
b00_a5eb:   ldy $63                     ; 25EB:  a4 63
b00_a5ed:   .db $6f                     ; 25ED:  6f
b00_a5ee:   .db $8b                     ; 25EE:  8b
b00_a5ef:   .db $1a                     ; 25EF:  1a
b00_a5f0:   lda $8c,x                   ; 25F0:  b5 8c
b00_a5f2:   ora ($70,x)                 ; 25F2:  01 70
b00_a5f4:   .db $bb                     ; 25F4:  bb
b00_a5f5:   and $78                     ; 25F5:  25 78
b00_a5f7:   rol a                       ; 25F7:  2a
b00_a5f8:   ora $8f                     ; 25F8:  05 8f
b00_a5fa:   bpl $a625                   ; 25FA:  10 29
b00_a5fc:   .db $0c                     ; 25FC:  0c
b00_a5fd:   cld                         ; 25FD:  d8
b00_a5fe:   stx $a6                     ; 25FE:  86 a6
b00_a600:   asl a                       ; 2600:  0a
b00_a601:   bcs $a653                   ; 2601:  b0 50
b00_a603:   .db $c3                     ; 2603:  c3
b00_a604:   cld                         ; 2604:  d8
b00_a605:   asl $a6,x                   ; 2605:  16 a6
b00_a607:   .db $3a                     ; 2607:  3a
b00_a608:   ora #$b0                    ; 2608:  09 b0
b00_a60a:   .db $52                     ; 260A:  52
b00_a60b:   ldx $b1,y                   ; 260B:  b6 b1
b00_a60d:   asl a                       ; 260D:  0a
b00_a60e:   bcs $a5c3                   ; 260E:  b0 b3
b00_a610:   ora #$b4                    ; 2610:  09 b4
b00_a612:   .db $b3                     ; 2612:  b3
b00_a613:   bcs $a5d1                   ; 2613:  b0 bc
b00_a615:   lda ($09),y                 ; 2615:  b1 09
b00_a617:   bcs $a669                   ; 2617:  b0 50
b00_a619:   .db $c3                     ; 2619:  c3
b00_a61a:   cld                         ; 261A:  d8
b00_a61b:   bit $39a6                   ; 261B:  2c a6 39
b00_a61e:   asl a                       ; 261E:  0a
b00_a61f:   bcs $a673                   ; 261F:  b0 52
b00_a621:   ldx $b1,y                   ; 2621:  b6 b1
b00_a623:   ora #$b0                    ; 2623:  09 b0
b00_a625:   .db $b3                     ; 2625:  b3
b00_a626:   asl a                       ; 2626:  0a
b00_a627:   ldy $b3,x                   ; 2627:  b4 b3
b00_a629:   bcs $a5e7                   ; 2629:  b0 bc
b00_a62b:   lda ($aa),y                 ; 262B:  b1 aa
b00_a62d:   .db $63                     ; 262D:  63
b00_a62e:   adc $52e9                   ; 262E:  6d e9 52
b00_a631:   dex                         ; 2631:  ca
b00_a632:   .db $02                     ; 2632:  02
b00_a633:   .db $8f                     ; 2633:  8f
b00_a634:   lsr $b3                     ; 2634:  46 b3
b00_a636:   tax                         ; 2636:  aa
b00_a637:   .db $63                     ; 2637:  63
b00_a638:   .db $6f                     ; 2638:  6f
b00_a639:   sbc #$da                    ; 2639:  e9 da
b00_a63b:   .db $d7                     ; 263B:  d7
b00_a63c:   .db $02                     ; 263C:  02
b00_a63d:   .db $74                     ; 263D:  74
b00_a63e:   .db $d3                     ; 263E:  d3
b00_a63f:   ldy $c2,x                   ; 263F:  b4 c2
b00_a641:   cld                         ; 2641:  d8
b00_a642:   adc ($a6,x)                 ; 2642:  61 a6
b00_a644:   sta $e932                   ; 2644:  8d 32 e9
b00_a647:   .db $52                     ; 2647:  52
b00_a648:   dex                         ; 2648:  ca
b00_a649:   .db $02                     ; 2649:  02
b00_a64a:   .db $b3                     ; 264A:  b3
b00_a64b:   ora #$b0                    ; 264B:  09 b0
b00_a64d:   .db $b3                     ; 264D:  b3
b00_a64e:   sbc #$0d                    ; 264E:  e9 0d
b00_a650:   .db $d7                     ; 2650:  d7
b00_a651:   .db $04                     ; 2651:  04
b00_a652:   .db $2b                     ; 2652:  2b
b00_a653:   .db $b3                     ; 2653:  b3
b00_a654:   asl a                       ; 2654:  0a
b00_a655:   ldy $b3,x                   ; 2655:  b4 b3
b00_a657:   bcs $a614                   ; 2657:  b0 bb
b00_a659:   lda ($3b),y                 ; 2659:  b1 3b
b00_a65b:   ora #$b4                    ; 265B:  09 b4
b00_a65d:   .db $b3                     ; 265D:  b3
b00_a65e:   bcs $a61c                   ; 265E:  b0 bc
b00_a660:   lda ($0a),y                 ; 2660:  b1 0a
b00_a662:   bcs $a60c                   ; 2662:  b0 a8
b00_a664:   sta ($6f,x)                 ; 2664:  81 6f
b00_a666:   ora $76                     ; 2666:  05 76
b00_a668:   and #$8d                    ; 2668:  29 8d
b00_a66a:   .db $1f                     ; 266A:  1f
b00_a66b:   sbc #$52                    ; 266B:  e9 52
b00_a66d:   dex                         ; 266D:  ca
b00_a66e:   .db $02                     ; 266E:  02
b00_a66f:   .db $8f                     ; 266F:  8f
b00_a670:   .db $32                     ; 2670:  32
b00_a671:   .db $b3                     ; 2671:  b3
b00_a672:   ora #$b0                    ; 2672:  09 b0
b00_a674:   .db $b3                     ; 2674:  b3
b00_a675:   sbc #$0d                    ; 2675:  e9 0d
b00_a677:   .db $d7                     ; 2677:  d7
b00_a678:   .db $04                     ; 2678:  04
b00_a679:   tay                         ; 2679:  a8
b00_a67a:   .db $7f                     ; 267A:  7f
b00_a67b:   .db $6f                     ; 267B:  6f
b00_a67c:   .db $b3                     ; 267C:  b3
b00_a67d:   ora #$b4                    ; 267D:  09 b4
b00_a67f:   .db $b3                     ; 267F:  b3
b00_a680:   bcs $a63e                   ; 2680:  b0 bc
b00_a682:   lda ($d6),y                 ; 2682:  b1 d6
b00_a684:   clv                         ; 2684:  b8
b00_a685:   ldx $09                     ; 2685:  a6 09
b00_a687:   bcs $a614                   ; 2687:  b0 8b
b00_a689:   .db $14                     ; 2689:  14
b00_a68a:   cpy $d8                     ; 268A:  c4 d8
b00_a68c:   .db $ab                     ; 268C:  ab
b00_a68d:   ldx $8d                     ; 268D:  a6 8d
b00_a68f:   lsr $e9                     ; 268F:  46 e9
b00_a691:   .db $52                     ; 2691:  52
b00_a692:   dex                         ; 2692:  ca
b00_a693:   .db $02                     ; 2693:  02
b00_a694:   .db $8f                     ; 2694:  8f
b00_a695:   .db $14                     ; 2695:  14
b00_a696:   .db $b3                     ; 2696:  b3
b00_a697:   ora #$b0                    ; 2697:  09 b0
b00_a699:   .db $b3                     ; 2699:  b3
b00_a69a:   sbc #$0d                    ; 269A:  e9 0d
b00_a69c:   .db $d7                     ; 269C:  d7
b00_a69d:   .db $04                     ; 269D:  04
b00_a69e:   tay                         ; 269E:  a8
b00_a69f:   sta ($6f,x)                 ; 269F:  81 6f
b00_a6a1:   .db $b3                     ; 26A1:  b3
b00_a6a2:   ora #$b4                    ; 26A2:  09 b4
b00_a6a4:   .db $b3                     ; 26A4:  b3
b00_a6a5:   bcs $a663                   ; 26A5:  b0 bc
b00_a6a7:   lda ($d6),y                 ; 26A7:  b1 d6
b00_a6a9:   ror $a6                     ; 26A9:  66 a6
b00_a6ab:   ror a                       ; 26AB:  6a
b00_a6ac:   sbc #$52                    ; 26AC:  e9 52
b00_a6ae:   dex                         ; 26AE:  ca
b00_a6af:   .db $02                     ; 26AF:  02
b00_a6b0:   .db $8f                     ; 26B0:  8f
b00_a6b1:   ora $81a8,y                 ; 26B1:  19 a8 81
b00_a6b4:   .db $6f                     ; 26B4:  6f
b00_a6b5:   tay                         ; 26B5:  a8
b00_a6b6:   .db $7f                     ; 26B6:  7f
b00_a6b7:   .db $6f                     ; 26B7:  6f
b00_a6b8:   rti                         ; 26B8:  40
b00_a6b9:   tay                         ; 26B9:  a8
b00_a6ba:   adc $0c6f,x                 ; 26BA:  7d 6f 0c
b00_a6bd:   cld                         ; 26BD:  d8
b00_a6be:   cmp $a6                     ; 26BE:  c5 a6
b00_a6c0:   .db $89                     ; 26C0:  89
b00_a6c1:   rti                         ; 26C1:  40
b00_a6c2:   dec $c7,x                   ; 26C2:  d6 c7
b00_a6c4:   ldx $89                     ; 26C4:  a6 89
b00_a6c6:   jsr $a5cd                   ; 26C6:  20 cd a5
b00_a6c9:   lda ($6d,x)                 ; 26C9:  a1 6d
b00_a6cb:   .db $db                     ; 26CB:  db
b00_a6cc:   lda #$a1                    ; 26CC:  a9 a1
b00_a6ce:   adc $a940                   ; 26CE:  6d 40 a9
b00_a6d1:   adc $6f                     ; 26D1:  65 6f
b00_a6d3:   txa                         ; 26D3:  8a
b00_a6d4:   ora $75,x                   ; 26D4:  15 75
b00_a6d6:   plp                         ; 26D6:  28
b00_a6d7:   ora $27                     ; 26D7:  05 27
b00_a6d9:   rti                         ; 26D9:  40
b00_a6da:   rol $d6                     ; 26DA:  26 d6
b00_a6dc:   inc $38a6,x                 ; 26DC:  fe a6 38
b00_a6df:   sta $e914                   ; 26DF:  8d 14 e9
b00_a6e2:   .db $52                     ; 26E2:  52
b00_a6e3:   dex                         ; 26E3:  ca
b00_a6e4:   .db $02                     ; 26E4:  02
b00_a6e5:   .db $8f                     ; 26E5:  8f
b00_a6e6:   plp                         ; 26E6:  28
b00_a6e7:   .db $b3                     ; 26E7:  b3
b00_a6e8:   .db $07                     ; 26E8:  07
b00_a6e9:   bcs $a69e                   ; 26E9:  b0 b3
b00_a6eb:   sbc #$0d                    ; 26EB:  e9 0d
b00_a6ed:   .db $d7                     ; 26ED:  d7
b00_a6ee:   .db $04                     ; 26EE:  04
b00_a6ef:   lda ($08),y                 ; 26EF:  b1 08
b00_a6f1:   .db $72                     ; 26F1:  72
b00_a6f2:   plp                         ; 26F2:  28
b00_a6f3:   .db $8f                     ; 26F3:  8f
b00_a6f4:   inc $7207,x                 ; 26F4:  fe 07 72
b00_a6f7:   .db $27                     ; 26F7:  27
b00_a6f8:   .db $8f                     ; 26F8:  8f
b00_a6f9:   inc $d006,x                 ; 26F9:  fe 06 d0
b00_a6fc:   rol $d1                     ; 26FC:  26 d1
b00_a6fe:   asl $58                     ; 26FE:  06 58
b00_a700:   dec $d7                     ; 2700:  c6 d7
b00_a702:   dec $08a6,x                 ; 2702:  de a6 08
b00_a705:   .db $72                     ; 2705:  72
b00_a706:   plp                         ; 2706:  28
b00_a707:   .db $8f                     ; 2707:  8f
b00_a708:   inc $a4b3,x                 ; 2708:  fe b3 a4
b00_a70b:   sta ($6f,x)                 ; 270B:  81 6f
b00_a70d:   lda ($08),y                 ; 270D:  b1 08
b00_a70f:   .db $72                     ; 270F:  72
b00_a710:   plp                         ; 2710:  28
b00_a711:   .db $8f                     ; 2711:  8f
b00_a712:   inc $05b3,x                 ; 2712:  fe b3 05
b00_a715:   .db $8f                     ; 2715:  8f
b00_a716:   .db $12                     ; 2716:  12
b00_a717:   bcs $a6cc                   ; 2717:  b0 b3
b00_a719:   ora $8f                     ; 2719:  05 8f
b00_a71b:   clc                         ; 271B:  18
b00_a71c:   bcs $a6d2                   ; 271C:  b0 b4
b00_a71e:   ldy $08b1,x                 ; 271E:  bc b1 08
b00_a721:   .db $72                     ; 2721:  72
b00_a722:   plp                         ; 2722:  28
b00_a723:   .db $8f                     ; 2723:  8f
b00_a724:   inc $acb3,x                 ; 2724:  fe b3 ac
b00_a727:   cmp $a5,x                   ; 2727:  d5 a5
b00_a729:   lda ($38),y                 ; 2729:  b1 38
b00_a72b:   ldy $a5d5                   ; 272B:  ac d5 a5
b00_a72e:   lda ($05),y                 ; 272E:  b1 05
b00_a730:   .db $7c                     ; 2730:  7c
b00_a731:   bcs $a6e6                   ; 2731:  b0 b3
b00_a733:   ora $8f                     ; 2733:  05 8f
b00_a735:   clc                         ; 2735:  18
b00_a736:   bcs $a6ec                   ; 2736:  b0 b4
b00_a738:   ldy $21a8,x                 ; 2738:  bc a8 21
b00_a73b:   adc $89,x                   ; 273B:  75 89
b00_a73d:   .db $32                     ; 273D:  32
b00_a73e:   tay                         ; 273E:  a8
b00_a73f:   .db $5f                     ; 273F:  5f
b00_a740:   .db $6f                     ; 2740:  6f
b00_a741:   .db $cf                     ; 2741:  cf
b00_a742:   jsr $e823                   ; 2742:  20 23 e8
b00_a745:   inc $40ff,x                 ; 2745:  fe ff 40
b00_a748:   dec $6e,x                   ; 2748:  d6 6e
b00_a74a:   .db $a7                     ; 274A:  a7
b00_a74b:   .db $3b                     ; 274B:  3b
b00_a74c:   sbc #$36                    ; 274C:  e9 36
b00_a74e:   cld                         ; 274E:  d8
b00_a74f:   .db $02                     ; 274F:  02
b00_a750:   tax                         ; 2750:  aa
b00_a751:   sta $e96d,x                 ; 2751:  9d 6d e9
b00_a754:   .db $52                     ; 2754:  52
b00_a755:   dex                         ; 2755:  ca
b00_a756:   .db $02                     ; 2756:  02
b00_a757:   sty $6f1b                   ; 2757:  8c 1b 6f
b00_a75a:   .db $bb                     ; 275A:  bb
b00_a75b:   .db $b3                     ; 275B:  b3
b00_a75c:   tax                         ; 275C:  aa
b00_a75d:   sta $e96d,x                 ; 275D:  9d 6d e9
b00_a760:   .db $52                     ; 2760:  52
b00_a761:   dex                         ; 2761:  ca
b00_a762:   .db $02                     ; 2762:  02
b00_a763:   sty $6f1b                   ; 2763:  8c 1b 6f
b00_a766:   .db $bb                     ; 2766:  bb
b00_a767:   .db $b3                     ; 2767:  b3
b00_a768:   sbc #$80                    ; 2768:  e9 80
b00_a76a:   .db $cb                     ; 276A:  cb
b00_a76b:   .db $04                     ; 276B:  04
b00_a76c:   .db $0b                     ; 276C:  0b
b00_a76d:   bne $a79a                   ; 276D:  d0 2b
b00_a76f:   .db $0b                     ; 276F:  0b
b00_a770:   ldx $9d                     ; 2770:  a6 9d
b00_a772:   adc $d7c6                   ; 2772:  6d c6 d7
b00_a775:   .db $4b                     ; 2775:  4b
b00_a776:   .db $a7                     ; 2776:  a7
b00_a777:   .db $cf                     ; 2777:  cf
b00_a778:   jsr $e823                   ; 2778:  20 23 e8
b00_a77b:   brk                         ; 277B:  00
b00_a77c:   brk                         ; 277C:  00
b00_a77d:   ldy $89a3                   ; 277D:  ac a3 89
b00_a780:   adc ($e9,x)                 ; 2780:  61 e9
b00_a782:   .db $03                     ; 2782:  03
b00_a783:   dex                         ; 2783:  ca
b00_a784:   .db $02                     ; 2784:  02
b00_a785:   rti                         ; 2785:  40
b00_a786:   tay                         ; 2786:  a8
b00_a787:   adc $ac6f,y                 ; 2787:  79 6f ac
b00_a78a:   eor $a4,x                   ; 278A:  55 a4
b00_a78c:   ldy $48                     ; 278C:  a4 48
b00_a78e:   ror $c051                   ; 278E:  6e 51 c0
b00_a791:   cld                         ; 2791:  d8
b00_a792:   bcs $a73b                   ; 2792:  b0 a7
b00_a794:   .db $89                     ; 2794:  89
b00_a795:   .db $ff                     ; 2795:  ff
b00_a796:   lda #$67                    ; 2796:  a9 67
b00_a798:   .db $6f                     ; 2798:  6f
b00_a799:   .db $62                     ; 2799:  62
b00_a79a:   sbc #$b1                    ; 279A:  e9 b1
b00_a79c:   .db $cb                     ; 279C:  cb
b00_a79d:   .db $02                     ; 279D:  02
b00_a79e:   lda $a1                     ; 279E:  a5 a1
b00_a7a0:   adc $808c                   ; 27A0:  6d 8c 80
b00_a7a3:   brk                         ; 27A3:  00
b00_a7a4:   .db $da                     ; 27A4:  da
b00_a7a5:   .db $d7                     ; 27A5:  d7
b00_a7a6:   lda $61a7                   ; 27A6:  ad a7 61
b00_a7a9:   sbc #$03                    ; 27A9:  e9 03
b00_a7ab:   dex                         ; 27AB:  ca
b00_a7ac:   .db $02                     ; 27AC:  02
b00_a7ad:   ldy $a455                   ; 27AD:  ac 55 a4
b00_a7b0:   lda $a1                     ; 27B0:  a5 a1
b00_a7b2:   adc $808c                   ; 27B2:  6d 8c 80
b00_a7b5:   brk                         ; 27B5:  00
b00_a7b6:   .db $da                     ; 27B6:  da
b00_a7b7:   .db $d7                     ; 27B7:  d7
b00_a7b8:   .db $43                     ; 27B8:  43
b00_a7b9:   tay                         ; 27B9:  a8
b00_a7ba:   lda $67                     ; 27BA:  a5 67
b00_a7bc:   .db $6f                     ; 27BC:  6f
b00_a7bd:   tay                         ; 27BD:  a8
b00_a7be:   .db $63                     ; 27BE:  63
b00_a7bf:   .db $6f                     ; 27BF:  6f
b00_a7c0:   sty $00ff                   ; 27C0:  8c ff 00
b00_a7c3:   cmp ($d8,x)                 ; 27C3:  c1 d8
b00_a7c5:   sbc $a5a7,x                 ; 27C5:  fd a7 a5
b00_a7c8:   pla                         ; 27C8:  68
b00_a7c9:   .db $6f                     ; 27C9:  6f
b00_a7ca:   eor ($c0),y                 ; 27CA:  51 c0
b00_a7cc:   cld                         ; 27CC:  d8
b00_a7cd:   cmp $8ea7,y                 ; 27CD:  d9 a7 8e
b00_a7d0:   rti                         ; 27D0:  40
b00_a7d1:   .db $bf                     ; 27D1:  bf
b00_a7d2:   sbc #$26                    ; 27D2:  e9 26
b00_a7d4:   .db $d3                     ; 27D4:  d3
b00_a7d5:   .db $02                     ; 27D5:  02
b00_a7d6:   ldy $d766                   ; 27D6:  ac 66 d7
b00_a7d9:   lda $68                     ; 27D9:  a5 68
b00_a7db:   .db $6f                     ; 27DB:  6f
b00_a7dc:   cld                         ; 27DC:  d8
b00_a7dd:   .db $e3                     ; 27DD:  e3
b00_a7de:   .db $a7                     ; 27DE:  a7
b00_a7df:   rti                         ; 27DF:  40
b00_a7e0:   dec $e4,x                   ; 27E0:  d6 e4
b00_a7e2:   .db $a7                     ; 27E2:  a7
b00_a7e3:   eor ($b3,x)                 ; 27E3:  41 b3
b00_a7e5:   sbc #$e6                    ; 27E5:  e9 e6
b00_a7e7:   lda $02                     ; 27E7:  a5 02
b00_a7e9:   .db $62                     ; 27E9:  62
b00_a7ea:   sbc #$b1                    ; 27EA:  e9 b1
b00_a7ec:   .db $cb                     ; 27EC:  cb
b00_a7ed:   .db $02                     ; 27ED:  02
b00_a7ee:   lda $a1                     ; 27EE:  a5 a1
b00_a7f0:   adc $808c                   ; 27F0:  6d 8c 80
b00_a7f3:   brk                         ; 27F3:  00
b00_a7f4:   .db $da                     ; 27F4:  da
b00_a7f5:   .db $d7                     ; 27F5:  d7
b00_a7f6:   sbc $61a7,x                 ; 27F6:  fd a7 61
b00_a7f9:   sbc #$03                    ; 27F9:  e9 03
b00_a7fb:   dex                         ; 27FB:  ca
b00_a7fc:   .db $02                     ; 27FC:  02
b00_a7fd:   ldy $79                     ; 27FD:  a4 79
b00_a7ff:   .db $6f                     ; 27FF:  6f
b00_a800:   .db $d7                     ; 2800:  d7
b00_a801:   sta $a7                     ; 2801:  85 a7
b00_a803:   ldy $a742                   ; 2803:  ac 42 a7
b00_a806:   adc ($e9,x)                 ; 2806:  61 e9
b00_a808:   lda ($cb),y                 ; 2808:  b1 cb
b00_a80a:   .db $02                     ; 280A:  02
b00_a80b:   lda $a1                     ; 280B:  a5 a1
b00_a80d:   adc $808c                   ; 280D:  6d 8c 80
b00_a810:   brk                         ; 2810:  00
b00_a811:   .db $da                     ; 2811:  da
b00_a812:   .db $d7                     ; 2812:  d7
b00_a813:   .db $43                     ; 2813:  43
b00_a814:   tay                         ; 2814:  a8
b00_a815:   ldy $79                     ; 2815:  a4 79
b00_a817:   .db $6f                     ; 2817:  6f
b00_a818:   cld                         ; 2818:  d8
b00_a819:   and $62a8,y                 ; 2819:  39 a8 62
b00_a81c:   sbc #$b1                    ; 281C:  e9 b1
b00_a81e:   .db $cb                     ; 281E:  cb
b00_a81f:   .db $02                     ; 281F:  02
b00_a820:   lda $a1                     ; 2820:  a5 a1
b00_a822:   adc $808c                   ; 2822:  6d 8c 80
b00_a825:   brk                         ; 2825:  00
b00_a826:   .db $da                     ; 2826:  da
b00_a827:   .db $d7                     ; 2827:  d7
b00_a828:   .db $2f                     ; 2828:  2f
b00_a829:   tay                         ; 2829:  a8
b00_a82a:   adc ($e9,x)                 ; 282A:  61 e9
b00_a82c:   .db $03                     ; 282C:  03
b00_a82d:   dex                         ; 282D:  ca
b00_a82e:   .db $02                     ; 282E:  02
b00_a82f:   rti                         ; 282F:  40
b00_a830:   tay                         ; 2830:  a8
b00_a831:   adc $d66f,y                 ; 2831:  79 6f d6
b00_a834:   asl $a8                     ; 2834:  06 a8
b00_a836:   dec $06,x                   ; 2836:  d6 06
b00_a838:   tay                         ; 2838:  a8
b00_a839:   lda $a1                     ; 2839:  a5 a1
b00_a83b:   adc $808c                   ; 283B:  6d 8c 80
b00_a83e:   brk                         ; 283E:  00
b00_a83f:   .db $da                     ; 283F:  da
b00_a840:   cld                         ; 2840:  d8
b00_a841:   sta $a7                     ; 2841:  85 a7
b00_a843:   ldy $8003                   ; 2843:  ac 03 80
b00_a846:   dec $7d,x                   ; 2846:  d6 7d
b00_a848:   .db $a7                     ; 2848:  a7
b00_a849:   .db $cf                     ; 2849:  cf
b00_a84a:   eor $55,x                   ; 284A:  55 55
b00_a84c:   eor $55,x                   ; 284C:  55 55
b00_a84e:   eor $55,x                   ; 284E:  55 55
b00_a850:   eor $55,x                   ; 2850:  55 55
b00_a852:   eor $55,x                   ; 2852:  55 55
b00_a854:   eor $55,x                   ; 2854:  55 55
b00_a856:   eor $55,x                   ; 2856:  55 55
b00_a858:   eor $55,x                   ; 2858:  55 55
b00_a85a:   eor $55,x                   ; 285A:  55 55
b00_a85c:   brk                         ; 285C:  00
b00_a85d:   brk                         ; 285D:  00
b00_a85e:   brk                         ; 285E:  00
b00_a85f:   brk                         ; 285F:  00
b00_a860:   eor $55,x                   ; 2860:  55 55
b00_a862:   brk                         ; 2862:  00
b00_a863:   .db $04                     ; 2863:  04
b00_a864:   ora $05                     ; 2864:  05 05
b00_a866:   ora $05                     ; 2866:  05 05
b00_a868:   ora ($00,x)                 ; 2868:  01 00
b00_a86a:   sbc $f5,x                   ; 286A:  f5 f5
b00_a86c:   sbc $f5,x                   ; 286C:  f5 f5
b00_a86e:   sbc $f5,x                   ; 286E:  f5 f5
b00_a870:   sbc $f5,x                   ; 2870:  f5 f5
b00_a872:   brk                         ; 2872:  00
b00_a873:   brk                         ; 2873:  00
b00_a874:   .db $ff                     ; 2874:  ff
b00_a875:   ora $05                     ; 2875:  05 05
b00_a877:   ora $00                     ; 2877:  05 00
b00_a879:   brk                         ; 2879:  00
b00_a87a:   brk                         ; 287A:  00
b00_a87b:   brk                         ; 287B:  00
b00_a87c:   brk                         ; 287C:  00
b00_a87d:   brk                         ; 287D:  00
b00_a87e:   brk                         ; 287E:  00
b00_a87f:   brk                         ; 287F:  00
b00_a880:   brk                         ; 2880:  00
b00_a881:   brk                         ; 2881:  00
b00_a882:   ora $45                     ; 2882:  05 45
b00_a884:   eor $55,x                   ; 2884:  55 55
b00_a886:   eor $55,x                   ; 2886:  55 55
b00_a888:   ora $05,x                   ; 2888:  15 05
b00_a88a:   .db $02                     ; 288A:  02
b00_a88b:   .db $02                     ; 288B:  02
b00_a88c:   .db $02                     ; 288C:  02
b00_a88d:   .db $02                     ; 288D:  02
b00_a88e:   .db $02                     ; 288E:  02
b00_a88f:   .db $02                     ; 288F:  02
b00_a890:   .db $02                     ; 2890:  02
b00_a891:   .db $02                     ; 2891:  02
b00_a892:   .db $02                     ; 2892:  02
b00_a893:   .db $02                     ; 2893:  02
b00_a894:   .db $02                     ; 2894:  02
b00_a895:   .db $02                     ; 2895:  02
b00_a896:   .db $02                     ; 2896:  02
b00_a897:   .db $02                     ; 2897:  02
b00_a898:   .db $02                     ; 2898:  02
b00_a899:   .db $02                     ; 2899:  02
b00_a89a:   .db $02                     ; 289A:  02
b00_a89b:   .db $02                     ; 289B:  02
b00_a89c:   .db $02                     ; 289C:  02
b00_a89d:   .db $02                     ; 289D:  02
b00_a89e:   .db $02                     ; 289E:  02
b00_a89f:   .db $02                     ; 289F:  02
b00_a8a0:   .db $02                     ; 28A0:  02
b00_a8a1:   .db $02                     ; 28A1:  02
b00_a8a2:   .db $02                     ; 28A2:  02
b00_a8a3:   .db $02                     ; 28A3:  02
b00_a8a4:   .db $02                     ; 28A4:  02
b00_a8a5:   .db $02                     ; 28A5:  02
b00_a8a6:   .db $02                     ; 28A6:  02
b00_a8a7:   .db $02                     ; 28A7:  02
b00_a8a8:   .db $02                     ; 28A8:  02
b00_a8a9:   .db $02                     ; 28A9:  02
b00_a8aa:   .db $02                     ; 28AA:  02
b00_a8ab:   .db $02                     ; 28AB:  02
b00_a8ac:   .db $02                     ; 28AC:  02
b00_a8ad:   .db $02                     ; 28AD:  02
b00_a8ae:   .db $02                     ; 28AE:  02
b00_a8af:   .db $02                     ; 28AF:  02
b00_a8b0:   .db $02                     ; 28B0:  02
b00_a8b1:   .db $02                     ; 28B1:  02
b00_a8b2:   .db $02                     ; 28B2:  02
b00_a8b3:   .db $02                     ; 28B3:  02
b00_a8b4:   .db $02                     ; 28B4:  02
b00_a8b5:   .db $02                     ; 28B5:  02
b00_a8b6:   .db $02                     ; 28B6:  02
b00_a8b7:   .db $02                     ; 28B7:  02
b00_a8b8:   .db $02                     ; 28B8:  02
b00_a8b9:   .db $02                     ; 28B9:  02
b00_a8ba:   .db $02                     ; 28BA:  02
b00_a8bb:   .db $02                     ; 28BB:  02
b00_a8bc:   .db $02                     ; 28BC:  02
b00_a8bd:   .db $02                     ; 28BD:  02
b00_a8be:   .db $02                     ; 28BE:  02
b00_a8bf:   .db $02                     ; 28BF:  02
b00_a8c0:   .db $02                     ; 28C0:  02
b00_a8c1:   .db $02                     ; 28C1:  02
b00_a8c2:   .db $02                     ; 28C2:  02
b00_a8c3:   .db $02                     ; 28C3:  02
b00_a8c4:   .db $02                     ; 28C4:  02
b00_a8c5:   .db $02                     ; 28C5:  02
b00_a8c6:   .db $02                     ; 28C6:  02
b00_a8c7:   .db $02                     ; 28C7:  02
b00_a8c8:   .db $02                     ; 28C8:  02
b00_a8c9:   .db $02                     ; 28C9:  02
b00_a8ca:   .db $02                     ; 28CA:  02
b00_a8cb:   .db $02                     ; 28CB:  02
b00_a8cc:   .db $02                     ; 28CC:  02
b00_a8cd:   .db $02                     ; 28CD:  02
b00_a8ce:   .db $02                     ; 28CE:  02
b00_a8cf:   .db $02                     ; 28CF:  02
b00_a8d0:   .db $02                     ; 28D0:  02
b00_a8d1:   .db $02                     ; 28D1:  02
b00_a8d2:   .db $02                     ; 28D2:  02
b00_a8d3:   .db $02                     ; 28D3:  02
b00_a8d4:   .db $02                     ; 28D4:  02
b00_a8d5:   .db $02                     ; 28D5:  02
b00_a8d6:   .db $02                     ; 28D6:  02
b00_a8d7:   .db $02                     ; 28D7:  02
b00_a8d8:   .db $02                     ; 28D8:  02
b00_a8d9:   .db $02                     ; 28D9:  02
b00_a8da:   .db $02                     ; 28DA:  02
b00_a8db:   .db $02                     ; 28DB:  02
b00_a8dc:   .db $02                     ; 28DC:  02
b00_a8dd:   .db $02                     ; 28DD:  02
b00_a8de:   .db $02                     ; 28DE:  02
b00_a8df:   .db $02                     ; 28DF:  02
b00_a8e0:   .db $02                     ; 28E0:  02
b00_a8e1:   .db $02                     ; 28E1:  02
b00_a8e2:   .db $02                     ; 28E2:  02
b00_a8e3:   .db $02                     ; 28E3:  02
b00_a8e4:   .db $02                     ; 28E4:  02
b00_a8e5:   .db $02                     ; 28E5:  02
b00_a8e6:   .db $02                     ; 28E6:  02
b00_a8e7:   .db $02                     ; 28E7:  02
b00_a8e8:   .db $02                     ; 28E8:  02
b00_a8e9:   .db $02                     ; 28E9:  02
b00_a8ea:   .db $02                     ; 28EA:  02
b00_a8eb:   .db $02                     ; 28EB:  02
b00_a8ec:   .db $02                     ; 28EC:  02
b00_a8ed:   .db $02                     ; 28ED:  02
b00_a8ee:   .db $02                     ; 28EE:  02
b00_a8ef:   .db $02                     ; 28EF:  02
b00_a8f0:   .db $02                     ; 28F0:  02
b00_a8f1:   .db $02                     ; 28F1:  02
b00_a8f2:   .db $02                     ; 28F2:  02
b00_a8f3:   .db $02                     ; 28F3:  02
b00_a8f4:   .db $02                     ; 28F4:  02
b00_a8f5:   .db $02                     ; 28F5:  02
b00_a8f6:   .db $02                     ; 28F6:  02
b00_a8f7:   .db $02                     ; 28F7:  02
b00_a8f8:   .db $02                     ; 28F8:  02
b00_a8f9:   .db $02                     ; 28F9:  02
b00_a8fa:   .db $02                     ; 28FA:  02
b00_a8fb:   .db $02                     ; 28FB:  02
b00_a8fc:   .db $02                     ; 28FC:  02
b00_a8fd:   .db $02                     ; 28FD:  02
b00_a8fe:   .db $02                     ; 28FE:  02
b00_a8ff:   .db $02                     ; 28FF:  02
b00_a900:   .db $02                     ; 2900:  02
b00_a901:   .db $02                     ; 2901:  02
b00_a902:   .db $02                     ; 2902:  02
b00_a903:   .db $02                     ; 2903:  02
b00_a904:   .db $02                     ; 2904:  02
b00_a905:   .db $02                     ; 2905:  02
b00_a906:   .db $02                     ; 2906:  02
b00_a907:   .db $02                     ; 2907:  02
b00_a908:   .db $02                     ; 2908:  02
b00_a909:   .db $02                     ; 2909:  02
b00_a90a:   .db $02                     ; 290A:  02
b00_a90b:   .db $02                     ; 290B:  02
b00_a90c:   .db $02                     ; 290C:  02
b00_a90d:   .db $02                     ; 290D:  02
b00_a90e:   .db $02                     ; 290E:  02
b00_a90f:   .db $02                     ; 290F:  02
b00_a910:   .db $02                     ; 2910:  02
b00_a911:   .db $02                     ; 2911:  02
b00_a912:   .db $02                     ; 2912:  02
b00_a913:   .db $02                     ; 2913:  02
b00_a914:   .db $02                     ; 2914:  02
b00_a915:   .db $02                     ; 2915:  02
b00_a916:   .db $02                     ; 2916:  02
b00_a917:   .db $02                     ; 2917:  02
b00_a918:   .db $02                     ; 2918:  02
b00_a919:   .db $02                     ; 2919:  02
b00_a91a:   .db $02                     ; 291A:  02
b00_a91b:   .db $02                     ; 291B:  02
b00_a91c:   .db $02                     ; 291C:  02
b00_a91d:   .db $02                     ; 291D:  02
b00_a91e:   .db $02                     ; 291E:  02
b00_a91f:   .db $02                     ; 291F:  02
b00_a920:   .db $02                     ; 2920:  02
b00_a921:   .db $02                     ; 2921:  02
b00_a922:   .db $02                     ; 2922:  02
b00_a923:   .db $02                     ; 2923:  02
b00_a924:   .db $02                     ; 2924:  02
b00_a925:   .db $02                     ; 2925:  02
b00_a926:   .db $02                     ; 2926:  02
b00_a927:   .db $02                     ; 2927:  02
b00_a928:   .db $02                     ; 2928:  02
b00_a929:   .db $02                     ; 2929:  02
b00_a92a:   .db $02                     ; 292A:  02
b00_a92b:   .db $02                     ; 292B:  02
b00_a92c:   .db $02                     ; 292C:  02
b00_a92d:   .db $02                     ; 292D:  02
b00_a92e:   .db $02                     ; 292E:  02
b00_a92f:   .db $02                     ; 292F:  02
b00_a930:   .db $02                     ; 2930:  02
b00_a931:   .db $02                     ; 2931:  02
b00_a932:   .db $02                     ; 2932:  02
b00_a933:   .db $02                     ; 2933:  02
b00_a934:   .db $02                     ; 2934:  02
b00_a935:   .db $02                     ; 2935:  02
b00_a936:   .db $02                     ; 2936:  02
b00_a937:   .db $02                     ; 2937:  02
b00_a938:   .db $02                     ; 2938:  02
b00_a939:   .db $02                     ; 2939:  02
b00_a93a:   .db $02                     ; 293A:  02
b00_a93b:   .db $02                     ; 293B:  02
b00_a93c:   .db $02                     ; 293C:  02
b00_a93d:   .db $02                     ; 293D:  02
b00_a93e:   .db $02                     ; 293E:  02
b00_a93f:   .db $02                     ; 293F:  02
b00_a940:   .db $02                     ; 2940:  02
b00_a941:   .db $02                     ; 2941:  02
b00_a942:   .db $02                     ; 2942:  02
b00_a943:   .db $02                     ; 2943:  02
b00_a944:   .db $02                     ; 2944:  02
b00_a945:   .db $02                     ; 2945:  02
b00_a946:   .db $02                     ; 2946:  02
b00_a947:   .db $02                     ; 2947:  02
b00_a948:   .db $02                     ; 2948:  02
b00_a949:   .db $02                     ; 2949:  02
b00_a94a:   .db $02                     ; 294A:  02
b00_a94b:   .db $02                     ; 294B:  02
b00_a94c:   .db $02                     ; 294C:  02
b00_a94d:   .db $02                     ; 294D:  02
b00_a94e:   .db $02                     ; 294E:  02
b00_a94f:   .db $02                     ; 294F:  02
b00_a950:   .db $02                     ; 2950:  02
b00_a951:   .db $02                     ; 2951:  02
b00_a952:   .db $02                     ; 2952:  02
b00_a953:   .db $02                     ; 2953:  02
b00_a954:   .db $02                     ; 2954:  02
b00_a955:   .db $02                     ; 2955:  02
b00_a956:   .db $02                     ; 2956:  02
b00_a957:   .db $02                     ; 2957:  02
b00_a958:   .db $02                     ; 2958:  02
b00_a959:   .db $02                     ; 2959:  02
b00_a95a:   .db $02                     ; 295A:  02
b00_a95b:   .db $02                     ; 295B:  02
b00_a95c:   .db $02                     ; 295C:  02
b00_a95d:   .db $02                     ; 295D:  02
b00_a95e:   .db $02                     ; 295E:  02
b00_a95f:   .db $02                     ; 295F:  02
b00_a960:   .db $02                     ; 2960:  02
b00_a961:   .db $02                     ; 2961:  02
b00_a962:   .db $02                     ; 2962:  02
b00_a963:   .db $02                     ; 2963:  02
b00_a964:   .db $02                     ; 2964:  02
b00_a965:   .db $02                     ; 2965:  02
b00_a966:   .db $02                     ; 2966:  02
b00_a967:   .db $02                     ; 2967:  02
b00_a968:   .db $02                     ; 2968:  02
b00_a969:   .db $02                     ; 2969:  02
b00_a96a:   .db $02                     ; 296A:  02
b00_a96b:   .db $02                     ; 296B:  02
b00_a96c:   .db $02                     ; 296C:  02
b00_a96d:   .db $02                     ; 296D:  02
b00_a96e:   .db $02                     ; 296E:  02
b00_a96f:   .db $02                     ; 296F:  02
b00_a970:   .db $02                     ; 2970:  02
b00_a971:   .db $02                     ; 2971:  02
b00_a972:   .db $02                     ; 2972:  02
b00_a973:   .db $02                     ; 2973:  02
b00_a974:   .db $02                     ; 2974:  02
b00_a975:   .db $02                     ; 2975:  02
b00_a976:   .db $02                     ; 2976:  02
b00_a977:   .db $02                     ; 2977:  02
b00_a978:   .db $02                     ; 2978:  02
b00_a979:   .db $02                     ; 2979:  02
b00_a97a:   .db $02                     ; 297A:  02
b00_a97b:   .db $02                     ; 297B:  02
b00_a97c:   .db $02                     ; 297C:  02
b00_a97d:   .db $02                     ; 297D:  02
b00_a97e:   .db $02                     ; 297E:  02
b00_a97f:   .db $02                     ; 297F:  02
b00_a980:   .db $02                     ; 2980:  02
b00_a981:   .db $02                     ; 2981:  02
b00_a982:   .db $02                     ; 2982:  02
b00_a983:   .db $02                     ; 2983:  02
b00_a984:   .db $02                     ; 2984:  02
b00_a985:   .db $02                     ; 2985:  02
b00_a986:   .db $02                     ; 2986:  02
b00_a987:   .db $02                     ; 2987:  02
b00_a988:   .db $02                     ; 2988:  02
b00_a989:   .db $02                     ; 2989:  02
b00_a98a:   .db $02                     ; 298A:  02
b00_a98b:   .db $02                     ; 298B:  02
b00_a98c:   .db $02                     ; 298C:  02
b00_a98d:   .db $02                     ; 298D:  02
b00_a98e:   .db $02                     ; 298E:  02
b00_a98f:   .db $02                     ; 298F:  02
b00_a990:   .db $02                     ; 2990:  02
b00_a991:   .db $02                     ; 2991:  02
b00_a992:   .db $02                     ; 2992:  02
b00_a993:   .db $02                     ; 2993:  02
b00_a994:   .db $02                     ; 2994:  02
b00_a995:   .db $02                     ; 2995:  02
b00_a996:   .db $02                     ; 2996:  02
b00_a997:   .db $02                     ; 2997:  02
b00_a998:   .db $02                     ; 2998:  02
b00_a999:   .db $02                     ; 2999:  02
b00_a99a:   .db $02                     ; 299A:  02
b00_a99b:   .db $02                     ; 299B:  02
b00_a99c:   .db $02                     ; 299C:  02
b00_a99d:   .db $02                     ; 299D:  02
b00_a99e:   .db $02                     ; 299E:  02
b00_a99f:   .db $02                     ; 299F:  02
b00_a9a0:   .db $02                     ; 29A0:  02
b00_a9a1:   .db $02                     ; 29A1:  02
b00_a9a2:   .db $02                     ; 29A2:  02
b00_a9a3:   .db $02                     ; 29A3:  02
b00_a9a4:   .db $02                     ; 29A4:  02
b00_a9a5:   .db $02                     ; 29A5:  02
b00_a9a6:   .db $02                     ; 29A6:  02
b00_a9a7:   .db $02                     ; 29A7:  02
b00_a9a8:   .db $02                     ; 29A8:  02
b00_a9a9:   .db $02                     ; 29A9:  02
b00_a9aa:   .db $02                     ; 29AA:  02
b00_a9ab:   .db $02                     ; 29AB:  02
b00_a9ac:   .db $02                     ; 29AC:  02
b00_a9ad:   .db $02                     ; 29AD:  02
b00_a9ae:   .db $02                     ; 29AE:  02
b00_a9af:   .db $02                     ; 29AF:  02
b00_a9b0:   .db $02                     ; 29B0:  02
b00_a9b1:   .db $02                     ; 29B1:  02
b00_a9b2:   .db $02                     ; 29B2:  02
b00_a9b3:   .db $02                     ; 29B3:  02
b00_a9b4:   .db $02                     ; 29B4:  02
b00_a9b5:   .db $02                     ; 29B5:  02
b00_a9b6:   .db $02                     ; 29B6:  02
b00_a9b7:   .db $02                     ; 29B7:  02
b00_a9b8:   .db $02                     ; 29B8:  02
b00_a9b9:   .db $02                     ; 29B9:  02
b00_a9ba:   .db $02                     ; 29BA:  02
b00_a9bb:   .db $02                     ; 29BB:  02
b00_a9bc:   .db $02                     ; 29BC:  02
b00_a9bd:   .db $02                     ; 29BD:  02
b00_a9be:   .db $02                     ; 29BE:  02
b00_a9bf:   .db $02                     ; 29BF:  02
b00_a9c0:   .db $02                     ; 29C0:  02
b00_a9c1:   .db $02                     ; 29C1:  02
b00_a9c2:   .db $02                     ; 29C2:  02
b00_a9c3:   .db $02                     ; 29C3:  02
b00_a9c4:   .db $02                     ; 29C4:  02
b00_a9c5:   .db $02                     ; 29C5:  02
b00_a9c6:   .db $02                     ; 29C6:  02
b00_a9c7:   .db $02                     ; 29C7:  02
b00_a9c8:   .db $02                     ; 29C8:  02
b00_a9c9:   .db $02                     ; 29C9:  02
b00_a9ca:   .db $02                     ; 29CA:  02
b00_a9cb:   .db $02                     ; 29CB:  02
b00_a9cc:   .db $02                     ; 29CC:  02
b00_a9cd:   .db $02                     ; 29CD:  02
b00_a9ce:   .db $02                     ; 29CE:  02
b00_a9cf:   .db $02                     ; 29CF:  02
b00_a9d0:   .db $02                     ; 29D0:  02
b00_a9d1:   .db $02                     ; 29D1:  02
b00_a9d2:   brk                         ; 29D2:  00
b00_a9d3:   ora ($03,x)                 ; 29D3:  01 03
b00_a9d5:   .db $04                     ; 29D5:  04
b00_a9d6:   ora $06                     ; 29D6:  05 06
b00_a9d8:   .db $07                     ; 29D8:  07
b00_a9d9:   php                         ; 29D9:  08
b00_a9da:   ora #$0a                    ; 29DA:  09 0a
b00_a9dc:   .db $0b                     ; 29DC:  0b
b00_a9dd:   .db $0c                     ; 29DD:  0c
b00_a9de:   ora $0f0e                   ; 29DE:  0d 0e 0f
b00_a9e1:   bpl $a9e5                   ; 29E1:  10 02
b00_a9e3:   .db $02                     ; 29E3:  02
b00_a9e4:   .db $02                     ; 29E4:  02
b00_a9e5:   .db $02                     ; 29E5:  02
b00_a9e6:   .db $02                     ; 29E6:  02
b00_a9e7:   .db $02                     ; 29E7:  02
b00_a9e8:   .db $02                     ; 29E8:  02
b00_a9e9:   .db $02                     ; 29E9:  02
b00_a9ea:   .db $02                     ; 29EA:  02
b00_a9eb:   .db $02                     ; 29EB:  02
b00_a9ec:   .db $02                     ; 29EC:  02
b00_a9ed:   .db $02                     ; 29ED:  02
b00_a9ee:   .db $02                     ; 29EE:  02
b00_a9ef:   .db $02                     ; 29EF:  02
b00_a9f0:   .db $02                     ; 29F0:  02
b00_a9f1:   .db $02                     ; 29F1:  02
b00_a9f2:   .db $02                     ; 29F2:  02
b00_a9f3:   .db $02                     ; 29F3:  02
b00_a9f4:   .db $02                     ; 29F4:  02
b00_a9f5:   .db $02                     ; 29F5:  02
b00_a9f6:   .db $02                     ; 29F6:  02
b00_a9f7:   .db $02                     ; 29F7:  02
b00_a9f8:   .db $02                     ; 29F8:  02
b00_a9f9:   .db $02                     ; 29F9:  02
b00_a9fa:   .db $02                     ; 29FA:  02
b00_a9fb:   .db $02                     ; 29FB:  02
b00_a9fc:   .db $02                     ; 29FC:  02
b00_a9fd:   .db $02                     ; 29FD:  02
b00_a9fe:   .db $02                     ; 29FE:  02
b00_a9ff:   .db $02                     ; 29FF:  02
b00_aa00:   .db $02                     ; 2A00:  02
b00_aa01:   .db $02                     ; 2A01:  02
b00_aa02:   .db $02                     ; 2A02:  02
b00_aa03:   .db $02                     ; 2A03:  02
b00_aa04:   .db $02                     ; 2A04:  02
b00_aa05:   .db $02                     ; 2A05:  02
b00_aa06:   .db $02                     ; 2A06:  02
b00_aa07:   .db $02                     ; 2A07:  02
b00_aa08:   .db $02                     ; 2A08:  02
b00_aa09:   .db $02                     ; 2A09:  02
b00_aa0a:   .db $02                     ; 2A0A:  02
b00_aa0b:   .db $02                     ; 2A0B:  02
b00_aa0c:   .db $02                     ; 2A0C:  02
b00_aa0d:   .db $02                     ; 2A0D:  02
b00_aa0e:   .db $02                     ; 2A0E:  02
b00_aa0f:   .db $02                     ; 2A0F:  02
b00_aa10:   .db $02                     ; 2A10:  02
b00_aa11:   .db $02                     ; 2A11:  02
b00_aa12:   .db $02                     ; 2A12:  02
b00_aa13:   ora ($13),y                 ; 2A13:  11 13
b00_aa15:   .db $14                     ; 2A15:  14
b00_aa16:   .db $17                     ; 2A16:  17
b00_aa17:   clc                         ; 2A17:  18
b00_aa18:   .db $1b                     ; 2A18:  1b
b00_aa19:   .db $1c                     ; 2A19:  1c
b00_aa1a:   .db $1f                     ; 2A1A:  1f
b00_aa1b:   jsr $2423                   ; 2A1B:  20 23 24
b00_aa1e:   .db $27                     ; 2A1E:  27
b00_aa1f:   plp                         ; 2A1F:  28
b00_aa20:   .db $2b                     ; 2A20:  2b
b00_aa21:   .db $02                     ; 2A21:  02
b00_aa22:   .db $02                     ; 2A22:  02
b00_aa23:   .db $02                     ; 2A23:  02
b00_aa24:   .db $02                     ; 2A24:  02
b00_aa25:   .db $02                     ; 2A25:  02
b00_aa26:   .db $02                     ; 2A26:  02
b00_aa27:   .db $02                     ; 2A27:  02
b00_aa28:   .db $02                     ; 2A28:  02
b00_aa29:   .db $02                     ; 2A29:  02
b00_aa2a:   .db $02                     ; 2A2A:  02
b00_aa2b:   .db $02                     ; 2A2B:  02
b00_aa2c:   .db $02                     ; 2A2C:  02
b00_aa2d:   .db $02                     ; 2A2D:  02
b00_aa2e:   .db $02                     ; 2A2E:  02
b00_aa2f:   .db $02                     ; 2A2F:  02
b00_aa30:   .db $02                     ; 2A30:  02
b00_aa31:   .db $02                     ; 2A31:  02
b00_aa32:   .db $02                     ; 2A32:  02
b00_aa33:   .db $12                     ; 2A33:  12
b00_aa34:   ora $16,x                   ; 2A34:  15 16
b00_aa36:   ora $1d1a,y                 ; 2A36:  19 1a 1d
b00_aa39:   asl $2221,x                 ; 2A39:  1e 21 22
b00_aa3c:   and $26                     ; 2A3C:  25 26
b00_aa3e:   and #$2a                    ; 2A3E:  29 2a
b00_aa40:   bit $0202                   ; 2A40:  2c 02 02
b00_aa43:   .db $02                     ; 2A43:  02
b00_aa44:   .db $02                     ; 2A44:  02
b00_aa45:   .db $02                     ; 2A45:  02
b00_aa46:   .db $02                     ; 2A46:  02
b00_aa47:   .db $02                     ; 2A47:  02
b00_aa48:   .db $02                     ; 2A48:  02
b00_aa49:   .db $02                     ; 2A49:  02
b00_aa4a:   .db $02                     ; 2A4A:  02
b00_aa4b:   .db $02                     ; 2A4B:  02
b00_aa4c:   .db $02                     ; 2A4C:  02
b00_aa4d:   .db $02                     ; 2A4D:  02
b00_aa4e:   .db $02                     ; 2A4E:  02
b00_aa4f:   .db $02                     ; 2A4F:  02
b00_aa50:   .db $02                     ; 2A50:  02
b00_aa51:   .db $02                     ; 2A51:  02
b00_aa52:   .db $02                     ; 2A52:  02
b00_aa53:   .db $02                     ; 2A53:  02
b00_aa54:   .db $02                     ; 2A54:  02
b00_aa55:   .db $02                     ; 2A55:  02
b00_aa56:   .db $02                     ; 2A56:  02
b00_aa57:   .db $02                     ; 2A57:  02
b00_aa58:   .db $02                     ; 2A58:  02
b00_aa59:   .db $02                     ; 2A59:  02
b00_aa5a:   .db $02                     ; 2A5A:  02
b00_aa5b:   .db $02                     ; 2A5B:  02
b00_aa5c:   .db $02                     ; 2A5C:  02
b00_aa5d:   .db $02                     ; 2A5D:  02
b00_aa5e:   .db $02                     ; 2A5E:  02
b00_aa5f:   .db $02                     ; 2A5F:  02
b00_aa60:   .db $02                     ; 2A60:  02
b00_aa61:   .db $02                     ; 2A61:  02
b00_aa62:   .db $02                     ; 2A62:  02
b00_aa63:   .db $02                     ; 2A63:  02
b00_aa64:   .db $02                     ; 2A64:  02
b00_aa65:   .db $02                     ; 2A65:  02
b00_aa66:   .db $02                     ; 2A66:  02
b00_aa67:   .db $02                     ; 2A67:  02
b00_aa68:   .db $02                     ; 2A68:  02
b00_aa69:   .db $02                     ; 2A69:  02
b00_aa6a:   .db $02                     ; 2A6A:  02
b00_aa6b:   .db $02                     ; 2A6B:  02
b00_aa6c:   .db $02                     ; 2A6C:  02
b00_aa6d:   .db $02                     ; 2A6D:  02
b00_aa6e:   .db $02                     ; 2A6E:  02
b00_aa6f:   .db $02                     ; 2A6F:  02
b00_aa70:   .db $02                     ; 2A70:  02
b00_aa71:   .db $02                     ; 2A71:  02
b00_aa72:   .db $02                     ; 2A72:  02
b00_aa73:   .db $02                     ; 2A73:  02
b00_aa74:   .db $02                     ; 2A74:  02
b00_aa75:   .db $02                     ; 2A75:  02
b00_aa76:   .db $02                     ; 2A76:  02
b00_aa77:   .db $02                     ; 2A77:  02
b00_aa78:   .db $02                     ; 2A78:  02
b00_aa79:   .db $02                     ; 2A79:  02
b00_aa7a:   .db $02                     ; 2A7A:  02
b00_aa7b:   .db $02                     ; 2A7B:  02
b00_aa7c:   .db $02                     ; 2A7C:  02
b00_aa7d:   .db $02                     ; 2A7D:  02
b00_aa7e:   .db $02                     ; 2A7E:  02
b00_aa7f:   .db $02                     ; 2A7F:  02
b00_aa80:   .db $02                     ; 2A80:  02
b00_aa81:   .db $02                     ; 2A81:  02
b00_aa82:   .db $02                     ; 2A82:  02
b00_aa83:   .db $02                     ; 2A83:  02
b00_aa84:   .db $02                     ; 2A84:  02
b00_aa85:   .db $02                     ; 2A85:  02
b00_aa86:   .db $02                     ; 2A86:  02
b00_aa87:   .db $02                     ; 2A87:  02
b00_aa88:   .db $02                     ; 2A88:  02
b00_aa89:   .db $02                     ; 2A89:  02
b00_aa8a:   .db $02                     ; 2A8A:  02
b00_aa8b:   .db $02                     ; 2A8B:  02
b00_aa8c:   .db $02                     ; 2A8C:  02
b00_aa8d:   .db $02                     ; 2A8D:  02
b00_aa8e:   .db $02                     ; 2A8E:  02
b00_aa8f:   .db $02                     ; 2A8F:  02
b00_aa90:   .db $02                     ; 2A90:  02
b00_aa91:   .db $02                     ; 2A91:  02
b00_aa92:   and $312e                   ; 2A92:  2d 2e 31
b00_aa95:   .db $32                     ; 2A95:  32
b00_aa96:   and $36,x                   ; 2A96:  35 36
b00_aa98:   and $3b39                   ; 2A98:  2d 39 3b
b00_aa9b:   .db $3c                     ; 2A9B:  3c
b00_aa9c:   and ($3f),y                 ; 2A9C:  31 3f
b00_aa9e:   eor ($42,x)                 ; 2A9E:  41 42
b00_aaa0:   eor $46                     ; 2AA0:  45 46
b00_aaa2:   .db $02                     ; 2AA2:  02
b00_aaa3:   .db $02                     ; 2AA3:  02
b00_aaa4:   .db $02                     ; 2AA4:  02
b00_aaa5:   .db $02                     ; 2AA5:  02
b00_aaa6:   .db $02                     ; 2AA6:  02
b00_aaa7:   .db $02                     ; 2AA7:  02
b00_aaa8:   .db $02                     ; 2AA8:  02
b00_aaa9:   .db $02                     ; 2AA9:  02
b00_aaaa:   .db $02                     ; 2AAA:  02
b00_aaab:   .db $02                     ; 2AAB:  02
b00_aaac:   .db $02                     ; 2AAC:  02
b00_aaad:   .db $02                     ; 2AAD:  02
b00_aaae:   .db $02                     ; 2AAE:  02
b00_aaaf:   .db $02                     ; 2AAF:  02
b00_aab0:   .db $02                     ; 2AB0:  02
b00_aab1:   .db $02                     ; 2AB1:  02
b00_aab2:   .db $2f                     ; 2AB2:  2f
b00_aab3:   bmi $aae8                   ; 2AB3:  30 33
b00_aab5:   .db $34                     ; 2AB5:  34
b00_aab6:   .db $37                     ; 2AB6:  37
b00_aab7:   sec                         ; 2AB7:  38
b00_aab8:   .db $2f                     ; 2AB8:  2f
b00_aab9:   .db $3a                     ; 2AB9:  3a
b00_aaba:   and $333e,x                 ; 2ABA:  3d 3e 33
b00_aabd:   rti                         ; 2ABD:  40
b00_aabe:   .db $43                     ; 2ABE:  43
b00_aabf:   .db $44                     ; 2ABF:  44
b00_aac0:   .db $47                     ; 2AC0:  47
b00_aac1:   pha                         ; 2AC1:  48
b00_aac2:   .db $02                     ; 2AC2:  02
b00_aac3:   .db $02                     ; 2AC3:  02
b00_aac4:   .db $02                     ; 2AC4:  02
b00_aac5:   .db $02                     ; 2AC5:  02
b00_aac6:   .db $02                     ; 2AC6:  02
b00_aac7:   .db $02                     ; 2AC7:  02
b00_aac8:   .db $02                     ; 2AC8:  02
b00_aac9:   .db $02                     ; 2AC9:  02
b00_aaca:   .db $02                     ; 2ACA:  02
b00_aacb:   .db $02                     ; 2ACB:  02
b00_aacc:   eor #$4a                    ; 2ACC:  49 4a
b00_aace:   .db $4b                     ; 2ACE:  4b
b00_aacf:   jmp $4e4d                   ; 2ACF:  4c 4d 4e
b00_aad2:   .db $4f                     ; 2AD2:  4f
b00_aad3:   bvc $ab26                   ; 2AD3:  50 51
b00_aad5:   .db $52                     ; 2AD5:  52
b00_aad6:   .db $54                     ; 2AD6:  54
b00_aad7:   eor $56,x                   ; 2AD7:  55 56
b00_aad9:   .db $57                     ; 2AD9:  57
b00_aada:   cli                         ; 2ADA:  58
b00_aadb:   eor $5b5a,y                 ; 2ADB:  59 5a 5b
b00_aade:   .db $5c                     ; 2ADE:  5c
b00_aadf:   eor $5f5e,x                 ; 2ADF:  5d 5e 5f
b00_aae2:   rts                         ; 2AE2:  60
b00_aae3:   adc ($62,x)                 ; 2AE3:  61 62
b00_aae5:   .db $63                     ; 2AE5:  63
b00_aae6:   .db $64                     ; 2AE6:  64
b00_aae7:   adc $02                     ; 2AE7:  65 02
b00_aae9:   .db $02                     ; 2AE9:  02
b00_aaea:   .db $02                     ; 2AEA:  02
b00_aaeb:   .db $02                     ; 2AEB:  02
b00_aaec:   .db $02                     ; 2AEC:  02
b00_aaed:   .db $02                     ; 2AED:  02
b00_aaee:   .db $02                     ; 2AEE:  02
b00_aaef:   .db $02                     ; 2AEF:  02
b00_aaf0:   .db $02                     ; 2AF0:  02
b00_aaf1:   .db $02                     ; 2AF1:  02
b00_aaf2:   .db $02                     ; 2AF2:  02
b00_aaf3:   .db $02                     ; 2AF3:  02
b00_aaf4:   .db $53                     ; 2AF4:  53
b00_aaf5:   .db $02                     ; 2AF5:  02
b00_aaf6:   .db $02                     ; 2AF6:  02
b00_aaf7:   .db $02                     ; 2AF7:  02
b00_aaf8:   .db $02                     ; 2AF8:  02
b00_aaf9:   .db $02                     ; 2AF9:  02
b00_aafa:   .db $02                     ; 2AFA:  02
b00_aafb:   .db $02                     ; 2AFB:  02
b00_aafc:   .db $02                     ; 2AFC:  02
b00_aafd:   .db $02                     ; 2AFD:  02
b00_aafe:   .db $02                     ; 2AFE:  02
b00_aaff:   .db $02                     ; 2AFF:  02
b00_ab00:   .db $02                     ; 2B00:  02
b00_ab01:   .db $02                     ; 2B01:  02
b00_ab02:   .db $02                     ; 2B02:  02
b00_ab03:   .db $02                     ; 2B03:  02
b00_ab04:   .db $02                     ; 2B04:  02
b00_ab05:   .db $02                     ; 2B05:  02
b00_ab06:   .db $02                     ; 2B06:  02
b00_ab07:   .db $02                     ; 2B07:  02
b00_ab08:   .db $02                     ; 2B08:  02
b00_ab09:   .db $02                     ; 2B09:  02
b00_ab0a:   .db $02                     ; 2B0A:  02
b00_ab0b:   .db $02                     ; 2B0B:  02
b00_ab0c:   .db $02                     ; 2B0C:  02
b00_ab0d:   .db $02                     ; 2B0D:  02
b00_ab0e:   .db $02                     ; 2B0E:  02
b00_ab0f:   .db $02                     ; 2B0F:  02
b00_ab10:   .db $02                     ; 2B10:  02
b00_ab11:   .db $02                     ; 2B11:  02
b00_ab12:   .db $02                     ; 2B12:  02
b00_ab13:   .db $02                     ; 2B13:  02
b00_ab14:   .db $02                     ; 2B14:  02
b00_ab15:   .db $02                     ; 2B15:  02
b00_ab16:   .db $02                     ; 2B16:  02
b00_ab17:   .db $02                     ; 2B17:  02
b00_ab18:   .db $02                     ; 2B18:  02
b00_ab19:   .db $02                     ; 2B19:  02
b00_ab1a:   .db $02                     ; 2B1A:  02
b00_ab1b:   .db $02                     ; 2B1B:  02
b00_ab1c:   .db $02                     ; 2B1C:  02
b00_ab1d:   .db $02                     ; 2B1D:  02
b00_ab1e:   .db $02                     ; 2B1E:  02
b00_ab1f:   .db $02                     ; 2B1F:  02
b00_ab20:   .db $02                     ; 2B20:  02
b00_ab21:   .db $02                     ; 2B21:  02
b00_ab22:   .db $02                     ; 2B22:  02
b00_ab23:   .db $02                     ; 2B23:  02
b00_ab24:   .db $02                     ; 2B24:  02
b00_ab25:   .db $02                     ; 2B25:  02
b00_ab26:   .db $02                     ; 2B26:  02
b00_ab27:   .db $02                     ; 2B27:  02
b00_ab28:   .db $02                     ; 2B28:  02
b00_ab29:   .db $02                     ; 2B29:  02
b00_ab2a:   .db $02                     ; 2B2A:  02
b00_ab2b:   .db $02                     ; 2B2B:  02
b00_ab2c:   .db $02                     ; 2B2C:  02
b00_ab2d:   .db $02                     ; 2B2D:  02
b00_ab2e:   .db $02                     ; 2B2E:  02
b00_ab2f:   .db $02                     ; 2B2F:  02
b00_ab30:   .db $02                     ; 2B30:  02
b00_ab31:   .db $02                     ; 2B31:  02
b00_ab32:   .db $02                     ; 2B32:  02
b00_ab33:   .db $02                     ; 2B33:  02
b00_ab34:   .db $02                     ; 2B34:  02
b00_ab35:   .db $02                     ; 2B35:  02
b00_ab36:   .db $02                     ; 2B36:  02
b00_ab37:   .db $02                     ; 2B37:  02
b00_ab38:   .db $02                     ; 2B38:  02
b00_ab39:   .db $02                     ; 2B39:  02
b00_ab3a:   .db $02                     ; 2B3A:  02
b00_ab3b:   .db $02                     ; 2B3B:  02
b00_ab3c:   .db $02                     ; 2B3C:  02
b00_ab3d:   .db $02                     ; 2B3D:  02
b00_ab3e:   .db $02                     ; 2B3E:  02
b00_ab3f:   .db $02                     ; 2B3F:  02
b00_ab40:   .db $02                     ; 2B40:  02
b00_ab41:   .db $02                     ; 2B41:  02
b00_ab42:   .db $02                     ; 2B42:  02
b00_ab43:   .db $02                     ; 2B43:  02
b00_ab44:   .db $02                     ; 2B44:  02
b00_ab45:   .db $02                     ; 2B45:  02
b00_ab46:   .db $02                     ; 2B46:  02
b00_ab47:   .db $02                     ; 2B47:  02
b00_ab48:   .db $02                     ; 2B48:  02
b00_ab49:   .db $02                     ; 2B49:  02
b00_ab4a:   .db $02                     ; 2B4A:  02
b00_ab4b:   .db $02                     ; 2B4B:  02
b00_ab4c:   .db $02                     ; 2B4C:  02
b00_ab4d:   .db $02                     ; 2B4D:  02
b00_ab4e:   .db $02                     ; 2B4E:  02
b00_ab4f:   .db $02                     ; 2B4F:  02
b00_ab50:   .db $02                     ; 2B50:  02
b00_ab51:   .db $02                     ; 2B51:  02
b00_ab52:   .db $02                     ; 2B52:  02
b00_ab53:   .db $02                     ; 2B53:  02
b00_ab54:   .db $02                     ; 2B54:  02
b00_ab55:   .db $02                     ; 2B55:  02
b00_ab56:   .db $02                     ; 2B56:  02
b00_ab57:   .db $02                     ; 2B57:  02
b00_ab58:   .db $02                     ; 2B58:  02
b00_ab59:   .db $02                     ; 2B59:  02
b00_ab5a:   .db $02                     ; 2B5A:  02
b00_ab5b:   .db $02                     ; 2B5B:  02
b00_ab5c:   .db $02                     ; 2B5C:  02
b00_ab5d:   .db $02                     ; 2B5D:  02
b00_ab5e:   .db $02                     ; 2B5E:  02
b00_ab5f:   .db $02                     ; 2B5F:  02
b00_ab60:   .db $02                     ; 2B60:  02
b00_ab61:   .db $02                     ; 2B61:  02
b00_ab62:   .db $02                     ; 2B62:  02
b00_ab63:   .db $02                     ; 2B63:  02
b00_ab64:   .db $02                     ; 2B64:  02
b00_ab65:   .db $02                     ; 2B65:  02
b00_ab66:   .db $02                     ; 2B66:  02
b00_ab67:   .db $02                     ; 2B67:  02
b00_ab68:   .db $02                     ; 2B68:  02
b00_ab69:   .db $02                     ; 2B69:  02
b00_ab6a:   .db $02                     ; 2B6A:  02
b00_ab6b:   .db $02                     ; 2B6B:  02
b00_ab6c:   .db $02                     ; 2B6C:  02
b00_ab6d:   .db $02                     ; 2B6D:  02
b00_ab6e:   .db $02                     ; 2B6E:  02
b00_ab6f:   .db $02                     ; 2B6F:  02
b00_ab70:   .db $02                     ; 2B70:  02
b00_ab71:   .db $02                     ; 2B71:  02
b00_ab72:   .db $02                     ; 2B72:  02
b00_ab73:   .db $02                     ; 2B73:  02
b00_ab74:   .db $02                     ; 2B74:  02
b00_ab75:   .db $02                     ; 2B75:  02
b00_ab76:   .db $02                     ; 2B76:  02
b00_ab77:   .db $02                     ; 2B77:  02
b00_ab78:   .db $02                     ; 2B78:  02
b00_ab79:   .db $02                     ; 2B79:  02
b00_ab7a:   .db $02                     ; 2B7A:  02
b00_ab7b:   .db $02                     ; 2B7B:  02
b00_ab7c:   .db $02                     ; 2B7C:  02
b00_ab7d:   .db $02                     ; 2B7D:  02
b00_ab7e:   .db $02                     ; 2B7E:  02
b00_ab7f:   .db $02                     ; 2B7F:  02
b00_ab80:   .db $02                     ; 2B80:  02
b00_ab81:   .db $02                     ; 2B81:  02
b00_ab82:   .db $02                     ; 2B82:  02
b00_ab83:   .db $02                     ; 2B83:  02
b00_ab84:   .db $02                     ; 2B84:  02
b00_ab85:   .db $02                     ; 2B85:  02
b00_ab86:   .db $02                     ; 2B86:  02
b00_ab87:   .db $02                     ; 2B87:  02
b00_ab88:   .db $02                     ; 2B88:  02
b00_ab89:   .db $02                     ; 2B89:  02
b00_ab8a:   .db $02                     ; 2B8A:  02
b00_ab8b:   .db $02                     ; 2B8B:  02
b00_ab8c:   .db $02                     ; 2B8C:  02
b00_ab8d:   .db $02                     ; 2B8D:  02
b00_ab8e:   .db $02                     ; 2B8E:  02
b00_ab8f:   .db $02                     ; 2B8F:  02
b00_ab90:   .db $02                     ; 2B90:  02
b00_ab91:   .db $02                     ; 2B91:  02
b00_ab92:   .db $02                     ; 2B92:  02
b00_ab93:   .db $02                     ; 2B93:  02
b00_ab94:   .db $02                     ; 2B94:  02
b00_ab95:   .db $02                     ; 2B95:  02
b00_ab96:   .db $02                     ; 2B96:  02
b00_ab97:   .db $02                     ; 2B97:  02
b00_ab98:   .db $02                     ; 2B98:  02
b00_ab99:   .db $02                     ; 2B99:  02
b00_ab9a:   .db $02                     ; 2B9A:  02
b00_ab9b:   .db $02                     ; 2B9B:  02
b00_ab9c:   .db $02                     ; 2B9C:  02
b00_ab9d:   .db $02                     ; 2B9D:  02
b00_ab9e:   .db $02                     ; 2B9E:  02
b00_ab9f:   .db $02                     ; 2B9F:  02
b00_aba0:   .db $02                     ; 2BA0:  02
b00_aba1:   .db $02                     ; 2BA1:  02
b00_aba2:   .db $02                     ; 2BA2:  02
b00_aba3:   .db $02                     ; 2BA3:  02
b00_aba4:   .db $02                     ; 2BA4:  02
b00_aba5:   .db $02                     ; 2BA5:  02
b00_aba6:   .db $02                     ; 2BA6:  02
b00_aba7:   .db $02                     ; 2BA7:  02
b00_aba8:   .db $02                     ; 2BA8:  02
b00_aba9:   .db $02                     ; 2BA9:  02
b00_abaa:   .db $02                     ; 2BAA:  02
b00_abab:   .db $02                     ; 2BAB:  02
b00_abac:   .db $02                     ; 2BAC:  02
b00_abad:   .db $02                     ; 2BAD:  02
b00_abae:   .db $02                     ; 2BAE:  02
b00_abaf:   .db $02                     ; 2BAF:  02
b00_abb0:   .db $02                     ; 2BB0:  02
b00_abb1:   .db $02                     ; 2BB1:  02
b00_abb2:   .db $02                     ; 2BB2:  02
b00_abb3:   .db $02                     ; 2BB3:  02
b00_abb4:   .db $02                     ; 2BB4:  02
b00_abb5:   .db $02                     ; 2BB5:  02
b00_abb6:   .db $02                     ; 2BB6:  02
b00_abb7:   .db $02                     ; 2BB7:  02
b00_abb8:   .db $02                     ; 2BB8:  02
b00_abb9:   .db $02                     ; 2BB9:  02
b00_abba:   .db $02                     ; 2BBA:  02
b00_abbb:   .db $02                     ; 2BBB:  02
b00_abbc:   .db $02                     ; 2BBC:  02
b00_abbd:   .db $02                     ; 2BBD:  02
b00_abbe:   .db $02                     ; 2BBE:  02
b00_abbf:   .db $02                     ; 2BBF:  02
b00_abc0:   .db $02                     ; 2BC0:  02
b00_abc1:   .db $02                     ; 2BC1:  02
b00_abc2:   .db $02                     ; 2BC2:  02
b00_abc3:   .db $02                     ; 2BC3:  02
b00_abc4:   .db $02                     ; 2BC4:  02
b00_abc5:   .db $02                     ; 2BC5:  02
b00_abc6:   .db $02                     ; 2BC6:  02
b00_abc7:   .db $02                     ; 2BC7:  02
b00_abc8:   .db $02                     ; 2BC8:  02
b00_abc9:   .db $02                     ; 2BC9:  02
b00_abca:   .db $02                     ; 2BCA:  02
b00_abcb:   .db $02                     ; 2BCB:  02
b00_abcc:   .db $02                     ; 2BCC:  02
b00_abcd:   .db $02                     ; 2BCD:  02
b00_abce:   .db $02                     ; 2BCE:  02
b00_abcf:   .db $02                     ; 2BCF:  02
b00_abd0:   .db $02                     ; 2BD0:  02
b00_abd1:   .db $02                     ; 2BD1:  02
b00_abd2:   .db $02                     ; 2BD2:  02
b00_abd3:   .db $02                     ; 2BD3:  02
b00_abd4:   .db $02                     ; 2BD4:  02
b00_abd5:   .db $02                     ; 2BD5:  02
b00_abd6:   .db $02                     ; 2BD6:  02
b00_abd7:   .db $02                     ; 2BD7:  02
b00_abd8:   .db $02                     ; 2BD8:  02
b00_abd9:   .db $02                     ; 2BD9:  02
b00_abda:   .db $02                     ; 2BDA:  02
b00_abdb:   .db $02                     ; 2BDB:  02
b00_abdc:   .db $02                     ; 2BDC:  02
b00_abdd:   .db $02                     ; 2BDD:  02
b00_abde:   .db $02                     ; 2BDE:  02
b00_abdf:   .db $02                     ; 2BDF:  02
b00_abe0:   .db $02                     ; 2BE0:  02
b00_abe1:   .db $02                     ; 2BE1:  02
b00_abe2:   .db $02                     ; 2BE2:  02
b00_abe3:   .db $02                     ; 2BE3:  02
b00_abe4:   .db $02                     ; 2BE4:  02
b00_abe5:   .db $02                     ; 2BE5:  02
b00_abe6:   .db $02                     ; 2BE6:  02
b00_abe7:   .db $02                     ; 2BE7:  02
b00_abe8:   .db $02                     ; 2BE8:  02
b00_abe9:   .db $02                     ; 2BE9:  02
b00_abea:   .db $02                     ; 2BEA:  02
b00_abeb:   .db $02                     ; 2BEB:  02
b00_abec:   .db $02                     ; 2BEC:  02
b00_abed:   .db $02                     ; 2BED:  02
b00_abee:   .db $02                     ; 2BEE:  02
b00_abef:   .db $02                     ; 2BEF:  02
b00_abf0:   .db $02                     ; 2BF0:  02
b00_abf1:   .db $02                     ; 2BF1:  02
b00_abf2:   .db $02                     ; 2BF2:  02
b00_abf3:   .db $02                     ; 2BF3:  02
b00_abf4:   .db $02                     ; 2BF4:  02
b00_abf5:   .db $02                     ; 2BF5:  02
b00_abf6:   .db $02                     ; 2BF6:  02
b00_abf7:   .db $02                     ; 2BF7:  02
b00_abf8:   .db $02                     ; 2BF8:  02
b00_abf9:   .db $02                     ; 2BF9:  02
b00_abfa:   .db $02                     ; 2BFA:  02
b00_abfb:   .db $02                     ; 2BFB:  02
b00_abfc:   .db $02                     ; 2BFC:  02
b00_abfd:   .db $02                     ; 2BFD:  02
b00_abfe:   .db $02                     ; 2BFE:  02
b00_abff:   .db $02                     ; 2BFF:  02
b00_ac00:   .db $02                     ; 2C00:  02
b00_ac01:   .db $02                     ; 2C01:  02
b00_ac02:   .db $02                     ; 2C02:  02
b00_ac03:   .db $02                     ; 2C03:  02
b00_ac04:   .db $02                     ; 2C04:  02
b00_ac05:   .db $02                     ; 2C05:  02
b00_ac06:   .db $02                     ; 2C06:  02
b00_ac07:   .db $02                     ; 2C07:  02
b00_ac08:   .db $02                     ; 2C08:  02
b00_ac09:   .db $02                     ; 2C09:  02
b00_ac0a:   .db $02                     ; 2C0A:  02
b00_ac0b:   .db $02                     ; 2C0B:  02
b00_ac0c:   .db $02                     ; 2C0C:  02
b00_ac0d:   .db $02                     ; 2C0D:  02
b00_ac0e:   .db $02                     ; 2C0E:  02
b00_ac0f:   .db $02                     ; 2C0F:  02
b00_ac10:   .db $02                     ; 2C10:  02
b00_ac11:   .db $02                     ; 2C11:  02
b00_ac12:   .db $02                     ; 2C12:  02
b00_ac13:   .db $02                     ; 2C13:  02
b00_ac14:   .db $02                     ; 2C14:  02
b00_ac15:   .db $02                     ; 2C15:  02
b00_ac16:   .db $02                     ; 2C16:  02
b00_ac17:   .db $02                     ; 2C17:  02
b00_ac18:   .db $02                     ; 2C18:  02
b00_ac19:   .db $02                     ; 2C19:  02
b00_ac1a:   .db $02                     ; 2C1A:  02
b00_ac1b:   .db $02                     ; 2C1B:  02
b00_ac1c:   .db $02                     ; 2C1C:  02
b00_ac1d:   .db $02                     ; 2C1D:  02
b00_ac1e:   .db $02                     ; 2C1E:  02
b00_ac1f:   .db $02                     ; 2C1F:  02
b00_ac20:   .db $02                     ; 2C20:  02
b00_ac21:   .db $02                     ; 2C21:  02
b00_ac22:   .db $02                     ; 2C22:  02
b00_ac23:   .db $02                     ; 2C23:  02
b00_ac24:   .db $02                     ; 2C24:  02
b00_ac25:   .db $02                     ; 2C25:  02
b00_ac26:   .db $02                     ; 2C26:  02
b00_ac27:   .db $02                     ; 2C27:  02
b00_ac28:   .db $02                     ; 2C28:  02
b00_ac29:   .db $02                     ; 2C29:  02
b00_ac2a:   .db $02                     ; 2C2A:  02
b00_ac2b:   .db $02                     ; 2C2B:  02
b00_ac2c:   .db $02                     ; 2C2C:  02
b00_ac2d:   .db $02                     ; 2C2D:  02
b00_ac2e:   .db $02                     ; 2C2E:  02
b00_ac2f:   .db $02                     ; 2C2F:  02
b00_ac30:   .db $02                     ; 2C30:  02
b00_ac31:   .db $02                     ; 2C31:  02
b00_ac32:   .db $02                     ; 2C32:  02
b00_ac33:   .db $02                     ; 2C33:  02
b00_ac34:   .db $02                     ; 2C34:  02
b00_ac35:   .db $02                     ; 2C35:  02
b00_ac36:   .db $02                     ; 2C36:  02
b00_ac37:   .db $02                     ; 2C37:  02
b00_ac38:   .db $02                     ; 2C38:  02
b00_ac39:   .db $02                     ; 2C39:  02
b00_ac3a:   .db $02                     ; 2C3A:  02
b00_ac3b:   .db $02                     ; 2C3B:  02
b00_ac3c:   .db $02                     ; 2C3C:  02
b00_ac3d:   .db $02                     ; 2C3D:  02
b00_ac3e:   .db $02                     ; 2C3E:  02
b00_ac3f:   .db $02                     ; 2C3F:  02
b00_ac40:   .db $02                     ; 2C40:  02
b00_ac41:   .db $02                     ; 2C41:  02
b00_ac42:   .db $02                     ; 2C42:  02
b00_ac43:   .db $02                     ; 2C43:  02
b00_ac44:   .db $02                     ; 2C44:  02
b00_ac45:   .db $02                     ; 2C45:  02
b00_ac46:   .db $02                     ; 2C46:  02
b00_ac47:   .db $02                     ; 2C47:  02
b00_ac48:   .db $02                     ; 2C48:  02
b00_ac49:   .db $02                     ; 2C49:  02
b00_ac4a:   bmi $ac7d                   ; 2C4A:  30 31
b00_ac4c:   .db $37                     ; 2C4C:  37
b00_ac4d:   .db $3f                     ; 2C4D:  3f
b00_ac4e:   and ($30),y                 ; 2C4E:  31 30
b00_ac50:   bmi $ac52                   ; 2C50:  30 00
b00_ac52:   bmi $ac85                   ; 2C52:  30 31
b00_ac54:   .db $37                     ; 2C54:  37
b00_ac55:   .db $3f                     ; 2C55:  3f
b00_ac56:   and ($30),y                 ; 2C56:  31 30
b00_ac58:   bmi $ac5a                   ; 2C58:  30 00
b00_ac5a:   adc ($c3),y                 ; 2C5A:  71 c3
b00_ac5c:   asl $86                     ; 2C5C:  06 86
b00_ac5e:   dec $e3                     ; 2C5E:  c6 e3
b00_ac60:   adc ($00),y                 ; 2C60:  71 00
b00_ac62:   adc ($c3),y                 ; 2C62:  71 c3
b00_ac64:   asl $86                     ; 2C64:  06 86
b00_ac66:   dec $e3                     ; 2C66:  c6 e3
b00_ac68:   adc ($00),y                 ; 2C68:  71 00
b00_ac6a:   brk                         ; 2C6A:  00
b00_ac6b:   brk                         ; 2C6B:  00
b00_ac6c:   brk                         ; 2C6C:  00
b00_ac6d:   brk                         ; 2C6D:  00
b00_ac6e:   brk                         ; 2C6E:  00
b00_ac6f:   brk                         ; 2C6F:  00
b00_ac70:   brk                         ; 2C70:  00
b00_ac71:   brk                         ; 2C71:  00
b00_ac72:   brk                         ; 2C72:  00
b00_ac73:   brk                         ; 2C73:  00
b00_ac74:   brk                         ; 2C74:  00
b00_ac75:   brk                         ; 2C75:  00
b00_ac76:   brk                         ; 2C76:  00
b00_ac77:   brk                         ; 2C77:  00
b00_ac78:   brk                         ; 2C78:  00
b00_ac79:   brk                         ; 2C79:  00
b00_ac7a:   sed                         ; 2C7A:  f8
b00_ac7b:   .db $0c                     ; 2C7B:  0c
b00_ac7c:   asl $06                     ; 2C7C:  06 06
b00_ac7e:   asl $0c                     ; 2C7E:  06 0c
b00_ac80:   sed                         ; 2C80:  f8
b00_ac81:   brk                         ; 2C81:  00
b00_ac82:   sed                         ; 2C82:  f8
b00_ac83:   .db $0c                     ; 2C83:  0c
b00_ac84:   asl $06                     ; 2C84:  06 06
b00_ac86:   asl $0c                     ; 2C86:  06 0c
b00_ac88:   sed                         ; 2C88:  f8
b00_ac89:   brk                         ; 2C89:  00
b00_ac8a:   .db $7f                     ; 2C8A:  7f
b00_ac8b:   rts                         ; 2C8B:  60
b00_ac8c:   rts                         ; 2C8C:  60
b00_ac8d:   .db $7f                     ; 2C8D:  7f
b00_ac8e:   rts                         ; 2C8E:  60
b00_ac8f:   rts                         ; 2C8F:  60
b00_ac90:   .db $7f                     ; 2C90:  7f
b00_ac91:   brk                         ; 2C91:  00
b00_ac92:   .db $7f                     ; 2C92:  7f
b00_ac93:   rts                         ; 2C93:  60
b00_ac94:   rts                         ; 2C94:  60
b00_ac95:   .db $7f                     ; 2C95:  7f
b00_ac96:   rts                         ; 2C96:  60
b00_ac97:   rts                         ; 2C97:  60
b00_ac98:   .db $7f                     ; 2C98:  7f
b00_ac99:   brk                         ; 2C99:  00
b00_ac9a:   sty $0c0c                   ; 2C9A:  8c 0c 0c
b00_ac9d:   .db $0c                     ; 2C9D:  0c
b00_ac9e:   .db $0c                     ; 2C9E:  0c
b00_ac9f:   .db $0c                     ; 2C9F:  0c
b00_aca0:   sty $8c00                   ; 2CA0:  8c 00 8c
b00_aca3:   .db $0c                     ; 2CA3:  0c
b00_aca4:   .db $0c                     ; 2CA4:  0c
b00_aca5:   .db $0c                     ; 2CA5:  0c
b00_aca6:   .db $0c                     ; 2CA6:  0c
b00_aca7:   .db $0c                     ; 2CA7:  0c
b00_aca8:   sty $0100                   ; 2CA8:  8c 00 01
b00_acab:   ora ($01,x)                 ; 2CAB:  01 01
b00_acad:   ora ($01,x)                 ; 2CAD:  01 01
b00_acaf:   ora ($01,x)                 ; 2CAF:  01 01
b00_acb1:   brk                         ; 2CB1:  00
b00_acb2:   ora ($01,x)                 ; 2CB2:  01 01
b00_acb4:   ora ($01,x)                 ; 2CB4:  01 01
b00_acb6:   ora ($01,x)                 ; 2CB6:  01 01
b00_acb8:   ora ($00,x)                 ; 2CB8:  01 00
b00_acba:   .db $fc                     ; 2CBA:  fc
b00_acbb:   stx $86                     ; 2CBB:  86 86
b00_acbd:   .db $fc                     ; 2CBD:  fc
b00_acbe:   .db $80                     ; 2CBE:  80
b00_acbf:   .db $80                     ; 2CBF:  80
b00_acc0:   .db $80                     ; 2CC0:  80
b00_acc1:   brk                         ; 2CC1:  00
b00_acc2:   .db $fc                     ; 2CC2:  fc
b00_acc3:   stx $86                     ; 2CC3:  86 86
b00_acc5:   .db $fc                     ; 2CC5:  fc
b00_acc6:   .db $80                     ; 2CC6:  80
b00_acc7:   .db $80                     ; 2CC7:  80
b00_acc8:   .db $80                     ; 2CC8:  80
b00_acc9:   brk                         ; 2CC9:  00
b00_acca:   .db $7f                     ; 2CCA:  7f
b00_accb:   adc ($61,x)                 ; 2CCB:  61 61
b00_accd:   .db $7f                     ; 2CCD:  7f
b00_acce:   ror $63                     ; 2CCE:  66 63
b00_acd0:   adc ($00,x)                 ; 2CD0:  61 00
b00_acd2:   .db $7f                     ; 2CD2:  7f
b00_acd3:   adc ($61,x)                 ; 2CD3:  61 61
b00_acd5:   .db $7f                     ; 2CD5:  7f
b00_acd6:   ror $63                     ; 2CD6:  66 63
b00_acd8:   adc ($00,x)                 ; 2CD8:  61 00
b00_acda:   .db $1f                     ; 2CDA:  1f
b00_acdb:   tya                         ; 2CDB:  98
b00_acdc:   tya                         ; 2CDC:  98
b00_acdd:   .db $1f                     ; 2CDD:  1f
b00_acde:   clc                         ; 2CDE:  18
b00_acdf:   clc                         ; 2CDF:  18
b00_ace0:   .db $9f                     ; 2CE0:  9f
b00_ace1:   brk                         ; 2CE1:  00
b00_ace2:   .db $1f                     ; 2CE2:  1f
b00_ace3:   tya                         ; 2CE3:  98
b00_ace4:   tya                         ; 2CE4:  98
b00_ace5:   .db $1f                     ; 2CE5:  1f
b00_ace6:   clc                         ; 2CE6:  18
b00_ace7:   clc                         ; 2CE7:  18
b00_ace8:   .db $9f                     ; 2CE8:  9f
b00_ace9:   brk                         ; 2CE9:  00
b00_acea:   .db $e3                     ; 2CEA:  e3
b00_aceb:   asl $06                     ; 2CEB:  06 06
b00_aced:   .db $c3                     ; 2CED:  c3
b00_acee:   brk                         ; 2CEE:  00
b00_acef:   asl $e3                     ; 2CEF:  06 e3
b00_acf1:   brk                         ; 2CF1:  00
b00_acf2:   .db $e3                     ; 2CF2:  e3
b00_acf3:   asl $06                     ; 2CF3:  06 06
b00_acf5:   .db $c3                     ; 2CF5:  c3
b00_acf6:   brk                         ; 2CF6:  00
b00_acf7:   asl $e3                     ; 2CF7:  06 e3
b00_acf9:   brk                         ; 2CF9:  00
b00_acfa:   sbc ($19),y                 ; 2CFA:  f1 19
b00_acfc:   ora ($f1,x)                 ; 2CFC:  01 f1
b00_acfe:   ora $f119,y                 ; 2CFE:  19 19 f1
b00_ad01:   brk                         ; 2D01:  00
b00_ad02:   sbc ($19),y                 ; 2D02:  f1 19
b00_ad04:   ora ($f1,x)                 ; 2D04:  01 f1
b00_ad06:   ora $f119,y                 ; 2D06:  19 19 f1
b00_ad09:   brk                         ; 2D09:  00
b00_ad0a:   inc $8080,x                 ; 2D0A:  fe 80 80
b00_ad0d:   .db $fc                     ; 2D0D:  fc
b00_ad0e:   .db $80                     ; 2D0E:  80
b00_ad0f:   .db $80                     ; 2D0F:  80
b00_ad10:   inc $fe00,x                 ; 2D10:  fe 00 fe
b00_ad13:   .db $80                     ; 2D13:  80
b00_ad14:   .db $80                     ; 2D14:  80
b00_ad15:   .db $fc                     ; 2D15:  fc
b00_ad16:   .db $80                     ; 2D16:  80
b00_ad17:   .db $80                     ; 2D17:  80
b00_ad18:   inc $6100,x                 ; 2D18:  fe 00 61
b00_ad1b:   adc ($79),y                 ; 2D1B:  71 79
b00_ad1d:   adc $6367                   ; 2D1D:  6d 67 63
b00_ad20:   adc ($00,x)                 ; 2D20:  61 00
b00_ad22:   adc ($71,x)                 ; 2D22:  61 71
b00_ad24:   adc $676d,y                 ; 2D24:  79 6d 67
b00_ad27:   .db $63                     ; 2D27:  63
b00_ad28:   adc ($00,x)                 ; 2D28:  61 00
b00_ad2a:   .db $9f                     ; 2D2A:  9f
b00_ad2b:   sta ($81,x)                 ; 2D2B:  81 81
b00_ad2d:   sta ($81,x)                 ; 2D2D:  81 81
b00_ad2f:   sta ($81,x)                 ; 2D2F:  81 81
b00_ad31:   brk                         ; 2D31:  00
b00_ad32:   .db $9f                     ; 2D32:  9f
b00_ad33:   sta ($81,x)                 ; 2D33:  81 81
b00_ad35:   sta ($81,x)                 ; 2D35:  81 81
b00_ad37:   sta ($81,x)                 ; 2D37:  81 81
b00_ad39:   brk                         ; 2D39:  00
b00_ad3a:   sbc $8383,y                 ; 2D3A:  f9 83 83
b00_ad3d:   sta ($80,x)                 ; 2D3D:  81 80
b00_ad3f:   .db $83                     ; 2D3F:  83
b00_ad40:   sta ($00,x)                 ; 2D40:  81 00
b00_ad42:   sbc $8383,y                 ; 2D42:  f9 83 83
b00_ad45:   sta ($80,x)                 ; 2D45:  81 80
b00_ad47:   .db $83                     ; 2D47:  83
b00_ad48:   sta ($00,x)                 ; 2D48:  81 00
b00_ad4a:   sed                         ; 2D4A:  f8
b00_ad4b:   .db $0c                     ; 2D4B:  0c
b00_ad4c:   brk                         ; 2D4C:  00
b00_ad4d:   sed                         ; 2D4D:  f8
b00_ad4e:   .db $0c                     ; 2D4E:  0c
b00_ad4f:   .db $0c                     ; 2D4F:  0c
b00_ad50:   sed                         ; 2D50:  f8
b00_ad51:   brk                         ; 2D51:  00
b00_ad52:   sed                         ; 2D52:  f8
b00_ad53:   .db $0c                     ; 2D53:  0c
b00_ad54:   brk                         ; 2D54:  00
b00_ad55:   sed                         ; 2D55:  f8
b00_ad56:   .db $0c                     ; 2D56:  0c
b00_ad57:   .db $0c                     ; 2D57:  0c
b00_ad58:   sed                         ; 2D58:  f8
b00_ad59:   brk                         ; 2D59:  00
b00_ad5a:   brk                         ; 2D5A:  00
b00_ad5b:   brk                         ; 2D5B:  00
b00_ad5c:   brk                         ; 2D5C:  00
b00_ad5d:   brk                         ; 2D5D:  00
b00_ad5e:   .db $04                     ; 2D5E:  04
b00_ad5f:   brk                         ; 2D5F:  00
b00_ad60:   php                         ; 2D60:  08
b00_ad61:   php                         ; 2D61:  08
b00_ad62:   brk                         ; 2D62:  00
b00_ad63:   brk                         ; 2D63:  00
b00_ad64:   ora ($02,x)                 ; 2D64:  01 02
b00_ad66:   .db $02                     ; 2D66:  02
b00_ad67:   .db $04                     ; 2D67:  04
b00_ad68:   .db $04                     ; 2D68:  04
b00_ad69:   .db $04                     ; 2D69:  04
b00_ad6a:   php                         ; 2D6A:  08
b00_ad6b:   php                         ; 2D6B:  08
b00_ad6c:   asl $0704                   ; 2D6C:  0e 04 07
b00_ad6f:   .db $03                     ; 2D6F:  03
b00_ad70:   ora ($00,x)                 ; 2D70:  01 00
b00_ad72:   .db $04                     ; 2D72:  04
b00_ad73:   .db $04                     ; 2D73:  04
b00_ad74:   .db $02                     ; 2D74:  02
b00_ad75:   .db $02                     ; 2D75:  02
b00_ad76:   ora ($00,x)                 ; 2D76:  01 00
b00_ad78:   brk                         ; 2D78:  00
b00_ad79:   brk                         ; 2D79:  00
b00_ad7a:   lsr $873d,x                 ; 2D7A:  5e 3d 87
b00_ad7d:   ora $8c1a                   ; 2D7D:  0d 1a 8c
b00_ad80:   stx $c0                     ; 2D80:  86 c0
b00_ad82:   ror $00c3,x                 ; 2D82:  7e c3 00
b00_ad85:   .db $3c                     ; 2D85:  3c
b00_ad86:   ror $42                     ; 2D86:  66 42
b00_ad88:   rti                         ; 2D88:  40
b00_ad89:   rti                         ; 2D89:  40
b00_ad8a:   ora ($00,x)                 ; 2D8A:  01 00
b00_ad8c:   .db $80                     ; 2D8C:  80
b00_ad8d:   cmp #$cf                    ; 2D8D:  c9 cf
b00_ad8f:   .db $e3                     ; 2D8F:  e3
b00_ad90:   .db $63                     ; 2D90:  63
b00_ad91:   .db $63                     ; 2D91:  63
b00_ad92:   ora ($03,x)                 ; 2D92:  01 03
b00_ad94:   .db $87                     ; 2D94:  87
b00_ad95:   .db $47                     ; 2D95:  47
b00_ad96:   eor ($21,x)                 ; 2D96:  41 21
b00_ad98:   and ($21,x)                 ; 2D98:  21 21
b00_ad9a:   .db $80                     ; 2D9A:  80
b00_ad9b:   .db $c2                     ; 2D9B:  c2
b00_ad9c:   ldy #$c0                    ; 2D9C:  a0 c0
b00_ad9e:   sei                         ; 2D9E:  78
b00_ad9f:   rti                         ; 2D9F:  40
b00_ada0:   .db $80                     ; 2DA0:  80
b00_ada1:   .db $fc                     ; 2DA1:  fc
b00_ada2:   rti                         ; 2DA2:  40
b00_ada3:   .db $42                     ; 2DA3:  42
b00_ada4:   ror $3c                     ; 2DA4:  66 3c
b00_ada6:   brk                         ; 2DA6:  00
b00_ada7:   .db $c3                     ; 2DA7:  c3
b00_ada8:   ror $4200,x                 ; 2DA8:  7e 00 42
b00_adab:   .db $62                     ; 2DAB:  62
b00_adac:   .db $02                     ; 2DAC:  02
b00_adad:   .db $82                     ; 2DAD:  82
b00_adae:   .db $02                     ; 2DAE:  02
b00_adaf:   .db $02                     ; 2DAF:  02
b00_adb0:   .db $02                     ; 2DB0:  02
b00_adb1:   .db $03                     ; 2DB1:  03
b00_adb2:   and ($21,x)                 ; 2DB2:  21 21
b00_adb4:   eor ($41,x)                 ; 2DB4:  41 41
b00_adb6:   sta ($01,x)                 ; 2DB6:  81 01
b00_adb8:   ora ($00,x)                 ; 2DB8:  01 00
b00_adba:   .db $82                     ; 2DBA:  82
b00_adbb:   .db $80                     ; 2DBB:  80
b00_adbc:   sta ($90,x)                 ; 2DBC:  81 90
b00_adbe:   sty $90,x                   ; 2DBE:  94 90
b00_adc0:   sty $12,x                   ; 2DC0:  94 12
b00_adc2:   .db $83                     ; 2DC2:  83
b00_adc3:   .db $87                     ; 2DC3:  87
b00_adc4:   stx $8c8c                   ; 2DC4:  8e 8c 8c
b00_adc7:   sty $8e8c                   ; 2DC7:  8c 8c 8e
b00_adca:   cpy #$20                    ; 2DCA:  c0 20
b00_adcc:   bcs $adc3                   ; 2DCC:  b0 f5
b00_adce:   adc $77,x                   ; 2DCE:  75 77
b00_add0:   lsr $17,x                   ; 2DD0:  56 17
b00_add2:   cpy #$e1                    ; 2DD2:  c0 e1
b00_add4:   .db $73                     ; 2DD4:  73
b00_add5:   .db $33                     ; 2DD5:  33
b00_add6:   .db $33                     ; 2DD6:  33
b00_add7:   .db $33                     ; 2DD7:  33
b00_add8:   .db $33                     ; 2DD8:  33
b00_add9:   adc ($9f),y                 ; 2DD9:  71 9f
b00_addb:   asl $1487                   ; 2DDB:  0e 87 14
b00_adde:   .db $92                     ; 2DDE:  92
b00_addf:   ora $870e,y                 ; 2DDF:  19 0e 87
b00_ade2:   .db $87                     ; 2DE2:  87
b00_ade3:   .db $83                     ; 2DE3:  83
b00_ade4:   sty $8e8c                   ; 2DE4:  8c 8c 8e
b00_ade7:   .db $87                     ; 2DE7:  87
b00_ade8:   .db $83                     ; 2DE8:  83
b00_ade9:   brk                         ; 2DE9:  00
b00_adea:   .db $02                     ; 2DEA:  02
b00_adeb:   .db $14                     ; 2DEB:  14
b00_adec:   cpx $54                     ; 2DEC:  e4 54
b00_adee:   .db $04                     ; 2DEE:  04
b00_adef:   .db $07                     ; 2DEF:  07
b00_adf0:   .db $03                     ; 2DF0:  03
b00_adf1:   sta ($f3,x)                 ; 2DF1:  81 f3
b00_adf3:   .db $f3                     ; 2DF3:  f3
b00_adf4:   .db $33                     ; 2DF4:  33
b00_adf5:   .db $33                     ; 2DF5:  33
b00_adf6:   .db $73                     ; 2DF6:  73
b00_adf7:   sbc ($c0,x)                 ; 2DF7:  e1 c0
b00_adf9:   brk                         ; 2DF9:  00
b00_adfa:   bcs $ae34                   ; 2DFA:  b0 38
b00_adfc:   .db $7c                     ; 2DFC:  7c
b00_adfd:   and $1115,x                 ; 2DFD:  3d 15 11
b00_ae00:   sta $09                     ; 2E00:  85 09
b00_ae02:   beq $adfc                   ; 2E02:  f0 f8
b00_ae04:   .db $9c                     ; 2E04:  9c
b00_ae05:   .db $0c                     ; 2E05:  0c
b00_ae06:   .db $0c                     ; 2E06:  0c
b00_ae07:   .db $0c                     ; 2E07:  0c
b00_ae08:   .db $9c                     ; 2E08:  9c
b00_ae09:   sed                         ; 2E09:  f8
b00_ae0a:   bit $1f0e                   ; 2E0A:  2c 0e 1f
b00_ae0d:   .db $0f                     ; 2E0D:  0f
b00_ae0e:   eor $c4                     ; 2E0E:  45 c4
b00_ae10:   eor $c2                     ; 2E10:  45 c2
b00_ae12:   .db $3c                     ; 2E12:  3c
b00_ae13:   ror $c3e7,x                 ; 2E13:  7e e7 c3
b00_ae16:   .db $c3                     ; 2E16:  c3
b00_ae17:   .db $c3                     ; 2E17:  c3
b00_ae18:   .db $c3                     ; 2E18:  c3
b00_ae19:   .db $e7                     ; 2E19:  e7
b00_ae1a:   adc $3c,x                   ; 2E1A:  75 3c
b00_ae1c:   .db $14                     ; 2E1C:  14
b00_ae1d:   bpl $ada4                   ; 2E1D:  10 85
b00_ae1f:   eor ($80,x)                 ; 2E1F:  41 80
b00_ae21:   cpx #$9c                    ; 2E21:  e0 9c
b00_ae23:   .db $0c                     ; 2E23:  0c
b00_ae24:   .db $0c                     ; 2E24:  0c
b00_ae25:   .db $0c                     ; 2E25:  0c
b00_ae26:   .db $9c                     ; 2E26:  9c
b00_ae27:   sed                         ; 2E27:  f8
b00_ae28:   beq $ae2a                   ; 2E28:  f0 00
b00_ae2a:   lda $c3                     ; 2E2A:  a5 c3
b00_ae2c:   adc $2104,x                 ; 2E2C:  7d 04 21
b00_ae2f:   bne $ae11                   ; 2E2F:  d0 e0
b00_ae31:   sei                         ; 2E31:  78
b00_ae32:   .db $7f                     ; 2E32:  7f
b00_ae33:   .db $3f                     ; 2E33:  3f
b00_ae34:   .db $03                     ; 2E34:  03
b00_ae35:   .db $c3                     ; 2E35:  c3
b00_ae36:   .db $e7                     ; 2E36:  e7
b00_ae37:   ror $003c,x                 ; 2E37:  7e 3c 00
b00_ae3a:   brk                         ; 2E3A:  00
b00_ae3b:   ora ($01,x)                 ; 2E3B:  01 01
b00_ae3d:   ora ($01,x)                 ; 2E3D:  01 01
b00_ae3f:   ora ($01,x)                 ; 2E3F:  01 01
b00_ae41:   ora ($00,x)                 ; 2E41:  01 00
b00_ae43:   brk                         ; 2E43:  00
b00_ae44:   brk                         ; 2E44:  00
b00_ae45:   brk                         ; 2E45:  00
b00_ae46:   brk                         ; 2E46:  00
b00_ae47:   brk                         ; 2E47:  00
b00_ae48:   brk                         ; 2E48:  00
b00_ae49:   brk                         ; 2E49:  00
b00_ae4a:   cpx #$20                    ; 2E4A:  e0 20
b00_ae4c:   jsr $2221                   ; 2E4C:  20 21 22
b00_ae4f:   .db $64                     ; 2E4F:  64
b00_ae50:   cpy $e092                   ; 2E50:  cc 92 e0
b00_ae53:   sbc ($e3,x)                 ; 2E53:  e1 e3
b00_ae55:   .db $e7                     ; 2E55:  e7
b00_ae56:   .db $ef                     ; 2E56:  ef
b00_ae57:   inc $fefc,x                 ; 2E57:  fe fc fe
b00_ae5a:   ora ($01,x)                 ; 2E5A:  01 01
b00_ae5c:   ora ($01,x)                 ; 2E5C:  01 01
b00_ae5e:   ora ($01,x)                 ; 2E5E:  01 01
b00_ae60:   ora ($01,x)                 ; 2E60:  01 01
b00_ae62:   brk                         ; 2E62:  00
b00_ae63:   brk                         ; 2E63:  00
b00_ae64:   brk                         ; 2E64:  00
b00_ae65:   brk                         ; 2E65:  00
b00_ae66:   brk                         ; 2E66:  00
b00_ae67:   brk                         ; 2E67:  00
b00_ae68:   brk                         ; 2E68:  00
b00_ae69:   brk                         ; 2E69:  00
b00_ae6a:   and ($59,x)                 ; 2E6A:  21 59
b00_ae6c:   lda $2727                   ; 2E6C:  ad 27 27
b00_ae6f:   .db $03                     ; 2E6F:  03
b00_ae70:   and ($c0,x)                 ; 2E70:  21 c0
b00_ae72:   .db $ff                     ; 2E72:  ff
b00_ae73:   .db $e7                     ; 2E73:  e7
b00_ae74:   .db $e3                     ; 2E74:  e3
b00_ae75:   .db $e3                     ; 2E75:  e3
b00_ae76:   sbc ($e0,x)                 ; 2E76:  e1 e0
b00_ae78:   cpx #$00                    ; 2E78:  e0 00
b00_ae7a:   sbc ($40),y                 ; 2E7A:  f1 40
b00_ae7c:   .db $80                     ; 2E7C:  80
b00_ae7d:   brk                         ; 2E7D:  00
b00_ae7e:   bpl $ae80                   ; 2E7E:  10 00
b00_ae80:   jsr $f120                   ; 2E80:  20 20 f1
b00_ae83:   .db $e3                     ; 2E83:  e3
b00_ae84:   .db $c7                     ; 2E84:  c7
b00_ae85:   stx $1c0c                   ; 2E85:  8e 0c 1c
b00_ae88:   .db $1c                     ; 2E88:  1c
b00_ae89:   .db $1c                     ; 2E89:  1c
b00_ae8a:   sei                         ; 2E8A:  78
b00_ae8b:   .db $1c                     ; 2E8B:  1c
b00_ae8c:   inc $0d1d,x                 ; 2E8C:  fe 1d 0d
b00_ae8f:   .db $04                     ; 2E8F:  04
b00_ae90:   ora $06                     ; 2E90:  05 06
b00_ae92:   sed                         ; 2E92:  f8
b00_ae93:   .db $fc                     ; 2E93:  fc
b00_ae94:   asl $0307                   ; 2E94:  0e 07 03
b00_ae97:   .db $03                     ; 2E97:  03
b00_ae98:   .db $03                     ; 2E98:  03
b00_ae99:   .db $03                     ; 2E99:  03
b00_ae9a:   bit $2c                     ; 2E9A:  24 2c
b00_ae9c:   ldy $39de,x                 ; 2E9C:  bc de 39
b00_ae9f:   bit $e396                   ; 2E9F:  2c 96 e3
b00_aea2:   .db $1c                     ; 2EA2:  1c
b00_aea3:   .db $1c                     ; 2EA3:  1c
b00_aea4:   sty $e7ce                   ; 2EA4:  8c ce e7
b00_aea7:   .db $e3                     ; 2EA7:  e3
b00_aea8:   adc ($00),y                 ; 2EA8:  71 00
b00_aeaa:   .db $04                     ; 2EAA:  04
b00_aeab:   .db $04                     ; 2EAB:  04
b00_aeac:   .db $04                     ; 2EAC:  04
b00_aead:   brk                         ; 2EAD:  00
b00_aeae:   brk                         ; 2EAE:  00
b00_aeaf:   cpy #$80                    ; 2EAF:  c0 80
b00_aeb1:   beq $aeb6                   ; 2EB1:  f0 03
b00_aeb3:   .db $03                     ; 2EB3:  03
b00_aeb4:   .db $03                     ; 2EB4:  03
b00_aeb5:   .db $07                     ; 2EB5:  07
b00_aeb6:   asl $f8fc                   ; 2EB6:  0e fc f8
b00_aeb9:   brk                         ; 2EB9:  00
b00_aeba:   .db $3a                     ; 2EBA:  3a
b00_aebb:   bvc $af24                   ; 2EBB:  50 67
b00_aebd:   rti                         ; 2EBD:  40
b00_aebe:   rti                         ; 2EBE:  40
b00_aebf:   cpy #$c2                    ; 2EBF:  c0 c2
b00_aec1:   cpy $3f                     ; 2EC1:  c4 3f
b00_aec3:   .db $3f                     ; 2EC3:  3f
b00_aec4:   sec                         ; 2EC4:  38
b00_aec5:   sec                         ; 2EC5:  38
b00_aec6:   sec                         ; 2EC6:  38
b00_aec7:   clv                         ; 2EC7:  b8
b00_aec8:   .db $bf                     ; 2EC8:  bf
b00_aec9:   .db $bf                     ; 2EC9:  bf
b00_aeca:   sbc $f21a,y                 ; 2ECA:  f9 1a f2
b00_aecd:   .db $02                     ; 2ECD:  02
b00_aece:   .db $02                     ; 2ECE:  02
b00_aecf:   .db $03                     ; 2ECF:  03
b00_aed0:   .db $fb                     ; 2ED0:  fb
b00_aed1:   .db $63                     ; 2ED1:  63
b00_aed2:   sbc $01f9,y                 ; 2ED2:  f9 f9 01
b00_aed5:   ora ($01,x)                 ; 2ED5:  01 01
b00_aed7:   ora ($f9,x)                 ; 2ED7:  01 f9
b00_aed9:   sbc $d04f,y                 ; 2ED9:  f9 4f d0
b00_aedc:   rts                         ; 2EDC:  60
b00_aedd:   rti                         ; 2EDD:  40
b00_aede:   rti                         ; 2EDE:  40
b00_aedf:   jmp $7f59                   ; 2EDF:  4c 59 7f
b00_aee2:   clv                         ; 2EE2:  b8
b00_aee3:   clv                         ; 2EE3:  b8
b00_aee4:   sec                         ; 2EE4:  38
b00_aee5:   sec                         ; 2EE5:  38
b00_aee6:   sec                         ; 2EE6:  38
b00_aee7:   .db $3f                     ; 2EE7:  3f
b00_aee8:   .db $3f                     ; 2EE8:  3f
b00_aee9:   brk                         ; 2EE9:  00
b00_aeea:   .db $f2                     ; 2EEA:  f2
b00_aeeb:   .db $02                     ; 2EEB:  02
b00_aeec:   .db $03                     ; 2EEC:  03
b00_aeed:   .db $02                     ; 2EED:  02
b00_aeee:   .db $02                     ; 2EEE:  02
b00_aeef:   .db $c2                     ; 2EEF:  c2
b00_aef0:   .db $82                     ; 2EF0:  82
b00_aef1:   .db $f3                     ; 2EF1:  f3
b00_aef2:   ora ($01,x)                 ; 2EF2:  01 01
b00_aef4:   ora ($01,x)                 ; 2EF4:  01 01
b00_aef6:   ora ($f9,x)                 ; 2EF6:  01 f9
b00_aef8:   sbc $e000,y                 ; 2EF8:  f9 00 e0
b00_aefb:   jsr $6020                   ; 2EFB:  20 20 60
b00_aefe:   cpx #$e0                    ; 2EFE:  e0 e0
b00_af00:   ldy #$20                    ; 2F00:  a0 20
b00_af02:   cpx #$e0                    ; 2F02:  e0 e0
b00_af04:   cpx #$e0                    ; 2F04:  e0 e0
b00_af06:   cpx #$e0                    ; 2F06:  e0 e0
b00_af08:   cpx #$e0                    ; 2F08:  e0 e0
b00_af0a:   rts                         ; 2F0A:  60
b00_af0b:   .db $80                     ; 2F0B:  80
b00_af0c:   jsr $0000                   ; 2F0C:  20 00 00
b00_af0f:   jsr $c000                   ; 2F0F:  20 00 c0
b00_af12:   cpx #$e0                    ; 2F12:  e0 e0
b00_af14:   cpx #$e0                    ; 2F14:  e0 e0
b00_af16:   cpx #$e0                    ; 2F16:  e0 e0
b00_af18:   cpx #$00                    ; 2F18:  e0 00
b00_af1a:   brk                         ; 2F1A:  00
b00_af1b:   brk                         ; 2F1B:  00
b00_af1c:   brk                         ; 2F1C:  00
b00_af1d:   brk                         ; 2F1D:  00
b00_af1e:   .db $03                     ; 2F1E:  03
b00_af1f:   .db $03                     ; 2F1F:  03
b00_af20:   .db $03                     ; 2F20:  03
b00_af21:   .db $03                     ; 2F21:  03
b00_af22:   brk                         ; 2F22:  00
b00_af23:   brk                         ; 2F23:  00
b00_af24:   brk                         ; 2F24:  00
b00_af25:   brk                         ; 2F25:  00
b00_af26:   .db $03                     ; 2F26:  03
b00_af27:   .db $03                     ; 2F27:  03
b00_af28:   .db $03                     ; 2F28:  03
b00_af29:   .db $03                     ; 2F29:  03
b00_af2a:   brk                         ; 2F2A:  00
b00_af2b:   brk                         ; 2F2B:  00
b00_af2c:   brk                         ; 2F2C:  00
b00_af2d:   brk                         ; 2F2D:  00
b00_af2e:   asl $8e                     ; 2F2E:  06 8e
b00_af30:   dec $0076,x                 ; 2F30:  de 76 00
b00_af33:   brk                         ; 2F33:  00
b00_af34:   brk                         ; 2F34:  00
b00_af35:   brk                         ; 2F35:  00
b00_af36:   asl $8e                     ; 2F36:  06 8e
b00_af38:   dec $0376,x                 ; 2F38:  de 76 03
b00_af3b:   .db $03                     ; 2F3B:  03
b00_af3c:   .db $03                     ; 2F3C:  03
b00_af3d:   brk                         ; 2F3D:  00
b00_af3e:   brk                         ; 2F3E:  00
b00_af3f:   brk                         ; 2F3F:  00
b00_af40:   brk                         ; 2F40:  00
b00_af41:   brk                         ; 2F41:  00
b00_af42:   .db $03                     ; 2F42:  03
b00_af43:   .db $03                     ; 2F43:  03
b00_af44:   .db $03                     ; 2F44:  03
b00_af45:   brk                         ; 2F45:  00
b00_af46:   brk                         ; 2F46:  00
b00_af47:   brk                         ; 2F47:  00
b00_af48:   brk                         ; 2F48:  00
b00_af49:   brk                         ; 2F49:  00
b00_af4a:   rol $06                     ; 2F4A:  26 06
b00_af4c:   asl $00                     ; 2F4C:  06 00
b00_af4e:   brk                         ; 2F4E:  00
b00_af4f:   brk                         ; 2F4F:  00
b00_af50:   brk                         ; 2F50:  00
b00_af51:   brk                         ; 2F51:  00
b00_af52:   rol $06                     ; 2F52:  26 06
b00_af54:   asl $00                     ; 2F54:  06 00
b00_af56:   brk                         ; 2F56:  00
b00_af57:   brk                         ; 2F57:  00
b00_af58:   brk                         ; 2F58:  00
b00_af59:   brk                         ; 2F59:  00
b00_af5a:   brk                         ; 2F5A:  00
b00_af5b:   brk                         ; 2F5B:  00
b00_af5c:   brk                         ; 2F5C:  00
b00_af5d:   brk                         ; 2F5D:  00
b00_af5e:   .db $0f                     ; 2F5E:  0f
b00_af5f:   ora $3019,y                 ; 2F5F:  19 19 30
b00_af62:   brk                         ; 2F62:  00
b00_af63:   brk                         ; 2F63:  00
b00_af64:   brk                         ; 2F64:  00
b00_af65:   brk                         ; 2F65:  00
b00_af66:   .db $0f                     ; 2F66:  0f
b00_af67:   ora $3019,y                 ; 2F67:  19 19 30
b00_af6a:   brk                         ; 2F6A:  00
b00_af6b:   brk                         ; 2F6B:  00
b00_af6c:   brk                         ; 2F6C:  00
b00_af6d:   brk                         ; 2F6D:  00
b00_af6e:   .db $07                     ; 2F6E:  07
b00_af6f:   stx $86                     ; 2F6F:  86 86
b00_af71:   dec $00                     ; 2F71:  c6 00
b00_af73:   brk                         ; 2F73:  00
b00_af74:   brk                         ; 2F74:  00
b00_af75:   brk                         ; 2F75:  00
b00_af76:   .db $07                     ; 2F76:  07
b00_af77:   stx $86                     ; 2F77:  86 86
b00_af79:   dec $3f                     ; 2F79:  c6 3f
b00_af7b:   rts                         ; 2F7B:  60
b00_af7c:   rts                         ; 2F7C:  60
b00_af7d:   brk                         ; 2F7D:  00
b00_af7e:   brk                         ; 2F7E:  00
b00_af7f:   brk                         ; 2F7F:  00
b00_af80:   brk                         ; 2F80:  00
b00_af81:   brk                         ; 2F81:  00
b00_af82:   .db $3f                     ; 2F82:  3f
b00_af83:   rts                         ; 2F83:  60
b00_af84:   rts                         ; 2F84:  60
b00_af85:   brk                         ; 2F85:  00
b00_af86:   brk                         ; 2F86:  00
b00_af87:   brk                         ; 2F87:  00
b00_af88:   brk                         ; 2F88:  00
b00_af89:   brk                         ; 2F89:  00
b00_af8a:   dec $66                     ; 2F8A:  c6 66
b00_af8c:   .db $67                     ; 2F8C:  67
b00_af8d:   brk                         ; 2F8D:  00
b00_af8e:   brk                         ; 2F8E:  00
b00_af8f:   brk                         ; 2F8F:  00
b00_af90:   brk                         ; 2F90:  00
b00_af91:   brk                         ; 2F91:  00
b00_af92:   dec $66                     ; 2F92:  c6 66
b00_af94:   .db $67                     ; 2F94:  67
b00_af95:   brk                         ; 2F95:  00
b00_af96:   brk                         ; 2F96:  00
b00_af97:   brk                         ; 2F97:  00
b00_af98:   brk                         ; 2F98:  00
b00_af99:   brk                         ; 2F99:  00
b00_af9a:   brk                         ; 2F9A:  00
b00_af9b:   brk                         ; 2F9B:  00
b00_af9c:   brk                         ; 2F9C:  00
b00_af9d:   brk                         ; 2F9D:  00
b00_af9e:   sbc ($31,x)                 ; 2F9E:  e1 31
b00_afa0:   ora $0019,y                 ; 2FA0:  19 19 00
b00_afa3:   brk                         ; 2FA3:  00
b00_afa4:   brk                         ; 2FA4:  00
b00_afa5:   brk                         ; 2FA5:  00
b00_afa6:   sbc ($31,x)                 ; 2FA6:  e1 31
b00_afa8:   ora $0019,y                 ; 2FA8:  19 19 00
b00_afab:   brk                         ; 2FAB:  00
b00_afac:   brk                         ; 2FAC:  00
b00_afad:   brk                         ; 2FAD:  00
b00_afae:   inc $8080,x                 ; 2FAE:  fe 80 80
b00_afb1:   .db $fc                     ; 2FB1:  fc
b00_afb2:   brk                         ; 2FB2:  00
b00_afb3:   brk                         ; 2FB3:  00
b00_afb4:   brk                         ; 2FB4:  00
b00_afb5:   brk                         ; 2FB5:  00
b00_afb6:   inc $8080,x                 ; 2FB6:  fe 80 80
b00_afb9:   .db $fc                     ; 2FB9:  fc
b00_afba:   ora $e131,y                 ; 2FBA:  19 31 e1
b00_afbd:   brk                         ; 2FBD:  00
b00_afbe:   brk                         ; 2FBE:  00
b00_afbf:   brk                         ; 2FBF:  00
b00_afc0:   brk                         ; 2FC0:  00
b00_afc1:   brk                         ; 2FC1:  00
b00_afc2:   ora $e131,y                 ; 2FC2:  19 31 e1
b00_afc5:   brk                         ; 2FC5:  00
b00_afc6:   brk                         ; 2FC6:  00
b00_afc7:   brk                         ; 2FC7:  00
b00_afc8:   brk                         ; 2FC8:  00
b00_afc9:   brk                         ; 2FC9:  00
b00_afca:   .db $80                     ; 2FCA:  80
b00_afcb:   .db $80                     ; 2FCB:  80
b00_afcc:   inc $0000,x                 ; 2FCC:  fe 00 00
b00_afcf:   brk                         ; 2FCF:  00
b00_afd0:   brk                         ; 2FD0:  00
b00_afd1:   brk                         ; 2FD1:  00
b00_afd2:   .db $80                     ; 2FD2:  80
b00_afd3:   .db $80                     ; 2FD3:  80
b00_afd4:   inc $0000,x                 ; 2FD4:  fe 00 00
b00_afd7:   brk                         ; 2FD7:  00
b00_afd8:   brk                         ; 2FD8:  00
b00_afd9:   brk                         ; 2FD9:  00
b00_afda:   brk                         ; 2FDA:  00
b00_afdb:   brk                         ; 2FDB:  00
b00_afdc:   brk                         ; 2FDC:  00
b00_afdd:   brk                         ; 2FDD:  00
b00_afde:   bmi $b018                   ; 2FDE:  30 38
b00_afe0:   .db $3c                     ; 2FE0:  3c
b00_afe1:   rol $00,x                   ; 2FE1:  36 00
b00_afe3:   brk                         ; 2FE3:  00
b00_afe4:   brk                         ; 2FE4:  00
b00_afe5:   brk                         ; 2FE5:  00
b00_afe6:   bmi $b020                   ; 2FE6:  30 38
b00_afe8:   .db $3c                     ; 2FE8:  3c
b00_afe9:   rol $33,x                   ; 2FE9:  36 33
b00_afeb:   and ($30),y                 ; 2FEB:  31 30
b00_afed:   brk                         ; 2FED:  00
b00_afee:   brk                         ; 2FEE:  00
b00_afef:   brk                         ; 2FEF:  00
b00_aff0:   brk                         ; 2FF0:  00
b00_aff1:   brk                         ; 2FF1:  00
b00_aff2:   .db $33                     ; 2FF2:  33
b00_aff3:   and ($30),y                 ; 2FF3:  31 30
b00_aff5:   brk                         ; 2FF5:  00
b00_aff6:   brk                         ; 2FF6:  00
b00_aff7:   brk                         ; 2FF7:  00
b00_aff8:   brk                         ; 2FF8:  00
b00_aff9:   brk                         ; 2FF9:  00
b00_affa:   brk                         ; 2FFA:  00
b00_affb:   brk                         ; 2FFB:  00
b00_affc:   brk                         ; 2FFC:  00
b00_affd:   brk                         ; 2FFD:  00
b00_affe:   cpy #$c0                    ; 2FFE:  c0 c0
b00_b000:   cpy #$c0                    ; 3000:  c0 c0
b00_b002:   brk                         ; 3002:  00
b00_b003:   brk                         ; 3003:  00
b00_b004:   brk                         ; 3004:  00
b00_b005:   brk                         ; 3005:  00
b00_b006:   cpy #$c0                    ; 3006:  c0 c0
b00_b008:   cpy #$c0                    ; 3008:  c0 c0
b00_b00a:   brk                         ; 300A:  00
b00_b00b:   brk                         ; 300B:  00
b00_b00c:   brk                         ; 300C:  00
b00_b00d:   brk                         ; 300D:  00
b00_b00e:   asl $06                     ; 300E:  06 06
b00_b010:   asl $06                     ; 3010:  06 06
b00_b012:   brk                         ; 3012:  00
b00_b013:   brk                         ; 3013:  00
b00_b014:   brk                         ; 3014:  00
b00_b015:   brk                         ; 3015:  00
b00_b016:   asl $06                     ; 3016:  06 06
b00_b018:   asl $06                     ; 3018:  06 06
b00_b01a:   cpy #$c0                    ; 301A:  c0 c0
b00_b01c:   cpy #$00                    ; 301C:  c0 00
b00_b01e:   brk                         ; 301E:  00
b00_b01f:   brk                         ; 301F:  00
b00_b020:   brk                         ; 3020:  00
b00_b021:   brk                         ; 3021:  00
b00_b022:   cpy #$c0                    ; 3022:  c0 c0
b00_b024:   cpy #$00                    ; 3024:  c0 00
b00_b026:   brk                         ; 3026:  00
b00_b027:   brk                         ; 3027:  00
b00_b028:   brk                         ; 3028:  00
b00_b029:   brk                         ; 3029:  00
b00_b02a:   dec $c6                     ; 302A:  c6 c6
b00_b02c:   .db $7c                     ; 302C:  7c
b00_b02d:   brk                         ; 302D:  00
b00_b02e:   brk                         ; 302E:  00
b00_b02f:   brk                         ; 302F:  00
b00_b030:   brk                         ; 3030:  00
b00_b031:   brk                         ; 3031:  00
b00_b032:   dec $c6                     ; 3032:  c6 c6
b00_b034:   .db $7c                     ; 3034:  7c
b00_b035:   brk                         ; 3035:  00
b00_b036:   brk                         ; 3036:  00
b00_b037:   brk                         ; 3037:  00
b00_b038:   brk                         ; 3038:  00
b00_b039:   brk                         ; 3039:  00
b00_b03a:   brk                         ; 303A:  00
b00_b03b:   brk                         ; 303B:  00
b00_b03c:   brk                         ; 303C:  00
b00_b03d:   brk                         ; 303D:  00
b00_b03e:   .db $07                     ; 303E:  07
b00_b03f:   stx $86                     ; 303F:  86 86
b00_b041:   .db $c7                     ; 3041:  c7
b00_b042:   brk                         ; 3042:  00
b00_b043:   brk                         ; 3043:  00
b00_b044:   brk                         ; 3044:  00
b00_b045:   brk                         ; 3045:  00
b00_b046:   .db $07                     ; 3046:  07
b00_b047:   stx $86                     ; 3047:  86 86
b00_b049:   .db $c7                     ; 3049:  c7
b00_b04a:   dec $66                     ; 304A:  c6 66
b00_b04c:   ror $00                     ; 304C:  66 00
b00_b04e:   brk                         ; 304E:  00
b00_b04f:   brk                         ; 304F:  00
b00_b050:   brk                         ; 3050:  00
b00_b051:   brk                         ; 3051:  00
b00_b052:   dec $66                     ; 3052:  c6 66
b00_b054:   ror $00                     ; 3054:  66 00
b00_b056:   brk                         ; 3056:  00
b00_b057:   brk                         ; 3057:  00
b00_b058:   brk                         ; 3058:  00
b00_b059:   brk                         ; 3059:  00
b00_b05a:   brk                         ; 305A:  00
b00_b05b:   brk                         ; 305B:  00
b00_b05c:   brk                         ; 305C:  00
b00_b05d:   brk                         ; 305D:  00
b00_b05e:   beq $b078                   ; 305E:  f0 18
b00_b060:   clc                         ; 3060:  18
b00_b061:   sbc ($00),y                 ; 3061:  f1 00
b00_b063:   brk                         ; 3063:  00
b00_b064:   brk                         ; 3064:  00
b00_b065:   brk                         ; 3065:  00
b00_b066:   beq $b080                   ; 3066:  f0 18
b00_b068:   clc                         ; 3068:  18
b00_b069:   sbc ($00),y                 ; 3069:  f1 00
b00_b06b:   brk                         ; 306B:  00
b00_b06c:   brk                         ; 306C:  00
b00_b06d:   brk                         ; 306D:  00
b00_b06e:   sei                         ; 306E:  78
b00_b06f:   cpy $86cc                   ; 306F:  cc cc 86
b00_b072:   brk                         ; 3072:  00
b00_b073:   brk                         ; 3073:  00
b00_b074:   brk                         ; 3074:  00
b00_b075:   brk                         ; 3075:  00
b00_b076:   sei                         ; 3076:  78
b00_b077:   cpy $86cc                   ; 3077:  cc cc 86
b00_b07a:   ora ($03,x)                 ; 307A:  01 03
b00_b07c:   .db $03                     ; 307C:  03
b00_b07d:   brk                         ; 307D:  00
b00_b07e:   brk                         ; 307E:  00
b00_b07f:   brk                         ; 307F:  00
b00_b080:   brk                         ; 3080:  00
b00_b081:   brk                         ; 3081:  00
b00_b082:   ora ($03,x)                 ; 3082:  01 03
b00_b084:   .db $03                     ; 3084:  03
b00_b085:   brk                         ; 3085:  00
b00_b086:   brk                         ; 3086:  00
b00_b087:   brk                         ; 3087:  00
b00_b088:   brk                         ; 3088:  00
b00_b089:   brk                         ; 3089:  00
b00_b08a:   inc $0303,x                 ; 308A:  fe 03 03
b00_b08d:   brk                         ; 308D:  00
b00_b08e:   brk                         ; 308E:  00
b00_b08f:   brk                         ; 308F:  00
b00_b090:   brk                         ; 3090:  00
b00_b091:   brk                         ; 3091:  00
b00_b092:   inc $0303,x                 ; 3092:  fe 03 03
b00_b095:   brk                         ; 3095:  00
b00_b096:   brk                         ; 3096:  00
b00_b097:   brk                         ; 3097:  00
b00_b098:   brk                         ; 3098:  00
b00_b099:   brk                         ; 3099:  00
b00_b09a:   brk                         ; 309A:  00
b00_b09b:   brk                         ; 309B:  00
b00_b09c:   brk                         ; 309C:  00
b00_b09d:   brk                         ; 309D:  00
b00_b09e:   clc                         ; 309E:  18
b00_b09f:   .db $1c                     ; 309F:  1c
b00_b0a0:   asl $001b,x                 ; 30A0:  1e 1b 00
b00_b0a3:   brk                         ; 30A3:  00
b00_b0a4:   brk                         ; 30A4:  00
b00_b0a5:   brk                         ; 30A5:  00
b00_b0a6:   clc                         ; 30A6:  18
b00_b0a7:   .db $1c                     ; 30A7:  1c
b00_b0a8:   asl $001b,x                 ; 30A8:  1e 1b 00
b00_b0ab:   brk                         ; 30AB:  00
b00_b0ac:   brk                         ; 30AC:  00
b00_b0ad:   brk                         ; 30AD:  00
b00_b0ae:   rts                         ; 30AE:  60
b00_b0af:   rts                         ; 30AF:  60
b00_b0b0:   rts                         ; 30B0:  60
b00_b0b1:   rts                         ; 30B1:  60
b00_b0b2:   brk                         ; 30B2:  00
b00_b0b3:   brk                         ; 30B3:  00
b00_b0b4:   brk                         ; 30B4:  00
b00_b0b5:   brk                         ; 30B5:  00
b00_b0b6:   rts                         ; 30B6:  60
b00_b0b7:   rts                         ; 30B7:  60
b00_b0b8:   rts                         ; 30B8:  60
b00_b0b9:   rts                         ; 30B9:  60
b00_b0ba:   ora $1818,y                 ; 30BA:  19 18 18
b00_b0bd:   brk                         ; 30BD:  00
b00_b0be:   brk                         ; 30BE:  00
b00_b0bf:   brk                         ; 30BF:  00
b00_b0c0:   brk                         ; 30C0:  00
b00_b0c1:   brk                         ; 30C1:  00
b00_b0c2:   ora $1818,y                 ; 30C2:  19 18 18
b00_b0c5:   brk                         ; 30C5:  00
b00_b0c6:   brk                         ; 30C6:  00
b00_b0c7:   brk                         ; 30C7:  00
b00_b0c8:   brk                         ; 30C8:  00
b00_b0c9:   brk                         ; 30C9:  00
b00_b0ca:   cpx #$e0                    ; 30CA:  e0 e0
b00_b0cc:   rts                         ; 30CC:  60
b00_b0cd:   brk                         ; 30CD:  00
b00_b0ce:   brk                         ; 30CE:  00
b00_b0cf:   brk                         ; 30CF:  00
b00_b0d0:   brk                         ; 30D0:  00
b00_b0d1:   brk                         ; 30D1:  00
b00_b0d2:   cpx #$e0                    ; 30D2:  e0 e0
b00_b0d4:   rts                         ; 30D4:  60
b00_b0d5:   brk                         ; 30D5:  00
b00_b0d6:   brk                         ; 30D6:  00
b00_b0d7:   brk                         ; 30D7:  00
b00_b0d8:   brk                         ; 30D8:  00
b00_b0d9:   brk                         ; 30D9:  00
b00_b0da:   .db $c3                     ; 30DA:  c3
b00_b0db:   .db $c3                     ; 30DB:  c3
b00_b0dc:   cpy #$c3                    ; 30DC:  c0 c3
b00_b0de:   .db $c3                     ; 30DE:  c3
b00_b0df:   .db $c3                     ; 30DF:  c3
b00_b0e0:   .db $fb                     ; 30E0:  fb
b00_b0e1:   brk                         ; 30E1:  00
b00_b0e2:   .db $c3                     ; 30E2:  c3
b00_b0e3:   .db $c3                     ; 30E3:  c3
b00_b0e4:   cpy #$c3                    ; 30E4:  c0 c3
b00_b0e6:   .db $c3                     ; 30E6:  c3
b00_b0e7:   .db $c3                     ; 30E7:  c3
b00_b0e8:   .db $fb                     ; 30E8:  fb
b00_b0e9:   brk                         ; 30E9:  00
b00_b0ea:   brk                         ; 30EA:  00
b00_b0eb:   brk                         ; 30EB:  00
b00_b0ec:   rol $7070,x                 ; 30EC:  3e 70 70
b00_b0ef:   bvs $b12f                   ; 30EF:  70 3e
b00_b0f1:   brk                         ; 30F1:  00
b00_b0f2:   brk                         ; 30F2:  00
b00_b0f3:   brk                         ; 30F3:  00
b00_b0f4:   rol $7070,x                 ; 30F4:  3e 70 70
b00_b0f7:   bvs $b137                   ; 30F7:  70 3e
b00_b0f9:   brk                         ; 30F9:  00
b00_b0fa:   brk                         ; 30FA:  00
b00_b0fb:   brk                         ; 30FB:  00
b00_b0fc:   adc $fdcd,y                 ; 30FC:  79 cd fd
b00_b0ff:   cmp ($7d,x)                 ; 30FF:  c1 7d
b00_b101:   brk                         ; 3101:  00
b00_b102:   brk                         ; 3102:  00
b00_b103:   brk                         ; 3103:  00
b00_b104:   adc $fdcd,y                 ; 3104:  79 cd fd
b00_b107:   cmp ($7d,x)                 ; 3107:  c1 7d
b00_b109:   brk                         ; 3109:  00
b00_b10a:   brk                         ; 310A:  00
b00_b10b:   brk                         ; 310B:  00
b00_b10c:   sbc ($9b),y                 ; 310C:  f1 9b
b00_b10e:   sta $9b98,y                 ; 310E:  99 98 9b
b00_b111:   brk                         ; 3111:  00
b00_b112:   brk                         ; 3112:  00
b00_b113:   brk                         ; 3113:  00
b00_b114:   sbc ($9b),y                 ; 3114:  f1 9b
b00_b116:   sta $9b98,y                 ; 3116:  99 98 9b
b00_b119:   brk                         ; 3119:  00
b00_b11a:   brk                         ; 311A:  00
b00_b11b:   brk                         ; 311B:  00
b00_b11c:   .db $f3                     ; 311C:  f3
b00_b11d:   stx $e7                     ; 311D:  86 e7
b00_b11f:   ror $e3,x                   ; 311F:  76 e3
b00_b121:   brk                         ; 3121:  00
b00_b122:   brk                         ; 3122:  00
b00_b123:   brk                         ; 3123:  00
b00_b124:   .db $f3                     ; 3124:  f3
b00_b125:   stx $e7                     ; 3125:  86 e7
b00_b127:   ror $e3,x                   ; 3127:  76 e3
b00_b129:   brk                         ; 3129:  00
b00_b12a:   brk                         ; 312A:  00
b00_b12b:   brk                         ; 312B:  00
b00_b12c:   .db $c7                     ; 312C:  c7
b00_b12d:   jmp ($0cec)                 ; 312D:  6c ec 0c
b00_b130:   .db $e7                     ; 3130:  e7
b00_b131:   brk                         ; 3131:  00
b00_b132:   brk                         ; 3132:  00
b00_b133:   brk                         ; 3133:  00
b00_b134:   .db $c7                     ; 3134:  c7
b00_b135:   jmp ($0cec)                 ; 3135:  6c ec 0c
b00_b138:   .db $e7                     ; 3138:  e7
b00_b139:   brk                         ; 3139:  00
b00_b13a:   cpy #$c0                    ; 313A:  c0 c0
b00_b13c:   cpy #$c0                    ; 313C:  c0 c0
b00_b13e:   cpy #$c0                    ; 313E:  c0 c0
b00_b140:   cpy #$00                    ; 3140:  c0 00
b00_b142:   cpy #$c0                    ; 3142:  c0 c0
b00_b144:   cpy #$c0                    ; 3144:  c0 c0
b00_b146:   cpy #$c0                    ; 3146:  c0 c0
b00_b148:   cpy #$00                    ; 3148:  c0 00
b00_b14a:   rts                         ; 314A:  60
b00_b14b:   rts                         ; 314B:  60
b00_b14c:   rts                         ; 314C:  60
b00_b14d:   .db $7c                     ; 314D:  7c
b00_b14e:   ror $66                     ; 314E:  66 66
b00_b150:   .db $7c                     ; 3150:  7c
b00_b151:   brk                         ; 3151:  00
b00_b152:   rts                         ; 3152:  60
b00_b153:   rts                         ; 3153:  60
b00_b154:   rts                         ; 3154:  60
b00_b155:   .db $7c                     ; 3155:  7c
b00_b156:   ror $66                     ; 3156:  66 66
b00_b158:   .db $7c                     ; 3158:  7c
b00_b159:   brk                         ; 3159:  00
b00_b15a:   brk                         ; 315A:  00
b00_b15b:   brk                         ; 315B:  00
b00_b15c:   brk                         ; 315C:  00
b00_b15d:   cpy $cccc                   ; 315D:  cc cc cc
b00_b160:   .db $7c                     ; 3160:  7c
b00_b161:   .db $0c                     ; 3161:  0c
b00_b162:   brk                         ; 3162:  00
b00_b163:   brk                         ; 3163:  00
b00_b164:   brk                         ; 3164:  00
b00_b165:   cpy $cccc                   ; 3165:  cc cc cc
b00_b168:   .db $7c                     ; 3168:  7c
b00_b169:   .db $0c                     ; 3169:  0c
b00_b16a:   asl $07                     ; 316A:  06 07
b00_b16c:   .db $07                     ; 316C:  07
b00_b16d:   asl $06                     ; 316D:  06 06
b00_b16f:   asl $06                     ; 316F:  06 06
b00_b171:   brk                         ; 3171:  00
b00_b172:   asl $07                     ; 3172:  06 07
b00_b174:   .db $07                     ; 3174:  07
b00_b175:   asl $06                     ; 3175:  06 06
b00_b177:   asl $06                     ; 3177:  06 06
b00_b179:   brk                         ; 3179:  00
b00_b17a:   sed                         ; 317A:  f8
b00_b17b:   brk                         ; 317B:  00
b00_b17c:   brk                         ; 317C:  00
b00_b17d:   brk                         ; 317D:  00
b00_b17e:   brk                         ; 317E:  00
b00_b17f:   brk                         ; 317F:  00
b00_b180:   brk                         ; 3180:  00
b00_b181:   brk                         ; 3181:  00
b00_b182:   sed                         ; 3182:  f8
b00_b183:   brk                         ; 3183:  00
b00_b184:   brk                         ; 3184:  00
b00_b185:   brk                         ; 3185:  00
b00_b186:   brk                         ; 3186:  00
b00_b187:   brk                         ; 3187:  00
b00_b188:   brk                         ; 3188:  00
b00_b189:   brk                         ; 3189:  00
b00_b18a:   rol $36,x                   ; 318A:  36 36
b00_b18c:   bcs $b184                   ; 318C:  b0 f6
b00_b18e:   ror $36,x                   ; 318E:  76 36
b00_b190:   asl $00,x                   ; 3190:  16 00
b00_b192:   rol $36,x                   ; 3192:  36 36
b00_b194:   bcs $b18c                   ; 3194:  b0 f6
b00_b196:   ror $36,x                   ; 3196:  76 36
b00_b198:   asl $00,x                   ; 3198:  16 00
b00_b19a:   brk                         ; 319A:  00
b00_b19b:   brk                         ; 319B:  00
b00_b19c:   .db $fb                     ; 319C:  fb
b00_b19d:   cpy $cccc                   ; 319D:  cc cc cc
b00_b1a0:   cpy $0000                   ; 31A0:  cc 00 00
b00_b1a3:   brk                         ; 31A3:  00
b00_b1a4:   .db $fb                     ; 31A4:  fb
b00_b1a5:   cpy $cccc                   ; 31A5:  cc cc cc
b00_b1a8:   cpy $0000                   ; 31A8:  cc 00 00
b00_b1ab:   cpy #$f7                    ; 31AB:  c0 f7
b00_b1ad:   cpy $cccf                   ; 31AD:  cc cf cc
b00_b1b0:   .db $c7                     ; 31B0:  c7
b00_b1b1:   brk                         ; 31B1:  00
b00_b1b2:   brk                         ; 31B2:  00
b00_b1b3:   cpy #$f7                    ; 31B3:  c0 f7
b00_b1b5:   cpy $cccf                   ; 31B5:  cc cf cc
b00_b1b8:   .db $c7                     ; 31B8:  c7
b00_b1b9:   brk                         ; 31B9:  00
b00_b1ba:   brk                         ; 31BA:  00
b00_b1bb:   brk                         ; 31BB:  00
b00_b1bc:   .db $9f                     ; 31BC:  9f
b00_b1bd:   cmp $19d9,y                 ; 31BD:  d9 d9 19
b00_b1c0:   cmp $0000,y                 ; 31C0:  d9 00 00
b00_b1c3:   brk                         ; 31C3:  00
b00_b1c4:   .db $9f                     ; 31C4:  9f
b00_b1c5:   cmp $19d9,y                 ; 31C5:  d9 d9 19
b00_b1c8:   cmp $0300,y                 ; 31C8:  d9 00 03
b00_b1cb:   .db $03                     ; 31CB:  03
b00_b1cc:   .db $1f                     ; 31CC:  1f
b00_b1cd:   .db $b3                     ; 31CD:  b3
b00_b1ce:   .db $b3                     ; 31CE:  b3
b00_b1cf:   .db $b3                     ; 31CF:  b3
b00_b1d0:   .db $9f                     ; 31D0:  9f
b00_b1d1:   brk                         ; 31D1:  00
b00_b1d2:   .db $03                     ; 31D2:  03
b00_b1d3:   .db $03                     ; 31D3:  03
b00_b1d4:   .db $1f                     ; 31D4:  1f
b00_b1d5:   .db $b3                     ; 31D5:  b3
b00_b1d6:   .db $b3                     ; 31D6:  b3
b00_b1d7:   .db $b3                     ; 31D7:  b3
b00_b1d8:   .db $9f                     ; 31D8:  9f
b00_b1d9:   brk                         ; 31D9:  00
b00_b1da:   brk                         ; 31DA:  00
b00_b1db:   brk                         ; 31DB:  00
b00_b1dc:   .db $3c                     ; 31DC:  3c
b00_b1dd:   ror $66                     ; 31DD:  66 66
b00_b1df:   ror $3c                     ; 31DF:  66 3c
b00_b1e1:   brk                         ; 31E1:  00
b00_b1e2:   brk                         ; 31E2:  00
b00_b1e3:   brk                         ; 31E3:  00
b00_b1e4:   .db $3c                     ; 31E4:  3c
b00_b1e5:   ror $66                     ; 31E5:  66 66
b00_b1e7:   ror $3c                     ; 31E7:  66 3c
b00_b1e9:   brk                         ; 31E9:  00
b00_b1ea:   brk                         ; 31EA:  00
b00_b1eb:   brk                         ; 31EB:  00
b00_b1ec:   ora ($03,x)                 ; 31EC:  01 03
b00_b1ee:   .db $03                     ; 31EE:  03
b00_b1ef:   .db $03                     ; 31EF:  03
b00_b1f0:   ora ($00,x)                 ; 31F0:  01 00
b00_b1f2:   brk                         ; 31F2:  00
b00_b1f3:   brk                         ; 31F3:  00
b00_b1f4:   ora ($03,x)                 ; 31F4:  01 03
b00_b1f6:   .db $03                     ; 31F6:  03
b00_b1f7:   .db $03                     ; 31F7:  03
b00_b1f8:   ora ($00,x)                 ; 31F8:  01 00
b00_b1fa:   .db $03                     ; 31FA:  03
b00_b1fb:   asl $ef                     ; 31FB:  06 ef
b00_b1fd:   rol $36,x                   ; 31FD:  36 36
b00_b1ff:   rol $e6,x                   ; 31FF:  36 e6
b00_b201:   brk                         ; 3201:  00
b00_b202:   .db $03                     ; 3202:  03
b00_b203:   asl $ef                     ; 3203:  06 ef
b00_b205:   rol $36,x                   ; 3205:  36 36
b00_b207:   rol $e6,x                   ; 3207:  36 e6
b00_b209:   brk                         ; 3209:  00
b00_b20a:   .db $80                     ; 320A:  80
b00_b20b:   brk                         ; 320B:  00
b00_b20c:   .db $80                     ; 320C:  80
b00_b20d:   brk                         ; 320D:  00
b00_b20e:   brk                         ; 320E:  00
b00_b20f:   brk                         ; 320F:  00
b00_b210:   brk                         ; 3210:  00
b00_b211:   brk                         ; 3211:  00
b00_b212:   .db $80                     ; 3212:  80
b00_b213:   brk                         ; 3213:  00
b00_b214:   .db $80                     ; 3214:  80
b00_b215:   brk                         ; 3215:  00
b00_b216:   brk                         ; 3216:  00
b00_b217:   brk                         ; 3217:  00
b00_b218:   brk                         ; 3218:  00
b00_b219:   brk                         ; 3219:  00
b00_b21a:   sec                         ; 321A:  38
b00_b21b:   jmp $4c4c                   ; 321B:  4c 4c 4c
b00_b21e:   inc $8686,x                 ; 321E:  fe 86 86
b00_b221:   brk                         ; 3221:  00
b00_b222:   sec                         ; 3222:  38
b00_b223:   jmp $4c4c                   ; 3223:  4c 4c 4c
b00_b226:   inc $8686,x                 ; 3226:  fe 86 86
b00_b229:   brk                         ; 3229:  00
b00_b22a:   brk                         ; 322A:  00
b00_b22b:   brk                         ; 322B:  00
b00_b22c:   inc $dbdb,x                 ; 322C:  fe db db
b00_b22f:   .db $db                     ; 322F:  db
b00_b230:   .db $db                     ; 3230:  db
b00_b231:   brk                         ; 3231:  00
b00_b232:   brk                         ; 3232:  00
b00_b233:   brk                         ; 3233:  00
b00_b234:   inc $dbdb,x                 ; 3234:  fe db db
b00_b237:   .db $db                     ; 3237:  db
b00_b238:   .db $db                     ; 3238:  db
b00_b239:   brk                         ; 3239:  00
b00_b23a:   brk                         ; 323A:  00
b00_b23b:   brk                         ; 323B:  00
b00_b23c:   .db $3c                     ; 323C:  3c
b00_b23d:   ror $7e                     ; 323D:  66 7e
b00_b23f:   rts                         ; 323F:  60
b00_b240:   rol $0000,x                 ; 3240:  3e 00 00
b00_b243:   brk                         ; 3243:  00
b00_b244:   .db $3c                     ; 3244:  3c
b00_b245:   ror $7e                     ; 3245:  66 7e
b00_b247:   rts                         ; 3247:  60
b00_b248:   rol $0300,x                 ; 3248:  3e 00 03
b00_b24b:   .db $03                     ; 324B:  03
b00_b24c:   cld                         ; 324C:  d8
b00_b24d:   .db $e3                     ; 324D:  e3
b00_b24e:   .db $c3                     ; 324E:  c3
b00_b24f:   .db $c3                     ; 324F:  c3
b00_b250:   .db $c3                     ; 3250:  c3
b00_b251:   brk                         ; 3251:  00
b00_b252:   .db $03                     ; 3252:  03
b00_b253:   .db $03                     ; 3253:  03
b00_b254:   cld                         ; 3254:  d8
b00_b255:   .db $e3                     ; 3255:  e3
b00_b256:   .db $c3                     ; 3256:  c3
b00_b257:   .db $c3                     ; 3257:  c3
b00_b258:   .db $c3                     ; 3258:  c3
b00_b259:   brk                         ; 3259:  00
b00_b25a:   brk                         ; 325A:  00
b00_b25b:   brk                         ; 325B:  00
b00_b25c:   .db $3c                     ; 325C:  3c
b00_b25d:   adc ($61,x)                 ; 325D:  61 61
b00_b25f:   adc ($3c,x)                 ; 325F:  61 3c
b00_b261:   brk                         ; 3261:  00
b00_b262:   brk                         ; 3262:  00
b00_b263:   brk                         ; 3263:  00
b00_b264:   .db $3c                     ; 3264:  3c
b00_b265:   adc ($61,x)                 ; 3265:  61 61
b00_b267:   adc ($3c,x)                 ; 3267:  61 3c
b00_b269:   brk                         ; 3269:  00
b00_b26a:   brk                         ; 326A:  00
b00_b26b:   brk                         ; 326B:  00
b00_b26c:   sed                         ; 326C:  f8
b00_b26d:   tya                         ; 326D:  98
b00_b26e:   tya                         ; 326E:  98
b00_b26f:   tya                         ; 326F:  98
b00_b270:   inx                         ; 3270:  e8
b00_b271:   brk                         ; 3271:  00
b00_b272:   brk                         ; 3272:  00
b00_b273:   brk                         ; 3273:  00
b00_b274:   sed                         ; 3274:  f8
b00_b275:   tya                         ; 3275:  98
b00_b276:   tya                         ; 3276:  98
b00_b277:   tya                         ; 3277:  98
b00_b278:   inx                         ; 3278:  e8
b00_b279:   brk                         ; 3279:  00
b00_b27a:   .db $0f                     ; 327A:  0f
b00_b27b:   asl $06                     ; 327B:  06 06
b00_b27d:   asl $06                     ; 327D:  06 06
b00_b27f:   asl $0f                     ; 327F:  06 0f
b00_b281:   brk                         ; 3281:  00
b00_b282:   .db $0f                     ; 3282:  0f
b00_b283:   asl $06                     ; 3283:  06 06
b00_b285:   asl $06                     ; 3285:  06 06
b00_b287:   asl $0f                     ; 3287:  06 0f
b00_b289:   brk                         ; 3289:  00
b00_b28a:   brk                         ; 328A:  00
b00_b28b:   brk                         ; 328B:  00
b00_b28c:   .db $7c                     ; 328C:  7c
b00_b28d:   ror $66                     ; 328D:  66 66
b00_b28f:   ror $66                     ; 328F:  66 66
b00_b291:   brk                         ; 3291:  00
b00_b292:   brk                         ; 3292:  00
b00_b293:   brk                         ; 3293:  00
b00_b294:   .db $7c                     ; 3294:  7c
b00_b295:   ror $66                     ; 3295:  66 66
b00_b297:   ror $66                     ; 3297:  66 66
b00_b299:   brk                         ; 3299:  00
b00_b29a:   brk                         ; 329A:  00
b00_b29b:   brk                         ; 329B:  00
b00_b29c:   sei                         ; 329C:  78
b00_b29d:   cpy #$c0                    ; 329D:  c0 c0
b00_b29f:   .db $c3                     ; 329F:  c3
b00_b2a0:   .db $7b                     ; 32A0:  7b
b00_b2a1:   brk                         ; 32A1:  00
b00_b2a2:   brk                         ; 32A2:  00
b00_b2a3:   brk                         ; 32A3:  00
b00_b2a4:   sei                         ; 32A4:  78
b00_b2a5:   cpy #$c0                    ; 32A5:  c0 c0
b00_b2a7:   .db $c3                     ; 32A7:  c3
b00_b2a8:   .db $7b                     ; 32A8:  7b
b00_b2a9:   brk                         ; 32A9:  00
b00_b2aa:   brk                         ; 32AA:  00
b00_b2ab:   brk                         ; 32AB:  00
b00_b2ac:   brk                         ; 32AC:  00
b00_b2ad:   brk                         ; 32AD:  00
b00_b2ae:   brk                         ; 32AE:  00
b00_b2af:   brk                         ; 32AF:  00
b00_b2b0:   brk                         ; 32B0:  00
b00_b2b1:   brk                         ; 32B1:  00
b00_b2b2:   brk                         ; 32B2:  00
b00_b2b3:   brk                         ; 32B3:  00
b00_b2b4:   brk                         ; 32B4:  00
b00_b2b5:   brk                         ; 32B5:  00
b00_b2b6:   brk                         ; 32B6:  00
b00_b2b7:   brk                         ; 32B7:  00
b00_b2b8:   brk                         ; 32B8:  00
b00_b2b9:   brk                         ; 32B9:  00
b00_b2ba:   .db $ff                     ; 32BA:  ff
b00_b2bb:   .db $ff                     ; 32BB:  ff
b00_b2bc:   .db $ff                     ; 32BC:  ff
b00_b2bd:   .db $ff                     ; 32BD:  ff
b00_b2be:   .db $ff                     ; 32BE:  ff
b00_b2bf:   .db $ff                     ; 32BF:  ff
b00_b2c0:   .db $ff                     ; 32C0:  ff
b00_b2c1:   .db $ff                     ; 32C1:  ff
b00_b2c2:   brk                         ; 32C2:  00
b00_b2c3:   brk                         ; 32C3:  00
b00_b2c4:   brk                         ; 32C4:  00
b00_b2c5:   brk                         ; 32C5:  00
b00_b2c6:   brk                         ; 32C6:  00
b00_b2c7:   brk                         ; 32C7:  00
b00_b2c8:   brk                         ; 32C8:  00
b00_b2c9:   brk                         ; 32C9:  00
b00_b2ca:   brk                         ; 32CA:  00
b00_b2cb:   brk                         ; 32CB:  00
b00_b2cc:   brk                         ; 32CC:  00
b00_b2cd:   brk                         ; 32CD:  00
b00_b2ce:   brk                         ; 32CE:  00
b00_b2cf:   brk                         ; 32CF:  00
b00_b2d0:   brk                         ; 32D0:  00
b00_b2d1:   brk                         ; 32D1:  00
b00_b2d2:   brk                         ; 32D2:  00
b00_b2d3:   brk                         ; 32D3:  00
b00_b2d4:   brk                         ; 32D4:  00
b00_b2d5:   brk                         ; 32D5:  00
b00_b2d6:   brk                         ; 32D6:  00
b00_b2d7:   brk                         ; 32D7:  00
b00_b2d8:   brk                         ; 32D8:  00
b00_b2d9:   brk                         ; 32D9:  00
b00_b2da:   asl $0e                     ; 32DA:  06 0e
b00_b2dc:   .db $0c                     ; 32DC:  0c
b00_b2dd:   clc                         ; 32DD:  18
b00_b2de:   bpl $b340                   ; 32DE:  10 60
b00_b2e0:   rts                         ; 32E0:  60
b00_b2e1:   brk                         ; 32E1:  00
b00_b2e2:   asl $0e                     ; 32E2:  06 0e
b00_b2e4:   .db $0c                     ; 32E4:  0c
b00_b2e5:   clc                         ; 32E5:  18
b00_b2e6:   bpl $b348                   ; 32E6:  10 60
b00_b2e8:   rts                         ; 32E8:  60
b00_b2e9:   brk                         ; 32E9:  00
b00_b2ea:   php                         ; 32EA:  08
b00_b2eb:   bpl $b30d                   ; 32EB:  10 20
b00_b2ed:   jsr $1020                   ; 32ED:  20 20 10
b00_b2f0:   php                         ; 32F0:  08
b00_b2f1:   brk                         ; 32F1:  00
b00_b2f2:   php                         ; 32F2:  08
b00_b2f3:   bpl $b315                   ; 32F3:  10 20
b00_b2f5:   jsr $1020                   ; 32F5:  20 20 10
b00_b2f8:   php                         ; 32F8:  08
b00_b2f9:   brk                         ; 32F9:  00
b00_b2fa:   bpl $b304                   ; 32FA:  10 08
b00_b2fc:   .db $04                     ; 32FC:  04
b00_b2fd:   .db $04                     ; 32FD:  04
b00_b2fe:   .db $04                     ; 32FE:  04
b00_b2ff:   php                         ; 32FF:  08
b00_b300:   bpl $b302                   ; 3300:  10 00
b00_b302:   bpl $b30c                   ; 3302:  10 08
b00_b304:   .db $04                     ; 3304:  04
b00_b305:   .db $04                     ; 3305:  04
b00_b306:   .db $04                     ; 3306:  04
b00_b307:   php                         ; 3307:  08
b00_b308:   bpl $b30a                   ; 3308:  10 00
b00_b30a:   brk                         ; 330A:  00
b00_b30b:   brk                         ; 330B:  00
b00_b30c:   brk                         ; 330C:  00
b00_b30d:   brk                         ; 330D:  00
b00_b30e:   .db $3c                     ; 330E:  3c
b00_b30f:   brk                         ; 330F:  00
b00_b310:   brk                         ; 3310:  00
b00_b311:   brk                         ; 3311:  00
b00_b312:   brk                         ; 3312:  00
b00_b313:   brk                         ; 3313:  00
b00_b314:   brk                         ; 3314:  00
b00_b315:   brk                         ; 3315:  00
b00_b316:   .db $3c                     ; 3316:  3c
b00_b317:   brk                         ; 3317:  00
b00_b318:   brk                         ; 3318:  00
b00_b319:   brk                         ; 3319:  00
b00_b31a:   brk                         ; 331A:  00
b00_b31b:   brk                         ; 331B:  00
b00_b31c:   brk                         ; 331C:  00
b00_b31d:   brk                         ; 331D:  00
b00_b31e:   brk                         ; 331E:  00
b00_b31f:   clc                         ; 331F:  18
b00_b320:   clc                         ; 3320:  18
b00_b321:   brk                         ; 3321:  00
b00_b322:   brk                         ; 3322:  00
b00_b323:   brk                         ; 3323:  00
b00_b324:   brk                         ; 3324:  00
b00_b325:   brk                         ; 3325:  00
b00_b326:   brk                         ; 3326:  00
b00_b327:   clc                         ; 3327:  18
b00_b328:   clc                         ; 3328:  18
b00_b329:   brk                         ; 3329:  00
b00_b32a:   brk                         ; 332A:  00
b00_b32b:   .db $02                     ; 332B:  02
b00_b32c:   .db $04                     ; 332C:  04
b00_b32d:   php                         ; 332D:  08
b00_b32e:   bpl $b350                   ; 332E:  10 20
b00_b330:   rti                         ; 3330:  40
b00_b331:   brk                         ; 3331:  00
b00_b332:   brk                         ; 3332:  00
b00_b333:   .db $02                     ; 3333:  02
b00_b334:   .db $04                     ; 3334:  04
b00_b335:   php                         ; 3335:  08
b00_b336:   bpl $b358                   ; 3336:  10 20
b00_b338:   rti                         ; 3338:  40
b00_b339:   brk                         ; 3339:  00
b00_b33a:   .db $7c                     ; 333A:  7c
b00_b33b:   dec $dece                   ; 333B:  ce ce de
b00_b33e:   inc $7cce                   ; 333E:  ee ce 7c
b00_b341:   brk                         ; 3341:  00
b00_b342:   .db $7c                     ; 3342:  7c
b00_b343:   dec $dece                   ; 3343:  ce ce de
b00_b346:   inc $7cce                   ; 3346:  ee ce 7c
b00_b349:   brk                         ; 3349:  00
b00_b34a:   sec                         ; 334A:  38
b00_b34b:   sei                         ; 334B:  78
b00_b34c:   sec                         ; 334C:  38
b00_b34d:   sec                         ; 334D:  38
b00_b34e:   sec                         ; 334E:  38
b00_b34f:   sec                         ; 334F:  38
b00_b350:   .db $7c                     ; 3350:  7c
b00_b351:   brk                         ; 3351:  00
b00_b352:   sec                         ; 3352:  38
b00_b353:   sei                         ; 3353:  78
b00_b354:   sec                         ; 3354:  38
b00_b355:   sec                         ; 3355:  38
b00_b356:   sec                         ; 3356:  38
b00_b357:   sec                         ; 3357:  38
b00_b358:   .db $7c                     ; 3358:  7c
b00_b359:   brk                         ; 3359:  00
b00_b35a:   .db $7c                     ; 335A:  7c
b00_b35b:   dec $1cce                   ; 335B:  ce ce 1c
b00_b35e:   sec                         ; 335E:  38
b00_b35f:   bvs $b35f                   ; 335F:  70 fe
b00_b361:   brk                         ; 3361:  00
b00_b362:   .db $7c                     ; 3362:  7c
b00_b363:   dec $1cce                   ; 3363:  ce ce 1c
b00_b366:   sec                         ; 3366:  38
b00_b367:   bvs $b367                   ; 3367:  70 fe
b00_b369:   brk                         ; 3369:  00
b00_b36a:   .db $7c                     ; 336A:  7c
b00_b36b:   dec $3c0e                   ; 336B:  ce 0e 3c
b00_b36e:   asl $7cce                   ; 336E:  0e ce 7c
b00_b371:   brk                         ; 3371:  00
b00_b372:   .db $7c                     ; 3372:  7c
b00_b373:   dec $3c0e                   ; 3373:  ce 0e 3c
b00_b376:   asl $7cce                   ; 3376:  0e ce 7c
b00_b379:   brk                         ; 3379:  00
b00_b37a:   .db $0c                     ; 337A:  0c
b00_b37b:   .db $1c                     ; 337B:  1c
b00_b37c:   bit $fe4c                   ; 337C:  2c 4c fe
b00_b37f:   .db $0c                     ; 337F:  0c
b00_b380:   .db $0c                     ; 3380:  0c
b00_b381:   brk                         ; 3381:  00
b00_b382:   .db $0c                     ; 3382:  0c
b00_b383:   .db $1c                     ; 3383:  1c
b00_b384:   bit $fe4c                   ; 3384:  2c 4c fe
b00_b387:   .db $0c                     ; 3387:  0c
b00_b388:   .db $0c                     ; 3388:  0c
b00_b389:   brk                         ; 3389:  00
b00_b38a:   inc $fcc0,x                 ; 338A:  fe c0 fc
b00_b38d:   dec $ce0e                   ; 338D:  ce 0e ce
b00_b390:   .db $7c                     ; 3390:  7c
b00_b391:   brk                         ; 3391:  00
b00_b392:   inc $fcc0,x                 ; 3392:  fe c0 fc
b00_b395:   dec $ce0e                   ; 3395:  ce 0e ce
b00_b398:   .db $7c                     ; 3398:  7c
b00_b399:   brk                         ; 3399:  00
b00_b39a:   .db $3c                     ; 339A:  3c
b00_b39b:   rts                         ; 339B:  60
b00_b39c:   .db $fc                     ; 339C:  fc
b00_b39d:   dec $cece                   ; 339D:  ce ce ce
b00_b3a0:   .db $7c                     ; 33A0:  7c
b00_b3a1:   brk                         ; 33A1:  00
b00_b3a2:   .db $3c                     ; 33A2:  3c
b00_b3a3:   rts                         ; 33A3:  60
b00_b3a4:   .db $fc                     ; 33A4:  fc
b00_b3a5:   dec $cece                   ; 33A5:  ce ce ce
b00_b3a8:   .db $7c                     ; 33A8:  7c
b00_b3a9:   brk                         ; 33A9:  00
b00_b3aa:   inc $0cc6,x                 ; 33AA:  fe c6 0c
b00_b3ad:   .db $1c                     ; 33AD:  1c
b00_b3ae:   sec                         ; 33AE:  38
b00_b3af:   sec                         ; 33AF:  38
b00_b3b0:   sec                         ; 33B0:  38
b00_b3b1:   brk                         ; 33B1:  00
b00_b3b2:   inc $0cc6,x                 ; 33B2:  fe c6 0c
b00_b3b5:   .db $1c                     ; 33B5:  1c
b00_b3b6:   sec                         ; 33B6:  38
b00_b3b7:   sec                         ; 33B7:  38
b00_b3b8:   sec                         ; 33B8:  38
b00_b3b9:   brk                         ; 33B9:  00
b00_b3ba:   .db $7c                     ; 33BA:  7c
b00_b3bb:   dec $7cce                   ; 33BB:  ce ce 7c
b00_b3be:   dec $7cce                   ; 33BE:  ce ce 7c
b00_b3c1:   brk                         ; 33C1:  00
b00_b3c2:   .db $7c                     ; 33C2:  7c
b00_b3c3:   dec $7cce                   ; 33C3:  ce ce 7c
b00_b3c6:   dec $7cce                   ; 33C6:  ce ce 7c
b00_b3c9:   brk                         ; 33C9:  00
b00_b3ca:   .db $7c                     ; 33CA:  7c
b00_b3cb:   dec $cece                   ; 33CB:  ce ce ce
b00_b3ce:   ror $7c0e,x                 ; 33CE:  7e 0e 7c
b00_b3d1:   brk                         ; 33D1:  00
b00_b3d2:   .db $7c                     ; 33D2:  7c
b00_b3d3:   dec $cece                   ; 33D3:  ce ce ce
b00_b3d6:   ror $7c0e,x                 ; 33D6:  7e 0e 7c
b00_b3d9:   brk                         ; 33D9:  00
b00_b3da:   brk                         ; 33DA:  00
b00_b3db:   clc                         ; 33DB:  18
b00_b3dc:   clc                         ; 33DC:  18
b00_b3dd:   brk                         ; 33DD:  00
b00_b3de:   brk                         ; 33DE:  00
b00_b3df:   clc                         ; 33DF:  18
b00_b3e0:   clc                         ; 33E0:  18
b00_b3e1:   brk                         ; 33E1:  00
b00_b3e2:   brk                         ; 33E2:  00
b00_b3e3:   clc                         ; 33E3:  18
b00_b3e4:   clc                         ; 33E4:  18
b00_b3e5:   brk                         ; 33E5:  00
b00_b3e6:   brk                         ; 33E6:  00
b00_b3e7:   clc                         ; 33E7:  18
b00_b3e8:   clc                         ; 33E8:  18
b00_b3e9:   brk                         ; 33E9:  00
b00_b3ea:   .db $03                     ; 33EA:  03
b00_b3eb:   .db $0f                     ; 33EB:  0f
b00_b3ec:   .db $3f                     ; 33EC:  3f
b00_b3ed:   .db $7f                     ; 33ED:  7f
b00_b3ee:   .db $3f                     ; 33EE:  3f
b00_b3ef:   .db $0f                     ; 33EF:  0f
b00_b3f0:   .db $03                     ; 33F0:  03
b00_b3f1:   brk                         ; 33F1:  00
b00_b3f2:   .db $03                     ; 33F2:  03
b00_b3f3:   .db $0f                     ; 33F3:  0f
b00_b3f4:   .db $3f                     ; 33F4:  3f
b00_b3f5:   .db $7f                     ; 33F5:  7f
b00_b3f6:   .db $3f                     ; 33F6:  3f
b00_b3f7:   .db $0f                     ; 33F7:  0f
b00_b3f8:   .db $03                     ; 33F8:  03
b00_b3f9:   brk                         ; 33F9:  00
b00_b3fa:   rts                         ; 33FA:  60
b00_b3fb:   sei                         ; 33FB:  78
b00_b3fc:   ror $7e7f,x                 ; 33FC:  7e 7f 7e
b00_b3ff:   sei                         ; 33FF:  78
b00_b400:   rts                         ; 3400:  60
b00_b401:   brk                         ; 3401:  00
b00_b402:   rts                         ; 3402:  60
b00_b403:   sei                         ; 3403:  78
b00_b404:   ror $7e7f,x                 ; 3404:  7e 7f 7e
b00_b407:   sei                         ; 3407:  78
b00_b408:   rts                         ; 3408:  60
b00_b409:   brk                         ; 3409:  00
b00_b40a:   .db $3c                     ; 340A:  3c
b00_b40b:   ror $66                     ; 340B:  66 66
b00_b40d:   .db $0c                     ; 340D:  0c
b00_b40e:   clc                         ; 340E:  18
b00_b40f:   brk                         ; 340F:  00
b00_b410:   clc                         ; 3410:  18
b00_b411:   brk                         ; 3411:  00
b00_b412:   .db $3c                     ; 3412:  3c
b00_b413:   ror $66                     ; 3413:  66 66
b00_b415:   .db $0c                     ; 3415:  0c
b00_b416:   clc                         ; 3416:  18
b00_b417:   brk                         ; 3417:  00
b00_b418:   clc                         ; 3418:  18
b00_b419:   brk                         ; 3419:  00
b00_b41a:   sec                         ; 341A:  38
b00_b41b:   .db $7c                     ; 341B:  7c
b00_b41c:   dec $fece                   ; 341C:  ce ce fe
b00_b41f:   dec $00ce                   ; 341F:  ce ce 00
b00_b422:   sec                         ; 3422:  38
b00_b423:   .db $7c                     ; 3423:  7c
b00_b424:   dec $fece                   ; 3424:  ce ce fe
b00_b427:   dec $00ce                   ; 3427:  ce ce 00
b00_b42a:   .db $fc                     ; 342A:  fc
b00_b42b:   dec $fcce                   ; 342B:  ce ce fc
b00_b42e:   dec $fcce                   ; 342E:  ce ce fc
b00_b431:   brk                         ; 3431:  00
b00_b432:   .db $fc                     ; 3432:  fc
b00_b433:   dec $fcce                   ; 3433:  ce ce fc
b00_b436:   dec $fcce                   ; 3436:  ce ce fc
b00_b439:   brk                         ; 3439:  00
b00_b43a:   .db $7c                     ; 343A:  7c
b00_b43b:   inc $e6                     ; 343B:  e6 e6
b00_b43d:   cpx #$e6                    ; 343D:  e0 e6
b00_b43f:   inc $7c                     ; 343F:  e6 7c
b00_b441:   brk                         ; 3441:  00
b00_b442:   .db $7c                     ; 3442:  7c
b00_b443:   inc $e6                     ; 3443:  e6 e6
b00_b445:   cpx #$e6                    ; 3445:  e0 e6
b00_b447:   inc $7c                     ; 3447:  e6 7c
b00_b449:   brk                         ; 3449:  00
b00_b44a:   .db $fc                     ; 344A:  fc
b00_b44b:   dec $cece                   ; 344B:  ce ce ce
b00_b44e:   dec $fcce                   ; 344E:  ce ce fc
b00_b451:   brk                         ; 3451:  00
b00_b452:   .db $fc                     ; 3452:  fc
b00_b453:   dec $cece                   ; 3453:  ce ce ce
b00_b456:   dec $fcce                   ; 3456:  ce ce fc
b00_b459:   brk                         ; 3459:  00
b00_b45a:   inc $e0e0,x                 ; 345A:  fe e0 e0
b00_b45d:   .db $fc                     ; 345D:  fc
b00_b45e:   cpx #$e0                    ; 345E:  e0 e0
b00_b460:   inc $fe00,x                 ; 3460:  fe 00 fe
b00_b463:   cpx #$e0                    ; 3463:  e0 e0
b00_b465:   .db $fc                     ; 3465:  fc
b00_b466:   cpx #$e0                    ; 3466:  e0 e0
b00_b468:   inc $fe00,x                 ; 3468:  fe 00 fe
b00_b46b:   cpx #$e0                    ; 346B:  e0 e0
b00_b46d:   .db $fc                     ; 346D:  fc
b00_b46e:   cpx #$e0                    ; 346E:  e0 e0
b00_b470:   cpx #$00                    ; 3470:  e0 00
b00_b472:   inc $e0e0,x                 ; 3472:  fe e0 e0
b00_b475:   .db $fc                     ; 3475:  fc
b00_b476:   cpx #$e0                    ; 3476:  e0 e0
b00_b478:   cpx #$00                    ; 3478:  e0 00
b00_b47a:   .db $7c                     ; 347A:  7c
b00_b47b:   inc $e0                     ; 347B:  e6 e0
b00_b47d:   inc $e6e6                   ; 347D:  ee e6 e6
b00_b480:   .db $7c                     ; 3480:  7c
b00_b481:   brk                         ; 3481:  00
b00_b482:   .db $7c                     ; 3482:  7c
b00_b483:   inc $e0                     ; 3483:  e6 e0
b00_b485:   inc $e6e6                   ; 3485:  ee e6 e6
b00_b488:   .db $7c                     ; 3488:  7c
b00_b489:   brk                         ; 3489:  00
b00_b48a:   dec $cece                   ; 348A:  ce ce ce
b00_b48d:   inc $cece,x                 ; 348D:  fe ce ce
b00_b490:   dec $ce00                   ; 3490:  ce 00 ce
b00_b493:   dec $fece                   ; 3493:  ce ce fe
b00_b496:   dec $cece                   ; 3496:  ce ce ce
b00_b499:   brk                         ; 3499:  00
b00_b49a:   .db $1c                     ; 349A:  1c
b00_b49b:   .db $1c                     ; 349B:  1c
b00_b49c:   .db $1c                     ; 349C:  1c
b00_b49d:   .db $1c                     ; 349D:  1c
b00_b49e:   .db $1c                     ; 349E:  1c
b00_b49f:   .db $1c                     ; 349F:  1c
b00_b4a0:   .db $1c                     ; 34A0:  1c
b00_b4a1:   brk                         ; 34A1:  00
b00_b4a2:   .db $1c                     ; 34A2:  1c
b00_b4a3:   .db $1c                     ; 34A3:  1c
b00_b4a4:   .db $1c                     ; 34A4:  1c
b00_b4a5:   .db $1c                     ; 34A5:  1c
b00_b4a6:   .db $1c                     ; 34A6:  1c
b00_b4a7:   .db $1c                     ; 34A7:  1c
b00_b4a8:   .db $1c                     ; 34A8:  1c
b00_b4a9:   brk                         ; 34A9:  00
b00_b4aa:   asl $0e0e                   ; 34AA:  0e 0e 0e
b00_b4ad:   asl $eeee                   ; 34AD:  0e ee ee
b00_b4b0:   .db $7c                     ; 34B0:  7c
b00_b4b1:   brk                         ; 34B1:  00
b00_b4b2:   asl $0e0e                   ; 34B2:  0e 0e 0e
b00_b4b5:   asl $eeee                   ; 34B5:  0e ee ee
b00_b4b8:   .db $7c                     ; 34B8:  7c
b00_b4b9:   brk                         ; 34B9:  00
b00_b4ba:   inc $ec                     ; 34BA:  e6 ec
b00_b4bc:   sed                         ; 34BC:  f8
b00_b4bd:   sed                         ; 34BD:  f8
b00_b4be:   cpx $e6ee                   ; 34BE:  ec ee e6
b00_b4c1:   brk                         ; 34C1:  00
b00_b4c2:   inc $ec                     ; 34C2:  e6 ec
b00_b4c4:   sed                         ; 34C4:  f8
b00_b4c5:   sed                         ; 34C5:  f8
b00_b4c6:   cpx $e6ee                   ; 34C6:  ec ee e6
b00_b4c9:   brk                         ; 34C9:  00
b00_b4ca:   cpx #$e0                    ; 34CA:  e0 e0
b00_b4cc:   cpx #$e0                    ; 34CC:  e0 e0
b00_b4ce:   cpx #$e0                    ; 34CE:  e0 e0
b00_b4d0:   inc $e000,x                 ; 34D0:  fe 00 e0
b00_b4d3:   cpx #$e0                    ; 34D3:  e0 e0
b00_b4d5:   cpx #$e0                    ; 34D5:  e0 e0
b00_b4d7:   cpx #$fe                    ; 34D7:  e0 fe
b00_b4d9:   brk                         ; 34D9:  00
b00_b4da:   dec $ee                     ; 34DA:  c6 ee
b00_b4dc:   inc $fefe,x                 ; 34DC:  fe fe fe
b00_b4df:   dec $c6,x                   ; 34DF:  d6 c6
b00_b4e1:   brk                         ; 34E1:  00
b00_b4e2:   dec $ee                     ; 34E2:  c6 ee
b00_b4e4:   inc $fefe,x                 ; 34E4:  fe fe fe
b00_b4e7:   dec $c6,x                   ; 34E7:  d6 c6
b00_b4e9:   brk                         ; 34E9:  00
b00_b4ea:   ror $76                     ; 34EA:  66 76
b00_b4ec:   ror $7e7e,x                 ; 34EC:  7e 7e 7e
b00_b4ef:   ror $0066                   ; 34EF:  6e 66 00
b00_b4f2:   ror $76                     ; 34F2:  66 76
b00_b4f4:   ror $7e7e,x                 ; 34F4:  7e 7e 7e
b00_b4f7:   ror $0066                   ; 34F7:  6e 66 00
b00_b4fa:   .db $7c                     ; 34FA:  7c
b00_b4fb:   dec $cece                   ; 34FB:  ce ce ce
b00_b4fe:   dec $7cce                   ; 34FE:  ce ce 7c
b00_b501:   brk                         ; 3501:  00
b00_b502:   .db $7c                     ; 3502:  7c
b00_b503:   dec $cece                   ; 3503:  ce ce ce
b00_b506:   dec $7cce                   ; 3506:  ce ce 7c
b00_b509:   brk                         ; 3509:  00
b00_b50a:   .db $fc                     ; 350A:  fc
b00_b50b:   dec $cece                   ; 350B:  ce ce ce
b00_b50e:   .db $fc                     ; 350E:  fc
b00_b50f:   cpy #$c0                    ; 350F:  c0 c0
b00_b511:   brk                         ; 3511:  00
b00_b512:   .db $fc                     ; 3512:  fc
b00_b513:   dec $cece                   ; 3513:  ce ce ce
b00_b516:   .db $fc                     ; 3516:  fc
b00_b517:   cpy #$c0                    ; 3517:  c0 c0
b00_b519:   brk                         ; 3519:  00
b00_b51a:   .db $7c                     ; 351A:  7c
b00_b51b:   dec $cece                   ; 351B:  ce ce ce
b00_b51e:   dec $76cc,x                 ; 351E:  de cc 76
b00_b521:   brk                         ; 3521:  00
b00_b522:   .db $7c                     ; 3522:  7c
b00_b523:   dec $cece                   ; 3523:  ce ce ce
b00_b526:   dec $76cc,x                 ; 3526:  de cc 76
b00_b529:   brk                         ; 3529:  00
b00_b52a:   .db $fc                     ; 352A:  fc
b00_b52b:   dec $cece                   ; 352B:  ce ce ce
b00_b52e:   .db $fc                     ; 352E:  fc
b00_b52f:   dec $00ce                   ; 352F:  ce ce 00
b00_b532:   .db $fc                     ; 3532:  fc
b00_b533:   dec $cece                   ; 3533:  ce ce ce
b00_b536:   .db $fc                     ; 3536:  fc
b00_b537:   dec $00ce                   ; 3537:  ce ce 00
b00_b53a:   .db $7c                     ; 353A:  7c
b00_b53b:   inc $e0                     ; 353B:  e6 e0
b00_b53d:   .db $7c                     ; 353D:  7c
b00_b53e:   asl $7cce                   ; 353E:  0e ce 7c
b00_b541:   brk                         ; 3541:  00
b00_b542:   .db $7c                     ; 3542:  7c
b00_b543:   inc $e0                     ; 3543:  e6 e0
b00_b545:   .db $7c                     ; 3545:  7c
b00_b546:   asl $7cce                   ; 3546:  0e ce 7c
b00_b549:   brk                         ; 3549:  00
b00_b54a:   inc $3838,x                 ; 354A:  fe 38 38
b00_b54d:   sec                         ; 354D:  38
b00_b54e:   sec                         ; 354E:  38
b00_b54f:   sec                         ; 354F:  38
b00_b550:   sec                         ; 3550:  38
b00_b551:   brk                         ; 3551:  00
b00_b552:   inc $3838,x                 ; 3552:  fe 38 38
b00_b555:   sec                         ; 3555:  38
b00_b556:   sec                         ; 3556:  38
b00_b557:   sec                         ; 3557:  38
b00_b558:   sec                         ; 3558:  38
b00_b559:   brk                         ; 3559:  00
b00_b55a:   dec $cece                   ; 355A:  ce ce ce
b00_b55d:   dec $cece                   ; 355D:  ce ce ce
b00_b560:   .db $7c                     ; 3560:  7c
b00_b561:   brk                         ; 3561:  00
b00_b562:   dec $cece                   ; 3562:  ce ce ce
b00_b565:   dec $cece                   ; 3565:  ce ce ce
b00_b568:   .db $7c                     ; 3568:  7c
b00_b569:   brk                         ; 3569:  00
b00_b56a:   dec $c6                     ; 356A:  c6 c6
b00_b56c:   dec $6c                     ; 356C:  c6 6c
b00_b56e:   jmp ($3838)                 ; 356E:  6c 38 38
b00_b571:   brk                         ; 3571:  00
b00_b572:   dec $c6                     ; 3572:  c6 c6
b00_b574:   dec $6c                     ; 3574:  c6 6c
b00_b576:   jmp ($3838)                 ; 3576:  6c 38 38
b00_b579:   brk                         ; 3579:  00
b00_b57a:   ldx $b6,y                   ; 357A:  b6 b6
b00_b57c:   ldx $b6,y                   ; 357C:  b6 b6
b00_b57e:   ldx $fe,y                   ; 357E:  b6 fe
b00_b580:   jmp ($b600)                 ; 3580:  6c 00 b6
b00_b583:   ldx $b6,y                   ; 3583:  b6 b6
b00_b585:   ldx $b6,y                   ; 3585:  b6 b6
b00_b587:   inc $006c,x                 ; 3587:  fe 6c 00
b00_b58a:   dec $ee                     ; 358A:  c6 ee
b00_b58c:   .db $7c                     ; 358C:  7c
b00_b58d:   sec                         ; 358D:  38
b00_b58e:   .db $7c                     ; 358E:  7c
b00_b58f:   inc $00c6                   ; 358F:  ee c6 00
b00_b592:   dec $ee                     ; 3592:  c6 ee
b00_b594:   .db $7c                     ; 3594:  7c
b00_b595:   sec                         ; 3595:  38
b00_b596:   .db $7c                     ; 3596:  7c
b00_b597:   inc $00c6                   ; 3597:  ee c6 00
b00_b59a:   dec $c6                     ; 359A:  c6 c6
b00_b59c:   dec $6c                     ; 359C:  c6 6c
b00_b59e:   sec                         ; 359E:  38
b00_b59f:   sec                         ; 359F:  38
b00_b5a0:   sec                         ; 35A0:  38
b00_b5a1:   brk                         ; 35A1:  00
b00_b5a2:   dec $c6                     ; 35A2:  c6 c6
b00_b5a4:   dec $6c                     ; 35A4:  c6 6c
b00_b5a6:   sec                         ; 35A6:  38
b00_b5a7:   sec                         ; 35A7:  38
b00_b5a8:   sec                         ; 35A8:  38
b00_b5a9:   brk                         ; 35A9:  00
b00_b5aa:   inc $1c0e,x                 ; 35AA:  fe 0e 1c
b00_b5ad:   sec                         ; 35AD:  38
b00_b5ae:   bvs $b590                   ; 35AE:  70 e0
b00_b5b0:   inc $fe00,x                 ; 35B0:  fe 00 fe
b00_b5b3:   asl $381c                   ; 35B3:  0e 1c 38
b00_b5b6:   bvs $b598                   ; 35B6:  70 e0
b00_b5b8:   inc $0000,x                 ; 35B8:  fe 00 00
b00_b5bb:   brk                         ; 35BB:  00
b00_b5bc:   brk                         ; 35BC:  00
b00_b5bd:   .db $ff                     ; 35BD:  ff
b00_b5be:   brk                         ; 35BE:  00
b00_b5bf:   brk                         ; 35BF:  00
b00_b5c0:   brk                         ; 35C0:  00
b00_b5c1:   brk                         ; 35C1:  00
b00_b5c2:   brk                         ; 35C2:  00
b00_b5c3:   brk                         ; 35C3:  00
b00_b5c4:   brk                         ; 35C4:  00
b00_b5c5:   .db $ff                     ; 35C5:  ff
b00_b5c6:   brk                         ; 35C6:  00
b00_b5c7:   brk                         ; 35C7:  00
b00_b5c8:   brk                         ; 35C8:  00
b00_b5c9:   brk                         ; 35C9:  00
b00_b5ca:   clc                         ; 35CA:  18
b00_b5cb:   clc                         ; 35CB:  18
b00_b5cc:   php                         ; 35CC:  08
b00_b5cd:   bpl $b5cf                   ; 35CD:  10 00
b00_b5cf:   brk                         ; 35CF:  00
b00_b5d0:   brk                         ; 35D0:  00
b00_b5d1:   brk                         ; 35D1:  00
b00_b5d2:   clc                         ; 35D2:  18
b00_b5d3:   clc                         ; 35D3:  18
b00_b5d4:   php                         ; 35D4:  08
b00_b5d5:   bpl $b5d7                   ; 35D5:  10 00
b00_b5d7:   brk                         ; 35D7:  00
b00_b5d8:   brk                         ; 35D8:  00
b00_b5d9:   brk                         ; 35D9:  00
b00_b5da:   brk                         ; 35DA:  00
b00_b5db:   brk                         ; 35DB:  00
b00_b5dc:   rol $7676,x                 ; 35DC:  3e 76 76
b00_b5df:   ror $3a,x                   ; 35DF:  76 3a
b00_b5e1:   brk                         ; 35E1:  00
b00_b5e2:   brk                         ; 35E2:  00
b00_b5e3:   brk                         ; 35E3:  00
b00_b5e4:   rol $7676,x                 ; 35E4:  3e 76 76
b00_b5e7:   ror $3a,x                   ; 35E7:  76 3a
b00_b5e9:   brk                         ; 35E9:  00
b00_b5ea:   rts                         ; 35EA:  60
b00_b5eb:   rts                         ; 35EB:  60
b00_b5ec:   .db $7c                     ; 35EC:  7c
b00_b5ed:   ror $6e6e                   ; 35ED:  6e 6e 6e
b00_b5f0:   .db $7c                     ; 35F0:  7c
b00_b5f1:   brk                         ; 35F1:  00
b00_b5f2:   rts                         ; 35F2:  60
b00_b5f3:   rts                         ; 35F3:  60
b00_b5f4:   .db $7c                     ; 35F4:  7c
b00_b5f5:   ror $6e6e                   ; 35F5:  6e 6e 6e
b00_b5f8:   .db $7c                     ; 35F8:  7c
b00_b5f9:   brk                         ; 35F9:  00
b00_b5fa:   brk                         ; 35FA:  00
b00_b5fb:   brk                         ; 35FB:  00
b00_b5fc:   .db $3c                     ; 35FC:  3c
b00_b5fd:   ror $70,x                   ; 35FD:  76 70
b00_b5ff:   ror $3c,x                   ; 35FF:  76 3c
b00_b601:   brk                         ; 3601:  00
b00_b602:   brk                         ; 3602:  00
b00_b603:   brk                         ; 3603:  00
b00_b604:   .db $3c                     ; 3604:  3c
b00_b605:   ror $70,x                   ; 3605:  76 70
b00_b607:   ror $3c,x                   ; 3607:  76 3c
b00_b609:   brk                         ; 3609:  00
b00_b60a:   asl $06                     ; 360A:  06 06
b00_b60c:   rol $7676,x                 ; 360C:  3e 76 76
b00_b60f:   ror $3e,x                   ; 360F:  76 3e
b00_b611:   brk                         ; 3611:  00
b00_b612:   asl $06                     ; 3612:  06 06
b00_b614:   rol $7676,x                 ; 3614:  3e 76 76
b00_b617:   ror $3e,x                   ; 3617:  76 3e
b00_b619:   brk                         ; 3619:  00
b00_b61a:   brk                         ; 361A:  00
b00_b61b:   brk                         ; 361B:  00
b00_b61c:   .db $3c                     ; 361C:  3c
b00_b61d:   ror $7e,x                   ; 361D:  76 7e
b00_b61f:   bvs $b65f                   ; 361F:  70 3e
b00_b621:   brk                         ; 3621:  00
b00_b622:   brk                         ; 3622:  00
b00_b623:   brk                         ; 3623:  00
b00_b624:   .db $3c                     ; 3624:  3c
b00_b625:   ror $7e,x                   ; 3625:  76 7e
b00_b627:   bvs $b667                   ; 3627:  70 3e
b00_b629:   brk                         ; 3629:  00
b00_b62a:   asl $3838,x                 ; 362A:  1e 38 38
b00_b62d:   ror $3838,x                 ; 362D:  7e 38 38
b00_b630:   sec                         ; 3630:  38
b00_b631:   brk                         ; 3631:  00
b00_b632:   asl $3838,x                 ; 3632:  1e 38 38
b00_b635:   ror $3838,x                 ; 3635:  7e 38 38
b00_b638:   sec                         ; 3638:  38
b00_b639:   brk                         ; 3639:  00
b00_b63a:   brk                         ; 363A:  00
b00_b63b:   brk                         ; 363B:  00
b00_b63c:   .db $3a                     ; 363C:  3a
b00_b63d:   ror $7e6e                   ; 363D:  6e 6e 7e
b00_b640:   asl $007c                   ; 3640:  0e 7c 00
b00_b643:   brk                         ; 3643:  00
b00_b644:   .db $3a                     ; 3644:  3a
b00_b645:   ror $7e6e                   ; 3645:  6e 6e 7e
b00_b648:   asl $607c                   ; 3648:  0e 7c 60
b00_b64b:   rts                         ; 364B:  60
b00_b64c:   jmp ($6e7e)                 ; 364C:  6c 7e 6e
b00_b64f:   ror $006e                   ; 364F:  6e 6e 00
b00_b652:   rts                         ; 3652:  60
b00_b653:   rts                         ; 3653:  60
b00_b654:   jmp ($6e7e)                 ; 3654:  6c 7e 6e
b00_b657:   ror $006e                   ; 3657:  6e 6e 00
b00_b65a:   sec                         ; 365A:  38
b00_b65b:   brk                         ; 365B:  00
b00_b65c:   sec                         ; 365C:  38
b00_b65d:   sec                         ; 365D:  38
b00_b65e:   sec                         ; 365E:  38
b00_b65f:   sec                         ; 365F:  38
b00_b660:   sec                         ; 3660:  38
b00_b661:   brk                         ; 3661:  00
b00_b662:   sec                         ; 3662:  38
b00_b663:   brk                         ; 3663:  00
b00_b664:   sec                         ; 3664:  38
b00_b665:   sec                         ; 3665:  38
b00_b666:   sec                         ; 3666:  38
b00_b667:   sec                         ; 3667:  38
b00_b668:   sec                         ; 3668:  38
b00_b669:   brk                         ; 3669:  00
b00_b66a:   sec                         ; 366A:  38
b00_b66b:   brk                         ; 366B:  00
b00_b66c:   sec                         ; 366C:  38
b00_b66d:   sec                         ; 366D:  38
b00_b66e:   sec                         ; 366E:  38
b00_b66f:   sec                         ; 366F:  38
b00_b670:   sec                         ; 3670:  38
b00_b671:   beq $b6ab                   ; 3671:  f0 38
b00_b673:   brk                         ; 3673:  00
b00_b674:   sec                         ; 3674:  38
b00_b675:   sec                         ; 3675:  38
b00_b676:   sec                         ; 3676:  38
b00_b677:   sec                         ; 3677:  38
b00_b678:   sec                         ; 3678:  38
b00_b679:   beq $b6db                   ; 3679:  f0 60
b00_b67b:   rts                         ; 367B:  60
b00_b67c:   ror $6c                     ; 367C:  66 6c
b00_b67e:   sei                         ; 367E:  78
b00_b67f:   .db $7c                     ; 367F:  7c
b00_b680:   ror $00                     ; 3680:  66 00
b00_b682:   rts                         ; 3682:  60
b00_b683:   rts                         ; 3683:  60
b00_b684:   ror $6c                     ; 3684:  66 6c
b00_b686:   sei                         ; 3686:  78
b00_b687:   .db $7c                     ; 3687:  7c
b00_b688:   ror $00                     ; 3688:  66 00
b00_b68a:   sec                         ; 368A:  38
b00_b68b:   clc                         ; 368B:  18
b00_b68c:   clc                         ; 368C:  18
b00_b68d:   clc                         ; 368D:  18
b00_b68e:   clc                         ; 368E:  18
b00_b68f:   clc                         ; 368F:  18
b00_b690:   clc                         ; 3690:  18
b00_b691:   brk                         ; 3691:  00
b00_b692:   sec                         ; 3692:  38
b00_b693:   clc                         ; 3693:  18
b00_b694:   clc                         ; 3694:  18
b00_b695:   clc                         ; 3695:  18
b00_b696:   clc                         ; 3696:  18
b00_b697:   clc                         ; 3697:  18
b00_b698:   clc                         ; 3698:  18
b00_b699:   brk                         ; 3699:  00
b00_b69a:   brk                         ; 369A:  00
b00_b69b:   brk                         ; 369B:  00
b00_b69c:   ldx $db,y                   ; 369C:  b6 db
b00_b69e:   .db $db                     ; 369E:  db
b00_b69f:   .db $db                     ; 369F:  db
b00_b6a0:   .db $db                     ; 36A0:  db
b00_b6a1:   brk                         ; 36A1:  00
b00_b6a2:   brk                         ; 36A2:  00
b00_b6a3:   brk                         ; 36A3:  00
b00_b6a4:   ldx $db,y                   ; 36A4:  b6 db
b00_b6a6:   .db $db                     ; 36A6:  db
b00_b6a7:   .db $db                     ; 36A7:  db
b00_b6a8:   .db $db                     ; 36A8:  db
b00_b6a9:   brk                         ; 36A9:  00
b00_b6aa:   brk                         ; 36AA:  00
b00_b6ab:   brk                         ; 36AB:  00
b00_b6ac:   jmp ($6e7e)                 ; 36AC:  6c 7e 6e
b00_b6af:   ror $006e                   ; 36AF:  6e 6e 00
b00_b6b2:   brk                         ; 36B2:  00
b00_b6b3:   brk                         ; 36B3:  00
b00_b6b4:   jmp ($6e7e)                 ; 36B4:  6c 7e 6e
b00_b6b7:   ror $006e                   ; 36B7:  6e 6e 00
b00_b6ba:   brk                         ; 36BA:  00
b00_b6bb:   brk                         ; 36BB:  00
b00_b6bc:   .db $3c                     ; 36BC:  3c
b00_b6bd:   ror $6e6e                   ; 36BD:  6e 6e 6e
b00_b6c0:   .db $3c                     ; 36C0:  3c
b00_b6c1:   brk                         ; 36C1:  00
b00_b6c2:   brk                         ; 36C2:  00
b00_b6c3:   brk                         ; 36C3:  00
b00_b6c4:   .db $3c                     ; 36C4:  3c
b00_b6c5:   ror $6e6e                   ; 36C5:  6e 6e 6e
b00_b6c8:   .db $3c                     ; 36C8:  3c
b00_b6c9:   brk                         ; 36C9:  00
b00_b6ca:   brk                         ; 36CA:  00
b00_b6cb:   brk                         ; 36CB:  00
b00_b6cc:   .db $7c                     ; 36CC:  7c
b00_b6cd:   ror $6e6e                   ; 36CD:  6e 6e 6e
b00_b6d0:   .db $7c                     ; 36D0:  7c
b00_b6d1:   rts                         ; 36D1:  60
b00_b6d2:   brk                         ; 36D2:  00
b00_b6d3:   brk                         ; 36D3:  00
b00_b6d4:   .db $7c                     ; 36D4:  7c
b00_b6d5:   ror $6e6e                   ; 36D5:  6e 6e 6e
b00_b6d8:   .db $7c                     ; 36D8:  7c
b00_b6d9:   rts                         ; 36D9:  60
b00_b6da:   brk                         ; 36DA:  00
b00_b6db:   brk                         ; 36DB:  00
b00_b6dc:   rol $6e6e,x                 ; 36DC:  3e 6e 6e
b00_b6df:   ror $0e3e                   ; 36DF:  6e 3e 0e
b00_b6e2:   brk                         ; 36E2:  00
b00_b6e3:   brk                         ; 36E3:  00
b00_b6e4:   rol $6e6e,x                 ; 36E4:  3e 6e 6e
b00_b6e7:   ror $0e3e                   ; 36E7:  6e 3e 0e
b00_b6ea:   brk                         ; 36EA:  00
b00_b6eb:   brk                         ; 36EB:  00
b00_b6ec:   ror $78,x                   ; 36EC:  76 78
b00_b6ee:   bvs $b760                   ; 36EE:  70 70
b00_b6f0:   bvs $b6f2                   ; 36F0:  70 00
b00_b6f2:   brk                         ; 36F2:  00
b00_b6f3:   brk                         ; 36F3:  00
b00_b6f4:   ror $78,x                   ; 36F4:  76 78
b00_b6f6:   bvs $b768                   ; 36F6:  70 70
b00_b6f8:   bvs $b6fa                   ; 36F8:  70 00
b00_b6fa:   brk                         ; 36FA:  00
b00_b6fb:   brk                         ; 36FB:  00
b00_b6fc:   .db $3c                     ; 36FC:  3c
b00_b6fd:   bvs $b73b                   ; 36FD:  70 3c
b00_b6ff:   asl $007c                   ; 36FF:  0e 7c 00
b00_b702:   brk                         ; 3702:  00
b00_b703:   brk                         ; 3703:  00
b00_b704:   .db $3c                     ; 3704:  3c
b00_b705:   bvs $b743                   ; 3705:  70 3c
b00_b707:   asl $007c                   ; 3707:  0e 7c 00
b00_b70a:   brk                         ; 370A:  00
b00_b70b:   sec                         ; 370B:  38
b00_b70c:   inc $3838,x                 ; 370C:  fe 38 38
b00_b70f:   sec                         ; 370F:  38
b00_b710:   sec                         ; 3710:  38
b00_b711:   brk                         ; 3711:  00
b00_b712:   brk                         ; 3712:  00
b00_b713:   sec                         ; 3713:  38
b00_b714:   inc $3838,x                 ; 3714:  fe 38 38
b00_b717:   sec                         ; 3717:  38
b00_b718:   sec                         ; 3718:  38
b00_b719:   brk                         ; 3719:  00
b00_b71a:   brk                         ; 371A:  00
b00_b71b:   brk                         ; 371B:  00
b00_b71c:   ror $6e6e                   ; 371C:  6e 6e 6e
b00_b71f:   ror $003c                   ; 371F:  6e 3c 00
b00_b722:   brk                         ; 3722:  00
b00_b723:   brk                         ; 3723:  00
b00_b724:   ror $6e6e                   ; 3724:  6e 6e 6e
b00_b727:   ror $003c                   ; 3727:  6e 3c 00
b00_b72a:   brk                         ; 372A:  00
b00_b72b:   brk                         ; 372B:  00
b00_b72c:   ror $6e6e                   ; 372C:  6e 6e 6e
b00_b72f:   .db $3c                     ; 372F:  3c
b00_b730:   clc                         ; 3730:  18
b00_b731:   brk                         ; 3731:  00
b00_b732:   brk                         ; 3732:  00
b00_b733:   brk                         ; 3733:  00
b00_b734:   ror $6e6e                   ; 3734:  6e 6e 6e
b00_b737:   .db $3c                     ; 3737:  3c
b00_b738:   clc                         ; 3738:  18
b00_b739:   brk                         ; 3739:  00
b00_b73a:   brk                         ; 373A:  00
b00_b73b:   brk                         ; 373B:  00
b00_b73c:   .db $db                     ; 373C:  db
b00_b73d:   .db $db                     ; 373D:  db
b00_b73e:   .db $db                     ; 373E:  db
b00_b73f:   .db $db                     ; 373F:  db
b00_b740:   ror $0000                   ; 3740:  6e 00 00
b00_b743:   brk                         ; 3743:  00
b00_b744:   .db $db                     ; 3744:  db
b00_b745:   .db $db                     ; 3745:  db
b00_b746:   .db $db                     ; 3746:  db
b00_b747:   .db $db                     ; 3747:  db
b00_b748:   ror $0000                   ; 3748:  6e 00 00
b00_b74b:   brk                         ; 374B:  00
b00_b74c:   ror $3c                     ; 374C:  66 3c
b00_b74e:   clc                         ; 374E:  18
b00_b74f:   .db $3c                     ; 374F:  3c
b00_b750:   ror $00                     ; 3750:  66 00
b00_b752:   brk                         ; 3752:  00
b00_b753:   brk                         ; 3753:  00
b00_b754:   ror $3c                     ; 3754:  66 3c
b00_b756:   clc                         ; 3756:  18
b00_b757:   .db $3c                     ; 3757:  3c
b00_b758:   ror $00                     ; 3758:  66 00
b00_b75a:   brk                         ; 375A:  00
b00_b75b:   brk                         ; 375B:  00
b00_b75c:   ror $6e6e                   ; 375C:  6e 6e 6e
b00_b75f:   rol $7c0e,x                 ; 375F:  3e 0e 7c
b00_b762:   brk                         ; 3762:  00
b00_b763:   brk                         ; 3763:  00
b00_b764:   ror $6e6e                   ; 3764:  6e 6e 6e
b00_b767:   rol $7c0e,x                 ; 3767:  3e 0e 7c
b00_b76a:   brk                         ; 376A:  00
b00_b76b:   brk                         ; 376B:  00
b00_b76c:   ror $381c,x                 ; 376C:  7e 1c 38
b00_b76f:   bvs $b7ef                   ; 376F:  70 7e
b00_b771:   brk                         ; 3771:  00
b00_b772:   brk                         ; 3772:  00
b00_b773:   brk                         ; 3773:  00
b00_b774:   ror $381c,x                 ; 3774:  7e 1c 38
b00_b777:   bvs $b7f7                   ; 3777:  70 7e
b00_b779:   brk                         ; 3779:  00
b00_b77a:   brk                         ; 377A:  00
b00_b77b:   bit $7e                     ; 377B:  24 7e
b00_b77d:   bit $24                     ; 377D:  24 24
b00_b77f:   ror $0024,x                 ; 377F:  7e 24 00
b00_b782:   brk                         ; 3782:  00
b00_b783:   bit $7e                     ; 3783:  24 7e
b00_b785:   bit $24                     ; 3785:  24 24
b00_b787:   ror $0024,x                 ; 3787:  7e 24 00
b00_b78a:   brk                         ; 378A:  00
b00_b78b:   .db $72                     ; 378B:  72
b00_b78c:   .db $54                     ; 378C:  54
b00_b78d:   sei                         ; 378D:  78
b00_b78e:   asl $4e2a,x                 ; 378E:  1e 2a 4e
b00_b791:   brk                         ; 3791:  00
b00_b792:   brk                         ; 3792:  00
b00_b793:   .db $72                     ; 3793:  72
b00_b794:   .db $54                     ; 3794:  54
b00_b795:   sei                         ; 3795:  78
b00_b796:   asl $4e2a,x                 ; 3796:  1e 2a 4e
b00_b799:   brk                         ; 3799:  00
b00_b79a:   brk                         ; 379A:  00
b00_b79b:   bpl $b7f1                   ; 379B:  10 54
b00_b79d:   sec                         ; 379D:  38
b00_b79e:   sec                         ; 379E:  38
b00_b79f:   .db $54                     ; 379F:  54
b00_b7a0:   bpl $b7a2                   ; 37A0:  10 00
b00_b7a2:   brk                         ; 37A2:  00
b00_b7a3:   bpl $b7f9                   ; 37A3:  10 54
b00_b7a5:   sec                         ; 37A5:  38
b00_b7a6:   sec                         ; 37A6:  38
b00_b7a7:   .db $54                     ; 37A7:  54
b00_b7a8:   bpl $b7aa                   ; 37A8:  10 00
b00_b7aa:   brk                         ; 37AA:  00
b00_b7ab:   brk                         ; 37AB:  00
b00_b7ac:   bpl $b7be                   ; 37AC:  10 10
b00_b7ae:   .db $7c                     ; 37AE:  7c
b00_b7af:   bpl $b7c1                   ; 37AF:  10 10
b00_b7b1:   brk                         ; 37B1:  00
b00_b7b2:   brk                         ; 37B2:  00
b00_b7b3:   brk                         ; 37B3:  00
b00_b7b4:   bpl $b7c6                   ; 37B4:  10 10
b00_b7b6:   .db $7c                     ; 37B6:  7c
b00_b7b7:   bpl $b7c9                   ; 37B7:  10 10
b00_b7b9:   brk                         ; 37B9:  00
b00_b7ba:   brk                         ; 37BA:  00
b00_b7bb:   brk                         ; 37BB:  00
b00_b7bc:   brk                         ; 37BC:  00
b00_b7bd:   brk                         ; 37BD:  00
b00_b7be:   clc                         ; 37BE:  18
b00_b7bf:   clc                         ; 37BF:  18
b00_b7c0:   php                         ; 37C0:  08
b00_b7c1:   bpl $b7c3                   ; 37C1:  10 00
b00_b7c3:   brk                         ; 37C3:  00
b00_b7c4:   brk                         ; 37C4:  00
b00_b7c5:   brk                         ; 37C5:  00
b00_b7c6:   clc                         ; 37C6:  18
b00_b7c7:   clc                         ; 37C7:  18
b00_b7c8:   php                         ; 37C8:  08
b00_b7c9:   bpl $b809                   ; 37C9:  10 3e
b00_b7cb:   asl $2a,x                   ; 37CB:  16 2a
b00_b7cd:   plp                         ; 37CD:  28
b00_b7ce:   rol $2816,x                 ; 37CE:  3e 16 28
b00_b7d1:   bmi $b811                   ; 37D1:  30 3e
b00_b7d3:   asl $28,x                   ; 37D3:  16 28
b00_b7d5:   bmi $b815                   ; 37D5:  30 3e
b00_b7d7:   asl $38,x                   ; 37D7:  16 38
b00_b7d9:   bmi $b81e                   ; 37D9:  30 43
b00_b7db:   .db $6f                     ; 37DB:  6f
b00_b7dc:   ror $7267                   ; 37DC:  6e 67 72
b00_b7df:   adc ($74,x)                 ; 37DF:  61 74
b00_b7e1:   adc $6c,x                   ; 37E1:  75 6c
b00_b7e3:   adc ($74,x)                 ; 37E3:  61 74
b00_b7e5:   adc #$6f                    ; 37E5:  69 6f
b00_b7e7:   ror $2073                   ; 37E7:  6e 73 20
b00_b7ea:   adc $2079                   ; 37EA:  6d 79 20
b00_b7ed:   jmp $726f                   ; 37ED:  4c 6f 72
b00_b7f0:   .db $64                     ; 37F0:  64
b00_b7f1:   and ($0a,x)                 ; 37F1:  21 0a
b00_b7f3:   brk                         ; 37F3:  00
b00_b7f4:   eor #$6e                    ; 37F4:  49 6e
b00_b7f6:   jsr $6874                   ; 37F6:  20 74 68
b00_b7f9:   adc $20                     ; 37F9:  65 20
b00_b7fb:   adc $6165,y                 ; 37FB:  79 65 61
b00_b7fe:   .db $72                     ; 37FE:  72
b00_b7ff:   jsr $3425                   ; 37FF:  20 25 34
b00_b802:   .db $64                     ; 3802:  64
b00_b803:   asl a                       ; 3803:  0a
b00_b804:   brk                         ; 3804:  00
b00_b805:   adc $756f,y                 ; 3805:  79 6f 75
b00_b808:   jsr $6e75                   ; 3808:  20 75 6e
b00_b80b:   adc #$74                    ; 380B:  69 74
b00_b80d:   adc $64                     ; 380D:  65 64
b00_b80f:   jsr $614a                   ; 380F:  20 4a 61
b00_b812:   bvs $b875                   ; 3812:  70 61
b00_b814:   ror $0021                   ; 3814:  6e 21 00
b00_b817:   .db $47                     ; 3817:  47
b00_b818:   adc ($6d,x)                 ; 3818:  61 6d
b00_b81a:   adc $20                     ; 381A:  65 20
b00_b81c:   .db $6f                     ; 381C:  6f
b00_b81d:   ror $65,x                   ; 381D:  76 65
b00_b81f:   .db $72                     ; 381F:  72
b00_b820:   brk                         ; 3820:  00
b00_b821:   .db $57                     ; 3821:  57
b00_b822:   .db $6f                     ; 3822:  6f
b00_b823:   adc $6c,x                   ; 3823:  75 6c
b00_b825:   .db $64                     ; 3825:  64
b00_b826:   jsr $6f79                   ; 3826:  20 79 6f
b00_b829:   adc $20,x                   ; 3829:  75 20
b00_b82b:   jmp ($6b69)                 ; 382B:  6c 69 6b
b00_b82e:   adc $20                     ; 382E:  65 20
b00_b830:   .db $74                     ; 3830:  74
b00_b831:   .db $6f                     ; 3831:  6f
b00_b832:   asl a                       ; 3832:  0a
b00_b833:   bvs $b8a1                   ; 3833:  70 6c
b00_b835:   adc ($79,x)                 ; 3835:  61 79
b00_b837:   jsr $6761                   ; 3837:  20 61 67
b00_b83a:   adc ($69,x)                 ; 383A:  61 69
b00_b83c:   ror $5400                   ; 383C:  6e 00 54
b00_b83f:   pla                         ; 383F:  68
b00_b840:   adc ($6e,x)                 ; 3840:  61 6e
b00_b842:   .db $6b                     ; 3842:  6b
b00_b843:   .db $73                     ; 3843:  73
b00_b844:   jsr $6f66                   ; 3844:  20 66 6f
b00_b847:   .db $72                     ; 3847:  72
b00_b848:   asl a                       ; 3848:  0a
b00_b849:   bvs $b8b7                   ; 3849:  70 6c
b00_b84b:   adc ($79,x)                 ; 384B:  61 79
b00_b84d:   adc #$6e                    ; 384D:  69 6e
b00_b84f:   .db $67                     ; 384F:  67
b00_b850:   brk                         ; 3850:  00
b00_b851:   brk                         ; 3851:  00
b00_b852:   rol $2912,x                 ; 3852:  3e 12 29
b00_b855:   bmi $b895                   ; 3855:  30 3e
b00_b857:   .db $02                     ; 3857:  02
b00_b858:   .db $12                     ; 3858:  12
b00_b859:   and ($3e,x)                 ; 3859:  21 3e
b00_b85b:   asl $27,x                   ; 385B:  16 27
b00_b85d:   bmi $b89d                   ; 385D:  30 3e
b00_b85f:   sec                         ; 385F:  38
b00_b860:   bmi $b892                   ; 3860:  30 30
b00_b862:   rol $2816,x                 ; 3862:  3e 16 28
b00_b865:   bmi $b8a5                   ; 3865:  30 3e
b00_b867:   asl $28                     ; 3867:  06 28
b00_b869:   bmi $b8a9                   ; 3869:  30 3e
b00_b86b:   clc                         ; 386B:  18
b00_b86c:   and #$30                    ; 386C:  29 30
b00_b86e:   rol $0118,x                 ; 386E:  3e 18 01
b00_b871:   bmi $b8b1                   ; 3871:  30 3e
b00_b873:   jsr $3021                   ; 3873:  20 21 30
b00_b876:   rol $2423,x                 ; 3876:  3e 23 24
b00_b879:   and $3e                     ; 3879:  25 3e
b00_b87b:   rol $27                     ; 387B:  26 27
b00_b87d:   plp                         ; 387D:  28
b00_b87e:   rol $2a29,x                 ; 387E:  3e 29 2a
b00_b881:   .db $2b                     ; 3881:  2b
b00_b882:   lsr $7765                   ; 3882:  4e 65 77
b00_b885:   jsr $6167                   ; 3885:  20 67 61
b00_b888:   adc $0065                   ; 3888:  6d 65 00
b00_b88b:   .db $4b                     ; 388B:  4b
b00_b88c:   .db $4f                     ; 388C:  4f
b00_b88d:   eor $49                     ; 388D:  45 49
b00_b88f:   brk                         ; 388F:  00
b00_b890:   lsr $206f                   ; 3890:  4e 6f 20
b00_b893:   .db $73                     ; 3893:  73
b00_b894:   adc ($76,x)                 ; 3894:  61 76
b00_b896:   adc $64                     ; 3896:  65 64
b00_b898:   jsr $6164                   ; 3898:  20 64 61
b00_b89b:   .db $74                     ; 389B:  74
b00_b89c:   adc ($00,x)                 ; 389C:  61 00
b00_b89e:   brk                         ; 389E:  00
b00_b89f:   .db $44                     ; 389F:  44
b00_b8a0:   adc ($74,x)                 ; 38A0:  61 74
b00_b8a2:   adc ($20,x)                 ; 38A2:  61 20
b00_b8a4:   jmp ($616f)                 ; 38A4:  6c 6f 61
b00_b8a7:   .db $64                     ; 38A7:  64
b00_b8a8:   adc $64                     ; 38A8:  65 64
b00_b8aa:   brk                         ; 38AA:  00
b00_b8ab:   jsr $2020                   ; 38AB:  20 20 20
b00_b8ae:   jsr $4400                   ; 38AE:  20 00 44
b00_b8b1:   adc ($74,x)                 ; 38B1:  61 74
b00_b8b3:   adc ($20,x)                 ; 38B3:  61 20
b00_b8b5:   .db $63                     ; 38B5:  63
b00_b8b6:   adc ($6e,x)                 ; 38B6:  61 6e
b00_b8b8:   rts                         ; 38B8:  60
b00_b8b9:   .db $74                     ; 38B9:  74
b00_b8ba:   jsr $6562                   ; 38BA:  20 62 65
b00_b8bd:   asl a                       ; 38BD:  0a
b00_b8be:   adc $73,x                   ; 38BE:  75 73
b00_b8c0:   adc $64                     ; 38C0:  65 64
b00_b8c2:   brk                         ; 38C2:  00
b00_b8c3:   and $33                     ; 38C3:  25 33
b00_b8c5:   .db $64                     ; 38C5:  64
b00_b8c6:   brk                         ; 38C6:  00
b00_b8c7:   brk                         ; 38C7:  00
b00_b8c8:   plp                         ; 38C8:  28
b00_b8c9:   and ($37),y                 ; 38C9:  31 37
b00_b8cb:   ror $69                     ; 38CB:  66 69
b00_b8cd:   adc $66                     ; 38CD:  65 66
b00_b8cf:   .db $73                     ; 38CF:  73
b00_b8d0:   .db $2f                     ; 38D0:  2f
b00_b8d1:   and $30,x                   ; 38D1:  35 30
b00_b8d3:   ror $69                     ; 38D3:  66 69
b00_b8d5:   adc $66                     ; 38D5:  65 66
b00_b8d7:   .db $73                     ; 38D7:  73
b00_b8d8:   and #$0a                    ; 38D8:  29 0a
b00_b8da:   .db $3f                     ; 38DA:  3f
b00_b8db:   jsr $5700                   ; 38DB:  20 00 57
b00_b8de:   adc ($74,x)                 ; 38DE:  61 74
b00_b8e0:   .db $63                     ; 38E0:  63
b00_b8e1:   pla                         ; 38E1:  68
b00_b8e2:   jsr $746f                   ; 38E2:  20 6f 74
b00_b8e5:   pla                         ; 38E5:  68
b00_b8e6:   adc $72                     ; 38E6:  65 72
b00_b8e8:   asl a                       ; 38E8:  0a
b00_b8e9:   .db $64                     ; 38E9:  64
b00_b8ea:   adc ($69,x)                 ; 38EA:  61 69
b00_b8ec:   adc $6f79                   ; 38EC:  6d 79 6f
b00_b8ef:   .db $73                     ; 38EF:  73
b00_b8f0:   jsr $6162                   ; 38F0:  20 62 61
b00_b8f3:   .db $74                     ; 38F3:  74
b00_b8f4:   .db $74                     ; 38F4:  74
b00_b8f5:   jmp ($0065)                 ; 38F5:  6c 65 00
b00_b8f8:   bvc $b966                   ; 38F8:  50 6c
b00_b8fa:   adc ($79,x)                 ; 38FA:  61 79
b00_b8fc:   adc $72                     ; 38FC:  65 72
b00_b8fe:   jsr $2500                   ; 38FE:  20 00 25
b00_b901:   .db $64                     ; 3901:  64
b00_b902:   bit $7720                   ; 3902:  2c 20 77
b00_b905:   pla                         ; 3905:  68
b00_b906:   adc #$63                    ; 3906:  69 63
b00_b908:   pla                         ; 3908:  68
b00_b909:   asl a                       ; 3909:  0a
b00_b90a:   ror $69                     ; 390A:  66 69
b00_b90c:   adc $66                     ; 390C:  65 66
b00_b90e:   jsr $6f77                   ; 390E:  20 77 6f
b00_b911:   adc $6c,x                   ; 3911:  75 6c
b00_b913:   .db $64                     ; 3913:  64
b00_b914:   jsr $6f79                   ; 3914:  20 79 6f
b00_b917:   adc $0a,x                   ; 3917:  75 0a
b00_b919:   jmp ($6b69)                 ; 3919:  6c 69 6b
b00_b91c:   adc $20                     ; 391C:  65 20
b00_b91e:   .db $74                     ; 391E:  74
b00_b91f:   .db $6f                     ; 391F:  6f
b00_b920:   jsr $7572                   ; 3920:  20 72 75
b00_b923:   jmp ($0065)                 ; 3923:  6c 65 00
b00_b926:   eor #$73                    ; 3926:  49 73
b00_b928:   jsr $2000                   ; 3928:  20 00 20
b00_b92b:   .db $6f                     ; 392B:  6f
b00_b92c:   ror $0a                     ; 392C:  66 0a
b00_b92e:   ror $69                     ; 392E:  66 69
b00_b930:   adc $66                     ; 3930:  65 66
b00_b932:   jsr $3225                   ; 3932:  20 25 32
b00_b935:   .db $64                     ; 3935:  64
b00_b936:   jsr $4b4f                   ; 3936:  20 4f 4b
b00_b939:   brk                         ; 3939:  00
b00_b93a:   .db $54                     ; 393A:  54
b00_b93b:   pla                         ; 393B:  68
b00_b93c:   adc ($74,x)                 ; 393C:  61 74
b00_b93e:   jsr $6164                   ; 393E:  20 64 61
b00_b941:   adc #$6d                    ; 3941:  69 6d
b00_b943:   adc $206f,y                 ; 3943:  79 6f 20
b00_b946:   adc #$73                    ; 3946:  69 73
b00_b948:   asl a                       ; 3948:  0a
b00_b949:   adc ($6c,x)                 ; 3949:  61 6c
b00_b94b:   .db $72                     ; 394B:  72
b00_b94c:   adc $61                     ; 394C:  65 61
b00_b94e:   .db $64                     ; 394E:  64
b00_b94f:   adc $7420,y                 ; 394F:  79 20 74
b00_b952:   adc ($6b,x)                 ; 3952:  61 6b
b00_b954:   adc $6e                     ; 3954:  65 6e
b00_b956:   brk                         ; 3956:  00
b00_b957:   lsr $69                     ; 3957:  46 69
b00_b959:   adc $66                     ; 3959:  65 66
b00_b95b:   jsr $3225                   ; 395B:  20 25 32
b00_b95e:   .db $64                     ; 395E:  64
b00_b95f:   brk                         ; 395F:  00
b00_b960:   eor ($67,x)                 ; 3960:  41 67
b00_b962:   adc $2d                     ; 3962:  65 2d
b00_b964:   and $32                     ; 3964:  25 32
b00_b966:   .db $64                     ; 3966:  64
b00_b967:   and $5000                   ; 3967:  2d 00 50
b00_b96a:   jmp ($6165)                 ; 396A:  6c 65 61
b00_b96d:   .db $73                     ; 396D:  73
b00_b96e:   adc $20                     ; 396E:  65 20
b00_b970:   .db $73                     ; 3970:  73
b00_b971:   adc $74                     ; 3971:  65 74
b00_b973:   brk                         ; 3973:  00
b00_b974:   .db $64                     ; 3974:  64
b00_b975:   adc ($69,x)                 ; 3975:  61 69
b00_b977:   adc $6f79                   ; 3977:  6d 79 6f
b00_b97a:   jsr $6261                   ; 397A:  20 61 62
b00_b97d:   adc #$6c                    ; 397D:  69 6c
b00_b97f:   adc #$74                    ; 397F:  69 74
b00_b981:   adc #$65                    ; 3981:  69 65
b00_b983:   .db $73                     ; 3983:  73
b00_b984:   brk                         ; 3984:  00
b00_b985:   bvc $b9f9                   ; 3985:  50 72
b00_b987:   adc $73                     ; 3987:  65 73
b00_b989:   .db $73                     ; 3989:  73
b00_b98a:   jsr $6e61                   ; 398A:  20 61 6e
b00_b98d:   adc $6220,y                 ; 398D:  79 20 62
b00_b990:   adc $74,x                   ; 3990:  75 74
b00_b992:   .db $74                     ; 3992:  74
b00_b993:   .db $6f                     ; 3993:  6f
b00_b994:   ror $7400                   ; 3994:  6e 00 74
b00_b997:   .db $6f                     ; 3997:  6f
b00_b998:   jsr $6573                   ; 3998:  20 73 65
b00_b99b:   .db $74                     ; 399B:  74
b00_b99c:   jsr $6261                   ; 399C:  20 61 62
b00_b99f:   adc #$6c                    ; 399F:  69 6c
b00_b9a1:   adc #$74                    ; 39A1:  69 74
b00_b9a3:   adc #$65                    ; 39A3:  69 65
b00_b9a5:   .db $73                     ; 39A5:  73
b00_b9a6:   brk                         ; 39A6:  00
b00_b9a7:   and $2020                   ; 39A7:  2d 20 20
b00_b9aa:   jsr $002d                   ; 39AA:  20 2d 00
b00_b9ad:   .db $54                     ; 39AD:  54
b00_b9ae:   .db $6f                     ; 39AE:  6f
b00_b9af:   .db $74                     ; 39AF:  74
b00_b9b0:   adc ($6c,x)                 ; 39B0:  61 6c
b00_b9b2:   jsr $2520                   ; 39B2:  20 20 25
b00_b9b5:   .db $34                     ; 39B5:  34
b00_b9b6:   .db $64                     ; 39B6:  64
b00_b9b7:   brk                         ; 39B7:  00
b00_b9b8:   eor #$73                    ; 39B8:  49 73
b00_b9ba:   jsr $6874                   ; 39BA:  20 74 68
b00_b9bd:   adc #$73                    ; 39BD:  69 73
b00_b9bf:   jsr $4b4f                   ; 39BF:  20 4f 4b
b00_b9c2:   brk                         ; 39C2:  00
b00_b9c3:   .db $43                     ; 39C3:  43
b00_b9c4:   .db $6f                     ; 39C4:  6f
b00_b9c5:   ror $7274                   ; 39C5:  6e 74 72
b00_b9c8:   .db $6f                     ; 39C8:  6f
b00_b9c9:   jmp ($3120)                 ; 39C9:  6c 20 31
b00_b9cc:   brk                         ; 39CC:  00
b00_b9cd:   pha                         ; 39CD:  48
b00_b9ce:   .db $6f                     ; 39CE:  6f
b00_b9cf:   .db $77                     ; 39CF:  77
b00_b9d0:   jsr $616d                   ; 39D0:  20 6d 61
b00_b9d3:   ror $2079                   ; 39D3:  6e 79 20
b00_b9d6:   bvs $ba44                   ; 39D6:  70 6c
b00_b9d8:   adc ($79,x)                 ; 39D8:  61 79
b00_b9da:   adc $72                     ; 39DA:  65 72
b00_b9dc:   .db $73                     ; 39DC:  73
b00_b9dd:   brk                         ; 39DD:  00
b00_b9de:   bvc $ba4c                   ; 39DE:  50 6c
b00_b9e0:   adc $61                     ; 39E0:  65 61
b00_b9e2:   .db $73                     ; 39E2:  73
b00_b9e3:   adc $20                     ; 39E3:  65 20
b00_b9e5:   .db $73                     ; 39E5:  73
b00_b9e6:   adc $6c                     ; 39E6:  65 6c
b00_b9e8:   adc $63                     ; 39E8:  65 63
b00_b9ea:   .db $74                     ; 39EA:  74
b00_b9eb:   asl a                       ; 39EB:  0a
b00_b9ec:   .db $73                     ; 39EC:  73
b00_b9ed:   .db $6b                     ; 39ED:  6b
b00_b9ee:   adc #$6c                    ; 39EE:  69 6c
b00_b9f0:   jmp ($6c20)                 ; 39F0:  6c 20 6c
b00_b9f3:   adc $76                     ; 39F3:  65 76
b00_b9f5:   adc $6c                     ; 39F5:  65 6c
b00_b9f7:   brk                         ; 39F7:  00
b00_b9f8:   eor #$73                    ; 39F8:  49 73
b00_b9fa:   jsr $7665                   ; 39FA:  20 65 76
b00_b9fd:   adc $72                     ; 39FD:  65 72
b00_b9ff:   adc $6874,y                 ; 39FF:  79 74 68
b00_ba02:   adc #$6e                    ; 3A02:  69 6e
b00_ba04:   .db $67                     ; 3A04:  67
b00_ba05:   jsr $4b4f                   ; 3A05:  20 4f 4b
b00_ba08:   asl a                       ; 3A08:  0a
b00_ba09:   .db $73                     ; 3A09:  73
b00_ba0a:   .db $6f                     ; 3A0A:  6f
b00_ba0b:   jsr $6166                   ; 3A0B:  20 66 61
b00_ba0e:   .db $72                     ; 3A0E:  72
b00_ba0f:   brk                         ; 3A0F:  00
b00_ba10:   .db $54                     ; 3A10:  54
b00_ba11:   pla                         ; 3A11:  68
b00_ba12:   adc $6e                     ; 3A12:  65 6e
b00_ba14:   jsr $6e6f                   ; 3A14:  20 6f 6e
b00_ba17:   jsr $6977                   ; 3A17:  20 77 69
b00_ba1a:   .db $74                     ; 3A1A:  74
b00_ba1b:   pla                         ; 3A1B:  68
b00_ba1c:   jsr $6874                   ; 3A1C:  20 74 68
b00_ba1f:   adc $0a                     ; 3A1F:  65 0a
b00_ba21:   .db $67                     ; 3A21:  67
b00_ba22:   adc ($6d,x)                 ; 3A22:  61 6d
b00_ba24:   adc $21                     ; 3A24:  65 21
b00_ba26:   brk                         ; 3A26:  00
b00_ba27:   brk                         ; 3A27:  00
b00_ba28:   bvc $ba93                   ; 3A28:  50 69
b00_ba2a:   .db $72                     ; 3A2A:  72
b00_ba2b:   adc ($74,x)                 ; 3A2B:  61 74
b00_ba2d:   adc $73                     ; 3A2D:  65 73
b00_ba2f:   jsr $4300                   ; 3A2F:  20 00 43
b00_ba32:   pla                         ; 3A32:  68
b00_ba33:   .db $72                     ; 3A33:  72
b00_ba34:   adc #$73                    ; 3A34:  69 73
b00_ba36:   .db $74                     ; 3A36:  74
b00_ba37:   ror $0073                   ; 3A37:  6e 73 00
b00_ba3a:   .db $52                     ; 3A3A:  52
b00_ba3b:   adc #$6f                    ; 3A3B:  69 6f
b00_ba3d:   .db $74                     ; 3A3D:  74
b00_ba3e:   adc $72                     ; 3A3E:  65 72
b00_ba40:   .db $73                     ; 3A40:  73
b00_ba41:   jsr $5a00                   ; 3A41:  20 00 5a
b00_ba44:   adc $61                     ; 3A44:  65 61
b00_ba46:   jmp ($746f)                 ; 3A46:  6c 6f 74
b00_ba49:   .db $73                     ; 3A49:  73
b00_ba4a:   jsr $4d00                   ; 3A4A:  20 00 4d
b00_ba4d:   .db $6f                     ; 3A4D:  6f
b00_ba4e:   ror $736b                   ; 3A4E:  6e 6b 73
b00_ba51:   jsr $2020                   ; 3A51:  20 20 20
b00_ba54:   brk                         ; 3A54:  00
b00_ba55:   .db $52                     ; 3A55:  52
b00_ba56:   adc $62                     ; 3A56:  65 62
b00_ba58:   adc $6c                     ; 3A58:  65 6c
b00_ba5a:   .db $73                     ; 3A5A:  73
b00_ba5b:   jsr $0020                   ; 3A5B:  20 20 00
b00_ba5e:   brk                         ; 3A5E:  00
b00_ba5f:   asl a                       ; 3A5F:  0a
b00_ba60:   .db $57                     ; 3A60:  57
b00_ba61:   .db $6f                     ; 3A61:  6f
b00_ba62:   adc $6c,x                   ; 3A62:  75 6c
b00_ba64:   .db $64                     ; 3A64:  64
b00_ba65:   jsr $6f79                   ; 3A65:  20 79 6f
b00_ba68:   adc $20,x                   ; 3A68:  75 20
b00_ba6a:   jmp ($6b69)                 ; 3A6A:  6c 69 6b
b00_ba6d:   adc $20                     ; 3A6D:  65 20
b00_ba6f:   .db $74                     ; 3A6F:  74
b00_ba70:   .db $6f                     ; 3A70:  6f
b00_ba71:   asl a                       ; 3A71:  0a
b00_ba72:   .db $62                     ; 3A72:  62
b00_ba73:   adc #$64                    ; 3A73:  69 64
b00_ba75:   jsr $6f66                   ; 3A75:  20 66 6f
b00_ba78:   .db $72                     ; 3A78:  72
b00_ba79:   jsr $6966                   ; 3A79:  20 66 69
b00_ba7c:   adc $66                     ; 3A7C:  65 66
b00_ba7e:   jsr $3225                   ; 3A7E:  20 25 32
b00_ba81:   .db $64                     ; 3A81:  64
b00_ba82:   brk                         ; 3A82:  00
b00_ba83:   pha                         ; 3A83:  48
b00_ba84:   .db $6f                     ; 3A84:  6f
b00_ba85:   .db $77                     ; 3A85:  77
b00_ba86:   jsr $756d                   ; 3A86:  20 6d 75
b00_ba89:   .db $63                     ; 3A89:  63
b00_ba8a:   pla                         ; 3A8A:  68
b00_ba8b:   brk                         ; 3A8B:  00
b00_ba8c:   brk                         ; 3A8C:  00
b00_ba8d:   asl a                       ; 3A8D:  0a
b00_ba8e:   lsr $69                     ; 3A8E:  46 69
b00_ba90:   adc $66                     ; 3A90:  65 66
b00_ba92:   jsr $3225                   ; 3A92:  20 25 32
b00_ba95:   .db $64                     ; 3A95:  64
b00_ba96:   jsr $7369                   ; 3A96:  20 69 73
b00_ba99:   jsr $6f79                   ; 3A99:  20 79 6f
b00_ba9c:   adc $72,x                   ; 3A9C:  75 72
b00_ba9e:   .db $73                     ; 3A9E:  73
b00_ba9f:   and ($00,x)                 ; 3A9F:  21 00
b00_baa1:   lsr $69                     ; 3AA1:  46 69
b00_baa3:   adc $66                     ; 3AA3:  65 66
b00_baa5:   jsr $2500                   ; 3AA5:  20 00 25
b00_baa8:   .db $32                     ; 3AA8:  32
b00_baa9:   .db $64                     ; 3AA9:  64
b00_baaa:   jsr $7369                   ; 3AAA:  20 69 73
b00_baad:   jsr $6f6e                   ; 3AAD:  20 6e 6f
b00_bab0:   .db $77                     ; 3AB0:  77
b00_bab1:   asl a                       ; 3AB1:  0a
b00_bab2:   brk                         ; 3AB2:  00
b00_bab3:   rts                         ; 3AB3:  60
b00_bab4:   .db $73                     ; 3AB4:  73
b00_bab5:   asl a                       ; 3AB5:  0a
b00_bab6:   .db $74                     ; 3AB6:  74
b00_bab7:   adc $72                     ; 3AB7:  65 72
b00_bab9:   .db $72                     ; 3AB9:  72
b00_baba:   adc #$74                    ; 3ABA:  69 74
b00_babc:   .db $6f                     ; 3ABC:  6f
b00_babd:   .db $72                     ; 3ABD:  72
b00_babe:   adc $4900,y                 ; 3ABE:  79 00 49
b00_bac1:   ror $6620                   ; 3AC1:  6e 20 66
b00_bac4:   adc #$65                    ; 3AC4:  69 65
b00_bac6:   ror $20                     ; 3AC6:  66 20
b00_bac8:   brk                         ; 3AC8:  00
b00_bac9:   and $64                     ; 3AC9:  25 64
b00_bacb:   bit $0a0a                   ; 3ACB:  2c 0a 0a
b00_bace:   brk                         ; 3ACE:  00
b00_bacf:   jmp $796f                   ; 3ACF:  4c 6f 79
b00_bad2:   adc ($6c,x)                 ; 3AD2:  61 6c
b00_bad4:   .db $73                     ; 3AD4:  73
b00_bad5:   asl a                       ; 3AD5:  0a
b00_bad6:   jsr $2020                   ; 3AD6:  20 20 20
b00_bad9:   jsr $2020                   ; 3AD9:  20 20 20
b00_badc:   jsr $2020                   ; 3ADC:  20 20 20
b00_badf:   jsr $3425                   ; 3ADF:  20 25 34
b00_bae2:   .db $64                     ; 3AE2:  64
b00_bae3:   jsr $656d                   ; 3AE3:  20 6d 65
b00_bae6:   ror $250a                   ; 3AE6:  6e 0a 25
b00_bae9:   .db $73                     ; 3AE9:  73
b00_baea:   asl a                       ; 3AEA:  0a
b00_baeb:   jsr $2020                   ; 3AEB:  20 20 20
b00_baee:   jsr $2020                   ; 3AEE:  20 20 20
b00_baf1:   jsr $2020                   ; 3AF1:  20 20 20
b00_baf4:   jsr $3425                   ; 3AF4:  20 25 34
b00_baf7:   .db $64                     ; 3AF7:  64
b00_baf8:   jsr $656d                   ; 3AF8:  20 6d 65
b00_bafb:   ror $0000                   ; 3AFB:  6e 00 00
b00_bafe:   and $73                     ; 3AFE:  25 73
b00_bb00:   jsr $6168                   ; 3B00:  20 68 61
b00_bb03:   ror $65,x                   ; 3B03:  76 65
b00_bb05:   jsr $6f77                   ; 3B05:  20 77 6f
b00_bb08:   ror $0021                   ; 3B08:  6e 21 00
b00_bb0b:   .db $54                     ; 3B0B:  54
b00_bb0c:   pla                         ; 3B0C:  68
b00_bb0d:   adc $20                     ; 3B0D:  65 20
b00_bb0f:   jmp ($796f)                 ; 3B0F:  6c 6f 79
b00_bb12:   adc ($6c,x)                 ; 3B12:  61 6c
b00_bb14:   jsr $6f66                   ; 3B14:  20 66 6f
b00_bb17:   .db $72                     ; 3B17:  72
b00_bb18:   .db $63                     ; 3B18:  63
b00_bb19:   adc $73                     ; 3B19:  65 73
b00_bb1b:   asl a                       ; 3B1B:  0a
b00_bb1c:   pla                         ; 3B1C:  68
b00_bb1d:   adc ($76,x)                 ; 3B1D:  61 76
b00_bb1f:   adc $20                     ; 3B1F:  65 20
b00_bb21:   .db $77                     ; 3B21:  77
b00_bb22:   .db $6f                     ; 3B22:  6f
b00_bb23:   ror $0021                   ; 3B23:  6e 21 00
b00_bb26:   brk                         ; 3B26:  00
b00_bb27:   asl a                       ; 3B27:  0a
b00_bb28:   .db $74                     ; 3B28:  74
b00_bb29:   pla                         ; 3B29:  68
b00_bb2a:   adc $20                     ; 3B2A:  65 20
b00_bb2c:   bvs $bb93                   ; 3B2C:  70 65
b00_bb2e:   .db $6f                     ; 3B2E:  6f
b00_bb2f:   bvs $bb9d                   ; 3B2F:  70 6c
b00_bb31:   adc $20                     ; 3B31:  65 20
b00_bb33:   adc ($72,x)                 ; 3B33:  61 72
b00_bb35:   adc $0a                     ; 3B35:  65 0a
b00_bb37:   .db $72                     ; 3B37:  72
b00_bb38:   adc $62                     ; 3B38:  65 62
b00_bb3a:   adc $6c                     ; 3B3A:  65 6c
b00_bb3c:   jmp ($6e69)                 ; 3B3C:  6c 69 6e
b00_bb3f:   .db $67                     ; 3B3F:  67
b00_bb40:   and ($20,x)                 ; 3B40:  21 20
b00_bb42:   .db $57                     ; 3B42:  57
b00_bb43:   adc #$6c                    ; 3B43:  69 6c
b00_bb45:   jmp ($790a)                 ; 3B45:  6c 0a 79
b00_bb48:   .db $6f                     ; 3B48:  6f
b00_bb49:   adc $20,x                   ; 3B49:  75 20
b00_bb4b:   adc ($70,x)                 ; 3B4B:  61 70
b00_bb4d:   bvs $bbb4                   ; 3B4D:  70 65
b00_bb4f:   adc ($73,x)                 ; 3B4F:  61 73
b00_bb51:   adc $20                     ; 3B51:  65 20
b00_bb53:   .db $74                     ; 3B53:  74
b00_bb54:   pla                         ; 3B54:  68
b00_bb55:   adc $6d                     ; 3B55:  65 6d
b00_bb57:   asl a                       ; 3B57:  0a
b00_bb58:   .db $77                     ; 3B58:  77
b00_bb59:   adc #$74                    ; 3B59:  69 74
b00_bb5b:   pla                         ; 3B5B:  68
b00_bb5c:   jsr $6f67                   ; 3B5C:  20 67 6f
b00_bb5f:   jmp ($0064)                 ; 3B5F:  6c 64 00
b00_bb62:   .db $47                     ; 3B62:  47
b00_bb63:   adc #$76                    ; 3B63:  69 76
b00_bb65:   adc #$6e                    ; 3B65:  69 6e
b00_bb67:   .db $67                     ; 3B67:  67
b00_bb68:   jsr $6c61                   ; 3B68:  20 61 6c
b00_bb6b:   jmp ($6f20)                 ; 3B6B:  6c 20 6f
b00_bb6e:   ror $20                     ; 3B6E:  66 20
b00_bb70:   adc #$74                    ; 3B70:  69 74
b00_bb72:   asl a                       ; 3B72:  0a
b00_bb73:   brk                         ; 3B73:  00
b00_bb74:   eor #$74                    ; 3B74:  49 74
b00_bb76:   jsr $6964                   ; 3B76:  20 64 69
b00_bb79:   .db $64                     ; 3B79:  64
b00_bb7a:   ror $7460                   ; 3B7A:  6e 60 74
b00_bb7d:   jsr $6f77                   ; 3B7D:  20 77 6f
b00_bb80:   .db $72                     ; 3B80:  72
b00_bb81:   .db $6b                     ; 3B81:  6b
b00_bb82:   and ($00,x)                 ; 3B82:  21 00
b00_bb84:   .db $54                     ; 3B84:  54
b00_bb85:   pla                         ; 3B85:  68
b00_bb86:   adc $79                     ; 3B86:  65 79
b00_bb88:   jsr $7061                   ; 3B88:  20 61 70
b00_bb8b:   bvs $bbf2                   ; 3B8B:  70 65
b00_bb8d:   adc ($72,x)                 ; 3B8D:  61 72
b00_bb8f:   jsr $6f74                   ; 3B8F:  20 74 6f
b00_bb92:   asl a                       ; 3B92:  0a
b00_bb93:   pla                         ; 3B93:  68
b00_bb94:   adc ($76,x)                 ; 3B94:  61 76
b00_bb96:   adc $20                     ; 3B96:  65 20
b00_bb98:   .db $73                     ; 3B98:  73
b00_bb99:   adc $74                     ; 3B99:  65 74
b00_bb9b:   .db $74                     ; 3B9B:  74
b00_bb9c:   jmp ($6465)                 ; 3B9C:  6c 65 64
b00_bb9f:   jsr $6f64                   ; 3B9F:  20 64 6f
b00_bba2:   .db $77                     ; 3BA2:  77
b00_bba3:   ror $a900                   ; 3BA3:  6e 00 a9
b00_bba6:   .db $bb                     ; 3BA6:  bb
b00_bba7:   lda ($bb),y                 ; 3BA7:  b1 bb
b00_bba9:   .db $6f                     ; 3BA9:  6f
b00_bbaa:   jmp ($2064)                 ; 3BAA:  6c 64 20
b00_bbad:   adc ($67,x)                 ; 3BAD:  61 67
b00_bbaf:   adc $00                     ; 3BAF:  65 00
b00_bbb1:   .db $73                     ; 3BB1:  73
b00_bbb2:   adc #$63                    ; 3BB2:  69 63
b00_bbb4:   .db $6b                     ; 3BB4:  6b
b00_bbb5:   ror $7365                   ; 3BB5:  6e 65 73
b00_bbb8:   .db $73                     ; 3BB8:  73
b00_bbb9:   brk                         ; 3BB9:  00
b00_bbba:   jsr $6964                   ; 3BBA:  20 64 69
b00_bbbd:   adc $64                     ; 3BBD:  65 64
b00_bbbf:   jsr $666f                   ; 3BBF:  20 6f 66
b00_bbc2:   asl a                       ; 3BC2:  0a
b00_bbc3:   and $73                     ; 3BC3:  25 73
b00_bbc5:   brk                         ; 3BC5:  00
b00_bbc6:   brk                         ; 3BC6:  00
b00_bbc7:   asl a                       ; 3BC7:  0a
b00_bbc8:   .db $73                     ; 3BC8:  73
b00_bbc9:   .db $6f                     ; 3BC9:  6f
b00_bbca:   adc $6f65                   ; 3BCA:  6d 65 6f
b00_bbcd:   ror $2065                   ; 3BCD:  6e 65 20
b00_bbd0:   pla                         ; 3BD0:  68
b00_bbd1:   adc ($73,x)                 ; 3BD1:  61 73
b00_bbd3:   jsr $6573                   ; 3BD3:  20 73 65
b00_bbd6:   ror $0a74                   ; 3BD6:  6e 74 0a
b00_bbd9:   ror $6e69                   ; 3BD9:  6e 69 6e
b00_bbdc:   ror a                       ; 3BDC:  6a
b00_bbdd:   adc ($20,x)                 ; 3BDD:  61 20
b00_bbdf:   adc ($67,x)                 ; 3BDF:  61 67
b00_bbe1:   adc #$6e                    ; 3BE1:  69 6e
b00_bbe3:   .db $73                     ; 3BE3:  73
b00_bbe4:   .db $74                     ; 3BE4:  74
b00_bbe5:   asl a                       ; 3BE5:  0a
b00_bbe6:   ror $69                     ; 3BE6:  66 69
b00_bbe8:   adc $66                     ; 3BE8:  65 66
b00_bbea:   jsr $2500                   ; 3BEA:  20 00 25
b00_bbed:   .db $32                     ; 3BED:  32
b00_bbee:   .db $64                     ; 3BEE:  64
b00_bbef:   and ($00,x)                 ; 3BEF:  21 00
b00_bbf1:   .db $53                     ; 3BF1:  53
b00_bbf2:   adc $6d,x                   ; 3BF2:  75 6d
b00_bbf4:   adc $7265                   ; 3BF4:  6d 65 72
b00_bbf7:   jsr $6874                   ; 3BF7:  20 74 68
b00_bbfa:   adc #$73                    ; 3BFA:  69 73
b00_bbfc:   jsr $6579                   ; 3BFC:  20 79 65
b00_bbff:   adc ($72,x)                 ; 3BFF:  61 72
b00_bc01:   asl a                       ; 3C01:  0a
b00_bc02:   .db $62                     ; 3C02:  62
b00_bc03:   .db $72                     ; 3C03:  72
b00_bc04:   adc #$6e                    ; 3C04:  69 6e
b00_bc06:   .db $67                     ; 3C06:  67
b00_bc07:   .db $73                     ; 3C07:  73
b00_bc08:   jsr $7974                   ; 3C08:  20 74 79
b00_bc0b:   bvs $bc75                   ; 3C0B:  70 68
b00_bc0d:   .db $6f                     ; 3C0D:  6f
b00_bc0e:   .db $6f                     ; 3C0E:  6f
b00_bc0f:   ror $2173                   ; 3C0F:  6e 73 21
b00_bc12:   brk                         ; 3C12:  00
b00_bc13:   jmp $726f                   ; 3C13:  4c 6f 72
b00_bc16:   .db $64                     ; 3C16:  64
b00_bc17:   bit $700a                   ; 3C17:  2c 0a 70
b00_bc1a:   jmp ($6761)                 ; 3C1A:  6c 61 67
b00_bc1d:   adc $65,x                   ; 3C1D:  75 65
b00_bc1f:   jsr $6168                   ; 3C1F:  20 68 61
b00_bc22:   .db $73                     ; 3C22:  73
b00_bc23:   jsr $6f63                   ; 3C23:  20 63 6f
b00_bc26:   adc $2165                   ; 3C26:  6d 65 21
b00_bc29:   brk                         ; 3C29:  00
b00_bc2a:   brk                         ; 3C2A:  00
b00_bc2b:   asl a                       ; 3C2B:  0a
b00_bc2c:   adc ($20,x)                 ; 3C2C:  61 20
b00_bc2e:   .db $74                     ; 3C2E:  74
b00_bc2f:   adc $6870,y                 ; 3C2F:  79 70 68
b00_bc32:   .db $6f                     ; 3C32:  6f
b00_bc33:   .db $6f                     ; 3C33:  6f
b00_bc34:   ror $6820                   ; 3C34:  6e 20 68
b00_bc37:   adc ($73,x)                 ; 3C37:  61 73
b00_bc39:   asl a                       ; 3C39:  0a
b00_bc3a:   .db $73                     ; 3C3A:  73
b00_bc3b:   .db $74                     ; 3C3B:  74
b00_bc3c:   .db $72                     ; 3C3C:  72
b00_bc3d:   adc $63,x                   ; 3C3D:  75 63
b00_bc3f:   .db $6b                     ; 3C3F:  6b
b00_bc40:   jsr $6966                   ; 3C40:  20 66 69
b00_bc43:   adc $66                     ; 3C43:  65 66
b00_bc45:   jsr $3225                   ; 3C45:  20 25 32
b00_bc48:   .db $64                     ; 3C48:  64
b00_bc49:   and ($00,x)                 ; 3C49:  21 00
b00_bc4b:   brk                         ; 3C4B:  00
b00_bc4c:   asl a                       ; 3C4C:  0a
b00_bc4d:   bvs $bcbb                   ; 3C4D:  70 6c
b00_bc4f:   adc ($67,x)                 ; 3C4F:  61 67
b00_bc51:   adc $65,x                   ; 3C51:  75 65
b00_bc53:   jsr $6168                   ; 3C53:  20 68 61
b00_bc56:   .db $73                     ; 3C56:  73
b00_bc57:   jsr $6f63                   ; 3C57:  20 63 6f
b00_bc5a:   adc $0a65                   ; 3C5A:  6d 65 0a
b00_bc5d:   .db $74                     ; 3C5D:  74
b00_bc5e:   .db $6f                     ; 3C5E:  6f
b00_bc5f:   jsr $6966                   ; 3C5F:  20 66 69
b00_bc62:   adc $66                     ; 3C62:  65 66
b00_bc64:   jsr $3225                   ; 3C64:  20 25 32
b00_bc67:   .db $64                     ; 3C67:  64
b00_bc68:   and ($00,x)                 ; 3C68:  21 00
b00_bc6a:   eor #$6e                    ; 3C6A:  49 6e
b00_bc6c:   jsr $6966                   ; 3C6C:  20 66 69
b00_bc6f:   adc $66                     ; 3C6F:  65 66
b00_bc71:   jsr $2500                   ; 3C71:  20 00 25
b00_bc74:   .db $32                     ; 3C74:  32
b00_bc75:   .db $64                     ; 3C75:  64
b00_bc76:   bit $0a00                   ; 3C76:  2c 00 0a
b00_bc79:   asl a                       ; 3C79:  0a
b00_bc7a:   jmp $796f                   ; 3C7A:  4c 6f 79
b00_bc7d:   adc ($6c,x)                 ; 3C7D:  61 6c
b00_bc7f:   .db $73                     ; 3C7F:  73
b00_bc80:   asl a                       ; 3C80:  0a
b00_bc81:   jsr $2020                   ; 3C81:  20 20 20
b00_bc84:   jsr $2020                   ; 3C84:  20 20 20
b00_bc87:   jsr $2020                   ; 3C87:  20 20 20
b00_bc8a:   jsr $3425                   ; 3C8A:  20 25 34
b00_bc8d:   .db $64                     ; 3C8D:  64
b00_bc8e:   jsr $656d                   ; 3C8E:  20 6d 65
b00_bc91:   ror $520a                   ; 3C91:  6e 0a 52
b00_bc94:   adc $62                     ; 3C94:  65 62
b00_bc96:   adc $6c                     ; 3C96:  65 6c
b00_bc98:   .db $73                     ; 3C98:  73
b00_bc99:   asl a                       ; 3C99:  0a
b00_bc9a:   jsr $2020                   ; 3C9A:  20 20 20
b00_bc9d:   jsr $2020                   ; 3C9D:  20 20 20
b00_bca0:   jsr $2020                   ; 3CA0:  20 20 20
b00_bca3:   jsr $3425                   ; 3CA3:  20 25 34
b00_bca6:   .db $64                     ; 3CA6:  64
b00_bca7:   jsr $656d                   ; 3CA7:  20 6d 65
b00_bcaa:   ror $4200                   ; 3CAA:  6e 00 42
b00_bcad:   adc $77                     ; 3CAD:  65 77
b00_bcaf:   adc ($72,x)                 ; 3CAF:  61 72
b00_bcb1:   adc $21                     ; 3CB1:  65 21
b00_bcb3:   asl a                       ; 3CB3:  0a
b00_bcb4:   eor ($20,x)                 ; 3CB4:  41 20
b00_bcb6:   .db $74                     ; 3CB6:  74
b00_bcb7:   .db $72                     ; 3CB7:  72
b00_bcb8:   adc $61                     ; 3CB8:  65 61
b00_bcba:   .db $63                     ; 3CBA:  63
b00_bcbb:   pla                         ; 3CBB:  68
b00_bcbc:   adc $72                     ; 3CBC:  65 72
b00_bcbe:   .db $6f                     ; 3CBE:  6f
b00_bcbf:   adc $73,x                   ; 3CBF:  75 73
b00_bcc1:   asl a                       ; 3CC1:  0a
b00_bcc2:   .db $73                     ; 3CC2:  73
b00_bcc3:   adc $62,x                   ; 3CC3:  75 62
b00_bcc5:   .db $6f                     ; 3CC5:  6f
b00_bcc6:   .db $72                     ; 3CC6:  72
b00_bcc7:   .db $64                     ; 3CC7:  64
b00_bcc8:   adc #$6e                    ; 3CC8:  69 6e
b00_bcca:   adc ($74,x)                 ; 3CCA:  61 74
b00_bccc:   adc $20                     ; 3CCC:  65 20
b00_bcce:   pla                         ; 3CCE:  68
b00_bccf:   adc ($73,x)                 ; 3CCF:  61 73
b00_bcd1:   asl a                       ; 3CD1:  0a
b00_bcd2:   .db $72                     ; 3CD2:  72
b00_bcd3:   adc ($69,x)                 ; 3CD3:  61 69
b00_bcd5:   .db $73                     ; 3CD5:  73
b00_bcd6:   adc $64                     ; 3CD6:  65 64
b00_bcd8:   jsr $6e61                   ; 3CD8:  20 61 6e
b00_bcdb:   jsr $7261                   ; 3CDB:  20 61 72
b00_bcde:   adc $2079                   ; 3CDE:  6d 79 20
b00_bce1:   .db $74                     ; 3CE1:  74
b00_bce2:   .db $6f                     ; 3CE2:  6f
b00_bce3:   asl a                       ; 3CE3:  0a
b00_bce4:   .db $64                     ; 3CE4:  64
b00_bce5:   adc $73                     ; 3CE5:  65 73
b00_bce7:   .db $74                     ; 3CE7:  74
b00_bce8:   .db $72                     ; 3CE8:  72
b00_bce9:   .db $6f                     ; 3CE9:  6f
b00_bcea:   adc $7920,y                 ; 3CEA:  79 20 79
b00_bced:   .db $6f                     ; 3CED:  6f
b00_bcee:   adc $21,x                   ; 3CEE:  75 21
b00_bcf0:   brk                         ; 3CF0:  00
b00_bcf1:   .db $54                     ; 3CF1:  54
b00_bcf2:   pla                         ; 3CF2:  68
b00_bcf3:   adc $20                     ; 3CF3:  65 20
b00_bcf5:   .db $72                     ; 3CF5:  72
b00_bcf6:   adc $62                     ; 3CF6:  65 62
b00_bcf8:   adc $6c                     ; 3CF8:  65 6c
b00_bcfa:   .db $73                     ; 3CFA:  73
b00_bcfb:   jsr $6168                   ; 3CFB:  20 68 61
b00_bcfe:   ror $65,x                   ; 3CFE:  76 65
b00_bd00:   asl a                       ; 3D00:  0a
b00_bd01:   .db $77                     ; 3D01:  77
b00_bd02:   .db $6f                     ; 3D02:  6f
b00_bd03:   ror $0021                   ; 3D03:  6e 21 00
b00_bd06:   .db $54                     ; 3D06:  54
b00_bd07:   pla                         ; 3D07:  68
b00_bd08:   adc $20                     ; 3D08:  65 20
b00_bd0a:   jmp ($796f)                 ; 3D0A:  6c 6f 79
b00_bd0d:   adc ($6c,x)                 ; 3D0D:  61 6c
b00_bd0f:   jsr $656d                   ; 3D0F:  20 6d 65
b00_bd12:   ror $680a                   ; 3D12:  6e 0a 68
b00_bd15:   adc ($76,x)                 ; 3D15:  61 76
b00_bd17:   adc $20                     ; 3D17:  65 20
b00_bd19:   .db $77                     ; 3D19:  77
b00_bd1a:   .db $6f                     ; 3D1A:  6f
b00_bd1b:   ror $0021                   ; 3D1B:  6e 21 00
b00_bd1e:   eor ($6b,x)                 ; 3D1E:  41 6b
b00_bd20:   adc $63                     ; 3D20:  65 63
b00_bd22:   pla                         ; 3D22:  68
b00_bd23:   adc #$20                    ; 3D23:  69 20
b00_bd25:   eor $7469                   ; 3D25:  4d 69 74
b00_bd28:   .db $73                     ; 3D28:  73
b00_bd29:   adc $68,x                   ; 3D29:  75 68
b00_bd2b:   adc #$64                    ; 3D2B:  69 64
b00_bd2d:   adc $20                     ; 3D2D:  65 20
b00_bd2f:   ror $61                     ; 3D2F:  66 61
b00_bd31:   adc #$6c                    ; 3D31:  69 6c
b00_bd33:   adc $64                     ; 3D33:  65 64
b00_bd35:   jsr $6f74                   ; 3D35:  20 74 6f
b00_bd38:   asl a                       ; 3D38:  0a
b00_bd39:   .db $74                     ; 3D39:  74
b00_bd3a:   adc ($6b,x)                 ; 3D3A:  61 6b
b00_bd3c:   adc $20                     ; 3D3C:  65 20
b00_bd3e:   adc $756f,y                 ; 3D3E:  79 6f 75
b00_bd41:   .db $72                     ; 3D41:  72
b00_bd42:   jsr $696c                   ; 3D42:  20 6c 69
b00_bd45:   ror $65                     ; 3D45:  66 65
b00_bd47:   jsr $6e61                   ; 3D47:  20 61 6e
b00_bd4a:   .db $64                     ; 3D4A:  64
b00_bd4b:   jsr $6977                   ; 3D4B:  20 77 69
b00_bd4e:   jmp ($206c)                 ; 3D4E:  6c 6c 20
b00_bd51:   bvs $bdb4                   ; 3D51:  70 61
b00_bd53:   adc $0021,y                 ; 3D53:  79 21 00
b00_bd56:   lsr $626f                   ; 3D56:  4e 6f 62
b00_bd59:   adc $6e,x                   ; 3D59:  75 6e
b00_bd5b:   adc ($67,x)                 ; 3D5B:  61 67
b00_bd5d:   adc ($20,x)                 ; 3D5D:  61 20
b00_bd5f:   brk                         ; 3D5F:  00
b00_bd60:   pla                         ; 3D60:  68
b00_bd61:   adc ($73,x)                 ; 3D61:  61 73
b00_bd63:   jsr $6562                   ; 3D63:  20 62 65
b00_bd66:   adc $6e                     ; 3D66:  65 6e
b00_bd68:   jsr $6564                   ; 3D68:  20 64 65
b00_bd6b:   .db $73                     ; 3D6B:  73
b00_bd6c:   .db $74                     ; 3D6C:  74
b00_bd6d:   .db $72                     ; 3D6D:  72
b00_bd6e:   .db $6f                     ; 3D6E:  6f
b00_bd6f:   adc $6465,y                 ; 3D6F:  79 65 64
b00_bd72:   bit $620a                   ; 3D72:  2c 0a 62
b00_bd75:   adc $74,x                   ; 3D75:  75 74
b00_bd77:   jsr $6e69                   ; 3D77:  20 69 6e
b00_bd7a:   jsr $6874                   ; 3D7A:  20 74 68
b00_bd7d:   adc $20                     ; 3D7D:  65 20
b00_bd7f:   .db $72                     ; 3D7F:  72
b00_bd80:   .db $6f                     ; 3D80:  6f
b00_bd81:   jmp ($2065)                 ; 3D81:  6c 65 20
b00_bd84:   .db $6f                     ; 3D84:  6f
b00_bd85:   ror $0a                     ; 3D85:  66 0a
b00_bd87:   brk                         ; 3D87:  00
b00_bd88:   pha                         ; 3D88:  48
b00_bd89:   adc ($73,x)                 ; 3D89:  61 73
b00_bd8b:   pla                         ; 3D8B:  68
b00_bd8c:   adc #$62                    ; 3D8C:  69 62
b00_bd8e:   adc ($20,x)                 ; 3D8E:  61 20
b00_bd90:   pha                         ; 3D90:  48
b00_bd91:   adc #$64                    ; 3D91:  69 64
b00_bd93:   adc $79                     ; 3D93:  65 79
b00_bd95:   .db $6f                     ; 3D95:  6f
b00_bd96:   .db $73                     ; 3D96:  73
b00_bd97:   pla                         ; 3D97:  68
b00_bd98:   adc #$2c                    ; 3D98:  69 2c
b00_bd9a:   asl a                       ; 3D9A:  0a
b00_bd9b:   brk                         ; 3D9B:  00
b00_bd9c:   lsr $626f                   ; 3D9C:  4e 6f 62
b00_bd9f:   adc $6e,x                   ; 3D9F:  75 6e
b00_bda1:   adc ($67,x)                 ; 3DA1:  61 67
b00_bda3:   adc ($60,x)                 ; 3DA3:  61 60
b00_bda5:   .db $73                     ; 3DA5:  73
b00_bda6:   jsr $6f6c                   ; 3DA6:  20 6c 6f
b00_bda9:   adc $6c61,y                 ; 3DA9:  79 61 6c
b00_bdac:   asl a                       ; 3DAC:  0a
b00_bdad:   .db $73                     ; 3DAD:  73
b00_bdae:   adc $62,x                   ; 3DAE:  75 62
b00_bdb0:   .db $6f                     ; 3DB0:  6f
b00_bdb1:   .db $72                     ; 3DB1:  72
b00_bdb2:   .db $64                     ; 3DB2:  64
b00_bdb3:   adc #$6e                    ; 3DB3:  69 6e
b00_bdb5:   adc ($74,x)                 ; 3DB5:  61 74
b00_bdb7:   adc $2c                     ; 3DB7:  65 2c
b00_bdb9:   jsr $6f79                   ; 3DB9:  20 79 6f
b00_bdbc:   adc $20,x                   ; 3DBC:  75 20
b00_bdbe:   adc $7961                   ; 3DBE:  6d 61 79
b00_bdc1:   asl a                       ; 3DC1:  0a
b00_bdc2:   .db $63                     ; 3DC2:  63
b00_bdc3:   .db $6f                     ; 3DC3:  6f
b00_bdc4:   ror $6974                   ; 3DC4:  6e 74 69
b00_bdc7:   ror $6575                   ; 3DC7:  6e 75 65
b00_bdca:   jsr $6f74                   ; 3DCA:  20 74 6f
b00_bdcd:   jsr $6f77                   ; 3DCD:  20 77 6f
b00_bdd0:   .db $72                     ; 3DD0:  72
b00_bdd1:   .db $6b                     ; 3DD1:  6b
b00_bdd2:   jsr $6f66                   ; 3DD2:  20 66 6f
b00_bdd5:   .db $72                     ; 3DD5:  72
b00_bdd6:   asl a                       ; 3DD6:  0a
b00_bdd7:   brk                         ; 3DD7:  00
b00_bdd8:   lsr $626f                   ; 3DD8:  4e 6f 62
b00_bddb:   adc $6e,x                   ; 3DDB:  75 6e
b00_bddd:   adc ($67,x)                 ; 3DDD:  61 67
b00_bddf:   adc ($60,x)                 ; 3DDF:  61 60
b00_bde1:   .db $73                     ; 3DE1:  73
b00_bde2:   jsr $6d61                   ; 3DE2:  20 61 6d
b00_bde5:   .db $62                     ; 3DE5:  62
b00_bde6:   adc #$74                    ; 3DE6:  69 74
b00_bde8:   adc #$6f                    ; 3DE8:  69 6f
b00_bdea:   ror $6f20                   ; 3DEA:  6e 20 6f
b00_bded:   ror $20                     ; 3DED:  66 20
b00_bdef:   adc ($0a,x)                 ; 3DEF:  61 0a
b00_bdf1:   adc $6e,x                   ; 3DF1:  75 6e
b00_bdf3:   adc #$74                    ; 3DF3:  69 74
b00_bdf5:   adc $64                     ; 3DF5:  65 64
b00_bdf7:   jsr $614a                   ; 3DF7:  20 4a 61
b00_bdfa:   bvs $be5d                   ; 3DFA:  70 61
b00_bdfc:   ror $0a00                   ; 3DFC:  6e 00 0a
b00_bdff:   .db $77                     ; 3DFF:  77
b00_be00:   adc #$6c                    ; 3E00:  69 6c
b00_be02:   jmp ($7920)                 ; 3E02:  6c 20 79
b00_be05:   .db $6f                     ; 3E05:  6f
b00_be06:   adc $20,x                   ; 3E06:  75 20
b00_be08:   adc ($6c,x)                 ; 3E08:  61 6c
b00_be0a:   jmp ($2079)                 ; 3E0A:  6c 79 20
b00_be0d:   .db $77                     ; 3E0D:  77
b00_be0e:   adc #$74                    ; 3E0E:  69 74
b00_be10:   pla                         ; 3E10:  68
b00_be11:   asl a                       ; 3E11:  0a
b00_be12:   ror $69                     ; 3E12:  66 69
b00_be14:   adc $66                     ; 3E14:  65 66
b00_be16:   jsr $3225                   ; 3E16:  20 25 32
b00_be19:   .db $64                     ; 3E19:  64
b00_be1a:   jsr $6f66                   ; 3E1A:  20 66 6f
b00_be1d:   .db $72                     ; 3E1D:  72
b00_be1e:   jsr $3425                   ; 3E1E:  20 25 34
b00_be21:   .db $64                     ; 3E21:  64
b00_be22:   asl a                       ; 3E22:  0a
b00_be23:   adc $6e,x                   ; 3E23:  75 6e
b00_be25:   adc #$74                    ; 3E25:  69 74
b00_be27:   .db $73                     ; 3E27:  73
b00_be28:   jsr $666f                   ; 3E28:  20 6f 66
b00_be2b:   jsr $6f67                   ; 3E2B:  20 67 6f
b00_be2e:   jmp ($0064)                 ; 3E2E:  6c 64 00
b00_be31:   .db $54                     ; 3E31:  54
b00_be32:   pla                         ; 3E32:  68
b00_be33:   adc #$73                    ; 3E33:  69 73
b00_be35:   jsr $6170                   ; 3E35:  20 70 61
b00_be38:   .db $63                     ; 3E38:  63
b00_be39:   .db $74                     ; 3E39:  74
b00_be3a:   jsr $6f64                   ; 3E3A:  20 64 6f
b00_be3d:   adc $73                     ; 3E3D:  65 73
b00_be3f:   ror $7460                   ; 3E3F:  6e 60 74
b00_be42:   asl a                       ; 3E42:  0a
b00_be43:   adc $6165                   ; 3E43:  6d 65 61
b00_be46:   ror $7920                   ; 3E46:  6e 20 79
b00_be49:   .db $6f                     ; 3E49:  6f
b00_be4a:   adc $20,x                   ; 3E4A:  75 20
b00_be4c:   .db $63                     ; 3E4C:  63
b00_be4d:   adc ($6e,x)                 ; 3E4D:  61 6e
b00_be4f:   asl a                       ; 3E4F:  0a
b00_be50:   .db $72                     ; 3E50:  72
b00_be51:   adc $6c                     ; 3E51:  65 6c
b00_be53:   adc ($78,x)                 ; 3E53:  61 78
b00_be55:   and ($00,x)                 ; 3E55:  21 00
b00_be57:   .db $57                     ; 3E57:  57
b00_be58:   pla                         ; 3E58:  68
b00_be59:   .db $6f                     ; 3E59:  6f
b00_be5a:   jsr $656e                   ; 3E5A:  20 6e 65
b00_be5d:   adc $64                     ; 3E5D:  65 64
b00_be5f:   .db $73                     ; 3E5F:  73
b00_be60:   jsr $6977                   ; 3E60:  20 77 69
b00_be63:   adc $7370                   ; 3E63:  6d 70 73
b00_be66:   asl a                       ; 3E66:  0a
b00_be67:   jmp ($6b69)                 ; 3E67:  6c 69 6b
b00_be6a:   adc $20                     ; 3E6A:  65 20
b00_be6c:   pla                         ; 3E6C:  68
b00_be6d:   adc #$6d                    ; 3E6D:  69 6d
b00_be6f:   jsr $6e61                   ; 3E6F:  20 61 6e
b00_be72:   adc $6177,y                 ; 3E72:  79 77 61
b00_be75:   adc $003f,y                 ; 3E75:  79 3f 00
b00_be78:   asl a                       ; 3E78:  0a
b00_be79:   .db $57                     ; 3E79:  57
b00_be7a:   adc #$6c                    ; 3E7A:  69 6c
b00_be7c:   jmp ($7920)                 ; 3E7C:  6c 20 79
b00_be7f:   .db $6f                     ; 3E7F:  6f
b00_be80:   adc $20,x                   ; 3E80:  75 20
b00_be82:   adc ($63,x)                 ; 3E82:  61 63
b00_be84:   .db $63                     ; 3E84:  63
b00_be85:   adc $70                     ; 3E85:  65 70
b00_be87:   .db $74                     ; 3E87:  74
b00_be88:   asl a                       ; 3E88:  0a
b00_be89:   and $34                     ; 3E89:  25 34
b00_be8b:   .db $64                     ; 3E8B:  64
b00_be8c:   jsr $6e75                   ; 3E8C:  20 75 6e
b00_be8f:   adc #$74                    ; 3E8F:  69 74
b00_be91:   .db $73                     ; 3E91:  73
b00_be92:   jsr $666f                   ; 3E92:  20 6f 66
b00_be95:   jsr $6f67                   ; 3E95:  20 67 6f
b00_be98:   jmp ($0a64)                 ; 3E98:  6c 64 0a
b00_be9b:   ror $72                     ; 3E9B:  66 72
b00_be9d:   .db $6f                     ; 3E9D:  6f
b00_be9e:   adc $6620                   ; 3E9E:  6d 20 66
b00_bea1:   adc #$65                    ; 3EA1:  69 65
b00_bea3:   ror $20                     ; 3EA3:  66 20
b00_bea5:   and $32                     ; 3EA5:  25 32
b00_bea7:   .db $64                     ; 3EA7:  64
b00_bea8:   jsr $6f66                   ; 3EA8:  20 66 6f
b00_beab:   .db $72                     ; 3EAB:  72
b00_beac:   asl a                       ; 3EAC:  0a
b00_bead:   .db $74                     ; 3EAD:  74
b00_beae:   pla                         ; 3EAE:  68
b00_beaf:   adc $20                     ; 3EAF:  65 20
b00_beb1:   bvs $bf25                   ; 3EB1:  70 72
b00_beb3:   adc #$6e                    ; 3EB3:  69 6e
b00_beb5:   .db $63                     ; 3EB5:  63
b00_beb6:   adc $73                     ; 3EB6:  65 73
b00_beb8:   .db $73                     ; 3EB8:  73
b00_beb9:   brk                         ; 3EB9:  00
b00_beba:   adc $756f,y                 ; 3EBA:  79 6f 75
b00_bebd:   rts                         ; 3EBD:  60
b00_bebe:   ror $65,x                   ; 3EBE:  76 65
b00_bec0:   jsr $6f6c                   ; 3EC0:  20 6c 6f
b00_bec3:   .db $73                     ; 3EC3:  73
b00_bec4:   .db $74                     ; 3EC4:  74
b00_bec5:   jsr $0a61                   ; 3EC5:  20 61 0a
b00_bec8:   .db $64                     ; 3EC8:  64
b00_bec9:   adc ($75,x)                 ; 3EC9:  61 75
b00_becb:   .db $67                     ; 3ECB:  67
b00_becc:   pla                         ; 3ECC:  68
b00_becd:   .db $74                     ; 3ECD:  74
b00_bece:   adc $72                     ; 3ECE:  65 72
b00_bed0:   jsr $7562                   ; 3ED0:  20 62 75
b00_bed3:   .db $74                     ; 3ED3:  74
b00_bed4:   asl a                       ; 3ED4:  0a
b00_bed5:   .db $67                     ; 3ED5:  67
b00_bed6:   adc ($69,x)                 ; 3ED6:  61 69
b00_bed8:   ror $6465                   ; 3ED8:  6e 65 64
b00_bedb:   jsr $0a61                   ; 3EDB:  20 61 0a
b00_bede:   .db $73                     ; 3EDE:  73
b00_bedf:   .db $6f                     ; 3EDF:  6f
b00_bee0:   ror $692d                   ; 3EE0:  6e 2d 69
b00_bee3:   ror $6c2d                   ; 3EE3:  6e 2d 6c
b00_bee6:   adc ($77,x)                 ; 3EE6:  61 77
b00_bee8:   brk                         ; 3EE8:  00
b00_bee9:   .db $54                     ; 3EE9:  54
b00_beea:   pla                         ; 3EEA:  68
b00_beeb:   adc $20                     ; 3EEB:  65 20
b00_beed:   bvs $bf61                   ; 3EED:  70 72
b00_beef:   adc #$6e                    ; 3EEF:  69 6e
b00_bef1:   .db $63                     ; 3EF1:  63
b00_bef2:   adc $73                     ; 3EF2:  65 73
b00_bef4:   .db $73                     ; 3EF4:  73
b00_bef5:   jsr $6177                   ; 3EF5:  20 77 61
b00_bef8:   .db $73                     ; 3EF8:  73
b00_bef9:   asl a                       ; 3EF9:  0a
b00_befa:   .db $74                     ; 3EFA:  74
b00_befb:   .db $6f                     ; 3EFB:  6f
b00_befc:   .db $6f                     ; 3EFC:  6f
b00_befd:   jsr $6f67                   ; 3EFD:  20 67 6f
b00_bf00:   .db $6f                     ; 3F00:  6f
b00_bf01:   .db $64                     ; 3F01:  64
b00_bf02:   jsr $6f66                   ; 3F02:  20 66 6f
b00_bf05:   .db $72                     ; 3F05:  72
b00_bf06:   jsr $6968                   ; 3F06:  20 68 69
b00_bf09:   adc $5200                   ; 3F09:  6d 00 52
b00_bf0c:   adc #$6f                    ; 3F0C:  69 6f
b00_bf0e:   .db $74                     ; 3F0E:  74
b00_bf0f:   brk                         ; 3F0F:  00
b00_bf10:   .db $52                     ; 3F10:  52
b00_bf11:   adc $76                     ; 3F11:  65 76
b00_bf13:   .db $6f                     ; 3F13:  6f
b00_bf14:   jmp ($0074)                 ; 3F14:  6c 74 00
b00_bf17:   .db $4b                     ; 3F17:  4b
b00_bf18:   .db $4f                     ; 3F18:  4f
b00_bf19:   eor $49                     ; 3F19:  45 49
b00_bf1b:   brk                         ; 3F1B:  00
b00_bf1c:   brk                         ; 3F1C:  00
b00_bf1d:   .db $44                     ; 3F1D:  44
b00_bf1e:   adc ($74,x)                 ; 3F1E:  61 74
b00_bf20:   adc ($20,x)                 ; 3F20:  61 20
b00_bf22:   pla                         ; 3F22:  68
b00_bf23:   adc ($73,x)                 ; 3F23:  61 73
b00_bf25:   jsr $6562                   ; 3F25:  20 62 65
b00_bf28:   adc $6e                     ; 3F28:  65 6e
b00_bf2a:   asl a                       ; 3F2A:  0a
b00_bf2b:   .db $73                     ; 3F2B:  73
b00_bf2c:   adc ($76,x)                 ; 3F2C:  61 76
b00_bf2e:   adc $64                     ; 3F2E:  65 64
b00_bf30:   brk                         ; 3F30:  00
b00_bf31:   jsr $6168                   ; 3F31:  20 68 61
b00_bf34:   .db $73                     ; 3F34:  73
b00_bf35:   asl a                       ; 3F35:  0a
b00_bf36:   .db $74                     ; 3F36:  74
b00_bf37:   adc ($6b,x)                 ; 3F37:  61 6b
b00_bf39:   adc $6e                     ; 3F39:  65 6e
b00_bf3b:   jsr $6c69                   ; 3F3B:  20 69 6c
b00_bf3e:   jmp ($4400)                 ; 3F3E:  6c 00 44
b00_bf41:   adc #$73                    ; 3F41:  69 73
b00_bf43:   jmp ($796f)                 ; 3F43:  6c 6f 79
b00_bf46:   adc ($6c,x)                 ; 3F46:  61 6c
b00_bf48:   jsr $7274                   ; 3F48:  20 74 72
b00_bf4b:   .db $6f                     ; 3F4B:  6f
b00_bf4c:   .db $6f                     ; 3F4C:  6f
b00_bf4d:   bvs $bfc2                   ; 3F4D:  70 73
b00_bf4f:   asl a                       ; 3F4F:  0a
b00_bf50:   pla                         ; 3F50:  68
b00_bf51:   adc ($76,x)                 ; 3F51:  61 76
b00_bf53:   adc $20                     ; 3F53:  65 20
b00_bf55:   .db $72                     ; 3F55:  72
b00_bf56:   adc $76                     ; 3F56:  65 76
b00_bf58:   .db $6f                     ; 3F58:  6f
b00_bf59:   jmp ($6574)                 ; 3F59:  6c 74 65
b00_bf5c:   .db $64                     ; 3F5C:  64
b00_bf5d:   brk                         ; 3F5D:  00
b00_bf5e:   .db $ff                     ; 3F5E:  ff
b00_bf5f:   .db $ff                     ; 3F5F:  ff
b00_bf60:   .db $ff                     ; 3F60:  ff
b00_bf61:   .db $ff                     ; 3F61:  ff
b00_bf62:   .db $ff                     ; 3F62:  ff
b00_bf63:   .db $ff                     ; 3F63:  ff
b00_bf64:   .db $ff                     ; 3F64:  ff
b00_bf65:   .db $ff                     ; 3F65:  ff
b00_bf66:   .db $ff                     ; 3F66:  ff
b00_bf67:   .db $ff                     ; 3F67:  ff
b00_bf68:   .db $ff                     ; 3F68:  ff
b00_bf69:   .db $ff                     ; 3F69:  ff
b00_bf6a:   .db $ff                     ; 3F6A:  ff
b00_bf6b:   .db $ff                     ; 3F6B:  ff
b00_bf6c:   .db $ff                     ; 3F6C:  ff
b00_bf6d:   .db $ff                     ; 3F6D:  ff
b00_bf6e:   .db $ff                     ; 3F6E:  ff
b00_bf6f:   .db $ff                     ; 3F6F:  ff
b00_bf70:   .db $ff                     ; 3F70:  ff
b00_bf71:   .db $ff                     ; 3F71:  ff
b00_bf72:   .db $ff                     ; 3F72:  ff
b00_bf73:   .db $ff                     ; 3F73:  ff
b00_bf74:   .db $ff                     ; 3F74:  ff
b00_bf75:   .db $ff                     ; 3F75:  ff
b00_bf76:   .db $ff                     ; 3F76:  ff
b00_bf77:   .db $ff                     ; 3F77:  ff
b00_bf78:   .db $ff                     ; 3F78:  ff
b00_bf79:   .db $ff                     ; 3F79:  ff
b00_bf7a:   .db $ff                     ; 3F7A:  ff
b00_bf7b:   .db $ff                     ; 3F7B:  ff
b00_bf7c:   .db $ff                     ; 3F7C:  ff
b00_bf7d:   .db $ff                     ; 3F7D:  ff
b00_bf7e:   .db $ff                     ; 3F7E:  ff
b00_bf7f:   .db $ff                     ; 3F7F:  ff
b00_bf80:   .db $ff                     ; 3F80:  ff
b00_bf81:   .db $ff                     ; 3F81:  ff
b00_bf82:   .db $ff                     ; 3F82:  ff
b00_bf83:   .db $ff                     ; 3F83:  ff
b00_bf84:   .db $ff                     ; 3F84:  ff
b00_bf85:   .db $ff                     ; 3F85:  ff
b00_bf86:   .db $ff                     ; 3F86:  ff
b00_bf87:   .db $ff                     ; 3F87:  ff
b00_bf88:   .db $ff                     ; 3F88:  ff
b00_bf89:   .db $ff                     ; 3F89:  ff
b00_bf8a:   .db $ff                     ; 3F8A:  ff
b00_bf8b:   .db $ff                     ; 3F8B:  ff
b00_bf8c:   .db $ff                     ; 3F8C:  ff
b00_bf8d:   .db $ff                     ; 3F8D:  ff
b00_bf8e:   .db $ff                     ; 3F8E:  ff
b00_bf8f:   .db $ff                     ; 3F8F:  ff
b00_bf90:   .db $ff                     ; 3F90:  ff
b00_bf91:   .db $ff                     ; 3F91:  ff
b00_bf92:   .db $ff                     ; 3F92:  ff
b00_bf93:   .db $ff                     ; 3F93:  ff
b00_bf94:   .db $ff                     ; 3F94:  ff
b00_bf95:   .db $ff                     ; 3F95:  ff
b00_bf96:   .db $ff                     ; 3F96:  ff
b00_bf97:   .db $ff                     ; 3F97:  ff
b00_bf98:   .db $ff                     ; 3F98:  ff
b00_bf99:   .db $ff                     ; 3F99:  ff
b00_bf9a:   .db $ff                     ; 3F9A:  ff
b00_bf9b:   .db $ff                     ; 3F9B:  ff
b00_bf9c:   .db $ff                     ; 3F9C:  ff
b00_bf9d:   .db $ff                     ; 3F9D:  ff
b00_bf9e:   .db $ff                     ; 3F9E:  ff
b00_bf9f:   .db $ff                     ; 3F9F:  ff
b00_bfa0:   .db $ff                     ; 3FA0:  ff
b00_bfa1:   .db $ff                     ; 3FA1:  ff
b00_bfa2:   .db $ff                     ; 3FA2:  ff
b00_bfa3:   .db $ff                     ; 3FA3:  ff
b00_bfa4:   .db $ff                     ; 3FA4:  ff
b00_bfa5:   .db $ff                     ; 3FA5:  ff
b00_bfa6:   .db $ff                     ; 3FA6:  ff
b00_bfa7:   .db $ff                     ; 3FA7:  ff
b00_bfa8:   .db $ff                     ; 3FA8:  ff
b00_bfa9:   .db $ff                     ; 3FA9:  ff
b00_bfaa:   .db $ff                     ; 3FAA:  ff
b00_bfab:   .db $ff                     ; 3FAB:  ff
b00_bfac:   .db $ff                     ; 3FAC:  ff
b00_bfad:   .db $ff                     ; 3FAD:  ff
b00_bfae:   .db $ff                     ; 3FAE:  ff
b00_bfaf:   .db $ff                     ; 3FAF:  ff
b00_bfb0:   .db $ff                     ; 3FB0:  ff
b00_bfb1:   .db $ff                     ; 3FB1:  ff
b00_bfb2:   .db $ff                     ; 3FB2:  ff
b00_bfb3:   .db $ff                     ; 3FB3:  ff
b00_bfb4:   .db $ff                     ; 3FB4:  ff
b00_bfb5:   .db $ff                     ; 3FB5:  ff
b00_bfb6:   .db $ff                     ; 3FB6:  ff
b00_bfb7:   .db $ff                     ; 3FB7:  ff
b00_bfb8:   .db $ff                     ; 3FB8:  ff
b00_bfb9:   .db $ff                     ; 3FB9:  ff
b00_bfba:   .db $ff                     ; 3FBA:  ff
b00_bfbb:   .db $ff                     ; 3FBB:  ff
b00_bfbc:   .db $ff                     ; 3FBC:  ff
b00_bfbd:   .db $ff                     ; 3FBD:  ff
b00_bfbe:   .db $ff                     ; 3FBE:  ff
b00_bfbf:   .db $ff                     ; 3FBF:  ff
b00_bfc0:   .db $ff                     ; 3FC0:  ff
b00_bfc1:   .db $ff                     ; 3FC1:  ff
b00_bfc2:   .db $ff                     ; 3FC2:  ff
b00_bfc3:   .db $ff                     ; 3FC3:  ff
b00_bfc4:   .db $ff                     ; 3FC4:  ff
b00_bfc5:   .db $ff                     ; 3FC5:  ff
b00_bfc6:   .db $ff                     ; 3FC6:  ff
b00_bfc7:   .db $ff                     ; 3FC7:  ff
b00_bfc8:   .db $ff                     ; 3FC8:  ff
b00_bfc9:   .db $ff                     ; 3FC9:  ff
b00_bfca:   .db $ff                     ; 3FCA:  ff
b00_bfcb:   .db $ff                     ; 3FCB:  ff
b00_bfcc:   .db $ff                     ; 3FCC:  ff
b00_bfcd:   .db $ff                     ; 3FCD:  ff
b00_bfce:   .db $ff                     ; 3FCE:  ff
b00_bfcf:   .db $ff                     ; 3FCF:  ff
b00_bfd0:   .db $ff                     ; 3FD0:  ff
b00_bfd1:   .db $ff                     ; 3FD1:  ff
b00_bfd2:   .db $ff                     ; 3FD2:  ff
b00_bfd3:   .db $ff                     ; 3FD3:  ff
b00_bfd4:   .db $ff                     ; 3FD4:  ff
b00_bfd5:   .db $ff                     ; 3FD5:  ff
b00_bfd6:   .db $ff                     ; 3FD6:  ff
b00_bfd7:   .db $ff                     ; 3FD7:  ff
b00_bfd8:   .db $ff                     ; 3FD8:  ff
b00_bfd9:   .db $ff                     ; 3FD9:  ff
b00_bfda:   .db $ff                     ; 3FDA:  ff
b00_bfdb:   .db $ff                     ; 3FDB:  ff
b00_bfdc:   .db $ff                     ; 3FDC:  ff
b00_bfdd:   .db $ff                     ; 3FDD:  ff
b00_bfde:   .db $ff                     ; 3FDE:  ff
b00_bfdf:   .db $ff                     ; 3FDF:  ff
b00_bfe0:   .db $ff                     ; 3FE0:  ff
b00_bfe1:   .db $ff                     ; 3FE1:  ff
b00_bfe2:   .db $ff                     ; 3FE2:  ff
b00_bfe3:   .db $ff                     ; 3FE3:  ff
b00_bfe4:   .db $ff                     ; 3FE4:  ff
b00_bfe5:   .db $ff                     ; 3FE5:  ff
b00_bfe6:   .db $ff                     ; 3FE6:  ff
b00_bfe7:   .db $ff                     ; 3FE7:  ff
b00_bfe8:   .db $ff                     ; 3FE8:  ff
b00_bfe9:   .db $ff                     ; 3FE9:  ff
b00_bfea:   .db $ff                     ; 3FEA:  ff
b00_bfeb:   .db $ff                     ; 3FEB:  ff
b00_bfec:   .db $ff                     ; 3FEC:  ff
b00_bfed:   .db $ff                     ; 3FED:  ff
b00_bfee:   .db $ff                     ; 3FEE:  ff
b00_bfef:   .db $ff                     ; 3FEF:  ff
b00_bff0:   .db $ff                     ; 3FF0:  ff
b00_bff1:   .db $ff                     ; 3FF1:  ff
b00_bff2:   .db $ff                     ; 3FF2:  ff
b00_bff3:   .db $ff                     ; 3FF3:  ff
b00_bff4:   .db $ff                     ; 3FF4:  ff
b00_bff5:   .db $ff                     ; 3FF5:  ff
b00_bff6:   .db $ff                     ; 3FF6:  ff
b00_bff7:   .db $ff                     ; 3FF7:  ff
b00_bff8:   .db $ff                     ; 3FF8:  ff
b00_bff9:   .db $ff                     ; 3FF9:  ff
b00_bffa:   .db $ff                     ; 3FFA:  ff
b00_bffb:   .db $ff                     ; 3FFB:  ff
b00_bffc:   .db $ff                     ; 3FFC:  ff
b00_bffd:   .db $ff                     ; 3FFD:  ff
b00_bffe:   .db $ff                     ; 3FFE:  ff
b00_bfff:   .db $ff                     ; 3FFF:  ff
