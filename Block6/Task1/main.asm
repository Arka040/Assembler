include console.inc
extern Print: near
Public X
In4 proto
Out4 proto
.data
X dd ? 
.code
Start:
    clrscr
    ConsoleTitle '������� ������ (�� 110) ������� 1 (���� 6) "����-����� ������������ �����"'
    
    push offset X
    call In4
    
    push offset X
    call Out4
    
    newline
    
    jmp Print
    
    outstrln '��������� � ������� ������'
    
    exit    
end Start