	.file	"TP3.c"
	.text
	.def	_main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "Enter an angle in degrees: \0"
LC1:
	.ascii "%d\0"
LC5:
	.ascii "By Calculation Sin(%d) = %lf\12\0"
LC6:
	.ascii "By Library Sin(%d) = %lf\12\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB13:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$80, %esp
	call	___main
	movl	$1, 60(%esp)
	movl	$LC0, (%esp)
	call	_printf
	leal	44(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC1, (%esp)
	call	_scanf
	movl	44(%esp), %eax
	movl	%eax, 24(%esp)
	fildl	24(%esp)
	fldl	LC2
	fmulp	%st, %st(1)
	fldl	LC3
	fdivrp	%st, %st(1)
	fstpl	48(%esp)
	fldl	48(%esp)
	fstpl	64(%esp)
	fldl	64(%esp)
	fstpl	72(%esp)
	jmp	L2
L3:
	addl	$2, 60(%esp)
	fldl	48(%esp)
	fld	%st(0)
	fmulp	%st, %st(1)
	movl	60(%esp), %eax
	movl	$0, %edx
	movl	%eax, 24(%esp)
	movl	%edx, 28(%esp)
	fildq	24(%esp)
	fdivrp	%st, %st(1)
	movl	60(%esp), %eax
	subl	$1, %eax
	movl	%eax, 24(%esp)
	movl	$0, 28(%esp)
	fildq	24(%esp)
	fmulp	%st, %st(1)
	fldl	64(%esp)
	faddp	%st, %st(1)
	fstpl	64(%esp)
	fldl	72(%esp)
	faddl	64(%esp)
	fstpl	72(%esp)
L2:
	fldl	64(%esp)
	fabs
	fcompl	LC4
	fnstsw	%ax
	sahf
	ja	L3
	movl	44(%esp), %eax
	fldl	72(%esp)
	fstpl	8(%esp)
	movl	%eax, 4(%esp)
	movl	$LC5, (%esp)
	call	_printf
	fldl	48(%esp)
	fstpl	(%esp)
	call	_sin
	movl	44(%esp), %eax
	fstpl	8(%esp)
	movl	%eax, 4(%esp)
	movl	$LC6, (%esp)
	call	_printf
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
