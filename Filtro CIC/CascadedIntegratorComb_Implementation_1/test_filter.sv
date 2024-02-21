//`include "./filter.sv"
`include "./filtro_em_cascata.sv"
module tb();
	logic clock, reset;
	logic [31:0] x_in, y_out;
	int output_file;
	logic [31:0] input_file [1000:0],  k[1000:0];
	int test;
	string line;
	filter cic1(
			.clock    (	clock	),
			.reset 	  (	reset	),
			.x_in     (  	x_in 	),
		        .y_out     (	y_out	)	
	);
	initial
		repeat(1000)begin #1 clock = 0;
			        #1 clock = 1;		
		end
	

	initial begin
	
		output_file = $fopen("./output.txt");
		
		$readmemh("input2_t.txt",input_file);
		reset = 1;
		#1reset = 0;

		for(int i =0; i < 1000; i++)begin
			@(posedge clock)begin
		       			x_in = input_file[i];
					 $fdisplay(output_file,"%h",cic1.y_out);
					 $display("%h",cic1.x_in);	
				 end
				 end
	end

	
	initial begin
		//$monitor("%d %d | %d %d %d %d | %d",x_in,cic1.y,cic1.regDelay[0], cic1.regDelay[1], cic1.regDelay[2], cic1.regDelay[3],cic1.y_out);
		//$monitor(cic1.x_in,cic1.y_out);
	end


endmodule
