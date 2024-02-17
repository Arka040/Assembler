include console.inc
.data
.code
GCD proc
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    
    mov EBX, [EBP+8]
    mov ECX, [EBP+12]
    
    mov EDX, 0
    cmp EBX, 0
    jE @out
    cmp ECX, 0
    jE @out
    cmp EBX, ECX
    jA @yes
    mov EAX, ECX
    div EBX
    mov ECX, EDX
    push ECX
    push EBX
    call GCD
    jmp @e
@yes:
    mov EAX, EBX
    div ECX
    mov EBX, EDX
    push ECX
    push EBX
    call GCD
    jmp @e
@out:
    mov EAX, EBX
    add EAX, ECX
@e:    pop EDX
    pop ECX
    pop EBX
    pop EBP
    ret 4*2
GCD endp
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 8 (Блок 4) "НОД"'
    inint EBX,'A = '
    inint ECX,'B = '
    push ECX
    push EBX
    call GCD
    outu EAX,,'НОД = '
    pause
    exit
end Start