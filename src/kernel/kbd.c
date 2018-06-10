#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include "vga.c"

/*Copyright 2018 Benji Dial
  Portland keyboard driver*/

struct kbd_packet {
  /*TODO*/
}

uint8_t kbd_packet_to_graph(struct kbd_packet packet) {
  /*TODO*/
}

struct kbd_packet kbd_gkp(void) {
  /*TODO*/
}

uint8_t kbd_gch(bool print) {
  uint8_t graph = kbd_packet_to_graph(kbd_gkp());
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
