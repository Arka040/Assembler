include console.inc
.data

.code
OutD proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push ESI
    push EDI
    
    mov ECX, 0
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
@L: mov EDX, 0
    div EBX
    push EDX
    inc ECX
    cmp EAX, 0
    jNE @L
    
@o: pop EAX
    outi EAX
    dec ECX
    cmp ECX, 0
    jNE @o
    
    
    pop EDI
    pop ESI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2
    
OutD endp
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 1 (Блок 4) "Системы счисления"'
    
    inint EAX,"Введите число: "
    inint EBX,'Введите систему счисления: '
    push EBX
    push EAX
    call OutD
    pause
    exit
end Start



