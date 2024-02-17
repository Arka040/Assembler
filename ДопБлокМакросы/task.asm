include console.inc


Sum macro RES:=<EAX>, TERMS:vararg
    Local num, Space, Same
    num = 0
    Space = 0
    Same = 0
    check = 0
    if type RES NE 4
        echo Incorrect "RES" type
        .err <Incorrect "RES" type>
        exitm
    endif
    ifidn <RES>,<ESP>
        echo Incorrect 'RES' type
        .err <Incorrect 'RES' type>
        exitm
    endif
    ifnb <TERMS>      
        ifidni <RES>,<EAX>
            Same = 1
        elseifidni <RES>,<EBX>
            Same = 2
        elseifidni <RES>,<ECX>
            Same = 3
        elseifidni <RES>,<EDX>
            Same = 4
        elseifidni <RES>,<ESI>
            Same = 5
        elseifidni <RES>,<EDI>
            Same = 6
        endif
        for p,<TERMS>
            ifnb <p>
                if type p EQ 0
                    num = num + p
                elseif type p NE 4
                    Space = 1
                    if Same EQ 1
                        ifidni <p>,<AX>
                            check = 1
                        elseifidni <p>,<AL>
                            check = 1
                        elseifidni <p>,<AH>
                            check = 1
                        endif
                    elseif Same EQ 2
                        ifidni <p>,<BX>
                            check = 1
                        elseifidni <p>,<BL>
                            check = 1
                        elseifidni <p>,<BH>
                            check = 1
                        endif
                    elseif Same EQ 3
                        ifidni <p>,<CX>
                            check = 1
                        elseifidni <p>,<CL>
                            check = 1
                        elseifidni <p>,<CH>
                            check = 1
                        endif
                    elseif Same EQ 4
                        ifidni <p>,<DX>
                            check = 1
                        elseifidni <p>,<DL>
                            check = 1
                        elseifidni <p>,<DH>
                            check = 1
                        endif
                    elseif Same EQ 5
                        ifidni <p>,<SI>
                            check = 1
                        endif
                    else
                        ifidni <p>,<DI>
                            check = 1
                        endif
                    endif
                elseifidni <p>,<RES>
                    check = 1
                endif
            endif
        endm
        if Space EQ 1
            push EBX
        endif
        if check EQ 1
            push RES
        else
            Same = 0
        endif
        mov RES, num
        for p,<TERMS>
            ifnb <p>
                if type p EQ 4
                    ifidni <p>,<RES>
                        add RES, [ESP]
                    elseif Space EQ 1
                        ifidni <p>,<EBX>
                            if check EQ 1
                                add RES, [EBP+4]
                            else
                                add RES, [EBP]
                            endif
                        else
                            add RES, p
                        endif
                    else
                        add RES, p
                    endif
                elseif type p EQ 2
                    if Same EQ 1
                        ifidni <p>, <AX>
                            movzx EBX, word ptr [ESP]
                        elseifidni <p>,<BX>
                            movzx EBX, word ptr [ESP+4]
                        else
                            movzx EBX, p
                        endif                   
                    elseif Same EQ 2
                        ifidni <p>,<BX>
                            movzx EBX, word ptr [ESP+4]
                        else
                            movzx EBX, p
                        endif
                    elseif Same EQ 3
                        ifidni <p>,<CX>
                            movzx EBX, word ptr [ESP]
                        elseifidni <p>,<BX>
                            movzx EBX, word ptr [ESP+4]
                        else
                            movzx EBX, p
                        endif
                    elseif Same EQ 4
                        ifidni <p>,<DX>
                            movzx EBX, word ptr [ESP]
                        elseifidni <p>,<BX>
                            movzx EBX, word ptr [ESP+4]
                        else
                            movzx EBX, p
                        endif
                    elseif Same EQ 5
                        ifidni <p>,<SI>
                            movzx EBX, word ptr [ESP]
                        elseifidni <p>,<BX>
                            movzx EBX, word ptr [ESP+4]
                        else
                            movzx EBX, p
                        endif
                    elseif Same EQ 6
                        ifidni <p>,<DI>
                            movzx EBX, word ptr [ESP]
                        elseifidni <p>,<BX>
                            movzx EBX, word ptr [ESP+4]
                        else
                            movzx EBX, p
                        endif
                    else
                        ifidni <p>,<BX>
                            movzx EBX, word ptr [ESP]
                        else
                            movzx EBX, p
                        endif       
                    endif
                    add RES, EBX          
                elseif type p EQ 1
                    if Same EQ 1
                        ifidni <p>,<AL>
                            movzx EBX, byte ptr [ESP]
                        elseifidni <p>,<AH>
                            movzx EBX, byte ptr [ESP+1]
                        elseifidni <p>,<BL>
                            movzx EBX, byte ptr [ESP]
                        elseifidni <p>,<BH>
                            movzx EBX, byte ptr [ESP+1]
                        else
                            movzx EBX, p
                        endif
                    elseif Same EQ 2
                        ifidni <p>,<BL>
                            movzx EBX, byte ptr [ESP+4]
                        elseifidni <p>,<BH>
                            movzx EBX, p byte ptr [ESP+5]
                        else
                            movzx EBX, p
                        endif
                    elseif Same EQ 3
                        ifidni <p>,<CL>
                            movzx EBX, byte ptr [ESP]
                        elseifidni <p>,<CH>
                            movzx EBX, byte ptr [ESP+1]
                        elseifidni <p>,<BL>
                            movzx EBX, byte ptr [ESP+4]
                        elseifidni <p>,<BH>
                            movzx EBX, byte ptr [ESP+5]
                        else
                            movzx EBX, p
                        endif
                    elseif Same EQ 4
                        ifidni <p>,<DL>
                            movzx EBX, byte ptr [ESP]
                        elseifidni <p>,<DH>
                            movzx EBX, byte ptr [ESP+1]
                        elseifidni <p>,<BL>
                            movzx EBX, byte ptr [ESP+4]
                        elseifidni <p>,<BH>
                            movzx EBX, byte ptr [ESP+5]
                        else
                            movzx EBX, p
                        endif
                    else
                        ifidni <p>,<BL>
                            movzx EBX, byte ptr [ESP]
                        elseifidni <p>,<BH>
                            movzx EBX, byte ptr [ESP+1]
                        else
                            movzx EBX, p
                        endif
                    endif
                    add RES, EBX
                endif     
            endif
        endm 
    endif
    if check EQ 1
        if Space EQ 1
            pop EBX
        endif
        pop EBX
    elseif Space EQ 1
        pop EBX
    endif
