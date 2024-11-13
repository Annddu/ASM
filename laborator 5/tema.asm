bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    a db 2,1,3,3,4,2,6
    la equ $-a
    b db 4,5,7,6,2,1
    lb equ $-b
    lend equ la+lb
    d times lend db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the even elements of A.
        ;Example:
        ;A: 2, 1, 3, 3, 4, 2, 6
        ;B: 4, 5, 7, 6, 2, 1
        ;R: 1, 2, 6, 7, 5, 4, 2, 4, 2, 6
        
        mov edi, 0
        
        mov ecx, lb
        mov esi, lb-1
        jcxz end1
        loop1:
            mov al, [b+esi]
            mov [d+edi], al
            dec esi
            inc edi
            loop loop1
        end1:
        
        mov ecx, la
        mov esi, 0
        jecxz end2
        loop2:
            mov al, [a+esi]
            test al, 1
            jnz impar           ;daca nr e impar sare peste secventa par
            par:
                mov [d+edi], al
                inc edi
            impar:
            inc esi
            loop loop2
        end2:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
