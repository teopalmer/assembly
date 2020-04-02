STK SEGMENT PARA STACK 'STACK'
	DB	100 DUP (0)
STK ENDS

DSEG SEGMENT WORD 'DATA'
	n	db ? ;rows
	m	db ? ;columns
	nmax	db 0; maximum
	nmin	db 0; minimum
	array	db 9*9 dup ('-')
	crlf	db 10, 13, '$'
	msgRows	db 'Input number of rows: $'
	msgCols db 'Input number of columns: $'
	msgAr	db 'Input elements: ', 13, 10, '$'
	msgEnd 	db 'Result:', '$'
	msgOut	db 'Array:', '$'
	DB	100 DUP(0)
DSEG ENDS

CSEG1 SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG1, DS:DSEG, SS:STK

outstr:
	mov ah, 09h
	int 21h
	ret

spaceout:
	mov dl, ' '
	mov ah, 2h
	int 21h
	ret

entryout:
	lea dx, crlf
	call outstr
	ret

getdigit: 		;one digit input
	mov ah, 1h
	int 21h
	ret

entry:
	mov dl, 10
	mov ah, 2h
	int 21h
	mov dl, 13
	mov ah, 2h
	int 21h
	ret

matrixinput:
	mov bx, 0
	mov si, 0
	rowcycle:
		mov cl, m;	counter to columns
		colcycle:
			call getdigit
			mov array[bx], al
			sub array[bx], '0'
			inc bx
			call spaceout
			loop colcycle
		call entry
		mov cl, n
		sub cx, si
		inc si
		loop rowcycle
	ret 

matrixoutput: 	;matrix output
	mov ah, 2h
	mov bx, 0
	mov si, 0
	rowc:
		mov cl, m;	counter to columns
		colc:
			mov dl, array[bx]
			add dl, '0'
			inc bx
			int 21h
			call spaceout
			loop colc
		call entry
		mov cl, n
		sub cx, si
		inc si
		loop rowc
	ret

multi:
	mov al, n
	mul m
	ret

setmax:
	mov al, bl
	div m
	mov dl, al
	mov nmax, dl
	mov al, array[bx]
	ret

setmin:
	mov al, bl;
	div m
	mov dl, al
	mov nmin, dl
	mov al, array[bx]
	ret

findmax:
	call multi
	mov cx, ax
	dec cx
	mov bx, cx
	mov al, array[bx]
	matrix:
		cmp al, array[bx]
		mov bx, cx
		jl setmax
		loop matrix
	ret


findmin:
	call multi
	mov cx, ax
	dec cx
	mov bx, cx
	mov al, array[bx]
	matr:
		mov bx, cx
		cmp al, array[bx]
		jg setmin
		loop matr
	ret

swaprows:
	mov cl, m
	mov al, nmin
	mul m
	mov nmin, al
	mov al, nmax
	mul m
	mov nmax, al

	swap:
		lea dx, nmin

		mov bl, nmin
		mov al, array[bx]	;save min

		mov bl, nmax
		mov dl, array[bx]	;save max

		mov array[bx], al
		mov bl, nmin
		mov array[bx], dl

		inc nmin
		inc nmax

		loop swap
	getout:
	ret

main:
	mov 	ax, DSEG
	mov 	ds, ax

	lea		dx, msgRows	;input rows
	call 	outstr
	call	getdigit
	mov 	n, al
	sub		n, '0'
	call 	entryout

	lea		dx, msgCols ;input cols
	call 	outstr
	call	getdigit
	call	entryout
	mov 	m, al
	sub		m, '0'

	lea 	dx, msgAr 	
	call	outstr

	call 	matrixinput	;input elements

	lea 	dx, msgEnd 	;input over
	call	outstr
	call 	entryout

	mov al, m
	mul n
	cmp al, 1
	je exitprog

	call 	findmax

	call 	findmin

	call 	swaprows

exitprog:
	call 	matrixoutput
	mov 	ax, 4c00h
	int 21h
	
CSEG1 ENDS
END main