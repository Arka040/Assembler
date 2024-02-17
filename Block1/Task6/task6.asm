include console.inc
.data

.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 6 (блок 1) "Пятеричное число"'
    mov EAX, 0
    mov EBX, 5
L:  inchar CL
    cmp CL, ' '
    jE otv
    mov EDX, 0
    mul EBX
    movzx ECX, CL
    sub ECX, '0'
    add EAX, ECX
    jmp L
    
otv: outword EAX    
    
    pause
    exit
end Start 