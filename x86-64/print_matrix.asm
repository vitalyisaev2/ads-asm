global _start

section .data
	m1: db 1, 2, 3, 4
	m1_size: db 4
	m1_rows: db 2
	m1_cols: db 2

section .bss
	buf: resb 64

section .text

_start:
	jmp prepare_buffer

prepare_buffer:
	; r8 - счётчик позиций в матрице m1
	xor r8, r8
	jmp put_char

put_char:
	; r9 - для обмена данными между различными областями памяти
	xor r9, r9
	mov r9b, [m1 + r8]
	add r9b, 48
	mov [buf + 2*r8], r9b
	inc r8
	cmp r8b, [m1_size]
	je finish
	cmp r8b, [m1_cols]
	je put_endl
	jmp put_space

put_endl:
	mov byte [buf + 2*r8 - 1], 10
	jmp put_char

put_space:
	mov byte [buf + 2*r8 - 1], 32
	jmp put_char

finish:
	; записать 0
	mov byte [buf + 2*r8 - 1], 0
	; распечатать сообщение
	mov rax, 1
	mov rdi, 1
	mov rsi, buf
	mov rdx, 64 ; длина буфера
	syscall
	; выйти из программы
	mov rax, 60
	xor rdi, rdi
	syscall
