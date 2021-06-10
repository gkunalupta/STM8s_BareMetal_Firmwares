   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  42                     ; 5 void gb_uart1_pin_conf(void)
  42                     ; 6 {
  44                     	switch	.text
  45  0000               _gb_uart1_pin_conf:
  49                     ; 10 	GPIOD-> DDR |= (1<<5);
  51  0000 721a5011      	bset	20497,#5
  52                     ; 11 	GPIOD-> CR1 |= ((1<<5));
  54  0004 721a5012      	bset	20498,#5
  55                     ; 15 }
  58  0008 81            	ret
  81                     ; 16 void gb_uart1_baud(void)
  81                     ; 17 {
  82                     	switch	.text
  83  0009               _gb_uart1_baud:
  87                     ; 18 	UART1 ->BRR2 = 0x0C;
  89  0009 350c5233      	mov	21043,#12
  90                     ; 19 	UART1 ->BRR1 = 0x0C;
  92  000d 350c5232      	mov	21042,#12
  93                     ; 20 }
  96  0011 81            	ret
  99                     	bsct
 100  0000               _gb_tmp:
 101  0000 00            	dc.b	0
 125                     ; 23 void gb_uart_init(void)
 125                     ; 24 {
 126                     	switch	.text
 127  0012               _gb_uart_init:
 131                     ; 26 	 gb_uart1_pin_conf();
 133  0012 adec          	call	_gb_uart1_pin_conf
 135                     ; 34 	gb_tmp	 = UART1->SR;
 137  0014 5552300000    	mov	_gb_tmp,21040
 138                     ; 35   UART1->DR = gb_tmp;
 140  0019 5500005231    	mov	21041,_gb_tmp
 141                     ; 44 	UART1_SR_RESET_VALUE;
 143                     ; 45 	UART1_CR1_RESET_VALUE;
 145                     ; 46 	UART1_CR2_RESET_VALUE;
 147                     ; 47 	UART1_CR3_RESET_VALUE;
 149                     ; 48 	UART1_BRR2_RESET_VALUE;
 151                     ; 49 	UART1_BRR1_RESET_VALUE;
 153                     ; 53 	gb_uart1_baud();
 155  001e ade9          	call	_gb_uart1_baud
 157                     ; 55 	UART1-> CR2 |= ((1<<3)|(1<<2));
 159  0020 c65235        	ld	a,21045
 160  0023 aa0c          	or	a,#12
 161  0025 c75235        	ld	21045,a
 162                     ; 57 	UART1-> CR2 |= (1<<2);
 164  0028 72145235      	bset	21045,#2
 165                     ; 59 }
 168  002c 81            	ret
 202                     ; 60 void gb_uart_tran_byte(uint8_t gb_byte)    // single byte transmit
 202                     ; 61 {
 203                     	switch	.text
 204  002d               _gb_uart_tran_byte:
 206  002d 88            	push	a
 207       00000000      OFST:	set	0
 210  002e               L16:
 211                     ; 64   while(!(UART1->SR & UART1_SR_TXE));
 213  002e c65230        	ld	a,21040
 214  0031 a580          	bcp	a,#128
 215  0033 27f9          	jreq	L16
 216                     ; 65 	UART1->DR = gb_byte;
 218  0035 7b01          	ld	a,(OFST+1,sp)
 219  0037 c75231        	ld	21041,a
 221  003a               L17:
 222                     ; 66 	while(!(UART1->SR & UART1_SR_TC));
 224  003a c65230        	ld	a,21040
 225  003d a540          	bcp	a,#64
 226  003f 27f9          	jreq	L17
 227                     ; 69 }
 230  0041 84            	pop	a
 231  0042 81            	ret
 268                     ; 70 void gb_uart_tran_string(const uint8_t *gb_myString) // string transmit
 268                     ; 71 {
 269                     	switch	.text
 270  0043               _gb_uart_tran_string:
 272  0043 89            	pushw	x
 273       00000000      OFST:	set	0
 276  0044 200d          	jra	L511
 277  0046               L311:
 278                     ; 74 	gb_uart_tran_byte(*gb_myString++);
 280  0046 1e01          	ldw	x,(OFST+1,sp)
 281  0048 1c0001        	addw	x,#1
 282  004b 1f01          	ldw	(OFST+1,sp),x
 283  004d 1d0001        	subw	x,#1
 284  0050 f6            	ld	a,(x)
 285  0051 adda          	call	_gb_uart_tran_byte
 287  0053               L511:
 288                     ; 72 while (*gb_myString)
 290  0053 1e01          	ldw	x,(OFST+1,sp)
 291  0055 7d            	tnz	(x)
 292  0056 26ee          	jrne	L311
 293                     ; 76 }
 296  0058 85            	popw	x
 297  0059 81            	ret
 342                     ; 77 void gb_uart_tran_bin_byte(uint8_t gb_val)    // binary byte transmit
 342                     ; 78 {
 343                     	switch	.text
 344  005a               _gb_uart_tran_bin_byte:
 346  005a 88            	push	a
 347  005b 5203          	subw	sp,#3
 348       00000003      OFST:	set	3
 351                     ; 80 	for(gb_ptr=7;gb_ptr>=0;gb_ptr--)
 353  005d a607          	ld	a,#7
 354  005f 6b03          	ld	(OFST+0,sp),a
 356  0061               L341:
 357                     ; 82 		if ((gb_val & (1<<gb_ptr))==0)
 359  0061 7b04          	ld	a,(OFST+1,sp)
 360  0063 5f            	clrw	x
 361  0064 97            	ld	xl,a
 362  0065 1f01          	ldw	(OFST-2,sp),x
 364  0067 ae0001        	ldw	x,#1
 365  006a 7b03          	ld	a,(OFST+0,sp)
 366  006c 4d            	tnz	a
 367  006d 2704          	jreq	L02
 368  006f               L22:
 369  006f 58            	sllw	x
 370  0070 4a            	dec	a
 371  0071 26fc          	jrne	L22
 372  0073               L02:
 373  0073 01            	rrwa	x,a
 374  0074 1402          	and	a,(OFST-1,sp)
 375  0076 01            	rrwa	x,a
 376  0077 1401          	and	a,(OFST-2,sp)
 377  0079 01            	rrwa	x,a
 378  007a a30000        	cpw	x,#0
 379  007d 2606          	jrne	L151
 380                     ; 84 			gb_uart_tran_byte('0');
 382  007f a630          	ld	a,#48
 383  0081 adaa          	call	_gb_uart_tran_byte
 386  0083 2004          	jra	L351
 387  0085               L151:
 388                     ; 88 		  gb_uart_tran_byte('1');
 390  0085 a631          	ld	a,#49
 391  0087 ada4          	call	_gb_uart_tran_byte
 393  0089               L351:
 394                     ; 80 	for(gb_ptr=7;gb_ptr>=0;gb_ptr--)
 396  0089 0a03          	dec	(OFST+0,sp)
 400  008b 9c            	rvf
 401  008c 7b03          	ld	a,(OFST+0,sp)
 402  008e a100          	cp	a,#0
 403  0090 2ecf          	jrsge	L341
 404                     ; 91 }
 407  0092 5b04          	addw	sp,#4
 408  0094 81            	ret
 462                     ; 92 void gb_uart_tran_dec(uint8_t gb_val)               // decimel transmit
 462                     ; 93 {
 463                     	switch	.text
 464  0095               _gb_uart_tran_dec:
 466  0095 88            	push	a
 467  0096 5208          	subw	sp,#8
 468       00000008      OFST:	set	8
 471                     ; 96 	for(gb_ptr=0;gb_ptr<5;++gb_ptr) 
 473  0098 0f08          	clr	(OFST+0,sp)
 475  009a               L302:
 476                     ; 98 		gb_buf[gb_ptr] = (gb_val % 10) + '0';
 478  009a 96            	ldw	x,sp
 479  009b 1c0003        	addw	x,#OFST-5
 480  009e 1f01          	ldw	(OFST-7,sp),x
 482  00a0 7b08          	ld	a,(OFST+0,sp)
 483  00a2 5f            	clrw	x
 484  00a3 4d            	tnz	a
 485  00a4 2a01          	jrpl	L62
 486  00a6 53            	cplw	x
 487  00a7               L62:
 488  00a7 97            	ld	xl,a
 489  00a8 72fb01        	addw	x,(OFST-7,sp)
 490  00ab 7b09          	ld	a,(OFST+1,sp)
 491  00ad 905f          	clrw	y
 492  00af 9097          	ld	yl,a
 493  00b1 a60a          	ld	a,#10
 494  00b3 9062          	div	y,a
 495  00b5 905f          	clrw	y
 496  00b7 9097          	ld	yl,a
 497  00b9 909f          	ld	a,yl
 498  00bb ab30          	add	a,#48
 499  00bd f7            	ld	(x),a
 500                     ; 99 		gb_val /= 10;
 502  00be 7b09          	ld	a,(OFST+1,sp)
 503  00c0 5f            	clrw	x
 504  00c1 97            	ld	xl,a
 505  00c2 a60a          	ld	a,#10
 506  00c4 62            	div	x,a
 507  00c5 01            	rrwa	x,a
 508  00c6 6b09          	ld	(OFST+1,sp),a
 509  00c8 02            	rlwa	x,a
 510                     ; 96 	for(gb_ptr=0;gb_ptr<5;++gb_ptr) 
 512  00c9 0c08          	inc	(OFST+0,sp)
 516  00cb 9c            	rvf
 517  00cc 7b08          	ld	a,(OFST+0,sp)
 518  00ce a105          	cp	a,#5
 519  00d0 2fc8          	jrslt	L302
 520                     ; 101 	for(gb_ptr=4;gb_ptr>0;--gb_ptr) 
 522  00d2 a604          	ld	a,#4
 523  00d4 6b08          	ld	(OFST+0,sp),a
 525  00d6               L112:
 526                     ; 103 		if (gb_buf[gb_ptr] != '0')
 528  00d6 96            	ldw	x,sp
 529  00d7 1c0003        	addw	x,#OFST-5
 530  00da 1f01          	ldw	(OFST-7,sp),x
 532  00dc 7b08          	ld	a,(OFST+0,sp)
 533  00de 5f            	clrw	x
 534  00df 4d            	tnz	a
 535  00e0 2a01          	jrpl	L03
 536  00e2 53            	cplw	x
 537  00e3               L03:
 538  00e3 97            	ld	xl,a
 539  00e4 72fb01        	addw	x,(OFST-7,sp)
 540  00e7 f6            	ld	a,(x)
 541  00e8 a130          	cp	a,#48
 542  00ea 2622          	jrne	L522
 543                     ; 104 		break;
 545                     ; 101 	for(gb_ptr=4;gb_ptr>0;--gb_ptr) 
 547  00ec 0a08          	dec	(OFST+0,sp)
 551  00ee 9c            	rvf
 552  00ef 7b08          	ld	a,(OFST+0,sp)
 553  00f1 a100          	cp	a,#0
 554  00f3 2ce1          	jrsgt	L112
 555  00f5 2017          	jra	L522
 556  00f7               L122:
 557                     ; 108 		gb_uart_tran_byte(gb_buf[gb_ptr]);
 559  00f7 96            	ldw	x,sp
 560  00f8 1c0003        	addw	x,#OFST-5
 561  00fb 1f01          	ldw	(OFST-7,sp),x
 563  00fd 7b08          	ld	a,(OFST+0,sp)
 564  00ff 5f            	clrw	x
 565  0100 4d            	tnz	a
 566  0101 2a01          	jrpl	L23
 567  0103 53            	cplw	x
 568  0104               L23:
 569  0104 97            	ld	xl,a
 570  0105 72fb01        	addw	x,(OFST-7,sp)
 571  0108 f6            	ld	a,(x)
 572  0109 cd002d        	call	_gb_uart_tran_byte
 574                     ; 106 	for(;gb_ptr>=0;--gb_ptr) 
 576  010c 0a08          	dec	(OFST+0,sp)
 578  010e               L522:
 581  010e 9c            	rvf
 582  010f 7b08          	ld	a,(OFST+0,sp)
 583  0111 a100          	cp	a,#0
 584  0113 2ee2          	jrsge	L122
 585                     ; 110 }
 588  0115 5b09          	addw	sp,#9
 589  0117 81            	ret
 613                     ; 111 char gb_uart_receive_byte()
 613                     ; 112 {
 614                     	switch	.text
 615  0118               _gb_uart_receive_byte:
 619  0118               L342:
 620                     ; 113 	while(!(UART1->SR & UART1_SR_RXNE)); //  Block until char rec'd
 622  0118 c65230        	ld	a,21040
 623  011b a520          	bcp	a,#32
 624  011d 27f9          	jreq	L342
 625                     ; 114 	return  UART1->DR;
 627  011f c65231        	ld	a,21041
 630  0122 81            	ret
 654                     	xdef	_gb_tmp
 655                     	xdef	_gb_uart_receive_byte
 656                     	xdef	_gb_uart_tran_dec
 657                     	xdef	_gb_uart_tran_bin_byte
 658                     	xdef	_gb_uart_tran_string
 659                     	xdef	_gb_uart_tran_byte
 660                     	xdef	_gb_uart_init
 661                     	xdef	_gb_uart1_baud
 662                     	xdef	_gb_uart1_pin_conf
 681                     	end
