include console.inc
.data
.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 1 (блок 5) "Ввод-вывод двоичного числа"'
    XOR EAX, EAX
    mov ECX, 32
    inchar DL
    sub DL, '0'
    OR AL, DL
L:    inchar DL
    cmp DL, ' '
    jE o
    SHL EAX, 1
    sub DL, '0'
    OR AL, DL
    jmp L
o:
L1:    XOR DL, DL
    SHL EAX, 1
    adc DL, 0
    loopz L1
    outword DL
L2:    jECXZ en
    XOR DL, DL
    SHL EAX, 1
    adc DL, 0
    outword DL
    dec ECX
    jmp L2 ; jECXZ не работает
en:    
    pause
    exit
end Start