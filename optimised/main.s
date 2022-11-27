.intel_syntax noprefix    # Использование синтаксиса intel
	.text     # Секция с функциями  
	.section	.rodata    # Секция с read-only информацией
.LC2:
	.string	"You need to specify 2 files in the command line arguments: input and output"
	.section	.rodata    # Секция с read-only информацией
.LC4:
	.string	"Program execution time:\t%lf\n"
	.section	.text    # Секция с функциями  
	.globl	main    # Глобальная функция main
	.type	main, @function    # Объявляем, что main - это функция
main:
	push	r13    # Пролог функции
	pxor	xmm0, xmm0
	push	r12
	push	rbp
	mov	rbp, rsi
	push	rbx
	mov	ebx, edi
	sub	rsp, 24
	mov	rax, QWORD PTR .LC0[rip]
	movq	xmm1, rax
	call	check_range@PLT    # Вызов функции check_range
	test	eax, eax
	je	.L16
	lea	r12d, -1[rbx]
	cmp	r12d, 2
	ja	.L18
	cmp	ebx, 1
	je	.L19
	cmp	ebx, 2
	je	.L20
	mov	rdi, rbp
	call	enter_eps_from_file@PLT     # Вызов функции enter_eps_from_file
	movapd	xmm3, xmm0
.L6:
	movapd	xmm0, xmm3
	movsd	xmm8, xmm3      # Заменили 8[rsp] на xmm8
	call	check_eps@PLT    # Вызов функции check_eps
	test	eax, eax
	je	.L16
	call	clock@PLT  # Вызов функции clock  
	movsd	xmm3, xmm8
	mov	ebx, 4000000
	pxor	xmm2, xmm2
	mov	r13, rax
.L9:
	mov	rax, QWORD PTR .LC0[rip]
	movapd	xmm0, xmm2
	movsd	xmm15, xmm3    # Заменили 8[rsp] на xmm15
	movq	xmm1, rax
	call	calculate@PLT    # Вызов функции calculate  
	sub	ebx, 1
	movsd	xmm3, xmm15
	pxor	xmm2, xmm2
	jne	.L9
	movsd	xmm15, xmm0
	call	clock@PLT    # Вызов функции clock
	pxor	xmm0, xmm0
	mov	edi, 1
	lea	rsi, .LC4[rip]
	sub	rax, r13
	cvtsi2sd	xmm0, rax
	mov	eax, 1
	divsd	xmm0, QWORD PTR .LC3[rip]
	call	__printf_chk@PLT    # Вызов функции printf
	cmp	r12d, 2
	movsd	xmm1, xmm15
	je	.L10
	movapd	xmm0, xmm1
	call	print_answer_to_console@PLT    # Вызов функции print_answer_to_console
	xor	eax, eax
	jmp	.L1
.L18:
	lea	rsi, .LC2[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT    # Вызов функции printf
.L16:
	mov	eax, 1
.L1:
	add	rsp, 24
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L19:
	xor	eax, eax
	call	enter_eps_from_console@PLT    # Вызов функции enter_eps_from_console
	movapd	xmm3, xmm0
	jmp	.L6
.L10:
	mov	rdi, rbp
	movapd	xmm0, xmm1
	call	print_answer_to_file@PLT    # Вызов функции print_answer_to_file
	xor	eax, eax
	jmp	.L1
.L20:
	xor	eax, eax
	call	generate_eps@PLT      # Вызов функции generate_eps
	movapd	xmm3, xmm0
	jmp	.L6
	.section	.rodata    # Секция с read-only информацией
.LC0:
	.long	0
	.long	1072693248
.LC3:
	.long	0
	.long	1093567616
