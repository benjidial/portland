;Portland floppy driver
;Copyright 2018 Benji Dial
;Under GNU GPL v3.0

  bits 32

flp_inventory:
  xor ecx, ecx
  mov ebx, sector_buffer
  call flp_read

flp_wait_byte db 0

int_flp:
  or byte [flp_wait_byte], 1
  mov al, 0x20
  out 0x20, al
  iret

flp_wait:
  test byte [flp_wait_byte], byte [flp_wait_byte]
  jz flp_wait
  xor byte [flp_wait_byte], byte [flp_wait_byte]
  ret

;al - data byte
flp_out:
  push al

.spin:
  in al, 0x03f4
  and al, 0x80
  test al, 0x80
  jne .spin

  pop al
  out 0x03f5, al
  ret

;al out - data byte
flp_in:
  in al, 0x03f4
  and al, 0x80
  test al, 0x80
  jne flp_in

  in al, 0x04f5
  ret

flp_read_a:
  push bl
  push eax
  push edx
  push ecx

  mov al, 0x46
  out 0x03f5, al

  mov ax, cx
  mov dx, word [esp+2]
  div word 36
  mov ax, dx
  xor dx, dx
  div word 9
  shl al, 1
  call flp_out
  shl eax, 14

  mov edx, dword [esp]
  mov ax, dx
  shr edx, 16
  div word 36
  call flp_out

  shr eax, 16
  call flp_out

  mov al, dl
  inc al
  call flp_out

  mov al, 2
  call flp_out

  or al, 16
  call flp_out

  or al, 9
  call flp_out

  or al, 255
  call flp_out

  call flp_wait

  call flp_in
  call flp_in
  mov bl, al
  call flp_in
  call flp_in
  call flp_in
  call flp_in
  call flp_in

  pop ecx
  pop edx
  pop eax
  mov al, bl
  pop bl
  ret
