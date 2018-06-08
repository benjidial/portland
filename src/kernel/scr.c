#include <stdint.h>
#include <stddef.h>

/*Copyright 2018 Benji Dial
  Portland text-mode I/O*/

size_t scr_pos = 0;
volatile const uint16_t *scr_buf = (uint16_t *)0xb8000;
uint16_t scr_mask = 0x0700;

void scr_clear(uint16_t mask) {
  uint16_t word = mask | ' ';
  for (size_t i = 0; i < 2000; i++)
    scr_buf[i] = word;
  scr_pos = 0;
}

void scr_pch(uint8_t ch) {
  switch (ch) {
  case '\a':
    /*TODO*/
    break;
  case '\b':
    scr_buf[--scr_pos] = scr_mask | ' ';
    break;
  case '\t':
    /*TODO*/
    break;
  case '\n':
    scr_pos = (scr_pos / 80 + 1) * 80;
    break;
  case '\r':
    scr_pos = (scr_pos / 80) * 80;
    break;
  default:
    scr_buf[scr_pos++] = scr_mask | ch;
  }
}

void scr_psz(uint8_t *buffer) {
  for (size_t i = 0; buffer[i]; i++)
    scr_psz(buffer[i]);
}
