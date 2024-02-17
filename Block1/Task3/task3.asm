
include console.inc


.data
    N db 'НЕТ',0,'ДА',0
  
.code
Start:
    clrscr
    ConsoleTitle 'Путнев Аркадий (гр 110) Задача 3 (Блок 1) "Баланс скобок"'
    mov ESI, offset N
    mov ECX, 0
L:   inchar AH
    
    cmp AH, '('
    jE plus
    cmp AH, ')'
    jE minus
    cmp AH, '.'
    jNE L
    
    cmp ECX, 0
    jG otv
    jmp yes
    
plus: add ECX, 1
    jmp L
    
minus: sub ECX, 1
    cmp ECX, 0
    jL otv
    jmp L
yes: add ESI, 4
otv: outstrln ESI
    pause
    exit
end Start