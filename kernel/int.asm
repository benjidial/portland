;Portland ISR handlers
;Copyright 2018 Benji Dial
;Under GNU GPL v3.0

null:
  iret

VGA_BUF equ 0x000b8000
vga_ofs dd VGA_BUF
vga_style db 0x07

int_print_byte:
  push ebx
  mov ebx, [vga_ofs]
  mov [ebx], [vga_style]
  mov [ebx+1], al
  pop ebx
  add [vga_ofs], 2
  iret

int_print_word:
  push ebx
  mov ebx, [vga_ofs]
  mov [ebx], ax
  pop ebx
  add [vga_ofs], 2
  iret

int_print_bytes:
  test ebx, ebx
  jz .zero
  push edx
  mov edx, [vga_ofs]
  push ebx
  push ah
  mov ah, [vga_style]
.loop:
  mov [ebx], al
  test al, al
  jz .done
  mov [edx], ax
  add ebx, 1
  add edx, 2
  jmp .loop
.done:
  pop ah
  pop ebx
  mov [vga_ofs], edx
  pop edx
  xor al, al
  iret
.zero:
  mov al, 0x10
  iret

int_print_words:
  test ebx, ebx
  jz .zero
  push edx
  mov edx, [vga_ofs]
  push ax
  push ebx
.loop:
  mov ax, [ebx]
  test al, al
  jz .done
  mov [edx], ax
  add ebx, 2
  add edx, 2
  jmp .loop
.done:
  pop ebx
  pop ax
  mov [vga_ofs], edx
  pop edx
  xor al, al
  iret
.zero:
  mov al, 0x10
  iret

int_clear_screen:
  mov [vga_ofs], VGA_BUF
  push ebx
  mov ebx, VGA_BUF
  push ax
  mov ah, [vga_style]
  mov al, ' '
.loop:
  cmp ebx, VGA_BUF+2*80*25
  je .done
  mov [ebx], ax
  add ebx, 2
  jmp .loop
.done:
  pop ax
  pop ebx
  iret

int_set_style:
  mov [vga_style], al
  iret

int_move_cursor:
  push dx
  mov [vga_ofs], VGA_BUF
  mov dx, ah
  mul dx, 80
  add dx, al
  add [vga_ofs], dx
  pop dx
  iret
