`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2020 05:22:25 PM
// Design Name: 
// Module Name: imm_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imm_gen(input [31:0] in, output reg [31:0] out );

integer i;
always@(in)begin
    case (in[6:0])
        7'b1100011:begin //beq, bne, blt, bge ,bltu,bgeu opecode B
                        out[0] = 0;
                        out[4:1] = in[11:8];
                        out[10:5] = in[30:25];
                        out[11] = in[7];
                        for ( i=12; i < 32; i = i +1) begin
                            out[i] = in[31];
                        end
                   end
        7'b0100011:begin //sw opecode S
                        out[0] = in[7];
                        out[4:1] = in[11:8];
                        out[10:5] = in[30:25];
                        for ( i=11; i < 32; i = i +1) begin
                            out[i] = in[31];
                        end
                   end
        7'b0010011:begin //addi,andi,ori,xori,slti,sltiu,srli,srai,slli opecode I
                        out[0] = in[20];
                        out[4:1] = in[24:21];
                        out[10:5] = in[30:25];
                        for ( i=11; i < 32; i = i +1) begin
                            out[i] = in[31];
                        end
                   end
        7'b0000011:begin //lw opecode I
                        out[0] = in[20];
                        out[4:1] = in[24:21];
                        out[10:5] = in[30:25];
                        for ( i=11; i < 32; i = i +1) begin
                            out[i] = in[31];
                        end
                    end
        default: out = 32'b0;  
    endcase
    
end

endmodule
