
module present_core (
	clk_clk,
	pio_avail_external_connection_export,
	pio_height_external_connection_export,
	pio_width_external_connection_export,
	reset_reset_n);	

	input		clk_clk;
	output	[31:0]	pio_avail_external_connection_export;
	output	[31:0]	pio_height_external_connection_export;
	output	[31:0]	pio_width_external_connection_export;
	input		reset_reset_n;
endmodule
