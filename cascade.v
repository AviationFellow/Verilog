module mux(I1,I2,S,Y);
  input I1,I2,S;
  output Y;
  assign Y=S?I2:I1;
endmodule

module demux(I,S,Y1,Y2);
  input I,S;
  output Y1,Y2;
  assign Y1=~S&I;
  assign Y2=S&I;
endmodule

module cascade(x,y,z,f);
  input x,y,z;
  output f;
  wire f0,f1;
  
  demux d1(x,y,f0,f1);
  mux m1(f0,f1,z,f);
endmodule