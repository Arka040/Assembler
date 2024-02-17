include console.inc
extern Print: near
Public X
In4 proto
Out4 proto
.data
X dd ? 
.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 1 (Блок 6) "Ввод-вывод четверичного числа"'
    
    push offset X
    call In4
    
    push offset X
    call Out4
    
    newline
    
    jmp Print
    
    outstrln 'Закончили в главном модуле'
    
    exit    
end Start