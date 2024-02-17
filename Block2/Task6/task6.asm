include console.inc
.data
    N equ 30 
    X dd N dup(?)

.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 6 (блок 2) "Сортировка выбором"'
    inint ECX
    push ECX
    mov EAX, 0
L:  inint X[4*EAX]
    inc EAX
    cmp EAX, ECX
    jNE L
L1:    mov EBX, 0
    mov EDX, 0
    dec ECX
    mov EAX, X[0]
search: inc EBX    
    cmp EAX, X[4*EBX]
    jGE next
    mov EAX, X[4*EBX]
    mov EDX, EBX
next:
    cmp EBX, ECX
    jNE search
    XCHG EAX, X[4*ECX]
    mov X[4*EDX], EAX
    cmp ECX, 1
    jNE L1
    
    pop ECX
    mov EAX, 0
otv1: outi X[4*EAX],,' '
    inc EAX
    cmp EAX, N
    Loop otv1
    
    
    
    pause
    exit
end Start