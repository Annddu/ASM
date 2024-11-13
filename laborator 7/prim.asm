bits 32
segment code use32 public code
global start        

; declare extern functions used by the programme
extern exit, printf, scanf ; add printf and scanf as extern functions            
import exit msvcrt.dll    
import printf msvcrt.dll    ; tell the assembler that function printf is found in msvcrt.dll library
import scanf msvcrt.dll     ; similar for scanf
                          
segment data use32 class=data
	n dd 13
    
segment code use32 class=code
    start:
        mov EAX, dword[n]
        mov ECX, EAX
        cmp eax, 1
        je not_prime
        cmp eax, 2
        je is_prime
        
        mov ECX, EAX
        mov EBX, 2  ; Initial divisor
        check_divisor:
            mov EDX, 0
            div EBX
            cmp EDX, 0
            je not_prime  ; If remainder is 0, it's not prime
            mov EAX, ECX
            
            inc EBX
            cmp EBX, EAX
            jb check_divisor

        is_prime:
            mov eax, 1
            jmp done

        not_prime:
            mov eax, 0
            jmp done

        done:
        push dword 0      ; place on stack parameter for exit
        call [exit]       ; call exit to terminate the program