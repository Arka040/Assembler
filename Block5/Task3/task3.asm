include console.inc
.data

.code
Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 3 (���� 5) "������ � �������������� ��������� �����"'
    XOR EAX, EAX
    mov ECX, 8
L:    
    mov EBX, 4
L1: SHL EAX, 1   
    inchar DL
    sub DL, '0'
    OR AL, DL
    
    dec EBX
    cmp EBX, 0
    jNE L1
    inchar DL
    dec ECX
    cmp ECX, 0
    jNE L
    
    mov EBX, EAX
    mov ECX, 32
@@: rol EAX, 1
    rcr EBX, 1
    LOOP @B
    
    xor EBX, EAX
    jZ yes
    outstrln '�������������'
    xor DL, DL ; ���� � ���, ����� ������� �������� � DL ������ ��� EAX (���������
    ror EAX, 1 ; ������������ ������ ������). ����� ������� EAX � �������� ��������� 
    adc DL, 0 ; � ��� ��� �������� ����� (2 ����������� ������ �����).  
    rol EAX, 2 ; ����� ����� DL ������, ����� � CF �������� ������ ��� EAX (������� ����� � DL).  
    ror DL, 1 ; 
    rcr EAX, 1 ; ����� ����� EAX ������ � ������ ����������� CF (rcr) � ������� � ��� ������ ��� EAX.
    adc DL, 0 ; ���������� �������� � ����� ��� EAX ������ ���. � CF � ��� ����� ��� EAX.
    ror EAX, 1 ; ���������� ���� ��� � DL � ������ �� �� ����� ������ ������ EAX.
    ror DL, 1 ;
    rcl EAX, 1 ;
    jmp otv
yes:
    outstrln '�����������'
    mov ECX, 16
    ror EAX, CL ; �������� ����� ���, ����� ������ ������ �� ������ ��� ������ �� ������ ����� 
@@: XOR DL, DL ; (������� ������ ���� ��� �� ������ �����)
    rol EAX, 1  ; ���������� ��������� ��� � ������ ������. ������� ��� � CF � ���������� ��� � 1
    adc DL, 0 ; ���� 1, �� �������� ����� ������ ( ��� ������� � ����� �����) � ����� rcl 
    loopz @B ; �������� �����. ����� ��� ��������� ��� ������ ������� � ��������� � ������ ������.
    ror EAX, 1 ;
    xor DL, DL ;
    ror DL, 1 ;
    rcl EAX, 1  ; 
    rol EAX, CL ;���������� ����� � �������� ��������� � ������ �� �� ����� �����
  
    mov ECX, 16
    rol EAX, CL
@@: XOR DL, DL
    ror EAX, 1   
    adc DL, 0
    loopz @B
    rol EAX, 1
    xor DL, DL
    rol DL, 1
    rcr EAX, 1
    
    ror EAX, CL
    
otv:    
    mov ECX, 8
LOT:   mov EBX, 4
LO: XOR DL, DL   
    shl EAX, 1
    adc DL, 0
    outword DL
    dec EBX
    cmp EBX, 0
    jNE LO
    outchar ' '
    dec ECX
    cmp ECX, 0
    jNE LOT
    pause
    exit
end Start