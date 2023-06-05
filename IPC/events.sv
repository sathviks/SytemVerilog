/*Event */
/*module tb;
 event a1,a2;
  
  initial begin
    ->a1;
    ->a2;
  end
  
  initial begin
    wait(a1.triggered);
    $display("Event A1 Trigger");
    wait(a2.triggered);
    $display("Event A2 Trigger");
  end
 
 
 
endmodule
*/


module tb;
  
  int data1,data2;
  event done;
  
  int i =0;
  
  ////Generator
  initial begin
    for(i =0; i< 10; i++) begin
      data1 =i; 
      $display("[GEN]:Data Sent : %0d", data1);
      #10;
    end
   -> done;
  end
  
  ///////Driver
  
  initial begin
    forever begin
     #10
     data2 = data1;
      $display("[DRV]:Data RCVD : %0d", data2);
    end
  end
  /////////////
  
  initial begin
    wait(done.triggered);
    $finish();
  end
  
  
  
endmodule

/*[GEN]:Data Sent : 0

[GEN]:Data Sent : 1
[DRV]:Data RCVD : 1

[GEN]:Data Sent : 2
[DRV]:Data RCVD : 2

[GEN]:Data Sent : 3
[DRV]:Data RCVD : 3

[GEN]:Data Sent : 4
[DRV]:Data RCVD : 4

[GEN]:Data Sent : 5
[DRV]:Data RCVD : 5

[GEN]:Data Sent : 6
[DRV]:Data RCVD : 6

[GEN]:Data Sent : 7
[DRV]:Data RCVD : 7

[GEN]:Data Sent : 8
[DRV]:Data RCVD : 8

[GEN]:Data Sent : 9
[DRV]:Data RCVD : 9
[DRV]:Data RCVD : 9
*/