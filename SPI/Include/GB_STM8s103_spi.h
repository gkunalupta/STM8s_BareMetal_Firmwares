#ifndef GB_STM8S103_SPI_H_
#define GB_STM8S103_SPI_H_

#include <stm8s.h>
#include <stdio.h>


void gb_spi_pin_config(void);
void gb_spi_ma_init(void);
void gb_spi_mast_tran_byte(uint8_t gb_data);
uint8_t gb_spi_mast_rec_byte(void);


#endif



















