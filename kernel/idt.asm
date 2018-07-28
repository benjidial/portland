;Portland IDT
;Copyright 2018 Benji Dial
;Under GNU GPL v3.0

%include "int.asm"
%macro IDT_ENTRY 1
  dw %1 % 0x10000
  dd 0x0e000008
  dw %1 / 0x10000
%endmacro
idt:

IDT_ENTRY int_null;0x00: divide by zero
IDT_ENTRY int_null;0x01: debug
IDT_ENTRY int_null;0x02: NMI
IDT_ENTRY int_null;0x03: breakpoint
IDT_ENTRY int_null;0x04: overflow
IDT_ENTRY int_null;0x05: bound range exceeded
IDT_ENTRY int_null;0x06: invalid opcode
IDT_ENTRY int_null;0x07: device not available
IDT_ENTRY int_null;0x08: double fault
IDT_ENTRY int_null;0x09: coprocessor segment overrun
IDT_ENTRY int_null;0x0a: invalid TSS
IDT_ENTRY int_null;0x0b: segment not present
IDT_ENTRY int_null;0x0c: stack-segment fault
IDT_ENTRY int_null;0x0d: general protection fault
IDT_ENTRY int_null;0x0e: page fault
IDT_ENTRY int_null;0x0f: Intel reserved
IDT_ENTRY int_null;0x10: x87 FPU exception
IDT_ENTRY int_null;0x11: alignment check
IDT_ENTRY int_null;0x12: machine check
IDT_ENTRY int_null;0x13: SIMD FPU exception
IDT_ENTRY int_null;0x14: virtualization exception
IDT_ENTRY int_null;0x15: Intel reserved
IDT_ENTRY int_null;0x16: Intel reserved
IDT_ENTRY int_null;0x17: Intel reserved
IDT_ENTRY int_null;0x18: Intel reserved
IDT_ENTRY int_null;0x19: Intel reserved
IDT_ENTRY int_null;0x1a: Intel reserved
IDT_ENTRY int_null;0x1b: Intel reserved
IDT_ENTRY int_null;0x1c: Intel reserved
IDT_ENTRY int_null;0x1d: Intel reserved
IDT_ENTRY int_null;0x1e: security exception
IDT_ENTRY int_null;0x1f: FPU error

IDT_ENTRY int_null;0x20: PIT
IDT_ENTRY int_kbd;0x21: keyboard
IDT_ENTRY int_null;0x22: cascade
IDT_ENTRY int_null;0x23: COM2
IDT_ENTRY int_null;0x24: COM1
IDT_ENTRY int_null;0x25: LPT2
IDT_ENTRY int_null;0x26: floppy
IDT_ENTRY int_null;0x27: LPT1
IDT_ENTRY int_null;0x28: CMOS clock
IDT_ENTRY int_null;0x29: peripheral
IDT_ENTRY int_null;0x2a: peripheral
IDT_ENTRY int_null;0x2b: peripheral
IDT_ENTRY int_null;0x2c: mouse
IDT_ENTRY int_null;0x2d: FPU
IDT_ENTRY int_null;0x2e: ATA1
IDT_ENTRY int_null;0x2f: ATA2

times 16 IDT_ENTRY int_null;0x30 - 0x3f: portland reserved

IDT_ENTRY int_file_read;0x40: read from a file
IDT_ENTRY int_file_write;0x41: write to a file
IDT_ENTRY int_file_create;0x42: create and open a file
IDT_ENTRY int_file_open;0x43: open a file
IDT_ENTRY int_file_resize;0x44: resize a file
IDT_ENTRY int_file_delete;0x45: delete a file
IDT_ENTRY int_file_exec;0x46: run a file
IDT_ENTRY int_file_info;0x47: get info about a file

IDT_ENTRY int_print_byte;0x48: print byte
IDT_ENTRY int_print_word;0x49: print word
IDT_ENTRY int_print_bytes;0x4a: print byte string
IDT_ENTRY int_print_words;0x4b: print word string
IDT_ENTRY int_clear_screen;0x4c: clear screen
IDT_ENTRY int_set_style;0x4d: set color
IDT_ENTRY int_move_cursor;0x4e: move cursor
IDT_ENTRY null;0x4f: portland reserved

IDT_ENTRY int_kbd_char;0x50: get character from keyboard
IDT_ENTRY int_kbd_string;0x51: get string from keyboard
IDT_ENTRY int_kbd_line;0x52: get line from keyboard
IDT_ENTRY int_kbd_fake_char;0x53: put a character in the keyboard buffer
IDT_ENTRY int_kbd_fake_string;0x54: put a string in the keyboard buffer
IDT_ENTRY null;0x55: portland reserved
IDT_ENTRY null;0x56: portland reserved
IDT_ENTRY null;0x57: portland reserved

IDT_ENTRY int_mem_alloc;0x58: allocate memory
IDT_ENTRY int_mem_dealloc;0x59: deallocate memory
IDT_ENTRY int_mem_check;0x5a: check available memory
IDT_ENTRY null;0x5b: portland reserved
IDT_ENTRY null;0x5c: portland reserved
IDT_ENTRY null;0x5d: portland reserved
IDT_ENTRY null;0x5e: portland reserved
IDT_ENTRY null;0x5f: portland reserved

time (0xff-0x5f) IDT_ENTRY null;0x60 - 0xff: portland reserved
