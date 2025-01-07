`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Engineering College, kovilpatti
// Engineer: Arumukam Ganes Moorthe V 
// 
// Create Date: 01/02/2025 08:43:02 PM
// Design Name: Serial In Serial out Shift reg
// Module Name: siso
// Project Name: siso
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module siso(
    input d,
    input clk,
    input rst,
    output op
    );
    wire [3:1]x;
    d_ff d0(d,clk,rst,x[1]);
    d_ff d1(x[1],clk,rst,x[2]);
    d_ff d2(x[2],clk,rst,x[3]);
    d_ff d3(x[3],clk,rst,op);
endmodule

module d_ff(
    input data,
    input clk,
    input rst,
    output reg opt
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            opt <= 0;
        else
            opt <= data;
    end
endmodule