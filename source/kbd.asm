;Portland kernel keyboard
;Copyright 2018 Benji Dial
;Under GNU GPL v3.0

kbd_scan_table incbin "scan_tables.bin"

kbd_mods_and_togs dw 0x0000
;0x8000 - lshift
;0x4000 - rshift
;0x2000 - lctrl
;0x1000 - rctrl
;0x0800 - shift
;0x0400 - ctrl
;0x0200 - caps
;0x0100 - num
;0x0080 - lsuper
;0x0040 - rsuper
;0x0020 - lalt
;0x0010 - ralt
;0x0008 - super
;0x0004 - alt
;0x0002 - scroll
;0x0001 - insert

kbd_buffer resb 256
kbd_buffer_next db 0x00
kbd_buffer_size db 0x00

int_kbd:
  push al
  push bx
  xor bh, bh
  in al, 0x60
  mov bl, al
  cmp bl, 0xe0
  je .e0
  cmp bl, 0xe1
  je .pause
  cmp bl, 0x7f
  jg .rel
  mov al, [bx+kbd_scan_table]
  jmp .got_code
.rel:
  mov bl, [bx+kbd_scan_table-128]
  or al, 0x80
  jmp .got_code
.e0:
  in al, 0x60
  mov bl, al
  cmp bl, 0x2a
  je .psp
  cmp bl, 0xb7
  je .psr
  cmp bl, 0x7f
  jg .e0_rel
  mov al, [bx+kbd_scan_table+128]
  jmp .got_code
.e0_rel:
  mov al, [bx+kbd_scan_table]
  jmp .got_code
.pause:
  TODO
.psp:
  in al, 0x60
  in al, 0x60
  mov al, 0x5c
  jmp .got_code
.psr:
  in al, 0x60
  in al, 0x60
  mov al, 0xdc
.got_code:
  cmp byte [kbd_buffer_size], 0xff
  je .leave_early
  mov bl, [kbd_buffer_next]
  add bl, [kbd_buffer_size]
  mov [bx+kbd_buffer], al
  inc byte [kbd_buffer_size]
.leave_early:
  mov al, 0x20
  out 0x20, al
  pop bx
  pop al
  iret

kbd_handle_dl:
  cmp dl, 0x74
  je .caps
  cmp dl, 0x75
  je .num
  cmp dl, 0x76
  je .scroll
  cmp dl, 0x77
  je .insert
  cmp dl, 0x78
  je .lctrl
  cmp dl, 0x79
  je .rctrl
  cmp dl, 0x7a
  je .lsh
  cmp dl, 0x7b
  je .rsh
  cmp dl, 0x7c
  je .lalt
  cmp dl, 0x7d
  je .ralt
  cmp dl, 0x7e
  je .lsuper
  cmp dl, 0x7f
  je .rsuper
  cmp dl, 0xf8
  je .lctrl_r
  cmp dl, 0xf9
  je .rctrl_r
  cmp dl, 0xfa
  je .lsh_r
  cmp dl, 0xfb
  je .rsh_r
  cmp dl, 0xfc
  je .lalt_r
  cmp dl, 0xfd
  je .ralt_r
  cmp dl, 0xfe
  je .lsuper_r
  cmp dl, 0xff
  je .rsuper_r
  ret
.caps:
  xor byte [kbd_mods_and_togs+1], 0x02
  ret
.num:
  xor byte [kbd_mods_and_togs+1], 0x01
  ret
.scroll:
  xor byte [kbd_mods_and_togs], 0x02
  ret
.insert:
  xor byte [kbd_mods_and_togs], 0x01
  ret
.lctrl:
  or byte [kbd_mods_and_togs+1], 0x24
  ret
.rctrl:
  or byte [kbd_mods_and_togs+1], 0x14
  ret
.lsh:
  or byte [kbd_mods_and_togs+1], 0x88
  ret
.rsh:
  or byte [kbd_mods_and_togs+1], 0x48
  ret
.lalt:
  or byte [kbd_mods_and_togs], 0x24
  ret
.ralt:
  or byte [kbd_mods_and_togs], 0x14
  ret
.lsuper:
  or byte [kbd_mods_and_togs], 0x88
  ret
.rsuper:
  or byte [kbd_mods_and_togs], 0x48
  ret
