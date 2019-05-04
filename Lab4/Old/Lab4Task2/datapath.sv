module datapath (clk, reset_bounds, set_high, set_low , q, current_data, rdaddress);
					 
	input logic clk, reset_bounds, set_high, set_low;
	input logic [7:0] q;
	output logic [7:0] current_data;
	output logic [4:0] rdaddress;
					 
	logic [4:0] low, high, mid;
	assign mid = (high + low) / 2;
	assign current_data = q;
	assign rdaddress = mid;
	
	always_ff @(posedge clk) begin
		if (reset_bounds) begin
			low <= 5'd0;
			high <= 5'd31;
		end
		if (set_high) high <= mid - 1'b1;;
		if (set_low) low <= mid + 1'b1;
	end
	
endmodule
