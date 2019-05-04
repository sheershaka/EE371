module sample (input logic clk, beginErase,
				  output logic [10:0] x0, y0, x1, y1);
	
	assign x0 = 0;
	assign x1 = 638;
	
	logic [11:0] counter;
	
	// beginErase has to be just 1 pulse signal
	
	always_ff @(posedge clk) begin
		if (beginErase && y0 != 0) begin
			y0 <= 0;
			y1 <= 0;
			counter <= {12{1'b0}};
		end
		if (counter == {12{1'b1}} && y0 < 439) begin
			// Enough time given to draw black line
			y0 <= y0 + 1;
			y1 <= y1 + 1;
		end
		counter <= counter + 1;
	end
		
	
endmodule
