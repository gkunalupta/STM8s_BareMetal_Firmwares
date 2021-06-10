   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  48                     ; 14 main()
  48                     ; 15 {
  50                     	switch	.text
  51  0000               _main:
  55                     ; 16 	gb_timer_init();
  57  0000 cd0000        	call	_gb_timer_init
  59                     ; 17 	gb_uart_init();
  61  0003 cd0000        	call	_gb_uart_init
  63                     ; 18 	gb_spi_ma_init();
  65  0006 cd0000        	call	_gb_spi_ma_init
  67  0009               L12:
  68                     ; 22 		gb_delay_ms(10);
  70  0009 ae000a        	ldw	x,#10
  71  000c cd0000        	call	_gb_delay_ms
  73                     ; 24 		GPIOA ->ODR&= ~(1<<3);
  75  000f 72175000      	bres	20480,#3
  76                     ; 25 		gb_spi_mast_tran_byte(0x90);
  78  0013 a690          	ld	a,#144
  79  0015 cd0000        	call	_gb_spi_mast_tran_byte
  81                     ; 26 		gb_spi_mast_rec_byte();
  83  0018 cd0000        	call	_gb_spi_mast_rec_byte
  85                     ; 27 		gb_spi_mast_rec_byte();
  87  001b cd0000        	call	_gb_spi_mast_rec_byte
  89                     ; 28 		gb_spi_mast_rec_byte();
  91  001e cd0000        	call	_gb_spi_mast_rec_byte
  93                     ; 29 		gb_spi_mast_rec_byte();
  95  0021 cd0000        	call	_gb_spi_mast_rec_byte
  97                     ; 30 		gb_spi_mast_rec_byte();
  99  0024 cd0000        	call	_gb_spi_mast_rec_byte
 101                     ; 32 		GPIOA ->ODR= (1<<3);
 103  0027 35085000      	mov	20480,#8
 104                     ; 33 		gb_delay_ms(100);
 106  002b ae0064        	ldw	x,#100
 107  002e cd0000        	call	_gb_delay_ms
 110  0031 20d6          	jra	L12
 123                     	xdef	_main
 124                     	xref	_gb_spi_mast_rec_byte
 125                     	xref	_gb_spi_mast_tran_byte
 126                     	xref	_gb_spi_ma_init
 127                     	xref	_gb_uart_init
 128                     	xref	_gb_delay_ms
 129                     	xref	_gb_timer_init
 148                     	end
