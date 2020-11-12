`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2020 04:38:12 PM
// Design Name: 
// Module Name: PC
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


module PC(
input clk,res, write,
input [31:0] in,
output reg [31:0] out);

reg [31:0] out ;

always @(posedge clk or res) 
begin

if (res)
    out = 0;
else if (write == 1)
begin
    out = in;
end
    
end

endmodule
