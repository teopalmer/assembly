PUBLIC outuhex

DSEG SEGMENT PARA PUBLIC 'DATA'
	a	db ? ; command task
	array	db 9*9 dup ('-')
	crlf	db 10, 13, '$'
	msgOut	db 'Converted hexadecimal number: $'
DSEG ENDS

CSEG1 SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG1, DS:DSEG

outuhex proc near
	ret
outuhex endp

CSEG1 ENDS
END