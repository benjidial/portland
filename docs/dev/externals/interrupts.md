# Interrupt listing
## Notes
For information on how to call C functions from assembly, see <>.  Just replace the `call` instruction with an `int` instruction.  If you are looking for the internal workings for contributors to the portland project, see <https://negative-four-potatoes.github.io/portland/dev/internals/IVT>.

## Listing
* [Memory management](#memory-management)
* [VGA driver](#vga-driver)
* [FAT16 driver](#fat16-driver)
* [Other](#other)

---
## Memory management
* 0x80: [Allocate block](../internals/memory#mem_alloc_block)
* 0x81: [Deallocate block](../internals/memory#mem_dealloc_block)
* 0x82 - 0x8f: Reserved

## VGA driver
* 0x90: [Set position](../internals/VGA#vga_pos)
* 0x91: [Get position](../internals/VGA#vga_pos)
* 0x92: [Set mask](../internals/VGA#vga_mask)
* 0x93: [Get mask](../internals/VGA#vga_mask)
* 0x94: [Clear](../internals/VGA#vga_clear)
* 0x95: [Print character](../internals/VGA#vga_pch)
* 0x96: [Print null-terminated string](../internals/VGA#vga_psz)
* 0x97 - 0x9f: Reserved

## FAT16 driver
* 0xa0: [Open](../internals/FAT16#fat_open)
* 0xa1: [Close](../internals/FAT16#fat_close)
* 0xa2: [Seek](../internals/FAT16#fat_seek)
* 0xa3: [Read](../internals/FAT16#fat_read)
* 0xa4: [Write](../internals/FAT16#fat_write)
* 0xa5 - 0xaf: Reserved

## Other
* 0xb0 - 0xff: Reserved

---
**[Back to index](index)**
