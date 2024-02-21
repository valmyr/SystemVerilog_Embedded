module comb #(parameter WIDTH = 32)(input logic clock, ena, reset, input logic [WIDTH-1:0] x_in, output logic [WIDTH-1:0] y_out);
	logic [WIDTH-1:0] regDelay;
	always@(posedge clock, posedge reset)begin
		if(reset)begin
			y_out <= 0;
			regDelay <= 0;
		end
		else begin
			if(x_in)begin
				regDelay <= x_in;
				y_out<= x_in - regDelay;
			end
			else begin
				regDelay <= regDelay ;
				y_out	 <= y_out    ;
			end
		end

	end

endmodule
