include console.inc

.data
    P dd ?
    Q dd ?


.code
Start:
    clrscr
    ConsoleTitle '������ ������� (�� 110) ������� 4 (���� 1) "����� P/Q"'
    inint P, 'P='
    inint Q, 'Q='
    mov EAX, P
    mov EDX, 0
    mov EBX, Q
    mov ECX, 5
    mov ESI, 10
    div EBX
    outword EAX
    outchar '.'
L:  mov EAX, EDX
    mov EDX, 0
    mul ESI
    div EBX
    outword EAX 
    Loop L
    
    
    
    
    
    
    pause
    exit
end Start