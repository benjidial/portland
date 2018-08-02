;Portland keyboard-related ISR handlers
;Copyright 2018 Benji Dial
;Under GNU GPL v3.0

kbd_scan_table db TODO
kbd_e0_scan_table bd TODO

kbd_mods_and_togs dw 0x0000
;0x8000 - lshift
;0x4000 - rshift
;0x2000 - lctrl
;0x1000 - rctrl
;0x0800 - lsuper
;0x0400 - rsuper
;0x0200 - lalt
;0x0100 - ralt
;0x0080 - caps
;0x0040 - num
;0x0020 - scroll
;0x0010 - insert
;0x0008 - shift
;0x0004 - ctrl
;0x0002 - super
;0x0001 - alt

kbd_buffer resb 256
kbd_buffer_next db 0x00
kbd_buffer_size db 0x00

int_kbd:
  push ax
  in al, 0x60
  test al, 0xe0
  je .e0
  mov al, [al+kbd_scan_table]
  jmp .got_keycode
.e0:
  in al, 0x60
  mov al, [al+kbd_e0_scan_table]
  cmp al, 0x00
  jne .got_keycode
  TODO
.got_keycode:
  cmp byte [kbd_buffer_size], 0xff
  je .leave_early
  mov ah, [kbd_buffer_next]
  add ah, [kbd_buffer_size]
  mov [ah+kbd_buffer], al
  inc byte [kbd_buffer_size]
.leave_early:
  mov al, 0x20
  out 0x20, al
  pop ax
  iret

int_kbd_char:
  mov ah, al
  and al, 0x01
  je .no_spin
.spin:
  cmp byte [kbd_buffer_size], 0x00
  je .spin
.no_spin:
  mov al, [kbd_buffer_next]
  mov dl, [al+kbd_buffer]
  and ah, 0x02
  je .peek
  inc byte [kbd_buffer_next]
  cmp byte [kbd_buffer_size], 0x00
  je .peek
  dec byte [kbd_buffer_size]
.peek:
  iret
