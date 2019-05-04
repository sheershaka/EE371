module noise_generator (clk, enable, Q);

	input logic clk, enable;
	output logic [23:0] Q;
	
	logic [2:0] counter;
	
	always_ff @(posedge clk) begin
		counter <= counter + 3'd1;
	end
	
	assign Q = {{10{counter[2]}}, counter, 11'd0};
endmodule
