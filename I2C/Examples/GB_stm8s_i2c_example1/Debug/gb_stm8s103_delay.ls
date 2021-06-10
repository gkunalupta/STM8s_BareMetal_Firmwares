   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  43                     ; 4 void gb_timer_init(void)
  43                     ; 5 {
  45                     	switch	.text
  46  0000               _gb_timer_init:
  50                     ; 10    TIM2->EGR |= 1<<0;
  52  0000 72105306      	bset	21254,#0
  53                     ; 12     TIM2->PSCR = 1;
  55  0004 3501530e      	mov	21262,#1
  56                     ; 14     TIM2->ARRH = 0xff;
  58  0008 35ff530f      	mov	21263,#255
  59                     ; 15 		TIM2->ARRL = 0xff;
  61  000c 35ff5310      	mov	21264,#255
  62                     ; 17 	  TIM2->SR1 &= ~(1<<0);
  64  0010 72115304      	bres	21252,#0
  65                     ; 19     TIM2->CR1 |= 1<<2; //generate update at Counter overflow/underflow
  67  0014 72145300      	bset	21248,#2
  68                     ; 21     TIM2_CNTR = 00;
  70  0018 5f            	clrw	x
  71  0019 cf530c        	ldw	21260,x
  72                     ; 23      CLK->CCOR |= CLK_CCOR_CCOEN | CLK_CCOR_CCOSEL;
  74  001c c650c9        	ld	a,20681
  75  001f aa1f          	or	a,#31
  76  0021 c750c9        	ld	20681,a
  77                     ; 25 }
  80  0024 81            	ret
 123                     ; 27 void gb_delay_us(uint16_t gb_us)
 123                     ; 28 {
 124                     	switch	.text
 125  0025               _gb_delay_us:
 127  0025 89            	pushw	x
 128       00000002      OFST:	set	2
 131                     ; 29 	uint16_t gb_i = gb_us;
 133  0026 1f01          	ldw	(OFST-1,sp),x
 135                     ; 31 TIM2_CNTR =0;
 137  0028 5f            	clrw	x
 138  0029 cf530c        	ldw	21260,x
 139                     ; 32 	TIM2->CR1 |= (1<<0);
 141  002c 72105300      	bset	21248,#0
 143  0030               L54:
 144                     ; 33 	while(TIM2_CNTR <gb_i);
 146  0030 ce530c        	ldw	x,21260
 147  0033 1301          	cpw	x,(OFST-1,sp)
 148  0035 25f9          	jrult	L54
 149                     ; 34 	TIM2->CR1 &= ~(1<<0);
 151  0037 72115300      	bres	21248,#0
 152                     ; 37 }
 155  003b 85            	popw	x
 156  003c 81            	ret
 209                     ; 38 void gb_delay_ms(uint16_t gb_ms)
 209                     ; 39 { 
 210                     	switch	.text
 211  003d               _gb_delay_ms:
 213  003d 89            	pushw	x
 214  003e 5204          	subw	sp,#4
 215       00000004      OFST:	set	4
 218                     ; 41 	uint16_t gb_milisec = gb_ms;
 220                     ; 43 	for(gb_i=0; gb_i<gb_ms; gb_i++)
 222  0040 5f            	clrw	x
 223  0041 1f03          	ldw	(OFST-1,sp),x
 226  0043 200c          	jra	L301
 227  0045               L77:
 228                     ; 44 	gb_delay_us(1000);
 230  0045 ae03e8        	ldw	x,#1000
 231  0048 addb          	call	_gb_delay_us
 233                     ; 43 	for(gb_i=0; gb_i<gb_ms; gb_i++)
 235  004a 1e03          	ldw	x,(OFST-1,sp)
 236  004c 1c0001        	addw	x,#1
 237  004f 1f03          	ldw	(OFST-1,sp),x
 239  0051               L301:
 242  0051 1e03          	ldw	x,(OFST-1,sp)
 243  0053 1305          	cpw	x,(OFST+1,sp)
 244  0055 25ee          	jrult	L77
 245                     ; 45 }
 248  0057 5b06          	addw	sp,#6
 249  0059 81            	ret
 302                     ; 46 void gb_delay_sec(uint16_t gb_secs)
 302                     ; 47 { 
 303                     	switch	.text
 304  005a               _gb_delay_sec:
 306  005a 5204          	subw	sp,#4
 307       00000004      OFST:	set	4
 310                     ; 49 	uint16_t gb_sec =gb_secs;
 312  005c 1f01          	ldw	(OFST-3,sp),x
 314                     ; 50 	for(gb_i=0; gb_i<gb_sec; gb_i++)
 316  005e 5f            	clrw	x
 317  005f 1f03          	ldw	(OFST-1,sp),x
 320  0061 200c          	jra	L141
 321  0063               L531:
 322                     ; 51 	gb_delay_ms(1000);
 324  0063 ae03e8        	ldw	x,#1000
 325  0066 add5          	call	_gb_delay_ms
 327                     ; 50 	for(gb_i=0; gb_i<gb_sec; gb_i++)
 329  0068 1e03          	ldw	x,(OFST-1,sp)
 330  006a 1c0001        	addw	x,#1
 331  006d 1f03          	ldw	(OFST-1,sp),x
 333  006f               L141:
 336  006f 1e03          	ldw	x,(OFST-1,sp)
 337  0071 1301          	cpw	x,(OFST-3,sp)
 338  0073 25ee          	jrult	L531
 339                     ; 52 }
 342  0075 5b04          	addw	sp,#4
 343  0077 81            	ret
 356                     	xdef	_gb_delay_sec
 357                     	xdef	_gb_delay_ms
 358                     	xdef	_gb_delay_us
 359                     	xdef	_gb_timer_init
 378                     	end
