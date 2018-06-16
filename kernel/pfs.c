#include <stdint.h>
#include <stddef.h>

/*Copyright 2018 Benji Dial
  Portland PFS driver*/

struct pfs_record {
  uint32_t position;
  uint16_t size;
  uint8_t sectors;
  uint8_t name[45];
}

struct pfs_file {
  uint16_t file_id
  uint16_t length;
  struct pfs_header header;
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
/*29 bytes so far*/
/*Spaces as padding at end,
  no spaces during name,
  space at start for free sectors*/
  uint8_t name[45];
};

struct pfs_record *pfs_records = (struct pfs_record */*TODO*/);
uint16_t pfs_n_records;

void pfs_init(uint8_t drive_id) {
  
}

struct pfs_file *pfs_open(uint8_t *name) {
  /*TODO*/
}

void pfs_close(struct pfs_file *file) {
  
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

void pfs_exec(uint8_t *path) {
  struct pfs_file *file = pfs_open(path);
  /*TODO: Allocate buffer*/
  pfs_read(file, file->length, buffer);
  pfs_close(file);
  /*TODO: Jump into buffer*/
  /*TODO: Deallocate buffer*/
}

void pfs_del(uint8_t *path) {
  /*TODO*/
}

void pfs_flush(struct pfs_file *file) {
  /*TODO*/
}
