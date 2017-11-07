    LIST p=18f4520		
#include<p18f4520.inc>		
    CONFIG  OSC = INTIO67       
    ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
    CONFIG  WDT = OFF           
    ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
    CONFIG  LVP = OFF
    ;CONFIG  PBADEN = OFF	; Set RB<4:0> as digital I/O pins

DELAY MACRO num1,num2
    local LOOP1         ;prevent compile error
    local LOOP2               
    MOVLW num2
    MOVWF L2
    LOOP2:
	MOVLW num1                   
	MOVWF L1  
    LOOP1:
	NOP
	NOP
	NOP
	NOP
	DECFSZ L1,1
	    GOTO LOOP1
	DECFSZ L2,1
	    GOTO LOOP2
    ENDM
    
#define SWITCH PORTA,4    
    L1  EQU 0X14
    L2  EQU 0X15
    ORG 0x0
    
init:
    CLRF    LATA        ; Alternate method to clear output data latches
    BSF     TRISA,4     ; 00010000: RA4 input
    MOVLW   0x0f
    MOVWF   ADCON1      ; set digital I/O
    CLRF    TRISD       ; Set PORTD for LED output
    CLRF    LATD
    
main:
    BSF     LATD, 0, 0  ; 00000001
    BSF     LATD, 4, 0  ; 00010001
    goto    blink
    
noblink:
    CLRF    LATD
    BTFSS   PORTA, 4
    goto    main        ; if push button reset LATD and goto blink loop
    goto    noblink
    
blink:
    BTFSS   PORTA, 4
    goto    noblink     ; if push button goto no blink loop
    DELAY   0x4f, 0x4f
    RLNCF   LATD
    goto    blink
    end