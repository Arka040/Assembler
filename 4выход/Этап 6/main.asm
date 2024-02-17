include console.inc

In_Rec proto
Out_Rec proto
Less proto
Min_Date proto
Out_Rec proto
Rec_to_Struc proto
Out_Struc proto
Sort proto
Out_Sort proto
Date_pack record D:5, M:4, Y:7

Date_unpack struc                    ; ���� � ������ ���������� ��������
D   db ?                            ; ���� (�� 1 �� 31)
M   db ?                            ; ����� (�� 1 �� 12)
Y   db ?                            ; ��� (�� 0 �� 99)
Date_unpack ends
.data
T   db " �������______ ���______    ����_1 (�����-4)",0 ; ������� ����� �����		
N   equ 6
D1  Date_pack <>                    ; ����������� ����_1
D2  Date_pack <>                    ; ����������� ����_2
Arr_of_Rec Date_pack N dup (<>)     ; ������ ������� (����������� ���)
Arr_of_Struc Date_unpack N dup (<>)
.code
Start:
    clrscr
    ConsoleTitle offset T  ; � � ������ ���� ������ ����� ���������� �����(��)	
; ------------------------------------------------------------------------
; ���� 1 (40 �����):
; (10 �����) ���� ���� ��� D1 � D2 (������ � ������� dd.mm.yy)
; �������:
    COMMENT ~
    push offset D1
    call In_Rec
    push offset D2
    call In_Rec 
    
; (20 �����) ��������� ���� ��� (D1 < D2 ?)
; �������:
    movzx EDX, D1
    movzx EBX, D2
    push EBX
    push EDX
    call Less

; (10 �����) ����� ���������� ��������� � ���� "D1<D2 is true/false",
; ��� ������ D1 � D2 ������ ���� ���������� ���� � ������� dd.mm.yy
; �������:
    push EDX
    call Out_Rec
    outchar 60
    push EBX
    call Out_Rec
    outstr ' is '
    cmp AL, 0
    jE next
    outstr 'true'
    jmp e
next:
    outstr 'false'
e:
~
; ------------------------------------------------------------------------
; ���� 2 (50 �����):
; (15 �����) ���� ��� ����� N ��� � ���������� �� � ������� Arr_of_Rec:
; �������:
    mov EDI, N
    mov ECX, offset Arr_of_Rec
    mov EBX, 0
L: 
    push ECX
    call In_Rec
    dec EDI
    add ECX, 2
    cmp EDI, 0
    jNE L
    
   
; (15 �����) ���� ��� ������ N ���, ���������� � ������� Arr_of_Rec
; �������:
    mov ECX, offset Arr_of_Rec
    mov EDI, N
L1: push [ECX]
    call Out_Rec
    add ECX, 2
    dec EDI
    outchar ' '
    cmp EDI, 0
    jNE L1

; (20 �����) ���� ��� �������� ����������� �� ��������-���� �� �����������
; �������:
    mov ECX, offset Arr_of_Rec
    mov EDI, N
    dec EDI
    mov EBX,0
    mov EBP,1
    newline
L2: 
    movzx EDX, word ptr [ECX+2*EBX]
    movzx ESI, word ptr [ECX+2*EBP]
    push ESI
    push EDX
    call Less
    inc EBX
    inc EBP
    cmp AL, 0
    jE NO
    dec EDI
    cmp EDI, 0
    jNE L2
    outstr ' sorted'
    jmp o
NO: outstr ' not sorted'
o:    
    
; ------------------------------------------------------------------------
; ���� 3 (40 �����):
; ���������� ������� Min_Date ��� ������ ���������� ���� � ������� Arr_of_Rec
; �������:
    newline
    mov ECX, offset Arr_of_Rec
    mov EBX, N
    push EBX
    push ECX
    call Min_Date

; ����� ���������� ���� � ���� "dd.mm.yy is minimum"
; �������:
    outstr 'min: '
    push EAX
    call Out_Rec
    
 
; ------------------------------------------------------------------------
; ���� 4 (60 �����):
; (30 �����) ���� �������� �� ������� Arr_of_Rec � ����� ���������� ��� 
; � ���������� �� � ������� ��������  Arr_of_Struc
; �������:
    newline
    mov ECX, offset Arr_of_Rec
    mov EBX, offset Arr_of_Struc
    mov EDX, N
L4:
    movzx EAX, word ptr [ECX]
    push EBX
    push EAX
    call Rec_to_Struc
    add ECX, 2
    add EBX, type Date_unpack
    dec EDX
    cmp EDX, 0
    jNE L4
    
; (30 �����) ���� �������� �� ������� Arr_of_Struc � ����� ������ ��� 
; �� ����� (������ ���� - � ������� dd.mm.yy)
; �������
    mov EDX, N
    mov EBX, offset Arr_of_Struc
L5:
    push EBX
    call Out_Struc
    add EBX, type Date_unpack
    newline
    dec EDX
    cmp EDX, 0
    jNE L5
    
; ------------------------------------------------------------------------
; �������������� ����� 5 � 6 ���������� �������������� (��� ��� �������� ���)
; ------------------------------------------------------------------------
; ���� 5
    outstrln '��������������� ������ ���:'
    mov EDX, N
    push EDX
    push offset Arr_of_Rec
    call Sort
    
    mov EDX, N
    push EDX
    push offset Arr_of_Rec
    call Out_Sort
    
    newline
    
    outstrln '� ����� ������: � ��������� ������� ������� � ������� ��� word...'
    outstrln '���� ������ ��� ���������, �� ��������� ��������� ������ ���������'
    
    pause
    exit
end Start