include console.inc
.data
    LAT db 'z'-'a'+1 dup(0)


.code
Start:
    mov EAX, 0
L:  inchar AL
    cmp AL, '.'
    jE otv
    add LAT[EAX], 1
    jmp L

    
otv: 
    mov ECX, 'z'-'a'+1
    mov AL, 'a'
    
L1: cmp LAT[EAX], 1
    jNE no
    outchar AL
no: 
    add AL, 1
    Loop L1

    exit
end Start

