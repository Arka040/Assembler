include console.inc
.data
.code
PRINT proc
    push EBP
    mov EBP, ESP
    push EAX
    inint EAX
    cmp EAX, 0
    jE @out
    jG @plus
    outi EAX,,' '
    call PRINT
    jmp @out
@plus:
    call PRINT
    outi EAX,,' '
@out:
    pop EAX
    pop EBP
    ret 0
PRINT endp
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 7 (Блок 4) "Отрицательные и положительные числа"'
    call PRINT
    pause
    exit
end Start