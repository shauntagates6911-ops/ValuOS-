#ifndef VALUOS_MEMORY_H
#define VALUOS_MEMORY_H

#include <stdint.h>

/* Physical memory info */
#define PAGE_SIZE 4096

/* Paging structures */
typedef uint32_t page_table_entry;
typedef uint32_t page_directory_entry;

/* Initialize memory system */
void mem_init();

/* Allocate one 4KB page */
void* alloc_page();

/* Free a 4KB page */
void free_page(void* addr);

/* Map virtual → physical */
void map_page(uint32_t virt, uint32_t phys);

/* Unmap virtual address */
void unmap_page(uint32_t virt);

/* Enable paging */
void enable_paging();

/* Simple memset + memcpy */
void* kmemset(void* dest, uint8_t value, uint32_t size);
void* kmemcpy(void* dest, const void* src, uint32_t size);

#endif
