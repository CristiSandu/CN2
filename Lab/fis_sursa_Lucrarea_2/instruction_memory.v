`timescale 1ns / 1ps

module instruction_memory(input [9:0] address, output reg[31:0] instruction
    );
    reg [31:0] memory[0:1023];
    initial begin
        $readmemh("code.mem", memory);
    end
    
    always@(address) begin
         instruction = memory[address];
    end
endmodule
