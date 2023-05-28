`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*

Size of this type shrink and grow automatically at run time 

no need to define the size before simulation 


this can be accesssed from any loction directly using index it


queues >>> array in operations  


it is effeciently utilizing memory comp to array

*/
//////////////////////////////////////////////////////////////////////////////////


module queues; 

int arr[$]; // this is how declare queus


initial begin 
arr = { 1,2,3};
arr.push_front(7);

$display("display : %0p", arr);
arr.push_back(0);

$display("display : %0p", arr);           

arr.insert(0,9);

$display("display : %0p", arr);           
    
arr.delete(0);//0 is index
$display("display : %0p", arr);           

arr.pop_back();// return type is int 
$display("display : %0p", arr);           

end



endmodule
