module filter #(parameter LENGTH = 5, SIZE = 8)(input logic clock, reset, input logic [SIZE-1:0] x_in, output logic [SIZE-1:0] y_out);
	logic [SIZE-1:0] regDelay[LENGTH-1:0];
	logic [2:0] counter;
	logic [SIZE-1:0]  x, y;
	logic ena;
	assign x = x_in/LENGTH;
	assign y_out = (counter == LENGTH-1)? y : 0;
	always_ff @(posedge clock, posedge reset)begin
		
		if(reset)begin 
			 counter <= 0;
			 regDelay[0] <= 0;
			 regDelay[1] <= 0;
			 regDelay[2] <= 0;
			 regDelay[3] <= 0;
			 regDelay[4] <= 0;
			 y <= 0;
			 ena <= 0;
		end
		else begin 
		    counter <= ~(counter == LENGTH-1 ) ? counter + 1 : 0;
		    case({ena,counter})
        	        3'b000:      regDelay[0] <= x;
	                3'b001:	begin regDelay[0] <= x;
                        	regDelay[1] <= regDelay[0];
                	end
                	3'b01:	begin regDelay[0] <= x;
                        	regDelay[1] <= regDelay[0];
                        	regDelay[2] <= regDelay[1];
               	 	end
                	3'b011:begin regDelay[0] <= x;
                        	regDelay[1] <= regDelay[0];
                        	regDelay[2] <= regDelay[1];
                        	regDelay[3] <= regDelay[2];
                	end
			default:begin
				regDelay[0] <= x;
                                regDelay[1] <= regDelay[0];
                                regDelay[2] <= regDelay[1];
                                regDelay[3] <= regDelay[2];
				regDelay[4] <= regDelay[3];
                                ena <= 1;

			end

        	     endcase
	            y <=  y + x - regDelay[LENGTH-1];
		end		
	end
endmodule
