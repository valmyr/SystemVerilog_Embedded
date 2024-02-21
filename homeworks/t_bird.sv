interface t_bird_interface (input logic clk,rst);
	logic	HAZ	,
	   	LEFT	,
		RIGHT	;
	logic  	LC	,
		LB	,
		LA	,
		RA	,
		RB	,
		RC	;

	modport  DUT (
		input clk, rst, HAZ,LEFT,RIGHT,
		output LC,LB,LA,RA,RB,RC
	);
endinterface

module t_bird(
	t_bird_interface bus
	
);
	enum {IDLE = 0,R1,R2,R3,LR3,L1,L2,L3} states; //Estados

	logic [2:0] state, next_state;
	
	

	always_comb begin
		case(state)
			IDLE	:next_state = ~( bus.LEFT  |  bus.RIGHT |  bus.HAZ   )   ?  IDLE :
					       ( bus.HAZ   |  bus.LEFT  &  bus.RIGHT )   ?  LR3  :
					       ( bus.RIGHT & ~bus.HAZ   &  bus.LEFT  )   ?  R1   :
					       ( bus.LEFT  & ~bus.HAZ   & ~bus.RIGHT )   ?  L1   : IDLE ;
			L1	:next_state = bus.HAZ ? LR3 : L2					;
			L2	:next_state = bus.HAZ ? LR3 : L3					;
			L3	:next_state = IDLE							;
			LR3	:next_state = IDLE							;
			R1	:next_state = bus.HAZ ? LR3  : R2					;
			R2	:next_state = bus.HAZ ? LR3  : R3					;
			R3	:next_state = IDLE							;
			default :next_state = IDLE							;
		endcase

	end

	always_ff@(posedge bus.clk, posedge bus.rst)
		state <= bus.rst ? IDLE : next_state;
	always_comb begin
		case({L1,L2,L3,R1,R2,R3})
			6'b1xxxxx: {LC,LB,LA,RA,RB,RC} = 6'b100000;
			6'b01xxxx: {LC,LB,LA,RA,RB,RC} = 6'b110000;
			6'b001xxx: {LC,LB,LA,RA,RB,RC} = 6'b111000;
			6'b0001xx: {LC,LB,LA,RA,RB,RC} = 6'b000100;
			6'b00001x: {LC,LB,LA,RA,RB,RC} = 6'b000110;
			6'b000001: {LC,LB,LA,RA,RB,RC} = 6'b000111;
		endcase
	end
endmodule
