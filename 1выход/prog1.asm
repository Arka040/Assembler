include console.inc


.data
    N dd ?
.code
Start:

    inint N, '¬ведите N '
    mov EAX, N
    cmp EAX, 100
    jB otv
    mov EBX, 100
    mov EDX, 0
    div EBX
    mul EBX
    add EAX, 23


 
otv: outu EAX

    exit                        
end Start
