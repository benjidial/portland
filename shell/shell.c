#include <p-clib/stdio.h>
#include <p-clib/stdlib.h>
#include <stdint.h>

/*Copyright 2018 Benji Dial
  Portland shell*/

void main(void) {
  uint8_t buffer[1024];
  puts("Welcome to Portland Shell v0.2.0!");
  while (1) {
    putchar('>');
    putchar(' ');
    if (gets(buffer)[0] == 'e' &&
              buffer[1] == 'x' &&
              buffer[2] == 'i' &&
              buffer[3] == 't' &&
              buffer[4] == '\0')
      return;
    system(buffer);
  }
}
