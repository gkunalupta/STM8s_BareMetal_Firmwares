   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  45                     ; 8 int main(void) 
  45                     ; 9 {
  47                     	switch	.text
  48  0000               _main:
  52                     ; 11   gb_bled_conf();
  54  0000 cd0000        	call	_gb_bled_conf
  56                     ; 12 	gb_timer_init();
  58  0003 cd0000        	call	_gb_timer_init
  60  0006               L12:
  61                     ; 15 		GPIOB->ODR ^= (1 << 5); // Toggle PB5 output
  63  0006 901a5005      	bcpl	20485,#5
  64                     ; 16 		gb_delay_ms(1000);
  66  000a ae03e8        	ldw	x,#1000
  67  000d cd0000        	call	_gb_delay_ms
  70  0010 20f4          	jra	L12
  83                     	xdef	_main
  84                     	xref	_gb_bled_conf
  85                     	xref	_gb_delay_ms
  86                     	xref	_gb_timer_init
 105                     	end
