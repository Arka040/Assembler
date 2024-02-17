include console.inc
.data
D dq 3 dup (?)
.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 3 "Большие числа - 3"'
    mov EBP, offset D
LL:    mov EDI, 0
    mov ESI, 0
    mov ECX, 10
    mov EBX, 0
L1:    inchar BL
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
    jmp L1

next: 
    mov dword ptr [EBP], EDI
    mov dword ptr [EBP+4], ESI
    add EBP, 8
    jmp LL
e:  mov dword ptr [EBP], EDI
    mov dword ptr [EBP+4], ESI
    
    mov EBP, offset D
    
    mov EAX, dword ptr [EBP]
    sub EAX, dword ptr [EBP+8]
    mov EAX, dword ptr [EBP+4]
    sbb EAX, dword ptr [EBP+12]
    jC LESS
    mov EAX, dword ptr [EBP]
    xchg dword ptr [EBP+8], EAX
    mov dword ptr [EBP], EAX
    mov EAX, dword ptr [EBP+4]
    xchg dword ptr [EBP+12], EAX
    mov dword ptr [EBP+4], EAX  
LESS:
    mov EAX, dword ptr [EBP]
    sub EAX, dword ptr [EBP+16]
    mov EAX, dword ptr [EBP+4]
    sbb EAX, dword ptr [EBP+20]
    jC LESS1
    mov EAX, dword ptr [EBP]
    newline
    xchg dword ptr [EBP+16], EAX
    mov dword ptr [EBP], EAX
    mov EAX, dword ptr [EBP+4]
    xchg dword ptr [EBP+20], EAX
    mov dword ptr [EBP+4], EAX  
LESS1:
    mov EAX, dword ptr [EBP+8]
    sub EAX, dword ptr [EBP+16]
    mov EAX, dword ptr [EBP+12]
    sbb EAX, dword ptr [EBP+20]
    jC LESS2
    mov EAX, dword ptr [EBP+8]
    xchg dword ptr [EBP+16], EAX
    mov dword ptr [EBP+8], EAX
    mov EAX, dword ptr [EBP+12]
    xchg dword ptr [EBP+20], EAX
    mov dword ptr [EBP+12], EAX  
LESS2:    
    mov ECX, 3
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


