//////////////////////////////////////////////RISC-V_MODULE///////////////////////////////////////////////////
module RISC_V_IF_ID(input clk,   //semnalul de ceas global
                    input reset, //semnalul de reset global
                    
                    //semnale provenite din stagii viitoare
                    //sunt pre-setate pentru aceasta lucrare
                    //vor fi discutate in lucrarile urmatoare
                      output [31:0] PC_EX,
                      output [31:0] ALU_OUT_EX,
                      output [31:0] PC_MEM,
                      output PCSrc,
                      output [31:0] DATA_MEMORY_MEM,
                      output [31:0] ALU_DATA_WB,
                      output [1:0] forwardA, forwardB,
                      output pipeline_stall);
                    
                    //semnale de iesire din ID
                    //vor fi vizualizate pe simulare
                    
                    //semnalele de control generate in ID
//                    output RegWrite_ID,  //semnal pentru scrierea in bancul de registri
//                    output MemtoReg_ID,  //semnal pentru scrierea din memorie in registru
//                    output MemRead_ID,   //semnal pentru citirea din memoria de date
//                    output MemWrite_ID,  //semnal pentru scrierea in memoria de date
//                    output [1:0] ALUop_ID, //codificarea operatiei efectuate de ALU 
//                    output ALUSrc_ID,      //semnal pentru alegerea operanzilor in ALU
//                    output Branch_ID);     //semnal pentru instructiuni de salt
  
  //////////////////////////////////////////IF signals////////////////////////////////////////////////////////
  
    wire [31:0] PC_Branch,  //PC-ul calculat in etapa EX pentru instructiunile de salt
    wire [31:0] ALU_DATA_WB,
    wire [31:0] PC_ID;       //adresa PC a instructiunii din etapa ID
    wire [31:0] INSTRUCTION_ID; //instructiunea curenta in etapa ID
    wire [31:0] IMM_ID;         //valoarea calculata
    wire [31:0] REG_DATA1_ID;   //valoarea primului registru sursa citit
    wire [31:0] REG_DATA2_ID;   //valoarea celui de-al doilea registru sursa citit
    
    wire [2:0] FUNCT3_ID;  //funct3 din codificarea instructiunii
    wire [6:0] FUNCT7_ID;  //funct7 din codificarea instructiunii
    wire [6:0] OPCODE_ID;     //opcode-ul instructiunii
    wire [4:0] RD_ID;      //registru destinatie
    wire [4:0] RS1_ID;     //registru sursa1
    wire [4:0] RS2_ID;
  
  wire [31:0] PC_IF;               //current PC
  wire [31:0] INSTRUCTION_IF;
  wire [31:0] IMM_EX;
  wire [31:0] REG_DATA1_EX,REG_DATA2_EX;
  wire [2:0] FUNCT3_EX;
  wire [6:0] FUNCT7_EX;
  wire [6:0] OPCODE_EX;
  wire [4:0] RD_EX;
  wire [4:0] RS1_EX;
  wire [4:0] RS2_EX;
  wire RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX;
  wire [1:0] ALUop_EX;
  wire ALUSrc_EX;
  wire Branch_EX;
  wire ZERO_EX;
  wire [31:0] ALU_OUT_EX;
  wire [31:0] PC_Branch_EX;
  wire [31:0] REG_DATA2_EX_FINAL;
  wire [1:0] forwardA,forwardB;
  
  wire ZERO_MEM;
  wire [31:0] ALU_OUT_MEM;
  wire [31:0] PC_Branch_MEM;
  wire [31:0] REG_DATA2_MEM_FINAL;
  wire [4:0] RD_MEM;
  wire RegWrite_MEM;
  wire MemtoReg_MEM;
  wire MemRead_MEM;
  wire MemWrite_MEM;
  wire [1:0] ALUop_MEM;
  wire ALUSrc_MEM;
  wire Branch_MEM;
  
  wire [31:0] read_data_data_mem;
  wire PCSrc;
  
  wire [31:0] read_data_WB;
  wire [31:0] address_WB;
  wire [4:0] RD_WB;
  wire RegWrite_WB;
  wire MemtoReg_WB;
  
  wire RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID;
  wire [1:0] ALUop_ID;
  wire ALUSrc_ID;
  wire Branch_ID;
  wire PC_write, control_sel,IF_ID_write;
 
 /////////////////////////////////////IF Module/////////////////////////////////////
 IF instruction_fetch(clk, reset, 
                      PCSrc, PC_write,
                      PC_Branch,
                      PC_IF,INSTRUCTION_IF);
  
  
 //////////////////////////////////////pipeline registers////////////////////////////////////////////////////
 IF_ID_reg IF_ID_REGISTER(clk,reset,
                          IF_ID_write,
                          PC_IF,INSTRUCTION_IF,
                          PC_ID,INSTRUCTION_ID);
  
  
 ////////////////////////////////////////ID Module//////////////////////////////////
 ID instruction_decode(clk,
                       PC_ID,INSTRUCTION_ID,
                       RegWrite_WB, 
                       ALU_DATA_WB,
                       RD_WB,
                       IMM_ID,
                       REG_DATA1_ID,REG_DATA2_ID,
                       FUNCT3_ID,
                       FUNCT7_ID,
                       OPCODE_ID,
                       RD_ID,
                       RS1_ID,
                       RS2_ID,
                      );
 
 
 
 control_path CONTROL_PATH_MODULE(OPCODE_ID,control_sel,     
                                   Branch_ID,MemRead_ID,MemtoReg_ID,
                                   ALUop_ID,MemWrite_ID,ALUSrc_ID,RegWrite_ID);
                       
 //////////////////////////////////////pipeline registers////////////////////////////////////////////////////
