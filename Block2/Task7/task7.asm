include console.inc
.data
    N equ 30 
    X dd N dup(?)

.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 7 (Блок 2) "Сортировка обменом (метод пузырька)"'
    inint ECX
    push ECX
    mov EAX, 0
input: inint X[4*EAX]
    inc EAX
    cmp EAX, ECX
    jNE input
    
L:    mov EDI, 0
    mov EAX, 0
    mov EBX, 1
L1:    mov EDX, X[4*EBX]
    cmp EDX, X[4*EAX]
    jA next
    XCHG X[4*EAX], EDX
    mov X[4*EBX], EDX
    inc EDI
next: inc EAX
    inc EBX
    cmp EBX, ECX
    jNE L1
    cmp EDI, 0
    jE otv
    dec ECX
    cmp ECX, 1
    jNE L
    
otv:    mov EAX, 0
    pop ECX
L2:    outi X[4*EAX],1,' '
    inc EAX
    Loop L2
    
    pause
    exit
end Start