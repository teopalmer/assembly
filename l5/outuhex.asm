PUBLIC outuhex
EXTRN number: word
EXTRN sign:byte

DSEG SEGMENT PARA PUBLIC 'DATA'
	crlf	db 10, 13, '$'
	msgOut	db 'Converted binary number: $'
DSEG ENDS

CSEG1 SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG1, DS:DSEG


show proc near
        push    ax
        push    cx
        push    dx
 
        mov    cl,      12
        xchg   dx,      ax
 
loopnum:
 
        mov    ax,      dx
        shr    ax,      cl
        and    al,      0Fh
        add    al,      '0'
        cmp    al,      '9'
        jbe    isdigit
        add    al,      'A'-('9'+1)
 
isdigit:
 
        int    29h                      
        sub    cl,      4
        jnc    loopnum
 
        pop     dx
        pop     cx
        pop     ax
        ret
Show endp

outuhex proc near
	mov	ah, 2h
	mov 	dl, sign
	int 	21h
	mov	ax, number
        call    show

	mov	ah, 09h
	lea 	dx, crlf
	int	21h
	ret
outuhex endp

CSEG1 ENDS
END