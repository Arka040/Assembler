COMMENT ~

 ������� _________     ������ _______

 ����� (������_2)
  
 ����� �� Free Pascal ���� ��������� ��������:
 const n = 4; m = 9;   
 type Mas =  array [1..n, 1..m] of longword;

 �������� �� ����� ���������� ������� GetElem �� ������������ ������������ � ������,
 ������� �������� � �������� ���������� ����� (��������) ������������� ������� ���� Mas
 (�������� ������� -����������� ����� � ������� �������� �����), � ����������� 
 n (>1) � m (>1), � �������  i  �  j  ���������� �������� ���� �������  (1<=i<=n, 1<=j<=m). 
 ������� � �������� ���������� ����� ������ ���������� �������� ����� �������� 
 (� ��������� ��������� i � j). 
 ���� ������� ������������ �������� �������� (i �/��� j), �� ������� ���������� �������� 0. 

 ��������: ������, ��� �������� �������� ������� �� ����� Free Pascal - ���������� ����� �
 �������� ���� �� ������� ! �������� ������ ��������� ���� ������� ������������� � ������,
 ��������� ���� � ������ ������ ���� ���������. ��������: n � m �������� � ��������� ���
 �������� ���������, ind_i � ind_j - ��� �������� ����������.     

~

include console.inc
.data
; � ������ ������ ������ �� ������ � ������ �� ���������!
n = 4
m = 6
Arr dd 1000001,1000002,1000003,1000004,1000005,1000006,
       2000001,2000002,2000003,2000004,2000005,2000006,
       3000001,3000002,3000003,3000004,3000005,3000006,
       4000001,4000002,4000003,4000004,4000005,4000006
ind_i db ?
ind_j db ?

.code
; function GetElem(var X: array of longword; n, m: longword; i, j: byte): longword
; ��������: � ������� ������ ��������������� �� ���������� ���� ��������� ������� 
; ��������: if (i in [1..n] and (j in [1..m]) then EAX := X[i,j] else EAX := 0
; [EBP+8]  ~ offset Arr
; [EBP+12] ~ n
; [EBP+16] ~ m
; [EBP+20] ~ i
; [EBP+24] ~ j
GetElem proc
; ������ (����������� ������� ��������):
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov DL, byte ptr [EBP+20]
    mov CL, byte ptr [EBP+24]
; ������� ������ (������ �������������� �������):
    cmp DL, byte ptr [EBP+12]
    jA @err
    cmp CL, byte ptr [EBP+16]
    jA @err
    cmp DL, 0
    jBE @err
    cmp CL, 0
    jBE @err

    mov EBX, 4
    mov EAX, [EBP+16]
    mul EBX ;����� ����� ������
    mov EBX, 0
    movzx EDX, byte ptr [EBP+20]
@L1:    dec EDX
    cmp EDX, 0
    jLE @out
    add EBX, EAX
    jmp @L1
@out:
@L2:    dec CL
    jZ @out2
    add EBX, 4
    jmp @L2
@out2:    mov EAX, [EBP+8]
    add EAX, EBX
    mov EAX, [EAX]
    jmp @e
@err:
    mov EAX, 0
; ������ (����������� �������� ��������):
@e:    
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EBP
    ret 4*5

GetElem endp

Start:
    inint ind_i,'i = '
    inint ind_j,'j = ' 
    
; ���������� ������� GetElem(Arr,n,m,ind_i,ind_j) � ��������� ������:
    movzx EAX, ind_j
    movzx EBX, ind_i
    push EAX
    push EBX
    mov EAX, m
    mov EBX, n
    push EAX
    push EBX
    push offset Arr
    call GetElem
; ����� ������:
    outwordln EAX

    exit						
end Start



