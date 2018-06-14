#include <stdint.h>
#include <stddef.h>

/*Copyright 2018 Benji Dial
  Portland USTAR driver*/

#define read_from_drive /*For planning until I figure out how this works*/
#define write_to_drive /*For planning until I figure out how this works*/

#define TAR_FILE_POS_T /*TODO: at least 36 bits*/
#define TAR_DISK_POS_T /*TODO*/

#define TAR_NORMAL 0
#define TAR_HARD 1
#define TAR_SYM 2
#define TAR_CHAR 3
#define TAR_BLOCK 4
#define TAR_DIR 5
#define TAR_PIPE 6

struct tar_file {
  TAR_FILE_POS_T length;
  struct tar_header header;
  TAR_DISK_POS_T position;
  uint8_t *contents; /*TODO: Buffer based on position*/
};

struct tar_header {
  uint8_t name[100];
  uint64_t mode;
  uint64_t owner_id;
  uint64_t group_id;
  uint8_t size[12];
  uint8_t last_mod[12];
  uint64_t checksum;
  uint8_t type;
  uint8_t link_name[100];
  uint8_t magic[6];
  uint8_t version[2];
  uint8_t owner_name[32];
  uint8_t group_name[32];
  uint64_t device_upper;
  uint64_t device_lower;
  uint8_t path[155];
};

struct tar_dir {
  TAR_DISK_POS_T header;
  size_t n_subdirs;
  struct tar_dir *subdirs;
  size_t n_files;
  TAR_DISK_POS_T *file_headers;
}

void tar_set_up_tree(void) {
  /*TODO*/
}

struct tar_file *tar_open(uint8_t *path) {
  /*TODO*/
}

void tar_close(struct tar_file *file) {
  /*TODO*/
}

void tar_seek(struct tar_file *file, TAR_FILE_POS_T position) {
  file->position = position;
  /*This will need to be updated when file->contents is upgraded.*/
}

void tar_read(struct tar_file *file, size_t count, uint8_t *buffer) {
  for (size_t i = 0; i < count; i++)
    buffer[i] = file->contents[file->position++];
  /*This will need to be updated when file->contents is upgraded.*/
}

void tar_write(struct tar_file *file, size_t count, uint8_t *buffer) {
  for (size_t i = 0; i < count; i++)
    file->contents[file->position++] = buffer[i];
  /*This will need to be updated when file->contents is upgraded.*/
}

void tar_exec(uint8_t *path) {
  struct tar_file *file = tar_open(path);
  /*TODO: Allocate buffer*/
  tar_read(file, file->length, buffer);
  tar_close(file);
  /*TODO: Jump into buffer*/
  /*TODO: Deallocate buffer*/
}

void tar_del(uint8_t *path) {
  /*TODO*/
}

void tar_flush(struct tar_file *file) {
  /*TODO*/
}
