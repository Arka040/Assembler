include console.inc
.data

.code
MaxDig proc
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    
    mov EAX, [EBP+8]
    
    cmp EAX, 10
    jB @e
    
    mov EBX, 10
    mov EDX, 0
    div EBX
    
    push EAX
    call MaxDig
    
    cmp EDX, EAX
    jBE @e
    mov EAX, EDX
   
@e: pop EDX
    pop ECX
    pop EBX
    pop EBP
    ret 4
MaxDig endp

Start:
    clrscr
L:    inint EBX,'������� �����: '
    push EBX
    call MaxDig
    outi EAX,,'������������ �����: '
    newline
    outstrln '��� �����? (��=1/���=0)' 
    inint EBX
    cmp EBX, 1
    jE L
    pause
    exit
end Start

