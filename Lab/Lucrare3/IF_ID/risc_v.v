//////////////////////////////////////////////RISC-V_MODULE///////////////////////////////////////////////////
module RISC_V(clk,reset);
  
  input clk,reset;
  
  //////////////////////////////////////////IF signals////////////////////////////////////////////////////////
  wire [31:0] PC_IF;               //current PC
  wire [31:0] PC_4_IF;             //PC+4 in IF stage
  wire [31:0] PC_MUX;
  wire [31:0] INSTRUCTION_IF;
  wire [9:0] instruction_address = PC_IF[11:2];
  
  //////////////////////////////////////////ID signals////////////////////////////////////////////////////////
  wire [31:0] PC_ID;
  wire [31:0] INSTRUCTION_ID;
  wire [31:0] IMM_ID;
  wire [31:0] REG_DATA1_ID,REG_DATA2_ID;
  wire RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID;
  wire [1:0] ALUop_ID;
  wire ALUSrc_ID;
  wire Branch_ID; 
  wire pipeline_stall;
  
  wire [2:0] FUNCT3_ID; assign FUNCT3_ID = INSTRUCTION_ID[14:12];
  wire [6:0] FUNCT7_ID; assign FUNCT7_ID = INSTRUCTION_ID[31:25];
  wire [6:0] OPCODE; assign OPCODE = INSTRUCTION_ID[6:0];
  wire [4:0] RD_ID; assign RD_ID = INSTRUCTION_ID[11:7];
  wire [4:0] RS1_ID; assign RS1_ID = INSTRUCTION_ID[19:15];
  wire [4:0] RS2_ID; assign RS2_ID = INSTRUCTION_ID[24:20];
  wire IF_ID_write;
  
  //////////////////////////////////////////EX signals////////////////////////////////////////////////////////
  wire [31:0] PC_EX,PC_Branch;
  wire [31:0] IMM_EX;
  wire [31:0] REG_DATA1_EX,REG_DATA2_EX;
  wire RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX;
  wire Branch_EX;
  wire [1:0] ALUop_EX;
  wire ALUSrc_EX;
  wire [2:0] FUNCT3_EX;
  wire [6:0] FUNCT7_EX;
  wire [4:0] RD_EX;
  wire [4:0] RS1_EX;
  wire [4:0] RS2_EX;
  
  wire [31:0] ALU_OUT_EX;
  wire [3:0] ALU_control;
  wire ZERO_EX;
  wire [1:0] forwardA,forwardB;
  wire [31:0] MUX_A_EX,MUX_B_EX;
  wire [31:0] RS2_IMM_EX;
  
  //////////////////////////////////////////MEM signals////////////////////////////////////////////////////////
  wire RegWrite_MEM,MemtoReg_MEM,MemRead_MEM,MemWrite_MEM;
  wire Branch_MEM;
  wire [31:0] PC_MEM;
  wire [31:0] REG_DATA2_MEM;
  wire [4:0] RS2_MEM;
  wire [4:0] RD_MEM;
  wire [31:0] ALU_OUT_MEM;
  wire ZERO_MEM;
  wire [2:0] FUNCT3_MEM;
  
  wire beq; assign beq = ZERO_MEM & (~FUNCT3_MEM[2]) & (~FUNCT3_MEM[1]) & (~FUNCT3_MEM[0]);
  wire bne; assign bne = (~ZERO_MEM) & (~FUNCT3_MEM[2]) & (~FUNCT3_MEM[1]) & FUNCT3_MEM[0];
  wire blt; assign blt = ALU_OUT_MEM[0] & FUNCT3_MEM[2] & (~FUNCT3_MEM[0]);
  wire bge; assign bge = (~ALU_OUT_MEM[0]) & FUNCT3_MEM[2] & FUNCT3_MEM[0];
  
  wire [31:0] DATA_MEMORY_MEM;
  wire forwardC;
  wire [31:0] MUX_C_MEM;
  
  //////////////////////////////////////////WB signals////////////////////////////////////////////////////////
  wire RegWrite_WB,MemtoReg_WB;
  wire [31:0] DATA_MEMORY_WB;
  wire [31:0] ALU_OUT_WB;
  wire [31:0] ALU_DATA_WB;
  wire [4:0] RD_WB;
  
  
  //////////////////////////////////////pipeline registers////////////////////////////////////////////////////
  IF_ID_reg IF_ID_REGISTER(clk,reset,
                           IF_ID_write,
                           PC_IF,INSTRUCTION_IF,
                           PC_ID,INSTRUCTION_ID);
  
  ID_EX_reg ID_EX_REGISTER(clk,reset,1'b1,
                           RegWrite_ID,MemtoReg_ID,MemRead_ID,MemWrite_ID,ALUSrc_ID,Branch_ID,ALUop_ID,
                           PC_ID,REG_DATA1_ID,REG_DATA2_ID,IMM_ID,
                           FUNCT7_ID,FUNCT3_ID,
                           RS1_ID,RS2_ID,RD_ID,
                                 
                           RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX,ALUSrc_EX,Branch_EX,ALUop_EX,
                           PC_EX,REG_DATA1_EX,REG_DATA2_EX,IMM_EX,
                           FUNCT7_EX,FUNCT3_EX,
                           RS1_EX,RS2_EX,RD_EX);
  
  EX_MEM_reg EX_MEM_REGISTER(clk,reset,1'b1,
                             RegWrite_EX,MemtoReg_EX,MemRead_EX,MemWrite_EX,Branch_EX,
                             PC_Branch,FUNCT3_EX,
                             ALU_OUT_EX,ZERO_EX,
                             MUX_B_EX,
                             RS2_EX,RD_EX,
                                  
                             RegWrite_MEM,MemtoReg_MEM,MemRead_MEM,MemWrite_MEM,Branch_MEM,
                             PC_MEM,FUNCT3_MEM,
                             ALU_OUT_MEM,ZERO_MEM,
                             REG_DATA2_MEM,
                             RS2_MEM,RD_MEM);
  
  MEM_WB_reg MEM_WB_REGISTER(clk,reset,1'b1,
                             RegWrite_MEM,MemtoReg_MEM,
                             DATA_MEMORY_MEM,
                             ALU_OUT_MEM,
                             RD_MEM,
                                  
                             RegWrite_WB,MemtoReg_WB,
                             DATA_MEMORY_WB,
                             ALU_OUT_WB,
                             RD_WB);
                                         
  
  ///////////////////////////////////////////IF data path/////////////////////////////////////////////////////////
  
  PC PC_MODULE(clk,reset,PC_write,PC_MUX,PC_IF); //current PC
  
  instruction_memory INSTRUCTION_MEMORY_MODULE(instruction_address,INSTRUCTION_IF);
  
  adder ADDER_PC_4_IF(PC_IF,32'b0100,PC_4_IF);  //PC+4
  
  mux2_1 MUX_PC(PC_4_IF,                 //PC+4
                PC_MEM,           //selction between pc from branch predictor or pc from EX stage
                (Branch_MEM & (beq|bne|blt|bge)),              //select if we take or not the branch(if there is a branch instruction)
                PC_MUX); 
  
  ///////////////////////////////////////////ID data path/////////////////////////////////////////////////////////
  
  control_path CONTROL_PATH_MODULE(OPCODE,         
                                   pipeline_stall, //hazard detection signal 
                                   Branch_ID,MemRead_ID,MemtoReg_ID,
                                   ALUop_ID,MemWrite_ID,ALUSrc_ID,RegWrite_ID);
  
  registers REGISTER_FILE_MODULE(clk,RegWrite_WB, 
                                 RS1_ID,    
                                 RS2_ID,    
                                 RD_WB,     
                                 ALU_DATA_WB,
                                 REG_DATA1_ID,REG_DATA2_ID);
  
  imm_gen IMM_GEN_MODULE(INSTRUCTION_ID,IMM_ID);
  
  hazard_detection HAZARD_DETECTION_UNIT(RD_EX,  //ID_EX.rd
                                         RS1_ID, //IF_ID.rs1
                                         RS2_ID, //IF_ID.rs2
                                         MemRead_EX,   //ID_EX.MemRead
                                         PC_write,IF_ID_write,
                                         pipeline_stall);
                                         
                                         
  ///////////////////////////////////////////EX data path/////////////////////////////////////////////////////////                                       
  
  ALU ALU_MODULE(ALU_control,
                 MUX_A_EX,RS2_IMM_EX,
                 ZERO_EX,ALU_OUT_EX);
  
  ALUcontrol ALU_CONTROL_MODULE(ALUop_EX,    //ALUop
                               FUNCT7_EX,    //funct7
                               FUNCT3_EX,    //funct3
                               ALU_control);
  
  mux2_1 MUX_RS2_IMM(MUX_B_EX,     //rs2
                    IMM_EX,        //imm
                    ALUSrc_EX,     //ALUSrc
                    RS2_IMM_EX);
                    
  adder ADDER_IMM_EX(PC_EX,      //PC
                     IMM_EX<<1, //imm<<1
                     PC_Branch);
                    
                  
  forwarding FORWARDING_UNIT(RS1_EX, //rs1
                            RS2_EX,  //rs2
                            RD_MEM,     //ex_mem_rd
                            RD_WB,     //mem_wb_rd
                            RegWrite_MEM,     //ex_mem_regwrite
                            RegWrite_WB,     //mem_wb_regwrite
                            forwardA,forwardB);
  
  mux4_1 MUX_FORWARD_A(REG_DATA1_EX,   //ID_EX source
                      ALU_DATA_WB, //MEM_WB source
                      ALU_OUT_MEM,   //EX_MEM source
                      32'b0,            //not used
                      forwardA,MUX_A_EX);
                      
  mux4_1 MUX_FORWARD_B(REG_DATA2_EX,    //ID_EX source
                      ALU_DATA_WB, //MEM_WB source
                      ALU_OUT_MEM,   //EX_MEM source
                      32'b0,            //not used
                      forwardB,MUX_B_EX);
                      
                      
                      
  ///////////////////////////////////////////MEM data path/////////////////////////////////////////////////////////
  data_memory DATA_MEMORY_MODULE(clk,
                                 MemRead_MEM,      //MemRead
                                 MemWrite_MEM,     //MemWrite
                                 FUNCT3_MEM,
                                 ALU_OUT_MEM,      //ALU_OUT(address)
                                 MUX_C_MEM,     //rs2(data)
                                 DATA_MEMORY_MEM);
  
  load_store_forwarding LD_SD_FORWARDING(RS2_MEM,
                                         RD_WB,
                                         MemWrite_MEM,
                                         MemtoReg_WB,
                                         forwardC);
                                         
  mux2_1 MUX_FORWARD_C(REG_DATA2_MEM,
                       DATA_MEMORY_WB,
                       forwardC,
                       MUX_C_MEM);
                                                  
  ///////////////////////////////////////////MEM data path/////////////////////////////////////////////////////////
  
  mux2_1 MUX_ALU_DATA(ALU_OUT_WB,   //ALU_out result
                      DATA_MEMORY_WB, //Data_memory_out 
                      MemtoReg_WB,    //MemtoReg
                      ALU_DATA_WB);   
                                                                   
endmodule
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////TESTBENCH//////////////////////////////////////////////////////////////////
module RISC_V_TB;
  reg clk,reset;
  RISC_V RV(clk,reset);
  
  always #5 clk=~clk;
  initial begin
    #0 clk=1'b0;
       reset=1'b1;
    #10 reset=1'b0;
    #1000 $finish;
  end
endmodule
