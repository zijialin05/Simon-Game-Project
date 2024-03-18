#include <xc.inc>

extrn	DAC_Setup, DAC_Int_Hi, Trial_Int_Hi, LFSR_Step, LFSR_Load_Fixed_Seed
extrn	GEN_RAND_SEQ, GLCD_Setup, OUT_1, GLCD_Read_Status, OUT_2, OUT_3
extrn	CLR_1, CLR_2, CLR_3, Game_Setup, GLCD_delay_ms, LFSR_Load_Seed
extrn	INPUT_SEQ, Sound_Int_Hi, OUTPUT_GEN_SEQ, Output_Bitmap, Clear_Bitmap
extrn	OUT_0, OUT_1, OUT_2, OUT_3, OUT_4, OUT_5, OUT_6, OUT_7, OUT_8, OUT_9
extrn	CLR_0, CLR_1, CLR_2, CLR_3, CLR_4, CLR_5, CLR_6, CLR_7, CLR_8, CLR_9
extrn	GAME_START, OUT_SCORE
    
psect	code, abs
rst:	org	0x0000	; reset vector
	goto	start

int_hi:	org	0x0008	; high vector, no low vector
	goto	Sound_Int_Hi
	
start:	movlw	0x00
	call	Game_Setup
	movlw	0x09
	call	INPUT_SEQ
	;call	GAME_START
	movlw	0x00
	goto	$	; Sit in infinite loop

	end	rst
