module FIR (clk, reset, x, y);
	
	input logic signed[23:0] x;
	input logic clk, reset;
	output logic signed [23:0] y;
	
	logic [23:0] d0, d1, d2, d3, d4, d5, d6, d7;
	logic [23:0] s0, s1, s2, s3, s4, s5, s6, s7;
	
	assign d0 = x;
	assign y = s0 + s1 + s2 + s3 + s4 + s5 + s6 + s7;
	
	assign s0 = d0 >> 3;
	DFFF one (.clk, .reset, .D(d0), .Q(d1));
	assign s1 = d1 >> 3;
	DFFF two (.clk, .reset, .D(d1), .Q(d2));
	assign s2 = d2 >> 3;
	DFFF three (.clk, .reset, .D(d2), .Q(d3));
	assign s3 = d3 >> 3;
	DFFF four (.clk, .reset, .D(d3), .Q(d4));
	assign s4 = d4 >> 3;
	DFFF five (.clk, .reset, .D(d4), .Q(d5));
	assign s5 = d5 >> 3;
	DFFF six (.clk, .reset, .D(d5), .Q(d6));
	assign s6 = d6 >> 3;
	DFFF seven (.clk, .reset, .D(d6), .Q(d7));
	assign s7 = d7 >> 3;
	

endmodule
