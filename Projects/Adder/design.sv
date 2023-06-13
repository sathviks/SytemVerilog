// Code your design here
module hafladder(input a,b , output s,c);
xor x1(s,a,b);
and x2(c,a,b);  
  
  /*
  OR by using continous assigmet
assign sum  = a ^ b;
assign carry = a|b;
  */
endmodule : hafladder



module full_add(a,b,cin,sum,cout);
  input a,b,cin;
  output sum,cout;
  wire w1,w2,w3;
 
// instantiate building blocks of full adder 
  hafladder h1(a,b,w1,w2);
  hafladder h2(w1,cin,sum,w3);
  or r(cout,w2,w3);
  
  
  
endmodule : full_add