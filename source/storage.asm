;Portland storage driver
;Copyright 2018 Benji Dial
;Under GNU GPL v3.0

  bits 32

drive_list equ $ - 0x61 * 20
  times 26 resb 20
file_lists equ $ - 0x61 * 4
  times 26 dd 0x00000000

sector_buffer resb 512

;al - drive letter
;ecx - sector number
;ebx - buffer pointer
read_sector equ $ - 0x61 * 4
  dd flp_read_a

write_sector equ $ - 0x61 * 4
  dd flp_write_a

int_drive_info:
  test ebx, ebx
  jz .bad_ptr

  mul byte 20
  xor edx, edx
  mov dx, ax
  test byte [edx+drive_list], byte [edx+drive_list]
  jz .no_drive

  mov dword [ebx], dword [edx+drive_list]
  mov dword [ebx+4], dword [edx+drive_list+4]
  mov dword [ebx+8], dword [edx+drive_list+8]
  mov dword [ebx+12], dword [edx+drive_list+12]
  mov dword [ebx+16], dword [edx+drive_list+16]

  xor al, al
  iret

.bad_ptr:
  mov al, 0x10
  iret

.no_drive:
  mov al, 0x02
  iret

int_storage_inventory:
  mov ebx, sector_buffer
  ;
