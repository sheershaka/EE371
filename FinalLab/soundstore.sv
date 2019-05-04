module soundstore #(parameter N=44000)
							(input logic clk, enable, start_read, start_write,
							input logic [23:0] input_left, input_right,
							output logic [23:0] output_left, output_right);
	
  logic [47:0] ram [0:N];
  logic writing, reading;
  logic [17:0] currAddr;
  
  assign {output_left, output_right} = reading ? ram[currAddr] : 48'd0;
   
  always_ff @(posedge clk) begin
	if (start_write) begin
		writing <= 1'b1;
		currAddr <= 18'd0;
	end else begin
		if (enable && writing && currAddr < N ) begin
			ram[currAddr] <= {input_left, input_right};
			currAddr <= currAddr + 1'b1;
		end else if (writing && currAddr == N ) begin
			writing <= 1'b0;
		end
	end
	if (start_read) begin
		reading <= 1'b1;
		currAddr <= 18'd0;
	end else begin
		if (enable && reading && currAddr < N ) begin
			currAddr <= currAddr + 1'b1;
		end else if (reading && currAddr == N ) begin
			reading <= 1'b0;
		end
	end
  end	
endmodule
