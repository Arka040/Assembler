include console.inc
.data

.code
REVERSE proc
    push EBP
    mov EBP, ESP
    push EAX
    inchar AL
    cmp AL, '.'
    jE @out
    call REVERSE
    outchar AL
@out:
    pop EAX
    pop EBP
    ret 0
REVERSE endp
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 6 (Блок 4) "Текс наоборот (рекурсия без параметров)"'
    call REVERSE
    
    pause
    exit
end Start