# Memory management documentation
## Listing
* Constants
  * [`MEM_POOL_START`](#mem_pool_start)
  * [`MEM_POOL_END`](#mem_pool_end)
* Structures
  * [`mem_record`](#struct-mem_record)
* Variables
  * [`mem_next`](#mem_next)
* Functions
  * [`mem_init`](#mem_init)
  * [`mem_find`](#mem_find)
  * [`mem_alloc`](#mem_alloc)
  * [`mem_dealloc`](#mem_dealloc)

---
## `MEM_POOL_START`
Value: `((void *)0x4000)`

This defines the start of the memory pool, as defined in [the layout](layout).

## `MEM_POOL_END`
Value: `((void *)(0xffff + 1))`

This defines one past the end of the memory pool, as defined in [the layout](layout).

## `struct mem_record`
Members:  
* `void *start`
* `uint16_t length`
* `struct mem_record *next`
* `bool allocated`

TODO

## `mem_next`
Type: `struct mem_record *`

This keeps track of the next memory record for [`mem_find`](#mem_find) or [`mem_dealloc`](#mem_dealloc) to check.

## `mem_init`
Signature: `void (void)`

This sets [`mem_next`](#mem_next) to a deallocated record filling the entire dynamic memory region.

## `mem_find`
Signature: `inline bool (uint16_t)`

This is a helper function for [`mem_alloc`](#mem_alloc) to try to find a free memory region of at least the specified size in bytes.

## `mem_alloc`
Signature: `void * (uint16_t)`

This tries to allocate new memory of the length specified in bytes.  If it can, a pointer to the start is returned.  Otherwise, a null pointer is.

## `mem_dealloc`
Signature: `void (void *)`

This deallocates the memory specified.

---
**[Back to index](index)**
