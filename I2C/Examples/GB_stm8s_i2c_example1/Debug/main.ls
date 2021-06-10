   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  55                     ; 20 int main(void)
  55                     ; 21 {
  57                     	switch	.text
  58  0000               _main:
  62                     ; 22 	gb_bled_conf();
  64  0000 cd0000        	call	_gb_bled_conf
  66                     ; 23 	gb_timer_init();
  68  0003 cd0000        	call	_gb_timer_init
  70                     ; 25 	gb_i2c_master_init();
  72  0006 cd0000        	call	_gb_i2c_master_init
  74                     ; 26 	gb_i2c_start_condition_w();
  76  0009 cd0000        	call	_gb_i2c_start_condition_w
  78                     ; 27 	gb_i2c_address_send_w(GB_RTC_WADDR);
  80  000c a6d0          	ld	a,#208
  81  000e cd0000        	call	_gb_i2c_address_send_w
  83                     ; 28 	gb_i2c_databyte_send('b');
  85  0011 a662          	ld	a,#98
  86  0013 cd0000        	call	_gb_i2c_databyte_send
  88                     ; 29 	gb_i2c_stop_generation();
  90  0016 cd0000        	call	_gb_i2c_stop_generation
  92  0019               L12:
  93                     ; 36 	gb_i2c_start_condition_w();
  95  0019 cd0000        	call	_gb_i2c_start_condition_w
  97                     ; 37 	gb_i2c_address_send_w(GB_RTC_WADDR);
  99  001c a6d0          	ld	a,#208
 100  001e cd0000        	call	_gb_i2c_address_send_w
 102                     ; 38 	gb_i2c_databyte_send(GB_Temp_reg);
 104  0021 a611          	ld	a,#17
 105  0023 cd0000        	call	_gb_i2c_databyte_send
 107                     ; 39 	gb_i2c_stop_generation();
 109  0026 cd0000        	call	_gb_i2c_stop_generation
 111                     ; 41 		gb_delay_ms(100);
 113  0029 ae0064        	ldw	x,#100
 114  002c cd0000        	call	_gb_delay_ms
 116                     ; 43 	gb_i2c_start_condition_r();
 118  002f cd0000        	call	_gb_i2c_start_condition_r
 120                     ; 44 	gb_i2c_address_send_r(GB_RTC_RADDR);
 122  0032 a6d1          	ld	a,#209
 123  0034 cd0000        	call	_gb_i2c_address_send_r
 125                     ; 46 	gb_2byte_receive(gb_msb,gb_lsb);
 127  0037 b600          	ld	a,_gb_lsb
 128  0039 97            	ld	xl,a
 129  003a b601          	ld	a,_gb_msb
 130  003c 95            	ld	xh,a
 131  003d cd0000        	call	_gb_2byte_receive
 133                     ; 48 	gb_i2c_stop_generation();
 135  0040 cd0000        	call	_gb_i2c_stop_generation
 137                     ; 50 	gb_delay_ms(1000);
 139  0043 ae03e8        	ldw	x,#1000
 140  0046 cd0000        	call	_gb_delay_ms
 143  0049 20ce          	jra	L12
 176                     	xdef	_main
 177                     	switch	.ubsct
 178  0000               _gb_lsb:
 179  0000 00            	ds.b	1
 180                     	xdef	_gb_lsb
 181  0001               _gb_msb:
 182  0001 00            	ds.b	1
 183                     	xdef	_gb_msb
 184                     	xref	_gb_bled_conf
 185                     	xref	_gb_i2c_stop_generation
 186                     	xref	_gb_2byte_receive
 187                     	xref	_gb_i2c_databyte_send
 188                     	xref	_gb_i2c_address_send_r
 189                     	xref	_gb_i2c_address_send_w
 190                     	xref	_gb_i2c_start_condition_r
 191                     	xref	_gb_i2c_start_condition_w
 192                     	xref	_gb_i2c_master_init
 193                     	xref	_gb_delay_ms
 194                     	xref	_gb_timer_init
 214                     	end
