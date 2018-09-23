;Portland kernel PFS
;Copyright 2018 Benji Dial
;Under GNU GPL v3.0

  bits 32

pfs_inventory:
  xor ecx, ecx
  mov ebx, sector_buffer
  call read_sector
  
  ret

;al - drive letter
;edx - name pointer
;ebx out - success - 0:cx out
;          not found - clobber
;          bad disk format - pfs_buffer+512
;ecx out - success - sector:byte in index
;          not found - 0:clobber
;          bad disk format - 15
;ah  out - 0 - success
;          2 - not found
;          3 - bad disk format
pfs_find_head:
  xor ecx, ecx
  test byte [edx+1], byte [edx+1]
  jz .short_loop_o
  test byte [edx+2], byte [edx+2]
  jz .short_loop_o
  test byte [edx+3], byte [edx+3]
  jz .four

.loop_o:
  test cl, 15
  je .bad_format

  mov ebx, pfs_buffer
  inc cl
  call read_sector

.loop_i:
  test ebx, pfs_buffer+512
  je .loop_o
  test dword [ebx], dword [ebx]
  jz .not_found
  add ebx, 8

  test dword [ebx-4], dword [edx]
  jne .loop_i

.maybe_found:
  push ecx
  push ebx
  push edx
  mov ecx, dword [ebx-8]
  xor ebx, ebx

  call read_sector

  dec edx
.name_loop:
  inc ebx
  inc edx
  test byte [ebx+pfs_buffer+3], byte [edx+3]
  jne .false_alarm
  test byte [ebx], byte [ebx]
  jnz .name_loop

  pop edx
  pop ebx
  pop ecx
.found:
  shl ecx, 16
  sub ebx, pfs_buffer+8
  mov cx, bx
  xor ah, ah
  ret

.false_alarm:
  pop edx
  pop ebx
  pop ecx
  jmp .loop_o

.not_found:
  mov ah, 2
  ret

.bad_format:
  mov ah, 3
  ret

.short_loop_o:
  test cl, 15
  je .bad_format

  mov ebx, pfs_buffer
  inc cl
  call read_sector

.short_loop_i:
  test ebx, pfs_buffer+512
  je .loop_o
  test dword [ebx], dword [ebx]
  jz .not_found
  add ebx, 8

  test byte [ebx-4], byte [edx]
  jne .short_loop_i
  test byte [ebx-3], byte [edx+1]
  jne .short_loop_i
  test byte [edx+1], byte [edx+1]
  jz .found
  test byte [ebx-2], byte [edx+2]
  jne .short_loop_i
  jmp .found

.four:
  test cl, 15
  je .bad_format

  mov ebx, pfs_buffer
  inc cl
  call read_sector

.four_li:
  test ebx, pfs_buffer+512
  je .four
  test dword [ebx], dword [ebx]
  jz .not_found
  add ebx, 8

  test dword [ebx-4], dword [edx]
  je .found
  jmp .four_li

int_file_open:
  test ebx, ebx
  jz .bad_ptr
  test edx, edx
  jz .bad_ptr

  call ready_drive
  push ebx
  call pfs_find_head
  pop ebx
  call calm_drive
  test ah, ah
  jz .no_error

  mov al, ah
  iret

.no_error:
  mov dword [ebx], dword [cx+pfs_buffer];FIXME
  mov byte [ebx+2], al
  xor byte [ebx+3], byte [ebx+3]
  xor dword [ebx+4], dword [ebx+4]
  iret

.bad_ptr:
  mov al, 0x10
  iret

int_file_info:
  test ebx, ebx
  jz .bad_ptr
  test edx, edx
  jz .bad_ptr

  call ready_drive
  push ebx
  call pfs_find_head
  pop ebx
  test ah, ah
  jz .no_error

  call calm_drive
  mov al, ah
  iret

.no_error:
  mov cx, dword [cx+pfs_buffer];FIXME
  call read_sector
  call calm_drive
  xor al, al
  iret
