COMMENT *

 ������_1 (25 �����)
 
 ������ ������������������ ����������� ����� ����� �� ��������� [1 .. 2^32-1], 
 ����� ����� � ���� (� ������������������  �� ����� ���� �����).  
 �������  ��� �� ������������������, �������� � ��� ��� �����, �������� �� 
 ����� ���������� � �������������� ����� (�������, ��� ��� ����� ������������
 � ������ �������� ����� �/��). 
 ��������: �������� ����� � ��� �� �������, � ����� ��� ���� �������. ��� �����!
 ��������: 
 7 4000000000 1 6 0 --> 4000000000 1 6,
 4  23 345678901 23 12 23 198 20 3 0 --> 4 345678901 12 198 20 3, 
 5 9 0 --> 5 9 
 
 ���������� � �������:
 1) ��������� ��������� ��������������� ������� ��� �������� �������� �����;
 ����� ������� ��������� � �����. 2) ��� �������  � ������ �� ����� 
 �� ������������ ������� pop (������������  �������������  ������ � ����������
 ���������� �����). 3) ����� ������ ������ ������� ���� �  �������� ���������
 (� ������� �� ��������� � ������ ����� �����). ����������������� ����������
 ����� ���������� ���: ���������� (�� outword) �������� �������� ESP �� ������ 
 ����� ����� � ����� ������ ������, �������� ������ ��������. 
 
 ��������� ������ ���������: 
 ESP (�� ����� �����) -> ���� ����� -> ����� ������ -> ESP (����� ������ ������)

*
include console.inc
.data
T   db " �������______ ���______   ������_1 (�����-3)",0		

.code
Start:
    ConsoleTitle offset T	
    outwordln ESP,,'ESP (at the beginning) = '
    
    ; ����� ���� �������:
    ; -------------------------------------------------------------------------
    mov ECX, 0
L: inint EAX
    cmp EAX, 0
    jE next
    push EAX
    add ECX, 4
    jmp L
next:
    mov EDX, [ESP]
    add EDX, [ESP+4]
    mov EBX, ECX
L1:
    cmp ECX, 0
    jE otv
    sub ECX, 4
    cmp [ESP+ECX], EDX
    jE L1
    outword [ESP+ECX],0,' '
    jmp L1
otv:
    add ESP, EBX
    
    
    
    ; -------------------------------------------------------------------------
    newline
    outwordln ESP,,'ESP (at the end) = '
    ;pause						; ����� ��� ����� �� e-mail
    exit						
end Start
