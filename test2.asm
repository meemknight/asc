.data
		
	a: .long 2
	b: .long -4
	
	text1: .asciz "a >= b\n"
	text2: .asciz "a < b\n"
		
.text

.global _start

_start:

	mov a, %eax
	mov b, %ebx
	
	cmp %ebx, %eax
	
	jge greater
	
notGreater:
	
	mov $4, %eax
	mov $2, %ebx
	mov $text2, %ecx
	mov $6, %edx
	int $0x80
	jmp exit
	
	
greater:

	mov $4, %eax
	mov $1, %ebx
	mov $text1, %ecx
	mov $7, %edx
	int $0x80
	jmp exit
	
exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
	
