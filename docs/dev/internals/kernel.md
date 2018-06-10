# Kernel documentation
## Main routine
The kernel, at the moment, simply  
1. [sets up the IVT](#IVT#ivt_set_up)
2. [clears the memory](memory#mem_clear)
3. [clears the screen](VGA#vga_clear)
4. [executes](FAT16#fat_exec) the file named "SHELL"
5. halts

## Components
* [FAT16 driver](FAT16)
* [Keyboard driver](keyboard)
* [Memory management](memory)
* [VGA driver](VGA)

---
**[Back to index](index)**
