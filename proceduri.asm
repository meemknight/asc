.data

printText: .asciz "suma %d\n"


.text
.global main

suma:
    pushl %ebp
    movl %esp, %ebp #;initialization

    movl 8(%ebp), %eax  #;param 1
    movl 12(%ebp), %ebx  #;param 1
    addl %ebx, %eax

    popl %ebp
    ret

main:

    push $4
    push $16
    call suma
    pop %ebx
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

