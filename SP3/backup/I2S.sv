`include "./I2S_Transmitter.sv"
module I2Smodule #(parameter RATIO =8, WIDTH = 4)(input logic MCLK, nreset, output logic SCLK, LRCLK, output logic SD);

	
	logic 	    [2*WIDTH-1:0]	Tx		;
	logic 	    [2*WIDTH-1:0]	ROM_Data[200:0]	;
	logic 		    [6:0]	ROM_Address	;
	logic 				ready		;
	logic 				clock_audio	;

	logic 	 [$clog2(RATIO):0]	counter;
	logic 		    [2:0]	next_state, current_state;
	logic 	      [WIDTH-1:0]	WordCounter;


	initial begin $readmemh("Wave.txt",ROM_Data); end

	enum {Start_STATE, WaitForReady_STATE,IncreaseAddress_STATE, WaitForStart_STATE}states;
	I2S_Transmitter #(.WIDTH(WIDTH))transmitterU1

	(
				.clock	(	clock_audio	),
				.nreset	(	nreset		),
				.ready	(	ready		),
				.LRCLK	(	LRCLK		),
				.SCLK	(	SCLK		),
				.SD	(	SD		),
				.Tx	(	Tx		)

	);	
	always_comb begin
			case(current_state)
			Start_STATE:begin
				next_state = WaitForReady_STATE;;	
			end
			WaitForReady_STATE:begin
				next_state  = ready ? WaitForStart_STATE : WaitForReady_STATE;
				if(ready)begin
					ROM_Address = WordCounter;
	                                Tx = ROM_Data[ROM_Address];
				end	
			end
			WaitForStart_STATE:begin
				next_state = ready ? IncreaseAddress_STATE : WaitForStart_STATE;	
			end	
			IncreaseAddress_STATE:begin
				next_state = WaitForReady_STATE;
			end
		endcase
	
	end
	always_ff@(posedge ready, negedge nreset) wait(transmitterU1.current_state == transmitterU1.TRANSMITWORD_STATE) WordCounter <= nreset ? WordCounter+1: $pow(2,WIDTH)-1;
        always_ff@(posedge MCLK, negedge nreset)begin
                if(!nreset)begin
                                        counter <= 0;
                                        clock_audio <= 0;
                                        current_state <= Start_STATE;
		end else begin          current_state <= next_state;
	                if(counter < RATIO/2 -1) counter <= counter + 1;
		        else begin
       	                             	counter <= 0;
                                        clock_audio <=  ~clock_audio;
            		end

		end     
        end



	
endmodule
