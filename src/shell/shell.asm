;Copyright 2018 Benji Dial
;Portland shell

%define BUF_SIZE 79

[BITS 16]

_main:
  push splash
  int 0x8e
  add sp, 2
  push 0x01
loop:
  push buffer
  int 0x9a
  cmp [buffer], 'e'
  jne skip
  cmp [buffer+1], 'x'
  jne skip
  cmp [buffer+2], 'i'
  jne skip
  cmp [buffer+3], 't'
  jne skip
  cmp [buffer+4], 0x00
  jne skip
  add sp, 4
  ret
skip:
  int 0x95
  add sp, 2
  push prompt
  int 0x8e
  add sp, 2
  jmp loop

splash db "Welcome to Portland shell v0.1.0!", 10, "> ", 10, 0
prompt db "> ", 0
buffer resb BUF_SIZE
