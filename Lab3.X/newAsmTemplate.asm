LIST p=18f4520		
#include<p18f4520.inc>		
; CONFIG1H
    CONFIG  OSC = INTIO67   ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
; CONFIG2H
    CONFIG  WDT = OFF       ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))

	ORG 	0x00	
	
Initial:	
    CLRF	LATC
    CLRF	LATD		
; ***********************************
    ; Lab3-1
    MOVLW 0xB5          ; WREG = 10110101(0xB5)
    MOVWF LATD          ; LATD = WREG(0xB5)
    MOVLW 0x7C          ; WREG = 01111100(0x7C)
    ANDWF LATD, 1, 0    ; LATD = LATD(0xB5) AND WREG(0x7C)
    MOVLW 0xFF          ; WREG = 0xFF
    XORWF LATD, 1, 0    ; LATD = LATD XOR WREG(0xFF) = NOT LATD
    
    MOVLW 0x96          ; WREG = 10010110(0x96)
    MOVWF LATC          ; LATC = WREG(0x96)
    MOVLW 0x69          ; WREG = 01101001(0x69)
    IORWF LATC, 1, 0    ; LATC = LATC(0x96) AND WREG(0x69)
    MOVLW 0xFF          ; WREG = 0xFF
    XORWF LATC, 1, 0    ; LATC = LATC XOR WREG(0xFF) = NOT LATC

    ; Lab3-2
    CLRF LATA
    MOVLW 0x00          ; initialize WREG to 0
loop:
    INCF WREG           ; WREG = WREG + 1
    ADDWF LATA          ; LATA = LATA + WREG
    BNOV loop           ; if overflow bit != 1 continue loop
                        ; why overflow? LATA became negative(leftmost bit = 1)
    BNC 0x32            ; if carry != 1, goto Rotate
    NOP
    NOP
    NOP
    GOTO Initial
Rotate:
    MOVLW 0x8F          ; WREG = 0x8F, PC = 0x36
    MOVWF LATB          ; LATB = WREG(0x8F)
    RLCF LATB, 0        ; WREG = LATB left shift 1 bit, carry became 1
    RRCF LATB, 0        ; WREG = LATB right shift 1 bit, carry became 1
    
end