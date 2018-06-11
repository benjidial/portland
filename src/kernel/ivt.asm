;Copyright 2018
;Portland interrupt vector table

%macro IVT_SET 2
  mov [IVT_START+gs:%1*4], word ivt_%2
  mov [IVT_START+gs:%1*4+2], ds
%endmacro

%macro IVT_CALL 1
ivt_%1:
  extern %1
  call %1
  iret
%endmacro

%define IVT_START 0x0

ivt_set_up:
  cli
  xor ax, ax
  mov gs, ax
  IVT_SET 0x80, mem_alloc_block
  IVT_SET 0x81, mem_dealloc_block
  IVT_SET 0x88, vga_set_pos
  IVT_SET 0x89, vga_get_pos
  IVT_SET 0x8a, vga_set_mask
  IVT_SET 0x8b, vga_get_mask
  IVT_SET 0x8c, vga_clear
  IVT_SET 0x8d, vga_pch
  IVT_SET 0x8e, vga_psz
  IVT_SET 0x8f, vga_get_word
  IVT_SET 0x90, fat_open
  IVT_SET 0x91, fat_close
  IVT_SET 0x92, fat_seek
  IVT_SET 0x93, fat_read
  IVT_SET 0x94, fat_write
  IVT_SET 0x95, fat_exec
  IVT_SET 0x96, fat_dir_info
  IVT_SET 0x97, fat_del
  IVT_SET 0x98, kbd_gsc
  IVT_SET 0x99, kbd_gch
  IVT_SET 0x9a, kbd_gln
  ret


IVT_CALL mem_alloc_block
IVT_CALL mem_dealloc_block

ivt_vga_set_pos:
  extern vga_pos
  mov [vga_pos], word [sp]
  iret

ivt_vga_get_pos:
  mov ax, word [vga_pos]
  iret

ivt_vga_set_mask:
  extern vga_mask
  mov [vga_mask], word [sp]
  iret

ivt_vga_get_mask:
  mov ax, word [vga_mask]
  iret

IVT_CALL vga_clear
IVT_CALL vga_pch
IVT_CALL vga_psz

ivt_vga_get_word:
  mov bx, [sp]
  mul bx, 2
  mov ax, word [bx+0xb8000]
  iret

IVT_CALL fat_open
IVT_CALL fat_close
IVT_CALL fat_seek
IVT_CALL fat_read
IVT_CALL fat_write
IVT_CALL fat_exec
IVT_CALL fat_dir_info
IVT_CALL fat_del

IVT_CALL kbd_gsc
IVT_CALL kbd_gch
IVT_CALL kbd_gln
