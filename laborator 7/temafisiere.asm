bits 32

;A file name and a text (defined in the data segment) are given. The text contains lowercase letters and spaces. Replace all the letters on even positions with their position. Create a file with the given name and write the generated text to file.

global start

extern exit, fopen, fprintf, fclose
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data
    file_name db "sir.txt", 0
    access_mode db "w", 0
    text db "a b  c  d e" 
    len equ $-text
    file_descriptor dd -1           ; variable to hold the file descriptor
    textd times len db 0
    
    
; our code starts here
segment code use32 class=code
    start:
        mov ecx, len
        mov esi, 0
        mov edi, 0
        
        jecxz final_loopp
        loopp:
            mov ah, [text + esi]
            
            cmp ah, ' '
            je spatiu ; spatiu
            
            inc edi
            test edi, 1
            jnz spatiu ; impar
            
            add edi, 48
            mov [textd + esi], edi
            sub edi, 48
            inc esi
            jmp endd
            
            spatiu:
                mov [textd + esi], ah
                inc esi
            
            endd:
                loop loopp
        final_loopp:
        
        
        
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2                

        mov [file_descriptor], eax  

        ; verificam daca fisierul a fost creat
        cmp eax, 0
        je final

        push dword textd
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2

        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        final:
        
        ; exit(0)
        push dword 0
        call [exit]
            
            ;mov ah, [text + esi]
            
            ; cmp ah, ' '
            ; je spatiu ; spatiu
            
            ; test esi, 1
            ; jnz spatiu ; impar
            
            ; add esi, 48
            ; mov [textd + esi], esi
            ; sub esi, 48
            
            ; inc esi
            ; jmp endd
            
            ; spatiu:
            ; mov [textd + esi], ah
            ; inc esi
            ; endd:
            ; loop loopp