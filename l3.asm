STK SEGMENT PARA STACK 'STACK'
	DB	100 DUP (?)
STK ENDS

DSEG SEGMENT WORD 'DATA'
	n	db ? ;строки
	m	db ? ;cтолбцы
	array	db 9*9 dup (?)
	enty	db 10, 13, '$'
	msgRows	db 'Input number of rows: $'
	msgCols db 'Input number of columns: $'
	msgAr	db 'Input elements: ', 13, 10, '$'
	DB	100 DUP(0)
DSEG ENDS

CSEG1 SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG1, DS:DSEG, SS:STK

write macro str
    	push    ax
    	push    dx

    	lea     dx, str  ;адрес строки для вывода
    	mov     ah, 09h  ;выдать строку
    	int     21h
 
    	pop     dx
    	pop     ax
endm

;ввод цифры в AX
getdigit:
	mov ah, 1h
	int 21h
	ret

main:
	mov 	ax, DSEG
	mov 	ds, ax

	write	msgRows	;input rows
	write 	enty
	call	getdigit
	mov 	n, al

	write 	msgCols ;input cols
	write 	enty
	call	getdigit
	mov 	m, al

	

	mov 	ax, 4c00h
	int 21h
	
CSEG1 ENDS
END main