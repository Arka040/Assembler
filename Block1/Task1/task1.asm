
include console.inc


.data
    N dd ?
.code
Start:
    clrscr
    ConsoleTitle '������ ������� (�� 110) ������ 1 (���� 1) "������� ������" '
    inint EAX, '������� �����: '
    mov ECX, 0 ; K=0
    mov EBX, 3h
    mov EDX, 0
met: cmp EAX, 1
    jE ot
    div EBX
    add ECX, 1
    cmp EDX, 0
    jE met
    mov ECX, -1
ot: outint ECX, 0
    pause
    exit
end Start