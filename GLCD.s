#include <xc.inc>
    
global  GLCD_Setup

psect	udata_acs   ; reserve data space in access ram
; The first few variables are for the delay routines
GLCD_cnt_l:   ds 1   ; reserve 1 byte for variable GLCD_cnt_l
GLCD_cnt_h:   ds 1   ; reserve 1 byte for variable GLCD_cnt_h
GLCD_cnt_ms:  ds 1   ; reserve 1 byte for ms counter
GLCD_tmp:	    ds 1   ; reserve 1 byte for temporary use
GLCD_counter: ds 1   ; reserve 1 byte for variable GLCD_counter
; These variables are for other modules


psect	uart_code,class=CODE

GLCD_Setup:
	clrf	LATD, A
	clrf	LATB, A
	clrf	TRISD, A
	clrf	TRISB, A
	;Turn on the 2 displays
	movlw	00000000B   ;set Enable to low
	movwf	LATB, A
	movlw	00000001B
	movwf	LATB, A	    ;control ready
	movlw	00111111B
	movwf	LATD, A	    ;data ready
	nop
	nop
	nop
	nop
	bsf	LATB, 4, A  ; Enable
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	bcf	LATB, 4, A  ;set Enable to low
	movlw	00000010B
	movwf	LATB, A	    ;control Ready
	movlw	00111111B
	movwf	LATD, A	    ;data ready
	nop
	nop
	nop
	nop
	bsf	LATB, 4, A  ;Enable
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	clrf	LATB, A
	clrf	LATD, A
	;Reset both Screens
	movlw	00100001B
	movwf	LATB, A
	movlw	0x02
	call	GLCD_delay_ms
	movlw	00100010B
	movwf	LATB, A
	movwf	0x02
	call	GLCD_delay_ms
	movlw	00000000B
	movwf	LATB, A
	;Read Status
	movlw	10110000B
	movwf	TRISD, A
	movlw	00001001B
	movwf	LATB, A
	movlw	00000000B
	movwf	LATD, A
	nop
	nop
	bsf	LATB, 4, A  ;Enable
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	movf	PORTD, W, A
	nop
	nop
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
