#include "scr.c"

/*Copyright 2018 Benji Dial
  Portland kernel main routine*/

void _main(void) {
  scr_clear(0x07);
  scr_outstr("Welcome to Portland!\n");
  while (1)
    scr_outchar(scr_inchar());
}
