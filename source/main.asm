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

.kbd_resend:
  mov al, 0xf0
  out 0x64, al
  mov al, 0x01
  out 0x60, al
  in al, 0x64
  cmp al, 0xfe
  je .kbd_resend

  mov al, 0x13
  out 0x03f5, al
  xor al, al
  out 0x03f5, al
  or al, 0x57
  out 0x03f5, al
  xor al, al
  out 0x03f5, al
  or al, 0x94
  out 0x03f5, al
  xor al, al
  out 0x03f2, al
  or al, 0x0c
  out 0x03f2, al
  call flp_wait
  xor al, al
  out 0x03f7, al
  or al, 0x1c
  out 0x03f2, al
  ;TODO: Wait for drive to spin up
  xor al, 0x1b
  out 0x03f5, al
  xor al, al
  out 0x03f5, al
  call flp_wait

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

  int 0x61

  mov ebx, shell_msg
  int 0x4a
  mov ebx, shell_name
  int 0x46
  cmp al, 0x03
  je no_shell

  int 0x4c
  mov ebx, shutdown_msg
  int 0x4a

hlt:
  hlt
  jmp hlt

no_shell:
  mov ebx, no_shell_msg
  int 0x4a
  jmp hlt

shell_msg db "Launching a~shell...", 0
shell_name db "a~shell", 0
no_shell_msg db 10, "Could not find a~shell.  Halting.", 0
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
