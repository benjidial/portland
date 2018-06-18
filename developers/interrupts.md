# Interrupt listing
## Notes
See also [the Portland C Library](https://github.com/negative-four-potatoes/portland-c-library).  The inline assembly shows examples of how to call these from assembly, and using the library makes calling these from C much easier and less bulky.  If you are looking for the internal workings of interrupts for contributors to the portland project, see <https://negative-four-potatoes.github.io/portland/contributors/IVT>.

## Listing
* [Memory management](#memory-management)
* [VGA driver](#vga-driver)
* [PFS driver](#pfs-driver)
* [Other](#other)

---
## Memory management
* 0x80: [Allocate](../contributors/memory#mem_alloc)
* 0x81: [Deallocate](../contributors/memory#mem_dealloc)
* 0x82 - 0x87: Reserved

## VGA driver
* 0x88: Set [position](../contributors/VGA#vga_pos)  
  Signature: `void (uint16_t)`
* 0x89: Get [position](../contributors/VGA#vga_pos)  
  Signature: `uint16_t (void)`
* 0x8a: Set [mask](../contributors/VGA#vga_mask)  
  Signature: `void (uint16_t)`
* 0x8b: Get [mask](../contributors/VGA#vga_mask)  
  Signature: `uint16_t (void)`
* 0x8c: [Clear](../contributors/VGA#vga_clear)
* 0x8d: [Print character](../contributors/VGA#vga_pch)
* 0x8e: [Print null-terminated string](../contributors/VGA#vga_psz)
* 0x8f: Get word from [buffer](../contributors/VGA#vga_buf)  
  Signature: `uint16_t (uint16_t)`

## PFS driver
* 0x90: [Open](../contributors/PFS#pfs_open)
* 0x91: [Close](../contributors/PFS#pfs_close)
* 0x92: [Seek](../contributors/PFS#pfs_seek)
* 0x93: [Read](../contributors/PFS#pfs_read)
* 0x94: [Write](../contributors/PFS#pfs_write)
* 0x95: [Execute](../contributors/PFS#pfs_exec)
* 0x96: [Flush](../contributors/PFS#pfs_flush)
* 0x97: [Delete](../contributors/PFS#pfs_del)

## Keyboard driver
* 0x98: [Get next scancode](../contributors/keyboard#kbd_gsc)
* 0x99: [Get next character](../contributors/keyboard#kbd_gch)
* 0x9a: [Get next line](../contributors/keyboard#kbd_gln)
* 0x9b - 0x9f: Reserved

## Other
* 0xa0 - 0xff: Reserved

---
**[Back to index](index)**
