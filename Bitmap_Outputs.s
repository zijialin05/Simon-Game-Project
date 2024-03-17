#include <xc.inc>
    
global  GLCD_Setup, Output_Bitmap, Clear_Bitmap, Output_Score_Digit, Clear_Score
global	OUT_0, OUT_1, OUT_2, OUT_3, OUT_4, OUT_5, OUT_6, OUT_7, OUT_8, OUT_9
global	CLR_0, CLR_1, CLR_2, CLR_3, CLR_4, CLR_5, CLR_6, CLR_7, CLR_8, CLR_9
extrn	GLCD_Select_y1, GLCD_Select_y2, GLCD_Select_x1, GLCD_Select_x2
extrn	GLCD_Write_Display1, GLCD_Write_Display2, GLCD_Read_Status
extrn	GLCD_ON1, GLCD_ON2, GLCD_OFF1, GLCD_OFF2

psect	udata_acs
OUT_TEMP:	    ds  1
COUNTER:	    ds	1

psect	uart_code,class=CODE

Output_Score_Digit:
	movwf	OUT_TEMP, A
	movf	OUT_TEMP, W, A
	btfsc   STATUS, 2
	call	SCORE0
	movf	OUT_TEMP, W, A
	sublw	0x01
	btfsc   STATUS, 2
	call	SCORE1
	movf	OUT_TEMP, W, A
	sublw	0x02
	btfsc   STATUS, 2
	call	SCORE2
	movf	OUT_TEMP, W, A
	sublw	0x03
	btfsc   STATUS, 2
	call	SCORE3
	movf	OUT_TEMP, W, A
	sublw	0x04
	btfsc   STATUS, 2
	call	SCORE4
	movf	OUT_TEMP, W, A
	sublw	0x05
	btfsc   STATUS, 2
	call	SCORE5
	movf	OUT_TEMP, W, A
	sublw	0x06
	btfsc   STATUS, 2
	call	SCORE6
	movf	OUT_TEMP, W, A
	sublw	0x07
	btfsc   STATUS, 2
	call	SCORE7
	movf	OUT_TEMP, W, A
	sublw	0x08
	btfsc   STATUS, 2
	call	SCORE8
	movf	OUT_TEMP, W, A
	sublw	0x09
	btfsc   STATUS, 2
	call	SCORE9
	return

Clear_Score:
	movlw	0x1C	;Total of 28 Y Addresses to Clear
	movwf	COUNTER, A
	movlw	0x01	;Choose Page 1 of Chip 2
	call	GLCD_Select_x2
	movlw	0x24	;Start from Y address 36
	call	GLCD_Select_y2
clear_one_address:
	movlw	0x00	;Write zeros to clear display line
	call	GLCD_Write_Display2
	decfsz	COUNTER, A	    ;decrement counter, skip if zero
	bra	clear_one_address   ;continue to clear if COUNTER not zero
	return

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
	call GLCD_Select_y2
	movlw 0x00
	call GLCD_Select_x2
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
	call GLCD_Select_y2
	movlw 0x01
	call GLCD_Select_x2
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
	
SCORE0:
	;SCOREX is the module for oututing the 8x8 bitmaps of integer X
	;SCOREX modules are implemented for outputing scores on the GLCD
	;Bitmaps will appear on the first page of display 2
	;Y address must be specified before calling these modules
	;NOTE: THESE ARE GENERAL COMMENTS FOR ALL SCOREX MODULES
	;NOTE: THESE COMMENTS WILL NOT APPEAR AGAIN IN OTHER SCOREX MODULES
	movlw	0x01
	call	GLCD_Select_x2		;Select Page 1 of Display 2
	movlw	00111100B
	call	GLCD_Write_Display2	;Write 0th byte
	movlw	01111110B
	call	GLCD_Write_Display2	;Write 1st byte
	movlw	11000011B
	call	GLCD_Write_Display2	;Write 2nd byte
	movlw	10000001B
	call	GLCD_Write_Display2	;Write 3rd byte
	movlw	10000001B
	call	GLCD_Write_Display2	;Write 4th byte
	movlw	11000011B
	call	GLCD_Write_Display2	;Write 5th byte
	movlw	01111110B
	call	GLCD_Write_Display2	;Write 6th byte
	movlw	00111100B
	call	GLCD_Write_Display2	;Write 7th byte
	return

