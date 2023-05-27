module tb;
  int a[5] = '{1,2,3,4,5};
  int b[5] = '{1,2,3,4,5};
  
  int equals;
  int notequals;
  
  initial begin
    equals = (a == b);
    $display("status equals : %0d",equals);
    
    notequals = (a != b);
    $display("status notequals: %0d",notequals);
    
  end
endmodule 


/*output:
# KERNEL: status equals : 1
# KERNEL: status notequals: 0
*/