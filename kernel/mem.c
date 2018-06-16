#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

/*Copyright 2018 Benji Dial
  Portland memory management*/

#define MEM_BLOCK_SIZE ((size_t)32)
#define MEM_POOL_LEN ((size_t)/*TODO*/)
#define MEM_AR_START ((bool *)/*TODO*/)
#define MEM_AR_END ((bool *)/*TODO*/)
#define MEM_POOL_START ((void *)/*TODO*/)

bool *mem_next_ar;

void mem_clear(void) {
  for (mem_next_ar = MEM_AR_START; mem_next_ar < MEM_AR_END; mem_next_ar++)
    *mem_next_ar = false;
  mem_next_ar = MEM_AR_START;
}

void *mem_alloc_block(void) {
  if (*mem_next_ar) {
    bool *origin = mem_next_ar;
    while (++mem_next_ar < MEM_AR_END)
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
  void *ret = &MEM_POOL_START[mem_next_ar];
  mem_next_ar++;
  return ret;
}

void mem_dealloc_block(void *ptr) {
  MEM_AR_START[(ptr - MEM_POOL_START) / MEM_BLOCK_SIZE] = false;
}
