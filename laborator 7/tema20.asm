bits 32

; Read two doublewords a and b in base 16 from the keyboard. 
; Display the sum of the low parts of the two numbers and the difference between the high parts of the two numbers in base ;  Example:
; a = 00101A35h
; b = 00023219h
; sum = 4C4Eh
; difference = Eh

global start        

; declare extern functions used by the programme
extern exit, printf, scanf ; add printf and scanf as extern functions            
import exit msvcrt.dll    
import printf msvcrt.dll    ; tell the assembler that function printf is found in msvcrt.dll library
import scanf msvcrt.dll     ; similar for scanf
                          
segment data use32 class=data
	a dd 0       
    b dd 0
	message_a db "a = ", 0 
    message_b db "b = ", 0
    format db "%x", 0
	format_sum db "sum = %xh ", 0ah, 0  
    format_difference db "difference = %xh", 0
    
segment code use32 class=code
    start:
       
        ;citim a
        push dword message_a 
        call [printf]      
        add esp, 4*1
        
        push dword a
        push dword format
        call [scanf]
        add esp, 4*2
        mov edx, dword[a]        
        
        ;citim b
        push dword message_b
        call [printf]      
        add esp, 4*1
        
        push dword b
        push dword format
        call [scanf]
        add esp, 4*2
        mov ebx, dword[b]
        
        ;facem suma low
        mov ax, word[a]
        mov bx, word[b]
        add ax, bx
        adc eax, 0
        
        push dword eax
        push dword format_sum
        call [printf]
        add esp, 4*2
        
        ;facem diferenta high
        mov ax, word[a+2]
        mov bx, word[b+2]
        sub ax, bx
        sbb eax, 0
        
        
        push dword eax
        push dword format_difference
        call [printf]
        add esp, 4*2
        
        ; exit(0)
        push dword 0      ; place on stack parameter for exit
        call [exit]       ; call exit to terminate the program