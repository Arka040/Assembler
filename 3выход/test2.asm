include console.inc
.data
    A dw ?
    B db ?
.code
Start:
    inint A
    inint B
    push offset B
    push A
    call Assign
Assign proc
    push EBP
    mov EBP, ESP
    push EDX
    push EBX
    push EAX
    
    
    mov AX, [EBP+8]
    sub AX, 13
    mov EBX, [EBP+12]
    outi byte ptr [EBX]
    
    idiv BL
    outi AH
    newline
    mov B, AH
    outi B
    pop EAX
    pop EBX
    pop EDX
    pop EBP
    
    ret 4*2
Assign endp
    
    
    
    
    



    exit
end Start