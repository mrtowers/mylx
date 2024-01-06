[bits 16]
[org 0x0500]

_start:
	call clear_screen
	mov bx, helloworld
	call print

.halt:
	jmp $

clear_screen:
	push ax
	push bx
	push cx
	push dx
	mov ah, 0x06
	mov al, 0
	mov bh, 0x0F
	mov cx, 0x0000
	mov dx, 0xFFFF
	int 0x10 ; clear screen
	mov ah, 0x02
	mov bh, 0
	mov dx, 0
	int 0x10 ; set cursor position
	pop dx
	pop cx
	pop bx
	pop ax
	ret

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
	db 'lets MYLX!', 0
