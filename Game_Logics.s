#include <xc.inc>
    
global  KP_Read

psect	udata_acs   ; reserve data space in access ram
LFSR_H:	    ds	1
LFSR_L:	    ds	1
TEMP:	    ds	1


psect	uart_code,class=CODE

LFSR_Setup:
    clrf    LFSR_H, A
    clrf    LFSR_L, A
    movlw   10001000B	; Set timer0 to 16-bit, Fosc/4/256 = 62.5KHz
    movwf   T0CON, A	; This is to generate the seed for LFSR
    bcf	    TMR0IE	; Disable timer0 interrupt
    return

LFSR_Load_Seed:
    movf    TMR0L, W, A
    movwf   LFSR_L, A
    movf    TMR0H, W, A
    movwf   LFSR_H, A
    movlw   00000000B
    movwf   T0CON, A
    return

LFSR_Step:
    