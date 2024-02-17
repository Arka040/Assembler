include console.inc
.data
.code
MaxMin proc
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    
    inchar AL
    cmp AL, 'M'
    jE @Max
    cmp AL, 'm'
    jE @Min
    cmp AL, ','
    jE @c
    cmp AL, ')'
    jE @c
    cmp AL, '('
    jE @c
    sub AL, '0'
    jmp @e
@Max:
    call MaxMin
    mov BL, AL
    call MaxMin
    cmp BL, AL
    jB @e
    mov AL, BL
    jmp @e
    
@Min:
    call MaxMin
    mov BL, AL
    call MaxMin
    cmp BL, AL
    jA @e
    mov AL, BL
    jmp @e
@c:
    call MaxMin
@e:   
    pop ECX
    pop EBX
    pop EBP
    ret 0
MaxMin endp
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 9 (Блок 4) "Максимум и минимум"'
    mov AL, 0
    call MaxMin
    outu AL
    pause
    exit
end Start