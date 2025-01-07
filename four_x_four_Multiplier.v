`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Natioanal Engineering College
// Engineer: Arumukam Ganes Moorthe.V 
// 
// Create Date: 01/06/2025 11:36:11 PM
// Design Name: 4x4 Multiplier
// Module Name: four_x_four_Multiplier

//////////////////////////////////////////////////////////////////////////////////


module four_x_four_Multiplier(
    input [3:0]a,b,
    output [7:0]y
    );
    wire [6:0]l1;
    wire [7:0]l2,l3;
    four_bit_and fb0({4{a[0]}},b,{l1[2:0],y[0]});
    four_bit_and fb1({4{a[1]}},b,l1[6:3]);
    four_bit_CSA add1({1'b0,l1[2:0]},l1[6:3],{l2[3:0],y[1]});
    four_bit_and fb2({4{a[2]}},b,l2[7:4]);
    four_bit_CSA add2(l2[3:0],l2[7:4],{l3[3:0],y[2]});
    four_bit_and fb3({4{a[3]}},b,l3[7:4]);
    four_bit_CSA add3(l3[3:0],l3[7:4],y[7:3]);
    
endmodule
//------------------------4-bit and-------------------
module four_bit_and(
    input [3:0]x,y,
    output [3:0]an
    );
    and a0(an[0],x[0],y[0]);
    and a1(an[1],x[1],y[1]);
    and a2(an[2],x[2],y[2]);
    and a3(an[3],x[3],y[3]);
endmodule

//-------------------full adder-------------------

module fulladd(
    input a, b, cin,
    output s, cout
    );
    assign s = a ^ b ^ cin;
    assign cout = (a & b) | ((a ^ b) & cin);
endmodule

//------------------4bit ripple carry adder--------
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

//---------------4bit CSA using RCA-----------------
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
