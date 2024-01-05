[bits 16]
[org 0x7C00]

_start:
	mov bx, helloworld
	call print
	call tests
	jmp .halt

.halt:
	jmp $

print: ;bx - pointer to text

.loop:
	mov al, [bx]
	call print_char
	inc bx
	mov ah, [bx]
	cmp ah, 0
	jne .loop
.end:
	ret
	
print_char: ;al - char
	mov ah, 0xE
	int 0x10
	ret

tests:
	ret

helloworld:
	db 'MYLX v0.1', 0
	
times 510 - ($ - $$) db 0
dw 0xAA55
