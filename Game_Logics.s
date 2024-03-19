#include <xc.inc>
    
global  LFSR_Step, LFSR_H, LFSR_L, TEMP, OUT, RESULT, LFSR_Load_Fixed_Seed
global	GEN_RAND_SEQ, FSR0L, FSR0H, COUNTER, INPUT_SEQ, GENSEQ, INPTSEQ
global	Game_Setup, LFSR_Load_Seed, OUTPUT_GEN_SEQ, GAME_START, CHAR_TO_CLEAR
global	SCORE_1, SEQ_LEN, LFSR_Setup, LFSR_RANDINT

extrn	KP_Change, KPPrev, KPOWC, KP_ASCII_TO_VAL, KP_Setup, GLCD_Setup
extrn	KP_DOWC, GLCD_delay_ms, Sound_Setup, Output_Bitmap, Clear_Bitmap
extrn	OUT_SCORE, Clear_Score, home_display, failure_display, success_display
extrn	GLCD_ZERO_INIT, options_display

psect	udata_bank5
GENSEQ:		ds  0x80
INPTSEQ:	ds  0x80

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
SEQ_LEN:    ds	1
HOME_FLAG:	ds  1
RESTART_FLAG:	ds  1
CLEAR_FLAG:	ds  1
DELETE_FLAG:	ds  1
CHAR_TO_CLEAR:	ds  1

psect	uart_code,class=CODE

Game_Setup:
    call    KP_Setup
    call    GLCD_Setup
    call    LFSR_Setup
    return

GAME_START:
    call    Game_Setup
    call    home_display
    movlw   0xFF
    call    GLCD_delay_ms
    call    KP_DOWC
    call    LFSR_Load_Seed
    call    Clear_Score
    call    GLCD_ZERO_INIT
GAME_SESSION:
    clrf    HOME_FLAG, A
    clrf    RESTART_FLAG, A
    clrf    CLEAR_FLAG, A
    clrf    DELETE_FLAG, A
    movlw   0xFF
    call    GLCD_delay_ms
    movlw   0xFF
    call    GLCD_delay_ms
    clrf    SCORE_1, A
    movf    SCORE_1, W, A
    call    OUT_SCORE
    call    options_display
    movlw   0x03
    movwf   SEQ_LEN, A
GAME_ROUND:
    clrf    RESTART_FLAG, A
    movf    SEQ_LEN, W, A
    call    GEN_RAND_SEQ
    movf    SEQ_LEN, W, A
    call    OUTPUT_GEN_SEQ
    movf    SEQ_LEN, W, A
    call    INPUT_SEQ
    movlw   0xFF
    call    GLCD_delay_ms
    movlw   0xFF
    call    GLCD_delay_ms
    movf    CHAR_TO_CLEAR, W, A
    call    Clear_Bitmap
    btfsc   HOME_FLAG, 0, A
    bra	    GAME_START
    btfsc   RESTART_FLAG, 0, A
    bra	    GAME_ROUND
    movf    SEQ_LEN, W, A
    call    SEQ_COMPARE
    btfss   WREG, 0
    bra	    FAILED_ROUND
    call    GLCD_ZERO_INIT
    call    success_display
    movlw   0xFF
    call    GLCD_delay_ms
    movlw   0xFF
    call    GLCD_delay_ms
    movlw   0xFF
    call    GLCD_delay_ms
    movlw   0xFF
    call    GLCD_delay_ms
    call    GLCD_ZERO_INIT
    incf    SCORE_1, F, A
    movf    SCORE_1, W, A
    call    OUT_SCORE
    call    options_display
    movlw   0x09
    cpfsgt  SEQ_LEN, A
    incf    SEQ_LEN, F, A
    bra	    GAME_ROUND
FAILED_ROUND:
    call    GLCD_ZERO_INIT
    call    failure_display
    movlw   0xFF
    call    GLCD_delay_ms
    movlw   0xFF
    call    GLCD_delay_ms
    movlw   0xFF
    call    GLCD_delay_ms
    movlw   0xFF
    call    GLCD_delay_ms
    call    KP_DOWC
    call    GLCD_ZERO_INIT
    bra	    GAME_START
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

SEQ_COMPARE:
    movwf   COUNTER, A
    clrf    TEMP, A
    LFSR    1, GENSEQ
    LFSR    2, INPTSEQ
Individual_Compare:
    movf    INDF1, W, A
    movwf   TEMP, A
    movf    INDF2, W, A
    cpfseq  TEMP, A
    bra	    No_Match
    INFSNZ  FSR1L, F, A
    INCF    FSR1H, F, A
    INFSNZ  FSR2L, F, A
    INCF    FSR2H, F, A
    decfsz  COUNTER, A
    bra	    Individual_Compare
    retlw   0xFF
No_Match:
    retlw   0x00

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
    clrf    CLEAR_FLAG, A
    movlw   0x3f
    movwf   CHAR_TO_CLEAR, A
    movf    SEQ_LEN, W, A
    movwf   COUNTER, A
    clrf    KPPrev, A
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
    movlw   0x0A
    cpfslt  INPUTCHAR, A
    call    SPECIAL_ACTIONS
    btfsc   HOME_FLAG, 0, A
    return
    btfsc   RESTART_FLAG, 0, A
    return
    call    CLEAR_HANDLER
    btfsc   CLEAR_FLAG, 0, A
    bra	    INPUT_SEQ
    movf    CHAR_TO_CLEAR, W, A
    call    Clear_Bitmap
    movf    INPUTCHAR, W, A
    call    Output_Bitmap
    movf    INPUTCHAR, W, A
    movwf   CHAR_TO_CLEAR, A
    movf    INPUTCHAR, W, A
    movwf   INDF1
    INFSNZ  FSR1L, F, A
    INCF    FSR1H, F, A
    call    DELETE_HANDLER
    DECFSZ  COUNTER, F, A
    bra	    ONE_INPUT
    return

DEC_FSR1:
    DECF    FSR1L, F, A
    movf    FSR1L, W, A
    sublw   0xFF
    btfsc   STATUS, 2
    DECF    FSR1H, F, A
    return

CLEAR_HANDLER:
    btfss   CLEAR_FLAG, 0, A
    return
    movf    CHAR_TO_CLEAR, W, A
    call    Clear_Bitmap
    return

DELETE_HANDLER:
    btfss   DELETE_FLAG, 0, A
    return
    call    DEC_FSR1
    call    DEC_FSR1
    incf    COUNTER, F, A
    incf    COUNTER, F, A
    clrf    DELETE_FLAG, A
    return

SPECIAL_ACTIONS:
    movf    INPUTCHAR, W, A
    sublw   0x0C
    btfsc   STATUS, 2
    setf    HOME_FLAG, A
    movf    INPUTCHAR, W, A
    sublw   0x0D
    btfsc   STATUS, 2
    setf    RESTART_FLAG, A
    movf    INPUTCHAR, W, A
    sublw   0x0E
    btfsc   STATUS, 2
    setf    CLEAR_FLAG, A
    movf    INPUTCHAR, W, A
    sublw   0x0F
    btfsc   STATUS, 2
    setf    DELETE_FLAG, A
    return

    