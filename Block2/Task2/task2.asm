include console.inc
.data
    z2 db '����',0
    z3 db '�����',0
    z4 db '������',0
    z5 db '�������',0
    adr dd z2,z3,z4,z5;

.code
Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 2 (���� 2) "����� � �������"'
    inint EAX
    sub EAX, 2
    mov EAX, adr[4*EAX]
    outstr EAX
    
    pause
    exit
end Start




