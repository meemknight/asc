.data

mat:    .long 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0
        .long 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0
        .long 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0
        .long 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0
        .long 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0
        .long 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0
        .long 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0
        .long 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0
        .long 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0
        .long 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1
        .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0

roles:   .long 1, 1, 2, 4, 2, 1, 3, 2, 4, 3, 1
size:   .long 11
printNl: .asciz "\n"
printF: .asciz "host index %d; "

printYes: .asciz "\nYes"
printNo: .asciz "\nNod"

ZERO:   .long 0
ONE:   .long 1


queueLen:   .long 0
queueIdx:   .long 0
queue:      .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
visited:    .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
currentNode:.long 0
columnIndex:.long 0

.text

.global main

main:


#;queueLen++;
mov queueLen, %eax
inc %eax
mov %eax, queueLen

#;visited[0] = 1;
lea visited, %edx
mov $0, %eax
movl $1, (%edx, %eax, 4)

#;while (queueIdx != queueLen)
_l1:
mov queueIdx, %eax
mov queueLen, %ebx
cmp %eax, %ebx
je _whileEnd1

    #;int currentNode = queue[queueIdx];
    lea queue, %edx
    mov queueIdx, %eax
    movl (%edx, %eax, 4), %ebx
    mov %ebx, currentNode

    #; queueIdx++;
    mov queueIdx, %eax
    inc %eax
    mov %eax, queueIdx

    #;if (roles[currentNode] == 1)
    lea roles, %edx
    mov currentNode, %eax
    movl (%edx, %eax, 4), %ebx
    dec %ebx
    jnz _l2

        #;printf("%d ", currentNode);
        push currentNode
        push $printF
        call printf
        pop %ebx
        pop %ebx

    _l2:

    #;int columnIndex = 0;
    xor %eax, %eax
    mov %eax, columnIndex

    #;while (columnIndex < N)
    _whileStart:
    mov columnIndex, %eax
    mov size, %ebx
    cmp %ebx, %eax
    jge _l3

		#;if (graph[currentNode][columnIndex] == 1)
        #;use eax to calculate pos
        mov currentNode, %eax
        mov size, %ebx
        mul %ebx
        mov columnIndex, %ebx
        add %ebx, %eax
        lea mat, %edx
        movl (%edx, %eax, 4), %ecx
        dec %ecx
        jnz _whileEnd2

        #;if (visited[columnIndex] != 1)
        lea visited, %edx
        mov columnIndex, %eax
        movl (%edx, %eax, 4), %ecx
        dec %ecx
        jz _whileEnd2

            #;queue[queueLen] = columnIndex;
            mov columnIndex, %ebx
            lea queue, %edx
            mov queueLen, %eax
            movl %ebx, (%edx, %eax, 4)
            					
            #;queueLen++;
            mov queueLen, %eax
            inc %eax
            mov %eax, queueLen

            #;visited[columnIndex] = 1;
            lea visited, %edx
            mov columnIndex, %eax
            movl $1, (%edx, %eax, 4)

    _whileEnd2:    

        #;columnIndex
        mov columnIndex, %eax
        inc %eax
        mov %eax, columnIndex

    jmp _whileStart
    _l3:

jmp _l1
_whileEnd1:

mov size, %ecx
mov $1, %eax
lea visited, %edx

_l4:

dec %ecx
mov (%edx, %ecx, 4), %ebx
inc %ecx

and %ebx, %eax

loop _l4

cmp %eax, ONE
je _yes

_no:

    push $printNo
	call printf
	pop %ebx

jmp _exit
_yes:

    push $printYes
	call printf
	pop %ebx


_exit:

	push $printNl
	call printf
	pop %ebx

	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
	
	



