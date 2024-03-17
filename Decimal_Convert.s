#include <xc.inc>

;Note: Not all global variables will be directly used
;Some of them are only used for debugging purposes
;Because global variables can be conveniently traced in MPLAB X IDE v6.10
;So that we can easily validate our algorithms

global  ARG1L, ARG1H, ARG2L, ARG2H, Mul_16x16, Mul_24x8, RES0, RES1, RES2, RES3
global	OUT_SCORE
extrn	Output_Score_Digit, GLCD_Select_y2

psect	udata_acs   ; reserve data space in access ram
;The following four registers are reserved for multiplication inputs
ARG1L:	ds  1	    ;Low byte of ARG1
ARG1H:	ds  1	    ;High byte of ARG1
ARG2L:	ds  1	    ;Low byte of ARG2
ARG2H:	ds  1	    ;High byte of ARG2
;The following four registers are reserved for multiplication outputs
RES0:	ds  1
RES1:	ds  1
RES2:	ds  1
RES3:	ds  1

    
psect	mul_code, class=CODE
 
Mul_16x16:
    ;This is the code given in the PIC18F87K22-Family-Data-Sheet-30009960E.pdf
    ;for 16 bit multiplication
    ;We copied the code here and made some minor modifications
    ;specifically we specified that the variables are in access bank
    MOVF    ARG1L, W, A
    MULWF   ARG2L, A ; ARG1L * ARG2L to PRODH:PRODL
    movf    PRODH, W, A
    MOVWF   RES1, A ;
    movf    PRODL, W, A
    MOVWF   RES0, A ;
    ;
    MOVF    ARG1H, W, A
    MULWF   ARG2H, A ; ARG1H * ARG2H to PRODH:PRODL
    movf    PRODH, W, A
    MOVWF   RES3, A ;
    movf    PRODL, W, A
    MOVWF   RES2, A ;
    ;
    MOVF    ARG1L, W, A
    MULWF   ARG2H, A ; ARG1L * ARG2H to PRODH:PRODL
    MOVF    PRODL, W, A ;
    ADDWF   RES1, A ; Add cross
    MOVF    PRODH, W, A ; products
    ADDWFC  RES2, A ;
    CLRF    WREG ;
    ADDWFC  RES3, A ;
    ;
    MOVF    ARG1H, W, A ;
    MULWF   ARG2L, A ; ARG1H * ARG2L to PRODH:PRODL
    MOVF    PRODL, W, A ;
    ADDWF   RES1, A ; Add cross
    MOVF    PRODH, W, A ; products
    ADDWFC  RES2, A ;
    CLRF    WREG ;
    ADDWFC  RES3, A
    return

Mul_24x8:
    ;This module is implemented for 24 bits by 8 bits multiplication
    ;It is based on the same principles as the 16 bit multiplication module
    ;First of all, clear the result registers
    clrf    RES3
    clrf    RES2
    clrf    RES1
    clrf    RES0
    MOVF    ARG1L, W, A
    MULWF   ARG1H, A ; ARG1L * ARG1H to PRODH:PRODL
    movf    PRODH, W, A
    MOVWF   RES1, A ;
    movf    PRODL, W, A
    MOVWF   RES0, A ;
    ;
    MOVF    ARG1L, W, A ;
    MULWF   ARG2L, A ; ARG1L * ARG2L to PRODH:PRODL
    MOVF    PRODL, W, A ;
    ADDWF   RES1, A ; Add cross
    MOVF    PRODH, W, A ; products
    ADDWFC  RES2, A ;
    CLRF    WREG ;
    ADDWFC  RES3, A
    ;
    MOVF    ARG1L, W, A ;
    MULWF   ARG2H, A ; ARG1L * ARG2H to PRODH:PRODL
    MOVF    PRODL, W, A ;
    ADDWF   RES2, A ; Add cross
    MOVF    PRODH, W, A ; products
    ADDWFC  RES3, A ;
    CLRF    WREG ;
    return

OUT_SCORE:
    ;This module takes a byte as the input and convert the content to decimal
    ;This module automatically displays the output
    ;Data converted to 4 bytes, each representing one digit of the decimal
    ;Since the score ranges from 0 to 255
    ;No need to output the first digit as it is always zero
    ;First, load the number to be multiplied by 0x418A
    movwf   ARG2L, A	;Load score to the low byte
    movlw   0x00
    movwf   ARG2H, A	;Load high byte with zeros
    movlw   0x41
    movwf   ARG1H, A	;Load 0x418A
    movlw   0x8A
    movwf   ARG1L, A	;Load 0x418A
    call    Mul_16x16	;Multiply
    ;Since the score ranges from 0 to 255
    ;No need to output the first digit as it is always zero
    ;Discard the first digit, multiply the remaining result by 10
    ;Load values for the Multiplication Functions
    movf    RES2, W, A
    movwf   ARG2H, A
    movf    RES1, W, A
    movwf   ARG2L, A
    movf    RES0, W, A
    movwf   ARG1H, A
    movlw   0x0A
    movwf   ARG1L, A
    call    Mul_24x8	;Multiply by 10
    movlw   0x24	;Choose Chip 2 Y Address 36 for the second digit
    call    GLCD_Select_y2
    movf    RES3, W, A
    andlw   0x0F
    call    Output_Score_Digit	;Output the digit to the specified position
    ;Discard the first digit, multiply the remaining result by 10
    ;Load values for the Multiplication Functions
    movf    RES2, W, A
    movwf   ARG2H, A
    movf    RES1, W, A
    movwf   ARG2L, A
    movf    RES0, W, A
    movwf   ARG1H, A
    movlw   0x0A
    movwf   ARG1L, A
    call    Mul_24x8	;Multiply by 10
    movlw   0x2E	;Choose Chip 2 Y Address 46 for the third digit
    call    GLCD_Select_y2
    movf    RES3, W, A	
    andlw   0x0F
    call    Output_Score_Digit	;Output the digit to the specified position
    ;Discard the first digit, multiply the remaining result by 10
    ;Load values for the Multiplication Functions
    movf    RES2, W, A
    movwf   ARG2H, A
    movf    RES1, W, A
    movwf   ARG2L, A
    movf    RES0, W, A
    movwf   ARG1H, A
    movlw   0x0A
    movwf   ARG1L, A
    call    Mul_24x8	;Multiply by 10
    movlw   0x38	;Choose Chip 2 Y Address 56 for the last digit
    call    GLCD_Select_y2
    movf    RES3, W, A
    andlw   0x0F
    call    Output_Score_Digit	;Output the digit to the specified position
    return

end