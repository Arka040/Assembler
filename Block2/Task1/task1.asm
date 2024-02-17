include console.inc

.data
    LAT db 'Z'-'A'+1 dup(0); LAT['A'..'Z'] of 0..1

.code
Start:
    clrscr
    ConsoleTitle 'Путнев Аркадий (гр 110) Задание 1 (Блок 2) "Первые вхождения"'
L:  inchar AL
    movzx EAX, AL
    cmp AL, '.'
    jE e
    cmp LAT[EAX-'A'], 1
    jE L
    mov LAT[EAX-'A'], 1
    outchar AL
    jmp L
    
    
    
e:
    
    pause
    exit
end Start

