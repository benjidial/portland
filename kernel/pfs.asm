;Copyright 2018 Benji Dial
;Portland PFS driver

%define pfs_files 0x0600
%define pfs_n_files [0x0504]

[BITS 16]

pfs_init:
  mov ah, 0x48
  mov dl, [sp]
  xor ds, ds
  mov si, info
  int 0x13
  mov ah, 0x42
  mov si, dap
loop:
  int 0x13
  ;TODO: Do stuff
  dec qword [sectors]
  jnz loop
  ret

dap:
  db 16
  db 0
  dw 2
  dw load
  dw 0x0000
sector:
  dq 1

load:
  resb 512

info:
  resb 16
sectors:
  resq
  resb 6
