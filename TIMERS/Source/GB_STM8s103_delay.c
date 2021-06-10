#include "GB_STM8s103_delay.h"

//****** timer delay functions*****
void gb_timer_init(void)
{

	//TIM2->CR1 |= 1<<7; //ARR buffered
   /**********************for example 1*******************************/
	 //Enable the update generation so that PSC and ARR can be loaded 
   TIM2->EGR |= 1<<0;
   //Timer prescaler value, PSC[3:0] =1 so Ftim2
    TIM2->PSCR = 1;
    //Timer Auto reload register value
    TIM2->ARRH = 0xff;
		TIM2->ARRL = 0xff;
	
	  TIM2->SR1 &= ~(1<<0);
	
    TIM2->CR1 |= 1<<2; //generate update at Counter overflow/underflow

    TIM2_CNTR = 00;
		
     CLK->CCOR |= CLK_CCOR_CCOEN | CLK_CCOR_CCOSEL;

}
//Using Pooling example1
void gb_delay_us(uint16_t gb_us)
{
	uint16_t gb_i = gb_us;
//	TIM2->CNTRL = TIM2->CNTRH =0;
TIM2_CNTR =0;
	TIM2->CR1 |= (1<<0);
	while(TIM2_CNTR <gb_i);
	TIM2->CR1 &= ~(1<<0);
	//TIM2->SR1 &= ~(1<<0); //clear flag

}
void gb_delay_ms(uint16_t gb_ms)
{ 
  uint16_t gb_i;
	uint16_t gb_milisec = gb_ms;
	//ms = ms *10;
	for(gb_i=0; gb_i<gb_ms; gb_i++)
	gb_delay_us(1000);
}
void gb_delay_sec(uint16_t gb_secs)
{ 
  uint16_t gb_i;
	uint16_t gb_sec =gb_secs;
	for(gb_i=0; gb_i<gb_sec; gb_i++)
	gb_delay_ms(1000);
}
//unsigned long int dl; // Delay
