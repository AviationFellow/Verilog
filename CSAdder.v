
module fulladd(
    input a, b, cin,
    output s, cout
    );
    assign s = a ^ b ^ cin;
    assign cout = (a & b) | ((a ^ b) & cin);
endmodule


module four_bit_ripple(
    input [3:0] a, b,
    input cin,
    output [3:0] s,
    output cout
    );
    wire [2:0] w;
    fulladd f0(a[0], b[0], cin, s[0], w[0]);
    fulladd f1(a[1], b[1], w[0], s[1], w[1]);
    fulladd f2(a[2], b[2], w[1], s[2], w[2]);
    fulladd f3(a[3], b[3], w[2], s[3], cout);
endmodule


module four_bit_CSA(
    input [3:0] a, b,
    output [4:0] s
    );
    wire cin = 1'b0;
    wire [3:0] c;
    wire [2:0] su;
    wire cout;
    fulladd f0(a[0], b[0], cin, s[0], c[0]);
    fulladd f1(a[1], b[1], cin, su[0], c[1]);
    fulladd f2(a[2], b[2], cin, su[1], c[2]);
    fulladd f3(a[3], b[3], cin, su[2], c[3]);
    four_bit_ripple fbr0(c, {1'b0, su}, cin, s[4:1],cout);
endmodule

module tb();
  reg [3:0] a, b;
  wire [4:0] y;

  four_bit_CSA e1(a, b, y);

  initial begin
    $monitor($time, " a=%0d, b=%0d, y=%0d", a, b, y);
    a = 4'd4; b = 4'd5; #100;
    a = 4'd2; b = 4'd4; #100;
    a = 4'd9; b = 4'd5; #100;

    $finish;
  end
endmodule
