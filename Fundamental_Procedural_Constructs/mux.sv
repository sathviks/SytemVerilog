`timescale 1ns / 1ps
module mux(input a,b,s,output y);
//procedural block

logic temp = 0;


always @(*)
begin
if(s==1'b0)
    temp =a;
else
    temp = b;
 
end

assign y = temp;

endmodule
