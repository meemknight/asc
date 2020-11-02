.data

	n: .long 13
	estePrim: .long 1	
	
	ZERO: .long 0
	ONE: .long 1

.text

.global _start

_start:

	# in ecx avem n -> 1
	mov n, %ecx
	sub $1, %ecx
	
	_l1:
	mov n, %eax
	mov $0, %edx
	div %ecx
	
	cmp %edx, ZERO
	je notPrime	
	
	sub $1, %ecx
	cmp %ecx, ONE
	jne _l1
	
jmp exit


notPrime:
	
	mov $0, %ecx
	mov %ecx, estePrim

exit:
	
	mov $1, %eax
	mov $0, %ebx
	int $0x80
	
	
	
	
	
	
	
	
	
	
	
	
	
