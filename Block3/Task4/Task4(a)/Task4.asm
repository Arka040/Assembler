include console.inc
.data
.code
Start:
    clrscr
    ConsoleTitle 'јркадий ѕутнев (гр 110) «адание 4(a) "–ассвет"'
    outu ESP,, 'ESP = '
    newline
    mov EBX, 0 ; здесь будем хранить здание максимальной высоты
    mov ECX, 0
L:    inint EAX ; ¬водим высоты зданий
    cmp EAX, 0
    jE o
    inc ECX
    push EAX
    jmp L
o:  
    pop EAX
    cmp EAX, EBX 
    jBE no ; если здание ниже всех уже просмотренных зданий, то не выводим его
    outu EAX
    outchar ' '
    outu ECX
    newline
    mov EBX, EAX ; обновл€ем максимум
no:    dec ECX
    cmp ECX, 0
    jNE o
    outu ESP,,'ESP = '
    pause
    exit
end Start