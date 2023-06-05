//Shallow_copy 
class first;
  int data= 10;
endclass

class second;
  int ds = 100;
endclass


class thrid;
  int f =103;
  first f1;
  second s2;
  
  function new();
    f1= new();
    s2 = new();
  endfunction 
endclass
  
  
module tb ;
  thrid t1,t2;
  second s;
  first f;
  
  
  
  initial begin
  f=new();
  s= new();
  t1 = new();
  t1.s2.ds =45;
  t2 = new t1;
   
    $display("Value of ds in t1 object: %0d", t1.s2.ds);  
    $display("Value of ds in t2 object: %0d", t2.s2.ds);  
    $display("Value of ds in s object: %0d", s.ds);  
    
  t2.s2.ds = 78;
    
    
    $display("Value of ds in t1 object: %0d", t1.s2.ds);  
    $display("Value of ds in t2 object: %0d",t2.s2.ds);
    
   t2.f1.data = 360;
    
    $display("Value of data in t1 object: %0d", t2.f1.data);  
    $display("Value of data in t2 object: %0d", t2.f1.data);
    $display("Value of data in first  object: %0d", f.data);
    
  end
    
  
endmodule


/* output 
	# KERNEL: Value of ds in t1 object: 45
# KERNEL: Value of ds in t2 object: 45
# KERNEL: Value of ds in s object: 100
# KERNEL: Value of ds in t1 object: 78
# KERNEL: Value of ds in t2 object: 78
# KERNEL: Value of data in t1 object: 360
# KERNEL: Value of data in t2 object: 360
# KERNEL: Value of data in first  object: 10

*/