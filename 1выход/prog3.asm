include console.inc


.data
    N dd ?
    K dd ?
    S db 'NO',0,'YES',0
.code
Start:
    mov ESI, offset S
    
    inint N, '¬ведите N = '
    mov ECX, N
    sub ECX, 2
    inint K
    mov EAX, K
    inint K
    mov EBX, K
    sub EBX, EAX
    mov EDX, EBX
    add EAX, EDX
met:
    inint K
    mov EBX, K
    sub EBX, EAX
    cmp EDX, 0
    jLE otv
    cmp EBX, EDX
    jNE otv
    add EAX, EDX ;EAX = EB
    sub ECX, 1
    cmp ECX, 0
    jNE met
    
    add ESI, 3

 
otv: outstrln ESI
    add EAX, EDX
    outint EAX

    exit                        
end Start
