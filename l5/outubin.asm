PUBLIC outubin
PUBLIC printnum

EXTRN number: word
EXTRN sign: byte

DSEG SEGMENT PARA PUBLIC 'DATA'
	a	db ? ; command task
	binnum	dw 0	
	crlf	db 10, 13, '$'
	msgOut	db 'Number: $'
DSEG ENDS

CSEG1 SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG1, DS:DSEG

printnum proc near
	push  ax
   	xor   cx,cx
   	mov   bx,10

lp1:
   	xor   dx,dx
   	div   bx
   	add   dl,'0'
   	push  dx
   	inc   cx
   	or    ax,ax
   	jnz   lp1

lp2:
   	pop   ax
   	int   29h
   	loop  lp2
	ret
printnum endp


numtobin: ;number in bl
	mov 	bx, number
	cmp	sign, '-'
	jne	outnum
	not 	bx
	inc	bx
outnum:
	mov cx, 16
	outloop:
		mov ax, '0'
		shl bx, 1
		adc al, ah
		
        mov ah, 2
        mov dl, al
        int 21h
	loop outloop
	ret


outubin proc near

	;mov	ax, number
	mov	bx, number
	lea	cx, sign

final:
	mov	dx, offset msgOut
	mov 	ah, 09h
	int 	21h
	call	numtobin
	mov	ah, 09h
	lea 	dx, crlf
	int	21h
   	ret
outubin endp

CSEG1 ENDS
END