SCORE1:
	movlw	0x01
	call	GLCD_Select_x2		;Select Page 1 of Display 2
	movlw	00000000B
	call	GLCD_Write_Display2	;Write 0th byte
	movlw	00000000B
	call	GLCD_Write_Display2	;Write 1st byte
	movlw	11000010B
	call	GLCD_Write_Display2	;Write 2nd byte
	movlw	11111111B
	call	GLCD_Write_Display2	;Write 3rd byte
	movlw	11111111B
	call	GLCD_Write_Display2	;Write 4th byte
	movlw	11000000B
	call	GLCD_Write_Display2	;Write 5th byte
	movlw	00000000B
	call	GLCD_Write_Display2	;Write 6th byte
	movlw	00000000B
	call	GLCD_Write_Display2	;Write 7th byte
	return

SCORE2:
	movlw	0x01
	call	GLCD_Select_x2		;Select Page 1 of Display 2
	movlw	00000100B
	call	GLCD_Write_Display2	;Write 0th byte
	movlw	11000110B
	call	GLCD_Write_Display2	;Write 1st byte
	movlw	11100011B
	call	GLCD_Write_Display2	;Write 2nd byte
	movlw	11100001B
	call	GLCD_Write_Display2	;Write 3rd byte
	movlw	11010001B
	call	GLCD_Write_Display2	;Write 4th byte
	movlw	11011011B
	call	GLCD_Write_Display2	;Write 5th byte
	movlw	11001110B
	call	GLCD_Write_Display2	;Write 6th byte
	movlw	11000100B
	call	GLCD_Write_Display2	;Write 7th byte
	return

SCORE3:
	movlw	0x01
	call	GLCD_Select_x2		;Select Page 1 of Display 2
	movlw	00100000B
	call	GLCD_Write_Display2	;Write 0th byte
	movlw	01100010B
	call	GLCD_Write_Display2	;Write 1st byte
	movlw	11000011B
	call	GLCD_Write_Display2	;Write 2nd byte
	movlw	10001001B
	call	GLCD_Write_Display2	;Write 3rd byte
	movlw	10001001B
	call	GLCD_Write_Display2	;Write 4th byte
	movlw	11001011B
	call	GLCD_Write_Display2	;Write 5th byte
	movlw	01111110B
	call	GLCD_Write_Display2	;Write 6th byte
	movlw	00110100B
	call	GLCD_Write_Display2	;Write 7th byte
	return

SCORE4:
	movlw	0x01
	call	GLCD_Select_x2		;Select Page 1 of Display 2
	movlw	00110000B
	call	GLCD_Write_Display2	;Write 0th byte
	movlw	00111000B
	call	GLCD_Write_Display2	;Write 1st byte
	movlw	00101100B
	call	GLCD_Write_Display2	;Write 2nd byte
	movlw	00100110B
	call	GLCD_Write_Display2	;Write 3rd byte
	movlw	00100011B
	call	GLCD_Write_Display2	;Write 4th byte
	movlw	11111111B
	call	GLCD_Write_Display2	;Write 5th byte
	movlw	00100000B
	call	GLCD_Write_Display2	;Write 6th byte
	movlw	00100000B
	call	GLCD_Write_Display2	;Write 7th byte
	return

