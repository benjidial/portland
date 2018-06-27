#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include "vga.c"

/*Portland PS/2 keyboard driver
  Copyright 2018 Benji Dial
  Under Gnu Public License 3.0*/

extern uint8_t *kbd_scan_table_0;
extern uint8_t *kbd_scan_table_1;
extern uint8_t *kbd_shift_table;
extern uint8_t *kbd_caps_table;
uint16_t kbd_status = 0;
#define KBD_LEFT_ALT 32768
#define KBD_LEFT_SHIFT 16384
#define KBD_LEFT_CONTROL 8192
#define KBD_RIGHT_SHIFT 4096
#define KBD_RIGHT_ALT 2048
#define KBD_RIGHT_CONTROL 1024
#define KBD_LEFT_SUPER 512
#define KBD_RIGHT_SUPER 256
#define KBD_CAPS_LOCK 128
#define KBD_NUM_LOCK 64
#define KBD_SCROLL_LOCK 32

inline uint8_t kbd_mod(uint8_t ch) {
  uint8_t intermediate = (kbd_status & KBD_CAPS_LOCK) ? kbd_caps_table[ch] : ch;
  return (kbd_status & (KBD_LEFT_SHIFT | KBD_RIGHT_SHIFT)) ? kbd_shift_table[ch] : ch;
}

uint8_t kbd_gch(bool print) {
  uint8_t graph;
get_key:
  uint8_t scan = kbd_gsc();
  switch (scan) {
  case 0x11:/*Left alt*/
    kbd_status |= KBD_LEFT_ALT;
    goto get_key;
  case 0x12:/*Left shift*/
    kbd_status |= KBD_LEFT_SHIFT;
    goto get_key;
  case 0x14:/*Left control*/
    kbd_status |= KBD_LEFT_CONTROL;
    goto get_key;
  case 0x59:/*Right shift*/
    kbd_status |= KBD_RIGHT_SHIFT;
    goto get_key;
  case 0xe0:/*Second table*/
    scan = kbd_gsc();
    switch (scan) {
    case 0x11:/*Right alt*/
      kbd_status |= KBD_RIGHT_ALT;
      goto get_key;
    case 0x12:
      if (kbd_gsc() == 0xe0)
        if (kbd_gsc() == 0x7c) {/*Print screen*/
          /*TODO*/
          graph = /*TODO*/;
          break;
        }
      goto get_key;/*Unrecognized scancode*/
    case 0x14:/*Right control*/
      kbd_status |= KBD_RIGHT_CONTROL;
      goto get_key;
    case 0x1f:/*Left super*/
      kbd_status |= KBD_LEFT_SUPER;
      goto get_key;
    case 0x27:/*Right super*/
      kbd_status |= KBD_RIGHT_SUPER;
      goto get_key;
    default:
      graph = kbd_scancode_table_1[scan];
      goto get_key;
    }
  case 0xe1:/*Pause*/
    if (kbd_gsc() == 0x14)
      if (kbd_gsc() == 0x77)
        if (kbd_gsc() == 0xe1)
          if (kbd_gsc() == 0xf0)
            if (kbd_gsc() == 0x14)
              if (kbd_gsc() == 0xf0)
                if (kbd_gsc() == 0x77) {
                  /*TODO*/
                  return /*TODO*/;
                }
    goto get_key;/*Unrecognized scancode*/
  case 0xf0:/*Release*/
    switch (kbd_gsc()) {
    case 0x59:/*Right shift*/
      kbd_status ^= KBD_RIGHT_SHIFT;
      goto get_key;
    default:
      goto get_key;/*Ignore release of normal key*/
    }
  }
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
