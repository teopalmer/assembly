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
	DB	100 DUP(0)
DSEG ENDS

CSEG1 SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG1, DS:DSEG, SS:STK

entry:
	xor	dx, dx
	mov 	ah, 2h
	mov 	dl, 13
	int 	21h
	mov 	dl, 10
	int 	21h
	ret

outstr:
	mov ah, 09h
	int 21h
	ret

entryout:
	lea dx, crlf
	call outstr
	ret

input:	
	lea 	dx, msgIn
	call 	outstr
	ret

bin:	
	ret	

hex:
	ret	

main:	
	mov 	ax, DSEG
	mov 	ds, ax

	lea 	dx, msgMenu
	call 	outstr
	call	entryout

	lea 	dx, msgIn
	call 	outstr
	call	entryout

	lea 	dx, msgBin
	call 	outstr
	call	entryout

	lea 	dx, msgHex
	call 	outstr
	call	entryout

	mov	ah, 1h
	int 	21h
	
	

exitprog:
	mov 	ax, 4c00h
	int 	21h
	mov	a, dh

	

CSEG1 ENDS
END main