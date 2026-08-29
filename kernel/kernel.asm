; kernel.asm — tiny 16-bit kernel demo at 0x10000
[BITS 16]
[ORG 0x0000]

start_kernel:
    mov si, msg
.kprint:
    lodsb
    or al, al
    jz .hang
    mov ah, 0x0E
    int 0x10
    jmp .kprint

.hang:
    cli
    hlt
    jmp .hang

msg db "ValuOS kernel loaded from disk!", 0
