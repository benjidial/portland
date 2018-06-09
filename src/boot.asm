;Copyright 2018 Benji Dial
;Portland bootloader

[org 0x7c00]
[bits 16]

  jmp short boot
  nop
  time 0x3b db 0

boot:
  cli
  xor ax, ax
  mov ds, ax
  lgdt [gdt_descriptor]
  mov eax, cr0
  or eax, 1
  mov cr0, eax
  jmp 8:prot

[bits 32]

prot_boot:
  mov ax, 8
  mov ds, ax
  mov ss, ax
  mov esp, 0x90000

  ;load and call the kernel


gdt_start:
gdt_null:
  dq 0
gdt_code:
  dw 0xffff;limiter
  dw 0     ;address
  db 0     ;address
  db 0xa9  ;flags
  db 0xcf  ;limiter, flags
  db 0     ;address
gdt_data:
  dw 0xffff;limiter
  dw 0     ;address
  db 0     ;address
  db 0x92  ;flags
  db 0xcf  ;limiter, flags
  db 0     ;address
gdt_end:

gdt_descriptor:
  db gdt_end - gdt_start
  dw gdt_start


times 510 - ($ - $$) db 0
dw 0xaa55
