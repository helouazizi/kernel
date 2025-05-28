[org 0x7C00]           ; Tell NASM the origin address in memory

start:
    mov si, message      ; Si rigister point to meassge string 

print_loop :
    lodsb               ; load the si into al just lodsb 
    or al, al            ; Check if AL == 0 (end of string)
    jz done             ; jump to done
    mov ah, 0x0E         ; tel the bios wich function to use 
    mov bh, 0x00         ; the page number
    mov bl, 0x1F        ; trrs
    int 0x10              ; call bios vidio related services
    jmp print_loop
     
done:
    cli                   ; Disable interrupts
    hlt                   ; Halt CPU


message db "Hello, Hassan elouazizi!", 0



; ========== Padding to 510 bytes ==========
times 510 - ($ - $$) db 0

; ========== Boot signature ==========
dw 0xAA55
