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
LY: inint Y[2*EAX]
    add EAX, 1
    Loop LY
    
    mov EAX, 0
    mov ECX, N
    mov ESI, 0
LS: 
    movsx EAX, X[ESI]
    movsx EBX, Y[2*ESI]
    
    imul EBX
    
    mov EBX, N
    sub EBX, ESI
    
    idiv EBX

    
    mov Z[4*ESI], EAX
    add ESI, 1
    cmp ECX, 0
    Loop LS
    

    mov ECX, N
    mov EAX, 0
print: outi Z[4*EAX],0,' '
    add EAX, 1
    Loop print
    
    
    
    

    exit
end Start    






