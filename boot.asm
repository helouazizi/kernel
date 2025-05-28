; bootloader.asm
[org 0x7C00]
[BITS 16]

start:
    cli                 ; disable interrupts
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; load GDT
    lgdt [gdt_descriptor]

    ; enter protected mode
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    ; far jump to clear pipeline and enter pm
    jmp 0x08:protected_mode_start

; ---------------------------
; GDT (Global Descriptor Table)
gdt_start:
    ; null descriptor
    dq 0x0000000000000000

    ; code segment (offset=0, base=0x00000000, limit=0xFFFFF, access=0x9A)
    dq 0x00CF9A000000FFFF

    ; data segment (offset=0, base=0x00000000, limit=0xFFFFF, access=0x92)
    dq 0x00CF92000000FFFF

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1   ; size
    dd gdt_start                 ; address

; ---------------------------
; Protected Mode Code
[BITS 32]
protected_mode_start:
    mov ax, 0x10       ; data segment selector
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000

    ; Print message to VGA
    mov esi, message
    mov edi, 0xB8000        ; VGA memory address
.print:
    lodsb
    cmp al, 0
    je .halt
    mov ah, 0x1F            ; white on blue
    stosw
    jmp .print

.halt:
    cli
    hlt

message db "Hello from Ouazizi Kernel!", 0

; ---------------------------
; Boot Signature
times 510 - ($ - $$) db 0
dw 0xAA55
