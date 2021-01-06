`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 05:02:13 PM
// Design Name: 
// Module Name: mux4_1
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


module mux4_1(
        input [31:0] in1,
        input [31:0] in2,
        input [31:0] in3,
        input [31:0] in4,
        input [1:0] select,
        output reg [31:0] out
    );
    /*
    assign out = (~select[0] & ~select[1] & in1) | (~select[0] & select[1] & in2) | 
                 (select[0] & ~select[1] & in3) | (select[0] & select[1] & in4);*/
 always@(in1,in2,in3,in4,select) begin
    case(select)
      2'b00: out = in1;
      2'b01: out = in2;
      2'b10: out = in3;
      2'b11: out = in4;
    endcase
  end
endmodule