SCORE5:
	movlw	0x01
	call	GLCD_Select_x2		;Select Page 1 of Display 2
	movlw	00100000B
	call	GLCD_Write_Display2	;Write 0th byte
	movlw	01101111B
	call	GLCD_Write_Display2	;Write 1st byte
	movlw	11001111B
	call	GLCD_Write_Display2	;Write 2nd byte
	movlw	10001011B
	call	GLCD_Write_Display2	;Write 3rd byte
	movlw	10001011B
	call	GLCD_Write_Display2	;Write 4th byte
	movlw	11111011B
	call	GLCD_Write_Display2	;Write 5th byte
	movlw	01110011B
	call	GLCD_Write_Display2	;Write 6th byte
	movlw	00000000B
	call	GLCD_Write_Display2	;Write 7th byte
	return

SCORE6:
	movlw	0x01
	call	GLCD_Select_x2		;Select Page 1 of Display 2
	movlw	00111100B
	call	GLCD_Write_Display2	;Write 0th byte
	movlw	01111110B
	call	GLCD_Write_Display2	;Write 1st byte
	movlw	11001011B
	call	GLCD_Write_Display2	;Write 2nd byte
	movlw	10001001B
	call	GLCD_Write_Display2	;Write 3rd byte
	movlw	10001001B
	call	GLCD_Write_Display2	;Write 4th byte
	movlw	11111011B
	call	GLCD_Write_Display2	;Write 5th byte
	movlw	01110010B
	call	GLCD_Write_Display2	;Write 6th byte
	movlw	00000000B
	call	GLCD_Write_Display2	;Write 7th byte
	return

SCORE7:
	movlw	0x01
	call	GLCD_Select_x2		;Select Page 1 of Display 2
	movlw	00000011B
	call	GLCD_Write_Display2	;Write 0th byte
	movlw	00000011B
	call	GLCD_Write_Display2	;Write 1st byte
	movlw	00000011B
	call	GLCD_Write_Display2	;Write 2nd byte
	movlw	11110011B
	call	GLCD_Write_Display2	;Write 3rd byte
	movlw	11111011B
	call	GLCD_Write_Display2	;Write 4th byte
	movlw	00001111B
	call	GLCD_Write_Display2	;Write 5th byte
	movlw	00000111B
	call	GLCD_Write_Display2	;Write 6th byte
	movlw	00000011B
	call	GLCD_Write_Display2	;Write 7th byte
	return

SCORE8:
	movlw	0x01
	call	GLCD_Select_x2		;Select Page 1 of Display 2
	movlw	00100100B
	call	GLCD_Write_Display2	;Write 0th byte
	movlw	01101110B
	call	GLCD_Write_Display2	;Write 1st byte
	movlw	11011011B
	call	GLCD_Write_Display2	;Write 2nd byte
	movlw	10010001B
	call	GLCD_Write_Display2	;Write 3rd byte
	movlw	10010001B
	call	GLCD_Write_Display2	;Write 4th byte
	movlw	11011011B
	call	GLCD_Write_Display2	;Write 5th byte
	movlw	01101110B
	call	GLCD_Write_Display2	;Write 6th byte
	movlw	00100100B
	call	GLCD_Write_Display2	;Write 7th byte
	return

SCORE9:
	movlw	0x01
	call	GLCD_Select_x2		;Select Page 1 of Display 2
	movlw	00001100B
	call	GLCD_Write_Display2	;Write 0th byte
	movlw	01011110B
	call	GLCD_Write_Display2	;Write 1st byte
	movlw	11010011B
	call	GLCD_Write_Display2	;Write 2nd byte
	movlw	10010001B
	call	GLCD_Write_Display2	;Write 3rd byte
	movlw	10010001B
	call	GLCD_Write_Display2	;Write 4th byte
	movlw	11111111B
	call	GLCD_Write_Display2	;Write 5th byte
	movlw	01111110B
	call	GLCD_Write_Display2	;Write 6th byte
	movlw	00000000B
	call	GLCD_Write_Display2	;Write 7th byte
	return
