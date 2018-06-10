_main:
  ;pass hello
  int 0x96
  ret

hello db "Hello, world!", 10, 0
