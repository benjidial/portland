#include <stdint.h>
#include <stddef.h>

#include "libc/stdio.h"

/*Copyright 2018 Benji Dial*/

void scr_init(void) {
  _pos = 0;
  _buf = (uint16_t *)0xB8000;
  _color = 0x07;
}

void scr_clear(uint8_t color) {
  uint16_t _ = ((uint16_t)color << 8) + 0x20;
  for (size_t i = 0; i < 2000; i++)
    _buf[i] = _;
  _pos = 0;
}