ID_EX_reg pipe2( clk,
                 reset,
                 1'b1,
                 IMM_ID,
                 REG_DATA1_ID,
                 REG_DATA2_ID,
                 PC_ID,
                 FUNCT3_ID,
                 FUNCT7_ID,
                 OPCODE_ID,
                 RD_ID,
                 RS1_ID,
                 RS2_ID,
                 
                 // control
                 RegWrite_ID,
                 MemtoReg_ID,
                 MemRead_ID,
                 MemWrite_ID,
                 ALUop_ID,
                 ALUSrc_ID,
                 Branch_ID,
                  
                  // 
                 IMM_EX,
                 REG_DATA1_EX,
                 REG_DATA2_EX,
                 PC_EX,
                 FUNCT3_EX,
                 FUNCT7_EX,
                 OPCODE_EX,
                 RD_EX,
                 RS1_EX,
                 RS2_EX,
                 
                 // control
                  RegWrite_EX,
                  MemtoReg_EX,
                  MemRead_EX,
                  MemWrite_EX,
                  ALUop_EX,
                  ALUSrc_EX,
                  Branch_EX);
  ////////////////////////////////////////EX Module//////////////////////////////////  
  EX ex_mod(IMM_EX,         
          REG_DATA1_EX,
          REG_DATA2_EX,
          PC_EX,
          FUNCT3_EX,
          FUNCT7_EX,
          RD_EX,
          RS1_EX,
          RS2_EX,
          RegWrite_EX,
          MemtoReg_EX,
          MemRead_EX,
          MemWrite_EX,
          ALUop_EX,
          ALUSrc_EX,
          Branch_EX,
          forwardA,forwardB,
          
          ALU_DATA_WB,
          ALU_OUT_MEM,
          
          ZERO_EX,
          ALU_OUT_EX,
          PC_Branch_EX,
          REG_DATA2_EX_FINAL);
          
 EX_MEM pipe3(clk,
              reset,
              1'b1,
              
              ZERO_EX,
              ALU_OUT_EX,
              PC_Branch_EX,
              REG_DATA2_EX_FINAL,
              RD_EX,
              RegWrite_EX,
              MemtoReg_EX,
              MemRead_EX,
              MemWrite_EX,
              ALUop_EX,
              ALUSrc_EX,
              Branch_EX,
              
             ZERO_MEM,
             ALU_OUT_MEM,
             PC_Branch_MEM,
             REG_DATA2_MEM_FINAL,
             RD_MEM,
             RegWrite_MEM,
             MemtoReg_MEM,
             MemRead_MEM,
             MemWrite_MEM,
             ALUop_MEM,
             ALUSrc_MEM,
             Branch_MEM);
             
 data_memory d_mem(clk,       
                   MemRead_MEM,
                   MemWrite_MEM,
                   ALU_OUT_MEM,
                   REG_DATA2_EX_FINAL,
                   read_data_data_mem);        
  
  assign PCSrc = ZERO_MEM & PC_Branch_MEM;
  
  
  MEM_WB pipe4(clk,
               reset,
               1'b1,
                      
               read_data_data_mem,
               ALU_OUT_MEM,
               RD_MEM,
               RegWrite_MEM,
               MemtoReg_MEM,
                     
               read_data_WB,
               address_WB,
               RD_WB,
               RegWrite_WB,
               MemtoReg_WB);
  
 forwarding(RS1_EX,
            RS2_EX,
            RD_MEM,
            RD_WB,
            RegWrite_EX,
            RegWrite_WB,
            forwardA,forwardB);
            
 hazard_detection haz_det(RD_ID,
                        RS1_ID,
                        RS2_ID,
                        MemRead_EX,
                        PC_write,
                        IF_ID_write,
                        control_sel);                                              
endmodule
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
