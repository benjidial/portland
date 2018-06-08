# Text-mode I/O documentation
## Listing
* [`scr_pos`](#scr_pos)
* [`scr_buf`](#scr_buf)
* [`scr_mask`](#scr_mask)
* [`scr_clear`](#src_clear)
* [`scr_inchar`](#scr_inchar)
* [`scr_outchar`](#scr_outchar)
* [`scr_instr`](#scr_instr)
* [`scr_outstr`](#scr_outstr)

---
## `scr_pos`
Signature: `size_t scr_pos`

`scr_pos` stores the position of the next character to be written on the screen in the form row \* 80 + column.  At the kernel's start, this is set to zero.

## `scr_buf`
Signature: `volatile const uint16_t *scr_buf`

`scr_buf` is a pointer to the address 0xb8000.  This address is the start of the VGA text buffer.  For more information, see <https://en.wikipedia.org/wiki/VGA-compatible_text_mode>.

## `scr_mask`
Signature: `uint16_t scr_mask`

This is used to keep track of the upper byte of the next word to be written into `scr_buf`.  The lower byte of this should always be set to 0.  For more information, see <https://en.wikipedia.org/wiki/VGA-compatible_text_mode#Text_buffer>.

## `scr_clear`
Signature: `void scr_clear(uint16_t mask)`

The clears the screen, setting each character to a space masked with `mask` and setting `scr_pos` to 0.  The low byte of `mask` should always be 0.  For example, to clear the screen with a black background and a white foreground, call `scr_clear(0x0700)`.  For more information about `mask`'s format, see <https://en.wikipedia.org/wiki/VGA-compatible_text_mode#Text_buffer>.
