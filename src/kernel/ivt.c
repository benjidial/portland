#include <stddef.h>
#include <stdint.h>

/*Copyright 2018 Benji Dial
  Portland interrupt vector table*/

#define IVT_START (struct ivt_entry *)0x0

struct ivt_entry {
  uint16_t segment;
  uint16_t offset;
};

void ivt_set_up(void) {
  /*TODO*/
}
