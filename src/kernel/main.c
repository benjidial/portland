#include "vga.c"
#include "mem.c"
void ivt_set_up(void);
#include "fat.c"

/*Copyright 2018 Benji Dial
  Portland kernel main routine*/

void main(void) {
  ivt_set_up();
  mem_clear();
  vga_clear(0x07);
  fat_exec("SHELL");
}
