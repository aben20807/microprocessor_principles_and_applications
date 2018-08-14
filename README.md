Microprocessor Principles and Applications class record
===
## review
+ C codes about using linked list and stack.

## HW01
+ Use sine table to compute degree.
+ Detailed process see [here](https://github.com/aben20807/microprocessor_principles_and_applications/blob/master/HW01.X/F74046284_HW1_report.pdf).

## Hands\_on\_1
+ morse code for midterm exam.

## final project
+ see here:[https://github.com/siahuat0727/TransLove](https://github.com/siahuat0727/TransLove)

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

## Lab5
+ Lab5\_1:
    + Call and use assembly codes in C program.
    + add function in .asm.
+ Lab5\_2:
    + Use Lab5\_2\_lib.h to implement add, sub to number.

## Lab6
+ Use RA4 to detect button to control PORTD led blinking.

## Lab7
+ Use high priority ISR to handle interrupt when clicking button.

## Lab8
+ Use timer to control LED.
+ Let port B be input button, and port D to output LED.

## Lab9
+ Use PWM to control servo moter

## Lab10
+ Connect three 300ohms resistors in series.
+ Use ADC (analog-to-digital converter) to measure voltage between resistors.

## Lab11
+ Use UART to let terminal to control two LEDs on and off.
+ `$ Control1`: LED1 on, `$ Control2`: LED1 off
+ `$ Control3`: LED2 on, `$ Control4`: LED2 off
