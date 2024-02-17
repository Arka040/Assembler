include console.inc
.data
MaxSize equ 150
n db ?
m db ?
X dw MaxSize dup (?)

.code
OutMatrix proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    
    outstrln 'Вот наша матрица:'
    
    mov EBX, [EBP+8] ; offsetX
    mov EAX, [EBP+12] ; n
    mov ECX, [EBP+16] ; m
    mul ECX
@L2: mov EDI, 0
@L1:    outi word ptr [EBX][2*EDX],4,
    inc EDI
    inc EDX
    cmp EDI, ECX
    jNE @L1
    newline
    cmp EDX, EAX
    jNE @L2
    
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
OutMatrix endp

StrOrder proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov EDI, [EBP+8] ; offset X
    mov ECX, [EBP+12] ; m
    mov EAX, [EBP+16] ; n
    mul ECX
    dec ECX
    outstr '1) По неубыванию упорядочены строки:'
    
    mov AH, 0
    mov ESI, 0
    mov EDX, 0
@L2:    
    mov AH, 0
    inc ESI
    mov CH, 'Y'
@L1:    mov BX, word ptr [EDI+2*EDX]
    add DL, 1
    add AH, 1
    cmp BX, word ptr [EDI+2*EDX]
    jG @not
    cmp AH, CL
    jNE @L1 
    outu ESI,,' '
@C:    
    inc DL
    cmp DL, AL
    jNE @L2
    jmp @e

@not: cmp AH, CL
    jE @C
    inc AH
    inc DL
    jmp @not

@e:
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
StrOrder endp

StrSimmetric proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov EDI, [EBP+8] ; offset X
    mov EAX, [EBP+12] ; m (stb)
    mov ECX, [EBP+16] ; n (str)
    
    mov EBX, 2
    mov EDX, 0
    div EBX
   
    mov AH, 0
    mov CH, 0
    mov EBX, 0
    mov EDX, 0
    outstr '2) Симметричны строки:'
    
@L2:    mov EDX, [EBP+12]
    inc AH
    mov EBX, 0
@L1:    mov SI, word ptr [EDI+2*EBX]
    inc EBX
    dec EDX
    cmp SI, word ptr [EDI+2*EDX]
    jNE @not
    cmp BL, AL
    jNE @L1
    outu AH,,' '
@C: 
    mov EDX, [EBP+12]
    add EDX, EDX
    add EDI, EDX
    cmp AH, CL
    jNE @L2
    jmp @e
    
@not: cmp BL, AL
    jE @C
    inc EBX
    jmp @not

@e:
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
StrSimmetric endp

StbSame proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    outstr '3) Столбцы с одинаковыми элементами:'
    mov EAX, [EBP+12] ; m (stb)
    mov EBX, [EBP+16] ; n (str)
    
    dec EBX
    
    mov CH, 0
    mov AH, 0
    mov EDX, 0
    mov BH, 1
    
@L2:    mov EDI, [EBP+8] ; offset X
    mov SI, word ptr [EDI+2*EDX]
    mov EAX, [EBP+12]
    add EAX, EDX
    mov CH, 0
@L1:
    cmp SI, word ptr [EDI+2*EAX]
    jNE @not
    add EAX, [EBP+12]
    inc CH
    cmp CH, BL
    jNE @L1
    outu BH,,' '
@C:    inc EDX
    inc BH
    cmp EDX, [EBP+16]
    jNE @L2
    jmp @e
    
@not: cmp CH, BL
    jE @C
    inc CH
    jmp @not
@e:
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
StbSame endp

MainDiag proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    outstr '4) Элементы главной диагонали:'
    
    mov EDI, [EBP+8] ; offset X
    mov EAX, [EBP+12] ; m (stb)
    mov EBX, [EBP+16] ; n (str)
    
    mov ECX, 0
    mov EDX, 0
@L:     
    add ECX, EDX
    outi word ptr [EDI+2*ECX],4,
    sub ECX, EDX
    add ECX, EAX
    inc EDX
    cmp DL, AL
    jE @e
    cmp DL, BL
    jNE @L
