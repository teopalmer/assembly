PUBLIC insoctal

DSEG SEGMENT PARA PUBLIC 'DATA'
	p	db 1
	sign	db 0
	number	dw 0
	crlf	db 10, 13, '$'
	msgInO	db 'Enter signed octal number. Sign is necessary: $'
	msgOutO	db 'The number has been entered. $'
DSEG ENDS

CSEG1 SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG1, DS:DSEG

entryout:
	lea 	dx, crlf
	call 	outstr
	ret

outstr:
	mov 	ah, 09h
	int 	21h
	ret

getchar:
	mov	ah, 1h
	int	21h
	ret

numout:
	lea	dx, msgOutO
	call 	outstr
	call 	entryout
	mov 	dx, cx
	;call 	outstr
	ret

ShowOct proc
        push    ax
        push    cx
        push    dx
 
        ; Начинаем перевод числа AX в строку
        mov    cl,      ((16-1)/3)*3    ; 16-битный регистр, будем выводить по 3 бита (0..7)
        mov    dx,      ax              ; Сохраняем число в DX
 
@@Repeat:
 
        mov    ax,      dx              ; Восстанавливаем число в AX
        shr    ax,      cl              ; Сдвигаем на CL бит вправо (делим на 8*i)
        and    al,      07h             ; Получаем в AL цифру 0..7 (остаток от деления на 8)
        add    al,      '0'             ; Получаем в AL символ цифры
 
        int    29h                      ; Выводим символ в AL на экран
        sub    cl,      3               ; Уменьшаем CL на 3 для следующей цифры
        jnc    @@Repeat                 ; Если знаковый CL >= 0, то повторяем
 
        pop     dx
        pop     cx
        pop     ax
        ret
ShowOct endp


getsigned:
	call 	getchar
	mov	sign, al
num:
	call	getchar
	cmp     al, '0'  
    	jb      signwork  
    	cmp     al, '7'  
    	ja      signwork  
	sub     al, '0'  
    	mul	p
	add	cx, ax
	mov	al, p
	mov	dx, 10
	mul 	dx
    	jmp     num

signwork:
	call	numout	
	xor 	bx, bx
	mov 	bl, sign
	
exit:
	ret
	

insoctal proc near

	lea	dx, msgInO
	call	outstr
	call 	entryout
	call 	getsigned
	call 	ShowOct
	
	ret
insoctal endp

CSEG1 ENDS
END