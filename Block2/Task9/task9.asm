include console.inc
.data
    N equ 4
    M equ 6
    A dd N dup(M dup(?))
.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 9 (блок 2) "Минимальный элемент матрицы"'
    mov EAX, N
    mov EBX, M
    mov EDX, 0
    mul EBX
    mov ECX, EAX
    mov EAX, 0
    mov EDX, 2147483647
L: inint A[4*EAX]
    cmp A[4*EAX], EDX
    jG next
    jE count
    mov EDX, A[4*EAX]
    mov EDI, 0
count: inc EDI
next:  inc EAX
    cmp EAX, ECX
    jNE L
    outi EDX,,'Минимальный элемент '
    outi EDI,,' входит '
    outstrln ' раз'
    outstr 'Индексы его вхождений: '
    
    mov EBX, 0
    mov ESI, 1
L2:    mov EAX, 0
    mov EDI, 1
L1: 
    cmp A[EAX][EBX], EDX
    jNE step
    outchar '['
    outi ESI
    outchar ','
    outi EDI
    outstr '] '
step:
    inc EDI
    add EAX, 4
    cmp EAX, 4*M
    jNE L1
    inc ESI
    add EBX, EAX
    cmp EBX, 4*N*M
    jNE L2
    
    pause
    exit
end Start