   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  42                     ; 4 void gb_bled_conf(void)
  42                     ; 5 {
  44                     	switch	.text
  45  0000               _gb_bled_conf:
  49                     ; 6 	GPIOB->ODR = 0x00;	// Turn all pins of port B to low
  51  0000 725f5005      	clr	20485
  52                     ; 7 	GPIOB->DDR |= (1 << 5)|(1<<4); // 0x00100000 PB5 is now output
  54  0004 c65007        	ld	a,20487
  55  0007 aa30          	or	a,#48
  56  0009 c75007        	ld	20487,a
  57                     ; 8 	GPIOB->CR1 |= (1 << 5)|(1<<4); // 0x00100000 PB5 is now pushpull
  59  000c c65008        	ld	a,20488
  60  000f aa30          	or	a,#48
  61  0011 c75008        	ld	20488,a
  62                     ; 9 }
  65  0014 81            	ret
  78                     	xdef	_gb_bled_conf
  97                     	end
