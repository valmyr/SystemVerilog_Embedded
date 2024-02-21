module I2S_Transmitter#(parameter WIDTH = 8)(
		input logic 		SCK		,
			     		WS		,
		     	     		nreset		,
		input logic [2*WIDTH-1:0] LoadData	,
		output logic 		SerialData	,
		output logic 		Ready			
);

	logic [$clog2(2*WIDTH-1):0] WordCounter;
	always_comb begin
		SerialData = LoadData[2*WIDTH-1-WordCounter];
	end


	always_ff@(posedge SCK, negedge nreset)begin
		WordCounter <= nreset ? WordCounter + 1: 0;	
	end

endmodule
