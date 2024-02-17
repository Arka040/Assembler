include console.inc
Mult proto
Public A, B, Z
Extern M: near
.data
A dd ?
B dd ?
Z dq ?
.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 2 (Блок 6) "Сверхдлинное умножение"'
    inint A,'A = '
    inint B,'B = '
    push offset Z
    push B
    push A
    call Mult
    
    outstr 'Результат умножения по идеи        : '
    outword Z
    newline
    
    jmp M
    
    exit
end Start