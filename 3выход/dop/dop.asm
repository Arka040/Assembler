include console.inc
.data
    A db  ' 000   1   222 3333 4   455555 666 77777 888  999 0   0 11  2   2    34   45    6        78   89   90   0  1     2  333 444445555 6666    7  888  99990   0  1   22      3    4    56   6  7  8   8    9 000  111 222223333     45555  666  7    888  999 ',0
     

   
AOUT db 250 dup(?)


.code
Number proc
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    mov EDX, 0
    mov EAX, [EBP+8]
    mov EBX, 5
    mul EBX
    mov EDI, [EBP+12]
    
    mov EBX, 0
    sub EDI, 50
L1:    mov ECX, 0
    add EDI, 50
L:    mov DL, A[EAX+ECX]
    mov AOUT[ECX+EDI], DL
    inc ECX
    cmp ECX, 5
    jNE L
    mov AOUT[ECX+EDI], 10
    inc ECX
    mov AOUT[ECX+EDI], 13
    inc EBX
    add EAX, 50
    CMP EBX, 5
    jNE L1
    
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2
Number endp
Start:
    inint EAX
    mov EBX, 10
    mov ECX, 0
N:    mov EDX, 0
    div EBX
    push ECX
    push EDX
    call Number
    add ECX, 5
    cmp EAX, 0
    jNE N
    mov EBX, offset AOUT
    outstr EBX 
    
    
   

    exit
end Start