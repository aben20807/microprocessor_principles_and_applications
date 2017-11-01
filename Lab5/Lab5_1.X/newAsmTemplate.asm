#include <xc.inc>
GLOBAL _add

PSECT mytext, local, class = CODE, reloc = 2
 
tempvar1    EQU 0x01
tempvar2    EQU 0x02
tempvar3    EQU 0x03
tempvar4    EQU 0x04
; 0x 12     34      0x 56     78 
;    ^^     ^^         ^^     ^^
;    0x01   0x02       0x03   0x04
; result:
; 0x 68     AC
;    ^^     ^^ 
;    0x01   0x02
    
_add:
    MOVF tempvar3, w
    ADDWF tempvar1, f
    MOVF tempvar4, w
    ADDWFC tempvar2, f
    return 