endm
    
.data
K1 equ 1
K2 equ 2
K3 equ 3
B1 db 10
B2 db 20
B3 db 30
W1 dw 4000
W2 dw 5000
W3 dw 6000
D1 dd 700000
D2 dd 800000
D3 dd 900000
.code
Start:
.LISTMACRO
    
    ;вепмше реярш

    Sum EAX,<123456,K1,EBX,D1>
    Sum EAX,123456,K1,EBX,ebx,D1
    Sum ,123456,K1,EBX,D1
    Sum eax,123456, ,K1,EBX,D1
    Sum EAX
    Sum
    Sum EAX,2,K2,B2,W2,D2
    Sum AL,1,2,3
    Sum CX,1,K2
    Sum K3,1,2,3
    Sum AL,1,2,3
    Sum B3,1,2,3
    Sum W3,1,2,3
    Sum ESP,1,2,3
    Sum EDX,1,B2,W2, ,K2,D3,123
    Sum ESI,AL,2,3,AH,K1,K2,BL,BH,DL,DH
    Sum EDI,AX,BX,CX,DX,W1,W2,123
    Sum 0,1,2,3
    
    ;яхмхе реярш
    
    Sum EDX,EDX ,B2,edx, ,K2,D3,eDX
    Sum ,1,EAX,eax, ,K2,EAX,123
    Sum edx,EAX,BL,EDX,ECX,AX,EDX
    
    ;гекемше реярш
    
    Sum ECX,CL,CH, ,CX,cl,ch,cx
    Sum ,AL,al,AH, ,ah,AX,ax,EAX,eax
    Sum edx,BL,EAX,DL,DH,ECX,CX,EDX

    exit
end Start