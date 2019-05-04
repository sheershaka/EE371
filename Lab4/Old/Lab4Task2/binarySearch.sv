module binarySearch (clk, reset, start, data, result, found, rdaddress, q);

	input logic clk, reset, start;
	input logic [7:0] data; // value to be found
	input logic [7:0] q;	// value in rdaddress
	output logic [4:0] rdaddress;
	output logic found;
	output logic [7:0] result;
	
	logic [7:0] A;
	logic [7:0] out;
	logic [2:0] ps, ns;
	
	logic [4:0] head, head_next, tail, tail_next, mid;
	assign mid = (head + tail)/2;
	assign rdaddress = mid;
	
	assign result = out;
	
	always_ff @(posedge clk) begin
		if (reset) ps <= 2'b00;
		else ps <= ns;
	end
	
	always_ff @(posedge clk) begin
		case (ps)
			3'b000: begin
					out <= 7'd0;// result = 0
					found <= 0;
					A <= data;
					head <= 5'd0;
					tail <= 5'd31;
					head_next <= head;
					tail_next <= tail;
					//mid <= 5'd15;
					if (start) begin
						ns <= 3'b111;
					end else begin
						ns <= 3'b000;
					end
				 end
			3'b111: ns <= 3'b001;
			3'b001: begin
					if (head_next <= tail_next) begin
						if (A == q) begin
							ns <= 3'b010;
						end else if (A < q) begin
							tail <= mid - 1;
							tail_next <= tail;
							ns <= 3'b111;
						end else begin
							head <= mid + 1;
							head_next <= head;
							ns <= 3'b111;
						end
					end else ns <= 3'b011;
				 end
			3'b010: begin
					if (start) ns <= 3'b010;
					else ns <= 3'b000;
					found <= 1; //done
					out <= q;
				 end
			3'b011: begin
					if (start) ns <= 3'b011;
					else ns <= 3'b000;
					found <= 0; //done
				 end
			default: ns <= 3'bxxx;
		endcase
	end
	
endmodule

module binarySearch_tb();

	logic clk, reset, start;
	logic [7:0] data, result, q;
	logic found;
	logic [4:0] rdaddress;
	
	// Set up the clock. 
	parameter CLOCK_PERIOD=100; 
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	binarySearch dut (.clk, .reset, .start, .data, .result, .found, .rdaddress, .q);
	
	initial begin 
		reset <= 1;	data <= 8'b00000001;	start <= 0;	@(posedge clk);
		reset <= 0; data <= 8'b00000001;	start <= 0; @(posedge clk);
													start <= 1; @(posedge clk);
		//q <= 8'd15; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		//q <= 8'd9; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		//q <= 8'd4; @(posedge clk);
		//q <= 8'd1; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		$stop;
	end
	
endmodule
