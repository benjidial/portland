# Interrupt vector table documentation
## Notes
You may want to read <https://en.wikipedia.org/wiki/Interrupt_vector_table> before reading this page.  If you are looking for a listing of the interrupts available to developers of applications for portland, see <https://negative-four-potatoes.github.io/portland/dev/externals/interrupts>.

## Listing
* Constants
  * [`IVT_START`](#ivt_start)
* Functions
  * [`ivt_set_up`](#ivt_set_up)

---
## `IVT_START`
Value: `0x0`

This defines the start of the IVT.  We are using `0x0`, since it requires the least setup.

## `ivt_set_up`
Signature: `void ivt_set_up(void)`

This sets up the IVT.

---
**[Back to index](index)**
