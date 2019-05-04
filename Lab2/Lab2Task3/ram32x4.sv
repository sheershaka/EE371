module ram32x4 #(parameter data_width = 4, addr_width = 5) (address, clock, data, wren, q);

	input logic clock, wren; 
	input logic [addr_width-1:0] address;
	input logic [data_width-1:0] data;
	output logic [data_width-1:0] q;

	//[data_width-1:0] -> 8-1 is width of word
	//[0:2**addr_width-1] - > (2^10)-1 is # of words
	logic [data_width-1:0]ram[0:2**addr_width-1];
	logic [data_width-1:0] data_reg;

	//body port a
	always_ff @(posedge clock) begin
		//write operation
		if (wren) ram[address] <= data;
		data_reg <= ram[address]; //<- because of synchronous read and write
		// and is different if asynchronous
	end

	assign q = data_reg;

endmodule
