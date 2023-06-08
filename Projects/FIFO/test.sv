/* 
ENV:Hold GEN,DRV,MON,SCO together
Test:Holds ENV and control simulation proccess



Transcation Class:
                1)Add (2s/4s)(bit/logic) varible for all ports (DUT) execept global signals
                2)Add Modifier for input port (rand / randc)
                3)canstraints
                4)methods : Print values ,copy()

    Genrator Class:
                1)Randomize transaction 
                2)Send trasaction to Driver
                3)Sense Event from SCO and DRV --> next transcation 
    

    Driver Class:
                1)Recive transcation from generator
                2)Apply reset to DUT this used in env
                3)Apply transaction to DUT with Interface
                4)Notify generator --> completion of Interface trigger


                connecting event in DRV AND GEN together is referred as merging of events

*/


class transaction;
  
  rand bit rd ,wr;
  rand bit [7:0] data_in;
  bit full, empty;
  bit [7:0] data_out;
  
  constraint wr_rd {  
    rd != wr;
    wr dist {0 :/ 50 , 1:/ 50};
    rd dist {0 :/ 50 , 1:/ 50};
    
  }
 
  
   constraint data_con {
  data_in > 1; data_in < 5;  
  }
  
  
   function void display(input string tag);
     $display("[%0s] : WR : %0b\t RD:%0b\t DATAWR : %0d\t DATARD : %0d\t FULL : %0b\t EMPTY : %0b @ %0t", tag, wr, rd, data_in, data_out, full, empty,$time);   
  endfunction
  
  function transaction copy();
    copy = new();
    copy.rd = this.rd;
    copy.wr = this.wr;
    copy.data_in = this.data_in;
    copy.data_out= this.data_out;
    copy.full = this.full;
    copy.empty = this.empty;
  endfunction
endclass

class generator

   mailbox #(transaction) mbx;
  
   transaction tr;
   int count =0;
   event next;  // when to send next transcation

   event done; // conveys completion of requested no. of tranction 

    function new(mailbox #(transaction) mbx);
      this.mbx = mbx;
      tr = new();
   endfunction; 


   task run ();

    repeat(count)
    begin
    assert(tr.randomize()) else $error("Randomization Failed");
    mbx.put(tr.copy);
    tr.display("GEN");
    @(next);
    end
    ->done
   endtask

endclass

class driver;
  
   virtual fifo_if fif;
  
   mailbox #(transaction) mbx;
  
   transaction datac;
  
   event next;
  
   
 
   function new(mailbox #(transaction) mbx);
      this.mbx = mbx;
   endfunction; 
  
  ////reset DUT
  task reset();
    fif.rst <= 1'b1;
    fif.rd <= 1'b0;
    fif.wr <= 1'b0;
    fif.data_in <= 0;
    repeat(5) @(posedge fif.clock);
    fif.rst <= 1'b0;
  endtask
   
  //////Applying RANDOM STIMULUS TO DUT
  task run();
    forever begin
      mbx.get(datac);
      datac.display("DRV");
      
      fif.rd <= datac.rd;
      fif.wr <= datac.wr;
      fif.data_in <= datac.data_in;
      repeat(2) @(posedge fif.clock);// this delay depants on type of FIFO
      ->next;
    end
  endtask
  
  
endclass
 
 
 
 
  module tb;
    
    generator gen;
    
    driver drv;
    
    event next;
    
    mailbox #(transaction) mbx;
    
    fifo_if fif();
    
    fifo dut (fif.clock, fif.rd, fif.wr,fif.full, fif.empty, fif.data_in, fif.data_out, fif.rst);
    
    initial begin
      fif.clock <= 0;
    end
    
    always #10 fif.clock <= ~fif.clock;
    
    initial begin
      mbx = new();
      
      gen = new(mbx);
      
      gen.count = 20;
      
      drv = new(mbx);
      
      drv.fif = fif;
      gen.next = next;
      drv.next = next;
      
      
    end
    
    initial begin
      fork
        gen.run();
        drv.run();
      join
    end
    
    initial begin
      #800;
      $finish();      
    end
    
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
    
    
  endmodule