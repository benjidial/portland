#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

/*Copyright 2018 Benji Dial
  Portland memory management*/

#define MEM_POOL_START ((void *)0x4000)
#define MEM_POOL_END ((void *)(0xffff))

struct mem_record {
  void *start;
  uint16_t length;
  struct mem_record *next;
  bool allocated;
}

#define MEM_RECORDS_PER_LINK 10

struct mem_record_link {
  struct mem_record records[MEM_RECORDS_PER_LINK];
  struct mem_record_link *next;
}

struct mem_record *mem_next;
struct mem_record *mem_last;
uint16_t mem_n_records;
struct mem_record_link mem_chain_start;
struct mem_record_link *mem_chain_end;

struct mem_record *mem_alloc_record(void) {
  struct mem_record *ret = &(mem_chain_end->records[mem_n_records % MEM_RECORDS_PER_LINK]);
  if (!(++mem_n_records % MEM_RECORDS_PER_LINK))
    mem_chain_end = mem_chain_end->next = malloc(sizeof(mem_record_link));
  return ret;
}

inline void mem_init(void) {
  mem_last = mem_next = mem_alloc_record();
  mem_next->start = MEM_POOL_START;
  mem_next->length = MEM_POOL_END - MEM_POOL_START + 1;
  mem_next->next = mem_next;
  mem_next->allocated = false;
}

inline bool mem_find(uint16_t length) {
  struct mem_record *origin = mem_next;
  do {
    if (!mem_next->allocated && mem_next->length >= length)
      return true;
    mem_next = mem_next->next;
  } while (mem_next != origin);
  return false;
}

void *mem_alloc(uint16_t length) {
  if (!mem_find(length)) {
    struct mem_record_link *link = &mem_chain_start;
    uint16_t i = 0;
    while ((i += MEM_RECORDS_PER_LINK) <= mem_n_records) {
      for (int j = 0; j < MEM_RECORDS_PER_LINK; j++) {
        void *end = link->records[j].start + 
      }
    }
    if (!mem_find(length))
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
    struct mem_record *new = mem_alloc_record();
    new->start = mem_next->start + length;
    new->length = old_length - length;
    new->next = old_next;
    new->allocated = false;
    return ret;
  }
}

void mem_dealloc(void *ptr) {
  while (mem_next->start != ptr)
    mem_next = mem_next->next;
  mem_next->allocated = false;
}
