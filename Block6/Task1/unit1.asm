include console.inc
.data
.code
In4 proc public
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX

    mov EBX, [EBP+8]
    xor EAX, EAX
    
@L:    inchar CL
    cmp CL, ' '
    jE @o
    sub CL, '0'
    or AL, CL
    rol EAX, 2
    jmp @L
@o: ror EAX, 2
    mov [EBX], EAX
    
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4
In4 endp

Out4 proc public
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    mov EAX, [EBP+8]
    
    mov ECX, 16
    mov EAX, [EAX]
@L: rol EAX, 2
    xor DL, DL   
    mov DL, 11b
    and DL, AL
    outu DL
    loop @L
    
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4
    
Out4 endp
end