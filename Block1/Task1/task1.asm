
include console.inc


.data
    N dd ?
.code
Start:
    clrscr
    ConsoleTitle 'Путнев Аркадий (гр 110) Задача 1 (Блок 1) "Степень тройки" '
    inint EAX, 'Введите число: '
    mov ECX, 0 ; K=0
    mov EBX, 3h
    mov EDX, 0
met: cmp EAX, 1
    jE ot
    div EBX
    add ECX, 1
    cmp EDX, 0
    jE met
    mov ECX, -1
ot: outint ECX, 0
    pause
    exit
end Start