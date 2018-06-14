# USTAR driver documentation
## Listing
* Constants
  * [`TAR_POS`](#tar_pos)
* Structures
  * [`tar_file`](#tar_file)
  * [`tar_dir`](#tar_dir)
* Functions
  * [`tar_open`](#tar_open)
  * [`tar_close`](#tar_close)
  * [`tar_seek`](#tar_seek)
  * [`tar_read`](#tar_read)
  * [`tar_write`](#tar_write)
  * [`tar_exec`](#tar_exec)
  * [`tar_dir_info`](#tar_dir_info)
  * [`tar_del`](#tar_del)

---
## `TAR_POS`
Value: `/*TODO*/`

This is the type of the integral value used to represent a position in a USTAR file.

## `tar_file`
Members:
* `TAR_POS length`
* `/*TODO*/`

This is a type representing an open USTAR file.

## `tar_dir`
Members:
* `size_t n_contents`
* `size_t n_dirs`
* `uint8_t **contents`

This is a type representing a directory in a USTAR drive.  The first `n_dirs` entries in `contents` are null-terminated strings representing sub-directories.  The remaining `n_contents - n_dirs` entries are null-terminated strings representing files.  These strings are not qualified with paths.

## `tar_open`
Signature: `struct tar_file *(uint8_t *)`

This opens the file at the path provided and returns a pointer to the [`struct tar_file`](#tar_file) representing it.

## `tar_close`
Signature: `void (struct tar_file *)`

This closes the provided file.  Further use of a [`struct tar_file`](#tar_file) once it has been closed causes undefined behavior.

## `tar_seek`
Signature: `void (struct tar_file *, TAR_POS)`

This seeks within the specified file to the position specified.

## `tar_read`
Signature: `void (struct tar_file *, size_t, uint8_t *)`

This reads the specified number of bytes out of the current position of the provided file into the beginning of the provided buffer.

## `tar_write`
Signature: `void (struct tar_file *, size_t, uint8_t *)`

This writes the specified number of bytes from the beginning of the provided buffer to the current position of the provided file.

## `tar_exec`
Signature: `void (uint8_t *)`

This opens, loads, closes, executes and unloads the file at the specified path.

## `tar_dir_info`
Signature: `struct tar_dir (uint8_t *)`

This returns a [`struct tar_dir`](#tar_dir) listing the contents of the directory at the specified path.

## `tar_del`
Signature: `void (uint8_t *)`

This deletes the file or directory at the specified path.

---
**[Back to index](index)**
