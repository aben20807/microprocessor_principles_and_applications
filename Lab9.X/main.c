#define TMR2PRESCALE 16
//#define __delay_ms(x) _delay((unsigned long)((x)*(_XTAL_FREQ/4000.0)))
#define _XTAL_FREQ 2000000

#include <xc.h>
// BEGIN CONFIG
#pragma config OSC = INTIO67   // Oscillator Selection bits (HS oscillator)
#pragma config WDT = OFF  // Watchdog Timer Enable bit (WDT enabled)
#pragma config PWRT = OFF // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON  // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = OFF   // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF   // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)

//END CONFIG

PWM1_Init(long setDuty)
{
    PR2 = setDuty;
}

PWM1_Duty(unsigned int duty)
{
    //set duty to CCPR1L , CCP1X(CCP1CON:5) and CCP1Y(CCP1CON:4)
    int mask =  1 << 0;
    CCP1CONbits.CCP1Y = duty >> (mask & duty);
    mask =  1 << 1;
    CCP1CONbits.CCP1X = duty >> (mask & duty);
    //CCP1CONbits.CCP1Y = duty;
    //CCP1CONbits.CCP1X = (duty >> 1);
    CCPR1L = (duty >> 2);
}
PWM1_Start()
{
    PR2 = 77;
    //set CCP1CON
    CCP1CONbits.CCP1M0 = 0;
    CCP1CONbits.CCP1M1 = 0;
    CCP1CONbits.CCP1M2 = 1;
    CCP1CONbits.CCP1M3 = 1;
    //set timer2 on
    //PR2 = 0;
    T2CONbits.TMR2ON = 1;
    //set rc2 output
    TRISCbits.RC2 = 0;
    PORTC = 0x00;

    if (TMR2PRESCALE == 1)
    {

    }
    else if(TMR2PRESCALE == 4)
    {

    }
    else if (TMR2PRESCALE == 16)
    {
        T2CONbits.T2CKPS1 = 1;
        // 250kHz
        OSCCONbits.IRCF2 = 0;
        OSCCONbits.IRCF1 = 1;
        OSCCONbits.IRCF0 = 0;
    }
}

void main()
{
    PWM1_Init(77);
    int i=8;//8, 15
    //set trisD
    TRISDbits.RD0 = 1;
    PWM1_Start();
    do
    {
        if(PORTDbits.RD0 == 0 && i<=37) {//38, 31
            i = i + 1;
        }
//        else if(PORTDbits.RD0 == 1){
//            i = 8;
//        }
        PWM1_Duty(i);
        __delay_ms(5);
    }while(1);
}
