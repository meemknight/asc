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

//problema 3 specific
readText: .asciz "rovvya"
printString: .asciz "%s"
letterA: .byte 97
diffInLetters: .byte 26

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
_3for1Start:

#;ecx : 11 10 9 ... 1
    push %ecx
    dec %ecx
    mov %ecx, i

    lea roles, %edx
    mov (%edx, %ecx, 4) ,%ecx
    mov $3, %eax
    cmp %eax, %ecx
    jne _3l5

    movl size, %ecx
    _3for2Start:
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


    loop _3for2Start

    _3l5:
    pop %ecx
loop _3for1Start



#;while (queueIdx != queueLen)
_3l1:
mov queueIdx, %eax
mov queueLen, %ebx
cmp %eax, %ebx
je _3whileEnd1

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

    #;int columnIndex = 0;
    xor %eax, %eax
    mov %eax, columnIndex

    #;while (columnIndex < N)
    _3whileStart:
    mov columnIndex, %eax
    mov size, %ebx
    cmp %ebx, %eax
    jge _3l3

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
        jnz _3whileEnd2

        #;if (visited[columnIndex] != 1)
        lea visited, %edx
        mov columnIndex, %eax
        movl (%edx, %eax, 4), %ecx
        dec %ecx
        jz _3whileEnd2

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

    _3whileEnd2:    

        #;columnIndex
        mov columnIndex, %eax
        inc %eax
        mov %eax, columnIndex

    jmp _3whileStart
    _3l3:

jmp _3l1
_3whileEnd1:


lea visited, %edx
mov b, %ebx

movl (%edx, %ebx, 4), %eax

cmp %eax, ONE
je _3yes

_3no:

    #//unsafe connection

    mov $0 ,%ecx

    _3beginTextConvert:
    
    lea readText, %edx
    movb (%edx, %ecx, 1), %al

    cmp %al, ZERO
    je _3doneTextConvert

    addb $-10, %al

    #// al < 'a'
    cmpb letterA, %al
    jge _3noRound

    addb diffInLetters, %al

    _3noRound:

    movb %al, (%edx, %ecx, 1)

    inc %ecx
    jmp _3beginTextConvert

    _3doneTextConvert:

_3yes:

    push $readText
    push $printString
    call printf
    pop %ebx
    pop %ebx

_exit:

	push $printNl
	call printf
	pop %ebx

	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
	
	



