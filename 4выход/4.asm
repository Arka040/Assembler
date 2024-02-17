include console.inc
; (ТЕСТЫ ДЛЯ ЭТАПОВ 1,2,3 -  в конце этой программы, копируйте и используйте!)
; ОПИСАНИЕ ТИПОВ (ЗАПИСИ) И (СТРУКТУРЫ):
; КАТЕГОРИЧЕСКИ ЗАПРЕЩЕНО вносить изменения в описания типов и переменных,
; кроме строчки номер 19, где указывать номер(а) сдаваемого(ых) этапа(ов)
; ------------------------------------------------------------------------
; описание типа Date_pack    (УПАКОВАННОЙ ДАТЫ-ЗАПИСИ):
Date_pack record D:5, M:4, Y:7
; ------------------------------------------------------------------------
; описание типа Date_unpack  (РАСПАКОВАННОЙ ДАТЫ-СТРУКТУРЫ):
Date_unpack struc                   ; дата в рамках некоторого столетия
D   db ?                            ; день (от 1 до 31)
M   db ?                            ; месяц (от 1 до 12)
Y   db ?                            ; год (от 0 до 99)
Date_unpack ends
; ------------------------------------------------------------------------
; ОПИСАНИЕ ПЕРЕМЕННЫХ:
.data
T   db " ФАМИЛИЯ______ ИМЯ______    ЭТАП_1 (выход-4)",0 ; указать номер этапа		
N   equ 6
D1  Date_pack <>                    ; упакованная дата_1
D2  Date_pack <>                    ; упакованная дата_2
Arr_of_Rec Date_pack N dup (<>)     ; массив ЗАПИСЕЙ (упакованных дат)
Arr_of_Struc Date_unpack N dup (<>) ; массив СТРУКТУР (распакованных дат)
; ------------------------------------------------------------------------
; ОПИСАНИЕ ПРОЦЕДУР: 
.code
; ------------------------------------------------------------------------
; procedure In_Rec(var D: Date_pack)
; ДЕЙСТВИЕ: ввод значений полей D, M, Y записи типа Date_pack
In_Rec proc
; [EBP+8] ~ offset Date_pack
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    mov EBX, [EBP+8]
    mov EBX, [EBX]
    inint AX
    shl AX, D
    and BX, not mask D
    or BX, AX
    inint AX
    shl AX, M
    and BX, not mask M
    or BX, AX
    inint AX
    and BX, not mask Y
    or BX, AX
    mov EAX, [EBP+8]
    mov [EAX], EBX
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    
    ret 4
In_Rec endp
; ------------------------------------------------------------------------
; function Less(D1, D2: Date_pack): byte
; ДЕЙСТВИЕ:
; AL := 1 (если D1<D2, т.е. если дата_1 предшествует дате_2)
; AL := 0 (иначе)
Less proc
; [EBP+8]  ~ D1 (16 бит)
; [EBP+12] ~ D2 (16 бит)
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    mov EAX, 0
    mov EBX, 0
    mov AX, [EBP+8]
    mov BX, [EBP+12]
    and AX, mask Y
    and BX, mask Y
    cmp AX, BX
    jA @NO
    jB @YES
    mov AX, [EBP+8]
    mov BX, [EBP+12]
    and AX, mask M
    and BX, mask M
    cmp AX, BX
    jA @NO
    jB @YES
    mov AX, [EBP+8]
    mov BX, [EBP+12]
    and AX, mask D
    and BX, mask D
    cmp AX, BX
    jB @YES
@NO:    mov AL, 0
    jmp @o
@YES:   mov AL, 1
@o:    
    pop EDX
    pop ECX
    pop EBX
    pop EBP
    ret 4*2
    
Less endp
; ------------------------------------------------------------------------
; procedure Out_Rec(D: Date_pack)
; ДЕЙСТВИЕ: вывод значений полей D, M, Y записи типа Date_pack
Out_Rec proc
; [EBP+8]  ~ D1/D2 (16 бит)
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    
    mov DX, [EBP+8]
    mov CX, DX
    and CX, mask D
    shr CX, D
    outi CX
    mov CX, DX
    and CX, mask M
    shr CX, M
    outi CX,,'.'
    mov CX, DX
    and CX, mask Y
    outi CX,,'.'
    
    pop EDX
    pop ECX
    pop EBX
    pop EBP
    
    ret 4
    
Out_Rec endp
; ------------------------------------------------------------------------
; function Min_Date(var Arr: array of Date_pack; N: longword): word
; ДЕЙСТВИЕ: АХ := минимальная дата среди элементов-дат массива Arr
; (минимальная - предшествующая всем остальным датам)
; Функция Min_Date в процессе своей работы для сравнения текущего минимума 
; с очередной датой обращается к ранее отлаженной функции Less(D1,D2)
Min_Date proc
; [EBP+8]  ~ offset Arr 
; [EBP+12] ~ N
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov ESI, 1
    mov EDI, [EBP+8]
    mov CX, [EDI]
    mov EBX, [EBP+12]
    dec EBX
