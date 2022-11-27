	.file	"functions.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	f
	.type	f, @function
f:
	movapd	xmm2, xmm0
	sub	rsp, 24
	mulsd	xmm2, xmm0
	movsd	xmm0, QWORD PTR .LC1[rip]
	movapd	xmm1, xmm2
	addsd	xmm1, QWORD PTR .LC0[rip]
	movsd	QWORD PTR 8[rsp], xmm2
	call	pow@PLT
	movsd	xmm2, QWORD PTR 8[rsp]
	addsd	xmm0, xmm2
	subsd	xmm0, QWORD PTR .LC2[rip]
	add	rsp, 24
	ret
	.size	f, .-f
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"Range from a to b, where\n\ta = %lf\n\tb = %lf\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC5:
	.string	"The range is correct."
	.section	.rodata.str1.8
	.align 8
.LC6:
	.string	"The range is incorrect, there is no solution from a to b or more than 1 solution."
	.text
	.p2align 4
	.globl	check_range
	.type	check_range, @function
check_range:
	sub	rsp, 24
	mov	edi, 1
	mov	eax, 2
	lea	rsi, .LC3[rip]
	movsd	QWORD PTR 8[rsp], xmm1
	movsd	QWORD PTR [rsp], xmm0
	call	__printf_chk@PLT
	movsd	xmm0, QWORD PTR [rsp]
	call	f@PLT
	movsd	xmm1, QWORD PTR 8[rsp]
	movsd	QWORD PTR [rsp], xmm0
	movapd	xmm0, xmm1
	call	f@PLT
	mulsd	xmm0, QWORD PTR [rsp]
	pxor	xmm1, xmm1
	comisd	xmm1, xmm0
	ja	.L11
	lea	rsi, .LC6[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	xor	eax, eax
	add	rsp, 24
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	lea	rdi, .LC5[rip]
	call	puts@PLT
	mov	eax, 1
	add	rsp, 24
	ret
	.size	check_range, .-check_range
	.section	.rodata.str1.8
	.align 8
.LC7:
	.string	"Enter a number with which accuracy you want to print the solution of the equation:"
	.section	.rodata.str1.1
.LC8:
	.string	"%lf"
	.text
	.p2align 4
	.globl	enter_eps_from_console
	.type	enter_eps_from_console, @function
enter_eps_from_console:
	sub	rsp, 24
	lea	rdi, .LC7[rip]
	call	puts@PLT
	lea	rsi, 8[rsp]
	lea	rdi, .LC8[rip]
	xor	eax, eax
	call	__isoc99_scanf@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	add	rsp, 24
	ret
	.size	enter_eps_from_console, .-enter_eps_from_console
	.section	.rodata.str1.1
.LC9:
	.string	"r"
	.text
	.p2align 4
	.globl	enter_eps_from_file
	.type	enter_eps_from_file, @function
enter_eps_from_file:
	push	rbp
	lea	rsi, .LC9[rip]
	sub	rsp, 16
	mov	rdi, QWORD PTR 8[rdi]
	call	fopen@PLT
	lea	rdx, 8[rsp]
	lea	rsi, .LC8[rip]
	mov	rbp, rax
	mov	rdi, rax
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	mov	rdi, rbp
	call	fclose@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	add	rsp, 16
	pop	rbp
	ret
	.size	enter_eps_from_file, .-enter_eps_from_file
	.section	.rodata.str1.8
	.align 8
.LC11:
	.string	"The number with which accuracy the solution of the equation will be printed: %.10lf\n"
	.text
	.p2align 4
	.globl	generate_eps
	.type	generate_eps, @function
generate_eps:
	sub	rsp, 24
	xor	edi, edi
	call	time@PLT
	mov	rdi, rax
	call	srand@PLT
	call	rand@PLT
	mov	edx, eax
	cdqe
	imul	rax, rax, 1717986919
	mov	ecx, edx
	sar	ecx, 31
	sar	rax, 33
	sub	eax, ecx
	lea	eax, [rax+rax*4]
	sub	edx, eax
	add	edx, 3
	test	edx, edx
	jle	.L19
	movsd	xmm1, QWORD PTR .LC10[rip]
	xor	eax, eax
	movapd	xmm0, xmm1
	.p2align 4,,10
	.p2align 3
.L18:
	mulsd	xmm0, xmm1
	add	eax, 1
	cmp	edx, eax
	jne	.L18
.L17:
	mov	edi, 1
	lea	rsi, .LC11[rip]
	mov	eax, 1
	movsd	QWORD PTR 8[rsp], xmm0
	call	__printf_chk@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	add	rsp, 24
	ret
	.p2align 4,,10
	.p2align 3
.L19:
	movsd	xmm0, QWORD PTR .LC10[rip]
	jmp	.L17
	.size	generate_eps, .-generate_eps
	.section	.rodata.str1.1
.LC14:
	.string	"Incorrect number = %.10lf\n"
	.text
	.p2align 4
	.globl	check_eps
	.type	check_eps, @function
check_eps:
	comisd	xmm0, QWORD PTR .LC12[rip]
	ja	.L23
	movsd	xmm1, QWORD PTR .LC13[rip]
	comisd	xmm1, xmm0
	ja	.L23
	mov	eax, 1
	ret
	.p2align 4,,10
	.p2align 3
.L23:
	sub	rsp, 8
	mov	edi, 1
	mov	eax, 1
	lea	rsi, .LC14[rip]
	call	__printf_chk@PLT
	xor	eax, eax
	add	rsp, 8
	ret
	.size	check_eps, .-check_eps
	.p2align 4
	.globl	calculate
	.type	calculate, @function
calculate:
	movapd	xmm4, xmm0
	movapd	xmm0, xmm1
	sub	rsp, 56
	subsd	xmm0, xmm4
	movsd	QWORD PTR 40[rsp], xmm3
	comisd	xmm0, xmm3
	jbe	.L31
	.p2align 4,,10
	.p2align 3
.L35:
	movapd	xmm2, xmm4
	movapd	xmm0, xmm1
	movsd	QWORD PTR 32[rsp], xmm4
	addsd	xmm2, xmm1
	mulsd	xmm2, QWORD PTR .LC15[rip]
	movsd	QWORD PTR 24[rsp], xmm1
	movsd	QWORD PTR 16[rsp], xmm2
	call	f@PLT
	movsd	xmm2, QWORD PTR 16[rsp]
	movsd	QWORD PTR 8[rsp], xmm0
	movapd	xmm0, xmm2
	call	f@PLT
	mulsd	xmm0, QWORD PTR 8[rsp]
	pxor	xmm6, xmm6
	movsd	xmm2, QWORD PTR 16[rsp]
	movsd	xmm1, QWORD PTR 24[rsp]
	movsd	xmm4, QWORD PTR 32[rsp]
	cmpltsd	xmm0, xmm6
	movapd	xmm3, xmm0
	andpd	xmm1, xmm0
	andnpd	xmm3, xmm2
	orpd	xmm1, xmm3
	movapd	xmm3, xmm2
	andpd	xmm3, xmm0
	andnpd	xmm0, xmm4
	movapd	xmm4, xmm0
	movapd	xmm0, xmm1
	orpd	xmm4, xmm3
	subsd	xmm0, xmm4
	comisd	xmm0, QWORD PTR 40[rsp]
	ja	.L35
.L31:
	movapd	xmm0, xmm2
	add	rsp, 56
	ret
	.size	calculate, .-calculate
	.section	.rodata.str1.1
.LC16:
	.string	"Answer: %.10lf\n"
	.text
	.p2align 4
	.globl	print_answer_to_console
	.type	print_answer_to_console, @function
print_answer_to_console:
	lea	rsi, .LC16[rip]
	mov	edi, 1
	mov	eax, 1
	jmp	__printf_chk@PLT
	.size	print_answer_to_console, .-print_answer_to_console
	.section	.rodata.str1.1
.LC17:
	.string	"w+"
	.section	.rodata.str1.8
	.align 8
.LC18:
	.string	"The result is written to the file!"
	.text
	.p2align 4
	.globl	print_answer_to_file
	.type	print_answer_to_file, @function
print_answer_to_file:
	push	rbp
	lea	rsi, .LC17[rip]
	sub	rsp, 16
	mov	rdi, QWORD PTR 16[rdi]
	movsd	QWORD PTR 8[rsp], xmm0
	call	fopen@PLT
	lea	rsi, .LC18[rip]
	mov	edi, 1
	mov	rbp, rax
	xor	eax, eax
	call	__printf_chk@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	mov	rdi, rbp
	lea	rdx, .LC16[rip]
	mov	esi, 1
	mov	eax, 1
	call	__fprintf_chk@PLT
	add	rsp, 16
	mov	rdi, rbp
	pop	rbp
	jmp	fclose@PLT
	.size	print_answer_to_file, .-print_answer_to_file
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC1:
	.long	0
	.long	1073741824
	.align 8
.LC2:
	.long	0
	.long	1074790400
	.align 8
.LC10:
	.long	-1717986918
	.long	1069128089
	.align 8
.LC12:
	.long	-755914244
	.long	1062232653
	.align 8
.LC13:
	.long	-500134854
	.long	1044740494
	.align 8
.LC15:
	.long	0
	.long	1071644672
	.ident	"GCC: (GNU) 10.3.0"
	.section	.note.GNU-stack,"",@progbits
