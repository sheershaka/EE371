module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic 			CLOCK_50; // 50MHz clock.
	input logic 	[3:0] KEY;
	input logic 	[9:0] SW; 
	output logic 	[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic 	[9:0] LEDR;
	
	logic [4:0]  address;
	logic [3:0]  data;
	logic  clock, wren;
	logic	[3:0]  q;
	
	assign data = SW[3:0];
	assign address = SW[8:4];
	assign wren = SW[9];
	assign clock = KEY[0];
	
	ram32x4 ram1 (.address, .clock, .data, .wren, .q);
	
	seg7 yo (.z(address), .d1(HEX5), .d0(HEX4));
	seg7 hex32 (.z(data), .d1(HEX3), .d0(HEX2));
	seg7 hex10 (.z(q), .d1(HEX1), .d0(HEX0));

	
	
endmodule

`timescale 1 ps / 1 ps 
module DE1_SoC_testbench();

	logic 		CLOCK_50; // 50MHz clock.
	logic [3:0] KEY;
	logic [9:0] SW; 
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	
   DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);

	// Set up the inputs to the design. Each line is a clock cycle.
	integer i;
	initial begin
		
		KEY[0] = 1;
		SW[9:0] = 10'd0; KEY[0] = 0; #10;
		SW[9] = 1; 	KEY[0] = 0; #10;
		for (i=0; i<2**5; i++) begin
			KEY[0] = 1; #10;
			SW[8:4] = i; SW[3:0] = i; KEY[0] = 0; #10;
		end 
		
		KEY[0] = 1;
		SW[9:0] = 10'd0; KEY[0] = 0; #10;
		for (i=0; i<2**5; i++) begin
			KEY[0] = 1; #10;
			SW[8:4] = i; KEY[0] = 0; #10;
		end 
		$stop;
   end
endmodule

