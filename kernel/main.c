#include "vga.c"
#include "mem.c"
extern void ivt_set_up(void);
#include "tar.c"

/*Copyright 2018 Benji Dial
  Portland kernel main routine*/

void main(void) {
  ivt_set_up();
  mem_clear();
  vga_clear(0x07);
  tar_exec("SHELL");
}
