`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 07:32:30 PM
// Design Name: 
// Module Name: ID_EX_reg
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


module ID_EX_reg(input clk,
                 input reset,
                 input write,
                 input [31:0] IMM_ID,
                 input [31:0] REG_DATA1_ID,
                 input [31:0] REG_DATA2_ID,
                 input [31:0] PC_ID,
                 input [2:0] FUNCT3_ID,
                 input [6:0] FUNCT7_ID,
                 input [6:0] OPCODE_ID,
                 input [4:0] RD_ID,
                 input [4:0] RS1_ID,
                 input [4:0] RS2_ID,
                 
                 // control
                  input RegWrite_ID,
                  input MemtoReg_ID,
                  input MemRead_ID,
                  input MemWrite_ID,
                  input [1:0] ALUop_ID,
                  input ALUSrc_ID,
                  input Branch_ID,
                  
                  // 
                  output reg [31:0] IMM_EX,
                  output reg [31:0] REG_DATA1_EX,
                  output reg [31:0] REG_DATA2_EX,
                  output reg [31:0] PC_EX,
                  output reg [2:0] FUNCT3_EX,
                  output reg [6:0] FUNCT7_EX,
                  output reg [6:0] OPCODE_EX,
                  output reg [4:0] RD_EX,
                  output reg [4:0] RS1_EX,
                  output reg [4:0] RS2_EX,
                 
                 // control
                  output reg RegWrite_EX,
                  output reg MemtoReg_EX,
                  output reg MemRead_EX,
                  output reg MemWrite_EX,
                  output reg [1:0] ALUop_EX,
                  output reg ALUSrc_EX,
                  output reg Branch_EX);
                   
     always@(posedge clk) begin
        if (reset) begin 
             IMM_EX <= 32'b0;
             REG_DATA1_EX <= 0;
             REG_DATA2_EX <= 0;
             PC_EX <= 32'b0;
             FUNCT3_EX <= 0;
             FUNCT7_EX <= 0;
             OPCODE_EX <= 0;
             RD_EX <= 0;
             RS1_EX <= 0;
             RS2_EX <= 0;
             
             // control
             RegWrite_EX <= 0;
             MemtoReg_EX <= 0;
             MemRead_EX <= 0;
             MemWrite_EX <= 0;
             ALUop_EX <= 0;
             ALUSrc_EX <= 0;
             Branch_EX <= 0;
        end 
        else begin 
           if (write)
           begin 
             IMM_EX <= IMM_ID;
             REG_DATA1_EX <= REG_DATA1_ID;
             REG_DATA2_EX <= REG_DATA2_ID;
             PC_EX <= PC_ID;
             FUNCT3_EX <= FUNCT3_ID;
             FUNCT7_EX <= FUNCT7_ID;
             OPCODE_EX <= OPCODE_ID;
             RD_EX <= RD_ID;
             RS1_EX <= RS1_ID;
             RS2_EX <= RS2_ID;
             
             // control
             RegWrite_EX <= RegWrite_ID;
             MemtoReg_EX <= MemtoReg_ID;
             MemRead_EX <= MemRead_ID;
             MemWrite_EX <= MemWrite_ID;
             ALUop_EX <= ALUop_ID;
             ALUSrc_EX <= ALUSrc_ID;
             Branch_EX <= Branch_ID;
           end
        end 
     end
endmodule
