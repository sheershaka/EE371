module seg7 (z, d);

	output logic [6:0] d;
	input logic [3:0] z;
	
	logic [6:0] one, two, three, four, five, six, seven, eight, nine, zero, A, B, C, D, E, F;
	
	assign one = ~7'b0000110;
	assign two = ~7'b1011011;
	assign three = ~7'b1001111;
	assign four = ~7'b1100110;
	assign five = ~7'b1101101;
	assign six  = ~7'b1111101;
	assign seven = ~7'b0000111;
	assign eight = ~7'b1111111;
	assign nine = ~7'b1101111;
	assign zero = ~7'b0111111;
	
	assign A = ~7'b1110111;
	assign B = ~7'b1111100;
	assign C = 7'b1000110;
	assign D = 7'b0100001;
	assign E = 7'b0000110;
	assign F = 7'b0001110; 

		
	always_comb begin
		case (z)
			4'd0: d = zero;
			4'd1: d = one;
			4'd2: d = two;
			4'd3: d = three;
			4'd4: d = four;
			4'd5: d = five;
			4'd6: d = six;
			4'd7: d = seven;
			4'd8: d = eight;
			4'd9: d = nine;
			4'd10: d = A;
			4'd11: d = B;
			4'd12: d = C;
			4'd13: d = D;
			4'd14: d = E;
			4'd15: d = F;
		endcase
	end	

endmodule

module seg7_testbench();

	logic [6:0] d;
	logic [3:0] z;
	
	seg7 dut (.z, .d);
	
	integer i;
	initial begin 
		for (int i=0; i<2**4; i++) begin
			z = i; #10;
		end
	end

endmodule
