class generator;
  
  transaction trans;
  mailbox #(transaction) mbx;// we need this to send data from gen to drv 
  int i = 0;

  
  task run();    
    for(i = 0; i<20; i++) begin

     trans = new();// this will create new object with out carring histroy this is problem 


      assert(trans.randomize()) else $display("Randomization Failed");
      $display("[GEN] : DATA SENT TO DRIVER");
      trans.display();
      mbx.put(trans.copy);
    end
 
  endtask

endclass
   