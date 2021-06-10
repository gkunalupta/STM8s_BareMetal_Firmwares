#include "GB_stm8s103_i2c.h"

uint8_t gb_read_reg;


void gb_i2c_master_init()
{
	
//	gp_i2c_pin_config();
	
	
	I2C ->FREQR=0x02; // Input clock frequency = 2MHZ
	
	I2C ->CCRH=0x00;   // selecting the core clock frequency as 50Khz
	I2C ->CCRL=0x14;   //
	
	I2C ->TRISER=0x03; // Rise time calculated for 50KHZ at 2MHZ is 3
	
	
	I2C ->CR1|= I2C_CR1_PE; //enable the i2c peripheral
	
}

void gb_i2c_start_condition_w(void)
{
	gb_read_reg = I2C->SR1;
	gb_read_reg = I2C->SR3;
	
	I2C ->CR2 =I2C_CR2_START;
	while(!(I2C ->SR1 & I2C_SR1_SB));
	gb_read_reg = I2C->SR1;
	gb_read_reg = I2C->SR3;
	
}

void gb_i2c_start_condition_r(void)
{
	I2C->CR2 |= I2C_CR2_ACK;
	I2C ->CR2 |=I2C_CR2_START;
	while(!(I2C ->SR1 & I2C_SR1_SB));
	gb_read_reg = I2C->SR1;
	
}

void gb_i2c_address_send_w(uint8_t gb_slave_address)
{
	I2C ->DR = gb_slave_address; //Write Slave address
	
	while(!(I2C ->SR1 & I2C_SR1_TXE));
	
	//clearing the ADDR bit
	gb_read_reg = I2C->SR1;
	gb_read_reg = I2C->SR3;
	
}

int gb_i2c_address_send_r(uint8_t gb_slave_address)
{
	I2C->DR = gb_slave_address;
	
	while(!(I2C->SR1 & I2C_SR1_ADDR))
	{
		if((I2C->SR1 & I2C_SR2_AF) == 1)
		  { 
			return 0;
			}
  }
	gb_read_reg = I2C->SR1;
	gb_read_reg = I2C->SR3;
 
}
// for receiving 1 byte
uint8_t gb_single_byte_receive()
{
	uint8_t data;
	I2C->CR2 &= ~I2C_CR2_ACK;
	
	I2C->CR2 |= I2C_CR2_STOP;
	
	while(!(I2C->SR1 & I2C_SR1_RXNE));
	data = I2C->DR;
	
	return data;
}

// for receiving 2 byte
void gb_2byte_receive(uint8_t data1, uint8_t data2)
{
	I2C ->CR2 |= I2C_CR2_POS;
	
	I2C ->CR2 &= ~I2C_CR2_ACK;
	
	while(!(I2C ->SR1 & I2C_SR1_BTF));
	I2C->CR2 |= I2C_CR2_STOP;
	
	data1 =I2C->DR;
	data2 =I2C->DR;
	
}

void gb_i2c_databyte_send(uint8_t gb_i2c_data)
{
	I2C->DR = gb_i2c_data;
	while(!(I2C ->SR1 & I2C_SR1_TXE));
}

void gb_i2c_stop_generation()
{
	I2C ->CR2 |=I2C_CR2_STOP;
}


	