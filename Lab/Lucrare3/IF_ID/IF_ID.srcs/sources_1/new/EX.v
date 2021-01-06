`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 03:49:49 PM
// Design Name: 
// Module Name: EX
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


module EX(input [31:0] IMM_EX,         
          input [31:0] REG_DATA1_EX,
          input [31:0] REG_DATA2_EX,
          input [31:0] PC_EX,
          input [2:0] FUNCT3_EX,
          input [6:0] FUNCT7_EX,
          input [4:0] RD_EX,
          input [4:0] RS1_EX,
          input [4:0] RS2_EX,
          input RegWrite_EX,
          input MemtoReg_EX,
          input MemRead_EX,
          input MemWrite_EX,
          input [1:0] ALUop_EX,
          input ALUSrc_EX,
          input Branch_EX,
          input [1:0] forwardA,forwardB,
          
          input [31:0] ALU_DATA_WB,
          input [31:0] ALU_OUT_MEM,
          
          output ZERO_EX,
          output [31:0] ALU_OUT_EX,
          output [31:0] PC_Branch_EX,
          output [31:0] REG_DATA2_EX_FINAL
          );
          
wire [31:0] OUT_MUX_1, OUT_MUX_2, OUT_MUX_3;
wire [3:0] ALU_cont;

        always @* begin
                $display("Inainte de mux");
                $display("%h",REG_DATA1_EX);
                $display("%h",REG_DATA2_EX);
                $display("%h",ALU_DATA_WB);
                $display("%h",ALU_OUT_MEM);
        end
          mux4_1 mux1(REG_DATA1_EX,
                      ALU_DATA_WB, 
                      ALU_OUT_MEM,
                      0,
                      forwardA,
                      OUT_MUX_1);
                      
          mux4_1 mux2(REG_DATA2_EX,
                      ALU_DATA_WB, 
                      ALU_OUT_MEM,
                      0,
                      forwardB,
                      OUT_MUX_2);
         always @* begin
                  $display("Dupa 4_1 Inainte de mux2_1");
                $display("%h",OUT_MUX_2);
                $display("%h",IMM_EX);
                $display("%b",ALUSrc_EX);
                $display("%h",OUT_MUX_3);
        end

         mux2_1 mux3_2_1(OUT_MUX_2,
                         IMM_EX,        
                         ALUSrc_EX,
                         OUT_MUX_3);

         ALUcontrol ALU_controlunit(ALUop_EX,    
                                   FUNCT7_EX,    
                                   FUNCT3_EX,
                                   ALU_cont);
         ALU alu_cot_mod(ALU_cont,
                         OUT_MUX_1,
                         OUT_MUX_3,
                         ZERO_EX,
                         ALU_OUT_EX);

         always @* begin
                $display("Dupa ALU");

                $display("%h",ALU_cont);
                $display("%h",OUT_MUX_1);
                $display("%b",OUT_MUX_3);
                $display("%h",ALU_OUT_EX);
        end                
                         
         adder add_EX(PC_EX,
                      IMM_EX,
                      PC_Branch_EX);
        
        assign REG_DATA2_EX_FINAL = OUT_MUX_2;
endmodule
