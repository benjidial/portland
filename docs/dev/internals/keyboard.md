# Keyboard driver documentation
## Listing
* Functions
  * [`kbd_sc2ch`](#kbd_sc2ch)
  * [`kbd_gsc`](#kbd_gsc)
  * [`kbd_gch`](#kbd_gch)
  * [`kbd_gln`](#kbd_gln)

---
## `kbd_sc2ch`
Signature: `uint8_t (uint8_t)`

This converts a scancode into the appropriate character.

## `kbd_gsc`
Signature: `uint8_t (void)`

This obtains the scancode representing the next keypress.

## `kbd_gch`
Signature: `uint8_t (bool)`

This obtains the character representing the keypress.  The boolean passed determines whether or not to print the character as well using [`vga_pch`](VGA#vga_pch).

## `kbd_gln`
Signature: `void (uint8_t *, bool)`

This reads characters up to and not including a newline into the buffer provided, appending a null character.  Backspaces cancel out the preceeding character.  The boolean passed determines whether or not to print each character as well using [`vga_pch`](VGA#vga_pch).

---
**[Back to index](index)**
