#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include "vga.c"

/*Copyright 2018 Benji Dial
  Portland PS/2 keyboard driver*/

uint8_t kbd_sc2ch(uint8_t scan) {
  /*TODO*/
}

extern uint8_t kbd_gsc(void);

uint8_t kbd_gch(bool print) {
  uint8_t graph = kbd_sc2ch(kbd_gsc());
  if (print)
    vga_pch(graph);
  return graph;
}

void kbd_gln(uint8_t *buffer, bool print) {
  size_t i = -1;
  while (1)
    switch (buffer[++i] = kbd_gch(print)) {
    case '\b':
      i -= 2;
      continue;
    case '\n':
      goto gotLine;
    }
gotLine:
  buffer[i] = '\0';
}
