`timescale 1ns / 1ps

module ID(input clk, input [31:0] PC_ID, INSTRUCTION_ID,
          input RegWrite_WB, input [31:0] ALU_DATA_WB,
          input[4:0] RD_WB,
          output [31:0] IMM_ID, REG_DATA1_ID, REG_DATA2_ID,
          output [2:0] FUNCT3_ID,
          output [6:0] FUNCT7_ID,
          output [6:0] OPCODE_ID,
          output [4:0] RD_ID,
          output [4:0] RS1_ID,
          output [4:0] RS2_ID
    );
    /* ce fac cu PC_ID? il propag mai departe */
    /* registers(input clk, reg_write,
                 input [4:0] read_reg1, read_reg2, write_reg,
                 input [31:0] write_data,
                 output [31:0] read_data1, read_data2) */
    registers r1(clk, RegWrite_WB, INSTRUCTION_ID[19:15], INSTRUCTION_ID[24:20], RD_WB, ALU_DATA_WB, REG_DATA1_ID, REG_DATA2_ID);
    
    /* imm_gen(input [31:0] in, output reg [31:0] out */
    imm_gen i1(INSTRUCTION_ID, IMM_ID);
    
    assign FUNCT7_ID = INSTRUCTION_ID[31:25];
    assign RS2_ID = INSTRUCTION_ID[24:20];
    assign RS1_ID = INSTRUCTION_ID[19:15];
    assign FUNCT3_ID = INSTRUCTION_ID[14:12];
    assign RD_ID = INSTRUCTION_ID[11:7];
    assign OPCODE_ID = INSTRUCTION_ID[6:0];
    
endmodule
