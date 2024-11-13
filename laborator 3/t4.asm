bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 25;65000
    b db 5;250
    e dd 50;4294967000
    x dq 100;6744073709551000

; our code starts here
segment code use32 class=code
    start:
        ; x-b+8+(2*a-b)/(b*b)+e; a-word; b-byte; e-doubleword; x-qword
        ; signed reprezentation
        mov AL, byte[b]
        CBW
        CWDE
        mov EBX, EAX
        mov EAX, dword[x+0]
        mov EDX, dword[x+4]
        sub EAX, EBX
        sbb EDX, 0
        add EAX, 8
        adc EDX, 0; edx:eax=x-b+8
        
        push EDX
        push EAX
        
        mov AX, word[a]
        mov BL, 2
        imul BL; dx:ax = 2*a
        
        mov BX,AX; dx:bx = 2*a
        
        mov AL, byte[b]
        CBW;  ax = b
        sub BX, AX 
        sbb DX, 0; dx:bx = 2*a-b
        
        mov AL, byte[b]
        imul byte[b]; ax=b*b
        
        mov CX, AX
        mov AX, BX
        mov BX, CX; dx:ax = 2*a-b bx=b*b
        
        idiv BX; ax=(2*a-b)/(b*b) dx=(2*a-b)%(b*b)
        
        pop EBX
        pop EDX; edx:ebx=x-b+8

        CWDE; eax=(2*a-b)/(b*b)
        mov ECX, EAX
        mov EAX, EBX
        mov EBX, ECX; edx:eax=x-b+8 ebx=(2*a-b)/(b*b)
        add EAX, EBX
        adc EDX, 0; edx:eax=x-b+8+(2*a-b)/(b*b)
        
        add EAX, dword[e]
        adc EDX, 0; edx:eax=x-b+8+(2*a-b)/(b*b)+e
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
