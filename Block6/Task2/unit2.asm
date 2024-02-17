include console.inc
Extern A: dword, B: dword, Z: qword
Public M
.data
.code
M:
    mov ECX, offset Z
    mov EAX, A
    mov EBX, B
    mov EDX, 0
    mul EBX
    
    mov dword ptr [ECX], EAX
    mov dword ptr [ECX+4], EDX
    
    outstr 'Результат умножения через умножение: '
    outword Z
    
    pause
    exit
end