///////////////////////////////////////TESTBENCH//////////////////////////////////////////////////////////////////
module RISC_V_TB;
  reg clk,reset;
  /*reg IF_ID_write;
  reg PCSrc,PC_write;
  reg [31:0] PC_Branch;
  reg RegWrite_WB; 
  reg [31:0] ALU_DATA_WB;
  reg [4:0] RD_WB;
  wire [31:0] PC_ID;
  wire [31:0] INSTRUCTION_ID;
  wire [31:0] IMM_ID;
  wire [31:0] REG_DATA1_ID,REG_DATA2_ID;
  wire [2:0] FUNCT3_ID;
  wire [6:0] FUNCT7_ID;
  wire [6:0] OPCODE_ID;
  wire [4:0] RD_ID;
  wire [4:0] RS1_ID;
  wire [4:0] RS2_ID;*/
  
  
  wire [31:0] PC_EX_out,PC_ID;
  wire [31:0] ALU_OUT_EX_out;
  wire [31:0] PC_MEM_out;
  wire PCSrc_out;
  wire [31:0] DATA_MEMORY_MEM_out;
  wire [31:0] ALU_DATA_WB_out;
  wire [1:0] forwardA_out, forwardB_out;
  wire pipeline_stall_out;
  
  RISC_V_IF_ID procesor(clk,reset,
                        
                        PC_EX_out,
                        ALU_OUT_EX_out,
                        PC_MEM_out,
                        PCSrc_out,
                        DATA_MEMORY_MEM_out,
                        ALU_DATA_WB_out,
                        forwardA_out, forwardB_out,
                        pipeline_stall_out);    
    
  always #5 clk=~clk;
  
  initial begin
    #0 clk=1'b0;
       reset=1'b1;
       
      /* IF_ID_write = 1'b1;      
       PCSrc = 1'b0;
       PC_write = 1'b1;    
       PC_Branch = 32'b0;  
       RegWrite_WB = 1'b0;       
       ALU_DATA_WB = 32'b0;
       RD_WB = 5'b0;    */       
       
    #10 reset=1'b0;
    #200 $finish;
  end
endmodule