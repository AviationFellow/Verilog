`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// College: National Engineering College, Kovilpatti
// Engineer: Arumukam Ganes Moorthe V
// 
// Create Date: 12/24/2024 04:00:17 PM
// Design Name: 
// Module Name: fulladder
// Project Name: 
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
module fulladder(
    input a,
    input b,
    input c,
    output s,
    output cout
    );
    
    assign s=a^b^c;
    assign cout=(a&b)+((a^b)&c);
endmodule
