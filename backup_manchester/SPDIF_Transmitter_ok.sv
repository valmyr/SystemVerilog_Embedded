module SPDIF_Transmitter#(parameter WIDTH = 16)(
			input logic 	clock		,
			input logic 	nreset		,
			input logic 	[WIDTH-1:0] Tx	,
			output logic 	SerialData	
				

);
	logic [$clog2(WIDTH):0] CounterBit;
	logic txBit_n0,SD_negedge;
	always_ff@(posedge clock,negedge nreset) CounterBit <= nreset && CounterBit < WIDTH -1? CounterBit + 1: 0; 
	always_ff@(clock,negedge nreset) SD_negedge <= nreset ? SerialData    : 1;
	assign txBit_n0 = Tx[CounterBit];	
	always_comb
		if(txBit_n0)	SerialData = clock ?  SD_negedge : ~SD_negedge;
		else 		SerialData = clock ? ~SD_negedge : ~SD_negedge;
	
endmodule
