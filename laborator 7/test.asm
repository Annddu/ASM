bits 32

global start        

; declare extern functions used by the programme
extern exit, printf, scanf ; add printf and scanf as extern functions            
import exit msvcrt.dll    
import printf msvcrt.dll    ; tell the assembler that function printf is found in msvcrt.dll library
import scanf msvcrt.dll     ; similar for scanf
                          
segment data use32 class=data
	n dd  0       ; in this variable we'll store the value read from the keyboard
    element dd 0
    sir_numere times 100 dd 0
    
    ; char strings are of type byte
	message  db "Enter the number of elemnets ", 0 
    message1 db "List of prime numbers:", 0ah, 0
    element_enter db "Element number %d-> ", 0
	format  db "%d", 0  ; %d <=> a decimal number (base 10)
    format1  db "%d", 0ah ,0
    
segment code use32 class=code
    prime:
        mov EAX, [ESP + 4]
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
        ret 4
    
    start: 
        ; push dword message 
        push dword message
        call [printf]   
        add esp, 4*1    
                                                   
        push dword n    
        push dword format
        call [scanf]      
        add esp, 4 * 2   
        
        ;loop for reading numbers
        mov ECX, dword[n]
        mov ESI, 0
        jecxz end_loop
        read_loop:
            push ECX
            push ESI
            
            push dword ESI
            push dword element_enter
            call [printf]
            add ESP, 4 * 2
            
            push dword element
            push dword format
            call [scanf]
            add ESP, 4 * 2
            mov EAX, dword[element]
            
            pop ESI
            mov [sir_numere + 4*ESI], EAX
            pop ECX
            
            inc ESI
            loop read_loop
        end_loop:
        
        push dword message1
        call [printf]   
        add esp, 4*1
        
        mov ECX, dword[n]
        mov ESI, 0
        jecxz end_loop1
        prime_loop:   
            push ECX
            push ESI
            
            mov EAX, dword[sir_numere + 4*ESi]
            push dword EAX
            call prime
            
            pop ESI
            push ESI
            cmp EAX, 1
            jne no_print
            
            print:
                pop ESI
                push ESI
                push dword ESI
                push dword element_enter
                call [printf]
                add ESP, 4 * 2
                
                pop ESI
                push ESI
                push dword [sir_numere + 4*ESi]
                push dword format1
                call [printf]
                add ESP, 4 * 2
                
            no_print:
            
            pop ESI
            pop ECX
            inc ESI
            loop prime_loop
        end_loop1:
        
        
        ; exit(0)
        push dword 0      ; place on stack parameter for exit
        call [exit]       ; call exit to terminate the program