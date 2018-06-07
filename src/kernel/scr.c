#include <stdint.h>
#include <stddef.h>

/*Copyright 2018 Benji Dial*/

size_t scr_pos = 0;
volatile uint16_t *scr_buf = (uint16_t *)0xb8000;
uint8_t scr_mask = 0x0700;

void scr_clear(uint8_t color) {
  uint16_t byte = scr_mask + ' ';
  for (size_t i = 0; i < 2000; i++)
    scr_buf[i] = byte;
  scr_pos = 0;
}

uint8_t src_inchar(void) {
  /*TODO*/
}

void scr_outchar(uint8_t ch) {
  switch (ch) {
  case '\a':
    /*TODO*/
    break;
  case '\b':
    scr_buf[--scr_pos] = scr_mask + ' ';
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
    scr_buf[scr_pos++] = scr_mask + ch;
  }
}

void scr_instr(uint8_t *buffer, size_t count) {
  for (size_t i = 0; i < count; i++)
    buffer[i] = scr_inchar();
}

void scr_outstr(uint8_t *buffer) {
  for (size_t i = 0; buffer[i]; i++)
    scr_outchar(buffer[i]);
}
