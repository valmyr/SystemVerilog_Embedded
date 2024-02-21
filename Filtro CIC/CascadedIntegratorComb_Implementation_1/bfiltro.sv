`include "./integrator.sv"
`include "./comb.sv"


module filter#(parameter WIDTH = 32, SIZE = 3)(input logic clock, reset, input logic [WIDTH-1:0] x_in, output logic [WIDTH-1:0] y_out);

	logic ena;
	assign ena =1;
	logic [WIDTH-1:0]wire_out_integ[SIZE-1:0];
	logic [WIDTH-1:0]wire_out_comb[SIZE-1:0];
	logic [WIDTH-1:0]integ_wire_comb;
	logic [4:0] counter;

	always@(posedge clock, posedge reset)	counter <= reset | counter == SIZE - 1 ? 0: counter + 1;
	always_comb 				integ_wire_comb <= !counter ? wire_out_integ[0]: 0;
	assign 					y_out = counter == SIZE-1 ?  wire_out_comb[0]/SIZE :0;
	
	genvar i;
	generate
			for(i = 0; i < SIZE-1; i=i+1)begin
			integrator integ_n_(
					.clock(clock),
					.reset(reset),
					.ena(ena),
					.x_in(wire_out_integ[i]),
					.y_out(wire_out_integ[i+1])
						
			);

			comb comb_n(
                        		.clock(clock),
    		            	        .reset(reset),
                	        	.ena(ena),
                        		.x_in(wire_out_comb[i]),
                        		.y_out(wire_out_comb[i+1])

		        );
		end


	endgenerate
	always_comb begin
		wire_out_integ[0] = x_in;
		wire_out_comb[0]  = integ_wire_comb;
	end
	       	/*	
	integrator integ_n0(
			.clock(clock),

			.reset(reset),
			.ena(ena),
			.x_in(x_in),
			.y_out(wire_out_integ[0])
	);
	comb comb_n0(
			.clock(clock),
			.reset(reset),
			.ena(ena),
			.x_in(integ_wire_comb),

			.y_out(wire_out
*/
endmodule


