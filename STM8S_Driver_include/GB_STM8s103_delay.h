
#ifndef GB_STM8S103_DELAY_H_
#define GB_STM8S103_DELAY_H_

#define TIM2_CNTR *(uint16_t*)0x530C

#include <stm8s.h>
#include <stdio.h>
//****** timer delay functions*****
void gb_timer_init(void);
//Using Pooling example1
void gb_delay_us(uint16_t us);
void gb_delay_ms(uint16_t ms);
void gb_delay_sec(uint16_t secs);
//unsigned long int dl; // Delay


#endif