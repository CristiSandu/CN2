`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2020 04:04:33 PM
// Design Name: 
// Module Name: registers
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


module registers(input clk, reg_write,
                 input [4:0] read_reg1, read_reg2, write_reg,
                 input [31:0] write_data,
                 output [31:0] read_data1, read_data2);
    reg [31:0] x[31:0];
    reg [31:0] out1,out2;
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)begin
            x[i] = i;
        end
    end
    
    always@(read_reg1) begin 
        out1 = x[read_reg1];
    end
        
    always@(read_reg2) begin 
        out2 = x[read_reg2];
    end
    
    always@(posedge clk)
    begin 
        if(reg_write == 1) begin
            x[write_reg] = write_data;
        end 
    end 
    
    assign read_data1 = out1;
    assign read_data2 = out2;

    
endmodule
