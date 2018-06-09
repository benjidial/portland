#include "vga.c"
#include "mem.c"
#include "ivt.c"

/*Copyright 2018 Benji Dial
  Portland kernel main routine*/

int main(void) {
  ivt_set_up();
  mem_clear();
  vga_clear(0x07);
  vga_psz("Welcome to Portland!\n");
  return 0;
}
