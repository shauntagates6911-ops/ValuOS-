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
; boot.asm — stage 1 bootloader
[BITS 16]
[ORG 0x7C00]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; message (optional)
    mov si, msg
.print:
    lodsb
    or al, al
    jz .read_kernel
    mov ah, 0x0E
    int 0x10
    jmp .print

.read_kernel:
    ; load kernel to 0x1000:0000 (physical 0x10000)
    mov ax, 0x1000
    mov es, ax
    xor bx, bx          ; ES:BX = 0x1000:0000

    mov ah, 0x02        ; BIOS: read sectors
    mov al, 4           ; number of sectors (adjust for kernel size)
    mov ch, 0           ; cylinder
    mov cl, 2           ; sector (start after boot sector)
    mov dh, 0           ; head
    mov dl, 0x80        ; first hard disk

    int 0x13
    jc .disk_error      ; if carry set → error

    jmp 0x1000:0000     ; jump to loaded kernel

.disk_error:
    mov si, err
.err_print:
    lodsb
    or al, al
    jz .hang
    mov ah, 0x0E
    int 0x10
    jmp .err_print

.hang:
    cli
    hlt
    jmp .hang

msg db "ValuOS: loading kernel...", 0
err db "Disk read error!", 0

times 510 - ($ - $$) db 0
dw 0xAA55
