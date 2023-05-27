module tb;
  int a[5] = '{1,2,3,4,5};
  int b[5] = '{1,2,3,4,5};
  bit a= 0;
  byte b= 0;//2 state intial will be 0 ----------------for 4 state X
  shortint c = 0;
  longint  d = 0;


  //unsigned
  bit[7:0] f = 8'd0;// metion size if using bit good pratices 
  bit[16:0] g = 16'h0;

  //floating 
  real h = 0;

initial 
begin
  a =1;
end

// what if you store value more than range 


byte varl = -130;// it can hold til l -128
bit[7:0] var2 =130; // it is unsigned
 
initial 
begin
  #10;
  $display("value : %0d",varl);// output will be 126 this unexpected value 
  $display("value : %0d",var2);// output will be 130 

end

 

  

endmodule 


/*Three Data  types



Hardware : 2 types 

1.reg :- procedural block 
2.wire:- contiounes block 

// donnot mix them if verilog 

new data type SV which act as both 1+2 in hardware is "logic" datatype-----> used in interface 


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------



variavle : 2 type


1. Fixed:
1.1: 2 state: 
              if wire capble of handling  0 and 1
              1.1.1:Singned: 8 bit -byte-----------------------------------------------(-2^n-1 to (2^n-1) -1 )---- 2^7 --> -128 to 127
            
                            16bit - shortint
                            32bit - int
                            64bit - longint

               1.1.2:UnSingned:  8 bit -byte----------------------------------------------0 to 2^n -1 ;  -0 to 255
    
                                16bit - shortint
                                32bit - int
                                64bit - longint
Note:If mixed both leads unstablestate


1.2: 4 state: 
              if wire capble of handling  0 and 1,X,Z Here you us only integer

2. floting: real ----- to store floating point value 







-------------------------------------------------------------------------------------------------------------------------------------------------------------------------


3.simulation :
3.1 Fixed point time
3.1 Fixed poin real time

4.bit 
