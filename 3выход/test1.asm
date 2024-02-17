include console.inc
.data

.code
Start:
    mov EBX, ESP
    outword ESP
    mov ECX, 0
L:    inint EAX
    cmp EAX, 0
    jE next
    push EAX
    add ECX, 4
    jmp L
next:    
    mov EDX, [ESP]
    add EDX, [ESP+4]
L1: 
    cmp ECX, 0
    jE otv
    sub ECX, 4
    cmp [ESP+ECX], EDX
    jE L1
    outword [ESP+ECX],0,' '
    jmp L1
otv:    
    newline
    mov ESP, EBX
    outword ESP


    exit
end Start