EXTRN insoctal: near
EXTRN outubin: near
EXTRN outuhex: near
EXTRN number: word
EXTRN sign: byte

STK SEGMENT PARA STACK 'STACK'
	DB	100 DUP (0)
STK ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
	crlf	db 10, 13, '$'
	msgMenu	db 'Main Menu:$'
	msgIn	db '1. Enter signed octal number$'
	msgBin	db '2. Get unsigned binary number$'
	msgHex	db '3. Get unsigned hexadecimal number$'
	msgEnd	db '0. Exit$'
	actions dw exit, insoctal, outubin, outuhex
	DB	100 DUP(0)
DSEG ENDS

CSEG1 SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG1, DS:DSEG, SS:STK

exit proc
	mov 	ax, 4c00h
	int 	21h
	ret
exit endp

getdigit: 		
	mov 	ah, 1h
	int 	21h
	sub 	al, '0'
	mov 	cl, 2
	mul	cl
	mov 	si, ax
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
	ret

displaymenu:
	lea 	dx, msgMenu
	call 	outstr
	call	entry

	lea 	dx, msgIn
	call 	outstr
	call	entry

	lea 	dx, msgBin
	call 	outstr
	call	entry

	lea 	dx, msgHex
	call 	outstr
	call	entry

	lea 	dx, msgEnd
	call 	outstr
	call	entry
	ret

main:	
	mov 	ax, DSEG
	mov 	ds, ax
	mov 	cx, 12

progwork:
	call 	displaymenu
	call 	getdigit
	call 	entryout
	mov 	cx, number
	call	actions[si]
	jmp	progwork

exitprog:
	mov 	ax, 4c00h
	int 	21h
	

CSEG1 ENDS
END main