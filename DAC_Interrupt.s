#include <xc.inc>
	
global	DAC_Setup, DAC_Int_Hi
psect	udata_acs
counter:    ds	1

psect	udata_bank4
myArray:    ds	0x80

psect	data

myTable:
	db  0x00, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70, 0x80, 0x90, 0xA0
	db  0xB0, 0xC0, 0xD0, 0xE0, 0xF0, 0xE0, 0xD0, 0xC0, 0xB0, 0xA0, 0x90
	db  0x80, 0x70, 0x60, 0x50, 0x40, 0x30, 0x20, 0x10
	
	myTable_1    EQU	30
	align	2
	
psect	dac_code, class=CODE
	
DAC_Int_Hi:	
	btfss	TMR0IF		; check that this is timer0 interrupt
	retfie	f		; if not then return
	;incf	LATJ, F, A	; increment PORTD
	movlw	0x00
	movwf	LATH
	tblrd*+
	movff	TABLAT, PORTJ
	movlw	0xF0
	movwf	LATH
	decfsz	counter, A
	movf	counter, W, A
	btfsc	STATUS, 2
	call	RST
	bcf	TMR0IF		; clear interrupt flag
	movlw	0xFF
	movwf	TMR0L, A
	movlw	0xF0
	movwf	TMR0H, A
	bsf	TMR0IE		; Enable timer0 interrupt
	retfie	f		; fast return from interrupt

DAC_Setup:
	clrf	TRISJ, A	; Set PORTD as all outputs
	clrf	TRISH, A
	clrf	LATJ, A		; Clear PORTD outputs
	movlw	0xFF
	movwf	LATH, A
	movlw	10000111B	; Set timer0 to 16-bit, Fosc/4/256
	movwf	T0CON, A	; = 62.5KHz clock rate, approx 1sec rollover
	bsf	TMR0IE		; Enable timer0 interrupt
	bsf	GIE		; Enable all interrupts
	bcf	CFGS
	bsf	EEPGD
	lfsr	0, myArray
	movlw	low highword(myTable)
	movwf	TBLPTRU, A
	movlw	high(myTable)
	movwf	TBLPTRH, A
	movlw	low(myTable)
	movwf	TBLPTRL, A
	movlw	myTable_1
	movwf	counter, A
	
	return
	
RST:
	lfsr	0, myArray
	movlw	low highword(myTable)
	movwf	TBLPTRU, A
	movlw	high(myTable)
	movwf	TBLPTRH, A
	movlw	low(myTable)
	movwf	TBLPTRL, A
	movlw	myTable_1
	movwf	counter, A
	return
	end

