`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 03:27:03 PM
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(
input [9:0] address,
output reg [31:0] instruction
    );
    
    reg [31:0] regmem [0:6] ;
    initial begin
        $display("Loading rom.");
        $readmemh("code.mem", regmem);
    end
    
    always @(*)
    begin 
        case (address)
            0: instruction = regmem[0];
            1: instruction = regmem[1];
            2: instruction = regmem[2];
            3: instruction = regmem[3];
            4: instruction = regmem[4];
            5: instruction = regmem[5];
            6: instruction = regmem[6];            
            default : instruction = regmem[0];
        endcase
    end
    
endmodule
