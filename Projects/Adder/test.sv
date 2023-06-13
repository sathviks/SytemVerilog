
class transaction;
  
  rand bit a ,b,cin ;
  bit sum, cout;
 
  constraint a_b {  
   
    a dist {0 :/ 20 , 1:/ 70 };
    b dist {0 :/ 50 , 1:/ 50};
    cin dist {0 :/ 50 , 1:/ 50};
  }
  
 
  
   function void display(input string tag);
     $display("[%0s] : A : %0b :: B : %0b :: Cin :%b :: sum : %0b :: cout : %0b  @ %0t", tag,a,b,cin,sum,cout,$time);   
  endfunction
  
  function transaction copy();
    copy = new();
    copy.a = this.a;
    copy.b = this.b;
    copy.cin = this.cin;
    copy.sum = this.sum;
    copy.cout= this.cout;
  endfunction
  
endclass
/*-----------------------------------------------------------------------------------------------------*/

class generator;
  
   transaction tr;
   mailbox #(transaction) mbx;
  
   int count = 0;
  
   event next;  ///know when to send next transaction
   event done;  ////conveys completion of requested no. of transaction
   
   
  function new(mailbox #(transaction) mbx);
      this.mbx = mbx;
      tr=new();
   endfunction; 
  

   task run();     
     for(count = 0 ; count < 23 ; count++)
	     begin    
           assert(tr.randomize) else $error("Randomization failed");	
           mbx.put(tr.copy);
           tr.display("GEN");
           @(next);
           #10;
         end 
     ->done;
   endtask
   
endclass
/*-----------------------------------------------------------------------------------------------------*/

class driver;
  
   virtual fulladderintrface fif;
  
   mailbox #(transaction) mbx;
  
   transaction datac;
  
   event next;
  
   
 
    function new(mailbox #(transaction) mbx);
      this.mbx = mbx;
   endfunction; 
  
  ////reset DUT
  task reset();
    fif.a <= 1'b0;
    fif.b <= 1'b0;
    fif.cin <= 1'b0;
    fif.sum <= 1'b0;
    fif.cout <= 1'b0;
   
    $display("[DRV] : DUT Reset Done");
  endtask
   
  //////Applying RANDOM STIMULUS TO DUT
  task run();
    forever begin
      
      mbx.get(datac);
      datac.display("DRV");
      fif.a <= datac.a;
      fif.b <= datac.b;
      fif.cin<=datac.cin;
      #10;
      ->next;
    end
  endtask
  
endclass


class monitor;
 
   virtual fulladderintrface fif;
  
   mailbox #(transaction) mbx;
  
   transaction tr;

    function new(mailbox #(transaction) mbx);
      this.mbx = mbx;     
   endfunction;
  
  
  task run();
    tr = new();
    
    forever begin
      #10;
      tr.a = fif.a;
      tr.b = fif.b;
      tr.cin = fif.cin;
      tr.sum = fif.sum;
      tr.cout = fif.cout;
      mbx.put(tr);
      tr.display("MON");
 
    end
    
  endtask
endclass
  
  
  
  class scoreboard;
  
   mailbox #(transaction) mbx;
  
   transaction tr;
  
   event next;
  

  
   function new(mailbox #(transaction) mbx);
      this.mbx = mbx;     
    endfunction;
  
  
  task run();
    
  forever begin
    
    mbx.get(tr);
    
    tr.display("SCO");
       begin
         if (tr.a == tr.b == tr.cin == tr.sum  == tr.cout)
           begin
           $display("Full adder verified"); 
           end
       end 
    $display("--------------------------------------");
      
    ->next;
  end
 endtask

endclass
  
  
  
  
  
  
  
  
  
  
  
class environment;
 
    generator gen;
    driver drv;
    monitor mon;
    scoreboard sco;
  
  mailbox #(transaction) gdmbx; ///generator + Driver
    
  mailbox #(transaction) msmbx; ///Monitor + Scoreboard
 
  event nextgs;
 
 
  virtual fulladderintrface fif;
  
  
  function new(virtual fulladderintrface fif);
 
    
    
    gdmbx = new();
    gen = new(gdmbx);
    drv = new(gdmbx);
    
    
    
    
    msmbx = new();
    mon = new(msmbx);
    sco = new(msmbx);
    
    
    this.fif = fif;
    
    drv.fif = this.fif;
    mon.fif = this.fif;
    
    
    gen.next = nextgs;
    sco.next = nextgs;
 
  endfunction
  
  
  
  task pre_test();
    drv.reset();
  endtask
  
  task test();
  fork
    gen.run();
    drv.run();
    mon.run();
    sco.run();
  join_any
    
  endtask
  
  task post_test();
    wait(gen.done.triggered);  
    $finish();
  endtask
  
  task run();
    pre_test();
    test();
    post_test();
  endtask
  
  
  
endclass



/*-----------------------------------------------------------*/
  
  
  
module test; 
    fulladderintrface fif();
    full_add dut (fif.a, fif.b, fif.cin,fif.sum, fif.cout);
    
   
  //  always #20    
    environment env;

    initial begin
      env = new(fif);
      env.run();
    end
        
    
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
        
   
endmodule
 