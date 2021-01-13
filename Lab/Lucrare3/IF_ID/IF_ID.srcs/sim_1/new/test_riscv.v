///////////////////////////////////////TESTBENCH//////////////////////////////////////////////////////////////////
module RISC_V_TB;
  reg clk,reset;
  
  wire [31:0] PC_EX_out;
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
       
    #10 reset=1'b0;
    #200 $finish;
  end
endmodule