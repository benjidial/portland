#include <stdint.h>
#include <stddef.h>

/*Copyright 2018 Benji Dial
  Portland PFS driver*/

struct pfs_file {
  uint64_t header;
  uint64_t sector;
  uint16_t length;
  uint16_t position;
  uint8_t *contents;
};

struct pfs_header {
  /*UNIX timestamps*/
  int64_t create_time;
  int64_t last_flush_time;
  int64_t last_open_time;
  uint64_t position;
  uint16_t size;
  /*NUL-terminated string,
    empty for free sectors*/
  uint8_t name[478];
};

struct {
  uint8_t sixteen;
  uint8_t zero;
  uint16_t n_sectors;
  uint16_t offset;
  uint16_t segment;
  uint64_t sector;
} pfs_dap = {
  .sixteen = 16,
  .zero = 0,
  .segment = 0
};

inline void pfs_read_sectors(uint64_t sector, uint16_t n_sectors, uint8_t *buffer) {
  asm volatile (
    "mov ah, 0x42\n"
    ";TODO: dl\n"
    "xor ds, ds\n"
    "mov si, %(&pfs_dap)\n"
    "mov [%(&pfs_dap.sector)], %(sector)\n"
    "mov [%(&pfs_dap.n_sectors)], %(n_sectors)\n"
    "mov [%(&pfs_dap.offset)], %(buffer)\n"
    "int 0x13"
  );
}

inline void pfs_write_sectors(uint64_t sector, uint16_t n_sectors, uint8_t *buffer) {
  asm volatile (
    "mov ah, 0x43\n"
    ";TODO\n"
    "int 0x13"
  );
}

uint64_t pfs_get_header(uint8_t *name, pfs_header *header) {
  uint64_t sector = 0;
  do {
    pfs_read_sectors(++sector, 1, header);
    for (int i = 0; i < 478; i++)
      if (header->name[i] != name[i])
        continue;
    return sector;
  } while (pfs_header->position);
  return 0;
}

struct pfs_file *pfs_open(uint8_t *name) {
  pfs_header header;
  struct pfs_file *ret = mem_alloc(sizeof(pfs_file));
  ret->header = pfs_get_header(name, &header);
  ret->sector = header.sector;
  ret->position = 0;
  pfs_read_sectors(ret->sector, header.size / 512, ret->contents = (uint8_t *)mem_alloc(((((ret->length = header.size) - 1) / 512) + 1 ) * 512));
  return ret;
}

void pfs_close(struct pfs_file *file) {
  mem_dealloc(file->contents);
  mem_dealloc(file);
}

void pfs_seek(struct pfs_file *file, uint16_t position) {
  file->position = position;
}

void pfs_read(struct pfs_file *file, uint16_t count, uint8_t *buffer) {
  for (uint16_t i = 0; i < count; i++)
    buffer[i] = file->contents[file->position++];
}

void pfs_write(struct pfs_file *file, uint16_t count, uint8_t *buffer) {
  for (uint16_t i = 0; i < count; i++)
    file->contents[file->position++] = buffer[i];
}

void pfs_exec(uint8_t *name) {
  struct pfs_file *file = pfs_open(name);
  asm volatile (
    "call %(file->contents)"
  );
  pfs_close(file);
}

void pfs_del(uint8_t *name) {
  /*TODO*/
}

void pfs_flush(struct pfs_file *file) {
  /*TODO*/
}
