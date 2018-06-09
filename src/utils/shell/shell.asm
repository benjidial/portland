;Copyright 2018 Benji Dial
;Portland shell

_main:
  ;pass splash
  int 0x96
loop:
  ;pass prompt
  int 0x96
  ;read line
  ;check line against "exit" *
  ;set return value to 0
  ret
;* if diff
  ;pass line
  int 0xa0
  ;pass file
  ;pass size
  ;pass buffer
  int 0xa4
  ;run buffer
  jmp loop

splash db "Welcome to Portland shell v0.1.0!", 10, 0
prompt db "> ", 0
