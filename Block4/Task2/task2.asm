include console.inc
.data
N equ 100
S db N dup(?)
.code
ReadText proc
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    
    mov EBX, [EBP+8]
    mov EAX, 0
@L:    inchar DL
    cmp DL, '.'
    jE @e
    mov [EBX+EAX], DL
    inc EAX
    jmp @L
@e: 
    pop EDX
    pop ECX
    pop EBX
    pop EBP
    ret 4

ReadText endp

MaxLet proc
    push EBP
    mov EBP, ESP
    sub ESP, 28
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    
    mov EBX, [EBP+8] ; offset S
    mov EAX, [EBP+12] ; len
    
    mov ECX, 26
    mov DL, 0
    sub EBP, 28
@L: mov byte ptr[EBP+ECX], DL ; @L �������� ��������� ������
    dec ECX
    cmp ECX, -1
    jNE @L
    
    mov ECX, 0
    dec EAX
    mov ECX, 0
@NL:                      ; @NL ���������� � ��������� ������ ����� �����
    mov CL, [EAX+EBX]
    cmp CL, 'a'
    jAE @next1
    dec EAX
    cmp EAX, -1
    jNE @NL
    jmp @otv
@next1:
    cmp CL, 'z'
    jBE @next2
    dec EAX
    cmp EAX, -1
    jNE @NL
    jmp @otv
@next2: sub ECX, 'a'              ; ���������� ��� ��� ���� ������
    mov DL, byte ptr [EBP+ECX]
    inc DL
    mov byte ptr [EBP+ECX], DL
    dec EAX
    cmp EAX, -1
    jNE @NL
@otv:
    
    mov ECX, 0
    mov DL, 0
@L3:    cmp byte ptr [EBP+ECX], DL      ; @L3 ������� ����� ������������� �����
    jBE @n
    mov DL, byte ptr [EBP+ECX]
    mov EAX, ECX
@n:
    inc ECX
    cmp ECX, 26
    jNE @L3
    cmp EAX, -1
    jE @NO
    add EAX, 'a'
    outchar AL,'����� '
    outstr ' ����������� ���� ����� '
    outu DL,,'('
    outstr ') ���.'
    jmp @e
@NO: outstrln '����� ��������� ���� � ������ ���.'
@e:
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    
    add ESP, 28 ; ��������
    
    pop EBP
    ret 4*2
MaxLet endp

Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 2 (���� 4) "������� ��������� ����"'
    mov EBX, offset S
    push EBX
    call ReadText
    
    mov EBX, offset S
    push EAX
    push EBX
    call MaxLet
    pause
    exit
end Start
