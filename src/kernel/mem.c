#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

/*Copyright 2018 Benji Dial
  Portland memory management*/

#define MEM_AR_START /*TODO*/
#define MEM_BLOCK_SIZE /*TODO*/
#define MEM_POOL_LEN /*TODO*/

#define MEM_POOL_START (MEM_AR_START + MEM_POOL_LEN * sizeof(bool) / MEM_BLOCK_SIZE)
#define MEM_POOL_END (MEM_POOL_START + MEM_POOL_LEN)

bool *mem_next_ar;

void mem_clear(void) {
  for (mem_next_ar = MEM_AR_START; mem_next_ar < MEM_POOL_START; mem_next_ar++)
    *mem_next_ar = false;
  mem_next_ar = MEM_AR_START;
}

void *mem_alloc_block(void) {
  if (*mem_next_ar) {
    bool *origin = mem_next_ar;
    while (++mem_next_ar < MEM_POOL_START)
      if (!*mem_next_ar)
        goto foundBlock;
    mem_next_ar = MEM_AR_START - 1;
    while (++mem_next_ar < origin)
      if (!*mem_next_ar)
        goto foundBlock;
    return NULL;
  }

foundBlock:
  *mem_next_ar = true;
  void *ret = MEM_POOL_START + MEM_POOL_LEN * (mem_next_ar - MEM_AR_START);
  mem_next_ar++;
  return ret;
}

void mem_dealloc_block(void *ptr) {
  *(MEM_AR_START + (ptr - MEM_POOL_START) / MEM_BLOCK_SIZE) = false;
}
