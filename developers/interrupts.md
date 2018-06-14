# Interrupt listing
## Notes
For some examples on how to use these interrupts from assembly see [the first version of the portland shell](https://github.com/negative-four-potatoes/portland-shell/tree/v0.1.0).  It uses the VGA driver's print null-terminated string interrupt (0x8e), the Keyboard driver's get next line interrupt (0x9a) and the USTAR driver's execute file interrupt (0x95).  See also [the Portland C Library](https://github.com/negative-four-potatoes/portland-c-library).  The inline assembly shows examples of how to call these from assembly, and using the library makes calling these from C much easier and less bulky.  If you are looking for the internal workings of interrupts for contributors to the portland project, see <https://negative-four-potatoes.github.io/portland/contributors/IVT>.

## Listing
* [Memory management](#memory-management)
* [VGA driver](#vga-driver)
* [USTAR driver](#tar16-driver)
* [Other](#other)

---
## Memory management
* 0x80: [Allocate block](../contributors/memory#mem_alloc_block)
* 0x81: [Deallocate block](../contributors/memory#mem_dealloc_block)
* 0x82 - 0x87: Reserved

## VGA driver
* 0x88: [Set position](../contributors/VGA#vga_pos)
* 0x89: [Get position](../contributors/VGA#vga_pos)
* 0x8a: [Set mask](../contributors/VGA#vga_mask)
* 0x8b: [Get mask](../contributors/VGA#vga_mask)
* 0x8c: [Clear](../contributors/VGA#vga_clear)
* 0x8d: [Print character](../contributors/VGA#vga_pch)
* 0x8e: [Print null-terminated string](../contributors/VGA#vga_psz)
* 0x8f: [Get word from buffer](../contributors/VGA#vga_buf)

## USTAR driver
* 0x90: [Open](../contributors/USTAR#tar_open)
* 0x91: [Close](../contributors/USTAR#tar_close)
* 0x92: [Seek](../contributors/USTAR#tar_seek)
* 0x93: [Read](../contributors/USTAR#tar_read)
* 0x94: [Write](../contributors/USTAR#tar_write)
* 0x95: [Execute](../contributors/USTAR#tar_exec)
* 0x96: Reserved
* 0x97: [Delete file or directory](../contributors/USTAR#tar_del)

## Keyboard driver
* 0x98: [Get next scancode](../contributors/keyboard#kbd_gsc)
* 0x99: [Get next character](../contributors/keyboard#kbd_gch)
* 0x9a: [Get next line](../contributors/keyboard#kbd_gln)
* 0x9b - 0x9f: Reserved

## Other
* 0xa0 - 0xff: Reserved

---
**[Back to index](index)**
