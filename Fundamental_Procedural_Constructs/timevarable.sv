
`timescale 1ns/1ps // 10^-3 3 -- floating valus can be stored
module tb;
  time fix = 0;
  realtime realt =0;
  
  
  initial begin
    #12.245 //-->12000
    fix  = $time();//store fixed point time value
    $display("status : %0t",fix);
    #10.25//-->10250
    realt = $realtime();//store floating point point time value
    $display("status : %0t",realt);
    
  end
endmodule 

/*

$realtime() : 
            both return current simulation time 
$time():

*/