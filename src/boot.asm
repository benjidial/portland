;Copyright 2018 Benji Dial

MAGIC equ 0x1BADB002

section .multiboot
align 4
  dd MAGIC
  dd 3
  dd -MAGIC-3

section .bss
align 16
stack_bottom:
  resb 0x4000
stack_top:

gdt resb
 
section .text
global _start:function (_end - _start)
_start:
  mov esp, stack_top

  extern kernel_main
  call kernel_main

  hlt
_end:
