[bits 32]
[org 0x10000]

_start:
	mov bx, helloworld
	call print

.halt:
	jmp $

print: ;bx - pointer to text
	mov al, [bx]
	call print_char
	inc bx
	mov ah, [bx]
	cmp ah, 0
	jne print
	ret
	
print_char: ;al - char
	mov ah, 0xE
	int 0x10
	ret

helloworld:
	db 'MYLX v0.1', 0
