.data

	putere: .long 1
	zero: .long 0
.text

.global _start

_start:

	mov $1, %ecx
	mov putere, %eax


	_l1:
		mov $2, %ebx	
		mul %ebx
		#sub $1, %ecx
		#cmp %ecx, zero
		#jne _l1
		loop _l1
	
	mov %eax, putere

finish:

	mov $1, %eax
	mov $0, %ebx
	int $0x80	
	

