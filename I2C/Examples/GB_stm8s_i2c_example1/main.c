/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */

#include <stm8s.h>
#include <stdio.h>
#include "GB_STM8s103_delay.h"
#include "GB_STM8s103_uart.h"
#include "GB_STM8s103_i2c.h"
#include "GB_STM8s103_gpio.h"

#define GB_RTC_WADDR 0b11010000   //Slave Write
#define GB_RTC_RADDR 0b11010001   //Slave Read
#define GB_Temp_reg 0x11

uint8_t gb_msb;
	uint8_t gb_lsb;
	
int main(void)
{
	gb_bled_conf();
	gb_timer_init();
	
	gb_i2c_master_init();
	gb_i2c_start_condition_w();
	gb_i2c_address_send_w(GB_RTC_WADDR);
	gb_i2c_databyte_send('b');
	gb_i2c_stop_generation();
	

	while (1)
	{
		//GPIOB->ODR ^= (1 << 5); // Toggle PB5 output
		
	gb_i2c_start_condition_w();
	gb_i2c_address_send_w(GB_RTC_WADDR);
	gb_i2c_databyte_send(GB_Temp_reg);
	gb_i2c_stop_generation();
	
		gb_delay_ms(100);
	
	gb_i2c_start_condition_r();
	gb_i2c_address_send_r(GB_RTC_RADDR);
	//msb = gb_single_byte_receive();
	gb_2byte_receive(gb_msb,gb_lsb);
	
	gb_i2c_stop_generation();
	
	gb_delay_ms(1000);
  }
}