.lctrl_r:
  and byte [kbd_mods_and_togs+1], 0xdb
  test byte [kbd_mods_and_togs+1], 0x10
  je .set_ctrl
  ret
.set_ctrl:
  or byte [kbd_mods_and_togs+1], 0x04
  ret
.rctrl_r:
  and byte [kbd_mods_and_togs+1], 0xeb
  test byte [kbd_mods_and_togs+1], 0x20
  je .set_ctrl
  ret
.lsh_r:
  and byte [kbd_mods_and_togs+1], 0x77
  test byte [kbd_mods_and_togs+1], 0x40
  je .set_shift
  ret
.set_shift:
  or byte [kbd_mods_and_togs+1], 0x08
  ret
.rsh_r:
  and byte [kbd_mods_and_togs+1], 0xb7
  test byte [kbd_mods_and_togs+1], 0x80
  je .set_shift
  ret
.lalt_r:
  and byte [kbd_mods_and_togs], 0xdb
  test byte [kbd_mods_and_togs], 0x10
  je .set_alt
  ret
.set_alt:
  or byte [kbd_mods_and_togs], 0x04
  ret
.ralt_r:
  and byte [kbd_mods_and_togs], 0xeb
  test byte [kbd_mods_and_togs], 0x20
  je .set_alt
  ret
.lsuper_r:
  and byte [kbd_mods_and_togs], 0x77
  test byte [kbd_mods_and_togs], 0x40
  je .set_super
  ret
.set_super:
  or byte [kbd_mods_and_togs], 0x08
  ret
.rsuper_r:
  and byte [kbd_mods_and_togs], 0xb7
  test byte [kbd_mods_and_togs], 0x80
  je .set_super
  ret

int_kbd_char:
  xor bh, bh
  mov bl, byte [kbd_buffer_next]
  test al, al
  jnz .no_spin
.spin:
  test byte [kbd_buffer_size], byte [kbd_buffer_size]
  jz .spin
.no_spin:
  mov dl, byte [bx+kbd_buffer]
  inc bl
  inc byte [kbd_buffer_next]
  test byte [kbd_buffer_size], byte [kbd_buffer_size]
  jz .no_dec
  dec byte [kbd_buffer_size]
  cmp dl, 0x74
  jl .no_dec
  cmp dl, 0x7f
  jg .rel
  call kbd_handle_dl
  jmp .no_dec
.rel:
  cmp dl, 0xf4
  jl .no_dec
  call kbd_handle_dl
.no_dec:
  cmp dl, 0x44
  jl .got_char
  test al, al
  jz .spin
  jmp .no_spin
.got_char:
  xchg bl, dl
  cmp bl, 0x30
  jl .shiftable
  cmp bl, 0x40
  jl .numpad
  mov dl, byte [bx+kbd_scan_table+256]
  iret
.shiftable:
  test byte [kbd_mods_and_togs+1], 0x82
  jz .unmod
  mov dl, byte [bx+kbd_scan_table+324]
  iret
.unmod:
  mov dl, byte [bx+kbd_scan_table+256]
  iret
.numpad:
  test byte [kbd_mods_and_togs+1], 0x01
  jnz .num
  mov bl, dl
  test al, al
  jz .spin
  jmp .no_spin
.num:
  mov dl, byte [bx+kbd_scan_table+324]
  iret

int_kbd_code:
  mov dh, al
  mov ah, al
  and al, 0x01
  jnz .no_spin
.spin:
  test byte byte [kbd_buffer_size], byte [kbd_buffer_size]
  jz .spin
.no_spin:
  xor bh, bh
  mov bl, byte [kbd_buffer_next]
  mov dl, byte [bx+kbd_buffer]
  and ah, 0x02
  jnz .peek
  inc byte [kbd_buffer_next]
  test byte [kbd_buffer_size], byte [kbd_buffer_size]
  jz .peek
  dec byte [kbd_buffer_size]
  and dh, 0x04
  jnz .peek
  cmp dl, 0x74
  jl .peek
  cmp dl, 0x7f
  jg .rel
  call kbd_handle_dl
  iret
.rel:
  cmp dl, 0xf4
  jl .peek
  call kbd_handle_dl
.peek:
  iret

int_kbd_wipe:
  xor byte [kbd_buffer_size], byte [kbd_buffer_size]
  iret
