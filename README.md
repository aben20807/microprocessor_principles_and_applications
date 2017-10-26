Microprocessor Principles and Applications class record
===
## review
+ C codes about using linked list and stack.

## Lab1
+ Simple addition.

## Lab2
+ Four fundamental addressing modes:
    + Literal:  use MOV to operate registers.
    + Direct:   use MOVLB to select bank.
    + Indirect: use FSR to point value.
    + Relative: use PCL to jump address.

## Lab3
+ Lab3-1:
    + Use AND, OR, XOR to implement NAND, NOR.
    + Implement NOT: XOR with 0xFF.
+ Lab3-2:
    + Add from 1, 2, ... until overflow.
    + Because of signed integer, overflow occurred when the leftmost bit = 1.
    + Use RLCF, RRCF to retate with carry.

## Lab4
+ main.asm:     Bubble sort with calling subroutine.
+ lab4mac.asm:  Check sorted result correctness. SWAP macro.
+ Notice that cannot skip whole macro, let macro be in a subroutine.
