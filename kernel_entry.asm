; ValuOS 32-bit kernel entry
; assemble: nasm -f elf32 kernel_entry.asm -o kernel_entry.o

[BITS 32]
global _start
extern kernel_main

_start:
    ; simple stack
    mov esp, 0x90000

    ; call C kernel
    call kernel_main

.hang:
    cli
    hlt
    jmp .hang
