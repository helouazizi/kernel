;[org 0x7C00]

; GDT setup - 3 entries: null, code, data
gdt_start:
    dq 0
    dq 0x00CF9A000000FFFF   ; code segment: base=0, limit=4GB, exec/read, ring0
    dq 0x00CF92000000FFFF   ; data segment: base=0, limit=4GB, read/write, ring0
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    lgdt [gdt_descriptor]         ; load GDT

    mov eax, cr0
    or eax, 1
    mov cr0, eax                 ; enable protected mode

    jmp 0x08:protected_mode     ; far jump to flush pipeline & switch to protected mode

[bits 32]
protected_mode:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    extern kernel_main           ; tell assembler kernel_main is external (C)

    call kernel_main             ; call C kernel function

hang:
    jmp hang                    ; infinite loop

times 510 - ($ - $$) db 0
dw 0xAA55
