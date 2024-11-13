bits 32
global start

extern exit,printf,scanf; add the external functions that we need
import exit msvcrt.dll    
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    n db 0
    message db "Enter ", 0
    element_enter db "Element number %d-> ", 0
    format db "%d " , 0
    ;sir_numere times 100 dd 0
   
segment code use32 class=code
    start:
        ;read n
        push dword message ; ! on the stack is placed the address of the string, not its value
        call [printf]      ; call function printf for printing
        add esp, 4*1       ; free parameters on the stack; 4 = size of dword; 1 = number of parameters
                                                   
        ; will call scanf(format, n) => will read a number in variable n
        ; place parameters on stack from right to left
        push dword n       ; ! addressa of n, not value
         push dword format
        call [scanf]       ; call function scanf for reading
        add esp, 4 * 2 
        
        ;loop for reading numbers
        ; mov ECX, dword[n]
        ; mov ESI, 0
        ; jecxz end_loop
        ; read_loop:
            ; push ECX
            ; push ESI
            
            ; push dword ESI
            ; push dword element_enter
            ; call [printf]
            ; add ESP, 4 * 2
            
            ; ; push dword EAX
            ; ; push dword format
            ; ; call[scanf]
            ; ; add ESP, 4 * 2
            
            
            ; pop ESI
            ; pop ECX
            ; inc ESI
            ; loop read_loop
        ; end_loop:
        
        push dword 0
        call [exit] 