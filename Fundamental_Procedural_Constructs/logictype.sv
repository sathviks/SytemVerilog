
`timescale 1ns/1ps // 10^-3 3 -- floating valus can be stored
module logictype(input a,b,cin,
                  output sum , carry);

logic t1,t2,t3;


HA h1(a, b, t1 , t2 );
HA h2(t1 ,cin , sum,t3);


assign carry = t2|t3;


endmodule




module HA(input logic a ,b, 
          output logic  s, c);

assign s =a ^ b;
assign c =a & b;

endmodule

