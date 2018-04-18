#include <stdint.h>
#include <stddef.h>

/*Copyright 2018 Benji Dial*/

size_t pos;
volatile uint16_t *buf;

void scr_init(void) {
  pos = 0;
  buf = (uint16_t *)0xB8000;
}

void scr_clear(uint8_t color) {
  uint16_t _ = color << 8 + 0x20;
  for (size_t i = 0; i < 2000; i++)
    buf[i] = _;
  pos = 0;
}

void scr_print(char *msg, uint8_t color) {
  uint16_t _ = color << 8;
  for (size_t i = 0; msg[i] != 0; i++)
    buf[i] = _ + msg[i];
}
