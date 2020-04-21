PUBLIC insoctal
PUBLIC number
PUBLIC sign

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

getsigned:
	call 	getchar
	mov	sign, al
num:
	mov	ah, 1
        int	21h
        cmp	al, 13
        je	exitnum
        mov	cl, al
        mov	ax, 8
        mul	bx
        mov	bx, ax
        mov	ch, 0
        sub	cl, '0'
        add	bx, cx
        jmp num

exitnum:
	mov	number, bx
	ret
	

insoctal proc near

	lea	dx, msgInO
	call	outstr
	call 	entryout
	call 	getsigned
	
	ret
insoctal endp

CSEG1 ENDS
END