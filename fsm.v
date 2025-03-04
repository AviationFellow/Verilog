module fsm(q,clk,rst,x);
input x,rst,clk;
output reg q;
reg [1:0]s0,s1,s2,ns,ps;
initial begin
  s0=2'd0;s1=2'd1;s2=2'd2;
  ps<=s0;
end
always @(x,ps) begin
  case(ps)
    s0: ns=x?s1:s0;
    s1: ns=x?s1:s2;
    s2: ns=x?s1:s0;
  endcase
end

always @(negedge clk or negedge rst) 
ps<=(rst)?ns:s0;

always @(x,ps)
 q=(ps==s2)?(x)?1:0:0;
 
endmodule

module fsm_tb();
  reg clk,rst,x;
  wire q;
  fsm f0(q,clk,rst,x);
  initial begin
    clk=1; forever #5 clk=~clk;
  end
  initial begin
    $monitor($time," rst=%0d; x=%0d; q=%0d", rst,x,q);
    rst=0;x=0; #2 rst=1; #10 x=1;
    #10 x=0; #10 x=1; #10 x=0; #10 x=1;#10 rst=0;
    $finish;
  end
endmodule

module fsm1(q,clk,rst,x,ps,ns);
  input clk,rst,x;
  output reg q;
  reg [1:0]s0,s1,s2,s3; output reg [1:0]ns,ps;
  initial begin
    s0=2'd0;s1=2'd1;s2=2'd2;s3=2'd3;
    ps=s0;
  end
  always @(x,ps) begin
    case(ps)
      s0: ns=(x==1)?s1:s0;
      s1: ns=(x==0)?s2:s1;
      s2: ns=(x==1)?s3:s1;
      s3: ns=(x==1)?s0:s2;
      endcase
    end
  always @(negedge clk or negedge rst)
  begin 
    ps<=rst?ns:s0;
    end
  always @(ps,x)
  begin
    if(ps==2'd3) q<=x?1:0;
    else q<=0;
    end
endmodule

module fsm1_tb();
  reg clk,rst,x;
  wire q;
  wire [1:0]ps,ns;
  fsm1 f0(q,clk,rst,x,ps,ns);
  initial begin
    clk=1; forever #5 clk=~clk;
  end
  initial begin
    $monitor($time," rst=%0d; x=%0d; q=%0d", rst,x,q);
    rst=0;x=0; #2 rst=1; #8 x=1;
    #10 x=0; #10 x=1; #10 x=1; #10 x=0; #10 x=1; #10
    $finish;
  end
endmodule

module fsm2(q,clk,rst,x,ps,ns);
  input clk,rst,x;
  output reg q;
  output reg [2:0]ps,ns;
  reg [2:0]s0,s1,s2,s3,s4;
  initial begin 
    s0=3'd0; s1=3'd1; s2=3'd2; s3=3'd3; s4=3'd4;
    ps<=s0;
  end
  always @(ps,x)
  begin
  case(ps)
      s0: ns=(x==1)?s1:s0;
      s1: ns=(x==0)?s2:s1;
      s2: ns=(x==1)?s3:s0;
      s3: ns=(x==0)?s4:s1;
      s4: ns=(x==1)?s3:s0;
      endcase
    end
  always @(negedge clk or negedge rst)
  begin
    ps<=(rst)?ns:s0;
  end
  
  always @(ps)
  q=(ps==s4)?1:0;
endmodule

module fsm2_tb();
  reg clk,rst,x;
  wire q;
  wire [2:0]ps,ns;
  fsm2 f0(q,clk,rst,x,ps,ns);
  initial begin
    clk=1; forever #5 clk=~clk;
  end
  initial begin
    $monitor($time," rst=%0d; x=%0d; q=%0d", rst,x,q);
    rst=0;x=0; #2 rst=1; #10 x=1;
    #10 x=0; #10 x=1; #10 x=0; #10 x=1;#10 rst=0;
    $finish;
  end
endmodule