# Kernel documentation
## Main routine
The kernel, at the moment, simply  
1. [Clears the display](VGA#vga_clear)
2. [Initializes the dynamic memory driver](memory#mem_init)
3. [Initializes the file system driver](PFS#pfs_init)
4. [Sets up the interrupt vector table](IVT#ivt_init)
4. [Executes a file](PFS#pfs_exec)

## Components
* [File system driver](PFS)
* [Interrupt vector table](IVT)
* [Keyboard driver](keyboard)
* [Memory management](memory)
* [VGA driver](VGA)

---
**[Back to index](index)**
