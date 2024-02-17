include console.inc
.data
.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 4 (б) "Рассвет"'
    outu ESP,,'ESP = '
    newline
    mov EBP, ESP
    sub EBP, 4
    mov ECX, 0
L:    inint EAX ; ввод значений
    cmp EAX, 0
    jE o
    push EAX
    inc ECX ; счетчик домов
    jmp L
o:
    mov ESI, ESP
    sub ESI, 4 ; ESI буду потом использовать для сравнений чтобы выходить из цикла
    mov EDI, EBP
    mov EDX, 1 ; бегунок по номеру домов
    
LL:    mov EBX, [EDI] ; взяли дом
    mov EBP, EDI ; записали его смещение
L1:    sub EBP, 4 ; перешли на следющий дом
    cmp EBP, ESI ; сравнили с концом стека 
    jE yes ; если конец, то мы сравнили все дома восточнее взятого и они оказались все ниже
    cmp EBX, [EBP] ; сравниваем высоту взятого дома с более восточным
    jBE no ; если восточный выше или такой-же, то берем следующий дом
    jmp L1
    
yes:  outu EBX ; вывод дома который видит рассвет
    outchar ' '
    outu EDX
    newline
    
no: inc EDX ; берем номер следующего дома
    sub EDI, 4 ; берем адрес следующего дома
    cmp EDI, ESI ; сравниваем не закончились ли дома
    jNE LL
    
@@: pop EAX ; очистка стека
    dec ECX
    jNZ @B
    
    outu ESP ,,'ESP = '
    pause
    exit
end Start