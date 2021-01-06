`timescale 1ns / 1ps

module mux2_1(input [31:0] ina, inb, input sel, output [31:0] out
    );
    reg [31:0] aux;
    always@(ina, inb, sel) begin
        aux = (sel == 0) ? ina : inb;
    end
    assign out = aux;
endmodule