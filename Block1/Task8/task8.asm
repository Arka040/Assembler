include console.inc
.data


.code
Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 8 (���� 1) "�������������� �����"'
    mov EAX, 0
    inchar AL
    sub AL, '0'
    movzx EBX, AL
    
L:  inchar AL
    cmp AL, '.'
    jE otv 
    cmp AL, '-'
    jE minus
    inchar AL
    sub AL, '0'
    add EBX, EAX
    jmp L
    
minus: inchar AL   
    sub AL, '0'
    sub EBX, EAX
    jmp L
    
otv: outint EBX
    
    pause
    exit
end  Start