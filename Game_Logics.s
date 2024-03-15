#include <xc.inc>
    
global  LFSR_Step, LFSR_H, LFSR_L, TEMP, OUT, RESULT, LFSR_Load_Fixed_Seed
global	GEN_RAND_SEQ, FSR0L, FSR0H, COUNTER, INPUT_SEQ, GENSEQ, INPTSEQ
global	Game_Setup, LFSR_Load_Seed, OUTPUT_GEN_SEQ

extrn	KP_Change, KPPrev, KPOWC, KP_ASCII_TO_VAL, KP_Setup, GLCD_Setup
extrn	KP_DOWC, GLCD_delay_ms, Sound_Setup, Output_Bitmap, Clear_Bitmap

psect	udata_bank5
GENSEQ:	    ds	0x80
INPTSEQ:    ds	0x80

psect	udata_acs   ; reserve data space in access ram
LFSR_H:	    ds	1
LFSR_L:	    ds	1
TEMP:	    ds	1
OUT:	    ds	1
RESULT:	    ds	1
COUNTER:    ds	1
INPUTCHAR:  ds	1
GENCHAR:    ds	1
SCORE_1:    ds	1
OUTPrev:    ds	1
OUTCurr:    ds	1

psect	uart_code,class=CODE

Game_Setup:
    call    KP_Setup
    call    GLCD_Setup
    call    LFSR_Setup
    return

GAME_START:
    call    Game_Setup
    movlw   0xFF
    call    GLCD_delay_ms
    call    KP_DOWC
GAME_SESSION:
    call    LFSR_Load_Seed
    clrf    SCORE_1, A
GAME_ROUND:
    call    GEN_RAND_SEQ
    call    INPUT_SEQ		;Not Finished Yet
    return

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
    
LFSR_Load_Fixed_Seed:
    movlw   11110111B
    movwf   LFSR_L, A
    movlw   01011110B
    movwf   LFSR_H, A
    return

LFSR_Step:
    ;Step 1: Calculate feedback from tap positions
    ; Most significant bit: bit 15. Least significant bit: bit 0
    ;Taps: Bit 0, 1, 3, 12 
    ; Check bit 0, XOR with TEMP
    movlw   0x00
    clrf    TEMP, A
    ; Check bit 0 (MSB of LFSR_HI), XOR with TEMP
    btfsc   LFSR_L, 0, A    ; Test bit 0, skip if clear (0)
    xorlw   0x01	    ; XOR with 1 (bit set), result in WREG
    movwf   TEMP, A	    ; Store result in TEMP
    ; Check bit 1, XOR with TEMP
    movf    TEMP, W, A      ; Move TEMP to WREG for XOR operation
    btfsc   LFSR_L, 1, A    ; Test bit 1, skip if clear
    xorlw   0x01	    ; XOR with 1, result in WREG
    movwf   TEMP, A	    ; Update TEMP with new result
    ; Check bit 3, XOR with TEMP
    movf    TEMP, W, A      ; Move TEMP to WREG for XOR operation
    btfsc   LFSR_L, 3, A    ; Test bit 3, skip if clear
    xorlw   0x01	    ; XOR with 1, result in WREG
    movwf   TEMP, A	    ; Update TEMP with new result
    ; Check bit 12, XOR with TEMP
    movf    TEMP, W, A      ; Move TEMP to WREG for XOR operation
    btfsc   LFSR_H, 4, A    ; Test bit 12, skip if clear
    xorlw   0x01	    ; XOR with 1, result in WREG
    movwf   TEMP, A	    ; Update TEMP with new result
    movf    LFSR_L, W, A
    andlw   0x01
    movwf   OUT, A
    rrncf   LFSR_L, F, A
    rrcf    LFSR_H, F, A
    btfsc   STATUS, 0, A
    bsf	    LFSR_L, 7, A
    btfss   STATUS, 0, A
    bcf	    LFSR_L, 7, A
    btfsc   TEMP, 0, A
    bsf	    LFSR_H, 7, A
    btfss   TEMP, 0, A
    bcf	    LFSR_H, 7, A
    return

LFSR_RANDINT:
    clrf    RESULT, A
    call    LFSR_Step
    btfsc   OUT, 0, A
    bsf	    RESULT, 0, A
    call    LFSR_Step
    btfsc   OUT, 0, A
    bsf	    RESULT, 1, A
    call    LFSR_Step
    btfsc   OUT, 0, A
    bsf	    RESULT, 2, A
    call    LFSR_Step
    btfsc   OUT, 0, A
    bsf	    RESULT, 3, A
    movlw   0x0A
    cpfslt  RESULT, A
    bra	    LFSR_RANDINT
    movf    RESULT, W, A
    return

OUTPUT_GEN_SEQ:
    movwf   COUNTER, A
    LFSR    1, GENSEQ
Out_Char:
    movf    INDF1, W, A
    movwf   OUTCurr, A
    call    Sound_Setup
    movf    OUTCurr, W, A
    call    Output_Bitmap
    movlw   0xFF
    call    GLCD_delay_ms
    movlw   0xFF
    call    GLCD_delay_ms
    movf    INDF1, W, A
    call    Clear_Bitmap
    INFSNZ  FSR1L, F, A
    INCF    FSR1H, F, A
    decfsz  COUNTER, A
    bra	    Out_Char
    return
    

GEN_RAND_SEQ:
    movwf   COUNTER, A
    LFSR    0, GENSEQ
Gen_seq:
    call    LFSR_RANDINT
    movwf   INDF0
    INFSNZ  FSR0L, F, A
    INCF    FSR0H, F, A
    DECFSZ  COUNTER, F, A
    bra	    Gen_seq
    return

INPUT_SEQ:
    movwf   COUNTER, A
    movlw   0x00
    movwf   KPPrev, A
    LFSR    1, INPTSEQ
ONE_INPUT:
    call    KP_DOWC
    btfsc   STATUS, 2
    bra	    ONE_INPUT
    call    KP_ASCII_TO_VAL
    movwf   INPUTCHAR, A
    sublw   0x3f
    btfsc   STATUS, 2
    bra	    ONE_INPUT
    movf    INPUTCHAR, W, A
    call    Sound_Setup
    movf    INPUTCHAR, W, A
    movwf   INDF1
    INFSNZ  FSR1L, F, A
    INCF    FSR1H, F, A
    DECFSZ  COUNTER, F, A
    bra	    ONE_INPUT
    return


    