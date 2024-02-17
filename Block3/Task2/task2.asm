include console.inc
.data
.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задача 2 "Max/Min"'
    mov EAX, 0
L:    inchar AL
    cmp AL, '.'
    jE e
    cmp AL, '('
    jE L
    cmp AL, ','
    jE L
    cmp AL, ')'
    jE res
    push EAX
    jmp L
    
res:
    pop EBX
    pop ECX
    pop EDX
    cmp DL, 'm'
    jE min
    cmp EBX, ECX
    jBE f
    push EBX
    jmp L
f: push ECX
    jmp L
min: cmp EBX, ECX
    jBE ff
    push ECX
    jmp L
ff: push EBX
    jmp L

e:
    pop EAX
    outchar AL
    pause
    exit
end Start