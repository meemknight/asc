.data
printText: .asciz "%d, "

.text
.global main

divide:
    pushl %ebp
    movl %esp, %ebp #;initialization
    push %ebx

    movl 8(%ebp), %eax  #;param
    movl 12(%ebp), %ebx  #;param
    #;a / b
    mov $0, %edx

    div %ebx

    mov %edx, %eax
    mov $0, %edx

    cmp %eax, %edx

    je isZero

    mov $0, %eax
    pop %ebx
    popl %ebp
    ret

    isZero:
    mov $1, %eax
    pop %ebx
    popl %ebp
    ret

divizori:
    pushl %ebp
    movl %esp, %ebp #;initialization
    push %ebx

    mov $1, %ecx
    movl 8(%ebp), %ebx  #;param

    start_:

    push %ecx
    push %ebx
    call divide
    pop %ebx
    pop %ecx

    mov $0, %edx
    cmp %eax, %edx  

    jne _esteDivizor
    jmp _nuEsteDivizor

    _esteDivizor:
    push %ecx
    push %ecx
    push $printText
    call printf
    pop %edx
    pop %edx
    pop %ecx

    _nuEsteDivizor:

    inc %ecx
    cmp %ecx, %ebx
    jge start_

    pop %ebx
    popl %ebp
    ret


main:

    push $100
    call divizori
    pop %ebx


exit:

    push $0
    call fflush
    pop %ebx

    mov $1, %eax
    xor %ebx, %ebx
    int $0x80

