include console.inc
.data
dig16 db '0123456789ABCDEF'
.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 2 (блок 5) "Ввод-вывод шестнадцатеричного числа"'
    XOR EAX, EAX
L:    inchar BL
    cmp BL, ' '
    jE o
    cmp BL, 'A'
    jB digit
    sub BL, 'A'
    add BL, 10
    jmp next
digit: sub BL, '0'
next: 
    OR AL, BL
    rol EAX, 4
    jmp L
o:    
    mov ECX, 8
L1:    
    mov EBX, EAX
    and EBX, 1111b
    rol EAX, 4
    loopz L1
    outchar dig16[EBX]
    jECXZ e
@@: 
    mov EBX, EAX
    and EBX, 1111b
    outchar dig16[EBX]
    rol EAX, 4
    loop @B
e:    pause
    exit
end Start