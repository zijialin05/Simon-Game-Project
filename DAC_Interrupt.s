#include <xc.inc>
	
global	DAC_Setup, DAC_Int_Hi, Trial_Int_Hi, LFSR_Step, Sound_Setup
global	Sound_Int_Hi
psect	udata_acs
counter:	    ds  1
Sound_IntL:	    ds  1	;low byte for Interval
Sound_IntH:	    ds  1	;high byte for Interval
Sound_Dur:	    ds  1	;Duration
STEMP:		    ds  1	;Temp registor for sound
SOUND_TERMINATE:    ds	1

psect	udata_bank4
myArray:    ds	0x80

psect	data

myTable:
	db  0x80, 0x86, 0x8c, 0x92, 0x98, 0x9e, 0xa5, 0xaa
	db  0xb0, 0xb6, 0xbc, 0xc1, 0xc6, 0xcb, 0xd0, 0xd5
	db  0xda, 0xde, 0xe2, 0xe6, 0xea, 0xed, 0xf0, 0xf3
	db  0xf5, 0xf8, 0xfa, 0xfb, 0xfd, 0xfe, 0xfe, 0xff
	db  0xff, 0xff, 0xfe, 0xfe, 0xfd, 0xfb, 0xfa, 0xf8
	db  0xf5, 0xf3, 0xf0, 0xed, 0xea, 0xe6, 0xe2, 0xde
	db  0xda, 0xd5, 0xd0, 0xcb, 0xc6, 0xc1, 0xbc, 0xb6
	db  0xb0, 0xaa, 0xa5, 0x9e, 0x98, 0x92, 0x8c, 0x86
	db  0x80, 0x79, 0x73, 0x6d, 0x67, 0x61, 0x5a, 0x55
	db  0x4f, 0x49, 0x43, 0x3e, 0x39, 0x34, 0x2f, 0x2a
	db  0x25, 0x21, 0x1d, 0x19, 0x15, 0x12, 0x0f, 0x0c
	db  0x0a, 0x07, 0x05, 0x04, 0x02, 0x01, 0x01, 0x00
	db  0x00, 0x00, 0x01, 0x01, 0x02, 0x04, 0x05, 0x07
	db  0x0a, 0x0c, 0x0f, 0x12, 0x15, 0x19, 0x1d, 0x21
	db  0x25, 0x2a, 0x2f, 0x34, 0x39, 0x3e, 0x43, 0x49
	db  0x4f, 0x55, 0x5a, 0x61, 0x67, 0x6d, 0x73, 0x79
	
	myTable_1    EQU	128
	align	2
	
psect	dac_code, class=CODE

Trial_Int_Hi:
	btfss	TMR0IF		; check that this is timer0 interrupt
	retfie	f		; if not then return
	movlw	0xFF
	movwf	LATJ, A
	movlw	0x00
	movwf	LATJ, A
	bcf	TMR0IF		; clear interrupt flag
	movlw	0xFD
	movwf	TMR0H, A
	movlw	0xC8
	movwf	TMR0L, A
	bsf	TMR0IE		; Enable timer0 interrupt
	retfie	f

Sound_Var_Setup:
	movwf	STEMP, A
	movf	STEMP, W, A
	btfsc   STATUS, 2
	bra	E4
	movf	STEMP, W, A
	sublw   0x01
	btfsc   STATUS, 2
	bra	C3
	movf	STEMP, W, A
	sublw   0x02
	btfsc   STATUS, 2
	bra	D3
	movf	STEMP, W, A
	sublw   0x03
	btfsc   STATUS, 2
	bra	E3
	movf	STEMP, W, A
	sublw   0x04
	btfsc   STATUS, 2
	bra	F3
	movf	STEMP, W, A
	sublw   0x05
	btfsc   STATUS, 2
	bra	G3
	movf	STEMP, W, A
	sublw   0x06
	btfsc   STATUS, 2
	bra	A3
	movf	STEMP, W, A
	sublw   0x07
	btfsc   STATUS, 2
	bra	B3
	movf	STEMP, W, A
	sublw   0x08
	btfsc   STATUS, 2
	bra	C4
	movf	STEMP, W, A
	sublw   0x09
	btfsc   STATUS, 2
	bra	D4
	movf	STEMP, W, A
	sublw   0x0C
	btfsc   STATUS, 2
	bra	E4
	movf	STEMP, W, A
	sublw   0x0D
	btfsc   STATUS, 2
	bra	F4
	movf	STEMP, W, A
	sublw   0x0E
	btfsc   STATUS, 2
	bra	G4
	movf	STEMP, W, A
	sublw   0x0F
	btfsc   STATUS, 2
	bra	A4
C3:	movlw	0x50
	movwf	Sound_IntL, A
	movlw	0xFC
	movwf	Sound_IntH, A
	movlw	0x41
	movwf	Sound_Dur, A
	return
D3:	movlw	0xB9
	movwf	Sound_IntL, A
	movlw	0xFC
	movwf	Sound_IntH, A
	movlw	0x49
	movwf	Sound_Dur, A
	return
E3:	movlw	0x16
	movwf	Sound_IntL, A
	movlw	0xFD
	movwf	Sound_IntH, A
	movlw	0x52
	movwf	Sound_Dur, A
	return
F3:	movlw	0x40
	movwf	Sound_IntL, A
	movlw	0xFD
	movwf	Sound_IntH, A
	movlw	0x57
	movwf	Sound_Dur, A
	return
G3:	movlw	0x8E
	movwf	Sound_IntL, A
	movlw	0xFD
	movwf	Sound_IntH, A
	movlw	0x62
	movwf	Sound_Dur, A
	return
