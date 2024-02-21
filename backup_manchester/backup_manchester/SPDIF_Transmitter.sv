module SPDIF_Transmitter#(parameter WIDTH = 16)(
			input logic 	clock		,
			input logic 	nreset		,
			input logic 	[WIDTH-1:0] Tx	,
			output logic 	SerialData	
				

);
	logic SD_internal;
	logic [$clog2(WIDTH):0] CounterWord;
	always@(posedge clock, negedge nreset) begin
		CounterWord <= CounterWord < WIDTH & nreset ? CounterWord + 1 : 0 ;
		SD_internal = Tx[CounterWord];
	end

	always_comb SerialData = ~clock ~^ SD_internal;
endmodule
