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
    a dw 1011101110111011b
    b dw 1001100110011001b
    c dw 0

; our code starts here
segment code use32 class=code
    start:
        ; Give the word A and B compute the word C as follows:
        ; The bits 0-2 of C are the same as the bits 10-12 of B
        ; The bits 3-6 of C have the value 1
        ; The bits 7-10 of C are the same as the bits 1-4 pf A
        ; The bits 11-12 of C have the value 0
        ; The bits 13-16 of C are the invert of the bits 9-11 of B
    
        mov Bx, word[b]
        shr Bx, 10
        and Bx, 0000000000000111b
        or word[c], bx
        or word[c], 000000000111000b
        mov AX, word[a]
        rol AX, 6
        and AX, 0000011110000000b
        or word[c], AX
        and word[c], 1110011111111111b
        mov bx, word[b]
        mov cl, 4
        rol bx, cl
        and bx, 1110000000000000b
        or word [c], bx
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
