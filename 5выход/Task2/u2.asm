comment *
------------------------------------------------------------------------
�����-5 (������_2, ��������������� ������) 
------------------------------------------------------------------------
*

include console.inc

public In_text, Out_text, Find_min_word 

.code
;-----------------------------------------------------------------------
; procedure In_word(var Elem_of_Arr: array of byte; K: longword)
;-----------------------------------------------------------------------
; ��������: ���� K-���������� �����, �������������� ��� � �������� ��������
; � ���������� ����� ����� �� ������, ��������� ���������� Elem_of_Array.
; ����� ���������� ������ ��������� In_word  "������" ����� ����� 
; (������������� flush) �� ����������� ��������, �������� � ����� � 
; ���������� ������� ������� ENTER (������� ��� ���� �����������, �����  
; ���������� ���� ����� �������������� ����������� !!!). 
;-----------------------------------------------------------------------
In_word proc        ; stdcall
; [EBP+8]   ~  offset Elem_of_Arr
; [EBP+12]  ~  K
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    xor ECX, ECX
    or CL, 1011111b
@L:    inchar DL
    and DL, CL
    mov byte ptr [EAX], DL
    inc EAX
    dec EBX
    jNZ @L
    flush
    
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2

In_word endp

;-----------------------------------------------------------------------
; procedure Out_word(var Elem_of_Arr: array of byte; K: longword)
;-----------------------------------------------------------------------
; ��������: ����� ����� �� � ����, ����� ������ ����� ����� ����� 
; ���������� Elem_of_Arr. 
;-----------------------------------------------------------------------
Out_word proc        ; stdcall
; [EBP+8]   ~  offset Elem_of_Arr
; [EBP+12]  ~  K
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    
@L:    mov CL, byte ptr [EAX]
    outchar CL
    inc EAX
    dec EBX
    jNZ @L
    
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2

Out_word endp

;-----------------------------------------------------------------------
; procedure In_text(var Arr_of_words: array of byte; N,K: longword) 
;-----------------------------------------------------------------------
; ��������: ���� ������������������ �� N ���� (�� � ���� � ������ �����), 
; �������������� ���� � �����.�������� � ���������� �� � ������� Arr_of_words.
; � �������� ������ ��������� In_text ���������� � ��������������� ���������
; In_word ��� ����� ���������� ����� � ���������� ��� � ��������� �������� 
; ������� Arr_of_words
;-----------------------------------------------------------------------
In_text proc         ; stdcall
; [EBP+8]   ~  offset Arr_of_words
; [EBP+12]  ~  N
; [EBP+16]  ~  K
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    mov ECX, [EBP+16]

@L1:    
    push ECX
    push EAX
    call In_word
    add EAX, ECX
    dec EBX
    jNZ @L1
    
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
In_text endp

;-----------------------------------------------------------------------
; procedure Out_text(var Arr_of_words: array of byte; N,K: longword) 
;-----------------------------------------------------------------------
; ��������: ����� N ���� (�� � ���� � ������ �����), ������ ����� � � ����� 
; ������ ������. ����� ������ ������� �� ���� ������� ���������� Arr_of_words.
; � �������� ������ ��������� Out_text ���������� � ��������������� ���������
; Out_word ��� ������ ���������� �����
;-----------------------------------------------------------------------
Out_text proc       ; stdcall
; [EBP+8]   ~  offset Arr_of_words
; [EBP+12]  ~  N
; [EBP+16]  ~  K
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    mov ECX, [EBP+16]
    
@L:    push ECX
    push EAX
    call Out_word
    add EAX, ECX
    newline
    dec EBX
    jNZ @L
    
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
Out_text endp	

;-----------------------------------------------------------------------		
; procedure Find_min_word(var Arr_of_words: array of byte; N,K: longword) 
;-----------------------------------------------------------------------
; ��������: ����� ����� (� ������� Arr_of_words), ������� ����������������� 
; ������������ ���� ��������� ������ � ����� ���������� ����� �� �����.
; ����� ������ ������� �� N ���� (������ ����� ������ � ����) ������� 
; ���������� Arr_of_words.
; � �������� ����� ������ ��������� Find_min_word ���������� � ���������������
; ��������� Out_word ��� ������ ���������� �����.
;-----------------------------------------------------------------------  
Find_min_word proc  ; stdcall
; [EBP+8]   ~  offset Arr_of_words
; [EBP+12]  ~  N
; [EBP+16]  ~  K
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov ESI, [EBP+8]
    mov EBX, [EBP+12]
    mov EAX, 0
    sub EBX, 1
    mov EDI, ESI
@L:     mov ECX, [EBP+16]
    add EDI, ECX
    inc EAX
repE cmpsB
    jNZ @s
    jmp @next
@s: mov EDX, [EBP+16]
    sub EDX, ECX
    sub EDI, EDX
    
    mov ESI, EDI
    
@next: cmp EAX, EBX
    jNE @L
    
    mov ECX, [EBP+16]
    push ECX
    push ESI
    call Out_word
    
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3


Find_min_word endp			
;-----------------------------------------------------------------------
	
end