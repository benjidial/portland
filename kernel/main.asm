;Portland kernel main routine
;Copyright 2018 Benji Dial
;Under Gnu Public License v3.0

  extern vga_psz
  extern vga_clear
  extern pfs_init
  extern pfs_exec

  bits 16
  org 0xf000

main:
  cli
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov ah, 0xe0
  mov ss, ax
  mov sp, 0xefff
  lgdt [gdt_index]
  mov eax, cr0
  or al, 1
  mov cr0, eax
  jmp 0x08:far_jump

  bits 32

far_jump:
  mov ax, 0x10
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov esp, TODO

  call pfs_init
  push shell_msg
  call vga_psz
  push shell_name
  call pfs_exec

  call vga_clear
  push shutdown_msg
  call vga_psz

hlt:
  hlt
  jmp hlt

shell_msg db "Launching shell...", 0
shell_name db "shell", 0
shutdown_msg db "You may now power off your computer.", 0

gdt:
  dq 0x0000000000000000
  dq 0x00cf9a000000ffff
  dq 0x00cf92000000ffff
gdt_index:
  dw gdt_index - gdt - 1
  dq gdt
