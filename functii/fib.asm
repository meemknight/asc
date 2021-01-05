.data
printText: .asciz "fib: %d\n"

.text
.global main

fib:
    pushl %ebp
    movl %esp, %ebp #;initialization
    push %ebx

    movl 8(%ebp), %ebx  #;param 1
    mov $1, %edx

    cmp %ebx, %edx
    je _ONE
    jg _ZERO

    #//calculate fib f(n-1) + f(n-2)
    mov %ebx, %eax
    
    dec %eax
    push %eax
    call fib
    pop %ecx

    mov %ebx, %ecx
    dec %ecx
    dec %ecx
    mov %eax, %ebx

    push %ecx
    call fib
    pop %ecx

    add %ebx, %eax 

    jmp _endFib
    _ONE:
    mov $1, %eax
    jmp _endFib

    _ZERO:
    xor %eax, %eax
    jmp _endFib

    _endFib:
    pop %ebx
    popl %ebp
    ret



main:

    push $6
    call fib
    pop %ebx

    push %eax
    push $printText
    call printf
    pop %ebx
    pop %ebx

exit:
