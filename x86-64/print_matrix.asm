global _start

section .data
	m1: db 1, 2, 3, 4, 5, 6
	m1_size: db 6
	m1_rows: db 3
	m1_cols: db 2

section .bss
	buf: resb 64

section .text

_start:
	jmp prepare_buffer

prepare_buffer:
	xor r8, r8						; r8 - matrix element index position
	jmp put_char

put_char:
	xor r9, r9						; r9 - prepares chars that are going to be put in buffer
	mov r9b, [m1 + r8]
	add r9b, 48
	mov [buf + 2*r8], r9b			; put byte to buffer by offset
	inc r8
	cmp r8b, [m1_size]
	je finish						; reached last element of matrix
	mov rdx, 0
	mov al, r8b
	mov cl, [m1_cols]
	div rcx
	test rdx, rdx
	je put_endl						; reached last element of the row
	jmp put_space					; reached space between elements

put_endl:
	mov byte [buf + 2*r8 - 1], 10
	jmp put_char

put_space:
	mov byte [buf + 2*r8 - 1], 32
	jmp put_char

finish:
	mov byte [buf + 2*r8 - 1], 0	; null-termination
	mov rax, 1
	mov rdi, 1
	mov rsi, buf
	mov rdx, 64						
	syscall							; syscall write
	mov rax, 60
	xor rdi, rdi
	syscall							; syscall exit
