[bits 16]
[org 0x7C00]

%define NUMBER_OF_SECTORS 1
%define LOAD_POSITION 0x0500

_start:
        mov ah, 0x02 ; instruction to read disk sector
        mov al, NUMBER_OF_SECTORS ; numer of sectors
        mov ch, 0 ; cylinder
        mov cl, 2 ; begin sector
        mov dh, 0 ; head??
        mov dl, 0 ; disk number (floppy here)
        mov bx, 0
        mov es, bx
        mov bx, LOAD_POSITION
        call load_sectors
        jmp LOAD_POSITION

load_sectors:
        int 0x13 ; interrupt to read disk sectors
        cmp ah, 0 ; check if ah (return code) is 0
        jnc .end
.error:
        jmp panic
.end:
        ret

panic:
        mov ah, 0x0A ; instruction to print char
        mov al, '!' ; char
        mov bh, 0 ; page number
        mov cx, 3 ; number of times
        int 0x10
        jmp $ ;infinite loop

times 510 - ($ - $$) db 0
dw 0xAA55
