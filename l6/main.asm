.MODEL TINY
.386
	

.CODE
        ORG 100H

MAIN:  JMP INIT

        SAVEDISR DD ?
        flag    DB  '1'

MYISR:
        PUSH     DI                      
        PUSH     DX
        PUSH     CX
        PUSH     BX
        PUSH     AX
        PUSH     ES
        PUSH     DS
        PUSH     SI


        MOV     AH, 02H  ;CH=HH, CL=MM, DH=SS
        INT     1AH

        MOV     AX, 0B800H
        MOV     ES, AX

        MOV     DI, 3984 ;[(Y * 80)+X]*2

        MOV     BL, 2
        
HHDISPLAY:    ROL     CH, 4

        MOV      AL,CH
        AND      AL,0FH
        ADD      AL,30H
        MOV      AH,17H
        MOV      ES:[DI], AX
        INC      DI
        INC      DI
        DEC      BL
        JNZ HHDISPLAY

        MOV AL,':'
        MOV AH,94H															
        MOV ES:[DI],AX

        INC DI
        INC DI

        MOV BL,02     

MMDISPLAY:    
        ROL CL,4                      

        MOV AL,CL
        AND AL,0FH
        ADD AL,30H
        MOV AH,17H
        MOV ES:[DI],AX
        INC DI
        INC DI
        DEC BL
        JNZ MMDISPLAY


        MOV AL,':'
        MOV AH,94H
        MOV ES:[DI],AX

        INC DI
        INC DI

            
        MOV BL,02
SSDISPLAY:    

        ROL DH,4

        MOV AL,DH
        AND AL,0FH
        ADD AL,30H
        MOV AH,17H
        MOV ES:[DI],AX
        INC DI
        INC DI
        DEC BL
        JNZ SSDISPLAY


        POP     DI                      
        POP     DX
        POP     CX
        POP     BX
        POP     AX
        POP     ES
        POP     DS
        POP     SI

        JMP CS:SAVEDISR

INIT:   
	CLI
        MOV AH,35H       
        MOV AL,08H              
        INT 21H                 

	CMP es:flag, '1'
	JE	EXITPROG

        MOV WORD PTR SAVEDISR, BX
        MOV WORD PTR SAVEDISR + 2, ES

        MOV AH,25H              
        MOV AL,08H              
        LEA DX, MYISR         
        INT 21H

        MOV AH,31H
        LEA DX,INIT             
        STI                     
        INT 21H

EXITPROG:
    	PUSH ES
    	PUSH DS

    	MOV DX, WORD PTR ES:SAVEDISR
    	MOV DS, WORD PTR ES:SAVEDISR + 2
    	MOV AX, 2508H
    	INT 21H

    	POP DS
    	POP ES

	MOV AH, 49H
    	INT 21H
    	MOV AX, 4C00H
    	INT 21H

END MAIN