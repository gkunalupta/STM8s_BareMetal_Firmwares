   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  42                     ; 5 void gb_spi_pin_config(void)
  42                     ; 6 {
  44                     	switch	.text
  45  0000               _gb_spi_pin_config:
  49                     ; 10 	GPIOC-> DDR |= (1<<6);
  51  0000 721c500c      	bset	20492,#6
  52                     ; 11 	GPIOC-> CR1 |= ((1<<6));
  54  0004 721c500d      	bset	20493,#6
  55                     ; 14 	GPIOC-> DDR |= (1<<5);
  57  0008 721a500c      	bset	20492,#5
  58                     ; 15 	GPIOC-> CR1 |= ((1<<5));
  60  000c 721a500d      	bset	20493,#5
  61                     ; 18 	GPIOA-> DDR |= (1<<3);
  63  0010 72165002      	bset	20482,#3
  64                     ; 19 	GPIOA-> CR1 |= ((1<<3));
  66  0014 72165003      	bset	20483,#3
  67                     ; 22 	GPIOC-> DDR &= ~(1<<5);
  69  0018 721b500c      	bres	20492,#5
  70                     ; 23 	GPIOC-> CR1 &= ~((1<<5));
  72  001c 721b500d      	bres	20493,#5
  73                     ; 25 }
  76  0020 81            	ret
 100                     ; 28 void gb_spi_ma_init(void)
 100                     ; 29 
 100                     ; 30 {
 101                     	switch	.text
 102  0021               _gb_spi_ma_init:
 106                     ; 32 	gb_spi_pin_config();
 108  0021 addd          	call	_gb_spi_pin_config
 110                     ; 35 	SPI ->CR1 &= ~(SPI_CR1_BR);
 112  0023 c65200        	ld	a,20992
 113  0026 a4c7          	and	a,#199
 114  0028 c75200        	ld	20992,a
 115                     ; 38 	SPI ->CR1 &= ~(SPI_CR1_CPOL | SPI_CR1_CPHA);
 117  002b c65200        	ld	a,20992
 118  002e a4fc          	and	a,#252
 119  0030 c75200        	ld	20992,a
 120                     ; 43 	SPI ->CR2 &= ~(SPI_CR2_SSM);
 122  0033 72135201      	bres	20993,#1
 123                     ; 46 	SPI ->CR1|= (SPI_CR1_MSTR);
 125  0037 72145200      	bset	20992,#2
 126                     ; 49 	SPI ->CR1|= SPI_CR1_SPE;
 128  003b 721c5200      	bset	20992,#6
 129                     ; 50 }
 132  003f 81            	ret
 167                     ; 52 void gb_spi_mast_tran_byte(uint8_t gb_data)
 167                     ; 53 {
 168                     	switch	.text
 169  0040               _gb_spi_mast_tran_byte:
 173                     ; 54 	SPI ->DR = gb_data;
 175  0040 c75204        	ld	20996,a
 177  0043               L35:
 178                     ; 55 	while(!(SPI ->SR & SPI_SR_TXE));
 180  0043 c65203        	ld	a,20995
 181  0046 a502          	bcp	a,#2
 182  0048 27f9          	jreq	L35
 184  004a               L16:
 185                     ; 56 	while((SPI ->SR & SPI_SR_BSY));
 187  004a c65203        	ld	a,20995
 188  004d a580          	bcp	a,#128
 189  004f 26f9          	jrne	L16
 190                     ; 57 }
 193  0051 81            	ret
 228                     ; 59 uint8_t gb_spi_mast_rec_byte(void)
 228                     ; 60 {
 229                     	switch	.text
 230  0052               _gb_spi_mast_rec_byte:
 232  0052 88            	push	a
 233       00000001      OFST:	set	1
 236                     ; 61 	uint8_t gb_recv_data = 0;
 238  0053 0f01          	clr	(OFST+0,sp)
 240                     ; 62 	SPI ->DR = 0xff;
 242  0055 35ff5204      	mov	20996,#255
 244  0059               L701:
 245                     ; 63 	while((SPI ->SR & SPI_SR_BSY));
 247  0059 c65203        	ld	a,20995
 248  005c a580          	bcp	a,#128
 249  005e 26f9          	jrne	L701
 251  0060 2005          	jra	L511
 252  0062               L311:
 253                     ; 65 	gb_recv_data = SPI ->DR;
 255  0062 c65204        	ld	a,20996
 256  0065 6b01          	ld	(OFST+0,sp),a
 258  0067               L511:
 259                     ; 64 	while((SPI ->SR & SPI_SR_RXNE))
 261  0067 c65203        	ld	a,20995
 262  006a a501          	bcp	a,#1
 263  006c 26f4          	jrne	L311
 264                     ; 66 	return gb_recv_data;
 266  006e 7b01          	ld	a,(OFST+0,sp)
 269  0070 5b01          	addw	sp,#1
 270  0072 81            	ret
 283                     	xdef	_gb_spi_mast_rec_byte
 284                     	xdef	_gb_spi_mast_tran_byte
 285                     	xdef	_gb_spi_ma_init
 286                     	xdef	_gb_spi_pin_config
 305                     	end
