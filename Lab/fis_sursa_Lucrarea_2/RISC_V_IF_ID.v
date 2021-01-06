`timescale 1ns / 1ps

module RISC_V_IF_ID(input clk, // semnal de ceas global
                    input reset, // semnal de reset global
                    
                    // semnale provenite din stagii viitoare
                    // sunt pre-setate pentru aceasta lucrare
                    // vor fi discutate in lucrarile urmatoare
                    input IF_ID_write, // semnal de scriere pentru registrul de pipeline IF_ID
                    input PCSrc, PC_write, // semnale de control pentru PC
                    input [31:0] PC_Branch, // PC-ul calculat in etapa de EX pentru instr de salt
                    input RegWrite_WB, // semnal de activare a scrierii in bancul de registrii
                    input [31:0] ALU_DATA_WB, // rezultatul calculat in ALU
                    input [4:0] RD_WB, // registrul rezultat in care se face scrierea
                    
                    // semnale de iesire din ID
                    // vor fi vizulizate pe simulare
                    output [31:0] PC_ID, // adresa PC a instructiunii din etapa ID
                    output [31:0] INSTRUCTION_ID, // instructiunea curenta in etapa ID
                    output [31:0] IMM_ID, // valoarea calculata
                    output [31:0] REG_DATA1_ID, // valoarea primului registru sursa citit
                    output [31:0] REG_DATA2_ID, // valoarea celui de-al doilea registru sursa citit
                    
                    output [2:0] FUNCT3_ID, // funct3 din codificarea instructiunii
                    output [6:0] FUNCT7_ID, // funct7 din codificarea instructiunii
                    output [6:0] OPCODE_ID, // opcode-ul instructiunii
                    output [4:0] RD_ID, // registrul destinatie
                    output [4:0] RS1_ID, // registrul sursa1
                    output [4:0] RS2_ID // registrul sursa2
    );
    
    wire [31:0] PC_IF, INSTRUCTION_IF;
    
    IF if1(clk, reset, PCSrc, PC_write, PC_Branch, PC_IF, INSTRUCTION_IF);
    
    pipe_reg p1(clk, reset, IF_ID_write, PC_IF, INSTRUCTION_IF, PC_ID, INSTRUCTION_ID);
    
    ID id1(clk, PC_ID, INSTRUCTION_ID, RegWrite_WB, ALU_DATA_WB, RD_WB, IMM_ID, 
        REG_DATA1_ID, REG_DATA2_ID, FUNCT3_ID, FUNCT7_ID, OPCODE_ID, RD_ID, RS1_ID, RS2_ID);
endmodule
