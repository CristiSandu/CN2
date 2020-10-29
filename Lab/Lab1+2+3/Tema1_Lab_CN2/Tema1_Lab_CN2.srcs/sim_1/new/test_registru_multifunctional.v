`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2020 12:15:45 PM
// Design Name: 
// Module Name: test_registru_multifunctional
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_registru_multifunctional;
    reg [3:0] intrare;
    reg clk,rst;
    reg [4:0] intrarile_pe_1_bite;
    
    wire [3:0] out;
    
    
    
    registru_multifunctional reg1( intrare,
    clk,
    rst,
    intrarile_pe_1_bite[4],
    intrarile_pe_1_bite[3],
    intrarile_pe_1_bite[2],
    intrarile_pe_1_bite[1],
    intrarile_pe_1_bite[0],
    out);
  /*
initial begin
    clk = 1'b0;
    rst = 1'b0;
    repeat(4) #10 clk = ~clk;
   
    forever #10 clk = ~clk;
end  */

always #25 clk = ~clk;
    
initial begin 


clk = 0;
    rst = 0;
   intrare = 4'b1010; 
   intrarile_pe_1_bite = 5'b01000;
 
#50
   intrare = 4'b1010; 
   intrarile_pe_1_bite = 5'b00100;
#50 
   intrare = 4'b1010; 
   intrarile_pe_1_bite = 5'b00010;
#50 

      rst = 1'b0;
#50
   intrare = 4'b1010; 
   intrarile_pe_1_bite = 5'b00001;
   
#50 
   intrare = 4'b1101; 
   intrarile_pe_1_bite = 5'b11000;
   rst = 0;
#50 
   intrare = 4'b1111; 
   intrarile_pe_1_bite = 5'b01000;
#50 
   intrare = 4'b1101; 
   intrarile_pe_1_bite = 5'b11010;


end 

endmodule
