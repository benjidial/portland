# VGA driver documentation
## Notes
You may want to read <https://en.wikipedia.org/wiki/VGA-compatible_text_mode> before reading this page.

## Listing
* Constants
  * [`VGA_BUF`](#vga_buf)
* Variables
  * [`vga_pos`](#vga_pos)
  * [`vga_mask`](#vga_mask)
* Functions
  * [`vga_clear`](#vga_clear)
  * [`vga_pch`](#vga_pch)
  * [`vga_psz`](#vga_psz)

---
## `VGA_BUF`
Value: `(uint16_t *)0xb8000`

This is a pointer to the start of the VGA text buffer.

## `vga_pos`
Type: `size_t`

`vga_pos` stores the position of the next character to be written on the screen in the form row \* 80 + column.  [`VGA_BUF`](#vga_buf) can be indexed with this value to find the relevant word.  At the kernel's start, this is set to zero.

## `vga_mask`
Type: `uint16_t`

This is used to keep track of the upper byte of the next word to be written into [`VGA_BUF`](#vga_buf).  The lower byte of this should always be set to 0.

## `vga_clear`
Signature: `void vga_clear(uint16_t mask)`

This clears the screen, setting each character to a space masked with `mask` and setting [`vga_pos`](#vga_pos) to 0.  The low byte of `mask` should always be 0.  For example, to clear the screen with a black background and a white foreground, call `vga_clear(0x0700)`.

## `vga_pch`
Signature: `void vga_pch(uint8_t ch)`

This prints a single character, masked by [`vga_mask`](#vga_mask) to the position defined by [`vga_pos`](#vga_pos), incrementing `vga_pos`.

## `vga_psz`
Signature: `void vga_psz(uint8_t *sz)`

This calls [`vga_pch`](#vga_pch) on each character of a null-terminated string.

---
**[Back to index](index)**
