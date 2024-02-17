include console.inc
.data
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 10 (блок 1) "Таблица умножения"'
.code
Start:
    clrscr
    mov EAX, 0
    mov ECX, 10
    outstr '   |'
L:    outi EAX,3
    inc EAX
    Loop L
    newline
    mov ECX, 10
    outstr '----------------------------------'
    newline
    
    mov EBX, 0
L1: outint EBX
    outstr '  |'
    mov ECX, 10
    mov EAX, 0
L2:    outi EAX,3
    add EAX, EBX
    Loop L2
    inc EBX
    newline
    cmp EBX, 10
    jNE L1
    
    
    
    pause
    exit
end Start



