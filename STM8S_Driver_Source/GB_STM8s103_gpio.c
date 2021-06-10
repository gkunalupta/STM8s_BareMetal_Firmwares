#include "GB_STM8s103_gpio.h"


void gb_bled_conf(void)
{
	GPIOB->ODR = 0x00;	// Turn all pins of port B to low
	GPIOB->DDR |= (1 << 5)|(1<<4); // 0x00100000 PB5 is now output
	GPIOB->CR1 |= (1 << 5)|(1<<4); // 0x00100000 PB5 is now pushpull
}
