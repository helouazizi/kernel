section .data
    msg db 'enter a number: ', 0xA
    len equ $ - msg
    buf times 5 db 0         ; buffer for user input (5 bytes)

section .text
    global _start

_start:
    ; write prompt
    mov edx, len
    mov ecx, msg
    mov ebx, 1          ; stdout
    mov eax, 4          ; sys_write
    int 0x80

    ; read input
    mov eax, 3          ; sys_read
    mov ebx, 0          ; stdin
    mov ecx, buf        ; buffer
    mov edx, 5          ; max bytes
    int 0x80

    ; exit
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; status 0
    int 0x80
