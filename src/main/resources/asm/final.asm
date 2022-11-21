include number.asm
include macros2.asm
include macros.asm
.MODEL LARGE
.386
.STACK 200h
.DATA
variable1                      dd ?                                       
p1                             db 30 dup(?), '$'                          
p2                             db 30 dup(?), '$'                          
p3                             db 30 dup(?), '$'                          
g                              dd ?                                       
h                              db 30 dup(?), '$'                          
a                              dd ?                                       
b                              dd ?                                       
c                              dd ?
w                              dd ?                                       
d                              dd ?                                       
e                              dd ?                                       
f                              dd ?                                       
i                              dd ?                                       
var1                           dd ?                                       
_1                             dd 1.0                                     
_2                             dd 2.0                                     
_0                             dd 0.0                                     
_10                            dd 10.0                                    
_5                             dd 5.0                                     
_6                             dd 6.0                                     
_@2035112768                   db 'El if-else con < anda bien$',0         
_@617669072                    db 'El if-else con < anda mal$',0          
_@539308525                    db 'El if-else con > anda mal$',0          
_@555868801                    db 'El if-else con > anda bien$',0         
_@1572353411                   db 'El if-else con && anda bien$',0        
_@1696433187                   db 'El if-else con && anda mal$',0         
_@385616127                    db 'El while anda bien$',0                 
_@636796678                    db 'El while anda mal$',0                  
_@3838227055                   db 'El do-case anda mal$',0                
_@575922958                    db 'El do-case anda bien$',0               
_@3395461228                   db 'El do-case-default anda mal$',0        
_3                             dd 3.0                                     
_@3144947366                   db 'El do-case-default anda bien$',0       
_@3524401087                   db 'El do-case-default con case true bien$',0
_@2862696447                   db 'El do-case-default con case true mal$',0
_@2255339023                   db 'Ingrese el valor 3.0$',0               
_3_0                           dd 3.0                                     
_@1114453748                   db 'Read anda bien$',0                     
_@4024934293                   db 'El read anda mal$',0                   
_@3730290725                   db 'El #Iguales anda bien$',0              
_@928319560                    db 'El #Iguales NO anda bien$',0           
_@2948132247                   db 'Muchos AND andan bien$',0              
_@130408048                    db 'Muchos AND andan mal$',0               
_120                           dd 120.0                                   
_100                           dd 100.0                                   
_30                            dd 30.0                                    
_@4053823596                   db 'Muchos OR andan bien$',0               
_@3248565000                   db 'Muchos OR andan mal$',0                
_@3043032677                   db 'Muchos AND con ORS andan bien$',0      
_@84037988                     db 'Muchos AND con ORS andan mal$',0       
_@866142330                    db 'Not en if anda ok$',0                  
_@3458920603                   db 'Whiles anidados andan bien$',0         
_@4263969198                   db 'Whiles anidados andan mal$',0          
_@3890098392                   db 'Ifs anidados andan bien$',0            
_@162459165                    db 'Existen errores$',0                    
@Aux0                          dd ?                                       
@Aux2                          dd ?                                       
@Aux4                          dd ?                                       
@Aux6                          dd ?                                       
@Aux8                          dd ?                                       
@Aux15                         dd ?                                       
@Aux16                         dd ?                                       
@Aux19                         dd ?                                       
@Aux33                         db 30 dup(?), '$'                          
@Aux31                         db 30 dup(?), '$'                          
@Aux37                         db 30 dup(?), '$'                          
@Aux35                         db 30 dup(?), '$'                          
@Aux38                         dd ?                                       
@Aux48                         db 30 dup(?), '$'                          
@Aux46                         db 30 dup(?), '$'                          
@Aux49                         dd ?                                       
@Aux54                         db 30 dup(?), '$'                          
@Aux52                         db 30 dup(?), '$'                          
@Aux74                         db 30 dup(?), '$'                          
@Aux72                         db 30 dup(?), '$'                          
@Aux78                         db 30 dup(?), '$'                          
@Aux76                         db 30 dup(?), '$'                          
@Aux79                         dd ?                                       
@Aux87                         dd ?                                       
@Aux88                         dd ?                                       
@Aux90                         dd ?                                       
@Aux101                        db 30 dup(?), '$'                          
@Aux99                         db 30 dup(?), '$'                          
@Aux105                        db 30 dup(?), '$'                          
@Aux103                        db 30 dup(?), '$'                          
@Aux106                        dd ?                                       
@Aux114                        db 30 dup(?), '$'                          
@Aux112                        db 30 dup(?), '$'                          
@Aux115                        dd ?                                       
@Aux124                        db 30 dup(?), '$'                          
@Aux122                        db 30 dup(?), '$'                          
@Aux132                        db 30 dup(?), '$'                          
@Aux130                        db 30 dup(?), '$'                          
@Aux133                        dd ?                                       
@Aux142                        db 30 dup(?), '$'                          
@Aux140                        db 30 dup(?), '$'                          
@Aux143                        dd ?                                       
@Aux148                        db 30 dup(?), '$'                          
@Aux146                        db 30 dup(?), '$'                          
@Aux155                        db 30 dup(?), '$'                          
@Aux153                        db 30 dup(?), '$'                          
@Aux163                        db 30 dup(?), '$'                          
@Aux161                        db 30 dup(?), '$'                          
@Aux164                        dd ?                                       
@Aux169                        db 30 dup(?), '$'                          
@Aux167                        db 30 dup(?), '$'                          
@Aux170                        dd ?                                       
@Aux174                        db 30 dup(?), '$'                          
@Aux172                        db 30 dup(?), '$'                          
@Aux184                        db 30 dup(?), '$'                          
@Aux182                        db 30 dup(?), '$'                          
@Aux188                        db 30 dup(?), '$'                          
@Aux186                        db 30 dup(?), '$'                          
@Aux189                        dd ?                                       
@Aux191                        dd ?                                       
@Aux193                        dd ?                                       
@Aux195                        dd ?                                       
@Aux197                        dd ?                                       
@Aux199                        dd ?                                       
@Aux201                        dd ?                                       
@Aux202                        dd ?                                       
@Aux204                        dd ?                                       
@Aux205                        dd ?                                       
@Aux209                        dd ?                                       
@Aux213                        dd ?                                       
@Aux217                        dd ?                                       
@Aux227                        db 30 dup(?), '$'                          
@Aux225                        db 30 dup(?), '$'                          
@Aux231                        db 30 dup(?), '$'                          
@Aux229                        db 30 dup(?), '$'                          
@Aux232                        dd ?                                       
@Aux234                        dd ?                                       
@Aux288                        db 30 dup(?), '$'                          
@Aux286                        db 30 dup(?), '$'                          
@Aux292                        db 30 dup(?), '$'                          
@Aux290                        db 30 dup(?), '$'                          
@Aux293                        dd ?                                       
@Aux347                        db 30 dup(?), '$'                          
@Aux345                        db 30 dup(?), '$'                          
@Aux351                        db 30 dup(?), '$'                          
@Aux349                        db 30 dup(?), '$'                          
@Aux352                        dd ?                                       
@Aux406                        db 30 dup(?), '$'                          
@Aux404                        db 30 dup(?), '$'                          
@Aux410                        db 30 dup(?), '$'                          
@Aux408                        db 30 dup(?), '$'                          
@Aux411                        dd ?                                       
@Aux426                        db 30 dup(?), '$'                          
@Aux424                        db 30 dup(?), '$'                          
@Aux427                        dd ?                                       
@Aux429                        dd ?                                       
@Aux443                        dd ?                                       
@Aux444                        dd ?                                       
@Aux446                        dd ?                                       
@Aux449                        dd ?                                       
@Aux450                        dd ?                                       
@Aux452                        dd ?                                       
@Aux474                        db 30 dup(?), '$'                          
@Aux472                        db 30 dup(?), '$'                          
@Aux478                        db 30 dup(?), '$'                          
@Aux476                        db 30 dup(?), '$'                          
@Aux479                        dd ?                                       
@Aux481                        dd ?                                       
@Aux483                        dd ?                                       
@Aux485                        dd ?                                       
@Aux487                        dd ?                                       
@Aux515                        db 30 dup(?), '$'                          
@Aux513                        db 30 dup(?), '$'                          
@Aux524                        db 30 dup(?), '$'                          
@Aux522                        db 30 dup(?), '$'                          
@BoolAux                       dd ?                                       
@BoolAuxTemp                   dd ?                                       
@aux                           dd ?                                       
@Cont                          dd ?                                       
.CODE
START:
MOV ax,@DATA
MOV ds,ax
MOV es,ax
MOV eax, _1
MOV @Aux0, eax
MOV eax, @Aux0
MOV a, eax
MOV eax, _2
MOV @Aux2, eax
MOV eax, @Aux2
MOV b, eax
MOV eax, _0
MOV @Aux4, eax
MOV eax, @Aux4
MOV c, eax
MOV eax, _10
MOV @Aux6, eax
MOV eax, @Aux6
MOV i, eax
MOV eax, _0
MOV @Aux8, eax
MOV eax, @Aux8
MOV variable1, eax
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP b
FSTSW ax
SAHF
JAE tag_aux14
MOV eax, _1
MOV @BoolAux, eax
tag_aux14:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _5
MOV @Aux15, eax
MOV eax, _6
MOV @Aux16, eax
FLD @Aux15
FLD @Aux16
FADD
FSTP @Aux15
MOV eax, _0
MOV @BoolAux, eax
MOV eax, @Aux15
MOV @Aux19, eax
FLD _2
FCOMP @Aux19
FSTSW ax
SAHF
JAE tag_aux23
MOV eax, _1
MOV @BoolAux, eax
tag_aux23:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux28
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux28
JMP tag_aux29
tag_aux28:
MOV eax, _0
MOV @BoolAux, eax
tag_aux29:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux35
MOV SI, OFFSET _@2035112768
MOV DI, OFFSET @Aux31
STRCPY
displayString @Aux31
newLine 1
MOV SI, OFFSET @Aux31
MOV DI, OFFSET @Aux33
STRCPY
JMP tag_aux40
tag_aux35:
MOV SI, OFFSET _@617669072
MOV DI, OFFSET @Aux35
STRCPY
displayString @Aux35
newLine 1
MOV SI, OFFSET @Aux35
MOV DI, OFFSET @Aux37
STRCPY
MOV eax, _1
MOV @Aux38, eax
MOV eax, @Aux38
MOV variable1, eax
tag_aux40:
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP b
FSTSW ax
SAHF
JNA tag_aux44
MOV eax, _1
MOV @BoolAux, eax
tag_aux44:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux52
MOV SI, OFFSET _@539308525
MOV DI, OFFSET @Aux46
STRCPY
displayString @Aux46
newLine 1
MOV SI, OFFSET @Aux46
MOV DI, OFFSET @Aux48
STRCPY
MOV eax, _1
MOV @Aux49, eax
MOV eax, @Aux49
MOV variable1, eax
JMP tag_aux55
tag_aux52:
MOV SI, OFFSET _@555868801
MOV DI, OFFSET @Aux52
STRCPY
displayString @Aux52
newLine 1
MOV SI, OFFSET @Aux52
MOV DI, OFFSET @Aux54
STRCPY
tag_aux55:
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP b
FSTSW ax
SAHF
JAE tag_aux59
MOV eax, _1
MOV @BoolAux, eax
tag_aux59:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD c
FCOMP _0
FSTSW ax
SAHF
JNE tag_aux64
MOV eax, _1
MOV @BoolAux, eax
tag_aux64:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux69
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux69
JMP tag_aux70
tag_aux69:
MOV eax, _0
MOV @BoolAux, eax
tag_aux70:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux76
MOV SI, OFFSET _@1572353411
MOV DI, OFFSET @Aux72
STRCPY
displayString @Aux72
newLine 1
MOV SI, OFFSET @Aux72
MOV DI, OFFSET @Aux74
STRCPY
JMP tag_aux81
tag_aux76:
MOV SI, OFFSET _@1696433187
MOV DI, OFFSET @Aux76
STRCPY
displayString @Aux76
newLine 1
MOV SI, OFFSET @Aux76
MOV DI, OFFSET @Aux78
STRCPY
MOV eax, _1
MOV @Aux79, eax
MOV eax, @Aux79
MOV variable1, eax
tag_aux81:
MOV eax, _0
MOV @BoolAux, eax
FLD i
FCOMP _0
FSTSW ax
SAHF
JNA tag_aux85
MOV eax, _1
MOV @BoolAux, eax
tag_aux85:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux93
MOV eax, i
MOV @Aux87, eax
MOV eax, _1
MOV @Aux88, eax
FLD @Aux87
FLD @Aux88
FSUB
FSTP @Aux87
MOV eax, @Aux87
MOV @Aux90, eax
MOV eax, @Aux90
MOV i, eax
JMP tag_aux81
tag_aux93:
MOV eax, _0
MOV @BoolAux, eax
FLD i
FCOMP _0
FSTSW ax
SAHF
JNE tag_aux97
MOV eax, _1
MOV @BoolAux, eax
tag_aux97:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux103
MOV SI, OFFSET _@385616127
MOV DI, OFFSET @Aux99
STRCPY
displayString @Aux99
newLine 1
MOV SI, OFFSET @Aux99
MOV DI, OFFSET @Aux101
STRCPY
JMP tag_aux108
tag_aux103:
MOV SI, OFFSET _@636796678
MOV DI, OFFSET @Aux103
STRCPY
displayString @Aux103
newLine 1
MOV SI, OFFSET @Aux103
MOV DI, OFFSET @Aux105
STRCPY
MOV eax, _1
MOV @Aux106, eax
MOV eax, @Aux106
MOV variable1, eax
tag_aux108:
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP _2
FSTSW ax
SAHF
JNE tag_aux118
MOV eax, _1
MOV @BoolAux, eax
MOV SI, OFFSET _@3838227055
MOV DI, OFFSET @Aux112
STRCPY
displayString @Aux112
newLine 1
MOV SI, OFFSET @Aux112
MOV DI, OFFSET @Aux114
STRCPY
MOV eax, _1
MOV @Aux115, eax
MOV eax, @Aux115
MOV variable1, eax
JMP tag_aux126
tag_aux118:
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux126
MOV eax, _1
MOV @BoolAux, eax
MOV SI, OFFSET _@575922958
MOV DI, OFFSET @Aux122
STRCPY
displayString @Aux122
newLine 1
MOV SI, OFFSET @Aux122
MOV DI, OFFSET @Aux124
STRCPY
JMP tag_aux126
tag_aux126:
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP _2
FSTSW ax
SAHF
JNE tag_aux136
MOV eax, _1
MOV @BoolAux, eax
MOV SI, OFFSET _@3395461228
MOV DI, OFFSET @Aux130
STRCPY
displayString @Aux130
newLine 1
MOV SI, OFFSET @Aux130
MOV DI, OFFSET @Aux132
STRCPY
MOV eax, _1
MOV @Aux133, eax
MOV eax, @Aux133
MOV variable1, eax
JMP tag_aux149
tag_aux136:
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP _3
FSTSW ax
SAHF
JNE tag_aux146
MOV eax, _1
MOV @BoolAux, eax
MOV SI, OFFSET _@3395461228
MOV DI, OFFSET @Aux140
STRCPY
displayString @Aux140
newLine 1
MOV SI, OFFSET @Aux140
MOV DI, OFFSET @Aux142
STRCPY
MOV eax, _1
MOV @Aux143, eax
MOV eax, @Aux143
MOV variable1, eax
JMP tag_aux149
tag_aux146:
MOV SI, OFFSET _@3144947366
MOV DI, OFFSET @Aux146
STRCPY
displayString @Aux146
newLine 1
MOV SI, OFFSET @Aux146
MOV DI, OFFSET @Aux148
STRCPY
tag_aux149:
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux157
MOV eax, _1
MOV @BoolAux, eax
MOV SI, OFFSET _@3524401087
MOV DI, OFFSET @Aux153
STRCPY
displayString @Aux153
newLine 1
MOV SI, OFFSET @Aux153
MOV DI, OFFSET @Aux155
STRCPY
JMP tag_aux172
tag_aux157:
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP _2
FSTSW ax
SAHF
JNE tag_aux167
MOV eax, _1
MOV @BoolAux, eax
MOV SI, OFFSET _@2862696447
MOV DI, OFFSET @Aux161
STRCPY
displayString @Aux161
newLine 1
MOV SI, OFFSET @Aux161
MOV DI, OFFSET @Aux163
STRCPY
MOV eax, _1
MOV @Aux164, eax
MOV eax, @Aux164
MOV variable1, eax
JMP tag_aux172
tag_aux167:
MOV SI, OFFSET _@2862696447
MOV DI, OFFSET @Aux167
STRCPY
displayString @Aux167
newLine 1
MOV SI, OFFSET @Aux167
MOV DI, OFFSET @Aux169
STRCPY
MOV eax, _1
MOV @Aux170, eax
MOV eax, @Aux170
MOV variable1, eax
tag_aux172:
MOV SI, OFFSET _@2255339023
MOV DI, OFFSET @Aux172
STRCPY
displayString @Aux172
newLine 1
MOV SI, OFFSET @Aux172
MOV DI, OFFSET @Aux174
STRCPY
GetFloat g
MOV eax, _0
MOV @BoolAux, eax
FLD g
FCOMP _3_0
FSTSW ax
SAHF
JNE tag_aux180
MOV eax, _1
MOV @BoolAux, eax
tag_aux180:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux186
MOV SI, OFFSET _@1114453748
MOV DI, OFFSET @Aux182
STRCPY
displayString @Aux182
newLine 1
MOV SI, OFFSET @Aux182
MOV DI, OFFSET @Aux184
STRCPY
JMP tag_aux191
tag_aux186:
MOV SI, OFFSET _@4024934293
MOV DI, OFFSET @Aux186
STRCPY
displayString @Aux186
newLine 1
MOV SI, OFFSET @Aux186
MOV DI, OFFSET @Aux188
STRCPY
MOV eax, _1
MOV @Aux189, eax
MOV eax, @Aux189
MOV variable1, eax
tag_aux191:
MOV eax, _0
MOV @Aux191, eax
MOV eax, @Aux191
MOV a, eax
MOV eax, _0
MOV @Aux193, eax
MOV eax, @Aux193
MOV e, eax
MOV eax, _0
MOV @Aux195, eax
MOV eax, @Aux195
MOV f, eax
MOV eax, _1
MOV @Aux197, eax
MOV eax, @Aux197
MOV i, eax
MOV eax, a
MOV @Aux199, eax
MOV eax, @Aux199
MOV @aux, eax
MOV eax, i
MOV @Aux201, eax
MOV eax, _1
MOV @Aux202, eax
FLD @Aux201
FLD @Aux202
FSUB
FSTP @Aux201
MOV eax, @aux
MOV @Aux204, eax
MOV eax, @Aux201
MOV @Aux205, eax
FLD @Aux204
FCOMP @Aux205
FSTSW ax
SAHF
JNE tag_aux209
FLD @Cont
FLD _1
FADD
FSTP @Cont
tag_aux209:
MOV eax, @aux
MOV @Aux209, eax
FLD @Aux209
FCOMP e
FSTSW ax
SAHF
JNE tag_aux213
FLD @Cont
FLD _1
FADD
FSTP @Cont
tag_aux213:
MOV eax, @aux
MOV @Aux213, eax
FLD @Aux213
FCOMP f
FSTSW ax
SAHF
JNE tag_aux217
FLD @Cont
FLD _1
FADD
FSTP @Cont
tag_aux217:
MOV eax, @Cont
MOV @Aux217, eax
MOV eax, @Aux217
MOV a, eax
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP _3
FSTSW ax
SAHF
JNE tag_aux223
MOV eax, _1
MOV @BoolAux, eax
tag_aux223:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux229
MOV SI, OFFSET _@3730290725
MOV DI, OFFSET @Aux225
STRCPY
displayString @Aux225
newLine 1
MOV SI, OFFSET @Aux225
MOV DI, OFFSET @Aux227
STRCPY
JMP tag_aux232
tag_aux229:
MOV SI, OFFSET _@928319560
MOV DI, OFFSET @Aux229
STRCPY
displayString @Aux229
newLine 1
MOV SI, OFFSET @Aux229
MOV DI, OFFSET @Aux231
STRCPY
tag_aux232:
MOV eax, _0
MOV @Aux232, eax
MOV eax, @Aux232
MOV w, eax
MOV eax, _3
MOV @Aux234, eax
MOV eax, @Aux234
MOV a, eax
MOV eax, _0
MOV @BoolAux, eax
FLD e
FCOMP _0
FSTSW ax
SAHF
JNE tag_aux240
MOV eax, _1
MOV @BoolAux, eax
tag_aux240:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD f
FCOMP _0
FSTSW ax
SAHF
JNE tag_aux245
MOV eax, _1
MOV @BoolAux, eax
tag_aux245:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux250
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux250
JMP tag_aux251
tag_aux250:
MOV eax, _0
MOV @BoolAux, eax
tag_aux251:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD i
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux256
MOV eax, _1
MOV @BoolAux, eax
tag_aux256:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux261
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux261
JMP tag_aux262
tag_aux261:
MOV eax, _0
MOV @BoolAux, eax
tag_aux262:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP _3
FSTSW ax
SAHF
JNE tag_aux267
MOV eax, _1
MOV @BoolAux, eax
tag_aux267:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux272
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux272
JMP tag_aux273
tag_aux272:
MOV eax, _0
MOV @BoolAux, eax
tag_aux273:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD w
FCOMP _0
FSTSW ax
SAHF
JNE tag_aux278
MOV eax, _1
MOV @BoolAux, eax
tag_aux278:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux283
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux283
JMP tag_aux284
tag_aux283:
MOV eax, _0
MOV @BoolAux, eax
tag_aux284:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux290
MOV SI, OFFSET _@2948132247
MOV DI, OFFSET @Aux286
STRCPY
displayString @Aux286
newLine 1
MOV SI, OFFSET @Aux286
MOV DI, OFFSET @Aux288
STRCPY
JMP tag_aux295
tag_aux290:
MOV SI, OFFSET _@130408048
MOV DI, OFFSET @Aux290
STRCPY
displayString @Aux290
newLine 1
MOV SI, OFFSET @Aux290
MOV DI, OFFSET @Aux292
STRCPY
MOV eax, _1
MOV @Aux293, eax
MOV eax, @Aux293
MOV variable1, eax
tag_aux295:
MOV eax, _0
MOV @BoolAux, eax
FLD e
FCOMP _120
FSTSW ax
SAHF
JNE tag_aux299
MOV eax, _1
MOV @BoolAux, eax
tag_aux299:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD f
FCOMP _120
FSTSW ax
SAHF
JNE tag_aux304
MOV eax, _1
MOV @BoolAux, eax
tag_aux304:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux307
JMP tag_aux309
tag_aux307:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux310
tag_aux309:
MOV eax, _1
MOV @BoolAux, eax
tag_aux310:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD i
FCOMP _100
FSTSW ax
SAHF
JNE tag_aux315
MOV eax, _1
MOV @BoolAux, eax
tag_aux315:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux318
JMP tag_aux320
tag_aux318:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux321
tag_aux320:
MOV eax, _1
MOV @BoolAux, eax
tag_aux321:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP _30
FSTSW ax
SAHF
JNE tag_aux326
MOV eax, _1
MOV @BoolAux, eax
tag_aux326:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux329
JMP tag_aux331
tag_aux329:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux332
tag_aux331:
MOV eax, _1
MOV @BoolAux, eax
tag_aux332:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD w
FCOMP _0
FSTSW ax
SAHF
JNE tag_aux337
MOV eax, _1
MOV @BoolAux, eax
tag_aux337:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux340
JMP tag_aux342
tag_aux340:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux343
tag_aux342:
MOV eax, _1
MOV @BoolAux, eax
tag_aux343:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux349
MOV SI, OFFSET _@4053823596
MOV DI, OFFSET @Aux345
STRCPY
displayString @Aux345
newLine 1
MOV SI, OFFSET @Aux345
MOV DI, OFFSET @Aux347
STRCPY
JMP tag_aux354
tag_aux349:
MOV SI, OFFSET _@3248565000
MOV DI, OFFSET @Aux349
STRCPY
displayString @Aux349
newLine 1
MOV SI, OFFSET @Aux349
MOV DI, OFFSET @Aux351
STRCPY
MOV eax, _1
MOV @Aux352, eax
MOV eax, @Aux352
MOV variable1, eax
tag_aux354:
MOV eax, _0
MOV @BoolAux, eax
FLD e
FCOMP _120
FSTSW ax
SAHF
JNE tag_aux358
MOV eax, _1
MOV @BoolAux, eax
tag_aux358:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD f
FCOMP _10
FSTSW ax
SAHF
JNE tag_aux363
MOV eax, _1
MOV @BoolAux, eax
tag_aux363:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux366
JMP tag_aux368
tag_aux366:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux369
tag_aux368:
MOV eax, _1
MOV @BoolAux, eax
tag_aux369:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD i
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux374
MOV eax, _1
MOV @BoolAux, eax
tag_aux374:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux377
JMP tag_aux379
tag_aux377:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux380
tag_aux379:
MOV eax, _1
MOV @BoolAux, eax
tag_aux380:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP _3
FSTSW ax
SAHF
JNE tag_aux385
MOV eax, _1
MOV @BoolAux, eax
tag_aux385:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux390
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux390
JMP tag_aux391
tag_aux390:
MOV eax, _0
MOV @BoolAux, eax
tag_aux391:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD w
FCOMP _0
FSTSW ax
SAHF
JNE tag_aux396
MOV eax, _1
MOV @BoolAux, eax
tag_aux396:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux401
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux401
JMP tag_aux402
tag_aux401:
MOV eax, _0
MOV @BoolAux, eax
tag_aux402:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux408
MOV SI, OFFSET _@3043032677
MOV DI, OFFSET @Aux404
STRCPY
displayString @Aux404
newLine 1
MOV SI, OFFSET @Aux404
MOV DI, OFFSET @Aux406
STRCPY
JMP tag_aux413
tag_aux408:
MOV SI, OFFSET _@84037988
MOV DI, OFFSET @Aux408
STRCPY
displayString @Aux408
newLine 1
MOV SI, OFFSET @Aux408
MOV DI, OFFSET @Aux410
STRCPY
MOV eax, _1
MOV @Aux411, eax
MOV eax, @Aux411
MOV variable1, eax
tag_aux413:
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP b
FSTSW ax
SAHF
JAE tag_aux417
MOV eax, _1
MOV @BoolAux, eax
tag_aux417:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JE tag_aux421
MOV eax, _1
MOV @BoolAux, eax
JMP tag_aux422
tag_aux421:
MOV eax, _0
MOV @BoolAux, eax
tag_aux422:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux427
MOV SI, OFFSET _@866142330
MOV DI, OFFSET @Aux424
STRCPY
displayString @Aux424
newLine 1
MOV SI, OFFSET @Aux424
MOV DI, OFFSET @Aux426
STRCPY
tag_aux427:
MOV eax, _10
MOV @Aux427, eax
MOV eax, @Aux427
MOV i, eax
MOV eax, _10
MOV @Aux429, eax
MOV eax, @Aux429
MOV w, eax
tag_aux431:
MOV eax, _0
MOV @BoolAux, eax
FLD i
FCOMP _0
FSTSW ax
SAHF
JNA tag_aux435
MOV eax, _1
MOV @BoolAux, eax
tag_aux435:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux455
tag_aux437:
MOV eax, _0
MOV @BoolAux, eax
FLD w
FCOMP _0
FSTSW ax
SAHF
JNA tag_aux441
MOV eax, _1
MOV @BoolAux, eax
tag_aux441:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux449
MOV eax, w
MOV @Aux443, eax
MOV eax, _1
MOV @Aux444, eax
FLD @Aux443
FLD @Aux444
FSUB
FSTP @Aux443
MOV eax, @Aux443
MOV @Aux446, eax
MOV eax, @Aux446
MOV w, eax
JMP tag_aux437
tag_aux449:
MOV eax, i
MOV @Aux449, eax
MOV eax, _1
MOV @Aux450, eax
FLD @Aux449
FLD @Aux450
FSUB
FSTP @Aux449
MOV eax, @Aux449
MOV @Aux452, eax
MOV eax, @Aux452
MOV i, eax
JMP tag_aux431
tag_aux455:
MOV eax, _0
MOV @BoolAux, eax
FLD i
FCOMP _0
FSTSW ax
SAHF
JNE tag_aux459
MOV eax, _1
MOV @BoolAux, eax
tag_aux459:
MOV eax, @BoolAux
MOV @BoolAuxTemp, eax
MOV eax, _0
MOV @BoolAux, eax
FLD w
FCOMP _0
FSTSW ax
SAHF
JNE tag_aux464
MOV eax, _1
MOV @BoolAux, eax
tag_aux464:
FLD @BoolAuxTemp
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux469
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux469
JMP tag_aux470
tag_aux469:
MOV eax, _0
MOV @BoolAux, eax
tag_aux470:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux476
MOV SI, OFFSET _@3458920603
MOV DI, OFFSET @Aux472
STRCPY
displayString @Aux472
newLine 1
MOV SI, OFFSET @Aux472
MOV DI, OFFSET @Aux474
STRCPY
JMP tag_aux481
tag_aux476:
MOV SI, OFFSET _@4263969198
MOV DI, OFFSET @Aux476
STRCPY
displayString @Aux476
newLine 1
MOV SI, OFFSET @Aux476
MOV DI, OFFSET @Aux478
STRCPY
MOV eax, _1
MOV @Aux479, eax
MOV eax, @Aux479
MOV variable1, eax
tag_aux481:
MOV eax, _0
MOV @Aux481, eax
MOV eax, @Aux481
MOV i, eax
MOV eax, _0
MOV @Aux483, eax
MOV eax, @Aux483
MOV w, eax
MOV eax, _0
MOV @Aux485, eax
MOV eax, @Aux485
MOV a, eax
MOV eax, _0
MOV @Aux487, eax
MOV eax, @Aux487
MOV f, eax
MOV eax, _0
MOV @BoolAux, eax
FLD i
FCOMP _0
FSTSW ax
SAHF
JNE tag_aux493
MOV eax, _1
MOV @BoolAux, eax
tag_aux493:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux516
MOV eax, _0
MOV @BoolAux, eax
FLD w
FCOMP _0
FSTSW ax
SAHF
JNE tag_aux499
MOV eax, _1
MOV @BoolAux, eax
tag_aux499:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux516
MOV eax, _0
MOV @BoolAux, eax
FLD a
FCOMP _0
FSTSW ax
SAHF
JNE tag_aux505
MOV eax, _1
MOV @BoolAux, eax
tag_aux505:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux516
MOV eax, _0
MOV @BoolAux, eax
FLD f
FCOMP _0
FSTSW ax
SAHF
JNE tag_aux511
MOV eax, _1
MOV @BoolAux, eax
tag_aux511:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux516
MOV SI, OFFSET _@3890098392
MOV DI, OFFSET @Aux513
STRCPY
displayString @Aux513
newLine 1
MOV SI, OFFSET @Aux513
MOV DI, OFFSET @Aux515
STRCPY
tag_aux516:
MOV eax, _0
MOV @BoolAux, eax
FLD variable1
FCOMP _1
FSTSW ax
SAHF
JNE tag_aux520
MOV eax, _1
MOV @BoolAux, eax
tag_aux520:
FLD @BoolAux
FCOMP _1
FSTSW ax
SAHF
JNE tag_end
MOV SI, OFFSET _@162459165
MOV DI, OFFSET @Aux522
STRCPY
displayString @Aux522
newLine 1
MOV SI, OFFSET @Aux522
MOV DI, OFFSET @Aux524
STRCPY
tag_end:
MOV ax,4c00h
Int 21h
END START
