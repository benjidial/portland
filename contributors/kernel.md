# Kernel documentation
## Main routine
The kernel, at the moment, simply  
1. [sets up](IVT#ivt_set_up) the IVT
2. [clears](memory#mem_clear) the memory
3. [clears](VGA#vga_clear) the screen
4. [executes](USTAR#tar_exec) the file named "shell"
5. halts

## Components
* [USTAR driver](USTAR)
* [Interrupt vector table](IVT)
* [Keyboard driver](keyboard)
* [Memory management](memory)
* [VGA driver](VGA)

---
**[Back to index](index)**
