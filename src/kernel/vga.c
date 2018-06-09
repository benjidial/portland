#include <stdint.h>
#include <stddef.h>

/*Copyright 2018 Benji Dial
  Portland VGA driver*/

#define VGA_BUF (uint16_t *0xb8000)

size_t vga_pos = 0;
uint16_t vga_mask = 0x0700;

void vga_clear(uint16_t mask) {
  uint16_t word = mask | ' ';
  for (size_t i = 0; i < 2000; i++)
    VGA_BUF[i] = word;
  vga_pos = 0;
}

void vga_pch(uint8_t ch) {
  switch (ch) {
  case '\a':
    /*TODO*/
    break;
  case '\b':
    VGA_BUF[--vga_pos] = vga_mask | ' ';
    break;
  case '\t':
    /*TODO*/
    break;
  case '\n':
    vga_pos = (vga_pos / 80 + 1) * 80;
    break;
  case '\r':
    vga_pos = (vga_pos / 80) * 80;
    break;
  default:
    VGA_BUF[vga_pos++] = vga_mask | ch;
  }
}

void vga_psz(uint8_t *sz) {
  for (size_t i = 0; sz[i]; i++)
    vga_pch(sz[i]);
}
