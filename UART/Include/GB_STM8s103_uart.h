
#ifndef GB_STM8S103_UART_H_
#define GB_STM8S103_UART_H_

#include <stm8s.h>
#include <stdio.h>

//****** STM8-UART1 functions***********//
//PD5-Tx, PD6-RX
void gb_uart1_pin_conf(void);
void gb_uart1_baud(void);
//FCPU = 2mhz and baudrate =9600, so 0x0C on BRR2 and BRR1
void gb_uart_init(void);
void gb_uart_tran_byte(uint8_t gb_byte);    // single byte transmit
void gb_uart_tran_string(const uint8_t *gb_myString); // //string transmit
void gb_uart_tran_bin_byte(uint8_t gb_val);    //binary byte transmit
void gb_uart_tran_dec(uint8_t gb_val);          // //decimel transmit
char gb_uart_receive_byte(void);


#endif