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
    b dw 30000
    c dd 2000000000
    d dq 50000000000000

; our code starts here
segment code use32 class=code
    start:
        ; a-b-(c-d)+d
        ; a - byte, b - word, c - double word, d - qword - Signed representation
        
        clc
        mov AL, byte[a]
        CBW ; AX = a
        sub AX, word [b]
        mov DX, 0
        sbb DX, 0 ; DX:AX = a - b
        
        push DX
        push AX
        pop EAX ; EAX = a - b
        CDQ ; EDX:EAX = a - b
        mov EBX, EAX
        mov ECX, EDX ; ECX:EBX = a - b
        
        clc
        mov EAX, dword[c]
        CDQ ; EDX:EAX = c
        sub EAX, dword[d+0]
        sbb EDX, dword[d+4] ; EDX:EAX = c-d
        
        clc
        sub EBX, EAX
        sbb ECX, EDX ; ECX:EBX = a - b-(c-d)
        clc
        add EBX, dword[d+0]
        adc ECX, dword[d+4]
        
        mov EAX, EBX
        mov EDX, ECX
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
