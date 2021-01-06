`timescale 1ns / 1ps

module imm_gen(input [31:0] in, output reg [31:0] out
    );
    /*
    I : addi, andi, ori, xori, sltiu, slti:opcode 0010011
        lw:opcode 0000011
        srli, srai, slli: opcode 0010011 
    S : sw: opcode 0100011
    SB : beq, bne, blt, bge, bltu, bgeu:opcode 1100011
    */
    
    reg [6:0] opcode;
    integer i;
    
    always@(in) begin
        opcode = in[6:0];
        case (opcode)
            7'b0000011:begin //I
                            for (i = 11; i < 32; i = i + 1)
                                out[i] = in[31];
                            out[10:5] = in[30:25];
                            out[4:1] = in[24:21];
                            out[0] = in[20];
                       end
            7'b0010011:begin //I
                            for (i = 11; i < 32; i = i + 1)
                                out[i] = in[31];
                            out[10:5] = in[30:25];
                            out[4:1] = in[24:21];
                            out[0] = in[20];
                       end
            7'b0100011:begin //S
                            for (i = 11; i < 32; i = i + 1)
                                out[i] = in[31];
                            out[10:5] = in[30:25];
                            out[4:1] = in[11:8];
                            out[0] = in[7];
                       end
            7'b1100011:begin //B
                            for (i = 12; i < 32; i = i + 1)
                                out[i] = in[31];
                            out[11] = in[7];
                            out[10:5] = in[30:25];
                            out[4:1] = in[11:8];
                            out[0] = 0;
                       end
            default: out = 32'b0;
        endcase
    end
    
endmodule
