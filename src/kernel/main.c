#include "vga.c"

/*Copyright 2018 Benji Dial
  Portland kernel main routine*/

void _main(void) {
  vga_clear(0x07);
  vga_psz("Welcome to Portland!\n");
}
