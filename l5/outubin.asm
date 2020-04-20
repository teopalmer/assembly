PUBLIC outubin

DSEG SEGMENT PARA PUBLIC 'DATA'
	p	db 0 ;
	d	db 10
	sign	db 0
	array	db 9*9 dup ('-')
	crlf	db 10, 13, '$'
	msgOut	db 'Converted binary number: $'
DSEG ENDS

CSEG1 SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG1, DS:DSEG

numtobin:
	ret

outubin proc near
	mov 	sign, bl
	mov	bl, 1
	mov	p, bl
	mov 	ax, cx
	div	d
	mov	dl, ah
	mov	cx, ax

	cmp	cx, 0
	je	exit
	
exit:
	ret
outubin endp

CSEG1 ENDS
END