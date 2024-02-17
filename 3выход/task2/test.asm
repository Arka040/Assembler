include console.inc
.data
    A db  ' 000   1    222  3333  4   4 55555  666  77777  888   999 ',0
    B db  '0   0 11   2   2     3 4   4 5     6         7 8   8 9   9' 
    C db  '0   0  1      2   333  44444 5555  6666     7   888   9999'
    D db  '0   0  1    22       3     4     5 6   6   7   8   8     9' 
    E db  ' 000  111  22222 3333      4 5555   666   7     888   999 ' 

   
AOUT db 255 dup(?)
BOUT db 50 dup(?)
COUT db 50 dup(?)
DOUT db 50 dup(?)
EOUT db 50 dup(?)

.code
Start:
    mov EAX, offset A
    add EAX, 23
    mov ECX, 5
    mov AOUT[ECX], [EAX]
    
    exit
end Start