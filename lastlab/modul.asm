bits 32

; indicate to the assembler that the function _sumNumbers should be available to other compile units
global _asmdouble

; the linker may use the public data segment for external datta
segment data public data use32

; the code written in assembly language resides in a public segment, that may be shared with external code
segment code public code use32

; int sumNumbers(int, int)
; cdecl call convention
_asmdouble:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    
    mov ebx, 2
    
    imul ebx
    
    mov esp, ebp
    pop ebp

    ret