`timescale 1ns/1ps // 10^-3 3 -- floating valus can be stored
module FA(input a,b,cin,output sum , carry);

reg t1,t2,t3;


HA h1(a, b, t1 , t2 );
HA h2(t1 ,cin , sum,t3);


assgin c = t2|t3;


endmodule




module HA(input wire a ,b output wire s, c);

assgin s =a^b;
assgin c =a&b;

endmodule


/*
full adder using struteral method 

but insted of usage of wire for interconnection of block we are using reg to throw exception --> it will throw like t1 cannot be used as output connection 



Net type cannot be used in output reg or wire type 



Wire : connection of multiple componets and whenever we have sitution where we want define an undifened net(input and outputs) we us wire not reg type 

//DONOT MIX THEM in VERILOG this diffuclties is removed in SV using LOGIC 

*/