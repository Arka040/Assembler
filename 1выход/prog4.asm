include console.inc


.data
    S db ?
.code
Start:

m:    inchar S
    cmp S, '.'
    jE e
    cmp S, 'N'
    jE m1
    outchar S
    jmp m
    
    
    
m1: inchar S
    cmp S, '.'
    jE v
    cmp S, 'O'
    jE y
    outchar 'N'
    cmp S, 'N'
    jE m1
    
    jmp m

    
 
y:  outchar 'Y'
    outchar 'E'
    outchar 'S'
    jmp m
 
v: outchar 'N'

e:
    exit                        
end Start
