include console.inc
.data
    HEX db 8 dup('0'),0

.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 5 (блок 2) "Беззнаковое 16-е число"'
    inint EAX
    
next:
    mov ECX, 8
    mov EBX, 16
L:    mov EDX, 0
    dec ECX
    div EBX
    cmp EDX, 9
    jA char
    add EDX, '0'
    mov HEX[ECX], DL
    cmp EAX, 0
    jE otv
    jmp L
char:
    add EDX, 'A'-10
    mov HEX[ECX], DL
    cmp EAX, 0
    jE otv
    jmp L
    
otv: lea EDX, HEX
    outstr EDX
    
    
    pause
    exit
end Start