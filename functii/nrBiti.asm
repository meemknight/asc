.data
printText: .asciz "nr biti setati: %d\n"

.text
.global main

nrBiti:
    pushl %ebp
    movl %esp, %ebp #;initialization
    push %ebx

    movl 8(%ebp), %eax  #;param 1
    mov $0, %ebx #;accumulator

    start_:

    mov $2, %ecx
    mov $0, %edx
    div %ecx
    add %edx, %ebx

    cmp $0, %eax
    jne start_
 
    mov %ebx, %eax

    pop %ebx
    popl %ebp
    ret



main:

    push $4
    call nrBiti
    pop %ebx

    push %eax
    push $printText
    call printf
    pop %ebx
    pop %ebx

exit:
