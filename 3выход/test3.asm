include console.inc
.data
B db ?
.code
Start:
    inint B
    mov EAX, offset B
    outi byte ptr [EAX]
    
    exit
end Start