@L3:    mov EDX, [EDI+2*ESI]
    push EDX
    push ECX
    call Less
    cmp AL, 0
    jNE @next
    mov CX, DX
@next: inc ESI
    dec EBX
    cmp EBX, 0
    jNE @L3
    mov AX, CX

    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EBP
    ret 4*2
Min_Date endp
; ------------------------------------------------------------------------
; procedure Rec_to_Struс(D_pack: Date_pack; var D_unpack: Date_unpack)
; ДЕЙСТВИЕ: распаковка даты 
; (из ЗАПИСИ типа Date_pack в СТРУКТУРУ типа Date_unpack)
Rec_to_Struc proc
; [EBP+8]  ~ Date_pack (16 бит)
; [EBP+12] ~ offset Date_unpack
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    mov AX, [EBP+8]
    mov EBX, [EBP+12]
    mov CX, AX
    and CX, mask D
    shr CX, D
    mov (Date_unpack ptr [EBX]).D, CL
    mov CX, AX
    and CX, mask M
    shr CX, M
    mov (Date_unpack ptr [EBX]).M, CL
    mov CX, AX
    and CX, mask Y
    mov (Date_unpack ptr [EBX]).Y, CL
    
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2
Rec_to_Struc endp
; ------------------------------------------------------------------------
; procedure Out_Struc(var D: Date_unpack)
; ДЕЙСТВИЕ: вывод значений полей D, M, Y структуры типа Date_unpack
Out_Struc proc
; [EBP+8]  ~ offset Date_unpack
    
   push EBP
   mov EBP, ESP
   push EAX
   push EBX
   push ECX
   push EDX
   
   mov EAX, [EBP+8]
   outword (Date_unpack ptr [EAX]).D
   mov BH, (Date_unpack ptr [EAX]).M
   mov CL, (Date_unpack ptr [EAX]).Y
   outi BH,,'.'
   outi CL,,'.'

   pop EDX
   pop ECX
   pop EBX
   pop EAX
   pop EBP
   ret 4

Out_Struc endp

    
Ptr_to_Min_Date proc
; [EBP+8]  ~ offset Arr 
; [EBP+12] ~ N
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov EDI, [EBP+8]
    mov EBX, [EBP+12]
    mov EDX, EDI
    dec EBX
    cmp EBX, 0
    jE @o
@L3: add EDI, 2    
    movzx ECX, word ptr [EDI]
    movzx ESI, word ptr [EDX]
    push ECX
    push ESI
    call Less
    cmp AL, 0
    jNE @next
    mov EDX, EDI
@next: 
    dec EBX
    jNZ @L3
@o:    mov EAX, EDX

    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EBP
    ret 4*2
Ptr_to_Min_Date endp

Sort proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    mov EBX, [EBP+8]
    mov ECX, [EBP+12]
    
@L:    push ECX
    push EBX
    call Ptr_to_Min_Date
    movzx EDX, word ptr [EAX] ; вот тут адрес минимального элемента сейчас
    xchg DX, word ptr [EBX]
    mov [EAX], DX
    add EBX, 2
    dec ECX
    jNZ @L
    
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2
Sort endp

Out_Sort proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    
@L:    push word ptr [EAX]
    call Out_Rec
    outchar ' '
    add EAX, 2
    dec EBX
    jNZ @L
    
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2

Out_Sort endp

; ------------------------------------------------------------------------
; ВЕДУЩАЯ ЧАСТЬ (ОСНОВНАЯ ПРОГРАММА):
start:	
    clrscr
    ConsoleTitle offset T  ; в Т должен быть указан НОМЕР сдаваемого ЭТАПа(ов)	
; ------------------------------------------------------------------------
; ЭТАП 1 (40 очков):
; (10 очков) ввод двух дат D1 и D2 (каждая в формате dd.mm.yy)
; решение:
    COMMENT ~
    push offset D1
    call In_Rec
    push offset D2
    call In_Rec 
    
; (20 очков) сравнение двух дат (D1 < D2 ?)
; решение:
    movzx EDX, D1
    movzx EBX, D2
    push EBX
    push EDX
    call Less

; (10 очков) вывод результата сравнения в виде "D1<D2 is true/false",
; где вместо D1 и D2 должна быть напечатана дата в формате dd.mm.yy
; решение:
    push EDX
    call Out_Rec
    outchar 60
    push EBX
    call Out_Rec
    outstr ' is '
    cmp AL, 0
    jE next
    outstr 'true'
    jmp e
next:
    outstr 'false'
