include console.inc
.data

.code
Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 6 (���� 1) "���������� �����"'
    mov EAX, 0
    mov EBX, 5
L:  inchar CL
    cmp CL, ' '
    jE otv
    mov EDX, 0
    mul EBX
    movzx ECX, CL
    sub ECX, '0'
    add EAX, ECX
    jmp L
    
otv: outword EAX    
    
    pause
    exit
end Start 