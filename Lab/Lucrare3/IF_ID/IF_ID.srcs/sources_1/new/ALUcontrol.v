`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2020 01:54:55 PM
// Design Name: 
// Module Name: ALUcontrol
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


module ALUcontrol(input [1:0] ALUop,
                  input [6:0] funct7,
                  input [2:0] funct3,
                  output reg [3:0] ALUinput);
                  
    always@(ALUop,funct7,funct3) begin
        casex({ALUop,funct7,funct3})
            12'b00xxxxxxxxxx: ALUinput = 4'b0010; // ld,sd
            12'b100000000000: ALUinput = 4'b0010; // add
            12'b11xxxxxxx000: ALUinput = 4'b0010; // addi
            12'b100100000000: ALUinput = 4'b0110; // sub 
            12'b100000000111: ALUinput = 4'b0000; // and
            12'b100000000110: ALUinput = 4'b0001; // or
            12'b11xxxxxxx110: ALUinput = 4'b0001; // ori
            12'b100000000100: ALUinput = 4'b0011; // xor   
            12'b1x000000x101: ALUinput = 4'b0101; // srl, srli
            12'b1x000000x001: ALUinput = 4'b0100; // sll, slli
            12'b1x010000x101: ALUinput = 4'b1001; // sra, srai
            12'b100000000011: ALUinput = 4'b0111; // sltu
            12'b100000000010: ALUinput = 4'b1000; // slt
            12'b01xxxxxxx010: ALUinput = 4'b1000; // sw
            12'b11xxxxxxx010: ALUinput = 4'b1000; // lw
            12'b01xxxxxxx00x: ALUinput = 4'b0110; // beq, bne
            12'b01xxxxxxx10x: ALUinput = 4'b1000; // blt, bge 
            12'b01xxxxxxx11x: ALUinput = 4'b0111; // bltu, bgeu
        endcase 
    end
               
endmodule
