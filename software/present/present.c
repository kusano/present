/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include "alt_types.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"
#include "system.h"
#include <stdio.h>
#include <unistd.h>

int main()
{
	printf("Hello from Nios II!\n");

	int N, i;
	scanf("%d", &N);
	printf("N=%d\n", N);

	for (i=0; i<N; i++)
	{
		int w, h;
		scanf("%d%d", &w, &h);
		printf("w=%d, h=%d\n", w, h);

		IOWR_32DIRECT(PIO_AVAIL_BASE, 0, 0);
		IOWR_32DIRECT(PIO_WIDTH_BASE, 0, w);
		IOWR_32DIRECT(PIO_HEIGHT_BASE, 0, h);
		IOWR_32DIRECT(PIO_AVAIL_BASE, 0, 0xffffffffu);

		//usleep(100*1000);
	}

	IOWR_32DIRECT(PIO_AVAIL_BASE, 0, 0);

	return 0;
}
