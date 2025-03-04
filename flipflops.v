module d_ff(Q,Qb,clk,rst,D);
	input clk,rst,D;
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
		else begin
			Q<=D;
			Qb<=~D;
		end
	end
endmodule

module dff_tb();
  reg D,rst,clk;
  wire Q,Qb;
  d_ff DF1(Q,Qb,clk,rst,D);
  initial begin
    clk=1;
    forever #5 clk=~clk;
  end
  initial begin
    $monitor($time," D=%0d,rst=%0d,Q=%0d,Qb=%0d",D,rst,Q,Qb);
    D=0;rst=0;
    #2
    rst=1;
    #20
    D=1;
    #20
    D=0;
    #20
    D=1;
    #20
    $finish;
   end
 endmodule
 
  

module jk_ff(Q,Qb,clk,rst,J,K);
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
		else begin
		  case({J,K})
		    2'b00:Q=Q;
		    2'b01:Q=0;
		    2'b10:Q=1;
		    2'b11:Q=~Q;
		    endcase
		   Qb<=~Q;
		   end
	  end
	endmodule

module jk_tb();
  reg J,K,clk,rst;
  wire Q,Qb;
  jk_ff JK1(Q,Qb,clk,rst,J,K);
  initial begin
    clk=1;
    forever #5 clk=~clk;
  end
  initial begin
    $monitor($time," J=%0d,K=%0d,rst=%0d,Q=%0d,Qb=%0d",J,K,rst,Q,Qb);
    J=0;K=0;rst=0;
    #2
    rst=1;
    #20
    J=1;
    #20
    J=0;K=1;
    #20
    J=1;
    #20
    $finish;
   end
 endmodule
  