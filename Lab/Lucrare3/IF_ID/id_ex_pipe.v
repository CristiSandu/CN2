module ID_EX_reg(clk,reset,write,RegWrite_in,MemtoReg_in,MemRead_in,MemWrite_in,ALUSrc_in,Branch_in,ALUop_in,
                                 pc_in,ALU_A_in,ALU_B_in,imm_in,
                                 funct7_in,funct3_in,
                                 rs1_in,rs2_in,rd_in,
                                 
                                 RegWrite_out,MemtoReg_out,MemRead_out,MemWrite_out,ALUSrc_out,Branch_out,ALUop_out,
                                 pc_out,ALU_A_out,ALU_B_out,imm_out,
                                 funct7_out,funct3_out,
                                 rs1_out,rs2_out,rd_out);
  
  input clk,write,reset;
  input RegWrite_in,MemtoReg_in,MemRead_in,MemWrite_in,Branch_in;
  input [1:0] ALUop_in;
  input ALUSrc_in;
  input [31:0] pc_in,ALU_A_in,ALU_B_in,imm_in;
  input [4:0] rs1_in,rs2_in,rd_in;
  input [2:0] funct3_in;
  input [6:0] funct7_in;

  output reg RegWrite_out,MemtoReg_out,MemRead_out,MemWrite_out,Branch_out;
  output reg [1:0] ALUop_out;
  output reg ALUSrc_out;
  output reg [31:0] pc_out,ALU_A_out,ALU_B_out,imm_out;
  output reg [4:0] rs1_out,rs2_out,rd_out;
  output reg [2:0] funct3_out;
  output reg [6:0] funct7_out;
  
  always@(posedge clk) begin
    if (reset) begin
      RegWrite_out <= 1'b0;
      MemtoReg_out <= 1'b0;
      MemRead_out <= 1'b0;
      MemWrite_out <= 1'b0;
      ALUSrc_out <= 1'b0;
      ALUop_out <= 2'b0;
      Branch_out <= 1'b0;
      pc_out <= 32'b0;
      ALU_A_out <= 32'b0;
      ALU_B_out <= 32'b0;
      imm_out <= 32'b0;
      rs1_out <= 5'b0;
      rs2_out <= 5'b0;
      rd_out <= 5'b0;
      funct3_out <= 3'b0;
      funct7_out <= 7'b0;
    end
    else begin
      if (write) begin
        RegWrite_out <= RegWrite_in;
        MemtoReg_out <= MemtoReg_in;
        MemRead_out <= MemRead_in;
        MemWrite_out <= MemWrite_in;
        ALUSrc_out <= ALUSrc_in;
        ALUop_out <= ALUop_in;
        Branch_out <= Branch_in;
        pc_out <= pc_in;
        ALU_A_out <= ALU_A_in;
        ALU_B_out <= ALU_B_in;
        imm_out <= imm_in;
        rs1_out <= rs1_in;
        rs2_out <= rs2_in;
        rd_out <= rd_in;
        funct3_out <= funct3_in;
        funct7_out <= funct7_in;
      end
    end
  end

endmodule
