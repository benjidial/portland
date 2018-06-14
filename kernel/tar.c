#include <stdint.h>
#include <stddef.h>

/*Copyright 2018 Benji Dial
  Portland USTAR driver*/

#define TAR_POS /*TODO*/

struct tar_file {
  TAR_POS length;
  /*TODO*/
};

struct tar_dir {
  size_t n_contents;
  size_t n_dirs;
  uint8_t **contents;
};

struct tar_file *tar_open(uint8_t *path) {
  /*TODO*/
}

void tar_close(struct tar_file *file) {
  /*TODO*/
}

void tar_seek(struct tar_file *file, TAR_POS position) {
  /*TODO*/
}

void tar_read(struct tar_file *file, size_t count, uint8_t *buffer) {
  /*TODO*/
}

void tar_write(struct tar_file *file, size_t count, uint8_t *buffer) {
  /*TODO*/
}

void tar_exec(uint8_t *path) {
  struct tar_file *file = tar_open(path);
  /*Allocate buffer*/
  tar_read(file, file->length, buffer);
  tar_close(file);
  /*Jump into buffer*/
  /*Deallocate buffer*/
}

struct tar_dir tar_dir_info(uint8_t *path) {
  /*TODO*/
}

void tar_del(uint8_t *path) {
  /*TODO*/
}
