module seg7 (z, d1, d0);

	output logic [6:0] d1, d0;
	input logic [4:0] z;
	
	logic [6:0] one, two, three, four, five, six, seven, eight, nine, zero, A,B,C,D,E,F;
	
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
			5'b00000: begin
				d1 = zero; d0 = zero;
			end
			5'b00001: begin
				 d1 = zero; d0 = one;
			end
			5'b00010: begin
				d1 = zero; d0 = two;
			end
			5'b00011: begin
				d1 = zero; d0 = three;
			end
			5'b00100: begin
				d1 = zero; d0 = four;
			end
			5'b00101: begin
				d1 = zero; d0 = five;
			end
			5'b00110: begin
				d1 = zero; d0 = six;
			end
			5'b00111: begin
				d1 = zero; d0 = seven;
			end
			5'b01000: begin
				d1 = zero; d0 = eight;
			end
			5'b01001: begin
				d1 = zero; d0 = nine;
			end
			5'b01010: begin
				d1 = zero; d0 = A;
			end
			5'b01011: begin
				d1 = zero; d0 = B;
			end
			5'b01100: begin
				d1 = zero; d0 = C;
			end
			5'b01101: begin
				d1 = zero; d0 = D;
			end
			5'b01110: begin
				d1 = zero; d0 = E;
			end
			5'b01111: begin
				d1 = zero; d0 = F;
			end
			5'b10000: begin
				d1 = one; d0 = zero;
			end
			5'b10001: begin
				d1 = one; d0 = one;
			end
			5'b10010: begin
				d1 = one; d0 = two;
			end
			5'b10011: begin
				d1 = one; d0 = three;
			end
			5'b10100: begin
				d1 = one; d0 = four;
			end
			5'b10101: begin
				d1 = one; d0 = five;
			end
			5'b10110: begin
				d1 = one; d0 = six;
			end
			5'b10111: begin
				d1 = one; d0 = seven;
			end
			5'b11000: begin
				d1 = one; d0 = eight;
			end
			5'b11001: begin
				d1 = one; d0 = nine;
			end
			5'd26: begin
				d1 = one; d0 = A;
			end
			5'd27: begin
				d1 = one; d0 = B;
			end
			5'd28: begin
				d1 = one; d0 = C;
			end
			5'd29: begin
				d1 = one; d0 = D;
			end
			5'd30: begin
				d1 = one; d0 = E;
			end
			5'd31: begin
				d1 = one; d0 = F;
			end
		endcase
	end	

endmodule

module seg7_testbench();

	logic [6:0] d1, d0;
	logic [4:0] z;
	
	seg7 dut (.z, .d1, .d0);
	
	integer i;
	initial begin 
		for (int i=0; i<2**5; i++) begin
			z = i; #10;
		end
	end

endmodule
