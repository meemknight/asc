.data
printText: .asciz "cea mai mica putere: %d\n"

.text
.global main

ceaMaiMicaPutere:
    pushl %ebp
    movl %esp, %ebp #;initialization
    push %ebx

    mov $0, %eax
    mov $1, %ebx
    movl 8(%ebp), %ecx  #;param

    start_:
    cmp %ecx, %ebx
    jge end_

    inc %eax
    shl %ebx

    jmp start_
    end_:

    pop %ebx
    popl %ebp
    ret

main:


main:

    push $32
    call ceaMaiMicaPutere
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

