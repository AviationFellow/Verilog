module siso(q,d,clk,rst);
input d,clk,rst;
output q;
wire [2:0]s;
d_ff d0(s[0],,clk,rst,d);
d_ff d1(s[1],,clk,rst,s[0]);
d_ff d2(s[2],,clk,rst,s[1]);
d_ff d3(q,,clk,rst,s[2]);
endmodule

module siso_tb();
  reg d,clk,rst;
  wire q;
  siso s0(q,d,clk,rst);
  initial begin
    clk=1;
    forever #5 clk=~clk;
  end
  initial begin
    $monitor($time," d=%0d,rst=%0d,q=%0d",d,rst,q);
    rst=0; d=0;
    #2 rst=1; #10 d=1; #10 d=0; #40
    $finish;
  end  
endmodule

module sync_counter(Q,clk,rst);
input clk,rst;
output [1:0]Q;
  jk_ff jk0(Q[0],,clk,rst,{1'b1},{1'b1});
  jk_ff jk1(Q[1],,clk,rst,Q[0],Q[0]);
endmodule

module sync_counter_tb();
  reg clk,rst;
  wire [1:0]Q;
  sync_counter sc0(Q,clk,rst);
  initial begin 
    clk=1; 
    forever #5 clk=~clk;
  end
  initial begin 
    $monitor($time," rst=%0d,q=%0d",rst,Q);
    rst=0;#2 rst=1; #50
    $finish;
  end
endmodule