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
  * [`fat_del`](#fat_del)

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
* `uint8_t **contents`

This is a type representing a directory in a FAT16 drive.  The first `n_dirs` entries in `contents` are null-terminated strings representing sub-directories.  The remaining `n_contents - n_dirs` entries are null-terminated strings representing files.  These strings are not qualified with paths.

## `fat_open`
Signature: `struct fat_file *(uint8_t *)`

This opens the file at the path provided and returns a pointer to the [`struct fat_file`](#fat_file) representing it.

## `fat_close`
Signature: `void (struct fat_file *)`

This closes the provided file.  Further use of a [`struct fat_file`](#fat_file) once it has been closed causes undefined behavior.

## `fat_seek`
Signature: `void (struct fat_file *, FAT_POS)`

This seeks within the specified file to the position specified.

## `fat_read`
Signature: `void (struct fat_file *, size_t, uint8_t *)`

This reads the specified number of bytes out of the current position of the provided file into the beginning of the provided buffer.

## `fat_write`
Signature: `void (struct fat_file *, size_t, uint8_t *)`

This writes the specified number of bytes from the beginning of the provided buffer to the current position of the provided file.

## `fat_exec`
Signature: `void (uint8_t *)`

This opens, loads, closes, executes and unloads the file at the specified path.

## `fat_dir_info`
Signature: `struct fat_dir (uint8_t *)`

This returns a [`struct fat_dir`](#fat_dir) listing the contents of the directory at the specified path.

## `fat_del`
Signature: `void (uint8_t *)`

This deletes the file or directory at the specified path.

---
**[Back to index](index)**
