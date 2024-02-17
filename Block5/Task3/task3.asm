include console.inc
.data

.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 3 (блок 5) "Анализ и преобразование двоичного числа"'
    XOR EAX, EAX
    mov ECX, 8
L:    
    mov EBX, 4
L1: SHL EAX, 1   
    inchar DL
    sub DL, '0'
    OR AL, DL
    
    dec EBX
    cmp EBX, 0
    jNE L1
    inchar DL
    dec ECX
    cmp ECX, 0
    jNE L
    
    mov EBX, EAX
    mov ECX, 32
@@: rol EAX, 1
    rcr EBX, 1
    LOOP @B
    
    xor EBX, EAX
    jZ yes
    outstrln 'НЕСИММЕТРИЧНО'
    xor DL, DL ; идея в том, чтобы сначала записать в DL правый бит EAX (благодаря
    ror EAX, 1 ; циклическому сдвигу вправо). Затем вернуть EAX в исходное состояние 
    adc DL, 0 ; и еще раз сдвинуть влево (2 циклических сдвига влево).  
    rol EAX, 2 ; Затем сдвиг DL вправо, чтобы в CF получить правый бит EAX (который лежал в DL).  
    ror DL, 1 ; 
    rcr EAX, 1 ; Затем сдвиг EAX вправо с учетом предыдущего CF (rcr) в котором у нас правый бит EAX.
    adc DL, 0 ; Получается записали в левый бит EAX правый бит. В CF у нас левый бит EAX.
    ror EAX, 1 ; Записываем этот бит в DL и делаем то же самое только справа EAX.
    ror DL, 1 ;
    rcl EAX, 1 ;
    jmp otv
yes:
    outstrln 'СИММЕТРИЧНО'
    mov ECX, 16
    ror EAX, CL ; Сдвигаем число так, чтобы первый справа от центра бит улетел на другой конец 
@@: XOR DL, DL ; (двигаем вправо пока бит не улетит влево)
    rol EAX, 1  ; Возвращаем улетевший бит в начало справа. Поучаем его в CF и сравниваем его с 1
    adc DL, 0 ; Если 1, то сдвигаем число вправо ( бит улетает в левый конец) и через rcl 
    loopz @B ; сдвигаем влево. Тогда наш единичный бит станет ноликом и запишется в начало справа.
    ror EAX, 1 ;
    xor DL, DL ;
    ror DL, 1 ;
    rcl EAX, 1  ; 
    rol EAX, CL ;возвращаем число в исходное состояние и делаем то же самое слева
  
    mov ECX, 16
    rol EAX, CL
@@: XOR DL, DL
    ror EAX, 1   
    adc DL, 0
    loopz @B
    rol EAX, 1
    xor DL, DL
    rol DL, 1
    rcr EAX, 1
    
    ror EAX, CL
    
otv:    
    mov ECX, 8
LOT:   mov EBX, 4
LO: XOR DL, DL   
    shl EAX, 1
    adc DL, 0
    outword DL
    dec EBX
    cmp EBX, 0
    jNE LO
    outchar ' '
    dec ECX
    cmp ECX, 0
    jNE LOT
    pause
    exit
end Start