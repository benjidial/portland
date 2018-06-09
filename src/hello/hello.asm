_main:
  ;pass hello
  int 0x96
  ;set return value to 0
  ret

hello db "Hello, world!", 10, 0
