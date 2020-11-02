.data

	v: .long -5, 10, 13, 8
	w: .long 2, -1, 3, 0
	s: .long 0	
	
.text

.global _start

_start:

	mov $3, %ecx

_l1:
	lea v, %eax
	mov (%eax, %ecx, 4), %eax
	
	lea w, %ebx
	mov (%ebx, %ecx, 4), %ebx
	mov $0, %edx
	
	imul %ebx
	add s, %eax 	
	mov %eax, s
loop _l1

	
exit:

	mov $0, %eax
	mov $1, %ebx
	int $0x80














