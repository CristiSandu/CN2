`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 05:33:01 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(input clk,       
                   input mem_read,
                   input mem_write,
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data);
    reg [31:0] memData [0:1023];
    integer i;
    
    initial begin
        for (i = 0; i< 1024; i = i + 1) begin 
            memData[i] = 32'b0; 
        end
    end 
     
    always@(posedge clk) begin
        if(mem_write)
          memData[address[11:2]] <= write_data;
        
        if (mem_read) 
          read_data <= memData[address[11:2]];
        else 
          read_data <= read_data;     
    end
    
endmodule
