   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  60                     ; 9 int main(void) 
  60                     ; 10 {
  62                     	switch	.text
  63  0000               _main:
  65  0000 88            	push	a
  66       00000001      OFST:	set	1
  69                     ; 12 	gb_bled_conf();
  71  0001 cd0000        	call	_gb_bled_conf
  73                     ; 13 	gb_timer_init();
  75  0004 cd0000        	call	_gb_timer_init
  77                     ; 14 	gb_uart_init(); //own
  79  0007 cd0000        	call	_gb_uart_init
  81                     ; 15   gb_uart_tran_string("***********Uart example: you type, I echo************\n\r");
  83  000a ae002e        	ldw	x,#L72
  84  000d cd0000        	call	_gb_uart_tran_string
  86  0010               L13:
  87                     ; 23 		gb_uart_tran_string("\nGettobyte: STM8S transmit driver by pooling\n");
  89  0010 ae0000        	ldw	x,#L53
  90  0013 cd0000        	call	_gb_uart_tran_string
  92                     ; 24 		GPIOB->ODR ^= (1 << 5); // Toggle PB5 output
  94  0016 901a5005      	bcpl	20485,#5
  95                     ; 25 		gb_delay_ms(1000);
  97  001a ae03e8        	ldw	x,#1000
  98  001d cd0000        	call	_gb_delay_ms
 100                     ; 26 		gb_recv = gb_uart_receive_byte();
 102  0020 cd0000        	call	_gb_uart_receive_byte
 104  0023 6b01          	ld	(OFST+0,sp),a
 106                     ; 28 		gb_uart_tran_byte(gb_recv);
 108  0025 7b01          	ld	a,(OFST+0,sp)
 109  0027 cd0000        	call	_gb_uart_tran_byte
 112  002a 20e4          	jra	L13
 125                     	xdef	_main
 126                     	xref	_gb_bled_conf
 127                     	xref	_gb_uart_receive_byte
 128                     	xref	_gb_uart_tran_string
 129                     	xref	_gb_uart_tran_byte
 130                     	xref	_gb_uart_init
 131                     	xref	_gb_delay_ms
 132                     	xref	_gb_timer_init
 133                     .const:	section	.text
 134  0000               L53:
 135  0000 0a476574746f  	dc.b	10,71,101,116,116,111
 136  0006 627974653a20  	dc.b	"byte: STM8S transm"
 137  0018 697420647269  	dc.b	"it driver by pooli"
 138  002a 6e670a00      	dc.b	"ng",10,0
 139  002e               L72:
 140  002e 2a2a2a2a2a2a  	dc.b	"***********Uart ex"
 141  0040 616d706c653a  	dc.b	"ample: you type, I"
 142  0052 206563686f2a  	dc.b	" echo************",10
 143  0064 0d00          	dc.b	13,0
 163                     	end
