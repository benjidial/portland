# VGA driver documentation
## Listing
* Variables
  * [`vga_pos`](#vga_pos)
  * [`vga_buf`](#vga_buf)
  * [`vga_mask`](#vga_mask)
* Functions
  * [`vga_clear`](#vga_clear)
  * [`vga_pch`](#vga_pch)
  * [`vga_psz`](#vga_psz)

---
## `vga_pos`
Signature: `size_t vga_pos`

`vga_pos` stores the position of the next character to be written on the screen in the form row \* 80 + column.  [`vga_buf`](#vga_buf) can be indexed with this value to find the relevant word.  At the kernel's start, this is set to zero.

## `vga_buf`
Signature: `volatile const uint16_t *vga_buf`

`vga_buf` is a pointer to the address 0xb8000.  This address is the start of the VGA text buffer.  For more information, see <https://en.wikipedia.org/wiki/VGA-compatible_text_mode>.

## `vga_mask`
Signature: `uint16_t vga_mask`

This is used to keep track of the upper byte of the next word to be written into [`vga_buf`](#vga_buf).  The lower byte of this should always be set to 0.  For more information, see <https://en.wikipedia.org/wiki/VGA-compatible_text_mode#Text_buffer>.

## `vga_clear`
Signature: `void vga_clear(uint16_t mask)`

This clears the screen, setting each character to a space masked with `mask` and setting [`vga_pos`](#vga_pos) to 0.  The low byte of `mask` should always be 0.  For example, to clear the screen with a black background and a white foreground, call `vga_clear(0x0700)`.  For more information about `mask`'s format, see <https://en.wikipedia.org/wiki/VGA-compatible_text_mode#Text_buffer>.

## `vga_pch`
Signature: `void vga_pch(uint8_t ch)`

This prints a single character, masked by [`vga_mask`](#vga_mask) to the position defined by [`vga_pos`](#vga_pos), incrementing `vga_pos`.

## `vga_psz`
Signature: `void vga_psz(uint8_t *sz)`

This calls [`vga_pch`](#vga_pch) on each character of a null-terminated string.

---
**[Back to index](index)**
