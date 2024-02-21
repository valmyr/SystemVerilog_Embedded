module SPDIF_Transmitter#(parameter WIDTH = 16)(
			input logic 	clock		,
			input logic 	nreset		,
			input logic 	[WIDTH-1:0] Tx	,
			output logic 	SerialDataCurrent	
				

);
	logic [$clog2(WIDTH):0] CounterBit;
	logic txBit_n0,SerialDataFirst;
	always_ff@(posedge clock,negedge nreset)	CounterBit <= nreset && CounterBit < WIDTH -1? CounterBit + 1: 0;
	always@(clock, negedge nreset) 			SerialDataFirst = nreset ? SerialDataCurrent : 0;
	assign txBit_n0 = Tx[CounterBit];	
	always_comb if(txBit_n0)	SerialDataCurrent = clock ?  SerialDataFirst : ~SerialDataFirst;
		    else 		SerialDataCurrent =  ~SerialDataFirst;
	
endmodule
