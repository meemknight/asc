.data

	msg: .asciz "test2\n"

.text

.global _start

_start:

	mov $4, %eax
	mov $1, %ebx
	mov $msg, %ecx
	mov $7, %edx
	int $0x80

	mov $1, %eax
	mov $0, %ebx
	int $0x80
	
