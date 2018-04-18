#include <stdint.h>
#include <stddef.h>

size_t row, column;
uint8_t color;
volatile uint16_t *buffer;

void kernel_main(void) {
  row = 0;
  col = 0;
  buf = (uint16_t *)0xB8000;
  for (size_t i = 0; i < 2000; i++)
    buf[i] = 0x720;

  char *msg = "Hello, world!";
  for (size_t i = 0; msg[i] != '\0'; i++) {
    buf[row++ * 80 + col++] = 0x700 + msg[i];
    if (col == 80) {
      if (row == 25)
        row = 0;
      col = 0;
    }
  }
}
