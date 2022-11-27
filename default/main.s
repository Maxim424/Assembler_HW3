	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"You need to specify 2 files in the command line arguments: input and output"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC4:
	.string	"Program execution time:\t%lf\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	push	r13
	pxor	xmm0, xmm0
	push	r12
	push	rbp
	mov	rbp, rsi
	push	rbx
	mov	ebx, edi
	sub	rsp, 24
	mov	rax, QWORD PTR .LC0[rip]
	movq	xmm1, rax
	call	check_range@PLT
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
	call	enter_eps_from_file@PLT
	movapd	xmm3, xmm0
.L6:
	movapd	xmm0, xmm3
	movsd	QWORD PTR 8[rsp], xmm3
	call	check_eps@PLT
	test	eax, eax
	je	.L16
	call	clock@PLT
	movsd	xmm3, QWORD PTR 8[rsp]
	mov	ebx, 4000000
	pxor	xmm2, xmm2
	mov	r13, rax
	.p2align 4,,10
	.p2align 3
.L9:
	mov	rax, QWORD PTR .LC0[rip]
	movapd	xmm0, xmm2
	movsd	QWORD PTR 8[rsp], xmm3
	movq	xmm1, rax
	call	calculate@PLT
	sub	ebx, 1
	movsd	xmm3, QWORD PTR 8[rsp]
	pxor	xmm2, xmm2
	jne	.L9
	movsd	QWORD PTR 8[rsp], xmm0
	call	clock@PLT
	pxor	xmm0, xmm0
	mov	edi, 1
	lea	rsi, .LC4[rip]
	sub	rax, r13
	cvtsi2sd	xmm0, rax
	mov	eax, 1
	divsd	xmm0, QWORD PTR .LC3[rip]
	call	__printf_chk@PLT
	cmp	r12d, 2
	movsd	xmm1, QWORD PTR 8[rsp]
	je	.L10
	movapd	xmm0, xmm1
	call	print_answer_to_console@PLT
	xor	eax, eax
	jmp	.L1
.L18:
	lea	rsi, .LC2[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
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
	call	enter_eps_from_console@PLT
	movapd	xmm3, xmm0
	jmp	.L6
.L10:
	mov	rdi, rbp
	movapd	xmm0, xmm1
	call	print_answer_to_file@PLT
	xor	eax, eax
	jmp	.L1
.L20:
	xor	eax, eax
	call	generate_eps@PLT
	movapd	xmm3, xmm0
	jmp	.L6
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC3:
	.long	0
	.long	1093567616
	.ident	"GCC: (GNU) 10.3.0"
	.section	.note.GNU-stack,"",@progbits
