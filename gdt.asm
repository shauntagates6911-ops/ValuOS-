[BITS 16]

gdt_start:
    dq 0x0000000000000000      ; null descriptor

gdt_code:
    dq 0x00CF9A000000FFFF      ; 32-bit code segment

gdt_data:
    dq 0x00CF92000000FFFF      ; 32-bit data segment

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
