include console.inc
.data
    NUM db 10 dup(?), 0
.code
Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 4 (���� 2) "�������� 10-� �����"'
    inint EAX
    mov EBX, 10
    jNZ next
    outchar '-'
    mov EDX, 0
    sub EDX, EAX
    mov EAX, EDX
next: mov ECX, 10
    
L:  
    CDQ
    idiv EBX
    add DL, '0'
    mov NUM[ECX-1], DL
    cmp EAX, 0
    loopne L
    lea EDX, NUM[ECX]
    outstr EDX
    pause
    exit
end Start