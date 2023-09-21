/*             Nahom Worku
               EECS 2021 - Major Project          */  
    
#define __SFR_OFFSET 0x00
#include "avr/io.h"
#include <xc.h>

.section .text
.global getHumidity

getHumidity:
    
 repeat:RCALL delay2s      

    SBI   DDRB, 1       
    CBI   PORTB, 1      
    RCALL delay20ms    
    SBI   PORTB, 1      

    CBI   DDRB, 1       
jump1: SBIC  PINB, 1
    RJMP  jump1            
jump2: SBIS  PINB, 1
    RJMP  jump2            
jump3: SBIC  PINB, 1
    RJMP  jump3            

    RCALL receiveDate 
    MOV   R20, R19
    RCALL receiveDate

    OUT   PORTD, R20    
    OUT   PORTC, R20    

    RJMP  repeat           
    
    
receiveDate:      
    LDI   R16, 8        
    CLR   R19           

    
receiveDate_1: SBIS  PINB, 1 
    RJMP  receiveDate_1            
    RCALL delayT0 

    SBIS  PINB, 1       
    RJMP  jmp           
    SEC                 
    ROL   R19           
    RJMP  receiveDate_2            
jmp:LSL   R19           
    
receiveDate_2: SBIC  PINB, 1 
    RJMP  receiveDate_2           
    DEC   R16           
    BRNE  receiveDate_1            
    RET                 
    
delayT0:              
    CLR   R21
    OUT   TCNT0, R21      
    LDI   R21, 100
    OUT   OCR0A, R21      
    LDI   R21, 0xA
    OUT   TCCR0B, R21     
delayT0_1: IN    R21, TIFR0      
    SBRS  R21, OCF0A      
    RJMP  delayT0_1                  
    CLR   R21
    OUT   TCCR0B, R21     
    LDI   R21, (1<<OCF0A)
    OUT   TIFR0, R21      
    RET
    
delay2s:               
    LDI   R22, 255
delay2s_1: LDI   R23, 255
delay2s_2: LDI   R24, 164  
delay2s_3: DEC   R24
    BRNE  delay2s_3
    DEC   R23
    BRNE  delay2s_2
    DEC   R22
    BRNE  delay2s_1
    RET 
    
delay20ms:             
    LDI   R22, 255
delay20ms_1: LDI   R23, 210
delay20ms_2: LDI   R24, 2
delay20ms_3: DEC   R24
    BRNE  delay20ms_3
    DEC   R23
    BRNE  delay20ms_2
    DEC   R22
    BRNE  delay20ms_1
    RET
.end