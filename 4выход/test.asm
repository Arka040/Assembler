include console.inc
Date record D:5, M:4, Y: 7
.data
D1 Date <>
D2 Date <>
.code
In_Rec proc
; [EBP+8] ~ offset Date_pack
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    mov EBX, [EBP+8]
    mov EBX, [EBX]
    inint AX
    shl AX, width Y + width M
    and BX, not mask D
    or BX, AX
    inint AX
    shl AX, width Y
    and BX, not mask M
    or BX, AX
    inint AX
    and BX, not mask Y
    or BX, AX
    mov EAX, [EBP+8]
    mov [EAX], EBX
    pop EBX
    pop EAX
    pop EBP
    ret 4
In_Rec endp

Less proc
    push EBP
    mov EBP, ESP
    push EBX
    mov EAX, 0
    mov EBX, 0
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    and AX, mask Y
    and BX, mask Y
    cmp AX, BX
    jA NO
    jB YES
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    and AX, mask M
    and BX, mask M
    cmp AX, BX
    jA NO
    jB YES
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    and AX, mask D
    and BX, mask D
    cmp AX, BX
    jB YES
NO:    mov AL, 0
    jmp o
YES:   mov AL, 1
o:    
    pop EBX
    pop EBP
    ret 4*2
    
    
Less endp

Out_Rec proc
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    
    mov EDX, [EBP+8]
    mov EBX, [EBP+12]
    mov CX, DX
    and CX, mask D
    shr CX, width Y + width M
    outi CX
    mov CX, DX
    and CX, mask M
    shr CX, width Y
    outi CX,,'.'
    mov CX, DX
    and CX, mask Y
    outi CX,,'.'
    cmp AL, 0
    outchar ' '
    outchar 60
    mov CX, BX
    and CX, mask D
    shr CX, width Y + width M
    outi CX,,' '
    mov CX, BX
    and CX, mask M
    shr CX, width Y
    outi CX,,'.'
    mov CX, BX
    and CX, mask Y
    outi CX,,'.'
    outstr ' is '
    cmp AL, 0
    jE next
    outstr 'true'
    jmp e
next:
    outstr 'false'
e:
    
    pop ECX
    pop EBX
    pop EBP
    
    ret 4*2
    
Out_Rec endp

Start:
    outchar 'Â'
    push offset D1
    call In_Rec
    outchar 'Â'
    push offset D2
    call In_Rec
    
    movzx EAX, D1
    movzx EBX, D2
    push EBX
    push EAX
    call Less
    
    movzx EBX, D1
    movzx ECX, D2
    push ECX
    push EBX
    call Out_Rec
    
    exit
end Start

