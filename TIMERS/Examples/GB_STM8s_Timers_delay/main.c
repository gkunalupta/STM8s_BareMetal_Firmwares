
#include <stm8s.h>
#include <stdio.h>
#include "GB_STM8s103_delay.h"
#include "GB_STM8s103_gpio.h"


int main(void) 
{
	
  gb_bled_conf();
	gb_timer_init();
	while(1)
	{
		GPIOB->ODR ^= (1 << 5); // Toggle PB5 output
		gb_delay_ms(1000);
		//for (dl = 0; dl < 29000; dl++) {}
		
	}
}

