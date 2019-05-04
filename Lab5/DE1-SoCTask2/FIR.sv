module FIR (clk, reset, x, y);
	
	input logic signed[23:0] x;
	input logic clk, reset;
	output logic signed [23:0] y;
	
	logic signed [23:0] d0, d1, d2, d3, d4, d5, d6, d7;
	logic signed [23:0] s0, s1, s2, s3, s4, s5, s6, s7;
	
	assign d0 = x;
	assign y = s0 + s1 + s2 + s3 + s4 + s5 + s6 + s7;
	
	assign s0 = {{3{d0[23]}}, {d0[23:3]}};
	DFFF one (.clk, .reset, .D(d0), .Q(d1));
	assign s1 = {{3{d1[23]}}, {d1[23:3]}};
	DFFF two (.clk, .reset, .D(d1), .Q(d2));
	assign s2 = {{3{d2[23]}}, {d2[23:3]}};
	DFFF three (.clk, .reset, .D(d2), .Q(d3));
	assign s3 = {{3{d3[23]}}, {d3[23:3]}};
	DFFF four (.clk, .reset, .D(d3), .Q(d4));
	assign s4 = {{3{d4[23]}}, {d4[23:3]}};
	DFFF five (.clk, .reset, .D(d4), .Q(d5));
	assign s5 = {{3{d5[23]}}, {d5[23:3]}};
	DFFF six (.clk, .reset, .D(d5), .Q(d6));
	assign s6 = {{3{d6[23]}}, {d6[23:3]}};
	DFFF seven (.clk, .reset, .D(d6), .Q(d7));
	assign s7 = {{3{d7[23]}}, {d7[23:3]}};
	

endmodule

module FIR_tb();

	logic signed [23:0] x, y;
	logic clk, reset;
	
	FIR dut (.clk, .reset, .x, .y);      

	// Set up the clock.   
	parameter CLOCK_PERIOD = 100;   
	initial begin    
		clk <= 0;    
		forever #( CLOCK_PERIOD / 2 ) clk <= ~clk;   
	end      

	// Set up the inputs to the design.  Each line is a clock cycle.   
	initial begin                        
									 @( posedge clk );    
		reset <= 1;           @( posedge clk );    
		reset <= 0; x <= 24'd0; @( posedge clk );                        
									 @( posedge clk ); 
										@( posedge clk ); @( posedge clk ); @( posedge clk ); 									 
									 @( posedge clk );                        
									 @( posedge clk );                
						x <= 24'd3; @( posedge clk );                
						x <= 24'd5; @( posedge clk );                
						x <= 24'd6; @( posedge clk );                        
									 @( posedge clk );                        
									 @( posedge clk );                        
									 @( posedge clk );               
						x <= 24'b111110000000000000000000; @( posedge clk );                        
									 @( posedge clk ); 
									 @( posedge clk ); 
									 @( posedge clk );
									@( posedge clk ); 	@( posedge clk ); 	@( posedge clk ); 	@( posedge clk ); 	@( posedge clk ); 	
		$stop; // End the simulation.   
	end  

endmodule
