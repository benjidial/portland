#include <stdint.h>
#include <stddef.h>

/*Copyright 2018 Benji Dial
  Portland FAT16 driver*/

struct fat_file {
  /*TODO*/
};

struct fat_file *fat_open(char *name) {
  /*TODO*/
}

void fat_close(struct fat_file *file) {
  /*TODO*/
}

void fat_seek(struct fat_file *file, /*TODO*/ position) {
  /*TODO*/
}

void fat_read(struct fat_file *file, size_t count, uint8_t *buffer) {
  /*TODO*/
}

void fat_write(struct fat_file *file, size_t count, uint8_t *buffer) {
  /*TODO*/
}
