include console.inc
.data
    
    N equ 5
    X dd N dup(N dup(?))
.code
Start:

    mov EBX, 0
L:
    inint X[4*EBX]
    inc EBX
    cmp EBX, N*N
    jNE L
    
    mov EBX, 0 ; столбцы
    mov ESI, 0 ; строчки
LP: mov EAX, ESI ; дальнейшими действиями записываем в EBX индексы столбцов, которые
    mov EBP, N ; находятся правее диагонального элемента в данной строке
    mov EDX, 0 ; (для того, чтобы лишний раз не проверять элементы, которые ниже главной диагонали)
    div EBP
    add EAX, 4
    mov EBX, EAX 
    cmp EBX, 4*N
    jE otv
LO:
    mov ECX, X[ESI][EBX] ; сохранил в ECX значение просматриваемого элемента выше главной диагонали
    mov EAX, EBX ; дальнейшими действиями преобразовывал значения индексов по правилу: 
    mov EDX, 0 
    mov EBP, N 
    mul EBP ; new EBX = N * EBX
    mov EDI, EAX
    mov EAX, ESI
    mov EDX, 0
    mov EBP, N
    div EBP ; new ESI = ESI div 5
    cmp ECX, X[EAX][EDI] ; сравниваю сохраненный в ECX элемент с симметричным элементом ниже главной диагонали
    jNE notv ; если разные, то заканчиваем проверку. Матрицы не симметричны
    add EBX, 4
    cmp EBX, 4*N ; ну тут всякие сравнения для цикла
    jNE LO
    add ESI, 4*N
    cmp ESI, 4*N*N ; и тута тоже
    jNE LP
    jmp otv ; а это если ты дошел до сюда, то матрица крутая
    
notv:
    outstrln 'Не симметрична'
    jmp e
    
otv:
    outstrln 'Симметрична'
e:
    exit
end Start


