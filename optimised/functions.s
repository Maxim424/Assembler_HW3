	.intel_syntax noprefix    # Использование синтаксиса intel
	.text    # Секция с функциями  
	.globl	f    # Глобальная функция f
	.type	f, @function    # Объявляем, что f - это функция
f:
	movapd	xmm2, xmm0    # Параметр x функции
	sub	rsp, 24
	mulsd	xmm2, xmm0
	movsd	xmm0, QWORD PTR .LC1[rip]    # Печедача первого параметра в pow
	movapd	xmm1, xmm2
	addsd	xmm1, QWORD PTR .LC0[rip]    # Печедача второго параметра в pow
	movsd	xmm14, xmm2    # Заменили 8[rsp] на xmm14
	call	pow@PLT    # Вызов функции pow
	movsd	xmm2, xmm14
	addsd	xmm0, xmm2
	subsd	xmm0, QWORD PTR .LC2[rip]
	add	rsp, 24
	ret
	.section	.rodata    # Секция с read-only информацией
.LC3:
	.string	"Range from a to b, where\n\ta = %lf\n\tb = %lf\n"
	.section	.rodata    # Секция с read-only информацией
.LC5:
	.string	"The range is correct."
	.section	.rodata    # Секция с read-only информацией
.LC6:
	.string	"The range is incorrect, there is no solution from a to b or more than 1 solution."
	.text    # Секция с функциями
	.globl	check_range    # Глобальная функция check_range
	.type	check_range, @function    # Объявляем, что check_range - это функция
check_range:
	sub	rsp, 24
	mov	edi, 1
	mov	eax, 2
	lea	rsi, .LC3[rip]
	movsd	xmm12, xmm1    # Параматр b, заменили 8[rsp] на xmm12
	movsd	xmm13, xmm0    # Параматр a, заменили [rsp] на xmm13
	call	__printf_chk@PLT
	movsd	xmm0, xmm13    # Передача параметра в функцию f
	call	f@PLT      # Вызов функции f
	movsd	xmm1, xmm12
	movsd	xmm13, xmm0
	movapd	xmm0, xmm1    # Передача параметра в функцию f
	call	f@PLT    # Вызов функции f
	mulsd	xmm0, xmm13
	pxor	xmm1, xmm1
	comisd	xmm1, xmm0
	ja	.L11
	lea	rsi, .LC6[rip]    # Передача второго параметра в функцию printf
	mov	edi, 1    # Передача первого параметра в функцию printf
	xor	eax, eax
	call	__printf_chk@PLT    # Вызов функции printf
	xor	eax, eax
	add	rsp, 24
	ret
.L11:
	lea	rdi, .LC5[rip]    # Передача параметра в функцию puts
	call	puts@PLT     # Вызов функции puts (printf для сообщения "The range is correct.")
	mov	eax, 1
	add	rsp, 24
	ret
	.section	.rodata    # Секция с read-only информацией
.LC7:
	.string	"Enter a number with which accuracy you want to print the solution of the equation:"
	.section	.rodata    # Секция с read-only информацией
.LC8:
	.string	"%lf"
	.text    # Секция с функциями
	.globl	enter_eps_from_console    # Глобальная функция enter_eps_from_console
	.type	enter_eps_from_console, @function    # Объявляем, что enter_eps_from_console - это функция
enter_eps_from_console:
	sub	rsp, 24
	lea	rdi, .LC7[rip]    # Передача параметра в функцию puts
	call	puts@PLT    # Вызов функции puts
	lea	rsi, 8[rsp]    # Передача второго параметра в функцию scanf
	lea	rdi, .LC8[rip]    # Передача первого параметра в функцию scanf
	xor	eax, eax
	call	__isoc99_scanf@PLT    # Вызов функции scanf
	movsd	xmm0, QWORD PTR 8[rsp]
	add	rsp, 24
	ret
	.section	.rodata    # Секция с read-only информацией
.LC9:
	.string	"r"
	.text    # Секция с функциями
	.globl	enter_eps_from_file    # Глобальная функция enter_eps_from_file
	.type	enter_eps_from_file, @function    # Объявляем, что enter_eps_from_file - это функция
enter_eps_from_file:
	push	rbp
	lea	rsi, .LC9[rip]    # Передача второго параметра в функцию fopen
	sub	rsp, 16
	mov	rdi, QWORD PTR 8[rdi]    # Передача первого параметра в функцию fopen (файл, который нужно открыть)
	call	fopen@PLT    # Вызов функции fopen
	lea	rdx, 8[rsp]
	lea	rsi, .LC8[rip]    # Передача второго параметра в функцию fscanf
	mov	rbp, rax
	mov	rdi, rax      # Передача первого параметра в функцию fscanf
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	mov	rdi, rbp    # Передача параметра в функцию fclose
	call	fclose@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	add	rsp, 16
	pop	rbp
	ret  
	.section	.rodata    # Секция с read-only информацией
.LC11:
	.string	"The number with which accuracy the solution of the equation will be printed: %.10lf\n"
	.text    # Секция с функциями
	.globl	generate_eps    # Глобальная функция generate_eps
	.type	generate_eps, @function    # Объявляем, что generate_eps - это функция
generate_eps:
	sub	rsp, 24
	xor	edi, edi
	call	time@PLT    # Вызов функции time
	mov	rdi, rax    # Передача параметра в srand
	call	srand@PLT    # Вызов функции srand
	call	rand@PLT    # Вызов функции rand
	mov	edx, eax
	cdqe
	imul	rax, rax, 1717986919    # Далее вычисление переменной eps
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
.L18:
	mulsd	xmm0, xmm1
	add	eax, 1
	cmp	edx, eax
	jne	.L18
