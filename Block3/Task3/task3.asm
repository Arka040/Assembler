include console.inc
.data

.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 3 (Блок 3) "Округление"'
    outu ESP,, 'ESP = '
    newline
    newline
    
    mov EBP, ESP
    sub EBP, 4
    
    mov EAX, 0
    mov EBX, 0
L:    inchar AL
    cmp AL, ' '
    jE er
    cmp AL, '.'
    jE s
    sub AL, '0'
    inc BL
    push EAX
    jmp L
    
    
s: 
    mov BH, BL
NL:    inchar AL
    cmp AL, ' '
    jE next
    cmp AL, '.'
    jE s
    sub AL, '0'
    inc BL
    push EAX
    jmp NL
    
next: 
    
    mov DH, BL
    sub BL, BH ; в BL количество цифр после запятой. в BH количество цифр до запятой
    mov DL, BL
    
    inint AL, 'm = ' ; AL = m       
    cmp BL, AL ; если количество цифр после запятой меньше либо равно m, то сразу вывводим число 
    jBE ot
    
@@: pop EDI ; этот цикл выкидывает лишние цифры после запятой
    dec DL
    cmp DL, AL
    jNE @B
    
    mov ESI, ESP
    sub ESI, 4
    mov BL, DL
    mov DH, BH
    add DH, BL ; в DH - общее количество цифр после того как убрали лишние (это нужно для очисти стека в конце)
    
    movzx ECX, byte ptr [ESI] ; далее я проверяю m+1 число для округления
    cmp ECX, 5
    jB no ; не надо округлять значит
    movzx EDI, byte ptr [ESI+4]
    add EDI, 1
    mov [ESI+4], EDI
    mov [ESI], ECX

    add ESI, 4
again:    cmp byte ptr [ESI], 10 ; этот цикл проверяет появилась ли 10 после округления
    jNE ot                       ; (пример: 0.49999, m=4: в стеке будет лежать 0 4 9 9 10  превращаем эту 10 в 0 и увеличиваем следующюю цифру)   
    movzx ECX, byte ptr [ESI]
    sub ECX, 10
    mov [ESI], ECX
    add ESI, 4
    cmp ESI, EBP
    jA DopOne ; если вдруг дошли до первой цифры, то перед ней выведем 1
    movzx ECX, byte ptr [ESI]
    inc ECX
    mov [ESI], ECX
    jmp again
    
DopOne: outchar '1'
no: mov [ESI], ECX
ot:    
    movzx ECX, byte ptr [EBP] ; вывод чисел до запятой
    add ECX, '0'
    outchar CL
    sub EBP, 4
    dec BH
    jNZ ot
    
    cmp DL, 0 ; проверка на то надо ли точку выводить
    jE e
    outchar '.'

ot2: 
    cmp DL, 0 ; вывод чисел после запятой
    jE zeros
    movzx ECX, byte ptr [EBP]
    add ECX, '0'
    outchar CL
    sub EBP, 4
    dec DL
    jmp ot2
    
zeros: cmp BL, AL ; вывод нулей
    jE e
    outu 0
    inc BL
    jmp zeros
    
er: outstr 'Ошибка ввода'
    mov DH, BL
e:  pop ECX ; очистка стека
    dec DH
    cmp DH, 0
    jNZ e
    
    newline
    newline
    outu ESP,,'ESP = '
    
    pause
    exit
end Start