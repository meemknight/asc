.data

printText: .asciz "suma cifre: %d\n"


.text
.global main

sumaCifre:
    pushl %ebp
    movl %esp, %ebp #;initialization
    push %ebx

    movl 8(%ebp), %eax  #;param 1
    mov $0, %ebx #;accumulator

    start_:

    mov $10, %ecx
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

    push $1600120
    call sumaCifre
    pop %ebx

    push %eax
    push $printText
    call printf
    pop %ebx
    pop %ebx

exit:

    push $0
    call fflush
    pop %ebx

    mov $1, %eax
    xor %ebx, %ebx
    int $0x80

