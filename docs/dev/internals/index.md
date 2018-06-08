# Internals documentation
## What's where
[Bootloader](bootloader)
: `boot.asm` (`_start`)

Grub config
: `grub.cfg`

[Kernel](kernel)
: `kernel`

Kernel entry point
: `kernel/main.c` (`_main`)

Linker script
: `link.ld`

[Memory management](memory)
: `kernel/mem.c` (`mem_*`)

[Text-mode I/O](screen)
: `kernel/scr.c` (`scr_*`)
