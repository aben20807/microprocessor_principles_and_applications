LIST p=18f4520		
#include <p18f4520.inc>

;********************************************************************
;****	Set CONFIG
;********************************************************************
    CONFIG  OSC = INTIO67       
    ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
    CONFIG  WDT = OFF           
    ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))

;********************************************************************
;****	Set vector
;********************************************************************
    org		0x0000
    BRA		Main

;***********************************************************************
;****   Initialize table pointer and ans value
;***********************************************************************
Init_TABLE_st45:           ; 1 ~ 181
    MOVLW   upper sintable
    MOVWF   TBLPTRU
    MOVLW   high sintable
    MOVWF   TBLPTRH
    MOVLW   low sintable
    MOVWF   TBLPTRL
    CLRF    ans             ; let ans initialize to 0
    RETURN

Init_TABLE_gt45:           ; 182 ~ 255 
    CALL    Init_TABLE_st45
    MOVLW   d'45'
    ADDWF   TBLPTRL, 1      ; read table from middle of table
    ADDWF   ans, 1          ; let ans initialize to 45
    RETURN

;********************************************************************
;****	The Main program start from here
;********************************************************************
Main:
    dis     equ 0x01
    ans     equ 0x02
    
    MOVLW   d'183'           ; set distance here (1 ~ 255)
    MOVWF   dis, 1

    MOVLW   d'182'
    CPFSLT  dis             ; compare distance to call correspondent init
    CALL    Init_TABLE_gt45 ; distance greater than 182
    CPFSGT  dis
    CALL    Init_TABLE_st45 ; distance less than 182
    
loop:
    TBLRD*+
    MOVF    dis, 0
    CPFSLT  TABLAT
    BRA     answer

next:
    INCF    ans
    BRA     loop
    NOP

answer:
    MOVLW   d'0'
    CPFSEQ  ans             ; if ans = 0, represent that ans is the smallest
    RCALL   find_near
    BRA     stop

stop:
    NOP                     ; set breakpoint here to check answer
    goto    stop

;***********************************************************************
;****   Find the closest answer
;***********************************************************************
find_near:
    MOVF    dis, 0
    MOVFF   TABLAT, LATA
    SUBWF   LATA, 1         ; A = sintable(t) - dis
    TBLRD*-
    TBLRD*-
    TBLRD*
    MOVF    TABLAT, 0
    MOVFF   dis, LATB
    SUBWF   LATB, 1         ; B = dis - sintable(t-1)
    MOVF    LATA, 0
    CPFSGT  LATB            ; compare A with B
    DECF    ans
    RETURN
    
;***********************************************************************
;****   256 * sin2θ table
;***********************************************************************
sintable    db  d'0',   d'4',   d'9',   d'13',  d'18',  d'22',  d'27',  d'31',  d'36',  d'40'
            db  d'44',  d'49',  d'53',  d'58',  d'62',  d'66',  d'71',  d'75',  d'79',  d'83'
            db  d'88',  d'92',  d'96',  d'100', d'104', d'108', d'112', d'116', d'120', d'124'
            db  d'128', d'132', d'136', d'139', d'143', d'147', d'150', d'154', d'158', d'161'
            db  d'165', d'168', d'171', d'175', d'178', d'181', d'184', d'187', d'190', d'193'
            db  d'196', d'199', d'202', d'204', d'207', d'210', d'212', d'215', d'217', d'219'
            db  d'222', d'224', d'226', d'228', d'230', d'232', d'234', d'236', d'237', d'239'
            db  d'241', d'242', d'243', d'245', d'246', d'247', d'248', d'249', d'250', d'251'
            db  d'252', d'253', d'254', d'254', d'255', d'255', d'255', d'256', d'256', d'256'
            db  d'256'
end