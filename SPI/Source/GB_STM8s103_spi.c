#include "GB_STM8s103_spi.h"



void gb_spi_pin_config(void)
{
	// MOSI: PC6(Output), MISO: PC7(input), SCK: PC5(output), PA3: NSS(output)
	
	//MOSI pin as Output pushpull
	GPIOC-> DDR |= (1<<6);
	GPIOC-> CR1 |= ((1<<6));
	
	//SCK pin as Output pushpull
	GPIOC-> DDR |= (1<<5);
	GPIOC-> CR1 |= ((1<<5));
	
	//NSS pin as Output pushpull
	GPIOA-> DDR |= (1<<3);
	GPIOA-> CR1 |= ((1<<3));
	
	//MISO pin as Input floating
	GPIOC-> DDR &= ~(1<<5);
	GPIOC-> CR1 &= ~((1<<5));
	
}
	

void gb_spi_ma_init(void)

{
	
	gb_spi_pin_config();
	
	//Baud Rate Configuration: f(master)/2=1MHZ, f(master) = 2MHZ
	SPI ->CR1 &= ~(SPI_CR1_BR);
	
	//clock polarity and clock phase
	SPI ->CR1 &= ~(SPI_CR1_CPOL | SPI_CR1_CPHA);
	
	//MSB is trabsmitted first: by default only
	
	//Selecting hardware control on chip select pin
	SPI ->CR2 &= ~(SPI_CR2_SSM);
	
	//master enable
	SPI ->CR1|= (SPI_CR1_MSTR);
	
	//Periphel Enable
	SPI ->CR1|= SPI_CR1_SPE;
}

void gb_spi_mast_tran_byte(uint8_t gb_data)
{
	SPI ->DR = gb_data;
	while(!(SPI ->SR & SPI_SR_TXE));
	while((SPI ->SR & SPI_SR_BSY));
}

uint8_t gb_spi_mast_rec_byte(void)
{
	uint8_t gb_recv_data = 0;
	SPI ->DR = 0xff;
	while((SPI ->SR & SPI_SR_BSY));
	while((SPI ->SR & SPI_SR_RXNE))
	gb_recv_data = SPI ->DR;
	return gb_recv_data;
}

	