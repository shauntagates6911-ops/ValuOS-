; ValuOS Bootloader — 512 bytes
; assemble: nasm -f bin boot.asm -o boot.bin

[BITS 16]
[ORG 0x7C00]

start:
    cli                 ; no thinking
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7BFF      ; tiny stack

    sti                 ; thinking still disabled

    mov si, msg         ; point to message

.print:
    lodsb               ; AL = next char
    or al, al
    jz hang             ; end of string

    mov ah, 0x0E        ; BIOS print
    int 0x10
    jmp .print

hang:
    cli
    hlt                 ; stop forever

msg db "ValuOS BOOTING...", 0

times 510 - ($ - $$) db 0
dw 0xAA55
