#include <xc.inc>
    
global  GLCD_Setup, Output_Bitmap, Clear_Bitmap
global	OUT_0, OUT_1, OUT_2, OUT_3, OUT_4, OUT_5, OUT_6, OUT_7, OUT_8, OUT_9
global	CLR_0, CLR_1, CLR_2, CLR_3, CLR_4, CLR_5, CLR_6, CLR_7, CLR_8, CLR_9
extrn	GLCD_Select_y1, GLCD_Select_y2, GLCD_Select_x1, GLCD_Select_x2
extrn	GLCD_Write_Display1, GLCD_Write_Display2, GLCD_Read_Status
extrn	GLCD_ON1, GLCD_ON2, GLCD_OFF1, GLCD_OFF2

psect	udata_acs
OUT_TEMP:	    ds  1

psect	uart_code,class=CODE

Output_Bitmap:
	movwf	OUT_TEMP, A
	movf	OUT_TEMP, W, A
	btfsc   STATUS, 2
	call	OUT_0
	movf	OUT_TEMP, W, A
	sublw	0x01
	btfsc   STATUS, 2
	call	OUT_1
	movf	OUT_TEMP, W, A
	sublw	0x02
	btfsc   STATUS, 2
	call	OUT_2
	movf	OUT_TEMP, W, A
	sublw	0x03
	btfsc   STATUS, 2
	call	OUT_3
	movf	OUT_TEMP, W, A
	sublw	0x04
	btfsc   STATUS, 2
	call	OUT_4
	movf	OUT_TEMP, W, A
	sublw	0x05
	btfsc   STATUS, 2
	call	OUT_5
	movf	OUT_TEMP, W, A
	sublw	0x06
	btfsc   STATUS, 2
	call	OUT_6
	movf	OUT_TEMP, W, A
	sublw	0x07
	btfsc   STATUS, 2
	call	OUT_7
	movf	OUT_TEMP, W, A
	sublw	0x08
	btfsc   STATUS, 2
	call	OUT_8
	movf	OUT_TEMP, W, A
	sublw	0x09
	btfsc   STATUS, 2
	call	OUT_9
	return

Clear_Bitmap:
	movwf	OUT_TEMP, A
	movf	OUT_TEMP, W, A
	btfsc   STATUS, 2
	call	CLR_0
	movf	OUT_TEMP, W, A
	sublw	0x01
	btfsc   STATUS, 2
	call	CLR_1
	movf	OUT_TEMP, W, A
	sublw	0x02
	btfsc   STATUS, 2
	call	CLR_2
	movf	OUT_TEMP, W, A
	sublw	0x03
	btfsc   STATUS, 2
	call	CLR_3
	movf	OUT_TEMP, W, A
	sublw	0x04
	btfsc   STATUS, 2
	call	CLR_4
	movf	OUT_TEMP, W, A
	sublw	0x05
	btfsc   STATUS, 2
	call	CLR_5
	movf	OUT_TEMP, W, A
	sublw	0x06
	btfsc   STATUS, 2
	call	CLR_6
	movf	OUT_TEMP, W, A
	sublw	0x07
	btfsc   STATUS, 2
	call	CLR_7
	movf	OUT_TEMP, W, A
	sublw	0x08
	btfsc   STATUS, 2
	call	CLR_8
	movf	OUT_TEMP, W, A
	sublw	0x09
	btfsc   STATUS, 2
	call	CLR_9
	return


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
	movlw	0x01			;writing 
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
	
	

OUT_3:
	movlw 0x05
	call GLCD_Select_y2
	movlw 0x00
	call GLCD_Select_x2
	movlw 00010000B
	call GLCD_Write_Display2
	movlw 00001000B
	call GLCD_Write_Display2
	movlw 10001000B
	call GLCD_Write_Display2
	movlw 10001000B
	call GLCD_Write_Display2
	movlw 01001000B
	call GLCD_Write_Display2
	movlw 00110000B
	call GLCD_Write_Display2
	
	
	movlw 0x05
	call GLCD_Select_y2
	movlw 0x01
	call GLCD_Select_x2
	movlw 00001000B
	call GLCD_Write_Display2
	movlw 00010000B
	call GLCD_Write_Display2
	movlw 00010000B
	call GLCD_Write_Display2
	movlw 00010000B
	call GLCD_Write_Display2
	movlw 00010001B
	call GLCD_Write_Display2
	movlw 00001110B
	call GLCD_Write_Display2
	return
	