e:
~
; ------------------------------------------------------------------------
; ЭТАП 2 (50 очков):
; (15 очков) цикл для ввода N дат и сохранения их в массиве Arr_of_Rec:
; решение:
    mov EDI, N
    mov ECX, offset Arr_of_Rec
    mov EBX, 0
L: 
    push ECX
    call In_Rec
    dec EDI
    add ECX, 2
    cmp EDI, 0
    jNE L
    
   
; (15 очков) цикл для вывода N дат, хранящихся в массиве Arr_of_Rec
; решение:
    mov ECX, offset Arr_of_Rec
    mov EDI, N
L1: push [ECX]
    call Out_Rec
    add ECX, 2
    dec EDI
    outchar ' '
    cmp EDI, 0
    jNE L1

; (20 очков) цикл для проверки упорядочены ли элементы-даты по возрастанию
; решение:
    mov ECX, offset Arr_of_Rec
    mov EDI, N
    dec EDI
    mov EBX,0
    mov EBP,1
    newline
L2: 
    movzx EDX, word ptr [ECX+2*EBX]
    movzx ESI, word ptr [ECX+2*EBP]
    push ESI
    push EDX
    call Less
    inc EBX
    inc EBP
    cmp AL, 0
    jE NO
    dec EDI
    cmp EDI, 0
    jNE L2
    outstr ' sorted'
    jmp o
NO: outstr ' not sorted'
o:    
    
; ------------------------------------------------------------------------
; ЭТАП 3 (40 очков):
; применение функции Min_Date для поиска наименьшей даты в массиве Arr_of_Rec
; решение:
    newline
    mov ECX, offset Arr_of_Rec
    mov EBX, N
    push EBX
    push ECX
    call Min_Date

; вывод наименьшей даты в виде "dd.mm.yy is minimum"
; решение:
    outstr 'min: '
    push EAX
    call Out_Rec
    
 
; ------------------------------------------------------------------------
; ЭТАП 4 (60 очков):
; (30 очков) цикл движения по массиву Arr_of_Rec с целью распаковки дат 
; и сохранения их в массиве структур  Arr_of_Struc
; решение:
    newline
    mov ECX, offset Arr_of_Rec
    mov EBX, offset Arr_of_Struc
    mov EDX, N
L4:
    movzx EAX, word ptr [ECX]
    push EBX
    push EAX
    call Rec_to_Struc
    add ECX, 2
    add EBX, type Date_unpack
    dec EDX
    cmp EDX, 0
    jNE L4
    
; (30 очков) цикл движения по массиву Arr_of_Struc с целью вывода дат 
; на экран (каждую дату - в формате dd.mm.yy)
; решение
    mov EDX, N
    mov EBX, offset Arr_of_Struc
L5:
    push EBX
    call Out_Struc
    add EBX, type Date_unpack
    newline
    dec EDX
    cmp EDX, 0
    jNE L5
    
; ------------------------------------------------------------------------
; дополнительные ЭТАПЫ 5 и 6 оформляйте самостоятельно (для них разметки нет)
; ------------------------------------------------------------------------
; ЭТАП 5
    outstrln 'Отсортированный массив дат:'
    mov EDX, N
    push EDX
    push offset Arr_of_Rec
    call Sort
    
    push EDX
    push offset Arr_of_Rec
    call Out_Sort

    pause
	exit
end start
	
ТЕСТЫ, на которых надо сдавать программу:
--------------------------------------------------------------------------
ЭТАП 1
--------------------------------------------------------------------------
1)  10.2.20 13.2.20	   ===>   10.2.20<13.2.20 is true
2)  20.2.20 10.3.20	   ===>   20.2.20<10.3.20 is true  
3)  15.2.20 10.2.21	   ===>   15.2.20<10.2.21 is true  
4)  1.2.3 1.2.3	       ===>   1.2.3<1.2.3 is false
5)  10.2.20 15.1.20	   ===>   10.2.20<15.1.20 is false
6)  9.2.20 10.2.19	   ===>   9.2.20<10.2.19 is false
--------------------------------------------------------------------------
ЭТАП 2
--------------------------------------------------------------------------
1)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.20 15.4.20	===> sorted
2)  10.2.19 13.2.19 13.3.19 13.3.19 14.3.20 15.4.2	===> not sorted
3)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.18 15.4.20	===> not sorted
4)  10.2.19 13.2.19 13.3.19 14.3.19 14.3.20 13.3.20	===> not sorted
--------------------------------------------------------------------------
ЭТАП 3
--------------------------------------------------------------------------
1)  15.4.20 14.3.19 10.2.19 13.3.19 14.3.20 13.2.19 ===> 10.2.19 is minimum  
2)  15.4.20 14.3.20 14.3.19 13.3.19 13.2.19 10.2.19 ===> 10.2.19 is minimum
3)  10.2.19 15.4.20 14.3.19 14.3.20 13.2.19 13.3.19 ===> 10.2.19 is minimum
--------------------------------------------------------------------------
