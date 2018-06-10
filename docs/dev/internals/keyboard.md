# Keyboard driver documentation
## Listing
* Structures
  * [`kbd_packet`](#kbd_packet)
* Functions
  * [`kbd_packet_to_graph`](#kbd_packet_to_graph)
  * [`kbd_gkp`](#kbd_gkp)
  * [`kbd_gch`](#kbd_gch)
  * [`kbd_gln`](#kbd_gln)

---
## `kbd_packet`
Members:
* `/*TODO*/`

This contains all the information necessary to interpret a keypress.

## `kbd_packet_to_graph`
Signature: `uint8_t (struct kbd_packet)`

This converts a [`kbd_packet`](#kbd_packet) into the appropriate character.

## `kbd_gkp`
Signature: `struct kbd_packet (void)`

This obtains the [`kbd_packet`](#kbd_packet) representing the next keypress.

## `kbd_gch`
Signature: `uint8_t (bool)`

This obtains the character representing the keypress.  The boolean passed determines whether or not to print the character as well using [`vga_pch`](VGA#vga_pch).

## `kbd_gln`
Signature: `void (uint8_t *, bool)`

This reads characters up to and not including a newline into the buffer provided, appending a null character.  Backspaces cancel out the preceeding character.  The boolean passed determines whether or not to print each character as well using [`vga_pch`](VGA#vga_pch).
