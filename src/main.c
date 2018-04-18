#include "screen.c"

/*Copyright 2018 Benji Dial*/

void kernel_main(void) {
  scr_init();
  scr_clear(0x07);
  scr_print("Hello, world!", 0x07);
}
