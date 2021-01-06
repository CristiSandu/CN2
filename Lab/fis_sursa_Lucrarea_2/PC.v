`timescale 1ns / 1ps

module PC(input clk, res, write, input [31:0] in, output reg [31:0] out
    );
    always@(posedge clk) begin
        if (res == 1)
            out = 31'b0;
        else begin
            if (write == 1) begin
                out = in;
            end
        end
    end
endmodule
