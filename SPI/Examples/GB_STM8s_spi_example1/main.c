/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */

#include <stm8s.h>
#include <stdio.h>
#include "GB_STM8s103_delay.h"
#include "GB_STM8s103_uart.h"
#include "GB_STM8s103_gpio.h"

#include "GB_STM8s103_spi.h"

main()
{
	gb_timer_init();
	gb_uart_init();
	gb_spi_ma_init();
	
	while (1)
	{
		gb_delay_ms(10);
		
		GPIOA ->ODR&= ~(1<<3);
		gb_spi_mast_tran_byte(0x90);
		gb_spi_mast_rec_byte();
		gb_spi_mast_rec_byte();
		gb_spi_mast_rec_byte();
		gb_spi_mast_rec_byte();
		gb_spi_mast_rec_byte();

		GPIOA ->ODR= (1<<3);
		gb_delay_ms(100);
		
		}
		
}