.data

	printFormat: .asciz "Printf\n"


.text

.global main

main:

	push $printFormat
	call printf
	pop %ebx
	
	push $0
	call fflush
	pop %ebx



_exit:
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
