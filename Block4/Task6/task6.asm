include console.inc
.data

.code
REVERSE proc
    push EBP
    mov EBP, ESP
    push EAX
    inchar AL
    cmp AL, '.'
    jE @out
    call REVERSE
    outchar AL
@out:
    pop EAX
    pop EBP
    ret 0
REVERSE endp
Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 6 (���� 4) "���� �������� (�������� ��� ����������)"'
    call REVERSE
    
    pause
    exit
end Start