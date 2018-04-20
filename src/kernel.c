#include "screen.c"
#include "gdt-idt.c"

/*Copyright 2018 Benji Dial*/

void kernel_main(void) {
  gdt_init();
  idt_init();

  scr_init();
  scr_clear(0x07);
  while (true)
    getchar();
}
