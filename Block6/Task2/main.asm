include console.inc
Mult proto
Public A, B, Z
Extern M: near
.data
A dd ?
B dd ?
Z dq ?
.code
Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 2 (���� 6) "������������ ���������"'
    inint A,'A = '
    inint B,'B = '
    push offset Z
    push B
    push A
    call Mult
    
    outstr '��������� ��������� �� ����        : '
    outword Z
    newline
    
    jmp M
    
    exit
end Start