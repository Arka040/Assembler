comment *
------------------------------------------------------------------------
ВЫХОД-5 (Задача_2, вспомогательный модуль) 
------------------------------------------------------------------------
*

include console.inc

public In_text, Out_text, Find_min_word 

.code
;-----------------------------------------------------------------------
; procedure In_word(var Elem_of_Arr: array of byte; K: longword)
;-----------------------------------------------------------------------
; ДЕЙСТВИЕ: ввод K-буквенного слова, преобразование его к верхнему регистру
; и сохранение этого слова по адресу, заданному параметром Elem_of_Array.
; Перед окончанием работы процедура In_word  "чистит" буфер ввода 
; (макрокомандой flush) от управляющих символов, попавших в буфер в 
; результате нажатия клавиши ENTER (сделать это надо обязательно, иначе  
; дальнейший ввод будет осуществляться некорректно !!!). 
;-----------------------------------------------------------------------
In_word proc        ; stdcall
; [EBP+8]   ~  offset Elem_of_Arr
; [EBP+12]  ~  K
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    
    
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    xor ECX, ECX
    or CL, 1011111b
@L:    inchar DL
    and DL, CL
    mov byte ptr [EAX], DL
    inc EAX
    dec EBX
    jNZ @L
    flush
    
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2

In_word endp

;-----------------------------------------------------------------------
; procedure Out_word(var Elem_of_Arr: array of byte; K: longword)
;-----------------------------------------------------------------------
; ДЕЙСТВИЕ: вывод слова из К букв, адрес начала этого слова задан 
; параметром Elem_of_Arr. 
;-----------------------------------------------------------------------
Out_word proc        ; stdcall
; [EBP+8]   ~  offset Elem_of_Arr
; [EBP+12]  ~  K
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    
@L:    mov CL, byte ptr [EAX]
    outchar CL
    inc EAX
    dec EBX
    jNZ @L
    
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*2

Out_word endp

;-----------------------------------------------------------------------
; procedure In_text(var Arr_of_words: array of byte; N,K: longword) 
;-----------------------------------------------------------------------
; ДЕЙСТВИЕ: ввод последовательности из N слов (по К букв в каждом слове), 
; преобразование слов к верхн.регистру и сохранение их в массиве Arr_of_words.
; В процессе работы процедура In_text обращается к вспомогательной процедуре
; In_word для ввода очередного слова и сохранения его в очередном элементе 
; массива Arr_of_words
;-----------------------------------------------------------------------
In_text proc         ; stdcall
; [EBP+8]   ~  offset Arr_of_words
; [EBP+12]  ~  N
; [EBP+16]  ~  K
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    mov ECX, [EBP+16]

@L1:    
    push ECX
    push EAX
    call In_word
    add EAX, ECX
    dec EBX
    jNZ @L1
    
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
In_text endp

;-----------------------------------------------------------------------
; procedure Out_text(var Arr_of_words: array of byte; N,K: longword) 
;-----------------------------------------------------------------------
; ДЕЙСТВИЕ: вывод N слов (по К букв в каждом слове), каждое слово – с новой 
; строки экрана. Адрес начала массива из слов задаётся параметром Arr_of_words.
; В процессе работы процедура Out_text обращается к вспомогательной процедуре
; Out_word для вывода очередного слова
;-----------------------------------------------------------------------
Out_text proc       ; stdcall
; [EBP+8]   ~  offset Arr_of_words
; [EBP+12]  ~  N
; [EBP+16]  ~  K
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    
    mov EAX, [EBP+8]
    mov EBX, [EBP+12]
    mov ECX, [EBP+16]
    
@L:    push ECX
    push EAX
    call Out_word
    add EAX, ECX
    newline
    dec EBX
    jNZ @L
    
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3
Out_text endp	

;-----------------------------------------------------------------------		
; procedure Find_min_word(var Arr_of_words: array of byte; N,K: longword) 
;-----------------------------------------------------------------------
; ДЕЙСТВИЕ: поиск слова (в массиве Arr_of_words), которое лексикографически 
; предшествует всем остальным словам и вывод найденного слова на экран.
; Адрес начала массива из N слов (каждое слово длиной К букв) задаётся 
; параметром Arr_of_words.
; В процессе своей работы процедура Find_min_word обращается к вспомогательной
; процедуре Out_word для вывода найденного слова.
;-----------------------------------------------------------------------  
Find_min_word proc  ; stdcall
; [EBP+8]   ~  offset Arr_of_words
; [EBP+12]  ~  N
; [EBP+16]  ~  K
    push EBP
    mov EBP, ESP
    push EAX
    push EBX
    push ECX
    push EDX
    push EDI
    push ESI
    
    mov ESI, [EBP+8]
    mov EBX, [EBP+12]
    mov EAX, 0
    sub EBX, 1
    mov EDI, ESI
@L:     mov ECX, [EBP+16]
    add EDI, ECX
    inc EAX
repE cmpsB
    jNZ @s
    jmp @next
@s: mov EDX, [EBP+16]
    sub EDX, ECX
    sub EDI, EDX
    
    mov ESI, EDI
    
@next: cmp EAX, EBX
    jNE @L
    
    mov ECX, [EBP+16]
    push ECX
    push ESI
    call Out_word
    
    pop ESI
    pop EDI
    pop EDX
    pop ECX
    pop EBX
    pop EAX
    pop EBP
    ret 4*3


Find_min_word endp			
;-----------------------------------------------------------------------
	
end