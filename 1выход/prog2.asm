include console.inc


.data

.code
Start:
    clrscr
    mov EAX, 6
    mov EBX, 6
    mov ECX, 0
met:
    add ECX, 1
    mov ESI, EAX
    mul EBX
    jNC met
    
    outu ECX, 0, 'Степень 6 = '
    newline
    outu ESI, 0, 'Максимальное число = '
    
    
    
    exit                        
end Start
