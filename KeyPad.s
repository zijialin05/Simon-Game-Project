#include <xc.inc>
    
global  KP_Read, KP_Setup, KP_Change, KPPrev, KP_ASCII_TO_VAL

psect	udata_acs   ; reserve data space in access ram
KP_cnt_l:   ds 1   ; reserve 1 byte for variable KP_cnt_l
KP_cnt_h:   ds 1   ; reserve 1 byte for variable KP_cnt_h
KP_cnt_ms:  ds 1   ; reserve 1 byte for ms counter
KP_tmp:	    ds 1   ; reserve 1 byte for temporary use
KP_counter: ds 1   ; reserve 1 byte for variable KP_counter
KP_row:	    ds 1
KPCAR:	    ds 1
KPPrev:	    ds 1
KPCurr:	    ds 1
KPASCII:    ds 1

psect	uart_code,class=CODE

KP_Setup:
    movlw   0x00
    movwf   KPPrev, A
    movlb   0x0f
    bsf	    REPU
    movlb   0x00
    clrf    LATE
    movlw   00001111B
    movwf   TRISE
    movlw   0x05
    call    KP_delay_x4us
    return
    
KP_Read:
    movlw   00001111B
    movwf   TRISE, A
    movlw   0x05
    call    KP_delay_x4us
    movf    PORTE, W
    andlw   00001111B
    movwf   KP_row, A
    movlw   11110000B
    movwf   TRISE
    movlw   0x01
    call    KP_delay_x4us
    movf    PORTE, W
    andlw   11110000B
    iorwf   KP_row, W
    movwf   KPCAR, A
    sublw   11111111B
    btfsc   STATUS, 2
    retlw   0x20
    movf    KPCAR, W
    sublw   11100111B
    btfsc   STATUS, 2
    retlw   'F'
    movf    KPCAR, W
    sublw   11010111B
    btfsc   STATUS, 2
    retlw   'E'
    movf    KPCAR, W
    sublw   10110111B
    btfsc   STATUS, 2
    retlw   'D'
    movf    KPCAR, W
    sublw   01110111B
    btfsc   STATUS, 2
    retlw   'C'
    movf    KPCAR, W
    sublw   11101011B
    btfsc   STATUS, 2
    retlw   '3'
    movf    KPCAR, W
    sublw   11011011B
    btfsc   STATUS, 2
    retlw   '6'
    movf    KPCAR, W
    sublw   10111011B
    btfsc   STATUS, 2
    retlw   '9'
    movf    KPCAR, W
    sublw   01111011B
    btfsc   STATUS, 2
    retlw   'B'
    movf    KPCAR, W
    sublw   11101101B
    btfsc   STATUS, 2
    retlw   '2'
    movf    KPCAR, W
    sublw   11011101B
    btfsc   STATUS, 2
    retlw   '5'
    movf    KPCAR, W
    sublw   10111101B
    btfsc   STATUS, 2
    retlw   '8'
    movf    KPCAR, W
    sublw   01111101B
    btfsc   STATUS, 2
    retlw   '0'
    movf    KPCAR, W
    sublw   11101110B
    btfsc   STATUS, 2
    retlw   '1'
    movf    KPCAR, W
    sublw   11011110B
    btfsc   STATUS, 2
    retlw   '4'
    movf    KPCAR, W
    sublw   10111110B
    btfsc   STATUS, 2
    retlw   '7'
    movf    KPCAR, W
    sublw   01111110B
    btfsc   STATUS, 2
    retlw   'A'
    retlw   0x00
    return

KP_ASCII_TO_VAL:
    movwf   KPASCII, A
    movf    KPASCII, W, A
    sublw   '0'
    btfsc   STATUS, 2
    retlw   0x00
    movf    KPASCII, W, A
    sublw   '1'
    btfsc   STATUS, 2
    retlw   0x01
    movf    KPASCII, W, A
    sublw   '2'
    btfsc   STATUS, 2
    retlw   0x02
    movf    KPASCII, W, A
    sublw   '3'
    btfsc   STATUS, 2
    retlw   0x03
    movf    KPASCII, W, A
    sublw   '4'
    btfsc   STATUS, 2
    retlw   0x04
    movf    KPASCII, W, A
    sublw   '5'
    btfsc   STATUS, 2
    retlw   0x05
    movf    KPASCII, W, A
    sublw   '6'
    btfsc   STATUS, 2
    retlw   0x06
    movf    KPASCII, W, A
    sublw   '7'
    btfsc   STATUS, 2
    retlw   0x07
    movf    KPASCII, W, A
    sublw   '8'
    btfsc   STATUS, 2
    retlw   0x08
    movf    KPASCII, W, A
    sublw   '9'
    btfsc   STATUS, 2
    retlw   0x09
    retlw   0x3f
    return
    

KP_Change:
    call    KP_Read
    cpfseq  KPPrev, A
    bra	    KP_SPAC
    retlw   0x00
KP_SPAC:    ;save previous and current values
    movwf   KPPrev, A
    return

KPOWC:	;the Keypad function that Output When Change in button press detected
    call    KP_Read
    movwf   KPCurr, A
    cpfseq  KPPrev, A
    bra	    KP_SPAC2
    bra	    KPOWC
KP_SPAC2:    ;save previous and current values
    movwf   KPPrev, A
    movf    KPCurr, W, A
    return
    
KP_delay_ms:		    ; delay given in ms in W
	movwf	KP_cnt_ms, A
kplp2:	movlw	250	    ; 1 ms delay
	call	KP_delay_x4us	
	decfsz	KP_cnt_ms, A
	bra	kplp2
	return
    
KP_delay_x4us:		    ; delay given in chunks of 4 microsecond in W
	movwf	KP_cnt_l, A	; now need to multiply by 16
	swapf   KP_cnt_l, F, A	; swap nibbles
	movlw	0x0f	    
	andwf	KP_cnt_l, W, A ; move low nibble to W
	movwf	KP_cnt_h, A	; then to KP_cnt_h
	movlw	0xf0	    
	andwf	KP_cnt_l, F, A ; keep high nibble in KP_cnt_l
	call	KP_delay
	return

KP_delay:			; delay routine	4 instruction loop == 250ns	    
	movlw 	0x00		; W=0
kplp1:	decf 	KP_cnt_l, F, A	; no carry when 0x00 -> 0xff
	subwfb 	KP_cnt_h, F, A	; no carry when 0x00 -> 0xff
	bc 	kplp1		; carry, then loop again
	return			; carry reset so return
