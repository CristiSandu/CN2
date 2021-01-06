`timescale 1ns / 1ps

module IF(input clk, reset, input PCSrc, PC_write,
          input [31:0] PC_Branch, output [31:0] PC_IF, INSTRUCTION_IF
    );
    wire [31:0] out_mux;
    wire [31:0] out_PC;
    wire [31:0] next_PC; 
    wire [31:0] out_im;
    
    mux2_1 m1(next_PC, PC_Branch, PCSrc, out_mux);
    PC pc1(clk, reset, PC_write, out_mux, out_PC);
    adder ad1(out_PC, 32'b00000000000000000000000000000100, next_PC);
    /* ca ai add 4 */
    instruction_memory uut(out_PC[11:2], out_im); 
    
    assign PC_IF = out_PC;
    assign INSTRUCTION_IF = out_im;
endmodule
