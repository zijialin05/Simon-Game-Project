#include <xc.inc>
    
global  GLCD_Setup
extrn	GLCD_Select_y1, GLCD_Select_y2, GLCD_Select_x1, GLCD_Select_x2
extrn	GLCD_Write_Display1, GLCD_Write_Display2


psect	uart_code,class=CODE

OUT_1:	;write the bitmap to fixed position one byte by one byte
	movlw	00000010B		;Start from line 2, omit lines with 0s
	call	GLCD_Select_y1
	movlw	00000001B
	call	GLCD_Select_x1		;1st byte
	movlw	00000001B
	call	GLCD_Write_Display1
	movlw	00000010B
	call	GLCD_Select_x1		;2nd byte
	movlw	10000000B
	call	GLCD_Write_Display1
	movlw	00000011B
	call	GLCD_Select_y1		;line 3
	movlw	00000001B
	call	GLCD_Select_x1		;1st byte
	movlw	00000011B
	call	GLCD_Write_Display1
	movlw	00000010B
	call	GLCD_Select_x1		;2nd byte
	movlw	10000000B
	call	GLCD_Write_Display1
	movlw	00000100B
	call	GLCD_Select_y1		;line 4
	movlw	00000001B
	call	GLCD_Select_x1		;1st byte
	movlw	00000101B
	call	GLCD_Write_Display1
	movlw	00000010B
	call	GLCD_Select_x1		;2nd byte
	movlw	10000000B
	call	GLCD_Write_Display1
	movlw	00000101B
	call	GLCD_Select_y1		;line 5
	movlw	00000001B
	call	GLCD_Select_x1		;1st byte
	movlw	00000001B
	call	GLCD_Write_Display1
	movlw	00000010B
	call	GLCD_Select_x1		;2nd byte
	movlw	10000000B
	call	GLCD_Write_Display1
	movlw	00000110B
	call	GLCD_Select_y1		;line 6
	movlw	00000001B
	call	GLCD_Select_x1		;1st byte
	movlw	00000001B
	call	GLCD_Write_Display1
	movlw	00000010B
	call	GLCD_Select_x1		;2nd byte
	movlw	10000000B
	call	GLCD_Write_Display1
	movlw	00000111B
	call	GLCD_Select_y1		;line 7
	movlw	00000001B
	call	GLCD_Select_x1		;1st byte
	movlw	00000001B
	call	GLCD_Write_Display1
	movlw	00000010B
	call	GLCD_Select_x1		;2nd byte
	movlw	10000000B
	call	GLCD_Write_Display1
	movlw	00001000B
	call	GLCD_Select_y1		;line 8
	movlw	00000001B
	call	GLCD_Select_x1		;1st byte
	movlw	00000001B
	call	GLCD_Write_Display1
	movlw	00000010B
	call	GLCD_Select_x1		;2nd byte
	movlw	10000000B
	call	GLCD_Write_Display1
	movlw	00001001B
	call	GLCD_Select_y1		;line 9
	movlw	00000001B
	call	GLCD_Select_x1		;1st byte
	movlw	00000001B
	call	GLCD_Write_Display1
	movlw	00000010B
	call	GLCD_Select_x1		;2nd byte
	movlw	10000000B
	call	GLCD_Write_Display1
	movlw	00001010B
	call	GLCD_Select_y1		;line 10
	movlw	00000001B
	call	GLCD_Select_x1		;1st byte
	movlw	00000001B
	call	GLCD_Write_Display1
	movlw	00000010B
	call	GLCD_Select_x1		;2nd byte
	movlw	10000000B
	call	GLCD_Write_Display1
	movlw	00001011B
	call	GLCD_Select_y1		;line 11
	movlw	00000001B
	call	GLCD_Select_x1		;1st byte
	movlw	00000001B
	call	GLCD_Write_Display1
	movlw	00000010B
	call	GLCD_Select_x1		;2nd byte
	movlw	10000000B
	call	GLCD_Write_Display1
	movlw	00001100B
	call	GLCD_Select_y1		;line 12
	movlw	00000001B
	call	GLCD_Select_x1		;1st byte
	movlw	00000111B
	call	GLCD_Write_Display1
	movlw	00000010B
	call	GLCD_Select_x1		;2nd byte
	movlw	11100000B
	call	GLCD_Write_Display1
	return
	
	
	