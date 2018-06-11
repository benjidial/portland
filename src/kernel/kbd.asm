;Copyright 2018 Benji Dial
;Portland PS/2 keyboard driver

[BITS 16]

kbd_gsc:
  xor ax, ax
loop:
  in dl, 0x60
  cmp dl, al
  je loop
  in al, 0x60
  cmp al, 0
  je loop
  ret
