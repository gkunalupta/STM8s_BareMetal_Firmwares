
#ifndef GB_STM8S103_I2C_H_
#define GB_STM8S103_I2C_H_

#include <stm8s.h>
#include <stdio.h>



void gb_i2c_master_init(void);
void gb_i2c_start_condition_w(void);
void gb_i2c_start_condition_r(void);
void gb_i2c_address_send_w(uint8_t gb_slave_address);
int gb_i2c_address_send_r(uint8_t gb_slave_address);
void gb_i2c_databyte_send(uint8_t gb_i2c_data);
uint8_t gb_single_byte_receive(void);
void gb_2byte_receive(uint8_t data1, uint8_t data2);

void gb_i2c_stop_generation(void);

#endif