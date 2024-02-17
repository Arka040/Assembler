include console.inc
.data
    S db 20 dup('-'),0


.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 3 (блок 2) "Картинка"'
    lea EAX, S
    inint ECX
    mov S[ECX], 0
L:    dec ECX
    mov S[ECX], '*'
    outstrln EAX
    cmp ECX, 0
    jNE L
    
    pause
    exit
end Start