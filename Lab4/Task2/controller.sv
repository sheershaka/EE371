module controller(input logic clk, start, reset,
						input logic [7:0] data, current_data,
						output logic found, set_high, set_low, reset_bounds);
						
	enum logic [1:0] {S1=2'b00, S2=2'b01, S3=2'b10} ps, ns;
	logic data_found;
	
	always_comb begin
		case (ps)
			S1: if (start) ns = S2;
				 else ns = S1;
			S2: if (data_found) ns = S3;
				 else ns = S2;
			S3: if (start) ns = S3;
				 else ns = S1;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset) ps <= S1;
		else ps <= ns;
	end
	
	assign data_found = (data == current_data);
	assign found = (ps == S3);
	assign reset_bounds = (ps == S1);
	assign set_high = (ps == S2) && (~data_found) && (current_data > data);
	assign set_low = (ps == S2) && (~data_found) && (current_data < data);
	
endmodule

module controller_testbench();

	logic clk, start, reset;
	logic [7:0] data, current_data;
	logic found, set_high, set_low, reset_bounds;
	
	controller dut(.clk, .start, .reset, .data, .current_data,
						.found, .set_high, .set_low, .reset_bounds);
	

	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
		start <= 1'b0; reset <= 1'b1; data <= 8'b00000100;
		current_data <= 8'b00100000; 									@(posedge clk); 
		reset <= 1'b0;														@(posedge clk);
																				@(posedge clk);  
		start <= 1'b1;														@(posedge clk);
																				@(posedge clk);
		current_data <= 8'b00001000;									@(posedge clk); 
																				@(posedge clk);
		current_data <= 8'b00000010;									@(posedge clk); 
																				@(posedge clk);
		current_data <= 8'b00000100;									@(posedge clk); 
																				@(posedge clk);
																				@(posedge clk);  
		start <= 1'b0;														@(posedge clk); 
																				@(posedge clk);  
		
																				
						
		$stop;
   end
endmodule
