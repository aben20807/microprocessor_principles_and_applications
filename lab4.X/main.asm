LIST p=18f4520
#include<p18f4520.inc>
#include<lab4mac.asm>

ORG	0x00                ; setting initial address

initial:    
    NUMS10              ; load 16 numbers to 120~12F address
    LFSR 0,0x120        ; let FSR0 = 0x120 as i
    LFSR 1,0x120        ; let FSR1 = 0x120 as j

main:
    MOVFF FSR0L, FSR1L  ; j = i
    RCALL sbrt
    INCF FSR0L          ; i++
    MOVLW 0x2F
    CPFSGT FSR0L
    GOTO main           ; i < WREG(16) continue
    GOTO check          ; after sorting (i >= 16) jump to check if correct

sbrt:
    MOVF INDF0, 0       ; WREG = num[i]
    CPFSGT INDF1        ; if WREG(num[i]) > num[j] skip
    RCALL sbrt2         ; if WREG(num[i]) <= num[j] swap
    INCF FSR1L          ; j++
    MOVLW 0x2F
    CPFSGT FSR1L        ; j < WREG(16) continue
    GOTO sbrt           ; j >= 16
    RETURN

sbrt2:
    SWAP INDF0, INDF1
    RETURN

check:
    RTLST               ; check correctness
    NOP
    END