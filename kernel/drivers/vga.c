#include <stdint.h>
#include "vga.h"

static uint16_t* const VGA_BUFFER = (uint16_t*)VGA_MEMORY;

/* Clear the entire screen with a color */
void vga_clear(uint8_t color) {
    uint16_t entry = vga_entry(' ', color);

    for (int i = 0; i < VGA_WIDTH * VGA_HEIGHT; i++) {
        VGA_BUFFER[i] = entry;
    }
}

/* Put a single character at row/col */
void vga_putc(int row, int col, char c, uint8_t color) {
    if (row < 0 || row >= VGA_HEIGHT) return;
    if (col < 0 || col >= VGA_WIDTH) return;

    VGA_BUFFER[row * VGA_WIDTH + col] = vga_entry(c, color);
}

/* Write a string starting at row */
void vga_write(int row, const char* str, uint8_t color) {
    int col = 0;

    while (str[col] && col < VGA_WIDTH) {
        vga_putc(row, col, str[col], color);
        col++;
    }
}
