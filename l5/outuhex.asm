PUBLIC outuhex
EXTRN number: word
EXTRN sign:byte

DSEG SEGMENT PARA PUBLIC 'DATA'
	crlf	db 10, 13, '$'
	msgOut	db 'Converted binary number: $'
	HexTabl  db     '0123456789abcdef'
	asHex    db     '00', '$'
DSEG ENDS

CSEG1 SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG1, DS:DSEG


ShowHex proc
        push 	ax
	
        mov     di, OFFSET asHex
        mov     cx, ax
        and     ax, 000fh
        mov     bx, OFFSET HexTabl
        xlat
        mov     [di+1], al
 
        mov     ax, cx
        and     ax, 00f0h
        mov     cl, 4
        shr     ax, cl
        xlat
        mov     [di], al
 
        mov     ah, 09h
        mov     dx, OFFSET asHex
        int     21h
        pop	ax
        ret
ShowHex ENDP

outuhex proc near
	mov	ah, 2h
	mov 	dl, sign
	int 	21h
	mov	ax, number
        xchg    al, ah
        call    ShowHex
        xchg    al, ah
        call    ShowHex
outuhex endp

CSEG1 ENDS
END