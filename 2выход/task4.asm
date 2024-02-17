include console.inc
.data
    N equ 5
    X db N dup(N dup(?))
.code
Start:
    mov EBX, 0
L1: inint X[EBX]
    inc EBX
    cmp EBX, N*N
    jNE L1


    mov EDI, 0
GG: mov ESI, 0
    mov DL, 255
G: cmp X[EDI][ESI], DL
    jB lo
CONTINUE:
    add ESI, 1
    cmp ESI, N
    jNE G
    
    mov BL, X[EDI]
   
    
    mov X[EDI], DL
    MOV X[EAX], BL
    
    add EDI, N
    cmp EDI, N*N
    jNE GG
    
    jmp print
    
lo: mov DL, X[EDI][ESI]    
    mov EAX, ESI
    add EAX, EDI
    jmp CONTINUE

    
print: mov EBX, 0
L2: mov ESI, 0
L3:    outu X[EBX][ESI],0,' ' 
    add ESI, 1
    cmp ESI, N
    jNE L3
    add EBX, N
    newline
    cmp EBX, N*N
    jNE L2



    exit
end Start   
 






