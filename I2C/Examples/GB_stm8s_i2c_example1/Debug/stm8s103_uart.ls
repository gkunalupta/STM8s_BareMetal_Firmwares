   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  42                     ; 5 void uart1_pin_conf(void)
  42                     ; 6 {
  44                     	switch	.text
  45  0000               _uart1_pin_conf:
  49                     ; 10 	GPIOD-> DDR |= (1<<5);
  51  0000 721a5011      	bset	20497,#5
  52                     ; 11 	GPIOD-> CR1 |= ((1<<5));
  54  0004 721a5012      	bset	20498,#5
  55                     ; 15 }
  58  0008 81            	ret
  81                     ; 16 void uart1_baud(void)
  81                     ; 17 {
  82                     	switch	.text
  83  0009               _uart1_baud:
  87                     ; 18 	UART1 ->BRR2 = 0x0C;
  89  0009 350c5233      	mov	21043,#12
  90                     ; 19 	UART1 ->BRR1 = 0x0C;
  92  000d 350c5232      	mov	21042,#12
  93                     ; 20 }
  96  0011 81            	ret
  99                     	bsct
 100  0000               _tmp:
 101  0000 00            	dc.b	0
 125                     ; 23 void uart_init(void)
 125                     ; 24 {
 126                     	switch	.text
 127  0012               _uart_init:
 131                     ; 26 	 uart1_pin_conf();
 133  0012 adec          	call	_uart1_pin_conf
 135                     ; 34 	tmp	 = UART1->SR;
 137  0014 5552300000    	mov	_tmp,21040
 138                     ; 35   UART1->DR = tmp;
 140  0019 5500005231    	mov	21041,_tmp
 141                     ; 44 	UART1_SR_RESET_VALUE;
 143                     ; 45 	UART1_CR1_RESET_VALUE;
 145                     ; 46 	UART1_CR2_RESET_VALUE;
 147                     ; 47 	UART1_CR3_RESET_VALUE;
 149                     ; 48 	UART1_BRR2_RESET_VALUE;
 151                     ; 49 	UART1_BRR1_RESET_VALUE;
 153                     ; 53 	uart1_baud();
 155  001e ade9          	call	_uart1_baud
 157                     ; 55 	UART1-> CR2 |= ((1<<3)|(1<<2));
 159  0020 c65235        	ld	a,21045
 160  0023 aa0c          	or	a,#12
 161  0025 c75235        	ld	21045,a
 162                     ; 57 	UART1-> CR2 |= (1<<2);
 164  0028 72145235      	bset	21045,#2
 165                     ; 59 }
 168  002c 81            	ret
 202                     ; 60 void uart_tran_byte(uint8_t byte)    // single byte transmit
 202                     ; 61 {
 203                     	switch	.text
 204  002d               _uart_tran_byte:
 206  002d 88            	push	a
 207       00000000      OFST:	set	0
 210  002e               L16:
 211                     ; 64   while(!(UART1->SR & UART1_SR_TXE));
 213  002e c65230        	ld	a,21040
 214  0031 a580          	bcp	a,#128
 215  0033 27f9          	jreq	L16
 216                     ; 65 	UART1->DR = byte;
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
 267                     ; 70 void uart_tran_string(const uint8_t *myString) // string transmit
 267                     ; 71 {
 268                     	switch	.text
 269  0043               _uart_tran_string:
 271  0043 89            	pushw	x
 272       00000000      OFST:	set	0
 275  0044 200d          	jra	L511
 276  0046               L311:
 277                     ; 74 	uart_tran_byte(*myString++);
 279  0046 1e01          	ldw	x,(OFST+1,sp)
 280  0048 1c0001        	addw	x,#1
 281  004b 1f01          	ldw	(OFST+1,sp),x
 282  004d 1d0001        	subw	x,#1
 283  0050 f6            	ld	a,(x)
 284  0051 adda          	call	_uart_tran_byte
 286  0053               L511:
 287                     ; 72 while (*myString)
 289  0053 1e01          	ldw	x,(OFST+1,sp)
 290  0055 7d            	tnz	(x)
 291  0056 26ee          	jrne	L311
 292                     ; 76 }
 295  0058 85            	popw	x
 296  0059 81            	ret
 340                     ; 77 void uart_tran_bin_byte(uint8_t val)    // binary byte transmit
 340                     ; 78 {
 341                     	switch	.text
 342  005a               _uart_tran_bin_byte:
 344  005a 88            	push	a
 345  005b 5203          	subw	sp,#3
 346       00000003      OFST:	set	3
 349                     ; 80 	for(ptr=7;ptr>=0;ptr--)
 351  005d a607          	ld	a,#7
 352  005f 6b03          	ld	(OFST+0,sp),a
 354  0061               L341:
 355                     ; 82 		if ((val & (1<<ptr))==0)
 357  0061 7b04          	ld	a,(OFST+1,sp)
 358  0063 5f            	clrw	x
 359  0064 97            	ld	xl,a
 360  0065 1f01          	ldw	(OFST-2,sp),x
 362  0067 ae0001        	ldw	x,#1
 363  006a 7b03          	ld	a,(OFST+0,sp)
 364  006c 4d            	tnz	a
 365  006d 2704          	jreq	L02
 366  006f               L22:
 367  006f 58            	sllw	x
 368  0070 4a            	dec	a
 369  0071 26fc          	jrne	L22
 370  0073               L02:
 371  0073 01            	rrwa	x,a
 372  0074 1402          	and	a,(OFST-1,sp)
 373  0076 01            	rrwa	x,a
 374  0077 1401          	and	a,(OFST-2,sp)
 375  0079 01            	rrwa	x,a
 376  007a a30000        	cpw	x,#0
 377  007d 2606          	jrne	L151
 378                     ; 84 			uart_tran_byte('0');
 380  007f a630          	ld	a,#48
 381  0081 adaa          	call	_uart_tran_byte
 384  0083 2004          	jra	L351
 385  0085               L151:
 386                     ; 88 		  uart_tran_byte('1');
 388  0085 a631          	ld	a,#49
 389  0087 ada4          	call	_uart_tran_byte
 391  0089               L351:
 392                     ; 80 	for(ptr=7;ptr>=0;ptr--)
 394  0089 0a03          	dec	(OFST+0,sp)
 398  008b 9c            	rvf
 399  008c 7b03          	ld	a,(OFST+0,sp)
 400  008e a100          	cp	a,#0
 401  0090 2ecf          	jrsge	L341
 402                     ; 91 }
 405  0092 5b04          	addw	sp,#4
 406  0094 81            	ret
 460                     ; 92 void uart_tran_dec(uint8_t val)               // decimel transmit
 460                     ; 93 {
 461                     	switch	.text
 462  0095               _uart_tran_dec:
 464  0095 88            	push	a
 465  0096 5208          	subw	sp,#8
 466       00000008      OFST:	set	8
 469                     ; 96 	for(ptr=0;ptr<5;++ptr) 
 471  0098 0f08          	clr	(OFST+0,sp)
 473  009a               L302:
 474                     ; 98 		buf[ptr] = (val % 10) + '0';
 476  009a 96            	ldw	x,sp
 477  009b 1c0003        	addw	x,#OFST-5
 478  009e 1f01          	ldw	(OFST-7,sp),x
 480  00a0 7b08          	ld	a,(OFST+0,sp)
 481  00a2 5f            	clrw	x
 482  00a3 4d            	tnz	a
 483  00a4 2a01          	jrpl	L62
 484  00a6 53            	cplw	x
 485  00a7               L62:
 486  00a7 97            	ld	xl,a
 487  00a8 72fb01        	addw	x,(OFST-7,sp)
 488  00ab 7b09          	ld	a,(OFST+1,sp)
 489  00ad 905f          	clrw	y
 490  00af 9097          	ld	yl,a
 491  00b1 a60a          	ld	a,#10
 492  00b3 9062          	div	y,a
 493  00b5 905f          	clrw	y
 494  00b7 9097          	ld	yl,a
 495  00b9 909f          	ld	a,yl
 496  00bb ab30          	add	a,#48
 497  00bd f7            	ld	(x),a
 498                     ; 99 		val /= 10;
 500  00be 7b09          	ld	a,(OFST+1,sp)
 501  00c0 5f            	clrw	x
 502  00c1 97            	ld	xl,a
 503  00c2 a60a          	ld	a,#10
 504  00c4 62            	div	x,a
 505  00c5 01            	rrwa	x,a
 506  00c6 6b09          	ld	(OFST+1,sp),a
 507  00c8 02            	rlwa	x,a
 508                     ; 96 	for(ptr=0;ptr<5;++ptr) 
 510  00c9 0c08          	inc	(OFST+0,sp)
 514  00cb 9c            	rvf
 515  00cc 7b08          	ld	a,(OFST+0,sp)
 516  00ce a105          	cp	a,#5
 517  00d0 2fc8          	jrslt	L302
 518                     ; 101 	for(ptr=4;ptr>0;--ptr) 
 520  00d2 a604          	ld	a,#4
 521  00d4 6b08          	ld	(OFST+0,sp),a
 523  00d6               L112:
 524                     ; 103 		if (buf[ptr] != '0')
 526  00d6 96            	ldw	x,sp
 527  00d7 1c0003        	addw	x,#OFST-5
 528  00da 1f01          	ldw	(OFST-7,sp),x
 530  00dc 7b08          	ld	a,(OFST+0,sp)
 531  00de 5f            	clrw	x
 532  00df 4d            	tnz	a
 533  00e0 2a01          	jrpl	L03
 534  00e2 53            	cplw	x
 535  00e3               L03:
 536  00e3 97            	ld	xl,a
 537  00e4 72fb01        	addw	x,(OFST-7,sp)
 538  00e7 f6            	ld	a,(x)
 539  00e8 a130          	cp	a,#48
 540  00ea 2622          	jrne	L522
 541                     ; 104 		break;
 543                     ; 101 	for(ptr=4;ptr>0;--ptr) 
 545  00ec 0a08          	dec	(OFST+0,sp)
 549  00ee 9c            	rvf
 550  00ef 7b08          	ld	a,(OFST+0,sp)
 551  00f1 a100          	cp	a,#0
 552  00f3 2ce1          	jrsgt	L112
 553  00f5 2017          	jra	L522
 554  00f7               L122:
 555                     ; 108 		uart_tran_byte(buf[ptr]);
 557  00f7 96            	ldw	x,sp
 558  00f8 1c0003        	addw	x,#OFST-5
 559  00fb 1f01          	ldw	(OFST-7,sp),x
 561  00fd 7b08          	ld	a,(OFST+0,sp)
 562  00ff 5f            	clrw	x
 563  0100 4d            	tnz	a
 564  0101 2a01          	jrpl	L23
 565  0103 53            	cplw	x
 566  0104               L23:
 567  0104 97            	ld	xl,a
 568  0105 72fb01        	addw	x,(OFST-7,sp)
 569  0108 f6            	ld	a,(x)
 570  0109 cd002d        	call	_uart_tran_byte
 572                     ; 106 	for(;ptr>=0;--ptr) 
 574  010c 0a08          	dec	(OFST+0,sp)
 576  010e               L522:
 579  010e 9c            	rvf
 580  010f 7b08          	ld	a,(OFST+0,sp)
 581  0111 a100          	cp	a,#0
 582  0113 2ee2          	jrsge	L122
 583                     ; 110 }
 586  0115 5b09          	addw	sp,#9
 587  0117 81            	ret
 610                     ; 111 char uart_receive_byte()
 610                     ; 112 {
 611                     	switch	.text
 612  0118               _uart_receive_byte:
 616  0118               L342:
 617                     ; 113 	while(!(UART1->SR & UART1_SR_RXNE)); //  Block until char rec'd
 619  0118 c65230        	ld	a,21040
 620  011b a520          	bcp	a,#32
 621  011d 27f9          	jreq	L342
 622                     ; 114 	return  UART1->DR;
 624  011f c65231        	ld	a,21041
 627  0122 81            	ret
 651                     	xdef	_tmp
 652                     	xdef	_uart_receive_byte
 653                     	xdef	_uart_tran_dec
 654                     	xdef	_uart_tran_bin_byte
 655                     	xdef	_uart_tran_string
 656                     	xdef	_uart_tran_byte
 657                     	xdef	_uart_init
 658                     	xdef	_uart1_baud
 659                     	xdef	_uart1_pin_conf
 678                     	end
