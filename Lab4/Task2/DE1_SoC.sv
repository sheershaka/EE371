module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic 			CLOCK_50; // 50MHz clock.
	output logic 	[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic 	[9:0] LEDR;
	input logic 	[3:0] KEY; // True when not pressed, False when pressed
	input logic 	[9:0] SW; 
	
	wire [31:0] clk;
	parameter whichClock = 10;
	clock_divider cdiv (CLOCK_50, clk);  // Comment out for simulation
	
	logic reset_bounds, set_high, start, reset, set_low, found;
	logic [6:0] HEX_0, HEX_1;
	logic [7:0] ram_data, data, current_data;
	logic [4:0] data_addr;
	
	assign data = SW[7:0];
	assign start = SW[9];
	assign reset = ~KEY[0];
	assign LEDR[9] = found;
	
	always_comb begin
		if (found) begin
			HEX0 = HEX_0;
			HEX1 = HEX_1;
		end else begin
			HEX0 = 7'b1111111;
			HEX1 = 7'b1111111;
		end
	end
	
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	seg7 hex10 (.z(data_addr), .d1(HEX_1), .d0(HEX_0));

	ram32x8 ram(.address(data_addr), .clock(CLOCK_50), .data(8'd0), .wren(1'b0), .q(ram_data));
	
	datapath data1 (.clk(clk[whichClock]), .reset_bounds, .set_high, .set_low , .ram_data,
					  .current_data, .data_addr);
					  
	controller control (.clk(clk[whichClock]), .start, .reset, .data, .current_data,
					.found, .set_high, .set_low, .reset_bounds);
		
endmodule
