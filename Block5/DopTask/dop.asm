include console.inc
.data
L equ 5
R equ 155
S db (R-L)/8+1 dup(0)
.code
Start:
    clrscr
    ConsoleTitle 'Путнев Аркадий (гр 110) Доп задание Биты-4 (Блок 5) "МНОЖЕСТВА"'
    mov EBX, offset S
    
again:
    inchar AL
    cmp AL, '+'
    jE plus
    cmp AL, '-'
    jE del
    cmp AL, '?'
    jE check
    cmp AL, '='
    jE count
    cmp AL, ':'
    jE print
    cmp AL, '.'
    jE e
    
plus:
    inint AL
    mov [EBX], AL
    inc EBX
    jmp next
    
del:
    inint AL
    mov ECX, offset S
@@:    cmp AL, byte ptr [ECX]
    jE DelElem
    inc ECX 
    cmp ECX, EBX
    jE next
    jmp @B
DelElem: mov byte ptr [ECX], 0
    dec EBX
L1:    inc ECX
    mov DL, byte ptr [ECX]
    mov byte ptr [ECX], 0
    cmp DL, 0
    jZ next
    xchg DL, byte ptr [ECX-1]
    jmp L1
    
check:
    inint EAX
    mov ECX, offset S
@@:    cmp byte ptr [ECX], 0
    jE no
    cmp AL, byte ptr [ECX]
    jE yes
    inc ECX
    jmp @B
no: outstrln 'Не входит'
    jmp next
yes: outstrln 'Входит'
    jmp next
    
count: mov ECX, offset S
    mov EDX, EBX
    sub EDX, ECX
    outi EDX
    newline
    jmp next
    
print: mov ECX, offset S
    cmp ECX, EBX
    jNE LL
    outchar ' '
    newline
    jmp next
    
LL:    outu byte ptr [ECX]
    outchar ' '
    inc ECX
    cmp ECX, EBX
    jNE LL
    newline
    jmp next
next:
    flush
    jmp again
e:
    pause
    exit
end Start