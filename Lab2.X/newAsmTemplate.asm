LIST p=18f4520		
#include<p18f4520.inc>
    
ORG     0x00        ; setting initial address
    
STEP1: ;Literal
    MOVLW 0X77      ; move 0x77 to WREG
    MOVWF LATD      ; move WREG value to LATD
    MOVLW 0x22      ; move 0x22 to WREG
    ADDWF LATD, 1   ; LATD = LATD(0x77) + WREG(0x22)
                    ; d=1: store in LATD, not in WREG

STEP2: ;Direct
    MOVLB 0x02      ; change to Bank 2
    MOVLW 0xff      ; move 0xff to WREG
    MOVWF 0x8c, 1   ; move WREG(0xff) to 0x28c
                    ; a=1: use per BSR(2)
    
STEP3: ;Indirect
    LFSR 0, 0x28c   ; move 0x28c to FSR0 (FSR0 points to 0x28c)
loop:
    DECFSZ INDF0, 1 ; decrease value of 0x28c by using FSR0 (pointer of 0x28c)
                    ; d=1: store in 0x28c
    GOTO loop       ; skip this line if value of 0x28c equals 0, else goto loop
    
STEP4: ;Relative
    MOVLW 0x0e      ; move 0x0e to WREG, use Program Memory to count 14(0x0e)
    SUBWF PCL, 1    ; Program Counter = Program Counter - 0x0e
                    ; d=1: store in PCL
    
end