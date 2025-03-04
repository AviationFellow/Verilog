
module txomux(Y,S,I);
input S;
input [1:0]I;
output Y;
assign Y=S?I[1]:I[0];
endmodule

module exomux(Y,s,I);
  input [7:0]I;
  input [2:0]s;
  output Y;
  wire [3:0]l1;
  wire [1:0]l2;
  txomux t0(l1[0],s[0],I[1:0]);
  txomux t1(l1[1],s[0],I[3:2]);
  txomux t2(l1[2],s[0],I[5:4]);
  txomux t3(l1[3],s[0],I[7:6]);
  
  txomux t4(l2[0],s[1],l1[1:0]);
  txomux t5(l2[1],s[1],l1[3:2]);
  
  txomux t6(Y,s[2],l2[1:0]);
endmodule
  
module exomux_tb();
  reg [7:0]I;
  reg [2:0]s;
  wire Y;
  
  exomux e1(Y,s,I);
  initial begin
    $monitor($time," s=%0d, I=%0d, Y=%0d", s,I,Y);
    s=3'd6;I=8'd64;
    #100
    s=3'd3;I=8'd8;
    #100
    s=3'd7;I=8'd128;
    #100;
  end
endmodule

module txomux_tb();
  reg [1:0]I;
  reg S;
  wire y;
  
  txomux t0(y,S,I);
  initial begin 
    $monitor($time," s=%0d, I=%0d, Y=%0d", S,I,y);
    I=2'd2;S=1;
    #20
    I=2'd1;S=0;
    #20
    I=2'd0;
    #20;
  end
endmodule