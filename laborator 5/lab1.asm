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
    s db 1,2,3,4,5
    l equ $-d
    lend equ l-1
    D times lend db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, lend
        jecxz final
        repeat 
        mov al, [D + esi]
        mov bl, [s + esi + 1]
        add al, bl
        mov [d + esi], al
        inc esi
        loop repeat
        final:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
