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
;****	Reset vector
;********************************************************************
    org		0x0000
    BRA		Main

;********************************************************************
;****	The Main program start from here
;********************************************************************
Main:
    index   equ 0x00
    dis     equ 0x01
    ans     equ 0x02
    

    MOVLW   d'40'           ; set distance 1 ~ 255
    MOVWF   dis, 1

    CALL    Init_TABLE
    MOVLW   0x90
    MOVWF   index

loop:
    TBLRD*+
    MOVF    dis, 0
    SUBWF   TABLAT, 0
    BN      next
    BRA     answer

next:
    DECFSZ  index
    BRA     loop
    NOP

answer:
    MOVLW   0x90
    MOVWF   ans
    MOVF    index, 0
    SUBWF   ans, 1
    
;***********************************************************************
;****   Initialize table
;***********************************************************************
Init_TABLE:    
    MOVLW   upper sintable
    MOVWF   TBLPTRU
    MOVLW   high sintable
    MOVWF   TBLPTRH
    MOVLW   low sintable
    MOVWF   TBLPTRL
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