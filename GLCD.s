#include <xc.inc>
    
global  GLCD_Setup
global	GLCD_Select_y1, GLCD_Select_y2, GLCD_Select_x1, GLCD_Select_x2
global	GLCD_Write_Display1, GLCD_Write_Display2

psect	udata_acs   ; reserve data space in access ram
; The first few variables are for the delay routines
GLCD_cnt_l:	ds  1   ; reserve 1 byte for variable GLCD_cnt_l
GLCD_cnt_h:	ds  1   ; reserve 1 byte for variable GLCD_cnt_h
GLCD_cnt_ms:	ds  1   ; reserve 1 byte for ms counter
GLCD_tmp:	ds  1   ; reserve 1 byte for temporary use
GLCD_counter:	ds  1   ; reserve 1 byte for variable GLCD_counter
GLCD_DATA:	ds  1	; Data Line Temporary Storage
GLCD_CTRL:	ds  1	; Control Line Temporary Storage
; These variables are for other modules


psect	uart_code,class=CODE

GLCD_Setup:
	clrf	LATD, A	    ;clear the data lines
	clrf	LATB, A	    ;clear the control lines. Reset low Enable High
	;setting Reset to low turn off the display
	;start line set to 0
	clrf	TRISD, A    ;configure PORTD as output
	clrf	TRISB, A    ;configure PORTB as output
	movlw	0x05
	call	GLCD_delay_x4us	;delay 20 microseconds for prudence
	movlw	00100000B   ;set Reset to high and Enable to low
	movwf	LATB, A
	return

GLCD_Read_Status:
	setf	TRISD, A
	movlw	0x05
	call	GLCD_delay_x4us	;delay 20 microseconds
	bcf	LATB, 4, A	;Set Enable to Low
	movlw	00101001B
	movwf	LATB, A
	nop
	nop
	nop
	nop
	nop
	nop
	bsf	LATB, 4, A	;Enable
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	movf	PORTD, W, A	;Read from PORTD the STATUS
	bcf	LATB, 4, A	;Set Enable to Low
	clrf	TRISD, A	;Set to all output
	movlw	0x05
	call	GLCD_delay_x4us	;delay 20 microseconds
	return
	
GLCD_Select_y1:
	bcf	LATB, 4, A  ;Set Enable Low
	addlw	01000000B   ;6-bit Y Address (bit 0-5) in WREG, Add bit 6-7
	movwf	LATD	    ;data line
	movlw	00100010B   ;Y Select Instruction, Segmant 1-64 Selected
	movwf	LATB	    ;control line
	nop
	nop
	nop
	nop		    ;500ns from Set Enable Low
	bsf	LATB, 4, A  ;Set Enable High. Low to High transition occur
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop		    ;500ns from Set Enable High
	bcf	LATB, 4, A  ;Set Enable Low.  High to Low transition occur
	return

GLCD_Select_y2:
	bcf	LATB, 4, A  ;Set Enable Low
	addlw	01000000B   ;6-bit Y Address (bit 0-5) in WREG, Add bit 6-7
	movwf	LATD	    ;data line
	movlw	00100001B   ;Y Select Instruction, Segmant 65-128 Selected
	movwf	LATB	    ;control line
	nop
	nop
	nop
	nop		    ;500ns from Set Enable Low
	bsf	LATB, 4, A  ;Set Enable High. Low to High transition occur
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop		    ;500ns from Set Enable High
	bcf	LATB, 4, A  ;Set Enable Low.  High to Low transition occur
	return

GLCD_Select_x1:
	bcf	LATB, 4, A  ;Set Enable Low
	addlw	10111000B   ;3-bit X Address (bit 0-2) in WREG, Add bit 3-7
	movwf	LATD	    ;data line
	movlw	00100010B   ;X Select Instruction, Segmant 1-64 Selected
	movwf	LATB	    ;control line
	nop
	nop
	nop
	nop		    ;500ns from Set Enable Low
	bsf	LATB, 4, A  ;Set Enable High. Low to High transition occur
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop		    ;500ns from Set Enable High
	bcf	LATB, 4, A  ;Set Enable Low.  High to Low transition occur
	return

GLCD_Select_x2:
	bcf	LATB, 4, A  ;Set Enable Low
	addlw	10111000B   ;3-bit X Address (bit 0-2) in WREG, Add bit 3-7
	movwf	LATD	    ;data line
	movlw	00100001B   ;X Select Instruction, Segmant 1-64 Selected
	movwf	LATB	    ;control line
	nop
	nop
	nop
	nop		    ;500ns from Set Enable Low
	bsf	LATB, 4, A  ;Set Enable High. Low to High transition occur
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop		    ;500ns from Set Enable High
	bcf	LATB, 4, A  ;Set Enable Low.  High to Low transition occur
	return

GLCD_Write_Display1:
	bcf	LATB, 4, A  ;Set Enable Low
	movwf	LATD	    ;Display Data in WREG, move to data line
	movlw	00100110B   ;Write Display Instruction, Segmant 1-64 Selected
	movwf	LATB	    ;control line
	nop
	nop
	nop
	nop		    ;500ns from Set Enable Low
	bsf	LATB, 4, A  ;Set Enable High. Low to High transition occur
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop		    ;500ns from Set Enable High
	bcf	LATB, 4, A  ;Set Enable Low.  High to Low transition occur
	return

GLCD_Write_Display2:
	bcf	LATB, 4, A  ;Set Enable Low
	movwf	LATD	    ;Display Data in WREG, move to data line
	movlw	00100101B   ;Write Display Instruction, Segmant 65-128 Selected
	movwf	LATB	    ;control line
	nop
	nop
	nop
	nop		    ;500ns from Set Enable Low
	bsf	LATB, 4, A  ;Set Enable High. Low to High transition occur
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop		    ;500ns from Set Enable High
	bcf	LATB, 4, A  ;Set Enable Low.  High to Low transition occur
	return
    
GLCD_delay_ms:	; delay given in ms in W
	movwf	GLCD_cnt_ms, A
glcdlp2:
	movlw	250 ; 1 ms delay
	call	GLCD_delay_x4us	
	decfsz	GLCD_cnt_ms, A
	bra	glcdlp2
	return
    
GLCD_delay_x4us:    ; delay given in chunks of 4 microsecond in W
	movwf	GLCD_cnt_l, A	; now need to multiply by 16
	swapf   GLCD_cnt_l, F, A	; swap nibbles
	movlw	0x0f	    
	andwf	GLCD_cnt_l, W, A ; move low nibble to W
	movwf	GLCD_cnt_h, A	; then to GLCD_cnt_h
	movlw	0xf0	    
	andwf	GLCD_cnt_l, F, A ; keep high nibble in GLCD_cnt_l
	call	GLCD_delay
	return

GLCD_delay:	; delay routine	4 instruction loop == 250ns	    
	movlw 	0x00	; W=0
glcdlp1:
	decf 	GLCD_cnt_l, F, A    ; no carry when 0x00 -> 0xff
	subwfb 	GLCD_cnt_h, F, A    ; no carry when 0x00 -> 0xff
	bc 	glcdlp1	; carry, then loop again
	return	; carry reset so return
