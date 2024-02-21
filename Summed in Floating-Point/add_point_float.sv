`include "./counter_zeros.sv"
module point_floating(
	input logic 		clk			,
			    		reset		,
	input logic [31:0] 	a			,
			   			b			,
	output logic [31:0] s2			
);

	logic [7 :0] exp_a, exp_b, exp_s;
	logic [2:0] state;
	logic [22:0] aux1;
	logic [0:22] aux2;
	logic [23:0] m_a, m_b;

	logic [24:0] temP;	
	logic signal_a, signal_b, signal_s;
	logic [31:0] s2_t;


	logic [5:0] zeros_shift_left;
	logic [4:0] shift;
	logic ena_zero;

	logic [3:0]  next_state;
	enum {assign_mant_exp	 = 0,shift_right,idle,zeros_counter,calculation,finish} states;

	counter_zeros count_ze(
				.ena	(	1	),
				.in	(	temP[23:0]),
				.zeros	( 	zeros_shift_left)
	);
	always_comb begin
		case(state)
			assign_mant_exp:begin
								exp_a = a[30:23];
								exp_b = b[30:23];
								signal_a = a[31];
								signal_b = b[31];
								next_state = shift_right;
								s2_t = 0;
								temP = 0;
								m_a = 0;
								m_b = 0;
								exp_s =0 ;
			end
			shift_right:begin
								if(exp_a == exp_b)begin		
									m_b   =  {1'b1,b[22:0]}; 
									m_a   =  {1'b1,a[22:0]};
									exp_s = exp_a;	
								end
								else if(exp_a > exp_b)begin								
									shift =  exp_a - exp_b;
									m_b   = (exp_b == 0 && b[22:0] == 0)? 0 :  ({1'b1,b[22:0]}) >> shift; 
									m_a   =  ({1'b1,a[22:0]});
									exp_s = exp_a;	
								end
								else begin
								    shift =  exp_b - exp_a;
									m_a   =  (exp_a == 0 && a[22:0] == 0 ) ? 0 : ({1'b1,a[22:0]}) >> shift;
									m_b   =  ({1'b1,b[22:0]});
									exp_s = exp_b;
								end
								next_state = calculation;
								
			end
			calculation:begin
								if(signal_a == signal_b)begin
									temP  = (m_a[22:0] == 0 && exp_a == 0) ? m_b :(m_b[22:0] == 0 && exp_b == 0) ? m_a : m_a+m_b;
									s2_t[31] = signal_a; //Como os sinais dos números neste caso são idênticos o sinal não importa pode se o de a ou b
									s2_t[22:0] = temP[24] ? temP >> 1 :  temP;
									s2_t[30:23] = temP[24] ? exp_s + 1:exp_s;
									next_state = idle;
								end
								else begin
				
								
										temP = m_a > m_b ? m_a - m_b : m_b - m_a;
										if(temP[24:23] != 0)begin
											s2_t[31]  = exp_a > exp_b ? signal_a  : signal_b;
											s2_t[30:23] =  exp_a > exp_b ? exp_a     : exp_b;
											s2_t[22:00] = temP[22:0];			
										next_state = finish;
										end
										else begin
											next_state = zeros_counter; 
										end
								
									
								end
			end
			idle:begin
								next_state = finish;
			end
			zeros_counter:begin
									s2_t[31] 	= (exp_a > exp_b) ? signal_a : signal_b;
									s2_t[30:23] = (exp_a > exp_b) ? exp_a - zeros_shift_left: exp_b - zeros_shift_left;
									s2_t[22:00] =  temP << zeros_shift_left  ;
							
								next_state = finish;
							end	
			finish:begin
								next_state = assign_mant_exp; 
			end
			default:begin 		next_state = assign_mant_exp;
                                s2_t = 0;
                                temP = 0;
                                m_a = 0;
                                m_b = 0 ;
                                exp_s = 0 ;
							end
		endcase
	end
	always_ff@(posedge clk,posedge reset)state <= reset ? assign_mant_exp : next_state; 
	assign s2 = state == finish ? s2_t : 0;	
endmodule