CLR_3:
	movlw 0x05
	call GLCD_Select_y1
	movlw 0x00
	call GLCD_Select_x1
	movlw 00000000B
	call GLCD_Write_Display2
	movlw 00000000B
	call GLCD_Write_Display2
	movlw 00000000B
	call GLCD_Write_Display2
	movlw 00000000B
	call GLCD_Write_Display2
	movlw 00000000B
	call GLCD_Write_Display2
	movlw 00000000B
	call GLCD_Write_Display2
	
	
	movlw 0x05
	call GLCD_Select_y1
	movlw 0x01
	call GLCD_Select_x1
	movlw 00000000B
	call GLCD_Write_Display2
	movlw 00000000B
	call GLCD_Write_Display2
	movlw 00000000B
	call GLCD_Write_Display2
	movlw 00000000B
	call GLCD_Write_Display2
	movlw 00000000B
	call GLCD_Write_Display2
	movlw 00000000B
	call GLCD_Write_Display2
	return
	
OUT_4:
	movlw 0x05
	call GLCD_Select_y1
	movlw 0x02
	call GLCD_Select_x1
	movlw 10000000B
	call GLCD_Write_Display1
	movlw 01000000B
	call GLCD_Write_Display1
	movlw 00100000B
	call GLCD_Write_Display1
	movlw 00010000B
	call GLCD_Write_Display1
	movlw 00001000B
	call GLCD_Write_Display1
	movlw 11111100B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	
	movlw 0x05
	call GLCD_Select_y1
	movlw 0x03
	call GLCD_Select_x1
	movlw 00000001B
	call GLCD_Write_Display1
	movlw 00000001B
	call GLCD_Write_Display1
	movlw 00000001B
	call GLCD_Write_Display1
	movlw 00000001B
	call GLCD_Write_Display1
	movlw 00000001B
	call GLCD_Write_Display1
	movlw 00011111B
	call GLCD_Write_Display1
	movlw 00000001B
	call GLCD_Write_Display1
	movlw 00000001B
	call GLCD_Write_Display1
	return
	
CLR_4:
	movlw 0x05
	call GLCD_Select_y1
	movlw 0x02
	call GLCD_Select_x1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	
	movlw 0x05
	call GLCD_Select_y1
	movlw 0x03
	call GLCD_Select_x1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	movlw 00000000B
	call GLCD_Write_Display1
	return
	
OUT_5:
	movlw	0x25			
	call	GLCD_Select_y1
	movlw	0x02			
	call	GLCD_Select_x1
	movlw	01111000B
	call	GLCD_Write_Display1
	movlw	01001000B
	call	GLCD_Write_Display1
	movlw	01001000B
	call	GLCD_Write_Display1
	movlw	01001000B
	call	GLCD_Write_Display1
	movlw	01001000B
	call	GLCD_Write_Display1
	movlw	10001000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	
	movlw	0x25			
	call	GLCD_Select_y1
	movlw	0x03			
	call	GLCD_Select_x1
	movlw	00001000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00001000B
	call	GLCD_Write_Display1
	movlw	00000111B
	call	GLCD_Write_Display1
	return 
    
CLR_5:
	movlw	0x25			
	call	GLCD_Select_y1
	movlw	0x02			
	call	GLCD_Select_x1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	
	movlw	0x25			
	call	GLCD_Select_y1
	movlw	0x03			
	call	GLCD_Select_x1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	return 
    
OUT_6:
	movlw	0x05
	call	GLCD_Select_y2
	movlw	0x02
	call	GLCD_Select_x2
	movlw	11100000B
	call	GLCD_Write_Display2
	movlw	10010000B
	call	GLCD_Write_Display2
	movlw	10001000B
	call	GLCD_Write_Display2
	movlw	10001000B
	call	GLCD_Write_Display2
	movlw	10001000B
	call	GLCD_Write_Display2
	movlw	00001000B
	call	GLCD_Write_Display2
	movlw	00010000B
	call	GLCD_Write_Display2
	
	movlw	0x05
	call	GLCD_Select_y2
	movlw	0x03
	call	GLCD_Select_x2
	movlw	00000111B
	call	GLCD_Write_Display2
	movlw	00001000B
	call	GLCD_Write_Display2
	movlw	00010000B
	call	GLCD_Write_Display2
	movlw	00010000B
	call	GLCD_Write_Display2
	movlw	00010000B
	call	GLCD_Write_Display2
	movlw	00001001B
	call	GLCD_Write_Display2
	movlw	00000110B
	call	GLCD_Write_Display2
	return 
    
CLR_6:
	movlw	0x05
	call	GLCD_Select_y2
	movlw	0x02
	call	GLCD_Select_x2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	
	movlw	0x05
	call	GLCD_Select_y2
	movlw	0x03
	call	GLCD_Select_x2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	return 

