;Portland PS/2 keyboard driver
;Copyright 2018 Benji Dial
;Under Gnu Public License 3.0

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

kbd_scan_table_0:
  ;TODO: Finish this
  db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "\t`", 0     ;0x0*
  db 0, 0, 0, 0, 0, "q1", 0, 0, 0, "zsaw2", 0            ;0x1*
  db 0, "cxde43", 0, 0, " vftr5", 0                      ;0x2*
  db 0, "nbhgy6", 0, 0, 0, "mju78", 0                    ;0x3*
  db 0, ",kio09", 0, 0, "./l;p-", 0                      ;0x4*
  db 0, 0, "'", 0, "[=", 0, 0, 0, 0, "\n]", 0, "\\", 0, 0;0x5*
  db 0, 0, 0, 0, 0, 0, "\b", 0, 0, 0, 0, 0, 0, 0, 0, 0   ;0x6*
  times 0xa0 db 0

kbd_scan_table_1:
  times 0x100 db 0
