module present(clk, rst, hled0, hled1, hled2, hled3, hled4, hled5);
	input clk;
	input rst;
	output [6:0] hled0;
	output [6:0] hled1;
	output [6:0] hled2;
	output [6:0] hled3;
	output [6:0] hled4;
	output [6:0] hled5;
	
	parameter N = 100;
	
	wire [31:0] width;
	wire [31:0] height;
	wire [31:0] avail;
	
	reg [31:0] width_prev;
	reg [31:0] height_prev;
	
	reg [31:0] w [0:N-1];
	reg [31:0] h [0:N-1];
	reg [31:0] n [0:N-1];
	reg [31:0] count;
	reg [31:0] answer;
	integer i;
	
	present_core u0 (
		.clk_clk                               (clk),
		.reset_reset_n                         (rst),
		.pio_width_external_connection_export  (width),
		.pio_height_external_connection_export (height),
		.pio_avail_external_connection_export  (avail)
	);

	always @(negedge rst or posedge clk) begin

		//	初期化
		if (rst==1'd0) begin
			for (i=0; i<N; i=i+1) begin
				w[i] <= 32'd0;
				h[i] <= 32'd0;
				n[i] <= 32'd0;
			end
			count <= 32'd0;
			answer <= 32'd0;

		end else begin
			//	入力が前回と変化していれば値を読み込む
			if (avail[0] != 32'd0 &&
				 (width != width_prev || height != height_prev)) begin
				width_prev <= width;
				height_prev <= height;
				w[0] <= width;
				h[0] <= height;
				n[0] <= 32'd1;
				for (i=1; i<N; i=i+1) begin
					w[i] <= w[i-1];
					h[i] <= h[i-1];
					n[i] <= 32'd1;
				end
				count <= 32'd0;
				answer <= 32'd0;
			end else begin
				//	サイズが有効な箱を比較して、中に入れられるならば入れる
				for (i=0; i<N; i=i+1) begin
					if (w[i] != 32'd0 &&
						 w[count] != 32'd0 &&
						 w[i] > w[count] &&
						 h[i] > h[count] &&
						 n[i] < n[count]+1)
						n[i] <= n[count]+1;
				end
				if (answer < n[count])
					answer <= n[count];
				
				count <= count<N-1 ? count+1'b1 : 32'd0;
			end
		end
	end
	
	function [6:0] led;
		input [3:0] v;
	begin
		case (v)
			4'h0: led = 7'b1000000;
			4'h1: led = 7'b1111001;
			4'h2: led = 7'b0100100;
			4'h3: led = 7'b0110000;
			4'h4: led = 7'b0011001;
			4'h5: led = 7'b0010010;
			4'h6: led = 7'b0000010;
			4'h7: led = 7'b1011000;
			4'h8: led = 7'b0000000;
			4'h9: led = 7'b0010000;
			4'ha: led = 7'b0001000;
			4'hb: led = 7'b0000011;
			4'hc: led = 7'b1000110;
			4'hd: led = 7'b0100001;
			4'he: led = 7'b0000110;
			4'hf: led = 7'b0001110;
			default: led = 7'b0;
		endcase
	end
	endfunction
	
	assign hled0 = led(answer[ 3: 0]);
	assign hled1 = led(answer[ 7: 4]);
	assign hled2 = led(answer[11: 8]);
	assign hled3 = led(answer[15:12]);
	assign hled4 = led(answer[19:16]);
	assign hled5 = led(answer[23:20]);
endmodule
