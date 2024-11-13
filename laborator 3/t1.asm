bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 100
    b dw 30000
    c dd 2000000000
    d dq 5000000000000000

; our code starts here
segment code use32 class=code
    start:
        ; (a + c) - b + a + (d - c)
        ; a - byte, b - word, c - double word, d - qword - Unsigned representation
        
        mov AL, [a]
        mov AH, 0
        mov DX, 0 ;            DX:AX = a
        
        add AX, [c]
        adc DX, [c+2] ;        DX:AX = a + c
        
        sub AX, word[b]
        sbb DX, 0
        add AL, byte[a] 
        adc AH, 0 ;            DX:AX = (a + c) - b + a
        push DX
        push AX
        pop EAX ;              EAX = (a + c) - b + a
        
        mov EBX, dword [d+0]
        mov ECX, dword [d+4] ; ECX:EBX = d
        sub EBX, dword [c] 
        sbb ECX, 0 ;           ECX:EBX = d - c
        
        mov EDX, ECX
        add EAX, EBX
        adc EDX, 0 ;           EDX:EAX = (a + c) - b + a + (d - c)
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
