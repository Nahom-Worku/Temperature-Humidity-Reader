/*             Nahom Worku
               EECS 2021 - Major Project          */            

#include <stdio.h>
#include <stdlib.h>
#include "avr/io.h"
#include <xc.h>

extern uint8_t getHumidity (void);


int main(void) {
    
    DDRB &= !(1 << PB5) ;
    DDRC = 0xFF;
    DDRD = 0xFF;
    
    getHumidity();          

    return (0);
}

