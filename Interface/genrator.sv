/*      Important Rules     */


/*
    1. add transaction constractour in genarator custom constructor 
    2. Send Copy of trans b/w GEN and DRV
*/










class transaction;// it contain all i/o
 randc bit [3:0] a;
 randc bit [3:0] b;
 bit [4:0] sum;
  
  function void display();
    $display("a : %0d \t b: %0d ", a,b,sum);
  endfunction
  
  function transaction copy();// deep copy 
    copy = new();
    copy.a = this.a;
    copy.b = this.b;
  endfunction
  
endclass
 
 
 
class generator;
  
  transaction trans;
  mailbox #(transaction) mbx;// we need this to send data from gen to drv 
  int i = 0;
  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
    trans = new();// single object single space from deep copy
  endfunction 
  
  task run();
    for(i = 0; i<20; i++) begin
      assert(trans.randomize()) else $display("Randomization Failed");
      $display("[GEN] : DATA SENT TO DRIVER");
      trans.display();
      mbx.put(trans.copy);// to avoid the dealy error in travelling threough prouces we pass a copy of the object
      // put meanis sending data to DRV
    end
 
  endtask
   
  
endclass
 
 
 
module tb;
  
generator gen;
mailbox #(transaction) mbx;
  
  
  
  initial begin
    mbx = new();
    gen = new(mbx);
    gen.run();
    end
 
  
endmodule

