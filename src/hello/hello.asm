[BITS 16]

_main:
  push hello
  int 0x8e
  add esp, 2
  ret

hello db "Hello, world!", 10, 0
