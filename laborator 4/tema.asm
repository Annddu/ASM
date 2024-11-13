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
    a dw 1111111111111111b
    b dw 1111111111111111b
    c dd 00000000h
    

; our code starts here
segment code use32 class=code
    start:
        ; Given the words A and B, compute the doubleword C as follows:
        ; the bits 0-5 of C are the same as the bits 3-8 of A x 
        ; the bits 6-8 of C are the same as the bits 2-4 of B x
        ; the bits 9-15 of C are the same as the bits 6-12 of A
        ; the bits 16-31 of C have the value 0
        mov BX, word[a]
        mov CL, 3
        shr BX, CL
        and BX, 0000000000111111b
        or word[c], BX
        
        mov BX, word[b]
        mov CL, 2
        shr BX, CL
        and BX, 0000000000000111b
        mov CL, 6
        shl BX, CL
        or word[c], BX
        
        mov BX, word[a]
        mov CL, 6
        shr BX, CL
        and BX, 0000000001111111b
        mov CL, 9
        shl BX, CL
        or word[c], BX
        
        or dword[c+2], 0000000000000000b
        
        mov eax, dword[c]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
