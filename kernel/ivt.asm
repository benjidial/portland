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
  IVT_SET 0x80, mem_alloc
  IVT_SET 0x81, mem_dealloc
  IVT_SET 0x88, vga_set_pos
  IVT_SET 0x89, vga_get_pos
  IVT_SET 0x8a, vga_set_mask
  IVT_SET 0x8b, vga_get_mask
  IVT_SET 0x8c, vga_clear
  IVT_SET 0x8d, vga_pch
  IVT_SET 0x8e, vga_psz
  IVT_SET 0x8f, vga_get_word
  IVT_SET 0x90, pfs_open
  IVT_SET 0x91, pfs_close
  IVT_SET 0x92, pfs_seek
  IVT_SET 0x93, pfs_read
  IVT_SET 0x94, pfs_write
  IVT_SET 0x95, pfs_exec
  IVT_SET 0x96, pfs_flush
  IVT_SET 0x97, pfs_del
  IVT_SET 0x98, kbd_gsc
  IVT_SET 0x99, kbd_gch
  IVT_SET 0x9a, kbd_gln
  ret


IVT_CALL mem_alloc
IVT_CALL mem_dealloc

ivt_vga_set_pos:
  mov [0x0400], word [sp]
  iret

ivt_vga_get_pos:
  mov ax, word [0x0400]
  iret

ivt_vga_set_mask:
  mov [0x0402], word [sp]
  iret

ivt_vga_get_mask:
  mov ax, word [0x0402]
  iret

IVT_CALL vga_clear
IVT_CALL vga_pch
IVT_CALL vga_psz

ivt_vga_get_word:
  mov bx, [sp]
  mul bx, 2
  mov ax, word [bx+0xb8000]
  iret

IVT_CALL pfs_open
IVT_CALL pfs_close
IVT_CALL pfs_seek
IVT_CALL pfs_read
IVT_CALL pfs_write
IVT_CALL pfs_exec
IVT_CALL pfs_flush
IVT_CALL pfs_del

IVT_CALL kbd_gsc
IVT_CALL kbd_gch
IVT_CALL kbd_gln
