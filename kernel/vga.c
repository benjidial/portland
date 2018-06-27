#include <stdint.h>
#include <stddef.h>
/*v0.3.0 - #include "spk.c"*/

/*Portland VGA driver
  Copyright 2018 Benji Dial
  Under Gnu Public License v3.0*/

#define vga_buf ((uint16_t *)0xb8000)
#define vga_pos (*(uint16_t *)0x0400)
#define vga_mask (*(uint16_t *)0x0402)

void vga_clear(uint16_t mask) {
  uint16_t word = (vga_mask = mask) | ' ';
  for (uint16_t i = 0; i < 2000; i++)
    vga_buf[i] = word;
  vga_pos = 0;
}

void vga_pch(uint8_t ch) {
  switch (ch) {
  /*v0.3.0 - case '\a':
               spk_boop();
               break;*/
  case '\b':
    vga_buf[--vga_pos] = vga_mask | ' ';
    break;
  case '\t':
    vga_buf[vga_pos + 4] =
    vga_buf[vga_pos + 3] =
    vga_buf[vga_pos + 2] =
    vga_buf[vga_pos + 1] =
    vga_buf[vga_pos] = vga_mask | ' ';
    vga_pos += 5;
    break;
  case '\n':
    vga_pos = (vga_pos / 80 + 1) * 80;
    break;
  case '\r':
    vga_pos = (vga_pos / 80) * 80;
    break;
  default:
    vga_buf[vga_pos++] = vga_mask | ch;
  }
}

void vga_psz(uint8_t *sz) {
  for (size_t i = 0; sz[i]; i++)
    vga_pch(sz[i]);
}
