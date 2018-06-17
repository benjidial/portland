#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

/*Copyright 2018 Benji Dial
  Portland memory management*/

#define MEM_BLOCK_SIZE ((size_t)32)
#define MEM_BLOCK_COUNT 0x600
#define MEM_POOL_START ((void *)0x4000)

bool mem_ars[MEM_BLOCK_COUNT];

size_t mem_next_ar;

void mem_clear(void) {
  for (mem_next_ar = 0; mem_next_ar < MEM_BLOCK_COUNT; mem_next_ar++)
    mem_ars[mem_next_ar] = false;
  mem_next_ar = 0;
}

void *mem_alloc_block(void) {
  if (mem_ars[mem_next_ar]) {
    size_t origin = mem_next_ar;
    while (++mem_next_ar < MEM_BLOCK_COUNT)
      if (!mem_ars[mem_next_ar])
        goto foundBlock;
    mem_next_ar = -1;
    while (++mem_next_ar < origin)
      if (!mem_ars[mem_next_ar])
        goto foundBlock;
    return (void *)0x05e0;
  }

foundBlock:
  mem_ars[mem_next_ar] = true;
  return MEM_POOL_START + mem_next_ar++ * MEM_BLOCK_SIZE;
}

void mem_dealloc_block(void *ptr) {
  mem_ars[(ptr - MEM_POOL_START) / MEM_BLOCK_SIZE] = false;
}
