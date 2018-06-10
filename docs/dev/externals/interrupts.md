# Interrupt listing
## Notes
For some examples on how to use these interrupts from assembly, see [the portland shell](https://github.com/negative-four-potatoes/portland/blob/master/src/shell/shell.asm).  It uses the VGA driver's print null-terminated string interrupt (0x96), the Keyboard driver's get next line interrupt (0xb2) and the FAT16 driver's execute file interrupt (0xa5).  If you are looking for the internal workings of interrupts for contributors to the portland project, see <https://negative-four-potatoes.github.io/portland/dev/internals/IVT>.

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
* 0xa5: [Execute](../internals/FAT16#fat_exec)
* 0xa6: [Get directory contents](../internals/FAT16#fat_dir_info)
* 0xa7 - 0xaf: Reserved

## Keyboard driver
* 0xb0: [Get next raw key](../internals/keyboard#kbd_grk)
* 0xb1: [Get next character](../internals/keyboard#kbd_gch)
* 0xb2: [Get next line](../internals/keyboard#kbd_gsz)
* 0xb3 - 0xbf: Reserved

## Other
* 0xc0 - 0xff: Reserved

---
**[Back to index](index)**
