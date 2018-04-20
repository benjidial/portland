#include <stdint.h>

#include "libc/string.h"

/*Adapted from http://www.jamesmolloy.co.uk/tutorial_html/4.-The%20GDT%20and%20IDT.html*/

struct gdt_entry {
   uint16_t limit_low;
   uint16_t base_low; 
   uint8_t base_middle;
   uint8_t access;
   uint8_t granularity;
   uint8_t base_high;
} __attribute__ ((packed));

struct gdt_ptr {
   uint16_t limit;
   uint32_t base;
} __attribute__ ((packed));

struct idt_entry {
  uint16_t base_low;
  uint16_t selector;
  uint8_t zero;
  uint8_t flags;
  uint16_t base_high;
} __attribute__ ((packed));

struct idt_ptr {
  uint16_t limit;
  uint32_t base;
} __attribute__ ((packed));

extern void gdt_flush(uint32_t);
extern void idt_flush(uint32_t);

struct gdt_entry gdt_entries[5];
struct gdt_ptr gdt_ptr;
struct idt_entry idt_entries[256];
struct idt_ptr idt_ptr;

#define gdt_set_gate(num, base, limit, access, gran) \
  gdt_entries[num].base_low    = (base & 0xFFFF);\
  gdt_entries[num].base_middle = (base >> 16) & 0xFF;\
  gdt_entries[num].base_high   = (base >> 24) & 0xFF;\
  gdt_entries[num].limit_low   = (limit & 0xFFFF);\
  gdt_entries[num].granularity = ((limit >> 16) & 0x0F) | (gran & 0xF0);\
  gdt_entries[num].access      = access;

void init_gdt(void) {
  gdt_ptr.limit = 39;
  gdt_ptr.base = (uint32_t)&gdt_entries;
  gdt_set_gate(0, 0, 0x00000000, 0x00, 0x00);
  gdt_set_gate(1, 0, 0xFFFFFFFF, 0x9A, 0xCF);
  gdt_set_gate(2, 0, 0xFFFFFFFF, 0x92, 0xCF);
  gdt_set_gate(3, 0, 0xFFFFFFFF, 0xFA, 0xCF);
  gdt_set_gate(4, 0, 0xFFFFFFFF, 0xF2, 0xCF);
  gdt_flush((uint32_t)&gdt_ptr);
}

#define idt_set_gate(num, base, sel, flags) \
  idt_entries[num].base_low  = base & 0xFFFF;\
  idt_entries[num].base_high = (base >> 16) & 0xFFFF;\
  idt_entries[num].selector  = sel;\
  idt_entries[num].zero      = 0x00;\
  idt_entries[num].flags     = flags/* | 0x60 <- Set ring to 3 */;

void init_idt(void) {
   idt_ptr.limit = 2047;
   idt_ptr.base = (uint32_t)&idt_entries;
   memset(&idt_entries, 0, 2048);
   idt_set_gate( 0, (uint32_t)isr0,  0x08, 0x8E); idt_set_gate( 1, (uint32_t)isr1,  0x08, 0x8E);
   idt_set_gate( 2, (uint32_t)isr2,  0x08, 0x8E); idt_set_gate( 3, (uint32_t)isr3,  0x08, 0x8E);
   idt_set_gate( 4, (uint32_t)isr4,  0x08, 0x8E); idt_set_gate( 5, (uint32_t)isr5,  0x08, 0x8E);
   idt_set_gate( 6, (uint32_t)isr6,  0x08, 0x8E); idt_set_gate( 7, (uint32_t)isr7,  0x08, 0x8E);
   idt_set_gate( 8, (uint32_t)isr8,  0x08, 0x8E); idt_set_gate( 9, (uint32_t)isr9,  0x08, 0x8E);
   idt_set_gate(10, (uint32_t)isr10, 0x08, 0x8E); idt_set_gate(11, (uint32_t)isr11, 0x08, 0x8E);
   idt_set_gate(12, (uint32_t)isr12, 0x08, 0x8E); idt_set_gate(13, (uint32_t)isr13, 0x08, 0x8E);
   idt_set_gate(14, (uint32_t)isr14, 0x08, 0x8E); idt_set_gate(15, (uint32_t)isr15, 0x08, 0x8E);
   idt_set_gate(16, (uint32_t)isr16, 0x08, 0x8E); idt_set_gate(17, (uint32_t)isr17, 0x08, 0x8E);
   idt_set_gate(18, (uint32_t)isr18, 0x08, 0x8E); idt_set_gate(19, (uint32_t)isr19, 0x08, 0x8E);
   idt_set_gate(20, (uint32_t)isr20, 0x08, 0x8E); idt_set_gate(21, (uint32_t)isr21, 0x08, 0x8E);
   idt_set_gate(22, (uint32_t)isr22, 0x08, 0x8E); idt_set_gate(23, (uint32_t)isr23, 0x08, 0x8E);
   idt_set_gate(24, (uint32_t)isr24, 0x08, 0x8E); idt_set_gate(25, (uint32_t)isr25, 0x08, 0x8E);
   idt_set_gate(26, (uint32_t)isr26, 0x08, 0x8E); idt_set_gate(27, (uint32_t)isr27, 0x08, 0x8E);
   idt_set_gate(28, (uint32_t)isr28, 0x08, 0x8E); idt_set_gate(29, (uint32_t)isr29, 0x08, 0x8E);
   idt_set_gate(30, (uint32_t)isr30, 0x08, 0x8E); idt_set_gate(31, (uint32_t)isr31, 0x08, 0x8E);
}

extern void isr0();  extern void isr1();  extern void isr2();  extern void isr3();
extern void isr4();  extern void isr5();  extern void isr6();  extern void isr9();
extern void isr8();  extern void isr9();  extern void isr10(); extern void isr11();
extern void isr12(); extern void isr13(); extern void isr14(); extern void isr15();
extern void isr16(); extern void isr17(); extern void isr18(); extern void isr19();
extern void isr20(); extern void isr21(); extern void isr22(); extern void isr23();
extern void isr24(); extern void isr25(); extern void isr26(); extern void isr27();
extern void isr28(); extern void isr29(); extern void isr30(); extern void isr31();
