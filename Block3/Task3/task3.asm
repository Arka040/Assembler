include console.inc
.data

.code
Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 3 (���� 3) "����������"'
    outu ESP,, 'ESP = '
    newline
    newline
    
    mov EBP, ESP
    sub EBP, 4
    
    mov EAX, 0
    mov EBX, 0
L:    inchar AL
    cmp AL, ' '
    jE er
    cmp AL, '.'
    jE s
    sub AL, '0'
    inc BL
    push EAX
    jmp L
    
    
s: 
    mov BH, BL
NL:    inchar AL
    cmp AL, ' '
    jE next
    cmp AL, '.'
    jE s
    sub AL, '0'
    inc BL
    push EAX
    jmp NL
    
next: 
    
    mov DH, BL
    sub BL, BH ; � BL ���������� ���� ����� �������. � BH ���������� ���� �� �������
    mov DL, BL
    
    inint AL, 'm = ' ; AL = m       
    cmp BL, AL ; ���� ���������� ���� ����� ������� ������ ���� ����� m, �� ����� �������� ����� 
    jBE ot
    
@@: pop EDI ; ���� ���� ���������� ������ ����� ����� �������
    dec DL
    cmp DL, AL
    jNE @B
    
    mov ESI, ESP
    sub ESI, 4
    mov BL, DL
    mov DH, BH
    add DH, BL ; � DH - ����� ���������� ���� ����� ���� ��� ������ ������ (��� ����� ��� ������ ����� � �����)
    
    movzx ECX, byte ptr [ESI] ; ����� � �������� m+1 ����� ��� ����������
    cmp ECX, 5
    jB no ; �� ���� ��������� ������
    movzx EDI, byte ptr [ESI+4]
    add EDI, 1
    mov [ESI+4], EDI
    mov [ESI], ECX

    add ESI, 4
again:    cmp byte ptr [ESI], 10 ; ���� ���� ��������� ��������� �� 10 ����� ����������
    jNE ot                       ; (������: 0.49999, m=4: � ����� ����� ������ 0 4 9 9 10  ���������� ��� 10 � 0 � ����������� ��������� �����)   
    movzx ECX, byte ptr [ESI]
    sub ECX, 10
    mov [ESI], ECX
    add ESI, 4
    cmp ESI, EBP
    jA DopOne ; ���� ����� ����� �� ������ �����, �� ����� ��� ������� 1
    movzx ECX, byte ptr [ESI]
    inc ECX
    mov [ESI], ECX
    jmp again
    
DopOne: outchar '1'
no: mov [ESI], ECX
ot:    
    movzx ECX, byte ptr [EBP] ; ����� ����� �� �������
    add ECX, '0'
    outchar CL
    sub EBP, 4
    dec BH
    jNZ ot
    
    cmp DL, 0 ; �������� �� �� ���� �� ����� ��������
    jE e
    outchar '.'

ot2: 
    cmp DL, 0 ; ����� ����� ����� �������
    jE zeros
    movzx ECX, byte ptr [EBP]
    add ECX, '0'
    outchar CL
    sub EBP, 4
    dec DL
    jmp ot2
    
zeros: cmp BL, AL ; ����� �����
    jE e
    outu 0
    inc BL
    jmp zeros
    
er: outstr '������ �����'
    mov DH, BL
e:  pop ECX ; ������� �����
    dec DH
    cmp DH, 0
    jNZ e
    
    newline
    newline
    outu ESP,,'ESP = '
    
    pause
    exit
end Start