include console.inc
.data
Slovo db 150 dup(?),0
.code
Start:
    lea EBX, Slovo
L:
    inchar AL
    mov [EBX], AL
    cmp AL, '.'
    jE ot
    inc EBX
    jmp L
ot:    
    outstr offset Slovo
    newline
    outwordln EBX
    exit
end Start
