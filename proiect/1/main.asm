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
printFormat: .asciz "%d "
i:      .long 0
j:      .long 0
ZERO:   .long 0

printSwitchM: .asciz "switch malitios index %d: "

role_host:               .long 1
role_switch:             .long 2
role_switchMalitios:     .long 3
role_controllerLogic:    .long 4

.text

.global main

main:


    #;for(int i=0;i < SIZE; i++)
        xor %eax, %eax
        mov %eax, i
        _l1:

    #;i is 0 - size
      
        #;if roles[i] == 3 (role_switchMalitios)
        mov i, %ecx
        lea roles, %edx
        mov (%edx, %ecx, 4), %ecx
        cmpl %ecx, role_switchMalitios
        jne _l2
        
            #;print switch malicios

            push i
            push $printSwitchM
	        call printf
	        pop %ebx
	        pop %ebx

                #;for(int j=0;j <SIZE; j++)
                xor %eax, %eax
                mov %eax, j
                _l3:

                    #;if(mat[i][j]==1)
                    #;use rax to calculate pos
                    mov j, %eax
                    mov size, %ebx
                    mul %ebx
                    mov i, %ebx
                    add %ebx, %eax

                    lea mat, %edx
                    mov (%edx, %eax, 4), %ecx
                    
                    cmp %ecx, ZERO

                    je _notPrint
                        push j
                        push $printFormat
		                call printf
		                pop %ebx
		                pop %ebx
                    _notPrint:

                 #;i++ if i<size goto
                mov j, %eax
                inc %eax
                mov %eax, j
                cmp size, %eax
                jl _l3

            push $printNl
	        call printf
	        pop %ebx


        _l2:

    #;i++ if i<size goto
        mov i, %eax
        inc %eax
        mov %eax, i
        cmp size, %eax
        jl _l1


_exit:

	push $printNl
	call printf
	pop %ebx

	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
	
	



