COMMENT *

 ������_4 (25 �����)
 
 �������  ����������� ������� Replace_4_to_3(X) (����� � � ������� ����� �/��).
 ������� ���������� ����� �����, ���������� �� ��������� ����� � ���� ������ 
 ���� ��������� ����� 4 �� ����� 3 � ���������� ������ ����� X.
 ��������: 12345-->12335, 44444444-->33333333, 4000000004-->3000000003, 4-->3
 ������� ������ ��������� ����������� ���������� � ������ stdcall.
  
 ������� ��������� ����������������� ���������� ������� Replace_4_to_3(X) ��
 ���� ��������� ������� �, ���������� � ������ ������ (���� �������� �� ������)

*
include console.inc
.data
T   db " �������______ ���______   ������_4 (�����-3)",0	
A dd 12345,23,44444444,765432,4000000004,98765444,4,12344567,189087
;    ���������� ������ ������� ��� ���������� ����� ��������:
;    --------------------------------------------------------------
;    12335,23,33333333,765332,3000000003,98765333,3,12333567,189087
;    --------------------------------------------------------------
;    (��� ����� ��������� ������������������ ������ ������������� �����)
Len_A = ($-A)/4 ; ��� �������������� ���������� ���������� ��������� ������� �
 
.code
; function Replace_4_to_3(X: longword): longword
; ��������: �������� ��������� X - �� �������� ! 
; ����������� ���������� � ������
Replace_4_to_3 proc
; ����������� ���������� � ������ stdcall
; [EBP+8] ~ X
; ��������: EAX := ����� ����� (� ������� ���� ���� 4 �� ����� 3 � ����� X)
; ----------------------------------------------------------------------------

; ����� ���� �������� ���� ���� (�����������!) �������
    
    push EBP
    mov EBP, ESP
    
    push ECX    
    push EBX
    push EDX
    
    mov EAX, [EBP+8]
    cmp EAX, 10
    jB four
    
    mov EDX, 0
    mov EBX, 10
    div EBX
    push EAX 
  
    call Replace_4_to_3
    jmp @F
four: cmp EAX, 4
    jNE stop
    dec EAX
    jmp stop
@@: 
    mov ECX, EDX
    mul EBX
    cmp ECX, 4
    jNE @F
    mov ECX, 3
@@: add EAX, ECX
stop:
   
    pop EDX
    pop EBX
    pop ECX
    pop EBP
    ret 4*1
; ----------------------------------------------------------------------------
Replace_4_to_3 endp

Start:  
    ConsoleTitle offset T	
; ----------------------------------------------------------------------------
; ����� ���������������� (� �����) ���������� ����� ��������� � ������ �� ������� A:
    mov ECX, 0
L:
    push A[ECX*4]
    call Replace_4_to_3
    outword EAX,,' '
    inc ECX
    cmp ECX, Len_A
    jNE L
    

; ----------------------------------------------------------------------------
    ;pause     ; ����� ������ ��� ����� �� e-mail
    exit
end Start