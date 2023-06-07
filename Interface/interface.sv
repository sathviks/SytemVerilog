/*      Interface       */

/*

=> An interface is a bundle of signals or nets through which a testbench communicates with a design.


Advantages of using interface over the traditional connection:

+   Allows the number of signals to be grouped together and represented as a single port. 
+   Interface declaration is made once and the handle is passed across the modules/components.
+   Same interface can be reused for different projects.
+    Addition and deletion of signals is easy.

*/



/////////////Design Code

module and4 (
  input [3:0] a,
  input [3:0] b,
  output [3:0] y
 
);
 assign y = a & b; 
endmodule


////////////////////Interface and TB

interface and_if;
  logic [3:0] a;
  logic [3:0] b;
  logic [3:0] y;
  endinterface
 
module tb;
  and_if aif(); //there is no constractor for interface
  and4 dut (.a(aif.a), .b(aif.b), .y(aif.y));
  
  initial begin
    aif.a = 4'b0100;
    aif.b = 4'b1100;
    #10;
    $display("a : %b , b : %b and y : %b",aif.a, aif.b, aif.y );
  end