#include <stm8s.h>
#include <stdio.h>
#include "GB_STM8s103_delay.h"
#include "GB_STM8s103_uart.h"
#include "GB_STM8s103_gpio.h"



int main(void) 
{
	
	gb_bled_conf();
	gb_timer_init();
	gb_uart_init(); //own
  gb_uart_tran_string("***********Uart example: you type, I echo************\n\r");
	

	
	while(1)
	{
		char gb_recv;
		
		gb_uart_tran_string("\nGettobyte: STM8S transmit driver by pooling\n");
		GPIOB->ODR ^= (1 << 5); // Toggle PB5 output
		gb_delay_ms(1000);
		gb_recv = gb_uart_receive_byte();
		
		gb_uart_tran_byte(gb_recv);
		
		//for (dl = 0; dl < 29000; dl++) {}
		
	}
}
