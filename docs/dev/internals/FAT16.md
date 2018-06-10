# FAT16 driver documentation
## Listing
* Constants
  * [`FAT_POS`](#fat_pos)
* Structures
  * [`fat_file`](#fat_file)
  * [`fat_dir`](#fat_dir)
* Functions
  * [`fat_open`](#fat_open)
  * [`fat_close`](#fat_close)
  * [`fat_seek`](#fat_seek)
  * [`fat_read`](#fat_read)
  * [`fat_write`](#fat_write)
  * [`fat_exec`](#fat_exec)
  * [`fat_dir_info`](#fat_dir_info)

---
## `FAT_POS`
Value: `/*TODO*/`

This is the type of the integral value used to represent a position in a FAT16 file.

## `fat_file`
Members:
* `FAT_POS length`
* `/*TODO*/`

This is a type representing an open FAT16 file.

## `fat_dir`
Members:
* `size_t n_contents`
* `size_t n_dirs`
* `char **contents`

This is a type representing a directory in a FAT16 drive.  The first `n_dirs` entries in `contents` are null-terminated strings representing sub-directories.  The remaining `n_contents - n_dirs` entries are null-terminated strings representing files.  These strings are not qualified with paths.

## `fat_open`
Signature: `struct fat_file *fat_open(char *path)`

This opens the FAT16 file at `path` and returns a pointer to the [`fat_file`](#fat_file) representing it.

## `fat_close`
Signature: `void fat_close(struct fat_file *file)`

This closes the FAT16 file referenced by `file`.  Further use of `file` once it has been closed causes undefined behavior.

## `fat_seek`
Signature: `void fat_seek(struct fat_file *file, FAT_POS position)`

This seeks within the file referenced by `file` to the position specified.

## `fat_read`
Signature: `void fat_read(struct fat_file *file, size_t count, uint8_t *buffer)`

This reads `count` bytes out of the current position of the file referenced by `file` into the beginning of `buffer`.

## `fat_write`
Signature: `void fat_write(struct fat_file *file, size_t count, uint8_t *buffer)`

This writes `count` bytes from the beginning of `buffer` to the current position of the file referenced by `file`.

## `fat_exec`
Signature: `void fat_exec(char *path)`

This opens, loads, closes, executes and unloads the file at `path`.

## `fat_dir_info`
Signature: `struct fat_dir fat_dir_info(char *path)`

This returns a [`struct fat_dir`](#fat_dir) listing the contents of the directory at `path`.

---
**[Back to index](index)**
