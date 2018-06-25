#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include "vga.c"

/*Copyright 2018 Benji Dial
  Portland PS/2 keyboard driver*/

extern uint8_t *kbd_scan_table_0;
extern uint8_t *kbd_scan_table_1;
extern uint8_t kbd_gsc(void);

uint8_t kbd_gch(bool print) {
  uint8_t graph;
  while (1) {
    uint8_t scan = kbd_gsc();
    if (scan == 0xf0) {/*Release*/
      graph = kbd_scan_table_0[kbd_gsc()];
      break;
    }
    else if (scan == 0xe0) {/*Second table*/
      if ((scan = kbd_gsc()) == 0xf0) {/*Release*/
        if ((scan = kbd_gsc()) == 0x7c) {
	  if (kbd_gsc() == 0xe0)
            if (kbd_gsc() == 0xf0)
  	      if (kbd_gsc() == 0x12) {
                graph = /*TODO: Print Screen*/;
		break;
	      }
	}
	else {
	  graph = kbd_scan_table_1[scan];
	  break;
	}
      }
      else if (scan == 0x12)
        if (kbd_gsc() == 0xe0)
          kbd_gsc();
    }
    else if (scan == 0xe1)
      if (kbd_gsc() == 0x14)
        if (kbd_gsc() == 0x77)
  	  if (kbd_gsc() == 0xe1)
	    if (kbd_gsc() == 0xf0)
	      if (kbd_gsc() == 0x14)
	        if (kbd_gsc() == 0xf0)
		  if (kbd_gsc() == 0x77) {
		    graph = /*TODO: Pause*/;
		    break;
		  }
  }
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
