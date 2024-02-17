include console.inc
.data
Alp db "gorjgiprwejpgiwe",0
.code
Start:
    inint EBX,'K = '
    mov EBX, offset Alp
    outwordln EBX
    outintln EBX
    lea EAX, [Alp]
    outwordln EAX
    mov ECX, -1
    outwordln ECX
    outintln ECX
    exit
end Start