OUT_7:
	movlw	0x05
	call	GLCD_Select_y1
	movlw	0x04
	call	GLCD_Select_x1
	movlw	00000100B
	call	GLCD_Write_Display1
	movlw	00000100B
	call	GLCD_Write_Display1
	movlw	00000100B
	call	GLCD_Write_Display1
	movlw	11000100B
	call	GLCD_Write_Display1
	movlw	00100100B
	call	GLCD_Write_Display1
	movlw	00010100B
	call	GLCD_Write_Display1
	movlw	00001100B
	call	GLCD_Write_Display1
	movlw	00000100B
	call	GLCD_Write_Display1
	
	
	movlw	0x05
	call	GLCD_Select_y1
	movlw	0x05
	call	GLCD_Select_x1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00011111B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	return
	
CLR_7:
    
	movlw	0x05
	call	GLCD_Select_y1
	movlw	0x04
	call	GLCD_Select_x1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	
	
	movlw	0x05
	call	GLCD_Select_y1
	movlw	0x05
	call	GLCD_Select_x1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	return
	
OUT_8:
	movlw	0x25			
	call	GLCD_Select_y1
	movlw	0x04			
	call	GLCD_Select_x1
	movlw	01110000B
	call	GLCD_Write_Display1
	movlw	10001000B
	call	GLCD_Write_Display1
	movlw	10001000B
	call	GLCD_Write_Display1
	movlw	10001000B
	call	GLCD_Write_Display1
	movlw	10001000B
	call	GLCD_Write_Display1
	movlw	01110000B
	call	GLCD_Write_Display1
	
	movlw	0x25			
	call	GLCD_Select_y1
	movlw	0x05			
	call	GLCD_Select_x1
	movlw	00001111B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00001111B
	call	GLCD_Write_Display1
	return
    
CLR_8: 
	movlw	0x25			
	call	GLCD_Select_y1
	movlw	0x04			
	call	GLCD_Select_x1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	
	movlw	0x25			
	call	GLCD_Select_y1
	movlw	0x05			
	call	GLCD_Select_x1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	return
    
OUT_9:
	movlw	0x05
	call	GLCD_Select_y2
	movlw	0x04
	call	GLCD_Select_x2
	movlw	11100000B
	call	GLCD_Write_Display2
	movlw	00010000B
	call	GLCD_Write_Display2
	movlw	00001000B
	call	GLCD_Write_Display2
	movlw	00001000B
	call	GLCD_Write_Display2
	movlw	00001000B
	call	GLCD_Write_Display2
	movlw	00010000B
	call	GLCD_Write_Display2
	movlw	11100000B
	call	GLCD_Write_Display2
	
	movlw	0x05
	call	GLCD_Select_y2
	movlw	0x05
	call	GLCD_Select_x2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000001B
	call	GLCD_Write_Display2
	movlw	00000010B
	call	GLCD_Write_Display2
	movlw	00010010B
	call	GLCD_Write_Display2
	movlw	00010010B
	call	GLCD_Write_Display2
	movlw	00001001B
	call	GLCD_Write_Display2
	movlw	00000111B
	call	GLCD_Write_Display2
	return
	
CLR_9:
	movlw	0x05
	call	GLCD_Select_y2
	movlw	0x04
	call	GLCD_Select_x2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	
	movlw	0x05
	call	GLCD_Select_y2
	movlw	0x05
	call	GLCD_Select_x2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	movlw	00000000B
	call	GLCD_Write_Display2
	return
	
OUT_0:
	movlw	0x24			
	call	GLCD_Select_y1
	movlw	0x06			
	call	GLCD_Select_x1
	movlw	11110000B
	call	GLCD_Write_Display1
	movlw	00001000B
	call	GLCD_Write_Display1
	movlw	00000100B
	call	GLCD_Write_Display1
	movlw	00000100B
	call	GLCD_Write_Display1
	movlw	00000100B
	call	GLCD_Write_Display1
	movlw	00000100B
	call	GLCD_Write_Display1
	movlw	00000100B
	call	GLCD_Write_Display1
	movlw	00001000B
	call	GLCD_Write_Display1
	movlw	11110000B
	call	GLCD_Write_Display1
	
	movlw	0x24			
	call	GLCD_Select_y1
	movlw	0x07			
	call	GLCD_Select_x1
	movlw	00000111B
	call	GLCD_Write_Display1
	movlw	00001000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00010000B
	call	GLCD_Write_Display1
	movlw	00001000B
	call	GLCD_Write_Display1
	movlw	00000111B
	call	GLCD_Write_Display1
	return
	
CLR_0:
	movlw	0x24			
	call	GLCD_Select_y1
	movlw	0x06			
	call	GLCD_Select_x1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	
	movlw	0x24			
	call	GLCD_Select_y1
	movlw	0x07			
	call	GLCD_Select_x1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	movlw	00000000B
	call	GLCD_Write_Display1
	return
	
