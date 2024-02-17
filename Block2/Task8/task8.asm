include console.inc
.data
   N equ 30
   S db N dup(?)
   B db 'Не палиндром',0
.code
Start: 
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 8 (Блок 2) "Палиндром"'
    mov EAX, 0
    lea EDI, B
input: inchar BL
    cmp BL, '.'
    jE next
    cmp BL, ' '
    jE input
    cmp BL, 'a'
    jAE step
    add BL, 'a'
    sub BL, 'A'
step:    mov S[EAX], BL
    inc EAX
    jmp input
next: 
    mov EBX, 0
L:    dec EAX
    mov DL, S[EBX]
    cmp DL, S[EAX]
    jNE otv
    inc EBX
    cmp EAX, 0
    jNE L
    add EDI, 3
otv: outstr EDI
    pause
    exit
end Start