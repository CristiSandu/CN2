////////////////////////////////////////CONTROL_PATH_MODULE///////////////////////////////////////////////////      
module control_path(opcode,
                    control_sel,
                    Branch,
                    MemRead,
                    MemtoReg,
                    ALUop,
                    MemWrite,
                    ALUSrc,
                    RegWrite);
  
  input [6:0] opcode;
  input control_sel;
  output reg MemRead,MemtoReg,MemWrite,RegWrite,Branch,ALUSrc;
  output reg [1:0] ALUop;
  
  always@(opcode,control_sel) begin
    casex({control_sel,opcode})
      8'b1xxxxxxx: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00000000;
      8'b00000000: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00000000; //nop from ISA
      8'b00000011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b11110000; //lw
      8'b00100011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b10001000; //sw
      8'b00110011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00100010; //R32-format
      8'b00010011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b10100011; 
      8'b01100011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00000101; //branch instructions
      default {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00000000;
    endcase
  end

endmodule
