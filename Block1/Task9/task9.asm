include console.inc
.data
    ConsoleTitle '������� ������ (�� 110) ������� 9 (���� 1) "������ � ��������� �����"'

.code
Start:
    clrscr
    mov ECX, 0
L:    inchar BL
    mov AL, BL
L1: mov AH, AL   
    inchar AL
    cmp AL, ','
    jE check
    cmp AL, '.'
    jNE L1
    
check: cmp AH, BL
    jNE next
    inc ECX
    
next: cmp AL, '.'
    jNE L
    outi ECX
    
    pause
    exit
end Start



