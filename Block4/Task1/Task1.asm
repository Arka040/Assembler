include console.inc
.data

.code
OutD proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push ESI
    push EDI
    
    mov ECX, 0
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
@L: mov EDX, 0
    div EBX
    push EDX
    inc ECX
    cmp EAX, 0
    jNE @L
    
@o: pop EAX
    outi EAX
    dec ECX
    cmp ECX, 0
    jNE @o
    
    
    pop EDI
    pop ESI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2
    
OutD endp
Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 1 (���� 4) "������� ���������"'
    
    inint EAX,"������� �����: "
    inint EBX,'������� ������� ���������: '
    push EBX
    push EAX
    call OutD
    pause
    exit
end Start



