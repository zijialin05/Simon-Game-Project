#include <xc.inc>
    
global  GLCD_Setup, OUT_1
extrn	GLCD_Select_y1, GLCD_Select_y2, GLCD_Select_x1, GLCD_Select_x2
extrn	GLCD_Write_Display1, GLCD_Write_Display2, GLCD_Read_Status
extrn	GLCD_ON1, GLCD_ON2, GLCD_OFF1, GLCD_OFF2


psect	uart_code,class=CODE

OUT_1:	;write the bitmap to fixed position one byte by one byte
	movlw	0x05			;starting from line 5
	call	GLCD_Select_y1
	movlw	0x00			;writing to page 0
	call	GLCD_Select_x1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00001000B
	call	GLCD_Write_Display1
	movlw	11111100B
	call	GLCD_Write_Display1
	movlw	11111100B
	call	GLCD_Write_Display1
	movlw	0x05			;starting from line 5
	call	GLCD_Select_y1
	movlw	0x01			;writing to page 1
	call	GLCD_Select_x1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00011111B
	call	GLCD_Write_Display1
	movlw	00011111B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	return

CLR_1:	;write the bitmap to fixed position one byte by one byte
	movlw	0x05			;starting from line 5
	call	GLCD_Select_y1
	movlw	0x00			;writing to page 0
	call	GLCD_Select_x1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x05			;starting from line 5
	call	GLCD_Select_y1
	movlw	0x01			;writing to page 1
	call	GLCD_Select_x1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	return

OUT_2:	;write the bitmap to fixed position one byte by one byte
	movlw	0x24			;starting from line 36
	call	GLCD_Select_y1
	movlw	0x00			;writing to page 0
	call	GLCD_Select_x1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00001000B
	call	GLCD_Write_Display1
	movlw	00000100B
	call	GLCD_Write_Display1
	movlw	00000100B
	call	GLCD_Write_Display1
	movlw	10000100B
	call	GLCD_Write_Display1
	movlw	10000100B
	call	GLCD_Write_Display1
	movlw	01001000B
	call	GLCD_Write_Display1
	movlw	00110000B
	call	GLCD_Write_Display1
	movlw	0x24			;starting from line 36
	call	GLCD_Select_y1
	movlw	0x01			;writing to page 1
	call	GLCD_Select_x1
	movlw	00011000B
	call	GLCD_Write_Display1
	movlw	00010100B
	call	GLCD_Write_Display1
	movlw	00010010B
	call	GLCD_Write_Display1
	movlw	00010001B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	return

CLR_2:	;write the bitmap to fixed position one byte by one byte
	movlw	0x24			;starting from line 36
	call	GLCD_Select_y1
	movlw	0x00			;writing to page 0
	call	GLCD_Select_x1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x24			;starting from line 36
	call	GLCD_Select_y1
	movlw	0x01			;writing to page 1
	call	GLCD_Select_x1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	return

OUT_3:
	movlw	0x3C			;starting from line 60
	call	GLCD_Select_y1
	movlw	0x00			;writing to page 0
	call	GLCD_Select_x1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00001000B
	call	GLCD_Write_Display1
	movlw	10001000B
	call	GLCD_Write_Display1
	movlw	0x3C			;starting from line 60
	call	GLCD_Select_y1
	movlw	0x01			;writing to page 1
	movlw	00001000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	0x00			;starting from chip 2 line 0
	call	GLCD_Select_y2
	movlw	0x00			;writing to page 0
	call	GLCD_Select_x2
	movlw	10001000B
	call	GLCD_Write_Display2
	movlw	01001000B
	call	GLCD_Write_Display2
	movlw	00110000B
	call	GLCD_Write_Display2
	movlw	0x00			;starting from chip 2 line 0
	call	GLCD_Select_y2
	movlw	0x01			;writing to page 1
	call	GLCD_Select_x2
	movlw	00010000B
	call	GLCD_Write_Display2
	movlw	00010001B
	call	GLCD_Write_Display2
	movlw	00001110B
	call	GLCD_Write_Display2
	return

CLR_3:
	movlw	0x3C			;starting from line 60
	call	GLCD_Select_y1
	movlw	0x00			;writing to page 0
	call	GLCD_Select_x1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x3C			;starting from line 60
	call	GLCD_Select_y1
	movlw	0x01			;writing to page 1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00
	call	GLCD_Write_Display1
	movlw	0x00			;starting from chip 2 line 0
	call	GLCD_Select_y2
	movlw	0x00			;writing to page 0
	call	GLCD_Select_x2
	movlw	0x00
	call	GLCD_Write_Display2
	movlw	0x00
	call	GLCD_Write_Display2
	movlw	0x00
	call	GLCD_Write_Display2
	movlw	0x00			;starting from chip 2 line 0
	call	GLCD_Select_y2
	movlw	0x01			;writing to page 1
	call	GLCD_Select_x2
	movlw	0x00
	call	GLCD_Write_Display2
	movlw	0x00
	call	GLCD_Write_Display2
	movlw	0x00
	call	GLCD_Write_Display2
	return
	
	
	