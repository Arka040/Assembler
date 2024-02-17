COMMENT ~

 СТУДЕНТ _________     группа _______

 ЗАЧЕТ (ЗАДАЧА_2)
  
 Пусть на Free Pascal даны следующие описания:
 const n = 4; m = 9;   
 type Mas =  array [1..n, 1..m] of longword;

 Написать на языке Ассемблера функцию GetElem со стандартными соглашениями о связях,
 которая получает в качестве параметров адрес (смещение) прямоугольной матрицы типа Mas
 (элементы матрицы -натуральные числа в формате двойного слова), её размерности 
 n (>1) и m (>1), и индексы  i  и  j  некоторого элемента этой матрицы  (1<=i<=n, 1<=j<=m). 
 Функция в качестве результата своей работы возвращает значение этого элемента 
 (с заданными индексами i и j). 
 Если указаны недопустимые значения индексов (i и/или j), то функция возвращает значение 0. 

 Внимание: учесть, что согласно описанию массива на языке Free Pascal - индексация строк и
 столбцов идет ОТ ЕДИНИЦЫ ! Привести пример обращения этой функции применительно к данным,
 описанным ниже в секции данных этой программы. Внимание: n и m задаются в программе как
 числовые константы, ind_i и ind_j - как байтовые переменные.     

~

include console.inc
.data
; В секции данных ничего не менять и ничего не добавлять!
n = 4
m = 6
Arr dd 1000001,1000002,1000003,1000004,1000005,1000006,
       2000001,2000002,2000003,2000004,2000005,2000006,
       3000001,3000002,3000003,3000004,3000005,3000006,
       4000001,4000002,4000003,4000004,4000005,4000006
ind_i db ?
ind_j db ?

.code
; function GetElem(var X: array of longword; n, m: longword; i, j: byte): longword
; ВНИМАНИЕ: в решении строго ориентироваться на приведённый выше заголовок функции 
; ДЕЙСТВИЕ: if (i in [1..n] and (j in [1..m]) then EAX := X[i,j] else EAX := 0
; [EBP+8]  ~ offset Arr
; [EBP+12] ~ n
; [EBP+16] ~ m
; [EBP+20] ~ i
; [EBP+24] ~ j
GetElem proc
; пролог (стандартные входные действия):
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov DL, byte ptr [EBP+20]
    mov CL, byte ptr [EBP+24]
; решение задачи (кратко комментировать решение):
    cmp DL, byte ptr [EBP+12]
    jA @err
    cmp CL, byte ptr [EBP+16]
    jA @err
    cmp DL, 0
    jBE @err
    cmp CL, 0
    jBE @err

    mov EBX, 4
    mov EAX, [EBP+16]
    mul EBX ;длина одной строки
    mov EBX, 0
    movzx EDX, byte ptr [EBP+20]
@L1:    dec EDX
    cmp EDX, 0
    jLE @out
    add EBX, EAX
    jmp @L1
@out:
@L2:    dec CL
    jZ @out2
    add EBX, 4
    jmp @L2
@out2:    mov EAX, [EBP+8]
    add EAX, EBX
    mov EAX, [EAX]
    jmp @e
@err:
    mov EAX, 0
; эпилог (стандартные выходные действия):
@e:    
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EBP
    ret 4*5

GetElem endp

Start:
    inint ind_i,'i = '
    inint ind_j,'j = ' 
    
; применение функции GetElem(Arr,n,m,ind_i,ind_j) к требуемым данным:
    movzx EAX, ind_j
    movzx EBX, ind_i
    push EAX
    push EBX
    mov EAX, m
    mov EBX, n
    push EAX
    push EBX
    push offset Arr
    call GetElem
; вывод ответа:
    outwordln EAX

    exit						
end Start