.L17:
	mov	edi, 1
	lea	rsi, .LC11[rip]
	mov	eax, 1
	movsd	xmm12, xmm0    #  Заменили 8[rsp] на xmm12
	call	__printf_chk@PLT    # Вызов функции printf
	movsd	xmm0, xmm12
	add	rsp, 24
	ret
.L19:
	movsd	xmm0, QWORD PTR .LC10[rip]
	jmp	.L17
	.section	.rodata    # Секция с read-only информацией
.LC14:
	.string	"Incorrect number = %.10lf\n"
	.text    # Секция с функциями
	.globl	check_eps    # Глобальная функция check_eps
	.type	check_eps, @function    # Объявляем, что check_eps - это функция
check_eps:
	comisd	xmm0, QWORD PTR .LC12[rip]
	ja	.L23
	movsd	xmm1, QWORD PTR .LC13[rip]
	comisd	xmm1, xmm0
	ja	.L23
	mov	eax, 1
	ret
.L23:
	sub	rsp, 8
	mov	edi, 1    # Передача первого параметра в printf
	mov	eax, 1
	lea	rsi, .LC14[rip]    # Передача второго параметра в printf
	call	__printf_chk@PLT    # Вызов printf
	xor	eax, eax
	add	rsp, 8
	ret
	.globl	calculate    # Глобальная функция calculate
	.type	calculate, @function    # Объявляем, что calculate - это функция
calculate:
	movapd	xmm4, xmm0    # Параметр a
	movapd	xmm0, xmm1    # Параметр b
	sub	rsp, 56
	subsd	xmm0, xmm4
	movsd	xmm12, xmm3       # Заменили 40[rsp] на xmm12
	comisd	xmm0, xmm3
	jbe	.L31
.L35:
	movapd	xmm2, xmm4
	movapd	xmm0, xmm1    # Передача параметра в f
	movsd	xmm13, xmm4    # Заменили 32[rsp] на xmm13, (eps)
	addsd	xmm2, xmm1
	mulsd	xmm2, QWORD PTR .LC15[rip]
	movsd	QWORD PTR 24[rsp], xmm1    # Параметр b
	movsd	QWORD PTR 16[rsp], xmm2    # Параметр c
	call	f@PLT    # Вызов функции f
	movsd	xmm2, QWORD PTR 16[rsp]
	movsd	QWORD PTR 8[rsp], xmm0
	movapd	xmm0, xmm2     # Передача параметра в f
	call	f@PLT     # Вызов функции f
	mulsd	xmm0, QWORD PTR 8[rsp]    
	pxor	xmm6, xmm6
	movsd	xmm2, QWORD PTR 16[rsp]    # Параметр b
	movsd	xmm1, QWORD PTR 24[rsp]    # Параметр c
	movsd	xmm4, xmm13
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
	comisd	xmm0, xmm12
	ja	.L35
.L31:
	movapd	xmm0, xmm2
	add	rsp, 56
	ret
	.section	.rodata    # Секция с read-only информацией
.LC16:
	.string	"Answer: %.10lf\n"
	.text    # Секция с функциями
	.globl	print_answer_to_console    # Глобальная функция print_answer_to_console
	.type	print_answer_to_console, @function    # Объявляем, что print_answer_to_console - это функция
print_answer_to_console:
	lea	rsi, .LC16[rip]    # Передача параметра в printf
	mov	edi, 1
	mov	eax, 1
	jmp	__printf_chk@PLT    # Вызов printf
	.section	.rodata    # Секция с read-only информацией
.LC17:
	.string	"w+"
	.section	.rodata    # Секция с read-only информацией
.LC18:
	.string	"The result is written to the file!"
	.text    # Секция с функциями
	.globl	print_answer_to_file
	.type	print_answer_to_file, @function
print_answer_to_file:
	push	rbp
	lea	rsi, .LC17[rip]
	sub	rsp, 16
	mov	rdi, QWORD PTR 16[rdi]    # Передача параметра в fopen
	movsd	xmm12, xmm0    # Заменили 8[rsp] на xmm12
	call	fopen@PLT    # Вызов fopen
	lea	rsi, .LC18[rip]    # Передача второго параметра в printf
	mov	edi, 1     # Передача первого параметра в printf
	mov	rbp, rax
	xor	eax, eax
	call	__printf_chk@PLT    # Вызов printf
	movsd	xmm0, xmm12    # Передача вещественного числа (result) в fprintf
	mov	rdi, rbp    # Передача первого параметра в fprintf
	lea	rdx, .LC16[rip]
	mov	esi, 1    # Передача второго параметра в fprintf
	mov	eax, 1
	call	__fprintf_chk@PLT    # Вызов fprintf
	add	rsp, 16
	mov	rdi, rbp    # Передача параметра в fclose
	pop	rbp
	jmp	fclose@PLT    # Вызов fclose
	.section	.rodata    # Секция с read-only информацией
.LC0:
	.long	0
	.long	1072693248
.LC1:
	.long	0
	.long	1073741824
.LC2:
	.long	0
	.long	1074790400
.LC10:
	.long	-1717986918
	.long	1069128089
.LC12:
	.long	-755914244
	.long	1062232653
.LC13:
	.long	-500134854
	.long	1044740494
.LC15:
	.long	0
	.long	1071644672