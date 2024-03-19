

#include <xc.inc>
    
global  GLCD_Setup, options_display	    ;add the function here: options display
extrn	GLCD_Select_y1, GLCD_Select_y2, GLCD_Select_x1, GLCD_Select_x2
extrn	GLCD_Write_Display1, GLCD_Write_Display2, GLCD_Read_Status
extrn	GLCD_ON1, GLCD_ON2, GLCD_OFF1, GLCD_OFF2


psect	uart_code,class=CODE

options_display:
    ; second screen, line 4 : display "F : DELETE"
	movlw	0x20		   ;starting from y=32
	call	GLCD_Select_y2
	movlw	0x04	
	call	GLCD_Select_x2
	
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00101000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00111000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00101100B
	call    GLCD_Write_Display2
	movlw   00111000B
	call    GLCD_Write_Display2
	movlw   00011000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00100100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00111000B
	call    GLCD_Write_Display2
	movlw   00100000B
	call    GLCD_Write_Display2
	movlw   00111000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00101100B
	call    GLCD_Write_Display2
	movlw   00001100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00001100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00100100B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	
	; second screen, line 5 , display "E : CLEAR"
	movlw	0x20		   ;starting from y=32
	call	GLCD_Select_y2
	movlw	0x05	
	call	GLCD_Select_x2
	
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00101100B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00011000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00100100B
	call    GLCD_Write_Display2
	movlw   00110100B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00110000B
	call    GLCD_Write_Display2
	movlw   00100000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00110100B
	call    GLCD_Write_Display2
	movlw   00110000B
	call    GLCD_Write_Display2
	movlw   00011000B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00110000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	
	; second screen, line 6, display "D : RESTART"
	movlw	0x20		   ;starting from y=32
	call	GLCD_Select_y2
	movlw	0x06	
	call	GLCD_Select_x2
	
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00100100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00011000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00101000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00001000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00100100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00000100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00000100B
	call    GLCD_Write_Display2
	movlw   00110000B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00011000B
	call    GLCD_Write_Display2
	movlw   00110000B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00000100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00001100B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	
	; second screen, line 7, display "C : HOME"
	movlw	0x20		   ;starting from y=32
	call	GLCD_Select_y2
	movlw	0x07
	call	GLCD_Select_x2
	
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00011000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00100100B
	call    GLCD_Write_Display2
	movlw   00110100B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00101000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00001000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00011000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00100100B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00011000B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00011000B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00011100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00111100B
	call    GLCD_Write_Display2
	movlw   00100100B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	movlw   00000000B
	call    GLCD_Write_Display2
	
	return



