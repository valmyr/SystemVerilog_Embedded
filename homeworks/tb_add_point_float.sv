`include "./add_point_float.sv"
module tb;
	logic [31:0] a,b,s0,s1,s2;
	logic [64:0]temP;
	logic [5:0] f;
	logic clk,reset;
	logic [3:0]state;
	point_floating addr1(
		.clk(clk),
		.a(a),
		.b(b),
		.s2(s2),
		.reset(reset)
	);
	real esperado,obtido, pass, all;
	logic [31:0] mem [3000];
	int i,clk_counter;

	initial begin
	
		$readmemb("point_test.txt",mem);
		clk = 0;
		i = 0;
		pass =1;
		all =1;
		$display("	S	EXP		Mantissa	real");
		#9245
		$display("      S       EXP             Mantissa        real");
		$display("Fail %f%",(100-(pass/all)*100));
                $display("Pass %f%",(pass/all)*100);
                $display("Total samples %d",all);
                $display("-------------------------------------------------------");

		$finish;
	end
	always @(posedge clk)
	begin
		reset = 1;
	        reset = 0;
		@(negedge clk)begin
		a = mem[0+i];
                b = mem[1+i];
		end
		if(addr1.state == 5)begin
		$display("-------------------------------------------------------");
                print_floating_point(a,"A   = ");
                print_floating_point(b,"B   = ");
                obtido   = print_floating_point(s2,"Esp = ");
                esperado = print_floating_point(mem[2+i],"Ref = ");
                $display("-------------------------------------------------------");
                $display("                      %s",(obtido > esperado?  obtido - esperado : esperado - obtido) < $pow(10,-5) ? "Pass":"Fail");
                $display("-------------------------------------------------------");
                if((obtido > esperado?  obtido - esperado : esperado - obtido) < $pow(10,-5)) pass+=1;
                all+=1;
		i+=3;
		end
	end
	always #1 clk = ~clk;

	function real print_floating_point;

		input logic [31:0] k;
		input string str;
		begin
		
			$display("%s %b %b %b %f",str,k[31],k[30:23],k[22:0],(k[31]  ? -1: 1)*(k[31]  ? -1: 1)*({1'b1,k[22:0]}/$pow(2,(23 - (k[30:23]-127)))));    
						return (({1'b1,k[22:0]}/$pow(2,(23 - (k[30:23]-127)))));
		end
	endfunction	
	endmodule
