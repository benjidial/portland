;Copyright 2018 Benji Dial
;Portland bootloader

org 0x7c00
kernel_address equ 0x0600
kernel_filename equ kernel_address + 34
kernel_sector equ kernel_address + 24
kernel_size equ kernel_address + 32

[BITS 16]

start:
  mov [0x0414], dl
  mov ah, 0x42
  xor ds, ds
  mov si, dap

loop:
  int 0x13
  test qword [kernel_sector], qword [kernel_sector]
  jz fail
  inc qword [dap_sector]

  cmp [kernel_filename], 'p'
  jne loop
  cmp [kernel_filename+1], 'o'
  jne loop
  cmp [kernel_filename+2], 'r'
  jne loop
  cmp [kernel_filename+3], 't'
  jne loop
  cmp [kernel_filename+4], 'l'
  jne loop
  cmp [kernel_filename+5], 'a'
  jne loop
  cmp [kernel_filename+6], 'n'
  jne loop
  cmp [kernel_filename+7], 'd'
  jne loop
  cmp [kernel_filename+8], '\0'
  jne loop

  mov dx, 0
  mov ax, [kernel_size]
  div word 512
  mov word [dap_n_sectors], ax
  mov qword [dap_sector], [kernel_sector]
  mov ah, 0x42
  int 0x13
  jmp kernel_address

fail:
  mov ax, 0x1300
  mov bx, 0x0004
  mov cx, 40
  mov dx, 0
  xor es, es
  mov bp, fail_msg
  int 0x10
  hlt

fail_msg:
  "Could not find file 'portland'. Halting."
  ;123456789|123456789|123456789|123456789|=40

dap:
  db 16
  db 0
dap_n_sectors:
  dw 1;n_sectors
  dw kernel_address;buffer
  dw 0x0000;buffer segment
dap_sector:
  dq 0;sector

end:
%if end - start > 504
%error "Bootloader too long to fit."
%endif
  times 510 - ($ - $$) db 0
  db 0x55, 0xaa