@e:
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
MainDiag endp

SideDiag proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    outstr '5) Элементы побочной диагонали:'
    
    mov EDI, [EBP+8] ; offset X
    mov EAX, [EBP+12] ; m (stb)
    mov EBX, [EBP+16] ; n (str)
    
    mov ECX, EAX
    dec ECX
    mov EDX, 0
@L:     
    sub ECX, EDX
    outi word ptr [EDI+2*ECX],4,
    add ECX, EDX
    add ECX, EAX
    inc EDX
    cmp DL, AL
    jE @e
    cmp DL, BL
    jNE @L
@e: 
    
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
SideDiag endp

Simmetric proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov EDI, [EBP+8] ; offset X
    mov EAX, [EBP+12] ; m (stb)
    mov EBX, [EBP+16] ; n (str)
    
    cmp EAX, EBX
    jNE @notv
    
    mov EDX, 0
    mov CH, 0
    mov ECX, 0
    mov EBX, 0
    mov CL, 0
@L1:   mov CL, CH
    inc CL
    cmp CL, AL
    jE @otv
@L:    
    mov BH, CH
    mov BL, CL
    mov DL, AL
@c1:    add CH, BH
    dec DL
    cmp DL, 1
    jNE @c1
    mov EDX, 0
    mov DL, CH
    add DL, CL
    mov SI, word ptr [EDI+2*EDX]
    mov DL, BH
    mov CH, BH
@a1:    inc DL
    cmp DL, CL
    jNE @a1
    mov DH, DL
    mov BH, 0
    mov BH, AL
@c2:    add DL, DH
    dec BH
    cmp BH, 1
    jNE @c2
@a2:    dec CL
    cmp CL, CH
    jNE @a2
    add DL, CL
    movzx EDX, DL
@a3:    inc CL
    cmp CL, BL
    jNE @a3
    cmp SI, word ptr [EDI+2*EDX]
    jNE @notv 
    inc CL
    cmp CL, AL
    jNE @L
    inc CH
    cmp CH, AL
    jNE @L1
    jmp @otv
    
@notv:
    outstrln '6) Матрица не симметричная'
    jmp @e
    
@otv:
    outstrln '6) Матрица симметричная'
@e:
 
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
Simmetric endp

Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 3 (блок 4) "Матрицы прямоугольные и квадратные"'
    
L:    inint n,'Введите количество строк: '
    inint m,'Введите колчиество столбцов: '
    mov AL, n
    mov BH, m
    mul BH
    cmp AX, MaxSize
    jA stop
    cmp n, 1
    jA next
    cmp m, 1
    jA next
stop:    outstrln 'Неправильная матрица. Будете вводить параметры еще раз? (Yes=1/No=0)'
    inint AH
    cmp AH, 1
    jE L
    jmp e
      
next: outstrln 'Вводите матрицу: '
    mov EBX, 0
INP: mov CL, 0
INP1:    inint X[2*EBX]
    inc CL
    inc EBX
    cmp CL, m
    jNE INP1
    flush
    cmp BX, AX
    jNE INP

    
    movzx EAX, n
    movzx EBX, m
    lea ECX, X
    push EBX
    push EAX
    push ECX
    call OutMatrix
    
    push EAX
    push EBX
    push ECX
    call StrOrder
    
    newline
    
    push EAX
    push EBX
    push ECX
    call StrSimmetric
    
    newline
    
    push EAX
    push EBX
    push ECX
    call StbSame
    
    newline
    
    push EAX
    push EBX
    push ECX
    call MainDiag
    
    newline
    
    push EAX
    push EBX
    push ECX
    call SideDiag
    
    newline
    
    push EAX
    push EBX
    push ECX
    call Simmetric
  
    outstrln 'Будете вводить еще матрицу? (Yes=1/No=0)'
    inint AH
    cmp AH, 1
    jE L
e:    
    pause
    exit
end Start