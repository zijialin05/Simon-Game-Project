#include <xc.inc>

extrn	DAC_Setup, DAC_Int_Hi, Trial_Int_Hi, LFSR_Step, LFSR_Load_Fixed_Seed
extrn	GEN_RAND_SEQ, GLCD_Setup, OUT_1, GLCD_Read_Status

psect	code, abs
rst:	org	0x0000	; reset vector
	goto	start

int_hi:	org	0x0008	; high vector, no low vector
	goto	DAC_Int_Hi
	
start:	movlw	0x00
	call	GLCD_Setup
	call	OUT_1
	movlw	0x00
	call	DAC_Setup
	goto	$	; Sit in infinite loop

	end	rst
