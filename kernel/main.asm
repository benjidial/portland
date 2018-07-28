;Portland kernel main routine
;Copyright 2018 Benji Dial
;Under GNU GPL v3.0

  bits 16
  org 0x8000

main:
  cli
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov ah, 0x40
  mov ss, ax
  mov sp, 0x7fff
  lgdt [gdt_index]
  mov eax, cr0
  or al, 1
  mov cr0, eax
  jmp 0x0008:far_jump

  bits 32

far_jump:
  mov ax, 0x0010
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov esp, TODO

  mov al, 0x11
  out 0x20, al
  out 0xa0, al
  mov al, 0x20
  out 0x21, al
  mov al, 0x28
  out 0xa1, al
  mov al, 0x04
  out 0x21, al
  mov al, 0x02
  out 0xa1, al
  mov al, 0x01
  out 0x21, al
  out 0xa1, al
  lidt [idt_index]

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

%include "idt.asm"
idt_index:
  dw idt_index - idt - 1
  dq idt
