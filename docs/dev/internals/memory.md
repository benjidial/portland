# Memory management documentation
## Listing
* Constants
  * [`MEM_AR_START`](#mem_ar_start)
  * [`MEM_BLOCK_SIZE`](#mem_block_size)
  * [`MEM_POOL_LEN`](#mem_pool_len)
  * [`MEM_POOL_START`](#mem_pool_start)
  * [`MEM_POOL_END`](#mem_pool_end)
* Variables
  * [`mem_next_ar`](#mem_next_ar)
* Functions
  * [`mem_clear`](#mem_clear)
  * [`mem_alloc_block`](#mem_alloc_block)
  * [`mem_dealloc_block`](#mem_dealloc_block)

---
## `MEM_AR_START`
Value: `/*TODO*/`

This defines the starting point in memory of the allocation record.  The allocation record is composed of a boolean for each block in the pool describing whether or not that block is allocated.

## `MEM_BLOCK_SIZE`
Value: `/*TODO*/`

This defines the size of a block in bytes.

## `MEM_POOL_LEN`
Value: `MEM_POOL_LEN`

This defines the size of the memory pool in bytes.

## `MEM_POOL_START`
Value: `(MEM_AR_START + MEM_POOL_LEN * sizeof(bool) / MEM_BLOCK_SIZE)`

This defines the start of the memory pool.  It is placed at the end of the allocation record.  For a description of the allocation record, see [`MEM_AR_START`](#mem_ar_start).

## `MEM_POOL_END`
Value: `(MEM_POOL_START + MEM_POOL_LEN)`

This defines the end of the memory pool.

## `mem_next_ar`
Type: `bool *`

This keeps track of the next entry in the allocation record for [`mem_alloc_block`](#mem_alloc_block) to try.  For a description of the allocation record, see [`MEM_AR_START`](#mem_ar_start).

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
