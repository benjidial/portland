;Copyright 2018
;Portland interrupt vector table

%macro IVT_SET 2
  mov [gs:%1*4], word ivt_%2
  mov [gs:%1*4+2], ds
%endmacro

%macro IVT_CALL 1
ivt_%1:
  extern _%1
  call _%1
  iret
%endmacro

%define IVT_START 0x0

ivt_set_up:
  cli
  xor ax, ax
  mov gs, ax
  IVT_SET 0x80, mem_alloc_block
  IVT_SET 0x81, mem_dealloc_block
  IVT_SET 0x90, vga_set_pos
  IVT_SET 0x91, vga_get_pos
  IVT_SET 0x92, vga_set_mask
  IVT_SET 0x93, vga_get_mask
  IVT_SET 0x94, vga_clear
  IVT_SET 0x95, vga_pch
  IVT_SET 0x96, vga_psz
  IVT_SET 0xa0, fat_open
  IVT_SET 0xa1, fat_close
  IVT_SET 0xa2, fat_seek
  IVT_SET 0xa3, fat_read
  IVT_SET 0xa4, fat_write
  ret


IVT_CALL mem_alloc_block;0x80
IVT_CALL mem_dealloc_block;0x81

ivt_vga_set_pos:;0x90
  ;TODO
  iret

ivt_vga_get_pos:;0x91
  ;TODO
  iret

ivt_vga_set_mask:;0x92
  ;TODO
  iret

ivt_vga_get_mask:;0x93
  ;TODO
  iret

IVT_CALL vga_clear;0x94
IVT_CALL vga_pch;0x95
IVT_CALL vga_psz;0x96

IVT_CALL fat_open;0xa0
IVT_CALL fat_close;0xa1
IVT_CALL fat_seek;0xa2
IVT_CALL fat_read;0xa3
IVT_CALL fat_write;0xa4
