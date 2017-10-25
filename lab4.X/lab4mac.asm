    
 
MOVLF	MACRO N, DATUM        ; 將立即數放置FILE REGISTER
	MOVLW N
	MOVWF DATUM
	ENDM
	
NUMS10	MACRO			; ============================================
	MOVLB 1		; 給定16個數字放在120~12F的位置
	LFSR 0, 0X120
	MOVLF D'45', POSTINC0
	MOVLF D'32', POSTINC0
	MOVLF D'138', POSTINC0
	MOVLF D'181', POSTINC0
	MOVLF D'110', POSTINC0
	MOVLF D'247', POSTINC0
	MOVLF D'87', POSTINC0
	MOVLF D'43', POSTINC0
	MOVLF D'144', POSTINC0
	MOVLF D'5', POSTINC0
	MOVLF D'207', POSTINC0
	MOVLF D'229', POSTINC0
	MOVLF D'156', POSTINC0
	MOVLF D'97', POSTINC0
	MOVLF D'88', POSTINC0
	MOVLF D'1', POSTINC0
	ENDM
	
RTLST	MACRO     ; ========================================================
	LOCAL IS1, IS2, YES, NO, ENDD  ; 檢測是否為正確答案
	MOVLB 1
	LFSR 0, 0X120
	LFSR 1, 0X121	
IS1:	BTFSS FSR1L,4	    ; 注意!!沒有FSR0這個register,所以用FSR0L判斷
	GOTO IS2
	GOTO YES
IS2:	MOVF POSTINC1,0
	CPFSLT POSTINC0
	GOTO NO
	GOTO IS1
NO:	MOVLF 0X45, 0X160	; // 'E'
	MOVLF 0X52, 0X161	; // 'R'   
	MOVLF 0X52, 0X162	; // 'R'
	MOVLF 0X4F, 0X163	; // 'O'
	MOVLF 0X52, 0X164	; // 'R'
	GOTO ENDD
YES:	MOVLF 0X43, 0X160	; // 'C'
	MOVLF 0X4F, 0X161	; // 'O'
	MOVLF 0X52, 0X162	; // 'R'
	MOVLF 0X52, 0X163	; // 'R'
	MOVLF 0X45, 0X164	; // 'E'
	MOVLF 0X43, 0X165	; // 'C'
	MOVLF 0X54, 0X166	; // 'T'
ENDD:
	ENDM
 
SWAP MACRO PAR0, PAR1   ; macro to swap two parameters
    MOVFF PAR0, WREG    ; t = a
    MOVFF PAR1, PAR0    ; a = b
    MOVFF WREG, PAR1    ; b = t
    ENDM  