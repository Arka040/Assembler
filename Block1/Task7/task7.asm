include console.inc
.data
    N dd ?
.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 7 (блок 1) "Ближайшее число, кратное семи"'
    
    inint N
    mov EAX, N
    mov EDX, 0
    mov EBX, 7
    mov ECX, 0
    div EBX
    cmp EDX, 3
    jBE LL
    
LH: cmp EDX, 0
    jE otv
    add ECX, 1
    mov EAX, N
    add EAX, ECX
    mov EDX, 0
    div EBX
    jmp LH
    
LL: cmp EDX, 0
    jE otv
    sub ECX, 1
    mov EAX, N
    add EAX, ECX
    mov EDX, 0
    div EBX
    jmp LL
   
otv: mov EAX, N
    add EAX, ECX
    outword EAX
    
    pause
    exit
end Start