include console.inc
.data
Ans db 32 dup(?),0
D1 dq ?
D2 dq ?
W dq ?,?
.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 4 "Большие числа - 4"'
    mov EBP, offset D1
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
    mov EBP, offset D2
    jmp LL
e:  mov dword ptr [EBP], EDI
    mov dword ptr [EBP+4], ESI
    
    mov EAX, dword ptr D1
    mul dword ptr D2
    
    mov dword ptr W, EAX
    mov dword ptr W+4, EDX
    
    mov EAX, dword ptr D1+4
    mul dword ptr D2+4
    
    mov dword ptr W+8, EAX
    mov dword ptr W+12, EDX
    
    mov EAX, dword ptr D1
    mul dword ptr D2+4
    add dword ptr W+4, EAX
    adc dword ptr W+8, EDX
    adc dword ptr W+12, 0
    
    mov EAX, dword ptr D2
    mul dword ptr D1+4
    add dword ptr W+4, EAX
    adc dword ptr W+8, EDX
    adc dword ptr W+12,0
    
    mov EDI, offset W
    mov ECX, 10
    mov EBX, offset Ans
    add EBX, 31
    
L4:    mov EDX, 0
    mov EAX, dword ptr [EDI+12]
    div ECX
    mov dword ptr [EDI+12], EAX
    
    mov EAX, dword ptr [EDI+8]
    div ECX
    mov dword ptr [EDI+8], EAX
    
    mov EAX, dword ptr [EDI+4]
    div ECX
    mov dword ptr [EDI+4], EAX
    
    mov EAX, dword ptr [EDI]
    div ECX
    mov dword ptr [EDI], EAX
    
    add DL, '0'
    mov byte ptr [EBX], DL
    cmp EAX, 0
    jE en
    dec EBX
    jmp L4
en:
    outstr EBX
    jmp ot
  
err:    
    outstr 'Ошибка ввода!!!'    
ot:  

    pause
    exit
end Start