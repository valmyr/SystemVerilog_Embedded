module I2S_Transmitter#(parameter WIDTH = 4)(
	input logic 		clock	,
		     		nreset	,
	output logic 		ready	,
		     		SCLK	,
		     		LRCLK	,
		     		SD	,
			

	input logic [(WIDTH*2-1):0]Tx

);
	
	enum {START_STATE, LOADWORD_STATE, TRANSMITWORD_STATE} state;
	logic[1:0] next_state,current_state;
	
	logic ready_int;
	logic LRCLK_int;
	logic SD_int;
	
	logic ena_int;
 	logic [2*WIDTH-1:0] Tx_int;
	logic [3:0] bit_counter;
	always_ff@(posedge clock, negedge nreset) begin
		if(!nreset)begin
			current_state <=  START_STATE;
			bit_counter <= 15;

		end else begin
			bit_counter   <= bit_counter + 1;
			current_state <= next_state;
		end
	end
	always_comb begin
	    case(current_state)	
		START_STATE: begin
			ready_int	= 0;
			LRCLK_int	= 0;
			SD_int    	= 0;
			ena_int 	= 1;
			Tx_int 		= 0;
			next_state = TRANSMITWORD_STATE;
		end
		TRANSMITWORD_STATE: begin
			LRCLK_int = (bit_counter > (WIDTH-1)); 
			if(bit_counter < 2*WIDTH -1)begin
				ready_int = 0; 
				next_state = TRANSMITWORD_STATE;
			end else begin
				ready_int  = 1;
				Tx_int = Tx;
				next_state = TRANSMITWORD_STATE;
			end
		
			SD_int =  Tx_int & 1 << bit_counter ? 1 : 0;

		end
	endcase
	end
	always_comb begin
		ready = ready_int;
		SCLK = clock & ena_int;
		LRCLK = LRCLK_int;
		SD  = SD_int;
	end
endmodule
