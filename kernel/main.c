#include "vga.c"
#include "mem.c"
extern void ivt_set_up(void);
#include "pfs.c"

/*Copyright 2018 Benji Dial
  Portland kernel main routine*/

void main(void) {
  vga_psz("Clearing display...");
  vga_clear(0x07);
  vga_psz("Clearing dynamic memory region...");
  mem_clear();
  vga_psz("\nInitializing file system records...");
  pfs_init();
  vga_psz("\nSetting up interrupt vector table...");
  ivt_set_up();
  vga_psz("\nLaunching shell.\n");
  pfs_exec("SHELL");
}
