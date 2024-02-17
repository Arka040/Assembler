include console.inc
.data
.code
Form proc
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    
    inchar CL
    cmp CL, '+'
    jE @plus
    cmp CL, '-'
    jE @Minus
    cmp CL, '*'
    jE @Mul
    cmp CL, ')'
    jE @e
    cmp CL, '('
    jE @c
    sub CL, '0'
    mov AL, CL
    jmp @c
@plus:
    mov EBX, EAX
    call Form
    add EBX, EAX
    jmp @m
    
@Minus:
    mov EBX, EAX
    call Form
    sub EBX, EAX
    jmp @m
@Mul:
    mov EBX, EAX
    call Form
    xchg EBX, EAX
    mul EBX
    xchg EBX, EAX
    jmp @m
@c:
    call Form
    jmp @e
@m: mov EAX, EBX
@e:   
    
    pop ECX
    pop EBX
    pop EBP
    ret 0
Form endp

Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 10 (Блок 4) "Формула"'
    call Form
    outi AL
    pause
    exit
end Start