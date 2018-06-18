;Copyright 2018 Benji Dial
;Portland bootloader

org 0x7c00
kernel_address equ 0x0e00

[BITS 16]

  mov [0x0405], dl
  mov ah, 0x42
  xor ds, ds
  mov si, dap

dap:
  db 16
  db 0
  dw 1
  dw kernel_address
  dw 0x0000
dap_sector
  dq 0

  times 510 - ($ - $$) db 0
  db 0x55, 0xaa
