# Interrupt listing
## Notes
For some examples on how to use these interrupts from assembly, see [the portland shell](https://github.com/negative-four-potatoes/portland/blob/master/src/shell/shell.asm).  It uses the VGA driver's print null-terminated string interrupt (0x8e), the Keyboard driver's get next line interrupt (0x9a) and the FAT16 driver's execute file interrupt (0x95).  If you are looking for the internal workings of interrupts for contributors to the portland project, see <https://negative-four-potatoes.github.io/portland/dev/internals/IVT>.

## Listing
* [Memory management](#memory-management)
* [VGA driver](#vga-driver)
* [FAT16 driver](#fat16-driver)
* [Other](#other)

---
## Memory management
* 0x80: [Allocate block](../internals/memory#mem_alloc_block)
* 0x81: [Deallocate block](../internals/memory#mem_dealloc_block)
* 0x82 - 0x87: Reserved

## VGA driver
* 0x88: [Set position](../internals/VGA#vga_pos)
* 0x89: [Get position](../internals/VGA#vga_pos)
* 0x8a: [Set mask](../internals/VGA#vga_mask)
* 0x8b: [Get mask](../internals/VGA#vga_mask)
* 0x8c: [Clear](../internals/VGA#vga_clear)
* 0x8d: [Print character](../internals/VGA#vga_pch)
* 0x8e: [Print null-terminated string](../internals/VGA#vga_psz)
* 0x8f: [Get word from buffer](../internals/VGA#vga_buf)

## FAT16 driver
* 0x90: [Open](../internals/FAT16#fat_open)
* 0x91: [Close](../internals/FAT16#fat_close)
* 0x92: [Seek](../internals/FAT16#fat_seek)
* 0x93: [Read](../internals/FAT16#fat_read)
* 0x94: [Write](../internals/FAT16#fat_write)
* 0x95: [Execute](../internals/FAT16#fat_exec)
* 0x96: [Get directory contents](../internals/FAT16#fat_dir_info)
* 0x97: [Delete file or directory](../internals/FAT16#fat_del)

## Keyboard driver
* 0x98: [Get next scancode](../internals/keyboard#kbd_gsc)
* 0x99: [Get next character](../internals/keyboard#kbd_gch)
* 0x9a: [Get next line](../internals/keyboard#kbd_gln)
* 0x9b - 0x9f: Reserved

## Other
* 0xa0 - 0xff: Reserved

---
**[Back to index](index)**
