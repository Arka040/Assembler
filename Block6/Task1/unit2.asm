include console.inc
Public Print
Extern X: dword
.data
.code

Print:
    outword X
    
    pause
    exit
end