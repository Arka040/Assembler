include console.inc
.data
    N equ 5
    X db N dup(?)
    Y dw N dup(?)
    Z dd N dup(?)

.code
Start:
    mov ECX, N
    mov EAX, 0
LX: inint X[EAX]
    add EAX, 1
    Loop LX
    mov ECX, N
    mov EAX, 0
LY: inint Y[EAX]
    add EAX, 2
    Loop LY   
    
    mov EAX, 0
    mov ECX, N
    mov EDI, 0
LS: mov EDX, 0
    mov AL, X[EDI]
    movsx EAX, AL
    CDQ
    mov BX, Y[2*EDI]
    movsx EBX, BX
    imul EBX
   
  
    
    mov ESI, EDI
    add ESI, EDI
    add ESI, EDI
    add ESI, N
    mov EBX, ESI
    CDQ
    
    outi EAX
    newline
    
    outi EBX, 5
    newline
    
    idiv EBX
    
    outi EAX
    newline
    
    mov Z[4*EDI], EAX
    add EDI, 1
    sub ECX, 1
    cmp ECX, 0
    jNE LS
    
    newline    
    
    mov ECX, N
    mov EAX, 0
L3: outi Z[EAX],0, ' '
    add EAX, 4
    Loop L3

    newline
    newline
    newline
    
    
    mov EAX, -5
    CDQ
    mov EBX, 5
    idiv EBX
    outi EAX



    exit
end Start


