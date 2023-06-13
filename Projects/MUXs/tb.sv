`include "mux.sv"
class transaction;
  
  rand bit a ,b,en ;
  bit D0, D1, D2, D3;
 
  constraint a_b {  
   
    a dist {0 :/ 20 , 1:/ 70 };
    b dist {0 :/ 50 , 1:/ 50};
    en dist {0 :/ 25 , 1:/ 75};
  }
  
 
  
   function void display(input string tag);
     $display("[%0s] :EN :%b :: A : %0b :: B : %0b  :: D0 : %0b :: D1 : %0b  :: D2 : %0b:: D3: %0b @ %0t", tag ,en,a,b,D0, D1, D2, D3,$time);   
  endfunction
  
  function transaction copy();
    copy = new();
    copy.a = this.a;
    copy.b = this.b;
    copy.en  = this.en;
    copy.D0 = this.D0;
    copy.D1 = this.D1;
    copy.D2= this.D2;
    copy.D3= this.D3;
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
  
   virtual decoder_2_to_4_df_v fif;
  
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
    fif.en <= 1'b0;
    fif.D0<= 1'b0;
    fif.D1<= 1'b0;
    fif.D2<= 1'b0;
    fif.D3<= 1'b0;
    
    
    $display("[DRV] : DUT Reset Done");
  endtask
   
  //////Applying RANDOM STIMULUS TO DUT
  task run();
    forever begin
      
      mbx.get(datac);
      datac.display("DRV");
      fif.a <= datac.a;
      fif.b <= datac.b; 
      fif.en<=datac.en;
      #10;
      ->next;
    end
  endtask
  
endclass


class monitor;
 
   virtual decoder_2_to_4_df_v fif;
  
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
      tr.en= fif.en;
      tr.D0 = fif.D0;
      tr.D1= fif.D1;
	  tr.D2 = fif.D2;          
      tr.D3 = fif.D3;
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
 
 
  virtual decoder_2_to_4_df_v fif;
  
  
  function new(virtual decoder_2_to_4_df_v fif);
 
    
    
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
    
   
    
    decoder_2_to_4_df_v fif();
    decoder_2_to_4_df dut (fif.en,fif.a,fif.b,fif.D0,fif.D1,fif.D2,fif.D3);
    
   
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
 