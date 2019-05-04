module filter #(parameter N = 128)
				(input logic clk, reset, enable,
				 input logic [23:0] data_in,
				 output logic [23:0] data_out
				);
	 
	 parameter addr = $clog2(N); //to calculate the bits that we have to shift
	 logic [addr + 1:0] count;
	 
    logic read, write, empty, full;
    logic [23:0] wdata, rdata;

	 FIFO #(.DATA_WIDTH(24), .ADDR_WIDTH(addr + 1)) fifo (.clk, .rst(reset), .write, .read, .wdata, .rdata, .full, .empty);
	 
	 logic signed [23:0] d_in, firstAdd, secAdd, accumulator;
	 
	 assign data_out = secAdd;
	 
	 assign d_in = {{addr{data_in[23]}}, data_in[23:addr]};  // divide it by N
	 
	 assign firstAdd = d_in + ((-1) * (count >= N ? rdata : 'd0));
	 assign secAdd = firstAdd + accumulator;
	 
	 always_ff @(posedge clk) begin
		if (reset) begin
			count <= 'd0;
			write <= 1'b0;
			read <= 1'b0;
			accumulator <= 'd0;
		end else if (enable) begin
			accumulator <= secAdd;
			// We always write the data to the fifo
			write <= 1'b1;
			wdata <= d_in;
			
			// managing the FIFO
			if (count == N - 1) begin
				read <= 1'b1;
				count <= count + 'd1;
			end else if (count >= N) begin
				read <= 1'b1;
			end else begin
				read <= 1'b0;
				count <= count + 'd1;
			end
		end else begin
			read <= 1'b0;
			write <= 1'b0;
		end
	 end
	
endmodule


module filter_tb();
	logic clk, reset, enable;
	logic [23:0] data_in;
	logic [23:0] data_out;
	
	filter #(.N(8)) dut (.clk, .reset, .enable, .data_in, .data_out);
	

	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
		reset <= 1'b1; data_in <= ~24'd246 + 1; enable <= 1'b0;	@(posedge clk);  // Initial state
							reset <= 1'b0; 							@(posedge clk);
		enable <= 1'b1;												@(posedge clk);
		enable <= 1'b0;												@(posedge clk);
																			@(posedge clk);
		enable <= 1'b1;												@(posedge clk);
																			@(posedge clk);
																			@(posedge clk);  // The data_out should be 100 now because of averaging
																			@(posedge clk);
																			@(posedge clk);
																			@(posedge clk)
																			
		enable <= 1'b0;																	@(posedge clk)
																			@(posedge clk)
																			@(posedge clk)
																			@(posedge clk)
		enable <= 1'b1;																	@(posedge clk)
																			@(posedge clk)
																			@(posedge clk)
																			@(posedge clk)
																			@(posedge clk)
																			@(posedge clk)
																			@(posedge clk)
																			@(posedge clk)
																			@(posedge clk);
																			@(posedge clk);
		enable <= 1'b0;												@(posedge clk);
																			@(posedge clk);
		data_in <= 24'd64;											@(posedge clk);
																			@(posedge clk);
																			@(posedge clk);
		enable <= 1'b1;												@(posedge clk);
																			@(posedge clk);
		enable <= 1'b0;												@(posedge clk);
																			@(posedge clk);
														
														
		$stop;
   end
endmodule
