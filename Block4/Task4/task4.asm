include console.inc
.data
N equ 100
S db N dup (?)
.code
Back proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    mov EAX, [EBP+8] ; left
    mov EBX, [EBP+12] ; right
   
    dec EBX
@L:    mov CL, byte ptr [EAX]
    xchg CL, byte ptr [EBX]
    mov byte ptr [EAX], CL
    
    inc EAX
    dec EBX
    
    mov EDX, EBX
    sub EDX, EAX
    cmp EDX, 0
    jG @L
        
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2    
Back endp

Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 4 (Блок 4) "Переворот порядка слов (не рекурсивная)"'
    mov EDI, offset S
    
L:    inchar AL
    cmp AL, '.'
    jE e
    mov byte ptr [EDI], AL
    inc EDI
    jmp L
e:   
    mov ESI, offset S
    
    push EDI
    push ESI
    call Back
 
    mov EAX, EDI
    dec ESI
    
Wrd:
    inc ESI
    cmp ESI, EAX    
    jE print
    cmp byte ptr [ESI], ' '
    jNE yes
    jmp Wrd
yes:    mov EDI, ESI
Word1:    
    inc EDI
    cmp EDI, EAX
    jE flip
    cmp byte ptr [EDI], ' '
    jE flip
    jmp Word1
flip:
    push EDI
    push ESI
    call Back
    mov ESI, EDI
    dec ESI
    jmp Wrd
    
print:   mov ESI, offset S
p:    outchar byte ptr [ESI]
    inc ESI
    cmp ESI, EAX
    jNE p
    
    pause
    exit
end Start