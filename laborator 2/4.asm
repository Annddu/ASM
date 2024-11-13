bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 10
    b db 10
    c db 10
    d dw 10

; our code starts here
segment code use32 class=code
    start:
        ; (50-b-c)*2+a*a+d
        ;  a,b,c - byte, d - word
        
        mov AL, 50
        sub AL, [b]
        sub AL, [c]
        mov CL, 2
        mul CL
        
        mov BX, AX
        
        mov AL, [a]
        mul byte [a]
        
        add AX, BX
        add AX, [d] 
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
