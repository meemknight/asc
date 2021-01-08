.data
printText: .asciz "este palindrom: %d\n"

.text
.global main


palindrom:
    pushl %ebp
    movl %esp, %ebp #;initialization
    push %ebx

    movl 8(%ebp), %eax  #;param 1
    
    
    inversareNumar:
    
        mov $0, %ebx #;accumulator

        start_:

        mov $10, %ecx
        mov $0, %edx
        div %ecx


        #;mull by 10
        push %eax
        push %edx

        mov %ebx, %eax
        mov $0, %edx

        mul %ecx
        mov %eax, %ebx

        pop %edx
        add %edx, %ebx

        pop %eax

        cmp $0, %eax
        jne start_

        mov %ebx, %eax
        
    
    movl 8(%ebp), %ebx  #;param 1

    cmp %eax, %ebx
    je _este

    xor %eax, %eax
    jmp _endFunc

    _este:
    mov $1, %eax

    _endFunc:
    pop %ebx
    popl %ebp
    ret



main:

    push $432340
    call palindrom
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

