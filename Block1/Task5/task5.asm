include console.inc
.data
    

.code
Start:  
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 5 (Блок 1) "Произведение старшей и младшей десятичных цифр"'
    inint EAX, 'Введите число '
    mov EBX, 10
    mov ESI, 0 ; first
    mov EDI, 1 ; last
    
    cmp EAX, 0
    jE otv
    mov EDX, 0
    div EBX
    mov ESI, EDX
    mov EDI, EDX
    
L: cmp EAX, 0
    jE otv
    mov EDX, 0
    div EBX
    mov EDI, EDX
    Loop L

otv: mov EAX, ESI
    mul EDI
    outint EAX

    
    pause
    exit
end Start