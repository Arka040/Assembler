include console.inc
.data
.code
PRINT proc
    push EBP
    mov EBP, ESP
    push EAX
    inint EAX
    cmp EAX, 0
    jE @out
    jG @plus
    outi EAX,,' '
    call PRINT
    jmp @out
@plus:
    call PRINT
    outi EAX,,' '
@out:
    pop EAX
    pop EBP
    ret 0
PRINT endp
Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 7 (���� 4) "������������� � ������������� �����"'
    call PRINT
    pause
    exit
end Start