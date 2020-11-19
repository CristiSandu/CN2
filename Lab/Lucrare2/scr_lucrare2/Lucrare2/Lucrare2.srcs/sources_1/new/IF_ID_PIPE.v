`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2020 06:59:26 PM
// Design Name: 
// Module Name: IF_ID_PIPE
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


module IF_ID_PIPE(input clk,  input reset, input IF_ID_write, input [31:0] PC_IF, INSTR_IF, 
                output reg [31:0] PC_IF_out, INSTR_IF_out);

   always@(posedge clk) begin
        if (reset == 1) begin
            PC_IF_out = 0;
            INSTR_IF_out = 0;
        end
        else if (IF_ID_write == 1) begin
            PC_IF_out = PC_IF;
            INSTR_IF_out = INSTR_IF;
        end
    end
endmodule
