#include <xc.inc>
    
extrn	LFSR_Load_Fixed_Seed, LFSR_RANDINT, LFSR_Setup
global	TEST_LFSR

psect	udata_acs   ; reserve data space in access ram
; The first few variables are for the delay routines
GLCD_cnt_l:	ds  1   ; reserve 1 byte for variable GLCD_cnt_l


psect	uart_code,class=CODE

TEST_LFSR:
    call    LFSR_Setup
    call    LFSR_Load_Fixed_Seed
    call    LFSR_RANDINT
    nop
    call    LFSR_RANDINT
    nop
    call    LFSR_RANDINT
    nop
    call    LFSR_RANDINT
    nop
    return