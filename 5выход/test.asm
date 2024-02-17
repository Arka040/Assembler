include console.inc
.data
RES db 1
.code

Start:
    mov EBX, 6
    xor ECX, ECX
    or CL, 1011111b
@L:    inchar DL
    and DL, CL
    outnumln DL,,B
    outchar DL
    dec EBX
    jnZ @L
    flush
    exit
end Start