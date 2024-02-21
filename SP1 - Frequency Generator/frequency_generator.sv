module frequency_generator#(parameter WIDTH = 4)(input logic clock, nreset, input logic [WIDTH-1:0] inp_freq, output logic freq_out);
logic [WIDTH-1:0] dout;
	always_ff@(posedge clock, negedge nreset)	dout <= !nreset ? 0 : inp_freq + dout;
	assign 						freq_out = dout[WIDTH-1]	;
endmodule
