comment ~

�����-5 (������_1, ��������������� ������)

�������� ��������� �� ���� �������. 

� �������� ������ ������� ������� �����  X (���������� ��������
���������� ��� ����� ��� �����) � ���� Res (���������� ��������
���������� ��� ����� �� ������).  

�� ���������������  ������ �������  ������������� ��������� 
Power2(X,Res) �� ������������ ������������ � ������  (stdcall).
��������  X ��������� � ��������� �� ��������, Res � �� ������.
��������� Power2 ��������� �������� 32-������ ����������� �������� �:
�������� �� ��� �������� ������, �.�. ���������� �� �����  k: 
�� 0 �� 31, ��� X=2^k. ���� ��, �� ��������� ���������� � ���� Res
���������� k ��������� ������� ������, ����� � ���������� � ���� Res
 -1 (�����!). � �������� ����� ������ ��������� �� ���������� �������
��������� � �������. 

�������� ������ ������ �������� ���������� �,  ����� ���� ����������
� ������� ��������� Power2(X,Res)  ��� �������� ����� X.  ����� 
�������� ������ ������� � ���� ������� ���������� � Res �����. 
�� ���� ������ ������������� ��������� 
�����������.

���������: � �������� ������������� ������� ������ �������� ��� 
000�010�00, ��������� ��� �������� ������������������ ����� �����
�������������.  ��� �������� ����� � ������������� ������������ 
����� ���� 000�010�00 � ��������� �������� (��������������� �� 
������ ���� ����� �� �������), � ����� ������� xor ��� ���������
�������� ������������� ����� �  � ������ ������ (��������� cmp � 
sub ��� ��������� � ������ - �� ������������!).  

�����:   
1  -> 0,       2  -> 1,      5  -> -1,      256  -> 8,     65536  -> 16,      
65535  > -1,    1048576  > 20,   2147483648   > 31,     4000000000  > -1   

~

;---------------------------------------------------------------------
;            ��������������� ������ (����� ���� �������:)
;---------------------------------------------------------------------
.686
.model flat,stdcall

.data

.code
Power2 proc public
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    mov EBX, [EBP+12]
    xor ECX, ECX
    inc ECX
    mov EDX, 0
@L:    mov EAX, [EBP+8]
    xor EAX, ECX
    jZ @yes
    shl ECX, 1
    inc EDX
    cmp EDX, 32
    jNE @L
    mov EDX, -1
    mov [EBX], DL
    jmp @e
@yes: mov [EBX], DL
@e:    
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2
    
    
Power2 endp

;---------------------(����� ������ �������)--------------------------
end

