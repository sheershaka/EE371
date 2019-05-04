`timescale 1 ps / 1 ps 
module ram_tb();

	logic clk, wren;	
	logic [4:0]  address;
	logic [7:0]  data;
	
	logic	[7:0]  q;
	
	ram32x8 dut(.address, .clock(clk), .data, .wren, .q);

	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	integer i;
	initial begin	
		address <= 0; data <= 0; wren <= 0; @(posedge clk);
		for (i=0; i<2**5; i++) begin
			address <= i; 						   @(posedge clk);
		end 
		$stop;
   end
endmodule

