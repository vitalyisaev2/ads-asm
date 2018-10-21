SECTION .data
	arr:	db 1, 2, 3, 4
	len:	db 4
	character: db 0 ; this variable will be used for printing purposes

SECTION .text
	global _start

_start:
	xor esi, esi
loop:
	xor eax, eax
	add eax, [arr]
	add eax, esi
	add eax, 48
	mov [character], eax
	mov eax, 4
	mov ebx, 1
	mov ecx, character	 ; write buffer address
	mov edx, 1
	int 0x80
	inc esi
	cmp esi, 4
	jne loop
	jmp _exit

_exit:
	mov eax, 1
	mov ebx, 0
	int 0x80