A3:	movlw	0xD4
	movwf	Sound_IntL, A
	movlw	0xFD
	movwf	Sound_IntH, A
	movlw	0x6E
	movwf	Sound_Dur, A
	return
B3:	movlw	0x12
	movwf	Sound_IntL, A
	movlw	0xFE
	movwf	Sound_IntH, A
	movlw	0x7B
	movwf	Sound_Dur, A
	return
C4:	movlw	0x2E
	movwf	Sound_IntL, A
	movlw	0xFE
	movwf	Sound_IntH, A
	movlw	0x83
	movwf	Sound_Dur, A
	return
D4:	movlw	0x62
	movwf	Sound_IntL, A
	movlw	0xFE
	movwf	Sound_IntH, A
	movlw	0x93
	movwf	Sound_Dur, A
	return
E4:	movlw	0x91
	movwf	Sound_IntL, A
	movlw	0xFE
	movwf	Sound_IntH, A
	movlw	0xA5
	movwf	Sound_Dur, A
	return
F4:	movlw	0xA6
	movwf	Sound_IntL, A
	movlw	0xFE
	movwf	Sound_IntH, A
	movlw	0xAF
	movwf	Sound_Dur, A
	return
G4:	movlw	0xCD
	movwf	Sound_IntL, A
	movlw	0xFE
	movwf	Sound_IntH, A
	movlw	0xC4
	movwf	Sound_Dur, A
	return
A4:	movlw	0xF0
	movwf	Sound_IntL, A
	movlw	0xFE
	movwf	Sound_IntH, A
	movlw	0xDC
	movwf	Sound_Dur, A
	return

Sound_Int_Hi:
	btfss	TMR0IF		; check that this is timer0 interrupt
	retfie	f		; if not then return
	movf	Sound_IntH, W, A
	movwf	TMR0H, A
	movf	Sound_IntL, W, A
	movwf	TMR0L, A
	movlw	0x00
	movwf	LATH
	tblrd*+
	movff	TABLAT, LATJ
	movlw	0xFF
	movwf	LATH
	decf	counter, A
	movf	counter, W, A
	btfsc	STATUS, 2
	call	Sound_RST
	bcf	TMR0IF		; clear interrupt flag
	bsf	TMR0IE		; Enable timer0 interrupt
	btfsc	SOUND_TERMINATE, 0, A
	call	Terminate
	retfie	f		; fast return from interrupt
Terminate:
	movlw   00001000B
	movwf   T0CON, A
	bcf	TMR0IE
	return

Sound_RST:
	dcfsnz	Sound_Dur, A
	setf	SOUND_TERMINATE, A
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

Sound_Setup:
	call	Sound_Var_Setup
	clrf	TRISJ, A	; Set PORTD as all outputs
	clrf	TRISH, A
	clrf	LATJ, A		; Clear PORTD outputs
	movlw	0xFF
	movwf	LATH, A
	clrf	SOUND_TERMINATE, A
	lfsr	0, myArray
	movlw	low highword(myTable)
	movwf	TBLPTRU, A
	movlw	high(myTable)
	movwf	TBLPTRH, A
	movlw	low(myTable)
	movwf	TBLPTRL, A
	movlw	myTable_1
	movwf	counter, A
	movlw	10001000B	; Set timer0 to 16-bit, Fosc/4/256
	movwf	T0CON, A	; = 62.5KHz clock rate, approx 1sec rollover
	bsf	TMR0IE		; Enable timer0 interrupt
	bsf	GIE		; Enable all interrupts
	bcf	CFGS
	bsf	EEPGD
	return

	
DAC_Int_Hi:	
	btfss	TMR0IF		; check that this is timer0 interrupt
	retfie	f		; if not then return
	movf	Sound_IntH, W, A
	movwf	TMR0H, A
	movf	Sound_IntL, W, A
	movwf	TMR0L, A
	movlw	0x00
	movwf	LATH
	
	tblrd*+
	movff	TABLAT, LATJ
	movlw	0xFF
	movwf	LATH
	decf	counter, A
	movf	counter, W, A
	btfsc	STATUS, 2
	call	RST
	bcf	TMR0IF		; clear interrupt flag
	bsf	TMR0IE		; Enable timer0 interrupt
	btfsc	SOUND_TERMINATE, 0, A
	call	DAC_Terminate
	retfie	f		; fast return from interrupt
DAC_Terminate:
	movlw   00000000B
	movwf   T0CON, A
	return

DAC_Setup:
	movlw	0x50
	movwf	Sound_IntL, A
	movlw	0xFC
	movwf	Sound_IntH, A
	clrf	SOUND_TERMINATE, A
	movlw	0xFF
	movwf	Sound_Dur, A
	clrf	TRISJ, A	; Set PORTD as all outputs
	clrf	TRISH, A
	clrf	LATJ, A		; Clear PORTD outputs
	movlw	0xFF
	movwf	LATH, A
	lfsr	0, myArray
	movlw	low highword(myTable)
	movwf	TBLPTRU, A
	movlw	high(myTable)
	movwf	TBLPTRH, A
	movlw	low(myTable)
	movwf	TBLPTRL, A
	movlw	myTable_1
	movwf	counter, A
	movlw	10001000B	; Set timer0 to 16-bit, Fosc/4/256
	movwf	T0CON, A	; = 62.5KHz clock rate, approx 1sec rollover
	bsf	TMR0IE		; Enable timer0 interrupt
	bsf	GIE		; Enable all interrupts
	bcf	CFGS
	bsf	EEPGD
	

	return
	
RST:
	dcfsnz	Sound_Dur, A
	setf	SOUND_TERMINATE, A
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

