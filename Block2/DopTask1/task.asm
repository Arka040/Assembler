include console.inc
.data
Buf dq ?
D dq 1, 18, 502, 10000, 40034, 1234567, 2345678, 3456789123, 123456789101, 18446744001245
Ans db 16 dup(?),0
.code
Start:
    clrscr
    ConsoleTitle 'Аркадий Путнев (гр 110) Задание 1 "Большие числа-1"'
    mov ESI, 0
    mov EDI, offset D
L1:    mov EBX, [EDI]
    mov ECX, [EDI+4]
    mov EDX, offset Buf
    mov dword ptr [EDX], EBX
    mov dword ptr [EDX+4], ECX
    mov ECX, 10
    outstr 'По outword: ' 
    outword Buf
    newline
    mov EBX, offset Ans
    add EBX, 15
    
L:    mov EDX, 0
    mov EAX, dword ptr [EDI+4]
    div ECX
    mov dword ptr [EDI+4], EAX
    
    mov EAX, dword ptr [EDI]
    div ECX
    mov dword ptr [EDI], EAX
   
    add DL, '0'
    mov byte ptr [EBX], DL
    cmp EAX, 0
    jE e
    dec EBX
    jmp L
e:  outstr 'По заданию: '
    outstr EBX
  
    newline
 
    mov ECX, EBX
    sub ECX, offset Ans
n:    mov byte ptr [EBX], 0
    inc EBX
    Loop n
    add EDI, 8
    inc ESI
    cmp ESI, 10
    jNE L1
    
        
    pause
    exit
end Start

