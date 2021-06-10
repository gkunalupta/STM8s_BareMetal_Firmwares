   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.1 - 30 Jun 2020
   3                     ; Generator (Limited) V4.4.12 - 02 Jul 2020
  44                     ; 12 @far @interrupt void NonHandledInterrupt (void)
  44                     ; 13 {
  45                     	switch	.text
  46  0000               f_NonHandledInterrupt:
  50                     ; 17 	return;
  53  0000 80            	iret
  55                     .const:	section	.text
  56  0000               __vectab:
  57  0000 82            	dc.b	130
  59  0001 00            	dc.b	page(__stext)
  60  0002 0000          	dc.w	__stext
  61  0004 82            	dc.b	130
  63  0005 00            	dc.b	page(f_NonHandledInterrupt)
  64  0006 0000          	dc.w	f_NonHandledInterrupt
  65  0008 82            	dc.b	130
  67  0009 00            	dc.b	page(f_NonHandledInterrupt)
  68  000a 0000          	dc.w	f_NonHandledInterrupt
  69  000c 82            	dc.b	130
  71  000d 00            	dc.b	page(f_NonHandledInterrupt)
  72  000e 0000          	dc.w	f_NonHandledInterrupt
  73  0010 82            	dc.b	130
  75  0011 00            	dc.b	page(f_NonHandledInterrupt)
  76  0012 0000          	dc.w	f_NonHandledInterrupt
  77  0014 82            	dc.b	130
  79  0015 00            	dc.b	page(f_NonHandledInterrupt)
  80  0016 0000          	dc.w	f_NonHandledInterrupt
  81  0018 82            	dc.b	130
  83  0019 00            	dc.b	page(f_NonHandledInterrupt)
  84  001a 0000          	dc.w	f_NonHandledInterrupt
  85  001c 82            	dc.b	130
  87  001d 00            	dc.b	page(f_NonHandledInterrupt)
  88  001e 0000          	dc.w	f_NonHandledInterrupt
  89  0020 82            	dc.b	130
  91  0021 00            	dc.b	page(f_NonHandledInterrupt)
  92  0022 0000          	dc.w	f_NonHandledInterrupt
  93  0024 82            	dc.b	130
  95  0025 00            	dc.b	page(f_NonHandledInterrupt)
  96  0026 0000          	dc.w	f_NonHandledInterrupt
  97  0028 82            	dc.b	130
  99  0029 00            	dc.b	page(f_NonHandledInterrupt)
 100  002a 0000          	dc.w	f_NonHandledInterrupt
 101  002c 82            	dc.b	130
 103  002d 00            	dc.b	page(f_NonHandledInterrupt)
 104  002e 0000          	dc.w	f_NonHandledInterrupt
 105  0030 82            	dc.b	130
 107  0031 00            	dc.b	page(f_NonHandledInterrupt)
 108  0032 0000          	dc.w	f_NonHandledInterrupt
 109  0034 82            	dc.b	130
 111  0035 00            	dc.b	page(f_NonHandledInterrupt)
 112  0036 0000          	dc.w	f_NonHandledInterrupt
 113  0038 82            	dc.b	130
 115  0039 00            	dc.b	page(f_NonHandledInterrupt)
 116  003a 0000          	dc.w	f_NonHandledInterrupt
 117  003c 82            	dc.b	130
 119  003d 00            	dc.b	page(f_NonHandledInterrupt)
 120  003e 0000          	dc.w	f_NonHandledInterrupt
 121  0040 82            	dc.b	130
 123  0041 00            	dc.b	page(f_NonHandledInterrupt)
 124  0042 0000          	dc.w	f_NonHandledInterrupt
 125  0044 82            	dc.b	130
 127  0045 00            	dc.b	page(f_NonHandledInterrupt)
 128  0046 0000          	dc.w	f_NonHandledInterrupt
 129  0048 82            	dc.b	130
 131  0049 00            	dc.b	page(f_NonHandledInterrupt)
 132  004a 0000          	dc.w	f_NonHandledInterrupt
 133  004c 82            	dc.b	130
 135  004d 00            	dc.b	page(f_NonHandledInterrupt)
 136  004e 0000          	dc.w	f_NonHandledInterrupt
 137  0050 82            	dc.b	130
 139  0051 00            	dc.b	page(f_NonHandledInterrupt)
 140  0052 0000          	dc.w	f_NonHandledInterrupt
 141  0054 82            	dc.b	130
 143  0055 00            	dc.b	page(f_NonHandledInterrupt)
 144  0056 0000          	dc.w	f_NonHandledInterrupt
 145  0058 82            	dc.b	130
 147  0059 00            	dc.b	page(f_NonHandledInterrupt)
 148  005a 0000          	dc.w	f_NonHandledInterrupt
 149  005c 82            	dc.b	130
 151  005d 00            	dc.b	page(f_NonHandledInterrupt)
 152  005e 0000          	dc.w	f_NonHandledInterrupt
 153  0060 82            	dc.b	130
 155  0061 00            	dc.b	page(f_NonHandledInterrupt)
 156  0062 0000          	dc.w	f_NonHandledInterrupt
 157  0064 82            	dc.b	130
 159  0065 00            	dc.b	page(f_NonHandledInterrupt)
 160  0066 0000          	dc.w	f_NonHandledInterrupt
 161  0068 82            	dc.b	130
 163  0069 00            	dc.b	page(f_NonHandledInterrupt)
 164  006a 0000          	dc.w	f_NonHandledInterrupt
 165  006c 82            	dc.b	130
 167  006d 00            	dc.b	page(f_NonHandledInterrupt)
 168  006e 0000          	dc.w	f_NonHandledInterrupt
 169  0070 82            	dc.b	130
 171  0071 00            	dc.b	page(f_NonHandledInterrupt)
 172  0072 0000          	dc.w	f_NonHandledInterrupt
 173  0074 82            	dc.b	130
 175  0075 00            	dc.b	page(f_NonHandledInterrupt)
 176  0076 0000          	dc.w	f_NonHandledInterrupt
 177  0078 82            	dc.b	130
 179  0079 00            	dc.b	page(f_NonHandledInterrupt)
 180  007a 0000          	dc.w	f_NonHandledInterrupt
 181  007c 82            	dc.b	130
 183  007d 00            	dc.b	page(f_NonHandledInterrupt)
 184  007e 0000          	dc.w	f_NonHandledInterrupt
 235                     	xdef	__vectab
 236                     	xref	__stext
 237                     	xdef	f_NonHandledInterrupt
 256                     	end
