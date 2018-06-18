#include <stdint.h>
#include <stddef.h>

/*Copyright 2018 Benji Dial
  Portland PFS driver*/

struct pfs_file {
  uint8_t file_id;
  uint16_t length;
  uint16_t position;
  uint8_t *contents;
};

struct pfs_header {
  /*0 for this version*/
  uint16_t version;
  uint16_t size;
  uint8_t sectors;
  /*UNIX timestamps*/
  uint64_t create_time;
  uint64_t last_flush_time;
  uint64_t last_open_time;
  /*NUL-terminated string,
    empty for free sectors*/
  uint8_t name[45];
};

/*Sector number of each header*/
#define pfs_files ((uint64_t *)0x0600)
#define pfs_n_files (*(uint8_t *)0x0404)

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

void pfs_init(uint8_t drive_id);

uint8_t pfs_get_header(uint8_t *name, pfs_header *header) {
  /*TODO*/
}

struct pfs_file *pfs_open(uint8_t *name) {
  pfs_header header;
  struct pfs_file *ret = mem_alloc(sizeof(pfs_file));
  ret->file_id = pfs_get_header(name, &header);
  ret->length = header.size;
  ret->position = 0;
  ret->contents = (uint8_t *)mem_alloc(512 * header.sectors);
  pfs_read_sectors(pfs_files[ret->file_id] + 1, header.sectors, ret->contents);
  return file;
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
  struct pfs_file *file = pfs_open(path);
  asm volatile (
    "call %(file->contents)"
  );
  pfs_close(file);
}

void pfs_del(uint8_t *name) {
  pfs_header header;
  uint64_t sector = pfs_get_header(name, &header);
  header.name[0] = '\0';
  pfs_write_sectors(sector, 1, &header);
}

void pfs_flush(struct pfs_file *file) {
  /*TODO*/
}
