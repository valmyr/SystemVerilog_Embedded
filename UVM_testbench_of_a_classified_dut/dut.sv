module ordena_2_num(input ena,
                    input cresc_ou_decres,
                    input [7:0] n1, 
                    input [7:0] n2,
                    output reg[7:0] menor,
                    output reg[7:0] maior
);
  wire n1_maior_n2 = (n1 > n2);
  wire n2_maior_n1 = (n2 > n1);
  wire n1_igual_n2 = (n2 == n1);
  always @(*) begin
    casex({ena,cresc_ou_decres,n1_igual_n2,n2_maior_n1,n1_maior_n2})
         5'b0xxxx:begin
           maior = 0;
           menor = 0;
         end
         5'b11001:begin
            maior = n1;
            menor = n2;
         end
         5'b11010:begin
            maior = n2;
            menor = n1;
         end
         5'b10001:begin
            maior = n2;
            menor = n1;
         end
         5'b10010:begin
            maior = n1;
            menor = n2;          
         end
         default:begin
            maior = n1;
            menor = n2;
         end
    endcase
  end
endmodule

module ordena_4_num(input ena,
                    input cresc_ou_decres,
                    input [7:0] n1_n, 
                    input [7:0] n2_n,
                    input [7:0] n3_n,
                    input [7:0] n4_n,
                    output[7:0] n1,
                    output[7:0] n2,
                    output[7:0] n3,
                    output[7:0] n4
);  
  wire [7:0] x1[2:0], x2[2:0];
  ordena_2_num ordenador_2_inst1(ena,cresc_ou_decres,n1_n,n2_n,x2[0],x1[0]);
  ordena_2_num ordenador_2_inst2(ena,cresc_ou_decres,n3_n,n4_n,x2[1],x1[1]);
  ordena_2_num ordenador_2_inst3(ena,cresc_ou_decres,x2[0],x2[1],n1,x1[2]);
  ordena_2_num ordenador_2_inst4(ena,cresc_ou_decres,x1[0],x1[1],x2[2],n4);
  ordena_2_num ordenador_2_inst5(ena,cresc_ou_decres,x2[2],x1[2],n2,n3);
endmodule
module ordena_8_num(input ena,
                    input cresc_ou_decres,
                    input [7:0]n1_n,
                    input [7:0]n2_n,
                    input [7:0]n3_n,
                    input [7:0]n4_n,
                    input [7:0]n5_n,
                    input [7:0]n6_n,
                    input [7:0]n7_n,
                    input [7:0]n8_n,
                    output[7:0]n1,
                    output[7:0]n2,
                    output[7:0]n3,
                    output[7:0]n4,
                    output[7:0]n5,
                    output[7:0]n6,
                    output[7:0]n7,
                    output[7:0]n8
);
   wire [7:0]x1[2:0],
             x2[2:0],
             x3[2:0],
             x4[2:0];
    ordena_4_num ordenador_4_inst1(ena,cresc_ou_decres,n1_n,n2_n,n3_n,n4_n,x1[0],x2[0],x3[0],x4[0]);
    ordena_4_num ordenador_4_inst2(ena,cresc_ou_decres,n5_n,n6_n,n7_n,n8_n,x1[1],x2[1],x3[1],x4[1]);
    ordena_4_num ordenador_4_inst3(ena,cresc_ou_decres,x1[0],x2[0],x1[1],x2[1],n1,n2,x1[2],x2[2]);
    ordena_4_num ordenador_4_inst4(ena,cresc_ou_decres,x3[0],x4[0],x3[1],x4[1],x3[2],x4[2],n7,n8);
    ordena_4_num ordenador_4_inst5(ena,cresc_ou_decres,x1[2],x2[2],x3[2],x4[2],n3,n4,n5,n6);
endmodule
module dut (a_if.inp in,
            a_if.outp out);

  always_ff @(posedge in.clock)
     if (in.reset) begin
        out.valid <= 0;
        out.a <= 0;
        out.a1 <= 0;
	out.a2 <= 0;
	out.a3 <= 0;
	out.a4 <= 0;
	out.a5 <= 0;
	out.a6 <= 0;
	out.a7 <= 0;
     end
     else if(in.valid) begin
        out.valid <= 1;
        out.a  <= st1.n1;
        out.a1 <= st1.n2;
        out.a2 <= st1.n3;
        out.a3 <= st1.n4;
        out.a4 <= st1.n5;
        out.a5 <= st1.n6;
        out.a6 <= st1.n7;
        out.a7 <= st1.n8;
     end
     else out.valid <= 0;
     ordena_8_num st1(
			.ena(1'b1),
			.cresc_ou_decres(1'b1),
			.n1_n(in.a),
			.n2_n(in.a1),
			.n3_n(in.a2),
			.n4_n(in.a3),
			.n5_n(in.a4),
			.n6_n(in.a5),
			.n7_n(in.a6),
			.n8_n(in.a7),
			.n1(),				
			.n2(),
			.n3(),
			.n4(),
			.n5(),
			.n6(),
			.n7(),
			.n8()
      );
endmodule

