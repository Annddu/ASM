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
    s1 db 'a','b','c','d','e'
    l1 equ $-s1
    s2 db 6,7,8
    l2 equ $-s2
    lend equ l1+l2
    d times lend db 0
    ;abcde876

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, l1
        mov esi, 0
        mov edi, 0
        jecxz final_loop1
        loop1:
            mov al, [s1+esi]
            mov [d+edi], al
            inc esi
            inc edi
            loop loop1
        final_loop1:
        
        mov ecx, 12
        mov esi, l2-1
        jcxz final_loop2
        loop2:
            mov al, [s2+esi]
            mov [d+edi], al
            dec esi
            inc edi
            loop loop2
        final_loop2:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
