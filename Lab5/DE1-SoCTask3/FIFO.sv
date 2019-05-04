module FIFO 
		#(
			parameter DATA_WIDTH = 24,
						 ADDR_WIDTH = 3
		)
		(
	     input logic clk, rst, write, read,
	     input logic [DATA_WIDTH-1:0] wdata,

	     output logic [DATA_WIDTH-1:0] rdata,	     
	     output logic full, empty
	     );
   logic [DATA_WIDTH-1:0] mem [ADDR_WIDTH**2 - 1:0];
	
   logic        flag;
   logic [ADDR_WIDTH - 1:0]  readptr, writeptr, rpp1, wpp1;

   assign rpp1 = readptr + 1'b1;
   assign wpp1 = writeptr + 1'b1;
   
   assign empty = ~flag & (readptr == writeptr);
   assign full = flag & (readptr == writeptr);
   
   always_ff @(posedge clk) begin
      if (rst) begin
			{readptr, writeptr, flag} <= '0;
      end else begin
			// flag handling
			if (read & ~write & (rpp1 == writeptr)) flag <= 0; // will be empty
			else if (write & ~read & (wpp1 == readptr)) flag <= 1; // will be full
			else flag <= flag;
	 
			// pointer handling
			if (read & ~empty) readptr <= rpp1;
			else readptr <= readptr;
	
			if (write & ~full) writeptr <= wpp1;
			else writeptr <= writeptr;
      end

      if (write && ~full) mem[writeptr] <= wdata;
      //if (read && ~empty) rdata <= mem[readptr]; // standard non-FWFT fifo read port
   end
	
	assign rdata = (~empty && read) ? mem[readptr] : 'd0;
	
endmodule 

/*
module FIFO_tb ();
   logic clk, rst, write, read, full, empty;
   logic [15:0] wdata, rdata;

   FIFO dut (.*);
   
   // Set up the clock.
   parameter CLOCK_PERIOD=20000; // 20ns = 50MHz
   initial begin
      clk <= 1;
      forever #(CLOCK_PERIOD/2) clk <= ~clk;
   end

   int i;
   initial begin
      {write, read, wdata} = '0;
      rst = 1;
      @(posedge clk);
      rst = 0;
      @(posedge clk);

      // initial 20 items
      {read, write} = 2'b01;
      for (i = 0; i < 20; i++) begin
	 wdata = i[15:0];
	 @(posedge clk);
      end

      // simultaneous read-write
      {read, write} = 2'b11;
      for (i = 20; i < 70; i++) begin
	 wdata = i[15:0];
	 @(posedge clk);
      end

      // write until full
      {read, write} = 2'b01;
      for (i = 70; i < 120; i++) begin
	 wdata = i[15:0];
	 @(posedge clk);
      end

      // read until empty
      {read, write} = 2'b10;
      repeat (70) @(posedge clk);
      
      $stop;
   end
endmodule
  
*/