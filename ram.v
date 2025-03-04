module ram(data_out,en,rw,clk,data_in,addr);
input clk,rw,en;
input [9:0]addr;
input [7:0]data_in;
output reg [7:0]data_out;

reg [7:0]mem[1023:0];

always@(negedge clk) begin
  if(en) begin
    if(~rw) 
      mem[addr]<=data_in; 
    else if(rw) 
      data_out<= mem[addr]; 
    end
  else
    data_out<=8'bxxxxxxxx;
  end
endmodule

module ram_tb();
  reg clk,rw,en;
  reg [7:0]data_in;
  reg [9:0]addr;
  wire [7:0]data_out;
  ram r0(data_out,en,rw,clk,data_in,addr);
  initial begin
    clk=1; forever #5 clk=~clk;
  end
  initial begin
    $monitor($time," en=%0d; rw=%0d; data_in=%0d; addr=%0d; data_out=%0d;",en,rw,data_in,addr,data_out);
    en=1; rw=0; data_in=8'd130; addr=10'd200;
    #10 rw=1;
    #10 rw=0; data_in=8'd52; addr =10'd1000;
    #10 rw=1;
    #10 rw=0; data_in=8'd200; addr=13;
    #10 rw=1;
    #10 $finish;
    
  end
    
endmodule