   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  43                     .const:	section	.text
  44  0000               L6:
  45  0000 00000708      	dc.l	1800
  46                     ; 12 int main() {
  47                     	scross	off
  48                     	switch	.text
  49  0000               _main:
  53                     ; 13 	PB_ODR = 0x00;	// Turn all pins of port B to low
  55  0000 725f5005      	clr	20485
  56                     ; 14 	PB_DDR |= 1 << 5; // 0x00100000 PB5 is now output
  58  0004 721a5007      	bset	20487,#5
  59                     ; 15 	PB_CR1 |= 1 << 5; // 0x00100000 PB5 is now pushpull
  61  0008 721a5008      	bset	20488,#5
  62  000c               L12:
  63                     ; 19 		PB_ODR ^= 1 << 5; // Toggle PB5 output
  65  000c 901a5005      	bcpl	20485,#5
  66                     ; 20 		for (gb_dl = 0; gb_dl < 1800; gb_dl++) {}
  68  0010 ae0000        	ldw	x,#0
  69  0013 bf02          	ldw	_gb_dl+2,x
  70  0015 ae0000        	ldw	x,#0
  71  0018 bf00          	ldw	_gb_dl,x
  72  001a               L52:
  75  001a ae0000        	ldw	x,#_gb_dl
  76  001d a601          	ld	a,#1
  77  001f cd0000        	call	c_lgadc
  81  0022 ae0000        	ldw	x,#_gb_dl
  82  0025 cd0000        	call	c_ltor
  84  0028 ae0000        	ldw	x,#L6
  85  002b cd0000        	call	c_lcmp
  87  002e 25ea          	jrult	L52
  89  0030 20da          	jra	L12
 113                     	xdef	_main
 114                     	switch	.ubsct
 115  0000               _gb_dl:
 116  0000 00000000      	ds.b	4
 117                     	xdef	_gb_dl
 137                     	xref	c_lcmp
 138                     	xref	c_ltor
 139                     	xref	c_lgadc
 140                     	end
