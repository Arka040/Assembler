include console.inc
.data
    ALF db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',0
.code
Start:
    inint EAX
    mov ALF[EAX-1],0
    mov ECX, offset ALF
    lea EDX, ALF[EAX]
    outstr ECX
    newline
    outstr EDX


    exit
end Start

