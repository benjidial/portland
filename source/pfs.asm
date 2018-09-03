;Portland file system-related ISR handlers
;Copyright 2018 Benji Dial
;Under GNU GPL v3.0

  bits 32

pfs_buffer resb 512
pfs_drive resb 1
pfs_gen resd 1

;al - drive letter
;cx - sector number
;ebx - buffer pointer
pfs_read_sector:
  ;TODO
  ret

pfs_write_sector:
  ;TODO
  ret

;al - drive letter
;edx - name pointer
;ebx out - success - 0:cx out
;          not found - clobber
;          bad disk format - pfs_buffer+512
;ecx out - success - sector:address in index
;          not found - perserve:clobber
;          bad disk format - perserve:15
;ah  out - 0 - success
;          2 - not found
;          3 - bad disk format
pfs_find_head:
  xor cx, cx
  test byte [edx+1], byte [edx+1]
  jz .short
  test byte [edx+2], byte [edx+2]
  jz .short

  mov dword [pfs_gen], .loop_i

.loop_o:
  test cx, 15
  je .bad_format

  mov ebx, pfs_buffer
  inc cx
  call pfs_read_sector

.loop_i:
  test ebx, pfs_buffer+512
  je .loop_o
  test dword [ebx], dword [ebx]
  jz .not_found
  add ebx, 8

  test dword [ebx-4], dword [edx]
  jne .loop_i

.maybe_found:
  push cx
  push ebx
  push edx
  mov cx, dword [ebx-8];FIXME
  mov ebx, pfs_buffer

  call pfs_read_sector

  add ebx, 26
  dec edx
.name_loop:
  inc ebx
  inc edx
  test byte [ebx], byte [edx]
  jne .false_alarm
  test byte [ebx], byte [ebx]
  jnz .name_loop

  pop edx
  pop ebx
  pop cx
.found:
  shl ecx, 16
  sub ebx, pfs_buffer+8
  mov cx, bx
  xor ah, ah
  ret

.false_alarm:
  pop edx
  pop ebx
  pop cx
  jmp dword [pfs_gen]

.not_found:
  mov ah, 2
  ret

.bad_format:
  mov ah, 3
  ret

.short:
   mov dword [pfs_gen], .short_loop_i

.short_loop_o:
  test cx, 15
  je .bad_format

  mov ebx, pfs_buffer
  inc cx
  call pfs_read_sector

.short_loop_i:
  test ebx, pfs_buffer+512
  je .loop_o
  test dword [ebx], dword [ebx]
  jz .not_found
  add ebx, 8

  test byte [ebx-4], byte [edx]
  jne .loop_i
  test byte [ebx-3], byte [edx+1]
  jne .loop_i
  test byte [edx+1], byte [edx+1]
  jz .found
  test byte [ebx-2], byte [edx+2]
  jne .loop_i
  jmp .found

int_file_open:
  test ebx, ebx
  jz .bad_ptr
  test edx, edx
  jz .bad_ptr

  cmp byte [edx+1], '~'
  je .spec
  mov al, byte [pfs_drive]
  jmp .drive
.spec:
  mov al, byte [edx]
  add edx, 2
.drive:

  push ebx
  call pfs_find_head
  pop ebx

  test ah, ah
  jz .no_error

  mov al, ah
  ret

.no_error:
  mov word [ebx], dword [cx+pfs_buffer];FIXME
  mov byte [ebx+2], al
  xor byte [ebx+3], byte [ebx+3]
  xor dword [ebx+4], dword [ebx+4]
  ret

.bad_ptr:
  mov al, 0x10
  ret
