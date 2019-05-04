module datapath(input logic clk, reset_bounds, set_high, set_low,
					 input logic [7:0] ram_data,
					 output logic [7:0] current_data,
					 output logic [4:0] data_addr);
	
	logic [4:0] low, high, mid;
	assign mid = (high + low) / 2;
	assign current_data = ram_data;
	assign data_addr = mid;
	
	always_ff @(posedge clk) begin
		if (reset_bounds) begin
			low <= 5'b00000;
			high <= 5'b11111;
		end
		if (set_high) high <= mid - 1'b1;;
		if (set_low) low <= mid + 1'b1;
	end
	
endmodule

module datapath_testbench();

	logic clk, reset_bounds, set_high, set_low;
	logic [7:0] ram_data;
	logic [7:0] current_data;
	logic [4:0] data_addr;
	
	datapath dut(.clk, .reset_bounds, .set_high, .set_low, .ram_data,
					 .current_data, .data_addr);
	

	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
		reset_bounds <= 1'b1; set_high <= 1'b0; 
		set_low <= 1'b0; ram_data <= 8'b00000100;    		@(posedge clk);  
																			@(posedge clk);  
		set_low <= 1'b1; 												@(posedge clk); 
																			@(posedge clk);  
																			@(posedge clk);  
																			@(posedge clk);  
		ram_data <= 8'b10000000;									@(posedge clk);
		set_low <= 1'b0;												@(posedge clk); 
		reset_bounds <= 1'b1;										@(posedge clk); 
		reset_bounds <= 1'b0; set_high <= 1'b1;           	@(posedge clk); 
																			@(posedge clk);  
																			@(posedge clk); 
																			@(posedge clk);  
		
		$stop;
   end
endmodule
