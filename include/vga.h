#ifndef VALUOS_VGA_H
#define VALUOS_VGA_H

#include <stdint.h>

/* VGA text mode memory */
#define VGA_MEMORY 0xB8000
#define VGA_WIDTH 80
#define VGA_HEIGHT 25

/* VGA color attributes */
enum VGA_COLOR {
    VGA_BLACK = 0,
    VGA_BLUE = 1,
    VGA_GREEN = 2,
    VGA_CYAN = 3,
    VGA_RED = 4,
    VGA_MAGENTA = 5,
    VGA_BROWN = 6,
    VGA_LIGHT_GREY = 7,
    VGA_DARK_GREY = 8,
    VGA_LIGHT_BLUE = 9,
    VGA_LIGHT_GREEN = 10,
    VGA_LIGHT_CYAN = 11,
    VGA_LIGHT_RED = 12,
    VGA_LIGHT_MAGENTA = 13,
    VGA_YELLOW = 14,
    VGA_WHITE = 15,
    VGA_DARK_PURPLE = 16
};

/* Build VGA entry (character + color) */
static inline uint16_t vga_entry(char c, uint8_t color) {
    return (uint16_t)c | ((uint16_t)color << 8);
}

/* VGA functions */
void vga_clear(uint8_t color);
void vga_putc(int row, int col, char c, uint8_t color);
void vga_write(int row, const char* str, uint8_t color);

#endif
