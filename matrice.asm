.data

	v: 	.long 11, 12, 13, 14
		.long 21, 22, 23, 24
		.long 31, 32, 33, 34
		
	n: .long 4
	m: .long 3
	
	printFormat: .asciz "%d "
	printNl: .asciz "\n"
	
.text

.global main

main:

	mov m, %ecx
	
	_l2:
	push %ecx

	#ebx = m - ecx
	mov m, %ebx
	sub %ecx, %ebx
		
	mov $4, %eax
	mul %ebx
	mov n, %ebx
	mul %ebx
	
	lea v, %edi
	add %eax, %edi	
		
		mov n, %ecx
		_l1:
		
		push %ecx
		push %edi
		
		mov n, %ebx
		sub %ecx, %ebx
		
		push (%edi, %ebx, 4)
		push $printFormat
		call printf
		pop %ebx
		pop %ebx
		
		pop %edi
		pop %ecx
		
		loop _l1
	
	push $printNl
	call printf
	pop %ebx
	
	pop %ecx
	loop _l2
	
	
_exit:

	push $printNl
	call printf
	pop %ebx

	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
	
	
	
	
	
