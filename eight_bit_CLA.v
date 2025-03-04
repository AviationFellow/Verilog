
module CLA4bit(A,B,Cin,S,Cout);
  input [3:0]A,B; 
  input Cin;
  output [3:0] S;
  output Cout;
  wire [3:0] Ci;
  
  assign Ci[0] = Cin;
  assign Ci[1] = (A[0] & B[0]) | ((A[0]^B[0]) & Ci[0]);
  assign Ci[2] = (A[1] & B[1]) | ((A[1]^B[1]) & ((A[0] & B[0]) | ((A[0]^B[0]) & Ci[0])));
  assign Ci[3] = (A[2] & B[2]) | ((A[2]^B[2]) & ((A[1] & B[1]) | ((A[1]^B[1]) & ((A[0] & B[0]) | ((A[0]^B[0]) & Ci[0])))));
  assign Cout  = (A[3] & B[3]) | ((A[3]^B[3]) & ((A[2] & B[2]) | ((A[2]^B[2]) & ((A[1] & B[1]) | ((A[1]^B[1]) & ((A[0] & B[0]) | ((A[0]^B[0]) & Ci[0])))))));

  assign S = A^B^Ci;
endmodule

module eb_adder(A,B,Cin,Y,Cout);
input [7:0]A,B;
input Cin;
output [7:0]Y;
output Cout;
wire x;

CLA4bit C1(A[3:0],B[3:0],Cin,Y[3:0],x);
CLA4bit C2(A[7:4],B[7:4],x,Y[7:4],Cout);

endmodule

module tb();
  reg [7:0]a,b;
  reg c;
  wire [7:0]y;
  wire co;
  
  eb_adder e1(a,b,c,y,co);
  initial begin
    a=8'd15;b=8'd115;c=0;
    #100
    a=8'd200;b=8'd15;
    #100
    a=8'd99;b=8'd59;
    #100
    $finish;
  end
endmodule