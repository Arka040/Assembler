include console.inc
.data


.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 1 (блок 3) "Алгебраическая сумма"'
    mov EAX, 0
L:    inchar AL
    cmp AL, '.'
    jE otv
    cmp AL, '0'
    jB next
    sub AL, '0'
    push EAX
    jmp L
next: cmp AL, ')'
    jNE step
    pop EBX
    pop ECX
    cmp ECX, '+'
    jE sum
    pop EDX
    sub EDX, EBX
    push EDX
    jmp L
sum: pop EDX
    add EDX, EBX
    push EDX
    jmp L  
step: cmp AL, '('
    jE endstep
    push EAX
endstep: jmp L
otv: pop EAX
    outi EAX

    
    pause
    exit
end Start