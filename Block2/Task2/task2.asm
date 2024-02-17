include console.inc
.data
    z2 db 'неуд',0
    z3 db 'удовл',0
    z4 db 'хорошо',0
    z5 db 'отлично',0
    adr dd z2,z3,z4,z5;

.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 2 (блок 2) "Зачет с оценкой"'
    inint EAX
    sub EAX, 2
    mov EAX, adr[4*EAX]
    outstr EAX
    
    pause
    exit
end Start




