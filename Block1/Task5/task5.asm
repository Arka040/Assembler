include console.inc
.data
    

.code
Start:  
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 5 (���� 1) "������������ ������� � ������� ���������� ����"'
    inint EAX, '������� ����� '
    mov EBX, 10
    mov ESI, 0 ; first
    mov EDI, 1 ; last
    
    cmp EAX, 0
    jE otv
    mov EDX, 0
    div EBX
    mov ESI, EDX
    mov EDI, EDX
    
L: cmp EAX, 0
    jE otv
    mov EDX, 0
    div EBX
    mov EDI, EDX
    Loop L

otv: mov EAX, ESI
    mul EDI
    outint EAX

    
    pause
    exit
end Start