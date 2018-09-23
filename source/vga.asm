;Portland kernel VGA
;Copyright 2018 Benji Dial
;Under GNU GPL v3.0

VGA_BUF equ 0x000b8000
vga_ofs dd VGA_BUF
vga_color db 0x07

int_print_byte:
  mov ebx, [vga_ofs]
  mov [ebx], [vga_color]
  mov [ebx+1], al
  add [vga_ofs], 2
  iret

int_print_word:
  mov ebx, [vga_ofs]
  mov [ebx], ax
  add [vga_ofs], 2
  iret

int_print_bytes:
  test ebx, ebx
  jz .zero
  mov edx, [vga_ofs]
  mov ah, [vga_color]
.loop:
  mov [ebx], al
  test al, al
  jz .done
  mov [edx], ax
  add ebx, 1
  add edx, 2
  jmp .loop
.done:
  mov [vga_ofs], edx
  xor al, al
  iret
.zero:
  mov al, 0x10
  iret

int_print_words:
  test ebx, ebx
  jz .zero
  mov edx, [vga_ofs]
.loop:
  mov ax, [ebx]
  test al, al
  jz .done
  mov [edx], ax
  add ebx, 2
  add edx, 2
  jmp .loop
.done:
  mov [vga_ofs], edx
  xor al, al
  iret
.zero:
  mov al, 0x10
  iret

int_clear_screen:
  mov [vga_ofs], VGA_BUF
  mov ebx, VGA_BUF
  mov ah, [vga_color]
  mov al, ' '
.loop:
  cmp ebx, VGA_BUF+4000;mode is 80x25
  je .done
  mov [ebx], ax
  add ebx, 2
  jmp .loop
.done:
  iret

int_set_color:
  mov [vga_color], al
  iret

int_move_cursor:
  mov dl, ah
  mul byte 80;mode is 80x25
  add ax, dl
  shl ax, 1
  mov dword [vga_ofs], VGA_BUF
  add [vga_ofs], ax;ax should be less than 0x8000
  iret
