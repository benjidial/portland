# FAT16 driver documentation
## Listing
* Structures
  * [`fat_file`](#fat_file)
* Functions
  * [`fat_open`](#fat_open)
  * [`fat_close`](#fat_close)
  * [`fat_seek`](#fat_seek)
  * [`fat_read`](#fat_read)
  * [`fat_write`](#fat_write)

---
## `fat_file`

## `fat_open`
Signature: `struct fat_file *fat_open(char *name)`

## `fat_close`
Signature: `void fat_close(struct fat_file *file)`

## `fat_seek`
Signature: `void fat_seek(struct fat_file *file, /*TODO*/ position)`

## `fat_read`
Signature: `void fat_read(struct fat_file *file, size_t count, uint8_t *buffer)`

## `fat_write`
Signature: `void fat_write(struct fat_file *file, size_t count, uint8_t *buffer)`

---
**[Back to index](index)**
