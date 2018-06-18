#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

/*Copyright 2018 Benji Dial
  Portland memory management*/

#define MEM_POOL_START ((void *)0x4000)
#define MEM_POOL_END ((void *)(0xffff + 1))

struct mem_record {
  void *start;
  uint16_t length;
  struct mem_record *next;
  bool allocated;
}

struct mem_record *mem_next;

void mem_init(void) {
  mem_next = /*TODO*/;
  mem_next->start = MEM_POOL_START;
  mem_next->length = MEM_POOL_END - MEM_POOL_START;
  mem_next->next = mem_next;
  mem_next->allocated = false;
}

bool mem_find_block(uint16_t length) {
  struct mem_record *origin = mem_next;
  do {
    if (!mem_next->allocated && mem_next->length >= length)
      return true;
    mem_next = mem_next->next;
  } while (mem_next != origin);
  return false;
}

void *mem_alloc_block(uint16_t length) {
  if (!mem_find_block(length)) {
    /*TODO: Consolidate adjacent records*/
    if (!mem_find_block(length))
      return NULL;
  }
  if (mem_next->length == length) {
    mem_next->allocated = true;
    void *ret = mem_next->start;
    mem_next = mem_next->next;
    return ret;
  } else {
    mem_next->allocated = true;
    void *ret = mem_next->start;
    struct mem_record *old_next = mem_next->next;
    uint16_t old_length = mem_next->length;
    mem_next->length = length;
    struct mem_record *new = /*TODO*/;
    new->start = mem_next->start + length;
    new->length = old_length - length;
    new->next = old_next;
    new->allocated = false;
    return ret;
  }
}

void mem_dealloc_block(void *ptr) {
  while (mem_next->start != ptr)
    mem_next = mem_next->next;
  mem_next->allocated = false;
}
