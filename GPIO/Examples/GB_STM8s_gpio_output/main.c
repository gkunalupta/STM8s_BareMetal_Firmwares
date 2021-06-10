  
#define PB_ODR		*(unsigned char*)0x5005
#define PB_DDR		*(unsigned char*)0x5007
#define PB_CR1		*(unsigned char*)0x5008

// Unsigned int is 16 bit in STM8.
// So, maximum possible value is 65536.

unsigned long int gb_dl; // Delay
#include <stm8s.h>

int main() {
	PB_ODR = 0x00;	// Turn all pins of port B to low
	PB_DDR |= 1 << 5; // 0x00100000 PB5 is now output
	PB_CR1 |= 1 << 5; // 0x00100000 PB5 is now pushpull

	while(1)
	{
		PB_ODR ^= 1 << 5; // Toggle PB5 output
		for (gb_dl = 0; gb_dl < 1800; gb_dl++) {}
	}
}