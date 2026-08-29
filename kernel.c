// ValuOS Kernel
// GPLv3 — Shaunte 2026

#define VGA_ADDR 0xB8000
#define WHITE_ON_BLACK 0x0F

static unsigned short *vga = (unsigned short *)VGA_ADDR;

static void putc(int row, int col, char c) {
    int idx = row * 80 + col;
    vga[idx] = ((unsigned short)WHITE_ON_BLACK << 8) | (unsigned short)c;
}

void kernel_main(void) {
    const char *msg = "ValuOS KERNEL ONLINE";
    int col = 0;

    while (msg[col]) {
        putc(0, col, msg[col]);
        col++;
    }

    for (;;) {
        __asm__ __volatile__("hlt");
    }
}
