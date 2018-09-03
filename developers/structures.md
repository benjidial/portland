# Structures
## Listing
* [File](#file)
* [Keycode](#keycode)

---
## Byte string
A null-terminated array of bytes representing a string in the ASCII encoding.

Examples:  
```C
uint8_t *myString = "this is a string";//C and C++
```
```Assembly
myString db "this is a string", 0;NASM
```

## File
A 8-byte structure used in calls to `file_read` and `file_write`.  Use `file_open` or `file_create` to get one.
```C
struct {
  uint16_t header_sector_number;
  uint8_t storage_device_id;
  uint8_t reserved[5];
}
```

## File info
A 512-byte structure representing information about a file, and returned by `file_info`.  See [byte string](#byte-string) for the structure of the last 485 bytes.  Any information past the null-terminator is to be considered garbage.
```C
struct {
  int64_t creation_time;
  int64_t last_write_time;
  int64_t last_read_time;
  uint16_t file_length;
  uint8_t reserved_sectors;
  uint8_t file_name[485];
}
```

## Keycode
See [keycode table](../contributors/keycodes.txt)

## Word string
A null-terminated array of words representing a string with color information.  The upper byte of each word is color, and the lower byte is an ASCII character.  The null terminator only needs the lower byte to be null.

Examples:
```C
uint8_t *myString = "I\x0f"//C and C++
                    "n\x0f"
                    " \x0f"
                    "c\x0a"
                    "o\x0a"
                    "l\x0a"
                    "o\x0a"
                    "r\x0a"
                    "!\x0f"
                    "\0";
```
```Assembly
myString db "I", 0x0f, "n", 0x0f, " ", 0x0f, "c", 0x0a;NASM
         db "o", 0x0a, "l", 0x0a, "o", 0x0a, "r", 0x0a
         db "!", 0x0f, 0x00, 0x00
```

---
**[Back to index](index)**
