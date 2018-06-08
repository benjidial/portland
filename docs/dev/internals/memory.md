# Text-mode I/O documentation
## Listing
* [`mem_alloc`](#mem_alloc)
* [`mem_dealloc`](#mem_dealloc)

---
## `mem_alloc`
Signature: `void *mem_alloc(size_t bytes)`

This tries to allocate a block of memory of the specified size, returning a pointer to the start of the block if successful.  Behavior if unsuccessful is to be defined.

## `mem_dealloc`
Signature: `void mem_dealloc(void *ptr)`

This deallocates the specified block of memory.  If the block is not allocated, or is allocated to a different process, nothing is done.

---
**[Back to index](index)**
