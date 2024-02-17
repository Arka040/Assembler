include console.inc
.data
    N equ 3
    X dw N dup(N dup(?))
.code
Start:

    mov EBX, 0
L1: inint X[EBX]
    add EBX, 2
    cmp EBX, 18
    jNE L1
    
    
    mov EBX, 0
L3: mov ESI, 0
L2: outi X[EBX][ESI]
    add ESI, 2
    cmp ESI, 6
    jNE L2
    add EBX, ESI
    newline
    cmp EBX, 18
    jNE L3
    




    exit
end Start




