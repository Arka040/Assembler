
include console.inc


.data
    N dd ?
    S db '���������',0,'�������',0
.code
Start:
    clrscr
    ConsoleTitle '������ ������� (�� 110) ������ 2 (���� 1) "������� �����"'
 
    mov ESI, offset S
    inint N, '������� �����: '
    mov EAX, N
    mov EBX, 2h
    mov EDX, 0h
    div EBX
    mov ECX, EAX 
    sub ECX, 1 ; ������� ����� ����� � �����
    cmp ECX, 0
    jE simple
met: 
    mov EAX, N
    mov EDX, 0
    div EBX
    cmp EDX, 0 
    jE otv
    add EBX, 1h
    cmp EBX, ECX
    jLE met
simple:    add ESI, 10
otv: outstrln ESI
    pause
    exit
end Start