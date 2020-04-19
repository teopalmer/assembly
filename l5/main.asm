STK SEGMENT PARA STACK 'STACK'
	DB	100 DUP (0)
STK ENDS

DSEG SEGMENT WORD 'DATA'
	a	db ? ; command task
	array	db 9*9 dup ('-')
	crlf	db 10, 13, '$'
	msgMenu	db 'Main Menu:$'
	msgIn	db '1. Enter signed octal number$'
	msgBin	db '2. Get unsigned binary number$'
	msgHex	db '3. Get unsigned hexadecimal number$'
	msgEnd	db '4. Exit$'
	DB	100 DUP(0)
	actions dw insoctal, outubin, outuhex, exit
DSEG ENDS

CSEG1 SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG1, DS:DSEG, SS:STK

getdigit: 		;one digit input
	mov 	ah, 1h
	int 	21h
	sub 	dl, '0'
	mov 	si, dl
	ret

entry:
	xor	dx, dx
	mov 	ah, 2h
	mov 	dl, 13
	int 	21h
	mov 	dl, 10
	int 	21h
	ret

entryout:
	lea 	dx, crlf
	call 	outstr
	ret

outstr:
	mov 	ah, 09h
	int 	21h
	call 	entryout
	ret

displaymenu:
	lea 	dx, msgMenu
	call 	outstr

	lea 	dx, msgIn
	call 	outstr

	lea 	dx, msgBin
	call 	outstr

	lea 	dx, msgHex
	call 	outstr

	lea 	dx, msgHex
	call 	outstr

	lea 	dx, msgEnd
	call 	outstr
	ret

main:	
	mov 	ax, DSEG
	mov 	ds, ax

	call 	displaymenu
	call	getdigit

exitprog:
	mov 	ax, 4c00h
	int 	21h
	

CSEG1 ENDS
END main