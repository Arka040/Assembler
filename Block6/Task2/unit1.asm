include console.inc
.data

.code
Mult proc public
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    
    mov EDX, 0
    mov ECX, 0
    mov ESI, 33
@L:    dec ESI
    jZ @o
    xor EDI, EDI
    shl ECX, 1
    adc EDI, 0
    shl EDX, 1
    or EDX, EDI
    shl EBX, 1
    jNC @L
    add ECX, EAX
    adc EDX, 0
    jmp @L
@o:   
    mov EAX, [EBP+16]
    mov dword ptr [EAX], ECX
    mov dword ptr [EAX+4], EDX
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
    
Mult endp

end