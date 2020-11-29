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
printNo: .asciz "\nNo"

ZERO:   .long 0
ONE:   .long 1


queueLen:   .long 0
queueIdx:   .long 0
queue:      .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
visited:    .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
currentNode:.long 0
columnIndex:.long 0

a: .long 0
b: .long 0

i: .long 0
j: .long 0

.text

.global main

main:

mov $0, %eax
mov %eax, a

mov $10, %eax
mov %eax, b

#;queue[0] = a;
movl a, %eax
movl %eax, (queue)

#;queueLen++;
mov queueLen, %eax
inc %eax
mov %eax, queueLen

#;visited[a] = 1;
lea visited, %edx
mov a, %eax
movl $1, (%edx, %eax, 4)


#;remove bad connections
movl size, %ecx
_for1Start:

#;ecx : 11 10 9 ... 1
    push %ecx
    dec %ecx
    mov %ecx, i

    lea roles, %edx
    mov (%edx, %ecx, 4) ,%ecx
    mov $3, %eax
    cmp %eax, %ecx
    jne _l5

    movl size, %ecx
    _for2Start:
    mov %ecx, %eax
    dec %eax
    mov %eax, j

    #;(mat[i][j]=0)
    #;use rax to calculate pos
    mov i, %eax 
    mov size, %ebx
    mul %ebx
    mov j, %ebx
    add %ebx, %eax
    lea mat, %edx
    movl $0, (%edx, %eax, 4)

    #;(mat[j][i]=0)
    #;use rax to calculate pos
    mov j, %eax 
    mov size, %ebx
    mul %ebx
    mov i, %ebx
    add %ebx, %eax
    lea mat, %edx
    movl $0, (%edx, %eax, 4)


    loop _for2Start

    _l5:
    pop %ecx
loop _for1Start



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


lea visited, %edx
mov b, %ebx

movl (%edx, %ebx, 4), %eax

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
	
	



