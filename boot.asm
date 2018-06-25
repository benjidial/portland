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
  xor ax, ax
  mov ds, ax
  mov ah, 0x42
  mov si, dap

loop:
  int 0x13
  test qword [kernel_sector], qword [kernel_sector]
  jz fail
  add qword [dap_sector], 1

  cmp byte [kernel_filename], 'p'
  jne loop
  cmp byte [kernel_filename+1], 'o'
  jne loop
  cmp byte [kernel_filename+2], 'r'
  jne loop
  cmp byte [kernel_filename+3], 't'
  jne loop
  cmp byte [kernel_filename+4], 'l'
  jne loop
  cmp byte[kernel_filename+5], 'a'
  jne loop
  cmp byte [kernel_filename+6], 'n'
  jne loop
  cmp byte [kernel_filename+7], 'd'
  jne loop
  cmp byte [kernel_filename+8], '\0'
  jne loop

  mov dx, 0
  mov ax, [kernel_size]
  mov cx, 512
  div cx
  mov word [dap_n_sectors], ax
  mov word [dap_sector],   [kernel_sector]
  mov word [dap_sector+1], [kernel_sector+1]
  mov word [dap_sector+2], [kernel_sector+2]
  mov word [dap_sector+3], [kernel_sector+3]
  mov ah, 0x42
  int 0x13
  jmp kernel_address

fail:
  xor ax, ax
  mov es, ax
  mov ax, 0x1300
  mov bx, 0x0004
  mov cx, 40
  mov dx, 0
  mov bp, fail_msg
  int 0x10
  hlt

fail_msg:
  db "Could not find file 'portland'. Halting."
     ;123456789|123456789|123456789|123456789| = 40

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
