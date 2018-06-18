# File system driver documentation
## Listing
* Structures
  * [`pfs_file`](#pfs_file)
  * [`pfs_header`](#pfs_header)
* Constants
  * [`pfs_files`](#pfs_files)
  * [`pfs_n_files`](#pfs_n_files)
* Variables
  * [`pfs_dap`](#pfs_dap)
* Functions
  * [`pfs_read_sectors`](#pfs_read_sectors)
  * [`pfs_write_sectors`](#pfs_write_sectors)
  * [`pfs_get_header`](#pfs_get_header)
  * [`pfs_init`](#pfs_init)
  * [`pfs_open`](#pfs_open)
  * [`pfs_close`](#pfs_close)
  * [`pfs_seek`](#pfs_seek)
  * [`pfs_read`](#pfs_read)
  * [`pfs_write`](#pfs_write)
  * [`pfs_exec`](#pfs_exec)
  * [`pfs_del`](#pfs_del)
  * [`pfs_flush`](#pfs_flush)

---
## `pfs_file`
Members:
* `uint8_t file_id`
* `uint16_t length`
* `uint16_t position`
* `uint8_t *contents`

This is a type representing an open PFS file.

## `pfs_header`
Members:
* `uint16_t version`
* `uint16_t size`
* `uint8_t sectors`
* `int64_t create_time`
* `int64_t last_flush_time`
* `int64_t last_open_time`
* `uint8_t name[45]`

This is a 512-byte header to be put before files on a disk.  The version word, for Portland v0.2.0, should be `0x0000`.  All times are 64-bit [UNIX timestamps](https://en.wikipedia.org/wiki/Unix_time).  The `name` field is a null-terminated string.  An empty string in the `name` field means the following sectors are free.

## `pfs_files`
Value: `((uint64_t *)0x0600)`

This is a pointer to an array of up to 256 sector numbers of [file headers](#pfs_header).

## `pfs_n_files`
Value: `(*(uint8_t *)0x0404)`

This is the number of elements in the array pointed to by [`pfs_files`](#pfs_files).

## `pfs_dap`
Type: [Disk Address Packet](https://wiki.osdev.org/ATA_in_x86_RealMode_%28BIOS%29#LBA_in_Extended_Mode)

This is a DAP to be used when reading from and writing to the disk.

## `pfs_read_sectors`
Signature: `inline void (uint64_t, uint16_t, uint8_t *)`

TODO

## `pfs_write_sectors`
Signature: `inline void (uint64_t, uint16_t, uint8_t *)`

TODO

## `pfs_init`
Signature: `void (void)`

This populates [`pfs_files`](#pfs_files) and [`pfs_n_files`](#pfs_n_files).

## `pfs_get_header`
Signature: `uint8_t (uint8_t *, struct pfs_header *)`

This populates the provided [header structure](#struct-pfs_header) with the header of the file by the name specified, returning an index useful with [`pfs_files`](#pfs_files).

## `pfs_open`
Signature: `struct pfs_file *(uint8_t *)`

This opens the file with the name provided and returns a pointer to a [`struct pfs_file`](#pfs_file) representing it.  Uses of this function without corresponding later uses of [`pfs_close`](#pfs_close) will leak memory.

## `pfs_close`
Signature: `void (struct pfs_file *)`

This closes the provided file, deallocating relevant memory allocated by [`pfs_open`](#pfs_open).

## `pfs_seek`
Signature: `void (struct pfs_file *, uint16_t)`

This seeks within the specified file to the position specified.

## `pfs_read`
Signature: `void (struct pfs_file *, uint16_t, uint8_t *)`

This reads the specified number of bytes out of the current position of the provided file into the beginning of the provided buffer.

## `pfs_write`
Signature: `void (struct pfs_file *, uint16_t, uint8_t *)`

This writes the specified number of bytes from the beginning of the provided buffer to the current position of the provided file.  Calls to this function do not affect the actual file unless [`pfs_flush`](#pfs_flush) is called afterward.

## `pfs_exec`
Signature: `void (uint8_t *)`

This [opens](#pfs_open) a file, calls its start and then [closes](#pfs_close) the file.

## `pfs_del`
Signature: `void (uint8_t *)`

This deletes the file or directory at the specified path.

## `pfs_flush`
Signature: `void (struct pfs_file *)`

This writes changes in a file to the disk.

---
**[Back to index](index)**
