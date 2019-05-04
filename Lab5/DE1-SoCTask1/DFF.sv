module DFFF (clk, reset, D, Q );
	output logic [23:0] Q;
	input logic clk, reset;
	input logic [23:0] D;


	always_ff @(posedge clk) begin
		if (reset) begin
			Q <= '0;
		end else begin
			Q <= D;
		end
	end

endmodule 

module DFFF_testbench(); 
  
	logic  clk, reset;
	logic  [23:0] D, Q;     

	DFFF dut (.clk, .reset, .D, .Q);      

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
		reset <= 0; D <= 24'd1; @( posedge clk );                        
									 @( posedge clk );                        
									 @( posedge clk );                        
									 @( posedge clk );                
						D <= 24'd3; @( posedge clk );                
						D <= 24'd5; @( posedge clk );                
						D <= 24'd3; @( posedge clk );                        
									 @( posedge clk );                        
									 @( posedge clk );                        
									 @( posedge clk );               
						D <= 24'd5; @( posedge clk );                        
									 @( posedge clk ); 
									 @( posedge clk ); 
									 @( posedge clk ); 							  
		$stop; // End the simulation.   
	end  
endmodule
