include console.inc
.data
    
    N equ 5
    X dd N dup(N dup(?))
.code
Start:

    mov EBX, 0
L:
    inint X[4*EBX]
    inc EBX
    cmp EBX, N*N
    jNE L
    
    mov EBX, 0 ; �������
    mov ESI, 0 ; �������
LP: mov EAX, ESI ; ����������� ���������� ���������� � EBX ������� ��������, �������
    mov EBP, N ; ��������� ������ ������������� �������� � ������ ������
    mov EDX, 0 ; (��� ����, ����� ������ ��� �� ��������� ��������, ������� ���� ������� ���������)
    div EBP
    add EAX, 4
    mov EBX, EAX 
    cmp EBX, 4*N
    jE otv
LO:
    mov ECX, X[ESI][EBX] ; �������� � ECX �������� ���������������� �������� ���� ������� ���������
    mov EAX, EBX ; ����������� ���������� �������������� �������� �������� �� �������: 
    mov EDX, 0 
    mov EBP, N 
    mul EBP ; new EBX = N * EBX
    mov EDI, EAX
    mov EAX, ESI
    mov EDX, 0
    mov EBP, N
    div EBP ; new ESI = ESI div 5
    cmp ECX, X[EAX][EDI] ; ��������� ����������� � ECX ������� � ������������ ��������� ���� ������� ���������
    jNE notv ; ���� ������, �� ����������� ��������. ������� �� �����������
    add EBX, 4
    cmp EBX, 4*N ; �� ��� ������ ��������� ��� �����
    jNE LO
    add ESI, 4*N
    cmp ESI, 4*N*N ; � ���� ����
    jNE LP
    jmp otv ; � ��� ���� �� ����� �� ����, �� ������� ������
    
notv:
    outstrln '�� �����������'
    jmp e
    
otv:
    outstrln '�����������'
e:
    exit
end Start


