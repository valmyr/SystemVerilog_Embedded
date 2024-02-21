module SPDIF_Transmitter#(parameter WIDTH = 16)(
			input logic 	clock		,
			input logic 	nreset		,
			input logic 	[WIDTH-1:0] Tx	,
			output logic 	SerialData	
				

);
	logic SD_internalN, SD_internalN_1;
	logic SD_internal_negedge;
	logic [$clog2(WIDTH):0] CounterWord;
	always_ff@(negedge clock, negedge nreset) begin
		CounterWord <= CounterWord < WIDTH & nreset ? CounterWord + 1 : 0 ;
		SD_internalN = Tx[CounterWord];
		if(CounterWord != 0) SD_internalN_1 = Tx[CounterWord-1];
	end
	always_ff@(posedge clock, negedge nreset) SD_internal_negedge = nreset ? SerialData : 0;  
	always_comb begin  
		if(CounterWord <=1)begin
			SerialData = SD_internalN ^ clock;
		end
		else begin
			case({SD_internalN_1,SD_internalN})
				2'b00:begin
				end
				2'b01:begin
				end
				2'b10:begin
				end
				2'b11:begin
					if(clock == 0) SerialData = SD_internal_negedge;
					else if(SD_internalN_1) SerialData = 0;
					else SerialData = 1;

				end

			endcase
		end
	end
endmodule
