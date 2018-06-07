# Internals documentation
## What's where
| Component                   | Location in `src/` | Name in source |
| --------------------------- | ------------------ | -------------- |
| [Bootloader](bootloader)    | `boot.asm`         | `_start`       |
| Grub config                 | `grub.cfg`         | N/A            |
| [Kernel](kernel)            | `kernel`           | N/A            |
| Kernel entry point          | `kernel/main.c`    | `_main`        |
| Linker script               | `link.ld`          | N/A            |
| [Memory management](memory) | `kernel/mem.c`     | `mem_*`        |
| [Text-mode I/O](screen)     | `kernel/scr.c`     | `scr_*`        |
