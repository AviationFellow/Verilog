module sr_flipflop(q, qb, s, r, clk, rst);
    input s, r, clk, rst;
    output q, qb;

    

module sr_ff_bm(q,qb,clk,s,r,rst);
input clk,s,r,rst;
output reg qb,q;
always @(negedge clk)
begin 
if(~rst)
  q=0;
else begin
  case({s,r})
    2'b00:q=q;
    2'b01:q=0;
    2'b10:q=1;
    2'b11:q=1'bx;
    default:q=0;
endcase
end
qb=~q;
end
endmodule
