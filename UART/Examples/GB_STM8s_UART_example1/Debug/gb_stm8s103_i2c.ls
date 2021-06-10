   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  42                     ; 6 void gb_i2c_master_init()
  42                     ; 7 {
  44                     	switch	.text
  45  0000               _gb_i2c_master_init:
  49                     ; 12 	I2C ->FREQR=0x02; // Input clock frequency = 2MHZ
  51  0000 35025212      	mov	21010,#2
  52                     ; 14 	I2C ->CCRH=0x00;   // selecting the core clock frequency as 50Khz
  54  0004 725f521c      	clr	21020
  55                     ; 15 	I2C ->CCRL=0x14;   //
  57  0008 3514521b      	mov	21019,#20
  58                     ; 17 	I2C ->TRISER=0x03; // Rise time calculated for 50KHZ at 2MHZ is 3
  60  000c 3503521d      	mov	21021,#3
  61                     ; 20 	I2C ->CR1|= I2C_CR1_PE; //enable the i2c peripheral
  63  0010 72105210      	bset	21008,#0
  64                     ; 22 }
  67  0014 81            	ret
  92                     ; 24 void gb_i2c_start_condition_w(void)
  92                     ; 25 {
  93                     	switch	.text
  94  0015               _gb_i2c_start_condition_w:
  98                     ; 26 	gb_read_reg = I2C->SR1;
 100  0015 5552170000    	mov	_gb_read_reg,21015
 101                     ; 27 	gb_read_reg = I2C->SR3;
 103  001a 5552190000    	mov	_gb_read_reg,21017
 104                     ; 29 	I2C ->CR2 =I2C_CR2_START;
 106  001f 35015211      	mov	21009,#1
 108  0023               L53:
 109                     ; 30 	while(!(I2C ->SR1 & I2C_SR1_SB));
 111  0023 c65217        	ld	a,21015
 112  0026 a501          	bcp	a,#1
 113  0028 27f9          	jreq	L53
 114                     ; 31 	gb_read_reg = I2C->SR1;
 116  002a 5552170000    	mov	_gb_read_reg,21015
 117                     ; 32 	gb_read_reg = I2C->SR3;
 119  002f 5552190000    	mov	_gb_read_reg,21017
 120                     ; 34 }
 123  0034 81            	ret
 148                     ; 36 void gb_i2c_start_condition_r(void)
 148                     ; 37 {
 149                     	switch	.text
 150  0035               _gb_i2c_start_condition_r:
 154                     ; 38 	I2C->CR2 |= I2C_CR2_ACK;
 156  0035 72145211      	bset	21009,#2
 157                     ; 39 	I2C ->CR2 |=I2C_CR2_START;
 159  0039 72105211      	bset	21009,#0
 161  003d               L35:
 162                     ; 40 	while(!(I2C ->SR1 & I2C_SR1_SB));
 164  003d c65217        	ld	a,21015
 165  0040 a501          	bcp	a,#1
 166  0042 27f9          	jreq	L35
 167                     ; 41 	gb_read_reg = I2C->SR1;
 169  0044 5552170000    	mov	_gb_read_reg,21015
 170                     ; 43 }
 173  0049 81            	ret
 209                     ; 45 void gb_i2c_address_send_w(uint8_t gb_slave_address)
 209                     ; 46 {
 210                     	switch	.text
 211  004a               _gb_i2c_address_send_w:
 215                     ; 47 	I2C ->DR = gb_slave_address; //Write Slave address
 217  004a c75216        	ld	21014,a
 219  004d               L101:
 220                     ; 49 	while(!(I2C ->SR1 & I2C_SR1_TXE));
 222  004d c65217        	ld	a,21015
 223  0050 a580          	bcp	a,#128
 224  0052 27f9          	jreq	L101
 225                     ; 52 	gb_read_reg = I2C->SR1;
 227  0054 5552170000    	mov	_gb_read_reg,21015
 228                     ; 53 	gb_read_reg = I2C->SR3;
 230  0059 5552190000    	mov	_gb_read_reg,21017
 231                     ; 55 }
 234  005e 81            	ret
 270                     ; 57 int gb_i2c_address_send_r(uint8_t gb_slave_address)
 270                     ; 58 {
 271                     	switch	.text
 272  005f               _gb_i2c_address_send_r:
 276                     ; 59 	I2C->DR = gb_slave_address;
 278  005f c75216        	ld	21014,a
 280  0062 200b          	jra	L721
 281  0064               L321:
 282                     ; 63 		if((I2C->SR1 & I2C_SR2_AF) == 1)
 284  0064 c65217        	ld	a,21015
 285  0067 a404          	and	a,#4
 286  0069 a101          	cp	a,#1
 287  006b 2602          	jrne	L721
 288                     ; 65 			return 0;
 290  006d 5f            	clrw	x
 293  006e 81            	ret
 294  006f               L721:
 295                     ; 61 	while(!(I2C->SR1 & I2C_SR1_ADDR))
 297  006f c65217        	ld	a,21015
 298  0072 a502          	bcp	a,#2
 299  0074 27ee          	jreq	L321
 300                     ; 68 	gb_read_reg = I2C->SR1;
 302  0076 5552170000    	mov	_gb_read_reg,21015
 303                     ; 69 	gb_read_reg = I2C->SR3;
 305  007b 5552190000    	mov	_gb_read_reg,21017
 306                     ; 71 }
 309  0080 81            	ret
 344                     ; 73 uint8_t gb_single_byte_receive()
 344                     ; 74 {
 345                     	switch	.text
 346  0081               _gb_single_byte_receive:
 348  0081 88            	push	a
 349       00000001      OFST:	set	1
 352                     ; 76 	I2C->CR2 &= ~I2C_CR2_ACK;
 354  0082 72155211      	bres	21009,#2
 355                     ; 78 	I2C->CR2 |= I2C_CR2_STOP;
 357  0086 72125211      	bset	21009,#1
 359  008a               L551:
 360                     ; 80 	while(!(I2C->SR1 & I2C_SR1_RXNE));
 362  008a c65217        	ld	a,21015
 363  008d a540          	bcp	a,#64
 364  008f 27f9          	jreq	L551
 365                     ; 81 	data = I2C->DR;
 367  0091 c65216        	ld	a,21014
 368  0094 6b01          	ld	(OFST+0,sp),a
 370                     ; 83 	return data;
 372  0096 7b01          	ld	a,(OFST+0,sp)
 375  0098 5b01          	addw	sp,#1
 376  009a 81            	ret
 419                     ; 87 void gb_2byte_receive(uint8_t data1, uint8_t data2)
 419                     ; 88 {
 420                     	switch	.text
 421  009b               _gb_2byte_receive:
 423  009b 89            	pushw	x
 424       00000000      OFST:	set	0
 427                     ; 89 	I2C ->CR2 |= I2C_CR2_POS;
 429  009c 72165211      	bset	21009,#3
 430                     ; 91 	I2C ->CR2 &= ~I2C_CR2_ACK;
 432  00a0 72155211      	bres	21009,#2
 434  00a4               L502:
 435                     ; 93 	while(!(I2C ->SR1 & I2C_SR1_BTF));
 437  00a4 c65217        	ld	a,21015
 438  00a7 a504          	bcp	a,#4
 439  00a9 27f9          	jreq	L502
 440                     ; 94 	I2C->CR2 |= I2C_CR2_STOP;
 442  00ab 72125211      	bset	21009,#1
 443                     ; 96 	data1 =I2C->DR;
 445  00af c65216        	ld	a,21014
 446  00b2 6b01          	ld	(OFST+1,sp),a
 447                     ; 97 	data2 =I2C->DR;
 449  00b4 c65216        	ld	a,21014
 450  00b7 6b02          	ld	(OFST+2,sp),a
 451                     ; 99 }
 454  00b9 85            	popw	x
 455  00ba 81            	ret
 490                     ; 101 void gb_i2c_databyte_send(uint8_t gb_i2c_data)
 490                     ; 102 {
 491                     	switch	.text
 492  00bb               _gb_i2c_databyte_send:
 496                     ; 103 	I2C->DR = gb_i2c_data;
 498  00bb c75216        	ld	21014,a
 500  00be               L332:
 501                     ; 104 	while(!(I2C ->SR1 & I2C_SR1_TXE));
 503  00be c65217        	ld	a,21015
 504  00c1 a580          	bcp	a,#128
 505  00c3 27f9          	jreq	L332
 506                     ; 105 }
 509  00c5 81            	ret
 533                     ; 107 void gb_i2c_stop_generation()
 533                     ; 108 {
 534                     	switch	.text
 535  00c6               _gb_i2c_stop_generation:
 539                     ; 109 	I2C ->CR2 |=I2C_CR2_STOP;
 541  00c6 72125211      	bset	21009,#1
 542                     ; 110 }
 545  00ca 81            	ret
 569                     	switch	.ubsct
 570  0000               _gb_read_reg:
 571  0000 00            	ds.b	1
 572                     	xdef	_gb_read_reg
 573                     	xdef	_gb_i2c_stop_generation
 574                     	xdef	_gb_2byte_receive
 575                     	xdef	_gb_single_byte_receive
 576                     	xdef	_gb_i2c_databyte_send
 577                     	xdef	_gb_i2c_address_send_r
 578                     	xdef	_gb_i2c_address_send_w
 579                     	xdef	_gb_i2c_start_condition_r
 580                     	xdef	_gb_i2c_start_condition_w
 581                     	xdef	_gb_i2c_master_init
 601                     	end
