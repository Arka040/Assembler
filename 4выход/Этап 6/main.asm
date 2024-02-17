include console.inc

In_Rec proto
Out_Rec proto
Less proto
Min_Date proto
Out_Rec proto
Rec_to_Struc proto
Out_Struc proto
Sort proto
Out_Sort proto
Date_pack record D:5, M:4, Y:7

Date_unpack struc                    ; дата в рамках некоторого столети€
D   db ?                            ; день (от 1 до 31)
M   db ?                            ; мес€ц (от 1 до 12)
Y   db ?                            ; год (от 0 до 99)
Date_unpack ends
.data
T   db " ‘јћ»Ћ»я______ »ћя______    Ё“јѕ_1 (выход-4)",0 ; указать номер этапа		
N   equ 6
D1  Date_pack <>                    ; упакованна€ дата_1
D2  Date_pack <>                    ; упакованна€ дата_2
Arr_of_Rec Date_pack N dup (<>)     ; массив «јѕ»—≈… (упакованных дат)
Arr_of_Struc Date_unpack N dup (<>)
.code
Start:
    clrscr
    ConsoleTitle offset T  ; в “ должен быть указан Ќќћ≈– сдаваемого Ё“јѕа(ов)	
; ------------------------------------------------------------------------
; Ё“јѕ 1 (40 очков):
; (10 очков) ввод двух дат D1 и D2 (кажда€ в формате dd.mm.yy)
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

; (10 очков) вывод результата сравнени€ в виде "D1<D2 is true/false",
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
; Ё“јѕ 2 (50 очков):
; (15 очков) цикл дл€ ввода N дат и сохранени€ их в массиве Arr_of_Rec:
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
    
   
; (15 очков) цикл дл€ вывода N дат, хран€щихс€ в массиве Arr_of_Rec
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

; (20 очков) цикл дл€ проверки упор€дочены ли элементы-даты по возрастанию
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
; Ё“јѕ 3 (40 очков):
; применение функции Min_Date дл€ поиска наименьшей даты в массиве Arr_of_Rec
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
; Ё“јѕ 4 (60 очков):
; (30 очков) цикл движени€ по массиву Arr_of_Rec с целью распаковки дат 
; и сохранени€ их в массиве структур  Arr_of_Struc
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
    
; (30 очков) цикл движени€ по массиву Arr_of_Struc с целью вывода дат 
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
; дополнительные Ё“јѕџ 5 и 6 оформл€йте самосто€тельно (дл€ них разметки нет)
; ------------------------------------------------------------------------
; Ё“јѕ 5
    outstrln 'ќтсортированный массив дат:'
    mov EDX, N
    push EDX
    push offset Arr_of_Rec
    call Sort
    
    mov EDX, N
    push EDX
    push offset Arr_of_Rec
    call Out_Sort
    
    newline
    
    outstrln 'я нашел ошибку: в последней функции закинул в регистр тип word...'
    outstrln '≈сли видишь это сообщение, то программа завершила работу корректно'
    
    pause
    exit
end Start