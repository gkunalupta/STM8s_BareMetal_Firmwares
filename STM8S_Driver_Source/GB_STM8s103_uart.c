
#include "GB_STM8s103_uart.h"
//****** STM8-UART1 functions***********//
//PD5-Tx, PD6-RX
void gb_uart1_pin_conf(void)
{
	/*clock enable for UART and GPIO peripheral is set by default */
	
	// Set Tx pin as output pushpull
	GPIOD-> DDR |= (1<<5);
	GPIOD-> CR1 |= ((1<<5));
	
	//Set Rx pin as Input floating
	/*by default all pins are input floating only*/
}
void gb_uart1_baud(void)
{
	UART1 ->BRR2 = 0x0C;
	UART1 ->BRR1 = 0x0C;
}
char gb_tmp = 0;
//FCPU = 2mhz and baudrate =9600, so 0x0C on BRR2 and BRR1
void gb_uart_init(void)
{
   /*clock enable for UART and GPIO peripheral is set by default */
	 gb_uart1_pin_conf();
		
	

  /* Clear the Idle Line Detected bit in the status register by a read
  to the UART1_SR register followed by a write to the UART1_DR register. */
 // char tmp = 0;
		
	gb_tmp	 = UART1->SR;
  UART1->DR = gb_tmp;
	 
	 
	/*Reset the UART registers by default:
	disable TE and RE
	Set word legth :8 bit,1 startbit
	Parity disable
	UART stop bit: 1
	*/
	UART1_SR_RESET_VALUE;
	UART1_CR1_RESET_VALUE;
	UART1_CR2_RESET_VALUE;
	UART1_CR3_RESET_VALUE;
	UART1_BRR2_RESET_VALUE;
	UART1_BRR1_RESET_VALUE;
	
	
	//UART_baudrate
	gb_uart1_baud();
	//Transmitter enable, TE bit is at 3 of CR2
	UART1-> CR2 |= ((1<<3)|(1<<2));
	//Receiver enable, RE bit is at 2 of CR2
	UART1-> CR2 |= (1<<2);

}
void gb_uart_tran_byte(uint8_t gb_byte)    // single byte transmit
{
	
	
  while(!(UART1->SR & UART1_SR_TXE));
	UART1->DR = gb_byte;
	while(!(UART1->SR & UART1_SR_TC));


}
void gb_uart_tran_string(const uint8_t *gb_myString) // string transmit
{
while (*gb_myString)
	{
	gb_uart_tran_byte(*gb_myString++);
	}
}
void gb_uart_tran_bin_byte(uint8_t gb_val)    // binary byte transmit
{
	int8_t gb_ptr;
	for(gb_ptr=7;gb_ptr>=0;gb_ptr--)
	{
		if ((gb_val & (1<<gb_ptr))==0)
		{
			gb_uart_tran_byte('0');
		}
		else
		{
		  gb_uart_tran_byte('1');
		}
	}
}
void gb_uart_tran_dec(uint8_t gb_val)               // decimel transmit
{
	unsigned char gb_buf[5];
	int8_t gb_ptr;
	for(gb_ptr=0;gb_ptr<5;++gb_ptr) 
	{
		gb_buf[gb_ptr] = (gb_val % 10) + '0';
		gb_val /= 10;
	}
	for(gb_ptr=4;gb_ptr>0;--gb_ptr) 
	{
		if (gb_buf[gb_ptr] != '0')
		break;
	}
	for(;gb_ptr>=0;--gb_ptr) 
	{
		gb_uart_tran_byte(gb_buf[gb_ptr]);
	}
}
char gb_uart_receive_byte()
{
	while(!(UART1->SR & UART1_SR_RXNE)); //  Block until char rec'd
	return  UART1->DR;
}
