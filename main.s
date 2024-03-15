#include <xc.inc>

extrn	DAC_Setup, DAC_Int_Hi, Trial_Int_Hi, LFSR_Step, LFSR_Load_Fixed_Seed
extrn	GEN_RAND_SEQ, GLCD_Setup, OUT_1, GLCD_Read_Status, OUT_2, OUT_3
extrn	CLR_1, CLR_2, CLR_3, Game_Setup, GLCD_delay_ms, LFSR_Load_Seed
extrn	INPUT_SEQ
    
psect	code, abs
rst:	org	0x0000	; reset vector
	goto	start

int_hi:	org	0x0008	; high vector, no low vector
	goto	DAC_Int_Hi
	
start:	movlw	0x00
	call	Game_Setup
	;call	OUT_1
	;call	OUT_2
	;call	OUT_3
	movlw	11111111B
	call	GLCD_delay_ms
	call	LFSR_Load_Seed
	movlw	0x09
	call	GEN_RAND_SEQ
	movlw	0x09
	call	INPUT_SEQ
	movlw	0x00
	call	DAC_Setup
	goto	$	; Sit in infinite loop

	end	rst
