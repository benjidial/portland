#include <stdint.h>
#include <stddef.h>

/*Copyright 2018 Benji Dial
  Portland FAT16 driver*/

#define FAT_POS /*TODO*/

struct fat_file {
  FAT_POS length;
  /*TODO*/
};

struct fat_dir {
  size_t n_contents;
  size_t n_dirs;
  char **contents;
};

struct fat_file *fat_open(char *path) {
  /*TODO*/
}

void fat_close(struct fat_file *file) {
  /*TODO*/
}

void fat_seek(struct fat_file *file, FAT_POS position) {
  /*TODO*/
}

void fat_read(struct fat_file *file, size_t count, uint8_t *buffer) {
  /*TODO*/
}

void fat_write(struct fat_file *file, size_t count, uint8_t *buffer) {
  /*TODO*/
}

void fat_exec(char *path) {
  struct fat_file *file = fat_open(path);
  /*Allocate buffer*/
  fat_read(file, file->length, buffer);
  fat_close(file);
  /*Jump into buffer*/
  /*Deallocate buffer*/
}

struct fat_dir fat_dir_info(char *path) {
  /*TODO*/
}
