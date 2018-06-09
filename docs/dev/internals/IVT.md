# Interrupt vector table documentation
## Notes
You may want to read <https://en.wikipedia.org/wiki/Interrupt_vector_table> before reading this page.  If you are looking for a listing of the interrupts available to developers on Portland, see <negative-four-potatoes.github.io/portland/dev/externals/interrupts>.

## Listing
* Constants
  * [`IVT_START`](#ivt_start)
* Structures
  * [`ivt_entry`](#ivt_entry)
* Functions
  * [`ivt_set_up`](#ivt_set_up)

---
## `IVT_START`
Value: `(struct ivt_entry *)0x0`

This defines the start of the IVT.  We are using `0x0`, since it requires the least setup.

## `ivt_entry`
Members:
* `uint16_t segment`
* `uint16_t offset`

This is the structure of an entry in the IVT.

## `mem_clear`
Signature: `void mem_clear(void)`

This deallocates all memory blocks, setting each entry in the allocation record to `false`.

## `mem_alloc_block`
Signature: `void *mem_alloc_block(void)`

This tries to allocate a new memory block.  If it can, a pointer to that block is returned.  Otherwise, a null pointer is.

## `mem_dealloc_block`
Signature: `void mem_dealloc_block(void *ptr)`

This deallocates the memory block pointed to by `ptr`.  If this block is already deallocated, nothing is changed.

---
**[Back to index](index)**
