`timescale 1ns / 1ps

module pipe_reg(input clk,  input reset, input load, input [31:0] PC_IF, INSTR_IF, 
                output reg [31:0] out_ID, out_INSTR
    );
    
    always@(posedge clk) begin
        if (reset == 1) begin
            out_ID = 0;
            out_INSTR = 0;
        end
        else if (load == 1) begin
            out_ID <= PC_IF;
            out_INSTR <= INSTR_IF;
        end
    end
endmodule
