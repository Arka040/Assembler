
include console.inc


.data
    N db '���',0,'��',0
  
.code
Start:
    clrscr
    ConsoleTitle '������ ������� (�� 110) ������ 3 (���� 1) "������ ������"'
    mov ESI, offset N
    mov ECX, 0
L:   inchar AH
    
    cmp AH, '('
    jE plus
    cmp AH, ')'
    jE minus
    cmp AH, '.'
    jNE L
    
    cmp ECX, 0
    jG otv
    jmp yes
    
plus: add ECX, 1
    jmp L
    
minus: sub ECX, 1
    cmp ECX, 0
    jL otv
    jmp L
yes: add ESI, 4
otv: outstrln ESI
    pause
    exit
end Start