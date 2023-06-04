//////////////////////Design

module add
  (
    input [3:0] a,b,
    output reg [4:0] sum,
    input clk
  );
  
  
  always@(posedge clk)
    begin
      sum <= a + b;
    end
   
   
endmodule


/////////////////////////Testbench Code



interface add_if;
  logic [3:0] a;
  logic [3:0] b;
  logic [4:0] sum;
  logic clk;
endinterface


class driver;
  
  virtual add_if aif;
  
  task run();
    forever begin
      @(posedge aif.clk);  
      aif.a <= 2;
      aif.b <= 3;
      $display("[DRV] : Interface Trigger");
    end
  endtask
  
  
endclass



module tb;
  
 add_if aif();
  driver drv;
  
  add dut (aif.a, aif.b, aif.sum, aif.clk );


  initial begin
    aif.clk <= 0;
  end
  
  always #10 aif.clk <= ~aif.clk;

   initial begin
     drv = new();
     drv.aif = aif;
     drv.run();
     
   end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;  
    #100;
    $finish();
  end
  
endmodule