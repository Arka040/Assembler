include console.inc

.data
    P dd ?
    Q dd ?


.code
Start:
    clrscr
    ConsoleTitle 'Путнев Аркадий (гр 110) Задание 4 (блок 1) "Дробь P/Q"'
    inint P, 'P='
    inint Q, 'Q='
    mov EAX, P
    mov EDX, 0
    mov EBX, Q
    mov ECX, 5
    mov ESI, 10
    div EBX
    outword EAX
    outchar '.'
L:  mov EAX, EDX
    mov EDX, 0
    mul ESI
    div EBX
    outword EAX 
    Loop L
    
    
    
    
    
    
    pause
    exit
end Start