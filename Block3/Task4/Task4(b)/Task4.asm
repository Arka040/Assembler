include console.inc
.data
.code
Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 4 (�) "�������"'
    outu ESP,,'ESP = '
    newline
    mov EBP, ESP
    sub EBP, 4
    mov ECX, 0
L:    inint EAX ; ���� ��������
    cmp EAX, 0
    jE o
    push EAX
    inc ECX ; ������� �����
    jmp L
o:
    mov ESI, ESP
    sub ESI, 4 ; ESI ���� ����� ������������ ��� ��������� ����� �������� �� �����
    mov EDI, EBP
    mov EDX, 1 ; ������� �� ������ �����
    
LL:    mov EBX, [EDI] ; ����� ���
    mov EBP, EDI ; �������� ��� ��������
L1:    sub EBP, 4 ; ������� �� �������� ���
    cmp EBP, ESI ; �������� � ������ ����� 
    jE yes ; ���� �����, �� �� �������� ��� ���� ��������� ������� � ��� ��������� ��� ����
    cmp EBX, [EBP] ; ���������� ������ ������� ���� � ����� ���������
    jBE no ; ���� ��������� ���� ��� �����-��, �� ����� ��������� ���
    jmp L1
    
yes:  outu EBX ; ����� ���� ������� ����� �������
    outchar ' '
    outu EDX
    newline
    
no: inc EDX ; ����� ����� ���������� ����
    sub EDI, 4 ; ����� ����� ���������� ����
    cmp EDI, ESI ; ���������� �� ����������� �� ����
    jNE LL
    
@@: pop EAX ; ������� �����
    dec ECX
    jNZ @B
    
    outu ESP ,,'ESP = '
    pause
    exit
end Start