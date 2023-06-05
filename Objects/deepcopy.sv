//deep copy
class first;
  int data = 12;
  
  function first copy();
    copy = new();
    copy.data = data;
  endfunction
  
 
endclass
 
class second;
  
  int ds = 34;
  
  first f1;
  
  function new();
    f1 = new();
  endfunction
  function int sum();
    return 3;
  endfunction
  function second copy();
    copy = new();
    copy.ds = ds;
    copy.f1 = f1.copy;
  endfunction

endclass

class third;
  
  int dsthird = 340;
  
  first f1;
  second s2;
  
  function new();
    f1 = new();
    s2 =new();
  endfunction
  
  
  function third copy();
    copy = new();
    copy.dsthird = dsthird;
    copy.f1 = f1.copy;
    copy.s2 = s2.copy;
  endfunction

endclass

 
module tb;
  
  third s1, s2;
  first f;
  second s;
  
  initial begin
    f=new();
    s=new();
    s1 = new();
    s2 = new();
    
    s1.dsthird = 45;
    
    s2 = s1.copy();
    s2.f1.data= 100;
    
    $display("Value of ds of first class from third : %0d", s2.f1.data);
    $display("Value of ds of first  : %0d", f.data);
    $display("Value of ds of second from third : %0d", s2.s2.ds);
    $display("Value of ds of second  : %0d", s.ds);

   
  end
  
  
  
endmodule



/* output 

# KERNEL: Value of ds of first class from third : 100
# KERNEL: Value of ds of first  : 12
# KERNEL: Value of ds of second from third : 34
# KERNEL: Value of ds of second  : 34
*/