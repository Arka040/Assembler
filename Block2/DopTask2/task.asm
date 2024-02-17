include console.inc
.data
D dq 10 dup (?)

.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 2 "Большие числа-2"'
    mov EBP, offset D
LL:    mov EDI, 0
    mov ESI, 0
    mov ECX, 10
    mov EBX, 0
L:    inchar BL
    cmp BL, ','
    jE next
    cmp BL, '.'
    jE e
    cmp BL, '0'
    jB err
    cmp BL, '9'
    jA err
    sub BL, '0'
    mov EAX, EDI
    mov EDX, 0
    mul ECX
    add EAX, EBX
    mov EBX, EDX
    mov EDI, EAX
    mov EAX, ESI
    mov EDX, 0
    mul ECX
    jC err
    add EAX, EBX
    mov ESI, EAX
    jmp L
    
next: 
    mov dword ptr [EBP], EDI
    mov dword ptr [EBP+4], ESI
    add EBP, 8
    jmp LL
e:  mov dword ptr [EBP], EDI
    mov dword ptr [EBP+4], ESI
    
    mov ECX, 10
    mov EBP, offset D
print:
    outword qword ptr [EBP]
    newline
    add EBP, 8
    dec ECX
    jNZ print
    jmp ot
err:    
    outstr 'Ошибка ввода!!!'    
ot:    
    pause
    exit
end Start