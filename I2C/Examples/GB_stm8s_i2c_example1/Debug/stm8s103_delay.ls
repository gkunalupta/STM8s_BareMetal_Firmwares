   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  42                     ; 4 void timer_init(void)
  42                     ; 5 {
  44                     	switch	.text
  45  0000               _timer_init:
  49                     ; 10    TIM2->EGR |= 1<<0;
  51  0000 72105306      	bset	21254,#0
  52                     ; 12     TIM2->PSCR = 1;
  54  0004 3501530e      	mov	21262,#1
  55                     ; 14     TIM2->ARRH = 0xff;
  57  0008 35ff530f      	mov	21263,#255
  58                     ; 15 		TIM2->ARRL = 0xff;
  60  000c 35ff5310      	mov	21264,#255
  61                     ; 17 	  TIM2->SR1 &= ~(1<<0);
  63  0010 72115304      	bres	21252,#0
  64                     ; 19     TIM2->CR1 |= 1<<2; //generate update at Counter overflow/underflow
  66  0014 72145300      	bset	21248,#2
  67                     ; 21     TIM2_CNTR = 00;
  69  0018 5f            	clrw	x
  70  0019 cf530c        	ldw	21260,x
  71                     ; 23      CLK->CCOR |= CLK_CCOR_CCOEN | CLK_CCOR_CCOSEL;
  73  001c c650c9        	ld	a,20681
  74  001f aa1f          	or	a,#31
  75  0021 c750c9        	ld	20681,a
  76                     ; 25 }
  79  0024 81            	ret
 122                     ; 27 void delay_us(uint16_t us)
 122                     ; 28 {
 123                     	switch	.text
 124  0025               _delay_us:
 126  0025 89            	pushw	x
 127       00000002      OFST:	set	2
 130                     ; 29 	uint16_t i = us;
 132  0026 1f01          	ldw	(OFST-1,sp),x
 134                     ; 31 TIM2_CNTR =0;
 136  0028 5f            	clrw	x
 137  0029 cf530c        	ldw	21260,x
 138                     ; 32 	TIM2->CR1 |= (1<<0);
 140  002c 72105300      	bset	21248,#0
 142  0030               L54:
 143                     ; 33 	while(TIM2_CNTR <i);
 145  0030 ce530c        	ldw	x,21260
 146  0033 1301          	cpw	x,(OFST-1,sp)
 147  0035 25f9          	jrult	L54
 148                     ; 34 	TIM2->CR1 &= ~(1<<0);
 150  0037 72115300      	bres	21248,#0
 151                     ; 37 }
 154  003b 85            	popw	x
 155  003c 81            	ret
 208                     ; 38 void delay_ms(uint16_t ms)
 208                     ; 39 { 
 209                     	switch	.text
 210  003d               _delay_ms:
 212  003d 89            	pushw	x
 213  003e 5204          	subw	sp,#4
 214       00000004      OFST:	set	4
 217                     ; 41 	uint16_t milisec = ms;
 219                     ; 43 	for(i=0; i<ms; i++)
 221  0040 5f            	clrw	x
 222  0041 1f03          	ldw	(OFST-1,sp),x
 225  0043 200c          	jra	L301
 226  0045               L77:
 227                     ; 44 	delay_us(1000);
 229  0045 ae03e8        	ldw	x,#1000
 230  0048 addb          	call	_delay_us
 232                     ; 43 	for(i=0; i<ms; i++)
 234  004a 1e03          	ldw	x,(OFST-1,sp)
 235  004c 1c0001        	addw	x,#1
 236  004f 1f03          	ldw	(OFST-1,sp),x
 238  0051               L301:
 241  0051 1e03          	ldw	x,(OFST-1,sp)
 242  0053 1305          	cpw	x,(OFST+1,sp)
 243  0055 25ee          	jrult	L77
 244                     ; 45 }
 247  0057 5b06          	addw	sp,#6
 248  0059 81            	ret
 301                     ; 46 void delay_sec(uint16_t secs)
 301                     ; 47 { 
 302                     	switch	.text
 303  005a               _delay_sec:
 305  005a 5204          	subw	sp,#4
 306       00000004      OFST:	set	4
 309                     ; 49 	uint16_t sec =secs;
 311  005c 1f01          	ldw	(OFST-3,sp),x
 313                     ; 50 	for(i=0; i<sec; i++)
 315  005e 5f            	clrw	x
 316  005f 1f03          	ldw	(OFST-1,sp),x
 319  0061 200c          	jra	L141
 320  0063               L531:
 321                     ; 51 	delay_ms(1000);
 323  0063 ae03e8        	ldw	x,#1000
 324  0066 add5          	call	_delay_ms
 326                     ; 50 	for(i=0; i<sec; i++)
 328  0068 1e03          	ldw	x,(OFST-1,sp)
 329  006a 1c0001        	addw	x,#1
 330  006d 1f03          	ldw	(OFST-1,sp),x
 332  006f               L141:
 335  006f 1e03          	ldw	x,(OFST-1,sp)
 336  0071 1301          	cpw	x,(OFST-3,sp)
 337  0073 25ee          	jrult	L531
 338                     ; 52 }
 341  0075 5b04          	addw	sp,#4
 342  0077 81            	ret
 355                     	xdef	_delay_sec
 356                     	xdef	_delay_ms
 357                     	xdef	_delay_us
 358                     	xdef	_timer_init
 377                     	end
