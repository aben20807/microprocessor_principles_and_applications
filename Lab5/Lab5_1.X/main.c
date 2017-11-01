/*
 * File:   main.c
 * Author: user
 *
 * Created on 2017年10月30日, 下午 5:40
 */
#pragma config OSC = INTIO67
#pragma config WDT = OFF
#pragma config LVP = OFF


#include <xc.h>

int add(int a, int b);

void main(void) {
    int sum = add(0x1234, 0x5678);
    return;
}