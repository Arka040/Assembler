include console.inc
Date_pack record D:5, M:4, Y:7

Date_unpack struc                    ; дата в рамках некоторого столети€
D   db ?                            ; день (от 1 до 31)
M   db ?                            ; мес€ц (от 1 до 12)
Y   db ?                            ; год (от 0 до 99)
Date_unpack ends
.data
T   db " ‘јћ»Ћ»я______ »ћя______    Ё“јѕ_1 (выход-4)",0 ; указать номер этапа		
N   equ 6
D1  Date_pack <>                    ; упакованна€ дата_1
D2  Date_pack <>                    ; упакованна€ дата_2
Arr_of_Rec Date_pack N dup (<>)     ; массив «јѕ»—≈… (упакованных дат)
Arr_of_Struc Date_unpack N dup (<>)
.code

In_Rec proc public
; [EBP+8] ~ offset Date_pack
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    mov EBX, [EBP+8]
    mov EBX, [EBX]
    inint AX
    shl AX, D
    and BX, not mask D
    or BX, AX
    inint AX
    shl AX, M
    and BX, not mask M
    or BX, AX
    inint AX
    and BX, not mask Y
    or BX, AX
    mov EAX, [EBP+8]
    mov [EAX], EBX
    
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4
In_Rec endp

Less proc public
; [EBP+8]  ~ D1 (16 бит)
; [EBP+12] ~ D2 (16 бит)
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    mov EAX, 0
    mov EBX, 0
    mov AX, [EBP+8]
    mov BX, [EBP+12]
    and AX, mask Y
    and BX, mask Y
    cmp AX, BX
    jA @NO
    jB @YES
    mov AX, [EBP+8]
    mov BX, [EBP+12]
    and AX, mask M
    and BX, mask M
    cmp AX, BX
    jA @NO
    jB @YES
    mov AX, [EBP+8]
    mov BX, [EBP+12]
    and AX, mask D
    and BX, mask D
    cmp AX, BX
    jB @YES
@NO:    mov AL, 0
    jmp @o
@YES:   mov AL, 1
@o:    
    pop EDX
    pop ECX
    pop EBX
    pop EBP
    ret 4*2
    
Less endp

Out_Rec proc public
; [EBP+8]  ~ D1/D2 (16 бит)
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    
    mov DX, [EBP+8]
    mov CX, DX
    and CX, mask D
    shr CX, D
    outi CX
    mov CX, DX
    and CX, mask M
    shr CX, M
    outi CX,,'.'
    mov CX, DX
    and CX, mask Y
    outi CX,,'.'
    
    pop EDX
    pop ECX
    pop EBX
    pop EBP
    
    ret 4
    
Out_Rec endp

Min_Date proc public
; [EBP+8]  ~ offset Arr 
; [EBP+12] ~ N
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov ESI, 1
    mov EDI, [EBP+8]
    mov CX, [EDI]
    mov EBX, [EBP+12]
    dec EBX
@L3:    mov EDX, [EDI+2*ESI]
    push EDX
    push ECX
    call Less
    cmp AL, 0
    jNE @next
    mov CX, DX
@next: inc ESI
    dec EBX
    cmp EBX, 0
    jNE @L3
    mov AX, CX

    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EBP
    ret 4*2
Min_Date endp

Rec_to_Struc proc public
; [EBP+8]  ~ Date_pack (16 бит)
; [EBP+12] ~ offset Date_unpack
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    mov AX, [EBP+8]
    mov EBX, [EBP+12]
    mov CX, AX
    and CX, mask D
    shr CX, D
    mov (Date_unpack ptr [EBX]).D, CL
    mov CX, AX
    and CX, mask M
    shr CX, M
    mov (Date_unpack ptr [EBX]).M, CL
    mov CX, AX
    and CX, mask Y
    mov (Date_unpack ptr [EBX]).Y, CL
    
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2
Rec_to_Struc endp

Out_Struc proc public
; [EBP+8]  ~ offset Date_unpack
    
   push EBP
   mov EBP, ESP
   push EAX
   push EBX
   push ECX
   push EDX
   
   mov EAX, [EBP+8]
   outword (Date_unpack ptr [EAX]).D
   mov BH, (Date_unpack ptr [EAX]).M
   mov CL, (Date_unpack ptr [EAX]).Y
   outi BH,,'.'
   outi CL,,'.'

   pop EDX
   pop ECX
   pop EBX
   pop EAX
   pop EBP
   ret 4

Out_Struc endp

Ptr_to_Min_Date proc public
; [EBP+8]  ~ offset Arr 
; [EBP+12] ~ N
    push EBP
    mov EBP, ESP
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov EDI, [EBP+8]
    mov EBX, [EBP+12]
    mov EDX, EDI
    dec EBX
    cmp EBX, 0
    jE @o
@L3: add EDI, 2    
    movzx ECX, word ptr [EDI]
    movzx ESI, word ptr [EDX]
    push ECX
    push ESI
    call Less
    cmp AL, 0
    jNE @next
    mov EDX, EDI
@next: 
    dec EBX
    jNZ @L3
@o:    mov EAX, EDX

    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EBP
    ret 4*2
Ptr_to_Min_Date endp

Sort proc public
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    mov EBX, [EBP+8]
    mov ECX, [EBP+12]
    
@L:    push ECX
    push EBX
    call Ptr_to_Min_Date
    movzx EDX, word ptr [EAX] ; вот тут адрес минимального элемента сейчас
    xchg DX, word ptr [EBX]
    mov [EAX], DX
    add EBX, 2
    dec ECX
    jNZ @L
    
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2
Sort endp

Out_Sort proc public
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    
@L:    push [EAX]
    call Out_Rec
    outchar ' '
    add EAX, 2
    dec EBX
    jNZ @L
    
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2

Out_Sort endp
end