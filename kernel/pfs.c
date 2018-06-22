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

struct pfs_dap {
  uint8_t sixteen;
  uint8_t zero;
  uint16_t n_sectors;
  uint16_t offset;
  uint16_t segment;
  uint64_t sector;
};

struct pfs_dap *pfs_dap_ptr = (pfs_dap *)0x0404;
uint8_t *pfs_drive_id_ptr = (uint8_t *)0x0414;

inline void pfs_init(void) {
  pfs_dap_ptr->sixteen = 16;
  pfs_dap_ptr->zero = 0;
  pfs_dap_ptr->segment = 0;
}

inline void pfs_read_sectors(uint64_t sector, uint16_t n_sectors, uint8_t *buffer) {
  asm volatile (
    "movb $0x42, %ah\n"
    "movb [$0x0414], %dh;pfs_drive_id\n"
    "xor %ds, %ds\n"
    "movw $0x0404, %si;pfs_dap\n"
    "movq %sector, [$0x040c]\n"
    "movw %n_sectors, [$0x0406]\n"
    "movw %buffer, [$0x0408]\n"
    "int $0x13"
  );
}

inline void pfs_write_sectors(uint64_t sector, uint16_t n_sectors, uint8_t *buffer) {
  asm volatile (
    "movb $0x43, %ah\n"
    "movb [$0x0414], %dh;pfs_drive_id\n"
    "xor %ds, %ds\n"
    "movw $0x0404, %si;pfs_dap\n"
    "movq %sector, [$0x040c]\n"
    "movw %n_sectors, [$0x0406]\n"
    "movw %buffer, [$0x0408]\n"
    "int $0x13"
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
