module jk_ff_c(Q,Qb,clk,rst,J,K);
  input J,K,clk,rst;
  output reg Q,Qb;
  initial begin
		Q<=0;
		Qb<=1;
	end
	always @(negedge clk or negedge rst)
	begin
	  if(~rst) begin
			Q<=0;
			Qb<=1;
		  end
	  else if(~clk)
		  case({J,K})
		    2'b00:Q<=Q;
		    2'b01:Q<=0;
		    2'b10:Q<=1;
		    2'b11:Q<=~Q;
		    endcase
		   Qb=~Q;
	  end
	endmodule
	
module mod13_counter(Q,clk,mrst);
input clk,mrst;
output [3:0]Q;
wire x1,rst,x2,x3;

jk_ff_c jk0(Q[0],,clk,rst,{1'b1},{1'b1});
jk_ff_c jk1(Q[1],,clk,rst,Q[0],Q[0]);
jk_ff_c jk2(Q[2],,clk,rst,x2,x2);
jk_ff_c jk3(Q[3],,clk,rst,x3,x3);

and a0(x2,Q[0],Q[1]);
and a1(x3,x2,Q[2]);

assign x1=~(Q[3]&Q[2]&~Q[1]&Q[0]);
assign rst= mrst & x1;
endmodule

module mod13_counter_tb();
  reg clk,mrst;
  wire [3:0]Q;
  mod13_counter mc1(Q,clk,mrst);
  initial begin 
    clk=1; forever #5 clk=~clk;
  end
  initial begin 
    $monitor($time, " Q=%0d, mrst=%0d",Q,mrst);
    mrst=0;#2 mrst=1;
    #150 mrst=0; #2 mrst=1;
    #20 $finish;
  end
endmodule