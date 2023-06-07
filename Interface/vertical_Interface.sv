/*      Vertical Interface      */

/*

=>  SystemVerilog interface is static in nature, whereas classes are dynamic in nature. 
    because of this reason, it is not allowed to declare the interface within classes, 
    but it is allowed to refer to or point to the interface. 
    A virtual interface is a variable of an interface type that is used in classes to provide access to the interface signals.

    Virtual interface concept comes into the picture to use signals of interface. 
    It is most often used in classes to provide a connection point to allow classes 
    to access the signals in the interface through the virtual interface.



Syntax:

virtual interface_name instance_name;

*/





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
  
  virtual add_if aif;  //  virtual means interface is declare outside class
  
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
     drv.aif = aif; // connet the interface that you have in class to the interface created in td
     drv.run();
     
   end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;  
    #100;
    $finish();
  end
  
endmodule







