include console.inc
.data
.code
Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 4(a) "�������"'
    outu ESP,, 'ESP = '
    newline
    mov EBX, 0 ; ����� ����� ������� ������ ������������ ������
    mov ECX, 0
L:    inint EAX ; ������ ������ ������
    cmp EAX, 0
    jE o
    inc ECX
    push EAX
    jmp L
o:  
    pop EAX
    cmp EAX, EBX 
    jBE no ; ���� ������ ���� ���� ��� ������������� ������, �� �� ������� ���
    outu EAX
    outchar ' '
    outu ECX
    newline
    mov EBX, EAX ; ��������� ��������
no:    dec ECX
    cmp ECX, 0
    jNE o
    outu ESP,,'ESP = '
    pause
    exit
end Start